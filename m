Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0B7C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E0082B70;
	Thu, 15 May 2025 15:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XOluqQeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3B382B7F; Thu, 15 May 2025 15:26:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C2982958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHHaSnKebz1bVDhpd4yO0RBc7Ghm6PIhtXPI5h+8UCJWW/gG82kiGgRJPC4jsMra5k1aM1IynfUTy2WErgCujXT0IP8S0hNOF77r42JLU5jEXDX6gH/YWJJYCnBqiYyac4u78gktWWsbL4PuezaRyrgwHb+/xtkr47jFzAgYbYN55iZcQGrHnbGHO5qDeHVOaHtWQC8SdEq6FoLPk6WdS7m9/0RXgRCC5wtTc7brz7kcQQ3EzWdVZntDDQTgeamIhRMnpN4qhp1lQgB9EDoW+AV+n+dbHgKTqcnEmhtW9lZKCfA9FLdGrtEzpa2db5bylLtp2x6cN+S6/HtP26N4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96GsAnUM9M6YISbHxurUAEGBN0/ILvIL6ixkiJJWa5M=;
 b=RrrhwXaUORe9BD9Es3NvzoCjeBxpRvznYwn8vPySwtAYaTMHcq4sLiXMbUWZX5FiVo2YFNTOl4cevua4DPwj8Qj/EgQMhalBG3c3FlHk2kUov0AOgl9glEIRAklLEDGUr0Ug506Tn8VdyGV++r+K8keicj8rnODuEg8Ewf+QIcN3n0T74YbkWJdkgrb0QYrQmHY0TfIu2XrGzJ09D/xcEDHz96VDmbiaIKx4sDMJt5eo8yas1/Uz0XVnLxrvAFt6bF0vcHCY6VjRERFZyW2dHYU63aWyizcP9P7qSW9XIXG1oUcn0WIwoB3WNBIV4uXK5aWHM8QTeO9ZTxsph5PYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96GsAnUM9M6YISbHxurUAEGBN0/ILvIL6ixkiJJWa5M=;
 b=XOluqQeYeCtHdIMRoXCG4gVZxDQp1tXhfAOpXGKjhek33xUVMPLWz5TwaLChQ/T5raOz9/EEHnruNn9R/xOMZujmxIDUA612idG8TBIT8lDsZCMb64TKsMAVYo2V6hu4ZeOjP0GNpl1c47oGNHNKTz4dFoz8nX/rsyIIrnUCeyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 13:26:20 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 13:26:20 +0000
