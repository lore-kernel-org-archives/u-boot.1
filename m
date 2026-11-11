Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9B606A885
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HVNaI+DW;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=vHiKEUGn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C6E281312;
	Wed, 11 Nov 2026 13:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qn9hBAUsE0mD; Wed, 11 Nov 2026 13:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5483981346
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403866;
	b=gGx1jTJd4LbFxyuzM9gPzowBC70j+K/LNcRyVNq5Wla3kv/rKtQGgEY5OgNXAnv+Oi/j
	 pr66CWDmhvH/cqOWrxOPJKv0VFOp/1ciwHM5OD7TljEKo3K+VA5ADMkw32k8ZitJt5e4K
	 3GDO6Tc1DMDMYJjUpK6TReMehUyqtYnqikJNZCjHVieecb+K3nh5/T4/rlA+nMl6hbUb8
	 TJ6cra8BDzcSiADlvRUz4rhS8SzxfBs/rVZz+TA6dm6jE/+/9BPN7a3N7CBpZPA+tDxqv
	 HwXL+Ky11Y1WXCR7IIFRDSqTuYQK7U8cOroCDAgIDunH/GQuJnhDO3PjqbJINQuC7MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=QXUPsyBV1Y7S3xB1oyiBDlVQGGuNsXQcvYG045aSHLk=;
	b=VCgzfUUhto+2ccJMWzQfnwbvzdiLQwAPEPLZXLSTITvFrHAz1ockoNrEGCMebHvbhDfh
	 aDucGlO1Q9hFLO+etMYbblVyHpC0O4tjzbULi9LZQ80ZkuZF2MQ4M5aLjGC5tSPq3PaSo
	 7EVGvAP4cuw/VWa9sLsnZm3T39xjKdGLUQuHA/2A/WKeET2fzZg83F9exBRJ7XQV3asHd
	 RckvZMBrde1dYnyQQ1MdJpQql0HwNEnZgDUP+9oCYswiG2FrW5CoE6bhBEH/oWpwlfiMh
	 JuIWOqWc/527pe8IVuftTity8mwFogS99Cz26ranXaDvwphZvfnQkqX+FphN7MBoekg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403866;
	bh=QXUPsyBV1Y7S3xB1oyiBDlVQGGuNsXQcvYG045aSHLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HVNaI+DWYmCTbmcBxEjcrYoWjlFiC/w0/UXhSQOJ8dTF0R4QS0nQ0mL3NSr01k8Vi
	 SSKhN/NEnbrSF67YIYEnj69+Vu0619Dw1qWMCfrs28oPscdi/y51mJd5NSRIVLTlci
	 dZhR+jQfOug+P1AfARioKfqY34xPjMQwAzEadGD5SYPjHcXmx9+QsaJ5cTwl7swkNq
	 IXMeo2bvDaGMHAYMy5ECPrzjpySFxbjB2vfJHft/uBL7k1XYOaW3vIDaatHNnwZrcj
	 ttJ478LS9ye5aOPv8kFdHOjxe9aemK7t6VD61DBp2fLHDcOaUoqtxHPmx6JWixbxsI
	 44AXWcHqHGkBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5483981346;
	Wed, 11 Nov 2026 13:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A17E31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8755C40445
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtaMg5LEKSci for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0169F40AA5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=vHiKEUGn
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0169F40AA5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXUPsyBV1Y7S3xB1oyiBDlVQGGuNsXQcvYG045aSHLk=;
 b=vHiKEUGnd9ODBRUfcInY3BZv+VuJG9D9e5oLAHee0KFqVJ+3v4tZMNpj755hDitXlT4uzONVp9+rIu1j5cUWJiQxQyC/KJx6zW1BMJeD3JIvusrsVJxGbjetOXP2tKxSGtlW55E1wUDsWIdVkmAuyfsaT0VqZNW7ois9zIvrFmCnxW/Q9hLPJv001cyO9GVI+g2s9CZvxiWysK+JqQv7U9cR+DVazQfu0/p618HRxy8akOEfv/lcVQMGw2xJ7H07oEINzLany4xAmovvd4al2RzxCxoHXkZ9P1QwSaIuR0etGdpjnU4qnsyKrpZd2yzfnZUO7mxt7hA8LHmQfq5uxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AM7PR10MB3509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:140::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:30:59 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:30:59 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 3/5] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
