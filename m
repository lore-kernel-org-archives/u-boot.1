Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E9AC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3974E80815;
	Wed, 22 Jan 2025 10:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="tkNYjPOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD53280283; Wed, 22 Jan 2025 10:28:24 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF4F807E9
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/8LlW+pRdzYv3xoBstimT1UFASJ5oddlIPn+iSNeAv7o+oNZZoNnvyi38HKiQ2OGTBuchB9TNhHWdwKuq9kg378uPar4P71d74MMX5493+Bk2QtlYUcuPQZ2lCA6zQ1E3Eg2QxBx0BRcxDsXVXSZ5cbdqQbozfrfxdgYlj0oMlY3VClSNb93ARYyYBL5yazJCJ65L+AdmuAqbr/4nAHoJN2Vr/yul7sf5HKPLFH+eI//dOP1gnMzFHMmy66KFSrqyzvHxj6AZcJMadxDS3kk3RYQ1eRrnmpQblTP+JmxKhIOEmcpzaEoNHEcxh1F/GVSCX0LXQdQaKBOIU7uBGTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzI0oc7mT2v9P+qH38EOw/HiwkBq5jZ0QcZ2aCT2SJM=;
 b=DmPvG0qtB4M8QD27+6YUPrwFY2skDgjlxqtCZDRUv95mqO9TXUQTwxWqxm/TTQxZ2/lpEj/EJn7fls8r7Qm2K+lx49SRUUQ8Vpv+jx/1DqGRvxPEVQ0ctdaDLQ+NP7zzWLeEPspkeqj5vxKrmoTZ2dWVssWNSe+RMSP73JmXpORjOys8NTw5i9I7n0Wwl6WsubTyE1agkcGqM/RyqTeD7DMr76mm+joI/1cTXZbWD2N/8zyMR5KMcjEIq/mrReFJ/1ANXOU0By9HAho14mvTqi3gcXvw7kKi4KpnK9mA4Wig4pj4hzdfaFTWq3ux/NUgLmbDNgiKESFus9ypHT1wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzI0oc7mT2v9P+qH38EOw/HiwkBq5jZ0QcZ2aCT2SJM=;
 b=tkNYjPOAZvD3ZS+1l65hfjG7VCop/h7OA6WF6NeS185Qz3FRSe8b5TFLNu5fT0qc7uoyPz2IO0YTrjr5BtibveSrdEvG84VWYk4WNUHtfr7JBLcSE9zQVjMbJhasyTwtdhmOgpS4NNqLiN3kJqLpZICYvFDCt6xGIlfwjFkhdYXDv6Tz7YK2nr8TueO4sD+ZNsxaU9j54kuFFeq0y4f/fpEuKKQuR7pyppOl+BHhc0nbS2LIGql2GXrYjcQHtSsBBLf5hVZsocSHt7pOau/BvIk0lXjxe7ykDubvXeCvimlxV0HhGrWBXv+AvNacdHzwz9NVi305xwdoCcccBcEgCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by PAWPR06MB8691.eurprd06.prod.outlook.com (2603:10a6:102:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:28:21 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 09:28:21 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] net: phy: gmii2rgmii: Add support for phy ethernet id
 configuration
