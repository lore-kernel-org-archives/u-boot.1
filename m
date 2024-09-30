Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B96CF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FC18841E;
	Mon, 30 Sep 2024 07:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RJEC3+em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589BC88D16; Mon, 30 Sep 2024 07:47:18 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2308841E
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXD0kzERJIz2zj3ExYTGRlY5VsWzyAllfOHVTykv0sM4K9Xaq3WzxRukB6Vf5rWM3Luiz1+Ywt6XI7vXuqIkFjeMWCf+Gmu2Pnmnk8x8d7FMYWjXGnZGB2BxGJLsJOV1EpZUsDqU75oK4b5rzDM29t7huAIYFFBqhd1zYi3iAPGTyAC5KKjdJ1aZrcKSm45GpY99qFH0ZNLPErlDRoe/+FFJH96GalDM8AhMdka4giN/arKsQeThSEjwhEeaEpTtdiLwYgt498mcnX9CM8Kq9tjdiD9UZ/9vR0PC7I/tTjv12rmbZ1Kh51IbHONGFb/RVJ3akYk4SSa7WtrXfonnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKz+uLRD5WD897V6D5Srt5cQFiF+/95ut8rvmeNuKa0=;
 b=wlXRtk3qKslyul6Ytcc9P6ApzGPK0+YFkX2cH9G1e+6/o9xbiinDahZmW6JeT5smW1ucSjHbK9mxcAva5rxFQwEklbycZnyKT74tTQmZQ+LgrDtKcRtrvyv3WTMy33UfYwAnGQIZkz1Mpnw6cMjxAJex4BpjPy6zqTpKmPzuMSKRPQ9ITIW2cVsmJq1MYuJWqszfromcumgp5z6jvks4/w2NbcHuFvxDRF1hg3Gav/OzE0Q4TAA9s4F30i//SpHZpyhJjd13SHiHccmBDqZMEOaO9nw2NMb6cZZL/ni/2G5PgehCtLCYWzz5R5oRE/QAuBUU3XHDy2x5zgCIrH831Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKz+uLRD5WD897V6D5Srt5cQFiF+/95ut8rvmeNuKa0=;
 b=RJEC3+emxupEkotd949PB8aB2Lla0LlDL6fOuytj6gMrblqtFoirYJRrCsUqIvUJdliQf20pbZ78N8k2SeKU6YQ+POVhMFcq5n8MfAYgQtziP16C3mlYj2ydKo3OuoInLjRUCoWqqTSR+TsIJQ0+c1bK7aV4HAJpnWJvpv0A6zn2kpIlmW03Z4lEEKgff/o+SJWkgybsYY3HQvDxGIIk8PUPkWQQNChqhlWH2jHkfBziU7VNuLBAEIIqaP91Q40fjsFV9v8bGyz0ZkZNJtiZaauoig1Q+kF4MxanziMdpRK3SrXdHdQp2R6AU5BoqXuByZDBAAphujsOfImNGRU3JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:47:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 05:47:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk
