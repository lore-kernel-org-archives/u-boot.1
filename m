Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8297CDD1B4
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 14:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341048908D;
	Fri, 27 Sep 2024 16:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="estZCF5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6F989118; Fri, 27 Sep 2024 16:21:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E31EB89089
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 16:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so19949625e9.1
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727446868; x=1728051668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0PQ8mdgcWYVRRv6jxACxtL/2tG+VZYVk9kmK1RJhnY=;
 b=estZCF5AgmjfNV9c571XM+GdchUEV7BmEcgkjNCltAN7RHNDjw25PKM24+uNq7Mpwm
 /CDVKc+0Oc+st50hpz882KIf+OG0IREPYSTxAfg70qLjkG13GKVc2Bsei302zF7oLd3i
 dUpBCBZf12ID/EVPIklzkt9M0gRK1i+i/kptvdC0FHiknbWS3XMEA/mIgEyunH9/NzxV
 u/L/12MZxv6IJ6WmIBjRe1/XmqqGQpNiXXaAnn2u0MxZR9Za/+xRm6UzagEVjf632GtT
 j5/zW7PK/3tsiY1nMuuQjUwYXQVOnsQD2HAUsQcW6NtWYtFJRjsr+Btxu0GRWC/l1aR4
 FyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727446868; x=1728051668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0PQ8mdgcWYVRRv6jxACxtL/2tG+VZYVk9kmK1RJhnY=;
 b=qHNVw2C94I4Un+3bGQZd2vUnOCjaOWs8Oecj/eMtMI8MAzxPLTrdYseVcCgRsxtsS8
 v6j40XrEpvKfNs4txe0i05WIblQIjRjm5NRSzQNnDIMzxNZSJKLUYyEkYcdgxGjowP4q
 ukxVL9t1FtLyI/oqGdeGP2t5hKVuD2OHuLbiJfkI2N86TTY1oEhhHi3nW9MjQGfaWu3N
 jQrCZbMFofvTq8vKKwh/bcCQwidpSnOK1puuah8DH9/chc0PQSsKhVMjkyTmEcATO5h5
 8muNqXCM56uTSfmbzzphxmaXBOimSXKdwmf0lK2Y1aEofQox4P2oH+mBKchmqoKKM5uK
 Bdmg==
X-Gm-Message-State: AOJu0YzA2doj5w5ajHjzSQsblcMOVoPXr9eRh6wcC9ru3NLAB2tCLPFm
 EVewh5MzVCyFLMsA8bgWJB6/WOjRLIMV3K1SfHlsPdTyoV5Jz7DhUInq99oMvyzqBzw942Y5+sc
 CQ70gtw==
X-Google-Smtp-Source: AGHT+IF/Nzj81qpvYna3xQTAY9CBCCYem03HUjjTMjTCYYIo/lPrFOYebn82gaYoST0R0ylAR2HJpg==
X-Received: by 2002:adf:ce84:0:b0:374:baeb:2ec with SMTP id
 ffacd0b85a97d-37cd5a9756emr2365651f8f.19.1727446867925; 
 Fri, 27 Sep 2024 07:21:07 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9128:5ed2:3d17:2f26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565e881sm2670410f8f.44.2024.09.27.07.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 07:21:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] net: recv(): return -EAGAIN instead of 0 when no cleanup is
 expected
Date: Fri, 27 Sep 2024 16:20:37 +0200
Message-Id: <20240927142038.879037-1-jerome.forissier@linaro.org>
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

