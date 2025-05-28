Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F1C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC365832DA;
	Wed, 28 May 2025 16:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EyG5CXqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E0D83323; Wed, 28 May 2025 16:33:04 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D0E832AF
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad52dfe06ceso562606066b.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748442781; x=1749047581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1dpQTtpYObNlT2xSfY0tlhypjOn7JLGOlrtiwIJSD3E=;
 b=EyG5CXqiYMnpMLSzB4G9B84uK/BpAUw72795YRNGXHiuhG+SoSNK0Aj4hpS0pfCtrk
 ev+MDlsMVMPSWpIr1g30leMkqM76SXrvn/NMxb0HnvjLkyoxXp6l1g5/9FcZEhSKADai
 fIHpDLoYqHPBs1rhuSg8pCI7atkMV7fAKuKow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442781; x=1749047581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dpQTtpYObNlT2xSfY0tlhypjOn7JLGOlrtiwIJSD3E=;
 b=cX6AcwPp2waefzXqIDe1WmShbwZ8j+oL5xDaqPLpM/61xBugzWywqGPcXn/pPO/ry4
 I4eBesMuwEW+gt5EGULMc84rhn2nkHbC1fjJKx0IYnUJl4GsEyUu34zYYIZL4g4Mq2T3
 LVMinxewUMYg8mkC+i9fqXyhi7yyRxb/C7CgjFWlBWcflvscjRMjoVRB0ZxcgG3X5sgl
 e/OrRWWVetIDk4hQpKQDn+d1XnwYdmcx7h1DZCN+By8VabeyqA4E4PyMWDEh22BG5JuH
 MH86LqNoeAIxSaQ7fAjuxERUJDu7RxbFnHbJr3fiFDCrSRdfn5vDBenkvy4oKkbvKyZe
 tXng==
X-Gm-Message-State: AOJu0YwT1yW7oKToAfzdGU33oG65ebgI3W6moci9nRcgQKY5T2puRm4l
 9X9bpHf6DJyKwW2gwsb0ClEFznyzGiP8tYJ0VsCDJVRtB1P54HKvZBJyXV26pol2MWaxEoMVmBb
 NPqvj0Yyhv9kPJDv1GNVL9yWEi34io9ZBptovKRwi
X-Gm-Gg: ASbGncv0ItY5Bplpxz7UxQJakV+h0VLMC9Xy/bXoBQPCRrdxVSOtBgKHhgkdAHgRVQk
 31tFli1uGII9XZmvLuup8liRfeCu8PqO8C412IMJLLxP2YhnPJPuIkpGk+607BLiSYhYr35p0R9
 k33Sz04tXwgKfZR0DDLTmczg26IZgW438=
X-Google-Smtp-Source: AGHT+IHm17kvOz4ZFmKyyOVVm0YqIhNkVu57Lxk0LWb5xTJzxMRPlfzkvQ+jkqmqfrPaVQBRZx2B7d6/WMWWGeDd8dY=
X-Received: by 2002:a17:906:c153:b0:ad5:55db:e40d with SMTP id
 a640c23a62f3a-ad85b12060fmr1431319766b.34.1748442781441; Wed, 28 May 2025
 07:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250527124038.3633270-1-sjg@chromium.org>
 <20250527133249.GH100073@bill-the-cat>
In-Reply-To: <20250527133249.GH100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:32:48 +0100
X-Gm-Features: AX0GCFtZxo6SH829mcAsng9HxUp2jHjcrzmsnK6P9tiwrTXtmBT2SepDdfSDM4I
Message-ID: <CAFLszTjjoxc+THgdrWEam2XQKNPp5zeYXF2o2u=MyibNOYT6oA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootm: Shorten BOOTM_STATE_
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Huan Wang <alison.wang@nxp.com>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Thomas Chou <thomas@wytron.com.tw>, 
 uboot-snps-arc@synopsys.com
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

On Tue, 27 May 2025 at 14:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 27, 2025 at 06:40:34AM -0600, Simon Glass wrote:
>
> > This is quite long at present. Rename it so that fixes better with the
> > bootstd naming.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> First of all, sigh, this doesn't apply to mainline. After the last few
> days, that starts to feel like bad faith on your part. Second, I feel
> like this reduces code clarity. I'm not rejecting the concept, but
> shorten + document doesn't feel as useful as "document". Finally, what
> "bootstd naming" does this better fit with?

Firstly, the conflicts are trivial to resolve, if you would like to
take this patch, since the conflicting code is not in your tree. This
relates to the booti and bootz features, since you wanted it done a
different way, reverting an entire series ("Precursor series for
supporting read_all() in extlinux / PXE") rather than accept a bugfix.
I'm happy to send a PR once I get to the point where you are happy
with my bootz/booti fixes, but I do want to work on that
incrementally.

The bootstd naming just means that flags start with a BOOTxx prefix. I
am trying to be consistent with this, as is done in other boot*.h
header files. This variable relates to bootm, so I'd like it to have a
BOOTM prefix.

Regards,
Simon
