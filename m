Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D4C3DA60
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 17:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F1A888A6E;
	Wed, 17 Jul 2024 19:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="OLAY3zDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C1D88A7C; Wed, 17 Jul 2024 19:08:32 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D85188A45
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 19:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjS2Rh3q16JghIXAyD4SNBC0DztHxN3HgPUhi4PxjpG1Il7uZTB9RtpTdeALdWCq5d+xCq5XmXuMfGTjIwfv9EWMwbWVQVqtocdqsNp8qoH6BV3K7lRzslxBkMqDsXk0Cvrosm4NjNefzTvVCs+JngeW6WZdec8ircJqGTMww5lzmCe4nV4pALUT89Eh6XdW+KN+09yWpk/Ew6ttx1LQMv/YEyp+YCDDP/WlNiKTUyUuhB0+SJWDM6YONPHKUPs0T+hN4e2BKNjit76TzdU+vPHIAvMbk1ebljXziSliOG33LvuwBzZqDdGs42WzFibMe/J+gnrBkSiEOvxrCtdtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik70Tcs7xz//+6mqKah9SHwplRMcF10RS4z2ydd9e50=;
 b=ThQYG4h6+40X6lUAuOc8r5nNwcOwwF5yQ0mOSt7luiOBy4MEYpCLvc1Lj2bD1Avo7IzQQRr7tac2VSqJTJnTU8NMFgDyflAsHoa5rktAEhTK8Z5BAQk8tsqM4vB4/XKm69Kaq5jHE2+wumix7M0uiSMbHQgy5qTk5QnP1XRvj3UmxKkmufJBfVn5Zrlah2puNw9PSAAH0YsdPRACZhg/kfSMW671sAwoWwpSVBm/YQM+IYNCge406KTYVAoydaSEEJp/aek80UISbxbTa7mdrqOzIj7Ndhr7l66SWvpYxyEgfE/zhKfEofpVkudElFID2b44XP1SAG0Cgzmhrv81hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik70Tcs7xz//+6mqKah9SHwplRMcF10RS4z2ydd9e50=;
 b=OLAY3zDiAQLTo3mP80Asy+1ApoKKmpGkDNBslMNbJKkptGjTOP229Emg55E/+ACfPGGweYBSs7cXp2ETyd58SGrmvqIDDrOSb4tE2AauyPMlrI2JRHgbMlHriuf4IYtsRWTgWidnPYtDCcHcRp1TuRoAbQGM2wFdGp+g8287SeaQAZhoB3pEEjWsV8fSvf3bZmsjYqA1tJKv1VloGeQDzSHFXYw1re7kMACIAmrlsnfvgQYEj+7qDPUUWHJnKesC+sepPw8F1OmeTX6oyvBlX5TBxGMNigjXeW98oxP3K/kzaFXMJdkfPatXl9xC29jQfY0jYZJbVCfP4evc8AnV6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB5220.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 17:08:28 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:08:28 +0000
