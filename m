Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ml4gt7YV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=o0tU0X1y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 176D94097F;
	Thu, 22 Oct 2026 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vGPDjJqArnx; Thu, 22 Oct 2026 10:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B4814094E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792664174;
	b=jkkLmQ+UHZR78qwCEmvqNfYTN7oUTCP/DcgNQpXq2aC3SrtU5JL0IvrRYaq9qelv4/ZS
	 W2Slu2wImsYAQaF9QtFPCz8BNeGb6L72sE3JGLgQiUG1FfQsaNVVA8wMcBL4ati1ImduZ
	 ukNd0wlTSNBzcWQnJyFKxFO72IXW/77ObgXvfO7d9wMmPPyNyjsGRgjkFlF03f8ii+8z/
	 sftdD584lr3NP4GBTtM/0ygDMjvJTXi/Woqs0jtlR/MwYcn7d1fx85HkYeXtjWMckuImt
	 AAEyNlA6FqBpqafd+jFEkqPOwgJIcuTO9Sxa/TCn3z5KlboGx+u27+ZI5KJkMSqglUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792664174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OsHcR+9T/6CUrcYQCJpTNxEAlbcTmMN2CCnZJYUTFbw=;
	b=hxTvoDYbiHHoqmPwjxdHpKo2dIFyrFg/9OFZp79thnJ0N8PLGMzanI9FEu7ud2MQv97D
	 9OZHOH7YEr0hkFHsrFKSxfSygeGRz+y+eg4WxSPldfYoUTpKnPcKR0kTOPlhBJLTY+SQX
	 wwKINDVbiLXaQ2NStsHeSns+8bGwZwbsILiUIzXlOWraIJ3yiYCkA8VkHMDLpUBus8LXe
	 VgIEg0sEKhrMly18sSLilHWGTyiRPDd1czbSLOS4znj2o9Z1EqPgkvrj12Mz1UI8EtpY1
	 bPz6FJKrYu+jboHMYOu6gLy8Shj1YruwjLVeQUa5Qpl/ACmzMrIRtng1yd7mQsisStw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792664174;
	bh=OsHcR+9T/6CUrcYQCJpTNxEAlbcTmMN2CCnZJYUTFbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ml4gt7YVTduFQz0Y+BPP5hEchMIRv4f/ezcfuzshT/1uyf8jMagKW1//8U+/HCK44
	 9fa0jh5bCvS7DpEH4JjeAoD52UZ5ZcUw4oO/DDpaAr+FLQnG0sjUsNx9SaEDyksth7
	 ZJh6yH2xnBV1klj2mBaOml3iBx1Z2kIGrXQXIjkq/eGzxdtso3T1Q/G3bk0M8EF05+
	 7bb00iCFOvEof02oCeosCA1nDicmkQ+owZxVusb+u6sx+JyJpjQdL8NVZaRNHwGc6N
	 +ZXCn0wReXdJNa27kDMJeXdaPJwe5dwYj8DsIhBniky0nwl9O6uVIAG1xgybed84Ct
	 kZFD+ACwpd87Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B4814094E;
	Thu, 22 Oct 2026 10:16:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80D78356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E58260884
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWXJnHlNhS6O for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9382B60818
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792664170;
 b=eRr1LZs25zNuSx1puSOpoMUgzH3ppN+RO5UrKwrGnbsLOKgTKkEdg08MkIgyJiRNQF0n
 oU6Jnm3vkPPTQBunfcyUHofU+HP7UzS+oDCHHCMCp60/4ibY7xZ1CTmwuX7PZiHthK3g2
 6Mtd2vEkjNO/2RagCKQkuRcXpoj1rFLJ3+yivH8nihv6bDKx2hfxXhD8JZnq/xIxtx3vt
 V7QZ+Wq7VI52ZfzfOMP46lxVC1Two5KlwvA5uNHEkysXDB5nHfa1pSrUBwjkqPQucvi2t
 6yY4QCVfKwEsZwsI8YEt3bbkkOYSsLG6O9afo/vua32+mS0k8hOrzbqRjx57hEatEuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792664170;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=OsHcR+9T/6CUrcYQCJpTNxEAlbcTmMN2CCnZJYUTFbw=;
 b=IoBSaprO/Jqxt8qMmvfAUwPsVIcd3hzY4jf7IP6FAv2xGCqp3lcVwHMuYp5n+Wa+9e6F
 tvdvmC8F/m1+tvbkRdQDBhk4liQLC9AoRySOkJvU9JZzKX26K/9Gq47AHQy1AYkz1XWvS
 EZxSiXUsM0p/+XauUhk4q9WC1zms7M5B7VSzjhEYl9Iqm82MoJPEF9w8BlDm89AUYq7Nl
 lR/McxOLzgrZiR6XEejmEKUTJYeTYqPrip8oLNhu+WIDNcUdXX+sp5wsOi0KN1useQQKF
 CJVlOXc6Ll2j9fVP9MN0qN/UzwQM0lNHpyWXz1X5JqGEWY36TxXqgwmJQaqMFb7HiNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=o0tU0X1y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o0tU0X1y
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9382B60818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:08 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso522812f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792664166; x=1793268966;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OsHcR+9T/6CUrcYQCJpTNxEAlbcTmMN2CCnZJYUTFbw=;
 b=o0tU0X1yX0o2IcrK4bzLn1Aji8JqnIHtRt3EHCeKqarsbNV1/n5ifJSSvNHaThAbcO
 Zn8O4yzBxN84ELqoy80eZUWYyT+AvQr4gAlR1UjWE2pYnMI9hMlMxW/C+bQkMHRwv/mY
 t2ikMqGwYeOsaH+7Z08Avbo5tkMTQwq9jD38ImWCCiDYYeHR1XOSSKYOyzsazCDbie0u
 qyLHwrORtIx/gskolvsJ9ZpwQfydvbvlLnKAK0CKdZzD7SMtO2EC85Sm8HfWPy39jT5S
 uL2y5fdWR0Pjl/8HwCrPw79B42N+3B3n6kDKZgmdHT8jW3u5hHNoKNeT3JmSDCnv58U8
 bJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664166; x=1793268966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OsHcR+9T/6CUrcYQCJpTNxEAlbcTmMN2CCnZJYUTFbw=;
 b=M0TwoOgfm9r4rQIXJVA2SJckNyjzeYmZ4EEmmYNmwZFoR4WTybmE7t75lTMUpDjGcl
 RFBQPbVq06XJBuc/RwBfn0cwrGFYGZk80jy/OikpL51eNva0wGbECO2g+Ap3CsMzPsHN
 dMpo5adG1Xwr14IbknJuwPMfla5vt3pSLePoRyV0SdQHUo4kgDzc8U9vmiC0YK/5XhSg
 OYgRcL5grfzE6ZUp5T16JAJ4ynlxe9/R5M7TX4JgVP+3Cy4U7lOfIqkMPjjSRj7ohXs/
 QNHgJs5TAadA4c7Vn35IxaUqnF2kRxkuJQOKvi41Gk0srvl7YIZD4IiUh+H+z45MBvw/
 fskg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvtAe+LAxb4h6/+EGbHPqlm7y5jtiHLFz7mgWD2dv/ASCBEQYRrDjYZ0Gs2CMN7dxP04EFlt0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI3bjZ+6t6bBtVHlGzoLLZKrpJTSMs/ExRbsjuClzyybOL5XEB0
 pOfmRl9Og3quNzDCzNxhhi2+ES/5drYtbWm+Rvc7iRMj0kwa8FDcQtUbC5BBUgyOL2c=
