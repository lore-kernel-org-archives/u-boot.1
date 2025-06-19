Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC114C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676E682CFA;
	Thu, 19 Jun 2025 11:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xdrYkiMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD4382B18; Thu, 19 Jun 2025 11:13:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF5182CD5
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4m9LgZX19eVxTZQqxbJwEndeihLUEDbLkw4C6uoi64axHXSr1asSLum/pMCaDNoyW2+mcgKY8HLhbJpHbKVrUgRfV2yBl8BTaP+zzAJfQ7cL/mUb9e5nzqo+4fvVHzck7p0YmcsRdnUgn3XVCGeimAKOdiI7IXpcGwAJqt2NUCEzlE/VKsSC8NZSeyP/cplg5ph3daFTJzYxyDlyK/wQp41/SGHdYHmvlLf9h9ekNgPRDoDs5P9eqgIqnpEAqiP8XH54M38/CheF1HRs2/7GrZksXOxfLtkuM3EGYgS4jtdJVQbFA2BgHjhAXftXAh4BfiulDCBS5AnSzuzBAp8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95RTx/wxH825gfCEr+8LRWEZmrZXChxYxT+iYRoKH6E=;
 b=hnikvlaQNLGlIqJUokz5HFcmiiWEif8Aujbjnprjhw+o0xpHmhQk9NtmJVTE44bDodf4lkOrmFVJSu84eDNb/5Xv1QvJgLdD+YCq9dZS+4bqTO+Y76M0zAFwxUHXZKWJ9PWokPPY4TVvz21cNpAlmnJUdKjU1iOw6NAhBjPSN7n9k4LtFDUdVJ3nDFqul5D18e83Ia2suFf18jWfIcPez++3hf43V/h96hyvZL/EdnA/kOSog95raU1TfegMdp4JsLp/Q/VzggReiG6KUqiPfXsXzN0vlwiUqLfMZqWXuVLBTuRrjhQI8IzvRvt/k+FpsjHzeXTayU7IB49EtC0qSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95RTx/wxH825gfCEr+8LRWEZmrZXChxYxT+iYRoKH6E=;
 b=xdrYkiMBO/iW864aCFvHQvZWoHHtxViKt7b+APAoY3G51X7dDOpKVGFeaSuv0r6PEonXnmvC13u3Z9qIDueGDgNucticyRMxz30pKlEt8s68F/PJlyCXB4noVPWsu5GPDFbenbbkKSOltaY9mfHi5DzsRmJzlDmDnCuy/9UF9Vc+RnH8syTlPeJ/N9Goj3BQAp0AH8MThSuQ5Xtu4eRPK8GNoa67NrXmqkAqnwnQiiut2zkLKFlM3GeeM56qavinEU/5g7iE92GpYocLU7lLdoYpJmCYikaUUvU0ywULBbKpChZvvwg/ezeNoSsl7theQ0uOtolx2G8skEn0FPDgCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Jun 2025 18:23:37 +0800
