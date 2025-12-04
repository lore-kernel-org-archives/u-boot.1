Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A3CD1F9D3
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC498400F;
	Thu,  4 Dec 2025 13:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eYnDTes3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C38984015; Thu,  4 Dec 2025 13:23:27 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1F883B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 13:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE9erCf0DemhfqW/MWWv3ri3OsGf+RmYUB9K8MWwnvojD1zu3IVdkwTvuYfp7JP+o++JHTkJna9ceIk6rF2k/A/b1Lci2OdWIrwAGqgDm1fkKHT1KS2BZzNYxs4MoiwMCl4DB4xFCC4Z4u3VhZKy577Eh+4onm21bXxxH3txNvNkO8k7TYF66N4S1pqkl8NAl4v/Tx5Hx2blwV3/oOVIom7tds3v1UBwhKi2NaG8OYUuueZzODpj3a6Lcbg6uGGq/laKSp5UrHwAU428XeIPQrn6Hu6zWwYtTSNJv9H+Q6rh5XQRYT6CsRwPYZPOwWPHxwN156VH1ffOVbcCjMDxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDkimWryYVwHiyYP0dFgB10gtA+k3hTUlD0FDGAoS4w=;
 b=TZsD4bNqPKYq1+uIZmnRHtJo2DrEmfzUf36mvGCjPS+uxTyXZkFf7xvIdiXZhGgeY62K/PLFkJlVxdOCKoh4Ul2Euxv804vvh7W1Gjz+9tjxE/SbCKwnRqjQXvDxiaH/R1h/b/8h+v0JWQRMFmCEOkN0x6ZIUfLuHgDtqHi/Hqp02/7djF7Mm0xDkyam4JVxE1aUDIIW+Jc8dh7matxx/WcOXZgI0JnH9mJD3HAhBG+jzSDDWRpiyB6B8TxuzHbh44h8Cx6fLFZS9QQDwbCF1GwJlWBB/kzEUs1thmOeGv+T7rqse8D+TXhkhqYh2KpPnrodadtk5sfbkXOI3iNT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDkimWryYVwHiyYP0dFgB10gtA+k3hTUlD0FDGAoS4w=;
 b=eYnDTes35b4wLJPJ4EpyiTc9FSc4nczCWdTR9CGfdn0CDMDNXs4Z4vgqVZQyayWl6USqXSHED7Jpwrc5Pn8r6ReGjzlV8JCVOMDbTUMcHLA/1irVUkPJvl2ywX7sN9ea/DEPYM8DOJCMsWH/wuGVzPLb8SO3nH0ryEo9egLrYsI=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by SN7PR10MB6571.namprd10.prod.outlook.com (2603:10b6:806:2aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 12:23:19 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Thu,
 4 Dec 2025 12:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 12:23:19 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 06:23:09 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 06:23:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 06:23:09 -0600
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4CN7q51542400;
 Thu, 4 Dec 2025 06:23:07 -0600
Message-ID: <65cd5b6b-aa99-457d-80db-ad6061200b07@ti.com>
Date: Thu, 4 Dec 2025 17:53:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-k3: j722s: Fix eMMC boot functionality
 broken by Ethernet boot
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <mwalle@kernel.org>, <u-boot@lists.denx.de>
References: <20251201060839.777816-1-c-vankar@ti.com>
 <df77fb4b-8cdc-4029-abf9-4757d7d8ca25@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <df77fb4b-8cdc-4029-abf9-4757d7d8ca25@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR10MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: e051a9e2-dd8a-4024-902b-08de332fe895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlJZRENNZ2NzT2Q4a3c2c2dwejh1WXRUbXBUVlM1aFU0WGxWeVRPU1BCN1ln?=
 =?utf-8?B?bU9zRVFkVk5WaDl4dUExZlhreVBzZERQMW5LcWFZRWRWM2loNWQvT3d4RnlD?=
 =?utf-8?B?NWxMakZGL0JmZElHazdDVlcwaGVmZG9nU0tOSzZvSGtEUk9mYmZMeTZ1ZWNZ?=
 =?utf-8?B?T2dJRERrYmFyeVl3TG5ranRMVkg0cjVyWTE1dlhFamY4c1dVeDljUHAvbGtF?=
 =?utf-8?B?UVY1dEI0cTdjK0QyQ1RTSnQyL2tiWWZKbkVtSlR4ZFB3b1VrLzF0dytadFZh?=
 =?utf-8?B?V3RGeEtJVDNjaEdLUkR0R2VrNjdSbWdqU1lWVC8yckFUKzNDRHdxQmRCb0NC?=
 =?utf-8?B?aGI1RzRTRjhHb0d2SW00a1V6TXdEVWFFbkZNTm82WHN6VG1rU0tobFFZUzFx?=
 =?utf-8?B?Y1VoL05NRXA1b2o4R0xkSkFHMjNIQXBRUnZ3UFdUbERyOEFweEJHWU01NmFQ?=
 =?utf-8?B?SnprMjczTnNXcllEOFFuY2JOd3VVUzd4SVM1NVpWWDZZOEU0VHEva0lXOXZ2?=
 =?utf-8?B?QWZWYkpNdnNvZjFVWGVWcU45eUU4Wnc5YUc5MGdZNlcyNkxUL3lwVE0zalhU?=
 =?utf-8?B?Ny9lMWpaRloxM2w3MDBGcVlvSHo3aDV0Z0FtN2NQTFU3aXBIMlhuaW9lVE54?=
 =?utf-8?B?dDR2enEzZy9qTW5YNW9KUks5UG9nelBhdmM4dW5rMHIwUGFSY09ScGxnS283?=
 =?utf-8?B?NXQ1WnFHdlo2NW5jYTV5N0J1dVFXb0o0SWUrWTVaWGhhNVV1a2xwMDAvOE5I?=
 =?utf-8?B?TmdER21NeDFnYVlZK3FZbFJTSDJIVk5wMHNDR21OZzU2c1NkTUYvV2pkMHlj?=
 =?utf-8?B?N0FXa2ZPLzVvL2xNWlJuZ21haklWaUVHMElYdlVyWFh2NENVK3JtYTNkZldH?=
 =?utf-8?B?SVRZeUhiSTBpdHdON2Y3TEJvOHVOeGdWbWFpcVZ3K1BiZndhdTloR0VFb1BT?=
 =?utf-8?B?Tkw5VFkrNHA2ODhJQU4xeXdvSDA2WDB3WDFSTnJzWWxMdDBGWVF0UFpFNnRx?=
 =?utf-8?B?ZXYvb21FbWVkWDdadnB4aHNxRW5QMHVDMllTa1lOeXk2TG9EZnpNdWRMdm4w?=
 =?utf-8?B?OUVOUzAvWTd2Z1lEdlNRb0d4c3d6MmpzNkVDWVAyQnFIVXlTVUlGZlUveEdi?=
 =?utf-8?B?TGphRHJSSW1JUjA1V0VQWHREelcwdGJGQmMxd0Z2ZVpNbzZsaDVrMkpNTml4?=
 =?utf-8?B?YzQ0K25OYWhRNGQ2aHN1TTM4M2pWcnRVaityaXVoVjV0UnNlU2VFSzBLRmli?=
 =?utf-8?B?NCswRzRZYVFvVTBmWlgvdHR0NHpYaWhRdlo4dnpuWXBKTGorc2NSdVE4SHhU?=
 =?utf-8?B?M0FLN1U3TERKZ0wzWVFIOHNUSnFub256aGFlcVJlWVVyU2lMUWt6OThDVHpw?=
 =?utf-8?B?VHZlcTNGMUx2cGphR0NEVG5JcGo4Tkg4eXdmMGdwV1VqT0pGQmEwcUhYb25t?=
 =?utf-8?B?ZWZsQWk3Zi9QZ2ZoVzRGWVZiZEhqQXhGUDNWWjNhQzZXSjZ0YlZJM2cxVEdW?=
 =?utf-8?B?MEVmcHRsUS90L3BNbVIrcUJCN2dKQ3hNeGo1aVUrb2drK3F3cTVlazRuVGs4?=
 =?utf-8?B?YkFlVVJHV3pJQmQ0RFlQUk4zbFB0SHppOVVOZUcveGxaaDNHMjBIQ2xKZHRq?=
 =?utf-8?B?TXlDMk5IbnpEZ0pMa2pONkJZejF2OUY3blQvYmJVajJucnBXU3NOdFlJSng5?=
 =?utf-8?B?U1dFR1JJVGFCdGJUUXNTNmxsTU1IWDdYc1gyM2ErQ21ZVHp2MkpDSmxISzd1?=
 =?utf-8?B?bjd2Y2JPQkg4ZnV0eXI2dExZK2pGV096OXQ2dkdmRGw5Umg5Q3k4b1FITEl2?=
 =?utf-8?B?QnpobkJ3SFVpVE5ROVV1K21WWWZocW1zUW5WMW41L2RCN2NoSVdhTHMxU0Fh?=
 =?utf-8?B?WDNkdzYyb2w2czZhNW9JZy82ZlQySDdYL2ljb09MdHJxT0ptN0J1NU4yR1NZ?=
 =?utf-8?B?OUpuaEk3ZVJKSTdNNlU4YzVDSlRqWVFIdis4Vy8yUE1LVWxqVjYxSlFHNCsx?=
 =?utf-8?B?ZzNhNlh0TUFWZlYwRjRDL1puT1RRSjNQemdqRjRRZ29hSkxOMGU1Kzh0amho?=
 =?utf-8?B?c3RVRGZobWQyUm1QMDEzYngvRnBFSmR4TXMyVkliKzVrakhwTlBkOFB3bUhh?=
 =?utf-8?Q?UfAA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 12:23:19.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e051a9e2-dd8a-4024-902b-08de332fe895
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6571
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

Hello Udit,

On 01/12/25 22:31, Kumar, Udit wrote:
> 
> On 12/1/2025 11:38 AM, Chintan Vankar wrote:
>> While adding CPSW device support to enable Ethernet boot for J722S in
>> dev-data, the eMMC boot functionality was broken. Fix this by adding the
>> missing device ID 57 and its associated clock configurations.
> 
> 
> What does device ID 57 represent here , give some reference or
> 
> you can simply say, while enabling CPSW support... dev-data and clk-data 
> for eMMC
> 
> was removed by mistake, which leads to eMMC boot failure. So add this back
> 
> 

Thank you for suggesting the change, I have posted the next version with
your suggestions at:
https://lore.kernel.org/r/20251204122127.717108-1-c-vankar@ti.com/

> 
>> Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated 
>> data to enable Ethernet boot")
>> Reported-by: Michael Walle <mwalle@kernel.org>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> Tested-by: Michael Walle <mwalle@kernel.org>
>> ---
>>
>> This patch is based on commit '31bf4a1c30877' of origin/master branch of
>> u-boot.
>>
>> Changes from v1 to v2:
>> - Updated commit subject and message to convey what has changed by this
>>    patch.
>> - Collected "Tested-by" tag from Michael Walle.
>>
>>   [..]

