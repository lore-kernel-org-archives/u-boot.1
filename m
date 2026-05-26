Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4830FCD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D29846A5;
	Tue, 26 May 2026 08:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a5tShPWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56DC846D3; Tue, 26 May 2026 08:52:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078BB83EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKVM2SgidD2eEoIBUAzNVaKM8yTuSSKsLS0m3+6gBYcJjiXfU6mVuOWa5k3PQNw4gxG77GNSKrrLWCeaGQG4iH96hnj3vcIVuPLviP4xRTBZSJ1PFvmwx5vVBNIOFBC2LSDnSWSwunF1Nak6ZvuwUL+KZ7KaqJ/cSHFRP4J3n5XQN4/MM6lj8Ya/Vm8kvRoyrRjigEbtQ40n75Xp1wofklhiWf1GypRCnmCayDsxEXiBZpeWkE+SRX/6ccygIZuxHKfig1stszwAHb4eNYHS/7WL8tueBYkyhxe361SS8IcRH7LSaJfpfSzefa2PAzpVUfpmZ7jDu2byCBhyZPAv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A62vDV+hRrh9K6Rh6Bn5tS/LaumeOiuDgNNqfnzAnIU=;
 b=EJkVG/hf6RaphIyZjaRqXhBFTlUTcYS5d+7tPDaqlItLVU8oxxtrKnBIXmdtvnBaHRszm3EpssInoAjW+pUJG0Au++KSnLgObHthZV8jkuMFIISyJz4m6n0zJqc8B3DX6iB/6FahDDJ3vTNTMh4tIGb1+3rc2LEf7eHiYybJaNP+YxSjySOi72GfI+pN9YcYb2qfBetL1bA3ZufnAHvsfxCgWkTaX7KNJvjyst2NMrtIuYH88RIK4DG9Lal2cYbOdFuyAiWk/SG82hO1FlRiJyqVUvXaK1+bhj+zAmo6bKG/kp0W9VLe5nUpvpX94YylKRdFkHRPfysk77sJV4UERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A62vDV+hRrh9K6Rh6Bn5tS/LaumeOiuDgNNqfnzAnIU=;
 b=a5tShPWrGjfGC/9nnTLpAG8FRdd7US31BR0rrhSjcMzc2N9unkLiJxDE7mwY7Kgzg6ruIsmwEUk/pVvZxO5xlWVm5j1K73z4zm+rzIaHYliAxGG3OR0y7GEXpAsxYGWRVUaFMl51Lgt0q7zve8i88qkgT09TrGIVsH7jApkPhSuFpInHIuG2eaSKA4CCY/zHaZmg2jUToCl9emxCtg6I/M3DbQW00bMt/pIg60anpmjrmAHZ/0y/tGDxIUSfuOpfSWQ88aoGchJ0m2jRPLKEqbBXU0EwF1AkcBCytN+915GVh507aADu2x46+FhDmM7NpQW1ysFuDdKGnTl1zYIyPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:52:36 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 16:09:12 +0800
