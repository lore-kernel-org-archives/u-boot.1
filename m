Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFDBC61DC6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B22760757;
	Tue, 25 Aug 2026 19:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7cdltPFUvQL; Tue, 25 Aug 2026 19:04:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684670;
	bh=pYfHn+Kp6SH1sBVcd1ZfKS+PXR+ilega43i5oy7OPDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zeUvYJPi88GAXpOowXQN8TPTMiKDp2+o1C6uK06ebZ/7KmEbMCGRjzX225RvY7OaH
	 KLkfvLVrnnvcxszUPGPU7ro7uHSDnlNsEg72q+XUMDZ0aybYgU1d9uznP6VOglhbKB
	 fnkUjsRnPdKJ3znCfXGA2eqHoVQ3CUCOR9qsKTZ1dTjH+M9rZf1jv5R1p94+Sn3DBk
	 Gz4aKdowBVP9Dj6Q07CF8y9tCBf4zgBX7BLRvidYHV8buRAkuRgjq7i0htRLldN4y8
	 dQvHrKJQk1ncNZJUOkvB+KLnNXfmc4XnJwGrgEq0o/LaPJiYkPyR0YGYdTBsKEZXMn
	 Ccl9qMkJobiwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BC1760780;
	Tue, 25 Aug 2026 19:04:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 024393C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7D2C405E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAKnk5zgJNzY for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lhDm6V53
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E11E940591
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B05A40603;
 Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282CF1F00A3D;
 Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684665;
 bh=pYfHn+Kp6SH1sBVcd1ZfKS+PXR+ilega43i5oy7OPDM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lhDm6V53eNzXA4IYmReP5cZiDFO8m2RmfKHsyUj3M7m6aU+YOXzrJuT8hr+mXHpFC
 3TC8F8vqnD1A/s78JjICPOcgFV+7yoQYpIJWHiRO253wtShX17GTjjI2FlvE6TGc77
 IFPFHRwVpyoVrkhA8UC6Il0ADV3sGTzbPEcAMQPVtT/1kIhevsj5WKx1Vwv3wR4f+x
 O6ofYvrcjX/j/tDDI0CZWyuMiuoHyPRtAg3INivFA7Xq8rWPkbq8G6UFbsy5xqH4Du
 +N2lze6gJabYXGy6hLC655OQgWMHdW6OmoS2niMQ6iPbqOKNlttPqSmcWFnWsd9dMa
 PRG+pmKxVaZ7w==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:11 +0200
Subject: [PATCH v6 11/13] ARM: dts: ux500: Make panel regulators have
 unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-11-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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

