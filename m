Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3CCC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C2E80F7B;
	Fri, 21 Feb 2025 14:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TppDP7YU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEDE807C4; Fri, 21 Feb 2025 08:45:34 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D567A8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8aseYaPc19OYFEQjAfXMYarkZD2fu+05ltUC98BDHYvFJvnddZC+mmtaagmrmsmwOQJoYYXt0gtNq7d1vJ0R9o3RpmPgyG38eEGbYK1DP8U3VO9UVuDPxSy3oWZjhVVRcKOmGLf/KsEYQvD893+sOtTfFRQubzF1TjE1cOwC83HbbtY2rC3V+etGF7lT4nTMiqV14u+x3CNK6n8aKG3eOmWI8QR24ysZefLW/ZzJmP5dbxhpMBdccVUY4gmrhq1oIBamofwfDH3SFPjIq6YSEqK6H7P3fjFvDW5YCviLe/WjW8Ybko820xlAQMg334EfhFNO9RBfuQDZfrnC6Vi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azOOHiCCjShdWMFjaiw3f4UF4UlgcX/yIHS3MXMTmZk=;
 b=RpZbDDsBofvxfd72vEZ0o88VPOsHb0B7GZT0zcnomh5IFFBZdewRg+R2GLgGET3+xaGdnYvt8kXSLYHlRiT5j05mhVJDvI5+zyBbq49CSboMZwaUgP+MZs4Fge0rFyet6t+YO8WzyIi0n4z2SclOxvaBYCNRMYnhUA+UeRmD7CspJU8JphlNHgwwrR52wiCISbud4EbvmXW38C3sAn9hctjpnOe6lj3ErydXjs/WpsAgiHMaMOknOiJcn/5YeZ24VfzyuvcHm1g9Ml1OZOnr2WHtMy1U7OxF/Yl+b4Xee4GoS5/8qQ83w/+ay5A4q4vrS5kxn+XkxHtuHVvI7Liwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azOOHiCCjShdWMFjaiw3f4UF4UlgcX/yIHS3MXMTmZk=;
 b=TppDP7YUHCgsMXJE7kXEKiE8E6H+vJZgWMCTy2osBGsQaFRmvJUm6oA5CgQIOER8NIqwC9Eu/Me3BNrt3i/FNv/Abk3kfzkL1g+vehQIWqzuuAtvCAAqu1ch7JulqdydVoZvQv70HJhHa1EZ/DoEI+ejmIannl0fYiul9RIguFl4OXk1Ux6Ws0XP1tGdqjFAkA+2oLoPvUv+VOySe3u6YiCCgDle+YyqWwLx/KG1ejv6y9R0p4mUiVxoKEMD1i6xTNBTV87VbT67Q6qb4bTrm2HB0C/fSOcrNBX5Te5mI2LmaFbaI04aw/mTUDsuZFI17mfHqFJAAfXNoN3NIsB6yQ==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by DS1PR03MB7991.namprd03.prod.outlook.com (2603:10b6:8:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 07:45:27 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 07:45:27 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Yuslaimi,
 Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>
Subject: RE: [PATCH v1] arm: socfpga: soc64: boot_scratch_cold 8 and 9 usage
 documentation
Thread-Topic: [PATCH v1] arm: socfpga: soc64: boot_scratch_cold 8 and 9 usage
 documentation
Thread-Index: AQHbhDHwwxJ56ZWKH02L1h0wwsO2CrNRYLgg
Date: Fri, 21 Feb 2025 07:45:27 +0000
Message-ID: <SN6PR03MB35837EE3FD9C1B28967B5A82A7C72@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250221072622.24035-1-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250221072622.24035-1-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|DS1PR03MB7991:EE_
x-ms-office365-filtering-correlation-id: f8e925fb-2b2f-4aaf-af3a-08dd524bb57b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7qGwRPdefaP1k2jcOLDoi+gIfxefbUW9/ubAdAqW5aGtTA1Jv76enzCHS7j9?=
 =?us-ascii?Q?E0hKZYmz23/7MFA+lWXq+13wVDjt8EFVtAnJMjedfwFnL7E/t3Q0IbfwQZZ6?=
 =?us-ascii?Q?eBX35BuCM8EkmQAoSiW8p/j+MhYzBRfjSIjFxiegXk8v9+3OWj927iRU5m0x?=
 =?us-ascii?Q?CDcYdCdbjXscM7lQG5ihGH1jhpQ8BB/YPojohnprzbGzCdAuIXDI6QzwpkJ1?=
 =?us-ascii?Q?DUT5RYAquuGrzw6J2y0UfR3+BUjyXm2+kxCa6EUfbcYMSluNj7BSqoVUgRe8?=
 =?us-ascii?Q?m4ADrHQjVzVHMVkzDDJje4xgJMhVORYe0Q907JxBjczKVAB6ORYymgXXOfcR?=
 =?us-ascii?Q?ELJy62svHExq2q0JfJaLdf+16+5C2dH9CXrHFuAkMwXKM0eUr8Clh0dUngBs?=
 =?us-ascii?Q?1Sxbo+DQYUiv4rilJRZDvD6WvInnVlkFK0LDTMRWfotonkaGhArYVHEev2az?=
 =?us-ascii?Q?YshKOFn6IlOPrQ/Hkxhw0dq6jRoFigBe/EOMlLopbqmd5kcpNaO0/uvLjq3B?=
 =?us-ascii?Q?YZWOoXJ3krFb0TmL8q/fZNnCGtIwNA5JD84OEc8KITM1XNd7Ofz8T6kmYAfl?=
 =?us-ascii?Q?BWUJKNsqhgc5RRLmoSPwjO26101IB11BcrvkqvFuJGoROOmsw2Io+SDEEn3k?=
 =?us-ascii?Q?ehjUzFfkBsn4+4KuriNzkDYkkS8N/A4nMCTrR8fWxWvhEsWaC++mqZtZjGHt?=
 =?us-ascii?Q?zd8wsqAsB0Q+elTUgUm+eSrakF9eqU5qjhqdS3M4TlHBr9e862SdwHo1qAgz?=
 =?us-ascii?Q?64oUSCIMyCOKEgZeKJqCV4izHcJ45RxWyGmrfypTLS+qWvbMVWk6/hrGUaoY?=
 =?us-ascii?Q?tKf7A+vAZaJ0xNFKO1iuZRwmd4zgU4U9xLGkiK19y8YgobXzN+NnxvCe9g7R?=
 =?us-ascii?Q?v36eZC9tHOX1rkVl38cRJmbqUnDfPX1elUgmuQ5abcjn0ZeloMRsWDCOYadI?=
 =?us-ascii?Q?EiGQzOdIPvIJN6rzCsu33TsTkNRisohjCvKMaM/de3sp+Pb3P7G8WZUizk/9?=
 =?us-ascii?Q?zQNKPr/UQy7RYtQVlsod/bnFjiVb9NdW8K8BkIDeCEwAJ7f8U0u8cWHkqHcL?=
 =?us-ascii?Q?l2/x51XffVicbmL9PmoLiMDCdYqcuK7f5gOzSBPfMCVEoU4sTKs6s4HOsrea?=
 =?us-ascii?Q?kJ2p1R3MoZ6Z/O1j6WMGHaAmbo39qxrY+ULbjVQJqwMHBkoCailNIphpJyEC?=
 =?us-ascii?Q?rhOiEP2TXGRDPsg49Q4cVh83oNOYioU7/FWwaffhdanl5pomvxzvh+adXsMm?=
 =?us-ascii?Q?Y7ryu5C7b/aUU4ZcmutJobS8HipQsnPqsHYo1hkI7+AN6MghjwwvkJRQe8b+?=
 =?us-ascii?Q?CYavB96TBMh7I1ss2kbWVNoXDs40rO/v1Z9MW+hWAv8jydc/gd8oFnpkX4VX?=
 =?us-ascii?Q?B/CfHRcPfdn14iyUNu8GcXRKK7bRW9Hlb3+/nMXhsdNuwQWwlAqx6799Br0W?=
 =?us-ascii?Q?qATPwootxiWdMIBVgbEtuH8ODiTinNo4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHk7AXBDCzymxsjcdpnT9Eui2lfZh85NHnyaUetlegvZtifJDLMdh9v/F2HB?=
 =?us-ascii?Q?ajv4gpttF83Lzb9kKrmmCJUBuTcCaJInQ0Qr/AlCyu9oJQkF6B5TDlJzdmxW?=
 =?us-ascii?Q?0sYQKXUwS8oq+s1xdpWjEqF443xpznXCH5Tohypo8IBWv+Invo6UvMj928eL?=
 =?us-ascii?Q?FCXVVPEp1jeep/K0R/GnUJIJjQFQY2GlYWXsSMHmL0mfkby2KKaLGilWraZm?=
 =?us-ascii?Q?YznQbnM2xVcUwrzEQx6V531EJBV2pP+xaNCF0+TKxdteMODFlldiQZujZoqE?=
 =?us-ascii?Q?I8YE2Tzo/QoKWAsUQA9h2NMh6dfKl3NotzMGjH8AFXYYJZVH7aIes3syNGIg?=
 =?us-ascii?Q?bd1h55QFrbb/WtQ4bm+mM4t9XkZqjU4Rm69UcyL3TWh9FjGq3RskoNEmmpGd?=
 =?us-ascii?Q?29sEBCelGNeg2NkARcmm51qZsiSk9e1L7zDJ+f2VgSaLJzpQymSpE6LcqRZs?=
 =?us-ascii?Q?K0JoH9PRQ7LaIPLuoHJmmzdpid74YlwWV3BqV8CM8X69A4CnAa9nj7ukycRQ?=
 =?us-ascii?Q?BjFxyL6Xt/ABCC6RJl8R7YpIu92pn5rgZM1nkJ5lT4T3qNackFBMJE28F69U?=
 =?us-ascii?Q?LiHdPT823Il/S0ukvBwh55DWZqiO9NAZ9ZY/3Ckw0KwQjYqVUY69tnNE1Vay?=
 =?us-ascii?Q?e4R12umOka/vXXstGpn7qe3dfqVcYPJiV5fFwcM4lE2VuvT/vJClCbnHS1KQ?=
 =?us-ascii?Q?AOFhEIHJfZ28iN7xsjKDRobWtugiEtUY495WYeNnjea6QqAq8ZWcnCpcp6e8?=
 =?us-ascii?Q?aR+8vOdGuEZsJkn8bujvevodjLDVbZ7MvB8Vm5FRo1kTdybSM+VmbTeIsW3b?=
 =?us-ascii?Q?Umq4lJgiZ3oDXBr1mtf6T7ScfRmL07ZkEQ2obWbm1Wqoat0CGhTU257vV7FR?=
 =?us-ascii?Q?lLYReibCYNeCr6iGqhjEci7box67MRG0hb0AyYjct1tcRmZN6hUI2hpRGTF2?=
 =?us-ascii?Q?xY/eimfjYQPC+GzqMGg5si6/ZFbVvKIxMYnD1KFBbMKbwUWG1JRoIv58CdnJ?=
 =?us-ascii?Q?1TzAB4XwZFRfZy11vz3dJgpTjEmvPPmUBOqXJGiXSttdmPsVoSORRM3+PH4c?=
 =?us-ascii?Q?D2ouq0OSedDg8xybtRtF7msVwQ4MUDfX6VxZ3ldpoML0o3zVT/Qngo7ow4mi?=
 =?us-ascii?Q?8ljG+2vAhhmOFdtSNQRKWJ5FFEZCRk01iFBnJtA99iGfbGiqsRx4hs2NPGZK?=
 =?us-ascii?Q?WewTaXUSZb+8TEes1AYF215Nj8XlX/O/ACOR8cVvxlD7xkJz0ZOScLGobRaa?=
 =?us-ascii?Q?FQDfK7riqe+d8B4NQCQQZaMlEnDwnXs9CyZw4lC0shVfRWEIUJrTcTfl9+Rp?=
 =?us-ascii?Q?vHpaRqpZ7w+xZcpsTkhdYxW4Ea0Hsd2EhNk9tD5XFZ78EOfLFSwl5AAR6zP6?=
 =?us-ascii?Q?Jw9YOaQezOkNipiqpMP42a+UAJ6kXp69/FN9x3Wv3/g6S4zXc1Jxrdyfv8IQ?=
 =?us-ascii?Q?Zu7FZjsYGBL9S7/iiaN6zIAZBUDOUf9SwbuJeiy2s4UenEjwedqotg1aJkYi?=
 =?us-ascii?Q?YzQeU3qObUyiSp+rlPV77nf9RVATPZ+3yRL+9gs1akKXNUIJyv9ICxNfZHXh?=
 =?us-ascii?Q?lO35lABpr4yoWCtD01KFOJln7QRLNTXeguggTpV8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e925fb-2b2f-4aaf-af3a-08dd524bb57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 07:45:27.6961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WktWlPStnHJlvwxQngjrOEj69LE4fJGIPdDSTpZj5Am3lo4hJyRVniv26Hb0QdLK8ZW+DmyrzMjnqJzpZG5o9iJUuWZ58o1Sw5B7x/FYCdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7991
X-Mailman-Approved-At: Fri, 21 Feb 2025 14:53:04 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Friday, February 21, 2025 3:26 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Tom Rini <trini@kon=
sulko.com>; Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Zamri,=
 Muhammad Hazim Izzat <muhammad.hazim.izzat.zamri@altera.com>; Alif Zakuan =
Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v1] arm: socfpga: soc64: boot_scratch_cold 8 and 9 usage do=
cumentation

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

The boot_scratch_cold register is generally used for passing critical syste=
m info between SPL, U-Boot and Linux.

Documenting the usage of boot_scratch_cold8 and boot_scratch_cold9 sticky r=
egisters for capturing the Uncorrected Errors
(UE) and the UE Address. This is to avoid overlapping usage in the code for=
 S10 and Agilex.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/ar=
ch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 78eff247978..bfc31a14cfe 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -65,7 +65,9 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD6		0x218
 /* store VBAR_EL3 value */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD7		0x21c
+/* store ECC DBE register */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD8		0x220
+/* store ECC DBE address */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD9		0x224
 #define SYSMGR_SOC64_PINSEL0			0x1000
 #define SYSMGR_SOC64_IOCTRL0			0x1130
--
2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
