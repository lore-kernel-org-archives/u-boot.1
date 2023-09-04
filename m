Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79422C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0692086964;
	Mon,  4 Sep 2023 11:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UbH5UnFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D6086967; Mon,  4 Sep 2023 11:22:33 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E1B86960
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so2023996e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819350; x=1694424150; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6J+t7tJ6zolUtVzcGxgBShJ0JbZsRo2SeCd27x/m0g=;
 b=UbH5UnFS23a3Rrkc9s9s4uAWcpd9vFqftt9ho9/ZYZfLVsnL2qUgSh2GbINDOC4fJF
 ApT2MEqRsBCndhf/3wXQu5mPBWnvJxyGSnnrng+UzNO4MBEIMLyD+l+FcdXl4BgUqoGz
 20mp9T3szxEKe400DmXYZ9fiSExzXXsRC7/ulYT8c/6TPsN5QBcb6L/SdpQ837abUSJL
 8VwApTDD8ah+hzNFR7R23lw9QoQiynd5A75+O/ieT/kr2sAxFU+bkEI30AR5q5OkZ/M/
 +p5brHs7ahS3BNMZNjkq5X0B+SDzLSiZxu825qWNk6MVNgy4JYRj8S9mIUPvAtZZpcOZ
 rs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819350; x=1694424150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6J+t7tJ6zolUtVzcGxgBShJ0JbZsRo2SeCd27x/m0g=;
 b=kD7eH97AqSQdaWsdn7SZEKiDQcVo7lqlGdNeCSoooFCbkGoHZgQWyKv1idue2H8OrV
 dLGXSsl4rOrlQJvEwjide5dKQKylFcGjGf1m7S0cyeqmPkNq0QFlkk672RpO4EH/hFuQ
 Iaa0WR142AEZJhPAU7W2B/6j1JlVQLokiS3uNGFiJZ5eP/i4qkXWwbPv3+tkOW9NA2pS
 P1AX6kHuSrFyMb4zsWH3LfXCS8Xh1J8DI2nuav97tQ9GiKZ1haCS+krkanUst2OGO39D
 sxgF6riN/9pVh3us3l/6wjHjaAsO9dhr1fGOpCLFIxdzx73YnAcSR63ZtuPZESKnCQZn
 U1sw==
X-Gm-Message-State: AOJu0YxiqCdWqFYSX+wD/ShrHGw4D+hMGAwgpZsxw8edeVz/YDH3kJtQ
 HEXIXCPO7avEE9RhzAl3sXpqntwMDHOF/QFzdEdd9h+lKzq9Zw==
X-Google-Smtp-Source: AGHT+IEpEAv6sQ2I45mr8Hy/G5UBYOlNQVEwk4AGrBlOMzXl5qGp20a/5SESGs32TdvYFtEfjvZJ+YOtQA2I6Uvwrms=
X-Received: by 2002:a05:6512:487:b0:500:b679:ad3b with SMTP id
 v7-20020a056512048700b00500b679ad3bmr5358956lfq.53.1693819349714; Mon, 04 Sep
 2023 02:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-9-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-9-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:22:15 +0800
Message-ID: <CAEUhbmUJ1586i5AW7mseEOE_CQCMm9jOBbNbTNKdLdy6BbMKGw@mail.gmail.com>
Subject: Re: [PATCH 8/8] x86: doc: Update the list of supported Chromebooks
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> One is missing, so add it. Also mention the SoC used in each.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  doc/arch/x86.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
