Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F30DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3210B84A49;
	Thu,  2 Jul 2026 20:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="bl6HG6b2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29D384A27; Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29964849F3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljq4V2gzxj3;
 Thu,  2 Jul 2026 20:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016863;
 bh=bh5Ds9hRKofWFsXHqPww2yVnibsIrOK5Ft4Hw9itExI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bl6HG6b2NvZdReSBAwSpe7qtl4LAcBEZ2hyNkAIiB6TQ66WdLUzDlwJdEnOiz/f8I
 wkYPTaZOWPpkLRxXjUK/Pd9r51O7nEz0xtMCcfmpIi4SZ7yqmlYWGl715ui8reZxuB
 EtdSIyHjJbgzu2qMyJi7rQlTFzhJiSebD0CvEPs0TH8H5Fq1ZpaQCaKeCKcEnd1DNQ
 qTBhWUmA8ppbsOKCLcXOd8q0ZHZg1kqeKznH8ROZY/ymr87tF+UZMLsYhXDp9xOCOS
 oB2BTTlWTk4yDiIRm/j53+kyclBPT4C7HptdJETm9tQFDmmnzV1UJQmG7z6VvSA5T0
 ewV3YaFDZ69EQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljp4BddzvSj; Thu,  2 Jul 2026 20:27:42 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 02 Jul 2026 20:27:32 +0200
Subject: [PATCH 2/6] Revert "cmd: boot: fix edl being shown when not supported"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-revert-sysreset-v1-2-7920c16a1f3a@cherry.de>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
In-Reply-To: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This reverts commit 1076feb8a3f96e2def81485f852e9c1a451cedf4.

The args support for the sysreset uclass contains a logic bug. The first
sysreset device implementing the request_arg callback will consume the
args, not support the specified arg and thus return -EPROTONOSUPPORT
which will stop the iteration over all sysreset devices.

This is an issue if one has multiple sysreset devices and each with
support for different (valid) args. If a sysreset device implements a
-dummy argument and another -foo and one calls reset -dummy on the
U-Boot CLI, it'll depend on which sysreset device will be attempted
first. If it is the one implementing -foo, it'll return it doesn't
support the argument with -EPROTONOSUPPORT in which case the device
implementing -dummy will never be attempted and instead we'll do a cold
reset which is very likely not what's expected.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/boot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 29cdf4a9a81a..d80f9d8c05dd 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,11 +60,8 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-// All options handled by sysreset drivers via their sysreset_ops.request_arg callback
 #ifdef CONFIG_SYSRESET_QCOM_PSCI
 	"reset -edl - Boot to Emergency DownLoad mode\n"
-#endif
 #endif
 	"reset -w - warm reset if implemented"
 );

-- 
2.55.0

