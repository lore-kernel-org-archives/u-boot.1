Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4972FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AACD87754;
	Wed,  8 Nov 2023 05:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y+YEiFwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE1087738; Wed,  8 Nov 2023 05:27:08 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8108775F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a84204e7aeso76306457b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417621; x=1700022421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dKuqqEhLeuR8vFIyqQnqz0drZHLrXssPA8aMZ9qehjE=;
 b=Y+YEiFwWtnJEvi8EglH7YcI2czNFXJhexroy0H0zPHjhYMteJx+oWB+AoIYqPYyX5a
 E5i7aSWHg9elBmOxmyZ/n2fVE5AtUMcb243xyUC+W+RXNbqAKGIeuyhoOiCvontpFir0
 +Qhq7kj9nUKH9ia9Z+ciau5oRB7Ho3NEMiAT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417621; x=1700022421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dKuqqEhLeuR8vFIyqQnqz0drZHLrXssPA8aMZ9qehjE=;
 b=Cg3+xTply82DqJgr/vkwlw8/e9KTBCUYdQQYcDDB+e11770Wk9NmBCXNGSsKq/eXUl
 meyJjuU9B1sgnRtpfXNjizsBb7qKQVfM+NChKsmUiAYioBu8smoeD1wqwskQlSHN9lt8
 KrdkF37CdG6lxe4gh72NxExXJDXvITdM+tnQBDWMODe8aIFm4gO32ipC7KibsyZl4zgf
 RKqaLYTpxXtn1+5jYYnD0aisMsYqcApiXyPfsUsUE8rhHuRZL/ciRq57a06YNF9DOFFU
 6/CB2e4lOnzu1C+dLrIOr8lJRlRvIxbCKoqExpyFMlcnYdByRoRGPRN6EEQ8hE3tK1gW
 liYg==
X-Gm-Message-State: AOJu0YzNpUfmm+eSUEnKwFaQQ2gJ6louDpyq3X7tPAao3He1owSr1wEg
 yOg2MY047pLd/S0l9SBKYgr2AGt2WqCN0e1lrjuOgHVwNMc4LZ6Hk30=
X-Google-Smtp-Source: AGHT+IGgIEz7XLC7ZNQdksYuzKrRTxl+FRALyuBx60s6TbYqA5SFT3sodQDd2nod3ZzcyhVUlAWoSwHOfK52W3+Q0r4=
X-Received: by 2002:a0d:d952:0:b0:5a7:ba09:52c7 with SMTP id
 b79-20020a0dd952000000b005a7ba0952c7mr691962ywe.11.1699417620606; Tue, 07 Nov
 2023 20:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-26-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-26-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:13 -0700
Message-ID: <CAPnjgZ3x9SsxG_+zvEXUKaOtPB=R-a3_8RMEybkin3YgObcdYg@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] spl: fat: Add option to disable DMA alignment
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> If we don't DMA-align buffers we pass to FAT, it will align them itself.
> This behaviour likely should be deprecated in favor of
> CONFIG_BOUNCE_BUFFER, but that's a task for another series. For the
> meantime, don't bother aligning the buffer unless we had been doing so in
> the past.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/Kconfig      | 18 ++++++++++++++++--
>  common/spl/spl_blk_fs.c |  5 ++++-
>  common/spl/spl_fat.c    |  5 ++++-
>  3 files changed, 24 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
