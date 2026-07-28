Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26BC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0663A60A97;
	Wed, 29 Jul 2026 04:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdrydzS6Ys-J; Wed, 29 Jul 2026 04:56:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6436360ABA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300955;
	bh=iC58NmgMJr3osR5njQUnlBPcnlnlsNbqyc4yIe9PQrk=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tsYQBsgDYY0JmL+dMDvvgKq74zcNoO2hebHjlEQ8Kqbq42/DXv79htZen4LK4jI13
	 NF798+jtUvSG0FyKHFmbe+cNcWCS2j6zutpt4P7ZO0jLCRP2nX/vyMpiAGqlmqahOJ
	 SYqvskKKcZQETTHPrqjiRhikUimOBu8igQjORpnogI1yWWqvZhG+eogSLKa3bXDyc8
	 ZNjM0N+U9tUx0zeKfNXfYJm7uMo1ZuT/XY+sStB3SdqL4p/GKi0r9see4I6E0TNYQv
	 lGgbhgXy8CsFZOr13VMEfxWyECf8ezIlPS0hbyT9/tdTq7ryooGfCovI55Bu1kFWbd
	 6hLbxxdWSMwaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6436360ABA;
	Wed, 29 Jul 2026 04:55:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4195D45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27BB8812A3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_OKqoKo6776 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:54:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1FFE681232
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FFE681232
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FFE681232
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:52 +0000 (UTC)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8jlt4pLWzMlGd;
 Tue, 28 Jul 2026 19:54:50 +0200 (CEST)
Message-ID: <58db1c20-5f1f-42f7-810e-6b75a6d6062a@mailbox.org>
Date: Tue, 28 Jul 2026 19:54:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] doc: Switch from printenv to env print
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>,
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>, Minda Chen
 <minda.chen@starfivetech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20260728133337.15916-1-marek.vasut+renesas@mailbox.org>
 <20260728133337.15916-2-marek.vasut+renesas@mailbox.org>
 <2C16005F-7F2A-4892-83CD-6EABDA3A53ED@gmx.de>
Content-Language: en-US
In-Reply-To: <2C16005F-7F2A-4892-83CD-6EABDA3A53ED@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: o49kbkpc66rmpk9hpysoeietruftyh89
X-MBO-RS-ID: a2af2d5f9ccbda2bd89
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC58NmgMJr3osR5njQUnlBPcnlnlsNbqyc4yIe9PQrk=;
 b=oVPgff/GK1+lkGxyUpu6gBxR/wkLcbx0/SgYTkv1UCW/cwA4jzxHQcYRVlyNcT8M6/XzkN
 frSlvEbANR7iO6PDC+iJXOTmIgFpZc5/CMqUfWoSYcXhRT1Tt4awWcQ8e0L1nadDoDra8C
 aUAqUtXOHNUjrm4jQbfG/tZ4uq+dThCdhRpLz+vMybfHkxExnrGcdSjHzhXAn7bDa2a01m
 IUqFk5BXoVbjc7a7APutdXP80rGtqBLeMm8z9YwTFL+LO+3RQ7sAyTHGvh8d+oD9+CYpLv
 uP3myBiC8o1aJoEtT1JrDUwheVI18Mv6knZxK7s63nm+mhZ7VyKEipghArI8Tw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC58NmgMJr3osR5njQUnlBPcnlnlsNbqyc4yIe9PQrk=;
 b=llcn1sAmcKMI5YObWqbIymlXSOE1C2g2TyFttVQF0ydU8nHkFLGwHgBdNCY1aqO2B4sutJ
 9oLJeKFOf8/MnqN7QxRxdtHYiYTWUO25sD37NF+pTR3ZdBoG5H9dS5fhhhucwszqGWzzYm
 vfISnZbBGdq2+xl9lj0N2kkva/XprzjZLYsziZ/IQPcKTxcARyWBsyXhorVX0PoSwV7uMb
 XfLoy5cITg1wARc3OPxbGGxLJ/Zpqk8H9EIefHsmxlkrCkViOu4w+cxbqG1C6Yid2MsbE7
 ba514jGF/x5Njg2etkd0Tkf1sj/9nTkka2DLRf2CAeyjeqWx3nOUigfxKftWZQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=oVPgff/G; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=llcn1sAm
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 7:22 PM, Heinrich Schuchardt wrote:
> Am 28. Juli 2026 15:33:18 MESZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
>> The "env" command is the recommended environment management command,
>> its "print" subcommand is the equivalent replacement for legacy "printenv"
>> command. Update the documentation to use the contemporary "env print"
>> command instead of legacy "printenv" command.
>>
>> Note that the "printenv" command is unlikely to be removed from U-Boot
>> in the near future due to it being integral part of the command line
>> ABI.
>>
>> Implemented using:
>> $ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/) README
> 
> Hello Marek,
> 
> An earlier version of the series was merged today. Please, create a patch for the delta.
Fixed in [PATCH] doc: cmd: gpt: Reinstate gpt setenv , thanks .
