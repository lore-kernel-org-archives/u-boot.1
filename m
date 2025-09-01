Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4EECA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1AA583955;
	Mon,  1 Sep 2025 08:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JA1G8vHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D242839B7; Mon,  1 Sep 2025 08:33:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946E08399C
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu424PSUyifw7RV2Ao1yUILo3FGRXnBzlCDMwqDcqjgZ4kdqvBW4r1PiEkMse8X1SKIrIKSPUrTil3P8KjzjrPuNeo1nGqiEAyFZ0r35iGALs8Xu39d4WZDxDVn5tG2x4NUWxV7oPzIHcDpBfQeiWjRpvzPxkj30ebcwIz7UbeMKsGxBd1Cw9xyLLlqpZrAMSEOlWXL+3yFKyMWaBwMmGrS4jVltGDNVdegv7s4DTdYut8G+H4UGdxaS3K7LhDTeJUAMdrvUUqxauwAOFB43UkciQlZa2pEZeSAt6OE/fTYdlEDq6Q2CDEqfNqubqhLt2o4BDzjP6jsJPIqbeYrFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY5h1n+BKQH0YmpKM3F3mjrBCV3fZXkN8hd1P4xl9xw=;
 b=e4SxyDkkFrJzJpCHxe9tEt3lTGIORFqHhrJ0NE4L+SNoddREAM05W9RdDAp+EDOcIYKlFtqzV1R/N/+yFxKZvlyavNyY1QtRhmJDaOh8dIsawLQVZxkFRCcPjQzpiEVPShsbgUhxp6VdaDzjpeULDrIcs5+SikixGs04K0Icm73WCkWvS3DZihoBbeEGdviQNGtaI5q/fLgQYRwvFKS34l5pDhkb8oSXNOx24zJdpErzPNQlob1Z0GLw6LDUtxW0IPD+zdCUfh8wNL0eDOMt/bgmBV4GB0/5Oc7boHxltuxB0fREdXTxk1AifCgqXysgQzrnlCkAhab4tDD1pcknbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY5h1n+BKQH0YmpKM3F3mjrBCV3fZXkN8hd1P4xl9xw=;
 b=JA1G8vHcMlug/kVxNcYlj1aHUGj9gS4rTUd8fAZ0WmIo5Wcjh7EjChiP0KJtFUJ7OyKuh5dzUXsVbn2nH3PGvFb43TFSEtOu9aI+Pb4YtKOFRn5M2x2MwGIo08qMlz3p/dG6lwHhe3WbO9Fe/rU+Pu4NPyFlo/1SBhhsJ4HNBBrfBa08ugtfBuw31uTH977EpbYnOoU4CKXI0e+EZO+Ym/fKj6iUkCRgx3J3Ag9usMNH0AKNHvFXuSLAzP0YlgorpLTxBB1P1Qu6SKQWA3isl7CpYTsyxfZrjb8dEtyg1y19L427q/6P3q+L76zcE5eDl+vsWGudLqrnp27aIYgYkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:33:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:33:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 00/11] power: update compatibles for PMICs used by exynos
 devices
