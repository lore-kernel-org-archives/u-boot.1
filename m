Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69681C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 02:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD96284AC8;
	Tue, 30 Jun 2026 04:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MnB1DNf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A034684ACA; Tue, 30 Jun 2026 04:51:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA51849F3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxJGD178Bb16GcKN2LmA4cLelcDdNiQ3LfQK0f2vfQQzNv3GYdP6cUgK9DVW+9zeoQSHGFlSwXj3VTBKrXMaJPHtPbKskdUPB05UMnaiOWW5zD0XEgs/L5BMUIAqh4s8VucnG/Pz4ikiNf9uCvHQJRUAznFk+MBPR1YLhUE7xfHzCNpUVYI+vNzuORU6BLCKfM30HsEZ0rzNPyrxauBPGE/ELYbE+M7zwxU/fdHHtOTLj5w6MxPeB6/29AxzEzo3Xxkpv0ozHNsbYptlPq4Tympb/iHqpPXuqZ5eaIEzcGaZRIjXMgyAwpE14craG0UMRtrw1FwohfXEVzApP6bRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxojBAiYQu49PJTaWlQM1746sntaDTiRjJqyXzRX21s=;
 b=ArQNFRXtMhv9vUinEUD2hnM/FutN4UZxjh2iiLPrnI1DpJRL2xhCneEixA/JH81i2QrTcAL8dOg+CSjEaUdP6PCxDFGKY8EaGE6QMBUxdOhRtVLt8NlRIWz7TxAnPXCvWAX5NrknlngZUtToiRq68FI7GNfIDITWsqBYutJGEYrpDwOafBfwbO6teGS2sTT9K2p/5W93DoalyXPLzDU92tkuVXu0pckkoqoWgowKuaI4DuJZJmEEj6T653wxFQHfUQpvo1vHMwtSDBlLc9iz6TZC2MZs4f9pYC0pnmRG3BE+Khn2LFOWTRhZIUZRaDn5hyprI9ADQIEsVZ1tCvxnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxojBAiYQu49PJTaWlQM1746sntaDTiRjJqyXzRX21s=;
 b=MnB1DNf1Krdb/UXl+stN9kuKg8NWSGmvcW2RVJuTeUaSW/nCEHjHhZET6atEFMBuEZVIkyShokhKTTFZGjihhv4bWCWlxGuMbooVkUkCkxZrz4yhj1g4GmZV+7jEQCN04VeoK1YRf41a/goU5WMGsKYXHq4V3RSvl6A3p9krh4eD4XLGF7x8Jf7fJAX3b9KYpl8LjDWtPwHgnVCDtO3Z7W94HQcyxUi89ESq0io29vNAa40nkm70JZZhrRfcaR9QdITEEKqPsO6yVcFAvfjijGyGsiy4/Lh2GMIrJz1GJFBXy5Km3CeVugsKky1ZIvY2Stny8R24arHUo7LAxte9Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:51:49 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Tue, 30 Jun 2026
 02:51:49 +0000
Date: Tue, 30 Jun 2026 10:55:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: Re: [PATCH v2 v2 8/8] spacemit: k1: load product name from
 environment variable
Message-ID: <akMwEDC+dvCB0nGk@shlinux89>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
 <20260629-m4-v2-8-cbc91c6b83d8@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-m4-v2-8-cbc91c6b83d8@riscstar.com>
