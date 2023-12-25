Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C59C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B6E8781D;
	Mon, 25 Dec 2023 16:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ff38fPYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95088773D; Mon, 25 Dec 2023 16:42:14 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E858987831
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ccbaea0a6cso11969041fa.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518931; x=1704123731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvQDLylMZZyItYAARaG/slPihLAB8fb3RjCohXg8958=;
 b=ff38fPYeqzsV/pzlyxOiaMDB/OJZVAawJHfnmWKPcLjh3jQsUDr1gwx68F0mH5epae
 k0pdMa0BnmPfheRR1wBQctUdUVFL9L2pk/7+jShQRP0SOO94yB4YdsrfP+e726i2tbkv
 Ap+32nNlDDNslFnztz5TKEh2tHdkqMzn8T14DmwWOo2eNjiMkU0Qz3krMwEFIH6RiDOw
 /pBkmO0dQEw4zH5T0vQqnl+RWXmA+R178QgtjAwBX/mcT4TI2mPDFfHGYjcE9v9TV3jb
 1cKXaMWkWG2HbXKDjeW1RrBIIeT6kDpbRuIqspI2VLqoZkTV6tgAINV6Z2qcZbfc75UN
 3XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518931; x=1704123731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvQDLylMZZyItYAARaG/slPihLAB8fb3RjCohXg8958=;
 b=qBbEInq8BcMrWY5mDOVcMAPDYBaZROfUeWLNDF9f/+hdvoGD9BWo6UIeW2J1VMIJyp
 FqSeaFXh1EzpD06YKMDtIi+Hv2CyTlhla7Kz4espb1u3NEE7/Jn5FstWX6I0RL+92lTc
 fln4QdpRiWWcDhoH14KOrsjJgldzQwLRApZtx+H5L37FRB/rKSMggIzpr3Lp0dPCozbZ
 76ZS8AqfTY0uwWRC0Yay4qaMoa0Fs5Gfd0M3n2pSwOKPCPAxEDVP58T6m6Rm+a3Drbqy
 UWvrstgaVqpX3+hTVBt8rtPRVn4oBDAcnsix0NzgaTQQ/GkOc406WXGOyNKGz+nQ/Lex
 qNog==
X-Gm-Message-State: AOJu0YxrUJlHDDv0uptnZJiZz02b4So/aZgxUItaaT92pzxa1EW57yxH
 YhmTl4fDLGVP7PoIdj57PnsDremiG429s/RLVWEJhKjgoCI=
X-Google-Smtp-Source: AGHT+IGcDH+7sXg8Iq86KMFlz0XhbFa9ARIfLEhlXbXEW6mUKZeGBHh508PRwl3003NLem5OlkycUA==
X-Received: by 2002:a05:651c:2044:b0:2cc:9ec8:fc60 with SMTP id
 t4-20020a05651c204400b002cc9ec8fc60mr2030658ljo.9.1703518931649; 
 Mon, 25 Dec 2023 07:42:11 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:42:11 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATHv2 7/9] bcm_ns3: use device specific naming for variables
Date: Mon, 25 Dec 2023 21:39:27 +0600
Message-Id: <20231225153929.8284-8-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

Use device specific naming for variables so as to not overlap
with common function names.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 include/configs/bcm_ns3.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/configs/bcm_ns3.h b/include/configs/bcm_ns3.h
index 47de4bc201..7c6e0725a6 100644
--- a/include/configs/bcm_ns3.h
+++ b/include/configs/bcm_ns3.h
@@ -45,11 +45,11 @@
 #define PCIE_ARGS "pcie_args=pci=pcie_bus_safe pcie_ports=native vfio_pci.disable_idle_d3=1\0"
 
 #ifdef CONFIG_BCM_SF2_ETH
-#define ETH_ADDR "ethaddr=00:0A:F7:95:65:A4\0"
+#define BCM_ETH_ADDR "ethaddr=00:0A:F7:95:65:A4\0"
 #define NET_ARGS "bgmac_platform.ethaddr=${ethaddr} " \
 	"ip=${ipaddr}::${gatewayip}:${netmask}::${ethif}:off"
 #else
-#define ETH_ADDR
+#define BMC_ETH_ADDR
 #define NET_ARGS
 #endif
 
@@ -749,7 +749,7 @@
 	OS_LOG_LEVEL \
 	EXTRA_ARGS \
 	PCIE_ARGS \
-	ETH_ADDR \
+	BMC_ETH_ADDR \
 	RESERVED_MEM \
 	SETBOOTARGS \
 	UPDATEME_FLASH_PARAMS \
-- 
2.30.2

