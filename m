Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337EA103E2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 02:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85C83FF9;
	Thu, 12 Mar 2026 03:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i70ugmlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A32984056; Thu, 12 Mar 2026 03:17:42 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7760583F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 03:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUZEf/mAejALdmHIy155E3yIJRha1lPlYydricjSsTSjubqvt49Wpqs5EAfS4c2txA8PSEs7yYwkSUTXcKprikAK8fms5wbZuv1p20qJnP0/ksgcdRIJWTYr+zy0i9qDXv4HTfblFbWNImjiSuuc9gzh+ayZeQhD3dcIb2FNaeVCv4MJt8Ok+Wd+Sr+wTceD1rA07fDXnvxlmeMEhzRfRRy6OJjDGLtw/w/OdvsR5vw03yBU+XsiP6QXBHkkChTlQC/dQyCrBnqAJsBS0jpfvlrs7k/HuRhZZozoQNR9bpplROf6jX0lDecwZ0qQUHwKWIlqCH+bUfC93WGFT+ev7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3c+6Gfe0QqAJmbUJEhTff/vOjrW0IUNh0yXtb5QZfA=;
 b=atfNgdaWyE1fzHfg0SEOnfoYX4rx4/294Bk26Xt1VhQY9QlhcnhpZI7m8gorvKAXYr345JRNK/t956s2z0H4qJZ7tRtNOHn9gYiEo4q66mn/DorXJHVNHKR9fF7BOKe+k/6+TwYWRtG0W7XSXWsD4vTXBeQshCqXcERR/WI+rgKK4eqAld89iN1Qwdh+yqtdxZtxb2Mmd/eum9gRDoehDvyy9w88slzML4Eyyr9yEHsdjWtCOPOatYfjq32v4TYfcwiH4geUJm+SuslNV1ZKEx7kEvXurxJIkdDEFJbXK2QgGuW1fVN+JnU+CLQVCMIBQedJ1KKmNb6zY9jnXmDVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3c+6Gfe0QqAJmbUJEhTff/vOjrW0IUNh0yXtb5QZfA=;
 b=i70ugmlLzENmhssUsa1FJisUKRei1/QLvujD0UF1PX2/ESVcXEipPXt+oLoNMZrZkBA+IA/mn0SYFvZmBMmRrbYKGoZVjiKx2Hq9GwSEF0b/i43ym/AVchF3zg3eO91D4URDOsdo+YVkrYw3n2NSJv9MDmwLLLt666A9RKq4iV7U6fyDRxOtsM/u3CpH/3B65OVg3R2F+x+Yeba7BzUB1BNPP+SzczFd9FfVRXh2OtJVpRDJQhQMhTMocmz+rPJiN/QkWy1u79ny08wjdu5vKeOyO/iVauiMFqYOoFuCg9nlH5e1v3yYDQOvLi0WODI1ruNIZ9FEHHnLyU/oXRTOeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 02:17:38 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:17:37 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 12 Mar 2026 08:57:23 +0800
Subject: [PATCH v4 2/4] misc: ele_api: Add support for XSPI SET GMID
 command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-xspi-v1-2-375b8c444dbf@nxp.com>