Date: Mon,  1 Sep 2025 15:44:08 +0800
Message-Id: <175671244825.14594.896251953048052795.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d5e883-93d6-4cea-a1a0-08dde9216c2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHF1ZFdHdFNBUWJWOVJDdVBldnNvUUw5N2JDVlU3YlFUcUJJVnRFRnBjUUV0?=
 =?utf-8?B?c1l0RSs2czN1eWxvbGxoVHhvOEkwYnA4azRiU3VycUV4ckZTS0pxN2NHM0ZC?=
 =?utf-8?B?cmV3NnMwVmlrWWowNi9OTDRFeFAwVW1zKzE1U1hCYUhxbG1tM3diWmc3K2dp?=
 =?utf-8?B?TzQwVUV5R3lmWUM2aHlHTkFpM0xxdy9DTTFudmcvSlRIU25XcXB0T3M1aHlZ?=
 =?utf-8?B?Y3B6Q1hYLzVRaXRoVFh4eDBZenhOM2QzVUlHb3Z0TG8zUE9iM2JWcTdhem53?=
 =?utf-8?B?RTZHaXpMUWlzUW55dWZRWHhEbUxpZnh6dEk1RDRVR1BYaTV5eXJtNG1mRVV3?=
 =?utf-8?B?dGFRaDBjWkdOK014WklNLytrOG9nN3ZwY1hIZGpHMEVRbGpsTUFOT3poR1Bs?=
 =?utf-8?B?RlRrNHBiWkZkS1hYYkttSjZ2dzJRWDdXUW1FdmRBVE5iZUNUV3VxTTBOdXZ1?=
 =?utf-8?B?MmpDTi9KbURQZERNTUwreW9JdEN5eUZ3NjNoTHUvS1p1MmI4b1BzYW80ZFYr?=
 =?utf-8?B?b0hzcmh5WTl0Q1dPdlIwbnJlbkhFTXh4cjIvNGg3R0lMcHpIaTM3aVZDUzZD?=
 =?utf-8?B?K1BPN25hODhBS1YrSiszTUd3UlRtUEVuWEpnWVlwck44MFA3eURHalMvY2VQ?=
 =?utf-8?B?TmxWRTN6L0xRbTg0ZWY5dlFPZkE0MW9PS0UwbytXek1UQURZT3RLbXNRWHI4?=
 =?utf-8?B?YTR6MWdaTUQ1bzl0dGVvVDYyKzJjeVZoL01MTVh0U2Fma1Q0UXRpTG1JR1VH?=
 =?utf-8?B?NkZhaCt2Y01DLzY4TGw5WGhkT1hnV1NFZXZjby82cVdycmZham44NG5oK0g5?=
 =?utf-8?B?NVdCZFhlMnRmbXRQVEFQQnhRMkFyakd2MVlEdHF4b1AvdnJrMDVtL0xPNFhC?=
 =?utf-8?B?R0tEL0JEbmlNRy9sZG05dzlicHk4YklKaGVVTnZJcjRvZmZEREpIWnAydTV6?=
 =?utf-8?B?MWNVMXZFWmFyamEvaVAwQmdKQ1FDTkh5WVpwbnpvQUd1WENKUDdqdU1rZUp1?=
 =?utf-8?B?QTFEOWdFR1VFbmw0M0dTd29kMWVJY0RkUitGc0hxQ2FYaWtOcHlNWFVCekpF?=
 =?utf-8?B?ckpLWktKRmVvbk90dkV5RjJReXlEOEp6MVRoL3ZxdDVKUDFvcEppcnFsaW9S?=
 =?utf-8?B?aWZoTEpYNDMzUE9lTWplYTFNa0VZSjdFbzNxTWhXSFZlWjhVWWh4Z21Gc0lw?=
 =?utf-8?B?NkdyRGlIVTl2UU9ubk1jbFM3b09HakswVytHMmdTTExhcjdJWkI4aHNKUElE?=
 =?utf-8?B?a01taCtiZG1CUWMyNWZZZjZ6V01JUWpZNFhCZmJWQndPc241SEJheXhNUUJC?=
 =?utf-8?B?M1N1cU9zd2VidEg5WGdlT3lsTERBRERPYWsvQlFkTzJ1dCt4SU1JdFJleVhE?=
 =?utf-8?B?SmZVNlU4Nkd4MzNLRC9hRG4xak1SYUhjMStjV2ZxU2UvYkVYMWZLb0tWR1M3?=
 =?utf-8?B?MUhnMGdSMitnLzk4TkF2T3lkQlNwZXM2WkREdHBSTzA5NTM1NFlGUFVRU29E?=
 =?utf-8?B?VlltaHhCUkxRYUJ3WlVDT0UvZEZrOXBRd21kbTcwVXdXQlBiWE9XUzVrNDln?=
 =?utf-8?B?bGdnditHTm0xb3VPcjBqM3ZPQmRPUldzOTZGU2c4Skk0NHRzOTVRc0V3K29J?=
 =?utf-8?B?N2dkM0ZmL2lxSE5wUXgwSlFFTDJ5OThZZ0lCRTFzZDFuenpnMyt6bGhvekxz?=
 =?utf-8?B?ck1zUVFGalQ4M3ZCZ21hbVl2dStlZXBreWRWRm9OUFRoTnVPOVZ6eWZPK0dz?=
 =?utf-8?B?QkVoVXkrK09CQ0RKOHN2QUlLaVR6RmNnSWcveW9kVXFsbktPUjB6S0w2Q3hh?=
 =?utf-8?B?dDUxbGlBelh4enRiSnlmaEszQTFiMzJSOHVhektHSHB5ZElvTTFoTmVlcmNZ?=
 =?utf-8?B?RElsb242Nk9Dd2k3NDRiNXE0RExjUm13czdVOFhJWGxBdVhORUh0dlhsL09l?=
 =?utf-8?B?TVdLRkVJU1hnWjc2MUF0cGFzNkZ6djlOYkk0b25ZRXo3bnhEbDRtczBHOG0x?=
 =?utf-8?B?WjhlU0ppVHpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU13bnUrelJPaVRVYWRXT2ptVzBHOU54Sk4vTVJ0QXM5RENBL3hJdmNuRWdo?=
 =?utf-8?B?TVBoWlhGK0J1UEk5V0p1MERKSndLOVNtZWJxYnRSRkR1ZmFqb1RZdEFBYWUw?=
 =?utf-8?B?WlR2LzQ5di9vV0EvcmdHTmRZQWdDQ21CZFBxUVd4SHZaWWI3MWZVZkxOclQ1?=
 =?utf-8?B?bVFHalUxVnE5a0taaTdCM016RTNWcGM0TDdsb1g1aFkyQlBBbHlDTVRsVTY0?=
 =?utf-8?B?aW9OMGJKUFZXZ2pOazJtQmJBb1liVnBlNUJtU1ZMdmRCc2lVV01XOE00ZGJX?=
 =?utf-8?B?RlJmNjBCM3JEZHY0VTFUZ2dtSDJhWVFvL0dxLzFrTHBDMFFWY3BRU29sbXlO?=
 =?utf-8?B?ZUM0dDFzbHNEUXFxNmY3czZSaStaL21zTXkxbVgwTGR4UmFsNzVHZzFxSGVW?=
 =?utf-8?B?NTJKN0hDVmM1RkozOUpuQW5ZYVEyL0RlSGFvRGFZdjNBOXozVGEybkdDcmVP?=
 =?utf-8?B?dFVKakJTT0x0VE1EMmo2eTdMZnQ5bUhHMmVOeG9LQUM1RmtYVnlrTVpVSGxl?=
 =?utf-8?B?akF3SFJSSjBzUTQzNTBrV2NVS3ZUaml4YnhsMnc4SXRxbTBtODQybmMwKzIr?=
 =?utf-8?B?ZytkSHllb0M4NWhMTytjb2x2Z0dJYlZUbXZEUnF4RW1JSDRqZG9ZbFpBZ2Jn?=
 =?utf-8?B?TnpPZkVlTE95NWQwcUJTemlrMnQwcktUUjZvV1BxRVZaUGRIS05QUEJJMlNG?=
 =?utf-8?B?QnFITE9XU3RJb2gvdElOQms5emVpc3RJUk1pbzlBSWlMS0Jwd2RWb2FHT21t?=
 =?utf-8?B?cWtDS0sraVRBcXNzQ0laWi96RG82d0RNMzg3L1dpMDRPWHVHWmM5UjFzSVhx?=
 =?utf-8?B?U3o4dURnTFhYcTNtUjZjNWxGMGJkVGtyK1ZUMnhYVFluUVN0SlZFSE8rRFFj?=
 =?utf-8?B?NytiYXR1UXF4VTZ3MWtld1lNYitNaXNQZTk0VFZ3WlYrZm84SmtHejlqSWRH?=
 =?utf-8?B?dEw4bEFRQm5CdGtLYnZsZ2k3QW84emE4ZDQxSXlLMTNIcjJsaTQ2SXpxcVBH?=
 =?utf-8?B?dWVhRjZ2WmgzQU5ianBLN0I0TGM4Qmk1bzhHcEJPdXNNa1kzQjMwQkJkY1kz?=
 =?utf-8?B?NnJIY21NWVhCQUxvTWVySkxyUFFEMkFFOWgwdUZDV0hGTjRzcTVOYWs5L293?=
 =?utf-8?B?VEF3eXc3cHRPNy81YlpZNUJ4eXVPU1BJWmtOZzgxZkVuWkFkbUVwSW8raVhr?=
 =?utf-8?B?Qm1oR3kxc2M4ek1sRk16SzFXUTVZTG1HaEY3Q1RpUVJrTDkxdlQvUXc0anll?=
 =?utf-8?B?VUM0RmxoSFI0QWdUSndLOHR6OFQwS3d3a2cxSnFESXpIZVZuR2x4dVE0UzVn?=
 =?utf-8?B?NVJmWmtEOFViR2ZFTXJZaGNaQnEvL2xTWlRoM20vampZZEVBRi9tNUpyN1o5?=
 =?utf-8?B?SHhuRmNUbGJTNDJEMlhIQVJrTVhsc0k2WEpSL0E2MzVva3dxeVE2UFZ3cmpv?=
 =?utf-8?B?aEFiV2VKTk5mQlBkby9EUGVaajZOeVpoTHhGR1Nrd01TbFdpdS8zdWZabUla?=
 =?utf-8?B?emswVUZmT2dGRmM5eUQ1aGdFd0FoSGFwWGhyRnlnU1dyNjNrNHMwdXRLYXlO?=
 =?utf-8?B?Z3B4Rmc5QVNMSGhlakVHbFNDdlNWRkhYa2lEM0VPNDM0bXNGaDNCeXJubldw?=
 =?utf-8?B?WUFCaE9Ka1hwb0hzSWdDaWlKc3pPSFk2cW50Tm51OHovcUxCLzFGdmdsc2ZW?=
 =?utf-8?B?ZXFYMnluOVJORDlxYXJ5eXh2T0lBUTRwVDFBSU8ySndjT3A2ZlZlUHVrbTdC?=
 =?utf-8?B?NGtxRVJ1YkF0VllGZ2M2MUYvQ0FFaUkxOGV2ZTRPZXV0WVd3QkdyRnJVcjF5?=
 =?utf-8?B?cjhLbGZybHNWUFBiSWRmMCszbXQyazRNNFJXVDljcFNxVFdVaDJ3a3FCc2dK?=
 =?utf-8?B?Mi9GL2dTMDBFdTdoeDlIZUNNWk1PQWRlNkJaZUcwNEtST1dHdGx1NG85TGN6?=
 =?utf-8?B?Ymxuam9LNFl6Z2NOZ1BJSnZSOVprb3QzUm4rci9JWko3V2ZvTUF1ZkthL0Z2?=
 =?utf-8?B?c2lzTVV1ZUVZcUZCUERHQzFwanJnSi8zUXdwYjdvVXVUSW9DSGRjSFRGTDJm?=
 =?utf-8?B?aEo1aFVtUTJrU2ROSytFZTVHbHV5VXBHL0hoWGtMY0F3VFpmeTFYYlFoZFN6?=
 =?utf-8?Q?1QGFazMISbDnpCbA3Xdbq1nFR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d5e883-93d6-4cea-a1a0-08dde9216c2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:33:11.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5SKNVwNEmKk/fAgCVBsSYAR1DyKOoHHWIPJUuY/YNjZPqDSLzBoqvxeN1Hi+GYBzbdKqQWOmS0lzB5gulgJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
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

