Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08285CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D48D84707;
	Wed, 20 May 2026 00:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="gSU5IXam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CD184852; Wed, 20 May 2026 00:48:05 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AA2846EC
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso2460531a91.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230880; x=1779835680;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P75McgSA3JkXVyYilmjW/tXmGi2z/dzntTcBL3lZvjM=;
 b=gSU5IXamwwtuulHU9MaZBGhnu5JdXGj4MWJkW+kBwp4F1nXsXniiTEbb+Loj3pGGj+
 NbeOJDQl06VKvQfAdHiPQZ14Xe7A9dBxkcJQleOQBJ5j/MGFSJJFa+kjRBCQFmn81Ff8
 j0gbohydShhHHDiISyMZZOPexz25Cs5SO0zirOvJUf3bulvSqp6/wKBKr2TYdaYnm8yN
 +rrPAV9t+TH2iDqr9YiWQ/16qFxs+W92CJOexPvgyXXkjwXUI91e8pE+xAEvUOxxvH21
 81QO83z3SuCDC/XLBQuZ4TAeC3wFjj9K8v6R2OXjBFmN57YKGkxE/TdDUf+132/615v0
 qBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230880; x=1779835680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P75McgSA3JkXVyYilmjW/tXmGi2z/dzntTcBL3lZvjM=;
 b=HxVctQXxXryceJaehRb1OfsLussK1wF54ltv+JVJ5R/ql2TNZb2wMJzFN/IeScVUJ5
 RycamltQ9LBDbPhrhY0Yi4TwVgvTMsbZahZFZtQrTHnGJSDfFrP83+7pbcfYjSzOUctH
 zc0ixRFc8gZ5GzkVb90mbzPiy99arogYb1lHd5Dg4WGcGDkXNu3tBwk5UxDiB4Xxt43A
 NgHrgTlPVhpCVbNmf7Oqecr6+O+NJbNlv54S5KIuqwPTikSbY4HCB3X3/mnNTczTtXWl
 uRWaWTDJiPrlXUWv6sB493XBgmjATzHSE3+f2fHWgi+7IvXi2vNUw3I6MKLjnqNzDVtn
 Ag3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mAaYGxo6obbGM8JzUBjjND4LaScVvR2ntCE+Vd09LRmOG6l3PnRE+207Wi4sE+7P9M1bVNvE=@lists.denx.de
X-Gm-Message-State: AOJu0YxQB7SUvtbCFiRZoEwZqv5EfTOK1HQNaSE9LNcA2u6I4whsSiAz
 b3t/nS6eS19gm+NgtstSlNL0HfpfkQJMv6O3UNKi+CizecDQoWM7Z8XokXf4yYrQT7g=
X-Gm-Gg: Acq92OEdTwuKOrwqUQU2IITXjNvT3hS/fzuB13T3VMh9r7/tstUJdJPxIPxjSewEqF1
 92Z5LuTMerdYvHsoeUr20S+B5bMEpw9Hyz0nsYiWRuMm1vvSuVZFjm/oOzy9X/vtVfYmKuMfSUn
 kH5CLzWXOEK/KnpKFC9IpZd4VxU6+q3LRhKPLAveZ7gFz3T2AIJGB6/G/R4HFdaDIA+nUioNdoO
 q6xLpjBh7nIT1GUmvJYQZzB1sO0rFGy7HO7TpJrN3jCGDlwZ3zb7lWfBoRRMRpp1wYBVfrJI/VA
 UE6V6WZ8vQcBvZzSx0qLX6zXUFP4s9+Ya+Z9FzcFUYkAFMnismMd33mPWu8C/1fks1WzG6/r9So
 3vD7d46u2N/Yh5nAxCQq3ZMT6pmZAwHtMwQrSTBDfi9ceUo+pOFJBmr7eOdawiMs75RFA5rNgR1
 SUaxiAuhAuoeaW8ARB/XGVsf4BZnhSebmVYLcRDXIU3vceGZFd0AGF381ZWYuo26MJ
X-Received: by 2002:a17:90b:1c0f:b0:366:4782:139a with SMTP id
 98e67ed59e1d1-36951a6c339mr20312280a91.17.1779230879995; 
 Tue, 19 May 2026 15:47:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:47:59 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:47 -0400
Subject: [PATCH v2 3/9] spi: fsl: add support for Spacemit K1 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-3-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Make FSL QSPI driver supporting Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- No change.
---
 drivers/spi/fsl_qspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 65ab3e306d7..5692510a558 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -267,6 +267,14 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_128,
+	.quirks = QUADSPI_QUIRK_TKT253890,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -870,6 +878,7 @@ static const struct udevice_id fsl_qspi_ids[] = {
 	{ .compatible = "fsl,ls1021a-qspi", .data = (ulong)&ls1021a_data, },
 	{ .compatible = "fsl,ls1088a-qspi", .data = (ulong)&ls2080a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = (ulong)&ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = (ulong)&spacemit_k1_data, },
 	{ }
 };
 

-- 
2.43.0

