Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F07BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F7E849A3;
	Thu,  2 Jul 2026 20:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="YTP64L29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE4B84A4F; Thu,  2 Jul 2026 20:27:48 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CC884A04
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljs0hSZzyWh;
 Thu,  2 Jul 2026 20:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016864;
 bh=GIc+fqQi9HlfR/FVc48RcWXds723+kbiAXpSwsL7tRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YTP64L291AzlQ9Ej9J/eHMYS9Gydmql/yw+Oc3WAkDgjRR1GJb4FpQAtapAJRQNim
 1ngztRSV6BnvUrx71QiaFZArnbF11icaX+w7nO1mrCC0Rufg+02iTQVuNFeL62DQ4d
 qyGuZCFqVRN35NlcDbwaokvVm5jQHfVGRJUChVaTfVyJ2/Z1QcZPlmlOyINUccRQgQ
 q+tr+8T2HqPvAG9wfqIipd+brtLOHMB1JDxcXbYy+PCatmceUJo4gnsRK0H5HEjL9j
 uWpVRNRuy7R9BpKfLXIkOLQE0d1dP3kHXVshMVZnpI7c1hygy56EHLlO+0Phz/iw/J
 oYbHLXm9nRdQA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljr0kCRzxdY; Thu,  2 Jul 2026 20:27:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 02 Jul 2026 20:27:34 +0200
Subject: [PATCH 4/6] Revert "cmd: boot: Add '-edl' option to reset command
 documentation"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-revert-sysreset-v1-4-7920c16a1f3a@cherry.de>
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

This reverts commit ef06c5d76ff46d488df201cc679f148b0140fd7a.

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
 cmd/boot.c              | 3 ---
 doc/usage/cmd/reset.rst | 2 --
 2 files changed, 5 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index d80f9d8c05dd..23496cafdf5c 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,9 +60,6 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
-#ifdef CONFIG_SYSRESET_QCOM_PSCI
-	"reset -edl - Boot to Emergency DownLoad mode\n"
-#endif
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 88261293924f..78c9c8873bc9 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -22,8 +22,6 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
--edl
-    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
 
 Return value
 ------------

-- 
2.55.0

