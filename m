Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A22C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEEB860C14;
	Fri, 18 Sep 2026 20:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVeyuq8f8VBl; Fri, 18 Sep 2026 20:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4BE1A60C31
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764285;
	b=IOx5vmhF9RcfFX+3aIGAwUGPya5zUIf0kVNK03YVNoJVtyWyE2oSogYUNLnpZfbiWKsR
	 R7K6icWPPz9UGGfOlwV+vLhEbPqIH1dXazp/AoQCMa3YRK2+gluW4rHOw+ZQIYDD5W7TI
	 /JZzq33XGTzv+gvrzdSh33QzW8Cy0OeAT68uUzxaitfRnmANFTiHkz4xyJVyQOlwySSie
	 9D71fnfWT2QDdBVY+GZxCmSRG7Xai2zf4iWHy1PXY4VRQ8moor0BpmXCPOZ0ktR0NAFYZ
	 tQ4MJJsua5j4dMX1HuMB86CDi/fvepRV+zLD4s2ZE2QI2ONeswGrrZ1BMVh7ZDqOn+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
	b=i0EVmiow2ItAT9tilANYwYRcLt/lg7ekUFkjZjTlWU4k0XABnKcEJLS7FjXFx3G4hbJP
	 P+FDb1eK8TxJWB28CzQzy+Im6yy96R3rJPHeFPd8onH0HWsBc+trgRu1N/93GwDnofeLk
	 pKagYQbXVvTrA9R/0CrOApKacXbds3cx+Vvhp2zMUaxwxdDsT7okM1mSnERpDyEvGh+v0
	 3rzHfZuoWbk4pmXM4BaWgIJi5Or+bc3fMkKDWEXHZuWx5PgBGryie/RxM3OnXz7QzOUp6
	 xfnp3XEOsG3UyCjwKxaOM6SpHr1Rclvkg6eguwbbvpU+sVtd/z6KZXyMob3UrXVwBRw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764285;
	bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p/8y5JFmDNa/267ZdSiid7/J9syzWf8zrlF4524bOUJD94xx6dViwz/GMWXMPfHoT
	 J0BeDTmqNd1AYI99Bku2jZN08vJgj4W9aPUpsl9riD0oiyRGSBC/xHFgOwHfmoxUZ4
	 gf8Dw8vify2uICY19THtIqagwT78Oz9b7f5ipJSgBP5QBgCAp1P+yIIF7wZw4z60xM
	 bFcLsX6jxx6Hl7jxwLoAmMsAcftbJg1yI02xx13WPvSjFj36/nwEHutJB5HvG3LHRQ
	 YQkHKj1zC1KFxBlKpN/IFOEwz/Bbprfqje9u7c4Pk5h06g9ud/CcAO9T6R3ALL3M2Q
	 dZWqQTICVDteA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BE1A60C31;
	Fri, 18 Sep 2026 20:44:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 086EE13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E253240BE2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LYGu3k9KQvFs for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:44:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E80D740BC9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764283;
 b=IfdPaet6CecIm29x4/dkOxMRsBsDSex1o9gNa9YTdUUi5++7sTi2mbESX/4LR/uG152Q
 JHClB6DdZ/ombL6lKQzzGdToIhxSgVi3jq4azgOeLDso8/ZnZMNWQ3qTg6rvZqlRJBwXi
 Yf+XXjYFgu3VPfu/rZwLWrivoRyrO1ZPIqlo1r5DfE8gesHXa3rYw+iNosCPPAqiVfW6J
 yhQq+Iq+dPE+0rsD0oRKQc5npeqap9NYTLRufnspVqOA8UWe9P41dnhIx999qB1G34rug
 HELN3J+cbrp4y6DTvw9XngAeZphnPLVfOt2Vx8gzLUW8nKiDjyE/gDC2gg9rzoXJtxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764283;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
 b=DP0+E7p44Q0j+Ro+6SJsSmI6z7YjMa1Y69LirCknik5RQXAb2DTVW1WG7tJwcxmvcKA/
 lj5K7NV2r0RS6PNZ040CvKBF18iQ/umCTGfb+5i2gnwt71OkN86rdwUYZsIKc4lN0twsV
 mnTm/Qf0ing2pX96RtBNE/Ytx3LfCpLsTDmWfoxhsSksIkffsqZHLaWqEjVCGtLG/ohzd
 jXg3AsN44gmMgizkf4iqo5zl4UCq47Yzh9dDF9SjNgILROpultEBfybd8y8txnci75so3
 f9NwZyD6ujiIHc0/ODwkpe8jcBgSTLRVCi70PCYAU4IEzNTXyyV9rp47sEJYNqcUOZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iliddoFj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iliddoFj
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E80D740BC9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:42 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso1912764a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764280; cv=none;
 d=google.com; s=arc-20260327;
 b=GxI+rLxJJi5YDkeOPob0ECBcBktYjqrKp5IBPyHJlsiuicCBR5s3lYGgsfDBXavwYd
 TnUE9eDbFvpOb6sFzs+HmyQaL+1xvgoEjyD78Gkd0ErNKj6ysC1xrgpSX/rU3DrJdT97
 O7bIjVbEsA0r5Lrh2diciBelfilUdBx/hnCg8eoI1LYTwtM5vmixpdyWRe6PCT6+MTwB
 pEbBF2wuG2whmkW28qm/zjTM4gBb+335RujVe3RoBlhseibz1XcXcsCz7Mt+U/Z/4s7w
 nah/UtNXbM3qVNtVG5wQoqReISa+z+ybikR+Ys5m+19VzGHdLZx80KU1Trl5FXN/ZMkA
 W2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
 fh=ep7JrxOquKw4dFEptYB865R6cA0QiF9sUjicKn8SuwQ=;
 b=EGNrNqSdYWOYb6Ky4atLz/SgLffEIaZ7q5cD5LDDP5S2yWaOKCo9Iu7AtH5lDUB/Vo
 UcZ+oA21ndyHsnaXZVJOaFcbD8LYhVr+stvtRSWUMZH1IhZWUEwTr6A8BC3HirhSnQu9
 QJER1Q/M1RmhG458rc3mKwxPkneTlGYAA9CjjqUs39abgc8+aW3GzZwxljAZYYAt7GPh
 /LWkjNs/TlUTQ8kGcCmsGYaty+AAS0D0xPGLLCq6WnIw8g1BUvnIsMXw1mU6dTjdcw6N
 ouAe1ueDeHUFQmNlmNJy3xTVALevgwYRZSB/c6IbyRSCn2h1D5ljFRWvFxuQJm3la4pn
 jRLw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764280; x=1790369080;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
 b=iliddoFjBqPiuqv6pzjQcHqz5HgTTrBM60goW9Z95Kmqq5aEZrzNrfFjxThzkx3xvv
 IP3GYaXdrch7IGg/RwRfFMohk5hxF7ZSDfTZrttwCiu53ee+cIafFSyhCieOj70LtjUq
 0hhjANfo3aln1Ab6X26EvX4vJwCrgs0YwStdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764280; x=1790369080;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8ezH4HDeBeBTc9Kf2x2xOmFzmQpwtlMaI3KFC71jk7w=;
 b=Gj8rtDSyLtdB2XZfOwny5hBsSV2OOv0ZLy2kVs6gxRm2pXU023qawrBCO/aW/zpvR5
 0mFkzJYmk5ktXoFp/MXneJnRIJv1XnJjIm7jXh7Hvp+4dehoXs6OWQ1Zn8MxVu7ZOhSu
 f9jHzzjO5q9Cz0/eYbDIArz8gL+3EsMRmN0IkwXGqCqq8LAb+GrhYtyyOoz1hBNn1Oi2
 rDZRuHLySZ889Zaf1sEnzNlKW7dvV5Dt2LIgV/MAjw6QRX+c6YQYOOGAu+6t4ESkeVIr
 zh2bjhEQkSaBq+XK4ayBRbeuRGCxeXJxMdVhl+lQYtHxT7ZWbrJ55dWeDObZ5Y+DaFUg
 lIng==
