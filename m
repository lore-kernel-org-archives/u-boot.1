Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE960A260F
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gtb5j8wZ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xAMVVmK7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8676C81206;
	Tue, 10 Nov 2026 12:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBTkU_fKTFjk; Tue, 10 Nov 2026 12:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D225181224
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313465;
	b=P8V/LKZGGfFA2sk5Im6WpzGDCveVQwy2gasIwLhalGq2jGymgPzZMzEaBHeSk+wmKxQI
	 hCMi8I4xrhkZuDBWHjJvRpregsbozSiAm1kLYZz0sT/33C/7DtWTbdGECZt3nywVOJR32
	 vh2tbZH8unEO5Y9bm4ejlt7lpys/1NCF+ixr4GnI/jBsXqyCD/Gnk8fRd2nMHdeG4v2j1
	 oKe8epAeV+wMqKw+kGi4KVwhxr05UkwwSE2BnjEXWpAO04fUU0tkVbj+AaKP8jAddnZfO
	 Yh/996WGNcMUEBjGB0N/eG1GSCIPBeF0+iknHoye6zXu15mHB0bkWjfGquARlDKctVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FyZ6oWSgtyjcjlJnAL7tMmwQaPzjeOzbQ9DN0OB1398=;
	b=MwC1SK8rxPjxchAGkcHvZyUPh6B8Z+ttX8gfMSbrHpcks3Svc/DtTd70OsAsgJwpdp3T
	 RWeiUJTYxlQ7iiOK5zyqIT5B3u71qVwwS35dJeLAntbre5PqsLfeo2EY4aH2R5VciUX14
	 jSOCuXjK1LDntgt0NceOv6l7dfHFZcqpJRsfj++kzxLgPFzRfZtvq4jTH8mEPDPzxMvSL
	 qZajrZ6WGXe+rRP2Xchk99p5W58lfgqSFs0hYG9FNSgjx5y0UNLK/9Wb4FD2yLLB/B+2F
	 pUPy4UrjwclPHeXagmd1LCSFYfdWzTbuG5nvPPyrGW5VHMuB6UesJx2Qdg3EEndpOSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313465;
	bh=FyZ6oWSgtyjcjlJnAL7tMmwQaPzjeOzbQ9DN0OB1398=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gtb5j8wZhvCC75TG3M4BQpmxo0oRV4PRpsWKw5Ul31i5ywUCU0QvkmyVKAxv1Xn33
	 17mbuOyxWows6OsNHqdtbxJ2MogjMG9Pi7livqnbSl8Zxf6513SM4hb+ythkxnpFc8
	 hVYhTXxaOIHuejf0D5AcMZLBozjtJQXDcMVPmQq/LQSf3f4kQlN5jazBfMR6eReqFC
	 4+iHhk2xXmFLzJgnHDb+LKmNDTah5SIyh0oOFvKNIh03PGy4qBbsHQGQWrpD102qVv
	 4gTraReL7QlIGlriV69Orrp7+XYs8zHEC9pWIhNA/HbajoyVPo9nStuCBtspGjkC5j
	 bItC+LUI3u1eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D225181224;
	Tue, 10 Nov 2026 12:24:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FBA19D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 555B66085C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Ul7yQwCBD4P for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6756E60768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xAMVVmK7
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6756E60768
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so19306835e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313453; x=1794918253;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FyZ6oWSgtyjcjlJnAL7tMmwQaPzjeOzbQ9DN0OB1398=;
 b=xAMVVmK7UXoeXiuOFwQyD/N+od+3y68Dn+8wWAgWgzHoFv9RkYGNWRuYzTyrS2hwKw
 Covr21qsvsIFCXooBR2lnf7A/Ku/RbvGxWq/rkIrIzhaUTNce7E4dpzohSBRGwfZIYa6
 NxP0n7hSd5UZHnxqTu75zPl7ImIWJREJKmriZc5eqwXUuNidSr1OIh7jIVtJI3eo2h7u
 L8O9capP+HK4Mizm1SskSMeeICBReSqNCeuLT/Ldq4p8Ywy4dfRGT0KxGg7tutKkrq2G
 +C77VH9HjY+9B2wwl/Ppprk9pRO5OfIS62HmzklD/AKtbKKCdhkJTr8uDI1mBsC94TGr
 K9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313453; x=1794918253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FyZ6oWSgtyjcjlJnAL7tMmwQaPzjeOzbQ9DN0OB1398=;
 b=J0XMcFc4ORAI5C3q8OvvumDkI8nj+7FsSrTHFehE1h0IXnYiV+O+hzpuMsWxRpQXbX
 geY6+wmvbWfVX033mpDUDK+ifiIGXk4o3beyPwmuda+zTveCRaiV7ntuPH1+hhyhtCWW
 lyRPm2eEF/ZXSFw0bg5iNcJihPBsOpnJaguZ7a2lqATiO5dBSyrSzxgPET1acGPl9Ipr
 PYMwHJ++wdaHiuuD+ZL1j7YouW0G3P2/bQ6uWh5GwsyndM6/3qQvwamMvryKiF/vbNO8
 aXD/cEQzKAMwpWK/sbHl/nKXLADkSwi+1owLQ/WUZg3w0cPdPH/i9+ZAkkYmz99aYG3J
 tuVg==
