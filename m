Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA8CAC5AA
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D4F83211;
	Mon, 22 Sep 2025 15:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="a35y76k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256A4832F9; Mon, 22 Sep 2025 15:06:09 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF9382CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b04ba58a84fso742610266b.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758546365; x=1759151165; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BGTQ0C330rjkw2JJTzNK1dKSaQtu0GxHJOSBlfyQPWo=;
 b=a35y76k9NYtEijCZRwR6cppsM9pcwCONRkg1F+Ut52XEx8KJnU8yEud0RovEzoAx2Z
 V6rWsfDjhLalciEcYzL9PdhZfxRb7d2tSQbCOB9lJe8WPBWvnCCqaoBvjABrJSju+Gl0
 Ayc62wMb7kPT0XJNe1bCro/1QvWyG7Y8VCc201UPaCk3OjHT5JcahARWkC5aKNpS10ug
 1VER47I6k017r5FvEwdn30bF0uCMO1syMTeR0MoJKQveE0AbtVhXz4ExvMvWNcwbWlTA
 B4q0/nq7eZ5lQdRbgGmU0c4CPtqrUw4Ky4EbNSdlJCTZnpGZukQxVUoYH/DOSm2HOiK8
 ciPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758546365; x=1759151165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGTQ0C330rjkw2JJTzNK1dKSaQtu0GxHJOSBlfyQPWo=;
 b=PBgdE335mKLnHSKSi8kltYfSIr8urrkc73aSLpY9U2DzVhUmW9+KAdAq1LKzQ1pmYa
 mtH+myqFOGwuBlgh9rCmAIlMSX/cOwLbSNE7AX6Ua99aFouwjLLxiPNfLPzVK2YhYltv
 eWXreXSFIAn3nlMY3NJWJ8UN5mF13uLTjQSltx5kX1CADDhpyta0BhAeG1y5Ymk5KMni
 yg0XcU68ofcxssIZI17CPtlWgv3aEH4XRiXEl06IOt8Fcq47Yc0j6XVJKqwyTk1CVgZD
 ftVHxQe+eRRGr2A3igVTiP8iFIrL/RBSbVnESgmT60J+TGlPoNh4TNWfEGOMeu4x3z4S
 5kOA==
X-Gm-Message-State: AOJu0YxuJBP0hJU6Oswd/E9tkuooxHcmeByxiniCVFdffLfFW/oXLGPA
 j8keS5gofVqCIyJKT35TeLFAF/DRXCEe0S2iUY0gscx5ORsUirVIRZOc+Se5AA==
X-Gm-Gg: ASbGncuneGRqjOCBSWZYK3sNUK/e1dqhS8kxasfJZZYwQU5Wn6ScWVqLxvI6WNT8vle
 vlyzpCGITSumaVzcofPjqt1zhKbnwQgFtoDWZZbkpor6613CKhoObyODm6XfahikKQmfMiAAh8Q
 Vo8LXJIqJOG6G1ipI4PlMgpS50ppghFeBAIkEB3NfCAgrLjZzWnDW/7U6S6IZpZS8raxDkR3NHr
 MjdHFqUz/imkYxVHuclQ2uSyWhWlnQi/zKcsLVBr5IsVKo6xvKJplZrd4X2O8vcvoe0mlOWUtMt
 YnVXhvTc5FueeZ4PvLx1HLjTY8RGqW5Nufi8fLxiogLS0c13ZrPHt0JJRvsvdNmFjw5ssy/SQ+P
 xIgkI+UwHA5Pwsc1J/P8odQ8v7epMpNvz+y1qUk2ZMp/vUQEI8JPyDoq+c+8pVStge27s7Wm9jl
 f4fBc=
X-Google-Smtp-Source: AGHT+IFW5PfP8iNDjIWqphj24sv1tWMxawSlvDvL2QrUZL/pT/6FaruHSgppg4k5rxSBXgIlr+4fNQ==
X-Received: by 2002:a17:907:d0a:b0:b04:1d07:40de with SMTP id
 a640c23a62f3a-b24ee9dbacamr1476246366b.23.1758546365080; 
 Mon, 22 Sep 2025 06:06:05 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2bcb8c930csm297920566b.26.2025.09.22.06.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:06:04 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] usb: musb-new: fix ti-musb dependencies
Date: Mon, 22 Sep 2025 15:05:57 +0200
Message-Id: <20250922130557.4178098-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

If OF_CONTROL is on, ti-musb.c registers a "ti-musb-wrapper" driver
that requires UCLASS_MISC. Hence, select MISC if both OF_CONTROL
and USB_MUSB_TI are selected.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/usb/musb-new/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index ad9072a5327..acd6e3decc3 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -40,6 +40,7 @@ config USB_MUSB_DA8XX
 config USB_MUSB_TI
 	bool "Enable TI OTG USB controller"
 	depends on AM33XX
+	select MISC if OF_CONTROL
 	select USB_MUSB_DSPS
 	help
 	  Say y here to enable support for the dual role high
-- 
2.34.1

