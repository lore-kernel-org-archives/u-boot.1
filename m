Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF60606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p1Wh+CsN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YKZLv8hH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA89F60AA9;
	Sat, 31 Oct 2026 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EaBNE-rHg_T5; Sat, 31 Oct 2026 08:47:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F27AF607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436473;
	b=SteIlSbv3+BnYRYXaPeCSRskhUhY1IOTPO/Encca0Xa2Wqpy65FSpUvi8udwtmMSTOoY
	 T2/oixhtRvuDixjtfBqvIZBG9hakbC5AoRBAE+cpsnSNptmP60CoNwfTmLjK4LaQMuYMW
	 uyNO3ibLFzdgynUUc4H/Efbk3RVk5FV4X6qMzZJfaWhXVsZIpeSUFoH6ynLFEbUCVdOJy
	 0q+0aSb6NtgypQanH+CuZkmLZSR4krg0pRxRj5193Slafk/glwySPgpNKLcabNXFcbHgW
	 Vyoy24CmJIHlDcSXmTyhcRd3LmU/NjLATBNlv/lFKfSbii4RzHghKgMTF3nrhJ11nQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
	b=DR1FFOk8ZJPKf5s2rZnE0Q56/tbGdT75y5cSILCSBOln3FDGu6wEO+Xs75l0pTH3NDPW
	 cRSeuHCGvrKFIUD/cm98evJsRArQpCueSkdHwN+dl3E96804EkKHZnBCjsmujP839+poi
	 NzCe6woQ6mnkgwN3nehRbcjJs4q4KGsYhQUM0K31cCEGbAsMPtr6t0WH4KjdTJku4M5OI
	 kaKXPt1cJk+zxh5ah/yRezb/kftjNhvEd2VlOucForYcQaBgYPJSNkoiQVFbsX65qMepM
	 9XjRG/9aT0MxR/KjOhp+hYbqSqnfmEyMdgUcbykLfdWTMuWAZgAQnfCMbZ60ENDvpgA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436473;
	bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p1Wh+CsNsPZ6SG0r/cM73R0kGHJteiqcJ8uoXNlTkp3jHjgrTS+DZIpT4/bmLbZDb
	 DvuvInBCk6ZJUJNW34hurKxD2PEUBOHgywjpOuGmmFhl3645Qsf/NH57xE5hGrGB13
	 OLsdNXuPX7VGG82pYmK8nqdrLhG46l6IfhnTv5VhQiD5Gzd5xr5ZjGcqt+Dsr8DE3A
	 /Vi+3a65yxvNoJfPOrSrvG0DGNH6JHy5S/o5KF0iMM5Xk3+FDgLbb3XLvEdYq3APFz
	 LEpgrc/77Q7B45KiXAMXrQT1Fc7nIN+OZwMb39aYoWcY1hpNgKFbdLHH7kktHPqIbK
	 3cd5a+HTeDQtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F27AF607A0;
	Sat, 31 Oct 2026 08:47:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 885AF156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DD8140B07
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCQjsfFx_wuF for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:47:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FDC840A8A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436470;
 b=RpEUgF9VnwpvaXMICJPmbayLdsGHbJ2Q4a9Ws2jycWvhjOFcqmckjA6OP6zWD60yP2qZ
 uEoqOohfUX0+tpMHLxCeX7j40CIwzkiquhKchiL6P+smdVdeZXu6Iu4wDhAdZDeg3p48L
 zUHNUccDXi07fUp54grz+ZJLh/w69wPyis+jBJepoo0LUmspdzhX1pt+B39gGl7+0uenz
 mxlQASaTFD82jFCzTYb7JlJUi5KcfQB65G193mztq0m/IlDaxLWfMkDbeHwNHdyxV7J4D
 AVr1T0wEoutUQ61IK/Vl3IBh0PS2aNZjuffBG5uUljNO0bXkWMlkUa6RNVWO4UTArbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
 b=jkA5ZL6EQrhCBJRafkVq7QY+PiPW9o2DnfeeB7TLBu/iHUhSRemGpUa+GIGOc0aMFlYl
 tjrFSxGIzU9swzkv/DJv/KsPgZXzajV+Cr5MsxDY1v8PX6PH451XgTJ7NyIh3E//olWl2
 9ictw+GI6psAxsRGGbybwga/ADiH7IC8MR8SKuEn+JOjAshA7Oe38Xy9mdE2/3v5fKdZ8
 ID4OcviVbiC1gPcFO2ZsmXhbFDPFHhS7B9J/I8T71Un+Cb4Xf2jKMksH9uRxh65IywDZW
 kW1iDaXsjNxnbMRPdX4bgR5fHsUf1o7gt6+Fj1G1Imrg3JIogMshWo1a7izKfFrVG8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YKZLv8hH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YKZLv8hH
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FDC840A8A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:49 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso834824a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436469; cv=none;
 d=google.com; s=arc-20260327;
 b=qVP1daedZLim8qIeBRZdjbrbDujoahjUZdLhNehkbFP4UUn40u5QpzO4VVKmzUbUgD
 3XP4a8TDgeHPRX1YGoycGEeHg8+C2XMcYifIvBrZ2alO6Kv6CkSVeV2PmlOcdqTX5+bK
 F7wJ0u8DMr4TZ4IksKFqyttjiwZl8eFJH4shW4eNk+c/KwlPmDIREu17DvUpE1w6lF5i
 JMVUa/aFQzVDVAlQs/xzJB8m2QJ1fv62BZlGTGf0+17G/UlLT72Ap8tV4AbuMaHcFNDf
 OWvPi3zIyg8z+7sYtylm07kQAk9+jUkI9V9sSOm1uE9XpoHuG3Ty1NEG73BjnWZi8TjW
 j4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
 fh=m9zt1YTb05G3mdtnJmzwZTgAKGUaisNKgV1irq0NDNI=;
 b=HuhXeTAokVfeeYg/GzJ6aWbTzfPKV4R9IlBv09Q0//motGwBmGRouB7Celn8BvEa/j
 fi/gtwHWCIiYA1AYju61Ksi3HoJIKxXNmA2ZbkX5f/F4OgpPIZb4fSAVmPJ74gGyhI//
 jWv9O7j7hOLBTzeKi3QvkWnPH/yIldC3jvqf+ti19Vzxyr/w8KrU+ozJUze4fogFyIH9
 eVScUuDxIOFottYgnNQOeBYvP84padgXdbgWsiTvCeN3cAU1kqaeK3woQOnWcPQSSHYO
 2GYrvMYnRGsF2K/APu+Om8R+jnFFERk+MHEeuF2BzDoKt65IKZ5l4c8JPJSVm4hjSUEg
 X9CQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436469; x=1794041269;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
 b=YKZLv8hHzF6WKstas+UtSstli03yV5tRlP/tiARQAEI0cu4G+3yb+Y35kj0ELF1ozo
 3g9m7TeFo5Ui71dI8RMWCl0LLcncHb8lNUbrdJWF3mkeB5orzDlk6hDda9VcLWRiGLuH
 oNUhh7bnkjo2NpIkD+39pp58WnIVcUIcSyTtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436469; x=1794041269;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdT9hjxNvQlFeFa9FTl9B6FO9XRVEud7OjNgOq/PhPc=;
 b=2l7C+N+u9H4nhKWkUELwyoGdSOyZFLlJpmMOzDiMgweimX/aMM/cCqE1WLi6HdqGHh
 8mpurlXF4zggLEJ/9hEKVXPXZldT4oM3kg8bkA7zVLCPSIT7TDZDS4pAPBpdrDc17jKL
 Rv9cJdbpNMzxFHWdaciCPSJkoBRKCSPLLpafnSXFn0dwuQnsPnsnc2n4uHgcCRtL1gQq
 Okz9H5C75iJdyAKWVw2C9Plpb/uoJ4SnvjaImA3rAPF8m5zDlulxEdPA3DsroocV63gZ
 3b+62ljIycY4nQ4HUWWpqV1rKXiscgUVQCpF6sGFU3Vn4AglvSNBDUTSZC2s6VflrQRz
 0FwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxjkeJsyTdDHjnyXsNcVB8jfzY02v1Hsd80am0Jk4fKfvjJxgFSEmxfB+75T2UjLuzhjJtgtw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJds1h/ztK24Kr+HBZuF1nfDdyBQXXakZ16P9k4xP0s8gLTLfq0
 uSGpSXS69bajIxtY1JsjnFDV1CiVSAG/9lDhzJ1C0CNWtP/UKLIPOvNJcp8Oyk8JBWCVdnpZ+bU
 2dRsk5bu42eYlbj3kYIoS2flaN/B9wzn7lSJ7YL7t
