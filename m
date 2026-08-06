Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02833C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9397540903;
	Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLkVdtb71kwW; Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04ED54090C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059893;
	bh=mZp3qlzod7utZXbfE1dfsn3VwTLsJjVOkos5fWYKVbI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0eScUFdFjdzYwnT3tnEKWDtGqhCiflZEo2usmlZk/REZZ9jvE6g0z/LUwXPbGzei5
	 cKP7toWiZgor3LYHhlZ+Zc68kz7ECbp0qTuvoqXjPTV1uT7apaa/2fW3YdTmAiZwxR
	 TmOx0uAxiKmdQGTHM11SbpduQT+qN8FBJ13oCcDpL5jft9QemFDjOc9BxUat4QeR2K
	 sjJoxjHQYiBDLipYCePtxDhB06Azan2rwri/hvknWRRECUhaiSNg36a8+mW5Jr7tLs
	 ljrFPOBFYVzkjjCE2udDaRojudAKbPbmDLENXgyU3JePjnvFFLPoh9BUbzIo0fHrk2
	 nMLB4IzfgWq0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04ED54090C;
	Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FBA6218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D9074090A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMXX_JrV3wwD for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C3F5E40903
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3F5E40903
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3F5E40903
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtqjngAiyKBtIy4dV+UNUnIDHRoBq/rcNIrn3TbmugTTozxEac/vsFDjqg3/eSe7pU9eo4Zy+ABmkJLlyVAf+WS1SIuwdmkFA2JSR6yKmvxaXUMT2Mri+xANBokf7kaYUh4eDSwqYWB487J24XYb3XFMrtKb02BrNI195cgZzy0Wn8wcWojnaxGu+RyhFTqWrVdQj60VBrEZdVV7XPcjeZKfZYVMLHWGzSGqWW0puXYcAHN1pyOX4RRn70ShjPB75GQGl2mNNbBnvJ8aLb/6/a2zBcznxr8jdTdjGuMVMOK4QBwR1QgZXWXvQuyLh6dcpEKi3KXmltVHTgJyo7Mjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZp3qlzod7utZXbfE1dfsn3VwTLsJjVOkos5fWYKVbI=;
 b=dMth3yP3wjDD/FsY9+Bwrvb+AE1gCfAlIZwzzkOMthj/ekTRGkUkjcYCqfGYzmRHKODqzG77AC7g72cIr5XZX1wNKvpYXOxkvIyUmeinSWsyPfy5RXWnuG7V/nti3KOafSALrcN2aqyA0oNZ3DTEThvNBzvRz/Zx66zTA9vUvSTiKVKSlOhhD63BkGKvREV4a0VU1ep2fCKqX55wTIk9GMjvv8FKfIqJMCo4uuvp9K9JBolnnFjJ40PJ2fzHKqFvqSNQ1bjK9NYfztgOF2QxyMXzFOiwPcdSbei3uvDAGQ5o6lvJOJgBiYUQC0zMPcO2kYEtV/lSrAaV6Y27hTLnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:41 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:40 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 01/16] airoha: add support for Airoha AN7583 SoC
