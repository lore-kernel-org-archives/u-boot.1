Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E6C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 22:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995A987FAE;
	Mon,  4 Mar 2024 23:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVDmgVuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB4887EE4; Mon,  4 Mar 2024 23:15:39 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB7287FA4
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 23:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov0322@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412db7067d6so982565e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709590537; x=1710195337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=op4cJ4nmnv5yRhCO3ZaBrz7z1A3lqiZ7P4pqwMOUvJ0=;
 b=fVDmgVuhWx7SuJnIF9dDQw/U6K2vthBABgS13HvCj9Z95lyMarAjK/aBN8UByjmxwz
 WqIfnRRpK28nF0gMYwhAfM14tC6S92jPisy6Or3RR+W4twppkw/rCmEZGJn8X4gynPe+
 0Cmr0uyOdhQDCb1YvMbVJxlZvHmlFetvZL8mONV7NRI6KuPWJev+5IJcG3YUZ/tpk+dH
 0wAo4b1akOJStsBxNAfCoX4y+NLr8KzbTuMiuVdg8apfedQQ418ZTyMXdthOU//BkNkP
 PFE0l9lmTdYuMTNN0Ve7YlTVatrcyHbt+8j2jtGbGL7wWKnEyCY63n/l0jgHQpU48gPq
 KJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709590537; x=1710195337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=op4cJ4nmnv5yRhCO3ZaBrz7z1A3lqiZ7P4pqwMOUvJ0=;
 b=VhNimebSNJzDDHLop+8QrCYSd0heaaDecOC3wwgzsph1H31wzm9jEAUErEcSetjdi7
 7T3rWZaCV0BEoNM3vwg76dnnd9bMz0rqyRm55yAfsbafV2X2EyMMpml3+bxyVNsJlBOM
 fFtgN//qaQ9ncoGQ8PYyZSemOAOU7mRrzv9Jv1RwlLVeccRklyDsSuYOgOj3r5LLXO9z
 XQ+aw3C4ZDxJ/ucb4v5uFZSmVaLw3SNFbUj0J1ycQXuJVecxVeOUU3v1Vgolg3H1FU4c
 HpveRhGsw/gy+y/U8akmpUGorr6Mh00z6koVQq29xNB3Bz8lFWhmUMlIUqklZQx9vP+8
 XHOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt1F7PQbuPj8ms5jf94bcYuNGZ7U4E610Sy620bCsrRV+EJVkXcKcQu9Q0Nn9vIvEwJRRbQ60aK8sBUdykU3vewZs1Ew==
X-Gm-Message-State: AOJu0YzRMU1xHQU+MQKYF//jXZY6qkJaZ1Mp/rWYd4vikJqHGENoLm30
 5vs4r2yOD8UZOw4sDV67OCaflhW7gIpKOSlENEgFdl3qHeSHiydy
X-Google-Smtp-Source: AGHT+IGlM8VeKhDPH+woRnPOb1OXIbE5igqLAzMEE28XhXY82Tm+bv3KQv1mlQ8q1TscZDiTg2QUkw==
X-Received: by 2002:a05:600c:1d85:b0:412:e371:7c2e with SMTP id
 p5-20020a05600c1d8500b00412e3717c2emr2921453wms.1.1709590536975; 
 Mon, 04 Mar 2024 14:15:36 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:f7e0:efec:4145:922])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b00412ebd587ebsm266481wmo.3.2024.03.04.14.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 14:15:36 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: trini@konsulko.com,
	xypron.glpk@gmx.de,
	yanhong.wang@starfivetech.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] doc: board: starfive: Fix paths in the bash block
Date: Mon,  4 Mar 2024 22:15:32 +0000
Message-Id: <20240304221532.368453-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Mar 2024 23:16:10 +0100
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

From the current documentation it is not entirely obvious where to take
some of the u-boot build artifacts in order to flash them to the sd
card. Extend the "Program the SD card" block by providing relative paths
to the jh7110-starfive-visionfive-2.dtb and u-boot-spl.bin.normal.out
files.

Add "$(linux_image_dir)/" prefix to the Image.gz and initramfs.cpio.gz
files in order to provide some information about where they could be
taken from.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 doc/board/starfive/visionfive2.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index abda8ac21b..031d66fbfb 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -103,15 +103,15 @@ Program the SD card
 
 .. code-block:: bash
 
-	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
+	sudo dd if=spl/u-boot-spl.bin.normal.out of=/dev/sdb1
 	sudo dd if=u-boot.itb of=/dev/sdb2
 
 	sudo mount /dev/sdb3 /mnt/
-	sudo cp u-boot-spl.bin.normal.out /mnt/
+	sudo cp spl/u-boot-spl.bin.normal.out /mnt/
 	sudo cp u-boot.itb /mnt/
-	sudo cp Image.gz /mnt/
-	sudo cp initramfs.cpio.gz /mnt/
-	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
+	sudo cp $(linux_image_dir)/Image.gz /mnt/
+	sudo cp $(linux_image_dir)/initramfs.cpio.gz /mnt/
+	sudo cp arch/riscv/dts/jh7110-starfive-visionfive-2.dtb /mnt/
 	sudo umount /mnt
 
 Booting
-- 
2.34.1

