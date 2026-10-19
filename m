Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561CCCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50A5980BED;
	Mon, 19 Oct 2026 09:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DPKEKWwKLmUZ; Mon, 19 Oct 2026 09:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AC7080AC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401306;
	b=PRWlZYcxGEMYyCewVnXKp0h13r10fqap0qyU3fMvMs3NLOnIex9pya52NnbXBjKsJepG
	 HzQl61u6CcehAz41u3GFCIfLPd3Csf3EfwDBrxwboOqGMpXeAMURXNe+tp9PMYxUNSwwq
	 pTFhnDgfUIVaFUpk1qXfQBEC944uLluhCsi7aGo/doWilxV4Ra+aptbBsAdWbFbgB3yyP
	 uNCP22fAW/8j+REfA4fVxpHBfuzT1PNLipE1oLtmUqbye08MZR3clypa0Nijm0NncOIKd
	 JX8iu3X16wuAISm9F+ICjYIvQnrA9c6pG2p+rQTTmLvINbN73k0DgoUWC+TPIfLl6RQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401306;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
	b=QhxyJRnymMyl2sZYinD6T9azIQUygP7v0gpS6ym+V7EGyO9FHDIZAx0AZ77LYm32b52o
	 unCGpo4hMNN9XNAKo5KS5Nmrc/LaqC2tr9WVe3I8uSqVSwNlgWmOCF8+1nsXvDlY7lEsS
	 vRjgK5JRoOQNJsrrZ0plyqApmmJFiFlgka99YSNZWARbos5elpTSJhW9tmQPcI++l/XM2
	 dowQxbb9UTWw6yh9HvTm5EPc76haK+5UZ1s7XiE2lgN1IkhrEHySIIZ6NrkI20bI1LOvO
	 jtxJdQ8PB+BwQH31yeIT4tElHPOqbo1pGArjHRcaF1Mz1O9ufLGi+uS7mL7B2lYP8aw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401306;
	bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HufMVmznaQppnTiyyK1R5B+apExiM4rUzeTOmiEwHX/LMcwzCyHaaAeBkGc1zG4nZ
	 XAXJWcP2ynHm8iL5TZFteUi72EqMvy96IWxtp63nzFw/ZNPlCItEre7PX8ojkobkvq
	 C6Xhc2erJ3cDv/PPMUNyMxNnmDfc4RQ9E6KM1ctSV4zZFP2pjiaqeAD97i0OfEuuDJ
	 ue2HFcESzYQGR1kwTdEwdh/2/zGRxHe0iVk0GKlzxRNX3HWvUtTUN4CsS2X/Q8nQNH
	 grrf8mmJno6Wft7VzFTymXuI6F9acD6dR+q8pk7KAAu9NY2XLIsoBVHb2y9MLj0vGL
	 h4xceJ+YJWBEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AC7080AC4;
	Mon, 19 Oct 2026 09:15:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1636523F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0893760749
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjTAHpb9x9nz for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E11C6069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401304;
 b=am9ULX759PfLS+F6yvospW1o/r+0rKMSDTN8WA/PYhqvQfwhxuRbbdWycEFiSu4guZ/A
 WocvBC+tuonfXKQRAVz0EXYC6Ar1wUjjw42a+wmQpDXdMObMA5kCRxjLxbHSEuSa3u59z
 st+w0jJiO9yQyajkjSMf4DWCKJZXt0I+M1S6AK7hzEtHClp+HyzldFWjSU+K3mN7+BDov
 BY27FAj3icSN0nSxV7VilGWfS5IRWGslxjhsIatUYo+Aeqy4oa35kjzmLqQvpJMOtZiDI
 F5r9sS4YN3DJ45Mihvgi2IdfKM3DPgV854qTh/E+Q2jA/KZxYRoFgn5bm3YE7Okqfgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401304;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
 b=FW3YBApy31n17aO9EXDWHUivTp4sXVBtnp8cCGwkEkgb/KAJmchgGfaEMohlo2OBPpWo
 U4NlRX8OJry1tAltgTzBMCoamKZXSc4TIfSzn75zbL7LxB8Zty+GrcIUD7JoOSnkaldgR
 hA23ZpIs3uHVeNCe9qyjzNgixBJfTLdNsZE+1g25JlTbFXnEAXAy13Yf+lk+RG6LdHw7G
 82Jk20xxERnXvmwM11GuYQXJW98lj1pndfF7jJJ4XiR/fprf+W2Rh1avpgztiq419pZZ0
 HLdfsbsF4Zpb09ScXLmtgb8o6Z6XIbP9rUy2VgQzQoZz8oEvlxcbWsh3nhbi7E9gI5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OSujmpkn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OSujmpkn
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E11C6069B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:03 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2519939a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401302; cv=none;
 d=google.com; s=arc-20260327;
 b=LQDWThJ5NTO6WHuhMUmSk+EpvpM3VG9v5+0zGpWKCzHLM42u8wAMGNw0dIFxE7VsP2
 MzqxDoU0wfndVRJF/ZFQ+U3mH4lsZYYySLwrybjeWG0uclnlsf2CTSeD3q7WlVZH20LQ
 5fCaEJeC8oaVMvrY76meTWHZjxmBCEdY4N0Xx2LkdxbHi/c6+i6qpJa/LxE99X0Qyo6C
 bwlg8JgQ5xAYpwfoJcsQVjlmGRnOCoiRD7cKzvbKEo7dgRNHYhhXV6KrxQ0qjl8x1ufG
 Q1IycBuzW8R66CYsWN2T7oDfnCMe7f6jewloIfs/DQpnPxU4NXNh9ujgQ3Aw4arkuZK1
 UEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=GBwbSjVBETcbdRvcmHd+MM4yM/OkroxoItLNmPL9mMNDYNGVps2Lx+4NTebh3Zj8VN
 xQw6YzuqvQFrrSFQRQrWj3+ldoU8SSq/UaTA+s4LIW5Tp6achDJlVpe1dWRnGvLibrT7
 tDUTy8eZhLDLPHNMeX9RBmKi+if76pwtD9+iVTQR7KAmcXENaTUBERPGFh+QFg/4JvTr
 2pjoxMDL81dG+Lp6MP6tssR2ck/7YYJfCAhtdZdzt3N6c+PgEWtj8C31NWD/M+QlXwa/
 9mTv/3Ft7oiXir4I8wqAQbhgqZqzO4gaoggYfDUm4aUHe8plscSGzu9dfSLbBIbmv+6Q
 JbCA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401302; x=1793006102;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
 b=OSujmpknjGIMnIneEuY5FCtTUdvQRfWuLeK6Z814JRTY3emeEPIuGbOP6mOLpmdFbt
 Phl1pywczEtK5kpGD9T47VE7aOyXFtrukhPC3EOu/aNP1K/0f24b0yytIneQlpuRw6W6
 WKRgheeDwjRPyqKVgplY1nSqmeoPyYDUyF56I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401302; x=1793006102;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y+uRA/qrv/IbYfHIM/JVEAYlDjrBCTm0my19I6ShIw0=;
 b=0Q7crQs9eGSd2BD5VkYY/At1f7DsYoHK1t50Z6fWh2XvzmR5ww6SLXD++n59bWvrUU
 lI+401fNtoPwzLDxSY0inoc0+lIwW8DVQqTzu2QaK+wugx4WIcfECe92RvU6OMzIisgS
 A6b7BXpKlrlZE/4gfHnTAMlLxfR225v+2hfGanMtt45E/2hRZhMpXO69SoCKKuwhPRJj
 A3adY/iksJjP2GeeR8Q/XRc747gQ99uhWcgppkOYCvuWtlyc+35BRViEcAAhjNuwZiwC
 ubEGmftaqESd5svRwap76uKniB+A9mLhrnK2n9Q0//QN9oBEqw4KIgZzZYpvvF4Qy3TK
 FS7w==
