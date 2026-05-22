Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD02CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 14:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0980847C4;
	Fri, 22 May 2026 16:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lGZW99RT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C1B847C8; Fri, 22 May 2026 16:59:50 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D16846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 49A65C2C65B;
 Fri, 22 May 2026 15:00:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 564F06003C;
 Fri, 22 May 2026 14:59:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A3239108114EC; 
 Fri, 22 May 2026 16:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779461986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Sbb4bhbYZ6AzjlWQi+D08tQ4vezamPm5yoN5//4cuYM=;
 b=lGZW99RTt/Kmh4gv6rsNpeyHV3rJfCKdHMSk5LmwdWCxttlQKUvys+1rtCqphs29uMpQhr
 /RptQ85GAasUISEUvNQjmaucffXmrxIgOKxVZEHjBGfqNE2yVFPOIOsZgLa6XwJaERwEEj
 dp0VuMdNZySIxs4NkWXrN55/bWCv5TADFJ9+fut90VrpP4Z36DxiIr0h6C0wqQJCp+5mKE
 PkEjMXh0tC5Lf33GNOmvfAcy7c5bG7vsVMbbkqBfUqauajUjBQFkOjz9JLPVVbmGV24flb
 1f3dwviO2g2Dv+i+zlc1vASm4B9vfWJuGZP7oMPJBjRhCTh3/VaXDeO65Y6gFA==
Message-ID: <88d27838-a369-48f3-a477-99736a4db69c@bootlin.com>
Date: Fri, 22 May 2026 16:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] arm: mach-k3: Update pm-boardcfg for all k3
 platforms
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-17-richard.genoud@bootlin.com>
 <6dad8477-a34f-4c50-9ce1-7ec1d0f343f3@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <6dad8477-a34f-4c50-9ce1-7ec1d0f343f3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 11/05/2026 à 12:54, Kumar, Udit a écrit :
> 
> 
> On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
>> From: Abhash Kumar Jha <a-kumar2@ti.com>
>>
>> Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
>> following substructures
>>
>> - lpm_cfg : Low Power Mode configuration
>> - pll_cfg : PLL configuration
>> - dev_cfg : Device Power configuration
>> - rsvd_pmic_cfg : Reserved PMIC configuration
>> - rsvd_cfg : Reserved cofiguration containing the size for the flexible
>>      array appended at the end of pm-boardcfg
>>
>> The ABI revision for pm-cfg is also changed from 0:1 to 1:1
>>
>> Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
>> j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
>> "pm-cfg -> pm-boardcfg -> rev".
>>
>> This change only adds a new 'pm-boardcfg' property as a parent of the
>> 'rev' property, this does not affect the generated pm-cfg binary.
>>
>> Add u64 type in schema and update the boardcfg script to deal with u64
>> types.
>>
>> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
>> ---
>>   arch/arm/mach-k3/schema.yaml            | 195 +++++++++++++++++++-----
>>   board/phytec/phycore_am62ax/pm-cfg.yaml |   7 +-
>>   board/ti/am62ax/pm-cfg.yaml             |   7 +-
>>   board/ti/am62px/pm-cfg.yaml             |   7 +-
>>   board/ti/am62x/pm-cfg.yaml              |   7 +-
>>   board/ti/am64x/pm-cfg.yaml              |   5 +-
>>   board/ti/am65x/pm-cfg.yaml              |   7 +-
>>   board/ti/j7200/pm-cfg.yaml              |  92 ++++++++++-
>>   board/ti/j721e/pm-cfg.yaml              |  92 ++++++++++-
>>   board/ti/j721s2/pm-cfg.yaml             |  94 +++++++++++-
>>   board/ti/j722s/pm-cfg.yaml              |   7 +-
>>   board/ti/j784s4/pm-cfg.yaml             |  94 +++++++++++-
>>   tools/binman/etype/ti_board_config.py   |   4 +-
>>   13 files changed, 552 insertions(+), 66 deletions(-)
> 
> Please include all K3 platform, otherwise build will fail like beagleboardOk

Thanks!

Regards,
Richard