X-ClientProxiedBy: MA5P287CA0361.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d1d5f4-ca4d-4a34-6db2-08ded65287f9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|19092799006|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CCbfnRA/iIj3PCI9hX/fEgavjNjHT9ELTe+gGTE21BCuiUjEDgJoaP6Bud2FsWifRUiA1nHt9g/kS5jVbb9mysKJeD6yIcYCEo3J+IKPIRQPx1Zkt0D53VW+h+Pm5cDZuijmIgQATduE4QQhwdTzDbEUYC7rMdswk3ZCeVQM1TvcM6UZG0o23jMCsHiqJTJjlWiVWPQGnpDlRZ6g4eZqhljmwin8xjYgayflGUnLfmRmCDy6DF4bOiEfiZkwLJU/svQyGQkb9UwwDQJ3URjtKAfT8KN3iO4vn7LiDt/T7kj9FDMbde6Ps6eQXSumUXpdkvNSiBDfvhcOfMgpxV7BUrwltestDs7J7G72Vkts562YS62Em/5Stvy8xhYFkPUFlVufaQL+Eazhdp6ijJGRD0QsbFeeX/PBDn3H3Scl3ndeBn1f9XF7x6Kl34radOdoaWSxZKmst0TRtbojv5xzIS6E1FSsjzQi4xfKKEaK3lhriFGk4F3Ky9iFjD+ODTnlXACLnpdDsd5X6qsM4ioaJ2/YsN0rsAkf/NxfX/zlAqdWkdPzSbX40JtbQX6UJkq33gHXMeNpuzJdWpQ+Cf2HmDnew6ZXtKanTuxpoTYrlq0rOQeCTPcJMbBIWlF2C4OgCfD5MQkwcS/rMrbzzq6mWxIctqJteYPCWv2pH3LpVaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OI/6T9QgpVA1X49BTf2t4EBhmq6EaBQdKxG9dBRSBBXQNFNFXqgxrgDhlqvJ?=
 =?us-ascii?Q?7YyDpEpQ9iJIII8jOaxFo7CKRbno4vHLrqL67+VNUeg43P72skhLLOenSTfv?=
 =?us-ascii?Q?k3KS87ElO1aeN4aXJ5KjlOnYDJ/l+DQLCB4t11w71YmLW4X8Qmn22rFZJp/f?=
 =?us-ascii?Q?/tgCYTFQW9lhScNBE7r3MLUfPvaB0maYDYg+oiPBCRH9cx2HGUV6bcEZtW2E?=
 =?us-ascii?Q?munXV9lCkbZu6GQx7GBWXoN7Bjd8aCYMjyrOdluQeGfMU4xmOLTIVfmrQjhk?=
 =?us-ascii?Q?o/h6BB/JJS/vOc/D0dQS2PwEsGQM4RmMHbkt3ILipOrPub7gPON6s2nObj9Z?=
 =?us-ascii?Q?O3v2265ByvXTIK5swsC5BsskPGLN1xO1WSSMYr1Fuoyweycv3Aiio/KFn8Sn?=
 =?us-ascii?Q?7P2zVXW8x4sjAhkVjcAuFDY8RfDvSLvnpNU8bG0HYuxfP6CiFnTHgXjmgpR3?=
 =?us-ascii?Q?yAJLlO+lVOPrCQIBBumgD6GPsDFueELBIU8aezzPLSwXizTy1fmj6J8Ulggh?=
 =?us-ascii?Q?x3poGeG+VxUTFLAL4UbfLc3p457aUsUQZF0r3mgupK4f30Ia1ydnygtFOv6M?=
 =?us-ascii?Q?AIIKO8oK9GImFBw2XA1zNuwWMmILxwffZP1fBAk3FwkdlQtKRMxf2uV3ttR4?=
 =?us-ascii?Q?2LnwWquNp8Tcyblxam8/afEoTC/zFLpUajSfkhu9NRzD9IC76htiwvenD+39?=
 =?us-ascii?Q?yN625DCLb9RWHFacFj4FXqXXB7ztPlRMMCLj5p2F9yigdvOV49bijHTrzX+4?=
 =?us-ascii?Q?PCcyc6kQyu3T39hEFYre8QggAgiAGw3aqL+7GLvBmf7vDMWlTGnPIBXwVZJG?=
 =?us-ascii?Q?Q57F3e0oBZDYt0F8JMEy/yXmwY2rcjnGmeAzx8xsV5wxFonlylV0GfgApcjm?=
 =?us-ascii?Q?sHPsVYuuAvTV7JOJ7fkHCC9WYlSKgIHJQe87iO16xgaPmQ+gU9aROs3+w+C3?=
 =?us-ascii?Q?lE2pxd0NCEFGJCW1Qd9yXKDl+eybi8T1OcrKj5ysFL+3/LQIHunBLJFzttg1?=
 =?us-ascii?Q?FCGo+n5uJjIy00qNCxp6UWk7STj3dl0o2/HMNtzuZ5oWkuinuXThZq05guAI?=
 =?us-ascii?Q?sMq2NULTrk/TsKuWAjg/fr7ebGBJCCClFZe8GiErT8fdSSarSurAWkbLzF09?=
 =?us-ascii?Q?POcX8uc3G1xpFBqDRljSobPk/MI66YCdkIlY+5c2lIq5xxZZnYDuEYqetfLA?=
 =?us-ascii?Q?NvWuDsvGjT7KuZA4sHwAM926eszrGiQtvcEA32A3u5HwBJmn5ly2qRlWHATd?=
 =?us-ascii?Q?OEh0bhrtarkM0GyFxSvaS4+Qd6/86sXOBUB/FGIq2+hp4wmVtY0R46E2R+uc?=
 =?us-ascii?Q?nPu/fT0HXmAFw5nXL3EmIc3XTr97kl0Xw1pbIy7+I34twTkNzp16bK6yAing?=
 =?us-ascii?Q?MlnVq+tV7VU4zk054kF3Umd/qgrcZ0/UakL2hBZdjw7xoS79t36dASxshJut?=
 =?us-ascii?Q?o1PeuChj4GsrMAPd/6AIdY/8q7TV8fjs5wPyufAkkLUYE/BSD32Cp2P1DWKy?=
 =?us-ascii?Q?TknhfdyljsoMQcWkcbUWcog8nouvs6lx6uaSvpsOFGg8TYpP3xtNZ7w/EE7A?=
 =?us-ascii?Q?n4XEd6atckKBAm/9JFOloA26OiNypI6RxrkDHij6jZMMmQgtd8nHYm5tocvk?=
 =?us-ascii?Q?4fkWi4nHh3l6JpKfKoOi0fN7ETOVSCsqvSSQ7fr5PZWnVlmHlGdfY+SNSuMV?=
 =?us-ascii?Q?Jh1E0LXm3jBFb6BZ3c/cIczSW/9mu09Hi0cWZacAQYemeAWHrbFwhrdJX0bm?=
 =?us-ascii?Q?zze2E8+tdFsi9a9QsdZH+VnNutzpYmwGOniZyhSvflprWdNkEK6t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d1d5f4-ca4d-4a34-6db2-08ded65287f9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:51:49.1389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9g9gBHgmdMSzee/10g9MbDBxcE9QIvxb19xb1q4RhrKG8fnND5KvSQufoz/0KrexF49STmbtSpLBqA4huI3/z8FTxwLs5Yr4ylbwy0/sOcMVXImnJn9pEjp7zJ2nq0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
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