References: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
In-Reply-To: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: c632a970-1f49-4b38-537d-08de7fdd8798
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: faqKl09uXBiijlRh5dI1qWxDR4KSW78Hym71Z8NaJxCe1d45ZGGx8UmOO5E+V3O2EhXCFgoIJVclRMIQTXYTghdK8Klw4PGprdENAGWaZZrr/EUj1U9PawE/aQuLwIdkHnmA7ZtVsmP0Mh5p3vesQ7TWanU2/ez2uP26Z6Qmc790H3ftz+BmiykJDsAb+7R2B1gNSVEya6LeH34NwhVztb2QfYzHMrKguF0t7DuQH2SwGAgiyMzcWHugf2kiN3Hzs+zAOxoCGuiAwLTVLQSxF5exZq6EjOCsuuBtKyYw5MH/iqsxV0xacrcb8AkX7oiChySIuvNli2dh3NYLSO5QUqhP8/sT3evL6vWI4rSyeLKjZO/oCuHE1Dhgaz1IhjbIf2NC5fiT+T2lFFB7s3lNYkuCEHRNtA4OvgLFpP5Ba2KxyTaEbT8Sjk80M0iORt0NC0hs66hYy7Ym+GYWC+cXXzhLXKymdKaFsJwT77ddylxNJPPuip0mTln4BcJLu4J1asr4AU1W8v5drorpFMhgb5IiTltdJhINCd/GZyDUKrAXLXVNJssiJWx0D5HjXhPswVjPHExEMutT0wxS6NS5iiKKtDYDzwebYQhkKVMxdbnwCkgsdBDucljpYWHpgDQCqLkaWRsRMwpYdfTaGsyH4/YM39Juo3WDC1qoiV0rQgWJezUWAQabKV3WmI8VwaRdn7bw2A9c1F+giTEuF0xtIx53GlPvKjtTL5eiZFiv8xldgR7QWPR7APfcQOOfzpdguXBraSEXHSP8sxCIOpo6VlNIrRgLQOBKUIQ4jQTtDnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGh4bGxwaTJWMUZLdzh4QUh6STQydkFIb3dxSTVWdmR5MURsb3htQjl2OVZI?=
 =?utf-8?B?TC9RdUNtTHpadDJkNnFSL3FPQVBLd2JMUUM1VFV4djNld0VaeTN5Q1lRYm5J?=
 =?utf-8?B?ZUpxdTNXQmRiRWVRTmtONGhvUHQ3ZjF0Um5vUjlIVlI4Z08wTVlIVm1GZnhk?=
 =?utf-8?B?NCtOeEFES1R6UExXbFRCNEN3R09wRDEyS205Vkg3TXF1ZWJpQW0yY3VFaTVV?=
 =?utf-8?B?Q3ZrcVdhOTIxZ25MZHZWbnMwNEFTbWthTlcyMDhRL29TcllVWUxVMDV5VGts?=
 =?utf-8?B?dnNHNGdUekJHZFZRMUZWSUxPMWlJZC9Ta3RXOHRjTk9qUkI4TkduSUh2V0JI?=
 =?utf-8?B?SVFRbGtxYklOd2Q5ZFBSQXAyVS9iWmpkdHZuUHBRQk5QYlBma1JpVDJNL2lQ?=
 =?utf-8?B?WFljVkpqdHAxMUt0WngyVjdvcHpQZzhOd0ljZzV6QzNXdU9YSFFDR01kMitD?=
 =?utf-8?B?cFJkaWZFY3pVZDdBbXArVjgyYllNaGJjSWpKTUdsYTJTbFVuaFZJU29vRzN0?=
 =?utf-8?B?UTB3ekYyd0pCOHJPTWhSaHcwWitLNEQ2Q1FIeUJmcVRESEpiNTZnZkJoWHV5?=
 =?utf-8?B?bDlEd21hdThPdklqUnNHWDF2YnVrWGdxU1hWYllKeXJGODY2czd2eWFaQXEr?=
 =?utf-8?B?dDhPUTg3anViRXVnUjFVbTg3Y2xQVkZmS3FXa3JtMUs5Z1lrcW9XcEJtZFZa?=
 =?utf-8?B?TUhDdVVyMjBjWmw3d3EvT0RaMW1ua3k0OVFCcHZLN1ordUVUKzUyWUNqSVpX?=
 =?utf-8?B?RStSNU9NdHVnem8xRDdQQ2JSdlZuUmdxMVlHOEFGcGFNWnVEMkZtS1QrU1dJ?=
 =?utf-8?B?clVCL0VwU1ZQWVB1QXExSDh2UzJ5UVB0VDZXbk84WC9UcSs0bktpakNLM2Q5?=
 =?utf-8?B?a1BQRzBzbnZTZi9UQVpQejZuUklleS9DVEFNeTgxS3hBN3V1NUgxbmRZd0J4?=
 =?utf-8?B?YzNWU0J2TEk4b2NEWnNuc1JUMkE1MW1pU2V1YjEwRlcyTDU4VEZRSWlJcVlO?=
 =?utf-8?B?YTRibzFFM0dESUpSVzJUZHVrK1hsKzVQWi9xbkkrL1RySlBsNTFDOGxmeDNp?=
 =?utf-8?B?MDdHaEpoWFZDcjJCaGZBc0NXOWIydGNqekNZWnZVWjZtekFSa3hua3ZmUTBz?=
 =?utf-8?B?UEd5TGpwTkp3ZGtiWlFwakZDSHozdlVoU0lxUWV2Y2paQVFRZmpPY1AxQUd6?=
 =?utf-8?B?SittTUlPUzZtS0E0SmhnUEdtN09STm5wZzlxb080cWFnMW1Qai9lRnlTVWxs?=
 =?utf-8?B?b0x4b2tMNkxiOTZyNTFwL1ZWcUNpZDFSMEthWXlpZzVBMlgzUTRiK2U0dklk?=
 =?utf-8?B?V2xESTBRNU5jVEhjL0RaaUpTdFNTc2NqTlVURGtkWit2RjREdUN4TFZIWlJS?=
 =?utf-8?B?ZGt0RFNES29qb3Zjc1Y3VWZwSGNwSlN3WGVuV2FyY3dFSmExTVpWbkVZVFVH?=
 =?utf-8?B?dFhnSUk5QUdPcWNXMjQ0ZlJIMHVmRUhNZ1pzYVlvSC9EalZJN0xwZDNNV0xC?=
 =?utf-8?B?ZFZTVlhBUXhGMjAzRmIxNWNRWnR4YVA2N2pRbS8rSFNRcms1TkdIcmY3dWVM?=
 =?utf-8?B?OS9JRFNENjQxZStVWjBzVVhmNlpqemZKUjVNQ21qUWhYMmdCQVlMTlBheC8x?=
 =?utf-8?B?KytYellUNHRhT3h6RXRkeWNoTDNIZExxWmNIdUg5Q2lOV241WDZYTjdOcDFm?=
 =?utf-8?B?aWFRaVBERUQ5anRsTmRZVG40Mkp0amhDTkxDWE1MQlpWZ1F2d2N3R0JBMmhS?=
 =?utf-8?B?U3RWWVVPVWJBbjBFYmRMSDRwVGxqYVpCUmdzRTYzd0RoTTIrRTVSdXJTcFJz?=
 =?utf-8?B?RTlvMDBjWlhtK3ZHenR6dUdiWXJEZk81QkR1eVFmQlQxUk8wOW9hVjFmMDlR?=
 =?utf-8?B?SWhiMnRXS2ZLa21NY2l1TmdSL0x2Ym9EeTVlRzJLL3dybHpBbVdvbm0zMXU2?=
 =?utf-8?B?V3BGb2lzTmJ0UDVkUExCcXNJWkxkbXhEdUVrdXJMb2J2KzcvV1packxuZlhS?=
 =?utf-8?B?UDd4ZW9zdCtPbXhCMDd6UnpQaFFmZUlya091TmdUN1ZZRXJZVUNPQ284blFM?=
 =?utf-8?B?RWdOcGlVOHlpeFRvYk1zclE3blUwbG1rQTFxOW1vQjB4Mk1hTUttVDQ0ZUNL?=
 =?utf-8?B?YVNjV1dKTjAwN2R4ZEVzWXNqTG1LeElVL0N0a2YxdWQ3eXlUUVNFaXRJQldY?=
 =?utf-8?B?ZTkwcW44Wmc0YWpKa1Byc0IyUVpMamVrMTBUSWdLbVJaaFBsUVB5VXpoY2NH?=
 =?utf-8?B?bXZlbWkyNEFOUVpBcXF5cmx0TjNFQnFRZjBkdk13VUhRTXVmZnc4eW5JMnVn?=
 =?utf-8?B?Q1dKREVLbGlnbTBqSUkzMnBRbG1nVnNNWFNpdWU2MWxIdExXUUFDUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c632a970-1f49-4b38-537d-08de7fdd8798
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:17:37.3646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQKmmwHTwsjyi9hSY6Er/ufui5iTe1P1zbI8QCw5OVtN29aYfw5jdJQSEUs83IAqAo3p5d0qo2PpSGawLGTa1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246
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

The XSPI SET GMID command is used to assign GMID ownership to the
requester, allowing access to protected XSPI control registers. This API
must be called in SPL if XSPI GMID-protected settings need to be
modified. Otherwise, XSPI configuration depends on the previous GMID
owner to provide the correct settings.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
 drivers/misc/imx_ele/ele_api.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 4e1afc42bd8..04e7f20a2a6 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -49,6 +49,7 @@
 #define ELE_ATTEST_REQ (0xDB)
 #define ELE_RELEASE_PATCH_REQ (0xDC)
 #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
+#define ELE_SET_GMID_REQ (0xE4)
 #define ELE_WRITE_SHADOW_REQ (0xF2)
 #define ELE_READ_SHADOW_REQ (0xF3)
 
@@ -162,6 +163,7 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
 int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
 int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
+int ele_set_gmid(u32 *response);
 int ele_volt_change_start_req(void);
 int ele_volt_change_finish_req(void);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index e7aee0fcef1..8ee0a7733ca 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -844,3 +844,31 @@ int ele_volt_change_finish_req(void)
 
 	return ret;
 }
+
+int ele_set_gmid(u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_SET_GMID_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	return ret;
+}

-- 
2.43.0

