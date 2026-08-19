Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19896C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5F5140861;
	Wed, 19 Aug 2026 08:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiKwE5qpgoz7; Wed, 19 Aug 2026 08:54:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129675;
	bh=t7izog+V2nh7Pzb4KXfwMaaFOvzJy9AD1E0u7GFJjIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXl+lUcYQ7bSVArxYZ/mP42S2kggmkXmhrBJNg5OXvhEbYWt77JtjJkMWkVf4eOXT
	 BoqF5UpBoPy0W11tfbWT4MRnPtNegULwAinzW2my78kslyhCC2dLIjXm0EcoWU34oz
	 BgHoihWcHbeN2HKMIENx5+x8jCpZ8i7SMVf6YPalgxKYQfJSxxkCepxN7s91AAvE0+
	 FWAXJZtp8CCsvDQaG+uz9Nyg3okZK2G3EHNvkZaRrI+YnV8rrunApxf41Y6Czd9Hhl
	 hnrQpwi5+bxG/qBKcV/wm+q7BPtoGTbOO4DfjjJ6+gn9aKcdgNJF/TbY9XmMl0kdgk
	 1gEo3V2SmktCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FC0040815;
	Wed, 19 Aug 2026 08:54:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 121122FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03F8C60602
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VDx17Qn99DT for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ItA0E4Et
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 091B960614
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD0DA43C65;
 Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772761F000E9;
 Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129668;
 bh=t7izog+V2nh7Pzb4KXfwMaaFOvzJy9AD1E0u7GFJjIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ItA0E4EtAS7NX/edBxb+ciMbQJ4W4fFXaZBSM8FhtX727/e7h6iJ7EXxHuUbNUg44
 BS6Mc+LbvmDMtD55R0qEI3GnBCNxBRTBgkWtrXji4G3CExZSrYuLi0WbfeNEN875UN
 M/NlGjpJ2vpwUIwmDlpG1aEtHQ/bUpRwotrkae6YAtujFDUbiBoWyNd29IWLNV+K/H
 DjHYKIGgBFc42rSnqTiFjbtqUB9l5Q71rkm3Z2o6vkVQ+1h4K6p2fQaifKpBmoVVWX
 n9U5egz6JEcuBIHBdeJEssO/ZW/PhkAQ8mVzA/0DvZu2SUSZiwp67Eh69V0yU3kt2O
 dyR4viLX7Wuqw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:16 +0200
Subject: [PATCH v4 11/12] arm: u8500: Enter fastboot with volume-down
 button
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-11-f1c8c9ffac30@kernel.org>
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

