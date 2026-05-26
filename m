Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD8CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5138C846A5;
	Tue, 26 May 2026 07:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xxRIxk/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAF0846B4; Tue, 26 May 2026 07:22:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888DF83FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSpd6L0rx5uY0nx00N4uJSPWv6JuBbNkxE8CUbv5APK5wzu6Qh8IiCj6UrzcuhtKrec1K0WTT/V2mVKoD0GmHgKtpivcOItR9HvNLGnFsNoDuSrSWlHfLj85pOMPTcuCt1TtVaOUShlt64jaG5BeVqFnM3Bmjnf8H1iNRqV/scUJxerYaRyepPkWpz0dJVK4ZdqvSP8v+FniPTd0N+H/qLJquIEQTJI745cBDOXuOk7XeQ7gC+xirYC8hMpjSeoLjZTg5qFN+08CcJi7YsU4KIDxUGvBDFW/pyTIM9Jb71pqmsC5NGTrT5z3XI2KW6CitBUY2cXp6ESlZ5edpbtAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zbpkY1yuiyMDZLBzvHxeT62gbW9Ty2MF+EyMpyUazk=;
 b=g6FTw0a1YtHcVAhavVnWEaFzxr7Uns1SXmIW+evinKDYLbpz3nfoye7hgh8CPuEPRFuOCqEr8sB50H44XgFz7NapqxdIjv52sgKmXW5B9WxxkMeajO15RkJYYVgOiL5ggA00yu+zSZks47SfMCUcH9t3syylHWZGMcnZGAsfxVY8f5aBMEnunO0d63n0bo7gL5HNNTdF8n7KBIXEeT+Ip+eQmeWoOJId2IByEXndq58gzUVmaYxlZHRGyTzZmcFq5J/Qr8mal+pn9RjHXo6vMGELYFNxWLPew8dwAu10OhsLkXu6KwMQizFfv7x//E/9X0bbFkoyDnlJZLGFIXraUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zbpkY1yuiyMDZLBzvHxeT62gbW9Ty2MF+EyMpyUazk=;
 b=xxRIxk/dAtgKWp4eZRzkBQ4FA59R/5iz3Utk+YZju/y69I7AIIbZJi+3IfCF23hA3TeC8d1yl3qw4ckSkZ1H99+OAnh3QcqoyLNdkm/Ly6XNJSK9lxevGyYiaBDD4Rq27yyEl8clQ1OMlJOMHs5HWMXturUxXnoM+Z6g+ScXxKbj9RPUfTV/9GEBccyVVKLACyBHmCstZdN7qkvkjKtbFLz7OrScyUAuoM4UUX64gs/uv16/qNhEA+wPwxMxx5rPwsrNyl1dSncTxl6EI+bC6dfGXPMkW7A2wBt/vY9P2gPxB0tzOr47osxB24qoW76ykzSP8HFZERCm/4wXgTioQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 05:22:38 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:22:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 14:39:16 +0800