X-Gm-Message-State: AFuF++kgvXiXVvHktkHpgWy5J92JMsNVynxL0vwBTzTtfjVqwdLHOUW4
 4gBt78PRY18vlqQ2LHaRZp1dHgj6IYH3zcvySmBwhZhgl5LJlv1rt9h7fo07RORh7eBkjpOWhWG
 T8vqyEjbiePKaVR35grpHsrhk1AiovUeexUQUso1lPgkhDKwOk2CigqDFj3c=
X-Gm-Gg: AYBFou0OvfL6Yx1RqZIfTV7+oXox4mdbWmmBL/0Cf9+/ZWqq6zbNeO04Dj155YwBvDt
 /sAwxqJW/lPk/EbPr9YI8+c9jFEK4vld00xyHjT31oZInuu722nFD08AmBO2NbCFT/ry8J2Krua
 7M83vjNNGmdk8GaKCUfR5z/j/lh/dIrU9lr0cCe0qw69xebH6LQxZytNvIijXKMbbIY9Be7I3KB
 XO7lPKHFFqreoX+ZaXVRYhYU5ATX37DIqy4muvcFHbY70s+90HxZlJte66WXF5uAIA6qwFhIbgr
 97Qcbx4bLv8+L/BWULgj2y8s6awBvHyedb73P2zEeIoi/XbMdoUDmSRf
