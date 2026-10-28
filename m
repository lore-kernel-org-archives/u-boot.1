Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P+1vruJx;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=fXTtqV7V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0631C40520;
	Wed, 28 Oct 2026 13:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_mZzhu27h7l; Wed, 28 Oct 2026 13:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A22FE4057D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793194584;
	b=ZUfKVXzEscSbu6LAXOE0IBAjeD2l4dJOYh5J9OgaMadGfMyDkTq3iGGXNtLIUMiP21aA
	 9sXSmber7FjG8t4MZd7BXguauIKCkMgJc5rk31OSVF71MmIF8Pl3K162xtPWmjJp7qnFm
	 JpRZiIa59lbQZ1wJNPYTb47HieTS2LEJWCOZYPzkOZJwxJ0kKWqTo75LN1BaRw8SqXgDd
	 iVQEMnzOYrz2kMGri4+1k5gIKpsTVfIs3mgHDwnWeBbQynnt+sI/l+malVBGVJan2obZ9
	 fdxRUUiRpDnNNlxh3jsQR373XvFlKZYqE+aAvcWXT5GFibcgV0Z8rk7zlRqpSxUAa/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D0Scgz90qPg7RYr5xMXn/Pqx8g88ozFqMog+si7tWyg=;
	b=ehvXz0tbQ2I1ISysXLdy4jHn83euiTCpHzdakG1LMIP+I/k5gJywjYsKMC/YQgxZYUka
	 A5Hk+5ArJ+fLqp4HaVxaZyEz3fMr+KHf4Zd+CnGZd/d65L3GvfQ6YRuBfvSHpvXNjhS9Y
	 qU2z6ANJ6TdsdVtjGAdukzDEuYOQ7B5Fh7OdKBleH36V9BaGLg0F6N3V7LOhP1O17pAO+
	 B3cXzs5jY8Y91OzLjD0FnFqBPyjbukP6aBY1eLyjKFhoHae9oXhUqmRsfE6OIvHjLAJro
	 6ib2oizPyUdtvqRaZysXNfWBCmLl/3vb/FkWoynxvdSkhI/IXNen2AnvGKpnE3VU/Xg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194584;
	bh=D0Scgz90qPg7RYr5xMXn/Pqx8g88ozFqMog+si7tWyg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P+1vruJxmvlJoKhOtcnRDNCUSmw5hS314Op+6jt79Spadh4NRzHuXlCoHwYlEpgGJ
	 /CGH8JO6PG57MFOhTwltzvAp604ce26ux/pnqKxmrMZ8Eu0oNjthtNSRgymlZc7Pbe
	 gfAkORYk7P2WSy0nTnrdJ0iyTFRVapGCFZktTUWt11iQAZc13oMUXsY1J1qTZBoQ5P
	 P3gcCJxg+o6R/bnaCmFaV9ZFcncLDTWiRXW2Q5hobWkgEY2PNh1WkSYAYGrNCjwt11
	 DvhOq2pw7ej8lunEQxTC0C8eF9VVHkOKbB2RTxjGUT4yPeyMoAZugXt5kXfdcATkg4
	 HW3Q+fKisw19g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A22FE4057D;
	Wed, 28 Oct 2026 13:36:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2849D4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E1214016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HE6WczFDh7Jx for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:42:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14C644006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166128;
 b=ooW5mjD6uZTCO97Mkec6Nm6YgN1AeoqnVX+5R5hDbepl+BAzbBMuLl9/svqF1GcAeuJF
 lO3+0vC7S+b4zlKOjEXiMxvIiN8U2kUMDZGYRehdT4ITc66JVZwz/sZWs/xJVe2wKXohb
 SzPOwLqe+hM2FPE/t/sT3EuCCBbC+o36S2w1qcDaehXQSZlPvvTUJ71ghlDBqypkbYuzK
 r1rh/FIOhRXee3NldvQq1dlfWm8DXVE2O+R/8Y3RP592lI/9otvmFIQ173fA5COstAqWY
 hS+ozH5uLqlu1N1Q2s0SdL8K4XhhweGEwAW+Yqm/Sp78vSM5uwQKijFAuCrZVaXDVkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166128;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=D0Scgz90qPg7RYr5xMXn/Pqx8g88ozFqMog+si7tWyg=;
 b=rWoznZ2fcPZ/rvHBWP4Qn7HPYOi7PikgqrDIER9aSqCuQb0R//NZ7jumD6G5+mwjNqdM
 /lT4XcOwV4fznDDT2fPlES8haqwbfaCJP5vf0sP4X0vp9KDydBXglNxhNcS/ZNUvO3NbK
 0JvmAnvYMdYrfjMH8PrbmqsIP+xV205S5nSrYU61ytNG0f64bPwVkLKH+vuhuwpuntixH
 cV9s9MSVgzkciY3ccgTPib2oTMOZVwk574vbgU6WuC9CfFFoX1Rxh7b825ZJ8O5JAbmwn
 CW3DrF5ST9jhDeJG126kqLgQCRS9d+1JH9CBbSbz7HduM+h1Vj/+0VcQ2HGQY4Ar4Vg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=fXTtqV7V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=fXTtqV7V
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14C644006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWf1tkFPhZrQUU/Mu52au8wWo9fnSXuGndGz5uC4vKw3NsX8swUUStp0gscR40YF1u7SdHmMGVKy7FMVtUbYko9GTMsrhxc4s8DIBEKKr4EsC4Ig6LVIwyS75Se3bpYgU6ZFebjXq8e9d2CU47IH+qbPxzs9I+DnKHBoiK36udDdhBFSRFR616rWI94K+LkZh85nSwTC/7ws1Rgc82U5NNn8xTCUoke6Z9LOkDE8kqrQpBD0ei6p0QJJWvfsM0hUobZGtx5moPw0CvVTu+yLjQ6zT8rQNCcOJv4CmBElqE1/0mWZmRbcQMX4PxJFxgjb/H0pRb0MWqzYRziz/EThnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0Scgz90qPg7RYr5xMXn/Pqx8g88ozFqMog+si7tWyg=;
 b=H4hA450efBDI4gwvp5jc3pgNnoKBF37NKULWHyUvJXnWL/fFxQ25CM/H5ro+2EvOXjHzCIDwhmLKvrk8k8snmIE6BvvbndMW43bSCIb6g9ZwhzWnTdu0FjNP1I0zFUe56RHAGRgKvbLaF+Ki1Qad0YLD9qDvLtpRthHb6IjnW3fCktHC7GWl+3OuZor4q/sohEin4uNE4q08C7W7/vME4CIihuEl/SwtOSQOtDC74Wt+MDUAcliycRXy54x7KzguyN7oEnXyrP4dyiJQ11s8Krx8+ZmiRRHPnaSbJ8L8PxM8QDhxwSPtVmNbFH95O2WVDO3oLJ+CJiGY4ISVz0vLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Scgz90qPg7RYr5xMXn/Pqx8g88ozFqMog+si7tWyg=;
 b=fXTtqV7VlvNaSn9hpsR8rHcPCpKr4dvzsEoxYBXPdGUrMZKtGvFCvbgyPL/cKu5d/Aq6gGSXwH7ygVubJLDRv1qhjVcSlj+KjuMahKosgRaXjXBl64HibRZHCzSe2lddxaeAZygRSPVB+2R+0ZdqzD9mypDYycY9jFOlp+LX57OdSDJDy4UYJrGYgsGp61zXE7oob+qV6+kgVq5hNQVfX3+29iMX6B2ZZeDCzfnOx1G7g5nHXvb92n1PkLpiorK+D8NBwkHeRr7DfHxe7yCE+uDMOLbBpANbXw3YEHUY8tiGHs/j48EAO8s4QzqmP8KCh5N8Lpy+jLfLlEuPMxlb+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:42:01 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:42:00 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Johannes Krottmayer <krotti83@proton.me>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, QEMU <qemu-devel@nongnu.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 1/2] qemu: arm: Rename QEMU arm* defconfig files
