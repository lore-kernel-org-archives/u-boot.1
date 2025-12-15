Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE35D5B16E
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 14:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AAA80081;
	Mon, 15 Dec 2025 15:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K5InbMFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE7280050; Mon, 15 Dec 2025 15:21:41 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0577180050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 15:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXOIU1Vk2Ty/UPPlRVBYooJnduvk17g/j4MRVhZnPzdMBbdTy6Or4ySEtKVULpezUt8xq5DX3hczNy2j6ywYYh47EjIUwtsptu+CjlpwYa+jMK2t3XYhoF5NW+Cz12ezK6rPcp3lTqX/J+fRUM8/y+PC9qe1mUsOyf/PahR32B2l+B0Mtf87sDJ5iXjoNKkgsBu01HXiZ9+N2EG2XY3HxeLi64z7b+C/fJWAEkCWP662zvRSUbfTeuNxZseh4cMGVuj2fXihxLj5kUU9537GdED+11sDQLzqVi22++wyHln6yo9vOaTyAnYOLoZPkm0pk9vK+fd9Flt4N3VT+MlSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9genpvrDtBviZ8Q2E3/HsJJFWz6LzfIWc7FtRRxRp5Y=;
 b=GzqK2bhfTWIyYxiIcVVYnEU+qaWdYbU94pwk7XTgXhqxQDiu5WGnaigfJCVNl4cByk48AP/wOHAdT2g/iqwVAoLf0RiK+16STZJuTQ6r2c8Dcy8WvgW5oul/VBmIypzPrzJCOhvb2mvFHFtvk80MyTUxGF+0MrNXei5SeyaOgcoDuWUZMOBIQ+FbYJWO/GYk9rn1h7HfBgqZwvh9BFBgq7orwOMtN9vjGoW3LFj1kp0iWTaA3AznKaXsOiu80LwI4rYM8AJ3ivq+SZa7Rn26oRyTZOhJirihGb+v4ra+z0YgBIkq8mgHsAb70ZS8V0zI+tn1olKdxpDBx/Vq6alIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9genpvrDtBviZ8Q2E3/HsJJFWz6LzfIWc7FtRRxRp5Y=;
 b=K5InbMFBa7frfM5iDchF0e+Fng4CoBMzpSDwPp3isrUufoMEppHIv0AVkw0UnMyEPyIXA1TiNFQCFJFxgd7RTHuEBM8TeR5WsKINhs67iiYrC1whhLkeAW96+h74TTDYFtu9bAaA5FWlJrllhHh/wcyD/780Hp0m+KNP1d98VsE=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by IA3PR10MB8322.namprd10.prod.outlook.com (2603:10b6:208:576::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 14:21:29 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::84) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Mon,
 15 Dec 2025 14:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 14:21:26 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 08:21:25 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 08:21:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 08:21:24 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BFELH3W2548907;
 Mon, 15 Dec 2025 08:21:17 -0600
Message-ID: <c3feb2fa-738d-4cd3-bc1d-b1c9e79d5159@ti.com>
Date: Mon, 15 Dec 2025 19:51:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] boot: fix prompt for SPL_LOAD_FIT_ADDRESS
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <foss+uboot@0leil.net>, <u-boot@lists.denx.de>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, "Elaine
 Zhang" <zhangqing@rock-chips.com>
