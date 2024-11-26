Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3DD3B9B7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A72E8972F;
	Tue, 26 Nov 2024 17:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XJ8xwhCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CDA88618; Tue, 26 Nov 2024 17:13:20 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2AC89C8A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3iMwp+QkafdVHHOjnu/mlqSUSG3cihUjO7Dq1oVi3qnxIEfiqckfiIzDzABjaXy7mAkDdg0EB3vC4e42EgdjfyAA3JYknY1dvLVZpDx+GQ0U1Mp8cI50J+WReu/2dCpSq40mWiboP/kHyDmDpINvx2Zget+3wrfa6JMGKU7A3FcnRCA1vbGIMYPes/go7LEP2D7ZhRCepv5c433ludX77IZWaC51d5Eh+HnMb+lbKgR6xghMWIxc2ITBeY1n9ImehgVLc1LSRr32wLVkVJgoKsQaIrtruthV0JT8GRWDpU8lannS2a/QQb/78n9i1O0DpWIU44FKXIhuwpiuoz57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KSVDRutcD4+Bjiy7C4+afX/Uya1813bQMY/X8i4RYQ=;
 b=Qq+ua6wipAvJREFiKae8JM1JdepUru85ebD+2Az/Cc1o2lZXdyUXZwaVFQ7NQUpa7S2gKaW7QL4QMTa/Kzhphjj7hnDq1oL6eHQItVuGRqwYrmsCHEukVTa24ow0vRRarHgkBisOKCgOVG+RzV8xhiLRPR5pVh5voKs+/b+Uq12A4GMXeliz1myWiASsV8nVOo1nUrR+H9mMdrlbvf/hHGuiyJdUIzMVAl7vORYXRBe+QoxMrns0oCkBmbB9wz6IVHiTSdbK+rbr+NQdC64U3A1SrHuSGm0H8ctvuuxN+CkLRMIpD5CENh372FQRwiXfhJh8Ek96X7yngwAaJquxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KSVDRutcD4+Bjiy7C4+afX/Uya1813bQMY/X8i4RYQ=;
 b=XJ8xwhCf2pAigYOk2pDPglOwWTQF23mFMMcqwR6pO9dORdaHdAkdM6UxXLl8hk9xOGSwuk/48lhrOXRWzDm51/wlqHcnobKotYH0yQ+CojbJL4SNUF8lwzXYeULa1VBUpqNKgPzyLqee0Zzkd5zTu+qmvYAt/yFEUmp+N37+bjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 16:13:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:13:11 +0000
