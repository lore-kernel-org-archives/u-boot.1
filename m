Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E7C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 23:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644A481D65;
	Fri, 28 Mar 2025 00:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jfKrITD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231E68129B; Fri, 28 Mar 2025 00:13:41 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32558070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 00:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476af5479feso14161171cf.2
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743117217; x=1743722017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQu9gkzttx5o3D6UrhD+56vx8IoJyPL+7EcStdv6gNI=;
 b=jfKrITD0dWM99KsDpUa23mcZvq2U3b3oDPzL0ENzkXCr3V8uCOgraFaokjreV3uot5
 UBBlSX6YQ/ld+2vQ+Th4B9rIcZCumAc3slYBZ+PkGe8yEMtaco6Q//CKKFeXTzyAVD16
 i2YOzUrxlHS9zkeATYi1hMlih6u5z2bZry0U4la4zXeHY/0KTl0qYwRp3SQsSs4EhTce
 W+wgXBdXwPQfMZBShN5wqAOyYo9ion6thRH/1DMoo9neZEMwOHCpFb5xcRaUrYuDN3Lx
 jEA+GzFVoTbNrLH8g3y4jbvoIaKXGuAFlI5x8HqR4pp7CyTqqkVbUMk13zdp6LTcOvNl
 piDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743117217; x=1743722017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQu9gkzttx5o3D6UrhD+56vx8IoJyPL+7EcStdv6gNI=;
 b=EJPOWCuhqXRCqGuHvFGZVRnKaq9zrwRwawz/WMcDhuGds/vRACPacAlZv6BxZPdaKj
 sWsgohQZTPKqC95D2tFpUensvd6ca5gMpRPA9OWaY377UiwAoRTFSUSf93MNemHhYcyG
 33r2LnTwcqtNKdYzxxUY+xYUzvWHCQ2Ohk2obE0V+R5fl4eQ+A3GkCRQ3GCe5F7GumQK
 gW1jNnoiZYtBgiHrpiLHQaF9/fI0QMsDQxI8NX/EnKGv+Fow635rMXmi5amL+XoWgq6x
 Vn1o7UCvyTtQH3Od83TmwRdELduQFT14Q4u5lSt/MkveOC/Wn7lD9V14fTti3PRiugdH
 /s4Q==
X-Gm-Message-State: AOJu0Yz6UYl7LsccGYry3gqL8sXJKYlvRhf5e/lvM9ZCFFcxDP+nLlM7
 1CbUE0tAEux9bix3mPSIq0lRROrDhmWdRGDfQfnGtqysGDMc1Ia9eE15xjHL739af2ZkqFb15mo
 7
X-Gm-Gg: ASbGnctfWtgOK0X4hFgLMjqTsWEPLr2pwt2PRbkgZcqdycGc/YrZl59e9sXPVpyUCmW
 r+cq9I+siS023b2VpzqPZX3GQSB5mdpJhrSd3b6SBrcnpU8KUw8s/flk6gAxdRh3dM9vxKliAKs
 DW4/FPbrEsIYWkAGZNUSpnkQeTI308j+dG4MUYu3IWuxPrROV4lXsJ7TdlwyW9h+HAW+cN1KWJB
 fL0Fi57QLbygT3rm56x7tq7H5nvXabInDfDQ3zhTsKXFRrZ4XjxYpQu+iuyY4deeeDCnW7hSK0+
 IJF0kspF2BIdIj72D9ZDfOUf5uKOst2qEOUywTvRvZlrF8UlwgNklYDLyBi7kem/hjyewg==
X-Google-Smtp-Source: AGHT+IHbE+sFE9v2cSCIrNQsV+twSs6n128RxpsecWyn/MiDUH1fU78+A3i2xoLcEnLuLxfK8ch5gA==
X-Received: by 2002:ac8:7f88:0:b0:477:6f6d:10fc with SMTP id
 d75a77b69052e-4776f6d1158mr66128111cf.5.1743117217402; 
 Thu, 27 Mar 2025 16:13:37 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47782a7fa50sm3283761cf.45.2025.03.27.16.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 16:13:36 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
Date: Thu, 27 Mar 2025 16:13:17 -0700
Message-Id: <20250327231318.2713201-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327231318.2713201-1-raymond.mao@linaro.org>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
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

Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
is a default address for bootefi, bootm and booti to look for the
device tree when launching the kernel.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 env/common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/env/common.c b/env/common.c
index a58955a4f42..a38e5d107a8 100644
--- a/env/common.c
+++ b/env/common.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <linux/printk.h>
 #include <linux/stddef.h>
+#include <mapmem.h>
 #include <search.h>
 #include <errno.h>
 #include <malloc.h>
@@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
 	return env_get_from_linear(default_environment, name, buf, len);
 }
 
+static int env_update_fdt_addr_from_bloblist(void)
+{
+	/*
+	 * fdt_addr is by default used by booti, bootm and bootefi,
+	 * thus set it to point to the fdt embedded in a bloblist if it exists.
+	 */
+	if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
+		return 0;
+
+	return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
+}
+
 void env_set_default(const char *s, int flags)
 {
 	if (s) {
@@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
 
 	gd->flags |= GD_FLG_ENV_READY;
 	gd->flags |= GD_FLG_ENV_DEFAULT;
+
+	/* This has to be done after GD_FLG_ENV_READY is set */
+	if (env_update_fdt_addr_from_bloblist())
+		pr_err("Failed to set fdt_addr to point at DTB\n");
 }
 
 /* [re]set individual variables to their value in the default environment */
-- 
2.25.1

