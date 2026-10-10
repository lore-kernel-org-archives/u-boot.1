Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDD1CA9ECE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A842C4087A;
	Sat, 10 Oct 2026 22:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6xrREpXGXnY; Sat, 10 Oct 2026 22:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDD9D40878
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671536;
	b=cVt1i/WJwNx6S9TyC4tZQmYrTj3JBWjqzxRuzIrJiKHswFgbhx8KtUCETrrDIg2HPC/W
	 3XqSUteLt1pXT7HfK3aFIZCwvKKbTgdTyt8FbTjPHI22ZDkVUOmE/1u8FyoFzcsmwO2yD
	 cFGSAjBE00mn1iPV9Zcf65Z2daueNU/lZ4XGVckQ5eXnZYbxCGaJnk4TJiyXaaxsQsEuY
	 IeRyQGUFOPTC3YpCr/L2cGkHzQ543HHnSiMD12CUuBACorv3I6Lpb1QNHs/SBuQ8R2Tit
	 MabN07ABBFrf4P7TGeRXtKLrg3yps368F1xgsnMe88AjJBHDUHWRN+ZH0iTiSjuby6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=sY0OcPV2PKrpvIU3krKM7MMBsVxT+EHo7azcIxz5v4o=;
	b=r4PJQtgkYjNEFN91MMavzzS5pJffp2shAeTVbsb0JFNeg6GEzB5fR+6jE//fCd+kAK45
	 Bgx7/FVFhg5oPuow95i7fNOPO+qAqW3/ozTAv1LXHmYMAyCGaoGgv346UOidR7JD4DECx
	 Kx1sY6mFznvF/niPXKnSc8aupfHmT7BnVLGYzeAmvX59otiJObssrtxTXanWEvzeBMLIX
	 2xckGXymPLNk+B1SwAB0JHe0so4W4vvvClRqfsne5E30JAJbGnd4oQSvXn1PdBfIIZC4j
	 sbyWbJesE4JguCrTq9fZ644/cSjBPrQh3jmFGB+hPB0PUJafr4Ps38Yk8BNcH3N10xQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WlwS0Ssn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671536;
	bh=sY0OcPV2PKrpvIU3krKM7MMBsVxT+EHo7azcIxz5v4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=j3sgcg3iA1c3AIl3hdzrL3yzA1BuNVx27C/7iLoDfB+8357kzuUhsWZGNu15/Dz2r
	 lzo73I+rqpkb6z5KkTGgsEUbjcfgU7F+uawxT/w5sBnTpnhXfiY3GOpKv6o+rnMmCs
	 MbY6GCVYQkYBY4e9vN796+IitZQRZpCFoaokm6ravsXc4zORhV5Uq0mvKgVmAqIrKf
	 tDR1FgzuAbNbZzlpbQQ1tngflAZW1mymwOBFn0qhY/XdBlI9Y6GCUFOXDy/P7BJr07
	 yPltwWddzLA/nKOvMeuJJxb6lRb22F1qpqwMGwDl5wPEOAhc5FhxDjUaTKbU9wgJVe
	 9WA2rbASda+Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD9D40878;
	Sat, 10 Oct 2026 22:32:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A69D6105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98D6C4082C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0oAD-Qkb0LOc for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03CED4082A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666489;
 b=Il6J/VCKHLp9IhOct327sdXLGX35L3ZTf3LiT1TVboTUA2YVgQ5lGYN7SKl8xajjIBtM
 Jjt2CCq2Y8FF9DDbHHalMlL1agNAxaKJlI/tAUdlsyXSYDPSOfTHAAKDIg82XcRTzm/O6
 DJ9qgMAtCa/yMXTK3IWwA6TRDQsBL1VTfhk4r4Xmp5RBH3QWB9sqrSFlxQVGL4PMOrAkn
 8hzR6OJUFDrrAbFIMJ2iKLaR8Kb8avz3ZIiH75oxrvxYRQAOb3KK6sEE5FBqQ8sIkAi9y
 0uE1ZCjX/AxJCkDT42rziuzfvOhjFcU8sSTqbEQ6/4TdX61OfawlHhutM4P9eI1X1Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666489;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=sY0OcPV2PKrpvIU3krKM7MMBsVxT+EHo7azcIxz5v4o=;
 b=JQIS+weWX4nfIACgReLKu2DzrauF0MJAmUxQwE9LsLv+3UJaWu3HE+6dkLn8IvycdSIA
 oDSngpjcrlqgIWviSXTCecqky05EnCHvhmEGy7S1rHpZZYFz2JG2n8pElRKr/x4UOnfFY
 Bl4UscPPH7WmfG0/F35UM1y46BsCPAZvkFEkpUpa+tPa0SIXR1nhuNoYDw5zWfAROfcXC
 Jd8Jw7bAgrkpisoV8bs0bbHGG0wPU2NpWQLxcp0J7SDCEkQKGYODyomBKSzDnlqejxYkE
 dpLGZwjX1FklFbwnwmp4jVWyS+KmQQS1sq8dtroedsnI7K2xtyCBvsXj9rka4FKCoXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WlwS0Ssn; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=WlwS0Ssn
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03CED4082A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9C114479D;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE4FC2BCFC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=CHEM6DTvgpBmkBvZOm0yEh1uzRPo6ON88eprGWu60j4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WlwS0Ssnoxz3oU9O9gloPQ9KpZs/6Ll4rnBm4unrJGY2hgSDxVg2dw9JrUuP37CuD
 4Upzkb5RlU0ldkHCfYlzwQEHr99YJaMr1i0eSBUFv3XFtd1waQfdXFq6XqZLShscg6
 N9g1PmUUhZMqZlXGoOHvTddCt4oMr5FhBkz/3pGhpwM159IgEixKPw2uBtQGqVhoPg
 sB5qmBBL8gRM0c2opJ0Hj/EdRIYbAGfIOoTcw13xpCOCU2ZREQEbLARfxnWIq3kMk9
 JPujqoWbhrDwdjkHOy9/kLwUhh6V5v0gOji78Yix/vh2q1Cw6vzqBtABYKlRnmDNYh
 rWADm/FFimm1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF7CA9ECA;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:58 +0200
