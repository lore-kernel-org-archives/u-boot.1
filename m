Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFDCD2ECEF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F08C83A79;
	Mon, 19 Jan 2026 23:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YPWBUNuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A528389A; Mon, 19 Jan 2026 23:33:24 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2205839DF
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJDLjuVz9JnbCk8EoqOFyHxqypA4ULz+uzSiE0A16HX3JzazxCQ4KWtDq10RAv2rKUw4mNMfZwSB66Xbj4MyKJHJpa5Ataw0qP5KTptjdVE5275Pt2Xyx34p7eC3KOikTEGDxM4UurNH2qOMO8z2STaIzozEjJe0tsqw/V3id3wfNBx5/+ZZNWeWoc0VoIXJys4ef+T0iw1UnERYZCNwgtkKqNFHy7+0Jd7h3W6eS5AZl0vIaFj5L8TmMV/jicWKev/jgu6Ge6o2Ogwpo6xeplQVzBKyiU492Yc3Tvw5Jp0BS0yyyKWzA1VTcxxj9e7kPdskSf7/kiZtPQzzBDhdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvnbZ2vJSWid6E9ch9pblfyh3BraKXPASsqRNV8yHUM=;
 b=I63xOCD+qheTKqyP7BDhzM73D7/SHAts9unwbtA8zPSOUdyx4GfAjNWiT0l7FejPiiLwfCIfJ6DSX7fQY3dtUHchwX3Tn7BYIA9ykU3JFqDHhEGm/Ou7CmMfu/LXz73hqOE8x9FC4cNNFmUobjtxwML7V/PhNHjp7O5bV2RhUvvaQ2h2nk5oj7GdP2AF75v1xXQZo8+i8fMm64NfRwCPEV0pGuz+LmWFViVpdJEHHIAKoCCi+ds4sxiI+2H8ktGYfd2ESYw1VSSA5NAMPIpx3TdjlcRYxKYk9K6g9KLA/jk1mgNw+lXmNhsb0CB2VmiCys0IeYjUs7lwkm+jXIizTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvnbZ2vJSWid6E9ch9pblfyh3BraKXPASsqRNV8yHUM=;
 b=YPWBUNuuaqa1aFj8n5rhdt2i9M0o2KbhCGorIyyfen6KiGwbzl4dA9tK0nKvOtza6jfYns4FE8+vXHQs6hDWv+q3CAGR8J5KmMruENhml3i9H333rVgA7fYeDnEn0lbs3Q5RQ0E4N+MIv26/63WtIL3wRP+NlGGGBId0KGlsIadxuRzkk1P2Su09CuEun19NFnjDYaQ739wJWgGC5c0WYW3GGeArIuC24O3+ALJO5cyQwaCThNbL1m3s/0x38vPPetr39RuEzTuE/+b8jcqOJ8XNQIGuWd3Cuz9siUVYKC5WpGzhjEONSv2Qb1m112Rwoy9CPxFHph1gjuvZb1MNJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by AS4PR08MB8242.eurprd08.prod.outlook.com
 (2603:10a6:20b:51e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:33:21 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 22:33:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/3] cmd: gpt: fix partition search boundaries
