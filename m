Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00543C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1D9882D6;
	Sat,  6 Jul 2024 15:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="iGLRhkQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F321B889DF; Fri,  5 Jul 2024 22:30:14 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6904C889D4
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Lh1LksJZjq2ByTMCG4FSHe1SyiUPllRDnfh//Wx7dGtjUwJWGmyQOx2/NXX0/k7cGc42oUXXbhKAsrHVefzBk6dYxEQjPBV/ftWVWFJlvkD79mdfEJIiyNBgT9tHTrECojQ0zJL476h2nRSZ1zykiWNETQLjYg+2x//fVmVJaGS2RMxaqetTIlZpJiykAFn/ltxp7POzQSqEiAeB4h1j0yIe+e19/8DvunZPQ0navVsPiGORJaW4gTSS21VCApiP7OwG8k7A8rWOOkBroix7He/nn+inZsaOKfKaXyx5U/4vKz/ePzSzcPD7GqUi7R28Mk0urZZSgVep6/DmBPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qc6iVG0ZVYdQBkfXHm8paw4pCtJ0EzJPCPm3aN+FfQ=;
 b=is4OrwWfM4Q9AfHrnw+BGsgQFsTI+7zDtxGdd9ry5TovD0BQwVMLju0Tp7mYpmxDYce2c4LiF1Str3oolqKO1ggUzDvDWKvEBIu26ZS77Bqj2yDiD0T7b9Kjlrs3lIDnwb52KfXDe/mzP1yt6GrjyzFFiWxBuH+S7OWt6zYsJw4NRKMdULzTZ200jV2BnmExJE5jKmNo7bH3SIWp1/H/2//RsrqtkwqzVnQFME6JNxLMkAit/6IT9X8ogICmiMb7PMwVBZRseNjHtVM39cac9gy32i3XP2dNxJx/EHfdAoTsoHR5eLGtfySKAnAPia5RicHvE+0qqSG6EmdKZoXIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qc6iVG0ZVYdQBkfXHm8paw4pCtJ0EzJPCPm3aN+FfQ=;
 b=iGLRhkQkxSwIptNymIrxjMt0ENMvmzHFlyrljhVapw/hW71oEY4tS8K1atC/fvfrvQ9IqSC6hW0ITlYR/r58RqaM6bOCd+FQ5AQVggIbMQwry9hnvxWxqqiM8l81eUCOoBzTqCuBBBx+3UDliVeQpZeeOASCc51z1X2H6upw/Vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 20:30:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>
