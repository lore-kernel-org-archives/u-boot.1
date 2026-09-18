Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA6BC982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94C3060C31;
	Fri, 18 Sep 2026 20:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98Od9TLwqpkw; Fri, 18 Sep 2026 20:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C5B4A60D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764601;
	b=pZeIhkFKEwoYtalTZR6Lo5FIYdYUjDhV/7feGSJR1ryx9nlGO0pYPYmLtCLmmyRFnicx
	 NfROD2z70pmV/cp3zj0JWnOPBKaT6J7TyxCyM3a8r/BTRvUajd3YG9amb7UDjiJyTrGnW
	 X/rWR8xP+rHq+rPEA52u5IfyNejMuHRaer5cnUoiNrH1N3g+uZGG5vaBVmVtVS1rf8+IL
	 ev3GyeETN4HISmZGeWM5dbcYq5XJwOn8tubSQzrf020AHuq+A9N4oEkElDM8gGGYUNdgD
	 B5Gm9/Va/Rqclun/oPbwIRsCD2nL+jrsjqRLb78/8vCdGzExLJ29h0LDUTfYktO5LLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
	b=ibNAWYsVPbAkixw8gK3ZBsG/l3+bKkbQdLg6fa5S+wej5FStFhWESCo9tNANnrYGaUj7
	 mL0kDMjr3xUD05nEBVZ/UA0sThiccoqVvpixoWNycD3Q9ErsgNFN8tE59HzLqkPPKdzNO
	 4eAkHUru+CoIig3sfMia+7fi23qpFYUm3xdFnVMVTEkmtWtepdccBn4NBX6tjH5AcMf7j
	 shq5C7Lgo9W/psBAHWlJWDG4IkC9tlUiUiKAEdBPDH4TdVYqKELY1W2F/fMKMM892v7G3
	 i0eG1YD4COXJSF7RhJAmdyoXFeSC8YeoOWSeEgYwQQjXFKthY6+t/+kRH6jzgdSy53A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JGUHzYHL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764601;
	bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0RyMMGKK3WlizvoTorVR6XKTwFeL6uakEk0nqDQfQ3MRYaRl3fgeaOhj2pN2ZgEiA
	 vKIVs5r093LlUpUNZ05+WFOyNu5kNl6Zjir3+JgYQ0gkUWNmlKB/SVMcFiyzEEOSXD
	 XBE7eCBdB628XmXygcO8fdnMn7aetCaWz4meRwuX7OWB7ls/7ceiHxAVnZAfqHRYdj
	 iEc7Cqm077609vz5Zq6LNqCKDO3zcnuhXDZQG9IQhNcN+nJFG64XLe76ewslc/IczR
	 CD3w2N4SOuLn6I8Wss4aI2E3cEEM1Tw2IVzSlMZ/evJQvlSOnFtpIJwaULi38CiXGY
	 fRFxdjFB4U4wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5B4A60D6A;
	Fri, 18 Sep 2026 20:50:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CD6D13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EE0260C31
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6B0VTIC85DI for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:49:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 21C5260D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764599;
 b=et9MhbQhMLq+7gMhl2x1x61ijMixTmzfqlzKg4JB5JS/Q7p1a5lnOiKN5CVc484MbFYd
 WlzIXt54pRWi98BDvCs14Yuq95+IOnOmkmBsSxczFwsFwUqRtt0hBAH/bU7xaDnoqwrYS
 ZBtz2WRqo5shzB7S9Hc0GJYJE3MjPqP1NQ915d0qMzJ4X9X4E6XcXjW2OeAm3Bedmn3x8
 WNsC8I7iTuPNAZ5NHT2hfKNa95MC6bHZ2KafV6XOtNzfJIBwYiIObDuqg77gmENAdvve9
 YJf6exmF/kgwT3Xnw2Fxesy5ceTwKHIOl/86wvPW2CuRbjk0/tHV8Y7SULuXIUaW/cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764599;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
 b=tQC2X/zFFEH/VaHu8c6OwvZnMIBFHpBf75ELDj7wz4kZ+qx1/Lnhj7W88fbuq539g82N
 ZkGXnTOGFy2KcpaiNOtFQDGfa07BaD1Kn+8oVBVbYLH+tWAty/LRkQzA9SwvsehQQnUTJ
 v7q6My8UliHaOMdlhneiX6Jf4bYoEcrXFExd/J1+Fi/+CmMLoGA5G6cq6S2ILUYugf7MA
 La+T1oiMPqTQP6rK50ZSzoX9bHMeDKQYRC9L5e02v6Xb0Y/S3TWVc7oktDjKmK1aDEWOy
 p4X5tlAUu6Z6JU+ksP+wZH7VAaNPTSFiJEPdlyg8lLFEUEtKTDyYxlAlLz7MQ/l25XQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JGUHzYHL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JGUHzYHL
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21C5260D6A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:49:58 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99c5de614so1578474a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764596; cv=none;
 d=google.com; s=arc-20260327;
 b=pgTRZVP4/vmF7beJ/X8oRtjXo40pEQCrCTHWGmJwdtM2EpPzFOOy3S71NM0wQkDFAE
 m2j4wGDqX1AEb7e6c4JbHF2LwdqWlJeyZcqU/QJGIocOpBtsa5J50VYILFUktHDnUVlm
 STOQJP21GapDXPXE7jf1yYHtVfirCipmN/Qf4Pmk6U1zyySeWJz5XB1a0/AT+H9t/hc8
 ngxxp7/XfTg8xHQpJNEQJfzNj6AjPLqosq+1uBA5akh3Z9zhueASE7zlnuKUx6Li5VbZ
 NCfLB2HN+GyL0saPuE+3Jy8DDor8CmCS60PUr9tI0fuoeQw7kMZar/hPvosJkHZbJir4
 wpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
 fh=56bkf3zsfilkp7HgK+DO/exurgMfRQLdEk4inLt7+o4=;
 b=nJHqGT1m0OJjejsFSQMxaOjkGkA2KxYadgELk2ZLRer9R6QXGEmmwid+tRecTSfxfw
 c+CTcJt9kolCDh0umpRU48BcXTgmE9U/8LTl8LJIncmRAd8yqYUHxqeYnA4HS2qX6Cos
 z0SncNUTd6sDUuRZH6HvKaxFUxcE3m/EJKL9u32UpHru4XZafAwCi/8/+wOlIbSGEiOp
 GDXSdzNTN+URKuIf3WAob8MyYjRtyMdadOqjQOSvlcyG8BO2HodSqJWiSubxFDKVJ+p1
 QuBwnK2TD8GDa6yNHdnXtwGYGpQEFbU3KfEtD5PBNzBrtR7vWU71VWVIbjV03D5KTu0t
 F3zw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764596; x=1790369396;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
 b=JGUHzYHLngJzVPl6nAMHWzlInpkuz6b2truHKzwRvbp/QChJ6s6hyLIafOmCHKorW0
 FvIoFDvh5WBQqIEZFMd2mHFHiyDFGnE4/f2qKkOsW6UMhVslWmoYqPoTVOeyG55lzw+e
 TKv7HmjwqWm5bMM494TAoRHnN9X/KPtjlPFqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764596; x=1790369396;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XKk3b3fw3RCVH3Smz+DkPIs5dOpmJ+mU+vLAAGHGHa4=;
 b=qUUUQw751MmDBymh4YaRWs4W921OPiSZRIEA4EPdGfWqmjavFmwdHCLJMTTyfpZFHO
 nlpbzQmsjvIamLtOR2MUZLbjkRO0zgWK5gzhgME3QSZWcERc4mMWWR9Zp9vq4b57oaEw
 rLHE0AJzauUb0+BB/2ZEJS08nvJk/XiRv90ssAPgWmC80BYjKexPOhKYyLidjX/7qJMe
 O61kAUgTzdOsfaN3jgtRCH0o5VO4oFNQmPL1uwUPb8E9RpB41PryL2jSBDlC30AIhRAm
 qgpNxZHPQfQwn5QH7f0NqvlbUBb2tQAtLBQW79H1YzNglM+LoKTsTko+66Dw8XgwKlIc
 WwsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTS4bwvTv91WOfm8ntIQ9JPIrEDAsXsaLTrToYpsuytTMjV4Qp2xhuRRUX91hv6vHZC1IgATI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lElGBQ/QS+F9td6AjiyNo26IQWVjJRTh0/lwjq8pHLHZO8h8A9
 JT7nY/8lBfG3Q3x3c9JGXCmpBmrC+jx/W3H12IZRLjYvCaWzFIW61dWFnowMjbX37oXURPoxDic
 XO/BcaNee8Vh7BrjUcJNe6VOJspHXwTIAFrG8iJKk
