Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB08C07E8E
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA78C88DEF;
	Wed, 24 Apr 2024 09:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Z69iO0WT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8493D87E96; Wed, 24 Apr 2024 09:43:55 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0704.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C9388DE8
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfan2EvI23RceyKl1Cpk2Qu4dCmmr3nAZvEd0Eh6eYGlzRhYYUrhW+XyHrCMCCCkw1V7AzxNO5la0G9oOvIhKfOfnAxgLYyq9jdZIbbWHpMl9noCPT0LFfhVWCSSzbXxMIlZCj6r5b2J9s0OeOZr/WK8wFTsajvS5VS3PBygJaJhFh6J19T1nB5FmvELJujRpVp39p1eptX5xkf6pmLOvCDS5oZALBVhHnoPTMzjLQGGQoH0Hd1WwxRjrU90CBTUGpk4e9C27fhyyi845lQ8gPur36eo1G43+u29ZIaCgBRZDajgj1CiO4S72uJFQDpb5sg+gWDD9tLz93hbbOzZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20EkQrbK13z+sww87qlkwQLBu2L6OYSpfYoydXjTnVg=;
 b=E2PMhTg2vvFko2cza1JM/vxEroQ8kip9XcPzxEf08wQWO85dm/auTAAlsVZRr+d3KocIZesKgf4LI3YY63ny88/1Wj/HgFmQ14nJHQAp3CRo3F+EM1YSbKNKpuorHJuMwxKmEHox8jU7GQCXQaHvmEsD+2phl4hrnu1dBU7WPqvaaDKt1xDOnXP3clm0SMDtyQFY8JrWOSV9Fn34eScBBs/RsjQXRRhN4Bv7XpTAsL5K1+nwXSEAB9te+/X5BYXNjsJhZvrTQkziDteFMehON3LCs+iVDN4V4aD2oMBm9fjpLebgMg6FwOT+xSKn1NdC5YhH8cAfDF0YIhevSWLphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20EkQrbK13z+sww87qlkwQLBu2L6OYSpfYoydXjTnVg=;
 b=Z69iO0WTqXMqVuM6a6vjdifIdM0bBxUVOYxmuxpzc/PrdC/MHrGnPxc6gVvD3Y+fTmQ2Lf72jzkUS8bOSOAcylwpKZLyyHlhaoX3uCUWheG1aRqhpf8uTG8Uw0sKOK64gKuWQ3Va9Wm8QCRGW731O9SzGrmhKm9uqrh5GOznnyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5844.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:43:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:43:49 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Green Wan <green.wan@sifive.com>, Leo <ycliang@andestech.com>,
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tom Rini <trini@konsulko.com>,
 Vincent Chen <vincent.chen@sifive.com>, Zong Li <zong.li@sifve.com>
