Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015DAC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440EA8352F;
	Sat, 24 May 2025 07:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HH4C+EnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DA38353A; Sat, 24 May 2025 07:42:53 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBDD8352B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-445b11306abso2412775e9.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748065369; x=1748670169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xMb/dcKivu440beT5AI0JjdwZMaEPJsKM6ELE/cyD4g=;
 b=HH4C+EnBZbXVMjPJVIkk22elqgvHt205Fop2ozJU9rdxOl2dFbYeZWJ5RRRjb+2IiL
 7B0resMwl4UUyelhm59Jc9u0XwkQJnltQR+a7Nh+b29HMbBDMQK1eNkRNxdhhQPLJUsI
 /I0gSPWUqCBcpukP7ENcQDSLI8nSBgMGtMTVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748065369; x=1748670169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xMb/dcKivu440beT5AI0JjdwZMaEPJsKM6ELE/cyD4g=;
 b=pF3nlnc8FRx5Pv6q3z3O0gLBQLmkbKdzhAheJpn03G10petqavlkGelYR3HCJ6JmOZ
 a/7R6dEMuVkEyPpqOm2W4C1cA3ntSNj1bnDEn713qb/Vz5gulxy0nv5UFjuSvTuPLSC8
 rVP5M9hqkffBlqBrT8TShDSjTR6pN8DT0PwSR0aHoqfyxrHe9Mrk8CvmtYhDZbidslFI
 Wmk7Gt0v5HfmBYuW1+wdWUtf+DPcxETfbTs+2cDS4q+3Ow9RPy5yR5IOLfwNMDoFHte1
 aR4FzXDoWder6MCwIKFoTBDGrHSbQz3DhnI9m4kUot5JOPiYdmIp+CDhNl4038Vqvxjh
 F6RQ==
X-Gm-Message-State: AOJu0YyEGFv7EElvM2+Rsl4tKKhBJSuqcTWcNHmU8zRLIF8oiKr/eU+3
 9zzx0tDEKzuQkf9oV18dDoY0IKwif0eqw+hG1Ykv4I6tMOxCNTpCb9PZSeZgz6WOXQ/sta2U7dk
 6z4lIsKL9Y8s=
X-Gm-Gg: ASbGncstSkeqMS5IyLmY8MrJs31XtYWDr+Lpd60I0ogVaVv6vwvd9SA+d2U7hcDRzGL
 ErTRxZMAi//vGY+3ErIpnHUIOdgX1ytUfQ7uS7CNtRDoN8QMtXRaE56c7fT+bm1FLTvtWK1NEnl
 i6Dyfhrq+ozehGzRKikdNO0AKDmHLbUUyHFoZTlfUaedQCtmYY1hBXCc2MuQjC4xwmiNe86K7Ls
 tQghMEH+nSX2Ojoi9pHh4A8x0HDU2CQ09O8IQkTqUYUP6pLVl3Q/rV/D671S4JRrQEdMhXyffmX
 6Uh+yNB1BsXim+d5HOaoNuE/rL/UUwDh3DDR+OPlCGSKOLraxA0emQczb4+dfKINOaZHhPc=
X-Google-Smtp-Source: AGHT+IGfB/F1RdY1HeOBgK1J+8NzIoqNzjNb5cLZzobJeNW8qRV0Faoy/youiH0k0YWSsbtI1U5aXQ==
X-Received: by 2002:a05:600c:6808:b0:44a:b793:98cf with SMTP id
 5b1f17b1804b1-44c9493e35dmr11754315e9.26.1748065369520; 
 Fri, 23 May 2025 22:42:49 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7bae847sm161457615e9.36.2025.05.23.22.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 22:42:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] bootstd: Use -c flag with bootdev order
Date: Sat, 24 May 2025 06:42:45 +0100
Message-Id: <20250524054245.409399-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Update this command to use a -c flag rather than a special 'clear'
argument.

Link: https://patchwork.ozlabs.org/project/uboot/patch/20250501133726.2627373-16-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
---

 cmd/bootdev.c             |  4 ++--
 doc/usage/cmd/bootdev.rst | 10 +++++-----
 test/boot/bootdev.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index f05a865f609..8ed2c96e50a 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -148,7 +148,7 @@ static int do_bootdev_order(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret)
 		return ret;
 	if (argc == 2) {
-		if (!strncmp(argv[1], "clear", strlen(argv[1]))) {
+		if (!strcmp(argv[1], "-c")) {
 			bootdev_set_order(NULL);
 
 			return 0;
@@ -176,7 +176,7 @@ static int do_bootdev_order(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_LONGHELP(bootdev,
 	"list [-p]         - list all available bootdevs (-p to probe)\n"
 	"bootdev hunt [-l|<spec>]  - use hunt drivers to find bootdevs\n"
-	"bootdev order [clear] | [<spec>,...]  - view or update bootdev order\n"
+	"bootdev order [-c] | [<spec>,...]  - view or update bootdev order\n"
 	"bootdev select <bd>       - select a bootdev by name | label | seq\n"
 	"bootdev info [-p]         - show information about a bootdev (-p to probe)");
 
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index abede194cba..76e56c26f21 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -13,7 +13,7 @@ Synopsis
 
     bootdev list [-p]        - list all available bootdevs (-p to probe)
     bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
-    bootdev order [clear] | [<spec> ...]  - view or update bootdev order
+    bootdev order [-c] | [<spec> ...]  - view or update bootdev order
     bootdev select <bm>      - select a bootdev by name
     bootdev info [-p]        - show information about a bootdev
 
@@ -85,11 +85,11 @@ bootdev order
 This allows the bootdev order to be examined or set. With no argument the
 current ordering is shown, one item per line.
 
-The argument can either be 'clear' or a space-separated list of labels. Each
-label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence
-number ("3") or a media uclass ("mmc") with an optional sequence number (mmc2).
+The argument is a space-separated list of labels. Each label can be the name of
+a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence number ("3") or a media
+uclass ("mmc") with an optional sequence number (mmc2).
 
-Use `bootdev order clear` to clear any ordering and use the default.
+Use `bootdev order -c` to clear any ordering and use the default.
 
 By default, the ordering is defined by the `boot_targets` environment variable
 or, failing that, the bootstd node in the devicetree ("bootdev-order" property).
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 84280caf7b5..ff3da505d85 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -793,7 +793,7 @@ static int bootdev_test_cmd_order(struct unit_test_state *uts)
 	ut_assert_nextline("mmc1");
 	ut_assert_console_end();
 
-	ut_assertok(run_command("bootdev order clear", 0));
+	ut_assertok(run_command("bootdev order -c", 0));
 	ut_assertok(run_command("bootdev order", 0));
 	ut_assert_nextline("No ordering");
 	ut_assert_console_end();
-- 
2.34.1

base-commit: d0792b0848712a84b5fe20ba60f699b48def807e
branch: schc3
