Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA29C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0AC87500;
	Sun, 19 Nov 2023 20:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BDmYQZQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30059874EB; Sun, 19 Nov 2023 20:12:37 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3AE5874DE
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3594c100735so9046475ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421139; x=1701025939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxsyUasUZT+8/+j7tJuVbzbesvWjvE1Lqg7KegDz8kg=;
 b=BDmYQZQv6/GxICC0/iPzfc8WO7RjCdk6boLH3pBU+04tR2NWlth+g8rnUG0D5ELdxh
 xLpfLzli0QkJK6Rhw9IeAz/bgFe5F2SQ1oqco10+9OnOUSuFrb0OV5ehDrq/wXzEd4f8
 TnpcwMkUKVCPfa49F66JfXIJlgx4v/9C9xilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421139; x=1701025939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxsyUasUZT+8/+j7tJuVbzbesvWjvE1Lqg7KegDz8kg=;
 b=RXywJyyHIFe2Z2rRRjgT0ZQUOc8IYgxwrQqNSwooSdnbx1t3NUbxEodOgUk3wu+cyx
 /NIU47ts3h0IA83ITR41O5o3Hxj9pynuUHjFUR8356q0UtB22OjPdYi3XRxHNPfDlrAS
 Lblfn4QBfHTeoKrvzW1s5CfskvT5Lp9jMbDLVvVFTpPk72w6GqPvvA8q0XqzWtwvgrt0
 o7yDmSSgd0Ll32WbmcQNDocHFs7LfJITWm/N2XAWfZjBI+jnJiDuNoc6oJmck3Qtly1e
 hUdpNlv924KTii5C4vuswbZtFP4FvMOUKGoShXF1/dzlV6HDpUX7teR5yKGJZT3W2jkc
 cVRA==
X-Gm-Message-State: AOJu0YwE21yeWLOp9NY19mHt0VwkJxpspJ8QUPmTdrCNjskSjbjUaT8k
 U1PzKGMXP3ePbdwi3+++0U8eK9ZsIlXrG6UF37PSTg==
X-Google-Smtp-Source: AGHT+IF1Iu1Ox4UtH5fY9U4HeOGQQLf1iAZVSt9kxoqlcIEEfECMD+Ts61f6kCFUpHcaU0HBS2WwrQ==
X-Received: by 2002:a05:6e02:1291:b0:359:3491:9042 with SMTP id
 y17-20020a056e02129100b0035934919042mr10452194ilq.9.1700421138970; 
 Sun, 19 Nov 2023 11:12:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 10/12] x86: coreboot: Enable truetype fonts
Date: Sun, 19 Nov 2023 12:11:45 -0700
Message-ID: <20231119191202.667180-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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
2.43.0.rc0.421.g78406f8d94-goog

