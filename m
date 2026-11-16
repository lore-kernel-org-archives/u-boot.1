Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C6606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dq7GRjr/;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ByOUd08Z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34A45606CA;
	Mon, 16 Nov 2026 10:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ahf0no2g-LXI; Mon, 16 Nov 2026 10:59:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6933607B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826787;
	b=bDVlp+a/CvhaHvd3/triEL9tKWLGRGE/z6+54DfHetCD9tul3lHuGzlHQITLg8H0Tpd9
	 /JE4u7tNK+LcDCh9rFgO97TiHSOuDpHYXKbWHbKU5/FxAtMYYCO8rGf7B8qTk2qjimsY9
	 WmbQ/1mC9z0wUAbO1RCInBzlMoMjQCTVZXhu/5DuGHdvuzHb/vX88Tjgmmd/l6qdI6k2X
	 UxdixjmwuPOipcF7KTMZqaOK2QRgpFm3eg+U9ZSfs5SwJjNNg26PifthZbyH+QJH3R5HW
	 JZMWUZMGWhXaezaW3TewWTf2jlZmx/Y2gEquw8vjrOJ9T6m5/sJDeBkJ8lW5ZGtsgog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=so8mxHAehSzLtSNQVld7pjNP4nOxYrevBz9WhaYShgQ=;
	b=ZLg6ggz8PsjqScZT0Rsw/wa0vIJi+nnQI3cRlHLdhrOEzD92dr5H7rj/oSxFbIaC73ZK
	 czKpFMTeIEWIaNBQKCank0XrPMeG5g2z+UOin20xQ2xORvqemEuO4cqe0HXXGvVB6Kdk0
	 ERscZhr6qSfe/IoZLsJ0BrSsbqhb0qUNROI4po/h18TM/b/q3WQopwdO2aiGkhsnPSFu9
	 nP9JrR25rPAg+of9rkS10QLwGzJAD9OCqIqdoG9xxVUJlzcNAC/9yA/xI9umoX/mqL+hM
	 hY0tzQmkQ6LlYa80X444nJMW2ur/5XgpFkWOVnC4t+Tvhyy6ULqKtsUP1TXfu+8kbeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826787;
	bh=so8mxHAehSzLtSNQVld7pjNP4nOxYrevBz9WhaYShgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dq7GRjr/Ci+JaDL9qHJu6HbsJ5UlCsuqveYGx2/MZvE8cHx/oWbKgyGdDiTtkEvw3
	 HBvEOabi1zpQsakIsDWj2b/OkA74oDxYN5x0ciILP6HMSEUv9khcOrTUEa+M2ataDY
	 NSxWfGYt/QZYeMCRbPMlerASyrJGq6bBErH70VNk86o8XE8qvUJvutUGD3EX+8F6u3
	 ybx5ZzWj6HQg49vjsHn/NjmYqKxgxEoqJL1KhZdOKz42dn72p8plpFtVaiTenLt2Bp
	 oOb0yVxx9m7HFnPXrwrPyh04Udk4juzgxd0pQiiJUpxuTXzf7YFFvH8sI5LQ1hha+A
	 hsoGzo6wuJ5KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6933607B9;
	Mon, 16 Nov 2026 10:59:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 837884DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A0C180D48
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCZIMchlSBgi for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1506680D44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ByOUd08Z
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1506680D44
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:32 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so35207245e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826771; x=1795431571;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=so8mxHAehSzLtSNQVld7pjNP4nOxYrevBz9WhaYShgQ=;
 b=ByOUd08Zz+J+OAl+A/fORAfdVFcA5eIF2B35DCRrkfERg6gxZFla6lDKgjT3cCUXb0
 cFbMOZ9e11vwDPyyY8OvkuIp6pgH0SukcsBE2WB6swYThQ+q0Q7CqePF2I+sWK7lj586
 g1ArHTnw/YZ+De2VXY0T08koz0YyZwRFctc4c2L+pC8tIZyiFWP+II7Bobwh1uyLu41Q
 RjGnvOIe1l7KYPR3alxezq55vfKgC9VKQ87ZYpLEMERg+Q7VROz5bRyKiP82s8begUr9
 S+eVl0wt0aHZXR8MvUyiS/Oll2S+TVEKVWAvzErwR714hiMbTNXp25znEfxztr/0iADi
 gPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826771; x=1795431571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=so8mxHAehSzLtSNQVld7pjNP4nOxYrevBz9WhaYShgQ=;
 b=vF3pVPYHAXS41Jh9SImgGKwzeC8xnTXK2xgkwELmUgo6HN1DKMaWP6pQsPMlwxXcq5
 A7haNGlBPwbyGz7LhyqWrkhlVmoXG2GuZ4U8a7jwmcgkXeB+JQzbTpIr1GmJQOiqrSKd
 PoF+zpI750gU183fPR87PBlECYOo4kxvkxEyufCljkmu7lrYwgGfl8NYjeuWFYcrUCmB
 3rBejCZz0ojHxq3Ugn0tK5LMWJ0x4qtXbRScjcdvm4lOSH7sjpSbRQdqnDl7lO7WFPxM
 S4/s+Ku611kl2ekCuj6OEJBjTuDAvTrBnhBRWoh4ReW5QxLFvJKt3/WkuXQxfjVMvU5i
 TB9g==
