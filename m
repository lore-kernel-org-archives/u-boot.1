Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7948EC5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D3F380BF7;
	Mon, 17 Aug 2026 20:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLm0XZhNOqGv; Mon, 17 Aug 2026 20:55:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5210D80D0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787000110;
	bh=plVsYeA9q0jaxoKN9LIHzE4FLn0EP/5viDpMFIJuqSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G6z2cihzvD/XQ3sK9HTqe7/hPTWe337EErDbvhSemwSDPSCWTxn5EtvgfdpcQNu3B
	 TDm/48YrrL0wLFki/QxIdhqUkF9xaFMDL7EPfTmjs00/+gTFEZLSFdLadkzZU+8Glz
	 GKLovcX1qjNAwzEL0w+0fvl2Z6XNLrvqdz7mS3FVv1PeoPXe6S8ST1QJsdiTLPNyn8
	 AxoQe67+6miM85UCv1LPAdnuuabiY9SaA2EjTk4hXTlnnDT1hocakigJG3WgxWBrxN
	 gwhxqAy4TNKvw02E6rabN4UUNkPSppNX6SJ+He8WM7iL+fNJHc63EbD6/5r/tOPgFp
	 OwmAxZQv4gwEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5210D80D0F;
	Mon, 17 Aug 2026 20:55:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AB98282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80C8040802
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id clmpmCNKKNby for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 20:55:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B792140800
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B792140800
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fllTvVE9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B792140800
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:55:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1385941821
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE621F00A3A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787000105;
 bh=plVsYeA9q0jaxoKN9LIHzE4FLn0EP/5viDpMFIJuqSU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=fllTvVE9/TuPUODFpL20qT+k6vOouIUbWN8H1O7amRXI//s8ZhU396GHYW6Xvg/fX
 T70E3u6h4spvMq9/U27zhs/1N1Y3G5dtDb5R2LK9ZoMI+AKBGtaAOJFZ2BRXuZXEOU
 l+sLOJE/H2Y1PthNcUIiPZND93xCOwvljBRwK7avAIVL6oGKTzASRrF60TdSYVl97L
 l3S5Exlluxb/83EEuUechS4srb9LNkOmF4wIeb75Q/ncic9hFjTylJ+MXgmOzJ3bVf
 umSgJCNAvTYSbVBJj0YIV1CQG/cy2VEXdjMGqJFGK079cndOKyXEGsKDC/c6ZsJVQQ
 dglFsXvTApTnA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5aeb2bc82ccso4482593e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 13:55:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvUd5ddsJZhAmDAli3lQQq/ftAiKV3njjb20gfKnEaGWGyaxXd
 8T9Qz6SIyVeelnEMr03gGZTACOWviAoupoA9lEi6Tb2nELCo9+O+sbeWQdYwwHnMTNJT/LPUnjQ
 GyKZHpqdE8UpNIC9tU29r0TCz0A5mn5c=
X-Received: by 2002:a05:6512:6891:10b0:5ae:9dcd:d04a with SMTP id
 2adb3069b0e04-5b45913c3fbmr2471739e87.29.1787000103696; Mon, 17 Aug 2026
 13:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
 <aoM6qJ32H35aumPL@linaro.org>
In-Reply-To: <aoM6qJ32H35aumPL@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 22:54:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
X-Gm-Features: AcwNN1WulztzpDsZNZW5TNKhOw5vUYRS9b7SrVp1uLURFt9D6TQCDU4d_4xyQrw
Message-ID: <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice
 device tree
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

On Mon, Aug 17, 2026 at 6:45=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> Hm okay so you're basically dropping support for the internal eMMC in
> this patch? Can we support both? BOOTSTD should be able to scan multiple
> storages for boot targets.

Yeah just laziness on my part, I'll fix it up.

> I'm also not really sure about selecting Janice as "default" device tree
> here. Do you expect users to change this setting when they want to build
> stemmy for another board?

I have a script that loops over the Samsung device trees,
and recompiles U-Boot for each of them.
https://dflund.se/~triad/krad/makefiles/ux500-uboot.mak

> I wonder if we could continue using a single generic binary for all
> boards using CONFIG_MULTI_DTB_FIT. We should have "fw_mach" in
> board/ste/stemmy/stemmy.c that should tell us which device we are
> running on, which seems to be mostly(?) unique:
>
> https://github.com/stericsson-mainline/android_kernel/blob/95088950909600=
12f916561b2ede5eaf8124fabd/arch/arm/tools/mach-types#L3956-L3965
>
> I'm not sure about codina-tmo, you would need to check which number the
> bootloader passes.
>
> If these numbers are unique, it should be easy to implement
> board_fit_config_name_match().

I see the appeal of the ambition to have a "one size fits (pun!) all"
U-Boot.

But as it is, some of the DTS attributes on the external SD card are
different between the platforms, so we would need to modify the
U-Boot internal Stemmy device tree for those, copying over yet
properties from the device trees and into the boardfile.

For example Janice and Codina uses a regulator for
vqmmc-supply, and those using the "sd_level_translator"
for vqmmc-supply actually use different GPIO pins on say
Gavini compared to Codina or Golden.

The pin direction settings on the MMC host vary. (Some of
these were really tricky to get right.)

So I think no, if we want external SD card boot we need
per-device compiled U-Boot binaries with the unique device
trees.

Yours,
Linus Walleij
