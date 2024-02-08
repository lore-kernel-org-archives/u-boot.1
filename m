Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B2AC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 09:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7254C87DC6;
	Thu,  8 Feb 2024 10:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JJoZN5KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 030A087D06; Thu,  8 Feb 2024 10:29:59 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E852287DFF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0CE7622B5D;
 Thu,  8 Feb 2024 10:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1707384596;
 bh=7Knq8LkbzrRR5ouYRp9imDFyln7gtHfmzq3WblRD38o=; h=From:To:Subject;
 b=JJoZN5KWAUQuGY2a0AQau3hL7Ra5y66jBahvxB0WW8oAvUZyINf4+v+TfpjJCjxO5
 QgryumJkaYgUO1CuM9FQW5A3h+fWaGdeNGYsv4HHdD4A32I3mIvzigNycnXrkLBkbU
 c9P03jit4oMRt4LAtm8Hl7BBZNKgf37+ml09cMHxc2LQ8n80CtllXFO8t26di6N0iY
 rYttUeS40jMA9Vuuo3PZ7ZJvuEDEx03sQdqeQkQSeGmkFu0MyKVi3r+GFg+K+D+l7r
 GKWBiHBYi1I7zRfvKOdKbeG5b1L4iiSXiJoN/mMr4EovTxPs9Gf2ptnOAumNfF71xq
 kCwTSGYsAIoPw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] arm: mach-k3: am62: Fixup thermal zone critical points
Date: Thu,  8 Feb 2024 10:29:49 +0100
Message-Id: <20240208092951.11769-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series adds support to dynamically fixup the DT the critical thermal trip
point of TI AM62 depending on the SoC temperature grade.

Joao Paulo Goncalves (2):
  arm: mach-k3: am62: Get soc max temperature by grade
  arm: mach-k3: am62: Fixup thermal zone critical points

 arch/arm/mach-k3/am625_fdt.c                  | 37 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h | 17 +++++++++
 2 files changed, 54 insertions(+)

-- 
2.39.2

