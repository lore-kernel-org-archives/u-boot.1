Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D640606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QP+SoQ+L;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=leFQZhFb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35EE74097F;
	Wed, 11 Nov 2026 13:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4WE-8kkUW0wI; Wed, 11 Nov 2026 13:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77EB040974
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402849;
	b=YCrbZeAFyqBDN5JXZRGqoxAigPU1N+9UY+35WbYawYS1A/wy4oq4eHlgRTU+ODrJAgTt
	 qgps2kwM8AZLDg32G+hx2STI2bYUtIE2VkrpV3VXueFsO8hMuiGZNjLzsajDvalcJOwOc
	 x7xZs4iUXI1zwtx+hA+HA6gYXYrzeX5MP7v/QylskcQhsS25k6lIKA8pngjqGW1psLV5Y
	 QJgbX4XRKuu+UaxpWv5NpmFvbtHmZp8CKIACwWeHnHwx+9fjaR8ec4izYvZKkgXDcLl8n
	 lNf7EdcFffN2+J2yB+S7Wd4Ui8Xup8tZJKkJMLRhVbntqpMgohfa1LVFHd19ihNU8Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M1ajuHu6X4rcB340nFhFwKLo4H/6FXGXXaMghtT8CQc=;
	b=FM0BE48joH1UrhZE0ZMr+lhUqVIpDfUVa4lrljNqrfiy2yCc4ghjZhj3M5RF1WRu0Knd
	 iZXE//pLeArokJ/28ldjNoGjE4QC9IguMrpwCABSkHfcmqzAhE5ZKxerC+kBeJvNqOcxf
	 RgL2bqnjXmFYowG6FVDiYi860oUdZxXzE7sVbL1y8hflQWPmW6bOZsVabtFe+MKw0ZQCE
	 GHiRWSwRq3/BPw65pyyOZETFCGJNbZUxME3uspUgudh4Gy+RAev+uLPhq5uiVJ2UuwP0W
	 2U4kIykG14V7Uy81IdJX1WdOvr2l55xIBC/mSEqKe1v2kKNwckOn0m/hcvynI6jKgrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=leFQZhFb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402849;
	bh=M1ajuHu6X4rcB340nFhFwKLo4H/6FXGXXaMghtT8CQc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QP+SoQ+LRwlxdw9JgUKi8QI48CXmBZM4fbFVdCNPtv1h7aKL2UcXORGnlt3RI8SM8
	 pX8CcLDeqhfqys1Ot0q7SXYm1+iOPo2T0hNIc6lAy6qNB9ob/9oAkuvtPBTjyE8SMH
	 z/0lLahqy+7RKaRi5F1zbG9nPOlQKkFMwEPChKlY3k89XAczdb0HwSwS/khPsV/aP9
	 1QsCZpvAJWe3qBVq0uBnE8EIGtFu2rF2efdPad7bgGLQze5w7E2eO5IbWjjrFHz29I
	 UY6v2ow41o5cYHgWMbiDl6EldExo/N7zoega9qXk4zS//qjg+Q51NexP34MKCslIUx
	 y7MJz9TbWiJ3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77EB040974;
	Wed, 11 Nov 2026 13:14:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0713117CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC584409A3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bg3EJ_h8JYgy for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 03:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDACA408DB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=chen.huei.lok@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=leFQZhFb
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDACA408DB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:17:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BDB84A29; Wed, 11 Nov 2026 04:17:05 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A354084827
 for <u-boot@lists.denx.de>; Wed, 11 Nov 2026 04:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1ajuHu6X4rcB340nFhFwKLo4H/6FXGXXaMghtT8CQc=;
 b=leFQZhFbRJTmE5h0nr0QAZLHie8H9XZ1jqUETdM/abe+wIGTZtOsj5rfwHrq8mjRTMmNiRYC/OZF0RJA1zn005GIxiBN49OdodCfFqfb/vZxY3KNcrsYKqhgqMXbrF9SzAGQ86FNJKwDdy3BZDt6NNUCJ4zv3IA1aVsc5m/jGb/lme2rzwehp+0lFSbFl7292QnlLMU3FmAK9zF3kHD8B0sVGgTrLh9+3CS3FZn5h6dq1DHJCYyxdyeCOCTtZjyPn0PB0bUSx/ZnKsq76g8GWQoO08P13naLWGTqm/dz+cEffoUzD3R9DEn2Ju2AuFmsPcRrxQh2qzZqsFKELTtUxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH4PR03MB8019.namprd03.prod.outlook.com (2603:10b6:610:242::16)
 by SA2PR03MB5788.namprd03.prod.outlook.com (2603:10b6:806:11b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:16:52 +0000
Received: from CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585]) by CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585%3]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:16:52 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH] cache: ncore: drop redundant OCRAM firewall bypass
Date: Wed, 11 Nov 2026 11:16:39 +0800
Message-ID: <20261111031639.9463-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To CH4PR03MB8019.namprd03.prod.outlook.com
 (2603:10b6:610:242::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH4PR03MB8019:EE_|SA2PR03MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9983842e-7e71-4c7a-b4d8-08df3fa23ae6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|261009223027099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: Ik1w1eVmSEehTrDV0vNCOhYpRaBVgKRXHX3i4YHG3jrInyPMHqGGtisGbsKMudoNmz+HqdpVFB2rlM4kI8Rr4YV+6qsFXwHnutkS15eSuGDcJugNJk95TaD5uHW87xsJeyYHlp7/rXjQJORGas/f2fVkCwGtbTLFnUnJ1jm4B3325nh1g/ExkqqdV3G1ci2M7gumc23PFdEsRCoC+62vhUiSsJvYmHxBqKIizcSwlSd4saBVQUDNSp92qyvSkxxEGYALqVD1RiOIocOzaFxHgYWxhV5EntyGwIMpahsIFrNuzORjO1Cb6TBaUpJwKAfSGUxZESqOWkXi6J1JyTivLz74b6oRC4ohtTmnBDzehnxlr9TFrFwVaFlcU51jFQaIy32pMCNIqrwD6qy5XuhQUiqPJYBE0kFsrQkmzk7HufTV1jMbTHAqah/0BP6XuohQrmPgyLQo/ZZkMZfR5BUsNGJFX+4Rzoi2hkqEtkCmNHpfdeRvxlx4HYEUhPb4uJn/Eh4yY+XdtIcPV8YrC9LYMkZwmlOefPtplfDZWoxahzdhNJU3jBQImWNNN90zQZIo48vF+hztzGydPCNHt2LHD/Iug1iM3I3QtTaVAF2hG+YSyifBQIJNOgeKzthSEbCUEdgTMt8wDWRhaqMNSRx5DtFLzhwqsjdUTVbmFJ6TUNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH4PR03MB8019.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(261009223027099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(56012099006)(11063799006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GAsws7mHJzfQHqp1NjvvMWi7zIuORy6N3lxrRAiaTHlRFK6VlHrWUr+KnZ+2?=
 =?us-ascii?Q?CJb+cii0FMpm1MgmROt/9wLSDvL+tcxRVpxXkk78TKmtJnCpl6PRp6rwO3dI?=
 =?us-ascii?Q?uAhzpmkTh8bi3w4mGdOeqsvP1Xqo9biYOy4bXCPukCgE7os+z/V55664GBV3?=
 =?us-ascii?Q?ugUjducsLbOTGv4ydxdX/7zfpYLL0e67J87jvTWVRWootz3dp9oqsRMCNCR/?=
 =?us-ascii?Q?H9Oj3OGW2Js0EwMQYeF11ONR/2Z4mDHfWUqn8YnYNb+bm0bgR4GFt3+f2tp9?=
 =?us-ascii?Q?fwBvC8/JJJjmCIObSaqlY/3ToPNl21pj3XJ1fV0Lty4is8eY0HKosKmxd2ed?=
 =?us-ascii?Q?Z/aoUlW7V7eIO0iohHCIlkZMfgql+MVSQcFJ6YEMpvwsHP+RlS1sEYnzBnV3?=
 =?us-ascii?Q?8jrKeYmxOFyoRGO06fJfNstr5Octt8zU5mEnalPEjaOR1CkB+g0/kuERKGhD?=
 =?us-ascii?Q?fHTdSOCV1Pz/lC0JRcHexI5ynuS3Kp0QIM8C1GaLpya4ZOnoeqpapNrkyQ+C?=
 =?us-ascii?Q?NgvMyJpnwS6O8sKBz8sqON7sm41a+FMw2CtsR6AUBVMbAHCMccz0LgUi4Mzk?=
 =?us-ascii?Q?6IDb/sjzRZf8bsXQ2oL8KSXsUPvCKdOD9xmkui2pEnXO9uuekVWVVtqbfq22?=
 =?us-ascii?Q?p0jk/n/xcedZmox8TXmQCW0okqp1xavWZ6l0OVymm+4A7jIszhDpFUqK4run?=
 =?us-ascii?Q?uMtQoBfPuXjxZyj8xea3OUez3OkMXw1+07nHrldf0uKT9HFk5gkwmzXHfW7J?=
 =?us-ascii?Q?8ouNnvZpnAS8qHES0BlDVer+rrawph9wCwB7RpJzsi55Zq23Q7j9gR8XqLoj?=
 =?us-ascii?Q?i07UMeXYMsvtlM9BBJmpOtvMi32+G+LkDTMSRxc1p5eoZHW2l5Q3jARi9Zh2?=
 =?us-ascii?Q?fSjZkcwcbNtoGqMpgVfgzIoFd83dDZSi5ZVqt5ON3WDz4JTx/bfF/Lk63vix?=
 =?us-ascii?Q?9SxE+vPVe8CUzelXJY0TtbdCcqDMlBl4X7G91DG676wSEEw3IaIR2BV53Jnw?=
 =?us-ascii?Q?sL0xv6CpPA1wIjbeE5otL6ZAERMcOV6iRBATgLbf/h/SG9FW7Btj0pRt1sB0?=
 =?us-ascii?Q?pfS37sqitwKVQvnuxsDMuVOt/SiGpDSH5sskD+s+KexGEOYE/e/UY28FrB8l?=
 =?us-ascii?Q?ck6iFTzgnXBJGzx8n4GML15ll3z8ZoVSBRJTZj5PBxZsTCLPkcX21U9n+/Eb?=
 =?us-ascii?Q?K96+SHScKmaLHqxtnulVMXvriI9TKShGq5hDwv1bwCDtaLt3mu/vynRQ1qdl?=
 =?us-ascii?Q?5fXXokHsPi36bzru0o70vGyQ/zDYi5sOFas7lORqiZVVUVxXvyCXLrmStT+3?=
 =?us-ascii?Q?pJ8/joo9vyFp7ubtdinkT39sxjSAzF+4DoRVZdF/iCpNoqlvNGkO1eHriYUP?=
 =?us-ascii?Q?gk6imJkx2NOYgXkWzDCoWSyFBUWxjI++/AYs3f1Mp6a9ABTwH3rDGQVQJTgO?=
 =?us-ascii?Q?EwlXKRSoSXSPikky/brV1TIN29njDBQYy5eBFiq6f4W/NUe495+d8iXPdbvm?=
 =?us-ascii?Q?wPvKn12VS57Pf0IQu7De+vko4yYaIojOzWglo1I99RXMEi2U5NDwvLtgWoeC?=
 =?us-ascii?Q?smnewpLnSkx3TSGCkfU4rMsjshEbU+LAAsa0NgK6hlUcxuctUjS/hUNmxzmP?=
 =?us-ascii?Q?85FvCW81/j0dxkTOPBAc3t+jQ/UCbA5+Vpd6nc9lb85t8fJR9C5UVKl8vTTa?=
 =?us-ascii?Q?wpZTrCYQDahur4WBJ1Reptg+yDdC80Vy6Xl/IDRWyNY8zjX1+WKP/sEjqguQ?=
 =?us-ascii?Q?0Kpl07uG1g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9983842e-7e71-4c7a-b4d8-08df3fa23ae6
X-MS-Exchange-CrossTenant-AuthSource: CH4PR03MB8019.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:16:52.0859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd6cZqKhnZOLN5GbSyiQuL/F7yd0WJA04Y4YfNmTq31Do69rNWBqpIYa5fw2lQHjpiyerDNT0laM9ugIwiJuho6vegJQRjXqt0xH77JytyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5788
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tien Fong Chee <tien.fong.chee@altera.com>

SoCFPGA Stratix 10, N5X and Agilex already disable OCRAM security at
the CCU through intel,offset-settings under the L3 interconnect
firewall DT node. SPL probes that node before the Ncore CCU driver, so
ocram_bypass_firewall() in ncore_ccu_probe() is redundant.

Remove the hardcoded programming and keep the OCRAM CCU firewall
configuration centralized in the device tree.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/cache/cache-ncore.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/cache/cache-ncore.c b/drivers/cache/cache-ncore.c
index 117d2b91ab2..c512e7bb267 100644
--- a/drivers/cache/cache-ncore.c
+++ b/drivers/cache/cache-ncore.c
@@ -43,13 +43,6 @@
 #define CCU_DIR_REG_ADDR(base, reg, dir)	\
 		((base) + (reg) + ((dir) * DIR_REG_SZ))
 
-/* OCRAM firewall register */
-#define OCRAM_FW_01			0x100204
-#define OCRAM_SECURE_REGIONS		4
-
-#define OCRAM_PRIVILEGED_MASK		BIT(29)
-#define OCRAM_SECURE_MASK		BIT(30)
-
 static void ncore_ccu_init_dirs(void __iomem *base)
 {
 	ulong i, f;
@@ -124,16 +117,6 @@ static void ncore_ccu_init_coh_agent(void __iomem *base)
 	}
 }
 
-static void ocram_bypass_firewall(void __iomem *base)
-{
-	int i;
-
-	for (i = 0; i < OCRAM_SECURE_REGIONS; i++) {
-		clrbits_le32(base + OCRAM_FW_01 + (i * sizeof(u32)),
-			     OCRAM_PRIVILEGED_MASK | OCRAM_SECURE_MASK);
-	}
-}
-
 static int ncore_ccu_probe(struct udevice *dev)
 {
 	void __iomem *base;
@@ -147,7 +130,6 @@ static int ncore_ccu_probe(struct udevice *dev)
 
 	ncore_ccu_init_dirs(base);
 	ncore_ccu_init_coh_agent(base);
-	ocram_bypass_firewall(base);
 
 	return 0;
 }

base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
-- 
2.43.7

