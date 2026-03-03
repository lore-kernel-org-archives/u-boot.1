Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C602EB362F
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB14839DF;
	Tue,  3 Mar 2026 16:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lNGg780Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A0883F61; Tue,  3 Mar 2026 16:03:15 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDFE838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/RsH6zky4dlvWzxAQu74ciLKYCZ8y8UslNRxDtfnuB98BTt7BX0Fnx8XYqLhEtPM8Jof1BZ8i3QDSieHixF7zW69oVbQYOFYVq2pCtHbISvPzqD99uMPcKFePGIu7LVU7NbirWPh6tYOD2RrEICIuX+HpScFHEtJTYVMHdZI7mITuGvr3jGzktdvVSiYoziE/AXEzljk/FwnCZeIo+q32AtCxZ3cNHn8XOKOAUaYoisWI0jvj1ohnqfZ5X/F3qJZolmlItqGLN7E1oUHMXvXRhpshGbVGnFK+egMpTYzQWIV1QOD8/dAHco7mn3FerJVAAsmnSQmDOxYJ8oBR4nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH9m+o72adiiHDKuqxImyrJqx3z2An8osgmqqWb5uX8=;
 b=rbpoWlg75n6avinrv8o9Flu9+b4H1EY8kkcD0odg2O+YEhc7IVOo2ECv1wbEpWgq0Fyxo6Rvzf5jLWEPIyeGvOZBY6qOpp9c1HbHAR4Ujo6UdqkNTk2YvpyDEUZaeuCnvAZ8aD4d389hLX5vFeXTkLrwTKk4unOMXHT4xPup9d6ug+UaRUBG0QGw4DWtp80OxqFfIZ72TrsmVd86R47tV43WkmuuhwpfpxYHGC6LDQ+5MLRhPwydygeGe5D6usvv7uvGdfHKb8ybB5Fc5mjIO33XTNmjxYGvJb99plyQel5BWlXlOLQ2RKtIq0A4aRr6V1C3nWT31DKoWwZxk38EHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH9m+o72adiiHDKuqxImyrJqx3z2An8osgmqqWb5uX8=;
 b=lNGg780ZUH38xWo27xpKfMugwDRVcAjdUTcazIU8Cvk2Xp5pDzwVsUwBZwYqVPWCMhVBRK5MAKn48sX5HPL48otlBakNyyewn3C+w6g7aSrlIGkJyEyShUey+Rzc+wx/G97xjjKOHT/JPSOm7KHuDQacwvejyXlKard6UIE+QuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:03:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:03:10 +0000
