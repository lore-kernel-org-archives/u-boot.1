Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE8FD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA4083EC9;
	Wed, 25 Feb 2026 14:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gZ8ZmXUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D6183E76; Wed, 25 Feb 2026 11:35:06 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E41A83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw0yRSYS87jjNMiUtDKZo3afZzUn+Zkaw4h/8u08j1y/C2ahUuaugiDA5Lr9Gt6MnpJT4nBt/pfqbMfGtWKM1Lp6dgVqnJZl4OGE2JGEaWL9MToBQQif5qsENvwrug9Xbc8pXTKl6KixAFvmYAL9UQlKu+3N920GRkGLVWzC8JBgMeRy90yuOaq7AZ6x+gc0SLSKlOiuTERdBbonxejb7l6yUl/u42cIg5WcSLpdSnF8lfL3uq+ek46Vp2o5UanpDcK00Rha5szI/URxU/E/meGgYwA1TtwlsmqnezcJif2vh9WZY0++KhUpMJ79gJJDJ/ah54iJg8ClNAMKBjawjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa3ogREca5yKO7I3xBbPo0Rzzg07VBEweitST9SiCQA=;
 b=GLnok4hx3Mp+s18Fnoyd5aql9ZPgbXKEwUcUS9IkwdQeWUE1HGY5LxTTVhsYiucPTK9LuWswsd4CoCJY19/e0vkT9g7rMGReuGudUXmC9RF9442skyIqS5aNu3lrIIW3K9PefVT6RkeY+NlgSvpEctbslCokX7BhwFEYqyVwWfrPk5954nebPkHEPd3ML8c9kZ/dggjpGv8dn0hoBzw9QCq+y9k8O4tIx9Z6KT4Hlkmly3TYyjgtbQ8na/st8PeYWyqEVAxgVndN93oVnYRJ3UGDeuEFYodTZtiNrogyjWtmIXjAoGhW27ZSUUHq+t/1YIX/5amvb/wgNh2A92Y9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa3ogREca5yKO7I3xBbPo0Rzzg07VBEweitST9SiCQA=;
 b=gZ8ZmXUqfRFTDkzDsh+2YFN1Bh9W+ZTzqE6gVuWg8qi2CWUAGVevNbYu7wBmiE99pu6dH08Z43eOnK0QWSizWxhnRjUQlMEemH30kLDRURo6BJPiHXDe1QGt6kOVfulaAldLBKf5xIwju99CG9hZ+Gq7/yX476GQKotkw5Dhvi8P/unqeyloY/r5ponVX6e5LDUT3u/mHimtuUg19r7kjv8lCul1zxf3FqQiS+XbkkTF6Vl8+T7gXE/Z6ZUhdJB05q73V7V4gj5aP2GENzRSDPk7Zh3oQ4Xh/AB/E0ok8adeHbF1XIDZp2KW2hWA5MNMdtBC3NUE5sgjkxJ53FBoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN6PR03MB7672.namprd03.prod.outlook.com (2603:10b6:208:4f3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:35:01 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 10:35:01 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] configs: agilex: enable FPGA Partial Reconfiguration
 command
