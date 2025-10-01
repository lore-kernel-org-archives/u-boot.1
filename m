Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD5CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F1B81D6A;
	Wed,  1 Oct 2025 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QlVtW+NI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB48D835D0; Wed,  1 Oct 2025 15:21:25 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72118344E
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so1364645366b.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324882; x=1759929682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oirO4392Q3ezp+UcVySoHf9KAwFXn8LTi8iIMQf06k=;
 b=QlVtW+NIc4PoviEvJnkHVQsOz6znzqe0RW36T9icaAK0t/GvaOIMbB9Z45A3Zid2am
 UWlE603DXJmhqyPBlTXqI7I0qR9ztol+2pjbRuKuR6F3agEYd9Uh+Kifs5eC45YSVjGc
 vvGRfwZ63uaZ+qgateoarb/lR9f5k8gOqKU5NRMaYxazNXBHdZOgvFQfUtO93FZrQCkV
 f7nIvaa0cZ3erKbwiQFM7AGm6QsbBweqsMSEBjEUyYq5iGspcdnCPn3+z4mZiT2hHmmk
 nN3hIe7DrC95b5Sarui2yCZ+0wrCFSsfO/rMGUa/MilE2/oxBLcsYnZEqMiDM52+2hF8
 2V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324882; x=1759929682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oirO4392Q3ezp+UcVySoHf9KAwFXn8LTi8iIMQf06k=;
 b=DEDcPS22YxG6ZU908HVLKG//9aowxVl9Q6INqZzRUcvZWt/r8cNgKuqH0Tqov9mm4g
 IN6oEv1ArdXUdE89hntmvX8NkJdhXeBPCFDkA3oiRqWIibXR8RFOSfvOJ3Ax0bELClam
 ze7kHUd8sOb1Os+veeX3/X3KxYGms4hJYumTqhN6EXgLKrVuXSVZnK5I+KVpKVX0m4Bn
 pJLYWAIiyKbVvda5KBRjdODKxP2QAVEcW7zrJY7LztxfNF/SeZQyGvS/Q5ujyOiUzDw9
 sohHzxsiD858DssLMnGOJLuF33hwGve/gIloXaB+3AsUkIhuqsgCqmebUEWYpk48KtC9
 nyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRl2Q1iBKNzjpyH2irGLT6SAk3LQ5+lcYBdRFpVG5Ji0Vn9z+6paIrebbfL6VSRR7vRF28/lo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8NTAO5OYJ6TDefWT0OHyPfR5bA7hN3KlmWIMIzFjSnNvCreS8
 EGATy6OZ4J3J5isYn6lrhG4IyxO3tiXKHCngW2yqihU54Y2ikqwdhzsW
X-Gm-Gg: ASbGncsbEXircrc7DLg06nVGcROO/n9QFWJYBHtmxPPt49/h57Ad8Cwk5CT0nKoQfht
 Y4W3rbl8j358tzR+erjCo8LBFsw0nLM8aZ2Ff7kBrQZzM71Yo8VQhuz49WrTl4p8Worvg8G//P2
 zaspPQHJLZDEy39PzSnkO+0uXQ8uXpugoliAnSiMHXStU2DNbamLkpY7VDUtSxNnLyTtfCTyXCV
 l3piiDP8Hmj/oRIzyUqix2iMZ4TyhiuL3UJCF9yvj/5fMjGd+F1BhZ5iwBwEANmTfWLqDq4MJos
 3a2jcLsCBNNEZFiMT1wthdXLx8ClEKXItg58AuO7yt1WEHj/6pSntE/vKvoJ2nZwwFnOroh5qDs
 QDjwIMcncJtd6BBVj1JxVS8c/cATo1x1/ZT1k/OIIdAr/ZII+H8S7Benh1Lgn1wpzIHYGXGq4NN
 PDVPyJ9l/cG+uZWRAW/GmJPASVinUKuRGjfnQVlTd1VI+gc7pWDNLTBHOZ6v4aIQ==
X-Google-Smtp-Source: AGHT+IEtgwPOruHQUv++WpexvHFFlGKclpTKi0gEvPdPaq4bU0C8ilJltMBGf060ZCZtwTjc6nBZXA==
X-Received: by 2002:a17:907:7294:b0:b0a:f3f3:a28 with SMTP id
 a640c23a62f3a-b46e585ce07mr423330866b.14.1759324882067; 
 Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b401d3d4124sm566956766b.75.2025.10.01.06.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:21:21 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/4] configs: apalis-imx6: enable USB Gadget OS Descriptors
 for fastboot
Date: Wed,  1 Oct 2025 15:21:04 +0200
Message-ID: <20251001132111.1490516-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
References: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/apalis_imx6_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index 7d54205938e0..cd9811aca616 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -124,6 +124,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.43.0

