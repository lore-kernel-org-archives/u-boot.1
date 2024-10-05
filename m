Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9452CF8869
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 03:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F256F88CBD;
	Sat,  5 Oct 2024 05:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WNrM+i/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5060488CD9; Sat,  5 Oct 2024 05:27:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33AB88AC2
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 05:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4953Qs0W130254;
 Fri, 4 Oct 2024 22:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728098814;
 bh=QkwKFEKoHm9OA7mKhpNzrEHKmH8Anti4MAaQE0KS6dg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=WNrM+i/v+E0JWbKi5GGMtfPORnIV43lgIy5aCDCYV5/FD67qN6m8/phVmKpJBk3EO
 Sady7FNNheZ1ZVy9CFIAuz2DztDEeIQs+bSkYeoYHmt/j+bMwbP61ZFluZSay+ICDj
 7WMOe4txMz8SfXzpZzDZ9KJEbqXD3sQBZgo2msLk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4953QsEu076435
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 22:26:54 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 22:26:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 4 Oct
 2024 22:26:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 22:26:53 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4953QrFe022471;
 Fri, 4 Oct 2024 22:26:53 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Javier Tia <javier.tia@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, "Joe
 Hershberger" <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v11 20/29] net-lwip: lwIP wget supports user defined
 port in the uri, so allow it.
In-Reply-To: <06ee18ff-e25d-4e66-ab80-b4ae0bd2574a@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c14ec8b9788c30c205f7b605c9d2b46ebdcdcc91.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjL-oYMkYEZCdcyE7F8x0WPByaELOcYc6Bhz5afXj1Ysvg@mail.gmail.com>
 <06ee18ff-e25d-4e66-ab80-b4ae0bd2574a@linaro.org>
Date: Fri, 4 Oct 2024 22:26:53 -0500
Message-ID: <86plof8c1u.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Jerome Forissier <jerome.forissier@linaro.org> writes:

> On 10/4/24 09:11, Ilias Apalodimas wrote:
>> On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> From: Jonathan Humphreys <j-humphreys@ti.com>
>> 
>> A short description is missing here
>
> I will fold this patch into the previous one since it was a review
> comment from Jonathan H. ; Jonathan I hope you don't mind?
>

No problem.

Jon

> Thanks,
> -- 
> Jerome
>
>> 
>> Thanks
>> /Ilias
>>>
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>  net/lwip/wget.c | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>>> index e8768fc2acd..b495ebd1aa9 100644
>>> --- a/net/lwip/wget.c
>>> +++ b/net/lwip/wget.c
>>> @@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
>>>                 ret = false;
>>>                 goto out;
>>>         }
>>> -       s = strchr(authority, ':');
>>> -       if (s) {
>>> -               log_err("user defined port is not supported\n");
>>> -               ret = false;
>>> -               goto out;
>>> -       }
>>>
>>>  out:
>>>         free(str_copy);
>>> --
>>> 2.40.1
>>>
