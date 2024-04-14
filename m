Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A378C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 12:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3C5880A7;
	Sun, 14 Apr 2024 14:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="PRbwoBRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF05B880AB; Sun, 14 Apr 2024 12:22:15 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E28880B5
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 12:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rvwzy-00006z-Nc; Sun, 14 Apr 2024 06:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=DIXtFs73YWcbL733BuyDrxchdBZb2c6n+HkhqcyZPfs=; b=PRbwoBRAnqzHZcN0ZcI/
 uJy3Hi8nM8mks6MUOzu2BettZedI/QFGzmG3B36XIo/hGjbhBIINd4esunQ0D8uoEqVRVYxiYoDGa
 y3JuWm92cqoBnE6CF0fbuEMfErz5PRHgkvZ3Gvpvy3y+mUTHDNmKoXd0l74me/+CQ1tfMPlGxH5eA
 MqDzi6kArzimvmL3SJ0xmHiNvNv9LC0G+KNqZhJcr4ipHwyiEgD6oCcvTSW/4+7TptvcJv5OylNec
 7rmIxZ665nxmiWAW2JQig5/+aVociNV+BdpR/RcvvbGReVnA25sbaD3KmjYjOToQJVtS+NFnc8wUa
 7EL/xJYWstqOog==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,  u-boot@lists.denx.de,  Peng
 Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
In-Reply-To: <20240412-imx93-of-v2-v6-5-c2ad48e46eca@nxp.com> (Peng Fan's
 message of "Fri, 12 Apr 2024 22:24:55 +0800")
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <20240412-imx93-of-v2-v6-5-c2ad48e46eca@nxp.com>
Date: Sun, 14 Apr 2024 12:22:05 +0200
Message-ID: <87il0k2qia.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 14 Apr 2024 14:45:45 +0200
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

I was able to test this series on the imx93-phyboard-segin. Up to that
specific commit no issue to report.

That specific commit however, using an updated dts subtree at
2639a0e2fd, fails to boot.

There is no more garbage on the UART, but the boot stops after BL31 is
started:

U-Boot SPL 2024.04-rc5-00388-gf81e4e85fd6-dirty (Apr 14 2024 - 12:15:51 +0200)
SOC: 0xa0009300
LC: 0x40040
M33 prepare ok
Normal Boot
WDT:   Started wdog@42490000 with servicing every 1000ms (40s timeout)
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
Load image from 0x45c00 by ROM_API
NOTICE:  BL31: v2.8(release):lf-6.1.36-2.1.0-0-g1a3beeab6-dirty
NOTICE:  BL31: Built : 11:39:38, Aug  7 2023

Not sure where that could come from.

Mathieu
