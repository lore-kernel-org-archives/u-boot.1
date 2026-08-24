Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E62C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 20:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D975B405D1;
	Mon, 24 Aug 2026 20:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMJdLTb6aHAx; Mon, 24 Aug 2026 20:01:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601697;
	bh=uDyMATB0fYNftyrVujf7hdc38xAeRjLR4R6R402Bp5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXHkm/Sjl1bYXI/ktSucWMofsbbBiJRkuAY32xw2wRphq/JVyELnr/r5rBXRmLEAR
	 fBA/tlMw6TkMRpGFGNeS/QKwQ0oSZA5t8CUEYmE6yscqf8Kh7iQWTtnQ02B/DxpOeg
	 f6quzNAyD3nKja9USbW1dSb3Q/0wYSWMls9pIcgwIB+HjiX1OjucuzbmKwSAMqQzig
	 0cTMyibU8kFDLxx8xqAD1LuB7dBtNZ1PoURtzjZGgAexZIc0eq2ufTbpaPys5HxIgV
	 wXQAAIMgjqMLH5rBNSRW85sN1U/IzkggaIjXGL31Qz2Q+A/+JDE1Qn57y2KPhdQ3wZ
	 do3S9YTJm/PLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0931440510;
	Mon, 24 Aug 2026 20:01:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6ACF29B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCDD080C7E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S7VfrgTNpyje for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 20:01:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DkFTd3Jo
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26816806FC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:01:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5378A60120
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA0B1F00A3E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787601691;
 bh=uDyMATB0fYNftyrVujf7hdc38xAeRjLR4R6R402Bp5M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=DkFTd3JoVcU1EMb7fWTyhV6LFxT4NxIkFOWFkgApWCg7ws5XwCsZxBpgpFbwj4ABI
 lxdhyyubFrVDlq77U8rmWDiAjmdGvYI/8q8LELf4yL5fLzCksiVCr9k8F7oD1RjML+
 mVPKaimPYyNcNmOAVaIYljhWKwoqloX8jV6qJwHV+mwX6m07c+WOG4LOHp+NSzyMRx
 YLyRxGNLdtdHric5t/EY0rlzkqNfEQ8jO76vWlgrHiK1vlQcAWGcGit1nkWg6xuCPX
 8QmEKjqAgo3SvMENXeNZJJtmL6HFWGRv7b7aV9nUNhS7l7B5RfksGynsfPTY1Y+YVX
 PhjmLkM1ZUlIA==
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-45ee4251389so2735416fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:01:30 -0700 (PDT)
X-Gm-Message-State: AFuF++mqWH9JQhG5PL1d9HKdqtIXO4yFMMh13DKJXPn7KUIlt6QhI8BQ
 ZasYn8WEwTLs6XYIO3KXAnejcQ/SZ7fBG340XTfepaf3RWm3dA47FJnJ+esPrZONNMjPIpoKRXJ
 K7dlrBuKNPRWjH73jhBcvjleMFllGMC4=
X-Received: by 2002:a05:6871:5d03:b0:448:888d:225e with SMTP id
 586e51a60fabf-4637ff098e0mr20926129fac.9.1787601690203; Mon, 24 Aug 2026
 13:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-6-07ca794e2b94@kernel.org>
 <aoxHY_tS5pVSl1_I@linaro.org>
In-Reply-To: <aoxHY_tS5pVSl1_I@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:01:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLkaoYcUd56iddL_5E+gj4nE89srPpiwv7zCD2PDgAa0sQ@mail.gmail.com>
X-Gm-Features: AcwNN1Whei5LRZAoKqRMNoxPTcr7aLMEHPtiHO0nIK9p91_daaT0X-AxzIMG4No
Message-ID: <CAD++jLkaoYcUd56iddL_5E+gj4nE89srPpiwv7zCD2PDgAa0sQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 3:30=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
> On Sun, Aug 23, 2026 at 10:39:25PM +0200, Linus Walleij wrote:

> > PL180 card supplies remain enabled after probing and while U-Boot is
> > running. They are no longer needed once control is handed to the operat=
ing
> > system.
> >
> > Mark the driver for removal during OS preparation and disable its VMMC =
and
> > VQMMC supplies from the remove callback.
> >
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
>
> Is it worth briefly toggling the regulator off before Linux turns it on
> again? Linux will typically need to turn them on again later during
> boot, and even if not Linux should be able to deal with unused
> regulators. I'm not sure it's worth adding such cleanup to U-Boot.

For our specific Ux500 target it is true.

But this driver is used by a bunch of platforms including some
ARM reference designs, and also booting other operating systems
than Linux.

Something could EFI boot off one SD card, then have rootfs
on another one and the original boot card undefined in the
hardware description for example. Albeit that sounds a bit
stupid.

So I thought it'd be more clean to shut off the light on your way
out.

But it's not like I'm married to the patch.

Yours,
Linus Walleij