Date: Wed, 22 Jan 2025 09:22:50 +0000
Message-Id: <20250122092250.722356-3-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
References: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|PAWPR06MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 389b25e8-9b1f-4943-eb89-08dd3ac71cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBWm4EYc3pE+atChdeDBzi/V5utMD81nm5efr9XuYeKFhvF3wm5o6nAIJqAk?=
 =?us-ascii?Q?fC06qACe3sBB06koEbNXHoNiGp/jQACA9AZAm2GBdwO1+z9ONFV0AzJTgBbF?=
 =?us-ascii?Q?4ma9F+ZcvsMb/jWrvxiHTozvyubSDgafiL/EZ1qd2C9jdHq8GZNvDztALqk0?=
 =?us-ascii?Q?I2pyj72nw+fuNYDgiWzEVXCyA3t1NI9YRHNieSjLHzn4C82n+scMc2Wj4KgP?=
 =?us-ascii?Q?Gtlu7MrSCk98sQcPSoguFrDhjoj2i7FNgN5qCsHZNqCAK0hVDoMcZ8nD+nxg?=
 =?us-ascii?Q?8qsvA1Xoh/P90XzHs0Ynh/O/NtCPEemJY8eZCM7AjanRCQaSCBbYOwVnXGSA?=
 =?us-ascii?Q?pt3sM9kgcBtzS2Bug4HsW5h88JPRBVAGFOoJrh3R66AubiYl0ZVD7LUmYIiL?=
 =?us-ascii?Q?7l8oZlBptntKpE01pPiLK7CVDAUxEID/b3TVUAOkks5p7bW/9YmJ1jIKY5X3?=
 =?us-ascii?Q?shO3Aevi9JWOrLM+S6SuqjK5wUW3EtGaC+OJd+tmI+NP1/ancdUReGARFg6w?=
 =?us-ascii?Q?+EA3bgQPMR0TCEdO9pRPh1NnL5i7zQssMbHn0ZIR5pqhcbLUcvYu9Nbc7hFP?=
 =?us-ascii?Q?2iP0OvUNCa4kA7TVsj+M6N+t1K6ezHDoKn769DT/mojziOApOLpr1JrL9GQ7?=
 =?us-ascii?Q?MvAiVLMx/CCS8umEo+BzC/vsvDcWkMrvZofeEeQ7TlwqEvxw2YWOiiFxoybs?=
 =?us-ascii?Q?IRU5EF5JWftBtajDt8syuQQS496RaSzyqWplG2cDdzwGfw6nAUzCSKu19Jnm?=
 =?us-ascii?Q?U3nBhz0jm9o9Axsv91rtE01svUHBwh3+jvarIYPMS1hqV/0pJ+VgIhICJNPS?=
 =?us-ascii?Q?C+RHkx0uQDAODbdJoJM9JvBgRh3rKiieLzIHTZLx+dKN3If4JCp/vwYM9NLd?=
 =?us-ascii?Q?USK2R6gWkmF7uqeRxN8bQYYJ07zJCT41ivsRICt2wCt85wtKj9yKnAq6Yo1F?=
 =?us-ascii?Q?+gwa0gUCPD5QgT6i/1tMW7Etx+uq3njyXSRUJDS5GHHxxvOOv1199FRcr5oP?=
 =?us-ascii?Q?rCVDJdrdcdfdRVh8U+v7FxnpQ7lvr7iRMZMviw/hvAEH2yXTJUYrXzNkblwH?=
 =?us-ascii?Q?RTlgmLa2d0iklvTB/t7D147GKYmCH810L6RlJIN6xETw3+nCd6MdDK5W03/w?=
 =?us-ascii?Q?liDmzdTnRtbxVIWO6Ke3Vc5fwmqkG+QE16tB/sVFRUv5qh19Yfc8tktpsxXo?=
 =?us-ascii?Q?gJPtn06YgTw1l27PcFpw0OpGzWbkksf/YuYemxXkxpguFFK1Jn0+GAC5NcWn?=
 =?us-ascii?Q?Io5Qvp+hH0hICZz0LgH/1NG9RI89tnRyqlScFsNejtcpmANEUCblYrqmPKJ7?=
 =?us-ascii?Q?mchVmYjnFIsAUKzRCVMyqwUG9b0bxGwCUVkMO97jlWIM3/His87OU2cdbvy1?=
 =?us-ascii?Q?VuD9ldJdPFncRgpOul6BVbO9FSJxrb4yA5zQF8YcmXuqZb6qI4E2akfiPdQ1?=
 =?us-ascii?Q?VxZ/cXB2mVjLfm3QO2u4Ne9HRm8AGeqM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3P51TAqnEB7oKDQJLF4MzlU70ktiCsfYZvWNofeKGgI8bStJyaT+nTVVn33?=
 =?us-ascii?Q?0x10fhtJHQBGimQC8kKWZluawu+elvo47kvdK0/gy6tMcnEFM5IPMTKbQUA8?=
 =?us-ascii?Q?3JaKZ+1ZcRCYnEtQJ8RMbxVTm7PxphMFa+GPFv0N40aazqpZnG1EeeICj3km?=
 =?us-ascii?Q?PFuEMXuStbUsXxrjsZNLat2NreNUXQCCMtRrltd1/WsJTuJdAzWh/TcPaeHU?=
 =?us-ascii?Q?KhLz1eqNh9YkQ89IQ8xLBAESpe2RhzZLQO8VVsS0cAAP6K11jawVj0PZ+FQM?=
 =?us-ascii?Q?sYaC5imoTiO0DP3sAA+m5nkyfl+Upxol9fpjTmo5Qt2A+/to8RpVE+WsSwHd?=
 =?us-ascii?Q?wlLJ5GUsDeQu/8jPyXrRUs+7wu5yIxn5Y5jce0sVxPRL3msFBR4+MZginfGZ?=
 =?us-ascii?Q?3tFevIaG/nqyJWXkvm7387i5E/IWIL98Wha7DiRHNGlysIbE/1U5IMAJYSQ8?=
 =?us-ascii?Q?MqRIheyxjAF1FCS73ENVC+0cPJhWMzXs/arswEdRqeioO2TN5LbIdqYOucns?=
 =?us-ascii?Q?Uz7/ej/vbKeH8hB3mg0w4BFvMkfKmyc4WmmeZGRQP5RIeulBeE7sJTIVBR0i?=
 =?us-ascii?Q?hnYfuaM/tbCH922YMf8E//oEQ+UtHQ6E2D1eBLtJw7My/YriMgSlCbssq/im?=
 =?us-ascii?Q?VDGAbBo03fu+PBLBnAgFkJOvrZMOg+yXThm3PnY6uYYq7AyaNSTeOWgUQHdf?=
 =?us-ascii?Q?OIC5hBEGrTI/msmtjif+sxvmEDr3br6VIJsFCJNHEDI9YypX0xUbCFeaq/TP?=
 =?us-ascii?Q?lRLtW3B0aLkwCzBVkIecx3kWOFaQxj+tQh83R+jRav81JGIA5X9WEpqhQj5z?=
 =?us-ascii?Q?OYcOhwoIgacpNsgHIu5TvQRuaC95MTPJHTCzmbVhyFJeIxKL5qMEwzH7CEan?=
 =?us-ascii?Q?zQ4WAaF8RcQPfLAY1kV+DmmIrpsr9yvsVr7KxYktTZ2OMayT+5wRIqAGK6mf?=
 =?us-ascii?Q?DM2tzHA+Ir9cWylimy3sW32O5fYMAtfABrKILlHm0GoPxhQqfAoblCzGwc3I?=
 =?us-ascii?Q?/uNu5Gt9/yd0YfCjAN8PABpnMqZIpHKeWQueiJaXezjzeaduOA1TgfT3f4eU?=
 =?us-ascii?Q?dqjJBoYcpfax4GYeFWFVRN0kCdOVp3pddpBCZ638PZd3AE3W2NLyBzE73na9?=
 =?us-ascii?Q?WvOH0V6nk1fck+SDmcFh70+tfA7CmMceZ/9ClgGt7kHlMPWd1FZ6qXEwuf5+?=
 =?us-ascii?Q?SVP1/hLKhp2PNOXpIgxeMr6VP5Zp0My7IYZOOHPQDnPXFbFcDc3xTJhreXSO?=
 =?us-ascii?Q?LT2fFd9+itreV2yu4oCoEviEjls0/kjtba8y8KgE11OLoDJpDQryEbxxJrd5?=
 =?us-ascii?Q?egtvK7CMxnoitmW98Iw8K5vgcnqJFJAYgSKmJMG68r8iOxd6i5q27YNe42If?=
 =?us-ascii?Q?mSp3cs3iO9b5CVOCPz4lCoAYrqQNXRdCvhN9BdqpMZbbJWcgMVnqslBaaGxf?=
 =?us-ascii?Q?EFV5i/cbuhRFtAQnSg4jEumwDCId9VnDowEHNh2lrAmcTnyjatNVnwdU2iNY?=
 =?us-ascii?Q?qBe6DBeZGWFjIYocNdo6JVD/8TU+lnTTV/VGB02/aZN/2Igs+7MQE1VA0m27?=
 =?us-ascii?Q?1pzIbV/nCJiWlAr/cmAZmLNWA3MVmUzbXmI3tfk7j0DPtYFfFDyJJJ17D6UP?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389b25e8-9b1f-4943-eb89-08dd3ac71cdf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:28:21.5036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EuXKbkh4sPzqVLMU8bv4zvygUYJg+6zGnrNRRypBB9cy+X9JACjCi6WndQZ/LRcNm3NN9LIir5yoeDEVszr4OWAqP4Gjd9MuhLH9Xg6b2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8691
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

