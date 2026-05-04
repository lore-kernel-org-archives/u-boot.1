Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A7CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDC08483F;
	Mon,  4 May 2026 22:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m8T7+laj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D248B84841; Mon,  4 May 2026 22:36:15 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEE784839
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7c57b52cso3889139a34.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926972; x=1778531772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8zLpQ1td4xyaVkL7JiFaBdUl/D7cT/9Jdc9IQU+szI=;
 b=m8T7+laj2IvDgqJrm8YEXv2cljpDJoyhwlW7Uks4UmZTKF+09akckJoCTUg51nQh92
 ZO4UflSJMVATkY7KTKB8C3nUl/gYHaSRj2o5FiiQvHNn1E0mxwpnI8iPI5S8FPiM7Y3E
 jngbFKoa7Xswt8X4nlx3xcYInT8DZgM765V44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926972; x=1778531772;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m8zLpQ1td4xyaVkL7JiFaBdUl/D7cT/9Jdc9IQU+szI=;
 b=KWfKbrrhahgGL/d7GcesLJ5OmmRKqR19NYxaGpAe2xRMAOYSnz3fKc3/KwIQ1M4/yi
 qCGoYVR+yiwRzVtlGtXsy3UeKeCQArrthF+mTd66QtbcqjwmRu49MspKSiQamSvZcxxI
 CrSC0EgUGYZArGZzyoYwZ1NzQulsM9VG4hzwrPw/F8o8HHqEADJZCDD2dCmS5Bljfaop
 B5CKlSp1Xpx4AbC3OTheWAXGLdxpLTsstlE8hDKpfwY5jTnrri+WUzlQHrV28BCL3s/p
 /9BnkgWz3+Oyy++AOCJ3L5ntAsbvkcSV/zYz0PIv1R8fQDHX8eV3pd8ddTch8X6GcEnl
 zzLA==
X-Gm-Message-State: AOJu0Yx89ndZe0x6uqRwNCSV2XOBof+gfzvAw+0uK0ldmx8neaCh518V
 lfJjC2fQS+VZIVTPo25iCQodRn6VjiBIkdu1D6KB21zBIS+A7e5TatHfTRm4b1uE4c8=
X-Gm-Gg: AeBDiesB0/loPLmrOZ3Fks6gv0BiJiQqkXws7bqFKSsI0siaxuzsr2/pEYTNOnkWYG2
 y6/WrtiEJko0X2ZT/aDMMQIjfZNI7IihJuxF6YH0naUAEGxcYnE+9fwNYGT5MEzWpYDKfPojSWj
 grQCzOD4QPttS6+y9s51V4q7cbk3a7P1OKg6VjoU0s9zhkTFS+/f7dV7DWbG8lNv4ZDIKQxBYUF
 O8xyJ8bek4c+jzS5q+U5cLlD7RVveLK3Ap7AxloqxzoksbL5ljkvXAWM+xziYhuZnytONJjyEzw
 mE93xkfE0lVcGZbu1p6Bv4MU4KpEXwNQATepEC4dOOp9lrvC1YpMGOr8AoKewXfCa+UXTdfSRD4
 NHR6avDpY6wMXHftZ/NPUcPlASPygU2i19xkUAom4He5x/TfNPy4WIHe68ww/7AeBBnNpOVjdrJ
 CSjDL999A3wMbZjjprkZDn6q34JBH9SI78G49TuOWCU6kw7w02v8L9erDeTPb2gmyaWyTaFCf7m
 0clN5gG/jS56pZPsuiLVBi+v8/nRqAAS+ak6V5SjvGlYSVokFxJC9y68Adt
X-Received: by 2002:a05:6830:67e5:b0:7d7:f031:37bf with SMTP id
 46e09a7af769-7dee13f9788mr7043340a34.19.1777926972087; 
 Mon, 04 May 2026 13:36:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Franz Schnyder <franz.schnyder@toradex.com>
In-Reply-To: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-Id: <177792697111.2985766.14817811636048176090.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:11 -0600
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

On Tue, 31 Mar 2026 10:10:10 +0200, Franz Schnyder wrote:

> With correct POSIX handling, unquoted empty variables can turn the
> expression like
> 	test -n ${fdtfile}
> into
> 	test -n
> 
> The POSIX handling for single argument `test` evaluates it as true,
> so the fallback initialization will be skipped unexpectedly.
> Quoting variable expansions in `test` expressions will always result in
> correct behavior for empty and non-empty values.
> This change was triggered by
> commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> The aim is to have a less fragile codebase that is not dependent on a
> quirk of the shell implementation.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: toradex: Quote variables in `test` cmd expression
      commit: 92a04aea6df3e59942614864486bbd0f46d01682
-- 
Tom


