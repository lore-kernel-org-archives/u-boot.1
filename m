Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB875E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67F68962E;
	Fri,  6 Dec 2024 14:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZWIxeE6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BA7895F2; Fri,  6 Dec 2024 14:11:28 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCB1895F2
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 14:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so74070939f.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 05:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733490683; x=1734095483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggZiT9aCUMlarsD7cvbxnKda73uyIyI2Mmdn28P6ouM=;
 b=ZWIxeE6jltSbKHdCGaDUXSvzFAoKAVw7p09ECnZxz90dBBNEON8mWaY51cm4RPMtH8
 XpOv5CZialeBOtSVJy4lWylUBsYFxx/yHeZz4n+0LKrssoZQ9QuKyu+5Ekq1wS1WFRya
 Fbcm1MJZFIQrm7CayZxL+0goNwqPtM4E7nMNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733490683; x=1734095483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggZiT9aCUMlarsD7cvbxnKda73uyIyI2Mmdn28P6ouM=;
 b=kZbCcTFDAMsK/vHGfghgkHZVlTlJN9WnDs2c+NTDhwJ/Vlu8bNQ9bsLHmqO0FT8TZ/
 Vugkyx5QK/tVOKb67Mim+ZM4z/uwpHHDLk72ESlYUId2+FsAa/QeiRwkd94Y3Ae+RXsU
 BM+UtSZQdyjygFpqP/ZKMVICWhynNWy1p6dAEjRrwwkE+06v5mDEHTC7GQkwE5wFNLkP
 ckNNh9Yor0My+MJerJ1YOYxbBp1gSj+HZQgS7OX17vAL3WAmbj8bgu28nfOfqCBa9Phb
 1MnRfO5jeLJZE9DiRBsIWeieK65LTqBRdxYG0bp+92jueCJK+YeJ7NV1/FdYVWmIHCD/
 jYOA==
X-Gm-Message-State: AOJu0Yx1Q87/j96e5IF5+E8Kb7dXMgGsCBDZ5bJ1plRDDzrT4aYzXSsc
 vWP+cnbbKpZ66YCoUXHJS7Ic728wH2fI2rd02jIk2PAzBkNtg5MGCk9sJGOnvBD90iPBPwYm4SM
 =
X-Gm-Gg: ASbGncuaUUuYAowT5or/vNGI5v5A78to0HP4s3w0gM6UQBSzvikuh7qcuLWqE6lYIgl
 ESBFX/FWkerKEWMzQoXCDw/pGU1vwRv22ec6BUOBd4+QqcvWrjMF5RYqLPm2Wgs9BgDjWETlXHw
 X6s6KCtkm4wMWOy8XV1VO3G9UpGjg8ZPvWIG5vgSU/hrheC8opQHqWtSafD9uiRSNKTkE83PKN/
 ZTwNLDIAwr7m9eOA9mBWH17dhuTO56qDcAWi+o7kIQ9BS1YZAg9xts2vu5txRnUQoUg7LjPdMnk
 irVtoMjndJw=
X-Google-Smtp-Source: AGHT+IFacTANFtHPd/GdAfpkJ4gUvfeabEo0JHK6+cJwo6hODWCpecaVxuDSONeaVmKAImewj/0Pzw==
X-Received: by 2002:a05:6602:2b84:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-8447e2f3afbmr406608839f.15.1733490683417; 
 Fri, 06 Dec 2024 05:11:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5b3b9sm97382639f.35.2024.12.06.05.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 05:11:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] rpi: Update environment to support booti and large initrd
Date: Fri,  6 Dec 2024 06:11:11 -0700
Message-Id: <20241206131113.2865416-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206131113.2865416-1-sjg@chromium.org>
References: <20241206131113.2865416-1-sjg@chromium.org>
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

The existing values don't provide for decompressing an arm64 boot-image.
Add those values and move things apart a bit so that a 50MB kernel can be
accomodated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/raspberrypi/rpi/rpi.env | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..d26e451cf7b 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -69,9 +69,11 @@ fdt_high=ffffffff
 initrd_high=ffffffff
 #endif
 kernel_addr_r=0x00080000
-scriptaddr=0x02400000
-pxefile_addr_r=0x02500000
-fdt_addr_r=0x02600000
-ramdisk_addr_r=0x02700000
+kernel_comp_addr_r=0x02000000
+kernel_comp_size=0x02000000
+scriptaddr=0x05400000
+pxefile_addr_r=0x05500000
+fdt_addr_r=0x05600000
+ramdisk_addr_r=0x05700000
 
 boot_targets=mmc usb pxe dhcp
-- 
2.34.1

