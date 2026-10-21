Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kU7bmEwa;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VdAOh1k0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBBBC8102D;
	Wed, 21 Oct 2026 00:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5uzTrWH9RLF; Wed, 21 Oct 2026 00:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5D5A80F9E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792541214;
	b=Llce+CWIQPh3pDHYmqkSZYO3Vmht+LE/+M6dArqZxKUBDLX34Tnyx0xlMd2NcT6UfYzZ
	 wD4D+0WS8wN/aPXL/S4kOu/UxEKZ6hGPiEN/9RyBfl551ctI/exJjXNks5cAeAjj+FhHv
	 VOq+h231E1OzbcXBcHcUF2mMCAvya5Ttn23foxDziqTcp4mbWPeWnO6TtQpk+Af6bo/oM
	 5m6KCkjOPdxPRS3a23T+jgVLpsrC6unczMPtVZmrOEFtD/2zlMlUBCNCglm3NOLD+Lp5L
	 E5YlIVrPA315MSBMrDpB1pTYCkOdAt0ggIesong5MeJs+WqohclvGdFiGT8HXBnUAbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792541214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=4SI/XxYvZ2sU0ofsHrzGLGZ3Kf0gmIGodW2FUsY4tV8=;
	b=s1moj9JS881+kRQFv413uac7cL1Zz6dcQMAP10zVhjw/B5mg9dMZkjBvzCQOKgw3D85p
	 2tiDtFdIhBEd1naJl5YPabse8nYh7sudcVrVUug29PbV1LPZ9NOAG0lOnXR5vu6jMmCiM
	 b00VddmT7x4NSPClHoz2fMbT8ZaNd7Nm4PUziEOzM64Evvqzm2p3O5KOPG/emh9sCsQDO
	 4Rmoo0+2hBzoCx/1+q8otYF/17SkPZtviVX0j/rSpDVHhD+0kpU092QzUFYMhIFrwkov1
	 +/ym2tB+yJuugvHVSFawQ0VyTs+fgAqXKdTOTY7rnckQdu4okk28TtYv1cpH+Uj684w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792541214;
	bh=4SI/XxYvZ2sU0ofsHrzGLGZ3Kf0gmIGodW2FUsY4tV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kU7bmEwaYTtz/MXMMEB7N+1oMI8aRN+MtroN1lbjFxmpaKkbi32kqJTO2/NvAlG+X
	 3LcVNASuUaB4Yx9v17fHZMV/6rGBzFTfEHku6gA73AnZadpBhu6eQ8C6wr2zPHXLPH
	 07780uP5hrKOhSHjCzqSLAOjRHyc49/yCTN34Fvivd+SsMJ7E3xh1h978Pzt4YJKhG
	 /fMlPFX3bUfoILexfATOK6WtK+ZXO7YSroBP4aPvb5xs2yfxHBjQHvDcQZluA9L1KY
	 8YkdJAv1imyY66F4myY/S0SglTdRKq/p3uY9JUirpJMF4XhJulz8R+5Wq2DRy/rAD3
	 1MdOAVoMR/c2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D5A80F9E;
	Wed, 21 Oct 2026 00:06:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48BC5769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 00:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E6FE60719
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 00:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azl0GApa6sIh for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 00:06:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E31F86070D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792541211;
 b=Wg/B5Tg4bqgYKFKahBJ4f7I+FP6GxaTA5wFVsSEA9BD2Z1cBoRg7LbOljPt0YtfGfore
 Fk4USteTOOrG4SSK+2c1AKESb1f4upgMSY5oSM/+yEosr5fNgGpSnBgEJWzi9hFrfbu0Z
 dG3XPwxFPqgka6NgDNHhHTirm9fHKkcnnzqG/+291kyLasbZ+qvqArFuebejndD0tzTzL
 oBYltcHCoapbNIeU2zIMMVJ0e6UO5NqDZSxvh5C8wLPpNosH5MUqdUCCzzNNtPKq0dSOz
 8B0SocwBjbhLBBOcekbUyP0RwCY0vzCfq+HZ3l/1BXfBsx97PIl8/Pm5gp3IpHGLO3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792541211;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 bh=4SI/XxYvZ2sU0ofsHrzGLGZ3Kf0gmIGodW2FUsY4tV8=;
 b=iRjWa0fteki3iyBYt5GSKrcBMFHVvIO4a/hjGpIgpnFawbLvBgbZx8IPp96iERPHus3t
 IhPXRmUZDIhbis6TKwsda5pwpt3/jORK1HmkpyPPeXuOIIdTbL20a07Titw6gzbvrKVll
 I4FjOUEBY06stuYE6qyFm341IDqsTbDT5aP490kM19f0KHyRGyMacZyIiVNfmNk1swu6v
 SoI+OxCMqNvFOX1Yt3Iv+dxMZ34ZGuWBTLeXZgVo97y3+uNJvqHsfoaNsTCn4MnmLaa+6
 zCAJNkm28LN3A1WRNI+HZWxyBSxzqrS/E8jMKswQcbmpcpiBZV0fk3Y2Y5v4iB8KzeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VdAOh1k0;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VdAOh1k0
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E31F86070D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 00:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCF+lcKKPmXXUbur0uKSQPo2BpNGOVQDxI2E2bkY7vb6IpdHb5oUJ5dK6hivRpVj7U63QOC1ygA7py92qrgHuYzMseJ1RE1AodC8uxC+JVmlYXw/bIPVz2C67vXhYzFqZ0mYDqgi4bso20yW66u5mL3cE7gvTI+pd73Nqrdmqc20C4DlkYwAGNzo+nIgc7wwvGwsYiRSpmb4EyhcwgXOPTk7MNMsqc87JHjddUH8DYW7K/ZIM7phaJioFUUh8tq4j2NmmSZFPFEG5lY+1Omn6lTAoB+KReoHMPe++jhU3YtZrgOLlDoupmcZBUjm4evX4sBlyfxm5gfkKZ1MxTFhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SI/XxYvZ2sU0ofsHrzGLGZ3Kf0gmIGodW2FUsY4tV8=;
 b=cJ4jo60yd5M+7VUhzhRtkO3Z7t+5MbtkTo0f4BEdrcPEGYPwsuYBH0RVPcKyXofmLeuVTr31KBCxKPCyX2vIe9OJuQ5NDujK1TTqGp2Vyv/av26s+02KL3rBppC4RXop+KV5Iyo7VX3I1ph1cT0JK69Eq+G5vAp197GAQGUdPErV3E0lqsv8G5EieQKykWJT3b810phxy8e6yaCwFkv2jAdv4ppVQK342vdPpmvg8RQ3gm0uXIjIAU1biMJ0lEuQKJA4gb+86BnfGIr5bQAm+1Da0trkxceBgxVvaWn372qmxKpia3o0vBgDJAnI+MuXNBohMe76cFzurqdWkPGaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SI/XxYvZ2sU0ofsHrzGLGZ3Kf0gmIGodW2FUsY4tV8=;
 b=VdAOh1k07GIxwVe2T7CZatGkteHCU06+eQjgDry53D1wy/Xj45RlInqrwVu4aKP7prA1MAk7CSaDYsYYXWg0RF++hjGQ4xVL4iRKUagpg3vFLBycxwqceb9PrGteKsa4ZS3nu9uoL6AhcV8xH3ntCzbG88qhMvsq+E1yFXolgjMYJM0AQYd0ofQEEGBEjmIinJsRd0sFbU8kiuGLIptm6JtpAj1EYbfrpFfd9q1rE4gnLUXiWEzQPTQCXTN4pbSxMnVWBPvURdpw+79NnBo+KpGewMMRrIU6FpKPvpmN6pV1BmcTt4xMxl/AwhzGiuafAJ8JyawDbgFrB9ftWy3DkQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 00:06:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 00:06:43 +0000
