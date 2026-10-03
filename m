Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D46CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5502441417;
	Sat,  3 Oct 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXwvCA01Ng2D; Sat,  3 Oct 2026 13:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 87C4641424
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032721;
	b=PHciO93hYnYB4lITrMa3klVIHskDgCNvF0iherDfhUfE23NUxqIT6Otui4+7gUrCLqPG
	 MMXslGtkkvuyLAA38lmpUp2nsl7pFo8413CvCmL+jNV4EW0WvSxjQw68GHyXOgfILG4jq
	 ydKvim74w2AVOGWEAcePczZC8ndx1Y4VyxVnhEDQYGlOBqaudpxHHfLse5n7m6ODuCt8u
	 PDoGsKHwytYtIxDo/0/emCIEYCTHVsdEz4QftleHbB9lL48tVm3NpobPArPBe6p5EHM3T
	 bwEhfyO11qEQblhv9kJZaNmrflfHnz0aW8n/S48EcC0wMlHybCwbMVi5yrjiFDFzXvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
	b=bg8sYFjr8o3RXGQehKZ8PsP7crZtWED7IdrjlmZcXKXp1Fn63bIkXbOi6vNDXKbIlzBU
	 QjXFxLzHFmHMRTi38DtxO0vDmGWELWYOI68uRNJ3wa2pI4x4LOUZHZnTKGLBxivdJ97Oa
	 n0pl77KpTzQq3EyzQabblVwXDKdk0p/wY7FiqMJZVLr+GaqFIFnRVT7B1dE8tZzVCwPPI
	 Gtm3tcZZlYeXdPIwP331yRUtBVoOYvK1v9hjxRzOUOQWaF3XrfSsza/kC35WE+01k2biL
	 GyErujjd7Xja+WSpwTiPg1nnFDDL0OR4+fwgL/Qg62MpHdImJQFl80VFnHETDDOwmyQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="MC/9Y23d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032721;
	bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8jSsNjMrrHdyC3hy8C9EPseCLuceA5HgetI7Pve43C7V9G4Dl493A67dhR6sF22J
	 U48nxZKuHGjDBEkxcpjaqRkjxbVMWRejof+ECRvCTSfiATu/jiXlXVxHOlP0xpWa6I
	 fVEDP9k7d6hHi1CWVoR+cfEYyBoOrpOVLGgrUUXQqiASLtPrzS0/2hUInj+ZPv5Imi
	 STXQVLca0VcyQ7XHWl72RV+3Aqy9SCRohSGwquazEUgka2Z7FVgUBLIeP3rycJugOI
	 hY0jbwiwuxTsJYSrgpO4IlAvpWlGT/t0DBUsXVQ72/XYbFqjRX2xFSXb/eO0BGxNLo
	 S1gqc2W0bc5yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87C4641424;
	Sat,  3 Oct 2026 13:05:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12A9D1A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED2CE41424
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 868_gFgyJAm1 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0BEC841417
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032720;
 b=pzTvD6XCSHk39q9aKmXyU+CS3IqN1h7M7yb8XY0qzztk6+h2EYXsybxRq9uxZlS7sokX
 NS6JEY7xWFxUCJy+dBBBehKTsl81ztU/y4WdMpPIzFixF8+cA8ERqpXIF5EK38m1QzqOe
 F3t5w7lzZcIhoj68IsU1zxWIiwo+qZ6AMbfyy1Adi+Ts5G6nq1WGFaRBOyG+6o7DYgJfh
 aFWs9ow/DZ+5srZRxNGLiLCekdmHsfBQZaRvlY1/KcUYb3cJaehCDwiLVmWxcmxJdOQPj
 Vg5InRxIoK966sOCfRLyY/9uCev3OSe5WH7Dfejk2xzCOX6VuejxSODH/wsephWVWIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
 b=nOI2Lkw1LbdlQAxkgIL4aM3TKjhcDkMmmF9DFLWpl3ie/q3qKKPCbUlIsZDeNZiVV9jZ
 83OXN1JO8/nhausPoTm3VwExGWXuQ69wnBZ1DtIwYXWBoEpNtkbU0Mgy7FnSk/ZcVoyBM
 mzukV2qxaC+9oxLBY2vv+1bMtloH21nbEptvvxvJVWEB0q8V2TTHHxd7rztChTCbNvrpt
 J1SzoInFGEqjxBWE9K+5af6dM4HdRsiY0Dmw77D2mXYuoGWJm/JLoOdZkSYNoAkeExQEK
 wx1xt3C6mcTEww/7X9ZGjs00FgyZGlfLD4t4RH1JxcPceXKju3INjG6jYd9DdgJ39mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="MC/9Y23d"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MC/9Y23d
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BEC841417
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:19 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6afb0063e63so298035a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032717; cv=none;
 d=google.com; s=arc-20260327;
 b=fpWDuYdmm9qVSgLfcZRDagpsPCNNhHBAArNmIAYmsIA6rlUl4optba7yP5xBQLRxfn
 HX7KAITHDdPF0W1XfCfP/eJWcPYsXXDt3hXRWde7o9eU+0Cye1USXzcBj00Ojr+MddsE
 pfDzlQWn0w/HlKN6T7iACNFEnzXbGtH8dRLG5rTwiSXZXv7D+cRxwXKXAvPfIwBGtYP2
 LLHABQHw2wwnvQ8UXmYb8BtNy4eQS5QFDMsE6q72f/8v6dS6+/gPWyROumfKn/VQzeGD
 yPy3jhTT+ZJjIB7qTIkVYsEVcWr9nj2BHtY6qV0i5cg8JYHRanHnE6nOMkj1fmxZ6MUa
 0HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=G83k3GN3/AGYlv6jz3faJpZfSHuLv6226F9BDF5kjIFexhhCyFKfBHimXTIxusV2KE
 pkcQ0ekBjnRugwN3gB69aoVgstkoTQAWdNvBL2qUa+g1UvvlaR/Xcnk0ASX38uzmabJv
 LYUwv3Rh4CXbeSaKI31zoNotnYYQLjQvjl7r44ES9wweRt+Can6VvCaVhJSDZ16TP/ZP
 ua0g8aPMKxJN6Iv6igt0wcZ3y4EqXdrksqjGOio+Z9CgPkaGId0EJccnauHYAVcsSITo
 HX7RcyqwviY1xvI3nS7YdnswYw5BEg9Rh2KDRnHzVb1EZVxLpHb+WHgDXHli6Iws4aWp
 UPmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032717; x=1791637517;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
 b=MC/9Y23dzQCIH90AAkWXt7HfDYKE8ZSZmu9Rdz9JI13T+tjf+AKEzeYCihWzjZPWt9
 v8xWoC0T4Ijba/AbWt15e2RHm3wFn3Thvjuw0tOkip4GwaiUO9NkqtgKKJwc+gc0OLU1
 eSEh6ik/Hy5h8IVASJMz+tKemPaoArW/WRMhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032717; x=1791637517;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JovOJT6d4CTKzdOHgBMVookagcLW4+Es81MxqBXVrw8=;
 b=FOZc4//xamjFjuNUMmlHlSwMdXqlp7mDGU+gNDAzPnAGSwykDy1BlR42C9Bi1NIVJA
 MKyyDjwA0EvZf8ADxdlR4cG9Yt3osCzbgMdbehCyj159qsSum08vQ/5dSRkhswrqwaM9
 OknkGdIKeENqwKgY03kMT7YCCvJPZeEs5rrBTIrEdmzvh8qkejL65qKMCanceZQXl7pC
 2HaNOEbniRg1XMgBBXsGCb6D7uCFH+WjtnQxSnnE/b2r9B71M5kgq3ZtxZVwlMwzRLZd
 EOMYBPFOPaae6LJhoNMmH6AjCIm/Y+vnA7zQianB3O1qEq2ZysUYt2zDdEQBMEuIFfy4
 5hTg==
