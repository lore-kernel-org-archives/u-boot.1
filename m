Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422A8C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE528848EB;
	Tue,  7 Jul 2026 13:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OCe8IPDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD6284942; Tue,  7 Jul 2026 13:07:52 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499C3846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664d4478a64so5351605d50.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783422468; cv=none;
 d=google.com; s=arc-20260327;
 b=ExbgXDHkCvE2tgE7eual0qnKhSscJ2+/p/TnfEUtxoMA2RG9qJX01i6S0Pjs/TQ3vk
 yg+b0hwFmk6TRl5NhF13az8QrTAi29mi1Om1I00O1z8APalgITH/6kDDrfEdMbzMDx0w
 cV0EJgHqCIEte7B9L1tbemNtyFZDju9YhEWK10dhaPYfzThsoV/fGuSYdRqU+rUauMlV
 ZMnInIqnYTLeMXQPOhHEPdmnDSwyObE4T+GQ8UU1JoaBCQa4NnArCgyHt+9AgcZufXtk
 JLYlOK7CBPocymozqu4FXu0CRv/+6hkhJlt+QBG53YgD7RhUh9hTSZo1k9wIWvH2eS3+
 xBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NZGCuRsMFcWDqG9NrRS7O52KUSxFR+XMYROurMZxas4=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=g2eknmsztb5sjbBW13HP4c/cLKP1ck/jY8CqAmUfkeDjb8GawcYKo4+jXngll/UlQt
 8kmgbW4aRs9FoI6y+zg7eqK4X5H0WgTBxMmPYB+UeOLl8BmQ5NKk4AvRNuOYMvf8CdWY
 EL53SRIgbx90Luw0yxDFY8vfsl00GkklPnBmTnkQxS6tkZ974oZqDV8BkJy6IrGB/U0D
 5f7A5KyOTxcEsTKx7tdZmN/NDab03u85+kbH0glO/ZMs4K2+EqgtQXup4fGyZHqKtOvf
 ZyCDA6ORNzirQ01NzJhx+N7Gotu7SQw7y7sPPP7sDUCdR5WqXBh7qsdLZIcrv1B/r7Ys
 d7DA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783422468; x=1784027268; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NZGCuRsMFcWDqG9NrRS7O52KUSxFR+XMYROurMZxas4=;
 b=OCe8IPDxX4yzofXZY4RPJvLLGyAqpgNc78boWzlE2hsOhawNTxlfdgGbXXSfQFqFrV
 q4IOitbAf4nT8vdHonJeh3adH/Q+/4iuVx8D1nuRYQbITyAOpu6rzubt1BEV1T6Vyiet
 H0izuWsMGt9T0zRnesJrv6B5YgO3/9lkQ8K49/vnXAKByHI69aXl06CPoH+rMZ/Ixjmj
 UBRZ38O7QOLcJgyd8tyTV28+USjY3UZq/0QyydCyUO4uWSP/pZg3EufRyjuDv595IHzK
 +Wk8j8vY2Gj4sLdSldsdvcA/t3MSXhQvs9PvHLwSxd0zDX9U2xmVlrLg6Me0uqL+jjJo
 t/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783422468; x=1784027268;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NZGCuRsMFcWDqG9NrRS7O52KUSxFR+XMYROurMZxas4=;
 b=oEhz/wvLSvE/5y9Dtm97L1yEPy4uBlnQuboSwrYto9D6ixwq4iU71vPu4QSRhTVF85
 yBbCwpzVC0smI3UjE6yjMfYCID782JhUsueNl6faGJ8FZPdfnHZSV8gTd+0EBu+JNTra
 xm+rkHyuCM0NviPqRgcX5kD4L5kMAl6lJSViHUwDgRcAs0Md//8Nk6rkjKlEtfZ3Aejc
 TSeDbQOmapbaD35r4dA3apkSe0yoIq/F6aszlcF5Q3SF2cfbNnlzywHCa55ZjN+mv/CM
 kdhNvwdhbk9eU2J7QTtppWTJEkf9X4CjmCVIFbG4WKtDO04pucsmbPZjr7wCLeJkF3wB
 DDWg==
