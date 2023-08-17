Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB60EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 10:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9BE86AA4;
	Thu, 17 Aug 2023 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BY5yFuW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44AD86AA5; Thu, 17 Aug 2023 12:10:17 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215D1867A8
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so6809828f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692267014; x=1692871814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FlxIgiTfoBSFkNfoKtQF/hPT4t5vbzc4lBUl2okrz8c=;
 b=BY5yFuW3IJUdCRyk5Gj+vCwAbajHb4+XDBRh3JvTriXJFXbwTS0hIikG9HiVyHWeOX
 FbCaYPJrOTbznRBHB/UVV5oo2cgcfDF2O6Potm7WynPEQHDOoXFPuK63OCB8THcchv7N
 SPVuBlgiOkODL+lEDQaVvizixp6yn81VkjzK1/e9VyH5e0RvyWbPQhLDwdgCaRQ2vPuL
 LBESSx6W9Ca6o2zlmq/nPJWduC6ehEqZcAYb8R7itYOsNrbtshrRPvPQanmmrSrYLplN
 YuORkqx2If3QBULsrNM82vNGcdFZBvrLATHr1eTyC0XjHQbcEzVS6c8uT5X0S6MTVd9i
 1Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692267014; x=1692871814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FlxIgiTfoBSFkNfoKtQF/hPT4t5vbzc4lBUl2okrz8c=;
 b=JYK39s5X7lqP+4/NHp2/sBfNzVqPOl017IfYJnTJcsOD55ieSbMfikFFFkjw5TAgx0
 NlqysmvVDNRWYNN9fpzP327Pfv0hva8stLN4VgUeXC0GsHEky2q94aSALGUwotJEIa2k
 ifnyIcix63qRc8zh/rLoEli+bidDRCkVMWVftuBzs9t+lAJ/adreA3ZDyhMdoXstNxja
 3G8SIsjg0Hh2rNcbn5hec5q2MpKvr20oGrDVIC3G7XMmSo9nthwYE7xiPl1vzv/Tx2s/
 U0b+dBdFlkQx5eF54szC3spjS/1tVBfCWWqDBJ9oZWQm3e9+kh/eo9DPfW4v/lMQApiH
 ru+w==
X-Gm-Message-State: AOJu0YwpzdpH/oJxWvKSnZfFHdya49ok/AujQNaqi3E5KjkN6KXRNd6K
 +139Dl6XadkwPgEHMGZFVPLmpJiV3RfOJlepox9TbA==
X-Google-Smtp-Source: AGHT+IEOoceqa/DK+u1aRyg0HAXMsEUNYI2+q9/2AKUEjKFrLkwalPO26OwmFv4xgJBUPtcwAGoaLMQleUFEyrSmH8A=
X-Received: by 2002:adf:facf:0:b0:315:9362:3c70 with SMTP id
 a15-20020adffacf000000b0031593623c70mr3601577wrs.60.1692267013896; Thu, 17
 Aug 2023 03:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
 <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
 <020474d5-bd1a-9231-af72-0e6cf1da66e6@mailbox.org>
 <91f9cd39-76d1-376b-1048-063a3d5588a7@ti.com>
In-Reply-To: <91f9cd39-76d1-376b-1048-063a3d5588a7@ti.com>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Thu, 17 Aug 2023 15:40:02 +0530
Message-ID: <CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com>
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 sjg@chromium.org, 
 trini@konsulko.com, bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com, 
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com, 
 "vigneshr@ti.com" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, "Kumar,
 Udit" <u-kumar1@ti.com>
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

Hi Neha,

On Thu, 17 Aug 2023 at 10:26, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Bhupesh, Marek
>
> On 16/08/23 02:16, Marek Vasut wrote:
> > On 8/15/23 19:48, Bhupesh Sharma wrote:
> >> On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>
> >>> On 8/14/23 23:54, Bhupesh Sharma wrote:
> >>>> Since Faiz Abbas's email ID is no longer valid,
> >>>> drop him from UFS Maintainer list.
> >>>>
> >>>> Since I am using the UFS framework now extensively
> >>>> on Qualcomm Snapdragon SoCs, so proposing myself as
> >>>> the new UFS maintainer.
> >>>>
> >>>> I have also been sending out u-boot UFS fixes in the
> >>>> recent past.
> >>>>
> >>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>>
> >>> I believe TI is working on something here, so please coordinate with them.
> >>
> >> Ok, well I haven't seen any reply to my earlier UFS fix related emails
> >> from TI, so I thought maybe no one is actively looking into this area.
> >> But I would love to hear from TI on the same..
> >
> > This is why I CCed Vignesh and Nishanth , coordinate with them.
> >
> >> Anyways since I will be working on the Qualcomm UFS glue layer going
> >> forward, I can propose to either be a UFS maintainer or a reviewer for
> >> now to make sure that the subsystem patches are reviewed and tested .
> >
> >
>
> I'd like to propose myself as a UFS maintainer along with Bhupesh, can help with
> reviewing and testing starting with these patches. If all seems okay, I can send
> a MAINTAINERS patch adding both Bhupesh and me.

Thanks for stepping in. The above proposal looks good to me - I can
help to-maintain this u-boot framework and work closely with you for
testing / reviewing patches related to  this area.

Many thanks to Nishanth as well for his prompt response when I ping'ed
him regarding this :)

Thanks,
Bhupesh
