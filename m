Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96BCD5C0F2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF7F8388D;
	Tue, 16 Dec 2025 09:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LCzQA4We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2968A836CE; Tue, 16 Dec 2025 09:46:35 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9B383642
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssSR8gnA+aKmuJF2Uu04qEjT4i9PuWWNWZTdLC47IggdCdbKZIub7DZpp4yyvs87p+6jQ6C53zxR/WWQmixrZCMAIePmU4Yxb3Y5lrI0TyTRgSUGnlWU93pK/zPGEkjA77s71R+Qwio67MELPXUNpF8facFeY1pJvtUfYF+5V5xatguShys1prfsIwJnsSPda90bqK9nK8TYlG2VvYG0xqeoLG0dB7lbeFs+Ym1jJN4wrpXlvtE1CCPSYw4kTUrNxxBIly+yGi8VytvEGEJtg7LL4ralziYCsu0L0R9OQnob5qG5YBUEp8eor3q/NkKe3D6T7iQ0w3p46f76Eh765A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6KwPK1K3iktp0/bdbtFM5GMi0+Zz1INpNMuRunlMMA=;
 b=UbZ6nqgtQzx+c+cNloYrD4U8YNIUPBv/Gro1hfYiFMszNvdpBXGkeGPWGy6PBXRyzrYGsw6FL37ht8+0Kw76nkLx2sTU4JX4JexnWBEGSSOzbkznRL0aG0g27Z061QmWBMIIf6hm6QHbe7mFKOaN25leCNV6lBFk5Nfc6bZozVzO7azubPw3Ein/uOBxY89qBXfwJY/vUAv4ewNi4otg9gRLULlmLL8j6unaBKY7ZKRKr2AXiQVZohSxft7L1mw6QJWEF1i2R/dcYkNn51nh7zrLvbWsWiGA2bpnXlob/PC2RhtG3ffD3ERq6FXbuLEAEBDmYCnl+ku/GVMfeSj/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6KwPK1K3iktp0/bdbtFM5GMi0+Zz1INpNMuRunlMMA=;
 b=LCzQA4WeM2IYQDZP8RlRl/lqI0mkaRRqjgILX8+RKfTh122n5BlinlT+XvIAAcXQpcFogx6lx9B10YicyUp8AInx4yUrg0Zae6hptC+F0m+Z6vqGQHJhEm7MoG4h/nhE2Rs6QDR55F/Sm5DhZd43coFijkw5sQDkLEeFlPSOgD6o9423y6c3/MJp2yK/O8Q9S9Bng/+T0RMW8RckMm1ik7dO3czXZDd4NlR+FBY6DbqPA6Q0EcIe1zxe5cJ3q7PPz51SN9+7W9bL8Wz+LiwmII24y5wzJTcqIh+4dCXIM+TMXD+ClsrWF+S3D8XNctrVO3Ro88v3r123SycMpgAaNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
