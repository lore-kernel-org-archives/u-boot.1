Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5B6CD37B2
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 15:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83A88341A;
	Mon, 11 May 2026 17:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mbjGaKu5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mbjGaKu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0B983CD3; Mon, 11 May 2026 17:30:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302AB81E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 17:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fXnBGM6STFJ6lfKyBzIQ2/FXylPWz/YO5vmSGtI5+8URsC0dtGQtrTtN8WvwugWYkYd/JownENyc/euKpk0FDemdggcjiLRKJzTHP6y+MoCfhMnbb9hkN12/hDtYsXdjvOPY9s03Y7bpgI0IWK/OxZEd5ELa4oe4QblJBetU7xoa8WNJd9EvFEF8FVixI6huijbau78OT7ntrtk2q8aPMKr56Cj0EwJ8ixLrytsLpR1aizD3N2X2D4Fx0fJ1h9QcJ0HJTPGL20j+wifmphcwvDp1IzyUx0inz78ht5V/Ebym+92+7d+5VkNaIRHx1fqK1/V+jCQY4IexyYdmwPBtUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSHqnUvX7PDMBWpAD2rw9W+Xy6spTtYlHf1Wsa0bVv8=;
 b=ZXDdndMWmDsSmI3kopp8zGBtztk9WUupuMbgR8mDeO/w6VcUW80pKvSpZE9OoOhNA+p3sCVtqWuBbcaGRJiWFfeTcJkxBuFdK3dYiL60bgoawnnhpuEisPOWi49zq/V4w2QMdPWRPKv0G7N0T0rc2ZLyh2cgpaFB2VpQ6+Z4KClAzIZREuUPECjU9YoxsXmGbQF1fvI/AvWGSv6gF14XHt0Zy7Fxr1k9kJmz20kiWqs9cMQX8zPNogy2JWeh1kYyaIKz+PDRC3zkS9Qs2PDm38nI8VZ27MgEdfLP+6RTKycnBRrpRLsZF5BQIbGs6aTQB0W2r0OxLLpjyYRQfWTfng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSHqnUvX7PDMBWpAD2rw9W+Xy6spTtYlHf1Wsa0bVv8=;
 b=mbjGaKu5v7a/1GitqzFL4nbOwR1bBFm93KpFxEcS5xbz2Pw0/IbFOPqDE/kNDal1ZlOKYZK/FJtZOzyRX7efak+G9Ez0wXgnuz/H1U/7OOsQKG2Kv1JBdvU/vBAYtWeSp27XT8Kf3ew9vfagX/0wklhl7eh3cCq+UdsuOPictWg=
