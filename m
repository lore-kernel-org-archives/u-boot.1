Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4BACA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7E33407B9;
	Wed, 30 Sep 2026 17:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T87zKalFpzuj; Wed, 30 Sep 2026 17:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6172340811
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788651;
	b=W2Gm8YM2c21+Mz9iAU9mqiDCVe11hk0kdYjiR3IRgDsOVrPSLNLLz7lTbUbmjQWkGbsm
	 GvF/8Q8j4VjfDbgcEtoGqmlpK/aMwktXlyq5e4Qqmx2aESIUn65ApSQpnIXnXzMG4TYfB
	 8kT9pFoQPtizKm26j/ZjP43q0D2eEizAn7E/byugGNgzCGVml35F2t1UUuvoaFeiaoiPu
	 EkzhlqVrX7n88bkL8/vQlf+/H2IUmpA6xcOos00Drjk/wDj4E/InA1/B41wez1XWT7Uhk
	 0FJDG+m9oeJWoD10OP/atq3lSyZqT8KTlR7AE3PDanEzRtvG4r0Q2FcL1g150XrCABA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8ijPNZEO1REhaLfrza526mvfSl0fHukshxGt3t5Qg7c=;
	b=I6+EY3tENuxtExItf66RKljjGJ4KKPGgctymY09FuFdWQyz40BV7YCgi2qLkBWY1fdr6
	 EiAKYNkXOjdGor2uzpF48yCB8+7+tX4OGJAQoYkPZrsd3LcjcKkfB5wmwz2UAqbCNK7Il
	 NCOJUSh/e7mVHPbFhEYizVv/Tf3FG9OIZWpak9mhMXIDq9BQFIf3IsQbJOW7kMGMhpb5P
	 jhZl1yuNIlFOHRzAUWJRDLxVQVoIVPo2zMS9c2G2B7JHCmuOAgjd/YZwOMEOeqUw7o3dx
	 qodF+T8tAXkYk0eAw8YVhsU8ar67GK0VUZ6VoMgthlkxUPm9CHZbXxgVI0Pn0V8sq7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=F3tjTRqQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788651;
	bh=8ijPNZEO1REhaLfrza526mvfSl0fHukshxGt3t5Qg7c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kdbnwd2LUU7z1MueMLRAeEOvmP9zcNS4YLRrDw+UJwkRjfvrHDuyOa8Qsb8f5E7X7
	 tY2obgyHrdTK+CYi7Jo4AA8WZ2hMsqFzmWEwPoPgiuIi8P0AABZzh3WktA9hnF58oW
	 J7jUzOpqsXunebc2nWPJ/30Db3cHEpNsz3L16nc8pFzlA40Q81Ongne2nbYB6FOszV
	 5EhBdCgbKF7HA5kfexfRjDcjh83jdZgesuTdKbEYKeY6l7GFT3b1wQjaRdIGMHsL5/
	 TsIbJ5VEbJMfx6O53jBSrlAH6HD+jIyquZSf/xV6CAfwSXAhwVw+DfoR9zP5YIHTr1
	 eq+1FmodqCs+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6172340811;
	Wed, 30 Sep 2026 17:17:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C318C32A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A870140811
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIkES6JOmamZ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BF24A407B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788649;
 b=BCnpwd/OtnCt5KoPt6RrAIPfqpNCb3QX1dSWcJDFpZY2E7MDULkeDDqWYard8KZjJQZ5
 IT8Q3MOUw4bJBC5QRO7VM3OTE/FuwufQAgLfWOt38PXk0VObawIWHF9MK9EkCeKtnHy19
 cb1uS/iKmo/S5dW0y+2IJgmt7QGK1GeK/9dStv4Hupw1H2PUkKaxXXXowPsRE5KgaZmZH
 eYfdJ4N4uoF3algD8zJMaEVVZJq5yyES6QqXIm7lA2XQhBojTHFm2q9Jyyen5oQHSInyQ
 /744F07SIu3c+zxttvivEebhCiTBIYdkQKXwSXvgyciZhCPUqzygyaC6pxBC2a1XMgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788649;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=8ijPNZEO1REhaLfrza526mvfSl0fHukshxGt3t5Qg7c=;
 b=Pn8KGCfPb8DWC5NLbgt9oU+m+toRktrk0LYaPEuI/FtYEWheM46/Mu7Wk4flTvKHxNnw
 nuGMhd0Ezvsxec9zV5T1tmxw5zFiKzkEouNAbN//7BWyHq4F82RJAKFsBeEKnE8t4CDuR
 /ELjTFKPKDFu6JIaapEgRO6/n/BoIDrj2QZTQ60KbqOAtJbEzFCoGZigYi6PlQfjI1ylT
 rsI8sgDjS1zPL065/rxkBikpT+F/ul+M5OA6+FbFRYceCYMVmTCcaoquG2rDPQlfy/26e
 Z62E5rErDq4IGiV5zE8biQy+kptD2gGATmClypaADq/pBYMlXdMLPel8stSk3BwQBFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=F3tjTRqQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=F3tjTRqQ
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF24A407B9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:28 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-820ff812cd8so58640a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788647; x=1791393447;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ijPNZEO1REhaLfrza526mvfSl0fHukshxGt3t5Qg7c=;
 b=F3tjTRqQx/a9PVVpoKC8Uo767bnnjhLYf+3/fhXVINq1eQ4vdZQdI/J4CO6zwX0wmp
 9DkrYu7wbbNjpd+na9sii1UXEiKOH0jVjrKmjFetqzxBEsLM5VtZtTFlvFYkAviwOlyN
 /cHJuJV6einB5nNiKbcBtIVqynj4dg42QQ62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788647; x=1791393447;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ijPNZEO1REhaLfrza526mvfSl0fHukshxGt3t5Qg7c=;
 b=z/fC/60+9HiWh3jFgjxAd9FaVHWuiLc12/M+KZEmG2/fmrcq/YdJFbJpNHZqp9e+x8
 YsljtSqCTBq7djFgSwdMdzi3RV6SGO6kO7J6MM34WsBwAUtRrn0VbSYplig7zX4Icbwi
 pMlhc/cg4DjW2PimzX8VRYY2PK17WzQQmbRnMIwpXqeQyeABDEoMRAyw7fD1/3BpJskb
 av+kYnacH0orksqWOveactSXMlU1H3uzRmbe4L4FZTp03ME8U11oyGbks4akCboMryaD
 r3gyeFaWW3supKFxIuaTA9j+IJXbHBcyo9GhXuMwyJtVVdCbV2+r2tu/mw/6G/izVNKs
 3zTw==