Date: Tue, 16 Dec 2025 00:46:20 -0800
Message-ID: <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1bcd3c-64f1-4a1d-ef99-08de3c7f9a98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMSAASQA24+QN+SMQ2dMz6rfnbNezHOKJ8yVQ95NZxOogt0kSa8+I5YSD5GH?=
 =?us-ascii?Q?DmRRyLDF/6yRs21t5OP/310dpZc6IvcnFnd6DphIF/BZ1KB+73J85CngqXez?=
 =?us-ascii?Q?ODpL5zjnhTtyBQCUDJcmS5vgPc5+/8seqZAp7FZXHCdI2KfpAmqy2y1ASmbq?=
 =?us-ascii?Q?qcasSDKOZ04LD7y1kuzMJ0LJu10PmouySbA41ZoxU/vtoUZ97Z/GCe9whH8A?=
 =?us-ascii?Q?A7Lf82+fyBKEKXke78lFa9h+9P9yesK4/C8+xL72E79cy8UUhm8IsNCIWQ6P?=
 =?us-ascii?Q?Zw98iHpx4y4zr/qo42Kw8U0mW4jYPStPQoMYUM2/fTDhywDVC95YeKnVJwK7?=
 =?us-ascii?Q?2z7tl5bHqytCTLsvqMrR+dhIxr1Sn/3I0kj0Z/glIwK+3rdVTLKU8MPVBAzZ?=
 =?us-ascii?Q?Eui0ba2FE2ICIhFpjOjawLv7k49mVBVUVaAA3zClhAtZ1eQxDpUZ7p+ozD5J?=
 =?us-ascii?Q?huNGzg4Y3iE0MtF1/Tk7QyCtRnDA3tSmUOdBYLwb5oal1rLTGyQ+h7VcSuDU?=
 =?us-ascii?Q?UMGLh1LABvTbbrPjlqKCM40mogBNQx2+P7vhKnNg/FbHIzks4g8WMzmkYXoC?=
 =?us-ascii?Q?7NY6bQSzkKD94mitTV750TfvlY2gLUAZLyWtgHDEeELFJ/jdgZopx0GUgMgm?=
 =?us-ascii?Q?PKolkvk2U2sHXeFJweza9/aBEnQAqgGRvMJTJcnMqFAf2cLCCar6YCoID0oZ?=
 =?us-ascii?Q?14jRhxqPoO6+JAc73/WSCenhVxxidPHYBf1EyE9htfY3VenX5qxqzurqWNM/?=
 =?us-ascii?Q?11MoKxe8UfhIjsw4Y0VHzspG/8vfIzdj0G/+6EeKGAOk8JvaLJN6s/1+qaFp?=
 =?us-ascii?Q?8Ezzo6itFMZvj3E5A6k1iqk4R7RqDNdkfS+P+KheAkM4iXnh5JPlEDaOFYwd?=
 =?us-ascii?Q?uPObmnpzLtqjvOfF2NHjW8TkA3EkaAVosmKOlOSdyTVPw358lbxd3qdfJo80?=
 =?us-ascii?Q?Jn4hOe3gxG2Hyf2JO6rGqlnu8m6yfF3FLRNRd2NA0KmyjiScpbJ/5KrhU4Kb?=
 =?us-ascii?Q?zBNgqZJbEZXPt4DDMtlLhxmL1id7Iy5NjGZzc/v/WgI658/SWI7/8iIKo2pk?=
 =?us-ascii?Q?smATaO/2usuchOpbgp6067oYGgmpU+fnLpW/xh6qWcZVSp88s5pzlifyfRfg?=
 =?us-ascii?Q?aWfpg8Xgu2NhqJjmNVX1LsmADjqFYrGxnVFQpIGMOTqcxAjsrSt/XEf0YBbc?=
 =?us-ascii?Q?rFfO8DoXUhzCIGb8r5lAOoUimW3xrm8oXX3wejiONBSNZvudTU4MvqPsHx3z?=
 =?us-ascii?Q?lLSHWq2u6NoyukgHM7ek8DZKeu7KFYtjZAYXd512Vh0X5sahK8CDcspUfPSa?=
 =?us-ascii?Q?6z5GxGILRdEbOt42DVgt1C2Fi/qZYw2aofa6MsPm2SR3NZMEPNljmj0tdq+g?=
 =?us-ascii?Q?OpFA4elJ5ftz5aGhamIxxNfQuP+tq5xVvjn3QdjtWuPhLPY2w1ZLg+JXMP7t?=
 =?us-ascii?Q?Eg3b952jdt4YZ/weSJuMlSUdmjAKZ3Xs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNyiTc8G6/I2l6IY6yBZTmPeaVh8m95VjEOAK0hlrfN8vW9JPDN+7q+l5wG1?=
 =?us-ascii?Q?jjM5noFQeZrLN8i7mm5xOFr1UZJsmSm30xQqaQZ6SyiviZOUZcv2Crt2OwkT?=
 =?us-ascii?Q?bFIjT1LAd3ynddA625Q+DVQIhbIu6l9M3+ieiSt5Chkwkx4+kGGcLVhQIQiv?=
 =?us-ascii?Q?ev6RELb++CkOCzenEbDOGGW6jV+sSgyBrq5R0P1kDM4mhvxPlfSe9QQCcvyy?=
 =?us-ascii?Q?ykdamBV36zV5flq4LbVeUphQCXECVpQteXz+XXibJmwasunRiDYp6i0rEaJ3?=
 =?us-ascii?Q?ne+attg8wRk5RW3oWnTsALCSxEveDSUqgzAahbunfiobzqudReZ33Ayd7JJi?=
 =?us-ascii?Q?Kg6g96vWI86nptJ0Q0oyJUWQ1SEpJwUwhLdT15KDf1UQUBj8xFyN+C16IsLf?=
 =?us-ascii?Q?xZ0knLs8z2N3zSR95wyGbV/r+q9xQup0SAmKj6EhbOBFi4aM/CoEohjuU9nr?=
 =?us-ascii?Q?i55GrdQUselp8FXGmczLRnRriSrW45dfL9LJQzBINwB62TKD3r8EqyR3yEDR?=
 =?us-ascii?Q?KLtvVnsSFXaRGDI6X7UX3ZrQRIzNjkO49eUn1rs3N9Vu+u55us5rEekTL/bB?=
 =?us-ascii?Q?nMNPVm3woaZBY0GI+6gbzZykTcCEyfmTzeU7zRFiNbccUNSB4KJBGXCKfA9s?=
 =?us-ascii?Q?c+6bb9Y5yOGG4RuXRoZvF9rQ5CrJGBioFRX5GiYl+mj+8+aDJyItoHrVL7Pp?=
 =?us-ascii?Q?2RTIJJyMJSxgqnlp3K7oWa/0OI4qanhSng9y2dQ5yErjV4/8SxLuroZdYHMk?=
 =?us-ascii?Q?oCmq+AerapFe62Uds9heAVsj8rEuVazKhjidlHeCbPQ1QbOFOWy8JU2l2aSQ?=
 =?us-ascii?Q?r/mzBFHMAAs/7xvf9k2MH78NYM1A3DqAcgMCxLD2wMCecRyoIMIGv+AmntaK?=
 =?us-ascii?Q?swbv9ULPrlvAZOXjcbUb0XmMUpRxuseJmsEzs0odQqRLYrlhwc2QnTSQOe79?=
 =?us-ascii?Q?x1Q8shmi1KVPdOGHzQgCxPWO+qLuT+8KY6ypHjpCZzg0A1xwsg5CF3X3vIUM?=
 =?us-ascii?Q?MDjHzmmMt2fEg5Bv1NjO4NokvHkIBinzq9+p4klpT4zbeM/AJ5t45oyTQV9A?=
 =?us-ascii?Q?CeN/m08JKLkcWzyutFBpana98HHcXhybb4ZybUlQew5mTujD44I5JNGG3DDi?=
 =?us-ascii?Q?fKW7H6T3ITs3hEtp5y5Ws5gz2CkrMYVeLQG3HllAkC6neNbT3ikdLarSK5FF?=
 =?us-ascii?Q?zhE3rQ9I3w1z3FDbsnl9UAmfs4W+8ivDuHJPjNjHOquuFvGU1enKJbWAX95S?=
 =?us-ascii?Q?hyTx8euMEYv9bAWBeow8iKTn7r4cNyIXAUgdiA+AOMFxGmLyTeS6G2l99DTl?=
 =?us-ascii?Q?zfo8oPttEcxJNBFjCcU99TkSifbjRvyTi9pmkFUVg+OI4WeOpHNP/B7iWXDn?=
 =?us-ascii?Q?D7TTYYI3fICr5rWcXFuGzD0TQHSZYrKJl25uRC98UEpDeFh7dM2Kj0vVmrLy?=
 =?us-ascii?Q?YgAidA3M+oYUulVaiNYw4wxsyqCrHSGxbv99IQ+XEn3ZPyEnzeA+MZLEnuBG?=
 =?us-ascii?Q?JUTX3TF85o5PHXe7G9nWAliA/OFZ8nt/ytUQMVFhpD4Mamp8uPJVGQ+db5K5?=
 =?us-ascii?Q?mh8uJhqv3LyVXrgltZSU5eJaLxHo7vVFGWREMLcyhuH77iV7shGrW6lkX2Sf?=
 =?us-ascii?Q?6mBFcstoRXuJTg9GPqObUzRP9hQYyzpFok8/+W4ZdlPX+9e2OOKRtQFWhzWz?=
 =?us-ascii?Q?WBkx3hlZD5rfFfPuW3fSZxi/XMevgKgixTlaEzKJUOlKs01QlbIbcB1f62TI?=
 =?us-ascii?Q?2JQJl8khfzKynA2r/zIq4ihTnLYMS58=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1bcd3c-64f1-4a1d-ef99-08de3c7f9a98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:28.7179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OxokqYcZJTEshWtSVN+BS2ILa1Hk19M61sfmGvx+4Wh8s/6UrwAbwp28f5HYhaTHfwFkD+qcA6KjQpbhCrEFUDgbXxRZ7YaXC65rdSXVkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The SDRAM must first be rewritten by zeroes if ECC is used to initialize
