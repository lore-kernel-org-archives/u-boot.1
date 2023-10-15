Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9ADCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA2F86B68;
	Mon, 16 Oct 2023 00:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697409723;
	bh=8YNGjTU2bYy7vJkzTgyU5xWqnwmykHrK79hWPyTJPUs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CLe3HvghkYHmU3d2EBohuewDc6XkfAoGOOQWj9cNFgMWftOGlGC1xkIm587KoBkCn
	 tO57RMx0Zuz7MEPcWlHyMF3CtPj3lOYC/XH4gYnB4AL8DK1HRfktfBgskA9p28xZLB
	 7alLaG52e0H/aPl3i0jRXkiZRrORyh8a8dB4uyOqO5ONQ0MRsbW5o0TrSKnPIMHLaa
	 uoKSg78fa+1MuJEFUt5TL8/21r1Gf/07aMNk6Gb1rMLBGsscq2q3EfURRgkxqSB4Qs
	 NBa+JkxUz2pxQMAj2UolAovheeK2IE9Sx22CEtVzrwRT19mOW+8mT++7ROSWU4bCdP
	 J7SrrIEvjBCog==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7BE84869D1;
 Mon, 16 Oct 2023 00:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697409722;
 bh=8YNGjTU2bYy7vJkzTgyU5xWqnwmykHrK79hWPyTJPUs=;
 h=From:To:Cc:Subject:Date:From;
 b=vhW2IyWnYBo+HbPxWfYbpAOK2MSJaKKxQD9XjE7TCnzbueGcYuKveWdUePP6UGLOm
 Th0W8H12/ip5SIB1sznY5wHUVtLUzJva2DIheFRwzuDdhY6i0XA14VxcTRto16Xk/i
 19RAiMJzzkfvWr9RraCb/SOECxk6eKFmAISC35EKLhZ58518Bw4Ql9/O7MNu6Z3Ppz
 2nssMtWW5oQxBIGlF7VRcufYH9poCdEdQUpJtWnYTzosSXfrfkPMBkkagCRYqJ85Q8
 fLwTd145ERpUx5NYpDlNzT1BgIDmjF/U+aWpFOe7qiX3N5rFZJ7n6CI3zYyCiZ3fGO
 e5g0J4y8apMbA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] arm64: dts: imx8mp: Make GPIO3 available early in U-Boot
 proper on i.MX8MP DHCOM
Date: Mon, 16 Oct 2023 00:41:14 +0200
Message-ID: <20231015224151.211982-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

The GPIO3 has to be available early during U-Boot proper start up for
DRAM size detect to work correctly. The GPIO3 is currently available in
SPL and late in U-Boot proper, which is insufficient. Add the missing
bootph-all to make the GPIO3 available also early in U-Boot proper.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index a29db0ddd3f..b05be57e71b 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -42,6 +42,7 @@
 };
 
 &gpio3 {
+	bootph-all;
 	bootph-pre-ram;
 };
 
-- 
2.42.0

