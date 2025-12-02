Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0DCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEBF83E57;
	Tue,  2 Dec 2025 14:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HL/zuVJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BB983E60; Tue,  2 Dec 2025 14:25:55 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D72483CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 14:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehk3IuKRPwBeslyLtYHVi+bWQLxNVbiCPTVKCu1yH8S0wckS+DHK5kMyUInRrfBrWWnRUe0Te+0Ya6wwoZrFYFsjSS3d3egRycz43g27dqW+0qcX73Fle2LVGOWNX+dtcYWdS/UXW3kw0EdnCShQriRH82BBOfsXhAzPBXUGIzSI5FViTjzdMgkbeMcAI7PDqBTteEjwci39meCJM6WFqUtP+LUjoLFcpx0aoUE6OIUNFBIBJl1VkK/cjaOyo11Gdu8kXdieuDEf1PnbyJX8ECKdwfH23rnJbC/L/tX4x0Cmd0KDfRv8074U+VildJssSKigrgUnDn7JoHTXiMRNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0tsUj4KQ+wzJsVPz6/9mhmRXfJb3DQ4deja0CsQr1Q=;
 b=X6CV5reoI50dKqpbLP9JY9v0hP3/Qo+uSZrBEgIq516SBVBXrzZaUtKIk+pGO957G6JU3OJbEGaLJir25iWUxLDfuEBDyChQUz39AzUwt3YaAnE3Bf5nvuOV9ZK8SbOv/R+AeyI8S7Sf3bhhyk0RUhWVsjIFg2yL1PET1ca7mxgUP5TrRxU4c2otzsCAj31qYerHCv9KovZ4pvc6dKPkzZmY8wPpvkc8fV+dVDgHm9N0EVARWVAAYw/KFKGI267FjvMitsWN+GwidYpo6jU1wYwWhqJaSb1xH2oqUGkFXEvmFBlFRFys4ge65DnOrjTiIaqTFdqudBXPIhQd7UQv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0tsUj4KQ+wzJsVPz6/9mhmRXfJb3DQ4deja0CsQr1Q=;
 b=HL/zuVJEmh0iobmOmwlozBPGFp2eZ2+xvIMSYRrF8WsAB1hYV6EJT43CBmf+Xrpge92FnkXRBweZyG2qCLyQqpeWfo8jkGrmuRhkwx+5j4UqRH0ZwL/enkqsGg0Yjzd18SzGuN79lriCS/EIpX9Zc+yNigoIg+jBxIxNmNsZUjc=
Received: from PH2PEPF0000385E.namprd17.prod.outlook.com (2603:10b6:518:1::6c)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:25:48 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH2PEPF0000385E.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 13:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 13:25:47 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 07:25:43 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 07:25:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 07:25:43 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B2DPhhr2311913;
 Tue, 2 Dec 2025 07:25:43 -0600
