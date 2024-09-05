Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AACCD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 07:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B356988BD2;
	Thu,  5 Sep 2024 09:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J2ayXD/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0291188BD6; Thu,  5 Sep 2024 09:38:22 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E87A788B7F
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 09:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so416319a12.2
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725521899; x=1726126699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WK6ZyC4ifV7toCoUkaq6L1X/eQe8Uk4TT+iwugg3dJw=;
 b=J2ayXD/8zkkS2sN1L33dHmmc8cxMF6K1t3vUbwdhhUfZJ2scQeXH9abbJO5i9l4lz2
 6z6J7kiboPZP//44E/6gAwKuu/tIG2Sc64Vbv2cFhKXPMaP5ZpaE2SPt10mU/fOHJPFi
 MuXKa8HhzPNdT8lovQoCqlCBTQZayj5AK81odzCybKTaMPXnuv19Pwg/Jt5QCmUpGE17
 GXRtp9uhelh6IpUDrM4jnEJa8qgHd6iWP76WUSr7aNGCRN7V+ZUKZ4n7dj6G/nuxy4Gz
 oeWF5HGX6PSNnrBVbeCOlqbYaPZGclnLQg11jz+WAFLL8pF5khtgbfWvOP1Z1r13ilTJ
 uz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725521899; x=1726126699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WK6ZyC4ifV7toCoUkaq6L1X/eQe8Uk4TT+iwugg3dJw=;
 b=gXYPjVTbAlG7MlV/r25E+yLy5hr0g2ZyeQ08wvM5aYRzebVAxi8d/Nmx/HvOoVoUhn
 wHwJxZKvb+NJtqtS7udVVJfkhaq+Z2KiN5R6WRFknAbJy0KUXADV8F9pRHp8CL98FBsb
 24PyvwCEwsQL2T2vlV/vJskyj01NyfafcnMnM/M/mAJitjHCeiAHRKPtzR6DNnWSeDQM
 XV0CLXhTJIlVAKuf9MIq6cO4XNxXYzpV115LICH/46hARX0fqbKkVbQcG3h/eu/n39pn
 A3ZkP2vbDCxmuz1gq0ps3JQTjH4AXL29wiN+akqhDvktsBDp3WLrcKO/xYnJm9HpUmeU
 eARQ==
X-Gm-Message-State: AOJu0Yx0wz3378MGOLg3BWaRKX4G1D9z48R5u9NFTxk9oq+kOFKcKYFx
 4a0Diw16tY/5BiWNlMNPSQm6Tzu4dZ4/VRy0mVpEH+e2Irog8BSfBU2Whs/3NdCpmtc8zdhviOE
 6aokfj88+GVuTb690MPQNYD+9BYhnzpatKIyfLheVS7b7zRyD
X-Google-Smtp-Source: AGHT+IFso/ogp9+qUvc6y9uFP0gZUynyfRHkoTbAo7vwo3wcoktr+Y7OL8d9XGRClZ/vx80NKzw21y0c5h760tlHU4c=
X-Received: by 2002:a05:6402:5246:b0:5c3:5423:3d10 with SMTP id
 4fb4d7f45d1cf-5c354233f35mr3077327a12.5.1725521899269; Thu, 05 Sep 2024
 00:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
In-Reply-To: <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 5 Sep 2024 13:08:08 +0530
Message-ID: <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/5/24 08:24, Sughosh Ganu wrote:
> > On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 8/30/24 13:40, Sughosh Ganu wrote:
> >>>
> >>> The following set of patches are miscellaneous fixes and some
> >>> hardening of the FWU update logic.
> >>>
> >>> Sughosh Ganu (6):
> >>>     fwu: v2: perform some checks before reading metadata
> >>>     fwu: v2: try reading both copies of metadata
> >>>     fwu: v1: do a version check for the metadata
> >>>     fwu: check all images for transitioning out of Trial State
> >>>     fwu: add dependency checks for selecting FWU metadata version
> >>>     fwu: do not allow capsule processing on exceeding Trial Counter
> >>>       threshold
> >>>
> >>>    include/fwu.h            | 11 ++++++
> >>>    lib/fwu_updates/Kconfig  |  1 +
> >>>    lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
> >>>    lib/fwu_updates/fwu_v1.c | 18 +++++++--
> >>>    lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
> >>>    5 files changed, 99 insertions(+), 42 deletions(-)
> >>>
> >>
> >> I found one more thing.
> >>
> >> I did this change
> >>
> >> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> >> index fbc2067bc12d..dab9530e499c 100644
> >> --- a/tools/mkfwumdata.c
> >> +++ b/tools/mkfwumdata.c
> >> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
> >> fwu_mdata_object *mobj)
> >>           struct fwu_mdata *mdata = mobj->mdata;
> >>
> >>           mdata->metadata_size = mobj->size;
> >> -       mdata->desc_offset = sizeof(struct fwu_mdata);
> >> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
> >>
> >>           for (i = 0; i < MAX_BANKS_V2; i++)
> >>                   mdata->bank_state[i] = i < mobj->banks ?
> >>
> >>
> >> to break desc_offset location. I generated mdata structure and write it to
> >> primary mdata partition.
> >>
> >> This has been spotted by (my debug) which is the reason why I did it.
> >>
> >>          if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
> >>                  printf("mdata offset is not 0x20\n");
> >>                  return false;
> >>          }
> >>
> >> But I got one more message below which
> >>
> >> mdata offset is not 0x20
> >> Both FWU metadata copies are valid but do not match. Restoring the secondary
> >> partition from the primary
> >
> > The reason why this logic is in place is to handle the scenario
> > whereby, during the metadata update, the primary copy gets updated
> > correctly, but due to some reason (like a power cut), the secondary
> > copy does not -- this is because the primary copy gets updated first.
> > In such a scenario, the secondary copy of metadata can be then
> > restored from the primary copy. In the scenario where the primary copy
> > is corrupted, it will show up in the crc check, and will get restored
> > from the secondary copy.
>
> But in this case - CRC of primary is correct but data inside is wrong because
> offset is at 0x21 not at 0x20.

How will this event play out ? Am I missing something ? When the
metadata is getting updated, the offset will be written as 0x20, and
not 0x21. And in case the metadata gets corrupted, the CRC check would
fail and the primary partition would get restored from the secondary
(assuming that the secondary copy is correct).

-sughosh

> That likely means that U-Boot is not actually using this field to find where
> data is but I think that's fine to say not supported mdata structure but u-boot
> should never copy this "primary broken" description to secondary one as syncup.
>
> M
>
