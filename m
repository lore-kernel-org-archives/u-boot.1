Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5ECA0FF9
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9FA867EF;
	Sat,  2 Sep 2023 02:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JED7NozK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6254786703; Sat,  2 Sep 2023 02:09:40 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAA686722
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-500c37d479aso4171950e87.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693613375; x=1694218175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4yDTXGtIEfhJgHeQCyheNdC3Ic4E98RDXcxguXcqZns=;
 b=JED7NozK6JydIqfOzbO2aoDlI6zj3KAM558QjE+uCSiJrzwJGVFI1iTlW0yTNSROcW
 nsHh61nbSELGRwfjeM3seBBwdawZufXosyNm+oC7nRs1Ib9WsIfPI0Vk12XU1S6Z3oiP
 VG0Psv7AbqZ5aEg5P7ej3K+gvb96/Sc03vcLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613375; x=1694218175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yDTXGtIEfhJgHeQCyheNdC3Ic4E98RDXcxguXcqZns=;
 b=LVzVh8QwSyCrY95MysSFqAmRsDWbSXdgmVIvMw4gPclYOyc4IvY/sM4JP4CcBtcEFk
 MOdg3S9u4OUm5yx4X3OliDjvJRLh5E/OWlqAvkjLxp3zujd6q+F7Gby4DBc22WkIvKmJ
 /sMjtGBkxlTRAvedcFliGonWto4hLzmGN9xM5XScCAO6n6TYp6oOJBfJsntI6MYZHbfy
 bjptvLQQxDJ8fIut8tZG9q2FJBAyQalltPxT50QHHM37GVAxnS3PSigHRczwkfmDhHSd
 Ut++pySHHy4/cuMqxi94FuB3RvJaY4iYSPhD08QqIw9S9cYo4/MTUiGe1upXQDzEnfJC
 bW9A==
X-Gm-Message-State: AOJu0Yy7iPLASUoDjI+4Eeqcum+gE5pY5RLl/7uMP/WGXvx4y46neKM2
 STt3M8GVnmtrSGHUdgGC4f25Z3hluN34ZvOLmXkPVQ==
X-Google-Smtp-Source: AGHT+IF+X3xq7qY//ETeXSpjshsNJ/arbSAoUm8wGoe9zDwzPIdMJ0xmKaMivigpk50DrwznGfzUl3w/obpCTGyMqiw=
X-Received: by 2002:a05:6512:3051:b0:4fb:77d6:89c3 with SMTP id
 b17-20020a056512305100b004fb77d689c3mr3048579lfb.12.1693613374555; Fri, 01
 Sep 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901050532.725-1-maxim.cournoyer@gmail.com>
In-Reply-To: <20230901050532.725-1-maxim.cournoyer@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 18:09:20 -0600
Message-ID: <CAPnjgZ2n-z9CEn_ej3HqNP1C9j=x7E0U-WcmnAyAHFCSeOWWyA@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix patman launcher script.
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc: u-boot@lists.denx.de
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

On Thu, 31 Aug 2023 at 23:05, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> There is no "run_patman" procedure in patman's __main__.py file, which
> would cause the following error at execution:
>
>   "AttributeError: module 'patman.__main__' has no attribute 'run_patman'"
>
> Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
> ---
>
>  tools/patman/pyproject.toml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
