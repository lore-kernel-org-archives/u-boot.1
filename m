Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1A606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e3DLYWtt;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EDa2LJDJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A2AE60626;
	Sun, 22 Nov 2026 10:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y__NXPO4YUDE; Sun, 22 Nov 2026 10:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9529F605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795343049;
	b=j6luSEuIPst8jH34EoZDpUrOkYew2BZdrmBVojCem+N4unCcvAc+o9QTG8R+LXkkxYMz
	 WfY84jse3Jpn8AcpWnaYUvtNDkgL4aPtyPA94WQ7y8fI8CkiMHcyvmec+diWTPwOJqtI4
	 4oxWXHCFAN95p2GAWo+XVdIZ5bDKiRsBwHmq+vMNA2hN0Bb73/Wa3hchvqjW4mBmrgaaq
	 ARki7Ce9aoF74ndUnNjAUt782cdT30YTfFVqHPt+l53Rzggl9YWWwM16VG1TtXDVrQsj5
	 QWA/hPulv7CvNbZM20bA6XWQUt0czvQeS/tp3I24Y8iryt0/xEU+9TTg7YS/zZH089g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795343049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qh0XdTijIwVUvab8jtjZlr3QbhWpDVsuAuLH8cg0WnA=;
	b=O5NUOGqlyAo3vWp9W3QwWHzB1NDAPoPQBlwc8BoG2oUmH6O/oifBraVqdUsv2+6+NQn4
	 r7dJwMx04ATKqKKRLgV4+m/REuqa6LnavORjG3BCRPl0sN8xB6a/WO7wfqdtB12FVvFSO
	 KY4cgHV/0QQ/23kqFDIvDLWh8A1OvJ6M4Rha06y9e/cZenvc/KmBY6FBn4L4HI73mn33d
	 URl9ybyYRm0ZoNqfsg5EOTRQzNFagYQ3G7fG1lYnIFyfRCi4vS3Y8NkbKR10kOIRBubH0
	 xD6U0ztsHDubgTm9noDEg98M4/LRu+UW6kpB4UgeE52dmfYtLEJcPKqbJMt74wH7nIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795343049;
	bh=Qh0XdTijIwVUvab8jtjZlr3QbhWpDVsuAuLH8cg0WnA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e3DLYWtt0MPZmVkRQDAqQ+LKt4KS110QJjWFnyhH4jlg8/OVRJxJpfhRSs9z2dMFZ
	 mzyU1SnhZE5k3oC5lOe4ulIdXU96XGRQrRDqRMf8j809wUYLjLvgfQd1t3+RhKEZsf
	 RDKro+Jik1/mK26xE9UFT0jq7VS9ai3XqWP3h/CytjeTQSel1qt2tETXIZ/1CfqcHU
	 +O+K6f+lEPlBvqjbWTSERIvcYJPZOmB5t6Ux9y45qSifPcY+PC+oHs6fe1qV2h6vAQ
	 JHhZhemwj09d/MoQLe8fCGRsg+XQKRd+DZQH8IpHv6m905HzF2vgbqc8zCSsgslh3H
	 brpb2KJChIwYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9529F605F7;
	Sun, 22 Nov 2026 10:24:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26C2D22B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23BBC4069D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8NKkUrXKl2U3 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 10:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 774624067C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EDa2LJDJ
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 774624067C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh0XdTijIwVUvab8jtjZlr3QbhWpDVsuAuLH8cg0WnA=;
 b=EDa2LJDJrQ9Ww6WH6bym42nofWtrgW+J0sKlHDlA+1yZtqfkzSL4YfoDAm2rZVKIIrzD5ZjiSGTjNG5BmmTNXBI/IXXnjkr9dFZvi3e1D4iIhXR+tGrGBq14s6RQDV+xM1yn6DC7AG8MePv76jSZYt+/LpwKICOu5CXp515Pyk/OSY+0W0tXi41uPdTlvqOpcbuLJJbRmFu9XOG2V5GHD4uo62SelL3VUj35RWTdoHWxE/DQUCiTfdv+7I07nxpReSZ7xF1OWcA8KByoRJtVJvvWrnsZdekk/o+lbtkgOyvQ2b2ci7UBTkq0nTy5MOXwOnH8aeznEX2shH/qzJXOdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 10:24:01 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.011; Sun, 22 Nov 2026
 10:24:01 +0000
