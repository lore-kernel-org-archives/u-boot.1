Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF139CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C704D84A3A;
	Fri, 19 Jun 2026 16:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TvXzuRqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC28684A3C; Fri, 19 Jun 2026 16:48:58 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32F8849BF
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWyApwqccS+uP/d/algA7ujC9W8b/R5HOGTqX2pWHLVYTSade0lSgd0Q2brlIgxcuW8XPKMM1sWQ+G/fUVy7hV6KlNs0jTdasYmfpDBgAoinFdBvzxS53qziRkIUvT/cQjhGPeRJ0/I8ywqP7whD1GUlCt3hmvhhn4WV0AM6i0Ew7Vgj8EG8Jpa2CM2Vqp+tq1i24aoNMke6fDTF6Q9TOuC7QNgojxUqXiyZYgXIK2Q4sGW+QpIpzGGVy1khs0VcpsNJ/E8yw5RaIPu4mxKZSTYByWBZWbA6dlsoHqXwg+6SjbLLl+VwuE6V0PsmItLcxZBhfSIQADzg4xtozeWqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZwr1/puTl8JtFTBxkcDhf0aVlesGQ5lqACb/cI5Dxw=;
 b=IR4Qw7Bz9vRTtTf81tOT5slG+JPFbQa/04X9k1Yv+xhCpsnpo+HI6FLKR54fkPG/T9vTbOdYx41/S98WqHoEl72uQMLM6UVqTzZBMEJi/f+NxaJocTwRW4L58vFACxk75VSRgmikKRzCEri5jJS8j3rKEVO41ISLtqwq/u8iLlcYJ9jONv+PJ2uobTn00/1gWE1mQi6/K32OWMPy+2FFeM9/poykEkLXq2SKMcfXnlbqJn1yVi4HNLzXbSxUGM3e1Xpr4CUFQ9DE0S6zGbcgaO1DZcWuSvR500zxsIDaupWTULkb52UcvvSLR8twsITouSuANXcX72pT/ZG0uL1itQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZwr1/puTl8JtFTBxkcDhf0aVlesGQ5lqACb/cI5Dxw=;
 b=TvXzuRqGENSTATeEi+QPecU4gkRUsb8Z0TbroNoiXTLK6YqRSWeDIMiOA1ezPoMoTFHmYA2ftfR1xJl5pCfJJIOePgB1kjaiJ+k9NDVsYpoODcBbT3oXdtXGvBIPLkn7yK/q7YTujrQIo1oLSgMnYj7c9PjwMNnvEDKaU5NIIcB0INhKFctgC0MhvzrkEut5Z3jm39jmvHgtBHHJo2Me3QvDyDhid/PmzFa8B+M5tdBkUwCR9MlZdwDWPBTLK9SbPxIZvsglncl8w3lM/m2wUj8qvkpjld8cIoT+rScWKqQCss6PB+afQEhWbv1jClc03rLZBQheqCjcJhEnu8PBZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:48:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:48:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/6] imx: Add env to support compressed boot
Date: Sat, 20 Jun 2026 00:06:02 +0800
Message-Id: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpoNWoC/yXMQQ5AMBBA0avIrE1SlVTqKmKhNRgJlRYR4u6K5
 Vv8f0EgzxSgTC7wtHNgN0dkaQJ2aOaekNtokEIqoTKNPB3Yn2icW1EUulBa5qbTOcRi8dTx8d2
 q+nfYzEh2fRdw3w8DTPXUbwAAAA==
