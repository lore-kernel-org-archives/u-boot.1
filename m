Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4EC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32EA983619;
	Sat, 24 May 2025 01:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WBfO4FQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD5883416; Sat, 24 May 2025 00:59:21 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6108383340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-231fc83a33aso3065425ad.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041158; x=1748645958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQGPtQAx4Kc1PFHzksIb07KrMGgt4H1jo4tjj4gR79s=;
 b=WBfO4FQFEqOP11C7++fRmbZ9KoOHMCz7c8T+1B+X5QVqfCkxNWeQI3xcCooE/n1qsX
 gV3LofhvolYp6b8ytARV8rbvmk1CW2T2GWgaXWBOGp2IQIYlokJJ6pow0GwWLdILMmQl
 u4Y4n3Och7lRXRjQ6TlSLhZhrIkhVIQduBJVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041158; x=1748645958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQGPtQAx4Kc1PFHzksIb07KrMGgt4H1jo4tjj4gR79s=;
 b=J2gRwkczsm+++MItSDmhimEDfI868OkqSF+Bov4+IyaeYSrrzN8hk/Gxt3tfFsbWLK
 JT/z9QxXAEbyOn8Dbq3luDk1eM+cU5v5NN8ZZVoZEK7CwJKVYRbKuCqdY6zisIGMB7XO
 w8oK7QKx97bPv5UVZFuoW89WfInmjBpm6W9QYXcak3TU7jiKZxvjy+QXxFQtJDgnJnDf
 zv74aWfbdwihApWCRHPIszwZ73RVs/KUbVtt6zfflFB5GxYruDJAjQZvplxdi/Lj/sXb
 RJbyvA+COwFduArNlNy3xnHjTUwjKwGstBuHSpfxb/nNoPwGzR2uO+eFier2dskNVcva
 oKNQ==
X-Gm-Message-State: AOJu0YwQuhG9evAgDd3GQCre7kNsrLSEusNdSPvGjQXVoffA/466c+sI
 qUnceFDcH7idRvONJRqp2sEfEkKbaz6qhpu+zTt74pHVVDwkOya5AD+/cFoQU9j6gvIJTRs34xw
 b4iM=
X-Gm-Gg: ASbGncsse+eE2Haj2cdynfsrGjebWK9nmEZM5kd85LpWk+sN1D/GkBILhtYjLRLHacm
 EXw/RpUTRt85nZE069PG3n1v/ugkrCEHIPFwrY8MO7UvZ1gy476HqNr5aPxQJmFPvHAHG/4yHcH
 46DdypaLGabET0B12hpmlmHCbJf0zzqK3vNSwqUQ0YkP7AVOCZuBQ4zv1E94n9soksDMiLN66P+
 HzvYD+rWTj62RXELVelHu2lRDDWCw0jA3il4WeqKLkUFWGyu0FUPvrcNd/fDuXKTV+JmtFgBBgy
 kHjpLkqOLmOaUyNPWh+q4z8UMgo4Q76gARLuaRAIObtS7tsHyTF0+qT2QaBW6ZN5G9kLAb5UEdv
 bsj6KaNSAUpMhVRs=
X-Google-Smtp-Source: AGHT+IFiztUIaduxAU9ixVyCk2u/0dlVin/Kkrlqk7J5u95s0tNS7tfP1gBOSRmK23QEOtoilgTC7g==
X-Received: by 2002:a17:902:e74b:b0:22d:e57a:27a2 with SMTP id
 d9443c01a7336-23414f68e06mr18267895ad.23.1748041157758; 
 Fri, 23 May 2025 15:59:17 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23401ab6bcfsm10005715ad.77.2025.05.23.15.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:17 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 20/28] coreboot: Set wifi mac addr from VPD
Date: Fri, 23 May 2025 15:58:35 -0700
Message-ID: <20250523225845.2311989-21-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Set the environment variable for the wlan mac address based on the value
stored in VPD.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/coreboot/cb_sysinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 92e4f9ca0c0c..555abc93f1cb 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -12,6 +12,7 @@
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
+#include <net-common.h>
 #include <asm/global_data.h>
 #include <linux/errno.h>
 
@@ -703,6 +704,15 @@ static unsigned int coreboot_set_one(const u8 *blob, unsigned int i)
 
 		strncpy(serialno, val, val_len);
 		env_set("serial#", serialno);
+	} else if (!strncmp(key, "wifi_mac0", key_len)) {
+		u8 buf[ARP_HLEN_ASCII + 1];
+		unsigned char ethaddr[6];
+
+		if (!eth_env_get_enetaddr("wifiaddr", ethaddr)) {
+			strncpy(buf, val, val_len);
+			string_to_enetaddr(buf, ethaddr);
+			eth_env_set_enetaddr("wifiaddr", ethaddr);
+		}
 	}
 
 	return i;
-- 
Sent by a computer, using git, on the internet

