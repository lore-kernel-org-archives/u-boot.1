Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E80CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D1A83B4E;
	Tue, 11 Nov 2025 14:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="1w3mW9h9";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Z8LwAAfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB0983B86; Tue, 11 Nov 2025 14:19:54 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5F883923
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-4z53.prod.antispam.mailspamprotection.com;
 s=arckey; t=1762867191; 
 b=i3+G936fKufq0+nzF7h91qpESYyE31yWkfnxBEK13Sea2XDUjDXD8EWvMOWyAVj5V8r06lH5Dm
 9ng0x/KQcj5HsTSSKJughmTBK2jkX1TBWcLSzgTC+P85Q87BEoAU1FE7brr1CpwOu8VpdrGxNo
 9G+R5j50cx/ahQyC0Nyxj8rkWfe5NKKcpt2CLlepVdAFFRuIgF2gy9QmaGyHa6f+Y7T1qBMVa3
 Ag278SCbN/ZueGtxQsQzFS1AV67L7EU7hk5wGvhyWbswv/NBlhtsR8ZjsAaHH4awIP7k8FvRJa
 9wKH0fuZSqQvIlS/UHTwzPKOoXIougaGRboC/UK0OzWxag==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-4z53.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-4z53.prod.antispam.mailspamprotection.com;
 s=arckey; t=1762867191; 
 bh=ru9WWR3T/3GfvebN53lEDzHhp6hkWTrvObufVCBSb7Q=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=AOazTtFDuNMnQtoecTbvJ7D2OKipjNKUbhtVESeIAYXyL/HlTRVgdoxR8e3PeEIxviCBUsJIuf
 n0AlVei9wQHEnuLbGOesfO9TXOmxajAkOwVwaKXjhijmfg5UiaYlohnzgQnW8uMYkY/SADh+fZ
 5/t6emiCUQlRB3glzniCZq48pMh2qU5humaa5EwSHvMy5hvltmHWXNL+mV1lTLiT+ztC6MDjqv
 m8FbMBXhYCembpzMEalpxTBPrbWDIh0vbqpxqdI3GZvFGrjoQs60Usg56RMfoqI2Pk1Ns4H8aZ
 onNq9ef/t62Y5DZGNyacHboBVyHlqUiBdrfgH5HzKPu1Fw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=KDCQ+HNJdvymeLxliZJsiuqIyCUwvTXfnJSgmKuUUdo=; b=1w3mW9h9t2+uvIQ3M88FWlNB2R
 bJTu+SuUWq6aNc7SSnXc3pzN1rpYCxcOGzBE1aybnOhTYP8yOmP07+Xth/jHIg5zp+c3MZQph+mUY
 /nN/vTdjNPl8D1A4tCt+VN67E4DKDsqiJ0SlOVJ08AGfw5takXeWhJvDaCNzWnt+UD0M=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4z53.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vIoHl-00000000TN2-1qa8
 for u-boot@lists.denx.de; Tue, 11 Nov 2025 13:19:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=KDCQ+HNJdvymeLxliZJsiuqIyCUwvTXfnJSgmKuUUdo=; b=Z8LwAAfrKZKBzKRx+jBFBkP4nQ
 H5/JXHUkEMzMC4Jq5DS/i61z261AWd5b7ar+01AO216gMjjNGAnmEZXzHXRXZngrp5KbzX33bbcF2
 RUPubRsofNz8rFLdOfYiDaP7dy611ERrwkhXgDI9w0e69hCwBvBEAMYtYSudAeZIhrCM=;
Received: from [95.75.41.194] (port=31868 helo=[10.132.253.42])
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vIoHZ-000000000LE-0tRL; Tue, 11 Nov 2025 13:19:37 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 11 Nov 2025 14:18:32 +0100
Subject: [PATCH] imx91: fix ENET1_TD3 pinmux for GPIO function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDINDNzK2wNIwvyMwrjk/LrNA1S0pLTDWzNDE0NUtWAmoqKEoFCoMNjI6
 trQUA3oImXmAAAAA=
