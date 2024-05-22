Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE060C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630A38845C;
	Wed, 22 May 2024 10:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="B5OnkO5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E4F88464; Wed, 22 May 2024 10:39:33 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C00388307
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9BaQasw2bBMBAkJyl5I4DS9p8dL2oZxCkz9g9jQxe4JOZUfLX5EBjdpcon+jv87dZKwjy07A8wg0hstzv8mOqfcBj7arxE+v927brXz2uqRKS/+/+xMTaz1FGf6jVpDLmMX5axkZd1S/XeTtIICf21ZD/K33X5SZ/ZSqgomCsEzBpDqvU01HZphuBB6hxcNaWrtcIWUp8CYzWsnKk3ovUr+6jFxVpiT1PKAyIsuAWn4Oid49dIFyRf35kYFMCE6uLKbZXzCOn0WrPCPbhHw/41cFW0Nls/7cgYebwJKYSENMeipFgVJ4mAmcw9H5P+id5w0so4MZQzH6QA9FxF1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0LZv3c0zFSJZopEW7u5QX08X/cnsVxo82kCLJ8g0VY=;
 b=oQIuoEXY1qidJHNsgekyVPoxv4Xh5sCGTTCGwqxCg8YJWxT5gEejYu+bPT2COs13UpK+uT07yNcBlwOJA4/4hfC7wfifuo3Gqw3HtexTdB36bnVG6gE9fXYR9jM78X6C4h3Ld1iLJPoSd7qhlkoU0tVYmVHFO4zQtqAmkhHadOCts39+a8Wh1EQNz2atRYoi95EQMSaENDwStUaALt19kE892dd40Xgvk26cDu0z4fhaHd07EH7m3Ug+GCMMBWMrpPI+Udt+/rClip0F9LWUNL/jBcXiIeuQ+iazKPWGnZ5XoX2kHlIhu1C6KgxEEpqYJKnDH9u0fWHHL/s8anoUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0LZv3c0zFSJZopEW7u5QX08X/cnsVxo82kCLJ8g0VY=;
 b=B5OnkO5q1sd3rTjs2rded1q4tAdZzIPg1+j5uLuv+T09oIZ+0AA3nITosnus+3xQtxEHY7n3w4jqB3ths+OaoTRdSIyPCMnFZo/n3kuLZg50v1XIUtrfHvn7IA4j+TP2G7HfcuBI4FM7+Si9L4tVE2ylbBZYFM533o7vyxPdGVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PAXPR04MB9202.eurprd04.prod.outlook.com (2603:10a6:102:221::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:39:27 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 08:39:27 +0000
Message-ID: <c9a78f7a-5b63-4d37-93d4-2c6bd8db0076@cherry.de>
Date: Wed, 22 May 2024 10:39:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, jonas@kwiboo.se,
 u-boot@lists.denx.de
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521180444.GC2568172@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240521180444.GC2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::42) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PAXPR04MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 44849109-e030-4176-a82a-08dc7a3ab0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHkzV2RTNmNPb1l0SENNSHJxZnh6WDNCY3JoOVFEckJqNEZKUnoxU1ZVS3FJ?=
 =?utf-8?B?bTBZVHVSc0xXSXdsT1FyZnlXTHdoR0JZb2t3Q1JXaGJrOWxkaW1jTEpzbDNx?=
 =?utf-8?B?YkZ2K3U0U0xWVldxMUxQR3hGdHp3NmFrRFdXbzF5U0dUYUQydTEzZjUxWFpl?=
 =?utf-8?B?SHlZMzVvUnEwQ2ZLR0pnRER2ZXVSdGtKaWNKTzlTZHBObTdBbllsakNFVjJx?=
 =?utf-8?B?OWRxb3lDdVJ6eVU4U2kxNnlBd0ZXNGFhdVlWYVZndDd2U2pTR3ExTFlXNEwz?=
 =?utf-8?B?NDJRNndxcWVucSswRFV3Z1ZJcDVPNzY1OFBMeUt4ejRhVjFtOCsvOUUrcE96?=
 =?utf-8?B?QmlqODZOd3V1QUZlS2l4aEd5Mkh1MnpRSkQwVk83Nlg4a1ZGNVd1eHhQa0s4?=
 =?utf-8?B?WWlGSWtPMkZTSDFKUnlOZE5BN0lCNDl1bGU4NTJ6K2w4Uk5PYzYyRTR5ajYw?=
 =?utf-8?B?SHA0SGVkQ1JBWVRuL1FocGpSdUNuK0ZZVGZvdHlXMmROcHZ0anhwT3ZGR1RZ?=
 =?utf-8?B?c3RoZzUwMkZTVFpWWUlLcCt2RWdqdlVhdWk5eGxpdmNtcXBWakVmYWtQMmJC?=
 =?utf-8?B?V2w3Rk1GSklMSWNxYWcvQWd2UlBjTGhmZ0NidUNrcE1DZ2grUmhkRjBXWGov?=
 =?utf-8?B?eWtlUE9qRDF0V1MzNSs2M0JkeFZWYUljT0ZUSVVlZGVVV3RoM1FCYVExU3M1?=
 =?utf-8?B?TjRrYkw3ZjFrTkVad29IS3dGTCtsSktaVHBwZUZzQWVYd201cG0zVldIaFda?=
 =?utf-8?B?ZFV1anlCZXB1U0d1WUtudkVNOU9tQ2pwck9NRmhUcGhtdzdvZk8zOEM5ck54?=
 =?utf-8?B?b2JEc0NJQ0hJRFZvVG9TVXNlRkd3QytPSHFGZGJrSlo0Y1NmTTFFajhxWDQ1?=
 =?utf-8?B?MnNwWXh5dzhIeE9JemZwZ01LbHJKdEs5WVlQTHhCbHJHUVpVSnNITGpGeGli?=
 =?utf-8?B?aGVHZ3hPRmhBNFh1MjhBZmd6M1I3MlIwd1dPa3puc29qeDRTZXFsVDV6QTZm?=
 =?utf-8?B?a0x6NXpaSVg2SHZlUnhyNnROaHdMYzJ6NnNwQytaQUprYWtmM2ZUN2d5cjFm?=
 =?utf-8?B?WFJ1OXMyQTJwUkg3eU0yK29hYkRtS0VFcjRLT3pSQTF5MCtzamhERG5hb3Q4?=
 =?utf-8?B?d0N2STdER0krUjkzYUJoSEVkK2JoL3ZqVFVCTmZvbnVqejYvYkhMNUJBTGdI?=
 =?utf-8?B?RDY1TU1HU3o1TGd6VUVEdDVHa2Zhb0dQZ2dvOXVIcW5FOUhkTDY2cnpTQ3V6?=
 =?utf-8?B?WnFLVnpSU3U0OFVlQzRVNDZXdUFzekFQbXZ5a2lQcCt1dG5XbkhNekJZR3RE?=
 =?utf-8?B?MngzWVhReTArOStBd0lHbmZxcEVKeS9wNktFdHRKVm04cFJUcmI4dnVTNkxK?=
 =?utf-8?B?RVdpVVdwSXB2YkVuSmU1aDdIMWg3dWtPYUVabFNBbUtvR3BDeXdCeGh0dWNu?=
 =?utf-8?B?U0dEOFZsZ1NmQjgvdmNVRXFDNGtpbGJSUzIxN3VLcmhRdnlnRlRvUE5kMTF6?=
 =?utf-8?B?VGhzK3dOVGVYOERKMVNiOXhVV0ZEWGI3WmlqaStXRVZTQys1c0lMTmxhY0xH?=
 =?utf-8?B?cFZFMjVzbTl1QWwrZWV6WkRsZG14b1lqakppcVlSQkpkaW4wanR3STRnZDNC?=
 =?utf-8?B?Y2hCSFpjQTZRbG9wTnU5VVh0ejZ4QzBLZ09RMVFSaTlRRkJVc2V3STVqSFJO?=
 =?utf-8?B?VWQ5cHRXOVlaOW12VGlyNDRPUERSSnBsMVZjRXBDSHpnSkNPM2hzTnl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BhNWNSTyt5a2tuMndtRzdTblhpeGUxWG1pM0R1YnJobElldUFjRS8vbS8y?=
 =?utf-8?B?RWJyRnRnRmloQzhNMUwyZm1Jb0dRdkw4Nmc3R0N0TTMvSWk5bjZKcThTelV2?=
 =?utf-8?B?d1J6VFo4Q3p1cm93Tm03aEU0MDE1ZGJ5MWV5N3dITnVWV3Znb0g0RnBKbXUx?=
 =?utf-8?B?RWI3cjFERC9ESi9tZncwWm9aODlTK0hubkNVQnduYWdJWHV0dTBNcGJ3TmR0?=
 =?utf-8?B?NlY3VktQK1RvYjMwT085ZHVaaUVwUWdIVjFjRWhlRms0YzBwU1BkOHU1SHdj?=
 =?utf-8?B?UlZBU0FOeGFncjY5eGVCNjJnYURDZmhJeitkUVpZZmIxK2tkNk40WWhrd2dl?=
 =?utf-8?B?MkxTTk5Lb3J6QWZmbHdJeDhrWEwxL00vSmk0OWQyc01EQ0pJSlRyWDEyNjVl?=
 =?utf-8?B?bnlmdFd3VFV4d3NFM1dTd1pyWTdBeVZPR25kVTJFTjhnY3MzUXRWVTlYc015?=
 =?utf-8?B?MkcyN0Z3OXBWTmlIQkxNSGJaVCszUStESTVicUg2UFlwcE1SaU9FSHlOVHZ3?=
 =?utf-8?B?RkowSHpUVUxiekJzcHMzTHlmRThiSC9SUlo4eHVTRWhpRmVRVWZJVUpqMDc3?=
 =?utf-8?B?UGlEWjNWL1J3KzJIOGJZM2RCdXpiUzZUNEJyMXhseEplYVBFZysyN25vWVhC?=
 =?utf-8?B?M1k0Wkx2SmgzVHNGY0tZRCsyWjVqeGJTaHZmUEhsdjZNS3pjSkhrc1lIZVFO?=
 =?utf-8?B?emg2SXVobklsZVV4WWxKSVNPZHhZRGdzckRuNWxmSklRTjAwKy9sZXlqYXVV?=
 =?utf-8?B?cklqZ3RzWVlWb1VldHlpN2JDVHJOeG5vUXJBdHpydmYra1pJZi9wU1gwUk9y?=
 =?utf-8?B?eFpqYXk5cUdUd2w5RElYWTlNekxvWlA3aGFBVGlWQ2VJUi9UTXI5Mm1XckF0?=
 =?utf-8?B?c3kyek5DKytnSGdZM05NKytyVEppcXJDOEhUaERYZE52QWx5MThUMDhyZWQ1?=
 =?utf-8?B?a25ubUR3bWdkZFR2S0RBa3ZRa0d0M1B6WEgwZit6eHNJdUUyV01CWW1sVUlZ?=
 =?utf-8?B?WkdzWGNHT1lrQVB0cGRZREZmUXh5KzhqVnVjNktHS3hLbEtvLzVydWtJTXlK?=
 =?utf-8?B?Z2RjVFVLb3BCREt5Um1VcFl4bjJxUTNwdlZ1Nlg5UVpnUWYyS2RjZXRzOWh5?=
 =?utf-8?B?RStuaTZjOTJHOEl6N0szK3lUOHF3cHJSbXZRc255S0hqamd5Zlg5a3Z2UEE3?=
 =?utf-8?B?ZnNTOERFSFZ1QUl3bWFVM1M4NmluQ3BmOTZuanN3YzdaY2VINmFmSFhRcTdV?=
 =?utf-8?B?UVRFeHBaZEtNdWZ4aUIxR0lOd0tXMEtMTllUSUhnNXF2STI2S1Z1amdKcXhW?=
 =?utf-8?B?MjUrRzRsRk04c0MyRG5zbGwxM0RNVVI4Skgwa2krY01mYkRNVVZHSGtKVFgx?=
 =?utf-8?B?VVpJRm9sczRuZWFOdm4rcEhUZU5CRFBPeDN5ZDNwVWRDWEFXVnhpdGVWWVh6?=
 =?utf-8?B?WnhqSHlGQ0FzR3JWdzRMRW4xRHU4T3VtVWcvVnRCMFBlNEhWb1dVTTBYMnUy?=
 =?utf-8?B?a2tkczhxNVFaSjJVTUpSeFZFT1FEMzQzTzFRSDlZMENGMVV4dzh0MU9LaldY?=
 =?utf-8?B?VnJpcGhETFNBNHcyNGk0bVFQRTJ0QzZlZzNvZW84S2FrRDFEZCtlWU1JTkNW?=
 =?utf-8?B?ZVhYc2pwY1F1eDdJOHBXVGRKWko0ZkZUK3QvdEs2K0hKRE41L0FyZ2JWeTBx?=
 =?utf-8?B?TUZWWFFodUVVUnE0VDcwZHNuNE82aVFLUThaMnRGWVJkelRjYWxhSlZNMTB4?=
 =?utf-8?B?aDJIdU44c3pldjZYeGJyeXowdzZ2eExyMyswREdTY2w2STNNUXhBbEdGbnFj?=
 =?utf-8?B?UkFXSWlVcDVleno1WG9DSDhKRVI4SFI1OWdZRjF1WHZNZjdaYjJsc293MjA1?=
 =?utf-8?B?OERaYzljejJ3dVk1Qm51dVVkNTZRV0lnUi9aZTk4c3NBazZQS2RHWEFlV2dW?=
 =?utf-8?B?RnA3NHd6Z3FIMlpqSllDRS9MdGF5NTI2SGsvZFlnbVBQYmJaWTBhRzAzWGFL?=
 =?utf-8?B?SGwzQXZOUllucC8zdTdTdmN3RUtCckE2SHlxRVpOelp3TjdNTmU4OWhXbjZa?=
 =?utf-8?B?Z0VGbjM3VytuVjF0amRpanBLUURQNzFCdDBQbjBUOGhldm9ob0NyN3oxWWxu?=
 =?utf-8?B?NTNCYVlQWlJ3QzViZjk3c1BkSEdQUDRjN0t4UmtEQWVQUkNrVHJidHMrRk1a?=
 =?utf-8?Q?LDtrmKGHhvSyFD39IUNgN7I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 44849109-e030-4176-a82a-08dc7a3ab0e9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:39:27.5973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHg5uJ/PxrHZYmS7KQ+fMw91XyyAJRaVAW5QGx2dzjUuGDYeGWNBBY5LjHOuOznKKj429A4bZe9okABY+7lHFguYcz2qJTm5Jr39+XRjw/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9202
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

