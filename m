Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DACCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F4983B91;
	Sat,  1 Nov 2025 01:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xASrqagO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B233283BCE; Sat,  1 Nov 2025 01:45:33 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1509E83B4F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvCYwdwQKAgxXYira3lRYmfHTabQoKKe8/OoHo6hn/uWN+0ZXW3RN5v5UvDVu/2qzUpzpiSPtWC5udXHsnS126NFHSj7BkJvm/Mec7HgFF6Q8eMac/EV8EEMwS/A3M07BE5eFj+BMN5JQWeHuhfXUkJ4GG/RxKnfGOcPAM4+j4dzdxzstoh3weNNersRiMnEIrGkYGh+8e4AxhwkMHKgoI5SL/Tjx/g2bAYhjyokbJLAg8+FXUebpKRv66sArKDdcI2LjY2gDtHsoHwDRPpkduhATxD3gcFlHegqhm1a+Tg72o9qTyNHmBbkNnuYizXiDOsgb13nBvl9H3AoiUrbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gq3bJtawCNwdsKBpkiq4OrzeRsVyKAonnABBx3qMz0=;
 b=nv7kQOHfnTo5icBsxlbzopspVCw/pRU+5MIwczQjwVcFb8N95cdTAnM0MwJC/JPBByD9sWEzHFI6QqdJKAk4gT+/bxfH0lGFaxbQxnXI6leP703VkRUkTAnVDDwGldIeAxSHtZiqpglv0Z6ry2j1ev6ayAxZAtZ5kWsY/MVxcp3cCoWU8tTNahMDfJYP4GPa88+N5ZiNNCijdY0yXe2VlAt69SK7COjbkwBv1B85ZWyWDAELgNnNmzOb9AIDPb4UeoPvwaN8rmxbXx9YurDEOe9bA6prOXLfNneASO6E62XsouvEfTxHmOYsnSMPZCpq0f4CoWF6x91HneN5KZA8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gq3bJtawCNwdsKBpkiq4OrzeRsVyKAonnABBx3qMz0=;
 b=xASrqagO53VkTxuiS7KsBryabAW7fUnZinN2JPeh7ch5vtzvKd7KuBGew8K2SCxU2su4Kd+0EuLKYq3PpBg9CG9F6CkT4aDPOh3LYRUMeV4jyMeC/6Gm3y8MycM6pOimcBhsqc8fwqBVk/DHo3CkBJGp56eaZcvEHAb856tz6u9A46wGDuk544P/BAzWF5iEyhVTCfltL7ito7Z60mlt9TfAAWiwLmTkMDijikNd0uZmPYtlyTB31tnAFTFkJ0PkkI9qI51SI+AUsJCBCEPi16MydkaSnwSorPcmKJslBwgx/nFTMfd1ciBYwj0CdjRhfyG0Tdpd2cSlWUHvZirQcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 12/19] dts: airoha: en7523: add reset controller support
