Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B87CF256D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 03:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF41583E40;
	Thu, 20 Nov 2025 04:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P5zuoLgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38C983EA6; Thu, 20 Nov 2025 04:33:43 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA13983E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4mveiOGZ43IlueJfpyhgKpSzdBRbeuF6oKIQnlSdTq/xusznsNwrj5P1xSPuZSgNgLXRZ8Mmh8mcyi/by/+RBQPiIr4U8/PgWfdY9igzZWRqG6JnsdOumftj9zQJKmZr7SRy/VofFbb8jCAJzqIik3eIqgdXYQBUfeKbGk3sxqLMe2g/9fb4ZaG1ldkBOR2+9F14dkcV2rh34CBx4ptDDvjOMCIN9uNpjPGCa4YrBt+mxHeiu/zM1x4EZxMSMwY1C5UmXV3sNgKmeRezrMgOuGKddLSz7L9ihNb5KVrrWsxlJdE6XAo3gOnXCgawYFP/aCJuc5exe1BH9J//7ZB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgXr3Bq5v7ug6Rhzm1XhBME6vqGbADn6R2CyZU/pNyI=;
 b=d1ntFVXJJ7ARBihzRnfShZyiZMsZ8j1I8RU7tQSNuABv1rvFAp8hPZIukEL8rpsMfOLvEi/2egkXSc7FHED6+iMGhn0ndWcXZkJ6Xq09nXwQvhx8Gk7l8+9WY+zNsYj8Vn4mbwzzd09IReH6Y5maLZZUsvGBOXYo9qQz7g3AToJYs6Yxg2D6G33185aVoZe4ZfuCgcjAul+Md4aT2XwMydHsEweE/HR7GLsUfKGnnuDQggBSTaZx+K+fhlbs/iGfZJGiHCBb2I+cKX0yJ1BpBntUQhirzYFaRS7tTJ81q+p7wSpWXau1vlcxC6/2VcDa89KB1gIuLTD1MNLSysSVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgXr3Bq5v7ug6Rhzm1XhBME6vqGbADn6R2CyZU/pNyI=;
 b=P5zuoLgEunEt32dx2M8OqaC4CTuwIjs5PC0iyP/HYiMPQNK+WFQRsFzQPH8hsmN57N1LjfyBkQB0goiZ2n+1IhVdwtmlbr1qJqgXAmxpCVHulpGTwHqsJmbZu0Tm5rjoXjJaqMJebordJovThA+IwnxEMV0c8Y75QMihn05H2K8=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by IA3PR10MB8708.namprd10.prod.outlook.com (2603:10b6:208:572::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:33:37 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::d1) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:33:36 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 21:33:32 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 21:33:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 21:33:31 -0600
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AK3XSQo2983151;
 Wed, 19 Nov 2025 21:33:29 -0600
