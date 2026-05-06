Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95718CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 08:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F29E8488B;
	Wed,  6 May 2026 10:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GpvFoNyT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GpvFoNyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C506848A1; Wed,  6 May 2026 10:58:28 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FCF8484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 10:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TqPnesaYYw/uUaFYa+oMJSInEqXcvwo/yloTmhwmxU3uJUgMCAudjaXGYfz/QeESx1LQ0m9q/b9BTP0d16nJVre7ELt4ZEOIWEEssj43wbgnnu8kn/wPWF7mkSKCs2Uql+Kvw7t8G5C0ILJHFOh7niPGJiRnHPDYWpszk18Fi1gFqJlRKaIoEVoEyuxFxFzzkF55TDYQZLaaWJ4mhfMbO9Eeg4Qa4GfjAD479PJ/k/hzMzjPfWhcpUFjKHVFlsJBPNIgIPStoBC3zMlkmzfAX9w5gER/qESA4Juj+WRK0oTUnsTYM74OLmeJgXgyS8CmrEO/5Quuuc7jd1JSjCuVtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXA4dhBm3iBip+arEainCz6EwhhveBHiDCN8zjQNqFY=;
 b=G+OAiuqSdm0kAgGPyXVt5Q4xbu6wBJ08wU3QhPNS0aumNkBi/VyXJJxWGoxqZA4DAp6FplvjUPNuQcWRrX8lTZnvyKKaTRH2hzqT8HUI793BCH0hfQy4ZxX3U44UKyNoukv3cr3sfwFiYk00+BofWsHfDagpiynkK2ahe3LBIVaTSc6wU59V3b9xcWxcYyJki+2y79DJvJacRavHDTBgrk0IJd9UA8LoKh6KeCbIY4s/t7CS3uMKQf4Gx4QsVBFgdaMBjLt/iB59yp350ZViFINxU6Hn1IMMbMp7Rde56Khk1du+bPcUZKvSs4haQd56qEO4BYWXR9qIr+op3HowVg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXA4dhBm3iBip+arEainCz6EwhhveBHiDCN8zjQNqFY=;
 b=GpvFoNyT2mek4bhPAO1J53COqP9Ar6RDSOjIQkJk8rcI/w9S80+YEV7pgBJyKq1OY/t4ycyQGfR1tMeiyjAEaua2LOmy6vj+hD+2WIzMOqywGvpW3hspAd79lxoarqYVSDpyfv184APnET6WPgTtCeaIgEmBxUoDl2dmOkICbno=
