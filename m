Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A2CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1902A83447;
	Thu, 11 Sep 2025 14:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eiMGARKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B4B83323; Thu, 11 Sep 2025 11:59:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D8983314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfFF/lmdL7R6jZs58x9lfnKZTEiwa0KGfjy72oRM8tNRAcCCHT8bIqpNfqm0sJ7fYbFYntPdX4HaE/7kP8isC5lfQTbp6viHGkPFpLyZOB9Znqjyj7TDs7TYAwMxdCk/7okCvo1EKrergtlc9DlfUid6lfuUY8dWC9N9nn+eugdozdLplMhJpk95ZfvpPfIlBsZ6GmBODofXJqx+wn58qjktvngc1+vR9Sz2gyr90KqxEJUPCkR/vABAmAUsdvErLgHAEkPRRlrj6HHo1/OprxGM2u+w5t1v8P9//CnBMDMZ4zbjz1fqMQK5HIAz90i2zSGsAqhJhI8nAU1l9EYnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc/+zR2l0SLIB/KXv1sUu5KFO5tI6wmOtgo1nPOSt34=;
 b=UWtqTX9D3u6SCJgUJQjsNHclcSmb0o4QomSeoZDvlEVNIlODcI/KklQLqRcdSuWQEohsG7yLBU3W8/o+dMW02V/VG8J1faDf+MBBJgUIXHwAXYaP8zL9I+sDzRSO9IVWlShcA9aW83T+W3XgAoQq82PUJ8PKe8IKNGaZUP7N0Flg5YVWL83zm8cBW/2r7Zq1lO8ZgDjwKM7uquSmDPRSQl5VGERqs2cDWZZz09DwhwG96r/o9p1aHkaAXGvlcmp5fCmI2eFgfsagLfnfH5EdmrJqeP87W3Vx44JLIi4lfvY1uYfXBrF4jetyytgYetg2rN7HjYZjEqzzX0NHulhBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc/+zR2l0SLIB/KXv1sUu5KFO5tI6wmOtgo1nPOSt34=;
 b=eiMGARKqWwJxHONR6qyoNYhoGzdVmlyflAkYkG4AF6Ebkvqn4Y++N5B/rLPj9GnGKG8tdeS5/fs+MxavURVcjALPvNG77xde3MzuK1YC5en+A63N+QxqGxCEK+KgXca5vKM0IgicCR69M2rDrt+tnIMl7wK2yuqN6BhT3QKFS1lJl2ek0OlzIS4e1NQ76pK0/t35kdo465w9ApKPVq1GqO+YT/37p3n58EytxIiIXlSXaIdVa5HiNbwdOpJMbbKYDjTbjZfaSBUnpAtnLPWd5Vti9cCTv4x+HRGxw0CGHkLRzSopNFfg7CuH2Oaf1siRqzuZLLSzgAjYRKDk+aGslA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Thu, 11 Sep
 2025 09:59:16 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:16 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 4/8] power: regulator: Add vin-supply for GPIO and Fixed
 regulators
