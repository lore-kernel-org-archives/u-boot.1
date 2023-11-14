Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 01:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D6887026;
	Tue, 14 Nov 2023 02:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rhHYign/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4485A8716C; Tue, 14 Nov 2023 02:44:25 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDCA86F88
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so824425b3a.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699926261; x=1700531061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncQ+sYokHtXpbYBef2jLyjGwYS8tDY6LqiqvHXK1K5Q=;
 b=rhHYign/DHPZ1jRz8zoB/m6UM1bU+Ab0IPpdHuLpq3nuotqhKmm058uohzm79V/0qt
 wpQxV+p6Nug76M2Z/jcBdHpjR/W4KgvimerhciAgDQeOEAQbE2qtoDr6IteYrcafaLEt
 NAPxgsxV9FC3S2Jjud3rZ07OGe4GLZL+qK6HF5GyT5TnjNsknlJ8/SpkTFR1HwzovZ2g
 zQq5NuQGpxcoIjZ91I7DAAZOTjZrVIoCkGgu4vpzND+0B8hmwua4mPVKyKvt7Xwwya8J
 RB24ZpOIWxUYqHZqXGVgkv1iWjMMUcbsfhsswL5/b1+mgJv5RA7mRXJF42/bY+tHulUH
 Vn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699926261; x=1700531061;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncQ+sYokHtXpbYBef2jLyjGwYS8tDY6LqiqvHXK1K5Q=;
 b=oktQddL70EQRC+kaI9tk3EQqV2ZoxaAGjl6Clpdc4Q8tuz5Q/dGuQcbkwHoSoFxIVN
 LCJYe4XyKFuWFlNx1nbuWSYLA80Bph8eidq2+884aGqLXPr3nAPPrCz6WU3kchuoVxIn
 xNDMrhm5ubbPO2dbWlEvYBwEDBkV9GuMu2ujd+LNl4jJB1tA7ulVunKMNZ0YOA58TXZY
 1TibZPpjDvvq8mtYr54OoHAx29te3jlPdfekgJkWMnIvCsdv0HZQir/VqgzovhFIIaTo
 bytbDlMyOIYlJjC3r0TZakUFhmvHtJDjipJqoW5kvc38OfeHllSk8K5JuAQPpH/qiwm4
 pwHQ==
X-Gm-Message-State: AOJu0YwxaBl6Cgp/RVMtBonKlwjEqX7DNfyVs9U+F5gphb1nlSkgsYrs
 68wIVFPEMDA/9oZJfmc1uT5+9g==
X-Google-Smtp-Source: AGHT+IH62kWvzilr1m11o6tz7u67wVe8a2uN0H6lN5qmnLKZzZvmtudce7Lv1HDdYB1sdjDKZuln2w==
X-Received: by 2002:a05:6a21:338f:b0:14e:2c56:7b02 with SMTP id
 yy15-20020a056a21338f00b0014e2c567b02mr1297814pzb.0.1699926261355; 
 Mon, 13 Nov 2023 17:44:21 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a056a001ad200b006be22fde07dsm214657pfv.106.2023.11.13.17.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 17:44:21 -0800 (PST)
Date: Tue, 14 Nov 2023 10:44:17 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, michal.simek@amd.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/5] test: dm: skip scmi tests against disabled
 protocols
Message-ID: <ZVLQ8bryk6Jjo5C0@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
 <20231113014911.3308990-2-takahiro.akashi@linaro.org>
 <CAPnjgZ1AQMoKVgF_tk6fhnMaTbh5=gtgy6XDPgvLs4BjYR6+Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1AQMoKVgF_tk6fhnMaTbh5=gtgy6XDPgvLs4BjYR6+Aw@mail.gmail.com>
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

On Mon, Nov 13, 2023 at 11:01:18AM -0700, Simon Glass wrote:
> Hi AKASHI,
> 
> On Sun, 12 Nov 2023 at 18:49, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > This is a precautionary change to make scmi tests workable whether or not
> > a specific protocol be enabled.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  test/dm/scmi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> > index da45314f2e4c..2f63f2da16fb 100644
> > --- a/test/dm/scmi.c
> > +++ b/test/dm/scmi.c
> > @@ -217,6 +217,9 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
> >         u8 *name;
> >         int ret;
> >
> > +       if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
> > +               return 0;
> 
> -EAGAIN to skip a test

Ah, I didn't notice such a common practice as it is rarely seen
under ut. Will fix.

-Takahiro Akashi

> Please update a comment if this needs to be documented better
> 
> > +
> >         /* preparation */
> >         ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
> >         ut_assertnonnull(agent);
> > @@ -317,6 +320,9 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
> >         int ret_dev;
> >         int ret;
> >
> > +       if (!IS_ENABLED(CONFIG_CLK_SCMI))
> > +               return 0;
> > +
> >         ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
> >         if (ret)
> >                 return ret;
> > @@ -382,6 +388,9 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
> >         struct udevice *agent_dev, *reset_dev, *dev = NULL;
> >         int ret;
> >
> > +       if (!IS_ENABLED(CONFIG_RESET_SCMI))
> > +               return 0;
> > +
> >         ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
> >         if (ret)
> >                 return ret;
> > @@ -418,6 +427,9 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
> >         struct udevice *dev;
> >         struct udevice *regul0_dev;
> >
> > +       if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
> > +               return 0;
> > +
> >         ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
> >
> >         scmi_devices = sandbox_scmi_devices_ctx(dev);
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
