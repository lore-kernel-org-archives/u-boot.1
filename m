Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327EAC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE1981ECD;
	Mon, 31 Mar 2025 14:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o6O/sIHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7416A81ED8; Mon, 31 Mar 2025 14:23:49 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D098129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so40488695e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423827; x=1744028627; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y5HnO3ARwXycwrnN5wj9aHaMHyZouMgqtvcsy/Rw0dM=;
 b=o6O/sIHz2f2ei9viHBdK1TE9tohO1yi207F/lT0U5u/XnWr1SHPbre5oBgelFwDdLx
 uYlfN1UX4mzpgUekT70EonvVnfCVciFQIGw9OgjaRmK0to6ttoIweiT4Ibn0vmwPjO6s
 Kee8PEaVLS/UV1ptB8X7WG61l45neQt8hOBr9fkIE8NFdPAJpsbS1DvmamZXuQUAmNqr
 6RdEBgXqs+5FDBIINmkAJfka5v8UVH4Y3rquyKBpLmQG4Sx4EjmlnR0b1aYhD6nziFCg
 uOTDRSlhROTSHIg3269Cu2Dy7AkVsrQY3ZrI3Nd8lDtjUcWewwPVghTluOUgnugTugl9
 dDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423827; x=1744028627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5HnO3ARwXycwrnN5wj9aHaMHyZouMgqtvcsy/Rw0dM=;
 b=XihxhLo2gxKUrBRQ5+Zs/u/dDleaIqzawfN2BQV3eLm2JUftKtenpuoPSa/Dxrhf8Q
 aCWCWMI5h0C/W6CFDVqExPTt86HGwpcEPSbDW41WGbL3VKyr7eA2xyiqLp4ggpNhtvOG
 hrx2DG4gwvKQPuPfz8sZs7mcrXl7YboMNeH/5PVYSKKgUOeHajLEQz/y3RoFsZQ93r6I
 ChrKvsGMQVFJi23Qh2sYgulH5DpuesPuLJcpeULa08/ka9PQ8BNEdsR0ZFzgjrIKzr+n
 GoI6WdZD7yr8Tclj1Q/xVV4ogpsDkPuhBOInmpcuSvvnstdmUIWYhrX2Max8tKgA6fiR
 a+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ybOzTyhvecPVuxZbtH9Ex2IorQoz3i93LANa9rTAh81bF6kPNC7fn+VLh3OglecQXPa/R1s=@lists.denx.de
X-Gm-Message-State: AOJu0YxEHwdJTDELyvw+aXu4zXrbY+wS+LIODOLNtp8Lncpj5tlRVoXq
 j8OVc/CTKxvBrmMOA+2dXI453atzZJ1+oQHSEwl4368kSDrmP4LgRxD5QtOCUvk=
X-Gm-Gg: ASbGncv7ZsrRQSZc3eZSCxjnn76LWWpRJTqReRl/+zkc8InghafWNUVrXdozwyWcLL8
 ghMIVEruXoTiUdHD5uASMiro38VoJjChcuuT31xruVL7ZEPLLzLgfjmZc9R+I8iDeGlKLCsuv/A
 zupA1VIQXLPRB1X1lvWo5OYrmLkNxLuavNwQ4/cL5gLCmwqS+zzu2WGGDhVQVt6owuT51c35xP7
 jhr+lSx9BUSLZR6qC6+lP99eP08Caqx17JQTtN2nkIsnhP3f9bSYG3Fjo0YB0JLP4oUx4xuxMdI
 QwsrxROSU28IlPQC4sTTyk1rkopkx6BZxrxWHcSk/3zN45KdlOL4bTvH88JIqKukEKjd3cvQTI4
 e18bkUjXdesgL
X-Google-Smtp-Source: AGHT+IHCoTevegH+FgqNRosUHDa0AEDoedxl6KQiS3VwTskAzngDNYUFhTbTUPNnihZNyu5IsGXXJA==
X-Received: by 2002:a05:600c:46d1:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43db624aed9mr77516975e9.18.1743423826816; 
 Mon, 31 Mar 2025 05:23:46 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:19 +0200
