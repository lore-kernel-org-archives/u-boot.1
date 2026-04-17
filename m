Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6025F43696
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 18:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FD28425F;
	Fri, 17 Apr 2026 20:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TB7fnTZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F0D83FC0; Fri, 17 Apr 2026 20:29:44 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEC08425F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 20:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46aa216a65aso605083b6e.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776450580; x=1777055380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3QOPJH+VU46UVmkjoaNrZrfcGOvm1SumtVTGKUoKIk=;
 b=TB7fnTZGrjpxwXIC5JaKYDAKrXEDxzhYW8aRW2fH0lIxRI86EezOjtQPPSLQvmCVW5
 OTcqyw4+0QCXvqLh1YUCHmA1RuKEnQDEOe9RbJsZuUZBEPGTMfFk/C30bUf0AKfZPlRs
 mM77vNrq/3OfjQ4vXz0yT0Wug6DERuWK5oLMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776450580; x=1777055380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3QOPJH+VU46UVmkjoaNrZrfcGOvm1SumtVTGKUoKIk=;
 b=CML+ho/UQwUqf4KCp+2jw7UPiKbfreQPYvVlD7cpSi7KayxNhj/EAxHcupSP2QXjBr
 DrB6tFZP7mnelC0DSUAkNfD92szQ9vsMDgAdqQb7V/g+mh1SzIYI+ATzlCUJyxjuDmJA
 XzqMz9dgYNuX33ztwaZ89UbY3oYaMopvx6maJadnWHPMTZKAWhGDZuXEcG5ZLPYS5CRY
 kWoswTtPfuhTbq356Vu+CNkHIEuMRO03M4bbEYrUxNvY0BdwxuxeZqaoqD5gjpHY31Xk
 LFqYTW8wCXAZMVi+YtSMrCvBb+QrI7xDcUAYfYqz9KLJ3+3Fir1RKgdj4pc9v5Vi2+yO
 NBfQ==
X-Gm-Message-State: AOJu0Yy/7xTbHRg/d5Hp7wGBkyy62YqUNNgg+ZDsU2vnqBq/2s0cT+nw
 IOJ6L0E4rDON0LEkg+QLm/mCC81N1XHUjcbsslRB25ElpwZlhvWvR+fO9qa+6Rks9fs=
X-Gm-Gg: AeBDietfW9rmyCRlM68j4x0Seg4lySMJBMQgieeeyHVuUob8009IXe+G4sestdiCosc
 pssKxJGixE+UIYTo4s61715Oa8GhA+Y6ShNAjoUebZJKam072GsIlR0CnVGwsntKik13FAZN14Z
 fOjMmsMtRN3vyCOX7T6KQABHlNibvlCJc+jeu3zQ6zAbOfamdxVUGOvF1a2vhq4vvTF26XknK+Q
 0VkFJMjKQOQNSJwRtEcVjaeFAspFYrXwHt+XskaGuhHoy31SLwkHoAvT2NbRtKEztegESh3/Jqm
 LX+pM1qXlB2h5TQ7PtSiVV/aVqz3o9LBoBEf7ggv3GkBBkgBHn+TqdkBJ4xasiyVnXarZl6rEWD
 4gqiFng/8jDVX9xm78zG8zBxIrZshhS58zNaMk+NRt0/r3wIBIwNBTP/SqXhL6Z3uCSZiZXZrpk
 btKV7VXbMpzEeEIxRriNjfg04uV77MfkTte3IFT4oY/Cs6TsokaELB0Sh+fXb7ZuDW/GQPSYYOh
 guUl79IgYHmRM1IPV4PQS/O2ecxjKUfJ8IRpbCervAdUeQ68xvf6jwMOp28
X-Received: by 2002:a05:6808:6909:b0:472:b43a:3063 with SMTP id
 5614622812f47-4799c9cf2f2mr1966811b6e.38.1776450580444; 
 Fri, 17 Apr 2026 11:29:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac6f2a3sm2004954fac.16.2026.04.17.11.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 11:29:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: simon.glass@canonical.com, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260415151759.85015-1-philippe.reynes@softathome.com>
References: <20260415151759.85015-1-philippe.reynes@softathome.com>
Subject: Re: [PATCH] sandbox: enable FIT_SIGNATURE
Message-Id: <177645057978.805241.14897793283482926132.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 12:29:39 -0600
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

On Wed, 15 Apr 2026 17:17:59 +0200, Philippe Reynes wrote:

> Since commit d09256283f72 ("FIT: Image pre-load signature
> support must select not depends on FIT_SIGNATURE")
> FIT_SIGNATURE is disabled on sandbox. But this config
> is used on many fit signature tests. So FIT_SIGNATURE should
> be enabled on sandbox.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] sandbox: enable FIT_SIGNATURE
      commit: 30429c8bd2f18d33862cc41fe520f7459fa4bfbd
-- 
Tom