Message-ID: <e874bdd7-273e-465e-8516-3207db9ea245@softathome.com>
Date: Wed, 17 Jul 2024 19:08:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib: sha256: add feature sha256_hmac
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, abdellatif.elkhlifi@arm.com,
 u-boot@lists.denx.de
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <CALeDE9PSADyPUwBuHH46V2Of-HxyYJbo2VOdfQe-_soS6CHCvg@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CALeDE9PSADyPUwBuHH46V2Of-HxyYJbo2VOdfQe-_soS6CHCvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0043.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::16) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bc6c02-d344-4031-8192-08dca68313ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akgxSmhYc0dHV3dyb0Z5cXRUR0VqeXM0Y2lnaE8xeVdvdkRBY0gvSU5WT0Z3?=
 =?utf-8?B?VkxBZ0k0dGlJamk2QXVtc2IwRlpQWW5MQnZoMUJobEdLOEZtSU5JM213TUhj?=
 =?utf-8?B?czA4QTJEb04yekhtQTQ5Ky9SUVNiM2NuOGV4dWtHcExFNklNUzYzYkNpclN1?=
 =?utf-8?B?YTZIM1FUV2Z3L0xUM2lZU0l0cVNVZmh6MGg0UHpZdUtQeVFnVDdxbjFobjBY?=
 =?utf-8?B?SEhCclN4MVl6RjNTUTRRdzN1Zk8vcWo3aktPMGpZUjRXRzQybGFoOWJ5dDhk?=
 =?utf-8?B?bm5ITExJbDFRVWxyZHl3YnA0a3BLbVZWMFR6Nk4vU3dkNkh5cU83YlFlWmRn?=
 =?utf-8?B?RUxTcW10QVVIMFFVRmVLcWdMRlRacnE1ZzdKbUtlZ1U4cGFTTFFUN0pFQkZM?=
 =?utf-8?B?YTNnMXZnTWovL0VpelNnbG5IUTMyVCt0cXNlWlVaWkNhN3A4a0dwc0RpWFlD?=
 =?utf-8?B?UHB4UFd6bThrV3FzQi9haUYrZEQxUFZOaXhXVVh2WmJRVDg5ZjRDZFNOM2d0?=
 =?utf-8?B?WTJpTnRRaGFIZitFYWxPOFBaNFVVWTNYSDdJbU9hN2Q1bWVRK2JuUEhHUmdh?=
 =?utf-8?B?L1JjLzJJZjBGdWZncWFRVGgwQU9uVXB0SERGUS9RNHBpd2xpYnQvWlB4dXVi?=
 =?utf-8?B?bnhUclVjODVob1JPa0ZHd2pzblVrbWFKeFZNNWp6Rm11WEFDTTRhSTVtRm5O?=
 =?utf-8?B?VURSaXNNcmtSUGxyd2gyODVaaWRrV1orampPd1R5aEVKWDlUM3NkL3gwQzdl?=
 =?utf-8?B?cUh5MFV0alQrT1EzTVNBZE1ZU0wyZlRNL2NsRmFVN0dpSEpMdmJ5K1REbi92?=
 =?utf-8?B?WFpBN2x5SVpjcXlpWGVaNVpoT21CQkRnK0VaMEEwQUc1SXhIN1QyNGV3ME5z?=
 =?utf-8?B?SVZqQ1oxcEhYNi9tSFoxMUFBd2Zjcm5URHl5WmhNTys0V0s5cEt5SC8rU3l5?=
 =?utf-8?B?anlyVlkxRXpwMVFkTWRPUWtWditLWStHM1hWMHJSZmtiMWdqbmRyeHZ0NWNW?=
 =?utf-8?B?MkFFaHdqQWdtVnAvc3RiUDlVTFZ2aGc1SFJDR0k5NTRRUXNCVW1kTGpqaWhL?=
 =?utf-8?B?ZHRNVGRqSk5YSEJRMHBxbmo5RmtWRWlnYm01Wmh0K0Q4enE1NkxuUlJkR0g5?=
 =?utf-8?B?dU1UbEdvUWhnb1dBVTVJWHQ4NnJlcnVwZGRmQ3V2MTNkRmpZWjVZdWFLRFVM?=
 =?utf-8?B?c3hteXZQamN5MHRFUUdBM0ZrbGRmK25Pd0J2L2laWGZBNUxKSWVoRjBQcFdT?=
 =?utf-8?B?cUFRRDhzL2NGSEVsdWl2K0dzZXZya0liSjV3T1V2eEc4SE1vSnBZZWNKenZT?=
 =?utf-8?B?NEZvSDhSZExxdXNDeDhHV3VnN3lZajNlN01KNjJhMTdaYkFCb2JPWW1EOGRz?=
 =?utf-8?B?Ykd5blgvcmRVa0h3NXVodnZTTUNydkd6TnZoNDFOaWRQc2tabkFYbnhaLzNL?=
 =?utf-8?B?dDhGa1ZrTGpDY0ZvVE94NklBTlg1NzFkWmJWZWs0ZHJKQ2U4WWVqMUV0djRK?=
 =?utf-8?B?cDk0M2R6Tkl5YUpaM3RNdFVDcENQL2RlT1pVcC9JYlNCUDUzOHdMRWJ4bjJ5?=
 =?utf-8?B?ZkNhUjM4M2xJdm9ydG5YTURBVWxXL3F1Z094WEZzN2hZMUd1YzRnL2NNU1Z2?=
 =?utf-8?B?UE9WUDhEcVNnRmNUa0J3TURSRHZ5TVE1aTQ3Rk9kWUtHT1Nva001aTRxVXhp?=
 =?utf-8?B?MU8vWjcrZmJEMmcraEFzQU9XL21LSE04NkdwM244UFhKaE13L3J4ZkdZVUM1?=
 =?utf-8?Q?8iLu+0hory4UEIScqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dxZW91ZEYzZFFiMTVROGgydFJlRUpZZEg5TWFyT0p0OHFlZmFkT2Yzbkdw?=
 =?utf-8?B?bnVpc2tCSGtjKzFxTFdHeGx4NHJHVDduRDZsaGJmMU1YMU1EUXNsSXN5RjQ3?=
 =?utf-8?B?T1hjUXZ3ZENNZkJOazZtaE5qS2U3Yk1pWXJXTjUyZnFoUkZBbkhlZit4Q212?=
 =?utf-8?B?cm8va2VFelRrY3lVaXNDR0VEUlJXcDlBRnlIQW1wWE1qUjRkd2swcVNXZy9r?=
 =?utf-8?B?OXEwb0lPOHM5eVJyOTV2dU9kaFhXdVkxT2crZ1d0VVZ1dk9QMlVGV2FVd084?=
 =?utf-8?B?VnByOHN2T0w3NHFkZGVRVENXZVpmM0d4dkxtYThrWmRpSUc2K3VlVjJhbEY1?=
 =?utf-8?B?S3RnTWhqMWwyb3ZPTldrdC9Bd3hUZktuMjdhUGpHWHJyREp1bUZ4UXlLamY5?=
 =?utf-8?B?RWtrV0dXdXk5MUQ0dGxkZksyaElwMWlSR1B0NXU3MW0yVVh4bm56N2RCTGhl?=
 =?utf-8?B?d1lDSWYyeWQ1aEw2aG9aYWFVYlNHTFQ2SDVZM3dQUURLZk9lL1R4aGR4eGgr?=
 =?utf-8?B?Y0VkbmoxMVlkcnhGUitLYkNFSnl0cFV4SEhGRnhodlRycGtpamcxaE80R3k3?=
 =?utf-8?B?Ry9UNFA3N3hHQyt6WVFzWnNvR0FuWFdoUFU5Yzdod3I5dlFwTWI4MnBpZGIv?=
 =?utf-8?B?L2tjdW9FTWs1eWgzRU9Pa0V1aVpqYmJiaWlzYVQ1Smt5OHJJV1ZwWHVPdlE2?=
 =?utf-8?B?aXVPaEhlUUFqaERCb2Rhd1c1U09kL2MrQ0lCL042dGc0TmpySjlvaEJzWVFT?=
 =?utf-8?B?eUxwa1BVRGFsYTNtNHJXMEx3U3NnMkdXaTZkNm90RkhVaG1yVGlIa00rNW9W?=
 =?utf-8?B?UW9scU9TT0U5dFdKdlhkd0tEOTRRd0lIWnk3d2l5SGZITXVITzRBejhiWVFx?=
 =?utf-8?B?eWMrY0ZGdThxV0N6N2tJOWhyV25GeDZIK0RVd1hGamdtdW00dGUvalJJL2RM?=
 =?utf-8?B?U0loS3JsRlY0Z2JrZHVnV2RjT1Y1YUtGQSsvZHVsV1BnNVhBNjdYL3VPeUdN?=
 =?utf-8?B?cjdKQzc2TS84WDFlSEJWZXdCeFFVaFJmbU9ENDhQcmw5ME9oOHJEUVI3UnJs?=
 =?utf-8?B?TE8xMk1SZ1c4RktPUGpGeUZCbGpRemFGVFB0bUcyWTZBUW5RVVJVWGdYQXlL?=
 =?utf-8?B?MHVla0VjS1BTMnBlR0NqdDdXOEVGTkhTTkNEVmM0Wk83c21mNEV3RThiSkxD?=
 =?utf-8?B?TldtelB6bUZhM2w0WkZ5T3lqb1BrTFlnVHc5eExRVGh0SjQyaUZVMDZod0dU?=
 =?utf-8?B?NmhjM21ZbFZuL2g4enljYXAzcGtoTmdjczRySElkdmJ3cWF1di9GZ3VaRXlz?=
 =?utf-8?B?NksxNnBRR2hTdTZ6ZEhaMUgyTTdQMExONVFvTDVIa2pJUmpyL2pMVnA2bFYw?=
 =?utf-8?B?akUrSDVucERwNXRMYXIwek9FSWU5MW9YSUh6YU84bFpxZWxEZ1Z0L1JuckMy?=
 =?utf-8?B?NE9yR2Z4eW5LeHp0R3RMNTNuZ0szYkYzM3RXSVJTdVQxTkNMSklnTFhMSlNt?=
 =?utf-8?B?WGJJbUFqT1BoMkk2eTU0VER5bE1wUXloWUNWN055MG1OVTdvQXg5cWZlSm0x?=
 =?utf-8?B?MyszbWpnVzIzV1VoRVdoUFJIMGxudzQ1cTU1a0JkNmNNQnIwUElxMHJXTlJq?=
 =?utf-8?B?YVJsMXZtT3ZVQmNOZTZXNkVPKzJBZDFwVWhOK2hNQ2NZSk9ZZXpxZ1BUaTBG?=
 =?utf-8?B?R2dKY01jM05nU3dtUWczWlNuRUM0MHhwVFV6MFJuSEhQRmNSYkdLTG9ORUtw?=
 =?utf-8?B?TEg2ZE80cXRKUHF5cHh3d2JxZGRSc1VkMVA5bGljSkFkQm5OdjYwWlNiMEpV?=
 =?utf-8?B?ek9lWXBxOHlpaEJ6bUQwNnlDUzlBRnJucm1OaGhrdTJSMkFWelIySWgvUzVs?=
 =?utf-8?B?K1drZm5xVHo1SU13SXZBRFZPWGdLaUpsQ2dwM2FPYjMyaEhhbkdLR2QyTDJY?=
 =?utf-8?B?bFN1LzV0cUlJZWN1cnIxdGtCejlyM0VTeHg0Mk5CeHAxdEhZay9ONkhDSjMw?=
 =?utf-8?B?YlZWdnVHNDBQbUFTMGpseUt4dlFIbTJSclJscmVKalJncDdDV2ZHYUlwYUI5?=
 =?utf-8?B?MzB5VXlTbDc3cHNlNjZscVdZWkluN2g3K3FNTVBaMnhSSlpILzkxMnlUelRF?=
 =?utf-8?B?bmE1Sm1MSFlqVi9jQ2JlNThRU29IUnRUQTR0Q3NoNzJkdkJMYnFUOGE1a3hV?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc6c02-d344-4031-8192-08dca68313ef
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:08:28.6941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIhfHZYkC4BZQ0J8uIPtmV47RrFgj8HxvL7rahtnI92P4Mpierm57csCXlD58a8Z4tlC4fYao7nMBTCWztaC1yHsY1NircDLJY2wUOcs4s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5220
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