X-Gm-Gg: AYBFou3IZa1LwXxW/qFbxBgKo20cAv7j+bYNkk4U4Cr9AgpZlTy4lvbCveQe93Jef+n
 pPbSlB+RbBhsA6i0oatJ2APJHCxDB3bh6yMZr6E71RfMUy1CdrHcVmxgXzEnr8Se2XIerelMN7M
 ztyj+2s+AJTJyaq9daJsT/6dsFgtIrVi3GHCt/5hePPTeG6rPn4vbkPJnqhKQLrGjCNBDuRM4Ji
 /gHpfZs5sHHHBgo+/o4YKyqXxgltll4s+7HtzV/uZ4ZxyiVX/YWL81YELM7WAIbuuXe6cGeyquB
 gxLPOTtYIKWeCfvUtxMJd+83S8xxFVWmtSBQcVxK3mERwiYWpcksdTri
X-Received: by 2002:a05:6402:2381:b0:6aa:485d:56d4 with SMTP id
 4fb4d7f45d1cf-6aa577f54b9mr5169701a12.5.1789764596517; Fri, 18 Sep 2026
 13:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
In-Reply-To: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:49:44 -0500
X-Gm-Features: AcwNN1VTCqAs0PIDtPOk99lmFIJx9ookN1c9JHdz8d6gAow_JMTFM_qaFEBYJOg
Message-ID: <CAFLszTgGNjf2TLT3joC2P2b3c-iA-affy5SrbjXyM-FA_c89UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
To: jstephan@baylibre.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com, 
 u-boot@lists.u-boot-project.org
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

