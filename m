Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1CFCE7B11
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2643386583;
	Thu, 28 Sep 2023 11:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YPj5P+On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC53986DDF; Thu, 28 Sep 2023 11:39:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB06A85DD2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9dBd4021002;
 Thu, 28 Sep 2023 04:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695893951;
 bh=LoPpGSNqEf+QxEQexmTlW00vQg2+yQ89u7dGh2DxTOQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YPj5P+OnfW6Tsq6XK1ai9+fOkF57vPDmT9GFfPdyiBLC5xDyXM8EU2cX9Usz/IpE6
 x4d6NT6L+58sjFMdGctG2jfRZHGBtYHxHJ9/Eoj2inTQKRhEt0RRLgpPsxiDzjsJ52
 BHTkbxe+GHp9qixKX0dlPrsJmXX+4OTKEZs+Cj68=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9dBxg014643
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 04:39:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:39:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:39:11 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9d9JJ003047;
 Thu, 28 Sep 2023 04:39:10 -0500
Message-ID: <3f2ad43b-2c3a-3c00-124b-3cd1c3a5a49c@ti.com>
Date: Thu, 28 Sep 2023 15:09:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] arm: dts: Refactor common dtsi file for R5 and A53 SPL
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-2-n-yadav@ti.com>
 <20230927115601.3gdv4mc2i76gh5rb@tycoon>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20230927115601.3gdv4mc2i76gh5rb@tycoon>
Content-Type: text/plain; charset="UTF-8"
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



On 27/09/23 17:26, Nishanth Menon wrote:
> On 13:51-20230927, Nitin Yadav wrote:
>> Add k3-am62x-r5-sk-common to include nodes common for R5
>> SPL from k3-am625-r5-sk for AM62x SoC based boards. Add
>> k3-am62x-sk-common-u-boot to move common nodes of A53 SPL
>> stage from k3-am625-sk-u-boot.
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
> [...]
>> +#include "k3-am625-sk-binman.dtsi"
> 
> Might be a good time to refactor and squash sk-binman.dtsi to
> u-boot.dtsi ?

IMO, I find this way looks more organized and readble.

> 
> [...]
> 

-- 
Regards,
Nitin
