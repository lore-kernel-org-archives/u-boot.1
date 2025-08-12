Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EBEC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4980983290;
	Tue, 12 Aug 2025 16:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IRh7q80I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D721833C0; Tue, 12 Aug 2025 16:26:19 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F328F83145
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHMzStDY/kR7q0ezqPRFePyYL7lrLC0LzZf83J5O0PoCFuTwvwFVkLft3Gdx7gDiDZrk8HQslqBL23OdRFWI5/qhdnHMM6qrDM8SpbsG1OB4VWEr82txp7OF02yWkEnPvU8CfGYA9u/72rt1sz1Y0OolJdbyGxfUH0nC+a9/YrvHwQhXpRL973LBc21Olk/Mc1TYI72+tTGW5FfmDdYTSdx/Eceglw0KM3nNbpIwerC3EJR+vqN0zM+S9cotVY9umKT7G1pHy0A7tANUrZCTJ2dNkXU05FtVL4x6F3eDV6hGU0RLV6Q5TYffaE0/TORJ6uqBC9Qt4+3+CnCy755zPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShQNlliL1oy9PFsW20F83tC2IW18mluuL/wUTbpPp8k=;
 b=MpqcOMcy+3tcTTBPSJQmmX1YpWAhxbXDXLrzJq4bbqIym4DO4O/pB9ib7JbKx0JKc/PRTaqGuo2ntAs8nOHjsUMVajhBoL8dCGXVGUVGkbr4cr9NlxWnNRdbUu/RCIBovfB52aU4fsnfioK/MroGf5UwogzyQEk+SI2Wr4JHoROssBSgTHZfSa9UH5r/VTileAqF4ZM41vqvU4WHb8s4QhigW5Ieoqd2q/qF0MskFytq2ddT0gU7Rsj48dWSHOi4rs753QmYAllL30tjOwKy+PI19vu6SXYFynjEaeyhueWvZrsStmewDML/mjH38G54jwcLpNjmoavwvahuY2vMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShQNlliL1oy9PFsW20F83tC2IW18mluuL/wUTbpPp8k=;
 b=IRh7q80Iwx4BPpmOdBex8uWVQjbmO1EFDGnrCwyK46HjlijYOIDqrath9a8qEeKx1vK7FF6RFVDQgJusN+DpJ76DwnvNXOZKRidB6VLCiUdkRCvtIirCmbk2NbngjZVwT85aAhe165UPTdyFU76EzM+Rf8ZFeJS5A6ZF43HpCe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 14:26:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 14:26:15 +0000
