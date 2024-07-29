Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F345CC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE2D887B9;
	Mon, 29 Jul 2024 09:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IecRvLpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84420887E4; Mon, 29 Jul 2024 09:50:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BB9885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5afd7a9660eso2973917a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722239457; x=1722844257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GRE91g9/pjUOVUWSA6t6D7i+HsjYHZtUcNOiMAG0Qtg=;
 b=IecRvLpXzrjzAAT3h6m8huF4t3WzZsO4dxJhp4r9TGYvSsiacEPrZlqJHILFzXttQ5
 Q8Hh9+FzQZql6oZeaiYrl2LxflmYwunHpfoeESWCMUCRLFZScajo0NGL/3gggvngC9IY
 zaMuvO5/KvfpleXyObtYNgvl/LpunE0NDmTFe08Du6rJRtY+Semo6L7tnRIF8CkE897Q
 N6X3IemhgbyblTAZTTOC5NfFs/4a+Uh7zcOIfP7De7RiUpJXUY1LQ4HFUmzMV9QQjXHz
 /pTA+vZ0iSqQ1Y6CplUMazAFuqCJCwqpEN1KPUnOzZMpZCqhK1SIcBW1bmt6AFomXXC7
 I/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722239457; x=1722844257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRE91g9/pjUOVUWSA6t6D7i+HsjYHZtUcNOiMAG0Qtg=;
 b=ccqUhbJWfspEZ/h18wj/m1nt2WM9rY5gZxipTGTlaIcMNY0ix9gv0nGgY8HCWE+fq9
 +DRXmcAvZ4Yd0ndEVDCZmmBRHNTVq986AVmT4APpqTWW8EDydDP2jS/QW0zqzPDNECI6
 ZE2fVCNfCWabz4V7Zsnbb8c41J6RANW6VcgEBChuyHc7r6RU2pcU3MEBytjhnbHaWjdd
 SXcju9j4h30j3o5yfepcdakcTOEWdy9bHyxNvHSEPmYoj5lDdA1XmIt3uU0DPZrsvDax
 KfqavWqBD8aVLEw2TV7hFh/n4ZQszJq9QeLxBw9GuLzfsICcYzOLzMtkkT27r7/h2TMf
 2gPQ==
X-Gm-Message-State: AOJu0YyMVaOtdyRWX7Hp8jQkT0T8Da13Uxx/rqtF6IfkbmsKR9lv82+F
 3Tuimcajko80zI139hM0r16bt+tKXUzFHOGYLM8tFW5FCO9h46PzEMBv5Al+xeuaI5DgSvFa0IK
 Bz35IJnvUKe2eVVhbX+txV5N9JasRE3NnhnfM4A==
X-Google-Smtp-Source: AGHT+IHkXmGt0qzhSbcBydz1RL+G7RRAZMZ6NZ9Zu1m5uvOMhA43y8rrI2x5HpYLIL3M0pxRMhOb9cerRqOFTDrqY58=
X-Received: by 2002:a50:cd1d:0:b0:5a4:1bde:eb18 with SMTP id
 4fb4d7f45d1cf-5b0224d00f6mr3441114a12.36.1722239457120; Mon, 29 Jul 2024
 00:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-16-sughosh.ganu@linaro.org>
 <CAFLszTjocf-85dbHDXO25GdHfmXeVsavYmyEvRc8wOS2jq31Pw@mail.gmail.com>
In-Reply-To: <CAFLszTjocf-85dbHDXO25GdHfmXeVsavYmyEvRc8wOS2jq31Pw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 13:20:46 +0530
Message-ID: <CADg8p96Fb5ZEg02c2gY15cVLQ4PU9ZGE6__rodTFEqnQM5Hrsg@mail.gmail.com>
Subject: Re: [PATCH 15/40] lmb: config: add lmb config symbols for SPL
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add separate config symbols for enabling the LMB module for the SPL
> > phase. The LMB module implementation now relies on alloced list data
> > structure which requires heap area to be present. Add specific config
> > symbol for the SPL phase of U-Boot so that this can be enabled on
> > platforms which support a heap in SPL.
>
> Could you please add here why we need lmb in SPL? If I missed an
> email, please can you point to it?

Like I mentioned in another thread, both you and Tom wanted this
supported in SPL.

-sughosh

>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  lib/Kconfig | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
>
> Regards,
> SImon
