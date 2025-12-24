Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C8AE7544B
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 13:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC7718423C;
	Wed, 24 Dec 2025 14:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X/dewRb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BD6841CF; Wed, 24 Dec 2025 07:27:57 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3104184198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 07:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBcFoVcxM4VVBo8F5fl+K/QJcFRSgjHQ9171bM3j2PoQG2bmZ5ErtC9WSLbX9mBY4vrUcsWfrThwPJ4V7VJC8ETVHU5axnX0L+0XvryYaYM7534ScMj0NPBTY9boUhNoJF1XpCjALRjRqGRvtKWk8lBww9oWWn/Iuu1VDxlskvHEGlETpd/pJhzV/4eCELSJ2RqGfUEk7sqyU6f+ZipYNqHCJr3/LUxbNT1o+lhU4NADbdscWv1oTRxJ5NTa9MPiBNQzhfGzUuVahDaTGJBPRIqzZHLMMjZaCyFK8K7FJ3CpVN1j0148OUTfrKiss9hxDhpC/alkSnzd4TKr5jdrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weRlhHJdSO5ztVfwH5UyO2xMf7aswKK/ZmpDrdGNo/o=;
 b=jK5E4RhTRWDD3YZad62kVxDzQvJ/GOzWEhNkeYVkNxzCDgB16atXYfDvDeQq+vAZ7rUN5zu+9f5ZWhCqO+++NDPZNykzIqxf/ZtUPGByd3Su1NfewBPTo21snRPdw9dOb46dgPCZOW6vWpcHO3LW91NnK0QVyp/KDj0IwyyxeJnn15SP9Frte3jZyrzoMa3tCoL1QuBJaUSbbOI/cJskgBQhVXXdrs3b4eVyPsBgno1RNq2W4dO14e/+xso/+AUz+n8eNZo4rxx2I5r1kma0u1xaw0zO2olqTxkKMQDSURebtxgce5GcHxLLsF6KnWYe/x/zG/MYp3/o3ZdyA8VdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weRlhHJdSO5ztVfwH5UyO2xMf7aswKK/ZmpDrdGNo/o=;
 b=X/dewRb/KGR7nRMsz4veUSuKW0jokxSSIExCSNhvwBR2ELiqmjYfGfi1FngV2GFGgWoz1Unebe2LCXP5rzNKJHxuSgOVsJRqFpYBWyEJ2/xbrRtMai+z5DVbrmQGadGgS6F3JLpbDMxM3YtHMaNJeZAoMF9wxT7LwjS4vAISjhb6s2X0mLqro7SUu+qn1fAztK3UxeynVmHvpWjrTUVF3Qm0b99ZhxU7d/JzYbFLWHDSENFicGELw40QKgcoBU1HHkrs2HxZWDr+uy1lQGbnwlCUR7iAGzebaiZ9NjT1LDF5cAxk01hLJJaCTgJ0idhFY/Yuf2TuMTGhQo2VB95/sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:27:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 06:27:51 +0000
