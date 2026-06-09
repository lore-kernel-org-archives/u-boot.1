Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB50DCD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 03:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5598B839D9;
	Tue,  9 Jun 2026 05:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="I2IfTEgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04A7846A7; Tue,  9 Jun 2026 05:52:34 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9ADE839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 05:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGGAJbQh1zTxxw3DonzUeY+SDVEWuAGj70gXxLjRPHEJ+87XtQSnZsiMhpqqBnWBTO5bkGt3SD3Ea0bqH8BG5Rl3wk58OHl5FH3xTURyeKSqUB7EpgAn7gRKyWs0nFEMjRfyrFjMP50EnRib/Jf/p32jg258tZ7RP8NH7W489PJ1RI+TXtJZjQsSJeXulmBGWjVp6fU/4yBsKSuCq4YLQ0HDAdrn0NluF8+Ba6bN5xyZ6TrmCfod1lqYgjNQPy6pAE7DW8Igg+1jjho/x2IytoYYqDkQ7wlLQZoVITSVqlGCE6l0k1rwW6It98ww71rbqvIojI31mu38I8gRjYequA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ7rVsZg5fjeV2iJ5e2oW30w5YTcawsxTvboi+qf5Vo=;
 b=HnkKvQRsJYCLYshppstFH5hqdpapEgnYnX+lxG8aXSnttsawtaJjbxuJXDJ7zUKGuUCwjcM5AcPcydWa9slbxgZhRNfyvdsA8z+L2XWYjLDyJf4ATqHqIBESSAdBIjdCLBlZZuPcQwUDINOzBmUecJT4kud4ZctsnEzpTOHKdXCeqQSX35bJn0IOuyzKKPS1CGPCE30JajTvIhP3lAgecm4em61WXxvW7qyy0aB/RZXRzIWh5fAlY+XbgFmuf1V4IGeqa1D6cXCJ24jPUm5vZpP8DIDH96irTKqMpxb5LDYVleV3Q7t/XBsBaF4todQNA8EBDAvEtJDzNKkp1DEuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ7rVsZg5fjeV2iJ5e2oW30w5YTcawsxTvboi+qf5Vo=;
 b=I2IfTEgZhlHUsZRR/O6Qp9akOUQ7YWgVnOpRbXyySE8D/GWjhg4it5x0pRD5by+tWzLtul3/DtHs281hQCf+M1dA6J9V1SL0YU+aoH6dqP+h2wL9V0cJT5MzsO3j2N4BQJdwFcrMlMw2E99U94IIV6GwhXV3imPevlX3Lfpj2M0V1SFrQ96DdelFMY199Z9SwYqZZyLwaOK2YSZHvjH6QmqYflszaPoHbkKxfWo/ubzHV+ehZG+1rSPQejcobffCpbj8ZB75ALQaxG6QQkRJHMhBFp7Z7gwD7o8yqYc/yZN1DVH0dOtFivwwIZFBF7CRJv4tgy4hsvCKqhqffHXNBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by AMCPR04MB12646.eurprd04.prod.outlook.com (2603:10a6:20b:770::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 03:52:31 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:52:31 +0000
From: Ye Li <ye.li@nxp.com>
To: jh80.chung@samsung.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com,
	takahiro.akashi@linaro.org
Subject: [PATCH] power: domain: scmi: Allow failure in getting power domain
 attribute
Date: Tue,  9 Jun 2026 11:54:32 +0800
Message-ID: <20260609035432.2011926-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|AMCPR04MB12646:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b689c5-6209-465f-f83c-08dec5da880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|52116014|376014|1800799024|366016|19092799006|38350700014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Fdj/AA3D6lhWupT8J0eIhRkYxwXTEFWeuQXWTgapq/KzdR32EwQzk9V+MhBGy9dkXMhNwow1WSOetbB1Ai0fmWaAlxkgNESkW/vaD2+FLFLBGhDREk77CEV4pqiM1ZnOloGqEEYZ/hQwOO1tJ1hs1+1cpo7WOBjpWmhsAmtPr8zNCJTkm63nkM2jy3TjY0ZdQ6HTxXw4dAYJBKqKFfVouvKFhWpm72oI6M5N5tbI8OoExXkzAiNJjjDnIQ9x048Yaxc/4K8h+zU4/xX45VHUepszBQJu1ZJwti0+JdEaK6GT023pltAWdiirFYdDsGMICkiaj1Autj3EQExQmpzWbWZpUecprIFPd4iWA+4RdZYGNu9kiX874U6bl9JKBimdl4kwpiszLEYnj2+oqOBFVmnsA2Qt6s7G9hC59DtUxCQTlGYoVlDW+W3FOaAesQ4NFhCivBMxWUPANs0kwnR6HIXho/I6PUxgvBLfJIPJpMHjUvHft8Bv6YFYS8E117DqoSK6POJeQ86Rdi2RzYTjxZo5BKRDtNSU7HnWDTkZUH0qnKehown418k6QH9UL78G7LeOLIBq759s8QrJB+Jf06wrMuJk/ayIDRnv1hLMYBD0Uogxuf7svVzgElHFj3o3ke+eaFaQIv8xoEPmTebdGK86XQ79aL0p1Hp4xRNdQeadMc7dtZN50xEXXNporgQME4szPizUXFsBfqvM7/r3fHfnUSSxWaDVTwmstliEg/Hk1V0WhuLaIQY+na62K89o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVC3rSYRtZgd4elNasA4myCh+MQZwa7F34xpZS6MKJmcQqorQdxt6bdoTGZQ?=
 =?us-ascii?Q?8mwFcz62RhUos6RuhL2767h5V+vzN1apZIGUrYDNSjxXyCDwhgCm7faXnXlH?=
 =?us-ascii?Q?FirtSLZAmlfhEy5IDpJZv4CO5V1oTqGH18CMr2R06H2P87kykKfXX1j+O3uv?=
 =?us-ascii?Q?pqEGW55wL5B8PZxd043CdeKKJhF76pakLU9CyraK9WApJNM2tyQkN2LgX11J?=
 =?us-ascii?Q?Fnw6YAXLUHHgvkuueJDquHOswwwV7jtQRJVsBunMKjKZldvBcE3yne4oAn8J?=
 =?us-ascii?Q?TF29QWg0KF4v0/mN4p7K6OEING4h8C3GmaoR6AIUMdPOre2beHOAmPf0zRMX?=
 =?us-ascii?Q?vjPPm1kdt01N2IXG1m+tvRc8eD3orFLqakB8cm8wE/BhuYphMIW9vQisgcFF?=
 =?us-ascii?Q?t1Da5ZAut/9oxJ7IYbMuoRcFMDWjgw7wE48Y1lOsa+dol8aenFzVKNPuhJ3u?=
 =?us-ascii?Q?ut+Y/zm5oF1+yNJXF0qZVzHStM2cxrGUTCtV82/ntE6uMT0Bs+O/W11P8Muj?=
 =?us-ascii?Q?IBv0lFvkMqhHw92fWC3Rr0eLMl8K7HY5WWKCNaWM19LdhCQuzOW82JZvD4pG?=
 =?us-ascii?Q?gmgvsdigtoFk0VC+PmH6Km0psmsxsyPWLCSsjylD/yhZtwABVBd8Qk2MhgO6?=
 =?us-ascii?Q?IQTR+6A0ngj75qv+Ih7MkA2bOEklBzmu7kiaPD4aehwjQ59WNnwYV5KItH3N?=
 =?us-ascii?Q?L9qtTFczUEQH3gHq7AiVWJFtpKInv52q6QvPBCcLOIWzPz548w743DKz4Adn?=
 =?us-ascii?Q?K1AelfhY12PDKI6DCqj3CBY/Zgf+e3xoiMv2WFQf6nBjuO67BBJUpQeYJnLg?=
 =?us-ascii?Q?lLEhnyPoEzNxQHqp/mHlRoLwkA57DzlGiWShxHy1iQZ/QUxiU5BxDCL+MAMJ?=
 =?us-ascii?Q?xs40NCAJUZWGUysH22LrtSYSiERxvLDn5DDQ571Qh56ApfmFUlHNNuZkHufq?=
 =?us-ascii?Q?I/BRFlwG3wgAY4jiHqIFW9o/VUyAMnPHrgI2kKBY8pNIT++x7h38Bib7Vkv3?=
 =?us-ascii?Q?t1qRFcdIROnoI8679Z7ekvgpNSuJIqb8V6GLx6m0c00k45dNuiS3hPJI5fCs?=
 =?us-ascii?Q?l0YI9w5qgLnY78bc9H0VaohodT1+HaOhOlp5Zct71em7T16W484ELgsJ6UtF?=
 =?us-ascii?Q?59NZoRhrxCMn1/FZ0aOU0pKMMvSJ2BVrDU/JBtLLLy+3jqWbjzkIr90kPL4k?=
 =?us-ascii?Q?kfIR46qsF5gEBuRx9gnrn4NpCH2wqrIj/5vh1qqfi6ajzCLFeKtrItR8lxEF?=
 =?us-ascii?Q?M/N8pnAfFt3s8lQuKhQ6Ax9+dJJpWZNaAFeBoNgutFGsuB4/5N1GF0NiF4v0?=
 =?us-ascii?Q?z9MTRsGkCxuuz6put1I3vvcKA9HthHewctQnYbcg9gw6hmEK2wI7yKHAyIZG?=
 =?us-ascii?Q?5G2AdoeuCgV1adyxaGwH1H8N3zeRd8tquTks08/FRE7wSwGILTzJX6kGEH7G?=
 =?us-ascii?Q?kFa7SitVTieUXFYJ2Hp01AJ/f2a0h/f4sGvjiXIAqodJ8hLJwvzDgPBRsVQz?=
 =?us-ascii?Q?BEmphtEeS0O5tITALY60bpxTMf85Y4+ifZZ3uedbRPVlJ6OPtxmd8ol1tlgU?=
 =?us-ascii?Q?BAD9QVUK5x80gNfV5E9tAAiYZfZy7mmUVKfOVGJE3dVVGmTbRA4coW+YlgMt?=
 =?us-ascii?Q?G3EAytYs6bSksN2ZQTBAp9RH7V7dFCh05v1YR556UfeNepZqzU2+FrlWUWma?=
 =?us-ascii?Q?CPExrvSAnfLhWiMfftLSQdRq/Tpj1bUfmNmYomK7Xxg8pumR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b689c5-6209-465f-f83c-08dec5da880b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:52:31.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/IMP/2lmdZMsQlM3uxsyf24KNGY4nufs89SoG5um7GIP/7ca4dcio+MHrY8L7At
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12646
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

When one power domain fails to get attribute, continue getting attribute
for remaining power domains, not return probe failure. So other power
domains are still functional.
It is possible that one power domain is assigned to other agent or this
power domain is disabled by HW fuse, so platform returns denied or other
error.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/power/domain/scmi-power-domain.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
index e8c0ba8878e..c87f484325e 100644
--- a/drivers/power/domain/scmi-power-domain.c
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -165,15 +165,9 @@ static int scmi_power_domain_probe(struct udevice *dev)
 	for (i = 0; i < priv->num_pwdoms; i++) {
 		ret = scmi_pwd_attrs(dev, i, &priv->prop[i].attributes,
 				     &priv->prop[i].name);
-		if (ret) {
+		if (ret)
 			dev_err(dev, "failed to get attributes pwd:%d (%d)\n",
 				i, ret);
-			for (i--; i >= 0; i--)
-				free(priv->prop[i].name);
-			free(priv->prop);
-
-			return ret;
-		}
 	}
 
 	return 0;
-- 
2.50.1

