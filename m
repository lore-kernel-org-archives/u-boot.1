Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985D606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RRZEmOC5;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yED75xLE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54020405CF;
	Mon, 16 Nov 2026 10:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2ctIVKyxFmW; Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9CC54057C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826774;
	b=sAp/dyRs1aKOqkzm3XgaX/hItWvkGjKWUcrQux6RaBmzlogpRSi4s6hTO07+ZhtEJlou
	 WStx0dBF/ArzZQBqryhlBW51ff/Pd3v5PNA8iNe5UXhzsM6YFxHnaZlVvCtbTFJiExR6k
	 n8zRfcOTijnj4aaIP3hQrBRK0v8lr1QD0Jop96cO8yB3G3V1DNu/WAMG7sPDsU3InerB4
	 VMaSPPEbYcgNypD5Birhgt0rOfCn664fzci/NjXdDymaxcdNUvYs5WLqOhKZFBZQEC4IP
	 GZu4WHcyGabfd8hMQNQui548qek9BVRAN5boNfnYynV1P5e+xIIU/5Wp4QQ5f9nmUJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826774;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t/6mMxKjERAiGlj++S50BloqX5naNjwr3Vd1kKZro4w=;
	b=OpoSO7U6P97yG8qa16AfPknXaAJAimpZtu7rL/23g/ee2QQkXcgPzJmdzP0/cg+PfzHe
	 xsis08B7uBiyIS1Q1jYhudsHe5pugV0NB8mzPHCx4V54+UDr+yLsj4JJP6shO7vk/lXKj
	 UodsViA14ix+z/OnwCgnSf/nV5fMLRoZiUZLlCPNodFsD1djbXlrt/cXldDjCcuIvWEmD
	 Y3oLpe3fiNXUGz5j5zE3X2aqwLzMyKPBWzjGnXHzHJIUvyE/bRh3pQPnZmjsY+9j924Mw
	 JiaVvTjdiK90uMig+ivED7pa0Q7lKuSf2606I2ZmI/gXbDQuGXk+jBnu6XDQlKexDzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826774;
	bh=t/6mMxKjERAiGlj++S50BloqX5naNjwr3Vd1kKZro4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRZEmOC5KartiXup7hXzhuRC3iCnzqhob/FYnq3ooBa1WjCWxuLYAKYs1ya4nwAFI
	 32E9QAPhNwFe4+R3RP90Cs58uQbXwSI1+iOieLEgLE78QDj4uSTFcuQsC1mODu+W3G
	 K0Hw5SVmtibOLTFpmn+2CPCY1fAQP164xiFBdSXgAJ1DLh+BI3g/V2zxHhNDm8QjAy
	 ZaFNfaquH5o7Jrqxy8Zvig1lr7m/dVqhpJ6IpkmLWnUu3IqohUuLgjNZEePz7Dea4/
	 H1G+F1BECLlfQ5VnaszF6LgXrXkWSFmSbifQ7JdhML2hXgWAa6c9GbSHzNcrOpfuYz
	 F2VLV+dydlXVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9CC54057C;
	Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AD1F1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0090660738
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BS5hbY8E-Cm for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFE4760635
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yED75xLE
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFE4760635
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:28 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so27103535e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826767; x=1795431567;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/6mMxKjERAiGlj++S50BloqX5naNjwr3Vd1kKZro4w=;
 b=yED75xLEKnHAIIBnf2AL+w8eq7sL+8cj+JM0+r4rL2mSj6+Qo/eNGC0BCx3Vdt8Ng1
 zLlp7YkmgOxv3VGWISX15PIbA2r+8GDlDwu0GW5zSCNDodDtdXtlpDzKgacVBVb12wgQ
 gt1NNRx4sFEPssjyneq8eHkdWtqVnNlGvLc584PH1/4h67UBrbzl2CWVBAS4otVTkbtW
 O1HBelA6tgkyrDmHDYtJoVIToIQvatPxcsy/COvDN8TCD0b8HSkn3TrBkn5ArSfy6x7C
 MZcFT2DfpbZlRaGmIFE8XZd5ye2TFM0Wzc49d/up0i38zjqd46qV1ZfiBTKksiOhXisk
 oHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826767; x=1795431567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/6mMxKjERAiGlj++S50BloqX5naNjwr3Vd1kKZro4w=;
 b=fuS7hPSKi3sV/4av27HDmPD5P0wogg6b5ey9c7mKP3ItxOxd1x6mqaNG/Cuy+1fyGt
 HmQMY+hkgPnBc2c6VWGjF338w+0M+oLz6BP3t0IDHGHM5cXYdJ31WcyhAQ/nUhNtcCLD
 nyFvVIVdiC2o/GrGfNRn5QydAsWLJsRsJqNkBlwn8Dq1lckGH/PogFUGvhLRFo26N6y9
 ATx5t3dS1dkkxG+liqpgzP9EMNoVv7LzaODhhx6GUk5v5uqYYFXCZBcculAisSlbcF2i
 t6yfIr55ZEg+xTsS2m6wqdwxiMzC+acpGY0woxgZYktbTwrttmh8w4YZmQ4sR9QXrwx2
 9v9w==
