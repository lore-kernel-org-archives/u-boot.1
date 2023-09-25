Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC088CE7AA5
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 17:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D2E86C37;
	Mon, 25 Sep 2023 19:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ReFGFtx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B70F86CAD; Mon, 25 Sep 2023 19:07:46 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2060486B3F
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 19:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PH7V2v081664;
 Mon, 25 Sep 2023 12:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695661651;
 bh=wjmUgW4PMDeUqopNndrgdIzSD4YTZIQMlGFVz00y4i8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ReFGFtx0msua469udnEtYU7DYe9Sn+nASkzr6jDmNxCjue+DENleKexRcXOanlnVB
 BGvHDsqQhG+yX+oPkydHzcuNij80YnGQl9JkqYehdWDBvSAwhYRf/Jo8/bsKzEJzt0
 sVjbD0RBWniU47SG2a96mdObiAdWQUAcMVqWIkbc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PH7VGM116820
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 12:07:31 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 12:07:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 12:07:29 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PH7PUQ003659;
 Mon, 25 Sep 2023 12:07:26 -0500
Message-ID: <a8bdf338-9e9f-db6e-4b77-838791b081b3@ti.com>
Date: Mon, 25 Sep 2023 22:37:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] lmb: remove overlapping region with next range
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
CC: <nm@ti.com>, <vigneshr@ti.com>, <patrick.delaunay@foss.st.com>,
 <sjoerd@collabora.com>, <u-boot@lists.denx.de>, <xypron.glpk@gmx.de>,
 <michal.simek@amd.com>, <s-anna@ti.com>, <dsankouski@gmail.com>,
 <kettenis@openbsd.org>, <sumit.garg@linaro.org>, <sam.shih@mediatek.com>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <20230925152126.GC305624@bill-the-cat>
 <87ttricly9.fsf@bloch.sibelius.xs4all.nl>
 <20230925153114.GD305624@bill-the-cat>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230925153114.GD305624@bill-the-cat>
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

Hi Mark/Tom

On 9/25/2023 9:01 PM, Tom Rini wrote:
> On Mon, Sep 25, 2023 at 05:27:26PM +0200, Mark Kettenis wrote:
>>> Date: Mon, 25 Sep 2023 11:21:26 -0400
>>> From: Tom Rini <trini@konsulko.com>
>>>
>>> On Sun, Sep 24, 2023 at 04:48:32PM +0530, Udit Kumar wrote:
>>>
>>>> In case of new memory range to be added is coalesced
>>>> with any already added non last lmb region.
>>>>
>>>> And there is possibility that, then region in which new memory
>>>> range added is not adjacent to next region. But have some
>>>> sections are overlapping.
>>>>
>>>> So along with adjacency check with next lmb region,
>>>> check for overlap should be done.
>>>>
>>>> In case overlap  is found, adjust and merge these two lmb
>>>> region into one.
>>>>
>>>> Reported-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>> This is good!  I wonder if this addresses the issue that has caused
>>> other platforms to need to set CONFIG_LMB_MAX_REGIONS=64 and I'm
>>> wondering if any of the other maintainers I've cc'd here can drop back
>>> to the default number of regions and then re-test their failure case?
>>> Thanks!
>> Hi Tom,
>>
>> For the Apple M1 systems I don't think it makes sense to reduce the
>> number of regions.  These systems don't have TPL or SPL, have plenty
>> of memory (at least 8GB) and are really fast.  And we anticipate that
>> the number of memory regions will only grow in the future.
> This partly gets at what I see as part of the problem.  It's been
> unclear to me if it's reasonable to just bump the default to 64 for
> aarch64 (and riscv?) because the problem is that 16 is truly too small,
> or given what we're doing we still don't need a ton of LMB regions as at
> the end of the day things should be coalesced in to just a few and it's
> been an underlying bug in an area everyone assumed wasn't buggy.

Did we observed overlapped memory regions added in lmb region ?

which leads to increase in default number of regions.

