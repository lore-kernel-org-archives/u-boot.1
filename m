Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2321CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D691836AC;
	Wed, 13 May 2026 13:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qPas3ElG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3B4838BB; Wed, 13 May 2026 13:01:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FA18341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6hwBKElUAEvFtjNAuZIal9Thtw3uwL6bzEo4HSv23/ZeNV7tCwA6l1drlM3rIuQZ108OIE+EEmd3UkBVYI+uJ5urQOjgXnY5/0jqRchiFfiTc6ae/dxe9u29Jxo1Ds9Hdj34RoA91VSDgJbWiezEOLd59XkRne3TgNn/pMKknDFD3KA8xZ/NGaJSAnENANO8tp2ZlYvpTNAknvXoGNKfKB4xvSoRZnvXjKvAUrPiLRArFED4CVXwDA6DGNcZTIvWE+6IxYaOtMImnKCv8qfpn+hokPdUPozBRLNiYwfMGpi4Netj+CHodEd3/jo7qr/WfCluHBUUFsPsbWDLSfJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jTvCvYZp+gxBm3RQGGZNbBEqwtcAQin9edwqvZBzAA=;
 b=erLhwCrYYWVnhN1lpp/tMr7r/pT6cyEiPSVjZZqYnfsnVS5+F2JbtSIxr5n1wu5lIavukeU1ZaMOt4xmgnex7BalpicNSIR6jTG9FgU31rMJcWXHQcvKkQYc94MJd1K7KrlzE6xUbJSC2kQzuoedtwJpoGslVH8hMfLUCRZ907t04fr6xPKvsQqUvoHSUAmYWo7U4eYZCb+q2ATlPdJIpN3QihFe7E3qHLrwnrd0zfpceOqMSa1YeYfV7K1CmyoJ0k/8gWsb31iWz9S2TxzBFTHKpFuqiHdU7Td/O+fFAS0IWBsE+Zhnm0NcGP8mP2W7e5AUllJM7saWHEXMzdIR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jTvCvYZp+gxBm3RQGGZNbBEqwtcAQin9edwqvZBzAA=;
 b=qPas3ElGSfGq/u2UDV78B67oeedV9Vd4AbRDHcb2EdsRYEl9R0zBFKraRCJQNtUaMHBeY5bqhnQVgKM61Au3pchmlVTZ6e5uIDhVtKZQQ6WPmms51Ubma0J9PfROsG4ymIzM+iHy+LMOqvJC9MKKzCIxUCw9KBJUH2gX3zfVR7eEUDwpCbUciScBTXs1xb4DkL09S58Q7H7QL5b0P7h3VF5Yfl/e4d2AZugSNFw8GsijSxkxPDqfuaG79Qo2Mp101OMVjpZKmWDyio2BujZEj6mq1P2KwPVThf8JqkvMXqI7AvZuTObOX/CHof6CDHVKM85XKj/xMcaksBg8V6/Pvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:01:28 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:01:28 +0000