Hi Julien,

On 2026-09-01T08:52:42, Julien Stephan <jstephan@baylibre.com> wrote:
> video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO
>
> Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> at link time:
>
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
>
> The __splash_u_boot_logo_begin/_end symbols are provided by
> u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
>
>   obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
>
> video_get_u_boot_logo() and show_splash() reference those symbols
> unconditionally, so with the logo disabled the reference is left
> dangling. show_splash() alone would be dead-code eliminated (it is
> static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> but video_get_u_boot_logo() is an exported function and is always
> emitted.
>
> Guard the splash helpers and their symbol references with
> CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> video_get_u_boot_logo() stub returning NULL for the disabled case in
> video.h. Callers already handle a NULL logo pointer (e.g.
> bootflow_menu.c), so no caller changes are needed.
>
> Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).

I won't comment on the word order / mixed tenses.

> [...]
>
> drivers/video/video-uclass.c | 7 +++++--
>  include/video.h              | 9 ++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)

> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
>       return priv->ysize;
>  }
>
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
>  #define SPLASH_DECL(_name) \
>       extern u8 __splash_ ## _name ## _begin[]; \
>       extern u8 __splash_ ## _name ## _end[]

We try to avoid #ifdef in .c files and prefer if
(CONFIG_IS_ENABLED(...)) so both branches are compile-checked. The
SPLASH_DECL externs do need the preprocessor guard since the linker
symbols don't exist, but the guard around show_splash() and its call
site in video_post_probe() could be avoided by keeping show_splash()
defined and providing an #else stub that returns 0. The existing if
(CONFIG_IS_ENABLED(VIDEO_LOGO) && ...) at the caller can then stay.

> diff --git a/include/video.h b/include/video.h
> @@ -418,9 +418,16 @@ bool video_is_active(void);
>  /**
>   * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
>   *
> - * Returns: Pointer to logo
> + * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
>   */

The stub is guarded with CONFIG_IS_ENABLED(VIDEO_LOGO), so the doc
should refer to VIDEO_LOGO in general terms - SPL may have it disabled
while proper enables it. Something like 'Returns: Pointer to logo, or
NULL if VIDEO_LOGO is not enabled in this phase'.

Regards,
Simon
