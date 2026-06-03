Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0963CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F0D848B9;
	Wed,  3 Jun 2026 18:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nJX2xb6f";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nJX2xb6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7A58469D; Wed,  3 Jun 2026 18:16:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6349884881
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fyy2ilOiMYiy3dbCvTFZgSap88gY9nisJA5hkLMAv+1ib+1LpPCC67Bmwp8nSlkxHF7IHL1UivlkB8qo7UcpU2IZJxI+8rBaS2I9Mm53BzvldtB/Umr33vYaLHOnb0nBSyppC7hsBrj3bdQTOG3969sc31lF1qamUKzKFr537Zzd+TaXSzsF9KhwXvXrGVNvNDdKnrsLifsYBgmmLZP5VtLkgTMkwEwTbx2EVqgY5mUH+85GJ7y9b+r8M6+aybQUVOpHIKfcX9N6cu4KN2tYb0mN+I1dFxXiWQhLrLhnN4CngMWPnSWGQprCGYJqkJrA2pwFTtk18bY5irVJgheIqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFthHjcfHQt5TdADs7UNhtuNkI5vl98X1T+eHCALsyM=;
 b=NtBx0hrLbr9Haml6wFgAU2iH4pAlRzZorP99TSQzx5P+Q2ejt+F2nJotiaxIUCfQMrah1d1GBTQOA5V4ECRhsf7JOC2Ox2ZhJr2R0e0fdTthL7ILDPYxNzVA9Q+39jHQXLVVWC037Zb5jGGuYJX+drkl/1Yw61K6eIqxQa2HzFKtcf83XCeIQ1/mAg4hjmXLpVUlITTfP7vscu3UKWe+lSZCi2MM+s0QVt+5yNdbe1aiOcC8p9npqCVfuOn+rEPdoV2ACZnPZ2yDy3BXesAz3BNknWZmQMS8NFth0RwQECR1TXVk/AGUMfFOOKLitfaaRb2x2i6fal4Qd3VnPy3Ipg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFthHjcfHQt5TdADs7UNhtuNkI5vl98X1T+eHCALsyM=;
 b=nJX2xb6fub5vsN97BE93QDMkoCjeKNH1GyVqaqMUTbZ6Ojfp+hlkNtZTpkI+4ld5vqh+tftq4UBE8XiIDKDhWGc6x2XuQw+lkzHqcL0AucELUHsgKvJE+7toiBmE1EJCGycEvNECtvqxsqTdhmUxJH+TuriGMCYTLLYJudqvJIU=
