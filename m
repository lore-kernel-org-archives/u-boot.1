Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F0E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBBC83F82;
	Mon,  2 Mar 2026 14:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="llzLA1Sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC20083F20; Mon,  2 Mar 2026 07:41:20 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA82383E63
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EllArAoaEm28QT4hCM6WEVSvLG5hcybjbwZ/RHOqZnoDtl3RsMsFgfCbst9BOqvNjprA7OFvH0upZKVvJWoZqiBLOaaa2TxxTcO64TVS/27wpYxyJ4srAwLVOHm21o3zI1l4XWd3a8Y3gG+kslyhkQeWWn9/UAyuaDZe21F5z1ExeblEiL5EmiopCZWSx+aAAg/ej2yMdaA4lZlqIOJG6C7wtmGtzTX+c0d6LNCkZGd3EArnf1SIzY7kNhN7pyKhBfbgw6RLtoqgX5Sx8ALAQA7A6dMpLPyjcJXT4Uh8m526+lWnQ3hZ/yFrOKfeUr3RdtGjLUAm+zNy+uV6PS0zmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAbpixsxTHHdYnnm3dJvHbWa0eMRM89uD+OFc7+vWcg=;
 b=tlWpFkkaWmp4AwKE/S8vIVcq2513TQNnaRkxgn62clPu7W7m6NUqk61pj0TVvZkv0oI52cyYl9gDDA1FfkCYJfvvBLFZLcJCeKXo4SPaSHBTuoTszWGcT6i7BsF3tb7SKh/22s7hsPoiM41zlyJiX8r940LxylaQEX+DU+8IHv/LfzoHfGpCSmhJdpaDcJiO5VWe5gcPUEYX5FaKSYoZ9XvfUcJO3ipVbvuA3cNoJ9k9r2/dIQOc3EGg5oZADIUeHUa8mMEHnM/cK0NGZLZrAsLPCSKZXJ2VAtw0kyAi2E7zn/60BMD51be8+Jd7JeNmg02omFe9C3HYWvztWwnofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAbpixsxTHHdYnnm3dJvHbWa0eMRM89uD+OFc7+vWcg=;
 b=llzLA1Sp4V6JARX1sIysd8Po3dcZ29KTb0iiG0bydOUgbxFw2TSz9n8mRQONw8bMmBsspvIIBaMpAWOyMXFvKq+al83eVIZRlkeiQO13c/ynv2ifsWNWAsk2klv1760/hJQUWykWzseqRsuWV2tCI6Krjs0WAltLknCq4yCRNecwVDvV1v6NLv+4hfixf9mP8xenGc/JsIv3F/3Kx6MmXO9zL1C6hOUqG0TCwIg1dwFWmxKFbXmro3XUbeOysPDjJyfgMM5Nbps5VHjtfJhxbPr3kYqgzcvULaZIs9tFIH+toZLv/TWxraP0veqSU7DfBNV+Da9JmebUln+Uyc7bbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:17 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:08 +0800
