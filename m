Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E567CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0C1848D8;
	Wed, 10 Jun 2026 03:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XcXtABWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7D3848D8; Wed, 10 Jun 2026 03:50:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D431848D7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hro3ELuF5mRfaMcdqNmrVpT0Cv76WEatbQdQgIjPAzv+7i1yCLtcaBKvZHfdFa1DNNVPTwgLM904IQulsza3KVDCx70b3y2ORoZmV+VO3GrvU49UaFt3kxrAaoNTH9YOrOdYdUacKGlzzLZtgrx9PVO4GWIZ3oy1HAzHNsfwfIhmEzGn1s0d0Y5WWSJWIK4/cM6QwP5E+jCBNuSqU2L1k3QT68arln+lqFQhNUUR1XMA6p6bkEzY8lMAe+D7/UX7Aac9GiSBP/k5yKidL5YoknuwXvckHxUkbcPOS9Qr/Yeu8Fh9XoHs4BrZSa4wmFIzixW3/U2M8K3mWjcQcPbBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgEX4fqHYy9aFmYJvTbfduVe1tdNj0XStV9S3Bx6Fto=;
 b=m91nlUdfDnkx8EAQMFfKJ3E25unLdFJYSwZP1JEdapibGGnOHRppPD4KnOQustNF4QUXHtFPgnNxZvwKf8hLsd/mJsjF4sr6FH1YemMJrH9/H+9MJOMYn1OaJnoY5nZzgHsM+M+Q1tCStP5iRRULNJRlJSSZULDLjkn12AygTDe3np9ipponMwTK/GwGDkF6no9U7UebnKCPhczjyoBQY1WrmTzujK1G+NPwd94zMPWoMIOZof05hH7IG9ZgEh++v3Lazy3m/tFdCRp6MdM8Q7Ba2g5F8olqw8Vq8oU04182TMwLi2sTqdDfTB9qSn9xL3IPcuwk4XFwUWdedqOTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgEX4fqHYy9aFmYJvTbfduVe1tdNj0XStV9S3Bx6Fto=;
 b=XcXtABWFv9/+5ppXUuD62TmAa7xT4GgM7lqsGpuRFaQwZkppSONBdEyULwPBvmrox1j/vsrPbiiiSRa4pDJiVRiukTFyDNaSwlR8oOYgWJvGgewu4ei24FJFudL5be+nhZwanyfqqWHAjMdX1gGcOvgNfQyfzAjG5473K9B77Omucuc4Vj4xq4x2DRE8bQ25YCXQL9qx3lw/z7dfgsRFAx2JmVuP9yJrNIa90QR7aYAGbtwphzN0mc7kjkJLU4emFBAxnyHhM5ptjQ5w/IPI8/nke5Qdyq5mnWjGhDMVLTN9zb8Pez3RD1O0PjoS8tUnwjbKkO63W2kVcnxrVEQlHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:50:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 01:50:37 +0000
