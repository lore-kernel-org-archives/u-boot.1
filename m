Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37C606A339
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o81XNiG4;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=A5rNjRol
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B03F60EB5;
	Fri, 13 Nov 2026 02:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3H7tcoLVmTs; Fri, 13 Nov 2026 02:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E9CF60EA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537219;
	b=Us1JBvjMYLxk6sW6tQGkt71RqMAg7mp/BqSOHPAKujHMJE1eoM+ohVaMzHRMJmgD/o+w
	 ftQa0G3Sr+VMEJanjiPSNfLlppNzW33cLbjbkH38IMaOkHI0m1w1DH656EQ64ayptFBfS
	 kdJ0PikKOvwxLenjPeLypwPh3HfkTqn96F9lMeGy7uzBBMmQADD6UVUKwupJRmsOZR5i3
	 kpVwBjEzcVGEoyrylQDBzzA7IbbLdyyQkw1S0Fr1/qkddvrSYmzL7khHXHMIjHb4/nHs5
	 sn7mVgcliN53lKugDcUz2wdYRLK9J2PUk5+fWQMN6xPLEPF/oD6NoDzz3LCL60bhEPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tlsTPBboYYOI/3dC+fU+IBVnaeJywJd0KDoEiy859O4=;
	b=kn4bR/0jdr1BnEZf3T4v7CyVn7FFU4+MPgwY1DhYiaO7iFgCLmtH7Ytx8C06+l6ERNuR
	 AfoCUFtpgnZN0y7My7O6li7ZGDxEVETCiL9O1Wwia6+MWOnuw3f3dB6g3N8YFeLKAvqDr
	 RwoyRdvyGxDVzeIKZaRRgq9vJaRDGWolPxF6gegiqh4k/+ej197zQmQUsZTMbdIKw9hDI
	 Z+Y6aAXXiN/06niqhXMjyXJOOj/IQzCo+cLZbto/qoGjtZ53mN0y8/KpWvCLK9dL9zIDg
	 NpWc61nLyPQNc9oNY+uxlehVVetDHT7ob2T01eUp1Pw0bQ5ZMfGF4rvHw8BDcncfnPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537219;
	bh=tlsTPBboYYOI/3dC+fU+IBVnaeJywJd0KDoEiy859O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o81XNiG4zu/TVRHiTVxcB+ErUWnkJ1OECC51GCKgmIGxvWj81EEcRDeE8LavvC3oJ
	 IONj0wJHjRI7TEfruqFGbiW9WRLerzYapnatHzN0+h5UQM66vUJNlMFFc9wnTEn0oN
	 1SwO/2zDwZUaGVwqwsRKQJ4UMmugQXZwQt7meOUSiuj0FxgIBV804LT4sFjBS4oXdc
	 NJmcXtW2jc/AYtXoPvtNhbCw5jHIMNmLPPSweZ51hUsGW994TXKVaGbYPRsMr/XSay
	 CdrFyYqiRkhLca0+L1TM4I+aVvauIbjLhVvynEx/AczHAiTtP2uB5UCjT3CErqFXBi
	 dzIFVIi/lWePg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E9CF60EA1;
	Fri, 13 Nov 2026 02:33:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B34F32FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A539D401BE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Sez9VuAbxYw for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B704A40082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=A5rNjRol
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B704A40082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:36 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 14B5B4C8BD;
 Fri, 13 Nov 2026 13:33:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlsTPBboYYOI/3dC+fU+IBVnaeJywJd0KDoEiy859O4=;
 b=A5rNjRolPeSR0rSOzvt/tDGYcvH4TPubSWwJbku5pVYXp5rO+XdPd6I1uhLS9ZZtKN8nje
 0aFi2qJZ1RmyQ7KttclnKx62+F7aZW7P20Ikw53U86MJPRywXGJdsXBFsNb5HnzxaMZzK2
 6pKsZGc7Df/yOR4C0TKZdGXvMKc3zcRTKUOmtZ1KZ8MxIwgxZrUywC6fDXi7FC+1w6Nu4M
 egVfFdgRo8YDwMSdXvjNRHPLv0KqOp6Zz0/a2eBXpMBwzfAxuQkczvux30DNd3TDALk/hb
 2/XRsCWBtTMFZpZJl/njz6JYI+d/fqyFOFxH8zbMfSVrRB1URP+z6B/g5GCcEQ==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 11/26] sunxi: a733: uart: setup serial console
Date: Fri, 13 Nov 2026 13:32:21 +1100
Message-ID: <20261113023236.569054-12-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
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

From: Yixun Lan <dlan@gentoo.org>

Set up the UART stride, R_UART base address, and SPL UART0 serial
console pinmux (PB9/PB10 by default, or PB0/PB1 when CONFIG_UART0_PORT_B0
is enabled) for the Allwinner A733 SoC.

Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-3-f19dcd098f60@gentoo.org
Signed-off-by: Yixun Lan <dlan@gentoo.org>
[Alastair: add 0x1000 UART stride, R_UART base, and PB0/PB1 UART0 support]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/include/asm/arch-sunxi/serial.h | 15 ++++++++++++---
 arch/arm/mach-sunxi/board.c              | 10 ++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/serial.h b/arch/arm/include/asm/arch-sunxi/serial.h
index 9386287b65e..ad785ff71e9 100644
--- a/arch/arm/include/asm/arch-sunxi/serial.h
+++ b/arch/arm/include/asm/arch-sunxi/serial.h
@@ -17,6 +17,9 @@
 #elif defined(CONFIG_MACH_SUNIV)
 #define SUNXI_UART0_BASE		0x01c25000
 #define SUNXI_R_UART_BASE		0
+#elif defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_UART0_BASE		0x02500000
+#define SUNXI_R_UART_BASE		0x07080000
 #elif defined(CONFIG_SUNXI_GEN_NCAT2)
 #define SUNXI_UART0_BASE		0x02500000
 #define SUNXI_R_UART_BASE		0		// 0x07080000 (?>
@@ -25,8 +28,14 @@
 #define SUNXI_R_UART_BASE		0x01f02800
 #endif
 
-#define SUNXI_UART1_BASE		(SUNXI_UART0_BASE + 0x400)
-#define SUNXI_UART2_BASE		(SUNXI_UART0_BASE + 0x800)
-#define SUNXI_UART3_BASE		(SUNXI_UART0_BASE + 0xc00)
+#ifdef CONFIG_MACH_SUN60I_A733
+#define SUNXI_UART_STRIDE		0x1000
+#else
+#define SUNXI_UART_STRIDE		0x400
+#endif
+
+#define SUNXI_UART1_BASE		(SUNXI_UART0_BASE + SUNXI_UART_STRIDE)
+#define SUNXI_UART2_BASE		(SUNXI_UART0_BASE + 2 * SUNXI_UART_STRIDE)
+#define SUNXI_UART3_BASE		(SUNXI_UART0_BASE + 3 * SUNXI_UART_STRIDE)
 
 #endif /* SUNXI_SERIAL_MEMMAP_H */
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..38936afae24 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -145,6 +145,16 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), 2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), 2);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN60I_A733)
+#if IS_ENABLED(CONFIG_UART0_PORT_B0)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN60I_A733_GPB0_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN60I_A733_GPB0_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
+#else
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN60I_A733_GPB9_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN60I_A733_GPB9_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
+#endif
 #elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A83T)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
-- 
2.53.0

