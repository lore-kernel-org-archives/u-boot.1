Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D300C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AE2C6089F;
	Tue, 21 Jul 2026 19:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KA0TZAyA-qVd; Tue, 21 Jul 2026 19:53:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B844260611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784663635;
	bh=vEju101FdsJrv+OFURuF/LsOv0eQjvVuUToSz41kx3s=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Eg/YavER6Go38dB4C/wioLpD7vmngT/qm3mhY1nVsfsLsfJaPERVnbP7QS3M9NCDd
	 Tr92Yx0lGinEAgRebsuBhR7dAb+bXCa0h3MkfWkHFrw5XdbWHi19UrAQB2+fAwnKxr
	 9LOxf1j2A6scY4Rk4vrBhkGuWvIlyLV8oE0CLUGy1LarD66KgQhkErxaVvC7F50fh0
	 uO2CrqDyjYMsUrHjaEZU1zU579qwcJOyiWGql+rA0xm4wU6k4Po0qDbcQMPlzP74f/
	 UviKIGQ8h2k48A6ho7ci6FN20x7wW/WzxbTfSR7ShRb5zyF0n/XPOL+iYgDlUWZdxQ
	 +KkZAjtP1q/aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B844260611;
	Tue, 21 Jul 2026 19:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C380109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE4344016B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wx4e3ZzGBXNP for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:53:53 +0000 (UTC)
X-Greylist: delayed 313 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 19:53:52 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CDA7A40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDA7A40015
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDA7A40015
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:53:52 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h4ScK2kllzMlY1;
 Tue, 21 Jul 2026 21:48:33 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
Date: Tue, 21 Jul 2026 21:48:02 +0200
Message-ID: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1b8c7a4d22d92a83ea3
X-MBO-RS-META: emeqgdch66n3tnn9ns91kkc348pccey8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784663313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEju101FdsJrv+OFURuF/LsOv0eQjvVuUToSz41kx3s=;
 b=SQV0oj3Cug+XA4icPRWMBwjapRPUmltn3+aa73fZKPKUtsO5chZxx3RhseIJzFxnd58Ot1
 0uBefx0ODzkmW51RGHBvLV5xi/GBLmM69J7KCjs+LDskiJ0tVgzK6m1dQxZqrxBVN4FYfq
 fAvP7zV/R/ydfoqDr7xub8RcNY7jJJCDVYdYNkktP5rlBy7RGq8JDXSrjrJiPsVcLaUhe8
 vlaH0P1kNYy0ycamPfK69eQ2/8h/qspep5GgEtlBh56NVZzdSrrmWapog3HZUQBxEWZevr
 z/JlQ4rN+JVHq5hWKghkM4uXL0tDYXliv43QJ7q+FbwtdaOKz/1lLXL9mkiYCQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784663311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEju101FdsJrv+OFURuF/LsOv0eQjvVuUToSz41kx3s=;
 b=wG/Jn/q9PtLGC6YdNzOP+jjdDhnC9jIJAfr8JV59XH2DnuIVa0gQ5/2vKOg59hTOEpEtQz
 canx36E1/wquYZNVbiIsVoI4muHgkdh/CcVorFjqRMWt9VBrfMrVhmRQO3zdrsXoH792wY
 ArGtnnBFHrWwcuk80Ce1IWh3L2FYDdGDpA639M1HzEonCVI0NDthsw875UQ9wJZGQCKEq0
 5/j889C5iIikGYzOXEjcSDh9PLusjJ/tJ9UcqX5EKgG8+UEp/x1rEYKdyLaxlv2SieZtzz
 NlCFmIx18KGjvNAFTxI+6PJVcX7hbLfAdaTD3eDIy1Ev1pcAakzlAN8KY2PzQA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=SQV0oj3C; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=wG/Jn/q9
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

In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
the compressed DTs in uncompress_blob() using gunzip(), which invokes
malloc() internally. The early simple malloc is initialized in board_f
initf_malloc() call, which sets up the early simple malloc limit and
offset pointer in global data. Currently, the initf_malloc() is called
after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
during the gzip decompression, because the early simple malloc is not
initialized yet.

Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
use malloc() during gzip decompression of the DTs.

The impact of this change on boot time is negligible, because the
initf_malloc() only assigns two fields in global data.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 85b888d4bb8..9efcd9499a9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -921,13 +921,13 @@ static void initcall_run_f(void)
 	 * For simplicity it should remain an ordered list of function calls.
 	 */
 	INITCALL(setup_mon_len);
+	INITCALL(initf_malloc);
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	INITCALL(fdtdec_setup);
 #endif
 #if CONFIG_IS_ENABLED(TRACE_EARLY)
 	INITCALL(trace_early_init);
 #endif
-	INITCALL(initf_malloc);
 	INITCALL(initf_upl);
 	INITCALL(log_init);
 	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
-- 
2.53.0