Received: from AS9PR06CA0479.eurprd06.prod.outlook.com (2603:10a6:20b:49a::28)
 by AS8PR08MB6037.eurprd08.prod.outlook.com (2603:10a6:20b:29a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 3 Jun 2026
 16:16:28 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:49a:cafe::14) by AS9PR06CA0479.outlook.office365.com
 (2603:10a6:20b:49a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 16:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNQiOUPSM+H1g3aSrEBq5xFccTpi/6II8RNppecd4+NmVlbcBGa4p9PXDs3QpZWl9Y1PBySY98yUOLXfU18FLre3HLXMdPT8h5jl9Unw9ZPtaSFRJP+assxTNPgMexrYetFE0K/Vx3XWLEjJWzLeeF29tdu81xh4dnLXGPgDTWW8MgkoD5cr6HxslzI3q1wE8nIgQfhUW4iljhLSpir9By2USvOTYYFcvmHHH24x5obxixYuXRz7JEzIDzrM+aFjS0cyppyaamt335JCKPArlflnRbQBwg3tvCHn1L3J05i646mCWX+2kX+9pTb9KDjBRsTzm8sVh8BfpKoCg3/c0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFthHjcfHQt5TdADs7UNhtuNkI5vl98X1T+eHCALsyM=;
 b=bDRy+Xj20miTYK5Kf9ZCGFtILvmOPSYFJzD5bvRUfcychx7anMA56p54BK5sj4idH5RqS5BvlfTo7eUJtwmOiu3DcYoD2I8esBgQ6eSuacumyvHv45ZSt9W46Lu8b67566vqVANAZ4kP78PEzQIe6WrNT8JbkbyuB1mAOjFS98aUoIVhHRivZOrtuV0lrZW+wX+pAHVnmQPV9e9K7i03wsiaJuE34NS9MUjZA++mhw++Z2+nJRcRubF7K2pMpY1xokhiIDwj2mstMf8RvsI0V4r5ChvCo9QyUoZBXCQOXwKO9XP3YJssvXJdj3rillRxaOYxH9dHxZ8SxMM4Ld0haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFthHjcfHQt5TdADs7UNhtuNkI5vl98X1T+eHCALsyM=;
 b=nJX2xb6fub5vsN97BE93QDMkoCjeKNH1GyVqaqMUTbZ6Ojfp+hlkNtZTpkI+4ld5vqh+tftq4UBE8XiIDKDhWGc6x2XuQw+lkzHqcL0AucELUHsgKvJE+7toiBmE1EJCGycEvNECtvqxsqTdhmUxJH+TuriGMCYTLLYJudqvJIU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by PAWPR08MB10240.eurprd08.prod.outlook.com
 (2603:10a6:102:366::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:15:17 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 16:15:16 +0000
Message-ID: <7fbf606a-1c83-48e1-8402-04568b1761ed@arm.com>
Date: Wed, 3 Jun 2026 18:15:15 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-next-20260603
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|PAWPR08MB10240:EE_|AM3PEPF0000A796:EE_|AS8PR08MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 364e55e1-c097-4898-df5a-08dec18b778a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: pZJjGRMDOrnv29z1s/SmxAsDKZZ64mIEqzqsbr/vzUV6DQ0i8Fa2goi/B3pi6pZYM41omLiHvh+ud1CZIsqxLbY/H48oTy9SfhiBkzv3V9bWY4BBD9G2INfeFvEy4gNsyAhQV7cRgQ6NzFB4NvpIZYXozr5TdTF7VA7Wxbz2FCBevDyTfGEzrN4rbg04XNllkT9n01vO7lDC7meAhki7Xw8L7LIOIc0FZUTYhzOdPHmpGwz73teaKOe2hY4miP4UXcuDOXd49GvqTtMh7h5xJ6fNLOK80vdRt5gvIoVH3mY9Vcc/gZT45K69GG+7Io/ty4cUeDtAxI4RkxwOPn50jNMjI2b25VsQeP34zEY7L43nxS1fiy2U5S+AH7D8WXYwuCHmIY5qSJnQKIaZpaMP8mFHGzHEEhZQNZvSg9Z3bFcEQJfBk6iDo/b+2F9ElSzSJcASmAeWvRE6i7SQKwZ36Z0Do0mUF5aw+C4D2BJbvHTtANkxXMxrWxGD0FDWWKlMLpBFIPAbdUMySGXnRQy2GL/uVNkAuhiEywN0bCwPLFPDctBuyv1RGY+/a/sDJ/wYiFvbF2ZyERc2so5nwMBuPCiw8gw55sMLsqnsFW3Ib+HIVijJ9KWLeAcqbqab4XslWCLL4sX0gITHrZYYwiHfLw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oGu1PSmMpO+FAWtmEjmELdUWohPt9iQjZgrnhr5yJmPXAMnTiAQwsEqMcpJbvS1uqx2lQYdi5epVSKaOpxc9+HC8/1SJ+g6wpqN/MU6F/3bE+88v5TeMfaAdXNZ/6C05lwbcqHtLDuVe8P5CmZHZvLJpPU11IxbnDJvEc0Ne9U2vnDsIPctokben2evRhRLK0FbwHjjh7Eeo+8wKJlx+BP++jU27Ii0q7LA+iUciH6Wxpi9kolW0n76R+KgY93urtw8/aB5RCNKlUh0gsPMfZLmYJEfKg6qTnkze3TrhDoaVG4bDr7b5mFupUgCknYRGcBv7Lp5J42RLifjljIyv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67c74974-a7a6-4971-8ac8-08dec18b4cbb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|35042699022|36860700016|14060799003|6133799003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: uENUpy/aMZranHhV3CjKRHT148iUlofyXtgQeayeg/+feOvbHKsGBW44VhLB+nb/Y3zgEo1pZCOWZzVLKoXl6DcN2la72k/RWGwxJX/xLt7FOSfQ8sy5xuQGxEbDOMOqLScMnHq7i94/5sb6y8qBBJJ72jVIDu3VpQmpzf2xHJwphBAvcErHeFNaxGU5U/bcVK9rJOZ1z6AgsSyH59hpjpWhFPFJqVpGDRgSlX1U/7KP/bFk+yRMo6DH+4gry5LjeAHwoeLy3PoCuU1roOTBuYvklOtS/kQBsZ51SBNZQYYz/r8OPKIHxbfqL36noZ3AB+l6EkQvdqpZH0TmU0lwm05vVLmVhXq0EKzWrRwgzU5e1WkVOEkKMjpBu2+eCHgI9cPKzSC5k9WLDDkLxy8KXA/2c0jjCLUwmcCQu1z77TJ7f6S187b6KaBboUzJfpQt24vMCOEef4EeWNgz9ZBZpCjXA3XcHEV7CZ3a27NWeQe5OY/pBXqqRaYPmTaWdg7927ugyBS8HYEr5EtVJ1KY4q0DD0TqLwIodSxhCJ36wsuv9nQowQBq3a75JlnxqQ6R2TSLwejbDTVGevk3YObMMJl5JxB+R2SdKP0YKeyCRHdlGhZRLbMu9c/Iy/Pc9wzQRXm4latHQxbcuvSf4vFvBzoYdZ6OMOju6FPeEt+x6ITBrYNapFNYFoSbsWEl9R6G
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(36860700016)(14060799003)(6133799003)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bwhQCFOuo/paEhfyCk9+UHr2LiRPWMs6lGKEG1rH0BdMB0EAKQebq4jd5Pq2FAUPEShmNLiYpRnjvGXi5axv2l0dJFU5pLbRG+GvSslck/aLbCVQN1nRUbPcues8zblOdTLhnA/GT2QxQY6qMkTMdJjPtoAWFiGcqLomJJTxF/neUWBipOj7EZ2HIR/O1z7ileEeuyl9lbX/n9ptR/nG8SIjzI/5J2TUsqMNryU+fU4WXBaHf2e4D04z/KIvoTRTZieY+doFQXnzpwhRFdopZ8y3QZo7Yycng4indRu7aHtDi4AEuYMH8fQmrVX9InK3DPyxEPnYfFuWvYGPM2uuIKinr04dsVVWIV6oel4fhUFFTh3fmYNSkpVQj5GeKzdIe38peW2KCg3mPgA8ZPPYEx0jbgnezDDn91GUJoY2IkgNxIQA9TZeeF8/UfNpcg9i
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:16:28.2972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e55e1-c097-4898-df5a-08dec18b778a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6037
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

Hi Tom,

The following changes since commit 4674475760d293d6cca07c2f85ef48029e08078b:

  Merge patch series "Enable splashscreen functionality on AM62X" (2026-06-02 13:49:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20260603

for you to fetch changes up to dafa6a36037b516bed3c4f578c69e0c5c8017acb:

  net: mvpp2: convert FDT access to ofnode API (2026-06-03 16:55:55 +0200)

----------------------------------------------------------------
Pull request net-next-20260603

- eth, phy: Convert several drivers to use the dev APIs
- Guard SYS_RX_ETH_BUFFER with NET
- phy: Kconfig: use bool instead of tristate

----------------------------------------------------------------
David Lechner (1):
      phy: Kconfig: use bool instead of tristate

Peng Fan (9):
      phy: ti-pipe3: Use device API for DT parsing
      phy: marvell: comphy: Use dev_read_addr_index_ptr()
      phy: cadence: Use device API
      net: ethoc: Use dev_read_addr_index()
      net: qe: dm_qe_uec: Use dev_read_addr()
      net: calxedaxgmac: Use dev_read_addr()
      net: dc2114x: Use dev_remap_addr()
      net: mvpp2: Use dev_read_addr_index_ptr()
      net: mvpp2: convert FDT access to ofnode API

Quentin Schulz (5):
      ls1028a: only include drivers/net/fsl_enetc.h when driver is compiled
      arm: ls102xa: use platform data to check Ethernet interface is not SGMII
      net: tsec: make tsec_private a private structure
      net: guard SYS_RX_ETH_BUFFER with NET
      net: SYS_RX_ETH_BUFFER defaults to 8 when CONFIG_FSL_ENETC=y

 arch/arm/cpu/armv7/ls102xa/fdt.c          |  7 +++----
 board/nxp/ls1028a/ls1028a.c               |  2 ++
 drivers/net/calxedaxgmac.c                |  2 +-
 drivers/net/dc2114x.c                     |  2 +-
 drivers/net/ethoc.c                       |  2 +-
 drivers/net/mvpp2.c                       | 56 +++++++++++++++++++++++++-------------------------------
 drivers/net/qe/dm_qe_uec.c                |  2 +-
 drivers/net/tsec.c                        | 17 +++++++++++++++++
 drivers/phy/Kconfig                       | 14 +++++++-------
 drivers/phy/cadence/Kconfig               |  4 ++--
 drivers/phy/cadence/phy-cadence-sierra.c  |  4 ++--
 drivers/phy/cadence/phy-cadence-torrent.c |  8 ++++----
 drivers/phy/marvell/comphy_core.c         |  4 ++--
 drivers/phy/qcom/Kconfig                  | 16 ++++++++--------
 drivers/phy/renesas/Kconfig               |  6 +++---
 drivers/phy/rockchip/Kconfig              |  2 +-
 drivers/phy/ti-pipe3-phy.c                | 23 ++++++++++++++---------
 drivers/phy/ti/Kconfig                    |  2 +-
 include/net-common.h                      |  4 ++++
 include/tsec.h                            | 17 -----------------
 net/Kconfig                               | 21 ++++++++++++---------
 21 files changed, 111 insertions(+), 104 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/30328

Thanks,
-- 
Jerome

