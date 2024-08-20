Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D2C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C6E88D45;
	Tue, 20 Aug 2024 02:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c4lBMZYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C6F88D3C; Tue, 20 Aug 2024 02:29:42 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23AA88CA8
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2689f749702so2760028fac.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113779; x=1724718579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lqOrslEk46p+e8YBFWbRlPH6kFTug9wuNJSc/V/iqag=;
 b=c4lBMZYi5rH2nFlCI8woeUJBXHmAkkwg77AbJK+Ik7zmoqMmaVKUtFGfaUmYNKEzBv
 DqASqaN6QMfWrti2i4OkfUmwqq3bIeKbCcUEMeThiFwT3fLSpfShuDP7nTAX/ub5Pcxp
 FUllTCrS/v/ceceIwOC/7uQnhRmTVR9YIKjOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113779; x=1724718579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqOrslEk46p+e8YBFWbRlPH6kFTug9wuNJSc/V/iqag=;
 b=EXAtolKXAF8esUuAsYdpx9MyOWZJKSMGBySzq3T7kdKc6bC4qgyeaZixEQq2WAL34b
 qvYJ5LCW8U70/V6HLARy9YnwytyT8VexkQIBXIr7geFPx5zRNfXHB+bwgs+sktIQvfRu
 dm7RsSOSWqhZXh1RBXkkrJ046MI3HyRcBBMXWFS42Eq0IU7Q7W4Y8Vq/qNUFDo4ifbFw
 e1I8sXzhJBOZuiAJTzVUJ7O4J3RsvuxCGLfenZwTUJSBDOmS90f7JL9EeIjzbm3nYg3X
 f8/Ti4GbPi+6TlAOqnUZrx8nIwf6gMn2buTsBOgZAXxoE9CtdqtKk7fJ+G3VFmLuhec3
 wW7w==
X-Gm-Message-State: AOJu0Ywnb81uMIm/YJlEhK4nKx5BhHRw79r80RjjSs4inEaZoTdvCRB+
 DCP1Wi5nN3EmETeeVI9flgesIpxxs5c5PIditb4SmtX41+31LJa8LRj3VRKyWkYK2soLu1RBgWl
 J
X-Google-Smtp-Source: AGHT+IEFCObeCubYtBB2A0yR4gAJU/uf5vp+tyASr4w6xAZUle4p2ZMuhvBf4mlGSHMRZrWokcc5PA==
X-Received: by 2002:a05:6871:e282:b0:260:faa1:4453 with SMTP id
 586e51a60fabf-2701c3464d4mr11667168fac.8.1724113779305; 
 Mon, 19 Aug 2024 17:29:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270049bb2ccsm3332702fac.44.2024.08.19.17.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:38 -0700 (PDT)
Date: Mon, 19 Aug 2024 18:29:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240820002935.GL1626301@bill-the-cat>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <172411371943.165086.15363871870866133253.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+qbOedenm697Z4/u"
Content-Disposition: inline
In-Reply-To: <172411371943.165086.15363871870866133253.b4-ty@konsulko.com>
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


--+qbOedenm697Z4/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 06:28:39PM -0600, Tom Rini wrote:
> On Fri, 16 Aug 2024 14:43:49 -0700, Raymond Mao wrote:
>=20
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> >=20
> > Motivations:
> > ------------
> >=20
> > 1. MbedTLS is well maintained with LTS versions.
> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > 3. MbedTLS recently switched license back to GPLv2.
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!

=2E.. I did not, I just forgot to remove this from my b4 list.

--=20
Tom

--+qbOedenm697Z4/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbD42UACgkQFHw5/5Y0
tyx1RAv9H4J66TH2VFEBWReDmAmrTqcJvSacZL4Y572iGcKgJU90i93egUxslShw
RmN8VUiFEF0QDFKu0DD5cCC2TbJb+dFLue/A8XPdjSEiLnM2MV+PDmu1iuXipLN2
VnyHOam1EXDt+IpeWkPf2o00EliyMN8ZNtP5RFriWSPrMfdFVsf6bdKc+ogEPNvv
D0sV6ll4ImwUAtAnJZX1YLBKbGaCReRFsC/XX9GULmMG/e+uJ+SNy8wehWND1mZZ
c0eijMsDnO5FFAI4UzVwLRQk0JwwJf7hr456tAIFJrcHA3+fl5XyyLqBCZb4bwWI
AOb+9PwNTCWjMstG7jpvsksSIyVYgAY46IAJvnPqOOkjoTt9EB/Yx81gQOYE79x/
G24aoyacfBd8CfQO1CmOTYZMSFUfghTxqQKlOxBcLFvE9/eHigh2WvZrcizyIA0D
r3laemZg76JIJYm4lvRRrmJnFX0yqCI3NHPOGwdcb9Fq4ZBXNMYh7VcUWMwIg0nj
DGJkK6e9
=gY5D
-----END PGP SIGNATURE-----

--+qbOedenm697Z4/u--
