Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45317C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A73387A89;
	Thu, 14 Dec 2023 15:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EmKzkj82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1141787A58; Thu, 14 Dec 2023 15:46:43 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B45987A99
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4648495a842so1836303137.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702565198; x=1703169998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JeIl+XkY0bGHqZqk+14oYTG+6WPOBC/t5scVWQtixzM=;
 b=EmKzkj82jWoTGOT92f33mZo8eXbMdes7ZmYPJPXBPdB/IU9QCE+LimZDyQ2XKz/Tst
 Y0g3zaDirHSh6I9IehmwtGn+7iIWgI8IYO6Sp1UTiU862qnxk62AfzOIkaXNbzw5gTGm
 lhTYp4+Fcw8S538gSu+8ZIlNqr9Tn5VeED2/wrsTHM4X9yRnEkvT3+zVTON74yGsOw8v
 7DVtiksmHpHrjxmB62ldeCxrQw/WukTESY5H632HUot2bWTLPZhOFEc274TnVT2VU9CB
 IkYu4irG75jkQf+P1zj8IA8ozpG5xx7eFT3Eigjgq8R5d2A78fpbECAwwsEfkEar5ziJ
 AFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702565198; x=1703169998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeIl+XkY0bGHqZqk+14oYTG+6WPOBC/t5scVWQtixzM=;
 b=Sx+h6scu6M0WUvsZG3wXb+aOwYybWo6VfSwTJJCkfxPiG7IWziG1trtOX8fpNv/5kh
 kUt1lq+ZrIhmFAY1i4/YU0EOUNAUvSAD6gsDRbzaWQAOB0chpMvI2Fo67nD2r1NIIyPl
 Ev3BVjqFf/cCYOO+fOecIYO/Prlwf6+i0n3ndnjOwLIOUALJoi+JHsatEZphUewv4PRy
 OZTwo6I6KbqU0fMaBGcNFUPn3aREa/WmhUbWr3ArfFTqlWklrPsIwlWPL8ct5g+dzbrS
 3UGbaLhYKg4/ZouFz0ED3hH8vEf+LZN5K1MHh4br3gD72bf0J6BM3PT9SUX8uKjkvJcS
 4+EQ==
X-Gm-Message-State: AOJu0YydBZ6a4I7jQWyXiHQ2Gz/U0Np4HMp4K+4qcZZ+SEP0nrq1N5u0
 AeiLtKN7vKChNZVlSmvJRG2DBE0UoxkpxkivFCwBnQ==
X-Google-Smtp-Source: AGHT+IEpzEwZyYXVyGldN3Fh82UVtz5TH/o9Oqo9fIuf65mXdAK3NuzEZZbDoIy4IokrUV1Qu/o90YftZebrV02Vz+A=
X-Received: by 2002:a05:6102:3a0d:b0:464:4f99:67cd with SMTP id
 b13-20020a0561023a0d00b004644f9967cdmr8261477vsu.25.1702565198207; Thu, 14
 Dec 2023 06:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org>
 <20231214142713.GZ2513409@bill-the-cat>
In-Reply-To: <20231214142713.GZ2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Dec 2023 20:16:27 +0530
Message-ID: <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for
 CONFIG checks
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
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

On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  .azure-pipelines.yml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index d6f3fa423c6..f100c4493e6 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -65,7 +65,8 @@ stages:
> >        # have no matches.
> >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > +                  exit 1 || exit 0
> >
> >    - job: docs
> >      displayName: 'Build documentation'
>
> The GitLab tests needs an equivalent change.
>

Sure I will do that in the next spin of this patch-set, thanks for catching it.

-Sumit

> --
> Tom
