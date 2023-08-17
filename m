Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDF7C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 12:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EFC86680;
	Thu, 17 Aug 2023 14:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XV3RqDnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC4486903; Thu, 17 Aug 2023 14:11:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C56807C9
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 14:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so72242435e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692274308; x=1692879108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z4y6ukvqG71OAA8bG1/Z6vKbjznMGOUjoJ4gOGSVPiM=;
 b=XV3RqDnWITyoH6E1kOXXdRlj/mt1lnyeiPK+M2jOsxzUn25DZzOm5Xwl3MKjpBzliM
 f5ppm93vBBg6JdEhYiPg6qxNtsoyA5LCrCeDdFXvqY54iCJp5G23h30+6/oq9NifvqrJ
 uCTQ1mL+atK7yR4LG0Qx9wDP7vNqDoYMqPmeRWF4vROf/yeGgtEO1shTgQDNn0itNOz4
 NNXmiH3xVXlhIPT/GE7hiJytsf/NhewXHMvkdvM/KTfnz90uI/7o6Cacf7/tBxbnsg/D
 2pADLpfDAscGuaAFG+oFZUtOjD7SkJ0j0A5Pe4zcwlpPomB7uP3rbkuVa9bSbtvbk2yA
 DlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692274308; x=1692879108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4y6ukvqG71OAA8bG1/Z6vKbjznMGOUjoJ4gOGSVPiM=;
 b=HlJd3jA3igfiDqMa7/tGCqXcvnx6UZIPbfjypgWHBF4jRTm6rlzt8huHmpsTfv597n
 SObbMyrpWZl8WeeNasheI8rqxeIdaughjkhwBt3H6ExthqAs8ZR7Xkvh46nTa6cnYywq
 08G3SyH29roAW4zQpr9RHs+bPAYkT07YZLJpCNYHAzXStVX6A39Jkz9bBceSrNHdD15I
 SnxwD8bWXd1VMQY+WHppkmnQMHkjcpliz2BS3PssCx+r7YusIE5goYV0eBo49cAD7/A3
 d9laIrp34YjcbiXAOB6/PpSnJDnR2sYDSQwaTDFDLOOF988A6a7UGirlaFEDdv9ErMFX
 eN6Q==
X-Gm-Message-State: AOJu0Yw9svD5Z9O3s8VjaKqMFzKLeo+ihI3RdkW6L0I5ZNf3F9dej3bR
 y3PBr51YyCn+Ui4v/rFPYkpw9343B33dGKO3+XDGxw==
X-Google-Smtp-Source: AGHT+IHDCnkpY9U/GgJYTZdD0emxaDPed5336g/AhAnCgN7wJfFGTZw7xUTdTo1RUNV60Dz73tlTEdRbLohEvGtJMUI=
X-Received: by 2002:adf:e9c9:0:b0:317:e1a2:dccf with SMTP id
 l9-20020adfe9c9000000b00317e1a2dccfmr4015041wrn.62.1692274307580; Thu, 17 Aug
 2023 05:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
 <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
 <020474d5-bd1a-9231-af72-0e6cf1da66e6@mailbox.org>
 <91f9cd39-76d1-376b-1048-063a3d5588a7@ti.com>
 <CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com>
 <20230817113352.pgx2nx7mwfejubb7@iciness>
In-Reply-To: <20230817113352.pgx2nx7mwfejubb7@iciness>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Thu, 17 Aug 2023 17:41:36 +0530
Message-ID: <CAH=2Ntz81nDjacDjg85Gid-+waSeRND2u=PpsHgZhjrBT53_6A@mail.gmail.com>
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
To: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
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

On Thu, 17 Aug 2023 at 17:04, Nishanth Menon <nm@ti.com> wrote:
>
> On 15:40-20230817, Bhupesh Sharma wrote:
> > Hi Neha,
> >
> > On Thu, 17 Aug 2023 at 10:26, Neha Malcom Francis <n-francis@ti.com> wrote:
> > >
> > > Hi Bhupesh, Marek
> > >
> > > On 16/08/23 02:16, Marek Vasut wrote:
> > > > On 8/15/23 19:48, Bhupesh Sharma wrote:
> > > >> On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > >>>
> > > >>> On 8/14/23 23:54, Bhupesh Sharma wrote:
> > > >>>> Since Faiz Abbas's email ID is no longer valid,
> > > >>>> drop him from UFS Maintainer list.
> > > >>>>
> > > >>>> Since I am using the UFS framework now extensively
> > > >>>> on Qualcomm Snapdragon SoCs, so proposing myself as
> > > >>>> the new UFS maintainer.
> > > >>>>
> > > >>>> I have also been sending out u-boot UFS fixes in the
> > > >>>> recent past.
> > > >>>>
> > > >>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > >>>
> > > >>> I believe TI is working on something here, so please coordinate with them.
> > > >>
> > > >> Ok, well I haven't seen any reply to my earlier UFS fix related emails
> > > >> from TI, so I thought maybe no one is actively looking into this area.
> > > >> But I would love to hear from TI on the same..
> > > >
> > > > This is why I CCed Vignesh and Nishanth , coordinate with them.
> > > >
> > > >> Anyways since I will be working on the Qualcomm UFS glue layer going
> > > >> forward, I can propose to either be a UFS maintainer or a reviewer for
> > > >> now to make sure that the subsystem patches are reviewed and tested .
> > > >
> > > >
> > >
> > > I'd like to propose myself as a UFS maintainer along with Bhupesh, can help with
> > > reviewing and testing starting with these patches. If all seems okay, I can send
> > > a MAINTAINERS patch adding both Bhupesh and me.
> >
> > Thanks for stepping in. The above proposal looks good to me - I can
> > help to-maintain this u-boot framework and work closely with you for
> > testing / reviewing patches related to  this area.
> >
> > Many thanks to Nishanth as well for his prompt response when I ping'ed
> > him regarding this :)
>
> Thank you folks for volunteering and keeping our community vibrant.

Sure, I will send a v2 to reflect the same shortly.

Thanks,
Bhupesh
