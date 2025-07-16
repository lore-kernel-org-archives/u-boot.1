Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8030C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 22:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D3E83291;
	Thu, 17 Jul 2025 00:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nkzht5oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF08083242; Thu, 17 Jul 2025 00:15:13 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49A683276
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 00:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ff8d43619cso294709fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752704110; x=1753308910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixa7vn6BmdzO/ae52IvExR49OLQ6syuhSUNbpJ6rOM0=;
 b=Nkzht5ohAXsOoEyFPsu1prFn497UozEV4794LKHSG4AYngbzLBNpeji4gqlJn0kPvM
 vXnuv9HdfjCo01fKOpEMMZ3goNQTl8Dv1mTjin4Q1EpTZskWSq14NM8i8J8qCAlW0Xsk
 4Q0kJKw4vYblRdLNXPVhG2G6ncRGoOTIAsLEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752704110; x=1753308910;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixa7vn6BmdzO/ae52IvExR49OLQ6syuhSUNbpJ6rOM0=;
 b=Z2UvDqjtqb489YupTFuMFoHm3d9Z082lhumEGA354YAKYLLVl1vaA0mdRlIT8O7edo
 Kuf1uYdWIuSjbmA4aSZJeV4QSNBTHUAn/rtPZAwayL0/ixz4KsY7vVCCemJ5zcCYeEd+
 F6BxLMcevgH+9gztzFahCjl3oqH2CbA/nQNmrf+Izovi7C1kTSadSQuGkfcaXo9Mo2pj
 Uyst+2ZyE4hZnzv8PL/EVdutxw5ps0GigM0QF4yhNeYQL8+cGDCI/eBGBWcxcuSK9fsG
 KzutDbYsxYKwT6pNwRk0oDYj3xQKJO9D9UVaSd85hqy5TnjbTi93GMSnNJoCH68fVZld
 3wCQ==
X-Gm-Message-State: AOJu0YxN7GLWwDwgR+qClHGOcZJsbwl2RN6n62MZUIQOk8jFvMYCzLSS
 uMyV5dNRx9to/UnAaRgjNLORdr2MsUCb3baq3XKkZJdv1fEfKCrX8LucYyv7JOsQ1Io=
X-Gm-Gg: ASbGncuAGx5tGbivyypRLvOPTpjpusppQTtt3LT9IaHENWoJ1kdj2LGS1mcHFgAWNyo
 FlWT7Kpr/VHw3Enfy9Q4VMwSqT6VPVCFJWywAhmGSJnu5eat4s635AVQ6p7hnp40gz8rI4WlOnP
 3rFAm3gQfdyH/ZbGKy9SsgLJ1YATiKYiDgQEwVd/UBU2qM5d6ZHSEY6IANmCqogYQlZLmWxkFRt
 MwbH4MZBn6aDbnHU2VBbKsTABrUzke4BAgRIlaq/wkJ2eje8GdCUng3CcGVLXJp0XpRDLxuJCOk
 5TcARRu/PgtM5D7wlNpxEY+DakSG23+NT/KnHpZcglWd0jM4EmzlT9HqW/0W+3VA50Z58/rQBLS
 K43NOJ/si4pmJP5C8mXrKAYGdxLEhElilLFKhVQzgz5pg7MZhePP0cGx+zGQqyEQOzA==
X-Google-Smtp-Source: AGHT+IFUuGfsbjnpY2t1ysbbcoxXiBJ7G+eFxyeFUQO1ylGzPYYVWipe5hTCqZAef/rV31X+ZA67OA==
X-Received: by 2002:a05:6870:538f:b0:2bd:455e:c22e with SMTP id
 586e51a60fabf-2ffb244d212mr3528639fac.19.1752704110317; 
 Wed, 16 Jul 2025 15:15:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d3541sm3949246fac.35.2025.07.16.15.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 15:15:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250627-bootflow_fix-v2-1-bd803a226f4c@linaro.org>
References: <20250627-bootflow_fix-v2-1-bd803a226f4c@linaro.org>
Subject: Re: [PATCH v2] boot: Ensure method_flags is initialised before use
Message-Id: <175270410950.2648161.5316899330625740901.b4-ty@konsulko.com>
Date: Wed, 16 Jul 2025 16:15:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 09 Jul 2025 12:49:09 +0100, Andrew Goodbody wrote:

> The local variable method_flags is only assigned to in some of the
> code paths leaving it possibly uninitialised at first use.
> Initialise method_flags at declaration to ensure that it cannot be
> used uninitialised. Also remove now redundant assignments.
> 
> 

Applied to u-boot/master, thanks!

[1/1] boot: Ensure method_flags is initialised before use
      commit: f1c03778a4be8e08decf88f6b2018b90f6662090
-- 
Tom


