Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B3F86F1E;
	Mon, 18 Dec 2023 17:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tOvr8J3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA58786F1E; Mon, 18 Dec 2023 17:26:25 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6743087142
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-59148c1ad35so2524262eaf.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702916781; x=1703521581; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tyj1jIIn7p0bjb5WM/9npQJJgcsXzbstGhKJZmidtyA=;
 b=tOvr8J3xpc4pgXAb38adc2krBDftw5Y8RJGvpqtCKA9P0CeQ1chIYWtoYH/35HWDLg
 xZzPTho+lr2NjNqM7u01fwuFvCOsf93+ks9kucfdacUrA0loKtcooUQ+k6cAcscpV+2f
 a1/d7+QR9bsr/Tve3Ai8q+vpTI2HeLO5b3ifg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702916781; x=1703521581;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tyj1jIIn7p0bjb5WM/9npQJJgcsXzbstGhKJZmidtyA=;
 b=iGrFa6J387Qw50LFJwD/aGIyxb4mU6ERf4XUWFX2c3qXCJVlrEsIyUXAEHwUzpsXkx
 9iABcF+tb1uOj3Hfq0Ng2tzUh7jdswNKDkQamFtVyzfxyw7z/m7sKth6FiranBO5/vZ5
 s+pHp00tdTS4yFI0AazIXVzNJpMGOzPDiTZzmFyZxeVrudyyxSE2fDwBFkpjRYIeRy+G
 DL6Vzgz+xefADCUJlrZvFikjl+Fc7kb4tDpr1JnJeVVWDuNrglOAgjJi7W7gR7bOQLQf
 cGvmfa5P4CG3d7CGHJWyH+tUjtH9I1lhhjdKZnxO0EBbGemJCDxTk1/HmaGN4GHjphUO
 6ztA==
X-Gm-Message-State: AOJu0YwXmRBU7BAMTimCHY1IpNT2GsY/B7TK7OsEVB3hKKF05YTbBSde
 ZU4uic7IZWq1Rg43ShYMps1EKIfjPKdl2/dDrtQ=
X-Google-Smtp-Source: AGHT+IG1xIy9rS0z4heEeGVgKmisKApz7HuXt/4pNRZRkOCYGixRpxCqxYDb03dqgTZKBzn2PMfBdA==
X-Received: by 2002:a05:6358:7e44:b0:170:cc82:db41 with SMTP id
 p4-20020a0563587e4400b00170cc82db41mr17486987rwm.21.1702916780778; 
 Mon, 18 Dec 2023 08:26:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a0cfbc8000000b0067f4886019dsm850257qvp.122.2023.12.18.08.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 08:26:20 -0800 (PST)
Date: Mon, 18 Dec 2023 11:26:18 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>
Subject: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan for
 Das U-Boot]
Message-ID: <20231218162618.GI2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NRh8bxDjWW9YPukQ"
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


--NRh8bxDjWW9YPukQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Dec 18, 2023 at 8:42=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 470930:  Uninitialized variables  (UNINIT)
/boot/bootmeth_efi.c: 465 in distro_efi_boot()


___________________________________________________________________________=
_____________________________
*** CID 470930:  Uninitialized variables  (UNINIT)
/boot/bootmeth_efi.c: 465 in distro_efi_boot()
459              */
460             if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
461                     log_debug("Booting with built-in fdt\n");
462                     snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
463             } else {
464                     log_debug("Booting with external fdt\n");
>>>     CID 470930:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "fdt" when calling "snprintf". [Note: The=
 source code implementation of the function has been overridden by a builti=
n model.]
465                     snprintf(cmd, sizeof(cmd), "bootefi %lx %lx",
kernel, fdt);
466             }
467
468             if (run_command(cmd, 0))
469                     return log_msg_ret("run", -EINVAL);
470


--=20
Tom

--NRh8bxDjWW9YPukQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAcqMACgkQFHw5/5Y0
tyw3QwwAo+sEWZgkwfXEtwAY0iMhMYjQhBG9TusUgwEwoDR0JBLaN+8LlCIe4Uvb
TRY9ZhX+MblhHBEvf6+OU3N/djnc9m0GTFF4Idim54reBAZnikdEqnGQZTH8GCIG
1U1x+Lip4RoYm9Xtj8fZGqI12rZY2H1h/j7GSZhp0Lt764WRVSplO+BR7HZp6Qz4
FFVg8NDAYc7xZjFh/OdnC3SU/P3LJWrKCkfPRgFL0PIw+z2Jc+2cQtl+E35kBRXH
MpjMDI+uXxYiSKt2rrofz7vYyamAuGaFyurWCjXVHvMSDkaQDvkNXEAcFLfy/U+Q
7Ba8YakUOIDYR4Ld3NP6Ble58paakgB04rjveFbBlPYRZ/vmX1aVv9yzKc49dfBX
ek/Y5jkDDP1PTZDlFfX73WCjzHX7TXBxDIOluU38XlpEdSxNQBXRpPuyUUdBYVI6
/a8+zXvxRO5tYpJRwcZGoL82Yn2Y+f2VH/WGgDtr+NVISvJ78Vdl/3XNFa6W91wp
zjtpuWvH
=6jPZ
-----END PGP SIGNATURE-----

--NRh8bxDjWW9YPukQ--
