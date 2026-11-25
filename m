Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB0606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=08oy8HCj;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JjgM7rbf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 010CB80CAB;
	Wed, 25 Nov 2026 10:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsjlqU2jBROQ; Wed, 25 Nov 2026 10:00:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EEEF80CE0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600802;
	b=BMKv4rdOCANVNWNdVDgRsmHLj0gZAFeyOLZY0nV0gSE3PySF8VTvEolDFX2eI7alo+Sb
	 tiA39ItUJQhApkUJaqQjBrcIYuCiFHRnKKwgORHXID8ZKILVoHOWRyiiOQPAqLHrX0iIo
	 IxR6KmrIbv3CywOKlqUDcftfCgMBi26D+TKEeiaKZ036Wlvvzz+pk9TUeWr3oBtXd6MIJ
	 ZYuOK9Vu4fY5CXTjz5OUuTvLReCDb7saEFVzYQqiYBryJ58d5uoDGRAnT5DRHuikRERaj
	 gW5MksL8m3BdLXCtibjbgVmtF45NwTumZ+yq9px/b7WSa/DCCtlREArDLEjZKHMu1mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OW08jelncxUBPTYeXOQqVMJbOJeF7N7rnVyBt1lHBb8=;
	b=XqgTTjlBBQI49aMrEZfWCsE2+w343WYFIMtX7zosJo22aJVrc21TprasDxpNyjnJ1xZP
	 eMWMafXbo7WwGM85JtVZeVXhgrKV9WzmOmtsBVFcj5jqFMqH58Bf48/8S6J1x7Ph7dhZ5
	 KqFupxTi2rBxroMAaN4/kRH3XHWXbVRzQsq9nSccWw3/oPphtTQlcpO7RpaEdSJfsT+KB
	 gS/42yvAd2/Z2VxZOIC7kGo7PZt7/5eF6CM7X2/CNWDHVdGlXlxGenpNRscbDDVZNYdVA
	 TCmJEAQxW06xRWGiIwekYYjrkS7GXmfRjHyEdjhdpE8fnV+FLn0h/Pef4Vm1d8VXYkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600802;
	bh=OW08jelncxUBPTYeXOQqVMJbOJeF7N7rnVyBt1lHBb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=08oy8HCjITX0rUSY2izi0JPRQhgAjugM6Bu6KWk7CQPzCyvABZHbg7cax5W2QpMEa
	 6QpQqwYq/bRlxpeMYeT/1hLogJfx4oUVEifhg7rX2AeYQrB9CJin5o67VAP6Uoh5tK
	 2cqwLcFjJDz6Y3dNOUiIO/cI7IpWLZJYDI4+oXKJLtGzCg9PzI/Ujsmw+44HIRGr5C
	 Ifet1sxekKQqwwrgzCQsfuULGBQfgV5ba/do6h0sZv4D8XII0gWhnmd3AINI41dQGW
	 f5EJ0qw5SwlEmGRW5h95Dqvc8oU0LrBhXg9GsdLGZz6Dps1RczeCsdL8cEvblmnTml
	 IamU/2qyAmiIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EEEF80CE0;
	Wed, 25 Nov 2026 10:00:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE00C311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1D8B605E8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGe7EmrWfnoQ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FCFA606D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JjgM7rbf
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FCFA606D0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW08jelncxUBPTYeXOQqVMJbOJeF7N7rnVyBt1lHBb8=;
 b=JjgM7rbfwHMYSKF6hrBVqbUxrf838cXSQOFTeW/YP22YyOJzTLhvHKTm1RsdZLn6X4Kk6pMK51zqZF3VJ/Pn5S6itKry2g0/tGUdyiM4LxYytxbmvhJLbeDfnygaSAR6rkNKlNlQ+39jU5lC+pNJNF0Z4ZGhz/vYTl8sOl5+rLF43fp5JxcYI2svKKRYiHo3Epfw0uWgmRqGE/tYLVK52LBn6dzg9zMTwbbXybJ/ZPW55NIBVdCkRpnDO71Ys8zgbVxySCW4CBkSSBOlki93JOim2s3x/y4WOOB52xAam/hR514Il177rp0/H5j/Re1Phvvj4lSmFIqOpJzyskPv5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA1PR04MB10795.eurprd04.prod.outlook.com (2603:10a6:102:491::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 09:59:51 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 09:59:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, francesco.dolcini@toradex.com, lukma@nabladev.com,
 dlechner@baylibre.com, msp@baylibre.com, stefan.eichenberger@toradex.com,
 Max.Merchel@ew.tq-group.com, nora.schiffer@ew.tq-group.com,
 primoz.fiser@norik.com, jbx6244@gmail.com, aford173@gmail.com,
 cniedermaier@dh-electronics.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 4/7] clk: imx: imx6ul: add the enet clock tree
