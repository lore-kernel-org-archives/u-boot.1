Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE4EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18EF805C8;
	Fri, 28 Mar 2025 15:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UPexEQn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA308070C; Fri, 28 Mar 2025 15:28:18 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F7E80107
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso3605216a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743172093; x=1743776893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsaBxRYmQfceVnt7OPpDNsB64os8vZURbIT4nQLlcEU=;
 b=UPexEQn16jWdsmOEqs+b4kGF+uqgzz1xjkUxbZRkgFPiHLktAI25fHj2IsR51camfE
 b+z5oJK00tyv3mxvY/ygXvY32xOxMs6MldEXMWeWe+wtIoWSIANFfb8Q8j0Q0xHr1FgV
 3PRseQmnPS6E+xVbLsEbO0VQzTZwRubdhw7IaDq37WD/I4CvoBfmztCxAz3DZfO+m6pf
 zXn71ekmQtAEHVcgTcrZX7PnDGgLWbKASDST6m8Xctf96ogVFjzkh4Xp7n8Y8To6Bpae
 PULVg4hWCMaDv9DMfv2MPc5zhtelkLPRKO15rVL/zYf/7M3x/aH0YMes92bb6XqsY/aX
 L7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743172093; x=1743776893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsaBxRYmQfceVnt7OPpDNsB64os8vZURbIT4nQLlcEU=;
 b=niFgzrZRZ2htO4OFgfxCjwTm0lsuO9vcCacJGCDXjkywl9G6vLD8JcISl29Tctj9OO
 lR328rCAfmMzL4QxAp1JdPAXEYOCMfEwclKFwIDqdSokVv45oHXIQ7JpnAm/Qcq97wMf
 RxVo0FUFlhBHh6W26UV1msN9TNDDYJ+VcVIHKbxmyhoSwoRtA0KhOhYNUHjfzfdfTqFJ
 gqoxTpfkh+S7YVdIPsykhnsW4w35HhuQFcGDBvXfqGgJODgvOIJVYs2UbacVum25pXHt
 UScrEnlDvoqSB9nO4FiyF3yCkcLIJaiv/bk3nbLktzM45321BKDkj8DQLiqjXAP6DDSu
 xYpA==
X-Gm-Message-State: AOJu0Yx7ZpM/pStOAw98P+NA7dj0aCdNvH3mCQG8HAsTni7JA8sWO4VY
 aTqbtqL64bV4ApcIgjaMOyC5GCppkJcFJisng9HKBqZQ3PPWg2J/N/kYM/+Ob2f85nlex6xb9LX
 ZTRtz45/Z0AITMOjxZjWlkGHyJxLF4UnU9oeoVg==
X-Gm-Gg: ASbGncsmbvPmdOxoMRA64ViWaqQSuWyL1YDzfPHC48KXoLZtilEO+9y8OKLp4culLHh
 gOCZUlsWENeO+AALblCPFmnISG6Nzxew08wA3OXF0zMVj3OnN+QJDiSVN35BN6kcArrlWnZ995h
 830C8jJ8rN+pPXEJb+3Sw1Ut7t/z/w
X-Google-Smtp-Source: AGHT+IH+RFaTiVxn536p5kQhpmrZHcpIGMsBB8/s96QInmXUXjLVKbngnAGbZFc1uY3+R2BKFtBHClF6rVqzi8lze0Y=
X-Received: by 2002:a17:90b:4d05:b0:301:98fc:9b2f with SMTP id
 98e67ed59e1d1-303a7c54355mr9781979a91.1.1743172092823; Fri, 28 Mar 2025
 07:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <714a1d3d-7578-4fed-bc8a-c93eff3809c6@linaro.org>
 <8857623f-e6d6-4da4-b9e1-f56b352279f9@linaro.org>
In-Reply-To: <8857623f-e6d6-4da4-b9e1-f56b352279f9@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 10:28:00 -0400
X-Gm-Features: AQ5f1JpXF_9PjxTlZVy3c1pIbIppbyzQIBRa34QQFn7hpv4-Mm6-XYr1PcvHHac
Message-ID: <CAEfUkU+o7VNhszShhojpa0-vzcre1eHxt_PYkx_Ti_T1d-FRWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Caleb,

On Fri, 28 Mar 2025 at 08:27, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 3/28/25 11:44, Caleb Connolly wrote:
> > Hi Raymond,
> >
> > On 3/28/25 00:13, Raymond Mao wrote:
> >> When a bloblist is valid and contains fdt, it explicitly means
> >> a previous boot stage is passing transfer list compliant with
> >> Firmware Handoff specification, thus the fdt from bloblist should
> >> not be overridden with the ones from board or env variables.
>
> Actually, I'm a little confused here. Can you point to the documentation
> that says an FDT from a bloblist should always take priority?
>
> I can see why this makes sense to lock down, but clarification would be
> good regardless.
>

All the adaptations on bloblist are in order to make it compliant with
the Firmware Handoff spec [1].
In the spec, all data being handed over between boot stages should be
within a transfer list (aka. bloblist in U-Boot).
So the logic is clear to me, when the bloblist contains a valid fdt,
that explicitly means the previous boot stages are passing arguments
following the Firmware Handoff spec, and U-Boot should follow the same
way to pass them to the next stage - kernel.

[1]: https://github.com/FirmwareHandoff/firmware_handoff

Regards,
Raymond

> Kind regards,
> >>
> >> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> >> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >
> > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   lib/fdtdec.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> >> index f09c9926a7a..c38738b48c7 100644
> >> --- a/lib/fdtdec.c
> >> +++ b/lib/fdtdec.c
> >> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
> >>                   gd->fdt_src = FDTSRC_BLOBLIST;
> >>                   log_debug("Devicetree is in bloblist at %p\n",
> >>                         gd->fdt_blob);
> >> -                ret = 0;
> >> +                goto setup_fdt;
> >>               } else {
> >>                   log_debug("No FDT found in bloblist\n");
> >>                   ret = -ENOENT;
> >> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
> >>           }
> >>       }
> >> +setup_fdt:
> >>       if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
> >>           setup_multi_dtb_fit();
> >
>
> --
> Caleb (they/them)
>
