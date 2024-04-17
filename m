Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62785C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 08:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C1D8842A;
	Wed, 17 Apr 2024 10:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=epsi@gmx.de header.b="MBpyNegB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBFC88440; Wed, 17 Apr 2024 10:41:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C950588414
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=epsi@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713343293; x=1713948093; i=epsi@gmx.de;
 bh=VU38Hg+lkR6rToYg/nGPRoYEOC13rPv7b4Kv9BB0Gjc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MBpyNegBbD/hbxpvq78X/2lDJFFsMkGhRvCGDISGEH/oNYpVwwhlbXCADe69UOuz
 MwNHnxnXsDvMpk9MD0yKOC/xU6CRZdkg+Laf1Wes1SMdKjhjCQAffswI19O19N9E3
 qyUa9gcy2gKeMxeq8FfmwGrhEGNPwysjsN2Fq8Alkc68WkRgGEDmE+3IhNT3WvDja
 xuEdCUZwzq97s8A4CXvvT93oSRCxhr0iAdCXvl1vax4sFN9Wyh4fZ+yuzeil4KMcp
 kpPCHBG0MvjjXJtNUOBe9emcGB74cXURoIroQYj5SElfCwmtA/Lqmoyi92dKcUU0H
 CsVH4yEKpa0teC+JMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.3.21] ([217.225.83.13]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1sMxix3HoQ-00R2yv; Wed, 17
 Apr 2024 10:41:33 +0200
Message-ID: <5cf38ecf-f02c-4219-90e8-aceccf558b43@gmx.de>
Date: Wed, 17 Apr 2024 10:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [Patch] dwc_eth_qos: Revert regression handling fixed phy
From: Nicole Battenfeld <epsi@gmx.de>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Ramon Fried <rfried.dev@gmail.com>
References: <31a9f868-8f5f-2938-a22d-39a2695adba2@gmx.de>
 <31252563-cfe1-343b-cf29-31c374e5287e@denx.de>
 <b94139ba-2135-5f48-aa26-c2b301d13e46@gmx.de>
Content-Language: en-US
In-Reply-To: <b94139ba-2135-5f48-aa26-c2b301d13e46@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Pn0hHLTW0W3CTa2Ku3JEqoOS4NGuAFbxwsZvzV6O8Q7juN8K0S4
 3DxFudWF2sKvjJQphWGTEdl0A3wM7VcP0fJ+4YrFWDGds7PIMun9X0LDo59yAMmFU6qV7QB
 0tgIGfx+7uPRjLKH3BHEjakXAsNh8mZx//OTi284I4QyrdNGZ1uszR4cV9Dv/nF5gT/YC9K
 JwPtDyZbThMrrhaTFuFMg==
UI-OutboundReport: notjunk:1;M01:P0:AJRcZEvhf58=;15esjrpFmdHSl3NItiMkXcE/uAY
 8e2xLkXd3G+cEyQbYF7TgFmi51BRnFXQEEf/jVQ6q8zAh/Cb8PZkiSzf5Mcwc2t0ZSaJcuRqs
 4AA/CTA+/XbrnrnvJJuy1dz/lkO1vCW11r+DiODt3nFVyeLPfLLDr+Z/5Wk2/huPoeVJRdtFx
 28OboOi9HMM2UqMD8blfWoWLG2DVdUN8Z/Spr/+bScbpYP+bohw34AL2F+/THUijgErJcVfUX
 EC54hFqxgBdrrhPVD1DZlT+B3PvO9clmPzzGevjnKLliyT4twPVu3P7j01l5AyfXP0vRV0Z5e
 RcAkatGICSg7qcAgSo9Of2O83EFN5ZNbamTknO5IjHzdN3oL8lOFhtnBMOzp+GUYcXTivtQK1
 YtsgLxpJCodKTEPFjUB3yPs0sSmjG2ODazq2N9dTLmauxoOQ89chPSEUidf7SoJfMyj3Ebu2U
 jX1fEyAEuFzzkzwGftZlAWs4l75x0tYBuwOWUYnXK8GnILeLY9QocZionl7IEDtvypLCXJ7AE
 SEsuGz4+28izQmygOOjcXKxB55LX4KcEe2gWzE9hfx56v0UW0uSe/9CNEiSZyE5/krgU61lKF
 SBSDkBKbOBYGcyK6AYxlU0w9mtTH4UNHaC9mNbFNQh0uwLVLYsGHgjnwnzkbjCp8C1QQymMSL
 3pDOnOyyZE+xYG3etDXC8rzH0BPIohIO2SIsiL9jn3hbmyZkFFf7s/iATRNMgSABEByPTfyq7
 c416L+Tkz1VyzWhwQk3gFVe+2uDkdUy6EMGwHxqz1Ml7qFnBiTHGu0rdSzjCDzOCuRRKA8D+l
 q6P0nWM0PP+rc9czx7u0OGGR1iZl1yvtWNQNNqAJCnDAU=
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

Subject: [PATCH] dwc_eth_qos: Revert regression handling fixed phy

In imx8mp operation on eqos with fixed phy I get without that patch:
ERROR: no/invalid <fixed-link< property!
---
  drivers/net/dwc_eth_qos.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 67d80d987f..8ca8adead9 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -801,8 +801,10 @@ static int eqos_start(struct udevice *dev)
  		if (IS_ENABLED(CONFIG_PHY_FIXED)) {
  			fixed_node = ofnode_find_subnode(dev_ofnode(dev),
  							 "fixed-link");
-			if (ofnode_valid(fixed_node))
+			if (ofnode_valid(fixed_node)) {
  				eqos->phy = fixed_phy_create(dev_ofnode(dev));
+				eqos->phy_of_node = fixed_node;
+			}
  		}

  		if (!eqos->phy) {

