Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4206C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198C6880DD;
	Thu, 28 Mar 2024 08:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="oxhIrq+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C74880BB; Thu, 28 Mar 2024 08:41:03 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BCD880F3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 5A8471272;
 Thu, 28 Mar 2024 08:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1711611660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6MZp4mqMXrJmlxthJwrROhRvtmD4PJ24r5B4Svd/eE=;
 b=oxhIrq+u/FVNVSn8HSbtxJC6Ui9UR+k74oZvFuHenvBkUlaJBHAFDkp1AmcW9o2hTkVs0D
 78TdGHQFNhss91JGnNfpCNK8BIk7/hEkOhMM0E81uplb79DAiAs3yCslUrIOG3zD2h/iVV
 m5TZ4pOL4QHfb2WMb4otkn5ESjBfvfrrPolymKWsSDH3/zfcSvuCfY73xDaoR1VvYZYsTQ
 JY/KT2IFpRsw1vE0GHgkcfYoKQJDKXyHroL4zlwSVsexS+aVVauEPdkikGUehtYDYM/VRm
 0fT2Va1CHL5Sndlu4RAUhNpv35FJp5hq2V8DztABlWThHunroyjumHMySGjjGw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 08:41:00 +0100
Message-Id: <D057P1KGDU7W.1IWOBHLNV5GX@walle.cc>
Subject: Re: [PATCH v2] arm: dts: kirkwood: Enable upstream DT on Kirkwood
 boards
Cc: "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 "Chris Packham" <chris.packham@alliedtelesis.co.nz>, "Dave Purdy"
 <david.c.purdy@gmail.com>, "Evgeni Dobrev" <evgeni@studio-punkt.com>, "Luka
 Perkov" <luka@openwrt.org>, "Siddarth Gore" <gores@marvell.com>, "Simon
 Guinot" <simon.guinot@sequanux.org>, "Stefan Herbrechtsmeier"
 <stefan@herbrechtsmeier.net>, "Walter Schweizer"
 <swwa@users.sourceforge.net>
From: "Michael Walle" <michael@walle.cc>
To: "Tony Dinh" <mibodhi@gmail.com>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>, "Stefan Roese" <sr@denx.de>
X-Mailer: aerc 0.16.0
References: <20240328021825.17935-1-mibodhi@gmail.com>
In-Reply-To: <20240328021825.17935-1-mibodhi@gmail.com>
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

On Thu Mar 28, 2024 at 3:18 AM CET, Tony Dinh wrote:
> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> files from arch/arm/dts/ directory.
>
> Background:
>
> Hi Stefan,
> Hi Michael,
>
> I did a survey and we currently have 28 Kirkwood boards. Using some
> commands and filters, here are the finding.
>
> git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"' =
-f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm/m=
arvell/$1.dts' sh | grep differ
>
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such f=
ile or directory
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such=
 file or directory

...

Are you sure you want to have all this text in the commit log?

You seem to have forgotten my tag:
Tested-by: Michael Walle <michael@walle.cc> # on lschv2
