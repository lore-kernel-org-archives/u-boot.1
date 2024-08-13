Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAEFC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09F6889BD;
	Tue, 13 Aug 2024 14:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ap60ZVNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FFA88997; Tue, 13 Aug 2024 14:17:17 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4138871A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso38844906d6.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551434; x=1724156234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MEiVfoykWVcXr2nY5noUWCrw1bo+DYavNsa0/biWFg4=;
 b=Ap60ZVNFrdeh0VMFecYV0FzNjLKwombcEPPrk6T3pLw1RFRRyA1I8KBLICU7fpXazb
 NTCvabTng1ZGJyyjA5ZErnva9mOTskKJo62qRoLXPST0fJKCn4nUCm1LjugR2FL/LVHr
 hF2I+1+8sgRtpYhBst6FBuL7VehOIiUTj3+Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551434; x=1724156234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEiVfoykWVcXr2nY5noUWCrw1bo+DYavNsa0/biWFg4=;
 b=QO/wVHjfCfcCHlmWqfe6GceC98nzcgK4sw57145G9bqKagwTn/m9grWUQ+gbOx3OSu
 SSXt8MJE3CXp/1HWN/wD6wDVmjKih33MNBQXmeijkpP398CMuOk/zr9LMhN0O9T6IxDM
 4AWnbF3nOEY/S6+dHqVHT/na63SSEgP6Ct4yBmQE8XW4Y8vEWid1bkGZ7bmO/TUvXLtK
 pkWaHyQOarK3aLdtfsxNrhd7fOzVZU95M2vE6DtxgomBGwVVdSpahMF8SLk06oEu4XIM
 +GvJT8lP4G+TvFOO3kYyA0td+uOAlk5727y73tqZhts3YLKjTGJIqPvWx8knTrB8DI7c
 4L4g==
X-Gm-Message-State: AOJu0Yx0xtA+8OGifNrVqLG3/DaTEdKQlJkInkYbJxZsHYyFuu/W62l6
 KJh5E8fX9BVUboY0dfNaSaHGhEhmwiO+mObAQxctKMxwUNE6ZBxg33VAAPu7heYWW2VeYWl90Oe
 bojScCPb4CnFl2SsBhkOGkPip4XJNe1mw2n1rdTxQghJKgT0=
X-Google-Smtp-Source: AGHT+IHFAMbI2Njl6whhU/BbHlnTAjhZnV1MB2cpHstch6dNoBfLo0HqPWZDiU/B+Cj2ZQAB3RZRJFb6rwaPb5xE0Lw=
X-Received: by 2002:a05:6214:2f8e:b0:6bb:9b66:f264 with SMTP id
 6a1803df08f44-6bf4f443ecemr50950376d6.0.1723551434418; Tue, 13 Aug 2024
 05:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-7-sjg@chromium.org>
 <10e67e98-ac80-471a-a4ba-1c4bad88944c@cherry.de>
In-Reply-To: <10e67e98-ac80-471a-a4ba-1c4bad88944c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:17:03 -0600
Message-ID: <CAFLszTjh7W7JiVuxZc8VWZh493RG6=JfH-VfaKYBwH=FjOrWFg@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] mmc: Use logging instead of printf()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Quentin,

On Mon, 12 Aug 2024 at 03:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 2:29 PM, Simon Glass wrote:
> > The code makes quite a few uses of __func__ which puts the function
> > name into the resulting SPL image. Use the log subsystem instead, to
> > reduce size.
> >
> > The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Keep hex prefix on values which currently have it
> > - Fix up the second parts of the 'mmc%d busy' log_warning()
> > - Restore the original error message for configuring DLL
> >
> > Changes in v2:
> > - Various updates to log messages
> > - Drop an unnecessary cast
> >
> >   drivers/mmc/sdhci.c | 52 +++++++++++++++++++--------------------------
> >   1 file changed, 22 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index 560b7e889c7..4833b5158c7 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
> >       sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> >       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> >               if (timeout == 0) {
> > -                     printf("%s: Reset 0x%x never completed.\n",
> > -                            __func__, (int)mask);
> > +                     log_warning("Reset %#x never completed\n", mask);
>
> TIL about %#x thanks :)
>
> >                       return;
> >               }
> >               timeout--;
> > @@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
> >       do {
> >               stat = sdhci_readl(host, SDHCI_INT_STATUS);
> >               if (stat & SDHCI_INT_ERROR) {
> > -                     pr_debug("%s: Error detected in status(0x%X)!\n",
> > -                              __func__, stat);
> > +                     log_debug("Error detected in status(%#x)!\n", stat);
>
> It used to be uppercase and is now lowercase, though %#X would probably
> do the job too (albeit it would apparently write 0X prefix instead of 0x).

Right, but we should use lower-case hex in U-Boot.

>
> Otherwise looks good to me,
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin

Regards,
Simon
