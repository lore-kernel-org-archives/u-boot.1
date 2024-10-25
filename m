Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDFDD1039C
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 02:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6CD88FC8;
	Fri, 25 Oct 2024 04:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvugLQ7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D5E88DDC; Fri, 25 Oct 2024 04:02:42 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAD588FB7
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b14554468fso98328785a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729821754; x=1730426554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5Nb1izu2Wd1J8OL0vWu/TL9qDa8++DVpnU3OSHdAL4=;
 b=WvugLQ7Az5qZoAbStXBDMBaSUIk/OTfDArBTYw+A9OqbL1LSgBW423AMlnJQj2ObsD
 JWZDpMnjE50QRZsYkm3zkQtV39YcM7hbW/rV78p/9Uz/KqiFXEetzr9f9cupEgejGK6W
 jO+RyjhaNe+l40V7rcH9dVaXtxlQ+68mOqXGkhkxZeLTCEQFLKwLN/TXghIhNMLs6Shb
 2BgNUBJnFLruEov+FS00AFEWhtpx/JoxuV4Wm+Srxyguvbe2gNAzJ+Br+OwEprczql1s
 ffQDtVNhm53W+GfdYEslk7debB8FP2hQb/2QKC0OSCswhW1Yx1YKM0KkOeEeQdv1Clr5
 0ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729821754; x=1730426554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5Nb1izu2Wd1J8OL0vWu/TL9qDa8++DVpnU3OSHdAL4=;
 b=e7tAnvlirXKiX2jdIL/Bem4sulhf1jBZpqH9M9pSSxZj8atR5cHIKk4JZ+xj3QTVFR
 BNGkMpTOceuJ+lK/ARRddTBuluk0STW5TNyAIFB6t/fgALoYF25iiOkEZFypLxAR+akm
 /gW+OlwXNIohtSLSLsYlKb/rvp4RXtnGS7I7JDNrpcH/mK4CNnc8Hy9f6VdYGUQhhKoL
 fnqeIE6lyemBjqrwr2eVd0WTAodCR907lz+wujFAzbAza/Tf//XKOMyCNz+Im13p1d9G
 IKyno6Ya7K5VaRp8TwxgDGu9ZdrMLun6S8qLvjf4/1Bs7Q6cuaP9glGwfDnhNt+1kJcf
 02gA==
X-Gm-Message-State: AOJu0YzXN5UIO+hDC7adE22onX150GdUccA4tg7zgc/vJZaavZydAzT3
 QwWs2RPrG+AKheTdmf4BDPlVaGyKdgZi9tX0q4Na9TzuhtkKs92UoYNOGbpJ
X-Google-Smtp-Source: AGHT+IHc3qVAqigy4OKgOADMPuXjmzA2N8vZM/fauuGNmSGtylfC+zyc84nuXJdltLglVKQ1MYFGQA==
X-Received: by 2002:a05:620a:4249:b0:7b1:184e:a665 with SMTP id
 af79cd13be357-7b186d0f689mr510560685a.59.1729821754158; 
 Thu, 24 Oct 2024 19:02:34 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294b3fsm11607585a.33.2024.10.24.19.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 19:02:33 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] ARM: dts: imxrt1170: Fix default cells value warnings
Date: Thu, 24 Oct 2024 22:02:28 -0400
Message-ID: <20241025020228.1686306-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
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

Add #address-cells and #size-cells to the memory node to fix warnings

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/arm/dts/imxrt1170-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imxrt1170-evk.dts b/arch/arm/dts/imxrt1170-evk.dts
index c2fd0c0392c..0d8e7016860 100644
--- a/arch/arm/dts/imxrt1170-evk.dts
+++ b/arch/arm/dts/imxrt1170-evk.dts
@@ -20,6 +20,8 @@
 	};
 
 	memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		device_type = "memory";
 		reg = <0x20240000 0xf0000 0x80000000 0x4000000>;
 
-- 
2.45.2