X-Change-ID: 20260619-imx-gz-boot-07976923bf93
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: d98f1303-e96f-402d-d133-08dece11e240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kE3wRMhhMLWwvnObx73xjvsFf1424NQJPmS3UPRIjU652jG+1QEr1tg4QRRMSybtHdQ1VNddVvYJXjrEHRWOdaE11sqtxppxpRqkvMj4t7T+jj5FgXB16OkNR23eed++oB3K5sUkjH2Ph27KPOKZVYOjrVO/Ivuii5jtl8ZaA8RHgGPs8d+7429a/mZ2dyrkOJKMT21Bg1feaDYT+KFbkJbfSNLhbfeEzBw6wU46caruE+h69ZJBrCYlp6neX27pzdXc0sr02dT+qw/Hui3hMJxGrjrGBfKr16mxsPnJS0Ncb2WgD7f7wwde+hEz4HSBy0ECFxMr4up3w/2W0aRFSs5jd5ca5JxNfinXuANF1nbLt0YO/TWIDbYgeag+mnQGNPMzfwdebUuHFr6kr9qQPK7KRbp0FZLbH+OcyJqtxrorG7Lx/Eb/6rvVNkQCqVqMBpEL4SFBofEcFQngc0/BY87BgoaNA/430AQzlErXANaLlbQd8CTlw3vTgFQm0JCp5DFh73W0QPUUaxNv9kYnBh0n7HvMyq9zRZQIXeqmXuIwPQ0lSFbVW+uzihwWhIgCv50xRp9y5SGq/pwiYZpKwUsDSLjKmqdw2hnkoo5022dgKWKJsGXcO2pj+dwAK87mEAdHgNj+Ug0X6Cb45KrurLB5PTvBV4Er9B87ktIf7L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NhbVJDR3RkR2xYZDBaL3FETjR2ekxGN01LV0xkVjV5YkxDcUZwMStDRjVq?=
 =?utf-8?B?VnhvbE85ZHVqMk5aNm54dy9XZkVTTG1xcmEvbXZ3bzdkM0F0bk5mSzlYU1pk?=
 =?utf-8?B?UWtxS0hHUEc2ZTBUcTdiZlFhNDh2TWhLVDcvbzlkYkdXNkZCNm1ZaHZ2b1J3?=
 =?utf-8?B?Vmh2dlpzR1IvQnBldXU4eGlxSWpUeVk2MlRmc0c2akRGd08vTmxSREhoRU9x?=
 =?utf-8?B?c2lMNlVNRTBrbCsrclFsdTJDYjhGOGlvd2dEWUVja2YrODR4SGNuVzFZYlJa?=
 =?utf-8?B?dm5MY1ZTOFJxUkVMVnNxSDJ2TEw0SitNN1c4UURnMXRwNXhSRnhBbXV1ZXNn?=
 =?utf-8?B?Ui9BNnQ0Ui9ObFVITVlFWFZBVFl1bWJsZVEwalhXS2NrTzF6SnFwcnU3UVRn?=
 =?utf-8?B?QzFVamhUdTJETDRNWThyTXNOYk9wdTZuUCtZUVluNVkzYkRhb0k3Q3F5R2Vz?=
 =?utf-8?B?ZDdBUHh4VWQzaVVsZ1kwN3hwcjcydnZjbEJkYlV2a3pHQjRyWUF2QnQ1SGwz?=
 =?utf-8?B?Vy9OWHFBZGdKeTVYR1pEN3hialZEdWxjUGowS1Z1L0xsaHdoSWxBU1QrSkQ4?=
 =?utf-8?B?TUVxbkloZm14M1RzSXJFTXNidGlTRGFGMGl4OW5IcTNoMDNFNnorSld0SGts?=
 =?utf-8?B?QVN6cDZtczZFRHhCdzdQeUY5VHlGaGZhRG9ib1IzSlZUNHdkcVBib1d2eHJG?=
 =?utf-8?B?Q0V6cDNNQ1lJZHR0dkYrOVc1NnNST3U5QUJ6NUUxZlBkcWw0SDFzV2x1NHRu?=
 =?utf-8?B?blc5S3BIVFM2OHQzUDFjNEJrMFJCZGlxbk9SWTZCZ0YzbmM2RnEvbTdDWlBu?=
 =?utf-8?B?M3BLQ0NldEsyTlNJNk9iS0ZIZ281TUlJc29nc3BiNUF2UzRSbmIwdDZXWWlu?=
 =?utf-8?B?NlZJODdQYXovRVp2YUNVREE5ejhNVk92b2Y5OUM0b2JiRSs5SjlFaEZkOG93?=
 =?utf-8?B?MHlZVytpbFlSUm1rWHM2QVhpSHNMemg5Zi9TeEZVT1BnRnVqNmt5aHJ3bUpu?=
 =?utf-8?B?MWl2em1wQmVpUktXSGtHQjhDWXV3aDFTSnUvWi9GNDFiQktUaU5sSElJOWo1?=
 =?utf-8?B?NlRESXBUbnEzelBvc0RjaHM2NTBzOUN1djhBdjhiRTFramtWMGU5TUNrRHU0?=
 =?utf-8?B?NWtkRy8zU0xKRmpudGR6aXRSRUdiZHJTRyt3V1VZMDNEZmNkTkNhQXVLNTJv?=
 =?utf-8?B?V3N1eEtWamIrSnlveFBhSHhNRVNjeXdxWGZyZE1IMVViaU1rOEhaS0U5ZHI3?=
 =?utf-8?B?SnU5RFFNdGMzZ0M3OHRhMzZoL1pHOEtwS2ZYcW1nQ1VoVkFvVklvQ1o3c2Qw?=
 =?utf-8?B?TnN6UEdKdFF5QXU4UzR6M2RnZ0p2WTAvdzZ2cGlnS1J2cTVCeHVVWmU0ODdh?=
 =?utf-8?B?YkgrOXZqbytyWTkvVk84OFFKcjdJazZmVW9vdlV2SkZGUGcwTzJmREVoTlo3?=
 =?utf-8?B?VndIdm5XZFlDYXRXbDlhUU9YMTBrYzNtcjlzbWJXeVlOM2Zya2QwNGtoS2Vi?=
 =?utf-8?B?cGNRSjZMQXhJVGxRQmZxaVRpM3FjMGw5RlFoVzhPNVZncVVtdzl1NDNOYmdG?=
 =?utf-8?B?aXBEY0JwL3p2MjJMYmxHZnVpM1dvZXdoVTBOSFcyd0tQNDFMcEM1TDVLNGxh?=
 =?utf-8?B?RmpDaEVpbW02Nk9URXZLUUFiU1FJaGtwMnVoM0VaV1Q3RVBzSmNkQWd2TS9t?=
 =?utf-8?B?NXhhK3E2bW1tQmJSUGtVN09ubGtMaERyRGtMTmF2NDNpQ3FhZ0VjNmFOU29y?=
 =?utf-8?B?N1FxdDBzTGRSTy9LeURCMVNveERBTVlHaWZCTnpJbmJ1UTYrNDZyZzB6MVha?=
 =?utf-8?B?ZC9GZ21RazBwSmdJakpLbGgxcE9GQXNHYWpSMHpVcEpTNEpPb21qTHp0eG9W?=
 =?utf-8?B?aEZUNnJjWmtaK3ZmUVBqdXk5RWJpRkg3YWxtSlFObWY5ZGt5MmZXQjE4NFNy?=
 =?utf-8?B?NTRIc1RHNGJmK0VCbE1pclJsbzNpV3FIVTJVMERDSE5yQ3VaSnpKSnUvZFdh?=
 =?utf-8?B?NllkVUhOZ1RWTkcyMzZhd1hoSXBNbHk5a1lpbmZzSUliTWw4V1ZBUm5NWFB6?=
 =?utf-8?B?ckR1K2tBUkx1bWFReVJhOWQzaGRFKy9sSWpkbTRtMUsyck9HK2FNSENnR1BV?=
 =?utf-8?B?WDJjYU8rM0hBQmhiRzZMZ0ZMdUx1YlYrUmNHNXNzd1IvY1pXMnRMd0dnVHR2?=
 =?utf-8?B?ay9rNEhESTNWU24xMGVLVTRoakxnU2pNVENpa3pSYlJUd2ROVkFXOUs5aWdk?=
 =?utf-8?B?VmFHMWI1V0FMNUY0TjAzdEUxRGlMMTNBLzJoZUhkSDZ1c200QWF2eG4xbzdX?=
 =?utf-8?B?QS92QTM3azFmY215TURYTkFWbi9HTEx0KzVKbXFxc3Y3bEp2cDRaUFhLa3Rl?=
 =?utf-8?Q?+OfzYuRxx0vdBMQFWs49OgCpxkzu1EhKtVYly?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f1303-e96f-402d-d133-08dece11e240
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:48:54.1083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k87/W2pLfyLH+TT9NfQS659klWIfnuVxr1Ww8Jhw6M3prM14zCeAd7paxVkcDGQnB0Q5+H7HN45xVamHjrqW/vZotpKCCW7k69q/52nYEs3LwTyrtJYdVv+BQ5g+ml6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11827
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