Date: Wed, 25 Nov 2026 17:56:51 +0800
Message-ID: <20261125095652.28340-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261120111037.110741-5-eichest@gmail.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:295::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA1PR04MB10795:EE_
X-MS-Office365-Filtering-Correlation-Id: 02420579-a520-47e5-1623-08df4adad8b0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|18002099003|22082099003|261009223027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: yNRRf5KdwbKt6YcO0sE+ThMle7qV/4UZ9YGyBS5SNZ2BTcFyly52FkfTT1aSadCohsv4ZspfkTxqTQmqdBGQ/J0fXm7hmIfL5Ht9at5RMTCSH6b7tCO08KqjJTxS8KRXPcu2jhemphMefLBCJRfvplWCsT5APGj03KbeeebxICEwtKgVJWtXQpme1KrDrJtcPUwEOR8QvKWufbKNyogWrLFxRy0ofEwzaKsHAp/u8fL5rgfS0Xdn9y7+SsSUxvEg9kwOAA7AegxgO2g+kgMPrQ5HduhYex4+3jXg/rKCGeOKbFi3PwO64LgI61iqos82s1a/0HDKBgV7QVvhGs4ttYQ99fd3KGqZGJx2grwZ6oAtofYhu9My2r5neGmF+hjLsOEpi5uUV+FvMrBjmkG4lLdd381dIuu9h4kxadjAMIeDru9s+FilTLgNo2dBoohGqVrwX+KvvSn/+P/jjnWYxQWXoFRNu4fk97An/EImM7ZrZ839LR1iRX9fkG6LU9BJ96cqLM19+EQB+0Y2mG8MySfsb8JG0W9yUIrcEJH+rcLjkPVVGcX5Ah7LJ3xkOdH6Q1rW/vx2QNrdYdU499tFK1myHgw3kTMLSErIlHo2OTLsH99y/sn5y29/KCCNXyg1ThCXzQjQGvREVjEnWsKUqz1uuEvC//S3zUlE3N17T2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7EYNG2m6oSh6Tg8EJLILYbifDWbhMh9KHuU7I+mq912ziwsvVm8H+dvREE25?=
 =?us-ascii?Q?wD+d1Ofk/6gZHR8EX0GiajF6RsxJ0SBJ9vfMar+XzhoZZdZH5464jlPMqwBK?=
 =?us-ascii?Q?MLuYTWeNF5mcvyHvSzXWv5BV3qhkFk0S6GggCIDXfvCEVnR1nRV6M2JzKzSv?=
 =?us-ascii?Q?Qn/7pVrHGlF7Z3bfcV4kuUFgC7yq3VoHktew+C8J07Zsk2BsczjokV4NNLm4?=
 =?us-ascii?Q?j9aEeaXq9qDDSirbCftb1TVKMmR5d/1K9gfXatQTVSdCFwJD4QVYIlVf76/d?=
 =?us-ascii?Q?x69pIoWZ4lkUISnLmG6tTAiGcLMhtWCUFo00pKflRblYbrYtewe4ZvvGne/W?=
 =?us-ascii?Q?PCZbaL3do9OaKK0+saAJ1V24+cJrCm+tWYuH5HJPXjfn0Sid4WYzBAxC2ze/?=
 =?us-ascii?Q?nL51TmpVqTsf7Jnbt80u8QdY21d0KX66bJo+n/DOxT4obfkBDcUCDx8vkul4?=
 =?us-ascii?Q?ixLLIdj8iTdW+Lp0xF4eOVVMfrBN9K0Ec5OjkSXAk53dw3Z8FiO3L9O54f9J?=
 =?us-ascii?Q?Z0H2USVh2hty1S5qiQlQNUiFfLn7l3kxSIVR5RlIYesTGK0nXnHJykTDoGD8?=
 =?us-ascii?Q?57e0gb/4wFbq8nbUtARON7BFbXsyv9JX4+kOcO082wRuIj6DIV/0msBGAD/H?=
 =?us-ascii?Q?1s1cnG2pjodho3nn6yHrGXdj+6VZtIQCThbmmFUXWUQDb7PpCh0cImoS14pW?=
 =?us-ascii?Q?YNlt1RA/MhzR4Xp+V3IFqfg66ObVYYDoJV+LG7xd+2VQIRG+1k23udwHIm18?=
 =?us-ascii?Q?uNYXZsnN68knvHRCV08hYJ6P+M4vsnEV4UKbTVTFoYoE/+QUcVJ1yvewEJPf?=
 =?us-ascii?Q?NllM1PuFVpWnm78bL7ZUg7yQvyJ/nB4x2cpHnPmyczDXIOA2WH+cOSNSEsqZ?=
 =?us-ascii?Q?wXsMDIkf+mXeu2xB6sq5mUXQzE7xjLxzko6/g8ANAEPGYRcJJKadlgw0pBEG?=
 =?us-ascii?Q?9Esb2OQgFPRPXMFw1sS20xX3vMQEEmtiGE2zqXDK+vqJp4+LXr55F5uHfEs6?=
 =?us-ascii?Q?ijtY3S7e0hTU3PWT3uJF/0XEL2NAcgIvDduFGAl1m2DAhGwVdDApjPcLSJ9h?=
 =?us-ascii?Q?Tqa/TvP5i1zTFnZhsoxgY6kVFoFTHOXDRND7XujLvf8K4xGfc24il74mB50V?=
 =?us-ascii?Q?MvwAYli5m/3UUOwC8zs7eS2LkTubI2lfpDqa9BFBa8sQcz+nDzNcHomwZa9A?=
 =?us-ascii?Q?cwy7buiYGWRmg+QsGNNqbxBFCRVZlbVdddLRjGxup9curZywNmZdOBII+6yE?=
 =?us-ascii?Q?dd5BPHZwM4qWoEOlpe6S5Q5YMrtWZztV9w7nwCwOHP4/fn32dmJLnpCkUTn0?=
 =?us-ascii?Q?UW3QBwhJxyUk2w2nBESvW9fRq/CA//DVUKpTIShh3mohwD/1ix9nH2VxrqMX?=
 =?us-ascii?Q?6soKFlo9MYhKztyxaestQ2WBLh794BTf3x2CGn/IEPCALiRC0UB2rD9FVYgh?=
 =?us-ascii?Q?cggbt8Mu308T2K+ar8DbRJjRQ+AA9xMEGxN/0oCnq5WJm8BGJFSxStP6eUcv?=
 =?us-ascii?Q?iH42Pg1x4sjxTVQdAl7y91yswmoktWNdOk8G06K6Jwbsbf9iEJz073YI4hGd?=
 =?us-ascii?Q?R/zy2I5zNw0+VQrOQpY5h+HQdiGAmJRBZZvSrVU3KTK2H3x/RzfzqJaU1Inn?=
 =?us-ascii?Q?8u9fvTs/hqO511TFg+Qc0rvpyqEIrzUzQ1TnMTW+9sSt3QrItmK+xY2D1nTZ?=
 =?us-ascii?Q?gR9i3Y/DGC+fUgSUWysu+WBVYLMI8QbiXaWQ9uY/F7umdcRScrYZlKdxqGp5?=
 =?us-ascii?Q?rQsFxuvI1gd/FSkF3OR9iuXB0lIPBugGOC91r+8YIBV4YgCcvPUG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02420579-a520-47e5-1623-08df4adad8b0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:59:51.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0Lxx5EKOh9citLIWPRWrxe2sGivZr4HNOMyGsu4FnCTIKDnoLRogvhQobwVRtRPB63BrnLpX7SMzSC6tWaL2NBmWe/VhkvHQZ7B3b6tHAbXiyVErAU1VOxo04/EexVZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10795
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>  
> @@ -276,6 +331,17 @@ static int imx6ul_clk_probe(struct udevice *dev)
>  
>  	clk_set_parent(clk, clk1);
>  
> +	/* Take PLL6 out of bypass, the ENET reference clocks need 500 MHz */
> +	clk_get_by_id(IMX6UL_PLL6_BYPASS, &clk);
> +	clk_get_by_id(IMX6UL_CLK_PLL6, &clk1);
> +
> +	clk_set_parent(clk, clk1);
> +
> +	clk_get_by_id(IMX6UL_CLK_ENET_REF, &clk);
> +	clk_set_rate(clk, 50000000);
> +	clk_get_by_id(IMX6UL_CLK_ENET2_REF, &clk);
> +	clk_set_rate(clk, 50000000);

Could we use assigned-clock-rates/parents for these?

Regards
Peng
