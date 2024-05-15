Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EC6C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05241882DC;
	Wed, 15 May 2024 14:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="oTiu/CBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8415388307; Wed, 15 May 2024 14:41:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8D08826C
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mci8SwG4CtMakU2fICYkwz0rCEksDDCef9nI65oMJz405ZyBpVrCXvCOPYv4wY70wgkCI4VKbgN6IxpHg0+Qg9YmOFQrcX8eDPfj0hT9z3TJ8Kx/6vXQ4AkS0Y2vEfZwDWz/pAH0dNkbIcGn9CmvviODYDoOaMUUPpSx1yoSzhUWiA0AJPxPX4pfbbU+ngnxzbICws7nxfbcS/VEWCPU85Ga/QLS2xgZgRiG7uOju/uZajplI4BjwUSbU4bxSWXMAqZtSA52KfHFSis9tr2iomOkjbjzvfBVAqCzByytEByz5zgKxfVUA4ASGtk3Yly1KVPccZU4rF+r3ClZrJ9HQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTzcsOYoBGvRaz+wA7mTsXi6TVK1aNWDmpA8CbiVrgI=;
 b=BvfOf9CseCBWTwDT1JIjllgAr164rRG55cdz1FBE/SCyIS5O2GQSbE2GhkJFB2uNcfuTN0hQnunTf4adaNZ3p2Rd8skGtMwDLWF1cLSJqugv79z3VG3+Vv3/IbgdO007wmGWvwr3ouPo9vgu8aUmJE3oxMdx/aL39r0ovqtsp0RUuGJbMTrpD2/YZslQmh7REETSsvOb6hb5v9+MTE98PMOGBTbZ3a53D25xOjzOx04yoBe5p+gBfTFGhgKd0PqGC/eDVZhKd9qvv7zgYFM7exosc0t5z5v4gyVBkmENX2itthmlP21D/ujSy+RB+LwMRYuHbm0XMfHje5E7LIhYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTzcsOYoBGvRaz+wA7mTsXi6TVK1aNWDmpA8CbiVrgI=;
 b=oTiu/CBTZIuIwAH4Af5KPyBR4NaHKUk7ORgzygSuF5rohhzhEfv5uZRrSH1j3g7ixVbjTaHkqCKYXYUCx1q1Ng0MHxXe4anCzg/vcXWoD/+albEQD2K2dYJEgbNlaWcwGhmC0BruBhWmz71pXUeklf7rWtZpOq2mMVNJ4eEJLqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB8900.eurprd08.prod.outlook.com (2603:10a6:20b:5b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 12:41:36 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 12:41:36 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 1/2] firmware: zynqmp: Add support to access efuses
