Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EC7C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E5187E69;
	Fri,  9 Feb 2024 13:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="iuAf+Vv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0CD87E39; Fri,  9 Feb 2024 09:05:09 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160A987B6B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 09:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rYLsb-0003kj-05; Fri, 09 Feb 2024 03:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=73zR2kIDXtWEs2a1OUZuXjKIWNgLuBZzallvEsT0svs=; b=iuAf+Vv9sPi+n5ChY0Px
 a8SAHN0/piWi8Kk0WIMZibO3M5bOp0lGvVeX7D71aHiCUHMlJ9DpM3HeOvc5nBP3VHUjddjXqih2O
 n47p4+L9EfCLodXDuVK2GPQKa+e9AKwohYqiEI2Jts08TK/NT6wiGi5U/Seuh5LiBflzwcfMhTTxU
 KodCz/se32WupUlpPx5zWjwidVledcNnXgj3TQphxmncDjHXMd4fhFkh3XB5K1m/35w5/mVfRNViu
 hAsxaOscWm/mJHwHKUkl+6ZAeNH8Youd8llKxhvSaK1iRySfkfZblosiGMSt/mMvKW3sSttO5tvCe
 e7ZewLobFuxr5g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Shiji Yang
 <yangshiji66@outlook.com>,  Ye Li <ye.li@nxp.com>,  =?utf-8?Q?S=C3=A9bast?=
 =?utf-8?Q?ien?= Szymanski
 <sebastien.szymanski@armadeus.com>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] imx93_var_som: Enable AHAB support
In-Reply-To: <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 8 Feb 2024 18:20:57 -0300")
References: <20240208094518.391-1-othacehe@gnu.org>
 <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
Date: Fri, 09 Feb 2024 09:04:58 +0100
Message-ID: <87le7uyset.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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


Hello Fabio,

> Just wanted to make sure I understand: if someone programs the fuse to
> close the board,
> it will fail to boot U-Boot proper and this means that the board is
> bricked. Is this correct?

No. I fused the board and with this series applied and the three HAFDBS
commits reverted, I can boot just fine on that board.

Without reverting those commits, the SPL is working fine and u-boot
hangs at relocation. It is 100% reproducible on my board.

> Is the boot failure related to some malloc size needing to be increased?

I tried that it has no influence.

Thanks,

Mathieu