Subject: [PATCH v3 1/2] board: sifive: Rename spl_soc_init() to spl_dram_init()
Date: Wed, 24 Apr 2024 09:43:38 +0200
Message-Id: <20240424074339.210851-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0133f9-9404-49bb-aed1-08dc643247af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bwpUqDIHh8BZh98gD6qe3FbU5OjxoUW8Hg22FExxGDZHeGTyrNQx4bFXlI0o?=
 =?us-ascii?Q?gr0duCmHDeSEi03B2oL5+3MtkCWUr1RF+H8ZJHNrPZIV2TqZ7HaVC3Tv88TU?=
 =?us-ascii?Q?eG8kqgwYHxF70qarrADFvzU+RFfGkrYJNg8Iij095BkFPLm6JjJO0anactM/?=
 =?us-ascii?Q?P2qyaY+OrgAkZpruUM/lKUjE7AdFYd2MWgVgYZvqpdzPRK/CR8dpfBW44q+/?=
 =?us-ascii?Q?Uuaaii8n8ldsKGLNMAXMAOaJqSy1qQitDD7LwjtkKISJvfldmdv3CXhgjSCs?=
 =?us-ascii?Q?DviXx1alyJcKSSTPaKkGbDVlNwqvIX59NgBOCu6Uw0zCpX9z5vUp8tfDYuBk?=
 =?us-ascii?Q?Fe/ttlPhg8F3eQHFZl/p0lUuMtqSNF0Uf8eLbIVDKp5ckJTgDz0AsaKq5xSU?=
 =?us-ascii?Q?7XcgrYwbrI6nVWaqdKhxR70ljjh4orHYWy4UYO6LPcUAVB96H3xD62TrK2Ih?=
 =?us-ascii?Q?/+49ttvrdW905aYoRMhdXgA4/WE9xI2SFPLwxHamC1IceRahlyP3Qa8L4gxB?=
 =?us-ascii?Q?2P0p99dOquTd77tzD3+tFwizAPcsKKt9IUYOpyTbABS7HizU69mfVhK7pl3C?=
 =?us-ascii?Q?6wBs3km655rkSKeEp1s9EZij4ETYS5b8v17py67EMrmDWtbbao5ChiPeiCBT?=
 =?us-ascii?Q?odx7lC2ScyfQCEBqS2JgrzLuXv61Cl9PIf/LkNf7ctGLXIp0ljdJT+ZLo4AB?=
 =?us-ascii?Q?QLWhzNgN5edZlpLgi2ccP6zcuYE4uirVrKjdO2D8V7oY3UfBEGh4OXTmvl7y?=
 =?us-ascii?Q?1oer4ExZNj4dZaVtr8sEBMaWFQPKkpn8nHQPvNZPFATX0GSbZtkCjtn+M+cH?=
 =?us-ascii?Q?yMmKreoOMopqJhwIGGOpikmrXp0KzvnyVQSs7VE07TVm4rRzdx2RcZSzKvgS?=
 =?us-ascii?Q?E2GVoPGTmjRpe0Brn5OQbJZQPqpjH0QNMUqXpkHeVd79YDMOufoHC8320M/M?=
 =?us-ascii?Q?TZR5VvIMPQtcQDjmflAumzxKfv6xlaGTovJcLaI6J7duQvsiReZIcWM+lVlZ?=
 =?us-ascii?Q?MO0lwNHA5U4XcQ2hr1CjEavKmValux9W3KQd0DNxr2+FSkvCPchJsa9w+LHN?=
 =?us-ascii?Q?lR/BFYU4Y/FyrvJ0xRYyoDNYMwUQHAa2Klv6+PXqH3tLQ1wfTzO4zzu52Azt?=
 =?us-ascii?Q?NK2z2Y20oEYyKIn97yF+zdFVHD+5yx6oPlVXbqjW8RMkB6/2/Ca+o+sZQ7Hp?=
 =?us-ascii?Q?G8VOLk2e/Mp/vWiELb2Bdc7q4WQNS/aD8h5f5qq+Rd1BP3QSNJl6SYCvEiIN?=
 =?us-ascii?Q?jlhofD+2Q8BbAOcZmOWZEK0QyVuRQi4LuG62NnyfZagzllWuZn+XASiVPqr0?=
 =?us-ascii?Q?5GUFmvndJMgDNK8BMyBmYu8HkBhvRYelseiq2T+1s/Mj0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2jgwkkHGfEhcX167V1FuLsWksjJN+EeP0bZqLw/hKjQHuxiiNgaLBU4A+fD?=
 =?us-ascii?Q?Dzh7ilyc7BOsN0RWhrMR7CDku27D2SC4BlPypHJRZdx4SeFkJAP4jzx3fkNt?=
 =?us-ascii?Q?jDbIxKnwoKg0Sdqc9zX5VnINDgnVu9wuflCjLZkHrej8GLLTLPbOTjV/hQ/8?=
 =?us-ascii?Q?IwDuBwjajDQCadH8mcTbbgU63Bwhgmtp0984X3bVZi8Q53mWOxwLrmj6olHu?=
 =?us-ascii?Q?WCAV/567fVkFjtFhhfqXSPXYJAY0VZRfOacf/07Ob7nvLIz/XkvLzMOBcLNZ?=
 =?us-ascii?Q?Sn+jJmILfdKyomI3IX8BhQhzIvDugBXxStneLfUnbslBLIAXtfwS+Fc4VRru?=
 =?us-ascii?Q?8oaBKfqbMvV4eUdHE0N8sRFVpV2pRxdAhMerhTbTO21pXDWsdsqpjLqxQgNy?=
 =?us-ascii?Q?ykEEtoXsESrfm8L8uV50kiAKmD/QlEikAis7D5A1LLFo6v09MK63P8amOA6X?=
 =?us-ascii?Q?Bmj7WWsEBETiZrzsyTiSA0/b9Gwvz8pQUJ9Et+5cd6+zGn6jNCLBy28m9oej?=
 =?us-ascii?Q?/I4N5ZPHt5kSqk36tRruVrI7lvc2LNcx47C0EoeKQQKp5tb9LXFbbP8rWL/c?=
 =?us-ascii?Q?+BaM0q6AvRgU1hF6L+1L1tPo8KiIhzvUy4jddhetScK6yZFDTvQksAuyugW0?=
 =?us-ascii?Q?bgID66EuGdivEBtiXcbW0/bMNluLz0eqek+bubi+IeShglP9v63rreIGFufc?=
 =?us-ascii?Q?NcSLYz6Hcex9/PhRrJi178SmhqcMGQa0GwT8W1MsV1q+oRveGVO+PzBVC6X0?=
 =?us-ascii?Q?NEztPIbWZWKj1gwG+yKOEk6AcU5Cw5ZMxoPS1RLo+eOEDqz+D/OLVmEv3JJd?=
 =?us-ascii?Q?FQ7jos2BO/Ygc820eTox4KBgB+Gg+BnMxJDh1LvBUpgAXdLrRE5aO60B7AMl?=
 =?us-ascii?Q?rwvOcXnWIi8HOoYPJoebpbaN19EpJnQmblnfTz0pw/CDeFwMn3mv/wBg7fZT?=
 =?us-ascii?Q?hAGF//OhMX7d59tlOn5EYWiDTBx6fCDnqnY6GysHGmZcC6c3xu3CZIxfy0Zd?=
 =?us-ascii?Q?VjSMF0PKTU8a6ljgSfIkHs82vAfWI1D3BS4VpzgQnDmFDWXJNlwLjo9OZbFP?=
 =?us-ascii?Q?6vhGPKq1EiSs5qa3k3hJ6uQ2THiJ1ZGmFDRPvP8+prfuNJdjECshSqhJDfF3?=
 =?us-ascii?Q?rP4VF8GWPqkZznS19wWrgXAckLU0eYK0MlApXL0EvBVxPoxRG9Oza8poThbl?=
 =?us-ascii?Q?F51E+Oz+PshfkarxG+znzWqISiHfzZWgqUSBDbKZkyrbw3XZuYQvp622/cY4?=
 =?us-ascii?Q?91EK/m9k2Xo6X34LjlCc3WClS0ab5HW8+gqfPy9HVu3ra0sdzMOXXa2ZuT1d?=
 =?us-ascii?Q?xsVLQH+RdtbTiImEi8DwOu65LvJjHVqy8wTBKH/SCcwpWNYfChWgamyA1itd?=
 =?us-ascii?Q?fgwcOVIn1dlARLlfNcbl3cMeqE4zPS6XsL4M7vOyey5uW2cfPw9bPEnvHPY0?=
 =?us-ascii?Q?6+USce4apsjw6/r8rq6C4E45/InpNF3fDRWdlf4yPuvdAXYABdaM2cKjoYJI?=
 =?us-ascii?Q?HfkdRzyM/Et+/WlpWnaewFCJ8qCNoGFQ3kFOP5CsLHZ4TyCFeEO+cYEVnbn8?=
 =?us-ascii?Q?n7vt5v/ktG0MPr6fX9E2uJCV32ELdRH7wctcXsv4x4lU6dv8BjFvHjWIwBOd?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0133f9-9404-49bb-aed1-08dc643247af
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:43:49.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UEYmwXLPssvzjMQ/EOI5ZxnDOSipQj8QN8zqDS2xF1NWzqkM8Zy63gj7J5dMxBpqvEfO2IQAdWOhPsq61Klqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5844
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_soc_init() to spl_dram_init() because the generic function
name does not reflect what the function actually does. Also
spl_dram_init() is commonly used for dram initialization and should be
called from board_init_f().

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 arch/riscv/cpu/fu540/spl.c              | 2 +-
 arch/riscv/cpu/fu740/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h | 2 +-
 board/sifive/unleashed/spl.c            | 4 ++--
 board/sifive/unmatched/spl.c            | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/cpu/fu540/spl.c b/arch/riscv/cpu/fu540/spl.c
