Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F70C04FF8
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1D88855E;
	Tue, 23 Apr 2024 11:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="oKpnCVSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6F288503; Tue, 23 Apr 2024 11:14:45 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BDE88503
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhSuEzTSjpyhO9sF2BzjWKg6jLsh+4rdY5R04i8UTp2Crkk6xJbsKJ+9sV0Tq7u+Nq63X7HL8yWfqDCUULT3D1uthtVq4Gzw+INtaF4TKK7p5mPrWTn3lQDZpHnDRoZqXxnezmG4E28vFKzdA12HIAImPXZkhHu+zNAtOiAYxsbdTK46SjYKar8XyQZAH8cLVOe2Mlx1rMoDAXkR3l90aHaTuwNjZAMuqcLRjzueb8oN5k12iLTeS8+Nwmh+ioYK4eyMZ4tU1E5cgPKAvpswpjbTVRHr52mtNymFBoczhzIqh3k4nsLxuDpHtmiCfJ+WVMHfMLZu5xQ1wdFZ1x6CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOpy2spmjo7ma8K23+m4PzOocFjWSNFTbgnygWDK1fM=;
 b=el6B2v4gxxaUyE9vls0/aPjBaCAKmZHgFrZK4mMvTT//rga/KbBTsH8scmz91UszFZXyYIvd5sGo3hY8ww00g3fmX86iAbQv85MXqpocFJr09TC8CtX8mQNjQJoIRdBvBMzeCfQTxSsiyUpsJMpdbEB1u7aP5Oa8UhGBnW2DH20+m7wzxiARMRFXdzCVlfk76DeTCwsh+SQ25fH3RYBkLaHTfKabtEo3xMrLaFRKmqtV7rZ2BoKMskAT7hH9AL4jdTdxjcSbNtK3P1MvzsSHwUI3JDhwQ4cDlIoNcLrTDAjkXJ4zvK7ZRRzYtdlFSk7OURjoQL9oI1tbGyLAI1IuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOpy2spmjo7ma8K23+m4PzOocFjWSNFTbgnygWDK1fM=;
 b=oKpnCVSFp4trWtolepsUxgE3VC++CY0xULpDfgOstw60Rhe51jIPzFBGCJGiBMVgg0Lcq8m1KBIobEuSP2vk7mxqbTQlYoFzIg+mc9u1t6l13vwud2mXaGnkpM/P1bhWrkp7ZTO6+w1RHxw/RfGuXm0MTzVot2X6WYbgEAphDuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB4PR08MB8174.eurprd08.prod.outlook.com (2603:10a6:10:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:14:39 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:14:39 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v2 3/3] board: starfive: Call spl_dram_init() for DRAM
 initialization
