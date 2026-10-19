Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6002CCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CDF7605E4;
	Mon, 19 Oct 2026 09:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubFynzJ0a5IW; Mon, 19 Oct 2026 09:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78DC5605CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401298;
	b=ekc197eDGlDN6rGt7raOOPiJQZUSCEe1RYEw9CN5/jMTZ21snZKXMR4qjdIS54kNDws+
	 GyNmGY8lQPEVfA2Nv0+S68yf7RlgMmSqqAU0lr+mQR7MgbJib3PjE4GrzulLiIBAH92RY
	 wunoBPfMQq8optgElU8qU/vFmpQwbxhAMNiowBIdPb2N3k404sA8n5mhTezQhJSwhbg/4
	 hVhauWjSRfZHy2aef+UC1NS/bKntlTmDz5tGlFGCwgQQ81GGamzV50kzluGThLHSc+LeA
	 McezTnHtN20w02TUyWyJAuqNSN+ZnETJJdEwz5J4qV7T+JZxmjL1CQMTwtAAoTiP76A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
	b=cfHWJJLOI7XuKouWhtbY5sb9Y3N3GeuAvTm60+n9pVdEPtae2KEWVD3cfuKKCILF3MEr
	 RaELfbdiTsybJqmg+H+RfoDZA8Afg0oLhEsjoDIO2R4iXN0hyW2pWhMldWF9+V/JRIkBw
	 tkwNXQVv7dxw0BHgoFmuJvjAPp/93XjvaY1g655EGGLTqa8b5Rq9A5PuknxP/Rr6MhJRb
	 MNWIi5BKSeAQM4YXT5690lJdRyJtxLTb1wFxTmXCQRaSOeaSQiy/B5cWvDfZ6VEL2Ulmx
	 43RNrluh+qZrQXi2Mma5/541mzCHGjF7CxM2HbatXSkwSmBVYB2UbGxVmAZ+IHFOmPQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401298;
	bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eXOtGz72DK2k6dhyXc1iXIP4Q8e8iiLD2qxg/OuZPExYCKIBb2sDqd/Fl0jwm45sp
	 aqgb6wxcv+qdB79xuiq1wu8yUMi8VfiT5buXOoE1in6F7VO1FARhrmGgV/2cIR1WqV
	 IJEY+HjPE5FABVYdQ9EEOoQbsKW5OJi/VgsZoX11vI+7EdDeKmeO4ufwW+cFz2Wnqb
	 WoHBeqCiRiqHGRn0Yfm6zHdacHtOhFrkPmk4R+iOb2Afp3eTUbD1Vh281uU0SiMy3c
	 1hh5xEy+QpdtNj/ateBmQbh29XhEiVtQdkA56KpVqAaV/OaYpdR9mfhNXel7bfm3fx
	 lf/cKkrNzWpBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78DC5605CB;
	Mon, 19 Oct 2026 09:14:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8965923F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F607406A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e93O1cHAe2KE for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91BB740623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401296;
 b=MOHnqaURCznE4KDiXLKE0E+82a5fWCwThb8T0InwNRYKYttl+4smpj7Lz4sxDMpBWA9S
 LthT7K9DJIu6Kz3GQFBi35BBeY0fm3+aRvP0tJRvo5eGA3H5jfa94OHqyDuSU9x7DOL5S
 3hLxgrVcsZJGby15Ik67faH/tyErCqTcKF7NHQeLQasiHwQ7bxmcWkX/mvU2nmvoSryPT
 axoCuouepsV03BefQz+cSg6BdEKcFUKDW1JuDrannHdrkpeFxnaZU1RNJjtiWxitEbLsb
 fgDFYL4mv5OvVyi6PRmNxu/GPJ25umlKhOBUEgpcfOwpNLnV3ut+I5oZJ9uLJh3wXYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
 b=hXEXpjL3WVElQjfJcZXQlAyM/BuQsgX8qVG35A1jXNCzHiMo7BmEon1kNm2vaRPPw4vE
 kEhd/9hF8tZ+8KeDruGlSrU7VP+hVPeJxT8H9RAZJ1n97QkR/vFITZOi7p62cuvHvSXZV
 D8FegwVmceWajupgyMw+ZWZxijV1SwNP40PeWTjteDDGU5how/v7Sj1xqNR+K/nRtc8nF
 ss4e46TvHSeWsO1iNmHvh7cnzaM3Pp5S8SgIKTaB7szcrr3EdNhWCzD9VYqH4FRKSd+Mw
 9x1ZI8SHkrB6Dlu+uW4HMLevdr8twVazIV472LT2kZHgKBUHaiAmI7qQ1lLrEv6EYvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A7AOfzWC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=A7AOfzWC
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91BB740623
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:55 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2519749a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401293; cv=none;
 d=google.com; s=arc-20260327;
 b=IfWZDzpaKmvvlqEgMC70xUjPs5aEGpgTf9lYo+e6iDJBhJKS0QTqKI1HsTMZkKLDo0
 aPCmSMjmB2U9PuB9IqgUq/EtfXqqz8/1O8Q75TITaCJ8LKmU/vHjbBu8ZgVEj0qQ+5gM
 XSLZTf7HGyK4UtlaqKue5mrLNby0Dv5UkEeTowjpjgVG4NRXc9NKXpb9fO8GfQzpSFfJ
 r4zVQwNfw+wCye3NLlWwhvdKWh9ef2XGCTUxn2Eonz+A3tsozUfW9/dkdibkN23XlZVJ
 oVZpwDRXTAfK1DYdlFX2VxDgtrTRYoX1mLFvBuy28ZHAu9Zg/GZ+J9BCfjYJn/dT+dJS
 HufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=nas+CqSYjPLdYwgM4SUTkAofHMa8Wuv+mq4mjoT7QxYRv5lcTaQnvPqG0SBfvn7Epq
 Pfs0gCbaz/0/dUYQm2l+RWzLtTRRlqxW97CU0FZHOJjRUbtj+XbKujOAIz4LcfLWgeOE
 Xb59o6xKR6B5cyc2+JHIKT0M3dfhJVbqX/Km0gDI6W9M9yacgiSp1FwzWXDXmWeyvwYa
 ydyrmVNgo05hFNCJ5HdkqeAwhrWpczKNCqlcfmrHKw6T9X12Wa/H/4FY5iQut0ZulmKy
 yBXXqr/XtDKLK2fiD9cfdM2pyVuEHV2+l5LOfOBr+KRVy6eGMwRYvSr1FBWKXz0fBV88
 xkgQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401293; x=1793006093;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
 b=A7AOfzWCrrg8wEApOOTRHhQNZg8I+btABL1z/SKx0UgQgOsXNQyS0Ep3zPqr7ONZ/p
 TdROwF26sUI6aPS9CZI4aQfqXm7yhRVOrrGpU/bA/v8yqvgmE7VD2ps3sNMyv4AFA3pG
 g1yFxI8ZBSt9gyUGOygsjFdOeZX/LXDPAkdG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401293; x=1793006093;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LrAw5FY7bgbWUgq7tbIDi1zjXUwNSrapZI+TDOerEIU=;
 b=alWXM5Ek8E1tjfRoGFUrH4jh0TLr5TQhesTzjobadYBCW4ith+wMJ1/ulHJek6ExW/
 huPIxyk2JAXh0q0PZftQ8Ycyek7Q3HBUyDRDFgdLIuRCUOo1ICbxiQkDOUpG9vG7mTGu
 xCqqO8uHJxKSDVOxJVf0tCHzHCgtOPH5y9IrdwPD5sqB17U15jcaxrBvDqGy+oceQjo5
 Lb65VrvBpbBw1D/vu795xY2oA8RTw7Wy3cIisCJUxvws0pIuLuWub9SqHO/PIl7G2VNP
 ND8/7XY5IYU0RJXXjQPhpnUEsc8KoSzck56ckYjqZzi4Lf790gYSalDvNWl+y7YfrC2U
 u5vA==
