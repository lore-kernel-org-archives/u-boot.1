Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D05C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2140184DAA;
	Fri, 17 Jul 2026 15:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/03qFng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7115084E36; Fri, 17 Jul 2026 15:55:24 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6FC84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so495127366b.1
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296522; cv=none;
 d=google.com; s=arc-20260327;
 b=kyspEn5BbBUVTqj+MKHbeem2epBZwxBSas5MUCslo5VRw7uHXeZ7vvwBksfUiUagxU
 NpO9/dokRjKkevRvSZedFLdU08vsFTBeVpqDL3X2RgqDAaapoPmzmd7PS4yQlk180xY5
 T86Y48bEJcXrKoKBMoV6x2PKEnFbRWUKDhqXgdHKYOT1jbighDvATctkU3CPJRLksJyJ
 YgnGUpWRU6w5D+NwigWb8SkXTgCJQgjK2XN6ssV4DIR8kup8+6lqKpo/ukxiW70MhTDT
 6TXrcKht3lkQ4owQdVC4AW4ooqtcDALyP4MPRCqxXEeNiBhzROkHXjfi0gdk0QV1fTiB
 laJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pls2svbqPAl7o/3bB48bsZfoX0uJflyn0HxZhmXknBg=;
 fh=WsvL9Gy+7YhkfwetOElIT2GFYIXjpgEIra69PTd8gJM=;
 b=dof/vAmqjpYc8ZyfknT8fXi9Vq0N+xF0EnjtMYT8m8+GQOb7nZTwAKHLMIRf1i7Q8C
 bZPnStHl0tdkcD7K5vYlU4iOjpOSH2hbJQszLq5Jc9/7juMSEsysLFXz14vIZgYG5eaz
 A8Alr4SqKMZ9hfFlocJNrieEPFBQ2+erbsZK67Y76xun53v9fmabHB5LYARymfF+NWPE
 nicl7XJcm2lm0fSDo9iDzPoQjbzDCNkXKu5GkFq3hrSQgYJlpHwom8Ksner7luY3Ugn3
 Xgrc9MwEB0jn8LFFXGtpIf2RZYMNuYblKFcUnwgrb1U+F7PwctIW3uNX1js9sIllZo/O
 aS9g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784296522; x=1784901322; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pls2svbqPAl7o/3bB48bsZfoX0uJflyn0HxZhmXknBg=;
 b=g/03qFngFDiwlIpdwNDaLcmtYA8Z6dIjtrKqibHbGooeONtyDxnJgDfwHWCkSrgtNc
 Mp8Ky22Gq9IewkzCExQXwGJMQjzi8N/Et2XfbDzsg36pSYdiXzafC8UrwgoRAhBclH2L
 q46g533hCw5DeMNjJYEOzLEO7V3RP1O+SWQGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296522; x=1784901322;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pls2svbqPAl7o/3bB48bsZfoX0uJflyn0HxZhmXknBg=;
 b=SzDbNV3I8qqNpm4Sq9z3m8OENo5k5YWwMrJ3IESgRYQ0+DrScvgzmFSQIXRJIp/Ns5
 uPzvIxhOgR+paGbyCKdov5iEwKQ6Yfs2kaz6iQYoshbqDtkD2v//0YNM0WzShW4Qd/we
 bW+rp83VHEyp1WhIUDkU+B7zVTL/OTDgPNGCCCTtM6+2jtD0/asQAi5l/g5G095r4xvG
 8ntaNxnzF7tAcPxWb6S+JvXJiMJ755vtksGBl/hYDM7QYdXIr9yQ0FOP91gY5wiVhdiQ
 +Qp2pHPWnPUuX1tRYt5YRboe9sA7gTIVQiyZyBBOLvuWx4qSWjZp6BCFf/Uef8ATLxeq
 Jerg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ1RpdA2lHVq5ixi96/5oN2FZ717NfdNY0TD7SaV6bm1bN9orcdbVhsCcjbE7Vpwg2w6Ic7Rw=@lists.denx.de
X-Gm-Message-State: AOJu0YwLI5V9tUncWAZ625yPIHNzXL8grqw72rBpAEgiHykkcXGDqc9a
 CB0Zdw5OCZeO5/0BUFysWlvJKMGrNwXOBMnlI1hCP86qe8iEz3A4MlgZRdv+62f1Gkd+3capJ2C
 wN7q8Byc89SBJ4i+VsX/LSWHDmtyEVSJQ4kO1B5d4
X-Gm-Gg: AfdE7cnMU0ulFbmopTgh4YrjGlZ6RXmACIwmkd8Hol4QLUKpIyxyyAx9MJfqcanL9Qa
 A34fUu/2TIK9gWicDwhBInr1iAblW+fl9jRNGpIR2Wk5NfOTPqucqLC0/NwNna92XoW2qYEzHHf
 uSnYI5RbwveDkc2UU7KYIeHAx+WbkxKNMyKzd/H9yLRU6DCsYznRAudgxZd2r2vqYt6LKHEnAlt
 cvgsp5YbvBFW3rljirdGNfIAWmbkh6AyWQfk3b04t84GtQgFtI3MFVn7Y4e
X-Received: by 2002:a17:906:4788:b0:c12:6c2e:ae9 with SMTP id
 a640c23a62f3a-c16b46de9bcmr118780266b.22.1784296521803; Fri, 17 Jul 2026
 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <ex5nk6rhdq2xmoebwmbxtc3xxepoq42qlqb3u6ve3rd4inpxul@tuqk6be3rl22>
In-Reply-To: <ex5nk6rhdq2xmoebwmbxtc3xxepoq42qlqb3u6ve3rd4inpxul@tuqk6be3rl22>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:54:51 -0600
X-Gm-Features: AUfX_mwSCftQF1bc9uH9t7XpAne1f4g8ZIuWaLzH6rtVr3oxmtt7xGQpxPQLUd8
Message-ID: <CAFLszThptn1MekOUzBJ=xDzhgbVh4MMn_ycnBaY25=Mps30Frg@mail.gmail.com>
Subject: Re: [PATCH] cmd: read: fix unsigned overflow bypassing range check
To: naveen.osdev@gmail.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-07-08T14:33:04, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> cmd: read: fix unsigned overflow bypassing range check
>
> The bounds check in do_rw() was written as:
>
>     if (cnt + blk > limit)
>
> with cnt and blk declared as uint (unsigned int) and limit as ulong.
> C's usual arithmetic conversions are applied per binary operator, so
> "cnt + blk" is evaluated entirely in unsigned int and wraps modulo
> 2^32 before the result is widened for the comparison against limit.
> With cnt = 0xFFFFFFFF and blk = 1 the sum wraps to 0 and the guard
> passes, allowing blk_dread()/blk_dwrite() to be issued with a 4 GiB
> transfer count that runs past the partition (or, when no partition
> is selected, the entire device).
>
> Rewrite the check as two comparisons that do not overflow:
>
>     if (blk > limit || cnt > limit - blk)
>
> The subtraction is performed in ulong (limit's type), so no truncation
> occurs, and the two sub-conditions cover both "start block past end"
> and "count would push us past end" failure modes.
>
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> cmd/read.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
