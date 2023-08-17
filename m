Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8196CC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 05:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B92486A45;
	Thu, 17 Aug 2023 07:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="XUoEnzYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C573986A3B; Thu, 17 Aug 2023 07:45:06 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E7D86A4A
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=PSZHZcDpZlS0pz0p96pYbD9Fq/WccGdkWMgccpLYFIw=;
 b=XUoEnzYPIkwZm9VP2JSRpU1cZBX8Wcez/UbMq6iCbJaEO8/LqDjpgL3hXgI50PsL3zYz
 jtNATR98gl+9iI37/KuuQwPED7L9nVyD38r8eAFQa5a0tHyrR38jo3HsCHCVA/qTO8BbXy
 8VpSXvcTVYaHzADgqxiGf992STGzgSaQ+FdudDGTX95CAD2M9N/zs+ybobmpU9Qt4ekR5B
 QoWpEqr3De+UZ8xVoQFfKkJW1znEl85L9fH0hUFvfHh3qWaNrLNL7dhRuz6va5ZjFUGmmp
 9zCc8utGJFhvHjsLfBtCmOb0kAHRp3qBHMlAZdDgO4x8jNh2jYBR6vgkdZVe+5Gg==
Received: by filterdrecv-77869f68cc-qljt4 with SMTP id
 filterdrecv-77869f68cc-qljt4-1-64DDB3DE-14
 2023-08-17 05:45:02.317953713 +0000 UTC m=+8489342.760910283
Received: from bionic.localdomain (unknown) by geopod-ismtpd-canary-0 (SG)
 with ESMTP id Oqc3ZZwjQ2GMMeaVw49nCg
 Thu, 17 Aug 2023 05:45:02.106 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] power: pmic: rk8xx: Use sysreset implementation of the
 poweroff command
Date: Thu, 17 Aug 2023 05:45:02 +0000 (UTC)
Message-ID: <20230817054457.472342-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817054457.472342-1-jonas@kwiboo.se>
References: <20230817054457.472342-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7XhqrxU0Np8b2lK9?=
 =?us-ascii?Q?8TZUJtg+oNokmfkQKO=2FIkt7femj4ssgifR46p8y?=
 =?us-ascii?Q?0HGcjVYEzBHQf6IyQIYNzBLNtILaRa2nGbpdpOy?=
 =?us-ascii?Q?rSmSh6w+kfuTEl4Y6u668PjAETq0IxTrvYny+Qs?=
 =?us-ascii?Q?VJO0ui50bhUWIn+51RCBFJswQEMGA6KAC5XoXa?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jaehoon Chung
 <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Select SYSRESET_CMD_POWEROFF to use the sysreset implementation of the
poweroff command when PMIC_RK8XX is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
- Split patch
- Collect r-b tag

 drivers/power/pmic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 176fb07c651a..4a6f0ce093ad 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -233,6 +233,7 @@ config PMIC_QCOM
 
 config PMIC_RK8XX
 	bool "Enable support for Rockchip PMIC RK8XX"
+	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
 	---help---
 	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
 	an RTC and two low Rds (resistance (drain to source)) switches. It is
-- 
2.41.0

