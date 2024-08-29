Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457F5C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7439C88CC3;
	Thu, 29 Aug 2024 16:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kd03oYgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1A388C70; Thu, 29 Aug 2024 16:58:35 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145F888CB6
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39d254187daso2873975ab.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943512; x=1725548312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhKSnMx0yhM2r+nFK5gE+AcCQNLYQP8EvRWZxqAW44E=;
 b=Kd03oYgUdRhLj2n+kbSonA5eRiUbYR7JU7TwiKD/JrEeIxfLscb9MmZ6APE/x+r+Yq
 VHsmWi2WuP8IR2gIq9jGQSNQJYJcp4qXCHu/L0XdoTXxKsMe5STEpdQcg9Ab+lrQeChh
 wrIp4IQsk57XITrC/V3nPQltRFP6e4pMaFBvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943512; x=1725548312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhKSnMx0yhM2r+nFK5gE+AcCQNLYQP8EvRWZxqAW44E=;
 b=W5DfS5YF96Ik6WFhK1jWgZiYEwBm10/YKYkcmXpL43UsF2IHy9OW+yufOx8DvXTOjQ
 x7GOfoxRlStsvuQZBlcP26lfghMIiO4TYyPB6WDdP+d78dNqm67NMrba2TWcusfX6lFz
 YZ1OI/bWqkpcoH2xGHEtw7sswhCXrRwZqL3zf4GrDwiA2tvdK25Uc2lYP7lGly6Lca8F
 yBKVRydjJ/I/hcGBYr4TTdjIxOEPfq9GiDF1y4AQMhEhy76zLGV+A2biA/z82QshvQ/V
 iHFg2qFuOECAgRcTGYzaY9Wl93+YpDgQIUGrR4t9NEm5FAjv3WHgsXlvfcoPhIgX8MQF
 0wLA==
X-Gm-Message-State: AOJu0YxegiQBkyqAaRU012dzkYY3BkCWvmGnhUzT+V6ll/86nAMjrVPv
 GEluioXjJvAXyRfcZ/iYODeDj2U+L80orZNFLNwnxPL77pEWhCZ20ecEPe7nP5DgKGysX9K0aNc
 =
X-Google-Smtp-Source: AGHT+IFZjGVyPETjkzRkNPwEueDiBgqdaQksXwxb3CwaU4bgcQszl2ZsaMSYCHpiZymOwceHlxQj6g==
X-Received: by 2002:a05:6e02:1a01:b0:39f:36f3:1959 with SMTP id
 e9e14a558f8ab-39f377d827emr41059915ab.3.1724943511677; 
 Thu, 29 Aug 2024 07:58:31 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/19] boot: Imply CRC8 with VBE
Date: Thu, 29 Aug 2024 08:58:01 -0600
Message-Id: <20240829145802.1827952-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

VBE uses a crc8 checksum to verify that the nvdata is valid, so make
sure it is available if VBE is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index afe04c7327a..49e99e5e155 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -716,6 +716,8 @@ config SPL_BOOTMETH_VBE_REQUEST
 config BOOTMETH_VBE_SIMPLE
 	bool "Bootdev support for VBE 'simple' method"
 	default y
+	imply SPL_CRC8
+	imply VPL_CRC8
 	help
 	  Enables support for VBE 'simple' boot. This allows updating a single
 	  firmware image in boot media such as MMC. It does not support any sort
-- 
2.34.1

