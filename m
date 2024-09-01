Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C363CCD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85B188C40;
	Sun,  1 Sep 2024 22:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eO3UpKmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8BA88C30; Sun,  1 Sep 2024 22:10:18 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED34688BEF
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2055f630934so5387395ad.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221414; x=1725826214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9bzG096rqIQ8EHfLLZxBPhpHSw0dxRJNohj3xtfGBBo=;
 b=eO3UpKmkaYEUn3Coss7JopsMefCRrW5fcQbfT8/5sUjePptolFsb1rG1gNx1zWAYF+
 zotGjPFqXwR71esnt0KIj/QuUxFCaU857nkJnxAfN5FzWuWmj4HuQrLAauKOIdJQTo2R
 7Kn6ME+uDjqO/7UNVS4wDSUoDNAMdOE+6Hmuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221414; x=1725826214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bzG096rqIQ8EHfLLZxBPhpHSw0dxRJNohj3xtfGBBo=;
 b=LcTL0u00SlK5yry1fl8N1Mz91qd0NgFxQ81yFJwWphT3ZKIZyn6m9JPkox0mt2eynC
 jn1TUeFhcEQanHorIuZT8aln7eo4xYdzaKLJzgUwiVZYud5dvLEb9jW+rSaU5O56U4iB
 Ho23x7UChH3LTSmS4UtaPqu0ngAHYudm2iA+cWmB9ZHN6M7G9s9rX3BgUc+Rd6gvg09e
 PeoFMxzWOpN4z+eC695jve81PbxUsBrHHXQpL9juJ5qR9ZX1jJaWHIazr1uWwUL/hoSP
 3I3VQ0oDlHRsWsKTVcH5bp62zeOGQibDvPA/OKMPv7jZ+7fHhXEFOlq0wisteiw2FWep
 b5mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN7YlxwecynVFbPKDy8D5y5b6Qwic6NeAqijHlHFXeduzbfGsHqJ8nIMVY2jgHnItaYPKANlk=@lists.denx.de
X-Gm-Message-State: AOJu0YwaiEGDvbUpWGjG1/En8ZdpqfHPOc9ydTBks/zNov2A5diAaLuw
 tIQhcCSbL+ELCRebOavjzsxoi5EKdNqbxv9nMTYeOwgWssr80la/foSBROvOKpXK754s1tGseca
 OzKj2pe1HB2M+cpRlIUlPUvxjIV1VorSDd9eE
X-Google-Smtp-Source: AGHT+IFQVwhyvjtlP+rNyuttTDoucQFR7o8yTgGD0VKB/u3n8fSKKk6WuADyf8kZ/+o750ddvwgm9Vcv/BEy55bYo7E=
X-Received: by 2002:a17:903:32d0:b0:205:36dc:c3d9 with SMTP id
 d9443c01a7336-20536dcc7femr87599395ad.33.1725221414432; Sun, 01 Sep 2024
 13:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
 <20240812205638.1732159-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20240812205638.1732159-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:02 -0600
Message-ID: <CAFLszTjhGt4K=krtfhF_5SvqcE-yGxCN=1jNgMHKvyUg7vUPQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: rename efi_bootmgr_image_return_notify
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, kojima.masahisa@socionext.com, u-boot@lists.denx.de, 
 akashi.tkhro@gmail.com
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

On Mon, 12 Aug 2024 at 14:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We use this event when returning from an EFI HTTP booted image.
> The name is a bit confusing since it suggests we always run it,
> rename it to make it clearer
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_bootmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
