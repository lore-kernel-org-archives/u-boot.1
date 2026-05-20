Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EE2CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 23:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863A684664;
	Mon, 18 May 2026 01:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="aYkidGaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B329584664; Mon, 18 May 2026 01:18:08 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83E58466F
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 111FEB0054C;
 Mon, 18 May 2026 01:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779059884;
 bh=1kAnhIx1UtEdFRdTKXXjLBLLGteJ8P2BTlUETJIVhag=;
 h=From:To:Cc:Subject:Date:From;
 b=aYkidGaZZnVcARxKYsQ9kf7nq/vAPFcnFKcx0mdwCeoOY8WC1Pk8+Li+hp73vHeNC
 O61sZyO/UZzv87y05xBsUxFqrobdZxwKaCoTf33JtFjHRgsu5z9Qol7ZQGPku1fqV7
 gTVlcOK9SgM14ZhXTu6pct/Yx2Jyt7EOiK0DTd18Ix20Vk+Rnt2do1p9pgmQjhrhwN
 Wcq34MvVJuMmniD2ME3aAf3ldnpHyksv8mVYYy2FCZBdudXx2zAscemn4rBvIG5CNy
 xZt0/wUfGAdC6byVr0AUheLwGoTiD09XTG9XeswcFCj8r3gBjZ0zMqsOo7rh7NZhcH
 TjjH7oyUhF20A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] arm: dts: fsl-lx2160a: wdt0 for watchdog node
Date: Wed, 20 May 2026 23:48:41 +0200
Message-ID: <20260520214847.1987463-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

The SBSA generic watchdog node is currently declared without a
label, so any per-board DTS that wants to override one of its
properties has to use path syntax &{/soc/watchdog@23a0000}.

It fails with
  Label or path /soc/watchdog@23a0000 not found
when the path contains an `@`, forcing to duplicate the node.

Adding a one-line
  wdt0:
label allows to override the node with
  &wdt0 { ... };
(for example to change timeout-sec).

Zero impact on existing boards.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 arch/arm/dts/fsl-lx2160a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/fsl-lx2160a.dtsi b/arch/arm/dts/fsl-lx2160a.dtsi
index 1e281215364..d18b9175b45 100644
--- a/arch/arm/dts/fsl-lx2160a.dtsi
+++ b/arch/arm/dts/fsl-lx2160a.dtsi
@@ -292,7 +292,7 @@
 		#interrupt-cells = <2>;
 	};
 
-	watchdog@23a0000 {
+	wdt0: watchdog@23a0000 {
 		compatible = "arm,sbsa-gwdt";
 		reg = <0x0 0x23a0000 0 0x1000>,
 		      <0x0 0x2390000 0 0x1000>;
-- 
2.43.0

base-commit: 9e8313e6f99607da19b115dbe8f56ffc0ccc929a
branch: for-upstream/wdt0
