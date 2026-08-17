Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B87C5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CC5060829;
	Mon, 17 Aug 2026 13:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wY8PWeFuk6H9; Mon, 17 Aug 2026 13:34:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D27C60816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973657;
	bh=C9jnlAfzcqenjsrkhAnGY67DVxVEOkl2ZS05uSd95Gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RJc3dmXiwAaXD59WQKGvRHPBZ4ILOxzKuecNq2El9GF6K0uK5h+OEOyUDGIZLFR+Y
	 YdH4xCveYWzLry5IU1wsH6BUEg742uxLWGPC2JOZVBSTMwOPSvl41A1PWNH+l941lL
	 Mtev0B5ae5JRh5K4f3NRN0/3bHEOabuJKKhQYmLCN+ADOSOqk/auKKdAEOClH10j9P
	 CUXPmmDYNS1rIxt4Px2D0DplpEpaNRwnwrFEejXQqKUEjD1LT0cL3DBTA+t8FgYNku
	 3+Bw3xmABrgmrJRFDVmRsj8E6ZeqKAK4BlifcLT28xYC3wkEUZarGF5oHloouyY6h4
	 O+97jlzr3ExcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D27C60816;
	Mon, 17 Aug 2026 13:34:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30C72333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22A8080B0F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSqC8aL6KGyQ for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A14E80962
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A14E80962
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ghKCmmSS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A14E80962
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0061B40088;
 Mon, 17 Aug 2026 08:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9257E1F000E9;
 Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956268;
 bh=C9jnlAfzcqenjsrkhAnGY67DVxVEOkl2ZS05uSd95Gs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ghKCmmSSGiMCf+8dV+6obPE4HHsu1Okh+ws3RHwCSfHujlOcCCSCKEYx/8+1qWpIb
 Opdx17u+rF7aHILYUFtJajINzJ3cfM+4ea1d1lbvgCIa6DUmua3DNUytbx0VslmlWj
 0LhDAgZqNBGWR37201px0AhMvsLVp0qpGtUGAg03PZP5u08aqXDDEVyeG/rFY2KYeO
 lqC+ZF7meOL9v2q8LYnATid9iQtughUWkc154OS7J76xMWbuqt0D2eesaz9FjUaXz9
 Y7JnOXo2sPlYmqENUnetXE3hPmhcO2ffGFWQlZbtYW6WzUrFr4Z2T9E4hY+g7jTlUh
 tbGt/f2oXiT4A==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:12 +0200
Subject: [PATCH 8/8] arm: u8500: Give Golden panel regulators unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-8-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Golden device tree gives both fixed panel supplies the same
regulator-name. U-Boot requires regulator names to be unique and aborts
driver-model initialization when binding the second supply.

Add a U-Boot overlay assigning distinct names to the 1.8 V and 3.0 V
supplies. Include the common U8500 overlay since a board-specific
overlay takes precedence over it.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
new file mode 100644
index 000000000000..647b3f73c413
--- /dev/null
+++ b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "u8500-u-boot.dtsi"
+
+&panel_reg_1v8 {
+	regulator-name = "panel-fixed-supply-1v8";
+};
+
+&panel_reg_3v0 {
+	regulator-name = "panel-fixed-supply-3v0";
+};

-- 
2.55.0

