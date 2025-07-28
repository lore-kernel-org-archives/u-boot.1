Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29027C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11BBA82F8E;
	Mon, 28 Jul 2025 04:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XwzGZH3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE2A830C8; Mon, 28 Jul 2025 04:14:20 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA2D82F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFN1D55/DgXLK5aLk2qk7HPcsKNnbjVddsxxGGFh1iaU5cAWZzEPq/jA4BaTmg/uR60FWr3hFrQVcDyTg+tMt3iYtRXW5IdlMR0hadkqggJJEErKZUancxAaFkMaD7cw1JpEIwd1ZOkPegRkjHHp74sei21zDFt9GZpAU7jKqlWj1mGYZShvbOoiYRmWLhmFnTajuhLxM3WCNoefH/E21BkM5qKB33T0ZoYCy30KS+bxwKTQN/cyVt5RZ18+x1oZICYEcCFJBD8hSwuRQ4I47JJMUqC0yTNq95Uaq705ZDTqFx6Tza0oqu6A4nkjHIhr/ap2LK2QYummAnPrpqXCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oF+sryJXoOg/fRVFxRQwuKJRsGNIYKpyiwGySh3jcU=;
 b=njdscgjdCoXcz0NEZAZZD+qJlPMKqGivF0qAHNPmyp24uVxtdHwaWT9dq5AV1wsB+hd81l6K9L7SqXM5fQndVndDfitEKq7R/1l9Td6jzx81b6k7JIIE3+HpibEv5/SczqL0XFPMlVhOGBcr/h6F6erlxYVv5sm5Ho0Ho5Uok7KPm6mMJu9rnHmx/muL+5eIjxLQpV5+lKPnHdQCfAHXew0VbQsnL47U6dOF5MTzGn58jlUxi1r57crDNNVZhT4D3kmSSpIa2aYd1QirEdnANt1I7qy+UikemFhBhPmkjOCsEUxxzElbrqXB/V4oS6EBWWFueR7A0jx7I92l/+bp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oF+sryJXoOg/fRVFxRQwuKJRsGNIYKpyiwGySh3jcU=;
 b=XwzGZH3u3gykdpyFU5Gae+MEolTAJ42DyCTUmuFKh5arY71y3ewKQSDxd02HvcA35pJi6YBbEm5ZzoONxflQPT8vA5UB2a46jmOF6mMFNF5GLb2BCoZMYOY6VKlVRGF/lQSPxflEym20b0WQ29qN7tdFFcjKt1MWqSqZKJjW3iL91xMfGZ+66TXBbvmvPs/JQXV79wIoF6O8frankjGNn0CUWe3arHHHQlDFIc2BoV0Js3PEYl4/0vL1HAmhigvBxovn7Yu20wqahhXFwN1OClCbjXd6m8QCtubykkg0UejZyJsQ+L0Xz2fHqmkJ7DhzhZIlZWgwL1qVSRp7MSVdVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:47 +0800