Subject: [PATCH 4/5] pci: imx: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-pci-v1-4-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fe06ce-dbeb-4221-814a-08debaf35f04
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CC5WgmRMr3jHknJdzF6KI0CHiEjfkMMODZwpFZCTpbMqrsEyc3ood55kbiqVU+wAj0JB+cXkm/iWzsWJZlRhtkkrDkhwFpNg7V26cxiHL8XFbOvUxapZdsPN+2fvXlNAZgyDxJ2aj/DvSyHg02kYVyKHKWMfNc7pb/+aAcct/EMssCNhJ7w8AJuxp920IIjk09eD92GAMrEhH15ddjAnD18bOg1kgP/9fH5GlU3Ns2JH9rg7N+JCwTdSTsOnou2/E0nJlDi9SFldRaXuGbaURTHcbmbg9+cFFovfE2Ooki1QREra4qV6GJ8+Mq6ATZHDAC8xdJ17qj1v7TcIkAL4LLj1DgeSPpUAec1NQJ90W5i8hnoSfpOOfPCpr61/B687hcMS2SKPbgQf55xDSztgAswjd2AvAwUL0a+CRi1QmuJBKPZHvxibKCW6rJk84ADmFJ4B5xCz+Y6N/4BbKaRZGBd6/nG1txMSTHe0F5P8s4b/AespVVWp3zjee/ZRyVw2OOej+W63nBj9e96Il/3EjbmXuWbxLMEbEY9wiBuswWcytW913+97OvFSyZiNa6Jdg7+SMCIMBnrL5W27IpDUL9GJrBAbuflSU8QsK3Fxrl/4Ibs7IZtiGDUnN2GFQwrYsKEpx3t/vhan5YUPtnTq1WQg2H6+zsiKiPRjg1YQwG7D74lNZkr4l+JFbznRaGt4ttcHfPuLx2T1eODPQhMl7MMSh0msV0fDBbrlknAS7G6vbYBS9XqIbU580MiiuF4P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWkzK3AxNnFyeEJ4VEpUVFhOeVlMZjIzN3JkeWNid1ltb1l5Y0lOWklZdVJT?=
 =?utf-8?B?cWFHQVYrUFhudzRld0xoTGRpRnVvVHFuTUpTZDFxVUo3QSs0YUJFeWFONTNi?=
 =?utf-8?B?cjVGUmdvdlc0RERHdGVwcStIVVlFRmFtTGxHRnlaSHBPbDRqVTB1MFY1S3Vy?=
 =?utf-8?B?OG95b0R5ckRsaU9JQ094eUM0UUtzOW8zOHVTVTF1MEJCSENMNlBmMWJkTjBS?=
 =?utf-8?B?bEFsSmViaU9pREVrZm5zcmRjOU1VMzFhcW9YemlZbkJ3M1A0WlorL0FId0pG?=
 =?utf-8?B?akpDZFhzUll0Q2pPYVFGTGpYZitVS0Y5RXh2ZGpxZCt1SFdHckRkYTIzbXVP?=
 =?utf-8?B?KzRuZlRNdUtLZVNIaFo1V0pGaGUyaGwvM1FOWEhKMVlzdDNkL1RLNTNRYW1t?=
 =?utf-8?B?aUJYWWdlMCtjaktDc3NXVUNYU3RmQkllYTgxVVFFM3FkQUpxc1N3b0pRYWRE?=
 =?utf-8?B?b3lSY0gxSWcranRXKzdBd3VMTXJxT2syS2Q0Mk8zMHpjdW5IR3A3SDQyZnoy?=
 =?utf-8?B?czUxMEljdE92RVVwRnJHM1QyTUZKeWN0VG1uR1pySWFrcGJqZHhRbG1ubnRC?=
 =?utf-8?B?ZXBiRnVQdTdGSGlLQWlVd3o2N2ZJVFhmcGFYc3EwaS94RDB0V0VSNHp2RG5u?=
 =?utf-8?B?WDRtbVpmYXFyMHErbTRwbkdxMnVDUmtrVVdsVE9oSVdjRklJQWxMR1crZitE?=
 =?utf-8?B?TFFVQkgzWEVCcnpQYVBVYTZNbnc2MkZNaUxMcUlRWWEydUpsN0U1Z0FNV01j?=
 =?utf-8?B?WTBiZnJUeTJxaVhxdVJtQkpaRTBYSzhWUDd5dXFzSkFRaXBaN2sxeXlwUi9K?=
 =?utf-8?B?WDB4dGQ3WFlxY2xNZGcrZDAwMjNtOCs4ZldHd3MvclllYXlQbWp2YUdnQ0JL?=
 =?utf-8?B?YUJXYUxhcmhIQ213QU85aTFYV2R4MjFEZXJ4NHhTTUh2dFd6MkpuUWF6c3V3?=
 =?utf-8?B?dnRmb3cvWERHNVZzc2VLY2M2aUR6QTIxdk5CSmFxa1k5U25OWVY0TVliaXM0?=
 =?utf-8?B?Z3p0SGp2N2ZBcGgwUGZXTzlRYU8ybHgyQjZHNVo0QitReVlXeEdjUFVzNC9H?=
 =?utf-8?B?Z1IwQUVTeGgwY09nN3JIemgzU3BYcmxob1JpTzJWZnNJcWdodCtQbVlmcTlH?=
 =?utf-8?B?YkRWQWFLeWpmZkx3Q1p6RnhoTWZZMXh2Zmt3VTltM1JwWnZCaDluNTNPZjhx?=
 =?utf-8?B?bzdBd095RzFrbzJ4VnNEdGJNR2FGTTB3ZWo4cXhCVzRYQWZSUzlWS2FRMzIv?=
 =?utf-8?B?YmU2TXFkRGFUT2FWNU1DUXcxSW96RlN0ZktuODVnK2ZleTBoLzQvYmFzTlVS?=
 =?utf-8?B?dXBZZUlyU3h0OCtJRW1FclZxUHl5U09rY1VCNThNbkUrMDgxQXV2N3doUitj?=
 =?utf-8?B?blQvWTNoOUFVbzhUQVZoOWpmdGc4bmszRUt3NmI3YkNLeEhRbnU5RkxFdlFH?=
 =?utf-8?B?enJZSzlIZEh1aXFxbk4vODJvekd1ODVRbXpCS0dKWC9WaFNuOHBjTkVBR0d0?=
 =?utf-8?B?ZFVBbytmRkZGWWYwUUxITkpJYlM1dWcyVWZCeWYwalZpUkh6NldGWEVpZDhh?=
 =?utf-8?B?SkVidjg0Qkg2Z2ZQQnhKak92ZFdoekIvMDFZZElRQ1NMK3N1dllKRGEzQWdK?=
 =?utf-8?B?ZDZqOW0yUkpCdEdvUDlmWWJDMlhNZmJZV1dWV216N0dqMUE3cHhCaWFwVXhl?=
 =?utf-8?B?MVVkT1V0cDJvZmdUT1QxY2dVbVMwVlR6aU9wczZTTmlBNnF1M0Z6aVRiVkdm?=
 =?utf-8?B?Q242RXJmMUpKWUNMWnBCOWZwR2p5K1h3dlZyNVVXbG5KV2wyMHhBTXBQeDdr?=
 =?utf-8?B?TjdEdFdCRzM3MUpjQjFBa3NmbzJ1Z1pOR3c0b1RhQnBhNXdJdFBmc0IzcXZh?=
 =?utf-8?B?NHo2Z2lWQUtiZ2tPWlJWRHQ5c2g0WGk1bERCcksyRmROU2s5bUZYdnplb0N2?=
 =?utf-8?B?d2pUdXZvOEFSS1kwSzFYY2JXZDZYbDBZLzNkN0VGbERZdTBCUFhqMlkzQmhN?=
 =?utf-8?B?b0k3Y0RVOWRBUk1pcE5kVDR0UzFOTEdOZXhqR2FnY2ZrQURFMW1SZW10YkVa?=
 =?utf-8?B?U0tZbXB6OXlLcVdZaHFOam5DVU04Mi9ZUXUxcDJ0cE1NQzEwbkxtTnJ6V3Mr?=
 =?utf-8?B?RUdZZEx4YXZKSTFKb0pSQnlETjQ1bzhWYnFkdnFsNmNWemxyTHdjSS96U2J4?=
 =?utf-8?B?eGxLOUhzb2dmd0s2cUlLMWw4MmtXZzhJU2Q1MWliNFhBbE1Pb1ZrYSs0UmdF?=
 =?utf-8?B?UEgyK3g2STM0d3NxNmdLWDZkcmU5NWp3d1cyTnJFMTBxMmFsWTlpK0lrOElG?=
 =?utf-8?B?ZmdHUTFEVmV6Q3QrU0xCL2VYM2YyU1JobVQxRHdJWi9XRE5IV2hkUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe06ce-dbeb-4221-814a-08debaf35f04
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:36.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD6p2BJmqCK+4gvvEADLRd/umx+QkatktKpO81YW1r5087ZxHc2lIQkK1p9UUI7ZIFuWzpgP+AQy3nlzQkUZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
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

Use dev_read_addr_index_ptr() which support both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pcie_imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
index 8d853ecf2c2..c8b8e171e39 100644
--- a/drivers/pci/pcie_imx.c
+++ b/drivers/pci/pcie_imx.c
@@ -774,8 +774,8 @@ static int imx_pcie_of_to_plat(struct udevice *dev)
 {
 	struct imx_pcie_priv *priv = dev_get_priv(dev);
 
-	priv->dbi_base = devfdt_get_addr_index_ptr(dev, 0);
-	priv->cfg_base = devfdt_get_addr_index_ptr(dev, 1);
+	priv->dbi_base = dev_read_addr_index_ptr(dev, 0);
+	priv->cfg_base = dev_read_addr_index_ptr(dev, 1);
 	if (!priv->dbi_base || !priv->cfg_base)
 		return -EINVAL;
 

-- 
2.51.0

