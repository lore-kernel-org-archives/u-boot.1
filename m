Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DF4CD8CA1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627B885DEA;
	Tue, 10 Oct 2023 16:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VJQG39nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC88286CDD; Tue, 10 Oct 2023 16:58:31 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD7D86BC8
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53da80ada57so766280a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696949885; x=1697554685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUdRR6CGTi7LgYUiqIzcqrovLnWSbPXbB8CvwCjxYRo=;
 b=VJQG39nIbusecuygUToGZqfUDBclExMySaHZEe2bGBld2l9pjWOF+SXq3TZF0047oa
 1e8XM4r7f4QeROQmSaFQ6tsv+Xhs19U1GooZ9gVNePjRHdVmWEdJ6NGP412RwH5f3chy
 yr1xnfRM5H51FPwVaV3OyppSt2g8owJoJ9tLjL1wvGs/QRz6OYy5kLYZNlDd4iLTMj1Z
 tRA+HHd0Go+tv4GJTn96dXDclohJofWy6fn44/rqN9+jPIEnyR4Ku7un9GrZwHra1lrd
 YYud5z5ROrCPd3SbHAPWWNi9tPAyIvag/j6o7CPptnJMREJFHMCaHGgi3srBmCuFCvSv
 0OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949885; x=1697554685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUdRR6CGTi7LgYUiqIzcqrovLnWSbPXbB8CvwCjxYRo=;
 b=sbaQuYTNars0sqinvv9dOGOqG2xhPLLad1R0Eo49ttZygJZEnqE9uk34dRxl1l8OhL
 bzoKi4htqOn4Vaf8gpiY61EiGXJHvsFWbYUux4X28JdzSZZkqWU7s7U7pAiaV03rgfCV
 5JYpN2hnHodl3xv6wis118M2se8imiKXCyfkVAA6fCQM/v3xtCnJTNIW9shNVqzQM5dm
 rtMFJyb+uJxHksYnikRbT7cbxcKfugSPZ0K+b1zpIRkd01jpj3hKokyZhFdlWRQINwMo
 NyqYTBlGa5S3SzZJkNz6chfTay3upL1ykfV92T+qUy8zBCqhkKJGc/IsISpXsvymhf+D
 gIHw==
X-Gm-Message-State: AOJu0YwVbdKRuMyJs2YZ/j5dBkisFWEuXsuzJovs1H6818UCljnmcO9M
 kgleUVXBxvJ7l0WKa8yLuiAQ7SQQfFwkk5wq18TJLbDGxgdbz82CJlQ=
X-Google-Smtp-Source: AGHT+IE3fLffx9k13Fc7t2vGEY6kCF/45O9SAzKGcm0JWHK7CYsxoP+CRo4psK069TBUlv1fug4kYv2w/unrBYIu5Do=
X-Received: by 2002:a17:906:51d5:b0:9b2:ba66:bbb0 with SMTP id
 v21-20020a17090651d500b009b2ba66bbb0mr15575834ejk.28.1696949884849; Tue, 10
 Oct 2023 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
In-Reply-To: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 10 Oct 2023 08:57:54 -0600
Message-ID: <CAPnjgZ2Zp6cCPxLG7g=F0+FkDLJMheuiw-GeGbsTtH5KoAPGjg@mail.gmail.com>
Subject: Re: [PATCH v3] cli: Consume invalid escape sequences early
To: Yurii Monakov <monakov.y@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 10 Oct 2023 at 02:16, Yurii Monakov <monakov.y@gmail.com> wrote:
>
> Unexpected 'Esc' key presses are accumulated internally, even if it is
> already clear that the current escape sequence is invalid. This results
> in weird behaviour. For example, the next character after 'Esc' key
> simply disappears from input and 'Unknown command' is printed
> after 'Enter'.
>
> This commit fixes some issues with extra 'Esc' keys entered by user:
>
> 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> =>
> nknown command 'ry 'help'
> =>
> 2. Sequence <Esc><p><r><i><Enter> gives:
> => ri
> Unknown command 'ri' - try 'help'
> =>
> 3. Extra 'Esc' key presses break backspace functionality.
>
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> ---
> Changes for v2:
> - add tests and reword commit message
> Changes for v3:
> - fix indentation
>
>  common/cli_getch.c  |  2 ++
>  test/common/cread.c | 12 ++++++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Unfortunately this shows a design flaw, one which is hard to fix in
general. But this does improve it.

The flaw is that we assume that character sequences have a time gap between
them, which allows figuring out when a sequence has finished.

But when starting up there may be buffered output with no gaps. I don't
think there is a general fix for this problem. One option is to have a
special mode at the start, where escape sequences are ignored. But the user
may press an arrow key on startup.

So I don't have anything much to suggest here. Let's see how this fix goes.
Perhaps it is enough.

Regards,
Simon
