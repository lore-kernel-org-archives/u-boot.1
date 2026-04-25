Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4A2FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D673A842E6;
	Sat, 25 Apr 2026 18:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x47gPRx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1261784390; Sat, 25 Apr 2026 18:07:19 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3354842C4
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 13:45:03 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d90DsgsTcSGYxdwYIghKOziLKPQSXoEEvNui7ZdEEq3gfjD11ugIJ0B9FnqHPduCjBfOgD56GUazYbd8JfLolUbS4xVlCADrhcGjwOwtxV/vjqzT0OCNnZf4Pb9cSaY2F+HFH+zxL4BhAjfNUGG1d8szttouzUBXM7uJKwaQKI4g0YxKI8FwgyyL1YNMrNM84FRsSjk8IxYg5oeqX+y41yC/oNjUjZ/KgJomTeaTdeWpnTLmf2Bt+oQYNMzFlhOdvILC6l4n8C3crWPPUHtlvpx9m371U0si2AkFQUMF+evSaWMu3qwhHpWMMVXcSo8OoCtuaT7Kpoqf3pKPpOI1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yDHrLdbDqP4B0e4rQLQ0tMQXqNtDusTD864WhI9eR0=;
 b=H2ygLVp79a0XFoG3Pl0sFdMapury+8sMOaI2/g7adoVlr7zAx0ZOdMVZ20ojc2/nYjNwNAWLWcKCAk2dS1VwcVksODy6uZtEP0c2KIN9dXrssa+4/4OoQlS2uGNR1BdY4Y4jESAZOomqnt4zTCVakvJ03OSliKviEzH0eOi3yVQsgvDPszLDDg952DaDxI60ZnYWr9Cv5gmDqYxg1IFOcoAiJsCqtagU9XiErbnZLt01v7zdnd5H6NxHKLmH5GMJKY1drSAZ6qE94BhG1kUe7zqy8Wq8uw7gyNoefLqVoeEy1WnJbwyOkTTTwQe85B9lHXcot4PjsxcxASEO8zeLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yDHrLdbDqP4B0e4rQLQ0tMQXqNtDusTD864WhI9eR0=;
 b=x47gPRx5lhgftpvNLG7lAoj+kztQT7NslJ6R2iQFG7yYtvZ8lX6K/hTwZig/pVEkWIyj8G+9KtYm6j4btjzGWefuuEK8EB3WI94MzwA0xBvr1RBmgG/pMLJu512ek7C9jX2dU+yCX580Tj+PU2tqG6DMero9180ljznkL5ZOhwn9xj9X/JReRwYUbpCSncbV9TOZjNwhkKIavMOw0ikvkSD9QYmQn4NuNKkIAHZbitMw2kRBii1O8cOxS1R7uGwpVLmDFv/oI7mHUYujrFqyNwD9t+Lxgu4iV1hxRr439RQ7SGQop+Cw7Up8XvXBEmMn9V05iLdXWFsWwlhdpbiP+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:57 +0800
