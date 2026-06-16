Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0725FCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF6A848A6;
	Tue, 16 Jun 2026 17:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PCR2zJ2q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PCR2zJ2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B4A848BF; Tue, 16 Jun 2026 17:24:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9FB848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aZ3UV+LXnRG2mDdS6Tpgt7uG+MHphm56x4Ha+5fnPE+5vkGmPz+evfBC8UghT2hcF3D0H7LJ+5VqeTu6M6Ub/kiyYNr2/m2enTBan9mFRYHDZnQQLsBptlKt/HbwImFdNVL+9q/iKt4rcpyZAUv4FHl6U9HjziYos8QeC8NwFgWAtk7Pr7CquWKt0tjfdYA9n9HBk4TtK1FplB0+DlF22CPUuye7PC3YMOYzI2MBGVHDSBBvOdLLJS41tXUmh++QpkqOnOuFpIWu0RBI1qRiGXQUmbLVomn7XoIk4fY8Ay3e0W9KSHb3jiesE5Iwihkpl9FRS2hypGaITDj4dMYCvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/GL0gZ71blYuKSIdr5UZqC5ECRiLQfY9XqdDcvOz8o=;
 b=V+IgPQ87havjqaJz7ogBocWsILm2yxsN5ikadeYppO8vhFswCsjuloCIMj9TYYhKUE9gAfeiQvGJxP4y4Rptyfpt3e/RkLshjIGv23ezM67Q14YeFBcT7FBiIIRD8qXWxPwmPpLh+GkqzysPlExKJuaNlbrx4Kqn9VayF9Xim8Vd8njGnhjYxOeRadvABtzaimI/djXz6XNGTc6BBRHTGFKdO/2gIH/yIB6RpXql8R4HMm5LOm4D9KODTIJh/BXxUQfGB83D3PTi+TGFdH0i7tuFdrxk4Z/VqgePkkHU0wC2RtRaLl1yqB5vUIGVX8HSrZrX+shQ3eADrjbznPfFTg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/GL0gZ71blYuKSIdr5UZqC5ECRiLQfY9XqdDcvOz8o=;
 b=PCR2zJ2qcjHoR6m0SU+NKh3/BXWFRooQ09+ZnDk2BlhheKRxYTZfBA1a98VRnCJis9pcBjjo4R8WMnWpDzKzbH3HGtpyTJfT7ODNi9QcILSeqdAM3a3jJ26HFmui93ghoDF3RJJZioXokyPGtP+YKITf2xDZnMxe7d0paOIJGXg=
