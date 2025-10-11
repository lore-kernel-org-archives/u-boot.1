Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6033DCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4909838E7;
	Sat, 11 Oct 2025 20:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZOa0uFdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6915E83948; Sat, 11 Oct 2025 20:06:43 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09439836F0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 20:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7afbcf24c83so901754a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760206000; x=1760810800; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FwuWGpniKxxHfTmmWZmFtaV8TC29gnMn31ZgVkMM218=;
 b=ZOa0uFdPu0RKR59KgOxHOJoR0lrP5sZt+vqztWUTgAdzQMuDRLmLsiKqNt+PYfeF3U
 rP/L1ZwE4d5Jfq9dNvHS5Xw056nJyVYsXLVP87TN8STZINLt7+Of1gZPxPIRMgvuju+3
 nVH1vR7Anp8dWNDMdyQt7itllG3Dphzco7trE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760206000; x=1760810800;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwuWGpniKxxHfTmmWZmFtaV8TC29gnMn31ZgVkMM218=;
 b=DlZ82XqJ2dfLVnMq3VFwhrHFPY0RKOPvnilcLIElb1pifwP/TzOKAAxX311tuAE+Lq
 dCCLwVva3d5oYNTOj2wG81CUpt2lbfnkExHlJi9jgoetnFdfTiHrtgJY3QMsLAxV1XIb
 CVmTQzQCkcVBpt9Ni1BY5kb1aWPmwjbsl0ZUPiyeOKUbqrQISIr2dtncypU4A7cJorAr
 AEhrIRiGEEP50tudaBrFMlgAmjPD5hHA8dRzRUWRstaeOfFOagVa26bVmckSPfvfdRXE
 qHvrTU4zDU35ID3gvAU1NG4RTwOoJv86W+SSn6CmHrL8r5m/pMAkiHV7gu1m5WH47WWh
 rJUg==
X-Gm-Message-State: AOJu0Yy9dW0rUYECweAOyx7FwNpRd+F/1SqPkWZjZ63G0WXawVbuyqNb
 /xtLt7zobxXSsK/jGB2ldnw8MRxE/eK544ivUNfPa7mE7zBRmfkIvYkHmYq0xSKLTXQK+RXut7d
 6x1tzD5c=
X-Gm-Gg: ASbGnctuyoNRUBPuU4XgmWQ4Rh18OWaKvXsK30XRR/vUkHfqfT8xGoqsLDOWgPF4gp0
 Zalag/K9hTGrzaWt7npV7tLs79crWubbjpRyRmUQMsJlQg5GUycxdTNvw/Hc3MimXQGiY9Ak6qc
 nkoVQUFxzGX3dHWpDYex7Uq1yXGTP66wAlHH8m+YtpcEdxEwisbgEPhIOrdAW6pck0nwtHpTlIb
 vumgpnl1Y9wiGNFER+VuS+9Roi6+z8m10F/30LG/0cNf889Ca+4WLIzbJJug4bhQEvWNDiSJ+UD
 6z2hsBOnoxrd/lZ2P9eo7hmio8lftkRBSWKziAwU4nkdIrPGYCGuwN5MBKiL7sDt/hkKyeKvN64
 eDjep5prSnej/OQVovHPJsIb7dlWk7YEHcKtyxLY+XJbfEDAaJIVstSssOExxsxk22l7VV0zeEk
 ERssdI
X-Google-Smtp-Source: AGHT+IFm6pvVfa/iWQ/iMZxyn9uGzV8QClOc+cdijn4ym6EXbLgD5qfHV9o/eZXZeZYzeaNKNWGFGw==
X-Received: by 2002:a05:6808:1591:b0:43f:75f0:3879 with SMTP id
 5614622812f47-4417b2e18c1mr7099943b6e.14.1760205999699; 
 Sat, 11 Oct 2025 11:06:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419893b2f1sm1350422b6e.13.2025.10.11.11.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 11:06:38 -0700 (PDT)
Date: Sat, 11 Oct 2025 12:06:36 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251011180636.GM298503@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+86B7BKGUujrNV6u"
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


--+86B7BKGUujrNV6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think unfortunately the report email for when I merged in -next was
lost somewhere / wasn't sent. I may be able to get the details out the
dashboard.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Fri, Oct 10, 2025 at 7:08=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 1
   - *Defects Shown:* Showing 1 of 1 defect(s)

Defect Details

** CID 537478:       Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/drivers/spi/spi-mem.c: 528           in spi_mem_calc_op_duration()


___________________________________________________________________________=
__________________
*** CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/drivers/spi/spi-mem.c: 528             in spi_mem_calc_op_duration()
522     	ncycles +=3D ((op->addr.nbytes * 8) / op->addr.buswidth) /
(op->addr.dtr ? 2 : 1);
523
524     	/* Dummy bytes are optional for some SPI flash memory operations */
525     	if (op->dummy.nbytes)
526     		ncycles +=3D ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
(op->dummy.dtr ? 2 : 1);
527
>>>     CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "op->data.nbytes * 8U" with type=
 "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, a=
nd then used in a context that expects an expression of type "u64" (64 bits=
, unsigned).
528     	ncycles +=3D ((op->data.nbytes * 8) / op->data.buswidth) /
(op->data.dtr ? 2 : 1);
529
530     	return ncycles;
531     }
532     EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
533

View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--+86B7BKGUujrNV6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOqcrAAKCRAr4qD1Cr/k
CrURAP4rNpMZnPgIW432K1djEgtXCI7JO4dF5/cxRApYTh1wWQEAxIqcO5k1JXZk
NIplo7wqv/RZAjrHSrQ+/JCd2P6NfwQ=
=V1kF
-----END PGP SIGNATURE-----

--+86B7BKGUujrNV6u--
