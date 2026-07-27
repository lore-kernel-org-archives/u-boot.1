Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED23C5321C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41C7980DB5;
	Mon, 27 Jul 2026 11:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CnSO0gitUZEL; Mon, 27 Jul 2026 11:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2777980D5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153127;
	bh=CBjlir6eGghQiQqM9xroXfEm3FYowPVmlxn1VK3T/1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0tROQfiojQZ9L/kdse4UZF5s7lh8jleV4prUEGO5m/MYBX8BTl0XiHeufrS6lyIl
	 fs5ZUjpgsJQMhnfm4pjqaK9FnBtoxmhCvIKz3sQ6DYUoYWruxMouskCzk2pbTRha8X
	 eCWkWRL/8PZhW94G3sOZnbyCCIV36Z4+WVv6+BvIHXZ6279/3nwrRRF8LqOcl2cq5F
	 A4ZUYHm7NFdC9j/qTKNAzPYsDafgFra8g9BG9bBRjPtrdSU+wF57n2CBgYPj85hViV
	 I1LYW2m8kD1gZji0yYOdIdHH9yjOIBHVkB8CSp5wuDFX0n2kjp8rm7fjZbxPe8fBbv
	 sGKCiWlmvtmBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2777980D5C;
	Mon, 27 Jul 2026 11:52:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A76E226C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CF82405C9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIHOFeMu6zte for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:52:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7AE44405A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AE44405A2
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AE44405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785153109; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ji9GvfRZjwteBKccMp84hGWTUCq4LbcJTjBdnfzlAbGuz2fLv5QRfAQcry8IJrjmGrBVVcZP8Snz05BUXa+1CxbHlL/XqRjfLbvYk7+PRoBBGERq7P9BsX+h7Zsp0HDLtL0MKDz9ste5L4VcdDDfZjq0QVNSTR4VwMoIIT78qHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785153109;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CBjlir6eGghQiQqM9xroXfEm3FYowPVmlxn1VK3T/1A=; 
 b=J3+Mvh7J2luETYcvvgIFAZtj0lSN0/2+hAvMeydVMb9wMQ7g9ctnAmITIJNdqIprlaiYN6psMTt4+3Y4M/+hX03t/xe1U51rRYYcIKAZGxOmidfKKrXhyCN969jkkMjtJu0HzxicNT3xj+q+bBMPn3t94GEQib5bOvT/UKC92/4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 17851531071021009.7379325627114;
 Mon, 27 Jul 2026 04:51:47 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:51:36 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
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
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
Message-ID: <amdGSBKT4iRzuh1P@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-m4-v6-6-2f58566d48ca@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.144.37
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785153109; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=CBjlir6eGghQiQqM9xroXfEm3FYowPVmlxn1VK3T/1A=;
 b=WqTCwmAWLvOc6usW8QGBGo1ivkiJZtx08gcghPGoLMeUFacM4iQI5AShg9JzKgKq
 5uE5TClLzdN4PtzhxKHouz2Dy0B3fiD5mmXLZTvdrkdyDqk00rWRrYiRULq6gzuHN0Z
 Yp8Q9rpLg4ydRUFKc6R3P6go5EXRWdc66k1zyjmg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=WqTCwmAW
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

On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> Add the SDH0 controller node and its pinctrl groups to the u-boot
> overlay. The upstream DTS only contains the eMMC node; the SD card
> controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> missing. Place the new node inside the storage-bus via path-based
> merge so it inherits the dma-ranges from the parent bus.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>

Please cherry-pick upstream devicetree changes from Linux upstream with
tools/update-subtree.sh instead of adding our own copies. Changes for
k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.

Best regards,
Yao Zi

> ---
> v5:
> - Append power source field on eMMC/SD pinctrl.
> v3:
> - Fix SD pinctrl as uhs.
> v2:
> - Use vmmc-supply as vqmmc-supply on SD node.
> - Add alias of mmc0 and mmc1.
> ---
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 ++++++++++++++++++++++++++++++-
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 ++++++++++++++++++++++++++++-
>  2 files changed, 173 insertions(+), 4 deletions(-)
