Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4D4C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA37587197;
	Tue, 21 Nov 2023 16:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EFTDI3vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2D587590; Tue, 21 Nov 2023 16:08:33 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC6286F85
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so8132985e87.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 07:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700579311; x=1701184111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vGT0NpFUMgYkrYUeDgaGq+Q1+63290QnrrCH8cu3isI=;
 b=EFTDI3vR/jqO55VlIBgztoqHFA6frF1bjPYfOH5jbvyqkoq7seHm+8f69TiXADpf4G
 aUqXubemCrxOcHWuBiiNEJ9lFCXMqIlsXusjwxtRej7qjBKEPIQc/n4JcwgAe9GBGbJh
 lN28dK9e3EGQa3yQBJFpT2gY/rDYT/QvjMZv1h0CuJYuff8IibkdvVLskBTzPTtL30Cy
 1I5ydETJn8nTp1v9a1i0VXkjnYwEbd6qWvxo9s2tUD2AJ7Hvkqaz2qEyywnUtQ0XBbRG
 vaGsevY4cbzAqoHeixN5RzzI4fhAlE6vgXqkNwRciCPWxeQvHh1WG3g3xFGvWYe18Ppr
 xcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700579311; x=1701184111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGT0NpFUMgYkrYUeDgaGq+Q1+63290QnrrCH8cu3isI=;
 b=oMBSculbiE106pgWfMTFAJwRkLpOH0vxA/2a7zu/vDaFbndIgdZ6e8tlldBck1sVdo
 72a9kIMwWwcNGzUDAb6vGZzUxw65JN8VAWb5bWabMXb/ppwnQVyGPTAbSsae3yBeyp8e
 IDYSvTWajyuR3xxafVBjUx7aaBfbf3QQnVOvVFH8FP7w4ud8ZTwNnGra8tU5ygGGKbxr
 Yp3ifbb2P91Cp+kbodA1G1mGIzg2qVp5DBpaubAWnOCVvnwPSGHRBp4Jm7Zu3yb/eqLI
 cM9K9FRw6UR4EBAS1rwgkigx74Lb1ytYRzqZZmj62yXIk7pSxgbR4Yv2TXnichWmoYDk
 MHyA==
X-Gm-Message-State: AOJu0Yzv6LeXCKLT7yvzpFkmXEkokoSm8aujB5kNUpP/XNSRtukZA4OU
 EsxFqwS8FCD88xUdyr8qtvEPLnMOmJJPfvFqwovRSA==
X-Google-Smtp-Source: AGHT+IHNWFRMQaod+sV0GpUmSzPlzajdj3ASduJL8dvLYn0evqmFD9GsloB+KkdcprAGNbj6Qoe3PME+30r2irUsicQ=
X-Received: by 2002:ac2:4556:0:b0:509:8a47:3672 with SMTP id
 j22-20020ac24556000000b005098a473672mr7240868lfm.34.1700579310798; Tue, 21
 Nov 2023 07:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
 <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
 <20231121140929.GV2513409@bill-the-cat>
 <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
In-Reply-To: <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 17:07:54 +0200
Message-ID: <CAC_iWjJn4g7V1QG-HZQx7hjgc9uFUPVZqMSQzC6PYgFgx3CPUA@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>
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

Hi Neil,

On Tue, 21 Nov 2023 at 16:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 21/11/2023 15:09, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> >> On 21/11/2023 14:15, Tom Rini wrote:
> >>> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 20/11/2023 21:16, Tom Rini wrote:
> >>>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> >>>>> eventually display this information
> >>>>>
> >>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>>> ---
> >>>>> Posting this as this was the easiest platform for me to test some SMBIOS
> >>>>> related patches on and I needed to populate the nodes so I could check
> >>>>> things in dmidecode once Linux was up.
> >>>>
> >>>> Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
> >>>> Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.
> >>>
> >>> Part of the "fun" as to why we have the binding here is that while we
> >>> could use the top-level model property, there's not a corresponding one
> >>> for manufacturer. I'm fine ignoring the patch I posted here and having a
> >>> longer discussion about populating SMBIOS more usefully, globally, as I
> >>> think has been suggested a time or two.
> >>>
> >>
> >> I'm ok landing it with the same data as from the vendor.
> >> but couldn't we use the first top-level compatible as default smbios data ?
> >>
> >> compatible = "vendor1,board-name", "vendor1,soc-name";
> >>
> >> and translate to:
> >>
> >>
> >> smbios {
> >>      system {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >>
> >>      baseboard {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >>
> >>      chassis {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >> };
> >>
> >> since the vendor name should be already documented in the linux
> >> bindings, same for the board name.
> >> And we would be free to add some custom data in the DT if needed.
> >>
> >> Anyway, not sure it's the right place to discuss about that !
> >
> > That's essentially
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2-ilias.apalodimas@linaro.org/
> > which had a bunch of comments on 1/2:
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1-ilias.apalodimas@linaro.org/
> >
> > But I think that since then some thoughts on the subject have changed
> > and that approach might be more welcome now than it was then.
> >
>
> Thanks for the pointer, seems I had the exact same idea.
> Hope this will be re-spinned, I don't want to add this to the 45 amlogic
> boards when we have the necessary info already available and documented...

I'll respin the patches Tom mentioned once I find some time to address
the comments in v1. Hope to do it by the end of the week

Cheers
/Ilias
>
> Neil
>
