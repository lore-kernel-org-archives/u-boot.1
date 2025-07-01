Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C724C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BED82EA5;
	Tue,  1 Jul 2025 08:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P6nMh1YV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A5781FFC; Tue,  1 Jul 2025 03:25:30 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F528006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4a585dc5f4aso60305711cf.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1751333124; x=1751937924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=vInoO9ttG4/gyyKgG2tR2wKQ0VgK3NaaziGpE+6ucuQ=;
 b=P6nMh1YVo3J54TSehIEvtaVmhWMcH86iyUW+7+8TKa8BJo+P8O62wgI9K0JQ/3eXRd
 8r8JeNVWEy1ZIIi4BvuRb8bxZuaA//3soJ1sndAF2irP4MrUvwIYtpCT8oH2LMNgUgiR
 skNPNdVF1kQz5Js7wF93JL6bECRFbpbmBYdV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751333124; x=1751937924;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vInoO9ttG4/gyyKgG2tR2wKQ0VgK3NaaziGpE+6ucuQ=;
 b=JC5mcOfb2S3CCQkWrVOcqeZpfmwyu1pU/vfbw1/jurBW/EJdDF0Atq3IlWev+aWMk/
 tOR/lD3Ir5nXDaWgvxIxaj/Q2r8I/+fTVi0zZiRpcr7m05nvncbn1eiSdyMPz0UhFzmr
 cx4siQC9WkDfFWajqAwolv4gtQzSfLPOQWCQRVgNLm5pIO08eNnx2yes7/hktA4hiLEo
 ZDfBMmmSxyIXfSbfTB5tOeVM9aLEvgq/pjdeizQFJQy2MffRlewPhIEtKUsKlPGwggff
 R+FFsn12NDDpksqwFWorin4NJ9WzTn4/OWdGVmZvEUX/hAcymvYQUtu3tn8j+hA17nJ3
 jOzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVvSxoRQvXS2pfLJNOSNgwli3KVEpgUJYkXXzN1bj98PORQWUDlBC5xFMa868+t4w9R7czNps=@lists.denx.de
X-Gm-Message-State: AOJu0YwcVghXl7px25hz6zTwLZxQRNZh8BjhQMGgAniJwzeY3FnpSarD
 U8Z9EH8ch3iQjoNRlKWHCD9KYPoSNo63dD6Oa4ujX733BKI+KXOD3+fM4yxH0PLHqaM6suR/MFJ
 ci842u6rL/6jyBDCIGlnqsARAF2ZBjv+MLycpFnQb
X-Gm-Gg: ASbGncupd5TCiSBUCwRig2dNpHv9hBteoARTcA6By8spGzd2XST31owqGPmKpgS7pkm
 yX7aLK2hiSIIp7cUFGa/+ivHdWlMAXLxzfTixsIoDYktK6mh8ZIoS0efV9SMmEcPC8A1+jCdX3y
 UzyPoGB2StTpZb8xgphp24+o9dPMWSktTA99tiA8214D0=
X-Google-Smtp-Source: AGHT+IHBYi0tymUtXAPJBXmU9qjkAyZnR4q8yOGqFj+FHXeEF8baoe9lz/fs+WumEiKgXLJERVns57gfw2pdwKKgDro=
X-Received: by 2002:a05:622a:30d:b0:494:a2b8:88f0 with SMTP id
 d75a77b69052e-4a7fcab19cbmr241879081cf.33.1751333123947; Mon, 30 Jun 2025
 18:25:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 18:25:23 -0700
MIME-Version: 1.0
In-Reply-To: <5b13c86b-1efb-44e1-9ee8-03c2863337d0@linaro.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-8-swboyd@chromium.org>
 <5b13c86b-1efb-44e1-9ee8-03c2863337d0@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.11
Date: Mon, 30 Jun 2025 18:25:23 -0700
X-Gm-Features: Ac12FXzRyAnA-0za_Mh0n-3J-JPq1Er8-f2JsQbs3uXyMvT4569DBnbzcvG1LPk
Message-ID: <CAE-0n51i1vg1WwjHJxdvwWu15kGsoLtK=NhJMMSdXnxAs2ttKw@mail.gmail.com>
Subject: Re: [PATCH v4 07/28] serial: msm-geni: Enable SE clk in probe
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Jul 2025 08:48:20 +0200
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

Quoting Casey Connolly (2025-05-28 04:23:01)
> On 5/24/25 00:58, Stephen Boyd wrote:
> > @@ -561,6 +549,16 @@ static int msm_serial_probe(struct udevice *dev)
> >   {
> >       struct msm_serial_data *priv = dev_get_priv(dev);
> >       int ret;
> > +     struct clk *clk;
> > +
> > +     clk = devm_clk_get(dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return PTR_ERR(clk);
> > +     priv->se = clk;
> > +
> > +     ret = clk_enable(clk);
> > +     if (ret)
> > +             return ret;
>
> There's a subtle change in behaviour here, since we'll now fail probe if
> the clock isn't found. I think it would be best to treat this clock
> being missing as non-fatal since it can make bringup a little easier (no
> need to stub the clock).

I tried to return NULL from the sc7180 clk driver as a test and the
serial driver still probed. I think clk_enable() doesn't do anything in
this case, which is how it should be for other platforms? TL;DR is I
don't think this breaks anything.
