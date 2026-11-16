Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s1ors2h9;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CrR6wK+n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C637460614;
	Mon, 16 Nov 2026 10:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQ14VCg7hUy1; Mon, 16 Nov 2026 10:59:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0FEA607C1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826793;
	b=jG4U6l4b+T1Yi5ZSrXJEVP5WCOhTx/ZopfXqw5Mjnq5oGCp4XxDofBgoYuwDIaYQkvhk
	 ZfhDRd1Uas303bYmo/CDbQyj21SryBJJxp5rawkCHTPaEmxQ2+WVHYDSSv8pGlZbb22Xd
	 Silt/dh0s9zVKOVdyEkUR4Fe1LkkgRVKuzxISneulj+URJjbUFtKzUly8SNkGuaAy5GVE
	 8SUu0l5iksHOSQ1wbCMDHsDMkM05VV85GJj/0i/KVFui5T05VcYnkM7NW0GA0j0+qS9zg
	 itAhK6xgar72mJXSg+L1VednIQDigkK5JZ6mlBxdREuVBwQ6QonPm5mAsJIPtvpwV+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jWW7Q+8/v1xC71TLmZBK0lOmc+SybGlDJS2Sub8vJFU=;
	b=oYXUYfoZTNyDtemslncrvwcK/5yGsSg1Yfz4HiA6s4spqjP/AOGWpRVqlWaqZMZbEIQb
	 ghhMXgw9rA0w7hg6bjySTItZvFktgMFp+EerU/Opm6VZ0FLXLdrTqbCOU3i5lRBGR4C1w
	 KCU9L+9hhVc5ituU8xCQ4MJ+z+WPHSHV+bTMCPKTtYEQVf4jktxPwgZDc7Gea2dMwm9H/
	 sRacEoUKE79FpSkmqinnBAFaR/QfJa92CDpyrdkdnsUj7/HIEPHp7sR/95dyV1YdRL1Hf
	 lDGwCs5ZcD3ojIM+ZkaDG2cv7IjFQGzoz3iUxOzxmVqxy9OqUG3FTGX3JdKmqlH5xDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826793;
	bh=jWW7Q+8/v1xC71TLmZBK0lOmc+SybGlDJS2Sub8vJFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1ors2h9EBDNU85deeDX04w2zEFcfBzRYg5aET71wSLXGzUBHb9NahYAkwOPii1xT
	 Q2VJAGiOFubPkXGbQogJ5FLqaB3RDLcMSO613QzFPhBaprA1adikM6gICS5hgZDTWU
	 8XD7XKwTE+2J2yam7FdOJuElkaMYWQLzjKa3MMmTIf9RsD+saPRBo0YqfsvlXE1FRL
	 HpYeJicwnWc1Wy9nCFpamsDXhK6N/AVFoLBsoJjchccjey/rBmF0iz8QW8krS9sPfd
	 xvrsMPdkfJFYcHHXCCONNLmQfIVizkhOsECO6Wc4NXafPEgRYeUx5Iqaalmnca0Z3Z
	 QxXKjYKKPCpRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0FEA607C1;
	Mon, 16 Nov 2026 10:59:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A9594DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E52B040070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 99KtYAi_CLm6 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F361140068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=CrR6wK+n
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F361140068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:35 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso19638435e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826774; x=1795431574;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jWW7Q+8/v1xC71TLmZBK0lOmc+SybGlDJS2Sub8vJFU=;
 b=CrR6wK+ngcCjuxAZFPcvchwpwwtqI2oiryc23ZrnSLDCvQzP5Otsj23Rs21ILqrYNJ
 scwOF9kgXT8qkrMOdUkmYZPrLx+ozvkWyLBz1aXwF9EZo3RWcvSc/J8BNOB9u2fBMfQJ
 H0Hpm/ME32gDZWb8/PXTJrCXXLfdrcWSHIRIhuI5Br7LOYJ002Nu4nKdHhSCXgk3cNwl
 4C2lLyhqENIwSRjXTPo/rwa4LYDwkrNl5dIJioZGZH8ipwWM66gof8OLAS3RBNkGzUmP
 hXp5VucVJko/EscVT2Gk5dAL5KJCQKU/LBJ9YxSioSqTpsfHjsumW7bsHJ6adjXMuEBH
 JVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826774; x=1795431574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jWW7Q+8/v1xC71TLmZBK0lOmc+SybGlDJS2Sub8vJFU=;
 b=QieYylF1MC0mlXRdMDHZhJnVjV5FqbQB6Oj3P9jzRGMmb3FGK/ATyGbj4/8UNIRViy
 FVSjf/4ZJrxpIhBPbVU3fq/5XdTKl+CN4GO6iJt4oL8pGZB1gfvx+ng7iVaIaXp98r4F
 J08eCvQCwU5SytP4mjmDJnMdM9cl8XyqhyKwGAeAXBTxsF7YMhEod8QQ2ZdVsolbtxW9
 oBcR7OEy9+odendjc/qdYmhmaeizprERg/aN02iywpPUVW48VCpVenvYcTadcAK0jYGR
 Ao57X/hDqG2MRmV+hyvceCA3q75iSZWhBAyFiMzSg2MaBmeJ+aqmVWDEv2v9JfoQ5ilc
 y7Vg==
