Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3174E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 08:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFF180085;
	Tue, 14 Jan 2025 09:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bw7cN2jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B8780657; Tue, 14 Jan 2025 09:40:08 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD468007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 09:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e4a6b978283so10134968276.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736844004; x=1737448804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cyMwwP/12lylIXqMeV+h5PrhC+hps+QVA+yssPDUjyI=;
 b=bw7cN2jJszqu+sGsMB0M2QLuhGlmveugk8+B8cQvJsBKmEX058gZ50vjsCf0+xmX98
 rGYpsX5iZolJui1uGFE9XPq40ZbpPbj6tQ1y7eLOY82gATqWMbnDwhbdzI6LZIkW/Lci
 HEsVn6irfpsYgsVKGnjkXiVyMXRW1TOXHbpXgXrtIyl0kLslz7UWy3lnhr8bPM14z+mI
 jBfMscMDol+Q2DXQTTnfk3q0NAES5256R927RV0jsFbQe5gPNgI+sIQyQfQUCHKwt/f9
 Edi+u4Xv5Kw3oIzwoHp94iQWqGToiKEmhQfLLSCPVqyR+fo+J5tuQEDJTbxIzzYXCk0h
 EyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736844004; x=1737448804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cyMwwP/12lylIXqMeV+h5PrhC+hps+QVA+yssPDUjyI=;
 b=bCJIEejE1QolQ/vzwMqmPiE3Z4mj9fiU8cVjxnbwSPjOSswI0fm5nf+KFsSy1tKSQh
 imrSl8IZ/Gg8MMbzUL18VpXDnP+BjsY5+GbeFijpfZvUw2MVIqNZcNVCootHSoI0yYCa
 mRKpv5ld+dnHDMVnrRQyyxs6SJyoF2HdH+7X4Em8eFKWe8raIl8dbxZK/ICgjqQ6VYwC
 dfNHY44zBiaSLO28Q8cIP8oPxyVccdYBJnarHCtxLOT+Dx4gz9EWj6p4yWx/s28F6lF+
 N4LpuMYuYWuj9iLcem625Dv9f1vwtNPPjlmFbdA4skIDKW1TbnJ/LTSyHx6j+Tpbt37B
 ZsCg==
X-Gm-Message-State: AOJu0YyFyGgue6nHM3IqtK7W4SnEtJfV8ytgDrnL26LXJCbEgg5xvUYc
 odLNgDeyDEof63nmCpLu/kKP9OETqwjFdRiiTFWJ+zy1s4E8WueiRelLzjRBRWazYGmtm/tQuzX
 NvBaMXsJC99WFYmPf+KhjaV7oqcEBvmhxXLA0kDQMnGOhQP4i5HY=
X-Gm-Gg: ASbGncut4/HYcojOcObuY9XDDBucuegnjKA3KXn7dbdWCqId2n/C9SBZR1iI9omAyUx
 CXq/J4Rxd0N7/URlY0UchGikpVoeD1tK58pmHWA==
X-Google-Smtp-Source: AGHT+IHWLpbTe/wJjRciilpbKIqWRd00Zx/z2lE+1vB2HvVFdkksYFTQIXkZi8UfvUBqWcp8osqKXZNj32zYSziRfMM=
X-Received: by 2002:a05:690c:b84:b0:6ee:8515:6730 with SMTP id
 00721157ae682-6f54964144dmr131325957b3.17.1736844004070; Tue, 14 Jan 2025
 00:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
In-Reply-To: <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 14 Jan 2025 10:39:28 +0200
X-Gm-Features: AbW1kvYbyhzssGRFa7bxs1bHvu5B0j-ytJisDlmVOqIi3QBkwmojpalaGn5yVik
Message-ID: <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi again Ilias,
>
> On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > >
> > > Apologies for the formatting, replying on mobile.
> > >
> > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> Linaro has decided to write their own version of bloblist from scratch,
> > >> so there is no point in having a non-GPL license on this file. Change
> > >> it, to better fit with the U-Boot project.
> > >
> > >
> > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > >
> > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> >
> > The U-Boot series was [1], for reference. This was mostly about using
> > different tags and shrinking the headers. My clear understanding was
> > that we were going to try to have a single codebase, which is why I
> > changed the license.
> >
> > So, since you have a different view of events, why did Linaro write it
> > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > author just unaware of the original intention?

I am not sure I am following 'from scratch'. Firmware handoff is a doc
describing a list. Raymond implemented it in U-Boot and TF-A.
The right way to do this is to move the firmware handoff code to a
library that can be used across projects.

> It isn't relevant for
> > the commit message, but if you can find out I would be interested.
>
> Just following up on this as I'm not sure of the status of this patch.
> Can you perhaps write your own commit message with your version of
> what Linaro has done?

"The non-GPL license was inadvertently added, remove it". Raymond
wrote that code so I don't think he minds removing the extra license.

/Ilias

>
>
> >
> > [..]
> >
> > Regards,
> > Simon
> >
> > > [0] https://github.com/FirmwareHandoff/firmware_handoff
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=387200&state=*