X-Change-ID: 20251111-imx91_pins_fix-6bfae694156c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654; i=francesco@valla.it;
 h=from:subject:message-id; bh=ru9WWR3T/3GfvebN53lEDzHhp6hkWTrvObufVCBSb7Q=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJnC5vf/Gk8/ur9px1ODxUsCkmJuM5oJL/+8YgKbm2veh
 agdv0tCO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJvFZn+MNxUvZ10gHm9ktL
 Mh4r31s97fv9/5P/n5H89/m179zs1Yc0Gf7X/F/Nc8Nz26ZPO5vO/Hbqbfzcfk5k94slllOsth6
 /nfCEEwA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9412ffd991f5807b78a96f29fe1ed662
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vIoHl-00000000TN2-1qa8-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4z53.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Fix a typo in the GPIO function for the ENET1_TD3 pad, aligning it to
the function specified in the datasheet.

Fixes: a9d562daa3c3 ("imx: Add iMX91 support")

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/imx91-11x11-evk.dts            | 2 +-
 arch/arm/dts/imx91-pinfunc.h                | 2 +-
 arch/arm/include/asm/arch-imx9/imx91_pins.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/imx91-11x11-evk.dts b/arch/arm/dts/imx91-11x11-evk.dts
index 65571fc223b779d5aafc87da3940624db32418cf..ca9070a4c76440e72ecb2534ab55596fecb758d5 100644
--- a/arch/arm/dts/imx91-11x11-evk.dts
+++ b/arch/arm/dts/imx91-11x11-evk.dts
@@ -503,7 +503,7 @@
 			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
 			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
 			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
-			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO2				0x31e
 			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
 			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
 		>;
diff --git a/arch/arm/dts/imx91-pinfunc.h b/arch/arm/dts/imx91-pinfunc.h
index b0066df173b1386f040b0776fd798406a6e39e06..1e15a0cacf8a8f83ad1e7d602c24cb622f94f078 100644
--- a/arch/arm/dts/imx91-pinfunc.h
+++ b/arch/arm/dts/imx91-pinfunc.h
@@ -330,7 +330,7 @@
 #define MX91_PAD_ENET1_TD3__CAN2_TX                                              0x00a0 0x0250 0x0000 0x02 0x00
 #define MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                      0x00a0 0x0250 0x0000 0x03 0x00
 #define MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                      0x00a0 0x0250 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD3__GPIO4_IO3                                            0x00a0 0x0250 0x0000 0x05 0x00
+#define MX91_PAD_ENET1_TD3__GPIO4_IO2                                            0x00a0 0x0250 0x0000 0x05 0x00
 #define MX91_PAD_ENET1_TD3__LPI2C2_SCL                                           0x00a0 0x0250 0x03e8 0x06 0x00
 
 #define MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                   0x00a4 0x0254 0x0000 0x00 0x00
diff --git a/arch/arm/include/asm/arch-imx9/imx91_pins.h b/arch/arm/include/asm/arch-imx9/imx91_pins.h
index 26246702a9607cd1ba6c8a15be9313db63b2a4af..64bc4de4b2b0964cac56ddff372baa2b389750da 100644
--- a/arch/arm/include/asm/arch-imx9/imx91_pins.h
+++ b/arch/arm/include/asm/arch-imx9/imx91_pins.h
@@ -329,7 +329,7 @@ enum {
 	MX91_PAD_ENET1_TD3__CAN2_TX                                                     = IOMUX_PAD(0x0250, 0x00A0, 0x02, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x03, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x04, 0x0000, 0x00, 0x00),
-	MX91_PAD_ENET1_TD3__GPIO4_IO3                                                   = IOMUX_PAD(0x0250, 0x00A0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__GPIO4_IO2                                                   = IOMUX_PAD(0x0250, 0x00A0, 0x05, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__LPI2C2_SCL                                                  = IOMUX_PAD(0x0250, 0x00A0, 0x06, 0x03E8, 0x00, 0x00),
 
 	MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                          = IOMUX_PAD(0x0254, 0x00A4, 0x00, 0x0000, 0x00, 0x00),

---
base-commit: 365a7079fb918643da0f0709660a7d8ea76dd6f3
change-id: 20251111-imx91_pins_fix-6bfae694156c

Best regards,
-- 
Francesco Valla <francesco@valla.it>

