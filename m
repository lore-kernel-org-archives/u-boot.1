Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CEC5ACB3
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 02:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2568E86FB6;
	Mon, 20 Nov 2023 03:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OezQ97C/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36792874D9; Mon, 20 Nov 2023 03:36:23 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398DF86F6F
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 03:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66d09b6d007so10800726d6.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 18:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700447775; x=1701052575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yvZ9/bWaq3kEJR7ltu8Ht5f5dHO0iVAfaQeN6uBhnG4=;
 b=OezQ97C/QO3h36bt6Z1TcViuRnPoY6VsUnySiV5O6Id0NZtSRR4sC9WTggDMI8/LqZ
 Pf4VtocrcK5d/WyYBmoF32iwH3zCZQeAEwhOoHBQvHKgCMGBR+oig8Mxh+t1OLpToVui
 BKXMKfC7sZKCw5ChlO8iFr42WvNA4geT07txLzszx6pbFr5bko2KdgXiUEpjFOtSexxJ
 HTZwjCsVTVQWa24btcwdVKKDdVniUWHaACybo3WhVncz/kXBzwKXMCnDgAqDn2GFTOI5
 pMcHpjQh64hITAg8xTh1XhpmP5Gmq0g4k22v99GArqn4fGmgn0A4FeqOIpYYP90omksm
 OgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700447775; x=1701052575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yvZ9/bWaq3kEJR7ltu8Ht5f5dHO0iVAfaQeN6uBhnG4=;
 b=VOumxfUfyjss25o60CYqyqTjDLnaf14pJNAmP5pbWfdTRUoAf7tNgOayyVLEg0NT9p
 dAvvKgPmQI8rkZvcLXcXnEkbWz7TLaH5UWuaS5b2HsZZ7RekEKr3akn4zZYxoXtY3zqb
 p7EvFs8PqOIgOP+GFs3DrBh+kqS+GCubsmggph2pc8q3Q7Hjgb4OSfweBDcbQe1NwTdj
 FhAFiSXmHiKgUP9qV1OefhfqiWIyXVzQEwEo7bwbRQFlVkSMQWs+acGJMQTsKDN7JM6v
 /+yJL9RTk+5/S/8lj5Z90NxhMSuoNtV0RE2rfFAzMwZ7hVTa7md3KXijXWB29IUQQEGJ
 FsMw==
X-Gm-Message-State: AOJu0YwU1ux6SaIguM9yPeW1v88a4Nj9950mamn63qKxsOIpJA9hKdlY
 4f9/QrgJwF0oVNCQdb8sKxI=
X-Google-Smtp-Source: AGHT+IHodOUhvMKvQzDJdXm0oIKyK7qeFe4STI1LeUPv7XX0HVQ71V0ISmMy4Z1DRnNHPNE0CdVdcQ==
X-Received: by 2002:a05:6214:20cc:b0:679:d40e:d699 with SMTP id
 12-20020a05621420cc00b00679d40ed699mr3698207qve.6.1700447774926; 
 Sun, 19 Nov 2023 18:36:14 -0800 (PST)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 i19-20020a05620a0a1300b00767d4a3f4d9sm2349204qka.29.2023.11.19.18.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 18:36:14 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: John Clark <inindev@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH] starfive: visionfive2: add device tree overlay support
Date: Mon, 20 Nov 2023 02:35:31 +0000
Message-ID: <20231120023549.13902-1-inindev@gmail.com>
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

device tree overlay support requires fdtoverlay_addr_r to be set

before
~~~~~~
Invalid fdtoverlay_addr_r for loading overlays

after
~~~~~
Retrieving file: /boot/overlay/rtc-ds3231.dtbo

Signed-off-by: John Clark <inindev@gmail.com>
---

 include/configs/starfive-visionfive2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
index ff43113f24..29c74470c7 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -40,6 +40,7 @@
 	"kernel_comp_addr_r=0x88000000\0" \
 	"kernel_comp_size=0x4000000\0" \
 	"fdt_addr_r=0x46000000\0" \
+	"fdtoverlay_addr_r=0x45800000\0" \
 	"scriptaddr=0x43900000\0" \
 	"pxefile_addr_r=0x45900000\0" \
 	"ramdisk_addr_r=0x46100000\0" \
-- 
2.42.0

