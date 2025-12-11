Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B318D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982EE83D00;
	Thu, 11 Dec 2025 11:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hYYAlWAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2134C83655; Thu, 11 Dec 2025 09:55:05 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0798352B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8nB5syU6ckSmMty9zKJOcZu+HENMZ+uHyTrCNLkHCbAMajoP5z/ijRQguRKAl3uSpzBXEQ2cnxFP0/5ErJlv+h7p9RmmiDcCpFY/UYFfgbFF/4s3rIK/njzvqsu96LsNyyD0tWkiND6De1NK6HfqSaAy1YkTXF8eIpKaJ3w0SjNS7/dJPl04rua6YEv159AKzGEsyqR8KgqXtJz2ru+Ul/z9vuk11Cb5M53bGS4ZVIiKLEY2FeOH2gBpb9MA/yFGHnhMcamPy7ygoXFsQ/0GesNCkVLcfSaUDL0uTHzp1qgTEia9c0v9zQaDExfWtrl7lU2o784XSfyh+KEdP6qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEZbelac2H/z1CYx1JAz9eUS3QfoVwY/p2PkUKjuB5Y=;
 b=L5x4aQjPMXfk6G1RXvz1zKOmO8597xAXT0qSXHFdO5h7xeDUJliwf01wfq19lSfjZCAGuyqBFla8oXv1alDGvwE3xl3mBZEii2fe3QqxOfgRyxfgWlnaEalD5Hk4jRGc6vDJpJ/Efc77QXO31xkUgbo8MqN9Bu1CWpitYYvMkseKKd4IeQ++boD8Mevsu05bhssnlO6z6zhhX1xnBxr2sMqk3QGOtgmjGz30/26zYwuYkdVgRXnF142lnH5EO+sxXcfDdZWN+Pa/MYmQHl1z2lHiBdpDSuynE4gW8ziT82zPokm3WmoWC4Dh5cZs/7E3wCZ2G4wEmXLMC8Mm7BegBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEZbelac2H/z1CYx1JAz9eUS3QfoVwY/p2PkUKjuB5Y=;
 b=hYYAlWAGHjFnxqtSSf9cDEnIQ0GUlFiD/CS309aDLV4WlFj2cA3MxNJR6AvOIQru3QzXeJjHmXPY+bsUpgqVG6Qc56Mb9UrGphL8sZAobPxMCqWXO88+HqeYS0lkdjXE5oWj/J+nrb8EV+L5AAVgWmhUW3QyBJ/nMEYeHxN4+/LWbxoXT/rko43B00ZU/E9LbIR1crh9UDCDGOrk0zDt8T03WpIverevBpKV1kQEuTeRBoUyCJxCYrZbqyfnZVbOLToKp09h4LlayC6No2N9PQHEKOte8P8nu0o0K3AnBxqegRJX/A/A8yhTI+aqoNPxrjhtJOGEdcc8pjdKPW5VTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:55:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:55:00 +0000