X-Gm-Message-State: AFq9FYKqpFTjimE4nfrZOirVnRghsq2cJ40tFYlRzM/zeaDKaj921y+3
 h7l2yqxMjbpb9CNc6FTF/n6Ekak+sWEHDZEdcSmgTDHtEs0ziC5IlxcWpzJ0O4WN+8tekfj1m00
 N737yVGdNPLgJ7L6FyTIXe16UA6Al1aWZpTbXINJL
X-Gm-Gg: AYBFou17jN2jeFLfuT7Krp/GOyb3LBc977yYixee539vy9S5b7DkEVDT3IP5SO4oXk/
 eW09OdZKeSWy1pFTmaUe2AbFRAE9tK1fjliC8rxf+kZFYUFWHIHEfbkzFBxx66wpTs7FBUP2WH6
 M9g9kuW0nZKCw9qK0FHrEEWvAAZmr0IU4oiu7fZyhXcIEJArWEOPkeBnSl1Rr1GfQ/VdkS5rsUy
 xjHXfuR1cMT78V2Aisi94o3Zx2mRnXM3MFYyIU/YjZbN4efyHnw6cQS4qtVRBSkIVDBe2fzAYXp
 q+cpBeK/hRO/r8kBDM+ctoePYXBV1jzlhLgHqa+NBEg0he1Ul9Ni1Q==
