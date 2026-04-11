Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E164FE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1FA84223;
	Sun, 12 Apr 2026 15:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RR8O9dIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9DE84181; Sat, 11 Apr 2026 22:30:53 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67F784118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso3044810a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 13:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775939451; cv=none;
 d=google.com; s=arc-20240605;
 b=A33VuR+wa1EPA51UFFLl77VdM4nLCgb1+5TzSju+ZWXdewbhFGMGm9Mow7QNLicwbG
 8/zC6ouK4mIgbaQJZj5HM4KbUxP7YS9MaENMeVqXDycS1Xp5NPqo0vaXiKYAYicGYeO9
 yWdhyYu4zMSMER8jIxqz4bZJirr7afPpVZoCAvVXpQjQFQgQwJ1nRsJkzS2s9ftYDnq7
 4AihaY8NahHFX7cKbPW6ThOUFIERS6qLJBo/80ThfR9f1kXYK+8uzIJWi5/cpadVPH/J
 kxrW8qntYZ6jJ4RW6V+vCaHUFCF/3OD6cCWOfo1PjIzohPyz/4klxRxYn6/URsg77EQV
 R55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5CCO/Izxk1WHhUY/5yHeJFc6NA6XouOKFnvJrQ2m4XY=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=PPL5+1vYy13Traf1Jbyq2v1DfVJT4k72u58Fd8nWwaog8t7O/3WgaEORNOaofxyrpJ
 luIuIpzQinfqYoqjaU2T0wSxHJTO/5xk58G2TrGCyVkqy1xcnsIZ++1u+btAC1AaWXGC
 zyc2NIHVl7HYZMHLPkjLDMMHuMTFrzSVKMT1OB1u00+/aNTxDgpWtGBKamxB43fnkPyn
 UMKLx+w689z7MLJRhcL+Iu9UUuH6FJ+jNDprWzObJiu7MvhDO5sc1gBHuV4METF9o9Wh
 zSaNVor5Up9ZQQbcU7rDrmgsQY7ZFnZVX3xODrtlHd12t88yHfHmbWFTEFQois5IKPVL
 x6yQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775939451; x=1776544251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5CCO/Izxk1WHhUY/5yHeJFc6NA6XouOKFnvJrQ2m4XY=;
 b=RR8O9dIg7HU7Ka2t1ntwqnMlm9O8ZsIe70Ln+huRZerzF9aafQ0ELdjRvs3ipnwyb7
 4j6IMeYbsKX2prqa8OXU3Ond65C/RNAV38NoogbSS2B8KakQiD+d45bteXcDNJdJa7on
 ERBbv+WP0XHecdSSpBCLKqjjr8LRtr/Pj5sBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775939451; x=1776544251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CCO/Izxk1WHhUY/5yHeJFc6NA6XouOKFnvJrQ2m4XY=;
 b=l5QgaxRJ2at8VwLfNZZQHexM1XdaMgzO800d0eWwtY7rFqHDmchtkpVIGhvUmk9AFu
 yFyWEUAKrZD2j2xdMGwBxsjob3PQwW9jLgCCCtR1Fvbp6pWKLsxa+ZXPZbG5U4ObLBbI
 bTCqRyOo/MqFI4Ns1SSWm36k1YAs52zySRA/fpb+kIMzvAYgn487hVLlwNgBjtvwMkLV
 tfP/K7fK+Uo2GD8RoWBrcf9qz+rdu/qU2KjmoqE/YKcFBMmnUrDYQNtWp9dQlSa5ayoX
 sF01slUfOZKqGk39tGl3YYv0/zlhelVwNAggdg4k30bfurREIO04CX6NIpmOvE7ufnh2
 jFoA==
X-Gm-Message-State: AOJu0YwuTrvP71e6irZMHcPkePnuqRkByj1OC9rUjAmom/7oT99A+fw/
 Nt5k+MmqASttZQeiWF0XfPpMADxg37es/XjouCVG61r0vqYX32TFC6kaQaQwPIpFvXO6iufYVe/
 1BwAvOurYDHNnO/pe4Xko9xY0AGy5hp5yZE+abUoe
X-Gm-Gg: AeBDievkY5xHUcocbg2Po9kC8lyECXq72d+YusZ9qC9xfXvDLyPGfJrir0obKbm73rL
 hnacuP2FEUVmS9iSuYArQJGeKynCwnkA+GltIfWGS5MLu9cMFUd7iEqxmL63xNgyflqJ6MDtKLU
 YEkvLEeRLaVqZ02Gmo0cbQZwjovxNHFTgnFt1tzKDpR8zabQgFayMIJDiwBuXH6gMRfqox/1Vih
 Eu8YwM4SvB0jq2r76THlN1PzrlP8/tMUAhE2je/A3ThU9k3Q0f0nPKULZLjpUiucB4no4MUT3CT
 Xztu+A==
X-Received: by 2002:a17:907:a46:b0:b9c:513e:34db with SMTP id
 a640c23a62f3a-b9d72635a40mr493501766b.23.1775939451048; Sat, 11 Apr 2026
 13:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-8-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-8-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 14:30:37 -0600
X-Gm-Features: AQROBzBtIpUs5eEPkuYZ59-Pt2KA8F5CT9gzWEmJbylSbP-MGHJNNfQfbBywcZA
Message-ID: <CAFLszTg_yxJj8RYV9P-qFJd70npM7gei6M163VSrAQpPKMoo5w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] mach-snapdragon: add board-spl.c and split out
 common code
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: add board-spl.c and split out common code
>
> Code in board.c will now only be compiled into U-Boot proper,
> and the new board_spl.c will only be built into SPL.
> Code in board_common.c is common to both phases.
>
> Also split out mem_map.c, which is currently common to both
> phases since it seems to not cause issues in SPL. In the future
> it should probably behave differenly in SPL, especially if dram
> initialization is supported.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/Makefile       |   8 +
>  arch/arm/mach-snapdragon/board.c        | 358 +-------------------------------
>  arch/arm/mach-snapdragon/board_common.c |  56 +++++
>  arch/arm/mach-snapdragon/board_spl.c    |  35 ++++
>  arch/arm/mach-snapdragon/mem_map.c      | 318 ++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h    |   4 +-
>  6 files changed, 429 insertions(+), 350 deletions(-)

The commit subject says board-spl.c but should say board_spl.c

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