Since kernel image is becoming quite large, enabling compressed
boot could save loading time. Only need to add kernel_comp_addr_r
and kernel_comp_size to support booting Image.gz.

Some boards loadaddr is not 2MB align, update them to 2MB align
to avoid extra memcpy, because TEXT_OFFSET is default 0 for ARM64
kernel.

While at here, the last patch is a minor fix for i.MX952 fdtfile name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (6):
      imx8mp_evk: enable booting Image.gz and avoid extra memcpy
      imx8mq_evk: enable booting Image.gz and avoid extra memcpy
      imx8mm/n_evk: enable booting Image.gz and avoid extra memcpy
      imx93_evk/qsb/frdm: enable booting Image.gz and avoid extra memcpy
      imx95/952/94_evk/: enable booting Image.gz
      imx952_evk: Correct CONFIG_DEFAULT_FDT_FILE

 board/nxp/imx8mm_evk/imx8mm_evk.env | 2 ++
 board/nxp/imx8mn_evk/imx8mn_evk.env | 2 ++
 board/nxp/imx8mp_evk/imx8mp_evk.env | 2 ++
 board/nxp/imx8mq_evk/imx8mq_evk.env | 2 ++
 board/nxp/imx93_evk/imx93_evk.env   | 5 ++++-
 board/nxp/imx93_frdm/imx93_frdm.env | 5 ++++-
 board/nxp/imx93_qsb/imx93_qsb.env   | 4 ++++
 board/nxp/imx94_evk/imx94_evk.env   | 3 +++
 board/nxp/imx952_evk/imx952_evk.env | 3 +++
 board/nxp/imx95_evk/imx95_evk.env   | 5 ++++-
 configs/imx8mm_evk_defconfig        | 2 +-
 configs/imx8mm_evk_fspi_defconfig   | 2 +-
 configs/imx8mp_evk_defconfig        | 2 +-
 configs/imx8mq_evk_defconfig        | 2 +-
 configs/imx952_evk_defconfig        | 2 +-
 15 files changed, 35 insertions(+), 8 deletions(-)
---
base-commit: a0a1e9f2f1dffed04ee52723ce957c07bb905c25
change-id: 20260619-imx-gz-boot-07976923bf93

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

