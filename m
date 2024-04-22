Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 13:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9A1883A2;
	Mon, 22 Apr 2024 15:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="GEpioRgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C0288417; Mon, 22 Apr 2024 15:16:25 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E74388340
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 15:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGB/IHda4AGwzYp5kWen4Coal/Gxhxm1PWX/vt2Vk13jtpiSUWEiQHfQAdcgaGt8QSnYZW5Mv/b46yE5671u/k+78+0/uLdHRNKUztYuNPt/dW8KLtGDGJB2UfTUt6xsJB43rYdbN4nrWhgyCu273tCg8z8VhuTZ1Qq9CXR9ncN+1PxF1faU9rKp5IcTKKhJnkd5Hat5kzhfYFFX0UsSTcQRMK9hWVw3r9sxnBMLBvim8qYflLx94goZimi+2+cLMl4kdFh3CewNUgJXJjFvz/pLpzU46UUle8AjquT5l58TYrOxQxiP0cW8x8wJXeiQLJiQ61MasZyEdWjO0hKnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h+YwGYvOFT1YMf7kS3k3M3/9iJ5W18I1P+cIVEr83s=;
 b=XSltCFD/SYljCXjZsOW6IyUTpRVYFCGXhYnai9xGl5TQJ7VgHQf66/rhpvImzEnWbtmYaQg8XkZEz3wsYIzUS313ZzEsgn5rhBU96lu3LVyWHcJ/tQIyTh5h8YO/zOHyvixAshAq1AJ0/0e44Xbbir6E7l9H6PiXz1DDWC3JImLEI2RhlGfU4/nUErDs/r7UbOsaLu8o9u00rEe98azqciOydgQzDQH+6LYo4ux8NMkrYbgQK4xoufv8enOOsiai4I/qO2ZYGhWlzIchbKufXrjvCcrXPbcQmiTDFOE2HmsPDqZ2SsW8DG/QUfIqQlXT1xGcmAym6LS6XLfH5QZpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h+YwGYvOFT1YMf7kS3k3M3/9iJ5W18I1P+cIVEr83s=;
 b=GEpioRgC7aOhw+01Fq3UzFhmfhdVHmNOgU/KPyCgI6HEe5g+LG0kIoRolGLXR5Nmw/KLxP+8RlvIlP5D909LxfMBMiISOSe5nHCt73ZlzVoKySXKJT1QI5FWavedOVK8YQgc+C5WSfrJg1t9HFRC2rCDFh1WPBq7delSGnENdiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:16:22 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:16:22 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@sysam.it>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Green Wan <green.wan@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <monstr@monstr.eu>, Minda Chen <minda.chen@starfivetech.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>,
 Scott McNutt <smcnutt@psyent.com>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Thomas Chou <thomas@wytron.com.tw>,
 Tom Rini <trini@konsulko.com>, Vincent Chen <vincent.chen@sifive.com>,
 Wolfgang Denk <wd@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Zong Li <zong.li@sifve.com>
