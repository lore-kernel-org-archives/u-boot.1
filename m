Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F4606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZhE9BYmd;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Lcx1XxiM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326A14077F;
	Wed, 21 Oct 2026 09:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_wKzg2ruvwt; Wed, 21 Oct 2026 09:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 430D640728
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576785;
	b=FcK5IS01sFrmaAQnsgNCs3SiMnea2153YSCYi6v33oWMkvmxNl1VNpeB5O378THUGWZq
	 udrmb5tTXQ2aNsCfxB1hvfi4w+vT4Ooa6quWM9qdGsw/ZEU732syg2m3YWNkuUzqC84dw
	 GkMY8qVSlodTqpM3nsB4S+TfXSxx93dlif88k/YHOOs8jIpU0LWIjWIwKXdQpyRp8eEWQ
	 13vlpafnsmpXk2aXtVzHVOGZYBRaVk/jkEcQAtUe0VLgfpyJWtOpvRxdw+un4JQWq8cEv
	 URnGv2wzYIW06C7eQryxvOCt0l8SWglMkBCmGcla1mahkAWZtxMEsw9c2drx/o52ehA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M4UqnHFnvWigFY5MeT6IaogHQwUfzsSvbYbOw9VwQZ4=;
	b=pm/ZDeUF8mBd5T46nI7M+gsPcZLQ6E9zISV1qHTOEZXWrVMjhW1FTuG3s8NjXTOLN+SK
	 eONBLYBevWGhYYsnmMosod2qwGaLW2SRD1HxW0y8TOwZWDa0lKWU9w/uim0cm7iBlknaN
	 JrA97fgT7GBy6ZaNZzS/Bypm6lfmyQQ75+nRnKCIR/kJN91tg7IQfKVMu+fl4J0bh0O7T
	 4QfQeKifOupH9DHsLkcsguBCDfSDaA7Uq+jfT92Ua8hbDppQPtb0Ua7Q/acoIBGjtEUtA
	 1L6gAWTpxDrc0sXSnOrCY22hBk4XUmdn3IGo2HJYB+b6dFanaGIZN/Y5j+a2ITRBnXg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576785;
	bh=M4UqnHFnvWigFY5MeT6IaogHQwUfzsSvbYbOw9VwQZ4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZhE9BYmdNAC3RgBsadkfB14SdrrQ60iJAXFdt3kP6TjeZJN5V2XdQpUuoy8XprGCl
	 e4wJ5BoA0KGUMwXhqsRjNij+CCYOaKOE+gAzQTE+IEn5D/7rQCX2pfI5KC4b6R3pGO
	 hmh/ZsJ9x4Bv3VkXltnToHEb0YMK3Z4whmGQbHgnA99zFL4RiWo7hjTfon5w2e8cY0
	 ZZv1s8K75mKslPTxp/6bJA0Qri/l0OGyJbla2PZZ1zwu2Y2B4laAr1QLpnYk+xukbq
	 k7E6qCSAeCYCVUV73uTvoHioXkwa5uGin0r310PzaV1db47k1VKG1eCjAHw5BPdTPE
	 lx8E36kps8cBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 430D640728;
	Wed, 21 Oct 2026 09:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4467B1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A1B76070D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPe0nZstKKJt for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ADC65606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576782;
 b=jyHC7kj7x9FTEqYqbfzIS3O7FK3C7r9Z5vUT1HGb+AfomHcZCBu6YQ9367wsmHYV5k08
 VvZRZxSNBjLvf/GMEekHsgBKtsmusdIpS+MAvmzq/C2w25CD4MfsxfF5I5XwVhjOKvroN
 uLoEuOdKSO7eLPbWk1npW9dJ+41fkHh+tPdZkmfKlDjdO2b3POaMC3Q1hJVFxU4BGioHv
 K+P15hW2+QSvkY7HoYyOLkjdtXMqone6BiEy7uCELX8tkLpuv6YZLwDgIkzB+9FELXDP8
 hhcixS92NNcnbw5sj8rzX+jVGp8SXjowfvtscBdan0A75A1C+DC+sbgLAlj2iu+GcWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576782;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=M4UqnHFnvWigFY5MeT6IaogHQwUfzsSvbYbOw9VwQZ4=;
 b=KuS9SWBbGY7kguSZTwx/MnRpgfnLFsOfbx4Exsm+uKTYVJbXxedZnvrplTCR3V4HAR57
 QQRaMSZsP16f9eJ+bZjECP5ZYmtPv4ePp7rZ/6lghD80aGo2cY83cXUSjDMiKYMb+S7gJ
 foXtRLduKoVZl7rlU7TIEdi8Mc7AeB90CWSiX0wIXyLRJqzNHV5KVQkZj5lAzdU6Deqeo
 3FaLIn0H3FIvUG5hPmq1U41VRcm8s2A9jv44WCYumYBt0FhPpizsmk+ZOzHRsipbKAnrD
 WK4F9wds9CVG1ZzMVRCX7FAXBRNw82AY4iraL/vHD1NiUdkcIlBtH5ycsn8Gw2rrFJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Lcx1XxiM;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Lcx1XxiM
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADC65606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsNuZJbghtlR8BL8rB4J1Gr6oMcSGkqmqgzQxFgKCV8gaRnSoc1zqshPBPUt7f/jth178Yw7Q49n8eqwEaAZtQzDL0ND9w8RDYhWF/M3D/hdIBh08jDPbOunpaZDPS5Zab4n8rDy8De5f/8aT23ljLPlBz0806yn6udms50ZbAnyuqc6zhqQ5nJxxrOh9dO2C66f2JcnKPH4BFZcRTB9Ce7S4HqpJKSvGhjEbVb9CtbRmAWSx0O4AoRBr9L6y0GSw/ea+/r928iP9lEfWT/XPGl0xRT536VWG5X0NH8wBq3O16Msq+6gr3GyReC1zLnzV27o+KO8DPYY/qWjhL9Csg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4UqnHFnvWigFY5MeT6IaogHQwUfzsSvbYbOw9VwQZ4=;
 b=LN/TlaZxYvHSALkfMN5RCLE2eYi4PKGmbzGx2061HofoaKVkVlotOp+Fb/1OXJUoYNxmIP0TPlB57zf+MbewTC41McVWbAr4UMZRvkrUxVLnNDRjMBcnMgmrJcpG+o+MzW1g0Ymkoqrv3GcvX99jkh8sJRs/qqg3Mp/Uz7tqLnfRHQ+u3+/2OGniuyar7aQzswWWsjZOSoM/rR8KnHUufea6ekWk1E5VwNiyAelUY8aYsJmwSSV2IZLhsG3tMRFdLSK2BPPSW+yB7bsdivDW4z75yXNdv0a78ONuurMYF01Gxu+iAMSf2PBKXzmdBDuxupYseQaN4aUr6S2/LZzomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4UqnHFnvWigFY5MeT6IaogHQwUfzsSvbYbOw9VwQZ4=;
 b=Lcx1XxiM9LgMI9wzsMPNvLfTr5p4TpQR6l1KSZCq60glx8Kyq74nflWsXdZfZnApZrl1gCLmz/8wqEztIMRv4eACTNfjVrZ6iaaeGqH5h8DTlvO5X++UNFqv/jvn3pPiPJQefiKyRhBvdOPQmm+M4Q2EGTq9auY1hGV6PhWntgtslKmckZgmNhYaR1CCVVkqOFWI12tYdmTsO6/v3Yh4pmz325vNohOe3ZNTHvAEAf7c2prHwrE5lzZQZ7Ow3peWC9xPMJMQy9w7Y+R4BR3q5anW5XPhoOYsz6I7ChoTb1OAXeK+xymaC6wWspNzfADEm63yTtmbmnIVKoeCDbeQnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA1PR04MB10769.eurprd04.prod.outlook.com (2603:10a6:102:488::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:59:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:59:30 +0000
Date: Wed, 21 Oct 2026 17:56:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, kabel@kernel.org,
 lucas.liu@siengine.com, u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull mmc-for-2027-01-rc1
Message-ID: <atiMW0B30H2AmHtS@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0267.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA1PR04MB10769:EE_
X-MS-Office365-Filtering-Correlation-Id: 26612550-2244-420b-e335-08df2f59ffc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|376014|1800799024|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: FDSRu1goJpCYJCZXrohnpC8IbQ9UCJfamFJDIX4pl2GCn4w+6ydOGmiaeo2ByYkp3NQ8U2IuHDi7SDc7hOvwiZJegamcou7pexGH7xdGg7/k3ESPCHa9NW3YgXobsksy5NPKxsY1KjeC5xKQznQ2PAX8qgtBQfm2q2TeK+ICm5qRM5JF+NMar2i+h/qJeyI8QPUxv7PfSOaayuHB0Ocks/DsXJn+YyOOyfe0ivVNes8geAl8ImomkWQ5xgf/Zdcul+T1RQ8ebh3Y2KggPwN8DvTLhulFOVN17cjTp57KGrpqLXy3N5CZEiTaKYbytQWCs/s5cGE6z744RddW0reSB+fgF0aMFiZjFmVFci+tL43lLMUFT42r3TWT5lrJThqh0Y1JXtFgSai61Y9B1L9gB0fngBEmIOomeTRcZp0w+nYh1RXdM9u7rPw69oUkF+LgpxlCgCQXWsRtCmq4nqz6eRWwBQJQJ3sUSrdR5rl4MA8rXC1meSAF7gn8FJ+sDlovzD6fKGhKeTKljnlurmGhddZo0Ut15i8K4nVs2CcFkSNFKTa95VZaMXeUNV0pNbyNgt+Ro4RZb94vDPEB4XrO2H5Mvra6nOBsyREnyfFSsNmFnbJUVTUpxyRiKwKxADF8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwMOT1NJAwwSpghaHMK5NDqL4GusiCIRCz2HkcBOd30aslei4ddliGPk1auR?=
 =?us-ascii?Q?V9wkgurJB4cP02QCn6lqw5SvXkh9JMeSg7swhVvmEoaOp/XNMmZ20+9aFEcm?=
 =?us-ascii?Q?/cNmeGqdxVuMuQMBLYENqh4Iuxwph07GR//QTBO/9xTC8oygfIeG9ht1vtZd?=
 =?us-ascii?Q?9iwcFclK9m27GgxqrAgrDmC4u2+f04FnSc9NrP4gAMOgr+eafQgpuDLLfq3W?=
 =?us-ascii?Q?allV9L1aP24UVt41UBRM9HvDNedVkXRBn5OCcl9QE7rnp90NPSRSlZr6noMV?=
 =?us-ascii?Q?MB/Z/cn4PzKmwXqLEQTuT99Gxa4xoSvYKRJdjmT6WAALbm/iWKGi+ljkhpoQ?=
 =?us-ascii?Q?3FOXHToh69BnC1cpUwsMe+8KXw7SxlQ2uWghL9HXxUUm4jsL5bPq31Xok1nh?=
 =?us-ascii?Q?yyT/yovbMtrVZ4aayBO1t5aJt2Sjj6omK8ton4t/BH08sKPvlXCr9E+MYaKi?=
 =?us-ascii?Q?95YzefXmpFBg/D+iKRMgBdR0lsBmlvgG9mfjraapdv/OlKgyHxy9stSlw6nE?=
 =?us-ascii?Q?TIiyEkiJHN2OXXadhcaRDUaXUisIpBXooMogr7luMZG9IJy4Y1ozDV4Ax/HU?=
 =?us-ascii?Q?MaRhPBCjABps9VA8rpJokCkE2/ivYKyT6NAmZ8xxfpAcYCp8HyEScNDpVhh3?=
 =?us-ascii?Q?DFR+oLNGBi4ozhya2dkp06cBvTw1gWHCSOGR2/FhVe7eTyPRdOpJtxahsNHO?=
 =?us-ascii?Q?zhg7nipUvO/WexE4WbQ1a89RA4dddPyGSHip72WD0i4TewLS/OZgBH7GM9vI?=
 =?us-ascii?Q?ULY3KkxzG8eWuaxjJyF36Vk+vEcl2+LSYPxX0n0Rc6hht+ehyg+AaCAFV2V1?=
 =?us-ascii?Q?8pko7I1K0eANUFyE6gLjZ74JYf0H8zxj98f9O/IJGZ63t50qeK5HH9vbyPeP?=
 =?us-ascii?Q?qxG4/J4jxS0jlIDunK02BIqLW8g3A+ARC/KcJDqhBXuN/bFLveckkEnJNlP5?=
 =?us-ascii?Q?zt2vN9v0V3I6i1shCdAMUvGano2nG1xA8hNshX22Peg8Zudwu92yKOEW4bFk?=
 =?us-ascii?Q?zZyijTjLCu/MvYqMvl8P1WW97zwuk/AgHOrBwA0EteDgqwn5Dza9q+mXYi8a?=
 =?us-ascii?Q?GvO2IOUFhBJ8K8HGtDT/XthCUivMp3tapWP0x1ENuvpnw0o5nyLum8XX7VmN?=
 =?us-ascii?Q?mrmQiw8OY//6xG89Ex+gSIY7RE9UVFLzHV2PM1rWNPixk3Qi/+DuIdqqqiQx?=
 =?us-ascii?Q?cLjotsAY0DcPy+2Ac7tAm7+N4FRiONv1xXf6X4h3mB4IfBbXClIpD64HrEiR?=
 =?us-ascii?Q?FE7aEGAFeA7gMgUKEbztkQf5mpMQk4hflAuMK+qC9n672Y8g3jL1Yo2kTbLl?=
 =?us-ascii?Q?VjwCXB8h2rWmj1rJeHWKaWk99L8aBF8UJ5LQAG9Y6baVJXgvzv9g+aqNX5MB?=
 =?us-ascii?Q?eaWtOUXjU41kTqxq394kEG2SGss7q5Zitqs/0uZTg42oV2EfxzrYnQB34Ip5?=
 =?us-ascii?Q?nOs0V8iji6mGyHXmP8SZY3AEKEUUc4LfzLSZxAuTS3rkalWUiwQ7SlraIFGy?=
 =?us-ascii?Q?kYEc1e1c2Ra86mEP4Aum+Ck9hnBNH28X5u8LGHHlEe964rT5sOdmMCRBhogQ?=
 =?us-ascii?Q?OAdJGtjgOowX9itJAbS3e0GUKMFQgyBrIV/Oc2RhNWqielgfWMnT963Q6w+P?=
 =?us-ascii?Q?VCT9sHAcMKrXYXlR1nwFUsNNeZjva0K+QuviYacjpFFSCRiuRBG2dK583ZLr?=
 =?us-ascii?Q?G1VSPlEd81htPR9tzOUyRcZr/YcwaeeVmNF0Vx3h99q2iRGvo5tHy8u9MvXx?=
 =?us-ascii?Q?+DptK5Yi4xT8+dnqVL0X5sSWWcV2/pL1uQwcgLzu6Jd0BAHIGubm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26612550-2244-420b-e335-08df2f59ffc9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:59:30.2942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyEDNHWsojiKQNTVGMIaOqBxQDqs/GT5SUlqVZkAOInRyiPBeS4HxWNrB0tVq3HmT/hN1nW+3tBGa10cC+HHd62PqG0nYvxdoJTONqdOcd2vOrNIMURO7AF/5YFQlxpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull mmc-for-2027-01-rc1

------------------------------------------------------
Print eMMC health in cmd/mmc
Not time out a command that has completed in sdhci
Apply power-off-delay-us outside regulator support
Add missing MMC_HS400_ES_SUPPORT to mmc_set_card_speed
------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc/-/pipelines/1651

Thanks
Peng

The following changes since commit e36b675ebc4c41f1f4187c46d363d581c371d538:

  Merge patch series "rsa: fix rsa_gen_key_prop() buffer-sizing and zero-modulus handling" (2026-10-19 16:52:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2027-01-rc1

for you to fetch changes up to 7a4c42516e7bc98078694c6785cbbcc5c687806e:

  mmc: sdhci: do not time out a command that has completed (2026-10-21 09:56:06 +0800)

----------------------------------------------------------------
Igor Opaniuk (1):
      mmc: sdhci: do not time out a command that has completed

Marek Behún (1):
      cmd: mmc: Print also eMMC health info if available

Tanmay Kathpalia (1):
      mmc: core: Apply power-off-delay-us outside regulator support

baozhu.liu (1):
      mmc: Add missing MMC_HS400_ES_SUPPORT to mmc_set_card_speed

 cmd/mmc.c                | 35 +++++++++++++++++++++++++++++++++++
 drivers/mmc/mmc-uclass.c |  3 +++
 drivers/mmc/mmc.c        | 12 +++++-------
 drivers/mmc/sdhci.c      | 12 ++++++++++++
 include/mmc.h            | 10 ++++++++++
 5 files changed, 65 insertions(+), 7 deletions(-)