Message-ID: <c455fb2f-a71c-4939-ad5d-0c7c95f01431@cherry.de>
Date: Tue, 12 Aug 2025 16:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
 <20250730172438.GU1807455@bill-the-cat>
 <8f60f137-0e58-4dd0-9c7b-dd8bce55617d@cherry.de>
 <20250812141524.GN124814@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250812141524.GN124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 8333b0c9-c231-48b4-778b-08ddd9ac31f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUhsMzNsM2VYMmFlLzNFWTNKTHNSTnNBdDRmT2ZORkNpZUR1RTdweGJVcjZ2?=
 =?utf-8?B?QTVha1R6ai84Y01zY2dmYmppVG9zY0hvR1JtTjM4MCt2WkpjMUtVaTEyRzR6?=
 =?utf-8?B?WUpuS08vMFlZOGpGSWxBNUZzcFgvTGN2U09YOXFXbDhzbDFobno3ZTkyVU5R?=
 =?utf-8?B?QXVjNHZyTFlPdDFxUGNJbTk5dFhZdjJyNC9jK2pnNkV5OFJOeVZRZDlTN2FT?=
 =?utf-8?B?NWtxVDgxVXN3S2Y4Q1RyYzhIMWhTQWI0cWY5QU9EalAzQjV2ZmFZUHlVbWxk?=
 =?utf-8?B?WWdWZkQwbm9BUk0zMzdCWEtkVldqRUxra0pLSUpQdlIvOERUaDE0ZGdnWWo3?=
 =?utf-8?B?YmpIUWoyQmNkVi9YaGRFWExKOE05dzJTV0VSMTkzUHZ2SWhPZGN6aE9zeVl0?=
 =?utf-8?B?QzZwRWFHRU44U3VGWW95VC9XVjArZC9kWWpTbXJCa3JKY01IN3hKOHhGcWFy?=
 =?utf-8?B?R1h2NDFwZldjdEphZ2ZOUzNVYXFOTTV4RktWK0EzVDFiVmkzOHZOYnpPWVdE?=
 =?utf-8?B?WUlFa3IyNkF4b3Fsd0h5YmpoRm5WdnpUTzRML3RWKzJvWmEwcFRFRnEybFBU?=
 =?utf-8?B?WlVYR3FUNVRic1NMZWVQNTFJT3V1aDZpYktGYk56WUZZQlFVOVpZNWUxa2c1?=
 =?utf-8?B?OEl0NlJ2Ri9ta09OM1NTOWlQaHpuSkRZeTVCYmNrWks0M1NIQmY4M3FsOWx1?=
 =?utf-8?B?RUpYbkFYVWRVTkg4QmtOYXNubW16WEtBL25RdGoyVVRVaE9vNElYUENXUXlH?=
 =?utf-8?B?REVrc2huWElzbjF5KzJ3SXUwR2VuOTJaenQ4cDdsRFpwWVIyTDhteHowNkh3?=
 =?utf-8?B?UnNQZit2cDlGUWYxVzVlamlPR05EZ0JLYXhvZHFUa3FuR1R6ZFdVMENiNzV3?=
 =?utf-8?B?SnlrdFhoSjg3emhZeUhwS3kxSVZucTl4QjVCQkN0Y2V5VW9DcEpURE1mRzhr?=
 =?utf-8?B?b0cwZFlDVDdpVWtWQXhTL3RuaHBrSFdBR2hwd1RzQjZRd0Vpd0RnQ2plRDFs?=
 =?utf-8?B?TWZNOHlmSm5vYXBpdU1yeXIxeUdKSVUydUZSMm13V2dVTTFLdkMxeDBxUEkx?=
 =?utf-8?B?NlpuL0JmUUVnS0F3ZmlaZ2pyeEpTcWhyTXZ5OFE0OWI1UzFIbURRSnQ3ZUs4?=
 =?utf-8?B?VGtyYnZNODVvYlFxK2xhdDI3S01rRDcveW5vQ1JEdUFCQ3I4WHMweFEvclo1?=
 =?utf-8?B?aEhYM0lTeHVUWDhYREY3cERQRHd3SDhEei9DQ2JrMWkzRFJqNGtDaWN0eFly?=
 =?utf-8?B?ZitCU3V4RkFmTnB6VlRCdVFmZVpEbmlmUDYybkZLNnhYNmtSRXhYWFkyY3R2?=
 =?utf-8?B?TTJLUEJHbkZRa2RoNHJVQUo1Wms2V2pqQmoyMjlOMTJiY01GbUxFUEZwa2pi?=
 =?utf-8?B?VThHRjlWWkFocHlPQ1l6UVlNKzgwOHhWdEVTamkxMkVLbUZMVGVwSjIyTmFi?=
 =?utf-8?B?a2pXV2NTOE55S3V5T1AzV0VtOFIwQkJySGZvZHhISzJvUWg3M1c5Wmxkdk8w?=
 =?utf-8?B?M1RkZU1XbEtUS3QwckRkcmZhNzc2UGwzVUJxSjFFc1R0SVpUellpUUM2SFVY?=
 =?utf-8?B?VkFzZGI0U1R3cDlHNEoxK2tsMThTbVVxelJxMnBHRFpCWEpRWFFZaGhpTjUr?=
 =?utf-8?B?Wjhpam5SYktJcTRPYytBd2dRUEFnbkY4WG9pc1U5aU1XV0dsRkJZVExtRlNi?=
 =?utf-8?B?YzFJR0h2WGdqM2hYL0pONU9jRGRNSXB4QTVNSUV2K1ZkS0FaL3J3aUJIOEtp?=
 =?utf-8?B?RmVLWVZFeGJoQWJOMWdkalp5V2dvYWJrWkF6ZXFsVkkrck81MEJUVDZJTGhQ?=
 =?utf-8?B?ajVlZUVWZEx6Q1ZpM1RqL21lNzNNT3VHcHB2MUxyVk9HR2NoVjNVd29OUFZO?=
 =?utf-8?B?cTFQdlovMzczRWx5QStyZ1Izbi9wVmRxM1pYd3JIYzhPRG1XYUt6TUU4YnJo?=
 =?utf-8?Q?GGWcpXQS1ys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEh5dXVUSkxFSm4zSlRibkVCaCsxZ2k1eWlNODkyRkNXMENQTGdDQWtKazBU?=
 =?utf-8?B?RzVHRTJvdWhCQklzN2kyd3AzZU8yVSt3dWw2Nm9adjZ6Z2NmVjU5dHNZU3Q2?=
 =?utf-8?B?Qy9hbDkxRTBiMFQrakM2Mk9KbEdSYlRidnNHODJGdGUrelNBSHU0ajU5VjM3?=
 =?utf-8?B?Z09vTGRZVjVFZGYremJBZUQzSWE2UkNxV25uSWJmNEk3cEhnYXFZUEhhTFJv?=
 =?utf-8?B?TXZJOW5SaHN6S2pzbWw3aVJsVFlwQ0plMnVKa3FkUWZNcGUvU3VEb2h2V0FT?=
 =?utf-8?B?cjdFWDlaYWhtY2FNMWc1TE1PMGZjSjNIUWc4ajVxVThwVkNXWUFsVDVxWUhP?=
 =?utf-8?B?elNYK2FWRFlYckJXYjdOQlI5bXZGajZwT2ZnalJtb1U1R1ZvSEJ0SXVIL3hl?=
 =?utf-8?B?S1VVYWk1Y2ZTd2lqa0QyaTJablJZOEpicjd5NVY0Z0RRb3oxZGE0WmEyTHNB?=
 =?utf-8?B?VTZnNkFRN29iK2xaWXp0bi9yRlYxZmx4bjlyNVBJbzB2ekgyc0w3VEtzTHVy?=
 =?utf-8?B?N0NSMkdwR2l4b014aUpLUllxeGJEYmtRQ0o4RXlVSlBLVGR0dHlkRU5RWW4w?=
 =?utf-8?B?Q0QxdHJOUWhXNk03U3FBMzFuSmtONUlHTkhadTRRN1JBYzlqT1BNWE9UekZp?=
 =?utf-8?B?NCtSTC8xcStuSWNHdXl3OHlRTmVyTDNsNDdwTmh0OUpqQnViZkZsUWR1aUlP?=
 =?utf-8?B?OVZCcldaREluMXJsVmc5eDRSRW93blFtMXlLWmMyaFpEWmRwK1BDV2Y2aThj?=
 =?utf-8?B?K3RMbU9TNzJLQXBqQ1F6QWpDU3lwRVo1TE5VMW9jTEJTc08wZFhwNFkvV3lX?=
 =?utf-8?B?elZqZDBHTHlqRnBORFo5MGRsaU9xU3lNYlR0a1F1TUx2anFhS1hJT1drS3lG?=
 =?utf-8?B?RHFQWU93aE5LNzRTM21xS25XZHhKWThBdEtJMmNWRjdZcmxzQ20rU0l5VEp2?=
 =?utf-8?B?ZXVWL3RrN2h5MFhsRFo5aUdIY1ZwOXFZd09ZMWJuSE8zellsektqUU1iR3g5?=
 =?utf-8?B?ZGZKaGJMeXJZRWU5K3ZnRVB0OUJMbk9pcko5VEp4Q1pqVXFnajN3U05kbndD?=
 =?utf-8?B?OHdTazRRTHlSbGhaYjM3ZDRmTXA4amovQVk4dTcxQXMzUmJ1dVFad0VQTFVS?=
 =?utf-8?B?TkUwanAyaHgvc3JIZmo2dzVyczh4c3pDY3lhbjAvdFlpQ1Y2UW5MSHRLTXg2?=
 =?utf-8?B?cElzelk2YjJDc0c0bTdBcDhnUHM3QzZuajViMUEzeHF0R1MrTnFBaTdBTWdH?=
 =?utf-8?B?TGZzVXQrVTZ1cmpteGZCaEFXcFZFbnY5d1FWV0pJK1J6aHh3dmdjaG42cVZs?=
 =?utf-8?B?S3VIWmkyN1d3UW53Qk5OWWtHYnF2OGEyNStFcy9RMlluZ2lNNUROYTJmOGh1?=
 =?utf-8?B?RHg1SFBtRHkvdGFhWU8xRXM2eWNUMFgvUW53T0JSZkJkbVp0TmhhOVl4RVRx?=
 =?utf-8?B?Q1R2eHY5SXdNMWxjT2Z5NHdCYUZLTFA0SXVmNExLVFdLQ3EybDlkZ2ZqWXdT?=
 =?utf-8?B?eDl3SWhybTNHWFNoYmY5UDFpYjBMNVpwcUkrcmhlOUdScmx1c01FaFdCK2FU?=
 =?utf-8?B?cXlaQytWUVFEMUpoK2tPaTJXQXlvU1NqOXhFVUw3eVBBTGdPQXJ5UzBTdjBF?=
 =?utf-8?B?M3R1c0Q5UnNod0E3VW5zWU41RzUxQS82TnBxb3ZYV3p0TWM2YkxRcGo3R2Y2?=
 =?utf-8?B?c0lhOHJmUVU2SFhXelpXdjI4V3N0VEpPVGlUdlhwRUl6VmVtK1ZjM0VEQkhI?=
 =?utf-8?B?NnNoRkhLYWxoVDBiaTgxdmkvbllkRHVmNStadXBtNlEwb3JIOE5yVVF4Q2I3?=
 =?utf-8?B?UHhDN3V5TXZTclNmSW8rV2RWWGRQN1VMTWdFNGZwQkxMLzgvV2o2OG9pUlMz?=
 =?utf-8?B?cnJhVTNOZjZqUFl1WnlGakRBZlU4SkdNTHVFOUpHVmVJc0ZkRm14aldSc2JM?=
 =?utf-8?B?dnFRbGV2eUJ3Y0lmSTBqa1NKb0I1SEs1Tms2UW9wbnpQQnZIS0U1ZkZQLzN4?=
 =?utf-8?B?ZnBoV0FyWTNzLzRVWndldElrN25SK2VZc2wrWGt4aFFhWkpXdWxUQlhkTm9v?=
 =?utf-8?B?bGdvcU5BaUtVTi9Mc2JzMlV1Y2xxK0c1SWxNTHBWWUxLS1d6dUtiajR5R3I3?=
 =?utf-8?B?bnRSSzlPMHpUVzlvK2lLS0k1NUN5MG02UXNQV3F1SVRFVzZEeFAreXFFUGJw?=
 =?utf-8?B?dGtuMkFocGRXWHpnakFwK3p1RlBlUUROOXdETGNYdVRZNEhDWDlZOUZpVGhk?=
 =?utf-8?B?cUlXMU52clpqWDFtc09KRGZwN1JRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8333b0c9-c231-48b4-778b-08ddd9ac31f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:26:15.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v52tsrurptR+GcnfLlwEc2NMSCckR+NEXQw4tm9ABed2s59N81cKOg9KFEkVh4HX1yBNWlMCMyYpJ1p7B6fqBr1HOieBzbAskNOfMironIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
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

