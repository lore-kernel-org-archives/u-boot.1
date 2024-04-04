Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF05CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52AF882BE;
	Thu,  4 Apr 2024 15:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feHVlK8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5278828B; Thu,  4 Apr 2024 15:20:09 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D12E88276
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d84a5f4a20so2170801fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236806; x=1712841606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2xJmeqV7J9yDPWcWLWnQojhOFW5Vl2ZjST8ffro7Ow=;
 b=feHVlK8KJ4a1++cHsMVFkYdcmtV96FJ0XskBlCk4xDxm4GYzrjWwkkjAF74+VeUp71
 VajND63WuwEG9PbrrqZYvQ3/p5nzOl65X/Q1j0xXjdz12Yr7KKHf1iT9sl7XoCKMBrn7
 b5aczpSA3KJg87Sgj7xune0UnFzZzFSrJm1hs0io9Qcc6EB37vUorZH4aAn7XIy9hIuq
 WoovLzXawtBw6+b11y7yNshehbwUe20YmOyTqoxpFhbP79ZuxYHChWaou0RZ6ECVXJCS
 IQUrPK3nksLznlHTiJURegs/MEyC5tTSWnCdr2MzZV6yy9oR75Zi6bzS1htSVyJwc6b9
 qQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236806; x=1712841606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2xJmeqV7J9yDPWcWLWnQojhOFW5Vl2ZjST8ffro7Ow=;
 b=Cwvr6zycY8FUWEciWYXdQwLNHxE3pF1AtSYnJUqmKdcLMiVoTF84G/xY94W0XTwtaV
 eoByDEWVSONTsQTRetHjAsybBuN8zDtQzNiIQ+SC1aTyTmUu0UQ8LhtFqlaoae8Zulm9
 Wyi+PO5IQTuL4MMA644fmXWCn+dtq8FB4MKpUN5SqSz0vZOlf8kaXkU0oPr2B0TOFoC4
 LKqMx79+iBTFx87ifdedFBGFIh6HoVxp3D9lyA2JOg8grpnM/AaLivGuzPV3KdtBKquR
 8cKteRFYaM1rhi5cL6rAZPdanqfN9scr1iiiKDB8DTHys3tbGfFUPGgV4h25Maf++K2X
 o7Qw==
X-Gm-Message-State: AOJu0YwHUkYczay8Lw5N0WFwMFEVIkIhp1eYaOJnfynVr3Eav5lpjHjO
 1fu9tTjt3kPPCALqTmpCQhRYR2D/1COvctZ6abnkcx8soRsIY590uVvFyZzfAU9dqQ==
X-Google-Smtp-Source: AGHT+IEP7BtDVSIiGBNRXe1XbMJWfxrMW6glTHrRhyWuiLOJG73iXexRfYvEkhzyAL+O+blTWZtGTQ==
X-Received: by 2002:a2e:99cf:0:b0:2d6:c59e:37bd with SMTP id
 l15-20020a2e99cf000000b002d6c59e37bdmr1783542ljj.3.1712236806513; 
 Thu, 04 Apr 2024 06:20:06 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 i15-20020a2e808f000000b002d2e81c0f18sm2170424ljg.45.2024.04.04.06.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:20:04 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 3/5] cmd: optee_rpmb: build cmd for sandbox
Date: Thu,  4 Apr 2024 15:19:49 +0200
Message-Id: <20240404131952.3252301-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
References: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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

Support CMD_OPTEE_RPMB for SANDBOX configurations.
Test:

$ ./u-boot -d arch/sandbox/dts/test.dtb
...
=> optee_rpmb write_pvalue test_variable test_value
Wrote 11 bytes
=> optee_rpmb read_pvalue test_variable 11
Read 11 bytes, value = test_value

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v2)

Changes in v2:
- Applied R-b and T-b tags

 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 61e280fb1a4..227d66a7eea 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1394,7 +1394,9 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on SUPPORT_EMMC_RPMB && OPTEE
+	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	default y if SANDBOX_TEE
+	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
 	  in the Replay Protection Memory Block partition in eMMC by
-- 
2.34.1

