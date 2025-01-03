Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC8E77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 07:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA1E803F6;
	Fri,  3 Jan 2025 08:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QbwDWS2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C06E803CA; Fri,  3 Jan 2025 08:46:57 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8488036E
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 08:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2161eb94cceso117077415ad.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 23:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735890412; x=1736495212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LB2la2vYpWOfeuj3rt4IFwZbV/qFffpJduUkAFtVXNA=;
 b=QbwDWS2AP7kUCyynfNIwj4mT8A2OahnBBHbmXAlhyc6Ol1IHB/c4Rn8NMggAfZrcuK
 Vc4TZ/j3isWOIf57JAkGIMP1AWh3oo9lXeWgXBpw82vdePRGd4aJfptZawwGM0SLsRLk
 hriF1hs2LaANEyae1bL7TFt8KfZZxkFKmcGy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735890412; x=1736495212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LB2la2vYpWOfeuj3rt4IFwZbV/qFffpJduUkAFtVXNA=;
 b=Wzn3tbahabup4DZdr0yow+Jt4ulj/FpqPFYAuH7FT++w/wQZjB2GhWQZD0B5F/6PNk
 zQT6iNrXX8Ia9TVIvID2BSDg2LXZjBxXjp5sicovrWY6a5Kabuzp7wusaMB3K+WcvXSj
 UfO29Lwb4N04tcbIeFKRlKSUP8bpSSGz92bbUiEva/Z0X9coEo6GyUX6sf7PxLMGKapI
 a5UaSgReOicja0tyAmnfwWC1B3U9979OavHSDcK305gG4RPQZrKLZyBP+wPuupic2YaB
 DfZu8dU8hduSittmHxJEkLXnG/C2rSQj2O941tZitnZQWG1CqhuIsce/NiGN4YxT0yN9
 C0EA==
X-Gm-Message-State: AOJu0YymzPhGr4+YcTtOqvEKif4r/vxv1m6WwWVBMTyj9v24IpU/kPsy
 k5sxrnELbsEL7z81A2koXogFKi4v1Enfx4Mw0mT7cjeFtblSdR+4j3kQgvLR/74pe4T4fTAcJTo
 =
X-Gm-Gg: ASbGncvvV8nyxOasuwfE4kVL2wpaaoMJVhByA3U/oLOdSC0w4m7hWlrRD1ZWV+TN2dy
 VE0/9rBHZzdntiv88ZTeJjO9EKKQ9zRXvxEEPFEeaQn/RAowJwhYNEOPWq7Cj89658i5klK+Xqz
 HjgD+hDEzD52HUWr9++sh+eJis16IaceTBR4Ko3I4KJqt+LSvraAi8selQjjmW4lmOzHHQMwnzI
 agcmM7bvAlPLgOk8vXucSJ5STkjbkZyjXTpQovgoxcNTDpekmYbgJ2325ncwgKRsK/JEHSceD2O
 rCSfOQ0=
X-Google-Smtp-Source: AGHT+IH9oCFXqmycGIyRDl/vL4HVv/WeJCOW/cZZqX5W6LtdadELjyP5dlePwFkhO43o3Q5KKuHmGA==
X-Received: by 2002:a05:6a20:8403:b0:1e5:ddac:1ed7 with SMTP id
 adf61e73a8af0-1e5e046f87fmr74693396637.12.1735890412521; 
 Thu, 02 Jan 2025 23:46:52 -0800 (PST)
Received: from chromium.org (219-89-85-241.adsl.xtra.co.nz. [219.89.85.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9e3fsm19869376a12.73.2025.01.02.23.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 23:46:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] x86: emulation: Enable bloblist
Date: Fri,  3 Jan 2025 20:46:09 +1300
Message-ID: <20250103074638.2348387-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103074638.2348387-1-sjg@chromium.org>
References: <20250103074638.2348387-1-sjg@chromium.org>
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

Add bloblist support so that tables can be generated and placed in a
bloblist, then passed to a payload using UPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/qemu-x86_64_defconfig | 2 ++
 configs/qemu-x86_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 003af54498b..495072eceb0 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -36,6 +37,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 5183117854c..e3b96e873ab 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xFFF00000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -25,6 +26,7 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.43.0

