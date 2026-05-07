Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1424DCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A6084AD7;
	Thu,  7 May 2026 14:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iquKCdVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3278984A8A; Thu,  7 May 2026 12:10:29 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390B784A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjtKyjqIjtRNF/HqMYL5IkeRS4/7tyjAXNC2/N3ryJPLDEm6RQqKlYJIxUuTnyL8EAMyPK8ag4Aw3pHsA1Zg1MyhSsdOngVsOuJbYqNoPtH2h0PNtG9nnew9gfGSQ1xSRL0ODgE+zfncvrqWRIuA4wkzdcDCJIqkzJ4PeMZ/WOvsS0nArEW46vIsetpnc7jKhbnrCluROamSzYn7w1/TIMhDzhoyuGRedtkbqd3tiSQOsvJ5US+Z3yGhCCq+ckrL5PlAi5BNzMnUi2RRQpyZ5iXzZuO6DsDzHOK8QEekEb6ZRpAUnZ+fyV0CKnyvxQsDAgmafMMGfdrpXNgkPuEIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhkjPXHDh01SJW+pwhgo2iuyLmC5AR5KE5dxAUx7noU=;
 b=CFGUmywURmXDBPoFXfl9ytW7wB4VGJ3OkAdFsyXX9YYTUVvxtfgoVhmH4X6tdCU10IuRcI6FdhaImonv6UfECUI14VPXDaMVtXf2DFEhRkbo9EzI8eeApyVFNJ7wgo6p+dYPhZ5Yuf0nvmwvoU+0jDogA416j9btrGsBlM27YXV7ptm0A7INfZBQqudGPTwHFsUd5gAZkM6adarcmxCpVLn/t90NjNcKZLWWCp+uNNgZDP57UfPvsmOY3ryb4xd32BaeUGijY6gr6Sq/k1QOAF4Zzd8ZYDYU6oL+Ec4GX+6JJ1JZUFPXNTmhuk0u7giRVxsIf0xk7BZt4zEwXGprqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhkjPXHDh01SJW+pwhgo2iuyLmC5AR5KE5dxAUx7noU=;
 b=iquKCdVic3LXRRoXFK3jzdfgfxCWzKTvk6liiWl1crqIe4UU8oJ5Rqm2pyw1h3jP+gEOwe3iACzM6ieJ0sme0Fqj3KoEqPgBbUOgYUVrCfJSXxqaRsiF1eTQsH4ciAnOwJUn76QXk1kJzN22YSjslnE2c7t3EeqslTUzl2Uf6P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:10:23 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:10:22 +0000
