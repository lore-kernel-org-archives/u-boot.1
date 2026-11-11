Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB41606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wi34IHQh;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=mYlHAjd+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A00812DF;
	Wed, 11 Nov 2026 13:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXmMsSoYziLX; Wed, 11 Nov 2026 13:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6999B812F8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403797;
	b=RUF6jwLGZJtXnBrivmfguPb7HgIIgpvYeEW/jdxTVZ+wMcGr6Xgicqx6VlelwaaMS3P9
	 eA+Yoa84lZZtEtD2odEeNUASZDQPOTU48Ix96L9i1HQ4fEGbm9IykgdcHQPv+OAJuync1
	 YSeBMB2MpA/lYO0+h9aksVMMdo5roLIkpmmb8hk+2VZOjJBnp70UKRhykpzv9quMUpNC9
	 NOpELce9bZ3qv4w0Zt1424Edo6bFgUTzXSegfLLL3echvM1GCUXMlcrwvW0MHV+Zp/5iQ
	 R5Xt+BgufwIbLrNPaeo3L4Ke6QT5vOZDsWAxBuTBSx6g7n44D1BsBX0NCW0BXS+Pmkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Icz+lT+3dIfw5MFk2d4mgetzP6tbtoH08J0OyeI/hv0=;
	b=lA1iQ4RFsB9/JpDTjnMrFRY5M84Yu313aC3bXdi3pXdOLG78ybm89LK0I2dRtF9sDd2U
	 Kh1AFZN+jGxYcYjVjof08pxsWC0GlIAGLzaJpniPfLelTM1QV1KSAyEyu9MB2iD42pMFh
	 6v6MCKAACFVu33RepWcUiA1ASg1cUBK0pCX3LgvhUIVv5Aq9VB7J9J9+Zhg9x9lu/4EZX
	 63c+RR/L7J+ybMXdvruZvsJSdrsk4BjZW8hJ5LJy/mF9E2alGjwSwji4xlEfJ1u7WRNm1
	 ynSfRUl79hQWoWIeH3Ir/d1Y5AB5nvKnXcREmF309bRXKO/3Acnr0XGVPelYDLs2CYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403797;
	bh=Icz+lT+3dIfw5MFk2d4mgetzP6tbtoH08J0OyeI/hv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wi34IHQhqcNQqxfLv0FnjGDbiJ0oXy0WgMaOXPwAN89H0hMWoQ3O5tkbqpWe7xp46
	 PEBAh16ZZbiaEVSRKzaVg0Fa11aRr1euwoAJnZFeG0kjwdoYB2v1A1d5I7158KDf6Z
	 jPqhjBcblNjlYIlLdQ4hLu7oF5mq18X1FpWRDpDYHzGPB2WKR+Sxf+VvdhxeYZTbBR
	 Xd43/KzwqmgRkSbAfAbnsfEExiTdgQfuRTgaeIUVY0R4Tgby8CTxHc4S/p8F17WGxl
	 0zhyKqdK0D8lWZjD83G+b+Fap03xI+iM1tPb6kzi16DizjKljCaDGgyoFa/Jwnuw6S
	 Dune6mjVBK+EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6999B812F8;
	Wed, 11 Nov 2026 13:29:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03942731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E945D401AE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnc05HFA5JcB for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E0F1E40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=mYlHAjd+
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0F1E40060
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:54 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jPksC3mqszMlkD;
 Wed, 11 Nov 2026 14:29:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794403791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Icz+lT+3dIfw5MFk2d4mgetzP6tbtoH08J0OyeI/hv0=;
 b=mYlHAjd+HvXtcRgNv+1gPRg4kCksDon+O9AYJdVTLWs4SIRb5UHXEzeOKW4pAwfIk1CjQ2
 25It0haGy0Lc8YBvXibM9vzWM78DsQoRuzWorO2ChDwH4ebTasRFc/HgGodBtbnObAR9Bf
 5X3Nqj1rr9wsRpwLqlINjWUGWNIO7cYb42t644hXu3umR9rxjaK5dfHimyv8ZdWf3zELmC
 LZdQ8eyeGL5Cfnn/HRMKsvkipqXx9Z2A5Uz1TECI9OVAEkpQFHsiy5wyQxVuXpTo9OUZBN
 umUXc3ek3IiXmRWLvcfJSnWBudz+ZDUSiKQ7YBpzCbr5J8TH+MGIlWW6YiUudA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: dts: renesas: Use soc phandle in R-Car
 M3-W/M3-W+/M3-N U-Boot extra DT
Date: Wed, 11 Nov 2026 14:28:07 +0100
Message-ID: <20261111132943.7216-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132943.7216-1-marek.vasut+renesas@mailbox.org>
References: <20261111132943.7216-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c02ede9662fe22f8a65
X-MBO-RS-META: ijwcirejw8pxs478jmqfew8mbditagb5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use &soc phandle instead of DT path in R-Car M3-W, M3-W+ and M3-N
U-Boot extra DTs. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a77960-u-boot.dtsi | 22 ++++++++++------------
 arch/arm/dts/r8a77965-u-boot.dtsi | 22 ++++++++++------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index d048efb3463..335be487576 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -57,18 +57,6 @@
 	/delete-node/ vga;
 };
 
-/ {
-	soc {
-		/delete-node/ fdp1@fe940000;
-		/delete-node/ fdp1@fe944000;
-		/delete-node/ fdp1@fe948000;
-		/delete-node/ imr-lx4@fe860000;
-		/delete-node/ imr-lx4@fe870000;
-		/delete-node/ imr-lx4@fe880000;
-		/delete-node/ imr-lx4@fe890000;
-	};
-};
-
 &a53_0 {
 	/delete-property/ operating-points-v2;
 };
@@ -96,3 +84,13 @@
 &i2c4 {
 	/delete-node/ video-receiver@70;
 };
+
+&soc {
+	/delete-node/ fdp1@fe940000;
+	/delete-node/ fdp1@fe944000;
+	/delete-node/ fdp1@fe948000;
+	/delete-node/ imr-lx4@fe860000;
+	/delete-node/ imr-lx4@fe870000;
+	/delete-node/ imr-lx4@fe880000;
+	/delete-node/ imr-lx4@fe890000;
+};
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 269eb6a1814..8bc6bd726b5 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -46,18 +46,6 @@
 	/delete-node/ vga;
 };
 
-/ {
-	soc {
-		/delete-node/ fdp1@fe940000;
-		/delete-node/ fdp1@fe944000;
-		/delete-node/ fdp1@fe948000;
-		/delete-node/ imr-lx4@fe860000;
-		/delete-node/ imr-lx4@fe870000;
-		/delete-node/ imr-lx4@fe880000;
-		/delete-node/ imr-lx4@fe890000;
-	};
-};
-
 &a57_0 {
 	/delete-property/ operating-points-v2;
 };
@@ -69,3 +57,13 @@
 &i2c4 {
 	/delete-node/ video-receiver@70;
 };
+
+&soc {
+	/delete-node/ fdp1@fe940000;
+	/delete-node/ fdp1@fe944000;
+	/delete-node/ fdp1@fe948000;
+	/delete-node/ imr-lx4@fe860000;
+	/delete-node/ imr-lx4@fe870000;
+	/delete-node/ imr-lx4@fe880000;
+	/delete-node/ imr-lx4@fe890000;
+};
-- 
2.53.0

