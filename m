Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36D0CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 161BF4121B;
	Sat,  3 Oct 2026 12:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2CwzKj03OWQ4; Sat,  3 Oct 2026 12:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 42F0C41207
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031675;
	b=XLvINC3IIca4aKduLp/F/+nWKGG3RPWp2qbCfNGNwiITE41BGAxO2T+tKOGw/HLS5oFL
	 ovsX3mE0UaHEox233Av0gsMIJKRttBnLlZNwzsPNRMGfHdL+NpIfUcVgBAf1XEGnY8B6u
	 1m+SmjMXXeFmQeucVI+sPy2SD+n7jLxO1WS5Frm0h17GGaZadSkNMao/CwXwA9ZMX+YtP
	 0A/j00UWQxOAx5G4T3OgUw51IVt9FlmjPijwxS7/XjqpEZt7prlNatIzUTQS2OiAE0fMz
	 FnYGQdUettQFaQek38q7cWIja74YbIJk1UzegnYCUzG+QufYnkECb6QXFZgo/kZ8j/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qDcmgIyQykXWKZ2GRGDWom2hmsisPjodViDaolWY2ZQ=;
	b=I5yKnxpOr+qssee25CIZhNtGu7GfCcy8YEWQsvOVjUpKpoe+RQLl1Y6Z75BPv2j17Fs8
	 QRCTYhG/AQbZysG+2QTCjIRdbtjaZ23AHxcq+hUU46557fqPSFt5CHVb4N5GxiLU6fkh3
	 7LzarbYSWAa3K7t4tz6qvdqVFjOpRjciBHxtph2mcQ6yeeLPNgfHk8LaviELzmGS4OQRA
	 V4CubevOTbvjWlkZkjINLr5c3EZoDztBFh9WMNuGHIxFsa0BayzBmG0ZGHX/MPswq4klB
	 0zpV9JwYmlkqVJiFavfx+I14mhbwhkxrf2ct42/BtJyujOcXWWdMpnZxOgEprTkTPKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mHCb0Dk0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031675;
	bh=qDcmgIyQykXWKZ2GRGDWom2hmsisPjodViDaolWY2ZQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=le+f9lRaA5JSdphFHUe/0wFnYn4OqqcCvnifBUDSFFiDjuoEfqzgRSk0WQezABHRY
	 mPV+G9kVV5eYQlUpVyb6WaStVNUDbrp6uY18obAbXQ7+Mr/FS38VxFQ/A5TDAPQbt7
	 1um59X9YJaFxjBsdLo3pzMOMu+a0MptkD/0eoNaXxpLoUR0cYtSQHukvt6DMsB3nk2
	 eM80T2/vuDhHMW26HIScMtjsaEyJehi0nDr4K2b39i0PzbqK7Wxb9KkUyxvYFt+97Q
	 +rGSWr87SB4TtcYx7xoTYCKFiJQQV+WoOM3Vdlvj456cYfZNCxd+Bq/dba+F7elZR+
	 RQssoRjw3Rt8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F0C41207;
	Sat,  3 Oct 2026 12:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ACA032F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 03:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C88C40A99
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 03:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAyNSrWf7s0a for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 03:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7AE8140A9E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790999053;
 b=niVedaCdVWoauE0L7sAuUi6FLyYh9g2EuuQN/H7W8ZnP0P8n/4SNc6y6KU2b+/MljfKo
 +Hyvwb5Xyspl/2UEIpQ3QGpspLnSk6nlWM9tuCo8V95FLEUt4ISNtk9+7wqsfKQBdAzxy
 1smgNgQD7vU9sxUOAOjvCMLFuY2h4CO7e9JfAMjlwm9iOVL0FJdgH0mqne8ZPnbPsDws3
 sQMAnracM9/Z8HKTQWxw3qQ+iMkv+xgHFJIsRBTVV8d/gt5iBUZg3VcoTLbfzUsPKCFdz
 b8JZohb1bCTmsUOGnGbFBroiT3FI2zAeypxba73OzPfMjdaLMFq5X85QrRV/pSQGCVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790999053;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=qDcmgIyQykXWKZ2GRGDWom2hmsisPjodViDaolWY2ZQ=;
 b=Klwiw7ZCKAZXHMwamQ9PmueAbTIai6skWrX3RNvekuD6tl+T9Qyn9jwmhkETU7CQ1yhG
 fp6y3y5s0UV/JmiUfPhDCGKr/QFPs0hEdb+u3s4iYTFWbLlFwnUuXEfyT+kC2f0C2y8YS
 md6QxfWIl81ZWQefmAYDtn6tOXTUXsiaT5XitnKfDzvPnAxE/yuQ+J4cZvIf6cn4km4Uw
 B1sd4JDXI56KLzZX0iGaZbkAVmDc8sbu6xjqe4UFPtW8atT5+VrigXfRtjapTYN07Cgww
 GqVp5WMl5PJ0dzxmTzi6FplqKT8n7hDUxe/cede4AQS1eX1cpr/6iXdIRyv2QfvhYAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mHCb0Dk0; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mHCb0Dk0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AE8140A9E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 03:44:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FBDD44035;
 Sat,  3 Oct 2026 03:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25236C2BCF4;
 Sat,  3 Oct 2026 03:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790999051;
 bh=MN1BR3G2OEqoMeVrzTI82eJ6Cnpvx/6K67oQfzlUOHA=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=mHCb0Dk0I+zonODG/oYkUIhy3F3gChK0Bd8c7leQJuGKP3ZdLkA1LyYmy2eBG6E/S
 KOGBwaXXLGyAvRpQYE27WrIznM33tye99O07OJKpBclD20CX5yp5roBaO7WuUEvPSq
 1qy3Ys42XI37TKWLjPhQuluvmAZ+UaK50AJI168Y/i6baG6CkPO2VnC3/FsZk85/dG
 mffW9hDokFyeo9Ls+99zIhUAWDBD0z8ai4w60zhCIRDqHFGzNv3mZNy+Mnrb/Vewn/
 OrkbCyTSGb2oT9SPBSeN/DWtG+vuaUus/dc9xYtimvtVd2A/ucwUiOoB3we5r5xL9v
 Vkri978b/5SiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F17F6CA5FE2;
 Sat,  3 Oct 2026 03:44:10 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 03 Oct 2026 05:44:03 +0200
