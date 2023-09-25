Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B0ECE7AA8
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 17:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8775786AEA;
	Mon, 25 Sep 2023 19:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xYEd6yrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9D986BE8; Mon, 25 Sep 2023 19:11:10 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910F4805CD
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 19:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PHAvh9082765;
 Mon, 25 Sep 2023 12:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695661857;
 bh=7weN2BwNmL8SozhnEn9Rkq5FUA2E/veCIfCzo/kWaYI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xYEd6yrNZf7bmbJbo4MP+gmv0rlnQo/6DQzqgEVWMlWgCHeXRHYKRIZkOU/0ARypo
 X6C5akmwv6C3cXW2QFqzwvAbk/4BLwqV+senJBbMQfRNmGFuJnjzi7pbXVnuXP0ANA
 0OJX4OAlzntXI+OeN2lMZIvRu3dq1N7l7CxSJTEs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PHAvdk015562
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 12:10:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 12:10:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 12:10:56 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PHAr97037080;
 Mon, 25 Sep 2023 12:10:54 -0500
Message-ID: <968d8b5f-4f36-a3eb-5a0a-ec2a59aa8af3@ti.com>
Date: Mon, 25 Sep 2023 22:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] lmb: remove overlapping region with next range
Content-Language: en-US
To: Simon Glass <sjg@google.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, <nm@ti.com>, <vigneshr@ti.com>, 
 <patrick.delaunay@foss.st.com>, <sjoerd@collabora.com>,
 <u-boot@lists.denx.de>, <michal.simek@amd.com>, Suman Anna <s-anna@ti.com>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <57F0DE54-C8BF-4B48-9075-2D267DBA4924@gmx.de>
 <7edb7998-66a4-293e-9cfb-ebc142387684@ti.com>
 <CAPnjgZ1K8=UKaTf2WTeOY+58uoRrH=AiL6UNyM7v_Q1gpOvwuA@mail.gmail.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <CAPnjgZ1K8=UKaTf2WTeOY+58uoRrH=AiL6UNyM7v_Q1gpOvwuA@mail.gmail.com>
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

Thanks Simon

On 9/25/2023 9:39 PM, Simon Glass wrote:
> Hi Udit,
>
> On Sun, 24 Sept 2023 at 22:10, Kumar, Udit <u-kumar1@ti.com> wrote:
>> On 9/24/2023 7:21 PM, Heinrich Schuchardt wrote:
>>> Am 24. September 2023 13:18:32 MESZ schrieb Udit Kumar <u-kumar1@ti.com>:
>>>> [..]
>>> Assumption
>>
>> Thanks Heinrich  will fix this typo in v2.
>>
>> Let me wait for other review feedback as well before proceeding for v2.
>>
>>
>>> Regards Heinrich
>>>
>>>> [..]
> Can you please add a test to test/lib which fails before your change
> and passes after?

Sure, will add test case.


> Regards,
> Simon
