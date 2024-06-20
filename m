Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99EFC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151EB88571;
	Fri, 21 Jun 2024 01:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDiOa/Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63568885A0; Fri, 21 Jun 2024 01:06:48 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A50F8855E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb6aedcabcso52374139f.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924805; x=1719529605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=QDiOa/EqY8VCLZ736paLbTrMp3rm3AGU7wWc1konXB5Mw0jvn1H32WtqBT3sCMwGFd
 HfiN6v2nQC+4o1l/wPkRvHOuNUuX6Snbt4GF/xBamB0plxTxoj4nTUtTg/+3ht6vnaox
 h8zWdewTz+g3zZyMWfLj/75UdluEadwEQiPKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924805; x=1719529605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=sm3p7MZxTThO+P2SM3fPduUNSH0f1fm4fDKj9TR1wVhks4g0Vs5hu6d/BKP6L/H21j
 EVM1ixs8MW22yMPrCcFEuarKOsNP9IUhgxa2L9C5/F2f3r4ig2mqWOLmtGd+lWqh4Pxz
 BgpCfzUdhNaN5hZ7e/Ho888MidXg926ZLoy/t/8oAmYDQaacpDgiZrCWJBPxGUdbcyWS
 TJBN7OisUesadWRoS2HiWaNkR7IgaURWDt+3sFGuwfUMTStutVxUJjAXIRofUuFLgiqz
 S6+6QwckdMLhhoWqrXo11U+khEvPRIm6DHuFnxOHhm+NfBedMCyCEYwQuAx97l4dub+W
 sDYw==
X-Gm-Message-State: AOJu0YwXo1Z4KPMJZiVtal3VG0QCnwA3KsknvTQKCc7IfbxfG4aHw5Np
 cB/D6f7M/0/SPVjRsl2/Xg2ebEBQcAGztBM/5/MMhuk7eOirv9z4iOBzqSX2IXqIpFNFQ9YnyXO
 ofw==
X-Google-Smtp-Source: AGHT+IHp6Q2eh9UCm9xhD9ylDEpBZqf0prGHF9Ao30eWFiGBUNjdOlJzrtQcxu6SdJPW1le6HI2YgQ==
X-Received: by 2002:a05:6602:1582:b0:7eb:eeba:5e90 with SMTP id
 ca18e2360f4ac-7f13ee84deemr813149239f.18.1718924805036; 
 Thu, 20 Jun 2024 16:06:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Allen Martin <amartin@nvidia.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 09/18] nvidia: nyan-big: Disable debug UART
Date: Thu, 20 Jun 2024 17:06:16 -0600
Message-Id: <20240620230625.1797397-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

