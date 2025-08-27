Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD52C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59ACA8319C;
	Wed, 27 Aug 2025 10:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IEgyPsrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CC1831B4; Wed, 27 Aug 2025 10:22:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849F583145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4ujYec3pI4au+r7YWzhJ5KnF5Dlg4BAx9X0PC3FL63oixDF4q7Zhf15fqaAUQMARDoKXUlkozh3jWkUsP2kg0+/2yOJBYLWp16xM5yRvE7fDNgbF9MlJIBN9YMANiNIjIRZE98Md+NdWy6vLnEvli8ExdoILRNh1sgB6E4c74JNKYg5fUqML5dZ3ccOMVgjbYzEoTXidHri30to7FwKK9BOWllu/nbwWsCsKkjHgfZZlqqCPGvRIRaTJx5bl++vCtzsAN+OLeaB9TD2vZ1HkWIBV/lU9PBBT93DlpP35gF9mm5hYH4v5PHy4W70eb5VtHgUD6enfGE7r/cHhtI5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kUl1eyaSAVHHNCfV0RjuZ0JslpJAlMTG8t+otRD/6M=;
 b=wUupCkOYDp86yKmVOjrSdOwxyGY7jVT82D0FsVhUIZNzSf3OPejApBSMyF6oFKe08YXZaQqewhj0G87QEweqe1uaSJ0/A7pnB2lbBg+VYoUc/y/lb7vf1qbroB6ZebopV9eUF+CY44MMghF8e6bb3lZJSFMyYutlMNubCQp0rL4v4s7cfls947ZW+kSgo1ek9p65YE7jWkQRn+P8AeLTnT4JdECQYyTEJpd+cG9g2JF/Bui9qNP0VyagrClzHeT8i88rhkZ+xiDOuRYZ44Ad+w4Po/Ci2gjyRe/4VgzGM2VgkUAyv9EivErxgj5M6/4dr/qjeJ5agVHPt30sdvjzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kUl1eyaSAVHHNCfV0RjuZ0JslpJAlMTG8t+otRD/6M=;
 b=IEgyPsrCWC+Za9/fD5KqybpMFWyFXqadrLi5sT9CcXzmdJkCrUa9c4U409OqtuBeLh+PE33leTt38tYM2o2cN7QRRLGIAodFZ8RQk/dAL6hvQOa0L0k6fLHFDNvgW7RmmympEKMHMvbguH2lMdDKMWb4KZNd4ofhmj4xLcdjKG8D8XbAszz5+nUrCAx9SUtBSaJmkvXXJifmDf7UJYsLFfmg3ziGWcuH0Lf+QUskUaNLCDKf9I6Jc0DhwGQ3RvHIbQdjPFv5AGSXqNf8uM4qsuU7bLHCC1AYzxVbFG319McdA8a+8MgADEFInPImnB9ZiWkAQY8qiNrGmeLBdB0Dvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 08:22:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 08:22:02 +0000
