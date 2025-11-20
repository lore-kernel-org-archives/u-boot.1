Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C1CF887B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96AEA8414E;
	Thu, 20 Nov 2025 17:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ENQEaEmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1C58409B; Thu, 20 Nov 2025 17:05:16 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1E183E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso1864934a12.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654713; x=1764259513;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V8NgsF056yXiTjf5DcFupAioiQt6PkMA8vi3f+0C/ks=;
 b=ENQEaEmridqrxqhmYVojG3YuxRTvPtv0bL7/Y6bQX4ruuNT+hegoghnhFIJbS2UV0Q
 fSHC9SKRILGIkELvnXtaSwrIyK1iOIcU1d/LNs4ReBTgrp7sE57SAUts3SyFHiR5oIIK
 kEENHmnS43aSFQJR1aLUxpa8ljwyTyPDAWOexmDzdbi+hnaE+tmMAdsw1AFN0wlqMNd8
 UounTW9XJllQJP64Btc0BAl4M9oXCuFYg4eNmfOD9qmrRj/ehFfBFc/zq9Tmc5hZNJHW
 EUNgl2kYY/zjfY5FDrxsHzzOUEVusTPZhwQt6bXGrRZgiegd6VCV+dCZAl7/l4cge84Y
 +z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654713; x=1764259513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V8NgsF056yXiTjf5DcFupAioiQt6PkMA8vi3f+0C/ks=;
 b=EOX3k/NC9jyx4pgEDuFjXbVmmr0aL7aK5sUXE9JJqL6XUIeJV36C1wx9B4XOEKzNhT
 TgvcToXyVNdeBfmus7Upu8oA3Is7AJs66xQ5T8qPjs/HwXMLNjAgNxVLCffH2q/Dw/7u
 XOXwWY0MgK5mQyu8b04S+9Lauwbx4I3v5fq4mWllcE5QcN02xiXyxbnXFrx1QjyhPsFT
 byWWu9Yk81tNjY5AKPdQ/YY+sKSChFKZ08OC/2topIwKBm7LTyBlyunciN5zhrFQHcES
 EqZc7h2/0bCQRhEhz5noaxgV5vxTymGTCzl20iGOuQ6QlIMbNipTVgPlUi5nTakReVG0
 0zIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwuhk1ixPqxWI81yqRH+Z5M2NjtSh/TurEg1gq35C/tpwA2j7NVaqMYFZSJ4DB6iJB8HKvrIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzjuKkaW0SnSWmYub9YMD2yynEcOIpoDuitn5vuKWaklr+WwWcB
 djZggPajwY9+irHepScQRMm8VBruWgylkk+je7Fo7eVmR4x4XogrDTVOuTHzOIG75DA=
X-Gm-Gg: ASbGnctP/ipCWoHSIYfxpapFnFfJ+5Iw8iN8VvWZMo/j/+yGXHDe2fj1hYFN16Q2xO5
 2mYQ9pNWS54YNpcbARu4dVxZDTI0ujVUTyXKEbm/vcGcQeT34zzjsiWUvpnHz07MPdGpxCseuQh
 x/4VMki7qHiSZadIkr1sy6pTl5mY2STNeXmTZCM4kZGVAsDA/LgIh7Z01WI6xC3xV+ViJdS8l+4
 YuyIdoQDfvYipHlf8UWvdK2qKAQHIQkNg1fz8NcW27iDO2EYEJW/UbLUR4a3x3CtxXRLbVllbZL
 98/gJisIaxF5CRFTbEj8iqQgumb5sOUAzjbFCLnLB+COLsCR75BS+17wBq2P17G4AluiXNts0is
 xKkNyBzh7mrov0SfaDX4bAOqoqp1J7dJV/QMDmVHs8QsqggDh0EYNXig/NNCFLVl4vgqZSQ82qy
 ySIEQV9obZhUBBLdr4eg==
X-Google-Smtp-Source: AGHT+IFGkpG6FJwlE0jg/iPLJYugh9enLT5Qbej3bb4J30Q8iEMGU6cpdiaaT9sJeTasPjm4pRYlXg==
X-Received: by 2002:a17:907:1b11:b0:b73:53ab:cfa1 with SMTP id
 a640c23a62f3a-b766aab5200mr6060366b.17.1763654713202; 
 Thu, 20 Nov 2025 08:05:13 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6453642d307sm2411632a12.19.2025.11.20.08.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:12 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:29 +0100
Subject: [PATCH v6 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-12-6dd99a7271bb@baylibre.com>
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
 h=from:subject:message-id; bh=AGImpFbVBJuRtcp9Ub7WW+ozUrt8YcqQdnWEa9NLxFQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5G9k95r2iPQt/dH8K/e/H2aLyP/Xhk5V7p4o5nk7d2
 X9QxeBiRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExkXgzD/6RX3Ps75u86909o
 1TXXn9OVb23X22qg+PT1bx7vv9XB070Y/ule+6ax08LEY4fImyfbjqX8nGGy45Xrj2lLrQr2FN+
 NeckEAA==
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

