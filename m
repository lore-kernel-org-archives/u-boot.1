Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C2ECC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DB1C60B0B;
	Thu, 15 Oct 2026 13:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oPbFyY-T3JEF; Thu, 15 Oct 2026 13:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25C6960AD3
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070120;
	b=MuyEKdiWbreJDFvb5ZUKLxDOKonLRhS2PoM03fTyYr+UmNjyZXCxyW5sN/tKl4ZAxbGQ
	 A2Ng0WxaoapVG81Z3Oyl7P1937LBxSx/QFKjvTYfbaNEih1CDdTlmzzGRvm1gY5GO1qD0
	 tPb+eDetqs3PcbFimTRfTk/1NNgLPeEr5VtbktWErXJTKEfTUQ1cLVWci2Jw5d7kC/9rC
	 p9MsaA4+i142j39z8EvDvMakC0/GiRmg0DiiHhrQtdmf/pvUSm3jTrP6M7UKwuWxxgtOh
	 NhJqyHBkyACX28QnwZNZMo8MH0XLSsGEALfp97wzyMLeRgNJrD5r2B+gMqTCXjNsMzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2510IZag5BPptcmRM00QcwZALjaEw9JpgNNWBoJT1K0=;
	b=dZKKfoYmq3hIMY0J9OjLayj7DKvW2Dt801tOoRDSnGgNxqf0/5+s146jdrp2KqBuqKSY
	 mEW2ce7cZTVLi/R6oAuPI/KcYsD//40f8ZronA23IktBrDttR0/iYKdsJCBYdRDxeZs4r
	 VvBWQtBABNvKzw7Hyy33DoFXCC0OWLQUFuQIsLwX+DaFC1b1NucyJDhb6aOXArHeCZzVC
	 tg44SRw9Pt+kZdmTArmog4SqO6UBPs3157J1ODhkGrl9Fw2O1bCamN8V/B4lFH2rUCsqM
	 zP4T4bzRUYCxjjMbs0gcr1xawxC90sNxEfG0bQfNIeZrpQ5fv4ldPYbLJ7pUMT1FApg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070120;
	bh=2510IZag5BPptcmRM00QcwZALjaEw9JpgNNWBoJT1K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfy3g2BByHFXH56H2zSV0O4VfYI99voqN6V+zQMzXg9+PjVyrD8I2abAOJUWrcOVi
	 5KnE7sA+KaA08GoQfxi0EZGRhZVmoKTT2wRsQ2C4tTz5z7Hu+tZ3nkVS+a7t/w3sGy
	 2XnkCrekZNf3mEAv8L7AURzzbRIoXbj6flAQ5Ooz2POpWQdBwcnzyHyxy/5JmpBhg3
	 +bsHUbkLRpZQG/9ICIyKx/nyEzhDz+cJAgvwrz1ctPBFKKAAEfVLJUA+lbTs0NDbR8
	 /CgfKFCRCbMRMwutlOZVsRnKaw1XvFwMo9zq7JrZ+mN63XvGo/DBD0Lo/IiSPdTAbu
	 n3O67GSTNWn/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25C6960AD3;
	Thu, 15 Oct 2026 13:15:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E7BAE49D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D99284084B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxyoQ_jk1_5z for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C0164080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062845;
 b=USNkrSe96LeSKIPCMJ0Bw+HQP+KJtSowYTJbTz5frg8tTY6JjdMrk9eVQvRpzbBOXxX2
 0KBDgZZ1N7N1SuTF314cnUjZHxzPvWdEqgzSaqMrqJoryLxn4B9my8k5t/h2fa3CKkaPd
 3gMwoylRRDnUOp+5LPJOuTaXLnB2wXiVmrmM1zlzurBIqmy5LQ01V89wDlL1E9wMPoJPA
 GhLOx23IdRG0ghZRsJVOqn1oNE8Jt3KMqhOeikAKNoMIGu/iQdPhECGfia6/eC3A2wCDM
 2ngMt3TXiOxJFBjRUU8x0cdzdM+DJEnRICy11p8mbzSSSBJRFtWG1k3DAzeFCoc59Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062845;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=2510IZag5BPptcmRM00QcwZALjaEw9JpgNNWBoJT1K0=;
 b=PBtbujQD63Wt2BrVKHedP/RDUVgZii8qM+PGuzfAdcul+HW4hVK3/JwvtZGx9+ZuCe47
 ebq3l/fyrWY5qZubcA4JaWuvNQg/o4qrgieOucTErRu0CQcbzwNrWyRPCFcIoR08TFIUG
 iDHZJz1pIKfYldO8I4xe+tuFgP/Git7OHd7pFeh9yte2Qt/RA6TDuP4JwG51bs1NKWvsR
 PreoTGtkuarpI+BY1iH03peXeEQirnHQemuYLPc6Ho1a4zw0kYWhTp7oJPeUzjbfEVpzD
 wJzkwyYF/NDRl30y2Jpiq59Yzcvt+Kqw33/I8Vy2i10oaBUrTrmyhWAnkhZYBWbzGQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=ULm4BEMI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=ULm4BEMI
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C0164080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPBfcPDmtzp7O37DjTqaAwErCCYxAI343st9hzILTEWg/BoJnUG6fgb7dUyOSvuCftcTtljioH/qJ5uzYEklV7muzsyR9bppeM+sGo0IDP/PC/ho6hqAYFpTgBdl9QUiBjnFX4jYawYdJx2md5nHYrYYR1rRQ669CxAr1Ai9jCkyoKKo4z0up+sIe+RWo5yrU5hYWn3d7yVBUB+pQHimD8w68NQmMEIUtEbNXkux6rUjPcO83eVPpuN3LSlzOr+DHa0o85ZtaidCZHfiADlRkyyQyJLVPLE3HeGhvivnd+jlsISMTMMEIETZ61n71z4DcDraAknqu2ccHOmohFgpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2510IZag5BPptcmRM00QcwZALjaEw9JpgNNWBoJT1K0=;
 b=nhrbBMEsuxqj72lx9x00ZIz8tO/SHN4dlvg8hTRuxBYAb7Nluwiv4T7a4msAMV+JVs/pL2muzIKdyckzRwEM7Tj1OpZz35ShBkS2RzmjYQOjPIbhYLWdB1uOa8Zl6YYviqqa7WGZICOcws9yeK/zVZQUWsKyLHAGCzzrO+dfOlT0GRyhceJiddsYxgtt2UCwpnAx9+wSIGZWMXKpi42H3WWwmusro/aQxlqpSBGKws425MaV2OREY4Dn1EZnIiD/n7oI2zyrefSyIYcv5Ci1Ckv527S6E21Nt2O2eB/TBzUnS6btcuOZuuvTFUmZuJCZEc7cPGGrycuH1aH6yc/WjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2510IZag5BPptcmRM00QcwZALjaEw9JpgNNWBoJT1K0=;
 b=ULm4BEMI9B1FdCMxy5EQ4VanJ5E2eTvO0prOeLNdzjoJj4sjTCFyWUQ9tXfd9H3UumMjLmM53P4wsU6+mhfRoqxneMT9pzYIQAJlqFgxnO1b8QsoMQ3i1eBGGWj4vGS37EReT+nvWEVf1vJ6H66tDEYLk4RWyjXIZCVajpafOAy83RF7SPI+SRheLBriAUhfXgV8R8II+v76UsO4IBf47nrpmlL4uKqopq3ecbBFPowDwO0pZ76MkqbdMD/wfi3PhLXVOTIZvT9fQgXalMgo9f3frN9VDrBguVrY2oZhLiPUfvBOVshJSHXZUxwXx1FUz6PReudn9V1+GSwadZ+4Dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:14:02 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:14:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] MAINTAINERS: Cover all virtio driver-model tests
