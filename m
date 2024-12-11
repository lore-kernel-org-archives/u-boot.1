Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE6E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BAA80214;
	Wed, 11 Dec 2024 13:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="er8LuHGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF71F80214; Wed, 11 Dec 2024 13:20:40 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3AA8020B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso528662166b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919638; x=1734524438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oM7DzN52kHn2gAPlxM7rQ+eKe/PMIaDiHskdYWhLe1k=;
 b=er8LuHGTwP4mohm7+C8UNjNftFxSvmodbL98snixS/3rHI3pHRQEFkit3cjf14bbfb
 CFRBGnQhm4LUIPVQAe4kcGDJSSFqggVCcGvdgzbsp2dmUQVTVSA5ZnB5kaAFU2oslP7j
 zN4Vmir8L++8opnHaHLI3USht+msS9PbtHULRkhmsAidUlS1dhELOzqmTQdgI+nmgoPc
 bVdynoLIqMOvZiKD3fpxYHFYOVTQujkQ99K9C2oNZCLDYfVGI3SKs7zf7OO4Uxl4YIH5
 SCBWE7d4tykYDAnFGcsTkri1eyjlqRDgQuUZ4ew5rAuarJ4idsQVIqw4aU+XZkdnpmaH
 Dkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919638; x=1734524438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oM7DzN52kHn2gAPlxM7rQ+eKe/PMIaDiHskdYWhLe1k=;
 b=E3hVlndTWVYLubG/mxnjzeY89p4eHezXB9XbtHFxON1CtDudh7qqNctIoWLBMF0ccS
 tATlHlU6NWplJsUiIAtf6u88AEmbeLsoDlOkSi2PHkKkAJtbPx8grsOkigP3aj+o4m5q
 0kTrNPRlw297e+4YEDIPlydZ0kKRt+hZhpLrdtUbjJXyYODKtpuKhrc4qJBfCL7k7bj4
 Oh7g4H1VmEpYWSKsXnpPjtLzwSBtE4/wL0jZyg+N8X/kfDJelIfMHUn+9yRi5e9wK/f5
 vxNJk1A2XJ3zh/y+yWg3Vrd8ZXg4aO+YGoT1eqw/HTGegMk5oibHg27GEvqfbov35nkr
 6ZFQ==
X-Gm-Message-State: AOJu0YxEnIJ0C32tZd2PaT0LiIGo1GmQtXU5ZLnX2ojTTtHODy89epk3
 uBbjR5Cizz2mdZLU3zGOp7tptejD3WVapLOhlu2ZF81OtesYObBMX/2WiWIJ
X-Gm-Gg: ASbGncuDGmnxKL1WbxKM6xmcsJGbAp2+Gbh1SqcVJ8KyDGdjZKVKqcU9TB8MBwOq/GK
 NKBcMrJhAvxWoeqrjh8XZTp0T5yYh+kIkbISFzTGdmEddrAchJVV2zrmHRIKDH0BiNRgMQMtNUS
 tSJeWEWW8x8XR0rVUljPHse6oCbD5eerAdBLzLw50quwtWgqI00PnJtFjNcD70STZlmjq/SwXVw
 UrHwcfPVhKqBgWR4QP3MwaBFbvBvc1FpCUkcLrE9lXQ6gTM9w54iIHIjrnAa/NTXon6gqMmENHT
 1WH6JkffPeu8KblNw5Kmg5UvrDMQ
X-Google-Smtp-Source: AGHT+IHMrCsfms6f8OyJCdzrmEICGu8PrjbzwLUW7V+4iu7BcQv8iei6Czt9hxVMfsVZhGYQHxs/ug==
X-Received: by 2002:a17:906:292a:b0:aa5:27d4:980a with SMTP id
 a640c23a62f3a-aa6b13da9afmr251911366b.49.1733919637639; 
 Wed, 11 Dec 2024 04:20:37 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:37 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] add support for Apalis iMX8 1300MHz version
Date: Wed, 11 Dec 2024 13:18:50 +0100
Message-ID: <20241211122036.103383-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

This patch series adds support for the Apalis iMX8, which utilizes the
industrial 1300MHz version of the iMX8 SoC. Additionally, it includes
minor cleanups that do not affect functionality.

First, the series adds support for the new Product IDs (PIDs) found in
the configuration block of the Apalis iMX8. The primary difference is
that this version uses the industrial SoC, which features lower CPU and
GPU frequencies compared to the automotive variant we used before.

Second, the series extends support to this new SoC. During testing, we
observed that the cpufreq driver did not account for the reduced CPU
frequencies, despite enforcement by the System Controller Firmware
(SCFW). This mismatch led to discrepancies between the frequencies
reported by the cpufreq driver and those actually set. We have also
updated the GPU to operate at the correct frequencies, as the SCFW does
not enforce these limits. Previously, this caused the GPU to overclock
to an unsupported frequency, as documented in the datasheet "i.MX
8QuadMax Industrial Applications Processors" (IMX8QMIEC).

This patch series depends on the following patch and should be merged
only after it has been applied:
https://lore.kernel.org/u-boot/20241125174911.70723-1-ivitro@gmail.com/

Stefan Eichenberger (5):
  toradex: tdx-cfg-block: set apalis imx8dxp to always disabled
  toradex: tdx-cfg-block: increase indentation for longer defines
  toradex: tdx-cfg-block: add new apalis imx8 pids
  toradex: apalis-imx8: simplify module version handling
  imx: mach: imx8: fdt: set correct frequencies for the industrial SoC

 arch/arm/mach-imx/imx8/fdt.c            | 132 +++++++++++++++++
 board/toradex/apalis-imx8/apalis-imx8.c |  19 ++-
 board/toradex/common/tdx-cfg-block.c    | 183 ++++++++++++------------
 board/toradex/common/tdx-cfg-block.h    |   5 +
 4 files changed, 239 insertions(+), 100 deletions(-)

-- 
2.45.2

