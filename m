Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB85606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rkrgeOl5;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XPLhFuTe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EEF44079D;
	Mon,  2 Nov 2026 09:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgFYpB33rNHE; Mon,  2 Nov 2026 09:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE8A54074F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613530;
	b=py4K8CpahYNZAbLJg3sP+0r2ntwUartBvyjbpiwHBWXkYdqLA9c2PnjcbNTIyfTIr65z
	 TmGQHk7nq51R4IY17fkRX7k5K2jcvj5z/+pT2dShA5mXetWgtRpiMycLDPZ2Prr1UummO
	 JIJP/H85WwJ9jr5wEX6+AgC8CRRHKQ323UFdERYJrd/5zlWOuNvegSYsFFIC/+kJHq0LP
	 KbRGKKiY7R/S/ZQCCmpzkZQayHwCqvNA087oHHCzlW+Ok0xx3V7+k5Ub0oNBJmWJ2n0Kc
	 Ggcuc28IeGptDjKhW0uzLxkXnDCuck0VDPbHcK6bGtEiIV+VjoNY41+8N820uuz993w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613530;
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
	b=lai/bW0QBItCRdzJ6Htf5iqcVq4r4neiAtJUe0ZVzBd5k/JxU1x6bULRjL67RJuDZZBB
	 EULaLbjxnPDYsWSxXOL4Wi8qAu8Vhiq7gQUOivvRq9GhyFynAjhd+zxefJn6BmZg8Zmaw
	 4hhrZCm+js0Ls0r5FJZTwTX9NMZAWrZFXxmvYTZiSrFeKCHVXdCAylbeOsR5ThEkV6Auy
	 K/IsOmBYs6B+Sc7E2/VL/XegIagKI7wUgX/y50TpvQoIbJQWxYVIynqswnGG2TgjNjCC1
	 MJpOWrhaVPqkDB+JYEoYHIgcNgLnxQqEjw6qVQM6IK7f9ierjBYFrcGD2sjwjEWCgYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613530;
	bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rkrgeOl51wrg8ZfDqcK2XESoJEVw6yaEhf4OQ0Nyo0qPCJ3M/z/HVFeCAbLqq4gZZ
	 RA786bQxtBGUBhOFxbY8vWHfQ4De0wz8GjKhEzIi0uJEXK6P2MgJ1y3XDC5GzxUJJM
	 9MroWrbX+m5r1/fnL3A6w2MHn67CLztndsZEAGw8d+Suzu1aeblfOcazE1Bppou4V7
	 s/LEU12bVIy2carEfnfgaqoct7MRv5Ahl/c+dJ08gBYQ8iafJ2Rbk5Zewdi9cIR6B4
	 bCU+lJMozIy/OsD5ZFhsv1wyHptHcE8JU21UqSz/TBdVmFx+MrA/C38eWbvmJLQoit
	 RKJVihVauksGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE8A54074F;
	Mon,  2 Nov 2026 09:58:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60944323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5294A80BCF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJZPVT8kOLUo for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5983580BB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613522;
 b=H/8XQvfNkdQert1/ljXyjHzpvEfZ9lUwE7Cr0Mfa+jnIgQg0Nf7ZeI4BEadgbHzalYSj
 ZP+R1DfZGrxyejQ9zR6tJN7zgFcp98F8x0BMgiHU6izraBnPfvDe//+ujAdnaczDLyssw
 mXSEIaJrIF5mnMbL3vCsoLT90P12K5NW45a0ls0lvpAmtDCoXc3ic3yOPZaY/ciN6weLS
 Owd5VQyQ/WVb1wuO6yihc4AUCOVDwmJBO1TiQkBP4SOyxEjdrYskZ7YDxajdQ243b3QCe
 20hJ2lbu5zm9aaAU1ewEjV/66ntsL5AhqHZVdLH7flQySxtUeidq2q0zNCQ97sqJzow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
 b=SFgomAtNCOCdKWlZMqp/hiWEi4ibDHO5yq5kaRfAFM9nObwrQ1SJ3SbRX0wpR1v26854
 m5HyJ3MGlzY135vLPoVT8JgrSr7oQepojxkIDs5r6eXeAoOMTj7pZsaBB/pXiGgIGLDTy
 jllogCqHixUw7cA9RwuK9MDi7IWdWIGqXLoKyT0FC1FosKVIO+JYgYGF8DtqureuV29L5
 IYIJ1c3hwH3lQlhD7Wc4371YHlWjyehpsZtfnP3NSqsCqC0ikgZf96m7KvHRrrH4TLGgA
 mWTcSuun/79VjmwKcYvgj95oeOA50JvwhFg+9bHINY4Ji0wkhtyWCARaWdFxymwH8qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XPLhFuTe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XPLhFuTe
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5983580BB2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:41 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1473014f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613520; x=1794218320;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
 b=XPLhFuTeBK6aJa8vIjp3+PEr4cDfNIFh/kE06ztOSpcimTSyM5mfB9ikpgNoO52+OR
 GHKACulqs/9dq888s+FDnBq4caXbMfBHSfS/dyIhhVx38aJF2b1ZHXi9fCeCxQRG11l+
 C2qdKbxQDjPflc5Hy5PPE7lPrgKxIBv4yY5d5OY7/rK05vUZiFrhJ9wEMy3R5oJuLQV7
 rkLQRedJvpuxXUsKY+pSDRUUkDVA8z9nQfFrPUT9LXr3UDqZtmpwFEiCkVJN8AXvRI7+
 hT3uzNO+mzQsX9ATZ2H1P90V6pV0VfK1XzhhNhF1Ua457MJ/A3f0Ug5Vv+MN+XW9bB+E
 jASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613520; x=1794218320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXSkooQBVtPAv0GxXq5vO/jzuUtQUNnG4zjLKvyhNI4=;
 b=T+g42wXgL5jsoYvg8k9CeMjHpQtrhNSA9B9BEssAkb4jV40EUBkal7Lk+mQCWhs4X0
 BNq8r4LsqahZLLvgYcR+OuWkM683MlED2eHZhhsdZvn+lZAjbRuGG0Ln4D+Dt93tIxU9
 KodXgWxLuR7gNoKI8AYMV/P57P0kFsp0sxKJcw6P+0qMAD61/kuCYPayHZfGAYvhUbBz
 bJKW/IPnhTkc5D7wcqO4gwWg1r4gGySlTgZR83usLssX1W+uozq2FEoclG6rPRIEHvt2
 dVoc+M/0DeoGbmzjfHR1HQLdAuYBA1cda9k3TRzztUaaZRDbu6DgS53gtNqdKeEFOYd+
 w0CQ==
