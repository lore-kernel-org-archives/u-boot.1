Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7589CD54AB
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 09:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC5F86A5F;
	Tue, 19 Sep 2023 11:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QHCfYEUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCDE686452; Tue, 19 Sep 2023 11:29:03 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C995686A5F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQSz/949grit2zuQNoKxNor0/nCcbPgfundMnXwV7ICNICvbLQ3jhE/kPrOJOONEvhEFDRSAFmEGPUK/DsC5XwsDiVgYbaXgUL4uyrE4bTu9MuXW6JZeaWzPFI3vi+cecx/o/rjNMMRVVKm6vzRpKBjBW9T30so3z6z/HO1YXv5W8MrStyXzUbo0EL1AdqlM40AbWWku6G3IclMs83BsVRVbALIZAU9JG8rfn3KZBU3exNhhSE3hCCGqQ6qVth5szP2ohuLHy252VgY58zOd3s8XcV51qYWfLJoF5+bJaat7axMPaBOfRcWMI3RwpaZ2xUbexIvIaPc2L5/wMFDtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j4t4D5FPEJJXXNr24siPNp4feI5TA87xCM7OjPDdNg=;
 b=VYaPbI9tfneMto+2dGDdekmM5yCXJ1ctKVsW+jdlFnQJYU/DuA/jnB9b7jAYje6Bub1AdDsLBOo0w4r1dQ6FY7H+GpZKeDG9hKSykfFsj4NUiSECP0G5wMiLbo7Y0a+Y8XUgqRF87ZafHPTeqKCznyO70S3zvDFXEk6j40ufr0NhhL/fuIC0ui3YrUjt3naLvdunHHWGQ5dfIi+bHdk39RGV8C6BIwlpwrOqK6NSJpCF/nS7wEBaL5lN4q0KCBiHhNT21S37iN8TQMz11b9zBXgLn2vfLuxdQTyPBkltcagK9Fwd+b+rYC7YTPuWtPEb6i2jUSddNCHRLw6QeBoJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j4t4D5FPEJJXXNr24siPNp4feI5TA87xCM7OjPDdNg=;
 b=QHCfYEURcCQiXibbNJ1imHUkk7Ot7XpdfiIombBPxpPtTzpS1xN6EP8pKuz3IM01hxQjBaPj9aREpJ9bnDnxnHrDV/QK6n3XyXtVrXzkzGk1hR3FENm8p/ogr3tFSMkr+0RzCoz4lBqGfs9vzVRZcbOlvGh41TETgsGBZ/9noeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:28:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:28:58 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] imx8mp: binman: rename spl and u-boot nodes
