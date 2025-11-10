Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA48CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D04D83AB4;
	Mon, 10 Nov 2025 18:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k5vc8fIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E421D83957; Mon, 10 Nov 2025 18:37:59 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B72283A79
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGp94XdOcja0LaXpKrsFXkVBgDUugvmMi/vXqP2fu79mA1XbjZrH5dlQ9N2m5aSiWWuZGFbfcWFk9ASv3UeiGOmnt1b3mCJfNAMqF8XK83UQiccC6ogMo4X10K2rXOleEbElkA0/PLMSzsyEB3ErSm2e5z9UmQ87lRigUTOBvrbdqRJNI96ZenkJm3X27LrZyqj0UW+ZwdL29CfsM0hsGXzAEp7AcygolIpNXbvg85kc88q57XAzhewmAbf9BSQR0gbdwe1Xi4yab/XRbR60aimJWIZu+FRImqjdpVatM8RPbZE35gby/1F8wgJjfrthRmMZ4DuGzpdhC4F78eDTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvAVhiEER53qq75B8sWUFIuGswgCHnjpt/p4MoiI6Us=;
 b=wEPjL83EVkxJ2Z+bLLUaKdXQIc/Hb31U9gNUu61TaSou/+OLR6UgV81ewS9ADctnjls5F+aaIAGojdhVhbeY4rCe0bnfJjebrn34XGiDqzZxBfZDuarXoupCmLIAhB3ssxdWKlDMynmMVOzgDDFO+zZXt5pt1Os5McwLaEo+TItgRwGKSXmRKAUiKUmrBe9lfHLaJR3d7XDTVTfkbFztBe2v4Zb8IWeCXwlQEswyt277Bx3HD/JmS/bgnbRjO5YFGBzEfIpSzFFAFaei+JCcm96UhsC/ZxjdX9En+6hLjevfcKlj2PnR6mXCxsDOVl48KrVdWf4fAmxzaLyq8VeoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvAVhiEER53qq75B8sWUFIuGswgCHnjpt/p4MoiI6Us=;
 b=k5vc8fIRSCjUQuRa2z9w5qbgpUQwT+tjA28Zt/XdwvNG4ReZiIvOtZfUOHyxnExOrAzJzx6qKRrutAz97uL0Vk23GLMD830KySriZDIg7wf0cle0NKrpUL+0GyOaLoTBUGd4qBYgsMXzwmhQDdOIbNFN1+Y76Tgu1UypKyIQRdYaTBYeTAgzK8hTK8i2KnzLNRzTPll1bigUQ64VS5Es46SVRzkJgp5pXTq6P+ctqfVqiSEDUkWJ61d679sJgk8VIzPbvMZB+PgZXG6JDdAqHu01v5JHC6VKc5YHle1bi4MzuwCQBh0Kiii4n57JwF1Nfv37iOEPRzdVEld7FCd0JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB5984.namprd03.prod.outlook.com (2603:10b6:5:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:55 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:55 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 8/8] mmc: sdhci-cadence6: Add DLL master control and improve
 tuning reliability