the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
case.

This scrubbing implementation turns the caches on temporarily,
then overwrites the whole RAM with zeroes, flushes the caches and turns
them off again. This provides satisfactory performance.

Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
Preparation for Gen5 uses the same memory initialization function as
Arria10.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
 drivers/ddr/altera/Makefile        |  4 +-
 drivers/ddr/altera/sdram_arria10.c | 25 +++-------
 drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
 drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   | 11 +++++
 6 files changed, 115 insertions(+), 21 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index df79cfe0f7f..5c78a4c1fea 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -27,6 +27,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static struct bd_info bdata __attribute__ ((section(".data")));
+
 u32 spl_boot_device(void)
 {
 	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
@@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
+	gd->bd = &bdata;
+
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret) {
 		debug("DRAM init failed: %d\n", ret);
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 7ed43965be5..b9e3302d714 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -7,8 +7,8 @@
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
-obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
-obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
+obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
+obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d3305a6c82d..0e3a1d42f34 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -21,9 +21,14 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
+
+#include "sdram_soc32.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define PGTABLE_OFF	0x4000
+
 static void sdram_mmr_init(void);
 static u64 sdram_size_calc(void);
 
@@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
 		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
 }
 
-/* Initialize SDRAM ECC bits to avoid false DBE */
-static void sdram_init_ecc_bits(u32 size)
-{
-	icache_enable();
-
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
-	dcache_enable();
-
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
-	dcache_disable();
-}
-
 /* Function to startup the SDRAM*/
 static int sdram_startup(void)
 {
@@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
 		puts("FW: Error Configuring Firewall\n");
 
 	if (sdram_is_ecc_enabled())
-		sdram_init_ecc_bits(gd->ram_size);
+		sdram_init_ecc_bits();
 
 	return 0;
 }
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..7a0a043557b 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -2,6 +2,7 @@
 /*
  * Copyright Altera Corporation (C) 2014-2015
  */
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
@@ -17,8 +18,12 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/sizes.h>
 
 #include "sequencer.h"
