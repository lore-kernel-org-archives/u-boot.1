Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FC7C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B377E88C10;
	Fri, 19 Jul 2024 17:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hHmEpQY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A80188BFC; Fri, 19 Jul 2024 17:05:29 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F7B882EF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b06e63d288so10875156d6.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401526; x=1722006326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EkHuuKvtrP9/IeTD6EbWjLC16V5YMYbe0WzH8r/aZYc=;
 b=hHmEpQY2U4GdfSGDjo30zLjnXd2AJ8+Rn7oQgDPRoC5+oOfPClAaEAgxCDhLWeIvWL
 jAIYgtNjuDfJ1niP2gkX8+rWRoIOjTzOhTuCZeGT+hiLChhg19Z8kV7Aogm0lONYG7ws
 rELyEzZ6qs33HHjesaUYpjTB9TrD1Ooedsqe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401526; x=1722006326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EkHuuKvtrP9/IeTD6EbWjLC16V5YMYbe0WzH8r/aZYc=;
 b=rPhYgPNNqRiL3yOrlT8jhGNSs01phxW7W8FIzSQaD9ZQm9SUD4j8dNbdygsTsrM4r5
 pMg1ScT5XKQwr+ZZfguI6j+5omk2jDf7CF0q776AvwmTUR63e0CxEBEZ84RPSqL33S5f
 jWwDDBOC1uwqy0KzMdWuaGougEDwH37Q/1WTFeP9IZvoNmx5Pu3+VpAUlYULAx9z/5hD
 jEEzkmsyx3r3opmWQ3bfc5p0Oa1/w3jDP3zZc9QKExFuqOjsotOFvmtu+B2yWduFG58i
 jAz2uOyPtEGdrKAm/LboujKNZPU9sAyx+I9pSwjSz3Y9gDUtMltCv95o35gMuqLgAkmD
 kIlA==
X-Gm-Message-State: AOJu0YwWIJv3N59GL2lIZ7b87ZaDnhKKwenqbHYPBcx2c7HGyZdmYdDf
 U8PFC4Xv3NzFzjI5eNFl/ToLwst1gRDpfQ7z8ZXdAmI/loNnVdjWrqbzPD7Og7RZwPT3T0xvGoL
 4LT9j+B5/DbV5NxMo7cU7/v3S6WgFjrNZwcNfjVvkD3nhiIk=
X-Google-Smtp-Source: AGHT+IHojR9jMYuVef3mMnR1HRImWsf0CG4PEOw2BC/0jtrtte8O1bdvzLc7SQmQEGBSOpAoRHUSoY0T1cICe2lYIOg=
X-Received: by 2002:a05:6214:1cc6:b0:6b5:53a7:74b3 with SMTP id
 6a1803df08f44-6b78e2324f1mr91860736d6.15.1721401526244; Fri, 19 Jul 2024
 08:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
 <20240717-docker-image-v1-3-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-3-7c7fc6251e7a@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:15 +0100
Message-ID: <CAFLszThR8w8jvm=D4Q=k1ob8R7Ou7E6xQSvFR3a91b=0uEAjZA@mail.gmail.com>
Subject: Re: [PATCH 03/18] doc/sphinx: Remove usage of six
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 17 Jul 2024 at 15:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> We don't support python2 any more so there is no point to
> use six here.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  doc/sphinx/kfigure.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
