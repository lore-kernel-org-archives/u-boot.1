Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43472C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59258806F8;
	Mon, 20 Jan 2025 22:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kNpTUfql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838A8807A7; Mon, 20 Jan 2025 22:53:55 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EDA8032B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so135944739f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410031; x=1738014831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRunI40z8jmJlART2HtddoihGA9n9EaPoIo+8acbIug=;
 b=kNpTUfqlSaEJ6L0226oeK3ciN9L/LHec84b8vTxSU2PsOBqjgW9ZPJIfDZ3gjTJUMu
 o0+6Xe2JblUoU74s6D6/iyhgSDnWCJzrm1JaBLpUzssiDWy+NGEzSHpAgvgbPLf91A3n
 0h8n9YMZKjGXuRlEjd6E+C97tYz3KDsTBHyDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410031; x=1738014831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRunI40z8jmJlART2HtddoihGA9n9EaPoIo+8acbIug=;
 b=cjoge3lAk4bCQ4g5dMdXGgn930DRO4N1xQykalffUFMVzvP+STW0gpTwZ68/I/6rPk
 VpIp9GskRaUPNPr6EpibQ6y070bVUjcvNdyhydIQGmWy/mW/S95i22g5PPNNoinRrpCE
 J8GFmjDlJ9It6rRbIKzXelA1psdPZwsxC849ns6bN3A8YwBPbcqWFGUPBSuyV+dZiPWw
 mnvZidN0Ad3S+F+TvJWPyRPgwAPyFr8SbaeOLFRt2HgYMazOaeNsiTmgs/fCcfv7Rq5r
 7kZ9oMyMA4oI+6xWGXK0eDRQYfbYMoxQOVAtLbSR1iJEX1ielX4xVRLzsnedCMtOSWNu
 PKjQ==
X-Gm-Message-State: AOJu0YxUxt4Y0o78d9y/t4kEH3lRlPU5/eq8yA1zPcP+zUbKdDNfAFMv
 Q4BquYfWmsLq8PYRpNN0Oc8rKZXwVX3oX+RVrN3rHFuv/bxXjhpiW21oG76PYfbkuDPAv3ojodM
 =
X-Gm-Gg: ASbGnctrd7+EIdSTonyFwnQDwCAiNdFs2U4+C25fACDzXjHcsxUzlzy/E6jA44ummaa
 EhLITLmY7XfrVFCzGsyAhbrNm192eVwsxtyqq9t+xPWGg0t84ngy4hF5+JHcZavXPU6gghn22P/
 x7AAq2ar8sc46AE7WLSfYvqUvyW52hJ3pRshDmjRrGeLI+JWtjN77WTuS79gWpXRBbGAtOnujZV
 wLS8fZdg3lCq00/kBoCjMmAHFLXC9Y0KV+bUwAjcK+7FV9cj6SJlKZHyfkiSJjQBrE/CdJpNCIG
 qs8wUTs5pWyJnUtUCB5Vp7B6u3cHktU=
X-Google-Smtp-Source: AGHT+IG77MUAqGvEhDeYN6NuO8OH41cBCQ1U0RP8l5Iqy+fTXJM9Gn4NdAk7gX5NagjX+M9rJD3a3w==
X-Received: by 2002:a05:6602:2b8a:b0:844:bd90:d45c with SMTP id
 ca18e2360f4ac-851b65227a0mr1151121139f.13.1737410031518; 
 Mon, 20 Jan 2025 13:53:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/28] test: Add up the number of tests manually
Date: Mon, 20 Jan 2025 14:53:02 -0700
Message-ID: <20250120215340.617194-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All tests should belong to a suite, but if there is a suite we don't
know about (e.g. not added to cmd_ut.c) then the totals will not add up.
Add a check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index fbfdaaae0b5..cc30c517c51 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -233,11 +233,11 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	flags = cmd_arg1(argc, argv);
 	if (flags && !strcmp("-s", flags)) {
-		int i;
+		int i, total;
 
 		puts("\nTests  Suite         Purpose");
 		puts("\n-----  ------------  -------------------------\n");
-		for (i = 0; i < ARRAY_SIZE(suites); i++) {
+		for (i = 0, total = 0; i < ARRAY_SIZE(suites); i++) {
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
@@ -248,7 +248,13 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			else  /* suite is not present */
 				continue;
 			printf("  %-13.13s %s\n", ste->name, ste->help);
+			total += n_ent;
 		}
+		puts("-----  ------------  -------------------------\n");
+		printf("%5d  %-13.13s\n", total, "Total");
+
+		if (UNIT_TEST_ALL_COUNT() != total)
+			puts("Error: Suite test-count does not match total\n");
 	}
 
 	return 0;
-- 
2.43.0

