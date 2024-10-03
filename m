Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADBCCF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B582188E4A;
	Thu,  3 Oct 2024 17:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BMyXso8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C189988D9F; Thu,  3 Oct 2024 17:23:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C1B88DE9
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cfa129074so864104f8f.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969019; x=1728573819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPYJafKN3Kt/xHB/DNZ6P2xS+0mBigy9jMHqZFqQF8Q=;
 b=BMyXso8IT/TFgVYeck/qsxasL8CapTw405LOxdkZYIBB+sUSdbfMk+s+7ZrH1udXJ0
 bwIGxcxRZUBcPUPlUqn35m6ccCc392oa1REJp1rCMh5DI+yD8saGlma/PXV6XxoXcTV4
 R9hdYBPlmINHiMweGnAsfQnJzvLa7TM74C7mYpz/NkKiAlDwx+AFtVN6YfL88NvwdlIS
 sxxZhZiAzwwKgt59dACpvE/mns4/NJTpDHatj5legbEJ1JGP+bQkw2Y6dckwDRtRGmOl
 ljQx6d6bvZyVdvvh7+vkU46lqBzCcGrjq3TAnE3ANJnNl6LNAutzXp9hxN6W1OnhoB1Z
 icVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969019; x=1728573819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPYJafKN3Kt/xHB/DNZ6P2xS+0mBigy9jMHqZFqQF8Q=;
 b=iJU925H9kQfT40irShDkJTZgMZTKyCp9s+LCf54UngQp2tACSvIImUlT1rQcwvPYks
 6VwACq8x+PzjX8I1MfUB3GmuhtZoF8wh12edZcYKUJC+mHKr2mjyLVsdgfFRe2e+Zf0H
 mslNXnh0lofZ1tUB6GkYDR/2rnrr7zJfAItN7UF3PyqPpq9+nIZpTv/lH8ELmayhOHI/
 OOqLoL1CsufoMsElHNrlVWi8i7DKgEiR4HGuFiKywOBKSg8ssZzM4zfonsmsi8eDdgg1
 9LvFRsYV0hxQV60DLfYFmYgxbXBNm+WOuxJc0hH/slYr7CAVXlB104VZewHRhZkuszXW
 x7rw==
X-Gm-Message-State: AOJu0YzfwqVr9BMpCO7EkkZoK7yDC3kJ3pQjoyJrJ3FSHFK9sAjWQAqb
 x26PhfZZXkkwTKMDpHSc65CsGGmAg5VbgDbi6zBjvS/bASP9b1en/CBtY7jl82v8ijLQiKMeJrz
 1bAT0Rg==
X-Google-Smtp-Source: AGHT+IG2ZN8p6pXRdgL3NfJ/KuD46y27XxKiSzvL2eIs0c1VQuPVH8NjDiupS4ZwwY24kYdOzFiZfw==
X-Received: by 2002:a05:6000:10c7:b0:37c:d512:d427 with SMTP id
 ffacd0b85a97d-37cfb9ddfc2mr4654329f8f.35.1727969018667; 
 Thu, 03 Oct 2024 08:23:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:38 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v11 01/29] net: recv(): return -EAGAIN instead of 0 when no
 cleanup is expected
Date: Thu,  3 Oct 2024 17:22:47 +0200
Message-Id: <f980100c26995da542aff85bf89788e19aceb7b6.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Note: patch posted separately [0].

[0] http://patchwork.ozlabs.org/project/uboot/patch/20240927142038.879037-1-jerome.forissier@linaro.org/

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

Therefore, make recv() return -EINVAL instead of 0 when no packet is
available and the driver doesn't expect free_pkt() to be called
subsequently.

[1] https://lists.denx.de/pipermail/u-boot/2024-August/562861.html
[2] doc/develop/driver-model/ethernet.rst

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
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