X-Gm-Message-State: AFuF++lNNpXld7020P25W/ZI7LL4acpq3jGcBhFg57Zz6VSnCNboE+6P
 ifbYpT0JwWKvPM542jQspLsjHoY4BCInM17Y2mTR7+XlPUjbWA64lNkNLm4FF0bvr9A=
X-Gm-Gg: AYBFou1KfeoTPAAXBFswRn3SDPh5IForPn3RDtkZnWkmEObe/+wk7ZvRjCRs7ZQRy+j
 cJde1nYQ9cOhMsm8nNhzPValpcgkUp3UJltS+NL8UVc43BB4EvpYdtKC6wPR0B0SnPXUHGVil4+
 5OLRETMRQEb89BF+/BmrkFDQgkGXmcxGnAmxHcQmmRARMl9E0Rc0Ww5X22MwnyU/+K94d5ZsZJD
 L5D/PIK2lkQ8jgXSdst3+dhKFuqo3bOljp6RPr+ROJY2LBvvjmzosz6rKyqrdOzzTgjcHToaCY0
 O7ODq0r8d+K4HbJDOv9YtBHSwyRm1fH7MLqF2ckn6rDVtreIJq51vQg/N7bmkELloLu8Ad5IArd
 wColfKl5OpxTFcv+EyGPXgIQgUtJsjf+zagdibzG+4do5mpn1QlrzQ58CXzwujlaxUn3f/hhJ7K
 vCMnpC1+ThWknKuRdkAIJxPYTOsm1PUn/W3XIUyIt/F1GAqL2gmdnNiJRSUGBTTkbGqZFJ/5Mk+
 B8+WilVilaWZY+rN7MDd+PUtR+2OYPwRJrszeFj8FSpGEPWd1l5l1Ab0UvuaEcaG/rNm94VVmAQ
 e47S5y8qUk1l3MPKGw==
X-Received: by 2002:a05:6820:1906:b0:6cf:d6b7:d89b with SMTP id
 006d021491bc7-6dcf642946fmr1861407eaf.82.1790788646983; 
 Wed, 30 Sep 2026 10:17:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260929223254.500384-1-marek.vasut+renesas@mailbox.org>
References: <20260929223254.500384-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <179078864634.467656.4823138570288539524.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, 30 Sep 2026 00:31:52 +0200, Marek Vasut wrote:

> Enablement of new SDK SCP version compatibility on R-Car X5H.
> 
> The following changes since commit f61f50a79dab97c8a4109ee9c15b90bf6157d4e8:
> 
>   Merge branch 'main' of https://git.u-boot-project.org/u-boot/custodians/u-boot-usb (2026-09-27 14:31:14 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


