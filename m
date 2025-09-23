Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF13CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 12:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F56D833E9;
	Tue, 23 Sep 2025 14:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JTx1pb/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196E1833ED; Tue, 23 Sep 2025 14:14:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA63800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 14:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkFG2MJWdOtEtT4Ub7Z7I5cSDCfiax4i+wkLoUQ7XvpDA4rfrydtdKeGfCwRzgDLfyCrFENKqCF3nTmpgu56ktTKEELl/ovY+jTKbqkGjYuvaFiw2VKqCnIHwVmo3bglsf+xDULzzdCRhqjNjUAtu8G1KzZ5H1vsLxdv1Pv0KhpH67dEzx0yfiRLneXoCZMU8Ub8P8svca9b4dULP5BAJ3PZ+SiZjiHxz5dLfN9wiQgP+TwnCWowzORUd9HcTzPul3WaFoe/ChW+woZEqcvdwU+Hc8pJa2AmGhsQVjZ1Dy3MvMnAG1TbcEcQt/6OOOuVVCpq+uxQT65s1jCWtbbjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/TmU6uMhIVJe2lswy9p5u3uNeaHuFRi8sZgBeoBmLs=;
 b=oieDQPpJyqOMlhXhjsrcqH3OmRKugStD7iW7bY8JjJU0iG8nwkDllcLgJbTQbqTYE+OWe2pJ6BYc/WoFSa6qvgtOps1/9GUbcacj6+k0Ps1R2e11ZAnSNTUZIGaDQlhMSQg5kTbYYuNX/ZHsq1AebIiZMJbm8+XP3ehy0xAoUAOtE9gI/VqINUMLLmXeC1C3wpRueWSY3tNgoAH18xCf7esRZwugPnSwDMHmitRzltOtVfYTFDeMhOgqwjZcDXfliX9dvXT2nzioxaknKe7zSeTFGahZ+0ucrkDQvrXWmwGONtKDxxIscQc1hiuvetGPDekiaQDnty0ospbqJQe9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/TmU6uMhIVJe2lswy9p5u3uNeaHuFRi8sZgBeoBmLs=;
 b=JTx1pb/VJH2OncU+UTHr2RQVt3cXG/JH4G6VLj4EEA2+lJHr2oZql8pcFUwMLzmr8/eeMqWLakuHHIsgTHC/lmfOnxBtkOnNQxtsnbSB538K+l7ikiEewdTrLF3NJ5DYPEfooWmYJjtYTUyR7Mn2dYnkSbrfSo3glt8tzH50uRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 12:14:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 12:14:30 +0000
