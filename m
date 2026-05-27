Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D1CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E4B846D1;
	Wed, 27 May 2026 16:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HABAzezR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HABAzezR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D654846E2; Wed, 27 May 2026 16:33:56 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26A7844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XDYeE8UNxNtNVZ+5YFbROw4YjO/MlVDr4pNTb0a4d2TJPvVC40ouUqL7ZeUNd8+S4qHZofuPL45rFe1DeCDjmuDci/yN4B/McBSbPA1mKWPWFUpnTIVJmPQzQS/CFv+5tWsyUZF0NDfR7UEsMkU1H0dPsDaSoJ3xDnWm5NX79ZiQ3xCmYj8RYSnqQGggHJtkJDNe4ykxVqOm7/cRfPaHZhk2s7l/RA2bm7q7PPe2UhFYgTpzD4xQjg9e3qZvzxXDFAt9ScRke6/g9lc+CC4Q5Y82xf7ebtlcieXJFQxNisPL0Gw5wrd779iOdNrZwih2bMN1MwiWik/BHMRyWk1+Pg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1C3A0+0xTv0vB8r2Z5TqhQmK4bRT5dPWris9sGaLnM=;
 b=c+TQsD3q14sJVUfLbbdqcDaNasd8T/pyTABbcqVtCLqc7CIaJSPjkhUHDl7kV25HTLFz/o7xnGsZLBFBp64gy85wiwwkE7OBvAFlTi9PTDk+E1dre+vQK/pTDB72xJE8swTIsaEGft3dwBNFwG3jVX8UnKiwTzq/CaulhZr5MGsdf2IEW2LOaTcCOjsfzisYCogt27GK/QtA3cZMlYQe1XKuD6cLJPGqftPgKi2/CJvxLnOuoohy9t08DzzYRR/Zyv91l5SPgmT/X5yLp0OzBJDWZrQYh7d2lDYcIVjrPg+JK79ieQfdeQQ5g9fLEk4ZEdcyf9UMobI3Iza/YRj1nw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1C3A0+0xTv0vB8r2Z5TqhQmK4bRT5dPWris9sGaLnM=;
 b=HABAzezRW/2GYYM3cUqSHaGls/3HhNqiB/9kMq6VVFVCUzbYUOUIBMIXXL+nRCsi/keVr/mR84cHcYaSenaE1lK4JjTTWVu0Bic8/vT6KC6LIa9tMQ/lBEBpwl3jCjM3Q0tGO9tEfu5f/vvUHr+UUyr8yMImuHLF3LrmmjOj14Q=
