Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918E8D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADA489157;
	Mon, 28 Oct 2024 13:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UsAIzcew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408C68887A; Mon, 28 Oct 2024 13:42:11 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630548914D
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso538165666b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119328; x=1730724128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MviZKgIVve5rzj0BOvSXOcRXS/Z9mk03NhjDseRYNyU=;
 b=UsAIzcewWbycgYRBBmzpn7QNDfRU6QLLX4tnpnNqAWLZkNYLf/Vii7yTRpZ0rtWrmy
 g96QcPWqu9c/FyhN1n5IGScfmlJcO4xK9DhubUiUgtn0Jvrj/Bmjx5xFkb/pLKL644Vl
 HDdYT6AIhiF3mKSolfIRK9RtkeC9Eva9Gm6sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119328; x=1730724128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MviZKgIVve5rzj0BOvSXOcRXS/Z9mk03NhjDseRYNyU=;
 b=pglrVxmXKg2PsqKrcCsHoNUoz+jEaScdQr3OorMdYlGFx7rii7Eew6EyffdNuzHuPC
 XTLVuFwM0CN/Hxt67kS9wN2pqlJ+fUgkGQjcRifuU2iqpFqilsX6f5qi5yzsjEiCJHX0
 BGFm3oWRsBEkrscNTl+OAMwGmF8bPiMaynF/i1ooXpdiHKQJ83aG/x/EalimhKj4syJM
 VOG/jgEGTbzuhPNryLybvm8ZMP5y+Dd8vpmOF4M2nL1fHGCVfkKm1XogrQVhrPaGgKvs
 k6O6qzlMJm8Ka/+aAkaX4J151vI9V/cCPV9iodVJW8eITR5qkZ34bmKl2m6TXHHfJc4f
 3fww==
X-Gm-Message-State: AOJu0Yw4oDC62ODF+dkh6LJLaa/hqDEcNw6v6v/ln2U5+4cx91mCjsMD
 wTVJYWIxBUh+XruToeS0OJhZ4Fq7OaYeFQ/MEN6HG/UwHW6gJ2URFwyVZRlIGYwCPc5pr6cfT4p
 Inw==
X-Google-Smtp-Source: AGHT+IEQ6VKz+OxRJ5n5aI7Fr1VMz6tNcGUnghq65nOPCBoZQJ4m0NYA4hOXlBcfN8N3k+EE6BM96w==
X-Received: by 2002:a17:907:7f12:b0:a9a:a96a:e280 with SMTP id
 a640c23a62f3a-a9de5ed3f84mr590739966b.20.1730119328418; 
 Mon, 28 Oct 2024 05:42:08 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/21] test: Correct display of failing test
Date: Mon, 28 Oct 2024 13:41:25 +0100
Message-ID: <20241028124130.32072-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This should show the test name, not the selected name, since the user
may be running all tests, in which case 'select_name' is NULL

Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index da5b07ce00b..e4f42689da4 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -622,7 +622,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test);
 		if (uts->fail_count != old_fail_count) {
-			printf("Test %s failed %d times\n", select_name,
+			printf("Test %s failed %d times\n", test_name,
 			       uts->fail_count - old_fail_count);
 		}
 		found++;
-- 
2.43.0

