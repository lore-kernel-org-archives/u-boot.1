Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE6EC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CB482BAF;
	Sat, 24 May 2025 22:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="E0J7cyfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324D882D6C; Sat, 24 May 2025 22:37:53 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EA782B70
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5qBXe0y3wxOkw0ktPJHM1o57Kcfpp3R3aKPcX8AHAC1UpIg6Drpo3HrpjQv19ioi0ZBRmkNRAkX9TUR7m9YM0bhTrtDlBcaRFSxrRXGWh/nMspA2TFrHAfMTktAB6G2aA0tnPVocPdVo4gibVynQARhfVpVIdnhWfrn+iaZ/13fwh7pW8N+OEwU3n7EAycPBH+r1cs8AHncNqFz+ASLZLWsRTUaenaFciDFGgn1Y7IzN+nzyeFFEZaRv2YQ3QDBX5O4GtP5Oy048VaC9fZI573tPZX3aqiG6C/zNOFZatZ8O3EL9B2mUo9UF8PIacFIzsY2FB4NKGlmDc+DiHsG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc+0yGIAgZB0dg9WEQpK5REvjfK9l6lFjbukKBNstA8=;
 b=IorH0f4N54BNQwtu5lGcCb3qE0lR+tBwaTeZML8mF44gcWA+6hAiOqRybF04N4BiLrEzZjz6jCXTs/4V8sHE6CDqZZTyp23UzoIJh462TciUNdeYwgI3/BHo5LvFSVpCw/N1az7CuxCK+Q0PZXZe925JcPCWCWkwArlrhEV1SayakfiaV3ZocPFoZwrXN6Fe7IU+kKPCfTgkTmKvDuSaau5w/dQ4M0FPpJJlChtnlRG4QONlY0IbjTD4jd6TiJ1EPeav3dgwxLdjktk/w+z6dGdZPaezUgD9i1VJzAf/IZzRO989UWr6K+mIK/KAI+ADxA65Fdj8ARhit7Abx3asTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc+0yGIAgZB0dg9WEQpK5REvjfK9l6lFjbukKBNstA8=;
 b=E0J7cyfdQRPVmLVYGPxDToEWm5QFox022wFStMsHiTWl3cUWhPrFwW+EUbXLHHamR36M6wGJMqSlNjB7F+AZj+z8bXQAnrR4LTJzE/MfRvCkS6scO/CaHwjOuTaZKEt+ciT4hR+RGjgOwgL7Foi8UqTPX/BaPyTOZMMWHKNX+qKpdgicZjTCKzKDna1KWBk/MeG4butC/UE88pcwn/lnfkbkzAH6Rl6pkoA3ZYPIDWVTI6+tonn2yVDesnBHlA2SrL5yJjd9goPuu/zMzqdfv0d3MpWr81RirdolUI4PGyrznTs6TZqVTZzomxXBNXi5pzMyckCHHdGJMrQXqUxygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:37:47 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:37:47 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr) command
