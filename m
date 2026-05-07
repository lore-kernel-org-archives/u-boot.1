Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92586CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B55784ADD;
	Thu,  7 May 2026 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="PRUUKR9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFCA84A7B; Thu,  7 May 2026 17:04:32 +0200 (CEST)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::42a8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946AD84AFA
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gBFs62LlFzVmS;
 Thu,  7 May 2026 17:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778166266;
 bh=eqG1KISiAVy8HRuWNDtiAAwxoWVgs3mbc7WNrG8Uujs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PRUUKR9F44bUQFvFBeM4JpEwdZAQNf2jetSGkXVG980WmX200vyj8CjZyfqQ2lf/m
 X23lIuWcBNUKpNhzBZxKh8VqFGJY2JEfm7bj1vzeMUKWxCzk6v2itV4eOf8bHbMrtE
 EHzLzUcRHwTcHm5pV05jk/wGZdJZcnAUP1nw0J+kBQCBEd3ksaXVPqyhA9rHzkR/EP
 +z9vHm/bXXTUzny+ZVKNFX8Mho6pHauXEx2w62lFxpakWouiEe3pObEZZ1PBJlL0iJ
 lyA9WO1pxfhAuP3/qp5o8KyJUfML5BCrusD2h0KV8sXHPGa0mxVYPh6cYgLxsx8ndr
 JsdSv++jzkzpA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gBFs54StjzXDl; Thu,  7 May 2026 17:04:25 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 17:04:07 +0200
Subject: [PATCH v2 3/3] doc: usage: cmd: reset: specify when the -edl
 option is available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-doc-sysreset-qcom-v2-3-37fef7a9cf92@cherry.de>
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
so let's make that explicit in the boot cmd documentation.

Due to the implementation in drivers/sysreset/sysreset-uclass.c
do_reset() function, all options to the reset command are passed to all
sysreset drivers' sysreset_ops.request_arg callback (including -w) which
is only available when CONFIG_SYSRESET_CMD_RESET_ARGS=y. -w, however,
works also without this option.

Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/reset.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 88261293924..79bc8b9deca 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -11,7 +11,9 @@ Synopsis
 
 ::
 
-    reset [-w]
+    reset
+    reset -w
+    reset -edl
 
 Description
 -----------
@@ -22,8 +24,12 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
+All other options require CONFIG_SYSRESET_CMD_RESET_ARGS=y.
+
 -edl
-    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms. Unsupported
+    platforms will print an error message but the command will successfully
+    return (having done nothing). Requires CONFIG_SYSRESET_QCOM_PSCI=y.
 
 Return value
 ------------

-- 
2.54.0

