Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD7CA0ECF
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 10:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D5B86D09;
	Tue, 12 Sep 2023 12:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m2sSmlsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2DCE86177; Tue, 12 Sep 2023 12:04:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D54986D0A
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CA4V29117120;
 Tue, 12 Sep 2023 05:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694513071;
 bh=qGFExJg7GtmPeqbKmMPNwxgS91lnIjWv1n16AVWPCvg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m2sSmlsD9Qh8/8XiwKQQ9YCm+g8lbu3LdxjGLsc7nSIZcNHXTZwVsj00SXAtfeSGy
 XaF4tQOIZMPEiiJXkFhZoKFN6PUSQzFdaHE9U02q2WqYhDuAaoj649uugLn4MuYElr
 xAdkaS+3TchzfNaJpIpNtsIrDmEJtmk/Wh1LN6iI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CA4VQp005021
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 05:04:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 05:04:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 05:04:30 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CA4QvB107524;
 Tue, 12 Sep 2023 05:04:27 -0500
Message-ID: <95d31b40-79fd-1d43-5b08-e8d9891a6ab3@ti.com>
Date: Tue, 12 Sep 2023 15:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 7/7] arm: dts: k3-j721e: Sync with v6.5-rc1
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-8-n-francis@ti.com>
 <20230911112328.hvskhfdjxtlvx5di@sublime>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230911112328.hvskhfdjxtlvx5di@sublime>
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

Hi Nishanth

On 11/09/23 16:53, Nishanth Menon wrote:
> On 19:44-20230907, Neha Malcom Francis wrote:
>> Sync k3-j721e DTS with kernel.org v6.5-rc1.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

[...]

> 
> This file has:
> * tps659413 -> Should come in from upstream kernel please.

[...]

>>   
> we have tps659412 defined here - should have come in from
> upstream kernel.org
> [...]
> 

Regarding the PMIC nodes, these have not yet been upstreamed, effort is ongoing 
[1]. Will move these out from U-Boot once they have been merged.


[1] https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/

-- 
Thanking You
Neha Malcom Francis
