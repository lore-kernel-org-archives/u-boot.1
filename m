Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF776CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FEB8405C;
	Fri, 10 Oct 2025 21:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I0ma1oWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF45A83FA0; Fri, 10 Oct 2025 21:23:22 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C116183FA0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce86052cso1492265fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124199; x=1760728999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EswFx+ZSMnVT4udoBjZZeihGx8buC7/8gwERAOTC304=;
 b=I0ma1oWYrDY/fjPtZDjgYYI+vOxpZ4d0eJjgSFVzLkOReu2atkp7KMc7MkUJ3QgoBB
 OqSktyXWaX9HX4Jsc9HsumT5IR6toIJoi6epieKBS1mkXjYB9CZ2ayJQHzf3cRtP+bMl
 p4qb6ixzqkf04Nxfn2JOQ0oZJqL3mwy+8gPR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124199; x=1760728999;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EswFx+ZSMnVT4udoBjZZeihGx8buC7/8gwERAOTC304=;
 b=nBWnuRZsjAmIPd6nEj+ca2DrECUBkos5cBFz917sTwXzKmbx3PaidqRWmL+r3PEnHF
 QOA3Fl8U0HQFmExG96idaawnw5eC+uwIxXyc6LwhQw0LKhI0imhd4igkKuRXAAm5AeqW
 INHWLdxoe42pbbst0lA6tKl+XRJEpfHhP48MM+yHT5N+aIq/CXSBpcAYN8MbHeEEGMnM
 xOj14R3Yh2gv7hC7OtHM6jMQnb2kvZgM0fl6Ya2ZPQQPCfTdANAqjLl9A06s2YSbmGjF
 4dDojWuN4ss3vL3nyc/MLXkIqtS0tE4H0azk91A09bMpe3yjNuRMGqmzNAbvJbVZzxKL
 SWNA==
X-Gm-Message-State: AOJu0Yxv+2v0Vib1dFXG5lcSf2bCUIqnfh4VwOlPY9uAT19E1Pkg9GVr
 EOjSHsyhbtsMoO6NNB0hPTIASaYKPTLVIcDmPGg2x5Bd/P9jhrq5e7FkFxDmz60QYT7+titXXTG
 1YCwwegs=
X-Gm-Gg: ASbGncs/qsfhfyqDLszAvn2CP9R/96weQ/okt4TTb4I7RCd48wCeptroeq5V1tM+hcq
 xRIrDt+2cU/G5tAIdiUbrW9gHH1PvzlrdvTTtd0PSC+DLBuoXEmVDSOnA6thH0X5Gf0L2o6jtTr
 O5tpY21SVCEjxSsT+pxhVdm2BjU08mF679qmCw/cvTWYoOAOSxderIj1SuS9wr4uIGfFAqtMrCV
 pbqQ1WIAG6QA6QR4N07zawjRVYw1oV3CGd3Cc0RH/mN/V3KFUJV6nHQy8iNvRKsWj0f0s+SKH0d
 K1gdygcxZHsgbCYvh9j3fbSeAgOofU8tpvvX1MRbip7RWp0Tan80cjRrOuK8S4fn6lCBDcL9Sfp
 g2GicDhZ5DnmtXyEAJLzE66vbnVZ2uUEgckB1PxSRb4VbT5QEx7J6AMUB1DviXq/nODvPF3rTwU
 AbTy8=
X-Google-Smtp-Source: AGHT+IGZfk8Q4Xum1z2MbblNG7VaJMmM1qSo7lMUNtUi4iuM65SltID3EQf0Fi8vxzddlwS8zQb6kg==
X-Received: by 2002:a05:6870:9e84:b0:378:cd79:6771 with SMTP id
 586e51a60fabf-3c0f5f08c02mr5871593fac.7.1760124199489; 
 Fri, 10 Oct 2025 12:23:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250926153128.3680800-1-trini@konsulko.com>
References: <20250926153128.3680800-1-trini@konsulko.com>
Subject: Re: [PATCH] include: completion.h: Convert the rest of the dummy
 functions to macros
Message-Id: <176012419865.1180358.4722683829031026674.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:18 -0600
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

On Fri, 26 Sep 2025 09:31:28 -0600, Tom Rini wrote:

> While we declare some of our dummy functions as "inline" we do not also
> declare them as "static" and so it is possible for the compiler to
> decide to make these as global functions instead. This can lead to link
> time failures in some cases, such as "allyesconfig". As these are just
> dummy functions, convert them to a macro instead.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] include: completion.h: Convert the rest of the dummy functions to macros
      commit: 8ea8487da05cf93a9ae49c170f3b15d585a368f6
-- 
Tom


