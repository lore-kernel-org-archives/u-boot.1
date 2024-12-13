Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA25E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349A0801F5;
	Fri, 13 Dec 2024 11:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AfVTrFCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766AC801F5; Fri, 13 Dec 2024 11:23:46 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CBF8027E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 99F9FA42A31;
 Fri, 13 Dec 2024 10:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493F3C4CED6;
 Fri, 13 Dec 2024 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085422;
 bh=fuS2G0WOkhSBi3DTcRCHf0CXlClZrL8AMfNlnb1cUlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AfVTrFCnojZbblmsg+O6YoGomBDgxgb18jAtpy8bortM7A1dnVrmrH1xAkrNUYH3B
 yYSFLn2f0kA5xAY9det+WvkAzTpWT0VA4NVrFSWACMaMjcKPz9Zypo0wgdF3c3JRK7
 0aX5GmOSNTtWRzvh7xXVuve95nEQpktp4BCTk34tvO/Dp6wRtehm0HZkentk2mgYnd
 5wulQ/x8BpWVMndxgbLoJt4ZVfDLF99tDQvErrB849cZhDj2/K1ACflvzznJZX7i+U
 XLlr0yiaUcrrChm/7BBAW8iKcHFVir2W8EtaiXGp5xFa5HPK5A6vJHLhmW7fhFr+Qf
 5MfXsNOfYHGKQ==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 5/5] board: sl28: fix USB0
Date: Fri, 13 Dec 2024 11:23:21 +0100
Message-Id: <20241213102321.2166920-6-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
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

Since commit 61ff13283c3b ("board: sl28: move to OF_UPSTREAM") USB0 is
broken because the former u-boot soc dtsi was setting dr_mode to "host"
but the linux device tree isn't. That is because linux fully supports
OTG but u-boot doesn't. Therefore, u-boot only ever enabled host mode
and never OTG mode. Add it to our board "-u-boot.dtsi" to fix it.

Fixes: 61ff13283c3b ("board: sl28: move to OF_UPSTREAM")
Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
index aacf181e2dd..4202d1e5654 100644
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
@@ -203,3 +203,7 @@
 &sysclk {
 	bootph-all;
 };
+
+&usb0 {
+	dr_mode = "host";
+};
-- 
2.39.5

