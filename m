Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C52ED41D45
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF229893A6;
	Tue, 12 Nov 2024 03:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oys7O9j6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27AC893AB; Tue, 12 Nov 2024 03:11:42 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D87F89380
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 03:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b155cca097so436598985a.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 18:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731377499; x=1731982299; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWcELHs4WrdkPZe6zAgNCAvuD8bVwQIXAFek3/oaQhw=;
 b=Oys7O9j6C94xlybqZWoyVtGBFowb0Ej7SJgrZCoBAV8Rk2kT6WMLSy1U9DZEXXczSu
 vDydPSlL0wke6MlSle5YgcHcPuGypKajyVNbwbluE96b5TdLovbpTAqo40P/ASErj7eS
 2nIXLgZyU6yIoyocYLIwb6zKXpuiICSZxK2X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731377499; x=1731982299;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWcELHs4WrdkPZe6zAgNCAvuD8bVwQIXAFek3/oaQhw=;
 b=MlG55gG9bWbWuhKddaI7MWiEwDUAXsPuga5EPs0WyWdBg6ZrpqNQxAoaHxy6ZvNBAl
 lyQ6m4kymKCpu/IHrda7xGlJlOXvPpm90rAUUcAAvO+b5RlQw9I+oZUZlIABv29cAKZH
 32l4nX3tuJPe68/WeVIkbNbSJNB0lY8wUOUYCmw+/5ulhsCAzQPjSuetRbJ4WssgO/yd
 NtmcHLBEXr7Mi1FhxnkUQZ9RB+RFUNxO/Vwe0iAjss973cHPjBdnBdpT356KDWAUs3sf
 w47Uof09c3vkULugOsvr9yR6LE1EbYk0mniDBlF/fQBOHbrv3rCV/7oyiBL77u0YCFYh
 zuVw==
X-Gm-Message-State: AOJu0Yz26BdAkSLqX6PWwIqMDAeGqK00oKIx0PYNPTB7Fx57+rXrkq2V
 mrN/kYTjiJhxjVSc+yfWUbE1bmwZSfxMS3cdxRRyy/bohk8uQs623jfs5RjYTpCIoo87KFH4avL
 wH84=
X-Google-Smtp-Source: AGHT+IGEr8wT2sexfK83/4jtwzkTr0A7WieBROipgI6bxqRsPpgd1Gj3lfblsRw8lklBA5/ZAQmKDA==
X-Received: by 2002:a05:620a:3948:b0:7a9:a356:a5dd with SMTP id
 af79cd13be357-7b3329329bamr1839864785a.20.1731377499360; 
 Mon, 11 Nov 2024 18:11:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ace7c70sm546902885a.113.2024.11.11.18.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 18:11:38 -0800 (PST)
Date: Mon, 11 Nov 2024 20:11:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241112021135.GX3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9wVK/HKjURB96Ovn"
Content-Disposition: inline
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


--9wVK/HKjURB96Ovn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest Coverity report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Nov 11, 2024 at 10:24=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 514648:  Control flow issues  (MISSING_BREAK)
/tools/imx8image.c: 93 in parse_cfg_cmd()


___________________________________________________________________________=
_____________________________
*** CID 514648:  Control flow issues  (MISSING_BREAK)
/tools/imx8image.c: 93 in parse_cfg_cmd()
87              sector_size =3D get_table_entry_id(imx8image_sector_size,
88                                               "imximage boot option",
89                                               token);
90              if (!strncmp("emmc_fastboot", token, 13))
91                      emmc_fastboot =3D true;
92              break;
>>>     CID 514648:  Control flow issues  (MISSING_BREAK)
>>>     The case for value "CMD_DCD_SKIP" is not terminated by a "break" st=
atement.
93      case CMD_DCD_SKIP:
94              if (!strncmp("true", token, 4))
95                      dcd_skip =3D true;
96      case CMD_FUSE_VERSION:
97              fuse_version =3D (uint8_t)(strtoll(token, NULL, 0) & 0xFF);
98              break;


___________________________________________________________________________=
_____________________________

--=20
Tom

--9wVK/HKjURB96Ovn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyuUwACgkQFHw5/5Y0
tyys3AwAgKGKhmm7m6sUMd5Km1/r/Ziow/PCxneQCZ8KIAflFAJYo/5uECq82hFO
nLbhjD+c623T2nQSB0xjkpwM7hQYK+5DWEInOTs82NiRZFs6OZKUAwukZpUscp6E
Cl2NsikbHdhoxybDdnsR2MJr65IqfChqtLEvmTRaRXvDy+XDD4DbrH/SWDs9zg14
FSZhlmu7+LJDdzK9qoZYYhpcTLAHC5s84uFVMV9+ePjFlvNSl4zEv3U95dl/pCby
YN0U3R7N/ARv8zmFoyOMd+5mxR7JxR9G7RkI6lqK2p445GzKKB0aoJbB0Cuf74BW
FH1Xqa2ca8Ib3AQxFDWgo8yt3B1oOM9uD1Oa7FuTwXDpg/zHTau4BJmXDoUwlPyd
R6ZQRwR/TrwYTLmxV6mfFjkpSitoCvPCSTDiuzdiwbLytl0EUGJ2I1br94d/AAe/
RlYwwLz5yQtj31EHbo1UIZEgus9oIPdLM1WAXwqNOh8fVqZugPvKSeYGuip2qXs6
RxaDf7WN
=VRI6
-----END PGP SIGNATURE-----

--9wVK/HKjURB96Ovn--
