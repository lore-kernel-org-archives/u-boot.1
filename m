Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7EFC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 18:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9A3381222;
	Fri, 24 Jul 2026 18:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpHoK1W3KIgK; Fri, 24 Jul 2026 18:04:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8224780FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784916289;
	bh=pRiVUCteOy2fnTODMY90m8FPML1EkQx0iGJ/VMITAGY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XfNntW4SwqPxLoqSWLBERLBOPKea4U21aPwfLriJPZc9AeOTG90fPtFL2l2+SeIRi
	 vTOxdy+vrIg2Trpj6Koq/VKmH73iw6g3QEzp+IYYZFAHs+t15Mo+bI3MPwSeQO+yi+
	 OABgz1bVTVBhIkVQ/805tiOE603hCaxg4ABMWNbIC5fHpi+z+9dHtWYPTPX7RffVff
	 eg1DANF9ZEu5cTylcoEjqJuhSCfnPmOizAiaXqu6bDareklUUSowprjoawwqgVrZem
	 OXAXghtkqDvpCwGEA09zhH+X++6SZB2rBmI5a12jiR/D4d6yX8BoVXXBALeJ4iO1rA
	 z8GLtPkEml/ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8224780FF8;
	Fri, 24 Jul 2026 18:04:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70F1F350
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 568E8608C1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKNlfFwG6s98 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 17:36:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 55425607A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55425607A3
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55425607A3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zElMC2LourtjLzdt9Sv8+vZghovw/UsZiyH3CNtJ/ziWLux5eCVc9Ecjo0mDS5k+lDEAL7SGlZFWC5tMS68lVXT9PVi8BDo21wlrMdBOJATfw+GNCR/7st2+ZqeyEFlBDuuDMBGSQENBmCNAoVua6vJSfmMpq8INohQvWzgsqDj6SD2i281Qnq8ZP5NjhPd08p5DcrPZtIRcUTn34tP0FOJnz8+TevKY3eMChnB46JTZJaJp2uMTnooNYfOhoskg9z29ThPOfs+sx8lPHPtTNMsRowFN0wd6mrLJj3zB6lrT+/Z194EVWr57Bkcc1cSKeKo6gIVUs7a3fQvnQ0K5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRiVUCteOy2fnTODMY90m8FPML1EkQx0iGJ/VMITAGY=;
 b=WtQGAItl5EJmCG+qYbLlK5cMpZAG60of9EKo2pZXiugSBruqv+t5+4UddV0CerQnjPlWgynFNDP/3NsWxMCKQ9W85R6byinVafEwXwm2rg+kP3sAfpaLp9h25fPThr+i5wXYC7P9w3SdDoyuiMJtGU3WCmnSSq5MOJGZzt3xZkdGjk+DJU0v2XxUKYmUFFybQ7wKZkymzyILaINOUb1ODZWE6EhyvxGrkkOrHVEO82pcjFKSDCyTlpNlWoAXW46NE68K2JAVpEnupzhssOjbtO6Efc6bF8UVb5F1wRh43Tce+fnuaNDnD7mJhczi+U2bZr3Fw0PWaQgn5HssdiyyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 17:35:55 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 17:35:55 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: u-boot@lists.u-boot-project.org
Cc: conor.dooley@microchip.com, jamie.gibbons@microchip.com,
 Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH] riscv: mpfs: Read and store FPGA design information on MPFS
 hardware.
