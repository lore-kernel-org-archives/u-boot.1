Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14FCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1057D835B3;
	Fri, 26 Sep 2025 17:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VZiRmii9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FB2836AC; Fri, 26 Sep 2025 17:30:43 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F37B8319C
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-425715aeccdso11801305ab.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900639; x=1759505439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDu/hbnmtYgIrGgftzajyrtP1+veeH9jO+0BvwFeCBU=;
 b=VZiRmii9NyL3yRHvpwAhCpNSu07qTuoTag3b2dniRWjG+WGPsV6SNKeDKerZeVvdYM
 BO5DvvJonhooQXS4E4XXTJF0n+Lh07y8FVy00UPHdshBBieMX0jiyiJqkhb6M0GqIajv
 A0CQtPya35V8Pm/J49ThhOGhn4CD62AaFe5Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900639; x=1759505439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDu/hbnmtYgIrGgftzajyrtP1+veeH9jO+0BvwFeCBU=;
 b=D0vRcRE8+VZllPUN/RcT9uaqFflcfULx6uGB0alDbKo14S+QPPKSxp06QXphA94Kd1
 HRxi9NxQ8zJZoVuQO5O557YC35FgyOMaTibPc0CkSdwDXlsrPgOZkmjHlIFq1xds+5ul
 TqEhTKqLMNeBpE+eywj6yLZsKJ3dgEst0640tgEUCvrjx5C4FfsHi9H7NVj1kYfXYXum
 ZwvjSd4c8HuftTve2Yxg+MXHUggdmirRDP5U1dinGW76GNzozRbHGl2jEc9cbxiNotGh
 hWG+LarZDcCq6C/j/zgBu8N0POjUtJPLZokKrIPg82jNLEf6GB469KNB1MVFL0RxwAnI
 CM1w==
X-Gm-Message-State: AOJu0YyeQ9D56nSToIq2XIKCaX+tNF7Fhx3n4R86gmvlUhcXzGphjWAg
 VM72VPGcxl0RsgGZfwCdcf7ShyIS5zgDEhPkdVZGXBRbcV9qRaCK8UGysIl5kCvj2wjSIXYnXpI
 ZNPKtBms=
X-Gm-Gg: ASbGncsGKHJpNF6vn6tEjFCv3K7rVn9wrdeb7cBkPq+CX0KGgyGVYiROKP3P7M/RIjM
 LVJKQRcCuDFRs47hQK36DPO+9WtjqL1om1BMqVeF99DncD1Lwn/xSv4YlGRJofOaeOvdFugDCL5
 se1T88RZzZ5vTg/kRVgM3fYKGvJ1zoTE3C4lY4TOtgrR2WzdE6qHpM3ZT8xuJHGTSeCKVk1Ipat
 5MxM1Ri5kuaU7zeL4VUu0GLsjiwgvzVMSTXf0gz5ffcs/itgH7X3h8ap2E0Jly7jfRMXdjSDKie
 3C894VEYR0HiKPS3XXTICmZWDU1NqgLkaBSEv9kK6Uw3XohKhVunBqtzPTZ8Pg+YAKUsh97gHGq
 tCX/5J/JWGryegAZlFdCkWcQwqgHBHTtdbdefVNkCA+icMqaH+a+QB+CLUEZVfMj/oMQq8A==
X-Google-Smtp-Source: AGHT+IGUWaWcXICh2FDu9ofcex7ZO9++GW98UtL6SGQ2ebWQHQ6Jgno+zhdcKD14lF0OClvkPEFv8w==
X-Received: by 2002:a05:6e02:2196:b0:423:fc5f:cadf with SMTP id
 e9e14a558f8ab-42595625404mr111136965ab.18.1758900638739; 
 Fri, 26 Sep 2025 08:30:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23263865ab.34.2025.09.26.08.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:30:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 3/5] usb: gadget: Tighten the dependency for DWC2 OTG
 support
Date: Fri, 26 Sep 2025 09:30:32 -0600
Message-ID: <20250926153034.3680674-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926153034.3680674-1-trini@konsulko.com>
References: <20250926153034.3680674-1-trini@konsulko.com>
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

The DWC2 OTG driver depends on an ARM-specific header file to compile,
so make it depend on ARM.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 0121f9872ae6..9065e14768ad 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -109,6 +109,7 @@ config USB_GADGET_AT91
 
 config USB_GADGET_DWC2_OTG
 	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
+	depends on ARM
 	select USB_GADGET_DUALSPEED
 	help
 	  The Designware USB2.0 high-speed gadget controller
-- 
2.43.0

