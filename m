Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAEEC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AB188A6C;
	Mon, 26 Aug 2024 17:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MjDiW1B9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CD488A77; Mon, 26 Aug 2024 17:48:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0996688A53
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoNqyQ9mBsfStCjEztjO/QacN7KT+iJLGsA+IBg+uI89Rc0/lxw1bt+H7skZCjxYXf13aFW98L3ePCgXULs1c1NU+7mjmvcmGHyhm8q0rHGpccqqR7aD6ojUSXRAHIviu4pz0BslkicWv12fkRGxG6bDUS2OCjVQVsWEoyP1XkFrRZEOqeGt+HraU/ebClesIGkQzDlmk8F28Zcb+xx6JJJG89y3dfwK1IFk64d3rjG2aUrtaccj3ce+TP/cW3I1V5KLTaopdB3wJVjze3VVe+lF41n0ESnPmAWdxD2YBruQhysjSrnvnUs+qrg16Nx9CVUkygl+gABM4VxWBIPhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdmObM+WsnW+dr/GzlBSy1cQhWJqNT1NNNlOSNQdEwg=;
 b=TV7HlXX8gxIg+i3Z+lSoy5cCQ1bCzq0uNO5FtO3ebghfeQsjeux04jBGEiaOKQhaxlYlWqKCCB6RyZRa2fsnTNhpZEE0e2WcCVsuGK9dZYSMdYbohfT53WYJunrpwzWuG/bMraqRF6rJpdYdFNuSlSXVatycbfbCvcmuwzW1QfoZ2Qlpl8dt/gOVlXkg8bJeN/XxfxI1EXA8nAdWq8fZYXKpt7mXQUpEYOmyovvak4nycoBBN3jIoGX3qiwd9C+S6EHrI2YMfRv38nyerJR/9atvXhsIckc3fV8n6B9SVTstlN3qcWSc43tmpkV4Zmv4xygimDi9GKkCzbdQQRp7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdmObM+WsnW+dr/GzlBSy1cQhWJqNT1NNNlOSNQdEwg=;
 b=MjDiW1B99zxcSsGGScGRNQjtw5heB7jTQpt1wzkgrO9YLD2oIao4yTUTmRqXtGqSj2wi+iRHj7fb2Pw0I+5S929T75h673aJywm1PX+zSBk9QFioMccdMZ9LyoqlGzO9GyRB+6Jv107F3TbLLdMSGN/DODWNvTWyQDYBWnKQaiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9076.eurprd04.prod.outlook.com (2603:10a6:102:22a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:48:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 15:48:53 +0000
Message-ID: <3ffb1f2e-f093-4d2c-85c5-305c36247219@cherry.de>
Date: Mon, 26 Aug 2024 17:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Scrub trailing space
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240818200356.89000-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240818200356.89000-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 293013e1-5455-494e-18ee-08dcc5e69649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFgwYVJ4OHd5RDdaM3k3ZGdtbXh4UmlQWStRVUtmKzFnZ1NCM0Vqb2lsVytw?=
 =?utf-8?B?Zmp3Z2Q2MzdmQkFVVzBNRU1mMkY5L25iclZnNUJ2cjFmTW1lczVCQUpieXpD?=
 =?utf-8?B?VTY2clZiM0d2U2JqTVg2QWlNQlE4SVdYdmUrTzRHZmF0endhZGI0alZGRThx?=
 =?utf-8?B?UGFSL25HYkgvOVRYQlN2T0xnR25POGpiUWVEWnhBcUl3NzdPa1VhdnhLNHpO?=
 =?utf-8?B?UlhVZ1U3YTRhdGRYeW45U29BRUwwMDlDNnh4d2RQaU9RQmFpQVlDNHIvdCtN?=
 =?utf-8?B?UnB2dXpZN1NhZWwrd1l6L0MvTHdwNmovckpiWXVEblRGRUR4Y0VzL0ZpR0Ur?=
 =?utf-8?B?NTVFaFJSTlRrRll4RnZNZXhwOW9HMm9nWGRyVlhYWTJyNWVHazZQL3ZZbFJx?=
 =?utf-8?B?RDZXb3FhMHBuL3I1azdPMFk5NlpvdE9LL095Y0dYQlRGK0c2YWNTMUFCRjZy?=
 =?utf-8?B?ZmJGcVFibFJGMTZyM25RK3A2cVFRYXJsOFlCRm54RW1ReWFRQVNJc3Nua3Vv?=
 =?utf-8?B?clBRRTJ4RHUxNFB2Nk5nL29raWFFVTYvTmtueDBhVWRNZkJuRjQwbHJ5dDdZ?=
 =?utf-8?B?d0N0OWQxcGtubDc1VXhJL1pPZDdyVFRhTnc5VHN5SEdMRDMrcXplZ3JjTzdw?=
 =?utf-8?B?eCswc3BtVnhjYWd3MU85QVZNT2RPQzRUNk5id2JuVGpGNWM0UDJqYmtKanJv?=
 =?utf-8?B?eHNGSXUvV2MxWVZta3c0dTZFQURqaVJwemNKMTV0c3JkZ2V6WGFZRGplUXpt?=
 =?utf-8?B?M1JCRDRSTlNCTWZBOXBXcXRBcW5zR2hpc3JjalBZS05CdXB2QXhnS0ltQnY5?=
 =?utf-8?B?M1paeDZMRmk2RGp6SlBtcHNVM092R2NoZ0dzdGRyU1o1R2k0WFZnVmZYdzZo?=
 =?utf-8?B?UHBGaCtWY2pvRGxQZzdySW4wU2lvSlI4TFlUQ01Dek02aWxTeGMyWFYyb3Yz?=
 =?utf-8?B?NVlhTHBqZEIvV2ZneUxibDdiaFU5L1lNVzNVUXMzZUJnWG9uMEhZSWVWVDI2?=
 =?utf-8?B?cTJVd0Y1cUJVU1d2cFl2S3BuQ2xvYVRrVmkwb0lXUURzWWFvbDhGQzc2N213?=
 =?utf-8?B?Z2NuZitoUUQzUUxHTk5jZm85Y1U0VTBnTGFHejV1MzZjYytOWnoza1ZDb1FB?=
 =?utf-8?B?Mm1UUU9TRWQ3OVdpc0cyMHVJOUZGRlZMNy9abUhZMnN4V0pOUWowTW1DMHFs?=
 =?utf-8?B?cXkrbGZjYW13U21oSmVNL1JoSWpDWXRhTWxBQm1qVENJUGl1aWRiOWduMlRj?=
 =?utf-8?B?Wm1abkx5QmkyeU5oend3akhlV3FsU2RERnRaTXJ2R2RuVHRwM1dGdTYrSUp4?=
 =?utf-8?B?NEpqVWszUDNqUVJISlFVZkhhSE1YWFVPV0ZzQWFiSEN3ZENBZ0RjTVZUclVD?=
 =?utf-8?B?cVdvKzF0NXVUVGhRdzNpSWEzSW04bk90VFBrbm1yUE83cThoNHpha1lYVVdu?=
 =?utf-8?B?R3pLS0oxM0Zqa0x2Ni9jc1N1ejlOejlqS0R0QVJZUnIxeEhrdUVOdUlwU1NE?=
 =?utf-8?B?UElSemwvMm1kV3ZFVVFNSFprL0N4RFVCcUhVM1BNOGM4OVBISXZ2dzVIelVx?=
 =?utf-8?B?R3Z2VHQ2S09QMnEwNmx4bG5YMGZhWUkrZXZRVERqZmZvdysxTWVxTi9uZExW?=
 =?utf-8?B?V1FvWDhkditwUmVFUWZNMWVVbGNaditQOFNsM09xTU9nQmdHd29lRlNlUlM4?=
 =?utf-8?B?MVZlRnAyalMrdlJoTzdiQXlZZEhzVXkzNlJTaG5VVWlDUDFjNm8zQ3lNbWww?=
 =?utf-8?B?U3BlT0NnTm5iQUdna0dCcVROQko4dWtjVm1FU1JQdGFyenhRQmc4THAvTzY5?=
 =?utf-8?B?RGVEMW95ZU5yaWg0WGVQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnEwQmNqdCtYUjhNQ2F3bzdTRzMvK2ZVMHp1eXZKSUFEZlJhNVRPOFFqbWs1?=
 =?utf-8?B?TDE1K3BCWlkxbUJZUU4rQzV4Q0EwZHZJYml6SmJxSVBnTCtYa2JaODJyaTJU?=
 =?utf-8?B?OExBTE5qSFUvZjJxaWNWNTE1eW9ETFhuczlib0FhWHBsZDcxVVVzSjliME9M?=
 =?utf-8?B?Z1dVWkVqU1NWczZUdmlCVHNZZXVwejc2TzgwY25ZSkNnNTVKYUJsOHRaUlZa?=
 =?utf-8?B?MlYva2lLdWlvMWpHRWRiUFJscHBqRklGZGE3eW5IaVRFdk9EU25DV3NVVEs1?=
 =?utf-8?B?Q21VcWlpOEZZOFhHbGJ4YUtzZW9sL0NoNTdRMUMwV3pTSU1YL3NMTW53dWdS?=
 =?utf-8?B?SExZUEVDRjUzRXNxYm5uWFZjWEZTK2YzUDg5QWkrdmQvZlBxZXpub0ovUHNE?=
 =?utf-8?B?VHRFUGJQOGhNTUJHVXVaUlZiSGFHaENSSHpOcUhzRUFHcE92YXNUYXpGa210?=
 =?utf-8?B?NFNoTHI2NUMxa1FEUmtCTk5HaWc2NUZZYi84VUtIWDNweXlNd1BZZWxhbDcx?=
 =?utf-8?B?c3h1SDlzcXAvNlRhc09NT2dFSGtJeDZWcVpOM25JaDBmOGNqM1JqbnI3c2kv?=
 =?utf-8?B?SitrWlhhUHFWamYrdlhwNEs5K3Izb0pCZnlPUGFRL1hFaEFCUSt4cm5pbEp3?=
 =?utf-8?B?c21mZTVWTG1nQjFSODlEMTRVdWpRTnB5T0FoVmhiQlRmQnBEU0czWUd5eXFP?=
 =?utf-8?B?OXNNN0dIb05nWHNXdGh3bXFTU3l4SnN4WndNeEc1MU9nOVVVdjVRR0QwZkJR?=
 =?utf-8?B?M1B2RnpjOFhCWFpxYXFEUTRiMmtYaDRKN1lkdXJUQVhJRXcvR2RLRkNBeENo?=
 =?utf-8?B?cWdwK2Rac0plNElSQzYyNmlGV05UZy9QRDhpMXJWNC9MaVFPS0hGcy9BVzV6?=
 =?utf-8?B?d1hZQ2EwQklLWk9QRDJpZldoRGgrWDZzd0NkRGhvSXJReHEyNnp1c1Z2L2lC?=
 =?utf-8?B?Q2R5K0ttd2s2SXdtTDd4UC9zS3ovdzVUa0xOdzBRcUpreUx0WEZXZ0ttNnVS?=
 =?utf-8?B?Mm5hUjNYSFEwVlVHK1N5SzRBZkZaQUhmdnBGWHJDbHQzVE95UHNERU1MK0JT?=
 =?utf-8?B?RU5QL2pTMEg3QzdwZGpaRXRNSm1QeHA4YSs0aEZrQmxFMmVqbGhpbmxiM3V0?=
 =?utf-8?B?czVHMUZmNmJtTi9zWXZVWjBydXA0Z2xKSDBYY094VXgxNFdJU3d5eTFad2NK?=
 =?utf-8?B?UlM3UHp2SDlPSzBYdVFLTXhqRjJkUTNZbDFMRmtCU0RFRGV1TktpRGNJdm9j?=
 =?utf-8?B?L2JNc3lMaGdZOG5RVFJpNml3dFBJSlVyNWNsOExPUHR4TVBpbkJnZ2ZaQTd3?=
 =?utf-8?B?WXFCS3N6VllnOFpjY25ManYvbWtqMG9peUw2bnBsd2pyUTEvL1Fwb2dXRmd3?=
 =?utf-8?B?UThDV2hjYm52QWRYNFdtc1l3K0FhZU5jVlQ1cEczaFZVL1BtL2R1YTh0SGJW?=
 =?utf-8?B?R2JKaGJRVHRkdGpFUXNab3ZXM1l3NWVYa05EdXRKeEJ1M1owclptd0g2bHlq?=
 =?utf-8?B?UnJtZ3N6V2xoaHBlUm5rbXFsQVRkQjBGMWNjZE1sckd3ck04dGxwY3FGc2Y5?=
 =?utf-8?B?aXVDbXk3cnd2bVVIT2ZjdFBFVDFhRXJLUDZ5QS9BaXZhTHFPSFR6VGE4YVNI?=
 =?utf-8?B?dGxBY3liTzlhRTMvb3cvNWY3YkZZVHdWL09Yb0VoQndBR3BFR0NGV2o5RFVL?=
 =?utf-8?B?NUk0cnNJTjQrZml2emxjZFJpdjBqck9MOENDcWlqYWIrK1ovMEhnVUJXUTFR?=
 =?utf-8?B?Yks2bngyeEFaTUdYRUUxd015QkIvZUpkOUsxdlViYXlQVkZNelk4YXpjd2hM?=
 =?utf-8?B?LzVCY0I1aWE3RlFmS0FMOWt1L0pWUkgwb0xlVjdRWFRYUjlCRHV0UHk0YTBG?=
 =?utf-8?B?TXhFSGorR1NmNEMxcWVnUVd4Y0habzZQL2d2QkFDYnBaQVdocHZXZGdsZ0Vw?=
 =?utf-8?B?M0xKSEFKK3BJWEc3a0ZwelFPeTZkdmlsUHp4MHRQZjJWTXJLSGdCNHZmck5h?=
 =?utf-8?B?TnJCT0owZFgyeVdxcytmdzA3blpCNG1TU200Qmh5aG5wUnhSSVpaT3YvMkg2?=
 =?utf-8?B?V1lGcWJad2R6QUJLV3c3K2FqaXRud0ZWRzhSalRsdzJnWHh5dW15YUlqOEVM?=
 =?utf-8?B?bE9UNHJ5VExCbC9TKzNzT1lOT3g3cTU4WmI4SFIyeFB4ajJBQmo4RDRYaStL?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 293013e1-5455-494e-18ee-08dcc5e69649
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:48:53.7869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISXJa7MyGaaCYSiJ1BBkLJ80jtzwOQikbNqPBcl/Mi1L4RBCTs9htcQd+cV7zgfC8DDKYo49TzX2S124oriNpQUqh4CfqJ8KcFQH+ITWY6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9076
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

Hi Marek,

On 8/18/24 10:03 PM, Marek Vasut wrote:
> Remove all trailing space from the code base. No functional change.
> Implemented using the following one-liner:
> $ find . -name \*.c -o -name \*.h -exec sed -i 's@[ \t]\+$@@' {} \;
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   fs/btrfs/conv-funcs.h       |  2 +-
>   fs/ubifs/ubifs.h            |  2 +-
>   include/linux/rbtree.h      |  4 ++--
>   include/linux/zstd_errors.h |  2 +-
>   include/valgrind/memcheck.h |  8 +++----
>   include/valgrind/valgrind.h | 46 +++++++++++++++++------------------
>   lib/dhry/dhry.h             | 48 ++++++++++++++++++-------------------

Some of those seems to be imports from other projects, did we fix 
upstream too so that the day we import new versions of files from those 
projects we don't have to do the work again?

Cheers,
Quentin
