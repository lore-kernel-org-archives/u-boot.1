Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5D8C71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 05:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C340281760;
	Tue, 17 Jun 2025 07:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hXy8X93q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A51A81E18; Tue, 17 Jun 2025 06:30:23 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7210980C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 06:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm24oImI26qairhtIy3V+Cj30vGcJQRinVemIE4hppvio6GfXYY/HIKD0yZ8T47EbYDDRux/kuolO6fu9osquxXtmhVqdOwPCVudwxehdetKRgO4Hq6SK0KByd3TSWqV0gPl0ltRSBfRFwDExhFghZ48E8WwXgyp8Stt0QVzn2kOWlZy1xpqoAezsLY9IpnbUfZHUqcLdRzZBICZ9wB22+fl1VZBHcO/SxZD3CKBxUakfZ9aPOCaXfyC0BJBSMO1ukbndwM9h1tGbJMcsuSc91OXMDM3Z5/2NVMCU4JvcLfn6IKu0soyDNds2S23f/7mxx2ZssYfDToU9vT7sEhTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5txadCzQLeF2diH6EEdx026cG8DxG3xWd1ehWUUnLA=;
 b=dER4sGfaGJQOpraybAJtug6CBr3Dc3lmdD5n/G4RTs7ko8dECKi0opY6fQk/nvujSaPWBf0xiLsjUZOJ5svyqq6ce+6xZnaRXUrhtYfXS6d5LcEJB06T6lholqrjY1b9qMaaufMgMkt3dqS+oloCA2mU9Cpdg1akRE9McEqNvV7G+ct0JSjQQxkiibOAfhlrLR2lu9r01WflpZ5ZMlIii+7+hZa785QIguG1/txJx22b6x/ZyGAQJwHVCGrKzvgfDJUtQ4RLSxsXI+Vpszy2VdHFBXR0YTnvcfbFa9d0Y5sE50Mj0UieyU9ZqAwO/HEZigZn107TSXm89Wal7/x5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5txadCzQLeF2diH6EEdx026cG8DxG3xWd1ehWUUnLA=;
 b=hXy8X93q/bbY2S4thlxroHwaaIDLH7BPKDI+66Jw66gA5XyBiFk6SKqLGR7r01fI1z4XHbp4llnpbet81ST8oNoBsUoFpWdM0QJ1VpNhaRX/Z20mrzCIU5ufpGWnfIQj73EYJuowy0FE9WJCp/djtlDLBnA8V/wFG3VeEVs0xxgK2moNqG6Ipy768yqJFIDgm3nSweMDaycQ1IA/BCMRWUM46IZbswM56M89i3FSe5MxNklxPn0cXtDQmaM6NOgbnR4lIIpYC0zRks2UXE2mIljivSdC5SgCDTfbaY5m7YHIz5YGGVmXOzVstfm3oaDFr5jwRFHjRgHC2ujopnQMSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA0PR03MB5386.namprd03.prod.outlook.com (2603:10b6:806:b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 17 Jun
 2025 04:30:18 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 04:30:17 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH] dts: agilex5: Enabled nand boot in SPL
