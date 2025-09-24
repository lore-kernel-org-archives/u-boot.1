Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A7CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 01:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EA983448;
	Wed, 24 Sep 2025 03:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aTmWhGAB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CDMC8x4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C29833E9; Wed, 24 Sep 2025 03:47:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3429F833ED
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 03:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWfqt07Lbz9tKf;
 Wed, 24 Sep 2025 03:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4VnQf4ysrTKc9x8xzSbuc7SuSozExZI/LqAPv/aBcM=;
 b=aTmWhGABDpxnvB/yNduUinCba8ImKsPLhNHzwecd6AKmYMUuyStTgLNk6Sne/0d4LhNTyp
 0rbYUNGUliJteBVvJ2Jj2BrAI5MLI8gOuFKyeT1BbqNRvrMXOmqzH9cgACPlXYNHe7WfjX
 G9ICZeDq2ns4bIamnP4sbCfICr4M0aL8UI4Z7rJ/RQgbPDzcNd/xiaHo3V7k0i6ioZu5gX
 xtTvSlu/7s+ygMhumKAO/+x8+TO+phPrnK5+lOfYGOgDn2YuojPn9dF/DNTdaO3IEjowxb
 fGfrlLw0maPCi7k1goEfRludiXyxmcxc596o37TI8Lbjy08s91AirIa7xunlpQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CDMC8x4N;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4VnQf4ysrTKc9x8xzSbuc7SuSozExZI/LqAPv/aBcM=;
 b=CDMC8x4NpfHG48l+iH7Q2rHQ4lqaZ5tLY19Z0YnKSY83WrEMtLLpuAkEvELEwqjhMco0My
 12rqKR0+DmiEd9pCYyFWpvEL5RWUDQDMxmLVIm2vgMq9aOqis8OUcYuEQNnpzgOUrfBD8t
 TfWko/QO1TRHWQGKsFCzMdUV6cOWBv/L4vaf7NDXYkd2BxEe6PA+MMUS1++wvAX2V5zkXK
 lPwtzL0tvw23F6GsDpgjxd33/qaW9ejHhBHO7dNnjrHUmVgd1Wsc2xW9PFkIJe84JB7BTc
 dw8hmkABdLqqAGhPhddrKPkmKp1y5gzRUK2da5VbTrsKirI0jh3QflZMOUV4yQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] pci: pcie-rcar-gen4: Add missing 1ms delay after PWR
 reset assertion
Date: Wed, 24 Sep 2025 03:47:14 +0200
Message-ID: <20250924014730.120800-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250924014730.120800-1-marek.vasut+renesas@mailbox.org>
References: <20250924014730.120800-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a779prps7wsjf3c9eyh41iagm9ickbwr
X-MBO-RS-ID: 85355a53103e40b7141
X-Rspamd-Queue-Id: 4cWfqt07Lbz9tKf
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

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
domain, after reset has been asserted by writing a matching reset bit into
register SRCR, it is mandatory to wait 1ms.

Because it is the controller driver which can determine whether or not the
controller is in HSC domain based on its compatible string, add the missing
delay into the controller driver.

This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
whether S4 is affected as well. This patch does apply the extra delay on
R-Car S4 as well.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 74aa75d2927..30fd1300da8 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -308,6 +308,8 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	if (ret)
 		goto err_unprepare;
 
+	mdelay(1);
+
 	setbits_le32(rcar->app_base + PCIEMSR0,
 		     DEVICE_TYPE_RC |
 		     ((rcar->num_lanes < 4) ? BIFUR_MOD_SET_ON : 0));
-- 
2.51.0

