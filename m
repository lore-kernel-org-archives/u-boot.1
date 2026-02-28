Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A9E1048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB4583F30;
	Sat, 28 Feb 2026 02:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="be80r5OD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A300B83F56; Sat, 28 Feb 2026 02:43:14 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BC283F2D
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB2FLXvF3Jl7n16OT9aazzmXWD/nur37N+4hpJLHZi8B2ufOHF7mHHDGWwzEYyNiZyp2be9C6JwQ1cyYH99oNw53VeNzDeX/37s1HjyJnSTUrBNykLDl+L2xjVzzag/5ehlZhTfN4ThWorOq3BmR2XI9AaCNy4SgMenPbMcZMRHrY7HQyCjs3Sw2kW9wpMHMrvBLaQTSf2gbemfdhax4M+8WS+4QqL2MAEM3dTQwa/ugpurmSqoJtATZaHSwosUEpZZCMOLoysCe01f8358Sah2RSBzh6GN77wfoy5ZQAv59zNTfGVlIi8jokpyCgEZ6NagfCt7R+8SGF56Qsd3/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3Qloh/qhWh1CavL899+6nyPtAmWypvvttNjShtZynw=;
 b=b8p1tVMooG7lyug0TlP8lN6bWYKhEM3ETLyD9E1Cc/LxCm7uJ+BJju/L2CEDXDpg2ubBMdUCnbeRnUa/PQgw5Maq2NZLUiuAL0SUvh+URSnF0IV7QiihO/5cy4fudbU4Yuqr5O5lWj/73OIneGhnfp32DH0HWaXLQHDJw6LsmTE4YfdYhTNYRn2a23kss40ocvaN5uhbs78N47uPa3ziHIztJZxUF0j9VzVQgqSZ1lxcNiI5oYe4OTdE/loTXe4tVdHF5SD2Czvm3takm3OKpap9D/FJENuvhD7miH0UNHBhpuGBWnl3jSK9s5kGLLL5V+wyMCAYMiAfgpzd5d2tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Qloh/qhWh1CavL899+6nyPtAmWypvvttNjShtZynw=;
 b=be80r5ODLlIn2dn9R0yFPdL1q1IzaeVg+WQO1ioZ7q/y8vJOXhmHU3dfItdnDlDkDxBt/t2Z8p9hACiDogJJdnmJc2Ukg2ms//dY6XywQIciLEGeR5XfmWDGj6/z5RAJ7zJBSoyBAAmkvhALP0LS84k/o9Yuh8HXI/BPvwEjMdqC5Rhq44eqiTRRACe27KBkw/TlHm3FcvW/oiiUcCRvlvK1C8weZbQyRPuzDY7RCQLM7qezXZpn3bC/+ZkUwYtrLL1DiXK9+T/POhvXcKSrfzAR2H/IieKlW8Uel4c4viCS7QKiI6cKKJEU0yMMauBzPQnaVk3GX+42NiAt8oHw+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:10 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:22 +0800
