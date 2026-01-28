Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11F8D35661
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 00:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B988584221;
	Wed, 28 Jan 2026 01:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P1ON9mzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7103F84222; Wed, 28 Jan 2026 01:51:06 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0991E84164
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 01:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLfDZk0KPlVQtnmkQoNJOwDpcnYWaQ/q200rvzxUmV0wsXVAu9ndSBbpswDy6iBjAFZ6At2U6bSSBrEFJliCuLkAhz088V6EEl33WN/gDIdSfiKKSZ+YVoC+X88Y7h5r/dLdaHPBedtau6u5yoNRYfSyIVDCDTRrkXaLU487q5uF9IMtCxoLHokJUwPDooqw0oZjDP78CPhg1w2S1bSz2fAjwC49bA547/wgr5AQaMaWD2IZOx17OikFV+CJSU+UsYn2rIcjzE5uROZdqsminnb+oLvAscT+p/D77BTrYQ5+PAu4X6qUqvueZPd4mgTqCKS+0hRyDCK4sOe2SHJKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltPjyz70ElXDHF4Swxo8lkBp1chL6b6bTxImDvqKEe4=;
 b=DGlGhX2+KjPhM52AlglaH9yL/N0DPl1ovQ4tgmnXW5kKY5viFgg+/NehXFGzAMjkl3MFFJfEzehNDxjBbDuAi2xl5AdeH4LsGDa7jkU773qdoV6Sl7oNwjz4wDNXIEiUou3upUV+nE3V2NgcNtQ0CnbeLz6eHULL7Bum20hi8OD9l/5iI5aZKgzyP7CZ+E55R7BWzB3oNBLVed6H2wDafuR1xX+Kzfs7h1rC8Xrnn+yfDruHGyNldI1d0lxPawvy6NA3YBXz4aFUK0Ud0xhEEidG+XKslTn0vD0G8gz0RoZQip1zJ/TBw3r4PCrtvJ/oPfzZEjh1XN58VL4zpIqAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltPjyz70ElXDHF4Swxo8lkBp1chL6b6bTxImDvqKEe4=;
 b=P1ON9mzh2VN6fyBCwFz/ehY1LFtXUTyDYWkC2B+eM2d3f+t+TsJY0t4Q2ey8bk0eWLCzsVEbQf61EAUitWhXjGLGXcIO/1eFFIu6hBEKXVgNUdStY6bWY5sMxmJIZMeKmcPg4OQ/vuk4aXtlM+p/BkrcSyEKDD+arGGcGxv3QkI=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 00:50:58 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::1a) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 00:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 28 Jan 2026 00:50:56 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:50:56 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:50:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 18:50:56 -0600
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60S0oqHt1443906;
 Tue, 27 Jan 2026 18:50:53 -0600