Date: Thu, 11 Dec 2025 18:08:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 1/9] mmc: sdhci-cadence: Add reset control support
Message-ID: <aTqYHV-fN5oXS4pY@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <8bcab0e7b389d65f54746202c28a22a279a4691d.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcab0e7b389d65f54746202c28a22a279a4691d.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c7901940-cd79-4da6-64b2-08de3892f7a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MspmXTnBSj9JYw9QJH4UTk1yi4RaQWMmXUwzlfwZV/sFPV202ZYUN7yNKyws?=
 =?us-ascii?Q?JbuRtaCuQ4RSjrdG9mVc6fYfq6u7jqfkNhMh1t0oBJXq4eeNHVHJY/rilmvB?=
 =?us-ascii?Q?KSg+P0gc2iD6Mqt/IwIwQNoKPzCEb4CGo/zTznY36w+j9nuIrk0l13JW1Hme?=
 =?us-ascii?Q?t4IPL6zXjBSybqg8lzshjL7j8ViN7MoCT1BL74i0Hq9lSFJ+cfhArIqUdPSl?=
 =?us-ascii?Q?Qul5U2fOLf+pz4+6FfOlp8YeSwBs48//0H30jorXfjXzdEq8VYmL+cFeaxfF?=
 =?us-ascii?Q?SiBTpeR3zYm+RptAw7KzQisnRnZ44GkGHzoG8RUYc5hKaNBaVAQ2uxI08Hrr?=
 =?us-ascii?Q?TQnoZYvKL1UE22cBZQI+O5Ja/JJJvH6eEWUtXOpH8/AuqkuT9EgF0y+jKN3C?=
 =?us-ascii?Q?O8+/x7chaNVNSIqAaVsYF+t5ISDK7ZO7+h3IqDe3VQi4MDL6HGUb/QmKfaWD?=
 =?us-ascii?Q?TVHEJwilPc8W4G3wRJkOdemrUn5ax0T5NJT1OL+1xI3zXmbe7zotZPeqc2xS?=
 =?us-ascii?Q?qP/RZ51/QLhz64omC92QKKPZw+IX0b/9im/ShCemPEDNfjUGa9EFjYplC8MN?=
 =?us-ascii?Q?WlShxhoLpKkrSLatr1QANe0TkOLyHUzE+Z2JiCsz/ri4GHwrU8GK+fDyDHGk?=
 =?us-ascii?Q?s3aQEyFOQgRSWVGbHPngvmWRvXsv7VftycHRQr7FMjvwVYWAzRtEJZcBtqlB?=
 =?us-ascii?Q?f/V+MKUkRTkxqZSN2gfQEde5p6idyVLyoDXj6VzRYiNSCzAocqAXl8Auwb7P?=
 =?us-ascii?Q?kZx/7dDsF4IVXvq84WQIXsiqN4TZK48t25Xlh3aVdXIw9ayzVraQQbPB+BQ7?=
 =?us-ascii?Q?ExlZf2o3K8xjqgaO8OqjQ9JjTD1E0ntiuDZ/xaPaT3WIxIQfBId9HnEHge/4?=
 =?us-ascii?Q?od+XX9HoCwhdoi4eYpthqBD2ldKr3H9B8XIr+8VpD26MZDmdLpylpNcmqQmB?=
 =?us-ascii?Q?129LgnXQVYkqO5JaaatPmZHcCjsPhyKGKUyGgd7UuKyLUDLpY30NnbSi05Gl?=
 =?us-ascii?Q?PiR6/XoT4o6YMzoEecxW6Hsbi+a9VLhEcm0IAGuh9fRWFuOaZA8ZsBaSa1p0?=
 =?us-ascii?Q?JUVHzsaTtTgrphB7hs6gpaIZpivoOSsf5AZntcArPdvbsmRCf/vvUixFSdZ9?=
 =?us-ascii?Q?/4Bbm2BHAbEMRrdVmUGq3TRzKeCZcqDUa24mtgiA/c1QyfEDqAQxRewZ5yVb?=
 =?us-ascii?Q?1rOpqvWJSnje6pFOfDo4nPTu/dXGWpgCMOMgi1Jm81l+dgVTvCdx+Cax9XIv?=
 =?us-ascii?Q?1JFpMWPN66yTuDYOvC2cgsKYgM7VO7IvrUhFS1qDPwfglMQjWoqRo7sZRxEh?=
 =?us-ascii?Q?H1s0SK1tl2bJ44bA0nvON5E5dfTLuHSJ6GQKloVR5r1H+ucUPEVUjOE5n/5I?=
 =?us-ascii?Q?mGBP5jfch9iZi8fkIyGgHHfa2kLVVGVn8uNe6DOCYJdn076vpd17LCHGIECs?=
 =?us-ascii?Q?AoXeLL1L8piunhBjh1raDIe7LykmMAbupMG1lxXS7TLZXODdxq/2SWrmpxGD?=
 =?us-ascii?Q?tMwizoTX5ZogXgUH/X+Ca3bvffK9dbReceDK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQYoPfrxTf8a5/F95Eg7luR+RYn57Rvh1cBhwSqgEogK4OPzR+OX/Tqgz+rX?=
 =?us-ascii?Q?pvt+i5spvVs2OoaCblhj4y43/y21KFCh/r1H7cEFnO5PW0iDb8siXSlZ3DRL?=
 =?us-ascii?Q?iGP2Xb0JkSZWbehFdSVt/fhkiPrB13j7BgQxR5LsG9kpbcw2BstEl+TtpfhJ?=
 =?us-ascii?Q?jiKBy+vwJcmQSqFtk7J0lZLGWIJVpVGeg8JrraMSi35OdjqZ/XOefu2ADU67?=
 =?us-ascii?Q?bq+A1k9dFhOYCQ3qAOnychJnzSvA1iEb3erRXVtjt3wCVVwA/+Y2pqiYn6+3?=
 =?us-ascii?Q?9NXPsl54uFbEj2aemeAbc9SgxbF1wVj3fkaugCtGxnp6zB38H4sgBr1x2c7/?=
 =?us-ascii?Q?iaGtr0IcaU5TkEdFd1M97BqtnmilZW9JcrRj36NAqlfbdxgEytpKMhxPKj6X?=
 =?us-ascii?Q?sdobhNEuMYM1z/gopjLf/g2FROtcsS9uHHv7wmeDdiKTvg6FPA5WBLooVV8I?=
 =?us-ascii?Q?mVYaCAU6xpU4JWuGddAlFjsgIXMUiXlDg6EpT1/MG6f5EbiwUxHknT6rKd8T?=
 =?us-ascii?Q?8xSHToXcg40QnLNl5akZnwR8Ft9BrdWFVvRQW3A98ztb3XdvXjHS2CouRMbd?=
 =?us-ascii?Q?NbmeRJbOD8MtZH8//UwdkWei2hYNl+WFUbe3DfeURjYlu/9yP0vQJ9HJUe8W?=
 =?us-ascii?Q?WAqhtKy5KjTX8f4D7peqPO3A09E7c5/fW107dfiwLr6CoLG0TwTPB7H4qfXe?=
 =?us-ascii?Q?OMVH/h9tq2DAHeZyLhxIaL/h5L29A5QrL/ZCkq5JLYM7xIYZJn0uObLbQE/Y?=
 =?us-ascii?Q?f1oc3iTKqRZGnbY/IfqjcDlw6LKAo4+oaDzK1txKsrFxwNQUKz+mxII+5G+2?=
 =?us-ascii?Q?vSiX936J9Fwgo3Uay//jcUipKJhscdohZoLJoYL9Xprf71wJIwss/DD1K/xT?=
 =?us-ascii?Q?v4EIcbcaGKdWxjoD2Xgcb3owz9Lfe1rIXPkh1Rm7btRCdP5S08xRiT7jXqOS?=
 =?us-ascii?Q?A44Ua77IFzktuXyx0CJAFKg+Yrd2yUMKIqzZ0Q2V9tpeZcrHe1obL08Scpwe?=
 =?us-ascii?Q?YUm6n77jbxqnNvfuReMxY9YZzLDemwTvmubWqW8kChBFkhK1y50YUyiTGcjg?=
 =?us-ascii?Q?nmVGvyGXEGLPfhXa+8g6hUPwicZ4RQdol8cHI645RMoKx0L4ObR2ntXyNP7B?=
 =?us-ascii?Q?3XwaAZg11vVlKtqJB9A1Fx3we2laYZzC0Ofw0tJf3Zo1QwIBXLRaDVa1QKIm?=
 =?us-ascii?Q?MQjAHF4Kq3rLXaZBr4NdFZgkc2b8KYAM20Adru2SupUjTPvAOgnZTA2jOBuc?=
 =?us-ascii?Q?Tl8O54ipah7IHirnAbZONZ9hjW9j2yTcAr6HLvEdWpA13G8YbgYyYv9l6Vpa?=
 =?us-ascii?Q?rkM1FkgcRwTwu/v9g91FlQPL7fySFsbhoAklifW1y6MSGHR28fGUlJnPYLrs?=
 =?us-ascii?Q?smHmx0CuNB967SzcHGgC0V6EhPHfP/auoy6XnMXvsMHV84ZFB3q4WKqnlDlC?=
 =?us-ascii?Q?Iw6Qf9A5L1Dj82b+CEIoAjJ08N0hlIKBR+v1CklETMG7OSyU/4L1zXl+kzGY?=
 =?us-ascii?Q?AdHXa4L3TpKN/ONkMGWWV2YYXzJuvdyhPxc0tW+mUO9RKobYBGF3S7KOQDDT?=
 =?us-ascii?Q?tGtibxXWovyfboh9aV1FdKwoDwruU2OjiyF+ICw+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7901940-cd79-4da6-64b2-08de3892f7a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:55:00.6248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJpxFQRKmir3YDNnhr5FCpircsoyekMU7vxZ1QurFywBoZaipcZKAazsduJsOno0tIekXdHEXQ1yT4BjJzFJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:31AM -0800, Tanmay Kathpalia wrote:
>Add reset control functionality to the SDHCI Cadence driver to properly
>handle hardware reset sequences during probe. This ensures the controller
>is in a known state before initialization.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
