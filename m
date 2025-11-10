Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA2DCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD7483F4D;
	Mon, 10 Nov 2025 21:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aJboASF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5870B83A98; Mon, 10 Nov 2025 21:11:55 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E0083AAC
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso528868666b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805513; x=1763410313;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xny7skziXwZhA/ALHX6YBX/He2KmlPgGim3Zv6mNcco=;
 b=aJboASF/DGKofkMy7f1zGNNzfbshg4TnAd7RSKqYZ4l9ToGCuG0zgh21HsJOyt3q9R
 KFGNy3oJF/ejzEyl2jmkq0gN/mEzEy68IVpoQ1+U0SmJjVMeJR3ncOL3vp5ArMRR5Zeh
 Vb+of3HlXCPdM9xbas+jK2RxUu46SIipJYQD84aGzZxcGNSGx7yRwxLJVuEex2kpRmKb
 c9oLp5FDWtXPCdgIZayKqHAyeR8XWa4T03CZYqJB5/TJbrvVC4WGO2S8bS1I+oDKQ9OS
 dHskDOKv3mo7rZF+15ZcRB/vGSopgeTKnXNaDYriiVljfmN+dBd6LfShkXY+pJ21WlCS
 hRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805513; x=1763410313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xny7skziXwZhA/ALHX6YBX/He2KmlPgGim3Zv6mNcco=;
 b=hKQYis1ZhPnGYzrheJX20znlUQYqc1yJoHtQMBrdWwE7pTqFbnqPTC1IVzSuXZMj55
 LP4rEOx2Q523VuO8udp4U6P9TP1NTIwEYcOLw8wJV16lTChMPRXps4G90go6nmrIT2ni
 ZAWXyy1kDYEHoRvokI30pi6uXHaRFNu20+sTZ1CDZAA1wW5bTfKy31Gg229y1a3XkMl/
 W/LuSAmrCDgqoghDfa0jhuTRDSFv/blt5KZISm67E2GDFUHxAsCPrbUEsHd/bTIsu9a2
 ShyxadzHnhDRv4IpgOTOrjNLJ7bSAU2HBKZecxdcYB/bmuKzhiVLsyI8ool6FfoLuWrN
 NsZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhJ2PEUvTUCexE+u//f6NS6N0K2bjz3hZ3UMmCHkuY1VdJ9XSxt2vkoAqMHSVAVKIgOGk5Qws=@lists.denx.de
X-Gm-Message-State: AOJu0YzURDn9D0r0LgaZeTx7bZIL1OZjqUTOBFM3YM4K1r9EafD9ine6
 16p6WVLb/KXHrR5Qp6ZL5Q3af9ft9B2OzwUNoc4CBwiqDyGM2Hnhqn0mxv9npzCzve0=
X-Gm-Gg: ASbGnctwnLD7ytw+4ZjrRktf2EmvHhMfa+hMO/v5A68jMcagwR9T9SZ2ZOagVGADimA
 zw11iACmgoHXoHa1NDeT7iUbohcPOm/0CYjPtjaThD8sTmwIL4nH0JTQCBed8Kw77pASa3Xdqp+
 3o3LLg/5Rsnk8QXtzxMqtieDvtJpmOUxkAZsUF8bEILsaTvNTN5y86qK7tJis5m8O73e8m8PJu5
 I8on+AiyTqtB8+bVUEBN6XXs6nXFc4wvEznGsxcTZeoS1wtbc+29mbrJ1n9gyuAL62lAdvSplhC
 gobaRD11+YhqjKnccOTlpUOMqaJkMb9HdXjVEWlRFCDt3Ttm1U6oy9nRrNmY3zMnDqj5vrVdMTj
 WZ6EIGkT6wBBhvXiSompZAlV5ossrGsAEh4BvT7Oq9u7DfG/KcBBcIhwaD+xn//ZAc5H39NyCZw
 Aj6pI1bw==
X-Google-Smtp-Source: AGHT+IGvXZrckygh635EWf87fT9zDDljn4yq17WPcfFe7fPCVWMVZc1LUxqipNodTI33I/CBfI9e8A==
X-Received: by 2002:a17:907:3ccb:b0:b6d:8385:2164 with SMTP id
 a640c23a62f3a-b72e04c5200mr888181666b.54.1762805512792; 
 Mon, 10 Nov 2025 12:11:52 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf97e447sm1242048266b.42.2025.11.10.12.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:52 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:35 +0100
Subject: [PATCH v5 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-11-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I2WIWrzTGwlvqucEtjNtIVhplM8Na9O0kf0e2P3kAvI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht1d8xt1y92tWLRQs/F+rsuH7sd9Pd7elFDDIzTprF
 Lnw3vPfHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjAR+wRGhrmp5999sZnmuHsd
 l5zWZPsbb3W2CO99PvGUY6PNBAHVe5cYGbZ89Lom3BTHpTrrWg7LAkHOKkU7/op/XVu1vm5df7x
 RngUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -11,8 +11,28 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
 };
 
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.51.0