Date: Sat, 24 May 2025 13:37:32 -0700
Message-Id: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 377fce67-5403-4ea6-8ff2-08dd9b02d77c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4gHacGW0Sz7ZFK2mE3lDl3AyaCr11cC1JXy92qnM/mIG3kwfg1EdMTNDv4rK?=
 =?us-ascii?Q?UGf0bJA9uMmXrBlCXK7HSsgKpnes3pIx+An5vR4XwWoA96Bp7fIdXeO7/PX4?=
 =?us-ascii?Q?HzvoVcPns7favfzejahFvdpWYJujYhmaVYFpE3drCbgXyKgP5jB/h+aV9+oG?=
 =?us-ascii?Q?WocHQ3ahPBa+kT+BpSwIQ4/E2Y451xdMAkJSYHD6s0GhzlfoXSZQentSbiUs?=
 =?us-ascii?Q?SPvKm75cUnmBXM6OGrqnc3hfbBzccm5zS6GP7niA124BNxkPFFFTG1Ne0h5s?=
 =?us-ascii?Q?Rm91+/sxqAPRrCbdjqd9Wo5oBYljqANu7W+0uUa128M0uiV8GMWYn2M9+kpK?=
 =?us-ascii?Q?HjD/wQ9mATw1T+AzOe4xW0avLLGzsfMuNFRxSBivI3znJ1BRIOKPCNssTjfT?=
 =?us-ascii?Q?Q7FFk/GWq/wwg+VVjmilL/0MMLVMOxaC8Q0hFilOoJUm9FyGUngVAgrysxVR?=
 =?us-ascii?Q?HnZZtATNwQyeBzCv7op3dp+79tSiuOOVPpPzliKWC4KNnT4qXg56uRY0fNvj?=
 =?us-ascii?Q?qssHtl+cGMRIJGg8WKGvZCQd+k7v0HualobhGhzjCXWzoF3PdM5/hgc/61dZ?=
 =?us-ascii?Q?BGKeenMTIsHfTQAy0ursd7CrABG5ZhoZUnAI2unevQifPxhVy6HbHVEtKuwk?=
 =?us-ascii?Q?sa8ahUv0w+XVDitvADmWOR18BulDh9Rhhlp7kt5J19xEG+Nt7PS3/eqafSwD?=
 =?us-ascii?Q?6IfhZz/JEmFXQAqnPoWTVf5aiXvHgdhlQnLCCqilYjVIlrDZw/1EN7dPiPUW?=
 =?us-ascii?Q?97fjve9rK/AAsO8+m6A8IxCzcZj9/v3qqCOVwRFlZxLexgxm2y9OlivDjVu1?=
 =?us-ascii?Q?2er3rHVIiD+sal6T+Ad/+Zz3MqeEc7T/ZX1GxTh5MzGbDpzoLkYQNL4u3U1y?=
 =?us-ascii?Q?TRTgYm6yilXobWezLBeUKxiYOfil4+BG1Nh+yZbpNObSfsmYUU8GcAU2Bmy6?=
 =?us-ascii?Q?fDTSmqEbJNC6/RnrhAhT1IIZjnSKCbBJuJUbbUHeAslchLVaX1gyT7Os8Z26?=
 =?us-ascii?Q?njAaYpt4c/7WNOWNZQZoXFNGgn7BnCQlFjfk/n7qmJOul4uRzv6dS+cY7nQU?=
 =?us-ascii?Q?hbs+36SEPJWJ9AfX/eo/oWmP8U1N9YccCFt0navkEqok7n2G1JFhykcA5Xv5?=
 =?us-ascii?Q?WcZ/CVIzNzoDraMjq8XoJH5jZaYoIsswS96+cO7mB7Y82KPlDdFWykNva1p1?=
 =?us-ascii?Q?Vszh1tulnmJgLCAGIe7rtZncQ5WOt54t6w9+jBpo3SL/3/AitxWA/KdQnX5Y?=
 =?us-ascii?Q?xewUuaT5uuKZSeBHAEo/qA64/HeUcJoPfMZfI14ZF5XH2ZPYXMcicdAp1o/U?=
 =?us-ascii?Q?lluvSIYAnujwH3ATDHvXrgV9ONtRlXAikYjkkdds2P/SZidTHEOVYGrzas9J?=
 =?us-ascii?Q?9VhiMbcbtWOLBk9SHO3TOsG1GZkFzgG3An4pOdU9zzBVXHNl1kLhp+7VF2tM?=
 =?us-ascii?Q?cFX4VGMDAS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgvzuTTSWhIyzsHOkno1uUW66FPlxp9QoBISRUyhz+BSaSEsbx3QT9fsjWs5?=
 =?us-ascii?Q?1EER/rt3cxR5wdK6QjP0qgIP6UGj4AqRmCyXzx05aSLNAFXtNb6sZQs1EgP6?=
 =?us-ascii?Q?metJMWVk+4U3cKI3w8oCJG6U7D17A/BZGDtkGevdmMxGOeriL5l2aCSkQ2H9?=
 =?us-ascii?Q?0CKhAPKLcG9XLjESvz3S150greflsQSTin1L6D78zFRdALhj7jsSvF34obHi?=
 =?us-ascii?Q?+qxIP8LUVgr3FNBzNlZb1MPBl39m6Ya+vtOB4wf3y1iyE6OxGlWsRYRnKNp5?=
 =?us-ascii?Q?QcjP1auYBPj8NBhMAYJdF3BExeiA2dSZChFbSTQ6be+1WEBKeU1GdZfNzlgl?=
 =?us-ascii?Q?jv7UCiVctN+tDpqmPHn4BCjHLOQtEsgVsnbsOLuAsNJEbLVVd1dtNygyO/LD?=
 =?us-ascii?Q?mPg+V7SkoX3/xXI5ToKA8lO69JniADfeMjYYGDbzLzJANnY+qeSuXCyQZ/Xi?=
 =?us-ascii?Q?Vz9JcV8Y0ieAzSz7WGJraRkYMiymCrC+0WH0SaUlTS4qGGanrmnZ91JkEOJS?=
 =?us-ascii?Q?iSW7n3ZK1/T2ikmvAb56CmiEEXm1TFcleJ7ZL4nUT/xiQclMOLZSVqy+y/dI?=
 =?us-ascii?Q?F/JUuNH8Cu+/BkDc+5U6Hw2TkAKDBW+a0zvh2vVME8Ruju7gvk1J1jVx+vtG?=
 =?us-ascii?Q?6h8vIWiHAsa6h0HiKPsadfiH+1EjWiTGetoBOPVVkqo5OzKAlRDnOTf5RXCn?=
 =?us-ascii?Q?o29MLayMYx/YStxaTcGpy7MUfJfJ4XYXFW9o6l/75UkMQzT8WclrJzHIWdS7?=
 =?us-ascii?Q?3pq08mH30OfyOdabnJF3OP+GMukr+rZ7usdSPHX7DSh/dyhCvw7IWstKqtC7?=
 =?us-ascii?Q?llHJknhHtr7wtsAteiJWKYuO/x3VEHd+vT/MhgP7jfNh/Cj3nMjnPNgzPPlS?=
 =?us-ascii?Q?jkd8+NiypsXig3sUPd6RLYQuVy3Z5XjuwD84MuBXew0/9shGgQnBFfgCuAy8?=
 =?us-ascii?Q?rT1X5riOjZpk1cVjA16P8dfaAuv2Tr4D2QJSZGttYiLRvalKO3GEe1z1oeTx?=
 =?us-ascii?Q?LhqzQkyXjZocGYSkcGDlUGoqABsky1qAYNVbv04CdZcpiSf2HRMQKx/g1D/T?=
 =?us-ascii?Q?D5titrADGKlIxqhOcEflI6umgPQIyp1IoknNTiXWTmekpaehSCppDtAAcjn7?=
 =?us-ascii?Q?C29uKan5gEO7gnGhRd0c5/L6puL+fnCbNyWVPcbvISGkwGiaHB4UzTKsd9p/?=
 =?us-ascii?Q?mxpKt1U/f+IMVoEkL6ly+IuNLxHk+7wXV9L5/GV77OLzQvOhOlovTKms4FvS?=
 =?us-ascii?Q?17aV1WBzMA5aDHTSumXVr2/Sbx9b5TX5JVwurJPVPEe1tXwfWR4uxe3Ah5j+?=
 =?us-ascii?Q?U4NwGS8s8M0+r1eGIdnH3JExvuhmJMh8vLXYuaWUOX9PpBHouKrnawUjjyse?=
 =?us-ascii?Q?TFoDlznXZAzuHNn01XPJ4mJWAOpzuTqirSIT7pgg10dwvA1ItUCujMvmiSEF?=
 =?us-ascii?Q?+XMicohhfEfFwGhFL0l3Efr4AeUEo8Ag143Q0RRysQyfgeau3zzsp3FI8DA8?=
 =?us-ascii?Q?5tQr8tCdUCCpayXvWioZCpbv6XHHF+o3kxwapkhyvXc4GGdBP8qJOZq4QoTq?=
 =?us-ascii?Q?lwwof39VePe2mdfSK8J5yMnF/iQwalr4Ja4K5Bf2xCjSIT3Y3Ck8fEqXe9JC?=
 =?us-ascii?Q?WFDmNqYTe35EsFW346tWfBE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377fce67-5403-4ea6-8ff2-08dd9b02d77c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:37:47.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snZzcOhbcjNnHbv6YZIHh6HOZJJd0EcKfRD4fkVyxxRUWbxoO3yGb6KIlFvbVEhEWHHVVfybYEyLDwqsM3i7MnfRqUJN4G5cF+op39d+gDJamy7YmvXxr+mC4lHLqkLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Partial Reconfiguration (pr) FPGA command is added to U-Boot console.
