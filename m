Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F7606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lRApZGWp;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vSBQQbIt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A5AA81351;
	Wed, 11 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u0TGNvrKHpa2; Wed, 11 Nov 2026 13:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C348812C4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402853;
	b=cAtqwHnjojH/ol8xO36chQynLpgHNO8EntcLEnT9+n5IFM6BhrNdNI8RXqT8MJCy9Y7K
	 0t7BovphX10+ODg+fpK34zbYgDLNCQSr6LFSB0oM6CCuANsoJPqE7Ly4VY1258PU79VQQ
	 6mTveQoDf0BjmquN4MHL+CRXZe0D5AF2VizwphAOXV601I5954DpX62oCSJ3lFIM8JZkD
	 hXIt28a8ZVXDGX66g62jTLBVj9XipQfm5MmYgTY/joo5j/2rS/YBRC/iPlF3fwYp/fj7Q
	 E9uKLhBUYVdyMrX6jUiKtnRL+fFUnKo1abg9tPAVQeYLymy8twM/9q846EdG0emzISA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402853;
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
	bh=1zOpnG4OtpqFfzDKJaF6n/CCVlihVC/pNhoZRA9EwGk=;
	b=Ope9xfwLJGcf5m0IyKjRbosvFRSiZW2+1Gsip6KFhEcIsuKWREC3MKvAE8HnwB2P0cxp
	 mfYLoBs8Kes8i1ww/hHHJLuCboy9ogzbcXyGzRwQZ/zy5bEZZecWgH/ZmjR0w0AkYsl4S
	 3mvjRyaqe+kv2AChwDABR7hmn6z8LJR9f2JzXRIxRQHIM5+cXye7KFh7RDrxSI9avDJAZ
	 Z58T7Fc81KKFdQqYPBclFQ7BYRtSidQn8fcWafZnIO63pRX6vB4a7LZsyJ6wlMRPVH2zl
	 eoEN104DW8rGjF/EtFkmg5j9wK2kTekc7jLx1OapeOfwmpyUe9VICy/FDcq07F4GYrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vSBQQbIt;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402853;
	bh=1zOpnG4OtpqFfzDKJaF6n/CCVlihVC/pNhoZRA9EwGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRApZGWpADYyPBWutAJVtMz75csIWKWHz7TwtjLkjLP87YSL/098NvxnJd00Zpven
	 IaawScMTschYvOb6rtEVHbxSDg5ECzX3dGvkWqlJLPf0MIarWrMEpHPY3mJjmQJBDi
	 HCvhS6aBsijP9JIc3KiJRRBvmpwxcZOJ6HJkZGAw5i5x58VPzEBGdxeuJ92JMMFNob
	 YMUGoH406sG+ytY8fGyar6aFuH26LIEsVWIqXkTvbwuO+WbBUCLCwLz4FB3PoX/A6a
	 Df/M+niM7ljp6VvItixsTtyRby7XSQujJObrewxiFJHHxQbwW+IGycdGmxxkSykWMY
	 cf9a5F4gD/zJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C348812C4;
	Wed, 11 Nov 2026 13:14:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF2B617CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFCBA81288
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PeidoEKro7d for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E13881279
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vSBQQbIt
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E13881279
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zOpnG4OtpqFfzDKJaF6n/CCVlihVC/pNhoZRA9EwGk=;
 b=vSBQQbItf9174g1birJP5lHShCbNjm263WLBCiXBOV1xhd96CGd5F6mkedohPsUpUhslhkP43GkW/OErKPPrltiWgOsKjB39B2KBTgbtZRAE73IZ59NjRcBk2jXhEahO3XOTd0iYUBx9voZr2DgCOZI/ru24Ma8isohePFB+9ZKnbmA0+Zu7J72Z0/v2uxTaY+cC+KY0omahZr+Ew15HPLEIn9JA60laf5P5YW7WIeP2CcJ1VOsTraTExwXuLQ4tjae8qkmyayw3NUiGnbpznnZe53MU8mUktTiLLFTBQobwMQK2g1qh1Qi/B5zkg41gMIzUqyfG/DIV4wsKWFJxLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by BY1PR03MB7851.namprd03.prod.outlook.com (2603:10b6:a03:5b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 08:51:05 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:51:05 +0000
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
Subject: [PATCH v2 1/4] mmc: sdhci-cadence6: use const PHY config tables with
 per-call overrides
Date: Wed, 11 Nov 2026 16:50:53 +0800
Message-Id: <20261111085056.15418-2-tze.yee.ng@altera.com>
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|BY1PR03MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: d227f2fe-639c-470d-b1b2-08df3fd0ebee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|11063799006|261021123027099003|261021121427099003|56012099006|261022075727099003|261102123227099003|55112099003|18002099003|22082099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: zbh6zBuWrESaQmgZOA7rkuDKLK4eARt7TzJSa0uRh4Q4VLhj4L1Zf9J54UtuvjnKM82Eh/JxAlhapx2zoj7OMt2xLosFErM1FfSxBFrKz6SVl2TC89NIGN3eQ66zv+DgeRRBQ6sbloWo5LdQA5PgVXXhZ+5re7MC1gyZcRhKDvrCbOdeq/sbr/xH4cfzRfXPSLTL8E6n4NlJ2Bp6hU5TQPijxC+ZRiq1CzeEP8CR2YcaVSeqDM6d06hk46gcQxYOunuWu0cTZsXj5LF20kTSBzf72ZqkkkozNGYbtm2TIEpo+M6CnuNbyXH2vP5/FjVkrLfVzkbZG2YO4ChWvUGw/9VVD+jJEI7lb5JAosH6s4v/oBuBEidS7ER1BnEHBhIJx35VSgPm05RafOm5hSXE3Th/9i53DAFVl6bekwbDm5AXttjW4qnR6bSpOiKg9HHdhx/cSkJZNlukPoj/ERU4sYZL8OYt2KO9PpQNyHIKPezWJDc+C1KKYGLzf2dCIZ4Mb2Db+NuYCmxXa89mMVwxyvSvuk1v66LoCTZuCZLPR0ZCNDHigokZjfvSNejeag7yVZek+erhj/oWz7IcWN6EGxIhtOR3ojS2CtngM6Vzw2e4eaJy1VbHqqN2tpiK1H+VZho8eVJSEYUicCQk07b4OMsSZII2UIacxUsu74sb+iA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(11063799006)(261021123027099003)(261021121427099003)(56012099006)(261022075727099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lniQoT2z7cgFH1SpqfmAFJYNQIz71sse+7hGRPRi4Ld7yDiHPbQGXplndERe?=
 =?us-ascii?Q?V18lToKz+/+BLPIQdK8JAEscdFy4a+PT4RhZCYZOLscO/fWHQ3C/ES5FuVLL?=
 =?us-ascii?Q?nnLHABmpdc+k3I5/Kcy2QVVCcmd4Y9fGhaZJHcVPys03aC4FTope1iTjPwdD?=
 =?us-ascii?Q?0t2odDYoeJ3Wwh0/LPXe+yulcxEReEq2raM40klTE7Ce898gCjEQdB+Gof/Y?=
 =?us-ascii?Q?5v5DhjBc+N1xX8Gp8T7lgYIYlU4LVIGtAiyCyUic/qZr5nIaLstCLWr8rko1?=
 =?us-ascii?Q?1Pfu6WUxIK4iY+Qf4t7r8yfC1k+h6B6D5sUcGkIMpLm4nj72Ye49OHRd4gJm?=
 =?us-ascii?Q?B/rNgE7rLsXNf/d6DhiRBYcXTdmF9LiaJpzbdCfpcDxaSIzJOXsbOStoObkI?=
 =?us-ascii?Q?/SHyu8gFZs1TwEHGc9j4LLbcFUd8MTwBoPi1mFHZaguia5Uo6Hma3vAK04G7?=
 =?us-ascii?Q?Gh/uSM9bYBfrJ0niqqfl2wLesW44CKNwV398irkaIWRL+DvWz3NzF8Aiynad?=
 =?us-ascii?Q?CmDBtcluTnt57fEAD07+K/MJO+8naLXjSYmq8f3qqw2x4/MZ9J6T7/tP88S7?=
 =?us-ascii?Q?Mqz06M/TB0smI/xrQZrcrNQH9Ddcimj8kp+tGoAkCnNA/iDCUCAHm39uWG0e?=
 =?us-ascii?Q?HFQBWUdLOY4Z6tmgIV+U8tPRRDXZ2STRkT0K3BNm+5n98i93QgI12/i0IoDb?=
 =?us-ascii?Q?t85Puygjoxzzdc4Fwl/tEO6DkD8GvNtDN7SARHyzGP2cpHsSxZ6ssHXr1re1?=
 =?us-ascii?Q?XNhbVzk0iZsViFnCLcrTJTB+4rsZ+Ho/Sf+QULQckf9n88iwwCWvU/R8r5/W?=
 =?us-ascii?Q?neZi+6HngoTk2gm3Y0vE2ec9ivDNWOQmASzj0R0gyj34h3oKrA0tNQher0W0?=
 =?us-ascii?Q?wc0h23zmE8Jy1lH1hYmvv6vJ3jkF3VsX0zjAe4naMyJNLWpwIGkY3rI/gP/k?=
 =?us-ascii?Q?xCUOM/9DPa77k7P8E0alcBvU+eQEwyjTP321Z4m+bXjtgm30edkJPHecIO90?=
 =?us-ascii?Q?CDh3yR4abefci3Fr2sLOqYvBbf7QmOjHUVWY6pWfgzFIuIIBnTvSsUL38Tnu?=
 =?us-ascii?Q?GEiph3R+ygj/Gc5FEamGjSubAU6g1WF8f27YJudQWLABuWQfpmXSedMDh28M?=
 =?us-ascii?Q?KBmBf1N3XDf5lVyy6nRWsy1z1N7iU1sN3YRiK5Sy2BC/J96sCDWjczDdA89j?=
 =?us-ascii?Q?laESNOMkjtoLvNc1lSU08XLOsOztFc4O07gVbdZmq5cjXiRZRzavhknKpq5A?=
 =?us-ascii?Q?EMTVGALZuF6ZGceeuQX/Pn7p4iAdGDjCcDEYr3epJ+f34s92w3QsMQamoiFD?=
 =?us-ascii?Q?yVrkxe+m9vieS/Xhn4HCvDBsY3QIxFM4iESXJwj+xH+7Q6SgF6Mc23rI0B+v?=
 =?us-ascii?Q?yblcnWiqD2Eejd6wqITtl9BmRq9A/hWh6ajwTbT9y6T/MY9wgsYNCwDEuq2P?=
 =?us-ascii?Q?Jkv54jYvQpMzKURfTD+9dPRN83n7mCXYuJ4MDVApYM6ZPpROnzBFPIqoAJyl?=
 =?us-ascii?Q?r/+ssCom0bhRZyOcpy29MQ9AJ8w1b1IVz2yaO6K9t58y2ZQxrF0RhSdTDsTR?=
 =?us-ascii?Q?Ea0ws2IhIPCuSaRfmcsdHOsNRSyUKPBYoRNiadaa2RLRyi9WL53/Mo+lPYEB?=
 =?us-ascii?Q?ei28BsuFpxhURLuWA0W7cbdEo77LLO29aLcsTtxqV6cq94LmMU/Yq1tJP/UQ?=
 =?us-ascii?Q?vAFoB7Ke1A0PrYVU8MQMLMiCydcKz48rj9mWVw26GSoGbnFi2oN76ICKZhCE?=
 =?us-ascii?Q?2QtIN0Svsw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d227f2fe-639c-470d-b1b2-08df3fd0ebee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:51:05.7550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbxwVVcqsTDBDTRUKXiarBGtoZG2hq/m5MuloZreJ3zMfg3htcFpeEUOJL6JGbKuQH5TEhNKKd48d2y0fx45Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7851
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tze Yee Ng <tze.yee.ng@altera.com>

The per-mode PHY and controller configuration arrays are static globals
shared across all SD6HC instances. sdhci_cdns6_phy_adj() read device
tree overrides directly into these tables, so DT-derived values could
leak between controllers, and a missing DT property on one controller
would silently reuse a value programmed for another.

Mark the configuration tables const and copy the selected defaults into
per-call local storage before applying any device tree overrides, so the
shared defaults are never mutated

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- No change since v1.
---
 drivers/mmc/sdhci-cadence6.c | 88 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index ca1086e2359..513101f165a 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -71,7 +71,7 @@ struct sdhci_cdns6_ctrl_cfg {
 	u32 val;
 };
 
-static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
@@ -79,7 +79,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
@@ -87,7 +87,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-sdr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
@@ -95,7 +95,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-ddr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
@@ -103,7 +103,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs200", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
@@ -111,7 +111,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs400", 0x00280004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
@@ -119,42 +119,42 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-ds", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-ds", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-hs", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-sdr", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-ddr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-ddr", 0x11000001, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-ddr", 0x00090001, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs200", 0x00018000, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs200", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs200", 0x00090000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs400", 0x00018000, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs400", 0x11000000, },
@@ -201,65 +201,75 @@ static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode)
 {
-	struct sdhci_cdns6_phy_cfg *sdhci_cdns6_phy_cfgs;
-	struct sdhci_cdns6_ctrl_cfg *sdhci_cdns6_ctrl_cfgs;
+	const struct sdhci_cdns6_phy_cfg *phy_defaults;
+	const struct sdhci_cdns6_ctrl_cfg *ctrl_defaults;
+	struct sdhci_cdns6_phy_cfg phy_cfgs[SDHCI_CDNS6_PHY_CFG_NUM];
+	struct sdhci_cdns6_ctrl_cfg ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_NUM];
 	u32 tmp;
 	int i, ret;
 
 	switch (mode) {
 	case UHS_SDR12:
 	case MMC_LEGACY:
-		sdhci_cdns6_phy_cfgs = sd_ds_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = sd_ds_ctrl_cfgs;
+		phy_defaults = sd_ds_phy_cfgs;
+		ctrl_defaults = sd_ds_ctrl_cfgs;
 		break;
 
 	case SD_HS:
 	case UHS_SDR25:
 	case MMC_HS:
-		sdhci_cdns6_phy_cfgs = sd_hs_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = sd_hs_ctrl_cfgs;
+		phy_defaults = sd_hs_phy_cfgs;
+		ctrl_defaults = sd_hs_ctrl_cfgs;
 		break;
 
 	case UHS_SDR50:
 	case MMC_HS_52:
-		sdhci_cdns6_phy_cfgs = emmc_sdr_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_sdr_ctrl_cfgs;
+		phy_defaults = emmc_sdr_phy_cfgs;
+		ctrl_defaults = emmc_sdr_ctrl_cfgs;
 		break;
 
 	case UHS_DDR50:
 	case MMC_DDR_52:
-		sdhci_cdns6_phy_cfgs = emmc_ddr_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_ddr_ctrl_cfgs;
+		phy_defaults = emmc_ddr_phy_cfgs;
+		ctrl_defaults = emmc_ddr_ctrl_cfgs;
 		break;
 
 	case UHS_SDR104:
 	case MMC_HS_200:
-		sdhci_cdns6_phy_cfgs = emmc_hs200_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_hs200_ctrl_cfgs;
+		phy_defaults = emmc_hs200_phy_cfgs;
+		ctrl_defaults = emmc_hs200_ctrl_cfgs;
 		break;
 
 	case MMC_HS_400:
 	case MMC_HS_400_ES:
-		sdhci_cdns6_phy_cfgs = emmc_hs400_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_hs400_ctrl_cfgs;
+		phy_defaults = emmc_hs400_phy_cfgs;
+		ctrl_defaults = emmc_hs400_ctrl_cfgs;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++)
-		dev_read_u32(dev, sdhci_cdns6_phy_cfgs[i].property, &sdhci_cdns6_phy_cfgs[i].val);
+	/*
+	 * Work on per-call copies so DT overrides never mutate the shared
+	 * const defaults, which would otherwise leak between controllers.
+	 */
+	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++) {
+		phy_cfgs[i] = phy_defaults[i];
+		dev_read_u32(dev, phy_cfgs[i].property, &phy_cfgs[i].val);
+	}
 