Message-ID: <61ab1427-272a-463e-b0e5-97e6571911e8@cherry.de>
Date: Tue, 26 Nov 2024 17:13:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when
 defining ram regions
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-9-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241121142731.1202209-9-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 87345be6-0f81-4993-6b87-08dd0e353977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elNlT2M3SnMwOUllQ1RLVHNDWk9nU0gvcSttZDhBbkk4eEYvZ2VxT3FtTytC?=
 =?utf-8?B?R2VYY3FWUDZ1SHliSE1TL3cwVVByVUxvY2xVMnV0Z29VNjlGY09wdUNLcVhV?=
 =?utf-8?B?NXU2cEJseVRtbkgxeUNQd2g0cXJCVUh4NkFKelpwOFNwVy9hUWREUFdDN1R0?=
 =?utf-8?B?bDI2MzdUVlRDbzhlVHhIN2hUUFNFaDF6TnhySzdKSEdrNFd2WGxNaFVxZWtD?=
 =?utf-8?B?bm01NjYwR3k5SnBuOHRTZGs2SG5hR2U4T01nOG9ORlR5dDh1ZmhDOU5hT3VT?=
 =?utf-8?B?WWM4RnByRUJ3NDFZYnV2Ym1SMThpaFE5WXB4RUw5L2dsTnVkalAzUDk2R1lj?=
 =?utf-8?B?NHJtZ05kZmFaaVNiOTMwSHhOcG1GNWhlMzJRS282b09XeGQyNXVuQjZmd0J4?=
 =?utf-8?B?TzhNRmV3NXQwTTRnMXROVU05WU53R0UvU1duOHd5clBJQTZLZ295UzZxNHVn?=
 =?utf-8?B?ZDNDWnhFck4zZFBsUWtsMlh1NEJ3ajAzZEJwQXA3T1hqR3pCM0JDLzR0MENM?=
 =?utf-8?B?YnRiL0pHNHVESGtGLzdQdFUvaWRHVE5yaHlmMUJTZnp3QWtTTndhV295WFY4?=
 =?utf-8?B?Q3ozd0dJaGk1aXpqUjRGM2hFYkhqM1lGRUxtdlFZZGhjbEhQWFN2UGhkcmVT?=
 =?utf-8?B?NXhQeE9nNkhiZldabm0rVUg3YjR6cTB1V2NhczZpaWJXVzRSMVlITm1zYmhS?=
 =?utf-8?B?R0cxR1FtcHUyWlZJUzg4TUdRWkZtRlNVVEREbmJxQ1N6Nnp0bVYwVGZkK0Rn?=
 =?utf-8?B?MGNnQng0MGE2MUNoUWp5dWJVaGtXdFplSWtUVnY0Sm1zV09tRitRRXFYRSs5?=
 =?utf-8?B?U1RRVnB6d09nbzdEYlU3bnRJQks3bVo1Rnh6K3Nhdk5DTHV0TVJxaWlSZ0Jw?=
 =?utf-8?B?RkxjRWdSOEZBTlJSeGl2azY2eEhmekhZSlJ0TmRHOXllR29iVFpDNTFkai8z?=
 =?utf-8?B?U0JBOVBpbE0xZm92UDdZaWlXOTNVbUU0UTV5YkRHc1o4T2lnZnM2S1FnVXo2?=
 =?utf-8?B?NThzeXlNbC80UEp6TlJXN0VyblRnN0d2dFNvaEtSdkRBTFZ2Y3VhRzVFOVFx?=
 =?utf-8?B?UkxtMDZhR1VMTTZwWjFVZjJqWUh0clF4dUp2VjVnUEVEaWJ0azdxUC9KT1o1?=
 =?utf-8?B?Mlp3SGQ5T3BQbURrcVJCU2tjUEZDN3ZLOHlBS0thY2dOSXhPZmlsdE9lVlBs?=
 =?utf-8?B?ZUgwYXY1WmE2ZGRDWGlzQU0vOW9jeS9pdkRDYVJWb3g1bGlmQWhURm9TVXVj?=
 =?utf-8?B?NEFqQnRmY1o2aE1sb2dSSEovTVFsY3dCbitoN3dvT2dvWGl3T25CSmVGRmxQ?=
 =?utf-8?B?eDZPM3BoRDg5N056Q04yM3FjSG9iYjJQc2NlTURUSUxvZFVNT256VTJISllV?=
 =?utf-8?B?VXpmbzJrMEVkeG5wM1Y0R1E1MzZpMHVORXVuVXhyeFJSaTBUa1BCUDVSc2p5?=
 =?utf-8?B?Mm10Njg4bmsrdjNNT1Y2WGVWYlZCZEkvQVpDRlFnVmJGV0dYekJIbVF0NGlr?=
 =?utf-8?B?UG1mWmlTam5XeGdpV21NOHZEZE9UT2hudkkzWXVyMEl3dEM5TjkyUDlyRXk3?=
 =?utf-8?B?NnhidzBpeUU1QWtTSjdzcCtsVmZISXhDaTJsTVE5alRheUdQNTZjSTNHbm5j?=
 =?utf-8?B?emNCS0d2VUR4ZzVCell3NmtScml2R0N0QUFwQnhUTmJqU3V3QktQVUdWNjVW?=
 =?utf-8?B?V2dBUThBWG9BaklwcnhhUXBmbXR6YXhuZnJRYlZIc2hSdFFkY21sOG04d1c0?=
 =?utf-8?B?L0xLOXNWZlozRGVubnBCMlhwaUFlKzh2NmNVTnA3b05uT1dwMkVaazY2dnRG?=
 =?utf-8?B?MG9FYUl0Y01hak1RZzVjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0oyRGFsM0twVGtpaXZqQ3ppdjRxREJ5cUIzZDhTMTJqTG54dWdva1dhWjdp?=
 =?utf-8?B?T0pZbFRHZCtIQTFQaVRUUkhEU294WEJkaTNHQlJnZUZzdFdQUFU2dEpCeDZH?=
 =?utf-8?B?OVg2d2ltcEltbjN5YWkwazM5RWZKQXNZMEFTZjk0S3FUWGQ5bldrZ2hacDUx?=
 =?utf-8?B?UEtsQ0ZTc1lvdndFaTI0T3plK3FNR1RHeEJHbUw0MitVV2lSKytJWnNmNlU0?=
 =?utf-8?B?UDBGNE85ZkNPU0Z0M3pnUW9zRHU0WmlpU0RaQndlSXhiZENBdnArWS94SVc1?=
 =?utf-8?B?SVdoY1BQM2dhMXhOY2NtMTlEd1FURkRJZ1FEQUdRQVRHZmtvcVNlUWxDYmlV?=
 =?utf-8?B?dVlYbnVBenNKdHMzSC9mcEM3Smo0NldBVVowQU9jSW1xME9sbElYU1R2TmZj?=
 =?utf-8?B?YmNvZTZKZ2RtY0ZHZk5iVU02Q3N0cFh2MWlDSnVXZmpLTkIyaVdaOVZ6SGV4?=
 =?utf-8?B?cXNwUUZFRmFIQUEyZHB4VUZZcUlFdCtrZVFkbFJqam1Kc2dwY0xCc0UrYVl2?=
 =?utf-8?B?aGpDMldrb2piRUFJWkdrTllKc0xiZkhKNGlxMXJlQS9HMk5PZU54SjV2YmRL?=
 =?utf-8?B?WnlYbDhGaC9KcnFMQis0OFM5UjVTT1p3cnh6OFExVUpjZ1FCdVhpeGdmb05E?=
 =?utf-8?B?Y0hTTHpia3g0WE9UbTBUd1lVRlhSNUR3QjVWb2hDSmtpNXdZTVVSNTJOL2Rj?=
 =?utf-8?B?aEpQZG52enhOeWdHSUpoZmxZc3pFOWFjVklGT2YxMS85bW1Ya2VmWDZUalph?=
 =?utf-8?B?djRwM3F6Ry8zMnB6NmZNR3U5M25hbUR6ZDZsR0J1ZC9SWmFZVlBJWHkxMEV1?=
 =?utf-8?B?QVZ4TTJFdTc5aGcvcGRzemtaWkpKRzhHMGNHVEZrZCsvVnRxam0vUTYrY0ZH?=
 =?utf-8?B?ZHUwYkYrdXZPeXNsc3FpUmpZN0lwTGdHVlZydURQU3hEaE02Z0pHY3A5Tzdw?=
 =?utf-8?B?WEp2K3ViRWh0Wnd4cGJjTUVhNU9CaWU3U1NXS3BIb3luVVhIOUk2ZzdDQ0M5?=
 =?utf-8?B?Z01xYXFqY2FGeWl2MFZEYW9LVHdNMzBPZmV6Q2pPK21hdXcxL1J3QXVOUkNn?=
 =?utf-8?B?U1E5dW5jQ0RzTHNzaEhCUUFPTGhDQ2JjOW5uRTMvMEE4cWNTTHQ5eDZyaXZO?=
 =?utf-8?B?VWFiU2ZDaWd1SEdiTFZhWjN5bytkRllMZnJ0MTFESVdHU1J5bTFXdks1Nktu?=
 =?utf-8?B?ejAveWRrWDcxcnFIWjBIRzRtWWcrNm1LdGRqa1hHbEluVE9nS1laaTNodUV3?=
 =?utf-8?B?SEhlQk9icUN6ZW5veUIvc1ZiRHppNDFJdkVYRmV1MytWQUJpSldPT1BMMzJa?=
 =?utf-8?B?RU05MmE2R3RUd2VlbzBaZCswNmppTURDTndMMHNoVDlpeGFCaktuRTBXem9R?=
 =?utf-8?B?VkFLVmhqZUpxbkJTTHFFSTRkVlB3YVRGeGFGT3lLaWIxUEtDUG9JNjZEMldj?=
 =?utf-8?B?MHJ6M0xxbiszQkhzVDRtdVVKSStZandVOWJkTEsxQmtDWS9GMUhQLzZBa1A5?=
 =?utf-8?B?b2dPbHBaSUxNbzk3SnJFTGRiblZ6Z1ZWMFBOTzE4SnJFNy9CUUxXODRGUzFF?=
 =?utf-8?B?SkpqMXdJTkg2NS81eDBsVUNvNTBFdEk3SkJTVG9lSmQ2NDIveEtMNWFjZkhG?=
 =?utf-8?B?SCtjOHFUaXRjV2h4L3dsYzhtaXVwMU05YjVqbUVDM1pYTjBjVEpHcjYvemgw?=
 =?utf-8?B?Qm1JcXNFeWV6RjBsY2orUkhIZENxcFVoUHNxNDV3dWJhenpQWm5FTjBlOTc2?=
 =?utf-8?B?NC96TzNackNWbzhSRnUrcEVGWWZHS0RLVUJLZDVEVUNmaEMrKzJYMmlQWElW?=
 =?utf-8?B?dkZzcjd0VmgrRFUyMlpmYXVhc1BaNVpTT2wwNzJRQ21KNnZPdnFQNWUxZUFY?=
 =?utf-8?B?MWZWWG9nTFRGcHhkbUNuN1hHRUJ1RGxsWjA2ZGJaQ2VHYnZLY0xaRUhzbzhp?=
 =?utf-8?B?L0J3TVFTK2xiYXhON1dDVW1RVlF4UUk0cllhR243d3g4YXBwWWxZSU1SeXZh?=
 =?utf-8?B?R21hWExuWDV6ZzZ4eWRuQU0wRU5rZ1pXbm1SZ2lLUGVkQkxJS3lTVkZ2VC90?=
 =?utf-8?B?TC9MLzEyK3pOWlQ5OWY0WldRWHZFaGVWR2hWdVIwSWFnTGpQcDNhcnRMbXN5?=
 =?utf-8?B?VHNUWTdLTi9mNVY2K1Q3OGJxTEVJUmZxN1hnMnZxWGN3b3ZRcTBSQWZWSW1W?=
 =?utf-8?Q?Zs+tPK7474h4CQhONQvb3nk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 87345be6-0f81-4993-6b87-08dd0e353977
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:13:11.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/iQJhzlpvf8wr+Axf+DWZ/fmTFlxrmB4XRSDPdhqxkP5xWMUhMJmITRK1wCmW2LxENo9IO101f5BQrTS3ofvqk2KQjBhdhA2DV1L2kRNWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727
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

Hi Heiko,

On 11/21/24 3:27 PM, Heiko Stuebner wrote:
> Currently the sdram code for arm64 expects CFG_SYS_SDRAM_BASE to be 0.
> The ram being in front and the device-area behind it.
> 
> The upcoming RK3576 uses a different layout, with the device area
> in front the ram, which then also extends past the 4G mark.
> 
> Adapt both the generic zone definitions as well as the ATAG parser
> to be usable on devices where CFG_SYS_SDRAM_BASE is not 0.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/sdram.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 1fb01e1c4b1..4e2af55d6e1 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -181,9 +181,9 @@ static int rockchip_dram_init_banksize(void)
>   		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>   		 * have it, so force this space as reserved.
>   		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < SZ_2M + CFG_SYS_SDRAM_BASE) {
> +			size -= SZ_2M - (start_addr - CFG_SYS_SDRAM_BASE);
> +			start_addr = SZ_2M + CFG_SYS_SDRAM_BASE;

I would just put CFG_SYS_SDRAM_BASE on the left side of SZ_2M.

I would also do

size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;

But those nitpicks are just a matter of taste, therefore

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
