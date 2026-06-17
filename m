Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCDCD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4D3849BB;
	Wed, 17 Jun 2026 16:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ihF3HZ+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D07849BC; Wed, 17 Jun 2026 16:11:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D7E849BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwacXunXd9hH2t503b+bfJr8R0QjHtqllrPOx7PM4Lab4xx3pzRa3BoKn40JbgtfxVGoV6uzVHWJRWOHaWWsiaK1B+iNhTgqbxv/iMas66sMmNCH94vrBxzV7gOAhN72v10uSL5GeqLKIp0hcn4c0EkLfcCnP6EwciGc7Nx6y+zI8Ge62q/GUjql91SlRY9Cs3wViC4HdXJAzMzHUuL8sh0akj/lKZbdqh71fjSBHp6lFuzdH9MlSKTMQAf3HI9VLHWRpL9Z2DuX258guZRv1z/wcS+U4aeo+z/rNMnUhvf+aqUPCj0QYHhxWBkhUwg3hXHLXlDPbbrZZ1wVSswmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jm5WO5SkbG9Y/qt2VAEMJQxgBjOY/x5uNWAQP4v08k=;
 b=KeLJpxCU4IjAyzOU7Kg+V1xuXD5D85fHHkE9WYll0bwpRuqojTDwOeVTPu2IIDJy2v4bFBCjaAq572ufPCS87qpZiocoEZywACpTVuOn6QY9d2F5fm3Z4NEmMQVc0xxMfNtqYkBfcILrZQ5H6HcAf5PwEp7kGCsNJk/oSwAxU9r5h5yMYD5t/wtUOjlb5HXRir+5XcvrGV8JcaVjL2A0yt62Aq/p7E5ORrJ/+8IV5QNGDTA3Hae+5ScViOGkDXKxI24DJoHiesEG6w22tREwuesOobcsdJbTWaDAUR+9JvSJw+7c+CPNKcTh24pdhj2eJ5KiBs8yqf6odo2xdLrBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jm5WO5SkbG9Y/qt2VAEMJQxgBjOY/x5uNWAQP4v08k=;
 b=ihF3HZ+gc/w7eviBdRGe7uJEvUAD6bUMnD0uXjbcC+MfU8weNHhLoGb29iiF899UgRUrpitgb6w5351zgw6LkpOknGQLZ3nEnHxPM6FpNdgwgYe2AiVWIrbGkWxPOp8JdGOdyvWyY7u7+yQE+Y+N6xzOu6vKInJ3qPYSR56dNASVNNtf9kQGGRckre6wt/joWqnXLx+X/dp3DmOQGzlWyneF6sIBULB9hyxZ9ZqBuhTt+j3XQxXwMPD1ih2+7zYksnhXDsvmEkzF9a9jkwzDDCwuHXpC95nNMyX1S3g98HpWt1xa98w1fzLyybsvb/z2GBg9ej61apWXygKv5MaswA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AS8PR04MB7623.eurprd04.prod.outlook.com (2603:10a6:20b:29c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:11:51 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:11:51 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 3/4] nxp: imx9{4, 5,
 52}_evk: power on mcore according to SM config
