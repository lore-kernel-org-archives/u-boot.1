Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8297ECD128A
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 13:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5335D88047;
	Sun,  7 Apr 2024 15:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="CjiGI0bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F7F83333; Sun,  7 Apr 2024 12:30:02 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC29878ED
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 12:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rtPme-0004pN-2w; Sun, 07 Apr 2024 06:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=Ca8SZxHeM+16eUYP9iolG/gBpUBT6/IAG3CM93Nv+MY=; b=CjiGI0bshRhRPCB17gww
 qeu0vvIlPxrukhGXzVGfsyTR53UnM7n/T5oTs8tOtFR8M2MySgGrq/TRqKfSRJquw8OKwqoAX/Z6Z
 SpViVU5o4lokS7fwCCXVROd0eVdVKbC7AS6jGGdD1dSdPKRef4oZWcMLQOLTZNmDrCogGoV07kwsC
 81cDY7uARbtXwF6NnCt9duIo/NxoHuw3pf6V+8CbbN0gw2g/om5KSCSRG6kw3AQkc19MQDZDFtmAS
 0PeLebTgGMcZEaWVWOHoZsv6NaSfzAIAV1bEQXjYuhpGkrtJ1ecJIB26Iz8Ep0Wdx3R44m1kpi4+j
 Qa1NfvzydTecoA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,  =?utf-8?Q?S=C3=A9bastien?=
 Szymanski
 <sebastien.szymanski@armadeus.com>,  Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,  dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
In-Reply-To: <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 (Peng Fan's message of "Sun, 7 Apr 2024 10:26:31 +0000")
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Date: Sun, 07 Apr 2024 12:29:52 +0200
Message-ID: <87v84ta2jj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 07 Apr 2024 15:03:39 +0200
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


> Any comments?

Yes, see: https://lists.denx.de/pipermail/u-boot/2024-March/549531.html

Thanks,

Mathieu
