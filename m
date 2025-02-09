Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3750C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24EA80834;
	Sun,  9 Feb 2025 21:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="fzeDqgr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B75809D4; Sun,  9 Feb 2025 21:24:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9F380821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C04jul5MhJ/e1W2Lh5nBXwLhQf/v07Yg19OKR0rbrmkv9gmZEny2wKjWdIOxmAIbyhj+ZI5QEUWBNxiXB0CeT7zsWGKJAGGYRKwfBiUDNH/RRSLRdnueLEi4Ffyc5k1FNQPIGl4ZR/vSpCW1R9v2yN/2ee7D6xlJxl1qB/zzkTuUuTMs5FSS/oNNRnrDNC9aoi/mUdK99091EWFatfnNGayoXLzu74RBI5omSO6c+UBnonjKizcdzm9njXqBVZu+B3CNrUnSsCUUqYrePXhzqHdZn9YWCzs7C7TlD42DLSjFZbSs8IWPwqtU0A+elpcp1AjZaJd9Bvk+YGTSmIoxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOUHg+DUS67DxyoCq8iq5sPwSsnul0vOVKGOuWJEwag=;
 b=Of74254U76EbX5EAHhTTUkYGNrKxbOP0R+TobGvX5ZKdoIbNv4/Y1yKrElJa/GwYj+YWagqx5FMz1Y2Qi8Wx7cMygloSnCx1DekHqSmK/ZKj8ZHNZUh5O47BfsI7u5Tq1LxvV/h+c3B2y2Qzmh6G9jEw7W9CGFiJu3yKILkkLH9MWq2vtggyH6noFsHjqEW5jotNFyB4GPhGI1OW8fKAT2DkLdn2+5ttSI9Nu966yajg5GcQ7yr4ECHEVdHEEOLLTpYaKK5woKOAg28Z1W5dXxV/mdHT2jSjmUZx4gJ64HPO1KJ21F8LjtB0MLn8bYWB0UAu+DYnbrZ7kIKUpHEIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOUHg+DUS67DxyoCq8iq5sPwSsnul0vOVKGOuWJEwag=;
 b=fzeDqgr6gFvx5w+SCLSbZXEEhvyP2ei/o+pPPPHAqyMItQ45ZcLPVW2P6kpgpss/PTzFVFv6BfR2KsxudLl0n1bPvNTa2bAiw9kw1SIJDDnwUjkaGz7aJkmPtL+lHbJIl5yRQmczXiDGhmq+nG9uEZgnhKyVXdmywgixeRYpDDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 20:24:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 20:24:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 09 Feb 2025 21:23:52 +0100