CC: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>, "Jesse
 Taube" <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Martin Schwan <m.schwan@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, "Andre
 Przywara" <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Justin
 Klaassen" <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, "Rui
 Miguel Silva" <rui.silva@linaro.org>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
 <20251212-kconfig-reorg-v1-2-72441d8cc53c@cherry.de>
 <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
 <579ab77f-ceac-4de0-b3ef-1bfda1724418@cherry.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <579ab77f-ceac-4de0-b3ef-1bfda1724418@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA3PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cebda2-8ef0-4602-68eb-08de3be53bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXNMemtITWZVTTZTYmZBQmJKUTdXOERRMUhFZ1hYaUMxdXpTZ2JOc3FzN1hk?=
 =?utf-8?B?djFrcU1rVy8vSUsxb2NMQURBS0xFTW9zZGxUQU4vcUtOeXpxNjlyL2FSa0FY?=
 =?utf-8?B?WWp4RnkvL0hWNTdOU0ZxVS9obnRwS04rWU9nek4wMXFQRVdYVU56a3BHMVpk?=
 =?utf-8?B?akc2cmlzOXVUcUF3OXNjSmFhUzhnZElETVBCRzFRM1VPN28xN0JWOFBNV05P?=
 =?utf-8?B?ai9TL1BHNGZKS1RxL21HWFozdVAzcGlxdTM5VXNqWXNmOEZWSHRZMmVLaDI0?=
 =?utf-8?B?VyszREdJY05wVUowMy9zMTBGdnphVDhPY3pRZ0s0VUNwVnV6dW5rV2pMZ0Nk?=
 =?utf-8?B?TDRsSWRhekxvR0h0T0FXTktRdEVJWkI0aTdkbGVsckZoR0VnYmVMWUNVamxZ?=
 =?utf-8?B?ekhZWCtKcWJtdmtsdjB1VHlmV2VXV3BrcVg3WTlnd0p3czhyL2dBa1RCeThI?=
 =?utf-8?B?MkhaQUZCNHYrVy9ERTVBT29nVitYRFpCZkFnVld3RlQwck5rYzBOdWhPYURO?=
 =?utf-8?B?RW9vajI4b05nT3c3RnM2WHRiNzlqSW1rNU91cDJJVW02ckhYUGFnTmNHQWxT?=
 =?utf-8?B?UzU0eGlkalZ5bzEvSHJ2d3VPc1R3c21LdzRYZXZkU2FwdzF6bVlKdUJ4N2ND?=
 =?utf-8?B?RFltYmhJZjJYMmxiOXkvU1ZUSVZNc0JrSzlwOGxSQ3NJbW5XTlJTR0RvRUZK?=
 =?utf-8?B?OUdsK2UzTXZpdFF4ejZiV1BEbzdGNVRYOUpiajR0bFVpd1ZZbWJGcHAxRmp1?=
 =?utf-8?B?REJTNmlPdHpSZFhqNXdVWHRpZUJzY3JtK0FnSkk5RldsZk5rMm9kcGpXVk0y?=
 =?utf-8?B?M29YSUw0SlFEdmI5TDVjSWdFSnhGZTB6c1JtM0pSZ1NGUkk5eEFtVXBqa1F5?=
 =?utf-8?B?WkJiVjhhSGV6bU93SHByZnk0YmpvRENZSW5XYkEwNnFHeThWQll0NDVPUmRj?=
 =?utf-8?B?QUJsMG0xSGJydkdQWTFDVk5yOTFSemhoRkY1eDNxTU01VmVBQVlLRi9SRFd1?=
 =?utf-8?B?Mi9wOXAvYW9rY3dZaUhNYVdzTTd0cWZ5bnJhWXhIQ3RtTm5sZ1BBbFJWaTZt?=
 =?utf-8?B?WmdNRFJLbDJxb0ZkRUZuT1FVUklZY2dqa3hRd3l6RGUvR1dpVnNOSVVNZ0RG?=
 =?utf-8?B?NHkvNnVKQlhTWFVQcFpFblZrZkRRRTY4SmVEN1o5RW1GeE9hZXhnVW54KzYv?=
 =?utf-8?B?MGFEOU1OQTJuM05NQ2RqUGo3U2JNQ2E0WTh4QzgvdFpRbXc1bks2cEpMMGFn?=
 =?utf-8?B?U09OYURFZDJjZG9lemNqM0dFdGVTalJvUUs2aFlxSWhaSW1xZXIwdFp2Mk4y?=
 =?utf-8?B?aS9PM0RoUlhYNkgvVDVsY1B3ZHEyU3hnU3d5V0Nsc2N3K3hyRzNwQXFjcEZv?=
 =?utf-8?B?K3NCYWFQWms5VEhWN0JNdXY4SlB4YkZPekdmSzJmMm5PWXJmWEx4cnF6bWFz?=
 =?utf-8?B?MzAzRSttdkdUTWMwMVlXYlU5YzFPbmhoaTJURXIyTXROcXdGK1BUYitXVnBW?=
 =?utf-8?B?SUR1Wkt6UUxWNkk4eXNMZ3Noc1RyQVZVUngxc1c0cS9HSmk3SlQ3a0plTVRm?=
 =?utf-8?B?N3BMcFVxWldxWnZVL1RQNVRsSUN5NkVyRStXTjRMMGd6eEluUmtpREJxZ2Y0?=
 =?utf-8?B?cWd6cmVYREwzZkk3SGt6cDhDSDdtSnZRVXB0RWhVWVNkd2N6TTJmRjlLN0xm?=
 =?utf-8?B?ZkEyVEl2Mms0SnFVT2Nsa0w3RFFUb2xVU1pQcG1WWFFZUVJpVUlYZGNrSzlz?=
 =?utf-8?B?VzBFY1pZcmJyUFNJOWo0RmM5TVN0WndQd0xSOXZlZS9tMGZidEhNVHRQSjN4?=
 =?utf-8?B?UzJtVHQwQUZxWENmU2lYVzFiQVV2SnJKWE5JQUZadDNGUEZRUUJHZExEaHJh?=
 =?utf-8?B?Ulo4eDdmTmFvR2FybUZLdE11M3J6SmpnYkErT25WUWwxYjdFaGpwcnpYZlBo?=
 =?utf-8?B?SitNQTVrcFB5VytkajltUitIZm1rY2QrWXRKaU95SVBidHRyUStZSG5GaSth?=
 =?utf-8?B?cXJRbFllOFYzVlErOGRzMFhFbEpKck5xdlorT0JjbkE0Q3Q5bmdHMlpoRytm?=
 =?utf-8?B?akpKYnlsSDdHRFZNRDZ0QjIxeGJobUwzS05tcTgrOXl6SnpiZG85eElxUTRD?=
 =?utf-8?Q?AyMU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 14:21:26.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cebda2-8ef0-4602-68eb-08de3be53bc7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8322
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

Hi Quentin,

On 12/15/2025 4:20 PM, Quentin Schulz wrote:
> Hi Kumar,
>
> On 12/13/25 8:05 AM, Kumar, Udit wrote:
>>
>> On 12/12/2025 11:43 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> The prompt is missing the indication this applies for the SPL loading
>>> a FIT image, and not any other stage.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   boot/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index 85f4d468069..07ae6cc585a 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -272,7 +272,7 @@ config SPL_LOAD_FIT
>>>            "linux" images are also supported with Falcon boot mode.
>>>   config SPL_LOAD_FIT_ADDRESS
>>> -    hex "load address of fit image"
>>> +    hex "load address of fit image in SPL"
>>
>> SPL_LOAD_FIT_ADDRESS, itself indicate that this is for SPL, no ?
>>
>
> You only have this information if you enter the help menu of the 
> symbol, the user will not know it applies to SPL if they don't enter 
> the menu (and they would have to infer this from the name like you 
> just did, which not necessarily everybody is aware is a thing). 


i assume , user are aware of how u-boot works :)

Anyway thanks for adding clarity.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Honestly, I read that prompt and thought it was a way to configure 
> loadaddr environment variable or something like that, wouldn't have 
> imagined this is related to falcon boot (mostly from what I could tell).
>
> Cheers,
> Quentin
