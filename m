Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8399D6D25F
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7BC89840;
	Thu, 28 Nov 2024 04:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UgbLv+lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9305D8983F; Thu, 28 Nov 2024 04:48:13 +0100 (CET)
Received: from mail-m17237.xmail.ntesmail.com (mail-m17237.xmail.ntesmail.com
 [45.195.17.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14398956D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 04:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4109ad64;
 Thu, 28 Nov 2024 11:48:05 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
Date: Thu, 28 Nov 2024 11:47:58 +0800
Message-Id: <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hMGFZKS0JOSk9MTkIeHUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9370e2169303afkunm4109ad64
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Mjo6FjIoFSwxASoIFEow
 GBMaFFZVSlVKTEhJTE1OTUNNSEpKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk5KNwY+
DKIM-Signature: a=rsa-sha256;
 b=UgbLv+ljdAIvKv1ZzkL9AL72KzVk27b1+sNQFddcEMPO4YZu/AlIRSYFEwb3XcOl+Wp33hCnTOOoVChpTrcKwO6Jo/tRNdfi2V4kUZQFifG00Fg3RI+cAHD4fOfl3P5RJHXAJ3xPwnJ9iqDgpKH3cvYVYhVQR0wEsijdTokUWaE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=8RG3dRia0TlrkmqtfF2KwPcX41uxALdDNbpoXAZzZZw=;
 h=date:mime-version:subject:message-id:from;
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

The efi_stub is useing DEBUG_UART interface by default, Enable it.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 configs/efi-x86_payload32_defconfig | 1 +
 configs/efi-x86_payload64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 071ddb8e36d..f0b9acc358d 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_PAYLOAD=y
+CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_FIT=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 71612d7fb19..b02a861e59c 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_PAYLOAD=y
+CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_STUB_64BIT=y
-- 
2.25.1

