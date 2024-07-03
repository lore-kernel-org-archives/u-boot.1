Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C4FC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9851888877;
	Wed,  3 Jul 2024 15:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVwlGW3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427CC88814; Wed,  3 Jul 2024 14:01:55 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4D2887EA
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 14:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebin.francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 463C1n69004233;
 Wed, 3 Jul 2024 07:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720008109;
 bh=wPo3SiaDdOF+d8XHPvSMjD+kYyzuNm8PFpXtTRrGdE0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BVwlGW3buPqV33kwm6s2R4CT7DRTZFejKeg2t30HrA/VTsbtGk5r3U6fuA554eN+R
 ZOqVSh5JN2Qurc+ZMasn6rg5z5sBKf6M45CQGabyYrx+CNN6DFaJ9AZFZN8kKmIPpk
 0RQpRnagaKtS+GT1G6fSdJlKrmSqBg5P+TcKjxd0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 463C1nGk006408
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jul 2024 07:01:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jul 2024 07:01:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jul 2024 07:01:49 -0500
Received: from [10.24.69.195] (shark.dhcp.ti.com [10.24.69.195])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 463C1j41039999;
 Wed, 3 Jul 2024 07:01:46 -0500
Message-ID: <629315ea-8198-45af-bf92-6a6e7860e1df@ti.com>
Date: Wed, 3 Jul 2024 17:31:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/4] Low Power Mode: Pakage TIFS Stub on BeaglePlay
To: Nishanth Menon <nm@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
References: <20240628093252.1864609-1-d-gole@ti.com>
 <20240628130323.vxy7rruh3bdcklxe@brownnose>
 <067d0bd4-867f-4d48-8852-f5d8e04ffc2a@ti.com>
 <20240628174008.tjdhwvzj7mxaka6z@destruct>
 <7769855e-8e08-47c0-b4a0-a466f44044de@ti.com>
 <20240701152419.zptqmwrqcwabyrx3@lethargic>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20240701152419.zptqmwrqcwabyrx3@lethargic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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


On 01/07/24 20:54, Nishanth Menon wrote:
> On 15:25-20240701, Sebin Francis wrote:
>> For HS-FS device we need to sign the fs-stub with customer key. DM firmware
>> cannot have a component which is signed using customer key.
> Please explain please why DM cannot have a component signed using a
> customer key for the public record?


For HS device customer is owning the customer key and only customer

has the access for the customer key. Because of this the signing has to 
happen

from the customer side.

DM is release by TI, Since TI doesn't have access to the customer key it 
cannot

have a component that is signed by customer key.


>
