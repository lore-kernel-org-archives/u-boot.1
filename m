Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4748C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A028B40714;
	Wed, 19 Aug 2026 08:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EbOuFNxhMUOB; Wed, 19 Aug 2026 08:54:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129671;
	bh=zC/IemMsWSFE7KR9mWoXuJHYwZ1Seo88B4RxWb3MOT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kS+8GTmyJrmXd+B/7PMR81ZH0FCg2ntpxfyPYXTaLGtaas3SbAv3ksEteF0euye+s
	 RxupNkA8wtGYwinOYhsmhVW1rOgQwHKSc74G3agm5AQtFgHF0pse/HjUjX9d4K8An5
	 HmgLHlpVAsUd/6s3ZCRxUx0IkCXeL1hg22U7bK1h6JBG0iqWAbwoXv06hsWLTyKiTk
	 NBCfxUaLwNJacknE2HiPoIzjdzRVLXfxP7tXLq+xERWuYXRVuuWps9zzoKlN7Cjwmw
	 m6fn9HyU1Im7us1d7UYCi7ueeNj5vQ2ArHOrIkFLim1zW0rRxfWMZ7J+hKnbV7QHdH
	 ZWhUMnfYMcd4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE2DA40654;
	Wed, 19 Aug 2026 08:54:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D92A230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23BB860618
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVNyNNrSI77v for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Hj/TW+RA
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3247760602
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39B4D60A5B;
 Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D85F1F000E9;
 Wed, 19 Aug 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129666;
 bh=zC/IemMsWSFE7KR9mWoXuJHYwZ1Seo88B4RxWb3MOT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Hj/TW+RAPYaEC+ol+hO7lMQ9QdQDjNTqgILHRilcVMlI/MScAJKQtcTxx0UaVOAbw
 WtpMsY8sdSP4SIWSTtTRSf0peB3FA8GKokMmFjKzkuFpaDL+SGzg8fxvOEdV2Lz8TL
 hs7tzdktoNzGx3ZkwhrqHany+2/DDH1WVetUWjfb02Pqy/7Y2Bidt+mEdXZyDY8fqO
 jgzfkVC40EK86xJ8fa9W4sUHhkyjLUfepB8vHz4zpGZSJoOK+lgr9sLWZDQ2SoWvPs
 6/Lq7MMuBODXG+RHdflDneQXOHUOQcS1Yv9yb9/juehcEqq+gDNj4tI7Xbo4wrf6H3
 o6ecYHGojHEwQ==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:15 +0200
Subject: [PATCH v4 10/12] arm: u8500: Give Golden panel regulators unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-10-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
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

The Golden device tree gives both fixed panel supplies the same
regulator-name. U-Boot requires regulator names to be unique and aborts
driver-model initialization when binding the second supply.

Add a U-Boot overlay assigning distinct names to the 1.8 V and 3.0 V
supplies. Include the common U8500 overlay since a board-specific
overlay takes precedence over it.

Link: https://lore.kernel.org/linux-arm-kernel/20260817-ux500-dts-fixes-v1-1-24379c6c2495@kernel.org/
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

