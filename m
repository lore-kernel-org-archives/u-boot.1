Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B69FED2FD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B04841B9;
	Thu, 12 Mar 2026 11:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DHk3b5UE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB226841E2; Thu, 12 Mar 2026 11:01:19 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C7C84180
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAhKdeodBNKtCq7KOVbk4qxr7feF/OaX/omC1pOGXJ5ymD3gZWJviKIcXbNcvkYwpAlf3/536mwqOinJ/fAzsHgBnHkTxAqKzGg6SJ+ECb9QNteAocJR+zj4OV9P5UjFQbQSi69x/uYdEIPV6cmMPl56c15p/dJZhXnyefqfaa0jkSHp8EpBMrva/r99oN1MtMKws2Fat/6AmWEdMHFHd07sgh3Z/gPLXfHxTgDgta6GTdUioYVbYZjvmXfLrvNKwClc4EUJzmVpafmGjPz5MdRIiYm3ny3XA8MT0DHniKWfRjJw3f9tOQxYWxwvGp8RBbvZ/tuR8SmOVzaW9jtomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBKfe/HwGKIV61g/XS9YvC1CRbK6YKSW/yQNF1YcTs4=;
 b=bTZOFXtH3/ZNn4V0K8rQVHjx897SOHov8NNx/et/Yftm/ZaYSLEc06zxBcCq5SfzfAKxVwoCScNNiuCb6nY1qNTnNCAWB9PgnQLvPcHKvfvoXNjKjd43I/0CdfiX/7rAwLoZ0d+AUiDC8mRlwds/jiRrSxhAbQWOczjs+wb9YDdL5dZiRWuweNLm/SrTd84lSovv0dYddrV2f+pdLkPkyBTZ+BdLXqwPaW7kTPZXAq720As/pQoKl2GvKvnYmX7JAOXbaFUj0NZaGKaSwUmCGJZDOuZGMGgCDLgZ7MdwVrF3fC6zjQUjOI1ndm3tSZkoRKcitX6I8xmZdp0qzvClzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBKfe/HwGKIV61g/XS9YvC1CRbK6YKSW/yQNF1YcTs4=;
 b=DHk3b5UErjWFCICaMJPtlq7U3cOL/VxjIXss5aHUdZ9+738wAfj3AtX3OKOzOj2CZBa//nITLIHzbBh+2XTSvIIRscTcdCg2mOzxmnH90wIkvLdSC3FO9o7mC/Sl7QOadHhuk2lj7cW2MQqTUZL7H8vPY5SWqRPw8zkwGoZcDhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:01:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:01:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/4] add [ as alias for test, fix 0/1 argument handling