Message-ID: <b9facf13-8e1e-45c5-b3a9-37e75dfafab2@ti.com>
Date: Wed, 28 Jan 2026 06:20:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: dts: k3-am62d-evm-binman: Override tiboot3
 filenames for AM62D
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
References: <20260116103010.3947922-1-p-bhagat@ti.com>
 <20260116103010.3947922-4-p-bhagat@ti.com>
 <65dd25b7-f4fa-4ede-8da7-39c963bcaa6a@ti.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <65dd25b7-f4fa-4ede-8da7-39c963bcaa6a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfdfe29-305a-4c97-57ed-08de5e074c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3VURnd1QVgyamhBY2xqMWlhUG1JTU13blc2REtiQlFsVjViYVVZSlNsbFpB?=
 =?utf-8?B?UE50ZXNqOWs5UUNlRG13UHBKWndxWmVIZ0xiQkdPaFlGVEpqdk9ZRU1xaWVP?=
 =?utf-8?B?ZXFBUHhxN250azJRRWVPVDlBWkEzb0lCK3d3REhUMGV5UVZMbEtHYVZ3dEpQ?=
 =?utf-8?B?a1psdHQ5dERqZitqUERReVNwY1pCVFlHQlFsVzBhaGNWTDIrNEl0OU5jSFhE?=
 =?utf-8?B?L0lJRmtlbWNheU5SbnFDWVhDV3ZJWGlqQnRuMk4wNVprOGRqVldPeks4ZUxy?=
 =?utf-8?B?OFRJc1ZUWWhXUkRtYXM0TlZhRTRaTDBkUXZRSUFkZXZiZDNnVHZZc0w5Vms4?=
 =?utf-8?B?SFp1S29IRTlhU1ZyNldqd1RZRTdVOEhGOTFlZ3MwS2ZVcVdYREhhSmg1VzB0?=
 =?utf-8?B?SERvdUdObnBLYUk5K3VjVkJvdm9od3NnTVZaNVhzS0E1bWdCQlJZbS9QMHV6?=
 =?utf-8?B?WG5NY3g1bkdjck5LQXdhcVBiYmVFazdTOUlGYUF6dDJSOERCK3c1VGVWd0oz?=
 =?utf-8?B?dVdjeFFyWml2M0pXbGJYOGhoOXBWZlVuSUQ2Z0RKMlhiakxUSzI4VzcwR0J4?=
 =?utf-8?B?VlZUbkd1a0tuWGVTYUVzY0NNN2xyb09XUFRFbkx6ZlFUelNWQWNQYWxEYW1p?=
 =?utf-8?B?OEk2d0Y0dDBLRUtyMGpPU3F6TGZzYUcxZUp2ak52QW93cW9WanlET3Rza2lM?=
 =?utf-8?B?eXg5QkVyNmtsN04rdnRoVmh4dGRRK25YaUdFaEpjQ1pMbjhYRU0wMlZucTVt?=
 =?utf-8?B?NXVuWGxCU0tDRklUNjViWDhHSCt5WjJFVzNQa3dId2JhUkhtZjNFcnJhWU5M?=
 =?utf-8?B?WGNBZFFMQ2pyYVkvenczbE9KVFljODRHMGFrYmlKSDl0cS9KdWw2czl5alB4?=
 =?utf-8?B?ZjI3b0hIRzh1c2FRSXJLRTEzTVhFMXhaYXF0c0d1QW5RM1dRTTFQSTRGbGND?=
 =?utf-8?B?cGVIZjZRZHd3d3QwODMreVF0ZVdLTVJydGhPbm04OWJtYjhsRnlvTUVLQ0VC?=
 =?utf-8?B?UVNvdyttTUZiWjFNNm0xTlNRd1JNZlpQY1h5UDZVMHh0aFh4NHkxR1dZK3Zh?=
 =?utf-8?B?MGsrbjQwam9hL25vbXNiTTVaRldZTWErQm1leXJvNmFTQ081OXZvWndwenlO?=
 =?utf-8?B?Y0xiWEhTd2hsZVFtaG1qNVV4TVFZekFwSnpnZ1A5QUhSTEZMTWF2S2J0MTk4?=
 =?utf-8?B?cElJRnFWbFRpNGd0bnVyK291aGs4MnJPQk5BU2FjNTJrWW42UEN4aFdpZnAw?=
 =?utf-8?B?RDZHTkZ0bk1Kb21EVVBGQXdlLy9zbktKS1VoZkk1T0twMnl3WitWWXNERXh6?=
 =?utf-8?B?SkdpSUtOR0Rvei9Bb0tRQ016SXlrQnZ3TFUwQTFSY3J6RU9MREpHTy9lRjNQ?=
 =?utf-8?B?aXpEWWV6U2pONEtBNHlGSkZlazJ2bDZyRXBTZXRXRy9XNWFvaGcydXZ6NEFz?=
 =?utf-8?B?cTZ5NXlvL2FHdmFUenhOemhHeHNRUUZJUzlZVTBsVVEyb3lmVWRDSVF4MWFp?=
 =?utf-8?B?WUd6RjNrSk05MFBXOHVrUXZDUjZwTTdtZzVKZzBNTzRiMjAvQ2NUM2hFY2Fw?=
 =?utf-8?B?VzJVQ1YwMXhnbytUcFZYU08zRnVEZk03UlRxYndwMUJORHFsZ2l3Vzlmb0hs?=
 =?utf-8?B?QWxIbVJMRFYxcENrV2VGeE5rc2lleENHYUtYVXIvaFNURDZBZlYrd1F5bnB2?=
 =?utf-8?B?cy9oN2FMbzdERUk3ZlEwOE8wZmlBRm96ZzVkVEExMElwcGgzMUhHQ1FYZGVR?=
 =?utf-8?B?ZWV0azZ1NDVHMXp5VEt0TWhYWm9Mc0k2MFQyL0ozdFBkbjdqU0N4b29pYnZu?=
 =?utf-8?B?NUZYeFNDUzk5S3NIRHpmVGhKSFRZU0h2TWJHRU9McW5nSlIrRlZOKzloMjNO?=
 =?utf-8?B?UFZ4dmRnSXd5eDBhRmtnZ1JLOThJamN2MWxmcjVEN3ZVMVFXeVBIQ1liV1pt?=
 =?utf-8?B?aHNuWmVvNGU2MXlWWE0yN1IzWGdWVTZDSnNsUTViZDNndDJMRERScUpNVG1x?=
 =?utf-8?B?bzR2cWpwcFlxNThQd1cxMGREK2VjL2FDK2xXNGR2ZERwc05vUVFvbDdNeDFn?=
 =?utf-8?B?NjRSVi9oU0F0ai9EUUY1MVJQeHY5L1VhNTBxaVdzTWdSNm9XbTFqNTJUMTdh?=
 =?utf-8?B?ZElYYW9PNUZLR296a0s4ZTZQVzIzVmpZNHhJNExLQStMSFZWQkQxd3FuV3pS?=
 =?utf-8?Q?NhN1Gj1ZFrxOM7YyCQY8ANdCtvMov1MT+Gfwe0fpDUet?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:50:56.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfdfe29-305a-4c97-57ed-08de5e074c34
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
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


