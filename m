Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524F8FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9AAE8466E;
	Tue, 28 Apr 2026 12:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="XcbV3pDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943768466E; Tue, 28 Apr 2026 12:26:17 +0200 (CEST)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C2D845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4c6H25ptzLc1;
 Tue, 28 Apr 2026 12:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777371975;
 bh=v0wxM8i0x9Pm8ivg5bRMHQfqkXErgWa7h6vhAAazAw4=;
 h=From:Date:Subject:To:Cc:From;
 b=XcbV3pDBv5PXK50unUvC9sWfoAJNA1xW5CEpi0VQ65+ke+Uq7TcaiF3TFWpnxHPi/
 W9ZPocT2wwZHZ9Vqq2aUACGdG5GrqjnQSRTvGkD3m6vUZyBGbGzr1/sN0ytJqzHM7o
 WfwtH/zsbLZm43sOqAlDhPKnvw2R/UM+XFlOmhNUg0PcLkwSE2O5Mh3gT/fZIa0Q05
 cNMaf5rZRY8ZdoL1kUftysxTUHVVp+ybdTWep3kgZkG6kl52MRkGugSW55j+kU/8Vy
 hcsh16vhVJ3wcpmZx9wxOgLZUToDlwPMLXumZnIs8ALttV5JFgxcsMxAEAVvc6N2zE
 JTRps5iAJNbzQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4c6G2FXPzDFb; Tue, 28 Apr 2026 12:26:14 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Apr 2026 12:26:08 +0200
Subject: [PATCH] doc: usage: cmd: reset: specify when the -edl option is
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTNJOymm8SqGRW0HHROpdsBAC
 Hen6vIt/t9AuQgrnJsNCn9EJY8Vtm0g3sN4Y5RUDWToZBx5TDmirlpYecJ3zE8cukQ2BO+sI6j
 dq/Agy+956f/W+frgOH1HsO8HrFVPRHUAAAA=
X-Change-ID: 20260428-doc-sysreset-qcom-f5d21aa84142
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 u-boot@lists.denx.de
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

Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/reset.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 366b17eea16..54767fea241 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -23,7 +23,8 @@ DDR and peripherals, on some boards also resets external PMIC.
     Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
 
 -edl
-    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms and only
+    when CONFIG_SYSRESET_QCOM_PSCI=y.
 
 Return value
 ------------

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-doc-sysreset-qcom-f5d21aa84142

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

