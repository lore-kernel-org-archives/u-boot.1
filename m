Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6694FCD0DC
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 08:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D9383FD9;
	Wed, 18 Mar 2026 09:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ObyCzG9y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ObyCzG9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A5983FDC; Wed, 18 Mar 2026 09:32:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E307E83FB6
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l8hjBmmGqomnNAE41vYGkWfbySGxGystwWXsrauIq69ptB/UnYpcQXM8lIFwNhNSiJ2Gi8CsSoslp7zsA/CJ72I9F45wn8m1tn0PgqvcWkbLEum4HwQKjtinIkgqqXY100ZYOo+KvzEQyfI24+LBawwL45R+jbjIrs79Y5flkEbgGQNZrd8yXybKecpRdGtQfpumVY7MydeGP+FP9yn2Di8anMxO3pfA++/gCZiJrHDegvERpnMJQSdGYi5akG50vu5rlihVlr78El0lTKEtZWAOO989lKB0+/NhM/ZEFDnv3/5ELsApi7Cq5QTJRcIhi6vMkrvb35eDknA3dPvXcg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkW/Nv2GFpqqodA1Vc1tLHHWAPUk7U16yDSlWZfSGCI=;
 b=hbdAX1SFYe7FGcI1EiQAdfZgd9lvrUkY+2DWAS8aMhw46Q7ORDFeae75tNgLuFFMw3O0XZEiUggQMFT7LX6f8XMzq52CcF9gejMZfApm4GblNY57lhUxUDzFd2oZto91QG44hGNRhJ/iq07K6u3LNQBUTjsK3HUrpyGYaI8pWJIpT9cdleI7sFhMt9orGAg7/7zZTcvoMMg9lFe4nW9oFCbqzmFWT0fp3ThzJF12gWrWFz3wrUSqLRxze/rgU6+KmGbp1oU8haVhP1sZzRcjz13xvGGu6kvZ2QIZBkXNktpbNlmFt5smpsKD/hGbqZCz813pmf390ZXjNNhTernGLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iopsys.eu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkW/Nv2GFpqqodA1Vc1tLHHWAPUk7U16yDSlWZfSGCI=;
 b=ObyCzG9yBgPk+eiSZYuQSgTgtY/NuuO98G5wmNbKYpUYRoW1OoAlKg5X5SkCM8t263bLArCZQjIDrO/4Xbrt0Fx23gdX59vvPZXRaW+975VXzfisFa7pcy6VOEQXMY+tfRngaBz06fgZ+y3y5yI9MmfMeTGZu3f0CYO4mqZrZnE=
