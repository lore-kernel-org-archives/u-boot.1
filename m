Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5E4CEB2D1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 06:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2CF8912A;
	Tue,  1 Oct 2024 08:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZKex2KBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248B38913F; Tue,  1 Oct 2024 08:08:01 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D2B89121
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 08:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49167rxP122465;
 Tue, 1 Oct 2024 01:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727762873;
 bh=D7FeKBx4OkUA9tDBtwzHojef4gg0ydEY3uMpO/UXUR8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZKex2KByGNRo/AC8tMfdcqovNj2fT1OrowmTzlHodIgT1G0bKvnv3lq98EhyDYcI2
 Ig+HXVuqDOyR+3MEypMQIpQQhojm92UEsF3JOsY87JEsYwY+FxihBV+O7u22/3rP0W
 MvFzCI+aaX0LQMEmG4G+D/z49vvsg4vNz2twQ/7g=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49167rV9012076
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 01:07:53 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 01:07:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 01:07:53 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49167o5G124978;
 Tue, 1 Oct 2024 01:07:51 -0500
Message-ID: <d08bf82d-b26b-4cc5-8448-229f001fc0a6@ti.com>
Date: Tue, 1 Oct 2024 11:37:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] lmb: rework logic to validate load address for
 network commands
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
CC: Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Praneeth Bajjuri <praneeth@ti.com>, "Kumar, Udit"
 <u-kumar1@ti.com>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <172688637179.2451825.4736403690225486599.b4-ty@konsulko.com>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <172688637179.2451825.4736403690225486599.b4-ty@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 21/09/24 08:09, Tom Rini wrote:
> On Mon, 16 Sep 2024 20:50:23 +0530, Sughosh Ganu wrote:
> 
>> Rework the logic to verify the load address so that address re-use is
>> not an issue.
>>
>>
>> Note: To be applied on next, on top of
>> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
>>
>> [...]
> 
> Applied to u-boot/next, thanks!

Can these fixes be applied to master also as the failures are seen now 
in master as well?

Thanks and Regards,
Vaishnav

> 
