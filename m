Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2CECA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE8A8329F;
	Thu, 11 Sep 2025 07:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Iwvew1Cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55A9832DA; Thu, 11 Sep 2025 07:12:31 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF158319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kadgj/Huvcw2jzIsUZ1MBIO4ybBwGWueDkCTPyLW1WZWixx4VV7w5WGIAHf8Txn9mkrSfS8JnZR4D2W8r10l4f+WgIJ9q3cJixQ58x//R6djh+m6N1f+VTD2k00mAKNpByJ7aFcQ/HoEnIfgz7nqnnCDkYs1551HdV2YT3wDrgFMCygm+u/y51jzWmAqqCO0lzOYPp7qzx88Y1sndO2W4H318JICTQ3XQAQqJNFD/7k+bvSry5vCFl63SlloKZQt6xyN/1fVA0BiwGt1/u5Ot5uZillGOOTj3P8ZhjFtfCHgK6Qzeg7IiEr68M9YAmYAS8R71cCWODyAbdllAapsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lsAXTw+ZWIbems2+/N40WVjHC8J2BCaN6QktbZeUEo=;
 b=YXv0Zb1PvCN47KeXiYnXD29ybxZJCgSvppvXXcspH7yrIfCdwT+DMOO5KGahqkdIZU0q2fwtp1xfzzF7JMk8CFs7Il3TDfk4Fi+Hwgc0bHw98Bl6Q7u9KmlMrLSyK2JmWOVFXBF35EA1q+oMUkvEiktCj0VVk6lOFdbGnxoruNw/VE521PkRlXGLELYMr9QEp5flIiRLbpHJc1F3wDkWdgsnHn/xHVvog+99WpbnYneH7DdyS7sdlW6l2XMoIdktJDjlV0IfaUKzGAubGIPMVjcwXo58BIFN+rfR1gVfOIwqePE8IIhKLttJyY22Sa0T0JOX81JOqmtw362mB5d9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lsAXTw+ZWIbems2+/N40WVjHC8J2BCaN6QktbZeUEo=;
 b=Iwvew1CmNxxF8VJ2hlo1NTWNVXfrPBqk+zXBL2EN4Cknqr2Sv5EKPqcssxNiPv+/SAY2EpKVDOfQ/l+JvcUgILpRVsPqLwIMJi1oy12GXmxWgwQBqhl9IzmzhfdciSGS7+erWimulMU9UlrAUUeaBy3fMfRqp8mAbmFgsnPAZZOk9Bwe7kjwUEm4+ruEXMz9Ss93tgfNTQzJZr40/wTvLUtVKYL8Mt/lgSv6p9aslsB5kbJTHrVDd1/dwIPblGcVRoKsKRWCX9xNYRDJYyT8K6e5AfNgjHRcXAxJM/h1Gw74eXlLSEqQQdtIC/Geb+HkjBzldM+AMdpex7vhif77xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:12:27 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:12:26 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 0/4] Enable USB 3.1 for Agilex5 SoCFPGA
