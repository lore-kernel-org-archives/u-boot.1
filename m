Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0EC5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACEB82AE9;
	Fri, 30 May 2025 11:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bzh/bi6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401E482B95; Fri, 30 May 2025 11:49:09 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3865882A46
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DCD1325317;
 Fri, 30 May 2025 11:49:06 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E8-LBnWq_7sN; Fri, 30 May 2025 11:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598545; bh=RV1iw4K+eCG3ifsFK50UvL+XFZQL33zu9yreOI4drc0=;
 h=From:To:Cc:Subject:Date;
 b=bzh/bi6T6ZusTIBy0iku7Q05d/cqrcvF1A+RNDMcQd0TeCvoh3Triaj9LO/AmRARV
 aGX2YrHWJYW/Je8W1/vEg6kagdeLY1OqnCaWF3AKl+5PlRATt0GZVP4mlMR0GfZmUm
 67+9CcDRGjG4DzuW9r6b3SJTUpRBE4ZXJU3BUZg4742JYCJOMT8bfy6scRX/G7EcjL
 OnCKDL+OJsXXeK2Q414I2XEnOfRsGrADaWpC6oSovORtqMPawFjcUR0LgeFWKFTYRU
 VAV8q6Ja+rOva+OP6HKVlwAUxOdn9MK3+Ztd2x+mSvR8Cr3Hk8SQ0czWEAIIBCz4EC
 z8/JBsTdNyhFg==
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
Subject: [PATCH 0/5] Convert Lichee Pi 4A to use S-Mode proper U-Boot
Date: Fri, 30 May 2025 09:48:46 +0000
Message-ID: <20250530094851.57198-1-ziyao@disroot.org>
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

RISC-V software usually expects that HARTs are running under S mode when
leaving the firmware, for example, the UEFI specification explicitly
states requirements for S mode.

This series separates M-mode-only code for TH1520 port out, and
configures binman to pack the OpenSBI firmware to initialize the S-mode
environment. Then S-mode proper U-Boot is enabled on our Lichee Pi 4A
port.

Note that booting on Lichee Pi 4A is broken between PATCH 3 and 4,
affecting bisectability. Considering TH1520 port is still in an early
stage and separating the changes make the commit cleaner, I personally
consider it's acceptable.

Yao Zi (5):
  riscv: cpu: th1520: Build spl.c for SPL only
  riscv: cpu: th1520: Support cache enabling/disabling in M mode only
  riscv: dts: th1520: Prepare binman configuration for loading OpenSBI
  board: thead: licheepi4a: Run proper U-Boot in S-Mode
  doc: thead: lpi4a: Update for S-Mode proper U-Boot support

 arch/riscv/cpu/th1520/Makefile          |   2 +-
 arch/riscv/cpu/th1520/cache.c           |   2 +
 arch/riscv/dts/thead-th1520-binman.dtsi |  32 +++++-
 configs/th1520_lpi4a_defconfig          |   1 +
 doc/board/thead/lpi4a.rst               | 125 +++++++-----------------
 5 files changed, 68 insertions(+), 94 deletions(-)

-- 
2.49.0

