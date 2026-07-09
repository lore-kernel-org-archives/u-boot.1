Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EDCC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B7384C1B;
	Thu,  9 Jul 2026 21:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lz7FY6da";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A3184C1D; Thu,  9 Jul 2026 21:16:00 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C68A84C02
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6989c0ec3c5so306200a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624557; cv=none;
 d=google.com; s=arc-20260327;
 b=dqfem5qCkH8LxZ+CbYd3XoiTT10Q13Usyi06ngCLpgT454CZ74W2njWpfiAf8VYR/5
 BWOnUl7h24ITCM/yrh6koHx2o2Maj7/k4rBcrtQ3Xr58X8vq97xnPLSTAqhtXpgab2RN
 llcZFnLyI9RmWLiHU3BRMHjmolFVn3l1c1K2Rr7Mwdx6yiw12tvN2HfHgOx/cYGMNR5B
 0K0Gu12yV2t2N5XEyWVC1+o+zxe1Zjrk9C3SRBGH9HqnIhk2IH/89kLJqMm+Mqv++uwA
 9ZVRIpTbsFXYninkr9+AXfdWJMQeT5S7x3NYsxSDL85pDd0HfyrbLYJgyE+nK9UalSWD
 2HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dNGUhK65ex5uKOEmhkDYdu7iTe7dJp5E02iNhPvL3s0=;
 fh=TRuQGwbA9KeRCvIOx59fIDgqV1vdp2WBy4n7quHKbrg=;
 b=MtwdoRGgbaXRz9gNWZkZSSBxVUh68Ch37hk2JYvO+KlsHsEAwGZxB3QlyJX67N35JP
 NI7d3xw2z2qDBRhFmxw08A60Mum09LhhWG8ccjBhbErQAZOOb87XIdQtbiTQZxWz15tY
 oZw4WwWXxEMLJhdCGr+msm0dSqSa4G4N74z554JmtpT+0VrP3kURiKhGWJOzMR68ng9J
 qh0ZrM5g91PLAZE9kKahM/oEoFCur2aMZwiwe//8D68K/3qYs3GEXTtFlav4A/Rya1Ww
 KVDGEWREGYzGP/DBjMtBADfSjlsMvCaEGZPJJ0fo9DE54RjsJT2qJ1DYr+b5iIWaPLt7
 /DEA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624557; x=1784229357; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dNGUhK65ex5uKOEmhkDYdu7iTe7dJp5E02iNhPvL3s0=;
 b=lz7FY6das0UcA2WSXn59TuYGkEKjG0rbXZMNa7XFoZ3TeDUPtFXUpgGyQ1wq7RrTNt
 udoJFcqyqAM4g+G2FpUfpy/LHGW1kZdtSR//r9dTpb3hpvayFafEB5MM5OmvGBim7Szz
 9VT07cfT8uyBHNaD+n1CqfAgRJNXV/7thfshQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624557; x=1784229357;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dNGUhK65ex5uKOEmhkDYdu7iTe7dJp5E02iNhPvL3s0=;
 b=LiLn2oBs4AIAL2lfu+storIhPpTrl7baXp6BD//fz6MIaLVWW8NR37i9ww8rIL0W+4
 cHBLxUnkZCqIqwddTogXLWa5DREjY3l71jit376893cslmwYudW4RMtlSWWuDxslzoyW
 h/73pgDUIB7j46/ud93AenBmcFZZ2erhvgt4kEqKBoZ1l6dap4Yd8ZXRSvBikVY6npVs
 lM78+zPQC3Kz4nfln+eFEXsem78nls3rcyi3kARPuTiI+zYt3Gx/OYhBZfLyywNetFnT
 9tGJ+hNNKKBcgxRVYNrlHAa3PJwIxKO6FgnnaBEtGQxu1gbkbYF7zpcPAe3Ix7jM9AGg
 P8hQ==
X-Gm-Message-State: AOJu0YyemjCAcwyNvet7FJEdCCq3Mv8OBmK+754pS+qvxWbKO/C1LGW0
 i6KCj1aX1dzT3hIYBBS85qMvxV/XqYbYlwRwoc6xUbcSoxMZWPqaYDJ/grKDr+sMj3YL+2Z5qho
 NMatFdhoC+NZiEfZ0fxfNgvBteWSG2YkQB3lbaao0
