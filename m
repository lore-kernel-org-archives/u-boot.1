Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59010C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746CD80F32;
	Tue, 18 Feb 2025 13:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FYiwAKTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE3E80F68; Tue, 18 Feb 2025 13:07:32 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28CB80F1C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsNAPHxtwEmfasyC8EY+XY/eS/y4cRbzWqlDLOL4MjKaAbdPmUCN6Tyy64hkBFwgD/B+Z6pn6CvS46UDi4XQafFuWI/6zPf7VqgyIWiyc6qvRj5wpxX/9jvAwlGiuqH9e4oCgieq9JxX6aXF4vYrgPe0adHbc+n2QqUZ7scQtezoa85hrEHMSwBHC7ngnXH+R0TSFq8td+quUyO6VtdyCXW3wZB3F0wnmPJla/GqzHvsttrr4jHq6R38bPC2jkoY6tBT30uEUKW0qxhFz3XWqKsykCKHsO+YavgP0tRDHGri82RLTd92k1T9FLcMqQdO2qgA4HsDHyhSbE5c5k4ASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOskLGzIL+6z9ZsL3SaRzeBSmQHQB6TwaqFc5cjJO3M=;
 b=VBHMrP3w3BZ8y3sTZfhqZ29Iu0RJslxm2vm+v8WY/6eDTGq+4OtZBTjC9khsbphRE4msUe9+bafTLLshrpqA0R+KtRo/TSjnY9FqvAxA0m0PQj/KggwnT3NWsQrQWYBrTyRPgG+2+Sh5/2TYm7cyVOGNFl6bLHTAEvONaTby5B79amnQXLkx7w5bWpjAxst6c9mAOlrrUYmFBO6j06Tvc29eqsc9b958oAjF+DkoolxHW0ZKsROIThpXphpny/623a04L7/jZqA1Ln+18V0GVjSKfHC3uuOF6avvWZzD/ZZzbILCZiQRghfFIz/F2O0ktDGIz6rbWZpSU4vUMfk2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOskLGzIL+6z9ZsL3SaRzeBSmQHQB6TwaqFc5cjJO3M=;
 b=FYiwAKTMFf9mHw+5rM4wK1u7Kwka1fAMWY2UOBxIsuxpMMpQLPAFiyRcOKCJIEUHcbc+sfvfeLbfDDigN1Y2Q9VljwXm3azsT4PEt9xPQxxnGzh1o08K75lxldnQW93xKZqrNkdLeOdEdEL0r5bgbr5ALbZirZS2UhCOgDId0kA4EMs0m5RT29u2ts6yx+y8eiNH4brbP5YjUwrLE12Nk+bbEP1xFX4X6G9BFlA9RTLJQPcn872eU75mA/oXey+gY3MuXnwUGTPhVmDzkQXIzhC1dbaRgPmQuBQYNxAcQ3gx29lm/1a87Yccxhxs9zV9IHMIT2F2N6qPNIVE7uRqCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:07:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:07:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 05/20] scmi_protocols: add SCMI misc protocol protocol_id
 and message_id for getting the ROM passover data
