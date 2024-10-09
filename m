Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC693CF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22160891B3;
	Wed,  9 Oct 2024 12:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="J39wDuOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E59891C5; Wed,  9 Oct 2024 12:51:20 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CED891B8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5BXzDwxZxzRC+5FcKzCGAuxd5a8SpbSI8GsdNiVsmO/YcIMSNrPiXeqN+b4eqb4EFml0ioXwu+ljSlMIaNjgXtsBTPL35mo1oLyCtNjM4jymfcPeKnKK70H4l4xejdmvP04UlcQBPEYrsNaRYzKRYZ/No13HeDTCgaXXIwM6iQ0JOz4yUgIC1mwcBQ9CTgTyT7UfKa6Tv5yiPhj8m8TuueHaCtFiVc0UpfacIAaj7nH+Q9KZvbF97vrlcg368InpyIcLnVVEQ6J3rsDzK1JUZSP9Oje0NPsRViwQujY64B+oE/yMYluEZmGYfzRqLMLcDfIUHopLAO2PG4H6/MYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=It6ADHRgiWziPqhIf6DflLI5lYsG24PDqbV+UeYa0BozPGKwdE32+y1na27++FW0n8IwGjEK9JanpY4NvOv8cI/SuHCzuf3b0NzHUgnul+rUS13ukaGOKVm0hbMaM/SaimkVq7vuCV1kSGwMpaBIfwQpb3t0ik/TSvx8msle3lGObK0FtajwgTdvQxAqDvGAM8Dl305OBLOD5UiomzfqRpi5y0RnD1wuKN9D0UkKlVifkCt3pq8bFjcomxPpJ1RhsKxuxgea3Aa7faLnsgVDo0lV62iEUGDfCd1KIzT3VWmaUXa7H6F5kbxmtboDyIS7226BZh+kwRZPrCvt/OfBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=J39wDuOCwk/1jPCfzyL5JldGW7QHTVuvTT+OAwl8YiU4FCEXUvl4jXFdPDS48cXmQXx679Ph+F4Q53ErjmSQN1x/SlLoxETV1Ik7dYqgBWH5sgpwfbyovSqSm2GQic2H5hAgsP1KC1gaxYpI/Oob0UeHJSsQ+GFoY0k7AX3KPGWPhMPXZhXSEaxTGCrFTbuPQTFnjuOEctcf6iWs7KFiBIzalKf7W5jfc/GGSvVnKccTYKk9346IKrTuTW894otSvPxU60oztoEa0D9js+Q2Pp03O+rtvJC/fWr583d4JKd0FlJDBgOKW+pCUJU/eYPIoUpuJuC5qyuk7WrJr/X0TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10543.eurprd08.prod.outlook.com (2603:10a6:150:15b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Wed,  9 Oct 2024 13:50:50 +0300
