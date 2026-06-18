Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F3DCD98E4
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAE5849BB;
	Thu, 18 Jun 2026 03:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nj/Pgl/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F000849BC; Thu, 18 Jun 2026 03:15:02 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF74F849B8
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6tnmL3VJhk48inNBVT3LJ2P4WMjdMGGit+nc6JOyfcmzpsvO9NWDNH/JBf1T9ZAPyRzaBgQVtPmHsvQwCdj7507bi2t7Yem73RZLjcVxfuBbGV4109iKcJU9vFdnfOFilZO5zvZ0uhClBIO4yItTCGAY98NH0Cru+LaduZbG+3KviUaQapqndEWhrleoReXAbto1emKHHNEcZpWCDPWf6K5aBX8qMz05yUhdJgDhcBqgH5hfW2maoKjWGdITOJ7EfL//ie8hEu39gspQiyKAhBPpvX6q84GoHynfdv1h5LYfmXX1mCym0W1ZtCUz2Lzz8z61ljkk3WvQ9MBuKcyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPxtJUPeuEh1Om7U4kTbfIII38wD+dE0nwUwWc0RWmQ=;
 b=uBrxxi6vUnro2l2HOr97iiCPIdLLMdjoRoSBcIy9v9d0HZf9vAVtlA71Yoz7JE9PnccnHl6aN17tRHBKJnGtuSlRTpI0pVQ3O72NfbtHiLGY6VqaYXjkvdAOxhjiVHdULXei02Dnc8e/NTbpZIm4DLY0PnJPwrEpC8uuNwJeCxtYx0ASN4bFyNGkEt2G4WdRGkgA/ACKmzIk0Ydtt0yW4BROOoCO7JwTb+DQNhIlKPVAiX02Mmo+TXb6fO07GKj1XflB9olkzdSrSpS4uRxdvBGsHrYCcxJRPsVp+IodCIg1pcCdbzi7c2fzKQjOxYzbeHvmSrEZRyg9yQ/eHQMMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPxtJUPeuEh1Om7U4kTbfIII38wD+dE0nwUwWc0RWmQ=;
 b=nj/Pgl/4wO/EvS8FyVRJP86sHYue3WUGqgs0bFBZhG6Vw4MiVx5NHfHjxvVwteu8+fHnGrPWdRUaME7PZleE1f20MZiZDj3Pd/9/zPQlbFslP8E+yez1dMXplsrFWQvWBBPrurneyDCK8WpkBzgxQg5jEJjyuEUyEMv7izQWoyK5IxxCTwJv5IPbXvUyPmBpi64sx6ZI4VucwAR0Bj1qUfRs7J6xsR7AHVnuHo6OXf4FNbMDGNW6tUKO1urCgcyEZg2/g4O7OT7Ih+AOATREyCbvQgmsevd1q+RYqVkrksUFk9BHHtwczKYkV2gSsGFaw8LGK9sWNjcMvI9Z6n7eXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 01:14:57 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:14:57 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 3/3] imx9: scmi: use 48-bit MAC add instead of incrementing
 mac[5]