X-Gm-Message-State: AFq9FYIA9Wagik3TTiJ/M5kKN+eFvToNGPjctLTlWJzwshiyZ221sF4p
 vTNaJtLX3ngnd16Qn0lHchnwrJIYprN1xZqNE3aXKKoFvzZVtnZNY7Z5K1m9oDclHPVVqPTNnIN
 wc6UQmYoZXtiwZd2TCYvqP75d932ycT+GAe5R0jbh
X-Gm-Gg: AYBFou30EEF1rR/jcYjDfALJMCz4bC/osXM5p6CxAFgAcn/fdFmqM7LreFk4Wfnhdcy
 dfvCiJN9MqT5y5my2OCRH7gnFGlGKvQgengw4mugBVJGo2ByiR6SRbUvSGBjgQQm/Vcp53Tfnpi
 dJBNtf5ermk2kAwS2uJ/AGYS02jnusMM4kqtdKh3jskWNxRpTDyOCHnV/GYU9yrFwfOgla50d8C
 ifdmkDJC1TH+MYhJnokYfnkWo06/nVYm9PeCQLG5pZz81CzvD++Xl+rUiITvyG7C/DTfgSanZ1Q
 lUiIm8K6l0AK1ZheOsSi0Gz2NUYgvc5/8HCDu5p9u592vgyxPdhnG0Vs