Received: from DU2PR04CA0163.eurprd04.prod.outlook.com (2603:10a6:10:2b0::18)
 by MI3PR08MB11878.eurprd08.prod.outlook.com (2603:10a6:290:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:32:14 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::e4) by DU2PR04CA0163.outlook.office365.com
 (2603:10a6:10:2b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 08:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 18 Mar 2026 08:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bslv3as++q/mePKOXfqzdoIlRPPx0ylLfd+adGZeb7CSHs99WSftsNw4xrLxxKjNC/pxITfMqVEdP1VKfhNqKD4WjZ8ZOREZ2hSEkTHIyR1vG4sRKBlWfqvWvF89jW2scqAyGJBk+gQZ3ofnlFbeVpbLgWVWnClVjFs6n7Ju8Rvrk6sYBr1ghSnE0fVcGnXJ52E+Ag8yMTV3bKfCY0yKJUwSCmIp7zsWV5WD4ulcg0D8LijFjNZYVmtwYtFgLKTYj1sxxJ3yKAzi3mBKkXs9ty7TEXKWZpSscRG8qcQLTQJcnXm7A048bGQzE21zJK4NiL+ArHvQwaIZzrS+WBjYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkW/Nv2GFpqqodA1Vc1tLHHWAPUk7U16yDSlWZfSGCI=;
 b=Gtc+86DC0bz77K8DhPiwaarAEEhWpBGSztBhaEh8rNyXHvW+yf8rQAMXMH2KdL45V6WzCQZhTwUipzoM3YeMafVEgTbxfsrWbFq8CytoyTKcLEqXcodxRXMF2fkEdbrXgIR/yXs5S0dqjjDSALdRbh0dobxXtI5UdhV/5g1O+Xj8a1Llse0m8XPLpgczL8g8NwEl8T/rJw8HCtjqvIpfgJT7iTtO8YY4FOVpIWckWWX4uO5iYICcNaSXYBC2StCOK1U5/HmIlBZNjlP75N6AXSVLN5tIFN0CSw1XsTfEdCvjZ47eBbr6IaCygFwF3awy6stW6VYx+z0gwOxn0C7vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkW/Nv2GFpqqodA1Vc1tLHHWAPUk7U16yDSlWZfSGCI=;
 b=ObyCzG9yBgPk+eiSZYuQSgTgtY/NuuO98G5wmNbKYpUYRoW1OoAlKg5X5SkCM8t263bLArCZQjIDrO/4Xbrt0Fx23gdX59vvPZXRaW+975VXzfisFa7pcy6VOEQXMY+tfRngaBz06fgZ+y3y5yI9MmfMeTGZu3f0CYO4mqZrZnE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8381.eurprd08.prod.outlook.com
 (2603:10a6:20b:558::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 08:31:10 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9700.025; Wed, 18 Mar 2026
 08:31:10 +0000
Message-ID: <cc2d2032-15b6-4c45-a686-b344c26eb110@arm.com>
Date: Wed, 18 Mar 2026 09:31:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: airoha_eth & pcs_airoha driver fixes (for
 u-boot-next)
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8381:EE_|DU2PEPF00028D01:EE_|MI3PR08MB11878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b105658-dea5-4daa-8f26-08de84c8db9a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 1bizk4NA4cp7IMZgqvooxswYHFPteckEoCwVCGbU6xwW4yvmM6ltfrAtts03GR2c5VDYWNi0rqviU0oW5J9O0CE5dx8LtRVqHzicvp+KM+OQ6ZJ0giMdPc/JCXMnjXamulhqKL/hoejaiD0ymgsED6EuN2bZqxCn1isROhy+JcrznLm5nuzdA3h14eCJeYGfPL3er+UKWmDgSqH5q0BimLX/iXn8XaRn+3lC28G+RRS+G1wFC4J8Y5Re6MbqpBOoR/RxTIyFAZPitjsV6Y9aGLhYoN5m/afX/dnTeA5yEwRqbJl+XvU5b43p82tu1G3j034AZKRlol8gsWawvwX26VOH7JC6osvy8FV66yJOCC9tohhr6lVnyjk+FqsccR4XT/QbXiHB2Hrr66zydC5ED+OML48nFpxAjEq0WanHxNHj4OUxVky3mQ1ZZrKDikp0b2vvwT93h9Qv5b5+pim+PLFAaweOnKIIzYx4GC7JhzxzHj8bUgqCaM5SXLrRyO6eO50aniMNVsQO53hVRYQGfHTNHEfoZBAoGmuZvR/TBkjZijRzDsWcPNcFg0asQ1EC4MuEK0/H4fOkFjK2mNaiU9F6hsh8N37yPmG9SHpobBmPlyaSfZnRqBHFTQ9Tx7xux+/i0XUmkaS++j880nHozqosr6Cd9ZiYyEYvOkxOYM9XsPxzEbXAC58kIWRbYiRx9lcs2vbrRK8JE2PbuIhQASEexqPrudJPcRDCxh44Zns=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aNRYMWw+6LvkL20aLEnLfSAZT9/a/JZCNIkBBTX1ggSEj7XbSrFgntnXab3Ww8eKDEVWwQ2ZwMHp3GRcuV+qdK+1K65KJgb0kkGQc2UhkXO5p7oefL4B1YZGFdT3zQwCRupGn/QQEYc/0IyZpgqNq1vPqUW3uwjAPoPJi58dIhDUvm3RpiYgZOnMXrtBnQj0fMIs87oYzprls83zUtfXg8k4VFjd2iuKXtnpz8nRksiCafxSwau02b2+cpmJr+p17NE7lgG6MNg/Z/z2VtkKs98g8eKfWb/jSQA/n+sPeKX+QQ0Q1Rol301ge1PLNj+Y33fk5AIgZFM+wpv6XfdTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8381
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 24afeb6e-ca0f-448e-572b-08de84c8b505
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|35042699022|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EzxQiJfTZZjC0ROYM1f4weR8Qb6F2XiJtLO3ImlAMNxUnKMVXwgzCKW2BdUKyqwu9AlSc+f6EjzW3+tHZ7jjkxeiJ1d9ZvMW3/hRPxyfXgOez1lFWfa5tkI8OQP0jyIXnjid3d00Q9vJASUMOct4Jy2OQ/NMg4lg5JFECZUPjsyZjFQsbhqbHV7wd5114P/E4P9lu/4CdrzMHiw8Ajze+Fif2P29kd9B1IWMhPFvUwngdgkeH0b9aUX2/T0QnpPT+/Rzsvxce9X9PlskIeJnWBzKux+q0pWlq3BGq/GvzK9XWuEMJyxuEq+zG0OnlxPBgQ8k5EOWZSweiehIPARGNM8i/kcGgtonrnSUF9FC4Qh+sL88l15pERgFDafnEhQx9Uu5RoAZV9A/4xHSH+Ef0lwu9JmMIzONSLREOU+VIJfAc0EDUXy+MP0GWHsdeILMYRyGBeE8k8r8/MyqFVlbDIShpTWdpLjuuyPIxBTHAvH7NYBUZOyH9IutP131cfAkNDNANPt+yPsmHGYRTqKDAnoKCLpySXz5JLPyrwgGONtUvx+BgUanptRIx/Uk2pVzomNcBYXYO83jZ7Fy/r7/RF8dK7WGj7nsVl+xRGU6Cbz8kO3qZ2/uJd/qA34+uXE2CuyU8/NqunrlOr2h2lvp7WIMCv/8JyYzZnYWSpHFI+jTaNLOOu8SlcHDBO7cL9b66gEspwoSwFYkXDRdM9mfFXGSA20Ev0qUunfCxlCidldMC19MdNANVSF3A6m0RZKycyX/L2fCam7fgNdUPqzg1Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XLvaAy581YziOW9It0w4scc7NlD9h/k4pDlOtWkNjD1cneybvykQM7zdfcMjHhA0iqiVt4kwqOfV1wFbhkKf0EAPCNVyiHvCn0vf49pVVI6tgzi0bv11Ho5XfTdjLLje3rFmszELomR1jeFs5bYtxK7w6L2XJBchxfVi73CWuPWpGPkLsx7SbMj7MJwOSfbo+XyO+1SoJfvDP4yBamC3Jlyixe9IBvWcTag+0iHOoL60LCudSyvGbhvTHBw2AMIlfr1ZsCKdxZODR97aTHGzV5avJTUeAt06hO3HAk9NtjdWvG+mW4D/OdQ6zHEZ6LVc0adrVjQpbCiGSVBSTA6z+J6JacwEjcg+E0Qwd6PV3V02LQJj3kjcBVTJYMCkRwYF22uza7hYX/gMj+BrhjSaxlAQ/zhLAk0D3Ke2uWiZXo6gtak0xC7V9fHTRxE5esBB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:32:14.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b105658-dea5-4daa-8f26-08de84c8db9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11878
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

On 15/03/2026 08:47, Mikhail Kshevetskiy wrote:
> This patch series:
>  * apply minor fix on airoha_eth driver
>  * add back pcs-airoha commit dropped due to CI error
>  * fix allyesconfig issue caused by attemt to build ARCH_AIROHA specific
>    driver for the x86
>
> Mikhail Kshevetskiy (3):
>   net: airoha: probe airoha switch mdio on airoha_eth probing
>   net: pcs-airoha: unify code using SCU regmap helper
>   net: pcs-airoha: fix allyesconfig building
>
>  drivers/net/airoha/Kconfig             |  1 +
>  drivers/net/airoha/pcs-airoha-common.c |  4 ++--
>  drivers/net/airoha_eth.c               | 22 +++++-----------------
>  3 files changed, 8 insertions(+), 19 deletions(-)
>

Queued for net-next, thanks!

--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