Message-ID: <d9acf26e-ff6b-4564-a5ab-da4e48cb7fe1@cherry.de>
Date: Thu, 7 May 2026 12:10:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] MAINTAINERS: remove trailing colons from section
 titles
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
 <20260429-add-ethernet-support-for-genio-520-720-v4-1-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-1-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eb2773-2dd5-434e-2f20-08deac20d9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +UPkIf/lbRQKM8ivtMEIsj/MVBkqBgCeLNpZX+Vpu465Zmw8wUjHtwtSHQSpPDcRziJ68TRCBFCIfa0/fusPCM7n/8QI0STUGjV6nn2tz3uUdJ0NB3RbTlEJDg5AbeUCx0FKOQ+6POf0EU4HyBVBkGll25Vzg9lOgkQ42Be2JwtqJ0/97o6IFfjI9V1HEkuQdeelRPFyNygMxkU2APT1SM5u/knG97wAvJCt8RKqOfPqYiKNsno9ezQNnD+mSe3jbQUGxc+r3PtESxgWvXStuP74OXbfz/jxq7Po5RO0axX1cpuUpCYQ+SkgiWFU/cWfJQWhKJfNzrZXv5eNXjJhomrzs7T/EryIVr/f7jgtGZaJDPJRsBMbt8+9/DPJnOvTDMF3aYnroDLvRc1naZD25hizdr0+h0/i+Hyu1408q82dr9qpmCaKdkuqm03dppEdAZ4iezBNPtHUQ/+nUt022GxXlETa03yjhLekZp2emSYWfPX6wT3dRq847xJ05pKI0f2LEPN4AI5gpvqcT9yOGH4ymnBYx501XAYLHCqiUgy6Vkc+0SwBxbfZltqUKbzjFB6lsxtxe/KrM94m1KksJzDt0sWtDUY52BgQUfC+2GyqAS3RA6kEOwSKs1HgOPwQ6VU8XElvjgovCQ6GMblXbZDAmqg1PwbBE7skbdRFWlwwu7iH0ZJpPZStmUGJtLhu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHE4aHVWbE1GQUxhNWpUUlU0RWNBZkFrWGlsV1dTd1BFVFlPM2czVlV1b2ll?=
 =?utf-8?B?UUVJbHNqOXpBQy9iT0orK0w0cC9LRnplMGRBU0twYkFaVUFzODRMMXpFZkYy?=
 =?utf-8?B?VXdXcXBlS2ZrMGRmcU5BaEJZSVRSMGl3UDBRNTU2RDkzeVNEampVZ0oyamxh?=
 =?utf-8?B?S3hCa2VheVMyaE12cSt6enJVSGZUV2t3dWxvMVVOKzRQT051SDJuM3ZzOEVk?=
 =?utf-8?B?Q0lCeWplajBaU3N6bXR6UGZOc3hnK1k2YS9Ga0ZKdURvdXMzRDhDMGtaUVNs?=
 =?utf-8?B?bEM5Ti9sRWpzTlp1bEs5b3BkbmxWRUxxUWpuU3VJUTBscnE5SHNCcjJXbnFC?=
 =?utf-8?B?YmJJMjhWZlM4ZXBacGFNelFzV2ZKMUlsMmRGbG5uc1NLT1hDRTV6b3dKam8w?=
 =?utf-8?B?cnMxbkdBVTNnR1U0ZStzVkhlWFlJSDBObDdoYVRVbS9hZTZmV2kvK3d2S2Ny?=
 =?utf-8?B?WCs4MWxTVmVDNjVyVTFUcVN2bjNGUVgraXhhclFnRndqYmlpLzN5eXlsTFln?=
 =?utf-8?B?ejUvaHExN3ZNcllHc3plZ0JSbG9sMytzYTRwazBrQ0FWUU9tU2lZK0h3YVAv?=
 =?utf-8?B?RXpCZHZYUm8wZU82WGtBQm1sVXZVUTRGdzQ0ejZ0aVZ2SDAzbEZHMDdzcU1T?=
 =?utf-8?B?U3ZYL3VXTUhwaTJRUGhOWG5iNklJTTRYOFZpLzRyS1BqTExqS216UlIxaVN4?=
 =?utf-8?B?ZkxPcjFwNkVRQnlXalAvS3MwQzQ2WXhKSytmdU1tQ09zTzI4K3p0aUNESWQr?=
 =?utf-8?B?c25qajJaRHhCRFVqVjNuN0NCalgrK3h3bVYrUHZjMUJyWkZUd0ZpL2t4alk1?=
 =?utf-8?B?ZytXUFlPVTFvZldaYVNadW5tbm1WQTJwWno1NnByVlBqc05YWUlZU3U1WmdN?=
 =?utf-8?B?Uysxblo5TE5mTjR6S2NBbDMrRnlaL2RJUitsejlraUE4UTcwV1paMDltSk52?=
 =?utf-8?B?SmRtR2p3RkNUUUo2VjJRUVFtMm9JSHNwRllpQm42ZzhnNi9UQVZhZG5YSitv?=
 =?utf-8?B?MlpxTUdnWFFTVStBR3Npa0UxbEI4ZU4zeFU3VW5acHJ4RVJReU9hOUdjaXVy?=
 =?utf-8?B?TVRoZE1NbVFiLytTZlNId2VRMjNHUmlyN1VvSy9mYnN3Zm1GS2wvaWFCbHBn?=
 =?utf-8?B?dE5INGFSVTE1a0IvUndVWGNhN2x0VlhMNW9XN2lxK29NZVFQdE1XNHlmeklD?=
 =?utf-8?B?cUJxT0VwczloRjhoWVFRSmd5RlRMUnN6Nlc2UjRDWHV0bEluQ1JpdDk0WnpK?=
 =?utf-8?B?aWt1VmFaRmRKc1JxQ3dlNmtuaFpvM2d6a0xyMzFCYnlES2NBNFd4OHcvQlZW?=
 =?utf-8?B?OS96YkdEaU9adlFDRjBRQmd6TjBiTk1iVG8xWUxyQm9GK3hIUmIrOEpScHND?=
 =?utf-8?B?aEZhU3ZWcE93ZXM4a1hoRWNKdi9PQlJ2em95TFBHYWFDYXpxWXFMV2loYkR4?=
 =?utf-8?B?OGlwbllqa3NKYWpGZld5WjhyOWtMWnhrVmN1VGFsZ2VjQlo5UWdiTUVZRjFD?=
 =?utf-8?B?Um5IUHEvZWdxUUlDbStKZU1GWXZsQ21ja0taZWt6aE9sZE9qbXIwazBOSExs?=
 =?utf-8?B?MUtZUjltb2dRb1BqQWZXb1ZSNm9LV1FIMHFGdlhSc3pwcDh2QXRUZkU0ek9M?=
 =?utf-8?B?OTBwTXpxcmZoNDFUcHQ1NVBSbS8vQVgzOU9ObGdZNGp0MWxnSmtBa3NDd0hG?=
 =?utf-8?B?MzgxQUdjOHpvU0NJYU43bC9STUIzV09iV2ZCdUkxb3hhQnBJdm5MYWZzbnEv?=
 =?utf-8?B?cllwMndMeGlPQVB1SVhjcGJ1UkJWM0xXZ3FlYkUwTnlSVGtMcEM1eS9RUUFQ?=
 =?utf-8?B?V3dDaXNvLzljZU94ZWkxRUZMTmFtZUdzMG93QmtCRWo0aTBXaHR4V011LzFz?=
 =?utf-8?B?RnlNV1RaN0I1VDR5ejYzNW9yTHVWT0xOTkVJb3UxcytzdnJRWVFiNVJPZkJh?=
 =?utf-8?B?cmxTRWZTTk5tamU3RkJBVWMyZmgwcG9KMk5lRk9aLzB3UTZhQ0dEVHhiYnhC?=
 =?utf-8?B?OGNoWUNrTmxKRkVaaVNDR1RyMnV2TEl0dW9LV1krdUlGRG1YQUxqS2tXc080?=
 =?utf-8?B?d0FWMnU0NEJISCtsZEhkdjIrNmhtS2QvK3J4TWdLRnpPUzEydE5ZMjhCREQz?=
 =?utf-8?B?OEpBOVh2NzFUNFBIbS93TFpoeHRQWHo5aE55cGZ3ZUlaRUo3Q0J1S3d5NHc5?=
 =?utf-8?B?WTRaQk5LMVB5VTgyRG01TW5Lc2tZTGdxTHV1Q294ZDdyTWpSLzdYM1c2ZFgz?=
 =?utf-8?B?SGVzY3V5SXQxdkNTTFZJSTBNT05JSWNOcjVlREgyK3BNRm5jSWx3bm5IeGlV?=
 =?utf-8?B?UVVSM0JNYklTbzYwOUhvemg5WDd1a3E5cDFzOFhXRnIxcUo5cngwdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eb2773-2dd5-434e-2f20-08deac20d9eb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:10:22.9229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKhJQzhfPWTd37+e8FzaQPLdc1qSgX2ox+5FozlOww/WP1WTq4oRC+HWDYvA3wnsjZSmqOEIu65d0GZPXemXLwxbdHrtOBaHWihL+mlkpwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
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
> For consistency, remove trailing colons for the three following
> sections: ACPI, ALIST, and INTERCONNECT.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
