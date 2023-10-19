Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96955CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398178744E;
	Thu, 19 Oct 2023 17:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eXJcE92K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F5E87436; Thu, 19 Oct 2023 17:01:12 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010D587259
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7af52ee31so98545137b3.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727668; x=1698332468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MjA5r6OateBSE2unsZ/rZ6JI0fN4mt9QeKnejMnUv7U=;
 b=eXJcE92KFUJaba/S4ArpokvxDoe3tYKArppdxCWNwxbIN8ceTynSrKvkoHNPQpxQl0
 tD43cT1Kee9X8dRRP0nYJxUAXsPziCSGfaABO2Q96M046fng5o1ozwWWtThuj0dtcxyU
 mu4M7/Z6TjCDFknlcdnjTQy07d7gy6QPE80gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727668; x=1698332468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjA5r6OateBSE2unsZ/rZ6JI0fN4mt9QeKnejMnUv7U=;
 b=esq4eaXMm6My7rVkJkhKKVUpJMVr94bhSeWXpDbBCkaKqzxAa5P9d96VDDH2DqOLRd
 /Y466iGoJJdJv6M4HpUAsdVrLE/q3DjTF2cfhOVEosBXekltGf/ZSgBECtkPrlT6yelr
 ksm8NWUZH/8LJcNCLayni9ZhREk19eh2L3GDctPukpQaVJ5snD1rLuuEVUBsXd02nk7T
 Yugpx+71TQA48/9MpQBrWhtHOaVP1CUSf9HSEb24If6F8yS2yLUzmJSFXhZfN1Fc8VQ7
 ora7PtnUvu+QavtWH8ENVSqYy05zjIHVJFcf32DZl6jW6nM0LrFo7CHZriN8fW31pQo4
 e7yA==
X-Gm-Message-State: AOJu0YxjJhPmugjEhp+qyNuikKumPkGOBzq1LuNhQ95n9Lf16fYg/XTn
 hzu+AsqZt7gHL8qzsvPNYb29nngxSx+0SpfxowAdrg==
X-Google-Smtp-Source: AGHT+IGPfSPlbZ2KpBFRweXuA/yGTydV1HCz2heGrRKMMiXxKNQKngwkjz/X0pV+2gUisnZchri0Lw==
X-Received: by 2002:a0d:d694:0:b0:5a7:afcc:80fe with SMTP id
 y142-20020a0dd694000000b005a7afcc80femr2948860ywd.3.1697727668319; 
 Thu, 19 Oct 2023 08:01:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 03/24] dfu: Make DFU_TFTP depend on NETDEVICES
Date: Thu, 19 Oct 2023 11:00:44 -0400
Message-Id: <20231019150105.714407-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

In order to do a DFU update over TFTP we need to have some network
device available, so make this depend on NETDEVICES

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/dfu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 4e80e85d10d7..8771678ca5a0 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -19,6 +19,7 @@ config DFU_WRITE_ALT
 
 config DFU_TFTP
 	bool "DFU via TFTP"
+	depends on NETDEVICES
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
-- 
2.34.1