Message-ID: <f1694902-6b69-48e9-aae6-1f0801c72a21@cherry.de>
Date: Tue, 23 Sep 2025 14:14:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: Update mentions of README.fdt-control
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchart <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250917011720.1148189-1-e@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250917011720.1148189-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cabfec6-bdac-4d11-0ad7-08ddfa9abf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVQxQTVSMlczUllkMnNtQzBkeVAvREJEbHVWb2tOVmV1NkNNQ1pVd3VFR09M?=
 =?utf-8?B?SzhBVnBON1MvUG53cTdnZ3V3aUJnazFSNEQ2aTZLL1c0S1I4WGtxbTdSelJE?=
 =?utf-8?B?bFdmM3p4Nkc4U1gvaFRoSUdKdDFGMEF0L2kvVjkxTno3NUQ3eGhlN2lqUFNG?=
 =?utf-8?B?UjhVenVLRHhmL2E0Zmc2dzhrRzg5Qy9scldXbzdFd3gwRWxNcGdOM3NjNWpw?=
 =?utf-8?B?bk42bVJHUVlyTlR5Qm13K0FFNXhEZ1owUldnSnRYdW1kUmNLb3JHQWx1MFRm?=
 =?utf-8?B?ZlVuUEZUWlNTWmVXMFlqd3BLdEZYdE5PenJLNitUbTdJaVpHSk5nNXpkOEd5?=
 =?utf-8?B?M1R3TXYvTzU2VFhBUkRKQmt5UjdXamVGdjZnK01aS1RVRE80OFpHcTFjZVow?=
 =?utf-8?B?UjNTQ1FBWHVQL1U2R3ZyRDdqVU82TU5JRzdONGZLT09LRVp2THhKcDdodXli?=
 =?utf-8?B?SzFUWXEzK0hBNTJ6aWk2SUVyb09aVHpMd3pkb0lIZ3FCNGlhTVU4SVltNHRK?=
 =?utf-8?B?ZWcxYTVQTUZLRHNZY25acHhETFJwVlRTVEZTc1VOdEd4VHAxZzlQVmhPekRS?=
 =?utf-8?B?SWR6bUE1eGtnUUZjamUxVXZ5RkRpeVJsYlRXeXhOMVRFWFNGUnNtK2t3M3JH?=
 =?utf-8?B?SXNKbzZhejlZckhiVTVYWFM3RkdDaTZoL1VOY1doRzlEblRJQ1NaR3hndXlE?=
 =?utf-8?B?RXdLaXgwL091dWQ4eWRzcHFsaGVqR0FvVGhaTDB0bU1zVStrSjByU3lybEtu?=
 =?utf-8?B?aWZMcXN6eFJPQkQ5UDV6Vm8zK29ZTFFzTk1aS2RUcVk3bHp1RDlCL0JlVFVj?=
 =?utf-8?B?ZUNkWXdFVUtNb1ZNSjhzRHpWM25DQURObUFUaUJ4dVk4VlBiY2p1Mk9wWUZG?=
 =?utf-8?B?ZUtOUmdJeHFrTlB5WnBqNWk0UGMzbkUrWmNUT1hmeEFnTEJlY0tGVFg1WW9l?=
 =?utf-8?B?NW0vZGNVUnZLMms2ZEp5SlVOazVRbTZjOWFzdjlWUlZEMFR6MVFaeVQ1K3JI?=
 =?utf-8?B?VmQ5ditlT2JNSWhDekw0NkRXaHhLTGRPcFczVnlXdXZCeTFXOUFaa20yMTh2?=
 =?utf-8?B?TmxYRFBhOWNtMzNITzVoajVRcDVxc2g5WG9FYklWc3lhK2ZBcTJZTkJaTFBi?=
 =?utf-8?B?T2MxNUtOeDZyd0JRbjhPUzVDbGlldFFxTXJJRnlQL1dOZEdYWk9yaytFWXdw?=
 =?utf-8?B?S1gydVR2a0V5azFCQTJ4c1ozYW5NeG9TU256bTJDZkI0eUtQQ1pZcmY0d1pG?=
 =?utf-8?B?YkJJaE1ZQ2d5MDhNd1M1MXVMMjYzS0RpZm1YRXdBdHo4bXZaM1BhOWhNL1Rm?=
 =?utf-8?B?SUV2TjBobFVGZFRZK1M2Q3FKcDNvWXB2aURoRkE1b0xEUENrMkFlL1daSkR1?=
 =?utf-8?B?QTFlOVZaL3JYYWhLQWsxS2ZIN09xbTFmdlFCcUJOWVhqTE15MmxlUEd3WXps?=
 =?utf-8?B?NEx0dk5uQ1hyWnoxRzJOY2ZDcHBjSTVXTHlrMkVvZkdKNWhMUmk3SDRtNU9W?=
 =?utf-8?B?RlBtbjUycTlVdUYwNnVGKysvTmZQTXNmZ2JSMDZxMEs2NTJkM0hJam5oVkVJ?=
 =?utf-8?B?NlRNb2RnWjQvZWlJTHhUbTFBQU9Dd3ZTRXNXYmdCaWVOVFYvSjd1NlJVSTVS?=
 =?utf-8?B?MnV0bU9Qd1I1QnBjZ25hcmlDeXhMaGsxeVp2TDBhVFJXdXpLcmhpcjlFMVhF?=
 =?utf-8?B?Nm1DMXczWWkvc1hJc1RWN1h2UGM0Y0RqdmlsTmM4bVY1WmhVa3pPT3ZyTEEr?=
 =?utf-8?B?NmhWcE12b1pUQmNTRWZjVGpUMmlnNU13OGxsbkdNaloyQ09Mc1VXNWNCdG1j?=
 =?utf-8?Q?g6+kBaDYVpnPHpjlrqf4R2D+GfyJboXv/G9Gs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlljTVRESmt2ZlFrRU5xVWJpaXY3RmtZRmJpbVRFWGhQQndHZndITW1Odmd2?=
 =?utf-8?B?cXBFeXNUWHM5VkoxNUozVG0yRlAvZ2lPNjRVc3E3cXhaL2h1RHo3aDhremJN?=
 =?utf-8?B?eGxKczZmUko5anlkSkJlU0UzTnlFOXN6WDNCYXJzNC81SkxFQk9KWXpGdVZ4?=
 =?utf-8?B?Z3k5ZVplc095eitQTlBDTVhPR2tUMUljT0dmS0tQMTNiUWw2YTRMaXFKY1RP?=
 =?utf-8?B?b1lYVTA3M01Ya3pkWWRJRXFENXRqTlQ4akZFSDdHU3h6V2RDYktNQTBKMHRL?=
 =?utf-8?B?bXBMV3FxVE5OTTkyZHA1bDBuVnFBNHJlY2Y0TyszZWJHTno3NjBmTkhVQTkx?=
 =?utf-8?B?LzhWbUx3V3cwdnpSLzV4d3J2S2NZVW9mblNJWXVHclA0SjVxbHNhWFRuU3Fv?=
 =?utf-8?B?SHpYY2Y5Tkd3M05tRDlYK3AzYTFvM2xmcHROR0p0Mk5zSXVxWlNGdUlXUFNo?=
 =?utf-8?B?R25RcU5kRGtkY0wvMG5sY28yODJTYkg3dlBhQ00rRXVTMjRPYnptaXplNHla?=
 =?utf-8?B?K3FWSTA5aU1rR2NpL0lGMGxVMExHL0xQaFdrWWFyV2o5N1JyNEdDcHN0Q0dM?=
 =?utf-8?B?ZThVVVVxb3hreUhYUkUwcTNSend1N01GNTJMaHd6d1FBMWRldGRkK2tTWE1U?=
 =?utf-8?B?SmhaVmdpY3BQRnV5eEQwRjY4Y2V2SkI2bGVnTkhlN0Z4YytmeUVXWWpnWkF2?=
 =?utf-8?B?NDd2aWF1Z1lhekNESXZZVDBQNTk4QU5tUVh5ZS93dlJnalpEU1NFa2ZmZ2I0?=
 =?utf-8?B?NWpoKzlqT1JDVjhVNzU1dlNhNm44cDJ5YXFDSWdRSytQOUhqWXY5SGEvNnlB?=
 =?utf-8?B?N045U2t5cHlVaWxGUWVEQ3ZjazVVWm5wcGM5RzNSVENLZmQ5SGZIWlI5dUt5?=
 =?utf-8?B?dloreHBhWDJySERqN1U5VVlBbm5Jb2dROU1TOUpmbHJybmhZUm02NUpxTWZ1?=
 =?utf-8?B?VFBSNGxtakI2S2NBM2JPQzBIV0pwaXZHaHM5TEt5dWwxRGJmd3JvWU8xZlRx?=
 =?utf-8?B?MExYOWs0cm5KU2VMNG9MKzVOUHEwcmJ1OUNaNXBVbXNHdXFrdWFmZDhnVVJl?=
 =?utf-8?B?RllYUktRaTFpUmxoWEhLY1FabXVEeUJIWm13OTVjaW41YTJoNTdhRnd1QXBh?=
 =?utf-8?B?a1hxZjVhYzhBRFdNU0dXM0xjN0NiUXNMTjhKdDlWcEJEbWxmdG5nTjE2THdN?=
 =?utf-8?B?RFZJOW5NaXdaWFJ5UGo4RVFoMERyR3hFR3BJdDAxZ2M0MkRHOTZjY2x6RXhD?=
 =?utf-8?B?UmV3RjBra0JaSjZmdEVsZS9LTDFRcWgrMll1S0I4cUd5L0JYMERmUm1Xa2VR?=
 =?utf-8?B?NFFET3VxdXZUV3lyc2RFRWdaSWpaSFVWWitTVmVYL2lqOERuc3gvRmJJbzM3?=
 =?utf-8?B?SWdSTE9EQ05TUWdrbnQ1N1VuZ3RPcHMyaHQwaGJyVzAwK2d4Rm1vZ1lSaDhG?=
 =?utf-8?B?cURKWnlMODdtZHVtSFlJcWpMTS9MRyt0SU5sNUpnUmJsWE4yMytySEhhSHRX?=
 =?utf-8?B?RXBnQjFiemFTNDJNZkpkc0hnYmo0aUkyYlJGSWFBR0IyZU1KbGlxclNEblRI?=
 =?utf-8?B?U2hUZFBCRnN4OGFhaWt2TzQwdUdYQVRQRkRvMUE3VE5PQkdxUjRrMGs4dmFR?=
 =?utf-8?B?aXlkeVNCMUdqQ2FBQ3NrK3oxODZKQ0cyYy8vbVREM0RqZUR4MWxkSWcwcEVl?=
 =?utf-8?B?RlFPL3llY1lvc0NCOCtQbTFKazVKb0lweVJzMms1aFdVQUxreFRWbGtlL1V0?=
 =?utf-8?B?TnJubVY4VnBwZ0FldEpHQ3ZFMVcwcjhqMTZNTVFIQnhDQW4xUFhqZ1ZibmFD?=
 =?utf-8?B?T1dqdEtzOGJPSHBRaDlvM3R6NDd5OWs3TjcyMXhiL1BKdGU0bFM2Z1RMSnhB?=
 =?utf-8?B?MHNsYjlJV0FYZWNrU1MxMlFKaDlkTWRsaFBhaEprb25tUDdZd3lUSnlzSlh6?=
 =?utf-8?B?Q3FoYlpXU2tIU1A1S1E3djdmekRFQkpHSVYyUFdkODJDbG1LUStSbUhwSFR5?=
 =?utf-8?B?ZndiODhOSzRjUTJRZDVPbVJnaUFic2Y3cytkbmVxd2VKS3BKeGtJWE90dHhZ?=
 =?utf-8?B?UmJ2dDlQQ2l4cTFpOGlDRUovd0VsMG5ZZ01Hak5DeWlPelBicVdzRnZZRTdF?=
 =?utf-8?B?RFJ4WnlmVmZXYkRhdDRscW5KaDR6OUNaKzh5YzVtZ0ZoYytNcmhteVEwTWNP?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cabfec6-bdac-4d11-0ad7-08ddfa9abf32
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 12:14:29.7815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLWhpKpGRkIfdrMFpgTDFkfq1Wrg/umhijwxR9+YFfXqKld/gGvXQ8ddERhAWXa/F+BuZSBUfPxlCh+ILS3UwZQkx7/T47k/aDJxxVcQSlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668
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

