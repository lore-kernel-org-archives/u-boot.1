Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C5C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 10:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2754803CC;
	Wed, 25 Jun 2025 12:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OjLCYdN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CC182CBC; Wed, 25 Jun 2025 12:08:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BFA8006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 12:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBncTQ++9rTjnSkDZ7gwIx0Cg6/AnysDGYQWCekqSbYA123+4iAoXck/vjYQsPZPqRH3kjnBFpivPYBWqyyinfrZic4qs/rh9ADdorGaJqDHAd8iqhNiq/Z+cna8OI1cL2nWNuw5Z7LoOFH/ppszjAXNIsr3VIoMHPqUkFW9/LJ4+/Kuu5n1AlzDS4IqKQOkVAVVUBVO6pPnNuo0V/5TM+VSvnr6ZCYq+QX3ZvPdLOkHgyimAF5J0ZQz99/F7w2Sg925hA7QB1ACnr7ndgJT/f7HXQgJdZvxUoHw/sWE2cmtLjFZvxfhO93+Hq9MOrhf28VH/A4L17bmrj7bo7YBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yISZZkwGTEyp1VwpxSIPOTuoSgzJrEDiogUKN3AoNeQ=;
 b=eziLyqi6bt7v0Rv/YcIBF2Z2NcysDDBNVeleOOhV3OQ0Lwg2p1O8lZHQu18H3nn88yYQML4hzStkU53O/WfzNZ79Jk3tu3Sitxj3+49PvkNnTpIsIyeCPHWpyTquTWEUXbje5LZLuaK8gL4ecl+BuUAJdJKIMHYV1NA7TVA8ws/Dn9HV9m6tpME+jS+hoje0P4gY06a2X4PUXxvIZPO5aIcl2TUkqBta89RlnaIPRYEjDdmoIjQNcbcr/kud0Kq7BUSk/HgcW2fZPyRV4WGiQb0g2EUl6myH7ZIhxi3F1EE8hvat25Gk0c0psNiiOk57b+kkAG/9F1zOn8NMcH/bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yISZZkwGTEyp1VwpxSIPOTuoSgzJrEDiogUKN3AoNeQ=;
 b=OjLCYdN6lTI1qpX0A3+hB/s0OaHgpYOfX1r+fWqlJAzA19MYitaHz81d3XFFX64pyeYewKXianP4rfjP66M5vjFQs6iABT0Gf7gyTU0eRmjtdvBYWdC7og5IplgTE9dwu4nuZksPphUbrkP6R/qX0lISZc83j8oTaW85EWQO6fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8527.eurprd04.prod.outlook.com (2603:10a6:102:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 10:08:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:08:10 +0000
Message-ID: <ef2ad96e-3812-486a-a161-fd241b9737b7@cherry.de>
Date: Wed, 25 Jun 2025 12:08:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Extend usb_onboard_hub driver to support Cypress
 HX3 hub family
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 044800a8-4409-44ea-f013-08ddb3d02e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K21iWjBzL0I3ZlQ0WVBzY28ranpyR01Ramx4bHhrWis1QnZGOWUyRThUMm5H?=
 =?utf-8?B?cHI1ZHNhbzZrNnhUdXlGeXIwYWRYdlRqOEVvQ01nMkhMNmRTUVRlTWNSVTZB?=
 =?utf-8?B?SlJybXNFeUVweGhybG5lSktYcTBmaHpWMEJVWmh3Y0VEQmgxT052UGplNmx1?=
 =?utf-8?B?NS9vaCsxNGlST1gvRGFpbTBPT21ZMElTdEF0YVhVTTdjTnpGN1lwQldoc3BB?=
 =?utf-8?B?MTNXRXlnYVRPMXBSTG1DaGVnaXk5OWtpUEViVUpSajNOQUtrZ3l0ZC92eXJ4?=
 =?utf-8?B?bE9UK0VKRStSOTNzTDZtL3BuSEpEdmFUTkxOdXJkL0hEamJ4Q282bkFYQnR3?=
 =?utf-8?B?NTFMY2VaWWc4TlVYNXNpelVzSk5rMlJVRG04NlhqL1NWQXJBOXUxcFZQVmor?=
 =?utf-8?B?c3VIVU9SSkRZZTQzajJEQy9ySEV5VEMvTnVhdjJWS29Zcnhndm96aysvQVli?=
 =?utf-8?B?TDFzUnBPdGZNdCtsZHdDa0xCd2k1ZmxVL3ZUblhzZmZKTGpXUG4vTkdhY1o5?=
 =?utf-8?B?YVV2UzJOTEZvQ1BvemJFakJBdFlsNVNzZHVoMU81WXE1R2hHcjJNbzVlTWl2?=
 =?utf-8?B?RzVJR0p2aVR4UDkzZllwMXRkNXdhVEl3TXV4UmQrS1dUcTNVa053OE8wc29q?=
 =?utf-8?B?elN6M3o0MkFZbmZiTXpHdkpnUUoxV05ZWHAveWRTU2RCNS9vM1JEckJ2UWwr?=
 =?utf-8?B?QVh4SStzMHU4YytjOFpEQUZ4dktpTFFSWlIzZlNmbjdtbmJqTW9zUmd2TzJn?=
 =?utf-8?B?UFN3aTFoU2NpY1BWOC81M0t4dkFrVFZmeHBKU2dLZjlaQ3hGRDN0bUV5eVZF?=
 =?utf-8?B?Vm1Ka3U3dS9UWFE1T0N6ZmdLTW1pYWxybWg0V0dwa2V0Mk93RnowbzltYU9Q?=
 =?utf-8?B?R0dOMGFVOFJJMUVETytXbXdvalBpc1pnTTl6VGxSZlprMU5SMlBFZktuUitN?=
 =?utf-8?B?TDA3bzZ0U0lCblpKWmpGTFRQL05pOVp0M3BoMm9IUUxid0pYT25SMm00RFhE?=
 =?utf-8?B?cWgwM1NPOXQ3OHMraVluVzEvNVRMTHZzVGh2WUYvcSs0UEgrOGhOdmQvN2RE?=
 =?utf-8?B?c2lmTlE5MnNNRmNvMHJ3U2RaaEpJKzhMRFAxZ3R1WW5pZy9XOEpDbE9RNGts?=
 =?utf-8?B?dGE5NStKeGNMTmdtcGF6UnpmNC81UXpBS1V0U3gyRjJ1VzRneVd5MXltMFQ0?=
 =?utf-8?B?Slh1NHhmcnVjaWtBZnM5QzVvRHJxODR1cVpLU29mU2RsTGc3aU9icURoM2lO?=
 =?utf-8?B?TTRxMjF6bUFuMVVFbTI2UTl1MC9SZ3JwTmZhZUE5SlJMb2lGYVVnU1M1Y3Bq?=
 =?utf-8?B?TU5SLzRMeGRMRmwyMEh1b2VXcytyNkl6Sm9MYWVtYmljckhjcjdFRi9PMWxn?=
 =?utf-8?B?Ujd6UzQxeWlBZk91eUdKWEZML3NxcDYrcGVFTThZWlZNbFBLYjdrSzFQSjAx?=
 =?utf-8?B?TDhMRTV1dnZIcWFzOEU1RGZlSU9aWmlHUHZleWNsMk1yOUY3akhLYzBQeUtw?=
 =?utf-8?B?cTBsUVRMMG1hOEpXK09vQ3dzTTRLc2hMSTljdHV6V1JSc3hjN2JFYXZzanpW?=
 =?utf-8?B?L0tQeXpZQWQ5RTEwZHcxMlgvb3Q1RWpMRDBRWStBTWRnQXA2OXdrTmJLRnZF?=
 =?utf-8?B?ZjFQcTJMTzF5RVdTdjNyQ2VBa0JoS2JkOVZiNmhodEovZEdjSEdJajRYeE4v?=
 =?utf-8?B?ekNVQ1EwMEllYnNtdE9aVTZUalRWOExGS1JkL3J4WFNFR0RQU3hFT3M3T2xT?=
 =?utf-8?B?YzdWenI0S2pIWTdUN056T3VGSCtIOWlLY3lmRG03eTl5a2hENy9ndzZmSVpy?=
 =?utf-8?B?NWhyRXNUTWgyR3dCbVU2cmtNODhvRFVBR0pGdGRpRVQwaVpxU0pBYmIrRzFU?=
 =?utf-8?B?Y1c4VHpQZHR0RHdvaU9LK3FRVlptZWh1c1dIaTl3WGtnbWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRtaDFrdWttNEZBcjBVRmVieVpsUVdYRVFoWTJUaG5hN1h1bU50a2JMVW1U?=
 =?utf-8?B?UC9KTmIrQXgzRXE3bkVCSFZuQkRqRGUwNTFuWHhTMXVnSWV2NDBRUzBkVjdH?=
 =?utf-8?B?dGY5SzIvNEc1U3AxOWJLd29RNkNBay8zTGdNRFVBczVGUG8zT29yUFdwMFZK?=
 =?utf-8?B?clVFRzB0d2Y3b21XQWZxR0pxckxVMHorenJIdFNXbFNrU3VOc2FsYk1LTmRY?=
 =?utf-8?B?bW9FUzY4aDVzS3RiU2o1UmcxeHJHWjJyank0WUhxWkZzN3VobG5pMjNGcDVK?=
 =?utf-8?B?NW1LSW1YUGYrVTI0UG1aYk1zWVQwYmE1Ry9XTWxyUUhGWm9pUkNNZ05Kc0E2?=
 =?utf-8?B?a2tIbVlhL1loOVdOSDJsVTQvTnA3aFRWaDdvMml2dGlpQ2tDNll2SzVla1B5?=
 =?utf-8?B?SjduQ2l1QnorWWxsb081VjhpUk5CRlU4TDJPRlVpT1B6YklJTFd4WkNjWitp?=
 =?utf-8?B?QlhpZ28zUmMrd0hld2xoRlc0U1F3eloveVBLREZzdnhtdk9ZWndsWGdlZTFa?=
 =?utf-8?B?ejFpdEZveDNJU1hFM2w5UThlelZaajJSVzg4ZCtTM0hKTThZQmRCZWRmbWtk?=
 =?utf-8?B?Y1JWUy9mVkpFMWpqZUF0c0ZwckJ1cVhHbUUzOTIybFZFQWJsMnM2S1F6VmR6?=
 =?utf-8?B?cXZVTndMNUV1N3BhR1BGOW9OcnVoQkxMVXlWZVIzTVB0TXk1V282L1lpQ011?=
 =?utf-8?B?YUh5eEZ2aXc2NVNGT095RFAvRnFZQjVSNUVWeDNkYW1mVWtBVVVsOUl6UmJF?=
 =?utf-8?B?NldsZlp3ODhDVVVLWXBVZmVGUFNjMnMxRFdPdnFzR1VWMTJBL1U1bDlxSU9h?=
 =?utf-8?B?U0ZYYW9MRjZKcjdwOG9IMm1GM2V3M2c4UDYxcEpMaSs5WkRZK2RBVDlrdlBU?=
 =?utf-8?B?OWR2N2ZnVVVBbzNqdEVKR3VGUVZmWU9MQ25wZ2c1YWt5OStvSmRWbjJseWVU?=
 =?utf-8?B?K2V4NjIxMlNzTytNLzUydnZyeGNUK1ppcXN2YWxKN0JSSDFGaFJWQk5nd2JS?=
 =?utf-8?B?Rm13QytGT2QwbVF2bGMwbXdwQ0FFdzdkTDZVbEE5MXJnMzNScFlnRGRyMkQv?=
 =?utf-8?B?M2w1ajVqdDBHVmprTTJBdWMyUGZBd1BBdlN6TlorSWJjMkVqMnF0QWtWSnIr?=
 =?utf-8?B?WjQwODVFYkdoeHhXSGZGTmZiMURvQXpnanJyb1VsaVJDeFJFZW9NczNKblU0?=
 =?utf-8?B?d0xUblFLRGJ6RFM2TTdRTEM1K01SNEVQa3NyU0NubVZIY2FTbythUmlmeEtC?=
 =?utf-8?B?ejRoMXI3OVhmRjRkUWM0NmRmWk1Yc3JtRktEeExkb1R5eTA5aFVJaHE2blVs?=
 =?utf-8?B?UWkva2dveTBzaFlGbHRsTGUyNHdUU0NFNWFrVjVpN21DS0U4cFphNGxrbFB6?=
 =?utf-8?B?VTlhY0pnanNBNFNDWnNSY1MwUm9PbU5mQ2grb0RMa1ZOemNKTjhVRGliQjVY?=
 =?utf-8?B?eEx0V3p6Y3FwMkhhUzFFUmlUbjlFQnM5VGo5Tmp1N3B0bkE4S1J3YUd3YUpt?=
 =?utf-8?B?Qmo2dXQ2Y2lvWUZxZlB1U0NhV2ZxcDE2bFJxbjNHaU85dENHbjBpY0o1V2Mw?=
 =?utf-8?B?VHJJd0cxSVJQc1VGaXRVMUcvMmlsTVlIM0p1cVV1UllmR0NPZ2Q1OGNGU1o2?=
 =?utf-8?B?TS9kaElubW9lWEc1dVY5TXJJRmNIc0dSUkIxelg1cnExbkprMEs2VE5GeEFY?=
 =?utf-8?B?dDY1aDhpV296eUs0TWp0dFVtSkJtaElmVDEybkR1WGxZODZQemhad1cxOXRY?=
 =?utf-8?B?NU5JY1dzU0pCY0NZN2FjaEhCMXN3a29zUk1QSTk0VVNzc0JSSEJuaEIvTjJQ?=
 =?utf-8?B?c05aNkY3QndraStpYkFxYitoa1lrQXN4QXBxMWNJMTYrbzczaGNEc243QnBt?=
 =?utf-8?B?VU54SWpkTXlNMHZsdER3aFI1aVNlVDNiTGZ1OThQRGw2bHFSc2dodXhpRmdm?=
 =?utf-8?B?VGpKa0pjUXp6RFJ0a1gramk4Z0J6bHRrbHV4TnJCNGtRbXRIMWxWY1hvRHFr?=
 =?utf-8?B?NWZVWkx5TXk1N3B6cEtYUG96TTVSZEUwMEluRXltNzU5VHYwdXBZUUpRbURr?=
 =?utf-8?B?eGdxeFlNbkk3NUlrWTNiVG41TTVldFlNcmxOWlJSM0VnRWhMaUdCdEhnTTRW?=
 =?utf-8?B?djFRSWNLZWZ4U0NsOHBJemJCczdwYnFpVWRZbHhIUzAvaGkwMTBxalArRS93?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 044800a8-4409-44ea-f013-08ddb3d02e87
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:08:10.7330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+oKQ9bZnlaLxmWL8Jpjzx2pDR+pJKSNrfh35mlFdacjKoH/wCj5Uq1cFZwz42j6FckxsfVb98Ldvufbcyw6S+YFOaSI5ZRBh4zBSPyIAUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8527
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

Hi Lukasz,

On 6/10/25 10:02 AM, Lukasz Czechowski wrote:
> This patch series extends the usb_onboard_hub driver to allow for
> support of more types of onboard hub devices, and adds the Cypress
> HX3 hub family.
> 
> First patch in the series updates the bind function, so that it no
> longer uses hardcoded compatible strings.
> Next patch simplifies the code, by removing unnecessary dm_gpio
> function call.
> Third patch updates the remove function, which allows the prevent
> issues with usb devices reenumeration, in case of calling
> "usb reset". Although the issue could still occur in case of invalid
> initial state of reset gpio, it is minimized with no impact on main
> usb_hub driver.
> Fourth patch extends the driver with support for multiple power
> supplies, the same way it is done in kernel driver.
> Finally, last patch provides hub data and of_match table entries
> for Cypress HX3
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

For general information: this patch series is required for RK3399 Puma 
once devicetree-rebasing is updated to 6.16+ since we have 
non-backward-compatible DT changes. We should be able to anticipate the 
breakage by simply enabling USB_ONBOARD_HUB in 
configs/puma-rk3399_defconfig. I'll send a patch once this gets merged.

For the whole series:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma Haikou

How I tested:

- Apply the series on top of master
- Set config to puma-rk3399_defconfig
- Enable USB_ONBOARD_HUB via menuconfig
- tools/update-subtree.sh pick dts 0fe42d171081426ab119ca5c0eb130e5f3a9a805
- tools/update-subtree.sh pick dts 53aacaed0ad140b017c803d9777473c6c62f5352
- tools/update-subtree.sh pick dts 932da7a8df7b6b43453d640b383d0076d5a7d9a5

Connect a USB stick to Q7 USB P0, P2 and P3.

When in U-Boot run:

"""
=> usb tree
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 0mA)
   | |
   | +-4  Mass Storage (480 Mb/s, 0mA)
   | |    SanDisk USB Extreme Pro 54A45678CACF
   | |
   | +-7  Vendor specific (12 Mb/s, 100mA)
   |      Theobroma Systems Mule USB/CAN Adapter 002A00244356530720323439
   |
   +-3  Hub (5 Gb/s, 0mA)
     |
     +-5  Mass Storage (5 Gb/s, 224mA)
     |     USB  SanDisk 3.2Gen1 0101b5ceeeaf252dc220834775927a7
     |
     +-6  Mass Storage (5 Gb/s, 224mA)
           USB  SanDisk 3.2Gen1 01013e8773b9dc4a14a4278d7dd42fc

=> usb storage
   Device 0: Vendor: SanDisk  Rev: 0    Prod: Extreme Pro
             Type: Removable Hard Disk
             Capacity: 122112.0 MB = 119.2 GB (250085376 x 512)
   Device 1: Vendor:  USB Rev: 1.00 Prod:  SanDisk 3.2Gen1
             Type: Removable Hard Disk
             Capacity: 29340.0 MB = 28.6 GB (60088320 x 512)
   Device 2: Vendor:  USB Rev: 1.00 Prod:  SanDisk 3.2Gen1
             Type: Removable Hard Disk
             Capacity: 29358.0 MB = 28.6 GB (60125184 x 512)
=> usb info
1: Hub,  USB Revision 2.0
  - u-boot EHCI Host Controller
  - Class: Hub
  - PacketSize: 64  Configurations: 1
  - Vendor: 0x0000  Product 0x0000 Version 1.0
    Configuration: 1
    - Interfaces: 1 Self Powered 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 1
      - Class Hub
      - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

1: Hub,  USB Revision 2.0
  - u-boot EHCI Host Controller
  - Class: Hub
  - PacketSize: 64  Configurations: 1
  - Vendor: 0x0000  Product 0x0000 Version 1.0
    Configuration: 1
    - Interfaces: 1 Self Powered 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 1
      - Class Hub
      - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

1: Hub,  USB Revision 3.0
  - U-Boot XHCI Host Controller
  - Class: Hub
  - PacketSize: 512  Configurations: 1
  - Vendor: 0x0000  Product 0x0000 Version 1.0
    Configuration: 1
    - Interfaces: 1 Self Powered 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 1
      - Class Hub
      - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

2: Hub,  USB Revision 2.10
  - Class: Hub
  - PacketSize: 64  Configurations: 1
  - Vendor: 0x04b4  Product 0x6502 Version 80.16
    Configuration: 1
    - Interfaces: 1 Self Powered Remote Wakeup 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 1
      - Class Hub
      - Endpoint 1 In Interrupt MaxPacket 1 Interval 12ms
      - Endpoint 1 In Interrupt MaxPacket 1 Interval 12ms

4: Mass Storage,  USB Revision 2.10
  - SanDisk USB Extreme Pro 54A45678CACF
  - Class: (from Interface) Mass Storage
  - PacketSize: 64  Configurations: 1
  - Vendor: 0x0781  Product 0x5588 Version 1.0
    Configuration: 1
    - Interfaces: 1 Self Powered 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 2
      - Class Mass Storage, Transp. SCSI, Bulk only
      - Endpoint 1 In Bulk MaxPacket 512
      - Endpoint 2 Out Bulk MaxPacket 512

7: Vendor specific,  USB Revision 2.0
  - Theobroma Systems Mule USB/CAN Adapter 002A00244356530720323439
  - Class: (from Interface) Vendor specific
  - PacketSize: 64  Configurations: 2
  - Vendor: 0x2294  Product 0x425a Version 3.4
    Configuration: 1
    - Interfaces: 1 Self Powered 100mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 2
      - Class Vendor specific
      - String: "UCAN Interface"
      - Endpoint 1 In Bulk MaxPacket 64
      - Endpoint 1 Out Bulk MaxPacket 16

3: Hub,  USB Revision 3.0
  - Class: Hub
  - PacketSize: 512  Configurations: 1
  - Vendor: 0x04b4  Product 0x6500 Version 80.16
    Configuration: 1
    - Interfaces: 1 Self Powered Remote Wakeup 0mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 1
      - Class Hub
      - Endpoint 1 In Interrupt MaxPacket 2 Interval 8ms

5: Mass Storage,  USB Revision 3.20
  -  USB  SanDisk 3.2Gen1 0101b5ceeeaf252dc220834775927a7
  - Class: (from Interface) Mass Storage
  - PacketSize: 512  Configurations: 1
  - Vendor: 0x0781  Product 0x5591 Version 1.0
    Configuration: 1
    - Interfaces: 1 Bus Powered 224mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 2
      - Class Mass Storage, Transp. SCSI, Bulk only
      - Endpoint 1 In Bulk MaxPacket 1024
      - Endpoint 2 Out Bulk MaxPacket 1024

6: Mass Storage,  USB Revision 3.20
  -  USB  SanDisk 3.2Gen1 01013e8773b9dc4a14a4278d7dd42fc
  - Class: (from Interface) Mass Storage
  - PacketSize: 512  Configurations: 1
  - Vendor: 0x0781  Product 0x5591 Version 1.0
    Configuration: 1
    - Interfaces: 1 Bus Powered 224mA
      Interface: 0
      - Alternate Setting 0, Endpoints: 2
      - Class Mass Storage, Transp. SCSI, Bulk only
      - Endpoint 1 In Bulk MaxPacket 1024
      - Endpoint 2 Out Bulk MaxPacket 102
"""

and

"""
for dev in 0 1 2; do usb reset; random $loadaddr 0x8000; mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000; usb dev ${dev}; usb write 
$loadaddr 0 0x40; usb read $kernel_addr_r 0 0x40; cmp.q $loadaddr 
$kernel_addr_r 0x1000; done
"""

which writes random data to and reads back from each USB stick, you 
should have three occurrences of:

Total of 4096 double word(s) were the same

The reset isn't technically required for each device (only one `usb 
start` or `usb reset` should be enough) but it allows to make sure it 
actually works (since one of the patches in this series claimed it 
wasn't working before).

Thanks!
Quentin