Subject: [PATCH 3/3] phy: cadence: Use device API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-phy-v1-3-908ff621dea4@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
In-Reply-To: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 George McCollister <george.mccollister@konsulko.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: df292dbb-fce8-48db-71a1-08debae6cd75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|52116014|38350700014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: aT7EbIW05Qx2cbYWbAzH5GRmppFF4EilnyT5p08DAZ7C2zPGuLWvzL/BJCKxmUNtzjLbJhHDdh9JFqTG/rNeET9C8RlBWb7BhKyt4g5jlxECsviK65dBBy98Y7fCCn4YpwwAXP0xMVI/AI3kb5kxYC9IQ9sPgkqz1B7s87tganOx62/PYQ2VPAZ01HpQaa9vn23zkjaYuACzmNIEAXS7jh4cXDbmkZ1sKhHa+MWE1CwMwWywZJ5akNpjy82QKsLzi4Pt9aKJyeR/Yl1gByemS+rpcC2y1FKoVJa7hxUGugopiYPNgPmoqDv+V7xQjZ1yg9s1KjSnoDnRgVHIveClRbi5n39/0EIDsN6Bi1XPDegiVj+CuqqxF4PjgcIL70caHw1rtbiTfneA4SLHfvIOrgWE1lcPnqgRPFkza4E5D/wNtowDf15s79zdUlpv5IswJNiwJ7cuSb58WVWWKIkYG8PuZcxk8nS+DLj2T9P0lWgOhdh/LaxkmZQMimA8ts471dwmlXz88KIzsg6AWBWqoz7O/YD6MSzNzyS6Eub3POHm2NxC1CIbq2xmI0sT1EYxvIHzO6qqVEN2MNkB3/r1TWcWh/DFF9OtlrXuVfWim8uKd+AgVlmonZE1pYwvG3hmsl7J2KZ4YX49v02i2ghscXHp0TSEDmhlkpKzn5OrPadM/b2RPXlVMT/5UoecMtEIwoem10A6kTYdH5w05bcu31BNrjDekl5LohBOg6RyhsJqj2wRUoR35d+bK7dpcCoI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJkUkpoVDdnUkxKUGxzdS84c2JaRThhWmpUN2hQbWdQR0N1Y2dBdHM4Wm1Z?=
 =?utf-8?B?UjlRdnhBSHFKZTRTdU1sTmU1Z2xiN3JqcDBIeEhxYmo0dyswUlVVUEVIWEFj?=
 =?utf-8?B?RUYwQUhLYlNwQVloa1N6UWl6MXl1eWlTZ1FOWUdoWmtyaHVPVlB0dDg0bDNu?=
 =?utf-8?B?Z0FkMVZITzNzOVY3T0s4M2c4Lzd2M2tpa3M3ZHdGQmhBZThTdjA5d3dIWDFY?=
 =?utf-8?B?U3RYb1ArTTFQeFNJeHI0UkMwN3BwSDIrV2dmZGI2dzlnZ1R0TitqSG5TYjM1?=
 =?utf-8?B?bEZWRjFWNjlwNGplZ0dtVXJyZUo1N3V1OCtaSGVhNUU3WmtQcUd6R083MzZy?=
 =?utf-8?B?ZzhFU3N0WWRDN1FVOHJRQ3ZNQkYzUmg5VzVzR3kvVDlOYTdDUXM3cnMyTkY2?=
 =?utf-8?B?UWdoSDRkMzIxOFZyOFZwNjJjbVNQKzJOUGVFRmdPU0ZhdlBaWHc4UEZTajNM?=
 =?utf-8?B?bFM1d1gvY2dTSVE0dmx3dlYrZmdNNzRRT0F6TjFpS3NONWR4emR4eFo1Zktm?=
 =?utf-8?B?RnJvWlJZQkRESWprVDJITmQ0YjRtTHJlYUVxVGx4TFNBMFg5QXVVVHhVWkw2?=
 =?utf-8?B?TW8xTXllTjBSMTZHTlJTSG1mem9GQzV4b3cyeFJrVkdjWG1zQStIUVpTaFkr?=
 =?utf-8?B?NVRRZWQvYXhmdkRTUGJwRFJmYkd6SStlUzJ3eUNtOHhQY0V2Zm11Nml4UUNn?=
 =?utf-8?B?ajJ2eDZONlRuY1MvNEJoWldZaEhvRVdxNm5RNy83Rm5aWktzMWVKVDVBY2Fz?=
 =?utf-8?B?YWZUL01jY0dSUGFqUkZETnovblQzOFI1RUR5NUJnd3U3SmxFQ3pkS29aL0V6?=
 =?utf-8?B?RVNxNHRrL1UycnpsT1JYNFBIUzF0MVZNcTNCOHgyaW5uSUgvRUxOUVFISk5W?=
 =?utf-8?B?R05GSkpySXBCYVpLT3lSVkVnYlU2ZTBScVg1ZkFXQmtRRDNKQ3FrSkxTc2U3?=
 =?utf-8?B?a3NXR283dURRUFF4RzlzMWV0Myt5MGYxOTNvNGV2TlEvOGs3bTVFNlJxVXpB?=
 =?utf-8?B?VlRHV01PNHdmckZvWEhwM244N1g3Rm90c0h2M0cvcGZSNGJNN3FvL2FidzVL?=
 =?utf-8?B?aTduWnFTWGlpRnhVTmRNY3NNbHVSZEczMmRLY3BrU3EwRFYwbVR3Qk1QVHN6?=
 =?utf-8?B?ZU50UllMNHFlU1hrRmVmVmdBRVIwSERhTWtaTEhCM2U3Yjc4SDkxZzU1M1Iz?=
 =?utf-8?B?RVg1OXgzUTNEY1dOajF2eTBDY3BkcVkwUWdGZUhJelUrYkdMeCtCVXdhQjFQ?=
 =?utf-8?B?N24rS2IwSjNJOWVoNlQzbEhWdTN1NlU4cm5QNFU1cWRHeEJnUTVYR295RzEw?=
 =?utf-8?B?cXB5dkZsZjR3U1F5cXhtRUtVVzRVTlhUaTN2MlRWWEU3Tlg1a2tFaG1sblQw?=
 =?utf-8?B?bzVHSUFseGd5UHNDYkhGTHZPeEJyMVNlYmdMOXk0R2NqMFVjcTRCZ0xkOW1X?=
 =?utf-8?B?ZHBCdExqcUlwQ3ZPZTZJOUwzcWdXZzBRSG5EL2FtQnZab0s1UEhXU2tSQnpU?=
 =?utf-8?B?ZmVuUWhsV3lhZ3lLTnBnblcrUElmTlF6MkRGZ1pTUjVGWURNWlJVT0M2U3F3?=
 =?utf-8?B?a2Zmd1RqbHlvbUZvOERzTXJHTE9RSkZyVUtqemR4NDM1NlFiSVZGN0ExRXdi?=
 =?utf-8?B?d3BDQXFIUXhOdDZtWmZyZmlWRzlwbkU0MmRlTzVqaHZROEIxak8ycWNaaEd1?=
 =?utf-8?B?aEdqaGMvalpRYUw2TXVQczNsc05LdTlWakRXSFNBQ2pCa2pHWjdJUXYxSGds?=
 =?utf-8?B?WVZpWUpuTkhTa1hkNnlsOTZFSnJEaTJ4eU9rdXZnRkN0OWJwek1tN1djY0dE?=
 =?utf-8?B?SjdoOHVoWkdMMXFBNHNqVGxLNDdaMjc1Q3lXa3FKRkdOL29aMnRhRUVxeHc4?=
 =?utf-8?B?bldjaHZsZHdSVXJBOXdsQk4wVldnZ29uMnZEbTRLZHowQWExb0gyQWJ1dWRU?=
 =?utf-8?B?SEhZci9JenVVK2l6YWRkZmFScmlpaE4wWWxOSjlibExVQkJhc2ZaNmpMWDFT?=
 =?utf-8?B?dUZaT1Y2UkhFMFFvWXk1aUxDTnhYaWhKZ3M4djNVbGE1UkczbU1hU3l4YW9T?=
 =?utf-8?B?RWpvaTFKSWVUL043R3M1enNNSmNodVc2Uk5VdS9nVkpJNjZDVG9TczhUVEpZ?=
 =?utf-8?B?MXlJREV5bjMwY3RqRk03VHdlMmp2UFVmU29iOFRDMnpYY0tWQnB5YUw2SmRx?=
 =?utf-8?B?S2xhSjI1ZWl1eWlTdzlwQVBFb29Zc1JBRkR1dGhQSnpOVDVsRVJaYmFOOWc4?=
 =?utf-8?B?VG9pRXhvekNDQURpTTFGUDFhMjFaMXlwMW9rVC90SmYwNTNxN0lqdHpxMzNo?=
 =?utf-8?B?QWJ3TWlvelpVSUI1Uyt6M3NaZXA4OUo1L0JjMXliVVYwRWFwWkdMUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df292dbb-fce8-48db-71a1-08debae6cd75
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:22:38.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QA8ydZNNPAWp4dgvjSpWtp6WA5ucY6T0Pb8XZYwsTXWLQoFn1jEtjEuYtq72BqjtonNOE5oVyBiuOVG90EoUiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_remap_addr_index() and dev_read_addr_size_index() which support
both live device tree and flat DT backends, avoiding direct dependency on
devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c  | 4 ++--
 drivers/phy/cadence/phy-cadence-torrent.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index bd7ab9d1b77..9f8a6d8d43d 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -1068,12 +1068,12 @@ static int cdns_sierra_phy_probe(struct udevice *dev)
 
 	sp->dev = dev;
 
