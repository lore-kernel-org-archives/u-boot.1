Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651F4CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA31887DC7;
	Mon,  2 Sep 2024 15:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="la7XWtnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6A588A3C; Mon,  2 Sep 2024 15:09:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1078987873
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLaFC/UKB98nCPlN3fSg/q8P9V0Kw4QE/90ynijPI7t7adJV0Bc5usgIPa3Cj5Ba1DGdiUGzCrcHOy9386O8OrqVT0ztV8pJN+shd60tdZm7RstJrFrBghN0edEnjThfwxGhhTzg70e37n3P8t/e4ltCx6Iu98hWxeEYF0xOWbKaVoDrvpMs6sdHDpBGfE3YsHalpnDPZ4jD5q9KoxCTbI0jl6pdchm5VeYxAguxHq2FLe7ruTUF2OgeDsUDOdZoqhp/Qm7/z0SLdHO5+OtQzYkpENjkyk4nfoNrNgc3gOLI7ZU4973yQoH/4vfISRswGT5xX7dWPHmcgXOQNQp5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/JODarbaBf9PdqtCPzsilWnsABxfq3NLyQPYFOguTY=;
 b=VkYIb3VFmHzst2g2uji/n8xtwacinFHRsH4IfbUE4eVJxAJGqSlLFgfrUhi4qjO/XN9RfpedQLzigqjECo8+MEUoNjDiLLPYlnkm7T4DTRZWCL5hDbH62uD+IdCWrZp1Zt9cBOpQtbcr0JqWfFQrms4y72mKZjTV81PU5XK+qxuk3CeaNJaxKHgngjkzykHN9EsZBlFyKk8bR63oduymcnZaTPCuAiz92q7fbftIAaYVmErqQ7xzKBM1V4zUMnEnwN7cQRjGGf+SG/xwQR9vBPcnO+VDQ7uMBgoEXn34q4RUObBY4P2aNYlM809dkCuk9/JRP2SLThCWYmLUSc8gJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/JODarbaBf9PdqtCPzsilWnsABxfq3NLyQPYFOguTY=;
 b=la7XWtnCMtZNpVJTcJd/FFtbHUAOpf2Tyk9/CQB4lb4GgNwOw1Zv0fRlO70OUYgwJChUHMqSohQ3gnD2gxzK0HB3BD1iJJWglU0CD3nCSX5BFmMm3VWxdHECrU+OAKFGk8rwpUVVBUnnRyfoxao1hE5wPP305hoPWC6dwA2AQQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 13:09:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:09:06 +0000