Date: Tue, 19 Sep 2023 11:28:47 +0200
Message-Id: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3309:EE_
X-MS-Office365-Filtering-Correlation-Id: 279b385a-929c-444e-ba27-08dbb8f2da33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+NZzfbK0x4WOJeSKakxTYjIT7d9cE3zkJjWVWG0i+1SJhB/oxDih62p138zOYv7Y51FCv/PSaKRZy630RtUSOzye3MS//jdp9rDRV2H1igbD4vyNJLUvwnr+DFU9XC9IATruA4vjtgltniDRE3v/Fil5eL9U5PYl+J5pyq/dbbzhc3hexQ+sYXaFWd73r4u5V04aWRWMhPPaFmDmbyP1feRs/i1oKEyqV67NRZSR4EDBLIwccP5dOJCLBnCis2zA7QNNjrrcJ128UkImSllSvNOB60gvLhtdZw1d68qBR6VmXLFmomm+hoNwxJi8UzahOwmmvKJxrFS4KoFEcuz7MxZAyXHT1sir8Y3f/orjf0RimWDAJLpIpgd+1j2imqWKCNg2mktq8W9vZTwheoaSu0T2gDECnEPo1FQrHM2+N+Rlkjaz+Z4uzPqQcgzu1+bQ0mUCh+E6p/J7jIx8bw12AU2DkHiVwN7FC9407t6O2sk05hk7bJQmuefQJteJJndGKQFxcu7yTXnSzl5nJ8pfVBnRCb4ZhZAuvLNj8/mZhriSvlOEEACKeESJox66MlJUpfwey3q8P2bJ2L1VPvQmf/Q7tv1awV9bcVkurOtQyfnObuTAeIJ5vKteNCTloL/46TjdvLIXaX5/Hxe19IoJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39840400004)(136003)(186009)(451199024)(1800799009)(6666004)(52116002)(6506007)(6486002)(6512007)(83380400001)(478600001)(1076003)(26005)(107886003)(2616005)(2906002)(316002)(66556008)(44832011)(54906003)(66946007)(6916009)(4326008)(8936002)(66476007)(41300700001)(5660300002)(8976002)(8676002)(86362001)(36756003)(38100700002)(38350700002)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?972n+AA3QjlJYY7RLz6IghmZDfj/S1OCxjWVpLKReTx055arGTmatJgrKU2p?=
 =?us-ascii?Q?KD3MKzUWNHzQJwZv/bgSjq+FJwGape+6S3HFC7wsSVk1+3ayfH7QU5iDX57Q?=
 =?us-ascii?Q?zpB9eW4tWTZ6E69gT2f4t+RoHEdtuEDY2JSnso592cd9PM9ao7SFBEak3WH6?=
 =?us-ascii?Q?P43lLyiBQMAbG9kF4kktPM4wm6PIHsOGMW/U1gRw6BSho1xbbid3BJ7owR4f?=
 =?us-ascii?Q?kHL8jq//iOXDqZ75odCNDKF+gFpnNufYzVw+WX9+e8z4WWoh6nC/pBHqbwu8?=
 =?us-ascii?Q?zlc9yGVIBeGDqSJ90JWuuV/r3iIt7Wv5lWaUf9B5nVm4k0cMoabb2ItWdV4i?=
 =?us-ascii?Q?0jZfz4/FSkdtEuA5MAhqP8HN+w+XDlyXjTcKUl8//i/Tie7H7QH6pNRqxrJ5?=
 =?us-ascii?Q?wTXxMfGx0cZli+UbUWaLBT2paz1hpH9DongyrGrc5T6y0AiS6rwB4yN+wZbr?=
 =?us-ascii?Q?Ay0bhYMRjS+Qd6oncCsmVZCG2QwzhzOHNtxx43a0Jey1Tqqb3uZKQGGPfYrU?=
 =?us-ascii?Q?UcjFXJ0X8WZcAi+WIixuAUx5haEH6MT2wOhjzRHe6tfvC9ufxQ3wXJOWV8y4?=
 =?us-ascii?Q?cELU+AwXTOnfToNiFLPO9pK2VG69ztuP0RJ7e44FYouxaCrJPkTI3NWKVoz7?=
 =?us-ascii?Q?qQvG0vWzQyuijIZVpg65dcWMwD+/6PT+pa6jYM9rN6B325+CLAuLdQgKguVP?=
 =?us-ascii?Q?5cooGoUhe/GpMMQ0QySSEonXTCExcsO25KckeN8BdEPSgo+2SGOxhqR7I3Ns?=
 =?us-ascii?Q?IXnmyRZQjSAMY7jblsoceisQZ3Jq4pbN+xePZITBU8CFLxRvmsXyMfk6gmvB?=
 =?us-ascii?Q?gI9sUa5kHq9nLd21uCpV0AcBHz4k499EQ+E70qWvqvJLdDdieNOb8GmnbuW+?=
 =?us-ascii?Q?pnY1JWA+7RXBoploCxbJNb1XTedZUAkzl7hCMqeYalukv5eqm3kUyXWE8zZr?=
 =?us-ascii?Q?qgLbQU7wy4g5wNOz8dmg3wxSoXLCZt/91ovhXiQVjCivRxSCAbhKi5ATkKKW?=
 =?us-ascii?Q?EyVweqgtCM5BQTLG8z6joj26zxI0Ee/nUjYni56X9M8f6QCa/KMN81P+SspG?=
 =?us-ascii?Q?6M6IH1p/XEVmVaKdjIwxeiOBIRBpETsF6/DT4CN8zwdlgkvtYDl4bU5TySFz?=
 =?us-ascii?Q?qLi6W7S4VpOdmhoej3Sjr6L0IF8p/tP3GH1yCMbkA1MJJKRww7mTY/tDI4P8?=
 =?us-ascii?Q?SH0R4lMzLl5gIMLiawM2k/3ilSSNgfdfBJ3rkMApHHZ8C/ITL6txOz5VhByg?=
 =?us-ascii?Q?7YTtaDRk05XclJdxfN0sNHo4OmELy7NJueSUXNlf5WWByKmiEZgKzlnZXNtR?=
 =?us-ascii?Q?ABQFGXpvj6DoHYFf2bTkiyryS9dpgs/SCyEiTnhZ4B4ynS7/X60QoQBbqiK+?=
 =?us-ascii?Q?IVJwjJoavXIOAQqmiph9yem/O9XnjIe0OPk9IBXgHwiDhlpdoo8xS7W+pnSs?=
 =?us-ascii?Q?a9XgETTAEX+yx9ol5sQKJm3GgXZOYut+tjsyHFcO0mwWgtdbNRZX4zsM3DiS?=
 =?us-ascii?Q?CvVMbDh892wt3s7dzobVnkuN8mjEvBOaQJF/e6ap7oZDcNnFxMKcDFB9bOju?=
 =?us-ascii?Q?S+1X28Oa398NY+rthsHZau2vxJky2as10sq4Zl/aTkBZvLvsEa0Q+fZSBEKp?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 279b385a-929c-444e-ba27-08dbb8f2da33
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:28:58.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSZky6NUpe+3C1w2MUhl43ccVPblVSWPjU69soFLHqjpi1paBl5hClwsypcKxotbElE/16XYcA/Yp0D2VfP7ReKT0OKBz86POZpvXsXNexU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3309
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

The hab signing script doc/imx/habv4/csf_examples/mx8m/csf.sh does

  fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset

to figure out the offset of u-boot.itb inside flash.bin. That works
fine for imx8mm, imx8mn, imx8mq, but fails for imx8mp because in that
case 'uboot' is merely a label and not actually the node name.

Homogenize these cases and make imx8mp the same as the other imx8m*
variants. The binman type is explicitly given and no longer derived
from the node name, and the csf.sh script will work for all four SOCs.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/dts/imx8mp-u-boot.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 200938a980..355af16cf3 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -171,14 +171,16 @@
 		filename = "flash.bin";
 		pad-byte = <0x00>;
 
-		spl: blob-ext@1 {
+		spl {
 			filename = "spl.bin";
 			offset = <0x0>;
+			type = "blob-ext";
 		};
 
-		uboot: blob-ext@2 {
+		binman_uboot: uboot {
 			filename = "u-boot.itb";
 			offset = <0x58000>;
+			type = "blob-ext";
 		};
 	};
 };
-- 
2.37.2

