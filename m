Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879E7C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E68D878F9;
	Mon, 23 Oct 2023 15:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="f1mBsEG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA0A878FD; Mon, 23 Oct 2023 15:04:33 +0200 (CEST)
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch
 [185.70.40.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D17878F8
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1698066270; x=1698325470;
 bh=b41fpmOLMejtMudFXqGrokeQunLrrGSg1PsEeiuZVU0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=f1mBsEG10JdNzUwta7xLunhMJJD/skQyfHq4D+lQzdxvsNzg5oClf091Fr6BCtjHc
 GkJKDHPlH72tKRzwHdhp4GtlYFp1C6LJWszzyZCPK6NZTmmsEiwmH9RnRSENiPFao8
 S2MZh+kUr8YtK1PKou4WzruKNvKiiY+tgIUkWryyp9OdSsHiTzBRu0ohqFu5mD2r7J
 9EUuSz647CuZXjT88fV6grQ2lBl+up/kMD5Tlcfdtob4xx2BupChE0DVhyhh9Yr5aB
 hI3w5UNPm/PN93OqPmT9CYSQHDGTO5Io2QH/+TyWMf4jOdFrJCpP5tp6hDxnohjCDO
 RLMakgf34CZ4g==
Date: Mon, 23 Oct 2023 13:04:11 +0000
To: neil.armstrong@linaro.org
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, christianshewitt@gmail.com,
 adeep@lexina.in, b.galvani@gmail.com
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
Message-ID: <CWFU8EKJU032.2QE09681ITNVJ@protonmail.com>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi,

> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
>
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
>
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Nice to see this! Next step would be to have this in U-Boot SPLin
Amlogic SoCs in the future. I'm tempted to implement this in my tree
before sending SPL support for (some) Amlogic SoCs upstream.

Cheers.

