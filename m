Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04EAD3DEA2
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FD888E5C;
	Fri, 18 Oct 2024 19:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ReKIbFUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A364D88CC1; Fri, 18 Oct 2024 19:21:08 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B8188DFF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so15077726d6.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272065; x=1729876865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zlk50nBs1YfX0mBDDFAM23fcT4QzcWpvMYeJGRNM3yM=;
 b=ReKIbFUDy8eEq7TH/2MIbiilpd1TeKwHSCWO7IP0wFQcHvK8HzhHY0z7hefaDPTnFu
 TnF9Wwf7mUgYTB1BxDz6ubzaCfFtTv6i1TD7I/RiIojHJdRqh7pDIJfRTku1erqVpp57
 xq9NmhGdOcZTzefW/VFSRi4J2x+2wSF4S7Wpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272065; x=1729876865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zlk50nBs1YfX0mBDDFAM23fcT4QzcWpvMYeJGRNM3yM=;
 b=ZDIIjoHSWnTGKxxTL2j6b3w8vid5ybdsapnD8C2SX2IFWOhntW+wFJfJj6MGSHLb4w
 VF+X31baxFq3Vv8bEekakVTSoNP0RE6laZesjob5E53KanLwFeqG+d/27EFX+P9N9Gy6
 Z/0C4EWqsCWeKRMYuMKDZvN6Vod8g917raGUY1QwYGRk5oSDCTHWgpb3EP/OwJNeq2Qj
 4MLVtylMwbjeR8sP3Sz7rff+qHThQLTC4EfqoU2v5HMO2n3eFNCH5q6YEZMAVUJeTyAf
 1BtmN0uA8TJVbx2AC6/cOfP0liWeSuQBBb6a0JdYZj2OLh+VmJlhTfb0y2Lt94OX3Acz
 yG3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBr2+7X9dC5uECSSBGTqID3+jrkg6El/o8xRHpRv0RxpDmUoNAQvKKKl2QUCJnodtnE1QLzhY=@lists.denx.de
X-Gm-Message-State: AOJu0YyPjY7v3iS8x3kQrhmEVV+HqqA2cnzscpscY0g175TdYRgglszo
 l3MduvPwITyJXjm5zLfqlCFaTBTXWrTM/lKlKQp0vYFn0EhFlhcrRccAOboOsDnMSNuXRn7hDjA
 8t73es/prUQ8kL51A8Vuj3ie24O3tC4qguZxw
X-Google-Smtp-Source: AGHT+IHxxZ8l8EWYeF8zNRKUi9k9zW9XajoJybZ27P+QLIYdrtszpTajOV+HNYIXZM+S3EBp9mssJxlUfrA5uH4LLk8=
X-Received: by 2002:a05:6214:4808:b0:6cb:99db:bdbf with SMTP id
 6a1803df08f44-6cde160f1bdmr51851756d6.43.1729272065484; Fri, 18 Oct 2024
 10:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+N7GviHP0yL2_Pz9_1Ysdx2dV4D4dMRuacs7nk6B+7hA@mail.gmail.com>
In-Reply-To: <CAC_iWj+N7GviHP0yL2_Pz9_1Ysdx2dV4D4dMRuacs7nk6B+7hA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:20:55 -0600
Message-ID: <CAFLszTjRX=euO04XuiXS9a55wVgXU3bPF_yA-q4Qv3g0Qog_Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: reduce noisiness if ESP is missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 07:43, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 18 Oct 2024 at 04:18, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > EFI variables can be stored in a file on the EFI system partition. If that
> > partition is missing we are writing two error messages per variable. This
> > is too noisy.
> >
> > Just warn once about the missing ESP.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         new patch
> > ---
> >  lib/efi_loader/efi_var_file.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >

Reviewed-by: Simon Glass <sjg@chromium.org>
