Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBFCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 10:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7C88841E;
	Sun,  6 Oct 2024 11:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dFsr+05R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1177488A1C; Sun,  6 Oct 2024 11:59:58 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CCB1883D4
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaVfhLsj091R8tFkqK7+ildwNI93BFkggAgnxbw4o7XjtoWnHCDnYC1rnjZMwUPcU79P+yqryDTuaqt8MPl4V+dTH+R8cuKeL9fwEp0iAhwUgs0i/sPT9CYR/tT6jlmni002VLLJr+KQmRTA9EzTD5TFArePRPW69GldntvDdvRs75OBLJ+4m4yOWKlFWEo+ruaKjmKtlVFED90TdGa2esGDaGKmKtX1pCWdUcF66J8YvXcjEga7atk+xSPSqMB0lLTOlkzfaLkzjFnRWWnFIqToT+qIpEzaUBeykFvKlYvBh/Fyawapmlp5W1FpiaJHvuLGytovzrRrhfp102Z0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t88s5XIyhbTEIs8fqi3kWfjFr4n4fn8Ei3LbleN4u90=;
 b=UwxxewFu2RHEIVI0ww5du2qpsaNwHUtUM998a5kS8TJrhasIrBTmbL+bo2PFNrSJP6Drt22AS3YAXshYTROD6YQ6EvyuNxvBvVYCef0Ie7UccF46NAfY+RJai9erghwjj3e5wIHnLzDkiO6fuSeft94yMEA4dTwvryGtrjr/c4eipVGT4RYzoqmPJr3wReF1wNyZzrb/0e23FTvIyE00KIAezNw72u+jm0cNLaFU0duEgK8DajIRwauI2ejUNXlHXfMBmzQW9fEh19jS9v9gIyFebX2DOmNbZI/rOSQwDastq8Qg5/U6YYcX+Wswdpa43/cdCk9BanglgzDaa0pkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t88s5XIyhbTEIs8fqi3kWfjFr4n4fn8Ei3LbleN4u90=;
 b=dFsr+05REPy4VVptQQNk313Csmt1ULQ+huy4JC437ISWuR06yItrHXCJQTF3bnK6zvK+Xy2smyjWFspnq37JkOBILreUczdEWoG1sbspzW3qqMsyiXhZwkSH1bBoJpDK11g7QYcUdLZXCqDikUO4M3bN19c6nAIYeh/vXOpYo96KTLehA4lh/mlXtb88zykAjfyapVmM/p105usLgsL2KQbGyDXtznEL2Na3R2NYL3j1HY+5dEdIC+pXsm42j6PQxA6YJflcJcMs8Lj9AU7gIXPZc2UOlVKWkUNxdzA8TVthGJTtRe2PCs+tSYS4BM6efw4Iu0zltUYG6rIkOKOUSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:44:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:44:51 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, alice.guo@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
 akashi.tkhro@gmail.com, sjg@chromium.org, festevam@gmail.com, marex@denx.de
