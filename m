Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39664C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E624283252;
	Fri, 30 May 2025 11:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="BTWZV+3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB32482BAF; Fri, 30 May 2025 11:49:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF71283252
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A2786260FC;
 Fri, 30 May 2025 11:49:26 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVIaPIzT6nUg; Fri, 30 May 2025 11:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598566; bh=gqHL2npBs1+QSVw3LOaQLaNEWHOB9BCpMa9cU3UIY4g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BTWZV+3uvHNgLk1SdTyQex8bGTG0ZHYv50QtfszynPt4emRnQERr2hkY/ymBKxeFj
 tQJQDXqupQUq/CMgbzHzLpom9QDn/xPaWy2gSGZbLD7M1tUz/bnxYlIGagbBEYzVEp
 JMbfu+eKDMLnRpUk9mtxAZ3fkH3rkMrF7NM8vy3W84hS2EDn10wA9olitNjgwdL0nS
 1J+js03Vt2KSFdos2UT22W/c3gHcr4+ADkinvUVsSGJJv40X+jT0nOyGGDakzZ15LP
 2oexaoNnEfKs1BHY7noJnq07+Z1m67V3wT/zNhtGKTzcoOaFSiO9Nrx12uDcKl3fmy
 ZgjG/eayKckSw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 4/5] board: thead: licheepi4a: Run proper U-Boot in S-Mode
Date: Fri, 30 May 2025 09:48:50 +0000
Message-ID: <20250530094851.57198-5-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
References: <20250530094851.57198-1-ziyao@disroot.org>
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

RISC-V software usually expects S mode when leaving the firmware, e.g.
UEFI applications could only run in S mode. Let's convert proper U-Boot
of Lichee Pi 4A port to run in S mode.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 configs/th1520_lpi4a_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index b19dc009fde..32b39b295a8 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_LOAD_ADDR=0x80200000
 # CONFIG_SMP is not set
 CONFIG_TARGET_TH1520_LPI4A=y
 CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BOOT_GET_KBD=y
-- 
2.49.0

