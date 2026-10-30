Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437E606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=je9DJFIt;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=fjT50u6/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A698816DA;
	Fri, 30 Oct 2026 14:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Orzskb1yhem6; Fri, 30 Oct 2026 14:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E4D8816D3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793371348;
	b=Ni2VAYSi4E/yhEfRgOjPk+w6mlICq+stZmYV/vH5SX2yxwhk9wBsF5sv0P6DV1XFTnWA
	 ymxOHeQPIPYpU4ipVHt1petavuSErZDBH91siLxiCi1a/En3tJP/IRR3vpQrHgkdcf4UA
	 p2av0U4e+pfk5DHABxbCpvG1OitjF7T7doZNurm26sFzErLZjBO9ohEI58eMtb+y8L2yL
	 UZm5sMrN1Wc5si1D7mTtCxfVT/IScRjzJzSnF1TYZHPgx/nTKBsUCgKEYvuKWaWPu+Gnq
	 cvY4HSr132swUC2Ariytd1433/OX1avlLHyNxLertwt+Mpn1sy6+frysL51Oh9Wqong==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371348;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=oIyA4b2klrgL3zJLq/K0MGIpgK9MIh6CG+elWuTD0JU=;
	b=SymZx+nUM9xLVNKaM98a//KL5mKz1EcNREiLCLK//dlMdN2rIofiu9mJEbo98ApPjG5M
	 66HeD6eKAWodUFbQ4TU9eaDxzxDiTljeV53xzifAJ00eRQo5bhRTNEdc3xDMYAdmOIG8Z
	 CLM5tWJ1fHQ0Bc6wj9fsCzd/y3ZyTfGZxeE6W31E7dTCu6sH1ayYSigUZA/JuYmsQAeqi
	 OdLmFoNKlt+RxLsKI75ch/yTCrLYQjjmwWEJcNWicIogB4NtynbglxHvfAUUOnYVa8eoW
	 ZV+fQh3haCniTi7KB8RcBpShOeRcaTApgcFtL1itStfVfX52/OKo4gX+eDVvlQUm5tQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371348;
	bh=oIyA4b2klrgL3zJLq/K0MGIpgK9MIh6CG+elWuTD0JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=je9DJFItvukAuh3K01Te2lKGt+SKt2Xg5eyx+EBInBkW9C3Ehjph4Yzi0Oli2HYfL
	 Qpacg5LHC00F2X+A6eeDEnHI6gQH6HodO6w/eWa8JOStUCaLHXlH2SbCf3FaFfa1Lo
	 Cb2OKvDSlTPvwUT8eoxBiVAHZGra74YdEdgNayf1HrcqXyvRfcaKjyyRKCU0/HdHmo
	 xrDh7B9iDmgYw7ijkPZE+86KW1SlI5hSDYOR2JGtahqnYL3sACIK8yyz/0DP1J8wa6
	 hxmqHUogb/GPhyahd3tODqao8CLVRy25oHfj/eG8ZWFjLyyaNmaukOVr85JVTkX6kT
	 OI6g32Bqha8Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E4D8816D3;
	Fri, 30 Oct 2026 14:42:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38033235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32A3C40535
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3AEv75K9VDE for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:39:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF62340530
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371140;
 b=j4FsLIuNlx5oQWKuLWeAA6241NaCPTcoL7ul3Splfx9cd/TCN1SWYLN7+X35jLMVa/h2
 kk/OrxYvg9XXXNwXU/jVXnIjWm4DJZhs+AGfkKgOq7c3qAhA5RuknftELRjxjTRMb2sM5
 rjBlS8GUI6TaLIAstLIZuOkgJ7OD5331ZikXbe6xMBKJeHpTvN8XhyTEaI4B6j8ATFWwd
 nZOwzNTZjpbxOcUe5VathVteHylw2GckMOsAv7mIns3YWXUT852opleDVFEKfNv4/D2gm
 ftsy+lRmLLaVtRhy1l18+Au6Z+uQYsHrsOJTNj9y6TMWZ91n7qajD+deRTsTseTC+Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371140;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=oIyA4b2klrgL3zJLq/K0MGIpgK9MIh6CG+elWuTD0JU=;
 b=Btpvm9tdkLY4H54zy5Q3LZyScFSpK1G9vS1NWf9vXyNXPN9nByxT50WLsXmvQdq0jT0b
 ssAa7gxmw2W/8Tzkuw5pBRTQqYdXhGHdBWxx3V1JXXu/JgvIu4w+Z7trn6EGMDUcf8ATW
 M36EJuhFEFHtBSRtp4Tc5A2KFiET0e+Ool/hIMqdHPwMeb42ByZghbxDefW0VVMtM1Ugj
 Apu5aSV0851xGtZpmOjJ8q8HUtM5wb9iwZu3rYDHFdiiQWSH7np5yYg/IyvRlVUcviiFR
 jj5NKT5B2xt8GhS+vH3eozFSE5oTt+WZ4QII1txls/LzQUGh4QYdAhLqmN8VSSak4aA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="fjT50u6/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=fjT50u6/
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF62340530
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVJ50yJ0d4vA6Eea8MkykIyAePW1ii8ZxKMM5mcQzvjDJAj/2pxBY6N4fv49ebULmbvkXWYOp3GL57iYtmYHEgallkNVA15GU/8Eha8SyfoZ+mCK2P3alGQ9h2P2wCcjDPpDe4rZmV7deWSKtRAvVm/CshEsqRJe6OexQFtMsY8c49ORpjxO9/WNyt+6CjtTWmmL4SH54x/OvIoWOIegnr7W1vzhx7IyMzGDobSvfJajeESWl9zSx4dDp2U9ZsIY7928VcXc1cXiL4L6YOIf9qiSLTszWKF0olAPzpO+2bSaPVH7A4CNem5rz0bfaNApMXD7QAMhL6ab5rqvt41FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIyA4b2klrgL3zJLq/K0MGIpgK9MIh6CG+elWuTD0JU=;
 b=HvMwi0/UX29Z/IlpWPHF5Ynyl1ac03/i+jre9ByAOSomJeHF00gNUimRbMftljkIsjQufc3L4ENH44GxdoWgRjzzUiRYQ4HtaLBCaIL47avxV1v81YgfxwRAVEMQRhd7DcjdQARh/zksoN29cuN9FLVAVkrP0X5WK2QM5Nl4q35DjtrPXUIp8xQ1EBdwRbTca3ta0S0D/sKh654U7/FLdn4TEXPunfvTn5t5My4NTiDA7s0Pehd6MDREfcURa6l7tkDC0CVr2jYtLVuyTO9jECv8xtXiK42fuTHTApVC6IqHQJH20yId4eXgNeOC+3PAQPWIp0uAAGbHLOCl+gomsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIyA4b2klrgL3zJLq/K0MGIpgK9MIh6CG+elWuTD0JU=;
 b=fjT50u6/ctya97/2RAWIukHZJaHzAM6/jDbSzsvr1h2ODSlEEc7DYEQ5gDNhdmeGR0FhMfbtHaWSfr+JoRwub6PltCtRzWsNe5IjBOuIZ5Q0iJmNmx4wTDYDqO3oYGIKjZX8zfCp6GzUe2Ko+tWAD7szSoha6rxi6mfpFWMqgT+FhBdauYc1wTMoAuMVogVBjZhVHbTw3ihVnf8p9M0MKO4b/+eHUaD8r7lThDGqkgEJK2aCtBXC8eK/pX8oFfFJaHE7Dj0tTvoCIrzpwIegMXzgY1rUnJRUmNsHdnTRgK5W9yedaxOx3S2MyhIOvLFE5Ivkidx8xwL5ynhmSd8tNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by VI1PR10MB7733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 14:38:53 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:38:53 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 1/3] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
