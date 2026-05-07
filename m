Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9983CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67DCF84B14;
	Thu,  7 May 2026 14:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ezan4/Wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB9B84AD1; Thu,  7 May 2026 12:17:08 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEF084B1B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWU6PSC2x4D6OebPQG9xwePtKjqWC6S5HTYq1Glw/D9ii23t/aa9kXfKC6qf/4AiW+3/2Xa5vWCRasclbywL6PkuXRNqeO/m2pi8wtPkXroLHtSzXSyUkQdn1nYP6NxkAcAw2QBl/z7P9xZpe4x03f+u0TsGGqbDDkjrKQFnbjkw9fWCt7ADYb0YchZTpFU0KMlYqE+AeyA03MTyeCB1BcMsHGrYXbHrl4n2VTZ7M8Qo3ehsWYSEx9wTaTnDq7zI4qTQQYWjLIymbVPfH2aD2RJOwUxqtGRcOq9vvTOllbMxX9ZF025UHqVEKo8X9yyHpTKVE///DkBDroGybNQUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEJpxRR/IoX6CoU/gXJI0hziW8XngsdaFu2w5mMU2WY=;
 b=KER6hJAD9AkFtGWJ41K1IRI/mmkUppdsrqnL91k0FvqQcjUAi5PhqgcN82J8HyvbMc7UB/lxFh9mXmX0EWARUyef2r56XZolZcUuuiMNMvSfewig8XsmsPY2jFhoE2tKqlhs0nXth8FSl62PD7ii0TpFPc00opmrL4CLDZGZe0vL8vTWpflH0t4Omto+tplDHUq60v0Hw6VkouZCa+A3C7fEqP7i85fkW2tuZO+fOHyz5qKe/UB8Xl3Wsxvv7FIAhktqRmVZKd5q2JVrf0Fy1qncJE1LRGAXYoMHmDYx33maFrb9i6yC5DnEXUH5DFKeJjaoQ/hh54hWQHMd3j7q1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEJpxRR/IoX6CoU/gXJI0hziW8XngsdaFu2w5mMU2WY=;
 b=Ezan4/WqLAvjT9ier9ov86DUgtV6e7kcJlw9YsaXh92QyyEg8KqRrFOgaEJa9zsmDceuo1ESOvocNZR78SOGjVV0mkoLILHBc10fC0pHwBSBgWaXyjYA3hBi/KzICliKWD5dqYRfJkjllB4hTBQKkbPqTXfI6XMQU7KoLXfIdac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:16:53 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:16:52 +0000