Date: Wed, 25 Feb 2026 18:34:44 +0800
Message-ID: <20260225103444.1851-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN6PR03MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d2b222-8fc2-4900-3b52-08de745987b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: oY1AUpII1g4Df8MFOHgXrdc1DWTaMhNDU+lrhNhxr87KxdZrEHnwsL5OACK05DieLHa9QdJokhWFMYBkeTYlSQf/N1VJabGlu8paKsOvXDLNVWdImsdEQnSNfQPHkeg/f6f58mjAvaGMfkXP+15TS9GbnbsKG/y2hqW2oyZQ5jVw1krccFFTG81R+Usxv0zfrD1fhu+oQj5J7DEN5lveC/vIplHUiFVlVzy7ICRJGXCfpNeu5WOZsOu8HFpss5f4suqk0LLEVTnsG0ErcaDm+aN97UX8FSoAkRHRHySngQ+WXj1FqGgX9iagpzGgxSFQ+8p07b0t9xLIYFSl7IbXU410a01Me09sFCFF6ihNL2xtwczrM17Ble+6tK/I0v74xHV1DAzShDkn7y7zlf6VMeAnbSF2bPWivCAJPbPbIfkrFaFGKzb8Qc/cXzWQiDemA9AlgJw7C5NJcxYo4H4Vz0tWj3zkCe2Ow5Vz6iOj/kq44/30m881Vh6SkH4OSoGJCsQGeIPL6uq9nNICSoIFUeaV+9ehqVLDDrpwE42Ip02aoeyPnTcJXo/LIDHEQbwCUR2P9zB4Ndwtgh4b0GaDBJ4eTWECdiXB49mvEv8EDCKVs/SOf7907bplD3XcEBuE0B42LygPc2dX/yK+dI2KhGcZPyYm8eOr8QT47WzUNeEMQ+uQODvCTO74uTgFa3swPJnSBfLBnbk5S/YU9MDuGMcR/x36tBOyH2CguShpJiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNz2+W8zaU/SNFHo3nAOlu+7NmddCYzPPv7bbgn/8w6JDqIMe6bbDwLs4XZT?=
 =?us-ascii?Q?7JrLs7Vy/RaFNGiN0wdTlCFJBWRZ4OeW2FTUO0LbARuErfJuMxLQ/Y85s0fV?=
 =?us-ascii?Q?U6jQDFcX3JmaA0eAi8yILXoJa5142WsNh6J8/IDI0e6bKmgIem6797hPtZ8g?=
 =?us-ascii?Q?Rmrt+yI2hJ3JWWlMN//Sacy8t4sj2S410FbkCgqEyeTclT/IFP7DZjqPpGKC?=
 =?us-ascii?Q?G9Ar2qL0gxQoZkq7S5vY4KpvUKyr+6bsSJ2KM2IuS//X3l524wV5UVFydVuv?=
 =?us-ascii?Q?PDsvs+3eEeL2YQ55t9s//cESssH7dEO0ni2piazu6aPXQTYNtRzUdhpZjgEA?=
 =?us-ascii?Q?hd4uCtW11GPhmGoMnYNxbU4vDo8fc6Ux9IvBK5K0E/KWGsZXV76S0bvQaQ77?=
 =?us-ascii?Q?VzWqxrQ1flYau7ZvE/TOFIhhnL5/5UBqpq1Z7NAQDOa/LF6b1fZ7iHaTR/t5?=
 =?us-ascii?Q?O+VG2xBRfFjl/jnWhUdtByo24E0F+4+ZpOF74HKvxMrgJ3HR2rLo6m20n6+I?=
 =?us-ascii?Q?P7TUpCPI5F+NGyoA73hB+TNhuGk6gkkqc1ferpD921Z98uuFBg2re295zleY?=
 =?us-ascii?Q?EW79kzp0hv4aFtDNvd0ifQBCkcJZ4jmW4Ndv3ivYnhcbA8wudOjKxoJR1CL8?=
 =?us-ascii?Q?Y6UVtgob6YbbBptfAu1NwuQhuTCNTwnsnIf+T/P0dWNiHoIZZrbgXGD81LQr?=
 =?us-ascii?Q?yc+7DjxbgMzWFSVFqRxfBPvuMsHnBBQZ90EQxoh4ScKRX5Z0xFQd2X5wXs4U?=
 =?us-ascii?Q?AThhAEDxUAv83fihiaU9nvW/RTV8xgkNrkzJiOb6HPzFondcUWrY5/d84NGx?=
 =?us-ascii?Q?8VL56eJ+7HiQ0dD8gfHcNuS/ph7ClD4BmJFcI0qO24kOT4WGDd7koFDy38Qy?=
 =?us-ascii?Q?eJC5nQES3rgqwg8PkiurRXcn9ZQw3ecATN62ShAOPK7TblM3CaSgDtK2n0vF?=
 =?us-ascii?Q?rR/vp33InwhypuaH6EGa3LG7kNxrHJRDvOiSpXU8aCeqeU3JINNwV7e3nsXc?=
 =?us-ascii?Q?QK8Jbp/MrQ912K+wuF1TRNX348wdFlmY4DALr+VrF9gJt817aoNDEl8dslIU?=
 =?us-ascii?Q?u9xFViu8B6PuRqh/Q5Z0nX0kSZ9e8bt2pLGEnMG2Nq4T03zWLWMhP0gimJee?=
 =?us-ascii?Q?293AexkqZ8kh4q6oTuaohbgSuGhLlMJ3ZphctwAt7hYvCNMqJyM3+ndCdeID?=
 =?us-ascii?Q?jYde7yLSyDGTEhevzlt8AaNl/rgk8r++Tw4g7gSnezAzG4xP68087ymEtfDs?=
 =?us-ascii?Q?jaEPsPZIcW8eW/8YW5ksLZBKSGB9cTJr6bQdtZyxGQY4YOFOkBE4Ej2icWiX?=
 =?us-ascii?Q?j7/ftc2/rdVa2SKA44W3LfrlYqnZUeS3+6Sp4Qx/2ssBRwPtszVzciKGSQKu?=
 =?us-ascii?Q?ouqSh/FX3+QxFXczbS5nF+zup1KqNKjsf34/In2OViyRpReS1r4SOnfzMJXU?=
 =?us-ascii?Q?FUdGwaXZ8+zmCqaCD9tyMWCVE/lyHTVlTP+BpWcrgU2FLNg/xImzCjrykxww?=
 =?us-ascii?Q?so4EkWtYcBTemH1Hvek5HltXBLHPRPcRx7z86/HDhJrPOSNa97RO+Msehnfq?=
 =?us-ascii?Q?zxtccvdt90RjzDxGVUm0geqFc1bBULKMF7sx7FAeTzT+z4czpIziJZbMYhTk?=
 =?us-ascii?Q?eBkqo2/awORcZh91rAjlulJnIFYnQ37jcTuf82oxgNmlr+MHdrKYgPdHvHkk?=
 =?us-ascii?Q?myVm30sgjbU8hSs06/SexClJihTMsh106U2SCitOdnF1W1y4eOwi/wyzFc4T?=
 =?us-ascii?Q?2mxNOQ9gCQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d2b222-8fc2-4900-3b52-08de745987b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:35:01.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCxW87npyPVBr0otLFN4lX/kgX6QX5ovmqB1mRaUnnrYQo54kpZLi1RQGY07mK9bo2aGeAOzV/RQ6bRnLTzoQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7672
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:09 +0100
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

Enable config to support FPGA Partial Reconfiguration in agilex.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_agilex_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index b2c7b30d546..402e617d27b 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -67,6 +67,7 @@ CONFIG_ENV_UBI_VOLUME="env"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_INTEL_PR=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-- 
2.43.7

