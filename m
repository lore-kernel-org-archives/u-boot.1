Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9801C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 09:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C8787188;
	Wed, 25 Oct 2023 11:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qfwiGyKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84D7871FB; Wed, 25 Oct 2023 11:07:37 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754DA8716C
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9d132d92cso10742285ad.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698224854; x=1698829654; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cilmICyeis7c/+vMMkiZRhmG9dsZY5GehpO5J2e4qME=;
 b=qfwiGyKEn3ysl5OZ1nmmUNvx2GeA5LyO211FlllheoU5Q81hXtq4nP9EluPW9HYLPr
 zjdrEwJQtiTSif5bXy9EPAHg8Y+Bd6pHVscRMRlZKXqhbJn3RhQ5JNJyiuP2TOJmSnCD
 06xboA1MWRUkd3uATxq48imQIZUXnsUUPtRSdgjYr/qJPDcDlurhXyohkEADZ1pSlPoM
 parjJSb/ec8fWTvX28ytyGXZaTvr9l/pUx2XudDjHVsh6RyivNVyFuT7hvdZ6PWtx16b
 Wl/pjGtA+0ChWXRchhQ4TPOHb/FAkC0WNDbMD1ceJQYzjvj8gDG2wpHD76OY7xB8rzaL
 ybhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224854; x=1698829654;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cilmICyeis7c/+vMMkiZRhmG9dsZY5GehpO5J2e4qME=;
 b=SOAw6go8s5N06C2a5/yFDXS0pwFzGIDoBeHAeRIfKDt7jBYHq0+NpFcYd3ZBzyo4zC
 Metk10tstiqOqftbx+9647HPvSwDrK8hZSNlCn85b8Bgv2Y3qcre6Cg4Nk1StG0l9hgF
 0ByspLei+9OXALPlPNWn4y820rpXanFaRsACo4Mr8XOZZsML2ThHVET45zZ71524ZKAr
 Y/UsIYmdcQhP0hDnGTzUg4PPCCRY1nws5hcH+2jAoVJghiDNcFfHGOVuCKAogSY10iV1
 ECQAhDENHoOsg8DOV+Usf8sdlVCIU7t8TijxbL/ICWKSX/vIYv6zXfmL8cpWqqGT+UoC
 wLUA==
X-Gm-Message-State: AOJu0YyzRfq2UVYJTcyUx8inrW/88iOCoV7QAuODvUmSPQYdYf+J/2VX
 PYIrh/sY/7ohNhdTIYutQu4ksg==
X-Google-Smtp-Source: AGHT+IECxuYtWcZC6u/UepguQPKhkF+dMc4zI05iAA2w3u8dkyXyoqiDcphnl+DAp4kuZ6PWNn8m1A==
X-Received: by 2002:a17:902:dac6:b0:1c1:fbec:bc3f with SMTP id
 q6-20020a170902dac600b001c1fbecbc3fmr14082583plx.5.1698224853658; 
 Wed, 25 Oct 2023 02:07:33 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d50300b001b8622c1ad2sm8691539plg.130.2023.10.25.02.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 02:07:33 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:07:29 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, sjg@chromium.org, etienne.carriere@st.com,
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 3/5] cmd: add scmi command for SCMI firmware
Message-ID: <ZTja0eN4nKSfk+7Z@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, trini@konsulko.com,
 sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-4-takahiro.akashi@linaro.org>
 <cc22d995-1234-477c-bd0f-6ca1946103ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc22d995-1234-477c-bd0f-6ca1946103ff@amd.com>
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

Hi Michal,

On Wed, Oct 25, 2023 at 09:29:04AM +0200, Michal Simek wrote:
> 
> 
> On 10/25/23 07:14, AKASHI Takahiro wrote:
> > This command, "scmi", may provide a command line interface to various SCMI
> > protocols. It supports at least initially SCMI base protocol and is
> > intended mainly for debug purpose.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * describe that arguments are in hex at a help message
> > * modify the code for dynamically allocated agent names
> > v2
> > * remove sub command category, 'scmi base', for simplicity
> > ---
> >   cmd/Kconfig  |   9 ++
> >   cmd/Makefile |   1 +
> >   cmd/scmi.c   | 335 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 345 insertions(+)
> >   create mode 100644 cmd/scmi.c
> > 
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 205df2f1fb65..c940051eba91 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2550,6 +2550,15 @@ config CMD_CROS_EC
> >   	  a number of sub-commands for performing EC tasks such as
> >   	  updating its flash, accessing a small saved context area
> >   	  and talking to the I2C bus behind the EC (if there is one).
> > +
> > +config CMD_SCMI
> > +	bool "Enable scmi command"
> > +	depends on SCMI_FIRMWARE
> > +	default n
> 
> As I said in previous email. default n should be removed.
> It is default option.

I see.
I hope that Tom will take care of that when merging if there is no
other comment.

-Takahiro Akashi

> You can take a look at least on this commit.
> 
> commit b4c2c151b14b59a2403675526adf666710cade67
> Author:     Michal Simek <michal.simek@amd.com>
> AuthorDate: Fri Aug 27 08:48:10 2021 +0200
> Commit:     Tom Rini <trini@konsulko.com>
> CommitDate: Tue Aug 31 17:47:49 2021 -0400
> 
>     Kconfig: Remove all default n/no options
> 
>     default n/no doesn't need to be specified. It is default option anyway.
> 
>     Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>     [trini: Rework FSP_USE_UPD portion]
>     Signed-off-by: Tom Rini <trini@konsulko.com>
> 
> I have also sent one more resync patch and CC you there too.
> 
> Thanks,
> Michal
> 
> 
> 
> 