Subject: [PATCH v4 2/6] cli_hush: support running bootcmd on boot retry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-2-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Kg+TGtcWBIAVSrHbJr7RKzreMrTNFioGuDeGTnelsAE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olNNTzE1n0ekiTG6UWirWVxZ7JmgxXP+16dB
 2bRN+0SdFOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTQAKCRAFgzErGV9k
 tkf6EACe+57VWAiCerp/qAT3gSAy3AKnpVzI04wmo7EW421sDtGpbh7baR4dcwAZGj1AOODNccY
 19ztJh+5f3zTv95yqip1Fbi1luacmHd5k4JxgPIkq69jj0bzb6fhU38ea9aE3GGgKUb/QV7Lgyc
 EJ8iD8ve5rfum29o+n/DbIHCW1/6iWYxtUotYXVKmTx4zlYtHVSXgq9HYmj1QFY9/ojYwnWYhJ/
 uXR4NpfQWs+eYjo8NtIpFIQCnbzoIqoJ5IKSc1y4SikfQNNyrjaXX6kttL0hWZL+ydgusDkQv8Z
 0Zn3/N1qeAtg19MqxbNBzgqCs2K7w9kIV+luKOVE7ZuJcw1mYP+U0ssW21ABS4NTglMlljbsLRJ
 2/aYaco8udcVFC5ioUG3Ptb7ltlrSSJr1yX4VPgbkjZTCpxa18huV4KpDsQmfLsScpAVzIx+Sb3
 WsKQRZXvoZBw5v3jSupDKK608xPefzPmdXmydb63vcaUQcAmMsj+5KrSPVRC6GfMA19qLepSPM6
 R2d5PPGXJKbIZrSiyHczoivJqenQCpLO3dVTXgHOVoKbJ3xFltroUkMWKbnAOe/VIx18vZa6eGr
 y2WNPE+EJb5C8er8YMlwWDClWKzCMGeIKM86LyIZmJAd+leAsx6j3ajdZf6Cyl4Xp+IrJyhxZtd
 8GC2vL0EPlSYoaQ==
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

Introduce a new config option: RETRY_BOOTCMD. When enabled this causes
hush shell to re-run "bootcmd" when the auto-boot counter times out.

Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/Kconfig               | 7 +++++++
 common/cli_hush.c          | 6 ++++--
 common/cli_hush_upstream.c | 6 ++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c09a98c3233ceb1c68024a193d7dafdce6b83903..4db13dcb9a51940c358f754d9ff91e88bebd96b1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1711,8 +1711,15 @@ config RESET_TO_RETRY
 	help
 	  After the countdown timed out, the board will be reset to restart
 	  again.
 
+config RETRY_BOOTCMD
+	bool "Run bootcmd on retry"
+	depends on BOOT_RETRY && HUSH_PARSER && !RESET_TO_RETRY
+	help
+	  If this option is enabled, the "bootcmd" will be run after the
+	  countdown times out.
+
 endmenu
 
 menu "Image support"
 
diff --git a/common/cli_hush.c b/common/cli_hush.c
index 9f437ae5f475e2f33041485e88d72c9bb71ab309..7bd6943d3ed65bb24c709af0b195825a26d65f39 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1027,10 +1027,12 @@ static void get_user_input(struct in_str *i)
 	if (n == -2) {
 	  puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
-#  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+#  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
+	strcpy(console_buffer, "run bootcmd\n");
+# else
+#	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
 	}
 #endif
 	if (n == -1 ) {
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index ab5aa5f9b36a91e09f8fcfcbb8b31afa0892e6bc..748ef60ac90b8af8052631c7ad3a6aed2629140b 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -2906,10 +2906,12 @@ static void get_user_input(struct in_str *i)
 	if (n == -2) {
 		puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 		do_reset(NULL, 0, 0, NULL);
-#  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+#  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
+	strcpy(console_buffer, "run bootcmd\n");
+# else
+#	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
 	}
 # endif
 	if (n == -1 ) {

-- 
2.49.0