On Mon, Jun 29, 2026 at 11:51:22PM +0800, Eric Chung wrote:
>Read the product name from the environment instead of EEPROM,
>as the EEPROM may not be programmed and the environment always
>contains this information.
>
>Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>---
> board/spacemit/k1/spl.c | 50 ++++++++++---------------------------------------
> 1 file changed, 10 insertions(+), 40 deletions(-)
>
>diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
>index 0db362130e4..4f8b2f1035d 100644
>--- a/board/spacemit/k1/spl.c
>+++ b/board/spacemit/k1/spl.c
>@@ -12,6 +12,7 @@
> #include <configs/k1.h>
> #include <dm/device.h>
> #include <dm/uclass.h>
>+#include <env.h>
> #include <i2c.h>
> #include <linux/delay.h>
> #include <log.h>
>@@ -73,39 +74,6 @@ static void i2c_early_init(void)
> 	}
> }
> 
>-int read_product_name(char *name, int size)
>-{
>-	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
>-	struct tlvinfo_header *tlv_hdr;
>-	struct tlvinfo_tlv *tlv_entry;
>-	int ret, i = 0;
>-	u32 entry_size;
>-
>-	if (!name || size <= 0)
>-		return -EINVAL;
>-	ret = read_tlvinfo_tlv_eeprom(eeprom_data, &tlv_hdr,
>-				      &tlv_entry, i);
>-	if (ret)
>-		return ret;
>-	p = (u8 *)tlv_entry;
>-	for (i = 0; i < tlv_hdr->totallen; ) {
>-		if (tlv_entry->type == TLV_CODE_PRODUCT_NAME) {
>-			if (tlv_entry->length < size)
>-				size = tlv_entry->length;
>-			memset(name, 0, size);
>-			memcpy(name, &tlv_entry->value[0], size);
>-			return 0;
>-		}
>-		if (tlv_entry->type == TLV_CODE_CRC_32)
>-			return -ENOENT;
>-		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
>-		i += entry_size;
>-		p += entry_size;
>-		tlv_entry = (struct tlvinfo_tlv *)p;
>-	}
>-	return -ENOENT;
>-}
>-
> static const struct {
> 	const char *eeprom_name;
> 	const char *fit_name;
>@@ -117,9 +85,14 @@ static const struct {
> 
> static void fixup_product_name(void)
> {
>-	char fdt_name[I2C_BUF_SIZE];
>+	char fdt_name[I2C_BUF_SIZE], *name;
> 	int i;
> 
>+	memset(product_name, 0, I2C_BUF_SIZE);
>+	env_init();
>+	env_load();
>+	name = env_get("product_name");

Need a NULL pointer check.

>+	snprintf(product_name, I2C_BUF_SIZE, "%s", name);
> 	memset(fdt_name, 0, I2C_BUF_SIZE);
