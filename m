Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83B606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rfeOQ54j;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ROy8yt7+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C3448143A;
	Wed, 11 Nov 2026 13:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGL9QD3PqrDN; Wed, 11 Nov 2026 13:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7535E81425
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402858;
	b=czpXL9mTqR8LReRm0vdZCG8d5annI6FPyGKOtdF2j7CxmFeephZhSxfaNFu+cK/iM8WH
	 aJvVWX2f7la8jLT7kpFEWt/55PJ+QYJEvJ1PnVhg4+202iEsb2R+Ly6bB6e7xzFtqdf3Y
	 17yz6sicbXExQhSqTsGSctRaDNN41zPWsV9FKMPWIkHwZj9w/GJpO+agW0sP/a86u6Ph4
	 xl37I+lO0QNDChcLkQx13rVHZR51Gn/glEaetU451crrZrnqdAn4okz1IHk653GOUn6h1
	 K6i0nkb0Xobk6jDPqcrHEoGkssnBXXJYOop7w1sQ6KGgy2LAdeBLi02f0CELOUYr5KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vJCn515NWTAK/80Lh58xy/KzcIUyoXB6fVHUpO+RcIE=;
	b=PAN63O02JOGjEIOzi4XoCXqlWOKFemU2WNPgmZndp7AdByG7koQ2MrKV7JOlAvutqRIp
	 XYRK84YKILZH6Sq2yjvECj8chtO62mRm3WLcl9D8qJcAY07IvJFh7S3Kjo3HC+SrzaPHG
	 CGt+NCzrWWu6ixjUNtCKeMSypd2MXNKrXvW466U5k2COzZWI14/lhzd44xFqWvaqIQsBc
	 Hd1M/YNWk4psycqO2g7nI9Lb2a1l90jrzh7iVSW4nNQpUo+oJmoBLPVcpQbqRR2o8fLAu
	 y09wZJ9hRbnJPnD1CBh8Lx6QedR/LgtXhYGE5BURVgwpDFzsDyVPkutOvXnoyRfiUHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402858;
	bh=vJCn515NWTAK/80Lh58xy/KzcIUyoXB6fVHUpO+RcIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rfeOQ54jHHsMpTOGI7X6ayXoxpgGpPunfWIfnVdtGYIcJiS0lei3DnMcUH4FSd5a6
	 SL3N/OYqgEV7xKSwb5QHjQtxZmG9XWrYgr+olkGhy1nO76l0M05ERH0thWBZ/MlMv+
	 FSJLtIzAi6zoTrAMr9H04dy/Kg4xznIdxmzZOhJ44ToTwXeG7CzbgQV7OWYpTYxU7h
	 DaDquqPmhTtK/YiNusPV3UpoHqjvpuo/Q1kRUylSNPEVRYg55/rlzJHSkyqCSne+Rm
	 EIFc5C7MYkSfGprIZ7dAqId4w9yEHaMx2w7WDJwUgCpCvlyX2BDtPG9QwVTymohfbX
	 Sko2fPM2UsxyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7535E81425;
	Wed, 11 Nov 2026 13:14:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BC49DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D37D40070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRBG60IQ2Fuu for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1F02940357
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ROy8yt7+
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F02940357
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJCn515NWTAK/80Lh58xy/KzcIUyoXB6fVHUpO+RcIE=;
 b=ROy8yt7+tt5BBzq6iNYaoeRRskfpH2p6YM5k1pnX6mxUyxkV8e+D75IF7RaMxFMdyhPcI2NfA/VeKag9NlOeTATTQ+il2hgVbfT/7Tmvkqto0C92YDje+vJNcRZMK6hmAygxFRFSfZwbTLpbfwA/PVW1hVXTVa48Hg1sXmcopftmmpfahezPgqPScFwLvduxvnecpM9NWqVbjg75awLUwX0W2J1bTrr02o/Cqo2s6ZBuBfwVberqvf6BKAkLWvcFE09kWr/UK4p3NvIN4+WN8eU21RsDjBmJP31OvJjCT11odZrNAdo+lM3a4OVYSjEL5a+HsOYV8n2dRBfPW5nPLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SACPR03MB615085.namprd03.prod.outlook.com (2603:10b6:806:540::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:51:17 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:51:16 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 u-boot@lists.u-boot-project.org, chen.huei.lok@altera.com,
 alif.zakuan.yuslaimi@altera.com, boon.khai.ng@altera.com,
 kok.kiang.hea@altera.com
Subject: [PATCH v2 4/4] arm: dts: socfpga: agilex5: add SD/eMMC UHS PHY timing
Date: Wed, 11 Nov 2026 16:50:56 +0800
Message-Id: <20261111085056.15418-5-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20261111085056.15418-1-tze.yee.ng@altera.com>
References: <20261111085056.15418-1-tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SACPR03MB615085:EE_
X-MS-Office365-Filtering-Correlation-Id: 373528ce-4c2b-41a0-fa5f-08df3fd0f295
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|55112099003|3023799007|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: x5Sr/fhkckRYwv3Yb9ik260hTKAUFZV7iGuLX5qsM9h9+1/tsKe6iM10pvc6YJEgk94UqpqUnOwubySUfXI9xpGHWasUeZ7Tj1G14KWYZSYj1Pt9VKog8/3pubZGHV7kDZqAYk4DV8PSIuZlMmotvgSTW7u/jOziviTJ1ebIdP8k6UpdpNt7wxLHZUabH1uLSklFtfUNPD6AM59nLsirfLVSLReFZEZEi4AvfqB02q5fQNVXO1JljaezsM1PD7FwyoKbf7tThXhEQsh1/nLEO/WJhN7MNtf3xzMixBT7vQsFD4m34lvZzehVy4IfDt0vgmQ7CVGH4lRqdKpNCIuO2lzoi/hKYyeJedcUOw6HHb55b3fyaSE0iT1wjTdni9ij+zmfUYkNdpu3h+ac0/DeuTBkOyadATqb51cONWmUzsUAaTACXOqn7ov0SePiRolaz4U3LAXoUOmlWYknF8ex6lwSBHbUcZbmHXpscJ/LqDwnq6Ca5Hr7UvScMEGqCxvnWT4Hxqcl9aZHtq9qm6nfiIUNiTxVeb4cUrfXZkJm9QJrwT7Ou+DufrBuyuU44bh3Il3MlggHGEJlvxmIQ927sVYthAodok4QLsb4CN8mTZM2nHeKO3hvicWtyh4TdoQ4FZo8Xl3/uVL/MDno1l//ogQqStelxj0L/kA2UCISVMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(55112099003)(3023799007)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLGBUNVd76j2n+o4N7Ml6z+wu32xzJTIyK8pjYWIyW7dJ544BnNRxYl5WLgi?=
 =?us-ascii?Q?PihcLx/Q+P0XYUWOVk/RXUOP3IMf41NXOSdeQ8gmVqyVCMyxdx+p0oB2mV8u?=
 =?us-ascii?Q?VVQuRS3IsRmsMCkZ2YzEc9b3ffeQJzFcXOeXIClOr3a/3oC6KKeQY7Pq4oiG?=
 =?us-ascii?Q?eEFv0gybFGHwLa0PDGvjkiABBHZYlOcIkZ1qzGl+2+a2biRghgG2dcLH3cfh?=
 =?us-ascii?Q?GU39lAUal/H7yNXXNYJfMa10K0GbBQh1bUip0OCFmzPO4mBZ0JLKmD1lxwC5?=
 =?us-ascii?Q?9sWxr8zyaJ88DNs8UBhlZWyRZxZttKNNulgVOIx+xFf8vpAmzwqqldDLzmkr?=
 =?us-ascii?Q?oJH9O6fDbyVmkByfUrIwy7+VKTz10fYgHC4axUtFTK+6aq1kQ1B7wwaElPJn?=
 =?us-ascii?Q?3Jj+u5YKcMUXHU1MP0dWjoHiXOfkItWSRlg/IWU8Ztz75r/wFRstBIUFBHrl?=
 =?us-ascii?Q?KjIZP4F73rj6RjV9Atj3xoGKjQDUDQQyvq/EQrUhD2eJLhaE9Gr8zjKW4VJ/?=
 =?us-ascii?Q?UqHUsGp4C6OtTs1q8sURcL49cN5ugCYLYQfRF/Sgx1MYsq46mS1RQrVBy8mw?=
 =?us-ascii?Q?hoUg4NPKrg2+BI8IDqSjX3W19yspHD1QRILdwS5HrazE4hrt7ws70kDWXe3m?=
 =?us-ascii?Q?tSkSF+ZC9es6VQUGU4M3pvZfGkScQXFFsbi6GmguJddBJRWv6irMIvZBB3Ua?=
 =?us-ascii?Q?DgSTGQD/lPvfvb3KcpMmzALkc2o7A8bjQ5KH9uUZipvj21VzTsdh0TJfmsNT?=
 =?us-ascii?Q?IpQE5B73xRwsajs0mdWrJsGtptfn4ZDzVqBJ/jMjqFhOQaIhwyV7IfADrCtC?=
 =?us-ascii?Q?KXydNsojWb4yj5gXAcmx0buNhfoCvpPEao/NmMZLxPYm7i6///SBO/vJZ+6v?=
 =?us-ascii?Q?PXxQobToxEphQy2HJrHE/Xl3fsKgLBay6sphfUeY8mSVv6zwPtaEWmcbz85C?=
 =?us-ascii?Q?Z4Ol1pEoWrpAKAsArt6edqBcBRRTuRmzotkFazD2ngXY0SHYWVHsPqmmjKrI?=
 =?us-ascii?Q?UUvbbWBpz3J3ecf0LFRIYvu8ba8tym8WK7kgAIrgTlAQlj+h8nudNXId6aty?=
 =?us-ascii?Q?9EWholkq+7i3vA4VHosqNVH8xq4Ya9Cz6x8hhBTbmC9bZq8Trn8QY0JgicoN?=
 =?us-ascii?Q?SlXK3qE8/Kuc/h/reEU3GTprjG/01ZDgGUFz32YnM+sa29EVRcEY0+AjoKcp?=
 =?us-ascii?Q?/hNiR3PdPDpeCUBkFFoCfrpF8pUNsWR4NpjX7MFL7yXgkFgggqg1jr5/559d?=
 =?us-ascii?Q?c/sOtQigU7zd1pB0/c4GLlx6+CfmX4SIh/uVbywY47rz4GUYujxMEIfRNzEC?=
 =?us-ascii?Q?sCNa3EY3u0JH+Z51b5ZV52hLHvcCAQkhJGX6WtRqBS9Z58NqyB5xWgl0jrnv?=
 =?us-ascii?Q?eyBCprUQJiE3ApB00IJWNuGuBIQ9IYSJlomwwKGp0uQPDzMb3NPpjUKsj6+u?=
 =?us-ascii?Q?+qZrtICn4jdVm6ruDsjYxmSuohZS0ghqxrjACiuTC9TZxAt7tnNz9rYW7f31?=
 =?us-ascii?Q?JJrVkBIdGErrNCjx6ddMlXPyrrpyIgo4v7mi8caXwP1K8HqxLTCEV+m9yYwN?=
 =?us-ascii?Q?yTgShypA3/yCaLda2Z1eXSh35538T7gZLS2O/BQhuTGlQsEaxl5BD0BTg5of?=
 =?us-ascii?Q?Rr5ttmB2Px04XvlHkkq3aRZUop+EPbW/4GV0OgB5Ji424m0+iyJk4RC+6Z9m?=
 =?us-ascii?Q?z6M2nc10UENCFrd63wDOYd43c5rUWhoZusFIFkjuPTXbvTb5fuGi8QlVsyRG?=
 =?us-ascii?Q?7cz0u/u2qg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373528ce-4c2b-41a0-fa5f-08df3fd0f295
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:51:16.8944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rR2qoHBHh1Xb6nD60f2vFTcIVSOCTqjVwz/JLMn9uT8gt8PsABSIkReweVnIG2+chb9pNVv09d+y2DCycQFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR03MB615085
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tze Yee Ng <tze.yee.ng@altera.com>

Add UHS-I PHY and controller timing so SD cards and eMMC can run in the
higher speed modes on the Agilex5 SoCDK and its 013B and modular
variants:

  - SoCDK: DDR50 (emmc-ddr) timing so SD cards / eMMC can run in UHS-I
    DDR50 / DDR52 mode; advertise sd-uhs-ddr50 on the SD board and
    mmc-ddr-1_8v on the eMMC board.
  - 013B: drop no-1-8-v to allow 1.8V signalling and add SDR104
    (emmc-hs200) and DDR50 (emmc-ddr) timing; advertise sd-uhs-sdr50,
    sd-uhs-sdr104 and sd-uhs-ddr50.
  - Modular: advertise sd-uhs-sdr50, sd-uhs-sdr104 and sd-uhs-ddr50 and
    add DDR50 (emmc-ddr) timing, overriding phony_dqs_timing back to 0
    (this board needs 0 on the DDR read path) via
	cdns,ddr-phony-dqs-timing.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Drop the now-redundant "cdns,phy-ctrl-emmc-ddr" overrides on the SoCDK,
  013B and eMMC boards; the driver now derives this value.
- Express the modular board's DDR read-path value via
  "cdns,ddr-phony-dqs-timing = <0>" instead of a raw
  "cdns,phy-ctrl-emmc-ddr" override.
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 12 ++++++++++
 .../socfpga_agilex5_socdk_013b-u-boot.dtsi    | 23 +++++++++++++++++--
 arch/arm/dts/socfpga_agilex5_socdk_013b.dts   |  4 +++-
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   | 12 ++++++++++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts | 19 +++++++++++++++
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index b4b8f54b969..4768fdabe55 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -114,6 +114,7 @@
 	cap-sd-highspeed;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
@@ -153,6 +154,17 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
 
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
index 75d51ef06e3..63b9b9d3ed7 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
@@ -121,14 +121,12 @@
 	status = "okay";
 
 	no-mmc;
-	no-1-8-v;
 	disable-wp;
 	cap-sd-highspeed;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0000c800>;
-	sdhci-caps-mask = <0x00002007 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -153,6 +151,27 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
 
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
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b.dts b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
index 9605fa4cb00..1bec13d998e 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
@@ -90,11 +90,13 @@
 &mmc {
 	status = "okay";
 	bus-width = <4>;
-	no-1-8-v;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	disable-wp;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 	cdns,phy-use-ext-lpbk-dqs = <1>;
 	cdns,phy-use-lpbk-dqs = <1>;
 	cdns,phy-use-phony-dqs = <1>;
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index 52aa92e4292..f53846a0c46 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -25,6 +25,7 @@
 	disable-wp;
 	non-removable;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	bus-width = <8>;
@@ -71,4 +72,15 @@
 	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
+
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
 };
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
index 032e40fc639..fe026d6432d 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
@@ -33,6 +33,9 @@
 	no-mmc;
 	disable-wp;
 	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
@@ -71,5 +74,21 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
 
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	/*
+	 * Modular SoM: override the derived phony_dqs_timing (1) back to 0 on
+	 * the DDR read path; at 1 one DDR beat collapses onto both on this board.
+	 */
+	cdns,ddr-phony-dqs-timing = <0>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
-- 
2.43.7