Date: Tue, 17 Jun 2025 12:29:10 +0800
Message-Id: <20250617042910.91099-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::15) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA0PR03MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3134b5-5264-43ce-6914-08ddad57a8db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WI8XTcxsLnDXhaILHkqIdq9Na8r4NXbyb/EqgzKKUtQpmT5sKK3Kc12ebiLP?=
 =?us-ascii?Q?QYSg7ll8ZoaZnzdQXPoPhPGtGxin5cURMHpqXGjDltGp/VWfUoomanIBGzIw?=
 =?us-ascii?Q?3WiAZDU/paX4VHTVHVAgxqTVenJ6Yr34yKO+J6w1DJLT/m8Kxmtyd7tpHU7D?=
 =?us-ascii?Q?XqOM10m4Gui5VeHONG4/v14gtebUBjUlW+bgTl0Wb3E7k+msrsgDXmHOgN82?=
 =?us-ascii?Q?s3F9RGDDudkm3rajnTCSkGAbX976ZY+bf+ucTvyWXzlLE4P0wyfTc4qPOX62?=
 =?us-ascii?Q?uuylyy3re3C2LHLNOIZoNwxN0akPN7ko/yo+FRMH/uFGmaL/MG3DSu+WQhHt?=
 =?us-ascii?Q?Jen15XlhE948j56N8nOr5IW68sDml7OSm9d/WN0tEYV9kvk7k/Q/D6rFeuvq?=
 =?us-ascii?Q?hOq9zfUwhaPAMWNjeOBURFGH7ssjqsLlf8cERkbTqmOOIYe4MsGb8pknazuU?=
 =?us-ascii?Q?LYk4giihQdB18GaO7+7tFPzogqFPZNG6tGtQTVMckavmyUD+At04QjrLmJUA?=
 =?us-ascii?Q?+uncCRfnvXb/p060jfzoznjV+OK/h1+vEDheSBdgXG4XZ3u+28dJdEYLyNOE?=
 =?us-ascii?Q?1vJ8u7hcUJMQJvTY3eUrp3f1boWpH0gX0AJOmIBhdOgOxFxYzDjBbKy6cVDE?=
 =?us-ascii?Q?SLuOKAVd0DreG7D0+0xY9pW/PniWSmh/+iQDo/yJcGHAjXG7Kv3QeRV64w20?=
 =?us-ascii?Q?Q1p6nz5VST/2UCJ5gUbFAZsfUq76yGft77af4PB9BeFMTecIOsQ33J1xIwK8?=
 =?us-ascii?Q?SgRUg+WnpiFXYV8SfxmbZ6ZZm6nKjMrx/cIVwudXDwyKijgS6QBKNhSid6st?=
 =?us-ascii?Q?IkQns11juabDO9ww0S01gfYqC/fAELug2QIBhW5raQDmwla894Ix7A4buZzy?=
 =?us-ascii?Q?rwk8jg3wM580OvOgQboq+gehUksGW1Rj6JbJ9k56F1afybjO8BbO3lDB16+a?=
 =?us-ascii?Q?GQGccozSCJE9j70P/dnwTLNOa0uj60nQ4eZxuTh4FsFr6eKp3onpEoAPGMct?=
 =?us-ascii?Q?daNFZ1ilftZR3zGZd44HZ006nDWnAftnrpmozfU87BMjAT9jFCvHhCkfy98L?=
 =?us-ascii?Q?5fzN3HGA7e7b2IG/K6SWOvEuOwZ7Bdv23MynFbYcTxQ5qDsyFC9srwFW9mRr?=
 =?us-ascii?Q?+j6NuqUTXYz3s9lCmBHoaMGk2/xrhb0O79weudw7GU0UAe2V0vK7umd9dNnm?=
 =?us-ascii?Q?CECpjwPUmT+9e1Tsi2SIwEuisrUf+OZdmWGrgrWkVPSDEwzL36pKgwD7NEj5?=
 =?us-ascii?Q?KDzTjfY8kJrSM7FH6KzmiGT3P9RcSluaOEtm6aNlVrxyRM/2UxS+KIKWOxsY?=
 =?us-ascii?Q?x7+wJEYRiPjPgeIANZNpmrQnbTEa3kQtKb+LKXPenf5amcZrP+FwD63UFqEb?=
 =?us-ascii?Q?blj3Sc2q5XZc+kHZHwCaBcb3BURgyscX/3NcMAwAOA00BHQln9cfwMb7kz/l?=
 =?us-ascii?Q?0V1/6V6uw5I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCj67THNpz2uSxnanKeCD/1j458kKD/NNu8xkQAimoD99c3M49nXsOQLSgip?=
 =?us-ascii?Q?6AgHHYEvx8f6OiYdJt1wZn6QKrRd7g0x5Rjl00r1EhUdHaMyH7SO+2JyOuRc?=
 =?us-ascii?Q?UpZgGOple65YHJHg100oAzT3qPmCdB8IKMy3Erwmok44oTaeGkkkRLJHakly?=
 =?us-ascii?Q?buwwMltZDGabuPeCR6WGI7Tinaj8eJP3C3HTE9wkNBT81DyR/1LkVBtoImQp?=
 =?us-ascii?Q?l9azdDa21Eo4bvk0j6o4p+0HwSpqeYL97wqaFYcmIIObk1mD+IAipFiTnz1H?=
 =?us-ascii?Q?eiKXgcspaQf63H8hoSusm+vh6hieFrhM8TweIjroF3Ca3GMgr38lmRZl8cf6?=
 =?us-ascii?Q?equsJrQwVnP1BO4yvZTTaIDvNTewSUuC6xGG4TrXAy/SqfNs/w2Xha381I8t?=
 =?us-ascii?Q?zLtyrY0zuYEsLyKpjUQc2LGs13c8pb3mOApxCb8aEGAFtE1M0v3p64GBx/N+?=
 =?us-ascii?Q?uie0xQqZGTUebuO4lZ1EMoM/D8wpx991NeQmJlReDJMXGieitqunw8R3KN6F?=
 =?us-ascii?Q?kJE3L7bnFK/Kg/EXlNj3Izfg43VdL9ByvGnj9eD3awb8XRRcPeaK4LXQxyQ9?=
 =?us-ascii?Q?vWwM8RLQCEYEbUjPuhMwxUAMw2GHB2xzo9YAQlGWWFWoo1NGZwhh2hgc179b?=
 =?us-ascii?Q?vETyw/AtPCvlfMEwL2OQBa5OpoagCrTK1KLHmSxr8/B5w9Sx+nPTtzVUs+Eh?=
 =?us-ascii?Q?JKNHsiXKwRkZeXc7hAjXtqrtpdOIxkeWQ6pF1q2kp4fNFucO1k0GnqONBgSs?=
 =?us-ascii?Q?fnDD/cmR/hoCsaGvfOaYA/J1OFZaBwtykHWazjG41FeuAONZWGXJC4g1GTMS?=
 =?us-ascii?Q?u8ZrA9V3W3XRLrz0Wfl/rO1/TlKW0eAkidA3dYPoXYOlOkZDko5HzJj9LoKz?=
 =?us-ascii?Q?195LPzGuK3jjidZvgiYs9jMxxrpFttjYqdVZYMbJ34FxV5vVjeqSqsg6PTnZ?=
 =?us-ascii?Q?G/X2N2f13O6/yaNF6njzohu4qn/vXsnxVEiv25iqndwR/0YYDZfbBNpPoeu8?=
 =?us-ascii?Q?ciVkHRYNamH8uSOlK71Lmcju6b4qTjVBPnVDQ9YwiL2ukpDehm5xPW8G2gmE?=
 =?us-ascii?Q?jvcz5bdypFrFabiTFTgiLecqPVwn8d1aOIyyZAIBxUnaam6cYziCQaqC/w9C?=
 =?us-ascii?Q?PrF4ZLSFXSpO0V1n4Pfd04eYUb1JZQpvrQASAY4eNE3yTr22IEwdUD3LOXZl?=
 =?us-ascii?Q?y+dt65sFKruQGqtMJcLdHeVeOTrwl8+9CXeOTi5YMF00dW7IIHdZWe7FiaJO?=
 =?us-ascii?Q?4U1Fs7R9vo7Dm9KH7d/0gNCXOorWPKT8cfXmhWB9rYz0eX152UGFoIIu4nUG?=
 =?us-ascii?Q?4PiTpnZuERa7gNUgVX97IY/w23fw2R0Jx4QPzpaH+ugCK7jBzidV4vN5M0Ll?=
 =?us-ascii?Q?moKSyZLpfcRUXLzGtvZMBP80aQRKDrxGuzaX+5VPcUqRh18fjL/CjGvAbAeo?=
 =?us-ascii?Q?sGNQyWLfa3YfURL1vLrFvjYYe4CAb4ag/9yyMm7DXgF1QwTp8jDqWsZHfLg2?=
 =?us-ascii?Q?nk/goqpXDNDFeg1uiUl+rsWM5rVcewK1Bb09o/UulQRVepzArpbqvUakgVgG?=
 =?us-ascii?Q?dzg3B8N2dV/H+Dit6rXJoHa6nsGyzcb1pdLk9Tx+UUVRMTPNYare3OgRxn2f?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3134b5-5264-43ce-6914-08ddad57a8db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 04:30:17.2831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W6A4DzP7Cfor6/CV+76oX94MNQ2UL7F9IyhqUCc3U7RhfJDlMe7Vwj0E5nIuVZ/j2EPqJLTRpqWdiL5w/+ujlwEMD52kx0vSlJafT9WDXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5386
X-Mailman-Approved-At: Tue, 17 Jun 2025 07:41:19 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable nand as one of the bootable media in SPL.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 8d7dc0945ab..938ddb04c04 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -67,7 +67,7 @@
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
 	};
 };
 
-- 
2.35.3

