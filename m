Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0803CCF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB48893CF;
	Fri, 20 Sep 2024 09:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vdkx0RVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013018939A; Fri, 20 Sep 2024 09:25:04 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04D88939A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so15601055e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817102; x=1727421902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6e0o/F7aq2nC/vaU8+aHr3OBAvwMXQ7qD5FTGSoV6TM=;
 b=Vdkx0RVDKUuyBA6vXWB6NJwd6OES2Vo3PK0vvymkMTJjGLtiMJfdzU9vwfmgDBf3UB
 dZTFw8ZXt/pWRb1+LlVsNm5ZSW2dZxOZenix0X3RrC7VaHiaakiWVzFbAhqEVDuPv3J1
 n9wEMjlCtH2UAw7K2QErSbMQZRkkQVvFjyykE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817102; x=1727421902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6e0o/F7aq2nC/vaU8+aHr3OBAvwMXQ7qD5FTGSoV6TM=;
 b=LYizwFtqT/hAzkJt/QWsswqNj1Vx4fjuNOxHDcrOiMBJoPoun6FQVp4Ldrm9OKGW1+
 TyM6CV/gsJFiTZet+eD5LF6FNjua3neUMuHBwc1HIpbAMuGe9W8Dp5o/ICrWHU+ef0Ul
 lI3Mpcui7MW8XML+bVUsvuNbE2M76QkrwJSD3ohVeiGJZAvjc+144qeJYT8df7+NApl5
 u+LQ2iWAfGoXC00tHwrnOUhy69Tsyv65iA40CY9fuwWnywZTj4ZQRE2zEl+sSJXh1eK2
 amBazZPR85BedsVWtrFnWT/QL94GDc7z8eQb/JJ0b58wHChITKOUsCpYwZQE83tY6KEm
 uDBw==
X-Gm-Message-State: AOJu0YwG06yI722XQenR7wlRzEjfH4CfcBz4ooYua17pIUs6K9k9Bl/h
 o165zp5fr69ZNEeB+2Ep7MBXi7sNIuFuWBImgQeSX6MWs8JCNjKtBB7WEvl45DnUtxKY8Z5qNLC
 zEHtZ
X-Google-Smtp-Source: AGHT+IExF2q0G2b93OHNsKDQeip6cQQfx5DWiL5xPBeRUW6jdtyoOEADS6mDHzPlry8Zn+H11OPd7A==
X-Received: by 2002:a05:600c:4705:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42e7c1640aamr10939065e9.13.1726817102123; 
 Fri, 20 Sep 2024 00:25:02 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/18] fdtdec: Support separate BSS for all XPL builds
Date: Fri, 20 Sep 2024 09:24:28 +0200
Message-ID: <20240920072444.134997-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Adjust the condition so that separate BSS can be deselected for TPL and
VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 5edc8dd2f9f..106bb406365 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1232,7 +1232,7 @@ static void *fdt_find_separate(void)
 
 #ifdef CONFIG_SPL_BUILD
 	/* FDT is at end of BSS unless it is in a different memory region */
-	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS))
+	if (CONFIG_IS_ENABLED(SEPARATE_BSS))
 		fdt_blob = (ulong *)_image_binary_end;
 	else
 		fdt_blob = (ulong *)__bss_end;
-- 
2.43.0

