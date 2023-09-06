Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C072CEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 03:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1471086591;
	Wed,  6 Sep 2023 05:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j0C66W4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C498659F; Wed,  6 Sep 2023 05:50:10 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110F28656A
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3863o5hV001766;
 Tue, 5 Sep 2023 22:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693972205;
 bh=ESKwiJp0lZ94pIZn7ZaHvwT5ECOPcurrUw+nbWFQiQI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=j0C66W4hE/S743mzK90SbU42cnqobPXoHLtJviHsFjAOol/cPfQ/wDNdG1DMB8907
 Hr/bxvdsL9M0o1cKsyBJxAoTTg/Ixb3EKZHSLiuDJ91AMEyZp/9y1CuiijNouc6fEM
 UTFDqwJu+uJbTuXP1YAKWmPWWv/d4Xu7h5WNpftw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3863o5he029733
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 22:50:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 22:50:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 22:50:05 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3863o1a3049175;
 Tue, 5 Sep 2023 22:50:01 -0500
Message-ID: <2c91bdf0-39c1-f7d9-28db-c1a7a8e361eb@ti.com>
Date: Wed, 6 Sep 2023 09:20:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Simon
 Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
 <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andrew,

On 05/09/23 20:52, Andrew Davis wrote:
> On 9/5/23 3:21 AM, Manorit Chawdhry wrote:
>> The following commits adds the configuration of firewalls required to
>> protect ATF and OP-TEE memory region from non-secure reads and
>> writes using master and slave firewalls present in our K3 SOCs.

[...]

>> +                        // cpu_0_cpu_0_msmc Foreground Firewall
>> +                        firewall-1 {
>> +                            id = <257>;
>> +                            region = <1>;
>> +                            control = <0x1a>;
>> +                            permissions = <0x0100ff>;
>> +                            start_address = <0x0 0x70000000>;
> 
> This address might change if one moves ATF, might work to use 
> CONFIG_K3_ATF_LOAD_ADDR?
> Not sure how you would get the end address as we don't really know ATF size..
> 

I think this could be handled within binman IF CONFIG_K3_ATF_LOAD_ADDR and the 
ATF binary were not only A53/A72 inputs. But since it is, I don't see how that 
can be implemented.

> Andrew

-- 
Thanking You
Neha Malcom Francis
