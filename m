Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADAEC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52DBC811A7;
	Thu, 27 Feb 2025 15:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IvalhlT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4215811B3; Thu, 27 Feb 2025 15:49:00 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC3E811A7
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9C0ED259BB;
 Thu, 27 Feb 2025 15:48:56 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IofmeCL_CP4W; Thu, 27 Feb 2025 15:48:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740667711; bh=bBOaoVUC8v8AVdyO3BwxWqoC55NW7z9whotRJaLCKTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IvalhlT5lS+QMRyctPuTrBpV+SL4Er5N+c7pkq9WMNadRAphvgXfYDewx/5J83cq/
 CBiYQzooiSy86N3O2AqBBSjUul81+EOa0hl4KbHgO21s6tON1NTl4YDqfRvZGk6fbG
 +rHb/UWu/jL/8TXdzPtd76gzye4lhlffIObFkBt5WpAtoqn35m82Y7sHxrOH6tqYeG
 3VDFvdq0Gdnbi7SouQXWsyM2bc0p0inEice7pDd+l3tQHerYmhiziOXqsFSxe+V45s
 +rW9QPapsC0DhycCJ/IsqXg/9vP+XerqmiaauCB/ksRU464HeHjR/fNp6tJX2Txiwv
 ePieueD2mCrRw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 5/5] riscv: select OF_HAS_PRIOR_STAGE by default if SBI is
 enabled
Date: Thu, 27 Feb 2025 14:47:33 +0000
Message-ID: <20250227144734.61458-6-ziyao@disroot.org>
In-Reply-To: <20250227144734.61458-1-ziyao@disroot.org>
References: <20250227144734.61458-1-ziyao@disroot.org>
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

Availability of RISC-V SBI service implies a prior stage exists. As SBI
firmware usually passes a FDT to the loaded program, let's select
OF_HAS_PRIOR_STAGE if SBI is enabled.

With previously added fallback version of board_fdt_blob_setup, S-Mode
RISC-V ports use the SBI-provided FDT by default. This covers the most
common usecase, where a SPL (probably the U-Boot one) selects proper
devicetree, loads SBI and U-Boot then invokes SBI with the devicetree.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b24623590f2..f7706788f92 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -410,6 +410,7 @@ config NR_CPUS
 config SBI
 	bool
 	default y if RISCV_SMODE || SPL_RISCV_SMODE
+	imply OF_HAS_PRIOR_STAGE
 
 choice
 	prompt "SBI support"
-- 
2.48.1

