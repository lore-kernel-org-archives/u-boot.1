Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B935C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 10:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58A281FEE;
	Fri,  6 Jun 2025 12:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m95naCDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEB682977; Fri,  6 Jun 2025 12:44:11 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BA481F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 12:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udbJl4ReSOvo1/OoK+1YWxAEqb2VbkNQcFf5sfQ57GFlKX+NvoQtEGqgShnswV79UaU8F8b/IxHokIUvrPWjE4qpojOOLD/p7BqBbvsJNO/xyTsrpmaAB/9xlXAb1OfZnO7pGp6QZYg7r8lUvCzJZDxr/6moowqwoqNgy5f5gn7EJ2bek9J4vZ/s2+5yuQBZx4XapdEmCjS0wD52QWX3UJzmkErwaGmrr08uJkA6uOLzw66JkF03uGGXTlYpu2yWEj4G5moslrLKZIsEVLfa3WHWu1TydEqd2OeWUiUpHUQ8NrO8PgJDic3jGAdfR5ade+z8JWNBnU4wZh9V/bZgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2P4ELaNZ2jYOIyiomrsPpYo+4rUkH2YfCS51r9bPeA=;
 b=BCvgmydVK03O7wUKbpsrHJRFz7UfJScY2JxLeuGUsmzhYFDQfXprGjhc8g22GPZXXU+e3vZ60v9CkEZl8Qlz2enxSf+LUq7k2nsqDRlXumPa3PDaTlz1xaZT/Ucq/6SPY9iuqG/MC7NGSiLqo43Fb2e/80GnJavgWQ3rTCI28+l3dGeFl+fZsgJ5/ErPOEQ1yxXdxq1M64Dcb6TmwbfVvDFjHe4ARF0GO7VBvk3WW1RsAvg/BtG50YpEmV4wMnQ+yoC5BPC5F2i58i0ur//JAnCcMyPOmkkvXM69/8eDuVybfMPKbM2Ajf99Y/8tUb80CLikqeNpWOdDjuzCNTvkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2P4ELaNZ2jYOIyiomrsPpYo+4rUkH2YfCS51r9bPeA=;
 b=m95naCDB9Kzt4HoVknvHX+xxd0X1tFaKknlt2ovXaqzn0FnV9d2Bs59Mv/RbIq0JiVhITPHQXQqtg5A+7gx2/KdXvgegwbs15kADtsEbTx6HyF62dVbSZ6CzLRZr7eN8MmLcYhhSW7PEkDbIogWVPLwjXGP09lpCmqgZrPd+o8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 10:44:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 10:44:07 +0000
