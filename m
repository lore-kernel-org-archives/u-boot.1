Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD25D3DEA4
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4123188C4D;
	Fri, 18 Oct 2024 19:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPVYARoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA7388DDE; Fri, 18 Oct 2024 19:56:01 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E430E88C4D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71ea2643545so984766b3a.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729274157; x=1729878957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alZnvxSfKa2LVhe7N6UnvTw94sAdT38ZFVvhSNGcAzk=;
 b=dPVYARoBTZKMRKbMuNnS5F1LgAm+OpIX85qDDWq8NWC8jMKT3QMLd2+IOYg8EVc60O
 KrFRdm0gnEewrh7O2irmBOgroWEJ5u58D43zgL79U1xO+h3pZRGnAsYE4HGgDZgBOiKe
 A0StzPBm4rFkhWh8tTTCUrmPZEZoCdkIuKhcrvgVXqN/vuHtN79NVYqgzF6oyH/pjZg7
 w0ixBjK3VPRG2edF6N1+YhV5f/UImG6/SN2Bjig1/jg7zIS4hK7X6ZzS8PIfPhbu0dEO
 6XQzbgVoMQLL27YvKOxjwvlDgD3SwwKFTHIj1mkvZj9r+ZtydtCmDTMxczo4DBcw0Qn0
 bwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729274157; x=1729878957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alZnvxSfKa2LVhe7N6UnvTw94sAdT38ZFVvhSNGcAzk=;
 b=mc2e4+Mbwp8facL9xc1DTTnzbsuds6/0R+F7keFIEPSmvivcmokfmtWxdVxTCej6pm
 GjVmv2SGFdjTlncd4otVymJ/imzpjmB4SGt39WaLcN2qkM5NMB9M+J9PNGyP3OdCJkl6
 cP+D+f8B8XGrv8aAvKDaqu5uQLJ4ujwf1XIB87kACKNpgBjLz86poCbNbzD8PIb2SdVD
 5wTiWyTCN3wlbF3HK7k/WQEMGJyPcmny7IVUySdNmIpjwGWbIjGL44plNhpaGSr7SuUV
 zilxA/W7QCMOLpQm4S9XqRPWkdQoXVFICQDLQQIRejk85bi2gvGd1GRMcXRk+M0P43QP
 kHZg==
X-Gm-Message-State: AOJu0YxbM96gDbrqm1u/9xihwkrSzX7G/RGk7KZoVcDTnMJhtUVGhZ00
 UUssNubHctFCdFXVMqyZrrG36h9tOxXG8BaJxbCzg1M6GFlCRHq89Vx4+w==
X-Google-Smtp-Source: AGHT+IFhjHYZNMWf4IVj2HYkeT2irTgADEZf6ImQSdv8hRmQed1LhySoMn8Nli1eCxmV7s3Be5W1zg==
X-Received: by 2002:a05:6a00:2302:b0:71e:5a1d:ecdc with SMTP id
 d2e1a72fcca58-71ea31d2c22mr4663689b3a.17.1729274157229; 
 Fri, 18 Oct 2024 10:55:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ad3c:ece1:18ac:9bc9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eacc20d1bcsm1428408a12.9.2024.10.18.10.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 10:55:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] mx6ul_14x14_evk: Convert to watchdog driver model
Date: Fri, 18 Oct 2024 14:55:49 -0300
Message-Id: <20241018175549.361096-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018175549.361096-1-festevam@gmail.com>
References: <20241018175549.361096-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/mx6ul_14x14_evk_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index 522c5660d72c..9fbd2c648bc7 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -89,6 +89,9 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
 CONFIG_SOFT_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -107,3 +110,4 @@ CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

