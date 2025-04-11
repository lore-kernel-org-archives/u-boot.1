Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75DAC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2685683F1F;
	Fri, 11 Apr 2025 10:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kLMqIt8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC2383F24; Fri, 11 Apr 2025 10:08:49 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C14783EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSGNRxxakpCCHLMeukYbQmqMbssmaNi/U8MzoKkIu+FZPTSXbG/K326CjlevxoTH6b8QBV/aVpyVobVt8tG7QT06rMvT2xpBHSNvPIFnRlfARvE4NX/BeFCzN0Pkp9Sl2GAfkJD/0y5Un+ZqszJgSzesquANdoejT2B0E6mE7i+7uwqnL5gyZgUfvtNGylF0OzOInMPAlZG/6PW5m2EXjJfXv3piK8khLk7aPXMVCAPOH2ptSD0XlbBm8uIdkhQI6pfrHsS0Kz9cTsMGSWBS7DbRJ8AD/bSsUsK1NbrgJThMdRDKqIG2+LwuBExDyt55VIZQ5luCpfVqdWLAe41Ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdD31EW2KRX55Zg3VTuWi3r6LGqplHhLMjqtciiwPoI=;
 b=yr0WwBZjM62t7TIp6ZMZ5lNVZb5IjynCocBF9YsSAioco2zW4foLTa08Y2+n6gGlWJroDU46EXJYO1+piWlMfLOodF+F7DVAUS/GOEckNmzM/7DalzKqszUcJFhx053/2tRlim0b9RTotIsGkI9biTYmIgBlbZdrSqmyGgNKhvVI/gSgoKRqeWkU4Rnz1KWhibOWX5GDzJEuyWlfYMLW3nnapF6IPDOmZvqgkwr2tRblNhLxCgflAd82YDCLfD124sw329F5yOwzB2o0kfpKzYsLeFadkx9sIh2TO0StqLV1R4vWbJabESj+nW+ZdVKF+Z9jPPYJdxdNCUT87NbXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdD31EW2KRX55Zg3VTuWi3r6LGqplHhLMjqtciiwPoI=;
 b=kLMqIt8RCBFN/bCvepS3kTIMea2pJ9KH2haYgaAxwb1khTYLw6YMWqLQppqkENevOk2AyFsz2gh31oe8rAhom5/NRq0fLLNVplUNdJz55oMLNSCWOVhHeqQ99PEm0BIN9T3mCxr+RiKDjtdzbyw/htKkaFvDXyiUmmm32cltBMguzctlsSCD+8nhaD4t2tyVL/RuguT9o0JvAMy0WoucIZezHJdMUS3Ky+Vc5CTnvA8b0a/ZFT5iGHCQ8G5t4jwxT4oUv/XNabhiP0a2zGbYDOa6FHBVK2fV+AfzWxxR6lcKmLF7q4NHd4wDzPeQETR/4opqV/LCvpq+H81/qT8XTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:08:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:08:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 00/20] imx: add i.MX95 support