Message-ID: <f3ee75f8-55b4-4aee-82b3-b91fc82f9ad0@cherry.de>
Date: Thu, 7 May 2026 12:16:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] net: Fix alphabetical ordering in
 drivers/net/Kconfig
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-4-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-4-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF000001F5.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::918) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 19162625-4110-4b07-4e38-08deac21c253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9b2GUKEI7Paw21QzvKf6iO8bSAOiSJl3jJ0SOAL4kuYiZeM0G9LUguZOPYvd8K1eQTFKuEuvGJMlMZ7uMs1uaHkLtcg/CBvxwEaEeuMnSYP3fK5mhZLtOK0Yji6CYqNZjNvmBAS0X1VcsyZsCPGCmNCVhFJqg1UWPZ0h3bFhSubAih91PeOe4g1wV+ri6jMw2IlnStP0Hn7kcWDl5Nqm0jeiwbLJNjN+6Pxaaa8RzGfWR+x0eCy6AoqK8QaOwHsFg604Nf0FEZPzKRZ/s8ElMmNp3PrwknEY/LEXjQDIptHAEyAn8pjllSprAjThucan1sFM9tq6TaPnFExyVigM3dtMjDZRTauzeQx9ZLWjmQOfCOc4hFSzBzOcYdFK8lFTwF/Gy26myqaLlSrs1Gl80XdD3sFpqLkRcy5qMP3Eyit8W8wGcPc6ebqnqKq9d+TD290Qnt5xBixDe0vqAkiiDK0GdJwwgRXOCg+jaDRv5fs3c+x9kz8KZEMAOJYic89TSWVDkt2AIJyKQZ1Y2iyfyJqpH2dTclj4sG4MI7YDKTzddjiTqGOcJ+wdSj7tqRnHd+6ZdW4ZkyzFaKgivgx65eAPxJm1d+u4tGlkhpGfTc5F8U9Cko5uj6dYRVcZBfEsQQRMSk0OOeSA28M53jvd6cVTqpuMTxn7nY6MYnFFaHq+PtRYv9ErA1hMwhgMxxJy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmY5L3Bxd3B2SXpJWXQ3Y2hBNXhxMnMwd2tvRitqQ1ZiQjIyZWVYRS9qVzNX?=
 =?utf-8?B?NGNTNzJlTXRrSWpHUmRiN3NJQy94RWtiVWZoZjJzS0ZuVE9HeldNcFN1Nmpm?=
 =?utf-8?B?VCt5QkdQQVRWTk5XS3E4NG5vYjNzM0dxODdwazRQeDBEQmFuUzhjVTNxSEZS?=
 =?utf-8?B?UlkzM0x3b2w2RW5WZGxjZTVKQ0dySC82VzNkLytjR0c1RCtVT3NEMUc3aUNR?=
 =?utf-8?B?SFpFOFovR29sL2VQWjVYWkM0WEY2OTVEYll0RUxYcnY0MkZ2Z1dYT0RYM3U2?=
 =?utf-8?B?enE3bnE1MlpUUG5HVkw0bm9uczQ3YStPQk9Oa3cxb2F4d1MvcnRnTWE4Y3VC?=
 =?utf-8?B?d0dkU0ttUEJtdzBBMWFTbkNyZk5FL2FaMHZwVEVGZ1QxNDVXKzZKMGdlbXpj?=
 =?utf-8?B?UEJLVG5PSTVNOW14QSttYS9vRitqbTM5SUZacHZ4SzcxSE51SUo3dk9RTFc5?=
 =?utf-8?B?aHovMDFJY1hhMWFOdU9NQlFsYjVWaWZpWEoxTlBTOGxhTUMwRHBlY2FIOEdZ?=
 =?utf-8?B?OFVOdXRHMFNONFJuUU9JQVgrZTlOWndWaFQ1TDFUVzhHZ04zN1hzS01WWUJS?=
 =?utf-8?B?NUZUaksvRjRXWkxnU29HdUNza2FoQ0hFN3RES1o4VnhLVStuNHNsK3NBZFVo?=
 =?utf-8?B?R2ZmYSs0RC8wN0pzMSs1NVFzVEgvNFJUNUZ6aFlPRFBwUWZKOFFJYU9DcHVn?=
 =?utf-8?B?TlMzYUZyaUtDbThnSFlrNk1HVzdMcDFTQVV5a2t3OXFGQ1JjNWpGSmFlYXd5?=
 =?utf-8?B?ZHZVTWpSdjB2eU1iSkhKdXc3RlhBZmdwRlErZEhUdFVGZjhNbWZTQ0YveVZI?=
 =?utf-8?B?Q21xQ1p3SFR4cU4xN0owQ3NlYVk2YkZoQ3BXbnVGOURQYklPbDcwbFJwWVdT?=
 =?utf-8?B?Ty9pQnUrR0tsdGlCSHNMNmcvbExNaUp3UUczbWhPcGZCSnlSdlhrL3dlRFcy?=
 =?utf-8?B?ZUhwMWQ2MDZ5MWpPTkYwYnlpN2tzeGRmdGI4ZDY5N09Mdk5pUGJtOWc4OUVz?=
 =?utf-8?B?c3NBYVJBZC9zenl0UWVUQjFGbEFHNk5aTHV3cTRLQ2ZwYlVVajk0TldVTFhn?=
 =?utf-8?B?bnhhZHNodTVBMFo0Q041ZzB5WVMrZFpaT0t0UkFXeEo2b0toczdCaTlKS2xZ?=
 =?utf-8?B?R1lGZ0VzdUNXUFJacUdwWTlQWDJvZUdFcjR3ZUJvQm9Ec2Y5UGVkdEU3WEdz?=
 =?utf-8?B?b1JZWkhuckNQd3hGaE90eVZkYmxRLzVYMUN3QTNZcG9DWXVNVGxGUm1VQ3BP?=
 =?utf-8?B?OStYQTFxMVRXeU94Vm9HczJpYzhVYk1WTmlCYk9ueXFmeURnS1ZYQ1FMSEgr?=
 =?utf-8?B?bGhzM2NBWWxIK3NKQTM4V2Q0Tkp0NkFkcmtNUk9wemVYK0l0SGJ0bnNVZWhS?=
 =?utf-8?B?SkhwZ0VGRGNoRUlTajV1OG8xU2hyRVd4aUFuM1VPMzBnNm4vMThkQktUMUNY?=
 =?utf-8?B?eG43Q0tsaEhicFE3RW9lM0p3dTRIRHVueEMyZkJyd0NnNWgrMy9KbTZRcVNS?=
 =?utf-8?B?RitCRmpjUEJIc2JBYzY5SC9EbUcwTitTV2pIKzJ1OW9CV3djeGxjM0wzZ3l6?=
 =?utf-8?B?ZkU5V1NtSjVrY01GNTdzdXBndWpLRnk0T2ZsM3N6OGRKV3EyMmJGT1h2UFJh?=
 =?utf-8?B?RlF5SmVic1VEbVhPUkJOa2x3dmdVVVlLcXhaRGxZd25RSmVhUzd6QlVPOGNF?=
 =?utf-8?B?b0NGd0s2eWFVMzhueml0QVlzaG9YRUpka0lFZ0FpYk53T3hiZitxM1NUbkFt?=
 =?utf-8?B?d21hRnVrdnUyeVlWZHJmRW1zSS82amNUUTZpRDM3YitDNFUweDQ4Wnlzckoy?=
 =?utf-8?B?U1cxNTVDeGFoTmdSWXlGYjlLYnZydmlwQmdNZXlSb1ppRENOc2JRVEJKYmFJ?=
 =?utf-8?B?ZVduaE5QbkMvM0I5RndXLzJrOUwzWGhXSEJ4NnpyVG5hamFwVWVqaTdKaEZj?=
 =?utf-8?B?Nk04WEhaZUtUS0JSTTJRMWdtQTdnUTNrcW1Ecnp6akNXcVRNUURJbjlldmRY?=
 =?utf-8?B?aVYxQjloRWZWaTdoZUo5dVhmb1VqczFjemFSalovSFVtYk9nSDY0YmpCWEZZ?=
 =?utf-8?B?ZlpFK3FvYW1SSnU5eVIyU1dBVEZjOFFIZlorSjg2MjVxOUJBOXltY0c0Z0Js?=
 =?utf-8?B?UHprMThXbG9yOHhYRDkvVXdoWVVvMXBWaDI5cjBjdXo5eUhVSlpqZW1DeUEr?=
 =?utf-8?B?N0MrUUNYOGtWcnVnZkJDV05PWWIzUit5RnRIcVBQYkJDem5vM002UWhIYlhU?=
 =?utf-8?B?VGRjUjUwU3p4UGx3dml6ZEZpMFgwcEZIcUo5dm0xcXYwYkFqeHNzaGpwY0k1?=
 =?utf-8?B?dS9lTkxUSWxuekFJWUlFcDd5YnJpSGRtSC9UNUs5M2ZIQzFPSG02dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19162625-4110-4b07-4e38-08deac21c253
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:16:52.8691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bXIAIiwreAhxD8nQgAt4DUHt0TU1tcTJpxa/SpIQXrGG0gY1C32sGahQrBHNLHISbYGOAhyTX0z4bwkMl9cIE6T+2eBbH9GsoUDes3zZdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Mailman-Approved-At: Thu, 07 May 2026 14:04:29 +0200
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

Hi Julien,

On 4/29/26 3:58 PM, Julien Stephan wrote:
> Reorder entries under DWC_ETH_QOS to maintain alphabetical sorting by
> CONFIG_ names:
> - Move CONFIG_DWC_ETH_QOS_QCOM before CONFIG_DWC_ETH_QOS_ROCKCHIP
> - Move CONFIG_DWC_ETH_QOS_STARFIVE after CONFIG_DWC_ETH_QOS_ROCKCHIP
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
