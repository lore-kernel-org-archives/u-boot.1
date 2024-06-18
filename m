Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C63C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8FD882DF;
	Tue, 18 Jun 2024 14:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMJ/zeKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BC28832D; Tue, 18 Jun 2024 14:00:45 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17EA7882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52bc27cfb14so6630112e87.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718712042; x=1719316842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCVgm6Xd9HWkMjyhT4XzAYUtQa0rbWJL97mPC9icbK8=;
 b=ZMJ/zeKGGa3h7+kDLgt4HXQ29gdVlFAeCj0d3f/2NhRbLVOS0RiZEdvNKJfYoPdCy0
 3v3dpfsem0/jklYyDsW8QA8x+A2bJtLHLHqRhFXw+DrFrMslUAOpodh5IowejouvdV9K
 Y70xRQz3t80c3o5CevycIyfluCqagH6Jb8qRezBd8x822LkVCDGUB1+DRs80i0uN5ibx
 bu6OqL4BR95cbnpDCxOvSvIst1Ki9+w7nWcetEymLlVaBLjJNE/W4JjzXn6VAMKQv6XO
 1XJzQf8viiNRZim5ehoit56GQ1NV9FQFr2rjPyleZaZa7o52YNnW0oPowc6Vl1IQ+SXi
 sDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718712042; x=1719316842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCVgm6Xd9HWkMjyhT4XzAYUtQa0rbWJL97mPC9icbK8=;
 b=STXtJbtVxzeTApavqLPIpsRmDQVbXyAfSLJ6qpW8VI3YjXKdCfv2SZgiT498OmZPbt
 fMHF9BPjnYUJ/6Z/2JRryLAoLTyeDwJmSzz8ScKifegRFKPNPLQkHHj6ObjDdFl5N4IB
 e5hCQHA60dH5oEAY3NF+L/a6W8UGNNgPugvgjbjDrKqqLqtgfOvdEzgE0ioQaFwS7n1t
 B42AzVug+rRZr6WCbOJII0L21AySJ/va7eNjxET0tH60FMHbPH336sY4tkoMq5dRoT7q
 8bu//0NxwwT0fLEV+xgjUZ8ilqUIFN3WZg5RdCLnh6ahT1h1y6HBg8Bhug3BEATxIp5o
 KS3w==
X-Gm-Message-State: AOJu0YxNjfSBxZbFhKQOyoygR6d3+XtDvpEWR4KtlzEt+MCnGPNTS1l+
 e9mHgCKuXnvEHVa3fY4NK6emsawexuH9ffFPM0kB0mFTYz5i3B8QFVbPIQ==
X-Google-Smtp-Source: AGHT+IF93Cw1Cwa/sgDoR8I26+mDDvVQIajdlKu5x0u2U4r7POuH/1uU9WCb9PKUw3JK496Icae/HA==
X-Received: by 2002:a05:6512:b20:b0:52c:8a11:cb4a with SMTP id
 2adb3069b0e04-52ca6e920aemr12625954e87.46.1718712042165; 
 Tue, 18 Jun 2024 05:00:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa674bsm614825666b.210.2024.06.18.05.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:00:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] include: configs: tegra-common-post: make usb first
 boot target
Date: Tue, 18 Jun 2024 15:00:30 +0300
Message-ID: <20240618120030.41502-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618120030.41502-1-clamor95@gmail.com>
References: <20240618120030.41502-1-clamor95@gmail.com>
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

This ensures that the device can boot from a USB device prior to MMC. Useful
cases are when installing a new OS from USB while MMC still has a working OS
configuration or if the OS configuration is broken in late boot stages
(kernel boots but the system does not start).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/configs/tegra-common-post.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-common-post.h
index fc74980f7c..2f08dfed02 100644
--- a/include/configs/tegra-common-post.h
+++ b/include/configs/tegra-common-post.h
@@ -7,7 +7,7 @@
 #ifndef __TEGRA_COMMON_POST_H
 #define __TEGRA_COMMON_POST_H
 
-#define BOOT_TARGETS	"mmc1 mmc0 usb pxe dhcp"
+#define BOOT_TARGETS	"usb mmc1 mmc0 pxe dhcp"
 
 #ifdef CONFIG_TEGRA_KEYBOARD
 #define STDIN_KBD_KBC ",tegra-kbc"
-- 
2.43.0

