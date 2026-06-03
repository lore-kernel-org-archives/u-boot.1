Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D9DCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 10:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BB284878;
	Wed,  3 Jun 2026 12:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="swwRrmzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF668056B; Wed,  3 Jun 2026 12:49:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7372884878
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 12:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/p/ZlqwihUJZXdn3LK7V9LHxw6VZFPDWVfp8g/D1dfG2aRjU7+BlEpiQY970DjhVIVrwbDsb1xsj0iZnxhdAo2Iz3237IDiUi0EMqgKzOD70Zzc+7MNw3U1RmcEhAjN06WuzRnwVWfliNgiG1p3Qx9GPdDQe5+IgVjMyNPrsiNASQ78ZwZ1bVSjhZCFbixg6uxVhf2J4DDWOEmJpGYIMhqNfyanj1TxWHLzomRWQ6BFFGaGUjUC+HhAh02OxnAzpv7EP0dvgEgm5AnpprDsSjvXETFlGqMWI050MdX6TSaQrt9kAyk4POQdpwDb/hzKiJCZPlpUm2aeSiwJsj+yuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UasLbzzK2WmdUmxU0VVCbDdIWfa8QgA5wlaOVEUpebc=;
 b=DbEHkAcEEEVxH25ytZK8JbO2ce6/YOeBqtXp8hTkn0irAqZpb6Jfr2PDBY1+AQyFh/haY8/fw3eI+ulGs9SxgxHDSeRCAwQq6d3ARi6lYaI5tt3PbHlYjYt2WoxhVZDRF1mIpVCKhq3dqFHQANrMCHPYKziaevx0RampTcdEwGdjIpKi3xymIAuN27VD0XPoM0ZOrTI0uwc+gYRbw7NFIlUvJjb0BSSHQBoi/aYcqLf5nhweBzAILqnu1bFcpUDLDZqtL/lTNfcJvD/XUcznK0MsV9jzy3QvsLonxUhgQqL6bSMKiDhQhFnVFEL88Yf1gT+iRWf9x4oy42wvbT0Yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UasLbzzK2WmdUmxU0VVCbDdIWfa8QgA5wlaOVEUpebc=;
 b=swwRrmzJhLihje+mBjritAnKwGP4UqGJAkmEJO/aIwYB6hs9FHZZIB3J73YaJ1BWorrnIUQnq0xAuxdfD2ByHWRfgXYa5b5OVUfZCR5gSUz4v0EDbsn2qwnJIxX6ssQriZqYJ44FFJF9z0Fb77z8XjXeepzPL+OdHZWUFAIKv2yHUfxX6WsLeHlPv0J1SupsOqlaIeEd6RI2QWQn3MF+NZDTPx53Nbb52Jnnx8rLkyWXYF/23qiqh4dPctfhZIO5np+9Lr5GYkT5Q/i33eR9DCbnyTpnJh9K0AUeRb4/dl93WgfQv2LVXgjo6Y86Ch9BnsRmuPA4yMnqBE8Vm0AykA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB9678.eurprd04.prod.outlook.com (2603:10a6:102:23c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:48:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:48:59 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 03 Jun 2026 18:51:52 +0800
Subject: [PATCH v1 3/3] net: fsl_enetc: Add SGMII support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
In-Reply-To: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eeb4df-b90c-49dc-11db-08dec15db7b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|18002099003|18092099006|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qSDPWUm524MZi+CnWYS0I0ESROC8o038v3dwsDcTJiUz4bCseWeDyO8cBW/kR6EMRJuLfg5RJKWpPixMJZ2SSvtfzYYZbQP/n0CZzJjxCV3ttw2f2ZdmcFO8ZFRnH5+syytJsRF/xuqBHrPEiY5TNtOq/fO+JyIVhL13dzNp5JHU7sehmYX5Jc9eCL/2nBOdNYI5Yu/erGwY3AvFuPl9yqLFWdVrNEPOHB0qDAyv+0ERJY4hCPw0BHPIlz6zIpsE4Bk5OzVIBaRlxI1L5xlZHBimglahGviOFocyZe944uCApY1CjieJXFlXu5wpXhBpOJXb5a6tk4Az2qdbnEJCKLoClxYO3LqL+67oc/if7U2VX5DIItN1/snDQYeEi5SHKBIr2ItIlPUGIWDvkWA2Xyn12XVMu4jSTedRMqbD5KUOtBMum1k7vPx4dtyY859L87t/yx5JnbKvwaj8kCeanNdsRXjQV7kZWoWqMljt1vO0J2LHzrlMQnjcPxBS5Yh+EZ9k/De2qc5fLHNw6LIWi0ruN03aR3Lkx1XAwlhG+rbXuMAgpKemvK1MzPLM5ebOsGkzYCvK+zE53Q6OZtCkOGTehy5HQlV5iBwN8F1fMevJNmR4OYk3Rb2yvJV7YmeTaLQiAcyIde43tmb6WCy3iY346taip+iHZv5Qhdt1z0iAFyjOHdh9N6SvcEFcsSXTzWAmglwYarL3J7npQ0hhdZ6AY24n5+hdk58vYbwsxiwV+t9JFbZNR3gGuajb0wJL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(18002099003)(18092099006)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Zsb0J4c3ZXYkZXc2hDTyt6RHhCREM1Ym9CSk5nTGoxeHA2WU9TUVBUT0h1?=
 =?utf-8?B?VmVxN1hsMGNUZ1NXWmpoWk14ejBnN0ZlUDhLbWNhTnVLWjNOTU1DNk4xejZi?=
 =?utf-8?B?eE9jMHJXM2x3L3VMMHVIRTRobzFjVVdPaHE5RHJ5UHdTTmNLb09UdHM2NkZv?=
 =?utf-8?B?N25QNmpIeGNINVpndmVHVGhFRThLa2ZCS0d5dDdrTFlaVkFJQzduR2xQSVNG?=
 =?utf-8?B?VHpabG9JS3hCMUFhTkdGSHB6S2Y5MGpuZldQVzZlRi9SU2NZcVNPWW5jMWtF?=
 =?utf-8?B?TVpnM2Y2a1BHRE5HTWJmdVBwak5DZG9qZFdVVDVOMS9sMEk2UEJWOEhxR0JB?=
 =?utf-8?B?dWw1Z2ZBcVhPNUNtL0pYblRFVVN5YU9uN3NrelIxZUJYdXFPZnlDODUvQk55?=
 =?utf-8?B?NlNqOEtNVHI5dmpXZTBPNUZrd1VaNlU2TUhjTldleEl1ZThiU2dXRGJRRTJZ?=
 =?utf-8?B?T3VuZG1UdzdQci94UGRwWTlyQjZFT24wSkUxWHlhNGRsOU1OQWxxUUkwNGJ0?=
 =?utf-8?B?WVRwSDdoazBsTWR5TDMyYytMRU5SSG5rR3licUdFL0VwZUtNVGRjUklQMU9B?=
 =?utf-8?B?eXF6dFJWajJpWHJPWDhHSHE5YzlMWHg5UDNYZlRWc2lNSlFhcVpCNFJIL1Vi?=
 =?utf-8?B?UWNZMGNnWWExZk9YUFY2UlBWTFh5Nis1RXAxaUpBYWZVUE1qVVFCTC8xWi9h?=
 =?utf-8?B?Rjg5WjdqSDRoVmRoSXVOS3VlanFqUy90K1lYUFFKd1FVaVJYVlJwNkc0WXlr?=
 =?utf-8?B?dGdkR04yRldKeUtQL0wxZTVLY2NOMGsxcXF0MkNKWEo1UHdTN3BwSzI5dkZ6?=
 =?utf-8?B?SDREbW9QSHJnRkZoWlR2NW1Yejl6LzlwZ1FRUjZQSmtLSDhTQy9IR0VBQ29q?=
 =?utf-8?B?NFFjZWxBN0RRUmgrYWZJZ3FnNUNVNHRaSFB3eVR4blBudXExYU9nMlFEbkNk?=
 =?utf-8?B?VHc4NVF1U3RmWnpDYlJ6b25KRjR5eC80VVptK1BtZURxUXhoc1lWU0lRZHUr?=
 =?utf-8?B?b2hYMGs1ZzF4cDdkMHFzZHVESFJJSEx6czE4WTJTV2hXM2M2UEhiRmgzcGlq?=
 =?utf-8?B?OVp4bUdMU3M4bGx5dW5aakM1OEVsV2htaCt4bHNqaTZ5NnBrTTlXcHpmMnVR?=
 =?utf-8?B?aURvdmt4dmlLeHZHQ1oxaGpiYkF4aDE5VHJwRERrVFc5Y1loVlNIYm13ZS94?=
 =?utf-8?B?ajlaNDVUQjloM0V6akJrR2h2SjM5QjFkQVgzWjd1L0ZzNFM5dWdwUWVjdVBU?=
 =?utf-8?B?Q1N0NVEzekw1dmZQYTNmYmRIc1JIUmtaN0dFa2p0S3UxSHN3QkdkWHcrRmEx?=
 =?utf-8?B?K2RDbk10V2lpNEw4Q0xmWDJKRzNFdEhNbzh3bHJSYUJLL0w4Ni8vaEdPNklp?=
 =?utf-8?B?RW5OalJ2d0pRSHRXQmlNTWxZVndIMmh1ZVRneFV1ZDZheDJGYjg4TzMzelQ4?=
 =?utf-8?B?Y0p1OEVBdnZSWUhYb3VWQ1Q0bDd2MU95ZnV2VXZPc01DdUVWekdYdzd0KzVm?=
 =?utf-8?B?SXVPMVk4clZZeWVhUkUrWTRzNjIyUGdFZlZIK1VmbEtmUjlrR0xiMlIrTVFi?=
 =?utf-8?B?RlpLaG1Ta0srRFhsdWxzdnF6VDFKK0EySUk0RmZMVmU5OW1hcGhWaStsSTJO?=
 =?utf-8?B?YnljRWV3WVUrUU8raXNLd2tkNkp6bkRzM0dyWVZjTGtpUEJ5NEcyVTRYOFc2?=
 =?utf-8?B?ejNDdVVTVTBBTUN4aUMzeHQrcmlpUHdtL0RkTkxXOURIQU1yVnNUd2Vpc2RW?=
 =?utf-8?B?VjBKV0lhcVNNZzZaNVZvNE5hR1g5dDkxQ0o2d0JJN3lHOHFrY3FtY1N4c3d5?=
 =?utf-8?B?VW1vUTFSRzlTeVc2eWJ2aEtaUGtLZzgvNXA3NXJsamN0N2ZlRkVvaUxkbHd4?=
 =?utf-8?B?N2w1SUVrQ3Q5TG1leitkR3psdEt4dHZack9uc29CeUZ2WkVYNnMzejZ4c0w5?=
 =?utf-8?B?a3c3c3B3S1NDOFp3U0VibkdWNU9sS3NBbnNlMlhScnZHbUg2WVJRYWlPMTkw?=
 =?utf-8?B?T0FMQ0QzM1BLNFpDOFRYWEpYZi9oQWpXbkhTT1VDaGYyNTZyNnVXdkFWcjhv?=
 =?utf-8?B?bFNRckZRVTBXekdRWWd3eGVpZUdhSzBNTFJJY1IvZFh1cFFZTUNuZ1pBNDZa?=
 =?utf-8?B?Z2d5K05LTktqb0R5SDdKNDk0alpxNzF4MzY0N2hMNFVoaGQrTXFvZkhxc1g2?=
 =?utf-8?B?TGM2eDFZZGp0OXQ2Slk2dnNhNU51OE8yS29kNlhyQXlFY2tDcTBXTHVFS1hX?=
 =?utf-8?B?Z0FuV1ZpVVNPTmtYREoxWHI3Tk5FTjRwM0tiRGlwamtTU1V2bENWbWVMcFJn?=
 =?utf-8?B?cFBwQ0c5d1BiOWFreHBydXMwdVpWQUN3eEZGVVdyZnM1Z0RMbmdwUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eeb4df-b90c-49dc-11db-08dec15db7b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:48:59.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0ximXPaMJHiMP8AV3N9eKEqUXSyXTAAbStiP3FrY7LG3SAuDW2pI7Wa/pMRv+b6s2LcLwstTJi4PK+Ov9hp0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9678
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

Add SGMII interface mode configuration for i.MX95 platform in ENETC
driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 10 ++++++++++
 drivers/net/fsl_enetc.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 206f1a381bb..8406f70345c 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -362,6 +362,8 @@ static int enetc_init_sgmii(struct udevice *dev)
 
 	if (priv->uclass_id == PHY_INTERFACE_MODE_2500BASEX)
 		is2500 = true;
+	else if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII)
+		return imx95_xpcs_phy_sgmii_1g_config(dev);
 
 	/*
 	 * Set to SGMII mode, for 1Gbps enable AN, for 2.5Gbps set fixed speed.
@@ -456,6 +458,14 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
+		if (enetc_is_imx95(dev)) {
+			if_mode &= ~(ENETC_PM_IF_IFMODE_MASK_IMX | ENETC_PM_IF_MODE_AN_ENA);
+			if_mode |= IFMODE_SGMII;
+		}
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
+		break;
 	};
 }
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 6d868e82f8c..3c35060ecb0 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -104,6 +104,7 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
 #define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
 #define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  IFMODE_SGMII                  5
 #define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
 
 /* i.MX95 specific registers */

-- 
2.34.1

