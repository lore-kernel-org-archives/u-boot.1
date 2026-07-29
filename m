Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469F1C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04655813B6;
	Wed, 29 Jul 2026 12:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MKvkVw0Jikp; Wed, 29 Jul 2026 12:28:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD67981242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328130;
	bh=M48GLicSDQeqDgSZU3FH5TMU0KoF7vI/1K4C0xwkznY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQc5i+FTT3QNLtyohY1LPKsSy3jG7lgwnKVJova/yFDmm53LX3yGw5la+E5TyxG9j
	 IFrS4er0EfrHeYkHZMV2Y5bbdn03y8HXgU2TL4T2aglI0LQa44SnpSMRS6sEHQw/dQ
	 8CnimOoqXpFqWpncNi6S37fVaS99YUww2OB3qdA2OEsiXfu6o1VkLOyQDENy9PhZAA
	 mxKjj3CqB63+DoOSDkkDPb9lCFQpdzxzMvd+UtQGLVDImIG4MfFuovnN071hDmJXF8
	 KvZKU7hZTFS/Xg4K8lrG63cjndl5czse7/L91cRn28yxoUY9Zs6emYLUBv1gQcbC1g
	 0aW/S8RuPOzRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD67981242;
	Wed, 29 Jul 2026 12:28:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93F924BF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8475080F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-uMsWVYQzwU for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1FFC280FA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FFC280FA9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FFC280FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCD68494B; Wed, 29 Jul 2026 10:52:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8C6268498B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:23 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C98CC169C;
 Wed, 29 Jul 2026 01:52:18 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8FD3F66F;
 Wed, 29 Jul 2026 01:52:21 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 22/22] doc: bootefi: note two-phase runtime variables
 selftest
Date: Wed, 29 Jul 2026 09:51:24 +0100
Message-Id: <20260729085124.2618817-23-harsimransingh.tungal@arm.com>
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
 t=1785315142; bh=DPaYO77GmWfUXJD/Y9BExqflCGi9dc3be56e0rggDMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lTHXK8UZQYq0VVTZHPCX5nfhPSZggJVXT0yoBlZElS+CvbupzsUzGqoredyVDfj0q
 0YX8udIrslCVXguKbI5muqBu+dgWm4QG5NPKtERM8EelVvRmdSFj8Ev9TITxUx3Fj6
 sXTdBBewwcgUqSgV/hcC3UBe+Rj5hlOT+eRtjXs4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=lTHXK8UZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="lTHXK8UZ"; 
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

The bootefi documentation did not describe how to run the
runtime-variable selftest, so users had no guidance on its reboot
requirements or on which flow applies to their configuration.

Document the runtime-variable selftest flow in bootefi.rst. Describe
the non-volatile path, note the single-run
CONFIG_EFI_RT_VOLATILE_STORE=y case, and show how to select the
runtime-variable selftest with efi_selftest.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 doc/usage/cmd/bootefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7c5448586b7..0a7800b93ce 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -160,6 +160,37 @@ environment variable to match one of the listed identifiers
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
 return to the command line but require a board reset.
 
+When CONFIG_EFI_RT_VOLATILE_STORE is enabled, the test
+*variables at runtime* completes within one *bootefi selftest* run, so
+it does not depend on preserving state across multiple runs. It still
+executes ExitBootServices(), so a board reset is required afterwards
+before returning to the command line.
+
+::
+
+    => setenv efi_selftest 'variables at runtime'
+    => bootefi selftest
+
+When CONFIG_EFI_RT_VOLATILE_STORE is not enabled, the runtime-variable
+flow is split into *variables at runtime setup* and
+*variables at runtime verify*. Run the setup test once to create the
+runtime-accessible variable in non-volatile storage, reboot, then run
+the verify test to validate, append, and delete that variable.
+Both phases are on-request tests, so they only run when selected by
+``efi_selftest``.
+
+::
+
+    => setenv efi_selftest 'variables at runtime setup'
+    => bootefi selftest
+
+After reboot:
+
+::
+
+    => setenv efi_selftest 'variables at runtime verify'
+    => bootefi selftest
+
 Configuration
 -------------
 
-- 
2.34.1

