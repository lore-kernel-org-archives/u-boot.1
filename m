Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E31C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CE18755C;
	Tue, 19 Dec 2023 17:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XVlIujTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CB687725; Tue, 19 Dec 2023 17:04:28 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A5587527
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c69403b3eso47166555e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001863; x=1703606663; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Alg0o1zfE3YmTuKYZqJRl7vavWI45irNz7ZFJBUKGnQ=;
 b=XVlIujTX8389xwD1aX+rEfQ6s8h3ia4BO51EgdA8o561gMsRvFsouD1DXm39c5n2Q8
 LEfd1xYUJxAC66zBI7NLvsrO9HorigINEauChfhckS+disX/PvjG+wPImFMselBEe299
 2rw97ms+rlvOlBwbQ3r5ap3brIIUMKN7K4BMW7nm3xXrQopEGXLaJo1EwUObkO+2h+sQ
 D/jdaqL54ygYcg3GLdUM+Qmklbhv2/tV0zMv4iDffIBSySoQixYIGjcUscGB2bQZ7e+0
 0J3p3qw7Ll5XUfY5ek8DXw36uqFvqNRhj67lKVUd8N4LMmw87k5Zcjz3f28YgGC+tPu6
 tzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001863; x=1703606663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Alg0o1zfE3YmTuKYZqJRl7vavWI45irNz7ZFJBUKGnQ=;
 b=spUUNh96OOuoISWlG9qMjW6u1IYT3xTGgSs4rIw6PTj/ZCF2ICIYRAAUqGPdeUI4fj
 fGMoJGsGzkiuyySqdWFAqTBa3SlXPOELoIGGviv5tIoH8Xjtq5+z75pevmno7cIVoTpN
 L0L4GKbMdphcDzAjXglvpKaENrUagkgtD36InV3ClTjBaR9XnlDDPfriYu+KpxSK1K6I
 Hqn1V66AOIUEPl5ZNWjSq0bZlrizfl7p7d/MeICmkXzetnwtgKw3JmmxRBSOT24J6mwo
 DGgLL6DuTpf7r9QFrKDN3ZRfu1RsntCQm4PLL5opKGdl9e7J87+2USGuFeM7341nPZwr
 Xbrg==
X-Gm-Message-State: AOJu0YyVWmjZ5oqBXXLyHJuci2D+xD7tuXcBMcFTqI2hWhqu7/E1eLbE
 SL/ZgYKf9Ga3TNcCFALwLIl5UQ==
X-Google-Smtp-Source: AGHT+IEAMmNrQaYnMwpVdWOB2mqfZl7V/wkAXICo+mGtx3LrUVvWsLo4ehAxpluVusDF0YbOGu2H3A==
X-Received: by 2002:a05:600c:4f82:b0:40c:4dc5:b2ee with SMTP id
 n2-20020a05600c4f8200b0040c4dc5b2eemr7260360wmq.149.1703001863313; 
 Tue, 19 Dec 2023 08:04:23 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:22 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:02 +0000
Subject: [PATCH v2 01/32] arm: init: export prev_bl_fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-1-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZEVZs2a/1UTwGpaFvzkhoL2Qtc8IbTQk1dXh5VVKk5I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/YxuBXcmZTF3PpWuTqrWf66v7XBvb6LXwRViMy7Ht
 N3d+62go5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzksQDDX+E38fdc86/89OcQ
 PamRafT/+PXcPxOO/FT7vu99RrifrAUjw+TOo0n1yUuVfigZrY942it+VH27Ps+HxTtm7v33YMn
 xGBEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When booting U-Boot on board with a locked down first-stage bootloader,
we emulate the Linux boot header. By passing the U-Boot FDT through this
first-stage bootloader and retrieving it afterwards we can pre-populate
the memory nodes and other info like the KASLR address.

Add a function to export the FDT addr so that boards can use it over the
built-in FDT.

Don't check is_addr_accessible() here because we might not yet have a
valid mem_map if it's going to be populated from the FDT, let the board
do their own validation instead.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch has no dependencies

Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/save_prev_bl_data.c |  5 +++++
 include/init.h                   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b286bac9bf00 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -45,6 +45,11 @@ bool is_addr_accessible(phys_addr_t addr)
 	return false;
 }
 
+phys_addr_t get_prev_bl_fdt_addr(void)
+{
+	return reg0;
+}
+
 int save_prev_bl_data(void)
 {
 	struct fdt_header *fdt_blob;
diff --git a/include/init.h b/include/init.h
index d57a24fd00dd..7a3ab152b65f 100644
--- a/include/init.h
+++ b/include/init.h
@@ -168,6 +168,17 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
  * Return: 0 if ok; -ENODATA on error
  */
 int save_prev_bl_data(void);
+
+/**
+ * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
+ * of the FDT passed by the previous bootloader.
+ *
+ * Return: the address of the FDT passed by the previous bootloader
+ * or 0 if not found.
+ */
+phys_addr_t get_prev_bl_fdt_addr(void);
+#else
+#define get_prev_bl_fdt_addr() 0LLU
 #endif
 
 /**

-- 
2.42.1

