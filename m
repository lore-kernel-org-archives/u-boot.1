Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3ECDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B4286DDE;
	Mon, 16 Oct 2023 00:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBYf1rvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D59D886C2D; Mon, 16 Oct 2023 00:34:54 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF9786BA4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so6520780a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409257; x=1698014057; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n8i/wjqdC71ztvySiOjCLW5YIxJJAW1Xh2eZaF5DKIY=;
 b=kBYf1rvoWACCoqOGY5tFvE0h961gynuVjFGIrG5L5udYgW+p3MJHjhczKCisnf5vqw
 JXdmIWcjj6aneF5E+o1kreemMNOdJA3nQb3KeISklTAMDCYF4o3a9wluQtpvtm4wD7tj
 XBnGy0KEV7JwngNLZiKeXogfpAoApB6P4FnZny1okXxLs5Tlwr97DfUOIp81oUhz4rba
 Ta89E0fUqkZBLAKawlLXFzbnym+uT29sO+0fHLSiDePlQ957GXpLe2kr6TpjA1eGoRcX
 H/TXIvpeQ1EFmTt/oIyxVBx0ctOfRbgU4uyKxGBu8C62F/yZe5uSiXy0fnRprKKFvL2u
 zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409257; x=1698014057;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8i/wjqdC71ztvySiOjCLW5YIxJJAW1Xh2eZaF5DKIY=;
 b=ExTvvOZBR2n7ad1TNf3WOji1rKjmUg4Tx3/o64WfmaXMb3HFM0FRIjm43rdjvEizF1
 su+zdTOzNmoVzxkAn2vwawxeAkzw8LG0EsBC7NsYrARPrOE3Vh8v3L02wZHpBdLvjbV3
 8f2CfrpRVZqZErfXDy+p0RKBVdn2wEOtjeu80Kj3bPvppVSXlPERn8cg+F80EGBh5gJG
 H/IybazPqee+b87prk1Lo5hYZd3+KghclF8yhJbIEKcRmnABrbTNT47ck19Yer+f/kb3
 3owSzFKXA85NRz9EfKdI5e4KvPF+lKGzZWhd8E8S27l4+ulo1sTTRU1o0QnMi1QRTKgq
 +o7g==
X-Gm-Message-State: AOJu0YyClGj7s+PiDbyCcwVvGJdjvYjd1r+vyqZXR3A9o0OZ6CAqsK/d
 3CskEd8T2VGz05b7HpEo52c=
X-Google-Smtp-Source: AGHT+IHHkl1YYHnQuOXajKCNSThXJABkUe2coTSWtvFJyb4uoAITqj346pgyWWWeUzsW606ycdLN1Q==
X-Received: by 2002:a05:6402:3550:b0:53d:ff75:9c38 with SMTP id
 f16-20020a056402355000b0053dff759c38mr10524578edd.39.1697409256773; 
 Sun, 15 Oct 2023 15:34:16 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 cx16-20020a05640222b000b0053dbb214d96sm6621584edb.13.2023.10.15.15.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:34:16 -0700 (PDT)
Message-ID: <47780c6a-6e51-501d-b146-3cd637854612@gmail.com>
Date: Mon, 16 Oct 2023 00:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 8/8] rockchip: configs: sandbox: enable rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Enable rkmtd command for testing with sandbox_defconfig
and sandbox64_defconfig.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V3:
  New patch
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018b..1a01f51a0b75 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_CAT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 01830c7bd255..cc54e6dec5af 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -84,6 +84,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_AXI=y
--
2.39.2

