Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30175C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E7B88884;
	Wed, 22 May 2024 18:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="avRg4RCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E61688867; Wed, 22 May 2024 18:04:43 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754E488870
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59cc765c29so111032666b.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393881; x=1716998681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0NDk26H+iHDAlVRHzZWuWds7SnthG/ogIr2wQPsr/Y=;
 b=avRg4RCyDH/7oHNtYokW43dzDrEetP3Rdt9adZmeilMapSncbucAh0RkfogTWB83En
 IWuuqgnHixLDnIjzB4v4Y3+tO8qbQwFAOqM9O1Glk9vCuuMYwgXPeYqw2TjGifC3Fzpr
 HINWvKRqfallT/WYPrmBGhJshHLvQWei8n9D4w8Nj1o59zAd2a0LkNcO57iQuzTX0inI
 igYnIskZ6V8L4XDrNucfi+alLXXJqw1fQZjVKDBvtnEgk9gZH7A/L0xeNKg2Gbige7ad
 yW+poZshtqzfWpoyr6Vzlf2wF0V+Hs0Y8J3I86s4uUvQoJteTaPx45KAIF9dL9u3c0lP
 w45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393881; x=1716998681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0NDk26H+iHDAlVRHzZWuWds7SnthG/ogIr2wQPsr/Y=;
 b=ncsxKuUil0sWOVam/9iqmRd3h0gUldfP4CNhC1K2LE6xELg15eGCh8FZ4hjT+/17Uo
 akP5H+GIaC8hr5e4wRTzbFxuzfUI6H8edlgSK2jVNT+u/ju026QUrMoEZUCVG1O/hrMO
 XkahdZh9bVjmOkBGHMvorwncMxZomZkPQ0U21sk4F/iNOcyKNyrAWB3d3cGv1feIlxVM
 ZRRZFlu6rXB5V+RrkzGOUPy9rp8Xmo82uGvoRU4yyZgMYfILTSVEJm4yw2v34Xw8ZK/A
 DpjO6cQWx9tXK0NQkIpWM4W3MiLnLaJRVWzEnHnjoyKD/eMzk+lCGU/QH/AFfJqlvSSW
 GcpA==
X-Gm-Message-State: AOJu0YzuAWiEw0hfT0Isj3Pz849PTDIyiBu3nNx+cYOsK7C7vANXGgzr
 bfyxsO3UV/rEvHrVWtEpMx4SqFPREkw8WiprQsnhJ9pSur0xgkuF+S++XPvnngSNy9XX7iZojS4
 iKcU/c2tw
X-Google-Smtp-Source: AGHT+IGoFUMCVLhgffRBR7coREWemMoQS5OIHX1c/2q/je/YioX39mHrAUWWRLUAPQOnGGDqdQqp4A==
X-Received: by 2002:a17:906:f28b:b0:a5a:1b47:dab3 with SMTP id
 a640c23a62f3a-a6228083cc5mr154929766b.25.1716393880817; 
 Wed, 22 May 2024 09:04:40 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 09/15] net-lwip: add support for EFI_HTTP_BOOT
Date: Wed, 22 May 2024 18:00:09 +0200
Message-Id: <6c98b28ebe3d2371cc1c62c531ae6115bc93c09e.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Implement the wget_with_dns() function which is needed by
CONFIG_EFI_HTTP_BOOT=y. Note that there is no dependency added on
CONFIG_CMD_DNS_LWIP because CONFIG_CMD_WGET_LWIP natively supports
hostname resolution.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/efi_loader/Kconfig |  5 +++--
 net-lwip/wget.c        | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7..9d8dc8c756 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -505,8 +505,9 @@ config EFI_RISCV_BOOT_PROTOCOL
 
 config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
-	select CMD_DNS
-	select CMD_WGET
+	select CMD_DNS if NET
+	select CMD_WGET if NET
+	select CMD_WGET_LWIP if NET_LWIP
 	select BLKMAP
 	help
 	  Enabling this option adds EFI HTTP Boot support. It allows to
diff --git a/net-lwip/wget.c b/net-lwip/wget.c
index 0ed8b77c47..a3e65dc80e 100644
--- a/net-lwip/wget.c
+++ b/net-lwip/wget.c
@@ -166,3 +166,19 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 
 	return CMD_RET_FAILURE;
 }
+
+#if defined(CONFIG_EFI_HTTP_BOOT)
+int wget_with_dns(ulong dst_addr, char *uri)
+{
+	char addr_str[11];
+	struct cmd_tbl cmdtp = {};
+	char *argv[] = { "wget", addr_str, uri };
+
+	snprintf(addr_str, sizeof(addr_str), "0x%lx", dst_addr);
+
+	if (do_wget(&cmdtp, 0, ARRAY_SIZE(argv), argv) == CMD_RET_SUCCESS)
+		return 0;
+
+	return -1;
+}
+#endif
-- 
2.40.1

