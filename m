Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88D3D58B16
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 07:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4602C843FA;
	Sun, 15 Mar 2026 08:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FpInmpJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00DA284286; Sun, 15 Mar 2026 08:48:12 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA4C84242
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 08:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+hxbfm0wRknCTj4oNr4Z7KrrX4n8hXn54+qu4NqBBuVV5/cXza/Z9O+KevbV1uS8cxUzYd+vdpcRh5ANCuhU4yqdcjxivmgpxTivIUXzPS+kYjvFRi/9U8dcsPhozvc/XGSY9iBbSG++QXPLyu7Hjak+CyUaoFXullmIL0vS7IMEMcP7aJTug2sAbyY+Y1rQ/3W80EYPQuzk/jaP3XXIx5iJ8CkWjHnJGXWpGQzahQ12AJuaq06y5+4bS/TUEj818wmLLAN69L88TuxYSuiCmjzgKuy5IU89sBuK1uLj7O9H+ulAxJlotsbZ/Rs9ggyhf740SJGpYWsRNlSRJ7Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4281qYV5I8O9lyXQWjZsW0ta71CqEh2NpA9lnve4XU=;
 b=rypfOVJ1k9M+rgRzcFxIikuEAtOnhtlCWmGjdpDAkbCb6zQ7bKXmawpfNkNGRTLCQdgIZIYBCbrjpsoseVtJYsOAHnI0HPm4Y9C8FUSs9oqE/fYGYzoShcgtWQLnNKukheLLBFJmRX/PMyyrWwEocsKcp9VbDMwwvmlcxHx5wL6c0c4NdUNwlR/4dsiz/CnT/K8PqTMJ3JhjW3oKsJN3CkxsSC/BY+NksAMcjZ6hIuz0IKsemxJRY6qR/sw9xIBpW2P25DF+2or6m7UMXjew2vf1K3hHlV5dLwck/U3IYiXsX7KsI52/oQF8JEfK+J6Ja/W+F79kBOFa7jOEzUnV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4281qYV5I8O9lyXQWjZsW0ta71CqEh2NpA9lnve4XU=;
 b=FpInmpJcw4WDi+Fz7aGJ7yV/739sLFdDnUJxem+JDs0damnFNxQYn5Ore0sk/SLSsdbB8xEIlDMwUl7AoKIRQN4kXy1Ft9HyKq1BLMfZs1XNai425V92k/1QepGlCEUx6/ro3cc9xO+kLEazVZUzt/tSvSJ3agOCS+SfSwPLhoKOsEKO7qDPmTb5cIQs8GCXw9uWv0uVtsn4fw5vj+amkVU5RuoEJb78KYzBR0gsFdDXlXHzpETWc9E3KFwQguhvNP2d6AOQXSTBOjDkEMXZDG05btCTR1oXAf8lbpcN+akpyFdNMFrCakleXlFHay47+K6+PfQLaS1bUugZ2/qaTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8613.eurprd08.prod.outlook.com (2603:10a6:10:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sun, 15 Mar
 2026 07:48:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 07:48:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/3] net: airoha: probe airoha switch mdio on airoha_eth
 probing
