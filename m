Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66757CD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD28083E81;
	Tue, 12 May 2026 19:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C6brSuH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8BB83FEC; Tue, 12 May 2026 19:44:45 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EB3836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479e4835e26so3412448b6e.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778607882; x=1779212682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6TBCx0bJ4XGEFQpeAzv/4UCZshrVqclOhhIFqGOzQPw=;
 b=C6brSuH0jt93vao90wTNbQpsVBSJRp/Gdb7JrDZyxx/gBEqggt8WSIoluoru0xdmXS
 INjXdZVLzVjXWeh3tJTAWzuv9LQpGNXlXuHTfPWqQKnrzoJnqjUZ9hP1x7XfGjoSct8J
 luTMBEDTclCjPSKTZbxRYm0Ly7Evp3p/ReG0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607882; x=1779212682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TBCx0bJ4XGEFQpeAzv/4UCZshrVqclOhhIFqGOzQPw=;
 b=hsbGA6FKJ6l8W5EN1RpsyJRFifOl/9sJrS5nebBHj4MeOcmVckNA8ztQ5007hT+8LE
 Qwkhj2b/0HP4MzNQQStyO/zRxP+MKndY7QvOXYAttMYlcDohnntPjmK3V2GUJYTuUGn9
 FOcwOPwcsB7pLO3nHruwDozOnETP0dI1FOq65sNkjlbcq5ftjkKNUfx9+qAZL6X1z3Qm
 Yo1wy2ADrSbm+AP4k9z3yFlj8Sfp28+8Bx+L8eF1EbPo760/vH8DmVMRtcph+sohApHW
 Y3QKW0ByVlhHHDTjmkhoiTLqPZxEoX2MoTIaCbZQXa9jks4YKLpmJdJm9Avp4YY/6USo
 BAVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4U+IkoBhkKqxUdseh5F5umT1rRnvNhJxQLWR7kvu+B61R5Z664c8K5ZaZe/ggzAqv+ShTRjA=@lists.denx.de
X-Gm-Message-State: AOJu0YwNXm+5njP54zcQw3PFHxcNkaHjtAgyN1Hop2YO0e96b8vNQsmB
 YUnv/VJAn2QtuQ9n1T180XpnEhxev9r71VbSDHbJD1wVolCCdl6HMHts4+K8cam0GeI=
X-Gm-Gg: Acq92OFXPZR6LFrV9RhWbTz2mdtKm8r8VJa8/rc0UUWOKRe5U6kFXnXpaVAd8ycSKMK
 RBZNaClBdLtHfUyJSkipZS7zz95N4p3pin2IWvN5IPwk18yl4pY5TPc7J1MgfTqD5a3Z2S2i5j6
 daYFp6b/SkmWNHlEgFV8Nig/225LCNof7xKhniAKJVqRu/nDFepOAmyWkx7pXk3oWNRsoBZnhvu
 pE2bZvLVYAi2Ir41EBahejbdSJG1KJ35NOiT0qnPk7Ad56YkzVqSvzxfhmcOYwvljJxcmOmBlxv
 BZUi1DfndbHy5dGcHkYbLFKZuEM5kUXC4QEycZuRGdNOlJJmC/duCZ8nisiPT0+/yI8BHYP6a66
 3BFHAZtSA7YRq6bQXGtzkJWAiPYz1APXm9eXRzqLhTCyn/LKrneVcTRWLzREOLKm1+IMrU/OCIw
 SXxV5s20rsHmLM1rpi+rcuerXl9YjwQTI5yvY2tXJLO1RwXaQ8A//CrE/SiX9bsnSrTbinKrZGH
 ld5SsUSnDdoyMaQsJzf4mz8QUOclYJ8jW5yNv4GPkbQdBPksV4=
X-Received: by 2002:a05:6808:2395:b0:467:2f84:b0c6 with SMTP id
 5614622812f47-482b290a26cmr50000b6e.8.1778607881984; 
 Tue, 12 May 2026 10:44:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76936220sm22786280b6e.10.2026.05.12.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:44:41 -0700 (PDT)
Date: Tue, 12 May 2026 11:44:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
Message-ID: <20260512174438.GP1858239@bill-the-cat>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
 <177857908918.1655329.7242382998405759036.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w1WZm/LsgEoxG3kI"
Content-Disposition: inline
In-Reply-To: <177857908918.1655329.7242382998405759036.b4-review@b4>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--w1WZm/LsgEoxG3kI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 03:14:49PM +0530, Neha Malcom Francis wrote:
> On Tue, 05 May 2026 18:36:24 +0200, Ernest Van Hoecke <ernestvanhoecke@gm=
ail.com> wrote:
> > arm: dts: k3-am69-aquila: add combined boot firmware image
>=20
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Out of genuine curiosity, the Message-ID here implies "b4 review" was
used here. Is that correct? And how useful did you find it for this
case? Thanks.

--=20
Tom

--w1WZm/LsgEoxG3kI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagNnAgAKCRAr4qD1Cr/k
ChVFAP9s9x4Q+P8hbaUeTh/PO6NWq8SYkoFsnD0w+cuGGh5mRwD/X7T2B44XyEwX
EaozRX9ElERIRbR6N3N/AwF7mi/r2A4=
=19uH
-----END PGP SIGNATURE-----

--w1WZm/LsgEoxG3kI--