Message-ID: <20241009105054.1879054-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e03914-ede7-432f-e5f6-08dce8504c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9qNHPwlz3XxNO0ybv7+MiWQehqvcnpSFWfRMzlXUjRVV+KmOsrS6JS2Bw7KF?=
 =?us-ascii?Q?40jMNnoNxFp+P7lCLtxDBsKE+Xmb50qSbb2qgEaNEG4RJDjsHew3U3pX165a?=
 =?us-ascii?Q?t3mk6iUTJ2asuaovE+Q9nPenMBSgXW9qOJD+kJpHmzShl4p2rclM0cOgb1zh?=
 =?us-ascii?Q?2nJOZi42kVCX23fttj0jnrNy65egjfocQtjb6ZxsStJV//P4lwS4t5hD+m2I?=
 =?us-ascii?Q?OA6RXawxrhB5T4N2N2JBNAVc4/x7GfvkkJSzAhg6O1l2YO8PFPxovtKHdoEz?=
 =?us-ascii?Q?CoTSYBLYJN2jPBjK9fdwJXzUu8xfIUOpgHqBl+A2I+Z8KiEqrIwuZ87kKBK1?=
 =?us-ascii?Q?+Tp0OAMCJCdRZz3Kh4V69V92pz1C/feNT5do1pPs/OSMyL5n8GoOXWq/vnC7?=
 =?us-ascii?Q?i02V41hOb/oX6cmzLdaRpirayZTcoGIlIaCyrc/WY7Q/S+nP3hGhKa/C9FdN?=
 =?us-ascii?Q?GKTsajsWN2MiMArD0eHYh4XV3fBs5t4FlLCmD0vU2z455AfHGeHTeD9KD8NL?=
 =?us-ascii?Q?TBVZ383WtX/CDhur+MJQ3OLYqZ8VdN36uilI6vSuYKjSHxaEHjR/iW7pvTVg?=
 =?us-ascii?Q?6ov4jC1rEMmSfuy2sEiXtOt+WIWyUcGgF7cRXxoGEf/GAJiZMpAx2iAwdsnw?=
 =?us-ascii?Q?uydrCsV7v09yEDfajIZrY4UR1Wl/vCrnw3fO9Z2XjpMJ/viGTGYIbMmJcKj+?=
 =?us-ascii?Q?8effbNreKp2oHqq+C7qbp/mgQNW3u4A7+BDv1RqPLvpruCgAY3fETOeStPvB?=
 =?us-ascii?Q?8ox6eXACc3S1xY6oPPbr0aPTST/syDy334NEf2505gWeJKRR9PsCUXnlZn4P?=
 =?us-ascii?Q?Sp2SOTYqmxmee0o0Wr9r/pkc7CnPPmw6BlAcfjdFl6o77cOPOjyjV7B5mZeP?=
 =?us-ascii?Q?6kEMMnclr0qp4/z+LMGU1kdTUk2ug8Q15IQa5kolJCzdgv3b5YoGd0kG9pHT?=
 =?us-ascii?Q?8JHCGiQjWWsDV83nhEg3GM2GgeNtGoHGLKiukAjqVDDO0RrFtkC0NQcxtOm0?=
 =?us-ascii?Q?CysRNHjDGP5dUtkiysl10Wcxb2c0dYDkSDCbabxlLhuxICOIqRbYroMvhNAX?=
 =?us-ascii?Q?XI22iktCCeHjwWHO2Mc+rjeNkuqyxlYJWuhsZX2yA5tGsgp241j4GqJ716vv?=
 =?us-ascii?Q?cD5TtajPVyavJBQRcA/Z9IvjpyeCMnQoojS0/ngB8z3+twrHIz2r4xUC/HK6?=
 =?us-ascii?Q?8YzTkOzFLymERlNhGWXb0YTsAO9eIS6wEedt4oDEW38GzdycW/gVUFQbs04I?=
 =?us-ascii?Q?I/ietJdf/brCO1uArDkZ/VGhQUDJatRup0aIb+Kt7daSRFrKg+UqBNz3urGE?=
 =?us-ascii?Q?hACJfVX53R337/wCdpP+yL33blmGznbwbqsn+Ix60eoFOWR4aHJ0rIU9wDox?=
 =?us-ascii?Q?qEE6mR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8SClCH0kEH0XVt78MOXXsMkN/KcdtqO5Kd6lLUU3TNZnFJvZY7JGKTcMxFQ?=
 =?us-ascii?Q?DOImeGXq2inAy35VHZwx+4arex9oXCWTBXK8Aur3sgO4qdttpHNbb8Ud1wtb?=
 =?us-ascii?Q?VSrulqVcWHDIeNyv1hZ2tA+TqAPSs9VG0Kj2o/wAxOg7gV3QhfWvJ3xCqwEe?=
 =?us-ascii?Q?5WFSHTW2K71/d9nS9HyIbHpG6VLG2H2HPgeVyfexxnVefkAvPEghOX2nHHWA?=
 =?us-ascii?Q?/+P9SH+sibBFwAogm1hOMf+ccmD52icjphTMB7PAjSd2mpqLZmqOYR6GqTBF?=
 =?us-ascii?Q?B1qbYFsq03PLFuq3T1LQfT5MGb249gQV80s2OkdmKmWK0tBXOR17kMId0aaC?=
 =?us-ascii?Q?VktawMPzBc5c2zYEkgOlON54JFvIsKApjTP4SSou0fecmNhbW8qFQJP1QJtk?=
 =?us-ascii?Q?KND0WI108yg+LzA3BKkjQ8CQe2DDdMFCsimCHfkWJfUjbp2LIlElXIzb8NbM?=
 =?us-ascii?Q?52+8mI6LIvKs6/cOf43zrcVas3+pqZ8+Db9yYO+KN27yqYs3kC4CNu83FuL2?=
 =?us-ascii?Q?xwQKOScAd7sU7MB2pwOyeMv6VFQUeubgMeQSyhuqIZXSpwFCju9adGjR7JX2?=
 =?us-ascii?Q?No2w+Gyl/73884m3Zh980rqE0GGdtBtrbmxkR/n7eWdU98Njjt8Gs4xwl5E2?=
 =?us-ascii?Q?vpIwTqYnN0lp78+n+xc9KTDczS82fHEzkS/hRkaL5DltnO7HybnBuVc3WZuH?=
 =?us-ascii?Q?uYG1PL279m4pyKXD0UzwpFCdcnIr5unLi4/xfxxALwMZDFqZIFV++WIrXpOf?=
 =?us-ascii?Q?raSdoazoFU1eXGJRA1QNcG82d1oNctOS+vfLw/5Rb5Rl5E5fiCoqYfftv546?=
 =?us-ascii?Q?7SB+UT6zV6L3r4i5Y3IYfrqK4k/+FPkVUIK6fMdQCKYMe9NKB6UeCjBUX/or?=
 =?us-ascii?Q?epEqI2pvdvTpyPmr75egOurO8FoHBH8e9h4Zl1RccBlpjpfftLzwIbwVhLwL?=
 =?us-ascii?Q?wZhM4Gmg2AtnndGzEXvn3MXXgD/SJ1Ks0irZkcXaMXzknd0BcggHKMel6aex?=
 =?us-ascii?Q?7YZ665sOg3DvnfLyAuMKQhS+S09NLCO6WbIO7725LLjlUJa2SbYZNe9erWLd?=
 =?us-ascii?Q?UgzuXd7WyM9FID5CUtG+9N6jT7YcLmP41Awrz68Jpn03PQ11POMGbw/l7Vb8?=
 =?us-ascii?Q?lqCv5GOvrhONH6jcMidBWii9RnIW5eDWMghFVZhGFZca/2+DfgQHGVFUU/JV?=
 =?us-ascii?Q?iE4wjqcP6onZ8ELXA1w/UTkWmsh5f9ECVfJax6OgekLePjrkqcXePIK8CXOs?=
 =?us-ascii?Q?dJh//nEAFgRdmUaT9/NYQQILz2uZY4CNqc/fWZ3qtUh1VfNex0maDH+dCjdA?=
 =?us-ascii?Q?bHiTSmdYBIwPhn4QtAp+A6doQ6Ylx7uflKcFrwxINOoOnxyEkJJBM1f4X/27?=
 =?us-ascii?Q?UEeFa/DJUP3mWCYaGW/WZkjuw5zGrbQG34rzvqtVmaBAT9k382J9HXECWJ8n?=
 =?us-ascii?Q?ryQOAfS8PVVqdMJSZfkR3WYgIt/IswpDZoFDXC4IrMQ7PEKI+eqVPMT2l+X1?=
 =?us-ascii?Q?dqSlcpn8SfmtXaaCbqr8H/3YvFZZzGFLlTC/GOf8VxUKk0fqon+6plZo4fbK?=
 =?us-ascii?Q?OwvFU52rjXSnCf4cQ+BFGejGXOe+EM/AA3fW8aQcJzLpbRmWljeFyvqLfJnt?=
 =?us-ascii?Q?OiZna3qo3FPFRLy5JHpgFmo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e03914-ede7-432f-e5f6-08dce8504c8e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:16.0793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRFQGio5+UxAl4CVspJArBzwgYO8mZwxpfc+qsg6r5dGvQfbltmBpcCze6luSIVUJ7kgYVEXvZ5ypy0BCoqrpiwG4jaXGASDP95Fiqas3rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10543
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2a95c44b141..b950d2b7727 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