Received: from DU2PR04CA0295.eurprd04.prod.outlook.com (2603:10a6:10:28c::30)
 by DU4PR08MB11007.eurprd08.prod.outlook.com (2603:10a6:10:570::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:30:49 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::15) by DU2PR04CA0295.outlook.office365.com
 (2603:10a6:10:28c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 15:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via
 Frontend Transport; Mon, 11 May 2026 15:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IH3LSvG2f+sWVgBCUQWmCzyeufdWOuDMFZisfd4T8zxGJ9MmYxi1X4/o6njMfubMiR6Pk3csWrY5I938G1bVQl9tLHa0QcLBtO8Dy5jOtNDG4LADe6icvt/vEK1DvxWGqDOZdMzBt12CT98yxWLPXO2nNKuWwadSi6sGcGDpdwWPrbO1v17OExXfJwlnn0/aj8RvRMn7CORKW8K2zxqVXJguE05k+YQVfN8C6JoD94WFfrUsEdnT23JvQqqlPfqa5d8nViQ8wt9kGfUsmpxuzRnnOWjm5RWS22V+ghHaW3bp6Vp/CbzYhTBx+hrbNUuJ89kkeSas1IsHgh479YsFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSHqnUvX7PDMBWpAD2rw9W+Xy6spTtYlHf1Wsa0bVv8=;
 b=kxDVwRUl/XAInIozHcElKX2+D6wEfNwWVE+iKOf6iXwYruuLrSOG12jK+pHi/YBY5CI0tut5JGSro1lUMhBN72VETyQhcgMHis7Cuj7jOqb1n3b2eAEW2X3tugG9ouwLXuaLieq/Olss5dQPHtXLZ6jLt7YUvC4+cePY9an2onV/hnaMtJUlDEw+Y5V9MwN2QmXtPHke9pBwKfxR9Zlxq7L0gqx5syHziy5SxgpdV92aGLwGVAjfuQFX6K9D7nUP+9fQmJC2SMAQ4TXW80gin+aLWUjpEN7T95GkZk1zpOB7vVG2qesWyok64ANkQbc9f/PNNnuiTg0i9RA6c3GmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSHqnUvX7PDMBWpAD2rw9W+Xy6spTtYlHf1Wsa0bVv8=;
 b=mbjGaKu5v7a/1GitqzFL4nbOwR1bBFm93KpFxEcS5xbz2Pw0/IbFOPqDE/kNDal1ZlOKYZK/FJtZOzyRX7efak+G9Ez0wXgnuz/H1U/7OOsQKG2Kv1JBdvU/vBAYtWeSp27XT8Kf3ew9vfagX/0wklhl7eh3cCq+UdsuOPictWg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6065.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:29:46 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 15:29:46 +0000
Message-ID: <55e14878-7f7e-4c8d-8eff-71c14d5338a4@arm.com>
Date: Mon, 11 May 2026 17:29:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg: Fix portname buffer overflow
To: Francois Berder <fberder@outlook.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB28053AA411008729F40FC707DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB28053AA411008729F40FC707DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0505.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6065:EE_|DU6PEPF0000A7DF:EE_|DU4PR08MB11007:EE_
X-MS-Office365-Filtering-Correlation-Id: 380cecd4-8ddf-4653-0811-08deaf724729
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 6I+WjAD6xl1HmweGQ3EaVjm0VzbHcrZEIKim2u+AEkQ9ioc6JcCPd3/k0ksWqCWiulVfytEA6pK8u1Jz7H/IncqyWay0KvK4u9Mx3se64KAs0N3z/oDcs8+kR0GkzRUi3KgpImUm0IlC3qb4UmvV/fVcX1I46M2SEhzVuNCepjYWhR+LdJCRSOgrze6rVSnteBbC5ReTjvr6tHwqqBrDclr1K/yne0hI4jTXZHd+ra7dpUlyqNj4Wir6jQwnumid7Rc8oOZDGFEom6vrhwJZUJXx3b5ersgLPfhK4vbQEv7bsJRAg95uIJJv+9XA+u4GXWba16CUZWUXVqw1U5CkWgB0I8I2SOsv+OJ9Pu3vQcuTGm2oaQy9424K5dvF1p0O7+ygGxWKfvfD/6m7IfxVtXKKZPEx+tnRQ9NKe7S2M7q3MaQEpXjLSaPcQxex8SEntIAp/pVaR4IAWVwa3Ph65cB6PWfmJCeRGh1ceMdMMieB7wV+CpNxn93BEWta0xG+H36XNSQeA8QdmbC3YXSKUI0yd3Ch0VOWxz5oX7I1RKPnOW3NkqEbNyU/0eBl/PnHbRNlpwHjOsU8fcdFcK1q2MZ4aCPH7Ncq+UiCWQ03TG8x3EsKrSTSZrEu2VOnjQxAlbRGU9x4I6KUbgJbQRieBOUQqH9OdzNeQchHRVMhK36plHCRPvucGOaM44Lo7xtn
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: b07ovNnf3h0vhqMBR81rGA7y7m+0QS194h9uiQUnZCofrkE7bXqBRRWo0LM7hXvOfF64oGdp7T6lLpQC4MdPBvoBwrMCPVFRCWpZsbbKzYB2S6hqHfSJQFZxkffKj7MmTj0vLPZzD3vR4KcCcxNLztzxsCdcp1Cgmr82eFx2MYMhAW/am6m1GZEP6dj0GSvQ759wONVdNk9/Uahg1hWZBr6VKuOjwCXiXfqyMpJ03DNwtWq8IgTt6U7+01JzSESIxewDWbUcAyxDtGSSutR+9dJKuBoHB4+oPC8VEyNfAealfeL6AI7BDj9WuzgfL+lPDCX1Y9ASaTXTjGN8T2iotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6065
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b917fcaf-f3ac-4504-cf55-08deaf722210
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|32650700020|14060799003|35042699022|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: ZvzU76mfAU2oPyUSDi198stJOCAqbRgT1PPhhgPdy7n4DlXMI6PBByaO9gOrakwOrQ5zD+FnmvbVyqlURsO10Srup4e+I3+jpYrDlxbjsOiykexCkIIFFdDpn/IfHn6fDCqXlLqzDr8ObD8TBar5mwfJarwGAGK50ucBYS+oOI9NExpWBC6cgrUKfgKZB+Q1/+C1lMamQ/BW8KeEEJBvQ2XGNsRPIpiuPVwjkGJEieNHSFv12H5gHkpeyHWlr1ISEi2l/LgDyZKbm84NVWE6XzVMW90AI+j7LwaNjp3DVPFL06Y1leb3CoiYNTpGkIujdxQN26COmjOg9rdcnDW2vd0F0rwbF5ROfAZ3XPSj84P3/HXpN4VYNby5ezvHeJhXouGZBLCHnPlD2pRTd12w6+IEP+yAYXPTwdKZ/YYZmHxLj7bYfT/Xa3yQxA6Oj2nYlNsiMLTqo8jCz5YM2CVnB90SdIbc5FkmmuvSl0Gt7Ehys2AX2VemO8bfoS5Dmadm/SnmIz9sPAScJK1FrWJuhhfvrLtdgZfo6vP1NWkqa6lfeDYVbgdIwie6r1X6JsokxrwQOwHXmYtQK8EyFcdwRy5xAKkK/qaUiJvPcELrENBK0Vt8VEtAV81vNfhzOhEwqkj1s+mH73rrt0gHaga7gRiUzKAQoiwCu4sXgQ44ecRPHO4xmrewTJIsHucsB6Ax9yFjh4E81SfOXaJw+LEfGBExxwUMGGgO6cCi5QU83r0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(32650700020)(14060799003)(35042699022)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X7lV8eGj8sTYnVZIB8ZtgEneZT25W+zchoj5DdLbCjJ/GHKsT4JmWSF0vOdYGnrDTj05BHyhnE/rhs00e39svHhtbRNjaudr6gEavXIj+GIZe7UvA2VtxsfQXCsTuf8wg8fVUfrCNMM0eAcKSBEz7cGO1PrPs3Se/1BAB4aOlY+r/dNLVbbBeCy3++jjy4fbDomy8JnuTeQWvpfaiRJ/mSkHcryJojrfjDYsosSkMvyHXBq9iuMg+WYJrGr3ISZfvEhh+pA9IznKPR5xiMT/sgrA0aBC1r02tsFgE6l5VRrhGc2vKnpDQmGLUXsRkOVWDJH5/+s2nJDIWjT5iQKCU6o7E9JFb0jOuGLBPzKvH8yU6T6pfmHklhr9GPD5f+zPyGvqpMzLIqpCkqdZVrqdEohdq++2t4EIqo7RrC92fbXnPRtDt9ENwu+MHy8UXOxQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:30:48.7141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380cecd4-8ddf-4653-0811-08deaf724729
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11007
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



On 09/05/2026 22:01, Francois Berder wrote:
> portname consists of dev->parent->name ("icssg0-eth",
> "icssg1-eth", or "ethernet") and dev->name is the port node
> name ("port@0" or "port@1").  Every board DTS in the repository
> produces a string that overflows the buffer:
> 
> "icssg1-eth-port@0"  17 chars + NUL = 18 bytes  (AM642 EVM, IoT2050)
> "ethernet-port@0"    15 chars + NUL = 16 bytes  (SR-SOM, phyboard)
> 
> This commits increases portname to 64 bytes and replaces sprintf
> by snprintf so that any future DT node name cannot overflow it
> regardless of length.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  drivers/net/ti/icssg_prueth.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
> index 12a162b9d68..4796d0d67cd 100644
> --- a/drivers/net/ti/icssg_prueth.c
> +++ b/drivers/net/ti/icssg_prueth.c
> @@ -496,14 +496,15 @@ static int prueth_port_probe(struct udevice *dev)
>  {
>  	struct prueth_priv *priv = dev_get_priv(dev);
>  	struct prueth *prueth;
> -	char portname[15];
> +	char portname[64];
>  	int ret;
>  
>  	priv->dev = dev;
>  	prueth = dev_get_priv(dev->parent);
>  	priv->prueth = prueth;
>  
> -	sprintf(portname, "%s-%s", dev->parent->name, dev->name);
> +	snprintf(portname, sizeof(portname), "%s-%s", dev->parent->name, dev->name);
> +	portname[sizeof(portname) - 1] = '\0';
>  
>  	device_set_name(dev, portname);
>  

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
