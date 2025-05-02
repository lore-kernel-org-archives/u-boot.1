Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E25C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF2382CD2;
	Fri,  2 May 2025 16:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hrz/94sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E834482CDF; Fri,  2 May 2025 16:52:51 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF6282B5F
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso3578934a12.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197569; x=1746802369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HFL7E5P8Gd99cqtXB8XR+kJ38wLXpl2I87+xhov7YhU=;
 b=hrz/94spfNwZxQqvMSAHYiJFN0fxSobwS0fydKy2HrrBGW6W5cVRNm2LqbPJuGKg7e
 KheXw5aLEREHtLP/gkCz86xe1DRqAiHxbSdoQXM/NKEgmOiDBofU7Kz28sumyZc3Fh5q
 uxDrCs/8v+8ZlwLJ2lLb/E/sJHwn3NWwE9n/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197569; x=1746802369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HFL7E5P8Gd99cqtXB8XR+kJ38wLXpl2I87+xhov7YhU=;
 b=aUp2ElUuMBrZtmptjzQwm7uQihzVv/Z8S/wWInTSbMxgZ5BCtNeZm0atJ/kPYC2O6d
 PMyE5XXJK3Dancc8GCODtOBmMGCZDmjF8vkHQAE+UVXuIGuH2Qhd93hfZxdzfM+RwX6x
 cLAUkkwJ/oLXCbpktoMyEQlKiSIhbpnWRS6e6LJzbgF/fqKh642/gg8S3jhjsy4YR5IP
 +Yj5TnC6TTNHirDOkfmGUya/ZZHSvfxrFVEQbdi+eywuo5/pptAzCVSFH4xdzoR26Djr
 92u3oKngGrji1IBTQAD1yQDv9NSwYprcQ+FhB9QqHDDe9vjsVjx1om2TUQgPHIaX3nYu
 ZX6A==
X-Gm-Message-State: AOJu0YwvyCFVlWlFHAAtIkB3T16taNHYYIiWZFF4TsP/IcJix89x+KZv
 yLm+trJY5e13RfL5EgFk0isz1AT4oRrkHA9ai5kFP3BQ7khFjS2q/oZMB/g72D+fccf6wEyuWfC
 MgcX7NY2H+nQQqnv+QqWFpjkyQbd/X383sBN3
X-Gm-Gg: ASbGncvl5V0S59ye3QZwDc6ptcICa4Lp9kTKXKN3S7OjTlsRZjVXAcL3rKOwOgD9Dia
 mwp+5zQs42PPUHI8VQgdjZ7+/VfcuukTx8dDxJh+NEuzPYX4lx8zK5dI2aVQmVI/WIMB++VdApq
 O5P1FoLcmN/waUqGhN7pcTjC6GrHTztxP/Bg==
X-Google-Smtp-Source: AGHT+IGmcv2x9jit32A/oDyW6WD6Nx6RaMwDTg3HvI+wZGK7gUn25tEQhPSQwzvFH+d2U30ZqEYexzGB2b5l3si85qQ=
X-Received: by 2002:a17:907:d8d:b0:ac7:391b:e688 with SMTP id
 a640c23a62f3a-ad17afcf870mr346001866b.58.1746197569074; Fri, 02 May 2025
 07:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
In-Reply-To: <20250502140649.GQ1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 08:52:37 -0600
X-Gm-Features: ATxdqUFWBLt4NHYf6qvg_qx1NKLVJCi_3T0x7hIq8dEnNyiulyVIqYkv9fTRJbQ
Message-ID: <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

Hi Tom,

On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > > This file reads from the environment but does not include the correct
> > > > > > header. Update it.
> > > > > >
> > > > > > Drop the unnecessary config.h while we are here.
> > > > >
> > > > > Are you sure about that? It was explicitly added in commit
> > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > > > includes") probably because of CFG_SYS_... usage.
> > > >
> > > > Well I assumed it wouldn't build if it had it, but perhaps that is
> > > > incorrect? I understood that CFG_ things had to be values and you
> > > > couldn't #idef them?
> > >
> > > The cases where in that series I added config.h were for good reason,
> > > either failure to build or tricky size change reasons. All were
> > > intentional. An audit-and-remove of config.h would be it's own series as
> > > yes, there's perhaps not the need now as whatever complex chain was
> > > unwound.
> >
> > Oh dear, OK. I'll respin the series.
> >
> > Hmm but I see you have sent a series that does some similar tweak[1].
> > What was the goal there?
>
> I fixed your problem. Please don't bother re-spinning this series, it's
> not clear what problems it's solving correctly.

OK thanks. The problem was trying to include net.h in include/efi.h:

https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.3930701-1-sjg@chromium.org/

So long as that works, we're fine. Having said that, even if it were a
problem, we could always refactor things to put the Ethernet decls in
a separate header.

Regards,
Simon
