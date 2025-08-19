Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA61BCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD3C3802C1;
	Tue, 19 Aug 2025 09:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="SHAIwtzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203CD80422; Tue, 19 Aug 2025 09:12:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957668006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrVHMJKvG451S4ugQrWXfmhOY0voI0IX4hspcruUeicHsul/9KYPoku2doeG0rGczfe0yZz7tJzwsYuT7HYq/AhcPj1ON526buPEP4uD2+fIhs13b3ykrSP+Zwh1UupRK0S6ZCku7DDlzFFKxYSSF1ytIyvvQNrgWyTFoJrjE53NvP718AIeybFMGRhReCf+uch7VtcA6xoB9wm4TiI5eWunmp5u7BL0wJddSPdexQJw0xUMUzeo2zCvYfoPrcibuWfLZkw5tk7nOV8Sd1Wh7F3dC6tiZ1pyV38axSDjC2NtJ0mvT2JTmyHf40BAKWC53ewWJQDwgPyiqBZqO+xhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHRdrjnqnEnfBC6wGX7MJpD3Y8ObPaDbaodwPhhqEoY=;
 b=Yb+WOJWvWS9ZT53j0+/Uo3hJc963dcvhcT1N271XsEnaUyHRSxXATU0C1STH4z9dhBWe+E5tQbCh4oWy2f4mWNnaX+n7htuhcB3F8c8vCRPoRAfu+kM9R4OwcIv/dsujmGl0aet1EZiZtoSnbQqq/BYfvUgnqjwRStlfYzEpWmG5ket8AtKzVlVpa2/QNsXky88B2SgznPI4IhEfXdzbEof9TcKsUrW5HM0UNlYI19SuWRRZsGzTQgS4ck8qJhR7i13sdBfmXrQkC/opWLtA++SsmeJpOVvSXHMXw13YgH4OkC1rv05wF95CagSJ+iJrx/9ptP520BerVwe7eP2Phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHRdrjnqnEnfBC6wGX7MJpD3Y8ObPaDbaodwPhhqEoY=;
 b=SHAIwtzru7SnU2WdYQZViH4YasgjZQOsFyfbAKQ4MoGnrpcIsvV/+Mppnvhp2ux5NBbaIDXwXg7+T0F93i4k4x+SSwjdHistTtqoXh+oIakeubwmFxcm7wxBdcAM1pTsWTrLoKqVbWHwghalCUxnJr7De1EexvPZiC2m0CYZFKygJyXdlW4TeBXENdEHKy492BNadL7Ks/fkvZ+j/BAlf4LzI4RIF3tftPkPeKUAPTlDOwSAvWZPZWBq+gU2IeAZiCm04nIrx3JasdzRe1kKN8yLwYsMo0ID2R9uLe77xxZ4UOIeUZRxPsbMk8zv9u//BVX/74akrJWGOzDvdQgSww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:12:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:12:51 +0000
