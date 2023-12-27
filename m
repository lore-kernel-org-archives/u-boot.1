Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E465BC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A7787956;
	Wed, 27 Dec 2023 16:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HcTuo5f+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 850348798B; Wed, 27 Dec 2023 16:32:14 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F6A87834
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cd8667c59eso3962655a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703691130; x=1704295930; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6kk+RTFnTzfaTNq6lLe8fTZekcwALLbUUIay4ARUP48=;
 b=HcTuo5f+8cjj3xuw/BBbZBA/8jJ0pmAgyn/kGggTPc6lJH2JYsyxikn5m883LNn6Kv
 7wtAgRBQi1iurKtHhNOTdoQsQ2GWb2ukCwXYJuftnhYG0NnU+dT7d2TiC9BOhaqgjksq
 MdH7qU0SKs9iToDGnvB/OhsqOQRxs7OjuLpnNDiGFeyndtVhQYYPnbHt6sQ9ITMUylOL
 OxYKlAcJgafwkyg5Abt/vJkc/VTeLeMkghosmx40+Qsw/FQagWAcNtdMLSEDMTGvNfYX
 cofcs76kIYkYjpihBXoujb4z8L8g9a+f5eE3G8AsNHNknJlRPbhFz6AGSTZiNH2+bW1t
 yKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703691130; x=1704295930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6kk+RTFnTzfaTNq6lLe8fTZekcwALLbUUIay4ARUP48=;
 b=LFuOkFpnyWe3x5eTGIQLUxaWBGBc/ifLhWZ30ut/jE3p88NAcTO2M7ePCv5SdYTliK
 N4qT0O8CJgOn2LdeLKno218OjTKTa0QahZSsDP8jTLuza8Zq5EKZtBcIYxIMJnJsvG6K
 7c3ZP4WXfwRW2CCmeqURnRSf2UthKJ2eGakTiD/IY4VwOLO0qznZQTotjI/Y7QxL8F0h
 pxeuddtajYp20thPd4bq4rhwO/RGzv2ESu9NCjhRMZOxgwCB65JHR1wp06jQguVhYipD
 3+TyI9nx8MxzyURWeXOEybizZYycpWzG74BTLc0x2pqDDH0hjKgERByM+vip5G/BUnci
 amrg==
X-Gm-Message-State: AOJu0YyyLWZFPqcYK2aX0pM1qK72xhbgmylWTQq3kKHTXuYMzYibla48
 BK+uOsD4ynnt75Xhsh2LEkd4D9QZQ27ED5quAWtX4Oii4asyaYEdR7siTy8A
X-Google-Smtp-Source: AGHT+IG1b8pFvXkGSlL4eSflxHyir5LIEjXV3Me/dQ7H1wXbW5oP9Aef32i5wKWNKQ86wuKlq/D5Hr1Eh0nd11BTrUw=
X-Received: by 2002:a17:90a:d987:b0:28c:825e:2cf4 with SMTP id
 d7-20020a17090ad98700b0028c825e2cf4mr1378947pjv.41.1703691130272; Wed, 27 Dec
 2023 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-7-raymond.mao@linaro.org>
 <CAC_iWjLs3Tj25hr7zD4cWCsRRWhB=DNerOr6CjH2PQeOfAaBGg@mail.gmail.com>
In-Reply-To: <CAC_iWjLs3Tj25hr7zD4cWCsRRWhB=DNerOr6CjH2PQeOfAaBGg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:32:00 -0500
Message-ID: <CAEfUkUJDMwfjeJb84ygpEqpdgEfHFMwdVrvD=LSj0LG4YVXYLg@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] bloblist: Drop spare value from bloblist record
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, 27 Dec 2023 at 04:43, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Drop spare value from bloblist record header.
> >
> > For now it is still present in the header, with an underscore, so that
> > tests continue to pass.
>
> I am not sure I understand the commit message. Doesn't the spec define
> this as 'reserved' now?
> On top of that, it's a better idea to follow the spec naming. It's
> easier to map the spec -> code for new readers. So I would rename
>
> tag -> tag_id
> size -> data_size and
> flags -> reserved.
>
> Can we at least do the flags -> reserved in this patch?
>
> I will update the naming of members in v4.

Regards,
Raymond
