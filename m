Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61144C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB5F80821;
	Sun,  9 Feb 2025 15:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHhKFTho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A2480944; Sun,  9 Feb 2025 15:29:49 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F4180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa21145217so5124808a91.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111385; x=1739716185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/qsWqBZBBCCyXwhdujQ81uWXFemxOEY+TnQjhDgbmf0=;
 b=EHhKFThoegO3M3+Bbys8SLTBbsMopXo9l0PFdBNIqiqzhH+FVLv6iYxA9/thMRq/lS
 Zx5m7AhA+fAALghO8H+Z2b7JZZz6tBYT4IrhpT2Ly9yzNZzcS5ZGCDB77FabvfG2Pj1x
 /AUQljdA0oWAgzjKZGMvWxqVfBXsFVBgRUvyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111385; x=1739716185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qsWqBZBBCCyXwhdujQ81uWXFemxOEY+TnQjhDgbmf0=;
 b=mhc6uC/lKeZJjl9l4k2McqgOzZJDnstQkCIS+tkzjCh4rvtC7IbndNGCgKRNkQ8qvF
 /8W/WL3C3YYEGT1ljYCvzdqKTMFYhy6FYtPcc7NsxshAFiPRCt62EV6cIC2nDB9qv1Oi
 f2BPvt0ECrJs3lqIACSUUQtpPRLspKasH90i3LJM9MuLT8ZrfFTgPeoe4897zRH/tv1m
 O7mrtXwQDY/e2nd3/+0y7ZIZQm+uiYnt4Fmmzpi/hJxKAPmhBkvNAfjQooOe5N647BdX
 Y9W9CLlxus9gVfsL7BnfI+dSz+89PcypLLKi9udlnKarSVjTlzCyw+SMehdNiyyKnFAs
 2IQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFl9diggEvfy1I9HkpyBw+EOXsFuCDNB4ly4zeutlBRW5TuSKoaBVwnqbTAj/B0Gl4wxDaDwA=@lists.denx.de
X-Gm-Message-State: AOJu0Yznv8VOEqQ30hsfErB9G2IDkAj3WY9w5IyF6oHhjwJin5wJtWWj
 fA/WXkqIHU7RNVVJWeTTzeJfIZ1fX5xrIxZ+FAwlrwWfYPFDDUEg6rvXNnQkUNg7JQ5CeoRk1Jx
 629umG8JdLbUzePSGQaAstI0u73SA1feogiQb
X-Gm-Gg: ASbGncusVG8/C/8XY71MznMo/hjsyugKGD9UE6KFNiBl3p/YCTxSCyG9/ODi4R9Z/1n
 HViR5my79yLMurP8U+G4ti0qT6eSb7XlU3DVLv+E/SE/o5Gb5sbJx7aU/O3u1Sy7KUCalSRjEIA
 ==
X-Google-Smtp-Source: AGHT+IGv8+ch5sjc+/6GxKPnjM9U0T7CaoK8Xj3VdIUlcClSiubNUhIf7u+ytB5/VeAh0Paa7FQVFeOJfX+vDEaLNms=
X-Received: by 2002:a17:90b:1806:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2fa2427064fmr14324146a91.21.1739111385381; Sun, 09 Feb 2025
 06:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
 <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
 <20250125225510.GJ60249@bill-the-cat>
 <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
 <7bc236dc-4cdb-4b43-a752-f9d6dcfa9498@amd.com>
In-Reply-To: <7bc236dc-4cdb-4b43-a752-f9d6dcfa9498@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:29:23 -0700
X-Gm-Features: AWEUYZlmfwsN-nzLvGTOpUbjCCsGBq4I4PjPA0r0kfprC7spBLHBbhLRIV-Dx9o
Message-ID: <CAFLszTgPa4aT_J9h9pqeTtLCVn4x2JvLWRcWRD8NaN3uoSAtyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
To: Love Kumar <love.kumar@amd.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huang Jianan <jnhuang95@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
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

Hi Love,

On Sun, 2 Feb 2025 at 23:05, Love Kumar <love.kumar@amd.com> wrote:
>
> Hi Simon,
>
> On 26/01/25 4:28 am, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> >>> Hi Tom,
> >>>
> >>> On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> >>>>
> >>>>> This fixture name is quite long and results in lots of verbose code.
> >>>>> We know this is U-Boot so the 'u_boot_' part is not necessary.
> >>>>>
> >>>>> But it is also a bit of a misnomer, since it provides access to all the
> >>>>> information available to tests. It is not just the console.
> >>>>>
> >>>>> It would be too confusing to use con as it would be confused with
> >>>>> config and it is probably too short.
> >>>>>
> >>>>> So shorten it to 'ubpy'.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>> [snip]
> >>>>>   102 files changed, 2591 insertions(+), 2591 deletions(-)
> >>>>
> >>>> First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> >>>> it's how we interact with the stdin/stdout of the running U-Boot. And
> >>>> indeed it provides more than that. But ubpy is too abstract and unclear,
> >>>> and looking at the diffstat, I don't know that big global rename is
> >>>> justified to save text space.
> >>>
> >>> I actually get quite confused hunting around in the fixtures so I
> >>> suspect others do too. I would like to settle on some better names.
> >>>
> >>> Yes, I don't like ubpy much, either. Your favourite AI suggests
> >>> 'fixture' or 'test_env', both I which I prefer. The only challenge is
> >>> that 'env' has various other meanings in U-Boot.
> >>
> >> Yes, until someone has a better suggestion than "ubpy", we should leave
> >> things alone. "fixture" has its own meaning within pytest and so that
> >> would also be confusing.
> >
> > Yes, ideas welcome. Arguably it is confusing that this one fixture
> > provides a gateway to all the others.
>
> I have a couple of names to suggest:
> 1) "ubintf"/"ub_interface" - As it interacts with U-Boot during testing
> and acts as the primary interface.
> 2) "ubman"/"ub_manager" - As it manages multiple things in tests, not
> only limited to console.

Thanks for the ideas. Both of those seem good to me. I'll give it a
try with the second one since it is easier to say.

Regards,
Simon
