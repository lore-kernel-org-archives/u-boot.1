Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F686C98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F67839DE;
	Mon, 19 Jan 2026 01:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zmn73dy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248258397D; Mon, 19 Jan 2026 01:36:29 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DBE8389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvwp2831ey7zP7TdvbUgqu6iSDdPLtsuJKED3vwPl17qjZFqCekQduGq7odP6TmBstooicVsr3gEgJmz92FDm1MWuXpUgoH50avU10D4wpoZr7+BsS1OOh74XUodf9PFX5KaCXtuLxiXS70w0dfWBFKK0Hw8UG9qg0H3gpOv/vpbh2xIHJyWrlu38zKKOELXtBhHrtLtdS97FCCrL2INUPcDnRit49rbEle6UrWERMvYazfALE9pvJkHG0xTw4q6igbdYom9WIeLqovdQCQHSrsUgfMvkLX3J7GUzkf8uPKQT217SfutMJ2hjAHM+MlIE8UXIw2Ea5lfK7GZ6IEvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJyAVe22F4rEj7hNifWVF4I+fDOt76tACfDPiKi10+I=;
 b=eXH10qN179y40lOMTd4ka7c8H6kXGKUnUmkfu4w3wMCngsnyqfWZAHLWfr29kc6Nq9zYzn02eKk+GTy07KMzFF0WuOPeboWXJlHeA0/T+loukozgbp+KCnsfRy+cgYFWCaFTX4Work7lVd0whxpMNXmUKsGKu14GXvwZ0d3JKNj9iaJDDDy0Q4060FEeXY10O230LzHypPXUZIMd9LvHK+WGuYsvwLFkC+g7GHGxEg3Tw9iyO7Ci/YuxI4rM2RLMOy/HpkVJAL8VOD7y6otgLnXUfzihyqam4RIhUC2elm7I7+rtmMtpOCiWKDGARLYyIjznZ/jS0Z0FfpUC+SFnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJyAVe22F4rEj7hNifWVF4I+fDOt76tACfDPiKi10+I=;
 b=zmn73dy8DFd9d2MIjvNkUFVO6VHc5XOCyTdCGeOhe8ztDN1pMnw5G7ITMHMhVkl5SVbV08dl2dV2rUHO6XYiWuH4oq/cD82rNzXbC9y9iI61MwbhqUv0swhs+Uf1MraEX/bbwRsZWKHy5XzMpDQizWkYR8JE0XIKPy7BAuHDX6uyn+wO58s8ksJSmUkO+ZEA7MFeu76+6QZ4Rx2VaPaGyt4Cu1K2ThdNna/xhpBStrgm5aMxkXSF6aYKDzxZfZLwfFzavwD+yq2dBtQO377XIprcE5GXsWdmtj93MoH7EGGeXjcLIuzA4r7hFr0BPHUwP7l/af9CVEkWe5+u/j8EeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB10761.eurprd08.prod.outlook.com (2603:10a6:150:151::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 00:36:22 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 00:36:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] cmd: gpt: fix partition search boundaries