Date: Fri, 11 Apr 2025 16:06:43 +0800
Message-ID: <20250411080707.602371-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2f3fe7-8080-4f05-7d79-08dd78d01442
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/DDZq9CKkoXF6gUzQ6JJbE13CQMd9iqcoNueTVsK81ZVcvuJ2i+SNZhp35U?=
 =?us-ascii?Q?Hup2AskqM75wJfM1oE9p1V37uxDUf1797bFsre/qBf3JvyNcf3l3mvJ+bUQ8?=
 =?us-ascii?Q?/LBaQ9+WPHDUzX/l0eRhhxQDlfHhjX7lx1NuBjQz/04RtZmn5HNwnnbqxv5W?=
 =?us-ascii?Q?HzF7lqBWZnyDGLUfhxqnYofOXpk1TGOtA2RhHcrtYinM2txSiarKoYSGBTWz?=
 =?us-ascii?Q?9UpsXpRTI2X/nLdrAnE8Qh0n/4njrzVv8NlbwXiZGO28O/b1GnKHGNBv7BQJ?=
 =?us-ascii?Q?gdZE1xDLWLbF3dlGYC6UD1sYp1blY3q0SHxRMIi/ulxzTtzpYmAtceSYinXW?=
 =?us-ascii?Q?iTfTb2c5NLoCA8TrBj7Dg7OzTx2gASIuZZFjUey9bCJfdyGOFeqmFUWI3K8X?=
 =?us-ascii?Q?4EceTO/Dp94a8c0o6J/Er0hFM4AQqPgTnjJ4mTjw1JFL6QwxlNgpPq9AlqIa?=
 =?us-ascii?Q?z37YPLg+ZtCpyorIjPJ5tV2N+5dY88T15/AARnF2y4tNy4+G5CEUOvo7Q5iD?=
 =?us-ascii?Q?IdyJoVNmZoRp7h8Bmiih+0E4s1Of3YnIGQc8N75pT75x1w071ceujDGNHXql?=
 =?us-ascii?Q?nWjX0o0hZTjKyqKEYp2Hg4hi1TC2oiOchFuP5VrqmM8UFhK5EcDzjoq2mBUg?=
 =?us-ascii?Q?4wUl9ThsJJHQkWvJOzSrp+yloaovyIwPQiqf+EZDz+Ac4MYWaZoqKylPFwwW?=
 =?us-ascii?Q?dzzaDbTcs+jWj4xnokN+rKDnAX48xRNV9eXHxkzDBfFYx1coOOxFUhmhVdft?=
 =?us-ascii?Q?4sipldaibFtNaohVtRAm860ZgNxCciioXMIGGLiMmlrdkqBJbRZzXfjycVeN?=
 =?us-ascii?Q?HY5OLpUarJwXv2nNxoODSlwp0STWJfj2SL64tr9odCGRqw18YEnDfldqxQM8?=
 =?us-ascii?Q?BC0lNu6aHVo1RWXg8DwUMlT9xnn718KrWwvl07q9MsVBznpOzLyzpA4wZH2Y?=
 =?us-ascii?Q?ElmuxcD71gvQM/Z/qKdrRdIi2KJzHajybqMkEnjMlwAbqcyBFv4YVsHq1SmX?=
 =?us-ascii?Q?CzEb7q3ALf4VSUTPRDznFiGPDDcl/6RXih2npy7LsUcpj9yaLx3JaRrIB2iy?=
 =?us-ascii?Q?VsPvxrFZNU1WxubCZr3L5WfBjThM0ITVFsr1HzF0U0wjZNl6OMpHHfGZk/kf?=
 =?us-ascii?Q?qPjdILun4H8Sd6NJMsuLFU2LhrJSjRsANQYhjgiO1JM8l8lXe+sFwA90V9wW?=
 =?us-ascii?Q?bfpkIW5YhcRJQSE7JsYME096gwyhjFRwD8JPJm7Xo6xL2Jf0xssGAV9MrXYu?=
 =?us-ascii?Q?J0oILHIea+CsbPVhqv5HB9oYyIeI2zDJsMGhRKePV47/XPmvD37ZykueTckW?=
 =?us-ascii?Q?aF1465i9J3AkAgyCwmfdHv6ckMsqx2vB5ziC7Xk+0yl8TngIOVatrjYsVC7N?=
 =?us-ascii?Q?0lOvEadUXDZwAmioVHMcuMdLS0BgZApMGZ7x0DnVhq9ybf4fdH8fDqXq9Q8o?=
 =?us-ascii?Q?d0kUsBNDq6AXAIj5EiOKvVyOem4aPD229KrilNcNXZa/xYR8UJwy7DFE7jYG?=
 =?us-ascii?Q?QKhJq+wWAtvcew0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5et+9KmJmIe1cyNanQ8a2/tju2JKkVDQoDkmDCl1SKb7l9usX23hBKQoI7EV?=
 =?us-ascii?Q?Dgo0VzBPgdPcohNrbGQgmQw/nu2HQkUn4gSn3B+9BaYdYN4sx038HW2fEaV2?=
 =?us-ascii?Q?4NSAdb35mU+FXW2O2n+LnRLdolEiZUUadSuEZBcWR3mTAgbuVFqRDBWyIKRc?=
 =?us-ascii?Q?olhGbBaWZSe2wAMYYPbjqthATkRQWB9XnqkDaBpfMaWiQBdrvjm/PSRWFMbS?=
 =?us-ascii?Q?G3psZmB4Q0TTZXrhTfoarEKKm84bxC2Dyj9Mmx1NeJcgRD2P/jFkQFqwrLtu?=
 =?us-ascii?Q?Qp9th6WY3M7vMRAg9B3ilUNGGHwdHP2z62SVrZmszNZYS8KDG/9hiOptbeUG?=
 =?us-ascii?Q?BNvB6OZOhfm45/b4UOM2trROfRSey/LFUrvmSEUod/UdbrL4RK2tjfP+j9QJ?=
 =?us-ascii?Q?QuWStNVMAyFItqgcUOIqe+VRht2BVlw4uwN3STb4ZEEW8JLZDaA/48jDkwn/?=
 =?us-ascii?Q?wAYoDUKU1JN0zYuiM5KYGoDsXLOZlSGEdlAjOykeg2rkQrUFKgbXTCnPsK73?=
 =?us-ascii?Q?k5t9cjQMoFfeUEHKYfRQ3GOxpo0BIqTmw5cCaueNMES6ouU+yth+aLrTkU/0?=
 =?us-ascii?Q?0USbky/S+GFsPF75NPBIQf9FubCyOIXFVYM4wDU3lu4a8WoMb5haWkGgaEf2?=
 =?us-ascii?Q?l5fTMKkkh9FheKJspFKB8OPjgzgte6RUYp52OwdbHd+EL8IoWkE1DpZjoLYH?=
 =?us-ascii?Q?cmZL002VqvGDEyJBIJHOuHfH40heFtRpW1/TvDdZk0AO2m0MtBUfuHEls6IM?=
 =?us-ascii?Q?mRxVCj1gBLW9jRWtZkSCJtnoCcCbY6XiOimfXnyQaV5lMoAIA2fC5TyIMFO/?=
 =?us-ascii?Q?aG+eyUKMrRVEqZrIvEK1A0IlKUfVyHCIjAwl8LTsKY4IjJHT56EQm/HtpYgD?=
 =?us-ascii?Q?ObOdEerJg7kpktRU3pVMkGgE9EGChE2o0rR815R0v2Vnue1N+CFX1A3sp1ZD?=
 =?us-ascii?Q?t1uW4r1+fjJqhH3A7rt2SLdOeTB6bKiSKqU5PrG+9oHUaDnjpdg6omKllFQJ?=
 =?us-ascii?Q?exxmIO6RTFw1wpmbMQQzHmg1deorm2R+Rf/OZccA8LUU0SMK044lbJEv4APH?=
 =?us-ascii?Q?/ybWsZaZs0caSnymiryXIa6E5YRhjj6YNl33ZLHnHWNAhP2kQsfMVaZFYpdv?=
 =?us-ascii?Q?b3eZUyF08rkE31UvAP9iM2ZJrDYB7E+THBG8rau52R4OeT8xOae1fDsbFqve?=
 =?us-ascii?Q?sZUM5hnRVc1Y5KTF0ajbXc8CHe/OKLjtg9Qb3evxWD7QMzWy2EbapIg+scp+?=
 =?us-ascii?Q?7UeokE6hCrjAqQBZ/9NTaLLdJyv3XhIGG7r8zBLej1de1siufXsM/zH6HGAE?=
 =?us-ascii?Q?JuE6PLN+nSY8+cOgHG5baioEZLf83IIa9Ool0e69C9yopCIOYXv5RalRm6wM?=
 =?us-ascii?Q?u7/08q8eQSAKQV3w1BOZlEwBamQZlJd6NjZsW5L3UF1mnUG8bglaotS3g6Gl?=
 =?us-ascii?Q?f8W3c9tHHtIQ9hJs/sfi2ogQ0Jzrk1IjBbMtrSGbIRqdCJ1W/9kddqUIgfCw?=
 =?us-ascii?Q?/eS0KbUBeRpO5EC8DWZchnJap57piiBTNrKAk7HhaynL4USasCh53D7EbktL?=
 =?us-ascii?Q?6YLyi87Qsx/EwfNr6ck86J1gbqF6WmH9n6OD41CH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f3fe7-8080-4f05-7d79-08dd78d01442
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:08:44.9650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkFbZ0hYqulgy02SKVNBjIb6auIws60R/I91LFod/ZxE5LRc7+pVJqPSwOYtQAN8PQ4osvv1Q6jx9WQ6kZd7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

