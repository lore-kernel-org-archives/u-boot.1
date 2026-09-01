Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27EEC624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A910480D3F;
	Tue,  1 Sep 2026 09:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7tVBhQZ3O3C; Tue,  1 Sep 2026 09:13:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254013;
	bh=b6Uc+0TZrU0Q6cuIxdG9RV9HIdoBVk1WK348s5kqzCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvuI/oPeRF0nADfvToCkr0vOeNPSKjED3dPEQz0a8vnikA0NP7n5S0cA8/MB0iNXV
	 Jz0fqn6d6pWFbnOIyjA/uLplW5W0jaxGVkBaKl8/L8wHumefkFmvESF3EQZRy5+7Y0
	 eplCV6OWd/MWiqClOtapTGpsfZaO+Mun8KGaY4aZAF5g2MiWfccxfZOyCVu3K2gnws
	 dj8Cgy5Q2TljqUTPG4gsFzXQzMWZLj3aoAGVs/qJWKRxg/0BOyA4+0agD5Sl2/7DYh
	 f7Gzc4sy1AXu0zlV7tjjAQ46EXZF3v+7eCQyVvEGKzRPq8ZhDLvz86SBvVIoiUPKJi
	 ykjc6JyvE4ijQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADCF980C1E;
	Tue,  1 Sep 2026 09:13:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D070E2FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C12C740728
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTSqLNRZYfsc for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fguLbj13
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB03940706
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E0C041A47;
 Tue,  1 Sep 2026 09:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55061F000E9;
 Tue,  1 Sep 2026 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254010;
 bh=b6Uc+0TZrU0Q6cuIxdG9RV9HIdoBVk1WK348s5kqzCY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fguLbj13mKVUODr8L1rWr0N9IKoNUsovAeY+jpDPq9KcjIFWNCiduIkBk3pMEyUfR
 awdVV/e20mZ4dUo/IEvtcWKOfsxDfRmEQVPlR8l+OxrXh4haN9duoAfHLsaEqKsOh3
 yCiT77h/zFs3CLGs1fGS75K8rLlQNMu2y7b9ohaf3NaaOO5bpXjI3PEVO2rB1Uu8pN
 pj6Byl9Oa8wB18oVSFOVywZugKVKU/7D7elqPtu+c1rE9JfrmbP9CzCN6ZrcZ5QN6b
 koehYlbilg3/0gF+UXzUW+fTUcdHnb5i2FS9hBxePUJpd5uOQiNlWvfPlmyx2BpSq9
 9itptsrXeSj9w==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:10 +0200
Subject: [PATCH v7 12/13] ARM: dts: ux500: Harmonize GPIO key names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-12-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

U-Boot want to use the volume down key for activating fastboot mode,
however the code there relies on using the key label, and this
differs betweem Golden and the other devices, so harmonize this
by using the same label as the other devices.

Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: 18fb6f060ebaf10aa69f7411868dcde376c528c2 ]

(cherry picked from ux500-dts-for-soc)
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index d4f364ec8685..1bb667300ed3 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -391,21 +391,21 @@
 		label = "GPIO Buttons";
 
 		volume-up {
-			label = "Volume Up";
+			label = "VOL+";
 			/* GPIO67 (VOL_UP) */
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
-			label = "Volume Down";
+			label = "VOL-";
 			/* GPIO92 (VOL_DOWN) */
 			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		home {
-			label = "Home";
+			label = "HOME";
 			/* GPIO91 (HOME_KEY) */
 			gpios = <&gpio2 27 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;

-- 
2.55.0