Subject: [PATCH v1 0/3] riscv: Rename spl_soc_init() to spl_dram_init()
Date: Mon, 22 Apr 2024 15:16:10 +0200
Message-Id: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1513210d-f482-4eab-a8f9-08dc62ce6783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?udPim/t6Jr8Hv9qmnRbDePDXeQzF+y/s11QFMPQcfnEgBhBxvF9qfgUMLkhA?=
 =?us-ascii?Q?Civ4Psupjh4TcmpxI4LmAeI2Ld2QXmF+em9etuFWpBhPPrOpBp8jneljLDiU?=
 =?us-ascii?Q?MTSMa+5OtSn72JhwuxnsU6TKYj2sdDqxt6dK2OCnwcajCn+rcNYJeseK2Rxn?=
 =?us-ascii?Q?uXBSpBfUTTKRheLQoT+a44zl6KXSYgES2LwggD501p4nbXrXRrfTpCKTawjA?=
 =?us-ascii?Q?pTEmQ2oPKVssxg1Vgd8t5MsVRwsmZNtJyC4kzWtNlFfHLlrTFLRLDg63vpY/?=
 =?us-ascii?Q?nUtd3LDydIjqfM0kcZlR7Dpf7zNiGoHp2NLxEnoowfUdpCK4oK99FRxvh3a1?=
 =?us-ascii?Q?m+KMxSqcYhJc82sojSVZo13csuTGEbCW+hCQLSeqiPLwQxv9A0MbG+Y229eK?=
 =?us-ascii?Q?GHcmA5NCyfvDCvcXkPfLYRgM7TOazE7E+XaAzlSodDH4DM9JwpU+AeAwAL0S?=
 =?us-ascii?Q?zcB+vpQC2wkrPE1u8gSmOwQ4qxOnVvklQO3yytR1Dq0GW9A/6CoHtfrP17ZV?=
 =?us-ascii?Q?ndM7w0EGklrQENhld/b9nzgD7Q4IS+s45MeTGLsOB3Yu0zsXm4DmBZkn3GgT?=
 =?us-ascii?Q?xO6Z3mpgw0rKKjX+gkcKmSPx7SoWPWF5mF4TMmBVjkA74hVajzNCIlN999Qy?=
 =?us-ascii?Q?p4vWcnzFhqGkm5u0JbcVfVMWpLQmwQz8ST+yX+N2WassZh6v7f8PetUKuptb?=
 =?us-ascii?Q?cdDIxOYY5L2gOAJ5Z5tJnGTPvQZa2tNjblx6ziRtM2IPvog1jeSe+G/WHJ/z?=
 =?us-ascii?Q?jKC8kCVZp1D0OloQoWY3Wx+KUV68qgnv707jXcNghhpFoFSRO+vCNeSHJjuJ?=
 =?us-ascii?Q?isdftnyG4sOgI6/BMkXmmYzVRdn/oB8cIoJHe83mzG4MeO3xIJFExZyQT/JX?=
 =?us-ascii?Q?GWsdn4Tb0JvZSRxjo+MZ3Pl5M/oPNlj6YDPFVhV5TGm0XU8P2UdQ8Zh60ZHN?=
 =?us-ascii?Q?nV78kGyo0Lh35z8cmqWVkBYk8oQ7DUteAGr6xd2HDpdOBvlsSqz91ZEnNc1I?=
 =?us-ascii?Q?kWFG2NODMg9AD8cMyN6INugJUK8NEC8KKdYt6mwVR134kiahV+2gAVdyFdj5?=
 =?us-ascii?Q?XWduBVacK+GxTlVAnnZ3hLZ6fycziVIsB/BTxDCRsnpUs9MmiWMNbVui79zX?=
 =?us-ascii?Q?K5h4j/n+2lC8Lent/WmVTe12cZ5tNffa+XTQ3lzi7PdEolmMofpdRLrcFS7a?=
 =?us-ascii?Q?Jj4pWPuvNZ3vROosAX5hBd3afTMFXPUt3M4Lm68K9lYS+sAUHnXQp9nuHDT0?=
 =?us-ascii?Q?fK11siSSS+gkWEVDk/z84JqeDIGeIEh2SowfVsNtdaQNK/p5IPxhzsvhkkXt?=
 =?us-ascii?Q?aqxbp/q2pQh9DGnRnOWDcOcoX+J0jBGNdk9trBKAClPJ3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJvYVA2bay48ofXsWtskP0IWASDxB39bYKFLtMG/KstjUn9DeTCKZ21HV+2P?=
 =?us-ascii?Q?IoVgbcN/6Ja95k0f6kgFx/AUrKv2KjoZhlntHdjHywp/4maX6msZVVywV2iw?=
 =?us-ascii?Q?eq+qAWjGAA0OFCfs89xq97e8tHWq1iSmkj3Dzk0CZ5FG4NrKgDjU8OUlj5GF?=
 =?us-ascii?Q?MDthYnXz5dZCfiuVO7pU4ulibmBVhQWz/D5iu4lfVMyiv3p6bz6g6LJ4XPYr?=
 =?us-ascii?Q?0o+xAuWFPPLefUPHi3zhmJjSSD9uVSDDLqbG5dt//qmSdpOxbQlLuoTrCjw6?=
 =?us-ascii?Q?K9kBcusMd4kvqADhh+1V4HcfPhl85EDDKtw6MRyzObjE2AueJqhCxsAfWYYt?=
 =?us-ascii?Q?TOk0O3LVlxG8tCrWgHgU/tyF7K5bDM317x7DvdvKxPi4kic+nMwfTwTVsNAT?=
 =?us-ascii?Q?/vroFWY7W93oek3SFrUilPqD5Ge0nIHJCj5Cqu7SKpRH2QjLdE0QkR4QcYBn?=
 =?us-ascii?Q?Og+NjVDEALH6I/LKMIVMXVyU2G/1LqoRplMd0q2OS/olgOoat8DB2wu6eo4k?=
 =?us-ascii?Q?K2VqTnxd1FeoD0ChSE8A2qv6H4pl12vc0D1osqhAQkhVy5uClHz6KzdLMoNn?=
 =?us-ascii?Q?xb1iQoO5idd0TXk4yeeHBofv8lBThL8AA1x2L1c7NeWSo52Z7jBsejQeGLAX?=
 =?us-ascii?Q?KUgSCxPA8zqqT5ufCVe3Po6Iz/eLNk0UwVFyFOTmgNOdlimUEy5dSimEDbBa?=
 =?us-ascii?Q?M4iYHEMajr5ElBydttcJFiC3CkTMeGExZRlk1rZ8yY0+GVQIaGvQplWm/u2A?=
 =?us-ascii?Q?ryMDZO3qyPCiIdlsxMg6BtXPgFL73Q/r+ePIZKZN7Tno3Q6ejqh/MS5yuGzV?=
 =?us-ascii?Q?Gogq9zdlxaCC84BO0gV3ItG56HVqFOsOYhSeojQHyrqjxi4fOV9m3k5JiOPy?=
 =?us-ascii?Q?HXhphUCRPPXLYmd+sJA72+Ofql2QUfv8t2O/Dp37kBfWsL1nn9xIVmjsCkal?=
 =?us-ascii?Q?chYISQzIluLwiueCtcceZauQhjCpc/yF1Mkkz/JU8ySbWY0d1Y3g+vWVnPxE?=
 =?us-ascii?Q?AxEQDGgevKtqVJa/I8L1t4TBcjZr5e0aYENz5yWSDv89ncIC248aBIIXVaAd?=
 =?us-ascii?Q?mXCRMP5EwWv+Ofyo9c26aVUpzXxi24AmgFn8bE9NCFgPb5WyOwKu/Ng2gl1t?=
 =?us-ascii?Q?ofOqpv0iEx+SpqRfOzgbQALfDtMfXHpub+cEIeycPGsg63Ph9oEYV1JD5fxm?=
 =?us-ascii?Q?vE1YxgwUNFIFMOgma1Lmuke4ii/PooNXhdGU9gX4lcVgOuvDzyV7avI19/ke?=
 =?us-ascii?Q?05B3fmDtcspYnn+W2TH+Lpew9N9op4ISU4THNkNPjp4GBWkqFzgvDgMkIvnm?=
 =?us-ascii?Q?bECctjpnUCDljHdvikD8xdZEkgYacTMopMMarS/dHjSDdOa1/Amnk9lrs4oh?=
 =?us-ascii?Q?6XT2WhsFgJSVI1LyuHLQPEa8D3scQvh3THrxbPztGMB6GOKFSQ87gx3/Z7Zo?=
 =?us-ascii?Q?kG7RmE5lwntbepOHL5XkAomRk66aeTQS3nbSYK/OKzoUnSROvKRD9011LCNq?=
 =?us-ascii?Q?nGfrEA8ziDk2wHJyuW+RnNXNQtZydlNDhZ4/pi5vvtspH+WEa669kxSKwAVR?=
 =?us-ascii?Q?lzGatHNe7cuybo5JtJLTIF+/JmmUFUU0Ev8U8Wvml+WSkc+MrEa5uLGlkkas?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513210d-f482-4eab-a8f9-08dc62ce6783
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:16:22.0498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knq/IwB8Pm6OZjnARFSIH4OmvvDr/XSDwj+ZI5xXwJws3XEbcSKlLQgBFs1+DeMqCdpgBQ0OlZFYtFU02M9hSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5620
X-Mailman-Approved-At: Mon, 22 Apr 2024 15:27:06 +0200
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


This patch series renames spl_soc_init() to spl_dram_init() since the
purpose of the function is to initialization the DRAM on sifive/starfive
boards. spl_dram_init() is a commonly used function for this purpose.


Lukas Funke (3):
  arch: riscv: Rename spl_soc_init() to spl_dram_init()
  board: sifive: Call spl_dram_init() for DRAM initialization
  board: starfive: Call spl_dram_init() for DRAM initialization

 arch/riscv/cpu/fu540/spl.c               | 2 +-
 arch/riscv/cpu/fu740/spl.c               | 2 +-
 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h  | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 board/sifive/unleashed/spl.c             | 4 ++--
 board/sifive/unmatched/spl.c             | 4 ++--
 board/starfive/visionfive2/spl.c         | 4 ++--
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.30.2

