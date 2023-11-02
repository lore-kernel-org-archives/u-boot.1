Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D7087755;
	Thu,  2 Nov 2023 23:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aLsk1a40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2728774A; Thu,  2 Nov 2023 23:49:19 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C770087725
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a90d6ab962so18009587b3.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965354; x=1699570154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SiZYmzEaI+WiClKAVv4YgvfNZEg52BE8TQpgmcHJRks=;
 b=aLsk1a40TT3hEYPQzbBerUSVQtJvWFp8hXeCZ+j91419owG7fB59QRlVfWfpfY4k2N
 KR9GeY+5FnhLxmlRWw693V+3MWsuWfK23Ch8mJqr08HKWLTe9Myjrj4LfCp8hCONWAb6
 64IBncLAjodx/wHBxC8Y0wWRfob0KPgun6kjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965354; x=1699570154;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SiZYmzEaI+WiClKAVv4YgvfNZEg52BE8TQpgmcHJRks=;
 b=TDWH7J63xRGoJaB1cRfsWWP4/9h3mfFdE4C6DgUa23cGlOMLzJNkAKy9UU2cUU0PAg
 9UOo7bRnZOMjKT7zLfrS0LpVHbDbCXCWqog0ucUPd78e+NKzZYgY8EpyzOYBhPJyoJpg
 UxJ47uHyB3PxT0jSMVpKzv97Xc0LPiXXjqMgKt//1WE76xja7cP19jq4CsEpFcFrIx97
 C3prLuXe4kRp27MSWDrrggSHs8qtpDF7LjDvp8gkSX9pv1qk2KziB56w2tQGqZF/kv2w
 Lzv0j9EaX07KJCr13nNa3J33syZKUBG7T+YmuQQUlfAz6IzcblD+TUjpjGTe4veyVKIj
 H0rg==
X-Gm-Message-State: AOJu0YwvQiwtzfNuj0/jaWAlBmHl582YJFz9vCY7qgi3MMQyOUdNQvoE
 jmmccwrOWkEurMF4I4pyuFL2QesCvE4B5tJymMJmUd1nMR8sea7IX/w=
X-Google-Smtp-Source: AGHT+IGzm0apYEY27OUZz+DJk/DgbT5keD3ZHxscv5EyYpuNkfZbWVuNnHsAWDAa/biUEKo1uknxOj565cRdkk2BwCw=
X-Received: by 2002:a0d:cc16:0:b0:59b:ec85:54ee with SMTP id
 o22-20020a0dcc16000000b0059bec8554eemr1358796ywd.39.1698965354334; Thu, 02
 Nov 2023 15:49:14 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:09 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231023134012.GI496310@bill-the-cat>
References: <20231023134012.GI496310@bill-the-cat>
 <20231023005242.1.I573d6fb6587a8fbba2ae3783a42c4587ed6572d4@changeid>
Date: Thu, 2 Nov 2023 17:49:09 -0500
X-Google-Sender-Auth: aiPIApNeTTPQaxeStDmGsxmsfwI
Message-ID: <CAPnjgZ0RW3-YVN=NPTB+nbuj+dbqeCkM=pguNLsrMgVg3YGn1w@mail.gmail.com>
Subject: Re: [PATCH] buildman: Include symbols in the read-only data section
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

On Mon, Oct 23, 2023 at 12:52:43AM -0700, Simon Glass wrote:

> When symbols switch between the inited data section and the read-only
> data section their visbility changes, at present, with the -B option.
>
> This is confusing, since adding 'const' to a variable declaration can
> make it look like a significant improvement in bloat. But in fact
> nothing has changed.
>
> Add 'r' to the list of symbols types that are recorded, to correct this
> problem. Add a constant to make it easier to find this code next time.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks for fixing this.

Reported-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/6

-- 
Tom

Applied to u-boot-dm, thanks!
