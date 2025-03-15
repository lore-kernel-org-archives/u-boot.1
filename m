Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130FAC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0797780ECC;
	Sat, 15 Mar 2025 15:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DL+BUCIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7002C81428; Sat, 15 Mar 2025 15:27:23 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B59811B2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4289725e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048840; x=1742653640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=DL+BUCIo9ZPmYb2ZfL1JdEohS6y78fZC2WyG9+bbiYoS8ZV3a4//Wtf46N0NZDh0wo
 YupJJhLKsVgaqmW/EtTTO42jFs28Z8r33XuO1NQak3xS72s2opNVJ3w+V8WuuMJTYO2m
 R1GGZ41qhvhY8hpoGkPzHNi9cwyRoz65sCrxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048840; x=1742653640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=ZpRwwJo3qWIO8Wdy5TqiLoNQfevkMRAxtU5tYp77VW531+p8KZGI7TpPVslkEXy4SV
 34fJqxlmPHYECHH/C98NZuROML0Kev8hqI+2T2M1l6NqkkOz6UeAsGn5uLQDMOr4AI0t
 B4NyOVCPQvIaH2RVLNccgT4c58H5IsU6B9Xt2YAKHhAL3/dQB+kmGzoq1G5b8Q9d0p6j
 gMHHbMa3I9MBCq+h9yJvjJntdXpneTunbQUiV1OlnhlDuF9b6noGrzRoaDVZk3kHOyzc
 CzDDMkupBCV2rhOQ4RhwOMWOwe15fme4qgkYjtlH5zKCtjZ+QLzu+urosjspwi70lUzD
 764w==
X-Gm-Message-State: AOJu0Yx24gX9kR6KaDP80ZFPtmPxmlckofaREMT8DVM+R5lkawJO0XaQ
 sI0Q3W7Aog7agd8HRv8oDcuFWNcy+YLHjueA4260YpoZCxYubCJYaYRdqq9WTAw5zQNe51AT5hD
 xoA==
X-Gm-Gg: ASbGnctoN8GcmY3z/fQ6Ju/XC5TXhomdF1f90fL9DUdbJFlTwC8cnTqfqHU3HqT+lwq
 zjAoErVkZP9E3YPPfgthDeNrkqE6RQIVdMTkV0iZvxiIz5TmjbaE2WDr9ZAR19OYe1HOX8y1t2y
 2sX20UxLSKYaY5mj5NtqjOcfVbe0VZHIAXGcg0xYvUqxZAN6WjR7N/oEJwdGwafe1qwCJsjZ+tJ
 TJC+DCuYlkQhJI/94RgIXH3lSyaCzb1RA/CljcFurEC+leCdHSrOwnCTxR05hTkSlLD1eEd6gO8
 DGpAKm1fzV5pa+xqng4pMA6PQXligIrz3ncoqqib6e+AuuvBIF/6
X-Google-Smtp-Source: AGHT+IH/HdP6BEy1WTT5a2X08eIirw3HQmbDV3BPB+Jy3jjVkY3LBdM6hR0iTikuybrv4UsVaxCdHQ==
X-Received: by 2002:a05:600c:41d3:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-43d20e467c7mr64663245e9.19.1742048840180; 
 Sat, 15 Mar 2025 07:27:20 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 05/46] x86: qemu: Enable dhrystone
Date: Sat, 15 Mar 2025 14:25:25 +0000
Message-ID: <20250315142643.2600605-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

