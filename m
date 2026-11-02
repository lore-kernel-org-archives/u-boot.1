Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927DD606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u8uPrQB6;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Okq8XOhd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BD084070B;
	Mon,  2 Nov 2026 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXZ8l0RrhWcO; Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 737174066C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613522;
	b=tH4BUsRDSGGOvcuYu+hxFn7I+nUzZVgJNV0hDdX283PsU7mQzePFJ4/n5NrAWG1bZSOI
	 H/2am4EDY4q8awM1actyOhddJl9r3rE6cnIRMEQbGiKVBFQHrDKeC/xuOXR1dmL//p8g1
	 Lj4FpqSLtFeQfOB2jauvJZ0odPq3V8A+Ced4WnHyOiltaJSrBh9ekXfEDaD8+xkf4/+Nc
	 X6CImSIWndCkBgigS+F8UTtzmLiD//a9iv7e9mrOafSigGWrEeSXK/7BP7qMzmFz/0q5c
	 Q+2ICHafy0h4VJB0LDB08/U7Gc+2WZhvcIFGl5kg2HJrR75VzeRYhuZCbHKKhPsbnug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=k1lsAJkXmwFkU7eFaWHRQZtHleGxZkxO5moaVMa0KEI=;
	b=QBNcezux3RlxhuvrIm0VKiSUWl5HbDiXOT0FU3KdZlp/+HJ90JlMEvaxpyp+w3jv+WT5
	 Aj6+IzfCCNLMaQD7qs7moVMYG4vlVh7M86d37bTmxsddoQOyh1VLcQyk9BCRqiTg8w7l3
	 K4hEtpxoLDgB4BFTBOw83meP94ljaeby7/oJuF7h2dyeyLwtb2msXRBrbZQt4nFkImDuw
	 090kP63H270Ww2LORQOChWt1A32/YUAPeAAcyVvMu7xNnJcBST1ZybITp9dR2nE5+IGKm
	 pBNZdckIZBPrKpJHEAyO6MNseF3SUf2nF9oJg+yZjFhGnMBQao6Wtvtdq3D9Q7Cl1GA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Okq8XOhd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613522;
	bh=k1lsAJkXmwFkU7eFaWHRQZtHleGxZkxO5moaVMa0KEI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u8uPrQB6IuAjrNtaWSCc84081DRlcKo8aVbbXgfjBnRMS3fk7+H5g6mYH+PiobyKj
	 Os9vUFwqW9bqKPFVnLJ3gaROZWL7vV5wMfSaR3Jj7MukzyBSvkQCDoQw2WSkdE5CdM
	 vcnzqOnX87+I1rDtxoBZF8vIpLJns+i2DoSy/CCv7dVNAM7cOMo9Gbfq1C3AP7gd6g
	 x3UlHDGOsTmM0Kj88HxynzlGQ4NbVxp3qM7yOUQpoY04eCM8vwCud1eGfpyp9O01XG
	 d8t+twAGCJAFlP9xyuickWHH1DEPXnz4wUETh/hD5Drb07QzhS6hmGEJ20lG5lbXBp
	 L41tNha5bMp0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 737174066C;
	Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95551362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BDEC406DE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKYkfjxQlQsG for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 588C6405CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613519;
 b=iCciv4AvN1ST+9Y+PXW3hdwuW5i4Yeyo8cck2o+1rmdKfGPBVrDpdfOvgqKfDEvPbEwZ
 JH3RK88wLXlzl+qXae4cwRiO+925dyET6IzrzbywhRAtHlP4Ks0kmNJZz7dsuMGaH1IT8
 tyBKM3+I6yp0ir5y+DWYaQEVnSLRJYG4poJcX+pdv8iT5C6TN5mn3vOTAxgfeqPS/gvmC
 amio3XCqfarqHcOMSLe5vmnq6dkT2t+WbVhmfHaTgVSgOGT9EiPEt0klv6enjDMrvRTf6
 M7TB40WbbXCQFdtz7kG9D8I7c+ijYr5OfdInrGnMUxcwO6IkyoUSeACz/CW+La6XwCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=k1lsAJkXmwFkU7eFaWHRQZtHleGxZkxO5moaVMa0KEI=;
 b=VEmGBM1942EoGKHqKxGnOBvAW0b11PYG/xsiFrHkRn8VI60zTlPN1ccpbLk9bnSWfg/i
 1kH3OyasboRNgfUdIQ2gzTYDr2prV4kRA2zz4FeDskFw++oZL5uBFtxNkqBHc01XqutUi
 yA8iGoXN4LsCGdyCkEQdpHwi5gcMz2F9vLWcDf+opxiILCzEzdLi0e1Dg+J4qc38gMyP0
 VylNfBVr1QiAViyDJdrNEk6zadMM1ciQ05nZ9mIMN1OWeP4eY9lqsE2MuZmQnqcYRBgSb
 rN7FeSZh2vWv8TvARVh02pXrmQuR0bFN5Kf/gnxpDm2mUr4FTXEualKJE9YuWxdpD3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Okq8XOhd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Okq8XOhd
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 588C6405CC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:38 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2270039f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613517; x=1794218317;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k1lsAJkXmwFkU7eFaWHRQZtHleGxZkxO5moaVMa0KEI=;
 b=Okq8XOhdqp7YL2sinnOcopdt73nGFS2wtXVYejTxUCpevWGyRD3SY3DomjXA4K09yU
 AfK5PYhoRdXGLkSqUFDXmoIPFrVvbC5ePw7JKLReA/BazE6ZsYwpcnK7iUnh73zb4r8u
 oJo3FxOeJXZ5LikHL2wXwl2EXNjenkvEbclo5EkVffp9cU/ffUo0/pMm3zTA9wVSEHU0
 +I8qqO/IQyimVik9DYixHCh0cCB+zXFfFwGt1pUeaQfACzybdv6487jssNncHkarYZYe
 kCaA9Q5O1PES/d4maRB6VtCrEuIBmAiz84Pl0SiIEXfTe6NZ0FhzaGp7UTCVjhE5ANxC
 CYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613517; x=1794218317;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k1lsAJkXmwFkU7eFaWHRQZtHleGxZkxO5moaVMa0KEI=;
 b=ow3vu4Igw4F54j5cWRwlRmWaY2VLvGtc0axMHPWVHjJV7QN2lcjUqZoC8NPH1LIxEC
 +SLh+1p3fxQJiYk5DSnRJdCRyyoU1HWSIf9KhAkII4VkccXiUmdihp7nd5IMEwrKDzsS
 mIyLzEuJdYyVuD9D9Is4dIE/+QAwjtcsg7AUtDMUwFe1xfHuu5Wa6+IweupDBFdCNc9z
 HncQopPwOJlJpIVbomiJz3/8JUIqBhy6IPCcWGj2QtxJ6gYsR7oEmnLVXvCO77YdOqkp
 Ic8f0RyBZ6j2FCcS5ZFG7i6ajpAZTtwN74gDjUYH66h6BquG3eG9bJucb7r78JJ1rk2O
 HFdg==
