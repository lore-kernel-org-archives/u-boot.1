Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012A606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HH6ySgj/;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=eGGxtsSd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4E1981638;
	Thu, 12 Nov 2026 05:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_VTL2ZcKOKP; Thu, 12 Nov 2026 05:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA848815E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794463156;
	b=groBqI6OrR/JrHTD+RODdaGeK3LTixhBN4yRRuBrOe0+/u01TM3MjnJ2SKHAZ4FpzLaR
	 qofPINcTBTpCwyHTFr771sNM3MlT3q3+TUCc9CT0ywS8Y09eu9vGHDUcgROiCo0nrJxT/
	 UNwxxkpG134j6YsUrXsvIjCqvMuYCUyWL8+QN6SzU9lJvbPPbNLm7B7et0vJtBi5oP3UG
	 bS6yeYqHsJMAq7tjlwLDbnHMInpbwV4SFc7ptPkjRPXY035KbVbRJYqChlU9kYNFSLW88
	 Qr5A/f07pM/WfgaDWO0QzbuA/FNBrOnXhJ1OJSKOwJzBujawYIjup+aKZvxGX8j4f/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794463156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=eK7KfWDYqwE7n9zMsIRz0QH9dkNL63YIT57Qj95xLzE=;
	b=jyCYBid2RM4Z8Ppol9+lA5D2mdLXCtXUBlBQt/UQeTfSA8Fl9Q3zHraidowXhfoRkBVG
	 CTi09Slrfy5tEtd3FVlU0azUJ1sbjIhCOllO8TMwHQwiDFUX8kmuQIFWIVF4mjKINGRS8
	 Pl9swWUS5R/eTdBKif6UHAh8B9rw5Wscw0pb+vZFWp2qYWdBJjcbtYCxWUwEsWTkGO58A
	 s5vBVic2jpxZs0HJQLJ+q54NEEoF9e5ZV9meGaCJ+q79cHikqe6LgOKRBDw//LlLQe4em
	 M27/tl4dT4FBT1v5uj6t+B+pub4nbJ3LcIIIRHprJbqLxx1y09MjRBhOtqoQo6dgxow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794463156;
	bh=eK7KfWDYqwE7n9zMsIRz0QH9dkNL63YIT57Qj95xLzE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HH6ySgj/laYRWiBxPA0qxDcU3AINlcE0Q6zuWHGqFgsSaGFLgkaS/JCPWer9msA7v
	 pd0+bm5VgwrUVnrvxndgq118YzXNwC2+pohGPEotKTW8SiGO7pOAeLA5TEUO4kjeRR
	 u+3/x4czYDxG2dNdOQ//GBsWKix3Y9mz8TpZSo8EV6djtz1wKSW0povo5kOXCuPFew
	 FjqFyDR7ge2wgcOMyD1E6yOaJ1U8uics6ZgAeiSefSkhUmVIj00ZcEvvyeBLjZpV8Z
	 p0LjKMFK42oFv3ilwu/IO532sts/mOwl6Gq2GY4fEjV7viUZnAo+QKjzM2EglSZE0E
	 NtSxNylX7ONJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA848815E7;
	Thu, 12 Nov 2026 05:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 724012FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6394560893
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T6tR-niBRJSK for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 05:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17B4660887
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=eGGxtsSd
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17B4660887
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK7KfWDYqwE7n9zMsIRz0QH9dkNL63YIT57Qj95xLzE=;
 b=eGGxtsSd7IEj3h+0MY8Pa2x6NbJYWm3YrGAPZ5owrCPiAhC/ArY53uvDWq6EVpNDtrAYh60SuKrwmccFk2aEdBnBW7JEes+UHw6QW+CAaerHcLNyzNBObxJP5tWYlUeW/LH98mfkZ8brZKyVN5ja4deP1vHtWM5d7ErcSlh9SDvHaHQLbCf0s3LL/4rzGuvtkd8Ctp9+PmKi7/qLnfV0rehZ0CjCfoSCdeaxaHU7dh9V4FfOrec9Rll+Ak4XR7bB7+/COySY2PV6CdsGDtRcYsC5GrO2HSfcH8lCWUqIzlHqyWSKkAUK53gUcJVTVe86DKno4wFNY4jLlEUFf/hUpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by FT1PR03MB457023.namprd03.prod.outlook.com (2603:10b6:170:3b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:59:07 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 05:59:07 +0000
From: alif.zakuan.yuslaimi@altera.com
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Bitao Dai <btdai@terasic.com.cn>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3] arm: dts: socfpga: Add Terasic DE-25 Standard Board Support
Date: Thu, 12 Nov 2026 13:58:52 +0800
Message-ID: <20261112055852.22457-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|FT1PR03MB457023:EE_
X-MS-Office365-Filtering-Correlation-Id: ce716cc1-93dd-4c9a-a5bd-08df40821026
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|55112099003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|18002099003|3023799007|13003099007|261022075727099003|261022113327099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261009220027099003|261026121527099003|261026140227099003|261021123027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: GDmfLN/uHVMCXBzUNGGAob1lH+sZJptakUPr7pQjQYxII4xCex3MYBFb3lmHYJLbSBQK7WTL4rFLM6ong7CaFxn02XXIMvSge87AHsR7oBgkFb7Ua8NIg0WddWr3G+J5wwZYgyKs7r6nDhQF9d/wf8fo53ZqZ1qEllsmmWACHOzkNGb90+1rkwj2YHpwUonpqjxMVq0H3bg442ljIvVYH/oIlDWj25Z0f/vx3Ijla/Y6v6YYB8siBIFJpxrN1QbcHABb4ZdmC4vczF0dggRE6155rT9wUUcofG42mKi2XW0t61I99sDrMRkoG1Y2RaQqdVdsDAwumvGSrjzne5CKyvGO5NVEy24BWw4LSqPORjV5IAmZQSX1QVFunvSaWHkMXZj+QYZKnmdcSCJNMhIr/aB7bPDbqVadkOHd52zL9lOkSou9jdPrc/8aU588zG0abTLVk/W1hy60pINGWENYLCGE0w9C0r1WFo5CnYjCNhzelw4sjko8o/0EiKF/MD9PjfwTmQYy5mZh64FsF6sLnoiD7uePPOiNMHs5H/1MB70wKS8BImwOJbE6+jVSXO1AsMVthkU3zzuRDwnCQc/55J8R9CKFGV68OgcFLQio/GA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(55112099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(18002099003)(3023799007)(13003099007)(261022075727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261009220027099003)(261026121527099003)(261026140227099003)(261021123027099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xfvM2J1uX1L+z0f6G2V1dahQucqZq1IbbXDpJVnbvlFV2xSpMOB68EsjcDq?=
 =?us-ascii?Q?1Sw33CYEwcARs77PYfZ9F7o/m2MaD251pVUIm+COwxl6iHNDz9jJVFF/lDRv?=
 =?us-ascii?Q?rKAgsyL54QUtyCVng19plQKNFu+eQZDAzeTzvSNXz0KnQUSKqctwhJbDbj12?=
 =?us-ascii?Q?Ps0u3NJbfuGS/3rukxbOJ2nPdBUE1QEDKdcxr4u59SnK5/AGXkaDUfhNsO53?=
 =?us-ascii?Q?M6MFzpCDxvCszX8kF3d5fhhrvIKbQUFzEiWMzH5bfNfkllS4jtzoqzuzg/f2?=
 =?us-ascii?Q?nGX6c4QDKh7R4FDHB6WxU26ui6vDxxxGflgwf8ky++RmUqIZpH1vWReHad+b?=
 =?us-ascii?Q?121jv7fE0kbRS3ifvyPsFSEwuHED0OVOakD/bHDG6xJoQvhe1O/QTtNNJdmy?=
 =?us-ascii?Q?RJEk6KzPXBrQ4blRcFnQNmPIn4sRDgsxrrAzah7B96mGM1I9pMgxjQz2mRVq?=
 =?us-ascii?Q?vNFCuHt2VtiSeoF4FN/vmZA8I2DptG+PsnBJpqQ0ynT0AFoeYit9227nLrdi?=
 =?us-ascii?Q?BXd6rOLGDZ+Abo3Fmblqcdt3b1nTfBkKXHiu20LeGnl4i/tqVNBWoZn03ffq?=
 =?us-ascii?Q?ZyDzaz7rSXxKyxOQumuU23wD8EwtyVyCBMICi0BO8ZUdB6o0ANOEYt6sFpxw?=
 =?us-ascii?Q?JNs7u3/cnsVCn1x/t0tGNq2TeqhEPLK3RYwl8iG5UYPCnWBx24LdxFdP1XBh?=
 =?us-ascii?Q?jTCTjk7aFGDHNSyRcbOq4snRjyuk+EqHiwCI5nFw6wPpfN7Ph3NhNdCb/cdt?=
 =?us-ascii?Q?/6yRVDUS3TuhbQfY987ah4j064rI6z/fv4QQUFQrGUBU+BGtjW7fprX/fPjB?=
 =?us-ascii?Q?g+q2CHpHMMu90+N1SkqP3E62HOPNuojxxTp2XV9o9jN8Vv3zngfjkR0S9eJq?=
 =?us-ascii?Q?+DvJMZD2dXpHjVLBsu3iPnT4r/7sJEUxoT6Q0I7U+Ie8DMIY64Nl+J7hf8ge?=
 =?us-ascii?Q?qBd0O7eW4h9WcKZvjXxThbtj15XMjnXOARWVNAMtGGYDye71RROyqh/pgA6s?=
 =?us-ascii?Q?Lr/eAtu4wPCPvsn/zCfeFjeF63PI56L/a4jo6+k1j68iltgdzFjLH/ryDD5n?=
 =?us-ascii?Q?3PgBB0M0WhiMRSuheAKA+p8nVi8dyhMZ/6Ndl02HKA/20WYxBEyWju2bW6D9?=
 =?us-ascii?Q?4zIuDU8yniRma2t5dvbGv2SbJC/JIyT3c8quM1BYy2tewZ/TdzlJ7weMLhrk?=
 =?us-ascii?Q?F/8HMYPYh8Db8fIQlM7eil6onxTmauSLm9I4ytEd4Qv/Vev2jCMLXdvNWk/P?=
 =?us-ascii?Q?/9DIpBtnd3Wkt7vnEU4bGzhe3J4YscEP0rjNPMFPVU6UGbEdXPnQpQHW+Brk?=
 =?us-ascii?Q?367SLweJeW6f72oWsvkkgpetwKXDg0nYKjRhaKJgkAIJ958c9aV/xSEVy0HN?=
 =?us-ascii?Q?CU1tJiVYA7WZzhmO0XMayReOzZVIZfyI/cQOhrEkIl674/37tgan6x8mj6ZE?=
 =?us-ascii?Q?5IYHu4du39DOhaVACFEeetDCU+tIRHnXCcleZGJCB2uBqYDFscGTJCMOtEPT?=
 =?us-ascii?Q?ho9GAZuo7SfoH0MY+6SvWwKGDqjbdSGINRzBh5fknqoZz1RWiuOnXj8dt0Ty?=
 =?us-ascii?Q?OlNKJlIwMnX8XOLR0weq/eviho1pYYpo5mvvTJAVaFZIKS0WmVHCkqFpnMjE?=
 =?us-ascii?Q?TEv/CX/N8J1/1ktCL81Z8wP5qfEogNYk1Ersltc4+w+UpEt01eJRcdOEgMRm?=
 =?us-ascii?Q?1gsQdIVQntOUf3c2Mw60OS1yOspUCd6y8qkbRQyzY3mSrO9ILroDD84Hgfyh?=
 =?us-ascii?Q?BiHU7ixt19S1V8v5UBD4WTdcr3D/jFU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce716cc1-93dd-4c9a-a5bd-08df40821026
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:59:07.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjJEMcsw/9RknRXFYGZkxO50bDbFq7PY8AzQB6rqZ/twvn9Lu3avPDMQ5q/LxJP0Od3buI9zMbtuWofwiEvYaabAo4an/+0qYHH/EDcrQY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR03MB457023
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add dedicated device tree support for the Terasic DE-25 Standard board,
which is based on Agilex5.

Following Terasic's Linux device tree for DE-25 Standard configuration in
which UART and board wiring differs from Altera SoCDK boards - enable UART1
instead of UART0, route console through serial0 alias, and expose a single
HPS LED on GPIO port B pin 17 (active-low). Enable only the on-board
peripherals present on this kit: a single RGMII Ethernet interface on gmac0
with PHY MDIO address 1, gpio1, i2c1, spi0, and usb0. The second GMAC,
extra I2C/I3C buses, spi1, usb31, and NAND are left disabled.

MMC retains UHS-I SDR104 mode consistent with the Altera SoCDK reference.
QSPI NOR flash matches the DE-25 Nano sibling: 16 MiB MT25QU128 with a
single u-boot partition covering the full device, matching Terasic's
128 Mbit QSPI. DRAM base/size come from the HW handoff like SoCDK/Nano
(no hardcoded memory reg override). gmac0 uses phy-mode rgmii-id to match
the DE-25 Nano sibling.

New files added:
- socfpga_agilex5_de25s.dts: Main device tree
- socfpga_agilex5_de25s-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_de25s_defconfig: Board configuration
- board/terasic/de25-standard/MAINTAINERS: Board maintainer entry

Build system integration:
- Add build target in Makefile for DE25 Standard device tree binary file

Signed-off-by: Bitao Dai <btdai@terasic.com.cn>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v2:
- Drop hardcoded 1 GiB DRAM reg and rely on handoff following DE-25 Nano
- Use rgmii-id instead of rgmii for gmac0, matching DE-25 Nano

Changes in v3:
- Enable QSPI so &flash0 in u-boot,spl-boot-order is a functional SPL
  fallback
- Add board MAINTAINERS entry under board/terasic/de25-standard/
- Match DE-25 Nano QSPI: mt25qu128ab 16 MiB single u-boot partition
  (Terasic 128 Mbit), drop SoCDK 256 MiB layout
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex5_de25s-u-boot.dtsi | 198 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_de25s.dts        | 153 ++++++++++++++
 board/terasic/de25-standard/MAINTAINERS       |   7 +
 configs/socfpga_agilex5_de25s_defconfig       |   3 +
 5 files changed, 362 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s.dts
 create mode 100644 board/terasic/de25-standard/MAINTAINERS
 create mode 100644 configs/socfpga_agilex5_de25s_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..45709953c94 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex5_de25s.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
new file mode 100644
index 00000000000..ba2c0997be0
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_de25s.dts b/arch/arm/dts/socfpga_agilex5_de25s.dts
new file mode 100644
index 00000000000..ccc4bec8c5e
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s.dts
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Terasic DE25-Standard";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart1 {
+	status = "okay";
+	bootph-all;
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu128ab";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Full 16 MiB MT25QU128 device used for U-Boot */
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x01000000>;
+			};
+		};
+	};
+};
diff --git a/board/terasic/de25-standard/MAINTAINERS b/board/terasic/de25-standard/MAINTAINERS
new file mode 100644
index 00000000000..fec445b3654
--- /dev/null
+++ b/board/terasic/de25-standard/MAINTAINERS
@@ -0,0 +1,7 @@
+DE25-STANDARD BOARD
+M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
+S:	Maintained
+F:	board/terasic/de25-standard/
+F:	arch/arm/dts/socfpga_agilex5_de25s.dts
+F:	arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
+F:	configs/socfpga_agilex5_de25s_defconfig
diff --git a/configs/socfpga_agilex5_de25s_defconfig b/configs/socfpga_agilex5_de25s_defconfig
new file mode 100644
index 00000000000..6b99626f2ab
--- /dev/null
+++ b/configs/socfpga_agilex5_de25s_defconfig
@@ -0,0 +1,3 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_de25s"
-- 
2.43.7

