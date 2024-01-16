Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3655C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B24887A05;
	Tue, 16 Jan 2024 18:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9WfBMSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD4B87A36; Tue, 16 Jan 2024 18:14:33 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B2887A14
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-427a3887483so62862621cf.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425268; x=1706030068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiMM1MFv91uHV7BD5aRWuIOj8x1+iCYX0IYLQ6Y+DEw=;
 b=x9WfBMSgxCbbui/7sKL9qz/7qP+im8Y8dzL65p3tIUHJ0FcwusUQnJtN7JENYv6mtr
 YrmV+DnrYitRNEk+M0RW/J+TiOtT0o9UGWs98LEPlpLDq5iFzgUxqEZGYlals0NBlg47
 3hKu5vWFVlZ/7TmFkgQZZSfk06QjFkrp6MpSRJwG/omBK8vhusSWfU7HTdU+Tr5mMHKR
 OEVHnbzA+5Ol+/lJoNxKVjWA/zPxu/NfpJBPHOz7d/o5mwKcWHKhf4vbfTmT6MgxnFSp
 cj/LWzCb0MMg8kMwxSfIjz0gkVTkRH+gpqV9P7ldH4mhe1N/XJ3viELpNY4wEngr9Xts
 lHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425268; x=1706030068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiMM1MFv91uHV7BD5aRWuIOj8x1+iCYX0IYLQ6Y+DEw=;
 b=C9p9/DTaMZpkILkurA6u4NQ9UzRy74esUeE/N6JYpzE/Zq/m7IXzyOZjf0VRU3/cMx
 snptQpSNDITQxWHVLx5gzsFQTkE/dGhTIZMbncjffHDStc4RPifdTZqDrSit4mU9MIe2
 NvsnEMGrbuyp/hbZ6ostWaPiiNhHwmS+FCnYrvLE/aCFCvb7kHij8m3nSJSYezSWrhNW
 WTGTjc6f0KZVy2lB10NeK97URGWDZa3uZiq1hs15QUVdHvJU6d57q9EfgZ0WHeM/zAF4
 /v7aBWOhd9U94Sbz3HJpglItsCvB8Gxk84XU/9Aa1qOcBUcP4/j1A+22kyf8XWkCtoIM
 0Qyw==
X-Gm-Message-State: AOJu0YzRBWIe27yargvXkENFxwIgDBRflVcoi1qdIt1UbkRsIELnTqtN
 KHnsCIevjSjh1SECc993UBxKJzgZ5v3em6rXiklOluc27E8=
X-Google-Smtp-Source: AGHT+IHKd1s6CQEe5zCPhs624QzyvhGMrwlyB+6pyzsakA8+kfmXEPDfd/Tao93luvMRpY4GSz5/sQ==
X-Received: by 2002:a05:622a:13c8:b0:429:f5e9:e20 with SMTP id
 p8-20020a05622a13c800b00429f5e90e20mr3378138qtk.124.1705425268564; 
 Tue, 16 Jan 2024 09:14:28 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:28 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v6 4/7] arm: armv7: save boot arguments
Date: Tue, 16 Jan 2024 09:13:49 -0800
Message-Id: <20240116171356.376801-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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
Changes in V5
- Drop the dependence on OF_BOARD.

 arch/arm/cpu/armv7/start.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..f4f50ab9a4 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,28 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
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

