Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB89CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 12:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806718319C;
	Fri, 19 Sep 2025 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m5MA1qFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FFD8323A; Fri, 19 Sep 2025 14:20:29 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AAD81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 14:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSs6039pKz9sy4;
 Fri, 19 Sep 2025 14:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758284424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LG3x3jCSd3MeKy6W2OEnmtJxHNN86hjJl2LqLu6dd84=;
 b=m5MA1qFwxLGUApV+WGQ5SvyTFMkvlLUpA41oEC52i1Ep7OUSnw2D+DoXtwQrv/m0GYoGnK
 osKGkrEoOVc7PVfIPiRyNzc1YMjiD3327Jdzyob3p76UEjVGaY03AXycxRmxh+AUQDcfY3
 Vf7jw709PV/JDh6FQlwmCo94K412D8nROAdSfhG+rytYJ1TP/zVz+twCamykweQZgLZ8R1
 qL9cMYC8HJgqB3BzL83qTQxzKYU8gTxDusMHxCp+mjycly+WNU787LwERHH/lpb5uDGJz2
 q4yDswiTRMoDxfQ+Jj5DxPPQqy6v+LvCf5aD2MOC+HmrZGmAp7U1aE7da/N/XA==
Message-ID: <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
Date: Fri, 19 Sep 2025 14:20:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
To: Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de, jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
References: <20250919070156.1497268-1-ye.li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250919070156.1497268-1-ye.li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gsyoufts9s1bp5pmjd78chzhm7ozspbd
X-MBO-RS-ID: 0705f6204c714ba66b2
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

On 9/19/25 9:01 AM, Ye Li wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Align erase and write on erase block boundary in line
> with how read was aligned in commit 622b5d35613.
What is the issue that is being fixed here ?

What is the reproducer ?

Details please .
