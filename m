Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8393C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D13606EB;
	Mon, 27 Jul 2026 13:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06Vk80YQmlit; Mon, 27 Jul 2026 13:09:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8AEE6065D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785157751;
	bh=hL7A3UHyvfw98JQc5pPQi8eD/Zb6JIrvTzG+C3IGF/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNVpx6eLQuDimN2Og/x8AYAQiJyXMMEb5CV4jiGG7oxI8Eo08sQLh4tSObbJtoPyU
	 92IPxCK+kGn9NFsVdgBCYF9uG4u++iTnqSsvN8O/iqR6sQohznK3SGvSQse9amuStX
	 z1hWPcaDX4KJu1yWygvlh/gDP1jf2bQlGwcTxu4iLkQUFFObl2k8fA5XicCAV9VEG4
	 mLxvVmlLZ6JwuIAwQsBx7f8wEIHH5yUgK6ZjZ0C7kgtkoQLJvI2Ouey/845242X7y4
	 56TfyJeEjo3QlzUi3cmuQPjZh9NtCbwgI1m4DW2EgenmKADwBdSbvWHaDJLkkz+jwu
	 NLR56072+FLfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8AEE6065D;
	Mon, 27 Jul 2026 13:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B6D350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A26B76065D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBVHDhaCyOQO for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:09:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6CD56063F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6CD56063F
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6CD56063F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:09:07 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b28c91fba5so3146241e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157745; cv=none;
 d=google.com; s=arc-20260327;
 b=SWB0WTYlf0dvQuusvCvLGiH3Mt9GU8K0tJ5IjZMiLhi0M+rJThj1JRfseXvqMfE6e3
 lado3h5SAiUGnYzQYmx0rRUNzhoVtPe6ylYygDaXROMsDTYCODF2xyUxGckUenTx5F/d
 wqiJe3tqpvcoJ4VM7PUgsS8P9aQguuBFrUC5Ky419LfiP4OaTfsoXiGu7Se2a6XgzOc7
 46t6tpK5/fxBrA6pz8Tlq/Q+IALMpDMhhwjoiLMAaQbswkLANJJSgn5gLbNqBjZvFPBo
 +kURQ19X67uGeLfoTqqJEBB7NQRzIUuFu8CJPWBCcTV1dRvnWiajRRyZ+bVmcAehod7j
 x1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hL7A3UHyvfw98JQc5pPQi8eD/Zb6JIrvTzG+C3IGF/o=;
 fh=G4ygsNxBGRTfj8t8mBEDqMIopdzTV0C+EqJXTgJiSw4=;
 b=Y1O/nwI4w3YdegFS5egKc5q9p0Snk7AZEo37W9TioKCJJKXhb1Le67OnAor5HQj7nn
 B6e+yIQ7x/UfF8d8+mGTJeBDqE/ZGhZZkf1dclEUeHx4r6FSquF6Vw7eAju/Q7WxOOEx
 BE56USiaOFEJQQlx0/0kzgyC5g9xGjDPS7DcAg8pOYgrjkedfKEXEyUcC892ynwNXK//
 HSpZLeHZ9/AoKKYYLE+lrUAbVGmAQvNgLYh3mgFTu/q2sobbBnGgvwOdYmtNZ4ceiZEg
 4pEjyXibIzhzfKXqINtruiARjDdKgbvO8LYAWpl1lQCwj63OPjdeeL8tknPKlNIkH+fX
 Ihmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157745; x=1785762545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hL7A3UHyvfw98JQc5pPQi8eD/Zb6JIrvTzG+C3IGF/o=;
 b=fNWrH5B8BMiZFu+kgxxfbPDBi+QEevP0MtHDLkwcjRo7OCZjr4ELTgoriY//j10eGm
 4VuKdKQW2i2daripNG1uzSmp0YIr41Jf+xyOW4Uv38NPUB2HwO3If69I4N1LgC6L4fDb
 zMB5AIIAzMnMEisnnOHk3X7M7qMeV4ImMfuJCll4PbyPNPz4UTAKk6TOc1DBmdEb6fu7
 EH34sUZAn4w4zPNr1PpU2Oo9L9DbUGV4nUeV5+7F6k9dw0CRNFNPxZBlM5uMFyGijdKH
 opZRgtVmO0/6CsFCumfTtf7kCZWSu1ruzXMjijwvhKxjYiUlEiDBilJHKj7LL/hZXV+p
 ExZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5mH7sD+YSdndrwb8bscIwvwptwORNsY2PqWBA9eC0VntKJjKiZnu3xHLCg4OBLTFplKKQN+c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxTuVhsvE0IQyxiU/YhUbGntB4T2wMmWmfKDnZ8hivYYvIDE4cK
 yXuVXZq2a9e8IW0LqAzTaKvOpj07a63rBGU8v8fruKJfpp7V5Tvl1krfXo95ee1zK+NFnduAcOI
 0RA6Ed7KhiHcw5EfhZYXJR0U27aVDxTp9YZ+PUvyixQ==
