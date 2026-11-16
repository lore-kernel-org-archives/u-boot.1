Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53268606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QdWl/cWf;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u5Xya2py
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17C8160819;
	Mon, 16 Nov 2026 10:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXldwJF_j55x; Mon, 16 Nov 2026 10:59:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A008A6080B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826794;
	b=U/9DBtUT6uf3Pe8MNavE6J6WQ08wKMTjGryga7/DLJBaj2VcEgpqFCzn7XDsPDW6rCeD
	 3RK4Pf+EHIS74YZ2gVCzT2Yyjn5uE5EQw+VIwQHtaEaWsHuW1Ox7JSVqbkHgXqf0C1O83
	 Hk+l2RuBdsF8CshpBGnTkq5VoM7R8wwYu7bQbjvvzpCs+VYNNB85/Ut13SXN9q/mBWaiL
	 FrVZZCsoEPKlFPDDgT3tzXLrhrPucfv3B/KVcYmxa/+02c4S3HRnmzpLPy3XWIH5Zo1kU
	 yxHAQzq1qrx2xzeEjqlSey5poNe+wH9yw0rDN86TLuNhWxhz3m99WKk7ulWRBFu+VTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Yx7MqLma75ZpEIC0sWqiA4r8kKWRjwP1u0b+1IUR4RE=;
	b=YZFw4vAgZxfiV19frUYoyywfg2Zd4BvpkNCOYL98Xtad6jSDgOv7sSHrWkfO4TXh3b/b
	 gmlpi3fJ00VokFmuNwCOUJ8qqlWUAX3ZLx09T4z3QXQ007dZFfX1P8RNaFkwPHTBPKg0O
	 XzjZfcVBQvyX1VS69P3MtOYnjkrUHgZbxx9R4VhNjv0ALQcLOfPgqIegFwZuDPMMyKC9L
	 KMKotjHUPlip8InDrgfdlHWcmNuHywPJHjC/YRQgNVM5MvMsIo56dOq5bIHAtelgmcBWR
	 zrGqSxPFY7AR2l2aSD+6BAwcxHx1jioCQ8/zdVJSaHuVWhman4TWoqaIFnsmeqZa0Vw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826794;
	bh=Yx7MqLma75ZpEIC0sWqiA4r8kKWRjwP1u0b+1IUR4RE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QdWl/cWfQBnvwTNNnCYRW72CFVohS5KW1ac1uspamcUXXBKBYhj4rD/wRvFZQV1hS
	 FkGMuFcOWFKuuS7RWNjZ6Si9zfpi8/7kLeVKDpnwrtAB5pUwp7YP8R67+vBN3M8G78
	 ByogHWGRGpiylkIAH9mHmeJSt64KJDqMCL1ilGV3JHAXj63Up3jrSNOARbduqWncN7
	 OKtiCXfnwasGWbQg4eH6KTjfa2ucTihz8KOUyeZK1mztnFj10f72k1TwwLenXifgKx
	 XlA9FynpuKEg9BrgvmwCmWhGOBYJKPKMdwqysrTXLpc1jn+60Apyc5h6KwWbPdqDeg
	 nkGBEDS2nj9bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A008A6080B;
	Mon, 16 Nov 2026 10:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A613B2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C27A40581
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWBu-qoTH9kz for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C4E84057C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=u5Xya2py
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C4E84057C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so19714105e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826775; x=1795431575;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yx7MqLma75ZpEIC0sWqiA4r8kKWRjwP1u0b+1IUR4RE=;
 b=u5Xya2pym+qyvd+iJ0zwSOZdOMfqbpgkHGhvIIS9c0v3RDfPCdwPXz7Y5d2IaRoPR3
 Ukbkjj93pCTxnNdg+w88LCQ7tFGy6dJ/WmJvZFwl9MPsg5vNkxITPpeeccc33NkW6Iix
 OKCEiixSHazgrg1mhBClaJzzba68Q9Csae25a57nsEAFvdLDpx2pfZoTPkB0L5TZV/7S
 +4SRqhkeXo0a6Z/xVmqTnhDboUuHucHILSW+A42r5mIkgoFuS5rZe/196IJyT3NDhfO8
 D7NKMAwjgCc+l+mtgQHXWQcQBYjbOnNdj2zxfQougLn/HK402XW7odLtRF9pQueAqyUp
 ho+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826775; x=1795431575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yx7MqLma75ZpEIC0sWqiA4r8kKWRjwP1u0b+1IUR4RE=;
 b=uoNvIVMk3pftpG/7P+kGkOtSd0pIlUCHWeAOfBlK2fPvsWQ9Kvj6Y7EhORw5LFhPr4
 ZfiygkpkzS870UBfTGZtaLvjLx3vKlNjtx/T0x4RQT+87eDoaJKuyh9A0XdTGs10cCQ6
 Mmg9BJtPzSHd78Vf0VtOtgRF6jDzzrb7YBf1RnDowpXmldtbZkgTsqrCu8z22MrRTHua
 LaLUisMktyKAdrPCuXqkwkMk5iLEDr6uhe65qcpsXz86U3cNPBv0gns7I8gmpozbzioJ
 CpxKYbigJ8kIQ9sdWrZr1CqTj5Joln9BNuoh2iw41xiZs8SGGlvF1UgfKUKlOShj8qzI
 ASTA==