X-Gm-Gg: AYBFou02+RYZR2fFiOogllYk2iTBtRAZJxRVttmmgKCv/863JT8VjnXaBWrVQzkNbNJ
 d2h3/2FVmh8yzFYWYhV0AFzY3BlHbcL6kzoSA5ULneJnT2i/8xfkkUzKW08RV88sWD76T/c+iqE
 7F1hThGUfXWL9QCH6VPRVj6Sg7SuFtvAeeAlEzOGCsE8RI/AOGkwL04FZ1O0bPEmKyboCg2cE2W
 vPAUB2iOEA6Qii8ZB/Rb9sc8qsob5eWrqZNbJJLotC1Evu1n+/o3POU1adJmsGBVgsE04qs9XGt
 umpJxreEpyqYddl1S5kmiUjkrduxOW7pdC5rJ7h7i3MpwYtbNOJus0wOOK3iHQ9Rt1HqQZn/6sm
 W3RtZHaG+N0id6Rt7cHd3CgAyWVv2hRqS9cmMQMqvmMEeSeNUkkRXNM1q69c3wI8esPJZoSA=
X-Received: by 2002:a17:90b:2fcd:b0:3ac:a7ee:6780 with SMTP id
 98e67ed59e1d1-3ae8986606fmr4108475a91.66.1793436469114; Sat, 31 Oct 2026
 01:47:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:47:45 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:40:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027-blk-part-unbind-v1-1-e44d2b48ced0@kontron.de>