Date: Sun, 15 Mar 2026 10:47:55 +0300
Message-ID: <20260315074757.3829709-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d759f92-a6ee-4322-4f6a-08de826732e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1b2wXHinyhro1DgEnPHOWYrxu19WJPEkBp4eO5ETgqUpAIP5yxH5UM+I25/W+Jv0Oeo5viHVxWaVkcBIPqkCa1KVFHOJoHzHP7hIETJAuS36EtsRsfZtpRbH1IxnN7n+TYdJzVRxDQma3WcGQ0zcqEa29+1zLYpyUzKiEAHYfk8F3aln02C6xvo75DxcSQ6e291ATOQuN40iFFh+IlS8zvtZHzEmiHh89DZIZtTsIaIe3bGis8qIDXTKExQGjti8KqybCqFBn3QLom8xfCPbk6NjI1T0/MovD9uPaqS9FSqi5hKTxmATGDaTjgz59p+gVdPYEJ0ZlNLTQVCWecwTEArXcXvnlcpWvolOZRu8vD2UOVmHAC4JBFQywYpmmzkS+hiKYaaCGyWNTm5j+U7hmWUfbQjh8Ew9M/rGMBGb3WIwPnyw4E0nz0FHey7qExVED0IE0iEatEmVJiNsX0//HTrqMK5Lh89XRtsuLBvMxrYFLRHFRj9UY3ykgbx3pTx5QIOnp/GB/K09CzQrbBdztFqGJYnURJPcX0QXHEyPh+tZoU4jB4Uy2R5Z/YBNdL6IIYLZDmOt4WQcjsU7L3kquUikcwwfMPrvet5HBlzr47ZFEnTxiXvFeFjCy+NMUGikW3RA03X1FNssNrjQP07Fhtmicm5nu144lkdhrjg5N6SGAw0XEwHMBLFll9o6X/FKciC5ymZ263p/29hHJwoYbesJ0b6NhExIZFND6FBdUlHTUQ9cpsWfzUt+YZSX4TesZt8ic2yH/Ffoa/xklkRnAOpr7U+aETkfwmHYmYkmXBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMFLuzWexEljl4JRw0Xbw939wkp0MCw5ksSVGrxUhftuKfXugVagR0ZEG1xm?=
 =?us-ascii?Q?9TkMUGELrv7qjxhvu4KKK0SEm/dNbK8q2OS3lZNLqnwfTkMJHdta+TLurGio?=
 =?us-ascii?Q?1KNnkfGL6v8UXb3mUDR7+Ok08ujBbVoysHEU1wukljJZiFjQ4gn/uy7qsy5+?=
 =?us-ascii?Q?/+Vca9G51RaDff+c2CTWJK640a1Yp0iEcyh/2UQmtap1cCRLszKNgramMIam?=
 =?us-ascii?Q?E8dj18Tfkhob2mC5qNyHN5y3ChxZr/b5XlW05ugixZXFx3Dfx/QauKgN10Jh?=
 =?us-ascii?Q?mLBWvaTmgJMc+/mDjqg02m5BBdalmmqAXyjB6HsYoX9BtGkY/VdfYebw0Txa?=
 =?us-ascii?Q?M7aVl7un4xZ0H0PWdfp3XUA/33bp7LJ0mchiWiqNTOrgVr+ShYSKomaoGjgZ?=
 =?us-ascii?Q?yXcNQDCu4RTEAQaBFBA9T5uLUlPS0P+oVmRNOyiGpIGf3qHXNWZlH6V/arSZ?=
 =?us-ascii?Q?jA4EB3EgDBZJ1U28UmYaO93ULd2+S8psJag9E8x66wBCIzlDyfsOKtaQ/Fr/?=
 =?us-ascii?Q?9+18kOJIB3YJFel/gvl2QjUaTJ0aKxtxdULrbRZ44zLVpcbgSJjF2dmL8ORU?=
 =?us-ascii?Q?go0juI0MW6h2VjDMf+WlOt4zmpDxRT7V6oMtssIM5m8AerbfKidYXb8wiqwO?=
 =?us-ascii?Q?njJ3+5KRSCW/6Sles0o+GGWP83UqVc2qomK/zMEkdMFnHhPgRT1cEKPQNAZw?=
 =?us-ascii?Q?30F50FmK52x5aNL1/PNJAYROF59MAHDdP0VADjGGMAMTET0Wwv/uLeFtGI5e?=
 =?us-ascii?Q?RbE3mTPLAMIQZm7kQZRBeLWpK0Es5KoJTj61jToQ+v/zvaIPIVhj2p0Md12e?=
 =?us-ascii?Q?RuBug2HWdykaZLIV4R1cuUKjQteCzr5Rrk1BqFaSEQ5YfSKSxo2rwwuCQfju?=
 =?us-ascii?Q?sKYQDkcvOBSXFGgrwQUKUH7wJU4Yw6Fc+dPzDvTKd+UhsRJ1mPrVmimLnsHO?=
 =?us-ascii?Q?Hpfa6BWp2FrGVk+Iy6fS1C7YuUeLWvKytfhomvlVj3+iSQHv53FELICOlKNy?=
 =?us-ascii?Q?DmBc439SrNDVxx49zJmHXtbOPqZ5edzCfnPMJ4YsmofAMPWhCl/09jQIKxuC?=
 =?us-ascii?Q?05DCuSia9T+8OQ0VfBSyJm21iepLlLuRXVnUHMx9P2zpqEtiDROMU7N0YjH0?=
 =?us-ascii?Q?jtFC/FzI+kEfGXGIuwFQr73c9T+s0Kkh4PT94Xhh+UQeetSIZCO8h1cB925R?=
 =?us-ascii?Q?zvYG6cryyQgLXupVD9eSjRwsbrINB6s265rzVjmQEWTKoDp+Uip7bo1KheWe?=
 =?us-ascii?Q?bR7okpOh+6Xw7mHWviYiOzB9OqG1MYPMl8XX+KTvBc2rWabMMkgzWW74j7Zd?=
 =?us-ascii?Q?DCRgj0KpEBehKsrSU/HZCBaKL555pGsPtF+NR+NA+b42GtcGYLU4CLRsp4oF?=
 =?us-ascii?Q?Z6DvhnmHugSyGWD4Lkv/1jDl7HR0age1KJuFujA+/OJeXllPc/uxABgvCHpz?=
 =?us-ascii?Q?7DRfnX/mR1U+QZRmv6Wkv+6liATb9XCca90jXxmS/UqiO9/BfmMkXH2u7vJa?=
 =?us-ascii?Q?Z/BdCKuu79tdYzO6KKGojCmDK/R0SnY6OCqrq+0cAI+Ig59pVRVj5JO5nAnx?=
 =?us-ascii?Q?4P/S+pH0os7WyRhnD4D3Od3zdTiLzExq975yIpYusKGMqQkuailtA2X1Vdhw?=
 =?us-ascii?Q?ahoj9O8IF7yTUNZnUu5RglM7YbmjR/dNA8VvjTT07dVT9SdkGNMZD5+APvMc?=
 =?us-ascii?Q?WMNh7jv6boeh7FU/yp7srpzvPeqtZWsiysJb/UJKu3lIwp94LOWxxUbTm6ui?=
 =?us-ascii?Q?9azzzHNvqhxmrE1/D34mT24F9QRJC2A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d759f92-a6ee-4322-4f6a-08de826732e9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 07:48:08.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aknmxDO5S9MNWfeSYBc7kzLrfeYRRFdlWE2gSKbVR0urDJPZn8PwpLnoeu9argXY5ZULEJXunrpCMEMxxw39lvzWIRa1RvVLCxq3xNA8qw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8613
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