Date: Wed, 10 Jun 2026 11:07:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, alexander.stein@ew.tq-group.com
Subject: [GIT PULL] Please pull mmc-next-2026-06-10
Message-ID: <aijU_urF5yvfqrg4@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b6246e-d03a-4c01-bfbb-08dec692ab30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|1800799024|376014|366016|19092799006|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZUnEWu2ucf6O2VLVgoxKS4tQp31huwStuyHHoopthPmAUPGP/EQHamHHgM2rZJOrQSSqCFFSWHpwAxhglDE4znFbx9AfPiyY1Bds5/10q270eCwAUU46/Yia7YdwmN3dIpS/sBne0Mcwpza7UAi+zov6+6CS683H9LwsvDBptTBEGxASxA262zEMJFc1j/pWKlOYjCIhNwAZ7qMqbJHs3zJ0a4afEcaedn08sYVqdtIb7xfvQxQldNsXWdC/3SlFuT8J96gMBhlabJ+rLbiNjALzXPAtCUxK/Iw5hwlobVTXQFl5RzVIbqNTjeMiqLu7FohNIe8fjEoZQaBz62Y/zZ23mEL0cmkQdcpV2lkmzt9vy8Kr4QEj5NG64TaRe1KZbbN1sfXDcBYUXBD9+zPkGW0s9dcdF5mTzpL1ep7GPvdOE+jG9OHq3yZsmA42vesArJEaW9RiDN4F0/z4D3oYJhgJyTn1X7ssfDQWmMoONNb0h3yaxFkvZcNMLTfGfhrXAS+yh9MDSAoLHAEB/JbOlHc9kXCzaDfZ/EHVRximxyyv4ntVPE6jI6vlv4Ix3q6yWGqYO2Y025Az0St9ddqVwhQ2ITQAfuFo7UlSedn1U8HpVI8hiayJUmriADLVHlJkDqaTYIJxdwQ8nwZ6I5TSOj4pADxt/+EggCfUmX/iXDfD7vz+lpFtedkbEiuEUU3Dd0gVVkhglKlk64skkzpFfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(19092799006)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajmL4zM7LAJR+xfxNhC2384TipK318UBj8IeHDu5j4HTg1sxuHiDX7PuV3sk?=
 =?us-ascii?Q?Uj3NYaygOWhwakOaDr7QVk0TbBmWclErjXh6f6qkZQeovC+eCNPa3uxwaRZJ?=
 =?us-ascii?Q?9G0lP3ryuqoAk+M79p2AoZhv55aBopURRW6Q52pxRAm5tN7bc+Zf2AvYaN39?=
 =?us-ascii?Q?0n6NlBv+fvicv9yTud55k8m4I/oosO9i9ZRia8ypOIMxj3uKM1CXyTzoWW+Z?=
 =?us-ascii?Q?DflpD9MnN6ikkIfoe29OmPfM2sOuHJdbfBAj5w6q0p7ztvVoB6kz+1pZorpE?=
 =?us-ascii?Q?bowv2pJ0eGIaf4jARQRkLpeJ11JCS4FQVNyI9/vfgKgWLBzUc/8CI1O+NDmR?=
 =?us-ascii?Q?exdky4kOR+Ls90+bFXX54yjPW/OenhPx8PtvHYCQwqafvpB0vgxhSizrJLy/?=
 =?us-ascii?Q?LFj+iP2hosQYDlr4f6EgA6VylM0WSRM4uC8TY7OVUNmHWDkq48i85FuuBelN?=
 =?us-ascii?Q?2KbWK2FZYf312TvZ3KxUw9m8I1p9pwXGKM+aYr897AnAu75LxYIJB7fGENkZ?=
 =?us-ascii?Q?tYwpkx1LaA3q4o+vDewuFAglL4HXH5B0OK3iTWNhplpf6nLkhs/Wgr55ByY9?=
 =?us-ascii?Q?0Fvv23u+L8lkKjmhTs7zdqRESrQSmUNnurMJR9EbzlUtSNs3PHw0H7/xYDLn?=
 =?us-ascii?Q?AWYZSEQCLyN1BgfSFgyQQBpC5LPOsbVNCxvCUwhRjQHWtHZcneisFcCkW8FR?=
 =?us-ascii?Q?APRGMHhy/ice5VAgyfzb+rGOwY3yKnsOob7nScpmvHvQO/gkYkUq96qR1ijr?=
 =?us-ascii?Q?ZguHfOcKBhQwVOrcLK/y7/3n4kmwPcX0qY7vOdv9QgOrKtyDHgRd/C3XwzMX?=
 =?us-ascii?Q?CVA/TR4ldzjLrO24DrU2dEl7S9pVPUPlFs8NRBiZcg1yC9Dv16FH801RdmjB?=
 =?us-ascii?Q?f8bta+bdckH9xxqWdSJrdySclszTySD02hlN8svq7KUV4V63thD2v+DJzsax?=
 =?us-ascii?Q?+v03eBc1xk4CCvzENCVmyNvZuaUyenHF+ywF54t5fhG6MRU+Ntz813uDF8CV?=
 =?us-ascii?Q?lM9v8dM97q9vOJIThYUEYA6w1iDD822kqAhWTYlrKdUOS8fNqKO6uNHkbuR4?=
 =?us-ascii?Q?388f3Wc+INd3ZEc+LQTGhwxfMTnbg5VMALQaKnirlQwZttRjNNak2aLIGtak?=
 =?us-ascii?Q?iPQ1inayRjzBLNyvy3RFHuw7rvDTOnrmiWl+bFic8WYNkQ4LsJmDdM5eGemU?=
 =?us-ascii?Q?r1qCN0BC+sdB7NM+49C44D5BgFaYED2qdRA0Q0hopqHgkrvQ/PCIUDykTobH?=
 =?us-ascii?Q?qwG0AbSEg+1WKjPcX+dUblxHwe9SBTxbQHT3e2SPs6VeKDARfmFaflp1QpCF?=
 =?us-ascii?Q?+D3NCDozBcuS0eT45+RI705K+M5IZtyudNYBJKvH+zD+NBdL4F4Rm5RmsBH1?=
 =?us-ascii?Q?uxND1diKVV26opG3OuvyDjF4PzkDlA2pXzILlq7Abfbhq7CMi89A2Pm83v06?=
 =?us-ascii?Q?o/FkSegXP8vMfBejH3s5C0/+iF7bnzD3qXgFUtYHUtheJ0T0jZaozKmmt0iL?=
 =?us-ascii?Q?ZBLr/PAJWBo9SxnX1hL4N4uPPEo6ZPTNu2blLFDWEWkVJExcReQKzYveJaNV?=
 =?us-ascii?Q?B/9n/aXlbWoj6Dq3PO4cx6xUfRDMPbFKlisygqNR3kwAEnhKv7TbtqY79QM+?=
 =?us-ascii?Q?aC6DjfqbTTLthQEYZuFPz2QnYRiEWK31jrnakk8LqXeodYRJeSTQ97rlTN+m?=
 =?us-ascii?Q?Mp+uhUUJbs5SbHS3a5/HUHKnUFlVVsp+3ZdaE+ylgMPcDZllQHEMihsJ/FaP?=
 =?us-ascii?Q?peOWTfuE4A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6246e-d03a-4c01-bfbb-08dec692ab30
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:50:37.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ondhPwQqk81F1+A+EExYiDAJAG46KIpguxat3vtT9m9Ep2dtW/4FILy8QcXHYfCf8sFB/q7e+y7Fqcx20EJN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485
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

