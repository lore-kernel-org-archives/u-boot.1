Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFBCC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 10:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1043A810EB;
	Fri,  2 May 2025 12:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJGfB/xO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73D2812BC; Fri,  2 May 2025 12:59:14 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A5880F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 12:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-47690a4ec97so24762521cf.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746183551; x=1746788351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R8yNz0VkCvTjF33/4u44sun70E9eDGStthyr9HBMB7E=;
 b=dJGfB/xOZD1rl5PJ8AjNiE5K8o1uMYDmO4BE8p3OVPJ1IbRBZGvP1ZQwHFf3q2N95G
 5MSfdxgm4tDmLFsRAzN6YgNJjMz7kuzqHaHDSpPFtJY9cOL3hnM58m1pCeo5A4k7EHlO
 viFiyZBaYsxAFnQGDiHmmVAbvTCj/3N0z0jNUJ4+T6bVzANvBew8s8G5/l0LExomJGq1
 ajtFvaQ+ImHJRgX2I78G/jg3SFWGnT3dNeueLZp5kwQLBcOmmuWtkJQd7OdjoscoY0op
 PwGHTqZugYBwL16bAZX0SM8dWeMLr6AkEmd9hNRWHOsaooPFEcR1Zw1tyemWr7tWco4r
 6pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183551; x=1746788351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8yNz0VkCvTjF33/4u44sun70E9eDGStthyr9HBMB7E=;
 b=vgRerdtyAPHs4GYqRzLP84mDtlDUJBTCL4IaulTxWA4vcbru+cnEToz/9vgViDTHpY
 3UnOt1vBLR3y121+2LGWWBXK/cCeZsI0S13/R8pyYoIiytXFOoLVr8ohQ9xOI+u1R/vZ
 9S7GDA8fgQbzxC4VBKrD2RBBs0FWX1JRgosgetCGtRrXi1MtaHloB7azSmikGWrfo8eQ
 jB6tEelRVKFrBvD/+7r5KuwEw5kWsFRYkrO550NLXqkJuL6UJD6tWq0tUWLTG8zPlEqG
 6yDnvb7OiVW+GMGZ2Wd0hcceactblsDNLG+Ck7nrVGFgoZM3jYaN0iF+mpK2Ue0bhEhv
 aLHA==
X-Gm-Message-State: AOJu0YzK3l+I/nXTwUtd20rR7t1NKGbTYqtnQEsY3hUrZmLgeiX41vAL
 z5s0xyI9PSxFALrRWv6HDR8OZM89LEvT6MmQmMbqWUd2lE6u8ujTBPVjEg==
X-Gm-Gg: ASbGncukWpBgZ5lQT3fOdKnrXF+cjVJFfBGxc6p4SRReDbnnLTKWD64RqBsq2g1MQLt
 bSCi5zZC1TGDlElbUrwrY8lM9ijYGFLEPu5GMs6hI3glLY5QD1fdqEF9YNKZVQ9H4cwutWHI8Lp
 MoYv43LzJqZV9T2ZQbMM2KWEW4E7JyepAO1NR0/NBPAFstQHVaiwcRBPRKeQjH22qwBtIj6EmUV
 2ZKq0gKUyHfXr2joTYcfbgb1uJbnNtaCMsjb655xvt4n2uPFjWgf7ceI/knDgZukFAkxTQMt4vP
 YPkKrDv0D2Dy8tUkZBO2ozy//6zRKTb3vndl/07nQNv38RP51JY1AaUDDRJSre/htA5zJ9dkqjk
 QqIWqMs7wElCP3/o=
X-Google-Smtp-Source: AGHT+IHsfpblx4Y/YRx01nogA9CQU8NQytsCUlbG9XUZlDfAgMDNoHJEE103XKVvQqBQpGtQghP9sw==
X-Received: by 2002:a05:622a:5c98:b0:476:790c:73a7 with SMTP id
 d75a77b69052e-48c32ac7253mr31749651cf.40.1746183551088; 
 Fri, 02 May 2025 03:59:11 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b966dc21asm16754901cf.32.2025.05.02.03.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:59:10 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: festevam@gmail.com, aford@beaconembedded.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/3] arm64: imx: imx8mm-beacon: Enable BOOTAUX
Date: Fri,  2 May 2025 05:58:46 -0500
Message-ID: <20250502105859.978427-1-aford173@gmail.com>
X-Mailer: git-send-email 2.48.1
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

In order to run binaries targeting the Cortex-M4,
BOOTAUX is required.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index e4eca19a10b..27007bd8687 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
+CONFIG_IMX_BOOTAUX=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-- 
2.48.1

