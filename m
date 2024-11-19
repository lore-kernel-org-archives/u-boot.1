Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC560D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F97895AD;
	Tue, 19 Nov 2024 14:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqf3P8ep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE5A8971C; Tue, 19 Nov 2024 14:20:35 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA008959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a6bdc8f7a1so16449815ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022432; x=1732627232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2C+pQPYN5p3WxMvT6cQliVQp2qultsjlNJVaV5L23g=;
 b=bqf3P8ep1KCy5DBjYthi5MdiW7vQu/IY7HqJOGPZlsZawi1mOga9yiU6qv09RmfXL3
 f6Dd1DZrqsQ5/vDN6yRihXK6si2kHCf9a/pWlHMfDjdSN9MFM1Y3P5VuzDpqS/UGnYQI
 /anOYKj9/4au/8ZeSiMlHvUxwv55I0JBe2QuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022432; x=1732627232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2C+pQPYN5p3WxMvT6cQliVQp2qultsjlNJVaV5L23g=;
 b=Lsujzcp0LtR44fu7g78jTRptPFq0OR0OZg53EpuY6Ne3tdWl8DEzGC/SPMbU8pVM0Q
 gNeNMQrZTl2s0A+vmgXBF1i+MN/hW+mzAdqeWQMSJqhiLT4Mug63FMVCJ2ihrQUEbbaq
 vaKdwr7UGnzYBSYW2q6AEMkkhVbvD9+8+WIW1/NlXUi0t2YbheBKa9BUyAOXJTZ1YXRx
 1SOBJ91U9kakP3rlIZGEcCoyJjP0mx/pDHoVo+/nvZbh+sTWEqihRMeOV4tZgV6m7iZ3
 lnU/2ssBX8VkAxqhRr599VAZysnWbu0uQYWQ2a0/RgwLNdpSlaqlQEnyROQDV7f0Kaka
 MyjA==
X-Gm-Message-State: AOJu0YwsVJhT2rmY5jnTh8zIQ86/dfXNgnqeS7QeHmBEbjvSi3JAmKrC
 37FGcb5eTGt+3vDpI17Y2UPJGr25KKZQgq4ccRbXVzWV6i5k61pcdniBmZcL1YvGooxmGXGFbZY
 =
X-Google-Smtp-Source: AGHT+IGJybAqzE1+mWqtkU28Z/MNqGhGlJS2xWsUeVgueqJcaC0NWcxamYJh60KdP6I7QKwQ9rEGyg==
X-Received: by 2002:a05:6e02:12e6:b0:3a7:7ee3:108d with SMTP id
 e9e14a558f8ab-3a77ee31438mr15199175ab.23.1732022431730; 
 Tue, 19 Nov 2024 05:20:31 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 37/39] pxe: Deal with a missing FDT in the bootflow
Date: Tue, 19 Nov 2024 06:18:42 -0700
Message-Id: <20241119131844.4078144-38-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Move processing of a missing FDT so that it happens before booting, so
we can see the result in the bootflow.

Signed-off-by: Simon Glass <sjg@chromium.org>

pxe: Deal with using the control FDT

Move selection of the control FDT so that it happens before booting, so
we can see the result in the bootflow.

---

 boot/pxe_utils.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index ca91bff7e51..99c968a1202 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -605,27 +605,9 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			      hextoul(initrd_filesize, NULL));
 	}
 
-	if (!bmi.conf_fdt) {
-		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
-			if (strcmp("-", label->fdt))
-				bmi.conf_fdt = env_get("fdt_addr");
-		} else {
-			bmi.conf_fdt = env_get("fdt_addr");
-		}
-	}
-
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
-		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
-			if (strcmp("-", label->fdt))
-				bmi.conf_fdt = env_get("fdtcontroladdr");
-		} else {
-			bmi.conf_fdt = env_get("fdtcontroladdr");
-		}
-	}
-
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
@@ -792,6 +774,34 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	if (ret)
 		return ret;
 
+	if (!conf_fdt) {
+		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
+			if (strcmp("-", label->fdt))
+				conf_fdt = env_get("fdt_addr");
+		} else {
+			conf_fdt = env_get("fdt_addr");
+		}
+	}
+
+	if (!conf_fdt) {
+		ulong kernel_addr_r;
+		void *buf;
+
+		kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
+		buf = map_sysmem(kernel_addr_r, 0);
+		if (genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
+			if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
+				if (strcmp("-", label->fdt))
+					conf_fdt = env_get("fdtcontroladdr");
+			} else {
+				conf_fdt = env_get("fdtcontroladdr");
+			}
+		}
+		unmap_sysmem(buf);
+	}
+	if (ctx->bflow)
+		ctx->bflow->fdt_addr = hextoul(conf_fdt, NULL);
+
 	if (ctx->no_boot)
 		return 0;
 
-- 
2.34.1

