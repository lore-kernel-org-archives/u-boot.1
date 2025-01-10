Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88581E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 14:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB02805E9;
	Fri, 10 Jan 2025 15:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/QpFyw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E6380602; Fri, 10 Jan 2025 15:54:35 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92E1801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 15:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so6170065a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736520872; x=1737125672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IreOfaL/wD22Y18lZyF7Wo6SaLX7pyOqaP6EZJ2hqqA=;
 b=W/QpFyw06TQhYqqpAs7+cmCp7fYgdO5CUrP8kqme3vm4VWU0JQpNK5b2tescYkWYfQ
 MyUir9I81sUZUedRA3d0dbI6yzMFJMdulrCUAwbC3Xd6byFhLgutB1h3Ta68MVgWZ0bM
 EHnYxu3utTGhAEVepD1BtTdm/E5l14EU+H60g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736520872; x=1737125672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IreOfaL/wD22Y18lZyF7Wo6SaLX7pyOqaP6EZJ2hqqA=;
 b=Y6e3rOcKfHnrH4JBD9eP2Fb40WOBfu8vJXsnX9bY3SlJCT5PEVmL+DXwg+6iD1Yi75
 3edsbxbkLSSlZeAb30tFvRCdVrO664fAMRBa+X7qf4Fmzh0cxc7IxQF/wSfpmn7+O+Lg
 cSRvBoM7LWgkwbU2dnxwB1slmBm6+4soSR2Bd8rFj409plwXAE2uesVoFYwDJH9w5X2K
 Ni4CVyte3t37Xq+vwSzu2ghESBzmOTDfeHri3629t6wDmLd/2pSJmh5LnvvH3g83avfk
 htNPCmgrQjsdLsyymakVg0iP5uItHmCh7nt6eNaFh8C3Vzav1QC491MRervnX/dosCYy
 pkjQ==
X-Gm-Message-State: AOJu0YyzYhJr6gIbLFRSMSEUEiZCrUtalN+T4T7dDsSplFboKgUp7UCf
 t4cEM0XQfohwt+7VmKpaVpFuXqiZRXrcU1qHW6rsMbzhqcN7HAtiPuUtOcj2bAwIE2EXArf0ou2
 nx3NoV5g3/se7zAz+BR6teYjaKHfJXKD9Fxdu
X-Gm-Gg: ASbGncv3eeOfcnLnOw0vm2cpSukuBT3Xbz+xXBu4NgS8lkztJ9PYplj8Oc9enhsSJTV
 4pM6ssuI3HNOTdFsDcUTsQR6iRpE1WWQ5iNHW9mU=
X-Google-Smtp-Source: AGHT+IGQhkmxqJf2sxiBookeb/IIbhV+R3ZaUdntc6O7B1wF0Pe66VzjAEIUM81Jpi9SeOix3S1GiTSExK+utpH+KVU=
X-Received: by 2002:a17:906:f5aa:b0:aa6:945c:4531 with SMTP id
 a640c23a62f3a-ab2c3c5c93dmr740226266b.7.1736520872415; Fri, 10 Jan 2025
 06:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
In-Reply-To: <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 07:54:19 -0700
X-Gm-Features: AbW1kvYXWqvBF07Ut2avHBXJj-0Op4CTYly82Wu0flPRvZ9xsslRt76vgrIw9eU
Message-ID: <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi again Ilias,

On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> >
> > Apologies for the formatting, replying on mobile.
> >
> > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Linaro has decided to write their own version of bloblist from scratch,
> >> so there is no point in having a non-GPL license on this file. Change
> >> it, to better fit with the U-Boot project.
> >
> >
> > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> >
> > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
>
> The U-Boot series was [1], for reference. This was mostly about using
> different tags and shrinking the headers. My clear understanding was
> that we were going to try to have a single codebase, which is why I
> changed the license.
>
> So, since you have a different view of events, why did Linaro write it
> from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> author just unaware of the original intention? It isn't relevant for
> the commit message, but if you can find out I would be interested.

Just following up on this as I'm not sure of the status of this patch.
Can you perhaps write your own commit message with your version of
what Linaro has done?


>
> [..]
>
> Regards,
> Simon
>
> > [0] https://github.com/FirmwareHandoff/firmware_handoff
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=387200&state=*