Date: Tue, 23 Apr 2024 11:14:29 +0200
Message-Id: <20240423091429.178653-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
References: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB4PR08MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 356ffb5b-38b7-4fb0-c47a-08dc6375cd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BU2Jj7GiZjLQwaWX8QVwikMNPagGo2BjBGd2SUq0V14v0iXXnJQFYI57qeXY?=
 =?us-ascii?Q?KnHs20RqJQMJow2/Ra8nOdfPggtnvIX9B/lAJwxinp78X/Pxj82kYmuG05BA?=
 =?us-ascii?Q?mKLRD0RiOeJDQnnGWoexxFs6DcU8aYy6yletptEBGy0uNGPRfKdI15cprfbd?=
 =?us-ascii?Q?+Mb7MuD6CfTlcYBPU+weDQQMQHVMEbfbJdRNNZoZ8gNnNPGKaXW18nvqv2Bi?=
 =?us-ascii?Q?ihwMC2/Uu3G05e6YWHROA8wxRhS/TSSyqvgV0Bfs4AfKTHxkGgvGErEEzteo?=
 =?us-ascii?Q?35I163RX0CsIvdhSb7tC6WMqr0LFLKwsnUacYHFk+vXKdUCY+1d3KHS05QEQ?=
 =?us-ascii?Q?dR9MO6V5WnsSS9TAiGM8rDoanJ98O9X/eWjurwyCfdgBQuncoQ8bGTVx0HmQ?=
 =?us-ascii?Q?aZWTGSDsvatroOIGA9XIsYgv9wsyVsmVTpzWGgx6MepI7M1Gv+QwUsrrVo9a?=
 =?us-ascii?Q?sb6ogGANaEVCcmemRLSllQ4ge9a0tS4nF/kQNyjdlOoMFcpKHYCPJVSuX8cU?=
 =?us-ascii?Q?WuI7oniFeUdAd3PXBtJdP2K8ZfbX/eBlddC0q/VvGhHFCSGFU9kWTLTp1xPY?=
 =?us-ascii?Q?Nuzy7tXxCXnrROL5Y5FykcKgJthGTa/if3HhIHDhxTDYHQuhHU/5B3kahsBV?=
 =?us-ascii?Q?nXrv+hJbwOBPalPTDJG6GCAYM5hBkZPS3EQOtJzNFpJVX0OeZzcuRt3UYWXk?=
 =?us-ascii?Q?voqSHszcMa1NQUgALJg2onVADvSm7c9GR4qCk8MhBOZsxj9H67mIyzBTRIdh?=
 =?us-ascii?Q?jPyo1SnIp2LggSiRgDP+89rtS0Mr3O3ynd1KvX7c9Y1IFMNAcXlNo5ednpxe?=
 =?us-ascii?Q?cBz3FaVXU10YHQYinsvAh2g88y/sWCNeobjFmBU3dVd0VBRW86B0Y3ASN/of?=
 =?us-ascii?Q?E2YVPz5LslzCy3scx/P/Q1a4n0FNQk/JgJuFgBzNebhLdOt0GSQ0/fkG+ql6?=
 =?us-ascii?Q?TALRBaUyzhQggI2tPaTrOUPB71l4tzHUk8/Huqrm4G0j+6zaJiP/kraY/Rd6?=
 =?us-ascii?Q?L+Ulqco/Aqzlwmwd8vm/wRX8ty22UILynGYT2UT2EY14AudtK4AXVW4i+t+I?=
 =?us-ascii?Q?OkxYiFVPrBKOjxTgGoJRUlsgvpVvy6N6yJznE6L/tz4XABpwmHtXgEUa/+9r?=
 =?us-ascii?Q?++Ji/GB/6p1yW8nqiGr75YUyg5Iz0wf9WrR/Ig55Uu+XITgSJq+x95DGvK7X?=
 =?us-ascii?Q?zFC1uKau2F0s1loRZunBjdzhnFQ/q/dVEZt7eNpLKMiGrkB5vcvNsxoJmF/s?=
 =?us-ascii?Q?V9257UHDX8xHPSNxbrE/HmZPps9D31XWwqPl6tlXIXFFvaVg9gFybxP2cFog?=
 =?us-ascii?Q?QMybk6shU9+hx7LZQvjvoJ8Wtc8w0c0ClW+vPEvAYuUBVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3AhffOLoltjfGd+JMkmqtrd+8zGi5bZ7HMBCn3eOyZhjRWgakwiSTAJi35dW?=
 =?us-ascii?Q?5GD/8YGk1vyyYbpZdx17xLlcson6NSuODxGtvlntgT96cUnf7BgaJmNexJ1A?=
 =?us-ascii?Q?9L0D9YwPkBPNXD5yzZNX+gkzMC8z4AKgX9WcCr2IxjWTbWxcf5VTLOFs9fZT?=
 =?us-ascii?Q?ajwufIqcOZ3883R6Bc5rp0HmhSpAt1NYE6MfelIsv8WdiXxA1Mal8oCvih0d?=
 =?us-ascii?Q?IFJyW8BVfg34m62vaVFqYnNbeNwHSjpS9qhpKfwfNILu7YONY5vomT+hmldc?=
 =?us-ascii?Q?N90J6JBwu4Y4nlxAEuR8t6sxzP9I5rkzVkPYwGt+E4yXnDQVafFpUglAmebQ?=
 =?us-ascii?Q?268bjmR2+Pg3lFT1BQmXe4gFnYORhOd1k6QB7dYnhIxYcYsczUldMUTnmUUM?=
 =?us-ascii?Q?NOw9xNS8kS1Ixcgl+Xxa31UUAYuyslkucv3S9gGxrjj+XEIWHRinp0e/sU84?=
 =?us-ascii?Q?A/HiGyGNU/7Zizej3I/Bl7pRr0c6nqTcuWmV+MKi1D7eUw8QHIPyX5y9BPyr?=
 =?us-ascii?Q?gihJ3G5j84ONMO/gdA7ylNMguDSUN5bEaDcFuvP+ZiTo3aPKdIMEOnbsPeef?=
 =?us-ascii?Q?KqGvYHihJ9YsXapgdl7S3m051RqhDI7ASQNbw14+SnauQ3dQVRU73Xh4FhFY?=
 =?us-ascii?Q?+kKj9rXVpv2fUuXGOAFL6RVN8KxYByQV1cLOeNEXUFG3WHvHeSQUSLUeMYvn?=
 =?us-ascii?Q?l3v0LZqipVf70uJ+MnNCf48+9mpWg2Gdvd1EwanKZcbnVWHDuVZ7yNn0lweU?=
 =?us-ascii?Q?dmTiJmnLuSkb2JaWEagfNJD450w28DDr44jkjtx0LIJ36A00c3ymWHMTFfOP?=
 =?us-ascii?Q?xmmWzpt/gFrrlTXTJhpajX/clBTvpzrUaoFffNBk5e2eeA7HtYBQh6EFA2vR?=
 =?us-ascii?Q?TXN7DmYZ9MsQGJJGvIGkVvutf4h7zNVFt3vpr9h/5HckRGQQvNesisWXbqFV?=
 =?us-ascii?Q?ffadmW/BsJUnkdCo98ukPssVxVty0vLwbHaTWpHzWhDgoMY7MixVOWMB9gK7?=
 =?us-ascii?Q?2zJMcAq/m05kg7iW6V8INlGRtW7dOd/QuIFOMDe7YHK1RBkUe8ueKuEyZHpI?=
 =?us-ascii?Q?Rj0tFwKLL37OtWqaGb+VOeJYr5YlQtVHRhJr3p2WhkESwFuJx8dV6/HeZk17?=
 =?us-ascii?Q?ZYTFptRNIjzSF11wA6mT4W2TBMQAVxpXMM9xExdGacidil/eHZiHCkx9eCnJ?=
 =?us-ascii?Q?RXG8GGbU9h7IzJKpqbH3qJafFHGA/w7MkZggnXL0avidEok3jcvCGLxjsdLN?=
 =?us-ascii?Q?uLchSFIN1h7aoWy61q0sYrk4IZpnVIzRR9+2l0rx8bClKjQa2lhpxn9ThMst?=
 =?us-ascii?Q?F/dGm+MMC3tO/kRamn/pi5FeUh5OcCsZhW6ux9tGe1xPGhHQ7PjUlaiOx/k6?=
 =?us-ascii?Q?OER8t7nwz4U4CXNL9gdFeT3W4uJ0fsj7P2wjW9eieOI3suCl5nMQlP4JOCgv?=
 =?us-ascii?Q?YxcrP/OMlPgIFDzRkx1buaZ0ezzuIUpsjXU1aLfzfiUmZpO3L0LEJo8izhVu?=
 =?us-ascii?Q?GssbZglW/wYsIWa3Ld27Yft0GMmfNjJxJeV/jtzTZgd8RwnrBekTfS7Jwwa3?=
 =?us-ascii?Q?i8cu4JmJB1k5Ly7dMfFmkS380JJVXtgj7piEhsAH9XmW3EDvO1OoqYGfwDbO?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356ffb5b-38b7-4fb0-c47a-08dc6375cd26
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:14:38.4920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss59lrOVwoCN+LR1knQUacY79xZkuhZ6yb8hn9ha6H56xVQEU6mtRAzA7LMGvEI4IveyhTcZ6JKviOSbNQocbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8174
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Call spl_dram_init() since this is commonly used for dram initialization
in u-boot.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v2:
 - capitalized acronym DRAM

 board/starfive/visionfive2/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 45848db6d8..ca61b5be22 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -285,9 +285,9 @@ int spl_board_init_f(void)
 
 	jh7110_jtag_init();
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("JH7110 SPL init failed: %d\n", ret);
+		debug("JH7110 DRAM init failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.30.2

