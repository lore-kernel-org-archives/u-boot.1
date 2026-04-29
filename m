Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A295FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77448848BD;
	Wed, 29 Apr 2026 16:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VdHPhGH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B25E848C2; Wed, 29 Apr 2026 16:16:48 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB61E848BC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-672c12e95e9so17659478a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472206; cv=none;
 d=google.com; s=arc-20240605;
 b=WfvSew5lxP/dRFA7Pz1R2HaG1KXOxLRhwewq3eiDxo9Sk3LlWii8wbB/DLnMOEPBxo
 tIT8Cv/qmamYM3eYgoH61Tl1+Ca+04ScpVBK4pUZ4x9XTjRmHrZEEkUKfh4Sr9i3WS8v
 BV/Yy5fSvjrXBXbly1e+swKeLHcNtv/11w0cMB6sYn/6JZvNdnUx9hREF/QZxScMHPFe
 a3R5MSKQZxOcDg6IWwf+1wClhr5L81Cj5EJEWCzOOx/CG9pBcapx3KYySOkdApYKzXKL
 hS/kZtjiBANlTbDhB3sZ3WU/z0cu2H9z5cRCbyZXdejCqu41GlfcQeypQd/DeRkyuTDi
 Xjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y2fMrtrTwedt34dAmjyMdD8a2DD6DkWSLjWBYBcTupA=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=WK5ozZ8yTyrewn8AQrxo03rw0o/N5vlWk7kjnYiRTh0ueEY23QsBE6/rnJQbYEazjW
 XRzqi1XXGiBabj1BtvfRiMuh4yW07ECm1fQOfctnLn8umQ+7eSWyNuP1RsUN+/Fm24Ex
 YtBr2q7H/5c+/6BMWDmCqOSq4+RM2m7VfrbA4+KlipvP0DSiFEDUYk4KbZbB4WgfMDSf
 eIpvfQzaw4yqzlro9rvlbKwv9v6+Yc575FeMtOHInrHOCW1sxRGX7DoqPYsQhXqd59X4
 +odazC7sjPCD6nzZ16eMofNzTc/l5zodjueF9rqY3+tL9P61eW26yy8NkS5xXLylNX8X
 ghwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472206; x=1778077006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y2fMrtrTwedt34dAmjyMdD8a2DD6DkWSLjWBYBcTupA=;
 b=VdHPhGH9/y91ycQhheJY2Xhuw1S8/AqCFbyf7DpOhYg2a4DIZG1uVFoYGvW7fxMIop
 NrAnWUn4P2oi1VNUhbGDnzkbiBCwzexo473QTAv9/hf+Vkb+eN134Hn2MGmBGQ0r3d1L
 6UpKgQlKSsi2z9WiKwhHrH1+zZ1ar7bXqn0sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472206; x=1778077006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2fMrtrTwedt34dAmjyMdD8a2DD6DkWSLjWBYBcTupA=;
 b=tLtEnWH4GnWw/0ulQ9RTmKPnFuqW3kz0lEcQybIKwWBwRfWA+wiXHdH6D5Jb3yh8f5
 odlQcAhccJmeyEFdqfTYlb4WwlR9L5P6u1WAOzVaX9WTj54sU6n9QN5/TtAFhJ+OlwA3
 oi+MAhjq2123gqvlYvrP4+P1G2pO04X94Qimwedw0CzIBK7LsCsiIzmoyf5hzA4Jh1LD
 ZQvaKLQihMXfmcu5quvvYkCQX9o4+7yyvj934Y3algQEZRG8LajYSQI2siLZAGaL6339
 UjRNxk+e0giemSZUzXWbBAWwCtCm0zvnmase5/bV+rqcPKauG2jJc07l4XdfMFOP2P76
 Et3g==
X-Gm-Message-State: AOJu0YwyfUWaWyUVKxU/tXdBp7Agly0gnVpHGMVfqXWGGSs0Bwiom0G6
 apC5zOTExBmINaSqJi3eQiQkMaGgD2UWBYv43HvOhilzRVQeDg3ugeWGss8ArAvviHjyxuJm27K
 MNCVUgrJYKS64Zsl8C/drDLZpQtFGoDXtezYUUGe8
X-Gm-Gg: AeBDiesBY9m/IYBJswu3Y+uT3G/a6BgkO7e6o6chtmmoQQ2dE80dSfBmKbpPuOdX0fO
 Wual8BO4M7nvPODYbIKsYa4qt7BLAhwnfHTmUKdPgaVePs9c38GqkNA6F0CLhwV9M/fQZPzidmn
 6dM1dsAxZVee5rMU/rAWlgrUFfSUdOQaHFn70cinbmh3YVOXuCjwwVwvulw3XTyrc3xNSyAB8Xe
 ol34E+bmFcEELA2pjphObdH3GetflrYL5FJCVK3qxTTnqT95Bry1Gm73ZtJWpb/Y96BDselOtt0
 zRIq7y8QopOgDNcr
X-Received: by 2002:a17:907:84e:b0:ba2:6e21:e591 with SMTP id
 a640c23a62f3a-bb804537cebmr454271466b.35.1777472206096; Wed, 29 Apr 2026
 07:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <2294454ca0c4c4ba0974868d9d8b8d51e92ecd8a.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <2294454ca0c4c4ba0974868d9d8b8d51e92ecd8a.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:16:31 -0600
X-Gm-Features: AVHnY4KvkPZ141eqk9GPmYM61wFYaEpF_u_pUoLeZmwom2dGLuyUGozzeF-0O6w
Message-ID: <CAFLszTizjVWoLnpZf=RxGB_A1EqW=O0YKshJA2_GNPkT1hNT2Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] mach-sc5xx: Remove unused image offset Kconfig
 options
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
> mach-sc5xx: Remove unused image offset Kconfig options
>
> Remove SC5XX_UBOOT_SPL_OFFSET, SC5XX_UBOOT_OFFSET, SC5XX_FITIMAGE_OFFSET
> and SC5XX_ROOTFS_OFFSET as they are no longer needed in the Kconfig.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/mach-sc5xx/Kconfig | 24 ------------------------
>  1 file changed, 24 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
