Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D05C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF1383046;
	Mon,  7 Jul 2025 12:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751883892;
	bh=peBo9b18pwWtHDlJc65ZTnmCPq0pdU2RxD0gWnG7xWs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HnxlHQMAN41OmK9f1ZJb7W3FY9vFUvfVWMW6ftJvGw1FytWFTFe9SmG5Jpg0YBNhl
	 XmzHNjefsrglGE82XPgsHZx3CPdyb2lAR4KJlxq3j7vYRnwtA5gn2PEsTZiNMARbFX
	 Ti6OvFlKee7e8YpQX7dH3NhI5ld+b0Q4niIyD5434HngBeRRy1qKxF5zvVdZjt4IvH
	 U5UieJPfvvEA3bAJuAtuFbLAgTPxRCKVpJY8F9rIRET/allRZy6JXX+RYb8L+T5RFU
	 vNwfxIIhnjzzn3byDCB1DrArEnGrf4O8iDSBkeYEDuJAKnlRQjmSEZMkq8Gh/5yT26
	 IYSe7cLPLxdNQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8BB8304D; Mon,  7 Jul 2025 12:24:51 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD7C83043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EFgtUpn7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C203610380104; 
 Mon,  7 Jul 2025 12:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751883888; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=peBo9b18pwWtHDlJc65ZTnmCPq0pdU2RxD0gWnG7xWs=;
 b=EFgtUpn7+ux9TAgduBIDbKIlJGEQo1zg5cW1Tom+1ao9byBwM0t2FB0okGQqG+pnz8AZsc
 7lPB3978KL6ZbI0lNVvVNw5coLfdqMDOftTYva12xflJL+SOKGSmBxBrkek++rOtIAfMkq
 Ez8qECsWmGao1x2k4XeiOXoVaNxtjW0UVj8yI+tg9qbybobkNHj6wjy8U/D1OMbB6ctESC
 yctxJf2XceD73h6sAkRZJijIZ+I5CyoMjZf9SYGyLTUCMj7LO13SxzUF4CFruHJooRmdZV
 FFWhkl5iut4WrFRJJ+gEtXQjsNqunIDilw7Ms5I8+auR8x+7YYVb0mqNq8ZvvQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: marex@denx.de, trini@konsulko.com, andrew.goodbody@linaro.org,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 1/1] usb: Fix usb_control_msg() error path
Date: Mon,  7 Jul 2025 12:24:30 +0200
Message-Id: <20250707102430.18125-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

As pointed out in [1], there is a logic error in the -ETIMEDOUT return
path.

The while() condition evaluates false, when timeout is 0. Postfix
decrement makes it -1. Adapt the if statement accordingly.

Fixes: 2fc8638403c (usb: Assimilate usb_get_descriptor() to linux)
Signed-off-by: Philip Oberfichtner <pro@denx.de>

[1] https://lore.kernel.org/u-boot/caa9932c-c5dd-46d6-a5ae-120238300a73@linaro.org/
---
 common/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 7a8435296c6..266339e4897 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -258,7 +258,7 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 		mdelay(1);
 	}
 
-	if (timeout == 0)
+	if (timeout == -1)
 		return -ETIMEDOUT;
 
 	if (dev->status)
-- 
2.39.5

