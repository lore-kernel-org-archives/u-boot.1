Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59557FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2ECB846F4;
	Wed, 29 Apr 2026 09:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Fhq+Vg37";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fhq+Vg37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C43E846F5; Wed, 29 Apr 2026 09:26:20 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF039846F1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RJpqhQHT9LpvZGA7Vmqn7I56esvpRZgEqW/s0pbUbF2l31Q2N+WwXKpT9WjYNWD0U88ebJ1ssB13qv4ZjtM1mWJUdzBytSq0zJbUwO8aZx/zZX1s3SRz8aIiJU+9u8zLWEkn9yIyL5cQJM0CFDMZnK5CpxRtqCtwZUiZGektzcQDfL4krkca9IfQRwJA8TLgnhrwuRK/awIt6s850Gyk1vs2A11w0DIOxtvVDo0czfAq/7c0VXI7F+k/rOWf4mIdM49YRMycbdFkIrq4KasPiYLOAuaWL1BMXnXSsBf6ziGlnOPkYel1YSRQPBOC4Qr0KUSlu+guCvretu8HYnFqpA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvVTpnkwNWsiDr8oKwQE1J28K800Gjyqj5XmLtHUpAo=;
 b=acvPA5HVqefGE4QoeFCJETEPKiNxz0DfSoPola9EryI8st0LtHbXSc+S0Esr7vA6PiMj6308Sa3gKfbm9PC34A0BfWOxfgQkDnIU5YsuDG1KyalzK1H5yUZ03uUKXbBtU+a3/AH45bPwoWEX9zWVFpEk42JeyRBShPbl2TDcICaXvr541iGNbhLFgvr8fjzgljwUZ3mP3rXp+bLFdxrnMBwpWt151g4XuXRq+7iGWsiADTucOtj6SFjwFOPpBxzfwDmma/lFNioLrKM73H38WRtnfBNisM2GaiLzZferV7LA3XyDqRGSpm3nJI5upg46kBlbbyzZKP07CApFhMEHzA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=canonical.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvVTpnkwNWsiDr8oKwQE1J28K800Gjyqj5XmLtHUpAo=;
 b=Fhq+Vg37n2icPmn9xiBw4/Sh2hz62xlwf7siAkM0ufn3xyUy5+egFfUcBH6oIwZEyKVmjTSkkUygSxku8oOyMxdmIQKRJMbjoecqMzytyOYssCFGbPY4KsGdRaykPt6ssQTRitkHWqV3fqW2Gy+38ubh++LtUw67eCH/nNfa/vo=
