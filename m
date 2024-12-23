Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F298E77188
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 02:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B10D80642;
	Mon, 23 Dec 2024 03:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D1F80655; Mon, 23 Dec 2024 03:41:48 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805CB80107
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 03:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2087f0b740=meng.li@windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2Zc4X001318;
 Sun, 22 Dec 2024 18:41:40 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43nsub16y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Dec 2024 18:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPhz8ZnBlBPvn8JldH/9gcoAoa1vmcGujvqqDYTjZgg/RmkOPDgz5XwHAPjU/8mRCrv5L5E17viYk5n7RbOMKZuZKEd0/PNOqAGEd7V50L1xl7nzXmAXqh4SIKD1a3MHVmEfPT+/1Qq65zvpuWCP13DJ3dr3Dbxwq6QwCeaHdNOlXhgOutTugs8iXfH+Uj97EBiBy2O9lfQIOS84DvQEIt4b3ak7PU8+WoGuCFMO2azZd37evVlCBvYr+AiVP6s4s7f3TR4LHxkHZhmQxU39VjoShfaNzWTiw1TjML3I1YpuZfzsniHbx+2U88FKvTjIDE+q0kHZxP2nqiDkExw7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/EJDzQSwAuSUFXLO3aI1H8zeTzQlY3KfSIH77seOvU=;
 b=hYdwYLZhlO0TkXRPWcVeKqL6YjD0razy3cQXHtVKo1/rEbMcmU1qLvZUHa2MmXtBH6v5owRXvwSG7FFnkHWD9YaqgVrpnHjUvJ2XNnoFd6xi5Jtc79zwZBXyEEcQJUWr4mSN9+t58DtuT1AM5JC2momDxF4vgbvsjSRN9H2Q980YBAjt23EGqtoIb2h4uFs9IVm+GpGfUEou9vZTL+0ct2BREn2y+aurRjvHVSrseE2SSgLU61wNGI3SjH8W9WFehyk0KO79TUNJY4w0OBdI9xM28J13B+GMk9QTnpl8G4C0w92xIdxzjlaQ5yXc+NIxI2/frF+tJuIoKDPsYWXLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 02:41:33 +0000
