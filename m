Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B9CE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C66803F5;
	Wed,  1 Jan 2025 23:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="clyOWpxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA6180583; Wed,  1 Jan 2025 23:12:59 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB79C80511
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216281bc30fso169432355ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769574; x=1736374374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGAIdBFQgirIsE70JMRXITSIiEJBs1Xyo0+xE7YujME=;
 b=clyOWpxxu8fjmltTe2Bi1uLvyOjntUk7w96b1GaylCyLvpXpXDfZYbrYg0i9scsRQE
 10jLFNiW5P1gqdOnclZd/D3SZ1vYUJ4RymE9dGxNENkKlqHshzCblrAMy2Dy4Y26kI/J
 okOTL1kqoQFDdYbaCXKgLJve2wvpjyndslVAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769574; x=1736374374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGAIdBFQgirIsE70JMRXITSIiEJBs1Xyo0+xE7YujME=;
 b=DX5s3BIRmxCpUJMKW6ef4q8060cNADK+DehPgQSKdcvcetZA5K+hgzSweIeH5TxMf/
 Uz8kf0cd/q7NYnTo4tTcavSNUrqgZxOd+ktn9SvakfmqX0c2aAPo62R26YP9cSC37SMW
 qga6Af0+weaYgd9+OKPn/ZjA6phJ7nY4WxSdcF+9PKqDDV9kvd3ayzcpHAhyHhVZIR9P
 jlv6j6pKan1c6oTc3+DWcJDYMrxLYeNxk7xKlnF08wFUh5h86HKD9DWwjwRO734q3cx+
 ksZLlkdcbSZ5XakF0htafA7oBT+jpEu3DbDd1tamjc1sJKFCqLFFRS3vIzRE00XDlOwp
 yDLg==
X-Gm-Message-State: AOJu0YzbeVSuxUASYy4zDRWCLT65LjzTwitH+wh/oiGxpytptqD7XT2U
 bwOu3IvpCh2vtuQaUbg7Y+h1EC4lkhlKir47NEDSAKWZdS4HDwy/6u2O0fxgYUuT84K39o/nsrU
 =
X-Gm-Gg: ASbGncugAVRJC0KnON93/l4XuVgGsYLHno4IPMmvcZ4ptO5r03yhan26FJdy7LraAku
 3iRed6SVXMLdryKPeFmNjJoUBZo1Jk8RC/PzRWm6EEyQNYx/2VgomjFwJh74IKCPeFbYuvjY1PV
 KsBzxZOpC+QgRUzQE3fVrnBXIiollMzixKqJpvKgXnCrtUBv1OZsNCBlFsB6mgq1vaFJJCWdBhp
 c+ajfumwuB8tVklv1Aeyf+USRP4OWurNueWrUrafDDRLkt+Jjmz9Ic=
X-Google-Smtp-Source: AGHT+IHHJVgaVZQ7ZRJRvH1ByOQ0lk8yZYY5nHGEAPWucGKMqAz/8Nqzgq1Vcpze7hD6nM/WvGEklA==
X-Received: by 2002:a05:6a00:3c84:b0:725:4615:a778 with SMTP id
 d2e1a72fcca58-72abdd7a148mr49623349b3a.7.1735769573767; 
 Wed, 01 Jan 2025 14:12:53 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/67] x86: Create more space for SPL with qemu-x86_64
Date: Thu,  2 Jan 2025 11:09:07 +1300
Message-ID: <20250101221003.1944600-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The space here is quite tight and there is plenty of room in the ROM.
Move SPL earlier to allow for expansion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/qemu-x86_64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 3c0fc7a34fe..39375c76227 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -7,7 +7,7 @@ CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_TEXT_BASE=0xfffd4000
+CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
-- 
2.43.0

