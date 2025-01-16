Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF68C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E4D807E4;
	Thu, 16 Jan 2025 14:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="IEWA+LvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE198033D; Thu, 16 Jan 2025 06:45:15 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA27D80040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9ORBOs/wRmjCvTaukJmDiYFBmeHVNaNqzMCZn8QNkuqWDa1qbTSJRWKq0DYGxBsqSXH8MP2OZitI9mETVOiV8ryB8IrP279jToWT9PpRpaJ389FH46Mqsdj53pKUs3vxAVr8LvAQUyYWU+kkvVVk5bXUATfhvLRZRN0zU+2tleN4dnfGkrZMgeblAcYrypHdLooLhRxjTOcs5FR/l2L0IF6oXHIkMBaj32u4t/aph7ljROZA+DgtPft+b7OPDoRp+bjmOrFeYaQAhyr09tLCOfi/XBOCn8tsDz66kwtgm9vKTPY5RTdNjNE4UeBl9HxgAcMi0TN22GnEfnDfv5h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEkxj7F2+k/OjqMuWw8VwwEqUaMMz7UosCwGw0H/2vE=;
 b=h5FjZK/LShqjToBijWiXFi+oWrwrfr1WmlTe5vJrj03H+ibplo/YFjed2IeOtajsL0ANvJq4cNfaMAcZm5jAcbUkGm4c4td74mFjVncpInSXNWsNPmRBCXHKFDvuh3q1RK235yq3tte30YJS0bhXtr/FfZYI3376+mvHW5p1OdfHsnPwS0e6qn4DyKO073htkS+rDVwmb55AMT5pPd/bpdAWcAQjbMYht13kDYCGlTdMPQBgMZip2g5pm9fkntztEvaqYWRuigk4UtyAaJXoY/Qn3TDcu1W2aOFmRwGTgfaRB+Va80rtvJfmsxVku7WcWpBzJCkRV2cTqe23jvuUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEkxj7F2+k/OjqMuWw8VwwEqUaMMz7UosCwGw0H/2vE=;
 b=IEWA+LvOyPZ6fwOIefNhEVIIq54mj2a0H0bAvN/xD0nbuySUyXKCFdD9PQieNoCMRsZ1AQwQjsX4rZKWswppCkWQvyiAHGsx7YkGPtCHBkE7CiwEmVZBGmdqH00tRHi5q6g40NEz42zlqFl2SoghOAo4YAGD7yioHvJIUr6gYKOm5VZD3wR9aOvlBmdkUr51XEcPrr+fwzJE6xoZc0s6hfaRtkB3sZTgZMZdMDjS+cph7HVdkPbJoLZGqZ8I2HAHTQKMsS1r1iX1JCLJ1vvZIisQWZw1Lj9iHA6+/q2rzYI/lWIGmnc9nUxPPyMzULvoILaVV10sJkE1VUu0VW2qeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by DUZPR06MB8794.eurprd06.prod.outlook.com (2603:10a6:10:4db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:45:12 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:45:12 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] net: phy: gmii2rgmii: Add support for phy ethernet id
 configuration