Date: Wed, 24 Dec 2025 15:41:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 quentin.schulz@cherry.de, peng.fan@nxp.com
Subject: [GIT PULL] please pull mmc-power-next-2025-12-24
Message-ID: <aUuZKcBaddeEk5ov@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9899b955-05c8-4046-0822-08de42b59072
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YmLieK+e9s2NfR9EN9VtFHMkovfugr3i+hYthL79K9AHo4WnVvV8Fn3LNzfs?=
 =?us-ascii?Q?yYJj7ViSamLidAn0VUEud8BKfHlnNOR9CKPXmByV1ONk6u3Zf5sxOvP8L5Ge?=
 =?us-ascii?Q?2r9ACuGjid1ZLKcl1j7gdX/dryjYs8k9TnPyAZo8uiuj7PovBsX0WMv+4qen?=
 =?us-ascii?Q?6dEnrUCpdqo3Tt70i764eL+jEr+WByHaYYaiuSQk0aEaVFfrf+XF1lxevuC5?=
 =?us-ascii?Q?+HHPJYkgzZVmCK9AU8b7es9GOEnUE6lcbdLf01qQ/GWgPpwuNtYnyeXAI/eV?=
 =?us-ascii?Q?VVXqI8DSgSLFFf+U5yisrElrdWXnd5RF6ABP5YCwLIUa+Gq6xnMvvxHOoqtf?=
 =?us-ascii?Q?N+kv/ai8J1pkTVBO33iHnSgAK9T8zXVHR0XK/t+LWuV1ed3HHU8X2KmsWpDR?=
 =?us-ascii?Q?ZYi/Fr8nKSfmOWyJPBporG2DDPiai5yawR8hsFZl4cWSXB7AcPKcVOn0kG8f?=
 =?us-ascii?Q?cq+MBwYGpnjggOyOZdZPdqA1OQH+08XF3SIE0JN5gPqQBUr4bNyQlieiAYEu?=
 =?us-ascii?Q?ARACzJ++na1LGxttGfMrzqek6DZNX0adb/zTmPWz4EVbWn8jCKktf0bZjGoi?=
 =?us-ascii?Q?rsiq5lzb2nWSqRmXKoQbwRyXJFNRUBTosD26NF/VN3Tm8Gd7rFOPThfZU7KT?=
 =?us-ascii?Q?ML/Giye4D6z/T57UhfnzPCmD8e2JQYc/9bAtw6Z3lP1r5cDuY40tvy+JqPP1?=
 =?us-ascii?Q?+kDjk4zRGaeE0cLP326JeZg63OShZFFCjcidJAJJ81JTIHrPqQuNwo0QwrMa?=
 =?us-ascii?Q?Z7ZM1MIGrTKToVwUY4FGGRJzFkdCeDvS9ZwqCK5MJABraqdJtI9EhrzyyPGK?=
 =?us-ascii?Q?onhEqvgIgQwHO1cH6HJuofZkIV35T+Wr964oW7S/l/5c07dSV4pNx6lwNCtQ?=
 =?us-ascii?Q?8UurmnagofcYX7643RNqdkqtSyyw/NkpDoROWkxZLy6kCJmAJkKY6mO30DTa?=
 =?us-ascii?Q?/5fmpOfPxLBdBEoj7E9UFw57/4fbD+82h+7ehupZhwEuWATLnkmAwaXyhN8L?=
 =?us-ascii?Q?BdRz0k0H8jJ1IFgvop65B5Eg6ZPdWqp6QTPYE85WitYjWOSObSWYC124phim?=
 =?us-ascii?Q?NQ61Cqk8LK+Pi5niknC145vF4bCnA8tZiI/ALpUwgl47tF627mLlJ0k0Nxqs?=
 =?us-ascii?Q?yBEFFIuOJlUtdMIC5r/alND6UR+P6d69+NSf+ovs4xGzX3nIZWFot3eLCp4U?=
 =?us-ascii?Q?G0jkUy/CoW2o6BXO3JTxzDfFUI/nW0LKfGEM9AY6ohyNhZoSls50nYxhxL1x?=
 =?us-ascii?Q?IZOrsHvOMpcGUIutHNWbOoERL8g1QZzoDW6sGnO9OkuM77RmrY8z6f2JiCcA?=
 =?us-ascii?Q?ATAqp3fAi9ueRhd46+EEg+uyGBrDJSX6UPAcpwwUm0mM3uWr/4K3QQWi8CyR?=
 =?us-ascii?Q?3WijWlEbILWIQFCfbhmaYcR0SWxUeyU67jZbMBpJoeEM7lZPAjww+Ftz4f+T?=
 =?us-ascii?Q?8rQP36UFexCf7fI6QXPqDv2ssa5llRHa3VA0Hwgg2dpgPD0U3jsINRJRzOLa?=
 =?us-ascii?Q?nmuSd+QqDOgG/WON7pQ//B0AOgNcppJC9e51?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zORrvdcm0y0QGyvjsCNdO3+3pZaX9kvj3GvCvtVKo46Z1u1QPu8mDBvI2aEH?=
 =?us-ascii?Q?1HcNKBlKtOG0JaIEZrYiixSSAiBsQec3wT504EqliLQ3dPpm448924NeSahY?=
 =?us-ascii?Q?X2TmQq/vIlIVN7OMASMzaqMc2MrJOr4BrfAEVGhYVxUvI82G2dsJvgm45BCq?=
 =?us-ascii?Q?eANhhG8HKbLiQZzUlc4e/Dlu9CG2mXyUTa3aqVMiTnJrdCbJ/IpS69R5j+8z?=
 =?us-ascii?Q?BJTZtCsQKtwnUlxe7DPw+oIdX50uhqpgJInPsLpv55ZZrenIUgNrMng214Dj?=
 =?us-ascii?Q?Ja/5Vivlz7pGyRvLqF3YgG09GDdRnnLMfo3i7CB2BVnhPuO7CDFK/w1B2d62?=
 =?us-ascii?Q?sLb8LKMWoSFoMC5aWAm80LpSX9KdEBBlPbEOKLrRxngyNvxewRck1d277zUU?=
 =?us-ascii?Q?oRky6xPMELwAxzd52CiVYFVPg/DI4ql5gBrpLAr8/vdZOwX4ldQCgPEBFIWW?=
 =?us-ascii?Q?5w8VEcA+a14vfs0yfEeWma2AEJnLBhh27q6hKxSm1FFR6PLdCmqGTiivvWzn?=
 =?us-ascii?Q?PgHQN0Q4iZ+DRzaR/dHGQvUuzCdlsJW5RShmZBkgSFKVqhzNs6JwuBDV5GKO?=
 =?us-ascii?Q?ZLj+vnXlcabk79gD/RJIZO4nSAuECklKACdvtrys4EjM02my3/UwS/Qm6ZFS?=
 =?us-ascii?Q?FcPjD+Gix6HMUMCbccvIQQCbbdeGZHP59ibIsZUWBFgfHqiRlW7CgMhrWXQy?=
 =?us-ascii?Q?CMgwkt33nPQzWeXeeAc95a2neV+AIq+jDQYI5g5rqbA2eUPpYgdOONNCf83M?=
 =?us-ascii?Q?2FXJ8Gb4ilBXSq/2wVXxgxto9OA/N5HbPz/s6Y8ZY++yh5rIN5H/gtzMsxnA?=
 =?us-ascii?Q?v9Mjr8mbBcCwCznrapQ7cloZGl/xCmSquYC3KDPAuYWGUFuXQ/bD1Mmasy+O?=
 =?us-ascii?Q?Bvicog/TBBlE2AALO6wbk0DzJUNmyyo4Ecb5h/SRxWwKum2vxfUFqCXyr9HJ?=
 =?us-ascii?Q?eoXDRKZn1jLaHL2wU21PRrPXjj0ifY5MHJqf6nNizar+uvfP7z1tyNKi/Uj0?=
 =?us-ascii?Q?YCluMjGZwRaIhiURq91+LflzwXqErgGn6xd3LY7J2TUf9Nsps/hB78Vzci7r?=
 =?us-ascii?Q?n8Bph7O/QGK9LAUep3f0bJPJsFdpPCjtUNrCgEa4TNbc/jh4ui22UhBatXRO?=
 =?us-ascii?Q?ILe1Xz0CISut/K4+uS7588UbYZlyPoBlUH6xbcTUTgXJDcKdqrH2eZlTo+3e?=
 =?us-ascii?Q?2war8VwUNiTxTmrDAOE89akJNmY98SucR9aNV7FrNO6TSQMxqJM6wL17fRkZ?=
 =?us-ascii?Q?z90lldhJUomqgVEDqPqtO7T9eXHJI8gogBDyX5MQklPS7QHvei0gczqWoaxy?=
 =?us-ascii?Q?A0g3k7git3APXBoqw2Wa89e8lL98u7YoHAH6gHP7vqtcEZ0AFUcoWC4c3rxI?=
 =?us-ascii?Q?0KUMn2aHPNhjujJ0nljqFtPKLl9CzWaP5b+oul9l7CIZiBLvQ/jN9r/Ytp9/?=
 =?us-ascii?Q?oVGpqW778yTZRlPDhVZ0Cisq/H4DIVVhSonUJJIdKRc1VuKsJ7+x6b67KNzD?=
 =?us-ascii?Q?g9R995EsD+yS/tygHv1+vsltyaKxKuwHwFp9yS88E0OEvsva8OidXtJSveWQ?=
 =?us-ascii?Q?wy8GPN5uVXQSkBE3MJUEdk2j1OSuAZ4UImv56QRlc/TiHsLaUeEbLTYVQeTQ?=
 =?us-ascii?Q?kczgfVO8Ufv6/NfXlU+p0eGZSyUIMJV8JMuAKLU8jcXXaQnow4swOtxoW3qa?=
 =?us-ascii?Q?qfcGcpdKzfLRnmx7GjOjajhyPMWC6gGG3n5zIBQjDGi9mCFYWpQBp5giM9xB?=
 =?us-ascii?Q?rgUlVMWtnw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9899b955-05c8-4046-0822-08de42b59072
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:27:51.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VcgRMhpzlF7P8Qs2JbVOs8Xj5GlbnvD9ASxL6kZ89IHSMr3jtWQvAge/3f88z6qCcXYCmzrVZG8eEoe/RC38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6991
X-Mailman-Approved-At: Wed, 24 Dec 2025 14:10:46 +0100
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