Date: Mon, 10 Nov 2025 09:37:37 -0800
Message-Id: <20251110173737.24545-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aefb622-c1a5-41bf-76ae-08de207fe178
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r+XvoYIzMefylqflwIBl4WXmwXOjzFOO/J+Z48MalMPG/rbnmfhomTaQyzUW?=
 =?us-ascii?Q?9c1MZ9ORQ8P0xHr1Dd38lBOdit/mVO3Bn7rEynKLgL1V8n22nRztHTh78hP6?=
 =?us-ascii?Q?0dCkr+XXX68atu2WLGoZDKvENcotZ4RsXieETNb/TQLVZQydhJn3UrzolEfS?=
 =?us-ascii?Q?n79FU2eaNBurUN6lTO5enX6uE+5O4vCadehEhf6BZY3g7Jo6PTrQu1ePrvqR?=
 =?us-ascii?Q?HoIt5rcCjghoT/1wGXVy5HMslNMM4/adVFkiyw+c85rpSpJT3aJ4VE36F+pW?=
 =?us-ascii?Q?wS/NzFlheN42qdJ3o7pz9EN4pe/+A31Kz8AuO3cOIQ9YnEnDD1gIxQk8oJT1?=
 =?us-ascii?Q?SKpOnd0MMfmsrWa7U3u7ktUIwXA6wQQooGZGw0PnkipEmiXEEvuB10ukx2rb?=
 =?us-ascii?Q?liQprxHIRUOuuf+aq8TD4DxbJPkZV7mYpLqBowbEVnf2x95BkD90zJI7RtXB?=
 =?us-ascii?Q?eTFMzYXt96Cqv9jb+uDJy/KuPhrpbS242/M2Q/I6KM9c4nHTa5aPAB6EU3jB?=
 =?us-ascii?Q?dUmXMY8k4xePe/gHTNWcdtDPCqgjN6QIEgiUHrkLO4tj9ctXX3nldZakE0yv?=
 =?us-ascii?Q?oQHp7G8h+fLZiZ7+s0rmJAu9nDRI6VUYMBnxPggE3QzZ2iR8rp5iLc4Mr0Lt?=
 =?us-ascii?Q?8lGUAMEgcO6qM9l9u+3vrAGP7zse6j2lJFt7KNRfxPnAuauIFarRILoQerEC?=
 =?us-ascii?Q?Z9sQxR/kcAs55f0KkIVPUlw0/BK0aWttKiFATeROjRSKf3I/VWtngEfOHr/g?=
 =?us-ascii?Q?yaMA/DyBbR+X0tDsTx7V46Ye3HjX2iuaMzUVUA0tyPW9DLSXqFah0/j3J7vN?=
 =?us-ascii?Q?/LBLmAIP4KR/sYmcfqfKeFVJXO1/COzKGrOA+hVLTz4cTmeukCIrrmmXd6of?=
 =?us-ascii?Q?xA6aX/vd7R9BAkPYAu6Z/Y8cL2bHdRnNAhOP07h3uLxFkBGzG2k+zSNsJu3g?=
 =?us-ascii?Q?EoXMA1L6rfgSFgCJ47JVvrfa6FpsRYkfbelDYePaUAQz8BC81lB2kIM+aKI4?=
 =?us-ascii?Q?JlnYcL3Vfv4hLoZpiJceTkSWLIkDi9prbaSeqVpx0P7e5HlK3NweCNymudGw?=
 =?us-ascii?Q?ANV4QOy4Z9ip0s0FRxAxbSG8Uh2NrXte81mjpZxPjIw/Q/5+4sK8uuor+oi2?=
 =?us-ascii?Q?K6Pll3sTsO2n/B3zNMOHGi9h7P9TTi3A2e+nGa5iMw5CaZ5Z7xEXeLwQ07/d?=
 =?us-ascii?Q?ZeUgC1dNiVE4WS8CC9dZzkoaevpLZex/KUm4mSF16+VI/EVUN3nwG5qDGv0O?=
 =?us-ascii?Q?lB+WdkPmo0PfxcR7VtLGv0p1CfaGlEY0VkYd49TzTHAjWui8nwLgIN4vcoSm?=
 =?us-ascii?Q?eNHcjBOtqEIW6lT9eGkJzMDO9QDjRSMssLxFzWvZKowCAZCpzVKPeLh4U7/Q?=
 =?us-ascii?Q?zZHF0EKXHMB94/viWTpQLB9aadYaxzmVj/azDu/6NQCwznn0cl0jadhx/oi3?=
 =?us-ascii?Q?t8I2n6nNganC9l+bTqHb1/g1K3eMWLnw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2Q/7bf6labbjF3wJ0NDdQNJHnohSCBGZEV5zVoScjwsh2lbMR+wAbw0pf6l?=
 =?us-ascii?Q?lsx7uTxDXSfqPX8zOhSYGeAUYIC/mJA5O4o2fsSa7ZdFAWr6FMkdXxe8tieZ?=
 =?us-ascii?Q?vBDwxQ4iX8MoA30IfmFJOMranzmRvwXC0BiJ6zdlbHZF1yFCxGemnkEjDxnu?=
 =?us-ascii?Q?0vB51ZQbhij8LsZ30YTLWLSUCCG4f5ZQrzlioKXclFK/7X94eMs9SRkLL2TM?=
 =?us-ascii?Q?To/dFpJr64+/0E1fTE7Bl/Sw4n4EXm4uiS7pCO5QZjinbU+El51mkqZD/aiC?=
 =?us-ascii?Q?+mF4ddy/dCWjwoOLlkCFiGsJYKwLtVyoNRQJm1eUpnC4xypZgZ12FNHfr/yY?=
 =?us-ascii?Q?gXBT6HKaNvR1kVJrGelrjyjV4zk0LuVHjoAzadNB2GHP6nt5yPrmzWFZnbin?=
 =?us-ascii?Q?Ysj0oQutczK3yD6k9faoaOiOK0+eBu5YxENkjulKENlC8+ewLpzM/INQO52t?=
 =?us-ascii?Q?Qbwd4K4BUrqIp5srbb/2yN4DRQQ49JkC2nTDzexU+KyxxtimFJzDAPTKuplO?=
 =?us-ascii?Q?5dmixTyueyr0/X0/WZZ4tHmp/6wrqHVJk8Zge6ogB3K12YwOF7hDkGgBX3WQ?=
 =?us-ascii?Q?IXSyDysk8WY9+B+y4Pi2g0gfmZlKzY8tLUDWULxKNE3zpk0Nqc8cB4hX5ii/?=
 =?us-ascii?Q?DW1NTXs9nQ/qzDBOFefRQND1T9ThcbgPbnRsUSeBt+DcW3fTbwfMLYl/ZGJZ?=
 =?us-ascii?Q?kLxIHmsKdV/5KT1yekDEgmGFNaOSO7fsJv8O5bqf6EpJryk8Lwdl0D+u9Je0?=
 =?us-ascii?Q?WbOvA9QX4x/6WM/X5m3Ft2nKJEwQjLEVAEz3F6nn9vHu5Ep6jLSGgTKP4DOa?=
 =?us-ascii?Q?UwqjgNKzSdDAjWZqBmA/eOi7fnEUqPEXp1ZUQCoJf1vyXiNSr/G4xV/CWzXT?=
 =?us-ascii?Q?xB+QTkyFo18Zvh1uu7uF4j1BjjFN5jAhcY0Rg9+fmZw3i3cdliUJjt+4tgnl?=
 =?us-ascii?Q?PA8XQ57rA/TNHVsolYzOVvhaNk84aiG13gsUYiNgDJsWRV3adnGF2CkVaTkV?=
 =?us-ascii?Q?8KsI1V+WxxJVM6EmqViFEyGquSK6SSRS4vNiQLTP03DLRX6vbUlDZbo+2sul?=
 =?us-ascii?Q?uYnHfm38GBMaHxvKLFmGNp/pdglPOihLPLzyvezm1I6tu3jm7+sO1ECQc2kj?=
 =?us-ascii?Q?AcTfw43VPpovI8Qk0moJ2KvD8yztZZle5DFR6CPGInQjLfdg8MsFJfeusDD1?=
 =?us-ascii?Q?gNJe2toz5oPV7BzqBNQ7yZ/sU4xnntWv1x9f7elzHPPEY4VXpOBAtx1CoCsO?=
 =?us-ascii?Q?10V3JnVtMGJzAMOseop969CQlBAzSiDLDxTRIaWXCPuyW5MwC8uaBVuBViHu?=
 =?us-ascii?Q?2xDbAkaBdfkrqXY2jHA763bIFJsmCLzS5//H/3+HdE1QeKhQCIlC5W0rh8QX?=
 =?us-ascii?Q?9wk1mTbDTiZrdH447F2cCI41DY4SAMtfeph6yQP675fh5JflD0WxKZcFsNCE?=
 =?us-ascii?Q?yj9LRFDeFD/CA4zRDAjp4XsUMNZuBBcQWq4eAmV1TzdKEoX+3/Akv6arNKWg?=
 =?us-ascii?Q?WDFNZRM1SexnRKi+zG1DyAFWQBWzzC6YFWJnFam/KMqzt79KQrAp1GbKEmgU?=
 =?us-ascii?Q?osdwt5yDPv6pbqTY7Vg38fMqAC9LZ2JjJWXFMlDff3hv88EZ8GAXq0CTh64E?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aefb622-c1a5-41bf-76ae-08de207fe178
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:55.2063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtJduD8cQItp/IldEaTDIb0zYrp7gQncCvTHS0r9noiQD5us+IIhRHmJkRCDbg7X9rGB4i4m2tN11OkVW4AQ64nSOI4ltkamIGQhk7vJJro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5984
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

