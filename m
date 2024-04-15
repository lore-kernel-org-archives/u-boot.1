Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE72C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 19:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E571A8823A;
	Mon, 15 Apr 2024 21:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ahLHdZM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FBF8823A; Mon, 15 Apr 2024 21:14:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DBE8822F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 21:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FJDmow102690;
 Mon, 15 Apr 2024 14:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713208428;
 bh=EPASf0ebxAAIJ8VMHGAs7AnjAu5vl3GMvNjq1PE7Ok0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ahLHdZM+++9wuD7cCnuCQZqmimiKteKYGe+SDHM8mJMzvOS6j09aPIlUI51K8skYE
 qiOdOjB/yIuTWYpDqjrPDKTBUE3b2eVLzHY+TJ91JpS1Knsa/tAzhRkSwFHk77x5Iz
 kTPBMO9DXwSffbFiplfrRc1QcruZsj/ayTO1iNkU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FJDmYp080324
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 14:13:48 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 14:13:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 14:13:48 -0500
Received: from [10.250.220.165] ([10.250.220.165])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FJDk4U129151;
 Mon, 15 Apr 2024 14:13:47 -0500
Message-ID: <e96724ee-bbaf-43b5-8a13-219182295852@ti.com>
Date: Tue, 16 Apr 2024 00:43:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Cleanup K3 binman templating
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>,
 <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240412145040.GA361586@oliver.lan>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240412145040.GA361586@oliver.lan>
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

Hi Tom,

On 12-Apr-24 8:20 PM, Tom Rini wrote:
> On Fri, Mar 22, 2024 at 06:40:07PM +0530, Neha Malcom Francis wrote:
> 
>> This series does primarily three things:
>> 	1. Split out the common J721E defconfig for both EVM and SK
>> 	2. Cleanup k3-j721e-binman.dtsi to be SoC specific binman nodes
>> 	   and -u-boot.dtsi files of the respective boards can pick and
>> 	   edit according to their board. This is based on the
>> 	   discussion [1] and this is the primary goal of this series
>> 	3. Move J721E EVM and SK to using OF_UPSTREAM
>>
>> This series depends on series [2] and patch [3] which implement
>> OF_UPSTREAM.
>>
>> Also received input from Nishanth to clean up the unnecessary artifacts
>> in the final build directory (maybe populate them in another directory),
>> working on that as well but didn't want to delay v1 further considering
>> I'm modifying a bunch of board builds and would like some friendly build
>> tests and boot tests for them.
> 
> Please rebase this on top of current master, thanks.
> 

Will send out v2!

-- 
Thanking You
Neha Malcom Francis
