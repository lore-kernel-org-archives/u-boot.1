Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC403C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1874987985;
	Thu,  4 Jan 2024 16:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OAsZBPjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C66879AA; Thu,  4 Jan 2024 16:11:05 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FCE8796B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7b913830d8eso26543039f.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381050; x=1704985850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dc2ZrolK1NEttM8KoWKpC2Lw4llvoZ31nUaWghODIh0=;
 b=OAsZBPjMljfKb5/PttrK7IRac6GTOUbRQcX7MTe8fnTBkY1O7RvvdEJ87RRy3IQreo
 GmdmWnyRvfshAX+ABEhVGaH7bbHw6wVLnBuMb+a1B73myJ9WChBhu6P7aJLCudA1NqAB
 qL8SzQzRPopmcPKD9XjbhJrUrjnsVjLfjWG+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381050; x=1704985850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dc2ZrolK1NEttM8KoWKpC2Lw4llvoZ31nUaWghODIh0=;
 b=lKX8+3iy3yoUuH3SRBZ6wzk8LaUvqmm0py7M0NMrEac+5dYadukD91s92SOdDh8+gP
 eJclkCoul1DKAzIMnYUJlEpn2FyP66WH6AaPBltkPkGSD/i9HdUjxuXMifRYKfHSWjiY
 ca3OUEunf4BuXSBGVQMLmDXSkq0mQdFhyZQ58TUYGtzBFhvDKz9UWpO40XtzcPV0jn8G
 CY6YZ0J5K7Tig+EASlgDo7kc7SPa83vR5W/9Vis2FVKy7O+NYd4lDgpPznDQuXnAdxiZ
 2q93RWVz2csQZzUna1P6MW8GrGf2pMsgELpAlR6mpyZCU1n4kGctVYhS9lHHZPQ+hwH+
 b/6A==
X-Gm-Message-State: AOJu0Yw/L9Ki5Z3J4YfKtzuPQlcWnjOPX0+AzpYDnIZJLPv0WwC/IwyQ
 jHhq8nSplfMCXmnMTIbHnl9xkSMdH9TR5lQm5QzJwBndpVZn
X-Google-Smtp-Source: AGHT+IGG7C0biZ0vtwedq9bcny5bf+1BdO8zW6ye2suh+lzMfUw2ZSSjz5vHHyVx1QxSxB6pv5HVVw==
X-Received: by 2002:a05:6602:4f91:b0:7b7:fb7f:85cd with SMTP id
 gr17-20020a0566024f9100b007b7fb7f85cdmr839867iob.24.1704381050596; 
 Thu, 04 Jan 2024 07:10:50 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v6 5/7] x86: coreboot: Enable truetype fonts
Date: Thu,  4 Jan 2024 08:10:40 -0700
Message-Id: <20240104151042.695717-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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
index dfce7c2d591..b867468e16c 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -46,6 +46,16 @@
 		compatible = "coreboot-fb";
 	};
 
+	bootstd {
+		compatible = "u-boot,boot-std";
+
+		theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+		};
+	};
+
 	sysinfo {
 		compatible = "coreboot,sysinfo";
 	};
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index ace3b63dfd4..8f80e0271f7 100644
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
index 3762cde6f3a..7d744e9962a 100644
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
2.34.1