Received: from DU6P191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::13)
 by VI0PR08MB12010.eurprd08.prod.outlook.com (2603:10a6:800:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 07:26:13 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::b5) by DU6P191CA0039.outlook.office365.com
 (2603:10a6:10:53f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 29 Apr 2026 07:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPxRBrZ4G/891KsJsyeddV4v1m+zeiR3WH6QmQxuKwHLUasrT8zETP8dYE3ILCGDPQDbhKW6R4KUrupBAdtbCVVCVLnmNOaDT/sGzZqgu3WTWHJGQYrLG5IFKZsKv/p8pbgBXZNO52gmhNjoZOK8UT2tcssXy5ZQkeVbi/r4EmJFnMX76YvTROnw+Z1jQrT2kj29m8JY+f+7rLmUam3mUVY7ban+uBy4pkQyZXonm5+OBXRGhLh95IKNd71UvdI6pg34Y9D7Xoisf+VdF8cV/UFPv8kwo+5UICYvo4Oc5o6nRhHlj0anGjtyiqPTf/u/070Q5JVVSLmw769j7uezrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvVTpnkwNWsiDr8oKwQE1J28K800Gjyqj5XmLtHUpAo=;
 b=yEDmA3JGcCQcw5g2CXsjxiCptg9TU2uCJN5uqfyiz37ODEk0wY9CCt+8rIUjtCSN+Fth1RLY+BngnXEtNIycBQaOV/3O4FWTLnbLxFssMa8/Kr4Zbcue+lb9uLWWcB8QoGk5YHtUeNOQFadLNI4KgJ/MMhKH3+Ivh/aSFowEkfJXe9ZAIab+IHkSBcj7AQ0yuZRoqVuWi+GppCRKDsZO50GW+u+n8pDhR3qVAtaGB4R8LQfRVc2G4PZDuxVX6bUW3WXl8mgA04TklHIYs1/zQd2I13POkb0VJth5QsA7p65F37Bq/M7dDI44yAtRIhUu2k/ZDMF8mZHjAlsad1cmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvVTpnkwNWsiDr8oKwQE1J28K800Gjyqj5XmLtHUpAo=;
 b=Fhq+Vg37n2icPmn9xiBw4/Sh2hz62xlwf7siAkM0ufn3xyUy5+egFfUcBH6oIwZEyKVmjTSkkUygSxku8oOyMxdmIQKRJMbjoecqMzytyOYssCFGbPY4KsGdRaykPt6ssQTRitkHWqV3fqW2Gy+38ubh++LtUw67eCH/nNfa/vo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8830.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 07:25:07 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 07:25:07 +0000
Message-ID: <5bdfb744-9c60-4fda-9e56-65bfc63fbec2@arm.com>
Date: Wed, 29 Apr 2026 09:25:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip/wget: don't print content size twice
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 nd@arm.com
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
 <20260428181434.179888-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428181434.179888-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::30) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8830:EE_|DB5PEPF00014B9D:EE_|VI0PR08MB12010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f15471e-0964-48e5-ce52-08dea5c097b7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: hvy76H1XVmIISpktS7gDXAQxKWD3SUClKR6hpKoh+FziF1MC2N3OUH1jI1xGU19zpV129RWd915EVjmrpJE3t9STtWNBJBYxnPzEEwFQO/jqlb1G55C8VziBTlr4VWGIrFil3bo4CNB2Fj35kZWOYV0iIXkSDIpOAtWe4voRod7eiFEN3mtmZ5YqjWroCjQ5VnaaxWcLCyhE/VXX0HMaWRrthivpmABCXYndlaybbZGlfThmCpLyn252ywofZmObbk/u+dTRrnAx2z8JLU6BG8CmRELAPEsWgg/5VSLpT5EStogEwSDHx7zJt0ff4azu2M+6A1KQrvF067DCg4DlFn61Mx2WMMxT2ePpMKV190XDlyZE1JMmOI+xiky3vjmkHlL/XcxbgfrWMfsKzGkrb7WbwVs3LjthAVg1ONqibMV99HdDeTcI6Ek3L8QiB6DVjGSmV/t9PXEmMh1VUqx2fhF/y83Ntv10zOZ7P6xYaDKhnYglPsPmWGfkWQ/Ru9gN/dlvx0pJf2SiH/yRlPG7tQ3asYnt468YAwERyKI9a1dD/LmggSAKThIFgH2ubQRKRpwSepHkcsHi/pXFaDdkapdbsPssl1zScfJyAvfYYnAyzA5BmeaLydCloqMg7y5HF9z/Mca6meipp7F8+G3bQN/f1qCYyjt8PHvJ3UdhSxYw6bfzdUUda7mTBfwh7h9FiVemxbpLxxwwi3Nkt3TbO5vWfK7t6o4fwpeOVn5bPwQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: b3Odx5PE1/FS08H2yFZMQxuyKC34XT4U2TOctkd3+KFfyyfTVdImfBNg76FvMVN3TDFklzQQIx0wUE57w/yvTWKFsCxrRbJ0aW9ygLDc7sl95seqiuTzBH2QilaZogy1eAvGpCLbOdviZ4jYG3Jnxtb9zr6vYplxC7rK77kClciUmVnln6ACRZeyl5+3BOr0lnH0a1MtWE6qX5UugFMUxOnIEWDGbNDNIihUfkcZhn8ptN7+r79xf19NvaFQzw9rOSMXMEFRe0EO+zEA568eL14trNTmcr97TXhJL3fVW6uj0vyvcjDyHdG+CetBX+6WO5cuYwsRpn0OXraXSBicAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8830
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58fef8a2-e187-4525-2cae-08dea5c07094
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|35042699022|14060799003|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mFRC6OgsRj954K4uHbx8L0dUay4ER8nHK8i5VzZjnuZ99NdpvT1ZnJ/DK8++OPAuiycLcdPf04CmSqXbc0aehmXbb0ITI7MUD8oI8xRJ5FjXUQqqI7FnZT4Q4NUDQaRKq69cQ4SybUi/m1yzR6CUcJZ56cOiz4Pp3PPVAzSSHX2SzGIdfCRsrDj+uhVmlHtW68MJmYkNcHagUVqbeHEfhK8wm/8O3awEAHp4pPXbTwAu//4gYs7q7kyNC/uhCobr0QtHM9i7puhwh/OZgTV1Tredk4Juu021fqZj71lGdOS99CT9GM3lqkhVpC5/GKjsh/tdkUeEbKgh1ITry77F6aJyXq+ZY93dqai/QzACnsyDR2fZFzxfN5FhTzzVMyYXxckioh/snlDMZdwCaNc2CSfCxP7nZYBan2ONTwRKN9xgTMMLk14HiwSTsDW2NW4hRHRHrFC0Z4nd5FM2aGrgA5U8TVZUzY2rSuUrAmdPCL46xiMLsipUkAkQNR6LkjUGxKhDckbLj1ED65deA9t025dTLYoy5PvVjIkBHk4fVmbY5YyEIIH5IFvf6L+G4YwrEv7fAJbandEHl6ov50xyXFGa9z1fpwYENjqJPUrryREPP0VqQE4OG2kcrNbHUOJ1ihuQVznAJoJ7pZtSCITcmipYAf5GW3qpGRymy6TiIDLwMp1A1cjCKYwsSBYnvRluBXF/bu6EqtVlwx7w//A5blpUfS/E3edbgoLPnfb1rJQJKQk2Ic7F3n56kSQiwKfvfoxaxZoLZUdw0jZav5FDHw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(35042699022)(14060799003)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ymXAR/7sWGaL/3LagqkH/oR51XCUm2bSYp/W9uuEcAmN2Jo+GuAhIz4ZG0rSRIeKquLcSuQX12ZvakTcWz+Y0cYE4Rqpw4YGVnfFqneEhpSjsofsEfNwBcpgYI97Avqm3r3E3nS7WyjXjtPuN/73ImV6XNz1TZX8J3wJbtckcBoNRAUMl1vRR3HiH9HzcYBIgUHlBQsiKYNK+ycZfMdgqkjYGwXzuvEf+p4KmSb3l+ZZzz7CFKbVndesutTRvk7K3NxsbpR4o9UQVB9Fg5bf1t7ArovaOm6Q8mzAoB/Lsx999R2cu9CJZcWHoH2229HlPEBxLE0oH7zurPDT2+HZ/JqH1Ib45UvAQwLesN4UW5OOp7ACT49xlBUn5uiegL5mo4LYcfyGE4xtS+SeSAwr6zJnWdbnKdXDBa+DPXAh+sg4gnKXn+sUu/Esf2MTTfTs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:26:12.9933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f15471e-0964-48e5-ce52-08dea5c097b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB12010
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



On 28/04/2026 20:14, Heinrich Schuchardt wrote:
> If wget_info->silent is set, we should not print anything.
> 
> If wget_info->silent we print the received content size.
> Printing the value of the Content-Length header is redundant
> 
> For chunked transfer no Content-Length header is sent.
> The content length is returned as HTTPC_CONTENT_LEN_INVALID by the LwIP
> library. In this case we were incorrectly printing '4 GiB'.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/wget.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b6c25be6115..983abe2ccd3 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -243,8 +243,6 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  		putc('#');
>  		ctx->hash_count++;
>  	}
> -	puts("  ");
> -	print_size(ctx->content_len, "");
>  
>  	elapsed = get_timer(ctx->start_time);
>  	if (!elapsed)

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