Please pull mmc-next-2026-06-10 for next

-------------------------------------------------
Convert ofnode API to dev_read API for mmc/power
Minor fix power on/off delay
Correct mmc command help
-------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/30396

Thanks,
Peng

The following changes since commit e91911169bc737ee4a79963a1cba8db2aab7c1c0:

  Merge tag 'v2026.07-rc4' into next (2026-06-08 15:28:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-06-10

for you to fetch changes up to 39dd6607cd8a3b02ff64b4bb2bebc605195fd961:

  power: regulator: scmi: convert ofnode API to dev_read API (2026-06-09 23:55:56 +0800)

----------------------------------------------------------------
Markus Niebel (1):
      cmd: mmc: fix help and parameter verification with MMC_SPEED_MODE_SET not set

Peng Fan (14):
      mmc: xenon_sdhci: Use livetree API
      mmc: cv1800b_sdhci: Use dev_read_addr_ptr()
      mmc: fsl_esdhc_imx: convert ofnode API to dev_read API
      mmc: msm_sdhci: convert ofnode API to dev_read API
      mmc: octeontx_hsmmc: convert ofnode API to dev_read API
      power: regulator: tps6287x: Use dev_read_addr_index()
      power: domain: meson-ee-pwrc: use dev_read_phandle_with_args for ao-sysctrl
      power: domain: meson-gx-pwrc-vpu: use dev_read_phandle_with_args for hhi-sysctrl
      power: domain: imx8m: convert ofnode API to dev_read API
      power: pmic: pca9450: convert ofnode API to dev_read API
      power: pmic: qcom: convert ofnode API to dev_read API
      power: regulator: anatop: convert ofnode API to dev_read API
      power: regulator: qcom-rpmh: convert ofnode API to dev_read API
      power: regulator: scmi: convert ofnode API to dev_read API

Ye Li (1):
      power: regulator: Fix power on/off delay issue

 cmd/mmc.c                                     | 21 +++++---
 drivers/mmc/cv1800b_sdhci.c                   |  2 +-
 drivers/mmc/fsl_esdhc_imx.c                   | 14 +++--
 drivers/mmc/msm_sdhci.c                       |  7 ++-
 drivers/mmc/octeontx_hsmmc.c                  | 74 +++++++++++----------------
 drivers/mmc/octeontx_hsmmc.h                  |  1 -
 drivers/mmc/xenon_sdhci.c                     |  5 +-
 drivers/power/domain/imx8m-power-domain.c     |  4 +-
 drivers/power/domain/meson-ee-pwrc.c          | 13 ++---
 drivers/power/domain/meson-gx-pwrc-vpu.c      | 13 ++---
 drivers/power/pmic/pca9450.c                  |  2 +-
 drivers/power/pmic/pmic_qcom.c                |  2 +-
 drivers/power/regulator/anatop_regulator.c    |  3 +-
 drivers/power/regulator/qcom-rpmh-regulator.c |  7 +--
 drivers/power/regulator/regulator_common.c    |  6 +--
 drivers/power/regulator/scmi_regulator.c      |  2 +-
 drivers/power/regulator/tps6287x_regulator.c  |  2 +-
 17 files changed, 78 insertions(+), 100 deletions(-)