X-Gm-Gg: AfdE7clZ0h1+TTANkMJUE+WOxShd9lElgqSpHa+gXPSbYkyDNHNqBahgkFICBJPrssL
 zxrAOAy3hw6W2n9op9+HK3/p3aOn4wg/BR8FWYhYWqyiDccuASyR7tCRiTaD6WpJZJgrIQiVyaz
 kdQHH2TtD/+b4nZhwTpk+bmRSA0e7+9WBnaH78eZa6WjjPRr2R9B7q2i4Nz6UTVEJCHUOVzHxRf
 fHCcTztjiHCGDEpqIf/WuPBp/47bxy9Tu0a9N+nDFCL3km3YYpFwObrIAa49j/YYzfCVRPjW1/5
 zV+DMQ==
X-Received: by 2002:a05:6402:3202:b0:699:fbe4:16d0 with SMTP id
 4fb4d7f45d1cf-69ab4478684mr3503731a12.16.1783624557565; Thu, 09 Jul 2026
 12:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
In-Reply-To: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:15:45 -0600
X-Gm-Features: AUfX_mywG6-xNPZX9PfaASLXsip3BeHqlyh-bTiDfd_zlKisxzBU_Qmm2hbhiws
Message-ID: <CAFLszTjXkx0Jw0yjNXXwdXrQYre7Lcs59m_Bc27QW0n0c+WaJw@mail.gmail.com>
Subject: Re: [PATCH 00/12] MAINTAINERS: update entry for ARM ROCKCHIP
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
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

Hi Quentin,

On Tue, 7 Jul 2026 at 10:09, Quentin Schulz <u-boot@0leil.net> wrote:
>
> Simplify the ARM ROCKCHIP entry in MAINTAINERS by making extensive use
> of the N: regex. For some reason, it slightly modifies the list of
> people returned by get_maintainer.pl but I believe the ones reported as
> maintainers are still correct.
>
> Add more files under the ARM ROCKCHIP umbrella.
>
> Remove inactive maintainer (Philipp Tomsich).
>
> @Simon, since you don't have permission to push to the Rockchip
> custodian tree, I was planning to remove you from Rockchip maintainers
> as well to reflect the reality but since you're still an active
> reviewer/contributor, maybe you would like to be kept as Rockchip
> reviewer (R:)?

Since Kever took over I haven't been doing PRs. As you say below, it
has been great to have the vendor looking after this.

I will likely see patches anyway, but keeping me around as R: sounds
good to me. I have quite a few boards and I hope that RK3399 VBE will
be merged at some point.

>
> Add myself as maintainer.
>
> As could be seen over the last year or so, Rockchip support in U-Boot
> has almost ground to a halt with Kever only being able to find time for
> his maintainership every few months due to his responsibilities at
> Rockchip having changed.
> I would like to express thanks to Kever as it is not that often we get
> people from the SoC vendor actually contributing to upstream projects,
> let alone maintain them. I'm hoping you can keep helping us especially
> for things that aren't documented in manuals or for odd behaviors. This
> is my reason for still keeping you as maintainer for now, but if you
> would like to be switched to Reviewer or dropped entirely from
> MAINTAINERS, please let us know. I likely will automatically switch you
> to reviewer in a few weeks/months if you aren't migrated to the new
> GitLab instance and thus do not have the rights to push to the Rockchip
> custodian tree.
>
> I've reviewed Rockchip stuff for a few years already and my current
> employer has all its products based on Rockchip for almost 10 years now.
> I want to be very clear with what to expect from my maintainership: I am
> likely not going to spend substantially more time than I am today
> reviewing things, I'm essentially just going to unblock the merging part
> of anything Rockchip once they are reviewed. There are many things I'm
> unfamiliar with, so I'll likely ask odd questions or clarifications until
> I can get some basic knowledge in new areas.
> Things aren't going to go faster by themselves so this is also a call to
> action. If you do find yourself frustrated because things take time to
> get reviewed, please consider spending some time reviewing or testing
> other people's patches to help with the global effort. If you do find
> yourself in a position where you can spare some time to review or test
> things, please feel free to do those things (be it for anything Rockchip
> or anything in U-Boot really, or even in FOSS in general).
> Finally, I've never been a maintainer and I haven't really figured out
> my workflow yet so I'll likely make mistakes and asks many questions in
> the beginning, so bear with me and report anything odd or wrong.
>
> @Tom, if/when this gets merged, anything needing to be done in the new
> GitLab and/or patchwork to get me the appropriate permissions and
> duties? For patchwork, I'm already registered under qschulz. For the new
> GitLab, as quentin.schulz.
>
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
> ---

Regards,
Simon
