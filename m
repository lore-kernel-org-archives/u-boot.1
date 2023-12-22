Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E36C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 16:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F23887021;
	Fri, 22 Dec 2023 17:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yzE/RJ3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CF5871CE; Fri, 22 Dec 2023 17:35:07 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D992F86F64
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 17:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d3165ac96bso1504317b3a.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703262903; x=1703867703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AU3nCPKQ8SAJxV3D2GDlI9kJ5TEXCIcoOIqmdUYZUfc=;
 b=yzE/RJ3zOAk5b5ZoKymmy9Yxt/4TEQTtXV1kSuRLdLASBPRkdoE4JAAkYoaOZ3Xnbm
 7+CUbByRqPX2jb6BSqfaKUDBDlZvJyYKhfyMd5WcSH4DU9tEomwBu5vFoDwIHMo8ouSZ
 Z6WFKgGfyZOSCoiYU0nZTmVBYvidnpJ47KQr5Idn40wUbIgDpkFGabUCYuDicnDagyW5
 WSoqCS2fasuA3nnLYYU1XyLdG9m2UCC2WQuam1nQ/cV1wRKph1mKHdrWWyUd3yGLDIcR
 k8fY+ydq+hpcYAt5o290iZIjW+Re9+XJ1IJ50bS76qAGIwJcNoSYIfgXHcgZtvXlK4d5
 06EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703262903; x=1703867703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AU3nCPKQ8SAJxV3D2GDlI9kJ5TEXCIcoOIqmdUYZUfc=;
 b=UWb+7ntv7db50jOF6sCq9YGyORaaRSWY+tCmOpYifeO3ddpUF5fGJ2uVqfIabi16ze
 CL4IkqDddrWp1xN/DEh9Zrm/+zs9YtsfkArbW30WGzPQ/+4wIg7Q9QWYTT7mA9nfPowV
 JKHP+CijQcA6bGK4+5mlfqnveo8w4quppQylxuW8XpQ+uOdLJwm9Vx1CEGXB7vaJQ5yJ
 /SGrKJt4lo/P56wSlBaluaYkTJu0R6oWEeD+ni4LHsjQaIQYlyNiUOnyCrIbzwoPewGW
 m7hxeC3xw7T6aBI+/DODZfY9XTSoDeJZxAkSlxGEuAZEy47/xQkf0iB2ijtxowy3j/my
 6ecg==
X-Gm-Message-State: AOJu0Yw4aTBKmgAjqsAwT50SV8ulQaB081MluMaP7Fm5ToRW4974SZU7
 kgWSAO79u8xCfc15r+do1EP9/GbxsMo/rQU1svBfZRnkZIPCIQ==
X-Google-Smtp-Source: AGHT+IFpWUQwVHz1UWJ5Vy6IzABPnm9YEjmZLusHoCiarv8oeX5rKaojEAKPnmzTmt9NMURb8kUt8MHJpt8LRNnchlE=
X-Received: by 2002:a05:6a00:4197:b0:6ce:93bf:b778 with SMTP id
 ca23-20020a056a00419700b006ce93bfb778mr1370388pfb.44.1703262903100; Fri, 22
 Dec 2023 08:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-4-raymond.mao@linaro.org>
 <CAC_iWjL3JfxVA0HW_2vbV3ivWDm0H00R=Mj4to_BC2b2gNY4FA@mail.gmail.com>
 <CAEfUkUK22kEAsobLXS3eH-FJnUg4BW5TuWtfaBeYLGgJs-ksgA@mail.gmail.com>
 <CAC_iWj+83faSBgg42G+9vUs1un92RFqiWYVCSq4hS8yn6GtFVA@mail.gmail.com>
In-Reply-To: <CAC_iWj+83faSBgg42G+9vUs1un92RFqiWYVCSq4hS8yn6GtFVA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 22 Dec 2023 11:34:51 -0500
Message-ID: <CAEfUkUL2atPGNaxK6HdE-w2CGGshLF0dEUrdE=s90XYmy5UKDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] bloblist: refactor of bloblist_reloc()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Fri, 22 Dec 2023 at 10:46, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Fri, 22 Dec 2023 at 17:30, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 22 Dec 2023 at 06:12, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Thu, 21 Dec 2023 at 02:41, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > The current bloblist pointer and size can be retrieved from global
> >> > data, so we don't need to pass them from the function arguments.
> >> > This change also help to remove all external access of gd->bloblist
> >> > outside of bloblist module.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >>
> >> [...]
> >>
> >> >         }
> >> >  }
> >> >
> >> > -void bloblist_reloc(void *to, uint to_size, void *from, uint
> from_size)
> >> > +void bloblist_reloc(void *to, uint to_size)
> >> >  {
> >> >         struct bloblist_hdr *hdr;
> >> >
> >> > -       memcpy(to, from, from_size);
> >> > +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
> >> >         hdr = to;
> >> > -       hdr->total_size = to_size;
> >> > +       if (to_size < gd->bloblist->total_size)
> >>
> >> What's the size of *to? Is it equal to to_size?
> >> Because if to_size can be smaller that gd->bloblist->total_size the
> >> memcpy above is wrong
> >
> > to_size should be 0 (use the total_size) or a value larger than
> total_size.
> > I think I should keep the below line from the function header.
>
> The point here is, are we certain that the *to is big enough? Or we'll
> end up overflowing ?
>
Yes, this needs to be checked before copying.

Thanks and regards,
Raymond