Subject: [PATCH 1/3] u-boot: drivers: marvell: rtc: adding rtc driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-cn9130-board-v1-1-b94ab83e141b@solid-run.com>
References: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
In-Reply-To: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>, 
 Alex Leibovich <alexl@marvell.com>, Kostya Porotchkin <kostap@marvell.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb35f2e-dbfc-4767-1ae5-08dd4947b655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGRrbVl1ZkorQm9zeGQ5UmdoeTNpNFJxK1gzYlRJWUtvNFl0MU1Rb250RzdH?=
 =?utf-8?B?Myt2cnhVVFhlZEljcmNGZSs2RjJmRlZqR3crNmF3VW5rU1NCRG51SzVDSzl1?=
 =?utf-8?B?ZU5jaWkyUXR4U1NPMmFUOFVna3Y1TlNQZmFnRUlvdk13dFFLNDVNbU9USFdJ?=
 =?utf-8?B?a1BoWHBlbG8yWCs0Z2VKQlpDYkREZFIvNmw2dlphYzBCY3FzUGtJR3FxK2NR?=
 =?utf-8?B?S0JZNjh3MXE3b3hndDNBR2FpeVZrQ2NQU0ZQTEx2OEtYbHNaQk53TUNMWlho?=
 =?utf-8?B?NGdZUDZwSEFRU1kyeEN3UjFTVXhQbGpVaXNNRWprNnptb0k1anJFbldpQnhQ?=
 =?utf-8?B?b2ExKzNMcUg3TEh1aVZQeE9sRWNYN0kvTU0xZGx1bGMzZ3UxT3N1d1ZRN2g0?=
 =?utf-8?B?YVk4VGZVajVUeXpWY2hlSHFYNHlkVXhycFJWT0huNlhqQlZIMnVPbGhEcExB?=
 =?utf-8?B?V1pkMllrNzVnWlkxYURIeHpSWVdxcHFxNTg2T3RpcFV1cGd5ZmhCeWNPVU5l?=
 =?utf-8?B?OHdCbVhCOVI3c3RKOWZyYjI4a3hxSzByMTl6eE5uK285a2NNMjMySmNTbE5B?=
 =?utf-8?B?NVhTRVQ5RlNaRHlUdFZxMHpvdFFpY3U4OWJBK0tTc3F2eTJlbDlFL1l5dE9x?=
 =?utf-8?B?U3l6ZmQybUJnTmFEeEVsSS9TYW5sWDArL1dpcUg5OHdwb3FYRmpGNy9WMVda?=
 =?utf-8?B?SHYrenU2SFFld2t5b1BPYTNIT1grSkQyT2w1Y25KM21vbzBBWVZ1aHRpM0l3?=
 =?utf-8?B?VzhxQ1M0eHdDY1BaY2tvSVJUYUw1OXdldEVoNnlFYlVuQjFjOW9vYURRZ0Vw?=
 =?utf-8?B?NGlhSjZuWXZXbi8xSnhqS3RrRG16dC9vMEY2OWhxZTFKc1RHOFYyQnBEY0I0?=
 =?utf-8?B?TnBEVkU5ZTdwUWg4eUFWY0x5QmwyL0JvRzZRbDI2TTZydjlleW9jeVFqNEFH?=
 =?utf-8?B?ellCS3UvS1pzRWZzV2tNM0hlSkM0SlBRQWJuV01DSFRNUWRGK0RYRlVZQ1Z1?=
 =?utf-8?B?YjllOGF1WloyWVNON1ZMblFrU3pxajc4UnpDVTlnWkI5cm5MNkNucklEb2Fk?=
 =?utf-8?B?NlI5d2crWk1ZYXBBRXFSTnVkTitQTFkvVG1UOVU5YkRxcG9BS3pLWHFEc2hn?=
 =?utf-8?B?VytoS1haQTZmL0pLdlBkL0VSWUc5cUVQbEM2ZURKd2IvL2QwZ0NBTFFkWkcz?=
 =?utf-8?B?VVAwallNU1dsbnhKRzh4dit4Z1dQOVplTk1VTVdac2lCSko0YjJoWFBBZFEz?=
 =?utf-8?B?cUlXUnZXSDYzYVBpc2VZZ2l3eXd2YUE5NU5TYkh6Nll2alVYVmd1c3VNYndJ?=
 =?utf-8?B?S2FZWnZsbGFSbjlMeEp3elQ4cVZoZ3lORnVscG9XN2lvQWE1SUpOWExUbGI4?=
 =?utf-8?B?MmhsNEhtNXFmT0RxY21qMmlhb21VZlZiQkFjUXExNlRwcjRQalVrelR0ektk?=
 =?utf-8?B?VHlGTWxYbUFBL1ltOTNpVTdzRTcxQS9GVzR4N2dlQ1RHTkpVa0hNcm14cmdr?=
 =?utf-8?B?QmtSWHl0eWRwZUJ4a2VYTk5aTVZvcGZ6bXRyK2RZMTk5NmN2TjhqTnpCSnZp?=
 =?utf-8?B?ZU9YNkZxbHBaZzlVVzVSd1Zwc1RSNi8rc2puZTBVeDBFcVpCTzlGWU5jTVBx?=
 =?utf-8?B?Z3RiUSswbmJQaUVUZzFuR1hGOUp6Qnk3dHVHK1BWQW1mR3Z2Z2lVNDNQcDBw?=
 =?utf-8?B?ZXRQMEVYQUM4NURxS0hLNjl3eW1kcmZOMXpXd3M4UyttSWdheGVidmFHQ0Y2?=
 =?utf-8?B?Z2VxNzVpV3F0dVptMFQ0ek9aSVU1UjdBMGVPNVNPaHRwM05UUFdsNEZIK2tO?=
 =?utf-8?B?OEo3eWR4U0U1YzNIZ1MvZGU4M004RkYxcXBUV3VRSHdPc1p5bEhSNjFPeVFk?=
 =?utf-8?B?TWFTeEZEYmhJTUNRYy9rS09RUnV2Umh3ejZKT0FmbzRuUWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnllakVrQVZtOE9sUHBRWStwMVh2K3pyL3RSeEpaMUlnbVlQYlVCV0c4aE1S?=
 =?utf-8?B?RStyeEVQemFqMHR6alhwdGhVbWRpQ0ZlN1kvMzNaaHlHeVh2d1YyNytadmNM?=
 =?utf-8?B?S2R0OVo1MldrQnptcGxDNHJaeUNrcnNNa204VVFaUUtnSkF3MGZXZmV3OVlS?=
 =?utf-8?B?SEwva0ozeVJ1SzFaSmJ2YkhXeWJiZmN4NEo5K010ODUwZXhITXQ4TTlnZno3?=
 =?utf-8?B?Y2lCYUxJWTZEQ3g1MitUenUweUk0OC9pVGFMLzZtSStLME1GMTE2cXUwZmZw?=
 =?utf-8?B?TGVSdkFVdzFIOXRhV2txem1KNFpmbmhKUU9WMlFZZy9VbUhTcVorbHNYQXIz?=
 =?utf-8?B?QWJTNG9lK3d3QjNnOEFKTSs0UUgrMUc2c2I2M0pWaXhIbTN1TXp6MlFJUHF3?=
 =?utf-8?B?WEVuYWhpZkVteFBmUndHNEtjVGN2b3hXY0dVWkRNVGdCWnhlTjFzOXdmZTNZ?=
 =?utf-8?B?WGViaXdyTWVOQ1JTSVZuZ3o5Z2ZtbithdTdwd1VxSnBxVUdES01GMjJOUk50?=
 =?utf-8?B?cncrRFhvdlBPZHpnZStqOWxSRFdwZHVjUWFKRHBmL0R5TGQzK3pzRUc5T2tE?=
 =?utf-8?B?dVYvUmVodVNJUGY1a3RGclRNNXhOMXBaaDBONWl4VkQ1M1Q4K0dVVXQrbXhJ?=
 =?utf-8?B?UnlwcTk5R3NOZSttWWh1Z1UyK2FTRGs5MHlDb1JFM1VqZFBlZ0RyMm5zcnN2?=
 =?utf-8?B?Qzg4WW9MQ2I1MHlmNHYwWTRUTVA2bEI1R1YxeUxlNUVYUHZyUHRheno4Y21V?=
 =?utf-8?B?Qk5CempSZkljQmJOalEyNFlZNVNrbUhoU21XdzZDc0FycEdTeUFqa1F3VUxN?=
 =?utf-8?B?MVdGK0gwRzQyTUM3L3JNVVh3ZUFFVXZpUTBxSXhsK3VLa0E1ZXVHVi9sd21N?=
 =?utf-8?B?K1hJU2NjLzFNL3lKK0IwbmNaMW5uUVUzcjJpNVBwdC9PY2F4K2ZIT1lCQ0dz?=
 =?utf-8?B?aklWNGVjeHFERGd1c2NxNWJtMHIzTjFNd3pVeVl1em9kK01oaFAzZmNKRTBZ?=
 =?utf-8?B?V2NQdFhWTXc3eDd4RVNvU29POWNmck84a2VySkZUWWpxYUFPV2F5aVJpSGZO?=
 =?utf-8?B?b2VySmo2cy9DbDRZWDIvSTgxb2hMSWUveE9xZk5ucEx4ZXNuTFducjFTUkMw?=
 =?utf-8?B?TElKL0hoTWlCUG04b3dPKzZyUnBibXBoUDJ3VXZ5UElVdFYwUEU4STBYbWFr?=
 =?utf-8?B?bkZ0UWJ4ZTkzZHNWK1pFZ3F3b0kxb25kSjlZRURJQ2NheWhqVTM5VFg2U0lv?=
 =?utf-8?B?WEkwcWxGTVhyM09FTHlvRjdoVkhnMERVazVDVHdCcmV0NjlEMVE5SzU1aHJ6?=
 =?utf-8?B?ZnZHNkFpV0o1N1VJMUxLNCtBcmZMUnVHaW5RNTYwajdwdWlIZ214VlNwUDV5?=
 =?utf-8?B?ZUVHVm5CZW5taHNiQlNmck9paGJIU2xhYUJVN3RJMzc4K0EwSFdJcjZyVTBl?=
 =?utf-8?B?aHM5c0NYbXlwZkxDdlJPZWZLUFlNRTdqc05ockRWeFBycGw4cUdiNDdqOTJy?=
 =?utf-8?B?SjZoTG8yZUJMSElUOHIvekl5UXVrUlI5NVBHbkhGSUFsVi8ya3VzdGdSaVVW?=
 =?utf-8?B?RVB2a0lPU2FHdGFBMktUbWxmcEhOMjlUcnFSTjFOSG1vbjQrK2JhOUEvTjlV?=
 =?utf-8?B?elNqRjhBUEV3NlpKaE9FM2lSOFpTQ1RGRE91UjRvUzA0aExxTlZWc09SQlQy?=
 =?utf-8?B?eWNKTUhPUHlzZ0FmN3ErdDdyU3YzWTdONEpUNFgrWjlLWEoydmRXSXJSVWsx?=
 =?utf-8?B?R0VnMUkvUmkxcXFlejExRldrYURSV2hhZTRtV2hXbnMrVnhEbUZEZDVKSllE?=
 =?utf-8?B?UmVkczBkZ3pVNmx4aDRJRFN2V1ZuLzBXOWc1UVAxc25xZVNwcXpVQ3dzS2N6?=
 =?utf-8?B?ZnFLajJjVHhXQUNHR1R5bEkwakdNdmI2YUFISXZCbnYveHZmSHZrTU1FcUdT?=
 =?utf-8?B?TVQ5OEZBZ1krUmduTmdLUGRKNmRQS0RpWGNyOTZldnM1Wlhra2t6Qmp4UkxB?=
 =?utf-8?B?NTAvY3Z1M1ROTUlSdWZKczFiNDV5OHhJakFHNlhWMno1MkZJSGxvTnZ5ZWor?=
 =?utf-8?B?Vzl0SVdXWVRqa1o1VjVZdW1KWjFJbjZlNlZYZzRacUxiSk1JeHdMMlpKYzNw?=
 =?utf-8?Q?chV3Xk/YbH4eaEF4aHedm3Xcl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb35f2e-dbfc-4767-1ae5-08dd4947b655
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 20:24:10.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmCitfnFnRJb/DvAqfLDfNaCDsiOb5/ehRpWHjFyuPApHioAQHbVRs8RQoCl3bd6cCIDU2cYFrZR46lyDt5qgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
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