When Kconfig PHY_ETHERNET_ID is set, create external PHY using via
ethernet-phy-id driver to support using strapping resistors
of the external PHY.

Fixes: a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---

Changes in v2:
  - Fixing inside 80 chars per line

---
 drivers/net/phy/xilinx_gmii2rgmii.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index e44b7b75bd58..d860f4c37856 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -18,7 +18,7 @@ DECLARE_GLOBAL_DATA_PTR;
 static int xilinxgmiitorgmii_config(struct phy_device *phydev)
 {
 	ofnode node = phy_get_ofnode(phydev);
-	struct phy_device *ext_phydev;
+	struct phy_device *ext_phydev = NULL;
 	struct ofnode_phandle_args phandle;
 	int ext_phyaddr = -1;
 	int ret;
@@ -40,8 +40,14 @@ static int xilinxgmiitorgmii_config(struct phy_device *phydev)
 		return ret;
 
 	ext_phyaddr = ofnode_read_u32_default(phandle.node, "reg", -1);
-	ext_phydev = phy_find_by_mask(phydev->bus,
-				      1 << ext_phyaddr);
+
+	if (IS_ENABLED(CONFIG_PHY_ETHERNET_ID))
+		ext_phydev = phy_connect_phy_id(phydev->bus, phydev->dev,
+						ext_phyaddr);
+
+	if (!ext_phydev)
+		ext_phydev = phy_find_by_mask(phydev->bus,
+					      1 << ext_phyaddr);
 	if (!ext_phydev) {
 		printf("%s, No external phy device found\n", __func__);
 		return -EINVAL;
-- 
2.39.5

