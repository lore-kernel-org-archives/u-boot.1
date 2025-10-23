Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6065FCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF6A836A3;
	Thu, 23 Oct 2025 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oJ//q6nR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288DB82E34; Thu, 23 Oct 2025 09:34:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBEA832BC
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USvetUvi7/PgS3QiUwmr0m/L33KL/Qqu50sI7w1oWnZiV5W4W4l1+9RhauTfNHq0zrUBiR59bQgV34sGca/EmAksXFRFQuY6WMWiRHCHGNHzotKo5SrhlizINdHfk9XFp6g+n+JL64/Ch3XRgPdYX77JhhTTFuKloQ0aC3Bcr4fDFudx3zPR45K0MrG/u1XeQ5dYYb/43dPpakbhmoAzuToy6RkfpbLS2Enp5ySA955YAkDKHLdemrxopDszmNKWgkgnklAA+3dCykAHOZAzuBL5taSwbWpjEjjlNfHAPexM6jeFW6qGm7gUSeLavVxWDX+ClpDIntRu83RtHm9trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4dsf12T6P9krBXnNvOzDuS4diHywnmaUHoDMY/lj60=;
 b=eaMQqwYGW9sVRnwAxQEebbloFd8rusY0ocaAje2go4nPURPsyD1luW5n1hd/KRu1LVek11/uqIkXpsYWAcg39E8pJh0GaxivIgQ2BAXw5A6HuP211G533z4J0I5Z/t6fLOjkPcivnGvDdacv4GdHwIOYihsDjm0tDKcu9Tm/YRoEUKmPBRdN7vu1hIFgHVL4+fH4Fsy6t3L4/37x3FZTswB1FdxJuw3m+55pOjuuXmvE5Cs9xJlvN07dt3SbKngMs/vDI3jb0UIdOistADQWU6HcZHAwsLIXus7egv9v6ze8r8nzLJdb87yXrNJbIsjheS4Mj5BCBZseNSccQxl1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4dsf12T6P9krBXnNvOzDuS4diHywnmaUHoDMY/lj60=;
 b=oJ//q6nRlrEc/bb5vPK3R/Px1Vm6GCDCmA1ENkc1RDQeubsjt4u5uboJywad7rn5lljt3YoackcXXdrLcwyfNRZs6uRAT3PxmOu1tqI7Yx5MMg5ftfMXiih348NFZgZH1AJfrYIPCmHAz9pFDrIp7Nr965r6YEDZDXEuwo+DIqlUdT93GsXL7oHMcEX5I8cs/+KfJeINL8dyYJoHy7l9JBcr1wKlpGg77YLpT8dTj3tnBKpZmKr9YG/DWh9+rWTkJKvnhL1OQwwi52xIdvQKdRx76hRBvIwqeYNe70AlfE+Bxp7f6wzac5LZ1EmOUiCwZL9zg31dn5UeYhlRQXPJug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com, jh80.chung@samsung.com,
 marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