X-Received: by 2002:a05:6402:454c:b0:6ac:8d79:9e13 with SMTP id
 4fb4d7f45d1cf-6af9e2cb9c6mr3531278a12.6.1791032717516; Sat, 03 Oct 2026
 06:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-10-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-10-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:05:05 +0100
X-Gm-Features: AclHuK9XKJyZ3krmCLfU8qj04w4bBtA2zeT_BNY9X9r2J2H1yhBDNfKCWji4GK4
Message-ID: <CAFLszTgCTAv6S3ozRZHJO1VcmYR2h+ndqhfxzYBBRGnnJ865dQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] spl: ufs: allow loading U-Boot from the boot
 logical unit
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> spl: ufs: allow loading U-Boot from the boot logical unit
>
> Naming a fixed SCSI device number cannot express "use the currently
> activated boot LU". Offer the boot W-LU as an alternative source, so
> that flipping bBootLunEn between boot LU A and boot LU B moves U-Boot
> along with it and the SPL needs no reconfiguration.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> common/spl/Kconfig   | 30 +++++++++++++++++++++++++++++-
>  common/spl/spl_ufs.c | 18 ++++++++++++++----
>  2 files changed, 43 insertions(+), 5 deletions(-)

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -1635,9 +1635,37 @@ config SPL_UFS_SUPPORT
> +config SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN
> +     bool "The UFS boot well known logical unit"
> +     help
> +       Load U-Boot through the boot W-LU, which the device maps onto whichever
> +       logical unit bBootLunEn currently selects (boot LU A or boot LU B). This
> +       follows an A/B switch made by the device itself, so the SPL does not have
> +       to know which of the two is active.

Just to check, SPL_UFS_RAW_U_BOOT_SECTOR still applies here, so with
the Rockchip default of 0x800 U-Boot sits 8MB into the boot LU. Is
that what you intend? If so, please can you mention in the help that
the sector offset is relative to the start of the boot LU, since that
option's help only talks about 'the block device'.

BTW several of these help lines run past 80 columns, so please rewrap them.

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -24,16 +25,25 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
> -     int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
> +     int devnum = config_opt_enabled(CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM,
> +                                     CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM, -1);

This mixes two styles: the full CONFIG_SPL_ name here and
CONFIG_IS_ENABLED() below. It also leaves a -1 which is never used,
since the W-LU path ignores devnum. I suspect it is cleaner to drop
the variable and use IF_ENABLED_INT() in the else branch, which gives
a build error if the value is ever used without the option:

    if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN)) {
        ...
    } else {
        int devnum = IF_ENABLED_INT(CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM,
                                    CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM);

        bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
        if (!bd)
            return -ENODEV;
    }

What do you think?

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -24,16 +25,25 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +             /* A UFS controller only ever has a single target */
> +             if (scsi_get_blk_by_lun(0, UFS_UPIU_BOOT_WLUN, &bd)) {
> +                     puts("spl_ufs_load_image: UFS boot LU not found\n");
> +                     return -ENODEV;
> +             }

I built rock-4d-rk3576 with the new option enabled and the SPL builds
and links, with only this path left in.

The message says 'boot LU' but what is missing is the boot W-LU. Since
the likely cause is bBootLunEn being 0, please can you say 'boot W-LU'
here so it matches the Kconfig help?

Regards,
Simon
