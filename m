Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD08FCC9DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 08:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CBF83F75;
	Tue, 10 Mar 2026 09:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aZ4qgFjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928FD83F93; Tue, 10 Mar 2026 09:28:58 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E830983952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vladimir.oltean@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+bnh0W/jO7TD8lYzFbrqdI9hZdZo4JG92uF8dirwpkTz+HopUFv6qrpt8ujsr8jIqYJAzxdwDkV94MVZ2+F2c9febfpw/QEnGruVyIWSeX7ZDXMF/TOrWLLvk8FcE589J70XkcqPj6dsLVUMjTy3a/L5KRPR9QpSR/+Vyi6ozmGQs3wobL4MMrQgevYxmRGLnsV+dnDH48dVOeEzFPEU6VP/cYk+jOZ1/CGw4rD8kL6HDviPdvq/V6LK7ieui17YM2w1jO06v5Dk4JtNuWj86a0PBJJ3aB29vPFrB7dwwzXJ85kcKfyzoLR6mXTsxwdppWRwa1lwuqQ4TigqCHarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UujWDtMPSWkW/eaTtcU3sc0sbipAYWP2Qd1eqIXZWtg=;
 b=VWc2P3ymTZAOGRQbpDdyq5+COCZH/DiUgquWcj42KChAr8CgK0pWgwaqm5hLwbhqzwfsKYWo1uve83xdajwP6rOnaE05i90pRva+E58IMTNnmyd4tUrm9UOBStTYH7SIJ5lrZcpCWI/1mfky86a3w2vPq6psV99RqB2vFQG9OEG1iZlXUYqN56A8r3MEHRXfGIHft58Yy1rVd0os6NiWOj8wAASjYi851KgqWMKyVEb6nwnXuODtqcTmQPHXNp/JRsLueLDDuqJS1E1PaOqGlbVhXm0EtOUczYLh1imq0whotNhsthrjPSFE6E1kVMatc2BgNmSbTyIbys5eBJITxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UujWDtMPSWkW/eaTtcU3sc0sbipAYWP2Qd1eqIXZWtg=;
 b=aZ4qgFjBDqA86eEaz9yaiaE+GZRju3xAfB7SENRZcDBWYjREDNbCZxH/JtnZOBhrqdgNGw0g79S6EArxREtOZO+M07sDnpmlzj5lEmT1rFjHAFLa06nAN6EuAQPFmvAcgYleHCBTJrfCxR2Tlr6DKMGuQTU1vktoCvoCDV7Ub9xWO9x2XoSU9VI1ZRGOcXXQsK9wVhYmelT2wXBjUcHnXVFrwJbTZRTmwKiC8LNaGKKB1s2F9WdN+zVLDOEVpPJ9YYy8zF1squpE5Xs5LG5DT7qY3sl0iIxyV1OixXY4f937sG99BZJhrhHK8DHz26Y6p/41G4k9P6Xb6bnvCL9pYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB8728.eurprd04.prod.outlook.com (2603:10a6:10:2df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 08:28:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 08:28:51 +0000
Date: Tue, 10 Mar 2026 10:28:47 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org,
 ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
Message-ID: <20260310082847.sbo7aoqsohij62p3@skbuf>
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-3-lucienzx159@gmail.com>
 <20260308140614.50489-3-lucienzx159@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308140614.50489-3-lucienzx159@gmail.com>
 <20260308140614.50489-3-lucienzx159@gmail.com>
X-ClientProxiedBy: VI1P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feb77ef-75f3-47c7-ebee-08de7e7f0ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014; 
X-Microsoft-Antispam-Message-Info: CaYfaDOTvjIqaV43HaHLajoHBLxZP9dMuQxOB6PdpAvEb/dV4pmPYXWssMnnAuaguG0Eoz+ROIaeg1VsPuBKOZuOEXcJM8lR/D5USvWX/879RJc9gF5EMwNYjlwOw7E3WsyxCvNDWq5c7ZwylKOTK+2u0xj+u8uB2uGZ8qyd1p5x1GkFTTMMu6JU7GErUHokBAePXCIHqcq6uQ75Xj4yr2jNH7m0vRhjqV9YHFsjAh5NaeJO7QOVvhwXe3FB2zPvMq9kDWWTqR5q8zuUWXQ8/UGoBA3ZGZmKkRUTOXpbMVrn5tE+pBnV8hmxUvF7ixWOdR+MlCwGVnWLA7tOlHsc9DSIiHfLkx66EDOek+vo5Xa7ZxDqGlDce2T0EYx4Ih+5IqvCcZI8zKJxTQZl1v1qIJHX+7o3DzyLbaNoD1iWjd7IL3iZF1ngENLAIrIUAEwG6qzVM6x08PHDHuLNtrceCKwCELKJmQoxw1kXviUFE8Ij9qHYF324/AKrHNWxpM9MIwvgLus0+8bf4c3m1QImW/YUTg4/dzOxp1emwnZR+ciWAHugb14b6YiVF7c3oSKmDR9R/YovbKCjKKRcgzXQTI7M2X+ibudKy2xFj8imjhXdlzuzQTuOKh0R7Jxe/SmWugNoEMiyXrrZfbTXfKoLSPum82ymd9dKhEyK2Jo8n/qiw/L6z0yn07WsT4gZ1f4psxN07hWk9YYtiKDRAKroj1kUSf1u+0l4KYYwGwvCmH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8585.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PAKlvc0ZUp5FMUxH3ca90GYFzqEKfTd+SeTDj+LlvXvV5vRD4Aa+SeRICBVs?=
 =?us-ascii?Q?AGgs5woj9oiM/v62e8+RRpI+mwxXkmp/P2MhI8J8v1RHeL4SNaYKi9nTmeP/?=
 =?us-ascii?Q?g3f7abvRleNP8Ihdygq3jRgCN/0vob6zyFSdifPouQULKHiC5Aw8tOHbz9qf?=
 =?us-ascii?Q?6Bz1dv8UiWT3gU0cbH+wOXdTaxQ88n9JDGZuEdf4m3CdfN7cUUiCFHMtLCzr?=
 =?us-ascii?Q?mzPH7jnneoivYVriENCh3dXXD0jisrWQpTXAf4facW/Rz5uyuuTYKPoCTvco?=
 =?us-ascii?Q?A0bcEIPCmqnoxz3+lRpnMvZfAV2XInlMSjNQm75eDEeETO4/eYzAPuX8b47D?=
 =?us-ascii?Q?ilig0GMwcD6gFXUAGYdzh9WI3VWcsr7nYvIqhIEEUkckXgL3+lZ7BbGSkW47?=
 =?us-ascii?Q?AroVlSmM5JSn7DKZ6iKowPo6Z0anqjixruQd5C7+FINErePqDXjzhcmWl8ih?=
 =?us-ascii?Q?2/PVnVPLvjquj9SE3pBybZDYOIGJxOrylhUZJ4Ph4IsBpRwOCIrsLGZgocun?=
 =?us-ascii?Q?oqXZi1wV+Jn2ifeisc2xCoNDutj+8x6BfgSqu5ifCBnnmoNOrh9FQxCcdN4J?=
 =?us-ascii?Q?grGHh+lrmovD5p4klFUjQRDXZbcRRl9kJ5jZY86IMBldAe3dNS1QWZEK8RMf?=
 =?us-ascii?Q?wt1BSlrXXb8yWyDJxiUmHFEYAJFZKJ71l9DhJGfl5CX5fn7LuX41xkguW3Hv?=
 =?us-ascii?Q?wcEQV65I7kdzhZPsG2EK519wV7G9Hn1h38QVIZQk4cUaeeFOqzw1qVbQ2Klj?=
 =?us-ascii?Q?uWv0FXbUO4HGYDA6bd9p680n6MO/uD/9SsTXlYBqq0zrQMKgQx/0ztb9jYRD?=
 =?us-ascii?Q?bEc2PStHi5ug1IeIOQgWXvz3PfW5Qa/eYVd9I1hK+BSABDdyXZrkBgPMZnVu?=
 =?us-ascii?Q?RbwbRKfY9OvKoa0sjrfehQZg64u0cTUekeHJhF6qK/aBU6/uWmy898TtnPUu?=
 =?us-ascii?Q?Vt4KLlJOR7VKuPGkUtutYCLeVo/Fg++U2hUr2xMlwLkDp/G1NOhL6L9jIo7K?=
 =?us-ascii?Q?BAqGFWjoA/k1cc/ZK9q0Fee+r/gYyr7ZHYyQrImqkzE/KZoHQnDS+ka21u4d?=
 =?us-ascii?Q?mADpomnrA5o65pwbZNoErlyjJ+4PuB8+PlAtiMdxSR8xlgCO2bKDXOCccJo3?=
 =?us-ascii?Q?Ct8iU3pWg3NcAH5Yof7pN83b8a4cBhba8xdhPRQHYlyJwkO9WVLniQj3W+PE?=
 =?us-ascii?Q?d4jZYp2pko3sGUe0/TN0wJI48vnzJojDirf6HA86Erj768zPkqMFiuuwH+zZ?=
 =?us-ascii?Q?XiUct7VEgDXLyqqArqSEhyzwBxNbh3RmxHMB1rG7VGOqiY3a8PMS55byCUcK?=
 =?us-ascii?Q?z7vB3NEUfxk+QwBY5DmkO0BOVCyhrttyE1n91vDp+ql/btXXg3emQgf2Epza?=
 =?us-ascii?Q?yAcdA6q1I6xiMXE379zV8WKyLOtAaw2kdRkJOOAULrXSCnPUxQ4BU0W5XKYF?=
 =?us-ascii?Q?TNjMhnkV/2cl5ARdd2fPv37a9BrrTu0MLWDmtE4SXT2u1GrcTWHiQHTazUD9?=
 =?us-ascii?Q?ktL7Ou6GaB14BWcCl/ENXMnKEaA0AwB7MVuazxjkcZXJhU+ubGBoaIxhRM2G?=
 =?us-ascii?Q?PlWrnb+nSBr481trK6kNwfgI31b/TNoNwZ2jDvkY5txwGoQ3mrj3d/WgpMTd?=
 =?us-ascii?Q?LpLGpxSr8WU+ogFMrD5IzNWdrFVlIlse5VQQ0OJgtPs2UVA/l/gc/yAkPoWW?=
 =?us-ascii?Q?p5k3OcZuM1vIXg2aibFPMkF5ldhlQK58lQMjoSTmbWCDWVDHLBFy8+AxBeiW?=
 =?us-ascii?Q?RER/WMXR42vkx4+RIXh/jpzXzkMpYlCVvMWcZdqCrQSFHQ9+TXFb8mWxF8mJ?=
X-MS-Exchange-AntiSpam-MessageData-1: Zh0iSnwG+iQAY33VUOXEoBbhuzU4Bb0uC6A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feb77ef-75f3-47c7-ebee-08de7e7f0ee3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:28:51.4600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi0uzdv/oPcit4Q6XisJDVbU3Qv4C3zsht3pCFNcivjo6mXuIa0Ikvno/zk6hVbYh1pxjU8XMKsD0imVX0UcEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728
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

On Sun, Mar 08, 2026 at 10:06:14PM +0800, Lucien.Jheng wrote:
> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
> index 1a628ede82b..0ec11ba5231 100644
> --- a/drivers/net/phy/airoha/air_en8811.c
> +++ b/drivers/net/phy/airoha/air_en8811.c
> @@ -23,6 +23,7 @@
>  #include <linux/compat.h>
>  #include <dm/device_compat.h>
>  #include <u-boot/crc.h>
> +#include <linux/phy/phy-common-props.h>
> 
>  #define EN8811H_PHY_ID		0x03a2a411
> 
> @@ -660,11 +661,82 @@ static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
>  	return 0;
>  }
> 
> -static int en8811h_config(struct phy_device *phydev)
> +static int en8811h_config_polarity(struct phy_device *phydev)
>  {
> -	struct en8811h_priv *priv = phydev->priv;
>  	ofnode node = phy_get_ofnode(phydev);
> +	unsigned int rx_pol, tx_pol;
>  	u32 pbus_value = 0;
> +	int ret;
> +	bool use_legacy = false;
> +
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	/* Try standard rx-polarity property first */
> +	ret = phy_get_manual_rx_polarity(node,
> +					 phy_interface_strings[phydev->interface],
> +					 &rx_pol);
> +	if (ret == 0) {
> +		dev_info(phydev->dev, "EN8811H: RX polarity = %s\n",
> +			 rx_pol == PHY_POL_INVERT ? "inverted" : "normal");
> +		if (rx_pol == PHY_POL_INVERT)
> +			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
> +		else
> +			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> +	} else if (ret == -ENOENT) {
> +		/* Fall back to legacy airoha,pnswap-rx property */
> +		use_legacy = true;
> +		dev_info(phydev->dev, "EN8811H: Legacy RX polarity\n");
> +
> +		if (ofnode_read_bool(node, "airoha,pnswap-rx"))
> +			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
> +		else
> +			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> +	} else {
> +		dev_err(phydev->dev, "EN8811H: Error reading rx-polarity: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Try standard tx-polarity property first */
> +	ret = phy_get_manual_tx_polarity(node,
> +					 phy_interface_strings[phydev->interface],
> +					 &tx_pol);
> +	if (ret == 0) {
> +		dev_info(phydev->dev, "EN8811H: TX polarity = %s\n",
> +			 tx_pol == PHY_POL_INVERT ? "inverted" : "normal");
> +		if (tx_pol == PHY_POL_INVERT)
> +			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> +		else
> +			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
> +	} else if (ret == -ENOENT) {
> +		/* Fall back to legacy airoha,pnswap-tx property */
> +		if (!use_legacy)
> +			dev_err(phydev->dev, "EN8811H: Mixing standard and legacy polarity properties\n");

Mixing should be perfectly legal. Otherwise there's no way of converting
an old scheme to the new one without breaking backwards compatibility.

The way in which this is done in Linux is by reading the legacy
properties first (with a fallback on PHY_POL_NORMAL if absent) and then
using them as "default" argument for phy_get_(rx|tx)_polarity(). The
phy_get_manual_(rx|tx)_polarity() are intended for the use case where
you have no legacy property to support.

I believe doing the same way here would simplify your logic quite a bit.
No need to look at the specific "ret" value, and no need to duplicate
the pbus_value modification.

> +
> +		dev_info(phydev->dev, "EN8811H: Legacy TX polarity\n");
> +
> +		if (ofnode_read_bool(node, "airoha,pnswap-tx"))
> +			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> +		else
> +			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
> +	} else {
> +		dev_err(phydev->dev, "EN8811H: Error reading tx-polarity: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Apply polarity configuration to hardware */
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> +				      EN8811H_POLARITY_RX_REVERSE |
> +				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int en8811h_config(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
>  	int ret = 0;
> 
>  	/* If restart happened in .probe(), no need to restart now */
> @@ -695,19 +767,8 @@ static int en8811h_config(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
> 
> -	/* Serdes polarity */
> -	pbus_value = 0;
> -	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
> -		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
> -	else
> -		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> -	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
> -		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> -	else
> -		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
> -	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> -				      EN8811H_POLARITY_RX_REVERSE |
> -				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
> +	/* Configure Serdes polarity from device tree */
> +	ret = en8811h_config_polarity(phydev);
>  	if (ret < 0)
>  		return ret;
> 
> --
> 2.34.1
>