Changes for v9:
 - remove the "firmware: scmi: smt: Interrupt communication enable" patch from
 this patch-set and sent it separately
 https://patchwork.ozlabs.org/project/uboot/patch/20250401075635.3802640-1-alice.guo@oss.nxp.com/
 - use scmi_proto_driver_get() function to get SCMI protocol driver, which
 dependents on two patches which have not been applied
 https://patchwork.ozlabs.org/project/uboot/patch/20250322014444.174796-1-marex@denx.de/
 https://patchwork.ozlabs.org/project/uboot/patch/20250409075352.535194-1-alice.guo@oss.nxp.com/
 - query SCMI clock management protocol version in .probe() once and cache the
 value in private data
 - explain u32 protocols[] in struct scmi_base_discover_list_protocols_out in
 commit log
 - make debug prints in read_auth_image() a bit more informative
 - keep the list of "config IMX8_ROMAPI" sorted
 - correct spelling errors in imx95_container.txt

Signed-off-by: Alice Guo <alice.guo@nxp.com>

Alice Guo (11):
  firmware: scmi: use scmi_proto_driver_get() function to get SCMI
    protocol driver
  pinctrl: nxp: add a pin controller driver based on SCMI pin control
    protocol
  firmware: scmi_agent: add SCMI pin control protocol support
  clk: scmi: check the clock state/parent/rate control permissions
  sandbox: add SCMI clock control permissions to sandbox
  cpu: imx95: add i.MX95 support
  imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
  binman: add a new entry type for packing DDR PHY firmware images
  tools: imx8image: add i.MX95 support
  doc: imx: add document for i.MX95 Image Container Format
  Makefile: add some files to CLEAN_FILES