Date: Thu, 12 Mar 2026 11:01:02 +0100
Message-ID: <20260312100106.702368-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F707.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::392) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ab1169-b554-4891-d4b1-08de801e4a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +M4rMwoj4tNa19TD1NMQDcd1f5+un+zFSF/JK66wYSbp8sqHn1ZYxIThc5WQ3O7YiCegaqM09vYLwaeFjA9R9x15hKgxdhN8WDLkTEV75hCLaFEwtGP+BvJYlwW8YzfdgzMnnUeivlFL7d0B+SwmtSyMMcpsf5yeb5Y3gYvSzn8l7UvCM+yMVGMMtIEeh6+MmATWwB2I+XXqYcnbsQgwqEYpgyYhXPliTK+tNAPdocOKekOsOZpd2OK9myqrhj+wXcr16+iQXYRUE8bljFn1E+4UmF4XhsSVNrkFyGvjbFqhsZRytX+fshiWKdL2JLL2MKT6TxRcxLiTh8TjcwTeglsAtwbj4lFSeRzitx2tLu9UNPBJXcAxqa1xDv3aJNfq4PH7SYuDKDr2Fs1hpj9/o5bnfXANISvj6JVufNvLaKDz+F6C0AaqyVnjUADIsxH77xtpvxzoNT5nzyICu6HVyfkcXpf5lmMLjaETPR2N5KJ4tq2OcS4IejKAP9ArYfi+kSu7yrztzKYvriKG44DzV+8DqsLNQRIFVAZrfh4e1kVl9YogmhHW2OgxcezwF2OAb3dj4doGzRwByIfxIjoD2gDE95jfktwa44W7B0XBACmywOD2fjMNw0kGbXqFgeA1X1C078zRZU1GYKyUEWQjIjT1YqHtKIx9i+KQTW0FkcKhfzzTrsUjKhiLcf+rMShAG69I9U0QKHgo4i7wHoya45nTXSNQ0luUBVdr2pVaQyoaUvWztsSzxgYi073mjZmW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eL1zAeQQbQi/T9P0QQlnUakkAvzqBY/zba15R1DKOogg25bs3ZXscgeIvQBX?=
 =?us-ascii?Q?Ue8pCSKHC9hkTWZdNulUUDZ1dRG280ebecsHh1ccYNDnCbM3vUklapq60QoB?=
 =?us-ascii?Q?oslvorlSLPXEPbVM3pguX19hVMkYcSbC1CZXll5OSmY0ote/or4U6DgHBaaT?=
 =?us-ascii?Q?9mgMd8irexmMDWAk6+IAbEUSIXXZhH/DRP0dPvop5/IW0dgHdk9nd3klojML?=
 =?us-ascii?Q?upW1D5xdLBJE5UiBj1bNaHYc454LrADx8slJ/IsIXDdA9SCWMjJeTva8GUts?=
 =?us-ascii?Q?0vhU2k654umaUgML1PITqQ5WFlrnbCKnxjjITuBmmcsGl+HrqfGaK4nwxTbx?=
 =?us-ascii?Q?LwS6pc9U7MUjW4GAEeQ57u46G33PzoJQhCB1gVFphmVpmeaE0s5OsK4hONv3?=
 =?us-ascii?Q?ydq4vJOinPo3DLXvq588a9JIjHpcWD5FleBceeDHCgboPHjK4toIPfNPFWOq?=
 =?us-ascii?Q?h0eOYWAJg0alYInPA9Sdpb11bfvdSDQFmNKJyMU/JPZgX4LJPgaFwWc+S/MX?=
 =?us-ascii?Q?3hui2k3u/LAclwYBaSZrw0C8H5PjttfaLB+JTkQZl+9r9v16/9hOWfr7h4ck?=
 =?us-ascii?Q?HzI12F9bzIrOLPsrvICY/TG77HiaJlQuH3WSUA7THmpOdbZMD6BATXmB7fu3?=
 =?us-ascii?Q?OFMK3A2W+WNy5CkYwO2aFNTuLwpJd/0idHhnNO63RbTNwSEtmNSVoycb0xpF?=
 =?us-ascii?Q?uHN24p/7MPByfPH8ympCyQ7xBYk8zwO6d99muJ8n6e56P+UW7drjz9CdaY2k?=
 =?us-ascii?Q?EpTx0ef3IXlIvrJN2hC8dxgBgsxojj5BcJtTYn3cCaluleVa8Cw91AZVjmWb?=
 =?us-ascii?Q?9oAA8diuzEQD1pJlke4phYvAjEI0Y6YsKYtMEYJekzjLu+kFGWrqt1OOsLNR?=
 =?us-ascii?Q?A34vN37VdRhORJrrMxJnpWvil2/kNRMeeJ2ODG44wQEUquu/QsiWpwQPeL8y?=
 =?us-ascii?Q?ziW+tlTG/AMrgYwJ2DhltJtFpIivUm/9uxOcqNs++dkrT40iIo9Y++LrBfTp?=
 =?us-ascii?Q?nVxhc9MWHmyRWmZH2vVQMLBlnvA2CbYl7ItVJcZls7q+FRxDXkJnZcZK3Wz5?=
 =?us-ascii?Q?MgoA2mHzXNPAPe3dCZKkEfIP8qij5FeMZ9B4ynPUNBNdojAcxCMVf2wGaUki?=
 =?us-ascii?Q?Sk6nS4YvQ/pu0qVnCHPhsqo7v1H73oU2RnpnnFGoujnllGYzWgFAcYI2ba+F?=
 =?us-ascii?Q?vaQR2qJq0WtdkD8lUQjJYcXBEAC3/3XDpHBoFJCQ/47UovgVt4u5d7sPX9gx?=
 =?us-ascii?Q?8AyYpsFPopYLVjEoycg1tZUCQ4QLUWD4tTfLRJhGSc88qt6VRTHnPHj/PtGT?=
 =?us-ascii?Q?Ua4J1qklZNmB8DHm7SWlzrRW3+kfGO/lsm+SsA3f25tRILJANZrfTTUtwZXl?=
 =?us-ascii?Q?a4sna42wg9KZPhPZZRDGtZbcBMS7RLKr7YKSk22W9+F54BMkPQNWh96kxthq?=
 =?us-ascii?Q?yd2K1bwbb/n2E53F7p61pSd+3Fe3cIVfcSN/jasRILbdEJV0WfHjgAkbMaw6?=
 =?us-ascii?Q?9hBLSmJgts8If4O6w9Qnp+RHse1mEpsXkBYLE8CqwZhKaIrvCylxRsJ87WPh?=
 =?us-ascii?Q?RpP/AihJvPdXj0KOkLZ8CbJGMh9p9FC6JlO4MY5GbZl/fh5UU3pvYDDlFCZI?=
 =?us-ascii?Q?kdRXe38kIZBHdpQ57o88TGX1FvG4pMm2g/Kya8WTmxoMjz819G+Pz2po0vxs?=
 =?us-ascii?Q?OML5imgIyNCaek6QnrlGrr9zJzB/D9DLY2JeyfJl77T6XSgBfU5+42BXpBjX?=
 =?us-ascii?Q?qfgzvGIxJOI34UX2GaPoaPkBywLvmf0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ab1169-b554-4891-d4b1-08de801e4a2a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:01:11.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V47mIqd/UAr9Z0XgbGqvh9zCrD1vQPi9qVtTnD2vasToDNWU3G0nAwXYXm1LYJO3IqGRK13WfLKVfambUer39FSMAvmpF0aorEubnmlLNbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6694
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

Make 'test' behave a little more like its cousins in other shells, by
allowing the [ ... ] spelling, and while here, fix up the handling of
a single, non-empty argument to comply with POSIX.

v2: update documentation, add a few more test cases.

CI is happy: https://github.com/u-boot/u-boot/pull/905

v1: https://lore.kernel.org/u-boot/20260311120910.3934114-1-ravi@prevas.dk/

Rasmus Villemoes (4):
  cmd: test: allow using [ as alias for test
  doc: test: document [ ] spelling of test
  test: add tests for left-bracket alias for 'test' command
  cmd: test: fix handling of single-argument form of test

 cmd/test.c             | 30 +++++++++++++++--
 doc/usage/cmd/test.rst |  5 ++-
 test/hush/if.c         | 73 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 3 deletions(-)

-- 
2.53.0

