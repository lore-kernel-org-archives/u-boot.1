Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB0BCFD37D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 10:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B86B83FBD;
	Tue, 25 Nov 2025 11:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nxPemiFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C19083FD3; Tue, 25 Nov 2025 11:07:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE19583FA5
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 11:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx1ckyLxoCzlwdeh2gHkOCzVjz8MrE/mhE6EyRXZ6Wp3zuajIX+mxDpj9MW5bJjNzFD39rFcM9zF+Bjdfo90DA1DyLWbxyApD7V4kBP/0pEEp8M21Wf0/S4WigrbJIo6spejwlxZEpCOZ6fW41VYR24OHCqvj21VFhqAoGJZXVH8psEnEEas7kbMJJA1qPU/ZgjBsZwPWkBZSQT4vQvRLV2WJ6IMqdnAoYZ6Ch35B0fsrQk8dug+avfpUq3D8Sp0MrjAgjHREbiHR+K70E/No2s60X19bs9j0YCIsAVs5xdWO3W4lfy0NKfOR05ZPGNt7axz7FDnOEN50lzKaqsK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qJl0Df2YeD10DD60kvyrUm76bpNEFYiXRhluzz4FYM=;
 b=whwmLaksI37SHotHJcr929W40H8ywKSWQqdpEs5J6xKk58n9jeJRwntqUZqseLVSZHFh27kk9V0tjFjQFTcZtcOEem2YZnOTxfTctkzcWODhu6muhjjSOtpM18GL+nj2eECgjJBJ2sP4MR3YuN4G8le6QlNCOdKOT8R/lN4WeTwGwbGb+Fk77ij747x44MQrdkx0RZ8RebiYhQ/gJCbV3tt1vXrxNIjQzr0itlZ0WBiHw3w69RogirRu5lXehSxErTY8aVzlEtPkynfAh5c7zRcA1yLefHF0AFfuybFhfpkHBVgqxXQM6jUdUOQfmdanfVOcH3v2HFfKKxCbmuPy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qJl0Df2YeD10DD60kvyrUm76bpNEFYiXRhluzz4FYM=;
 b=nxPemiFuiR5u7n5Bg+irUKF8YvKj+fGDC7OnggaEmdjGjt0WQkuCl//Rz1b+sfgcZ/jwI9PZfphDzPdSQpzIfm768ovSyznYsydWUWtNx9U0xcTD2TWQbKVkV/lS9dSq8LGSxYF2h6sWIMaQee0ayr5hsAg7wmfsOdkDdciVk5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 10:07:30 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 10:07:30 +0000
