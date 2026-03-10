Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C965FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FA98403D;
	Tue, 10 Mar 2026 14:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P8nju2zJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA6783F9B; Tue, 10 Mar 2026 10:13:55 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1656583981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfP0k5NTuvAQJafw/fH3ppqu4PT2eOqgzt7uIjpQydrI1pX7JB2q5a8qyIk+nvhKexXqIE2eLzS/8pqZgwADH8Z/oD5NMSMa4p/1VYTo89yxCJ8Hr7Rub/l/39DhLzpsnV6TtPz8MIJm/GY3hGaOTAk4dTkFxXnCQ8KJAjOj//edUT4GgrYVdYP63vNlDjmFSptiF0lhdW2kjzquI1uNP4Tv9NP4k3pCALDaJMsCsi63CgbEAppyGN9ynAl68AzK3a1aUhQamp6vk7Ti5+Wou3xtkeBwrYFjsRNmlztvFdnYUF0pmjPw7+p9pt9EFg2x+kbMcVyiZ7lnGNy9Gpgwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zMDb5FtYZn9eqnAZ87vTB4gwg18AHaWF+hawHcY0io=;
 b=qHQRzKkSO9r8ZN6Nyb3C/c2lAVR05KLtFwFX+G02LqKEAmCbDepLUorFm4Odo8SjpH8/Iirtl3HkTELzZSts/7BsfohbSdyGYnNYU5jsjyL0jFfevAZlfLEfKXx5OmwX1F3J3bUwZvH2yNo7qAAIIZdGn1Y5J7Xq28i5mDZ5kcK9Rx7HgV5hG6ZpsHCB5imjsCQn1Xz53f27MsLm6E8LcQggGqyGUxPkcOa3ZmspnhktNGTSHG9gNTLXNX4hl2zaMtMF9bw8MlJ1F3V2YlarsG1ewjL4GxyvJeDh0G7V4/USb10/k7OFAxY9tUq8wM7B5+PlLHcua4M4d85ImvOtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zMDb5FtYZn9eqnAZ87vTB4gwg18AHaWF+hawHcY0io=;
 b=P8nju2zJuWzv6OERxwUfNFCVeW0EaIO6ciL44e4r9IusvJBu54G2WgpxLdmsc5uTaAhTqv/PnP+QLvwcTBSDB9Ubzcs6sNQRXq2TlnhU2y+a3QsoLceTpcGNyEAlocxJYQ7sEyuQ3l1G27P9b/2N+d/ylh5iq4ToD7PJKsVsjDN4D3POpYz/gYEy9XVjknHBRD2TTUjWsGMCOonlwHGEh4OhiUlvTGFWaLVDmPuMakRv9Vb2l2m6ruBFWykvD/I9uLeQkfHejHmrrPaMDlnuAffzJ8Or+RhklAhJTrgmZ/2i93wN1FX7sLitvvir/Fw7i/onuvk63RlfP12S7aNrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:13:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:13:47 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 00/10] imx: Switch watchdog addressing from macros to
 devicetree
