Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F18FC83F10
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 02:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260C786406;
	Mon, 28 Aug 2023 04:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Oz7Yctqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD12A86410; Mon, 28 Aug 2023 04:24:33 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD64863FF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 04:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S2OTCK092695;
 Sun, 27 Aug 2023 21:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693189469;
 bh=6cPpdhpkMwf5erAzG6tJH8mBVREna/OzRiaq3Aib91A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Oz7YctqoNU/cBS6ifJC04HZYj2jKVR0cwGNHgEFewfSrQMoAuP8grOK4HN/cEJcIS
 naQSaHCyapBPRKe0u0ItLIkCV48v5B1IdGkZQkSSg8Mlo9u6RRjoKRx3HCRJZ1zPVx
 FMrrrr6rGmXnoZ00H8Dichl9yjOVxCQMTXMIq7sg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S2OTqR048646
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Aug 2023 21:24:29 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Aug 2023 21:24:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Aug 2023 21:24:28 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S2OPs0129658;
 Sun, 27 Aug 2023 21:24:26 -0500
Message-ID: <02463fce-7d48-5404-7641-f5c2914020cd@ti.com>
Date: Mon, 28 Aug 2023 07:54:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/6] docs: ti: j721s2_evm: Create documentation from
 J7200 docs
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Reid Tonking <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-5-a5f141be40bc@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-5-a5f141be40bc@ti.com>
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

Hi Manorit

On 25/08/23 16:47, Manorit Chawdhry wrote:
> The documentation is based off J7200 documentation tailored for J721S2.
> 
> TRM for J721S2: https://www.ti.com/lit/pdf/spruj28
> Product Page: https://www.ti.com/product/TDA4AL-Q1
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   doc/board/ti/j721s2_evm.rst | 263 ++++++++++++++++++++++++++++++++++++++++++++
>   doc/board/ti/k3.rst         |   1 +
>   2 files changed, 264 insertions(+)
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