On 17/01/26 00:03, Andrew Davis wrote:
> On 1/16/26 4:30 AM, Paresh Bhagat wrote:
>> Reference the tiboot3 binary labels from k3-am62a-sk-binman.dtsi and
>> override their filenames to use AM62D-specific names:
>> - tiboot3-am62dx-hs-evm.bin
>> - tiboot3-am62dx-hs-fs-evm.bin
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> ---
>>   arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi 
>> b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> index 41c8746cf08..430bf8ccb79 100644
>> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> @@ -63,6 +63,14 @@
>>       config = "board/ti/am62ax/rm-cfg.yaml";
>>   };
>>   +&tiboot3_am62ax_hs_evm {
>> +    filename = "tiboot3-am62dx-hs-evm.bin";
>> +};
>
> NAK
>
> We have discussed this before, the name of the file is based on the TIFS
> binary used. This file uses "ti-fs-firmware-am62ax-hs-enc.bin" so its
> name must match. The name has nothing to do with which board or SoC the
> SPL was built for, we have *never* named the SPL image after the board or
> SoC, if you believe otherwise then tell me what specific board or SoC the
> file "tiboot3.bin" or "MLO" is for?
>
> You also give no "why" you need to change the name in your commit message
> nor cover-letter, simply stating it is the "correct" name. I do know the
> reason, and it isn't a good one, go fix your yocto/test scripts.
>
> Andrew


Agreed Andrew. I will remove the patches from the series. Thanks


>
>> +
>> +&tiboot3_am62ax_hs_fs_evm {
>> +    filename = "tiboot3-am62dx-hs-fs-evm.bin";
>> +};
>> +
>>   #endif
>>     #ifdef CONFIG_TARGET_AM62D2_A53_EVM
>
