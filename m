Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A25C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 03:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0787D87061;
	Mon, 26 Feb 2024 04:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wmcrKgP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3D287DEB; Mon, 26 Feb 2024 04:36:27 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E86087E3F
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41Q3aNPJ086043;
 Sun, 25 Feb 2024 21:36:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708918583;
 bh=7b0yiUzqed9rvDiC5uyy+0RNaD9PDsQvQysoCt6tv24=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=wmcrKgP/VysQ43SVvQ9eEBDRzY5+csu/lVqVaVc1xjZCT/MQjH3u0eqMZsg6/jgeX
 qBgllJz2OJMGt5OoUJL5qpou9/vBMqLpHfAYkEdagnqB7YJseUw0K0VOZj7Ip1rgND
 tuMxbDRPC/LeZk2380laT64mozwLU0s+W6bh+hFM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41Q3aNUZ086715
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 25 Feb 2024 21:36:23 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 25
 Feb 2024 21:36:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 25 Feb 2024 21:36:22 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41Q3aMvh001218;
 Sun, 25 Feb 2024 21:36:22 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v2 3/3] arm: dts: k3-j721e-sk: Remove OSPI phypattern
 partition
In-Reply-To: <90c45918-e0eb-4d09-9e0f-06aea0d4ccb5@ti.com>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
 <20240224002307.2284386-4-j-humphreys@ti.com>
 <90c45918-e0eb-4d09-9e0f-06aea0d4ccb5@ti.com>
Date: Sun, 25 Feb 2024 21:36:22 -0600
Message-ID: <86le77rj61.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 26 Feb 2024 04:38:54 +0100
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

"Kumar, Udit" <u-kumar1@ti.com> writes:

> Thanks Jon
>
> On 2/24/2024 5:53 AM, Jonathan Humphreys wrote:
>> The phy calibration pattern partition isn't needed as the Cadence driver isn't
>> calibrating the phys.
>
>
> Please do mention Fixes tag here
>
> 58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts support")
>

I put the fixes tag on the cover letter.  Is there a 'correct' way - to
add to the cover letter or the individual patches?

In the case of this particular patch, I don't think the fixes tag is
appropriate as this isn't changing any observable behavior, it is a
clean up.

Jon

>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
>> index 479b7bcd6f..20b76a84ff 100644
>> --- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
>> @@ -157,9 +157,5 @@
>>   
>>   	flash@0 {
>>   		bootph-all;
>> -
>> -		partition@3fc0000 {
>> -			bootph-all;
>> -		};
>>   	};
>
>
> This Patch LTGM,
>
>
> + Neha
>
> For further cleanup, we should not have these ospi nodes in u-boot dts file.
>
> should be in board dts (k3-j721e-sk.dts) with right bootph properties ,
>
> and comes via kernel DT.
>
>
>
>>   };
