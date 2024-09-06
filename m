Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A073CE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 00:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABDF88CC5;
	Fri,  6 Sep 2024 02:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TEXBIzjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C45588CC2; Fri,  6 Sep 2024 02:30:58 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AE488CCE
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 02:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf92f96f83so7815566d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725582655; x=1726187455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwkEQwfZfpR0tu0myETm7wYFgk6zcOHy+x+7DEL7k9M=;
 b=TEXBIzjmPcpDildTo3Y+HW5RHr0XKpgBRTqpCNlhv5irTSG8+1sSxQbJQe2ugn17PU
 SBAfA37mGZ3JQRYqJZVACvevIzcfuVCFmjH3qfuQ91XkCM+7RzVBj/rGksTEkuVeSHOl
 sl/CRGTtulAsJQ35VtWDA2l6krzhjHJKlYZro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725582655; x=1726187455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwkEQwfZfpR0tu0myETm7wYFgk6zcOHy+x+7DEL7k9M=;
 b=WA4dz4oMBGw1BoCrUgpdE1eC7LcgaWNT6f5CRmID2532Ouyxfh98Ns+xppxvcsTZcx
 ClLIJj6zpBBZ1sjpl6pz4t0DOKLQ+8uzURSRGBuk59D/v6V1vpv2Ut4tECUcKFtgJ0r5
 N3HeNUt4Y8fdjBJCuVSFO4AbHWM+qU7XG08rTV4V1BMLEIRi6L2o9cb2VCtiZzP+AOfN
 +171ZpyDl2zb9uCAVbe4lf2WRR/aFb2FYTkR3d9wgkcBYhUCWlQ7E3Fxk8HZ7J6AIc17
 Y3nv30BEjhewpuXouSS4RUemUwgdJgtdQNuS4BLNT++Ju1225GA3cX6auyTyoSC30CyQ
 nDzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH952lkhWX8xYmQdfRXu5UuxDvtcZCR60JjaTJ97f2D0VVH/NSFAUz8aiSyPZY/6quhFtyLIw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTa51596VlKT4F+M+/9fmCgRyUdqfJCsVdjcOux0nt9FCLMpne
 BH6RlDJyuDUn/y1QvInb+gxB2YkRYbY/m2EgksPUyCS3Vp9otEVrVOUoP0mvsJXERagxe1tD/eB
 C7W5IPqmR909kwMojY4lgSVU4qPlcbY6vdK25
X-Google-Smtp-Source: AGHT+IErAG9Gf/oKt2EucA8on/TPyIOEyE65byEv4fp776Q2ZmKMyO3HkqYgS1IgM3qYzkLMz0RwB7YYfFVPhCE0i9Y=
X-Received: by 2002:a05:6214:3902:b0:6bf:75da:de1e with SMTP id
 6a1803df08f44-6c5283fac49mr13484996d6.25.1725582654736; Thu, 05 Sep 2024
 17:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
In-Reply-To: <20240905155402.486a7110@wsk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Sep 2024 18:30:44 -0600
Message-ID: <CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-mCw-w@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

Hi Lukasz,

On Thu, 5 Sept 2024 at 07:54, Lukasz Majewski <lukma@denx.de> wrote:
>
> Hi Adam,
>
> > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx.de>=
 wrote:
> > >
> > > Hi Simon,
> > >
> > > > Hi,
> > > >
> > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com>
> > > > wrote:
> > > > >
> > > > > Hi Lukasz,
> > > > >
> > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@de=
nx.de>
> > > > > wrote:
> > > > > > Unfortunately not - this change is only for properly setting
> > > > > > start address of the u-boot.
> > > > > >
> > > > > > The _real_ problem here is the symbol placement generated by
> > > > > > binman when we try to define the image as a single one.
> > > > > >
> > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > specific.
> > > > > >
> > > > > > The "fix" (for which I'd been now probably opt) for this issue
> > > > > > would be to generate two images with binman - one for
> > > > > > u-boot-spl-ddr.bin and the final flash.bin with the former one
> > > > > > included (as it was before SHA1:
> > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > >
> > > > > Is QSPI boot broken on i.MX8MM?
> > > > >
> > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > >
> > > > Note also that I sent a series[1] which allows the symbols-base
> > > > to be adjusted, if that helps.
> > >
> > > I've seen them - but not yet tested.
> > >
> > > Thanks Simon for the patch series.
> >
> > Is it still broken with this patch series?  I have been traveling and
> > haven't had much time to test.
>
> Yes, I can confirm that it is still broken.
>
> I've applied:
> https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426387-1-=
sjg@chromium.org/
>
> on top of mainline:
> SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
>
> Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.

Can you please point me to the tree? I suspect that the symbols-base
is already 0, so setting it to 0 has no effect. I'm not sure though,

Regards,
Simon
