Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED64CC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506F582B07;
	Fri, 11 Jul 2025 19:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="woVnTuOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F047382C84; Fri, 11 Jul 2025 19:36:27 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8B08277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-312e747d2d8so3009213a91.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752255384; x=1752860184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jSE5pWAa9saCQzxdHC4D3ZXSx/70b+KC00kh3ri0Wz4=;
 b=woVnTuOiVyacURmbhRhDdmLE2KqdyF21uPVlSAkkmnwtrmsmFKoOPaBaFtqoXzyuWs
 6RXkUD+1pwA8rf9nti/kIFg9FWCXBWhCscNdfbHS6zalVItRSmptRMqj973fg3k9OwuQ
 MRzfYtFIXCxYb+4EUAzu/Fj2MxyYUldHlnlbtowl5OwdVQaEEHbgXUD6Et7+0cbzjBl3
 IxeZzmfrJyPgKIhCOX3omzDtryAcSzt4qtmeOFgvkTWlThx3U4Nx0YcVi+SN1SSO46OJ
 1iQ0pZqqvq2bhMrpVJJ4n7WJSNbuIEyl2WGHRVdYNLzUl/icG8f8ubQn0cV2JtkNJMQt
 UDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752255384; x=1752860184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSE5pWAa9saCQzxdHC4D3ZXSx/70b+KC00kh3ri0Wz4=;
 b=dyfrdFa8msSDZTYrIPRB4gzSWeYHe8hHb0P3dfuCR46jzdS5l8htYZwjsG9AOTl/V+
 jg8Nl1d4SPPIAk7BvG3ImGbq9G62hn95/bCZ8QAVvOwwi+HeUbN9w1URiGjJ+6E7w9+d
 gV8UW8RkxuR4CH8SCyyy5/UClh4NIQhCgUwcCTixaEqUIlV8v3OTAODkYsPHQveXGtrH
 zX5cTjm3AdbGZHJC3hVYx0n8nEaDgGLQXe+x2+mB/MegZ8i3xBEOpN2y5zhUavmMU9Nl
 I1kw4RXgh+azI4oWkQHJxfSFNlRiVdBrdH46U0jbDcvchQF88HdeUionDa+ETNOrh6sS
 skVQ==
X-Gm-Message-State: AOJu0YxHpfkgXYYvSbkTtn6FwZE87eoFlqlIyEoBfLyIWi/1gkj3vv3E
 xiXVm9DbZSFpCAyGuj6Q7T0kURbvSmwdTYjsAKwflAXBayIce47La8Jxd7nV6Q1PPunlfMNslBA
 Xj6fTC0wc+QUCX3ALwQFy4gu/9o3ZNO8vEa/RP5zsMw==
X-Gm-Gg: ASbGnctgW1pBZB2UQ4pXZPlmjEIEC1sWEQSBav+Rj0JQ5SUSA0pn9z2j8CWaV8l8wjX
 8vCIWK5mC4giDyYOOW6TMQfdvF67dTs+oWQk9NEehvECvSejdnBOPevE6OBrIl81rXgd4Q3CAwj
 W91Kgj0NXbxbcB2dFKt4va5mlGzE/HSccqWp7N3CWi73h6kc/oeKsmuNQI0VQUaCGojttmYuXHV
 3SkeyyJ
X-Google-Smtp-Source: AGHT+IEjpOtSRQaa2sOKv+Qh9fVqLadlNOhl5Rp6QF50IOoIi93+aFnInpxV+2Qp9d5KEgt50JyWM1JWz83i3qu+mFg=
X-Received: by 2002:a17:90b:568f:b0:313:d7ec:b7b7 with SMTP id
 98e67ed59e1d1-31c3d0c25b6mr13466462a91.13.1752255383639; Fri, 11 Jul 2025
 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
 <20250704134208.2895595-7-raymond.mao@linaro.org>
 <20250711154530.GH6424@bill-the-cat>
In-Reply-To: <20250711154530.GH6424@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 11 Jul 2025 13:36:12 -0400
X-Gm-Features: Ac12FXwt1WH8MAcqzAfuCRfPA7B_FxJwU6bAVXp__m9TZJxNJD8Myvq70k0KH_8
Message-ID: <CAEfUkUJjP6LRmSy_wjJvDWFmLsQaQk3ccO=yNG83_Q2N4fQL0w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] fdtdec: apply DT overlays from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, 11 Jul 2025 at 11:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jul 04, 2025 at 06:42:05AM -0700, Raymond Mao wrote:
>
> > During FDT setup, apply all existing DT overlays from the bloblist
> > to the base FDT if bloblist is being used for handoff from previous
> > boot stage.
> > According to the spec update for DT overlay handoff[1], an overlay
> > must have the same top-level compatible string as its target base
> > DT has.
> > Before applying the DTO, it checks whether sufficient space is
> > reserved in the base FDT region. A margin (0x400) is used during
> > estimating the space size required by the merged DT.
> > A resizing happens if the reserved space is insufficient.
> > After all overlays are applied, it resizes to the actual size of the
> > merged DT.
> > Note that the margin (0x400) is arbitrary from experience, it might
> > not cover all possible scenarios as complex overlays with many
> > properties might require extra spaces and lead to FDT_ERR_NOSPACE
> > error.
> >
> > [1] Add Transfer Entry for Devicetree Overlay
> > https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> [snip]
> > +     actual_size = fdt_totalsize(*blob);
> > +     /* Add margin for extra size growth after merging */
> > +     new_fdt_size = fdt_totalsize(live_fdt) + actual_size + 0x400;
>
> This is still a fixed value and still not the right way to handle it. I
> think now that we expose configuring the amount of extra space we have
> for the tree it should possibly even just fail out with an error message
> that points to SYS_FDT_PAD?
>
Shall we do it following the steps below?
1. Expand to "fdt_totalsize() + SYS_FDT_PAD" without conditions.
2. Apply each overlay and out if any errors are returned.
3. Shrink to fdt_totalsize().

In this case, the expansion is only once at the beginning. Is it good?

Regards,
Raymond


> --
> Tom
