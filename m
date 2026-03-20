Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EFB1099B3F
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 21:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A09EB83CF5;
	Fri, 20 Mar 2026 22:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZTHwKlzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB1583D71; Fri, 20 Mar 2026 22:33:09 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6927883CF3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 22:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45f053b7b90so1550966b6e.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774042386; x=1774647186;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9SLqW/6h+p1i5wcW95Dk/s7NQoA37p+mdu+64V0rgI=;
 b=ZTHwKlzR0UVJKlPFfDA+xGoEPwXRiusNe4G2kerP0bIHRKGjz/1u1ZpGJ5ATbKOfPl
 U9fnSAfhvwq+XNVrtPW2s6USHEZMWkFbV7RPjauMQkXOqtWQnqktKQthvh6hWb3WUBdm
 WQcs2p1y2a7ggcn8/ujPb+qwPXxl3jXySJwJRADotpzAd9cNmNo3sg2+ckknCt8yAXLC
 XhhGPjPscSWIQzZmyOsVnrE1qdURH2GFseJbhlcalVV5f6cZ0drgPShgm25VLysZ7ih0
 GhkriDkJ+TtMnGPl3/S2/jSkFbiAB0w7FdF3844I3/KR1ZVS1vOT7BVZp6qD9XW9cFg9
 balQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774042386; x=1774647186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9SLqW/6h+p1i5wcW95Dk/s7NQoA37p+mdu+64V0rgI=;
 b=WqKTy6osCMAyEpZBVhPgd8YldcDWZ9bOBpzqxT6nVh1+nCOo095Bb1goZhjHLBHp6r
 +q6tVeTJU1RQLH6ZB9xP/kqPUficQgCYL+iJNeRSgUgyvEcjZH7VfZw59WEFq0HnbtYy
 SvK9rdeMx9hR3yJrIVqEFvccNfjmp8557WHykqitPui6tltCTrSANVs4WAnfJgA9K6Rx
 vEzoflWXAGZhbw5QfoZ0vymVUtA8vRLjP/90LAZdGVkeNfwn8ntnttbbkpV4Nh9gq1C1
 0odd5RaIA2Ix0FZPiU5egqN5SMu2mcdApqKQrAuhdF6xwPb2rQ26cmWIEA+q9BQfZSH5
 Kljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtiIt911BJxTSwOVj4wj0cxHI4Btjy8KDzsQt9ZYbTowQbqK69pYcCM4Gp277P/hPZpYZrQSs=@lists.denx.de
X-Gm-Message-State: AOJu0YwcpUIIW0s+PspSLabBhKzEjEQV7t1hu0JZuB8NkpYkx4Ge0drE
 vUHA4IdtoomknPKQu/98lnmQ3yDex1pGD1olaIgWOK5+hG4RIUm7C9uBqXpBf83I9hI=
X-Gm-Gg: ATEYQzzQGUDLSsAQLpHzJojhOqkX8SJxo9q22F6M37eDwQovuGXNJ7BaBIWp47amDcf
 RUQwlhOhKjYIjShuM/vjrhcjjckbqbmwbwo2n9LwAgvy4raOE5YthBqM8qqT0UeybJkr+0Xmzic
 jXLP2yD+XIYR3syaQlyrKoIdQDhvhe07cgIdIqTjKy7FjS/HGOIjx6TlMltYmiPmFENvC/lvNdN
 ZfFzEFEmrpkVJuCs3dUmBI3y6wIw0Y4OskOiPFXCjBcUaCyI3+GLWHD59TxIb/315niBXEfq7j8
 fjuzvzjFrSDTV+wBp3FGMR1eIYa39GjRdQAmIOyIA4Kaw2AfRklsZu1hhzqc6wINdXV46PjhPmi
 XKKCXJe0EatYBilV4tzm6y3bTRs+CtPi3MVuwP2hnnembOqKsXD5H1PPkBsy2GqoYWeQVPE+WIE
 WTq0z6D8HpuobZnRr+TMMOYjHoAhskPRz8KbrU1IKNd2RKaR69GqnyzDQPrEhiq8Pe2lFsE5E=
X-Received: by 2002:a05:6808:13c7:b0:466:f6ee:5bce with SMTP id
 5614622812f47-467e5fb5ed7mr2967383b6e.56.1774042385994; 
 Fri, 20 Mar 2026 14:33:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a3c:6fc:3be2:208d?
 ([2600:8803:e7e4:500:6a3c:6fc:3be2:208d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d64fbbsm2677803fac.9.2026.03.20.14.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:33:05 -0700 (PDT)
Message-ID: <9060e287-9b77-4051-b378-c68ddba4fa65@baylibre.com>
Date: Fri, 20 Mar 2026 16:33:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] configs: mediatek: rename genio boards defconfigs
 to match the device tree name
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/18/26 11:45 AM, Julien Stephan wrote:
> Rename the defconfig file for various genio board to match the name of
> the device tree. While at it, do some cleanup:
> - introduce mt8188.config to factor genio-510/genio-700
> - remove useless SYS_BOARD_CONFIG for genio-700
> - set myself as maintainer
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Changes in v2:
> - Split the initial commit into several commits as requested by Mattijs
> - Link to v1: https://lore.kernel.org/r/20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com
> 
> ---
> Julien Stephan (6):
>       configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
>       configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
>       configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
>       configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
>       configs: mt8370/mt8390: introduce mt8188.config to avoid duplication
>       configs: mt8370/mt8390/mt8395 add myself as maintainer
> 
>  board/mediatek/MAINTAINERS                         | 18 +++++++-------
>  configs/{mt8390_evk_defconfig => mt8188.config}    |  3 ---
>  configs/mt8370_evk_defconfig                       | 28 ----------------------
>  configs/mt8370_genio_510_evk_defconfig             |  5 ++++
>  configs/mt8390_genio_700_evk_defconfig             |  4 ++++
>  ...k_defconfig => mt8395_genio_1200_evk_defconfig} |  2 +-

How about also including _emmc_ in the name, like:

	mt8370_genio_510_evk_emmc_defconfig.

Since we will be adding a _ufs_ variant for all of these, similar to [1],
then it will be more obvious which one you should pick when booting from
eMMC vs UFS.

[1]: https://lore.kernel.org/u-boot/20260318-mt8195-add-ufs-support-v2-9-f18eeeeb0e72@baylibre.com/



>  6 files changed, 18 insertions(+), 42 deletions(-)
> ---
> base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
> change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e
> 
> Best regards,