Message-ID: <ccdf5291-604b-48bb-9e3d-8f3214483237@cherry.de>
Date: Mon, 2 Sep 2024 15:09:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: guard call to tftp_start() with #if
 defined(CONFIG_CMD_TFTPBOOT)
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240902125917.119941-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240902125917.119941-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: db1036f5-7e5e-465a-0bdd-08dccb506ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty94VjUxZjlacVE0bzZQMWM4N0wvWXoremE0ZTRCRkhlckkwcStUNFlZTlhF?=
 =?utf-8?B?aldlenJIQWIrTm91ZjRYQUp5RzlFNFhvcEVWeEJNYjdvMHVrWURuZ3MyaUx1?=
 =?utf-8?B?aDFOWFh1UnNJRHBEcjl2VEJCamVuaG1LOUY2am5mWXpjN2JiQmhJMWFmOXZF?=
 =?utf-8?B?d2pCSk1OTDdRbWk3bkVvdHY5UlZsOU42cmhTMllYMkRFcjBubGEwN3NpMkJE?=
 =?utf-8?B?K3NHOFZuUEVya3JXS01SRW4yK1RMVThQUFBrT0JNNFNBNUhHRXRxYTQwVysz?=
 =?utf-8?B?RUhrNHAvNVhTN09IMVpiQm1wenJWR1RzM29XOWczUHBqWFBZajVpKzFkK0JD?=
 =?utf-8?B?U2xjMlpZM0hnSTF4SnZZWDYzZ1BQSzMvOVc2Q2I3SENxNWU3VkJ2RjNHWXgx?=
 =?utf-8?B?elpYS1dFbUZ5eDg1WGgxdTRCWEpUNzg0OTcxRUNCNzM4ZklncG1ZenlUOHJt?=
 =?utf-8?B?NEJCZzc4WlA0VzIvOTZWOTVQNDY5ODM1cW5COGZncHNsTVNCWXYzcFFTRUU3?=
 =?utf-8?B?YW1FTHJiZDNjOS9yZFFEUjlzTTF0YkYwcDJCRitnMG13YjlLdFFTaFVZZWJt?=
 =?utf-8?B?SmtyZFd0alBrZzdiVVgwUHdSZ2Q2SjAzQ1hjQjF5UFg2bWxnalo2ZlZiUDhn?=
 =?utf-8?B?UU9YbWo0a1pmVHB4dGVCVXR0TXRhSHhjMUZWQy9HS3Y4amJxVHptVVZ4b2sy?=
 =?utf-8?B?Y01ndStBR3Y1WFFiSUFqVHlVbEdVMTBtK3JjOUY1d2NoaGNVdkM3dnlFcnhL?=
 =?utf-8?B?SXdzWmw3YTNtamtSWVdLQVZ3UUR4UFFkYzdDZHliK2ZBWGxORDE0Tld0RThh?=
 =?utf-8?B?WURlQlpwWXhkT1pzVzhENnV6ZnJmaXd0aDdNTU95Y1dlQWoxenRaR3hCTjdO?=
 =?utf-8?B?dkQ4aVU4TTdsMExETVhhRkZja3U5WmdJeDN3dkljRW5GOW53THgzQXNNL0pP?=
 =?utf-8?B?c1NhNEdFSU1FaEJ1TVhkbVR1UWphT1VWajU2YUdCWHFzUFp5dzE4U2h2cDFP?=
 =?utf-8?B?M2xEek5DVjJHT3puRHlnOU8wSk9Ob01wdXloL1ZTSVpDaWw1VmNJbzhnZUg2?=
 =?utf-8?B?WGFmQWJWS0IxQy82aTluMzhCSjZvNlBZdEpiZWF0WVFGVmJhdkRqZWhRZ0ZH?=
 =?utf-8?B?WEZvVjZaejd4OWJOU3RxaFZLZjc3Z1Rrc3pPbC9iemdMRmRzczJBYlVUTkM2?=
 =?utf-8?B?bllZU3kvR0RmSU81WEVPeFFPMmp4azgvM3gzRnlpWFZDVUN4SWlmS0lhVzZQ?=
 =?utf-8?B?WVhjTkN3UHYwMFBvK21rZW1hUldGUkhyaUJyK1BsVWZEN0ZVSWxGVzRXZ1RE?=
 =?utf-8?B?aS94Y0NaT1k1Rnp4ZTArMVIzN1FvRE50VlN5Vjl2dGpCaVIzSHNVY3pzdmhN?=
 =?utf-8?B?b1VVaEV3TkRraHV1M2xEK0hzbStuMnRjY0NxQUdyaHNHOXFPazNtRlYyakxJ?=
 =?utf-8?B?dG0rMWdjSGdWNEd5eFcxVUR2Tkk5OTc2R0ZlRDNSQ2lnZzZRVU1rV0ZmTkNW?=
 =?utf-8?B?WCtXQjk1Q0djUTYrMGUvWVFTelZqTWlodEdpaEZjU0xzVU4zWGpEU29ETHNk?=
 =?utf-8?B?ZnNXMmFkMDlESTlGMVE4ZTlCblBtT1M4aTVtUER0SHdMcHI5WXc1Q1RKTitt?=
 =?utf-8?B?MUl5elJkSS95U0x2Q0RqRkdRblY5d2wya0pPWm5iWjkvUlFOWVl6enh3SnRa?=
 =?utf-8?B?dDdMaFlvRjZUWHVwc3ZVRmxPcm9NREova29tM0dWLzBjb0NWTEl2WkNKN2Er?=
 =?utf-8?B?K0Zmamx1d0pxTGtZT0NEOEVJY2pmRnVJM2NYQkZPdTB2a3I3dXdia2VYeUZK?=
 =?utf-8?B?Z0ZWRTdYQyt6OHl6SzNRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2o1c2V5U0lqTDlkaE9Od0pOUkxDanRBREo0RkgwYmJ0dFRVSHRpZ0l4VHZa?=
 =?utf-8?B?cXYrMytMWFlsTXJTQWh0OVVlblpOaWh0MHhlVGVpdjlMeTZhZGM2T20rWVlN?=
 =?utf-8?B?dlRSZklVQytMQ2JvZlYyRy9keWFDa1BkMlpISDZkQWE1dFNJWnZKdzY5MHhJ?=
 =?utf-8?B?Wk1Hd1JUK3RseUk0ekdlVHRtZ2tLcE05cWptWXdRczdMbVEzL3JBYzJEQTdo?=
 =?utf-8?B?Z2lxREhOY1MvR2lpeVAvbXpNUzdDaGVzNW5iNVV1MS95c1I1eWlTc0tQRnJs?=
 =?utf-8?B?a09FYUd1emJwcjlQL2ducFlyU0UwMHoxZzI2NVc3R2FMK1ZsaW1HM2dqaXZs?=
 =?utf-8?B?dFFGb1FFN0pyMld3NG9RZDcra09mWEUxamVyUmhIZG9DeUVoUGR4NFh5b1Rp?=
 =?utf-8?B?TS85NVk0K0J4MmVaK0tncWxWaDJnWTVqR3pmZnp1by9PMXJrelJidUUwTDlR?=
 =?utf-8?B?Q1RKN25pRGszcWw1R3U3K2JjcjBCSG1VendVdUc5SzVkNlVjbmllbG5VVDVX?=
 =?utf-8?B?QlR0L213MFJVQTR4TTJlWGc3bXpjM0dCMkY4dm0yQjBHK1Rxc0tOTXpOZmxn?=
 =?utf-8?B?TC9TMUk5SnZ0NG1hcS9BTUs0WWppcE9KTjVBbmVkaFBxaGhyKzI0TGt6NFA1?=
 =?utf-8?B?Q1FxV0tmZWIwdEVkMnFVZzBLOTZobFM5cUUvYnA0WEx6ejR5b0RZbHdYVXph?=
 =?utf-8?B?ZGpLK0gvTFdUdTYvczZMTUIxUzhETmIyTzFpbUxUbXBYZ0x6dkgyekwzNnJB?=
 =?utf-8?B?UndPc2hKZ2xCTi9jaURGMU9mNkZqQnFESHA3SnNzRlZhYzlSY25OWDlMRDhK?=
 =?utf-8?B?V1JNQkNWejBHZWQzQnVxRjFyRGQ0Yk5BQ2xzbDBaNWN5Rzc4bGovY1ROQTBq?=
 =?utf-8?B?MHlreWg5UmxUSkVWbkU3bFdid2ROdkQwekx5dTV5K2ZjTzhXUmYzeCtrMFU5?=
 =?utf-8?B?OUVzaFRXVjluOUtTdU9TOGtZSkFpMzN4b3VMNWNYdTlzZEc3TGc0R1hZQkFP?=
 =?utf-8?B?R0hacW8vLzNHSFFSUXk2bi94YnJYcnJkNFNjc2ZjTFNrMWx6MVcvazZVa3Vr?=
 =?utf-8?B?enR5OHNTdDMxQ2k2cktRcVlFT0lqT3h4bHNycDJWR3hoeVdNRnc3VHljdmsz?=
 =?utf-8?B?ZWJJQmdGL2dtdmh2aDBOTmFxSHB5RjZFaG84WDVBRWo2d2crdHZUdXBwV1BE?=
 =?utf-8?B?alhzeWNDYkdMQlZSTUJtaGQzeXRGckdkdmk1NkpNUnBkS1llK0t2RVQxZWtC?=
 =?utf-8?B?MkNEMHdsRUV6S0VsaWtZUU8va1NOQm40anliazV6RFZBOVFwRnY0dkphUVJt?=
 =?utf-8?B?dXpxZzNvcHNHQnVCdFhLcGl3UFZGREtraktGeXo5K2o0eGlnaTRnK0FYNEta?=
 =?utf-8?B?NCt2UzZ4S1FkMCtPekMyNGtzWG5nc09nemNESmE0L2FsdGlHMUZZaFBMMHRZ?=
 =?utf-8?B?SDN4Y0JJYUdscFpxN0pWVmY3aVo1dDgzMHZHZjNSbEU4bjQvU2dTWlFSM0ht?=
 =?utf-8?B?VitKd2NIajViZWdSdUdGZDl2dU0xOE4za0FBbFdGTTdvVGliNTVaYXhIV0pW?=
 =?utf-8?B?RjliUmg4QnozUS9vWDl2ZzVHeWVNQkhBODlXeTdwd0dza1BBVEN4N1I4TXJZ?=
 =?utf-8?B?aHliSXRadEovSzY0WW5BbFNDU2E1bTJIVnlHK1QyckpwVEUvMFRyekFjaTFr?=
 =?utf-8?B?UHRhNTQzd3pITVYrTy9xUUVqSkU5OXlpNmx0MGhCVk9ENnVMT0JqcTlWMWlZ?=
 =?utf-8?B?UVo1d29mOHBQSVp2eXpYN2NxQ3RSLzhCMDMxOXBJaUpMYTVZa2Mwem1GYUQx?=
 =?utf-8?B?NXNmSDdXSkJSZ2cyZ2IzUWszMHJqcU9FQWpFRzltWEtrc3ZubHlGVCticVVt?=
 =?utf-8?B?SkZvTTNTOWVscEJPV1k2NVVaWHhjRXhvK0hJQ1lzMWdUdzJjNzNCWXZXL0t5?=
 =?utf-8?B?dGZDWllIbThRRmpzczlNTXhhMkVMLzhUWjhQUG5CdjQza1dWMFVFU1RjMUYr?=
 =?utf-8?B?VlMvRkRreE1vRnlGWDVHQkk3VzdvcGtYT3dQNURmNHozM3FjcU5FWUprT3hR?=
 =?utf-8?B?TFdHOXU0YndLdlZkUGt4Um9VanlpTHVlNjdkZjE0YTBtNysyWUNXV0NQQWZ1?=
 =?utf-8?B?bXQ0M0FUNC9BN0hWU0dmb3lhZlQzKzJQNTNxZ2g5VDZPK0ZCUWRBenhBZmJ3?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db1036f5-7e5e-465a-0bdd-08dccb506ca4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:09:06.1584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLIUVjChVgYtQtc/ut+JNU5qUG1hebYHBySyPy09SUayOu76SCSr6SIsq0hc0CtH0lfbL4xKZX1TjTp6Bij+64bA21F1saxf4eRdj6tE+QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783
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

Hi Jerome,

On 9/2/24 2:59 PM, Jerome Forissier wrote:
> net_auto_load() cannot call tftp_start() if CONFIG_CMD_TFTPBOOT is
> disabled.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   net/net.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/net.c b/net/net.c
> index d9bc9df643f..35961ba1c7d 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -334,6 +334,7 @@ void net_auto_load(void)
>   		net_set_state(NETLOOP_SUCCESS);
>   		return;
>   	}
> +#if defined(CONFIG_CMD_TFTPBOOT)

I think we're supposed to use if IS_ENABLED(CONFIG_CMD_TFTPBOOT) now.

Additionally, it's highly recommended to rather use "normal" if's 
wherever possible, i.e.:

         if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
             if (net_check_prereq(TFTPGET)) {
                 if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
[...]
                 return;
             }
             tftp_start(TFTPGET);
         }
     }

Would that work?

Cheers,
Quentin
