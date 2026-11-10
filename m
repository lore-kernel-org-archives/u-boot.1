Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E954606A335
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KhMtShZr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jPmWWX76
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC6B81184;
	Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yT0K6aW2HY0m; Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DAAF281224
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313461;
	b=fk+gn2gm30e71LMF73NIZJp8wum+Pafq/VKRGVCA0PUc+n3swm+hnTEsFzdP/i6nI/Hq
	 mEhXGut5ll30ISJ9WSbMVGNS2q+ZykadeAvGhyzfuahtvUBXO+m/DKxvdd9DBMoR1rwHi
	 UeKNZn0RtA5fElrq/hnjP9xLkT98vp3dmVp3ga8ddq0c7gb7dcUhfeEOTWmchY5Erhreg
	 kLj8443gAHNvs9gDJ7gloP5P/34/VHafxSsoh/pALZcnRzZ0QO6y8a3QqxbB8zzg0RTPb
	 coJ9QwLtAH+pLaTfz5PyPxwwU0CqI4tP24GAYi/PW2+YBCyIVgdTEIiLfrh3I5Lu6Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
	b=AO97AdqZ7YAVP9YrNlDdewuI/+H2YGqAKWdpqWTrvlLvOR99rWOkyqGKbdDiiHXBRjpe
	 KOfWpqbRHPkjqUNrTSOkmx0F2F54yP5Iav+BgVa0FuTKEX5ORx3xNDa1mx0niFg48Xuoo
	 nNHtyYtcAQRAhdqnx0MDsmaTyTn4eivXGxx4+tn279ngr+Lh55X6/OY+oX0s3tT5uv0g0
	 xO9sU4yeSV+OrOf3WXglji5WYV7vi8aZm9In89nUBPFdzt0t0Gcr+QnUyC3nPuP3rkJnh
	 LQT23d3qc/1s2CXa/grwJcgHHFje/fQYzwfEqdXf4zaL5hPhUNmy5YRaWOO5ikTRN/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313461;
	bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KhMtShZrnzzUme+ToO67nRQ3vU/oO99PlvHbMKl9hYkDTZcnn/dGQNoPVfG5DF6xR
	 BOiTRwvfiac+/JPYslEsnrtO6yqZyy7KtRQL6luQDjPkpLtRHkhfsOjkYyHbU18nCY
	 myVoJmTFf9Q9OAmSiJMv/T15BX8oLiYWbdBT3qNLHpL7zantMU3Ta4ddPK1r6tSLLs
	 0XMjX1s1mzFJmm8TMPqYL+3DiLgmvFvtUEHrbx+PtHnIvWvJmbDJrNr4sO5LzLGXSu
	 LQ98KFTnoeKZ65+GpzihTc2VhV1UCrI/7ppWxC2dUZ0WEXFXshattLhB8GgnkgBS02
	 jJOCMmLjiEWbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAAF281224;
	Tue, 10 Nov 2026 12:24:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C46731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B1A740356
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rX1U4MubVvnh for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 458E040176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jPmWWX76
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 458E040176
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so22333255e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313451; x=1794918251;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
 b=jPmWWX76Jnco5dK4txA9prMHjMBZerMg3UbqOuAhKAuP2ed8ozSRLzdqrGgpk0GVOH
 ux1wPHnZ8nDWERqDbG76fuCren/Ku1nPumQPNegT6RNMtVzPbwiT2OFK0BEa41Zou3rf
 Qa75rLX1c+ubmbYowBTC4RVeSee1C6wi2uU9LdOFjU27ovXLF+5+OnAo7tfAJ2TRKXMA
 ZiyNyChvTHoWG88DSgfYbQdFVDoKOcDl7pspJgXlIyxTjg/IqCUT3R2nhe10FthgwNnA
 atuZjrFEMbrzHU0ofSxBEZLbUvLyRabvTg1+IXQjbMwglbLD/k3biGY4FBewORRYBOZL
 bRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313451; x=1794918251;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
 b=KFYWpJEDh3po74GLHjftF3uSAfnehAuhE1CPyYTm/XWJyd9KEhoAlgyWTvooEZhOl0
 rkiytg85MN10AW45/qSa0CyvSAs8yx0JhMoMuLog90itO4ZBWppp6PgRY5bxEU2y/v2P
 JGcp9xdrDHymro57yjXko/xXCGkyTvyHI8TUoYZZBATpb+uheuwGXkpju/LhFukYoNMX
 SgA9hwufdfPAF4h8RBa0QUdQpyGwIHmMbvfQUyjj7BgIhmqUZzipkBlYuJLkPmRVXBT2
 4JBOuwZ3uhTWHtAkw+9U5CQ5Lt77QQHrTBX/KPUq2tfJ6gCfOT/pO4C7pNdCayOAKXTS
 j6hA==
