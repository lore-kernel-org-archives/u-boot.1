Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB8D1039D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 10:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9068B83F72;
	Wed, 26 Nov 2025 11:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W/UP7HS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D67883F75; Wed, 26 Nov 2025 11:45:00 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB10A83F70
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIRDRuNHN0C2WOTPUXWIazpAJTul9H4IFc2Zq0dTBG2Qb7Nbe93XopBK+KtBX3fAoYJsNFhvZ4jEG2rNzcU9PnpX7vgBVOfI05Ju6ayVmPQ+pJwbA4xAQFontcHShFxYuoISMvusGgBM8nQF2wwq+Q9spZSeSb0VG1vqoA8mzwPtX0ra9je30hFs+EWy2yBcgADkuidqHXvfRzZDuIQmsg1BI7xS+Qg1tc4ymB40fvnuldzoZwCv84RhXuNa6KJScppXiNw5OmWK/5qzAvIps3Ia/xyxj09dLNCxz0yHsnpW7X+DBBmXnq4U7TENgpse9zJkVXg/86lPuHhSXrnDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/se4E0K2zsAbZ7PIL0EZljfDcxMOfPayO7Gi8f+eCg=;
 b=bA2Jy09bSbwA+YJ0bCK6CTHTAh6T+D3GYZcrpWzYr9tfLmAFFkd0q0paiacuAa1OK0wEPQYOz/mwPL2oV3mah4QSkcqRClo3H7bNlcqI8Ci+WdZGGFxXtrvGyAF6Ay6BFagZyAvoP48OFiGMEh+gqsfjSfqfg3iRMEKYB9vITV6x5J64PmhRGpXgu9e6mtSYGGyQe57pVCMxQnopQQqFvGLq32Tj4q7V0SDFpQ8ztiH3H9J9vkB9aXXOBZLsjNpktziq99L7fUBuVk4uCYHypqZAiMyswVnc0JThmT36VicBZtzDQYILrmeT4P3FqCpYkvWFcU9pbWxSr1UwmLzpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/se4E0K2zsAbZ7PIL0EZljfDcxMOfPayO7Gi8f+eCg=;
 b=W/UP7HS0rSjgFrpk2fsAT41rDBFdjTbTqVm/ie8t3j1cUYgwXWXt3ZBBAhma155CGdioOnjC/DgBwojBe9Ox/00GbkdH+5smvR2iekAkmANjRHt2ie6S5gQId7lX6rcW7PMc2VAXjEjMB7tRsxElUkzy2xYA5DSRBB4xh5GphrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 10:44:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:44:55 +0000
