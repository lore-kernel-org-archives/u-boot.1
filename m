Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF823E9D3E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699CB802C1;
	Wed,  4 Feb 2026 15:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i0hU3Mlu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="weTyjc6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E85D8063E; Wed,  4 Feb 2026 15:23:16 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275AB80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f5jJ16CZ7z9tRP;
 Wed,  4 Feb 2026 15:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770214993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2NjgAJwmAs5PLU3n2T407QYP4jBapPK2vDKdO3JBQM=;
 b=i0hU3Mlu16p18vIfPHl/913w54QBuCunf2B8pATRzkD04/4SW+3zTrhkzkMDj9osF6KRxJ
 djybmMC5m4X4cuj5nSQqTBLNSlI2BUInbZB6pQ6egkrXTzga2+KojnWPqw4SzU09d+J6ry
 kpB//OGFOH9D6XG2gJR9oESLf++gH8IlaXfeSytsXgiY1to7nwQVKFTv1Ei8yj6y6dAZPG
 cVM15nUELypEQpus76s4sOgSydEmEg9xpSxWkdV5W4jYDHyhK/vXVDx5F5LuGWkkVZZPmC
 KkezjNCPGZf4RRJXV6zU6cj7geey+57X85DeV1hsnlkq/tSl7sQVri+/LzpGzQ==
Message-ID: <2a4dfbbe-2f3b-44ab-8cd4-4bf7ce5d4403@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770214991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2NjgAJwmAs5PLU3n2T407QYP4jBapPK2vDKdO3JBQM=;
 b=weTyjc6UAgsfE0+eX231NROBftdFILkUP9IUHiAqmdGuRgX4qnXEu2iwIyrLUG0Agj94vc
 OqQp+0E7hG1T9nmm8WKwkfCTHDrvPTyAWOsZePkXQ1zhPuFYSPYpS6d5/ECmnnzToB5Rr2
 DuZ1+T5w2Xk4pbQm8PTLFwg+j39pwooizO2cfWquJAAdXr3E2ete0iRgFVhpY5TN9qv6cP
 3Cwu7jpxke4IzAO536/yYqzbr4ZDPgdCzZBUSfAhKPIvaklscjwcWoVwXWfEc0PfsEOFcU
 REkB+b1GBpmrfwocJKLkez5AB4xAIuKVUmVAgdBqx5OWb5EJNyCgGmCHpMQdNA==
Date: Wed, 4 Feb 2026 15:23:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm64: dts: freescale: add basic dts for FRDM-IMX95
 in u-boot
To: Tom Rini <trini@konsulko.com>, Joseph Guo <qijian.guo@nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lei Xu <lei.xu@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>,
 Simon Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>,
 qijian.guo@oss.nxp.com, xinyu.chen@nxp.com
References: <20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com>
 <20260204-imx95_frdm-v1-1-85dc80e98a6d@nxp.com>
 <20260204135436.GW2603314@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260204135436.GW2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9f3ukdw7gn1grh4ab8nxgkis6bopdnh8
X-MBO-RS-ID: a5e86fb08c3cfcb3199
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

On 2/4/26 2:54 PM, Tom Rini wrote:
> On Wed, Feb 04, 2026 at 04:47:12PM +0900, Joseph Guo wrote:
> 
>> Add the upstream device tree files for the FRDM-IMX95 board:
>> https://lore.kernel.org/all/20260116-127-v3-2-3dc49545a745@nxp.com/
>>
>> Signed-off-by: Lei Xu <lei.xu@nxp.com>
>> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
>> ---
>>   .../src/arm64/freescale/imx95-15x15-frdm.dts       | 964 +++++++++++++++++++++
>>   1 file changed, 964 insertions(+)
> 
> NAK. Only cherry picks go in there.
So ... move the .dts into arch/arm/dts/ until there is an upstream DT in 
Linux and thet gets synced into dts/upstream/ in some future U-Boot 
version following the Linux release which contains the DT. Once the 
later happens, remove the DT from arch/arm/dts and enable OF_UPSTREAM 
for this board.