On 5/21/24 8:04 PM, Tom Rini wrote:
> On Tue, May 21, 2024 at 07:39:53PM +0200, Quentin Schulz wrote:
>> PX30 Ringneck ran out of memory in the allocation pool of U-Boot proper
>> pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
>> already to this common bss+stack addresses so it made sense to follow
>> the same route for one additional SoC: PX30.
>>
>> While at it, also fix a few issues related to UART on the PX30 Mini EVB
>> I could test.
>>
>> Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.
>>
>> Thanks to Jonas for hinting where to look at.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Quentin Schulz (10):
>>        rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconfig level
>>        rockchip: Use common bss and stack addresses on PX30
>>        rockchip: ringneck_px30: Use common bss and stack addresses
>>        rockchip: evb-px30: Use common bss and stack addresses
>>        rockchip: firefly-px30: Use common bss and stack addresses
>>        rockchip: odroid-go2: Use common bss and stack addresses
>>        rockchip: px30-core-*: Use common bss and stack addresses
>>        rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
>>        rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
>>        rockchip: evb-px30: make UART5 the debug UART
>>
>>   arch/arm/dts/px30-u-boot.dtsi                 | 16 ++++++++++++++++
>>   arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
>>   configs/evb-px30_defconfig                    | 23 +++++------------------
>>   configs/firefly-px30_defconfig                | 19 +++----------------
>>   configs/odroid-go2_defconfig                  | 19 +++----------------
>>   configs/px30-core-ctouch2-of10-px30_defconfig | 19 +++----------------
>>   configs/px30-core-ctouch2-px30_defconfig      | 19 +++----------------
>>   configs/px30-core-edimm2.2-px30_defconfig     | 19 +++----------------
>>   configs/ringneck-px30_defconfig               | 19 +++----------------
>>   9 files changed, 46 insertions(+), 115 deletions(-)
>> ---
>> base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
>> change-id: 20240521-px30-2024-07-rc-7136f6241d29
> 
> As I assume we want to fix the platforms for v2024.07, is this the level
> of config changes everyone is comfortable with on the platforms? Or
> should we just go with the minimum for release and the rest to -next?
> 

I can tell you that Ringneck doesn't work anymore on v2024.07-rc, but 
the PX30 Mini EVB was still reaching U-Boot CLI without the changes. I 
don't know about the other boards.

So I could split this into two series, one for master, one for next.

I could suggest: patch 1 to 3 in master, the rest in next. Patch 1 is 
just moving things around. Patch 2 is doing nothing if nobody uses 
ROCKCHIP_COMMON_STACK_ADDR and SPL_SHARES_INIT_SP_ADDR (which is the 
case for px30 boards). Patch 3 is for fixing Ringneck, which I know is 
broken.

Heiko having access to the Odroid Go2, maybe he could test without my 
patches and see if it reaches the CLI to know if we should pull it in 
for master as well.

Does this make sense?

Thanks,
Quentin