Date: Thu, 23 Oct 2025 16:46:05 +0800
Message-Id: <176120893103.2124.13562247141313263270.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f5facb-1a71-4285-6414-08de12068eef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LytKQjRVYnAvcy9WS09tMEprSWNWYklmMTZwdjZtVk00bXRIRWpWZk5sdUs5?=
 =?utf-8?B?ejJYTHFFTzB0NmpKUG9hM3l5dmpkZlhXYXdWNTZMeUFuNytaeEg4ait5UE9H?=
 =?utf-8?B?YXJqcGlrcXhtUjVqZVJ2enhWTm0renIvQ2J0dmE0T0ZwOGZ5cVEwcFNkOUh4?=
 =?utf-8?B?WVE0SnM5dC8vL3IrOEswTFJWU1YzaW1hbVRTUHcvRkdGRlFsV0V0dlRlWnd3?=
 =?utf-8?B?USszckc0dWtHbkVVc0RsZ1Z4YTVpczJlWEdaZUpvVlZvVjVKY09hS05EbTBv?=
 =?utf-8?B?cHU0c0NzZVFYQ2NzOEVjUVc3c2Y1UkdOeXRpZktlYVgwSXc3Mkpza0JUc3NY?=
 =?utf-8?B?TDBZbnNZTmVmbjlQS0hjUFEwbEp1UmhEWk51Y1dXcHM4eWJpK3RSNHZxMGhx?=
 =?utf-8?B?RWVqOHlWemVESVJ1ZERic0tiblV6UVR6U3VSVy9mRm1MLzdkUWZodnk3N1NC?=
 =?utf-8?B?MDZpQUV1MGNHdjVnZGJKNTYxczBJYUo4VTZMZkRScU9XMHpMb2thaTJZUnZh?=
 =?utf-8?B?bE9yMHBzRVVpcEhnaHJNSWFRZFdOZitXd01YWHJ4QlNPV0VTSFVla1lLeTJL?=
 =?utf-8?B?eDZyeDlNNS9DVkpid2ViQVZEUXl2aWtpeTdodXdXYXpZaldScnV0a1BQSjlE?=
 =?utf-8?B?akk5ekJXSUV2R0I1WWlwZWFNRnRIdDFnUmtqZ3NRQUd5SFRlbjBrMEoxTjFC?=
 =?utf-8?B?UnoyQnR5NEY3cXVhaWMvLzhQdnJjb1ZNN2pnT2pEcnFvbVVCVWwzQTB6NkNn?=
 =?utf-8?B?SVkyUXhmZTl2c2s2YVIzeTRTWWs1S29qcVMwZXdzUVlKRGw2NllQUDREUlls?=
 =?utf-8?B?Wmprem5YRFM0bWRiZU1SUTBIaHBSc1Q0TGFCK2t4akpDWDJYcmpJQmduTmxI?=
 =?utf-8?B?STJPaGxhNzVaMUV0b3l5Z3JJcFRFQXRSa2tzUmNYdWNHNjZiTHVOK056Qnky?=
 =?utf-8?B?cjJ3bWpWeWdaRTUwQ3dOeGZYTUZjdnIwRmtrS3ZRMWRDM3FjcmQyUGpGczRx?=
 =?utf-8?B?Tm10MWxGQmRRT0FHNUU3OWdEa21rTW5ZcVZtWFZkb3RJVlRxK05iMFlwSEJL?=
 =?utf-8?B?dGUzeVRiNG9LL3lFenY5dmNLYkg3OFZqOGtVVnRWbnhGSU1lUXc4QTB1RXl0?=
 =?utf-8?B?VWxOdmFvSW5LVjREa3FXaGhzNGRkdHlyNGdJVktUQnc4UEJscS9hbkxJRERZ?=
 =?utf-8?B?Ym8wTjEwUGh3VjdlU3dEWHBDUzhza0h5MGxiendaa0JZYWswMUoyaS9CV1VP?=
 =?utf-8?B?cFpZVTQ0enc5Y3BmUW81aEVxZGIxaUxnTzBWVDJ3Vy9UQlp3c0V4bWtNUG83?=
 =?utf-8?B?WnFhb2lySm1tL21POVA2NU9CNGVyTHZHTWYxbXM5K28rUFRsNzllbGVlU24y?=
 =?utf-8?B?c1F0cDhKWmRJWi9ITHVxdHF6OVpkNGRtS0JNUTVGNHoxNUJmak8rQnlVMm4x?=
 =?utf-8?B?Z0JTcWRtZmtxOHUrWjVPZ1ZaaEQ3TmlRTlo2Nnc3bTF1dTd0QmZxc01zcXBV?=
 =?utf-8?B?M1VXK0ZZUEo0VWx3bGd5RUI1NmtrYzR2engzUzdpVlBhUEI4SjV3UVJSSWNM?=
 =?utf-8?B?NGhKZDJBbVpENDZrM2FIcnFLTDFNbElOeklGZVVaUmlBeFVENFMxa0hIT0FV?=
 =?utf-8?B?T2VKWmpTTmJuSGhiaE9zWmNyRVdNbHdkNEQ4cE91SlhCNkVHNHA5WGY1VkRm?=
 =?utf-8?B?RjNIbjFxRzBoS3VlQy9NZ290QTMxMEVYSUhmVUhTQ1pUVUlaRWFFd0NtWFFS?=
 =?utf-8?B?T2Zjajgya29PQlNCc3RvbXBBMDF0LzJzOGNqbE1XK055WUtQemJkY28wMlZ0?=
 =?utf-8?B?cDdCM3p5UzJXbWprQW41KzBySXhxTi82U0VlbHZJczc5WHRlcGxCSllGYjc2?=
 =?utf-8?B?U2ZDc3pEZVgzS2lua2FwNDY3eTBIZVBTTzhxSVpOSWVraVlRYXNwU2loV1dh?=
 =?utf-8?B?VGhEVzM0RE95bXdrQmxJS1ptSVlPNTcyck9SSmlsZGJOQS9vTEhEUEZXNHRp?=
 =?utf-8?B?dk1CMjFjVmVFZ1NhMHkvTGJPd2M0Ukt3MllIbGVhbmRTOHR6OGNUbE5PTTFa?=
 =?utf-8?Q?a8qEqM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bll2OXRqNmJjaVVoUWpJK1AwRkVPZVRVV0JrSDd2UzFURjRZYmx3UGc5OW9i?=
 =?utf-8?B?MERWVHI5MUx0UTlaZWdWS0hjNzFRajB4a0VXZFF2MUlxbDYvNVg3Q2xtZlNC?=
 =?utf-8?B?WlpBSlZvbTgrODF2eitLdjhjZXNXdGgyRlAxY3VmaHBwbkQwWHQ5T21URWZB?=
 =?utf-8?B?ZmlVaUJ2bXdnOEdYWHQvK0NUUTZCS3hLc1VFc1VLRzRhNHVNNnA3cW9xOHRV?=
 =?utf-8?B?dEtHRWxUMjJYajZuMmo0RERHUTUzSm41ckFyK1AyOEdVdUlUY2d1VDdTbVcv?=
 =?utf-8?B?R1FjNW9MTmFZVFd3cXNNcXI4dEx1N3owMnlicUtFNEtQRVRTeEtIUFNFdEp1?=
 =?utf-8?B?SkFUcUcyWUI2WHNCeXExaVhQdmsyWkRjZyt1Q1l6cG13UGZaUnlZeGdndFRX?=
 =?utf-8?B?K0sxN0ErNXdoTXVjbUpNdHFVOWRRMWdGY0JZTDhobHVlbFlUYVRMd09LbzBk?=
 =?utf-8?B?U1lzcFEvOGt3SmYrSSs0Q3Y1YmdrdkNYSFpDVjduSW9MVUk3bVBuWTBYZmRz?=
 =?utf-8?B?SzZFQk0zWDlBaEY4SDhOVE0rT05RdVVSWDNPUlR4TlNvY3VHN1N5azNNMUlE?=
 =?utf-8?B?ZHp0dEVWeDRoVVVuVllROTQzd085NTRiODlUWGxUanJZRUt3cUc3dGV6N0gy?=
 =?utf-8?B?c2R2a08xY2lEdko2Vnd1eTUwWG5IaUxrZTBHQkJBOHR0UnlSek9YemZsOVRX?=
 =?utf-8?B?MkF4dWhDNG9aWkVTOHh3ZVNhYjh0TWczZXlUdGRxb1ROWHIraVc5aVBaUFF1?=
 =?utf-8?B?QitaTXFaUC9EMmVpUFlQTDhkK2dCRXk5WEZGRjQ3dHZ0T0VCOGNFNEw1ZG5n?=
 =?utf-8?B?SGU0eUszWkVCNi9pSm1sMnZFbWx4U0xjb2tERk0zQzlGalRpZkd2UER4eVo3?=
 =?utf-8?B?T2kxcitEdGN0RHBIV3Y1SUNiT0c4emJZeGViVEFZMWNSNmRDRkE1RENTdDI3?=
 =?utf-8?B?ejRUNDU3NkdoRk1QcTBvZmdjaDJKT3RXK0lzSE5rOVVjZ0g2Ym5XZDl6S3o4?=
 =?utf-8?B?ZG5WaGI5THdPZ0FwY1o2Qzlmd2s5akZUVDRzcGw5QjgrTFNZZnVzdWQ1NkNS?=
 =?utf-8?B?WVZDSDZHVVExeW5ya1Z2MUR0WjRWcDN4OWxkaUxxallaWk9NLzFjb3J1S1gy?=
 =?utf-8?B?YUloOFF1UTZtMWpkZWFmUkFrVDZBNFY3ZFArckxwU0xYNVl2dVVtMVJRYmxy?=
 =?utf-8?B?TjAyclhyNXIyOEEwb2hFdFZiMnk1SVUvOTJOWmJrdjhIZWhLdVg0TEdESHo0?=
 =?utf-8?B?OGVXamNwaHhZOHBPVFVIUUlsU3BCdGFjUFc1Z1lrMHRkVXAvOE45bWJtbnNa?=
 =?utf-8?B?RmhaQk1TYXduemlLK2ovUkpmejU1U0d5VjRkeWF4WnBWR2RLSHJCZElCb3lt?=
 =?utf-8?B?YThka0hjR2x5enpFZzVrbENTVGszdHVrRHMxYllENGd0MG1LSlNJVCsrbDhr?=
 =?utf-8?B?RWRJL1RLRzJrdDY2NWdCSzE4OFFyMEJMUkhUeXZIQXptWmRKcXpDQ041d05s?=
 =?utf-8?B?S1piMDM5RDNFNlhObHYrUnIzQjdyNVcvS2xKeEFPYjE4QTM1QTd5Y1FUOHNM?=
 =?utf-8?B?QmtyWjB1end2REVYQm1tUCt6aWNUTkxjanZSNUFyekxDelYxZEFBVXdFM3JQ?=
 =?utf-8?B?MlBTc0Y5ZU9PVzF6NG5oNkV5dHVxRFJQTVNVbEJJelFMTFcrUzgyQW12S1Np?=
 =?utf-8?B?SU9lbzVrc2hNeEFac01WSTNjZmF3b2xKUXlxYUJoVEJmOE1sRFhKdmZJMWhT?=
 =?utf-8?B?T1hCTmxyakJ4bjE5ellsYy9YNjFLUVN0bDlWajRMNnlWUlh5aGwyUmowdlgv?=
 =?utf-8?B?cnQ4ODlYRDhYbzk2K0VsVHdsVXRoZ1Ewanc1Y2JXa0dCcjVyWmhHSU1TOEt0?=
 =?utf-8?B?aE5oM1pmV2V1dnpCSGVwZ0ZDSE10WllaTlE1SmlzbmhIenNyRDcrTWZxdFdy?=
 =?utf-8?B?WlhCeTVFMzJ3L0owbksvL1BBcDFQVzU0NzNTcXVaSlBSYjVwRGFzU1kzWG1P?=
 =?utf-8?B?cDZmU3o2Rk5xMmhXcW1lS3B4dDViQ2orSEdrVDlUVXFhZEs1VHVzekZPc2hY?=
 =?utf-8?B?cWRoa0lMZS9rYlVWZk5uTVRRdThQbnpGZVJEVmJDS3ZwSENCUEpRREpHbFM5?=
 =?utf-8?Q?D6iwUMkgddd6rKs50amvLgugY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f5facb-1a71-4285-6414-08de12068eef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:11.5693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyNCNMcTktHTyfZK9NYs3s/wqcOlJ5O4PDvEbbabhXl/ba+5XuyNSRhCQYKqBdY34DDc7CP7JhWCxBNd/pzIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Tue, 21 Oct 2025 13:45:26 -0700, Tanmay Kathpalia wrote:
> Some boards have SD card connectors where the power rail cannot be switched
> off by the driver. However there are various circumstances when a card
> might be re-initialized, such as after system resume, warm re-boot, or
> error handling. However, a UHS card will continue to use 1.8V signaling
> unless it is power cycled.
> 
> If the card has not been power cycled, it may still be using 1.8V
> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
> they can be used to determine if the card has already switched to 1.8V
> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
> transfer mode.
> 
> [...]

Applied to mmc/next, thanks!

[1/1] mmc: sd: Handle UHS-I voltage signaling without power cycle
      commit: a9797a8a057b408e9c26f69d5e1d651285bf81c0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
