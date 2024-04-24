Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EF6C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF03188DB6;
	Wed, 24 Apr 2024 10:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dKbGlxro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0786F88DF6; Wed, 24 Apr 2024 10:12:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96B888DB7
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVvKhCt7DSHing8v2OnLwe5owHYzrafrm+l6lnP0j7OOF0DC5/36O3l6S8As4JHcgtLsMQ5jhlxWgWGCaNzhwK7cg46FpgAkdlwoJ3CN/Zk3lx8Wn1Ggki6Uvz+XSRtA5mXy9//w1koQumTmNMHNyZSAIqAxSYg3PWHbJbZA05bYineUPrRCcz3yaFrxqNCscC96d26rZ7ETz0+VHsesNV7XQaqlKbjy9SwRGX1uMJU+PdO8lTyRTb6CIqIXA5pS45jXNjcHdBvoBQoggaGZJeJt1/XxGn8TCBE9EfPS7NGt23v2wRnGCmUBEC5TTiZjF8cnTOFVtsYG+V2NQx2Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ71DykKcC3T5n87MrehG3WMVv+yen2q+x8EAooVYEU=;
 b=IGsr9mOhyLzhMQJSXYFlSwoaRJftaf2RUE7yLho0m2uORSP82eysx9WhUzPV6kKjkjykUZz3yT7d9Lu8oUBFoq23gMaJqysq+B1iJwhSLQpRigE8Tncx/zKux6cn+K9INMyDc/6DSygde1BTM0otp2DAqhw9+hOv5j84+sCEm0HKa98ZPnbeRATFubl/WptPNTr446VhR1tZhYehx9yvTr2ZV1dZWQl4uZu+iin7mToshs2j5SAR+Tan6wBzzo2D7SLquKsHsMk5fKPIwzlJOUsbzNWFijJwthgfj7FfFjgoj/4fz2zB/2iUOZ+wD4pcLmCI4vP4GlAz9SQjgtj9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ71DykKcC3T5n87MrehG3WMVv+yen2q+x8EAooVYEU=;
 b=dKbGlxroO+vFlw6pfvb0YvSc37MZ82qSH3EXz4ThjVuHcNYNnPq87E4B2//QUCNxWsAeDV94pyMdPR8V128MY0yeuT/ucUf5Roncy//Mnj13lk479Krum/uR819jNxFYgTDrcTFFnSzCTcmhRqBQ7zJzzG0sXNl1TMqkrLTMexE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:12:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:12:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] imx93-11x11-evk: Convert to OF_UPSTREAM