Date: Wed, 17 Jun 2026 22:14:45 +0800
Message-Id: <20260617141446.2794896-3-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617141446.2794896-1-ye.li@oss.nxp.com>
References: <20260617141446.2794896-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0233.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::12) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AS8PR04MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5f7ab0-dc49-48b3-81ee-08decc7a607f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LhIYYqAlexO43jSNA28VWZLDDgU/cmmNlyj+xoZ957ldch0HmBmX5gqBnnSPe/eu2sDIForGkkyXkXEH/jGo5qDf0TYHiHxDA75wZtFGMgMyrGjhPaIp4LE5Pnvc4O8LocED/cMo2xlyG8WLedNO/Yng82FeAcPbx9DMwA9u8urhEXGElnN1MKHMYFJgm1fQRWo76GAizobO3dKaaYu8yXpaF0c+MuQKXzYuSmoGE3HtxgMOXFrIg3FdXl/ZVAV44s8DYY7LHMs1yhcwQnISCvxVBgNXEitB66sMPu3PIOAS7INyFEFWsDvEQ6dap0xHGIXhhqCpLSREcLXI9dSKU8LVJQeD6P91nklvA77CZd/5jLuuWHpv5pBcjAyJlsjQITfEzuY3ow3t+fOYwKntRi2ukgWzawLXqvP3wJGaGdhuZrMgdLVjpkNlSYtyXXyS5qEKbPKYHxOEAxsn4XvDsb43NaA6oe47ZZzUGUW8RTHzpzgd2WQ70xUqsa4LXQLgKhQD7mxX8ct1nhpVX9q3SN8u5xMiHh+6KAHqdt3K87T8futYbpOPeCuyZ3ELDcqzjjkJ/lJD30qyv0ZSvYKi1Lng++12O15ug9+v6e21gLX8ApvCmW72VlEvjbIEw9MsFg8vtsvMhHoFQYrMaOiBZT6+TZayTWjGXCE21sxrPuXD79MEzAj3w0T6zQyZcYLH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PnPpMvZmGNv2zf+zywjgtLcIrVoCM9NmUnY1wwAGnz9Ki1aOYFjnJn77RHQX?=
 =?us-ascii?Q?6IS1QcaOPjIaMO+tG1vLTbTSpFi6kUfaSRF4xnJbCOdAp/jfXWMWafy/31EN?=
 =?us-ascii?Q?tucNFqUYyaD9FM/MgmA1pgA+vt1jQq8Aix16JLaZpJGUle2pW7WeLqaLUKYF?=
 =?us-ascii?Q?uebt9iju6vk4kFICIL411rI8O24kGeDvqDVtGGNgXEv+f0/Zegt2iwZQKr+q?=
 =?us-ascii?Q?Bd5dpzl59r3XuiFPeMizGTop08+AjoJeKC+pbJvyPc0mCUTi2CZTC/Z0fNOw?=
 =?us-ascii?Q?Uc+msMgHrl4WwIFULCwGNqoq0d3mxKWOkjAdpdIrjN69P9H44GSaxXOtdaLf?=
 =?us-ascii?Q?qZJUwOzJuuLede3e7ovJp33JMrQq0BwUFHUdQg147uy4yeEEfe4U07R3PPKS?=
 =?us-ascii?Q?g6gvMCjmUw1Gs3wcqGatv/1jF05E42zxIMdbuk+PvPx1c8QdXr/Vn6XUatKQ?=
 =?us-ascii?Q?eBJQpsKc0kNT7ww0JDFBh9OrkR3cDD2paq1P00CEAWPPA/gVcntObi81UTS7?=
 =?us-ascii?Q?kqYCImfn+eVDSL2L+QHgcI6odr6+31DJRTfzZuqKZcTVcj+5J1nav8pYotha?=
 =?us-ascii?Q?hvlNpnl1bjQmyCpIwGalEixArD8sy4EjTyp/Nw0lnd+yyVz8yTTKGOj0PmW2?=
 =?us-ascii?Q?e0JyfwLik8iNRdK6EcEdREC6h+pBJvdqqkTvlZb5ajwSm0EfGj56FiwJZiRQ?=
 =?us-ascii?Q?knRw6RHWE5jPLvIG6gCYg1dMnClmMOI9fnV9xiSu5dCVGpQ6eTjmz1BaCc4J?=
 =?us-ascii?Q?eyKRYrNmFhFFU2dUluH9RelAOhO5S9jbp9VkUgWfDPll6oiy2Ogc0nRf0xNx?=
 =?us-ascii?Q?5hbOWEaKqzSz7Av6VJKoJsVfkrT94eoBwPpvooHxoyMv4BwZZ2Qtd+7UxPeq?=
 =?us-ascii?Q?2PSuWLbBPZ/OUWlXmx+j7KxMNS8ygXggw4lepSONcr7aEdsF7MuJttCWt8me?=
 =?us-ascii?Q?5aDtrC0fnPXN323UPL2yuTYXQkUjW3U/GDTgrIbOGJXWVPUPVfPOVXmsFUgh?=
 =?us-ascii?Q?F890YBgEgkcooDIPv7jSN0a5mdG5hKs+eg6gb54KxV5UBEPyURcwRkULCBm2?=
 =?us-ascii?Q?JxdFXK5Z4XGXz43l47fDCu8Wscyn0DZBs4AmHGbzLWIqaCyXGZ+6Nm1wH82S?=
 =?us-ascii?Q?Snd6oW675N0nPkxS0itBN69mC7UE8A4ID1BOHoG9wL4d0CkgX81cKRWqyMO6?=
 =?us-ascii?Q?0/woGzqlraP1KtzbelJzWgaahm4ySOb41B8DsCNNqyQPW5P7ugPipHZoUpP6?=
 =?us-ascii?Q?my02w6aAkAI7BFxfn1YAdsGcF5m9pfjKF92POuk+20d45kJMR0zkziYH9p6R?=
 =?us-ascii?Q?WxEQ/2eDB3NO5fsOPzXN+4u8Vfz3tbfEZtY10psJVmtBMj6pea+dCxoqW33/?=
 =?us-ascii?Q?efjs37Ic/qLSYMuqqj1AdJm5BWr4ss5kHhp22PlD/iaI1ULmh2Jnyw5ZZ8yK?=
 =?us-ascii?Q?UqfaPfny+EMi5ryOA3+R4AffgBMiG21X6wFe4Xs36xUPByMybHBuFVWRJ00O?=
 =?us-ascii?Q?nZcEeshNJb3IMI+9XXU6Y41KZV0el53pKgv1mEnL4/IyGM5ai+22Emagkuan?=
 =?us-ascii?Q?iPxmy5lVqZXdyIQZghy2IUBmWDVGB4setwhePjibOs772cRMGt0tRjmDGuVf?=
 =?us-ascii?Q?fgiX9YvvHmYCMOcOYRHh1jkDqUCBuLpX/cUJz80UWiJ5TSHJEOUKpGXa9bWz?=
 =?us-ascii?Q?wTLG71ow49MioMKI2N3u7XoJ+3QJNP9ySVBg6ofANtYR5aS4MW8+5oVnlkqb?=
 =?us-ascii?Q?5ZjJxDqDefAwwfPtYu1SQPlpcdIiazc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5f7ab0-dc49-48b3-81ee-08decc7a607f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:11:51.1400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT68uM8mtzDUgrDcoTcERevUXK0OOdniRfymxG0bf24yxc2Nx6m6CZaYpKi27ZGexjg8jsFTPwwY7vvEo+Z7Ou6Mu2YBOuImbhryDVD+4BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7623
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

