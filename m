Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC83109192A
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBA6840B0;
	Thu, 19 Mar 2026 23:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hPr1e1dP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEFD840BE; Thu, 19 Mar 2026 23:09:58 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3098784056
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso99556166b.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958196; cv=none;
 d=google.com; s=arc-20240605;
 b=cSaeiLRHflVx4pz9TS+yf+p7zB/lEjyg6Epif3dXK1Fk5F/Ssce0O2eFHrOugapSSx
 Lfy3jO+T/W25M9jeSBROEierROSE8tk6ZNv89RxlZeynJiM2XXj56ZsUfpfkDcK669fW
 55cf1JvSPfDhknqiank11s41rzCJOkzs5GMJ0WlSG8hLjZvlZyjfcI4MdhSV/ZU3aj6Q
 ezjw3db0Mu4BsSz01iuyMbPIL73o07zaM7o5uTX1OMdtxxcGEjCfcFLHRR4HSgaUmOIs
 xIBSGS3ZV1lfOR4OmgvxW6iazL+bnfG/7I9ndee1D9u9WFI1HaFRaLAFmcZQ9Sx/yHcG
 fm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G/gKEjKxVm+m9damrsVkQGD9ojfpDVmGDQSqpLaxhT0=;
 fh=2N/GFik9HI109CjVB737DYnc47pvd9vkTeLOrL6Mk6U=;
 b=ODsSFuonWI/2Acu7F0azeNZUacbme+G3y78EeKRcCLve/bmwRFBBpu3dZcNW5a8I/k
 eTIGLT974PVVTcVDTA45ppt+GKCSlQv04i3P5firrqtzDUmI7qHU04kqXRIHHL+cpDhl
 B6SmBFgsvOQeZoVVamfC8nsCYFOgbpjhTsjaLAfd3ut6LNYvKneLFck2rIcCijtr8BZs
 2O2Yh+aPQgyTG2/0Rie2z2YXxiwX0DrXibaheTdPAfPRcMQP+0C0vULJ+4TRg+PPVNFl
 hGR/51y60uAWp2iCewkjHJU9Qj+Q1uHSLb3zXVRE0U7YVtdeBkt6C40JaYLYXGe5qKch
 gT8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773958196; x=1774562996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/gKEjKxVm+m9damrsVkQGD9ojfpDVmGDQSqpLaxhT0=;
 b=hPr1e1dPIZGs+9O6uo464USEVmRJvVucZ5MRPSLc1zZRpEUha43RaAlSzN+eDlT3K0
 9fjr0WlqNrWR/N7S2xijcBrqnFdq9Rqh8D7L/nb/6rhJGT8cU2VzPFATOJLPKex3uEHf
 ub5cTCW9s+ck0wNIw7hSR8Qw4E5yty9NaB5bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773958196; x=1774562996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/gKEjKxVm+m9damrsVkQGD9ojfpDVmGDQSqpLaxhT0=;
 b=X8FVNKnVMgyL+4/C3i3Df44KiyFoi6z/9MJBrDrpH21DToJGMokH3sDIZ8uehhycUN
 Ru0+oUvyEkHm1MLIlN4LjNpo42t/96bHADW+yy57pQ3/pJ+922kCPda6JRJYulOtn9p9
 x10Fy1gZ+w271kufbMlZ2ABAXUN9IoxVaiq9orhP2pgEZwyIhpDnDor2DkGmWFO6WwDY
 CVfT1YBigfB0CQ6SfsjPfIoVNFB26ZiHiUQYGoRpaZcYD0cvSfrGt9oPCsUVJ26ulIIq
 91WBvF/z449lkXWZqRn0NQ0rfsolOu3HZi6v0qNQGFOrpvbJsupiuaHpXfxpSIOohz5Q
 xNcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyyb/yfyoTFcWRKPpaIb3HUCh5QcDcL8XvHS0pitYIxJF3/nFYRVwwTODKCR/Vqqugs5iiSSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxkeIRAUaDWw6oBY7WjEElZHCZei6ZsSQ/9kf8mxhajdAH18Dzl
 +Zg+in0sApupQC7SpEuoMW4XPRJBhyPBB1YFUymgZwozSzWTjFV6fiNiwPI+6UN8fNG3nGdd/tN
 BuPF0tqNfpGQjf98oWdb17OCsXhQD8/c47yP38WbD857Yh8wQdPbT+g==
X-Gm-Gg: ATEYQzym8cvwyJmb2e4z9d66QCbWVH3/NjpW4uNhg/8rfuO/KIJgNdVs2XGiOgdDOOd
 FmmyvVMVilHfi+4OwJH5Bq+/XYnGEOA+C4LoeeDTAx/ZY3AfJmvZfk0qUk2Iqizubhgb1ny1a6O
 10eX0sFfyanKY/uJefEQH/szH3y/j5si/o+2t/2efYHTETJRFM224ylSiiA9yjjli9S1lImoeGo
 TRUoyGZ75osAISMJIT0RlaPBciabLcN8Fn6JftyTfGcK0YAyY+MHaTuCbSXVN78qWbnkge5iZqN
 4T9AXfwF
X-Received: by 2002:a17:906:7947:b0:b88:51cb:fd65 with SMTP id
 a640c23a62f3a-b980f8f9030mr324035166b.3.1773958195513; Thu, 19 Mar 2026
 15:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
 <20260319162134.GV502704@bill-the-cat>
In-Reply-To: <20260319162134.GV502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Mar 2026 16:09:42 -0600
X-Gm-Features: AaiRm51iaVWXC3S5XvET4TPoIy6vgKQXTn8PdEXBZqLsuDwfzrdoZXKbOpWI4Gg
Message-ID: <CAFLszTixyb6AvgZ2NHMKzadHHDt2S1XPxEGvaz4zCoijuaFzJQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 dlechner@baylibre.com
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

On Thu, 19 Mar 2026 at 10:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 19, 2026 at 05:14:05PM +0100, Julien Stephan wrote:
>
> > Many defconfig files rely on include directives to factor out common
> > configuration. When running "make some_board_defconfig", these files are
> > preprocessed and the includes are resolved automatically. However,
> > merge_config.sh script currently does not handle include directives in
> > configuration fragments.
> >
> > Add a preprocessing step to resolve include directives in all fragments
> > before merging them.
> >
> > By default, the include search path consists of:
> >   - the current working directory
> >   - the fragment's directory
> >   - the default U-Boot configs/ directory
> >
> > This ensures that existing defconfig files work out of the box. Additional
> > include directories can be specified using the -I option:
> >
> >   ./scripts/kconfig/merge_config.sh -I <additional include dir>  configs/some_board_defconfig frag1.cfg frag2.cfg
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 51 insertions(+), 5 deletions(-)
>
> This forks us from the upstream version of the script, and I don't think
> upstream will want this.
>
> When I make use of this locally I do a two step:
> - make foo_defconfig savedefconfig
> - merge_config.sh defconfig frag1 ... fragN
>
> So, I am hesistant to start with to change this tool more.

Related, there are quite a few buildman updates which could be useful
here. If you are interested I could send part of the series which
handles fragments. I believe you don't want the 'extended board'
feature (intended for CI testing) so I could leave out those four
patches.

Regards,
Simon
