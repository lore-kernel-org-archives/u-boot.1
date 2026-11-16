Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ccebty/p;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zbf61EkD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D7B5607A1;
	Mon, 16 Nov 2026 10:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5NnC4jqAkSA; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B882607AA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826776;
	b=tIiA0s/yLc1CcZX/39237OD+qXjd9NrneiMSibWeiMMt3WzPNCIZa+5lOZ2HneFb6xKT
	 UwQw44RBwRN1kNa+NeoYJlUgFrq0mq0ty4tOKRNJ2q17S4XMoE1hdedFhqUSmWY4ormr8
	 K2S6erX/8VJes8qqpsFUlwUlUCOdgME2c0LiHN7u7nDLxnEAFKJ7LiquptNBzgpLovT0a
	 579Uq36mtHjzDHRPIailc2NKm1BrrvfihvW/DiHexVEXAiFg3EdLgLx5KCVZW3ox9dm/p
	 3oxDEM3poYFVujgxSVyqhBWoL6/6YE6QYr4KZhzBMwfaEPzhX8loTACIsazyaGtxvkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FrI8YLPestmuAyhxOWxRjlfKXzfTGOtODXPFUWV/RCQ=;
	b=M2lgG4c2e4Ef1C709RgKcoIMb3Z6oW5CW/o/PkbHBznS6psQjmRyfxeQdiLh779REpzG
	 lV3VQCHIgpIEPzTUYWNkReLUQD8m2LJHYfuUzOHpohsLQrYf/SUP+uNUvj/iLEbTqjm8v
	 vm1WL+x7zRzS25ZERsbO8BxxMqz+y94r+ryK3+mehDr6w0xENooIsphOZOy4gslHwrKxE
	 yE3gHU+AgYkj8S3jBm+c5wdCfhX1hkfIJFBaXuc9OzWqCIBC5C7/+XWHIvw+wXg8jCoTd
	 8Fnt0ZoyTqxZhnBF8Q2y5pEZcLhzFe/busCbmfizJVJO8pzkJsk+wJZw3ayTq1N483g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826776;
	bh=FrI8YLPestmuAyhxOWxRjlfKXzfTGOtODXPFUWV/RCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ccebty/p1SMkiC5KunlRiePcmG2HSj/fW8pdEdZdEkCy4KlHZ8aX7CJk+StALpaKU
	 nQanq717faddC75MYcKfaEIBiht5CBs50uZgu2CYO5DHSCf/PwS0dSmxxKfOEOFagp
	 EJNkh0Zv9ZopKKugVFeF/apETC4w7kT4O0nb5fOayMKAwH3CDFfbx/NPNwPabXLhKG
	 NSd3mG4D2rXJBZYwpKC3zQ98JaCgLSVhb/oN8SgI6tZi//RlATTpmQKJGXScZRx+oh
	 67RnQ3JeKC0+/Zeh//GCoo6UJ53e+sVvcWamKJcwV3zE53p5Y7TeO6nNzqfFJwrSy2
	 FBXNZ8Ofy4FLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B882607AA;
	Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 245891E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11DE64057C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6Rfij8jhqVU for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C8CC40572
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Zbf61EkD
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C8CC40572
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:29 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so36769845e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826768; x=1795431568;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FrI8YLPestmuAyhxOWxRjlfKXzfTGOtODXPFUWV/RCQ=;
 b=Zbf61EkDDTeWUTuypYLGszQWdVa4tXsXU1MMqgR+IfNVp+nEPTpsapeDzNlq02j3QT
 PaNHvcJ6tkbDpWWaw6/XvPyIbUF9sTVr6PFUfs6J2EUY9VPi/mQnfbpzGVWCqIeGp70d
 FHDwJJXCwhe+YGgCqxQFZ41Z145wBmKwTkDuMCCok5HPY6Sl4cytVDLTF+tCfzenZ6WK
 t+AW2qU1xnSdB7JnExTcq5PazY4l5GHLZxiAYkNKxNnUgCgGcJZOljLvv/U7/owgrWp1
 YuOCkpKve0RAVwMvVDHn/hSDVg+qSe7Ql1k0DgL2eo8PqD5GLa0ZChSG6rY8E2asUqSz
 Wing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826768; x=1795431568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FrI8YLPestmuAyhxOWxRjlfKXzfTGOtODXPFUWV/RCQ=;
 b=eiKos2wdJd4DAU6Ba6j4SWsXXRDfWUptqWNVx2KaXRm4XrJmjFOcjNtSChcoMInrSr
 WzyHLBhYIPfu5sZVrNKs+4/SzpKP/B5EWPXOkucwSDXnnhCZiK1cIjkOq1MxtKidH9HK
 cVSgeAcMb9XU9ZC2hCVZSUcwkTZaWDJh4P7zghSCAoKWg3uHZsD8wwvLr8jzsnqTB2Ju
 8LZPKfg5GthnqNa36W+4OMnbK+43znqQEgySgvuUabC/Lo7nLiV2VLi6G7JGShq+d36c
 BQ+2SNV5unzDC9d0gz3JKykLUqXIiD+Q8UvJnmNuL/Dp98MI6dzo1rBfTIw380gO1G/o
 VOcQ==