Subject: [PATCH 05/13] imx8mq: kontron-pitx-imx8m: Switch OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-5-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|PAXPR04MB8639:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 92be906b-6bfd-4399-75aa-08dea25820f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: dC7lP/afeUUCE1yXcu1SqnTYu/T1BaWE4MKuSCIAIXy3KZUzR0BjXtl/UeuaJGFAUb+CqsyaOs76S0nC8igyAxdt03hotrjooC2gefvja6V1XgvxZcCG3Jmd9NiEEvHo+oOMpbZfGX55I3Xd2E0YFR58zJUkwhAthmy8aX1m1o5FjL/F4AbrpuKGr7bIArDfM8EkkPuoIIMw3havOjZPw03T6822uH5C6L1Cix0Wpp6fyEboKOnu5DfZ4FfoOqe1jX4IGWCoIKkjRznjlZhc8gPG2ZkBKxB4ozwugMtZ5vwLo0n7Nocg7rO17UjiCZwM1GIKBuWbnbUwNy1M9SGtpQlHUq9xNy+psvZTrtDRQc5F21X/x/7yGOF5TpoxwY3b58c2/iQ4YzAJ+vTVrALY4xe+Qb72GLQGvwSywMlfUvuJ1LgTGOGfr5NTm9wjcNW7OX6Aa7XrgZ6sESofxSN7F+AXivpmB4DXD7NfY4yNOTgAjRV//62uW3yaYcD/tr1hDX3R8tugyKyewV6OAVGdW5g3XLsdwcPz/KkDrmYNHc6gDTL8IePnrpfP7d0KYbPJfFzlDHBtUN0VV9SmXmH2zKARLwItwy9Ep/SHYpideHNM0nTSiI/TvOtriktXiss0gSgjpvc0xy6FpQlncmnxCbJ3xoGw6nrpBmv4Kk6EBDpznA6kBAbZFbHyTzHaoVVnJzHcBJoXnlCSMcm9hiJWZXqXfzRr/2rWXULT9f/+5gLP9rYpsEVxIAHNoa2wtlmO2OOmbJjU+jkoFgdzAF2d8gIKcNr0XQrzWBico2B8RD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRuZVZobDFJeExiOFlUYnRSV3RoSHRneWFyd0ZkUHA3eUVRb1JVK3JVcStu?=
 =?utf-8?B?WnBTVXZ1aXZiSnBzZ09RS3R5WG02Nk5QRE4xNHdNVVdodFRZMGdtK3BjVW5Z?=
 =?utf-8?B?Q3N1VmNCUFZ5WEdSNTk3V2UxdmtZaWtydld0bTJyd1NpdlJHYnA1QzB4QnNO?=
 =?utf-8?B?OHJ0SllQVXlTQkNDQTQycXZQRi82RVR4aUJocTd0YTFQWlp0dFNNclZ2TTdF?=
 =?utf-8?B?THFjUjBIRkpNcHhOVkJ0dSs4VnI1dXVMZmpaTkpQWDdUazNHMFdRTUxDWnpQ?=
 =?utf-8?B?ZXl3VE1NZ3lyK2g5d0tZVC9wZ2lKQ05ISGxLN0pIU0g5Z2FlWVF0M0pqTzho?=
 =?utf-8?B?enhZNzR1UHJxM3JBS1F6d3pyd2QrRnpHWUMrWTR0VDlRS0psNGZjWFhrcXNh?=
 =?utf-8?B?WVFBL3UxN1BhZEhPVGFsczNhbmJJeFhTbG5xYm1UaXlJNkFsa2I1NVQrdzQ1?=
 =?utf-8?B?Qm92dFZXMU04cFVreDhQZFZoQzVYZWFrc0JIZlRKRm8xTlQ3R3pGMWhCKzdw?=
 =?utf-8?B?eHUwSW1FdVBObWtpTHREKzUwSmMwbFlHajQxMUwrQmQ1c3IzUm1HRnZpRnlq?=
 =?utf-8?B?Y3Bia0ZHUTBGWjhMMFVBOW1HcDdBaUwwYkcyTTZSUkdVMnV0L0pKRDNyZlpp?=
 =?utf-8?B?L282ZzVzbk9FL3BVT3M3ZWdkVDR3QmM0K3pJc0RMZXJrOUIvdWQwYjFKd252?=
 =?utf-8?B?dVc4VTluUjd6UGNSTDFoV2NSbVhHbUlNSWRyc01pbHQvVWtNM3l5aXpuTFAw?=
 =?utf-8?B?eHdScElIWmpobythaDcvMmZEaFpsVTh6SFZmQnB5VTdnS2hyUi95SlJlc3lQ?=
 =?utf-8?B?SUVOS1RhREFCYmZrbEdWbngvbXBNRzByYjZnUjhTYmZpUGlPUGxjZUpiTTBi?=
 =?utf-8?B?eE9XNDJkN0FhWktvZjZMSzQxTUp2YWpVd3p0NFZCOGI1bmk1Z0pHeWZXOTJo?=
 =?utf-8?B?bStnc2xHbHhNZHo5eU4xY1NlSEYyMlpxVzdvdDFQMXkvS3dveHBQTk8zMUQv?=
 =?utf-8?B?eXRZam90bVlWQ0RHNnZScjd4SVNSTzVsZ1dtc2pUWmtESlZNQ3F4dTE4Tyt4?=
 =?utf-8?B?aWJURHJxcml2TE1uWVR6ekR1UVdvZW04WVRoWjdKU3g4b0hHZWZrMHZoWDBX?=
 =?utf-8?B?RUViRWJpdVF0dDBzQnorU1dzUFlFcFpCTFZIYjhndGJyRzErVWpFWnM0ZTIz?=
 =?utf-8?B?cWZ4OGFWRWUzOG1TdHNSUnJ3cXYrVUltRkFZNGFPbTlLd0JtTnRZWUs1S2dD?=
 =?utf-8?B?NlJxQWxYNElKWGVQbEhIWXFGR0VyUFpZWWk4UG9yTVhLZFNINEgyYmhmNzFR?=
 =?utf-8?B?cHdGcjdXK2NRdE9HYThMQktKWExYU1FaV3NhbC9NdnQ0WkFtZ04yTjJIZ0Uw?=
 =?utf-8?B?SWwyODR6Z01xM2J4Y2F6blBZTVp2eGNGRnlBdjcyYlBWaFk2UjJ4bW43R3Ny?=
 =?utf-8?B?UzU4WU9ET1lReERDeEZKaS9aTXVYb1BYQUl3SEJHRnZlakdGOURBeTNMZVUx?=
 =?utf-8?B?aG82VHl2MXdvcnRPaWtXTHFxOGpMcDN1Qzd3a0xsUExiekEvV1RpaExaNDh6?=
 =?utf-8?B?K2lxVGhKVG93dGx6NUNLYzJ4Rmc3WE1GUDlQdUNSYVFJVkJWdnJnRk9WdVlq?=
 =?utf-8?B?QVpDeEtETGpUMDUwdHpCY1ZjY1JyMDd5ZThCWTZLS0lVQ2JUNVBpZUtIQ3Vj?=
 =?utf-8?B?cDNGalA1am1DMlE3SXpTVzlWNm1FY0ZobFloQ29kZHk5SWRVWmljbks5OGdn?=
 =?utf-8?B?KzJpYTVzRVVxZk5hdkRmWTMrajk3aXozTXFnQXJrdjlHdVlIV09ncnhHRXlY?=
 =?utf-8?B?eWlOVkFNbzlYMVVPSWRtc1RBRHJXa2VnWGUrR251Ukg3ckh3Q1hsRzgxTzZu?=
 =?utf-8?B?Ri9iYlhWeW81MGthTWhqOU1zY0t3Vm14OHFJTVlpYWxCTGY0TE5ObStqbTlp?=
 =?utf-8?B?UDBjL04xeGdpSVllUFpPbFRnWmZDR3l0SnVTWFBseWw5WEpnVjhUWWk2dm55?=
 =?utf-8?B?SHlDRndxdGloamVob0VoeTVvdld0VXJrSWdHc2tmOHZJNHFmSmhSUzJzQmRM?=
 =?utf-8?B?djRZSWdiRmk4WFlHcGtMY2x3c2ZySjFKQTNuUEsydFBqb2p5OExBSjRXc0p1?=
 =?utf-8?B?ajNZWm1nWElSb2w5USthN0hsaHNCMHhIY2FvSXhvSU5FMXUwK2FhQ3RMTDNV?=
 =?utf-8?B?d0tkQklBSHU2Nm1xL09zNFpPY1pPYkFEYXJkbjRNM3ZHK0lHZjBVS3BzVGZ2?=
 =?utf-8?B?SnQwOG1aK1g5ZC96YWYrT2NCS1Qrd1p0dUlvbGVwNGlPM3A2V0JIVnBmaEF2?=
 =?utf-8?B?K2tvWXRrcG1CUVFrYWJuOFJWNVh1N0t2cHNUeGt5RldaMGNwL0wzQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92be906b-6bfd-4399-75aa-08dea25820f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:52.8359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIpFj2jIofNcrDxdqFHesBj5Yo5Q/XFSBD7caf70Rm41uxw1ACFLTvqmjF63V01JkIGZJpKtZoUp/VnrhEMrkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts is almost same as upstream Linux