X-Gm-Message-State: AFq9FYKT28xVrSDrqa4euBld5q90SMRvBWmqj/Xj1uHMRJpbdbrqTfB/
 ACOHkmmpwiTfSxuYO4ztVnu9gyaizdevLW9k8b4hJ4PXjXLWt0b7ZBhSHW96uMphMl0S//SnnQy
 3UfN7oVtJGVqipPWReqKyVaqt2wg3cIJBkbAm75BIL/LzlntmnqPMHQ==
X-Gm-Gg: AYBFou0WeVu9QgfBFLhjUfLtKCELpMVloLySSDLctqwXuaAOcr7XIbU0Nz6sX5NkcFg
 j+UQdwlmrTyTspy6827t86NcoOmEfuFwRaxMHos1ncU35JYUZ4Qm68CmxV0lwpKPzSKhQLLHXby
 waai5vlMCT9YOrYnLvhGcvE340v8BUMPUslbKk+Ql1LhW5TZfX1I4VK4UKucV0DmuqkvVWZoPhO
 YD/ll2eTKxN6s2wsQOBSxAend8TMathxs/rV+DPgiJ9yeynFmDnrmAB6LspPRJIG1wooMx+Y7II
 kYsFWAB8KFKa2HMy+aCrLr6yd96igPVCsXRBurytrD6q4qQ4hVQaIg==
X-Received: by 2002:a05:6402:42cb:b0:6b1:c265:a5ba with SMTP id
 4fb4d7f45d1cf-6b3a81c194fmr4249744a12.20.1792401293109; Mon, 19 Oct 2026
 02:14:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:14:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:07:04 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-9-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-9-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:14:50 -0700
X-Gm-Features: AclHuK8bDqdEZnU-R5LARExLhlJKeGta1qCdqHXIN7dq8Y5JMzdwHk2OoWzYSCk
Message-ID: <CAFLszThFK2F+E7iPNC_v8S2_SK=s4nu0DvboGvvXhLrHQV+ZmA@mail.gmail.com>
Subject: Re: [PATCH 09/14] expo: Allow a box to have its own colour
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Allow a box to have its own colour
>
> Add scene_box_set_rgb() to draw a box in a chosen colour instead of the
> console foreground.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/scene.c   | 20 +++++++++++++++++++-
>  include/expo.h | 17 +++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)

> diff --git a/boot/scene.c b/boot/scene.c
> @@ -696,8 +709,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
>  	case SCENEOBJT_BOX: {
>  		struct scene_obj_box *box = (struct scene_obj_box *)obj;

>
> +		u32 colour = vid_priv->colour_fg;
> +
> +		if (box->has_rgb)
> +			colour = video_rgb_to_colour(vid_priv, box->rgb >> 16,
> +						     box->rgb >> 8, box->rgb);

Patch 11 later folds this open-coded conversion into a new
rgb_to_colour() helper in this same file. Please introduce that helper
here, so this patch uses it from the start and patch 11 does not have
to churn these lines again.

> diff --git a/boot/scene.c b/boot/scene.c
> @@ -696,8 +709,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
>  	case SCENEOBJT_BOX: {
>  		struct scene_obj_box *box = (struct scene_obj_box *)obj;

>
> +		u32 colour = vid_priv->colour_fg;

The two declarations should sit together at the top of the block
without a blank line between them.

Regards,
Simon
