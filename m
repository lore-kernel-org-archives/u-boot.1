Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171CC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 22:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1942386F67;
	Wed, 22 Nov 2023 23:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvRAOvNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B856187668; Wed, 22 Nov 2023 23:57:16 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48C686EF1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 23:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b2b3da41eso1670915e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700693834; x=1701298634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FXyxUHrEzGu9KThGjWvac3U4T4+a0dB/OP3EKwEhUgs=;
 b=SvRAOvNmybstcStS09RckSPScwIrJemetJCE5L6MewDl+FrWYp/t2g8Xt7vCKm7APD
 yi/wGsw6aCmS/oRWLOCLFNW1/uuer+UQmsXeGyJVjNITjwkjraR+TRD+dFzXRHZTQv1t
 yu6kuRhRV59bxr6j0ff6xHk0/TydhS0gU/H8OavnfEAkFl5VJMxcDsnpVo/Yc15SN5eZ
 CbUZfnSwqPMSsLUInQW1rrQwCXG8P16XYNFLjWZrqNwPkq+rh+r6lVfP7O0yfHzTY1qW
 XfFBAYlofT80FLmSPkr1NnqnroCsio/OAcW51izMbu6zwOrz1UbMm5stjgehOD+CQMkp
 v6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700693834; x=1701298634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXyxUHrEzGu9KThGjWvac3U4T4+a0dB/OP3EKwEhUgs=;
 b=YZ2/9qFyDv2i6BH1dBopZnwoOBYXoy05KXwh81rK8ZebCcAdiR3YFBXYWGn9SIF07S
 zht1L/+ch0zo54cXWtMZySsaU/CR5f8bJtLw2inN3yAQGYsXDnCjMWoXupd+Gzjlk0bJ
 Zm/vNVhAVTMVH05WaSl8Vs3WzlNFTLSCcXbBBODgVNGhRZQdnqI6DMZvw6GLJxak7S5L
 +H3R03NjHjbReSyy9Ruwb8rqt/3BaGAVAt5hHykIHi4KoFCz2Som3WRLy1vo9Ga2nrCz
 XH7DcOcUzf7jn9OizXHIccO0pRTJDiL5jjvbJc7tctVDnHc+zIsI21Zr5NxG57MdDPvn
 IniA==
X-Gm-Message-State: AOJu0YyADpdJc1aYSRHQx//GDwRxN+MGfWbWORM8l7svH/QiHekIQiOi
 LmgoExy/dRgapNdBcwt5S7vT1q4fRPc=
X-Google-Smtp-Source: AGHT+IFkf0RcAOdeKzFYIqOnxROBg2uKGowrcawp5ThgdOXcDWhvL4lkFoGB8nk9jzukRSdpvaBDUA==
X-Received: by 2002:a05:600c:1986:b0:409:6e0e:e948 with SMTP id
 t6-20020a05600c198600b004096e0ee948mr2836873wmq.1.1700693834068; 
 Wed, 22 Nov 2023 14:57:14 -0800 (PST)
Received: from morpheus.home.roving-it.com
 (2.1.9.e.d.3.3.1.6.1.e.d.5.3.a.e.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:ea35:de16:133d:e912])
 by smtp.googlemail.com with ESMTPSA id
 q19-20020a05600c46d300b004064e3b94afsm782749wmo.4.2023.11.22.14.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 14:57:13 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] doc: Remove README.sha1 file
Date: Wed, 22 Nov 2023 22:57:07 +0000
Message-ID: <20231122225711.96464-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The contents of README.sha1 only refer to process around verification
of the pcs440ep board firmware in flash. The device was removed in
commit 242836a893ae ("powerpc: ppc4xx: remove pcs440ep support") in
2015 so this readme isn't really relevant anymore so can be removed.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

With the wide deprecation of sha1 in general we should likely also
review the use of sha1 in U-Boot as a whole and look to move the
remaining users of sha1 to sha2 or sha3 in general.

 doc/README.sha1 | 58 -------------------------------------------------
 1 file changed, 58 deletions(-)
 delete mode 100644 doc/README.sha1

diff --git a/doc/README.sha1 b/doc/README.sha1
deleted file mode 100644
index f178f372643..00000000000
--- a/doc/README.sha1
+++ /dev/null
@@ -1,58 +0,0 @@
-SHA1 usage:
------------
-
-In the U-Boot Image for the pcs440ep board is a SHA1 checksum integrated.
-This SHA1 sum is used, to check, if the U-Boot Image in Flash is not
-corrupted.
-
-The following command is available:
-
-=> help sha1
-sha1 address len [addr]  calculate the SHA1 sum [save at addr]
-     -p calculate the SHA1 sum from the U-Boot image in flash and print
-     -c check the U-Boot image in flash
-
-"sha1 -p"
-	calculates and prints the SHA1 sum, from the Image stored in Flash
-
-"sha1 -c"
-	check, if the SHA1 sum from the Image stored in Flash is correct
-
-
-It is possible to calculate a SHA1 checksum from a memoryrange with:
-
-"sha1 address len"
-
-If you want to store a new Image in Flash for the pcs440ep board,
-which has no SHA1 sum, you can do the following:
-
-a) cp the new Image on a position in RAM (here 0x300000)
-   (for this example we use the Image from Flash, stored at 0xfffa0000 and
-    0x60000 Bytes long)
-
-"cp.b fffa0000 300000 60000"
-
-b) Initialize the SHA1 sum in the Image with 0x00
-   The SHA1 sum is stored in Flash at:
-			   CONFIG_SYS_MONITOR_BASE + CONFIG_SYS_MONITOR_LEN + SHA1_SUM_POS
-   for the pcs440ep Flash:	 0xfffa0000 +	      0x60000 +        -0x20
-			    = 0xffffffe0
-   for the example in RAM:	   0x300000 +	      0x60000 +        -0x20
-			    = 0x35ffe0
-
-   note: a SHA1 checksum is 20 bytes long.
-
-"mw.b 35ffe0 0 14"
-
-c) now calculate the SHA1 sum from the memoryrange and write
-   the calculated checksum at the right place:
-
-"sha1 300000 60000 35ffe0"
-
-Now you have a U-Boot-Image for the pcs440ep board with the correct SHA1 sum.
-
-If you do a "buildman -k pcs440ep" or a "make all" to get the U-Boot image,
-which will be found in ../current/ipam390/ - the correct SHA1 sum will be
-automagically included in the U-Boot image.
-
-Heiko Schocher, 11 Jul 2007
-- 
2.42.0

