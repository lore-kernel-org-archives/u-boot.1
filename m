Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA1606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=noL45Cp9;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZyUetVQC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6514057C;
	Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77e5FtEJu79t; Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F7E840581
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826781;
	b=An0cYJN4GwYc9cQoy2mmiOjsEZgQtlMVzOQ9zU2BAKiA6D6ksKNEuulAt2l2U9riEeSA
	 05yg/QfuNLDS3SI+G8AQ4HSKxEncOipwNY+m3HFAcJmEXA7ItdhUHSq5L+qzpgAJgynGz
	 oIFcg6jkLIEb8/vq4pZJd3XAWe4uXlThIVdVrwQuogqDokyq6V/LkXMhmeKr+KGiwzGb/
	 obMZIWLLQCnWbSKtfJBXso5YGv5ODr7JMx+4uJxqGTx6AEJAgLrxI4J6mth/K+8V0xF6F
	 yPyKBNN4uMNj+rNQr6Z7iWCOQzcwExhWmlgJMfOejWa2I2msapnhaKdeYBuixPbpVrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/n60E2l9V4vtCmFRRDNlLPXjzDSEkBUl7arc+gsjUHo=;
	b=KQN+0Q5oL/ZRXPfhaqUb+VF6DMBJpANugHMEBJprzhugd9My+59w2ZFN2W0a66/5KP8c
	 1qLATOkk6jCLFMajnG97GYxXBH/f1YHRX1U8F2jFMyyfi6JNLq3lQrP+KESuBwTeN5jCS
	 zdrnMD+OHEN/au7TPHeptfoxwPivU6D0OdDEVrH9oGwF41586iJlzlSnLQq57GoswB1FM
	 CC3WegcTdkpouU7gPJLxZ2rtP/7bRN21Uwos6o8BklPvy5tdLcPvxkfF2Z2nB8aDsw3Dh
	 NCjnEA9XvTof45jGRvm4m2k3wV7j0fA4LXuOwLexRFhBLHU/oJ4x17sueVPbqyCjKiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826781;
	bh=/n60E2l9V4vtCmFRRDNlLPXjzDSEkBUl7arc+gsjUHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=noL45Cp9NUFyWryJtpsTiVq9zqXcERoYGCRw2i0CN0KNSxTqnJ5wC68upu19kLVZA
	 qsqMSZLtA6MsTMitD84/LGA9YflZFh9FVnc278NE7GQ7q497FCKiNwd4VycuKaazGM
	 Fn14bsj0edCWlynWmUVOJuqGD1AKJk6Rm4GELj26Ctn/2cTAy+xYwLwYEhPMmDrab3
	 j/V3tAfBor4HXnObj9yjkRPHCHqJSmhvlBiGU54zsMO4nJ44f8d+r8HzwNWGY4uIbs
	 acHXNrt5rWuXtZB+aUELVlDfxjfddAkALAqsIS0PrffzjZWm/HKNJTh5+2T204RmGs
	 Oe3/4Ki6cAcog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F7E840581;
	Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A6E31A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4823480D48
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ti4dnrGqVYEa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A89580D44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZyUetVQC
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A89580D44
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso37174495e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826769; x=1795431569;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/n60E2l9V4vtCmFRRDNlLPXjzDSEkBUl7arc+gsjUHo=;
 b=ZyUetVQCQ8rxOzsHsIh6YCt7N7kdLY1e1xFkWyBIBVjtvOFK4eaWO8i2ZfjKC+2vR8
 Z7nYqNMUc3Dxc23lI94d2m9ezYVe9NNx55qtguOE2caFoWUXD+S2niNKICdybGwXfu7M
 wbqHN1Cyzop0J0Qvl5oHbm8UkjNf/lbckQ/tceGuNUy1pdlF+WMsXtpsw576F/HM8D7Q
 QFqyslOaagW4sRjkBE1poGZ+sDcCtksWhGS7Sx0M0LOa6HcUYnWAOTsw/qTZMhRBA9OW
 FA1FjH9OqUlUgivl44xiKbmexbpUat9hXGD0vxoUSOtlFIyVbfFqNtGLx9nF+p6N50Uq
 5rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826769; x=1795431569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/n60E2l9V4vtCmFRRDNlLPXjzDSEkBUl7arc+gsjUHo=;
 b=GfhQy6uKG/B3xrAxNgnx0BgH1QSISEeNetcj+TlnmZTgmTLFpN/pxShSA+wq8ovQ1U
 RmAn3E3WrRiq8N05jP/gZOy5oYtg0Avsnbgk+1NyQT4NGtOLVI+1Bv9PoAFwHIdtXpD5
 4mm0uikZIrTQwx6HEvqvDI2FJa3ktCzHaA5In/4InNCQIYfin+QWSKuL+4uTyv+NFzue
 zolhuw8JYgjGRCv29LFVx19HE6fvoBHelr77/cvBTG2+WyVENvVvH6S7Ck0gtvKyiVYK
 UkWNeYDz4k+4+HCNiNSb+gHZnmUQXkgmyArHO035nRHuw3E3avZXlgYqunLBiuv7T9vB
 rY3Q==