Date: Tue, 20 Jan 2026 01:33:04 +0300
Message-ID: <20260119223305.3022690-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|AS4PR08MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 800ad448-6da1-4cf7-c029-08de57aabffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RRn7IJrQkBrm9Zk36IMB0zXeVN4YEGgkR1ZTzV2Zd1iCjxvAJxxr+WgGfrK1?=
 =?us-ascii?Q?cN/RtCmv4slzfEKUMBCOInDwUSracpW54b2NIndjqKzspcAcEG9e81GpVgnt?=
 =?us-ascii?Q?1XPLpqpLN/xYJCYWprhh0yQkVkXy87o92+j7/7Z0V9PWhUWqGBffXKC9r2IY?=
 =?us-ascii?Q?iMXdigE82kb6UrzK5s21tpCHzJ6FVEIutoFSxNaebp8RpmtU7OukYHfLqEtu?=
 =?us-ascii?Q?FbBu02US1ISOaUVNIXo3rIjNkn+kjZ4vvd16+yNJf/laNn4/FWM1T7hKikaT?=
 =?us-ascii?Q?k9IoxXbMmXxVKmTouD3U3uiXtYZismed2POU9URM26WRJuccV/l+Bo66820H?=
 =?us-ascii?Q?f6X/lIuQUPKXmaT6e0JIDVGpiXATnj8RaHrlkE+GDG04YJDdt4iuKTrS1dnk?=
 =?us-ascii?Q?1TUHTYcDvrqDDBAx+fxSIonaDf1JQS8EKQeptegLkn0NsHAz1ob0lf07I+9X?=
 =?us-ascii?Q?9W226wj+LJynpC/8TBpjuJYF/eBKega8uux5KN8EkaL/kiosy1gxoN0L377l?=
 =?us-ascii?Q?koMza1ZOZeEv88hCWdNkIHMuTq6cLJeCxOCnIHvKyt6H8z/IQN/WvqvTx7z5?=
 =?us-ascii?Q?DGrxUJt1xzS7Rgd5GM9SaFc9WYgkmORaSRJtne0vJ/L7l2DelO4JX7+elOgg?=
 =?us-ascii?Q?UtKR/VNhOvcStuYR8ojBnoA373SK5Yz0OeDmu8KXn9/XE8s/MbuJYkXGB2/H?=
 =?us-ascii?Q?jYreSsGo+bV9JwMBEq4Ei8ULWyZKDp59Nc5/it0RcqAwvPYxm/jEofucjPaJ?=
 =?us-ascii?Q?Y1axtYPjP/gAmNcL2jJAz4B6gGNDXGQwRU7TOY2qM4w6nTwdBC2DSFcsSpkm?=
 =?us-ascii?Q?HF40Q0k0pl5zHCMANdzTDne9PpfaITLxn1SjP9t8aVMmP32DjnX7cQlMo+en?=
 =?us-ascii?Q?vNSwwWLLI0ujZ2S/sI94a7w1FygMubsQOUUM3B6hpUWbKAK4Jd7qN7wOd1eN?=
 =?us-ascii?Q?P4SwmL3R1Vjx4fE7QoQQVCFSqCOI5jbAGlglJHQTJPtextM6IQRvAw5zQ55W?=
 =?us-ascii?Q?UqBi3qnbeJfYLGFoeXkJM2vMxvOffNmJwzUO/gEu0CXNVeZjAgpMyEBs9NnB?=
 =?us-ascii?Q?Z5YH9cKXB3az1SvS/lySD6fcYF7SodeqGtuZl8yPgd+lIsgTYOvYR8RU2tK/?=
 =?us-ascii?Q?G4PGOem71v90DlFTVghHOIix+qsFljzDBrJJoAQuurcQ0CImcrkdCBTHA5Pc?=
 =?us-ascii?Q?092Uvz23m11zYOa9n/ZTcgkjLmnSgwquhNFvGYM/5G3/Iz781wWf/9bMDUdy?=
 =?us-ascii?Q?BdI10d1/qPAcJpWpJOM4nUtfMgneMDWvBCcisuXU1F33jZRHcbQnIY4HiMl1?=
 =?us-ascii?Q?dcV8l25ebjn5lWiTjDDJoiAa28oXasGU6b6NcI7Z4piAB+W1qbr9N2P/ad4Q?=
 =?us-ascii?Q?C8EYXOEk0cvqresQSDE57R06u4ABZqm9Ufy5BZcncMB96nDxpNcdrmGm+www?=
 =?us-ascii?Q?H6Xg/T9ePI8dA0E63EZjUPeyW3RNvz00QWOckyA+7o3xDuPDSfuPbKuYRnZG?=
 =?us-ascii?Q?8MAebBAVc+th9QrIGjdZikVD60ee+JIAOF+Hlhl9LPCnrS6O4gZHeSkO4Ykw?=
 =?us-ascii?Q?pktP2UyLF7MSGEQRXtzW8BCEo6gxkShkQBBYg0uBbFhWD/OZUeIkifrNkN5i?=
 =?us-ascii?Q?Bq7pRQWgLc+Tmopzn9MOY9bRCKwhZdcCy6UgtRJJEGzf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ci0GleJfuCdtXpZgEVPCggm/Ol49d2d32/7XQ10bhYBWdBQT0wroOywHG/yX?=
 =?us-ascii?Q?i+iWOI3jtp77FDQ+B2xJMtVQrtqo89EH6A2xPhogdm4VWcyiuuzp51mvLDO4?=
 =?us-ascii?Q?VPlI9T0OjiNYBMO8WU/bsX4yNbe7Zw1n2yHvsLj3OfIoxTcRK4kYbf3744gz?=
 =?us-ascii?Q?YSwZckPKqWd8LHqdO4bbrC7pcpJ5J8LqYrcqKRLXgeqyQTJdqS8rfDuG+nal?=
 =?us-ascii?Q?WZ9bgBa8HG1ZR+ist9YCghqhShENv6vB9XShQ22Wr+8SYT1CKS9LFq6zrsPL?=
 =?us-ascii?Q?JqXRKje4JME+08p75lIJAAdZHm965Ydo6x1OEl50qdJSvMW/y/MYmUCX0sDE?=
 =?us-ascii?Q?17XcsKaWCixVJ8u7QfyniKiw5azfx+hhbk0T0XlKJLsxE/kgQeFNn9zvMgUT?=
 =?us-ascii?Q?oS83icQZTyulQg/r0IaYLiN/nbMkxuT5K8xabiimEoeuUlV17VndSF+uRmfY?=
 =?us-ascii?Q?/KNvtiDCVv1JN9i9PTMyyciriJOIPvb2ZsxqJkQuJ/bCz8GluoEBkIx9x/Ja?=
 =?us-ascii?Q?gylguWSZAnZ/JWO12wuQw82Q0xsdSJQAP3BwUy21H+bfL4yHJZ3F5rwUpGEH?=
 =?us-ascii?Q?DJjpHWLqv/sJhFPdLCC2L+R4QvGU1w7TJHuZUHX9ZpcUtMrgWyp/8P8HQqvP?=
 =?us-ascii?Q?evvUdIwta30XxWI0kg2VdPlkjGsaYqudaoTqFNjrcOjSFtQCWrvTOjW25den?=
 =?us-ascii?Q?DOqsTJ2wRuX2AZaDXCXA/0Fk29PY/FGNl3cyJXiUVzOwGPaRHaHfa8SfCy2i?=
 =?us-ascii?Q?5Rzwq39HGoEfE85iGESPHu4tMQ64xm1zRg57/Oo70a+HFqyfluvpmuO8BhbL?=
 =?us-ascii?Q?E8b/7LrAcydlfnTglSmANcbOgM634A9yS59OlrvNHVzbYPi/UXgGnIM7sLri?=
 =?us-ascii?Q?NJd1W1m1NvDKSVkzv3d5usF1NAVy4NhT7JFPT7XCMUg0AYzFnECD9SZ6qagD?=
 =?us-ascii?Q?UsREoXZCNay+WHZ1hKR7N9aB602py5KuypT8c/SA/z5lLoaO6ZXSpQUMp7HX?=
 =?us-ascii?Q?wcjyXQgacy4K9DuxLSaVv6F4lwavC7PQhRLA5fBEV2/T82ZYr0B3JryVK8sH?=
 =?us-ascii?Q?f8j0l8Mk3iQgLrtKD+gdT2x6MhzwfgVZB+tIDC4C6vFaQtgneIsZGl1gA2j+?=
 =?us-ascii?Q?cdyPwIKCM/DucwPV+C+C5Y0pdLSRbKQLdS8MuAfXiwmmELmTqo4IUgqRecz4?=
 =?us-ascii?Q?+8rphLXl6uHmZnKCKtfKccZjiOC5BwFP8sxHbyWm2UsZEPsa3FXHNBz3ivCD?=
 =?us-ascii?Q?lJAdNfRoIQmiiohWYYlZBTYv0tBcK4yuaaIrfWWiLJ/aRm5Fs9E4du4LHqPg?=
 =?us-ascii?Q?LquIhR3zBaWZizkF1HP/06OGIVuuRn6eFNhlrzEGAh+45qrrSe3JdXp1/XY7?=
 =?us-ascii?Q?JbhpDjEW9xMpSACRDpkCV4C84Tc7tYHsRCVIrp7n6OlBHqOmja05SWr17xaU?=
 =?us-ascii?Q?0k+5IDybAeI0pOlRgQTiEz0KRnwxioLhD8uB/Jd608jn56cgKw/htnKCygnI?=
 =?us-ascii?Q?eiL4R0VJNJDuqHWjWg1Vx1NsBbJQS5boiLpmbdmXxHZqR0shjmrssn/ekAAG?=
 =?us-ascii?Q?qjb6tq34WHPAXZKrGz//YK5GbN3l19lPIA5AvL2OkmSDTbi3STezNczNLL1z?=
 =?us-ascii?Q?ZBIHHQjQKLETu27kMuJ9LE450oJZRpWwkNsYvAEg4RH5L8cWwHBHIvINsFbg?=
 =?us-ascii?Q?RBaJLFz+jBWZDcdml/wOYZSeJ4pUIetWdbv1atz963WWSxXK9JKDDi6r3ixt?=
 =?us-ascii?Q?dDlT8HjlukmYOGHVt5pS4ruN0pqbq1c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 800ad448-6da1-4cf7-c029-08de57aabffc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:33:21.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecXmqd9tTQ7WwAS+W5JyXCHxiKBJoUgdMbcCEQB8mSFsIh9nhZ38JoPbL5r7wlpgqj1xfmgGGrg58HFWqsfM97C9z4MaNwmbs0fnJHFcBDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8242
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
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
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

