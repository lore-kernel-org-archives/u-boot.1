Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF259C5AC80
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 16:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CE3760650;
	Sun,  9 Aug 2026 16:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7xcG-NnAbAA; Sun,  9 Aug 2026 16:33:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A21CB60603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786293213;
	bh=Q2BzNJZYx9+cGbBAZj2SJHspcW77FVKMCHVZNCPZwV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njc1Vei3d52vIxPvEGMu0h2P8FydqSa1kEnGbEzrfagqRnO1HsOSO/5kbIjU0hUwn
	 kIbCrJcYo5yUuhZVNqzjsaFE1HHisyjppokTgK+Y21KqOoTPlQW2ZHh9lFiepyfvzR
	 48wEEc8fN4rK2v2a3PNrLNl5mQHF3iFDQ/M7w3nnhH5oJr8mxhRHUx+L3d3KNliEyA
	 gGji8rESo2pN1gGdZKWRhTNvsEIQRI851okGbXaoT2qiLW5IwRfpMaJJQwXtGwR+6r
	 HbWLeRCZorn/RueLgDDxzbYGdXFjZsTpyAyUg3fSmiVZJ/qQkyCc3IFKFXxZjwtZ4Z
	 cXODxEWQq1BHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A21CB60603;
	Sun,  9 Aug 2026 16:33:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2BB8198
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8B7180CBA
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAgSM6_zGNgY for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 16:33:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BE00080CB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE00080CB1
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE00080CB1
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:33:30 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so943579a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 09:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786293208; cv=none;
 d=google.com; s=arc-20260327;
 b=TXxbl99JWJEAJh+x1BGJaroLNlWVY6XY8rZWjtR5Ka6uwYt6jFl5Kw5OtglWEncBU9
 0Z2GK8hVTc4CAPF87oqGwoJ04YkIcUkFQxeTL5lIG5MQWXe8mKZFjhHvMiNz5IzGhsXV
 1P0lZnbP8tHlJVofidiz976qUo4bcxFscJUc6ny5t09iFVSAmLPY76+/AVxy2pvrX45l
 YJhKui2kPUxPZZKRQpBHEQYRVNktyz8VClNjOehSvqce10KN7Ds0nIWs6pawUQVkvnbE
 28iPRLKsHLThyZB3sr4EOGY70CRCdoUDJmiGnv466qqiqjsZTp6/Z0FE38rwLo0+I9bD
 LFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q2BzNJZYx9+cGbBAZj2SJHspcW77FVKMCHVZNCPZwV4=;
 fh=ezOECVFWbQY6VA3LizSbnI3v/6LcVIn/6YmpjzAhGSg=;
 b=hWi9/XleMYoQ0te3Tg+WBKioiKlf3oPQK/Rz1jbDp6bIku3jPXl7lLC6FMDgA645kD
 WVyALBvYKJsV7PJwyzT6Tiib8krsBywlKsqWbAKsrbBlQF3afjxNbhm+gN+z+pdRVPnt
 mS9f2nQr7c9IYnjMzOoouykip6qQGZuZ3sDuVlnJMniLjp65CgmZdxwp1RqqTTBeBp8D
 nvhfhC0zxQHsPwAzb+iQIm+Aak2+ui54llDLSCjiM3ZiubqDLdT7YBtSc1zcCzPEgLTk
 QB16ntibdOuqcK4LkKmrPlqKVpEH4rOYekwXLnuXDiIN+hjr8/vLmh1CyA46PAve+ind
 P1dw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786293208; x=1786898008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q2BzNJZYx9+cGbBAZj2SJHspcW77FVKMCHVZNCPZwV4=;
 b=sI2J2MfQ9crMTKVUT/2cN0YCDuaKPHNGJxyN3hf51frUdzp5ezNU4c2KltvGrTVhWK
 dvPNn1uK7dU1o4k5lsW3OXmES9elxJRRNpgp208z00PtWL3saKzstOw1QjlNf9rW1JO4
 PbKmOWe5xiN9yQ+U7CSf6lsvA08vk/asTZH03iJUFyLknfPgA4w+St8JO8A+iTkgE3Sj
 DbRUdcFTQFsMwKJi9RPCcS1iX1q0vyrlbMTTzbsCWG24O7fg6OVHODyTOjQa1iMljBuW
 1E35wnLmBuisVOOV0gxEOL1qzf5v9cYIkMORcXB9uQ9DWpyOaMDDGrAa7umBcll5bfaZ
 9MxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoU+QGa1j/kE8FOaJr4d0b4OdfCEuTtE9dxqWyJ5eXtw+tpGGfVt/AFVsCOko2AcErxUHr7El4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy9R1mEeUjAdSTR9tzgJe6FtnfmX96NrIN+/1mW2w27ew0FO4xm
 HLOTvutShAUq/W4YmbOzVJGe1e5JD9NOhKXoKki49xvShQe8g/VBHRGZjXkCYmWDkqozI993BCt
 wvIuFcvVwRhSWhW3w8GleCQcG67abUiDnfQJaDNbHlvHMhFrrWmROUw==