Message-ID: <9bb15fc9-7434-4ba4-814b-d99cdcd7a4f8@cherry.de>
Date: Tue, 25 Nov 2025 11:07:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
 <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
 <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1669d988-6fa0-4d2a-c5ca-08de2c0a7197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGFGdHd5MEIrdXFsRGdlY2J2QUFEVXBDM3ZOalF6N2xOaEdDMGdTK3VZaU44?=
 =?utf-8?B?dk1mZ1VTSHE5M3FZQXhzNGx0Zk1XUi8xQTB0YmRvSzBnbW5QazlBQ2tQSUc5?=
 =?utf-8?B?ZVF5cFRjMVJ2V0VaT3k5VTBwK0FRWU13WjliRzdjUUljMGdSV0FMYVprOHFU?=
 =?utf-8?B?Vll4ZGpZUHlrWUdhNU90V0NiWHBoYWtBUXJoS04rbG5NaU00VjZBbUUxMG9V?=
 =?utf-8?B?SWx6VjErelFsaVl4NTR6Ym5XNzZtaWVYR1NPUEhSRVkrTEdGQmJkUGFmTUFP?=
 =?utf-8?B?dHZBM1M4ajlQSkZpSzVLcVRUT0kySTR0WGxIRDdhMjNOeFVoanJUc3hmOHdn?=
 =?utf-8?B?QUhJaHJrQllUS01yeWFXc25TV2FpR1oxSG16eUxKTlBJWENLWEpjWG9JNnA1?=
 =?utf-8?B?Z3N0MGtJME9oQlZzQ0pJZnI3ZEcyb0xLc1RJZE1SMm9PS0V4eW1XZnI5R3c3?=
 =?utf-8?B?SWQrQTB6OXh2TVVXMHBpMll6d284MEhXT3F2ZHpubG9wbGtNb3BjRlJQK05z?=
 =?utf-8?B?S0hSelAyckxPNW5nVGllNHR3OXdUWW5odHVkSXNOLzNiL0hrWU92UmFuZXh4?=
 =?utf-8?B?ak41U24xM0pHZHlXS01GdWw2ZFlmTzRoWmZjTzZhTzlRYUJjR2ovRjFmem55?=
 =?utf-8?B?c09SU0RZM1dwREUyK1BaTllEYVh4eDZNVnJ6YXFUZjBRenVQQmFvNHBuOWkw?=
 =?utf-8?B?dmhzNnVjZ29tMG9oUU9OTnN0elNIYVBUR1VzNWJ3b0xsRE9tSHliZ0RNbVpK?=
 =?utf-8?B?ZjVYUHZaYzFiZDJNaWttUDBEWUViQzJpS09mdSt5dE9pUGFkWWpwclNrZ1o2?=
 =?utf-8?B?TDRHZlhVbmtPVlpLaDhRSUhkMUpCc0U2NXljMjBLamJwQzQxaUhwejFjN09Z?=
 =?utf-8?B?UHVDbEszSSt1SWpYdzI2dTh5eDd0Z3V3Nk1pcTdUa2NuWS9uZk80V3d6VC9m?=
 =?utf-8?B?VGJQZ0o3YTNhN1MxNDZDZFJhc1k4RlByV2E2ZCtTZWl0eUF1c3UyRjIza2po?=
 =?utf-8?B?SDRFM1gwWnBZVEZsVlNxK3ZSM2l6eGFFWmxrR1RXYnRENHZuTldIeTNtakh1?=
 =?utf-8?B?QkhQbFMxd3N0d1JwOXBmQThZMG9mNXFCeHJXaTZNM05YWUUxMjZraWFkZTBx?=
 =?utf-8?B?YVB0TEFpaUpOQU9ydFRIRVVWejJrT0p3WXQwUzJlRXduSVFKSGV1OFNtTTJM?=
 =?utf-8?B?VTJyRE1aeG5CMDBlREx0TlRkYkRWaU8yNzVTUkd6d2xTMkhWakhEYitaQkNW?=
 =?utf-8?B?bDYzRUNOZGFqZGVOUWpha2NGTERMdzFHa0F3eVdQYXBmL0YrVHRuRG1EY3Q3?=
 =?utf-8?B?MTl4TWt1YmxrYW1mb0VWUXc1dnpjRkdaS2lzNUV5U0k3T091VW1GVHNzWUlI?=
 =?utf-8?B?R0g3ZW8zaTFzYkttSmFnTGZ6VVNycitwVEJ6N2thYkhIS0hxVXFyT3Z1eWxi?=
 =?utf-8?B?WEUxZ25wTmlKb2pvOWdraG1qVWdkeVZGSHozblgyTWRyWjNQWWhuaitJMCtS?=
 =?utf-8?B?QnhyUG5IUGRFdlpDdnVCNVdyaVlWaTlTZVN1WGx4eFU3UThPLy9NODZnakhj?=
 =?utf-8?B?TjNBK1pHVjJaeURuTktwL3hQQ2dEVW5MNlhlaUlZbDRtanhTSVAyd05aMXJo?=
 =?utf-8?B?S2Z1L2J0OEx1aDFycWUxQ0FTUFg1MFEvbUp2RExCWWp5ckRBT1dIQklVejls?=
 =?utf-8?B?NHp2aElNV2xDUXhLSnR3cVRtOERHamZSRVpJOHlta1ZLQThEWDZqTDVxS05w?=
 =?utf-8?B?ZlhyS2trbkRqajBUV2R0SHpMekhYN1VYWXVNbjNLcTZZeGFiSlg4eVlIeXhw?=
 =?utf-8?B?eGl6Y2Y0cS9iMmFNWjZaelVmN1J0SGovRzRaeEZqbGdMOWFON1l6NVVtcWRI?=
 =?utf-8?B?OC9EVE8vYzhNeXh1T1RrOG9ZeHVhVjBhTlBZUGJTdTdtdzgrcE1TOXdnaWdo?=
 =?utf-8?Q?ItzCU8TDdmTiMQX9vAxkHYwLF8c1GDHB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhhc1ZocytUcFB6OERUL2N5VFBzS2lScG5sbjBaMENvSURwYzNJMjY1NDBp?=
 =?utf-8?B?RldacVJNR2ZBQnpRMEQyN1dJajZvUEY4RUEyY2RsSU1pZ0xlZExNemNEM0tk?=
 =?utf-8?B?WG9kRkp0c3pEN0RHazNxWFZMZFVtTUJRKy9pamV2YUdmTDBHUkY1M2xjWHM3?=
 =?utf-8?B?L0tqYS9yb1VJa3ByUFdHZnlUWUNYeVZrR083d2RxUndFNlNtMmJHNjhIQ0dw?=
 =?utf-8?B?RjZldVVMQWFjcmdIQWdMamtnVEh5dUVtbENieVhsV25wb1pTRnBubVhkaW1v?=
 =?utf-8?B?TjFaT0tYM0pzNlZ1N3kxSXg1Z1dkMUdQQ2l1YzRMYUQ3NEhlSW43NE5ZdWJ6?=
 =?utf-8?B?aDBiRGs1VzVma0Z4aG5XSEIzRSthMloyc3NITlVKenMxelNGSHVlMG96Rjl6?=
 =?utf-8?B?VlR0Nm5BdVNmY2h0VTZwU3o3cGJLbS9lREo0OExiS0VyRHhweEs4bUEyc25G?=
 =?utf-8?B?T2lyYnFqamt0VGlzWE02NlR3bjRqSEhqbndUN2pqRDBLUy9lNHEzSFhqeWNt?=
 =?utf-8?B?ZlIyeW5XekFCWUcrWWFoSlhFbWxBakIwaklJYksyVS9YQWFlVDBGencrVzRq?=
 =?utf-8?B?MXlUT0hvRGI1djdMQis1aUZoWnd2U1gzWGFSY21PMFR2YWF2SlVXTzdVcXhx?=
 =?utf-8?B?QzIzKzFJN2U1Tjl3L1BnZzRRZkV0NkpSN2pHTUd1MVhhV0RQNVlZclVkd3pE?=
 =?utf-8?B?Z3lodS9BdHRFQVMxVjRFWklhS24yNnR4TFpLZzl5cU1uQTVvLzR5TVNvUWlW?=
 =?utf-8?B?UHU0SXRld09DRXRKOWViSHZBeGVqZ1FKaXNndjUybDVCQXFPS0NMVWcwUy9i?=
 =?utf-8?B?M0lGTnNsSjh4dUR5cTlucE9XZFNCZUxqTVJSRzNmMmg4UlUyRjRSTUdCV1NH?=
 =?utf-8?B?ZjVFZXNBd2ViNGVwcjhXZnlMN2Q5MnNpMThWcnhXR1FJYTM3eHpHSFhheXll?=
 =?utf-8?B?RWZoN1lBS0UyUjl4L0hMMmFOQk9jSXNOR2ZheXo2Y0gwTUVZRGFMMXdoWWFz?=
 =?utf-8?B?ekJ4c3g1ODBsbkJGMEljbDd6REpleXF0aWEyd2VaRkV5bzhVak9QL1pyaHR1?=
 =?utf-8?B?S0MxZU83WTNvblhIMmdvU1BvNnh1Rll5eUZTSU1aaUgxY2dkSjFvYTNFRG5Q?=
 =?utf-8?B?RTA3MG45WlZ3aGZkSS95TEVrM1dXYWxGYUFYb2JkVmJwZTJzM0FWSUJydFBm?=
 =?utf-8?B?aktTYVF3YkNOYUdQSnUzNWVPY0tiaFFlN05qNGc0aEw4MU5oRnFRWTdhekxO?=
 =?utf-8?B?QVpjR0VGZUhGL3RvczltdUtwUFRyUllUSDFvcTd0UDZrMUNoSGhncGpCcmVU?=
 =?utf-8?B?ZE9WSzFKU3llNlN1akdEMnhHbkxPUEpHeHFLS1BBVzIxMGVsUVUzRTVYS0ox?=
 =?utf-8?B?Ri8vWUlHQXVLUDYzU3ZMRlNTU2FOb1NRL1JDSEpVdmw3N1hUTlg0VEdFSXBh?=
 =?utf-8?B?eUZPN2I1SkpHa1NRTmIxV3ZITk5BV1hvdGtJR1U4QXdFV0Nrb2F5S0E5NDlI?=
 =?utf-8?B?Y2JHcFJ0RlVaVWl0eklLNjhXTjhwbzNjbnk0NzRYRmdyK25kbTNDNjhKMmFs?=
 =?utf-8?B?RFQxTWtGTm5KNlROK29lcU9ib1dOb0FMUlgrdmxYd3R2UjNEQUJXaFJHSjNN?=
 =?utf-8?B?RmptTHVLcW43cGVqem5TOUdqaVM4b2JrUEVtN0RDMmxjc2Q2M25KaUcxNGQ1?=
 =?utf-8?B?Y3lJRkFBczFjMkpMKys1ZWNHanUvYzRwOCtNc2U3TDZ2alNlWTh6c3ZuY3Az?=
 =?utf-8?B?MEl5ekpESDM1aU1WNm5oTW5HdkR3TDd0cXdPbDdJV0dicVgxZGtTandyVkxF?=
 =?utf-8?B?MkxXZHB5enlPeUtHSXphSE5KSVIwRENVYXJhYmtHSm1oMUg2eHdVME0rdU1O?=
 =?utf-8?B?UUtPSFUxVFFWQkx3cE91bVp5cHgyWEM1cVltcG5rcXZJcDh0OGpSZ1NEaGFU?=
 =?utf-8?B?UlNMOHk3WDhsWkplbmxnT1FvNkJZbTdMSEhyZW9zb21Oak5mSWdkMXRZU2hY?=
 =?utf-8?B?VGtsSzQxZ0FxRy81WnA1ZEorNTVrZFh0VkVkeVUvWXZIdjVDdHZqcTRiTnd3?=
 =?utf-8?B?S1VhKzZzOXZmYkx4ZzdZbm1jU2toaDdRbnRCYUVtbVlSZDQ3ZmpEWm9aUlFk?=
 =?utf-8?B?N0M2NmlOMkMvcmNMMlllYXllY0lCWmhVaXVOc2wxUi92R3FXUUFGWFdZSWdF?=
 =?utf-8?Q?pP6Phon62EoRexRG5VpaNHE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1669d988-6fa0-4d2a-c5ca-08de2c0a7197
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:30.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7fr8SJLNeb/d4mPySuTXySkwPPeRNMVee/cBS/k0RicMEB/TJ+6DtfYbwWgGACCzJ12BkHHRsUqzu3obiQFKIVKsjxBK+rlOoAdG7sc7V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854
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

