Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BF3EF3715
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 08:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D5B83BC8;
	Mon,  9 Mar 2026 09:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RG815m6b";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RG815m6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A801883CDF; Mon,  9 Mar 2026 09:16:16 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6B983A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 09:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cCAcehULQM4WwGCshR/6pzQvj4Wal8CNcUN9JVDTT7v2H3hmTtEqfHGcMBFeajBvyMVP7m91nK9tlUPLjLeTS98QPUTvXm58xmQRZuNvfAEfZundiv5wDXjbTs3u9lih8Cfk2S80ds35rV+Ni6RbjEUVP1hynNV+B1FdtZKr8+ndPLbFUmzXnA58pSMtLcbDZ2ui8bIDIql49sUWs0TU7u161DXnaegNDyDdk9KL3BaXt7EyhsWUVnGFY/HSmJ4V1Lb+CSuLMWDaYNiqK3KkLHfwJvDY5nlBwKvYzDOcCS2nw8drIwdZDKlzhhjpQaNRb7XLJa8GZpezmWzjZlzz4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwNIiI2sTZAgFqQNLTBRuylOkrr6RWLZ9/kbMsyV2yc=;
 b=qEoiROUYJLFZ3kQPsgbqshVRiEOU7j8KjbfWm6CLgUbzEpdXHAro3jyoD1HXVVOs3w70VjBkQzcvdZOhF5A/Ps3vtjjBNb+JXBaQJNlL2F3m/v5pQTYePvMvmzcdjc+oHLLHZstlcgF7OObXnTRlcP9air1tM0uXR+A55423Z15CktvNpQIsdjjlE+/zhnQ0lx+piy+0cC6Tzyk3I2IuvLeKthqrNigN25o/c1C5OE7R3RNF3ca+d4Y3bpWyQeYYxCGxjYRBc8o41wfY6xfgKX77oWTInGWqxhnSK/FiKSQjY8jId9DF2pGoNuC8Bww9CkA+2uObNGYu3NP92LMltQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kwiboo.se smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwNIiI2sTZAgFqQNLTBRuylOkrr6RWLZ9/kbMsyV2yc=;
 b=RG815m6bDeKqiEq2kDc010/3JCqpldMhf608CJUnAa6RNWt7qDl4xVH3OqDgee/aETpADXJ95YSaKDQwdk+fJBXOchR2gtS+8S+t/2yWapu3sKlsbNX9d3wc3vuGnbqO9j+oKSnI8pfEdbxejbWLAvg8MUBPZJn6eXRny4O7+Gc=