X-Gm-Gg: AR+sD107a0YK4CozidSW4iDnBjV4ySF7W2VmZKA4NmYG5RgQObvbC9Bm8XKkTEsU4Xp
 8mfSmVxibRNrzdQYgeuRh0jwEIyYB5qqFPTBR0Q8/lD+f6eqe3+loYrbGw0moe2Tz4vUvDv9bwI
 GSeDnyVDKLD5BlMFSynCn6t6N7NQVLD9uJotQiDHORYNHkgqvGKOBIl4AKfyaIHh82t0bfOYWoG
 qykDXvxZlSXxLolQ+vT+KL6yhHxvDAY8B6lMgzE0VYM/epJPrN3vfnNUq/K+8g2lcPg9P/d44K0
 nWLPnhUZ6nmZe0/LRurCc2BSsXpGephmolQPoaaJx/1umDnYwAYGWi3EtQRZR3NygY/8QuSyXDU
 RjrTLi+KetETI9452WiE=
X-Received: by 2002:a05:6512:251f:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5b2bcc33deamr2043331e87.28.1785157745049; Mon, 27 Jul 2026
 06:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
In-Reply-To: <amdGSBKT4iRzuh1P@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 21:08:52 +0800
X-Gm-Features: AUfX_mwxYowhEMnUNjwEC5pSSkuDHHTFcKLFbeP1FjWbbjHHBjdYQEyAnGUrOEc
Message-ID: <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785157745; x=1785762545;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hL7A3UHyvfw98JQc5pPQi8eD/Zb6JIrvTzG+C3IGF/o=;
 b=lnNxu4RjQLBztGbw0l5/dLtcOEPR804n2zqVTsFIbJIzdO5UgAdTLVDKUrpAj8pYJA
 vaWBiWm4OhrFgHmNIjtccRX/1VxzjxCIJNA8c7M7Ikw/l+tPKxTzOeNH1hUlE/L9dLUE
 4g/sD/PZZr2dhiVjD8yI7c4yOBprXqpnnhzGgpkRSi4+24jzvq3LFiIhQGi50uvGHDVn
 rGgd1Tk4ihllCVQc8+0XYUFOnm8/jT8vI9Qqagzb/lGvDuTxlG/JFO7RhLQYYG2l5mni
 vJeVhWv+QP/IN5ENVsV6fUnNJnCqv08KRU7qckJ5FBTZ5/aTqyBgHhmtBCY4s6Xiqp8m
 8yAA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=lnNxu4Rj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Yao,

I'm not familiar with the policy for syncing DTS files from the Linux upstr=
eam.
Could you clarify how this script works?

Does it sync all DTS files from Linux upstream at once, or is it
possible to sync
only the Spacemit DTS file?

If I choose to sync only the Spacemit DTS file and include it in my patch s=
et,
would that cause conflicts later when others try to sync all DTS files?

Best Regards
Eric

On Mon, Jul 27, 2026 at 7:52=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > Add the SDH0 controller node and its pinctrl groups to the u-boot
> > overlay. The upstream DTS only contains the eMMC node; the SD card
> > controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> > missing. Place the new node inside the storage-bus via path-based
> > merge so it inherits the dma-ranges from the parent bus.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> Please cherry-pick upstream devicetree changes from Linux upstream with
> tools/update-subtree.sh instead of adding our own copies. Changes for
> k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.
>
> Best regards,
> Yao Zi
>
> > ---
> > v5:
> > - Append power source field on eMMC/SD pinctrl.
> > v3:
> > - Fix SD pinctrl as uhs.
> > v2:
> > - Use vmmc-supply as vqmmc-supply on SD node.
> > - Add alias of mmc0 and mmc1.
> > ---
> >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 +++++++++++++++++++++++=
+++++++-
> >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 +++++++++++++++++++++++=
+++++-
> >  2 files changed, 173 insertions(+), 4 deletions(-)
