Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06783CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B57839B1;
	Thu, 30 Oct 2025 14:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ambKKgUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE23E83893; Thu, 30 Oct 2025 11:01:47 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1407800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso640315f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818505; x=1762423305;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZNxbW6ERWikMraMYHdeyk1vAfpc9A4vrIaj4zwKijzo=;
 b=ambKKgUZC0ZYiLgrNjxb4ZgJvJIoqAchCNtEFwLXOSUtAxmKsckVinO5tmuVZ7Ob14
 q27sMuX+a1xIdTXZSOt3ZdmX0zIYldrhSDLcfsMRFa+Om2jgdI4EaJkkuXnjq6Bv2WTW
 D6o8TzCJJK+VP/okF0eydiXcmcevf6sXOpu4+tVcFoiKAaAMyc6sHVNRAZXY0fduk0Ab
 xHS77n0wJbA+Syr3PaNvBn2y3XliGVhgJpJZ2d1VlBq51z9byKIt58J+hGsN6jGfm+sw
 tOM7bj3Xq29SEynjApg0IceUhS8ZHbZRAR+Kmo2vUY6YfwNgDOOo4tOVC0MY6qLPcXmu
 9mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818505; x=1762423305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNxbW6ERWikMraMYHdeyk1vAfpc9A4vrIaj4zwKijzo=;
 b=QWuOgMfkg2X0r9hBEseeIfc4WBEWBPN5qj55gUpdMb8nKoAi4e6EdKdKWgq8YUo31r
 2Lev1Cau8cp3ZlCx4TNIFExxpsbWon+gS/JA8MGNC5A/c6A1yfze+GOZOgcCU9KawIUs
 FLW8gxyZM7up9DlBTs8Q3ebA7XjZs3lWhR5oX3WRZVD6nhrrKhc/Aq/bqDTQwU/+eDGJ
 gjfWlVksUsD3acvG/GC/VADyQ3dXEOYMlxkqM0fmrPQ2XbFyyeOMjOhBleSOB4UgRHf4
 IKdrbde3kvbqXJZNUYwkzVkNjpO0/DFkWywPI3WLDGnRvKxwBdrICalcKZ40nErs+D04
 ZaMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKc7BV+FPdeqWevjwVzfyddcHP2h0VhKByF2udExJJB27p2Sz/7fOeqr+mNo4JaI9fAjHdDo=@lists.denx.de
X-Gm-Message-State: AOJu0YxzHVUNgtXbytGMBe8hsy8AKIamOg29zIaqPvPUDuCtOCENI5LF
 opFqomO1X4GfxfQnOB8SPaM6oXMd+VWGAuddAZPjYK5+h8xovyxc0kE3kF/26HYJE7w=
X-Gm-Gg: ASbGncvvhaIdcNq16eYtE51jqwaHwFuRlPjPn1BmQ4Osb+R0b/69ssF7rYs1EPYvdqP
 pRPjENkIe4yKS7FLZbHnCPoUM4eG9BjF25hCwCxESVp5/K0Rowh9DyezbxWIpNRr0jZsQc951QB
 4A7CwhsSp++X0IsmlycmlRGPeZ9yuUcCZRZdKtUzaD/gJiqqJX7aRagZJSx9bnPx8VNsf8FYiNj
 PIHmc+iXAl9CmT3wBx68nYFKHH926N19ng59Xu2mggJyV2o9u0wzQDxEgV0fcs/xSqH2SBBTjP/
 589WUvnJEO6Q1r8qj6wU0grLIOdszps3PBEeI33uhYij1K0P+APaHuCaGFEPUj/iBY2F+NOzDwh
 trLv9gDyq5yEmMBE/nLDUPDLPOar0jfhDDz2l4wZ8ybJaN/Sej8cy2VgPKjmC+P+T4g8V0UeA9W
 Rem/8+/jsK9dcEjfKdvRo=
X-Google-Smtp-Source: AGHT+IFer82kgLYO8jiGeMxzFbkGG7cvl1kQxVBBuX967/ECogFmvYcdvjQ0HTmJi0hTz9MyS+tQdA==
X-Received: by 2002:a05:6000:2908:b0:428:3ea7:4473 with SMTP id
 ffacd0b85a97d-429b4c9b02emr2471097f8f.39.1761818505184; 
 Thu, 30 Oct 2025 03:01:45 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429b9b436efsm1756941f8f.23.2025.10.30.03.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:44 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:30 +0100
Subject: [PATCH v4 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-12-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=633; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+qyiUx6XLG5UhRn4foleZckG0VNlcEq2vd/29s1FPXw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm89Rr/KFtZ49sO7en6G1SdvW7qU3r6nT1roodfRtTa
 1yReVKxo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZSMJPhf9iRWP/aGwsNde2z
 jyjntSyf+PXb9Qn3Zect/PHoyU7r7tWMDLv3/Alc2/nte6jJXK6jBZIGreZVU7wypb/XnVKwuJc
 uwQQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c4264a5d9272228e468f7057c195593a..3a9f382193532dc3b712a1bd3fa16a9c0de3fedb 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -106,3 +106,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0