Subject: [PATCH v3 07/13] arm: imx9: Add i.MX952 SoC support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-7-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ac2bbe-0213-4d87-d033-08de7826b48e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: oIQ9w429f6CguPqR9GATJ1h/ywwFDTFyD+hHvUaABt+kuvSdn4xXSqdaQdQo49a4oLOshtCwZ+vgCrEOAFNtNMZ5wR+QV6Ntg+ODuumtZJUMENkP32Ugmloj619+Bk+lZqriETqUr0BjKd5D4mMYPNYNnxw8pFlFoJ4bPuEiLmZ0LpiCv3KKLir6EQQY51STpmTh15MmMqflJrFOCF7s1cn6RNkJaf0CXrmcSJRfFjHGpIIEro/ELotULigAfz4OtmMhHVX0d2Z44a19gg/kVdWCv3N+tLhybqrwAik8cnzJJeCVZVKDZWDjS9R8TJ7ZUT7trwYJaC63Ke7UZWlP5V3QOJDwNbJqKYyhYfKqESAxT6y8LAmb6Xb6l/RnJEcTm11WBAY0dX5WzeJ57Vud9Q9HioVJm49d2ukJ2GGerPITLjiMJEvIXCONcVlRseJrl8PfIsULytDERUBwSot14eGF/ZyYJeiLeL6eNBFGoAgd5saRMqUl2SF1ZzwLj90pkXqeSQHt+LiTYFeQsOJgno/Ijh9MKhFSvFfNAIa66aX84qevcZNm7/PPMdszsvgfsOXKjP9ooH/BdjenbfWVBI6WJ268dEYfpV21ffwwl9kH8tYtsjZmJ4HGz/PNxu6irbIjgPisiQf+5yJnidHAb1Wglu/nI7peK8BvJ4Xcvj21wNAytf6JTEEoUcqNZ+5fn9j/LRfDdfr1Nqw4w9Z68su+jGXr2oFssHqco3nOOU4xiPpav60hoowQX/AQmPh/Wdp1NsilH+9cdDg+669MAnOF+4FQ1XT4sR0/p7lrw2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFldTFvOFhSOWVRdTJkdm9TeGpBRVFYdDZTWlh3bGVKaGp4TjdESUVrNHVh?=
 =?utf-8?B?NlZqckdVNHJpeTNEQ2kvaWs2Zm5OMmpsWFpCajgzcEgzaTQ0cWkzRXhFV1FK?=
 =?utf-8?B?aHVVN2tLOHNHSjVuZ0pGWnhObS9LSFhVR01ETHN4Qm9YQ1NxeGE1Wm1yR09Y?=
 =?utf-8?B?YU00UFpMMTUxcnJrc3pIVElpMFdEWDMvbWNWNDNYUFgwVjduRDluY1M4QlEx?=
 =?utf-8?B?dU0yV0Y1KzNFWGxTYjY0Q0NSckIwbWQzVFF6VHFhRlgybmI4UW9MVWNtOWlv?=
 =?utf-8?B?dHJ4Q0NJSTN3REFPVjJmM2x2Y05kVEVmNlFMOGM1aDl3S2ZiZGZ1cnFrY0dy?=
 =?utf-8?B?aW1ndDV4dWdBVzFyTjdwMHBUcU80ajJXZVpTNTlpOVl1Y0JoenhBU1Z5aThs?=
 =?utf-8?B?dGRsU1NjNWRjUWhwUWNYRnhkNUFDSkViZTF2V0RtQzN3ZmppUVJkZmV3QU5w?=
 =?utf-8?B?YXNySmI2aUlSSS9Ld0RYdUpUVHFhWk9JZXMyVUdYUG5qOStDL3ozN1dwOXV0?=
 =?utf-8?B?Z1RXRjRWMW9CL1g2NDdQWWZHanhJcjNxMmVVVFVVaXVlaDQ1UzR2TVBpUEJV?=
 =?utf-8?B?clBLSlBKQU1kTzdlcjVPRFRVUStPc2xlZHhxamtoMTcrZjdld2ZkZGNMTjRV?=
 =?utf-8?B?TGYrU2g2dWh1bGY5MFFPblRja2FscE1Zb1hWV09TazNDUDZVbVIvL1dxdjNu?=
 =?utf-8?B?V2NLd0l0dkQ0R1JXT01SdHRBSXhVVU96TnlINGxLQTVEUm5ON0pQc1JMaDNR?=
 =?utf-8?B?ekN3UnU0TDduT1AzSFFvUC80NVgwd0o5bVFTK0FqNXpjMGZlbVQ0MDV0TXdS?=
 =?utf-8?B?ZHFDdGtnaU1sUUR4dGhHdUpuU01mRzZOTFRRQW5vT0FzVndWRDA5UEN2SnFa?=
 =?utf-8?B?OEtWYnR3bE5nb1JlSUtmdWhsVUJmSnRSUURDS1Iya2pReTdYVzRubEtFUjhZ?=
 =?utf-8?B?VGUvMUR5ZldVY3ZHS2t0Y1lBQmNWUjhZTjZzbHNyWmY5a1JpR01jUEFFM2RK?=
 =?utf-8?B?eUlFMk8yMEViSi9yVGkrUEhpWWpyV2FYQWhJMlZNT2p2aW1HTWtuT1poMkhl?=
 =?utf-8?B?TnV2Q1p1Nm1jS09DVGI5NWlxc3ZRZk1FTGJ6TDBOamRCanFWcjErd1NGcWs3?=
 =?utf-8?B?eEk1d3NhSnF3cnJ1SUM0M0poYTUyTzA5VXppb2drem4xNWxKNGhwQWx3cm5P?=
 =?utf-8?B?dDIzU0dZaXhWVElTUXltNkxLbTZvNWlCa1dmQjN4djRZU3piQzlHMEdPSG5q?=
 =?utf-8?B?M0tpWWJDZFBhbnoyNVAzdFBIckpvcXJ4VVN3anBMU2ZVNW9hb2htd05IeHlp?=
 =?utf-8?B?L0xoaHNBUmFJOFVPb0x3MGZuMlFSbVlOR3ZpNlR3UEk0UjFWc0FrZGoyekFN?=
 =?utf-8?B?MGt0S2o0L0Fqb0ZZSVJBQlJHbzZPczdZMUwraURYMUFZSXpYb2dVUXFLRkQ0?=
 =?utf-8?B?U0pzemNFNUM4aEVPY2dxUS9YclZ1eGN1QVFaTUZCUGVtWDFGZ2dMa0hJbDIz?=
 =?utf-8?B?SFp2Rnc3eDQ3TlpIU2tQcTdKS0hMYlV5RUg2ZUNxMFoxcVM2UGdxWXhKeHJh?=
 =?utf-8?B?dEVpcXd5MnYzeE8wSk1ldXdCZVpoTFdFd0lTeTB6UTlldXI1d1dNL3dmUEtO?=
 =?utf-8?B?V0RkcEJXVERGMDFURlNoRkl6T3R1V0VZOTZtdUQ0YmZoRGJJTThtU0k4a0No?=
 =?utf-8?B?K3o3aiszYStlNHR1c1Z2SU12K0FHZk9CaDBqQWUrUEkzMXpiRGtVbG1aczBR?=
 =?utf-8?B?RXlDa2ZNaFE4b0RhWlNJeDZ0cjRhbTRYeEpya3J2V05HOWRLWmpJRlRXVmJi?=
 =?utf-8?B?amxKREJBWlA3Y05oakJjS0hkMlI5TE52S2E2akhuVW9FTnRoRlVpTFNDaSti?=
 =?utf-8?B?NkZFQnRzM3RYNzJ1NEpqVXpnZ0ZlN0twYktiZUNHNkE0NWMvUmx2Sm0vRkxs?=
 =?utf-8?B?cTNNUldBSDJSTUZDUnF1Q0hyZ21hY2gybGVOcHJHQ0FIS25oOGx5bnlLS2No?=
 =?utf-8?B?SzJ6M0lYSXVBMzBwTmVUZGRQV3Uwa0NDdUtLYk1YRW92WEhIUm5YejhYSGZI?=
 =?utf-8?B?V2NhUU5Kc25kQVZXK2Yrd0VIY0ZsNGorb0tZeitFUVRIcWhPVVpDclNNMWc3?=
 =?utf-8?B?L0diV3FTZCtXYTJJbWhKWHFwZjY1TDZ2M2UxSVlVSzFhT3VjSllYT1V1bUdY?=
 =?utf-8?B?OS94eU1QenllWDF2LzFmaVFYNFd0VS9lQitSL3RLK3BOUFVpU0ZvQ0R1alZj?=
 =?utf-8?B?NlVDczdoelVxbVpMUjZQbFRwT28xUUR6SjFvaXYrQTlSdkpvQy92eFZjTVRp?=
 =?utf-8?B?MnQ5MHpYWnU4aElqVy9zd3dOdGcrNU1HcDBTY1JDeE1hU3pISG9GQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ac2bbe-0213-4d87-d033-08de7826b48e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:16.8535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uB9jpDPyXp6yP2m+52xQ/Ui3Tzszin97lIN/UMkmIhKyb8hL+KOsAhTlkxIwF/s6PledBjEK0GY1xoptMlw2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Add basic SoC support for i.MX952:
- Add CONFIG_IMX952 Kconfig option
- Include i.MX952 clock and power headers
- Set CPU speed grade to 1.7GHz for i.MX952

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: David Zang <davidzangcs@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig       |  9 +++++++++
 arch/arm/mach-imx/imx9/scmi/common.h | 10 ++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c..716940930a6 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,15 @@ config IMX94
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
+config IMX952
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
index dd4675402c7..c3610127dce 100644
--- a/arch/arm/mach-imx/imx9/scmi/common.h
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -21,6 +21,16 @@
 
 #define IMX95_PD_M70 IMX95_PD_M7
 #endif
+#ifdef CONFIG_IMX952
+#define IMX_PLAT 952
+#include <imx952-clock.h>
+#include <imx952-power.h>
+
+#define IMX952_CLK_SEL_A55C0 IMX952_CLK_GPR_SEL_A55C0
+#define IMX952_PD_M70 IMX952_PD_M7
+#define IMX952_CLK_FLEXSPI1 IMX952_CLK_XSPI1
+#define IMX952_CLK_24M IMX952_CLK_OSC24M
+#endif
 
 #define IMX_PLAT_STR__(plat) # plat
 #define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 2ac2a93e796..538190e23b7 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -153,6 +153,8 @@ u32 get_cpu_speed_grade_hz(void)
 
 	if (is_imx95())
 		max_speed = 2000000000;
+	if (is_imx952())
+		max_speed = 1700000000;
 
 	/* In case the fuse of speed grade not programmed */
 	if (speed > max_speed)

-- 
2.43.0

