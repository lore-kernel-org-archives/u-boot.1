Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C2CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 06:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E501D8359F;
	Mon, 18 Aug 2025 08:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dN+KC/qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAD8835C1; Mon, 18 Aug 2025 08:01:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CAE83559
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcRyMMVWd5doFTh9G+XY7QUck/l0NHpANtVcKBqfTHbSmvLc48X4FIdlEJwT/iFdBYXfdmYdUYkAtRS8cezCkJkVw2ETouYXscRLYpPchOZWx74fS2jNDv9mpPsXP+0Tp04QefL55q5Xye6ypK9BmQm9pJoddxx006o/3hiR2S+eS0iGKXCHoGBH/t/a4TKgGuJ4gC3gS46gZ2q30m/thX1Y5f98KcxIMqsIDb2+Cpka/+9wt26GtqM7GRotgrgFVaBll3deHISdkvPWaXt5+M1baW32mPwKTUY/5NP1R5o4BTs+DZtI4QTV74LaCoAIH7KHzKqXb9cHi5rzDTMEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fsLjxWaCAQVKV4iCbleAvgEswc4r2qRJQ2TTMGyQ0Q=;
 b=aM6hcBtKfIhdk7+mMZXqpVIKGJykvSBapZcIjHvOWM3eFwzRgDJGCjJtP6wA0nCcmOoRdXWHqmyEaeur1Ic1uPu1VEPaxQHbkdSGDPabbbqsznoncR5sA1Qnvx7+cSpnYTBljqLqTtMFoOEZQvafMJ7ixreRYM793ixMDFjaM0cb2LMDaSkQoZbys+cb/k5oymaW9mPjJrLe+3tgtG9b9NbCqvwlHhFSz3C/kJEFVZ5tN/iWbWOkoxialYjmbCIc4mlRHe5/6e7EtBMDsn/UMiVlQeqlzAqLcY34+4PbugrHyffQdg8wDYyRyJh7Fxy4lia8mrK9VtSZK2Wf9jdECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fsLjxWaCAQVKV4iCbleAvgEswc4r2qRJQ2TTMGyQ0Q=;
 b=dN+KC/qPZ9eB4NwI3QT+PDOgKZxmG8HUtXEtku0TqEctTpIDGJ4WLY1elZmYg0pZlQYfZuDGCgykGoMf7Q6izCDtHLOOOdWjSA3DwS2XxZ3b+31m1BtkkjL5JNfTEhszfTzRqnBgwUGuaA8qeIWYmhYwoz5MzFXw5qDoSUGBIfO8ECENG3U68PHZigm/ajMk78zRfMWRbcY3+jIJs8Q196Uo+ej1O2znc9BdS3wBPSwiy7fBCy6ur1LtnfFMGq2vaZCUQcWICiXjBsX1Yjbj3BxUqcNVQHxz/i15WaJZVcJ/Gn8V6vP2Ya/YBzjSx0JCEeaPSJVpX/rpfvTnp6pDgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10440.eurprd04.prod.outlook.com (2603:10a6:800:218::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Mon, 18 Aug
 2025 06:01:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 06:01:00 +0000
Date: Mon, 18 Aug 2025 15:11:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
Message-ID: <20250818071145.GA25272@nxa18884-linux.ap.freescale.net>
References: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
 <20250813-b4-scmi-v1-v1-2-bef20fc32d4b@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-b4-scmi-v1-v1-2-bef20fc32d4b@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10440:EE_
X-MS-Office365-Filtering-Correlation-Id: ee84788c-d979-49b3-d502-08ddde1c9a68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UAy+Tl+NEcGjghKHXI/NDEiBuCmubwgLVlMaNk4KEOOMh1nYgPVjO3elp5P0?=
 =?us-ascii?Q?ninzRX35mZRV+3ZkNrHa2WL0NNw92y7cogihd/iejEijPoAHE/vRSxw98I+T?=
 =?us-ascii?Q?BBJOkHsl4jK3GeOjzWQZqBHeiFlUmP/U9qixaSNtFHWRaROAy/RLDUjFyQ0e?=
 =?us-ascii?Q?ea//uio6hioN59Ljin2QqofM587pYBrKG7Q1itEueUDZN/8bU4sOexuoKcob?=
 =?us-ascii?Q?vjeE28Z7vQZp+LCJ1t2pXSOuyt87zw/1vPHu5j8Ck3XL5gqcmRhIx65F/olh?=
 =?us-ascii?Q?8qf87ezPWuHUTsNvzbjat9Ugm1+p/Jongk3n8ZsTXaaZQ1SEBvGvzRSsUtqX?=
 =?us-ascii?Q?JQmmbSBPljqvS/R0aA5VnYAW69yeqVCXO9JXrzHbvjgiJNKn8w1yIucxmKsj?=
 =?us-ascii?Q?qcpezxCNrwqG+pCkLCMWacJHwwnhtIYY2WIf9J1tlIUeClPSZr/1jJI+b3IR?=
 =?us-ascii?Q?D0zUtspuM8PAadewIgnLYCLXZTowMWmJdR7pRnlDVouXHES9fyDhQ4WmxQv0?=
 =?us-ascii?Q?3rs/Z28igJJPrKLSJL970fQDAGNSGR9dBZ/95eyg5VHAF0m3ETYuk38m7GUh?=
 =?us-ascii?Q?qnEogMFJ1BUG7ttEgnnHBkrYrVr+1Jm1592+OV8AgpPDbh9VBU0dNtY4BXis?=
 =?us-ascii?Q?37zj5oRyaXrDUvVCvOza2WKKVJdA02UfAL45Ph5Jc7tsFr4hOkAVF0Q5dXto?=
 =?us-ascii?Q?Ferysojq5URWpK4uNy/nXBUi8Ik71ZuixXsfahV37BSZ5dObM6uCY6b/IQWP?=
 =?us-ascii?Q?Pqxq4M19ps9BXeRvieUUN9c6qILkEiTzTG0a+DJVejsMdltvdSeXGMATNeiu?=
 =?us-ascii?Q?L5vC0/jK8TQkXeTVcQ7eiT7DZnJLBYmKV7BVxuVESSSMjqAiMkA/l+xg333q?=
 =?us-ascii?Q?J0Uzldm4xElVNQGOLA888R/9kkvQfzy11BhS4na34fRLnZ53Sj8XVSE+sNDx?=
 =?us-ascii?Q?JDb8ewbJQy7eNdMQyXH6Hv7SGeOBiRqoEySO3+tBiWyWBXTiMytXwPKr1EyS?=
 =?us-ascii?Q?RBjgA9VYVKG2AaRr1m/OmvG5popwU64RFa7C6Q2Ju1xdprpKeO7LYAx9sUOO?=
 =?us-ascii?Q?0O33osksZLxiRfgnk169R1y+fF6Ymg/FgtKnzoe0/ekjzIi7lhZLniPRndPv?=
 =?us-ascii?Q?H/hWqnNYrKpRJgzgA+hQg0nKR4dDsrhUnu2lc2Xq8rqUcJKyoiuew1sQ5WJE?=
 =?us-ascii?Q?3SMzLc+mbNLcQZdRxbi2WgEZgghznRaMJhNg7met3DPjnCy85G5MRGaSdACM?=
 =?us-ascii?Q?mVLui/Z4Kx93dCoqlCBHhUmZDmy08PliLM9YPO6+imHbkD+7TfLclorVybWH?=
 =?us-ascii?Q?0qxMo8UHHa2bgTp9sPxzSo7qa2XS5OZ7aZsHH2f/Wx+7WRfla7iEwhxd8Q0U?=
 =?us-ascii?Q?9J2yW9xHej4sOSHk71AGYhP5k3ewm8nLM+GW+vttPyx48WEyrcA7xYhbK+Zv?=
 =?us-ascii?Q?ZlAoWzahrv7a4jlt7nH8HIOgRaPbR2Z+pK8JGFocZDe4IaMYeJsybg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdsR4Ov1MTwJHUUlgLc+vuzTE4LwX6yOMob+fX5jurI2vZEdBfbAD4tPScu5?=
 =?us-ascii?Q?EMOW575e1dR03kAna5im0Yrm7lKTiO4oC06hNHgrxaCnCMQhVolRaXk63apM?=
 =?us-ascii?Q?E2LsJ5PmPbhdJTz5KA26SvfuAT8wJU96AGIp7xrZ92s8Z1qCpPdaOHtvEuZO?=
 =?us-ascii?Q?jkG0TbKJRwf+XnSnrcWy/s2OgTYEA2fqcpKoShzf00ggRfgmfFUR/NIMQwdf?=
 =?us-ascii?Q?dLcSYCRqe1RCHteQw2D0CUfTLbzyWTrRGhIdeNv/zlUEhUSnxgD4IbRKxvJy?=
 =?us-ascii?Q?757hW4cuHHjjAnoHGdwBQnyfiThKvMcRe7rwfDHtfisn7oMlyYN0bSXZdvdF?=
 =?us-ascii?Q?oJCBIypDS4pkeKGFCk5U4y+evgaU6ddaBH1+gR4CwCujgUE+l1khAQidbMIS?=
 =?us-ascii?Q?AXkCNF75R+9MSWVUTKwoBn/rNc5amHeXMIFWXpkIm5GT0AkSCarjNPjASyS5?=
 =?us-ascii?Q?NrvN1BOkpMwYWC2AvPFmuL2eFw01Cgu9Nr2GlELWCUXY4k4+X5QBXStUzG7P?=
 =?us-ascii?Q?jiiy9A1OnkCWNsJFVMJl2n4ADUMwMwi8dJahW3N6dBHo2lwJQMVuFXuHN8cn?=
 =?us-ascii?Q?iNzSctLN7NjbrFewsvUctyw01/xQzoaIehWNNOFPl1loVtWnsdS9cj5XwA08?=
 =?us-ascii?Q?s31c0/9ZqjZWJITcQKerJvImexknn91n6TeDdfu7cVFcWHr+bee5KKFh+1Pi?=
 =?us-ascii?Q?IMIOkF36qNrGAPOtzzFXZ9vopY2OTHuLNNGH+7wdYmW1Di74WzTVv6f9pyW3?=
 =?us-ascii?Q?pwQXx8mTg/ceO54ci4MIP9xcjwA5qDUKmzNurWgv2TIydZd6ey1h2O32ik68?=
 =?us-ascii?Q?UH++A1TEn2+lPLBgCQJPc1Pueo9w3eUsPWu6ajunO/38zLFC+G3dCwS7FLQj?=
 =?us-ascii?Q?ETGSxwgGZYRln0027ru6TKB9KPSHC87OS57gAcfnZHaxQF+VfVoiqSLlqDpr?=
 =?us-ascii?Q?I/3STuzK6ha5B5GFto6tp75eLZMMo1WcZnFSz4p4P1X3Prncvi/OzjUjwnVP?=
 =?us-ascii?Q?ZfMAssgmffe1dX8mheIGM1ZCNbkOkYMH3dtK0q5+niAytspcAep8+T5VkvfE?=
 =?us-ascii?Q?Tn21TviDJYA26UO/OW1x8z2QP/kJNKm8BvR7D0SBOS4jS9t2JMIc309Kuq15?=
 =?us-ascii?Q?YCJfKV1TcDo1HCwfZWAZJNoP7S2USRUdeI3cwDKfZkeTWXUjSQPUSIxhrNHB?=
 =?us-ascii?Q?x48aNiqGb5WYf2Ngjtl3ZGcVQIzIDPr9uLwTQggAGurueTZ//elO1O/pIelY?=
 =?us-ascii?Q?fL413+vJATHOfY0Bc5HsCzz7D7olC0SvabsMra/LugGPJCHCuEP7D3hg1IQH?=
 =?us-ascii?Q?7Jl0hKD1B3jWj5AnKUa7eGmWe7CPpNGzbsQLtUohZ79E+E8JS4rBjExjFSmE?=
 =?us-ascii?Q?B1qes1qNdOatWzwQY7Nt9aH56DCfvZVE9QCkkpr+Nt3+rDUMxoj2lKNENoh+?=
 =?us-ascii?Q?GjD54v9SZCQEVDRPQ6lbgotdINtMMZ8QK4m6qlmRT5+odgrbJV8E0+gco6px?=
 =?us-ascii?Q?fMS4jCczVsu4kDck0LfrJEVI99uftYPheZX+MaINELMl9pLjsKnPMrTLtxzq?=
 =?us-ascii?Q?HQHcnnV3EN3dfaN/LwHZLyV8sDdzApN90kMXkU3Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee84788c-d979-49b3-d502-08ddde1c9a68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:01:00.8151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIRwa7m/k+a52iYTBVa8rgOZ+gHNekfxpU24Kci3OqzI6kVMU7mFphM9wMEqB3JfPAQHquCtO7QTPrqSq9BNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10440
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

On Wed, Aug 13, 2025 at 03:59:36PM +0530, Kamlesh Gurudasani wrote:
>Clock version 3.0 specified in ARM SCMI Platform design document
>v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
>
>The SCMI server with clock version 3.0 rejects the message if
>they don't have this field.
>
>Add support so that both SCMI server with clock version 2.0 and 3.0
>can be handled.
>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>---
> drivers/clk/clk_scmi.c   | 49 ++++++++++++++++++++++++++++++++++++++-----------
> include/scmi_protocols.h |  6 ++++++
> 2 files changed, 44 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index 83ea7bb4286..b547f2494c6 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -135,17 +135,44 @@ static int scmi_clk_gate(struct clk *clk, int enable)
> 		.clock_id = clk_get_id(clk),
> 		.attributes = enable,
> 	};
>-	struct scmi_clk_state_out out;
>-	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
>-					  SCMI_CLOCK_CONFIG_SET,
>-					  in, out);
>+
>+	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
>+
> 	int ret;
> 
>-	ret = devm_scmi_process_msg(clk->dev, &msg);
>-	if (ret)
>-		return ret;
>+	if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
>+		struct scmi_clk_state_in_v2 in = {
>+			.clock_id = clk->id,

Use clk_get_id

>+			.attributes = enable,

			.extended_config_val = 0,

>+		};
>+		struct scmi_clk_state_out out;
>+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
>+						  SCMI_CLOCK_CONFIG_SET,
>+						  in, out);
> 
>-	return scmi_to_linux_errno(out.status);
>+		ret = devm_scmi_process_msg(clk->dev, &msg);
>+		if (ret)
>+			return ret;
>+
>+		return scmi_to_linux_errno(out.status);
>+	} else {
>+		struct scmi_clk_state_in_v2 in = {
>+			.clock_id = clk->id,
>+			.attributes = enable,

This is wrong, I think you need to use 'struct scmi_clk_state_in in = {'

Regards
Peng

>+		};
>+		struct scmi_clk_state_out out;
>+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
>+						  SCMI_CLOCK_CONFIG_SET,
>+						  in, out);
>+
>+		ret = devm_scmi_process_msg(clk->dev, &msg);
>+		if (ret)
>+			return ret;
>+
>+		return scmi_to_linux_errno(out.status);
>+	}
>+
>+	return 0;
> }
> 
> static int scmi_clk_enable(struct clk *clk)
>@@ -275,12 +302,12 @@ static int scmi_clk_probe(struct udevice *dev)
> 	if (ret)
> 		return ret;
> 
>-	if (!CONFIG_IS_ENABLED(CLK_CCF))
>-		return 0;
>-
> 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
> 					    &priv->version);
> 
>+	if (!CONFIG_IS_ENABLED(CLK_CCF))
>+		return 0;
>+
> 	/* register CCF children: CLK UCLASS, no probed again */
> 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
> 		return 0;
>diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
>index 762a1032c37..a4d1a4c80c8 100644
>--- a/include/scmi_protocols.h
>+++ b/include/scmi_protocols.h
>@@ -807,6 +807,12 @@ struct scmi_clk_state_in {
> 	u32 attributes;
> };
> 
>+struct scmi_clk_state_in_v2 {
>+	u32 clock_id;
>+	u32 attributes;
>+	u32 extended_config_val;
>+};
>+
> /**
>  * struct scmi_clk_state_out - Response payload for CLOCK_CONFIG_SET command
>  * @status:	SCMI command status
>
>-- 
>2.34.1
>
