Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBBFEC0E6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E260807C0;
	Tue, 24 Mar 2026 18:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lzboblWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3589838BB; Tue, 24 Mar 2026 18:25:22 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AEC80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzh9X/UldP9lF+jFHrXeKsFatoSSpFKft+bBW//0vTyBEoheuGIEd+BlJybKVq+1JSi4aKdSzRw7wBlKAm1TCGGydMlaRhTSmYTMxWDb5AGoHoAqVeCvYXjR2S48MMcDdehnmPdvkluxYZ62ZnygzI0SJLmklbJ8gTgPmtna48jtMZYon3/AXKyhn4wyYKaFN5r2eBBoRBQbkvPLJZmfAN3fR1FzZ2NjVyysz4jskSxe1fzU3TnevloYFGMcJKLE5csRybrq4NBm+YCHl6PkQnEkuwfMu7fOyKcXHko6tDtv4Pvz6PbsHnb4/agZdsyHyEUqyanR+2hFZxpDABmdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRleysXyn2eg1m2XfsO2Xod13XpPmbv3ddB+M4NuYrU=;
 b=SUt7unpG8FtBacXHeqfQE00DGyIXwdNr+nqKEygZ8BpF0bzing87f2OQ7+e1whIp0Llb6FTVL5xtZN7F+nxqkb+7XfJTbCZL4Ld/kP2Hw3deEhhuJvkDWfs6vV4HIu8jPA+z2vMG1MF3ztbmw3pnG+8Zo3DHk+C9wn8yzFCHF9TIvgraykAcpEBVUfFxJ8TPXngG7zzsWep5vI4UAA69h2rPVd2S/rfnb6IYK8SZyi5dV9CdRvRArv3TqipyU4nJpnHb80TOJ1+29PPMBtMi1EPQMuyDorSXU3S/YsdfXbXqHoBfUXjNMuHs5/j9NCTCvzN6FHl77cijtOx5inJTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRleysXyn2eg1m2XfsO2Xod13XpPmbv3ddB+M4NuYrU=;
 b=lzboblWl2E0yVfh0EWL1DUY4UsC4qpbMZDBMeW1D9ofo38HkBcMpwrw3SQ7jvyEwukffdncWbkV5fV4bmiro1ck282608lRKQd7uJy3jMYahNJHudRUsjRu7C0yQvSENU6GhbBtJ4VxYnkZFg262tMzOGVRx7svozofO7iExaT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10908.eurprd04.prod.outlook.com (2603:10a6:800:26d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 17:24:49 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 17:25:07 +0000
Message-ID: <2d220428-936e-4ba3-a888-c7331bb7355d@cherry.de>
Date: Tue, 24 Mar 2026 18:25:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot/fit: remove useless else branch
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, James Hilliard
 <james.hilliard1@gmail.com>, David Lechner <dlechner@baylibre.com>
References: <20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10908:EE_
X-MS-Office365-Filtering-Correlation-Id: 050b8338-1f31-4c61-6584-08de89ca4b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: rtbXnGf4iJNpyXk/py9kbLmTdoJJYC5a43NEOZcFCh60KKFctRz6IC4C3LdFHLQ0G5JoSespvADAUs96pLaWV1uizwN20fjHGyblsESq08CgZCh/NOIC2k8PubKPV4jzQ5kvEf8lfVLNC/RfHdhfhlHLPc/DCkkuX4cYWr2QplteOK4d5bM8TdDVbwelo1znv4Rn6PB5J4bN6KI7RAcf3huorwNQRKBnszUO+3ddK8lLmQiYxmN1aaHtRb8oXQZqiS1lSC/jAbc2uorqJFpfmroLzCcw30Ilm0ftzwWcp3s27NsL2sW+udbp0uBP9WlxeQ+ma+svZvNWfimGgOf8GqHJO+yz1C5h2QLiwLFEvNkkkuWsErbJfQZWHkHWfIJosoY7VxKV1HlgkOZHh+OWneb+aBsIHW38+Gf+Vd8wHeabUr6H5fzZxBomJloym6Kmu6ChcCObF4X+p7wmqpsQYuuQFsDukXDxfTz3zDMFjCEiXCykR83YYCT6uhWL3GtVNcem8UYlaNBYJW/nKR6LUvu8fguXRLNsKAm874YG7vDCWuB67Bq+PrzoXKDZxNpbw0MlO+kaan0OTHSTlvDJhYEuW/lUVIrYJYbChRfNBgvA8mKe20SGBN4FmvEKoyOmxjhmShrogWUMOf5WZjiqYGMmvJyzPX/jrOzFHSuLy8sa9UQLTMl+zQLg4EAuefmaVn/xlf4Y5wsyFU75PfDO354/flZOaJRJEeOu/WRs2Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3QzdmxVZjhEZHM4WlVWR3gxY04vcURmRkNCc3YzQ3ozVm9XK3p2VlFMOWFa?=
 =?utf-8?B?UkdlVGNqd0RrcERHaDBVV2ZnWW5Pa0hTaE1pc1VqVXViYmxIMTRKWUI3UWxP?=
 =?utf-8?B?MU9DdDRLa0RYSXYwa0ZuUDF5c1dlRUlyWFMwcEVCS3NSekd4dCt0V3U5SU90?=
 =?utf-8?B?Ykw1UUx4eUJtcm1TcnFrT1BjeU1YS1k4dTl5TzEyN3A2K3JSc3NEMWVpZHRW?=
 =?utf-8?B?K3YvRUpQRjZMUmdORTA0RC9zbTdZQWRucUlueUpURVBxdVcwSHpPSGxKUmwx?=
 =?utf-8?B?elZOTVZwNDBGQ3dPZ0NsUS9XT2czNkhTdTJXMDUrSnh2SmtSazJublVzSHR5?=
 =?utf-8?B?US9aSy9PNHU5SUx4b1VIZzF4R2lIdXM0aXdYdjNtbTlNMnZwV2tzQWo0RWdR?=
 =?utf-8?B?TDBNRGJuSXNVdXo4NXBxWTlOdXhOelJXNGlrSWRXQkdCOTZnRUx5enM3dnVx?=
 =?utf-8?B?Vk5Sem5rNXVYaUFsTWd3UkJmVm5OdVR2ZnNvV1hpN1VKbXlIS0lJSDc0WFZr?=
 =?utf-8?B?dFlrdWRPalk5OThVN2EwMFZKcHExdjgvYzgwVzdkTWQzSzhlN0lZQnMyK0oz?=
 =?utf-8?B?K055YllLM1hTenJJN0J5dzZ1azNPVWNMSnNqWnRzakdRNlNuSmZnQUk1Y2M0?=
 =?utf-8?B?NnJEZS9sQm1RVXNGSjhHcEVORkxIRkE1WXF2MmF6bnl1WkNFRVErSlY5elRG?=
 =?utf-8?B?MFFQTyttYWRRVTcvdmg2S1g1cXJkamU4eXRUQkRSUGE1dlFBSDhSa3dVOWVx?=
 =?utf-8?B?dkZCMlp2Ty9QYlFVbVVUa0RKT21HZEZYM095TFBMZmpxejBuUzZiY0JNNmNm?=
 =?utf-8?B?YTVLRjVjcjIvYUtDZkVyOWpOeFJxN3Q0aTNuNEN5OHoxVjFwUUtROHpCZUFS?=
 =?utf-8?B?a0g5T2o2NEFOYU1uQkJ4eGxGSkRaWGgxdzN2TFovMFpEeGU1bEpQNlllNEVW?=
 =?utf-8?B?M1VFZEhZbDRjUmVvN2I5a3BWSUMzVTVKdDkwM1c5SmVEd1J2YmQwZnpqS0Nz?=
 =?utf-8?B?WEdSWUhFZHZEUU43ZTVYWkdja0lFQlFqRlpMemxPaWUvNlVOSW9HbjRaSG1q?=
 =?utf-8?B?ZXRsLzkrdldpUk9sekEyWU9sVjF3aWVrQ2JPNGZ2eGQwN2ZoSjI2ZWVpbFcx?=
 =?utf-8?B?Y0pCOXppWmNOSmxxMHlXcmFTUWRGc1hqYUNFWUtaSm8wMkUydHBwZGVBbm42?=
 =?utf-8?B?bWhLWmxYMmNoNWxxMmtCMWg5WXZzcVhhL281cnA3UEdOUXFlWXIwRVlOeFVQ?=
 =?utf-8?B?SjJzVXNyRXUyaTZqTmNnbWllYnJXWEUwTVFZbGR2SWVXV0Jwdzhwbnd3UDY1?=
 =?utf-8?B?VHVwRU92cEpESDJXRlNEVGZxSGhvdmliOW5pVkZXZURZTi9yUjJoTjVmWkRy?=
 =?utf-8?B?K3BZalBXaUhoNmNGeDFXU3NsbkFOY1VkRnFZQkhGdEQ3eFRCaVR2Vmh3dzlv?=
 =?utf-8?B?Q3JWQ25oVlN1YnVYVmVrZTZkazczb0ZCenlFYml3RDFMVVRvRjdzUkZNZVBh?=
 =?utf-8?B?bDdpOHI2YXc1R0o4TmFJNm8zcjYwK2hrUDI2bTY5emlRZkpSc0ZYSkI2ZVRv?=
 =?utf-8?B?Qlc5ejkxTmpmeUFvN0lCWlpieE94bE9ZUVE0NFhHM0wxQW5YQll4VU9CaFZW?=
 =?utf-8?B?K3FzVldSWGNvTHRnSXgxeGRPRjZjOXVqOStGUlY1VWpuVFJxSWkxNmxvWHly?=
 =?utf-8?B?ZXJab1JoY0VISU9sK21FRjE2bEcrWDllelNOVGF0UVFBb2ZsK01ZVzRNZDRO?=
 =?utf-8?B?VlF2NCtQWVJPOGRBNjRLQ0d3MXVyVm03Qlc4d1JkWEo3OGxsaWpnNUwweGN3?=
 =?utf-8?B?TTYwOVREaW1wdEUxWmRpaFNCTWNWajZKdjUreG4zcFBheUI5YWRndGdFYko5?=
 =?utf-8?B?aS93dHN0V1lvK3dMM3NWcHpFaXVyMW5qVUZ6WUVzM1dEYnBML0V1ZHlUNkhF?=
 =?utf-8?B?ZFdiUU0wR2JBcmRXZlRkK3p6QUE4OEQzckJSWUhSN0pmU2hxRU8xVGJodjVH?=
 =?utf-8?B?ZllFU2NBYWFvWTUzeTZyUEx3bXBVT1hmeUdqRXNhQ3ZCbGRTYXQ5VzJWNmJu?=
 =?utf-8?B?Wkg5Ni9YbGtneGFnZWxZTGx6RVd2MGx3M2J2QTJRK0FwQnZ2aWptemIrMU1U?=
 =?utf-8?B?cDRieDFGZHMwZ1FBMXR6NG0veXpnZTZwY2l4akFHQlRqZVJBNlVRVGdDR2xL?=
 =?utf-8?B?NzA1ZUxzdERQZ2RuMGRSblFkUUhJQ1BZVmNFUVdZNzgzcnNrMXVOdTlncFlU?=
 =?utf-8?B?VksyUUdsVWl4QzhtTjNvVS82M0czd3dDQW1wUm56NUZUcnBjZE5GMENwamdX?=
 =?utf-8?B?QlM3Uk5yTCt3K0hGamtNaVFwVmNWbDRWL0FhcDQyMXBYV25GSXF4UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 050b8338-1f31-4c61-6584-08de89ca4b5a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:25:07.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq/44nqkr+Ga8bYREXfo8WJabIlS55YD3ON2ewrVtQ6xixcG4K47PMXTB4a26ur5wzpQLSbuf4lC/AMMCKBirGXrGe081NZUYo3TGqwdwLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10908
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

Hi Julien,

On 3/24/26 4:33 PM, Julien Stephan wrote:
> The assignment of load = data is already performed before the
> if–elseif logic, making the additional assignment in the else
> branch unnecessary.
> 
> Remove the redundant statement to simplify
> the control flow and improve readability.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