X-Gm-Message-State: APuU4Z9qfTs6J9wsi4ZaS53j/+7S5FwBLgVpOs0jiM2qAehzyHgvMhym
 rJ0yoih/qjKk9aGVE8A7+eaOorLtX9o1iwXu3l3R8bNfku/RROCiX9GMG0+zQAEXX9g=
X-Gm-Gg: AYBFou06djJGmnDPtZY+TuWJrGT8uc31wsovGzOZgNzH1ioymH2J6NFtkwXpkeUTCpl
 LAe1KZzLvPnZKdb2sWuPQfRg807dNH8OwoVS17EfQ+Nen1Vyp/jQ13L97YrDM1N9Nusxa1MTOE8
 LKW2sp8mE+wUOCcd5cL/78t2JyyS6BFsQbaAIIh2tI6znzINOGEaHY8Ep453JOThxYmswIxf8PW
 QkwLjlL1Ezf66NKVASAj5TmZWd/HC/Ul1nVXiu3t6nalJNEp4UAlmAySv/7CLIKFfytJhmrFuTn
 744yai+Ie8/9LUlLKFbLYHtmbqECrTTDkcOFRYHYe3Pip+wzfhA731+puA1NDTxMV+Xia92KHfi
 9ZeEbzAoTh81Bpe0hfIHv/H3r1Dtdx9Upymu5XzA/yXWSdyA/2yopBfniqoOHNXTWFCKDzXL+9h
 qBBJtNajcfmptOlBX89ZHvccJFXTG075T2UR1ZDT11zVnqMv0N3qJhtNL0JVJRpSgWm9RMvYlTd
 2Gv1WymTF/0oB9LUHuliGprx6A02s1tsH2LZ/gwCfZac2fT10O4MpY6UdwHmO5AKD1qU+XcbgQ8
 RtR3Dtrifc6OGNllF/6YRaK1dJbX+ktjNfK/oT1KHT8Sg7WO
X-Received: by 2002:a05:6000:1885:b0:48e:412:3813 with SMTP id
 ffacd0b85a97d-48e6e4f5718mr20155334f8f.20.1793613516864; 
 Mon, 02 Nov 2026 01:58:36 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:36 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/6] Fix binman btool version errors, buildman tests and
 dtoc coverage
Date: Mon, 02 Nov 2026 09:57:45 +0000
Message-Id: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJle6GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3cLkjNTk7Pi0zArdxDRL89QUgxQLS9MkJaCGgqJUoDDYsOhYCL+
 4NCkrNbkEZIJSbS0AD+TU2G4AAAA=
X-Change-ID: 20261029-qcheck_fix-af97ed0d895b
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running 'make qcheck' fails on the binman test to check the version
numbers of the tools are found as expected. Update the code for the
tools that have been updated and no longer have their version numbers
found by the code.

There are also failures in buildman. First add code to understand 'gcc
-E' as an alternative to cpp. Second add the code to accept an empty
CROSS_COMPILE variable in the environment when testing that
CROSS_COMPILE is not set by the toolchain selection.

dtoc was not achieving 100% code coverage so add a new test to rectify
that.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (6):
      binman: btool: lz4: Update version regex
      binman: btool: lzma_alone: Update version function
      test: Do not set DTC environment variable
      buildman: Cope with empty CROSS_COMPILE in tests
      dtoc: test: Fix coverage by adding test
      test: Disable running event_dump test for make check

 test/run                                           |  6 +-
 tools/binman/btool/lz4.py                          |  2 +-
 tools/binman/btool/lzma_alone.py                   |  2 +-
 tools/buildman/test.py                             |  4 +-
 tools/dtoc/test/dtoc_test_include.dts              | 71 ++++++++++++++++++++++
 .../test/newinclude/dtoc_test_include_file.dtsi    |  7 +++
 tools/dtoc/test_fdt.py                             |  7 +++
 7 files changed, 92 insertions(+), 7 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-qcheck_fix-af97ed0d895b

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

