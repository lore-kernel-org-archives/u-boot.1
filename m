Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64EE69E88
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 10:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC738964B;
	Tue,  3 Dec 2024 11:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SB/zWHqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422A38964A; Tue,  3 Dec 2024 11:17:53 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABF589650
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 11:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOcfyIfaew8b0Nc+OG6YYMAWOLkkcjV7c/JhxI/p4wT35YzQd5Y3hxdqsuuAoI6Gzqsut5Hw/Ul+a9gGVBVIYLUsIbscS67RhBHY3qvoDPRVhN/6kEDTMhAUaH2WFLXWe5b3ZdVm58Ko3kBqqS06ro9V4A90MSA3S3v51/rJ378GrwaeXcRaHmjR0iFyMrpFwm7vLN0yYp8a2huJYPkkG9tzEj2jjtsvqfY+bpMWdpzJb37NHPXbBIrn7/h0j2jyYrpzC5h02sKw7DJ4/vKTFtQLgd3XBJ4j0krCPSWrRXN/s8KFoqfcbCFxu4J3faH+iSEhsP3K0/zBodhTw3nv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40oVyX3E9JQuPlkHZHa35OcJMZExk5u2IkNxhEQAn6Q=;
 b=f12lUM6vqUwNq5qcB4m8M26dsG4M6acaAP8NPFapeDfvmPuV3pwxFdfhtSPfy9pWjTqXl7FvVDFtmKoySfPxJdsEYNrK81AP+anmiIwMfI1b3wcSGpGJu5FVved0UPsvtgCdujTeMCydNZs3/XIhzWjaHbMY+vsjRZ/NlQZoyqAbiIEOz1CjSLCUMrUpXuLGhbz1cSvb69tBgNgqrV54Tt5JBILhXwnlqUbQxBAACgllRXN+alOQ5gM6eP/T5MU6iNVGZOPL7z+mp8tz/XWy7Gx0FsSC3/ledXwUR4hOGgJANVR3fSf5rC1rgLO76rHcrYQljcLAa3MNKJVxbLWWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40oVyX3E9JQuPlkHZHa35OcJMZExk5u2IkNxhEQAn6Q=;
 b=SB/zWHqd4aw2mRLGyXDr+3AncWXJGnbFlUxuucwWtQvoP3d83hhViNyxt5BhsmOKIc0sEew3PAYeMmfU8K1KgMwzpw9MosKAk0guHrf9fgJivaz1dW5j0HUZXQnIUftl7ceA21pil1bS9fLYX5/vLxcTtknIiEFPsMsxtoE5oxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10612.eurprd04.prod.outlook.com (2603:10a6:150:225::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 10:17:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:17:49 +0000
Message-ID: <20df012d-5917-4e5d-8920-cff7b92c86f0@cherry.de>
Date: Tue, 3 Dec 2024 11:17:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] power: regulator: replace dev_dbg() by dev_err()
 in regulator_post_bind()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241203100611.354468-1-patrice.chotard@foss.st.com>
 <20241203100611.354468-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241203100611.354468-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10612:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8ee352-acc4-44e8-77ea-08dd1383bd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEZMTHZidk9IZC9QaHBCamJOeFd0SlFyLzlkNHNHSHd0QnJvZ0s5STFrZzlC?=
 =?utf-8?B?NEdQTGtuU2NCMWNBRFlmcGhMeDlRWmVZRWdCWHpyYUU0VHZBT3hvN0NYdG9T?=
 =?utf-8?B?UDFGMVU0bEs3Y3hsbEpGVkRBMDFVR0w3dktlMW1OOWVKbngwUlZURXdxOHlS?=
 =?utf-8?B?ck81dUgxK201TWVRZUdGK3V5VDNvSmQ2QmRJeEtHVGZwVGdVcGk1RnVPS25r?=
 =?utf-8?B?MlMrbDEwMjFTcHVVaHkvNHg1cDZQQ0l3THdXaTJIcnZyQnhiZjlxcTczM3U1?=
 =?utf-8?B?Q2RtZGtzekhFb0l4ci96dzYzRTQ4ZnE3TzNWeWJrYzlwV2RKWkk2d1h0SEpl?=
 =?utf-8?B?ZXArWTdBa1doVjdEWmRLcHVBaWN6VEp5QzdMTStCbUR0bWJ2Z2h0OXRlZnVi?=
 =?utf-8?B?cXRCazRmd3JYSEhLaGQ1eGdIZ3V5MUQ0TVY3ZHNjTFFlKzBmWlo2SDdFQWNv?=
 =?utf-8?B?ZUpZaEpBRDAvcDZRaUJqSjBZU1N4OXBsVnJ0a1ZjOVVDM1dhSDk4S3lLSFNO?=
 =?utf-8?B?YVp4NDQ4RGtwY2JWTDM4R0grYmpsQkhYUkpwL0ZuQUw4VU1aNm9vSTZaeGpV?=
 =?utf-8?B?T3BZUk5hdFZzd09SZzNmVWQ4WUo3eFNWK2VObzdQbWpuSnIzNjBqc3pjV0k5?=
 =?utf-8?B?OW45WDluemQxbm13cHY5elI1c1liaFJVSHpNcmRBNGowT2dkOVBKZEVqbWtH?=
 =?utf-8?B?WFdCVzd1S0ZyZG1PWEU5Zm9lSjZTZzN3UVlmUURhRDE0dkxyZ0hlcUw5bW9B?=
 =?utf-8?B?VUNIZGtoWVVDTUVVdTA3RGRDNnZBaExDdXU5Y0VYMWd3emZiMndpVDFuYWlz?=
 =?utf-8?B?Ym5wNmgvK1dQZGpLZG52dVdwbW1RamZUaUdONUZBa25WWVVGbVc0YUZ0STNr?=
 =?utf-8?B?cG11UG00TUVuenpDeUdmMnZDS290K0YzeDhrZkdoVHZpL2g0K2lRV0RlYVpS?=
 =?utf-8?B?YS9PaHRaek1NMm8yUmY5TENETEc5T1lVNWtweEdITDlBK1ZuaTBMaElEcnVk?=
 =?utf-8?B?VStGeHI4TVMySDFGZzEwZUMrT0M0akZSeGNOdjdvcEw5WHBIQXNxVzJ3ZjZZ?=
 =?utf-8?B?bFBuM0M2SGhsbXFWeWoyQnVrdE1LZm9TdDQyRGdzcVdHOE1pWWNZSTJFVjNn?=
 =?utf-8?B?N2E2eHlBL3RxL0FsRnZzQkNlbDgwL0ZXK2RjdGw0R0tJQWptYmpPM0NXdmxW?=
 =?utf-8?B?bEtkQTJBNlBSNVh5eGZ6cWNrTlM2OEg4aXJ4RThhZUEraDltTnR0R3JRdDda?=
 =?utf-8?B?aWZDa3BkL0I0SVBTYzFBa1J3dE9YOU52QjRaTGl6K1NwbW01S3ZnQmZKcWtS?=
 =?utf-8?B?ZHU3VXZ0c25kWE1uRDhHRVlOdS9ob1J3THlHcUt1aVdJOFR5MlVTVDN6MmF1?=
 =?utf-8?B?VjdKL24wVEpsZyszTW50UTNVU3hFR2lTUUJxMC9HSHVXVzFUWDQvQW9Ia2ND?=
 =?utf-8?B?b0hJYjExa3VVdnpxRlc1NU9KSis2ck4vanFuTjlKSHNxdDFDbm8ybWRqQ2Rm?=
 =?utf-8?B?VEpESFVrUGk2V2tPdzRCMTI5NEZSc2ZtZFJiZkxBUjlmbklyQnV3LzhQNzdC?=
 =?utf-8?B?TUZlMjlhRnpabW5sWmxEN0x4OFdDNkczVE91THl6NzF3Zk0yV2w1OGJ0R29a?=
 =?utf-8?B?aE9LbzlPcmlwOXNWSWZIZUJGSUpZS2dUam9YWmxXR3ZXU2pTZ1N1UGxCaDRD?=
 =?utf-8?B?eUdQTzBHV0pxUTFMNll0NXpBVFFEVjdsa3VKMUhmc05FT3hpeDF3ZXVpYnlz?=
 =?utf-8?B?ckxCd2NqcS93Y3NzOHNOK3czeEFiNnpRS2R1c1JDY0NDSHg3akkvRXRBNVli?=
 =?utf-8?B?WkpkckFtcnBtVWl6b2NTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxEaXdsRVZENmJ5NVhhUnFTWGE3NW40UEdpVzAxeU5yVjJsSXJraVRUQ1Rs?=
 =?utf-8?B?Y09POTZ6S1JIRGpKL3FtOTZYVnkyQnc5VHNybHdoSCtPdFhTR1F1S3gxWGc5?=
 =?utf-8?B?UVJTclZPTWRFQjdJcG5MWWJUYkdOY0d1U3ZUWDZpbC9SVlVHa0MwNDFUK2h1?=
 =?utf-8?B?KzJWQUt2b2pWV2tUcC90MG5aSmJDRlYxd1VSanV4KzllTzdseGpYa05GR1da?=
 =?utf-8?B?UFFUWGYxTXdRcFBIT3N0ZC9icDh2SFM4RzFneTUwL293RVYyRStCUzQ1QVUv?=
 =?utf-8?B?SmJJUzl3OXA1TE9tYk80Rmp4R2ljOS9FNGdaV0JTdjM1N0lsaVg0ellmbytL?=
 =?utf-8?B?cVBmY2F0cG9SamNoQ1JkYUZuSUVWNHUyTlEwVmhmRjR0Y0lGeDhFSlFnaTZp?=
 =?utf-8?B?UjJvRk9xcUwyWVZ4bFJGeVppaDVJd3B6S1FER2NuRzNwU0JZSEpPU0pyVlhn?=
 =?utf-8?B?MGMyWWV0Rm92TUlZTmx2SkJLZ1JjWTlSYTBNTG8yK1BiZ01YenEzME1BRGg5?=
 =?utf-8?B?RUk3M0c0eThRT2ZETUlud2tFMVhhdDI5L2VzZVFRQTcwb0psbk9VemhyamRF?=
 =?utf-8?B?WFFKdERxR3IxQldSOERrajhEaG00NlA2NHZWcWlZeHJRenl2WG1MZTE1TVBK?=
 =?utf-8?B?S1ZyRm1BRmJNZTdUbG1JWGJocDhCTUdGUEVqMnVIMzFnYUpJTWg4aEQ0bU95?=
 =?utf-8?B?N1k4ZlpEdW9xV2dwSy8waldqVnFqQjJndDY1amllWXorY3RzUXMvRWhudy83?=
 =?utf-8?B?NGJrZFJKNnliNzdmQVFFM3RQOWhIa1hvMDZsN0lpUWtFdDdHTEZmVkhXRHRO?=
 =?utf-8?B?UFVRUzNyeCtFcVc1MlJDeXI1QlZsWXpzazlGbUFnNjhjNjU3NGowdTRERm9u?=
 =?utf-8?B?anZYVVkrRW5qTkdTdVZkNXBKaG00ay83Qk9RT3RtNzBPMjhoK2hFWnBGSCtk?=
 =?utf-8?B?WkNPK3dacEt0RXNZR25BdFhFNmtkcEJYTlhvaGc5dkhRdnQ3TGtheGNPU1Bw?=
 =?utf-8?B?N3BFb3g5UWFJTkNWUTZVZUVDQkQwM0hDZzFyc2JVSm9XdElrU0Y4cmRnc2dE?=
 =?utf-8?B?aGhlMFV2ZWdURTBpSTdrYXhrRWt0TzZ0OTF6ZzRxdHcyMnVlVmt4R0NSUk9D?=
 =?utf-8?B?U00xeTRXOW1rdkpaN09QanRxVVlUT1BlMUlmRTdNODZKam5EQ3RjKzBSWmRI?=
 =?utf-8?B?MVcvai9kbmg4R1EyT0FFMUNqUDZwdzZQUTkzNUI2UGU5NXJaOGdyZVVPanpT?=
 =?utf-8?B?amFJaFcwVi9pVStlUDJsc3h4MS94b2VGdWlzQVBJZEgxbS92dFJaMURnSks0?=
 =?utf-8?B?bExCYUt3SlFzWktUOC9QWlNibDQ4MFpWQUpOdDVaL0JjWGlTNjRpNVdHdGpi?=
 =?utf-8?B?b2w2QXh3SWJXc1FKd1BCL04zcGFROEdYNEdCZ3djMGlKckpWRXlqZDM5UTJM?=
 =?utf-8?B?S2JxTnI4Qm5Na2ZhREMzclNGcUZYdmtEYy9uRTUzNURWUUlxT1N6c05nNVNG?=
 =?utf-8?B?N2NWVWZXM2Y3NEhTVHRCTjZpYkN2bjRQWmJXeWQ3VW5ib2pRQzlueExWWDBp?=
 =?utf-8?B?MXpSK0JQelVTcEhtVnEvN0hDK3VJZ0lMR1NnZGhXME0wWDJnV1NFSGJRNlJy?=
 =?utf-8?B?bUEyUlgzTlU0YlF1VHZZUnZWeGhCWU02Yjh5SVUzOGZ3b0VmTUpwanBaeWgx?=
 =?utf-8?B?UXVEN3prREtIZVdrTmxEWEt4Ty9ZU3VoZmRwc0hIS0NKdVE4NTZzOVdOMThi?=
 =?utf-8?B?Y2s3WTVjOTFlSkV3Sjhxb3RzUFV0azB3ZG05YjhPU3pGekRyN1I3RVl6UTc3?=
 =?utf-8?B?K1FiclFrUndka1dJdXRhUkUya1FLYVdSZTRwTE45c0t4RStiOWg3ellUNzdi?=
 =?utf-8?B?em5ITjBFVXZ6bTZnOWxRY1dvNnhGRk5BWVhna0tQMVBmQzNwWSt0NkhsWHFC?=
 =?utf-8?B?ei80RWdGaUJhZjVPK3dUdkFybUF3YTlHR0c5dlhVdklpbGZaSXlUL05mVDNY?=
 =?utf-8?B?K2dOaFlEeHBwZTlUM0NJU2hiUEJ2ZExTQVNUcTJTcjZGOStsaXdKY1ZtMTgy?=
 =?utf-8?B?dU96MW9xMHY4c3F1Ym54R2ZXS1d5UmxmNDJNWTlVZExMaDduQ3F1d2RkYnFL?=
 =?utf-8?B?UVhmZXJ0YmtpRnRUWTZGYVF6dlJHdXVXcE9UNk02OXkwWHU1OTErK1dpM0tH?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8ee352-acc4-44e8-77ea-08dd1383bd38
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:17:49.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZPWVUDRnG28zRqZbHQD3fpcCtys3KiVAwW5OnUmE7osoGFF2t+cBrn8nTXzrgOcPvLi33IeXWMX9JaaV9O5/qToNcCOfWq5nitxA8Nhzyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10612
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

Hi Patrice,

On 12/3/24 11:06 AM, Patrice Chotard wrote:
> To ease debugging, use dev_err() instead of dev_dbg() for
> alerting when regulator has nonunique value.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
