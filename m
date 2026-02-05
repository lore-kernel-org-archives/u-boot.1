Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F7BE91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD01783AA9;
	Thu,  5 Feb 2026 16:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJYLda4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78D283AA9; Thu,  5 Feb 2026 16:16:12 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44CA83C2B
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFDHc5UUV42Q3IlIaq/gLR/qp4pHKd+Ajp3L1pLJnobk05S2FBCAua6PIj7wYIHFfd3PX/527ttLdagZSUJlJwGykOkdB8GvrsBpxvxvfUI+NN3/JHIvNO0IrbYqRcvirqoJ7jdM6W+MT/QARauKcziGuDm/XWbtlaxiL8fDWp7n9K64RLoV/YZwPyE6nAteQLh9D3R3m05q978SO0Uu/qX32TXFd5rBfynFslvlAZ9JpF3blklcts/NmDC8Lu/zf6JxdZg0WNxungTRABiDS2qDBCKGC3Pzs/0MEmZqAD6co6H9DrcRnhqWgu8s14AW+4qAXuPlAHwne4BPDoByAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9nxDvmKEBAXgpGr8qqZ56NEnCactglg0zYDt9bf74c=;
 b=lwVLesfSgn3c8Jo8KsaWblaVIZHeLJrSu1qs4pYi8+U9miErO5X5Ijiivu0v43J8QHcmIhmYdqQ2XMP7wWSHVGYJXceM9dlV/0L3kn8wBtE1jD92xWsyEYYTTLIz5Ic75f5b5GXckrrCC+YwDNi5e88ed71E4OQycXAIvsTfk037maRy7NCfc53eTp59zrvC99Mkp45V8ZysUtSLNo2SSpeAnsoTY0lF07421Ql4syeSAgdOWgh5a6rs+n4L5W7By02rBYlqXAv8v+0RHB3e2/e535Ws0r7lMt5MM0kVRucbH1H1GIglwD7bg54Ssr4nGwszjQHvK+aESX8gTGJcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9nxDvmKEBAXgpGr8qqZ56NEnCactglg0zYDt9bf74c=;
 b=MJYLda4eModvI8vukHYZKnRemspSDV52XwRqtY0iuCyKbrMwiAAIvfB2Aafc4Up9qddOt8zTCL/wfMgXOBpH97C4jIP1ftctdM+M5ESBc4QwDnFE2TMxuH0e3P7RbxFseVoqWeb36kb7W8PGutbLLnyKPpH7BAqaF4AuXBlS4PyJTO01SE2QaVvsqvjhz3B6ljE0mdc723iA7KnZVys0YWKC75NREThN+yxCP5XAekQBiEhMu8Jlg7fLXH2JqQeS3n6TjBK8vO7tHHO0bWPOJGjkXuA0gMM1FxQZ4iWYC/sw4MEClsZ7EIUBLfJ6Z2Z1qINfrs7Di5iMwY6KyKOe6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:16:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:16:07 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:14 +0800