Date: Wed, 15 May 2024 14:41:24 +0200
Message-Id: <20240515124125.732487-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: eddee932-4b32-48d6-8487-08dc74dc5bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRkgDKEdQ6UEuMDVfbpPRpIjsxvWihPijhzFxzW32yMdsYIf79aQbw1GM1wl?=
 =?us-ascii?Q?OwoqzFfqguQ30hAjTW4JG0z6+eEwYKmJEj4n/w+bw6PxpF6p6vSPQ5fFyGhT?=
 =?us-ascii?Q?GtEBtUcSSdi+qfLDNA0eZe4RMU/F5E7qrFUYdhMdq/8hqJbRS3lU2H2rjuG2?=
 =?us-ascii?Q?CHwF9aHFqw0R0QV5+ut9Rqpp6sKDoR4UxbR0Jmqu+LV0uMvJjp58iZMCvff9?=
 =?us-ascii?Q?0SQXwud2KOc6GMVhW2HaMN3rYZUNZGAUVLfImotWBq+WMPx67IGR9s1tFDGN?=
 =?us-ascii?Q?Ai2O6RpeMtj+7VdSDJxeNLTKwSUjh/G/309wAV2zdcgkl0wAhlt93CPqSg5E?=
 =?us-ascii?Q?H7tYlJJ/75yOiJtmx5HxCzIwlHPoGDYO9m/pR9Sl6CgBTIAYmNTAksz9ZXJI?=
 =?us-ascii?Q?6yAzvJAs5QTMRkXUQaQUfBLGbGyqx4A1v1LwfoBD3PYncNHsRWWYarEqY+3D?=
 =?us-ascii?Q?RBFiOMMyw7V6VhXUb/79ZMG0Nto2RlwtsJ4pk3VZIwZas9ACWKgQ347SOclZ?=
 =?us-ascii?Q?osNvbpn1rTjby3PRgP+cnVqxFwuJvtrjGrcst+8b46gwVC1dHt2rPb+GwMRV?=
 =?us-ascii?Q?6LLCrE6dqNiPcqMPyQO62rAvYSwUbF6fsHAxAWovf+al8UHUsv3Jrqd4P9NY?=
 =?us-ascii?Q?0SzmmDBW5xe85f9pBACVuxH7gAYYFssDuKynfEE4COKbbvjmXIFWYi0sx3AC?=
 =?us-ascii?Q?eebsuziX0JT3paRqsn3UexUiLIheb3jlmDgfnmZKe0paHd4RCdwlO+G7i9GX?=
 =?us-ascii?Q?iY0UWMrMT93ziRYLOcmJ3BX7BZJvusS7P56Y6O5mWlXOtm62IqpTMhCDmO6r?=
 =?us-ascii?Q?JH/3Y8fOPwhPDtsSNCA2+BdPZ07YI4SzaWveP9B+9XUoNMfMLduLuZHwJ4If?=
 =?us-ascii?Q?g9z8tkBN4ZgRcqgSKFLuEYAi2voH40LSuyqYnN+niJSRCznlxMXlxzyacViO?=
 =?us-ascii?Q?wHx3TItiDI+4B/Itpn0kKHXMfDNF8YQVie17ZD2FS7VM/U7oNzWOqyNa9wvl?=
 =?us-ascii?Q?s1/u2MZQJCXmgHbboQdbwQsyE5pBsxNVUI5efDuDDUbRMlwUajzxFsNXl4ce?=
 =?us-ascii?Q?YbCnCBDkHxFZsWkEHWBl+FgaxP/HC+NlxBkGYf2PbC76mI/reFJOnhThdA/+?=
 =?us-ascii?Q?s8ayPk/iKUFyf9GsS6LeFvJfrPHJX+XtswdfkavI8KqMEfeI4E5/0zYjuBSE?=
 =?us-ascii?Q?EE3ppTHB1nulCa0LjTPJ8++3c5WWfgN3KIZ8WXH8WtksREr60B0nGo5/Kwzz?=
 =?us-ascii?Q?yQbLGQw7nGjjGm24gk4u8tefHCfxrQl30xrfdFVaWMNu4DiYS/savNv/ZrHK?=
 =?us-ascii?Q?lwdgtumJnmhRkEWo5hdVoJwG8QvsQ090bivB7GzY0gchcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3UOJlfyXcfNkcGIwYXXYMsVtcoqGOwx7duU9yRrTSogs5xJ+NJKu2CbcKY7F?=
 =?us-ascii?Q?TjkAGtQRHSAZJZQiXev3EA6L5DPA2PVvXT5Ch3jSk4TerBCzniDVFHBnlYfd?=
 =?us-ascii?Q?0HyZ8HVExMdSM59DCA4CGtIZSCZy+DQXUu+S7Z0MHdLA7HXGN0SD5kE/s5u8?=
 =?us-ascii?Q?dD7JL4yb5o0aYXjAjSfdTs6c7xq/KAu8HNC0HkuZ8ccA+A3sC11dBRdOApZU?=
 =?us-ascii?Q?iHp/uHREHEu2JMNXB4p53nZIp5VyH3bzehntY2ZAKYQiWP5mSqepp9Kf9m2o?=
 =?us-ascii?Q?1iDgd0Q1ICJZDhnc7wXbfFlVmcK6+e4OWGnn35pBuaHuiax2bylf0c/nAtb6?=
 =?us-ascii?Q?7FTAzUHZ3wlGsbmvtHJRcdGyfk1D2hHX8yCEX3Q/ddiNxOwxWpegQ7+LWpwC?=
 =?us-ascii?Q?cz2bZGeV7Z4gVq7w547OvGJRwD66hc5jPC8MR+1xA/EUIjPGVAAVgEvn3+zF?=
 =?us-ascii?Q?rfe3ZHeFHuaDfCourkl8CCNuZQjpgwKinSKTePaQX1CFm5T0xy4onwvj3hcX?=
 =?us-ascii?Q?CPtmXGz0Xe2c/rJQZd4G3Rg+Gh+0zCTakoa46iWEuEZgZubwLBSBtJT2JmWt?=
 =?us-ascii?Q?oHKVD91NzCz7gR3Kxa9sF5PV9mNv8lP64vLut/wMWGoIjpS50CRuFxxAuljh?=
 =?us-ascii?Q?cuis8pavBltU81cMyTw7tcQx2HPtrU0M20mqQybiXBacccJ+HEio68igYpSe?=
 =?us-ascii?Q?IoDruP3Iw98e/nXPIElKBK+Nu5nqfCVY1Cr9Rqq91Gl7EeMAqBZb/ppSidnW?=
 =?us-ascii?Q?vJidBV1PpeOhlMnBUKQbIwfWp9i9IOV0I7knUdpN2HOh6cbQtrAD+5EvTXGr?=
 =?us-ascii?Q?bHKvvw4txoyaGZlY5PO9LXjgIk4c8NMx44O4Mo2UvVaCgJwFXoWK4+ZcaHs0?=
 =?us-ascii?Q?fjZIhkhGmjkSyMNsuwRz4b4ZsPPpoPQd9x9J8BBtZnkUl0Qx5tVUQw2wYsGO?=
 =?us-ascii?Q?TpV5HEUUoUlWx6hNy1f92AsIV6UgSW5vE6iqLTsZ975LhJs9ZvSXeV2NPHMY?=
 =?us-ascii?Q?mS4E0V4O+6RDbG6CCg5Ve3E58w+CJH0eikyrPaooaiUSJC+P6C8Zni43eVvC?=
 =?us-ascii?Q?eYpivW+uAtuE4CkoS0S+1XZrbwO/6uzF+skcyP0x0lAezTs115yw8cLe/cvl?=
 =?us-ascii?Q?v3FlCyVfesp3arsLWum1WKFwKcHqTA6vmnt3ek+GR758oEINRtxh/2U3Ygeo?=
 =?us-ascii?Q?DBRUqTREUPbFHQ+VaYBUp+6QNvJSGzyOtbSUSVl1VfmO6Rx306TPnvif+VDp?=
 =?us-ascii?Q?YCjjEZBJ5sQIz5leBnN/fsZWlVVov67Eip0ZQra9h5902fvG53ePNprZ6kel?=
 =?us-ascii?Q?LOFjURpaNTqEBOJtiQc83FR7N8uRAIiHLATOidrRsautqf5d0f0OQ1VT4f5I?=
 =?us-ascii?Q?PQGtMcmkuMzun6k2k66hVYgBkVEScblUOwD8fEgnUO3CZepSDc+7WEo+kscb?=
 =?us-ascii?Q?4oG+TPaybQr2qmuYurE3VHZ1HO4s8XA3doUXKpBccgiYNLsKZoX9tZlqQOL4?=
 =?us-ascii?Q?QQf0NWHLrGkb7ZtE0IKCtC79AldmFgeC+L7Cmjn+O1pBTm/RlhtDR9NKGVUb?=
 =?us-ascii?Q?rNP/hFexgkVWS9kqWFTU453z33N6NDryBJUyknJz2zxccmvCcEZ6JITvgetr?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddee932-4b32-48d6-8487-08dc74dc5bf4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:41:36.5510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE8sSRPWU5BZHa88Mn8Od5pOmL9Ou3vWMWm840cr1Pks25nshAXRx7aiUB1syERo43b2E9ERceAiXsYG/l3IBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8900
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
index f99507d86c6..d7fbe6a3efb 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -210,6 +210,37 @@ int zynqmp_pm_feature(const u32 api_id)
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