Peng Fan (4):
  scmi_protocols: add SCMI misc protocol protocol_id and message_id for
    getting the ROM passover data
  scmi_protocols: add SCMI Performance domain management protocol
    message IDs
  clk: scmi: add the command CLOCK_PARENT_SET
  imx9: scmi: add i.MX95 SoC and clock related code

Ye Li (5):
  scmi_protocols: update struct scmi_base_discover_list_protocols_out
  spl: imx: use trampoline buffer to load images to secure region
  imx9: add i.MX95 Kconfig and Makefile
  imx: container: add V2X container support for i.MX95
  imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 188 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 +
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           | 119 ++-
 arch/arm/mach-imx/imx9/Kconfig                |  15 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           |  70 ++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 ++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 749 ++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++
 board/freescale/imx95_evk/imx95_evk.c         |  36 +
 board/freescale/imx95_evk/spl.c               |  69 ++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 152 ++++
 doc/board/nxp/imx95_evk.rst                   | 114 +++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 ++++
 drivers/clk/clk_scmi.c                        | 204 ++++-
 drivers/cpu/imx8_cpu.c                        |   2 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  34 +-
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 162 ++++
 drivers/power/domain/scmi-power-domain.c      |   8 +
 drivers/power/regulator/scmi_regulator.c      |   8 +
 drivers/reset/reset-scmi.c                    |   8 +
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_protocols.h                      | 104 ++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 147 +++-
 tools/imx9_image.sh                           |   8 +
 52 files changed, 2916 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/scmi/Makefile
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock_scmi.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/container.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/imximage.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/soc.c
 create mode 100644 board/freescale/imx95_evk/Kconfig
 create mode 100644 board/freescale/imx95_evk/MAINTAINERS
 create mode 100644 board/freescale/imx95_evk/Makefile
 create mode 100644 board/freescale/imx95_evk/imx95_19x19_evk.env
 create mode 100644 board/freescale/imx95_evk/imx95_evk.c
 create mode 100644 board/freescale/imx95_evk/spl.c
 create mode 100644 configs/imx95_19x19_evk_defconfig
 create mode 100644 doc/board/nxp/imx95_evk.rst
 create mode 100644 doc/imx/imx95_container.txt
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx-scmi.c
 create mode 100644 include/configs/imx95_evk.h
 create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
 create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts

-- 
2.43.0