Date: Tue, 10 Mar 2026 15:53:34 +0800
Message-Id: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7Nr2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MD3fKU/HRdy8QUA4tEi5REy5RkJaDSgqLUtMwKsDHRSmWGSrG1tQA
 D6iQuWgAAAA==
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcc6c8d-3c09-4a4f-96b4-08de7e855626
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: iPMNnAJei34RAkkvIzZfqKnE0hkncFmciR1cnTcVT3G6X6XAk980rdVZEFWHEmh3mM2OeD3fj5tK0br++bzos7C+tF9d19Mgm6K7DVebwfUT8uW9R57wISn2w+xip6LMtAZ9HgZ2Bl6djm8HgqGPGH3AyhZ7eakdBJmhRzfK46fuuzs00mJApQahUdDSjaIsac/KNm2hHcpmdaoHRa/aXzx+l6uMuMWt1Ghth6Mc4ZzAHVftQcZ9A0AaRVbPpumcj51DW1HeBogEfUTvBQ+UCN/P29gUkYngIqQOhctReDJ5kaDRlCVqVOp2P9l+aF044ZsBDNbFoiqIwCnwBfbk8BkMJsc9kF/AWx0uIJ66SC+DV58WfB9DfRwS9W6pABpTHRraPwdqmplm1V8T01Ig1l7b26+UWInL8NcdHfFPxOyzZqY8sXiY7Riu3LVszE6CWZqo6RzuVLBS7ey3TLXvZ4GwixiAhII9UxvoF6smo/44wLqgrvyM3tdN+K6CIkHJykmBgxD+UwcNh9K8UhYv6fmn+HZGD5ZwQAJ71GzyegGIobfY7IjLQBLL/W1myK/h+urAI1Jujjk1v4w4lCJU/q4WJq/0lIcB3Luo5+fcjrum/zLu6X8IKQ1LUCP1xGluTVLABFQYsdT16tfmMCrPWDSNFxXNFd4oig0izODxQ5YODhtur8ZCJMudKA+1wjHvEJ4fFP0bXqg6owI4HYWhZcuEZCjnOIa5yBUmQMQKpSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJPemVPZlJqSUg3WmlvYy9DUFNBWkpmUW9aKzVuSnV5Qm93VnVkcFI1WlZY?=
 =?utf-8?B?RUZMUGNhd1U0OFE5dGJNaTB4cHN5WUVWMFlxYWVDUExHMUw0Sit2eUlQWVVI?=
 =?utf-8?B?YUxZcDRBaUowMWdsaFUzc2VUeFBBQjV3UW1hczA2S0VxaE5tWDQ3blJvNVI3?=
 =?utf-8?B?TGRrbkcrSWY4d1BSQkF1QUs4M1BqaUhIL0w1R3JJQjlna1laNk5BV3JGY3g4?=
 =?utf-8?B?bkVvd3NzMGFiR0NpT3NkQnhicDU4c29CdWJrclpyTzV3cnptelFPV0VqYVMy?=
 =?utf-8?B?UmZXZkdpTXhSNncySnlmZVAwNmllOXc1R3ZycjJhdzFNbFV5VGpreDdZNXdX?=
 =?utf-8?B?WGdsUVlDRUpPTGZkNS92SjNBL1RhYnUxMGZWREVIMUpURWpTYVhWK1loMDRS?=
 =?utf-8?B?QS82Y3hJeDJtc2NkL0JveTJlUUlVQ1pMa09laG9sWlA3Q2JBVEVTeS92THYx?=
 =?utf-8?B?bkNGZUhncHM2WVdSZ1oydkJVbDVPQVZjS3Y0Nkllayt4QkdoY1g4aFBuMEZH?=
 =?utf-8?B?aEU4cEFtZGlkL1NucVRENWY5MTh6citwaFlRaEp0SjNoNVJQa2ZkUm95c0hQ?=
 =?utf-8?B?QkxaTEZ0aXRnZitmQUMyVThhUXZ6R2JBVUNrakJRbEEzL2gyYVpSUDhUckdz?=
 =?utf-8?B?WnZQVXg4UTlQVFhpSFRIeWVOSExtTG1jQXlFQitKQWlsa004NTYxVFVNd1lu?=
 =?utf-8?B?V3ZVS2czTzErV3QrKzQxdnQ2NVI5Ry9hNGJnQnBkeVpkbDk3SmtZelVQc3M5?=
 =?utf-8?B?OG5hbElYLzVZN2FEUVpyOGFEdDNxeUQ4OWFrTDlEbWlGeTQ0NkQ2bkhaSFRl?=
 =?utf-8?B?bjYwZGlpMGZzVWUvWmpza0w2eHhDaVhKZlNiazgzUkdBYXFibkR4dExHRnR1?=
 =?utf-8?B?YVpOTitiTTg5N29MT0ZKMDlTMDU4OEdPM1B6OUNKMmJtbzRwMUtvWHVVRFhW?=
 =?utf-8?B?T1U0WkhkcEZlYUIvZ3pOUE5hTkJnUjVUTkE2M2xTZ2FVU3lSQmQwVmVPZWU0?=
 =?utf-8?B?YnRPb0MwYlYvK1lSNlZWYnMzbmpub0d4QlYxY3NKYjk5VndTb0phOTRkKzBj?=
 =?utf-8?B?N1hCM1JTSlZSV1BJelJ4cEpubEliN3VEZ1h4akxiWDZSdGJkZkh5S3RiRVhn?=
 =?utf-8?B?ZVFzc0hYOGJLOEJhOStEcTQxcG5xNmJvVGE3YTdkTW15TUV1Qm10U2VkWDR0?=
 =?utf-8?B?QTRVQXY4aDFpSjExelJzUDhVcGRGYmFzSXBMMmc4NjE4YUtLZmJlc1AyK2NS?=
 =?utf-8?B?Y3FFUHpDZXY2NUpGdGQ3aFZJT3NEcFk4WWpFdWR6b252WEg5QXlSRVp1bWw0?=
 =?utf-8?B?SmtJRGFVZUR6QzQ2eTN5Y1doY3N1djJIdGNrenRFRjNOVERqTDV0NDljSGdG?=
 =?utf-8?B?akRlT0lEd2NSRUZzN0RqV0l6R3BhdW5mNlBPbzJYYXBRSVdoM0ZneFRnTyt6?=
 =?utf-8?B?ZTZndTREZENvcjB5aWZNdWRHWGVuRnJ0aTNRK1ovTjRIYlV0aUVoeW4xblNO?=
 =?utf-8?B?dExYc0kxL2F0SDN1OGNLSXg1QnFUeHJ3dXZHWkdESVRCUlZHbFBjYkcxSXlC?=
 =?utf-8?B?blAxNXRBTkNHa2R3YS82K1paNU5VOEt5WXh1YllJU3gyRldYcjFxeGFrQzZ0?=
 =?utf-8?B?TlF5VmkzTHMyZDBxM0hnUFBzNFdERjBpSDZWMFBrMzlVdm1ldldNL1cya204?=
 =?utf-8?B?UTNING5OZkdLSWdGY2c1MFBrOU5selFBbjdGVHNLSTI5d2dSdkQ1dnZPc3VY?=
 =?utf-8?B?RUJnQzVDc2xvWXdYMDJLNHF6d1krOFM2Kyt4VktBUW5XVVpMM0ExcmlYWDdE?=
 =?utf-8?B?dE5ESWRyKzV2eWRYZENVendWMzdsUDRkNVhrY0pmU3FGVkZ3Qy96dXllRnZy?=
 =?utf-8?B?UUtUNHFRdVQzbU1Ydmc0UUpYZCs3Y2REdnBZOHh6N1lqUmVPTkhnNW5YZThp?=
 =?utf-8?B?UWVxekZ2WUZaRjc3d2RJRldDUVcrYWNET3czYTU1TGtTczVveWloK3NoYTBz?=
 =?utf-8?B?R1ZuZlpBMXJpZWlvcHNjSEhrREZJcEVwQSt5NVhpdXV5ZXpTZG1wbjh3U2Jn?=
 =?utf-8?B?WHZQbXAzZWx1VFVFWk1yd0hmRjRENUFMclJyRzB3QkhrVnprWU56SGdXMHZJ?=
 =?utf-8?B?MnhjcjlBdVY3am1oM3htN2lXeEYrK0R3ZGZyeWU3RUZiZlB2alAvUmpWVGY0?=
 =?utf-8?B?bHl6RE9RUGIvLzREeTRVSEhtTEpBWUx6WEFQVFI1ZGhsNlo0bzhQSTZTV1Qr?=
 =?utf-8?B?N29vY1RFOW9URTArTTdlclVhMmpwc0ZLdHl0LzRTbTFFRkE3eTQ2RHJUTXha?=
 =?utf-8?B?cjNUSlBuRS9ZNlExT3drN3ZvejVRYlhXS0pVb001OXh2bVR5ZC9sZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc6c8d-3c09-4a4f-96b4-08de7e855626
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:13:47.7030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrNkLEQro4RusjzhJbieoA3qUgIdqlqT/ntr/XT4LmBX6gKGeFAG59OBpJlF6g/mhcQq0Vr8iIi0B/W8ylvPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