X-Gm-Message-State: APuU4Z9mG0oIumC2cJlJYXZcfRcBZ0D5tBVe9rpv2C++IqxkNc3Ev9xj
 zpi6hpFrBYt6cYgJvU0eEN0umM99C+ogDQyk63UllaGrLr0KiO968f11mJe+q3jVI+U=
X-Gm-Gg: AYBFou1QAkh1bIZIQrYbKWhh28JEcFaOI756o8QWKBP47Wz9hCRQRipt0yBFLHZ8bxC
 dRA427pcuMIllH8w/LkuI2dhjMJ64yYbKjWUrfSBMeaHSZJEz7adWjWjtanAXjaqRUJH2k6AqBU
 Xnil533WXiEqnAsd+kTMXQfU00c4Utjc7G+ZxHMOMtlxnls+5iPSz88DEojcI/Pta1lYqe59k68
 +s2MGwYaggXG2o6QbXvE2UXUkHvQ/te3LJsMUlOBWo/e/5q0yMvbAM1Nc3RJeIEvvyCfb7/VMgZ
 Jr5YmrKbF+l6CxPNZCnHsKLs+JOtrj3kRruFDqi8iCo9V+FcBY/YX/jDCTwjXbd4ly2QqusPvYv
 ASacObopgCBxs6MB+KhBeyV/EiGx638kfQtMeHtp5DDkNKDItHuoagoGQMfno9jE1PucBDa4Y2f
 BYxm/vfgtc43wjrT+yedFoKZRpIba5prFuUf5bsksKzIbr7ajhdUr/zx8uzPWb11V4K33Y97mnv
 AFLp4HKi7eoTPOgYfRl+e6FAwi3hUW3pEUiaSdOix+QpUvHDxWw93bote3WCSHhJ9X5No5JHneC
 soD4zb+ICW4g+AlOuNcQNSAapniXydWtZU7mYCl/9aepKxhZ
X-Received: by 2002:a05:600c:1c17:b0:4ba:4395:56c9 with SMTP id
 5b1f17b1804b1-4bb55abc204mr252891885e9.26.1794826766820; 
 Mon, 16 Nov 2026 02:59:26 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:26 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:23 +0000
Subject: [PATCH v3 03/15] binman: btool: lzma_alone: Update version
 function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-3-b6cf7e96944b@linaro.org>
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
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Simon Glass <sjg@chromium.org>
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

lzma_alone 24.08 now prints its version string to stdout instead of
stderr which means the current version function will not find it as it
only looks in stderr. Instead look in 'combined' which contains both
stdout and stderr and so will work with older and newer versions of
lzma_alone.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lzma_alone.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index deba3ff7677..ac346cbca12 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -116,7 +116,7 @@ class Bintoollzma_alone(bintool.Bintool):
         Returns:
             str: Version number of lzma_alone
         """
-        out = self.run_cmd_result(raise_on_error=False).stderr.strip()
+        out = self.run_cmd_result(raise_on_error=False).combined.strip()
         lines = out.splitlines()
         if not lines:
             return super().version()

-- 
2.47.3