On 11/24/25 8:23 PM, Marek Vasut wrote:
> On 11/24/25 4:05 PM, Quentin Schulz wrote:
> 
> Hello Quentin,
> 
>>> Example invocation:
>>> "
>>> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>>>            -d arch/arm/boot/zImage \
>>>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>>>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
>>>       -Z 0xde000000 \
>>>            /path/to/output/fitImage
>>> "
> 
> ...
> 
>> Which formats are supported for the --tee-file parameter? OP-TEE OS 
>> itself has multiple versions for the binary header (v1 and v2?) and we 
>> can pass either a binary (tee.bin) or an ELF (tee.elf) in binman, c.f. 
>> tools/binman/etype/tee_os.py
> 
> The raw binary only, see the example invocation above.
> 

Must be documented then please.

> [...]
> 
>> OK so... On Rockchip we have TF-A and OP-TEE OS split in multiple 
>> entries with different load addresses (see @atf-seq and @tee-seq in 
>> arch/arm/dts/rockchip-u-boot.dtsi). I guess this means we wouldn't be 
>> able to use this auto FIT?
> 
> Are those multiple "versions" of these binaries or are those really 
> separate parts of a single binary ? The later seems a bit odd. Do you 
> have an example of such configuration?
> 

Same binary split.

Rk3399, PX30 and RK3588 (the three Rockchip SoCs we use on our product 
line) have this.