References: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
 <20261027-blk-part-unbind-v1-1-e44d2b48ced0@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:47:45 -0700
X-Gm-Features: AclHuK_6tZOLjtsIZuHmE-VIv_HLoVbn6u6DRjQpJD_rKTdzoNMWd8qx2vfJiZs
Message-ID: <CAFLszTiMidJ5usDh=F4Cdg_NTKSdAd8zrZUreGcdW=SCG0vEZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk: Unbind partition devices when removing a block
 device
To: frieder@fris.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-27T14:16:39+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> blk: Unbind partition devices when removing a block device
>
> blk_post_probe() binds a UCLASS_PARTITION child for each partition
> found on the device. Removing the block device removes these children,
> but does not unbind them. When the block device is probed again, a
> second set of partition devices is bound next to the first one.
>
> This happens for example when the probe of a block device fails in the
> EVT_DM_POST_PROBE event and is retried later. The EFI disk code then
> iterates over all children and tries to install a second EFI handle
> with the same device path for the stale partition device, which fails
> with EFI_ALREADY_STARTED:
>
>   Adding partition for mmc@42860000.blk:1 failed
>   switch to partitions #0, ERROR
>
> As every further probe adds another set of partition devices, the
> block device can't be used anymore until the next reset. This was seen
> on an i.MX93 board where a single failed read during the first probe
> of the SD card made it unusable for the rest of the boot.
>
> Unbind the partition devices in the pre_remove hook of the block
> uclass, so that they are bound and unbound together with the probe and
> remove of the block device. When only some devices are removed, like
> before booting an OS, the partition devices don't match the remove
> flags and are still active at this point, so remove them first.

I don't think this is true any more. Since commit 3632b5d63c8 ("dm:
Remove children when parent is removed by flags"), when the parent
matches the flags, device_remove() removes the children with
DM_REMOVE_ACTIVE_ALL masked out, before uclass_pre_remove_device() is
called. The partition driver is not vital, so by the time
blk_pre_remove() runs the partition devices are always inactive.
Please can you drop this sentence?

> [...]
>
>  drivers/block/blk-uclass.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> @@ -841,9 +841,31 @@ static int blk_post_probe(struct udevice *dev)
> +	/*
> +	 * The partition devices are bound in blk_post_probe(), so unbind them
> +	 * here. Otherwise the next probe adds a second set of them. They are
> +	 * still active if the remove flags don't match their driver, so
> +	 * remove them first.
> +	 */
> +	ret = device_chld_remove(dev, drv, DM_REMOVE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	return device_chld_unbind(dev, drv);

For the same reason, the device_chld_remove() call does nothing, since
device_remove() has already removed all the children by this point.
You could just call device_chld_unbind() and trim the last sentence of
the comment. If you want to keep the call as a safety net, please
change the comment so it doesn't say the partitions can still be
active here. If they ever were, device_unbind() would fail with
-EINVAL rather than leave things in a bad state.

Regards,
Simon
