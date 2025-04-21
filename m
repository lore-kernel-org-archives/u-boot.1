Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C32BC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5704E817C4;
	Mon, 21 Apr 2025 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FCJRYLsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F0E81E1F; Mon, 21 Apr 2025 18:26:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83F981FC6
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D1A4241A11
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252782;
 bh=wKpWjZhgrEkeT+ygG3UT8V1qxeF62P5zEGd9aoawBGc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=FCJRYLsSEEccZ/1G51UXslttP8cPsOd06Yi3wc9kRv+jjhnwAnJ6CwwlKOtRynHCc
 BrKeEit+/U3sw1NXEVdgRNJ3atRYi+fvQA6N7Q5+srtqSVc6IIFQ0C3Ktl8WFD0uum
 zIZyE+yjXRXhwJK/iRK4f9xt+ywNW9/oIINmIzc2U39K8D0NCg572I6+Jv1TBVCFpn
 s8Md0Rf8RoG+c9WR8DLvMC62Y7130B7VMq9w2eLyAeh9Mhreg9ArLTExTD6YiCTc93
 BA7oieOs/WJJtJ9WJalM1PURedKJJbJeinMJ9nS6Z+3DMWMdKQCJFmj1QbG3jhbUym
 Yw2USkqWSMYog==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so25648455e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252781; x=1745857581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKpWjZhgrEkeT+ygG3UT8V1qxeF62P5zEGd9aoawBGc=;
 b=AXLdo6I9g+aav0A7lWYxZ7iq6ekjCecOeTK+zqODqNymxMGFJQXFW7Bs1QB03Ja1v6
 wr2X9tT3ixUHCQrwTxq1BHNNy/gsOLlE2WjvplI5GBFpjCD5xDoUYh9iYMGWjqIwBDtB
 YeT8LqYCXVVjMQz2wCyTNBVcx9YMUg4bBAyafXw/N3RaG3sfmMN8Jmo2LSAqdY6s21uX
 mLaX12c9TP3iVKR6IwHMAMbJfaSUy02THxFDr6Ue84wSLx9Re58W+/LUdsZ9ARMhcr2L
 xk3LqFMLBqeSFPhAdYOUr5o5hU/hU0DlSiKqgsoViR2x1mu+y1ja+GuVZtbcF/0DLlOr
 ujlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaaYO1ERnyYEZYCUXnwDv5m/8/2W+w+fByiyY364G6yC0W8A6f9f8FEGq1O5qDbc3pr9ZzZAY=@lists.denx.de
X-Gm-Message-State: AOJu0YzMGlRx8F2m4jkXuE4mHOSkIFbqf9HVHOlvS49oQG0EPA4iiX6V
 vGhiS/pE/j4lw7OFftv45IymETmlfdcrNlDfQldExoRg8h8YuQAxX1iO2R5kIWKjjdpXgS38HXG
 NrYiSUcSGQ2e7tCnxtmLtwpDI96YpnMHhVCRsPlQHk4d18x8GmUeeFelBM0263QCxFPM=
X-Gm-Gg: ASbGnctHaXQQ0RtsbULN2ev3GrF9eqw6FHtA7orm+YqE4AuObzd8ZK6bB0GaaELekiX
 FO5Jl3dzTFAcXuFoXolrzMkm5grzCFWUILUcXdsVOI3LpWdxbcZJ4twY/t11hT4inPJtqRSIjG6
 qXTOR3b+KxW8okKAVbibstNABHU5d23fG1gnGTlTEnGV/TNEPCQxurycWD2RAP2FRthDh5OoBiZ
 42P2iZf3Lb8CKSV39Gm6XMcEvV0hm8LAgeK4ZvWGL7zoCNhagaYlP7KKQ4GgzimGuBMhvswsnwC
 Obn1aDs8NOPVzMmKttk0Z8niAgEWW6R9u3GgU9bf3ZN8059yRs7rzVeG06UiyciFUERmHzMjvRc
 mYIEuxHD04ly5JQ==
X-Received: by 2002:a05:600c:54ed:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4406def1692mr78466415e9.11.1745252781579; 
 Mon, 21 Apr 2025 09:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI0XIfViKZnZ9yH+Vb7BdEAks4C8BwpOK34O219F1hpHkOcwz9+zBmerWYRGpfuc1kZ9zfqQ==
X-Received: by 2002:a05:600c:54ed:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4406def1692mr78466185e9.11.1745252781049; 
 Mon, 21 Apr 2025 09:26:21 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:20 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 4/8] boot: introduce BOOTDEVP_6_EFI
Date: Mon, 21 Apr 2025 18:25:51 +0200
Message-ID: <20250421162555.1200687-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

The EFI boot manager requires access to all block devices and to network.
So hunting of bootdevs must have been completed. It does not require
DHCP to have completed. So priority-wise it fits best after all bootdevs
except for the 'dummy' network boot devices used for PXE booting.

Create a new bootdev priority for the EFI boot manager which is sorted
after all other bootdevs except network.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/bootdev.h | 10 ++++++----
 net/eth_bootdev.c |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/bootdev.h b/include/bootdev.h
index 12c90c4ec1b..6f46451da73 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -36,9 +36,10 @@ struct udevice;
  * @BOOTDEVP_5_SCAN_SLOW: Extenal devices which need scanning or bus
  * enumeration to find. The enumeration takes significant fraction of a second
  * to complete
- * @BOOTDEVP_6_NET_BASE: Basic network devices which are quickly and easily
+ * @BOOTDEVP_6_EFI: EFI boot manager
+ * @BOOTDEVP_7_NET_BASE: Basic network devices which are quickly and easily
  * available. Typically used for an internal Ethernet device
- * @BOOTDEVP_7_NET_FALLBACK: Secondary network devices which require extra time
+ * @BOOTDEVP_8_NET_FALLBACK: Secondary network devices which require extra time
  * to start up, or are less desirable. Typically used for secondary Ethernet
  * devices. Note that USB ethernet devices are found during USB enumeration,
  * so do not use this priority
@@ -50,8 +51,9 @@ enum bootdev_prio_t {
 	BOOTDEVP_3_INTERNAL_SLOW,
 	BOOTDEVP_4_SCAN_FAST,
 	BOOTDEVP_5_SCAN_SLOW,
-	BOOTDEVP_6_NET_BASE,
-	BOOTDEVP_7_NET_FALLBACK,
+	BOOTDEVP_6_EFI,
+	BOOTDEVP_7_NET_BASE,
+	BOOTDEVP_8_NET_FALLBACK,
 
 	BOOTDEVP_COUNT,
 };
diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index b0fca6e8313..dd071853886 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -59,7 +59,7 @@ static int eth_bootdev_bind(struct udevice *dev)
 {
 	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
 
-	ucp->prio = BOOTDEVP_6_NET_BASE;
+	ucp->prio = BOOTDEVP_7_NET_BASE;
 
 	return 0;
 }
@@ -117,7 +117,7 @@ U_BOOT_DRIVER(eth_bootdev) = {
 };
 
 BOOTDEV_HUNTER(eth_bootdev_hunt) = {
-	.prio		= BOOTDEVP_6_NET_BASE,
+	.prio		= BOOTDEVP_7_NET_BASE,
 	.uclass		= UCLASS_ETH,
 	.hunt		= eth_bootdev_hunt,
 	.drv		= DM_DRIVER_REF(eth_bootdev),
-- 
2.48.1

