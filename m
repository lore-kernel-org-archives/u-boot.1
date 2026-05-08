Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B169CD37B1
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E9384D85;
	Fri,  8 May 2026 18:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PzN4HMUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D6084662; Fri,  8 May 2026 16:43:12 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F1980F0E
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFUNf3adB0VAHLINj646YTRiBz8gHUjli2hIF5/Bcxwi7SCIqOelQmk0n/qPaBA56hATISa+Kk+mTjwxV1f+IbCO+QtM6zXKcOu7DUydTGbuIffci/9enl9FI48UgT+ATcwRsJN82ZGKkK07mZnPN/gBz78MUJXIRAqqNku94b9Ns4XkVZi8u1LyJIFVuFAa311TilCWnrubt5c/8LfKDAFSD7rMXbnmQsN3Y65ApKhl16AqNNNKFqPaqZAsgdgIFqff9sGVdVrjAPBqQJLmeNYCK0X02u313JXz+9m6t7ZEUIVsfQkRkxD8ZJOBL6SCoeBjeKvgrdeH8fGseD2AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG3k8XgyQTwc8tPEEntV1/UmD8T8W3lVIWKjfzE1wcg=;
 b=tPDPmSJU8lbt61g4+lK/lAznQUiIiW/behbWCHrRJNIokEvxo7C5Q0jlD7cj2d1cq2a8pIfvvIbRv3M+/0c7IkN0gJCuA7yR3bPWAAeTftfPSOecAWDpoJCmAWc/2WIbc+/WiGxm0u0BrnZNRfjIW103x5YJEgShbxRZzAvtdPLq4MGouQt/7/IA3lrhUGFfxH6NqU06Cvd0+x7PX4riGI5+7ozoF7JlPNr/My3SrDxCyLNuCkliLLZSsHCYVTYdKPDAQSj5U6QYa46MV8H04Oe+LoK0cT/KnL1LfQvAHyhZVqw6j4vCTksovRWu7ZYBI6a2fZwM8PnbxMx2BKtiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG3k8XgyQTwc8tPEEntV1/UmD8T8W3lVIWKjfzE1wcg=;
 b=PzN4HMUMCzD1KQHn1mdebHXbJ3g1ZfB89yfQiZrj1uVlwfaDWa++AwubZ9uxuKEar3J51qp6HRxZrfDeVjlo06rptTPKO9g0v+tpBO+Y/CMx1jxpSVLSNTuXfi39OcmFg5luV33Jps8eoF4znLrGNpaxlCOUl9zh26y/P+palqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9625.eurprd04.prod.outlook.com (2603:10a6:10:308::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 14:43:07 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:43:07 +0000
Message-ID: <2ded0757-009c-47e6-9a9c-271d9b5b4aa4@cherry.de>
Date: Fri, 8 May 2026 16:43:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] MAINTAINERS: add maintainer entry for air_en8811
 driver
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
 <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: d90aabe6-c68d-443c-83cb-08dead101da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x9PX3UoQateltUSFtoMGN3nNtBy8nXGSBe2DXLo4KTi/HTVBMcPqQBRUaiaynVflpX0ywqSdObpk4xfXMLEI52wSDXU8EcKTPfBqoPJ8IxF0aUyy2Uta6pgPIIZodJ+f2uwIcDbfJ+KLhC4LTJQZw3JbntN4ScmyTm8vo8o3H32Z5DNJD9YIIkBR065DNDW1WvZU5gfTZadoXUIAfYofEL029a7QIn6uAqAd0LJHi3vExiJLeVGIObAL0q2BGdFey0is6No3LcndDNcVAZ+3jWCufQD78FzpNphLYBLeP1N280KslpyQFyfd0QY2NwAZMlCowA0eFHwbMHbbt7xk23WzPGnOPDIoO/Hq/XJgAtnXHKKjut1o1TNNXWmL8IaU4FXO+pOAUZlWggWH0s2oVFq9cWWgMuX6G2a41s7ERtIdrPCI0b4uQovVlOVA+yfJw+HwiGWKxSp6Tz3TwVh1jnSBE37KIBpEwgy2NMGoz9/zD9ynWq3dVpVxFJlpsYPZ3DY6eOpinYWYkcgIRWFw2eXhLZF6Ow1p2YEjkWMfdgr/Covtis9POq1WUlNoN9T8mFzShODVcRjovc/Gbh7QBNwgsbXDP71/dI6dPyAscxUmTt96PIka1meD4+EdC3/lZzmK1OLT2pdcme1YTdtJYzgCAGWRf06Zt2uyuLQTwPhtrvGK3F7Ab41LM/kprtNn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUlNNXptMnBiRFZ5bEl4RDRRK2JqdzE5YXA0Rm5FY3hHOGF4bW5BUExZeGZv?=
 =?utf-8?B?VDZPUEhIbE5SakRDVjRHMXJTTEo1Rlp1NUI2dUhuL3hhSVJOK3RHdyt1U2dt?=
 =?utf-8?B?aG9uN2V6a0xsdk9BZmlHMmNQazVsb2NRcXZoS3JoSWx0cEtCcms3VkNoV3Jt?=
 =?utf-8?B?M0FHUHhEaStrdUxGMUFHazByRS8rMUhGZjl3VzNNMXJZWDdhdExTaVgwZ1Bu?=
 =?utf-8?B?ckhDekdBTG5RbjJORUhzaU1pSVJBWlgwejgzTTZUZmVoTkdZNUYxT09CZ1JC?=
 =?utf-8?B?aE9WMVFiU0JhVXVKZnpBZEFtNU9lNU9ENXk0MWd6UDdHbUJBUnBENGZ6SWwy?=
 =?utf-8?B?Ly9hWlRhNW4waDg0dzlFL2tkazhtL1BGZkhQMkUxaFY5QUdEUXdLNTFrRlUy?=
 =?utf-8?B?WE1kNW45cWV6MkJiWUdhcDJHZ2JCYzZMcm9sMjZpdDJlbDJDeVoyY0Q2SGc5?=
 =?utf-8?B?U2JXbEFpUmwvZUw5VWkrbm52QnNZRXdJMElCaXVhL3VEdytzTldrSURRTjNw?=
 =?utf-8?B?aHNUcWVRMHRwSkgya1FPem5nakdhZkJ4TU9lTXQxZlJCWTN0b1ZQZnhTMytm?=
 =?utf-8?B?a1k2cDdOazREaExWdmNYL09ZTUdlRWc1Qlg3SkZPWC9uWWxrWUVHN3ZNemxX?=
 =?utf-8?B?OFBiaXJxK2NvV0RvQjFlc2h4U0dIY2doKzZYcHRmNGpYSEsrWlR3K0Y4Ukxt?=
 =?utf-8?B?NlpUdGVGS0NXeTRQd3RQcUZlMWdSbVQ2cXZpMG1MOTNQc1ZNVVNNSWJnK3o2?=
 =?utf-8?B?ZWg4dkRGUmFEMysvcW8vZXl4TWZabkxBK3RsdkVnU2dCWWloNFVlSXJwQkxu?=
 =?utf-8?B?dDVyUjFKbEx0TEZhdlp4d0N6ZjVRcmV3Q1hCNjdkcWFTN2kzbU9va2xNdWcr?=
 =?utf-8?B?b2k1bVAzTHdiMWxaelJvVmM1TUkyR21SbUJoWkZaeUFMbVdTdGVBZXZXbktw?=
 =?utf-8?B?NHRXRFVkVm0rZk9SNDVJWDJlVjhJVFBRcUhFQmNtNE8rSHAvZzkyMzNJWmYx?=
 =?utf-8?B?OGRabkNEblBGVW0xY2ZId3A3VFg0NkI4ZFRUSVp6WC9xVk9zODFZcWtvNEV2?=
 =?utf-8?B?cGw5TVB0ZTFJNTlZYkpTOW15YVZJbTRpZ2tuNVJXTHUvRE5wU0p2QmwxczRL?=
 =?utf-8?B?U2R2OXdrVE1qUEIrQW45SldJcXRNSFZpNkw1Q3QvaHJMUTRLWjFiOUpzU2dB?=
 =?utf-8?B?TVVwTW93UGZqbUxMem44ZUVMczc2ODl6MWNQRUxqUXpUcFNUcUNISis0QlRH?=
 =?utf-8?B?ZkF1VjhhUGJCZFR0Y2VnNnBJNHBRL3FqNnlCcnIwWi92eU1ISGk5RndZOXQw?=
 =?utf-8?B?QUJwR21pREJVaFFGMjFjNXJ5STdnSXJZNzZkbnAzUDhqWWZ0TnpTeTZQaEp4?=
 =?utf-8?B?Ym1mdkZDUnUvbVJwMU95UkhxU1Jra1dKb3JYSG92MU4wUTd4V3NZUWliNk9J?=
 =?utf-8?B?aWlqOVAxNFpobnV5bUxyNDQ4ZTVDSjI0dmdUdDdDU2hLVkVGU3BEdVJvUCtt?=
 =?utf-8?B?bVVBQXVpek1CU3hsQnd4UW8vWW9qVzAwY0pIaWl1Y05tUzhhUDY4Z3B4MXdZ?=
 =?utf-8?B?a2RoTUtzWmdML0tkdXI4aVVZRC9McUIzT0VVY21hZ3h0ajd2aVAzWnV6aE0z?=
 =?utf-8?B?TlVRTDFZTFM4eFdNdXlTd29zNmZoY3pVbTRUTDBMWGVyUkNzM1Fac0FWVVNl?=
 =?utf-8?B?YUFOLzZDWXFyck9oeHJFVkt2NTB4WGNONkthem53SWZQN1FoMVlkbk8rekVS?=
 =?utf-8?B?ZVFkUDBoZTE1ZVljRDFER09td3dyeEsrOUlLOGVtaERHUUhQNXR5OTg1cFMz?=
 =?utf-8?B?UWpJNGd0by9MZ3E2MUdmYWNkMTFuWWRNb2RwM1VWZ0kzMTdRSjZVL1ZyS2hX?=
 =?utf-8?B?RmtPbnJnMzBtV3Q3NUNsUHl6VTc4SEloVGI0WVFiL1BZZ01UYjdSQ0lrZ0VI?=
 =?utf-8?B?UmFjd0V5S1pmN1AyNzR3bzhsV3RhbjROdGxubklCTzFRaWh3RHlFTks5K1M2?=
 =?utf-8?B?TXNEcmlWVDBTS0dCQVlWWTloVXUvWVlaRExRUWl3bGYyS3RDU29va0g1dlg0?=
 =?utf-8?B?R2s4NzZHTW5CNlQyTEhoMVZ3OWdxMXV2ZGdYek94dFdKNFhaVnhjS010S1I4?=
 =?utf-8?B?NEVDS1U4VFVMNHN1ZFpmMStWRlpCbVFFc3ZCbFRoNFlSVkNPZlcyanV4RnEz?=
 =?utf-8?B?SWd4UkhZT1ZLRjNENXduMjBjdjRTazBSeTJVdVYyVXhqd3lSWTE2bW9qcnpq?=
 =?utf-8?B?aFIvMmR2a3YxMklRY0cyNmwwUU1tSzYrNWE1SkthZEtFWGVhKzdGakxaU1Qr?=
 =?utf-8?B?L3R0YUk2clc0c3QzVG5SVXprT0FqN1Nld0hkdFh5YkZBTGJXRFlvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d90aabe6-c68d-443c-83cb-08dead101da0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:43:07.0045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JqtZj5j4H56x4Awi17lGgHy+wpKQdl4yc1pMAC/0jBFfY4+zelMU8H+FdpCeiBJB5NYLpWRy0SUpCR2XN+H98kLKiq89hMZcxFqksSQH0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9625
X-Mailman-Approved-At: Fri, 08 May 2026 18:23:45 +0200
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
> Add a new entry for drivers/net/phy/airoha/air_en8811.c  driver.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