Date: Mon, 30 Sep 2024 14:50:37 +0800
Message-Id: <20240930065041.5554-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a287997-0b61-4738-b4f0-08dce1135513
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P5XgpFKDo5CXrhVM9YYV8gna+TO0k2gpN8u0G9/LMtdEfN+fDlL0k9eczlfh?=
 =?us-ascii?Q?9nX3OjyeaIFx2GSXakku6pv+OWk9/9o3R7pssoU2Ke8EAaLqlHKvQ8SDSKfG?=
 =?us-ascii?Q?TY9GhQtm3HDZkFIM543RFDzTVy00Tl9LwWYPtflSuHtkFzZfmDUhzXVW8SNH?=
 =?us-ascii?Q?+dpVwrd+xN8qSYqzcGr07aFOxCLEyC8+VnMwfhNNK7MkFpcbQZE5rC5/hImi?=
 =?us-ascii?Q?o6rBHxchzJAAAUX0u6WPGyPYO0xVzOsDbgrz4IjH1Fs/OykFdYgOtdSQp+6f?=
 =?us-ascii?Q?a52cRXbvQmi/lCrz8LOVAwQv/ainDQ+qvAqAFt5cCFQkXqMxJ7EKY/pxHK1p?=
 =?us-ascii?Q?AQPTZBtlgvGrOMCmHY3l4Nff3dcAhXTKm1YaK9S8Rm29oUJtemW1Fj1k3zwS?=
 =?us-ascii?Q?sIEBjzV0fSNiETtyndyloJdU/jiSCwmJOPzknaOKjNuYMZLnRddflG0CGA/n?=
 =?us-ascii?Q?LoHNCKa2KYwzcniSTCre8Fl5FBCKDZEPZaso267yYcTm/hWntUYTg4v7G3pM?=
 =?us-ascii?Q?kvdBxhWoCt3dLUnJdNH7miRpJz/065Nv6uyTQy3SOshAc77tcFeGqvzl+Bqk?=
 =?us-ascii?Q?Frh5zevco8SgI/PRN6TtTYSJrCgYmgtSK1E2olEv6Y3DPzCld6UhSgfkkiKK?=
 =?us-ascii?Q?RSAHJZ9PLsS8y70FYamiIxdivVDeBoDjIp+SvONXFAEE+FFlBjFlj0ijd9D7?=
 =?us-ascii?Q?Yskr2FUinpI1luw/6/6DFRg7KN8Af8Z+WcVRzRMxjIAYve3njO2/NIL52Zv1?=
 =?us-ascii?Q?7jXvqBLbsG/Fe0jOCtQxOBdNoQ+8u+c37v01CdTwbIFPml/G/4vmOFzM7Uhb?=
 =?us-ascii?Q?rMKDTpXR1ipYH4805Eb/MczJqPHlSqLwy5RwDHZdaI9PM8Xu8yhEuETC0/Ax?=
 =?us-ascii?Q?xrv+OOtd6eg3dHciQo+tt6TCgnJIhNZe4DpPCRjKQU3oO7ioG6/h62lTM1Ve?=
 =?us-ascii?Q?aco3eDxiHtnJC6Bt6R4AfX/IxBLEBm3W1DS3rur2/3CeISR3ZGXNLrkfPEht?=
 =?us-ascii?Q?U7XdQ/oke80reneHUeNqcQyKhZE6WctZMHm73fDLEQjLTKXxLQM+GFQEkFWu?=
 =?us-ascii?Q?ThdI3zPsQ1t3ZcCNd0GiDbi9gKcJ7k9W4cNdh9d90qqzLKVc6AGkoqJmrcc7?=
 =?us-ascii?Q?3ajMNwaGSJNmQX63kKlLigP/z4aAqdaCFIJDqLCXWXxLMKOK23LZtr0bcNYB?=
 =?us-ascii?Q?JKg9BCwaKW28q0fskmSTIYBg9YHWtFGryX6a8fvwPyhUd46MBtljzkbh8W8z?=
 =?us-ascii?Q?SCz/zF2fQVvOnM48T5G4517+PUo/XbwlWdiRVBmMUa95zbTGwOVxu8Np2DrM?=
 =?us-ascii?Q?LBSi9uBn17E+LKOe/yDhqXZ3OX3H9yngcI0CC2hyudC6dS9lXBi4nAgSwl4W?=
 =?us-ascii?Q?OzCliWwitbRF2q3FNUKV/oKubDNQZATEmQ8UckcojIqGuDRM0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6XH3GRVILaGEp3knJzefGT5XZencF/mgoTT850s7GPrXb8nou3vo7+Ftq0J?=
 =?us-ascii?Q?ZDP0kk6bnl3Q0fG3D6qKG3FY0uTZpoQX+it6T3icWI0Zp7g9I/1hpgbWw0Ng?=
 =?us-ascii?Q?BhIMWydCqm4rRi9hlCbvpygTyQYPE4m0x8X38JfoxCkFG2zQm92SPugT8o5Q?=
 =?us-ascii?Q?VIYz1mKBTCh1N4G0iljk27JloFn1hTOXJdUsF2jZN1ABaS0A0ZIDRPX7Lv1O?=
 =?us-ascii?Q?RLGtuq1zWvz++cxm9MBw6GlmzrKCQbHWxhOVaMAHTqHcS1pvS0wS8r2j4JqB?=
 =?us-ascii?Q?eST+M8BUpgXE1o6BFVC8WI9AWgfDrBvjOwf0duxKOdNeJ+3CELsYkSO1plwL?=
 =?us-ascii?Q?LoO/4MPEpPOmDIZxOKu/ogKMrnsam/+JdFXD1Jvw2MV+xAqMyQ8KSm4eNAxl?=
 =?us-ascii?Q?nedMAIyE37pVCHKVahkFKrGPrxAwEtCIsVu3v5XJA8Icrpv611xvzm7BGUzp?=
 =?us-ascii?Q?L1dk0dfzvZ92mt1zFYr+bL+yD/O0VNG+Lz/aM0log6mbCB9N4qNxrj1VZj2y?=
 =?us-ascii?Q?387pdZ7aZcusr+YIsjVO7WclcxTBB30KDhLncBvJRIhZyS13rzEbcQ5vuUdv?=
 =?us-ascii?Q?qkYOyd7aqvqDEyXtd3g4BdqRmk37ap6flDyZSL+eXx4dRwYZ7AOGfpzrgNB8?=
 =?us-ascii?Q?N81kJMXZMO65QPwwXQ7RBU3+e7pZVlBdEu/k1Oog7gvyWItASs6/8YtjMP8W?=
 =?us-ascii?Q?8X0q05sVfq+tfmshbFV+2q1KI4LsIIgGEhP3cWBZV1+Gc0K64bRSMYJb7eqf?=
 =?us-ascii?Q?STk3bIJVcXPuM5rZti27uw8h1vMKBgrG3TGtzOlo9pnJdBMVjr4gexzZLrYm?=
 =?us-ascii?Q?FKr65aINueN4uLrftCFZGb/G/rPi0lAzQQoevzI5YJPvp7nWUwL9Vv0HNG7A?=
 =?us-ascii?Q?FIn5okyJhJ6IhcSxzZkj8a5OtHOuxMTFFu0UcB4/vwjqXSnHQabJr3XRn2mk?=
 =?us-ascii?Q?Bf5UMcjGxm+CdcXnW8FoHCELktTPGZC0VCX6f9k5Oyb0j7ot1PuXrJZHDJ1G?=
 =?us-ascii?Q?fyWtz7ZnGW8OvJ64jyZHj14Umyykq4ZB01GDB/f5mjitacKm1JhVLeVfgTyB?=
 =?us-ascii?Q?wofSF3Iv3UmVH+B4OpQupneYRtNXR4V6iGeGUx4jM6qKYsDZkMtGdlifb3uT?=
 =?us-ascii?Q?l7zl4SljYdPZ9XlZAt9nQ6GdhBknSE8fG+ezcGniDPBCKDzV/Xpe6LCjok88?=
 =?us-ascii?Q?6afcrQ3Ruo3F7arguK3rMix8CMpw0nmoNvoQBzyXqPE3R+Egs6XXc2+Hl48J?=
 =?us-ascii?Q?OeFeTM368XuHFuiZ9HJ+kfP49pQ1KNLqXbUl/Zfy9NZdJGsrdizyQBkHH6v0?=
 =?us-ascii?Q?Q3PRV9ajNKblSxYP3NEw/OuDoaXDYJt1ybGtdJ+yv0ZZUhoJXEmiof7uzGDz?=
 =?us-ascii?Q?aSjpC+m341bRimeMSRFw4GglWG4Ye1tf69EjYXH+r9+AYVqirW4eTVNN/fi1?=
 =?us-ascii?Q?EQc/RSv9ni58dma2QI5ZJ/rNBuhsjwF73GpsRviNzYWIT5skwp/HbqKlSRcS?=
 =?us-ascii?Q?1bGrSIYB44R0OpGy/nT/uKj7JkHa+8Bp//yw3mhBciBKmv893yAyazBHgB97?=
 =?us-ascii?Q?1jtbd8M7IEaPvo1yHxU3/x58j8DftiSTfF4UxDCq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a287997-0b61-4738-b4f0-08dce1135513
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:47:13.2084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0lR3OduAH0SYI8GvmoYWYGfSMO2WsJq1pn1RrFzFjOnqBSoM2MV1v1B1KBlc+R0zX2xfeL1pvRQ/Cx9eypseg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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

