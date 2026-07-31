Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCCC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA13C411A1;
	Fri, 31 Jul 2026 17:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1F_8Mw5-wIK; Fri, 31 Jul 2026 17:19:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B17C7411AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518344;
	bh=j6lZ4K9OuirGutroP6zx4gqIFkJLyUKla6A/bOYnYHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v5IgsGiUEbztuX8nmVZ8u3ga7P7KJ8nWwXH2RHwCb3o3yID6OBD1bBhianDWjOp5K
	 SUO3tJ8r521rlcfehxjKiDz8NmlJhmg+ehUJWnhHew0QOMDbN3mdz5eQafzfAZ7IzS
	 NCgyZH1MHqXHoh6QopJZSrctQd0gNr66QOajQle3B3Kxi3Btm/BJWNRIGYjoDHV7rn
	 r88JBz3ODimXnLoj7qR/1xjd51QJFaftfPE8xnfOLF3Vgj7PUZKAS8fDPdjckC79Mk
	 rwM5XvtufzSJahcnE1Y42mSgZ/kaQQzfvAJQV6Wl+kdHBDQ9d8ogmZNWLW9ZjGLG3W
	 Vgkfiycn83BWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B17C7411AE;
	Fri, 31 Jul 2026 17:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CBED3B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F290400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuyVhf6GaGt3 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A45940025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A45940025
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A45940025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1268992f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517912; x=1786122712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j6lZ4K9OuirGutroP6zx4gqIFkJLyUKla6A/bOYnYHs=;
 b=o9KX47dI7/lR6V7cKEP3sd4Uul/F4zJELVgTrnF9/BmsFcyD2bu08MouxlXusRXksv
 jWgAlb7+b5j1YgMaNq2f8NIm98FXajCynAwUrf80hVzsfzCUXr0Hg0zJ98BAscKf9/lo
 z0CedSWO2chexmBAZ9Jayi7EOmBRqOienFX9IwyKih2ooV8XLp7V0NoAR269bjPUXSAY
 uvVdgdssNdqibFyzMJb/poFCH5nx/rmFYP2lMWihS87RgoeikyMjZ5A2mBmRf5GNka5s
 O0XZkbGrasOtyWM5JLVbiT1Zq/zQ9noCZtfpaRv6FODkfnVGdO4TIF72m6PYq9URwS6X
 HjNg==
X-Gm-Message-State: AOJu0Yz7AIINlplFc55PhQJ8ViA1mSOMDwyB/Cvn/Hrp5cX319pIqztQ
 rcA3Gll0KCKQIpZiR8FSmwY0B0iE+Z5KYC3CpuKYo9iHS3G/ZUPeDOh+Y8I3z0wEJhZH0+ZNmYy
 APq4n
X-Gm-Gg: AR+sD10Sh2lkHoieDX022VQTeGvffYGCxPdbUBWEDs7dnMADr+rLfIMr8lx4lY9H6ZI
 xuvRdL8TCbC3jKX6f3VBsJ84J9qBo8Y54agxoahL87HT3COcN6FR9A8A3E0zhe75yVZzvgWLVjI
 ANPPoc/yR/je8up1X2j0w5U8g60HWUT+UvBqFoU1W9f7vgN4G7QCL6Y8l02bey5cBnGM3wv8zNZ
 J5xIDCHYClVM0zEvnV8VvBC2giwnzu7NT0N5QC83j+v9zjJQpY7J5WBx/tC1Q7L3lbg6KltVbd8
 vI4EixvtC2uiN1VWeQbITRgiJ/GGKk53SVZWlqyxUnMxSfztijI7CC7pAnNAfee67Wz4Ohw9Zt+
 YpU/Y2pldxMuEepKGrvCXWm8dnyUXH0ZFWtRBDoalUxq6kz1Rm3ltKv7tGNsbqzHt4VSKMzDrZU
 p3SFVODRc83rAI38ys1crJw12w9h0U2frqGwVMvBSV4se6sz7SLOMQIDioLzjD++m3X+t0Q/B96
 Ukjf8bdDA2EUjKGceAH4Ah7J/xB5GpgVev2pwqNsw==
X-Received: by 2002:a05:6000:460a:b0:474:5a38:f650 with SMTP id
 ffacd0b85a97d-47fd729e7cemr1031199f8f.3.1785517912182; 
 Fri, 31 Jul 2026 10:11:52 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:51 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:52 +0400
Subject: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in SPL
 if enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=alchark@flipper.net;
 h=from:subject:message-id; bh=tgvOT1q+cSAs/nNQADRHcp8FrRCNwR3ZOSQUG1w3K3I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFea+ZmjOirx9eQ96R8ufHyy4nTX0e7PMks94uZrn
 bT8ybzUuWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp3viWkWFB/zNbtk/9x5y39gZ4Ld6l4qzRpbXvidrz5b6nSp5Ne1bN8D/o1zm
 vFQZvZk/yld/ts3Fa04Q1XHO2z3Sr+vk27p3d84/MAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517912; x=1786122712;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6lZ4K9OuirGutroP6zx4gqIFkJLyUKla6A/bOYnYHs=;
 b=wHL9mRVvHjXA5HeReg6J/SdLN6scFnlD56cip7+nFoXgPngU9dDG0hvytLf6UfvwAy
 ZUvttOvTCJoYAdWYkCNxVn4Qr9h9XPWjgo33SBcdZmeTRKZAO4m1DvHjJXoKNninBiCF
 E+41YPUmRErdvRlhNr8F2ZaNpdJKPa3W0J6dXMy/eLdWA4nmyxyqe7NZ30nG5vdQ4bHl
 XCEw9ztG0lLzp5aDgBm0DC/A5nxdVxPpvdAk65hOb2cJ47UIE/rj/Z7fSFIVhwRJIHBc
 UM9mI7vGhVb4MlqcvNezyrbzd94iG50RR48a9CGe/Xxud1OtubyEF2Fubn8/z4gaoxAd
 w4uQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=wHL9mRVv
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Common code calls into a platform specific function to determine whether
to attempt OS boot in Falcon mode.

There is currently no platform logic to drive that decision on Rockchip,
so attempt Falcon mode boot whenever it is enabled in the configuration.

This can be overridden by board code if needed with appropriate logic, such
as checking for a button state to skip Falcon mode boot when pressed.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079a..54dec06737e1 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
 	cleanup_before_linux();
 }
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+/**
+ * board_spl_start_uboot() - decides whether to boot the OS or U-Boot proper
+ *
+ * If Falcon mode (direct Linux boot via TF-A from SPL) is selected via config,
+ * try booting to Linux first, with automatic fallback to U-Boot if it fails to
+ * load. Boards that want to implement conditional U-Boot/Linux selection logic
+ * override this, for instance to look at a button.
+ *
+ * Returns
+ *   0 to boot the OS directly
+ *   1 to boot U-Boot proper
+ */
+__weak int board_spl_start_uboot(void)
+{
+	return 0;
+}
+
+/*
+ * This overrides the weak default in common/spl/spl.c, so it must not itself
+ * be weak: two weak definitions of the same symbol would leave the choice
+ * between them up to archive link order.
+ */
+int spl_start_uboot(void)
+{
+	return board_spl_start_uboot();
+}
+#endif
+
 #if CONFIG_IS_ENABLED(RAM_DEVICE) && IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 binman_sym_declare_optional(ulong, payload, image_pos);
 binman_sym_declare_optional(ulong, payload, size);

-- 
2.54.0