dts, so switch to OF_UPSTREAM by dropping the U-Boot copy of the dts,
enabling OF_UPSTREAM and updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                      |   3 +-
 arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts | 613 -----------------------------
 arch/arm/mach-imx/imx8m/Kconfig            |   1 +
 board/kontron/pitx_imx8m/MAINTAINERS       |   1 -
 configs/kontron_pitx_imx8m_defconfig       |   2 +-
 5 files changed, 3 insertions(+), 617 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2cdcfa9f92e..c4360390984 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -888,8 +888,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
 	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
-	imx8mp-msc-sm2s.dtb \
-	imx8mq-kontron-pitx-imx8m.dtb
+	imx8mp-msc-sm2s.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
 	imx93-11x11-frdm.dtb \
diff --git a/arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts b/arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts
deleted file mode 100644
index a91c136797f..00000000000
--- a/arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts
+++ /dev/null
@@ -1,613 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Device Tree File for the Kontron pitx-imx8m board.
- *
- * Copyright (C) 2021 Heiko Thiery <heiko.thiery@gmail.com>
- */
-
-/dts-v1/;
-
-#include "imx8mq.dtsi"
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	model = "Kontron pITX-imx8m";
-	compatible = "kontron,pitx-imx8m", "fsl,imx8mq";
-
-	aliases {
-		i2c0 = &i2c1;
-		i2c1 = &i2c2;
-		i2c2 = &i2c3;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		spi0 = &qspi0;
-		spi1 = &ecspi2;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	pcie0_refclk: pcie0-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	pcie1_refclk: pcie1-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2>;
-		regulator-name = "V_3V3_SD";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
-		enable-active-high;
-	};
-};
-
-&ecspi2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	tpm@0 {
-		compatible = "infineon,slb9670";
-		reg = <0>;
-		spi-max-frequency = <43000000>;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10>;
-			reset-deassert-us = <280>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@8 {
-		compatible = "fsl,pfuze100";
-		fsl,pfuze-support-disable-sw;
-		reg = <0x8>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-name = "V_0V9_GPU";
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-			};
-
-			sw1c_reg: sw1c {
-				regulator-name = "V_0V9_VPU";
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-name = "V_1V1_NVCC_DRAM";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3ab {
-				regulator-name = "V_1V0_DRAM";
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-name = "V_1V8_S0";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-name = "NC";
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-name = "V_0V9_SNVS";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-name = "V_0V55_VREF_DDR";
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-name = "V_1V5_CSI";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-name = "V_0V9_PHY";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <975000>;
-				regulator-always-on;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-name = "V_1V8_PHY";
-				regulator-min-microvolt = <1675000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-name = "V_1V8_VDDA";
-				regulator-min-microvolt = <1625000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-name = "V_3V3_PHY";
-				regulator-min-microvolt = <3075000>;
-				regulator-max-microvolt = <3625000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-name = "V_2V8_CAM";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-	fan-controller@1b {
-		compatible = "maxim,max6650";
-		reg = <0x1b>;
-		maxim,fan-microvolt = <5000000>;
-	};
-
-	rtc@32 {
-		compatible = "microcrystal,rv8803";
-		reg = <0x32>;
-	};
-
-	sensor@4b {
-		compatible = "national,lm75b";
-		reg = <0x4b>;
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c32";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-};
-
-/* M.2 B-key slot */
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
-		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
-		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
-		 <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
-	status = "okay";
-};
-
-/* Intel Ethernet Controller I210/I211 */
-&pcie1 {
-	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
-		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&pcie1_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
-	fsl,max-link-speed = <1>;
-	status = "okay";
-};
-
-&pgc_gpu {
-	power-supply = <&sw1a_reg>;
-};
-
-&pgc_vpu {
-	power-supply = <&sw1c_reg>;
-};
-
-&qspi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		m25p,fast-read;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	assigned-clocks = <&clk IMX8MQ_CLK_UART1>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	assigned-clocks = <&clk IMX8MQ_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	assigned-clocks = <&clk IMX8MQ_CLK_UART3>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb0>;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	maximum-speed = "high-speed";
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vqmmc-supply = <&sw4_reg>;
-	bus-width = <8>;
-	non-removable;
-	no-sd;
-	no-sdio;
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	pinctrl_hog: hoggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19 /* TPM Reset */
-			MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x19 /* USB2 Hub Reset */
-		>;
-	};
-
-	pinctrl_gpio: gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5			0x19 /* GPIO0 */
-			MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15		0x19 /* GPIO1 */
-			MX8MQ_IOMUXC_NAND_WE_B_GPIO3_IO17		0x19 /* GPIO2 */
-			MX8MQ_IOMUXC_NAND_WP_B_GPIO3_IO18		0x19 /* GPIO3 */
-			MX8MQ_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* GPIO4 */
-			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10		0x19 /* GPIO5 */
-			MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11		0x19 /* GPIO6 */
-			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x19 /* GPIO7 */
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x16 /* PCIE_PERST */
-			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16 /* W_DISABLE */
-		>;
-	};
-
-	pinctrl_reg_usdhc2: regusdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
-			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x16
-			MX8MQ_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x16
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_qspi: qspigrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x82
-			MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82
-			MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82
-			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82
-			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82
-			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82
-		>;
-	};
-
-	pinctrl_ecspi2: ecspi2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x19
-			MX8MQ_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x19
-			MX8MQ_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x19
-		>;
-	};
-
-	pinctrl_ecspi2_cs: ecspi2csgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
-			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x49
-			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x49
-			MX8MQ_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B		0x49
-			MX8MQ_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x49
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
-			MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20			0x19
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8d
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcd
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcd
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcd
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcd
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9f
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xdf
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xdf
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xdf
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xdf
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xdf
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usb0: usb0grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO12_USB1_OTG_PWR		0x19
-			MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x19
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index dd720b819db..0e885f97e63 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -327,6 +327,7 @@ config TARGET_KONTRON_PITX_IMX8M
 	bool "Support Kontron pITX-imx8m"
 	select IMX8MQ
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_TORADEX_SMARC_IMX8MP
 	bool "Support Toradex SMARC iMX8M Plus module"
diff --git a/board/kontron/pitx_imx8m/MAINTAINERS b/board/kontron/pitx_imx8m/MAINTAINERS
index aad84528e33..8c43526691b 100644
--- a/board/kontron/pitx_imx8m/MAINTAINERS
+++ b/board/kontron/pitx_imx8m/MAINTAINERS
@@ -1,7 +1,6 @@
 Kontron pITX-imx8m Board
 M:	Heiko Thiery <heiko.thiery@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/imx8mq-kontron-pitx-imx8m*
 F:	board/kontron/pitx_imx8m/*
 F:	include/configs/kontron_pitx_imx8m.h
 F:	configs/kontron_pitx_imx8m_defconfig
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 39aeb7bf01c..3b13fea5d68 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x300000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-kontron-pitx-imx8m"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-kontron-pitx-imx8m"
 CONFIG_TARGET_KONTRON_PITX_IMX8M=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

