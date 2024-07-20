Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD7C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EBF88CCF;
	Sat, 20 Jul 2024 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W5D7CMuU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tkLN3Cg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5541988CBB; Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6876D886F9
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nw1vM3z9sWs;
 Sat, 20 Jul 2024 14:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eikx+AX+VKbqbo/YTakOVD+Ixz7O32TCinTjj/4NKvo=;
 b=W5D7CMuUWEaCi4GboMOmrEYFGtXkX3SSsewM026mCqh/pgl4BxnMPmP2JAdJc/3f9XZ1sb
 jrmcsBkgCbtoKjvj+DKpkoezTwlaCVrxVGNkCwiKjHL1C1+8UqeLh8KUfpihlNxqU4fRaH
 d5m8fwxyzzVtLDL+/I3DStEQv3mUQGSVxYIOPsgefPKmFDgq3ZyzbH88vOpJR5LihnZXGr
 GhOMYd/HNqs20yBI47p4LkG0sidM6NitHlAhXlP4b5O8xZtj1la676JGE63yCl/akf5YWX
 Bf+wYKaNc6LtlL7NUPvavDr5lqF8uwYk0jWXXp2dA2Lj6dyRvaA3e5frovDDng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eikx+AX+VKbqbo/YTakOVD+Ixz7O32TCinTjj/4NKvo=;
 b=tkLN3Cg5/sju4vobCJhGH09lFB6fMnfwKLvAMIlqHR3o0pX6SyYJXvWbgj6n6Z3NsJxh2O
 pgOErYs4lLwnr8UA3bzsfKRgGALpMk3udPJySoYNQz3kocJp3HHzBz3VEKDjrYfRShd4l9
 nJub9pTP6+wI0nlj2M5EFcoVgmL1PPfvnzjun7gPWHlkpn5avoIzLnmDiMwQH9ZHoj3Uk5
 PlblA9EPAW5DEBeAP1fMpBP7+LeeBSXNv6UPNr1ktm+tQ+PlLrmH+Mv/4UxGorkwCr8rBi
 BL0RerVUR4XoIvSMwn7GRNrJTYGfE/gKae631gczzZttrZ5RdJucFM+32YUCtg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 34/40] drivers: sysreset: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:59 +0200
Message-ID: <20240720124239.7553-34-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 552a38fa4caabd49f34
X-MBO-RS-META: jompsafayqunbpi1xi5reaico3c1k6c8
X-Rspamd-Queue-Id: 4WR5nw1vM3z9sWs
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/sysreset/sysreset-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 0abb4042e0f..d30b008bf9a 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -117,7 +117,6 @@ void reset_cpu(void)
 	sysreset_walk_halt(SYSRESET_WARM);
 }
 
-
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-- 
2.43.0

