Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DF0C83F38
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1013483414;
	Thu, 17 Jul 2025 18:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=os.amperecomputing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WO2bqM3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44B283439; Thu, 17 Jul 2025 18:15:49 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A823083414
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=os.amperecomputing.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rebecca@os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/x6FlvFkX/o3lp0Nwbtg40Q/PV9uxIrS8Qi+Snnkbb2X6JDjD0kVASiLzfo2NBZVpDbwsNcqAJmF/KoaIruvOgl1exlgg8v1AnB7oDaGot7xB3BNMLypVpGc1ceeyf1CSjR8Q0UapMAF9aebcjqMw/+NGCeJoxStfRvlgQP9mzAEB+s5YJpYdJEwv9d5oB7UcUpU1EKkzsSeF2Ao8JvxUnZ+Q6rdWGBT6ZVen42GP8urdyod0cRlVKsDHnqcMabD3kCVJScUmDBrgFnwoM9OnAFJiBMdWP6hgn0Be52q1GoIo+kYUfySQDzoJIe2osnYBV33cgwOFVsbhzg8q2FXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ5xYvzbCEUWw5IcT5bFVh/Y/SSTr00T7k+6bkOLmFk=;
 b=L0kPjCX/Y5tZAluoyhIFjBFjFChMYgEhRyAhnch+yDvCD8AChNdv6/AXBaaEq1jn7/Ma9s3YQqXC/n9bJrfh5Azg9KwwQOZ+aAreIkDjXtkvrT/yJ5qoPio0CNLVayhO36f4B50vokWKWd0OaTxYXmyY4DcjaoRnjp6i66Iy+gFQkHwyDQ7DLvie/XLrH5ReVg8yRsbPPbk1MlczBozF27kbF0NqbHjC0Q/ia0zLcDSRxzVcOToF0MXxsr2kV1okWWgdc4iLZvtfwrEzr34IkAAqXWF5VsL9J0D4RyZnGO4vPFaI2IQ3X+PFvw/7NGSf/uTTNvaQJh2+qMDjtwbHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ5xYvzbCEUWw5IcT5bFVh/Y/SSTr00T7k+6bkOLmFk=;
 b=WO2bqM3GdS42clV4Akd52W93ELOg0y2RrvVRKoweb6aqf2aC57KmEGiDVPMQCHVJjdoszIGqDEe6vmqSDNEOpHMBN1zFi3xQC1QD86hk09QEci8KApfEGUjUDxZiZ67fM3RMzWbHNkTHD3tRB8uHXgsnG0cnZu8Iz2EY7Z2QyXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV3PR01MB8464.prod.exchangelabs.com (2603:10b6:408:1a3::7) by
 PH0PR01MB6699.prod.exchangelabs.com (2603:10b6:510:74::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 16:15:44 +0000
Received: from LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d]) by LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:15:44 +0000
From: Rebecca Cran <rebecca@os.amperecomputing.com>
To: Tom Rini <trini@konsulko.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rebecca Cran <rebecca@os.amperecomputing.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: ast2600.dtsi: Fix typo of uart11 reg address
Date: Thu, 17 Jul 2025 16:15:27 +0000
Message-Id: <20250717161527.2664-1-rebecca@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To LV3PR01MB8464.prod.exchangelabs.com
 (2603:10b6:408:1a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR01MB8464:EE_|PH0PR01MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed0b417-28b4-49fa-2a10-08ddc54d2e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFGAGUj0OZ+GXMaVfBYzPfKjOMxUADZnUzN3LXxwWYkhC/3+Dn9/NB0mTOIG?=
 =?us-ascii?Q?htwYp5SDTIYlPxtRK3dAUwUcC+Ya35z5c4RAl7FnXQ7i8XgaxYbbs1MJUQwV?=
 =?us-ascii?Q?XN7roGBzJ6xN7g9pAc7y+Te5RQqa8Qn9Eii08h4vfZiAQMD9QCV7YBe0EVtU?=
 =?us-ascii?Q?SYoYFpIMxDCUNOq5C6X2Wz+jheVuKqDkMz10cD+fWG9E7NEFSzSsL5UfTDsZ?=
 =?us-ascii?Q?LEL+ZoY5vrk7W8gPtS+UYXosz1HfE6CdgG75TubIfKgfrRDjVr1BOzfTNDvT?=
 =?us-ascii?Q?rPSW6kS+gFLVCNtLoqCNMfB7u9J26caHMzzYWIi1EFErMzbdpmQd+np5tM9+?=
 =?us-ascii?Q?4PbxCOMJ+IZcPDYx2GtMhBMnpiFShYlGf9kKjO+xHwHbvnWUIt+64UJ/QLoP?=
 =?us-ascii?Q?20UPZ1bea1xkk+DlkTwnFuOttGf691wWlAvHkeTFED5Xz+eL9L6xSrRKmzoC?=
 =?us-ascii?Q?edUzxPAoUsmsgy7OW41LV63atZx1yo3xZrHLKGEqwLNNzAlOG3900muPvlux?=
 =?us-ascii?Q?1L4om57EtqeADT6v7uly3Rk5tHLdzp3D3IJxwlPfABd2HGeIF9DuBZKC6zw5?=
 =?us-ascii?Q?VeHqzWNBfgkC/PUx6uD9NmNQh06IZMRIfO9STWyrHPlzYMPu1r+hsn2zl0gb?=
 =?us-ascii?Q?F+zAkLZu2xilJBfvJ61fZPEhGAbziIjWS9Zk3jWzLZPzKh86jgbAPf0ev7bm?=
 =?us-ascii?Q?gPA9W4B1p0sQbruJvKcoBd+LWLaRAr/xc4NDywvpqQEfJmtV8PWlMdFYBwCw?=
 =?us-ascii?Q?4I1hpCwpWh4PXWnyGFTsom5DS7F4/bqxJ5hU0UNaLT2QReP9KC85G9wlN7L6?=
 =?us-ascii?Q?klK/rqnKmZ/NrHg8lWPJfceZSHKWsh12EPjZKwmo2+LAWRarSUUFzATu1woU?=
 =?us-ascii?Q?KbIXnWpMZpLPTDaVypRtqJowyxxhU7IlZSXeX3cT8nFr7lA1J9SSILQUcz8/?=
 =?us-ascii?Q?Dp9DLmVO+zzpT66PidRo2aOpPLQolciVM1CRq0GXB5sYbK1gDBbVG20HwYfi?=
 =?us-ascii?Q?2Z6lxQgyi93Z8We5JAxd8hivDCSGXWOh/k33uzJoqa2kc5wJRAHDXmIwtSxJ?=
 =?us-ascii?Q?i4y5O1NhIBmGtknTYQd5+YfwJ+HPZukjIorbW3QYbdDfdMaUQ2Eo/7lCtMhL?=
 =?us-ascii?Q?ow/4D1o9ufMwg0t8S+12eDa6Lx7QA8gawnjd83J/C2UIU1vPbjc/2CjrdniZ?=
 =?us-ascii?Q?tofOy2+PiR6zFsYito3Ct+n/uxh/Kezqzua2XYU5DcYHq6qELtoMpwM4C77L?=
 =?us-ascii?Q?PWs0GKLaq+dX4CnwnZBhOm++AY/vf8pzkOYGBVmfSfG63DA0IO5Ltp9jdHq2?=
 =?us-ascii?Q?YwQWC/7KwWjFZnjKpVj386XRYXoZoX6e5uSdfUHkXG0uNyRG8iJBuFHzZna2?=
 =?us-ascii?Q?WfkDg1xT0I36YDOmkjHBB1LyMwnlwHzfrAAEH511jqd3zMsoX2VtUvE/ClTZ?=
 =?us-ascii?Q?LAvKM23Q6qugG+YohJlO+UZ1299v0GRviVP1cb7QgI2dJwK9+H6pvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR01MB8464.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkixkLJWRmNmWSB7ilHUcSmZACQ6l7aqynoPhG+YDIBuC+iO1DVBj91qXnA3?=
 =?us-ascii?Q?g8dNsBW2QqOzJcw/JHQPbcGMS5RxpEIVtCDMNRLZWCE9URod2hYMpWxy5NsY?=
 =?us-ascii?Q?26apG+Caj6wuoH3YhztYkpm6I+1iLeANKzHW5YmHAJ4OE+n+aJlkeuVuhZS7?=
 =?us-ascii?Q?55em87LmyWDuDD5LtN8ZlfF85Br6kTzCpzhknyMj0tt5q2H6m52mb0SwrqDg?=
 =?us-ascii?Q?3RLt6Q4CIzItop1tQ52DtqkBQN7J5+lsjkI0CfJhK75LUZR9v4Thf8HLjLNw?=
 =?us-ascii?Q?0AJ6SWFJaYacZKsKpza2e2eotJDNDDtC7rH0Ivf02o+bk0oCKjT+nBJkEAJl?=
 =?us-ascii?Q?LWVn8qI+4Tj6P1ydGA9ry3ddx1dnfjzzdDkwd8I2Kgt8HDx8+PXgBXbycv1R?=
 =?us-ascii?Q?5N7pkJ1hYk/WAobfuQLUF0aVBvDzTs8eAvrRJ2Ox08uX2hvZQiWFN2s/EPfr?=
 =?us-ascii?Q?+Xz+LRM5dzBFou8uOM0Mj/vi2wRaUxRjuiIGT0gLvEXcY6WRPvEVraCI94qN?=
 =?us-ascii?Q?irp9yinGJQ7zOnWduj9SfK1bmu5ctRFKq2MP7N5paRNZPouQ+DvQO3x9YbZ0?=
 =?us-ascii?Q?ZIh1+taXITSutPGpBQben8px4Dm5qpM9ZqwVgT4Te2RT90OMTci5GJfAXX+X?=
 =?us-ascii?Q?t3jj0qQhIyvHPNaYiW4INUlcmSSvIYYpdsqgoiayw2KUTlYsWBu1FNR8fIuZ?=
 =?us-ascii?Q?CFMYLJrBRy/kvnk2gl5Wam9SKd2mBEWvB5lpSH7yvWSPWGhDBkWEEZC3JDo4?=
 =?us-ascii?Q?hXimyM7wa2YrbglmGYqTNnddmnY0CbD3x1OCHEIpx7eBRQvYGUfZ8CAyT3Ip?=
 =?us-ascii?Q?KgeLUWxoTW5Ck49utUDRzuiYMqG9FA2IfujYwcpSqIATcK/UTl8vwEdNbMA5?=
 =?us-ascii?Q?DgqDRcpQj/fUxFVbMLcRl7uxywEiWIFV/iR6J8cDSj+207j2JgNhoqaMjwJQ?=
 =?us-ascii?Q?stK9+OAZVkk/mWn19PsfkvWQ7ynuPp4DanKYKPHVbtUl6G85EMXUWYikBxLe?=
 =?us-ascii?Q?9j0esXQt81zJBOROTt0zLZfYcyKtsKS5VLq+PY0F8WZjcYSm51ePvCbzbrRp?=
 =?us-ascii?Q?uLmD1ELGplNOZBzePWFVteEbmWwZ1QotFvO6Wf3B+j1KDm5z7p5OeoMOwRuW?=
 =?us-ascii?Q?aM9yqVQCl4XsrcXvQjNeJD9oiD0SLMQaS0+T0STZajqo+wiMEiWcOU9bvbT9?=
 =?us-ascii?Q?XLNAOFWERxS2AQXnHpeJcnOqB341LIKcroqNyUAVEIXjGRK6V8Fi/BSf4GPk?=
 =?us-ascii?Q?IfP929WWdyi13+LXukVwg3qYhlMSxjeiGm/RFspqPFQWCnmxaRwz9GPGLXuP?=
 =?us-ascii?Q?aE8/a8I0dRRbXz7x1GmXdDdiTkGbFSaC5L1YX0chizoCV6HIAIgXT5eP2V3o?=
 =?us-ascii?Q?xfw6VLyzzwf1dz6pA4kAD4YHLUx7a6USJtCG2WWmUqT6VWpVvwjSGOVD12tw?=
 =?us-ascii?Q?p1U40icayud9H9pUPZkKtPaljHUXUo6P0kYwbOo3Gt550fTXtPIwSwmJUPS6?=
 =?us-ascii?Q?fKgAT7c3g26iP7XyZLARVD6Vvh6WAVFhEIz1iXCkh2Hp3fB3HPaAiuf6kY/K?=
 =?us-ascii?Q?L8C7/nEqWa8XTHlmqTwGZ3ik1rAJfmN1U+XVWzxKbv5lQqfdkjzKHNWpMIZ/?=
 =?us-ascii?Q?PyM6EolmTDz1Ppo+OqP3E38=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed0b417-28b4-49fa-2a10-08ddc54d2e54
X-MS-Exchange-CrossTenant-AuthSource: LV3PR01MB8464.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:15:43.9816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRFFah8KFWFr6AOZLJiHZY77tWknRiEDPTG8EAkxbXIPgX+un5uawVyvTd0w5louyUjVn3k+Bkgu4pAmKrTGeyIjUF2Y74BVQxZDdLcGfYt/Rx4VopT4LSxvOW1/LJq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6699
X-Mailman-Approved-At: Thu, 17 Jul 2025 18:27:59 +0200
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

The uart11 reg address was a copy of the value for uart10.
Update it to the correct value.

Signed-off-by: Rebecca Cran <rebecca@os.amperecomputing.com>
---
 arch/arm/dts/ast2600.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/ast2600.dtsi b/arch/arm/dts/ast2600.dtsi
index cb8ce8b6b6f..a048951fa18 100644
--- a/arch/arm/dts/ast2600.dtsi
+++ b/arch/arm/dts/ast2600.dtsi
@@ -794,7 +794,7 @@
 
 			uart11: serial@1e790500 {
 				compatible = "ns16550a";
-				reg = <0x1e790400 0x20>;
+				reg = <0x1e790500 0x20>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scu ASPEED_CLK_GATE_UART11CLK>;
-- 
2.30.2