Received: from CWLP123CA0238.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::19)
 by AS4PR08MB7631.eurprd08.prod.outlook.com (2603:10a6:20b:4ce::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 08:58:23 +0000
Received: from AMS1EPF00000091.eurprd05.prod.outlook.com
 (2603:10a6:400:19f:cafe::72) by CWLP123CA0238.outlook.office365.com
 (2603:10a6:400:19f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 08:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000091.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 08:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxPJBUSKY/6KDduRd/0hID2OB29sGnRKJCUxQF9kquHCgWh0j0oyG2Lnf68CaCfTofCDEOVIlnDCdU2ugEcR6ZfAE3Kw4fG9m1cYvpHhKq0Io2GcBcAx33XI6Q7Hi/bQca9v+ZAvPyZwl4Foh9mU8kBw37tStestyDnmDEHI0fmFUCP+coYGQPSQyyOHQnaX+f3pn0yo3NBfbqqCgv4+5msRgTDa7NnYG6nPmADAltLf/GDMchg/YsGQEcIlatnmM+b+E+wU2Bk6IRC0D4sc5hYl8CR4osU0vaY7pHDzYeCzEmIvBXx4lFEJVWoV4oQxFbC8yJnP66IOfHlE+YvmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXA4dhBm3iBip+arEainCz6EwhhveBHiDCN8zjQNqFY=;
 b=Ea/SZchDhN1EVWlrGGXmpKKzTQdHyM+oGXoStMgG/7ETQ8yDtCHrgb8vgpOtThMRS2A1EJymwlEjnV+HUXj+LNSlxUPbPAgrs01/bfrRP/10PMc+lME8JWwk9Qjr3UQT05i7q/6DCtN9rrloSYNoZhcwkdovy86/61Zg21nccm2Rd4tKMYxLC+q3a/WL5AqZcx9+gDZgWyOb3N/lmaeYWhIR4VDyZ/wTQLJE6gE+94RtVwdnLeC+weDgnh9Wd+ANyeFcEgBsMJ/C/+ilL+EQKH+UQbqY+5SDiMI9i3ipKYi5f23PnS2S0y8VA6pTpy3M/9FAPbCNtb7vKMxf1Y1YTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXA4dhBm3iBip+arEainCz6EwhhveBHiDCN8zjQNqFY=;
 b=GpvFoNyT2mek4bhPAO1J53COqP9Ar6RDSOjIQkJk8rcI/w9S80+YEV7pgBJyKq1OY/t4ycyQGfR1tMeiyjAEaua2LOmy6vj+hD+2WIzMOqywGvpW3hspAd79lxoarqYVSDpyfv184APnET6WPgTtCeaIgEmBxUoDl2dmOkICbno=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8480.eurprd08.prod.outlook.com
 (2603:10a6:20b:55e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:57:19 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:57:19 +0000
Message-ID: <17eb561b-c8f7-4883-aab5-6d2859c13a33@arm.com>
Date: Wed, 6 May 2026 10:57:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] phy: add common PHY polarity properties support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, trini@konsulko.com,
 sumit.garg@kernel.org, marek.vasut+renesas@mailbox.org,
 vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 nd@arm.com
References: <20260425080649.75688-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260425080649.75688-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8480:EE_|AMS1EPF00000091:EE_|AS4PR08MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5c1035-71ee-4204-98e3-08deab4da064
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 92oJRKHoOyMjGj8tFaoDAHlL/N+85gzPRmu/dTec2I1tYfQ6XJWhWEYK2rzWIMRDF4KQbQnkKiHFRHcateeMQ8mY4YHm4ZZ9O//r2+r2vZVIUlNlJaEefd2h9M/yFIvfi9Pljdd5L7ia29YYQw550Gjnme78OZKrRM5cgKVnguzD+6PFcKxfqCnP9b5HHIEjjFRs87iQS0yxVOerp7HZO2AFOrsPJpCGSfB8SYsUGwD42plPv0UX2fK10b8B1yBzkmnBOmVxUlj4pqcrspkm6IR74w8rMSZCzYGh+j2jrlX/IbYriwk0nMCUpbg86KBf7yoziNSUl6eueItYfYFnEOu1YwqcnQQUz7dwbfFj6ZnNMBtL6vKenKzLVDcbooczf4x10gAwH/mqfIS78hpz79gfz0NTCQTV2K1Q4+5KoLNuYUQPo4Yj6w9zFjRYfE7SDU2EDi1PeoiGICvwyenNblmCAxakg+xaz/npXjsDEy29fwUoJ6oKuhOk7AKz7rgj0d4v2ZSxGJgZ7ySm63Pj2mKKJ4ZL6dK16Jxg0ZZJFulRcY/8DeN4Gh9H/sinAT5j8tnj+LPEEe2yf2xOar/z6LhGWOC9Zo8WNng1pvcZvL0jstqA+rRUzS1pWU3sh8pBo+t3w57ETu2qhOEZ58vhTBLeHNDUbbJIg1Xy93mm2YtM4yZvbmuCpwL1elq9bZSb
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ARgnQwG6NaPXnrMHhwUJNMcCaJhlFk4ROA2b8ypgzDa4PAUH5/QjCnF3UHv0v2i5RotxX6K1CwTtyLGaCZulowRa8zfYM8BSZVFv1ABIg0cF5cIclh8W+JusPDNa27ix8TlYV9ytazBaE8vPSbJRbRr7fsS1WpRdvnpncFh58hxbIsC7dQ2m6/SxzcqbQeyJ4vwvnLMqf3JhgUWh3FEQRmBk2/h0HS1cXTYq9ujY3ZC88EC6DsEFJCjDbjbta5AP9HzpEtdPj6yQHEGuf0/MxTcQJGyCYWWpAGMgl4i8yW9Wv4F8sPWrhjEoGLzQYyziM7WelsHVdzDeYNvhGP5FAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8480
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d88e91a8-b474-414c-688d-08deab4d7a84
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|14060799003|35042699022|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: RJQoX5c94a8068PP0wOoNangAzTxC+mq2Po+QcILjjsxPbk3bw0/jykZ7RLC/wmvSvbb6mpj1vabl0n5InYAhYmABCv9957h9Vj73meA61O4jroVCBag5J7C3bSOUMPmZ6sE8HfPhyz6xkO/s8wfoklEKVpCNt+stHXGj+b8why7wNwlrcEgPLQqxW79rUG4rioGghR+JDtmSPuJNIqxpoJxRRvWPYgybIHj9xT0VkMKlhgvzNIZfioE3DkL+fS/htbQ4Tm3nCJ4WhLl1wkS6H428zl9OaNpbOSUy62vzo7ILTTF3XQ2xZUUPtXjNlz4wPuZOjQ+bhWpM09DkBnAWsiYk13r1Y9sBo5bWHnmjPrx0BrMlMKgPd0oxHJDOn9SssDITkPKD/AXLq3gGiRNmF4wTaA40R854QUaH0h71sJl70U/FK5e7tsNxhob265GF5KXXvEFBx6BuY8cP53+hbo56Ne4KDUt3f5ykI0PSUZKWZgONabdiucNMPwbsb0LdVmcSoH19WxlZHxDQD23l9Gp2jsjl6eIYrSab1dBjgrel0+uEZX0iNHrzZAbDRTD7DZd1ABm6A5U3dMJ2XFVfRpF8bN93Yy/uZjqpmKdus1Mz76Aj2EiumnU3PGi2C/murtjlMUjWPk+0+krHdkmuRJ9onXLLy7Te/HbYeeiN+Tnc/1snOJc7ZPcXRKAl0QDn85ZV3q2nsvZBUYyrxgJATipgrDI8k7c9/8OEmxEO0M=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(14060799003)(35042699022)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZbcL6wGYnH9is9MCnCtB1scOBt1hptxyK8RPAyU9pXcTZ/Lw8qNOoRguMOohNN6X0fhvoj77QeuNiXmSXRm2HE99L6OnH+ECTZYaQVWZkuECnzK3EpxWFMvcm+BRnKpyNz/UQVzgdhnQM4UynOslx/FocwxcQcjqV9n9J8nQhSv9p699OwSxcraNCmR2TSXPSxnBlJNDMXy08klZ7hIXu3EvZaXz+preAnJwTAD5E5ouvbwdrlz7h5dDnOB+cWbMUXV+G4bj0M6EDW2eXCnje0bG+QXDKwONNynvKCzGwULNBHz5vI4L3jeo1iEmLvCknKnbznf2nOBUbFJwaOZ/r+3L/RO/bFqXOE3aFlOZQk//Wgw/vJ7SjNxI82kdLBWbfnaozy6X7R+Xft2IZV9Ym8KD2IppLWYkoNRwxf2f1Zmth7mLaoTpl2xnH5NsMSIF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:58:22.4041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5c1035-71ee-4204-98e3-08deab4da064
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7631
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

On 25/04/2026 10:06, Lucien.Jheng wrote:
> This series ports PHY polarity inversion support via generic device tree
> properties from Linux kernel, synchronizing with Merge tag 'phy-for-7.0'
> of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.
> 
> Patch 1 introduces a new PHY_COMMON_PROPS library providing helper
> functions (phy_get_rx_polarity, phy_get_tx_polarity, and their
> "manual" variants) for PHY drivers to read standard polarity properties
> from the device tree. The PHY_POL_NORMAL, PHY_POL_INVERT, and
> PHY_POL_AUTO constants are consumed from dts/upstream/include, which is
> already on the compiler include path.
> 
> Patch 2 updates the Airoha EN8811H PHY driver to use the new standard
> rx-polarity and tx-polarity properties, with backward compatibility
> fallback to the now-deprecated airoha,pnswap-rx and airoha,pnswap-tx
> boolean properties.
> 
> Patch 3 adds sandbox DM unit tests for the new library, ported from
> the Linux KUnit test (linux/drivers/phy/phy-common-props-test.c), along
> with the 8 sandbox DT test nodes in arch/sandbox/dts/test.dts and the
> CONFIG_PHY_COMMON_PROPS=y entry in configs/sandbox_defconfig. 16 unit
> test cases (8 for rx, 8 for tx) cover: missing property, single value
> with no names array, count mismatches, name-based lookup, missing
> default fallback, default fallback, and unsupported polarity value.
> 
> Changes in v4:
> - Squash former patches 3 and 4 into a single patch to fix bisectability
>   (the test code referenced DT nodes that were only added in the
>   following patch)
> - Add CONFIG_PHY_COMMON_PROPS=y to configs/sandbox_defconfig
> - patch 1: replace printf with pr_err for error-condition messages in
>   phy-common-props.c
> - patch 2: use phy_string_for_interface() instead of direct array access
>   phy_interface_strings[] in en8811h_config_serdes_polarity()
> - patch 2: remove unused local variables ofnode node and u32 pbus_value
>   from en8811h_config()
> 
> Changes in v3:
> - patch 1: fix ofnode_get_u32_prop_for_name() to apply default_val and
>   return 0 when the polarity property is absent, instead of returning
>   -ENOENT; update @node and @default_val kdoc accordingly — this aligns
>   the "missing property" path with the behaviour expected by
>   phy_get_manual_rx/tx_polarity() and is validated by the new unit tests
> - Add unit tests for the PHY_COMMON_PROPS library (patches 3-4), ported
>   from Linux KUnit test linux/drivers/phy/phy-common-props-test.c
> - Add test/dm/Makefile build entry gated on CONFIG_PHY_COMMON_PROPS
> - Add 8 sandbox DT nodes to arch/sandbox/dts/test.dts covering all test
>   scenarios; include <dt-bindings/phy/phy.h> in test.dts
> 
> Changes in v2:
> - Drop DT binding patches (v1 patches 1 and 3): already merged via
>   the DTS upstream subtree merge (tag 'v7.0-rc2-dts')
> - Drop creation of include/dt-bindings/phy/phy.h: the header is now
>   provided by dts/upstream/include/dt-bindings/phy/phy.h, which is
>   already in the build's include search path
> 
> Lucien.Jheng (3):
>   phy: add common PHY properties support
>   net: phy: airoha: air_en8811: use standard rx-polarity/tx-polarity properties
>   test: dm: add PHY common props unit tests and sandbox DT nodes
> 
>  arch/sandbox/dts/test.dts            |  60 +++++
>  configs/sandbox_defconfig            |   1 +
>  drivers/net/phy/airoha/Kconfig       |   1 +
>  drivers/net/phy/airoha/air_en8811.c  |  60 +++--
>  drivers/phy/Kconfig                  |   8 +
>  drivers/phy/Makefile                 |   1 +
>  drivers/phy/phy-common-props.c       | 286 ++++++++++++++++++++++++
>  include/linux/phy/phy-common-props.h |  69 ++++++
>  test/dm/Makefile                     |   1 +
>  test/dm/phy_common_props.c           | 319 +++++++++++++++++++++++++++
>  10 files changed, 790 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/phy/phy-common-props.c
>  create mode 100644 include/linux/phy/phy-common-props.h
>  create mode 100644 test/dm/phy_common_props.c
> 
> --
> 2.34.1
> 

Series added to the net queue, thanks!

-- 
Jerome
