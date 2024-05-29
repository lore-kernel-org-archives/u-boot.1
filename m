Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6859EC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBE188663;
	Wed, 29 May 2024 18:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A6Cm3DbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380DA8860B; Wed, 29 May 2024 18:30:04 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2727988210
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43fdc0bea19so10529881cf.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000201; x=1717605001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4/6v9FsZK3UhMAv/5Y9pIhxZWac9gX1QupA8QykS+20=;
 b=A6Cm3DbQfaGtVzm1AMpgeGaGCVfcpOjggr6XtdhWHcRA5dsMjUxMUt/nTmt5/gLwTk
 uEXEOYFyttLiZYHYWisadGfMoGcQK4aMdy08P7cDDtYRCcbobQmvM6NTk0EdcNLQ7dub
 MNSobcSaVXXN0r0cZMeIuEc9rvqI0kJpZblh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000201; x=1717605001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/6v9FsZK3UhMAv/5Y9pIhxZWac9gX1QupA8QykS+20=;
 b=J8JzEMuLe+Ek4T2p1tPgEeRRVwN4lQRDFuHbnK9fQ5YzrdMyT3qjbvkSldgLAo7jA4
 yP90y5JISSVbVadbTXFmjtgZCkJLAJs2fraqyM2fRbo/GxcVH6WX/YoQEQ2tTjli6PLd
 NF/n4HB7hj+WQ1m1Gcim17TQY0U+AemDnZKeDg18PUwVs+nJJuFsn7Mly/v1cAg8kogr
 20uHXLKAR+umlZ6wkHljYJiixdMvz1QBXVtAV5D0cI2qKSsFkFFnzKvRGxQN9ALgY/6z
 hkuF8rDaJvCKZpWkDCL/s/fJjQ7fHTZNQ+5xYc1oGJYiZLctTBq0nd2n1Yas5Gl39MKq
 kUNA==
X-Gm-Message-State: AOJu0YyHceYPrqflkrSZSDiX0LkS14xc/9aFETc0StJXZ940mR+3/37e
 hkomKs7aJ5JJdDRCpc4O20Yy6KGQCg2Lkdy2+VqUuM0xSTj9zWUPBj5v7uP/vAXLItbtD0W6JZD
 rOCJOYpNj9MgxHuGWUVeKbdIjLWd2aVuUinIu
X-Google-Smtp-Source: AGHT+IG6iKPnOXwD1H+0R/YITSD0xHlNobr0BrDnyfmy6TzO0yaGoUQ6kITo0Bgw2G5LDbaDRnmaCRhq3f4o//wrl1A=
X-Received: by 2002:a05:6214:5f01:b0:6aa:5a46:5dd3 with SMTP id
 6a1803df08f44-6abcd107c22mr203346046d6.58.1717000201055; Wed, 29 May 2024
 09:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240525081053.2818481-1-net147@gmail.com>
In-Reply-To: <20240525081053.2818481-1-net147@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:29:50 -0600
Message-ID: <CAFLszTizGyw3WYKu22Y1sPaUrmCnpoBVfVuOM-Ra97fEnd+byg@mail.gmail.com>
Subject: Re: [PATCH] sandbox: enable support for the unlz4 command
To: Jonathan Liu <net147@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

On Sat, 25 May 2024 at 02:11, Jonathan Liu <net147@gmail.com> wrote:
>
> This does not work with sandbox at present. Fix it up to use map_sysmem()
> to convert an address to a pointer.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  cmd/unlz4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