Subject: [PATCH 1/5] arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
Date: Fri,  5 Jul 2024 22:29:50 +0200
Message-ID: <20240705202954.1149590-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ca74d0-35e4-4212-4d20-08dc9d3141df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MHjAHMsrditFHdeOMUR55gI0l8OeDAA/FNM/2kqdHofhR4jod7vPxz/e0ymI?=
 =?us-ascii?Q?RNwRUO8xTUaWQolje+W4uov01nZMlael95WmuEnt2UyzEB4cNHa5YrFqqvhO?=
 =?us-ascii?Q?8H/0eAbcwYWEj9eCztSjP67TJjVekqz6Roi5SOH0yB1ycyZa+bZdzWD4H+Gu?=
 =?us-ascii?Q?ipCDmcGsDszNzI6bi9zx9FzLj79axXrxyTEl0IM1RNoHUjfBJopS2WvAPDla?=
 =?us-ascii?Q?hBemJiDEtejlMc5OcEPpg/BTdcJZuoZSMKKjz+n+Gdpoj9buu8S6JhD6pN99?=
 =?us-ascii?Q?MKVCwFBfX7ifAvZEy7F1rY1ffUAETibx7m3F9pCQJNOXqzb1NlJBG2E2/5PI?=
 =?us-ascii?Q?iL92yMDUJGDaMenzgXp84MsQrVm7ITLfvCS394S9rEkbmKWkI5VG9OLt3C5a?=
 =?us-ascii?Q?/zDSGf0Gn/ZsWq/EgIn/8tKPt+jK0xgOgljdA1sGecJmEc/c8l2wyaa7I9Ld?=
 =?us-ascii?Q?ZwDD972gJvigm0ikHvP/eHP1VfeLvT0zWYHPVnCbOY9adGOF48K3OzjVSZo5?=
 =?us-ascii?Q?zKqLWCwTTGxC9F5I+hHBjieTvppiCf3VEu5ayB9egK5ORRWe/ncYaj21GKZw?=
 =?us-ascii?Q?2WTIJE4mYrp5sWTWHvwvOuZ3sRjrdXbGHiAv7dgTaI4ioHPOPwB04nDFRWXf?=
 =?us-ascii?Q?AQ6hEwHzzaKj6Bik0pE8XRa46uJdHhzsGxgTz6VC4RfIRTUYyt73HGTl5exX?=
 =?us-ascii?Q?CSbt2PY4gUwl1YXHFol8hITMnc+VvtiFW/Iq+CEtJlNO2Z4DW11UiKK5w77E?=
 =?us-ascii?Q?M2q+71MJEjPzUp//ThUdqDJI9lGd2OAYr9ghOElPmX4uLTkJrPaRMI5FtNDg?=
 =?us-ascii?Q?KiptaaU/O18Gqp0iVDe0fw/tB7+0cd8bntl5bQqaeGLPVJybS8jQv7ReX8GT?=
 =?us-ascii?Q?wfA6HeelO+HOVTjOXIl1cEn7oOTjWr1GHRj/pcwKjDseNQM5Yc8Tv9nM7duu?=
 =?us-ascii?Q?aWIVjv/j4IfSpYe27QfJFcoPRXweL8KNqq8ujHQUscM/eokGN2onyr6zHR58?=
 =?us-ascii?Q?DTxCYHXMeUC0nnPEIVJWkJujx4OLfown5Cpl5dy/EvbzsJGB9cCAYwp4rUlC?=
 =?us-ascii?Q?yT//U3G7aDNcN0GWuOYkGXd+/fRYVFWuHSl9vo6N7RuJFVjaPrIR6AwFrqkU?=
 =?us-ascii?Q?iKYRwFidopEhj8P9uQ5EjFjRrn9vQDSRFo7/4li143EPm8hg04TrNiczhyXl?=
 =?us-ascii?Q?YAoqQbEUrOibeU6ba13DERBh8e4AjfB+pi4Q5GCaY1hdC59ZLLUf4N9zN0B+?=
 =?us-ascii?Q?WpgAEzw7Jn8jpgSBLHLg0yFdBw5e1SN1sNb3bzHYLz6PYDFFFaFhKmnBtfuR?=
 =?us-ascii?Q?lg3mDTL5/XhqFTf5tiyCsapgWG9PJxWhpTuKGzXuJ60+MsE+ldiXRUDYvjE/?=
 =?us-ascii?Q?TxCyKYkxjUtTOE0msWd3SBIB0vV58OZ4GOB0tTAA1o1ZS6kO0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaSo0b+WHwPtMttmwf/Aoe+ViqTMByCYBr7ZwDu3etzy9AvdOKr0SqRbhhgi?=
 =?us-ascii?Q?mEBFfItK+WBAYtugZEncwQtHcj0xoKYtCjYU3qVXf0EbLt61JfgyfIywmFsV?=
 =?us-ascii?Q?jTv72UvmEJw4AOMNef2EeOs0unSHKcSQai1EYgt41KpxMvcl2gJepY9q1qDA?=
 =?us-ascii?Q?kLJq6X4lT6xChLBT/hI7C0W5Jno7q0LdCH66UBZfznabAOrexltiagShE/9R?=
 =?us-ascii?Q?hrHbdtHnbmBos7NfgdXis4oYacv9A6dx3xkps9IyBSKwg/FZ2WNvg23hW1/+?=
 =?us-ascii?Q?cI1eo1tBXjGsQbbMnTkx9ol7zqXBxa5oYZnq4/ckaYb2RkgqiRvsv2VTiLEr?=
 =?us-ascii?Q?6Bi/dwXir+0f54WXwkAN6gZn7Ye/+cLxMH1kY+7oKZ8FCIBSFUHJCnD8mjWw?=
 =?us-ascii?Q?/GwSpYIaxryzbH60M95n/OW0u6Y6k67rGvBI86JcRWpcJtG5UHFXRETqrXu1?=
 =?us-ascii?Q?Ys/D9QkhyrTodNv9aocsmVheqMhvRVYJFJBm06IY2O4vvhmJznC8VAu87RNl?=
 =?us-ascii?Q?+HXRgTbaWgtgd7PhHTUU2G+CTG0RZrWtPxM9SqBrH4BPA08EPkA5eg7lIMfL?=
 =?us-ascii?Q?MxO5aZSFBjETvTFYLLGegCzbM34EoVyvPsLZ/JmQrfPpEOHwWp88kH6JlGSU?=
 =?us-ascii?Q?T6FCFHyRYVevrMExpn5BLV4GyeRWHRihEuARu4wFKR+RRvlk9cPfMKMKqW1m?=
 =?us-ascii?Q?WkQr3IyLNPiivdkOlzJewMg13FKqJniYw7bzjZXNrLb8Pnae/PLQUuto/9xz?=
 =?us-ascii?Q?NCHJLfiKEAubc30qjlh+CbMdg9MoYHR03HGVMzvIVhv+MtnoUJjJecI2PLPu?=
 =?us-ascii?Q?BYElXpfs0cEEBxHRDVZOkv0TL6PQQuVK2+uKPa7N93BD++OVcUx0qMF2lIFp?=
 =?us-ascii?Q?HKtAReidg/ZnPKoPVTssg+rZ9vZRXIXS7q6C0SHRbTjaTJkkVTQ7CcVI4qTn?=
 =?us-ascii?Q?m/dtiwGHccphO3ls9faeJsQNLK7sd1j2J0iZ8/czBqEIHH0zqNe7Oh6O5RV4?=
 =?us-ascii?Q?5G+OQIcYoEYyHE0n+d852ljC04BfnoxFuM1bpMAoM2kyJIzNUKX2rhfUv9bo?=
 =?us-ascii?Q?YpXInbB5eMVaVLbsguRIwbMws6jZZDA043a+a+IuGEtKHGaJKhuoDvWm8aOd?=
 =?us-ascii?Q?Omkg3nqjjOx40PoXSDcPj660KOpn5Bbghr5pxQHbnkKNeU+Pg1r1Y6B3y463?=
 =?us-ascii?Q?GCMxYrY8hqXlLsFYawH9XLKoMFK8wRbLYw0VnXr7w/mStcVtZmJ4BhZn8vHs?=
 =?us-ascii?Q?L5buDjuV972opI3pETs31jVeaIC92vWNXR8ixoCFMPk8Ql1KH5+BH48IrXH2?=
 =?us-ascii?Q?DuDxA/xqY3F3rnqdAsWIwfRoxzRcFDIQKBQ6Xgoc5nn52Qir1g4ZMalJqkkn?=
 =?us-ascii?Q?WuiE3Z0FL3Vj5shSsQ3zRvUgX3KFY21lz5qAagJONC3zz2R+DylywMc/GaNx?=
 =?us-ascii?Q?zXZP6wzZXy0rywloyNC4M7nYTQhGqnYFkZI1gAA/0Gr0HBbE4uj2NFk3bYCD?=
 =?us-ascii?Q?RoqS0dXV4ydFOMK9iQ0OEcp4u1JbnM/fJaUev7LK6JHw4Tf3K6Ua6eWnSUgp?=
 =?us-ascii?Q?NjdCOfRz4GvwtwFMdDpuAPpwgwEF98HHm5RMhyFIocHohiZQGmDy15T0Thjq?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca74d0-35e4-4212-4d20-08dc9d3141df
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:06.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPoCO74wdHksqTrNRM2aeyytT8GYw/xdtNgsHz4KMW2uGrF00w9VvEIMaq9vLwE3qHoflgKqFV/uVdDyTUTO3zS+vXaXtOKecl35k2JbEKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6307
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 ...rlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} | 0
 ...3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} | 0
 ...rlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} | 0
 ...om-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
rename to arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
rename to arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
rename to arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
rename to arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
-- 
2.45.2