Date: Wed, 28 Oct 2026 13:41:38 +0800
Message-ID: <20261028054141.2933271-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 846433e0-e979-4f3d-2fc2-08df34b62fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|18002099003|261026140227099003|13003099007|3023799007|261021123027099003|261021121427099003|10067099003|261022105027099003|261009223027099003|261026121527099003|56012099006;
X-Microsoft-Antispam-Message-Info: dmzY6alr9W3QegnNTZhMrojA8D1Ffq2q6tL3iMvaz0rLkjciqb9ghVuJ4gDuUeZzdQLqoghrCiFajZGJTH2RIJRD+50Si/CfHPKv8DovIhBqb4PPzMN9Gp7IXBNuEd6A2guaczX1FZIxrXIpkosiHZVLPjZMmqArzViCd8L1h8OfhTSQytgs8q5o2c9I2A1T0miO72Wqoo6vaN2CB8D+LmpD8k4fUIfhh4ap1nG1M7NPvCa3byWYZVZ3JFticvtzTHkFpA5yJi0uXxWjMd4A/SwXGr3PL7wYU3zVt68mZw267QnqZi5O4+y9CP5aRTd4OqFfFbE/7punTLvfLcLekFHSkDqiF0RXkfHIJkBiXHgn84O1QNS/SxuVeH2Z0pyEKiDdVnr3L8XF9QhtmghOqu0UMhZI6+SA+cHlQMYWJqhzM7hovFgxtIQR3V9DQWCjLuVv+eUdzigus+yJdNsVycZ2XBRXIcIlKLvyH5z1KO7KmeWyAQRt3alGmtXVH+BdBpS4vI+A/Voq2CgRF7rb9ktEp9ev/WgsHGvs3x3lItskZfD6CSLE5Q4L+AwWZVZ2zTUFy2tvmWSV8CoAjH9b92OHkwtiL02rB0cVN7Z8zc+LxWU2pofBtYCI73t1T78r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(18002099003)(261026140227099003)(13003099007)(3023799007)(261021123027099003)(261021121427099003)(10067099003)(261022105027099003)(261009223027099003)(261026121527099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhpiH5Kww7uwxJR5u8Ni8fNf+4BK0Wy3uFrUtFklA1jHrfExiufKo+zCCEWI?=
 =?us-ascii?Q?k4YO/3tNW79MG9ka9rm6HzR4jeyWxZT3Nit5daneu7StSXGdjsPJdOF2PC/X?=
 =?us-ascii?Q?FCaR13ZkJ/bA0pUZ2VLBWSIGSD+l+CKf4n695EEFWoHp0Z0PELyXIy2T0ztl?=
 =?us-ascii?Q?CTqhe/+e+lQ0d7gq0CLYFdO2v2fSwinrmkkgS095cJpKKALS+5wMi6WTBeoZ?=
 =?us-ascii?Q?kJNZMXKkCLFPis+U71AtF6loqrL1FzHJHzG8Lm5S6tpzKnTbn+E0jQztmDGm?=
 =?us-ascii?Q?fLiSt4iEGWFW1lgS6Z/UJWVZIbTGw0ACZhb68RON7n1cqRcdt5mZZ4yEUJxQ?=
 =?us-ascii?Q?U691xbNCgm2GkiA8g07t30AWhVvu7Ja9y3McgRT4EiP31h5xl2eOlvtmWCC6?=
 =?us-ascii?Q?urYqw6TzQmTcB8fcXo1iz3jNtmHnlqi2bliac0CIJCvJnSH3gxUduX02YHvX?=
 =?us-ascii?Q?GsCWJxP6rudRRIDW9X0qySrwneCZ9tgyde92KtIc0TiqvEZGSfClbbeQm6u6?=
 =?us-ascii?Q?VG/wCQ9t0p9EUgDutZoKbW2ExlTI801eoTFovtWbWe2yDPK2k9LXKiPrMaRo?=
 =?us-ascii?Q?E6jJfyT4FhUX18voSO0O6kUlpdzDYwulpIvM8mclfnX8YwLoLRjtVVcakC5J?=
 =?us-ascii?Q?K2JqcCZRgGeOxGzZuG215DYBgFSmpBmVomyzMAPVrH9oHjWh4sDMuvO5O5pM?=
 =?us-ascii?Q?s6CPsmPWJr5icNcH30hBeeSkSxaHjtIhBh4E/3T/5kNilnxDCVyFFDIV9BaA?=
 =?us-ascii?Q?7NRpEKVPkCwV+8cG93BjdGksP/GwKm/azAI07XwvEaIXQpisq/keCCAG/ior?=
 =?us-ascii?Q?CHLgg4jtDmICLWDohPwh2hdHMd99usN9am4t9KTugyG1Nl1XSBidZyr73Qsi?=
 =?us-ascii?Q?AY7BKfgWbQwtJLJ1KvNFwGzprSVU7CtRpEKEvqehAuP0/UDXl7/4Qrb65Cb1?=
 =?us-ascii?Q?azmhfYIC0Cu1r2m2O2whDEnA/MxxYb0vw9AdZo3VxM8SDqsEvrqP7ErhJBfr?=
 =?us-ascii?Q?BDPFluEqP2ALQ9zog/w0iCTLaDaj9L8GPm2PL+/fGHRF0mq3kOecx9mRaB9Y?=
 =?us-ascii?Q?DzqA9SSwc0iOMqchidj0ojim/KOnMmAVYl8FPiSetZBs4+TI0+5ndmESmbwx?=
 =?us-ascii?Q?03tRz14rzap1RPCeHoDXir3nmLBHIgYzBUhsh+aonbLDmWrFYYL1KV7EGFTI?=
 =?us-ascii?Q?0H3Ov+IHlPGulndiMnU7c3C+ZUZPpp73BXlzmsncgXg2mGUWA26NUVQXJpsE?=
 =?us-ascii?Q?Xt1Szl+HvIgCNoJJRCYK0cixdS2iDuzxK2NvNrEh77JIvo0Gy5yo7TxXPvDq?=
 =?us-ascii?Q?bgJHDq7zT4DeQ4zFKx2L2BTKSYp4ki5/GaIc1in3ztksju9FRXqj74WjgG/1?=
 =?us-ascii?Q?514s/04JQTwUBEPpzvD1yKkJ9pvIZwurts7gbpv9a/nckfu/kPVj+ddrcDdR?=
 =?us-ascii?Q?1xJlzdC5XCvVh5RC91CxwdKF7AWE4PrJTzIhcw68UC4vg//sBB9/vK2+QNQk?=
 =?us-ascii?Q?DTLV530iHcKrMN1kcr3gXT6M3fx/VKDQuYGsSKVQrQF/QHN7mPqyDXVuIwAn?=
 =?us-ascii?Q?OODdJExSzwKDqEeY3hmSNHsoMJzOEb9glsQZaw2g2rqS85dySL0hHiIKSnZT?=
 =?us-ascii?Q?uqkpCb8MQEfxlWvtnmX9rnPwa9OZiyIbN6965TT+zzuOW52z/csBl8bD2Knb?=
 =?us-ascii?Q?xoTIpc1l5ujg4bYM5x8Uw2lhWhMq/mhTASj50bETtvwCQXIqBA0hwU+wIdML?=
 =?us-ascii?Q?WI1Ittk55uPcGnfacPqGVYxMfZ7jSPs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846433e0-e979-4f3d-2fc2-08df34b62fac
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 05:42:00.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlZrTzXOKoVD1reVUOrdYjGb3tryw1gou7vb+ODvpUmVPZWzX/Mq8SFweSSOYrr4aLVn1cKFa0h7B5PG8i2GJ26M5Izdkkp4eB1qZtLyE/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Other QEMU defconfig files use a hyphen between "qemu" and the
architecture name, but ARM uses an underscore. Rename the ARM
defconfigs for consistency.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

Changes in v3:
- Rebase on current mainline and keep the removed ARM devicetree deleted

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                          | 24 +++++++++----------
 .gitlab-ci.yml                                | 24 +++++++++----------
 MAINTAINERS                                   |  2 +-
 arch/arm/dts/qemu-arm64.dts                   |  2 +-
 board/emulation/qemu-arm/MAINTAINERS          |  2 +-
 ...pi_defconfig => qemu-arm64_acpi_defconfig} |  2 +-
 ...u_arm64_defconfig => qemu-arm64_defconfig} |  0
 ...ip_defconfig => qemu-arm64_lwip_defconfig} |  2 +-
 ...{qemu_arm_defconfig => qemu-arm_defconfig} |  0
 doc/board/emulation/qemu-arm.rst              |  8 +++----
 doc/develop/driver-model/virtio.rst           |  6 ++---
 doc/develop/uefi/uefi.rst                     |  2 +-
 tools/docker/Dockerfile                       |  8 +++----
 13 files changed, 41 insertions(+), 41 deletions(-)
 rename configs/{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} (54%)
 rename configs/{qemu_arm64_defconfig => qemu-arm64_defconfig} (100%)
 rename configs/{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} (83%)
 rename configs/{qemu_arm_defconfig => qemu-arm_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 556828f42fe..071fcae104f 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -253,9 +253,9 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+          # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+          ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
@@ -474,21 +474,21 @@ stages:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm:
-          TEST_PY_BD: "qemu_arm"
+        qemu-arm:
+          TEST_PY_BD: "qemu-arm"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm64:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_TEST_SPEC: "not sleep"
           OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
-        qemu_arm64_lwip:
-          TEST_PY_BD: "qemu_arm64_lwip"
+        qemu-arm64_lwip:
+          TEST_PY_BD: "qemu-arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
-        qemu_arm64_tfa_fw_handoff:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu_arm_sbsa_ref:
+        qemu-arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0338f20b8a2..905523e3e27 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,9 +37,9 @@ stages:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-    # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-    # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+    # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+    - ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
@@ -386,33 +386,33 @@ integratorcp_cm926ejs test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm test.py:
+qemu-arm test.py:
   variables:
-    TEST_PY_BD: "qemu_arm"
+    TEST_PY_BD: "qemu-arm"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64 test.py:
+qemu-arm64 test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_TEST_SPEC: "not sleep"
     OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_lwip test.py:
+qemu-arm64_lwip test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64_lwip"
+    TEST_PY_BD: "qemu-arm64_lwip"
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_tfa_fw_handoff test.py:
+qemu-arm64_tfa_fw_handoff test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_ID: "--id fw_handoff_tfa_optee"
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm_sbsa test.py:
+qemu-arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
diff --git a/MAINTAINERS b/MAINTAINERS
index d273603ac64..96203466579 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1330,7 +1330,7 @@ M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
-F:	configs/qemu_arm64_lwip_defconfig
+F:	configs/qemu-arm64_lwip_defconfig
 F:	include/net-lwip.h
 F:	lib/lwip/Makefile
 F:	lib/lwip/u-boot/
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..382d131f47f 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Empty device tree for qemu-arm64
 
  * Copyright 2021 Google LLC
  */
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 538769f8040..b2b1fce75cf 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,5 +5,5 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm*
+F:	configs/qemu-arm*
 F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu_arm64_acpi_defconfig b/configs/qemu-arm64_acpi_defconfig
similarity index 54%
rename from configs/qemu_arm64_acpi_defconfig
rename to configs/qemu-arm64_acpi_defconfig
index f85f2913530..ef4c9f156c5 100644
--- a/configs/qemu_arm64_acpi_defconfig
+++ b/configs/qemu-arm64_acpi_defconfig
@@ -1,2 +1,2 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 #include <board/emulation/configs/acpi.config>
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu-arm64_defconfig
similarity index 100%
rename from configs/qemu_arm64_defconfig
rename to configs/qemu-arm64_defconfig
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu-arm64_lwip_defconfig
similarity index 83%
rename from configs/qemu_arm64_lwip_defconfig
rename to configs/qemu-arm64_lwip_defconfig
index 06ed5a131db..5b1ddb2af03 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu-arm64_lwip_defconfig
@@ -1,4 +1,4 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_QEMU=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu-arm_defconfig
similarity index 100%
rename from configs/qemu_arm_defconfig
rename to configs/qemu-arm_defconfig
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 9e993ca9783..d575bc64ff6 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -32,7 +32,7 @@ U-Boot
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 On successful build 'u-boot.bin' should be created. It's necessary in the following
@@ -100,12 +100,12 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
 
-    make qemu_arm_defconfig
+    make qemu-arm_defconfig
     make
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 Running U-Boot (secure)
@@ -182,7 +182,7 @@ Booting distros
 ---------------
 
 It is possible to install and boot a standard Linux distribution using
-qemu_arm64 by setting up a root disk::
+qemu-arm64 by setting up a root disk::
 
     qemu-img create root.img 20G
 
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f4301c..90a12fb3003 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -32,8 +32,8 @@ network and block device, the most two commonly used devices, are supported.
 
 The following QEMU targets are supported.
 
-  - qemu_arm_defconfig
-  - qemu_arm64_defconfig
+  - qemu-arm_defconfig
+  - qemu-arm64_defconfig
   - qemu-arm-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
@@ -51,7 +51,7 @@ variable being properly set to a working toolchain for ARM:
 
 .. code-block:: bash
 
-  $ make qemu_arm_defconfig
+  $ make qemu-arm_defconfig
   $ make
 
 You can even create a QEMU ARM target with VirtIO devices showing up on both
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..c2bad4cdd5f 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -713,7 +713,7 @@ HTTP(s) Boot can be activated by specifying::
 
 For QEMU targets there's a Kconfig that supports this by default::
 
-    make qemu_arm64_lwip_defconfig
+    make qemu-arm64_lwip_defconfig
 
 The commands and functionality are similar to the legacy stack, with the notable
 exception of not having to define an "httpserverip" if you are trying to resolve
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 187320c26d5..8680ea257e5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -251,7 +251,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build OP-TEE for qemu_arm64
+# Build OP-TEE for qemu-arm64
 RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 	-b 4.7.0 && \
 	cd /tmp/optee_os/ && \
@@ -264,7 +264,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
 		CFG_TEE_CORE_LOG_LEVEL=2
 
-# Build fiptool, bl1 and fip for fvp and qemu_arm64
+# Build fiptool, bl1 and fip for fvp and qemu-arm64
 RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
 RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
 	-b v2.13.0 && \
@@ -294,9 +294,9 @@ RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.
 		MBOOT_EL_HASH_ALG=sha256 \
 		MBEDTLS_DIR=/tmp/mbedtls \
 		-j$(nproc) all fip && \
-	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	mkdir -p /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee && \
 	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
-		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+		/opt/tf-a/qemu-arm64_fw_handoff_tfa_optee/ && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=sun50i_a64 -j$(nproc) all && \
 	mkdir -p /opt/tf-a/pine64_plus && \
---
base-commit: c267fa81d42b5a5bd1055d3858f74496faa6082f
branch: qemu-arm

-- 
2.53.0

