Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EEECA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F25E60A46;
	Sat, 10 Oct 2026 13:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vC5uMaLylSAi; Sat, 10 Oct 2026 13:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49DAA60903
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638101;
	b=mc6Rx2ZtnN7LuuUiRIuK/Tx2m4wg78ZU++M9LalqGuPTdE9uF1FIE3lhiNzleIDdKS+o
	 7zoYjLwUSD/j1YKWAGmAvGV/d5KtDh8d87r9MR2RB4fVLeIgEWLobBtzeJeP/vifUU4lP
	 nx6QAvaCovi4DV5u+7x1jREmVWbHskg0TKtaAAf/PiWYZVXzE80aaOyHxIfn6W8R7Seju
	 51ptjtklk0+hA8uoXUiIWiyH4jL30SREPILqSYwUwuWzAzYLkzK7tzR425BR3kBQ6WkeU
	 Rjf2QZgqZpEaay1/kobGWDYioBgjD7NUWGB3jfevm5sRctpCr3bdNZEE1souDUNvueQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=znsqReDWbpW2eOhGds+TSnr3q6pLIo3xam6tLKWlSr4=;
	b=Sy8RY5lGHNrFBnLKOkFQLxLvzKtAvSVmBOjmSbiQK141VW5ntsvaOEL9JghV7hPedhDJ
	 xzewlSZgAHPNmlnRkKfUQwAiZuaVlRjjiW5IshZUSb9hmEfhHR4uneOtP+yOitnD8YCSq
	 ws2G5S8V2ZSS09RLfr20pJgcUy9mpeacUbeM9aOO5SJ3kdxXv5R2OBNvgah2zLhnTTlFz
	 1+bbS1s0MDri1zqu6xHZcbx+sGvODE3zim3a/3w8goUVFNMWOY42vFYWPn1ieRssMth6/
	 7bpCLt29H7OWZbmNdiBtwGUdsM1HncPgLDPE6bP2W8BOUUhrp5fnYdFxHCnr6pth+pA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638101;
	bh=znsqReDWbpW2eOhGds+TSnr3q6pLIo3xam6tLKWlSr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=i0vHLIbCLpmKQwMwpbbnjpenTse2uzmCBoRm5oWMZgiQinzuUj0p57Fr/QBzhCDJD
	 Vwkg2OinELQgq0pFCSzgoN2RcEs8tQk6QHzllSF0OzFha27bbgbPikJtFIICLJkcBr
	 XcD+AeU4qZzHvVuVqZQT97apK+iHu2RrGogTKM9jnVCww4MPXJirLUOZFSOruaLCgd
	 OlQYu7XVmQO6yfbXuT/2yeP596MNNa93ZWeg3IK0KH9az5tTPn2/epzIHbYiyYKnDF
	 q9cS4ItZbu2uwambjgNGyxDMHhJnFpI/GxPNgwsVfaSvcWVXUtyJLMJtkL91SdSqxZ
	 ADVRo73HWBgpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49DAA60903;
	Sat, 10 Oct 2026 13:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 582AD9D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3072340116
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFWzN-saI1jw for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6BD7240061
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791635301;
 b=EK1G1fu8uUV+GGVRTFGZeJN/fa0gJFff8etA+yc6kU+q5KGzNoDMpKt3A258ace3vw6K
 lbTDBEZoFPg8b4gpj7UxIe7ZNs+AkyjHR8GUhljkXrm4W0+HS/jI14Wf8no7ds6SYymrA
 YLG8qvEyV6NQ/Wx0NSDlMS6jHE6cAMHBhbFH5rWBWjkkV2rVkFeVQ5/iOqIPPjkb44QQ+
 3XgAEb9pbH2C1N7axGQ5SMY5F/nPqkfO3RHtAz9C12s+2jTLIfzdXJbDIha1mr+f3ynkL
 kOv7M6mhP9kRYRUiHeN9xpqEJjRFPeqhfS2L5h93tp/892GGHRMMhqeE4bBGDwlAnMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791635301;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=znsqReDWbpW2eOhGds+TSnr3q6pLIo3xam6tLKWlSr4=;
 b=HQNpeap8M4H67FlLCBTWVFEvnfv95/V6oMo9lIKv39h9LHy++xdlgqRZN7UDWHstuEzi
 FH782yHnpERB2za9Gq162sN4yUBLrzO0Y9C9/3Y+ojq0Ns7wjwNq4U9RyDeO3CAty3eHP
 t7MW13n07Lo2CP1nLO8VSiCTlzsAvvXOGYw0ESrDfMbIHMRgn1wK28K125lEU0/OrIK/6
 dEmGmjDu28Gk5VjazZ4A6gljJN9x3/RhTn4Xpui98y3ulfD6aGSgbyMAzresxnaqBWzmW
 MK54Vajgm2kn4oNNxfErpXfSOXIK2K9ukZl1QtDwifjlj+otI509FqoYeM/OdXVjMIg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GHQpzHqF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GHQpzHqF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BD7240061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 708B5438F0;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48B5BC2BCF7;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791635300;
 bh=LIYxpfhpBw34dB/EGLXXHNwisEl7phW1VHgWfzfMhxo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=GHQpzHqFIGLmfc1EboP7VBjSVK98WOoL3XoLgBFEtWaXiIRX/dqvxS7Bp8ZKfo5J/
 Vc9PbJXqAEKYyI8wYXCmpSTftiM3oB26k0w3T5bi0rXF2hQzVKPwJWBro25XEhpdNc
 siv2pub2b68Bh2/ow1PwJQycLxBgtoB29JVTq4CL5EDzVoT1w/5Qx+/GOL3wl/ddwH
 YmKo0GHcGG7kVEoNgBuHuishxrDoX00CWkHPTD5iavzCjgpXi4YW/astyJXlRHb7Af
 x4yXMOspaGsIt/9/IoFMUkqBq/X3t21MOYpaJoakQlLHvjd7bf+62896D3rOH8fbn7
 u9J3sV3Xq8kcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68FCA6017;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 14:27:52 +0200
