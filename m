Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69453C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 16:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230D888646;
	Thu,  1 Aug 2024 18:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hy8Jpfzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA3888B31; Thu,  1 Aug 2024 18:14:51 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2596F8870E
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 18:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-709428a9469so3924161a34.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722528888; x=1723133688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LO2U1kHor0cVot0FwBqja7P/JSaj/F8gpMvve7VqgVI=;
 b=Hy8JpfzrC8RnG324SvBsYctb/xfNOKYEHh5P1PgN43Ya9sRjzlueOMqQ4IkJOe6MSN
 sVnqazsOVIOiwhLoR7lzxVwpyktTsRmVYtcR36He+w3MADY6f/7Hn1w4yaAClswJWEZG
 y7IClXSjy1MzEkTqK7ly0tNcPz3GZIwFIeiq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528888; x=1723133688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LO2U1kHor0cVot0FwBqja7P/JSaj/F8gpMvve7VqgVI=;
 b=Yk0Th7mFsQKNcWzoBKKDdBKlDRKt7PwxSC2rHnn6A6amJHY3VkB6PUiQOz1I/kl31K
 YgY8Mg4AQEOgrcuscKg3XN6Ba0xN8Xtgcn19Czg43fl2/n47h2G9MqwKyISvI1/2to25
 csijL2+f7Tmec4fc7v1yBdoGk4sYJh72npnr5bep61ZluCtD7HgiGgRk/8kB9ysiqi4A
 2jEu0zGr2eo66w+v589Lc6VQUxgFLIroonpM9dCMQM+tGfahGiGNCDNb1cnk3eCNJlno
 rWzfjpnqNFvyOJoQmIRnFQ1j6eWDYnNX5Jri+oaD0Dnntr3oAMeP1S0wMZuJ9upMFzDX
 lJfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAEGM+D3v82zzDXNDG3anE052/fVBKoK9gFusJV0IUcSE4IHNt6YCFEe+OhRvKS9mOTbJircKzDpJ09JC+ZguvRvTbsw==
X-Gm-Message-State: AOJu0Yzemn0Ydcg4AjiopvaLnZaVBTNu78fuqDrTicnM77b7Ku44TUft
 Fho70/eJU2GsRdgjGwropPd0QPLHds2uICJE6E4ZJ3A6mZKnj5GP5S9O+zmBWxIHHyc1LdbHKdJ
 P6BBdzbK0W7UdXhQ1tamRb+X+Q3MgvsJBwlmg
X-Google-Smtp-Source: AGHT+IGE8Lb3p5LEUpilqHyr2G/7BkKtpRnNQWhBRS/iVsEpScK0SXjZJ9sopwn44pAd5coLlg//Ehujhr95iDInJIg=
X-Received: by 2002:a05:6830:2781:b0:709:3a05:36c9 with SMTP id
 46e09a7af769-709b998180cmr735548a34.29.1722528887943; Thu, 01 Aug 2024
 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240731160754.16263-1-richard@nod.at>
 <CAFLszThXjgSBHjUmbD1whpVnRvQO0rBXdYv60RS7DgXwrbzvKA@mail.gmail.com>
 <5054868.82XvGhxQ46@somecomputer>
In-Reply-To: <5054868.82XvGhxQ46@somecomputer>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 10:14:37 -0600
Message-ID: <CAFLszThYgQJWMB0LQPxh-JqSGFj_Ooi_4HdTGjA0=Br256-FnA@mail.gmail.com>
Subject: Re: [PATCH v2] bootstage: Fix out-of-bounds read in reloc_bootstage()
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, 
 upstream+uboot@sigma-star.at, patrick.delaunay@foss.st.com, 
 marek.vasut+renesas@mailbox.org, yangshiji66@outlook.com, xypron.glpk@gmx.de, 
 eugeneuriev@gmail.com, raymond.mao@linaro.org, devarsht@ti.com, 
 bmeng.cn@gmail.com, trini@konsulko.com
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

Hi Richard,

On Thu, 1 Aug 2024 at 08:48, Richard Weinberger <richard@sigma-star.at> wrote:
>
> Simon,
>
> Am Donnerstag, 1. August 2024, 16:42:14 CEST schrieb Simon Glass:
> > > +       debug("Copying bootstage from %p to %p\n", gd->bootstage, to);
> > > +       memcpy(to, gd->bootstage, sizeof(struct bootstage_data));
> > > +       data = gd->bootstage = to;
> >
> > should be a separate line (patman/checkpatch complains)
>
> I saw the suggestion of checkpatch.pl but ditched it as matter of taste.
> Do you want a v3?

It's OK I suppose. I used to hate that checkpatch.pl rule too, but
have come to get used to it...it avoids hiding the gd-> assignment
that my eye is looking for :-)

Regards,
Simon


>
> Thanks,
> //richard
>
> --
> sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
> UID/VAT Nr: ATU 66964118 | FN: 374287y
>
>
