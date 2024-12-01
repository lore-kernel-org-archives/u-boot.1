Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E3BD49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601A489738;
	Sun,  1 Dec 2024 17:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iJmhAt5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F24B89722; Sun,  1 Dec 2024 17:15:14 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC273896A7
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724e113c821so3008026b3a.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069707; x=1733674507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qZQnqIQ8K6yAnRrR8YxSSgdMVC9WEnJZwN4lX42SSmQ=;
 b=iJmhAt5Q9wq0cCD6LBirVktb5zS8GcUKMlNrclDu2ACY0tzAEuZuC5rc+/h+YH8xs7
 zdWVhnwEbZ8OSlmpdWM1ryciczX9cRtVE0BguJrHmGdjw/tJtbRrSrauHHB54somkSE5
 YFPjYlCWsXrbi1R+G1wsqU7QEVUI9nk3R5gz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069707; x=1733674507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZQnqIQ8K6yAnRrR8YxSSgdMVC9WEnJZwN4lX42SSmQ=;
 b=lIIJ97wCub2M+5dDA1uhZuez+PAJ8EIcPpFtJ6O8TtwnWqHjO8DTa22hMF9t15HBqe
 wiONTAdPjt0QUI6vyM7AoLTWScIBBkpGgRQbqb3+SydFXp9AFchHVclycHY9GAlgAtio
 qKwyaswpPNduoZQVLOOF4t1A13NqtnKMIS9yaSwpZAEf7bU/6Z3Mbwj0ZFYDkRn9CQYo
 RJXq2n4mR3INOKxcAoOTM/Y/SXPU88BpWNPYJWTnuyd7f1QzVW4jxigKnEm3MXnwyA9n
 rZRSTJAgleUwAC0uLCsxST0R4lfRmWKBuE3QRDLKug8bOBXFF0K/bYGyDiIudcAIqAz4
 mjYQ==
X-Gm-Message-State: AOJu0YwD1+moR91fpwWm7N0Ahn3+0Yb5ajxmc1uZ3xzaMDp2p9f5SqdW
 IFRs0y4dF/AICO64KCtK2jvL/xwniqyzn/xmi77vRGoJfmyHjUZwCQEQNi+BnFM743MAe9cMyW5
 LNldiQMhymWbwcrTHbzRMdic9xDkOZE8OawXQ
X-Gm-Gg: ASbGncu+Eyac835amwQ4ZBWCDbDLK39MZ//sfORU5kuvJ8VDAlGbmT47hTdIw3V0mZi
 YmaWe1moykyXClbC5W8pAZgGivz7+DQ==
X-Google-Smtp-Source: AGHT+IFmAKcW8+RidpMthYQkm+a8eXW5cIrpZ4L6tNLCx+vEYSxlLwEOA0JUXrmhRUMM8+SEBBiIuZjBeOJVM0D+DkU=
X-Received: by 2002:a17:90b:4ac8:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2eeab0411a2mr4547419a91.17.1733069707463; Sun, 01 Dec 2024
 08:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-10-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:14:20 -0700
Message-ID: <CAFLszTguwP-7wAPv32UHvW10ORqtK35ZgiG_GpWiFXW8o1QRMQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Janis Danisevskis <jdanisevskis@aurora.tech>
>
> efi_bind_block had two issues.
> 1. A pointer to a the stack was inserted as plat structure and thus used
> beyond its life time.
> 2. Only the first segment of the device path was copied into the
> platfom data structure resulting in an unterminated device path.
>
> Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