Message-ID: <b5391d0b-d1d6-45da-acb9-064a8ce2de7f@ti.com>
Date: Thu, 20 Nov 2025 09:03:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
To: Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, <devarsht@ti.com>,
 <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <h-shenoy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <DE1M02OMYGCG.UGUVC26WQW5I@ti.com> <20251106133745.GX6688@bill-the-cat>
 <15de746b-85f1-4cbf-a803-a225d7cc2d44@ti.com>
 <20251111133504.GS6688@bill-the-cat>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251111133504.GS6688@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA3PR10MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d65a14d-7ab5-47e7-188c-08de27e59698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDQwaFdlVEdHMHdUMmJXUGxmM2U0djVXdE4way9BcGh6Y3FYVitHM3ZYOWdM?=
 =?utf-8?B?WjkxRGdoSVlzYmgvME5udjNYKzIzd2t3YW9jOXJ6QXF4elE5SVJLK3l3RzBo?=
 =?utf-8?B?cVR6K3oybTBtMG5hVStkOURLMVkwV3ZFVER2RUQxNWg2clBVUm1IZCtOUUk5?=
 =?utf-8?B?RXB6Yll6S3ZaaWhUZGFLQmNtcVB1VmFId0J6QVVyQmtRME11cmxiMUVqUHpz?=
 =?utf-8?B?akQ1TkhkUS9lelFGTklPcUM5TThmOGRCNDkvU0RaTjAvRFZNelBBQTRrYWMv?=
 =?utf-8?B?ZXJLOU80TlNjcEw2RTZ4c2xhTE5Lc3U3cXpyWEJTNEZ5eU90OUhBeFRmd0J6?=
 =?utf-8?B?ODF4aVZoaGd3Z0FRcjBkNUcxMjJTM3NVakNvZVNEWGJHbU9kYnJidy9JcjEr?=
 =?utf-8?B?ZGdraWVrTXFLNnJVSzlqVE55UmpGN2xrT0t1T0d3V0NwT2JUWHZXVWtZVDg5?=
 =?utf-8?B?M1pCV0J5TlZxMWZrUFI5RGJnS0FUREc3S3dHa1hYaU40MXlLTysrMTlWZXJv?=
 =?utf-8?B?S0dJWkdIZ0luTDZpZTNyZHdFVGZyWUxwZExjNTNRTDJKaERhL2IyZEVlc081?=
 =?utf-8?B?N2RLdi9lOW1Oclc5eHd3NWp1Zzk3UzZaM1poQmRYNXNIa0x2N3FLSkFiUTg1?=
 =?utf-8?B?TFlxZGtzWFI3WCtGR2UzTFZFV2NXalFrTTVqZEVkazJ4aGdYelREeDBHWUEw?=
 =?utf-8?B?UGpTaXVoUjlkSVBVMWZ3Mm5CSzdJUFdxVjdXM3NhNVk3Tnd5R255ampYOTg1?=
 =?utf-8?B?eGRXRCtZckpoRHJuMEM5cjh6aC9pUDg1aXVpdjZxV21ZTnBTMmhxV0toSndZ?=
 =?utf-8?B?ZzJPUlFzOHNOeTJobVYzQWFDYjFDeks3N0dzQTZTME9iQzRlVUJyYlRQTmZz?=
 =?utf-8?B?eW9hZHI1aEMxSk1WeThhbmlHVUo3RTV1RVd5cWRQZDhhdzVvY2ZrU3NlWnJN?=
 =?utf-8?B?ZjIzQXpJeVJGdWlKbjJnQzdVQXFhSjkvaTNoUXpPdVU5OXJGZFM2R0Z2V2Z1?=
 =?utf-8?B?S05wYkY1aWx4VDdWMlNFb1NoQXZiQkMzZllrZGZCd3RSb2RjeS9nVGxpZDBl?=
 =?utf-8?B?QWpzT29NUXR5K2xQMjNGMFd6RWtUVURDeTJleVpyYWhnWjFVZ0ZWRDBzQTBU?=
 =?utf-8?B?eGF3NWZnQjRoRjArSE54TDEwMU53cGNtTTFacVZTaVE2Mkc3QU8xQVNyb2dW?=
 =?utf-8?B?ek15LzBndCtHcTBjU3AyeUMxZStibzB0MWE5czUrc1g5U2V4RDEzS1YvK3NC?=
 =?utf-8?B?VFdpbkhQRjVCUE9Ja21ON3FZb1I1Y240eFNaUmpnaFJYNHhtK055WWNTVU5O?=
 =?utf-8?B?bXRjZ2dxZXRJWkFGMEpqdXlvZEZkd2xkQjRxTW1qK0x0TVZONTU0MW9TM0VH?=
 =?utf-8?B?d1lZRkFVZ2x0YmI1c21OKzhvQ2dKL2U3Q3dOT1ZIL0RNV3paM0Z2NlBsR1pV?=
 =?utf-8?B?TnRyVHF4Y2JhOEVHVUNrd0U4cXdNeGdnTld3dDNNYUg2Wlg1d2FmdU1scEht?=
 =?utf-8?B?N1FocTVaVm16amRmL2U2L3NiVGorRnZsQ250ZjhGSlByZnl3eWhobEtOK0xF?=
 =?utf-8?B?QVJnUmRvS1diRXRycUllTjJiMWFvelhERnp2K0c5eVVMV1VRZnUxbWplUTVo?=
 =?utf-8?B?b1lRQnRyYXd0ZzRQV0wwSWVPaytKSnMzcDMxendOc1VLYldXVUhIdnRkN0ZL?=
 =?utf-8?B?MjRqUEdkKzVWK1JITDZGRE1xanlpMDd6b0VTNmw5MEN2V2Zsa21zeThneFNx?=
 =?utf-8?B?SXhJMGt6UUxRVlBWVkNwNGVnakkzQ1c5NmpvU0kzK2RtTitaKzNRU2IrMGUy?=
 =?utf-8?B?TTBDeGJ0OXJrb0dxRWtCak9kdWFjbGtmNUtxUGUzN00vc09DdW11T3IxQjdK?=
 =?utf-8?B?Vm9QaXFsZ1F0MURYNE40U1JBTzFZQ3RXbHpieXVoZEROZmg0VjdYWUh5Z21t?=
 =?utf-8?B?aDR1bkMzTzVPalE2c0w4Vm9xdGVxam5EYUxWZVY4eHQ0M0RKYmhlakcwbHBQ?=
 =?utf-8?B?TDNrOEJWT0dONjBQUEc0Sy9oTisrd0NIUVRhM2s2czhIZExnOG05SXphcjFZ?=
 =?utf-8?B?bFBIVEk0TEp3TkVTUk9ESzNQY3RPSkpYWWJQOXNRd2RJQVA2UlAydnNZNUk5?=
 =?utf-8?Q?zSPs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:33:36.0204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d65a14d-7ab5-47e7-188c-08de27e59698
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8708
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

On 11/11/25 19:05, Tom Rini wrote:
> On Tue, Nov 11, 2025 at 02:38:10PM +0530, Swamil Jain wrote:
>>
>> On 06-11-2025 19:07, Tom Rini wrote:
>>> On Thu, Nov 06, 2025 at 05:56:38PM +0530, Anshul Dalal wrote:
>>>> On Thu Nov 6, 2025 at 2:28 PM IST, Swamil Jain wrote:
>>>>> This series:
>>>>> - Refactors tidss_drv
>>>>> - Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot
>>>>>     SPL
>>>>>
>>>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>>>> ---
>>>>
>>>> Tested-by: Anshul Dalal <anshuld@ti.com>
>>>>
>>>> I also went ahead and did a sandbox build and the driver seems to build
>>>> fine contrary to what Tom saw[1].
>>>>
>>>> Below are the steps I followed, am I missing something here?
>>>>    1. make sandbox_defconfig
>>>>    2. Select CONFIG_VIDEO_TIDSS via menuconfig
>>>>    3. make -j`nproc`
>>>>
>>>> [1]: https://lore.kernel.org/u-boot/20251105164114.GQ6688@bill-the-cat/
>>>
>>> v4 drops the header in question :)
>>>
>>
>> Hi Tom, as we have the patches tested and sandbox builds also fine, does the
>> series look good, could it be possible to pick it?
> 
> I've assigned it to the video custodian as yes it looks generally fine,
> thanks.
> 

Gentle ping.

Regards,
Swamil.
