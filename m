Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BE4FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4B8844A5;
	Sat, 25 Apr 2026 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="W3zuT8gH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1563284359; Sat, 25 Apr 2026 19:01:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A8F52843B6
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ABE735A6;
 Fri, 24 Apr 2026 10:32:41 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252353F7B4;
 Fri, 24 Apr 2026 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051966; bh=KW8y+03SDHMpVk/Pm0i56k80CzrKINVxVtVj0oh8Tyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W3zuT8gHoIA/h9q9XrGDsLvpEq9g6k5ciCcHlTxzGl6ebh0e9lOTUCHvlEWta0m8u
 599fmNwvuFkInkxGG8Upu3xYf7Ulmn4LXzrmvFdHdeAqYcOyt6pLB7/tDHfgLvh5eY
 rmGA6bjllVGqBxvOXXKPZqLXE2w0Xxcr5S1dhuwo=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 06/12] corstone1000: enable bootefi selftest
Date: Fri, 24 Apr 2026 18:31:45 +0100
Message-Id: <20260424173151.371134-7-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Enable UEFI selftest command in Corstone-1000 defconfig

Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
so the board can run the built-in UEFI self-test suite during
development and validation.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 configs/corstone1000_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 527a679b785..b5fb4868e0f 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
 CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_LOADM=y
@@ -63,6 +65,7 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# CONFIG_CMD_POWEROFF is not set
 CONFIG_USB=y
 CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
-- 
2.34.1

