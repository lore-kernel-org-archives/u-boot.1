Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1281CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F45386D38;
	Thu, 21 Sep 2023 03:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ESc+Wp6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43C286D1E; Thu, 21 Sep 2023 03:06:15 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D727386D4B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59e77e4f707so5519327b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1LV5S4XbepWNcK1wynQjdS3D0FcoWcDKjkTAURw8k8=;
 b=ESc+Wp6SbsMK576ly36NMudJzkMr5wwtZrZupdAkgpfR9BVr/wxZgqydqPsc73/vN2
 r7/RygU3FdSFsB3IAHEsT29/3xOHawZdv3AHNwVOHm+T9PT+kCo0SER7bB6f/z/NSd+5
 GKJjsh4N7dNahewRx3nJTvcQvZcxmkQRHVR/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1LV5S4XbepWNcK1wynQjdS3D0FcoWcDKjkTAURw8k8=;
 b=v89xxJAgTesFOOvd5AEKIf2nX94NQaBP6Ghke2O9h26xrUbcTAzFZQN8ZopvfR9kXf
 KlYmz/u5mNOepX0jjMXfc5o9UgQV1+DwbrEtlzSbGlQCNqmotBfW3aOTO4pOzh+2HtGa
 S/oBhRa2QLx1LjijvuWdwM54vGF0cmD/2lIRSuwSYl394jTrSgcUUhFeJ5d8xKkaZEEh
 Kd2ep5M74W2s6FElm22RGEDtIwIBHnWa3eB3cOD/6A9u3EvtgpRGrznoS/mjZf9mbTud
 oLFKSUOXnpKiQ7OQRNvSAZjIcbIcX3xorL7xRymUBnBqIOm05IF2ce3F0ZRddqhfo2jo
 DEIw==
X-Gm-Message-State: AOJu0YxPUbYLxBWCxWgrAIjpa7M+8rTG0ZiX8qtftngWB1szz6C2rXWn
 D5Fjy29WVPes68VOuskLGwOLwIHJv+AizyZl3DUyzg==
X-Google-Smtp-Source: AGHT+IF1ftz47wKO+QvUPjz8VjpPMUkR9cnlRkG/1nkd2/d578QViSJj51WcBvqXqMFA+aNPWVErGG75p82TkYYCimM=
X-Received: by 2002:a0d:f082:0:b0:59d:d85e:795d with SMTP id
 z124-20020a0df082000000b0059dd85e795dmr3688577ywe.51.1695258365283; Wed, 20
 Sep 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-6-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912213504.65513-6-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:27 -0600
Message-ID: <CAPnjgZ0JSuyATDC37_x48CGzNBki=qDBtf5K1TuDhH4E2imFbw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
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

On Tue, 12 Sept 2023 at 15:35, <seanedmond@linux.microsoft.com> wrote:
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

Reviewed-by: Simon Glass <sjg@chromium.org>
