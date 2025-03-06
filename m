Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CE9C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D3681420;
	Thu,  6 Mar 2025 15:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z8SsAGIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409B481417; Thu,  6 Mar 2025 15:33:01 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F38C81253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so127801f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271578; x=1741876378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QCKbKpoW7qtcnKQqEqm3Pt/MttXIhUkzBeb9zyPhNg=;
 b=Z8SsAGIulmA2uyyfpo9SlD2YR5+rs1z6SzUvgjUUzycG41DsoBB7A02Gh6V7Efhm5F
 G8u4hajuxsq0vMKc3dfGC0sXK+CgD3AfzLsTv5vhxrIUvpRnpmeV33YBn7sAfAVIuc8r
 FvT8YP+xSRYi3BX/uHBSYef+3k/YjY03tvJpFFaKe6eIePgi3t3AtSCqgGFF09uzSdmj
 FdouKkOh0kj3UW/KpJon+rMRnR3HqcTHf0Pey+AjRz6JFkP7UNSsoh+bIE2TtzjlILRM
 /D80VKbqrxr2gzc3yG7wNaRKNS4qJaTdK9oytWUAAOeH5SOq0qZPCxjK0QYpkybunjrm
 M9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271578; x=1741876378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QCKbKpoW7qtcnKQqEqm3Pt/MttXIhUkzBeb9zyPhNg=;
 b=Wk16C++SKUo3x9WhFBRJFnDTRBBGba/NONRDneZHVeAaKSwmAGBShObjN2+k23X+ZM
 jqCDhuYfaa+L0PdetyUerSgdl4sUtd3H1/NJeVJwr2YkHaQeLyoAObCeG0TOyC1oVCpF
 U7TFTUCQWJ55xoVSvBvrnCV+RGau9+zTgDUkkZete3o4bPf/UivdbDSBhwn1P9fpT5tb
 XI+BFowkQ+idbd+iwkHN+4j0zPn+RwLS42MRl/QzPPYXkGZbGfUm1e7I9IxwmUSr7uFf
 YdwFgchMSx8haHag8Q/q11jBwB/Cq20m6fjUycguQ+DH7+3EaVy4+CnH2wwlBqOfYHth
 4z6g==
X-Gm-Message-State: AOJu0Ywmnx326RHkYOatCJOfrsXtU0UJ9IzxQ8Y7KKFJkEvcmzlwX6WC
 6hdnoQPt5Hy8BZJa26EGQKn+X1G+yXeNNEjNVMgDSRsNNcRWlwpr0hMPeq1KihQIP0vhUDEFdw+
 q
X-Gm-Gg: ASbGnctgF22sS5BfBjyymxw+2XQ454+vVPC7pQTKjBcndwjmSR3Zu3PcDAgIx2Sg8nd
 5r4YgA9MCvuC/69KK8v4Swd7QCoJAEVu8inWy9KZrvTqsSiM3WEcyRB5021rwoRKIz9Qos7DfWX
 nq07e084nH0ohO+NlE0N6SZbWcXTJxGdUKbL6TqfSZHmB/nZ3CHSPmX6tj5Bs/o1flgjgF/RZIN
 HmWdeLHpL8kXa8PpneIBNPXzTGth45dL0IX93xbmO/eAvhG2pSBPbJG0RKfchBEFtt4qXV3yXek
 5aZzFBqb4S6eTLtrQqFVCkUYoKQCD7UoVvdXkPhlk8gH5TSpLhmKVA==
X-Google-Smtp-Source: AGHT+IH+8LB7bDg69JSVECviSN/esVStzfZz0GA8RdyVMIZNnrZZbEBcZy12fF3BiB9vE3DImDoMMg==
X-Received: by 2002:a5d:5f91:0:b0:391:fcc:9ee8 with SMTP id
 ffacd0b85a97d-3911f740cb5mr7425482f8f.23.1741271578440; 
 Thu, 06 Mar 2025 06:32:58 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9470e2sm21561065e9.33.2025.03.06.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:32:58 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] net: lwip: add CONFIG_LWIP_DEBUG_RXTX
Date: Thu,  6 Mar 2025 15:32:22 +0100
Message-ID: <20250306143224.3080316-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306143224.3080316-1-jerome.forissier@linaro.org>
References: <20250306143224.3080316-1-jerome.forissier@linaro.org>
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

Add Kconfig symbol LWIP_DEBUG_RXTX to dump the incoming and outgoing
packets when NET_LWIP=y.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/Kconfig    |  6 ++++++
 net/lwip/net-lwip.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 40345ced9c9..d28a8a7df94 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -10,6 +10,12 @@ config LWIP_DEBUG
 	  Prints messages to the console regarding network packets that go in
           and out of the lwIP library.
 
+config LWIP_DEBUG_RXTX
+	bool "Dump packets sent and received by lwIP"
+	help
+	  Performs an hexadecimal & ASCII dump of the data received and sent by
+	  the lwIP network stack.
+
 config LWIP_ASSERT
 	bool "Enable assertions in the lwIP library"
 	help
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 5a2a86686f4..c00a7fe97cd 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -5,6 +5,7 @@
 #include <command.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <hexdump.h>
 #include <lwip/ip4_addr.h>
 #include <lwip/err.h>
 #include <lwip/netif.h>
@@ -36,6 +37,12 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	void *pp = NULL;
 	int err;
 
+	if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
+		printf("net_lwip_tx: %u bytes, udev %s\n", p->len, udev->name);
+		print_hex_dump("net_lwip_tx: ", 0, 16, 1, p->payload, p->len,
+			       true);
+	}
+
 	if ((unsigned long)p->payload % PKTALIGN) {
 		/*
 		 * Some net drivers have strict alignment requirements and may
@@ -265,6 +272,13 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 		flags = 0;
 
 		if (len > 0) {
+			if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
+				printf("net_lwip_tx: %u bytes, udev %s \n", len,
+				       udev->name);
+				print_hex_dump("net_lwip_rx: ", 0, 16, 1,
+					       packet, len, true);
+			}
+
 			pbuf = alloc_pbuf_and_copy(packet, len);
 			if (pbuf)
 				netif->input(pbuf, netif);
-- 
2.43.0

