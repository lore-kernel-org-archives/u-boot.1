Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A38CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD44E810E0;
	Sat, 10 Oct 2026 22:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWzE1auoDDWo; Sat, 10 Oct 2026 22:32:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9119081089
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671553;
	b=WocYDeTEG2LK2WnSeANAZqoIlZaS7MX5Qtt+aH118Reicl0Pd9xYz/UM5KFhq13zILLG
	 2FMEUoq9qd1+Xt1LsY+PUo4RkscX3Hu/KWHlxjdmd78gvqyGMYYUp0IDUVrt84shPRo+K
	 I/P1XkuP1ThIO0GmbAsrlR6OwHiqv+39qT73+xunOiWYuauBT9Z+c6emGiO/07GsydpFt
	 3r7zAWmHYIHJ7SEXjhVp9pqxYdwSVONgESnl30pH/v4BDoAmDLGiovZs/eZt71327VvMB
	 2gc3A36UMd4jWduxb5iHz4WGe+Fa0FZQ0S+jeM45+z4MDEAa+6l19Rddy5MnP6I8G1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=YG0KjaeEXSY33l+leQKju4odClZudIK0kyKsPRjlg/8=;
	b=Al6/QzGd8EuxfcmflaAVkwar9JXKyJn/5S9enoXV66pMIxoB2jg5WV7HBEc4wrrN6sAz
	 V6qsuBdNO00DpALeQ8+OryXgdngSyN5//60EvLcU8jYuH6gh4+ZOzIfMMUhT5bmK08Eu9
	 tGNeeJcF22Png8kF0hsa/A8qvSyB5MYZJST0dtogwuGILreiPfucPcYInp/mqkEzGSd8V
	 R07GCrvk9TWxi7cIujGl3GF8xRZ/l96VhKTVAvY5bchs26BuW3Mp+3Qb2B7vxORN5alXu
	 Wg3Y3Gr8iSUVXPY1NIXcsJmCYVCJu+oQYfKM456PLSCPFNAU6U9MBpAQxij3y0YhAbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671553;
	bh=YG0KjaeEXSY33l+leQKju4odClZudIK0kyKsPRjlg/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uFyYr1/4otoqGb9smohNmd9YNi4Pl7wJyUseztE7Ux0NwxyTf1dw6I5CRFGZ4kfjd
	 2nj4+u9RRZPXc9QIl6GJXwBc7LQzzIUbwAkGOka78VUJzP5w03N7ql2pYRwFEZRAni
	 op1Kds7zeUXybEkk8o+2cbO0l9Nk4Ufwj67+bqQF3JH7b3aa7hv/vkuNj4exoMNCE/
	 p/o/QrcGQZhvmtuwvrMV33FBDk4UjjHB+tUe15gJyT/xaI7KhZuGXmFjO76SqvdAbm
	 vfP7Tb51ChQbOheF1mDonKeYEHJPxbrAzBSMgGzoCuhw/ql3rE4Pt3jM4Buu0bAGrA
	 IG7EFQLmGQ52A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9119081089;
	Sat, 10 Oct 2026 22:32:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBE48356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C224E60638
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJMM8elJ0FZx for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1AF16061A
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666490;
 b=Gx0Tbh1sANhrVkZZRP/uiMhkmRVxsJhV8VzaTHrvH6nf/VKbhrIZIc5b6o+WuD674Byw
 uRYZ23z8yhAcQWduLlNv36UHJD3FSsUBocWLps+QZSsrgBx0ixqZE0nnKwqYWsBsI5nUg
 qVG9eiOWwEuMEehN9v/36j7T82GKmS4pnnmMf1eMinBo3Sm+Tp18vZC2ZZop7laeAMyec
 fg+xHgUlsoWCJjRKh8pgFev/O7OEArAz1wYvUYkH2dfA9ontaXjcmv0oZTC1RpCqh7LIt
 /UPQL7XJBixAiPANM9+MPdOD3RfcfTJuKj8Nuco44+mLayBvDy/6LhLD2h7+8IFni5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666490;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=YG0KjaeEXSY33l+leQKju4odClZudIK0kyKsPRjlg/8=;
 b=J/Ci/9k0jK5IpIbzGGQKiEMJtR8jVT/UwROSCqoRy277/ttcGQ986PPCSNz6IQ+COLdV
 TEUrofjN+5lmJAf/JcknifJyiH/fhH6rQXpT3KyDyqJvtwBo2NVWtwEY2sPPAABoZqd2R
 hCNNHAHJ/KQD0nHw9iKmoHKQDairI/isieDJBeoHhEhFlqbqIFH140LNmevtiWuJEKTuF
 f2w0HoDSynzZ/8yP+nIUppGjAFh3SJZ+fRFUAWW6+woVoC2ezY5Los39MS/i4pnuomAOK
 vXi6hdXnFGxuG5KiJRexDayYS5V/kUZHBhKIaivT64PMJKXS5VyJ16Y9NsysJUdCovQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QpUoodqE; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QpUoodqE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1AF16061A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 974D060534;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C773C2BCB9;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=VVSJAQisVKA0GljhN+c4anDapgj0dXBZDjt+O7eVO24=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=QpUoodqE2WuQGWAvjWpaJZDO8SvOGwoAUO/f3hoLFTQD4lqAxzjxV3U/jMNTSxwL0
 M+97hZfNcaeSo1P91Vn4kLWtbN4dId0PGm4xe/jKItpa50hgmfRzlC0NQ83B/6TmX9
 z16q4UA6HMTcgFtaElVVDh0X5NLqbRs54vIceL4zbQYHFzH5g+OOG1Bpl+xhzOaEP/
 3vPIh7EJJEw3rguOnzddYRid1BWwW7DurcMf1UKVTXph1zc63EeLV3C5e33zgloRfc
 exx+2nmQITVQmJbJ98UKrS2yHJPKXu3zPRLW6P1NaBP3BJbjgnj0C2R9NCvSETKWO4
 8oBp6SwuOliYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 387A6CA9EC5;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:53 +0200
