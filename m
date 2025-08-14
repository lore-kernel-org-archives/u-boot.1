Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CBCCA0EE6
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DC58399D;
	Thu, 14 Aug 2025 20:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GxemwJcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD91583A2A; Thu, 14 Aug 2025 20:14:48 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAE8D8399C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2eb9ae80so1157458b3a.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755195285; x=1755800085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWfJ3I35nD2TRHlGDF789xD04LKGuhALS6RuTfXiwjY=;
 b=GxemwJcHyDPzdJjWqgPvYrDvFtigwKTPwhsTeyiXezlq1tYX5q2dVOAj6XhUE8GdUK
 2TbotavSKqkHlPcIaSApiFyW9Fz+4qbYV9vsIODeslXhy4o2obRQlC0jeugY15JRO5kt
 9XQD+uUPqplhh7dP9ZZEuGU7q6YZKhWwQ2oH+HQXHqCGhADkojq5SJMmBk1peH/tSu6/
 MM3GmHpwvnl7fzh5mZWeLh+zqCcPDryCs+Z9JFK+Ah2J69cQja7LPdmIPaz3Prj7YVzl
 me9Vwcf9aA2a4HnDaU822ZrcdXij6t2FUZ73xrspTRKfXkcR1am1BwgUyM+rAcIg7eyt
 CbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755195285; x=1755800085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWfJ3I35nD2TRHlGDF789xD04LKGuhALS6RuTfXiwjY=;
 b=FNiNCAZj4quodulrUUT0KnKUnOirXGj6tvkUJidv4c4V7hXnrLRTU44QrsZDhiyAg5
 lZjN39B3F0S223w9IuWfYgoXLaT5rHDZvy4YEXpQdK/KncQ3vGm0m1wwu7pZevBtSGGF
 VuNq+hqRRtIw/JdvMDqWtDI9cxbEuVUmDNCP+ZAzkz8myLeO/vOfPCcUyyuk+Me2HC4J
 kjqthIohqqn2RxGNI8v3A7BhjlOXJ0x1YBu9BUZr+a5nqWSNAT9/dI79n12DDTlNpIqd
 luuyQsjpdEcvjhZTkAoVBUdcw0MH0TUf/eXfrpcVWt38XAy2VQgqadWspDSq4Naddn/Y
 wGYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOXBCJLPyQBr7gnKp6kIdI94rAQd3N8eJRQJoJw2GiW9V6r8hC6pzcHJSkPJkbc/LQXe/wp5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwalD3ThFGEi24uOCvxbJmg5W29i+8XhPR98tHOe9ZSM9oVvDss
 AsMOkWxGfG2P/Jxy21+I1En2rwR1rjjc6C6Iqfmknrn3+3iCfuE2W6GJ
X-Gm-Gg: ASbGncvC+xa+Ke0OpIg5dLP9TTrGgAD5TFDaQUnPjGWEwxJiWpbqRtPGNz+w9GlnK2F
 Epa7+0hhXvQVqULzSBVGoddBif3g27wKfboloa+b/llyy7kUCLg6cwRf5PMrpf2dEKsdsbZ23ZG
 di6RUyqiQKfopCgt7TOJjGEs/4YGKEAc8aURtVXebepDIt4Y5nfZJyuPSvSjOISyaFn9WvSyuOw
 q8GVl6EAnD2bSPPhWafYVFL3Y6qNHlRV/lFEQakfBbtnPjUM8hXMFLzzljovNF175ciR+O98hv4
 /XMqg5rs3TAJIFFFyRSW9f++A3u0LSAhCXIVKEAY7GHRBtaNKIgSoQ+XBnTzuiicNJ2iLc8+mcw
 5IpN1nIAw415bJ9SS8drDRyexDqJ6WR+SIckAzNrEww9d7Q==
X-Google-Smtp-Source: AGHT+IGu3ZdTp01MsR0iOW3xCPZ9dDyEPpkRU5xL6JnE9m1Ru3+i8sb7xzdPLip4qZ+iNwMfh5nMIQ==
X-Received: by 2002:a05:6a00:4fc4:b0:76a:986b:6d2 with SMTP id
 d2e1a72fcca58-76e2fd4e63cmr5999874b3a.11.1755195285077; 
 Thu, 14 Aug 2025 11:14:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f50d:900e:961:a245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbce4bsm34713327b3a.77.2025.08.14.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:14:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
Date: Thu, 14 Aug 2025 15:14:36 -0300
Message-Id: <20250814181436.1598067-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814181436.1598067-1-festevam@gmail.com>
References: <20250814181436.1598067-1-festevam@gmail.com>
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

Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
work.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Select via imply in board/emulation/qemu-arm/Kconfig. (Tom)

 board/emulation/qemu-arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 80ab9d8e1c3f..447061b25cd8 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -8,6 +8,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
 	select QFW if ACPI
 	select QFW_MMIO if CMD_QFW
+	imply SYS_EARLY_PCI_INIT
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
-- 
2.34.1