Date: Thu, 15 Oct 2026 19:13:22 +0800
Message-ID: <20261015111328.1269775-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: f88b21c2-e80d-4448-a53d-08df2aad6aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dlavGtJtjEG8M8OaT8M5lrg+xOpxdqiQu6sBtWOYUip4JGMeAxbN0qzTiNGd0GWbV+S0kXIf0z1iHgbjBXLao3ANCnpCCWvqAZvBlz7CYVQT4QEf8EIh9R5HqImmAhtyt4TOtW6T/zPM/u5ws39Yw+HdW/HfcuNJXww1DrvmLmIwjIhgrCZOKeX5ma4vZMpKYidKKhJ4LGnt9Dpm0KDR8wzJbseul5brPYB5gIMvaI06ufBxvC6ymTTpanVbolTgkpaXxjxd0GTxNsbIt1eU4LyZv/bOeQJ5v207qTtY1Wo6SfhgWw/285uLZN4edOv93TkCLaMbxDVvBdQISTMa7g78n6ko2vi+4Xlw689TBE4zZC7azhdwP7D7+8Ba5vKB70DFH0ndueXwn9xVFA/B0Ir6cB4o4JBQEtghVDnKf4KCB6FV8Hr0dqdQeJvM+48o4QxkwQG+GPpI0bJ3JU6eRxm6Hm7W0yMz3/iJRJA2sB7cd7b1RMNORz1XMC1Yr/wd+nmvIinbTWCYneahVOSYlOCK/+tS5b+VCsjXwbAPiIvphp/9qpYd6QXgh1rm1W9XwmO0M9+TSHp6aOO4E9lxEzVk9CbaQeGXEKrlvdBW6sNrDJhnrurpxUexVQ5mmsrbgLAzAig9tX7ziD/+Wk6R27abm3WbhmslUNy+CRhxP6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgZlYgOTS7JTMOg2s8rngI5gZdkKxpjUkSHTLzngThG9DWmkpnvDKXmmQ1Li?=
 =?us-ascii?Q?KNF/97zVK6WPpZGcjxzLxKx4k30uQXDVrouH3fwV8UdZLbb8/+kbCWR0n93t?=
 =?us-ascii?Q?Eq5G+7c0CxBIfiWs49SkJR3TFp1G/pFldglj2YNug1mdkmPUKpwc4byltQ4m?=
 =?us-ascii?Q?LSWeiN4CDFD75q/nbo57AdHc/9FEUZbc9dkFCA+bDSDp8hHYAesXAwF/8uY8?=
 =?us-ascii?Q?flgh3Kr5y9FBvHXqu7AibjBvUwTZJRs1UNYRJ4mefsBi9r8ysNCfs/ezhk3m?=
 =?us-ascii?Q?m99u3Ta4uxD0vak1HVJswAobN/N3pv31euVEH7jQk2x8dVRMLsAt4UAfdbsI?=
 =?us-ascii?Q?ciHyTP/YpZ6gIKtMV0S/9xOynfkUdNFc4M6TG1WaUfDsEQPnFHPEAwBjZG+w?=
 =?us-ascii?Q?QVcj00+S8O1xlbPBlHuV/qM6Ptu0XLIL7wWZpCvs+6Lc03l6MOL5d6tCqFh/?=
 =?us-ascii?Q?96CAH331aX8/EVXK72IVXeHRE4DAoALiJFviqoI1Fq82/R0gxTtJ6/WVrbG0?=
 =?us-ascii?Q?rlbvr2G+AGLQJyO6PpCmr4D5tLELuFiDln+mBq/7qutP8qItnokbRHb1r4Ol?=
 =?us-ascii?Q?6JAuoXbJRngHsaJHkeLqiUtd4GMt6gk8fGTWm6bzf/LJYRahUHA7iOnS2IAQ?=
 =?us-ascii?Q?ndoBnneOieVMEjvL6DBGHYe3Djdu0StZGUGF5nUXsbxIizn/yyomGfyNyVB7?=
 =?us-ascii?Q?LjAa8G7hwcbgUZ4j38uTppnoxt+p8LdzCadmViadYkia6FYgj6aisEVWS1xd?=
 =?us-ascii?Q?zDDS0p4E+3qsOiL4BQ8P0vlXMm8/cA58QO6wMWjYYw38nVfm4CVOVFkJVMRQ?=
 =?us-ascii?Q?4ImtVRwprbPkxZ3eoW3MiWUbIpKGwhn9PKmGwAJYQFj88CDZMZHLnxYavRp9?=
 =?us-ascii?Q?8IiFKl/o94HqQ3w8hqmyPrqJFsc3h4lSDWjp7O/bEqKbe+GyuklZdlaFD90V?=
 =?us-ascii?Q?0Gv7o0aO1AyxibwkqU2xKCyXZPwmAJtv22jEMyKZLwyEcwdf+Zs3t+G3bPii?=
 =?us-ascii?Q?uNHA5wru+7ex2H0rXs2kj5VmG/j+tsXAVgEbYat+qU8cAbRUM5OEXBjD3u/f?=
 =?us-ascii?Q?Sj+6XwvUoXOORTAA7/VTS7nZGyYWT+wpmvLE7pK8aQPTYmL+AvZryckPAksg?=
 =?us-ascii?Q?US3FbZFWXDH0bJf18ffsnfJwEhuxDBldNL+qc3mNtWvx2qu4iyhOgrkQOGge?=
 =?us-ascii?Q?2gsSJu/HmZphpEJQetX9Bcf5GVgEachCVUlPOyhJ1vcvtvyq38y6XhASRbYd?=
 =?us-ascii?Q?Dzlg8luB6BWHK89/PbRrdrO/vBKNFg/fx0HdHDTA41zCwgHuPE4XFwdXlsdw?=
 =?us-ascii?Q?4YMkSsCvEm3OLyytS9bKdv0yutfcQoTDkIswXzTxeQGCR2pRjE3g8FHIaG6t?=
 =?us-ascii?Q?F9NieWQBQcW79R4/PX4l739zPgYmoxyKZLj6t/4TWu3Uuwoj+AT/o79P7cps?=
 =?us-ascii?Q?CyG0i9JS0UIHq2Y7oinbZwwv9bWExWBfRgA7EJAVcoNfWvsEEWLmjA7p12sB?=
 =?us-ascii?Q?PMc+IbFk+B9Y6Z2nHOPcbz0Sh4I490xW1qWc/1+aizj7idXMfHAIhCGCTCtC?=
 =?us-ascii?Q?MUMHu19XX9C8S8VVywA+g98BOIWxJOY06bBS6hyiNVisiu8J4MtkwBUi2+bh?=
 =?us-ascii?Q?UVzZZ6krOFvXdahE6tFWOlo6JdUSeJafYcumDS1kkEaYUP6sCrdSZiBbJaGO?=
 =?us-ascii?Q?2qMme8ctqiNvV9Lfc3OKuWMbNjkMcsfecrsvwHCV7/lxlDDx2yhc6hBSbSoo?=
 =?us-ascii?Q?7mX5163u/KBJkjdweAhMXGRRc4/2tyY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b21c2-e80d-4448-a53d-08df2aad6aa7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:14:01.8889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZapYJOm4wiI1pBav7b7RZmFd2KbQcu4fRwpLqUeICXyebcgNDMRLksjRB3elpLkXtJgT+lghJ/0Y26dVZhPBtMty35xObi7vjQ/yBYcUgEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

The virtio entry only matches test/dm/virtio.c, leaving the existing
device and RNG tests outside its coverage. Use a wildcard instead.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c36..05963a84c0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1869,7 +1869,7 @@ S:	Maintained
 F:	drivers/virtio/
 F:	cmd/virtio.c
 F:	include/virtio*.h
-F:	test/dm/virtio.c
+F:	test/dm/virtio*.c
 F:	doc/develop/driver-model/virtio.rst
 
 WATCHDOG
-- 
2.53.0