X-Gm-Message-State: APuU4Z8H97D666sRYDMjdPXVATmN5G++EO3T/2r8HmHYhFwXKDQ9ypI0
 W6VGRhuAzaZwxsrq0qXQu9yG9vziQG70ZX5WPuG3QpeJf1xDoX9N535yELMEjFLGI5Y=
X-Gm-Gg: AYBFou0bDUukurO1VrQySY5rq9rI5L06wUkx509gUXJ3MPL72LKbzFwSYjepAlACNM3
 BVlHMjCl05z/gWpOnNecCF1BoOIb+BMf7ekt/iY2UimdHXvS7ij7a2TehkKK9408gHZDLu6BZBU
 FG/3kmX+XtgQGlF731TUYNkYvlgxCxQ08q8mYsUuBfdU64tQX3QRbRNne+VrgOLNPBhHztJDdC4
 GA8OpKyTP21B286K58I1rtEYYThVwK7qBCGss/+ogf88gQ6VGFm5224tClyY4oiF3QiCWASU5jT
 /6JVNDYNQHg1okfzPHMs9xu9oGmRdwF3M/hlVCqFOs/XAlJMA7hlNKdDWcHDvTltbYHWdpBr3ZF
 6TKv0XgEhGIf4bgJYOgz7ot40UuC1w7u/i2hfNVoKSAKU/zZHBmRnZzCixXyXiPvTNNDqNx5JG+
 LCh/rq1D7v+vD3tS5CGC4d1rv+6u8aiknjC+hWS9YnOMr+mQeAcLvrXv5P5Ecgn5aaOYJpzTaej
 RFtJXSAlCNAFWUTAYkQKYDzbyNrhIdJZg10BMU34nIiheGjZz6ULAbF5Tg8fuwtSrIHEnRcPcYz
 5i43j2ZCd+Szu0wYd7dqnwQF0nJFd2E/X7C32s2C5x1HxDyW
X-Received: by 2002:a05:6000:420c:b0:48d:f855:d1e0 with SMTP id
 ffacd0b85a97d-48e6e50b9ddmr21117437f8f.57.1793613519880; 
 Mon, 02 Nov 2026 01:58:39 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:39 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:48 +0000
Subject: [PATCH 3/6] test: Do not set DTC environment variable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-3-f1f547c4a731@linaro.org>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