Date: Wed, 24 Apr 2024 17:12:20 +0800
Message-Id: <20240424091222.10843-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a0e866-988f-4467-706b-08dc643642bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMDZ6mPx1YyO5eGDy+ur/Z2bVqFOeS16CYSw/Cz/9sZFtUojkVUriNxOFjfg?=
 =?us-ascii?Q?blxvQuH/iIPfz9X8t95mWXm+tjlMObO+ytuHWcJsfXYyWWjDDAHBHZ15doM/?=
 =?us-ascii?Q?0ouyTnT3CELNK/TQR5DDDoSWn1MMsKT6uSWfto+6S/KjjsHQPF61lv/4WOxY?=
 =?us-ascii?Q?TmJ6ECj/Owk+DpV/yx9RSiH1mpxijiwQz1ZMWTyIduiKDxP3j+ZfwXcRIHCa?=
 =?us-ascii?Q?S6HwYIErghT1CpmIKSYveRmpWYA+K0VLPpyFVS3BoiTqvFmBjn5niMbRFJra?=
 =?us-ascii?Q?Y2B7igfkQMbS2c7ajuuPZRQBKy38Bp3sndS1jdWh3oLM6/twu6vH4wFa3TB1?=
 =?us-ascii?Q?zk9jhxHXB+G7hJIEM4XKNKIIvdMi8HfBrAGxwW5j9qJANKARfaeqLVjfprOY?=
 =?us-ascii?Q?SW1U6oQYv8lMmSNYJEU7icnJ/wEnklE/VQw26QDaH1XY2yF5yfTpwUIaHzi4?=
 =?us-ascii?Q?VKvvsPs5hqdjce4kzhbzy4O0d5Br10TCoMt92YLeFtEazfpCIBbDBPU+hueg?=
 =?us-ascii?Q?ERgKrxtBmae3Zch8MSx6FE9NqLiXkglOkRZGCwObcdyDlbL/aWmCflX+XEv7?=
 =?us-ascii?Q?Y+GA1DRruNRawqaXriBYbu9qPkFNCa2EKszRamwkhXs3mcqBh4stBtefuPhD?=
 =?us-ascii?Q?NRu52R3912nQGBkwBIYTapVwzI4d2cgn9o+qGbX1rcLTMw3dOtswRxtb9uPv?=
 =?us-ascii?Q?UF8i59+WMASh4LTq+hBCwMscIPO/7G9ex2UA4MNvabnB65s7mp+yALoijA18?=
 =?us-ascii?Q?mZwv+Cd0CPJv9PJnU+6EhqGiVHrEy9gxPdHxyDul+sdTGZKt4DVLZopakjRx?=
 =?us-ascii?Q?PO5garYDrkzrRTXKJlgihqdYcIpRvkYd45OmCBUWnS/ltn8fycEjEfZuL3GR?=
 =?us-ascii?Q?CKRHucjFn0mabxDJ4wSq8iVdA2PfxMdpJck8lCr2xXyEJFdKm1ddQErthqi4?=
 =?us-ascii?Q?vA1fDWk56HiHDWtJyE0t+D7PqNVb6RDOrRmxULmDhK3jk+JfzQ1YAuChUlRO?=
 =?us-ascii?Q?U/YncgTO29nvQE0OaEJmNJroHAbZMvBcSv0OeEHF8VIbWlHGhWB89YIdWSOj?=
 =?us-ascii?Q?KJubMlqAwspHxlu69b5Ip/Dv+rMS72e10/Atg6xvvUELXBGg7K9zF6d3VF8B?=
 =?us-ascii?Q?WrR9/O99GlNy2roXagID2uKCQ4WNS+3eOO5plYrGKYcf7KABoitikRD2cNtp?=
 =?us-ascii?Q?W26bVCdo7R9NHLSe9PBtesdeije1SAMn8APzqNzVPe7DuUynKRROtzNgLlgQ?=
 =?us-ascii?Q?m5P26G+mrmcFkfE76Lr50to6qt6EXPPxIL1PrS03DHJ03oQSc2PP+uSmRj7e?=
 =?us-ascii?Q?L4He22rL8RQ6jpTzGH1GD61hyftRY+8p6TU5uC5PLvcxWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cEEkes0ckaMvP6pEF6EnT6eaJ6+m3/9Cf9AbPA2aqK31k6OpFXHrFp667t1d?=
 =?us-ascii?Q?cnL9ldFjK276NH8DYWAdX5MEfb7ZnNjOkqhZu5wl1B522z07SZdEUL4rjx+J?=
 =?us-ascii?Q?qS0SsBmw9ayi7pYd5/iy0vB56aM1/jMzfxtlNWRU3eOY918QP254whlPzAZL?=
 =?us-ascii?Q?Z61TPJOeCYvbXqX9uJbur3B6HSp5SEVVhMs+9V/UJvg6f+Zn6+oGXbal2J0n?=
 =?us-ascii?Q?9DrikPV7+YR/Lba5RRia/6dBDNuFi7VjaTc6oO9onC+Xy6v14MwpD9l/SSrp?=
 =?us-ascii?Q?U3mw4ehzDXTuJX97dncE04oSl5nPATV/Tei1HJd1pU7HXfgBvyFZgiedZpoG?=
 =?us-ascii?Q?7ljq9fmaont5ThIrM+MihY9APMI2Ai2f+73sMpoiEkRpF6cFAzpGA5W6ob5P?=
 =?us-ascii?Q?KxzZg4pb8ZqeqjiFERNIvCeigpvEMldY9AhgY+ufRuFBMqpqf/x0WEb378yA?=
 =?us-ascii?Q?w5rjwCr3a5zw/lQmcbTRi/y8B+coSZYVxMM9jN+HJIsLyJjeAYEyhEIWmapp?=
 =?us-ascii?Q?o7JTsso340bN5gBF6U3EV016IITR59lkUkskiRV2LjyLwS1hp0tgnw3GiMgP?=
 =?us-ascii?Q?U45oXwqVA14yyjYZ1m+grQzvSoH2oNP2GZBCsB+j9BRaTpbILx4PZ4jw5CfK?=
 =?us-ascii?Q?jTn+a6/8nP6VgOLQ1Qvlni8vFwgzleJVKH/7x1Ag8xTshXMuHn26Jvs+WnJq?=
 =?us-ascii?Q?n+wZEa+jllkbSU3AaP3pO2kIztcLRDywkZxW84vGnk5cmQQR/C1vEbaG5OSL?=
 =?us-ascii?Q?tnkkcc5N/yua7xBZzc6v/geONfFLj9bKYL41B35Zrfc6xwWn+ogwmnfO/rQd?=
 =?us-ascii?Q?fJykSHIjc2J+5isdE8LMeO0CjZ8kWFr58hoCYnKsnQYtwKhrtSaK/YRa9VXh?=
 =?us-ascii?Q?rcXfU+IbTSUwx0DQ8OKy2wV+2db7LwX39UxCfUwYg9yXO5fd6ZHYEESlKqZp?=
 =?us-ascii?Q?QChUZ/KBC+55RubZzKiGoRh7h6WJ9LlI6I37RFcx+Y+odZ2/AKAySg+/MXsX?=
 =?us-ascii?Q?kEBCTXBMAe5mUqfQHfACa7neqMy975OPjbPICqiozaj/Rhi0qIZxHOcEnJT2?=
 =?us-ascii?Q?bwZ8ei2icxw1HIslSP3V8y2J2RF6K9+hALKirPD7dCoRhwRUh39ifBLTdHw8?=
 =?us-ascii?Q?2IIO703kRNExu3Lk12zUzmXcAm9ieidWgHBIKN4dOltejHe1iojTAdLIaHXc?=
 =?us-ascii?Q?GUidHmvz4GSMtUKAN9v9XXSNO3bMuocLmwIMRrrcR5sDtLXMZOkxSPgFk8c1?=
 =?us-ascii?Q?5VXizJ2eTbICXY8/nq6+pzwIJwnzs6SaBhNYXnF/9G6CZu/z4KaG1Vl+8vF9?=
 =?us-ascii?Q?KTsq5sgYxbWAhwvPHBebWVlwWiV82DhA+BEvnHz3cXHjpp/eTn5VUV7n+2wk?=
 =?us-ascii?Q?QmkYWhHOk5sVAG3MyNZD8IbgAub6Qm52dsRlbbUMN9QToXw6IkiSORIhF05n?=
 =?us-ascii?Q?4gsJpd9NvBkJRXbKAEEH9fK9S8DHP8Lv4bzLBbmNfYPpwDDJugoIfzdl+6m9?=
 =?us-ascii?Q?KrHurx/d3tcyDKphJmYQ6piR4bscfg2L+vB2wEdbdL9ZvVaY9VLfJg7jDLbG?=
 =?us-ascii?Q?6Z8Ep3d2sYaarLrSRtcf/ittajlgSa3NqAEbRoKM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a0e866-988f-4467-706b-08dc643642bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:12:19.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yR1peXrlgAhuu2OG7rATcIR2fSd9dBSxqCPgXtnRTNqNS/1j0b7DtAqnnPskZ2HivQv8/hp3YB+hEdvFvv/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
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

patch 1 is to avoid build break when using upstream dts
Patch 2 is moving to OF_UPSTREAM

This is a resend of V3 imx93: Conver to OF_UPSTREAM patch 5,6

Peng Fan (2):
  dt-bindings: imx93: sync clock header
  imx: imx93-11x11-evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -----------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 include/dt-bindings/clock/imx93-clock.h  |   3 +-
 8 files changed, 138 insertions(+), 326 deletions(-)
 delete mode 100644 arch/arm/dts/imx93-11x11-evk.dts

-- 
2.35.3

