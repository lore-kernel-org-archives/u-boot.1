Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC13C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCE184B73;
	Thu,  9 Jul 2026 20:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JFHoOIYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555CB84B86; Thu,  9 Jul 2026 20:10:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD4984B72
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTjFMVsREA2tFHTKUSzNi7/54h+xh7VQt3yNbInu1uzdHY3TkLf4UXLJ7B4xDqMtMQlcYw387l54E4c+cgNxb9Vyk2hlkOIS1xB5VuCJJxlWDoHFuCPjaduyDLSKMOzKi6uttoGZ23KYcoWMpNWNLUn89XkUaYSgPPBEsH2TVBzWA0cIy5bytC14r+va91+HR/28ryG/+cHWqIBxRmNpY8rxiKR4a4GCs8JpapicbcAxgXy+indmeTorHsonpu8C2BCcRb5g0rXaPDWDfc6Sk40BI+fLL6NTJYLpgvHxaDh3N/4acRTe57IpK484m7JYAdXH0l7fp22xrVF5vHYF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRP4MYETQgl/gzVkNP5DXCB6BOSyEJzi52J0EG5yMSA=;
 b=rXx061qgwzhPryjg5wcFOFyVWsLiFjJvZt/CPXJsCLZVNbNPR6ZAKMI7V4vnFPOrykwtulEE7Irw0wtx+KB+m7A93tVCLIw12cyUl/PeUHYYlBaToipd7aXtp+i9/5qi4QD3nQ59Uq1oOk08JcS7gdY8YowC8G3p3Q2b9zPUUPz0Kvmmk82J4FFxqeK6EkAlU4pdN//p8NZKjeu4YiykcLTxElh3lJLJt1VzwvSq3ojN3LjuYoP6Q9nUHmf2ZPYlJ3RyQK50SXNi32kwDRyV9y9yzC2vz1QvPlT/PnhSo5ScZ9jnLL3KxgRBDZxfJYF+7wbi2KVc/Iuc0zSlWP2p7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRP4MYETQgl/gzVkNP5DXCB6BOSyEJzi52J0EG5yMSA=;
 b=JFHoOIYEBAV6Iob+bq8kZ/SNURSi/ywfySpy8Bdtn/SU8Lb0JIhpcB6AnJzaRdzhLGktg2GS2oVFVdqnm+v8T403tEypS1C2gIrf9qTJ0DMhZEQY7O7E3yjm5UeTlxV+EfQCNFbv0kCugjpixpljcrosAg5a0f7JoGydynVlOwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10497.eurprd04.prod.outlook.com (2603:10a6:10:56d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 18:10:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:10:47 +0000
Message-ID: <8ed19ccc-f2e8-4800-89cc-1c472813ad0b@cherry.de>
Date: Thu, 9 Jul 2026 20:10:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] rockchip: rk3568: Add support for LinkEase EasePi
 R1
To: Liangbin Lian <jjm2473@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Johan Jonker <jbx6244@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
References: <20260625125818.18914-1-jjm2473@gmail.com>
 <20260625125818.18914-2-jjm2473@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260625125818.18914-2-jjm2473@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000526.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::67a) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10497:EE_