Received: from DU7PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::24) by AM0PR08MB11281.eurprd08.prod.outlook.com
 (2603:10a6:20b:701::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 08:16:11 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::16) by DU7PR01CA0002.outlook.office365.com
 (2603:10a6:10:50f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 08:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Mon, 9 Mar 2026 08:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URQUHLBPKZ6n/WohttBq6/CkfEx3T3NTWCZtdfnsIR9HVH8TjJsU3oRHRiCCEmNZ6cSfNlbY/kJgIdVINX76OPTyMDFc3WqhCQcN/2eOOHrmZBih5KeWEYrkPHdyZSp1q4iFpqj/i84NBQqv/Pqo8H9az1Gs7Uw5oFL0St3YqPSoUhS3Ea+C8eNFaOt7QZRO39usjiB1ncDUHuoLGVV6sq4I+U54Uq+jChAHS/Z7SBKEx0x4Wz9QF1X190Ym2gRgra7Q7PbuGwpmEraEHDbEnmcgElt4MQTMnN9TfAiOoAUUrF5kmHdSMW0FxHTAakxwQLsdblV1tArGkSzdTApuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwNIiI2sTZAgFqQNLTBRuylOkrr6RWLZ9/kbMsyV2yc=;
 b=u1tHrxOuY9VcMBXNNdK5cLMs3KxU9/ZgFF5drO7ezJ+4RZUUYnp0aL8GKjKrVR/zcH0chBqPiKE08Ly+E7ipgZUMZWO0qo4TMxUJISWcWtWddmMoVRQBQQENzHDKE1cdN0YNn6Y5wn8RkqjRpF0BhxEy0h5ypFjNjDtmltaNaFd3KBrozOMN6qw8CZD5kSCHJ0HEPMDNyPVx2KLza7ThYj2SdsmHcqaioH7CdWYB3wyzQpYr50yhSJ2XLQdotsbkVKtcRp7KB/hIh6eDQgJt/nYIVy+HLIXr3YmxiG59oEWDJuKmMzXX/nLtDHdLd6Ib7cr1BMhl3pTWeeXENH8Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwNIiI2sTZAgFqQNLTBRuylOkrr6RWLZ9/kbMsyV2yc=;
 b=RG815m6bDeKqiEq2kDc010/3JCqpldMhf608CJUnAa6RNWt7qDl4xVH3OqDgee/aETpADXJ95YSaKDQwdk+fJBXOchR2gtS+8S+t/2yWapu3sKlsbNX9d3wc3vuGnbqO9j+oKSnI8pfEdbxejbWLAvg8MUBPZJn6eXRny4O7+Gc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB11349.eurprd08.prod.outlook.com
 (2603:10a6:150:2c4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 08:15:04 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:15:04 +0000
Message-ID: <21fa8850-f7bc-4b88-9395-06881b35d443@arm.com>
Date: Mon, 9 Mar 2026 09:15:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: Fix PBUF_POOL_BUFSIZE when PROT_TCP_LWIP is
 disabled
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260305223606.3163779-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260305223606.3163779-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB11349:EE_|DB1PEPF0003922F:EE_|AM0PR08MB11281:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f7f8c0-ebd8-49c9-6635-08de7db41f3e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: NSxgKffz2ruZoEPbqcr/JfxmXO8OaRj33EbV+UH6I7X2p4JqJsazR0Gh6/8+NVdqQ9GL4FYYMfLseds4VSYSwWlYXu/tN6MwwQFOBVvVm9esB/883m4BvES4Q+BhweKexHRt4hJ3jRNFU1J1ZJ5bzcH2jo8qPM4mFfglpEUA1+dNNQIor0H196An1nQZWqqOYLVhSwkXOiVuQl8/O5HsHa+R7GEnVQvEqxGvJkh6AyV+4rJlE89i3I8K+eiKJMVaql3yZqtidkZiAX6+jsx6saFCa/ZhwV1jvjX3XjphryjI754kQEDIGD5j7OkaQz3SgUnv1j6I7p+aoeddabrnFf0uh8MdcoGed3KaaszLbVflfl9ojwyYogL3yiwtCGOv0GYb4xl0tn5Lzwu7E8O9E6/u6VhAcf8xc6LCwZtvIzl/zX68orRoqPs6Xc7OmnHj6wGvSltBEshtWl4DUBf0NwiAp3Wq/daug46fjL2AYh80oqBwVRcpPYCS5z/FqzqXOmKM5wdAvZGqmowkaw7bEW6YwWrkv4EPQVG6XJtREFlZ1DpN9QtnhCPKr45Y1dJVOf8jAFp/zk5mLSdTfr7Z/luDFCie1Z+SG12zFUmkC+3U6hz+EzgJ9EvlkevBOqQ+/lfc49lykXIPrqOBZkkpEkJ2QhdafJrcN2NDRFf11cCCQReOaJVU+5lfrzy97Z4IWq0NpMDeYtOS2r6BQnzVWUO4YDUBe/RHjfUQS7TrwUE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: c1hnJRVN/a+Hh+Fv+qXIw7lNsYj4Qrp/JuWiXPBQI/R08dVgmU8xh6zoXsRtnOrkWqA9YKNrpfJHkSiYHMSdfdjfjHCFuQLpIwnxIGBeNGS7pfnntYn3e+wTOYVnSUaBz3ygwOxAk5Z68fsLTIW4wDOZoxoAdM7Yb6UxBCfhn1D6PnsAWKBkzB6HFJC6Px0Y4o1jISestq2vMpIPg+P619rEhBFzI5L4dRCQH9fM9F8zI0p2Ke9C5NFh2fkptq5T3ic6lesmqFzWkqcM/jzOcYm3Eej3A7oFsgIhR82lLB0UEbL9ZRRxv94vVM9dlsVCpY3/lS85N5IsiS7NHen/RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11349
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f53d895e-9843-4bd8-b8b6-08de7db3f7d9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|36860700016|14060799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 6ix37NE+jVUKHrTJl57c8Mtq5ybqPdwfDkqhcEMKXvIJZp4vbd+K3lfG+xxHe/smSv29aQngxjVhCVxi0l9vdE4LmzL0VDsR664uEmq3cCAfdy0V0U1pnGqLH3Ogj9DmBZ5d31a4VwIXZGJ3RRfDnXZMCezMJeiKV9Eq8bUA5Eul7mDdNNFsGYLz0Xq9rs7i4FBM1bomK7BghDa2gwR2qRsNvUE8mEco1CBoqKM+leq3L8psOor4I4DX7dToMGHGYcGqXTmbqh/yvnwdlZcGNNLw8ehkWmK6tmLKSeWQz+Kr+8KgxjwNTnT3a0Lh/J3n/K/qyftAWy2cbBACXRX+VkGKsThfD2gbTNedufKC0qVX0XaK+cKsBcFyW/H5t2Y7yRVyBnIqPB8ogvOqTMVqZDOmXM1oZ8WJxU/eP9wvNxYLsf4/dusrI4Q4iyym2bjWITy6zQZwBhDwZUOPhYzL1KdmZT/FI1+fgHyc+T7uc2PFsSQW/f/DNla8/O6H45jmBSF8GUxkB9ImjR2C4FzwIDV6zo9FFN7koZfTx9TzatDUaLaxnFAaHRlk1jR5orgDbBHHd8LbSzwc3fd4MuIXjey2Y5AQYeYPNchFUiQGgY7uRPmrbgmAgdciGP3HxPI3lNyg+EeEjep4xx05laFHbnyO5RNHOfhcmfIXYdtBRHU/rmLKBzVwi7NstyGFIlR1l0gZO0BQa5MRM1L9CzYkpTGOPQa1NG1oP52UTFHw50/PerdMsgTUSjP9ieIHkYvCkqbmynEjiBr8W2xeXNTZpQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(36860700016)(14060799003)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HYSJlPTkw8uA59vJO6U80pgQ32Bq2YzsMSvXWBy8DBH7Z5Wsw6h9QbMOZbM7gKUmcRLMUdj/eTTx2mwQejPd12BJvS3ceG+wDckY/1lk8as1GBy6nhGExXJS4IkhmqxlCKIGZlj1CsbsJ+FHUtZjIFzyWInWsFni/d9lWRXZoqw+YTEfqLUXlaCB7/ttGh0Pmj0icN/srYH6G+lyq9a9d23rwvqRbF4W83Dshbq734mm4zIEaVVmJOOXRqEETELhcILMmSg/DKpUiqiNo1IctDwIBvi4B234sxNoVFd0vOagcwdMfXsTTIkRBERpiSArIm4bkrCKtZL1DPMMBjwodcXRqn59L2SQvvWYVhTuObpd2dBYJPpfXXrED3h8GlaN4FZJ0iHDBgyzE9QEBmKulSOHVsOhQoM1dIrAZ5l9j2hJ/3g601ykoUle6jLJLhZX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:16:10.3723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f7f8c0-ebd8-49c9-6635-08de7db41f3e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11281
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

Hi Jonas,

On 05/03/2026 23:36, Jonas Karlman wrote:
> The PBUF_POOL_BUFSIZE ends up being only 592 bytes, instead of 1514,
> when PROT_TCP_LWIP Kconfig option is disabled. This results in a full
> Ethernet frame requiring three PBUFs instead of just one.
> 
> This happens because the PBUF_POOL_BUFSIZE constants depends on the
> value of a TCP_MSS constant, something that defaults to 536 when
> PROT_TCP_LWIP=n.
> 
>   PBUF_POOL_BUFSIZE = LWIP_MEM_ALIGN_SIZE(TCP_MSS + 40 + PBUF_LINK_HLEN)
> 
> Ensure that a full Ethernet frame fits inside a single PBUF by moving
> the define of TCP_MSS outside the PROT_TCP_LWIP ifdef block.
> 
> Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  lib/lwip/u-boot/lwipopts.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index e8a2c9d7a0a6..96aae3ad1f4f 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -121,9 +121,9 @@
>  #define LWIP_UDP                        0
>  #endif
>  
> +#define TCP_MSS                         1460

LGTM, but I would appreciate a comment here, Something like:

/*
 * PBUF_POOL_BUFSIZE is derived from TCP_MSS even when
 * CONFIG_PROT_TCP_LWIP is not defined
 */

With that:
Acked-by: Jerome Forissier <jerome.forissier@arm.com>

>  #if defined(CONFIG_PROT_TCP_LWIP)
>  #define LWIP_TCP                        1
> -#define TCP_MSS                         1460
>  #define TCP_WND                         CONFIG_LWIP_TCP_WND
>  #define LWIP_WND_SCALE                  1
>  #define TCP_RCV_SCALE                   0x7


