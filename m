Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717DDCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304E86DCA;
	Mon, 16 Oct 2023 14:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qd2oGizx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC1186BB3; Mon, 16 Oct 2023 14:57:33 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F44186BD6
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso143926666b.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697461049; x=1698065849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ojzP586Ps7Lp0uGP1UGnN/FPWlzgdzdCu7AStYfBBps=;
 b=qd2oGizx9Y2wFmHmC3MnLv2MS8Fq2gLzJRz+v/CpRaikQURGXEqM/BWlUinvs3Dug9
 /fr2auBwY0UIrkXDI3ikKDlj2wbg2MNAwvZ6VjEa6h48VkfgbPExlZQeVGBuK7C7PpZk
 hdO8/GUc8wX+s2Bo9rXnepee3msV+i5/lBIlxSXfp2govh+Xz2mqzn+owEjt9p3FkznA
 pmt3rZTk9ASFZhG+J8tacsea2HYdRVsokAah1erADO0Wb+bR+IVSQN55elIZqQCjqAex
 JYZk2HJVeL2U7MlxNtfgPXgG+7Nlw3j/Os08C+y3NLYaRpKTaIIDjjuc8c2I3wqfXfid
 49gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697461049; x=1698065849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojzP586Ps7Lp0uGP1UGnN/FPWlzgdzdCu7AStYfBBps=;
 b=ItHeq1hn9vTFk5VgZAnLK/oDqmN9aEz7H/tXLJkbBLkSARq0IZbe8QnSbs0q9Qx6p5
 ukAQZh7pExkoXdP1l3VkCMRDT7Oq8n9uuR2AwmBaebFE9s+smrZRCnkMmp9EepDBNsgZ
 1dkWPDEfLK3j3wHQ2TvPJq7914goRjPn8dK7wLkIdPBgONFHRpkwu+lkr8sjok4QwsPl
 BmCCqtKc9qV8ES/svU1bMBesdv5QfB2oShStm9CSN5C4iK//W9HCIYPl2WEauIIXE9rD
 lh4Y9L5bACPP8naZel560qPoDhlKaN6A/gNdAikrcJWqtKeq8gvmpErKdH/3FTerzXEu
 +DsA==
X-Gm-Message-State: AOJu0Yx+EOhTzfxdCFYsRVKhYOprDOy+3YFFdFYs33SGxDkRrUoRnmvf
 QzviyGckrCghu66SZm3FLcDF2w==
X-Google-Smtp-Source: AGHT+IFZzh3RHmYZBksrx0cPYuMFlKHWxvhBFvw68h76z2AkkV7qEHRbX5vdhMcQICVnh5WU+0jTbA==
X-Received: by 2002:a17:907:6d2a:b0:9bd:d1e8:57f1 with SMTP id
 sa42-20020a1709076d2a00b009bdd1e857f1mr6724458ejc.50.1697461048746; 
 Mon, 16 Oct 2023 05:57:28 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 gx11-20020a1709068a4b00b0099290e2c163sm3943312ejc.204.2023.10.16.05.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 05:57:28 -0700 (PDT)
Date: Mon, 16 Oct 2023 15:57:26 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
Message-ID: <ZS0zNjTK7PNxedBj@hera>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
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

On Mon, Oct 16, 2023 at 02:46:46PM +0200, Heinrich Schuchardt wrote:
> On 16.10.23 14:31, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > >
> > >
> > > Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> > > > Current efibootmgr automatically creates the
> > > > boot options of all disks and partitions installing
> > > > EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> > > > Some of the automatically created boot options are
> > > > useless if the disk and partition does not have
> > > > the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > > >
> > > > This commit only creates the boot option if the disk and
> > > > partition have the default file so that system can directly
> > > > boot from it.
> > >
> > > I don't directly see the user benefit.
> >
> > The user can add an HTTP boot option now and the installer will
> > automatically start.  That would allow products to ship with a single
> > boot option provisioned and run an installer on first boot
>
> This commit is not about HTTP. It changes how boot options for block
> devices are created.
>

You are right, I misread the original reply.  We should keep those as well

[...]

Thanks
/Ilias
