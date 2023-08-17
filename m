Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7567C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 12:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F22486751;
	Thu, 17 Aug 2023 14:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R3rZw2V8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D45686A84; Thu, 17 Aug 2023 14:13:38 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B6A807C9
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 14:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso74742445e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692274415; x=1692879215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vplSG1J2LFLWZrh4DGj5jQy/zoRcm2F7AA5q+SFaB5M=;
 b=R3rZw2V8vzJc2nTuQ+9EKNQ/G9pw7+TEOc836g5O32DWeOZNJKKtPW50QCz8N8KpA2
 2t907EjVdMbIfZ2m+WWuGKxGj/lZTvVBFJs/zFnvYM8VzhTT7XlsXSKhdQabxXbK5h3U
 YcUJpO4Yb3iOLZkRPsr6H1XJNujq6yjlIz8vvN77GuqrMzuJ/Wa6nW//wkfOX5ER2u2L
 X6B+7RUUMfNZw01x0vLsdVToiFp71URvYAXZJVNPw3HFgv1zRnaN2HqMbQhruyMVruUf
 fLoDBelfpPHF4/mi0+Uo9ZbC0KzHej03DysOlkLC6HawBwet9U+9EENBl42smGd92A35
 L73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692274415; x=1692879215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vplSG1J2LFLWZrh4DGj5jQy/zoRcm2F7AA5q+SFaB5M=;
 b=kCutOC1L0HAZaz1nxrM8QehBHi9+3isOI1bMISSbfr8uXJNWDITd9mxwK6Yq75w25R
 zJSPVYUTdj+Laq84uOvmxKHXyXnzdtlw68+wZd1kWKImzM/dLcvXjPeYz0OzPnCzbxlJ
 PTzKzSQ3iw3zdpWUQlYpozqYAH9KQp1CNm1oChXcs7qhaFhonLkmlEMkm+NB9W1aiAyk
 nbKzkAJGuaKa4Yzl19d4vKR7ywNRV6VtYMACAYqjdIm4TgAbqJUPcnIWw65XFZ+RYYnr
 sWdq2YO6EuUxTuX63QszrSYgVClkMzP+6E2HqGi3l8ArRX2eeKoVY0f4QrMT3nhS4Owv
 14zA==
X-Gm-Message-State: AOJu0Yw/iiHIi9JtzkquuUtz7dGflGBQTYfXiWTlrbwUFB5fFYZvqJAL
 3qXH08Yq/BGiq4qgJbiNxRZtg0XJv1WA7Un2iR1l1A==
X-Google-Smtp-Source: AGHT+IECVZg0FrMuqQivhjq/u954mp3DHVq0OoQ8WklXw9pZZ5OU8a3rxpXMibBGTVzL7cZvvCS34tb0rcwBrmqwEqQ=
X-Received: by 2002:a05:600c:b5a:b0:3fd:2e1d:eca1 with SMTP id
 k26-20020a05600c0b5a00b003fd2e1deca1mr3777455wmr.4.1692274414953; Thu, 17 Aug
 2023 05:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
 <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
 <020474d5-bd1a-9231-af72-0e6cf1da66e6@mailbox.org>
 <91f9cd39-76d1-376b-1048-063a3d5588a7@ti.com>
 <CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com>
 <20230817113352.pgx2nx7mwfejubb7@iciness>
 <67b6f4df-4f1b-4961-4c93-42f1b1104c5b@ti.com>
In-Reply-To: <67b6f4df-4f1b-4961-4c93-42f1b1104c5b@ti.com>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Thu, 17 Aug 2023 17:43:23 +0530
Message-ID: <CAH=2NtyJNqFe7WQJhCbNaxqNSXrYLW0e7F+44Sc1atOTdr_T6w@mail.gmail.com>
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, 
 sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com, 
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org, rfried.dev@gmail.com, 
 patrice.chotard@foss.st.com, jbx6244@gmail.com, kever.yang@rock-chips.com, 
 eugen.hristev@collabora.com, "vigneshr@ti.com" <vigneshr@ti.com>, 
 "Kumar, Udit" <u-kumar1@ti.com>
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

On Thu, 17 Aug 2023 at 17:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi all,
>
> On 17/08/23 17:03, Nishanth Menon wrote:
> > On 15:40-20230817, Bhupesh Sharma wrote:
> >> Hi Neha,
> >>
> >> On Thu, 17 Aug 2023 at 10:26, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>>
> >>> Hi Bhupesh, Marek
> >>>
> >>> On 16/08/23 02:16, Marek Vasut wrote:
> >>>> On 8/15/23 19:48, Bhupesh Sharma wrote:
> >>>>> On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>>>>
> >>>>>> On 8/14/23 23:54, Bhupesh Sharma wrote:
> >>>>>>> Since Faiz Abbas's email ID is no longer valid,
> >>>>>>> drop him from UFS Maintainer list.
> >>>>>>>
> >>>>>>> Since I am using the UFS framework now extensively
> >>>>>>> on Qualcomm Snapdragon SoCs, so proposing myself as
> >>>>>>> the new UFS maintainer.
> >>>>>>>
> >>>>>>> I have also been sending out u-boot UFS fixes in the
> >>>>>>> recent past.
> >>>>>>>
> >>>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>>>>>
> >>>>>> I believe TI is working on something here, so please coordinate with them.
> >>>>>
> >>>>> Ok, well I haven't seen any reply to my earlier UFS fix related emails
> >>>>> from TI, so I thought maybe no one is actively looking into this area.
> >>>>> But I would love to hear from TI on the same..
> >>>>
> >>>> This is why I CCed Vignesh and Nishanth , coordinate with them.
> >>>>
> >>>>> Anyways since I will be working on the Qualcomm UFS glue layer going
> >>>>> forward, I can propose to either be a UFS maintainer or a reviewer for
> >>>>> now to make sure that the subsystem patches are reviewed and tested .
> >>>>
> >>>>
> >>>
> >>> I'd like to propose myself as a UFS maintainer along with Bhupesh, can help with
> >>> reviewing and testing starting with these patches. If all seems okay, I can send
> >>> a MAINTAINERS patch adding both Bhupesh and me.
> >>
> >> Thanks for stepping in. The above proposal looks good to me - I can
> >> help to-maintain this u-boot framework and work closely with you for
> >> testing / reviewing patches related to  this area.
> >>
> >> Many thanks to Nishanth as well for his prompt response when I ping'ed
> >> him regarding this :)
> >
> > Thank you folks for volunteering and keeping our community vibrant.
> >
>
> Have posted a patch to update the same here:
> https://lore.kernel.org/u-boot/20230817120914.144240-1-n-francis@ti.com/

Many thanks Neha - I will then drop this from my v2.

Thanks,
Bhupesh
