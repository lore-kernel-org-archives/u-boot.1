Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A86C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD6F82F00;
	Tue, 15 Jul 2025 11:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MCrUMaUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461AD82F14; Tue, 15 Jul 2025 11:19:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5345E82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXtttflLOIQJBPDXJorgvmg+ta+ONn4OeL78AuuKaXts6gj7KVhJn/nYlJp7o7H6kPtHpCzbcaXbo2Zxjha4Tb3q/Qrv81nwXoRisSaEDsSNNpirz7KWo/zp9Z/7KhtCrFHVkqGsYFrVMx7PCl0xJZuIrdAMCg61lvhORVQdavMH4xITg808ZAgDUi2xMUw1LLJJSAoEd+mlpeaRoDQGnHlqDcrEQkfsfBw1CKBtkrgVLjuLxkqdsia5wJzpD9yKkjiVJoeedRqvh5ulE+ZId1npl2EDZ1sCYfnTVsCpCEtoUpp5vBv2R2elaOjpSEJsydB2h7w3saVUSx8Ku3CHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HFI36lIckz9/0Euv/51miKgoCbJl9tA3n0n9IfzuCs=;
 b=sOtVPYVAe9hEucacr4c+BGWLnEHVoeyyFpUFhzMqURzidLEcvAi0geH1lIZBrC+jMMWLN6ZGp3HGbjdFxj8lI/r4kPacOCo5FIRn6mhK5NGVvkzZKpVKoXEgTcM3gL+fvu28AJK4p/5Y5aGlHAk9rHbX9aX9NlIrnj7D4+9nIy7vrzlm+OkfvOckfSdKXjL1z8oCXdhusjHyh8INhHEzkh51Gx1ntNCeJqUCw5MAxsrwYRTtwK2ZT832HaFn6rrXLIypoXXSr8QkfLc0nZo/85e3fhwkb+gLUm6ofc9eZlnST6+HvrN/TqH0+mKAaaJi84M9LT4Vm76eE1Bi04cQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HFI36lIckz9/0Euv/51miKgoCbJl9tA3n0n9IfzuCs=;
 b=MCrUMaUCSvFeeteb3T1dWpSabpbrY5dfKkDMyhRpMe05LdLj53MhuFD0INoZYhANwszOdiap05cRn+sRgpv1zmlICSjcCkOLjIo+g8DeQqcUQWICpeZoF1Rx5r/fy5OAr/xfdSqI8EDjJq2rSchA4Fk3atrLWNsDX4nh37y43XA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10832.eurprd04.prod.outlook.com (2603:10a6:800:267::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 15 Jul
 2025 09:19:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:19:46 +0000
Message-ID: <7f502029-21de-45e3-a9da-4c681af0affc@cherry.de>
Date: Tue, 15 Jul 2025 11:19:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] rockchip: odroid-go2: Remove cru assigned-clocks
 override
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250713233429.1376172-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0111.eurprd09.prod.outlook.com
 (2603:10a6:803:78::34) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abb581b-d819-44da-9904-08ddc380bd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGttRHA4bjRESXU1eFcxL2xWaUYvRWlVY2VkU3ZqUjVwMXVtV3EyS0R0OHBO?=
 =?utf-8?B?R2U1K2YxRGlvVXIzYmZWcW5oVVBOT1M4ajB2ZWVpQTVpZFoyMjk0Q3BGOGJR?=
 =?utf-8?B?cjVNQ2pZOWhjV3dyR21CMDdtWWhGamN1cWNGbHdiY0U1UXdld2YvUXFlSmNr?=
 =?utf-8?B?YkoyY3NTU05CMFBkcTNPZ2c4NFVtbXhuVm93ZjdUSmVpZ0lqUmVObkxrU1Fi?=
 =?utf-8?B?cUxZaDBUVG5HU0h4UEl2bmRkZFZ2bGlIZWxCaU1oRTJzMW1pbmx6RmpxU01x?=
 =?utf-8?B?WUhibmk2TmRYQWs4NGxXcHhRdHNXSm1GRUNhZjhrckxvRXBsOXIrWm42eSth?=
 =?utf-8?B?OWRDemsyWHNGVVREVDVRNy8xVVN4NC9raGk3SXRtakdxZ1k5TzRBQU5SZTdG?=
 =?utf-8?B?Y040bmQ4N3dHOW5LMG5wck1TZXZNNzZWQTAvQ1VVZUpLeEVUdUlLYWdzQW5z?=
 =?utf-8?B?Q1NHSSt1Z1N4ZzZNSE1ETnNMR2dBK205OTVadWxpZlJzRU9xcit3Wm0rTzJo?=
 =?utf-8?B?V2h5SWFLZFJheUgwOWl6WXdVMGI1d0MwbzgvdDd5ZVVHaDdoRkgwMzcyUHgy?=
 =?utf-8?B?Sk53ditCbnoyS1dRVzFuNW5DdXZxa0pqdHY2VG5qQmJBdmxXeC9PTkVRSjNk?=
 =?utf-8?B?Y3lteW9SZkxFSWgvV1JtS1VxOU5kdXBUQWpYODFJZTU1VFlNaHFYSXFjYVpl?=
 =?utf-8?B?dHZrazJ2WVZ2Z0ZhN0o5T1RnY2NpWnVRSDJJcW50eC9kZjBpVEJrVUxoM2Ry?=
 =?utf-8?B?RlhZR2lYOTIxUDltWGV6aGtsTWZHS0tvMndLbmgvck9jZkF5bXZNd0ZPNnFF?=
 =?utf-8?B?dDVkeTBOMmgrSnZSV0xiWXRsVnZyN3JRTWdoNFJSTkY3a2pSMFd0cW5pUURL?=
 =?utf-8?B?YVlZRWIwZFljWnAvQktZS3poVkxlY0FGY0JPK0VPNXBwdE9iNDg4VEtpNEhw?=
 =?utf-8?B?aGJUT2tYb3FNOU5xcUhONGxaclEya1ZGNzJvV213ZXBuSGlidDN5RXlzTHE1?=
 =?utf-8?B?akZhVVAvcXAvTHFicmN1emVQMGdsZ0prZzA2Sk5hMnlRRUVqemwwMUxIZ1or?=
 =?utf-8?B?NjJZMlg5QjFKSjZJL01KdERhT0ZZRzZOOFlHcGVjNDZRNkkyUm02eFFDazZm?=
 =?utf-8?B?cW1kK3pzSGM0SEUreXREQnpTUVVVamhjSG4yc01aS0NWMVA0R09uSUhyL0Nl?=
 =?utf-8?B?N2lXUURnUlJRZ2hES1ZrYnZVU3lCeitzbHJNMUlSbThBYy9vZjlCTFFqT2o5?=
 =?utf-8?B?aWZoVXF5N1dNa3BjQnhOc29ueW9Ob1pqLzM3ampFaXFGQU45RFBWNFNMSlYw?=
 =?utf-8?B?eUJYeUpIbjNrRUlsVmVEVHRTL2pLR2NnK2pUbVdIdlR2dG9GVmVJWXh1Q2s2?=
 =?utf-8?B?NmRSMGFSSDdqWHNVVW1FSFgyeEZxdHBoZk1SR2ppWXY0REtIWjRtcmhuN0tC?=
 =?utf-8?B?R0JRTkFqNHg4cFVjdW0rbnZQWHNxc1Y1UzVsdHV2SGpLN2VGMFE1WTdxbmt6?=
 =?utf-8?B?M3JROUxyNnBsRnNMcnhpY1hMK0c2WTcweUxsNGZWTEppUFRtckhYOTF5eWJy?=
 =?utf-8?B?WDQxcGZLZnNWbXVmNGlER0N0TVAxUTYvU2dhMDZGWkY5WUlmL1RGMGh3T0tm?=
 =?utf-8?B?Q3RPYXFEVDNxWVV0NjZQOEFGOXZ4Zm4xZDhJOG0zWjZHd05TalNzVVM1bkth?=
 =?utf-8?B?aEhBajN0YmZBeit1WWFGVGg2VDNQcWdQZXdJWExMbWZWOUZGWFVYM3RraWg2?=
 =?utf-8?B?UzIzcEJlMDU0b1RZMi9oSlFTeFVwbWpDV3NpblhoV0xaYkd3b2xVSkxEUWl1?=
 =?utf-8?B?NFlaQzhZZ2dQbllOclhaYnlNd2ZDU3M3MlJqclFJMHBKSHViMm96b29GVlVU?=
 =?utf-8?B?NElIRnVTRUF3QVBkTUU3UHV3UmxwemlRL0VuUmJMRUlOY3RsWGpYaVY0c1A0?=
 =?utf-8?Q?vwj39M8VTg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czR0T3gxUUNBdUViTjI4SWszKzc0Sk9ZNW82RnRHN25KQ2p4Z2lNRnhFWlRN?=
 =?utf-8?B?cm5sbFNteDBMKzZnYnVhd1g1RE5Ua2RrMzlCZmRLYzlWaGt5WUg0SlhrSlhF?=
 =?utf-8?B?N09LRS9maEdwSkhLNmpUQUR6UkkzaGI1bUJ5QnM3R0V0dlZjUW5aYTFPaDFv?=
 =?utf-8?B?WGpnWUYxZkQvZGJpaThQUy9zNHBtNzhFS3dIMXpZVGNsYnpKSGZXTjU1MC9I?=
 =?utf-8?B?cnF2SW1Md2tKMUY3TTJobXlTOUZSMTRLQXNHRks4enpEVVU3RnV3cm9rK0dL?=
 =?utf-8?B?RUw4RXNtWWIwUzVaR3RnUjJ6NWZ4cTQvUHJ4N1lKcXdNdEZCVXk2aEZ6cDVP?=
 =?utf-8?B?ZVpiNGcydmsrdk51RVNJNVRTVGg1OUdZb2d3OUcrMkEvQ0MrTDdHZFVIbGhN?=
 =?utf-8?B?NW9yeHlySDZmU3hxMzYreG9NZjh2ZUFnZWVMSVE2S3g2ZU9SMU9OdEdaRXhC?=
 =?utf-8?B?QklzajFXUGZlb25aQWNXaU95SzhGeTdlWTNOUnpqa1NkT0RNZmpYVVZVNEtV?=
 =?utf-8?B?U2sySkFjbEI2cmRhNU5XYjN6cjZ1VUlVMG01ZmpjWHhNUWNabFhBd1FhVEtr?=
 =?utf-8?B?TkNPZjZ2azNSL1h1L0RkV0gxZzdHd05oQVpRMlBGYTZ6MVorVTk1Vi9vRWwv?=
 =?utf-8?B?dlYxWXZMWUJyY2JJTnUvYWdUQ2NNQjRJMEE2cXpDdW9veGZ0Vzlvc3FqODJH?=
 =?utf-8?B?b0xzbUZZMlJCZ1IrWVpKVFUwVzVzM3YzZjN3V3pMbFVob3RFZ2dmSnkzaHYv?=
 =?utf-8?B?ZTZ3bmdPTzZiNWJ1YzliUlNFSVVkZzBBazJpNzhqaTZURWhncUxDb3REUUdJ?=
 =?utf-8?B?NGNLMTV3b2hpQVA1b0hXWHN0NXNBM3FodnV5KzkralIycHoyakZRRHk3UnJz?=
 =?utf-8?B?dTEzbG0wL21pRGZ0eXdrM0RUTzQrQnlHWlpwcDEza0tCN1lKMTNoaWlZWXZC?=
 =?utf-8?B?MnlIUDVPTi9sOFhaTnBFVE05QUMvMzJndDdua2U0M0dOSGRJZlJ5ZzBhejBI?=
 =?utf-8?B?U3hNd2tETzExdG8vWi9BY0lIWXZQeXhKbzJCbU90b0pjYVFseGJlMlRXNVo4?=
 =?utf-8?B?dmQ4ZE51YlM2K1ZuSW9kUElJL1daQW84MGdOcDBCV0tMSExpZHhwWUNZTlpn?=
 =?utf-8?B?cGl5eGVVdXFwYzk5QzE2WTRrRTNDY0dtU1IvOE5tTWlHcEdrMUtzWHFiRWlx?=
 =?utf-8?B?c1BGdld6cTFpS1pFZzd2UGN2eXIvMS9mSDd0RHpNRG1JeGxFVUlObEc2WlJj?=
 =?utf-8?B?RVNwZEtUREZjU3BQaGZDdkQzdmhSUkJRVGJoeENOV0tXWFZhL01KcGduUkVR?=
 =?utf-8?B?bmdrYnBaU0EwNXlkeGFzeVN2anpJRjBJangzbkxiZUFrdGZoKzl5K3BSMCtK?=
 =?utf-8?B?VUdQMUVOWThtZ0g4ZktTYjR6NlN5dmFLeGpTVi9kdkpsRDgzU3RhTWVHR2Qv?=
 =?utf-8?B?bnlueE12Nm5GVHA1ZVFWS0QrUUpuZ0hkWE8vRWRkck13ZUxNMTFoV05Lc3BH?=
 =?utf-8?B?Z2taWkRBb3RBeHRobFBOMjlNTWpoL3RqMGtjU05XMDBtWGloaDB3UVVTMllr?=
 =?utf-8?B?MzhBVnA5REZjK0NSWlk2N2RTTXVlaUEzMTVZZkNpaXg3aGZWRzBGTzB6VVFM?=
 =?utf-8?B?SmFhcXkrcHE5TlcxcnNOQncxRDFNdTBUOXBQQUUyNmEvVXI0SUxQWXh6dWdC?=
 =?utf-8?B?OXp3N0xTam5PWUoyL09TM1JFS3lSS2psQzl5Q285L2tnbkhrR1B1cmdVNlRQ?=
 =?utf-8?B?cG9tUGJ2WjhtTnpHNXozdUswK1FkS1NpcVhyOFZMTWIyMi9HdlBpZVZWZnJq?=
 =?utf-8?B?VWNzK05Kdm9RSXU1bU50MWtKR0JHN2dIMUZuZWhXZlIxVnMyVFlVVGkrWkw0?=
 =?utf-8?B?Qk1FNlN5ZjlZVExkeVpMcjhBTXo5OUhNUk1xNjhqbmg1d1RBelowbUM2WlhE?=
 =?utf-8?B?V29RazZhbzBNeEtEV3RXM3hLSWo3Z3F3bXlnSWFCM0xGcjllK21WK0VWL0py?=
 =?utf-8?B?MTlJcEdJdDdrSDJlcmkwelNkekVIMlBtSnlWbll6TGcvMDZ5czZ6bVVZamU5?=
 =?utf-8?B?ZGVxTjA5QTZDUkp3d0h3MHl4dWpSMTlUZGJDQTVRN3ZOazUzSEM5bW1IT3d3?=
 =?utf-8?B?ZXdnWUlhUWxHMnBIVlFneUpoMGRWOXl2eEQxQWF6UFpjM2VKZC80NmdOK2Vq?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abb581b-d819-44da-9904-08ddc380bd6e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:19:45.9627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1RICUoq4Or0bk1Z3ct3UGfZUZ2Hi9uEMW3a2ppv9pZzMeyULySTrnTHHX0Yw8nL1ROctNjmR1Nx8mjIAD91PkPzjSc0XCnNBo+yCS90Rlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10832
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

Hi Jonas,

On 7/14/25 1:33 AM, Jonas Karlman wrote:
> Remove the cru assigned-clocks override now that SCLK_GPU is supported
> by the clock driver.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

And this seems like we can remove

/delete-property/ assigned-clocks;
/delete-property/ assigned-clock-rates;

from cru and pmucru from arch/arm/dts/px30-u-boot.dtsi?

And... maybe we can eventually make 
arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi include 
arch/arm/dts/px30-u-boot.dtsi to avoid duplication and match what the 
upstream DT does (including rk3326.dtsi which includes px30.dtsi and 
deletes VOPL)?

Cheers,
Quentin