X-Gm-Message-State: AOJu0YxbTc6uqfW5q6ljtxp8SAgl+hiLX6EmsFH00PEHSx1CXvEhBHuw
 jcll9ETU3cchnZwhZ2kh5oNxfzO+DDJRP6IdrYHgt2CnTpqrqJWSK/NacoI7JTprpYAn2auHRAK
 s7xvY321QNRmPxN+Vm11fL6X3o1e1weTyxV8JM1/K7g==
X-Gm-Gg: AfdE7cn2afuXzq2KH2zX6pG9labtIY/Frn3kFWdmxJjugfTcEeL4gpzoicHWiREYleo
 rMBBHWveQvPBsGsR6XpF7F0tl2cMZB42WGoLiobgMImrLG/xu5PF9emw0SktOSl+oZHzsGSUNZR
 GTbgdrknbFklLnMsWsGWg7NGmLg4GnIl1XRt8vmmnU7I9MJ/W/kOGytFZ6cn10KTAiHAMAq35N0
 IRnjXI/5Y0Yqvpx+IciAeYi7wt2b4nUszbRlUKCmX7GeVVIRyWjG8rCpd231C42Y73/ilbx5D7z
 Ih3lKieJE1vR78HpsSghscM/3CTUToxpG0pkeF2AyT2C+zr6woxblYI1NGmnRWtM7Rom5lmDvN7
 uZEhlIj4H6XMX90++7AqL88RJAvMFdm5kwtfsk1lb6ON3BPLp9Bu//iyGT7ND4s/chdSi3AHxwN
 F7ku5250KdDnz7HbVsxL6F0vkzSi8trIu8gcN+dOtEgoWgR+Rwz/qiTRWoXJ7a73wB7eFTxcxRF
 8uAjObi0Hg+9ZYXzEM4D3LD+QBx1in5L2fw0P6ppMMOHuN66mzoXC2RUe3TbDcUZVhQ9BdDpau1
 BIx5G+iuQ87xaQK6P/80uMQiRMwjQ2Warus0hcZcNCJXs3422guEhIPT/IcO5IF/ioLPIvJuuxI
 n7qmqRw==
X-Received: by 2002:a05:690e:4196:b0:664:ae6d:ad2b with SMTP id
 956f58d0204a3-6677fce0a80mr3605967d50.69.1783422468030; Tue, 07 Jul 2026
 04:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
 <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
 <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
 <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
 <207fe44d-e18e-4983-b152-be820d720275@amd.com>
 <CAC_iWjJ2z2TCZT63U5ve53LL80GnZ6PsuR1hOG4EMtizq3+LwA@mail.gmail.com>
 <879e6b36-29b4-4a14-9c28-6371bcd09d71@amd.com>
In-Reply-To: <879e6b36-29b4-4a14-9c28-6371bcd09d71@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jul 2026 14:07:12 +0300
X-Gm-Features: AVVi8CcqosLXB5-L2ekYUABPBV3k3imBZjud86p9tcBYhF7fge99oAEP9qrNo-k
Message-ID: <CAC_iWjKBNa+gLmp6WO78JMzKXhep=xaumwMUUy8WG+dQEyr99w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

[...]
> >>>>
> >>>> Pretty much this patch is bringing back old behavior before these two patches
> >>>> have been applied to the repo.
> >>>
> >>> It doesn't make sense to update to or run a firmware that won't be
> >>> able to use capsule updates ever again.
> >>
> >> It means that can be consider as misconfiguration. Which ends up today in
> >> forever loop (1/2 will at least tell now what it is happening).
> >>
> >> , eth1: ethernet@ed920000
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >> Cannot find fwu device
> >>
> >> But shouldn't be there different action? Go back to second image or reset for
> >> example?
> >
> > At this point, either your metadata is gone, in which case you can
> > either try to recreate them and hope for the best or an update broke
> > the fwu mechanism indeed.
> > In theory the board will automatically revert to the secondary
> > partition after X reboots since no one is providing an acceptance
> > capsule (or variable) so reseting should be fine.
>
> It just means that I should drop this patch right?

Yes please.

Thanks
/Ilias
>
> Thanks,
> Michal