Message-ID: <257158ee-7496-4da2-84c1-6bc74965cde0@cherry.de>
Date: Thu, 15 May 2025 15:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] spl: Kconfig: allow to enable
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR for i.MX8M
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Anshul Dalal <anshuld@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515131246.784206-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: e655e017-bc6f-496a-6447-08dd93b41465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1dvelBjeHlySmxRS1FlWVBxUDN2eTlUR2RVRHBTb0dMNENVQ013T3g1aW13?=
 =?utf-8?B?NC9KRStmTy81QXlnQU9HcU9OVjQxYkkvWHNWaFE0OXBlR1ZOUnM1UEtYREpN?=
 =?utf-8?B?SVNySk4xN0ZFV0swVzNGQ09GVUVDZFBUQ0FPaVJiQUZLZzJObmpLNlBnVlMr?=
 =?utf-8?B?SHhUQUltdkVhbDlLckl1aWhlUWhTVllzRnZBVjFpMGR1YTJ0N01aSEdMNzh1?=
 =?utf-8?B?bmIrNDVOdXN4M3ZHS1RUOENQaUN5V2Fqc1FtcDhWZGttcnBWbTBzTytadWtU?=
 =?utf-8?B?czlFRzh3WCsyQWdtOWZnLzV6bFpoeEpwUHUyRVh2RjBYQTN6cUtsQ20zdGx6?=
 =?utf-8?B?VmM4b25QNkoyZWVqSkk3ZEs5dWFNbDBxMWFVWlhiSTMwaFlrQzFjQnd5UXl6?=
 =?utf-8?B?WDRSK0xsRmMxeCtXY0ZBakZyRXo2TEJYa3k5NXBCKy9TMkQxN1BLRUswYU5O?=
 =?utf-8?B?SnpCa2paVXM1ODVlYWRCb05IUE5NNy9uaEdVT1MxUTFTZlQ0NEtOMFBjSGZL?=
 =?utf-8?B?OWtYV0lBOHI2eGU4WFBobnpDS0pRVjhyR09CM1IvY1hFY0UrT1hzRW9rWjVx?=
 =?utf-8?B?VldKQkRwZGdocWR0VXROY0xZejFwSW9LdERiUEdLUXhCRjFWeDlDNWZBeitE?=
 =?utf-8?B?Q3lBVmV6cnp0clQ2dW1ud0pDVWpKU21NQzNnL2hxSkFycGZPaVVIUklXQ1Jr?=
 =?utf-8?B?UUZmUDI3OUwyU3d5ekdzcG8vWFZlcEtQK1p2cVJTNWZpNU5TS0FZZmNJcERr?=
 =?utf-8?B?cm9vNmRLd1g1ejl5TDc3d2lXc1VRSkJwSS9CbXFTSUREMENJTVl3dS91WHBo?=
 =?utf-8?B?MWZHYWhjUDdETDh3allvQmJXdXkweHRVNVFqSE9QRXhXT0JLRVhLQkdtUm5Z?=
 =?utf-8?B?NnQxN1RSeVV4Q2Q3c3NOdFU3QjhLd0JJckFYdjhuK0dObjlnMnFlRmJ4aGtJ?=
 =?utf-8?B?T05INDBCeUhYNmQydHZIRkF6OGg1VGdEaU1Hdkdadmd5RWNocnJuZHB0ekpP?=
 =?utf-8?B?N2YwSFVMY3hPUFpqbHAxaW55ZVR2MDJFbVc4UkNvbTZjczBkdFppUUp5M04v?=
 =?utf-8?B?QktKSHhCWWQwRFpZaEJZTmpXMEd3bEhiMyt2TS8vZGRYbWxReGJ0SG9MU21T?=
 =?utf-8?B?SVVwdEFIMDhtbG1qQlBPQXBUbkIxTFp2b0pKcDQzL2hhTGVSREdTVTAyOTZ3?=
 =?utf-8?B?ZFh4RFpFK1VnMUJjbVU1Qzc3WDJhcjRGNmFPWXYwYlczSCtiNTBKekFnTzI3?=
 =?utf-8?B?N1drVFQwL1BKMGhRbWZqejNuMzBOVEZ5Z1JNZmpqSTlaNmZ2NVZ3WDRWYWU4?=
 =?utf-8?B?SHlsQnZjbVN4TnRHVE5sWWtBd01TZk90OXhxdFo5eFhBMXllQVFiSVpCTXRl?=
 =?utf-8?B?S2VIeWNuM3VlcWNVSjBOcUNOK3RnL016TURHbjkzSzVCcTA0bERSSUgxODF1?=
 =?utf-8?B?SVRhNDdCRXJQbGFia1B5L25OVmpMeU9YcXl6L0xOTlVhdEdUK1drdmhMdWYw?=
 =?utf-8?B?RGdGOWlmd0tGRmJQWFBwdXVUUE92NXZDU2NzK2xra2dlT3hZUXZNMFFhRzRm?=
 =?utf-8?B?V1VTcThOdmYvczNBRGxxc1hveEtFVERqeWUzOHpWZ3NqcStFUncxdkg2Y1Iv?=
 =?utf-8?B?cnpoYkVLL2ZBQnVlWUFnK0g0anBXazRmNm9ob2NJRXRmclZTWWZhdExXMitu?=
 =?utf-8?B?YTlGOENyKzA5SlV6Qm9zckViVjU1alJGVXJnblN2dWhISFJGeTViYUNyaWJ6?=
 =?utf-8?B?aHZLbS9MRVdWNTFtZkxMMEtTWUJLU24xR3dJUFp4dzRhQVVDcFp6V1ZJem05?=
 =?utf-8?B?MzVIR0MzMWRuVnRkRTFpdDFhR3BUd01McXRqeGFSOG1SWiszYkxMVWtzN1Jo?=
 =?utf-8?B?STNjQ1owL3ViSnRETzdxZ2JvT2xDaVh3ZTFwKy9zUUgvL2RxUEEzbUFLL24x?=
 =?utf-8?Q?5FJBIaLlQow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzkxS04zcHBwcTlZREdDMTJobVpKdXRSVTRoUE1DVnlVQzk5K0lKMCtGWGJq?=
 =?utf-8?B?THZvditSK09FV2pkZWtHQ1ZRamlGMG1lcXUxSURCN0NKdmxrMElPdVBaVlhE?=
 =?utf-8?B?ejl3OU90Z2xZMWJFYmNuMDZNbDg3R2NlQ3hrM1FRM04xMWhBczFVbFZEVThq?=
 =?utf-8?B?eTFhUHpaZVh5VnlUUWlENGJrKzVFNmtkZS9zZWVISDMvQW10dGdsekdrWjNp?=
 =?utf-8?B?Mlgwb081Z0d6eUZFYUg1VHQvMjQxdjNJQkp1MWYvdDBpWFVDYWRBWHJNRnNj?=
 =?utf-8?B?VXFUTGhWL2lwV09LdmhsekxaNjh2bHV1VUpTQzdyYmFvUlM4YUNvQm5PU2Zo?=
 =?utf-8?B?MG5aZTU2SnVwZ1A3MHlzazdRNmprYnB2Q3N5Z2UxbkdjelExMDlsb2dsMUp6?=
 =?utf-8?B?ZGRoaHgvUlUxcFVIbDBUaEtNVnV6dklhVlBDOFJJUDh4RjVsbGFGSndZZlNO?=
 =?utf-8?B?RWE2Nm5xQW1kQVd1dUlFUHZSZVlKRUdYVmlNbW84M3dzejJpODVzaDc1N0FH?=
 =?utf-8?B?cW9Zdjh1UXE2akY1aDhnc3Z4cnk5Rmd0RU1Xak1mZC9IVlJJdWpHK2oxc2hq?=
 =?utf-8?B?clR1b2VtNWdXdlNBeldFaUFXaXBCZDMvbEtxY3pIN1dLR2RzVFhiN1FxNDNt?=
 =?utf-8?B?eXpNVW9BemRKTUQydVJFNEl5UThKSGpjRERWNGw1MWNNOEd5QXlJcXMyUUQz?=
 =?utf-8?B?U0NoWTIxRm8xWXd5Yk9zQjZJcUU1cWU2aFNkaGZZTFFOeFhPcmNObUNWWVhJ?=
 =?utf-8?B?c0RmRVd3TlloeG5uM2NiZmtQMVFpeHRic0NXREJ1cnVwTzZkMWRnbDlSWHZh?=
 =?utf-8?B?TWJza2NVQVNQdUhmTnMvS3VFOFVIZFcxQ1FnaWlVYVl2SlgyU3lRcGdFbFpE?=
 =?utf-8?B?NHl2QkdlL3lDTzU4WWNzVEVJSFBhUVAvVzZyenRCaFJ3ZmRHVlcxTVNhcTdV?=
 =?utf-8?B?aTlldWJacSt6RlhiT2YxMTZ0VVhJRktCdE1aQ3ZCc3QyVldBc1JuSTFCWWRh?=
 =?utf-8?B?bGYxSVQ3aDFiaEpMY3E2eHpPMW0yaXZmaENJMmFpNWpPaWN5Q1NxeUdQaW1X?=
 =?utf-8?B?MjJoOWt2Sm1PM2orVlJoeE55V1h0RTlBck5mb25FOEpGOUIrYkc1VUFMRU5K?=
 =?utf-8?B?UGdNY1N2dllXN3pyUmliam1YQ2tPQ2FqSW1Kd2JoaDJIR2E2TFdCUDMxcXpx?=
 =?utf-8?B?eEVOSmFYNzFMaUNhVnVneENDZTZ3VGtISDdVSVJJSlJsV05RQzI2czVvUHda?=
 =?utf-8?B?bUFBSnJtSFUxblZPZEFMWDVzQzhFMmtCYU5XWHU1OUV3dkFXb1NJa3pQNXlh?=
 =?utf-8?B?S0E3MlhBUHRqMzBWODNsOGxYMUV6VFV4QkxkLzJ4c1VVTFp4OW5yb2t2THJ4?=
 =?utf-8?B?RS9yVlJ3NDM5bFFtT3ZkMjZuMWtpc1V2RUhwTHljMjFqKy9RU2h1Z0t1K0FQ?=
 =?utf-8?B?cXFCbFh2RzdtY0ZOMWNpcE5mZkhIVWNqQ3Q4ZWdaNExpbENDQkhxbkh3WnBr?=
 =?utf-8?B?em1NUFB2YjNGVEhUbVFpZ1IxWVp2OEpDSnNrZ21JaDd6cVpRcGcyWllTRmtW?=
 =?utf-8?B?WVpCcytRQ1VldzAxakNWMmV2V1lldHN0N0lDMEdhUVYyak11QzNETzhta0hi?=
 =?utf-8?B?RkJ1WlBOWmxya1BlWW5iMUV1MnB5Ni9mbDMySG1qZktCd2NUeVh4R01pMURq?=
 =?utf-8?B?RUZGRzNwS29IdS91eWZyNEd1YTZnRFJRZTZKRE1SRVlWSCs1ZlprWlVzZ1BD?=
 =?utf-8?B?TGsrK1ozYWwrd3ZiOFdnVmhOaDFkdnJ1WEJ1cVo1REVxWWFrRDBpc0NFd0Nl?=
 =?utf-8?B?ZXJUdUZUK0RlWDFnNnNFSnZoU3M5K1NLa1oyMGZUalk5cDJPQUNSN3hCeWFz?=
 =?utf-8?B?MWw0a2pCRlk1WTlIRXdQV2MxOVNRT3d0aHUvV0p5QVdqaUpyWkdybmxjelBx?=
 =?utf-8?B?c1U4UWVQR0ZDUkpvVmV3RElqR05ZZ1JSOFR6bGdRdHpJRVhxUjRTOGNicjRL?=
 =?utf-8?B?V1NsZ1VaZzMvQ3hLM2dac2pzaVh4WFBrd1dheHpFN1gyYmoyZWNsYlhwU2Z5?=
 =?utf-8?B?NG1ISmlKVDV0Ums1MWJ1WnkzVmF3UXRhZjMybXVFdldjTDRIbTVybXg0SkU4?=
 =?utf-8?B?VEp6eFNjMEJUUFZZQm1lb0ZTSHJJWEVRM3FSRXNETHY1WVh4MVFLZEZyYWRP?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e655e017-bc6f-496a-6447-08dd93b41465
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:26:20.3669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAeQHcEhxkQA3kZZ6abr8jyQLruGV1OJOuYDzcvyRKqvCqSe5vHGJB9FIdo4jDprGYgKwKiGhjjCAh/Jv/69bub3ZOumxiWZ8R4MTuIsErg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153
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

Hi Dario,

On 5/15/25 3:12 PM, Dario Binacchi wrote:
> Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") breaks
> the boot of the BSH SMM S2 board. As stated in the commit itself, "Some
> boards use this value even though MMC is not enabled in SPL, for example
> imx8mn_bsh_smm_s2". The same commit makes SPL_SYS_MMCSD_RAW_MODE depend
> on SPL_DM_MMC || SPL_MMC. With SPL_SYS_MMCSD_RAW_MODE unset, it is not
> possible to enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR, thus breaking
> the board's boot process.
> 
> The patch once again allows SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR to be
> selected also for boards that do not use MMC, in this case on the i.MX8M
> platform.
> 

Why would you use SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if you don't have 
any MMC? Shouldn't we rather fix the incorrect usage of this variable to 
be something else (or better guarded?).

Cheers,
Quentin
