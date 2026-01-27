Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01811D2FEF4
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A9884207;
	Wed, 28 Jan 2026 00:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pf0uo2HV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E1eaE/90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D7884206; Wed, 28 Jan 2026 00:59:32 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76F3840CF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f12Sf4Q5Gz9vLY;
 Wed, 28 Jan 2026 00:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ljFTApxP7w0jN2zRND/y24m2kt816agX1du5of9s0vw=;
 b=pf0uo2HV6ufj5ou0AAGMyOcOqNqChLPNIZsiR7Hh3k+jVMYCRcJDi53hjgKDUR4GUGHZmE
 yePCJ/MHJskzWcaeP5I9+lHe4X2vIAexFdUhPfm1ahZFSXx6mgQL6mx0vWwFUe3EhHU7R8
 K7P921LGPgHxJxrT80nPb5laIM7YQeoXaSYKJYClDRs4ioqrMS8U854kL7mJ45H21doJJ+
 5nvr0p05kS+1qjHbFxDibaQ2RUWcXVUnh8khZWI/odPqTKKZ8ZjMcbLAP3jwhjc6M0+7Xh
 gZwZNSDSGXQOvz3r0Hiwx3B28t5xqWiBrYEIERgB4Z2v4mchJJEfLakBRXyLiw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ljFTApxP7w0jN2zRND/y24m2kt816agX1du5of9s0vw=;
 b=E1eaE/90QT6UzFcCBo6CIwQFXuuFUJP7aOOEwIuI1S8TwiAQboM8KnOBcg4/JYDUAhFbG1
 R0jnUibPA1qyaWtkZJfyZzKERav1n1JuOHwwAZ6k4zbn9Opmc8m5KCp0MbNJ6N2LMF4DIi
 JcWTOR1ljyhPXZ05y0o9oqSs4TpNKD7GrlRtkrOy0txnu/3R7nDlsaHX2YHOPIVZ/NSc5v
 1DEvXeaf8rHlPa96WBRARyW2PMYiCEmtCqya6oQIYHCrs8Z2HufqgoFM+s679qoSz1y6nX
 3+0DY7t9wZ/xxd6ghCkCi9eEZ6JVfqhXTALStxHjRCvxzagYWM0KpZjRWZa3XQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH 1/3] gunzip: Add ability to disable progress indicator
Date: Wed, 28 Jan 2026 00:57:20 +0100
Message-ID: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6de92aa8be5f17cd66a
X-MBO-RS-META: bzzj3mp6xe91dowx4q9b16fk89ce3iep
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

Introduce new environment variable, 'gzwrite_quiet', which disables
the progress indicator during decompress-write. This is mainly meant
to prevent disturbing unit test which responds badly to the in-place
progress update and reduce UART traffic. By default, the indicator is
left enabled.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
 lib/gunzip.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/gunzip.c b/lib/gunzip.c
index 040450c0e79..d31bbb2ba03 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -83,10 +83,15 @@ __rcode int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *len
 }
 
 #ifdef CONFIG_CMD_UNZIP
+static bool quiet;
+
 __weak
 void gzwrite_progress_init(ulong expectedsize)
 {
-	putc('\n');
+	quiet = env_get_yesno("gzwrite_quiet") == 1;
+
+	if (!quiet)
+		putc('\n');
 }
 
 __weak
@@ -94,7 +99,7 @@ void gzwrite_progress(int iteration,
 		     ulong bytes_written,
 		     ulong total_bytes)
 {
-	if (0 == (iteration & 3))
+	if (!quiet && !(iteration & 3))
 		printf("%lu/%lu\r", bytes_written, total_bytes);
 }
 
-- 
2.51.0

