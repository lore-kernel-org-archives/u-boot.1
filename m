Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19ACC46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A2987579;
	Fri, 22 Dec 2023 22:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/1ng1g6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A183286FB5; Fri, 22 Dec 2023 22:32:01 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90115877BC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7810b3c4fa9so241304785a.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280718; x=1703885518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B0Hur6ceb0a0gHcAEPiu+wT17rZUpmB+zNLTferZMc=;
 b=h/1ng1g67JEgl1upIY/Dmn1GXaiPMXrvJx11kp5eDqjeD/MuMQQBmQiLnvEWqc8JmF
 +/kB9Af2cjU6dTALW6dNrGbTBThVqTS3Aa+kTNvfgQzS+INVFVUmWGbRpX7dnrl6mm2b
 5hpqeYhM9/1aHqx/GUDrPDWmZH+D65U807UNryrVP5kAgSWlKbxRC5kJSe2DBhIwSoR3
 RxGSkCXvkL+f/DgJkpxaA9yzaEcX+jCCjKs6UcGv2tOtFdseYYYyEtiu/p2f0gnGfQYJ
 KpPhbFpCrlTDs6x820+1ScCQO0aRqavtlODMILnhUraT970tnqbxC0SPSe5lFRPWIpZO
 NsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280718; x=1703885518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B0Hur6ceb0a0gHcAEPiu+wT17rZUpmB+zNLTferZMc=;
 b=MAS17fmBy4hb8N+lzcToJGZq3Jdr1j/nmi6h6Wdj9Ynb3gY6nKByFfD2T9C7/A8Wqz
 P99bWVpd5iieGJGE6eQ7UcmoDIz1eLtVlXtvT5Knonhz+S6Q/n34WqHRn++unmmhk2E/
 ZS1LK/fV5hJZYs25UjTRWgH8y3bzsz1vZuhYLWXNQMteDhhWQpsbo8/+EBoXUG7g8i+4
 qiJnh3eZP5KTlLL07dlv5R1DzozqIT+QSe8J2mkktkFjC46GSZ9CadOCywlPI1USHQhg
 BOeoUFo0KNe7XrbmU1+O6TmcRabHZrAuNbNT0EBxvJzGgGdcR7MBJcSG9D1WLP11GgQL
 chpw==
X-Gm-Message-State: AOJu0YxwYfx4bcYlylLghHE2frhnnD8hRWMAm6NTct4sK8OOb6+gj1hs
 Tjbifcso62HydumtnfbxaWxtT5pxSYqveSOtImfxHagzTow=
X-Google-Smtp-Source: AGHT+IH0WR9xpYJQmO5AOMCdSHSbDLx9QcTWhFSkuBySkeTDJfTbDvPh/XLoZFuCripQe+mWV+nF7Q==
X-Received: by 2002:a05:6214:1d2a:b0:67f:7e15:fc9e with SMTP id
 f10-20020a0562141d2a00b0067f7e15fc9emr2923837qvd.63.1703280718104; 
 Fri, 22 Dec 2023 13:31:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:31:57 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/9] arm: armv7: save boot arguments
Date: Fri, 22 Dec 2023 13:31:04 -0800
Message-Id: <20231222213110.660402-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Save boot arguments r[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in v3
- Swap value of r0 with r2.

 arch/arm/cpu/armv7/start.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..2ca63ca32c 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
+	ldr r12, =saved_args
+	/* Intentionally swapping r0 with r2 */
+	stm r12, {r2, r1, r0, r3}
+#endif
 	b	save_boot_params_ret		@ back to my caller
 ENDPROC(save_boot_params)
 
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.word 0
+	.endr
+END(saved_args)
+
 #ifdef CONFIG_ARMV7_LPAE
 WEAK(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-- 
2.25.1

