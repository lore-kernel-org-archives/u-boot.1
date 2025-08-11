Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF872C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED46383280;
	Mon, 11 Aug 2025 17:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V6a5jUTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6257283285; Mon, 11 Aug 2025 17:12:51 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B5083278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuelWtzZDJZrS0iORz+G674lYB5y7Y47VUZ8AY+OaXz99Csyp8ZiXc1kXRWWBxMzJNgPjHc41Ui2U6gkplzlqu1O7HMp7L2oE7oWisKkGy1V8qvUw2Ndhk+Q+++rjDRJdU8gTEXkuf7Lw2CN6UZYIwQC5llSXqF3Iwakm2j14aMIQeh5+pndEhK6K/C0ENNzBRv9T5zozdLce00B2L1AZHJhJKEm4Jdh002Qo4d33OgTRtHiQafiv2JGnhOUgIAvMGsqvvWtjF+Q1KCKXg/Yu9l0ZPGhihteaqTC/nbjFlnOUsCsukk95TQaXfbetsk9Qek6Eyk+5+/V664tot7LTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehVKiHc/9+I0E2sZsUkcKtf0UVvlBtS6KowpKX37OLQ=;
 b=DXFnKu5rBrafvg9bvEW7Ty5P/y+jc2CRkvDSFro4jnRST1oUj1TnwSTa/XTie3RT1T/7wk7j/CGoiS3TYwFwhyA/LZmvM1jHPRCABgjs19FvahQUjA5NDTgmSBaY8Rhz6C7iHfC4OUIGv3gB5HOljJ6AKOEksGPJ6AUdJ7O8BCqIf5NIMzQE2Kbu6Xm+88Q5xfyafGDfSrg3/hvuPFD0GWbL3sB6HEWgE4B+WixaW/tdr4gLJq8UTx2JfrBGtpp6J+6/6yEsgxbDsLJFuhEmY0m5TnQjCHUSlj+Xspn1WIhnjFVQExkPeNDSMgSU4ShoXJ8SMx90zeGZ053KmJFLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehVKiHc/9+I0E2sZsUkcKtf0UVvlBtS6KowpKX37OLQ=;
 b=V6a5jUTuaL7ImPoPpHZJAvsS3fz3kNGlPO5HH67LYmIWcjmsKcLLmsq73T+AFHmK985SW8JuUJbVo7bJH7uEDsRbQGHe2PSyY+UszaF7ZnwZxH6+g4B8DYW+76fld8jM1bxA4kUOnfq0g5E71bnc6yjrMjVoRZ/+CQhYCc6iCG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 15:12:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 15:12:48 +0000