Received: from CWLP265CA0449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::17)
 by DB9PR08MB6731.eurprd08.prod.outlook.com (2603:10a6:10:2a4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 14:33:49 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::81) by CWLP265CA0449.outlook.office365.com
 (2603:10a6:400:1b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 14:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 14:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYF+qem1AYSR0JXOgOnwS5mQG1pAyVmU4BB4FNbOuxci1/rBfTPJrBtgdz5zDndyyiCXWVY+oM6YbQepji+i6V7rAekqzGMRQIkvTeZgjpuHP7tWMchomXziRS2IEupA0Byh5XjvrT0Qhhx/6z3o8qrRd1dObDSFjyqrrl+K17Ypqs9Kukd2ft7ZfExoDe2HAzgNJXbPybyCCJbaXm/i29v3zmc9jPHcd0+tvDGrKfX0sU8M59ubIpJsk4gXBgRBxdwuJqPWTNAxrQ3Qy/DiEFXtgqqxK5wYTcKdjTiQvaaRMWYm/Kq2KKeOtzflRK5uRoU50hRCjlgOPqVAp6+xyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1C3A0+0xTv0vB8r2Z5TqhQmK4bRT5dPWris9sGaLnM=;
 b=t0UZ+qnjVFCgC3VSW1YCcJ2MYhVqfzXaq/U80iNSbI+6u6rnhts/UoVZmKe3SEIXLWhxCndhCmN/NTCoLRhWymeflcmzbXXiWE26kqC3LrkDERotwksGUGDsoZsKUbgfoxdLtguzty0gpUYtFQUNavQB4YJ7qVK5JQtM+VsgrGe7WiuDwo0zjPN1GE1p4gUdW3tAT7D2d8xW6/I7zeP0KNFRtzc3zhDAsxJsu+vO0ddOs7Z5ZTnHPKu3C+il6e3Q3Rqjb+8Zap2NhVIYM6q78GFJ0QG7r8HixoypEd/a6swZd+dOL0RjTbpQOGt3M7a6cJ+TjmS75MXWWcqcZmW7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1C3A0+0xTv0vB8r2Z5TqhQmK4bRT5dPWris9sGaLnM=;
 b=HABAzezRW/2GYYM3cUqSHaGls/3HhNqiB/9kMq6VVFVCUzbYUOUIBMIXXL+nRCsi/keVr/mR84cHcYaSenaE1lK4JjTTWVu0Bic8/vT6KC6LIa9tMQ/lBEBpwl3jCjM3Q0tGO9tEfu5f/vvUHr+UUyr8yMImuHLF3LrmmjOj14Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS4PR08MB7856.eurprd08.prod.outlook.com
 (2603:10a6:20b:51f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 14:32:45 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:32:45 +0000
Message-ID: <7a5255da-eee9-4595-9164-81c0ec9037ed@arm.com>
Date: Wed, 27 May 2026 16:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] phy: Use device API to replace devfdt_ helpers
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>,
 nd@arm.com
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::24) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS4PR08MB7856:EE_|AMS0EPF000001A8:EE_|DB9PR08MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 44672ae5-ddea-4154-5e70-08debbfcf6bf
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: V+RgaXdzAnVGpfWqSyu+r/k7lns5g1yufmcbrYkubyibwnhv4txVOEp0OsldTsHX1Oaobc7+bCid2JfA7MC+IEYhwYSfMEzacuz3EAL/RHYZByjADR4V/o115XZm8iADE153f0vGXsW1EqkDd0lpaHiOuZyBQgeEBtGJ/fkv6YidLLd652EajeK+LLH6NreE6evjK15J+COgSCnX1NM67AMafmJxTghCsQQWr3cqkEzZOjKvoptjWA/H2Vc2Df7ZtHElKtuO+7+BgzfSw3UA1E4oxP8vVwNoqeyA9o9if8ZIuKrhoUC116Jlo+ypfP7ukJ4sWPwD6pclRoO5BI6oQjLzmrYZQbQkXPPorsbb6ybflMDTERHOMXKFoYEfwNibskpHs0QPciwjKi8QI2TvASypQZzIoJsFW55+PvUOLqXWYk9MjuPnB/cGpbhukHjhayH5tR9IWMuZJ3M2v16Ty0/pRX1msLIXEg2s23vw9bYv57YMe3bsNcAfjWKtdGcfz2F6crl0hE55m1wgjpxCXje8JC5Q9ia/4yDl6qDvmuA2sN+fJg+YveECqirNhof9ZubTJzMsTuS60aMgTjhuVex5tS4pGgJJTMvyhZZlT+NKhg/OEx+sWg/ZPHwyigfDQquFDD1RpB0Is+kKhTFNCxr+Vq6wbUPOl3+t8vsuRujMhGkQJNHUM435EuP8Gs4F
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NslzEV3RP3IDzLMkpuIOSJi2o64Wolr0mzbZ2PxFz86HXQZr6nbjXVIcYJP47jy0vCxNQmlDanHN2nmJVCXNX+jiNWgQRi2fx7D1L0QWFQ4k8ly8jlWhV92Zo8if3TDd9JpTpUmgQrMhajJUrc6kMtSjTjXqrvOfhnzLCjYkT9sSKtR8jWNSzh/klSmaRyH+4oAVTnbw9c57wc/IKbbYOYvofqgPqdgq9TH68FOLW1tpSGo1ib/91i9gpgiVyXgor12cdYoYp95HjVqCeLESOvwXcgU8JpBBMFnoxOXsaQF2mp0rD+CcIyl2kQqFUAeMkp7SwTC5cCpBnxv38CqW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7856
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 257a3d94-1321-4fbc-e220-08debbfcd149
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|36860700016|14060799003|1800799024|376014|7416014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WX/uDgF1F+fSiebnGGSUXT/wfLhq6Bz0tnO5yv9T8POW6FjS3Z+4spToyBaDV/OVeCZyeHu65f9e4+V5Ef3Y/ZGdsED5NZ2i+gZPEN2e0VDOpbzsGqrkMWOJC7zoFQheXnz+DHHhD31+2YwrQ5R7ausrHaDFkqT7FHxEexUdrb+84cEvrsNCfEliCHjqznb+ONHQgYLpo1XgXXhNVqE3RIVVVsXZHP1B9G3/O0eQj+6DDlmNKlnzmuobwab7rI4eefnl3TQi8DB9UVJ5ny9ailPVGPNuQf0RofQNhA/owMIzyJHjpDu8NUC7y+X56/f1mHTSSOBGy5Pfi13pyPacVGADH736Tq9evwg/UFLDVDAIGdr0KgNligRVvx68sPpGj5+AGqONlLzTJ5vZycA2lzfrArpAuS3UqbCcBF5KWr/IQYPnRlqzYtEWJJAEFv01yFDTOoT+cWkb0SUYYb0+hNKKyqupryO3L43wNuQQHSehoY/K5oFztREW3reTVQLXoYd4QCz9BArovhJGmTyK5g3O7lMiLDFVvWQYR8TcMW8ivFEGSlWYVC2wpVjMIGJ10yXTXoMf1h3SfEahF60kImAeXllOZwgs+ASDrJqbhQheX2j5wGk+EFH670M1fOm+LImOSRhqki8u5JcSn0o1WjRb5/A8F6aC77XOrKV5nPGkdpfUADqCgcGKjO1OQJDDke/oHf1PRFK01HlTDzAdFpgu1ncq81crRYCfGoiWhl0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(36860700016)(14060799003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m9TYaMMrjXGU5C+eyKC5L6IKWNQKuu2YMIQ4wpEzsu99qNOQ1PH2NRvDU4t9zKAEvGZIolRJ9FYTw5QuVZmoeNL1LY4JF0RnNZmkh7OFL8VEK+mekeSH7u0XoLGVVMEdJjAzU3ioHqVgJoCYYZPiEoGhsY6leipuTUkD+q3fBuAnTH0+WaalJKzxLpg5a6+kyltIq3P/wRIVgb021Y95ifdnaYmx62gq1cAXK5GOlgT/2ZLJIg33Hk9XUsQG6JAOcSgUDL7Fh1u5bQkiiG96/mo9pVj+5COGu5pilu3Xqugaai0mI1FHX7AyT3x1n40t+pktJg6e0mAF3njwr80jdy+x/ws//VXQHg0GCkfWzN9qggXxRldVXDHPfLPL5Tqvk4RrwUxCFs55EgJ63c3ZocIdMgmYfcVRP2TxNlO6pPNZo6ICfJyyl1rQDNOB1dn8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:33:47.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44672ae5-ddea-4154-5e70-08debbfcf6bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6731
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

On 26/05/2026 08:39, Peng Fan (OSS) wrote:
> The goal is to remove the direct usage of devfdt_ APIs in drivers. The
> device APIs supports both live device tree and flat DT backends,
> avoiding direct dependency on devfdt_* helpers.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (3):
>       phy: ti-pipe3: Use device API for DT parsing
>       phy: marvell: comphy: Use dev_read_addr_index_ptr()
>       phy: cadence: Use device API
> 
>  drivers/phy/cadence/phy-cadence-sierra.c  |  4 ++--
>  drivers/phy/cadence/phy-cadence-torrent.c |  8 ++++----
>  drivers/phy/marvell/comphy_core.c         |  4 ++--
>  drivers/phy/ti-pipe3-phy.c                | 23 ++++++++++++++---------
>  4 files changed, 22 insertions(+), 17 deletions(-)
> ---
> base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
> change-id: 20260526-devfdt-phy-f2894541e3ad
> 
> Best regards,

Series added to net-next, thanks!

-- 
Jerome
