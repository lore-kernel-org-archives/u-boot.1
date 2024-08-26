Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE30C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF7D88981;
	Mon, 26 Aug 2024 12:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="eEBLiCvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3E1889FC; Mon, 26 Aug 2024 12:08:42 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF9486DBD
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1siWeN-0002Cm-5R; Mon, 26 Aug 2024 06:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=SA20KGgg4yLG4bHSZEVMaQIj1R85tESiScn03jtOid0=; b=eEBLiCvQPddV8LK66OZJ
 F85tzi9x9TOyUfCu1QXV9+WxZMdKSKon3SDIgFtz0o8nt5fAvq2y3BD/mybBAgx5TvyC4dO35D/ZP
 TPXtXVb+LQthAANlyhxv+MaykLiRbJITLosXmc05u0vcbWGqfrfxa7WoY1RPqG1G3LvC3CVcBLXCf
 OsaZvaS+01bDJ0grhPwQvHHqjIQb5tPaog0zqMO5uj3ymWClYM0TD1FXxx2+fPDcHccSW5xbPRKDe
 2vdnUb+MxZbjA51Xr7ImSDLwbxioJBqsni2+Jhq9+I40ed0eNFEt3bq9u0cy1A54/TuZX5q4VzpyD
 Mt7oAByo1HvBjA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>,  Tom Rini <trini@konsulko.com>,  Sean
 Anderson <seanga2@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Ye Li
 <ye.li@nxp.com>,  "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: ele_ahab: Add HUK derivation support
In-Reply-To: <CAOMZO5B_RgZbOqrb-yah0Ta+UPE3r=mYyemuN7Eq1LVKXTfknQ@mail.gmail.com>
 (Fabio Estevam's message of "Fri, 23 Aug 2024 16:18:27 -0300")
References: <20240820044802.12401-1-othacehe@gnu.org>
 <CAOMZO5B_RgZbOqrb-yah0Ta+UPE3r=mYyemuN7Eq1LVKXTfknQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 12:08:36 +0200
Message-ID: <87ikvn4mvv.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

> Please rebase against uboot/next and resubmit it.

Done, v3 sent rebased on top of u-boot-imx-next-20240823.

Thanks,

Mathieu
