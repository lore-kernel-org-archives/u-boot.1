Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6E6E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 13:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65241801DE;
	Mon,  6 Jan 2025 14:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="npe4mUyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D462B801E8; Mon,  6 Jan 2025 14:04:25 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49870801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso17634032a91.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736168661; x=1736773461; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sHp9sCtdVoGjYsMosC3CJoVpFHFZaEButNFrW8PzOh8=;
 b=npe4mUyWLMaWaOIr3HufGJJgT2blchUuyVk5Q9aVTg6SD3WN+PNtlz36/CLhIYhaed
 LBbxzfSJT5ZLWpcWcv7XBaCmmbSDRzEQ97m6xkvV2t1aTh2J83rPIKjVR+LiNXBPipT0
 SwUCrDy94amHkHm3q5Esw5YUmbxNnQFPbC4T9tgTaoxf7Eb5axa1Mr94+suNSZSAlxlv
 xF94v9lBIhKSLWyERN5RQLgn0QaVPRDBFJQwZ7rAPktT3EFns9Cb9AkeeSjQpQO7lmzk
 plQoyF4nghr8qnqFW2WiZx3R8Y4aXjwLFcOurhBwL6u8lDzH2NKVIKF5AaLCFiF7aWJ8
 2gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736168661; x=1736773461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHp9sCtdVoGjYsMosC3CJoVpFHFZaEButNFrW8PzOh8=;
 b=FQHn5qRfS1ST4UaiTLBKbl5MprP3WClq5t1/JC5YHUcHn+to8RT040enhb0W7ycf5Y
 3MPZ3YVuxef7tDgnsmZWqKr4hZIPqxYwIP3/7VQ5LNopHFF5/uWEmKScyMrRXHs1+sDx
 zooLmkcIoAVbCdKW7+jbUD+J7WAysbFAocZ90TGUxsOWFcWHrfalqaEI/tNXbgg5VQbq
 cFa0qAeu1T5BacgGuYGIEun2qMqotIBAhM+gZipk31fwyK5FQ6vIaqHA9s+Hzq/GzrSC
 UNlcA/FOsJXy0IrNfC1WpR/+dreADSOaWCTiA9KNqT+mZXGNqS3LFw+J96ZAm2bSuPdA
 j7mA==
X-Gm-Message-State: AOJu0YzL98lcclnTCS+gTgCU99YnCU61O2WzUY/CNa4GU/ZPSab00NWp
 mAWbmuzDpiCt0asAamcLf3N8rm5ppYvBtBIemKXqpnHIAGgSR7kKGGwYNOSX81Bg1c1+YmwaaMK
 CZPg=
X-Gm-Gg: ASbGncvGg1al4+0IZrPIDsPMDlqUg2Dpx6DF4je8sounogHrO9IDiZX4OZ9zSOV9/I3
 8qxQ1V+HXVBkkZbgwHyb16cM3r/i35IZgH439fTd6OfqKo0AUOprFwX8hrtY8Bv96Hp4wVnDJAX
 z/XJRiD5+LudLSmEJZxG9zE0N5BrznFzzJnLVD9HmHTSfcSF1JCClfV3DJ3L8ZhyMzj3GBJZ0bw
 IOOYbodAw6XAV7+Xt13UxdHdVxJt2KDzlNMQKA11NZatkuAe2U4DAM=
X-Google-Smtp-Source: AGHT+IFLiFu8Yd5VDklHhEUCBt2c4kYpVkcj6x+uUgI7n8BKAsxSdvpMEg42cac9aZqlSOudrsSQKw==
X-Received: by 2002:a17:90b:2b83:b0:2ef:9dbc:38d1 with SMTP id
 98e67ed59e1d1-2f4435ad5e6mr84325911a91.5.1736168661370; 
 Mon, 06 Jan 2025 05:04:21 -0800 (PST)
Received: from vm.. ([103.97.166.196]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c8537sm33632428a91.21.2025.01.06.05.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 05:04:20 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 0/2] Risc-V ISA Extension Probing
Date: Mon,  6 Jan 2025 13:04:03 +0000
Message-Id: <20250106130405.220369-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

This series aims to enchance the ISA probing support by porting the
corresponding code from kernel and using it when probing for CMO
extensions.

Mayuresh Chitale (2):
  riscv: Enhance extension probing
  riscv: Fallback to riscv,isa

 arch/riscv/cpu/cpu.c                | 600 ++++++++++++++++++++++++++--
 arch/riscv/include/asm/cpufeature.h |  37 ++
 arch/riscv/include/asm/hwcap.h      | 105 +++++
 arch/riscv/lib/cache.c              |  26 +-
 4 files changed, 710 insertions(+), 58 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/include/asm/hwcap.h

-- 
2.34.1