Date: Mon, 19 Jan 2026 03:36:05 +0300
Message-ID: <20260119003606.748561-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: d09b807a-8a75-4998-dfef-08de56f2c537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S3xgLHy5q3uzYTXu7vWk7Y94RZjaVxBEqcuC7yQyb3BSMlGbv44CRsXTBIhM?=
 =?us-ascii?Q?cLK+WpPWZkoiWsFnZfIYGA4o1njRf5b7huS29pGoR6IBYxJ0WcrMlHPuyovW?=
 =?us-ascii?Q?g/qg+X+aP0tKvsh78v3V2KeIMarrHnks5ZnVmJKnwhMaP1Reqcnq1VvQ9cl2?=
 =?us-ascii?Q?ykmM6dkc6NZjjROc0HZyfAJqFfRoPSHj4JXoP12gFGmYiVPaLM4X/wM5a5+j?=
 =?us-ascii?Q?tSsXZZDwsxYtoxH5if00b3eh7HjX+lramNy4pmyoM0Xo0gyoMlYFg6F95hqR?=
 =?us-ascii?Q?s9xj4wBS6f8NaKWhmfRxSaTGLrxZEKvdtXGw8RpliNnuZs+EnzZkqKoPCZiB?=
 =?us-ascii?Q?4wOiill3ON3b1esXmPQIagwP2su94d9m5pYXKSiBDEIYNm3G5Yru8Ne4wqVd?=
 =?us-ascii?Q?D8y+pS9oEoRVZ1nz6bclAARdHrKemOp1tvkT6kc8WeER8c4x8+no8KaFzAcE?=
 =?us-ascii?Q?9Hz2vPEoXVBY/Yc75+WBUAEWzQmL1YZtpJTu2zwMi4zu2cLn88cZ68ZdACpG?=
 =?us-ascii?Q?yenNmWuzQhC7OpDO1elaNbSQGq1G0qSzJL9htzgPn7A0Bq+bTkxvlqYMp06k?=
 =?us-ascii?Q?V2BW7CfubUQ/AtzTVTf/DE9gRTgPRhQdiGO3qDSyGyDgESXhgkTlRorQT86p?=
 =?us-ascii?Q?G4niv1FNk9i+UfbTtsMsP0Uz73b1PnmJi2FeZ/3RVL9AqIA8cR4Xy2OxMtT1?=
 =?us-ascii?Q?cfmOVUGjykUk0+Ew4t0oKmQD1VqXUjZFpQXQGL4skV+dh/SulsMJtacFagAb?=
 =?us-ascii?Q?7XCID/aCgE7tOMpGSWAiA7cI4TrI3hf4s7O8dOL66GE/mj3CfP9/sKTyAkd4?=
 =?us-ascii?Q?Q1qHe2zNZeLXgO1iM7Iicjm//4eDyaPSveDZIzlKqbd+bJP4wX2EKCCCe3IY?=
 =?us-ascii?Q?/rd6den8jtmloudIAcexROtLGn1erg2h+nS9XdsJuog1xsiER2h3V/ZZxk56?=
 =?us-ascii?Q?UEwROCTLokueBjiQsfXx9NW9CEXxIa8ZkfxiCO4sUAI0ClJi0YmyLcdPmyZQ?=
 =?us-ascii?Q?eume9Lnf+d7NLRmWN20aL+MYDqUy5JFFKTlpjMZcGT+DANk8wgfSeE3Y+/8a?=
 =?us-ascii?Q?+w639YOllt08ACWkwi2AXDJ2ER9cf/tL606y9yd6BIBJ5EyjkA7Gp4lYMUkX?=
 =?us-ascii?Q?Wpo+q/mRJ1Z73wH4WJF3d2kIltmKBMQ3Vfp8jlqS2ej8Gak8YY9/BbyekWVH?=
 =?us-ascii?Q?A6qEUa60Awtun4bw7BO78XHxO05kwa6UfOcJgsVvOXnnZKTVgoPD18lGXTmc?=
 =?us-ascii?Q?d5cOif3c0Az7ZVWT0KyWorFBIoSjOVq7xhsXzbVa2bJpL49B9FbXUPViV0pj?=
 =?us-ascii?Q?YwqNU5sLS4SDCKCihWp9xqQWcjtE/T6UZQwvLhmEHllGc6AyqEv19aEAWJMR?=
 =?us-ascii?Q?9m2tLHqKHiDfCoQ/RHFQIEG801TbUeLoScmJV6Z/ZJ378DI2sp9wm785MzEu?=
 =?us-ascii?Q?oAvy5VNt1NwO5Bmyel7INGzyyybdQUl8UTr4Pa5WuOgPbfkUt96/OcDYW28R?=
 =?us-ascii?Q?3WMK7rEeSAEzH+abpNzG+eAWBR9efX8u5cqjiUugrfg5b5ozsqc5D/J5EAuD?=
 =?us-ascii?Q?9/osziAaJ9h/6PEwFF/Pj2weQ6r4HxiK4asY96voZCbxGnBdSCd7p1RoltHB?=
 =?us-ascii?Q?mmmTXFmGdkQl25c+UZ0AZiR2CNE7GgFIO0Pubzmv0JP0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ry8az/H+UyR7y6qHXv/zIBUu4V+Xc8z1Gm+qWh1kV1H9EwFtSd3TG2mU2LAm?=
 =?us-ascii?Q?AL7E0WzXYY/y7D/jV3jTnYAAnkIPR59MHhmdoVRnBaSEjN3UzhuBhMfNiqH0?=
 =?us-ascii?Q?5DVhnZuMtW4Q+bacNzX3wox55xcLOpPPHX4mTRlXOFaBB1tc2Dxn4tVjqOWI?=
 =?us-ascii?Q?oxKhTOxAJcpUa9mGwrgcVXs68HDm+3ZXszImzrNeJvg9u/iIGrrTswUxmDOn?=
 =?us-ascii?Q?UoOUtTUYvWVVcXP1RxJAI5Q/qPw+JxOpQMkVZ2tk/EMTZiFpIzwn/mQp+Jsy?=
 =?us-ascii?Q?GtJycfRVC8Ry+h12mP6goK1qln1vni5M83GSAPWPp4rOroyFAykRr2wWqCAO?=
 =?us-ascii?Q?PXmXNIaKLTfYPCEcWsRt2dxnK8Kf0yNg2noX9sX535g2OFx+5C93zh2szDC1?=
 =?us-ascii?Q?bs/AOlxW68RR62MafQQGm1WEe/dpCnVbV7YnmW2RiRpS5Mht5/18BI+6DjUI?=
 =?us-ascii?Q?PCo052PbzpwwDIDNawt+r0YL+/biLoSjcW2Rx/t+FYrhVvzccGY+B70mCALR?=
 =?us-ascii?Q?OTNpouYZZKfNVs23oTcoRZV6FnHBO+kCBnbePhrPfsPtbdKGiCf9s3vR5tk1?=
 =?us-ascii?Q?E1bfd78Hv8yEoJjccUr94r6HNNpvv2aKF85NxavF8dQNr8BlBacPvX+LU41I?=
 =?us-ascii?Q?RJxNdsdnFv9/BOyHulkZXaq2TWJNll8UTZyCI8zqDuV3pWbGCjD8HHGbNpNK?=
 =?us-ascii?Q?wIQr3z52/c7ACWFGXQX+jBjK1tGsM2+i67ZF9c9BdtcY2/+MrHVUZ9QHzIha?=
 =?us-ascii?Q?k9wTVaNQn5Owa1tUFmZ9jXG94TMdEOhp7D8IXymDHbIwHpwutLX0dGRbZmt7?=
 =?us-ascii?Q?gzgD4YQZpxBKxAoNLxvzLqZqhVB1GlbozbxAtAUHo5EBnwLz2+xCoXWA8ga/?=
 =?us-ascii?Q?/ifrHErJDsvF/hJnM+tqVtm+KY56ghBiIJgko3xgcXJg+L94BPc3+NyDwLNG?=
 =?us-ascii?Q?1kK7Kw2AnDJQvMXv+R2oRE/bwhj3GC/bGA3FtJgFrGX5cH5eFbkofjOORhnY?=
 =?us-ascii?Q?BfshkUf9H7uvSRdC/UcHNKRzWX+ewuU2bhglaFL0J9vxO7TdWrVex3HC/mLy?=
 =?us-ascii?Q?C+IgT7SjWXglw1nFSUhet1upPS5YrGOjA5+ehAEsEtEkE5vdarbQ/eVHAU/V?=
 =?us-ascii?Q?jg1T7xXWjrNZIoOni5Paxs8gi71+Zy/gN9kIgZ7FKHV3dNw/V7I4kRgZJYmk?=
 =?us-ascii?Q?PDWMKAWxGAEgyVglFWMTZP11XUw9RfyiddZ41REMdb896A7cHqG/0zj03twq?=
 =?us-ascii?Q?g5snPOmwMBbbT1/TzFb+Yy/0GLbnAar+sn2a9MEyfvYcu9c6BDfqYvlCuwr6?=
 =?us-ascii?Q?X13wHsnYFGdZUk6PKb6x+BlSaw3uDreffR/ELHIwHEBRbP71ALEwWqtOqNPu?=
 =?us-ascii?Q?J8bYYPT83F7SXQuF2MAocCHad7VSPgt5QQAe8bkILnLkuIL8zvW+xdeBWV/S?=
 =?us-ascii?Q?q0ZWyLt0V9eTYhvHSm/tjb3KRLd+s8isOk7owiv1K/fvHgaIvN3DkWpwN5nG?=
 =?us-ascii?Q?z2rwfr0sbZnDKuiVquy8Sk5rzwP6YbyP81ki6gBzng5fgZ/DUTbOnUCozRsD?=
 =?us-ascii?Q?t/+6f69NvOPl+I8UbyKj6yNAMAcP+m+Jkh3seb88BMaKeC2piTIiag2Tjebh?=
 =?us-ascii?Q?FsfBnZ8nEsFyt89/i5NiyiKK4LeLj/yQ5BnDXi7Hj9Qw1gqByiTwFCdtnqA5?=
 =?us-ascii?Q?nZLUJRCZrDNwAPtuko6VlispGCYVTZRpp66iMbhhsjRXORS7QAqFz7tSG0vG?=
 =?us-ascii?Q?l4JUcYE4zGqPs50JZ4gV9p8rCG7c5vc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d09b807a-8a75-4998-dfef-08de56f2c537
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 00:36:22.6068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auSEdPy6uNRcL+p+4/yLJoR5n8+TOZfLQII5y4IVBwyUsXwpKGW9XlQXCsBGK6bBg61mBYd5Ru10D7NyVy4a3F1etQYnOFYzLOLmhJrZmQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10761
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