-	sp->base =  devfdt_remap_addr_index(dev, 0);
+	sp->base = dev_remap_addr_index(dev, 0);
 	if (!sp->base) {
 		dev_err(dev, "unable to map regs\n");
 		return -ENOMEM;
 	}
-	devfdt_get_addr_size_index(dev, 0, (fdt_size_t *)&sp->size);
+	dev_read_addr_size_index(dev, 0, (fdt_size_t *)&sp->size);
 
 	/* Get init data for this PHY */
 	data = (struct cdns_sierra_data *)dev_get_driver_data(dev);
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 933533b2b0b..814aff15070 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -791,10 +791,10 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 		return ret;
 	}
 
-	cdns_phy->sd_base = devfdt_remap_addr_index(dev, 0);
-	if (IS_ERR(cdns_phy->sd_base))
-		return PTR_ERR(cdns_phy->sd_base);
-	devfdt_get_addr_size_index(dev, 0, (fdt_size_t *)&cdns_phy->size);
+	cdns_phy->sd_base = dev_remap_addr_index(dev, 0);
+	if (!cdns_phy->sd_base)
+		return -EINVAL;
+	dev_read_addr_size_index(dev, 0, (fdt_size_t *)&cdns_phy->size);
 
 	dev_for_each_subnode(child, dev)
 		subnodes++;

-- 
2.51.0