Subject: [PATCH v2 04/13] arm: imx: Add i.MX952 CPU type support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-4-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1f2a33-4aa3-4e79-5308-08de766aba8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: knoQjioETl3q+5h4vbesu3FVdso97S+46zQdjDzDH0aBZKDWDna1Cp8bQs/oOEq6mskYgsJK2nHkxKnc52ROiOJS6h3KzSZj4kMTyM7shre3Tbmkqsyi6EA+8yuAA8Kmsl5EWuNoJZCbff7en/JfRKJMbKRVDi+UVtf4Tkn/RW2zIveusZluX+NJojCAE2bbwRkUatscOHatihRrMVlYBleybNbK2KufNpLJkiYzNtnv83/oVYcs+W6Rcnyi54QrgExgTeW17bKe6oxr6skGi9lIdnKKTY9gvT3Lg2GrkReB3Y85DuSjWHwiJoFIpMaDGdCyUJR/LjUDu1gHqzhNLlMqAOA4FRqwCkR4tya/+3beQmqSzfV7Ju0MHor6YSCu6JKDAxlYFvyUtZn8sPYVpaaBGkDGyfmcJTGrzSVBMUiNVNGpmMWyXUoAq9ROLo7vEvlJ0RDxhoV2RtamTUnbqxCN6cX0Mzh1bGT+5fhaq0jhBBY6CUolxcZ+xNRPpf6e2WmmFYIJkRXEVvBgISaYiy+a4PkmbwGcNRxCFtV0oYWNM4ClcqfWwvH/COTnIv8K/hntvAxHRkdEfTRXQqXN0Hm/vOQ8bzA/3XGBWBjGnJdvMCXvqNne56ztRu+G9YTI/ATM12bdn7V4hWby+derBhCOLHsNSAVvRPBtJdWDXY11JvaJMk811Ew2zmr7IiyVouPEUcCsi6jKzDiWMw2dCdexNtUtl7gVanD+Dz5g7Prm4quJgUUN00k9d5qiqxZVJIM1aJRW0ryqXUDV9PZhNDQQce8u5hw+ewmvcTwtIpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNPc0VyOVd4cjQ2VE9wYUppWS9na3VBU0xKTytiMllmTWk0ODlzUGhPRnZ1?=
 =?utf-8?B?K05FbHNDNlR4L0I2L09yRUYzaXpwSURpbnZXVWViNTBvMk1GbGM5d3N6RDB6?=
 =?utf-8?B?TXRsaWJaOHovaVdZT0RXUEM3L3ZIbjRoOUw1R1JvTG1GMURzVU4wcmRnN21F?=
 =?utf-8?B?QjZLVmxBZUs2WUFRTDZLbXNGR3ZBMmFSU2d3VFZraXk4S25Eb0Y0ME9BelVQ?=
 =?utf-8?B?SndEZm9qNXBqSXZvY08vWjlnUXNvRFZVVk9HM25XR2QzWXd1dENHOEJFb0tW?=
 =?utf-8?B?WDRObURuVG9WOVhseGdVbVdPemF5NmZ2Y0tjVDhkYXh0eVE0ZHFoMzhpUy9L?=
 =?utf-8?B?U3NnenBiMnhQdkpIYWtDaXdvWHdpVFErTnN1RVYzTjJ2MXdPSzc4K3FubmpD?=
 =?utf-8?B?MVgvVTNGMDcySGpZOTFtT0tid21yeXl6VjBHT2pTTEtEUzgwRW1VNlhUR01k?=
 =?utf-8?B?RFdhWitKSDcwK0l3K0pRNEpzeUVkeU54VC94UGJ0TWV1QnJhT0lTRkVUUWQ3?=
 =?utf-8?B?L0VPRDYwcUx0ZXV1ZlVrS0hpajczYncxSk1uQkp6ajNXTGF3dGkvc21rUmxt?=
 =?utf-8?B?bzNHSXRaYm0yQXNlOXhHM3d3M1pLUnRRbzRCM3FjRk40VThqZkJ5N3pFdXdH?=
 =?utf-8?B?ZWJBVXBzMDh5bzJUWjA1c1ROWTV0TWN4ZTFrOW5lMnNQZC9EOUViS25rNUVY?=
 =?utf-8?B?VnRiQTBqMXc3Wk5zNVRqR2lMa1piRjRSV3dsUWlmZ0NmTzBLUldSb1ZTT29T?=
 =?utf-8?B?QmpUeXpIZDgxV0l4YkhrUXhQRjJxQWMzY1ZUZk5wOWxodEtWWWJGZE1GZUxZ?=
 =?utf-8?B?R3JOUjF3bXlvdy9rc3VqM2xMMFdubVBzaFN3cSsrcVJueHNlRjluL1BlZ2VH?=
 =?utf-8?B?M29HRUlMVnJQQmpZbXVWOHFNQjViOW1sSjVtYk90TGhSZnRrTUtDd2FTQ2V1?=
 =?utf-8?B?UDVUMitJdklVVWtNR0YzaWtyN0pPUmJQRHF0aUpkYndTcUhlZzZQd1loM2hD?=
 =?utf-8?B?RzdUSEZHMHBPL0VKUmRkakM0MWJDTkg0THdSUk1Wc2hxQmx0VTJpaTZ5ZnY2?=
 =?utf-8?B?alVtbDV3U1VWOEZTQXVWbmYvbjV0ejI3LytiUXlwcFh0dndTTXcyYWRWVEt2?=
 =?utf-8?B?Nldrc3Q0MDV4STYzOHhDSUZCMnFUb2RDTXFINXhyTERlcngyd3lYeDhObVA4?=
 =?utf-8?B?ZDlrc2JhMldQYUczVERyYlN6b0psdzBzaEFlL1dadXlGb2h0MSthUXZKYnR5?=
 =?utf-8?B?ZmpLY05iWU5IcHhaNml1QVM4NkZWWHJBMlNORTNYQVV4d0NCdWxxSnJuUzhu?=
 =?utf-8?B?bmRSa25EMzYwV1VuNHA4VWVMZ0J6Nm52N3RpN1dYNVBndFZoNnhNUzNZaFBh?=
 =?utf-8?B?bnFWTFl1ZDd5TkppMTJUUlUxOHdhVVNNZ291a1VuTWVmYWMxTnlBY2ZSWDJI?=
 =?utf-8?B?aEVlYk5UZzY0VkR4TVkydzBQTlFhejd6SmdvZ3FabjlPMllMSDNrYkx1ZHhN?=
 =?utf-8?B?eGZCdUNHQ2x1NTB3bHJVQWpZbVpkUHZmYTBaZWRvN1RKMTFFaDQ1M3RGdDR6?=
 =?utf-8?B?aEF4SjBUZ0NRbHNxVXBqZEFYejNRa0M0a0tXSGkwYU1NblRHcVZqL1JTOTNx?=
 =?utf-8?B?dGJFWm5tS3pRUnh6Ung5YlRBbW1ESWJmbTNZdDJHd21jYnd3MHlQaUxnZkxp?=
 =?utf-8?B?U3k1UTl4MjkyVEk0bXc2eWpRd3BMZnh1UzJOYmhyTHVXKzhZcFgwSjMyeUtm?=
 =?utf-8?B?K2VmaVR2VS9NSE1ta0xTR2lTSEpseXZZVXBiQjg3Rk9CZ0E3WFJvT3F0UElk?=
 =?utf-8?B?MVByMWJrQkFmekdNQ3VOcVFKYWRVdVVRais0cksvdCtSZzZESUhoRS9Ub1BB?=
 =?utf-8?B?RDhMdWw4Nm1CdDNEU2hLMWZrUHA1UGJ2QTVlbjR4RlJCUGdjZTM1S0xhSy9s?=
 =?utf-8?B?WERhQ3RaOGZ4aVZBYXdwYnZPaVkvL0RxdFJZNUxTa0dMakFpMGd6NU9ZS0NL?=
 =?utf-8?B?NFhuTjB2bjU0K0hZcytVa0JtNi9pN0xEMmNuelN0OTcwSkxZRVN2bXByVTVv?=
 =?utf-8?B?aW5NWWFyVjhaVmxzSFdGSXRxd2FBbExrNlY4cnI4VzNhbGptQ3pZdlUzT3JL?=
 =?utf-8?B?bE4wNFNVdXhzaXpjM1Z6V01ON0ZXM1kvb2dMQk9WeVpwU3A1ODBlOEFhdzFz?=
 =?utf-8?B?S3Zac0NpRmt2UCtVU2JuVXdPdURDWkRGWGlhZ2ZQUWMrZXkzMUg2OWVoTWRB?=
 =?utf-8?B?Y1VmajF0WUU4TWpxeDlDL3VuMk5pZHhhYnVQc1BSUnNkdWMrQUpFbys1U3A5?=
 =?utf-8?B?ejUrb2YzNGJ6Zm1DSE4wZzdRVVZUbXlqL1lQa05tL05BY2Zyd3hyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1f2a33-4aa3-4e79-5308-08de766aba8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:10.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU8NOgmrqyIWOdZ0JdZZW2nktIdBDVmX0FPEQOhbF+Z7pnkFKk958Yigt7VYXK8Ks44FyXnuV5TYyJJfKkH6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Alice Guo <alice.guo@nxp.com>

Add CPU type definition and detection macro for i.MX952 SoC.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 1 +
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1af9778f8ce..25d0f205fde 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -79,6 +79,7 @@
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
 #define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+#define MXC_CPU_IMX952		0x1C3 /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 13857b921a0..ab573413128 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -99,6 +99,7 @@ struct bd_info;
 
 #define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+#define is_imx952() (is_cpu_type(MXC_CPU_IMX952))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))

-- 
2.43.0

