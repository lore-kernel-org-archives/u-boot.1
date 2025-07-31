Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8993C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FBC83946;
	Thu, 31 Jul 2025 23:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="G6tKqRXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394EF83935; Thu, 31 Jul 2025 20:15:56 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E5D83857
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 20:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so1165037f8f.2
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1753985753; x=1754590553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCFBUYmbUCpP7XmxR4q2r8DYsl+Y5mgLv8i+ca3zqOk=;
 b=G6tKqRXG4pysG3mSz0cH7ozt8CMCR5j8rkMo0rYpwmUu/nFG8xnqOiggclqjA57jPv
 yMLKUyRO+FGN9hTJ5Q8FS4rAuyQQHt9iiZ1Rd6P8aUKIgEc5Fr8nD/X9GPmrmq0474VN
 qV8z7dTODW1y42JyuJisPCnnPMev+MuvenM0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753985753; x=1754590553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCFBUYmbUCpP7XmxR4q2r8DYsl+Y5mgLv8i+ca3zqOk=;
 b=Qb2vzu8vplfYgDrikEd6iCkN4mOpfuEq860Fnm4H1DXShyFCjTd8LuHrGjb95GebcV
 TdKecQzn9nuvDu7MYW0OhsNsUFRiZutT/+gOIctYQYv5T/OLrUVsmYaADtB7cQS2BZz6
 7COlwkhduD97F7TwRSDqaPrMpho/rbfGevosvFB2BD+Zr+mfH0U5dDnU+7DioEAHYtJH
 yDqy3c/jg2oCXjDrvjWOnlJR2T6a+xduK4fHm+Gl/YkPSKmSfhZWM4VIT6Fjh+97/+Fs
 KtcMp9NTfoxoaQ134tpgZWSqb+99OB5aWMNrGOuEoBZQvQUO9W2+bPXSNtNYXeLZpREn
 e8FA==
X-Gm-Message-State: AOJu0YyQvhhSE29LCZxAmpQqI6Vm70X/xV8arB/azMIeZkuTWrPA1y7O
 r/2VOy+ehu1BpqSlH+7TkDuXxIwJYjnLNLGqLMcnhu7VpmNusQ0fD+fbp8WW81aJqyCItXrrTHo
 ozqJ3vBIFrQ==
X-Gm-Gg: ASbGncsmN7YCuiK1wOK1HGTcfotKMErisTq6SOQ+H6IUKGxgguurAKjSmhr2c2TrWYZ
 SSyCkPul6RBakKPQZIqgMhTM76/LneXKLMHGJVSFazQOVPa8GxuQDJ3nnD2+OXOsAMs3S7elftt
 evehlCJNtGtQYcu8LVNMndQCfDcrthaZTeLWjg6evriGiWbIvnyiDm761ADBQ8vWObMkBTJny82
 IoLJLFeRf6xB/EDHTPrrcr2lZTb60P45FGqabtGoiZeh8376CUi+DQnH25oLdexU/qiCY5/00k7
 ZdzQOwQ4dgkuUw5asZ0Qs/j5V8bGnV9SMTEXcqt0KMuaNa86MvEIfNV81OLcLmDOZ0+agRu4KgD
 jcydQwViN23l1Cf3NrRxLsCUguEQpanws4R6H5bt+Qg677Fi3+WJqg9X6qnbUOQPjN9pr0A==
X-Google-Smtp-Source: AGHT+IHkn4s8ixHsQOa7ShAiYf+vDiWevV3dA2nIH5pBStmmW6OiTP+KPbmapZUFujUPniOlJ9d45g==
X-Received: by 2002:a05:6000:2889:b0:3b7:95fa:ac4 with SMTP id
 ffacd0b85a97d-3b795fa0cdamr5545103f8f.32.1753985753292; 
 Thu, 31 Jul 2025 11:15:53 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abedesm3236129f8f.3.2025.07.31.11.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:15:52 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 0/2] Simple & robust MMC U-Boot upgrades
Date: Thu, 31 Jul 2025 18:15:31 +0000
Message-ID: <20250731181533.1872390-1-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

This patch set adds a mechanism for simple and fail-safe MMC U-Boot
upgrades.

Although vbe-abrec provides a similar method for fail-safe upgrades, it
is not always possible to use because, if I am not mistaken, it requires
control over the TPL. On some devices such as the RK3576, only a binary
blob is provided from the vendor.

VBE is also much more complex than this approach, but the added
complexity does not provide anything of value for my use-case.

Another way to achieve a similar result, would be to use
MMCSD_MODE_EMMCBOOT, but it is not possible to verify that the new
bootloader actually works using that method.

The proposed changes make it possible to switch between 2 different boot
sectors by writing to a separate control sector. The boot sector can be
changed temporarily. A temprary boot target will only be tried once by
the SPL and the control block subsequently reset.

Andri Yngvason (2):
  spl: Add A/B sector mode for mmc raw mode
  Forward chosen raw mmc A/B sector to OS

 boot/fdt_support.c   | 20 +++++++++++
 common/bloblist.c    |  1 +
 common/spl/Kconfig   | 28 +++++++++++++--
 common/spl/spl_mmc.c | 85 ++++++++++++++++++++++++++++++++++++++++++--
 include/bloblist.h   |  1 +
 include/spl.h        | 10 ++++++
 6 files changed, 140 insertions(+), 5 deletions(-)

-- 
2.50.0