Subject: [PATCH v1 08/12] arm: imx9: Add i.MX952 SoC support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-8-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 459b1c2c-c405-4513-9d24-08de64c97cb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFhWNFJwLzF4UlBvZVF2ck03bHhVYjVYTWwvQ1N6UnNpMm1UaU1EL3Q1VWxM?=
 =?utf-8?B?SW44WkRLNTZKNmhrcUdQMnllRi95WTFWYlR2U0JyNndKbGVJWXdMUHY1V0c3?=
 =?utf-8?B?ejVqZzluUDM3MkpHdWYvQlBMMHZtU3Z1elNCMW8vc3B1UEVFaURtZDhyZjR0?=
 =?utf-8?B?Vmx0WEpzamZGQzdJd1NSeWNOWjNPaS9kaTZ0bWlZekRpZ2JuRmU4UlU2WVFk?=
 =?utf-8?B?bncrTm0rdzREVjI4TGVsdUZEbFY3VXA3N3c0NjBOV1k3K3BOdlVSSmMxQW5l?=
 =?utf-8?B?WjZ6UHdWc0huZ0tac3J2UzVvQmNOdlZMTU9nZHVtcG0vQ0loRUc5UlJJNWo1?=
 =?utf-8?B?dTNRaUh0RDh6Um1kVWFqcVd4VSsrdnJ5dHQrRDRSbzJVcERQRFJqNlp3bENB?=
 =?utf-8?B?VHNWbFZEQ3NnRVZaZ3pDVE9DTlNaUzQvZjEyY2s3ZWNpMFZHZGwxK2FYRlll?=
 =?utf-8?B?UCt2NWUwc2xFMjF2TTlhZk5RZVViVm1BSjYvWXZUcjhadDU5SGJVZ0pFMFdp?=
 =?utf-8?B?UnRaY0JNcmxDVVRQMTVEc0lncG8zVlZJY3lUbG5JYy9mWGxlQ1EwT0c2TXVW?=
 =?utf-8?B?Z3J5Vkx0T2cyUGZYaWFEbHpoNkZnaEVWYXM5M1ppZnJNa0JjRk03WUoxUDhV?=
 =?utf-8?B?aHZzcDJpTWlFZ2ZFQ2ZCaHlYOUxrZ3FKRnN6QnFVZmlNbjZ0d3lhUWhHV2NW?=
 =?utf-8?B?WmRGa1BBbkxjSTMweFVtc3pQdjRzYlZ6bjQ1amVCem1waXhKWHFDREJ5SkZS?=
 =?utf-8?B?em8rSERTL3o1SWtuTGMwVmNWWGxyQlBSYWtHR05Ma3RlRjY3OWFJa0VLdE1J?=
 =?utf-8?B?amJydnFBUjU0N3JQRW1DZDljRU5xTTZMa0pCS01PL3U3TnFicWtucnFtMzhN?=
 =?utf-8?B?QlZZa0F3MEx5dXhpcjBRZWJyalFEZlBRNjd1MXM2SnVwcXdjOXlKSGFTK1Za?=
 =?utf-8?B?MFdBUzVjWmNVY2hFWVpCRjhLQTBZemlvVXRscHVMTWszQWpCT2F2STYweTRY?=
 =?utf-8?B?ckVXSzZXZTU1UnpudG9PMW9jeDRNYmpYWlZwT3VFWEY3WWlwZTJDSWZER2hu?=
 =?utf-8?B?aXZvMGkxMk1neFIwbzY3K2ttZDFOeWZQeGRjREVuclliZFVNMWlCR3RaS0NH?=
 =?utf-8?B?WDREVmY1WnNUa0ttZ0hvSVJUZy9nZmpUbE9kbzNlK3V2OWNKeW1KcG9GNzU3?=
 =?utf-8?B?b3NLSUxBTkREaTcvb3ZNWE5WcjY2MVl3d3BLMVdhUHdkYXBZb3FQTkI2NGMz?=
 =?utf-8?B?NVpBUmpybTlGRnNxaCtYWWVDVkpYMWl1K3ZzWGl2NU5vT200aUN4MUJkenJI?=
 =?utf-8?B?NlIxeWo3TG53UnozUXo0ZDlSV3NzV1lPRVlXNGU4bkZNaW4wWENweFhPREdP?=
 =?utf-8?B?aFQ1OHJQNUJ4Z3o4RllDTC9uU3kyWWFGb0JOWTAxS2pGenVwVTJSNElNV1kr?=
 =?utf-8?B?dFc5NDZuYjZZcmFXQlFwS0xqOURUdkJhVzYwU2d3dHVXTVljc3dCYmZKMDE5?=
 =?utf-8?B?bWN6Y1BYSXBvdmZPK1Y5ZGo4SXFEdHNJcVM0R2xmQzZ1MXMrNXd6MXlhdkJt?=
 =?utf-8?B?dm0vbEFZUTZzU2Rxb1QwMDlzM0IxYk5tOGlXdGVuMnZhL2tPVjFrZWxUVzB0?=
 =?utf-8?B?eWMzR2NkYXFUUVBVYm12cFU4aXBpa05GSnRUZmZyV1I2cVd5VkxTZk9NU2RB?=
 =?utf-8?B?WTdPVmJGRUs2UFRvMEdpdlhqK2xoajB3ejFENjJRVXVTRTFpMlljZkVrcVQw?=
 =?utf-8?B?VDFkWFN5NXZTTFphNG5XVFJPSW52bHdnaXZPZFRjY05Da1ozQ1hBdjc1TWN3?=
 =?utf-8?B?UFQ3bTBROGVqcHRRVmQvMkVQR1dPRFlNbExjQWVPZnRwSVhha1lVSDE4OC8z?=
 =?utf-8?B?VHhPOFA3REtrRHFhbTUwR216MXZLcXZ3OWdEano2WnRyOTd6anRhTkZqSi8r?=
 =?utf-8?B?TkxPalhHdm00bmQrcW04a3dqZUtDSk9VZXFVejI0QWxDTjFOWDRBMDdvREdn?=
 =?utf-8?B?bDNqV3J5Z1kwL0JyejVZaU9tNWxVRWtFcW1hc0hjUEF3ZTljbDBMVHdQNzVj?=
 =?utf-8?B?aFM4K3BVSGF6V1JnYlIxQkVzUktVVWZQSFZnb0ZQc2doRVVBd3djTUZldHVW?=
 =?utf-8?B?Tjd0dmZjZitnZkM1Qjgzc2RjYmUrYmdXSm4zdXU4SUkrUFJUck9hUENzbUFr?=
 =?utf-8?Q?c+iZUo8chEeQPneBiqW7uU8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmttWVB0dXlsY0lON1dQSG8zckU5ZElENGZ2bVFENEptY2xCTUNoaHhCdVl1?=
 =?utf-8?B?NWowMnpCSitGMXBzczVtcUdVOHZUZnp0K0V3Tm5CU2RtUGQxTmdVbE5XaGV1?=
 =?utf-8?B?bFpPZk9XWG9MRXlSOFlZZld4VkJFOFhLOVNvTEVGakRkaHF2bVRZR2duVC9k?=
 =?utf-8?B?MURFWWRKWGRRZEVuL1RHOExMcVRwcU43MXdOQXYyNXBWOWdaVW50aW5rMGIx?=
 =?utf-8?B?VDcwVklidklQS25YcCtpbWJrd1MzVDBweUpPbG1qOE5qaGdBeGM5L2NYVFVZ?=
 =?utf-8?B?eDcwc2UzR2kzVDZUN01wMDMvVXJtRzUxQmU5UXVQNTAwNGFrNjV6eU90ejhH?=
 =?utf-8?B?bGNFeGZ6bGMrdXZIaEY5eTBUWVk1aWExazV2NEdkOUxXcVprTjUzQVFGSmhm?=
 =?utf-8?B?N3BaUk1DNVk1RnN0UmV6R3dYRjdJTkZyYW5rdm0zeTl2YUliTjlic2RwNndG?=
 =?utf-8?B?Yy9zTURSU3RjUlduZ3BtWWtWaW1PczJUVXdSVUd0c2tDUDk4UU9HV1FNN2Nx?=
 =?utf-8?B?U1hYbDNtUWlQZHRKVjNUQkRKMWhIQ1dzK3pqMnl5QTR0dmR4V1k0dmZNWkhl?=
 =?utf-8?B?K08xeHZrejQ1c0tjc2pGTnpuY3o5OGNLTm5XYnJTZk1VQUxoczhGVm1tV2lt?=
 =?utf-8?B?TlpTZGVBVnNmaU5oN3hMeFErcEhKRDVSQlVRcXc4L1BGVWNXaXBSQjhDdHFm?=
 =?utf-8?B?cWc3T1Vmd09heEZlZjcwdG9kUUFSb0RlMVJUdnVnaE9Idit6OUVzc1Yzb0dS?=
 =?utf-8?B?WDRpMHdNdy9saHA2OGpTbTFjaUlLY2sydFlNYVIwU2JyWmVZQ1VFZUM0TTht?=
 =?utf-8?B?S3hTQmZOQklmUUJEaWlXWDltK2RxcXFsVnR2cTIxL1ZHd2VjUm5yUitiUzFi?=
 =?utf-8?B?Slo0Qm9HTjJiRFBCRHlxQmJWTVZscVFSay80UU14aVVDajk3NUFtV0t3eWo0?=
 =?utf-8?B?K2pzVW9mUVltQ2thNEZTNmtLbDhYdnhpRm10VWZuRmpsQXpScW83RXJDcS9j?=
 =?utf-8?B?cUpvaVBxaDNoQm8vbzhqTWtRTzJDL0tYZy90QVlHNEg4Z3FGMklvdVlqWHRS?=
 =?utf-8?B?SE1SL1dHTEI3U0xVUkRhTUdPY2tZbThNbHRJSFFsNE11V1lESC9pbG5nVXdP?=
 =?utf-8?B?QnFJMzBUNjlHajJzdElaSVUvUkttZVYyNzhEejFDVHorUUkzSXozNGpMQWdq?=
 =?utf-8?B?T052ak02OFBjWEh0dUVqbjQ5UGlVQnBiVzhOWTk1dGE3d1NTdEhuK1lvMFpF?=
 =?utf-8?B?M1E4QTJ4U3JXeGNwaUlwd3B1SXdQd0E1U2NQeVFUbDF5bzR2Ujlld25EM3V6?=
 =?utf-8?B?UWZNNTVrOWZ3TGJ1c3hSaFVJeWFvR081dFNqZTZNeWViT20xT09EY29NU0po?=
 =?utf-8?B?R3F0c09FUE1rSTA4eWhZMWlBQk9Gam1ZNUg5bkJpaUFCVFdycytnTng1ME92?=
 =?utf-8?B?ZkwxaE9vMHZMOHpFNWRndFhlTnQwMlhsdlR2SUQvcHpHT3NnOTluVzRQdTlS?=
 =?utf-8?B?Z1FiWHhDSm1IRE1Ec0YwaVJSN0ROZmtWMXNDNXBHV0VnSFhkUE04OE9XS0pM?=
 =?utf-8?B?QzVYcktDL3NFM1FpMm1SQVZQNXVzWkRQWVlIeEIwTW1vWXJselNUclBQcXo4?=
 =?utf-8?B?K09tMWpHdmxITFduWU9LaGtCUU9QcjhOeWJHdVN6aGE5UUFDdFN4SG5pSmJy?=
 =?utf-8?B?OUxHMXpvVDNBVXNWQTlxeGRmSGhJU0I2TG50VHdRb1UveTZDWDVvSlowb09z?=
 =?utf-8?B?azNpekpESnBaNjNPLzI0ekU3UFRUK093SnI5NWpraWJvcHN4MmVpcFA4Smcz?=
 =?utf-8?B?dFIwYkkrUGJIRDZRd1BocG9zUmxkZ2dLcUxtWURMcW42YjJTYXZuOE5IbWJl?=
 =?utf-8?B?VlV6a1dCZnVRdThGbmRkaXR1cy92NGNlMEVqMmhFb2ZySlNYdm4yRXk4Y2Rt?=
 =?utf-8?B?bmkwTVNQZUtieWpySEJXOVpsMm1LWGd5T1ZORmY3dmlRZHluck5ma0t0T3pO?=
 =?utf-8?B?V3pXYkJoZHdsMjJQTkJ1aC80NHF2a2E1N1pwVmduMzVERWs1NGlENkdxZVk3?=
 =?utf-8?B?blFXcUtpS3d2dlF5Vy9lb1FkRjRRYjlnR3JkSTh2R2gzSXNqSnczenliWWVJ?=
 =?utf-8?B?c3orK3pwc2YxcEN3c0s5N2N5NjVkV3psWFpWV3lTTFR1SUMzWUhnUlBnOU1r?=
 =?utf-8?B?MVlPcmtXVktDc2E5VktjdHlUd2ZoUkpWVUlPWWhNZWY1WlZLVUxIZ3QrWXNC?=
 =?utf-8?B?ZnBZQThZVXpyMStScTMvcnRvTjNDQmF0MXczVUFQQ0ZFQk9GNFVaWHcyT3ZO?=
 =?utf-8?B?Z25ZVjRpQXp0UGVGM3Y2dWQzc2FKZDdMelptNjVhR0xFejZlZERnZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459b1c2c-c405-4513-9d24-08de64c97cb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:16:07.8607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJTjuZLunHUlJT/91Tld2WeSvVZ2Y0IsTZmiKpLO5Apd7oibwCTnIjslFkxpy+p/hYB00NNVjcJ+KR+X8G2UbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