+#include "sdram_soc32.h"
+
+#define PGTABLE_OFF	0x4000
 
 #ifdef CONFIG_XPL_BUILD
 
@@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
 	return temp;
 }
 
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+	return !!(readl(&sdr_ctrl->ctrl_cfg) &
+		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
+}
+
 static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
@@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
+	if (sdram_is_ecc_enabled(sdr_ctrl)) {
+		/* Must set USEECCASDATA to 0 if ECC is enabled */
+		clrbits_le32(&sdr_ctrl->static_cfg,
+			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
+		sdram_init_ecc_bits();
+	}
+
 	/* Sanity check ensure correct SDRAM size specified */
 	if (get_ram_size(0, sdram_size) != sdram_size) {
 		puts("SDRAM size check failed!\n");
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
new file mode 100644
index 00000000000..b8b42ef8e03
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "sdram_soc32.h"
+#include <string.h>
+#include <linux/sizes.h>
+#include <cpu_func.h>
+#include <watchdog.h>
+#include <wait_bit.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PGTABLE_OFF	0x4000
+
+/* Initialize SDRAM ECC bits to avoid false DBE */
+void sdram_init_ecc_bits(void)
+{
+	u32 start;
+	phys_addr_t start_addr;
+	phys_size_t size, size_init;
+
+	start = get_timer(0);
+
+	start_addr = gd->bd->bi_dram[0].start;
+	size = gd->bd->bi_dram[0].size;
+
+	printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
+
+	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
+	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
+	size -= PGTABLE_OFF + PGTABLE_SIZE;
+
+	dcache_enable();
+
+	while (size > 0) {
+		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+
+#ifdef CONFIG_HW_WATCHDOG
+		/*
+		 * In case the watchdog is enabled, make sure to
+		 * (re-)configure watchdog so that the defined timeout is
+		 * valid.
+		 */
+		debug("%s: %d\n", __func__, __LINE__);
+		hw_watchdog_init();
+#else
+		/*
+		 * If the HW watchdog is NOT enabled, make sure it is not
+		 * running, because it is enabled in the preloader and
+		 * causing boot loop if is not handled.
+		 */
+		debug("%s: %d\n", __func__, __LINE__);
+		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+#endif
+	}
+
+	dcache_disable();
+
+	printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
+	       (u32)get_timer(start));
+}
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..85a951a5a74
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#ifndef	_SDRAM_SOC32_H_
+#define	_SDRAM_SOC32_H_
+
+void sdram_init_ecc_bits(void);
+
+#endif /* _SDRAM_SOC32_H_ */
-- 
2.43.7