Airoha switch mdio maybe used not only by GDM1, but also by other GDM
ports (ex: as21xxx phy connected to GDM2 port). So it's better probe
airoha switch mdio a bit early in the airoha_eth_probe() code.

Also remove useless eth_phy_set_mdio_bus() call and related code.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index f60405392b6..84ee9b2ad76 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,7 +12,6 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
-#include <eth_phy.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -909,6 +908,11 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (eth->switch_mdio_dev) {
+		if (!device_probe(eth->switch_mdio_dev))
+			debug("Warning: failed to probe airoha switch mdio\n");
+	}
+
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
 			continue;
@@ -935,8 +939,6 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
-	struct mdio_perdev_priv *pdata;
-	struct mii_dev *mdio_bus;
 	int ret;
 
 	port->qdma = &eth->qdma[0];
@@ -945,7 +947,6 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	mdio_bus = NULL;
 	if (port->id > 1) {
 #if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
@@ -953,24 +954,11 @@ static int airoha_eth_port_probe(struct udevice *dev)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
-		if (port->phydev)
-			mdio_bus = port->phydev->bus;
 #else
 		return -EINVAL;
 #endif
-	} else {
-		if (eth->switch_mdio_dev &&
-		    !device_probe(eth->switch_mdio_dev)) {
-			pdata = dev_get_uclass_priv(eth->switch_mdio_dev);
-			mdio_bus = pdata->mii_bus;
-		}
 	}
 
-#ifdef CONFIG_DM_ETH_PHY
-	if (!IS_ERR_OR_NULL(mdio_bus))
-		eth_phy_set_mdio_bus(dev, mdio_bus);
-#endif
-
 	return 0;
 }
 
-- 
2.51.0