X-Gm-Message-State: APuU4Z977OH5yof/WuFD7nzV9mer26PHe2XZe9AYxGGvMEFqhS2ZCkza
 dTVPAt4cPCcFrY3NVSLY4iFHmxJnknMGLkOvcl3O8sW8gufx3K+mJmxUCsYbaX0AKMI=
X-Gm-Gg: AYBFou2EKuKpB6Reak3uKOpinMTD/9Sig1YDtZg+vyFL8j96BwU+e82yYJ4UtaNYl8w
 CDUbCDZvwkNKOKdKPmwZvPn9RQ3d1fdKPc4niuEcRd+Qy3/h1Aq3l97OvJjRo2OIYxoYCVx1yyx
 SsaLnfu62jfmQ3MEY2Kxq1TkV4rWxiGhvcCP9VjkPmyt9xSyJOMfGI/OJ3csLp3Qei7H9/fUp3k
 yJGJWOVrHLLIwF/BnM9Qixo5nHdLNyE5pn+4+X+o41ivjnXM+lpE99Sj9WUMZJngEsixRXLwpbB
 0To8uJA5Tmwz5c0WfhByJ7LnQcNv/DqXyTDo2uv5QrRnjweY4risQ3Sa0y3IjlDXOwLUn4ncc6I
 gqKWbmNv00Rc5lm0RKrQJaTyWTm7sF2hhoWqZFTd1gP60nYWNIdnuE7c5p8hX8RVNd2kL47BLx6
 KN+L3LsxZoC5QfYUWg+MeQDEG85GNX19SSQPVLlHLMsAWQvn5juI1UlWNCk0miNuIsvQCw6lr+y
 xo8J3tf/ZdOJCgHNps3y54pzHOCHLNQIj/M63m8Xy7ITPW2lTatSASKCDagU+COKWA3wV+1zj4w
 T3NZrEHJdnX/+HGDWLRE2RYETlDvZWI+9M0ZvK/2BiT8t7hL
X-Received: by 2002:a05:600c:4e43:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4bb55a6a937mr211979085e9.7.1794826770801; 
 Mon, 16 Nov 2026 02:59:30 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:30 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:27 +0000
Subject: [PATCH v3 07/15] buildman: Cope with empty CROSS_COMPILE in tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-7-b6cf7e96944b@linaro.org>
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

When the buildman tests are run through the Makefile with eg 'make
qcheck' the Makefile will export an empty CROSS_COMPILE variable into
the environment. Add the code to the test that will accept this as OK.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 81ff2716bb4..1a66e6b2314 100644
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