- Add support for configuring the PHY DLL master control register for all
  SD/eMMC timing modes (DS, HS, SDR, DDR, HS200, HS400) by extending the
  PHY configuration arrays and writing the value during PHY adjustment.
- Fix tuning reliability by toggling the DLL reset before and after
  updating the PHY_DLL_SLAVE_CTRL_REG_ADDR register.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index d9467293807..91a245aa490 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -58,7 +58,7 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
-#define SDHCI_CDNS6_PHY_CFG_NUM		4
+#define SDHCI_CDNS6_PHY_CFG_NUM		5
 #define SDHCI_CDNS6_CTRL_CFG_NUM	4
 
 struct sdhci_cdns6_phy_cfg {
@@ -76,6 +76,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
@@ -83,6 +84,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
@@ -90,6 +92,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
@@ -97,6 +100,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
@@ -104,6 +108,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
@@ -111,6 +116,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
@@ -252,6 +258,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 
 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
@@ -296,6 +303,7 @@ int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 {
 	u32 tmp, tuneval;
+	int ret;
 
 	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
 
@@ -304,7 +312,18 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
 	tmp |= FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
 		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
+
+	/* Switch On the DLL Reset */
+	sdhci_cdns6_reset_phy_dll(plat, true);
+
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
 
+	/* Switch Off the DLL Reset */
+	ret = sdhci_cdns6_reset_phy_dll(plat, false);
+	if (ret) {
+		printf("sdhci_cdns6_reset_phy is not completed\n");
+		return ret;
+	}
+
 	return 0;
 }
-- 
2.43.7

