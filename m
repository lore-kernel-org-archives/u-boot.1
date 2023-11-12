Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B578587282;
	Sun, 12 Nov 2023 21:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X3G6QK25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A4087469; Sun, 12 Nov 2023 21:03:17 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C195870E6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-357cf6725acso15345255ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819388; x=1700424188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBcGrqi0lFVvkCKoimhFBdU+SWrai0etZMu07Mg63i8=;
 b=X3G6QK25tGHFeuXwbl71FciqNiCaypwDT068Lh351sOyFx0dyaQBonGxhjNDWPYw9P
 HRoYhcc8MnaGbgbrTY7254UmoUgAiSne6MPAs88RBa0/Dvi9EdOTQK6J6iGa5gQAtF8T
 +wqKxXXs0mIgx7ApmPWyVCttww69Mb/OHgeKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819388; x=1700424188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBcGrqi0lFVvkCKoimhFBdU+SWrai0etZMu07Mg63i8=;
 b=Sd8NgXb1sqks6L7sTCE+8h9du458Awo2fq8jCp2EqTPa4Hv9EBf/rt8fCwBihm8n+U
 NTIPA39D8YrBabAo9tsPD47Kxg+I449Q2QbVaKYnVM+J8OkFC4Yw0K7+5Gld4CZSqhT7
 34F1dUj5kZoKJP3yy33GFh9OVADN8qd7zYY+XExJfR6Z8LhIq1bBbY1JVvU4LJzxLp8A
 1jpgKRfG35upjr/3ygntQIah7qeb6R6zP+erxqN94linyz6sqSK7IFEdQBNF/zjrM48B
 usLcVo7WWklj2pcASWDE4HdnmSgikv0WfQUkbMsxbX/Kw938XXn6t8JteF4T0QRT/K9M
 oYpQ==
X-Gm-Message-State: AOJu0YyMnPtGupFcVrzX3OwQ5yieWd3Wo1MAoy0cHww2FJK7SxT1LZSA
 DxVWQDxiLJHhrxA4PYaIa2NodLMSZVdfxtnWltza+w==
X-Google-Smtp-Source: AGHT+IFDfbQgUy28bbu0Xt4K1I4WbD5jeNcI33hwBJT+4W4nr0Bpl0u56y6J7PSe/A3g4eMIxDs0gw==
X-Received: by 2002:a92:c54e:0:b0:359:6c09:a3cb with SMTP id
 a14-20020a92c54e000000b003596c09a3cbmr7159736ilj.26.1699819387881; 
 Sun, 12 Nov 2023 12:03:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 10/12] x86: coreboot: Enable truetype fonts
Date: Sun, 12 Nov 2023 13:02:47 -0700
Message-ID: <20231112200255.172351-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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

Truetype fonts look better in the menu, so enable them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to enable truetype fonts in coreboot

 arch/x86/dts/coreboot.dts    | 10 ++++++++++
 configs/coreboot64_defconfig |  1 +
 configs/coreboot_defconfig   |  1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index 0eb31cae42c1..83beb82f37c7 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -45,4 +45,14 @@
 		bootph-some-ram;
 		compatible = "coreboot-fb";
 	};
+
+	bootstd {
+		compatible = "u-boot,boot-std";
+
+		theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+		};
+	};
 };
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 92cca6e6aaef..42b46ba0d9b9 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -61,6 +61,7 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 3762cde6f3a6..7d744e9962ae 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -55,6 +55,7 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.42.0.869.gea05f2083d-goog

