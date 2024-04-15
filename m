Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A82C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 17:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2919B87F69;
	Mon, 15 Apr 2024 19:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="S4cENQNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F242D87BF1; Mon, 15 Apr 2024 19:02:17 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC7187E4D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 19:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rwPia-0007ZW-KW; Mon, 15 Apr 2024 13:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=nBgCoCmeUWXOxaLfAG+zZZ3YMpz567BAAc8cM5gg4kE=; b=S4cENQNd89F5+9DjM7c2
 dvISz/z4BR7aCXRrx/PloBIrnhT88BYXeTm5N23nZDl1dAKg9D0XVGRbk8V4ZIM4qiIlMBb8zh2SN
 ibOmv3nw3JHcfi43YyQkoHw8o6O6mASSvGWURLJaeT9ND/jbnl4wWszEztPWqjSPcvQl9xy0kVX3Z
 c5yXF0xgwodKAeZUkw1bdzVSNMgmdAyJcySwHYsgQ9p2ZrqJpxGTAW1K6DHivEPtzua1Mvv242gmY
 QDIA36cY9b+T3Byex9HhdDEFhTQnJHfguW4gGxQKTUOUsfDf7indM5agkN8hYXg2QqC2jkv/ROd2y
 EDIp06Pg/iBi6Q==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,  "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>,  Yannic Moog <y.moog@phytec.de>,  Wadim Egorov
 <w.egorov@phytec.de>,  Stefano Babic <sbabic@denx.de>,  dl-uboot-imx
 <uboot-imx@nxp.com>,  "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 PHYTEC upstream <upstream@lists.phytec.de>
Subject: Re: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
In-Reply-To: <DU0PR04MB9417723DD3E5F4010A2DB96388092@DU0PR04MB9417.eurprd04.prod.outlook.com>
 (Peng Fan's message of "Mon, 15 Apr 2024 12:55:47 +0000")
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
 <CAOMZO5ASD3HuvUMXc6tmStE1AKRheW_NLUjRfpN5HuJ64ZF-Cg@mail.gmail.com>
 <DU0PR04MB9417723DD3E5F4010A2DB96388092@DU0PR04MB9417.eurprd04.prod.outlook.com>
Date: Mon, 15 Apr 2024 19:02:05 +0200
Message-ID: <871q768sqa.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 15 Apr 2024 19:11:44 +0200
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


Hey,

> Do I need to switch back to only convert i.MX93 11x11 EVK to
> OF_UPSTREM? 

That could be an idea. I can take over the switch for the other devices
when I have some time to perform the debugging.

Mathieu
