Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E6C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B730888D41;
	Tue, 20 Aug 2024 09:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="r377Y9KD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41E888D47; Tue, 20 Aug 2024 09:35:26 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2173388CD7
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1sgJOj-0004FU-2M; Tue, 20 Aug 2024 03:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=sBQjzH5swmC4BGOqPBVG9+u/8EJLlIi1BOXIAlUUnHI=; b=r377Y9KDoGL0n2Gy8jSe
 Eyscrs0apnQD7C4Y3ORpwNLJyku3Wy78NFJqRbAAo46t6OhO5PIbfz6iJNW5qkVBQMqGp3YsHwAYV
 eUGUE2qVGcw/mDUoiUkeV97DnDzCUmK3+2yj3a4r22R2IAwRBKx3auqf4JGvE+V0I5AZvXpyyHbvk
 9UUGjM8JxYZ3jZXeLeiobI+G3Vv2JbPI/yPNcGEJXUTf6PNpUnJUTCboZqPtLO2u6FgL27B6zPGHU
 ZD2/xlTNKKpDfgj6Gggeaq9wU4HmdNQopUloTgAxP1+optSaVEmpmX5n1V1dLbk2e0vkI9TDenz6e
 uqvZ+dk0WN2KGg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Ye Li <ye.li@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>,  Sean Anderson <seanga2@gmail.com>,  "NXP
 i . MX U-Boot Team" <uboot-imx@nxp.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH] imx: ele_ahab: Add HUK derivation support
In-Reply-To: <59884e68-8099-4b53-8983-bf8fe2bd5e48@oss.nxp.com> (Ye Li's
 message of "Fri, 16 Aug 2024 19:11:03 +0800")
References: <20240813063243.24249-1-othacehe@gnu.org>
 <59884e68-8099-4b53-8983-bf8fe2bd5e48@oss.nxp.com>
Date: Tue, 20 Aug 2024 09:35:17 +0200
Message-ID: <87v7zv3ave.fsf@gnu.org>
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


Hello,

Thanks for having a look.

> Please try to pass seed size as a parameter, not hard code it. So users can
> set different seed.

Right, this is now fixed in v2:
https://lore.kernel.org/u-boot/20240820044802.12401-1-othacehe@gnu.org/T/#u

Mathieu