Date: Sat,  1 Nov 2025 03:44:56 +0300
Message-ID: <20251101004503.2379529-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c36949-f319-4fdc-12af-08de18dff211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNP3Ljll6iMWr2w9B4yixwKG6HN6A4D98NjJPWf2E/0vjKc2fzTltGqje6/E?=
 =?us-ascii?Q?uRfkvsdguAd7rI6WwWqqdfiJgQ6kQ10NSfxhfB3GUa68+OVLJJ6g/PxEHHiL?=
 =?us-ascii?Q?UY0bwmHS7OQyV2WGukXBGQLbTwiP2uZqY2rHtqZeo4IDxgHGrHrOFgeXKhxb?=
 =?us-ascii?Q?YpaP4utaWE5g466VtCTw24QlE97bNlxQY+FKD+lf+1clHA0AsoyZ2kLUk3Hx?=
 =?us-ascii?Q?DLAWGKcjloqw/dQHajviJ0OfYEgPkURghOjLRHiJjkW7hXMrZDNamLjYlTmQ?=
 =?us-ascii?Q?08BK+3m7Nyw8DaxfXMY8UrpPx/0/3+N5smfhfv6ur5or58SjqL1gC2f7SvGD?=
 =?us-ascii?Q?FGul6LViCmI9G6pGPv6iAc/6ADbsUfJhln7GtJuCRV2NnXkWdDs7GteJ9gic?=
 =?us-ascii?Q?Kp2RtHOOaZ9qGvLvMERFqQbpwwoyMTh9XItC8E2io3M7Airx4MIRo0Y90ilb?=
 =?us-ascii?Q?KpfTlrIap6+Ju4y5DhAvC24XDwB4vGAXyH7c2xHk+2aogoXVVeTYv4OrAxBx?=
 =?us-ascii?Q?Rcpq4dJS/LLmbjY04tfjXvhvvrDbMCR6BC/Ab25ptbFcj2H0ZOZJ8d1RrILD?=
 =?us-ascii?Q?pc08eRuhqBl6Xj+6giQepZsCykAJ+Sd8lCQ1ZPRADcFVOqLPKB3Z1z16YmP1?=
 =?us-ascii?Q?r/muOYqukik/QeNIydAVew8mKQAzqlAZXiEz6jPIO4T4NdhKjOkMR6ayXgYZ?=
 =?us-ascii?Q?aJstY0T6QtjngIvDBn5LCodzNdJTCjLOzivZidTbLHnMrqifQuH4TObhIv8a?=
 =?us-ascii?Q?M8LGFlXLnJ/yt2GNS+crrNa6Q0yWCtzbWuB5z3Z9HrmuaQg+r8xReAtjnncB?=
 =?us-ascii?Q?zMf5hHhSbX5eiVHpYQFCtrNrt9viGm+dllAFapRuGHq8eDH/2YKElVd8z0GE?=
 =?us-ascii?Q?1RsB7tGEDt+12z5i0PSV1Ug2sCLma5nGAnZMfETpeEOj6wwxHlXksUnPXVkn?=
 =?us-ascii?Q?VskGIr0wpwuek8V0xdbw3vwx5HONbQTBSAvtBYt50qhNIO0yBsQQkM4oFM7K?=
 =?us-ascii?Q?x2V9nlQVm+a+3oOXifzbRPYWpt1QNFzMRZ4fgNigB4ueqI8sxtMgUSrYL+5u?=
 =?us-ascii?Q?WYoOFRXuER4qVh1YTqwkv66nswZLQ2QJRa7UaRmza6Ed0SynH+mWdGuaV/+8?=
 =?us-ascii?Q?dXJ53+sKTMKfoV+gup6g+GQlscIJ9F7sHHif6iDUnDYhvpHUyk23dFxN/JRS?=
 =?us-ascii?Q?+pxvIG9EXgKDkOa8yhqeekNUciMMQLzsIOMA1vFnjAYMEK7IJ9KXvjvGdBmP?=
 =?us-ascii?Q?GrEJGgUSFfMuCXTzGAcEaAakDyEP+lQWfUGQWY/OqOiq13l1OwDAzOl/J1FD?=
 =?us-ascii?Q?CDhRiybWt9m3deqHYEifCE/4hdHXdzjdjfcsgs0qCpcKb/5mRsUoKed0Ikii?=
 =?us-ascii?Q?vVfJnKPYduwgYTXHaPszDPpqYqMTXcr48HqHgPs92XArIYh2oqcy9yHCLCQp?=
 =?us-ascii?Q?U4tcqAT+d7dwNnjZJsbJrYyLwS5JhCdBiKlSE6Ahp4JzSrrdA5EGW+qgMJBe?=
 =?us-ascii?Q?z2+2QP5yPp5/gvBQfURznX6sQxb/zheqbzA2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m67uQ/fDbudP4dbZcKjxQXwdvDSOwkO7Bm8dcKnWbtU1GS6KfP8uV8a1B/dW?=
 =?us-ascii?Q?3yboopG4U8sM/ckh0iA89HKmrDdOc2pqgoqy8KgixXW8sujWd2nZORp1dOsj?=
 =?us-ascii?Q?I4z7WAlKmD2rsWSmx8JOOX/1cj2uIIVUFQF2dqdfrDekPms2rOym+nwnkLhw?=
 =?us-ascii?Q?FaGatTc1F1XQIzRNPTyfjeb3Rujy4xVVJdZqOSyUljSQuNd87qezsRsGcIKp?=
 =?us-ascii?Q?WkvR9uI4btWdDYGBG/zWjjqIbk5X0IFSGGEuaHykNWjcjCc8MSm2bqYXoN0h?=
 =?us-ascii?Q?U2QUDRNzsCvgEh/XNma4YewlW9uRRXJGQZMfVTly4FdMp5ngsGHMZMBXUTb6?=
 =?us-ascii?Q?1I2g66UaQaxW+AlRR717rfklxzNYbGkZo3INIVLA48XVryDKfoCo9t5Rrr/b?=
 =?us-ascii?Q?+KiwmodFhgeaCWdwzUPFYXEfjuMIv+5fiQiaOMwBWbwyzmLhn4j7WJQDY/J9?=
 =?us-ascii?Q?r3TZ6dsZhPzmGfXmGs3r7y9RkzrUTYYcNlU05mahAqMHIzfMieh3mp6yB2hx?=
 =?us-ascii?Q?wFDtUGUVFNfyg30W/3Uf1Cvtv2PYhyJALNYYLvIZJOA/CVyvN4PsODGzjo9l?=
 =?us-ascii?Q?kl1u2jzgtsvGdelhf0hc1xQBUsC3XQTg2V94OaNRfg3WA4Xn9HCSdLqd2r/X?=
 =?us-ascii?Q?dNKyb5UEg6WgKXRATy9zsvHz4MxY7Q1gCfvt2qNumlEGpLoQTWjuiZ4oPwMJ?=
 =?us-ascii?Q?sYiZ3Lh38A2ZqxyF7ILzvJCa8bBJO31A8+ee4gi5DcuNDN701ON8Vvbwz8qH?=
 =?us-ascii?Q?9DlDqv6ldfPyVIZPf/Wq7q6+R7PIg2UWm9q8MFuAxkuZ5U7h3ICB8gP1LGh+?=
 =?us-ascii?Q?1W2/OYutPFfGOR0b7wYATj+P3w7YzSfzaGkVEfTnfJ5bSlh20aseCAHpqalq?=
 =?us-ascii?Q?X5hOhvCA6Xi9CADYlkQMuJuMezfBzX8FLFN1DRMBCuy5Eh0F/pRPcCI+RUHU?=
 =?us-ascii?Q?gp+bgS6fHz8vub82cXlqancnXkgaSj0DnvPGnM0SwipmeJxPeydljhbwJCgK?=
 =?us-ascii?Q?metyfCofK/b5Wfl6jKS9qjFPbZzGX4XTg6Id9lltKQQtfM8YrcRuqdudIJlU?=
 =?us-ascii?Q?4aob7qE5lUJvuyoeN5ea4OdLVJ6uESpvpr7V4VXkn6HOOtJ5zUerKIpPhgxS?=
 =?us-ascii?Q?n1Navf4y5C9nGeK5a5jgZd0qFYm/oRHnNTJjEwi0yw6PReeXyqEPvAkahKI2?=
 =?us-ascii?Q?6zNbj88pKQfMhEE3GFj/1x1slUwS7dcB6dS70fz5ZbkA663IBcF5za8nKreI?=
 =?us-ascii?Q?TH9+T7T6PHZf5396vTjzZHc/Qt+PFkQsYFphFpLwrERVbbTucCVa4mRmkJIn?=
 =?us-ascii?Q?GR0qdUbkLQrV/4F7srl3AjT5wqo9HlasNbAk0d0vV2kWnA2ez6D4Ql8F3V3b?=
 =?us-ascii?Q?gNZPM0J8LjajUFiQxu9AJQKwmXT/4gjCaFRYe5+5gL4AdlncrPySi7WqvG7Y?=
 =?us-ascii?Q?Ts9z54YbowCp5uRdX0OnYIph6GW7tD0OwqihzifzwAbzXKHNg9Kc5l8toCn7?=
 =?us-ascii?Q?zeT++Z+B46YgAg39qmrUWetFxwd6AtT1lTUu47xjOmHZDekNELFX7GLVOCWp?=
 =?us-ascii?Q?HxcJm9fIcuQ90JkHwdiIsipIGYw3h8qcrg3FOmLjLxo8JO1KVKItD1NCdbjZ?=
 =?us-ascii?Q?VsIR3aidLiKtA3LzW4xgrr0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c36949-f319-4fdc-12af-08de18dff211
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:25.2895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHKkpWGVyYPNycbywyZkZr9YTcDBPxhAVoOSkbO2pR5VC0IKynKl5C3QGZGEMPwh/rA+qd0Wsuk17KwktiqRD4PUpjo0XUlViJJBXxiK5aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

This patch adds reset controller support to en7523 dts

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 34fa8069f9e..e5a84dc56eb 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <dt-bindings/reset/airoha,en7523-reset.h>
+
 / {
 	reserved-memory {
 		#address-cells = <1>;
@@ -17,6 +19,7 @@
 		reg = <0x1fa20000 0x400>,
 		      <0x1fb00000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 };
-- 
2.51.0