Date: Thu, 18 Jun 2026 09:17:49 +0800
Message-Id: <20260618011749.2871269-3-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618011749.2871269-1-ye.li@oss.nxp.com>
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0300.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::13) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ca12a8-2822-4539-4d90-08deccd702d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uFMli3prQZrVQLs/jT7mrbaq2m6N+xDDbgdmBjxGqLpwnfXt9hzg5hG+ParKRR5szyfDtvzZjdDFPQIcCuyKWmz8gvKVMf5JnWZHr9tAOY7v3ns+4JsyX87M8HTlAPOLozCfKNjUh9SeG/oJpL813GHYsbLLC7e6HVYB8b+qhUJdE2VWfG1Ae0ALsgQaqjxUav7bJufgAB4wYG8LcIxSiwnjHSn6XaMFLfxSqKrxPVtLziUcpyGFW3ukqkfBEQUMUP2OWgcLlLPabXWsOh2qnHjizGfiFRbIKCUFRgitw0NVWxqVONWaCf/wGN2Ypb5i746GhZtg2OhEfv3cHySYfcaT/gi1Q4P48VBjhKEYrGh/6bWXxBxGdgFnJq9CMg3CokZcyVemhPS/IPBYSi2oKZZqn/JUApvfx4in8Rq7RWraU32Yj90yPL0hupq4WZUP+oRr9cLEr1E4uQsNv5A7ORDfY2Akv/I5cSKAtXv+tCXb+L7eMbXBSn5gw5e07jqYon1dWJx4dVxgsL3rJbMM5E7/iZw/Dn9GZGoX6rfHiFGQ3JKH6DZUdbatB2kB7JGRXgwMBjiqPcRcGnVVtf8nGRqnuIcpPGT/jtMmwX+Fhz1fPR8gD0vUX+CgPGsrQMjfygEEIbO9WI0h2PLGDXpupYQfPx/TmAg75n8+lkBe7wPO0N6ulwXNHe4h/If+BjFP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zgjbQnW3W3WgqoOAiVzyuZnul5Kgl0HPLSeF/NV5GZxFyqMCQZ9PkYhjdxM0?=
 =?us-ascii?Q?z036QYAZzdg9M7RE2RZwxEAcxsXF9pBvh3Plg7j4CV2qxC4JAntD9eokKAGb?=
 =?us-ascii?Q?FQf/YbIFjtnA4K3B0ncVx1IQTo2Bg78HwmZT9sAHjoNf2WZRwH2tpykT8h+d?=
 =?us-ascii?Q?dsd48jFuijAe6QU+qgPMQLs54xUcHMkgDY6yS0AoudJxDUh92ejim5B/2dsg?=
 =?us-ascii?Q?k+Z3qDKCCJIoOxjJD6Y5/A99iW8R45G37Fw+2Us/9VPDYCsDVLwPJuwBRswf?=
 =?us-ascii?Q?LcidHqn71EW/VNn8xwycmwYKVGCf/sgCbbGF8D0xtWdwR7PFNYq9u7V4+OsT?=
 =?us-ascii?Q?S6Ijnou7CfW0T+dG8pCJxAyPTNdvnTYIcWSgnUnuvrjXL1CLNnbiohwDU+Ny?=
 =?us-ascii?Q?dokaOl5RYXN1lGHB6cgZPBrhDe9O0a6U0jnE91Z8K5U7ynCtK2cgSrShG94z?=
 =?us-ascii?Q?hsicytZlqtycDh7+kL1JM4oheKdl5OMNqC2Oklzh+suBeW2TgO0DbTGiSDyU?=
 =?us-ascii?Q?jA5ALg/eGWH3WPAqIX4jOb6lNRq+CfS3g5UGMudokzzeHYd3EM7y9dLa/6EX?=
 =?us-ascii?Q?BrPIDdkNT3h7Jff43Uv4ZtWmeKMO5EV0ULNM+VkNWCzTBT9vGpt58OooqX5i?=
 =?us-ascii?Q?cL35ew5psMpWJhULhPnlr8sH44GIOCW8nltM1j1gmfDOvbzGViMHjFFobuJI?=
 =?us-ascii?Q?J2U0cksofUDZHCtqI1a/EVzaMK1oqgVVW9ay70WGKFmaWv6uCQMlVGU4i4WS?=
 =?us-ascii?Q?fXoWXKc7NXvclzGgKuAeLrRVFcm/zHSi3SbT4WwNQ/Y8+yZZrZK4jASiv0p7?=
 =?us-ascii?Q?zV+Kg5w++xg56FjkSEHuyjfgNiOu21ZiYnFNwyUEGzBA9zOoogF4Yff/F0oZ?=
 =?us-ascii?Q?/2YvxGb3hw0YWI7s6AlAQ5REUt2aqaFeWIXH/v9J3UqV0EPOcQWULXktdM8/?=
 =?us-ascii?Q?c+MKRRoDAQYB41ZCNNMUQfHRsI7qR6Kmbaj9u1Ivl8TJ9H3dO8+5yIjqG2si?=
 =?us-ascii?Q?SKw+KnKbh93ZLrDzJGtXtrZLNgxkKe8cTQHxLqb45oht2/af+gy+q5u9eUYA?=
 =?us-ascii?Q?sUT+vxCJp2uBB/8MuWiHruSNYIX1PY4frRG6hgGmNrgZWUllYW9w7f55sz9Z?=
 =?us-ascii?Q?HEkUXa/Lcjm6hCgE0GWDsD3HPmDpdgpTLY1H2PM5cJV/nmDTc05V828glorh?=
 =?us-ascii?Q?u3cbZOAWJ5Vq8jiiFG5zlaqd89Ho8H5d7bp4mgjNRHI4BBKCOhrswBZibdGq?=
 =?us-ascii?Q?TM2Oyp+zOlVTp3CtQRWzPY4k+OQYz5MrfITj/A0nMPNLMGvzsLfflCWLnESp?=
 =?us-ascii?Q?qsvUHtvG1E5vCDbEFUTgXCSKSDT6d4vcO2qtW7EcQs9laYtJwt5vhYafZNLu?=
 =?us-ascii?Q?an0t5wBhFEJhydMHoIQJmcWTcbAoRY1y5r6PEI5aR1iJfBvFjvVbDA4w5ytL?=
 =?us-ascii?Q?Zxv7Ks/7ATn3xrOhG2N5Dis8uUju15WKA+zCPu7SO9uqCO0nKGfxvnRwYYby?=
 =?us-ascii?Q?n8578x3x2VoBYZeig019LYM7fitE3iNSNjpcFLgvTGau41Xp1+xfTwoAvRgw?=
 =?us-ascii?Q?BUOWqv7fRqMZYKuMFXJ8EXOGbsJOEiWpnSCzxhJJV9QVC6oFhTzv6x3GTNkf?=
 =?us-ascii?Q?ocKqabihkT3jsX47Sb48tJKrKARaxq0URZ0vSY8TL9SQflsTXLyZT5XJZGZw?=
 =?us-ascii?Q?5ScxKl3ma7Qn52jsk23Bg5rhjb8I02I2duIvjC0ktnSMQKwux4hLZSLeih8q?=
 =?us-ascii?Q?3cXdLNjJKV0PIwE+EBuw7GOnyFCqqTw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca12a8-2822-4539-4d90-08deccd702d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:14:57.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CfjRgq35nkyPuTB31ChdUy8cRkdyCI6uvmK7SoO70Qmivg2QE5RwnKhac/ey9/scQTXhRiBspBzlc+S3SEtd8pIHmfrjSc7Vd3rZMNnsD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