Only enable PER clk is not enough, also need to enable AHB/IPG clk.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 03de7dcd505..f22b03657a3 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -148,6 +148,8 @@ struct fsl_esdhc_priv {
 	struct fsl_esdhc *esdhc_regs;
 	unsigned int sdhc_clk;
 	struct clk per_clk;
+	struct clk ipg_clk;
+	struct clk ahb_clk;
 	unsigned int clock;
 	unsigned int mode;
 #if !CONFIG_IS_ENABLED(DM_MMC)
@@ -1521,6 +1523,24 @@ static int fsl_esdhc_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(CLK)
 	/* Assigned clock already set clock */
+	ret = clk_get_by_name(dev, "ipg", &priv->ipg_clk);
+	if (!ret) {
+		ret = clk_enable(&priv->ipg_clk);
+		if (ret) {
+			printf("Failed to enable ipg_clk\n");
+			return ret;
+		}
+	}
+
+	ret = clk_get_by_name(dev, "ahb", &priv->ahb_clk);
+	if (!ret) {
+		ret = clk_enable(&priv->ahb_clk);
+		if (ret) {
+			printf("Failed to enable ahb_clk\n");
+			return ret;
+		}
+	}
+
 	ret = clk_get_by_name(dev, "per", &priv->per_clk);
 	if (ret) {
 		printf("Failed to get per_clk\n");
-- 
2.35.3

