Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EDFC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 09:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD6C82CFA;
	Mon, 14 Jul 2025 11:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LI1dUKRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAF382E52; Mon, 14 Jul 2025 11:59:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F371882B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 11:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg2ZP7fTf/NjCVCDTDV7RMr03l3CojwUAijKR95o5bE2Rjyeqbj+0snA2ZE18S+RZpWqRjIQQelAosQ2LWhSWxc61oZCqwTqbqgsKX+MWwZWekEzsziJyDjvcQUQj0lxW+mokMxba03a2XoMPP0DCWUsRLNcBfWFpW7H98EdOmlPwFqZUE9R/+RDUmh76mAD/DpGOyM8+miGzSIcNztoBjDzd/gqfeIISZPVCpma9yZ3R1xH1UeGy2b3xmJoyUhw2yYC4FG9lDi/FoMI+KGCEvYoNAaXDBdWpX9qz1SqunsI7l42JNkkyva6hGM7L+VKgcBLDORkFNsx1L2W2lVzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5nDhbkvyJ1VsAzyaMIG8Vr3qTlK6sRgZtlD7i4jQj8=;
 b=baAZq49hzMra37co5O+10EEVzCzKf1srO50yoXj4z5+xXNlRZvmSt/0AUcN5uIzujsBqratQcCk6EoPuBdGIcftOessUKEKPoAd+FgUXkFkOLuRyqiwWsReRKnRsc6lrWMzFv7+9Sbzyap3C4hpzp/u0RGjfhMg1GED09AvbasrlHYcjSjCgf/8klQczxYJy2IcqfP/Wl3fm7lufg7iGOnTfSRr9XQIKHe7rz0+mTRptNzQrRkiyRdl70CifetTP9gt625vmLcCAhqh/e7XhArIbVL9bTtDsseb3dcb4Q8Nud5izqqHSfuxNg+evWdRsDiSAT32vQunF5xkiNPijAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5nDhbkvyJ1VsAzyaMIG8Vr3qTlK6sRgZtlD7i4jQj8=;
 b=LI1dUKRrMAJ2XInC4Zsu5BO5nNbq0zIefADsS1zJT8Sx8R3gguNdYIJyGLgW7P5zrEoBo6ky9IOyy9/0aJWAMG9XbFXUbJBlK+KOtT5hBW8LuCtJKjLri3KodUrmAoTxtWfCCXua1dTHmgo2kN6N8zyf0qle7/kFRQqp79z6g6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9958.eurprd04.prod.outlook.com (2603:10a6:102:380::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 14 Jul
 2025 09:59:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:59:01 +0000
Message-ID: <a18b47c1-f872-4364-8c14-f18ec6d59384@cherry.de>
Date: Mon, 14 Jul 2025 11:59:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: i2c: designware_i2c: Remove clock disabling code
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Heiko Schocher <hs@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250701045218.8403-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250701045218.8403-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:118::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9958:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d46736-23cc-422b-b6bc-08ddc2bd0f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUNrR2dhMUpBaDdaSzdsclpKZWlwZ3JSUEJGU28xTUhOaTJ0UUhEakhoZHoy?=
 =?utf-8?B?V240OHIxbCtuUHl0YVA0THRFNTFFRkpYNXJ0NGRSSXBTc3ZCTDBBTDcyT2Nq?=
 =?utf-8?B?M1ZkajNrdllmNWMxekM0K0Rrdi9rNUtOMytPUUp3L3BUQVNVUTZFbmwxS0pS?=
 =?utf-8?B?WEszUGV6K0I5c08vRnFaenBaY0xxM2RRamxKbktzemw2ckpuZS9CNnY5cm16?=
 =?utf-8?B?WXMyRkxDcktkUGR2NThETHFTSFh0aXhpazZmT0tvY29kQ0JjNkZUNmlCRU9t?=
 =?utf-8?B?L3c5bEVJYUZwbExNOVRxR2p6Z0pFdUNxRmF6S08zSnEvdTlMWXZpcU9WRTU4?=
 =?utf-8?B?VGdqdk1KYVFGdkUrckdaS0tZeHA0Zzc5MFlST3hzTGx5aXJWc2dzOU8yNWxD?=
 =?utf-8?B?NCt6aUVqaXZTa0ZmUUJSTGw2NFJVVUZXQmtrWHZSK21DMkNxblMxQU1EWERt?=
 =?utf-8?B?UGFwaWJubXlaN28wMkJLMTE4NFZZQ2tTWWpxVk1OV0JFc0xPd2t3V09WK1Bn?=
 =?utf-8?B?VG1LY3hPbElPRThXOTRFRHZZenh3Z0owdStraWx6VjhWamFKcll4cHp3S2ds?=
 =?utf-8?B?VDFNYi9lTXRTVnNaRERHZUl6eC90N2t5ZGNyczlJaHZ1djU1MDIvcXN6MkF1?=
 =?utf-8?B?WU03T3U0Slp4enRJVFlGWnJXdC9zQXBvcDF4YThsNm9BNm91clJhSkFhR3VI?=
 =?utf-8?B?b1RiSmhTeitpOVBDVFBMM1pnaFQ3UUVwSEF4WXVldzQzN3V4OERPSWNRQ1Zp?=
 =?utf-8?B?emd5bFpWVnpIMzI5R1NZeFV2R1N1cHAzaHZENVRxWWVyNmsvN3NRUlZDUzBs?=
 =?utf-8?B?Z21nVXFTWFlzSmxUdDlBeHlWcjkxNDVDK2t6QzNFLzZXaEp3czJvQ1YyeUhV?=
 =?utf-8?B?UTZsUW5PNXpsRzdqUkNSODhrQi9wSEluaFNWUUxxTnF5VGZUZWU4cDI0QkJB?=
 =?utf-8?B?amkrUVlQcVRBeTFYYXBwbU9vaHJSMS9Za3hpOTlOaXBRTEdjUkVEa2xHWGpi?=
 =?utf-8?B?Zk1XdEhLRXI5T3FzWlg3MDE2eDJuQ2k1VGpGeW9nSXpKOHFsUHhLYUY5Nk1H?=
 =?utf-8?B?WlQ2c29BVW1CWG5KY0cvQk5BTVFFeWduQTVkT1dXVWM5RVMybFFhbTRobTlL?=
 =?utf-8?B?czc1ZDY3eU5iUDlxdUliT3E1angyc3gva1hMbVhtVEJMdFRyYkQvK2VyTWpj?=
 =?utf-8?B?RFMyTU5mTlgrWmZxWWdKbmM0czV2SDhtclV3ck5yODBZSnY2YysyVnVCTGNl?=
 =?utf-8?B?NE9oSDd2ZVcrNVlJbW94a3Z2NEx5dEJ4WW56Z2p1bmdXVnlaVUY4d0hYa280?=
 =?utf-8?B?VFAwMnE1anJRMTB2RmRLM2JNeFJqODdmVHZmYURsNUpLSlVVZEhlbXFJZHQx?=
 =?utf-8?B?UlU3Rk5kWHQ5RHFOcHhQaGVTVDRpcElmVEhPeEFZb3dYZENhak03anNSRFNU?=
 =?utf-8?B?RHdrdjNISCtUNjRaVFBveE5yNzFuR3pWenVxSU1PRllaMWg0WC91T2ZVc3Ri?=
 =?utf-8?B?cUtJeDYzRERFUjZudU5YUE81NWxWK3YvZnIzcFp1MFVDVFdGT1liV1VNZjRT?=
 =?utf-8?B?eG8zK3NRMkpvQ0JQYzlBbUFHeGRsc1loVDJhbjE3SVVrZk9KRjlycmRjT1V0?=
 =?utf-8?B?aDRPSkdhN2hnNCtrMVFjS1ArYjYrUmIvcG5qUStXZnJJSCtkSk1ieFk3eXE4?=
 =?utf-8?B?QlFOcU5lSDlpU2RVRTV0ZEZnZEhvN1R5NHBZMnFOaWV1VmFYYmE4NDdzMGpa?=
 =?utf-8?B?RmNFYjBDOGRXNEduY3gvQzBlWjRNaTZvemwxeVk3MkszUC9zbCtvSW5mSXZj?=
 =?utf-8?B?UkdLZUZxVU05SThUaWw1RE1zWlNuVG9hMkFxakFNS2R2SjVQQTdiVTFib3B1?=
 =?utf-8?B?MGlNbnVwRnJNeHZsOVFEL0k2SkRRaGd3Z2dsbmlrQmt3WUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUNaNmdhNFhhZnFTU2RnUUMybnc2dUdabFlNSlZkT0FiK1RMYXhPMTJUN1c1?=
 =?utf-8?B?RkxybXJYYjZ3TGNuckZoeUJkcStzVSt4KzNyV1VmMDQ2MGRONkhWZlVNWlVh?=
 =?utf-8?B?c0lHcDhoY3ZmZ2dFbGpXNWtYQlpTbmlmenlKc2VLWDNvZXM2aWN3Y0FCaUV6?=
 =?utf-8?B?dnFWR05xV0FVeW5lZm8yTVIrRXJqSENMY3RjdVR2cUpzZTZLd01ZbVJpdlJq?=
 =?utf-8?B?clZOT3FaLzZ5VTdUWTF4T2dLQk45WXkwMnQvbzNLZDQ1RENnaDhTck9uaXI0?=
 =?utf-8?B?ZUtSTTNhbFMyWWRicTBtREV3OWJqL3FsRldVN2krZ0lXSGhrTit4YzA2aXpy?=
 =?utf-8?B?enVHMEo3V1RkaERoem5ENnFERGlMYTNTWEJEVXdTaTRaUmU1eXlwNWx6NkNq?=
 =?utf-8?B?d3ZmU3YxaFlaOVZHbHJ6R2xZblk0SDFEMTBDREp6Yy9LQ3VMY1FCdFpjazNa?=
 =?utf-8?B?dXh4bkF3NFI2d2lXVHFaOXV2T3VqbDUxMHdpNUhpUEppSEQ5SS84WDJoWXQ3?=
 =?utf-8?B?L21MUXNOc01Pa3FMMkI4WitvR2U2YWFQQ2FuQ2cxS3ZGTS9NQkpXcWROY1JH?=
 =?utf-8?B?R1J0NUJaUlZGbDEvNHQ1NnNIKzh4YUs0ZUFndWNFUjFLSXhicUcvMXJYenFU?=
 =?utf-8?B?NnJLcmQ5ZHZoWE9PcE5XUG1lbkxhZUJjVHRweDBRaUU5dVVWeEFSSDJoeVhT?=
 =?utf-8?B?NWY0TjRDbEo0dUIza0FHZ0h6T1dpV1VmUDhOblB3dDk4dmxCSjhsN1Z5WGZH?=
 =?utf-8?B?Wlhma1J5ZlYzeHppdTJnUHVsdkloVGxTb1FMUHl1emdaVk9TbUNPblFJeFZN?=
 =?utf-8?B?TXdydWNzd0NKam1uSEFYVjlYRmVVeHBqMTVqdXBNcjZ6TlorVkQvamExYm02?=
 =?utf-8?B?Ni9VS3ZzbXd0azdTY2VBRVZldG9Ea1ZrTk14WGRkWEdKZjI3aFdDOTBFcXRY?=
 =?utf-8?B?UEF3SFFjaysxWHZucmN6MWZBVWkvRWJJM1VkVEUyWlNhdTdqZWtxU2lnQUJT?=
 =?utf-8?B?N3ozT3Vpbm5zQ0hoMzY1NjNSK3FLbm9qQ3lOMkRLTkxJWXd1OXpMOXFmVGho?=
 =?utf-8?B?Q2YrSW85WVVTUlF0am9zS1Y2YnRKYUpRYVVYdU8wWmdlTEIyWEFtZDBWamxE?=
 =?utf-8?B?YlJwV0swcTUwUm9uTnE5aFVPWndSbHhlcEtpZThqNHlkc1drTGZoVExxN1VP?=
 =?utf-8?B?bW5tSGhSYXVrVXJMbGx2Tmg0ZHZOcmNaMy90V21WbVB2dm5YeENnYTFjQ2Mw?=
 =?utf-8?B?T0dseUFLTkQ5dlVMaHV1Nmo4MHR2d0ZkcGcyc3JpSkw2MVQzQ2o3cGZadWMz?=
 =?utf-8?B?c0wrblhMYWpyREhUSGNWVEFualJhN3BTSFBpZGphQUtmUi9PKzBHaTQ4SDYw?=
 =?utf-8?B?Qm9PUHpBcXJ3aCs0eElwcmh2NVZsU3pwWWIyV0ZBTUxFZ2xoTEdiWFRVS3lz?=
 =?utf-8?B?VFp4WGVGUHExR0dtTzlxNG93Rk5wOTdlNjdRZm5GYTM0dkk5OElpeHFLZHlo?=
 =?utf-8?B?NnJ3ZkVlUDAvaUhUNTdweTFpdjZrd1RwZVFINXFPWmlSTTNYazU2eXZtci9p?=
 =?utf-8?B?c0lLT21lRFhtdmRBK2hwYUdKeVlxRDFPUG1mU0RSVzdvcGRPR20rYU42cVJI?=
 =?utf-8?B?NnlhczJHT0VtWDc3eTFwSU90eEd0N1FKWk5MMVU4Q3pXd2hkTkFDOGFGY3BX?=
 =?utf-8?B?S1pXbysrbUlsWUVHcS9rbFZaVmpkQzlBeDE2SytRM2NhRU1LOE9mc3JzZ3Ew?=
 =?utf-8?B?RDRSakNQUnBEV3NWYjVLVTlNNGFOeG9rK2o0MHFqZnE3WkJibGsycW5aZGZO?=
 =?utf-8?B?cGdwNEhqTE9DVUJxNHFGL2ZmLzlpODBZODdJemhSdFpmdndKNnZNZWNoQU1R?=
 =?utf-8?B?dXlORG5FWEFqUVJld3kvK0JOTDJLTU5EMEExbjh2VG9WcVpXRnNXQ3N4L0pL?=
 =?utf-8?B?bzUzRFFFMEVkRC9TQ1pILzlKOWEzWkVnUWh5dGRUTGcwNklzNUFhTjM4QUht?=
 =?utf-8?B?eERMSk9VNmlYb0Q5RjhDTTNUUXpDUUljOTVWYjZqeTV6VjVncitjK0ZQdi9H?=
 =?utf-8?B?cHpCbERMbUxyN1B6RmVQZFdtVFgzeEpKWlBEU1Y3VnZwcVA2R295Z1lFLzFr?=
 =?utf-8?B?TWJmSUlqWGlrQUNGWGhNWnA1VzJCVVdJb2R4MmxZSUVEWTV0dExNRWJUVEFw?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d46736-23cc-422b-b6bc-08ddc2bd0f33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:59:01.8191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhEERL2DKxQxhZ7syh6v5zriydgGu/ddGjZvSS40fZ//e6ipo373w29DRuJNzxLRxNROW3786Ytg0k3NR3756qLJNXJnILVHoxybCAyrwtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9958
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

Hi Naresh,

On 7/1/25 6:52 AM, Naresh Kumar Ravulapalli wrote:
> When i2c device is removed, l4_sp_clk is disabled; this would cause
> unexpected behaviour for peripherals still running with l4_sp_clk.
> This patch resolves the clock issue.
> 

Shouldn't we rather have those peripherals enable the l4_sp_clk as well 
so that the refcount is higher and the clock can be disabled whenever 
there isn't any user of that clock anymore?

Cheers,
Quentin