X-Gm-Message-State: APuU4Z9RAUwpSIROlQDZC+Akrgo2MX0+ULpHvxRMIEcAyXyQsBFb59L0
 AzxAUs2O+vRuOfaYaxdZlho3i0a1NpGMvffR1Tg6TqIRf+/zh/VfLA1zjpEuG0hVVXo=
X-Gm-Gg: AYBFou3W7MALaPTXGCPE5L7y/HmAD4tQT5AD/F+VAgwZH8QMegTcf1pWObO/xcU5lFf
 pcz93sXhh7er1plN35U+d9eulqafE8+2rWRHfbaV1vThPo4UnBEXxVE/e9GAZh7ymhep3+Dq4/F
 UKG3O7h32pIhi+KoMPN/XMPxsmK/C3N1C/1/tcXV+9hYGzLc13HgLfmC6RU6/5mXMDr/dkbvfHT
 mfZWOTgvgy1fBQ3oWBm5lL20NqHuVUwCG7C7BXOly69rEIBXHdIydNRQ1TAr7KUMsvVWOtGZ4xy
 I6t7cI+QarpZBi68c6pjSRF9Z+d/gGjsED4ZKoAYRNcQluDYyC0c0LWN9XqqdKCbJTK+rHfB5mo
 88ynaIiCzuQKCXp/ugutOAYTakQzOUXbWDrAHEJYWewRENvVXSRjsxIkkHE5vOAeX+aKFRTxMhq
 pRdwEqxYa21Gun7WJUVjpaIHmXwFq9aS59mtSDR/osKC3kF3SsgvIzYM40m/4BZ2cJYdRKJ5H73
 dmeZuyjKLbk9GwhN5qnw/E2etgiew6jE/ylAPdvZIMOxinNlthulFFosjT9f4x+nBRRJPH2zbyb
 SUjk0MI4KTIdHme+pRGMmkUCCgPC/Wk04yhJ64fyGU14C0Y7
X-Received: by 2002:a05:600c:8012:b0:4bb:68f1:5bc0 with SMTP id
 5b1f17b1804b1-4bb68f15c56mr96653275e9.33.1794826775071; 
 Mon, 16 Nov 2026 02:59:35 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:34 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:31 +0000
Subject: [PATCH v3 11/15] test: Pass location of built tools to binman code
 coverage test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-11-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running binman for code coverage tests and invoked by 'make tcheck'
some tests can fail if they use system installed versions of tools
instead of ones built from the tree under test. Use the toolpath option to
point at the locally built tools so that these built versions are chosen
before system ones and to match the prior invocation of binman. Drop the
change to PATH which did not work as it put the TOOLS_DIR at the end not
the start.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/run b/test/run
index d1654dffb5f..458d99069ac 100755
--- a/test/run
+++ b/test/run
@@ -92,8 +92,8 @@ run_test "dtoc" ./tools/dtoc/dtoc -t
 
 # Code-coverage tests cannot run in parallel, so skip them in that case
 if [ -z "${para}" ]; then
-	export PATH=$PATH:${TOOLS_DIR}
-	run_test "binman code coverage" ./tools/binman/binman test -T
+	run_test "binman code coverage" ./tools/binman/binman \
+		--toolpath ${TOOLS_DIR} test -T
 	run_test "dtoc code coverage" ./tools/dtoc/dtoc -T
 	run_test "fdt code coverage" ./tools/dtoc/test_fdt -T
 fi

-- 
2.47.3

