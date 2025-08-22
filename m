Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EFECA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF70280548;
	Fri, 22 Aug 2025 20:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Bf98Ys1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941AF82B20; Fri, 22 Aug 2025 20:20:45 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B048006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo9mBZbT/+Wrcj5MvpWqP6qmLlCfki38dnk15aBOGUs0b4a9d1PuB7YxlJWkc4a/v1K7HndamUqC4CBurVbumZegHNexqLta/AtzR3COeOLKSNAByMlLxHgxA6tbvDiXxZUSCrWKi6ogAXzKaX/wkuGao9bOpoCj8hiI0+xKXXvtteWvxM2Kp8x7TnMyS9sPnKOk61xPocWuy2AdvvSjTfSw03TdTcY5SGkdx4h5E8UeDnSb59vhe60I6KmFtAEyRpA3I2f9/Octo+syD1kGw9MGsWdyLBDVfdC5xTx6zGEQu0L4Jwzk9UPcLssXoO8byaD/AAvFh5vQxZzbURHJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX0dhi5n0d/xvBmq6owMR/jTWIB35x73IITMlzefhRI=;
 b=JBFxyNdhFv/KZcwV6EbK/ifYiIERnlGk0bXGy1l9XUnwWJHEV6cBCB1FSP2fp9j1zj2OzpkYtysfUpbRdE1ZYPqH/BGpcNTaLZ83VW5bcDwibuOqOZWyUNZtiRYaHA+0prJjf6WWspW0hcI4P/ikoRp6ISfzHelDtzMNVcX1GKcbBjg1QZwQ/szeEDEzW16FJJWSrp89Ng8+hSJCxw8Ve2isUpcbpiJiwDKEdW8SISYtptQeB7bCvbH860SmSb6nTn5BoIvqymLGRaEUyVh2XGetZYVewJP9aJDgS0HzX//pOf2fRhqViW7Nsoa+0vUxLhEpfVUQ5DyDVe5ne+LBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX0dhi5n0d/xvBmq6owMR/jTWIB35x73IITMlzefhRI=;
 b=Bf98Ys1SSoOnmIPDQCayROcJsfJWKU3oQ+e2j4U0hExIHJt/5IJXP+fE+enw6O4oFZIZjittXAVUIC8Q8NokY+zO6XF6iYVdfnCxGGqGCjw6W61ZUrazS7TgB2ImchE/tk++7ullGb4c3zkT5yIO4xPEt+nC4cmCJGLpYljBrdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:20:39 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:20:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] memtest performance improvements
