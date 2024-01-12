Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A83C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE838785F;
	Fri, 12 Jan 2024 22:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uGy4DM9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620C886EA6; Fri, 12 Jan 2024 22:34:44 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814858785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78313f4d149so645924585a.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095280; x=1705700080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5YNPlhJytwclbnPZso5l+tBazJTAx0BgcunMJhm9IU=;
 b=uGy4DM9v9lA5otCsK1ImJop1Fi6msLlpH1KC0a4Zy9ojKl9W4ZLe/Wdt2xQaCGXHT8
 cmHKjM/3RFAx5Yhwj5TEE3EW6ZDQ4XnABJ88Va5/8S9idM4/CvuYnCJD0KvbonOKv/Dc
 J4Z1fU5aZs6WJ78lVX0QhMVibBFBnufjRraXyiYsF+HfTG1WaQBe92+rOt9qb0nzs83L
 PnXMLsb0/afdc/bt98IPoHG+4SaVl3p3F2sQW/c1k1d5TRK0QxRUnCmmwaRk67K/b0do
 n6v6VD27XMxPWPTgxP/ubht0MCLIZObTS7wUF0wQxh7A4EepTCHnFDn3LrRtoE8SZaDW
 7cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095280; x=1705700080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5YNPlhJytwclbnPZso5l+tBazJTAx0BgcunMJhm9IU=;
 b=r6OFe8p03QlF6zetCptdocDYxb1BEXL3qrLq8NIPBCK+JHJ4Tx0rDw8l26A1qyYaf5
 3RP9ipL564eZLhP3aJwWyrQR7+FZnowrTkpEhlPUqUKakfU8oQhqzRJCkN7MivTKQPqV
 e+UADsCjMAAhvlGUP1YgFKcsJdSZXQC19H0LQ3n8ojE06xHeFSHuOpMiJgwdFQjz1nbK
 ap4ro3kSiNCJpoRjkLRwSWy6qQYByZ6UCmzPtn91WCInzCOpEyLd6z1CuEz0v6V9poOj
 jr2A6xTazl20gCeeMyj1b5H82eNaAOfmyRDndF4vSWcmKCuMc+Hs4g1w407uhh4LgbG/
 lSsw==
X-Gm-Message-State: AOJu0YzfN1T9lH30U7V/6TizSOwg1quWwgfUK+7hyUBcUs4KdwGU6RWc
 Uwiif6djsVKBGkQp9trixo/jn/4qm1VhXerbe/T4p99HOfM=
X-Google-Smtp-Source: AGHT+IHGiLpQ3biOtk+sG80Co8Et3QhFSIb7mNgnpW7lcXzGOFOERftVdhVWsxuOgWPIKwrq0A3KMQ==
X-Received: by 2002:a05:620a:2410:b0:783:3f20:4113 with SMTP id
 d16-20020a05620a241000b007833f204113mr2777747qkn.65.1705095280005; 
 Fri, 12 Jan 2024 13:34:40 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:39 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 5/8] arm: armv8: save boot arguments
Date: Fri, 12 Jan 2024 13:33:31 -0800
Message-Id: <20240112213337.185460-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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

Save boot arguments x[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in V5
- Drop the dependence on OF_BOARD.

 arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..91cdd03947 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
-- 
2.25.1