- For PX30:

Checkout trusted-firmware-a repo and build with

make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 -j`nproc`

Compile U-Boot:

export BL31=/path/to/trusted-firmware-a/build/px30/release/bl31/bl31.elf

make CROSS_COMPILE=aarch64-linux-gnu- O=build/ringneck 
ringneck-px30_defconfig -j`nproc`

- For RK3399:

Checkout trusted-firmware-a repo and build with

make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399 -j`nproc`

Compile U-Boot:

export BL31=/path/to/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf

make CROSS_COMPILE=aarch64-linux-gnu- O=build/puma puma-rk3399_defconfig 
-j`nproc`

For PX30:

$ mkimage -l build/ringneck/u-boot.itb
FIT description: FIT image for U-Boot with bl31 (TF-A)
Created:         Tue Nov 25 10:52:42 2025
  Image 0 (u-boot)
   Description:  U-Boot
   Created:      Tue Nov 25 10:52:42 2025
   Type:         Standalone Program
   Compression:  uncompressed
   Data Size:    659944 Bytes = 644.48 KiB = 0.63 MiB
   Architecture: AArch64
   Load Address: 0x00200000
   Entry Point:  0x00200000
   Hash algo:    sha256
   Hash value: 
2f6a1658befcd8330843ed5d61ee5b539000f3dca5f2b35311be064596fc94f7
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:52:42 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    106496 Bytes = 104.00 KiB = 0.10 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
e6d48a0c4a47d8132d8185b58a1f5e44c025eed6eb9c4328a40feec85446281e
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:52:42 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    129 Bytes = 0.13 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x0005a000
   Hash algo:    sha256
   Hash value: 