Subject: [PATCH 10/11] cmd: phone_util: fix "Cannot set reboot flag" on
 fastboot reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-10-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=1899;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=U+FeA8s5R7chNO8f+vErw4D3wV1XAzTW15uszADFsZM=;
 b=Hk0i+6tTHAEPTIgrBL1w5c976hxRz6SIzcG2O1qegJ73+7Eg6x+YH9ANZlxpTfuTYtk8SyBQC
 PmeETXK7737AFvlfkQcT6x2DtZd1DAh91pgkIW3+0NO25RJcGCpVE8F
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Select the correct storage media based on the 'storage' env to access
the BCB partition.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/phone_util.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/cmd/phone_util.c b/cmd/phone_util.c
index 1389b2ca6cd..8367e5729c0 100644
--- a/cmd/phone_util.c
+++ b/cmd/phone_util.c
@@ -1,14 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <bcb.h>
 #include <button.h>
 #include <command.h>
 #include <cyclic.h>
 #include <dfu.h>
+#include <env.h>
+#include <fastboot.h>
 #include <g_dnl.h>
 #include <net-common.h>
 #include <stdio.h>
 #include <asm/system.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 
 #if CONFIG_IS_ENABLED(USB_ETHER)
 static int do_usbether(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -110,3 +114,35 @@ U_BOOT_CMD(dfu_pwr, 1, 0, do_dfu_pwr,
 	   "    - Run the `dfu` env alias with a cyclic that triggers a\n"
 	   "      gadget detach when the power button is pressed.");
 #endif /* CMD_DFU */
+
+#if IS_ENABLED(CONFIG_FASTBOOT)
+/*
+ * Pick the BCB partition on the correct storags media
+ */
+int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
+{
+	static const char * const boot_cmds[] = {
+		[FASTBOOT_REBOOT_REASON_BOOTLOADER] = "bootonce-bootloader",
+		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
+		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
+	};
+	const char *storage = env_get("storage");
+	int ret;
+
+	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
+		return -EINVAL;
+
+	ret = bcb_find_partition_and_load(storage ?: "scsi", 0, "misc");
+	if (ret)
+		goto out;
+
+	ret = bcb_set(BCB_FIELD_COMMAND, boot_cmds[reason]);
+	if (ret)
+		goto out;
+
+	ret = bcb_store();
+out:
+	bcb_reset();
+	return ret;
+}
+#endif /* CONFIG_FASTBOOT */

-- 
2.55.0