Date: Fri, 30 Oct 2026 15:38:41 +0100
Message-ID: <20261030143843.467968-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030143843.467968-1-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|VI1PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 35228030-0c9c-4ffd-4510-08df3693850e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021135927099003|261021121427099003|261021123027099003|10067099003|261022105027099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: IKbb8gzP7r3igubj40MwrjFUIpj7jO744Kk+6WdWNQfxY88/LyTDwPW4kf6l2SbUuWC6VrzfGml5u3SSU1XvA71G8KfAqwM61QmLfwfgWEGo7gWwHJFQd2MELQeF8gC+q0p3QpKZpSCaSN4Y77dGRumWPfsrWuIsU1hA60+ZoX7ZZqHduFRkMvLvzxdjU4htOrnVJhZxKu6TnSF2P3aftznV8/6/P47+dlHa+yDGZ99U7E0vn4YZnKjEGoyadCaa7JWFTAWIF4qwpndIWmBg7BVuAu1dAi1LqD/5ld5NGym95T7EPbfLqUzHjKNE73iuhpPaSSGt2XG1S2wU6FEOsgMwizQF1wSNh9CBFXhCmEyIi5GupsyRc6iBiJay7znhendwRV9En6KQUvYPQoa9q1I3cX11BxhpamxgC3CXTKmqEC0yARfmSLBS8d6aS89AJzMRpkxfjKcx8MEIpUpbup8nuTRPVfcTxCJRjmsViR+xVO4cESVFSRWLcLAt8MC5MBwzinSxLTHw+ZPs0Ih6W4Kdt2ySmPjS5PTBgJnbto0+9KAoRvwTmsAGtOs3oAzSlA6i3NxmHGG5xKr6bXEpgURdb5IrHxXo841Awy4CTzrZpMG+7dYyGXCzJcC0flZqpLaoDa9iU5udEFdUWEYk5zth8zUehMJ9WZZ/RJO0R00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dHWj12ufTez7FfwHCCzg5h/l8Fv5iDYSal0Wr4e2xqFxskfTHSi7xFAangc?=
 =?us-ascii?Q?HwuuaAj+uV9/W1YgmiAc1z2QqKdtBONWIauyhTSp0qtK8wT8Z1MJlLMnrHmF?=
 =?us-ascii?Q?PK02gSPf2bI31RmMuQnqtG5iAIHu1q0b/6kI3rxHNnQCO0fVPiyfW27hcmWp?=
 =?us-ascii?Q?hBGeIMJ4jd/PotQlX2vMbnltn6ZyeUkw/SQxj6cjPOtMwmIP9wThHKdG8lTZ?=
 =?us-ascii?Q?nOXToLMOmJU9LnJwR3+CPHgFVOTTb6T+CSEYoRCKWVxmgYL24WWxux3Av8T9?=
 =?us-ascii?Q?by3lFoHRdeAoTkJMLCN0eZxUkgwVnqi1s+B7NRROJPUMEvHJ/Ul3PBMR0moF?=
 =?us-ascii?Q?xcXS9d2Ho5NVAJazpCSn6NGI17zkqKytSgxlgUmw8zReCTBomZJqkqF7YjIe?=
 =?us-ascii?Q?he/JZiA5x7wC2o+J5tSmbYYoW3ZNpPir7Wn8yEDqSlE68YVKV3Ytkz4GZgdA?=
 =?us-ascii?Q?P/ZAIDy7f47yJ7fU0uRsYrIGutaUjksE7nLAsGJVxqF3zxAKBc4DVpqZALhi?=
 =?us-ascii?Q?gZzGlOuLLiTG/1bDLrUuCLA1MJv56pRbudgMYHswyXO/OZWtdygcyC23IuYQ?=
 =?us-ascii?Q?yxfyKVMXujnOz2epsQTxx53XLxgYX17EROjOENpZxcjQsLS81R87X4plcKPE?=
 =?us-ascii?Q?kvhKN4Uo/dbg07ljOzkEypoGl/nLW/3NajvDhNuZs9MB2eTjFXAHBwe0m/Yi?=
 =?us-ascii?Q?Xu7IxPqjFicp43P4F4bBmCwFjxU0C+JjhI2yqwQKTWz0snt4EF8Sj3Ykbs3D?=
 =?us-ascii?Q?gyX6+V2MAdEJP3SM+AO4zJ0TOJVUrVL6K2YQLgWBCSGiSeqNRkWRecTI9ORN?=
 =?us-ascii?Q?hXa3go8FMn33iFS/JbsNkfDSowmufDEBGl2aPsmjMKMIIdwwNhD2x/BxYBUq?=
 =?us-ascii?Q?xySP65K1nyA1yv3jsi03YaPOKirYVfMH6Y6s5vB4l+eVdDKlwHpfTvYMrubC?=
 =?us-ascii?Q?BCDuPq49GICvtZGgASq794pAhwQudYm2S0mmy75sRJH7owPjD8I+Vx3lICt7?=
 =?us-ascii?Q?bcanhMSnkJ2IDmbGx0HNaZ5qorREYePccicVgWSxSk0UBoFQC+RNlP0iQvGC?=
 =?us-ascii?Q?qxFgeAif/m9cPmKgmbDd8ljLS/Lf0+z7SApHNLkr1+qOvejYa8JTvOx/PpHB?=
 =?us-ascii?Q?yjiPkSjBMLiHSfATOJtZQw3RXrF3iJ1xBo9kOg9ZSpTJKVIcOvaJIYq3sDIB?=
 =?us-ascii?Q?2xmY2nuyT1oCGIEgbK/cuVemOODsW8Tgg5U6HHI84LyaS9SP3x5tCsuvQAD1?=
 =?us-ascii?Q?X/N2jtegWMkITyMFd0MY7aIIHwpBZH+MkIemKeJS/dPRtJmXm7E2F5DK+XCM?=
 =?us-ascii?Q?Q7oG3zw0YzQFDIIkIoEgD13F7MO/QtwPjDd4pSzrzlwzBGANS4rnYZCaJKY5?=
 =?us-ascii?Q?2eLljDuIdgj8U8m+V4Uf8H0Ial9Z7xuwCPw242rxSFh0aIE9ybUvEj2AidOI?=
 =?us-ascii?Q?3Dz59j7Riqao1fsTuRJ7ezLfzwsXbfF5Qv+1yUQWu+IbImhkYj8k9IbTzhxl?=
 =?us-ascii?Q?KLEfupjq8TPFh/sNt+/kxB1IKgFyiQYy0cB1LlwmOy8gLwLkyfmmkmav0UaW?=
 =?us-ascii?Q?zZ2VRNwFPJ+xgW8UQt9hpy9NIj5hZE2m0vzpFqD8lWxc6/pe7kupO453dMOd?=
 =?us-ascii?Q?NhMikxk+hz2ssZSh51Ga5wR7bYts4s3uOvOffw7dAsUcYmORw0gVdNyvGBW3?=
 =?us-ascii?Q?qw4mDEBnolA5aTHR+Lk8ZeYg+qXyF77RjGeBigX7T5WhgMXwEupq+aa4916p?=
 =?us-ascii?Q?rAF8VXJ/merje5tns+kSFuiI9msj3EtULmzMpwNSBFNQ6kuy7esqBqsgRzOx?=
