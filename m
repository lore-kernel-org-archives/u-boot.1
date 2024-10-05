Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20254CF887E
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 14:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D6888B55;
	Sat,  5 Oct 2024 16:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728138851;
	bh=qnilx8kuWD+cQ/PTZTJZbA14c6pwRcF5wKRFwnGyROI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZT5Ki/nM3sGRNBuCT2qIetEhiiaVsK/x0G0PyKf7O/rx5UKKVcaUH8Z9HKMPFzTFw
	 THNQvIIIcPJXMEafl2Mcn7lKGNIP2sQTOwzbx+BkFuEnij3774HElq/2jWPWuURxAL
	 cAiLg2488ICWXC6h48q7dMM0cUQq+FksLCf6ib2gYri9ZlPY0JevtPrU0czX2Jwim4
	 rK5c3BL2viWW5gqZ+QjdTnlRaFSHVBHs8nLRlpF3FZOKDlePD2NpnLkXm6ib1YiDp/
	 vM+85W+fzF3/7cBkQLtXEv1N9QYjx/aL7FPx76aYwwbetoVbuSPmbxgCa670DKob1E
	 HPWbjq3PWnzAw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6C48F88B0C;
 Sat,  5 Oct 2024 16:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728138850;
 bh=qnilx8kuWD+cQ/PTZTJZbA14c6pwRcF5wKRFwnGyROI=;
 h=From:To:Cc:Subject:Date:From;
 b=XpUHwx1MXwCb1BrJrlBVleFN1kLAkQe50QWaSHkutpAY+emXRoBgRE3hKVD4sonH2
 iHnzLjZwhgg7JJaZatoYtMayUxPb4MeCI6XoLqlsfk4xGReN0mGNaQ+NHWYqvKqoJx
 IfEM1nb/gq13k2XVebTWs9M0kFMwXOAHUpJD191tUwYxHtmzqDP2V1+4C4a0pEG9LE
 S7Yu22inByB1G5ozhUjiUGMoLR3Fb6tKQgr3hP2+pEpiTKX51qIaOCX15bMQ0YRDrY
 j/RWtCsTz8kQ4YscBLedk7dQUgm1yHyPVKZ6eXrzjy0i9e9cd7vzZ/rcTcgu3u2XeR
 5GrfhD6VwN+Ig==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: dts: Add missing sandbox,
 emul phandle to sandbox-pmic
Date: Sat,  5 Oct 2024 16:33:37 +0200
Message-ID: <20241005143356.10069-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

This phandle was missing in the sandbox DT, add it, otherwise sandbox-i2c
driver cannot look up the emulator via i2c_emul_find(). This fixes the
following i2c_emul_find() error:

"
$ ./u-boot -Dc ""
...
       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
       out_set_value() PMIC write failed: -5
       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
       out_set_value() PMIC write failed: -5
...
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sandbox/dts/sandbox_pmic.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/dts/sandbox_pmic.dtsi b/arch/sandbox/dts/sandbox_pmic.dtsi
index 565c382ed45..ff2cb42844c 100644
--- a/arch/sandbox/dts/sandbox_pmic.dtsi
+++ b/arch/sandbox/dts/sandbox_pmic.dtsi
@@ -10,6 +10,7 @@
 
 &sandbox_pmic {
 	compatible = "sandbox,pmic";
+	sandbox,emul = <&emul_pmic0>;
 
 	buck1 {
 		regulator-name = "SUPPLY_1.2V";
-- 
2.45.2

