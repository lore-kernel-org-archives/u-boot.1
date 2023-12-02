Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C400FC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 20:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FC0876FC;
	Sat,  2 Dec 2023 21:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hT8dFTlU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c94LGPuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8BA8783C; Sat,  2 Dec 2023 21:53:18 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D06D876FC
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 21:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SjMb016VWz9sW9;
 Sat,  2 Dec 2023 21:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701550396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tdwdcny/An7LkcmcOOTTP02LvQVzbNeREE6yAq3NuwU=;
 b=hT8dFTlU1igifi2PoJXJuMuJ+OG1D4Gywyq5LNOI0WQ4yL7Zl3/7IyWqoAtg5G8slSFTIJ
 EAEtw3xIpkG8icLmAYt+erxobZrHpBlhkQNK4Yiw9BqT3RqrnJ41LhUwwrpsE29mwlp1go
 2b9SdjI4unDWXolKhUsaxa5rjQcJoQT49c2EV8vGxdPUNibFapK+vQEOOCI6Y4BYZXiYBc
 0lCv8Dwy7xjN2ntY21gv8GgaPrE5JcLVn5Gmc1v4XtlEAhDORx9VwvkCkZjF38NDEw4x2y
 4gjMbTm9/ogZF1FOkPoPDlmPSFWR5deYoYPyyg1MzHzdar33YbwNb8R/xn9L0A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701550394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tdwdcny/An7LkcmcOOTTP02LvQVzbNeREE6yAq3NuwU=;
 b=c94LGPuHj5TQM+2dx1sfrFpmDmLA/oCoH3r0Ttkxaav4k22c7EjNBJJEZYN67Vfhjg7pLj
 Tlzh4jjOS3OA6kk4K32XZ/SOmS1GrxObc66USBd9dHIbI3thEAWxwDqWTqLCTzc+p6RqHZ
 HKBpCR378P6XNTVuD9ABtYPAbYeHWQoMjqWDABWjPCdRwAAIvts+fOsxfrnC4+krTvkREv
 3vV24ZZuKz4jKEFNZXu5i1Wq4HuxrfMx/t1t48KfIFOFWxz+9GOZ6+3FnpS4juL2eBXa0Q
 225NAFm8XjARDVl/8wweRzRi92E/jqhiCgKE2s/G1hG3o2QFjxRxvAPloWKX2A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] command: Move command completion temporary buffer to stack
Date: Sat,  2 Dec 2023 21:52:31 +0100
Message-ID: <20231202205255.169670-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 761d225c3e4e72f40b4
X-MBO-RS-META: zc581ioma5si7qg9m5skiren8e5uq3my
X-Rspamd-Queue-Id: 4SjMb016VWz9sW9
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

The command completion temporary buffer seems to be only
used by the argv tokenizer, move it to stack. This saves
2 kiB from the binary size (depends on configuration) per:
$ aarch64-linux-gnu-readelf -s u-boot | sort -n -k 3

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
---
 common/command.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/command.c b/common/command.c
index 846e16e2ada..7821c273dae 100644
--- a/common/command.c
+++ b/common/command.c
@@ -355,10 +355,9 @@ static int find_common_prefix(char *const argv[])
 	return len;
 }
 
-static char tmp_buf[CONFIG_SYS_CBSIZE + 1];	/* copy of console I/O buffer */
-
 int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
 {
+	char tmp_buf[CONFIG_SYS_CBSIZE + 1];	/* copy of console I/O buffer */
 	int n = *np, col = *colp;
 	char *argv[CONFIG_SYS_MAXARGS + 1];		/* NULL terminated	*/
 	char *cmdv[20];
-- 
2.42.0