From: Ye Li <ye.li@nxp.com>

When working with SM config mx9{4,5,52}evkrpmsg, mcores are not booted
by ROM. Hence, power on the mcore and initialize TCM ECC in u-boot for
subsequent mcore booting.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  2 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 98 ++++++++++++++++++++++
 board/nxp/imx94_evk/imx94_evk.c            |  5 +-
 board/nxp/imx952_evk/imx952_evk.c          |  3 +
 board/nxp/imx95_evk/imx95_evk.c            | 10 ++-
 configs/imx95_evk.config                   |  2 +-
 include/scmi_nxp_protocols.h               | 11 +++
 7 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index b5e7d7d6855..5551ebaa68d 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -27,6 +27,8 @@ int scmi_get_boot_device_offset(unsigned long *img_off);
 int scmi_get_boot_stage(u8 *stage);
 u8 scmi_get_imgset_sel(void);
 
+int power_on_mcore(const char *sm_cfgname);
+
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
 #endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 372dfc5518e..c4127349aa3 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -58,6 +58,43 @@ uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
 	return 0;
 }
 
+int scmi_misc_cfginfo(u32 *msel, char *cfgname)
+{
+	struct scmi_imx_misc_cfg_info_out out = {};
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_IMX_MISC_CFG_INFO,
+		.in_msg = (u8 *)NULL,
+		.in_msg_sz = 0,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	if (!msel || !cfgname)
+		return -EINVAL;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	if (out.status) {
+		printf("Failed to get cfg name, scmi_err = %d\n",
+		       out.status);
+		return scmi_to_linux_errno(out.status);
+	}
+
+	*msel = out.msel;
+	strcpy(cfgname, (const char *)out.cfgname);
+
+	return 0;
+}
+
 int scmi_misc_ddrinfo(u32 ddrc_id, struct scmi_ddr_info_out *out)
 {
 	u32 in = ddrc_id;
@@ -746,6 +783,67 @@ int get_reset_reason(bool sys, bool lm)
 	return 0;
 }
 
