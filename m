Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C50C28B30
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 01:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7A5806D8;
	Tue, 11 Mar 2025 02:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C593gwW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4152A807D9; Tue, 11 Mar 2025 02:49:42 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FCD801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22403cbb47fso93504365ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 18:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741657778; x=1742262578; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NcmSGY93TJIOCChHR0BkeyOeVp8lO8SiRGfG7iDu9wQ=;
 b=C593gwW0Ht4BGk3CRuikEJnmnVMk/l2Q4s9LMdvIewiu+xyBtqDyjU4nHwWD+VIcqv
 CIWyN76YtkvkIKJlstG2R/MkFSYR4nNhFkptvhe/lBOD9qTKTJZ8iukXkf6fAue5vUAT
 3QKIOMUOTptygDaki5RrSX1l4p0g5UUvXku+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741657778; x=1742262578;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NcmSGY93TJIOCChHR0BkeyOeVp8lO8SiRGfG7iDu9wQ=;
 b=BGxWCupDueohy+jKY5SpR0aIxv9OlpXeAkkz5cMU/dk42ojVOqU4rhCwqw+Xgu9KOH
 fRmTVI5NjxRnRK/VimJQEpYNWbQ37ZsXGfSBXrBVeYeQf3RRKDYeS0FkWGvhLgtvGOPu
 ZzTWpIvEbWkC9T8+Op+l9hZMlnf/E7tRa7qhUX1OfRbVPMw1GLMO+77n5hVJyIndPuF8
 OJyzED18IBF5e7eN8ZDFvLB3Aj14XcItivSPT8mLmSjCRsODolIHCpuIaVccjfeKCWO8
 XJeU6711jX0ogO6BmLIN8R7hr5qiqoLbi/msleDGsST18PwoO+RaqZZynfC7KCrqfAAu
 IG2A==
X-Gm-Message-State: AOJu0YwquH0Bt073OkZNy/gkb2WYgUnO3a0IXTlHtooN34KQFiSkrT2+
 Z0pZnpi5RLv6L/Nu2TzGLo9ySNSHV/SyOgNS3w5A8k7C6jXe10/Xub2K191YsN2ssfjpeaB9uur
 A
X-Gm-Gg: ASbGnctN8KEKYbRJQSVk+aQE2shnTpKeWNRXheCzSua2oKruhYGU6aRO+g3kmK9HyXy
 oXqjEOjPgDiU2aJp+Sb12VDXTSXCGKfnrrxtx43f7f4PXXEd0mhmDutf6VVZuwt3BUaXLrDxl+c
 31X1XnDhjZXPwi36QBLHreKPXEExZLsv74jvM6xoaG8Zl4hMhSxYDk25GousVC1eJeSZ0khx7kB
 LsYUyHxWwGVyhgJze4BGt82qrW1f7qwhRxSOeagYR0o2oTrPjKr4Ijy1yxud9fI5GWjX91UVZAD
 PJ0pd6FAfHM33eClPcDzGg71QDQTIchZQX/9B9hYz2ohVMa44omGO1ws
X-Google-Smtp-Source: AGHT+IHyG6HpncheBjNBHG750uoumDTOr3McfmgUpxdE6I311Ih2HD+/Ch3B6TcRIRsPlfeXMb9l4g==
X-Received: by 2002:a17:902:ce0a:b0:220:e338:8d2 with SMTP id
 d9443c01a7336-2242899474amr238530315ad.21.1741657778520; 
 Mon, 10 Mar 2025 18:49:38 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91c5bsm85644235ad.186.2025.03.10.18.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 18:49:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:49:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250311014935.GS2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z5iBe5wnrtHfV9Fn"
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


--Z5iBe5wnrtHfV9Fn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Mar 10, 2025 at 5:43=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 544194:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_net.c: 1084 in efi_net_set_dp()


___________________________________________________________________________=
_____________________________
*** CID 544194:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_net.c: 1084 in efi_net_set_dp()
1078            // If netobj is not started yet, end here.
1079            if (!netobj) {
1080                    goto exit;
1081            }
1082
1083            phandler =3D NULL;
>>>     CID 544194:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "efi_search_protocol" without checking return value (as is
done elsewhere 39 out of 43 times).
1084            efi_search_protocol(&netobj->header, &efi_guid_device_path,
&phandler);
1085
1086            // If the device path protocol is not yet installed,
install it
1087            if (!phandler)
1088                    goto add;
1089


----- End forwarded message -----

--=20
Tom

--Z5iBe5wnrtHfV9Fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPlqwACgkQFHw5/5Y0
tyzEQAwAi+AOju/0hrCsWKuKVD/ALEMqpPs/NmCSqZvRAMidDXmLVp3wG0DO7K/T
dJNYU2J6sokfuA4GLIMOLxZVqKRARC3bs51afdYOvyzBkzAvXFp5/TNRUBy3J+ZZ
2/KhWuaWBchvF4uMOnbsUQnsbC3+CggSpSy++oMSl79vmIxaigixuqT4w68lwehl
qUAhrRbvfFqsKqciUwrB7upZ5iyDuRPBLQ2VyVw5q1iJwtWoiTWmh3ppgk1lSsRs
WSHEeb4HoePRrrxehtFu2XnzQ7thkAcm1XpSGssUuiYyEe31mJ6MldUUI+7rffOp
RCrVymjiq3wkgx7iZeRtyvuM4AHbQl662CTcDSK3WJ0Q1oA+wZCYaLLl7XmrpG5q
OYN13nxeEVssR/MDBoGzUDU4++giboG98LbnmFbPnR98JykIuxIPk2e6iQ9rQ5i8
P3ld8pQYgqELPcIbX2JW947Cmpina8SHkyrOPUB46k2sfHA7bqKxv7/ngPYRvZuc
Q6IGp9Ok
=a9dm
-----END PGP SIGNATURE-----

--Z5iBe5wnrtHfV9Fn--
