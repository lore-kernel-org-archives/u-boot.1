Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B69C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 941C2810DB;
	Wed, 14 Oct 2026 20:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWRIodJPqPzl; Wed, 14 Oct 2026 20:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6A2481128
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008242;
	b=NEbWBHUu6J66iGqVE+K8vIjsdhRbJmJB8+Rm040BbmdSuECVIpVsC1UPYZWWbKPhCb3Z
	 /lO2os1SlOKid/30YalvEOAASdAP5tkZ0YxYgh0Q8+XpQUfOeLOlzIoWiYGaXwmXRTv4f
	 MQYmJ/3cZkGPQFK7ShHYKsNGYe/2TUCTuvNnnM8l1hLg/1N6d2kpEP7dxwOaImjiHeeFz
	 UO2CAmHJWvbDh7MlNT8xKgi7uAKHHf6SBhW0/ccBwS1xb/eGYc+fXAkMEKpz537p3fcLc
	 TlIbKbTTr75D/dffcOd6+i+hfxr+9vIL9Lx35qPYa+VMV2KdP0TZMFHoFyl5YSjRPoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XTbw9IIFJH6OFq35ExnXHEouz67qCqCW6k7X+C3XcEs=;
	b=Sv8omTrZ2amHDmV/aBtN1UBeYIX97eXIgx019MNNWWzVF1cMt8en3a7odFDqH7xeAQm3
	 vcSgDoC1h0jB5Q3kV+2CXzvOLk029fkrLw19KigwcV1CGZYIxoI0lkrTIUu2wDXIbOWyX
	 WL1CGZtPZ7ssuPExJ6RTerrDIwONYh5MNL/C8SYJLG93UvpLI19Kkzq7m+z/L3bQPaGmW
	 xq7Ll9WUwe/+ZqQRhl6v9rg49BbUUDb2XhT+phznlHSCt3mZg0BAZtRcowD8m8Jyt24Lu
	 yDaVJf/XlKSQTT1aU2qZBdTL3qXRRN2W9VA2g0FP4wTXJfjGIZfSoVMhSX00FC8la6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008242;
	bh=XTbw9IIFJH6OFq35ExnXHEouz67qCqCW6k7X+C3XcEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rGPigpyWuVIjUZIyE1ARMrdWCEiMe9mclaST1mQwWy5NGvw+AtnwEAJhZVomDZ/M5
	 nY5Gh3ihXE8U2fQ1+NZOEdnHHjUrZSxe8RXL9dpi3/vxWQS+JK0luaEgwXQZ9+/jun
	 1SOkah7CcQ9IR2UQlfH30pAKjO7XS6TSsUSvYS3Cu1KaRAvbnUeu/mEel/bIdHI+IC
	 6qJqj4vjla5j05oB42CazMr4DMjKQHBgwqbqbg1Lx6aPqyvmBwxWCK42iYuo3s/oWT
	 Jdk/gAVfAiiTw5LNgD0BS9iQZBOMOWfb0QQvy6wkz6ojUL0XVL3Ys9/qy6EkIRxm2U
	 E4o76cW6mcRdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A2481128;
	Wed, 14 Oct 2026 20:04:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E160769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BE73407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAlTiK8aOQPU for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 136BF407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002228;
 b=hVu3q2fSNnT7GwbD7w1dWkMhu2cuotXBX/GomKNO2ohT4rYf0yQOzh2q6X8zPipqdxLm
 NBgomRjtA5LiGwy3L0vBLy32epPOlSv+Ga6aKqPefzgUyl29WgWDhys3s9ZeX8g5yrHA2
 JDLQSLKH95VaYHCKVDFuQEXFhO/ZMuXitzj7pUGvOCi3s3CR3yUD8hQRbzURpfZQrQsR9
 /IL8mENBo4M9RRsz+VRyKGHtERUR0Qa1Tjy2RCESVjRgNSJvw7Vhiotuucc0T+wUW7ipW
 pOJiWkb9tzwNtymj94mu4ynIAeJc0LWy1LaEbRHre2CJDzz0i9HsOqMTKTf3ikIwjEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002228;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XTbw9IIFJH6OFq35ExnXHEouz67qCqCW6k7X+C3XcEs=;
 b=pZenpeJugLKCmcSM8thYy4ntIS8yKeCyTGHAR94bIHtmm659trgqvyyJeuhaOHC55GEL
 VtblZBHmN1me+yQrPao1QOqorSgyDdDorygANzstt+vyPORV0HTCcd0b/9PyFgoU+9Ubm
 pT3cxe9n7FvOv4diJhQW/5nLZvJWKRjgzJSNyoh3UKariJv1R7lEH/S1Wn7QzIQ1k20iV
 d6kFLkMc0IA1joSoTrttX/DBWwcuLOOC0kMY5pr1sF6aTo3aQ/gKYljl52g/BjJ/ZPBEz
 PcB9GSOeuWdHAsESEHfG+3EPDZfJ8uLMx7zNTOrMkuTROrC43dtjeIJ3rGc0G9Nnamg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=RCgYFbBj; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=RCgYFbBj
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 136BF407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07454153B;
 Wed, 14 Oct 2026 11:23:44 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04AF03F871;
 Wed, 14 Oct 2026 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002227; bh=3QY1IBf/2ROVEhvqYj+IqRmDm4xknj3jBmZtaRNT/ls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RCgYFbBj3onWA3jCKtFLlOQ/eNmd2MSGiNN3txvrFIfbWJ1f3kWUsf673OHeszyVm
 XZyIHwN+EldNUm1GvNGo/ISoQ9lEV0s0FNHfRS3x9PR9J7jCpY0UAdfR1G6W90IN15
 xDyP/9lVZHVuIlALXGVp+F/g4LT5aSiH+tGILFzY=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 22/22] doc: bootefi: note two-phase runtime variables
 selftest
Date: Wed, 14 Oct 2026 19:23:02 +0100
Message-ID: <f532c4c9f5eca886745418f02d8ec778f332f886.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
Changelog:
===============

v3:

Simon:

- Clarify the volatile-store runtime-variable test flow
- Note that the split-phase tests only run when selected through
  efi_selftest

v2:

Simon:

- Update the doc to match the v2 new efi selftest flow
- Document single-run behavior for volatile-store builds
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
2.43.0

