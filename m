Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BF2C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F8B819B1;
	Fri, 21 Mar 2025 02:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4FHhFOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8BF810FE; Fri, 21 Mar 2025 02:31:37 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6374E80756
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7c592764e54so172582785a.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742520693; x=1743125493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3771F3FXJiUhWdGwEpoLDFwjaOnSuw80KJQ2NknwUeY=;
 b=I4FHhFOzpi1MnvUvXmxUAOSBJR43ZmHhDRdXwH2I/ZWH8M0bUd2YyUFTSIyjTym6NP
 GO6wqoIBCsdYcbNogB0bimuc5yIY2oNc+HOUL0/gp98LcpeQr1FzbNFUM6ZrRvwv/Gtp
 Xmpt3sE/kGlbgbEjZYq6lgH/cNYV1cE5V8rC2khmQjxKPexNqo8A8H5COkOVD1GOYbnl
 0ke+i6qcfv/fAWSldrEbXG4doVaa5b9gUwME3xxna/OG2aJKBbfwO0fXJJVWdPq6zGg3
 8uMkmNj/kNxih7+l9YeVT4Bl39JMEFizumb2lZN6boRp+QHctcSGELU7+kWcY9V/L5KX
 7/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520693; x=1743125493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3771F3FXJiUhWdGwEpoLDFwjaOnSuw80KJQ2NknwUeY=;
 b=s66CI9IgDCZw+cztVcAtvf0kGgyFPNes38cPkrt/Mk6CmHQHdSIOksLo2eZnukE1yV
 pRlZSbbl8W7J85TeWhjqqIZOwFGSHqfQHpnFEspWZJ0TyC0wTmG/Tj93TXClUb3+xb5y
 II8/mA+xf9AqFOesdWkFJ7RlITLxuj9GSHCPj0XV/KgD0JVvSv/l9fLsHX27JSyCb8CH
 TYqqj83I2Z8x1V2kwBrBwFn3jAR5wOG2CiyVplz43wfDE2qpz6myugeqFKaDIhy5DQEd
 UMTtiE4i8fUrVWAQT9bNDCMtvTf/tiz0OpP9xLprvSZqIwmxb9NIhHXaKyvhuw0plNOF
 PS7w==
X-Gm-Message-State: AOJu0YyTSeb5CLbV3dBc2+I5zJeQmb8UjjhR+1MMsFB7a0gRO/0cQKKl
 eFdic4ur56l/m44cvrt7FCoNxzWpF3mUYU/0F2P6VpEhoEAq4AqkZ1U1Jg==
X-Gm-Gg: ASbGncvgl/LoltooYSeCaCPGqqcaKEtH+/29wng0gWS8/deS1uL0cHJEhFWtOkECreN
 ZKWo4lYCfHDMlHnGoNmoITnLlChOZZ8cnhogG4VneODhh+1vnqmBeH5ETFDL+dxyiWjtIEpWFmU
 x+peb8zwMlnHDHPhQ9KC3WGJ0CsVJy7Pwy7Wr/mKM4t1CkXLy0jwNyJDTKHimIfhnOJ83Q+O2Zw
 rfBtYEQJ1LfbQ1MV0Bv9+Al2l6RvXDrNTtsoKdtl4DMiuEm9EAopNkmPpKae5nXJllPq46gbDFH
 JxgemKrnZntSTfmwpDyUo7m6OTKTTY71n7Asu2Llj3vcoKG9L59DGS7Ny+rBjc/LrtHuczatCay
 ElIS3w7vpGwWTit46/QaS0g5DXy7+Qg==
X-Google-Smtp-Source: AGHT+IF2NJiU7Lq6eNdEuIczRZ8I05HZooWrMyAjYQcnTkAJVsiildr4EC456Lr6aJDF5k6KvBW5hQ==
X-Received: by 2002:a05:620a:460b:b0:7c5:65ab:4ff5 with SMTP id
 af79cd13be357-7c5ba1e40e5mr217414885a.45.1742520692743; 
 Thu, 20 Mar 2025 18:31:32 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0137sm60501185a.31.2025.03.20.18.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 18:31:32 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 5/5] arm64: imx: imx8mp-beacon: Enable CPU_IMX
Date: Thu, 20 Mar 2025 20:31:05 -0500
Message-ID: <20250321013109.709431-5-aford173@gmail.com>
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
 configs/imx8mp_beacon_defconfig | 2 ++
 1 file changed, 2 insertions(+)
V2:  No Change

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 9709f628f9c..2893270d0c1 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -88,6 +88,8 @@ CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-- 
2.45.2

