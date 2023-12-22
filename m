Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF77EC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352508753D;
	Fri, 22 Dec 2023 22:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x5l5nfaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0970486FB5; Fri, 22 Dec 2023 22:32:06 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F395787805
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f8a5ed1a0so9498846d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280722; x=1703885522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87sG9HPEQ/b8s+kyD+6SBJ8evOSjubcYEd4dkOBwJ+4=;
 b=x5l5nfaSFlvszRRl9v/nRh2UjJTJ98+pQcVZduomdkpnFHWqvKu3fwdodObyr5K/8S
 xVanPiXTw3A5gHI2DIDpmpUdL+BavqHuvlTTKXLwqbu8xhRaDo2pnjQbpUPi9sSFff07
 ozrhZ/6rLdXon+6ZT+SCwM9S/gNushf/AlIj/wNyyl78L7R484m5QuTuVZaK99GeKzK6
 7hb8Hxxba0lZh9ruXbQa04GFjwaHaZOuezJVK3ukSjWSGRGNGL3z//yQlse/oOOFeT7z
 J1CKlffPh2btCEchItPWPdKkw/Gx9S2SYEaX3PkA1TeMODdFi58nRo1bmW/+wCqYWoUx
 +Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280722; x=1703885522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87sG9HPEQ/b8s+kyD+6SBJ8evOSjubcYEd4dkOBwJ+4=;
 b=XqoDyd79815yu8gD/iaoq2cknWZ5/peNRj03jd7goKXm5ly/p7+yUdT9mxOsCAImuY
 NpOTI3fqvgGGRarI5JIWrWyiq8JQo3ngxhFQaERzV+XHfnjSpoT2XDcmx3mRHTqdHplD
 LIhB6JFcFhV1pJLJET6GO1QqbZ0kgYxr8jLoOLAHS+dNcmW2ne5m251HeHslUDbwkQJD
 qVlc5Dp7W7bDotvZKuOpos3M/E7I4GW+VeN6rs5jx8yo2WRYiJy38kK9j5IcYPnnqEle
 qqE5Ts4uUN9m4IaKOhWIfPyvKPMOpaUWnaV22gc1pCBt7Jtyl6GcGLegthJqd0S6upqx
 BDUg==
X-Gm-Message-State: AOJu0YzNB9oAzoKmx01FNtQiZ3cnQq/DCkM4C7zm0tXqkdSVk3MfX9jE
 N7fxhJZDMcMhg7qEHzJNkdOPzoL8obVGKkIJuK36x2WnBDM=
X-Google-Smtp-Source: AGHT+IGofkQ97qqbcQauHvGXjbxcNmQiP86Y16iyETCi4FjnKqzGIn5e7hEOrNDLgckwvDi0YHxfNA==
X-Received: by 2002:a05:6214:f0d:b0:67f:5184:8e5c with SMTP id
 gw13-20020a0562140f0d00b0067f51848e5cmr2414015qvb.10.1703280722355; 
 Fri, 22 Dec 2023 13:32:02 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:32:01 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 5/9] arm: armv8: save boot arguments
Date: Fri, 22 Dec 2023 13:31:05 -0800
Message-Id: <20231222213110.660402-6-raymond.mao@linaro.org>
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

Save boot arguments x[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..8e704f590e 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
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