Subject: [PATCH 3/5] imx8mn: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-sr-v1-3-631100a113a5@nxp.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-0-631100a113a5@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a4977b-318d-4d19-dbd6-08ddaf1188d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3d4SjlyYSt2Rk5iL1pqMVhFWUFjZkZhUjU1UWZ5ck95RHBpQ1pPeVNZL05N?=
 =?utf-8?B?NWJ2NTN6R3ZXN3Z5L3o1d1h5Qlhkc1hMTTFocWpDTGpLV05rS0MxeU1NVHZ2?=
 =?utf-8?B?T3lXWGhweGxXZGFKTWpPcHNjQU1VVFRhZGdhQjYxQ0p5YmZGWFVhV0pjUmlN?=
 =?utf-8?B?RCtmTkhvdTZWb0ZyenRKVkU3aUlyc2FYOWZqWXlKdC92OEQ4dkZuak85OUpB?=
 =?utf-8?B?KzcybEF3UURvdUhCRFc4enFERzB1c1c4dWlaZTFsZ0FIenhpYVpkL0JNVlU3?=
 =?utf-8?B?OUF4QnovVTJ1b3A1NC9YMEhheVBjSnorNzhuQ3hudU5mMDlvYjRJYmJ1aXVl?=
 =?utf-8?B?Z1pNd1BKL29pRk9hWFhsVS82aWh5ZjlhRzh5NjNmWDY0OWhicXlWdnFvUmlT?=
 =?utf-8?B?QWZnL1VZNnJvSk9PVGVLWTc1dm5lYTlQZkd5SWhTTmF1YXJqZWtsSHRUd2Nz?=
 =?utf-8?B?ZFdrM1RoZVNtRFFORWNCdjNzblpoVENtSXMwcWs5RnZEbkYvK2JaTTJtcjU1?=
 =?utf-8?B?MjBNeGtqRVE5NHdkaHZwVEVyc2I2ODVncnZERXJnanR3NDk0Y3dFYWlYRlM0?=
 =?utf-8?B?ZWxqbWEzQjNMRUt6NUxDTklJY3hCK2FKOUExZzZOaGJMNHpJVnpCNzErMWJQ?=
 =?utf-8?B?UE5RbXoyQmUzc0hKekErdDRlaXZTQkRGQ3NtWjl0OWFvanZscWJkbmFONUVG?=
 =?utf-8?B?ck05NThRbXA1aE50ZDFUeHlNZlpENzg2TnA1Qm5VV1VxemxEQVZUSkw1N0h4?=
 =?utf-8?B?M3VMWTNPWDQwcUV6SHcyOUlSS3JNMnJUUXFCcFNSZEhmOUYyRWdKbmo4bkNT?=
 =?utf-8?B?V0h4RE0vdFQvYUJ4Y0wrMWxTNW9KSnNtempDeVVCd1l0RWRFd2lUS3JWS1ZK?=
 =?utf-8?B?R3premV0RHNjSmRGSzU4eGlVd1d6WlVYTE92ZnF5TTRvbVZITlB0cWNlUDVB?=
 =?utf-8?B?Z2UvNUpZekpCbWhqNWk3NnNmbFF5T2hqN2lpY0c4ME1ZSDhRZ0IxcHRoZzlI?=
 =?utf-8?B?U2k1VUduM3RINFlhdjJ4dTlIWHNCdGZ6OUM5UWxmdU9LL0lkUUR4SHRMZCtX?=
 =?utf-8?B?Ty9Pd3drNFF3MERJYmFmS2h5cG8va1o3R3BCbjdseHZuQSt1dVVpdTFCdWN4?=
 =?utf-8?B?Mzk4MmxoRVZ5em1ZMzByUmxMSVJkdmUwT1VZNVAyKzJYb0RXWTkzcENYRDk1?=
 =?utf-8?B?M2F5RnA2VzM0S0Q0TzZoZmIzSEU2WGd5Z3U5YUc1dEZGUVpqNUwyV0F0S2F2?=
 =?utf-8?B?SkZKSEJraWtXTFBXWk5XNG80Vm9rODVtNmoxZVdDVkNGVDB1N2hoQWZ0MVdS?=
 =?utf-8?B?OXFMT0hNMUhwRnhWbFlUUFREcU94UE9xN0NtcHhoRk1va0IxcWxvckFtcFFy?=
 =?utf-8?B?a1p1NFcraE1Tcm9VUEJHV2h2K2tVTG1lamNudjQ1dWRTS3RXaDU1T2lCS3da?=
 =?utf-8?B?TXJaRzlVTzkvdVloZktFT1ptWktXNWdabGY1Uk9SZGJPc1AyemZXMVlIVFBM?=
 =?utf-8?B?cjhwYlNnVzR5ZkdoblZuWTBFSk5kY0U3c2R4YVlaOW8xRjBOblQ3NWRmY0tp?=
 =?utf-8?B?VXdIMmYrRFBUYU4zelFKRzEybnI2SWQ5Q3dEZjdLZnNrQ0pBcFdxRnJWaXZE?=
 =?utf-8?B?T0Zma255aDUzenBBTzU3WTdHR2cyTXhoK2lwUHFGODBsaVdaR2hFSjVpZXRJ?=
 =?utf-8?B?d3pjRE0rYnZaOTMwZnozUHZnUUd6cFdMc2s4bWp3ZFFPaWE0TW1VL2RKOEFn?=
 =?utf-8?B?WUVjTWFVRzZPWG5aeGpVOUxUejNKMis4WGw3NTcwM1orZjg3YWlRcDNrdmRB?=
 =?utf-8?B?TDFIbldqaGdiL0JjTXJYVi8wMFRwdktrRXZnVE1GY1B5ak53OUMzeDhRcDJa?=
 =?utf-8?B?LzNocnFjN2IrNVpjVVFGOHNYR2V6WjhFZk55SFFQU0owcGR2aWNCaldtNUxw?=
 =?utf-8?B?b3NwdzE4SGhla0E3VmEyRXg5eGVpK01Mb3ZWV3hSaVI1bXpFMmpmaVdRVXdT?=
 =?utf-8?Q?UR0dPUSFm9H+PQNog9Q5OFxq8QffPI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkh3YnhXZ2xQUDFWOURuUi9PUnphRWduemJlRFdkRk9rS0xCM2VidVNHNTZm?=
 =?utf-8?B?RzdPakdjRnBwa2Y5RkNCbXBUbkxFbTBWc281Umxsb1Zzcy91bm9iNzdnN2FX?=
 =?utf-8?B?anRqbVJvRjRUS0lXK3czb2lIVzRXWGlzODhCM2ZiUDBVVGRuKzJoSVkrVUNw?=
 =?utf-8?B?VnJuNCtiWVlucUVXNW9IQ3EwcmsxSHJmV0ZrOVUyZDE4WkM5TWQ2bGc3a3BW?=
 =?utf-8?B?eUs0a0l4Y1pqK2k3bUNEeC9MTHFiRmR3TndGNDhIcHZXZGhrYTduaktOUFk2?=
 =?utf-8?B?NHB2RDd4Ry9DLzBsUFZqdzF5RHIwcWZLdElUeE5VcU5aVGFqcTBLc29ZeEtq?=
 =?utf-8?B?NWpRVHpKMXNnS2gyZlJldFY2Ulo3RGNnN01EY0cvcmczVU1Xc1I0bVB6bWI2?=
 =?utf-8?B?Y3orVzdsNVFvb09yalEyTEZpOGVoV3FpdFFCMGw1YWQvMVBJbGVremt6Yzd6?=
 =?utf-8?B?SlovdTd0SVJZaG5Pb3RkSGw4aVVjTnV4d3V4Lys5Rm00WmJidDJuUlQrL2Q5?=
 =?utf-8?B?RDBhQm5NaEl1WUdXdWNyR2J5bkpJYWhScHpiODRmREFOMW1qcE5NMXAvUDZM?=
 =?utf-8?B?MXYzMEJ6clVja0RTOHdGZkN0bTNyU1JRUDREOExwRy9rWkpmZERZUVVqWnhW?=
 =?utf-8?B?Z1dUdkxzZnJraUtGVk1Eai90OW16MlFqMjZQcnd5VldUM1Q5djY1T1h0QkxP?=
 =?utf-8?B?NFRBdTZRZ0phSVlFdG12eTdkZ1ZCYk9TMWpGTkFHa2tydXJ0Qi9jOVQwMXlJ?=
 =?utf-8?B?WmZtQ0k1K1hsUExrSnpFZUozM1UvQnlDNXRxTmFPc0dUU1NSMTBoVUJqdU5Y?=
 =?utf-8?B?SG4wUnFQbUI1bzRhdGlWWmQ3R0I2Sm56MHVxVU1aZysvUHFDb1lQaGY1SFk1?=
 =?utf-8?B?TE9GSUd3T2NaYkZyT2VQeE5KZVF5MG43WGRFRVF2bjM1ZFpVWjJISnVtN3dn?=
 =?utf-8?B?TUc5N2pDTjBSNE5xR1dJN2Q2MXBhaUtFWGhneHgycXp0VmFnOVk3MXBqVG51?=
 =?utf-8?B?NXZlTzIwQWRzRkNvTVNrdHhUS296Sng0TnRlSVJqZlQvQlZza1BWWUVKSTlO?=
 =?utf-8?B?UWdXVlJrVm02aHA4QVpLVlFTUll3TVc0TXBBSWEraEExWUNsRzJDUndnQzBt?=
 =?utf-8?B?WFM5bTZLUWY1ZkVqQXFJK0l1dkFGTlJqbXB5VTNvaCtOQ2JoQVhvK0RpanFh?=
 =?utf-8?B?M0VxaW1IYklCV1pPRWs0Z1duaTAyWnFlT2l0ajVYWFpqMTl3WksxaEEzaG0v?=
 =?utf-8?B?a2w3eWhkUG1KbG84dWsyWnl2c3FmUXRXaXdIR3JSb3o1ckxqTEZwOUZmZDVF?=
 =?utf-8?B?aWJYU0toNVpJVGVRSEtQOVZZalFPTC9KNXZUQXFGTWg3R2JBSVo2YjZ0NlJS?=
 =?utf-8?B?NDd0NE81aUlILzFlcUV2MXBuWHkvQVRGNE9CeUFDbm9kUUI1S0xLSlpsUE5T?=
 =?utf-8?B?dWRlS1Bta0lUL3lreGRNdmV0UjZkZGgxQkFZQ05zeVU0Wmp0Q2xxNWoweGxx?=
 =?utf-8?B?TVN1dDJadjVoS1NmVDAyNy9MRlloRnk3OVN2OVZnUC9XdXpTdkVKMjZpSGZ2?=
 =?utf-8?B?WHEyMGNDTGdsczAxZ2R2dDA3TUtDck83RS8veitXQTZ6Ny93TVdQQndUMnZk?=
 =?utf-8?B?OE42b0JxMFhYZFlraFRjV2lrUEc2SWtFTmdHaXp2V3RzYWVKR3h2N1FpUlJ6?=
 =?utf-8?B?UW9nZ0pzTXhGZThqYk15ZjdiVWVSNmt4MXRIa1ppMHA3UVVuZ3llU2ZrUVdP?=
 =?utf-8?B?NlhqVXNHNUVRRVNRNHgwU20zZll5QXA3aDZsaUpIaFJac2l1OUgraTVyRy91?=
 =?utf-8?B?ZU9ZVWY1NjVjZktTVDd1QWdhL1hTOGhMVEFCZmFQOW1HUzNEZVRzNGRRbWVS?=
 =?utf-8?B?OWpESlhlNFVSMXZpSjZnbklndmNxbTQ5aHVYeHNBcFl1dVZmQ3hiT0cvWW53?=
 =?utf-8?B?SEdUNkY1OG0rZndsZXZudXFYd0d2NTRMSk8rMUxuK2RybjZJQWRoU2NRaldC?=
 =?utf-8?B?WXpsZEgxWWpvcHowSGY3N0pVS0lBQ2liZjIxeEhTSWxBTmd3UUYwV21nd1Nh?=
 =?utf-8?B?dFFETnp1RVFaUVBBWmx3MDV3ZFJoVk5tMGV2cXMzVm5mblJQVFZ3akFqQVBO?=
 =?utf-8?Q?Jp/UxI/RMp2Fla7Yu+VRrimpH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a4977b-318d-4d19-dbd6-08ddaf1188d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:20.2780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkTlqi5rss7SMevOGfDpT+CKsfBLwfjyp25wum7WrgLD3hFeoG6ZiSdZunxpnvaVRNhbs/s4vmjtHsZFhJq+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

From: Peng Fan <peng.fan@nxp.com>

Define image array and GUID
Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 22 ++++++++++++++++++++++
 configs/imx8mn_evk_defconfig            | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index c62d7a47e21b77918af85e966ac2bf8f58a75df4..9d3f29f225317ed6cf3991ed8286696b99f00a6c 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -5,9 +5,31 @@
 
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <init.h>
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xcbabf44d, 0x12cc, 0x45dd, 0xb0, 0xc5, \
+		 0x29, 0xc5, 0xb7, 0x42, 0x2d, 0x34)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MN-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_mmc_get_env_dev(int devno)
 {
 	return devno;
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index d45c83951effb4f38d2b0fa19146cc2a44ca77cc..199bee49d1ee4e33d15cf684bc8961387f076b7a 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -23,6 +23,12 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -55,13 +61,22 @@ CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
 CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -73,8 +88,10 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MN=y
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
@@ -99,11 +116,17 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_RSA=y
+CONFIG_SHA384=y

-- 
2.35.3