X-Gm-Message-State: APuU4Z+xtoSpbK17bo3I7HpNRyQ6y9sTHoRlIToz0m8PGGRJuEeFYW9/
 Po8SOMAzWUq11IX+F9atDmPDv4bS/8x5xEWfqUV3v6ZyHzrdso6Uwyj4ZzhwzBYKS0U=
X-Gm-Gg: AYBFou0L0V4mDvaljKStHxzCfdd0eQVGCLvMxeFYTsZObJBO4YzZIjKHpre9kb3/uz3
 plACelAkqQTs0PS1ItA6Tg3f+C4FGm0D4QDdYlrnQwg31qqfcKdLeCn7M62wgG0vmVgpiN16bdv
 WWkIBSg51L1TSwSNFPpcrsTfnvCqi6amkkMk3zuDkhk8Y3wcL2DxGfVR7So8RTr0rZc1gcswjEv
 rXsbPSGmxKIZMuPhzFJ4Gu2GtAbEfpe5gXkgNPNMPydMW5fM5FJq0jkNlOmaCP8EbmC8LUmhRSk
 dP60NoAVlmFm2Q0t2Bkp+l3Lz+GxEfCcmniVMa1fRMkgm06TwRuCzmhLUqszdyvUyvISjpQNe9D
 NF58mSSyrwNV/0VVQpBMTtHw1gjh5a2eueqlWR/+c1BdOyX2DxDR/YUITnyXBmRRjRkZInYrR3C
 /ms0kPTi/OJI009nSGtA1DGRKdQllGWzicz2wOiKPyFgSBlEH1airjA9WyiOpGvR1obGK1Apo5l
 1yjXun4E09e+sQCHy6LsPV2xVc0znI/v5oqemC2uOkH7heEoXj+UVAx96kef8ySdgGnbQCAz+K/
 F0izZRAZGajaTrgXszkd4A0v/75kqMVO4mSdZT8JxH2VirOHHQ==
X-Received: by 2002:a05:600c:620a:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb69912526mr90601325e9.22.1794826773787; 
 Mon, 16 Nov 2026 02:59:33 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:33 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:30 +0000
Subject: [PATCH v3 10/15] test: Build mkeficapsule in tree used by tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-10-b6cf7e96944b@linaro.org>
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

Since the commit to only build mkeficapsule when needed rather than by
default, the build tree build-sandbox_spl no longer contains the built
version of mkeficapsule and this can lead to a binman test failure. Add
the config line to the defconfig so that mkeficapsule is built and the
tests will now work. 'make savedefconfig' was used to generate the new
defconfig file.
Building mkeficapsule in sandbox_spl is needed because that is the tree
used to run binman tests due to it being built for both 'make qcheck'
and also 'make tcheck'. The sandbox tree, which already builds
mkeficapsule, is not built for 'make tcheck' and building it would just
add extra time to the run.

Fixes: 2f736e8e3f4b ("tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 configs/sandbox_spl_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 83808c94283..3ea766d05de 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -242,3 +242,4 @@ CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_TOOLS_MKEFICAPSULE=y

-- 
2.47.3