Message-ID: <60e09bd4-2add-452c-a2c2-32074b266ad8@cherry.de>
Date: Mon, 11 Aug 2025 17:12:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: power_i2c: ret is uninitialised if not DM_I2C
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
 <20250807-power_misc-v1-2-2ac672f15461@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250807-power_misc-v1-2-2ac672f15461@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0690.eurprd06.prod.outlook.com
 (2603:10a6:20b:49c::34) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: ac089353-6ed2-45b7-e093-08ddd8e9883a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFhNNk4xbEtUdkUzaDh6Tmtya0hMY2l3RWErOUx4cVU1RmM1NmJueG1ubWsy?=
 =?utf-8?B?UHZVNEtLeWpudWhtSU9lbTluODQ1SnRtYzFrVHpSMVdBMnUySHl4a2IzTGpy?=
 =?utf-8?B?empTd1hSZldkOWExWFloWFVpdldEWjVvclhsMmthMEVDZFdlNjZQRGZacERP?=
 =?utf-8?B?RHJuSFZGNEVpbUs0TjRxbTF3TG9xUDJRRnRkYityVm5XWW1FUVRQZjdMdGI3?=
 =?utf-8?B?aFVxK3F6cTdOakp1aDlJU2lxdXFzcjJqMVhwdGx3MW9TV3hlZUlSa0ZQOXkz?=
 =?utf-8?B?NlVmc0IvY1NRVytCeWw5QlRtRzNLSjUyWEFlZ0EwcWVHVm1rdHhtaVI1SlBI?=
 =?utf-8?B?RS9yNkp5NEpDSW8wcVIzdEFXcStwZFczc0hTSUpBcVNKcTVvdG1TaWMrVGhN?=
 =?utf-8?B?c2dsVWdrUmw3eFpnV1RWZ2wyYXdBTFJTbzdoNnZNQzgwa1p3emhMellCaWNO?=
 =?utf-8?B?SlpndlRFazlqQ0ZrUWQrMEFNdnU4a3g3QWFyQXFBRjlmZHR6b2wvdjdLWnpa?=
 =?utf-8?B?bjlVRUt4K2l6NXc0dGdPQ1FvK1pSV0FRU3Jzdm5jOHZzOFZVekhCNHc0N3VG?=
 =?utf-8?B?Z3FpeGplNHlPK3hUQlczWWN2Q3VKZTNkd3hJcndET2VUMFk0ZW9wUHVuVE9X?=
 =?utf-8?B?RitleWhzbnF3QjNmdzhTVFBPaFcvQ1Q3Wi9MZk1CVjNzaUVpbUdwY253cFJm?=
 =?utf-8?B?QkxUY0hUTWJhenJFNStucllWdzdLdWJONDJiZFV6SFVTci9Zd3c0SXdscWRC?=
 =?utf-8?B?UHM2UVpNUDlqS3BxdzRpeEViZm4ra1dRV0oyYzJsV2QwTkxnQ1ZzcStNTEpq?=
 =?utf-8?B?eXBZd3luUk0xekM3VUIyeURSTHV4eDVYZmNMVmU4UmZsbzZ4eHlEd3VTY3VT?=
 =?utf-8?B?MkhXZURReFFFSHRtWlZwVklURVdUNG9kNllCMFduRUxBS09lT3VEZU15R2wy?=
 =?utf-8?B?amlrV0NHam0xMmZLM092TGEzMXMveUxnY2Q2dHhIU20xenBjVkc5QlRLamcv?=
 =?utf-8?B?ZThiSm5PZHdGN3psVXp5U0ttK0VMWVZlTHgyYUhHdUJWTmRkU0M2dGtzbnk4?=
 =?utf-8?B?N3p5ZllnaklMRDJFUElkcnBDRTlFOHUrN2xtMjRCNWhLWG5UWkp6MTU1ak1U?=
 =?utf-8?B?SG1LR3d2K250VlBPdWJyWCtiTFlPVGVMSG51Q3ZzSTRJajNEa0x1MCtINnlN?=
 =?utf-8?B?MFpMSEtuZmpheW5nZnpPbURXZlVpbmlJMElIbHQ0T3EzNUJsZWZxNzlmejRv?=
 =?utf-8?B?TWtBZU1rVjVkK2dIMzdsTHlYV1AwVTA5ZEZmZGlLRFBGdDVZTnBVQTJ1YzIr?=
 =?utf-8?B?U3BiOTJDWGRZOE9vbW1HYnBmVVNGcGtrSWFTaEZmaHBsSXB2ajk1TjJhdjE4?=
 =?utf-8?B?bnJhbStQTkxGc1hmYlg1aFVTci9sZzdNazV0RGY2OUlDTXZmYTFvVFlVL3lV?=
 =?utf-8?B?L3d4S0JEaHM0a0lPTUU4ZWFKbFNybDgxZWpGQkFRY1M4aFZGZGlGTDExRFBU?=
 =?utf-8?B?c1Z0bnhXcmtEbVJLWENpSnZWSnlaRkdjTmtJWGtIOG1zK1NwVjBmZEdxWnJG?=
 =?utf-8?B?Q2FkRlR4aFRqWklTcTFURmV3MUVhOE9RazU3aEFlRHk0UUpjQTJZNXNhM1JL?=
 =?utf-8?B?TlNUQXVWMlk5MXRvbnBVMGl1RFYzRkpZWk9xdTFwSXJsOUpSQ0lhMmxLY3BV?=
 =?utf-8?B?ejhIcE5OVVZNRjd5aUFjcVBKTFZtUk5KOHF5Q2hWUkxveVVqSWVMbTFRdWJR?=
 =?utf-8?B?YmJlR2ZldS9RVWdqd2dYSFJRZERSaGFrNVIyWlhMSTQ4bW00Q1dzRzFsTnB1?=
 =?utf-8?B?U2JRdjNFbkdMQnF4RVVIcmJMWHRSNEQ3U2lzZDNTVXVFS2ZxRnBVcDE4UVgx?=
 =?utf-8?B?aG9qRFIzaUFYRmpPczJtR3plWEt3UGNTdmo2c2VMQmdGbExIN0JVRWNJZDg3?=
 =?utf-8?Q?Jn3K01kkGHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRWaHhYb0lDTWtxQzJnNGhHY1h6R2hWaGhBRTdrMjdVZVpXZ2w1VFZ6WWFQ?=
 =?utf-8?B?MTBwQXR2TFJHS0tZUkVwY1RKOUVhM1p6RGNaM1pOaERNRjZuTVFYRUJoNnJH?=
 =?utf-8?B?MzJnVjNnVjlkODRjRmU5VXZmR2xjWitJcHVOZXMyU0YxdDhMc2doUG1kVDFW?=
 =?utf-8?B?SWxKWkJ4bFZOTmVCK25TRzdDVVpIYWQ3TGFwMzBMWGswU01RWGR2OTg2YVFa?=
 =?utf-8?B?dWdrVS9reWlUMFBYeHRjSTVKdGlRbzRsZjI0YmdTendNd3VlWGF6Nzd2ellM?=
 =?utf-8?B?SXZ0a0NPUk8rNnJuQUNPN2ovdW8vUFBGaDhFMzhucDNoQmd0ZU01dGVBL1kw?=
 =?utf-8?B?d25aQm1vbGhmRlk0Wm50VWlpa0JVWmRaV3NtYzJNYnl3OHBkNWxsM0dxY3hC?=
 =?utf-8?B?VStPVUgwTnBTcW1BMW5tOUV5eW5NNFl4bG9HRXpOVXdLd0pESVVoK0h4aGVD?=
 =?utf-8?B?M0VBYU9ZQk1RUExpSC83ZE51ckFxdS9WYXhRRmdqa0dMY3hiQ0w3L01iVzM4?=
 =?utf-8?B?aGl2NlVFMlRzZ1RNYWpZc2Z5eVZlQUk4VGtCN2IwbFEyQndUZEphNEh6bHhD?=
 =?utf-8?B?dzVGWHZ5VExuTENuYVVWYVVuUVY2TWFvWHZ0MjFkSnBBSHFuZkd3RUc4b3lV?=
 =?utf-8?B?OTdYWnhLWmxHMjh2cStkZ2hmY3ZMaDBrYUlkbUFTaTM2MkVrNjFYb0dHaHJL?=
 =?utf-8?B?cGZHczJOVkxLS3I1Q0g1d3JUc0g0YVh1bkEzVU1RMUdNVGFXUUt4T3VWN1dX?=
 =?utf-8?B?OTRkQXlBYWxsTVk5SXJIMTM2V0dldVVqa2c2THAzNitvSVFaU0l5Y29sS0FM?=
 =?utf-8?B?U1ErWmZhejhmTlpqamZ6Qk92RUdUZGZBVkxuVjJkZS8wS3E0NWRFSVhIejNB?=
 =?utf-8?B?ZmdWKzJNa2t1Y0RXN0ViU2p2eG5wdllZeXV6Z1VBQUsyc1RrZHMzVzdRRCtL?=
 =?utf-8?B?a1A2VWUyTDMraXV4bGM1NDN1cXVUelhNaDMvbE0yeHlsak5UM2ZiZFBkTzY4?=
 =?utf-8?B?dTFiUFZIRnp5ejBEY3ZYdi81QVByQnhEQ0EzMGdPSXlNeDltaGtIVDBXVDFt?=
 =?utf-8?B?VUY2UkZ5MzNtKzAxeFN5NmxHd3BNUEJzc2VHVGpzeUhJTzJZLzBaUTNvS2cw?=
 =?utf-8?B?a0dtOGs5R2lhck51OWJsbGY2ZFdGcWdybEFxTThWZmVrRWRsOUNLRzUyTDBt?=
 =?utf-8?B?WkJXK25td05rTlVtejdLK2NIVjQ4d1FKNlhWTk8yUkRhS0I1SEhxbFlkK1d3?=
 =?utf-8?B?WUtmR1hKWlkrWDVRS3BPRUsrK3Jhc0ZWWi9lMm9iM25lTk9jMDJDUXh4eXg5?=
 =?utf-8?B?bUh0VzRPVituSnowTU95MGg0ZUFIcWFxbyt2dVcrdGRjU3NzSE1CZTF0T2Jl?=
 =?utf-8?B?K3FudFFZVjJLRFFiZFJBa204eDJpRGF2VHBBM1JsOVZNSm5nclIyVFJyN1o1?=
 =?utf-8?B?TjZUbVpxdzBwZnhKaTd2d3UzakZKVm5wenF1YnBlRTlUa3d5VTA0VHBpUmRE?=
 =?utf-8?B?R3Z0dFdjRG9vQVBKZGttcjVPZTNHc0tJcFBSTmNycXBBWmJyTCswRnJuYzRu?=
 =?utf-8?B?M3Q3dldSVG96blRRS3FveG5DaENxa01MVmlvQ21SQjZrclJudDhBV2dTeGdp?=
 =?utf-8?B?dHFOZ1pUZEN6a282Z2kwNlVrdWdNbDRzd1h3b1BNRHp3bHkweDRjS1pzUFN0?=
 =?utf-8?B?aFJpMWZvVUNHNDNtUnFocUMvVTFRZ1A0ZldXalhoNEYyc01vYk1STEtRRjR4?=
 =?utf-8?B?RFc1SXRkYkJna3d6SkZoM3V4M1Q4cnhTZTJmMGFVblY3bm9jck82ZGlXbm9O?=
 =?utf-8?B?ZnFsdFI4TExIUDMvUGU2NnIrOUY1cS8yNVhmYStwU2E3a1ZXV1ZQcklhWU4y?=
 =?utf-8?B?SnZUb252Q0VWWFQ4TzY3eGlFYTRra2VrcTR4eWxCdjJUMzRydDVRc0tYcUxI?=
 =?utf-8?B?ZWExOXA3NkFwWDQ2R2pzVVVFR2FYZDY2QlBVWGpPODd2VDM1RC9TanB6SnhS?=
 =?utf-8?B?L2tFRSs0S045VnlGeWo5TEkwMkFlN2pkbnVWcXAxU0hPMk1wRnA1UDdWc2g5?=
 =?utf-8?B?UmlkRmh5NWJJeVdIYTJrb0RLbWdDenJwR1JMVmZjbjJVM1ljR0NLSmRCVnJs?=
 =?utf-8?B?SVl6SjZybkRHNGdtbndpQkVkZWhHODgyR1Vwai9lNGtmUlBkaVVxTWlpU2w0?=
 =?utf-8?B?b09JUWFWQWpqMEFwZ1lCK3B3bjR6ZGR6M1NxZG5LdHdNU2Urait3Y0JmRnBY?=
 =?utf-8?B?Y1ZHWlZFbFhkWmMva0tTajg5RGlBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac089353-6ed2-45b7-e093-08ddd8e9883a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:12:48.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udc4fg0+gESJmvHektRP5ucirEaH+pcxmbFTlCPBlDIPRazGzbEBE06WG6KIsjUYAVebaE88hX/BNgcMeWt6U7HbZUIVbrMdJeaVYsiayPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
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

Hi Andrew,

On 8/7/25 4:28 PM, Andrew Goodbody wrote:
> In pmic_reg_read ret is only assigned to inside #if
> CONFIG_IS_ENABLED(DM_I2C) so move the test and return ret inside as well
> and also guard the declaration of ret with CONFIG_IS_ENABLED(DM_I2C) to
> prevent a warning about an unused variable.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/power/power_i2c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
> index c2fc1c6b42f..58289ecce67 100644
> --- a/drivers/power/power_i2c.c
> +++ b/drivers/power/power_i2c.c
> @@ -75,7 +75,7 @@ int pmic_reg_read(struct pmic *p, u32 reg, u32 *val)
>   {
>   	unsigned char buf[4] = { 0 };
>   	u32 ret_val = 0;
> -	int ret;
> +	int __maybe_unused ret;

Or move the declaration with the struct udevice *dev; afetr the #if 
CONFIG_IS_ENABLED(DM_I2C)?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

in any case.

Thanks!
Quentin