X-Received: by 2002:a05:6402:1cc4:b0:6b1:d2ee:3933 with SMTP id
 4fb4d7f45d1cf-6b3a822923cmr4222132a12.45.1792401301629; Mon, 19 Oct 2026
 02:15:01 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:14:59 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:08:26 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-11-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-11-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 05:14:59 -0400
X-Gm-Features: AclHuK-Db2z-4XiB9kpjstnECsRgGO5r8MJGsl-T0QWFBEsiOmkzTQ-zg2zPo14
Message-ID: <CAFLszTj4+8mC2K1kh7_2_4AhME72BzHt=RsvBvYkszY3LXGAkQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] expo: Allow the highlight colours to be set
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
> expo: Allow the highlight colours to be set
>
> The selected menu item is drawn in reverse video. Add
> expo_set_highlight_rgb() to choose the colour of the highlight bar and of
> the text on it instead.
>
> The video device's colours are put back after each item is drawn.
>
> Also add a small helper to convert 0xRRGGBB to a display colour and use it
> for boxes as well.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/expo.c    |  7 +++++++
>  boot/scene.c   | 19 ++++++++++++++++---
>  include/expo.h | 19 +++++++++++++++++++
>  3 files changed, 42 insertions(+), 3 deletions(-)

> diff --git a/boot/scene.c b/boot/scene.c
> @@ -584,7 +589,16 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
>  		int inset;
>  		
>  		inset = exp->popup ? menu_inset : 0;
> -		vidconsole_push_colour(cons, fore, back, &old);
> +		if (exp->has_hl_rgb) {
> +			old.colour_fg = vid_priv->colour_fg;
> +			old.colour_bg = vid_priv->colour_bg;
> +			vid_priv->colour_fg = rgb_to_colour(vid_priv,
> +							    exp->hl_fg_rgb);
> +			vid_priv->colour_bg = rgb_to_colour(vid_priv,
> +							    exp->hl_bg_rgb);
> +		} else {
> +			vidconsole_push_colour(cons, fore, back, &old);
> +		}

This duplicates the save-old-colour logic from
vidconsole_push_colour() and relies on the matching
vidconsole_pop_colour() below to restore it, which couples the two
paths implicitly. Please either add a vidconsole_push_colour_rgb()
helper next to push_colour(), or call push_colour() unconditionally
and then overwrite vid_priv->colour_fg/bg when has_hl_rgb is set. That
keeps the push/pop pairing in one place.

> diff --git a/include/expo.h b/include/expo.h
> @@ -655,6 +661,19 @@ void expo_set_text_mode(struct expo *exp, bool text_mode);
> + * By default the selected menu item is shown in reverse video. This selects
> + * the colours to use instead. It only has an effect when @exp->show_highlight
> + * is set.

Not quite - scene_txt_render() keys off SCENEOF_POINT, which is set
from scn->highlight_id in scene_menu_arrange() independently of
exp->show_highlight. Worth saying "when a menu item is selected"
rather than tying it to show_highlight.

Regards,
Simon
