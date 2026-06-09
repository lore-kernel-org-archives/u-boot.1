Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E52CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3901848D7;
	Tue,  9 Jun 2026 09:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J3bWsqUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8742F8490B; Tue,  9 Jun 2026 09:19:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F36D848DF
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhb7vSzKhefvF1IXe/VQf5s5UuAOnTni6Qd8S1tLZH6dluCxp6eV8vH7xvNDwbTYrnEhFn2og9j0mHEyZ/VhRCjsi3xh9ee379aKgocROy/BnDj4sNYQ8p86i7gnGrjuB8B0rpNDishh1rYE4Ztr/gD42PqfLPDO+d9C/3O/BX/N7V0VBdwa5TZl0etsMs+y9lwLPWqoi1RrfXL4B4ALO03P/3K9qdPWfrNJkvhF3t8+yQUMmlWMvOa1I4wMRVOEvX8KRQNXfnUkNWCIzHAK/jLTzz7ZPzg1tbINwgjCWTY2izO7cYCxRf0Hs2HAVLysVRc17LI+MbAl0lezZG6h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYjTlUop3SC4n4hhaJztOncp18PzN/xHSvH/YwadfzY=;
 b=B3xjvYm7xvHbgXZPbgTP7FEl20IZR3YFL/IU2zkCD4wwZGo0fwNz2XB/Z+KtfTG9d1PY/NKFR2RWkQuowNMfGNDdxqxJyVffU89aTc98PbYGXH0jc6dtaFm2IjiBMREVY/B76D6EEAXu9A5BgiCndUTdAx4Ucd6M6ghii4PscVY3Mvp9RoLzpQa4JrZCvUMaQN3KQq+vGFebRfLemOTGL0sOlLgP2Sb1PKORaApzv4XeGTw8jduuBVp1dzzrWAOCE6Nv8kRCawHg/KXV87O64RO2/T5n+yF/S/ibp4LFjPUW6kwwDxZEZsEGq7YHZb57g/9AmvEsYGHNNUp6mZAmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYjTlUop3SC4n4hhaJztOncp18PzN/xHSvH/YwadfzY=;
 b=J3bWsqUX+s8NDqOz3GfLhyYpqNxhaSr/ccC3EwArMlyMZ1VXil+E3LknNpRLRXWbdswGcXHMv8f6C6PEpgKQefCuljKGFb8XyXcc423KFEsQdZ+C4wdpVyl7XyD1w8K0PhzmFclhLY+iv573WT0tiNjvymDovUV1uLPsGQLwOUo3CoBLv0ENG9GSw72WY4WCiqOQhTMX7xav+QFwPt2HtrJ3/y0i2pXd8sWl7g3eA6WAMonlAFFchiqP31gxuHFAi+2xl3mRqxy+t2v6BYXarYm9YdyuBdrAfEmi3oHAzXfWQZw78R5ahqFzRQ5i87hl6vPwBzi2zP9OvHqRRDWuoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 9 Jun
 2026 07:19:35 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:28 +0800