Date: Wed, 13 May 2026 19:04:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH] mmc: cv1800b_sdhci: honor 'no-1-8-v' DT property
Message-ID: <agRasadFIfNwO2Zg@shlinux89>
References: <20260507234836.284918-1-hfranco@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507234836.284918-1-hfranco@baylibre.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e55b11-d349-4a88-cfc1-08deb0defb7d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|56012099003|22082099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: UmMVkxoW2acnmY1lyJ1u2eOHL1eCg6jBcCmupqgZnfqy3WF72e+UIkilGsbG5DeLe7dRYR0ZIUSlaGl8ndQ7gzX0Dp46FuS7zRZYxZLsqOYsn5xAVyE5fBPHvkBX6GTxLIp2phaVXWFLVd57Dam/ZCsjGBc6I/l20ClVE2Q/pgzUiZPoUXxTa/L0LVhejBRkRrSZsqk3I8pHGe1Ie3NWdRw4KS6p4Ar9HP92cLa0OMdPHNDFbsOnKElr4ZXg8BeM5lnFMg1BQacKjCqHGdqm7Y/xTwGE3+MLzWE23QabEhqkhWsqKlg8i5oxxnTPiSmOp16uVZ7NsnszXosw+2SHDpCduC8xhhMSs8W05cVqYALpIo/AaFq/eP6BTC8L7bCbKqQYUEDuQuNL3TmUZKJ3b22/gK+vD+Ll/76mBr+I8YoyPCDzQo5uCahM5Cu3L9LVA5Gcwyc6cxJzyCTXMN9x8Pw2LmvuMB+SLMhkkfgUnOCaq0/6Zo/2BQQzsToMRvi3hjuUd4CuBc6AATLckfaEZ9JlLjVw+YpagSH7gkE1yLKk5wK5+vU9grRj1xOUfV+lQltVD3Z3k0ocZjYzbFLe4sJVFXy7giEfMHSIFEeeSyqmIOdT0rXHn5uZIL2NUY86XKga+2AuKySBujJ44xTZDcwdfbuoRuPUoVn/Mnyvzgp+or6aleNKgJJpxbRvyMfiPsrx/Ak2iJfE1q8Lx0rucVumzFHZL+JslictUlOKUZkAMq9IXOeREiivj9LUvCm7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(56012099003)(22082099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFwEGOLTaEMPIZTW/7O4yMJBtc2Rh80mYiDIaJGw0ROVGjBCMmIvhLbBVt5N?=
 =?us-ascii?Q?/JhH0QPAsoCImj/wl+747lmGd8ksXGcRjvHB0YEwT4iJhoQTRmEMgh98jZil?=
 =?us-ascii?Q?ZvlWWC4DBBxDbHLNi549+63PydlLdM66thYLUNbDRDKAm+oWyTjz1t6Uj8J2?=
 =?us-ascii?Q?iVEXNUF6/6+IZxLKFdR4SIMHNJWRW0GB4hyRJ48ekTJp2Ebtj+cZikqWKU7N?=
 =?us-ascii?Q?Jk/JO3b7JiGkx7b0eq/ZzRHoumtxzOiefq4vLyUt6DFnPC1ULV4QVBkXRfPw?=
 =?us-ascii?Q?Eyn4oMQBFYi6gY9hIhnVQuomk/ZSGTIhkeqOenwL2Xf36zUYckmiAtiwoKMn?=
 =?us-ascii?Q?c0vGW7TxmJ7AfeYCN2ibWjGoenRwVfM/zqdf0ZUMSnvbbTf+vl8xGfCatF26?=
 =?us-ascii?Q?3NJkVs0DPrVWMqjX8FXoA2zSzjd8hmo/kNd8yLyMySCKiyifV3qYI0bo0N6t?=
 =?us-ascii?Q?NvR0TO3ulXDTM4PykzfT9jV/CNBKIn2JApeLAAApKXjgam5V8bVRy/NsJGld?=
 =?us-ascii?Q?X/8xnsdaoypzt/9ULga2PB+72HxAwOpmTcsEFrRyIwNi3daglNtFfURN7z1w?=
 =?us-ascii?Q?aBUTkoud1xvEySiGnNrT8GHj+6NvQLpkXBhQwk2pSFlktV3hADQbzxGa+gzW?=
 =?us-ascii?Q?W4+9gusqaje840ICOYsgpxSICx2M/x6YdnYU/+R+UauJLEZljusRFhVGcW1I?=
 =?us-ascii?Q?L8TCybXQ27hcRhmy37RGs6zclax8bMl/WptLc79RnMpig+5gRf8vpdnbIc+F?=
 =?us-ascii?Q?5yBTNcoMosuoLOUTis3fuvYnuSbVug00THe6PEcf43b2TrovlxOMRv0W6uR+?=
 =?us-ascii?Q?5uQ20qk0DTAGbU127ewAqz932IWUyb7dd3u59HlG2zfkz7cM7VYByc98gh3I?=
 =?us-ascii?Q?yCJmon9jElSaEMiUiOx2Dw+tKOBnYE2RfagVfjAHvwa57V+0UI4KiFVq1tXv?=
 =?us-ascii?Q?k3SjJnmgJCdworBLn9m40vnZ1WaCCkefNAwBIWentok739XjRvfC5m3XsI9s?=
 =?us-ascii?Q?3WdVHaNYZnvJa3yo6z2i6hCoO4f+3mlgBsWfDatYxPYaf1AMUda5cmTO6UN5?=
 =?us-ascii?Q?+eVuZ/ledVLiWO+NcoMLjscxr+uBKPN0bXqK/UmVulxubsWX1pNcGnQI7YI1?=
 =?us-ascii?Q?+4c2V6zodiuaqHZqYZkWttBUJF9in9oDDW2qDhz71vCvHKBzt5F0UtMClntu?=
 =?us-ascii?Q?zfkcY83k7rLtstMHAFgP2lnJ3j3YumUd8P5LcS6RS+JDZcG8b1yC8WzRh04H?=
 =?us-ascii?Q?34QIrkKFaNKpihaeP5h4v5BzuMnUKsywVf4CMnAYAeS7FY/z5PNxVHHw2plR?=
 =?us-ascii?Q?AWpwwYP0IobbxYoZEaVAPOFfOlbH6p7GxpH7ujQpKXyV+OUlVaWX0As/zPSu?=
 =?us-ascii?Q?uq7yzoHXU3eNmmSvdME/7sVJqqxZzFu5d8rnLCRVkj9PaQrC4HrDts9xmXCD?=
 =?us-ascii?Q?a/Gi0jc0IgSVnCB50JM8+p/mRGj/D2f0hd4szQclJ2tLTffqt3PnhZUGeDl3?=
 =?us-ascii?Q?WdINuXftBQakXe0KY1hY8+GEk7Vo8ITT7TWbaQRikoUxw1nHGnO2j43NPx88?=
 =?us-ascii?Q?n3X0VF1pHTCKDjaUxmHIQRG6OlDVOgcl+g/uN1QJtgP0NCJg9px2IOHh18tx?=
 =?us-ascii?Q?CkdOwPTVLD3Kh53NLAvTh19f8frJwh+KmV6e17rQ5UoGTvo3RS5P5KGTDDRw?=
 =?us-ascii?Q?ISiTF0bRTlEGBtCWflSpAyQr+riLViJLZ3BlJ1CHNsOi4UIOxTX4QuQs4+Iv?=
 =?us-ascii?Q?v0/KDJB1BA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e55b11-d349-4a88-cfc1-08deb0defb7d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:01:28.2761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RcQ1ZjLfm+YKGNGYrcN2hu+t36xQQg83DfdcK4Nm1ATAo7Jj+0gzFyoNOcAndu2y0ozFdfKggdpJMtmSej60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
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

On Thu, May 07, 2026 at 08:48:36PM -0300, Hiago De Franco wrote:
>CV1800B SDHCI controller does support 1.8V, however, boards like
>MilkV-Duo 256M do not have a VCCIO 1.8V regulator (the bus is wired for
>3.3V only).
>
>These boards set 'no-1-8-v' in their device tree, and mmc_of_parse()
>does respect this property. Later, when sdhci_setup_cfg() is called, it
>reads SDHCI_CAPABILITIES_1 from the hardware and unconditionally adds
>the UHS caps again based on what the controller advertises. Since the
>board cannot switch to 1.8V, the host issues CMD11 (voltage switch
>request), the card transitions, but the bus stays at 3.3V. The SD card
>stops responding until the next power cycle.
>
>Before calling sdhci_setup_cfg(), set the SDHCI_QUIRK_NO_1_8_V quirk
>when 'no-1-8-v' is present. The quirk causes the SDR104/SDR50/DDR50 bits
>to be masked out of the caps, allowing the card to initialize properly.
>
>This matches the pattern used by zynq_sdhci.
>
>Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
>Signed-off-by: Hiago De Franco <hfranco@baylibre.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