Message-ID: <8244c927-a974-480e-a314-0e77b860f5a9@ti.com>
Date: Tue, 2 Dec 2025 07:25:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am62d-evm-binman: Update DM
To: Anshul Dalal <anshuld@ti.com>, Paresh Bhagat <p-bhagat@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <v-singh1@ti.com>, <khasim@ti.com>
References: <20251128110210.4143342-1-p-bhagat@ti.com>
 <5f575e86-a687-4427-af8a-108f08ee4d39@ti.com>
 <DENJUYPGV6Q6.IA9OYWK5Z67Q@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <DENJUYPGV6Q6.IA9OYWK5Z67Q@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN2PR10MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b64ceb-27d8-48bf-1aa4-08de31a64e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnFHbFA4V2RTL3hyYVVCYXBZWWo2VGJ5UElPN3B5UGhmNGdWTllXRlJQdmdT?=
 =?utf-8?B?MUZWZmJ5OEkxSGsyb2NRMHJtWWw4QkJnOHgzMFRDVUIrdFhMclhvOWQzbElm?=
 =?utf-8?B?WHkzL2NLRW03TnVIcE85SGRyeXJwTUUxbi9oQ3R0aVRha2pQYTRJVnR0amps?=
 =?utf-8?B?Mm9FeDFrYmU0WUo0blNtOVliTnBxSTZjZlphWVZaRksra0FyQ3BIcVRWVXBp?=
 =?utf-8?B?UEszQ1M0VWFEL2h3dzdyZ1o3S0ZnN3o3RFRmUXlqZm5RbmhoN2w1ZFF5dE5t?=
 =?utf-8?B?d3ZmYlpDaUVLM3BRaVJLYU5NTkRhdzBjUUk3N21Zbkk3bHdjamxCcUU2REpr?=
 =?utf-8?B?Qk9sQ0UxZXpjY1hTOWRWRGk0VS9vSnVEZE5Od2VIOVhnN210dTFoUzQxZjc1?=
 =?utf-8?B?b0J1M09ZOGpwMGovcWR5akxNQ1JiMGVCN090eDNMOG90Q0pBNVcrNVp0Njgz?=
 =?utf-8?B?R3U0VkFDSzhudXRZV0xtRWFTc2NxL21iZW5ORUxDSEVoNW0yQWNWK0lMcTVF?=
 =?utf-8?B?dXZkc095c25URWNPdGtmL2VheXFKM1krYlVYcFJnbEc5MFl5R1d4cks5L2VH?=
 =?utf-8?B?M1doek1rYWd0UTNqTFFGN0lRY0JqVWp3dlVzblNnVFNXMzQ3eXp6RXIyajZT?=
 =?utf-8?B?MWJyNldJTXY5dkJBK2p4NEFYYmFmR2RTUzV2V0xua3NmbDhXV3Y5aFp2cUND?=
 =?utf-8?B?NGJxeXRQSEFUNjhFWTRpMm1EbGJrM1lCZzA2NzNWYTlGNkluNUM0MGcvTk52?=
 =?utf-8?B?NnVKTC9IOTBmMzdsWUtaRWZuKzArZy9zUnlkeFgxR2FtVGRMeit0R3JsaFpW?=
 =?utf-8?B?L20rRkh1ZzFKL2pRNWIxMTlLOVdJdit3bEVqSUhqb0p0Qkt0NmJVeDNhNjlr?=
 =?utf-8?B?NE96Q2hJM0pOdVlaVmdsNHduTzFkdmdBbXd3UHMvRUp5eUxHUjJZbk5UVGR3?=
 =?utf-8?B?ajNXWlk1Zk4yeHpkblFPVUxFb256b1VLZW51UzQzaVhHMHpuK0JFTzdjNFZJ?=
 =?utf-8?B?MXpoZ01jOGw0d2QzUUxUTzBvSHA5UEhuTDNySDlaVERoK0ZKQ3B5TkdmQUpU?=
 =?utf-8?B?amVPUExCMy80a015aUtJdUxIZ3NnOVNYYmprWlNqanoyYUpFdEpZVHgxd1F4?=
 =?utf-8?B?Y3FoWU85RUtWL0cwT2ZidHRxdGdoYjFReStJcEdRUWRYaG9PVmZpajdjd2h1?=
 =?utf-8?B?dkQySWprRGdlNkl3SldxVU1yU0w2OTZXeGVSMUJJTWo5V0RxbExxcTBzODVI?=
 =?utf-8?B?VjYyK01ySmE4cmN2bkZ6TytLYnlaWFE3eFdHK2pNNmpJZmFLaGQ3d1AwVkxy?=
 =?utf-8?B?Q2wyNThvODNPdVFGcFltL0QzbXVBWjdZam5FS2ZCMVA4N05TQUdHTktodkxX?=
 =?utf-8?B?Z0JyYW91ZFpKUUxnZWhKelhvMGZOYW1QcUtWc1hMTkpnN1Z0c1pWb09kUjlV?=
 =?utf-8?B?OVRWNm54cGMxVlRuMWFUaU82MDBtdFk2Mnh6ODBNdW5ySlZNbi9yVjVMUUxJ?=
 =?utf-8?B?QnhwckJFOWwrUGxoNnFOenZXaVdKb0VZY2pheFBFYlFxZmRvTVovVjZWdWJQ?=
 =?utf-8?B?UTVwaC93WVg2VVlpNXdaZ2VxazF2d0ZhblNpeHl6eGRtTjUrUnpZS3J0YnVu?=
 =?utf-8?B?SDFibW5HN25yZ3JDVHQrbTJPUzVQMkJJSC8xV001RUVZOTEydkkxY1owL2ph?=
 =?utf-8?B?MFI3b25nUVBCNG1CaURZYXpIWHN0UW9lVHJzV2NVTkVzNS9YbnNlV0RpS04w?=
 =?utf-8?B?L0xRbVRWNlRITVZ6L0F0TEN5WnUvSldOMlVGZndhWlp4Mis4ZEkxTEI3SjRo?=
 =?utf-8?B?ZmRqdjBVdm96YVNxWU16TGFPN1hqcko4TE16cmpPM29PRm1hbEg0UzBmRFA2?=
 =?utf-8?B?N2VMU0xMRGhLVVVmQ0tpV1VsUk5Gd0RvSW1WQ2VYZk94bGx6dlc4bzk1N2hL?=
 =?utf-8?B?c0lLb3huQlFlZUx6NzgwM3V6dkNsTEJwWlMwN0lUdFpWRnRsc1hMRmVwa2hl?=
 =?utf-8?B?WllYUFo4ZzRMc2VoOVBReFhDTllJZ2F5c2FGSEE2NGU1TG5FbzJzQ2VjME0x?=
 =?utf-8?B?MkVFSXQ0MHRYZ0tYaWNxVVhlVWc2VFdxVzh5T1RtUXV6dTB3VmwrRm1scVA4?=
 =?utf-8?Q?KkzU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 13:25:47.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b64ceb-27d8-48bf-1aa4-08de31a64e21
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
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

On 12/2/25 1:24 AM, Anshul Dalal wrote:
> On Mon Dec 1, 2025 at 11:52 PM IST, Andrew Davis wrote:
>> On 11/28/25 5:02 AM, Paresh Bhagat wrote:
>>> AM62d previously reused the AM62a DM. Since a dedicated DM is now
>>> available, migrate to device specific DM.
>>>
>>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>>> ---
>>> Boot logs
>>> https://gist.github.com/paresh-bhagat12/38bce75c43466b5074271f4cb2ddc3f3
>>>
>>>    arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>>> index 7bf0e955645..3a0ab9f8b2b 100644
>>> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
>>> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>>> @@ -101,4 +101,12 @@
>>>    	description = "k3-am62d2-evm";
>>>    };
>>>    
>>> +&dm_falcon {
>>
>> Not related to this patch, but just noticed we have a different DM node for
>> falcon vs regular, would these ever be different? Could we reuse the same
>> filename for both, was this a limitation of binman or an oversight?
>>
> 
> It's a binman limitation, as with a common node it would complain of
> duplicate phandles (once in tispl.bin and again in tifalcon.bin).
> 

Why do both need a phandle? Seems like a big limitation if we can only
use a built up file/component node one time in only one other component.

Andrew

>> Anyway for this patch, LGTM,
>>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>>
>>> +	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>>> +};
>>> +
>>> +&dm {
>>> +	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>>> +};
>>> +
>>>    #endif
> 