X-Gm-Message-State: APuU4Z+LMEAtJE0APtI1vHtYqYk1g/UFDLkub0Av6HOrHoMrmfgMxmjt
 6FnU97UDS8ykhg4vQCUSp/bQTQ3sDiy1deg4eMxp5NYCmg7PPr6/KDmhOQksG7jnsD8=
X-Gm-Gg: AYBFou2L1ie9VAysS6kPG1Okgypv1866yKw6sbWVRyMG9rn9+vRsZpEk5MsRWaejs2d
 W90aZhwB3QqrLPIuo1UD5ybIXxzqjJmcEWOqPfssN6th+9/0EBYODNq40NAV1i2Ppd44CBDWXy2
 Qrf12Q8/cOLys+P4BbJ7U3Jz9Dhd1Dy4y8l1Eye3T2CYhDT+e3mYM/eXRHDpM6o0LGIf7BYDs6c
 UYKVPtK7D3qHADY5wU8JRoHPigh5DYYXTreNF5rRJtU3NWqi8lRgO52vHRdfqaQ5+X0u3WnSPIs
 ANZFBv23e0oaxuBDi1P0AdJ8N5Ny3csatejVNVClid5ZknKHfMdmg0KzhiOWNHbsgxUHmymbMV0
 f/mseM3PO30QYaooD8H1FnU7CynKVENRRFl8HPMqgpo/PZsYCz9Ar/5OIjYYfA8JC5OzcyAFQIK
 TF92m3lwsS3NbY5SOxtVzvO5xs2fLLRl3WL1y7myOqTJR+RY6LkyryCPmPa8Jbj4AzzhIXVVbh6
 +P+SwR3A12eiICJt519ILg/6SCGFpQwRGNWHW3P9RP+TvMT5OCR5kvYdupodiZOsCwWtQ0g6MYP
 ugivWR2Iex45b5hPJghPfOt9WRK9QVJJutNtr8hZ5cJC2aD2
X-Received: by 2002:a05:600c:8b34:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4bb559f7039mr211992905e9.3.1794826768911; 
 Mon, 16 Nov 2026 02:59:28 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:28 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:25 +0000
Subject: [PATCH v3 05/15] buildman: Use mock environment to ignore DTC variable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-5-b6cf7e96944b@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When testing the toolchain setting of DTC in buildman, use a mock
environment to avoid making changes to the environment and give the test
more control over the environment in use. This avoids test failures due
to being passed an unexpected value for DTC.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/test.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 7ee9496ffb3..81ff2716bb4 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -1012,8 +1012,10 @@ class TestBuild(unittest.TestCase):
 
     def test_skip_dtc(self):
         """Test skipping building the dtc tool"""
-        old_path = os.getenv('PATH')
-        try:
+        local_env = os.environ.copy()
+        if 'DTC' in local_env:
+            local_env.pop('DTC')
+        with unittest.mock.patch.dict('os.environ', local_env, clear=True):
             os.environ['PATH'] = self.base_dir
 
             # Check a missing tool
@@ -1038,8 +1040,6 @@ class TestBuild(unittest.TestCase):
             toolchain = self.toolchains.Select('arm')
             env = build.make_environment(toolchain)
             self.assertNotIn(b'DTC', env)
-        finally:
-            os.environ['PATH'] = old_path
 
     def testHomedir(self):
         """Test using ~ in a toolchain or toolchain-prefix section"""

-- 
2.47.3

