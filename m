Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A5AC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B58F87522;
	Sat, 18 Nov 2023 23:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="DKfEJL8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427D98751C; Sat, 18 Nov 2023 23:07:56 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF16874A3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso3416195e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700345270; x=1700950070;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjQlq0hDxLvK0eUCIjR+aM8R6W9xtcFJbLPYBWzvJ+E=;
 b=DKfEJL8kpeP8+ZErU0Q/VEatyb4kl08TPycCysVjF+Zb41WtNO0dHbjikfX9Lrvx4r
 wnZzvmz6munKllLofEuYioWqkEo9TI0Vj1mOtE6sRqP0bMsRdukVs3BQPHqCydMUf4Bc
 e8hmv4kwG63UZ0QseeSFgkFRUYzwbB/BGW+syQGfyQPmZyPDseHbtNxKOhD3RQgc0hAz
 xxpD67d8tS01Cmos/cP3QVR5dxFrr6dhYsQ3MwHXn0S0qOFdhbnnb2ORtdL9SBkZHqvI
 Wy/zCx2NTqwmZ0RFymfekafx5kPSyTOf/IqQS9i6KfLVsZ8CGJt+YrDYGMek2eX1vJRy
 SvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700345270; x=1700950070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjQlq0hDxLvK0eUCIjR+aM8R6W9xtcFJbLPYBWzvJ+E=;
 b=vvRqf4Q2LEdhbozo/8t+ns+ogoubbh/tz64jzvr3Vea/ufDnB/LIjL9yKmVsSBiCcp
 f8ibZ1W/9vY960JUweCPrnzI/X99dEsZcZdVez7y9ZyGPFCTbJCjioBM3lWo3iVUyN+r
 407VEHYwzKB499C8g1Grlx/e6hhmF8ZwImsM2hUdZ9hytwkiGcsgZciwjVwZZTKLgqtX
 7RITUn4JydUUuiuFyHKPhxiqpTm6tOEIt/f3ltlkmfVQVm04+yQYB0Xi9YdXvv58x5dg
 OCuFam0aGuDGxd0yV8ZLmrrDgZWzmV6+xy4y9X+E+/qOFSqnfQ/AvWM3iZmiX/ldLb2m
 +5JQ==
X-Gm-Message-State: AOJu0YzNXxolILMrzUB5gTbY4q+g9t/PdYxuicJisd3jlyQ7Dpr/+lqG
 icMox/39ciG9ulaFHSxVLcuG0ukkAHMF3GRtDBHICb7U
X-Google-Smtp-Source: AGHT+IH15i/ZPNXvdoOQkdSvDeb5Rij1OXZDdReztC/SauLOal66ZzY843FXoVszwuDm3gmHgfAMVQ==
X-Received: by 2002:a05:600c:4fc8:b0:401:c7ec:b930 with SMTP id
 o8-20020a05600c4fc800b00401c7ecb930mr8241352wmq.10.1700345270159; 
 Sat, 18 Nov 2023 14:07:50 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b00407752bd834sm7791581wmq.1.2023.11.18.14.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 14:07:49 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 2/4] bootflow: bootmeth_efi: set bflow->fname from bootfile
 name
Date: Sat, 18 Nov 2023 22:06:32 +0000
Message-Id: <20231118220634.1271886-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118220313.1271556-1-i@shantur.com>
References: <20231118220313.1271556-1-i@shantur.com>
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

We need to set boot->fname before calling efi_set_bootdev
otherwise this crashes as bflow->fname is null.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 682cf5b23b..183daad8f1 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -323,7 +323,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	char file_addr[17], fname[256];
 	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
 	struct cmd_tbl cmdtp = {};	/* dummy */
-	const char *addr_str, *fdt_addr_str;
+	const char *addr_str, *fdt_addr_str, *bootfile_name;
 	int ret, arch, size;
 	ulong addr, fdt_addr;
 	char str[36];
@@ -360,6 +360,12 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
+    /* bootfile should be setup by dhcp*/
+    bootfile_name = env_get("bootfile");
+    if (!bootfile_name)
+        return log_msg_ret("bootfile_name", ret);
+    bflow->fname = strdup(bootfile_name);
+
 	/* do the hideous EFI hack */
 	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
 			bflow->size);
-- 
2.40.1

