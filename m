Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3F4E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A974384105;
	Fri,  3 Apr 2026 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="olu1Hqba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5722383F9D; Fri,  3 Apr 2026 21:47:15 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3860D83F9D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46eca92a297so910744b6e.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245632; x=1775850432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N+Kk1vrz145mZkdieNZPCJmfH/TqmeZujDz/K+MO2dI=;
 b=olu1HqbaTYOdkq5aL7awfEUsUKu4Xh9vjkGSLnQZN5J6Cay/8Fb94a+mO2AxNXfS79
 O+pvdZqQVqgHH9ZMWN/76qdYV40NvnmkaLQGE8mSCjkxcOaLbCOjIT4akpX7Z5E2OYlj
 /yc2OJPJriSnd8lJSyhnMRZ/ViTGy3F5nxyy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245632; x=1775850432;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N+Kk1vrz145mZkdieNZPCJmfH/TqmeZujDz/K+MO2dI=;
 b=pSWrLPyfh3IBTNsIjlC3h/IONHXks3ipcFkc6XtRAT8iszICpBSSTDuogANpePSbmh
 CYFc8wkRrCTPK4ypra/8t2rNuyzZmm/QWBH1fvZt55xLsHpYYdP3ytI0i2UXeO/b4l7f
 ui0ZZ1PldaGGk/aTsqTX6pnUNKhSA2nTsm2RbA08+vCfmWeSwUsQXg3CkqRo0LA7wj5f
 33AR3SMrnKqey/91CpcmbOch79z1BQX6hkWglwA1jL2JacC1dUpRJFhTga7/XZKwhqYd
 tI/du9mkKIoOMfqvEVlf8tcNZ867iPGFWsoF4TVWDDixNh5QYy8zvY3/+alsFRwVPKu0
 JRfw==
X-Gm-Message-State: AOJu0YyJrbpNZmx7tAySom7hUBex+riwJLG+JCxv6yjbM7KirbWYtU+A
 rVGfkhuJR8VW+TTPt+GsP99EMXI9ExTLSD77vM8pzv1QxQC7+ZuBq3OAkuNbdMJ+VVBZvFUvaGc
 AUZdJEhg=
X-Gm-Gg: ATEYQzxSATaqj8nDSG/2QGiYIS+FnDq8G14CtuLK3LUVg4yir13MXrcM/cmz9sh0CKZ
 s7rDqiWjvOxLXb2IJxGrzCoIMKUg7moU/ZiLsi4xB1M1S1JgA3Tjrdh8t80pqNK8GFA4rirEPCw
 1K+nf5U6Q9tWzpqPwvleEt14gej67kSWa9LSG4Bp6cS0c+7HqwFBxsMD6/E9eMQQH2ei3tAYvQK
 /4IDOZ16ar40cXI3ZgfH0ccrmagOqFb0M0G/8HqHS17ppj+nKLqXukENdBzKhokeQckbNqOMs7f
 rtWiL+WaJRMa+hjuqwJ5UYSNaeMOh513fjREBOaHTGFNdIukE9fVySvoR3aLKYbW9DG3imtU0N3
 ICMI3pKRWwjmz4397JdyyBR0ScmML5c3w21zSWTorwfmjD4on/9Fk0fs34savFfmqXmlEZzaLzF
 4RG8cBmVlkgLbsFDkNIfdLzeirwum7Z8tVMmNYUYpQz7OekYp22B32Ddf7WRWHR3n4PJDd56wgN
 LpTdLVkB+RcbX4uAVgRNKHvCkpQcWGynCZqB5tm1K1vJzQ=
X-Received: by 2002:a05:6808:c289:b0:467:5403:3780 with SMTP id
 5614622812f47-46ef57f04bfmr2151889b6e.0.1775245631936; 
 Fri, 03 Apr 2026 12:47:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320141309.3541047-1-trini@konsulko.com>
References: <20260317012426.4162458-1-trini@konsulko.com>
 <20260320141309.3541047-1-trini@konsulko.com>
Subject: Re: [PATCH v2] sandbox: Add missing select's to the architecture
 symbol
Message-Id: <177524563109.2281750.6129579413777111962.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 20 Mar 2026 08:13:09 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issues around a number of
> symbols that we select without making sure to also select their
> prerequisite symbols. Add these missing symbols.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: Add missing select's to the architecture symbol
      commit: 021e3828fbd2bf6e633d2b98a3a0e8719fa13c46
-- 
Tom