Hi Tom,

On 8/12/25 4:15 PM, Tom Rini wrote:
> On Tue, Aug 12, 2025 at 03:15:00PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 7/30/25 7:24 PM, Tom Rini wrote:
>>> On Wed, Jul 30, 2025 at 02:03:18PM +0200, Quentin Schulz wrote:
>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> U-Boot typically can be loaded from different storage media, such as
>>>> eMMC, SD card, SPI flash, but also from non-persistent media such as USB
>>>> (via proprietary protocols loading directly into SRAM, or fastboot, DFU,
>>>>    etc..), JTAG, ...
>>>>
>>>> This information is usually reported by the BootROM via some proprietary
>>>> mechanism (some specific address in registers/DRAM for example). For
>>>> Rockchip, that information is stored in a register
>>>> (BROM_BOOTSOURCE_ID_ADDR).
>>>>
>>>> While we already have the information about which medium was used to
>>>> load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device), this
>>>> new property represents the medium used to load U-Boot first phase
>>>> (depending on configuration, can be VPL/TPL/SPL) which absolutely may
>>>> differ from the one used to load U-Boot proper!
>>>>
>>>> It would be useful to know which medium was used to load the first phase
>>>> of U-Boot, for example to check fallback mechanisms (proper loaded from
>>>> a different medium than first phase) are actually working.
>>>>
>>>> For now, this only applies to Rockchip's U-Boot proper DT but could be
>>>> applied to the kernel's as well and possibly for other architectures or
>>>> vendors.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>> I have a board (RK3399 Puma) running U-Boot which currently has 9 boot
>>>> scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR for the
>>>> next phases; not counting USB loading yet, which would make it a few
>>>> more). I cannot force the BootROM of this board to select a specific
>>>> device aside from erasing the other media.
>>>>
>>>> The only way to identify which device was used for the first phase is to
>>>> parse U-Boot first phase console output or add some custom logic for my
>>>> board. To validate that a new version of the bootloader works, including
>>>> the fallback mechanisms, I need to make sure the BootROM loads the first
>>>> phase from the expected device otherwise I may have false positives.
>>>> This would be useful for automated testing.
>>>>
>>>> Patches pending in the devicetree-spec[1] and dt-schema[2], hence the
>>>> RFC here.
>>>>
>>>> [1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v2-1-5a315d9bff26@cherry.de/
>>>> [2] https://github.com/devicetree-org/dt-schema/pull/169
>>>
>>> I am conceptually fine with the changes, but this needs to have the
>>> schema side approved first, just for the record.
>>>
>>
>> Now merged in the dt-schema (still no news on the spec side though aside
>> from a R-b from Simon 2 months ago). Is that good enough or do we need to
>> wait on the spec part too?
> 
> Ah good, OK. So should this be in v2025.10 or will v2026.01 be OK? It's
> small enough I'm OK taking it now.
> 

I'm fine with v2026.01, there's no hurry for me as I can carry it in my 
downstream forks until it's merged upstream.

So, up to you!

Cheers,
Quentin
