Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC830C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 23:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3F587732;
	Thu, 21 Dec 2023 00:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="qhIu5pnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BF683414; Thu, 21 Dec 2023 00:09:15 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BFB87841
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 00:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2339262835so16374566b.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1703113750; x=1703718550;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBDQIvdMX+niO0BM0IpK1XogZKwR1o3G2fe8kE3IB7k=;
 b=qhIu5pnWRennpHM6ghz0LUSHQU1N03KVMsfv5DT0TgO3MbTnNfIJwfeViTyaeiJQA1
 ngSZXLudnRehzbbg8usJjxLlZdjaB+6Ok+cpEKPxftx0NWHrn+wn57PQEyoAjhjlCANi
 vh6N7E23UbyBr7CcS/ZNI6w8qoLW6j6eYJAR7x6XVj/q3FeNOnuVcEa/A6fdeBcyfcQW
 iGbu45mtRqECGMwFvqYiIkmkRJACTTieq7yVHtvfRYizrOeUU4RgqnVIIupJMydwElFC
 GIIeavb5ALMBJM8ZFgHxUUcbZ3v4/OmrRdyEqRva17wydvfcgGDxKl/s5ZCyLYaoLV2r
 JRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703113750; x=1703718550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBDQIvdMX+niO0BM0IpK1XogZKwR1o3G2fe8kE3IB7k=;
 b=wSZFTFFICoN+5vwT00zj5GdpfWGXFsSnaxXzZp4FoLKpqEUEWhYxp4fah2nDsT14fB
 VqdJ5rFTiPpc1A+Vpf09xm+rc6/w7EN5W5/67LHGezSEat9E0OU8XhJ1rW8mDombnDiK
 EFG43plVruXpOCZURdMTRKMQAn14MkNLNrw3avzsO8+5lI9qJJ+5D85wNoi4HXqTgjfW
 0Z2jRoaqZaHsAq70nyuqX39WNuP4BaF8ebKSmCYXio9sJ4KEZnAbrHZOqpZfMwn7rOy6
 MDWlkeVTXhemeUeNrSJYAAhCHTJBad1MCuo8/yNmk1wmlcdM4hfLf+++WyaRmyrX09lb
 CnqA==
X-Gm-Message-State: AOJu0YxMZukp4xebNq+E+PRn29DPG6bMdTsG6I6rr4Z8UXaQKVX6Rlrp
 ynEU8yd9lq8PjUMiX4sSV+lGEMbBXL0YfTZaYn60Ng==
X-Google-Smtp-Source: AGHT+IHDl9BUKJavrDstifXVc5eMSaDvS7DSdfdSOQRotTEZInYFtEO6ItSMR0eBUB/Bos8LN3fDBEXWKjyfS/6yNWc=
X-Received: by 2002:a17:906:1001:b0:a23:6c63:3094 with SMTP id
 1-20020a170906100100b00a236c633094mr2275506ejm.150.1703113749694; Wed, 20 Dec
 2023 15:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
 <20231214162543.1200276-2-tharvey@gateworks.com>
 <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
 <CAJ+vNU0XbwbQoYDHm59LrFaK_hv29RkeZvbK=QCUMkoLYNM-hw@mail.gmail.com>
 <CAOMZO5BBDM2rzhxqe_kw8ADexUtsNxYfnueFtASkNxp561nquw@mail.gmail.com>
 <CAHCN7xJAzVY2FuELr17pqkkJtRdPo-sO-asLzYGF2cNwYrVPNw@mail.gmail.com>
In-Reply-To: <CAHCN7xJAzVY2FuELr17pqkkJtRdPo-sO-asLzYGF2cNwYrVPNw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 20 Dec 2023 15:08:58 -0800
Message-ID: <CAJ+vNU1FS-tLRJN49MtURzUpnRzZACf2jtm29GYW6MsVZWy4hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
To: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Fri, Dec 15, 2023 at 11:06=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Fri, Dec 15, 2023 at 12:41=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Tim,
> >
> > On Fri, Dec 15, 2023 at 3:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> >
> > > Fabio,
> > >
> > > The commit log details are not valid for upstream. I was basing this
> > > off of 8d060e4a66d6884341fbb3d8ab1d837a3f173d47 which made it upstrea=
m
> > > with the same message.
> > >
> > > I can submit a v2 if necessary.
> >
> > Yes, please submit a v2 and I will queue this series and the TPM one
> > to u-boot-imx next.
>
> This node appears to already be in the imx8mm-u-boot.dtsi encapsulated
> by an #ifdef looking for optee.  Can this ifdef be expanded to include
> CONFIG_SECURE_BOOT?
>

Adam,

Thanks for reminding me of that... that was my submission.

This patch just needs to be dropped... it was a remnant from before
bb6a4c55363c3 "(arm: dts: imx8mm: move firmware/optee node to common
imx8mm-u-boot.dtsi")

I think it makes sense that the firmware/optee node is protected
within a CONFIG_OPTEE

Best Regards,

Tim
