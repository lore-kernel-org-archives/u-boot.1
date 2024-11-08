Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D66D5C0F0
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89AB89234;
	Fri,  8 Nov 2024 16:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+s7+IZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E067A892A4; Fri,  8 Nov 2024 16:24:13 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97638925A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83abf71f244so78521639f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079450; x=1731684250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmk0xfEoYZWCbe8+sYaXOIVrthbpvM++URfwvKwsR9M=;
 b=A+s7+IZox9xP1mgzd09inWRf7BzuLaZKeyww81xgs3GDGBvIkd1VIk2QON264hcNhY
 vayve+0ROdrt/+Z5sI/RWRucor3vDCKj3o8eMPB9IFad+ziekGpn9cuEalxdEtxy3R+m
 SVWuQ0nakn9WBnqU7KDxQSjYvf2HfK6+04YbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079450; x=1731684250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmk0xfEoYZWCbe8+sYaXOIVrthbpvM++URfwvKwsR9M=;
 b=DGIsur1fqUVQTD+zttsvWHhvOKe+Q6SLTOV2JI0GZGq944uLaCVI/eTjUvdkpqT0v2
 q5YCHAxxfLBnbkvwYCRYef4bRmmZKy632GTcqdUeQbLjpfTqGi1nyar9ct4NCUAn5M4k
 3fJ/+XgOYMSOfPKKI0+TiIvV/fPLD7bjgUFndHr2357i17DOkvKWZc/RuKvngtXPxccF
 i94SHVrcnZp5HR56ZspgLzUjTwJU5SAg7bZ+ylhq/J8MX77RGBtSKvkd9MNsBqAC/kdv
 C9Q5HWI+QnhwBzs2jjEwuG4RZ2EtEPCpJ7fggIVxrHcze5BhFjINivLdHpVIVevp1hLZ
 rIpg==
X-Gm-Message-State: AOJu0YzchtY81FlXDbBdAk6zlOWTnItwOCBm4F+XVxAFnlJgFPLTjTS5
 JJUTY2p50hKDHcHL1yID7WX2OM6Zde7RsTZ/eS2VxC54zUSJsZbDDD/JplThinSJRU6MYLN12uA
 =
X-Google-Smtp-Source: AGHT+IGFOVctW6d+MSzBreNFOsWSHKFzjsMeHLBxCO4igmYlVVg8ZZTive6Ll7WAJROYSmd3jzxDLw==
X-Received: by 2002:a05:6602:160e:b0:832:40d0:902a with SMTP id
 ca18e2360f4ac-83e032a1a31mr316009239f.6.1731079449848; 
 Fri, 08 Nov 2024 07:24:09 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:24:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 9/9] RFC: Show building with #include in defconfig
Date: Fri,  8 Nov 2024 08:23:50 -0700
Message-Id: <20241108152350.3686274-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

Do not apply.

Update one board to drop the now-unnecessary settings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/j721e_sk_a72_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/j721e_sk_a72_defconfig b/configs/j721e_sk_a72_defconfig
index 80e3e90cafd..f7ddb405ee1 100644
--- a/configs/j721e_sk_a72_defconfig
+++ b/configs/j721e_sk_a72_defconfig
@@ -1,9 +1,4 @@
 #include <configs/j721e_evm_a72_defconfig>
 
-CONFIG_ARM=y
-CONFIG_ARCH_K3=y
-CONFIG_SOC_K3_J721E=y
-CONFIG_TARGET_J721E_A72_EVM=y
-
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j721e-sk"
 CONFIG_OF_LIST="ti/k3-j721e-sk"
-- 
2.34.1