Replace mac[5] += offset with a proper 48-bit MAC address add to avoid
overflow issues when mac[5] was close to 255.

Example:
i.MX95 MAC2: 00:11:22:33:44:FE + 6
Old: 00:11:22:33:44:04 (overflow, wraps to 0)
New: 00:11:22:33:45:04 (correct carry from mac[5] to mac[4])

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 4341a061d08..5a635ba8433 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -583,6 +583,35 @@ phys_size_t get_effective_memsize(void)
 	}
 }
 
+static inline u64 ether_addr_to_u64(const u8 *addr)
+{
+	u64 u = 0;
+	int i;
+
+	for (i = 0; i < 6; i++)
+		u = u << 8 | addr[i];
+
+	return u;
+}
+
+static inline void u64_to_ether_addr(u64 u, u8 *addr)
+{
+	int i;
+
+	for (i = 6 - 1; i >= 0; i--) {
+		addr[i] = u & 0xff;
+		u = u >> 8;
+	}
+}
+
+static inline void eth_addr_add(u8 *addr, long offset)
+{
+	u64 u = ether_addr_to_u64(addr);
+
+	u += offset;
+	u64_to_ether_addr(u, addr);
+}
+
 void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 {
 	u32 val[2] = {};
@@ -627,16 +656,16 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 		 * | 10     | netc switch | swp2                      |
 		 */
 		if (dev_id == 0)
-			mac[5] = mac[5] + 2; /* enetc3 mac/swp0 */
+			eth_addr_add(mac, 2); /* enetc3 mac/swp0 */
 		if (dev_id == 1)
-			mac[5] = mac[5] + 8; /* enetc1 */
+			eth_addr_add(mac, 8); /* enetc1 */
 		if (dev_id == 2)
-			mac[5] = mac[5] + 9; /* enetc2 */
+			eth_addr_add(mac, 9); /* enetc2 */
 	} else {
 		if (dev_id == 1)
-			mac[5] = mac[5] + 3;
+			eth_addr_add(mac, 3);
 		if (dev_id == 2)
-			mac[5] = mac[5] + 6;
+			eth_addr_add(mac, 6);
 	}
 
 	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
-- 
2.34.1