X-MS-Exchange-AntiSpam-MessageData-1: fvDRAVNxG+PVQhxGGBPVBM9THpYkRpYvo1k=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35228030-0c9c-4ffd-4510-08df3693850e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:38:53.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8ar4HiUOM1Q+1lj43yaHNSi9JamAsvAir653sLCAC2/1+YtwTfNa50Ma45qw2A1MY61M/nRiGqw9cJS2/udpt9iOk/aH1SIR50Z6MdRSjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7733
X-Mailman-Approved-At: Fri, 30 Oct 2026 14:42:24 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
measure the time spent inside the bootloader prior to loading the next
stage. These values are then forwarded via efi variables to systemd,
which exposes them via systemd-analyze. This helps to identify where in
the boot chain delays are happening.

Without having the protocol, bootloaders have to fall back to direct
reads of the time counters, which are architecture specific. To unify
this, we implement the EFI_TIMESTAMP_PROTOCOL inside the efi provider,
resulting in an architecture independent interface.

As the implementation of the protocol is tiny, we default enable it. If
this is not desired, set EFI_TIMESTAMP_PROTOCOL=n.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 include/efi_api.h              |  4 ++
 include/efi_loader.h           |  4 ++
 include/efi_timestamp.h        | 35 +++++++++++++++
 lib/efi_loader/Kconfig         |  8 ++++
 lib/efi_loader/Makefile        |  1 +
 lib/efi_loader/efi_setup.c     |  7 +++
 lib/efi_loader/efi_timestamp.c | 79 ++++++++++++++++++++++++++++++++++
 lib/uuid.c                     |  4 ++
 8 files changed, 142 insertions(+)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..9789237b025 100644
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
index c4b0c2137b8..25e2c4b1144 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -469,6 +469,14 @@ config EFI_RNG_PROTOCOL
 	  Provide a EFI_RNG_PROTOCOL implementation using the hardware random
 	  number generator of the platform.
 
+config EFI_TIMESTAMP_PROTOCOL
+	bool "EFI_TIMESTAMP_PROTOCOL support"
+	default y
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
index 00000000000..78cefd7a8c1
--- /dev/null
+++ b/lib/efi_loader/efi_timestamp.c
@@ -0,0 +1,79 @@
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
+#include <linux/kernel.h>
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
+	/* get_ticks() extends narrower hardware counters to 64 bits */
+	properties->end_value = U64_MAX;
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