Date: Fri, 22 Aug 2025 20:18:45 +0200
Message-ID: <20250822181848.3325832-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: c3030e04-91f7-4f6c-be44-08dde1a89594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JBOMm9n+wjiWTiNKuWqnHSamPdRkw+n2wqWA9kdsqKb3LCSUIyDZNWFPdG73?=
 =?us-ascii?Q?c4RIPyBsNVAMewkdQhm9pfV4REypz9jCj/ReLnSwWvyMb7DHS2mTXQ93Y3DB?=
 =?us-ascii?Q?LECJW826yHffU/t2+zNxF85X1yz8yyOElpRgwXYvz1k9TsmVtWs6L2izNf/i?=
 =?us-ascii?Q?6cIfH0ZbGLaIYeCvmDmw3OJYrVBvfH/L4Mv+0iFGfjHswQPJjUQ5f+8bowhs?=
 =?us-ascii?Q?Rz7DJ4sMCzPI0QEUav1dCC2B49LJv0IE+wsyDeOgGYJM4klY/yZTklkgjH67?=
 =?us-ascii?Q?a2z88tvSzEfVkGZOrVstSAnxR5p55O+UZPkjux+TVPyjM/IBlr15TxG0bOpa?=
 =?us-ascii?Q?QgV8jMWTbRCKBkoeN9ObHHAPi4heZ+G3gho8XwtW1geTkJZB62XmDOMkNus2?=
 =?us-ascii?Q?mTxY/pKkHnio1kPXZpoQbr4rLh9Ba4G4KDIw/ktIOCYIFz8jaTFKky1aOVzj?=
 =?us-ascii?Q?IUNVvEnqxioxBzrOPLH/T2SUD8Y+gnm9NXyeER5YGvJZwIxe3J1pczfZNqPU?=
 =?us-ascii?Q?+3FuxNHp1adH9BttscYtsZRVqENHUn30e0jXjU/EdEUPhcZ9kV8PXZ76moLP?=
 =?us-ascii?Q?k5pdTGQA0Xp2FzZnaPKbB/obQe+Gw78gYU64+yMrUw0MOzAEEXUqWrvYezmB?=
 =?us-ascii?Q?v8/MI8xhnMoomxnvAOHF8nS2I3ffv8n0GFRbpj6TJTJJ0i2HXNQ5H6Fn314w?=
 =?us-ascii?Q?sX0/NIoZJHFAEuNReELjMxlxf1SGPg/W0Cgp+VXM9l1+wweHDJr03aL4KGNg?=
 =?us-ascii?Q?dJH3dqcDHeK/1XgdFXhJSyG3ctdoIWw7WmwStNRgvyR6DfTYqO6WswlQUWe1?=
 =?us-ascii?Q?iVhKdFLMPqrrEYzAT7SsD9VbV5+TjzFQBmZ1oh5RYizP7wis04+zw//3evYj?=
 =?us-ascii?Q?YGmYnvlDhUrxLS3XWtl5yIwLd93h7rsIXGldUH7m/fqCb/Kgn+COTlGLZe8I?=
 =?us-ascii?Q?Y5+IT2wipEOJMfdvEwTYDR3yXBeE8xlegsayqWczSRQAdkWkAq2i+Hwam20p?=
 =?us-ascii?Q?RWfoxqcfzMfW6TBcsZHeSdDfyXIY4qJr+lCRfAgYn/v8Aq3RvfRkbSVC0TjD?=
 =?us-ascii?Q?rxw6E4LWG3BygufkTIh1cxc2qwuuTzTf9q5I3CR/BSpudJb+0+t+iZb6R2vE?=
 =?us-ascii?Q?BdpSzMlw+tUcW9MOWw4ejLeZeRiIBcj7kvqLck6wIk9P8NRbp5QHRffPP8Yu?=
 =?us-ascii?Q?tsPbSEs1JIPZQjAMQ7TXP089Rqdd09mlT1wOI0cBvZB5GPipszs8/ZNfQ8w6?=
 =?us-ascii?Q?3Z9XimhW3CM62SL7u+PFwCGfPqiQ8+YYwaVCnKfMc66lMqs4YrJ5mhKbnkR9?=
 =?us-ascii?Q?JKccbBLUWB5gEjaFIfBYSPzEWdOMAJWMpzj+a62W1pk8wnb7V+R0b1B8aPq7?=
 =?us-ascii?Q?Zu/Ph+k3KRjNZ4MjwjCMHkIJ/J4gdtvgWbVHjqdGX2IlawNyKAu0+zfVtpIt?=
 =?us-ascii?Q?Pgqc+R+VCtySOz1UETApSZLHF0OrNx+DkvguBNHG3/hmTfewgex1RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pf2/4NWqC6fDzJj9oS5TLx/HUKG8nLqNuwxNWCOY78oPOkjoOXruNDyyBKS?=
 =?us-ascii?Q?0l+XRBPyWn/1cYMzeX08RgevBqMTKSIQmS35J/U4mOPHauAIw5hNqoxZcRzL?=
 =?us-ascii?Q?Q9DQe4bI8yCoPzmP+FGVpqGFYl24C48aoEeKX/9slrwPZtIS1y55y4tR0ACg?=
 =?us-ascii?Q?ofORz19Kx596UuEp7GehMNr+UKT3igzIP28pgp9HOeNPqdnzL5h0bKuIHXf6?=
 =?us-ascii?Q?QqliKHUh3t32ege8kikvzdbwppN0LkmW7/4d9/pPeyGDp4ZzDWlT9ai1Y6xI?=
 =?us-ascii?Q?x2PuOwzJPJkWJzVN1LcjMundeT3a9pFuz3pYtwQJYwDRtk3CBz9eGj82UaCi?=
 =?us-ascii?Q?hmV4pujMgNWCMpjFPTVSsoEsSY1aUoQ1+iqYTk7t+UgMaMlwcmf0E2jyg62w?=
 =?us-ascii?Q?5q/2He7/3VEjUeJP/3ymDl84tIBcba1xBFEBTCN/tlhAa+dtaM03q6KfucSw?=
 =?us-ascii?Q?lztuIxq0ZNXnQ3Q+4zRg0aD7YXk1xrdowd+6lRtdtxuCMiy9etA4JxkkDx9H?=
 =?us-ascii?Q?B3fzX2CJH6cs1zis47z7xqEzkZIk0cTWp43jWbI7Yk8JNS7W780UBy4zSfT0?=
 =?us-ascii?Q?DFZPgFA73T/Jeb1cskcmu9xf0fs0cmeGrseP05uX7wGCluh7xvTkybt7iZ/l?=
 =?us-ascii?Q?iXyj8QqnBEF+pNQTIzvY5r36gaV0VbDrV/yykOhyL4B/wjMTQswxerZUqHle?=
 =?us-ascii?Q?B+5WyeMqyKa6olK4krUV10/ybujdZymcdieRHVIh3Mh8HQ5PAkhsCjkA7l+s?=
 =?us-ascii?Q?xX+UBMIjufJqBr5M24whs7IXKRUa+SQWzBp5R9PH/yPGrpD3CJfMX2vweRxz?=
 =?us-ascii?Q?h/idld57ShDUeI7R79qMA9E4i1/Te4X4lQVmVMJZc9s0Rj6DupJRVDtP93Dh?=
 =?us-ascii?Q?XLu5R5X+UjLPCsAP4zXEPhZIvcdCnuo7fM6vVCql67Kuznyp4tl9UfZ9ld0O?=
 =?us-ascii?Q?VoqmKCZHUwHuQzqLOg4dku70kYMwPvwA2niq4/KFcA72/1D/vZJRwLqSvA6N?=
 =?us-ascii?Q?dcqrkGjbDGIuXFYJIlOuShx+lXN0A6wQQoX+FReVXUIakgHnJMt65yAqLNKo?=
 =?us-ascii?Q?fAoFVlYShhE110yTZwJ1CZLS06IQyhUAwhCSlGZYKU7t+e6rRnwSmCamg8lb?=
 =?us-ascii?Q?8C/82NkzyfR1xVwhTO+WkBTgSPef8PwpLZSaDXguE7i9RU6WLNf0q4MDfGRf?=
 =?us-ascii?Q?A7ArEg1c65jC+mJGyD447d8HXH4lvQ9IyKW6wBWsBlzhRQe4ZChrxdwcr6Vz?=
 =?us-ascii?Q?Nt4lpvyx863u4NxIUryW5F/7Os1PlKd8zeKKLDNcPeyEobSjhhdXJ4dtGeUu?=
 =?us-ascii?Q?BNMxqF+AehUKPwymWZMiVzIMIehSQKkij2/Tg8pi+O6fXKsZVhM6qilJVsY1?=
 =?us-ascii?Q?YsqSVsLB2hs3TnHVWYm/eCQP/pg9phARklFRNRv+OHrOS8wCb4Uqnv1oWDxN?=
 =?us-ascii?Q?PO4mOhTJXok62MxOdjzv0OhPdY51vDhmGEqdehWSmSKZk2mYuSA9Ryvfw6Rp?=
 =?us-ascii?Q?6j+zFDzrkFItXNuJxuhaCq9hik1pRCvjUoEUylGtWhS9S15Gub8X0ahod9v5?=
 =?us-ascii?Q?lp1az90jS8mIjj11Qs4MxmNGJ/64zcpw9ZQqSddAgJwF2SicPRogR+sgNmpm?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c3030e04-91f7-4f6c-be44-08dde1a89594
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:20:33.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guQR7CteKXSedKfBGx1XzdZh88xxZ7ncYwefXCGrbrLmWGQsz/DdlAOIciH9mt13J6TYuvCUmNLgbgdczoJTWs0igFA0bE7mdy/853PXWXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3742
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

The first two patches make memtest run ~40x faster (when, as it should
be, dcache is disabled), with the second patch being responsible for
most of that. At least on the beagleboneblack which I used for
testing; other boards and configurations will likely see different
numbers.

This is for CONFIG_SYS_ALT_MEMTEST=y and
CONFIG_SYS_ALT_MEMTEST_BITFLIP=n; one could probably get a similar
improvement in the bitflip case since that also has a schedule() call
in the inner loop.

Rasmus Villemoes (3):
  memtest: don't volatile-qualify local variables
  memtest: only call schedule() once for every 256 words
  memtest: remove use of vu_long typedef in mem_test_alt

 cmd/mem.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

-- 
2.50.1