Date: Wed, 11 Nov 2026 14:30:27 +0100
Message-ID: <20261111133029.2538132-4-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AM7PR10MB3509:EE_
X-MS-Office365-Filtering-Correlation-Id: c26d3424-7035-4ec4-eb17-08df3ff805ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|261026121527099003|56012099006|11063799006|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261026140227099003|10067099003|261102123227099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 81ObsGOdTqN6+dTUtR4B8pd7zOOR6ErXbImUH1Lc14Pd+/jqQCi1Q+ZMTje7b6AQOfg6+wbhdckZA+DwtJyoIS8P2Lr6XGCX1FKzbjsjuBByvRrkRuIF4l+WaqT8Sd8K2BK5xyNVCA66NvM4bJxsh1+KSuDVEhstJWtnXOhGA9hD84bgfcuaCTs3v6upaD00ojcYhG6LD6LpkUDeqicBqKld4MankX0aACQJNy800iOpsKQ+b7QdBclag7i0jpphxLlb5QwwxbnVJQoErwp43tuN082Hl8zRCvik38KiFv3RntdSKlvbufcuZI7VDZtpjjLDTt1SwxA8JVNdxn/Lr0TNd5j7JqoSj82r77HFY6lqVSMlC8D1zCCflff6ohRchuJZrfbATPdb87iTvrRTnA7RFuu+VRnVUIfDltG+taUxmNBsHMOXSMOTIdGMRSM5KIdtQPrE+muI2T51bExVrBT7SrjnAOe5+p3HAidSPKuqGVo7RJIgy4TyfjSCwc1yPqSTOGj1qORursJG/LvVV+ghPcCuHxmhMM5gy9dukL5nQdeaZEA4a7vFtrmS7bE+kxios/tn0Hquva3rm/rujExdGui1MknPctriVaI0ltiv6dAisam5WnwYskESHj3QBgMgWwaD0EGOsuqgkGoPZD23MS1mP+u4RmxkcIvoKPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(261026121527099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261026140227099003)(10067099003)(261102123227099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41DW4G2jnL8WSsJ7iPYFFoWbAVwPWmcQhJvFf8JF/mz2zARZAy+8RisK/QQT?=
 =?us-ascii?Q?k7v6dhZ/be8DBHaNi9CcjJnUii+Ka3KPJNbK0DtWCrpokm59Bv0klXfG/swm?=
 =?us-ascii?Q?iuQtLLqbOXcJgXbf81ZZr/RC+Q7HCefDtPLawgLyrhttHRHVwIaKX5oveCSg?=
 =?us-ascii?Q?NGCMwfszri+0oXxuMIRM/apnkrQ6qlRuy6ptj/wDRT9i/drO9QLlfjexQp6K?=
 =?us-ascii?Q?Lt/8GUkLZ5eKZ6nY/Bg1Rho52VO5vqKhGGftDrksv7LLGK9OMhrsb133unMH?=
 =?us-ascii?Q?C/IRo7wpW8cuvp3xnz6H+fNTGZZhbbL6JL2+p9JBvLFW2ED3FAZNztHLLWOl?=
 =?us-ascii?Q?qwyCm+piHGHpSN+GkJb8p9dWGzpeAvZFD5NvEGnGuBfID21/tm1Jtw9EKr/Z?=
 =?us-ascii?Q?UyTIXoLEU8sJUW+3tsU1HVpOGyAl9lFcnxuypu+fKX1EM28lOzsG/RQ4RuZc?=
 =?us-ascii?Q?5fSQUB7iZv+zfWGPFH9G7b2tLYkjamXHPTuqyRF00sN1ihm1iiCS7YyBzDSZ?=
 =?us-ascii?Q?q6z87XxKvx1NbcxwuVaC6851UndSpRbfb2ZoJtIZ5LulPvmGRFtJyHBCMYvC?=
 =?us-ascii?Q?JBOUqP/cjpCUa/eb5iffXScgNiDd/U8+SPym3Zc4XIh3auXqt7Tnva2N1x67?=
 =?us-ascii?Q?CRBkqhYVNY2zmTHGIiYM49yGHKetWkeR3leNLnMPJiVES2/Q7+e0f6jJ7Z1h?=
 =?us-ascii?Q?jXLwHA/VOu2d1u/6De342JzAHLdDpzc8xC6OVLkb0Kky/vU0zmwmRh7pGGkx?=
 =?us-ascii?Q?1aIU6mUP2bDAIIm57WARhM1ix9xTv8lQyTKeBGzXNbk8QQj3fggrP/697tTn?=
 =?us-ascii?Q?dUElgaFmijdwF9yvJU/AuswASVEExXVmO6kRRJipBNR+dOmd4Q22HU3cTMyN?=
 =?us-ascii?Q?EvCdkQ741JQ7VcmD9gf8fnhYtXB5aYA2PC0w2SMBabLMN9Yjs7ACpaXI/IS6?=
 =?us-ascii?Q?nyUWA8KcrLpf2l+oK3rYfqXD19soaHchKFRH4Cs5ii5Xl2/Kv0rDSpmGHLjH?=
 =?us-ascii?Q?N8Ty2P9q/bGibD2o5PG7hJIB6glu8xd4JLUvGFueNqrrpXNfHwKvcsWT5MQv?=
 =?us-ascii?Q?ZKfcjpZmhVupA8zJ0og/NOyi8nKu5yVZ3ib7GCiQi8fZPylEeVap62oSsSrU?=
 =?us-ascii?Q?RXshl4GTEGy1oquZx7n9AyZ57VvNfCMofZRXWer3Khr5jf2k9EvKp/WvOGMA?=
 =?us-ascii?Q?5aRJljT6+/pwqv07MBkNUE7RpQdAwARhBtymTpzswZbRx2od2HvOhdIXBF0O?=
 =?us-ascii?Q?xtGtF2Kbjp9OsZH3IMKibOfcQMHg2OPDIgrbAHyzXCzgDYPLwz34NQVD7ehc?=
 =?us-ascii?Q?hySpfWSi0gvBWQZc2eor33gOuro7d8Y6HJq0xiSIfWvkWUDjuF50WIO/Snks?=
 =?us-ascii?Q?N9fk9KEaWw8Zb4VHqa7x8b8wdK+54OATu8lWYYmIdGHXcQZuNcKXhv2sOsWP?=
 =?us-ascii?Q?aGIdfb1uRSU0bPkAC6nO9VEeM/Nr90LFw5iku5hJbeagbm6QkfDcKh9XG/GN?=
 =?us-ascii?Q?kZfWPqotzpchP//v4U1cu4xNkiQAjj4ITfIq40JK65W14lUV8972JFGkg8LJ?=
 =?us-ascii?Q?avXvzAqI/6EEIKkiJBKZG8M/a+iBsHhc11s4FbdWIr6p90L3+bKYUYT9H4RZ?=
 =?us-ascii?Q?emCve1ck49g8wjz5Qi6xEZ0L0uRoj4ixpb5IevLwaJouUOGN+ISLAL8+8vQT?=
 =?us-ascii?Q?GZLFFPVl0mndikh3RqQvT46gSu3u026WhG31xSGb/O+NCOP+Sku/yop89eXD?=
 =?us-ascii?Q?bbIrOSoP9S71mYocKhmduFx3sWafNFI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d3424-7035-4ec4-eb17-08df3ff805ae
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:30:59.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilm252hGRTk4J/SkmlzIfsRR+2bvMEPq7uWowWe+T2D7gVgzUgeEySzSXwfD1qZbL3GpSPhI1S+XqfZ7pE+I7P3v+RpFpacib/jRmsjHr/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3509
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
measure the time spent inside the bootloader prior to loading the next
stage. These values are then forwarded via efi variables to systemd,
which exposes them via systemd-analyze. This helps to identify where in
the boot chain delays are happening.

Without having the protocol, bootloaders have to fall back to direct
reads of the time counters, which are architecture specific. Implement
EFI_TIMESTAMP_PROTOCOL in the EFI loader so that applications have an
architecture-independent interface.

As the implementation of the protocol is tiny, enable it by default. If
this is not desired, set CONFIG_EFI_TIMESTAMP_PROTOCOL=n.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- return driver provided values for efi_timestamp_properties.end_value
- no other changes

 include/efi_api.h              |  4 ++
 include/efi_loader.h           |  4 ++
 include/efi_timestamp.h        | 35 ++++++++++++++++
 lib/efi_loader/Kconfig         |  9 ++++
 lib/efi_loader/Makefile        |  1 +
 lib/efi_loader/efi_setup.c     |  7 ++++
 lib/efi_loader/efi_timestamp.c | 77 ++++++++++++++++++++++++++++++++++
 lib/uuid.c                     |  4 ++
 8 files changed, 141 insertions(+)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c

diff --git a/include/efi_api.h b/include/efi_api.h
index 646581150b6..63e0ed8737a 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -475,6 +475,10 @@ struct efi_runtime_services {
 	EFI_GUID(0x3152bca5, 0xeade, 0x433d, 0x86, 0x2e, \
 		 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
 
+#define EFI_TIMESTAMP_PROTOCOL_GUID \
+	EFI_GUID(0xafbfde41, 0x2e6e, 0x4262, 0xba, 0x65, \
+		 0x62, 0xb9, 0x23, 0x6e, 0x54, 0x95)
+
 #define EFI_DT_FIXUP_PROTOCOL_GUID \
 	EFI_GUID(0xe617d64c, 0xfe08, 0x46da, 0xf4, 0xdc, \
 		 0xbb, 0xd5, 0x87, 0x0c, 0x73, 0x00)
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7b865fe900a..dd91c953776 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -384,6 +384,8 @@ extern const efi_guid_t efi_guid_cert_type_pkcs7;
 
 /* GUID of RNG protocol */
 extern const efi_guid_t efi_guid_rng_protocol;
+/* GUID of timestamp protocol */
+extern const efi_guid_t efi_guid_timestamp_protocol;
 /* GUID of capsule update result */
 extern const efi_guid_t efi_guid_capsule_report;
 /* GUID of firmware management protocol */
@@ -674,6 +676,8 @@ efi_status_t efi_console_register(void);
 efi_status_t efi_disks_register(void);
 /* Called by efi_init_obj_list() to install EFI_RNG_PROTOCOL */
 efi_status_t efi_rng_register(void);
+/* Called by efi_init_obj_list() to install EFI_TIMESTAMP_PROTOCOL */
+efi_status_t efi_timestamp_register(void);
 /* Called by efi_init_obj_list() to install EFI_TCG2_PROTOCOL */
 efi_status_t efi_tcg2_register(void);
 /* Called by efi_init_obj_list() to install RISCV_EFI_BOOT_PROTOCOL */
diff --git a/include/efi_timestamp.h b/include/efi_timestamp.h
new file mode 100644
index 00000000000..0fe0c41b62d
--- /dev/null
+++ b/include/efi_timestamp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Siemens AG
+ */
+
+#if !defined _EFI_TIMESTAMP_H_
+#define _EFI_TIMESTAMP_H_
+
+#include <efi.h>
+#include <efi_api.h>
+
+/**
+ * struct efi_timestamp_properties - properties of the timestamp counter
+ *
+ * @frequency:	frequency of the timestamp counter in Hz
+ * @end_value:	value at which the counter rolls over to zero
+ */
+struct efi_timestamp_properties {
+	u64 frequency;
+	u64 end_value;
+};
+
+/**
+ * struct efi_timestamp_protocol - EFI_TIMESTAMP_PROTOCOL
+ *
+ * @get_timestamp:	retrieve the current value of the timestamp counter
+ * @get_properties:	retrieve the properties of the timestamp counter
+ */
+struct efi_timestamp_protocol {
+	u64 (EFIAPI *get_timestamp)(void);
+	efi_status_t (EFIAPI *get_properties)
+		(struct efi_timestamp_properties *properties);
+};
+
+#endif /* _EFI_TIMESTAMP_H_ */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c4b0c2137b8..38a48ec76fc 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -469,6 +469,15 @@ config EFI_RNG_PROTOCOL
 	  Provide a EFI_RNG_PROTOCOL implementation using the hardware random
 	  number generator of the platform.
 
+config EFI_TIMESTAMP_PROTOCOL
+	bool "EFI_TIMESTAMP_PROTOCOL support"
+	depends on TIMER
+	default y if !HAS_BOARD_SIZE_LIMIT
+	help
+	  Provide an EFI_TIMESTAMP_PROTOCOL implementation giving EFI
+	  applications access to a monotonic 64-bit timestamp counter and
+	  its frequency.
+
 config EFI_TCG2_PROTOCOL
 	bool "EFI_TCG2_PROTOCOL support"
 	default y
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 567db518a8f..8ff5468ae9a 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
+obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) += efi_timestamp.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
 obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
 obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f302bb62ab9..f0b3e59c3e7 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -325,6 +325,13 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 
+	/* Install EFI_TIMESTAMP_PROTOCOL */
+	if (IS_ENABLED(CONFIG_EFI_TIMESTAMP_PROTOCOL)) {
+		ret = efi_timestamp_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_RISCV_BOOT_PROTOCOL)) {
 		ret = efi_riscv_register();
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_timestamp.c b/lib/efi_loader/efi_timestamp.c
new file mode 100644
index 00000000000..a42b6546abe
--- /dev/null
+++ b/lib/efi_loader/efi_timestamp.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026, Siemens AG
+ *
+ * Provides access to a monotonic 64-bit timestamp counter.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_timestamp.h>
+#include <log.h>
+#include <time.h>
+
+const efi_guid_t efi_guid_timestamp_protocol = EFI_TIMESTAMP_PROTOCOL_GUID;
+
+/**
+ * get_timestamp() - retrieve the current value of the timestamp counter
+ *
+ * This function implements the GetTimestamp() service of the
+ * EFI_TIMESTAMP_PROTOCOL.
+ *
+ * Return:	current value of the timestamp counter
+ */
+static u64 EFIAPI get_timestamp(void)
+{
+	EFI_ENTRY("");
+
+	return EFI_EXIT(get_ticks());
+}
+
+/**
+ * get_properties() - retrieve the properties of the timestamp counter
+ *
+ * This function implements the GetProperties() service of the
+ * EFI_TIMESTAMP_PROTOCOL.
+ *
+ * @properties:	buffer receiving the properties
+ * Return:	status code
+ */
+static efi_status_t EFIAPI
+get_properties(struct efi_timestamp_properties *properties)
+{
+	EFI_ENTRY("%p", properties);
+
+	if (!properties)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	properties->frequency = get_tbclk();
+	properties->end_value = get_ticks_end_value();
+
+	return EFI_EXIT(EFI_SUCCESS);
+}
+
+static const struct efi_timestamp_protocol efi_timestamp_protocol = {
+	.get_timestamp = get_timestamp,
+	.get_properties = get_properties,
+};
+
+/**
+ * efi_timestamp_register() - install the EFI_TIMESTAMP_PROTOCOL
+ *
+ * The protocol is installed on the root node.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_timestamp_register(void)
+{
+	efi_status_t ret;
+
+	ret = efi_add_protocol(efi_root, &efi_guid_timestamp_protocol,
+			       (void *)&efi_timestamp_protocol);
+	if (ret != EFI_SUCCESS)
+		log_err("Cannot install EFI_TIMESTAMP_PROTOCOL\n");
+
+	return ret;
+}
diff --git a/lib/uuid.c b/lib/uuid.c
index 16ca8f37751..d7022519f0e 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -189,6 +189,10 @@ static const struct {
 		NULL, "Random Number Generator",
 		EFI_RNG_PROTOCOL_GUID,
 	},
+	{
+		NULL, "Timestamp",
+		EFI_TIMESTAMP_PROTOCOL_GUID,
+	},
 	{
 		NULL, "Simple Network",
 		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,
-- 
2.55.0

