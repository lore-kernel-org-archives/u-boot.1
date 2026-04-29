Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F7FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EA7848B6;
	Wed, 29 Apr 2026 16:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NdpYhxIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37896848A9; Wed, 29 Apr 2026 16:10:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC85E848B9
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so8809880a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471803; cv=none;
 d=google.com; s=arc-20240605;
 b=BKDpmbyUJOpQQlh44Aj0mLzHbUiCPuLhZzO+dfCkzR8srtjsV5UbDlIZaM8VGq/dEN
 k1MOlgp+CKnid8m5GlfosJYGRgb65evXm3Z3WhtU6oyyoKVHdIwo97k8aX/Oki6iW7A6
 obhiEYIjOPWIAp+IbYcb+yUrmJuq7g87HFqKNxlbKLWq+NMZLhBSDb8VLX9x0CctFOnD
 oSlBfhkEJSDM+QGRd4W5V808MaLrrQG8k0k7ui4hA1I1Roep3S3GVPEhHEXPahQoksgz
 Ida2FIKgPY97KewsNAwxyJHUB9G/L4QMu9iIubo35Y+d/IG99DUUFhXPje70bfQLJyvG
 7TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2ev/ibHGfeHeNLuI8oj2tylKX3KFGnjhSrHffZ9+alo=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=jRb9FR+w+b9cvguIraSwrkDunzFteUMTSPiTpvHbS+ijJn61WQXIUEly3crD2K3OoZ
 gtQ7KTyFZP+kVcz7O/+OkCHUW63rHeOxlE9RFAIpe6qFSWv5TlxWHO0oZ2DH0wRItFMn
 /iKwMWPjOPcpDc7rFUiUENZK3KSfkaHVUKNs4n17erhlXNo68CeK+QbszzEZSi860ay/
 OffZAaMdUookEHZRBt2oqxyksapwE3zn+aMfq/Z7ydFY07O27zNWasX8VUqGAoklNY+u
 Fovkwi09pTiOXjnoG0nLaRiqIoYhE09XTaDKskG4KFrrlUaR2lg+6BUnUPh5FI2EfyWI
 cZWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471803; x=1778076603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ev/ibHGfeHeNLuI8oj2tylKX3KFGnjhSrHffZ9+alo=;
 b=NdpYhxIh8svY+vT2MbPz+NFKdjPU1J5fzU2mS4GfX439skWG/EmQFYu2fWpD4SC7ja
 ScM9ahlzeNDXYPhk/AbuBjPu5oEHVCF/9snsVJ8PHBDLP0hfI72DPEluwnKOc6g1noe0
 fWqpqnzpgdO8IFWwCkuJBE7ydsBDBy8IxBryw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471803; x=1778076603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ev/ibHGfeHeNLuI8oj2tylKX3KFGnjhSrHffZ9+alo=;
 b=PdM11lSXtj3jsHYMd3VIAFrx2BRYqWVukJjld/7ac4km/8cVWcktXbIfbC4TZH3R28
 GvQad7qVN1xJvpUQdmbySrSL5vutZdrm/hXqgMCo5W56yIsBnvK387p2Ns+4aSyD7R+p
 X76PRcFXn0IsNuGHJ4+B1cOm4zsfWeu+gA+TGSMOdCHOLQSyRdvq6pzFuQ+ZBsUA/2lk
 dVmqN3f3Tikcv9Gwy6WZ5ZgtAi5rPG6ebksFyI3DFZYDdEyIw5KmQJLl4nJq7EvJfEo6
 N4yqnfiSB4EkUTt5ApftY+4YKWF/y5x5bV4RM2BlsvhFUiSEi/ILnUKeGA9pqrCsJ4gG
 y64w==
X-Gm-Message-State: AOJu0YylibGJe9k4KPym1CasUnH5GbXlO5XLW9Iv8ntY4upSdO415GIS
 FHANgnrS5ybHpq4vXbCZrxdKCaVz4TU2HjlCUGhfmdXPsYBvtcdOoMcaBASoA3gC1kkHjlz6l9t
 e9Wlz20sARWaBgZLx6gFIAYd9hnNEj9KUXKBklVx8
X-Gm-Gg: AeBDietQCRCAExkqW1KAqkt2AveJhDKvEWrTNLsFcfCzOin+9JF52abs/OjvxQB37Um
 xPSWX7XxhtbX+5gHcwGBtmvk3IeWAhF7w5nCYL2DXTgdOwZW1EB5IPFNWn5RlOZaXhPZIamLmWi
 M0ejLyynzxeOKpg3qWlx3sKkXA+p9E0LIE+dUC61TdU3EiC2sfPTK6CkDm1Sn8+2lqK9pUB/gD1
 3jZFKy3DPoixg/AT6yZxNfv6XFtVXgHVV2YHcUWZPNaUIq/A8Fv/sstbpWZBuFilQbxQYEPorP7
 fnzoBi9XcPoqIDKb
X-Received: by 2002:a17:906:eec8:b0:bb9:4595:ed5c with SMTP id
 a640c23a62f3a-bb94595ee53mr246941266b.37.1777471802746; Wed, 29 Apr 2026
 07:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <560a57b3a3b35fed59a83e07378c1c9533351951.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <560a57b3a3b35fed59a83e07378c1c9533351951.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:09:41 -0600
X-Gm-Features: AVHnY4LiXukrUGyM6CBFUmDIYr9lGADOkIPlpltH9JD3UT8PHXwn2vvUIi3d4eU
Message-ID: <CAFLszTjPa+rYddW4wVJQK71Nx2_FHrf4Fo3ABzDE0v-4znR=yA@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: sc573: Rename EZKIT board to EZLITE
>
> Rename the SC573 EZKIT board to EZLITE across the device tree,
> defconfig, board file, and related Kconfig/Makefile entries to
> match with release naming. EZKIT was used internally before the
> official product release.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/Makefile                                             | 2 +-
>  arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts}                | 4 ++--
>  arch/arm/mach-sc5xx/Kconfig                                       | 8 ++++----
>  arch/arm/mach-sc5xx/init/dmcinit.c                                | 2 +-
>  board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig                   | 8 ++++----
>  board/adi/{sc573-ezkit => sc573-ezlite}/Makefile                  | 2 +-
>  .../{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c}    | 0
>  .../sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env}             | 0
>  configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig}         | 2 +-
>  doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml                   | 2 +-
>  include/configs/{sc573-ezkit.h => sc573-ezlite.h}                 | 4 ++--
>  11 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
