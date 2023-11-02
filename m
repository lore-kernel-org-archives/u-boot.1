Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D494FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 15:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9BA587767;
	Thu,  2 Nov 2023 16:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H/j9uv3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB48987785; Thu,  2 Nov 2023 16:27:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9D887764
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 16:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A2FRAAP076932;
 Thu, 2 Nov 2023 10:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698938830;
 bh=stmTVRzwH9Yu/Ko8s2AOlzbp5YpwkWP2tyD8C60F1VI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=H/j9uv3WYkPREisq5ezhpfKPylXFJhdVppKcKBd8qO6VSWWXjzLmevNosaaACuvz3
 bknyHd06ZzIvIYEX0h/GfGjXKcqgYzhxTpMvZaMc63V9oIJYOgMktMHL+cbEhgfcio
 oU4Pu8wfqjT456WZ51NH2WsGYM2gajEZL/QIIz1k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A2FRA7T073537
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 10:27:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 10:27:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 10:27:09 -0500
Received: from [10.250.32.70] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A2FR9Dg056997;
 Thu, 2 Nov 2023 10:27:09 -0500
Message-ID: <32416b5b-46ee-4128-829b-30b13892eecd@ti.com>
Date: Thu, 2 Nov 2023 10:27:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm: mach-k3: am62x: Move board selection to mach-k3
To: Francesco Dolcini <francesco@dolcini.it>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, <u-boot@lists.denx.de>
References: <20231101203530.80359-1-afd@ti.com>
 <20231101203530.80359-5-afd@ti.com>
 <ZUNj6yyW/DdMYAV4@francesco-nb.int.toradex.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <ZUNj6yyW/DdMYAV4@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11/2/23 3:55 AM, Francesco Dolcini wrote:
> Hello Andrew,
> 
> On Wed, Nov 01, 2023 at 03:35:28PM -0500, Andrew Davis wrote:
>> Currently each set of board targets from a vendor is selected inside
>> the board directory for that vendor. This has the problem of multiple
>> targets, one from each vendor, being selectable at the same time.
>> For instance you can select both TARGET_AM654_A53_EVM and
>> TARGET_IOT2050_A53 in the same build.
>>
>> To fix this we need to move the target board choice to a common location
>> for each parent SoC selection. Do this in arch/arm/mach-k3.
> 
> Is this oddity specific of ti k3 based board or is this a generic issue
> in u-boot? Asking to understand if a k3-specific fix is the correct one
> here.
> 

Some platforms/archs do it this way, others don't, so it is mixed. Right
now I'm just fixing mach-k3 but I agree it would be good to audit for this
u-boot wide.

Thinking more on this, what we really need is a consistent strategy for
selecting target boards in Kconfig. I'd like to keep as much vendor
specific stuff in the board/<vendor> dirs, but in this case we end up
with the problem in the commit message.

I think arch/x86/ has the right idea. We can have in arch/arm/mach-k3/Kconfig

config VENDOR_*

selections which lets you choose only one vendor. From there we would
only include the one board directory matching that SoC+vendor combo.
That way we could keep the target selection down in the board/ dirs so
you don't have to make changes in arch/arm/mach-k3 when adding new board.

If everyone is okay with that, I can make that change to this series.
Could be a template then for other arch and vendors.

Andrew
