Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C89C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C385E88871;
	Thu, 25 Jul 2024 22:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tpuji5X3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752A788403; Thu, 25 Jul 2024 22:45:52 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2480C886CC
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093705c708so276333a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940349; x=1722545149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2jJkirKL9JcIEYinkc0nyP8OCxqu/mQlYDf10jkd3E=;
 b=Tpuji5X3+cl7B2SPGxNITHbg4zomwwf+m9WS8qU4l8QE99MRauNURJjmM+0FSOPY0E
 wc7hFXP/OiO7KjhQ07lEmJyfiOpZmRqYfqoMLEifbH++o+Av4APmuOAnNvziUUJg6jWe
 jjwyd1lHY4rqa8piBZbG4UVJjjFvSVjBM5LqskIj+j5m7sW9RpP4M97LSyQySeiJEE2X
 TgS81mn9l03P+tuirgqN4q2w0F2VO4CUpygDIjo82enoGnpN8r1UVXEeFO/OuosNvnm0
 wzIVVB1W/aD0R9s+In9rnoBBvwlegtTdACW3N4xaxN9DnG05uxBXg1vPQca9keBcfZSz
 4m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940349; x=1722545149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2jJkirKL9JcIEYinkc0nyP8OCxqu/mQlYDf10jkd3E=;
 b=jB6NwQPTzECx4Xvfo177t4j6WNK2LaHhqiU9hu4NjyzpBLpTnKxMjqGlXeBBgsDF/U
 3MLy+6CMBod11bLU7vG72kBqSvGnpmoCOzF2lnjsgtsKAxGZeP9QtzMAPKeBPSc05xEl
 Kqo/2IwsPy8uVFzH7a22r9D7XJTuws8a0SKgkbs5jyFPUNwuLIijqDBI9xCFR59gSh4C
 G7Iy1EOK1Zd5Rn3Tn8f3o2UeYlMIlq8HhDyTp1UMk1GkH/1/rFFfJFRv2jDezYfV8EB/
 Ma2JpmU9125ApCHgHH7UZrRIRfYqXfse7zlMfPMMRtgWCzZksoxG5lQgPRmlHJISV12Y
 2tDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGFuiczI7AFdi4ZDqWGIXqs8ezn6kKqQBypR3cm2g3Gs28rRgEfi0Zpv817RlelNmP9RkJFGc6PCX+0YdffgFGizl7tg==
X-Gm-Message-State: AOJu0YzAhF98SR89n9tRu5advYQTf0xT69cuQkN//EzxvDXfcZ7HhQNe
 b9WCWAyXGxo9sqfyLUp4BitdFEdtnMdL/CUMkzAuEMat94mSW0ZE/bc42EAg3yM=
X-Google-Smtp-Source: AGHT+IE2kHozo6auhHR83b5La4O8M539tADhtjzpxXEO7i9UDrc+C3EWojiQ0/C6Zm7lFPPQAFpR1g==
X-Received: by 2002:a05:6830:378d:b0:703:638a:7dd2 with SMTP id
 46e09a7af769-7092e6c3321mr4985485a34.10.1721940348973; 
 Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930785d30sm455770a34.69.2024.07.25.13.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 38/38] doc: samsung: Mention enabled eMMC in E850-96 board
 doc
Date: Thu, 25 Jul 2024 15:45:20 -0500
Message-Id: <20240725204520.18134-39-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

eMMC is enabled on E850-96 board now. Mention that in the board
documentation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 doc/board/samsung/e850-96.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0cb95473e536..0a7b6fc0c9dd 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -47,12 +47,13 @@ Build Procedure
 ---------------
 
 .. warning::
-  At the moment both eMMC and USB features are not enabled in U-Boot. Flashing
+  At the moment USB is not enabled in U-Boot for this board. Although eMMC is
+  enabled, you won't be able to flash images over USB (fastboot). So flashing
   U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
   be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
   to unbrick and revive the board. Flashing U-Boot binary might be helpful for
   developers or anybody who want to check current state of U-Boot enablement on
-  E850-96 (which is mostly serial console and related blocks).
+  E850-96 (which is mostly serial console, eMMC and related blocks).
 
 Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
 
-- 
2.39.2

