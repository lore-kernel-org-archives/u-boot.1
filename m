Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E368C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C24874D5;
	Fri, 22 Dec 2023 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="boB29ODd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04B2871CF; Fri, 22 Dec 2023 16:33:48 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6696874D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28c1e079b20so167226a91.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703259224; x=1703864024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+caM92Q237RWsKA3IKNFyOa6cn5gDGVre/UTYu/2Xg=;
 b=boB29ODdUh6NGuPRvUd+vqp+Qwn2/wUFJaQg8xfKbyN9ES9HLkjEToWCI4ckBL8X50
 1neaApQDCP3eK4KmNwGWCskpGSrhhHlLblP4jRGsgvqhrXk3hCQ6FSuvSI/lBtK9rOjt
 Cm7eXpUwxIMScKH2TYnoOQ13utcQkQiL6JxOodY5GajLUvV/OeBBQGZctTKAzRgXTsPL
 pvUM0kG1tUUfsDvL3OE9jcYZqR3RUIbV5+rhFMOLpQ/mp8e1EAG4cbmpSHdR38G7sEIy
 haetUDQpsLhxzW7loixlkCf34YmZgPjIYbJwxPWfZ7ddIlEqAjXIHeGOwVcGo4GU+0CP
 UDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259224; x=1703864024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+caM92Q237RWsKA3IKNFyOa6cn5gDGVre/UTYu/2Xg=;
 b=hIXvZ9BTtllEsYmLGjGLCsEKpjryqgVHRoaeuZAt8Hd4kOyjVHxL3tjiSzAxu+ucjx
 Edy1cDwD4adxClOtyWugcCv7ino3ADA7iGLYU5dmX4sTkxuRn1+LevNo7bwEyniFXhKs
 DNXhWyPg6pWeIub7Y0Ta46mMQmhBpsE9EiO5Yf/m6eT8Uj4yom0LaxW1Xpb2Ax007jGf
 Rssck65kQgwJOtuz3SB4NjASmtaMj188aJVv407rYLZ5xujcWBIBFnfU+TvIy1OHRyeG
 89ZZPFJ5PFdzmSw7EDPExfpPp/Kh35jDEvaldC9YnyT7akV5TOSOvM7ffYhoHzwPyGAA
 1AiQ==
X-Gm-Message-State: AOJu0YzU2PXR2wti+cVM3NDXHZN9JGim29Gmnjk3E+B7ZqnCdBkkOQxa
 +0UnmrYpDr1GmPeeuQkc+rGy/oRhP7FoGEya37NOrwsxvXygPi9Te1s06aIg
X-Google-Smtp-Source: AGHT+IGBCwYLvKMCDpW4IaUcfvJwsfqrOPB5swxykzhGTJ+CMqRlK5ipqImsrUpDTXT9/YHpAg063ncedEF8v8/mQW4=
X-Received: by 2002:a17:90a:ba17:b0:286:9ff9:ab9a with SMTP id
 s23-20020a17090aba1700b002869ff9ab9amr851313pjr.66.1703259224261; Fri, 22 Dec
 2023 07:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-7-raymond.mao@linaro.org>
 <CAC_iWjLNDo_jDUQ9gdimr+zfRtAGbJ15gP2niNcvb2V7aU_LzQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLNDo_jDUQ9gdimr+zfRtAGbJ15gP2niNcvb2V7aU_LzQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 22 Dec 2023 10:33:33 -0500
Message-ID: <CAEfUkUKXB34S3mf8xccp-H1ES=d0J-YBPDGJNp4HoFin8BFtKA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] qemu-arm: Get bloblist from boot arguments
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
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

On Fri, 22 Dec 2023 at 06:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> >  #endif
> >
> > +/* Boot parameters saved from start.S */
> > +extern unsigned long saved_args[];
> > +
> >  int board_init(void)
> >  {
> >         return 0;
> > @@ -144,6 +148,35 @@ void *board_fdt_blob_setup(int *err)
> >         return (void *)CFG_SYS_SDRAM_BASE;
> >  }
> >
> > +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
> > +{
> > +       int ret = -ENOENT;
> > +       unsigned long reg_fdt;
> > +       unsigned long reg_zero;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
> > +               return -ENOENT;
> > +
> > +       ret = bloblist_check(saved_args[3], size);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (IS_ENABLED(CONFIG_ARM64)) {
> > +               reg_fdt = saved_args[0];
> > +               reg_zero = saved_args[2];
> > +       } else {
> > +               reg_fdt = saved_args[2];
> > +               reg_zero = saved_args[0];
>
> I think it's better if we fix up the order in the low-level asm code.
> Store the variables in the 'correct' order there and get rid of this
> if
>
Yes I agree. I can swap the order for aarch32.

Thanks and regards,
Raymond