Message-ID: <54428bab-5189-48d1-9b96-977487648327@cherry.de>
Date: Wed, 26 Nov 2025 11:44:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251125123847.307-1-briansune@gmail.com>
 <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
 <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: b539367f-f777-460b-83c5-08de2cd8d624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekVzcUtFR1ZCb3RQSlVaYnVEcksvbVg5MGN2WmR4TFlZRWZUODNuOVhDTDJN?=
 =?utf-8?B?cHIrSXppRGdUS3dLOVVhWXlISml0NDY3VVYrV3JEK3dxUWpQbTg2dWNESkxS?=
 =?utf-8?B?SjBzcERHU29ML1BTZXBZZE1nd0ppREFKTHd4d2VpWFRoWDBQTEFlN2g4L3g0?=
 =?utf-8?B?QUh5ZkRpSnRWcHdWZ2NPS0VmZzhyYytrWlZlUDJJZDZkbG9ocFNveEVRYVNS?=
 =?utf-8?B?Nmk2NTVqeTBBdjN0ZE85MW96MUdLbVljTVNJb3dGSmpaNW9YMVNzUkVTeE1X?=
 =?utf-8?B?WGhOWS9oemZuL1ZVQUN3SmNXTlpyVWg4NStLVDE3WUg3VWZ6SFA2UnpUMTE1?=
 =?utf-8?B?eUFKdTg3ZnM2ZmZGZGN0T0pkemhJYzFsWXZsZ2lybVVXU1FxVkdTTHJMMFBC?=
 =?utf-8?B?QjlFZWJLeFo2dHBGN2VOSVZvSm9mZld3dFVXZ1ppYmhBNFJUVjAyWldVRW9k?=
 =?utf-8?B?aWczeGJ4UEdncmxQOHdlTEE4RzRtVmFuaDd6SXFRRW5RQkV0YnMwTGlOY29G?=
 =?utf-8?B?VFdoR3hNYlg1Z3l2RkVqN1IvNkpIRUU0U1FZMlc4bThiczJDaDEwWkIrVFdD?=
 =?utf-8?B?SjBwdFlPUTZEWEZDSGR4V0UzTGJPbi8rQU5IQitZNkNVbFdPek1aalJyeDBH?=
 =?utf-8?B?QkY2eUZDdkRlS28ySHlpMFRncm1aR2IySmFvWTkwbHZOdThHcytaMmNiS24z?=
 =?utf-8?B?d2ozTFVMeWdmbDROUVladTBUVXFBMG5qWEFTL2RYZ1I2L25mV0ZudUgwSndt?=
 =?utf-8?B?S1owT1BjN3JaSE00NHJIZVNKMjUydmRoNmhwZGxSNUdIWUEvQW1oaUN5WGs3?=
 =?utf-8?B?OWRXbDdrYjFlcFdxTnNMeTlCSnVOWE80NWNiUVpnVXR5Tm50dFZjRW41cEdY?=
 =?utf-8?B?dHlQbEVrN09FU1lGYjY3QVFUWE1TQXhSU01zWXFyVVhlQkVydW5ERlZqZ0xq?=
 =?utf-8?B?cTJtMXRmREV1T0RPT2FLc3o0MS85c1l0S29IczdENXZ1MjRvdlRReWJybXBl?=
 =?utf-8?B?L0swZkg4YXI3SUtEUGNVcE5zZXdXSU5TMTJjQ0lRd2NzcEdvSTdyZzhZZ3E4?=
 =?utf-8?B?aVZNZkhkeUtHckE0UHg1NmgzY0dzNHdiZVhFM1hCYmExb2trSWtuTGxNb0J0?=
 =?utf-8?B?VGEyYkVDa1FQVUtZU2dRWXJoZmlaMERIMEJxeHArVVkwenJqUTFhaHVWMFli?=
 =?utf-8?B?eDlhc1l1TmdHQzNHR2dHb1dTUkdKS3p4RWZQLzFrbDJKZW5FY3NWbmtyT0dC?=
 =?utf-8?B?STZhNzdlRTdOazQvVy8wUEE0ZWlLQi9BS3k2OFNKZ0UvWi9lV3ZMNnNEL2s5?=
 =?utf-8?B?RE1zb0Q4ZWVaZm44bEV1UFFJU0l2QjFEa0lmYmhGZCtlVlNCLzMwYWlNL3JU?=
 =?utf-8?B?c1p6NFE1eVBiQjFYSXVEVlY5YWVyYU1ZaXJ2Tmxzem1tV25sRkZ5SUtldGIw?=
 =?utf-8?B?SGg0R0hhbU11VWd6d1hLd2xzV1FXVEJMdXN3QXN6dTR1NmtNemtVUjNCNXhV?=
 =?utf-8?B?NzFzOVhKVFFhUVd6QldKSWNySkNxWWZOcDdKcGRCc0I2cFVGc1lwelNyTFEz?=
 =?utf-8?B?SG5jZGRWNVVPSGE4eWIrR3duVm80Y3ozOWRrRlBJeU5oM09tQ1A0dk14bG1W?=
 =?utf-8?B?a1A5VGVMMXE4ZFVGUFJMUjAvTkZjU2VhSEVxc1R2NEF5RHBMQ1krQXdCaXRT?=
 =?utf-8?B?Y2g1TjlNNURtbWxjYjZxNDBqZzRUR1dmdzQzSzA5eVEydjJwOEd0a0VjMTY0?=
 =?utf-8?B?cmRSQXRlR0hZd2lYRUFZaGttY3hnRThqMUphWDBjL2c1RGFlZk9pNVRlY3BW?=
 =?utf-8?B?QzFWRFpJTWN4c1lveUkweWJMbXdtMVlGU1c3ZjArMGdhcEZVMzFQbTB4RGZk?=
 =?utf-8?B?aE1oSmd2clhYUU5aOVRXN0E4R09waXR1OVptekNSdm9mWGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEh3QVZJcW1WbUxDR3hRMCtOSHowdFFQdTk0akc5MEJLRzN3KzB4OXg2VFhD?=
 =?utf-8?B?ZzVDUk5ITmN5NGc3SVQyNC9yU0QwWFdYYkt4SlFUdFVqNzREem9vM3hVM2M0?=
 =?utf-8?B?YUZ0b0Y3Q2U0S3l6LytFS0pzb1c2S3g4NTFCbW9UK2Z6d3RPWjVlSDVmVXE5?=
 =?utf-8?B?MTJLVlQxQjJ3bGpQOGxlYTJhVzJMaitTMFk5M2IvU01TWFFGNTBNbmFkS0Nk?=
 =?utf-8?B?eS9kV2hCTXVxS2pFYWNiQUo1QXV2amlKK2tJOTBIb3N3Vzhsc3ZtbW9Fdnk1?=
 =?utf-8?B?aUE4L20xMXk1NnljTmNCemp0UXFOckJqNkxqZzVIOUJuTnpuU25yLzl4WUZz?=
 =?utf-8?B?UEVQVnRDMnZtODh4a0g3b2RCbWxTYThoaUJQZHBOcUhLTGQ0eFRhR0p5T2ZF?=
 =?utf-8?B?dS9zT1RrczBKdk5DK1RlNWw5aUd3UTBycGMyTWNVOHpBUGNaS0EveEpiMVJW?=
 =?utf-8?B?RGZmU3JjVnR5dTVwOWc0SUxZelo5aFNzYnM5VStZQXk3a1phTUlMc25OYVJQ?=
 =?utf-8?B?YlJTWG9Ld1ZQYlVhbHdxazI4c3NsYmdteEtNYUxIcytWakhoZy9FZDNZaUox?=
 =?utf-8?B?RllWdlg2Mm02K2hKVXlHRHpJWXNlVzY1NFlNQWZWTi9PeHdxdU91eHBwUVpT?=
 =?utf-8?B?Y1dsZHc5OTRWQ0VWYmFGc0JHbU1XNFNWWEpJbnRQLzl0VC9IeElSalA3ZDVR?=
 =?utf-8?B?Z0Z6WnQ2ck5zaFJzYm1paytndVVVOGR0bHU2ZTArMmprYUp1OGpMTUpFUTJU?=
 =?utf-8?B?cVFrWVkyamtqR09KRjBURUpEM0dlYWNSVW1IanIyMFU5SW9uVEdxUU5iQTR0?=
 =?utf-8?B?YStjVmhFTFdZSThVa0dJU0xLL21qQjlJNHFNYTVVM1d1SGZianhKZFNLbUJW?=
 =?utf-8?B?ZkdkRmJxb05YMHJCSUpVR1RLaHpJUmE2bHVpZW5SWWRSaG9SZ09KNHoyVzlJ?=
 =?utf-8?B?SGZGQjBtZVd6Q2I4Yk9wRjMrMlgwYlJaZGJocWxtRXZKV0xtRVNVbml0UzJM?=
 =?utf-8?B?R211OXZmbjV4MGJROFRRUURLU01kaThxTkYzd3BHd3I1T21wdFBiTE90VVZR?=
 =?utf-8?B?ZnZzOVVZTGZ4cEJORmJoTVU1Ujh1ZkhUUzdzVWtjWHdRY3Zaclozakw1d2ZR?=
 =?utf-8?B?YzI2b0ViZ3dRQ2o4RWlZOE04b3lCVUNiaWswUWFoT1RJUm9nVnBqSFc4YVBM?=
 =?utf-8?B?L2Y0cFR2TzdTdGJtSVZ6TEplblROYzRtRnFFY0hnR3oxTnhad0lEZW5ES3Iz?=
 =?utf-8?B?NG9DTjJvbGtyOGwwS3l4RmI0NTA4UzF2OVh5OWR0c1RrRngzb3A3eUNuVEl0?=
 =?utf-8?B?bEhEWG02ZnI0WnpwKzg5cHRsa1Y3ZE1hWnVocE9yT2VNbmF5QWU1MHF4MmpX?=
 =?utf-8?B?Q01UU05Nb3Q1UEx1OVFJalZRRVJSeFo1N3Vob3JKdGNrNkhFQ0VnaGZ3NG1w?=
 =?utf-8?B?WXdheE5YN2QzMFEvUEJwUUVMQUZ3TEJPR2lDMzB5dlByWTl4THJSZUlSeG4x?=
 =?utf-8?B?UHZWVGNEK203WUVOYVBTSkYyZU0xRWZERC8xV1ZpVnJBeEpxZHdhbVV6VE5O?=
 =?utf-8?B?L0NBQW0zenUrb0RCMHE3UFNOdVlrUm1CT2hNZTM2NDNNa1JxMnNVQXJZY0xU?=
 =?utf-8?B?MXdWUkZvSzZQM1VxSVBpNG14c2o5cmdQWjhCeURGM1JDQ2o4ck52TWdncE9q?=
 =?utf-8?B?eVVIOW50TW9BU3llRzN3dXFjK3p2VDF4ODlVeFNhR29IVFdjQmtzek8xbjVU?=
 =?utf-8?B?RXVvSUl3Yk5xcCt6QVNOMi82TFAxanN0Z0MwMHN0M2JpZ3c0R1JndFZvOWRs?=
 =?utf-8?B?YVZwU1hlaEVZbGtWNTVxS1ZqWHBrem0xZWdvVld6enhxY1YwZVh1QnlUY3Fx?=
 =?utf-8?B?TnNPQTViK25wbDQ5cFlkSWtlSkVwaEdLMDRJMGlEenFkdG5yeFRrRC8vUmRt?=
 =?utf-8?B?UnUvQkROSlE2SlAvRGNRU0RjSjIxN2s5dnVCdlJNNGRRT2dTK0xXdk01OXps?=
 =?utf-8?B?QzJlbjlTMkVQbTYvbURNbXVXdHlrMk5RWitBYk1sem5aS21HK0t2eUs2UFpn?=
 =?utf-8?B?RHB2UDNVNGt5VmZEM1VUN3grQjd3UFJ1dDRLSnZFRlAxNi9LWmthaHF2NGlY?=
 =?utf-8?B?NVNkclc5eFMvRDY3ck9mNjNmdkcwcWlaZnlhVDV5MWRpb1puZ3p6T2FHYWtl?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b539367f-f777-460b-83c5-08de2cd8d624
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:44:55.1873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+2P+dzcKgnujj3FmYMtZIwt1oobMpNEa65wNXwJyk3YfgFGh0dRl4CcNe4fgVwGxU1+2mpzcHw4QMD70AtN20ZKtvm77rmiZCaoP+nxP4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034
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

