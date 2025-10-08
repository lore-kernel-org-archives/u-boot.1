Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D45CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19B1839DE;
	Wed,  8 Oct 2025 17:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b+zxxIm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D508401A; Wed,  8 Oct 2025 17:01:53 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA789839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7bc626c5461so2494470a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759935710; x=1760540510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DnsFaaD3/imZvQI6OaQzN8f6FCkECK9+LifZurrAosk=;
 b=b+zxxIm/hyBgFQR74yrrPCJx5it0KNM8v0OPltx1nfEL1xSdYv16/OVJVt8DZU3Z6Z
 TGi056ICMBceXwTK6mchqC/jkUCbA7A8dxM/pe5oMzTCJxfYvqIunSQqjyBYd4qFrD1w
 YXwiRE71gKSQqswq4/RRYgocLBypI+ho+mR9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935710; x=1760540510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnsFaaD3/imZvQI6OaQzN8f6FCkECK9+LifZurrAosk=;
 b=XEogLmP0yCVrv5Eg9ALsuEAInFJUAT/34rCOHPnDBIhAFeKO+0MIqmMd8IIW50K4PI
 0RUZ2I6rrYafm3HtUHkkya51whcZ9ZRY+LBZuX5fwr6FhHMPdchfF2FHWwt03iUwcQ9w
 sfwgsnjh4PfFx47Hl9aGGHywxRvCAKKxPzHy6JdN9P+MWxCpMQEvMTz4b5dfSmFnhTmA
 EHyk7tID1FK8Jcwc9IfwNR8Zbfwxh1nw+HTBk8FuknF2QO74xCbisv+IQ90JkxajSD8k
 u8vYSHfP7aZovWjSbbSCDlH4v+4Y7Zq0X5HPbeqCwgztTCZRpr3sCsu/i05sJyyRBsPA
 sI7g==
X-Gm-Message-State: AOJu0YwOc0rQAtrz06h+AXtwk532GqLxbOgeKfbwxRGmknz0BuddZFng
 KMdyrzIp3hWdTh04iee0/4yT03I2uRqTxy5yrvYwQ2Vu+/AW0voe+syKDNne357KuLDM3+6uvOk
 bUGj6L5U=
X-Gm-Gg: ASbGncuvZXPAagw5lU+gwGmr6zkEvu6nA4iku2bIYHO9M7yxxnCZWcbr2Q0rbmCh9ib
 DA+zPxLD7POh7bnIKGVG4nTZDCXVYn7gCQK2sT6VUV4xaznkXobz/w4QujFzHVC2RNqk3P04k5U
 1w4J9vhfXuCmXjpxlmEgf75d9oCI4TPRuL555/GgYAKvarGpWMWwGldjunvzyD7lkG8oYgXmDCB
 Vxfn3yMgSL8mhNQVIsEjOitQpo7nui12T/sdohaMql7AMUPwEpJ6P5vTe2/W2VlpeCtbgkNltGU
 QRrcww+8vWLDs/T3xNOLwXa48kirmp272xpWHiO6JhgIT/kJnL2pwnD7ltYAsDDUCQon+z2RaBP
 0hvycjD1MaEmBHz24MJyNL7IVFiPytfHCUrTfeCsMo4qIqI7CoSAOSgSZwWxj96PJL//QBiV0p9
 Wd75q0CQ3fTaVjjTjn/hpRjL4=
X-Google-Smtp-Source: AGHT+IHZC3lPhr/8E8Iya893chthIf2Mr1x0E/9qVCywYemkZfUMD4YhhKpFbTiizEKWSkz0yLTV8A==
X-Received: by 2002:a05:6830:71a4:b0:7bf:75e6:5ba with SMTP id
 46e09a7af769-7c0df785687mr2848457a34.15.1759935710370; 
 Wed, 08 Oct 2025 08:01:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf89b23009sm3720166a34.20.2025.10.08.08.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:01:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2] net: dwc_eth_ops: Correct check for FDT_64BIT
Date: Wed,  8 Oct 2025 09:01:48 -0600
Message-ID: <20251008150148.1859420-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There is no xPL_FDT_64BIT symbol and it would furthermore not likely
make sense for there to be one. Correct this check to use
IS_ENABLED and not CONFIG_IS_ENABLED.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Fix the commit message per Jerome

Cc: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/dwc_eth_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 551ee0ea6a02..a098916a674b 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1411,7 +1411,7 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
 	struct eqos_priv *eqos = dev_get_priv(dev);
 
 	if (addr == FDT_ADDR_T_NONE) {
-#if CONFIG_IS_ENABLED(FDT_64BIT)
+#if IS_ENABLED(CONFIG_FDT_64BIT)
 		dev_err(dev, "addr=0x%llx is invalid.\n", addr);
 #else
 		dev_err(dev, "addr=0x%x is invalid.\n", addr);
-- 
2.43.0

