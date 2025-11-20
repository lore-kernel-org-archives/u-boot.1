Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F5CF887B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BE184159;
	Thu, 20 Nov 2025 17:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C5rmwbvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01DE8409B; Thu, 20 Nov 2025 17:05:16 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E483283935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64312565c10so1473607a12.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654714; x=1764259514;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPlhNJYJ2bp34zf3iWtlyd49cNmFUmc7Y7jbQrgWnC0=;
 b=C5rmwbvq/WIpIu95RHsDStPN4SiEdMrRWeYCFZzqJcUi1MH/IZD7wDo2zni/h6BoXI
 LLgnMK4z22TUAFOEt8KJt+nDO9aNnfb2dHbscTMqkbbI04h7pKEsQDLFaY91pdyVy2K4
 S3QDDIMYCYJ++dqNMt/AVIC2YSsYljRaGDTvLQFxEwsvq1Bkimftn5c6pryayr2brhOx
 GqZCfXrLIEfhRFU3Kj5uJe6aIeTl/QTVpsEIF1Joy90CMbmOHjRD2NSIieYsvIAsOZue
 SNmaR05xOcoPlRtU8MLxV4r7k3Qb39g/r4qKFaiN8IfJgDUY9MPWDZ3E2fRmX6RI7VDr
 cbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654714; x=1764259514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TPlhNJYJ2bp34zf3iWtlyd49cNmFUmc7Y7jbQrgWnC0=;
 b=cIV1oMafhwUDkeZZEd6MKn03u5JdgoO48Gyw0wONIosOMH22JYCmfYgyW3RN6qB74V
 tqVoaHjVNaBsGH3IYZQ85WRqtRVaLzGiwq6auOmpsyN1rNp4XKdS66cemjNjPoQ2hXd8
 cZdLTqcrX+dtaKxcB50jrfCMv9fYztXhD2U9BUu/SUlo418AAMBnWrm3T+pfQq5CsM6s
 oEHOxFlDejOx9gml43wq10geDTUc/UYIgp8D0PB/Hy2+umd+n9ivq3bPItydfckXpjb2
 QWtVZj6jR9iO4yvX0c2w4cfIwUj9mFGkygJ0pcQ3uxqq1RtCwex5CpA9Ke3aMeT7AokS
 25Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBScVCbuJqo5x34+30ZoHu2c2/aSaPg1PYnBW+bDXCPaW/3cTsxBNmNMFG46dXgw49ElrzrXE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx0jtrHZFDgVk8kPLiT/d7IDes6oHWI5C0QNN4SWZevC8DDLqO
 GMwm2NjVORdmY/R+ozb0HXEtRie+IWztV6DxM7ik3yFAJg5mv3Yy3JkwpL4WVBS7I8c=
X-Gm-Gg: ASbGncvIOgChOhkLPXjIRKD9/PVIXjD0KZtYohF2pppSC+A63wXLo5VKOkV8eDG9Q/v
 Aa7f82R8E7N6FkodduUW1n53V7OLdIFZ7sYYmQwlvT1NGuqQm5HYUEaAH5lhHBbpUez7sjPJt/k
 NcMJMHYqANgwVq7ZkUeDC0nVkTDxJJYLsg6vqgFBpph+VpL+xW0LFCdQXtVhX2Js2iE3w5lu5x4
 POxfdF+hAVLWl56V0iFitwbSYbMr5nj9GMjylSYcKamGHKP5W/KsE+XEMdSH2oMzi2Udf294FrV
 glJm1EBEAUfQvpYP5UAw49ZwL0D7a8gBIBB8kYVIvSej6e6fuSe8T1hCtA3kZqcbMUFnQDcu8s1
 z+VaBc24h+/s7ca731iRBG6XNITAm8AzxFY+HaBuYXwSY3Mm+9zFxWQz61ipYTU7mqsZ3pn4rWY
 z/wBI3R08=
X-Google-Smtp-Source: AGHT+IEOjmYRjDSBySaJ11wh1k4EyBWM3dAnUPROtBhOcTkuynK1Bf4ahqE5kkvZwEd0jeEqD9CvZw==
X-Received: by 2002:a17:906:dc91:b0:b73:59b0:34d6 with SMTP id
 a640c23a62f3a-b7654f66a19mr353239066b.33.1763654714305; 
 Thu, 20 Nov 2025 08:05:14 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654fd4e8esm232969766b.41.2025.11.20.08.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:13 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:30 +0100
Subject: [PATCH v6 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-13-6dd99a7271bb@baylibre.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xE312MwWJYB3Y+TfxMO9glPGHryfuKbJAtBHWFon+ww=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5GyVzoUrjwo2ieZlrNzSZL4nzfJbTGdHp6hAW/HeZi
 FW4VmZHKQuDGBeDrJgiS2diaNp/+Z3Hkhct2wwzh5UJZAgDF6cATIQ5hpFhrrBKuFMfp7RI0c/t
 fg5nY35OZpv8c92X7/oO91mWXuBex/DPVtY3N+RGZlfOn7cBZlPcp/TdYDVqjNO7JuG3edey/Ye
 YAQ==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0