X-Gm-Message-State: APuU4Z8QCGbQXzgOpr7RiuF8wXFYiWlOF3hKZJErdwxZZHcwwoAnHiwp
 +GL92WJ3vHATlcFOanoG4R6u0vfkjZDXBGgOI9qmxjM6KemJn5ODVoqk6zvYrDecZac=
X-Gm-Gg: AYBFou3G0821ayANGvGMMqFiZr2zrZeSvSMh96eaxUjqj4uwZEHnRJIZZB85C2bSYhy
 IyezD71jaOx6tNFk584IWwRbWLysQmZCZPgApYvyNupzc6eePGUNjb0giYPiGPczsx8tb0lOYau
 g5jGcq/m363NSEdNSl3w9iRKEJzyOr6s8Bf5TRnv+NKW1Yz3AO+ovXXZJfy/KphXbXxmrQu1ejW
 xWHaS20+ehBSx+bEevTQWDcqBqnfbUF46GiQq1zyzQt9leZMH8AlwODhUa6CWEeIwZ/Zd+WvCK0
 SJsMUyqZjAfTyRpiyalvKl/KegNVPi3D1gmRQAoq/df/AGYUfx9ivD0ae2+aXWNlPldEzB4JEtp
 bwWAm8ZWnpXIvK7pthptp2EAqSGgGToiYy74P4pHKp+JtgFO4axSHAHzlI1GT1IoA9tzK8UWRkc
 IAt77uQpxu/g3M4YX2xhLtTbWUjUyw3OcP8Yst2RARBhqQWq1fFk0q5f4JYqZyvB1rz3CuwQ6QZ
 yu3+yLe2/3PtjO1aGaN8indrtsrfKycOH7Q4InhqQW0XNyJd7YhbXzrmmkcIdoclJmVDt2jidVI
 nGf5f34ea3ifzPNfLnoL2qDbtEuCIQdaOvvEhsHvIwJx0CHf
X-Received: by 2002:a05:600c:4688:b0:4b3:8529:eb27 with SMTP id
 5b1f17b1804b1-4ba0234ed9emr42290215e9.27.1794313450913; 
 Tue, 10 Nov 2026 04:24:10 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:10 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:01 +0000
Subject: [PATCH v2 04/12] buildman: Cope with empty CROSS_COMPILE in tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-4-1c76e0b68f29@linaro.org>
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

When the buildman tests are run through the Makefile with eg 'make
qcheck' the Makefile will export an empty CROSS_COMPILE variable into
the environment. Add the code to the test that will accept this as OK.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 7ee9496ffb3..e620a92126f 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -656,7 +656,7 @@ class TestBuild(unittest.TestCase):
 
         tc = self.toolchains.Select('sandbox')
         env = tc.MakeEnvironment(False)
-        self.assertTrue(b'CROSS_COMPILE' not in env)
+        self.assertTrue(b'CROSS_COMPILE' not in env or env[b'CROSS_COMPILE'] == b'')
 
         # Test config with ccache wrapper
         bsettings.setup(None)
@@ -668,7 +668,7 @@ class TestBuild(unittest.TestCase):
 
         tc = self.toolchains.Select('sandbox')
         env = tc.MakeEnvironment(False)
-        self.assertTrue(b'CROSS_COMPILE' not in env)
+        self.assertTrue(b'CROSS_COMPILE' not in env or env[b'CROSS_COMPILE'] == b'')
 
     def testPrepareOutputSpace(self):
         def _Touch(fname):

-- 
2.47.3

