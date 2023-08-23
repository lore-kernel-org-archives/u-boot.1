Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0E8C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B36986454;
	Wed, 23 Aug 2023 20:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="enge6Wlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA0B86455; Wed, 23 Aug 2023 20:15:42 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C016786451
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d678b44d1f3so176763276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692814539; x=1693419339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=we6XA6rMkD4EvUXRESuzLTtrkblk0lzFfJXfzHfF25g=;
 b=enge6WlxSTzADFo9jWmQlv6/NqcTVYT1zNgBPk6PEtptcexsSRdGMMIDoA+bIjslsw
 yzUnCHQDsIx/XzwfbTH7+iCxxfX/NLzUXQv9gftd1oeYEnJOSJJZXVLiEaXXsj/Kt40c
 CUyG5D3E9NuovGdPIn7e7Gx75m4MwdnYonvUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692814539; x=1693419339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we6XA6rMkD4EvUXRESuzLTtrkblk0lzFfJXfzHfF25g=;
 b=TKh6hskklBX4PWKLSmf3S5gD6MlUX0Tz4A/h2qy0NFyHF1BZW9ZARBCoodfMxdI/Cq
 I8LmFC9LNLOXx2/pumMnVuN0vnciVmjnnjvJlSXronxIZ7LPBNMcr3MWm0tYXCdp++V/
 fNzUD4PLRttjPb5hXydxtRJNHnPqiX1Rwy8t31jzihjiQR9ZGgIZKzYVBLbPuvxywTJP
 DeY9gUNV3jylD96ilPWwvLp2ozcxXGKq06ETbWvWub9+UjebeSX/ko2dG6sEHauggFEG
 Sfvv+B3d5YBUm8u5iVuhPH/TT86uTPJ68f1LfMNm2kfTqGWWzCH7dAQvgD6JNzjFeL04
 vuIg==
X-Gm-Message-State: AOJu0YzzS+Aa2nN5XI7mzruToD8Fno9e1OETk9nB03KxdO5Mdz3NH09l
 1Huo0WC7epZVLpyrdkuma4Gotg==
X-Google-Smtp-Source: AGHT+IGysXYec8PAc767MRj5bFgCTXGywvNaWeF35gjNCKdBtsk7ovEHxY8Xc1/HDa0MzAU6DsZZyA==
X-Received: by 2002:a25:ae04:0:b0:d0c:7309:87f7 with SMTP id
 a4-20020a25ae04000000b00d0c730987f7mr13655077ybj.10.1692814539377; 
 Wed, 23 Aug 2023 11:15:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 e203-20020a2569d4000000b00d0b0bbe574asm2963267ybc.44.2023.08.23.11.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:15:38 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:15:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/8] cmd: gpt: Remove confusing help text
Message-ID: <20230823181537.GZ3953269@bill-the-cat>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XoOwc7Txt3YwDxD7"
Content-Disposition: inline
In-Reply-To: <20230823164755.2874792-2-JPEWhacker@gmail.com>
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


--XoOwc7Txt3YwDxD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:47:37AM -0600, Joshua Watt wrote:

> This help text appears to be a fragment of the text shown when
> CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XoOwc7Txt3YwDxD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmTMYACgkQFHw5/5Y0
tywMnQv/S3CrhrS6s4NtT6PYdgZUX1TXLA8d7WHbHa/kahbr4j57gPgNRGGXfPIx
UlUKQ4ijQTjclFoksj1o7guR+l20GRPua42bqFXjQBxW4kxsjHfGQNY7aD4ypaQG
RIFXtrOe5ith16ItdZiMsAcIzQvO91acBs4hPK+xIaNS9HJiPx/2qRcSIk3ZN4aY
wlxBYQN5l+DqDI6WQ2BSZXa/vHrBQhcEl2or4YgHhaD6tySAILJ/fIx2uLWxsArV
a/Hw9lwtFv/d19cz8w5hFT+ZcXwaE3mrKrQyRMqsZc/1jEDMSqF9LU69dwDtIfEv
fs/gbOjBTxE5oEt5VA549cujV6P+W8rY8tYRTIRbmSByEomUN08ZKf5MEH5IdoKw
+jIri5rmW9YxtTaMdu8xbHcvrArE1YyT6gJcyQw2OcIBWtC3BfJQmDbeoq6Kwj2S
mNsUibTQxCzCeJiXzNs9yu97s0WD7VcAx4SFxz8PMyOsgy0xiiZfw55RgLmA1Elh
YRmuJMEV
=PQxP
-----END PGP SIGNATURE-----

--XoOwc7Txt3YwDxD7--