X-Gm-Gg: AR+sD10hTbtIydhPbI+Zgtwpczvl45CWljcn2cN6FibBBrvHYV1vYaPJD2cMHB+bum4
 zQO6inrwfWj8SJt+RfGzeK1jIfRSk4xciCh+C+aKjyAq9dIj5m7pNiu9Nk4hOzGyc+lrhphVjFa
 4jpnsyBY+sG0R7ye4JVcBtuG9sj4C6ofiqBfnDv0aptLj2wnhUB1Zz+trNU1Ikez4t6ZnWTCOcJ
 Le44kTBZjCoAu67raA+DgT1C2nl/fGMJuFDDiUj5p/GhBL7FahLZugoNuVlL+cZqURJhHqdGPxA
 NtKQjZMJd/6rojo3iK9YOzK7HvTYvLEr+6cyo5ecXoM=
X-Received: by 2002:a05:6402:a0d1:b0:6a0:9b04:bf76 with SMTP id
 4fb4d7f45d1cf-6a14f267535mr15756222a12.17.1786293208599; Sun, 09 Aug 2026
 09:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
 <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
In-Reply-To: <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Aug 2026 10:33:16 -0600
X-Gm-Features: AUfX_myy-4_vhA05tyyek2xnskMsFcg_siY7zeH1aHevK6YHhFg-9KN_p-C5yCU
Message-ID: <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786293208; x=1786898008;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2BzNJZYx9+cGbBAZj2SJHspcW77FVKMCHVZNCPZwV4=;
 b=GcbRzwiDNkbdbWiYXNhPP6WmTrRvAekrYRruJc/dplnT3833grsA9eae4LwbrFvWIx
 zKjMSDftwntaaGM4Jldghn/ObElXNtMxV7MeQPjKzdER3z00gcsnrjrEPfQt6qnbOzkh
 b8HCzuIgoZivQTimU9u9HOEvy0vciKJ7ZIQqg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GcbRzwiD
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,

On Sat, 8 Aug 2026 at 19:14, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/8/26 8:17 PM, Simon Glass wrote:
>
> Hello Simon,
>
> > On Tue, 21 Jul 2026 at 13:48, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
> >> the compressed DTs in uncompress_blob() using gunzip(), which invokes
> >> malloc() internally. The early simple malloc is initialized in board_f
> >> initf_malloc() call, which sets up the early simple malloc limit and
> >> offset pointer in global data. Currently, the initf_malloc() is called
> >> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
> >> during the gzip decompression, because the early simple malloc is not
> >> initialized yet.
> >>
> >> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
> >> use malloc() during gzip decompression of the DTs.
> >>
> >> The impact of this change on boot time is negligible, because the
> >> initf_malloc() only assigns two fields in global data.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.u-boot-project.org
> >> ---
> >>   common/board_f.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I'm not keen on reordering this list...
> >
> > The offending call is inside uncompress_blob(), which already has a
> > non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
> > MULTI_DTB_FIT_USER_DEF_ADDR.
>
> It isn't the allocation of the decompress target that is the problem, it
> is the gunzip() call which internally calls malloc(), cf. commit message
> and lib/gunzip.c gzalloc() usage.
>
> > That is the pattern most boards using
> > compressed multi-DTB FIT already use, and it avoids early malloc
> > altogether. Could the BTT config not just switch to that and drop the
> > board-local initf_malloc() workaround at the same time?
>
> This is unrelated to BTT config.
>
> > Failing that, the per-board workaround in board/liebherr/btt/btt.c is
> > ugly but localised. If we really want a generic fix, I would rather
> > see uncompress_blob() call initf_malloc() itself when it needs the
> > heap, so the ordering constraint stays local to the code that needs
> > it. We would need to ensure that malloc() isn't then inited a second
> > time. We could always add a flag to gd->boardf, I suppose.
> >
> > The reordering also means that malloc cannot be traced - the idea with
> > trace is that it is enabled as early as possible. Finally (that I can
> > think of), it means that early malloc can never be configured by the
> > devicetree (although that is not something we have needed yet).
> [...]

Ah OK, I see. So in U-Boot proper, before relocation, you have a FIT
containing multiple gzip-compressed DTBs and you want to select the
correct one (presumably with a compatible string), then decompress and
use it.

Is it possible to do this in SPL instead?

If not, it looks like there are two allocations in gzip. One is just
its state (fixed size so we could pass it in or pass a pointer to a
local var). The other is its context buffer, which might be 64K or
more. Did you see my suggested workaround above (call initf_malloc()
itself)?

Regards,
Simon
