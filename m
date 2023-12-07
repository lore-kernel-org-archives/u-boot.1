Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BCAC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 09:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D453D870F6;
	Thu,  7 Dec 2023 10:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VB91xosu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7FD87243; Thu,  7 Dec 2023 10:20:20 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277AB86F64
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 10:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso675181f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701940816; x=1702545616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=anD6nQKmNBCgfQ+e2V57LoPqem7vMgnJfqzxIiJ5hKI=;
 b=VB91xosu7yTfzcD2l70anPvACRONXJQOLWqvpFsY7Nqyt1C2rVfC886wz8Mntph+QE
 Zd18ADPulcbIOV1f7d0YiGS3KvM+B3ixgz1GD22prP/hlHO/qTvHicFcOXmOASmjZ2Z4
 IZWO9ruCfMC5AwSQWN8YncMXOJFvePS8E1mOjDI1f7yTKHQ4pkQ568OHWKDZJqkt+OR6
 ECZzgxYLDSOfFALLH2RDeDnrQIgIZqoQ99LWxy0t2YdcykNXa6/lE50eqjn2EREY4pzx
 JU71/iMMUTth/2eI2FDj5hpy0ycQD4ju8cLlI9lkMQleDB9rAZzCvU2oajJ1Ms754lR/
 c3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940816; x=1702545616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anD6nQKmNBCgfQ+e2V57LoPqem7vMgnJfqzxIiJ5hKI=;
 b=ENhFcizVI2ruNkf1wwWum4lbyY1XhH4J7HdBFhXt+jgneqavhN/GRZ7MVRBbS5MuoI
 TqNU1QT8yp4GuEvJHsv+QcE04r3Q4AdXJn1BukLSvqsMbjurqde4cLIj7FyjEZgsXGLG
 GJ2LmJ9kOgs3zhSYrGO7gI5KP+JQEZLGA4PvGCs/4bgVAZeYskP68uatl7CBp+12wSR4
 cb3/E/JD2YNFSjfO0FiAH1dAGpDqi6askramU4iNccO+TDOVwYv/t8uOx2+JvgjD84na
 x1xozCnoedMd9BSNccQzyjRKXLCToQFzOS5nL6Vmnl3NLjXRsBUsy3HafIm7rDBxYgnV
 gvHg==
X-Gm-Message-State: AOJu0YwXpVsMN9vYBETH2uHeoPFNNk9W3I6uD0EyylFFwTXiCGQjeI7j
 yBad5S2tz4pkafkVLG7TrlHz6g==
X-Google-Smtp-Source: AGHT+IH0qS+e0TrbHSEd3KhgSK9XL0ltWJk78FKBcWFAhf2gVUdRtHc3gBUKStBG1IBJ9bFEw8SrKg==
X-Received: by 2002:a5d:43c4:0:b0:334:b178:393e with SMTP id
 v4-20020a5d43c4000000b00334b178393emr875806wrr.123.1701940816629; 
 Thu, 07 Dec 2023 01:20:16 -0800 (PST)
Received: from localhost.localdomain (ppp046103111243.access.hol.gr.
 [46.103.111.243]) by smtp.gmail.com with ESMTPSA id
 m15-20020a056000180f00b00333332a8d39sm916660wrh.55.2023.12.07.01.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 01:20:15 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org
Cc: heinrich.schuchardt@canonical.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: [PATCH] bootstd: Fix a memory leak in the efi manager bootflow
Date: Thu,  7 Dec 2023 11:20:12 +0200
Message-Id: <20231207092012.17914-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

efi_get_var() allocates memory which has to be freed after the value of
the variable is consumed. Free the memory properly

Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/bootmeth_efi_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index e6c42d41fb80..530ad09cce83 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -65,6 +65,7 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
 				&size);
 	if (bootorder) {
+		free(bootorder);
 		bflow->state = BOOTFLOWST_READY;
 		return 0;
 	}
-- 
2.40.1

