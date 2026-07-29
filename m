Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11899C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA56260B07;
	Wed, 29 Jul 2026 12:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HU3FPy0N4WPB; Wed, 29 Jul 2026 12:28:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0849260B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328126;
	bh=1bvi9KEx/XjxNoeuABozwFgAaySNJnb8+1ufx14Fh2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mw9S5Y7uZUxSZJa+iyn160WXdOp3v/uFxe0mytM9aCBQxH2Uist1DSIB8BHlr8DD1
	 uCRz9Sqyt3Ns3Akad7ribdJgAlUpkHkFuZ2nj+EaV3SySyJaHQU9lfjzCUKRSDeTmU
	 7YoC+xWRWJuNkUOr3U/mH+kDatgus/iz9e/BSFuXzCxUO9RxX6SF/o0j6tZgRdERj5
	 DWpp5GgvYOVj6Fn0Iyao7OQ6u3w6cYfQUnGqge5VK50Fp2kqbp67DgtwCJPqKIc5sy
	 yl9XB/HFIi6FSdHcLLfi294OXFpRSo5sDV8Ul5whPEbCkUnvz9uy/LNBLl4ssWPrcB
	 3ISrAapYiq5fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0849260B11;
	Wed, 29 Jul 2026 12:28:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70C394BF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62EF580FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymW16JTsDd4v for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 048B780F78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 048B780F78
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 048B780F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5568493F; Wed, 29 Jul 2026 10:52:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 70BE48404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:16 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4EE169E;
 Wed, 29 Jul 2026 01:52:11 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1CE3F66F;
 Wed, 29 Jul 2026 01:52:14 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 18/22] corstone1000: enable bootefi selftest
Date: Wed, 29 Jul 2026 09:51:20 +0100
Message-Id: <20260729085124.2618817-19-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315135; bh=De9fC9rbzgBdSR3J02hOdPXvY4ufCVRkrUTT+Emk1GU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QdsHwm0ZMy8E6eBI4IesUwaHsQ8/1IXi4WbWBCxQcHIi2Ap1QaJBt7KbQ9Nqw/nwi
 nguUYTQ1kqWDHeMolal6U0Ggx+khNzjrP8EyMaf305K2wNU25ucXKkbwArYoJEPPoC
 7u+YIYayhTg/oLwXS3IjyA01579SZnVwRdlZnkAE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=QdsHwm0Z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="QdsHwm0Z"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable `CMD_BOOTEFI_SELFTEST` in `corstone1000_defconfig` so the later
runtime-variable selftest patch in this series can be exercised on
Corstone-1000.

Keep `CMD_BOOTEFI_HELLO` and `CMD_POWEROFF` explicitly disabled.
Enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
`CMD_BOOTEFI_HELLO` default to `y` and pull in `CMD_POWEROFF` on this
PSCI-based defconfig. The intent here is to enable the selftest command
without broadening the rest of the board command set.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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

