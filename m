Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B3C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B76E83015;
	Tue, 15 Jul 2025 08:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dSVCuwsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CBC82F6F; Tue, 15 Jul 2025 04:53:26 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1432E8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74b50c71b0aso2827170b3a.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752548002; x=1753152802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0l/jxr2i2rFSFIpq7lCrqQL3L1+hbrSbOf+AhDY3aY=;
 b=dSVCuwsxUsi7spw4OGPiGWKX6eVNWIL4Q9ZgWxO19WjQAdMxRAiTHsGg7tQvnQMhIK
 RjkZEhayASxGo/Q3DosXgIO86O5Canq6ZBewRz5oUcgsjYo1mu/qG4VWxigLUWB1JLhb
 DiV97IJNZrmBcc1gBgu7RxFBJIVqVCMBx9rHAhAHmH/av26LOMiB9XfI82QJ3cw1CKAg
 hH3gHNazACxoKEyH8J1m8NmtspkLP2uV7i53NPFlYMsIuVjCICc3/l+35nHPbYRwQpK7
 4N/f9UQZt5M0bLO/9fk1pu3fZIveRyRaz9DiOYx7RBMVmzKOunNi2RT/1fhygj9LUn5J
 CsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752548002; x=1753152802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0l/jxr2i2rFSFIpq7lCrqQL3L1+hbrSbOf+AhDY3aY=;
 b=A4VZw49M3/M61sKk59R+MjbOVreJepEBPdZ6oPNpg+RdFTn/rjrErXWfw6pDXXVT69
 hM9o/ilTsgR+FZoXCCFBRvt1NTxDjPlvrOix807A/3rdi2C4/kAjKaVAst55vsFIONrj
 orknwwSsq4J6eX7kjP4Kcw3D8mC0EmirrrQLwxsjZm74j5wHTlcJr8K9pl2AYrzw/qfg
 fPRLEPrjiB1BKKKTvwzKFH7XChkSS+9JNO0e9wI8BAJ7bcpXT9k0YrOYEaUX37BT3jRz
 VkwmjE/XVpDQmtbgSfx8GvYj4I5qZsCP2HZdoBQP/7bQEyNhp7DAmuNiunwxf82yzNoy
 3XqA==
X-Gm-Message-State: AOJu0Ywh2FZcoTWEn3TZvLcp8yGQGCadIooKjoh4Ma0TRCTvVu3wuS/6
 /hA9KS6FoCPQbOtvs1XXYYAf4EJ1YN/ZV6bPsQrx5fCC0qfTqYdp6USbepuB0w==
X-Gm-Gg: ASbGncutImEjB8/VfdGAGkoAhwpR/hLocu6m46vXx18DrDDXcwARED4aM0Y6b4dWTP1
 Herhy36ARTh/RxXbfbYxJWCXeW7acWNJL2m5kLyXmSt/UecBuOidrivzAoQuBDd9k316exI+7ak
 W566SDd93DwbUz6Pt7uJZMmz1U0/3peMlAWsqxfs8GemRjC5Ljq9bnXjFdGLGN3WQ1PQu05y+TE
 zs9TaE/A/1ZNYtAuOF+M6C4TsyDLsWuOQb5I/tqVxZZNRy4wo42P903zhEbKgkLDoZwO9EBW6+f
 KekrC7E+KUgthhSe7k/Vb+PmVOOQ1kVqtG0+JVPYqH6OWV4/XYEdaMMtTBl6/fJyOlj0R4Jtb69
 WyTQADocDZxxVJYUmRdp1JVItVskX4dotvRQ5XJiYhfIP9tGVkORB41pNW4GpgPcn2rJRlJHXSQ
 ==
X-Google-Smtp-Source: AGHT+IFto7S3aut3usFDm9lMlQ40nMcD5I6Ic32rmKDClb0/Tf1qnaHwbj/iQncNnxH/6/R3L0P4Iw==
X-Received: by 2002:a05:6a21:998d:b0:233:d85e:a69b with SMTP id
 adf61e73a8af0-233d85ea9c6mr11936113637.39.1752548002105; 
 Mon, 14 Jul 2025 19:53:22 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4ca28sm11777889b3a.134.2025.07.14.19.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 19:53:21 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ravi@prevas.dk, sjg@chromium.org,
 jan.kiszka@siemens.com, baocheng.su@siemens.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/3] arm: k3-am65-iot2050: Fix invalid default
 configuration reference
Date: Tue, 15 Jul 2025 02:52:53 +0000
Message-ID: <20250715025307.2013-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715025307.2013-1-aristo.chen@canonical.com>
References: <20250715025307.2013-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

mkimage introduced a validation step to ensure that the 'default'
property under the /configurations node in a FIT image refers to a
valid subnode. This exposed an issue in the
k3-am65-iot2050-boot-image.dtsi, where the 'default' property was set to
"ti/k3-am6528-iot2050-basic" and "ti/k3-am6528-iot2050-basic-pg2", which
do not correspond to actual configuration node names.

This patch updates both /configurations nodes to reference the correct
subnode.

Without this fix, mkimage will fail with an error:
"ERROR: Default configuration 'ti/k3-am6528-iot2050-basic' not found
under /configurations"

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index f49d6f262f2..b3d64485249 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -208,7 +208,7 @@
 			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic", "ti/k3-am6548-iot2050-advanced";
 
 			configurations {
-				default = "ti/k3-am6528-iot2050-basic";
+				default = "config-1";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
@@ -265,7 +265,7 @@
 			};
 
 			configurations {
-				default = "ti/k3-am6528-iot2050-basic-pg2";
+				default = "config-1";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
-- 
2.43.0