Hi E,

On 9/17/25 3:17 AM, E Shattow wrote:
> Update documents 'README.fdt-control' reference to replacement 'control.rst':
>    doc/arch/nios2.rst
>    dts/Makefile
> 
> Also convert some adjacent pathname mentions to rST links where applicable
> 
> Fixes: 3e9fddfc4f14 "doc: Move devicetree control doc to rST"
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>   doc/arch/nios2.rst                    | 2 +-
>   doc/develop/devicetree/control.rst    | 3 ++-
>   doc/develop/driver-model/design.rst   | 1 +
>   doc/develop/driver-model/ethernet.rst | 2 +-
>   doc/develop/spl.rst                   | 2 +-
>   doc/usage/fdt_overlays.rst            | 1 +
>   doc/usage/fit/overlay-fdt-boot.rst    | 2 +-
>   dts/Makefile                          | 2 +-
>   8 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
> index 34a75e7fb00..58f63c996b6 100644
> --- a/doc/arch/nios2.rst
> +++ b/doc/arch/nios2.rst
> @@ -13,7 +13,7 @@ Please refer to the link for Linux port and toolchains:
>   http://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
>   
>   The Nios II port of u-boot is controlled by device tree. Please check
> -out doc/README.fdt-control.
> +out :ref:`devicetree_control`.

If you're not pointing at a specific section in the document, maybe use 
:doc:[1] instead of :ref:, in which case you wouldn't need to add labels 
at the top of each file?

What do you think?

[1] https://www.sphinx-doc.org/en/master/usage/referencing.html#role-doc

Cheers,
Quentin
