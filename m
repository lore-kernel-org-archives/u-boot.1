Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A6C5DF80
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F42C81113;
	Tue, 18 Aug 2026 09:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eq96BLQraavN; Tue, 18 Aug 2026 09:00:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C68E8810BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043654;
	bh=t7izog+V2nh7Pzb4KXfwMaaFOvzJy9AD1E0u7GFJjIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w25DVJayt2l6BYwVg54A+VlrDFFgCSTOEle5cZqM2RqUBwXDWXoOy+faEDerSyoGj
	 +9rkKlBQMYprna/VioKAbXvG7P1Kn8KyyQ2EEu3EVP3zMqKm8vUUcAGGJUYnlywCS5
	 Ir/er78QuWFv4YAoA88E4q/zAIb6iTVoVhiBZkoDgRykc3ij20XS6Bu3xnI2MaLUWZ
	 VFEC3VnHCntRDwMVKCLA0DTcC3DFlYhtf/1Vaq8gF/Ia3/rpqAseXpb0dXfpkTrY/Q
	 CxYi0Qx4jHMlXr+dNL2Zu4nbyVXQx/sFXHcFqj89JECG0yARK3bvimLRNVAxI7p12I
	 XMmLYZcfbiemQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C68E8810BE;
	Tue, 18 Aug 2026 09:00:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 513C223F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4249A407A9
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwHLKyO7UWpf for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5834840757
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5834840757
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=PAAMi5xl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5834840757
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 831A34143C;
 Tue, 18 Aug 2026 09:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD81F000E9;
 Tue, 18 Aug 2026 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043649;
 bh=t7izog+V2nh7Pzb4KXfwMaaFOvzJy9AD1E0u7GFJjIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PAAMi5xlpYMH9qPBNrvXWj8PCiMznAr/KCA71kZqSygSGhBNU7/YtkTKa85z302Ig
 W5LGLkTqtOqGjC9to4nFoLtxQcY23UFrJ0mPFgBjSxl0UEvk3qXozF8LOGZpcjP6mk
 ZOv57ZelmmNvB949f1ZF+cNa9LQmnpoNgnvUBa2s74IjP75xOiQFHbu/zUQXTJqXsI
 yLGPd4Vra9XltYLRlbNB3zzOVcf+ER9o1AgldoRoFnVBgxVV5OK2/wI9cjIlyzJG1V
 dwg7bBUHnztMkqBzeh+lsSVCto9BYfShMxu0oNMpDUzltll5pP/C87bTOnqjFeppA/
 ApQTj3OPM10QA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:35 +0200
Subject: [PATCH v3 11/11] arm: u8500: Enter fastboot with volume-down
 button
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-11-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
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

Enable GPIO button command support and map the common VOL- button
label to the existing fastboot command.

Golden uses a different label for the same KEY_VOLUMEDOWN button.
Normalize it in the U-Boot overlay so the environment works for all
target boards.

Link: https://lore.kernel.org/linux-arm-kernel/20260818-ux500-dts-golden-voldown-label-v1-1-3edd581b09df@kernel.org/
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi | 4 ++++
 configs/stemmy_defconfig                          | 3 +++
 include/configs/stemmy.h                          | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
index 647b3f73c413..34fc58ec1538 100644
--- a/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
+++ b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
@@ -9,3 +9,7 @@
 &panel_reg_3v0 {
 	regulator-name = "panel-fixed-supply-3v0";
 };
+
+&{/gpio-keys/volume-down} {
+	label = "VOL-";
+};
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index c253780df2ef..2bc395a2682e 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -15,6 +15,9 @@ CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
 CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_BUTTON_CMD=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/include/configs/stemmy.h b/include/configs/stemmy.h
index e58ddd752cd3..08fa3dfd5b75 100644
--- a/include/configs/stemmy.h
+++ b/include/configs/stemmy.h
@@ -36,7 +36,9 @@
 	"fastboot_partition_alias_userdata=DATAFS\0"
 
 #define BOOTCMD_ENV \
-	"fastbootcmd=echo '*** FASTBOOT MODE ***'; fastboot usb 0\0"
+	"fastbootcmd=echo '*** FASTBOOT MODE ***'; fastboot usb 0\0" \
+	"button_cmd_0_name=VOL-\0" \
+	"button_cmd_0=run fastbootcmd\0"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOT_ENV \

-- 
2.55.0

