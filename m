Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D371FFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B0284439;
	Sat, 25 Apr 2026 20:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YG+H4q/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039E3843FB; Sat, 25 Apr 2026 19:01:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2CB2840AB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F6735AC;
 Fri, 24 Apr 2026 10:32:50 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D733F7B4;
 Fri, 24 Apr 2026 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051976; bh=7RpMKcsa9jFFBBqt0mirMpE9CEsSslFHO9vkZezUhps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YG+H4q/dX0Kt7iGvPU1R3rprUEe7ObjBWNhaiORnAmUTHvaxhYD8o0cIy54J7HK47
 LeuCF0BgU+Iv3uVrwSyKaQBghvTYj1vaMpHedlyA1MeaRgVwXBkxMlz2HBtV6FhWIS
 3ozioKqlD2WI2h9pfMn0Cdy399WjDNFFPzNgKxPM=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 11/12] doc: bootefi: note two-phase runtime variables selftest
Date: Fri, 24 Apr 2026 18:31:50 +0100
Message-Id: <20260424173151.371134-12-harsimransingh.tungal@arm.com>
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

Explain how the runtime variable selftest runs in two phases

Document that the "variables at runtime" selftest runs in two
phases when CONFIG_EFI_RT_VOLATILE_STORE is not enabled, and
show how to select it with efi_selftest.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 doc/usage/cmd/bootefi.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7c5448586b7..91aebf1a4b5 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -160,6 +160,16 @@ environment variable to match one of the listed identifiers
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
 return to the command line but require a board reset.
 
+The test *variables at runtime* runs in two phases when
+CONFIG_EFI_RT_VOLATILE_STORE is not enabled. Run it once to create a
+runtime-accessible variable in non-volatile storage, reboot, then run it
+again to validate, append, and delete that variable.
+
+::
+
+    => setenv efi_selftest 'variables at runtime'
+    => bootefi selftest
+
 Configuration
 -------------
 
@@ -167,6 +177,8 @@ To use the *bootefi* command you must specify CONFIG_CMD_BOOTEFI=y.
 The *bootefi bootmgr* sub-command requries CMD_BOOTEFI_BOOTMGR=y.
 The *bootefi hello* sub-command requries CMD_BOOTEFI_HELLO=y.
 The *bootefi selftest* sub-command depends on CMD_BOOTEFI_SELFTEST=y.
+The *variables at runtime* selftest runs in two phases when
+CONFIG\_EFI\_RT\_VOLATILE\_STORE is not enabled.
 
 See also
 --------
-- 
2.34.1