3125317584ab4860216e817612321962a0a904f14c830fd64961eaf12c15215a
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:52:42 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    112 Bytes = 0.11 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff020000
   Hash algo:    sha256
   Hash value: 
d856721b954d3b7d74bca14ae49a3ce52b17acde932bb2218f927af73c422b9b
  Image 4 (fdt-1)
   Description:  fdt-rockchip/px30-ringneck-haikou
   Created:      Tue Nov 25 10:52:42 2025
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    72912 Bytes = 71.20 KiB = 0.07 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
0d8d2d650a311a7085ccb883409e680daec58df83a27b76724de60465342777e
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/px30-ringneck-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Loadables:    u-boot
                 atf-2
                 atf-3

According to datasheet:

0x00040000 = DRAM
0x0005a000 = DRAM
0xff020000 = PMU_MEM (SRAM?)

$ mkimage -l build/puma/u-boot.itb
FIT description: FIT image for U-Boot with bl31 (TF-A)
Created:         Tue Nov 25 10:53:47 2025
  Image 0 (u-boot)
   Description:  U-Boot
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Standalone Program
   Compression:  uncompressed
   Data Size:    897112 Bytes = 876.09 KiB = 0.86 MiB
   Architecture: AArch64
   Load Address: 0x00200000
   Entry Point:  0x00200000
   Hash algo:    sha256
   Hash value: 
5da93c500366e99d5fe3acb84b32b5757a90d8ef32fe73052bc20f6ca17f0b89
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    143360 Bytes = 140.00 KiB = 0.14 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
30e187d1b9c029657b1a9e029e5f7ad34fbfd5f9ca4a44cb1cb48750a92cf09b
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    81 Bytes = 0.08 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00063000
   Hash algo:    sha256
   Hash value: 
7380684a38dedb22d648d835934ef573c3e32a15e4b81cbc4ec158d17cb707ea
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    8024 Bytes = 7.84 KiB = 0.01 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff3b0000
   Hash algo:    sha256
   Hash value: 
a887bbaec347403739e27430cc512922178b694ebe001e22c2cb4774254d67e6
  Image 4 (atf-4)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    8192 Bytes = 8.00 KiB = 0.01 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c0000
   Hash algo:    sha256
   Hash value: 
67bf4dd100c6c99dbbf76c0b19072e6e9756383925795d94ced000c2a7cf3b9e
  Image 5 (atf-5)
   Description:  ARM Trusted Firmware
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c2000
   Hash algo:    sha256
   Hash value: 
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  Image 6 (fdt-1)
   Description:  fdt-rockchip/rk3399-puma-haikou
   Created:      Tue Nov 25 10:53:47 2025
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    97832 Bytes = 95.54 KiB = 0.09 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
5439f6f77ab01fa191a6a69a8691165669497fe74fc909f13a6d448b1004d629
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/rk3399-puma-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Loadables:    u-boot
                 atf-2
                 atf-3
                 atf-4
                 atf-5

According to the datasheet:

0x00040000 = RAM
0x00063000 = RAM
0xff3b0000 = INTMEM1 (SRAM)
0xff8c0000 = INTMEM0 (SRAM)
0xff8c2000 = INTMEM0 (SRAM)

RK3399 is a special case because TF-A is running both on A and M cores.

Cheers,
Quentin
