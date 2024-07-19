Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71BC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C075187FEE;
	Fri, 19 Jul 2024 17:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="garhmzXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F6888096; Fri, 19 Jul 2024 17:05:12 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8149887D07
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b7a4668f07so8383526d6.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401509; x=1722006309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r2+l9VaQotd18EXky+xA/bv38fiNA5gmRiiL122v4Uc=;
 b=garhmzXzg6Ucffyk52PL8chUH15Bavu6Ca52CeLxioorxJ+qEzlKsRAjO3JXUoL9hu
 0ysgr8rM24KoTFFcnWVNhf3TM9oD1EuVknmRTXMz6JwCO9z5xcVwUr1VqmAfSxl5Uoxm
 AcnjM0Eh+johGH0J8wX4OKCTn3h/8qkgLvJN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401509; x=1722006309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r2+l9VaQotd18EXky+xA/bv38fiNA5gmRiiL122v4Uc=;
 b=S2iayYekw9pB/dcgRwuJ1/hnTDCgfvXZd+x7WJ6qcqqNqWCYp1GtKC4RgwSG0ciqmt
 yllj2cKaUsWwC4++k1C0oJBjGtPc4sINeJxSGmVrZ4PxN8pdMEyroBkLUugKw+WoWxQA
 M6wmUwh/JEAscbgGrpx53twg5K7ALA/P0YG7n3P6T0CufC7yLG4ofjSpVuu+J+jBdNIo
 DTa2TMi2rVkhy0dhB0c2jRRuS/HMWKSEZALkPvJZnOGLb6Vegx81qfSfA144xYYfmnxB
 2SRVelJxrGAhJWyYeYWQZWicUSySthbM/rgxMO7KUVivV5nf4t1osAv6KVXejC4fvy+8
 QcRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtaEsAIKvhFOpJuNzxptuCZ6b+/7HnRVU4LM6Kb5KTICrZTgfj9Mutyavzmak7WFROMYyurDQ9RnUAEKnoDEeaQjQQdg==
X-Gm-Message-State: AOJu0Yw7C019vbSwAitRrcDUgyyZX9PDGl0cH4h0EuVorw7Ip12HbSIx
 gZXqX7CLzJSQ3FstY0xBSbcow5podS9MGFKNTqbixWsjMs385IWx6+aUQo2S0xi2Hs1tL84PC66
 z44i1zVYfO8zpeT3lqyIVvVQ2M1+CekWhjEqG
X-Google-Smtp-Source: AGHT+IEhB4xCITIkYYphvMHkKDVBt/OUb2DhfEMLxq1+zTTF6fFux+5KbAj3aPcg8aIVnudRfKha+UOa5YK0D6T6DqY=
X-Received: by 2002:a05:6214:19ce:b0:6b5:4aa9:9682 with SMTP id
 6a1803df08f44-6b95a74e286mr3165716d6.41.1721401509330; Fri, 19 Jul 2024
 08:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
 <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
 <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
 <893fc8be-e4aa-46a1-9dd7-774a7f8faa69@linaro.org>
In-Reply-To: <893fc8be-e4aa-46a1-9dd7-774a7f8faa69@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:04:58 +0100
Message-ID: <CAFLszTgYdSdPv5AhCOZBx0fh1292KAtZ9KBxTE3DVW5PnP6+oA@mail.gmail.com>
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Tue, 16 Jul 2024 at 08:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 16/07/2024 09:04, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Mon, 15 Jul 2024 at 22:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 15/07/2024 13:39, Simon Glass wrote:
> >>> On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Integrate cmd-db into the U-Boot driver model.
> >>>>
> >>>> This is just a wrapper around an in-memory database, so we just need to
> >>>> get the address and validate that cmd-db is there.
> >>>>
> >>>> Since cmd_db_header will be stored in the .data section we can skip
> >>>> bind if it's already set.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>> To: Simon Glass <sjg@chromium.org>
> >>>> ---
> >>>>    drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
> >>>>    include/soc/qcom/cmd-db.h |  3 --
> >>>>    2 files changed, 23 insertions(+), 52 deletions(-)
> >>>>
> >>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> Thanks
> >>>
> >>> BTW, this is a MISC driver. Does it implement the read() operation?
> >>
> >> No, the API (as defined in the header file) takes a string and returns a
> >> database entry. cmd-db users don't have an easily available handle to
> >> the node / udevice regardless.
> >
> > OK. The closest thing might be UCLASS_SYSINFO, but it is designed for
> > inside U-Boot and uses an int instead of a string for lookup.
>
> Right, I don't think we'll be able to find a more optimum solution here.

OK

> >
> > Could you use the devicetree for this information? What sort of info is it?
>
> It maps resource names (e.g. "ldoa1" - the LDO1 regulator on PMIC A) to
> the address of the resource on the RPMh co-processor.
>
> We need to support existing (upstream) devicetree, since this has
> already been around for many years.

OK., Has this problem been resolved in more recent platforms?

Regards,
Simon