Date: Thu, 16 Jan 2025 05:43:24 +0000
Message-Id: <20250116054324.836712-3-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|DUZPR06MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fc86f7-f9f1-4d9d-77ca-08dd35f0f1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DlobgkSOAX1TY1JHpfj3LeMaAR0EfyxDmEEggRYSnJgp9gpMTWLmhd2CDWy6?=
 =?us-ascii?Q?HQ60pX5IOowU/4Lju2+wQAHJ4+fA/rwhkfirzH5KalkEtXEaq+p6QeCUoR71?=
 =?us-ascii?Q?lxQpUiYV4EhBiO21zlpl00OHTXclOeqMAtpZieSRKDrgWy3yA3huy9UOtJIu?=
 =?us-ascii?Q?xnIRKNYJMH7GXnuq0qT24N9CpCBgooAqiNmPFvshVqzQcJE5uZDzgcd9CJ6t?=
 =?us-ascii?Q?6zwSh6FUXTieB9g+yIFc9nRTdY7+Uh4V60VhxaSQneg8/Yi4/5hglG72nMPR?=
 =?us-ascii?Q?fejErtS/UN78KExo4eC0XyxT0AQwpggB9zFbrozLOa/5vunvQ+x6+kwWZ+6z?=
 =?us-ascii?Q?HMLW7bo8rJQdlSkU9aAjJ2IvXerHqvPU7V4VC/yypG8TsV/9bJJNPrOHF7O3?=
 =?us-ascii?Q?lRa5brZq9Svnq4NF04rRhLAp+kX8487M9PGITiQMoNpuvc/6OVf1hSThc3VG?=
 =?us-ascii?Q?RFTy5Bideea38Zik2P8EgpQ8yI5zFcomZAamiRGWUK9X5LiOUtwTr6VIp1z+?=
 =?us-ascii?Q?7gOM+Le0I3YxQ4lhGBCpFWuQiF8pjinuxgay9iauNyBTqAPgVfCmuJt1Md8J?=
 =?us-ascii?Q?jnibeFvUUcXNdUhZvTURBYbH8n5pbOOZS4PMdgeuTBDM1bU5vdrbUBe/bKef?=
 =?us-ascii?Q?PHmS0SJ0Be4uoifNWZ9gg/ebFKEtmbIc7hTRJ/vaXLfewx0GFlEzQWLhs/FK?=
 =?us-ascii?Q?TPmbquRGpnLY0m/ZbV/RjG6yGT9DxCzEaK69YGYuwDq0FDFRazvpan2up3yI?=
 =?us-ascii?Q?+V0f6wi310vwTZaGgqUpC8LoIboARYxOEhba5PiqALQSaodAZWekKkKlMXbf?=
 =?us-ascii?Q?wn7Lrlhl4jE/ezOt/FWpvSbNq2/WaC0SY6nlNlHkQtYOFBtHbrZlZTu4Dbl9?=
 =?us-ascii?Q?8wSLbW5tWXdpRLa3cwTyJ1MMb29aaQXGMXHaO59t61wEbpN4hh47esP/AYW9?=
 =?us-ascii?Q?9zreDCulGj+J7xVYzrAOrM1nDnS0q6h8SJJn7z0w/uUKsM3E993uRwwX8Upd?=
 =?us-ascii?Q?Zl5bQEvYNo/MKOBVaH4GiUdXGRnr1Sl+d+cFZjhYTk3Al8kmTj9z2S84F6nQ?=
 =?us-ascii?Q?ZVXzJCsqlNqxm0291EEh78lNvOSbE2st2BwrG5eXmdS1AcQDgobcls4mlmPj?=
 =?us-ascii?Q?Nr8BVTw8nnlG+nqMtcwh5D7BcPw32HGhv7tlpafZPTJHSc/80b5gSqNzOjEK?=
 =?us-ascii?Q?yujJ2WfGkL8DTgzb2jQZDFj/O+rbS++i+dSRhqm0tZB+kVxGX8690UFeBKmq?=
 =?us-ascii?Q?MOeVViD3OV+9kW5LnE6eGlBB9azKbfMP/IUH4lrrOsSjMBHp/cPTJDaKO/5s?=
 =?us-ascii?Q?Amx7GsgGYb3G9fq3a27QWF+HUbyve07oi/VEr5R6jKf0TIU2BL8I69nAuhDr?=
 =?us-ascii?Q?Vu1/HnRYc3/oJ/dEa0d9CFPAr205ZwxJwfJeh5v/epqB7c3hMOJa774ElR32?=
 =?us-ascii?Q?HQfyMcbj3Cut2FEI5i6B0MpOHUKrB6eC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZljHEj9aceyyWZx9gOv1pVOVhMQDZZowkooziUqVZyRkiKz9XxSYyKZ2lvIg?=
 =?us-ascii?Q?G2kc1VahaVVDMyVb6AVj6bX5h+K2/LhLy6PkFb1/wgaKzztkQ67o+RrnDCEm?=
 =?us-ascii?Q?hR9CMLzA20SQM4FS/WncK+eCa9OYDsgHfGHq1DF50GWRRtpPlrUTJkwhNi6H?=
 =?us-ascii?Q?2/hnDwes0pLf/muhbSdI7fYZr4Xe5BMwxDJMSEirzOGReHcuX4/RAoZDSt8P?=
 =?us-ascii?Q?Dgys25W0/VtMHFMw42BYs+SELUQCpDJt8hXwDHrCrsZOxe2GMubMvqvlAhU2?=
 =?us-ascii?Q?IAI4HGRWAU1QJ2M9SeCN1RObAcea3sqPq9dEvcBlY/wVrZOEYLHCTi42ORVu?=
 =?us-ascii?Q?pj3dg8UTTNQVQo4Xut8WG/WC71VNK6AnyoroBunilDx0cE48J3nwI81IY8pN?=
 =?us-ascii?Q?POw9TMcdkbnG2D/TB4k/YzlnTLxWbFkMer5X0zzCbus3L8w1+ITu4KpH/WP9?=
 =?us-ascii?Q?2IKj6v1c6dE5UjZ5AZMrLSp9zLoqiMnvZ9UHt0OsdOR533WDrtmknVce/jVu?=
 =?us-ascii?Q?zQPDpzuveACU7s2OeFfNBFnSxeNpnN25GvcFbKe8KTPmLQkf3rfuqpgRBors?=
 =?us-ascii?Q?+Bh2RLTTrHzOwv97iey4MRU1bQY5eXflgQA/Su3S4EcBc287XNw2ZFEoDVqV?=
 =?us-ascii?Q?BmjO6DgiVxOiWtwRpL4gEJFyQTlIUh7FkDPaYfEwUKxK50Grnflbu7BgVKCt?=
 =?us-ascii?Q?sVeJzmxWgAn6+NhbOJ0BDAmexynQSxyxLtlb9uu/0j97lyuMyanIhz5KXQpj?=
 =?us-ascii?Q?I6J8OtPF0SyMiXt4D2W7+l4pTEZbm0N2IWuCylS+8r3FZd/KRoOMvs5+DzSt?=
 =?us-ascii?Q?k0GtCz2IMj8Lw/uU/DxQatcmKGYp+1n2bBLZSFDjZIYX/A6lGgpECsCl3re7?=
 =?us-ascii?Q?gMM36JT26nbDYBPWzD9BRaAgS7F2e0ZOso5HgGXNKrwQ7dluoLWaEffNFiD0?=
 =?us-ascii?Q?YK77vne9ebysiC+SgqQNbWJ0VnzEzw2+7splOqmlRMoc7YYWYf80aVJqruHp?=
 =?us-ascii?Q?e6aiw9H0idLEvEtGsj7hm+mTXiD5k6fK25Rh9Bjza7ja1EfokNsxSWmUIV6z?=
 =?us-ascii?Q?4P86penCzmz2/XWVL8DrIq9UUr/nHHmWtiLDVEsqYSYes3PCZFkFpCTPJQQT?=
 =?us-ascii?Q?lfQUJ/gTUFyV2RADdGdWqH6zpgxiN3QK0inZKAysUAWhSw2sZS6wgnRmFhMA?=
 =?us-ascii?Q?gp0I76TWAo5kjqZHZE803WFdNmpxe7ju8EF5sEX+1ysfaUp9LnVd3IkQG5bu?=
 =?us-ascii?Q?WWdMdwCm4WpQIjg7pDOfv1VbfM7bem6bi8VsACidOs5OUfjmVoWpjPj5jThF?=
 =?us-ascii?Q?xDA9JgKB926LCOCZurgybbe9DFbWTyHEiGFdPFdH6porJu/Ls+QLkcv4LUhm?=
 =?us-ascii?Q?nZ8KgS0e8MonZfOrK8v2b1sEl/uU2ZNPVDQIByHL1e0FhcLSz+jkNpADPmz1?=
 =?us-ascii?Q?VvHUNajfeeor5Wp0YR9Dr0wtzxxkWuczmpHrdEFIZKstpfwuqVKUuLfbdi64?=
 =?us-ascii?Q?25vJ7mvAYk86+53DA4biDOsv79Lt6dClcVMQmAFZEkdRLEQHSY9YAYMOjXBu?=
 =?us-ascii?Q?35/LXZdJBUEwjs7V/ylRCRo2BIjDrQnenGFekLXCYcu8TUxpN+wgrQ+ySSfS?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fc86f7-f9f1-4d9d-77ca-08dd35f0f1fd
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 05:45:12.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COECb/Ufehi0S3nRyQHpsEsQ27pSLExhUk1j+QnyqylPP3adgGlZGPfCB8xUlUorcBI6iru3J0kWsTAmS+nsUFgLEszIMiyEmJhOIom9Or8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8794
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:52 +0100
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
ethernet-phy-id driver to support using starpping resistors
of the external PHY.

Fixes: commit a744a284e354  ("net: phy: Add support for ethernet-phy-id with gpio reset")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---

 drivers/net/phy/xilinx_gmii2rgmii.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index e44b7b75bd5..1d6d204b228 100644
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
@@ -40,8 +40,13 @@ static int xilinxgmiitorgmii_config(struct phy_device *phydev)
 		return ret;
 
 	ext_phyaddr = ofnode_read_u32_default(phandle.node, "reg", -1);
-	ext_phydev = phy_find_by_mask(phydev->bus,
-				      1 << ext_phyaddr);
+
+	if (IS_ENABLED(CONFIG_PHY_ETHERNET_ID))
+		ext_phydev = phy_connect_phy_id(phydev->bus, phydev->dev, ext_phyaddr);
+
+	if (!ext_phydev)
+		ext_phydev = phy_find_by_mask(phydev->bus,
+					      1 << ext_phyaddr);
 	if (!ext_phydev) {
 		printf("%s, No external phy device found\n", __func__);
 		return -EINVAL;
-- 
2.39.5