Message-ID: <89390506-0b85-40f4-8ec1-2909de013cd6@cherry.de>
Date: Tue, 3 Mar 2026 16:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/16] binman: test: Move UEFI capsule test files to
 test/capsule/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-13-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 81641502-3e13-44e7-9e98-08de7935fc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: qdsL5LAQJGgO83R0zBmWGiU58Z9QJbhIW9rtTI2byP7IIeR31iJNoGrFYo7ourBBvrem4gjU/Pbq7O4NxS3PXFb/VQTjM9mDVN2+nEesGZcEt85hCq/xG9i/KmyzrNChSgrZtpBnjSIQNAyazkVPmVkT8KoaXG1mfa1/bybPl7LmEoWq7qRX76EjiELNJfDCFPfTe92uU9NLk0XYvcdWslaJhJcKrpo1AYCGxmrLB62yELKFsFYQUDauzR2d78HIw/Zsua6P2IxDJg6bMkTSlRjpMk97rA9LZ0hhZSMQUxg1ifOKUstmpjwOuQweXaUIbiyIwDsp/nRzbeQtoR4uniZwHJ7WYqbFLUGdJiHyyyNaKZDVO7yVMrthvb/qWYLGEQhcnk5kDkwFLwSpZ25ovLea/nSos2ks98JXs6xY4yHJq2xa2Cc5bPLlgEVdW0LW3I/91/Dki/NrfOVEI1jtRbd8IWAuYQypBTGi/5GR7GYdVOFPuIghTjpmzvqPHv4k/VuMyqgu/bHNhZ14Zf8nyYnzOolLLKSjQ9Rs3rbFLqZyEDO4mXOD8Yt3tm8Q5dFehLqGibc4aVJ5hGj9pyVL8JZ00ooId3Fzv3u6WhRAK9LeUWrJqgEzialqZAcZFU9iuHkGXmulnIsaWKy9qI8FBRnhoCcjH1y2DPszxaUBJH3elE8fbpeKROCvdC3BkLqwdonve/1RzKxlYsB7kD7p9yuuNZLgqw7RnKa8B7RpPvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1c0VStScHgzQjVSNkZLTXFOTVFDTTQ1MUkwOHVRS1pVc2xneGNlb1VYV3JV?=
 =?utf-8?B?RXlNNFFORXhTM2JBdzFBOHJmK2h4SGIxOGVoZFFFZW05dU9kelBIZVdCTFYv?=
 =?utf-8?B?cTdYM0dOOEhZSkVXZTgzN2N4R2RiYTlZTlB2RXJ2L01nRU0zOFQza0U1SGM4?=
 =?utf-8?B?dUlGeS9aU1U1UytETURJdE5yakJRUVAwNjFPcEtxbU15aFhlNjRDQ29ZNVBx?=
 =?utf-8?B?WWgwOWdIZ3F3Y3BhYWkwTWlDdUVjM2l0MUVYTithK2txVGZ6cDlqY1U0cWRU?=
 =?utf-8?B?b0xlMXUyOTM2TlJBVGNQSWpIOVRCNmZ4VzlBUWxXUDlWZ1M1WE1ETStaUDhu?=
 =?utf-8?B?QWdFSld1UkkvOVc0Z3l5NDZrYmdzdGxXNlhqZ3FHcWkxblZYTitZTC8ycG5Q?=
 =?utf-8?B?ZDFiMmFvbnNHR0tRUjdWemxTUStzdVpWbXBKWTlqZ1pFUDRDWmVCTnk5cUp0?=
 =?utf-8?B?M2hhT2swN1B4U21SR0lwOE1rZWpETEZRNEhkdGtRWmtPS2lHVUZhVVR4czlZ?=
 =?utf-8?B?bS9KNGRybCticzRkR2pVQ3BYcGxEeVZOalQxL3BUWVJ5bUkzd241WEVYS1pN?=
 =?utf-8?B?cDBTZ2tRRmhGbkFTRDlkTDF2ZXd4Tk1yYmxyNEFxaTRuQmU3aDc5U1NTTUc3?=
 =?utf-8?B?WitaRUE3d1liZTdiVFRJMGhkTldxZ3J4SDNoVGZDTG95UzZ0ZGZvbk50eEJI?=
 =?utf-8?B?ZTBnWS9xU0l0dTRIMnBLY1VwMk1ZcUQrNTBHbklpVzdnZkxDVVBJaDZrVWh2?=
 =?utf-8?B?c1p3MmVnS3pFMDlNUXBLLzFncGF6S1gvNDNDb3VDVENHTzJlR3BnOHVwdUpk?=
 =?utf-8?B?RzRmZnlIa25hdTAvRjRRYVFZWVFzMDQ0SGVUeFN5eC80aVp0TWJUT29YY3FU?=
 =?utf-8?B?S3FveTlCMnU0UHpmZ3R0MHp0MWFib1E2cWt5U2lhK1VHZVRpM2VCMTZqUFd4?=
 =?utf-8?B?b3VhTlRJWjJnRDhYT0ZWMzJCZGtrRGF1ODdacHdwZmxLdzFqNXZuM3NoK1Rs?=
 =?utf-8?B?aSt5Snh6RXpTUzA2SnNqVjlOemQ0QVZsanFpYkNQeHFkbHhsZ1ZOU3oveHZI?=
 =?utf-8?B?S242MmJxZUc0VkFLMVJHcUNDMFpxR0QyU0FhQk1aOXBadUFjaDhkTmpkNXBC?=
 =?utf-8?B?TmhEbW9JdzU4SXhEdFUxTGFmOHBpY0dWcG1BZjkvR2c4NnIzWmR3QmlaVGFW?=
 =?utf-8?B?bHF5SFc4UTdKOUY2dFl3SnRzNmwxbll1OGRSanhvYWhXSjNQNGpGUU5meU5j?=
 =?utf-8?B?ZTc1MXRMa1FFTzZUUlZ2QUV6UEszK1d2eFMwbWg1SndKejQ0Z0VkS1RCSkpw?=
 =?utf-8?B?V0NQYnQ0dE01NFdPR2FETUhjbVlhcktDWEJnZGtTZGsvaHhrb3dNTVArdHNV?=
 =?utf-8?B?OGlLWi9rdDVZc0Q3TFNNaFpOWXJISEhEdlk0VkFsTDF2MmROQXdJbTFsdkpp?=
 =?utf-8?B?LzJuVVBwWTBWN1Y4YXBZNXBqUXFLVUZQMUNrNXZpZEl2TVVpSFNUSFdmbDhS?=
 =?utf-8?B?WUN2MG83RHNlUEp1aTZqcDc0UUhTTkNnanFHc085cytIMWJ2NDduR3RJSC9W?=
 =?utf-8?B?cWxIUHo4dVdBcSt0cXFmMEVJU2Q5MmVmNG9vc3ZFSmhzVFQ5dEk5Zmp1V01h?=
 =?utf-8?B?K0NFd2daQmFXQUc3QUc5NmEzdlRuL1JISERCT2k3MUwwMTNwRWtLbzNESVFL?=
 =?utf-8?B?LzZoVHFsR1VpbkhsNHpPbFFrMll5NEk1LzNJTzEycURnOXYyM3loazRGcit2?=
 =?utf-8?B?d1kyVXdlOURaVW5naWJHNVpwcEgxMUdUTVNTWDhUbURuWmJpYnIrWGRZbE1Q?=
 =?utf-8?B?aEE4RStpalVMekJOM0l1Z2I3RXNqczB5TUg2RmJhMExacVNJbWdwU2NLSm90?=
 =?utf-8?B?ek1JTE1KR0NzZDZJbEMraDVlMThRQ3RkelVPRGJVZnNvN3RRbkVxZ0VpV0lQ?=
 =?utf-8?B?YzFlUitpYmRtV1h5NDZKMEYyeUVsVVhyUkplaG0yZjRDeVVXdENoWDBlOEh5?=
 =?utf-8?B?a2ZuWmRTeTRTTGlXWS9rbnpwcW1kNWlVVml3MXRZN01WdFVnWnFjcko3S2d2?=
 =?utf-8?B?Z2lyR2pVMHNCSE8xbmdOcFpJeE41R2ZTeWJ5clZ4Wll6TmNtTlVLSUd5WERl?=
 =?utf-8?B?VnZ2eXJRZnEwdWdicUxNYWFBQ2FGb09VRXBxMkd6VXZXem5VeEw1MU1TTkM2?=
 =?utf-8?B?cU9lMDNaYWZ4RDlacXJVd1pSYUcwdkU0V2RYZ1RFVTJvcGhwbU1tUXJEWG9Q?=
 =?utf-8?B?VUhxK2pmMENsZDlrekRCc1pTUG5YanNTNWFmQyszdkdxamdLeXNKNDBHZHQv?=
 =?utf-8?B?Qk1qeWY1VkhXbzVBK082WjI5c2NqM1ZsQ1lYU05wWFVxK2dXTW0vdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 81641502-3e13-44e7-9e98-08de7935fc40
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:03:10.6555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1J0x0+LC5anwjzhKq/nl1jnrtFzqhUK3v2Ivhpn6VIUbpcNd8OqBxfOcb+giRw9kb3YfbEK6ktyngaD3nKoOMWamA5K0pkySE9xMTTRiHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about a dozen test files for UEFI capsule creation (signed,
> versioned, accept, revert) into a capsule/ subdirectory. Drop the
> numeric prefixes and the redundant capsule_ filename prefix, and
> update all references.
> 

What about tools/binman/test/key.key (seems to be used in security/, but 
duplication/symlink is probably fine?)?

Separate commit though.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