index 45657b7909..cedb70b66a 100644
--- a/arch/riscv/cpu/fu540/spl.c
+++ b/arch/riscv/cpu/fu540/spl.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <log.h>
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/cpu/fu740/spl.c b/arch/riscv/cpu/fu740/spl.c
index c6816e9ed4..16b307f036 100644
--- a/arch/riscv/cpu/fu740/spl.c
+++ b/arch/riscv/cpu/fu740/spl.c
@@ -10,7 +10,7 @@
 
 #define CSR_U74_FEATURE_DISABLE	0x7c1
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/include/asm/arch-fu540/spl.h b/arch/riscv/include/asm/arch-fu540/spl.h
index 4697279f43..519e7eb210 100644
--- a/arch/riscv/include/asm/arch-fu540/spl.h
+++ b/arch/riscv/include/asm/arch-fu540/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/arch/riscv/include/asm/arch-fu740/spl.h b/arch/riscv/include/asm/arch-fu740/spl.h
index 15ad9e7c8b..b327ac5036 100644
--- a/arch/riscv/include/asm/arch-fu740/spl.h
+++ b/arch/riscv/include/asm/arch-fu740/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/board/sifive/unleashed/spl.c b/board/sifive/unleashed/spl.c
index fe27316b2d..9df9c68604 100644
--- a/board/sifive/unleashed/spl.c
+++ b/board/sifive/unleashed/spl.c
@@ -27,9 +27,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("FU540 SPL init failed: %d\n", ret);
+		debug("FU540 DRAM init failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/board/sifive/unmatched/spl.c b/board/sifive/unmatched/spl.c
index e69bed9d99..6fc1d80954 100644
--- a/board/sifive/unmatched/spl.c
+++ b/board/sifive/unmatched/spl.c
@@ -134,9 +134,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("HiFive Unmatched FU740 SPL init failed: %d\n", ret);
+		debug("HiFive Unmatched FU740 DRAM init failed: %d\n", ret);
 		goto end;
 	}
 
-- 
2.30.2

