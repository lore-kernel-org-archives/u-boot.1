Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE19FCF857B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 11:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AD3840D8;
	Thu, 20 Nov 2025 12:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WXGTWHbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DFA83956; Thu, 20 Nov 2025 12:24:10 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4243B840D8
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 12:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxQer2zDytk4ALSeFVDC85g2oVouRfRVr1WFPcm+XcaRodCX/gDpTRpFl98pFEeNMI3uWL21RJvIU3FH3jfQYlqTNi6WekGXX37odeSlhCCsWPjC6N6FmtqY7v9qlSFO++C+6frm1fm6l753IWuYhnbIq9SJmDw3M2WOpfV1NrKlbq5MWWGs5PP60dzviWaNKhAde+dBGXWgB9XzzHpTXrwKyXM+w6BNubMxXGCH9Cd8DBdARSJT+aTq/Wrb4UO99Is4MRXbDHRB3bVFFKP7GfsZRL5h9MXGj5Iu8aPKvt2VfTuESk0uc7JLhKbJQFqFKVFnfLjDuu4C97Jp8HlHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/P8MzbOUx/fbfNsuxg+MjN8Uf7aBaeMl0UwPUztv7c=;
 b=Rjx5Jq6cvhUVUbOrpLngnnabvR8smU/Q7Wi2bBrWxN+NgwyD6tBGX+gnyWyLkyCYThQtK/d6guSLzr5/OTF7m4vb2ylAlKPJDfc04A0UX5lKKGmH7/6lYnkOI+VN3oObTMj7oRVFsIVRoNBFTP9TkYfUi8AoATJvOEz8x1Qr3aoQqVycClpsegTiYx0SH7N94BE/SqpaTyydorm/W84cCfYwNSGB7HbPJ5Et59qDjwootGCSSOH9fCiTInqa/EiuFWpsuOuYa61U37dLfSuAB5mB7BpuGPFM+DIJkAaE3/5hnlDVaUEQ5R5S2wNzqKzNvsBB9Hr2O5yYHb7W+Hh8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/P8MzbOUx/fbfNsuxg+MjN8Uf7aBaeMl0UwPUztv7c=;
 b=WXGTWHbXROTqFHdeRtd+Dv1vxfpFN4St+XVq6hT4yAQbwBx5kgEf76N/V5772AqYnAQeOHkYALSGZBZw28Vs1GzLJMjKBu2Jy1NZjECNBmHD1zFDcjOXPJMqJNjWdmYMj8Pqq3lhsxV+cyvrtzcDlzMrg0z3Mq/MWAlRHdRZFjLqbae/RtqrR4nN7t1GX7OcNe3JbDBVneHl8i7TAUoLKX29ei8J52rMqjlYBwdTpnah7NYP30zRgRXiee3r1M680aM4WM4mDPts0nx2oATkSMcL9BdIksYqlV2/RXXFFdecOvM5VmDWUiY4yGR3qQNXllXQ4DxW7f2Ufe+IaewS+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB11992.eurprd04.prod.outlook.com (2603:10a6:800:2f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 11:24:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 11:24:06 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com
Cc: alice.guo@nxp.com,
	peng.fan@nxp.com,
	lukma@denx.de
Subject: [PATCH v3 2/2] arm: dts: imx8ulp: Disable wdog3 until DM watchdog
 support is available
Date: Thu, 20 Nov 2025 19:23:00 +0800
Message-ID: <20251120112300.1242106-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120112300.1242106-1-alice.guo@oss.nxp.com>
References: <20251120112300.1242106-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB11992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6914cbd6-4ee0-4c2e-107a-08de282750ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hI0Nr7ujRWHkL4q5yRJpbsBjsSrCA6UY3iMQ+beygMF9hVc5qRm/TT3chZzd?=
 =?us-ascii?Q?jWivB07YMSXsQmSIvXrpVXIgfTvFcMSUPm1ylauu7/6eHRw+cqKtkzAm5mb0?=
 =?us-ascii?Q?wVY6hJoO35fSLSk3SptYwoJbpN4rW7pm9KSjntCW1QGkHq6Lbcd9ubnDoZyX?=
 =?us-ascii?Q?VfhshqhUsRSyWHchkJ8FjSH5Y49uwaTNKqEZqxu6XzDTi9dLONUs0k/2iepk?=
 =?us-ascii?Q?2rof68gDB5JOu4YdumkLR7yWp0SkFlSyc13zve5fAvVNrd2tIWl5Id3FrrFV?=
 =?us-ascii?Q?NSRp7mEgAo9Jf1GHC4pO27KyCLUtogZnSjA7pebSzIblC2th7zOYdZRQ69OL?=
 =?us-ascii?Q?d+B0JIjGaVb1tnJq2zBQGdJUYsLmJKmOt+BnGpea815GwlnL8KF9vmuBCPxg?=
 =?us-ascii?Q?d24xUp9QCpEkDJ+K15LXk/nZVIrPnqfaMeTGD3Zr0ey0AVw5ZT+GEwPeVPe2?=
 =?us-ascii?Q?ebmjbJZmaoI4g8qVjrblIlZ67GH0TqF/In164LmCOk93t7hbD05ggHomR9ZM?=
 =?us-ascii?Q?uo3Oj8SW2Xii3hVQmB20s/EFVKyNyVZ5xGpxHNBkk/I7ki0fRSg6/eL9cWea?=
 =?us-ascii?Q?bkUD6VQNqFRFFYYemAMAEOb6Wjv7gaxZ5gB4MuGHgZif29VqQipUeKIxBlTg?=
 =?us-ascii?Q?BwsmfbSBBM5MITIjcIu+U6g4Tbnai2mGL5/l2sH3AyHPk4SQAeldVq68M1GP?=
 =?us-ascii?Q?Q4l7NSDWHR/hDA/FL6FGIt5pY4TPR2wXFw0b7O9UeBaoIGpWBwUyq2/UJmMo?=
 =?us-ascii?Q?wvcAzzmBlezltAsZYmKMXPjzfeCYEQxbVlsvaoTSiqWK+/Spjc3tXSKi9X/8?=
 =?us-ascii?Q?shsJEecURdP16n9EcUxWgNamBieZo2KoT8l7fprF6xq3pXLNzQnxSZj9ljLD?=
 =?us-ascii?Q?1Rh7MLfaHd5gO0Ug/knMg70NBcd1oZpUxVOQ0A98S0xaSfaWDB55RrOnyZR4?=
 =?us-ascii?Q?wpT0+vpAMzWNj1jWt13ynARtDdTTdEf8CLoAudEt/krHhJlRKJ0tnMQgKDsq?=
 =?us-ascii?Q?kQMceJK/wHBixtxM96fc1WFCOHM+gf5F6f34rlKMMJrZZVbw8DeijJrDzhYJ?=
 =?us-ascii?Q?ug0S4/mIinly5O8gr7XtJSW/D7W9CPgzqD0OsUpnHaLZU+oY9T+fVgeJg8q9?=
 =?us-ascii?Q?XBx44z4Oeyi013MBrwcd6TPP8fIu7HShpWGIqYaQVV7swwALtPgTMPa+B5SF?=
 =?us-ascii?Q?g2io/cvmcwgruwdIiJQsIJsFw6PaVzKc2g+GWxxnEpb/tbcUJWshkvuS2flz?=
 =?us-ascii?Q?1W8nY0qzfVWlEhbeagvrBRd3dUrUSunEfNZYQFrHUozUkqtJ7DKenu710mhs?=
 =?us-ascii?Q?PDN9GG3NUveDIGimFMDErPi3C4Fyh9iTCE3EO1UClsFyeitnfHNRDBpPRq6k?=
 =?us-ascii?Q?vp9KNBYKx+am5LIjxWKuUcHMOUZgiRvzhtBJu2JdpH/WJFAnnbMBPa0O0Ie7?=
 =?us-ascii?Q?XE4kHg2UsyV26EQT8EErIo4GbW4N893qH1W5qhh3gJqxm+xKLJOGoHKWSDZQ?=
 =?us-ascii?Q?aYqsBYqUgUybcj9Ou5JcGTlykW6ms34d5nfF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BeD0V2mIvbnWC9KORWp0XfCIhR34Xfyq1J0FJKUjwSmFR7NjyE9o4KU+iyvo?=
 =?us-ascii?Q?I784XUy6aXBomgdxY/gvf+JJI/hNeCRpMyugnhOGa6v8HqeQBTQ+HOUsZEgj?=
 =?us-ascii?Q?c7ayNhmlg5DcVGRGxc+XkRalR9SaBHJuhLr9nOuHegzLmLfqn5sgw0X1lML+?=
 =?us-ascii?Q?KY9HFrWlq15VIMEt/y1VJi1bJtg3HaHKg+MvmyS+CLmu8WgMGOg8Blbjij2C?=
 =?us-ascii?Q?/mF8IZt1jWb53NrgZygsvQ0h8MFwifp45WQuLq2ZWogmra9q9u8N0AbWCZKu?=
 =?us-ascii?Q?dwz3t6jA4p4Fbg/78UR8Zan1UYKAPmSqUh87xUDV4TpLxtXiJi/QirdE4ELl?=
 =?us-ascii?Q?DJzni+q8LAxwpdZmWYo1sEdFXvfAxoe0fx5AuttU09TlJQSHZAFBNzsrJ+JT?=
 =?us-ascii?Q?Jgk5zfM41dTr8IPns0rZZ5O/wzBi52lljrlo84JuL3DdGs9prgBzVV5mx0EZ?=
 =?us-ascii?Q?3snv4WfRQHeRfs/B5chgBl2kmeRiFBYgHi7ru5K2pbxFBMcSKrhxHL+uJ46q?=
 =?us-ascii?Q?4G21et5jDAqtPcnZaiMrFWkYHfnK6l9Is6si3K5nKyLth15JVM0QG6Xg5htp?=
 =?us-ascii?Q?xKsrzO643pEQIrRPbgqJnU2upxyX3kKpeny6JQUGwFPM48RmdWeUwno5j4tV?=
 =?us-ascii?Q?PZ9I+ZUPpG5s2mkWvO+xNNnxmMwelzhfKCeG6SpPyQQFWreAIrH9d2ifbWTR?=
 =?us-ascii?Q?DeMLEXKOfleMF5d+24CykVucOtxD/jrBIAuvsuX25zFX76pSmfD4vD6+aysP?=
 =?us-ascii?Q?+LZgy6svBF9iU+oFQZM8tCZz2VWdApv58Ne9WAbEa3Le0w1NvwRCakWS7IWa?=
 =?us-ascii?Q?4hsFvWWhl62kY79i26IOYlL5sbeLqvM4jhiyRaSwcEUw+eTLvzZ9q0m3JCg2?=
 =?us-ascii?Q?v+OzmWgOAz8mGw8bnN46PGcVaM1WfarjK+elKz5AoxsoT2XLN4SAkxGwE5XK?=
 =?us-ascii?Q?mXY2nlUXQBYBu0HROGdaGI5paAKRMKkGRc3mFWix9fM5Lf8jfuJ+7U+iqHR8?=
 =?us-ascii?Q?c0QTLcKBQbhpQ2lrB3/BUUuuxhmz9ea03JVZzT3yBfU7mQBT9OZK6CIzLkym?=
 =?us-ascii?Q?z1+k7Wkh57vz3Ic6zTEO7m11pWZDf8H4J4xwSsczCnbQN8cWoR61wMOe28sZ?=
 =?us-ascii?Q?p1EVMw516W/1t7Ic5K6Qnh9r6AE6mnE2F3FAfBA8XQFIayVKM5kI+vtMTo9X?=
 =?us-ascii?Q?hW0YqQDzXRbsmVWTDp7iCAsPK5f2xn90Zw71e1Wfbv0QgcAsHMU6CmaBebZx?=
 =?us-ascii?Q?HaAckt2BnCt2Mmsnd+kpiI7G7nrLa1msrOZ/0n69CVsoGwRH6bvlinjFPLw2?=
 =?us-ascii?Q?W3gUZbAKZh2xQJ27WEYn36ywCRpzpFQ0x0Dp8u0N+h+yY4A6HHJU2k2PQ4rE?=
 =?us-ascii?Q?FmBenuFJ3+PIywk0nlWyTNBvHREzlf+FxXhcBvyekJQTfjhvFUl3mlMi7hU9?=
 =?us-ascii?Q?kg0XScPwYgBA6kODSVCSAOY1KhszBKsyInJiV9oEaEMpZxzmIDz9mQ1pVXaO?=
 =?us-ascii?Q?5YPJtb9Ow7cqq+jyQkcFuQc+yElRCCx4RXvq8PCbLf3dU0VE01jahhmoUVmG?=
 =?us-ascii?Q?uXQq18/THbtqkKr9NrXKjVe6uVdWrSnK/VoKqq9m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6914cbd6-4ee0-4c2e-107a-08de282750ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:24:06.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snvouu2rYIa+nouNgLHC0nzk1ERgifJvu8aU12jysOzh+EOjgnhyxk0MSDHFTCV4GxacX4Y52uBuoYqx1m4G/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11992
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

The driver model for watchdog timer is not enabled yet, so disable wdog3
temporarily.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
index f1c6d933a17..7aec1706382 100644
--- a/arch/arm/dts/imx8ulp-evk.dts
+++ b/arch/arm/dts/imx8ulp-evk.dts
@@ -119,3 +119,7 @@
 		>;
 	};
 };
+
+&wdog3 {
+	status = "disabled";
+};
-- 
2.43.0