Message-ID: <dcfddbdc-66bc-4d6f-bc1f-02b37bcd208e@kontron.de>
Date: Tue, 19 Aug 2025 09:12:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/21] mtd: nand: Add a NAND page I/O request type
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dc78fa-bc1e-49f4-e00a-08dddeefcf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzJOK25OWi9PaXloMHE0UWNMZWpHdVdoVUlHWlN1azBJdjNQOEdHS2JEYjNk?=
 =?utf-8?B?SmFMZTJ2b0JTc3FoRTdHQThheUlycUZRRUxQQ244Z2hLYVhiUWxicHBPNGNP?=
 =?utf-8?B?RE9WMTJvOEV5RUx1OUhHV3RDNlplYkI3Q3VhcTFIci9NcHk5cmRxRmx4ODBy?=
 =?utf-8?B?TVF3cHIvYTlsV2xiQnRIUEp1ZUdycUU3RDBsMTAyaG51Sy9HRlQrK3daQ3dQ?=
 =?utf-8?B?Q1ZhL3FxZlBOVUZNUXdZRWJMSU8rMHNGeWpHSjBEMytrOGUyc2xvT2RJSjFS?=
 =?utf-8?B?a3NJNndTTUVhZnFRbUtKYy9iYzB0OEV5bytPMTNKc3NzMVIzVzZwb0hpSWRI?=
 =?utf-8?B?OXRCeUttTWxPTGQ2aEJGM0p5SHM0TVBNWVp1eTVBTWl1SXBzR0ZXRkRrcllW?=
 =?utf-8?B?NTlqOCtOamFhWXc1cnRWOW5jWUlTdzB6WWxWNWFjR0tsWmFtSTdleHZyaGda?=
 =?utf-8?B?UmUrSHFWZyt4RkVPajFvdHk3UnBiY0dGYXpYakF2K2daRkh0RW1INlBYMXM3?=
 =?utf-8?B?VDhBOHM1VGI2M2ZHdEVSeFJDRTFuOGVLQTBBM2lYcjJTRzJKeFFhLzFucHA4?=
 =?utf-8?B?ckFxYnE0UmNwYnNWUzJhaTJEeHpvalI5K0pUbFo3dEo2MlpXY1ZIdEY0eWVU?=
 =?utf-8?B?VUgrK0ZyRHhyNWt3Mk54T2VoUlU0bzhLYWV6MmJuS3YrcFV1Ui96MWd0V3Bs?=
 =?utf-8?B?QjAxeTVtbW9iU3I5S1lWVlBHU1p5Vkp3S1c2ZVlTNmJwdmxpcndEU0R0VWo1?=
 =?utf-8?B?NnhJSWlCNnlDQmFoSVZFQlRKMGk2dmVaVTNacDVpc3ZCMCtXM1NIQmlHRXRz?=
 =?utf-8?B?QjhOajk1V0xXZnBseEF0dFp2Zlo5cU1XZW43ZGhWKzROVWh5SnhIZWhOelpO?=
 =?utf-8?B?UnpuZUpQNUtGeGNpM0lCT0g3NjR5ZGJRZzZSa0pxSHBiYWZhcVk2dWxUY0Y2?=
 =?utf-8?B?Z0ZIUHBITnZabitwaTJsWTg4YnR3UlZBQmdLNDZIeHJtNENnYmFsWExIaDVh?=
 =?utf-8?B?WHVhS3RZNmN5Uy9DQlpVY2VhVE12MW8ybUhHR3FLb3IwdVpLYnI1SjY5WWVl?=
 =?utf-8?B?d1BNMFpwOGY5eXlCTHYzL0tqWFo2TkpFVVYybkRld3RyTHJlWkgvNUc5S01p?=
 =?utf-8?B?S0JrZ0NNRy9tZmUySDc1c2k5UjVjaVNDWmJ2UU1XNjRoSytkRUEzVnA0R0dt?=
 =?utf-8?B?VUxUNjc4ZTQ3aE5vN2IrNTEvUTBvUzk5cisyTkpUbG9VblQvYTdUaTR0dWR2?=
 =?utf-8?B?QnJtamhDM0t2UXB0TU1LZDVhNWZXN0VpSXVIN2pwemdsS0t2K1hBVnRTTlNZ?=
 =?utf-8?B?RlF1cVdNTWkyYlJkUDA3TWRyMnZmb1JGWWdUQS9pZGRWQmxWcEp3TnNQWFJa?=
 =?utf-8?B?c3QxYnJkbVFaK0ttV251VHRZd3lDSU9QOW1uTVF5Y1kvQnBTTTVpdmhnOTBX?=
 =?utf-8?B?SVYwRWt4UTVwUE5lL252QmJUYlhDdFNUVDFZd2liZ1ZZbzAzN3Jvb2N6SHZL?=
 =?utf-8?B?bnIyV3BKRnZPeGp4M3JtMTE4TXAyWHg5YjlxazJOQTJlUkFVelc2YkdEUFdi?=
 =?utf-8?B?dDZRRDkxVWFDd0lmenZqaDI3V3UwdWtVcGw1UXJ4aFJJeElGR2oxRllkSWp5?=
 =?utf-8?B?eW9RRTcyaEExTzUyWThTdVo3ODVFY0lzMU9RQkl1TiswZGFWV0tzZ29mb1Jm?=
 =?utf-8?B?dUpOTTBVRTVUNmNZbXh2eXdDNFMyN3BCOC9Xc1lBVldSUXlXRFJBVThHRXdx?=
 =?utf-8?B?cVhtVFNoV1dkVXdxeTZmYUVkNC9CajdrNnl4aHNHY25tTXlrWC9ETkhrc2Jn?=
 =?utf-8?B?bTlXN0pKZnhMYTZUWGZYZmhLQ0xKQ09HZ0xsTHJwMUlVOGlqU1NsaGNESWRJ?=
 =?utf-8?B?MWl0OXdGc0tDdmdFdWZsdjc3aHplMWtUenhEaUN6VTgwWEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnkxa1h5Sm5Hd0VqbzVmakRjZWZtS0F1bGVZQkd5VzZPRkNEQWRCNnRyVElB?=
 =?utf-8?B?OU9ZZGo2akhNY1pmeDNmYkFmTmlxcnllVE0zTkxZK25QR3J6eVRMeWtQYm5N?=
 =?utf-8?B?aHJzejZVV21ZV0JDcEJlbkdMcmdCUHFsMjhDdW0vdWNpZHdzdktZQzZXY1ZD?=
 =?utf-8?B?MUxKOHptcFRkclFmaDFJQ1ZKSkxjWXdUampFbVl2WUlQQWFORWhkSGhHL1Va?=
 =?utf-8?B?M1hnU2N5T0E0SmF1eHpucW8rWktKWjFuU1hTSUhpMGxhamNVRjJpQTBGMHcy?=
 =?utf-8?B?N3ZVUlh0b0dQWTBPZXg0YklmeGpxcnRDL2s5RE9IMS9oZ0xrdzBLcTZiU2xT?=
 =?utf-8?B?ZlJPL05wWk5na3plcXBvVE1IemRoWFR1aStaY2tZWjBkNEROeUZVYVpOSS9j?=
 =?utf-8?B?YjBhU3Y2OW10Q0N3amE1ak5QR05mVjJqU0cySzBnV0Z4N3E4VGNFK2dFUjdH?=
 =?utf-8?B?V0xCelVBeGc1WitOR3pXYlFRNlQwYjVTQjk0RDF4V3ZZc0RRZ1RHK1JjYzRB?=
 =?utf-8?B?MnhxbHFPd2VXWXBZSEtMeDdTQ0dDSFk2ZDRMeUc3ZXk3MkV5Q0U4WGRUZ0xh?=
 =?utf-8?B?RFZ4Qm5rQzJCcXgvS2Fvc3ZJL0U0TXhwSVJRaFhRMk1RMkJpWkdtVzQ0a0hs?=
 =?utf-8?B?S3BYTElwUDlCNmE5eUtDeFZ6TEpMclpQOE5HOFhGN0MwWG1yaytuVHdtQlJu?=
 =?utf-8?B?clVBbnNXTzQ2QXozYXRKMVptVXFMeWJSVUlCdlFNSmhTRWppRHhBT0JGQ2VB?=
 =?utf-8?B?dS9JZ1ZoM0plS3ZLWlpEb005bGw4OUNxRk5jY0J6RmlITVRHSGlGMmkwSWFM?=
 =?utf-8?B?TVo4dnNnZUZXbkJUaEJ4K1BXZ1l3RTVXUEdjb3lLWWlJaEJEZEMvbGNYNjEx?=
 =?utf-8?B?aEpEcHgzVm84K0lzTFFTc3pCMnhrSmNvdTR0UnNTQys5MlVwU0U1OW9jaWhW?=
 =?utf-8?B?a0dVRk96ZUlNNnp0L0NzcU5PRFdEWXBWbDltamIvU1h2WCtRSXNPcDJXQ1Na?=
 =?utf-8?B?KytBN25NdFZnZlZjUkhsczVyTWRZVWZ1VXphZXZ2RGxCcDQwKy9DK1BmRTdV?=
 =?utf-8?B?YXpEVko5YXpkKzErRnNMZ2ZrWG9zSHJKZFAwM215cW4waW1VT3k2ZjNFbE9K?=
 =?utf-8?B?azFUSzFSN25PWnM2UlJza0d5SHpMM2xlamcrY2l0K2c0ZFQ4UjQ2THVzZk9k?=
 =?utf-8?B?RGlUaTRuSnF1azQvV3pRb3IzYlh4WGVzdGpxU0FCYkRsaEFRK3V1cHpESjZB?=
 =?utf-8?B?QXFvMGZwZkNweW13VzlRZ3Jlbk1oaDVCVFEyK1ByOWV4bSs2dDlrQ0daTEQx?=
 =?utf-8?B?dWhjYmhlMnE5cFpYZytmZzFZNFJCbVFlSVRmVG5nNFppeVdjamRoVmlFWk8w?=
 =?utf-8?B?NHZoZmJYQktUWlBpbUNwUGRmTDEyZU1ncmh5Q0I0RjF6UXk3TjV0ZHMrUStM?=
 =?utf-8?B?R0dadUt0S05RZWEvcTdyTW5KeGNoakZpUmNGZ0tUV3YvY3R4eSt0YlNGOWQ1?=
 =?utf-8?B?N3dGeW9KaXMyc3Z0WXpocXNJdTBjSXI3N0Fhb2duM3RJc3hxSW9hVlcyRmRP?=
 =?utf-8?B?L2JXYWFRN2dFSHhtRHlrSEJOc0NGQ3I0TnlmdGdIdGlIek05eU82UVpQMjNp?=
 =?utf-8?B?c2Z0YXQvbDU3RThEZGE3RjZvdUJrZ3FybnB2SGhpWUZoSDU5amlHVmxLOTBY?=
 =?utf-8?B?VTlsZzZPdTIva1lzdEl0UTFwUVlKb0ZMY1BtamFtTWVlZDFmcHFPa3IyQmhi?=
 =?utf-8?B?UFp2ZXVKSWZmcHR6Z1JWaGNZNHJoY0xJQlVHYVhPL1VDVFVhV3JJSFZyR0lw?=
 =?utf-8?B?VGJvcjZSUkNwSU95SFF6d0NXblgya3VuWlJybmthZU9RLytRT2NHMjJMK0gr?=
 =?utf-8?B?cU5hcmo3RzJMakZFbUlDak5waFZRYjd4RjQ2VVpIRzNHUDZVSzBvWSt3UDhz?=
 =?utf-8?B?RDU1dVVsVS9vU1BSbXBlYStBUEpiQTdydFVuMTJsajZDZXR0VnFoQXdvMW9B?=
 =?utf-8?B?NmpTNyttMnNGNndabGNlM1c2SVJUaHhHblpYY3k2REVKWVh6TTVOeEFWRzlW?=
 =?utf-8?B?S2p4L0o5QzA0dHJ2Z0FwVDRTanlHNXZId2UvM0JCVG5TMkxoSUZBNkdlWGlV?=
 =?utf-8?B?TFRPVzZjb3ZUVGQvQmNoMmJ6TURtTSt5bVlhLzBsN0J1SGxIME9oNzhLdWMx?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dc78fa-bc1e-49f4-e00a-08dddeefcf40
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:12:51.3846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZzLUFeSQXSE6Wcv+LRuGkr0VGPs15IcKfmajj+wQOyDgX1pLqtOgZowSlda6NM6ZTGZu014BJcGwQNjQ0MPlTK59ERgPhwW3APQPWUsulE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
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

Am 18.08.25 um 12:05 schrieb Mikhail Kshevetskiy:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Use an enum to differentiate the type of I/O (reading or writing a
> page). Also update the request iterator.
> 
> This is a port of linux commit
> 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
