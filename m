Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE100606A325
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lz2CvGLY;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WLpHbp8e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5985C81230;
	Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBbmVrXJf9L9; Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84CB381223
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313458;
	b=hkvXeU+Tl6YaOWgIjj+zXTB8Y95Iy0x3lQEepmvdWWGLq3Gvli0MF/kY6v12UnDhR2Bf
	 a2kTk46Uk56uiI4zkhr1yCgEMIdPj25suyuGQ1pKjD4DAoAHVRRY3A2OKWwPv7JwxrBsq
	 U0xZDARMsYiSY5bfHftmOmYTka6vRE4Ta8OlYlRF6TFkbY3U1zP+4s/wPa2mMRy0ueu7+
	 1OETbi7WwYwj/XhYoqnaqKhIypOhXy6/XHIL1cmqhRMm19Y+zDTMvG0gT5LN7hUbyRD4X
	 UKjxu/Ir8s6UogUl872OM6ewi1lMjqvaxhe+C436a9HyfEKbW6iZfUYO1lpzeH/yQMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
	b=YKc25ktsj+oOOPErLP2EjHsUMgYGYxxOdIiAzKpfTsVuy6AIVRRIW4n9tWiq976UgwHw
	 IbqZEO4OheWLGt4yfXSw8OlK/cy172zDGF0oy0hFFzHeBRfjk9IK4vA7lWwaVLL6EU9sv
	 RwwZ+1baSUKNxY6f9lKWOEaIXjzoqla4OsaPmtDGpoejO8C+ACw//516vdBesxncCPZVj
	 cGaBfaTQ6dd2qpTFOMBYt4ffaPWZSUZct4jGUwu4SdmOD5a6/bdO0/t981pkGmxzPTguB
	 KUgVpM474ow9ZiVi2j/AnMefNfN+ZBa8lc9pAHraYwjlsIVRkDZh3cKExIqL4Aghkcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WLpHbp8e;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313458;
	bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lz2CvGLYTgiaXyq/Xa8pkT1wPvzwdHmJ/NlDTwfm2T4g4RIA9QwExSiTi6puH4d/a
	 TNSIg+orfEUyJWA4c1VQyMyFDO52SjUs6wnLCElpNCBeYimUSrJUUYsLZQA/QYmyO6
	 KcvU52L4utSYaEDH4Jy3Q2ISBhZk5/+ywDFzf45oB0m2P9MVBKdoN3qsxWmMB4a3/t
	 loW9Kt2CEEqNLYNAFnPwZAGJLRBEyZtHLAK+xKTqtgP81GLDfYeYEjLC4dsEcggt9D
	 skah/dcPIRpJASSAVabNZo6CzLiiIgkr9FtmMns4BQF0g4lcNK7VHCWs9aiQB6cjkb
	 52OX1zAU+buDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84CB381223;
	Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A9ED731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 707B28116F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7niv8dWdw8Q2 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F94A8112A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=WLpHbp8e
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F94A8112A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso14014795e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313450; x=1794918250;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
 b=WLpHbp8eQoB2+r8AKy395UrGvi8hiD462zFt7sAkRCk3oxlSHC+gIku1Qq8xXzMoTt
 mBqmiRvSpsnpyrDJVzWxzlcnkr2Od5H9JlOUvEELPtVynHRfCMjanXQYR6p9Y5ucXH3N
 t5t4WAe+xagPjGx3oyKs6l1SXqOLKpZNKsDOtolUXgNwZI1C3sOA5pe7NYXPJg4W7HBk
 7TvYRvNz+Wvbkx3a5pT9sn0o/E0n1yP7uYwJow2YWHyjkgiqZSlnvY04EVEG4G0VyXnG
 +yzMUfw9x9BIpY+84qfpwg12fbt81cIgDTszisHES3Dft1jhbgc8+F5j+vWsKNASOT/Y
 KzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313450; x=1794918250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
 b=PKT2OBvIWEEEp/p0y2kCok1+///2ijNgGI/ch2zMykAvD8UJws+MnBIOmbdb4E/XOn
 2ZBCHcgns0aLFH/hpz5iVL/rB1BGq1Vm/5Ap1N8aG2gaCdIgbu6umBfgLZgCjNlOYeo2
 59JexRStqinqXu1qeDfj5+cyXgrnrFVtbsyLWZjeuvSmZihBa3hexO3OFTr4/s0OzaSG
 +x6c6hSUkRdH/3mFFBO+H/4rkiWEisJGHzXmiRaUfascsWHEfXNcx11uhozQV6GG7UFn
 vQbUX8jSAfzanJpzBy4KEzbCA51IPQ1cUR24lnXV3wOV8U8HDJvYji0zecpUIPrOuKAx
 N6OA==
