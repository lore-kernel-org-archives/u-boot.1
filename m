Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149AEC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 04:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470878744C;
	Wed,  6 Dec 2023 05:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y8E/GLMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E50C8744C; Wed,  6 Dec 2023 05:40:16 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343B58753E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 05:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B64e5AN068452;
 Tue, 5 Dec 2023 22:40:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701837605;
 bh=t3RjJCZqdMjMGksHa7FzsLo9+KbfhkLh1O8DLmWJRaw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Y8E/GLMPtBFnKAzqTBodUaDl72egwhERjaJDmFYZixpVWOvDBLAnSZxVSKrMQxuwq
 D3tmWL2Ofw9msdvhkEj433AI4NgTglbsjw5Q4HxO1niJ7DtnzJaTV2pd/ge6AHyZCx
 kBux7otmhyutxlEKE7KD7gK7Kwu4P67BdQm35AIg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B64e56n008793
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 22:40:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 22:40:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 22:40:05 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B64e002070178;
 Tue, 5 Dec 2023 22:40:01 -0600
Message-ID: <c3ca5d33-be3c-43fe-a14e-2d6146a629c2@ti.com>
Date: Wed, 6 Dec 2023 10:10:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] binman: etype: dm: Add entry type for TI DM
To: Simon Glass <sjg@chromium.org>
CC: <marcel.ziswiler@toradex.com>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>
References: <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-2-n-francis@ti.com>
 <CAPnjgZ0J2GLhVEdfPR78kP6d=T8Yk3wMCTTODc4x+7jzf5N-sw@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAPnjgZ0J2GLhVEdfPR78kP6d=T8Yk3wMCTTODc4x+7jzf5N-sw@mail.gmail.com>
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

Hi Simon,

On 06/12/23 09:24, Simon Glass wrote:
> On Tue, 5 Dec 2023 at 02:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> K3 devices introduces the concept of centralized power, resource and
>> security management to System Firmware. This is to overcome challenges
>> by the traditional approach that implements system control functions on
>> each of the processing units.
>>
>> The software interface for System Firmware is split into TIFS and DM. DM
>> (Device Manager) is responsible for resource and power management from
>> secure and non-secure hosts. This additional binary is necessary for
>> specific platforms' ROM boot images and is to be packaged into tispl.bin
>>
>> Add an entry for DM. The entry can be used for the packaging of
>> tispl.bin by binman along with ATF and TEE.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>> ---
>>   Makefile                        |  1 +
>>   tools/binman/entries.rst        | 14 ++++++++++++++
>>   tools/binman/etype/ti_dm.py     | 22 ++++++++++++++++++++++
>>   tools/binman/ftest.py           |  7 +++++++
>>   tools/binman/test/225_ti_dm.dts | 13 +++++++++++++
>>   5 files changed, 57 insertions(+)
>>   create mode 100644 tools/binman/etype/ti_dm.py
>>   create mode 100644 tools/binman/test/225_ti_dm.dts
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Is there a doc/ update somewhere about TI_DM ?
> 

Yes, it's patch 3/3 in this series.

> Regards,
> Simon

-- 
Thanking You
Neha Malcom Francis
