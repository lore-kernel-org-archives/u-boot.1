Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33400C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2F2E80D77;
	Sun,  9 Aug 2026 01:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yf6IhybihtjT; Sun,  9 Aug 2026 01:32:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7058580BB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239157;
	bh=9GnZfRS4FNtSPVPf9H4sjVZfq0rhk5r8jW2BAtz1occ=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=zPHUCxOr1IEFa3FYPoCRjlosuHcVxYEhkhsRemq2TiEAcIW+2qRWmgQTW1U6jlJSg
	 w2ueGJvHD7U5oflLOq9lgh2ggbiqbN00AV15hgyRU/F4JXI7o6L+j2NBfHmoUqsTMK
	 eLbaIwi20/9FkHhIly7o6SI/7bGjLR/cWifZGaBDiO6l3IsWIXQc3qY0bI5q2xvsDX
	 P1ZFlRGRlpbdbgoG7Fl4AQdj5W4VG1/rM9L2frFKEQntu70iR7Euyba0SzkpzxHdsC
	 2VSpdC3PMXQR7I9gr3fZIG9/DVeJeeiCUyJYQscitzmsVSuiFJk2lQqubm2syKDz6L
	 L1XWrYcXtbftQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7058580BB5;
	Sun,  9 Aug 2026 01:32:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF06144
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B546A400EA
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlChNM8Yegty for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:32:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9F716400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F716400D3
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F716400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:32:34 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hHgNw38zhzKmZD;
 Sun, 09 Aug 2026 03:32:32 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: Iterate over busses using uclass_foreach_dev_probe
Date: Sun,  9 Aug 2026 03:31:51 +0200
Message-ID: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 53khqoaf993r3f8jz71a4bbsznfb3e31
X-MBO-RS-ID: 73b379d925e66e19370
X-Rspamd-Queue-Id: 4hHgNw38zhzKmZD
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9GnZfRS4FNtSPVPf9H4sjVZfq0rhk5r8jW2BAtz1occ=;
 b=UFhr5GQlilgYZS+ztHaIFVzRC5vYP/duR0E6NCHrIYuyUwOcryilbw8bFJeKqWoGiOfMFM
 EZxff81SKX3qJ9x+qqZZ0lGjNNDn1ajKh8fm4kZ2tGrblTgI52Goc+Dqejm8AqLVRmN9H0
 XVvr/4l05QWg9dOn3MMppF8csJQcWVcyXlDiHpoG0ujjbe8OatIbEpGu/yq5GpHzM5UHIg
 1S7f4UvinoKleG6/FaNIEID/FwLHwX5hu8maPRTjmSAU0Rv1KZoimUfkVOrf6I58UNVC6/
 Qqro23DG2UFCKbLcdkLo8GQuQBh79oVzj7E0fONQX/7Nr34w/w46kaKoqIF5Eg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9GnZfRS4FNtSPVPf9H4sjVZfq0rhk5r8jW2BAtz1occ=;
 b=jNeqpJ/qr/PF0C0jLJFMltv3JpFCJxMqdxe8xVbduu7DlENCoL6Yl9MDNKBh6YW79o7leE
 IkXmOf9naA0h8jN3kggSbQGU+ETSz36G6gGtOfreWYsayM+zJRw/F81xqDgnh+4hk70GJ0
 MbKPVW55HS6rp4VFamAYMqCH7FH3Z73ztPlM+0xTIXvXa1uFr3EiTorVWXUM++/24LphsC
 pLqbW+iUibgUNENezFZ/N2YW4IgxG7pkGPmdq/AKbY8fs2T5ZuFITXsYqfvviE+F26JcwA
 sqTURt69FMiTscJ4myibhktzmytPKXPGggDkcFa1t+KYqVeWUj2R3dZLGAllGA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=UFhr5GQl; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jNeqpJ/q
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="jNeqpJ/q";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc
loop. The uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0 in
the ad-hoc loop would break on first controller that does not link up
in its .probe() function, which is undesired, as it prevents listing
of PCIe devices on other controllers. Using uclass_get_device_by_seq()
mitigates that problem, and, at the same time, simplifies the code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/cmd/pci.c b/cmd/pci.c
index 3c0aed50cae..d2a10aec41a 100644
--- a/cmd/pci.c
+++ b/cmd/pci.c
@@ -550,14 +550,10 @@ static int do_pci(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 		if (busnum == -1) {
 			if (cmd != 'r') {
-				for (busnum = 0;
-				     uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0;
-				     busnum++)
+				uclass_foreach_dev_probe(UCLASS_PCI, bus)
 					pciinfo(bus, value, true);
 			} else {
-				for (busnum = 0;
-				     uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0;
-				     busnum++) {
+				uclass_foreach_dev_probe(UCLASS_PCI, bus) {
 					/* Regions are controller specific so skip non-root buses */
 					if (device_is_on_pci_bus(bus))
 						continue;
-- 
2.53.0