CI: https://github.com/u-boot/u-boot/pull/902/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (10):
      imx: Add helper to get watchdog base address from DT alias
      watchdog: ulp_wdog: Get watchdog base address from device tree
      imx: soc: Get watchdog base addresses from device tree
      imx7ulp: dtsi: Add wdog1 and wdog2 nodes with aliases
      imx8ulp: dtsi: Add wdog3 alias and bootph-all property
      imx93: dtsi: Add wdog3/wdog4/wdog5 alias and bootph-all property
      imx91: dtsi: Add wdog3/wdog4/wdog5 alias and bootph-all property
      imx943: dtsi: Add wdog3 and wdog4 nodes with aliases
      imx95: dtsi: Add wdog3 and wdog4 nodes with aliases
      imx: Remove hardcoded watchdog base address macros

 arch/arm/dts/imx7ulp.dtsi                    |  8 +++++
 arch/arm/dts/imx8ulp-u-boot.dtsi             | 10 ++++++
 arch/arm/dts/imx91-u-boot.dtsi               | 18 ++++++++++
 arch/arm/dts/imx93-u-boot.dtsi               | 18 ++++++++++
 arch/arm/dts/imx93.dtsi                      | 21 ++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi              | 21 ++++++++++++
 arch/arm/dts/imx95-u-boot.dtsi               | 19 +++++++++++
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h |  2 --
 arch/arm/include/asm/arch-imx9/imx-regs.h    |  9 -----
 arch/arm/include/asm/mach-imx/sys_proto.h    |  2 ++
 arch/arm/mach-imx/Makefile                   |  4 +--
 arch/arm/mach-imx/fdt.c                      | 51 ++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8ulp/soc.c              | 15 +++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c            | 16 +++++++--
 arch/arm/mach-imx/imx9/soc.c                 | 17 ++++++++--
 arch/arm/mach-imx/mx7ulp/soc.c               | 16 +++++++--
 drivers/watchdog/ulp_wdog.c                  | 38 +++++++++++++++------
 include/configs/imx8ulp_evk.h                |  2 --
 include/configs/imx91_evk.h                  |  2 --
 include/configs/imx91_frdm.h                 |  2 --
 include/configs/imx93_evk.h                  |  3 --
 include/configs/imx93_frdm.h                 |  3 --
 include/configs/imx93_qsb.h                  |  2 --
 include/configs/imx93_var_som.h              |  3 --
 include/configs/imx94_evk.h                  |  3 --
 include/configs/imx95_evk.h                  |  2 --
 include/configs/kontron-osm-s-mx93.h         |  2 --
 include/configs/mx7ulp_com.h                 |  3 --
 include/configs/mx7ulp_evk.h                 |  3 --
 include/configs/phycore_imx93.h              |  3 --
 include/configs/toradex-smarc-imx95.h        |  2 --
 31 files changed, 252 insertions(+), 68 deletions(-)
---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260310-wdog-9ad08a8da9dc

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

