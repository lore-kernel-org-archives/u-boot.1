Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6E4D6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11BD89641;
	Wed, 20 Nov 2024 01:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsihjcQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37623895D6; Tue, 19 Nov 2024 23:46:59 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4142B89431
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3821a8c7c5cso667214f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056417; x=1732661217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+gTXKkoNCmg09HrAn3T7WBqGC7JqojyYDP79MXe0rg=;
 b=SsihjcQnhwFoGDbm2xNs9DB37z0BYFLS7FfK17erP4iwOF9NvM4a298gtQYxfX+SiM
 cra4nD7tzKvaXvd3mcIyUCp6TOpZLBgiJqcMsVTIJGDO9upHobC/c9PBu7i6VmAq6NW6
 z1kplNrSVQrm7MI4IebU+XxQDvtSG4oXxGd4AenK7W2lx2vZWPPDSK+cJNfwj88GkM27
 Q/vrktqqsAwg0uJZsC1kY2jjzI6LGTUc68DZ/fCuCMvHmdpgs7Sgs8sn6Q42ar8qpYGq
 KGxzPgRwdRbvDGmNNKiWsfxYhkNAA+r+oquzPwnzP8kq7FH9XjllyyEoHGvBAayijSub
 NNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056417; x=1732661217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+gTXKkoNCmg09HrAn3T7WBqGC7JqojyYDP79MXe0rg=;
 b=c6TwUp4exAfuvmFcfijGLO4RTwLUYtu5DJvp54DrtlEzQJC4B01UUbTWO0/GElxPap
 TFKWaqCm3iawDG7ev2kJsXkSDkrRd2hw5zT3P2ZcYh6h5iOlcPBaMD/M2i4UpRcjr1JN
 ogfQdIr3fH6hgtq8z+q4XlGMdZTslBaOQGA2kCmKFAD0BO9Nsw9GwOTHdrdlGRb5fome
 vNPlExiSDvf5Du6SGYHsq1zhiYWzEBB65vkFXAEQKQJhOZSnUAyiP+DOYRhZzxyLvBg7
 4rk0LV3DXHC88+7VOl7MIe+gbW88RPxetFtraXQlrG8uxGRF73sIva508fx1uCtUjVet
 DTcA==
X-Gm-Message-State: AOJu0YzSphUNuRP8P1KoFdvTulbKLhwtp3Xned2lzKdspiONlfuO6jIy
 TJmq5SukqWPRkB56HjNsFCiqg+9uGJiIJPWlf/PZo36bmo6EtNAF0YnvSTDX
X-Gm-Gg: ASbGncuhc0equUYowPIdjg2fkvqElcs1MYm2Ao1Wh6/OMAUynzRuVW3Ril82aZMJfpY
 o+SdIimsgl8hzkaiCwWX23IFZbq90f6vrUk4/niOyf7Mdx3iHStg5sVQzfWHBKvLHkMVj0lqhR2
 B4Gol7TdtHi69s6KkLjhtmo8Hw0qw+/fWKv39Jyr3kiQJs8yM56pSzNspB9IuRlvMkGmsS7sbhV
 8EiLTv9LHO7slqzZeV4BeqOWzO+EtweB9SMz89hEwa2sb9P9bGPTv0a1QEdO0jLDqoUhD2wlvMP
 M38xwrL5U1CV4/RW9bqvZYiUaOLu
X-Google-Smtp-Source: AGHT+IHXu9IP6C6fXdxZ/m7tca1C+rffKvfkh97i/TiOOdFXgLS9ecmDz+aorLo43+yElcwaIBGM+g==
X-Received: by 2002:a05:600c:1d1a:b0:42c:ba6c:d9b1 with SMTP id
 5b1f17b1804b1-4334f01d8d8mr2138705e9.4.1732056416645; 
 Tue, 19 Nov 2024 14:46:56 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:56 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 07/10] misc: atsha204a: update kconfig description
Date: Tue, 19 Nov 2024 22:46:40 +0000
Message-Id: <20241119224643.27692-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

The atsha204a crypto chip is not only on the Turris Omnia board. Extend
the description of the atsha204a kconfig to cover also other boards. As
an example the Enclustra Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f40..90fa8c9eae 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -73,7 +73,7 @@ config ATSHA204A
 	help
 	   Enable support for I2C connected Atmel's ATSHA204A
 	   CryptoAuthentication module found for example on the Turris Omnia
-	   board.
+	   board and Enclustra SoC FPGA boards.
 
 config GATEWORKS_SC
 	bool "Gateworks System Controller Support"
-- 
2.39.2

