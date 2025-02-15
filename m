Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D463C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3C980C6F;
	Sat, 15 Feb 2025 18:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R5C3+Mve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6268480C77; Sat, 15 Feb 2025 18:21:31 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543C780756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso498828966b.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640089; x=1740244889; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M9wmYY++mDoN1yXuSzjrtJ1k8Xe5jaocQXGvyDLhW/g=;
 b=R5C3+MvefNljN2aAdJRlqFUw3+7cTv8MExlYUVzwl2loo+FXYFqm0LgKPXCLWHTwZi
 ZXXsqvpFTObR9yFolClezVZv2rdOhgby1bGdBYtx3yLXAyMN6gFkw9q6LnYBMdyxEXqT
 PvG7WYtwikSlyg4mN15qALNQWDJX+mliPxiVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640089; x=1740244889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9wmYY++mDoN1yXuSzjrtJ1k8Xe5jaocQXGvyDLhW/g=;
 b=e6C/vHPLerXesg/ls1gtaee86pSpLGBUIL/Pi41x23HD3NrPuqirSZrYk0Xrg4Mri0
 5TENCyvG6Tq+fewko452Yrwpzns+GizaAck1dlO5cGYVJa5Oru1Qdy56JHMSW+5thXLy
 qVo3nEU2VDk/bfJdvjMQWQSgIOaKSVqrFXYXObkHeY1yEbByEIcWjVd1iz7JR19SpnEU
 FG5EQPzyZshRkOcXKU5+M9TwkkqCyTDI5lt8Uz3TTJIAZYB3PXyJY9xrM06OBv5rhiiu
 rhFNuiSAMABiFlRfYHSOwKuymMLpiaAYlIyGKiraJq4CzIvIIK0Y67nGsXqz6WvdpYqH
 M1Mw==
X-Gm-Message-State: AOJu0YxLi8hv9CaG1OHDBHrrWiixOYmXNmN2Bq6BcuSi1qD40vey+WGU
 kqx5R/RZ6SNn0k0XZPr+6Q0MFx57OeXIVRw20rswT4HTLYQE2YsUEWme9WGGBYObTW+tRfEP8C5
 cukPidy7rbXhH2dklNGoUCi+cGGjXaVh+abVDTO8aqb0hNl8=
X-Gm-Gg: ASbGncssaPJUZPKSLmegHTGkeAuQ2r9xS9urDuHGIK5LMqLDEVZV1535VvrM4hJoFkI
 BS94wlL6+hC+408sXHzOEIeVELKy6K2WbCvzjtDSeArYSWBrIJhL7tCUyQm2rjMlp1KARsjKR4A
 ==
X-Google-Smtp-Source: AGHT+IGzhDv2ll6nazBXfRE/5R46lN3icXrnJb+Hwjt53pX+1S56e59ic5BF3Q03ThDVmGU/HZHMJS+wTiq3BLmqBzM=
X-Received: by 2002:a17:907:9716:b0:ab7:d77b:43b2 with SMTP id
 a640c23a62f3a-abb70c486c1mr432784766b.33.1739640088683; Sat, 15 Feb 2025
 09:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
In-Reply-To: <20250215144147.GM1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:21:16 -0700
X-Gm-Features: AWEUYZmc2tU5lKPwzo1PcJDzhxUAnwXdKRDL6Nf2qBVR9e8_Jj3x7R-H0lRznjY
Message-ID: <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > >
> > > > This is a global default, so put it under 'default' like the tags.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > > Please make v4 include the way you redid the second patch and be on top
> > > of mainline, thanks.
> >
> > That's enough versions for me, so I'll let you do that, if you'd like.
> > It probably doesn't affect your tree as not as much is done in
> > parallel.
>
> I am disappointed.

I'm sorry to disappoint you.

The background is that I looked at the difference between our trees
and the gitlab files are quite different. My CI runs take about 35
mins and it seems that yours is around 90 mins. I would like to reduce
/ remove the delta (for time and patch diff), but I'm not sure how.

My goal is to get CI runs to below 20 minutes, best case.

Regards,
SImon