Subject: [PATCH] cmd: button: add live monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-b4-button-live-monitor-v1-1-6a2934e71fbd@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDsQg0TxKuKiE6d1RJOSHxHEu
 ze1y2/x3gmRg3CEvjoh8C5RvCuoHxXY+enejDIVg1ba1EpppAYpp+QdrrIzbt5J8gG7lnQ7daa
 xZKDEn8AvOe7xMP4dMy1s0+8G1/UFKeA08noAAAA=
X-Change-ID: 20261002-b4-button-live-monitor-87b27d864cb6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790999049; l=3218;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=W5lumvEdK05TMwElbKPNBeEZv+2cTckmdk6q6jk7ySM=;
 b=R88UJhta9UgsW6RCKbh6SZTYvMM4+o7UOpgUc2+ly9gAXEdC4g6+oudVNeddAldVVt5Hujfd4
 TeXtbAblrbPBCBmZKXynhNv3hSVEKA2uus4Gpj6BoCpKA7q8BMstntr
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

`button list` prints state once and exits. The new subcommand `monitor`
loops the input states with default timeout 5s so live verification
on the device is easier.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
`button list` only prints state once and exits so verifying a
button mapping on a mobile device is not practical. Therefore 
the new subcommand loops the input states and prints it live.
---
 cmd/button.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/cmd/button.c b/cmd/button.c
index 3e6db3f5b8e..daab7b6fb6c 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -8,7 +8,11 @@
 #include <command.h>
 #include <dm.h>
 #include <button.h>
+#include <stdio.h>
+#include <time.h>
+#include <vsprintf.h>
 #include <dm/uclass-internal.h>
+#include <linux/delay.h>
 
 static const char *const state_label[] = {
 	[BUTTON_OFF]	= "off",
@@ -53,6 +57,48 @@ static int list_buttons(void)
 	return 0;
 }
 
+static int monitor_buttons(unsigned long timeout_ms)
+{
+	ulong start = get_timer(0);
+	ulong elapsed;
+
+	/* Clear screen and move cursor to row 1, column 1 */
+	puts("\x1b[2J\x1b[H");
+	puts("Button monitor\r\n\r\n");
+
+	for (;;) {
+		struct udevice *dev;
+
+		elapsed = get_timer(start);
+		if (elapsed >= timeout_ms)
+			break;
+
+		puts("\x1b[3;1H");
+		printf("%lu.%lus left\x1b[K\r\n",
+		       (timeout_ms - elapsed) / 1000,
+		       ((timeout_ms - elapsed) % 1000) / 100);
+		puts("--------------------\r\n");
+
+		for (uclass_first_device(UCLASS_BUTTON, &dev);
+		     dev;
+		     uclass_next_device(&dev)) {
+			struct button_uc_plat *plat = dev_get_uclass_plat(dev);
+			int state;
+
+			if (!plat->label)
+				continue;
+			state = button_get_state(dev);
+
+			printf("%-15s %-3s\x1b[K\r\n", plat->label,
+			       (state == BUTTON_ON) ? "ON" : "off");
+		}
+
+		mdelay(100);
+	}
+
+	return 0;
+}
+
 int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	const char *button_label;
@@ -65,6 +111,13 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	button_label = argv[1];
 	if (strncmp(button_label, "list", 4) == 0)
 		return list_buttons();
+	if (strncmp(button_label, "monitor", 7) == 0) {
+		unsigned long timeout_ms = 5000;
+
+		if (argc >= 3)
+			timeout_ms = dectoul(argv[2], NULL);
+		return monitor_buttons(timeout_ms);
+	}
 
 	ret = button_get_by_label(button_label, &dev);
 	if (ret) {
@@ -78,8 +131,10 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_CMD(
-	button, 2, 1, do_button,
+	button, 3, 1, do_button,
 	"manage buttons",
 	"<button_label> \tGet button state\n"
-	"button list\t\tShow a list of buttons"
+	"button list\t\tShow a list of buttons\n"
+	"button monitor [timeout_ms]\tLive table, updates every 100ms,\n"
+	"                             \tquits on timeout (default 5000ms)"
 );

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-button-live-monitor-87b27d864cb6

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


