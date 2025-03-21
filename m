Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0ABC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572B681B42;
	Fri, 21 Mar 2025 02:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="meg5opdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E4381C84; Fri, 21 Mar 2025 02:31:34 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5578197D
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c3c4ff7d31so212779785a.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742520690; x=1743125490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AayUORl8bhE50bq3OdQLtG86ssvIqal5g11h/SXa+cs=;
 b=meg5opdZnfYNb7FXUod1E/3dHud4C7puZD5XS0u9uOACpeVeR2NrauZA5rPx8JF/H4
 8UrmNaxcfz+rlTQ56peYloO23sGzuVXLR5m52F7HLRq+wDn18EUsUawcNC9GZOURf3mm
 eH13Q5RUWdTRa0UOjJRG4dfPHiBGT86wXv+tNB/xX+8e0qVeWHlhUII0NA7iGjTc+k2m
 re3tX4Q4hyPojPEfJXg9d1wn+HHpxsqdQ/nQ+AWp8wnNE1oJbVudsESpkpTCVlGufbjS
 ATXopNMhcYpavkyw4eXK3++a+3x5Nam2L5Qz+1oExuUEx6bJv3jhjWdrf9QoX4XBusfB
 LOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520690; x=1743125490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AayUORl8bhE50bq3OdQLtG86ssvIqal5g11h/SXa+cs=;
 b=tvrqyxIhV9EU1mBQujx4RpwyQQaQHQd/RShBKOkCIk4foqSrdqsOBdqM0/Vkw6gzFw
 pai7Y/ogm/GbZBciZgGoGU5jPsDCrh33+07BlXsUhvt/lBKdj1LTBrl2u+zPAUyVDHKZ
 DPN2tA9oRAjl1rOb8gQQLAu72xQpa+B2sPnLFIIMLxcTLEubioDEj6fEQyc3nNCM6uDG
 Wb1pd2U7yMiJRhBb5OEL4JXjpaaVUQeOMPOVAz99oxZNo5//oayUhXnau9GNN9zxh4/V
 hcJhxQj2PYETyuOkonjOCt9NIPalzrMe37IfJGy8nuYF1//5DEMGW9NHzMKd2e8HOupB
 Udjg==
X-Gm-Message-State: AOJu0YwdcC9FeyUIac0epWozFQ17w5snHctTdNbJBBvwuoHccY08l1vb
 Vq9vo5r97dCqB2+uxPqMyiOOWSujnY43WC2tFHznUqVehyIOSBayFAHLOg==
X-Gm-Gg: ASbGncuUz0Avw6InsPhfdkkqugl9zIxmqPCaUgp28JsxLz8NaaRbAx+/RLHQx0DSpDd
 J1C1DnI/Lp4P2OUcoJt48DFdN5Xs2vkaX/o9/M8gJpKJzP3lgl3rVPv2yfk0V9J4Oun3t3skBOn
 eLc+GFx9IidHGrY+AziVhgI7wCK75slw7B9uX8NHC675OUaubFPhb71lpdkBwTm8I99LcmE/YSK
 gF+hp92/z/G1h2eKeREohQ5J8AgZiFH8J5qQ2U0UZ0g4eNos4jBut3YV4y3mTWC3I6ZzAVESroN
 DymrCfw4VB8V+JtN1liGenHNaqpuMRH07BePB79FMJnQlgiegJR0NXIrXu2Me6YJRbJarxiRXUY
 8rqLWmNY/ZnQPsTy1nZLa79+6Hzp8jg==
X-Google-Smtp-Source: AGHT+IHs8wxBl8qX30jKmUERgh2vm9fJptQScCs7wPS/6FRuTMoyGqgDI24JvIqr3ohDPj44BVUDSQ==
X-Received: by 2002:a05:620a:1b83:b0:7c5:6299:3da with SMTP id
 af79cd13be357-7c5ba1e422bmr202908885a.39.1742520690562; 
 Thu, 20 Mar 2025 18:31:30 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0137sm60501185a.31.2025.03.20.18.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 18:31:30 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 4/5] arm64: imx: imx8mn-beacon: Enable CPU_IMX
Date: Thu, 20 Mar 2025 20:31:04 -0500
Message-ID: <20250321013109.709431-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321013109.709431-1-aford173@gmail.com>
References: <20250321013109.709431-1-aford173@gmail.com>
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

Enable CPU_IMX to register the ARM core and identify the
speed and temperature information using the driver model.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mn_beacon_defconfig | 2 ++
 1 file changed, 2 insertions(+)
V2:  No Change

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 69af7cee092..93b32155aa9 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -93,6 +93,8 @@ CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MN=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x40000000
-- 
2.45.2