Date: Thu, 11 Sep 2025 17:58:37 +0800
Message-Id: <20250911095841.3659022-5-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a24f64-90b4-4d36-673c-08ddf119de34
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cl6YNds4zdRzQ80kjQcFDdJ/AFEZ/dvlHne36j0W9UgL/oVSG/9OjicGuXUx?=
 =?us-ascii?Q?l0Iduo08XbkeF/XBOV41fWd0g9RJc9N06KKzy6w8dVzxk2Sb0D5Y8HVMwFcI?=
 =?us-ascii?Q?eltCxFQ0qlr8qMXWOfDeM1YxsGt+b3XQrIOnQ+2kpmOEy7+9zG5KPjwQct0X?=
 =?us-ascii?Q?puRmd82sxCPxdCS+xGO3ZAHcFUBblBxF7IGvzx/wXyvGYyfsOalhAejWNuGu?=
 =?us-ascii?Q?IVXZatvR2RQByGkai37JMSKu/xznWtDnobvleuw/6dWYXYaAs/saNj7kKkvV?=
 =?us-ascii?Q?3j3RtwWfHSIMAVhzg37lVfhf5dPJ4k+yOU068lyArj0Be8qwEMFAv9eh43HD?=
 =?us-ascii?Q?AyPHmeXj/IVHpxR7aWom9nX0A6NlpMcxSxEdirgayBkk4JJlDgqrnvdzAuD6?=
 =?us-ascii?Q?e1WM1bs4Tu+a7pEnjofAvGDwgQLVNig8ZQr7rgDshsTiGC8fHjkOcyVGCker?=
 =?us-ascii?Q?opos1J2wogzFF092ir7vZRFyOY4e5Fa6XVq4nFdQLOyvAccDyEJB7KFEgHrS?=
 =?us-ascii?Q?DUXv9cVEg5khEkoZC7Uk9yQCmKBqJkwSKpfXoYmwJ0LJw1LAofjPLFUdBn70?=
 =?us-ascii?Q?L4wN0HpmdC/G4ai6AMsIJLgSku61SyVawmVi+CIapWRpotf18n8ZvHopWO+B?=
 =?us-ascii?Q?/hzR8ui4bb+WK+3KoRfFX+k+W0fHy4RCL5ZsqJtg56Dq1anOJmUGU+N4PSjS?=
 =?us-ascii?Q?OOoIsW/C65r27S39gvDzjCANmfexEFMNBiIyoBsqxqrkJSJQD+C1EXOXjWLo?=
 =?us-ascii?Q?5Oe5wWdoVHFicmD9Zyn3UVBcYYbhzL6mC1OZhIWMyk4QoYfphg0/8yQMq/nn?=
 =?us-ascii?Q?kpDQPedoUKTpUYHQhN/QwWvPcOBHoxZqgbgqLeXBrsNGx+XA0aXy5IPxoXzZ?=
 =?us-ascii?Q?89VVZzCNYpoIKJk09i/uuXBoJ5cdsFFpBxIArXA96XpYQAuW0I1vV+rheVde?=
 =?us-ascii?Q?6oZ0XWI/6DUKfZGLVn500OR0L3JAafEH4wIIPZ8HT2cDLJrymgTHPFqBQkYU?=
 =?us-ascii?Q?Bn36rpizfsAVs0tzl3a2j6DdAOSTPUgjzoeiw7EQaGMHyfzMt2GCHTmGaGvV?=
 =?us-ascii?Q?j6ThbEtOkLskwq0T2Wb51grd+r8CuBylmPtOSFUhkhF5fy5C2s9SuWf522Hv?=
 =?us-ascii?Q?Gxx7pUIc4GwhQToN7HekntX25lxntM6wz54ZWfHw0L6wC4jeRuwUwITsQ78a?=
 =?us-ascii?Q?cHHiDze0YAoXRRaqxT7tLcDM1dE6ayysfaGuBK5OmuvImG89qQ+HttNsxLYF?=
 =?us-ascii?Q?3Lfrafx8Z6Zr0mYfOn6gNwOtJfHrp9DBrPRa+QERQG8ZYyq8dSGtudJzVJ8Y?=
 =?us-ascii?Q?uH/yk4PlsDNR6zqIHWrGZtKOGl+55ZueHsfaIcjZy25rThbMTB6Ov1TKQzpH?=
 =?us-ascii?Q?myq0E4f155bt4onTeKXp4flei8UV7vZ28rtr5PJ4PeHmejNFhYsbPzzBDGFt?=
 =?us-ascii?Q?qutPq1WtKqguXNyPz6x71X+drsrpjIuOlcSXz/i/lvMDh6dyDEKnjvQlYThL?=
 =?us-ascii?Q?QReB2Ca16cXlTsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgSYoRJCGG1Pa8BJftkMWXXv23tVpEN6t0L5/tG8vuMQawEDstqB/BYdDkYT?=
 =?us-ascii?Q?9+ZJryJBo8o4QuOnlW+jBo3k/gB2PLPYkBBY+spkQCL1gHv1qrH8x24I52XH?=
 =?us-ascii?Q?pKOKVDb82Ukhk1DXRxlUQQjBM7v/asK1xKaz6bZTQqYx73cD5I2B1+AQAYy1?=
 =?us-ascii?Q?jAvfQP41bQuoh6+ZxlSS3ukS8kxUGHOkw221sXccfNcnZcU9ASk5FcFR2nd8?=
 =?us-ascii?Q?84cAwG7FiWGt92Y+bRMJ2rhfDrOHi2UxWUaLXyPdC9C/82+qfKC40MESDpMR?=
 =?us-ascii?Q?JA7Wno9vRJ1lcy1mW8FbXAuEBz4C8cA7MkhxLnZ8tvqldTvdbpqOwj9r4CyR?=
 =?us-ascii?Q?cU2gWzeAk6zSZiwo4HYe++tFuPQiavjtRwdx4KtUyUotc36nYLQhQfg1zJiI?=
 =?us-ascii?Q?3i2+pDWNjGgUTbYCMbPuqxFZiDPjvfqsNiWfdD376/8/a761yvtvmQjuairi?=
 =?us-ascii?Q?vxls5yOafzHlnIEpeZf9vrDvKCraFqyLqXI63YLyCQyqJRxUevab1sket/nl?=
 =?us-ascii?Q?kMT2UjtbdCjraIPBbfbPLuwQ5WWlfJrbIpnd6gBvHa96xt8qmzgBP66+ADl8?=
 =?us-ascii?Q?wKwraHZ/+pYIcFCWfKLAbBtHZvcBP5wk3/iziF+ZYwG/gUX+km2ZkTIfXjx8?=
 =?us-ascii?Q?I0OOH7ZpHQVKUbo5PbcDx2Xvml7mLZoOIE9KrfyVka+ASCJ2VTf3lSAfuytX?=
 =?us-ascii?Q?mPCPhyp9LoA+0Plz8F2GzOGe5W9lQKvzuzo5wvHGClzaPGz6yNLb4wcJ+rrN?=
 =?us-ascii?Q?G0nAGiE5ZfilLFIemi4X3Q7JuEOf4ZPp8vlKPc1M3nxB4hDsebmlgygfA6FR?=
 =?us-ascii?Q?9exsNtK/nyc4gdAIpGt6zK6Wfkoei68nCDhvLazisftxh4aVoWNZB/tr+x6T?=
 =?us-ascii?Q?qxXkqTpKA8pLJ2CKtx1/dETI4vNRsd94hUE4vdhM8dyt0Qeuy3fenHIq+dUi?=
 =?us-ascii?Q?RXCy+mo+BHrM0ZWuFvqpjIxRtI63eTnVbJvXZtXnrHGBqQK6qu+AKsl9NJHy?=
 =?us-ascii?Q?byynYTrLt3CLQ9VzAJyk80UHM4K6qrHEobdEPukJRgWPV/CR/LkrYA7R9q27?=
 =?us-ascii?Q?Zo9ikM38GNlfPqkOHc7mRpZ8yUMaOkJpwyj4fy0nh4Oi2fEEknHMn4rUsRTO?=
 =?us-ascii?Q?G9tUTssAlo086iC8gA9UAk42+hC9oj+Ky1RoU+rR5FuD3+6s7MnFRB3bQ77G?=
 =?us-ascii?Q?nYHOP5oRYgJk4kPi0PtN/ixUhOy+Jzk4z9dsZUu9wqblxd2Pn8RmBIiC3+Vh?=
 =?us-ascii?Q?nnXu77qf8UnyPJl7ZNFkCa1Y+yfo/PvPq0rqNLmAluaUjEJjk7a9a3Pf3+h/?=
 =?us-ascii?Q?yGDgod5UldQQMTCYvOUJYyXLCDCButHZepDsuQfwHU9gp4un0me7IdfrGWlb?=
 =?us-ascii?Q?Gu5kOr63SXUS8iZCJFB30Vkcqt5glgbJCkwR16dRyXaZPSiHrkMwVnW/ypdi?=
 =?us-ascii?Q?dGWClCrBsrdSTKMRDJvoPnGGwCdVrtJGXaBW+IcTODi2n/pZMXA/TZuuXsEU?=
 =?us-ascii?Q?o3lIkgnkngwDN6KWJR67mZN4cyk4SapywI58w6pzQu6mmiDtQIK2zMbkXOzr?=
 =?us-ascii?Q?U7C3cwM8CIym/55sEt0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a24f64-90b4-4d36-673c-08ddf119de34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:16.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEXZZX7zpdu2m3VN1VGDGyCqjQ/2amkBPHNTGfhlCx1hWcrkAy481qlcPAmcKtmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Enable the vin-supply when probing the regulator device.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/power/regulator/regulator_common.c | 10 ++++++++++
 drivers/power/regulator/regulator_common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index e3565d32a019..c80f10c3aa3f 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -45,6 +45,16 @@ int regulator_common_of_to_plat(struct udevice *dev,
 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
 	}
 
+	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
+	if (ret) {
+		debug("Regulator vin regulator not defined: %d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	if (plat->vin_supply)
+		regulator_set_enable_if_allowed(plat->vin_supply, true);
+
 	return 0;
 }
 
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index d4962899d830..799c968d0b66 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -14,6 +14,7 @@ struct regulator_common_plat {
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
 	unsigned int enable_count;
+	struct udevice *vin_supply;
 };
 
 int regulator_common_of_to_plat(struct udevice *dev,
-- 
2.7.4

