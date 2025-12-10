Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A57D3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77E383DA9;
	Wed, 10 Dec 2025 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vyZUwtLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93850836C8; Wed, 10 Dec 2025 15:11:16 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919248042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6431b0a1948so11615834a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375868; x=1765980668;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4NQ+lWidNj/+feQMRgBifTtISRExMJTNPAtjyeblQqs=;
 b=vyZUwtLLzm8+3sdKSKBZbpEIIQgxYzs2XhBUtFOj6aH2ZgPzHdWBuDZTHi5MJX4d3T
 TaZjwyqiFaFAYtVgitfgS9j3R9l2mDsvxxhgc+sSZHBh8WEOVmq0a2fOx7IRFp3c2HVU
 om9m9GPZs1BFmRv0fE09yEl53+FIl1s/1FeqZJ6I8+0zeJZ27H6Qhb5rLFLFnFSKRzvJ
 XR6iGVZuttWGyEW29p6x/i4zDXUHxvxlSg6xnMnZ1M+LBUNFm6dHst9UlukgBCdExFX9
 7StSWa+RL2ZONlOJK3sKxijPYGklDA8441q+M5aNKLnMu21U2oJ1qzp7fIJojOUKhIpv
 NJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375868; x=1765980668;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4NQ+lWidNj/+feQMRgBifTtISRExMJTNPAtjyeblQqs=;
 b=JHQVXwJWEMqr9lf3EUa8Fprrg/qy2TuvIgRBO8DJBP07BU4GakFN8igYpt7T215pxM
 Pspf1fse0UrbIZJt2HI+F41PgjarkUeM5StvYzPUmnNeK5lHFmX8NOSCgajAwKkdRM+c
 t1z+qOfrpMPpMCQMf8tUmTYmIzztpxvgNMRrr1sNlb0FkU3IJjGX23SRkbPxhzfqZ/FK
 5CdwJlHVraKxFz8x5Mfwhkrgp7kGwf2eoASxprjp4MjJZck85W5padChMEAK531FnmRl
 VBwgLKvDiZtYaAE+dc5lTz+CznNsXDd7P9QH53wiJJ2dl0gRfOc232fpoBDOMI8zBMDv
 3gHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO62NSDGbfJARIATW5HB//ibUAKfZLo/umnIleLYvrEgyydfWFwgvojtCQ6DvQdxBgzK8Gub4=@lists.denx.de
X-Gm-Message-State: AOJu0YyqGty73BiF7kuPGe+mrLH3d4YbY0BPc4i9LPlisfQRm4pvNHUw
 vlPC5/aWiRzt8E8hlYxHdTtWKgntoD/JVke4WiJasz5viz5wYoY9YSIzEInj3TFdsesSEgXrfLb
 EDC56
X-Gm-Gg: ASbGncuB6aTbfC7sq3cyXK310h130cQ4Knav/mbEJP5525kUTl0fdyZB6xY/VTSdyNq
 e+ycTqhF8tae0VI1hq2HPu4WMu3lGPE1svd65ZhRyUtaO/pB73gGXWrxbtit1YWYux4G9fQbzkx
 xvxU6M06/Pdr7XvPojzXtOL6obR17nUcZoiNMHJcYvVg4kvLyzc4JHuZ5vYAxf1E2FvYf8t63X6
 Wbj+gVz4EidPfvB0UW7zM64sYUM1KPvTBXScUBVVlqQ4xJ8bwG9lQ1KxOuVEODPbNgetpIFq0M+
 f/e7Gr/dggFYfEnWcXPBPdc8PxV8zEuEKfqaLl0EtsjO3wmFtXkJqLhZI20vtenXjYxXvjRMz26
 1bcpxd+dP56x5AOKImQVzxRl27HBxwNrQ2O0U32ugJ98yD85k00+HSdAOQ8iwO8EPLykmXp4Xdz
 ggWd7Wp5dMrOvhnlnEoyk=
X-Google-Smtp-Source: AGHT+IHs2hQsecwoO0LW/aPlGXdCQkjgHQQ+zEyJC7x+Dq8nsjK3q777ytfuRGxCy8Ysi0qlT/j/pQ==
X-Received: by 2002:a17:907:1c1f:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b7ce844ca8emr254359366b.45.1765375867763; 
 Wed, 10 Dec 2025 06:11:07 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f44d3d9esm1659997566b.30.2025.12.10.06.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:11:07 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:06 +0100
Subject: [PATCH v7 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-12-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FbC1rUTuScXeOmf83HpDWbtQ7H+tS92iS+oVIblF1ew=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzL+uDW67tlUz13uar71S1ms/pwv+3L3fmr3uf3Ppo/b
 8rjcM+gjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhI4D5GhpaGTMtbimlefgl7
 J92YZjq7+vxLFcGfOT82OLr/Pd/PpQFUkXy9tuheQ0z05jX//m/ISZ139Jc2T+4aT5EPbZ2T/Wz
 4AA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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
Reviewed-by: Kendall Willis <k-willis@ti.com>
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

