Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB53C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFC28304A;
	Tue, 15 Jul 2025 16:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GH6Bxfcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CBE82BF6; Tue, 15 Jul 2025 15:03:57 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE3482E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6525621b3a.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 06:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752584634; x=1753189434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4i5a+FhA5t6rGQBjqd2c3vX9DjjrCmChQEIUFCO8nFo=;
 b=GH6BxfcuIVbct7EgYeuJY5X9hxrdLPCDMbrHT4POboXv3teyEo0+sHAuqIUUNB8IWC
 ZtWE/nI/h27Fyf3IF6pdi7ZcYb0swhYYZa7NWohvhUJ0SCgt1VAf8Gos/Sqjjt6ODaRi
 P1+bb/WsUKm13sLSxC5t7d9vG7yAF7j5uwKvHZvMgj/+di2CGfQzXyZLfnxuKu/QZvAN
 fZ1U+c0BxT+0I41Mu3dqFhKtJ0ZWL11KEW33CgL5Zc2AQYoWUKuKi8juFPyWhixHs74E
 6t+uzh8FGm4BOJ8nsF+NANCT+fVx7XYjfYmRrKq3B5gWVIvERm5z3GBH+jP9xGhJUehu
 OXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584634; x=1753189434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4i5a+FhA5t6rGQBjqd2c3vX9DjjrCmChQEIUFCO8nFo=;
 b=Xg92/bqIQdrNHnklyegPzMpR255KerwrPQMdNNkly/jr/gyF7UmTYwWhS0SykHjxeR
 2B0C041d2AS5zdgqg+/XtZ67j6Zg4W2q25VO2iW07/xAIfMSCWbOuA/aVWz2p9kzI1RN
 yQJh/hhGf+MMLlVhVXXPCq2eqROXzxsrLwbg5bcRmRd62vVZg9W0YKl5/+4kmETJMEfE
 wR4ijdZQ0fn0TMQCskmGFjwGUco/r9wq7IXiRbA00QnCNQw5YTy5UNxlc2pKQFhAY8SV
 6gmfuoTR3OKMup5N+sp2bIsJ0tvcRQV3B5B35E5q03w4nVeh1iyXZ4rfmAA185MnICAo
 l0TQ==
X-Gm-Message-State: AOJu0Yzv7NtmzwVgHT68056+SvxETaC+mbIv6I9me95XnGD9NwsleXFK
 vH+P424LRM4XlelWW8YfwRlwFJUMclMcUN6kQcEkfn1ofLYEjnsC/9CFSOC9kA==
X-Gm-Gg: ASbGncu1uu6jElCzZdKnFlZtM5ogHpXqHMIwCeLWyuHlIZyd8M6D4v9Wpifdq1JOsuI
 K//KOmp3JULy0qUmGehWgvXPPioP/ShPd0ydJiGDCmNDY4R4ZlQ+Zgf+zYyxS/TaRHRyhuNN3+K
 JQwzksgNfifuua5qnk/IOetvxnbYRLhKfA4BZEUoXO8VSSl6FicUhqNRDx62YlW33d1Vj+b5S1d
 LyP4MMFnVXHjGJuKUjSyGtz59iQt030ncc0wVsnnLPMugt5J5Etxs/c9v8pReOiPc5CvE9r+3pd
 CGFDWI2DaY6KYt9lyQDM9mxnfnVeidtOaObFKUkKI9uznMujH0ElyV0ux2a+U/Tjnk8Ja9A2ToN
 VOH+7n5XFonrsi6CfDgU3n64GZe8B8BJcvLvm+T/lJ4f/T5GYkSmFY7zbAkH1enj8qgAM4ZE=
X-Google-Smtp-Source: AGHT+IGTqBMNBUWYi74IA3qRjT/xPWtcFyD9VjxHjtVCRuTFCDgqqtSptlktja6g4mfNiPfhMlamDA==
X-Received: by 2002:a05:6a00:140a:b0:748:2ac2:f8c3 with SMTP id
 d2e1a72fcca58-74ee3629f19mr30613621b3a.24.1752584633474; 
 Tue, 15 Jul 2025 06:03:53 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5fc9sm12392356b3a.2.2025.07.15.06.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 06:03:53 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jan.kiszka@siemens.com, baocheng.su@siemens.com,
 sjg@chromium.org, ravi@prevas.dk, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 2/3] tools: fit_image: validate existence of default
 configuration node
Date: Tue, 15 Jul 2025 13:03:06 +0000
Message-ID: <20250715130317.3886-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715130317.3886-1-aristo.chen@canonical.com>
References: <20250715130317.3886-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 16:47:06 +0200
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

When a FIT image declares a default configuration via the
'configurations/default' property, it must reference a valid subnode
under the /configurations node. If the named default does not exist,
U-Boot will fail to boot the image when no explicit configuration is
provided.

This patch adds a validation step in mkimage to check that the
referenced default configuration node is present. If not, mkimage will
print an error and abort.

This helps catch malformed or outdated ITS files early at build time
instead of deferring failure to runtime.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 8717dc9a3b1..8a1f6c185dd 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -756,6 +756,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	}
 
 	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);
+	const char *default_conf =
+		(char *)fdt_getprop(fdt, confs, FIT_DEFAULT_PROP, NULL);
 	static const char * const props[] = { FIT_KERNEL_PROP,
 					      FIT_RAMDISK_PROP,
 					      FIT_FDT_PROP,
@@ -764,6 +766,14 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 					      FIT_FIRMWARE_PROP,
 					      FIT_SCRIPT_PROP};
 
+	if (default_conf && fdt_subnode_offset(fdt, confs, default_conf) < 0) {
+		fprintf(stderr,
+			"Error: Default configuration '%s' not found under /configurations\n",
+			default_conf);
+		ret = FDT_ERR_NOTFOUND;
+		goto err_munmap;
+	}
+
 	fdt_for_each_subnode(node, fdt, confs) {
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
 
-- 
2.43.0

