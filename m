Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBABAC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75CE84C3D;
	Mon, 13 Jul 2026 16:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O5+F6jaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF7C84C3F; Mon, 13 Jul 2026 16:24:07 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECC784C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc7so1298624b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952644; cv=none;
 d=google.com; s=arc-20260327;
 b=Dxoa47mfjEL3oJNQnMrRmPMlCLgEERs8w/LC9ZsOgvSMnV8hFnhUDoQzTYMP42Y4wu
 4dNxY7WvyMJ2Dw7SUVF6nt6LtzlrHvioG0fnHb/DcFDI6yPU5bpW7RQdNoefVtfGRMma
 itaZlwvLvkRYeCSjvXNgTgNnaeXQuz1Cn8+4K7lx0DH8pa7yCFi+r1b7xX37Dq2kx0CG
 zMBJjeBZ9hvj6fFwZr2CrVY04IvMaHlVJugWNmo4VINdTQG3GiqLTCBpGEvQ3pzq2U7J
 MbEPKhnbt59lUg/xx2TKIMl40evdfqzxQXOWwh1S9qZFO3mRLLCTfdSjZpNjsNvId8tF
 r/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MUxIkEeDeTeR3R/RJCgB1Ql+ZlifuP8hZXwx6ZG36EQ=;
 fh=qUOps0b6OtTg4hWAo/UhSwr703HeCsU1mPNp0+c4VNA=;
 b=biNIQUDi+zt/ze6o9w5ru4h2yBZPE2z6v21X2T/iFuallVQCIwU1bhUJS1pAInWisX
 HAFRodMCeDbK2nXWgVGCNFfZ60d5fm9VtK/OKHJ7bNvfHyoTYFnAi09QCWZNVGvGQ1kc
 BgB24CptEQhW1jDztNnfAh8THT4tMCh2/I8kNGwXKGwt2nS03mWGL6ZpL5K6V8fws9pd
 1w9Nsc65uFGlbUygzAgSqizuFt9+nnVfT+cjfE0k8bRqn0nYo5azgcrra0vYgiWTNqC2
 RUE8b4NhO4k5LuolwLFuwPo+ooc8ek6bd41GYmIOr8mwWiEJ4U7hoOwGGm/0iUn358K7
 0p1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952644; x=1784557444; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MUxIkEeDeTeR3R/RJCgB1Ql+ZlifuP8hZXwx6ZG36EQ=;
 b=O5+F6jaS57/VAzWI5IJAJ/e8QGcSoFS1DsDrvwzqcS9dsGKtHWi0miG+Y+WMlqWQne
 PYrKjvLzcvJYsSIQ3CoqkWh7uKecHENePD/fE+5+qiBltXfrY7ssiO62IdJfW5zBsVyC
 MiCjK1JzKaJ8z8Ez80b9kbMRyGk4VwxF+Mi78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952644; x=1784557444;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MUxIkEeDeTeR3R/RJCgB1Ql+ZlifuP8hZXwx6ZG36EQ=;
 b=g2k/1k20cnPeiSikuCgiN6kUcyIQmnFcB8mZQYPwp3/TktilkXAQSemfP3RQb01VER
 w2Rz3I380kLoObc9Gx6HPh5WT0Jrn2HNcDjyGeHH7J64DN4ZHO9hD9s2prM7u2rk9NnL
 0pVGdXt7PPmhdVb7D63eOx+hDVDWAOLN7Mj1hHns5mF59JFkll5JKWqofivcxUkpS5Ba
 gobmMtBVyfa9gJ3bG0WP+MJW9ANjZjts7sHC7o7tbUC7GbUkEDhaADnRsED2HKTKj2bB
 pFs30x58Aqmpty2rMsy3UHaGXaDbu02ElBP260rzhNS0gQi7Z3OZUpwxt9hYabf/vJYm
 6TYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrrs2BsrI49Sf7ZhgjlvWttufeh/fw02w+qb74Qrs3HqaPgLiemHSthb4f2FLCUlnKiF+rtvk4=@lists.denx.de
X-Gm-Message-State: AOJu0YzNc0w5hEW1kBGEmobfb0IxytSXSdYmiY1LWKVXcnA9PAfztmW5
 4lPRwz4dBQM30EOMAFD2OWQqsXdcUwvIwxByPoblmt51h3uRDJZBJBbnhWXVupJzTJP5ANUZg9R
 h9ivdIEpvPqIC5jZOL4mkvnm529WhYi3sX4hcskU6
X-Gm-Gg: AfdE7clmu7YsMlrsMfk8A4XDQi7Zz+i2i69VPFmtq7rYT6EtXixv9xQ2yuDe9V1VN93
 RG+iWMe0Tf6O4RV4l79CEcsLoMsRxSbrcvyPStlV0zVcU+EPQwT+NItB18LCpJTA9DyB7wehrVC
 IeRC4xcE0gJ7TpqzvTydIgNWEvywMqwpLyzeVHpTH4K/i4m262ELdJmwiJphVLGYl3tNr7gFO1v
 p9QM80o5I82NOwplKVuATXCEr/yrgY8TxMrDcbvHn/dbpuhw9/lSBIdwRbYucBu+psgTjM=
X-Received: by 2002:a05:6a00:1c87:b0:848:4b27:36ce with SMTP id
 d2e1a72fcca58-848897efa11mr7967750b3a.73.1783952644120; Mon, 13 Jul 2026
 07:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-5-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-5-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:23:36 -0600
X-Gm-Features: AVVi8CeczxS5ue03L8Vgf-bdEWqrv3Jl_Ekj5HXttWmaE714VfZdqs0nZP8fxvo
Message-ID: <CAFLszTjiW=9yGncr7DmNDUzx9EOkbeYLxhK3=ipqr3qrTo5Sgg@mail.gmail.com>
Subject: Re: [PATCH 04/11] x86: apl: fsp_bindings: Drop redundant
 CONFIG_TPL_BUILD check
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> x86: apl: fsp_bindings: Drop redundant CONFIG_TPL_BUILD check
>
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> arch/x86/cpu/apollolake/fsp_bindings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
