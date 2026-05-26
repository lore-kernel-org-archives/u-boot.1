Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AACCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7AC8404D;
	Tue, 26 May 2026 14:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="SyGVoNEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5AB844CF; Tue, 26 May 2026 10:58:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC2D846AA
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 10:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWDJSXF4OJ0H7zKVN3yXRQkiRLz03u3r/B1wEGcbgLWtoYk4dkivMTkRhCEOzvMZEUbuEAw1FORDl3ptVuFVQmbiorRJuiQE/OP50+MLo/gD63niYfhOzm8W+YnKOy/NyjIraJFaoVT4x0REmV+ebMGBFatyI31jdgLXbgXBEcJ7wOOnN4Z5ak72bwJQPnqZb75fMd4/yf3oqVJAqWKX5yRcTM4JM/77uUn3XHbJlwR7EN92Q6pcdNOIitrr127dp3TO6la2RzNYNLQp5phsPa+y/UxA3OoF0RmPNWW0vl0NXb7nCdsWipneN9nnrVXgz6KpeFEYyR/7purVbosziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXBP1JIS4qNv+Kr6Cb1UF/+9Rzi3WNC5Kj+jhTjf2aU=;
 b=RqsYRzql79VmdxbIQmStmVpIIVbW+72BOc4cclN4bZgc41BYEdf9WhcXlr9MnOAiQ6EiEEQdcGUoNvs6kvp2a4/qpUAGQK4e6aZDEun/9ud4vdLgerAwd+DHeLb2ZVG5wSbA8JzkNGIJeZfmfNJTKjxX3JbLFdSJpQ63F459gKPYZ4zuS5vjmGsAss6eAa04iOAMZJzSe3q0o4f+WHZkO94sxTekgOcUm7bWfQYg5ygZStuJ23+cDTWSUBc0U931ovk2kmSd2WVAPoHM5YiUVoKU7PK0OFueINlBu38iLyZk5AWeC+KoM2Jp2RWGdiVkUhyTAL/iLtGbebmMnYQSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXBP1JIS4qNv+Kr6Cb1UF/+9Rzi3WNC5Kj+jhTjf2aU=;
 b=SyGVoNEYAuIf4bY0/4dtPC1RGEehEr0PdxdS6LNTfT1Ka57Dd5yWeRFR0UwPOogTI68qxT5pEAfRk8PemNagxxSrFGpUM03PuhZrEQdEAEpRjIcvmaHUW6IMRgsZEWGg54quu+1oeKb8zBlk4jjOoef9ZOMrPd1o9t3GOHPpYQ/Phn19/vx+yZprZKP2RCgM6Qi/cnMjzeEFLjs3DNFxESXbqBZzhv3i8bRTtmqoVc2i+IJPzKb1tePPqeqqYXKh7h55B9I0l5BjgjPkXf/ULmSe4Lx1HOrq6Noja4MWEf8HzvJrxT9Vt6MKdKyx/Xe9FVH4+tYc6v2Xew9lZbPELg==
Received: from FRWP194MB2790.EURP194.PROD.OUTLOOK.COM (2603:10a6:d10:187::7)
 by PAXP194MB1423.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:19b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:58:16 +0000