X-MS-Office365-Filtering-Correlation-Id: 63495f0e-c2f0-4b2f-25ed-08dedde5667d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|921020|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TqOmOLG9vCl5ryrW1f0R4dWhsd2wTO5RPRpm0La9GJGxwfVxAEEB6KP03HLYzQw+LjqXqU8dOk1a57QZNvzgssl8LQSuK9WIrMMaB99KmOZ/VTE5B3YRUmtyz3Ih9c18xGDb+vTxC1UduZ1kGOGwkdmCZzvLKZyArluAYYae/sxz2O0VQbx+XiKztr/tcR4dxg97NkPY7RGKFvGhZHKtN8ozpJcOTsxINxwrqez25VyvH4DEWBxCnDQOSq0zRULPQZ5cmf426Fshi3hwocp0mqLmakYKFxLX38M6JMGXIExX/vPLIsMSM3qiH7ckUxwrjgvXhgl2X0mFJUFhofjllk6WiwB4dk6qQgs2xCdwh82h/Vfzl+x+AypePFXFInw+kkruGlhvFBsBxUKsXQHYNSZMFmzzDMw2pN5NG83c7aYZWj68bedjNupW6cD+wu3l2SUX6iCagXvpsfUnSCHNUsWwk2WOZKtFfw9MNlHYAfgmlmS9sjYYtMvfNp/T6IFHCrl/VzWy5n6I6cmEnjVeY9Cc+Zv4wBD9iat9vBzGK5ZfqoX3WYhaisHZMSdi7nvn8hLxBdfJ/CRmSpDYDhIAq4cmccUfOEpAurV/yLYF6JX9P/syY3wuK0LYauKUImCBc/eI4nUDQvS1yucyV9dCX/dc8zMRx69V4+FZDg36ApE4QHl76/wDQgllA0ju/VR8uXgmOJ3copjzDjh2C9gzVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(921020)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFpREhrSEsvTG1KY0tuZnI3N01IL3lsbHhKS3FnNGF3VUtvc2dQWE00Y0NE?=
 =?utf-8?B?cmEwRHNmS3BUVk1pVnVpUjI3L0N0blVCTlVCeXdvWDNXNHVKdmo5R1dMTFVO?=
 =?utf-8?B?bVc4eHNDYmFocWp2UjMrdXRUK1p4S1Npd2llMlU2TmdOeHI5U25ZckVCVlpM?=
 =?utf-8?B?YmFxN2I4OEJEUUJqbkhKVTk4OUJQSERIUllBOUNrOFJWN2RVbW5qQ201bDJW?=
 =?utf-8?B?YXUwZC9hY2hPdzhpamI4S010NWU4WUNhYmN1Rm9hWVNzSDhYd21BdzI1U3Rp?=
 =?utf-8?B?dm42TUllY1ZkUjFHNDkvbk1uUVU1dU02U1RvaTVBeXdtK28yUUtnNGJkRjhP?=
 =?utf-8?B?MTcwMVNkSUt1Q1JVUmhqUE45MXhtem1TdS9Sa1diUng3Ykh2c3lpUkUzb2RD?=
 =?utf-8?B?WU9TSG9sUFBPKzN6OGN4aXZHcENpckZtMjRPRTg0VmJ6elAzQlpFaUM0ZVll?=
 =?utf-8?B?aWdqMHhxTWhKakl1RTQzRVBaZFhBWmQ5dFBhejZ4NVNjeFRFQUM1ZGFVUDdN?=
 =?utf-8?B?M0QrclkwUllLaTIrcHNBQnc2OWxrYUl2dkdHQXNlcllnaEVGdlh2bWpNYTdS?=
 =?utf-8?B?aTRkbWpta0UySjBuTElqKzBWVnNIaC8zZWNtc3gyU3BhUnRGT21SQzdiVklW?=
 =?utf-8?B?TXQvM2VxMTY3ZDMxbUtuMFpjcEdoSG5IeWpJZi9WQ2Zwd1RIbThyYzNqVE5R?=
 =?utf-8?B?WFhSMXlxczl1ZDh6alMzL2NENWxMdUM1a2t4clg1VlVEUWt2VVFCNkozdm45?=
 =?utf-8?B?b3JTZDE0ZDNTQXBTZ3ZseHg1QWlWR3ZpN1Avd3E2Qm9LbUpPOGxzUnhGemJo?=
 =?utf-8?B?VmFTdHpGRFJFQmoyQUxNbWFtWU1YczhVRlNNU1o5Z2hMVVVHSDFmZkFxRThQ?=
 =?utf-8?B?MFpJRk1SQUIzYjFtYkZpUmN6QUYrM2VObWUzeU9TQWNJYjZkMHhrSzVUWWJS?=
 =?utf-8?B?QVRYazZ0ajJsM25ab0dMVWM3Ry9XOGgrSGkwZGpKNDZNQ0lxNnBwOHdhQTV0?=
 =?utf-8?B?S1ZDL0hXcUZIOUwxZklzT2QveGRVdmtNdExuMk1Cam1kdWNVTVJkdnh4cHUz?=
 =?utf-8?B?dDZwSWtxY2lDT2F1ekRsTkk3cmxBQ3o1bmxnSmdHTktoY3d2V3l3VDdGMUFp?=
 =?utf-8?B?V0pObmY3VVF3WkhzamtLQkk2SkhnRFBETDEyR1pWdDMrRU01VUxIaHFUSVpI?=
 =?utf-8?B?WU5oMkwraTMrbCtUR2J5V3NCLyttQ2RCYUVqUSs5ODhVNStHYXBBZ3JoN3hY?=
 =?utf-8?B?WW5YaHVqQUlEeFk0enR3QVE1UE9UVnpqQUVaSHZMQ3lvMmNuUVpDMnNSSjhL?=
 =?utf-8?B?SWExYzJVbGpFMzgrZ0NWVHhwcFFyWEJtNVpTZlZ4ZmwyUjVSRGNNK3c2dERl?=
 =?utf-8?B?MXZQL3JrQWZWc0RIaEZiTDVjQW5IWVhVek1OMVlpZnllWHBLczc1MGVoMFVj?=
 =?utf-8?B?SkdwWW5Ecm1SU256VUVQSXowK2RRVzl6Q1VHaEJ1OUN3em9iRkhjWjN5SmNo?=
 =?utf-8?B?Y0QxeHZPNzRld2x2eHN2cXVrUnJEaXJib0J1MnlnTmNzUElVd0ovNzJBeXN4?=
 =?utf-8?B?NFIwUXNhbFQ1b1FvNG1naUhLYXNRM3NmbGhGV1ZVTkxub1Q3Z09WSUZkRkZl?=
 =?utf-8?B?K3JJMWNXd056OWRXUDBuYUQwSnBHcEpaR1E5aU93MEdsdDAxQllSMTdLSmh4?=
 =?utf-8?B?a2hhRzd1QnI2SEdvT2RkMDQ4ekpTSWFWQzZEb1B2c0puQlNRRmpDQ0VULzF3?=
 =?utf-8?B?UDRBQzhQeTc2TERkVFQ2WHlMNFl2RUFZa1IrMzlYZWFxTW9hbUZqU0NJZExr?=
 =?utf-8?B?WFc5NE85Q3dOa1JOZFNwRGV4OHlENWFJNEFPK0J2N1RBbys5cHI4Slc4dmFL?=
 =?utf-8?B?REV6RnI2aUhxaW5NZTMya1VmQjRWSkJwVFQwWkpTQTF0dW1KeUViQnIzNU9Q?=
 =?utf-8?B?R2MwUU95QUhGVDdtQ2hnMlRiaVFQY2Uzd1cyUyt1clNIYXZacDBYRWJVVC9X?=
 =?utf-8?B?cDMrVFJrcmNKL3YxOUZ0NC8yOFRibUk4dlMwYXZ0QVl6LzZxZWdlOUNPQUNR?=
 =?utf-8?B?QlhiTlZOZWphRVRyVDNuUkQ3cnpWWHVOSTZRV3d0QlBPR0kwVy9maGxPZGVX?=
 =?utf-8?B?bHhBS2hkaGp6dDFsRStTN3paNkdTTWw5dFUvaTE2WEYvZkJVMlNIMkxJSlBo?=
 =?utf-8?B?ZTZwU1ROUzJYK1R2a0FVVEVUczhlUW9QWHdZWVZkYUJDNURlR0kwVjRxVCtD?=
 =?utf-8?B?N1FpTmYyaGg4TkRrVlVIZWdxd2xSQjBUVHU5VUZNaldaZzIxeXNRSTYrWkpZ?=
 =?utf-8?B?eFZTMVRNNWZNUFVvMW9pVVplVDhqY3RxT0lsZERZNFc4NUxZdG5HZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 63495f0e-c2f0-4b2f-25ed-08dedde5667d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:10:47.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVFJm/jgpTGcApTcgMntJ6XMBuMbZf9cRiFKtoRB72ZAzKS6765f3HJtv2Wg49Ezy5FkaL+gSiybaqN7ifmSePvLegsSIiC7Gz79iU7t+a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10497
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

Hi Liangbin,

On 6/25/26 2:58 PM, Liangbin Lian wrote:
> LinkEase EasePi R1 [1] is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
> 
> [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