GPT disk partition with max available number (ex: /dev/mmcblk128) can't
be used from U-Boot. Here is an example:

  => mmc part

  Partition Map for mmc device 0  --   Partition Type: EFI

  Part	Start LBA	End LBA		Name
	Attributes
	Type GUID
	Partition GUID
  1	0x00001000	0x000013ff	"env1"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb02
  2	0x00001400	0x000017ff	"env2"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb03
  .................
  8	0x00158000	0x0034bfff	"apps"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb09
  128	0x00000420	0x00000fff	"fip"
	attrs:	0x0000000000000000
	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
	guid:	5452574f-2211-4433-5566-778899aabb01

  => gpt setenv mmc 0 fip
  error!
  => gpt setenv mmc 0 apps
  success!

The error is caused by invalid boundary checks. This patch fixes an
issue.

Fixes: 12fc1f3bb223 ("cmd: gpt: add eMMC and GPT support")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/gpt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 84221881c39..205f696c807 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -723,7 +723,7 @@ static int gpt_enumerate(struct blk_desc *desc)
 		if (part_drv->test(desc))
 			continue;
 
-		for (i = 1; i < part_drv->max_entries; i++) {
+		for (i = 1; i <= part_drv->max_entries; i++) {
 			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
@@ -819,7 +819,7 @@ static int gpt_setenv(struct blk_desc *desc, const char *name)
 		struct disk_partition pinfo;
 		int i;
 
-		for (i = 1; i < part_drv->max_entries; i++) {
+		for (i = 1; i <= part_drv->max_entries; i++) {
 			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
-- 
2.51.0

