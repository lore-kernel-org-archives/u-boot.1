Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC730E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B23D8070F;
	Mon,  6 Jan 2025 15:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RnQrO/7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C48380703; Mon,  6 Jan 2025 15:34:06 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F2D80704
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84a1ce51187so272775439f.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174042; x=1736778842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnciy6up9L/D8YFyzNkFKgEmIkgeLNBm4qM5KYWt9H8=;
 b=RnQrO/7NlGqPCb+Hd1hYSqTTKfyVdA43FD9cPtys1IBc6nYx+MTkmroapFq1B5C5lU
 i6EouNx7ES05KfTsabEcYWNxDxgFvlNI2ml7T9DWwckBl7nn5w0jz6z6afjltOPEESlT
 COdi/kP3KUZJxFGNfmse6Cvwk84Cr3TDJ8TVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174042; x=1736778842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnciy6up9L/D8YFyzNkFKgEmIkgeLNBm4qM5KYWt9H8=;
 b=Wk05YGspelvqraTaIMUks0iOkry0y6vIJxdiV3D8y4rp4pPxFWEXyQisZ5M6fYvByH
 uk22B6AaotlSGi5pzYRj/YsLMgMtppKRFDYwXBo0nunfLxE3vnAjXAmLM6hMxRDZPFQZ
 Q5oDC+nQK/g6PBKMXUz3OHiUd2sTCYw0msiLoL1Oo9temIQgZOaNKAY3JLwqwHV8vuuA
 bp46P16rgFEDq6+FTQpX/ghSDTV0clZ1B7X18xOnTwcBwwbBGFREyo+TIyvklj9OMIKy
 CgUXeHS9A03mP6t/R0fY+jfQDLGecIX4qJ9MDcOh//YvdA0Nf8+QPPYmrCf6eq15pwPc
 EFHQ==
X-Gm-Message-State: AOJu0YwEKhgYtOHbarYFzDezCqe2+xlvrhHLwvIX63ZaqoXPP//p+zzy
 a78DTrVVdswrPY8vgKu9Yrh6p/wdo/PWkIQ0uRaGpL40nF9bwv6Vje0JscU4oc3CXXSAn2+j7cA
 =
X-Gm-Gg: ASbGncsNiobiKPfOlBYL3ZC5JD4lvJqKunAWZnbwePxASr7olphmToW0Ypk2mEvmR7z
 RZlSbow/6hz9L8rrY/a1jcO5+hnAGUzwq/jQiU0eNnmpBEakpdDsu/CmgrdvmxR5V9e87gCMiBY
 dB2cWSCiMh8hKjpJAD5HKL/R95cPKinvr9r9AFsPYxy9qO7J7DRL+d+600hOp9y5wSK6loMgLJR
 H5LBEoWEWpgqdsSIRiCaXVjFc68Afc4AKTqdnveFI5p/5J8oqqnVF9rKcPLVFUzI/jSmshidh5u
 3zlD09k1TzBTXGVM0A==
X-Google-Smtp-Source: AGHT+IFRKGF5PKBTWN9LRUw3j7oIVpZ5uOEfeCXCd1KHZUNVhqPHXAlIZEiwG20leI7+Wyj5ckytnQ==
X-Received: by 2002:a05:6e02:508:b0:3cb:f2e6:55a4 with SMTP id
 e9e14a558f8ab-3cbf2e65771mr237833165ab.0.1736174042478; 
 Mon, 06 Jan 2025 06:34:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:34:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 30/33] x86: emulation: Enable bloblist
Date: Mon,  6 Jan 2025 07:32:26 -0700
Message-Id: <20250106143229.3023771-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to enable bloblist on x86

 configs/qemu-x86_64_defconfig | 2 ++
 configs/qemu-x86_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2771a4b9e19..792ba06c2b8 100644
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
@@ -33,6 +34,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 947d15cd727..82b6a9e14a3 100644
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
@@ -23,6 +24,7 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.34.1