Hi Tom,

Please pull mmc-power-next-2025-12-24 for next

------------------------------------------------------
Various Kconfig prompt fixes for SPL from Quentin
SPL_DM_REGULATOR_GPIO and REGULATOR_PWM dependency fix
------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28831

Thanks,
Peng

The following changes since commit baf076aeb32dcdd2b022405088c3288ffc160fcf:

  Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next (2025-12-23 08:11:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-next-2025-12-24

for you to fetch changes up to 3f495781dd06007eeaba61fec9f71908fa491ec9:

  power: regulator: Fix dependency of SPL_DM_REGULATOR_GPIO (2025-12-24 12:06:46 +0800)

----------------------------------------------------------------
Peng Fan (1):
      power: regulator: Fix dependency of SPL_DM_REGULATOR_GPIO

Quentin Schulz (8):
      Kconfig: put TPL_OPTIMIZE_INLINING next to SPL_OPTIMIZE_INLINING
      boot: fix prompt for SPL_LOAD_FIT_ADDRESS
      boot: fix prompt for SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
      boot: fix prompt for VPL_LOAD_FIT_FULL
      boot: specify VPL_FIT_FULL_CHECK applies to VPL
      spl: fix prompt for SPL_BOOTROM_SUPPORT
      power: regulator: fix dependency for REGULATOR_PWM
      power: regulator: remove SPL_REGULATOR_PWM due to unmeetable SPL_DM_PWM dependency

 Kconfig                         | 18 +++++++++---------
 boot/Kconfig                    | 16 ++++++++--------
 common/spl/Kconfig              |  2 +-
 drivers/power/regulator/Kconfig | 11 ++---------
 4 files changed, 20 insertions(+), 27 deletions(-)
