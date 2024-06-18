Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B269BC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034C5884C6;
	Tue, 18 Jun 2024 11:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Nypk13y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D059884A4; Tue, 18 Jun 2024 11:59:11 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6A2884FA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A5F23FE5F
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718704747;
 bh=vqsWmPrn6etHcWF2Ccenxx86jZTAHDbE41OS7uzOxc8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Nypk13y/lDlAWT3tDF88RHeglfHqfdoVmu4UFvw/q43lQNdBM7K6J2fTiDTBUtgV4
 s9WPNgG+4C7dM0+jSGiIbiy7W8czFNFCS+oiGlfF9gdGKYdtNMG3zY0prq+WTjAZzb
 kL5C8DfYg/t5DEWZCYqmbav2MgjP/2/XUGWEiE9WBxanwD7dpxNAjZJEbOwDgp/mYw
 NIyQeBddMAy/FJ/Lj4GirNb9reSL/u3/JRNntOfgTYjPzYmh/bl5EKnwjqU1NqLYjD
 +H/djND7LQhxz0eau1H5rx8w2yvOJ7VB38MuxbKWlkTR42fjxM+ado/nK+zRjtZo6H
 HrMafyGy1Ua5A==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212e2a3a1bso34578715e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 02:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704744; x=1719309544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqsWmPrn6etHcWF2Ccenxx86jZTAHDbE41OS7uzOxc8=;
 b=bmoypFltNRcABhJ4hGupe269dmBif+LJRE1WdkWjgilMFXKtfQiFhTzVa1apkf+zCX
 RE2k8KQE51j7iIuHfTWboNNp15dVUs1wdqPmGsQuwN9VaDPEcpI4fT0yKg8YjW7MRjnL
 u8qX+quVXFlIrqPU+xztO0LBtcD+7/AD0RAgOgEb6o2YPbTBTK9Cj7yNkocTL+mvylGY
 VBHplgLELXqL5jKFtRrmn50ENXGRGELmHr7b5B4cuwjX9zRrqgnHxA60SPnOf10kEnhy
 eC0+FDLIofNyh+SwHBQu/vqtd4mk1/rm9CN3SWR8ilFiPOBQZtem97esK29p11etln7F
 s7Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyUGm5MG8nL1dzN22PM4jiCWgcAZJTUs2XuNZk73ch+iXHEb30328Y4DDSmwc2KKPnqcxlJQ0GNdqhrsInN5x+epOpBw==
X-Gm-Message-State: AOJu0YzYg1YjyAywFUQeP+RzhFVHONb07bjqjuDFzowct/MXGdceDj0H
 gmju1cxjvAGTHQ1M+lnpGMMIoyzfYgGaSKb61thMOPa5aKJBv8O8dgj75/T50Ma29kZsp1hyn1G
 9eQEi3Br7l9uNKKapUf6iH483kKtuJZMhu4qWkusbU1ucb/n6teZqd96O2WuWmEtG+ME=
X-Received: by 2002:a05:600c:3492:b0:422:720a:1bef with SMTP id
 5b1f17b1804b1-42304825b7amr83169975e9.24.1718704744722; 
 Tue, 18 Jun 2024 02:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oN4E0ATY2kISyJhBxYDzcF3qsOi4em9kco2gc6lGVWUT9k6GHNBcreGLjmktLa3ze5xvfA==
X-Received: by 2002:a05:600c:3492:b0:422:720a:1bef with SMTP id
 5b1f17b1804b1-42304825b7amr83169805e9.24.1718704744322; 
 Tue, 18 Jun 2024 02:59:04 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4246bddc59bsm46989075e9.5.2024.06.18.02.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 02:59:03 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] usb: informative message if no controller
Date: Tue, 18 Jun 2024 11:58:57 +0200
Message-ID: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
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

The message 'No working controllers found' provides no clue that this
refers to USB controllers.

Provide a message that refers to USB. Use log_info().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	plural controllers
v2:
	add 'found' at end of message
	keep printf
---
 drivers/usb/host/usb-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d66..e16432a1516 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -388,7 +388,7 @@ int usb_init(void)
 
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
-		printf("No working controllers found\n");
+		printf("No USB controllers found\n");
 
 	return usb_started ? 0 : -ENOENT;
 }
-- 
2.43.0

