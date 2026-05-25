Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7B2CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA23846CA;
	Mon, 25 May 2026 04:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IeGsYZO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6311684815; Mon, 25 May 2026 04:41:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F36C846F4
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRuQrWJJ+0E83nR2HW7iehroTNMk9s77a0mJ8yveQ8e7GlTGQIXmdtK9FYegWtB0vtwYWwK8JEjaQGRajo0hczSQci4hcEyjNIn7T2JoxdEjDgPNJoHREGjv8RE7CPWlB6smNkgleXMY6Jy+ocnANZIIW4+8vkaQ9beIw5/+WU1Hc+ieDMCXEdpOD/d+L+aygpkHTAkkzeOYCrElGAK2j+cEpD+HsISdD5t9Q1td22leN2ZvSSKdgvsgbhwizk0LXrt84IxwfsT5TB3QOvo+rv17oNT4ND8QAlkvaclPnxmlp2tz6RqjvkNUudVbaV05ZVAHFTRjTW7S/yaIunWm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqUKdK3SoO+lz/ajKGzuZrn0NrW9Dy9pvV+aY9oor1k=;
 b=TI/V83C0i0REYcQ+C2ofhtnvgNzriSm0zEAjvu4RDvutnnmg+6htEz+i/+Oky4pu67vkY7leWWOv+Noo9xiZexcVktL2au3PX/CnCjRL5+qBLrzeD6YkcfMcaZreu++jbxa9t2frb002S3pm/1vxSBr330fJ/DclcKlz2JW1e0dg259jAWlWuoUfwASUpJ5aEOFCOR7PCssyNwfBNOER070JIdogjlcoYkMSywLKtLrmlnw2djGIQvrSgPncooC9sUz2BerMYQf7XvWpXbGJBw0/XX1QNZPbtQ92wT+pODQlmyKSVTbwJrkDzP1EqJDKgf4jZYnAT3cSZ18LO8umyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqUKdK3SoO+lz/ajKGzuZrn0NrW9Dy9pvV+aY9oor1k=;
 b=IeGsYZO4XOTIWUOyzbtFdTRgVa+y27JJtfnuPldBKqkAzm/3KnQ7FaGpO3icj3aVCV5HvHXVPp+4M0GgBWKiQ3lsfL+lCndrf7pEz+uqjG7JzhnIqTDwAd3XLFf+kvvdBZIjQkU8SGvsiURFEzDP8Axn0LC8FD7jZP0Qo31t1wfUBy7eGSxd6crFgo3+7h/iQs9NNTDNvQD90RT/TEUcofps9fMQ9Kw53l6FYELoBVlV/YaYzF+3GVIr+6PXBzplcniKZQrEwVfp14VSAniDvmG5kcy83X+yuIhfuG1Kef0aLzD+cO5N2THHrZfGSeUCEAYsB8xkapMhCXhFDUJDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 25 May
 2026 02:41:20 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:41:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:58:03 +0800