Date: Fri,  7 Aug 2026 02:44:17 +0300
Message-ID: <20260806234432.4098414-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: eea5428e-369b-436f-7489-08def414af19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: mPDN6FyBYTRZjxRqyHwZleX3mIME6o9zn/kbccDJ/YEc/CEz9D0UdgY27eo35B8UWVoNmFDvH/0OooG3iYGgdaWeT0gvgPJnZdKEfymXUrpPMPTo/HuKiYvkL2TxZqvgVybDuIvOAPZwp+YDl/k7qfZKcAFPAXR7O+EZ4CUecQw6/pIe4+K8Ek9L+ddsdYO/GqddyxDD24M6x/ObCiDLekdHHWHjczyqXk8y257CLy7lKrSMRx2WFyUu5zU98FmZ4aRU6DEHelL95M3puBjNok/C0OuXPz0XbBP14dbdOvoXi58IvLwFcDS73VuRomLcGEVyMQLHOtO99AxRBIyZCUDTY8qXNxDHKx88DoBsU4ogsuOwLY5iAHo4TvGN1UKDylWLGbPdTC7pa7azFh7vl+n2rEejI/LIj3AAVadhgGjru5Ic+s/6Kjk5BOmMVJF3XyZKiSeaaLplIBY1IDMHWs8005eVMidFxdTI3okSUUjD9WZPEBOkESo/ZKZtt8hQSwyve/iYduJfaPfpODhYAzLtXsW+mBj8u89q+rFfVdKhsbnpEmKwiixLGkuVBfcopf8sP8chFdxSSofTlyIqRNAMRTscz3JUXfMlKfUY1yFYMhxlsB0jUpuOrxOH1E6X1/6xeEWLv/cQrPu5UZq9I6WiQH6J/YTBsFugrR6AXKAbA47oOY7OtqglG6oXheRs34zTZnIVtbGQlhsVqocpZyuA/FzzPuV/xCPBX97Aa2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+bggoMQeyPUVPcmb/37zx2GXjpNLVBeK6HoJ0evWSqActWwjy3i6zNShy5q?=
 =?us-ascii?Q?+MzZQVDILJM+spcOitOX4+t4EMbuyigJEDlrFWt22ZF5js7wOqkIuMhpaR/4?=
 =?us-ascii?Q?Pfqhus9v6YT7DR7x0j20Japp2tHqhFinVSk4DFrYcLgyU9Mh5axwXJgV8/8v?=
 =?us-ascii?Q?tc8i7Vjegfdj82TEJOoS9MGBzMcCS9Z54iTQR1EYBTygWbUSGPiaw7P4jL9i?=
 =?us-ascii?Q?QBUhOtBol6+Ng8JPgHcKk+FfrNynyIIAvYAIm3i0UbhnkDnGYi7VOr/CeBJi?=
 =?us-ascii?Q?zo0i21Z1DqQsyXUOgh2Hnf23cHCE/eV0t6nL4W6C/8FR3PjrCefpcxwrKoWS?=
 =?us-ascii?Q?ZzHITasGcF8CzSTCME29CbgeXUokrfOFK/J7bLX0WJsrKxSfyklU6KS0yCsy?=
 =?us-ascii?Q?YmKf50KNdOzxc9JJLXE8p3LU7eK9xJ6/4EVylTr+GwveG1fCZ16YEWl+N85r?=
 =?us-ascii?Q?U4tmHD2uGfXt9c8OtIO75WE1NMs1k93lW9IJTJt4+fv1C20gziO955SdyZEe?=
 =?us-ascii?Q?YgTtALg0+okN2JuzL24lsH2ZjPkyNm6RKYvXGVxjwpAtjx27RmyZUSmeUHMF?=
 =?us-ascii?Q?uTqpQT6u26biFeM0gTsZvuawx2XrhcQBlkWd8vbTmDWI/EhDhmAbom3jfU9b?=
 =?us-ascii?Q?nnxqJACJ0DzNpe+lHptLMDLs5hAbUXUxPx1r1uE3Lp/VNIX9wF8WxgK7kTe+?=
 =?us-ascii?Q?QfhNRV0S6cC4/Yy5vTzgxb71natwIPqS2ED3STZoS40PsbOfUpHe2r4wyAJ/?=
 =?us-ascii?Q?d6mY7nDEp4Ab1h4aqUZEqetBeHIjLm4vhJzRX5mB96m3bGqiL36PPvA+EYiT?=
 =?us-ascii?Q?1KRXdpwkWtKMGvym4vtkoaOhFMw20r6NefY7QJ/X5Tlpkadk/L+5uu84VOH7?=
 =?us-ascii?Q?Tt8iT9ARPcE+8LB5iE6y7UeEL1lzOOe8HGEDL6tXyR7wiEfp2Oqsdt/NBWwb?=
 =?us-ascii?Q?yF5dvpGDNWat9tb28gmBzKxGvGrnbbGfxctrcY2RXRySIeABdix4p5aLfzCh?=
 =?us-ascii?Q?3mcBbQaOTF7hjoFih+MUFer38GxgXtx2C3zoa97lQSA85eebfFHuGO0TPQ0b?=
 =?us-ascii?Q?5LJh/EsD2Xn4cxvu2aQWYxzXQE0+D7qjCqNPmu1GHUhej2o906JsPSJ0baQc?=
 =?us-ascii?Q?/dFbI6og2Po/Cz3ubv7+ouKGiRr2Sihj915ZUa+ByJ2X/MFNvhiyphk8u6vr?=
 =?us-ascii?Q?mYos3FotyXMBPyvdLdwomV8D8O6V6+nhlk42b88nKSHwYJTcyhCb1HeBxjX4?=
 =?us-ascii?Q?mJAjK/NkaFYEyxD0w/c/6NxLKm7kbBQ7oqIJ73E6FQLmvFJSGRWfbjwxu/gE?=
 =?us-ascii?Q?1IapfuCnLwpoUgTP2hGN3ITIObTp8SDFlKFagQJpSz9DMLHHOKWk0KChGmeb?=
 =?us-ascii?Q?UFoLnp5DaooF8Ij7o+KyzeFGe2HAL3K4yxKGiRCd5xWtIGoUAlBH+zQy7aJP?=
 =?us-ascii?Q?6C1CMoQbfNiB5lwONS9P7PSi/beCFdxsv0ekp42FFxJcjuD56hO0KOtLiO4m?=
 =?us-ascii?Q?CbYHZkOPo69FdvdiPI5ZlGqCLwiTU4PRJRsziFjCtAilG9/N46pmCesIYdNL?=
 =?us-ascii?Q?CCy1RrnAf/wc6pf9gNJD68e5VPVYb/06QnDUesRJhnT3Wn88GPw8IHcO0U1M?=
 =?us-ascii?Q?i4mtS/667LnUGIWxK7fj2EdiRuhvJa13MVan5onWfpZOi05/oFnbTVnUQ7JH?=
 =?us-ascii?Q?VCnCV8RbCUaW3dR+ULi8ndGi/KwBCiV3GMNiez1ztK4bgp4BAKTaFYvqzOV1?=
 =?us-ascii?Q?Dh8zs40pi8qXje33q27fB118LuKr2sw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eea5428e-369b-436f-7489-08def414af19
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:40.9099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CjHFpMXVjQy1auEGsjXKTYgFsMnd/DaHkjmMhbAj4OXMRnKh2z3ZMT99ip0MwKWPOZpkYNJZlXYntpfff4VI6EEmD7aDaR3sUdLtjfSNWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZp3qlzod7utZXbfE1dfsn3VwTLsJjVOkos5fWYKVbI=;
 b=YS0++t7eonlzXEa2OJrdIeFq9G0AvB29jF8KP33r84aHoxsobXjkbkAXz8c+rvDyr/LS7a5d4gQ6ClX8F5I2cWFSjG9xAq1G0Yse0pwJfpZnSRRvhzFcXBdOOwA5muZCjCid97r0eZEl5FxLLYQ6Dih2mbpTmkCwv8WJUjEmT7bbTrlipN697K0at7qYZYRw0SgRHvFY3oJYLu22DdB7lBNoCvra7Eoyu6Ue1QDp5T+Djb6BR9APboJMyXMgEUOjWX16XkBwcwt7eQHflqHrBEP0P5+4mUlXlOXhz8VgZ7lCEpZtII0AHfECz5IUg5P06+6VCBhmTLNlSSAnI0yaqQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=YS0++t7e
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
entry for the SoC, DTSI and initial config for it. Also add the code for
CPU and RAM initialization. Everything is mostly based on AN7581 that
share lots of common piece.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts          |  67 +++++
 arch/arm/dts/an7583.dtsi             | 387 +++++++++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig         |  14 +
 arch/arm/mach-airoha/Makefile        |   1 +
 arch/arm/mach-airoha/an7583/Makefile |   3 +
 arch/arm/mach-airoha/an7583/init.c   |  66 +++++
 board/airoha/an7583/MAINTAINERS      |   5 +
 board/airoha/an7583/Makefile         |   3 +
 board/airoha/an7583/an7583_rfb.c     |  16 ++
 configs/an7583_evb_defconfig         |  79 ++++++
 include/configs/an7583.h             |  19 ++
 11 files changed, 660 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 include/configs/an7583.h

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
new file mode 100644
index 00000000000..d02cd194e8a
--- /dev/null
+++ b/arch/arm/dts/an7583-evb.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x200000;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "an7583.dtsi"
+
+/ {
+	model = "Airoha AN7583 Evaluation Board";
+	compatible = "airoha,an7583-evb", "airoha,an7583", "airoha,en7583";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+		stdout-path = "serial0:115200n8";
+		linux,usable-memory-range = <0x0 0x80200000 0x0 0x1fe00000>;
+	};
+
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
+
+&an7583_pinctrl {
+	pcie0_rst_pins: pcie0-rst-pins {
+		conf {
+			pins = "pcie_reset0";
+			drive-open-drain = <1>;
+		};
+	};
+
+	pcie1_rst_pins: pcie1-rst-pins {
+		conf {
+			pins = "pcie_reset1";
+			drive-open-drain = <1>;
+		};
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_rst_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_rst_pins>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&snfi {
+	status = "okay";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
new file mode 100644
index 00000000000..9362d2fbedf
--- /dev/null
+++ b/arch/arm/dts/an7583.dtsi
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x40000>;
+		};
+
+		npu-binary@84000000 {
+			no-map;
+			reg = <0x0 0x84000000 0x0 0xa00000>;
+		};
+
+		npu-flag@84b0000 {
+			no-map;
+			reg = <0x0 0x84b00000 0x0 0x100000>;
+		};
+
+		npu-pkt@85000000 {
+			no-map;
+			reg = <0x0 0x85000000 0x0 0x1a00000>;
+		};
+
+		npu-phyaddr@86b00000 {
+			no-map;
+			reg = <0x0 0x86b00000 0x0 0x100000>;
+		};
+
+		npu-rxdesc@86d00000 {
+			no-map;
+			reg = <0x0 0x86d00000 0x0 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@9000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x09000000 0x0 0x20000>,
+			      <0x0 0x09080000 0x0 0x80000>,
+			      <0x0 0x09400000 0x0 0x2000>,
+			      <0x0 0x09500000 0x0 0x2000>,
+			      <0x0 0x09600000 0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+
+		syscon@1fbe3400 {
+			compatible = "airoha,en7581-pbus-csr", "syscon";
+			reg = <0x0 0x1fbe3400 0x0 0xff>;
+		};
+
+		system-controller@1fb00000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fb00000 0x0 0x970>;
+
+			scuclk: scuclk {
+				compatible = "airoha,an7583-scu";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			mdio_0: mdio-0 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO0>;
+
+				airoha,bus-id = <0>;
+			};
+
+			mdio_1: mdio-1 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO1>;
+
+				airoha,bus-id = <1>;
+			};
+		};
+
+		system-controller@1fbf0200 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fbf0200 0x0 0xc0>;
+
+			an7583_pinctrl: pinctrl {
+				compatible = "airoha,an7583-pinctrl";
+
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
+		i2cclock: i2cclock@0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+
+			/* 20 MHz */
+			clock-frequency = <20000000>;
+		};
+
+		i2c0: i2c0@1fbf8000 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8000 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		i2c1: i2c1@1fbf8100 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8100 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		uart1: serial@1fbf0000 {
+			compatible = "ns16550";
+			reg = <0x0 0x1fbf0000 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1843200>;
+			bootph-all;
+		};
+
+		uart2: serial@1fbf0300 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0300 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		hsuart3: serial@1fbe1000 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbe1000 0x0 0x40>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart4: serial@1fbf0600 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0600 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart5: serial@1fbf0700 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0700 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		pciephy: phy@1fa5a000 {
+			compatible = "airoha,en7581-pcie-phy";
+			reg = <0x0 0x1fa5a000 0x0 0xfff>,
+			      <0x0 0x1fa5b000 0x0 0xfff>,
+			      <0x0 0x1fa5c000 0x0 0xfff>,
+			      <0x0 0x1fc10044 0x0 0x4>,
+			      <0x0 0x1fc30044 0x0 0x4>,
+			      <0x0 0x1fc15030 0x0 0x104>;
+			reg-names = "csr-2l", "pma0", "pma1",
+				    "p0-xr-dtime", "p1-xr-dtime",
+				    "rx-aeq";
+			#phy-cells = <0>;
+		};
+
+		pcie0: pcie@1fc00000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fc20000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1fc20000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fa92000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index 4b0374001d0..72cd1454208 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -29,19 +29,33 @@ config TARGET_AN7581
 	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
 	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
 
+config TARGET_AN7583
+	bool "Airoha AN7583 SoC"
+	select ARM64
+	help
+	  The Airoha AN7583 is a ARM-based SoC with a quad-core Cortex-A7
+	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
+	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
+	  video interfaces supporting HDMI and MIPI, and video codec support.
+	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
+	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
+
 endchoice
 
 config SYS_SOC
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_BOARD
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_CONFIG_NAME
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 endif
 
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 91395b8a850..51d82ea3e21 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -4,3 +4,4 @@ obj-y	+= cpu.o
 
 obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
+obj-$(CONFIG_TARGET_AN7583) += an7583/
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
new file mode 100644
index 00000000000..4cf7f8caf85
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/init.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+#include <sysreset.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha AN7583\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+
+	if (gd->ram_size > SZ_2G) {
+		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
+		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+static struct mm_region an7583_mem_map[] = {
+	{
+		/* DDR, 32-bit area */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = SZ_4G + SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+	}
+};
+struct mm_region *mem_map = an7583_mem_map;
diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTAINERS
new file mode 100644
index 00000000000..71ee542a8bc
--- /dev/null
+++ b/board/airoha/an7583/MAINTAINERS
@@ -0,0 +1,5 @@
+AN7581
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+N:      airoha
+N:      an7583
diff --git a/board/airoha/an7583/Makefile b/board/airoha/an7583/Makefile
new file mode 100644
index 00000000000..d582684d1f7
--- /dev/null
+++ b/board/airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= an7583_rfb.o
diff --git a/board/airoha/an7583/an7583_rfb.c b/board/airoha/an7583/an7583_rfb.c
new file mode 100644
index 00000000000..aa73679d929
--- /dev/null
+++ b/board/airoha/an7583/an7583_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
new file mode 100644
index 00000000000..16466be51b2
--- /dev/null
+++ b/configs/an7583_evb_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7583=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="an7583-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="an7583-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AIROHA_AN7583=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/an7583.h b/include/configs/an7583.h
new file mode 100644
index 00000000000..c865afea1a2
--- /dev/null
+++ b/include/configs/an7583.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha AN7583
+ */
+
+#ifndef __AN7583_H
+#define __AN7583_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.53.0

