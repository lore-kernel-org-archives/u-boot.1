Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD9FC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 04:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D156C880DE;
	Tue, 14 May 2024 06:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="isSVB6PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8BB88246; Tue, 14 May 2024 06:08:00 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2B287CDB
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anand@edgeble.ai
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f3a49ff7dso6647102e87.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715659677; x=1716264477;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlZd9AEqnV8mMu4XVxbmzR90JWuoqIPNFykPRh+dYtc=;
 b=isSVB6PJDNtcgnxaluxOTSJHRDMSu7AEkskLyKSqm+dcscRgVk+Qq1sMaadmxownYT
 ferm+DD5/KS3ZwXp4fwP8f/DsffZeOmZ/vAGROKe1JbEXioMT3naddzPe1VFzOJF/lOJ
 KyTpoOnaX7zNoND1ZJaJU/dQD448iaFZ8Q6tCrqE9xVBk/3TMWvwLp1YSiH64i2x6XAE
 ZxzsiwQK1N3ho2fVIoCN//hAHsV7d3UEJAMF3n20GnkQhtOt1W0livcAVr69SrwxmGSv
 WMv20qTMR9PG7MHZlEH7SsmyBgTYBl3hAUUxNV3JkpUUUJcGTChuQKgxqAOI34Nu8UVy
 ky0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715659677; x=1716264477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlZd9AEqnV8mMu4XVxbmzR90JWuoqIPNFykPRh+dYtc=;
 b=AdPylYu4XCITQ4nS18yeEO8bALgO9d6LsWu4wBAaOs4oxjCe+xaUs4FsB5wmzoXI7H
 n/h2gi37R+9gMdweoX5KX7X9GhOl0QXUo1wrAipdJrdhi0vOQg3fJx0LD2pWkSfHJGaQ
 CIdcr9RU2QRTHhuvJSL+7q55AOWUUtugRLCYMuVvZAea576uHBmj5rgqn4ANTF5YWmj0
 wpZOUQzhI4V7BQqRLP+M4GogWS/QJWno1oqVIrRx2vsFylQ5azAZho3v4SS0mjqk80CA
 oGTsx1XYwg26TqGhd8YfyKyheaR0/ljDnHh1RssOo0dKghw1t5BifddzoOqmxD01H9/K
 Jc8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd9EEZCwTgetDs7tDpSCLdol75KqM31u2XViZ9b14lJ0Qhhj3EaFOZxBpfQiJz+4mjuUZs8661WH4hiUQVskHYjASuYg==
X-Gm-Message-State: AOJu0YyHylFFpBPu31SWIsPnNvDBKWxFjufuumfQhNojl47zhYGVQ/T/
 8lfraauE/2tGtL+VBoQddqEii6aR4AGC2sI7KEZGGWkFukbrdPFkYldvzEOs7EH5Du2Zc6WBg1t
 bgtvZ0yUkNHK34nTQRyWMSVcFvgQoAmzJSH615g==
X-Google-Smtp-Source: AGHT+IG5xraivrMfm5EDDBMhPHTsgnGXqnGIMze0MFjJPPZ2eO5MVB3yuS5PBKlBEAaVzJGYym1sWFe8wVs+Cwug26o=
X-Received: by 2002:a05:6512:2310:b0:523:70db:7a0f with SMTP id
 2adb3069b0e04-52370db7b5emr372001e87.8.1715659676858; Mon, 13 May 2024
 21:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240511161224.1176-1-anand@edgeble.ai>
 <6857bc47-895d-45bc-9b7d-d00ac7b0ec1a@cherry.de>
 <CACF1qncdn9y+bE6vwjCBOAdseTkwPORMHfJ2JFJt6m7ECHGT1A@mail.gmail.com>
 <e8bdf854-db5c-4292-b469-bb678d75d498@cherry.de>
In-Reply-To: <e8bdf854-db5c-4292-b469-bb678d75d498@cherry.de>
From: Anand Moon <anand@edgeble.ai>
Date: Tue, 14 May 2024 09:37:46 +0530
Message-ID: <CACF1qnd+uOemB+8qjQyndf29m+O8yQW+BkTdXNEazSD5mUqhNg@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 14 May 2024 06:30:10 +0200
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

Hi Quentin

On Tue, 14 May 2024 at 00:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/13/24 2:07 PM, Anand Moon wrote:
> > [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Quentin,
> >
> > On Mon, 13 May 2024 at 16:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Anand,
> >>
> >> On 5/11/24 6:12 PM, Anand Moon wrote:
> >>> [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
> >>>
> >>> Following targets is migrated to use OF_UPSTREAM:
> >>>
> >>> - rv1126-edgeble-neu2 : Board is an industrial form factor
> >>>                           IO board.
> >>> - sonoff-ihost-rv1126 : Gateway device designed to provide a
> >>>                           Smart Home Hub.
> >>>
> >>> Cc: Tim Lunn <tim@feathertop.org>
> >>> Cc: Jagan Teki <jagan@edgeble.ai>
> >>> Reviewed-By: Tim Lunn <tim@feathertop.org>
> >>> Tested-By: Tim Lunn <tim@feathertop.org>
> >>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >>> Signed-off-by: Anand Moon <anand@edgable.ai>
> >>
> >> Doesn't match the mail address sending this patch :)
> >>
> > Earlier I sent this patch with my email ID,
> > Since I am testing these new boards,
> > I will use this edgable.ai email ID for source code changes to boards.
> > if needed I could send this with From: Anand Moon <anand@edgable.ai>
> >
>
> Up to you, it is just particularly odd that there's only one letter
> difference between those two mail addresses, which very much looks like
> a typo:
> edgeble.ai and
> edgable.ai
>
> But if this was on purpose, nothing against it :)
>
> (I made a similar typo in a kernel patch recently, hence why I brought
> this up :) )
>
Thanks, I will take care in the future.

> Cheers,
> Quentin

Thanks
-Anand