X-Gm-Message-State: APuU4Z+JCNP5lez/FxzUyj5nBirO9Paj2avrVb5lEymNA0vo8PQfpQKS
 AF8IVVSEnkDHkVYwPJ9qv4E6YvRy617D7zFUckW6UkBOH5Upe9TZsOTwkT0OvNeraxQ=
X-Gm-Gg: AYBFou0YkmM1GlRZUMWiGgQfJZ3OKzjO7vbW0SfxrKVSFvsG+iHBqEaKt3B/Ih7p9gc
 itYyAkSJ8QNdR2XPsoGlgjumwpaoD/PWsIgMzg8ZFTFyFTrmcOC4K8xnE5PqnTWfQW7P1ZoKqJg
 kERDYMj8xiCTHNkjrltK19W3ToKPb9flXqTmHl3x8HSNxP5Q/B+WT79WMHZx7DV19WFLZ4IjuqL
 LTt005hu+Agt4RIKETkX+fqYHna36zur507sf4Og83aaqWFslduwVPfaNjQIuZ1be+cJKJcPzcn
 t8aIpS0EdeIUE6Ce8VfPoVR+awTiU74OHe77YtNLql/XSBbTdaJmY9Z2GKP9qKuvMqEQYQi5UE0
 M02KG1UzIK0U47IRMjD53NDzOeamG8bux5DY/oP8s7OruhZl2AEGz/hNHlLmQtDHzXAno0OEvKd
 KgUrWG0zOTUL68GPuFycbUfhDSLHDlmYC+V2a6+A0kFqEfV4Mz4L5wl7RNjpg1r/sI8W0rVfJpO
 Eh0xXgrEe6YsrmZOYIyYtLlsYP88/WTnyw9EF5AwNSv6ExcX6nTv2qFb0fbBPZRxplmP4cnswiw
 BoSZa1E+VSyQyqT8W0JGAexXYgcYzh9ENDFMfLBTzuEL/zRr9A==
X-Received: by 2002:a05:600c:6291:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4ba0234ead8mr42029185e9.22.1794313449912; 
 Tue, 10 Nov 2026 04:24:09 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:09 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:00 +0000
Subject: [PATCH v2 03/12] test: Do not set DTC environment variable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-3-1c76e0b68f29@linaro.org>
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
 Quentin Schulz <quentin.schulz@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The presence of the DTC environment variable breaks a binman test that
attempts to execute dtc from a temporary directory using the value of
DTC but that is a relative directory path based on the source tree not
this temporary directory and so it fails.
It also breaks a buildman test that checks the environment and asserts
that DTC is not present.
Remove the setting of DTC as it is not needed.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 1 -
 1 file changed, 1 deletion(-)

diff --git a/test/run b/test/run
index 7c0263713c6..17e78815fa7 100755
--- a/test/run
+++ b/test/run
@@ -76,7 +76,6 @@ fi
 # to tools build by the build.
 DTC_DIR=build-sandbox_spl/scripts/dtc
 export PYTHONPATH=${DTC_DIR}/pylibfdt
-export DTC=${DTC_DIR}/dtc
 TOOLS_DIR=build-sandbox_spl/tools
 
 run_test "binman" ./tools/binman/binman --toolpath ${TOOLS_DIR} test

-- 
2.47.3

