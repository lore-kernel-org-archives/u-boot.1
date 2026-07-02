Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F3C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A6784A5B;
	Thu,  2 Jul 2026 20:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="FYrtZ9Ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F8B849C5; Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C935884119
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljr2F0XzKDL;
 Thu,  2 Jul 2026 20:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016864;
 bh=N9WT+xV5Qz4rZBMxqLl/mtnuIF6otxiAVSHC1rRHkDk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FYrtZ9ApIYd632TteB/DmXsvHybJBJvy3ZmSh4DtwnYsCGR6w+QVkAR3zAcbPXhjn
 7sjrOco41sEc+c2c5LmJVZbQg30uWv9QszoSa/xeJpNgNpGLP/rtz82rY4MJ0D9e5o
 Dx/kfQJQ1sOr7/w/gIDLkd//X9GPEITqfpcZWJg5iW8plPEThtphtJ5IcaT3PFiQou
 zqojNjA4VoXhf8Drd3yzIJGBK/xefoOBRVrMyGmK19jvyoWtaJ6GmUjQbA3UUHDzVi
 /4bCDDbPdE88QVlPs46FzwNA42R6KFLpbDsCi2GwesxcZljbGs/swNX2cK+ODlYnnQ
 s1NknuWmpAy/Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljq2cPjzxnC; Thu,  2 Jul 2026 20:27:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 02 Jul 2026 20:27:33 +0200
Subject: [PATCH 3/6] Revert "doc: usage: cmd: reset: specify when the -edl
 option is available"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-revert-sysreset-v1-3-7920c16a1f3a@cherry.de>
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

This reverts commit e49c84f7bb7b69a9736e8243665b30b46075ab55.

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
 doc/usage/cmd/reset.rst | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 79bc8b9deca5..88261293924f 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -11,9 +11,7 @@ Synopsis
 
 ::
 
-    reset
-    reset -w
-    reset -edl
+    reset [-w]
 
 Description
 -----------
@@ -24,12 +22,8 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
-All other options require CONFIG_SYSRESET_CMD_RESET_ARGS=y.
-
 -edl
-    Boot to Emergency DownLoad mode on supported Qualcomm platforms. Unsupported
-    platforms will print an error message but the command will successfully
-    return (having done nothing). Requires CONFIG_SYSRESET_QCOM_PSCI=y.
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
 
 Return value
 ------------

-- 
2.55.0

