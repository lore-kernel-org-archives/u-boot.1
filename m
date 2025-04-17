Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA8C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32FD82EAA;
	Thu, 17 Apr 2025 06:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ti4RteWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0CA82F5A; Thu, 17 Apr 2025 06:05:00 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316A282DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53H44oDM534735
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 23:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744862690;
 bh=Ujhd6gKp3yNciwxoA/+Bv5QLtspLSM3gg4qEAv9dXcY=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Ti4RteWYEO6xO+7kGSe/dxBUEM0uTJvIzzmaH9L9cSMpWK/0QY5Qr7LdtzRWTfBa5
 eaH/z58hl+NOq1kKxHRzCjjtbkM8wb/5V/3xjEuqwAkBYHT217FruxJzoHmj/nNVpS
 urGfG9arGMqmyiMhM+mSczK0ZIiS0ppJx42UgUzU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53H44nOj010261
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 23:04:50 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 23:04:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 23:04:49 -0500
Received: from [10.249.136.157] ([10.249.136.157])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53H44jDD090861;
 Wed, 16 Apr 2025 23:04:46 -0500
Message-ID: <f36a9f76-1d81-4d53-a24a-66718ca24167@ti.com>
Date: Thu, 17 Apr 2025 09:34:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Change DRAM message and add RAM doc
To: Tom Rini <trini@konsulko.com>, <sjg@chromium.org>, <u-kumar1@ti.com>,
 <afd@ti.com>, <vigneshr@ti.com>, <devarsht@ti.com>,
 <quentin.schulz@cherry.de>, <j-choudhary@ti.com>, <jonas@kwiboo.se>,
 <richard@nod.at>, <raymond.mao@linaro.org>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>
References: <20250319140327.301266-1-n-francis@ti.com>
 <174424957616.1824423.4212381391788741775.b4-ty@konsulko.com>
 <20250416-unlocked-economist-6b0607b00fae@thorsis.com>
 <20250416135231.GQ5495@bill-the-cat>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250416135231.GQ5495@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Alexander, Tom

On 4/16/2025 7:22 PM, Tom Rini wrote:
> On Wed, Apr 16, 2025 at 09:39:07AM +0200, Alexander Dahl wrote:
>> Hello Tom,
>>
>> Am Wed, Apr 09, 2025 at 07:46:16PM -0600 schrieb Tom Rini:
>>> On Wed, 19 Mar 2025 19:33:25 +0530, Neha Malcom Francis wrote:
>>>
>>>> This short series is an ongoing effort to make RAM utilization clearer for
>>>> easier debugging and understanding of code. Intention is for users to quickly
>>>> be able to identify the CONFIGs needed to modify for their RAM usecase.
>>>>
>>>> Neha Malcom Francis (2):
>>>>   board_f: Modify DRAM message
>>>>   doc: memory: Add documentation for system RAM
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/master, thanks!
>>>
>>> [1/2] board_f: Modify DRAM message
>>>       commit: 7dfe3cdc6c58f428803b0f1698bbd4b283103adf
>>> [2/2] doc: memory: Add documentation for system RAM
>>>       commit: 284ef1bbcefcf3180592ed48f522c79618099bd6
>>
>> Something went wrong here.  We have a file 'spl_before_reloc.svg' with
>> size zero now in patch doc/develop/pics …
> 
> Sigh, I thought I caught the problems there, but it seems not. Neha can
> you address Alex's other feedback too and post new before/after svg
> files? Thanks.
> 

Will do that, thanks!

-- 
Thanking You
Neha Malcom Francis