-	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++)
-		dev_read_u32(dev, sdhci_cdns6_ctrl_cfgs[i].property, &sdhci_cdns6_ctrl_cfgs[i].val);
+	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++) {
+		ctrl_cfgs[i] = ctrl_defaults[i];
+		dev_read_u32(dev, ctrl_cfgs[i].property, &ctrl_cfgs[i].val);
+	}
 
 	/* Switch On the DLL Reset */
 	sdhci_cdns6_reset_phy_dll(plat, true);
 
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, phy_cfgs[0].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, phy_cfgs[1].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, phy_cfgs[4].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -269,7 +279,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	}
 
 	/* Set PHY DQ TIMING control register */
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[3].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, phy_cfgs[3].val);
 
 	/* Set HRS09 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
@@ -277,20 +287,20 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
 		 SDHCI_CDNS_HRS09_RDDATA_EN |
 		 SDHCI_CDNS_HRS09_RDCMD_EN);
-	tmp |= sdhci_cdns6_ctrl_cfgs[0].val;
+	tmp |= ctrl_cfgs[0].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
 
 	/* Set HRS10 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
 	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
-	tmp |= sdhci_cdns6_ctrl_cfgs[1].val;
+	tmp |= ctrl_cfgs[1].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
 
 	/* Set HRS16 register */
-	writel(sdhci_cdns6_ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
+	writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
 
 	/* Set HRS07 register */
-	writel(sdhci_cdns6_ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
+	writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
 
 	return 0;
 }
-- 
2.43.7

