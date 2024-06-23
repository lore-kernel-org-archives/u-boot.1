Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5DCC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC518854A;
	Sun, 23 Jun 2024 19:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mq19lTMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD218837D; Sun, 23 Jun 2024 19:53:28 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CF0884BE
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eb85e80661so136408739f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165204; x=1719770004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=mq19lTMbjCRLaoIcMx6+JVHh3eVV9g50OM+kTBZRzIJB1E21fKyx5eYVy9aIC+dGhI
 u9RJg2qfGTxsIsVoIeokPsVMhJ19DhlZIM7RJm7a2GtWgB35ly3Ig3/zw6YXOyVE9j0s
 jRKkn5Vr3U+Z4MZlad387wID/uREDeI2txe9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165204; x=1719770004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=YwcrEJ+SPRncf1ADJSwP2Yjm7H4cf1cHVlIwNhLcdwodJoCTBwVbtTcQt9HLXlf2VF
 gaOqLu/BH59aZeHDzkPmRfwLFY0xQxhTfL2x1I14LE7VAWwsE8prMm00h3Mf7KRYrfed
 FvXX4NAbrU/krv5F5l+LrEkUcDQWnYvbL57E9MNc52UFQgHHjrrSdz17nH5OFuGS5hjG
 9LI/EPYA7WqnBc/X6StJhpBeAKRqwftmHHqOThIZqCNgVgfsvddY2qitz5KKviCs81l5
 ouQSFmohqJ3QLiGNT+nD2mMAdE7fWZZ+v+wBHiPsKfd/j/E5l1XFWxDiDqqJfUvtSR4M
 hA+g==
X-Gm-Message-State: AOJu0Yz0j4ItUYgtBv50AtqsJ601XJzKDNq3K+yU+Uwy3Y3UdBTCzoGg
 ijPntGRSso966u83Pr5tTjIESFPEMIjWot7yYIIHFfrfwl1X2dUoXlUpzQEGptnS0GyS1OOj8fK
 Ryw==
X-Google-Smtp-Source: AGHT+IF8rm+6BZqGI/9DUU7bQLi5SAq3Smxyi/HjbQYxJcyjbnCcHMzlheEjmQcI0QC88I8hbKHIHw==
X-Received: by 2002:a05:6602:148b:b0:7eb:89ba:44fa with SMTP id
 ca18e2360f4ac-7f3a74a9221mr339229539f.4.1719165203976; 
 Sun, 23 Jun 2024 10:53:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 06/16] nvidia: nyan-big: Disable debug UART
Date: Sun, 23 Jun 2024 11:52:52 -0600
Message-Id: <20240623175302.1463973-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

This cannot be enabled early in boot since some other init is needed.
At this point it is unclear exactly what init is needed, so disable
the debug UART to avoid a hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/nyan-big_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 1483d17d975..4dec710cf8d 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -17,7 +17,6 @@ CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
 CONFIG_SYS_LOAD_ADDR=0x82408000
-CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

