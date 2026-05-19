Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E6ACD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C2C847F6;
	Tue, 19 May 2026 15:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="XqUjz7KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9344A843B6; Tue, 19 May 2026 15:02:32 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC348483A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195745; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j7r1OlPc0QYfBXHr8FKMD0z6imusK0HrTNWzEoA1o83822WPJquJVTIhG90zOTUqfDZS5oaaTnWCHUv5rejmgSi7KPMPSQtc70lDaHXorvMXnw62MiC9gmr+6nEF+Ozr/75SIS35qkM9BFc5YKq4dLh/7vNPvvn8KygAczFEVE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195745;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ieWO5EE9k37C9iEuSuy9bsYfSV4zfJP7tDvHr8PVHtI=; 
 b=MkVNIKRiX4aACIFjun5Fv2ZNDHUeIqR3MMQRzitfev4+9MGWFgyEWrvl70C/bzZyg7tHboDPme4Qj+uHv+x30wfKZkCx9drNt9kZZHV7zcTb9H6MsbF2OjB3cqprJ1Iptrk+b2CUaYWCfq3cMsWQkc2zgMM4NPRAsSx2wPlP80k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195745; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ieWO5EE9k37C9iEuSuy9bsYfSV4zfJP7tDvHr8PVHtI=;
 b=XqUjz7KUgKnr4Kh4EqM3tLHkWhQs1YpQyD4uBujXuNKF/WSh/HYFOF2vIAAsUdMQ
 DVxxLZknIikieDfJMfSx0254tCvDpyvE4NBbZAkF/+KIFBsb+sg2uktwpZsV7iWs+x+
 syROCiPAhZDPfYoSPki2YhOAFfI/mawO4vL21SKE=
Received: by mx.zohomail.com with SMTPS id 1779195742883933.2411192175417;
 Tue, 19 May 2026 06:02:22 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 19 May 2026 20:58:32 +0800
Subject: [PATCH 5/5] configs: radxa-cubie-a5e: enable the gmac1 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-a5e-gmac1-v1-5-c3117603b9fb@pigmoral.tech>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=1051;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=8ndEnlW/Ch3m0fegFaKOZ2VQ+D5c7kknOeH/iZPDM/o=;
 b=qnjIMW1RkyYV7ZT4F7mcQJX64C4Ii8mjtJibjVEcYwm+3BC6zuYwW0MNRDgecsPJoYRPfx2Cz
 NHpKy0bRVm/AHuYMazXD7HD53jVRomJkSQ3x/HAHbaegnQuY6PdXFp0
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The Allwinner A527 SoC features two Ethernet controllers utilizing
different IP blocks. While gmac0 uses the older sun8i-emac IP, gmac1 is
based on the Synopsys DesignWare Ethernet QOS IP.

This enables the DWC_ETH_QOS_SUNXI driver and the required PHY interface
configurations in the defconfig for the Radxa Cubie A5E board,
activating the gmac1 port.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 configs/radxa-cubie-a5e_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/radxa-cubie-a5e_defconfig b/configs/radxa-cubie-a5e_defconfig
index 52a23615e60..fbfddf2773c 100644
--- a/configs/radxa-cubie-a5e_defconfig
+++ b/configs/radxa-cubie-a5e_defconfig
@@ -25,6 +25,12 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_SUNXI=y
+CONFIG_RGMII=y
+CONFIG_RMII=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_PHY_REALTEK=y
 CONFIG_REGULATOR_AXP=y

-- 
2.54.0

