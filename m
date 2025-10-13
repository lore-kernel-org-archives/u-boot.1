Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77395CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CEB839CA;
	Mon, 13 Oct 2025 15:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZ9wvmee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313CF8383E; Mon, 13 Oct 2025 15:41:46 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0A1839A8
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso9569098a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760362902; x=1760967702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FdHRc6+4G7/+9GRO25SR+gdE3kryhsMYISbyrTeh06E=;
 b=AZ9wvmee+VFJyVFWms+tzVy0GseTyXMcQP20hCx3C34naT6V8cCs8ko1q6KhNJvaNa
 ZGTa9xV7l1yEPY5cA9HsQ10QzAb87rx18Ga8xEEAUDqN//l+WWL+RC6C7RYw0FbbdbPS
 8HxiLlLXqwQoe210l5aTwMWDYj+GbNBqpEO5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362902; x=1760967702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FdHRc6+4G7/+9GRO25SR+gdE3kryhsMYISbyrTeh06E=;
 b=U94lZyyZhaLZF036bvSpCkZWCclT7ZkgLo7l0626pIaJX6g0W73wsrZaZVaC+IC3/v
 T92bV/5f44aaSItYlcSGW/1dLwaSUL68r4ItQbrGkzwYSGFJMS2IGErD/CZ9gI7lzidP
 LWHvfgbAuO99gbBqAF8VlvuQKZdpIUOK5ZmhKrEAuFNObsdIvaBSWJc5yymm7mUoyEKi
 JbBDzIvUJs69x/5YK1mKFA3Odsp4O3IgLzWwQXhTQXd5WNe8mrNaO8b+f6AAEo9HAlGU
 yM8tVmQP/OC6oAk9VYMSJ/9BV3/QgUEogdAvoVGCEylX5DeN9SfFSJW2n/ikYC0K+AQX
 HquQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl8txKg56vWRUJ95pwqPwX6dZRfBEBBBJjxtrcCL2YwuSniZoEPfH0ZnGoZmbBM42QF0J2S9M=@lists.denx.de
X-Gm-Message-State: AOJu0YyO6lrbV06wbnS2kug/Leqe2F8vKtLZAS5fUaO+c/pG7CjzLLZr
 XDKpECjly+8OmvCOsqb4S1nfiQj3nU1yhnFo7vl/veewUrEEEwz417uil0QsseVcFQKGWbDwsBA
 ykIR6a62JvDTAM6exe4U/LdbwEkoOsaGVnrHtCyo7
X-Gm-Gg: ASbGncsl5oLoXcdhTNZ0ub3TCiVXuZyeEjkeLYldZPAS//qnT5C4ESXM8KxGfzZNNRg
 1N7vaH1n2BJXsYaqK3yQR3MEM64UuBkdvEV7hzqtnVn2P1692iMKlCxzhfB8+s+mYnf+fV8MJpG
 /lDVdPKmWIFbcCTx+0/rD2y4Aw2HB30iDqjpCYBFlUGOOb9QoTocBaimRzqlCqpchriAqDrEhwd
 kMuLb9kU7Hc/e8qjbX0hMKaN0zkmAriGGCUwO+QGLXCg3Dh38XTtRDonqUh+dkROoSuaA==
X-Google-Smtp-Source: AGHT+IHJN25qrJ00PpfjqKgXa20e8UFmRtiiyr9xUUATz1hhJYQuNqUPGxlf+ee58Y1xS+WrUoYlSoHyonExqNDOGq4=
X-Received: by 2002:a05:6402:5203:b0:62e:e722:a3c7 with SMTP id
 4fb4d7f45d1cf-639d5b8b60emr19463648a12.9.1760362902536; Mon, 13 Oct 2025
 06:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
 <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
 <20251010153500.5bec4e20@kmaincent-XPS-13-7390>
 <CAFLszTjLmq0r9uTYR-irzzSN63G1Lpd0iWiwW9npLSraNB1Y_g@mail.gmail.com>
 <20251013144532.381e4ad5@kmaincent-XPS-13-7390>
In-Reply-To: <20251013144532.381e4ad5@kmaincent-XPS-13-7390>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 14:41:28 +0100
X-Gm-Features: AS18NWDcUYPYg12J8XzUo3GhgdrCZGUq-4vqRPSXhwLMyJL1BwsuydNSdp8Gnyo
Message-ID: <CAFLszTgJw+G3u9OOaUgCPZidL_6YvuKiiYPY7Ca-5ATL9i-0bg@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Kory,

On Mon, 13 Oct 2025 at 13:45, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> On Sat, 11 Oct 2025 08:20:58 +0100
> Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Kory,
> >
> > On Fri, 10 Oct 2025 at 14:35, Kory Maincent <kory.maincent@bootlin.com> wrote:
> > >
> > > On Fri, 10 Oct 2025 12:13:11 +0100
> > > Simon Glass <sjg@chromium.org> wrote:
>
> ...
>
> > > > > +/**
> > > > > + * dm_extension_apply - Apply extension board overlay to the devicetree
> > > > > + * @extension_num: Extension number to be applied
> > > > > + * Return: Zero on success, negative on failure.
> > > > > + */
> > > > > +int dm_extension_apply(int extension_num);
> > > >
> > > > The uclass should have a method like apply(struct uclass *dev, int
> > > > extension_num). Is the numbering global across all devices?
> > >
> > > We currently support only one extension driver loaded at a time, therefore
> > > we don't currently need this uclass parameter.
> > > We will change the API when we will have several scan method possible at the
> > > same time but I can't test it for now. I don't think we will have such cases
> > > soon and maybe the devicetree WIP support will be ok at that time.
> >
> > OK, I hadn't picked that up but it makes sense. We can always change
> > it later, as you say. But I would like to see an apply() method in
> > extension_ops, so that it actually looks like a driver.
>
> Are you sure adding an apply ops method make sense? It is not something driver
> or board specific. Do you want to have an apply driver ops set to the same
> generic apply function for all drivers?

I don't mind. I'll leave it to you.

Regards,
Simon