Received: from CH3PR11MB8773.namprd11.prod.outlook.com
 ([fe80::c241:6bd2:b212:f4b2]) by CH3PR11MB8773.namprd11.prod.outlook.com
 ([fe80::c241:6bd2:b212:f4b2%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 02:41:33 +0000
From: Meng Li <Meng.Li@windriver.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 festevam@gmail.com
Cc: meng.li@windriver.com
Subject: [v2 PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC network
 driver
Date: Mon, 23 Dec 2024 10:41:04 +0800
Message-Id: <20241223024104.1425680-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To CH3PR11MB8773.namprd11.prod.outlook.com
 (2603:10b6:610:1cb::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8773:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: b68ed444-130e-4a74-fabe-08dd22fb4fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZRaYK/ApWuLTe/6eyLQ/PsTRrAnCfrPSY27tXLexpyBxLV0uF1LRz3Ef09G?=
 =?us-ascii?Q?lNsLpKjNyBVLgOkCNSS2hmMIic7pm0NjqDwTm0ZZlwm6rAI9B2DirLB2qPjS?=
 =?us-ascii?Q?d1r3RHLEMiU52K2ps9jxYKv8DAUeIpaRxZ0wjfAN7Jul8EkKi2EJvCkodcOl?=
 =?us-ascii?Q?ITlSln5L2sweKKOzDKE2dzdcwWwSrb+bkWi5X9mhu+DyDzfSz+G+nV0TXdTI?=
 =?us-ascii?Q?0K2BvyF74TOxHNaT6C6bO5pkNlxeG6F1O55GMMRDqOFKkncMY9o4pNmOPSl+?=
 =?us-ascii?Q?/VPH8vkSAE3sG6apAWZaFKIUgkpRinS8NOZ79elg46MTmA7dqhJW94s923T2?=
 =?us-ascii?Q?CTxeuUrm8jkhusH33bvNCJ0qKZ03aw3EjbPad6B4D9C8Jb6lIWxitUP3x/xT?=
 =?us-ascii?Q?jZ05XUUSDefT3gjCvbl6idi/MRXyP3Ai2VF9dBz66gmzyYPYXaY/rTvQ1oJj?=
 =?us-ascii?Q?ObIz1wGwVLHdCVQ2LDNNnwnvXPTxFbhcfcsQ/aVN5DbHC/ZBVOdr7MY4HmHF?=
 =?us-ascii?Q?eW+nMiI+l7GdQmyBMouxMRU+eM1nNn2Q3GXLZh0l5dk1uYQv17ToCMXeZaaH?=
 =?us-ascii?Q?E6wfbE3FPqOUoAQxn/6bEEj5bX0kNWa/TsWkVc+AuLHTLuGDbl+oE51mfZS4?=
 =?us-ascii?Q?d8Y0yzAYwSLnTjVYDBWEGLjZe8h/btIi0o/iL3ytrpDKhqe8Rqn/hLaRCKa0?=
 =?us-ascii?Q?5WIVVWO6PeNTd5KqkSdeBi+QXJg6jTZOHur5shA3G3VMXaATbawsWxa40u60?=
 =?us-ascii?Q?Q1sAAGdufA77Bv7Lm3uBqGmRGYryqKLuxFuNZ0P7yMJ2NE7XPnerhZFQxroM?=
 =?us-ascii?Q?KPgGhveTpRZdnUd/8RCqax1Qq+jDg+ZMjSfKGjfSyq/rDA70VBab4puSA2NL?=
 =?us-ascii?Q?eFxCvOraM1GuioQyItnr/tT5EuKR4BiM5rMRZVCwrL55x3PSwbx9JN+xCcRI?=
 =?us-ascii?Q?xBMRyNGHHnC5cQ5ngtuSzxXu4jBkviDLG9M9l3I7l7GRvo+7HSq6X43U7fmo?=
 =?us-ascii?Q?pJmIMwgKH+hLuSqq6FRDfRTk4bDGc+ppzw/liHub+DqNcjxwkRPXtFgWA49+?=
 =?us-ascii?Q?fiWZs3q7MrdtTmg0GMGhlYlEVkt0PMXBIgpmNq9dG4NlIxVwD/YK+fdh5ri5?=
 =?us-ascii?Q?X2knXAynyuV+ZB9P+T+RnVIByoMdo1LrTzG02I8i+/izw1MtwBUX9E5AQB0p?=
 =?us-ascii?Q?mEKOwMeQm3nb30XziOOHAqjboIjTuueqw6wR+Y6nxI+634q4hbizpQoGNscH?=
 =?us-ascii?Q?OGogDVqsovyT1VftlWPKFeNBLyWvqn1idO6akXYMGmGBGXjvBQpCS6oSkZrp?=
 =?us-ascii?Q?DXjNKkfKD1EkVQ5ybjCbrhH9U4uGFh/vS4+Ip1V7PJbLXyGbtcaLeGHSNROe?=
 =?us-ascii?Q?geMYZU/QkVot2HXLqv3bVctSs/w9ap/o4iz5qdEMc2gNiUjiEK5A5I8CHRAA?=
 =?us-ascii?Q?y80L0iiS3JOoED1BfLgrC7TCBXcIHznS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8773.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0QIHDfMLYtTM8K3ONQPLG535K7+qSh1bPfq5p5JHJPzRiYlEUoiivmPkQDYX?=
 =?us-ascii?Q?MGkonREoedCO9DdorZT5Il4EYoZyxRfqUppOSJ1usayOR+Wvwm6+0pPHYnMi?=
 =?us-ascii?Q?ATuEnxOMM2U0+++o7eKlx/vyJbkp+j21lSXKVfqXJgPl7OT6vnQyy2DPJ4V2?=
 =?us-ascii?Q?ijwtFZxp3MrpCZq8mPZgA0cB/uwv7Hd9Fv87KZPcJG2spP5xSZK7/XbALz3M?=
 =?us-ascii?Q?cfIB2deUM80Fj/WjiuIenZv79SCx1O645ORxsQGnU16ig0zQvNVejB52ujXI?=
 =?us-ascii?Q?Tfa+RbGwNbINweW8hYdhODY0J4T/S2p5ON7BCLZ+uip83IPgpfs8CF3Sj8Zk?=
 =?us-ascii?Q?N90biXxrWcFaGkyxEQRCQAlFVdYkYW16tJjKEQIeehRRdQx4+3wha1lRuhZR?=
 =?us-ascii?Q?7jJQspXlZNeO0RTpj4NNm+lloEQmKga5ODUp2dosR0CoaUMrf5e1w8QVoCGp?=
 =?us-ascii?Q?kTj+EXmpvvy1twEpJfwBTSeQeW+pzMRi7vy03VjvAX0woI6qinLkw9A0w1pX?=
 =?us-ascii?Q?McYIQwMwss5AQT1WK7FQtsxCg46zwke6T2YzN9teDrBF8Xc+67eGGXYlb9TG?=
 =?us-ascii?Q?xe792U5EoVSpP2YBug2dgSPTHDe2zYR2qRZz1PrCm/wGFlVU+RsuiJGc7Pw/?=
 =?us-ascii?Q?24csR99VUMM5N62QCTmVg3b3PS5w3zwt60STj4wjcO8vNTA515SIa08TmztV?=
 =?us-ascii?Q?ADxnJxgARRV3FHBsrXfJA1InxgDByY4/WM2ZwWp8wrSwumr8gfvIPz55T0oz?=
 =?us-ascii?Q?CWCIG3z6Il5U+g8X6CbvwTBd39sR8zuXv6MraJOVl9ZO/IYS7mrF5m7PwYYQ?=
 =?us-ascii?Q?/SiOJgLYf6Jon0iZht95xdDXK1IPWHmycTz1wPL4gjidpmbDUD0GFz/iOnAz?=
 =?us-ascii?Q?o3DcM2z8/si8p+2u00nHQAKBt//j3mWII+m5qmOiMwNqsodscQ8A8dMEf4XX?=
 =?us-ascii?Q?s/I5rFDL8apP/tcTTNJo5PjIpviDGmSyjUGheMirqiRJtW87EkaW5gACdc8F?=
 =?us-ascii?Q?LXbCGRsghFPq6PCzcntiWCyobFwEI9Ms85okHTEXAeYpmbTt5N4lPY0KAlN/?=
 =?us-ascii?Q?orSAFsOEluvOBMg7t8vFfQQ3QcgDoVqeJ7sHflhVlDZ4EHmEmrPAFDzoh5G4?=
 =?us-ascii?Q?nCSiRsr8R91XazBzAjzpeC2DnxWJ8spTJ6TNdnf4R/yMPKTdOqL2tLQD73Fv?=
 =?us-ascii?Q?y0pnArwSjsUpqXmhmswvP9GL3hgdTYEu3BKVN3OCYSqiuUm8nnKursyEMRM2?=
 =?us-ascii?Q?bfxW2GIQJjK71DTwEKCCpQ287AAlXF1bMCWHpi0LEudJKHBBGfmaXpPbJckX?=
 =?us-ascii?Q?kzd3DMddjM8XeYch5rW67s8Z5qyoT9v6/PF3gu3nM3l1CWJmzjfMyO6okmZD?=
 =?us-ascii?Q?4jyGQ0ePyXOGXhpdFn3tXiCPKL2OGWdAYQqTHaTmkFIQJCp900zZs+nU5ZIu?=
 =?us-ascii?Q?IVsp2qgZeZW8Fu/vWcyyzVsXfzALVPa9Vg3tz4UHwFTwn+SFExnskfErhQv5?=
 =?us-ascii?Q?mFmfFKivvQcRgKToK5MS5kPCn5uWI8BbH4vQSpJgvU+uSWFq6T4pwTwd9sep?=
 =?us-ascii?Q?fkISSdSktDbkXP0hMXCEehI9Q6vBas1Tvc5znDd6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68ed444-130e-4a74-fabe-08dd22fb4fe2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 02:41:33.2412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCJxJZwMp4bk2NXJ/aNT0XE1PXo3SCs6g/DWnCj7iG7Xb+QWSSn/FnQJ0mZV7K2VPyGebMR2vrmtsaTl08cr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-Authority-Analysis: v=2.4 cv=Ns8rc9dJ c=1 sm=1 tr=0 ts=6768cde4 cx=c_pps
 a=hSS9g3ca6WprpwKybkK64g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10
 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=n_X3tbzzzarxTmYDTAMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: tgLM1lvrEYUZa9vOIquoF1gqANLIb4FU
X-Proofpoint-ORIG-GUID: tgLM1lvrEYUZa9vOIquoF1gqANLIb4FU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-22_11,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412230022
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

From: Meng Li <meng.li@windriver.com>

When FEC network card works as the prime one in u-boot, and is in
active status, kernel might crash during booting up stage, especially
working with grub. Because the DMA of FEC is still in active status, and
copy data into memory if there is network data received. In this case, if
kernel allocated a part of memory that has overlay with the memory
used by DMA, kernel memory may be destroyed and cause kernel crashes.
Because before kernel boots up really, u-boot dm_remove_devices_flags()
can call the remove callback of FEC driver with DM_FLAG_ACTIVE_DMA
flag. In fecmxc_remove(), phy power is disabled, so there is no data
received. In this way, it makes sure that there is no DMA action, so
that avoid kernel crashing occurs.

Signed-off-by: Meng Li <Meng.Li@windriver.com>

---
v2: Fix a typo
---
 drivers/net/fec_mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index d6d5cb52fd..3ac6bd3f3c 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1491,4 +1491,5 @@ U_BOOT_DRIVER(fecmxc_gem) = {
 	.ops	= &fecmxc_ops,
 	.priv_auto	= sizeof(struct fec_priv),
 	.plat_auto	= sizeof(struct eth_pdata),
+	.flags = DM_FLAG_ACTIVE_DMA,
 };
-- 
2.34.1

