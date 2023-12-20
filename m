Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE8C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356058765E;
	Wed, 20 Dec 2023 05:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ik95REYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EBA8765E; Wed, 20 Dec 2023 05:47:27 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D608765B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e49a0b5caso1628539e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047644; x=1703652444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rP08qD9+EA9kq7SDwDSp8r7VtD4RdP6qR3cbsU0sEYo=;
 b=ik95REYYvC9gm4trVNXg4jgebLtlnqHep0lksFX2bdmSZ7yXIqyG7XHwFbNXPc7mDd
 duC97PgDaR1Em/xcNKCRTgwQW6An8mTPeGE7/LFPIz5boaYRRd8wozdrrH6JggvmoggP
 a8VEaUPzOYsSIuTQIs8Q5LBaTiagN1LeuOtEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047644; x=1703652444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rP08qD9+EA9kq7SDwDSp8r7VtD4RdP6qR3cbsU0sEYo=;
 b=cP5CccVQoZNbluTdJflMMxzOOlyexN+d34wFIwwFbzs+w266FuWPRzNIf/ZF4wnenf
 NNyrO/SqnvbL/2jUL2EVbXfQgwpvpnkC0Sa1eY6zUvCNLfBa8zepSiJoTQ3iraONXCNy
 a64Aqb2cs/QATeBZxPivv7coWBexA9QHMl5i41cGR2eJ80E8m5iVjt5eXaTBd5rl552e
 bmARmP+C3ALEkYr8lf15tbJ04ZyqBj+VBTrPVdMSojKaKnqlJRw9KOMmBFQBW6371rHr
 EeyzCHJtunRUeNPdbADSko/MJ2PdiWeeuhEdQXy4X+3pdje2khHmivOfQlzI1xVER9l4
 PIQA==
X-Gm-Message-State: AOJu0Yz89hMnnQzQ3AKReKW77zYPUtM9fv/UMr4W8zY36B2J9mrVOSFW
 kBftYmTr8BLnIgdXTEAXL6o7t1FFWc7TsyhQ3U8dUA==
X-Google-Smtp-Source: AGHT+IEf8EfUuibeWP7DuC5QCvwOcnzTSN6HCyWpZ1jGW1Q4E0LmD26wmfd8i0Ya/eoD4fBlqjTdU67ikpqBm+dIIRg=
X-Received: by 2002:a05:6512:220f:b0:50e:44a4:f7e3 with SMTP id
 h15-20020a056512220f00b0050e44a4f7e3mr1389613lfu.81.1703047643897; Tue, 19
 Dec 2023 20:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org>
 <20231214142713.GZ2513409@bill-the-cat>
 <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
In-Reply-To: <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:11 -0700
Message-ID: <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for
 CONFIG checks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

Hi Sumit,

On Thu, 14 Dec 2023 at 07:46, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  .azure-pipelines.yml | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index d6f3fa423c6..f100c4493e6 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -65,7 +65,8 @@ stages:
> > >        # have no matches.
> > >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> > >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > > +                  exit 1 || exit 0
> > >
> > >    - job: docs
> > >      displayName: 'Build documentation'
> >
> > The GitLab tests needs an equivalent change.
> >
>
> Sure I will do that in the next spin of this patch-set, thanks for catching it.

Also, please add a commit message with that :-)

Regards,
Simon