Date: Wed, 27 Aug 2025 17:33:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull fsl-qoriq-next-2025-08-27 for next
Message-ID: <20250827093323.GB22823@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6be1bd-f101-40b6-80e4-08dde542ccf5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FPtkte5lYGznC9eEvNiRSQL87ouEsopOnXGPPTIV5zvnYQO5enbfOLGYRNwE?=
 =?us-ascii?Q?41Z9bs/HHoYj79fE8K0Usid0a/c3L9/ddrwZYc2RvS4oxVRJVvItInnr6fiK?=
 =?us-ascii?Q?SlAj2L5KBWWEIAK+lSImBb+5KftCdDCvyH7a/eJ6WRVZ0mlwhoT/23Jf/Xba?=
 =?us-ascii?Q?NhknSW3SzxL8fmEcp40A0EM4FyWUf8fNd24TyZsocoP+qRB2Njz9y92dDyaC?=
 =?us-ascii?Q?Qis4d24DSmdmJv7NBM6j7lHPXX27vxnbbngb2/w2x38fVBm5pDKbVU59DrQ+?=
 =?us-ascii?Q?TVbNAXXAPj0LERgJE43D2sKh8wFto95hWN3dq+3xjilvYcWo7jQEiQmbRj9b?=
 =?us-ascii?Q?0SgtzmdHWvR7TOtyJ3AERIGQvKaacWfZdxpjO3TINCHYDT2iJLDUxKL+tlXA?=
 =?us-ascii?Q?yRUTNEZ1MpbwI+hA68Ry5N1jY37jLOZJCuSGSYBobSVEn1qWZfmjSYmhM2ER?=
 =?us-ascii?Q?X9m24WcgPsWrjaCEmfixPSc8yZ0oor4MBxmuD3f8LdjKP50crQKPCfpVTs7x?=
 =?us-ascii?Q?YkJSNqHpk07PpE8Qgc2Zjzo0cQ/15tuEI6BSen54ZsIeICC2ekWsb8IUjTnX?=
 =?us-ascii?Q?9L1kogL7b4DouLvKiKN7UDd+0vGAUWbQmrPjGw8p5A/mRxd+HETanzDvQ7a1?=
 =?us-ascii?Q?vzt06KevGh58WDyPuuauBP7AEyT8jpz6b6W8a9DIRGSCofUdx4J7CJiyprkO?=
 =?us-ascii?Q?K5vzHv8PLJaAvm00Ka+0MVwUb3hZE1evqMM1sY/mn9g0oq1sbObblk7hutzT?=
 =?us-ascii?Q?FGLlr1554BO0IfqtGdFzX0NWYfEN525rRTelL06lOzNLw17tnl5ughJHbElb?=
 =?us-ascii?Q?66cwfxx6MpcMhaJvl/Sq/+wZnRXroNvW946c6AF4XZOSAomI/fwpSP4YFFg/?=
 =?us-ascii?Q?QW6JQBsVJhuKY5a1IeufYfrHsaQBevlGgVvuBjiWQtEfpAXrqLU7+weTEIjS?=
 =?us-ascii?Q?NSJHRCcmA7uq3aLnDtZrv9QUD57aQN/PUI/TKkus4x3eDV87r4OsdL4398Wk?=
 =?us-ascii?Q?V1utmEjBrOG5McCRFGfcIErUUyV06pbdjWf26jHLfpVGoMncKSCT3pHX9SCv?=
 =?us-ascii?Q?9uHVyk82qa+dH07J0idAJer+zbWha9K/fxombcv02y+obNxkS2dVYqAmdnvF?=
 =?us-ascii?Q?cOu0grrIAL9BCSKmA0ZtLVDTNkDxSizAGEHVLX65FpoafCjdZDJ9i3fuXEIW?=
 =?us-ascii?Q?1glB90AzOaIfSkyJ9erqouci6VFi91iP0RIiBHTJER7DoSptNExCResS9ocU?=
 =?us-ascii?Q?I/Dnn1R1QyP+LAzpKS8ZuucwwjbqXZrvoM2Rv31pYs+Uz75i2PeJHZMSv6mi?=
 =?us-ascii?Q?foSjVYAuxobZ+f5SygHOtQotHDNDecJy3PvXaV2kOvVBB0kAImGDeGgtoaZ9?=
 =?us-ascii?Q?UQj9bzd/vrO9loDdPzjKIpFdsqoqDEmNS83c71vbvSh97VBHN1b5ZhRa64De?=
 =?us-ascii?Q?f+sbulFnffE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L1c346pV2e0lu0mAA+hQkCswFdubPB+Q3j8Kx6ATU9rWIacSxkkLC87B/Ioo?=
 =?us-ascii?Q?lr5vxWTPjOC09c6F+JiDvlR6JVEk89N3Rnx3BaDC13+YErvjjZeq1/XHKhW+?=
 =?us-ascii?Q?cK3kOa792F2ZAPJVs9z/ZzTwB75r9zUhMnfQR57zQxhs8+B+yxXh0Vj6JIyl?=
 =?us-ascii?Q?Fv3Lf+cq10O1DEhWoq2dIQ/xNpeWurTGNxMUFqNuGlUzVTRevsueLyPhAI8L?=
 =?us-ascii?Q?zT6AcmNqjQhB6U29h8LeWOFRfsjNHHJri1NrzncWqdd53UmZ8oO6ZZor+Dsa?=
 =?us-ascii?Q?vJ1ZlGNNW99wh5pusi9vOTjEmmma8nOb40ve971orXV8OSGaPKT8vlzBF/pq?=
 =?us-ascii?Q?MXqf/HbE4y3KYr2DM0gW3xRoaM8B3izecniNOJWPxE1/0sVOijTs+GaOE2pk?=
 =?us-ascii?Q?kORuTmhg9gSSJqWNRwJ1Vg6Mo8plDT7pxbVhKK86aylnnj3cPZ0K8Ofoem1s?=
 =?us-ascii?Q?8ITFoTkEx+9ptzx+ul1Cykjrb+Im/Ddu3lYz2DXUXDrRiRlaC32etNheqx09?=
 =?us-ascii?Q?OcJI/zMQiiZQpQR365TpcatJETEp4dZ26pLYASDiVch08pHJ1GbtR4Gglk7X?=
 =?us-ascii?Q?1LdUv/zZkY3GqD/MsjFOLLRujzecMz3j98kzUPsOlV0Z5QTnPR0e2M3mZHjM?=
 =?us-ascii?Q?qhRXjdAUTDdifmQr08V4vgLL2S7KZx94oOu9ThbbkrAa07iYOfJ5VEj0mntt?=
 =?us-ascii?Q?F/JnGM0X6UuWgnphfOLgywUnasCyr4oCbb6DdnJ2jFO5BUHZ0/Ca2NTSEnNq?=
 =?us-ascii?Q?z4vXXlfJmRL0Vimpd59J6FRXq+cKr3iP8ODa31IQQ8cbV5aiNuOM1GmfoZ4O?=
 =?us-ascii?Q?Qbms8ovUcoWCDADqoXQ0kC7dn9gTvszOd9HMZQL9Un5Bk8MJB+lxduqH1Q0M?=
 =?us-ascii?Q?HXXyvm61xbpplr9peRrhzV9L33C0PsZkdNI/y/YNn4MFRJNsFY+NVyrroDST?=
 =?us-ascii?Q?bVzUm8h3kA4SvplKtZOJ3HvCQCNUh6YvfQLibflGhzq6bosA4jH5VZyptN+L?=
 =?us-ascii?Q?Rh2Ug6A2YtusfscGBxDm+w1Q212M1pttDb2qOvL8t7eszY2OdrkprcNZM+ut?=
 =?us-ascii?Q?PJCqDNVh7zcT13YDGFxnTA2F5vIiI8V96tBrKoUa8oGOpW46tNqJjnDyV2r4?=
 =?us-ascii?Q?EPxeKrn1gspigO8ZJUpN+M2dG7CdHaosdCTbr3UdEOiPy0AwOylFeq24Teqe?=
 =?us-ascii?Q?sKIfhGnFVoUPXGtafK2iRUxJyzI5DszNdjksVvxtVR00X/TC9msR7i1zK8JJ?=
 =?us-ascii?Q?kXbih0hjGpottxqJ2OYno+KIWDdbQuz//0fd/Uwfi19xhJs7bkr9kTIff3xo?=
 =?us-ascii?Q?ZrGS1PC5J1cp/h72NBM0BbGA+jY/ConnTZEERkGHryXofl1/fCXmNUbNw/wO?=
 =?us-ascii?Q?4xKZcVdaqyF87mWF52seWq8HWd/li5bMjdQFRjbp8WHGsMh7LHlqS0ar58uL?=
 =?us-ascii?Q?skdAIJbeydZIJxZn/5FFDns/qHDSMYjqRRvXlTZ/QlbdEL7MjrY/FJY0eI3V?=
 =?us-ascii?Q?VB2Gitf/rlSp6K+SsSDpZL694iZ3HoMXVwbXwtwpFlM2kBFMzU8C4Dof3L96?=
 =?us-ascii?Q?F3iIepeP6DyaU40nPGCZCb7fp7DKmClvyCR+gRmd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6be1bd-f101-40b6-80e4-08dde542ccf5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:22:02.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRtBwOH8jlzKXA6C4pjtXAkgqh7ULS+6JnYPwtnzY4VoQ2Ib+sGT24hEzTeUkgTFdr/J1McLf6jojfCFBKsrAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
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

