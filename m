Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF6C5DF9B
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6525280DA1;
	Sun, 23 Aug 2026 20:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCKvl9hzQJRc; Sun, 23 Aug 2026 20:39:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517596;
	bh=pYfHn+Kp6SH1sBVcd1ZfKS+PXR+ilega43i5oy7OPDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHE1sDU8wXeuebZ+nVS4qDzG26GvBaZkJVexBj1HKJo6Dg/LTUx8KVi9mgE+gPoF0
	 2bjlhhB2bhN/FDS84bDu/Ew6yVMCjUoHXFxTjS2OWpwd8bWNj6NO0oK+RylpwcsXBz
	 Im5/3tnbNMSnSfNBd3o2kaaIGzJNb/9PDWXd+5PMGTxkopw6O1uX99+lPKQvGP9sC+
	 H8pOF4D+ossY3URy/o4b/1oPx3rGMB7ouRGsyoAFNY+MMF2PRm5QKsrZSCFFGkarAg
	 0oeFmsmT1LNendPRdcsJSQ0xlbH5m8VbrqBqC2EXjADYWsp4h6nF0wNDZVWGckDlFL
	 FmOjEZ+lY9DQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A0F480D64;
	Sun, 23 Aug 2026 20:39:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EC8941A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EA3A80DB8
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98ILbhgEuY4u for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YRF2ebJZ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 839E780DC5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D922C44002;
 Sun, 23 Aug 2026 20:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DEE1F00A3A;
 Sun, 23 Aug 2026 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517587;
 bh=pYfHn+Kp6SH1sBVcd1ZfKS+PXR+ilega43i5oy7OPDM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YRF2ebJZSOfwQAouXll5+XYY6f0ZT1iozBFIOV+zt8ffEbL3HSdxmO29sBF+RB/ha
 fsp2mdWkC89T82AoPf3uJ0LGJ+9daxtBbbMi6KMUSuhi8QEoqlnwQ8IHfStzLsRWKN
 NRg3DKVrz1mDanZfWxoPm7b34FI+Qp6JckIIcBYJbRKLAWO1wv3fUQmgEXHA61I1Fy
 Taayh20DpNQVb5AnGrh5D88wq/OrZ0sBKbqZ17txFin0ikrB0ehgqSpPgeM+ETohOw
 NdQPcBxlNDm+Nr2qf5SKEZ2uhQHauWG1JxwmDSe2o7isNCYfBj2eDKDVccIvQCDG0f
 u3gZUtf53/gMA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:30 +0200
Subject: [PATCH v5 11/13] ARM: dts: ux500: Make panel regulators have
 unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-11-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

U-Boot is not happy about regulators with the same name though
Linux can deal with it. Make the names unique, it's more elegant.

Link: https://lore.kernel.org/u-boot/20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org/
Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: ..... ]

(cherry picked from commit .....)
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index f736888474e7..d4f364ec8685 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -510,7 +510,7 @@
 	panel_reg_1v8: regulator-panel-1v8 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-1v8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		/* GPIO219 */
@@ -527,7 +527,7 @@
 	panel_reg_3v0: regulator-panel-3v0 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-3v0";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		/* GPIO219 */

-- 
2.55.0

