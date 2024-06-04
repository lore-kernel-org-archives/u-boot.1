Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C44C27C50
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B712488414;
	Tue,  4 Jun 2024 16:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="QZt6pdWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C6388418; Tue,  4 Jun 2024 16:27:58 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D189F8850B
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Uld4eiTKmPyVHhsUHb/3KtArk93BrCYwR4vtEi485g7LirWDkb1BEPzFzy/9KLBfwUx7g9yIF/xB5BMNPoWEo+kghrShvrtId3tXRKCY7KSrJ+DENS8eR0B6DQnugvTAR0M2ZlLe/UZO3pTUIafXPE9cWCYTAsmS4rZKBo6jyGIDp22zy8xqTNcVuNT1kjPL1HtJNK1aQ0dIMfSrBnkTQRod3UvAUDzj7o7GoCvV0er7a8AT5FOUyOcb/UOCZvNb9tAKaGlLgBw35IxaGksHhV7Y7joZBHdObnb+6ntFWCbl2enMVqDIP2nmoIG4JysS8thQfx1JfLEvQzUoEPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPQHx31A2FGPQAXcdH9FGT4ImsHmQ1XkaGVoUYlFiXw=;
 b=D3P81QUeuFdGwPsf24CFLK99bZqVwlBsBP7iNvCI3s32IqthlcSXDIYhfQNP62vopy+NwenrZGUm8jzm4XXIue41bsaPNsTtl+EO4JWCcv8lZW3qhwXgcPDNmxpWA0F6Rm/df2ruCoLBbdLUUNI2bez/Algo2aPWCLvD6S1pZu0CbuNRnSsc+hCPO72new58wkhTm55kBVm+GKXKCt8CAWi5AsRGSu8ikyuUn4hJiZwT9uNc1oBUpPPlCdaoA1FHWfBI5lnmuXcIvsubaDGHkO/w4jpIEeGzzPcqARdGcfftDm76E9l9OdcBbBShavTA2bLElwB+ySZVhV76dQfqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPQHx31A2FGPQAXcdH9FGT4ImsHmQ1XkaGVoUYlFiXw=;
 b=QZt6pdWUPMcENN9zahLzugnBZmf2g1MpHEbE5E6eT3WUfWaZ+y8/MsQSgKBoNE54D6PkLlxI7w+ZBDC1EzV3eHN5mGYUKdIhrtt1YU6n708KekklXze2Fo+UzTeXmPei4imEiNZrUb37SR4x+/M2Bc9Cs+OX5BM5MZG/UOQjLYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:54 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:54 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 6/7] firmware: zynqmp: Add support to access efuses