Date: Wed, 10 Sep 2025 22:12:03 -0700
Message-Id: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: cf28b26b-55f7-445b-4622-08ddf0f1cc55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sVumcBUBEHDd5T8E1tWGAiSnWzilcgNx4fhs23dWJC5lv0tRVDmxqF2mXhHw?=
 =?us-ascii?Q?YuC9SKb7wX1Hw8GNhXTMm+fxgqnNXhdIXDTVDmih44vntAb4bq4UPG93q/Bz?=
 =?us-ascii?Q?PKwYaaH4Ra4FIHpYgnep4XWqD1UhmgS8af11wJBY3k1PVyTOeXiIZUHTlgmm?=
 =?us-ascii?Q?3hT6MUOK+xTQnlM4+3sxB26tBB1y8HTc2ElTkowuyZkorzNlHLdy/Nba7mZM?=
 =?us-ascii?Q?OomF/25tJ0RCH3OWKpm1LUv0WPDDYd+x9/NqPxd0tKIxHJOi8W+dtIWRmu6v?=
 =?us-ascii?Q?djze6YtKKiVCwoZstd8FvK8TZUsrjMoIOiH9irpYhWmb8fa5FikIpiQl9t0h?=
 =?us-ascii?Q?POHL/XzCFi/BYd9UI95SK/LlciraxhS+vSdpbRZsAsMq9DQEUi6qAoewYmv7?=
 =?us-ascii?Q?zArtDy6HA/PPrMt0ZVIJGPvlJV19Ls8W2aHq1OU2jkZFOjWZ7+E/H4HGDEpI?=
 =?us-ascii?Q?3n4PcjVHRe+DR0XX8N/tF9RPtHjE/rN+bDM1hgkWywmcOE7CfVZOat13iwl8?=
 =?us-ascii?Q?5hxjNZMaIUPjvWTtxj3LtaB6/udY0R9LDsumaBEInDm+5VsNRkWm6w7T7JXm?=
 =?us-ascii?Q?9H3cUEbZLUQxizNzJa5dxgZpg8sNi32ID6OlOwPZYi4RoObUrfaOfQdYuy6l?=
 =?us-ascii?Q?7CtwG0t8dK2jsvEGD+urUzF4IuiScOI+LEL0ntRQ+/dkjB8sXPBkf+iNg0q0?=
 =?us-ascii?Q?Lhj8GJ71L7AhSO+iJ/s1CrEr/JIZXZNN1x+Pd6CnW6cTGnqJfMCDt6vGHUKa?=
 =?us-ascii?Q?AXAYw5ZSCLVDiEnmkiJd60xLARJo1ByBjftTPaBWAaT+I5kOMXZK5wB8E2ot?=
 =?us-ascii?Q?he7cz8+DaB4QPxI1FV7UKpev5Iaem/FAp5tawhJo8XSSoDSDXjeXAhdUIJis?=
 =?us-ascii?Q?UpbbuM+4txH7baTO7XHC+r/RwuHUBqBr/AZ/psbP8gGXiaBwGHdpYh6mpZeP?=
 =?us-ascii?Q?UiIzcnS9ez3Cz0Hg9VNDHGObl8wKgZPI+2FNdR36QL1SYB7orlTTTwtlWP64?=
 =?us-ascii?Q?SbhR8gkQLqc1YhlEUJUHwcSNrdNgp+AwMXTIyAOO8yx9sGQgbruydw+CTsK4?=
 =?us-ascii?Q?smY+byqTRfJAQ9UC7MAzlUnxQPydWoT+HlKgU7j8I/xZ4HKPnKj31GzyQak0?=
 =?us-ascii?Q?WkPz2Y0b++OlmqfWMNPFdMDYEfWxKVQ0y7fiyd9CeIfK6PuUPMD9NMUP/U06?=
 =?us-ascii?Q?lWgBxC1HU98kJ+ST9PgaBiaLjcu7B+4EDzwaONsfnYf7ExBwahKsTApmX4OB?=
 =?us-ascii?Q?vS5NZhblfDlC2Iym+ojSZ6s8C3VRgfpwLwzAASTz+bBWzjXRDyIRUfJUByB6?=
 =?us-ascii?Q?bWRJv75DayTltKve2d2P7R4MDKqy9UUcvVKSsufsFkAOoMhSnPx+Bwr+MSuU?=
 =?us-ascii?Q?RElpdjI5/asUwkgW7toMqgTB/i6TKUWb6EZBkQRBN9qtvn05192jh8vgvNoK?=
 =?us-ascii?Q?n2XfhTqkvAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SeBMcSAOsaeDH6G+eKF/9oydaNHmUXaxuTr+aDhCslo1JTioUmp9GKR3gfWP?=
 =?us-ascii?Q?ZX73XvixTg5Nxp2cQtac9nTt9c0oUtip4pUOW0iBRvy/60QvjaFju+Jn1adz?=
 =?us-ascii?Q?u4aiKPkA4TPMQyCY4nruYt428jQi+wkL9mlPW61Y/tz3KHgbzoxzfql5mT+4?=
 =?us-ascii?Q?F3MKWIdoFghpGh1YJJDSmEGVrD7kPZmRnNB9rCiu/FhvR9unq+V/d3OYYbp4?=
 =?us-ascii?Q?ZtnY8uyuQ73ILtEAQBTt4+uHBf7jYCYQOqXaNTzIbOdpAkJ/SJi3i1+vy3RI?=
 =?us-ascii?Q?0VLAEQyqAqlywVAfgHpMEc+yjrJlSLX91FNZQ3LgVhHAOaOanVGYktTKEJs8?=
 =?us-ascii?Q?O7Afygt5jP8lc6IgjbOtJZ08eZLK2fkvoO4KWiP7Y31wny5aT3SLfyTE4nYw?=
 =?us-ascii?Q?0gwd3FLL14YHsANmLYDLD3PCl/ED92ZTwd8SCyuNQ9WR6o5sGHawottJ2nMn?=
 =?us-ascii?Q?Yv6JuTx0XpCumjB7wVjY/iPEzL96tc936kGei0DqD8A/ye/SgbnAorG2njic?=
 =?us-ascii?Q?veCcbEInD2l4bNm0TGdU6xJ6aCqGlDOweIWQeq4ViVzYVbvvo1frStXSwfxU?=
 =?us-ascii?Q?nStY14ApTo1ZGAXxXPQIk5U4+MhbkKIfAqDrumDYOt6K6b/J+eLu2VdoeFwA?=
 =?us-ascii?Q?bs37N1z96Vb3iHdgcPy6UzXDeoXyW8QmZdheex7IIgso1xDOUIkwT7fX9OcJ?=
 =?us-ascii?Q?r5omjOUcDWCvWgqZtVGYaa0Qqf21606VPSLef8jlHnKhvPk/bPkJicmM2+ym?=
 =?us-ascii?Q?X9fxamzCk4V0ID0cHW4ps/QpM9TLNozvl74pwgmXxe5QOrK4zd2VqUK1fH9k?=
 =?us-ascii?Q?tmE8tQG+tqgsfVJJVqWI2LtpRzVtJYQpg8/SaGkK5YdXzo//L5Kp8ECq1ZRA?=
 =?us-ascii?Q?uFfdIRJaHnZJahMhZhtt3mTmNiEWzR47khRNI3UyLXc4JKpGljzmG3WvDQ94?=
 =?us-ascii?Q?VINygNsVlcXMNeptuMz+HEanObBQGiZ8TdFTiCgDmDc0ZPHmAloyCBXoX1Ww?=
 =?us-ascii?Q?5XbnZ9BJHDs+dlz4g7vc6Y3pypeku/NHGrNUxgom3qrsxPYOoTj3Y6LUiIaw?=
 =?us-ascii?Q?RSaEf0U8gG8B/49Vas3eFErfiHOtxMkq7vSK+xd588WAOzcQaiepZT5hbdGM?=
 =?us-ascii?Q?yAMFVD3+2c1SSA8l21kUbcNcXuxag3dxbquRi8koxwrOLlvwRM1zwZslvg+5?=
 =?us-ascii?Q?SvyOGlNNLbFeh7KYzJVVeBSFBBbjlyspBqEr9w8JDjRznzqhgH5BbKRdv0UX?=
 =?us-ascii?Q?VTkCgzExYtzdJ9jVF+rAf5cfWvTk8aKDq8cuNrPTAtSmHgCNzXyhp16EPUGN?=
 =?us-ascii?Q?cd/71oHJzlthX8hIMl2TR10XJhlZRSoRVHhoIVdEU1zfs3wJeqXrPbGONQ01?=
 =?us-ascii?Q?eNCxH/5HNI4Ofi5UvEWZOF9Ge8VchFYY8WEUYgtKV/G8z/acFUKvD+wPRKlH?=
 =?us-ascii?Q?IBe7bqRpQb834qCAQKbqZG/xll/xQSqFJBxbh+h1eGx21RwgJU3MiD0knCgy?=
 =?us-ascii?Q?Fz0YOlJ9gqwvIfsDqlofahFgtBlzAj8U8LDqLKvmzReMnFe0ddHAnZJvFTpH?=
 =?us-ascii?Q?G+nZeQRLgJdlLoeZease/QHghA05nmbaTbwmD27w696vpxBDHcdgJEi850bG?=
 =?us-ascii?Q?HIj/42vUqqTRQrcr2m2EMQk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf28b26b-55f7-445b-4622-08ddf0f1cc55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:12:26.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iNg0UPumK3dlGPkLV9fclUYkqYUrnNK4DM7QtZ3KTgaM0qUfY3wk4U4RKpC2Et8aqSMkuXnF0sf0OVb6/7jLFT5Y+G59yTyXHwUZnOG1djb4N+GSQvnGjm2Psa6zBNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

Required configurations for USB 3.1 are enabled for Agilex5
boards. Testing has been successfully carried out on Agilex5
devkits.

Changes in v3:
- Changed commit message to state debounce issue explicitly

Naresh Kumar Ravulapalli (4):
  arch: arm: dts: Enable USB3.1 for Agilex5
  configs: Enable USB DWC3 host drivers for Agilex5
  configs: Increase USB Hub debounce timeout in Agilex5
  arch: arm: socfpga: Configure USB3 System Manager registers

 arch/arm/dts/socfpga_agilex5_socdk.dts        |  5 ++++
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  3 +++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.35.3