Subject: [PATCH 1/9] ddr: imx8m: Fix DDR inline ECC scruber configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-1-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Oliver Chen <oliver.chen@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc6ac0b-b812-42ba-f8ad-08ddcd7c74a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qno5dTlPamxRMnZ4WW50bHozS2JBQ3ZMcG80aGVLNFRGK3c5QXdJcW51VzZn?=
 =?utf-8?B?ZkdKM3p6QndCUEt2dWtDRFA3OTB4ZlhPWWk0L0tiRzNseEoxN2Jjc0pjZUVx?=
 =?utf-8?B?MkNWd0R5NmNzNVkxRDhuNU5majlpeHZIM3Azd3ErMUpDNDYvNnRMRDd3ZFJt?=
 =?utf-8?B?VXU1dmhCVjlua3Axc0k1STVWcndBckR4bWZEU0xWUGd6NFB4WGpzcDBvSU9x?=
 =?utf-8?B?cUJad0dBWGw0eldkeXMwL2s5VzZoSW9HaGdxSVJJVXpQY3pJUnEyYlJUN1pJ?=
 =?utf-8?B?KzNRT0krNlpOZVdsaElFSnZ0eFJsRWJsVW5DcUxlTnJpREZIRkE0bjFZZUtR?=
 =?utf-8?B?NGxmaENlTlNHYkpheVBxa0hTWUl3dUJ4dHY4ME9SYVI0OE51bkM3OTZaV0hW?=
 =?utf-8?B?cHBWQUFlVGdnWklHM3U0MUFOUnBrNG9DYktuWjgzSW9FT29KbGwwNCt2cWND?=
 =?utf-8?B?TEVYd0djeFh2K0ttdE5ENEVCZ1B0L045L1krT3BmcHJTNlRkVUpFcytXRmtw?=
 =?utf-8?B?dklUUmVvL0dxaG9NZGpJYnB6MjEyT0NhWXJERExhenpTS3NSTFZyeXAzcmVQ?=
 =?utf-8?B?cTM4RjRnNGZOZUR3WFFETlZ5eXY5eUZFdE9rSytMOTdkODlKaWRwYUt5dlpq?=
 =?utf-8?B?RTZpb1VRSll6SXlHWEg4WW9zUWt0a0hnK0pwb2VJdzNtQlNVN3hPNkcrNWZo?=
 =?utf-8?B?aGpMdFJwY01USVRidnRsa0cwSjRHa3ZBQkNIdm1tSzVPb0F1TkxyZjRaYnRJ?=
 =?utf-8?B?aWg1ZTZUa1dpeFNUTlVJcmNWRzJYZWFQUGJUQnZYY3dtaXNZVHVPYm8xZWdS?=
 =?utf-8?B?UmNldkMyVDlRWjM1aGY2UFRuVWhuRVBJMjJnSkpPbi9oRjhyR3RaNUJRbWY2?=
 =?utf-8?B?QVZSTGd3TmpVMWpPRkJzUWpoQjlKYlZaR0xISUlHTmY5eldyYVBmeTZZYWh0?=
 =?utf-8?B?WVlTNHpNaFU2cmZ0M2tZN05tY3pOSjBIcFdhbjB5Lzk1OTlMemp6RkZLSEg0?=
 =?utf-8?B?Z0JjQjROK28xU1Q3M0FUMWVGekV4Z3JQYmlWclF5cWQ0OGtiSmt1dFNZdEUr?=
 =?utf-8?B?Yy84QmJ3dzNMdGZVQ0JDOE5XN2ZhdnlKYy94WWxLQ0NCMFVRL3pPbGg3aS9V?=
 =?utf-8?B?Vm1BNnpWYTErOGlqL3hTc3Azd25oNWhuV0UveTdCTS9rZ1pHMVNmSzB6MnR0?=
 =?utf-8?B?amxJclYxV0traFJuaVArYnpZR0hsWDBTbWlPL0M3NnZXUm80Q0FZeVd3RWpk?=
 =?utf-8?B?OUV3ODkxK24wVjdhaVhKc1IyOGpVZWRzcStNK2kzblNyVUJBWkt6TFNBYUFY?=
 =?utf-8?B?bnNhUVFHdGNOZUFEcDlWK2FLRnhNWkVobmN5bDUrcHVldEtLOTlwbVZnYitQ?=
 =?utf-8?B?d3QzUERkaEdyYVEwVU5KcS9Mbms2Ulhjem54K2pyckt2ak5STi94ZDMwcDlX?=
 =?utf-8?B?UW5vRXZ0V1Z5cDRrMDVLUFJRSXI1OUlLUk10eUJhcS9LSC90dkRuWDhhQWpi?=
 =?utf-8?B?VkJyL0ZycGo3QXZqUWFyZzBKYmFZbXQrUzg5aGgxTXVWK1daRHI1SGhqNWlr?=
 =?utf-8?B?bWlzVG5yWGFGbVZHMUVQR2NEcmFMd1VMZVV6L0dHUkJ0cGNhNlpRblNWMVdD?=
 =?utf-8?B?RXI5SG9iOUNmVnlQSVVFZnA0OTdraHlDdjczVDVTN0t4WmdmTXNUd0VFOENL?=
 =?utf-8?B?SXpPZ2FTVXBBem1NOW1nREJwWnFUWUpEckV3U25pOEtjS3o0VkdIcnE0K1VJ?=
 =?utf-8?B?cldCV0dzSmc5ekpYVFBST3dTcERjNzk3MnhvR0c2SFhpZUlXYVBXbkc5N1M1?=
 =?utf-8?B?Zk05azdzRXV2ek0zYlRHRDNLaFNuMHBBOGx4QlhGRFNXZkNsNUxjSFkxZm1z?=
 =?utf-8?B?bkJSUmlKSkJqN3BBM2dQMWtmcUVkVmVhbklGNEZxZmlKRlNCSWQvWDhPK0o1?=
 =?utf-8?B?ZmFrMFJmK1VveGQ5YkN2aFNqa2w2MVlkejVjRzF1OENVM0ljemdLdG82SURo?=
 =?utf-8?B?V1VaWHFvcGFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWttdkFBQUhmL1pjaFMya01DaVZVV2IxOTNEdUI5NGFyb1Qya01yNDM5dmNy?=
 =?utf-8?B?b1lEa09DVGRhMno2dWMwb3lUSFUrUGI2QlpiYUNHelFKcHNOV1k4MS9CWnFp?=
 =?utf-8?B?QzFhaTBRSDdLWlg2OFlGOVdRZEpWTGx0aUlVMGNMWndLNDRoaHZ3RWYwQnpN?=
 =?utf-8?B?MS9iVjhHbFJiY1NHUE9aUFpTR1lsNisvdElLWjlGOWEyNEIzRzFpSWFGamxr?=
 =?utf-8?B?bjErRFlqV1BRSnEzRW1zSTNIaVllQkFYaE0wdUZDZXJFUnV5ZjhYTkEvLzhT?=
 =?utf-8?B?UzUxYU8xZGJucVZxT1pSODVMRE9XZzlvbytLT3ZMRStXOUVFNlp2QkRSWnRP?=
 =?utf-8?B?aTAxc0I1SC9sT2NVMHJrck43elNWK0JObmZ2U2gvR0g3TkZGRHBEc242b0ZK?=
 =?utf-8?B?NStUS3l2VGFaR0tyR21CMWQrUU0xT2Z4blgvdlh1aHA1TFptNkgrN3pCWE0r?=
 =?utf-8?B?RHpxY09kNUdKWGZHNStqSHhrN3lxTm5oMncvVjY5aDhsanVsSGh0UGFMNEx5?=
 =?utf-8?B?WkU0L3dqZFF0b0FzUkczTkFVblg2M2U0eDRFQVJDNzRTSUFXNUY4WUxxSzdh?=
 =?utf-8?B?S1NpYjZSaHpud3hwNGx6c0VDdkhuOWs4TUhsNXJWSDRkY1dlVDlYRm9KdGU3?=
 =?utf-8?B?SGZuaXBoajlLakx4MnBpTDI3MWZnd05INmlpS3Vsb1FtRVloS0lTR1BweENE?=
 =?utf-8?B?eVdZdVQzVllLL1RwVUFIeHRHZW4vRmc2eFBQbDNsdlFWVG1iTG1YUkhUdXF2?=
 =?utf-8?B?MFZlNXFwQ0hZenJsOFBvWDZvWmFreXJuS2lFV2dJTlN3TDdHVzgvWTF2Y1VS?=
 =?utf-8?B?eEs0clhuaE5zMGErb3BYa2Y3REdnWlpnZVAxUW5EMWEyQnpCd2Y1eGdSeGRH?=
 =?utf-8?B?VWhOQjYvMXZUbmRCMC9DNG5HQmpQWThZTUYzMlZhSmF1K3lkWnVETnZOcUpu?=
 =?utf-8?B?Yk5Rd1pGNGx5dDIrUjZrbkR2aHpnZW90Vkx2c05XZE1DSDRKUjR1ZkpkSWdJ?=
 =?utf-8?B?eUZ0UDczZlJTd3llZzNVaGtrNnlmTlZ6VDl5VVovMms3YTJTUTRNMFdnT0t0?=
 =?utf-8?B?dGpsT2xyS0R0TWNOMm9WU0pUSFRySGZndy9iNHVWbWhuUlpiaUZiaWpXc2U2?=
 =?utf-8?B?eDdyQkVBSGRWMHUrL3AxWVgxVWRMWGxXeW5YOWgrbTFYajZrT1lTMDZMSTZz?=
 =?utf-8?B?V1U0N3R2cHJpMUdYcDdWNGpMTk1iT0xFZW5kNHF2ZkdYZW5ZazhQV0RnVDVq?=
 =?utf-8?B?VUp0Qy9tU2dRd2IzN1V1elRnV0IxQ2E4eU9BUk40d01KY2U0eHUvd0YyQzFT?=
 =?utf-8?B?N2RFLysrUWRGNlFMNXZHRVpqMWQzWVhtLzFFWDhMZUcyV1NZU1RaQUtkdXNM?=
 =?utf-8?B?dGl4YmoweW1hK0djNTNsUHFnQU5ZWkowSjhnamZLVFRyRzdHcnFZdmIwemQw?=
 =?utf-8?B?ekUvR2h4WjlzS3VSTHdrSG5RLzlCelgwL0hGVytoa1V4Qm9ST2YwZTlEd0NV?=
 =?utf-8?B?L3c0UjZlN01sQUpkdDBzTEUyU3BOUXYwaFNLdDBvSXFLYmlzZVFwM3NKV0da?=
 =?utf-8?B?UTVtN0ZBVVJwdU9WbEdheGt0NklrbUtPaVNEMTgrUTd0ZDc2VW9iT0thcXdG?=
 =?utf-8?B?R0QvWDlIOUVkUm9XUlR2WXh0bk13bFhYbGtkOU5CbGUzZ2grYXFXUUswd3E2?=
 =?utf-8?B?YnBzSVlDS1hRT3pEeTFJL1RSOU1pR1UzcUpGZmF0azFySVVSbmlLenE0ZGQ1?=
 =?utf-8?B?cDh5YjJhQlVGVEQ0MUdXT2NyQ3pveURiRkhvV2Q2NmpZdzVrRWQwWUV5Rkhu?=
 =?utf-8?B?WjJlT29zV0NIQ2NLd2k3VDF4cUZNWTNTNm5sbENKVGFBR29neHBpTGkxNnN4?=
 =?utf-8?B?aUVkd0tvQWJ1cXlhS2VoR20zUFlNNWFSTDQySDExNlBUZ0lyTzMya0orcWdn?=
 =?utf-8?B?cjFlNHdJVDI4M0lSczhqdjZWbFhqZFlScUFrNWxmTGx5YzdMMm5TN1ZCd1Y3?=
 =?utf-8?B?dW1laUUzaWYvaFcrYXRkMzZseExtY241VmxyU3REZldwUTg0d3B1RDIxdU5B?=
 =?utf-8?B?RmV0dURSK3hNUDJtK2w4ZTVPbCtPaDRqb0MzSTVwdnYyc285THZBUnpucDVV?=
 =?utf-8?Q?RDgrGgK+KK/sMVtqvLsGkFzXA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc6ac0b-b812-42ba-f8ad-08ddcd7c74a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:17.4481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Occ9X0GjxFHzTiTd+X+cgLoaSbV+/u1JmHwUHhgAHYMmEOlGI9q9gV2TcDc0vSHFlZkSVP2y89HYXV1ZNYcbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