Date: Sun, 22 Nov 2026 18:20:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull mmc-next-2026-11-22 for next
Message-ID: <awLB0iSbrVC2XS9U@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aadeb4-d7e9-4e2c-04d1-08df4882b9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|11063799006|56012099006|10067099003|18002099003|261021121427099003|261021123027099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2Fpg1QgDwa/UH7kug0GOuo1lLGNSqKcktUVDnCb1nlnxlowRZJFOkhEsxWJyGLcPpsWFZf1qWI4sjo3fMJa0OY65qQJUP43+Obf6fVc9nOJkR/NOuelFvRNoelh45641imFklPqWqiyUdOzimVe9JHo89wJXdqZEOzU2D6dNdie8a68KGbuHo8x4wr+njrODyMdIbUEBIGtBb5pjNhl/WVm9GxtOyj1jAVsqQYMi4C099SxxNrNkIynH+v+f/u6XvR8XW0ijobXGLW9107f0ncqWF0Vd1t3z51kgYBalD7KBH2GkFgmFRU9X6jZ25O3e+tEf55Og79AhZYrD7rYy5RyjIdeR3RudO8XsGoLnE+Q2pV9LU1cMDyxOMev4UgePrXPe51EOOTNH/Qi7w36hSexDvU/l9TvIwLeoET7n2as842qw1A7QVvOZKdyAhz6vQSX6jsng3OLkF1qhZjjDK2XFI2NHYhkH0FExi7oGhJd83FR8IMqZ8bvl0XXpZIubBZXz+QA4E+oNA5zWzY0teMu/zuat0HjTLR+cJy/GrAqWX3ScxcpERm4eiZNG37PhOPr2rlP1pcUFJWdv7ejiIomoabwyyzvbD7TxSDk+IHzALzvNIRMhvY48T/Z0vJcK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(18002099003)(261021121427099003)(261021123027099003)(6133799003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ooa4gNrumsQCvKI8hLbEtLkp1TxKa/k8BHojg2oi7Toew8FMuuFBQ18FSgC?=
 =?us-ascii?Q?xOtUn0dufQuPtROY8lKvIJrc8dm07ymVueRxUdB4UEkfKJYWFE3J1Bvc/WrX?=
 =?us-ascii?Q?MzIvwCRXoYL+/eNWI6c/36TpaDdrncM/SqUtikN4C/MMsy/UQzp9rpgQrNEc?=
 =?us-ascii?Q?CvF9ezrVFJ8upAZpuMqkzPj6nrZaDi1Kbc2DoancKar25xakvAfuqMZMBurU?=
 =?us-ascii?Q?+FnVeQuxZl8DNkQ5ga9cxO9QNrP5Yd66VTfThrgP6jePJC2Sgd81C2NUM7my?=
 =?us-ascii?Q?ubZUp9NGxZfRGWOCGwt3ETDIxfDGTu0XThYFcDZVtYFAGFZr5qVbFIm2v1OT?=
 =?us-ascii?Q?zUdNgnG2kCYTv2mf9tM2AEoOrVRd+me5W6PWvYwmuTv4WcSrZ/Dgis4es+FR?=
 =?us-ascii?Q?SslYufFMshd2PFcKz6lZ66Z/8+i2oKQMEp8HUkH/2zct5NQDTVlSMH9q6UkB?=
 =?us-ascii?Q?CAzc8cU39c5PTJAQPP1Gl6U1pVSFjSLYwruIQ6j+1jCO+2IOhRXHEjT+fCC7?=
 =?us-ascii?Q?ynXQJ0SEnFSkGX3MSW3tFD3rm1cZ+syYZIX2ERU/ksLLB+Z3s24eDhDdKdK+?=
 =?us-ascii?Q?5DvbojBw1imnqh5VlIAnysCZ5Tqx4EWhFoIf2BNENU12kziyl/KBRDqsiCDE?=
 =?us-ascii?Q?I+lu8w0/swSYd22xs4orHxwBE/3jlYpAENnwF41/nHzbKvPwL3v7odxAB4Yk?=
 =?us-ascii?Q?SMfzLmd8U/o/TFO2uq03Q4hAVgxNSX9Cr4pPsMygtthhqnSb/XbyWWl4o7gg?=
 =?us-ascii?Q?k0iT2k+eVIFovRqY0D78tvvbFnVCbjr5AFlnZCn1dP9/khHUi55eQKYjJ4X+?=
 =?us-ascii?Q?hRnXi9zHT4emqaeMsaQg3xnkQk+iolYSibIJyk6ya9jXDToZ1VhXVWdahRn+?=
 =?us-ascii?Q?Xwl8EKx0xsmX4UXknoOTuo32PAtM/G78zdtUXbfgOSsandWoq+w41XMKkblj?=
 =?us-ascii?Q?rVWgvl9zJPoShbI6+ef4AJSzgFQqkgXFoS2vcDUADaJ5vby0oOxw1GZ6apqH?=
 =?us-ascii?Q?4nr/GRJ3RfhO4Ictv77lajE3xY5lvlfaha0lwxaAFu5kHad7c1gKYGUiSqBe?=
 =?us-ascii?Q?IM/iMaqnI6HC5XzAjwvm11iX3735R/ObP35JNJ8YHfUCjGBHFnBpw+anY3f3?=
 =?us-ascii?Q?65ukmkZNE8nT9rOdBeukN4uhWNHBt0pwqDgvGsRRMN4s6BnxR9acwd+OFKyb?=
 =?us-ascii?Q?iTl72jiKFOE2CGfsh+l+f+GfYBOF5soHfPhTQjajaxVYw2e4Y8qqBrfAzubo?=
 =?us-ascii?Q?EY+aRdpZBEWh+LT8gU9aJX1F8ieIdoReWyF5pL7QMa5bQRk2vW3rDbYw499u?=
 =?us-ascii?Q?pvZb8+zSZW0TfMhaTo+J5vIiHtAWaaixrV2XLBCE3tq4j7C6BRTTtLVNty0o?=
 =?us-ascii?Q?MDtvWwyZzFr2m8r0qTLbobLQQeHNH7mK+ljiuNJBbBAoaSIbvbc0uzZOd11w?=
 =?us-ascii?Q?Q8hUiasIpAQ1eKmc1ATydO5+VezfYvh8bOjumckSjkj3DPjCDYq9Hj7WvUOE?=
 =?us-ascii?Q?cHFov8jMewJ4vomAqjwyhijyzqiPvdUEolwoWt9YVTVaIe0vVg2L05dHtxCQ?=
 =?us-ascii?Q?69ypfLwzjkSOsaSDGbPyKVuiZkHdA5f3/9haQVOdHRsPOyCu7rRViePR/vU6?=
 =?us-ascii?Q?C3/9ypnINsdYYOdTKJYxa6IZQSFIFMUhEzhSGznT+YvMeQz1ARWrLQJjW7m2?=
 =?us-ascii?Q?vQZ9fPsKzYeUSk+ExLPnuo8/8kfUoEKNw4szBlLEjV3Iu14e/zwOdJ2e9/aN?=
 =?us-ascii?Q?Jh0E9MXFlbxQwI3CD4KX5diYz2AYnFbw6GmOQu+CSqqVJYKkn4Lh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aadeb4-d7e9-4e2c-04d1-08df4882b9d0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 10:24:01.4866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nq9/G5D6VZ8vccS2E7zvoNIq2TxUnINYde8Jjq2iFxqtBMRKB98xxl9IZOoaO2UbOaxVDjXJMgJtbpcxsWd2PhTK4LAeRXYGpnVgc2oxcZdZjPZ2777x1s1nQsu0QQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull mmc-next-2026-11-22 for next
--------------------------------------------------------
Constify driver ops for power drivers
imply LMB_LIMIT_DMA_BELOW_RAM_TOP for sdhci
Add sanity check for mmc_set_part_conf()
Sync hwpart and capacity after changing PARTITION_ACCESS
--------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc/-/pipelines/2120

Thanks
Peng

The following changes since commit d22f61a39fb68bc697e67df45f2e3103378bc7cd:

  Merge patch series "Prepare devicetrees from FIT configurations with fdt fit" (2026-11-20 11:47:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-11-22

for you to fetch changes up to 5ccb7594c52e17d4452dbcd1f070421cfe731afa:

  power: pmic: Constify driver ops (2026-11-22 18:11:47 +0800)

----------------------------------------------------------------
Igor Opaniuk (1):
      mmc: sdhci: imply LMB_LIMIT_DMA_BELOW_RAM_TOP

Marek Vasut (4):
      regulator: pbias: Constify driver ops
      power: acpi: Constify driver ops
      power: domain: Constify driver ops
      power: pmic: Constify driver ops

Patrice Chotard (1):
      cmd: mmc: Add mmc_set_part_conf() parameters sanity check

Patrick Delaunay (2):
      mmc: export mmc_set_capacity()
      mmc: mmc_boot: keep hwpart and capacity in sync after changing PARTITION_ACCESS.

 cmd/mmc.c                                  | 17 ++++++++++++++++-
 drivers/mmc/Kconfig                        |  1 +
 drivers/mmc/mmc.c                          |  2 +-
 drivers/mmc/mmc_boot.c                     | 17 ++++++++++++++---
 drivers/mmc/mmc_private.h                  |  9 +++++++++
 drivers/power/acpi_pmc/pmc_emul.c          |  2 +-
 drivers/power/acpi_pmc/sandbox.c           |  2 +-
 drivers/power/domain/altr-pmgr-agilex5.c   |  2 +-
 drivers/power/domain/ti-omap-prm.c         |  2 +-
 drivers/power/domain/ti-power-domain.c     |  2 +-
 drivers/power/domain/ti-sci-power-domain.c |  2 +-
 drivers/power/pmic/ab8500.c                |  2 +-
 drivers/power/pmic/act8846.c               |  2 +-
 drivers/power/pmic/as3722.c                |  2 +-
 drivers/power/pmic/axp.c                   |  4 ++--
 drivers/power/pmic/bd71837.c               |  2 +-
 drivers/power/pmic/cpcap.c                 |  2 +-
 drivers/power/pmic/da9063.c                |  2 +-
 drivers/power/pmic/fan53555.c              |  2 +-
 drivers/power/pmic/lp873x.c                |  2 +-
 drivers/power/pmic/lp87565.c               |  2 +-
 drivers/power/pmic/max77663.c              |  2 +-
 drivers/power/pmic/max77686.c              |  2 +-
 drivers/power/pmic/max8907.c               |  2 +-
 drivers/power/pmic/max8997.c               |  2 +-
 drivers/power/pmic/max8998.c               |  2 +-
 drivers/power/pmic/mc34708.c               |  2 +-
 drivers/power/pmic/mp5416.c                |  2 +-
 drivers/power/pmic/mtk-pwrap.c             |  2 +-
 drivers/power/pmic/palmas.c                |  2 +-
 drivers/power/pmic/pca9450.c               |  4 ++--
 drivers/power/pmic/pfuze100.c              |  2 +-
 drivers/power/pmic/pmic_qcom.c             |  2 +-
 drivers/power/pmic/pmic_tps65217.c         |  2 +-
 drivers/power/pmic/pmic_tps65910_dm.c      |  2 +-
 drivers/power/pmic/raa215300.c             |  2 +-
 drivers/power/pmic/rk8xx.c                 |  4 ++--
 drivers/power/pmic/rn5t567.c               |  2 +-
 drivers/power/pmic/s2mps11.c               |  2 +-
 drivers/power/pmic/s5m8767.c               |  2 +-
 drivers/power/pmic/sandbox.c               |  2 +-
 drivers/power/pmic/stpmic1.c               |  4 ++--
 drivers/power/pmic/tps65090.c              |  2 +-
 drivers/power/pmic/tps65219.c              |  2 +-
 drivers/power/pmic/tps65941.c              |  2 +-
 drivers/power/pmic/tps80031.c              |  2 +-
 drivers/power/regulator/pbias_regulator.c  |  2 +-
 include/mmc.h                              |  8 +++++---
 48 files changed, 92 insertions(+), 54 deletions(-)
