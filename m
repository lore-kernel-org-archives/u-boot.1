Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C69C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3743387800;
	Wed, 13 Dec 2023 20:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bftnOfO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B547387800; Wed, 13 Dec 2023 20:51:43 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775E787834
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e282ec7537so14990777b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497100; x=1703101900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1I9nNlk2vzr5pDpYEq8IRDL1Obt1saA0qdxmYe22yn8=;
 b=bftnOfO7Xo6No4gm8uRMAJncBkirYijKn/G5CRZmcZmQTvy10ffeM6g0QEk2ZyRBN6
 LNQh/vLAdoGdA/M4Abijqixwuoy0bgfv+kx6SscOZoQ5fl32u2kUDCVpDWCOOYwqZ+WX
 x2AH5NUYpeC6NiMzxxUGhHvWMqtI7nExFhRIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497100; x=1703101900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1I9nNlk2vzr5pDpYEq8IRDL1Obt1saA0qdxmYe22yn8=;
 b=QlkolycJvm93Cgp3fiKqWx+JTZKH8QF8KnjA2ShFvrylmdc/WYMg0ClhE6kBQ4bAGo
 pyvwHgouLENFtHNDU+Ykx6dEXdtTvqQyH/p3gAmUtVOomkkxjs8HMqUQec/vGiAnPw3i
 xV/fsrSzQOwZlLT0KipMpfXLpW7lceTCThiDt7IQZY8C6lwbdBajcev3XuoY6h/vc1g1
 DbgihyDrCf4qLt4IWeQIkt56kuqEozVBo/T7/X+Z8iW5cNOsORN2v/YxUs30SQwWLMAt
 RYOLythWb9F9DyRQJg9ywcyBfxrI2CIL29Q1mMdjrc54fVWplxLz7RGD1T6NojNIWwfT
 ToZQ==
X-Gm-Message-State: AOJu0YyatpGLBzB+aKPBi6+ypulpkseWuxV8kHPOWjkRxUK0RAdX7D5u
 20pq8/Admi3xkdvfklam/iN8ibUFsYRctGW4rkZDnTNdgUPb7kaqYo8=
X-Google-Smtp-Source: AGHT+IE09h658WuBMFMg3779/+2y8qAZpXf2nxQ+x6EWDub000KvY2fh/5JKsWVvFAw0/oUwJSqVCBZExwFIXhqBp8k=
X-Received: by 2002:a81:6042:0:b0:5d8:e5e8:b775 with SMTP id
 u63-20020a816042000000b005d8e5e8b775mr6727238ywb.15.1702497100072; Wed, 13
 Dec 2023 11:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20231210212522.398132-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231210212522.398132-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:05 -0700
Message-ID: <CAPnjgZ1CTzxpMivHP7jxQR3esHVPRAGTp7xWkU_pHNSfPHxkXw@mail.gmail.com>
Subject: Re: [PATCH] cmd: part: Cover both part type entries with GUID ifdef
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Sun, 10 Dec 2023 at 14:25, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The 'part type' subcommand depends on GUID partition table support.
> The help text exposes one of two 'part type' subcommand entries,
> hide both in case GUID partition table support is not enabled to
> avoid confusing users.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  cmd/part.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
