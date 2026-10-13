Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F59ACC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07C8780F3E;
	Tue, 13 Oct 2026 16:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGGClvAYNzOq; Tue, 13 Oct 2026 16:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C1FF80ED3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910121;
	b=lgW7099wOj1/+pOaRdqlzhtPv+UbefyE644xxrOk1zdv53vZXlHzvc4qQp7s7FDHbPOq
	 RJ4YboXdqGtPg5Yxmvued2YwnLqblH46farHUmWa+PglvcBq8p7KdFkEKD0xThA3OX9zo
	 Oew2euE3hSbnwCVYGwLOWid+I0v7wgPV1iU6mdqcPndGB5GOg7y0mhgJK8psLgOnu+Zrl
	 0qPL3QosuBYeGwsTtYlg8ay8RflHbzXcFQqUHdBFghjC+MKfm5wAbwEYWtCXmpEl2fSaN
	 7Fwy9h51WMvF42uc4x7H3D6tJGqkxBQYWiuCu1Gd5DEkibiAgc62YgnEjqpyUfxMjCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=vKHuEU7mOF+HOAM7VXZC3wfn+fbE9GU0M4JTvS0wxMg=;
	b=mbJFxi+sdMEK/NdLsm9DIoqlwFrYAyym2oBGQCuisbHbGv4IvAo+APc+T/cWvhygw0Hy
	 ntvZBz3p6HeNE6jl+LjEN6XOCERR7ROS++c1Lm9XnmgxqvGAmghanysOxVIVhmmgQ0rGR
	 uytcjkXIgCibcFbuwyMiUACP8ZF8mMyHsqsyBzLVxfHgQhLYPJxtOgsPcmBl6KswbkRaG
	 zI/WiJ7rv9ofkZ9IAM7sgfCfNk9ByDwUl7RtBJ3IuFZV8cwlD98K2ohHc4AEd+hJP2aIs
	 3DvigBo9Ic/mlqwbdRH9yI24kT2dNHa7PetitkopbMsVc1zFa/+2yOE3P1Nd77CLjqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910121;
	bh=vKHuEU7mOF+HOAM7VXZC3wfn+fbE9GU0M4JTvS0wxMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DCLbGRUxKJ/zndWMUMilvb9nhgj6tCphAmUXbrREUAlG63Tf9hBGDUoHS8jKh45hT
	 dS7F+TCJHdbk9f2+DFPWYD4hHOk4vZ/JLahTtbiLiRHB8rJMIFcpspq2WZczIsgnla
	 cOcD+xQz7wjO+LVSeo1+gglDs1W0rFWRwfa35l5GnJBBuxR6anjjicN8+C8bRUFD6X
	 BVUT0OFit1VvV8ChjqoJqltx52QsfykHd8Kh1cwn/sJ5En0eemfhut/yXqunrLDgId
	 /0TrOu619wEoQt9jvQ0F2VGtJp829hZcUPbd2ySYiMIHFXCAQ2ojASPZGZzU5PEMba
	 q7u+7E1Q7o7qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C1FF80ED3;
	Tue, 13 Oct 2026 16:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70AA9129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56F52404F9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_hugZEPSY8X for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F8A740437
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909218;
 b=M8fax1FRjpz1p3m/4mjpMl/qzPFx6JjIq69B4Ld4+3ocOkb+UJHW84U7+JPkNnGmu2OF
 qvQN/Qzc3inK27TsRDoneqi7y+PcFrj318W58HgEcKtdS5sTAyjSTfXAikKWoKi/Bf2a/
 /brSG8MYryaE3rAwHrmwtOiQx2mRb+gwjdYR4txhseuvL9l+e+yXJqC9joM8u8xg+WRfa
 ao3XQv3QqJJ2Q0CzCkTk0r/dGCGvpYoaM79ni8GIJlR2nU9oQnQOyJ/I6vDYg7Y1X0RBG
 EOTBzcoPuXSAkBV6iMjKpcxPX/emSnKM38UY+WqhRPW7p/amBIhkLt8etEqptAQUdZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909218;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=vKHuEU7mOF+HOAM7VXZC3wfn+fbE9GU0M4JTvS0wxMg=;
 b=eEWOVIipTusKdLri+/NIyF9y1B0oiPAjwjeNrTnWWNbcehLgeSQGldhJUvi9r647ns2O
 r+jwfeh5uyvrPZltBfkiM2gii8N4O7I39BzGSOAr32blOFT2OE2Fjtbk1WBniYB4yRYnW
 hBAG8dAbVJAnU/7q3T0cF4byXRgjbH+3jbF8QNONgL0ekkqPNGLNObh3KJJLuEbt6bLBf
 ISfD6zye8pAvZNz4w5BiojPb7D2tLNO767HGY8dGfB3DeEddRYVx6F//Hc7tXLyYWgLKh
 DVAFbvfnbvmdgNZy1zg/mpfXDskG8nR7TyCwzy9a91E22H6AwUCccV5a9nowid+EMEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tn58Uw5Q; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tn58Uw5Q
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F8A740437
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D99B41867;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E42FBC2BCFB;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791909216;
 bh=J6t2UA/D+v1CWOPsyBrYm+qM0YxxpOV4bA3Ss1N8a0Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tn58Uw5QlqJLPNs/wXxXQ3aeq1L/0yxONpOdxYAs8q1J6wBcQunXxl317EqiSfeWW
 Thj4n8lX3PCj9LbVufX1GM2c2zH+SA2AYv6afM/AMJEUhCZkF0EWbs4EW2BVLATUGx
 FpolpgWjuOwBi7BQlzKLfhZ1jXMbEs8g/E8Mpzlz30PLcppQu87fZPosw4RiERHqWa
 cnq8hbkdaJyG48ScvyRX+xxMsNojJqW+sCu6jt3khj5a78ntWh8DfQJsBurTROiLPM
 SY3+s88izYrNvM/cfL01BQrzEz27uH+jUSs57Sw/OLw0Ixomwt4NHeHdx3wNjbTHYa
 y8aozWQHgQXrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE3CC6B1A;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Tue, 13 Oct 2026 18:33:32 +0200
Subject: [PATCH v3 2/4] cmd: button: add live monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-button-live-monitor-v3-2-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
In-Reply-To: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791909215; l=3523;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ITLNbOdpfrKUeEi04PmS+kZBupXlmPeNqsjTfbVW/ZI=;
 b=VqgMZhq5QYQh05BTRoqZ8ZnZwxnsjhpoVY6O/vhDeU8al2qu2pcJltuaz/d9pMZ8WhoThLfM0
 gCk6v+9AZarAAEUdFxWVUTTNuLL5Q668UssTXo/9oX9E3cAqBJCw8X+
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:30 +0000
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

Add a 'monitor' subcommand which redraws the state of all buttons
every 100ms until Ctrl-C is pressed or a timeout expires (default 5s,
0 for none). This allows the buttons to be checked live on a device.

It reuses show_button_status() so both subcommands produce the same
output.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/button.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/cmd/button.c b/cmd/button.c
index da1bf1f6e3b..268f5a64952 100644
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
@@ -65,6 +71,60 @@ static int list_buttons(void)
 	return 0;
 }
 
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
@@ -77,6 +137,17 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
@@ -90,8 +161,11 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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


