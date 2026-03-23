Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B2FF4613C
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9053841B9;
	Mon, 23 Mar 2026 16:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rLTrXTki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5DD84209; Mon, 23 Mar 2026 16:14:40 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5CA84144
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so169313fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774278877; x=1774883677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UhPDe3M9EtDN1o1KCqTbT2mH+b91nvQ7xm0c4YOsdYc=;
 b=rLTrXTkiayTPJajz+z4A8ZvnqCbJj3PPs/0ynUu8YD6gviQWMzULdgbeLY7vVz05iy
 rrQ543AniHZXJXG2ltpLBBe+xdSx5OC+03Q8uT/nPGkVjCeXtPNj7Q7DHrLL1VBYkMsp
 yR33PGwu2dx3vfksfzQ1Y+HiuHgbFAZ7WGYQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278877; x=1774883677;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UhPDe3M9EtDN1o1KCqTbT2mH+b91nvQ7xm0c4YOsdYc=;
 b=UXHSnu+VobM0KBLlTYYlXmeoKwGEes24DDSF18W9Fnzv36oK7PRgG0ghc2JW99vKoN
 OKQpcVH+MeTCWPV3aeqiwbsAMyTyNoDvg4yrXPY4qwcUVPtTIhQNdYQD1THTuDyJnuVF
 0tkMj45gVFO/84GbQfkbqWRQxuYheuKjTi3DPQe7S0NGj/WVOHgd2OhHFxhWelEv49CL
 /31iV+OBNJ1bo3OgJVcHbgX3gq3s59JnHmrwjMSBSE33o9rCzykuzF75ozlh1/95vaZJ
 mP7ZeeKlhMPZLudQ4V7WxqTXHRMnWJZOGxNP5C97iBCIiCJA1OudeIT1lxtFmgoZFI1i
 Ph/g==
X-Gm-Message-State: AOJu0YypApbOrtGVqr3wRYxGlNqmG27x07mlD3QBUCgkz2puIZiotysy
 N3B5J332e4X73DdaXz7RYO9QxboAAlouzOG/eFqBjkAKsBxL77NqCNFZ2863jfe9cNevNMiS11b
 7tyAmDCo=
X-Gm-Gg: ATEYQzyRuFtXXduTHumyi519rz7dNk4xM4bWSnziZpe/yiOD9eKyu/WvkS4n4VWQlRx
 pHmygOq+d2ovZpCawflLQxUw4wQWsWob2eFowxclkuGvn9dqZ22/rJxJ0qQ5MZRe+SPo4J4CWRK
 SnkqQuIiCkQz1kULVQiy+c8PjR+d5Mg4OGixQ9ZbmE2KVinc+3QnR7E9VaK34FZOP3UVPOPUvzg
 xmwfVWmJ2xswiLoRp8yZXsLHYI1jXkbohhgdcsYkxtyQ2sB22xYzKxa1JGnnLyeuT9x/77mPlhv
 0EU6NIq4mIbF9hW3Snrx2BEuvisfH7iFDAfHdvk7qyCn1c5gWtWEqJCpbFkdrL+iZnqtxtiJ+tG
 m2ougrrkdEgNZ1mjs/tMICp2IQEw6jr2zivBKi4GOxKllEdQh9RknyiaNeEVv3tgkMKHf2jrQv/
 oQS3ecIgHVL7mPP2E6IrM3ByT/Iz5NOyMJoTXA7LB+d3e/q5lghv1MxRR32eT0TNtsIe1R3ISA1
 lGfsRUK3SB4ZWpbV10HxQVMgbOGYSUGNrwyItpIYyYl0Zk=
X-Received: by 2002:a05:6871:c964:b0:417:530f:6584 with SMTP id
 586e51a60fabf-41c1149db71mr8655244fac.48.1774278877272; 
 Mon, 23 Mar 2026 08:14:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14dd0a6bsm10057366fac.13.2026.03.23.08.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:14:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260318170233.1200532-1-trini@konsulko.com>
References: <20260318170233.1200532-1-trini@konsulko.com>
Subject: Re: [PATCH] tests: FIT: Add "clone" image attack image test
Message-Id: <177427887650.2283014.13946236854008944684.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 09:14:36 -0600
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

On Wed, 18 Mar 2026 11:02:33 -0600, Tom Rini wrote:

> Related to the problem resolved with commit 2092322b31cc ("boot: Add
> fit_config_get_hash_list() to build signed node list"), add a testcase
> for the problem as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tests: FIT: Add "clone" image attack image test
      commit: a22e9e1b8ec7c96664072d7e629e811c318fb92a
-- 
Tom