X-Gm-Message-State: APuU4Z/hd9FYgxM/VqevmPDGfX4MZsrFIrzanID6Ackr/o/bKQvHyqbl
 m1QztRG+md1SYawoNY4evkX6F6xoPr1NQ3bHB7BEoKLy1r4+BSk/Xu4KGzIUt95IXAY=
X-Gm-Gg: AYBFou25j06tjoIUwRVyxcrZXw26ESiIoX3J6L5EXVLrbgVn6Oyn011lDmh4cnYs5xN
 iKG2WJNSlepTSXI4ndNl+IqspJEzgcOi+UHtbYljOExrkKZ8IfZkdNKKogYcqJK770DH/eFxosf
 748BUcEE/WBEajGL2FCkcQEG50yYC6QogZAfOyl2hH+HppowTHuHJIxAo2jOBaCtcEPuvkM2dkb
 4HoHKjYAjQRbNHB1o4696Cp9nm3nTSv9eRUrWT9+m7kWaapOhYtqRJmYQaegYwGEM7wtvXzYoGY
 kmRqsdodbZeQXieJ1ZRYLs2dDNX0SyVFFpMBJNWHtQ1I8NGTRKyEtwMzFLAgdTuyg+DKdgO0MZl
 CiCFml3AoLtuws4/XFmSKf+bQf92ulOCCVIVX/IJO1QrC37S/u5ttQqn4qEW87X5TtmrVMEUphy
 X4aN+mQ14uN1FGgduRao6xWLKXnYnW8282SLYrFl+8fa998Vyky6RcQ9wWxDWGkSUABcrORR3KR
 F07/MW2AuHcYEzZFfB3lL7bQf3TREwDDif207mCsQAIDhVY/zJDQLNflXmtG+CroNbBAm16p68G
 ADavYmogP+83me2bkSooHwCEbV1iVf72sn4/E4OJ3Oo9LHrM
X-Received: by 2002:a05:600c:34c7:b0:4a4:f48e:78fa with SMTP id
 5b1f17b1804b1-4ba02344f3fmr37399815e9.12.1794313453010; 
 Tue, 10 Nov 2026 04:24:13 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:12 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:03 +0000
Subject: [PATCH v2 06/12] test: Disable running event_dump test for make check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-6-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
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

The event dump script does not work on more recent versions of binutils
so disable it from running for the moment.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/run b/test/run
index 17e78815fa7..d1654dffb5f 100755
--- a/test/run
+++ b/test/run
@@ -15,8 +15,9 @@ run_test() {
 
 # Select test attributes
 ut_mark_expr=test_ut
+mark_expr="not event_dump"
 if [ "$1" = "quick" ]; then
-	mark_expr="not slow"
+	mark_expr="not slow and not event_dump"
 	ut_mark_expr="test_ut and not slow"
 	skip=--skip-net-tests
 fi
@@ -32,7 +33,7 @@ if [ "$1" = "parallel" ]; then
 	para="-n${jobs} -q"
 	prompt="Building and..."
 	skip=--skip-net-tests
-	mark_expr="not slow and not bootstd and not spi_flash"
+	mark_expr="not slow and not bootstd and not spi_flash and not event_dump"
 	ut_mark_expr="test_ut and not slow and not bootstd and not spi_flash"
 	echo "Note: test log is garbled with parallel tests"
 fi

-- 
2.47.3