From: Alex Leibovich <alexl@marvell.com>

Adding missing marvell-rtc driver and configuration,
in order to support "date" command.

Signed-off-by: Alex Leibovich <alexl@marvell.com>
Reviewed-on: https://sj1git1.cavium.com/c/IP/SW/boot/u-boot/+/6322
Reviewed-by: Kostya Porotchkin <kostap@marvell.com>
Tested-by: Kostya Porotchkin <kostap@marvell.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/rtc/Kconfig       |   9 +++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/marvell_rtc.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/marvell_rtc.h |  52 +++++++++++++
 4 files changed, 247 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6467f20422bec546fd96b5e76643209870c8f255..aa2b292c57243f84d99d09b45aa271d66cd15a66 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -14,6 +14,15 @@ config DM_RTC
 	  drivers to perform the actual functions. See rtc.h for a
 	  description of the API.
 
+config MARVELL_RTC
+	bool "MARVELL RTC support"
+	depends on DM_RTC
+	help
+	  Choose this option to add
+	  support for Marvell's
+	  RTC driver, which is used
+	  by Armada 7K, 8K and OcteonTX2 CN913x.
+
 config SPL_DM_RTC
 	bool "Enable Driver Model for RTC drivers in SPL"
 	depends on SPL_DM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 99b5a2a346a9680ee33249597cec398c33e8d657..65c4d875d885546efb230bc5abd78e5d056ee863 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