Subject: [PATCH v2 1/3] cmd: button: add live monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-button-live-monitor-v2-1-004f47a4a7b1@protonmail.com>
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791635298; l=4119;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=1aa5H9bzC+wAoQQVdtNv1o0xYF8isu0OAxDh+fGQfjc=;
 b=egxcIcmenVmFPC+DfnZVNFuLJuha2QZZUorI98qQerYLhMc1d2uW4Eay8Fljytvxb3YV83JcE
 yeyb8NBNzhmC6mkXJkSIf08RdNg7hJ2fL6oXs0InICSGkGQ/iPsd4hK
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

'button list' prints state once and exits. The new subcommand 'monitor'
loops the input states with default timeout 5s so live verification
on the device is easier.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/button.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 9 deletions(-)

diff --git a/cmd/button.c b/cmd/button.c
index 3e6db3f5b8e..268f5a64952 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -7,8 +7,14 @@
 
 #include <command.h>
 #include <dm.h>
+#include <ansi.h>
 #include <button.h>
+#include <console.h>
+#include <stdio.h>
+#include <time.h>
+#include <vsprintf.h>
 #include <dm/uclass-internal.h>
+#include <linux/delay.h>
 
 static const char *const state_label[] = {
 	[BUTTON_OFF]	= "off",
@@ -28,10 +34,27 @@ static int show_button_state(struct udevice *dev)
 	return ret;
 }
 
+static void show_button_status(struct udevice *dev)
+{
+	int ret;
+
+	if (!device_active(dev)) {
+		puts("<inactive>");
+		return;
+	}
+
+	ret = button_get_state(dev);
+	if (ret >= BUTTON_COUNT)
+		ret = -EINVAL;
+	if (ret >= 0)
+		puts(state_label[ret]);
+	else
+		printf("Error %d", ret);
+}
+
 static int list_buttons(void)
 {
 	struct udevice *dev;
-	int ret;
 
 	for (uclass_find_first_device(UCLASS_BUTTON, &dev);
 	     dev;
@@ -41,13 +64,62 @@ static int list_buttons(void)
 		if (!plat->label)
 			continue;
 		printf("%-15s ", plat->label);
-		if (device_active(dev)) {
-			ret = show_button_state(dev);
-			if (ret < 0)
-				printf("Error %d\n", ret);
-		} else {
-			printf("<inactive>\n");
+		show_button_status(dev);
+		puts("\n");
+	}
+
+	return 0;
+}
+
+static int monitor_buttons(unsigned long timeout_ms)
+{
+	ulong start = get_timer(0);
+	ulong elapsed;
+	int ret;
+
+	/* Probe once; buttons which fail to probe are shown as <inactive> */
+	ret = uclass_probe_all(UCLASS_BUTTON);
+
+	puts(ANSI_CLEAR_CONSOLE);
+	printf(ANSI_CURSOR_POSITION, 1, 1);
+	puts("Button monitor\n");
+	if (ret)
+		printf("Some buttons failed to probe (err=%d)", ret);
+	puts("\n");
+
+	for (;;) {
+		struct udevice *dev;
+
+		if (ctrlc())
+			break;
+
+		elapsed = get_timer(start);
+		if (timeout_ms && elapsed >= timeout_ms)
+			break;
+
+		printf(ANSI_CURSOR_POSITION, 3, 1);
+		if (timeout_ms)
+			printf("%lu.%lus left, Ctrl-C to quit"
+			       ANSI_CLEAR_LINE_TO_END "\n",
+			       (timeout_ms - elapsed) / 1000,
+			       ((timeout_ms - elapsed) % 1000) / 100);
+		else
+			puts("Ctrl-C to quit" ANSI_CLEAR_LINE_TO_END "\n");
+		puts("--------------------\n");
+
+		for (uclass_find_first_device(UCLASS_BUTTON, &dev);
+		     dev;
+		     uclass_find_next_device(&dev)) {
+			struct button_uc_plat *plat = dev_get_uclass_plat(dev);
+
+			if (!plat->label)
+				continue;
+			printf("%-15s ", plat->label);
+			show_button_status(dev);
+			puts(ANSI_CLEAR_LINE_TO_END "\n");
 		}
+
+		mdelay(100);
 	}
 
 	return 0;
@@ -65,6 +137,17 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	button_label = argv[1];
 	if (strncmp(button_label, "list", 4) == 0)
 		return list_buttons();
+	if (strcmp(button_label, "monitor") == 0) {
+		unsigned long timeout_ms = 5000;
+		char *endp;
+
+		if (argc >= 3) {
+			timeout_ms = dectoul(argv[2], &endp);
+			if (endp == argv[2] || *endp)
+				return CMD_RET_USAGE;
+		}
+		return monitor_buttons(timeout_ms);
+	}
 
 	ret = button_get_by_label(button_label, &dev);
 	if (ret) {
@@ -78,8 +161,11 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_CMD(
-	button, 2, 1, do_button,
+	button, 3, 1, do_button,
 	"manage buttons",
 	"<button_label> \tGet button state\n"
-	"button list\t\tShow a list of buttons"
+	"button list\t\tShow a list of buttons\n"
+	"button monitor [timeout_ms]\tLive table, updates every 100ms,\n"
+	"                             \tquits on timeout (default 5000ms,\n"
+	"                             \t0 = until Ctrl-C) or Ctrl-C"
 );

-- 
2.55.0