Date: Wed, 21 Oct 2026 08:03:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] firmware: scmi: check if BASE_DISCOVER_AGENT is
 implemented
Message-ID: <atgBbhYwjJGCNOL0@nxa18884-linux-1.ap.freescale.net>
References: <20261016-base-discover-agent-fix-v1-1-113519da193a@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-base-discover-agent-fix-v1-1-113519da193a@ti.com>
X-ClientProxiedBy: SI3PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: ab16e70a-ae99-404a-6f10-08df2f073099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|18002099003|22082099003|3023799007|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7kQ1VzHOf1wqxtbi92UnUI0wmn/QCRNX00Wfj1+Ei5ea9CzUtF7RQif3JIKipbGXGJZjlcRtxnUZYbEOWm1+KyOUcICju5wahYRZMpPxevaBw5mzy5iHB+/LSHd7a/uF++Sha6t+/jj1DA+MGbI9ZNgDMPWi0cHQyySGkggN4hyG/5JVZxot6KWE8afuzOgaLFKC6PAhOX4YOcRFCsLqQNtVBZRdBzoqb2OORDNbcK59cFxXIZJ7X563BroHf5378CJnFwjzt+qNIe/onvBgry1rCyqLVE2YmeBWgRZgs1s5Sf4yDeTNBm4y9tPKBuBP+faagdWammV/uAOu8OhseDvM/Arln4bYtM8WUpMIhGp+QXaPdE75dWKrEhMscn26GNC7SbCMFuuJzwo+ayUiwVuIp4b2XoGE9iV7ZgWOpHTjBC45WvpcvqnvOkePEChJB3YflNv4MUrMO+yK1n1uZBUP/1roT+2W3prUp5/8/JOCMPymy+HKHp8v9Bl39pOJKGaUksYwBYVwtSIlfv1o79AOCjtd9KaKV53AD3m7RhGJqE9wMHOaIRh20pDd/c/dOqCkm11T4ALVPjFMn/5y81Dg2BkveI6Y9EEyyeQjuh/lOeg2IvP9eDuS+NsBGh/iFChfJyP3VZRVnMzSvEOPCKGH/wplebqZT85qy/iyHQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iReoC/6U4+EyKobt2L9Mr12rPgm8EM9DTyOo/zS+GB5KNMYAU+Ev9asVaJMg?=
 =?us-ascii?Q?V+/TVnLCXBGGmzugEIfa9sVcVaTz5jTK2HCx63PcWkmAcmfAqoOGarvfgEa1?=
 =?us-ascii?Q?l2ln/aGD7YNE4w6sZ6uFXxPQ7qHN/+VLK558Mffh9BjxBkzlDbWZMwhyqXNh?=
 =?us-ascii?Q?f1S1b4anFj9QE6nftamZJce7+JtKhvMJ/bd0X/Me7LzU5wwbmcnIIidqFsvD?=
 =?us-ascii?Q?dkJkFfd18L0OmKQnBC5cgpFzSZLBEIU7Z3VXpj5yb97HfO9U5L6ZUQT1dX4U?=
 =?us-ascii?Q?vCrNfBE/NPPRsiHm6XxoAdbEER6bn+3WNLJC6axwg136crvPLf2RsGIM1Nq0?=
 =?us-ascii?Q?PI42o2VYou7NCPI61g9Ssek5IrC+B6Dtm1QH55YQDwGQV75w6Oy4JtktaLK5?=
 =?us-ascii?Q?rSwXApMqoHgvcgQTPGFqU6+NtE453VWirTfQCQ/o6VYum72HCXzLjzHWYT/s?=
 =?us-ascii?Q?tC9K8d4KUyGOkm9nrRRAL4Ef3rwXGx8oy6ewRQyv5jfbIhKTRwjmArFnlxc+?=
 =?us-ascii?Q?yjqRxzn1o1ktiQcT2qrj1BibzrJHUZI/95ZBTV1uQCpUyi5qyyVR1pCLrdg1?=
 =?us-ascii?Q?JJ+G8lxPn76sY3ptAu7NfAEgRKFxNksgniTBNQA6tLrZZQpTvQ2mtItbRIfb?=
 =?us-ascii?Q?h6xZIxW8fD7ILUgHRaQ58FPAlJhb+Hi8xM4/aTfEUSmWlFv5uxzC7KlYQ1+0?=
 =?us-ascii?Q?wC4zy3DA32xk5KKF1k5O0dF9M0Co9cv3el6D1G8wYK3rOO48g3aP/tpp5Qoq?=
 =?us-ascii?Q?jGaAzPJy0sRpyuKO7BNWyZmhmQgu59E/Ut4F6olLXl2zQuKHZkfXdMPUXUFL?=
 =?us-ascii?Q?cFJP3gxHTZrLE85mC/NFvzgLI9EUQVDRG49GWtVRwL4ClphN3Mm9/WO+BO4a?=
 =?us-ascii?Q?8tdI8c3O6ZQFzxOI4CrYq4UfzKwKLz5bDtHz6u4N5X+nKxHkugObkFd4yNuL?=
 =?us-ascii?Q?Yzw64BZwIQiQHaSTkjqJ3W2AZbAC3P9Tvn+Y2T+S8rLTCjso3UtEO6gpJThG?=
 =?us-ascii?Q?bQqZb/k8bkPgum91mMeCyW+Nyoc3+x/mKL1HOh6JxQtaFQXJ222fqSB8d6G3?=
 =?us-ascii?Q?h0FP3151etUT6kcfg9NMwPGa13otP27kdDEeIqjQLTex18evVcwfcqEZ4msv?=
 =?us-ascii?Q?Y64zB+9U4hFCbPAPvU16yx92O5/ah0caF0SnfXpzWQAhZaiLqQfTpyux43B9?=
 =?us-ascii?Q?rSBD6PuNq/91Qx2DDSEhqnldgAdKTo/ZfFuX9PXpToE+EfjVMeAFdPZSppw5?=
 =?us-ascii?Q?k2IE30fU1E1xs+HSQtTb9TgSUOW6TUU9yGJAY7qLEE3pvVomPpsSe2T2nbYK?=
 =?us-ascii?Q?ChyhRDST0ffS70WbwhfnPGQTwfvWyFhvCBNnPvSGysXuwxetgr9sEfgHsOHe?=
 =?us-ascii?Q?/NBaKrOy8Mf/f0gYrHmkrg0z63PmloGwL7UyEBgSQqdHW4Dqb2XBenMPBuxt?=
 =?us-ascii?Q?PVfNI55Bxx8r2V7t6l84CYw3nqvDUHGROfJzp+PmgJTugOArrY+zKE5p1xLL?=
 =?us-ascii?Q?6qUS0iDuKLDmqxMB8OhdKAURoVcDA0F+OdHmiud6aaS+Qih90Oti6/JkIxLq?=
 =?us-ascii?Q?5c7isiVqyIKDqGYX0ZtL8LBNcScyQGjm61svCsWbbeRvmcnI9RDjH+axtXR2?=
 =?us-ascii?Q?ULkZZYwrodGqdD4vJiWYgzzMCbAnmgSJOge4WQxBljp1Q/94BgI+agCSROu+?=
 =?us-ascii?Q?2ogIIh/l1Dn8aiYKAri4R8JQfR1bpV2xAS3SyDr7hovXjikW9r4MkGyYq/N2?=
 =?us-ascii?Q?Ji2UTHwmOkaFYq9/FVByLw9fT7FyUk8+lDqjanAmggEvDlg/+UWd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab16e70a-ae99-404a-6f10-08df2f073099
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 00:06:43.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqVdJiNWP6dBVYu+fzIxX8/QLkjtNet303Wjakmnc4+hOGNLBHnyZ7PHlf4kRqfqEmB++K+L1/UEdybzfU0ymbOZfczVUoL5F1bCDf6ijJ3h1uLUvuDJYk2J2pYMEYZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 05:13:16PM -0500, Bryan Brattlof wrote:
>The BASE_DISCOVER_AGENT command is an optional command which may not be
>defined on the server side. Calling it without first checking if it is
>implemented will at the very best print ERROR: messages from the server
>about the command not being implemented.
>
>Fix this by first using the PROTOCOL_MESSAGE_ATTRIBUTES command to
>discover if the command is defined before we use BASE_DISCOVER_AGENT.
>
>Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
