Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C44CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 22:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 652208465A;
	Tue, 12 May 2026 00:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ck4Dw50q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F2B8466E; Tue, 12 May 2026 00:35:54 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12C584659
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dcd89701acso4549775a34.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778538950; x=1779143750; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VXPyh268UdpTICIJxEWBoO1Ye6RRBuYKF/rjyn+GC0c=;
 b=ck4Dw50qL4N8vcdasU+o7YVJEY/exJUUBuPq46Jl6kM8oyCnPhqvoZ4JG36hB3/5UK
 LKUwx1T2fAKwtYoizAnm7nfK5qJpmMP80yDr1uuRP36FwsmffIPssJ9K9Q2Ag6G4uXhS
 suJTO5vzEH+/osW5kNy6bffU/iN7MhEsp2KDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538950; x=1779143750;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VXPyh268UdpTICIJxEWBoO1Ye6RRBuYKF/rjyn+GC0c=;
 b=g1jbCDtU6RVBc3EDmIaT07E9vpu6M2fvph3hlnwO83WyDneTSgAKWBqvMHxxzpEHOH
 im5qtetCy25Mc6pSabX39BE3O82sQDpbVy5jSWEogQ0tqSEmOnIejWtRPvLz3wFGwXwB
 4ZiGTGkZi2YU9p9azveND2N0JHnJ0/RY9b+YURIV+B9KsCK/AEh32U8KdM2obPGsYjN7
 hus3vAtjACzhSx0P/JCdhInG+YypFOId0V0G9kXmRqrIad+gnfD9dhCXflRpcHP3njZw
 Wi1UrWdJdpNCB4z+NAaudRGYbs2luGyK/620iRPwdObjO+jE61bGs/8bc1CI4bwnd6kS
 fizA==
X-Gm-Message-State: AOJu0Yxj3M4QDnjP1s4/3id8IXstcogtEPkyp/XhuqxWPvqUc/rbkBwC
 ke52xQdrBixOh6Ns0+zA8+sWrPB4OK8pnkKtCaVldbWgp66IBdYnDetD5rfGyY6w2EVY5NugW44
 U7N3FaksHCEJI6pg=
X-Gm-Gg: Acq92OGJzQW+R4reykEirjkAzN/guufU5Fer3tDYrpetMFa36P5edOpAU49MRJwX/KE
 o/XIAHIQkasfcGo9c4dyLETyaGT0O4WinAH/sim5NmwCNWui6Sob2tGgb/dyDx3IOli227/5vsk
 TXcPHUlywrWswiuHBVzvgx3UCx3uViqEHDg+Gc5gERVKg85tWpUETekyq784LwQjwLFATA/akJS
 g+I4J6Wxz16KJCz66i1TD8R7Swc9AK0VlmjC2jUy3OETu9ruxPJXr7yZOj5TKIvvpkpxx1OTO4/
 7K6QISH2OIb62RVtv+wBr+ckxYsY1Z8hVctpSPmTdkvDrabaJ3iPRJSTxAjf+xN6bYtGDBHV1MG
 AczBrefkTBdudpP2OpZ0T7vyTsUbKF44j6RidZMgsq3CuzlF+sUqHprxdRPLVyBfb/D5Nai2qxG
 ZhDwW6gXFtDUyIM8MXQ676l7M5S8MZH5TfcRRxS/+dXc/DdJhGb5yV2diW8VxTmJtrX4lYDqdeM
 4+K8gxsrGLuI7hrPxFDLJM/blHWbvjvZLtNg8sOWgNR7PduXtg=
X-Received: by 2002:a05:6830:6b0b:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7e1dee81175mr15681376a34.6.1778538950257; 
 Mon, 11 May 2026 15:35:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be21f6sm7691773a34.2.2026.05.11.15.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:35:49 -0700 (PDT)
Date: Mon, 11 May 2026 16:35:47 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peter Collingbourne <peter@pcc.me.uk>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260511223547.GN1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u9O0i5AQADV8jXsT"
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


--u9O0i5AQADV8jXsT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, May 11, 2026 at 4:22=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 1
   - 4 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 1 of 1 defect(s)

Defect Details

** CID 646039:       Control flow issues  (UNREACHABLE)
/fs/ubifs/ubifs.c: 612           in ubifs_findfile()


___________________________________________________________________________=
__________________
*** CID 646039:         Control flow issues  (UNREACHABLE)
/fs/ubifs/ubifs.c: 612             in ubifs_findfile()
606     		}
607
608     		root_inum =3D inum;
609     		name =3D next;
610     	}
611
>>>     CID 646039:         Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "kfree(buf);".
612     	kfree(buf);
613     	return 0;
614     }
615
616     int ubifs_set_blk_dev(struct blk_desc *rbdd, struct
disk_partition *info)
617     {



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--u9O0i5AQADV8jXsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagJZwAAKCRAr4qD1Cr/k
CtT8AP9R603wH+CDBlFIPsXUgozIjnanYkgC7gY4t3R5fC91mAD/XRjGX+5isfsP
IcHObVEZ5dVtB9RIc5Wt8gUTuPPYgAc=
=av5L
-----END PGP SIGNATURE-----

--u9O0i5AQADV8jXsT--