X-Gm-Gg: AYBFou02f1ixnPSSsmVtFxQX1G1SQsqsZV+6My2Dw8CdP5rWMXVsXmPw3eDGb0Ndobq
 GXJhSq/ooghtrlp2rRxgo4uvDR+2ku84IT6q+3ndpSTb9vnOerQwcT9lNL4a+F+2EjdoHrlOels
 +gMuSqzLvSgGaN3aUWmA1q9pfPge4Twmes89zbfeiNnJx1JJVQhTfSD02jx8xNh4/oHs+5INPvi
 CEqnPIHeRwd1Gp0Nm028CW/ryWrId8WN9jtI6+04ErtSD0FO9NxgXVas4pfWVjFAnfCJiFuwFgq
 Ks++cRcdCzfvFBheSNEFnxUdXWjgVF3VWboE2pQvmVIheGu5hvHL6SRG9xjZYvYPLeKfyo+xVnI
 b6TdOr1cMqhejTRH0bPsY70Emuk05Z3s3T+KQWBFUJUCcx7FG6Y1VPthOdhg9u2EIcB8ZRx0sRa
 JU1TGU9phH2Ob8FMA6nTax3SHisyteh6fP7sP+fO1lGlikt9pL8bexmBPFMS0WnhXXUMjK8/yPv
 ZgODKahzt5+8r3y4MocUSTj7rfKk8Q3JnSKl6hxa3AIqsY7lce+88NQPjn1srcn87m2fw4IN150
 UYo9eo3MrlZLwdqqKAPJsyg=
X-Received: by 2002:a5d:5f96:0:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48e2d102e8bmr4648071f8f.10.1792664166357; 
 Thu, 22 Oct 2026 03:16:06 -0700 (PDT)
Received: from hermes.tailscale.baylibre.com
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583ffa8sm11693939f8f.51.2026.10.22.03.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:16:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>,
 Richard GENOUD <richard.genoud@bootlin.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH 3/3] WIP: arm: mach-k3: j722s: Wait for TIFS initialization
Date: Thu, 22 Oct 2026 12:15:58 +0200
Message-ID: <20261022101558.2474326-3-msp@baylibre.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022101558.2474326-1-msp@baylibre.com>
References: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
 <20261022101558.2474326-1-msp@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig            |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..ec3e95c11a39 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -30,6 +30,7 @@ config SOC_K3_J721S2
 
 config SOC_K3_J722S
 	bool "TI's K3 based J722S SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_J784S4
 	bool "TI's K3 based J784S4 SoC Family Support"
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..685c4d98a8a5 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -70,6 +71,18 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() before anything is probed.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static void k3_spl_init(void)
 {
 	struct udevice *dev;
@@ -84,9 +97,10 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
-	/* Init DM early */
+	/*
+	 * Init DM early. Note that this calls k3_spl_dm_post_init_f before
+	 * probing to do ctrl_mmr_unlock.
+	 */
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
-- 
2.56.0