Subject: [PATCH 05/11] cmd: phonemenu: show active A/B slot in the header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-5-bfa23de6eb0b@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=3838;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ffiAIQgf+1ESPQh1EhoikIjDmBW6G4txlkiotAmYsPQ=;
 b=UuFGBJ1m73byWwiVymNi8i2dqsjPMkHoZyOg/AO70SSVDTUC7SQPlJ97/0YH3Ag38n/P1e9/i
 WUFGWbmm9h/AUl/9YGjbxAN2rIAjOXk4bSTv0wFHtMPFwuIv4QIuM44
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

Show the active A/B slot in the boot menu header, read via
ab_select_slot() without decrementing tries.

Pick the block device from the "storage" env var.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS         |  1 +
 cmd/phonemenu.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 include/phonemenu.h | 14 +++++++++++++
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 696abefa1e6..8734a683221 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,6 +689,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	cmd/phone_util.c
 F:	cmd/phonemenu.c
+F:	include/phonemenu.h
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
diff --git a/cmd/phonemenu.c b/cmd/phonemenu.c
index e83394714c3..7478661d049 100644
--- a/cmd/phonemenu.c
+++ b/cmd/phonemenu.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <android_ab.h>
 #include <ansi.h>
+#include <blk.h>
 #include <cli.h>
 #include <command.h>
 #include <dm.h>
@@ -10,11 +12,14 @@
 #include <log.h>
 #include <malloc.h>
 #include <menu.h>
+#include <part.h>
 #include <stdio.h>
 #include <stdio_dev.h>
 #include <video.h>
 #include <video_console.h>
 #include <version.h>
+#include <phonemenu.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 /* Layout (pixels) */
@@ -427,21 +432,67 @@ static const char *pm_codename(void)
 	return buf;
 }
 
+/*
+ * Block device the real storage chosen by the "storage" env
+ */
+struct blk_desc *phonemenu_storage_desc(void)
+{
+	const char *storage = env_get("storage");
+
+	return blk_get_devnum_by_uclass_id(storage && !strcmp(storage, "mmc") ?
+					   UCLASS_MMC : UCLASS_SCSI, 0);
+}
+
+/*
+ * Active A/B slot via ab_select_slot(), read-only
+ */
+__weak int phonemenu_ab_slot(void)
+{
+	struct blk_desc *desc = phonemenu_storage_desc();
+	struct disk_partition misc = { 0 };
+
+	if (!desc || part_get_info_by_name(desc, "misc", &misc) < 0)
+		return -ENODEV;
+
+	return ab_select_slot(desc, &misc, false);
+}
+
+static const char *pm_slot(void)
+{
+	int slot;
+
+	if (!IS_ENABLED(CONFIG_ANDROID_AB))
+		return NULL;
+
+	slot = phonemenu_ab_slot();
+	if (slot < 0)
+		return NULL;
+
+	return slot == 0 ? "_a" : "_b";
+}
+
 static int do_phonemenu(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
+	static char slot_line[96];
+	const char *slot = pm_slot();
 	const char *sub = (argc > 1) ? argv[1] : "main";
+	int n = 0;
+
+	if (slot)
+		n += snprintf(slot_line + n, sizeof(slot_line) - n,
+			      "slot %s", slot);
 
 	if (!strcmp(sub, "advanced"))
 		return pm_run(pm_advanced, ARRAY_SIZE(pm_advanced),
-			      "Advanced menu", NULL, U_BOOT_VERSION);
+			      "Advanced menu", slot_line, U_BOOT_VERSION);
 
 	if (!strcmp(sub, "diag"))
 		return pm_run(pm_diag, ARRAY_SIZE(pm_diag),
-			      "Diagnostics", NULL, U_BOOT_VERSION);
+			      "Diagnostics", slot_line, U_BOOT_VERSION);
 
 	return pm_run(pm_main, ARRAY_SIZE(pm_main),
-		      pm_codename(), NULL, U_BOOT_VERSION);
+		      pm_codename(), slot_line, U_BOOT_VERSION);
 }
 
 U_BOOT_CMD(phonemenu, 2, 0, do_phonemenu,
diff --git a/include/phonemenu.h b/include/phonemenu.h
new file mode 100644
index 00000000000..5d6ded84197
--- /dev/null
+++ b/include/phonemenu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _PHONEMENU_H
+#define _PHONEMENU_H
+
+struct blk_desc;
+
+/* Block device of the real storage, selected by the "storage" env var */
+struct blk_desc *phonemenu_storage_desc(void);
+
+/* Active A/B slot (0 = a, 1 = b) or a negative errno */
+int phonemenu_ab_slot(void);
+
+#endif

-- 
2.55.0