Hi Brian,

On 11/25/25 10:33 PM, Sune Brian wrote:
>> Are you even sure SPL_CYCLIC is required? Wouldn't enabling CYCLIC be
>> enough?
> 
> Short test answer is no. SPL_CYCLIC must be init with default timeout #.
> 
>> Since you have not identified the root issue yet, can you please provide
>> the actual defconfig used before this change so we can figure out what
>> is happening, if other boards are impacted and how to fix it properly so
>> this possible misconfiguration cannot happen anymore?
> 
> socfpga_cyclone5_defconfig
> 

So, this does NOT enable WDT or WATCHDOG. It does force SPL_WATCHDOG on 
but that doesn't seem to do anything except if SPL_WDT is also set, in 
which case it'll then selects SPL_CYCLIC automatically. Can you walk us 
step by step through how you get this into this broken state?

git clone https://source.denx.de/u-boot/u-boot.git
cd u-boot
git checkout origin/master
make CROSS_COMPILE=arm-linux-gnu- socfpga_cyclone5_defconfig
and then...?

Does it happen with the default socfpga_cyclone5_defconfig defconfig?

What do you do next? Do you run "make menuconfig" to enable/disable some 
options? Which ones?

> But my patch did not target ONE config file. Because the risk or possible
> hazard could happen on other GEN5 socfpga. Need others to report btw.

Yes, but I only want at least one board this happens on so we can try 
figure out exactly what happens with this watchdog.

> b.c. it requires complete fresh build to trigger possibly.
> 

What do you mean it requires a complete fresh build?

Cheers,
Quentin