+int power_on_mcore(const char *sm_cfgname)
+{
+	char cfgname[MISC_MAX_CFGNAME];
+	u32 msel;
+	int ret;
+	struct udevice *dev;
+
+	ret = scmi_misc_cfginfo(&msel, cfgname);
+	if (ret)
+		return ret;
+
+	if (strncmp(cfgname, sm_cfgname, MISC_MAX_CFGNAME))
+		return -EINVAL;
+
+	printf("power on mcore for %s\n", sm_cfgname);
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	if (!arch_auxiliary_core_check_up(1)) {
+		/* Power up M7MIX */
+		ret = scmi_pwd_state_set(dev, 0, SCMI_PD(M70), 0);
+		if (ret) {
+			printf("Power M7 failed\n");
+			return -EIO;
+		}
+
+		/* In case OEI not init ECC, do it here */
+		memset_io((void *)0x203c0000, 0, 0x40000);
+		memset_io((void *)0x20400000, 0, 0x40000);
+	}
+
+#if IS_ENABLED(CONFIG_IMX94)
+	if (!arch_auxiliary_core_check_up(7)) {
+		ret = scmi_pwd_state_set(dev, 0, SCMI_PD(M71), 0);
+		if (ret) {
+			printf("Power M71 failed\n");
+			return -EIO;
+		}
+
+		memset_io((void *)0x202c0000, 0, 0x40000);
+		memset_io((void *)0x20300000, 0, 0x40000);
+	}
+
+	if (!arch_auxiliary_core_check_up(8)) {
+		ret = scmi_pwd_state_set(dev, 0, SCMI_PD(NETC), 0);
+		if (ret) {
+			printf("Power M33S failed\n");
+			return -EIO;
+		}
+
+		memset_io((void *)0x209c0000, 0, 0x40000);
+		memset_io((void *)0x20A00000, 0, 0x40000);
+		memset_io((void *)0x20800000, 0, 0xa1000);
+	}
+#endif
+
+	return 0;
+}
+
 void build_info(void)
 {
 	u32 fw_version, sha1, res = 0, status;
diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 4731b79b55d..f0edd7d131f 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -7,10 +7,13 @@
 #include <fdt_support.h>
 #include <asm/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/sys_proto.h>
+#include <asm/arch/sys_proto.h>
 
 int board_init(void)
 {
+	/* Power on mcores when using rpmsg cfg */
+	power_on_mcore("mx94evkrpmsg");
+
 	return 0;
 }
 
diff --git a/board/nxp/imx952_evk/imx952_evk.c b/board/nxp/imx952_evk/imx952_evk.c
index 2a61817939e..74ef87b50c0 100644
--- a/board/nxp/imx952_evk/imx952_evk.c
+++ b/board/nxp/imx952_evk/imx952_evk.c
@@ -9,6 +9,9 @@
 
 int board_init(void)
 {
+	/* Power on mcores when using rpmsg cfg */
+	power_on_mcore("mx952evkrpmsg");
+
 	return 0;
 }
 
diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index 99a37e0593f..0de7fbe3f63 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -5,7 +5,15 @@
 
 #include <asm/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/sys_proto.h>
+#include <asm/arch/sys_proto.h>
+
+int board_init(void)
+{
+	/* Power on mcores when using rpmsg cfg */
+	power_on_mcore("mx95evkrpmsg");
+
+	return 0;
+}
 
 int board_late_init(void)
 {
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 743778d9554..7c429fe0bfe 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -37,7 +37,7 @@ CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
index c17f3663eba..184dcc1e04b 100644
--- a/include/scmi_nxp_protocols.h
+++ b/include/scmi_nxp_protocols.h
@@ -18,6 +18,7 @@
 #define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
 
 #define SCMI_IMX_MISC_RESET_REASON	0xA
+#define SCMI_IMX_MISC_CFG_INFO		0xC
 
 struct scmi_imx_misc_reset_reason_in {
 #define MISC_REASON_FLAG_SYSTEM		BIT(0)
@@ -119,4 +120,14 @@ static inline int scmi_imx_cpu_start(struct udevice *dev, u32 cpuid, bool start)
 	return -EOPNOTSUPP;
 }
 #endif
+
+struct scmi_imx_misc_cfg_info_out {
+	s32 status;
+	/* Mode selector value */
+	u32 msel;
+#define MISC_MAX_CFGNAME	16
+	/* Config (cfg) file basename */
+	char cfgname[MISC_MAX_CFGNAME];
+};
+
 #endif
-- 
2.34.1