Date: Tue,  4 Jun 2024 16:27:40 +0200
Message-Id: <20240604142741.425307-7-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b93b01-7d33-4b6d-b891-08dc84a284d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ONXMlKFC/Pg+BBqpzevXE1Tao1FSvXmXDBqM1AabH/o8mt+i9967i0RP5Une?=
 =?us-ascii?Q?G8vh9/vccCbR7bvkY68iDVbHGfV5MzuztcKY0Df4tQPjnrRhR2aOlUW3ZrBm?=
 =?us-ascii?Q?DlKuTHjo1wtR3J2qsKm4XAtRTUGK3VwG8InFoNJRug0kvijTkHRRYRblPUAH?=
 =?us-ascii?Q?RAr3DnLvVJQBMK857DFfDtlJ3CQ7uVlYjGOb8Ky8S/9qJ4SAjybUi5opo8KP?=
 =?us-ascii?Q?9kpdjA6ESBqeNDyq5OfjiTuq613fN9mJsjPWdeSSLnqPtglZK978Ol8GSJi1?=
 =?us-ascii?Q?3UOQg7vzg7Prv6dCtFPKppoLEQwVIru2AYcU6qXio9sbOzWm6KiefuWcoaXh?=
 =?us-ascii?Q?5mOqwtPJYYkN9ELLRDXUzast0InfAmH0bc1X52xYJD5DS7EXDB4v0Cy9nNlM?=
 =?us-ascii?Q?lDBoYBoqPZ7XmvrNgBRa7zIQZ7Yq/qxmhUMXLHM8aOZ0eq921JgGLwOS65eB?=
 =?us-ascii?Q?PwT3yNtOJVnb61bv3hmdDM5NfsFYhUwntmgeBMvvAWQAOaPhz+8ZNBj7W+IZ?=
 =?us-ascii?Q?s3xwd5xwJ65BUE/Bs8BOLdCX53vCQjpG3QbL+jIpaDSml9yV+N0cVwIscmjj?=
 =?us-ascii?Q?RGVx5x7HXNbHOJWFHCOK4rVPUsTpWj3bTS4738C0Uh0bgeyiecpRkN9u4ura?=
 =?us-ascii?Q?eqgYzUUzMBQD6WnMirNk58BJuFUZWwGDs/M/tJLsA965QOMVPlGhg0EnPFmQ?=
 =?us-ascii?Q?uE5ZO+MwcP7/TSHYvGyBw8g4XebmODOXZWjHRq7crdcnhTruMY85kwDm5DMS?=
 =?us-ascii?Q?LREF8eKR10hBRG19xODN6b1IpCHc8CFka4ZFDXZE4+ZwQkWT0ObqWnTaYdt2?=
 =?us-ascii?Q?dy2HgrFdBWOy8bnnDKd46HmDbwyWS7pQHR16mIzAIRCklvsV3OC7DsGschI0?=
 =?us-ascii?Q?iedAKwkbqZuUIbr41d5Zl/Xq0FAHc8aVr3Amh5K4wCW4GW398V2R+rM/H4+I?=
 =?us-ascii?Q?woplIsjWV2IbIFonINFUuLIxch7MNvC1MMXHxglYFLoXmn8FUli1VkH2uSYz?=
 =?us-ascii?Q?R+BBJuCZ7QjTurdWDRofVZpnx9eChLHuSE0RenZbT3KL3+u+7XQR35AAfRSq?=
 =?us-ascii?Q?mG5Sy2MIFdmXQgd30ojQsWjy1S2wCtj4D/GQocFsANv/o5Y2plc9D6fEGEo/?=
 =?us-ascii?Q?JkGgiPsb/5NoqGmzhKGFeeWWKVnKjyqaic3dPLAuTOBqU+sAtwniPQlS3H67?=
 =?us-ascii?Q?hmTuZYsy/kjoSqWeZcyOHk1+PSRIGkmeRcwjghadS9rhLTrTbUSq3SwvmwUF?=
 =?us-ascii?Q?r4eG9/huUH3XoNfhmYhC82rivbYmPB2rzttuNBB0RJ9JJiXSjcK1EpFQWCrN?=
 =?us-ascii?Q?NcEItienOjbe9onzW0F5++70h9k/PKvx8A34EwQRmYddikWDc1KTXyXyEXbB?=
 =?us-ascii?Q?wMOOJ5Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nc0hnXuK85aGH5d8SlCL60M4WYjXZTvpl2JE9eOUr3Pdrhlj2Nr3SotEhM89?=
 =?us-ascii?Q?jlny8FU/h3O/25kKK35ZDfWFgmj0ksB5vm63VKrxbFu9Ol+CmD1mpvpu+DMy?=
 =?us-ascii?Q?BylFiyIRWFfI4IdFc9eV19M6ssRcUcrSLFkclO0GFtufBjPAoCk8Joj5NWLv?=
 =?us-ascii?Q?sQIw9Dt8e3XTN1lg5TQvONEd/l5F3Joi8kHn4iJrcam7lAcdRn4mGrlCSet/?=
 =?us-ascii?Q?6y/18c7YGvI4UJkGeUBEnJR7ya2QX1mQ4b3FDTluCkTmbnuSyes2rqprKz/U?=
 =?us-ascii?Q?gsHVQAjHnbtpIJ9mmsXx98Wm4jSy4fXdSCNEuv4N1xVrknNSMP/n5RSUIyER?=
 =?us-ascii?Q?hFEjubRHMRMsm3/Wi2UgO12Y2cdZjlI9FEKGBxVumpOSSj1PPqCOl90o/wLD?=
 =?us-ascii?Q?LxlkMJBzZsBcPpviAgksPoTW8glRIq8dVgujCl2GlN+TCn4MN4kPmgvl92td?=
 =?us-ascii?Q?V+zJB5t6hGaw43wqR0ZpkXIOrAVgiKL/jHcgPbzHoOhc7t3288Q0phfBRkWY?=
 =?us-ascii?Q?IIVBI641jnLT1bkft2UbZHj3mc2xbzIFRyiKMNFHUzdVH7bMzE572PmSK7OX?=
 =?us-ascii?Q?mmxB6csgG3Bjt4xYQ/8t7z230EBbrqmM2GUxTe1BgPP4bQo8sy6rxD9xD2To?=
 =?us-ascii?Q?zP2j0+5shTw7dHWNQpOwmFwopgat7Rdrncc+w0oGgNGlHY6mJqLrvQzJ2LVc?=
 =?us-ascii?Q?jxnr0KL5KMVYO6B3iEJq83PYQx7Ch2CDUh2WzcI9/Bf+oSgIw/NIg1X7X4jR?=
 =?us-ascii?Q?F4dvvYDXToZl57mIcuJBwhGkEVeSr19xeKvj1EscOGRGn4nXeJqTLFLRREdG?=
 =?us-ascii?Q?swZZ0s2Mq8w5DinzODOgBUTVq7GduloL3qAVQednEvLwpmSLLOAVCYZl1540?=
 =?us-ascii?Q?WWkWmfL6HYVI9+ACDCUyCVNqE8P3hSfu2AexbjXvOM+l0Gsl8K5LDbmuGmNh?=
 =?us-ascii?Q?+hYOPhEQSwMWvFnkimP0Fx0rE3O/xXOfjdxu8d52fi7rzUJjnWRYKftYTUvV?=
 =?us-ascii?Q?6RPQaaEX+pZnKKCG0wwEhAzYsIqzRm8T6Ca1eQNVGofr9pECBTsceAS6jmt2?=
 =?us-ascii?Q?mKZXpp6UHzJH+gfgeOPfrjGvHsnfWiS1pgvrdHIONyzac2KRL08vP8Ok7WSH?=
 =?us-ascii?Q?ezd/Svasl2pCYFixiv10whsez01oThu7FuA05iumo1AFBwwP1l6YEsGgVgPD?=
 =?us-ascii?Q?hb5ezpF5Z2+1dQJKu92eTcJYZcQ2JXKm/DR/t55eLcYxq/x7jI8sBM7kgokc?=
 =?us-ascii?Q?j7sd5o2GA7WOA0qf/T/4ho2n+MMPMu0hSm0cmOvOMRJrfCEhwx/GsBEvdTVw?=
 =?us-ascii?Q?XJ2Wf8dzbEjImTRJ1veDmsoHw3grQqP4f/WhGOGOOwJMhnnsbhhaFic/C9Tl?=
 =?us-ascii?Q?OScxOjy/DD1Po5XYFCDN1qQlZq/NNaCXo8XNlElkp23OmSZWUz/o4gUyVNiF?=
 =?us-ascii?Q?/Vj8SMzD+A/jftyGwUZ11AslOtgevnfEHc+CjzPxb/D07RmYJKxHzJyRi1cu?=
 =?us-ascii?Q?BVg4+McIgvUYO3jUuPb6YYY9ALjiDqQZUUp9mf3fp3Seax4BV7+WvkX+lOFF?=
 =?us-ascii?Q?uF/orbHqo0eGHX+7/8G5EWFqUGWJw7AfYSyc7gJH65FquFCFy2BJS/t2U1JB?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b93b01-7d33-4b6d-b891-08dc84a284d2
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:52.8760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkuBsRyepkoNBYSZFHCHRDI+jYC8hc7w9R157mpxqDDl53vG3aqDn3QcuiFQLvwraQOOoXxGd+WEPx1KhjZqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add functions to access efuses through PMU firmware
interface.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 drivers/firmware/firmware-zynqmp.c | 31 ++++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index dfad798a2e7..8e9687693dd 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -211,6 +211,37 @@ int zynqmp_pm_feature(const u32 api_id)
 	return ret_payload[1] & FIRMWARE_VERSION_MASK;
 }
 
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
+int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!out)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_EFUSE_ACCESS, upper_32_bits(address),
+				lower_32_bits(address), 0, 0, ret_payload);
+
+	*out = ret_payload[1];
+
+	return ret;
+}
+
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 {
 	int ret;
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 73198a6a6ea..7f18b4d59bf 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -453,6 +453,8 @@ int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
-- 
2.30.2