From: Alice Guo <alice.guo@nxp.com>

Add basic SoC support for i.MX952:
- Add CONFIG_IMX952 Kconfig option
- Include i.MX952 clock and power headers
- Set CPU speed grade to 1.7GHz for i.MX952

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig       |  9 +++++++++
 arch/arm/mach-imx/imx9/scmi/common.h | 10 ++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c..716940930a6 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,15 @@ config IMX94
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
+config IMX952
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
index dd4675402c7..c3610127dce 100644
--- a/arch/arm/mach-imx/imx9/scmi/common.h
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -21,6 +21,16 @@
 
 #define IMX95_PD_M70 IMX95_PD_M7
 #endif
+#ifdef CONFIG_IMX952
+#define IMX_PLAT 952
+#include <imx952-clock.h>
+#include <imx952-power.h>
+
+#define IMX952_CLK_SEL_A55C0 IMX952_CLK_GPR_SEL_A55C0
+#define IMX952_PD_M70 IMX952_PD_M7
+#define IMX952_CLK_FLEXSPI1 IMX952_CLK_XSPI1
+#define IMX952_CLK_24M IMX952_CLK_OSC24M
+#endif
 
 #define IMX_PLAT_STR__(plat) # plat
 #define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index e573736825c..f0443ccfb2d 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -154,6 +154,8 @@ u32 get_cpu_speed_grade_hz(void)
 
 	if (is_imx95())
 		max_speed = 2000000000;
+	if (is_imx952())
+		max_speed = 1700000000;
 
 	/* In case the fuse of speed grade not programmed */
 	if (speed > max_speed)

-- 
2.43.0

