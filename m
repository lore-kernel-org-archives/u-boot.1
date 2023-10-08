Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A63E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C91A86D29;
	Sun,  8 Oct 2023 22:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R3hlGrKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B239C86CF4; Sun,  8 Oct 2023 22:59:52 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F34B8655F
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 22:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-692af7b641cso581895b3a.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696798789; x=1697403589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMcoLSNi/uCSOc2lyKL4YXIHmOT2N9V7BOnZAnZMdmw=;
 b=R3hlGrKl2O0S+NdFOtx5z1B9e4WLUonqFAUZEJLlse4H4BF6cy1z81oVWyOnrlV+Mk
 e94bHZobNx/2tvcu+cSZbXEj3rmMsBlWXiVz7DaXLFpcKnDva1vI8zS6/+dSUG9T1iW9
 0ziSyoz3BBv0cm/Eg9eEXxNcSK9LSOuzw2OQ1Z1rAQsKkWRMF8uSiaaNbDhEAisBySEv
 FmQfCUl6azOPUrlaD2/uqg7VRIf4DAEvJ7o1Dkv29P5oSTOHVepqZDC+2RNq/w38hgij
 jS2UlJyLU02qTwOm8PB/la2PEUm+AGMfuEivc4oVwQMQC0Gko9PeIosozSSg0W+0dUYR
 xW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696798789; x=1697403589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMcoLSNi/uCSOc2lyKL4YXIHmOT2N9V7BOnZAnZMdmw=;
 b=dPXtMq9/a5PHP+1yZqx+ubu20urywfQZCjbX3yBtDU0GR5YshIsFbbTVOu7JyU/I8Z
 zMfJK3qEPuXGdafYVK3WckAeZZh+BcNIyN8GIZDXNR1Z87FgJI3wfo+Nu1sQnzZGRkCL
 gZwtYB7J+El3uozgj8RyTOg/xQuXCcxZMxASPgxEp1sEO68xwtW3NjcqyLlIANi4tDoE
 NiJiPvXCzfEn/pq2UnKP/5sQ6t4Mav/RDM70EdwPjrGY0SZLrQx6V9cCXJv6MPfaDIkV
 BOxkaYpsHD1AyJcA5GgxtseQNZO625/PBsicsQuKehhZIZmflUnPoKR7sbFdx57ZoFce
 ODzw==
X-Gm-Message-State: AOJu0YyuM0GEoQ8mrBQb+U5fopLbbgDMimdFVA9LDOP5lwHoF59aBNVq
 C/k2eJEUC9wAGj5aGv8RQwr0cN1nKgI=
X-Google-Smtp-Source: AGHT+IGb1vVLGHJb7QNGFi6bSbw41zdsE7bWAdhRtgdDQ+P6f9ktAq2jX+PB3/fqf31NWhkc7qewjQ==
X-Received: by 2002:a05:6a20:3d04:b0:13d:d5bd:758f with SMTP id
 y4-20020a056a203d0400b0013dd5bd758fmr17474459pzi.6.1696798788703; 
 Sun, 08 Oct 2023 13:59:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3eae:c867:7cc4:36a5])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a62bd0c000000b0068e49cb1692sm4919550pff.1.2023.10.08.13.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 13:59:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/3] usb: ehci: mxs: Use regulator_set_enable_if_allowed()
Date: Sun,  8 Oct 2023 17:59:38 -0300
Message-Id: <20231008205939.3332647-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008205939.3332647-1-festevam@gmail.com>
References: <20231008205939.3332647-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Since commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable() may be EALREADY or
EBUSY for fixed/GPIO regulators.

Switch to using the more relaxed regulator_set_enable_if_allowed() to
continue if regulator already was enabled or disabled.

This fixes the following error when running the 'ums' command:

=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0xece000
Error enabling VBUS supply
g_dnl_register: failed!, error: -114
g_dnl_register failed

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v1:
- Only collected Marek's Reviewed-by tag.

 drivers/usb/host/ehci-mxs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
index 092c79fd4bc5..ddf7cc2d00a7 100644
--- a/drivers/usb/host/ehci-mxs.c
+++ b/drivers/usb/host/ehci-mxs.c
@@ -236,9 +236,9 @@ static int ehci_usb_probe(struct udevice *dev)
 		debug("%s: No vbus supply\n", dev->name);
 
 	if (!ret && priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply,
-					   (type == USB_INIT_DEVICE) ?
-					   false : true);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+						      (type == USB_INIT_DEVICE) ?
+						      false : true);
 		if (ret) {
 			puts("Error enabling VBUS supply\n");
 			return ret;
@@ -265,7 +265,7 @@ static int ehci_usb_remove(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply, false);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply, false);
 		if (ret) {
 			puts("Error disabling VBUS supply\n");
 			return ret;
-- 
2.34.1

