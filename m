Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B274C10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F09D87651;
	Wed, 29 Nov 2023 18:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lcmgm9SW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82FA98778B; Wed, 29 Nov 2023 18:47:47 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BF687762
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso2969966b.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280065; x=1701884865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SXQ1codGgjOX+sT0/1pDbWxPMpo/Ya3I3X1to8XCtb8=;
 b=lcmgm9SWql2fPQ+CqJ9mA6peVUU3Z0SW5iqtSqssVnOG7hYDa5VqoSEG3wZR7twF0q
 eADvzy49A5jgBcCzXWzv3BFPARFP4tLkouGUt3JdSFW4BwPvho5Bd9sh3onNR407PRxG
 6Wum6qHvPAF0WuP+NagRzqWNmgwrwL1UyJcu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280065; x=1701884865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SXQ1codGgjOX+sT0/1pDbWxPMpo/Ya3I3X1to8XCtb8=;
 b=GvLknwxlZfadTJGuk4Je1D+ffYuZSlc1qC6OO/eUKFwDdbpzYRrNfuTHukqalx1Q8u
 i7MAaGkUOcZ2FXD8QY0ro4rM8wEdTQpvF+GCkDsgHKqeF5eC5iZZr138BZDob3ofToHu
 SUlb9zngPoUAZVg7Cex3zVCYY+6UMc8bbtmt7jlOGlgLNAsSF/eCVjgzLE6asqv5S16c
 ACZDj0qQrCRPVfiijRfdZ2BeBFZ+E4j8tp8xa0y7ARD65d7ZRw15Q4CNFvJ1/K3d1pgv
 DKTerNVetdWa0lTvzfbBmsnSv9s4maepkQlQ0YpKUHsjTDTqZStxDJPIzrb9tMWrFYH7
 TcFA==
X-Gm-Message-State: AOJu0YxFikHdwB/2gMWH8Cm3/h45DJqQNv1MthnlFh0FDkFHi4Fs0zQd
 55isfx0v9WV3qUx8zGajDaClSOwPM3Jbn4GdXDm7ZQ==
X-Google-Smtp-Source: AGHT+IGj0vhmhuaPTzqtIaZ++E4d+xP0VUWb88fvdDWF6zDE/IrMbu04Abptl528WCvL+68zqaX6JiqZ+HqDlt/nvTw=
X-Received: by 2002:a17:906:7e0c:b0:a02:5ebc:ea81 with SMTP id
 e12-20020a1709067e0c00b00a025ebcea81mr14393616ejr.45.1701280064976; Wed, 29
 Nov 2023 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-6-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-6-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:32 -0700
Message-ID: <CAPnjgZ2fcvgHo183QNNCNhSDzAmNR89+w=WegsOkrLsaXpekkg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Required to fix the following compile error when building sandbox:
> /tmp/cci9ibby.ltrans21.ltrans.o: In function `do_cedit_load':
> <artificial>:(.text+0x601d): undefined reference to `oftree_dispose'
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/ofnode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