Date: Tue, 18 Feb 2025 20:05:42 +0800
Message-ID: <20250218120559.451678-6-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b5fe96-ad6d-4b82-2315-08dd5014d0d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZihiJf21Pxc2kB/xIvg7CuNqWw8USCX9Zr6x2+MOEag3Ppo1rBYz42xfQnrl?=
 =?us-ascii?Q?Kin5FxcnEx7EYM6+CTwwRt5+Ny5wTh8hI0JmdIMsYUt0rRiudBuLlsG1f6VW?=
 =?us-ascii?Q?NNG+I4qknWXmP7mDbAl07Wmsk1YVEdUHTfe/RtFhdhp9+OzFR+vRhMjr4E8c?=
 =?us-ascii?Q?y+FWThdNWCaQYMK//TSV/R+L5lwTUzB7LAsiV2HDqZL38NfevZ3wxEZ4EADY?=
 =?us-ascii?Q?78Phjwu8yyL4m73ZVIY7wRfQmBEJuRbwgU5IxDDidxpElwo116EPn/P5Ec5N?=
 =?us-ascii?Q?H8E4kDnTH8s2Xxph5FLXh8ccpQ4hM4cTvXXML0CwY7Qpjr+PzL/M+sWhPsjV?=
 =?us-ascii?Q?0HCXsYGfUJOQpUX0lg4bZkshDcM1HVabJwWtYTopjnld4XyHQBRCapKnAoBn?=
 =?us-ascii?Q?S0S5FCGJI6G9eQrdfkue/fo91Cphfnlp5PsalwSD0UbZsS7GeOhbyEJyx4F7?=
 =?us-ascii?Q?JFuH6I/4whUuLEVWN4dvbuDOWIFdbaMOAoT4ixOTGL4W7vdiqRwzdSk//NLS?=
 =?us-ascii?Q?gRkSV5L/Bh3obnRE5IbZx9jK3wgGJdZd1BURxPVK4VCLohwMnfFEdEStIUq0?=
 =?us-ascii?Q?k2+lG20+WEkwbRxnFFV29jqCtI3Mx2Y0rGeYBMO8O73BJzV6hv9BFfEihaPF?=
 =?us-ascii?Q?mBqlgOqCBpFkzTlmWnTcB5vcLG5tDL3mbbKL4qXc8l1HW2ohVzavoHcdOY2E?=
 =?us-ascii?Q?ZUzKBd6uPcldswRa9hz2uTADLqiCdIMa0JnzvaAxh2Kio7Pp8deYLSD1ecsz?=
 =?us-ascii?Q?P1G3NerGtRPFKuKROJRmaUeQ08DWowiiVRBSJuNx8KbGIA6+TGSngIfm/+ST?=
 =?us-ascii?Q?gcCTjHd/KP7PHRr7Z75EKRHleZuinXZcYmof5Ye6LNOrHvqkFt1GpcjBxADa?=
 =?us-ascii?Q?0f5R/DbZvoPWuUHP5ipuKI/Ff1u4FsPx2cSpajpO6xPmhUpB2SyEEnb5T1Wt?=
 =?us-ascii?Q?Egt5XNvXYlvldeknmZDMtsIpD9nPUBwATZAmL5jtKOWukyyEOfCG6cvXHOWg?=
 =?us-ascii?Q?8aKjISN7AuYs6xU8EiNpLvK/Icf7CNPHqLHc9iUNJ7Eqcq6NTPkbBqOl1dWM?=
 =?us-ascii?Q?c+Yl87rAJkVVpMxERgM1V8GkVLuHbWw4F8CKV2T+a3yUIonl5wNmkw6gT9LJ?=
 =?us-ascii?Q?4r6+08auKYJEDCVjCZ+gi6t6ZInQeQz4igrnuP5yMO3oP30bzEcR54YkX+Ji?=
 =?us-ascii?Q?rmXVmJTU/afOmT4VEXarkcPWV9E37a8CTzcrLnrT5fC4dLciTAgoj4z+Ttlz?=
 =?us-ascii?Q?0msYwW24mwWGVl2hsDy2CETiw49xB7a2mpChFnt2BP+yQ99A/QHTMmO0Hw9o?=
 =?us-ascii?Q?485DGY/j8H9xQqbpPa4qxjGauFbXm//qx2uGunUdYY7J1KEI+/kyLK7OmLHx?=
 =?us-ascii?Q?qRqf/VND+6g/OX6Z5po4pa56qLEu3FnHcEN8ACObVqvChEFRfSPYhnDMLxDS?=
 =?us-ascii?Q?o6c0vuVX6Yj04WMdcJjGyRH3ht0C4fAn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGsF2N7ZYHRLuBfuzhWhqQ7+p8tHfehY1dim6fiUlqvDxI6kaYKv1nEP0RVn?=
 =?us-ascii?Q?hYtcG3vXulOtdtP3Eywxz9Dwo/8VOZQg4BOH3z/nS8mSWKx63yA+Nm5fPV4e?=
 =?us-ascii?Q?1mr5Y29I+c955CM+Dz3woUiarG+mjh1MB1UNTcf6tKFaInL6C/ylv6x5sMpN?=
 =?us-ascii?Q?ei15TehQX6kAtkDSBHP5GGnOBQgkRSDBHQalZ9YvOxD9w44wV7k2rOPMeF+0?=
 =?us-ascii?Q?mu9o0wt/PSx4LzAZ4Pr9z2H9lTVPsjpeR+PpmjuEbh1XYi76qya3WlEAaUM8?=
 =?us-ascii?Q?t1/uOiRCUVfW9i+hU80NfRC3WkASOopzxC2yzn9sW1v5G20D8zIR2yPPbdiF?=
 =?us-ascii?Q?27heA7YzyENkcgMKTy7ft8RSWZTjKNBNDbDbVbFnG1+ejOX5z2NPZ6E/KlJi?=
 =?us-ascii?Q?g/l/gJj9wec1Tvu3vpXc+Jh660O8MgMzxEUhCBkB+0KDsFtyg+kk375DQ3ey?=
 =?us-ascii?Q?n58ruhfzZJ+tlqLrQTWiBuCZwdfO4vZY5pj/u3YN04LvqsrylK4WuhXgbbpU?=
 =?us-ascii?Q?pFhP4vMcWCpa2WpbiBCV8Z57FOdjs7VXz61rQyzy3ZCm0c9NA3IgXvJNwt6F?=
 =?us-ascii?Q?FYb+uQNp3wuhnTBj+Dq0xGLsavTlM8BZh0AcasgBXqBKkZY8uPbU6LUGPEBv?=
 =?us-ascii?Q?BL3zrN9xekAufknzwqlgO18BmlLQT36VVxJCXOYfrsicbsh0f7Z/lLqGeonX?=
 =?us-ascii?Q?XHuMTd55+yocGNePVLETkTtXFpgGgnchGal55MiB5KdC5voM+RkheTWwsluK?=
 =?us-ascii?Q?Yqj+02TOqTrGAILY8qLN28RKlzOVEKz8sjHl6qu05atnik2MCGp5LS5EY6Zh?=
 =?us-ascii?Q?XqWCnW8Nv7CSyURG43zqVdEOyNZYg9BF2qgaI3T5mP3kZwIXTaA0ltAlDLH+?=
 =?us-ascii?Q?GPLkHe00pXgQmkp/n5qv1p35RTdt+P7QXvl+A/ypFqnhwAOHXuY7+y0rEWV+?=
 =?us-ascii?Q?f8tMMeu7D3TTMKoL/329QuVizs/8qb6o3Opir1D9MtRmg0RimAg+38m7QtTZ?=
 =?us-ascii?Q?U4X4xmbVMHVsrcm0+mSYjDqkRxEs8JK91Nxznvo7tLv45N0qBgBtMEL38GNO?=
 =?us-ascii?Q?HWLrw06C9jVC2cMlpMpS5tWy9cC2jtyTbOgfQ7SRpHBxi9gNXmz8kKNu25mu?=
 =?us-ascii?Q?ScKXb+SSl+t9BvUD4KVq6y4zru+ewBQN1vJjy55InhUXXhpRoS/mtHizh/lv?=
 =?us-ascii?Q?MtNJMxgTiAdt1mLsDCzUEkM7l4/xVxw9CEnIVtanA/I7x9ZlWqeWC8mW4QiT?=
 =?us-ascii?Q?ugoOvVnUSGDPXir569cGIfGkQhrhtDn9+3MURkI78YrGwoJIYwGRqBAkbLRd?=
 =?us-ascii?Q?pKP0XJe3oxCHimz7pEsTn7gmXi9umtIR839Ubtpfje+fjgusumlLYsXuqlob?=
 =?us-ascii?Q?Z1CrynDyWj2k2G+AnLwUc8xX+Kxb3fPvhabn8uoMA8JWov186NR/6dtFcwgT?=
 =?us-ascii?Q?ELV4NoPB+xUPlmYs7z7xm2ss2CSDgSJPgba9ACy463NlTZ3w2zfuR8fJ7k4W?=
 =?us-ascii?Q?oICqhp5EUASgM3iUTU/3GDDazvhuaUSMoY7s0NWTDUy05vKGXJw+dxfupDTl?=
 =?us-ascii?Q?uU9CuICo5+fUy9RqRz6wOKyM0o0HwiK64V3Yh5j8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b5fe96-ad6d-4b82-2315-08dd5014d0d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:07:29.2532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz0H/wuAACBxQHPxCh6HblkRG6/HcVaoECApB8N54b+nrTcifAeotFjClMXN84+9412TdxJufDkDqgq9sm+qlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. This patch
adds SCMI misc protocol protocol_id and message_id for getting the ROM
passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad440..06de4a601f8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */
-- 
2.43.0