X-Gm-Message-State: APuU4Z+PVJilIGw/6AgdCwbdU83SMjd12GV9NW9BrjobEgjWLT/6gFDg
 A5I1YqTpd/BCjwIrhcUGrOXyQiTAa55gYSg4XWlwQDypIZ7fy2nue/D97C529PFM9fo=
X-Gm-Gg: AYBFou2pGsOzjN77zyqyOUA53ueED4q9adxw4xGgd+hx4cRjvXm7kAn/c5Fg2ChK/eL
 11+ZNhliA4Ie6KVJ6oOb+T61ivORDKSl0G3FvXk6GoA4qsAc5sgplay3gjqHnR1aLPJ+6u2ltKF
 wIeuKKu5MMW2iYXyzWQ2X+KFGhfTdQ9iKWH6bLEZuADTHIgFAYpd9WXIj7DDDv7qUUwn/DzuVJI
 72+6xu7KTag9sGZXzdiXv/4jNoEET8GQW7QyNFhVBDe4w/rGnkT+LICpplhAxot6Q1AyyvGQQn3
 7WwvA2WS2rf6PYNe0WX/86xTHFPqXZmYen0CCGYTGv6CQjFtHpOQejK6u3cxf4NbzWmWV2W4b6z
 wErvNm0pXZ0Cz0Sk1mO3cxXljIQE/hpbdr7mnuFX+j8lE+aqcI2mtdgC6kduK+MgPipDbN2BEZC
 5rU0dULq1llRyyQtsjwHVpldsWWMLIw/PTxK1SBHx8wgaTKPnHF0MlKrXDsZ+o2zwfRa1rVzuBT
 Mmn/7p3wwTH9CKgbL4QqMAQSktAoqwqF5zswwlnwZSPNBJ9CkYeUROG8QH4rvowAyu+tcFsZWDb
 bUZGK/T0cIAQat3TSh+ktSjkXYyffQpN0NRAGYoeP/wU4sBS
X-Received: by 2002:a05:600c:3b9d:b0:4bb:5dbf:af06 with SMTP id
 5b1f17b1804b1-4bb5dbfb103mr196794645e9.9.1794826767859; 
 Mon, 16 Nov 2026 02:59:27 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:27 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:24 +0000
Subject: [PATCH v3 04/15] test: Do not set DTC environment variable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-4-b6cf7e96944b@linaro.org>
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

The presence of the DTC environment variable breaks binman tests that
attempt to execute dtc from a temporary directory using the value of
DTC but that is a relative directory path based on the source tree not
this temporary directory and so fail. The tests are testFitFdtListDir
and testFitFdtListDirDefault.
It also breaks a buildman test that checks the environment and asserts
that DTC is not present. The test is test_skip_dtc.
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