Please pull fsl-qoriq-next-2025-08-27 for next

-------------------------------------------------------------
Various patches from Andrew to address issues found by Smatch
Reinitialize job ring in crypto fsl rng
Set scaler values for fsl dspi CS-SCK and SCK-CS
-------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/27490

Thanks,
Peng

The following changes since commit fceb37d802b65beb4713f17e9167e7ecc4dbbe67:

  Merge tag 'v2025.10-rc3' into next (2025-08-25 13:28:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2025-08-27

for you to fetch changes up to 8b97d7569a48d15949cc9274f40bae013e24a2a4:

  drivers: crypto: fsl: rng: Reinitialize job ring (2025-08-27 16:12:21 +0800)

----------------------------------------------------------------
Andrew Goodbody (11):
      ddr: fsl: Provide initial value for zqcs_init
      net: fm: Correct test for timeout
      net: fm: NULL check dev before dereference
      net: fm: Correct test for timeout
      net: fsl_enetc: Fix copy/paste error
      net: fsl-mc: NULL check dflt_dpio before dereference
      net: fsl-mc: NULL check dflt_dpbp before dereference
      net: fsl-mc: NULL check dflt_dpni before dereference
      net: fsl-mc: Incorrect variable used in error path
      drivers: qe: avoid double free()
      serial: lpuart: Return value from correct variable

Anthony Pighin (Nokia) (1):
      drivers: crypto: fsl: rng: Reinitialize job ring

Tomas Alvarez Vanoli (1):
      fsl_dspi: set scaler values for CS-SCK and SCK-CS delays

 drivers/crypto/fsl/rng.c              | 21 ++++++++++++++++-----
 drivers/ddr/fsl/ctrl_regs.c           |  2 +-
 drivers/net/fm/eth.c                  |  9 ++++++---
 drivers/net/fm/memac_phy.c            |  4 ++--
 drivers/net/fsl-mc/mc.c               | 28 ++++++++++++++++++++--------
 drivers/net/fsl_enetc_netc_blk_ctrl.c |  2 +-
 drivers/qe/qe.c                       |  1 -
 drivers/serial/serial_lpuart.c        |  2 +-
 drivers/spi/fsl_dspi.c                |  4 +++-
 9 files changed, 50 insertions(+), 23 deletions(-)