X-Received: by 2002:a05:6402:2b89:b0:6a9:aff5:c6e0 with SMTP id
 4fb4d7f45d1cf-6aa53135699mr2673091a12.17.1789764280526; Fri, 18 Sep 2026
 13:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260831163056.3854693-1-valentin.haudiquet@canonical.com>
In-Reply-To: <20260831163056.3854693-1-valentin.haudiquet@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:44:25 -0500
X-Gm-Features: AcwNN1WZtwK8HjEtX8-6Z6qTzXwu0CRZnzb75YTaRTbJdl_LFTV7lHLIL82q4aU
Message-ID: <CAFLszTjsRV6mdz6VXgtTBmSzaMHcoBqgz_Ux__dz=CFNBJMgPg@mail.gmail.com>
Subject: Re: [PATCH] video: console: fix scrolling on rotated consoles
To: valentin.haudiquet@canonical.com
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-08-31T16:30:56, Valentin Haudiquet
<valentin.haudiquet@canonical.com> wrote:
> video: console: fix scrolling on rotated consoles
>
> For odd rotations (rot=1 and rot=3) the console rows advance along the
> physical X axis by the font height (priv->y_charsize): console_move_rows()
> and console_set_row() treat a row as fontdata->height physical columns.
>
> But the scroll condition in vidconsole_newline() compared the cursor
> position against the font *width* (priv->x_charsize):
>
>     priv->ycur + priv->x_charsize > vid_priv->xsize
>
> The condition is only met at the bottom boundary when
> (xsize % font_height) < font_width. With CONFIG_VIDEO_FONT_16X32 on a
> 1200x1920 panel used with rot=3, xsize % 32 == 16 == font_width, so the
> condition is never true at the boundary: the console fills the visible
> rows and then keeps drawing past the right screen edge, corrupting the
> following scanout line (and past the framebuffer allocation on the last
> scanout line), with no visible scrolling.
>
> Use priv->y_charsize in the odd-rotation branch, matching the even-
> rotation branch which already correctly compares against the character
> height. With this the cursor wraps back to row 0 and scrolling advances
> by one row per newline as expected.
>
> Fixes: 18a85cf7b5da ("video: Avoid starting a new line to close to the bottom")
> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>
> drivers/video/vidconsole-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