Date: Fri, 24 Jul 2026 13:33:50 -0400
Message-ID: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8adf86-98c6-4ffa-4df2-08dee9aa03eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|786006|376014|366016|10070799003|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pl6HUKWWk7sbgSzeM05tu/gmy/mq8uSRCOa4RpSCjrlBhCVml6p21C/dYvcFvsFb780v0detFW2iIDDbLxUfem5pzg+JSyp9Bff0BgUAR5o1tXFLFeiivqQ6fmh+ovHyA9brA+amgZcg3HDDqeUSfPhFSOfZ3ufcuqu6XfUi8bVcDx2F+xLYj7LvptfuALg2v7w8qqn3webelnLkqDrwCIKQ0CUu9LqSDzXUfr9LjDfF7a+GfjzfxCNZc2+VUb47aaIENp37bqwn1b/U+zdKE0JXRAYl/GSkEL8s1mF1z0zpsKDiTh+KYssW/i7Cx7bnSdD9yNiqUBK11G4BxTLtmb2oBLKfb7/6/F3Rrk9An4scNec4Mt8Gjtd6WhnqocbC9w0pWtpVeDRT+5MuHVvyuFmLIS5MIxKZqfAUq+ufOXk1LCXORA+qGUB31x15Lph41nAqIdobJ+S5KprjyjkqjlZQtPrNZjCLa+0/bk2O8qWO0NbuwoMQu/vK1dKJHNhYVwhQNaXylyn7K/8wkCV/jWEG/+bv5BmdZw1aHgxWa9kRFZlJ7ufPB3be4eii2/KodQuuBZminH4KiqN5uT9lzzFnob0Y1iguJWdTdZ930t/AUJi311YU9Noel0REnDfC1jMwGzj+pTh7C88YRC9oqkilT8P8JhjrWgBb/wn4Y00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(786006)(376014)(366016)(10070799003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpvrJn10nVVwg5t9HqSIztk2qkRyUVnAQyTdrqV1jc5CALNhsGlmUCSI2o79?=
 =?us-ascii?Q?Tur7Iq//eDPp9sJQrpA3mJVoKrjBTmySnK9L/dbUuWYCioOuSqiDxpUvsJaP?=
 =?us-ascii?Q?8ztaGkmiLyLegF0qfYbOPrnWMmVsGirGdiB+uI8RQRqW+4PWSvniNuPZBEbS?=
 =?us-ascii?Q?A8dFmhTlkvrcTyO7+kD05mReBB+pYV+AocMCEbyuNAjFldqT9s9LACEkL09B?=
 =?us-ascii?Q?hC4wlBNUnN2R/awv5X/DZWHfD3NM4ETUniS3V9bnIs3J30gYpPlTqwD3hB4V?=
 =?us-ascii?Q?mBYiKKBmByVWqOidJS8hTxR9ARP2iWYeVsY5SQTJPu67votWX6e1D5WRYay0?=
 =?us-ascii?Q?SnMO5joke5ynH/yBOAqlvxOcxMc0MFkzeqkezAte49/v86C20k5eB6Vp7PaB?=
 =?us-ascii?Q?BB2cn16OvbTH5HI5VWynFIXvG1xY7W1P2fGx67qdg8teglgK+uYsjFZGvUdJ?=
 =?us-ascii?Q?JS8i5x/bP8Z4T/jJdSQCGSxXx+cOo8DV9jlpPoLQRtkfR6CijRaxrfdlvKv5?=
 =?us-ascii?Q?2/nVBCPUZdlSyM/h/WEUjgzI8LQ8ivi07sVUIWmCQflCQqStexTXWZc+0erq?=
 =?us-ascii?Q?kkDBdni0dqfvAIwQIwtY/QKb6ytNqqcK0kL+4V2kggfJ/GcCnTFAK0t3gLcp?=
 =?us-ascii?Q?u8EmAZD+q9KJRsQkXa73X5NVfxzojOebO0ZVR2UuRdYEXfPX8f3NzA4Baze5?=
 =?us-ascii?Q?Y751h59pOYqYpak9B5mpvzlvGAvX8mjoA7i4tB0RtRU972HEOKSbNR1OskxY?=
 =?us-ascii?Q?9o7WJqiwZfOgcYbGX1WcQLSkUuC5hhmMqB4nTBuYN/FSdVKoqe7DJa+kbkpZ?=
 =?us-ascii?Q?0Wh63ewgdWAAo9RQn/w+QF2DwIE31GGuIdPlptE9pXvgXcESTFm9/kacZPZO?=
 =?us-ascii?Q?SGsSKRc5XxCsJX8zPs03T6GY0dKBs/BsWIxu7RrEMsV/dTpQoraSjDbdaC4c?=
 =?us-ascii?Q?tuIvNFR5NXkUCVm0eP4o0sOBmhzoSVQcQK3ZL3ZthDQOvdCcZmW5f3Vu4XQf?=
 =?us-ascii?Q?MgSXwiFIQEjJmhCtbkVGS8EIxRI7C9/3LLQAk8opxnCiwHwxooM3RXr2ExVw?=
 =?us-ascii?Q?OMtGvos/OFVLM3NNIxmSh/Xae53oaMlP8trLqcm+xIvXhJ5cYk8YAP8INc+9?=
 =?us-ascii?Q?noP/pMXnpi2A6/+m4rBewJVNeLCN2mUwCE06MrXVmlLwEx8HAdYnt63pZM6T?=
 =?us-ascii?Q?KbHFZTZJudTe9QFAqDdxF9PWnRTHytzEbV7pyz6/+q6izR8wrB8cxwlUo9Vs?=
 =?us-ascii?Q?aHeSMxPQZyhRaw8aH1sCirS9/baxBfwIFE2BqwSdjw3S1fDbk9DQE6GVcxxd?=
 =?us-ascii?Q?zhOFyI5DMhOp2KkSHcJnNPZrXO+HayVknAmDe3GhdfOpKzv7HbVSuZfajxOZ?=
 =?us-ascii?Q?uJ+04k0UQPuGJ1j0E3xL8GuNCdoHyxHKdJVRqkpx8Ep7GZr0nbn9YH3OGveL?=
 =?us-ascii?Q?Wo6jVtPC6r7hyHFAe783I0jz8iYU8EnBauJguuMoAHkSrEplkXebjiY+SVfv?=
 =?us-ascii?Q?t6cgJzXDtbYqQLeVpXxDZ9QFTuRTf2Bthw1NJjfmSRb3MxObVU2n73K61//W?=
 =?us-ascii?Q?Gmo6dmzH6IdXMYxX0e+udKZJoV979mBDH0Zoryrg8Rm0yk+D50ZE8EvkRYht?=
 =?us-ascii?Q?dVZ0wC2QGudgRjz/96CXIpvUFzQaFS/q+CsT7jnc/R+hiGVmqW2SGCkurAEa?=
 =?us-ascii?Q?FHTYcYgmVUMdynoBiqAjTmKgbw9uH/CPqlIH5mX3n22aNzXK5WJD9qkfPL5x?=
 =?us-ascii?Q?5rhC12HJdg=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8adf86-98c6-4ffa-4df2-08dee9aa03eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:35:55.4431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOtoPduqsjDrY3H0pGgNbKbiW4AEsZZvZW+RyxsUh7yCNZNBZ+g3cSgETOLo2Efy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
X-Mailman-Approved-At: Fri, 24 Jul 2026 18:04:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pa.msu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRiVUCteOy2fnTODMY90m8FPML1EkQx0iGJ/VMITAGY=;
 b=zp1KhgmX3Z/EQeuTfAZJAJIIdmbWRrMx1EGTL3bULFx8Sm747eLRt8/NHN8nzzm7n0wglBfGdPam2vu5I+C2LpqHZkv729hlMAgILNzgtH7ebImZnbS7uOEZDuPMho1+0dC8TNISPlFkWwg0tVjNDt7y2gZb3cehDLWXqTavlnLLOCi74W8eq5USyw1yh0xFxmYi8hMeC90k0UVkffpv+91dk2nY8JBOe9eyMFUB7VM+wcJRDMRnUbRO5EBSfoR1xFckKrNah9WigQFGgqW6lDWhWyq6kGeEoErDQAioEPK2tm1jLfN/cbVB8rZSohxY5DMCu6FovP61sM3O/tBqZA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pa.msu.edu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=zp1KhgmX
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When working with systems with multiple FPGA firmwares, it is sometimes
useful to be able to use the same U-Boot and script conditional behavior
based on the FPGA firmware ID and version number. This, allows, for
example, flashing new FPGA images without flashing the bootloader and
letting U-Boot and the Linux kernel adapt appropriately.

This does three things with the information:
1. Prints the FPGA design ID and version to the console as part of U-Boot
   startup, which is helpful to a human working with the board.
2. Stores the same information, plus the already-acquired FPGA serial
   number, in a new set of environment variables (pf_serial_number,
   pf_design_id, pf_design_ver [the version], and pf_design_backl
   [minimum-version backlevel]). These can be used in a U-Boot script to
   load different kernels, device trees, etc. depending on the currently
   installed firmware, which allows U-Boot and the kernel to adapt
   cleanly to FPGA firmware updates that change accessible peripherals
   etc.
3. Stores the same information in the device tree (under /soc) as
   fpga-design-version, fpga-design, and fpga-design-version-backlevel.
   These things are also available through the Linux system-controller
   driver directly, but it is handy to have them in the device tree as
   well.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
---
 board/microchip/mpfs_generic/mpfs_generic.c | 31 ++++++++++++
 drivers/misc/mpfs_syscontroller.c           | 52 +++++++++++++++++++++
 include/mpfs-mailbox.h                      |  1 +
 3 files changed, 84 insertions(+)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index f57f5f4046b..469e914e083 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -114,7 +114,10 @@ int board_late_init(void)
 {
 	u32 ret;
 	int node;
+	int idx;
 	u8 device_serial_number[16] = {0};
+	char serialstring[33], designid[33];
+	u16 designver, designbacklevel;
 	void *blob = (void *)gd->fdt_blob;
 	struct udevice *dev;
 	struct mpfs_sys_serv *sys_serv_priv;
@@ -144,6 +147,24 @@ int board_late_init(void)
 		return -EINVAL;
 	}
 
+	/* Store design info and serial number in environment */
+	ret = mpfs_syscontroller_read_design_info(sys_serv_priv, designid, &designver, &designbacklevel);
+	if (ret) {
+		printf("Cannot read device design information\n");
+		return -EINVAL;
+	}
+	designid[32] = 0;
+	for (idx = 0; idx < 16; idx++)
+		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
+	env_set("pf_serial_number", serialstring);
+	env_set("pf_design_id", designid);
+	env_set_ulong("pf_design_ver", designver);
+	env_set_ulong("pf_design_backl", designbacklevel);
+
+	printf("FPGA Design name: %s\n", designid);
+	printf("FPGA Serial: %s\n", serialstring);
+	printf("Design version number %d (backlevel %d)\n", designver, designbacklevel);
+
 	/* Update MAC address with device serial number */
 	mac_addr[0] = 0x00;
 	mac_addr[1] = 0x04;
@@ -182,6 +203,16 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u32 ret;
 	int node;
 
+	node = fdt_path_offset(blob, "/soc");
+	if (node >= 0) {
+		if (env_get("pf_design_ver") != NULL)
+			fdt_setprop(blob, node, "fpga-design-version", env_get("pf_design_ver"), strlen(env_get("pf_design_id")) + 1);
+		if (env_get("pf_design_backl") != NULL)
+			fdt_setprop(blob, node, "fpga-design-version-backlevel", env_get("pf_design_backl"), strlen(env_get("pf_design_backl")) + 1);
+		if (env_get("pf_design_id") != NULL)
+			fdt_setprop(blob, node, "fpga-design", env_get("pf_design_id"), strlen(env_get("pf_design_id")) + 1);
+	}
+
 	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
 	if (node >= 0) {
 		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index f608d5518b0..ef03ce7b262 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -129,6 +129,58 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 }
 EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
 
+/**
+ * mpfs_syscontroller_read_sernum() - Use system service to read the device serial number
+ * @sys_serv_priv:	system service private data
+ * @device_serial_number:	device serial number
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv, u8 *designid, u16 *designver, u16 *backlevel)
+{
+	unsigned long timeoutsecs = 300;
+	u8 data[36];
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)data,
+		.resp_size = sizeof(data)};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = 2,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
+		return ret;
+	}
+
+	/* Receive the response */
+	ret = mbox_recv(&sys_serv_priv->sys_controller->chan, &msg, timeoutsecs);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg.response->resp_status);
+		return ret;
+	}
+
+	debug("%s: Read successful %s\n",
+	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
+
+	if (designid != NULL)
+		memcpy(designid, &data[2], 30);
+	if (designver != NULL)
+		memcpy(designver, &data[32], 2);
+	if (backlevel != NULL)
+		memcpy(backlevel, &data[34], 2);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
+
 static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
 {
 	int ret;
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
index c0ff327a4ce..5c1ade3e918 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -59,6 +59,7 @@ struct mpfs_sys_serv {
 
 int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv, u8 *designid, u16 *designver, u16 *backlevel);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
 
-- 
2.34.1

