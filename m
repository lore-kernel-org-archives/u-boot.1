Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9942ACEFC5D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F2C87FED;
	Wed,  9 Oct 2024 11:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QJyXbJnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E073881A9; Wed,  9 Oct 2024 11:42:26 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF7780245
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso67767065e9.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728466943; x=1729071743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ilqpHsBxbHye/jJ6HOiNqrfaCIRv7uCQGAIV2shCU+4=;
 b=QJyXbJnHxz8RVqC5l9F6opft8nGae5bZOiBxjfn26tR9GOfAFd0LgG3XycXZDy2LLt
 T9IaVTlHo+GO46Ko7Rtq+1xcEE+u1nw/zklgrIk3o/NOA8vS+FrkeXsaHW2Zacdlcac5
 daHQnaDsKLZHlDvtz/NpNWsZ97pZN1E0Xa/vciN+ctuaCKSDmH8iOjygExi7lFr9jAd0
 Us7il9q5xv4ap+3rQi75bPGpSD08Nez7dOppIXfhZ+zWLu1aXSLZjwOHMKIYRcT5WoDy
 1y3dcUQ6mVVofsNwbPc8Kjmo63ioU80gAASRPR5jBz9EOOYnhThi4ul8V45yiQ+gYS8n
 B2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728466943; x=1729071743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilqpHsBxbHye/jJ6HOiNqrfaCIRv7uCQGAIV2shCU+4=;
 b=IKdStc/6elhReho4HK38ahX6KhmeO/oThqT0f01seXD6IRnXuw5n4lVwGwXFs4Gmgx
 zjzhqO8UuC2ZttfgIveGnxLvyJlf8GmUPgy3xaogEbggKX+aCDjAZt4Ft1eoZGe5SD0j
 OA0vD7HGweCbRBStjwGZc8K1dNfEplPhECvI5GSP0I/J2g4K+RfNrkRaHAw4U4nCz8wl
 Q2TUWmre/F5ChSuMCGfPv2cAi1ZUqO2LMIH5nmZj8mFKWSHHKh6jFBxl6fGnNV3/1pLC
 VeQbaBTpw1e7KlbgjSvl0YLMSSpTFlOFsdLgMaMWi5QdfDEujWF2/bMweQ+jtDarRf4T
 HP4g==
X-Gm-Message-State: AOJu0Yw3OTAObYMawb29vXL4vVC9wDqP13fizJfFzoEBn9ZdRYgvGW+Z
 quX6cQCZyDHRi/vlpTYfk8qx5WeZp8QiMBhe7oUQoLjo1wMFvEpQMHVkC5SIEaAxdKlXkwfvmxa
 M4OjDSA==
X-Google-Smtp-Source: AGHT+IF6Tf+am2VrJ67J47fde32xcr8+wXbr2iC60douPsHGDbL6j8WFwLd+LUbD+ktZOMr4A6xkUg==
X-Received: by 2002:a05:600c:384c:b0:42b:8a35:1acf with SMTP id
 5b1f17b1804b1-430d59b77bbmr14672665e9.25.1728466943383; 
 Wed, 09 Oct 2024 02:42:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691a47esm9943409f8f.28.2024.10.09.02.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:42:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH v2] net: recv(): return -EAGAIN instead of 0 when no cleanup
 is expected
Date: Wed,  9 Oct 2024 11:42:08 +0200
Message-Id: <20241009094208.1212555-1-jerome.forissier@linaro.org>
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

Some drivers do not behave properly when free_pkt() is called with a
length of zero. It is an issue I observed when developing the lwIP
series [1] (see "QEMU CI tests for r2dplus_i82557c, r2dplus_rtl8139"
in the change log) and which I fixed incorrectly by not calling
free_pkt() when recv() returns 0. That turned out to be wrong for two
reasons:

1. The DM documentation [2] clearly requires it:

  "The **recv** function polls for availability of a new packet. [...]
   If there is an error [...], return 0 if you require the packet to
   be cleaned up normally, or a negative error code otherwise (cleanup
   not necessary or already done).

   If **free_pkt** is defined, U-Boot will call it after a received
   packet has been processed [...]. free_pkt() will be called after
   recv(), for the same packet [...]"

2. The imx8mp_evk platform will fail with OOM errors if free_pkt() is
   not called after recv() returns 0:

   u-boot=> tftp 192.168.0.16:50M
   Using ethernet@30be0000 device
   TFTP from server 192.168.0.16; our IP address is 192.168.0.48
   Filename '50M'.
   Load address: 0x40480000
   Loading: #######################fecmxc_recv: error allocating packetp
   fecmxc_recv: error allocating packetp
   fecmxc_recv: error allocating packetp
   ...

Therefore, make recv() return -EAGAIN instead of 0 when no packet is
available and the driver doesn't expect free_pkt() to be called
subsequently.

[1] https://lists.denx.de/pipermail/u-boot/2024-August/562861.html
[2] doc/develop/driver-model/ethernet.rst

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/net/eepro100.c | 2 +-
 drivers/net/rtl8139.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index d18a8d577ca..f64dbb7d6a1 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -678,7 +678,7 @@ static int eepro100_recv_common(struct eepro100_priv *priv, uchar **packetp)
 	status = le16_to_cpu(desc->status);
 
 	if (!(status & RFD_STATUS_C))
-		return 0;
+		return -EAGAIN;
 
 	/* Valid frame status. */
 	if (status & RFD_STATUS_OK) {
diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 2e0afad089f..5f4b1e2d3a0 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -433,7 +433,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
 	int length = 0;
 
 	if (inb(priv->ioaddr + RTL_REG_CHIPCMD) & RTL_REG_CHIPCMD_RXBUFEMPTY)
-		return 0;
+		return -EAGAIN;
 
 	priv->rxstatus = inw(priv->ioaddr + RTL_REG_INTRSTATUS);
 	/* See below for the rest of the interrupt acknowledges.  */
-- 
2.40.1