From: Ye Li <ye.li@nxp.com>

The ECC scruber setting is incorrect and decreases the DDR performance
in ECC enabled mode.

Detail changes:
-Before, scrub_burst was 0; this is not allowed per SNPS umctl2 spec.
 Set to "2" to align with DXL whichw as found to be most optimal setting
-Before, scrub_interval was set to 1, which means back-to-back scrubber
 reads will occur very frequently, potentially effecting performance.
-Set scrub_interval to 0xFF which is the default value. However, users
 can tune this to meet their system needs.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Oliver Chen <oliver.chen@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/imx/imx8m/ddr_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index e9209ce8b61d7ed3507bc102cc8f57ebba077067..7fdcfee1d9c982d391fe0d20e373a66d71d26e23 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -58,9 +58,9 @@ void ddrc_inline_ecc_scrub(unsigned int start_address,
 	/* Step11: Disable SBR by programming SBRCTL.scrub_en=0 */
 	clrbits_le32(DDRC_SBRCTL(0), 0x1);
 	/* Step12: Prepare for normal scrub operation(Read) and set scrub_interval*/
-	reg32_write(DDRC_SBRCTL(0), 0x100);
+	reg32_write(DDRC_SBRCTL(0), 0xFF20);
 	/* Step13: Enable the SBR by programming SBRCTL.scrub_en=1 */
-	reg32_write(DDRC_SBRCTL(0), 0x101);
+	reg32_write(DDRC_SBRCTL(0), 0xFF21);
 	/* Step14: Enable AXI ports by programming */
 	reg32_write(DDRC_PCTRL_0(0), 0x1);
 	/* Step15: Disable quasi-dynamic programming */

-- 
2.35.3