Subject: [PATCH v2 11/13] imx9: soc: Use livetree API for fdt access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-11-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b34c180-b717-4e43-ba69-08dec5f775b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|1800799024|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Sn7aLRSf1/J7TOt9w9RIlP4AIbHp39i1EZOEicb3PN6NKxDmYppj8rUfAycOUfDxlc7VJKRTznUx4jPItN2T6OG8MaRZaLcZUrN+I04k2hzVl4zVhRwTqnjP3Ga2NYZ1zG3O6q0rMgY0afpR2HRHUAMMJAnPXSqUoVh19VwRM1NBttxawOs7RtFDklzVfWrmDUDCAFQ6cb2KK+3ruh/huikU7dCQ7fodjTsBrkY77mfsi12ypqPdtftEBeB7/YJOkqgEbDvQK9h6NJidkwffzdBF9PT8D25VGToIT2gzEzL6WyfSiQJvpD1EZHqjY7fDTOE9Ffq6nDqpLU9dgTU6YzOhrENCyyTTf/vOFq3Ya/j3v5mCmeeiZIuMN+hCcu+pTW/MCv37pJauJo1OZdHRUn7EQEQNkmwa3EVCFqpNleY2GcqDZkYNREGw+3IVAn8wq3jeWRGOjzG9vNiYHHffCozY0SS7LpWQYJvfkJhMlbnZjGZWJJRk3tTdadPYqdwfLxB8fUUKoa8xc+txJLRDwP19jbSCUFyuWxi6Y93uzd1DczSNMBjo2YP5vimbFxV9+BmN+9U6vuoo5AhCItYcjsZWjCDth/Nyq9xw4V8sKixzZg7mDf1fHC69nBRktkBAEXiyrwwqLVBrFzC99/q/GWNgwmZuk0ZVcaiwCMth1kRQyrCyoDO7TPtiybGVRjAEv34mI0qtQwdCamM6yCMyiI7/2mxpMZaobrgepaZqVHCwv1WoPqJ3ZgAdVeczsx9X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVJcDVUd1J3UjhjWG5JeE9aMERPdmZpT2x1d2lLcEJ3dkZrazc0Ums2a3Fr?=
 =?utf-8?B?c2dUcEhxN2xmU2U1a21SbnZ1RCtIZ3pOZEgyQklkZ21XVFBXbjE4ZGw4UzJ0?=
 =?utf-8?B?ZktGSUxwOHNTMGtTODBkdGd5ZUVLbmw0eDNKc2ZoQWs0YjlyeSt0VmhPZ1h6?=
 =?utf-8?B?ZzJlbDA2UU9uUjloUWVPM21ScWhJS0pERDdQWWQ3ZjcxcUp4R2wrWVREb1dW?=
 =?utf-8?B?SHQ3NVFrYkM2MHljSi92RmgzRDhodFdSSGJwblI2Mm5BT0RwK0V2TVBONEwz?=
 =?utf-8?B?QTlLSEhXbG5ORFdxZUVWdjR1T201azM3MS9QSzJoZkF0eEZUalVFbEdnVSts?=
 =?utf-8?B?L3RPU29JRFRIaVJJWnZmbllnallKREdlNFcwTDZXNFJUdTN4NTNpUDFVRmM3?=
 =?utf-8?B?VUg5SzJmL1dCSy9FOFNSTHNKY01vYnlqQy81UXBCSm1jQlNCYVRpaHVFaSt0?=
 =?utf-8?B?Y28rczVTcVpNT3ZZa05ha2Z2TENHWmtKeGRoRmJiamsvR1h2eGZRMTh0aWpl?=
 =?utf-8?B?MnVRcXh5VWRBK0ZQL0NXU29DN2F3a2JUUkpOQ1hvK0ZxSmE5clR5MG10Nlh3?=
 =?utf-8?B?cTVOVlFCMmhibHNYS0xQV2kwZXNQWU1vMjREU3VISGI2S1V1ZGY1dnQxK1Er?=
 =?utf-8?B?enN4c3lYMkhGL0dkRlZOa1BXNFVRbXFtT1lnZ0x3T1lDYytyaVo5OFNmbXFW?=
 =?utf-8?B?ZENCQTJBT280TXJnWVRKeFdWSnBxL2xSTWJQSDNVcms5RGtIUE40WTloYVd0?=
 =?utf-8?B?d29XSFlNT0g4QStIaGlEeWtjdHpIQzBSMjNMU0ZsbGI0VlpjV01NRHB0dDVX?=
 =?utf-8?B?QjdGVFRzZC9zUmU0blJnYXdQY3ZDS2RqUm5MVGcwL1lVV01uMTNOU3o5aTdt?=
 =?utf-8?B?SFZ2ZmFZMGFLYVdBWGRKOEVKUTZ5TmtuY0pSUVhWUHBPMXI4ZHJwTzR4cVlF?=
 =?utf-8?B?OUFISHExSXhKeWkvSnhEY2NhUVRGZGFiak1kSko1RFNDK3BhQ2k5VHRjR0lt?=
 =?utf-8?B?aFBvUjN6dTg4eDBEWERYMzRaWFk4ZWFIdHdXYnZ3ejlDcUVqN2NqOEI1Wk1L?=
 =?utf-8?B?Qk8rZVBDTDdRdHg1MFFMVVZVTlBlV2MvbE5ZTXQxMmtnSm5wZStsVitPOE5q?=
 =?utf-8?B?cXdsT2NtZy9KNHp4aFdVN0tMSk9wMFhJWEh0RFhNdVVFRzF5ay9KT01hMFdJ?=
 =?utf-8?B?WFN0UmRvMFQ0cG9YekkxS01kcm1Nb1dxVXNKNHBEb2ZuR3J1UDlING84cHY1?=
 =?utf-8?B?dDV2M3FjWitpWlpNUldvRVUyVy9kT2JmbFlRTVB0eE5GcFFLRE9FOE5KWDQ4?=
 =?utf-8?B?bGFadUlvZkhIODhTOE1xUzAvSUxxVDFKbURLWDFrWEthM1FXTGYyeWNSWlB6?=
 =?utf-8?B?cnJ6NTJJQ1MybStkNEJwN2tGblloK0pRVHRqWmZOK0Zob0JoTHp6ZVE5SjBW?=
 =?utf-8?B?eDNqL0IvRUJjU3ZVZUMrdi9XVGt0b1lZcm1vNGRwU0tqNUFWbldsNklhMjFV?=
 =?utf-8?B?WGRFMGZ2VWZVRFB4SUpIUW9ZYWd4UUI5VTJzQ0hnRjlmcHp0YWZYTmRtNGtB?=
 =?utf-8?B?aXQ3NFJuNERvUUZ5M1FWc0FhUTMwM1lUZmFaeXlHY1BkUWtmZWs3SWtDUzhv?=
 =?utf-8?B?ZU1Cd0lJR2tycHgxQ3V6RHpFSnp3WldnUldSbzhCVU1zaTMyLzFZU2RTM01Y?=
 =?utf-8?B?Qk84WUxndzUrZ3BYeExKR2VPTlp3Z2MwcDZQZ3gzU2NYU1lzeFlDL3l4cEVy?=
 =?utf-8?B?SUt6QUVOemNFbTlqVEEyRzNOR0Rpdml3VnBZOW1rNWNuMVRXempCVTVWdFR0?=
 =?utf-8?B?Y3JEQTNxbTJ1cjZDVndxUUwwSG1PRVNUa25zdllLWDdHdTU1VVkybm9uNDM4?=
 =?utf-8?B?bWlzY1NZYTR5Vi82MzhMMG9EeUxNNU0xTmMxVUR6V2pKdHdYS2EydVhrY2pU?=
 =?utf-8?B?b2FIMFd6a3d1Wm9kTk00K3ZTeXZFUlBveGErRUw4SW53cHZCeVJEOW5HclBQ?=
 =?utf-8?B?NHNrZFhSMXZLbGRlblRRTDMvUnpVQjhXeFlyOUxndXF3VllXMW5WVEJrcjdo?=
 =?utf-8?B?TjRqVWtQQkU4ZWNyZElLdGZpdUNFaXV5S005Tm43WFVJYytZcGNsUnAyQVVS?=
 =?utf-8?B?TmpMYXgybkdTdmVzMHJHaDczL01GV1A3ZzNMdGtxTnlJTklDbG8yTWl5bjFz?=
 =?utf-8?B?blZCMXpPRjZFREhHTkxFZW1Qdy95Q0I0M3E0akw3RGhvVHJob0dNaCtaMFRG?=
 =?utf-8?B?aDZEcTVwRkNmOE91NGZ6bjhzSVdWWkRRbTRNSllOYmR2cG9CeE1LamhzSnFx?=
 =?utf-8?B?Zjh3T0RXbnY1c003OHVxT2h4YTdsaklkM2Z1d2lyVmJCTmplUWk5QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b34c180-b717-4e43-ba69-08dec5f775b4
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:35.6218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn85gQtiGgNi5qLSdrafvWtRpjZ9ZALhnfb5jA23EAZhcK/VgF7TjWX/2rcmeNSPKcN1vlHv5IR3YppsZ4yFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755
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

Use livetree API, otherwise it will fail to read properties from the device
tree when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 6576ecefd5f..ad74f89a5d9 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -21,6 +21,7 @@
 #include <asm/armv8/mmu.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <dm/ofnode.h>
 #include <dm/uclass.h>
 #include <env.h>
 #include <env_internal.h>
@@ -738,13 +739,16 @@ int arch_cpu_init(void)
 int imx9_probe_mu(void)
 {
 	struct udevice *devp;
-	int node, ret;
+	ofnode node;
+	int ret;
 	u32 res;
 	struct ele_get_info_data info;
 
-	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "fsl,imx93-mu-s4");
+	node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-mu-s4");
+	if (!ofnode_valid(node))
+		return -ENODEV;
 
-	ret = uclass_get_device_by_of_offset(UCLASS_MISC, node, &devp);
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &devp);
 	if (ret)
 		return ret;
 

-- 
2.51.0