Subject: [PATCH 2/2] mmc: cv1800b_sdhci: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-mmc-v1-2-018e94f1c87a@nxp.com>
References: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
In-Reply-To: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Hiago De Franco <hfranco@baylibre.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 587f64d7-2c4d-48b5-3665-08deba071a2c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 06dAkNTRMKaXft9Gw6qj3IS5Q5iU3NCCDI66m6k0w/h5eoWlZCpUpeQqnapNX38GU3/sOLSUK6ux5/s7QUyTWtwFDpuIvCzobcXK7r/KpVYHilohM61skK5UoQOiYHgcxFEuijh3DfvwH4Br2/ToJoh0YeSuMue72xowpaW3IUBoUL1UGAybKBq5AZSHy1OmqslAZMSNGCknslkSg0Mk2nP66en6Bsjd9dSCc9SXhn9XVvIINGAyeys1Q4B+SeE46OII22KP92Jn/HfWoRxiIQ7/oFFjR2omXpp4vjPcNpRqApAtNC8PMejun1zTYdkapRuT87DnJBPfX0KxRAuIOtGG7ibogcSSpPMle9SiFkqjgvGx5R7GsBBujxrCHGY1lWQnBZcXISgEcMGr0jBKLduOZxC4oEfMQmE5CnWVlciEnlp5/OoDAatYDzh7hyQQQSOFzowHsV92fUK7Mm2xNh8Wneqz7zzWyAZ2qI1wyOxIr5F7TykZHThXSaEaWgaGGLyeuziB1YZNy863XBc/uZ1BTn2W2hGptUWIYcXVAKuRxeRnBLOJwsSMwedv1Dgvc8GbzdmAO0htEPRTYt3WI7n0tbDUQfj35U/VdNHC5xSL0Bb0ElLMWUk9IxqojfCD8uyMf/DxuU5nwCC5XicTbT9VxzFAwX1GQSSHvJuuyr1JaqD8oDtZiAWW3/MaZWOKAooEnYvkYLzoJOc4MdhmoNgKx8wkh62yq8SUEJIc51fPOra+obxzgrb90jke/IBd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1KWGU3bkJnYzZ5VGdKUHFYcGQ0aFMvZFl3VjVnOW9hckU3S09qZFQrTnJQ?=
 =?utf-8?B?OWNORGZyTXA5M2IwRmFpNjRaaWdRTU5LeDRZMEF5K0crWWZJV0pOVlVRMWcy?=
 =?utf-8?B?SnhLaXhUdkU0VXhMSzdPU01neTdnQU5qZGFUckh1L3E2V3ZiS3JQUU1YSFFl?=
 =?utf-8?B?Tkk0QjloMUNnckwvb2dwZEFBam5EWlJyK1lxRmJ6OElpSlpHSGJJSHRDbUc1?=
 =?utf-8?B?TGpCOERkNUVXOHpnU1liTHM4MEs0ZXp1Q2JuUXNWN29raVFlUkZpSmNLdG44?=
 =?utf-8?B?UDNNUU1XTUxkTnMzU0pOQmgxblVhelFEeTB5UE12c3M1OEFEdEdaWVdPSXkr?=
 =?utf-8?B?S2RzS2dTbmxpTmwrMEN0STBpTm1wV21oSDFMdUx2ZmRTcHMvdG00YjBmbUtZ?=
 =?utf-8?B?YW93YWpTMzJUR2xlemtXSStUQk4vbitSazR3WVlTQnl3cGMvTXowbTlCMFho?=
 =?utf-8?B?M0hxTHdodDhUSGoxemp5cnBQNGF0L1B4R1U0emM4ZDRIZmRlNTAya3c0NnZV?=
 =?utf-8?B?YnN3NkxENzFhNm5pOFJvYVBPTU13RWF4SWx0ekhCMGRkbCtvNGYzNWhZaSts?=
 =?utf-8?B?eVNGaG9HeDJWZVNMd21WdERMR3ZPR2FIY3h5MnRHSWdxUEtSVjJTd3pxZUx1?=
 =?utf-8?B?U1Z5Y0NzWExmSTVVZ05rMkRxOTRjK3dvVThtVVFreER1SDFGNW5HOGUrNXRN?=
 =?utf-8?B?NENFSm0rSllldVBhRXBOSlpvRExBak5RMlMvYXFsY0l2ZW9HMWU5ZEdTc3k1?=
 =?utf-8?B?eVhlMFFCaTc0ckJZRzk3Ym5HNCtsQnZJWExod0laVC9obkkxaEZjUndIeC85?=
 =?utf-8?B?MjFuaC9XQ1hIQmVrcGdIZ2VOV1JUYTV2RHMzWHhZZFpyUjUzSGJldys4RWRU?=
 =?utf-8?B?emFiVEU3NFNWYlZHRTEyQzZSTG9NQjQ3OGtabHk5QWt3VTdWYlZYMFU1UFpO?=
 =?utf-8?B?NVY1Y04yN2hDSXYvMkN5aWJYb01JVnlqdDlMSXVmVmtCT1MrMDVDS3lTUjQ5?=
 =?utf-8?B?dlhoS1ozNGYwNW5YRkRiVXRNT29sTEhhQ1NWbWxLbkdNckZGM2lyaEpXR211?=
 =?utf-8?B?TXBGb2dVcWIwemFjNzdFemRsTUtKeTUyd1BoUXlnZlJaY0VFMHJ3UDBpSWl6?=
 =?utf-8?B?WVRhWGNROTNKRFc3ZElnS3cvUkQwTmRTVS9JcWtieVB2VmlPeHh5ZEZMbEoy?=
 =?utf-8?B?N0U0OG5NcHJoeVEvcG05THpXeFBrVzBBSWJtL011T3g4VTNmb0p3UElpODdv?=
 =?utf-8?B?MmFKdkQyU0NjTnh3Sm05VVFJdWdVd0R0cmRaOWRMcXZiS1Z3TWN2dlRmUFZF?=
 =?utf-8?B?ZHpLVWNTVGdXU0lZaHdoR0VPTW50dXVKaVdOQ0RCOGVBNDdEL0hsaGlialAr?=
 =?utf-8?B?SE5OTzEyR1duRXJjTFBYTkgzL1lEcEU0VG5pdVE5MVZhcTFFaG5KVnZaWkJM?=
 =?utf-8?B?Q1BTTEF0ZmRPMkZnOTBwSnZHNERTNFlrclUwKzFIaEpkOEl4dXgzc0hBY2Ni?=
 =?utf-8?B?L1J3d245M1RjWVpwVytrdDJXakkvc2Z0aTUzMEhmMFpsQnNzUWd4UkZhS0h4?=
 =?utf-8?B?RlhRZW4vOGdXQ1FrYkFTOHVIekRIMTlkaElCc3JZMXkwOS94cjZ0MEZJMi9u?=
 =?utf-8?B?anp3eTNIVnZnN2lGMVNyZkxzOUFtQ2tPbzZjNHdyZGRmMUppYzFuUU9qRWpp?=
 =?utf-8?B?cWVHL3pnaDRpUkFhT1FrTE1sU1ZlWGVubmVMR3o0bEwwSFNQNUZyeHk4OUcx?=
 =?utf-8?B?eVduZEs0QTZRVUJCWjR1WU1xSmRrd2J4ZDJ6SjhCMkwyK3JnSTg4V2ozMFdL?=
 =?utf-8?B?QWZXYnNxeTdwTnNJTjA3SSszbzgxNGFiQ2JqVmhYeWt4aFZ2MFVPbUxlbWhP?=
 =?utf-8?B?a1NpR2lrWTUyYjIxdzgvZ2hDTW4zRi9QSk0xRi9ZaGhyYy9QMlpEY28zTkVT?=
 =?utf-8?B?bDhUNVZJei9SU09MTG54YlBlU3Zwa0FzVVJNaXRKMzVPclZEMHducUl1UEd3?=
 =?utf-8?B?aHREaGJXSElJVlpiMXJhZHZQUTY2UDJ5K0tQOStBdy9FOUxReWkwVnd5dFoz?=
 =?utf-8?B?OXh2a0Z1VTRjMXdnQ0psV1RiNE16Vm1SWHlNdllEV2oxeStNVmo2cGt1eEI2?=
 =?utf-8?B?VUFGWTdLUFZZaytMbWFZdWd0OGo5QXA1RUMxcmYyNHRxdzFuWENGYWhxbllU?=
 =?utf-8?B?WWNjTVBDYXgvTFNKN1FWcDh5QkNwV2FlQUF5ZTFyeHNIMVBFZHlXZnRLR1lR?=
 =?utf-8?B?ZzJXOXpsNXlvZjVrVUJmam14dnFVNGs0eWhlNXd6aWppNm1JZWhEY1lWNzNi?=
 =?utf-8?B?UytFQTd2ZmxXSEdSVmYwcGt0SlZtNHZTa0xZRTQyT0tsUTVWRFhKUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587f64d7-2c4d-48b5-3665-08deba071a2c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:41:20.0550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5j5XRvdIiD98/PT61OmMYFPUbyM6YA+iuuHqsfZoTNQZCbPgDneF19+KN/8GpHDY/qg16m4p0kv1HwdPhuWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
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

Use dev_read_addr_ptr() which supports both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/cv1800b_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 72c5bfc6f35..b756649f90f 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -85,7 +85,7 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 	int ret;
 
 	host->name = dev->name;
-	host->ioaddr = devfdt_get_addr_ptr(dev);
+	host->ioaddr = dev_read_addr_ptr(dev);
 
 	upriv->mmc = &plat->mmc;
 	host->mmc = &plat->mmc;

-- 
2.51.0