Message-ID: <cabe2ecd-7499-46ac-b32f-9902e473a55c@cherry.de>
Date: Fri, 6 Jun 2025 12:44:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
 <20250526-usb_onboard_hub_cypress_hx3-v2-1-f382415da84f@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-1-f382415da84f@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1e872c-1da6-40ef-a7c8-08dda4e70f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RENzUjdkK1RqSHFITm0zTUpwZ1BWWGd6VDlDTWJtUlM1Y2ZBQ0JiMGdRODVu?=
 =?utf-8?B?OVRiYkY4VGRmSUQ2bGFiOUVoMTVtK01VNlpBMVJiZDRQNkhEaU15VEVyN01y?=
 =?utf-8?B?cUkrSlFhVXcwZjdKaXV2aVJ3MkZsaTV1NlZmRkVBRDBGUlphZ2JTUkFHdUtO?=
 =?utf-8?B?dVUzUTJIcnBvR2RUVVZyUlVIVXdHTGVqcGY1YVlaUFQ0cUVBQWV5RVV1a2Fk?=
 =?utf-8?B?dFlVSm5uVFR0a0VZS1o3aGRVakVEVFZ1UGxCaDc0Q210a3ZyaFhUMjlwaUpI?=
 =?utf-8?B?bzQ0WGNNc2p3MDN0VUZNM2l3NUx1VjRFanNHRXN4b3g4ZVJJZ3hBTXp1dVVa?=
 =?utf-8?B?UFZQRmN3QjZkZXQwSzNiL3pwWFZqaTg0VWVVSXllYWZHWlp0amk5b2k3M1gw?=
 =?utf-8?B?Vy8xZUZXekM2Z3ZGT0ZVb3k2Z2NRNHM0QjBCNXoyQnJBS3NiSGdRWDVNWndR?=
 =?utf-8?B?K1FQQjM3c1NaTENKRVZGWHpkdWFxaXhpT2tpN3RHeHJTQXlHRGpRcDk5K296?=
 =?utf-8?B?aDVUSHRQYWduZXFvTGlIZmZpaURuS21qSzJNWGFMNG9saFdxTHpmczBMY20w?=
 =?utf-8?B?VnlsQmlpdGtSaksyQlQyTXBZWVJ1aEo0RWxwM2lBT0tDbmpDOFdSdjBVVmdl?=
 =?utf-8?B?Wm9laDh2WUhCOUJzSlYwZ3Y4VXZMN00wL1F3WDNtdmttWFFjWDJvaU5iMUU4?=
 =?utf-8?B?bEwrVVNPQXhMYkdRNjM4NVNCcE1oeklvVmdjeWE4NVJHOG92dmlkTldRUHo3?=
 =?utf-8?B?NklhWEpuSjQ4RWx4S0M3TTJxM28vditPRGdwQ0huRkRoVGN5aWh6UE55VjA0?=
 =?utf-8?B?VVcxOXNkbmRDaTMxVU13VkdCcjR4RzZkbm9kYWhrREV1OFQ2N2VObW1aeWFm?=
 =?utf-8?B?Z0g2bXhoY0JmMkQ2SnZrdW9OY2RhMHdmWnhtdTRaenYxNXQySVdaWGxvSGh1?=
 =?utf-8?B?VjI0VXppcFovY3ZsdnlaT3hZSzBsVVI1M1c5TzBuYkNlOTdRZjlEZVRXZlda?=
 =?utf-8?B?S2tPRFhrYm15SmpTU3ZjOTBQeFBkT29COGdvWWpCMjdiZENGMytuMGFEMWMw?=
 =?utf-8?B?Y2ZaMEhKZnZwU2lFSytDSXV4MElkZVNXNk9mckU2OUk0cDlXbmlwY2RiL3lk?=
 =?utf-8?B?c01zT0lBWWtZTUMrNFhDTWM1a2lpbUl0VTV2YjA0anBidi90OU8vUThMOVNp?=
 =?utf-8?B?NkRLUGJlcjEveE13eHBkRzdVMjAyNTRVQmlHWG9idHBlK2ExN3BNaUxUTWNG?=
 =?utf-8?B?Ymwwc0pxL0w5S3c0bjArZklVNGV3RXgyUFJLTnhNcGxUS0FZZHY1WVdpL1N3?=
 =?utf-8?B?WnBaWk1YMG03MTNUaUxtaXRXSGYrWjhwV0J5amFLU21SMW90TEluNHRqMjhk?=
 =?utf-8?B?c0VrTXpmQ3Y5a2FRNG9oUXJIbVhNajZNQkl5cTBGNjRVN3FwRzJ2UDFmWU9E?=
 =?utf-8?B?L0kvZkt1S1hkWVZDZWcySmJoUWVDZnNzTStLYkdKcUdCVEI2emdTQnJhYW5S?=
 =?utf-8?B?VGxXcTRPS1M5QlZiS0RvNExzejJVSGhFb0lZcGg1bG1zUk9hTTU3VFZLNVhF?=
 =?utf-8?B?WS9UbmZuOFM1Z0M0TjRmM09acVN5UXBTSUdNb090eTN6Tit1dGIzM0ltQlBC?=
 =?utf-8?B?dXpjRkF4SGJTbXZSRElOU21DYlRTcEx5bUpmZ2VXWHZwcGZEOXQ4Ykd3YkhR?=
 =?utf-8?B?VGRmdEtwY01QWGpzMWVJaTlJWGxjNVVsWlZ4UExmNHJxK3ptZytqbGJQcS9F?=
 =?utf-8?B?MXRuOGVCekd4U1E5VVQ2Z3RIVGwweENRSVNxTzBzRStaM1dLdnNHS0JrNzd4?=
 =?utf-8?B?Z1pqRExVR0RhV3czSDh2dWRjTnRHQ05sMHNWZ2ZCOFU3Z1NuNHNGcHJCK0xj?=
 =?utf-8?B?QUFKdk1KUDJpRHZ6cXd3VzhsS3RmVUNNbXNNZWI2ZVIwcmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRmZTd2OXZRbThuVWVMb0xGaGliSS8yY0ZYc0ZNc2tOMGttZEVoT1hzMUN3?=
 =?utf-8?B?aEtCZXVPZ0x4NlhqeFdQT1Z4OGZGM0hVSHQwL0JvWDYxL2phT0ZGNmZkd1lD?=
 =?utf-8?B?V2MwVUFkTVRjdzZMaTU3aDNYUmU0SXNNdThNb28zWG5tdTM4R2h4TDZNc3dC?=
 =?utf-8?B?eXlRU3c1bzVHK1ltSDhnTlNsT01lWU8xTHpXTTFIUkdzOUwvUnZVUDQwM3BP?=
 =?utf-8?B?UTNXNktrQWliN0JiMFRDLzNoeS9DL3pxNitxaEJJZU12eDNPOVI0enIzN2lx?=
 =?utf-8?B?SXY0Q1BVTFdoSXlRU1M1OWxNWnVkTnhGc3pGd0xCa0w4OWlxdjlyYXk0d0l4?=
 =?utf-8?B?V3RScUprendkSDFtWlBIWmduOWVBUXZqWlloNDJ0Y3dySkJVWXVEYkhTcmo4?=
 =?utf-8?B?MzJDclBzdFVvT3N0cDRHb0ZEeUV3bVNxdUdqWXdWUmdiTzhCdENvYVdlZm1L?=
 =?utf-8?B?NXpLMXIwcGhlVklUU0JRRTBHNFNzSzdFb1Bya00vVmN5N3BxZ2YzaHgxZE5K?=
 =?utf-8?B?cHljRGFBaTFocXJIQkc1MDAwa0hsK3hUYzJRcExVL0xDbksvc0FLSnl2aExp?=
 =?utf-8?B?OFFpelZvWThHSURpcnR6V3pnS1A5NVI3bDlQL2dRVTFrcDhiMnh5Z0sySFJG?=
 =?utf-8?B?cTlnaENLa0JzTkdrUlRaZHdvVVJEWXgraHRFRWlBYUQwcXA3dSsyVGROTTdu?=
 =?utf-8?B?UnJEK2FUcTlLRTRpUU42ckNkNWpTV2M1K0xEQ29OMlVRcUl0d1hpT3VZcHlt?=
 =?utf-8?B?OVlsM0VOQldGRE94RzVmaXFiK005NkdpWldHNmUvQll1MUQ1eE95Wi9HcVBo?=
 =?utf-8?B?UkNXR0g4YzZnaGZmd2N3aVZRc3NqMTdVTXB4NHl6NFJjdFRFY0RqSlBYeUJ0?=
 =?utf-8?B?Q0gzV24wQy9pVmFzTDVkakJlajRFNHFWSWVJS1VqeDhhYXNaYlBVOTJFV3h1?=
 =?utf-8?B?RFArYzFUbXhTOURkQnJjd05GY2pyeEJpSncwZDB4N3BUcU9xUHQ2aEZkdFVN?=
 =?utf-8?B?eXp2K2tpTE5acWEvUW5MSFlXd3o5akdTeks5eWhKcXNQTGJGR2gyd2p0Mzdr?=
 =?utf-8?B?ZHByZEp1N2tIbXBieE5QemIvZUR3UTJhaFIzSktsbHNWMEd0RzI3b1pPL3gy?=
 =?utf-8?B?UUpVcFB3VlVVZjBnTURocnlLSXRWZG1icmlISUVLRldQNmpiNzJZelhOQ3VZ?=
 =?utf-8?B?UGR6RmpvT2g1UFdXcFRwdHJhUHpFRmR0NHF4Rk9tREszRzhzZ3NTc2o2ZGgr?=
 =?utf-8?B?aEc5K0lZZzdKYnNxbW9OS25UNUFERWNFTDNKMlNzL1hoYjRCNGlHSkN3YUNF?=
 =?utf-8?B?L0JIWHkzazMvb3NaVDBZWkNVMXBndnNhTVk1UFVkK2tQbk1vdldEUkYzOEVw?=
 =?utf-8?B?eTA5WHpEeXRJeHBjV1d0OVBlMDg4SHBPdHNUVmJ3SkFNaVF1cjJMc0tBSS8v?=
 =?utf-8?B?b2o4aEY3ekJ1djhBOXVqK1g3WjdMOEtuWGlXWFlCOHBGMkpxbXNPZ1RlbitZ?=
 =?utf-8?B?R3UwcWlkRkk4Tk5Dc2VISW5qcU5RdGlaL28rcEk4a0VyeDFJQ2dnSEJERStV?=
 =?utf-8?B?dklDdWQwbHN3VTA4aUxvUGJySndiM014azR3T2pNbkVtUk1DaXpUMHhPNHVV?=
 =?utf-8?B?ek5vWDdKRXRMenVRUExqdysxT2NDS1dvVnBxWFdNaUlHYkVaVzFFSy8xWVlw?=
 =?utf-8?B?NDR0bWpySW9FelJCNzB5K1o4ZDMzekxBOHJnU3AvcGZ5WjVCSmltOTFTd0l1?=
 =?utf-8?B?a295ejNQczRuTy9Xa2RhU3B1RlJSd1UwQUNYVlFHUHNVdmlNcXFnMzJrM0Ju?=
 =?utf-8?B?N2lwdnloQjdGWFFrUmZ3QnV3VlJiZXF6TmJuQkIvdHZvM3pZRXE1WTZUZFpN?=
 =?utf-8?B?VGJrQk9RZG8rclRDVERESnAxK2tEc2UxUDVRQ0E0dzFMaWN0b0hUeXRVRkFC?=
 =?utf-8?B?T2F0YkVkN2VqV0VhMjdBT05zUDdTdDFDSWhXU0tuZVZGRU9yZFdjVjB3ZFZ3?=
 =?utf-8?B?bUZYeFNOdlYvOFl5N1RZbW5xem52ZTVsaXFXMFFoSzVzOXQzRmN5QVZ4dUw4?=
 =?utf-8?B?MGFRNnFLc0xleS8vQ3Z6MXlyS2dvODFTSU9Ib0VaeTdodmZDUFBQODdmdkdL?=
 =?utf-8?B?YzhHTVpiU0F0REpPbkl2VzBiZFZXWFFwMVVOdXpZcCtuYVkzYk1sMHh3R2p5?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e872c-1da6-40ef-a7c8-08dda4e70f67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 10:44:07.0981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VwwloV65ZT7EcFa3DseVo1hk4eJ5Y0kI2dgggW9e6pbu+O76WKj2xl80wIVriGQoA0PS9K+G3jGaZ5Pe0jLwCo6oVlz8DOdAoBAcLjWnXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
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

Hi Lukasz,

On 5/26/25 4:24 PM, Lukasz Czechowski wrote:
> Currently the check in usb_onboard_hub_bind is relying on specific
> compatible string for the Michrochip USB5744. Replace this with
> more generic approach that will allow to add new types of devices
> to the of_match table. Because the driver only needs to bind one
> "half" of the hub, the peer-hub node is used to find out if it
> was already done. In case peer-hub was bound, -ENODEV is returned.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