Subject: [PATCH v1] scmi_protocols: add MISC ID
Date: Sun,  6 Oct 2024 17:43:47 +0800
Message-Id: <20241006094347.2800266-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 22817f1f-4655-41bd-72b6-08dce5eb8651
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z7w67cYKyEoM6p+dAHvHaiXUVrvGnb0ZMugSQKI+FhDWW8v1ojH5hNSrOtzm?=
 =?us-ascii?Q?zLSFaGrWNYx5iuYIQjTQu5WJJZ80gKNemnsetHC56xYi3Sdnu4IGRx/6cgCd?=
 =?us-ascii?Q?ynHDdJVCd9ae9IDVNOyxykTzabv51kiIUCcMKVmSiHhiONV/OmKoKu+V/sha?=
 =?us-ascii?Q?OKFRuSSxygBEBdhaSqR7dQsbyQkBQekcd98zNfHpsSVAIHh9dGyFX3mWr6/9?=
 =?us-ascii?Q?EFEOsPqUBZ4CvjHqBhG7Pj+AKetDZhVYamzzr2S9U+T8YVjtP+sQrssQ4vdE?=
 =?us-ascii?Q?QJsjinhACZUHYEiIygy/EPH9fk5XUj6q3NiQ9yNEP24wxflBiulgvqVM2YHk?=
 =?us-ascii?Q?OrHHpqbSpgAtmwdUEfHK+/woLoPUWi9O+TWIi0pF8qJqDonFYcTglBGf5oS7?=
 =?us-ascii?Q?4DRyBdAxr/Agg/omgvnTwJNp9axyqbjNa1yCyF3zYHY2sY+tOD+VIT0orQEx?=
 =?us-ascii?Q?CB5afoQOQ9kiyWCFTxx046WQpRYyuopfLZoUzAKPqT1PxiBuSkGZtOsAE01x?=
 =?us-ascii?Q?GH0D+o14cmIFe0tKAdDazeUUHFpRV+VG/u0PXU8pUAleCZR7RJxwP7666Ujs?=
 =?us-ascii?Q?2QfrfzyxVxeo0xh5slIIiMOqam5Wb9Il5UI1v/LV0HyVGvz2XX22POkkDFdI?=
 =?us-ascii?Q?2vm8uX3xZpxxR/dis2cTrWsVqnjwmOxFl80og/rLyr3fdWyGvAMf8uk18nyA?=
 =?us-ascii?Q?kI5LMz+oSluQnkptWOhAa480N9WC/CDxmQJDBxX/GWvxNk3vJLIU2CcBH6qY?=
 =?us-ascii?Q?y0ezudkoaZ0Z/MfJiBsDGIOqwVDeynWV4Y09AZdZG/cazAOW4xZnA2/0pptO?=
 =?us-ascii?Q?y5J0CvclKUIx9/BaTo+NZNfKGJli8lHZL6r+nlq2Yd/piM5osWHtM9CtM+RM?=
 =?us-ascii?Q?47eWtRusXOedVb1UdrCSoNJdpEZgIpvqJHsYa9NSOyyuPbACLPX2/QwzYjms?=
 =?us-ascii?Q?8S9oAnKEx07mD4EP4s3Mv/CoWS/gN644/rS1xj/9p5QBhvC3mIfKZUUXqdHl?=
 =?us-ascii?Q?rBF1fUh6v6LH0FN7QosKiHTOueBa/FP/9EZYoRmQ306gMwL3GAiGGxumLydL?=
 =?us-ascii?Q?nT0BSJZ1Rk/C5DY2xrIcwFXhXywlMMe9XQxjKFcqyb7TGJWLMVszm4li0rMA?=
 =?us-ascii?Q?kMdDOe6dndacXxdoLMnGu6Cq4E5JjpsGyQ3Cz5hPXyLrKZ0gMMu8NfytaM15?=
 =?us-ascii?Q?uErNAV6+7JW21rok+zaOW7VwdNDO23STBzA5QeiGJps8XL1ROET0XAWr28Rh?=
 =?us-ascii?Q?oZkjqyWbqvu2P1TyQK8zFuUWu7++U+JYv77smv8Z0CJpx9DJr2lIw0S0AaUl?=
 =?us-ascii?Q?2ucqlSvPdmCZQC24n9YNj6MvGcjCGzYnmMKZ9fmVhARFyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/U7/Sx61GBf5VcNtrtSmau85ok7QI2KNNLD3yPD2340/v+g1iT8B9fo/+jv?=
 =?us-ascii?Q?J0dJmsVUZbtMyKLIu/7uytEduTYQk53dJzLHOjEUV6pkO5fiV6O1SJOxt4i2?=
 =?us-ascii?Q?6OE/5jcJRE5XXBXDZDeHM9ALHf1xOUZGkFuy2nNxcgoyLTTMemWmAPCB2KAH?=
 =?us-ascii?Q?LfLGp4njy4x2aw4d7EqB6wkD4ZMXXTC8qS1QLV0V7BFQMMHICoFZ9jxkC6rW?=
 =?us-ascii?Q?suFJtCUFfa/s2ikjxdz01LgjEYAtphJk8TGFlh0oQnMfalJOWd3P+SlOpQV9?=
 =?us-ascii?Q?nY9oJJsU2RrbT2eqggGLqWEhKr2W4pOdspY7aQFewWz9XTZXmMEyrkvEdTZz?=
 =?us-ascii?Q?T8RjNhZfsxj0xf9jxjkgvSP4kIftTCVF4KEJdqLfP3v2XtXDu4cScTxAMYDD?=
 =?us-ascii?Q?7HYbOMz+eSfwDYjCeVPuYilzuMt+Vr3t+C0tPb725bf3TNTma/icMcU6SN3e?=
 =?us-ascii?Q?V5co1h8Zere6qB5LBi4N+nZhQSc0QQAHO9DuP6/KYmvEO5qXNrhh9hNl19A+?=
 =?us-ascii?Q?rANGwAJQv9rSIyyeIr6UoV6XAmMuTNnSHdXR7xwbdryDP4hxgmQz+jsUTKxZ?=
 =?us-ascii?Q?oXs1h70YIsTUUqkB2habhPufUQRU1NSk8xkFL96ECOhws+DqrYflLFbgtLFI?=
 =?us-ascii?Q?PKvydbKNidS7XJ7iGDshx7k64u2/HomZ8LoUsIPI7JD1lxDVuN3CTmQ7e7Cn?=
 =?us-ascii?Q?cAMYSUkvNtXeUAfTCXlUrRL7G8FcbxGV1gL3BZz4L49+fu2QlresgK5hYHuO?=
 =?us-ascii?Q?2xuWLuvDqo21T/yC1imHJn6QVytF6RVqtTfb5GcSDbDp1VavJKZqJwrUM4DK?=
 =?us-ascii?Q?Ng/Tlg6BhiJK3sDdX07Twup1s0EplgcdQRS3VmlDT5ozFNpb9oraUy6Iy9pY?=
 =?us-ascii?Q?vY8P0lypjmG3hWwRhW8NZt9DFvePrxq8l+rGQenlqh0P1gwl9JYb67wHWV9K?=
 =?us-ascii?Q?qVNye1TpZjP5lHec0rgIf/YgWWa4wcn6uIruXBJ+PCd6AU93e3Jbc01n+gva?=
 =?us-ascii?Q?yWWtTVkim1ukpfnD0cdOnwtgESzAfRjycl1KI/6ro5xaI2LC6rY2EbPLcC7F?=
 =?us-ascii?Q?DH9wDSoMRNGee9MpK2Fmuc06CVpxsiKHMsscJou9VXe+zeo1/tyBq4FjrVQ7?=
 =?us-ascii?Q?5XAWzwadJsZtSeuv73oUNEGMPUft5k0dBuTGIJcEO0pDCcQETLWESyB8MTGA?=
 =?us-ascii?Q?GS1FTub88pf0vb6Pegad2VElepWwNNMqjzMvYl2ax4SWhpe1F4sqa18E5vzG?=
 =?us-ascii?Q?TbHUqx2tP7blLjTBb416126k9ABDZ/vs8a5NnbVll2jmY7+zc6kqYK305ev5?=
 =?us-ascii?Q?8MFicfqZac+iUiIvh2FwdoOfG/iUqRojQKabtq/pCY+hy0J7AW9FoUSIj76R?=
 =?us-ascii?Q?gJ8mHLTXdhXZDC2Qg5vyYSfnlRi030Xl3u/JmjGm9Gdk+99V6b0/rjgk6Cpv?=
 =?us-ascii?Q?YSSvCwJQFctExzggii+HEuD7B+osMrai2j2I8yhduLCgBZChBE7KupXkzKh1?=
 =?us-ascii?Q?4xCYUEbWUcjZw3GMbVQQdwqq8gBsRQGGisBzfPzalcRmg2EqKzIPYZMFxRMV?=
 =?us-ascii?Q?FozbDcGOc6djyjsqH2o6JU4cqtqIZgp7TQ+F6G/6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22817f1f-4655-41bd-72b6-08dce5eb8651
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:44:51.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KbLdExgRrq/59jVG4VR3OJsKQaJnmaq+rn3t2ndPjjSx80f7I1Bj1KzirLJdauCGtc/OfNCGnQIpENcxwqtaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

Add SCMI MISC ID.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 36e46f4072..e25d94ab5b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,11 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+/* SCMI Base Protocol */
+enum scmi_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */
-- 
2.34.1