Received: from FRWP194MB2790.EURP194.PROD.OUTLOOK.COM
 ([fe80::446e:193c:1864:92eb]) by FRWP194MB2790.EURP194.PROD.OUTLOOK.COM
 ([fe80::446e:193c:1864:92eb%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:58:16 +0000
Message-ID: <FRWP194MB27908D1150FB7424A8C57402DA0B2@FRWP194MB2790.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 26 May 2026 10:58:13 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] rng: jh7110: Fix invalid usage of dev_read_addr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::7) To FRWP194MB2790.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:d10:187::7)
X-Microsoft-Original-Message-ID: <2da231da-1fd6-4c98-a493-05f400f22190@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP194MB2790:EE_|PAXP194MB1423:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f82f70d-989b-4d7f-b729-08debb04ecb8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|5072599009|5062599005|6090799003|51005399006|37011999003|23021999003|19110799012|8060799015|41001999006|24021099003|55001999006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3owaERiL0ZOTnhZUHQ0WEdPekQ5Rk9lYTZCNXJjdUhPM01zMGlKd2swcGZ1?=
 =?utf-8?B?WlpKQWJibFAyMkNYMnZBd2RiZDdDNzBCWG5aTWJVTU9wYk4xOUFRTFJCRTNX?=
 =?utf-8?B?RXc4UVdOQWxMUmNJSEZqeDBpSjAxWmJaYU1EeEwySEo5dkFSTXBOSHdwRWh0?=
 =?utf-8?B?NHZoK0RmS1NYLytuSjhYVzIvSFUvWEN1Y3BRT2dMbW52aHBFK1ZXRHZJOUIy?=
 =?utf-8?B?YWlvRkhydEJ1c2Q5TXBUTExmSDloTWdEdDhqOTA2cUFSWS9TbVR4dE9uV1R3?=
 =?utf-8?B?aU5DVjEySmNJWFZQOGUydFhEQ1NKcW14NU0xbFRidm5qVTRON2FnZjg5dGlO?=
 =?utf-8?B?SEFPcG5jS3RDTUIyL29IRWkyOE8xUmxad0cwMm1oK0JvT1dDU29OaEtVRU9P?=
 =?utf-8?B?TzhpaHhLcUdsaGF6Q01tbTB2UEU2cGhvc3dhZGpzaEZoNC9mZVcrT1ZjZGNl?=
 =?utf-8?B?bFAxL1lHZXVBc0EzS2IxSzZRQTFUaGZqbXArU3dyNkhQVFF1cUpCVjEzWlBj?=
 =?utf-8?B?Y2taSmZDbkZwNXZxQWFCY3kva1dPQUY3bFlzTzZPWGc1bTdZWDlXVjR2MWpH?=
 =?utf-8?B?c2t0c3VTWE1XbzFBemtXb2pPc1Z1bVBSV29Uc2l4ajN6Sm5oV0Z3SnRCb0hR?=
 =?utf-8?B?Mmd0b0VvTGFOQlhMMWQwY0k1YmdSMmY1VUxuRWtzMkNYNkVtYXhPVmNEdVBU?=
 =?utf-8?B?algvVEZTYlRvNnlWWHh4Nk5PMmZmc3FDeVlTbzI1dFJYMitPQjdtc3R2aHc1?=
 =?utf-8?B?STB2V1dadW16YjVEUlhMVFZ5aC9PelVmRklxQTRJeGNBc0R1S2JEQXlBQjVJ?=
 =?utf-8?B?RS9SRTYvZ3BPdWZOMmNacU5LSml5UmR2YXR6QkNBQ1dYc1BsZGh0KzVZa25p?=
 =?utf-8?B?RFpuanFwMFdQTkJacHZ1NDVrWUwwY2FVV3J3cWtOeG5MVnYxTTN6MlorR3I2?=
 =?utf-8?B?bnJRd1F4cTNjMmt4U243T3AycXZVY3ZmeUVqVFl3ejFHNU1aK1U5WFYxcnFl?=
 =?utf-8?B?QVFVU3pxUy9TWk5aSU9PVzBMVDFpbGNMQ3VOdzVHV012SFdlUW9hM2tEZ0RQ?=
 =?utf-8?B?dUxwdlBveWhBQk5SL3hvYlZvM2NGRDBkeXhVRTZVeGU0ZVJTRys3SGNoNjZB?=
 =?utf-8?B?K2oxQWdQbWNqNTdXNlBjWjhnU3Nqd0RnaWVUb2NuM1dxVDhIZkwyMnBmdTlD?=
 =?utf-8?B?K2pwOTdYVW5NUkw3SnRqRmtQa1BVTjVuQWhXQlRxOWhwcURFelBoeGZCMG1Z?=
 =?utf-8?B?N3A0a093V05GS1JZVTRGeXV2eS93T0J6a2U3WWNJazM3WUVMSmYweWhETE1Y?=
 =?utf-8?B?MzRnVURlZllZSURtay90a1NaZHFsbDJHeDBUbCt1cUd0cnZBNGtmQzlxeVJH?=
 =?utf-8?B?T3pnbUl4c0VoM3BhMDlNQnlmRzNqSWZLM01TZUplYnFOYmI2LzIvUWROYmpy?=
 =?utf-8?B?empSZldTbVdpNWl4VU5RQ3I2NGxDVXJrMElVWHN3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0toZkVRL2gyR2pZeU1RaXdIQ1IyblpoYSsyVzZPeC9qMmwyNHFwNTllc1Yw?=
 =?utf-8?B?R1BmczN0bHlLb2IwM0g2d3pBamZuUGRxM3BoRVh1NVZTTFRCd1QyUjg1d3gv?=
 =?utf-8?B?Sm1pNVpkT3hNTHRHOWVFNXZCSWI0aXJjdEpqWVJHRWtzNC83akpXNURkSjRD?=
 =?utf-8?B?OUJCN2dmZkFZZlRPMGxBeFJsTVpvZlNJQlFrQUUyNytxMGoxY2lnWnJlbFNx?=
 =?utf-8?B?ODF1dXEvOG95Y1FabmEvNHZvVFdGekkxNnczWkFPZjBFQ1hPdCsrUFJmM2JC?=
 =?utf-8?B?eFdnYXRqY2xOZkdlN0RDWG9EcENlVEtKMW5WZG1POVVnd3hMYVhWRVJLWGh3?=
 =?utf-8?B?dU1hUlBydTlHWittYmM5aFZyeVRFbTdyek5tTVduRU1aU3JIUjdJYmxCYktL?=
 =?utf-8?B?QzdzWXR0UXgyTU9hY2daSnphYkhqakxGSUkrRUU3YTNla3E3UHBZK2FRUUlE?=
 =?utf-8?B?SlpNWEJGSDkxaWdLcHU5dWlpcHpRamh6RDJ0L3psWmI4MldUZlZsN0o3am9i?=
 =?utf-8?B?cmxkYzFkMkpXbUJVLzQ3Q3VSejVJUWJQZWV5ZjJ4eStNeXJ2Slp4eXJLdStY?=
 =?utf-8?B?NHpUS015bTlzYk1MRU53SFZnZ0x0bUpCK2tKUCtXVnl3SWdSSk9LK25pK2po?=
 =?utf-8?B?aFFROUp4SXE2MlhZK0p5Y0szQTlDU2RxME5lUlcrR2pIUUhTZENINEZrTit1?=
 =?utf-8?B?M3FzNjlkUXZvRmJDMGF1bTcxcGZDQVNpNVR0ZUR1OENZUmVqN2NnK3JhWW1i?=
 =?utf-8?B?eG9BeTQvY3NEODJwQ1Z1bFpvS2l0LzJGRHZNTlN2WE9lL3VmN0dGeU5xeWVz?=
 =?utf-8?B?V0RGZWhaUHorRkdnaGtvZmNqaENRTzZSN2lxbG9IaWIxV2F6QUVpYlVTWFNV?=
 =?utf-8?B?d29sZ1d4cXZTOUlLVUxubEVQblByR3RZYmhpMjZCVzVNQ2pJd0ZjQzNSREVs?=
 =?utf-8?B?K2V2SHhBN0h5eVcxU0h1NlVjNGxpNU4xbFk3OGc5MTVUMWs2VXdsenUxaHAy?=
 =?utf-8?B?bHY4SFpIc0NhRUpmaVNOQkU4Mi96aTg0VWJyNmlNdS8vbTBOM1JVeHQzL1d3?=
 =?utf-8?B?SDh3cHNlS2FwRFU1UTlNMFdEVG9HQ2ZFVGU2MnlIL1M2bllLYnhkdnBpL2lG?=
 =?utf-8?B?TTBjTm4zMXdXck5nWlJpclM0N3lXT1p4eWJWYSs5OXVCbmZPL01EOExBdFVq?=
 =?utf-8?B?NWVIK2dRK2F1ME1QU2FBd1RFTStuL3Z2cDdkMFpyWjc2N2dJNllIZkdGVDNW?=
 =?utf-8?B?VXNpMnlSb3BlR1h1NXRpekVqK0pqaFJuRDl0ZkJYZGV3aGtHZjU2cUpncm1D?=
 =?utf-8?B?ZjlrUUR4Q081bkI5bGNML01qa2tNQm9DUU8rVlNzRTZvTklXcEVHZTd1aXVB?=
 =?utf-8?B?U3RUbXBFcStzVklsWCtsT01ZMVBqZXMyNFpQMEpGQUlhQnd5Y1l0QUkwVVlm?=
 =?utf-8?B?Z3d2RHlYSVRmeCtNdXBUTTJKTWpIV2NwcXVGLzZiZktMWFUyZGVlMDVoQndH?=
 =?utf-8?B?eCt5K3ZPVDRnUmxBRW5QNWRBMitLazRMaGhGcnl5bDR1T2ZzejduSVdMcDhi?=
 =?utf-8?B?Vmx3RFlxR01SWTNsUVhzZFlwREpkWXowNGYxenA2T1NYUUZKRXZLbXhhT3J4?=
 =?utf-8?B?TlRld1RVclpFRGc0YjVKNm5WWU5uVXg2MHVDUWN3TVl6WHp3SXNTTndOZzZM?=
 =?utf-8?B?bWhGaDFWUEF4K3dWaHNhbytmSlpaWWVTQ1I4UVBja2haVjhRWTdSUUN4aFJS?=
 =?utf-8?B?dTcwd0RyV2lXa2Y4SkhWeEJsTWRBR1ZhcnN2Nit6aWI2TVo0dlFiM0FOS0x0?=
 =?utf-8?B?cTBwS3FzVFVyQkRmVUxOK0tGSllFWkp5L01nSDlGb2JUMVA1T2VFZmwxWFk3?=
 =?utf-8?Q?niiMKB1o4vWOy?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f82f70d-989b-4d7f-b729-08debb04ecb8
X-MS-Exchange-CrossTenant-AuthSource: FRWP194MB2790.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:58:16.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1423
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

dev_read_addr returns FDT_ADDR_T_NONE (-1), not NULL,
in case of errors.
Replace dev_read_addr by dev_read_addr_ptr.
Replace error to EINVAL.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/rng/jh7110_rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
index eb21afe4e7c..d54898c67f6 100644
--- a/drivers/rng/jh7110_rng.c
+++ b/drivers/rng/jh7110_rng.c
@@ -233,9 +233,9 @@ static int starfive_trng_of_to_plat(struct udevice *dev)
 {
 	struct starfive_trng_plat *pdata = dev_get_plat(dev);
 
-	pdata->base = (void *)dev_read_addr(dev);
+	pdata->base = dev_read_addr_ptr(dev);
 	if (!pdata->base)
-		return -ENODEV;
+		return -EINVAL;
 
 	pdata->hclk = devm_clk_get(dev, "hclk");
 	if (IS_ERR(pdata->hclk))
-- 
2.43.0