The "fpga pr" command supports multiple regions for partial
reconfiguration by specifying the region number. The implementation
of the command is specific to the underlying FPGA device.

In case of Altera, it is used to freeze the specified partial
reconfiguration region, then user loading the reconfiguration image
followed by unfreezing of the region.

Test set currently can't be added as the command is implementation
specific. It involves opening of FPGA bridges and loading of external
images during run time. Currently, existing FPGA commands don't
have any tests/sandbox environment. The design is being worked on,
but would take some more time to share and get the community
feedback. 

Changes in v2:
- Change the command implementation to generic FPGA command
- Add usage documentation for the command
- Correct "_" with "-" in alias name in Altera dts files
- Add FPGA partial reconfiguration support for Altera devices
- Address minor comments in v1

Naresh Kumar Ravulapalli (5):
  drivers: fpga: Add generic partial reconfiguration support
  cmd: Add partial reconfiguration command
  doc: usage: cmd: Add documentation for fpga pr command
  arch: arm: dts: Correct alias name for Altera SoCs
  drivers: fpga: Add partial reconfig support for Altera SoCs

 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   2 +-
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   3 +-
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   |   3 +-
 cmd/Kconfig                                   |   8 +
 cmd/fpga.c                                    |  38 ++++
 doc/usage/cmd/fpga.rst                        |  65 +++++++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/altera.c                         | 163 ++++++++++++++++++
 drivers/fpga/fpga.c                           |  37 ++++
 include/altera.h                              |   7 +
 include/fpga.h                                |   3 +
 11 files changed, 333 insertions(+), 3 deletions(-)
 create mode 100644 doc/usage/cmd/fpga.rst

-- 
2.35.3