Received: from DU2PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:10:3b::29)
 by PR3PR08MB5580.eurprd08.prod.outlook.com (2603:10a6:102:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:24:45 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::9a) by DU2PR04CA0024.outlook.office365.com
 (2603:10a6:10:3b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Tue, 16 Jun 2026 15:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQWg+eZ+xoN5xYmXZZDQUE089KIiomQNzxs4RmIiIDs1IR1MvW8CiYImmTEyudBIjtctMBJVMZeIcQRCDugDLpyFY8TICW2Vkw4aPr00Mwz5OnRVjob82xIUk/vp96xu1qybwDztMeJxbFmYanje6PW3Tf4NHddPBp3qF6WZQB2KOvZj21A9ze0FqkI3kQK3hpqnl60xYAfXA0mFLfQed1Gcz3BOpDGDoCkwc5E0W5b1OLtUJDPQLO4fu6SmIz7FXsUU8ft00TF4avW9uVnVmg7VomiwiCDzyDG1+pbMIFDsb3tFzD11Yypl+bMTmbXooX0ZdZgfPRrxq/dTP0+egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/GL0gZ71blYuKSIdr5UZqC5ECRiLQfY9XqdDcvOz8o=;
 b=aNqJmFPQPd/1gBFmU7PgEyu6dTArWqbLuiXF8+kBxAnEmfr+iP+yTs10Tc7MEnTpxx5Tp1nMwjJ+MjDLUVcsLseM/ROuJni25m38GCTlTSSys+8ChhbZtLZIDrNCc0WPxO5EMATGduFufVAmo4Z/aoYQzr9w7unJxYgklaso6jctCxELMeY6IgwnVqx2uxeZn7OtimmYWVb/B0nxtXJjC6y/pEoUWThN5nh5wZzruWxTPkS6RTuy+wIu28+JwpkY6rFoIVszVRQj0j9+Ef5W6KC14GK+PwIpuCTXVInFfW0OCPzp/BlgOxVArSSxmXMkEQwejrP4i+e2FyqUr22kpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/GL0gZ71blYuKSIdr5UZqC5ECRiLQfY9XqdDcvOz8o=;
 b=PCR2zJ2qcjHoR6m0SU+NKh3/BXWFRooQ09+ZnDk2BlhheKRxYTZfBA1a98VRnCJis9pcBjjo4R8WMnWpDzKzbH3HGtpyTJfT7ODNi9QcILSeqdAM3a3jJ26HFmui93ghoDF3RJJZioXokyPGtP+YKITf2xDZnMxe7d0paOIJGXg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB5411.eurprd08.prod.outlook.com
 (2603:10a6:208:181::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:23:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:23:41 +0000
Message-ID: <1b84ddce-4aee-43e9-a730-1b6f36cddd5c@arm.com>
Date: Tue, 16 Jun 2026 17:23:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] net: airoha_eth: fix mt7531 mdio related
 initialization bug
To: Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260616053845.2624481-1-mikhail.kshevetskiy@iopsys.eu>
 <20260616145431.GI382693@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260616145431.GI382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB5411:EE_|DB1PEPF000509FD:EE_|PR3PR08MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5d8055-d930-4153-9b73-08decbbb6548
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: JxpUYxRmQ7/Iz3oDRsEc71Sq0MjbhCTm7eo/fIrJpUKWIO2JUTRuCkKMVv8rpCpI3JrU0YeOlJZj4b2KEAz11uCdJ4nzBRsmnObTGqZF16DnBLtbEpOLv1BgqItUso/Vt8FUJbEMlBttME5i94XDSsLd4pGfgj5rn2MI2O++In3moPwAFZQe0Cd4Agb2BFtVSgBTxghX7E8DlGYwX9XocqODqNyBu3mzC/bte4uduVYO2xZ3pcz+mUWtsOfvcHIJCUKk/l2NI4mJVWJX79solZGkXyS5ZrIV+er1vWoFiju6I8gZLTtWqxBJ5deoKRNswJjRK3D1Y2JCuXpx159U8o4gIh1X1KBtztII0+j2RFYhf94BUqQNIYmwKmGRSmohEYdWxmUaJkHe0Rhu4cvXs5q/CIcOvpLVACBDGAp8TRZzqQ6eNOXNwHmCBBizbIYHzdgt/lV16O021qxLvAUBzJn/cV7e8JpJohZGLmpPqcKGBSwwQkl46EZbGrBD2ypAueFq99c0DVP1gQ0KMQwQABw3ioVHtPYmk31kMOQhxl2Sb/WMbFOhrnZWTNTq9G8YIISWxOMPfwz5gWMs8IIWHdfXbD4yCuXmUUMgQEE5Xvncw73eHm44t9VPXzMARlg6jez1yaDUWUY/lfkJzfWoRvv2+bd70LlOHvM5MXYeVxNuN43DKdnjC+efhBtNTaxY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jPg7rYXhBZqdkfWPgqitH1E/uR1QCdpR4InkvmJSc7vbhvK3A+ZxaIpr1B+RhMQmKLhVlYWLvvc3PbrxHg4HDOW9xn962N/JNWZQXJzYEQqUEhPUW5mjdjKjXep/BeU0qZwPfhJUJaQbiXF4gcmsH8M7RcdkunDMoNUTF7K9+PBEfQlfJCZ/gHWA/coi7BR+2MWJkSiV4hd5JnaOf/v3TLdnHEOr/egzkG7fCKEf7xGtmmOt8m+/O7tK1NdWIkV3Zf2bxnv8Zvug2K55RX1vfO0yDePcGJQkHXIzlQeccsiMjDX4nALoZPIzH9S/AlUGwxICIYsG+sienb73lPd9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5411
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: deea4d10-a92f-49e4-0c22-08decbbb3f28
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|14060799003|23010399003|82310400026|35042699022|56012099006|11063799006|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: tCgpCmhw+i+qbux7tZb3g7LP43RgwR8ZledF2y1nWxc7ic4y4dQfG/rOc12yD5mU4fvyr8T9MIj2POfS8ORrcoYXSwJTonRkj9YZ3pGhbaevnUSsKmslq/lMc2mYrHMtIxdPTmptp8lZ/T23NqWJiX7P3y/V+e2btKuqH8rmT8JOy+sB0WPganWp+N44Q8XqhgSlHFhdQjJZHiIlmekSgjZUXUk/R84fdCocZi6zJDXjRJFre631ShglpTY38k6Llm9oGkDcD9t2hLDz3S2eoij6841Y8xZJSsgJTJWLwigO4Qx/oXDHT8YT9nRmhL4TvR4ySp16dZ2xFhXL4P3Pu9WRUqGQisbfPvrzTYYxC/RF8lt83nbf+wiM//0+W5QlmEmI0Gf8lIMIfzZ0oJZvHkxQsEgzYHqzbmpKo95z3ANKxKtuwh89F2KKQisjSMveFkI3NqZ5JaGyTZRRmZTjq+CCanoKUHeddDWMaDvQ1w601CvjfWMH3PMA4YtHwiczrwK52WBaiKO4f45nXsYoXgAyRriS7JD2qlCQjp6A2o8dh4gLqplzW6wWJWeEz9HlgY7TyBBTB/kz5i0UHlXUUbUAgZgkcIUzmfS5aofUlJ9hzJA6qag8YKqqU3jdev/D1AuHuxRSOKosirg6FpIyZ0Id2ZN/SzZxxtvfq/7CWRn1uuxYD76dgFst7n6BcrzOXCFKfQbmvFURPxSdUI/fzIsBRcVLDquJdcYK9DCLaIg=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(14060799003)(23010399003)(82310400026)(35042699022)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qMckDShN0gbAICoxLB7dPS4iXNYBZBm2wxEAIu7HiXhPiwd2OWG2XUjpq/sX9SvFMVwi7szn7k+YI6Ik9b7QwR/80txiZ16CbrYn+3qW9117AjNF6Dxe4F4iuwd8Qt02ZwDXuQCi0bcdedpPV8Ej7sTVtzOespo45OaVsIuTRcKO3FQ95bY16je0/DHdx2OCMIajdttAvD+fYKfAAXcI+2sw02QlBgVAfvhx/4Jb3fHbDs9//qnlcI943DI661u0zqf4DEQiZM/3Xy8DNyaysdxOf9wRSGRGtETBHlgmSbPypOUpnd/ndb/zIDSgim5nTqjbOKxVeUNGL6V0vO//pdX3lZWtoin9CsLUTk46IkTf4FA5aKkHHQzxzzhyaAj2DskhQI+ZaZpxDVeZmkkVcVH+0pPSc2oZ89INCQb20Btsiq5lTwHStmv+SAJnrRcS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:24:45.0694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5d8055-d930-4153-9b73-08decbbb6548
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5580
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

On 16/06/2026 16:54, Tom Rini wrote:
> On Tue, Jun 16, 2026 at 08:38:45AM +0300, Mikhail Kshevetskiy wrote:
>> Private data isn't ready during bind time. The call of dev_get_priv()
>> function will return NULL. Thus we can't save mdio device pointer and
>> use it later during probe.
>>
>> To solve an issue, we will move mt7531 mdio device binding to the probing
>> function of 'airoha-eth' driver.
>>
>> All GDM ports (except of GDM1) are connected directly to their PHYs, so
>> corresponding mdio bus will be automatically probed during PHY setup.
>>
>> GDM1 ports differ from other GDM ports. It connected to the airoha switch
>> device. The mt7531 mdio bus is used to manage link state of airoha switch
>> device ports (LAN ports 1-4 corresponds to PHYs 0x09-0x0C). Therefore,
>> manual probing of mt7531 mdio bus is required to be able set/query states
>> of corresponding LAN ports.
>>
>> Fixes: 96d9e7c46425 ("net: airoha: use mt7531 mdio for GDM1")
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> This is fixing something introduced for the upcoming release, Jerome do
> you want to take it (or have feedback on it?) or should I? Thanks!

LGTM. I have it in my patchwork queue already so I'll take it. It will be
in my next PR to you for master.

Thanks!
-- 
Jerome

> 
>> ---
>> Changes v2:
>>  * small refactoring
>>
>> Changes v3:
>>  * Move mt7531 mdio bus initialization function before it's first usage.
>>  * Probe mt7531 mdio bus for GDM1 port, but not for other GDM port.
>>  * Add an explanation why mt7531 mdio bus must be probed for GDM1 only
>> ---
>>  drivers/net/airoha_eth.c | 78 ++++++++++++++++++++++++----------------
>>  1 file changed, 48 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
>> index 84ee9b2ad76..e5d39b95cc5 100644
>> --- a/drivers/net/airoha_eth.c
>> +++ b/drivers/net/airoha_eth.c
>> @@ -845,11 +845,45 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
>>  					    (ulong)eth, node, &gdm_dev);
>>  }
>>  
>> +static struct udevice *airoha_switch_mdio_init(struct udevice *dev)
>> +{
>> +	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
>> +	ofnode switch_node, mdio_node;
>> +	struct udevice *mdio_dev;
>> +	int ret;
>> +
>> +	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
>> +		return NULL;
>> +
>> +	switch_node = ofnode_by_compatible(ofnode_null(),
>> +					   data->switch_compatible);
>> +	if (!ofnode_valid(switch_node)) {
>> +		debug("Warning: missing airoha switch node\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	mdio_node = ofnode_find_subnode(switch_node, "mdio");
>> +	if (!ofnode_valid(mdio_node)) {
>> +		debug("Warning: missing airoha switch mdio subnode\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
>> +					 mdio_node, &mdio_dev);
>> +	if (ret) {
>> +		debug("Warning: failed to bind airoha switch mdio\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return mdio_dev;
>> +}
>> +
>>  static int airoha_eth_probe(struct udevice *dev)
>>  {
>>  	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
>>  	struct airoha_eth *eth = dev_get_priv(dev);
>>  	struct regmap *scu_regmap;
>> +	struct udevice *mdio_dev;
>>  	ofnode node;
>>  	int i, ret;
>>  
>> @@ -908,10 +942,10 @@ static int airoha_eth_probe(struct udevice *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (eth->switch_mdio_dev) {
>> -		if (!device_probe(eth->switch_mdio_dev))
>> -			debug("Warning: failed to probe airoha switch mdio\n");
>> -	}
>> +	/* Airoha switch mdio PHYs maybe used by several GDM devices */
>> +	mdio_dev = airoha_switch_mdio_init(dev);
>> +	if (!IS_ERR_OR_NULL(mdio_dev))
>> +		eth->switch_mdio_dev = mdio_dev;
>>  
>>  	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>>  		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
>> @@ -957,6 +991,16 @@ static int airoha_eth_port_probe(struct udevice *dev)
>>  #else
>>  		return -EINVAL;
>>  #endif
>> +	} else {
>> +		/*
>> +		 * GDM1 device connected to airoha switch. Probe airoha switch
>> +		 * mdio to be able set/query states of corresponding LAN ports.
>> +		 */
>> +		ret = device_probe(eth->switch_mdio_dev);
>> +		if (ret) {
>> +			debug("Warning: failed to probe airoha switch mdio\n");
>> +			eth->switch_mdio_dev = NULL;
>> +		}
>>  	}
>>  
>>  	return 0;
>> @@ -1202,38 +1246,12 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
>>  
>>  static int airoha_eth_bind(struct udevice *dev)
>>  {
>> -	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
>> -	struct airoha_eth *eth = dev_get_priv(dev);
>> -	ofnode switch_node, mdio_node;
>> -	int ret;
>> -
>>  	/*
>>  	 * Force Probe as we set the Main ETH driver as misc
>>  	 * to register multiple eth port for each GDM
>>  	 */
>>  	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>  
>> -	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
>> -		return 0;
>> -
>> -	switch_node = ofnode_by_compatible(ofnode_null(),
>> -					   data->switch_compatible);
>> -	if (!ofnode_valid(switch_node)) {
>> -		debug("Warning: missing switch node\n");
>> -		return 0;
>> -	}
>> -
>> -	mdio_node = ofnode_find_subnode(switch_node, "mdio");
>> -	if (!ofnode_valid(mdio_node)) {
>> -		debug("Warning: missing mdio node\n");
>> -		return 0;
>> -	}
>> -
>> -	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
>> -					 mdio_node, &eth->switch_mdio_dev);
>> -	if (ret)
>> -		debug("Warning: failed to bind mdio controller\n");
>> -
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.53.0
>>
> 

