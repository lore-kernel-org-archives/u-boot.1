Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D206C47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807D087944;
	Tue,  2 Jan 2024 23:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sMwdmuc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6331A87962; Tue,  2 Jan 2024 23:13:26 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F518756F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-781716c1291so424087485a.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233603; x=1704838403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8o0cE8CaSjHzd/qVtCnzdezrrJR+JssGq7NuaFzCLA=;
 b=sMwdmuc2prtm1mBxB127p9lhF5xyZj7xaYkiNdao0zkVzhhUmpPsqzHXG4zO/BMR7i
 se1WxiRy6fSzSb4Nc2ZLu41bvfQwYAGntkhqd35BhUvhOb7EQBDHBaRzgo7zKJLen8uQ
 +BQBgVfUEbTzG1gFAfo1Q8G6IQFtYh0rBrcY0U/U5ELuxUUtqr9Vqnzs8PtTDdkSbE3c
 56IkbnIi5L0jNrN0KgW9/BtVeLlNQlqpm6Up7tehCb6QUEvWyKGzCKeCG9h1v5xPlS8w
 uKEhUP+XO5d1x7LkUzio/AvJNi1LUh7QR7gAWVZVqwzGUHU7H531N18YkgC133+evuy4
 vQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233603; x=1704838403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8o0cE8CaSjHzd/qVtCnzdezrrJR+JssGq7NuaFzCLA=;
 b=NqRBC2yMAzoOkeZKrzFI7THj56KAn1VzkCLorW1BpMOZujBwdPvvFF84LHXjHoDUbY
 ulVdGubFRfZIGvUofdR7Gu2ZJxgd8NPeVQUo2R8XZMUq78AfarngCqbNnOR260iiMCKb
 TePagCOBgwnYYFFLJrasXFWvj/ftl/jhgfcd4IdiXcwu6Xn7q5UkutMeI/fHooWZG1yM
 BTJN0sSlwuQ2p78Lj//Hywa7RWWKIMbJ9klpE6mr9jI5eowUq/w6BxvOgULvp/d13oMB
 SbE00xPnIOAwLfQfx5w906CJzH8Pn7FCUJprmuM4mvMiIT04BP/o+MeDcNY7xjv/GZLd
 5HbA==
X-Gm-Message-State: AOJu0YwOtTf5HIF1iX3qHeZO5SlCfq3tISSN5ljCpASHMvPMcZn9YPi0
 +7Ip9uxUFn+GHNq483Pe3fsVmAn2j2iJSD52h1SldzvlHHA=
X-Google-Smtp-Source: AGHT+IFoUnTsMns3qhGp4AS/+oQrAwP28txJ3Rb/5hIg6DbKL8a+DdFRlrMBxUnygtWmtjj0gwQUuA==
X-Received: by 2002:a05:6214:62a:b0:67f:28d6:7108 with SMTP id
 a10-20020a056214062a00b0067f28d67108mr28550456qvx.40.1704233602968; 
 Tue, 02 Jan 2024 14:13:22 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:22 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 4/9] arm: armv7: save boot arguments
Date: Tue,  2 Jan 2024 14:12:29 -0800
Message-Id: <20240102221237.1007090-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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
Changes in v4
- Fix a bug when saving the boot args.

 arch/arm/cpu/armv7/start.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..66372e4c68 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,28 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
+	ldr r12, =saved_args
+	/*
+	 * Intentionally swapping r0 with r2 in order to simplify the C
+	 * function we use later.
+	 */
+	str r2, [r12]
+	str r1, [r12, #4]
+	str r0, [r12, #8]
+	str r3, [r12, #12]
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

