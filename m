Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86653CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FED836D2;
	Fri, 26 Sep 2025 17:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="op/lmh0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692D0836D2; Fri, 26 Sep 2025 17:30:45 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E2083666
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88432e27c77so98727239f.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900641; x=1759505441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COPmF98Z3qp3KbBfQNlEPG/yAA7/9eIBd3GLf7glO/k=;
 b=op/lmh0OWFH2qjcVZCMF/Mgpx7k16YunwPPDH5E+r+zHVSW4ThlkfgCbj26APwp9fp
 Qb8VQuFLruvuTD5nqKeyb6cxgpJZT7NTNCiY+b/6WN8Qhjg60A1mmJRa0KceeP6SxoT3
 S05FlNRCXhNIq+wRvaLEZjCgN/G0dJv7tLC4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900641; x=1759505441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COPmF98Z3qp3KbBfQNlEPG/yAA7/9eIBd3GLf7glO/k=;
 b=vKlV1dTM+8ScNf9hY/PXHLdX/ja36Qp1MwZ6+1kxxbfu1lT1C85FPoD/4cX4bk3Hfm
 7qiBM9ruCKAmy801MtrjqxCrHosvkxYcd9kCFPvEOCdQC3fkRXxxjUdSbCnhBiCqa/wC
 wZmbbe2k1oXe1i71PNiJLZ5ypOd1dSFcYrvfW9DzFKLkUCUo88MIFlSdO+daFAn22SxP
 qbsQgRgBne2vTItuz6jyRyPBizgd+jz6xGNbMT/6PxnCB+U9QOVco/to76hzMaWKWLyK
 E72BDIESF8p0/bdLJKYkjQmtfqgocLInGkW/YcJoiOLzDukgTlWIVCvTKsJa33DQgciv
 r+yQ==
X-Gm-Message-State: AOJu0YzQc/2qRb8eMAwaenlx4yfDflKkT7QVWvUjmRhnBP/PSgSMXUZo
 AtMKBt0aiPFeD2KXKNFQNQotcmXZMJfJKHu6ohb/FARk3WYwS3qimZDyO2cwlTqHhGyeYRVUxaL
 V0R4ko4M=
X-Gm-Gg: ASbGnct5EpEEbOi754iu1YHsshsenFwQFuyU1A2iRUrjI7VYGo1v/pz8T5l4UqiSqlT
 qNUhBwhstqHv3GcvN/ugqrkTtbxqAeSmxYyaAlicin7s4TVZ1eoXe4UNIJrfOHtL3MKvF647Nud
 nyCZtDyvC1LaWO5NoDxhxdz6XCbQdKbOP7RsH11cxq7/3ZsX7eWFDqtL9U8a8iGLxROcAE3fd8L
 F/kp7Wq7Zy7/voagB1u0bWZIp+u0i0Hgrr8EbO1LOGMQOaxpZkEvS0OwvVtoglm2PxSL5jeiO0D
 1jns3hq5X8cUvz16em3tF0zXlPNVOIdfurYAjQddK9Z6cGKmS2kjTPfInKXlwzGAihm1LzpOWky
 1B7dk4cJLjxsCk+l+NFfzsz/iDuNOnVEMbmRneGnC/t+NBeFszpNjODPPEbg=
X-Google-Smtp-Source: AGHT+IHMw9spwM+K59iNzVz3ro4vBgYSNQaHyiYNj9rM2BY73C0uoYpnx9TMDJcqhUH1d3Mn5QV3pg==
X-Received: by 2002:a05:6e02:17c6:b0:427:1841:666d with SMTP id
 e9e14a558f8ab-427184167e3mr55795015ab.30.1758900640709; 
 Fri, 26 Sep 2025 08:30:40 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23263865ab.34.2025.09.26.08.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:30:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 5/5] usb: gadget: Tighten CI_UDC dependencies
Date: Fri, 26 Sep 2025 09:30:34 -0600
Message-ID: <20250926153034.3680674-5-trini@konsulko.com>
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

This driver cannot build when DM_USB_GADGET is enabled as both options
control building of files that use the same global namespace and
functionality. In this case make CI_UDC depend on DM_USB_GADGET being
disabled as non-DM support is the legacy choice.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 9065e14768ad..9f817967a08b 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -152,6 +152,7 @@ config USB_GADGET_OS_DESCRIPTORS
 
 config CI_UDC
 	bool "ChipIdea device controller"
+	depends on !DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
 	help
 	  Say Y here to enable device controller functionality of the
-- 
2.43.0

