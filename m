Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315CCE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B64F89685;
	Wed,  4 Dec 2024 00:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PBfPk8+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C38B89326; Wed,  4 Dec 2024 00:48:07 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50CD8967D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-843e3b49501so197598939f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269683; x=1733874483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99yWmNGac7HvS5PIqaO4WTa+FuVX6TAIYsUh1NTygfc=;
 b=PBfPk8+pe9hMpLaAUFFEq49nQmgbEsOEBkurLvk/oZniWdmrQYeYbzXRV5faUuFJys
 NSTbzCshIocrBimvBm3A5awBUtenauBBq1trI8witXQmaLKg7jjFEn9OjwZthrZSD76F
 6w2NNrw25vnaIXES0uFmuQzCDiKIGDCV3Qnnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269683; x=1733874483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99yWmNGac7HvS5PIqaO4WTa+FuVX6TAIYsUh1NTygfc=;
 b=ZHFwytVwT2MVXA4Nys/pc1dkIpQ6FIYMoKKZTIaPEb45F4ifbmKltouc2vFqUop26G
 U7vLDNgxPQRWOIDgKKDLrNC3pJFUZMbuwjdn1VFViEtA7C/uuRNcufd1ywrVbnw8Y67K
 FMo1vAC2JKvnPxnSBsY9+/KbuUhIhcKGs2JiFjYEQkQP7U2pKI9KkpefOqhqhu52mNLQ
 pkW07kIhhqekSy9X2DLlrlEBnfdF8ZVogHy6wGf2TA/891DvdlFGvMecYgk61AkUc81Q
 RUwYTkIOqpcHil5IhtnWjTDaeVr8qDyHHR7mVLXh+C3v7vXLb+HQDqhQx0wuQrHFD8Ks
 rYyw==
X-Gm-Message-State: AOJu0YwqVHIz4zYYxhiLo/wrEPqbjpO08Sd5yCJid2oHlZtBeHkG8ZQY
 RG2qdaLX9tvreIA5eOVEMjYMdauTAVdbRyxpSJJTuFcKqNN59B2XzjYRWtpxR6aYYo6mpKBkOVI
 =
X-Gm-Gg: ASbGncsdDb5WGBaTWzwgnsf0+GfgqDRGb2mAN+/W3pPM8igIzsmLKaLGvFmTJ7U9ZTm
 uV8HckqPttNlvK92V+x0khEwBCPmfkKGl+jyn0yrjz8quViqzDp6FBGSipnW1bODOiJAwQAVj63
 d1ZdGsVl2kSNBLX0+9RBQwy/cDimW1XThNOhNC85x4O5BTu8BSSrB6IUrL64cbt2I7pW6qXmle3
 cmIMN3++sUvMfnDVrvQnCEvqEoANdo8Brh5SQzFR8n95PHvlka3/u/jGoc6Q2FgOiAVavO08B0W
 RV+Fq4Qnb1g=
X-Google-Smtp-Source: AGHT+IGj6MEdbjVCjwME+YWN2nKqiT3R3Yed2Yey0mi0Jk9Pf6NPy63vBh9sO+0UzMqniy9tP6v3ag==
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-8445b577d49mr640716939f.9.1733269683145; 
 Tue, 03 Dec 2024 15:48:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:48:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 39/41] pxe: Deal with a missing FDT in the bootflow
Date: Tue,  3 Dec 2024 16:45:57 -0700
Message-Id: <20241203234559.2938192-40-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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
---

(no changes since v1)

 boot/pxe_utils.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 053fdcbb6e7..1468a8e8498 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -605,21 +605,9 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			      hextoul(initrd_filesize, NULL));
 	}
 
-	if (!bmi.conf_fdt) {
-		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
-		    strcmp("-", label->fdt))
-			bmi.conf_fdt = env_get("fdt_addr");
-	}
-
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
-		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
-		    strcmp("-", label->fdt))
-			bmi.conf_fdt = env_get("fdtcontroladdr");
-	}
-
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
@@ -786,6 +774,28 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	if (ret)
 		return ret;
 
+	if (!conf_fdt) {
+		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+		    strcmp("-", label->fdt))
+			conf_fdt = env_get("fdt_addr");
+	}
+
+	if (!conf_fdt) {
+		ulong kernel_addr_r;
+		void *buf;
+
+		kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
+		buf = map_sysmem(kernel_addr_r, 0);
+		if (genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
+			if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+			    strcmp("-", label->fdt))
+				conf_fdt = env_get("fdtcontroladdr");
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