From: Peng Fan <peng.fan@nxp.com>


On Fri, 22 Aug 2025 20:33:22 +0200, Henrik Grimler wrote:
> To allow for using Linux DTSes through OF_UPSTREAM, we need to support
> more compatibles in the relevant pmic drivers. This series therefore
> adds support to drivers for the compatibles used by Linux DTSes, and
> then updates the u-boot DTSes to use the same, in a bisectable way.
> 
> Also drop exynos_power_init for odroid board fix errors due to
> regulators otherwise being enabled twice, and also fix some typos in
> max8997 Kconfig help message.
> 
> [...]

Applied, thanks!

[01/11] power: pmic: s2mps11: look for both {voltage-,}regulators
        commit: 38443338c7d491852d21d6c5e7e742fc347b9a44
[02/11] ARM: dts: exynos5422-odroidxu3: rename s2mps11 regulators node
        commit: 8575c09a42efc438eacb55483135deb322f98fdc
[03/11] power: pmic: s2mps11: remove check for voltage-regulators node
        commit: 983a16f38627c49704811c12ca7c6d134b08289c
[04/11] ARM: dts: exynos4210-universal_c210: rename max8998 regulators node
        commit: 89cad7ed6fdfdb3bcbb5c6d42b3d178c55d6c8d9
[05/11] ARM: dts: s5c1xx-goni: rename max8998-pmic regulators node
        commit: e64d1a03171d3a3cf62210f930497a25bc4f4f55
[06/11] power: pmic: fix typo and capitalisation in max8997 Kconfig help msg
        commit: 0fdd3b4243359fd81d11923b711c28230795cc54
[07/11] power: pmic: max8997: support maxim,max8997-pmic compatible as well
        commit: 920404409cf1bb7644199b4194bf137fc62cff82
[08/11] ARM: dts: exynos4210-trats: use maxim,max8997-pmic compatible
        commit: 1ca245d1c51173f73a98861244a33add45cb50d5
[09/11] power: pmic: max8997: drop maxim,max8997 compatible
        commit: 31c376cf4f383e57ce2053c3e4b8c7138fdb1e6e
[10/11] ARM: dts: trats: rename max8997-pmic regulators node
        commit: cec29c00bc4c3cfd4312b9444da0cc77f161442e
[11/11] board: samsung: odroid: drop exynos_power_init
        commit: a65798ddbb88b06539e2a109d686edd3fb3a8173

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
