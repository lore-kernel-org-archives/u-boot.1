Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE773C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 00:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7CD871CE;
	Tue, 14 Nov 2023 01:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="blV2p26S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC6C804CE; Tue, 14 Nov 2023 01:50:01 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F168718D
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so3486532f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699922989; x=1700527789;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQ1k/IHJzz14EdN3CGhergpoa2zZtMlrpREehiY7h+c=;
 b=blV2p26SevggIEA+yzJ/k1nN68mpGc2rgvDsrXbDC0WYZlTbDrANy4D2TqylB68l1s
 99L/LILGvaPomtgLESS+vU2QyoxYzmhNkRHq3kxkj2+YvbUe/5JyMfFpG20CVtGMEfmy
 qc4unchRG29/XYkjP/6cPFSWNpcA7yhoSF7Ryvf/7HndqcZr9pSHM291qGWWGLGbCR0y
 FiVJ85/h90V/4/yG+eA4czHb7zPpYCSWnxOdPiLtlfyGsNWqf7MgJh1RfI6elG3lETET
 Rit6lnwQUyYCCGA288H2LSrjoaxLkEzulv3e2PooxpwKXysvRn0SL8djobRAsup36O0l
 7YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699922989; x=1700527789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQ1k/IHJzz14EdN3CGhergpoa2zZtMlrpREehiY7h+c=;
 b=fPsgde4p0oO5hjaQgmHPn1iUYIzH5vftQCk960GTF90FhAFDzMR6Vq5BnfUS5iIUct
 Dbv6Kf8Mx6uBGoBHE5QjQNgO9eTwbQOytdPXTctHbtCTHmTq3xnTzYZR2MZZ25T1pfH7
 P/fmIPmx8OGY+GINeghCAFW/nKAg5MvlOQkPy1XK3GnChWKFT2LXmY8bLcjjzKy88mje
 19a2hZIQsxjcDr92obFZCExXkonk5u0HUErqm5hQj4u+vVWz81mOjsxDmovU57fOYGPU
 Y+wKra9J0eQVfX1c95S51NbkeyCqT2+oPMabKrYOmDf8ksdB6GjF4ZnlozGfCwC5LqoX
 MiRA==
X-Gm-Message-State: AOJu0Yyzax+5uPVhBJ/1wiq8pdphPtYgmq0+aiIC5J2SSgUQ8GJZTNhj
 G7b8IP1adWkCLTgKpoxRyYtPDROnQc64NtuzKr5N8V6r
X-Google-Smtp-Source: AGHT+IEJHFZwuQ4zpVheyqgzPxCzkr7cAnYyFZRK79GI9xcxyrc+qvpQzqStOrkgzV+WcKnZidZGgA==
X-Received: by 2002:adf:f348:0:b0:32f:ad68:7474 with SMTP id
 e8-20020adff348000000b0032fad687474mr5722343wrp.20.1699922989310; 
 Mon, 13 Nov 2023 16:49:49 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0032d2f09d991sm6402675wrm.33.2023.11.13.16.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 16:49:49 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	trini@konsulko.com,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH v1 3/3] bootflow: bootmeth_efi: Handle fdt not available.
Date: Tue, 14 Nov 2023 00:48:26 +0000
Message-Id: <20231114004826.815833-4-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114004826.815833-1-i@shantur.com>
References: <20231114004826.815833-1-i@shantur.com>
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

While booting with efi, if fdt isn't available externally,
just use the built-in one.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 10 +++++++++-
 include/bootflow.h  |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index a65d8ff582..c1e15b83a3 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -312,6 +312,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		 */
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	return 0;
@@ -381,6 +382,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		bflow->fdt_addr = fdt_addr;
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	bflow->state = BOOTFLOWST_READY;
@@ -442,7 +444,13 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	 * At some point we can add a real interface to bootefi so we can call
 	 * this directly. For now, go through the CLI, like distro boot.
 	 */
-	snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
+		log_debug("Booting with built-in fdt\n");
+		snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
+	} else {
+		snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	}
+
 	if (run_command(cmd, 0))
 		return log_msg_ret("run", -EINVAL);
 
diff --git a/include/bootflow.h b/include/bootflow.h
index 44d3741eac..ea6c6ffc0c 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -46,6 +46,7 @@ enum bootflow_state_t {
  */
 enum bootflow_flags_t {
 	BOOTFLOWF_USE_PRIOR_FDT	= 1 << 0,
+	BOOTFLOWF_USE_BUILTIN_FDT	= 1 << 1,
 };
 
 /**
-- 
2.40.1