Hi Peter,

Le 16/07/2024 à 18:56, Peter Robinson a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> It might be useful to have a cover letter explaining what the plans
> for this code are, great that there are tests but adding code in
> without it being used isn't always a feature so a cover letter with
> some details often helps with the context.

You right, I should have added a cover letter.
My goal was to add key derivation and use this feature to fill a key 
manager,
and then provide those  keys (or some of them) to the kernel. So the kernel
may (for example) add them in the KRS.

Do you know if there are some work or interest in a key manager for 
u-boot please ?

>
> Also if you're not aware there's work to integrate MBedTLS [1] and I'm
> not sure if that also may provide the functionality.

Good point, I miss it. MBedTLS has the feature of key derivation.
https://mbed-tls.readthedocs.io/en/latest/getting_started/psa/#deriving-a-new-key-from-an-existing-key
So unless someone wants to use key derivation without all MBedTLS,
this serie is not very useful.

>
> Peter
Regards,
Philippe
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-July/557832.html
>
> On Tue, 16 Jul 2024 at 16:16, Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
>> Adds the support of the hmac based on sha256.
>> This implementation is based on rfc2104.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> ---
>>   include/u-boot/sha256.h |  4 ++++
>>   lib/sha256.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>> index a4fe176c0b4..7aa4c54d0d4 100644
>> --- a/include/u-boot/sha256.h
>> +++ b/include/u-boot/sha256.h
>> @@ -24,4 +24,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
>>   void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>>                  unsigned char *output, unsigned int chunk_sz);
>>
>> +void sha256_hmac(const unsigned char *key, int keylen,
>> +                const unsigned char *input, unsigned int ilen,
>> +                unsigned char *output);
>> +
>>   #endif /* _SHA256_H */
>> diff --git a/lib/sha256.c b/lib/sha256.c
>> index 665ba6f152e..64f6b48974b 100644
>> --- a/lib/sha256.c
>> +++ b/lib/sha256.c
>> @@ -298,3 +298,43 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>>
>>          sha256_finish(&ctx, output);
>>   }
>> +
>> +/*
>> + * Output = HMAC-SHA-256( input buffer, hmac key )
>> + */
>> +void sha256_hmac(const unsigned char *key, int keylen,
>> +                const unsigned char *input, unsigned int ilen,
>> +                unsigned char *output)
>> +{
>> +       int i;
>> +       sha256_context ctx;
>> +       unsigned char k_ipad[64];
>> +       unsigned char k_opad[64];
>> +       unsigned char tmpbuf[32];
>> +
>> +       memset(k_ipad, 0x36, 64);
>> +       memset(k_opad, 0x5C, 64);
>> +
>> +       for (i = 0; i < keylen; i++) {
>> +               if (i >= 64)
>> +                       break;
>> +
>> +               k_ipad[i] ^= key[i];
>> +               k_opad[i] ^= key[i];
>> +       }
>> +
>> +       sha256_starts(&ctx);
>> +       sha256_update(&ctx, k_ipad, 64);
>> +       sha256_update(&ctx, input, ilen);
>> +       sha256_finish(&ctx, tmpbuf);
>> +
>> +       sha256_starts(&ctx);
>> +       sha256_update(&ctx, k_opad, 64);
>> +       sha256_update(&ctx, tmpbuf, 32);
>> +       sha256_finish(&ctx, output);
>> +
>> +       memset(k_ipad, 0, 64);
>> +       memset(k_opad, 0, 64);
>> +       memset(tmpbuf, 0, 32);
>> +       memset(&ctx, 0, sizeof(sha256_context));
>> +}
>> --
>> 2.25.1
>>
