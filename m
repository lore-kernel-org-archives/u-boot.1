Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E946C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F26884866;
	Sat, 27 Jun 2026 19:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="G4SRT2KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FADC841C2; Sat, 27 Jun 2026 16:44:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 993EB8056B
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621201F60;
 Sat, 27 Jun 2026 07:44:42 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.95.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018FD3F905;
 Sat, 27 Jun 2026 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782571486; bh=lK+AOWiEhwrBIpiZhv21sxP3xzADWn3aFZvhibgKN/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G4SRT2KWxx84/zFpj6cqEI8PQINu2whtNbwnn69UZh3vMlENfl19Pg/CLSRtj9MJv
 oTsYz0wvZlu0kUzWBjEmsIj2UvSvUPwG+XOYCmRzxNQqTrgcXB6XYwcWm14HNNlP8x
 k39IzOfrFYo257dIahOvmSjWQBF19yXO/tbPKHDs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v3 06/10] corstone1000: enable bootefi selftest
Date: Sat, 27 Jun 2026 15:44:17 +0100
Message-Id: <20260627144421.2067410-7-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Jun 2026 19:41:26 +0200
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

Enable `CMD_BOOTEFI_SELFTEST` in `corstone1000_defconfig` so the later
runtime-variable selftest patch in this series can be exercised on
Corstone-1000.

Keep `CMD_BOOTEFI_HELLO` and `CMD_POWEROFF` explicitly disabled.
Enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
`CMD_BOOTEFI_HELLO` default to `y` and pull in `CMD_POWEROFF` on this
PSCI-based defconfig. The intent here is to enable the selftest command
without broadening the rest of the board command set.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 configs/corstone1000_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 876b915b6a4..e16b13043ac 100644
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
@@ -62,6 +64,7 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# CONFIG_CMD_POWEROFF is not set
 CONFIG_USB=y
 CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
-- 
2.34.1

