Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA2C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E40AF4066D;
	Tue, 25 Aug 2026 19:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXZRrhF5lC0Q; Tue, 25 Aug 2026 19:04:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684675;
	bh=hkIkpPqja8HZGSUI0J2nSSwjZjftedBFRJJ33BW+9Zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DD4CY/2Hu+spRM/UvIkNvijQ2o8gUE83mY3rlu4hEaq/NQAY5uj92JANkC2M8n3qY
	 2vwikSd7Vd1sJOFVkUuEKZEJFrishmOZs78JP56aeBceg4nOagE06MnAugks2y9nE8
	 JYBM6r7RGli5UkOr1gqxKtZOYi/ZxtQh7Jz4rgveqZBiO5Qy4/6bEhDL9KodRmuQKW
	 JTB+DWnYa69qusZIIN+VkXHZ5n0HvmEnFTytcNC2HXnwkz8474927h6NimGpmMdthi
	 eRXEXsKQRdRNQK9V0CH0DKZRUX5B2HcMwNf5dq+8VjXxbvrtmraJeL/Pjvxo+gnbl+
	 8BMECBMuZk6SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30FB5405CC;
	Tue, 25 Aug 2026 19:04:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E90A923E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E67FB4062A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnhxC0qKjXUN for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KLXuf4Mp
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEBC740557
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C26A560053;
 Tue, 25 Aug 2026 19:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F301F00A3D;
 Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684667;
 bh=hkIkpPqja8HZGSUI0J2nSSwjZjftedBFRJJ33BW+9Zk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KLXuf4MpvlkOUnO8wyCI3+EMopCWns0OBpw0lWu1aGkajgTyyYIs8ligpwBLXQG7O
 dQ2jafLBSQQYJ6UaSTBZ0JzmJzNxGpHj6YAHdnhy06DQmYC1mjYaQOsrvsfQE7V3NO
 qzmiBDT7oOSEasUwgA7pYP3gMPbdmlBEohv5ov+9Fa8NHUkgGkI4YIGN1t3ep+AIZA
 R8nHOpEci70LMP7k57RSsT9fWdU6a+bKLeCyh0rwT4TCkHmFMHBJIzkmGuUlQNt3gd
 Bds+Pj+Q01YQ8pB4mV50/t8NkW3bRzK7wmmHxp4sMo5OtrHs/7Ps60hGXH2gCSv2p5
 TgfK/laGEY4Gg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:12 +0200
Subject: [PATCH v6 12/13] ARM: dts: ux500: Harmonize GPIO key names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-12-61446b6c289e@kernel.org>
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

U-Boot want to use the volume down key for activating fastboot mode,
however the code there relies on using the key label, and this
differs betweem Golden and the other devices, so harmonize this
by using the same label as the other devices.

Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: ..... ]

(cherry picked from commit .....)
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

