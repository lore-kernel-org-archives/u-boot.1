Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA42EC54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 03:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297AE87F6F;
	Wed,  6 Mar 2024 04:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uw9t9BpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474D5879E2; Wed,  6 Mar 2024 04:00:28 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356A5879E8
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 04:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ganboing@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so23982105ad.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 19:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709694022; x=1710298822; darn=lists.denx.de;
 h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F2RofYRkhAhnHuvaLKhUElnC2LXncHVbtNoiFBYSx2U=;
 b=Uw9t9BpHoEVLnzIOlbFcZ0Xtx5T+WpMHITNeUeAgu7jN8T6DfZW7SXzPaAdzfoiwSR
 QrZZTCqPccxZTlcKMlAfzKwhZ6yZmMNw6qABu4gRWq7akEqb+6ulMV4ruVxuNDp9aQpd
 pFjKFqO5Fr2l00JK70e3K7d2KG4vXjJUOE42gIv3NjwFdRTCTlSrU3pEVd3Dym/6QoV6
 LzfCzpk5cdRCwNegg0uj9b3dgYiAj5vuf0xrdT9J0QeCTBMHpG2K77EeitdfNGsAeOLO
 NKxBO905BWNYeg9027hNM3KGvdFAiVu2AYPNjZRsvEf/0astqPBtpZy7NL7uqV+8yySX
 L7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709694022; x=1710298822;
 h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2RofYRkhAhnHuvaLKhUElnC2LXncHVbtNoiFBYSx2U=;
 b=Gi+lNS2ZHNa+1Ku9ka3sWUWPi5a2/ABJ3F/UkjLzsSgnP8dZE160jLBsNSt3rMMpe4
 cAWXioHM2O7LKo+PNwcEN+PUSvgo3SpqwXpTkO2ypEzMvHS+l2mMdc4xWP5beRIbdf+1
 5GX/QbHiQL0Z+Hksel7jpwtWuyyBgAPFxMqIjmJQWY+urvVwyeHq1EH7QY8Xby8tZgtL
 i3t2sJNePzpXIwdXcmfZ+9J3uwlcf06syPq/0pbsNAS+2GbAjb5xRBkcVmPhA6ikIpMT
 9Fj61NKem3BwxjL4iKY1H94zB0G51QhT/30JVtEuPaS+ig0BH4/U7NWRakvpE6MIXDtB
 vlzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf5t1NTKFGv4yiMnGFWeDOS+Hb6xtX/i/HHbAtKiyfuPqpT8aPhxT8ybUjyJLOApKGFmpcJW8Ev/gbsmSDO2wNZONEZA==
X-Gm-Message-State: AOJu0YwpAtEJRuP9hjkmgIghGJj+VyEjv20FEoL0awoLI2TQWneQ9uAY
 oFN/VMwVuukqf27rWkJRHSNaIQ/+vV6XLZOcdeHuZCETXRo1MCo/
X-Google-Smtp-Source: AGHT+IH1vIQKuRcbeOC4pfvghk74lzFfo3tkXdOpfzRtggVeo1MzKwbIIcKttdtghuWWy34TcNnlVw==
X-Received: by 2002:a17:902:d2d0:b0:1dd:7e0:29c with SMTP id
 n16-20020a170902d2d000b001dd07e0029cmr4912592plc.12.1709694022300; 
 Tue, 05 Mar 2024 19:00:22 -0800 (PST)
Received: from m91p.airy.home ([172.92.174.232])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a170902654e00b001dcdfc66720sm10774834pln.18.2024.03.05.19.00.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Mar 2024 19:00:21 -0800 (PST)
From: Bo Gan <ganboing@gmail.com>
To: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com, duwe@suse.de,
 namcao@linutronix.de, xingyu.wu@starfivetech.com,
 mason.huo@starfivetech.com, hal.feng@starfivetech.com,
 chanho61.park@samsung.com, u-boot@lists.denx.de
Subject: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
Date: Tue,  5 Mar 2024 19:00:11 -0800
Message-Id: <1709694011-683-1-git-send-email-ganboing@gmail.com>
X-Mailer: git-send-email 2.7.4
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

Previously PLL node was missing from SPL dts. This caused BUS_ROOT
to stay on OSC clock (24Mhz). As a result, all peripherals have to
run at a much lower frequency, and loading from sdcard/emmc is slow.
Thus, enabling PLL node in dts to fix this.

Signed-off-by: Bo Gan <ganboing@gmail.com>
---
 arch/riscv/dts/jh7110-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 2f560e7..c09d5c9 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -93,6 +93,10 @@
 	bootph-pre-ram;
 };
 
+&pllclk {
+	bootph-pre-ram;
+};
+
 &S7_0 {
 	status = "okay";
 };
-- 
2.7.4

