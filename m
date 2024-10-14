Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E5D1812F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0B088BB2;
	Mon, 14 Oct 2024 18:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NplpZuW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45BA88D75; Mon, 14 Oct 2024 18:47:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E5188A1C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1fi7N0kscUUIg/2uWYtZ6aerVkUOk7pmxxNhAXjAxSlHeqylBz8ohehPiRXU5SlOJ/1nsFrbqKCu9etDl//B9wS6C58LoaqvhB7XLMAi6W5S3+dOTZ8R+3btrFPyGaaRMfP7aN1EkJeBJE3rXbgQByHEccN9NMhdvo2r5k0JQTcXVqcIGhwT/jLbs3VBoyNli+J9sXtX4PzItcNx3X9dX2DdG5YH1UrGNYfRolf5L5vedAaQP6J46jdU1zbgVP+wOikT/WPMVp6SF6xLrFG79DZ+8CnZ3MrZ+MyA0Adl76e5wHszH0fdg2ZA9Nahsk6lU1uJABbIg+MvCinDoxqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVe4TyHovXijpUbxRFKifUL8pAiNQLH3O4NlWa0Ck0g=;
 b=jof2gwazPTSxxQm3MKPQJvrm+eKlG4hIAc5EQ9X3LiRw9vUULM1mXIc82j249+BrzyUOI/MRSKV0ORuoNkdWzNyuKj9KrcZ8cUrpmDehedRnhOOagGDN9gblnRKizMOzzMlK6j2c/ni5RgLjZXVTfBpLrJ3R8QB/f4BM51cJPsWLvRw+Nn7iJ8z80gKz6z+8W7XmXxpPvMPCQjWYseKGSNJ32c2dCKYLS17E5ND2cfRVU7FT8q9N/fL5HQIW8SpYco1ZoYTH7ln/J9Zn9W2UBbFpV5zZdN2acN7qwGL2ccW9eFuMVq0I7V7peRwslWTdEry5DphmPgOkofBOBsLD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVe4TyHovXijpUbxRFKifUL8pAiNQLH3O4NlWa0Ck0g=;
 b=NplpZuW6o+JZzE9Qlr426YaMqCW4bYtjdSgIO3XG6+XW7YHO2NxSClf2A04F8krlLgCgxhUzAjGHFPPN9Yh9MjcsqTao5R+8h1jZXem1KxTT2iFJ/+1hEAPXtASprWdsJnO/W07BbvmKXmlHeCid0Y7OOF8lpIWkqBy7wH2lt/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB11044.eurprd04.prod.outlook.com (2603:10a6:150:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 16:47:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:47:08 +0000
Message-ID: <085c1f48-4469-4549-850b-62e3c9ae1674@cherry.de>
Date: Mon, 14 Oct 2024 18:47:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: Modernise Geekbox config
To: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20241011170602.1979605-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241011170602.1979605-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0185.eurprd09.prod.outlook.com
 (2603:10a6:800:120::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB11044:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec01026-c713-4ebe-7992-08dcec6fd7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFJobXpGd2plaTk3MENmKzcwbHU2YXRYV2tkTmprdlpoVVZucjNUdVhDWFVI?=
 =?utf-8?B?cDQyZSthc2RTdVo0cnVaVXFXMkFSRXFPYjB3cWlibEJRbXZYRTlWS0RIM1FI?=
 =?utf-8?B?ZUtlK2h2SUtwNTNDMHNpVVRSZnJOalMveTFkS2Q2SFVDOUJZWWVjdmhyMEk2?=
 =?utf-8?B?ZkJqaFRYWmsveTNnczFabjEzTnRqbUFFOTZxeGdKaUNDN1QvemhsQVpRZHRk?=
 =?utf-8?B?aVR3UE50RmhNNGtjWmxZcDJEMllvaFVmdDhCbDk0aTBnZXdoazE2WnNtSDBz?=
 =?utf-8?B?ZTFvR0RmKzZ6SEVCcm10UnZzTjBEdGlUL0dMTjAxaWkyc0RnVHhqa2o1UzJa?=
 =?utf-8?B?TzM3cGlsbi85TmltMThzWCtuMnoxN0Z2V05yOWJxeDE1bnpqZUVuc1hFcWJi?=
 =?utf-8?B?N0FHbGVLUEJIaUQxNGlMQ0RUVHRtbUxoK3ErQ2dRajVqQTg4ekxvcy9sTjhq?=
 =?utf-8?B?ek4xTWk1eFY5MWZQVHFCS2RUSWNzckROWENoY2lBS0NzOVUwUjJrQTBDZVpM?=
 =?utf-8?B?cjRzczdpdzRKbFViUmljeTBrQkh1N3NiMi9qMXdteEhTa3hCck00cDdqcDda?=
 =?utf-8?B?NnhjZVVhRkcrSHJrWDIwYTZrbjF1WDd6ejBzTXhhQnFST2RhQUNSaDBBc3lu?=
 =?utf-8?B?T1l6ZE1uWE9ja1F3SmVNTVFVRGMzU0lTeUM1dDFMb1N6aEhKM3hORm9XNDE3?=
 =?utf-8?B?WkRKTncvZHMxSTNJQXc0dGh4bjFoOGc3NlZSdnU2bFozMTFEZC81aXE5ZXlo?=
 =?utf-8?B?MCs0N1ZBMmdsanhQalZ2K2dWbGpEZTkzVE9zeHBPVDNHdXFEYU52ZFBiMmFa?=
 =?utf-8?B?SzQwUVU5dHpxVTA3dlliaWpYMjlmYTJ0ZnQvK1lFSkFLODIvUUVnaVRFQnYy?=
 =?utf-8?B?RlRqbzVjWWx3L0ptLy9FdTh4QkQ2NHpZcTJmTDFuSG5MVmU0aFBoSFA4NXE4?=
 =?utf-8?B?R1pScUlaci9od0tQN0Yzbmt4RGJSc21oZmpUbzNQRXl1Z09WOFJuWmczRktU?=
 =?utf-8?B?dUhUT2ZpZUw0aUl5QkVHenRSbXBmeEY4dkZicDZaZHZtSGk5bk9GelpzUlUy?=
 =?utf-8?B?WmQ4ZFZWZjErMUxaR2hwcEp3aVBkMjk2bGJYUXR0UU41SlJJNTJQUjBsZ3dG?=
 =?utf-8?B?T1RhUUVjYmhTQ2plUHVzSjN3RExYWkV0OGprQjZJVXh5N05PSlE5UGF6R016?=
 =?utf-8?B?SkRzeDQ2Wmt6c0E1M3dCQlkyQytBQkZIVER3ZlNYSXlvcFpJRFVDdzB1cS91?=
 =?utf-8?B?TW45clFBWjlrb243S1Q5MlgyeVltSTY4OW1yVms3dGYvVWxoUSt0cWlnK05I?=
 =?utf-8?B?RmNnNHBpWmtEc1I3d2dBVUFQUFdYM3N6bGluQlFKdmphR01RZERWdU80VU1Z?=
 =?utf-8?B?VE5FMlY4RGVzWEloSEpqSkJ4cVo3VWRuMlZvb1lwVDJXNW9uTlJ3T09WQlcw?=
 =?utf-8?B?U0o3ZzUzbnlKVE5zamx6aTE3c1U2T0hpUUV0RWZRTkdQTGVETkFCYzB2MHIx?=
 =?utf-8?B?STZaaHluR04xQU15ZHZiWTF0MWRyUFNwNTQ4SDdEbUl2dzBIa0llZHJxc3hk?=
 =?utf-8?B?NjVpL0pOU0gwUWdMM3BvbmxSTFpTOWlrVVZ6MUpKN2lJVU12MldRRG1PbUxQ?=
 =?utf-8?B?N2QyZXBTWnVqdVpmVFZNZDRiejFzMVdOYW9tT1I0b0hKcjFMdlNWZGlBaEhY?=
 =?utf-8?B?RVRLUktRQVVsWW5JMEFkWnpzZk8rZ3JiLzJCaDI1RllMelRRZzBLcjR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V056dHFYOXdPV0FHWmVocW9pQmRGN081NmMvVm1ZalVlSVNXUS9Fa0UrNzdT?=
 =?utf-8?B?OW5OU2o2ZkgzbTlncWdVVSsyWGRmd1dGekxEL2czazFkbXVjenpXNkgzaVND?=
 =?utf-8?B?RWxHdTJFeTkxRHlBWG1UeUNET3B6MFR3eGlJRFpXcnBiRm5DOGZhTzN6ZGV4?=
 =?utf-8?B?cTNlOXlBQTdzSFVxQXc2emRQNXJwMXVrVmlnM2lXN1N3eVc3SjROODh6MVJl?=
 =?utf-8?B?TTJicEdyZTcyOGZWazROL2dDbDJualVBUzl6WFFmVG9wYllmVHpCN2dIOFNS?=
 =?utf-8?B?eWh3Y0xzUUNadFIvOXJiWWJOcnI0cVZOZmJrbkkzVWgxZW1VMmJ1NDZWUzU5?=
 =?utf-8?B?RWtKaGZtZk5iSDJxdlRZeXVYRTB4VzFnaWZhYk1EMzg5R29FRGVyeUE1bEg5?=
 =?utf-8?B?eXJ4R2REN0hELzZpMFBzdFUzTGpKckdCRW8wSHF3YU5zTGoxeTl3THg3cmQx?=
 =?utf-8?B?YzRBckttbTZERDBUbC92cXYvclZFZ1FGZGJRWC9yMVNyanFTdXV2SXZZTC9E?=
 =?utf-8?B?dDF5cmhqM0JNcERoN01FMER5S1VYbFVFdmpCMSs1Z00xZy9PZ1hsSFoyTHps?=
 =?utf-8?B?ZnRlVWRZM3RDTkxQYnp0bmJ6elZxSDZXdDlEQVhrUi9rUnZ3azNGMENPTkxp?=
 =?utf-8?B?K2FTUXpvRUJ5Znl0d2MrVnluSjU0LzRJM0xrakdDZURMNHdoMERIU1ZTQ2pz?=
 =?utf-8?B?ZHBEdVZQZHdUSjhUZDU0bmNLSGNDWHdBazUwQUNIZTc5V0NzSW1xU3VJTXlR?=
 =?utf-8?B?U042L1FQY0sra2ZWb1pwQ1hETzhCTVlSR2t6Q1dIS2RIU0dFZ3lPZlZmK0py?=
 =?utf-8?B?c2twZVhkSTVmZER3aEpla2xPY2JFQkJMMGlVWDBnY2ROWEFzS2hOeTl2OVNq?=
 =?utf-8?B?dXB1M0pYM0JFWFRLWmZ4ZE4vYXRCNmlLUTdMczdLSnhtenl2cndVZllhM1JU?=
 =?utf-8?B?cDFGRjl3TGc5N3ZiMlNsdHBNazhVOHJoS3N6cGtHL2l3U3Z0cFFTWDFqZHRQ?=
 =?utf-8?B?VUVObmpNaHlyVWR2citjQUdLRmVIQjFBbGlibEcxNUFFUVpZTjZvTHVFRTVV?=
 =?utf-8?B?eDVsRG5ldFR0Z2JFU0FJbXdhd1IxVlVzeEZIWFRUSGh4K29iWUtWNjF1eHV3?=
 =?utf-8?B?TzRXc1ZhL3cxVTNOZHJrUmZNclZLWVpHUVo4UGx4NnZOTWxGLzJlZ1RMTjRC?=
 =?utf-8?B?TUswVkpMMnZvUVdtTG5xMmtGelg4aFlmVkFSby9TOXdwaHNIL3RQWHpLcGFa?=
 =?utf-8?B?VWNseHJNcGEzK2tlMDlvbW1EZVNXaVBpbzBINmxxMy9RVkNLOG1LT2hBZS93?=
 =?utf-8?B?RzdqWFg4SmJGTGEyNkJqeiswTGRVY1N3UlVnR05KekxJVjVRM3pQSzJqTUVY?=
 =?utf-8?B?R3c2QXVOa1NQQUZtZHZFQkFHUTllZHpPZi9JM1p2Q1pvc1FWTk9uQUIrQjBU?=
 =?utf-8?B?YUQ4NDJOY0JhdXNCTGJGbG1vSVA0L0djeHg3SHhtcFQ3aGw5b1JQelhvSEZv?=
 =?utf-8?B?bHpUWStmWi80T05IUzZteWhwM1RXdTg0UXVaVVViWG5SYklNZDhtaStCVUpp?=
 =?utf-8?B?WGxTRkIyWXJZbnMwNG5CWVBlWEpxQldVQnVaeTRyTFgvdTRla1BoMWRTM0Yz?=
 =?utf-8?B?QzdQYjRxVHptdEsxTzdpdjdHV1prUHdIeWlHY2ZReHo3OWF0Y1JWNWdoOU13?=
 =?utf-8?B?dXBaRHV1dlRxdnc1K1BuTkU5azcrSjVVTmNSc0FnVXZrZ25rVjFwbDNpQ01l?=
 =?utf-8?B?TkZ2SzlRWmpxdEp5YldqamFDcmpGU0U3bVN2WWlmRW5SWUc1cjJ5cFQvSnQz?=
 =?utf-8?B?NWhBMVBJU09oVzV4dFo0NXFIcE83d2o5TEk2c0pkUW5xYnBnbjBNSHpIVUE2?=
 =?utf-8?B?QWppQ00vNEZObFREckZwVkRQcjlWV1MzNGYxMDhlZ01pRmMwM2tGZGdvMi9j?=
 =?utf-8?B?VEhSbHhLRHJWV0R3YXF6dURQd2pKNnhzU2dMV1BTazlWR0lFV3JtM1ZHNFJN?=
 =?utf-8?B?MEN3citPZEFBRzd2R0FWUDRzRmIwZGpHUEoyeTZ5UFc5SWdZRU13S2JwRUtx?=
 =?utf-8?B?NDdOb1cxR0NybzhOTEFteDZNbHpqRkdPSlp1N1o2OUMwMVR2aCt6S1NEZ2U2?=
 =?utf-8?B?V2RqK1V0dkFVUkJqdXYxOXRoOGptUXNnemQ5dDdGMU5qdTdYMHAyMmdKR25U?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec01026-c713-4ebe-7992-08dcec6fd7ae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:47:08.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eiEw/XAxGFj/sO2Xzs2hYN2Jg/cKB6zkBCvUh92/uQksAg8qwwzn17cq6fyPoSnN4B3/pssG994+i2ZySQfYndmD6MEzLe1q8dIAOdO4wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11044
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

On 10/11/24 7:05 PM, Peter Robinson wrote:
> Modernise and move the Geekbox config to use SPL/TPL with
> upstream TF-A, enable MMC/USB/Eth to make the device more
> useful and work like other Rockchip devices. Update the
> readme to reflect the changes to the build process.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> 
> I've not moved this to upstream DT as yet because there's some
> further issues I need to debug but this moves this platform
> forward.
> 
>   arch/arm/dts/rk3368-geekbox-u-boot.dtsi | 10 ++++
>   board/geekbuying/geekbox/README         | 40 +++++++++++++-
>   configs/geekbox_defconfig               | 71 ++++++++++++++++++++++++-
>   3 files changed, 118 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3368-geekbox-u-boot.dtsi b/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
> index cfc8b9340a8..55d007f7ab8 100644
> --- a/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
> +++ b/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
> @@ -26,6 +26,16 @@
>   	bootph-all;
>   };
>   
> +&dmc {
> +	bootph-all;
> +
> +	rockchip,memory-schedule = <DMC_MSCH_CBDR>;
> +	rockchip,ddr-frequency = <800000000>;
> +	rockchip,ddr-speed-bin = <DDR3_1600K>;
> +
> +	status = "okay";
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/board/geekbuying/geekbox/README b/board/geekbuying/geekbox/README
> index de980f2f233..bd4d8cdd084 100644
> --- a/board/geekbuying/geekbox/README
> +++ b/board/geekbuying/geekbox/README
> @@ -1 +1,39 @@
> -see board/rockchip/sheep_rk3368/README
> +Here is the step-by-step to boot to U-Boot on the Geekbox
> +
> +Get the Source and build ATF
> +============================
> +
> +  > git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
> +  > cd arm-trusted-firmware
> +  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3368 bl31
> +
> +Configure U-Boot
> +================
> +
> +  > cd ../u-boot
> +  > export BL31=../arm-trusted-firmware/build/rk3368/release/bl31.bin
> +  > make geekbox_defconfig
> +
> +Build the full U-Boot/ATF firmware stack
> +========================================
> +
> +  > make CROSS_COMPILE=aarch64-unknown-elf-
> +
> +Flash the image
> +===============
> +
> +Copy the SPL to offset 32k and the FIT image containing the payloads
> +(U-Boot proper, ATF, devicetree) to offset 256k card.
> +

Missing a word here at the end of the sentence I believe?

> +eMMC
> +----
> +
> +rkdeveloptool allows to flash the on-board eMMC via the USB OTG interface with
> +help of the Rockchip loader binary.
> +
> +  > git clone https://github.com/rockchip-linux/rkdeveloptool
> +  > cd rkdeveloptool
> +  > autoreconf -i && && ./configure && make
> +  > git clone https://github.com/rockchip-linux/rkbin.git
> +  > ./rkdeveloptool db rkbin/rk33/rk3368_loader_v2.00.256.bin
> +  > ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
> diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
> index 8f4be79831a..1b116fa8602 100644
> --- a/configs/geekbox_defconfig
> +++ b/configs/geekbox_defconfig
> @@ -3,29 +3,96 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x00200000
> -CONFIG_SYS_MALLOC_F_LEN=0x1000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3368-geekbox"
> +CONFIG_SPL_TEXT_BASE=0x00000000
>   CONFIG_ROCKCHIP_RK3368=y
> +CONFIG_TPL_LIBCOMMON_SUPPORT=y
> +CONFIG_TPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK=0x188000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x400000
> +CONFIG_SPL_BSS_MAX_SIZE=0x20000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
> +CONFIG_SPL=y
>   CONFIG_TARGET_GEEKBOX=y
>   CONFIG_DEBUG_UART_BASE=0xFF690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_LOAD_FIT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-geekbox.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_BOOTROM_SUPPORT=y
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
> +CONFIG_SPL_ATF=y
> +CONFIG_TPL=y
> +CONFIG_TPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_TPL_DRIVERS_MISC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_USB=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"

Mmmm... really removing pinctrl in SPL? Not sure this is wise? We 
usually remove clocks and interrupts specific nodes?

> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_TPL_DM=y
>   CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_TPL_REGMAP=y
>   CONFIG_SYSCON=y
> -CONFIG_BOUNCE_BUFFER=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_TPL_SYSCON=y
>   CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_TPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_PINCTRL=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_RGMII=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
>   CONFIG_RAM=y
> +CONFIG_SPL_RAM=y

Not sure we need SPL_RAM if we have TPL_RAM?

BTW, if you're using upstream TF-A, you can also disable 
CONFIG_SPL_ATF_NO_PLATFORM_PARAM and let U-Boot pass the serial console 
to TF-A instead of relying on build time setting in TF-A :) (I've done 
this for RK3399 Puma already).

Cheers,
Quentin
