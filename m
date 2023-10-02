Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDB9E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD25F87492;
	Mon,  2 Oct 2023 03:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AQ6h/LBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606B687452; Mon,  2 Oct 2023 03:22:36 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCE087254
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5363227cc80so5825501a12.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209743; x=1696814543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0HaO8b9vgYPYTxvYBDdrOQSpWPE6SDDR9RzKXczogI=;
 b=AQ6h/LBuaTn4C7np52rufQEKYdR0HpeNPx0ZK/0ljYq+HMddKEMstp8CDgs3k6GHDo
 4f5LtJJC0XD1azbOTkm482MFp/wYuN8AE9YzkjNCSNUfi/FN/8WJbaArGFxylfQND1ct
 CgC1P96g/GUIXUvbJXy/WOpReLT2Wupaf9Vk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209743; x=1696814543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0HaO8b9vgYPYTxvYBDdrOQSpWPE6SDDR9RzKXczogI=;
 b=fKqjMcISgLG6bn73JXN/sg1eo7bCAXy80E7OXJ8YvT1UnOkBZhEDmyxjWqiuc1ASwh
 G9V+S8RG8t8xUkFnTNK0RhlTTPeuVdSdb7lWcnBQFP/3asVb4XUKrN30ihF2xW9gQrlf
 1VQEJ4V2nYUTRfzYnb5TQeQxhXWlKx1vYtidyzr+U4bIV9g9EXv7uskaXlm4Kjbs4OLj
 gqLQgb6VkorywlnhRe90QXx7blbq82oGvA+hQ7NoVfhJZGBgihGZzPFHKrCPpm5RDOX0
 Bypxlr722VSIiOq+zePZMVbwGVntI75JiE0HFWLKflep3YuaZRod9/EKuwSp6KSpgtvu
 ogcA==
X-Gm-Message-State: AOJu0Yx/h917lhtaPTrir3fP9/bV9ngjVqOoQS3Xo1WC+n349smpNsY8
 VJ5ixAtnmHA8dCkBdBIWuT+LVn9l8VMCeMZxmL5ZGG9ed7tVeHKdS4w=
X-Google-Smtp-Source: AGHT+IGbMmkYkbbfUObrne/ro7z8P43yH9ONthOHjvCTOTE5N/snuQb1pYJJPI0ZJRIN37jcHS4Moxvv4m0T198rhF8=
X-Received: by 2002:a05:6402:499:b0:523:47b0:9077 with SMTP id
 k25-20020a056402049900b0052347b09077mr9355522edv.38.1696209742949; Sun, 01
 Oct 2023 18:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
 <20230929004717.37413-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230929004717.37413-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:44 -0600
Message-ID: <CAPnjgZ3S3+_Zdu85k1EjvoF-Hh3+X6KrqV=tk4Ouon3fnY0zhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] stdio: fix stdio_deregister_dev()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Suchanek <msuchanek@suse.de>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
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

On Thu, 28 Sept 2023 at 18:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When copying the name of a stdio device we must ensure that it is NUL
> terminated before passing it to strcmp() to avoid a buffer overrun.
>
> Truncating the name field leads to failure to deregister a stdio device.
> When copying we must ensure that the name field sizes match.
>
> Addresses-Coverity-ID: 350462 String not null terminated
> Fixes: 5294e97832a6 ("stdio: extend "name" to 32 symbols")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/stdio.c      | 6 +++---
>  include/stdio_dev.h | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