+obj-$(CONFIG_MARVELL_RTC) += marvell_rtc.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1338) += ds1307.o
diff --git a/drivers/rtc/marvell_rtc.c b/drivers/rtc/marvell_rtc.c
new file mode 100644
index 0000000000000000000000000000000000000000..842aeb84eb26ec79ff889d0484bcdb050da35b40
--- /dev/null
+++ b/drivers/rtc/marvell_rtc.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Marvell International Ltd.
+ */
+
+#include <asm/io.h>
+#include <rtc.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include "marvell_rtc.h"
+#include <linux/delay.h>
+
+static int marvell_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
+	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
+
+	rtc_to_tm(RTC_READ_REG(rtc_base, RTC_TIME_REG_OFFS), time);
+
+	return 0;
+}
+
+static int marvell_rtc_set(struct udevice *dev, const struct rtc_time *time)
+{
+	unsigned long tm;
+	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
+	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
+
+	tm = rtc_mktime(time);
+
+#ifdef ERRATA_FE_3124064
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+#endif
+	RTC_WRITE_REG(tm, rtc_base, RTC_TIME_REG_OFFS);
+
+	/* Give registers time to stabilize */
+	mdelay(100);
+
+	return 0;
+}
+
+static int marvell_rtc_reset(struct udevice *dev)
+{
+	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
+	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
+
+	/* Reset Test register */
+	RTC_WRITE_REG(0, rtc_base, RTC_TEST_CONFIG_REG_OFFS);
+	/* Oscillator startup time */
+	mdelay(500);
+
+	/* Reset time register */
+#ifdef ERRATA_FE_3124064
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+#endif
+	RTC_WRITE_REG(0, rtc_base, RTC_TIME_REG_OFFS);
+	udelay(62);
+
+	/* Reset Status register */
+	RTC_WRITE_REG((RTC_SZ_STATUS_ALARM1_MASK | RTC_SZ_STATUS_ALARM2_MASK),
+		      rtc_base, RTC_STATUS_REG_OFFS);
+	udelay(62);
+
+	/* Turn off Int1 and Int2 sources & clear the Alarm count */
+	RTC_WRITE_REG(0, rtc_base, RTC_IRQ_1_CONFIG_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_IRQ_2_CONFIG_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_ALARM_1_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_ALARM_2_REG_OFFS);
+
+	/* Setup nominal register access timing */
+	RTC_WRITE_REG(RTC_NOMINAL_TIMING, rtc_base, RTC_CLOCK_CORR_REG_OFFS);
+
+	/* Reset time register */
+#ifdef ERRATA_FE_3124064
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
+#endif
+	RTC_WRITE_REG(0, rtc_base, RTC_TIME_REG_OFFS);
+	udelay(10);
+
+	/* Reset Status register */
+	RTC_WRITE_REG((RTC_SZ_STATUS_ALARM1_MASK | RTC_SZ_STATUS_ALARM2_MASK),
+		      rtc_base, RTC_STATUS_REG_OFFS);
+	udelay(50);
+
+	return 0;
+}
+
+void marvell_rtc_errata(struct udevice *dev)
+{
+	unsigned long reg;
+
+	/* Get the rtc register base address */
+	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
+	uintptr_t rtc_base;
+
+	rtc_cfg->rtc_base = (void *)devfdt_get_addr_index(dev, 0);
+	rtc_base = (uintptr_t)rtc_cfg->rtc_base;
+
+	/* Update RTC-MBUS bridge timing parameters */
+	/* Functional Errata Ref #:
+	 * FE-3124064 - WA for failing time read attempts.
+	 * Description:
+	 *	The device supports CPU write and read access
+	 *	to the RTC Time register.
+	 *	However, due to this erratum,
+	 *	Write to RTC TIME register may fail.
+	 *	Read from RTC TIME register may fail.
+	 * Workaround:
+	 * 1. Configure the RTC Mbus Bridge Timing Control register
+	 *    (offset 0x284080 and 0x284084)
+	 *	- Write RTC WRCLK Period 0x3FF (default value is 0xFA)
+	 *	- Write RTC WRCLK setup to 0x29 (default value is 0x53)
+	 *	- Write RTC Read Output Delay to 0x3F (default value is 0x10)
+	 *	- Write RTC WRCLK High Time to 0x53 (default value)
+	 *	- Mbus - Read All Byte Enable to 0x1 (default value)
+	 * 2. Configure the RTC Test Configuration Register (offset 0x28401C)
+	 *    bit3 to '1' (Reserved, Marvell internal)
+	 *
+	 * RTC Time register write operation:
+	 *	- Issue two dummy writes of 0x0 to the RTC Status register
+	 *	  (offset 0x284000).
+	 *	- Write the time to the RTC Time register (offset 0x28400C).
+	 */
+	reg = RTC_READ_REG(rtc_base, MV_RTC0_SOC_OFFSET);
+	reg &= ~RTC_WRCLK_PERIOD_MASK;
+	reg |= 0x3FF << RTC_WRCLK_PERIOD_OFFS;
+	reg &= ~RTC_WRCLK_SETUP_MASK;
+	reg |= 0x29 << RTC_WRCLK_SETUP_OFFS;
+	RTC_WRITE_REG(reg, rtc_base, MV_RTC0_SOC_OFFSET);
+
+	reg = RTC_READ_REG(rtc_base, MV_RTC1_SOC_OFFSET);
+	reg &= ~RTC_READ_OUTPUT_DELAY_MASK;
+	reg |= 0x3F << RTC_READ_OUTPUT_DELAY_OFFS;
+	RTC_WRITE_REG(reg, rtc_base, MV_RTC1_SOC_OFFSET);
+
+	reg = RTC_READ_REG(rtc_base, RTC_TEST_CONFIG_REG_OFFS);
+	reg |= 0x8;
+	RTC_WRITE_REG(reg, rtc_base, RTC_TEST_CONFIG_REG_OFFS);
+}
+
+static int marvell_rtc_probe(struct udevice *dev)
+{
+#ifdef ERRATA_FE_3124064
+	marvell_rtc_errata(dev);
+#else
+	/* Get the rtc register base address */
+	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
+	uintptr_t rtc_base;
+	unsigned long reg;
+
+	rtc_cfg->rtc_base = (void *)devfdt_get_addr_index(dev, 0);
+	rtc_base = (uintptr_t)rtc_cfg->rtc_base;
+
+	/* Update RTC-MBUS bridge timing parameters */
+	reg = RTC_READ_REG(rtc_base, MV_RTC1_SOC_OFFSET);
+	reg &= ~RTC_READ_OUTPUT_DELAY_MASK;
+	reg |= 0x1F << RTC_READ_OUTPUT_DELAY_OFFS;
+	RTC_WRITE_REG(reg, rtc_base, MV_RTC1_SOC_OFFSET);
+#endif
+
+	return 0;
+}
+
+static const struct rtc_ops marvell_rtc_ops = {
+	.get = marvell_rtc_get,
+	.set = marvell_rtc_set,
+	.reset = marvell_rtc_reset,
+};
+
+static const struct udevice_id marvell_rtc_ids[] = {
+	{ .compatible = "marvell,armada-8k-rtc" },
+	{ }
+};
+
+U_BOOT_DRIVER(marvell_rtc) = {
+	.name	= "marvell_rtc",
+	.id	= UCLASS_RTC,
+	.of_match = marvell_rtc_ids,
+	.ops	= &marvell_rtc_ops,
+	.probe = marvell_rtc_probe,
+	.priv_auto = sizeof(struct rtc_unit_config),
+};
diff --git a/drivers/rtc/marvell_rtc.h b/drivers/rtc/marvell_rtc.h
new file mode 100644
index 0000000000000000000000000000000000000000..f93b03bd2c954f1be9b645fb4de23a89e92e9dbc
--- /dev/null
+++ b/drivers/rtc/marvell_rtc.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Marvell International Ltd.
+ */
+
+#ifndef _MARVELL_RTC_H
+#define _MARVELL_RTC_H
+
+/* The RTC DRS revision 1.2 indicates that firmware should wait
+ * 5us after every register write to the RTC hard macro,
+ * so that the required update can occur without holding off the system bus
+ */
+#define RTC_READ_REG(rtc_base, reg)		readl((rtc_base) + (reg))
+#define RTC_WRITE_REG(val, rtc_base, reg)		\
+	{ writel((val), (rtc_base) + (reg)); udelay(5); }
+
+#define RTC_NOMINAL_TIMING		0x2000
+
+#define RTC_STATUS_REG_OFFS		0x0
+#define RTC_IRQ_1_CONFIG_REG_OFFS	0x4
+#define RTC_IRQ_2_CONFIG_REG_OFFS	0x8
+#define RTC_TIME_REG_OFFS		0xC
+#define RTC_ALARM_1_REG_OFFS		0x10
+#define RTC_ALARM_2_REG_OFFS		0x14
+#define RTC_CLOCK_CORR_REG_OFFS		0x18
+#define RTC_TEST_CONFIG_REG_OFFS	0x1C
+#define MV_RTC0_SOC_OFFSET		0x80
+#define MV_RTC1_SOC_OFFSET		0x84
+
+#define RTC_WRCLK_PERIOD_OFFS		0
+#define RTC_WRCLK_PERIOD_MASK		(0xFFFF << RTC_WRCLK_PERIOD_OFFS)
+#define RTC_WRCLK_SETUP_OFFS		16
+#define RTC_WRCLK_SETUP_MASK		(0xFFFF << RTC_WRCLK_SETUP_OFFS)
+
+#define RTC_READ_OUTPUT_DELAY_OFFS	0
+#define RTC_READ_OUTPUT_DELAY_MASK	(0xFFFF << RTC_READ_OUTPUT_DELAY_OFFS)
+#define RTC_WRCLK_CLOCK_HIGH_OFFS	16
+#define RTC_WRCLK_CLOCK_HIGH_MASK	(0xFFFF << RTC_WRCLK_CLOCK_HIGH_OFFS)
+
+#define RTC_SZ_STATUS_ALARM1_MASK		0x1
+#define RTC_SZ_STATUS_ALARM2_MASK		0x2
+#define RTC_SZ_TIMING_RESERVED1_MASK		0xFFFF0000
+#define RTC_SZ_INTERRUPT1_INT1AE_MASK		0x1
+#define RTC_SZ_INTERRUPT1_RESERVED1_MASK	0xFFFFFFC0
+#define RTC_SZ_INTERRUPT2_INT2FE_MASK		0x2
+#define RTC_SZ_INTERRUPT2_RESERVED1_MASK	0xFFFFFFC0
+
+struct rtc_unit_config {
+	void __iomem *rtc_base;
+};
+
+#endif /* _MARVELL_RTC_H */

-- 
2.43.0

