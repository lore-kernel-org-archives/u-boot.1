Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767BECCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 04:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67134833C6;
	Tue, 14 Oct 2025 06:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O0lI8+KM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794C4836F0; Tue, 14 Oct 2025 03:11:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D9E836AC
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 03:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/K2TBjDVtxcBbzfCkmsfxADM09nTv8pcF/gNGdB20r2WX0aEaENfR9q5y2coaA0NPD7X8+7t5vx7N3oXSAqMDssB87LGiDVJFOIo33gXn6RGd1tAF5Sijnu2FqRnyvZYHQxYQKqGxgr6VVN0lszmL+kDbnQAoFGCEEw7boYmp1kXXJ9bSys4SQ/n19F5JaEqR/vhiRoS0GAYaTh98yU3aIAv4gw84FVRPNGuLOGqf779R8gVkqefv3a/hJ6bfMBrPeoK6qNPvysvJmZ8rv7Onfos0irzpOq6wUsya+ROt7vU+ckRmWxojKr/hUkFx+KYwhfKlWJJry+ipUCH8v9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTJ+pkfDBXGXyDJxcozsEGZMB8r3VpivquAQcd/vEX0=;
 b=LLwy39sC4AQVKktq1UHPU2BX0QyNopirc8Fr88CUDW12MEjyuC88JXJUutra5ntq6vXuH8ZnNPBRbKKGnzthiL6w+2hEqzdYcjiJfqiP7BGcGnCCd+Cist1G35V+2nmjJaihz2ClRnhgY+TPqFosPtnq/9ipxQpAllnRSaqYGd7SQhSVMIngG3py9N8lKMaccUl0/ZOMZRXg8c7mxdMiTr+Vwqvyjbqrh8DjNZm5JeTyT9rhH8BcwcIAVNv/JEZsC58zTMXngZuChlm9l+u8s9kIHGgkZpzw5zQkhmtiutHaMA7ApXXkrx6zG0mVFfSpMonjRGrsXGEOdf4Mlg36ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTJ+pkfDBXGXyDJxcozsEGZMB8r3VpivquAQcd/vEX0=;
 b=O0lI8+KMt81Kx3od9IN52QVFhBNvGNArXHnJ0tI2mwqfAabF87rjCqggsDriR3RdhlTyw1xGlC8DLIe9/6/mVZwM1GL6d302nAhyliWDqJ4wd/QYYvOJTNRF0nU0fQQx+U9ii6k8iGf3jUwDzO9XEDM8lbGgzqww7J7fI2JMrOYpanKsLYnno36onPhBSqXEcx3XFBNbNzfokahx/pz7MiGBCs0ohFcOydBOUvszFMHAXdJtqxYqJHo7SNOJ3cJTf7tsrDdSCvoJjm0cZO6SIhPRWugnRDCE8ZoFELVq76zBT+t6QzoqB+aegIVtd4G5/kr5Jm3sauueDy0uVhsbNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10423.eurprd04.prod.outlook.com (2603:10a6:102:41c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 01:11:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 01:11:11 +0000
Date: Tue, 14 Oct 2025 10:23:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 0/3] Add i.MX95 15x15 EVK support
Message-ID: <20251014022326.GC31468@nxa18884-linux.ap.freescale.net>
References: <20251013034128.1752157-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013034128.1752157-1-ye.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10423:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bec741-c4ad-4ece-4277-08de0abe9012
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k4VprIvlUdc4I6s/hToXA0AroQ/E/LcEFZNf8eg1rD6oGRExC17nkcdzwA1P?=
 =?us-ascii?Q?hregCEnKB3avU/VrYJZed6wv1Rea7p7qn0CyiOacf9NEJSRbDvBFuSmSUUP0?=
 =?us-ascii?Q?SJ4vEfhS5db9PhOWsCSlB/Y8+4Kyv5XKXgCuxGpRwpQRZFk2OB7wrQVIfIGz?=
 =?us-ascii?Q?KUYs/i3nEDaSDeR0aGD3KQcS5BpHcRl4/GQrZ+va2dXA6QrWodoGEh3y5KCD?=
 =?us-ascii?Q?RHzR1YY4+2gfbXQ9KacSOzVj7OpWupTYuK/x1GTpGBvGlPmLxVv/r/A4TWsA?=
 =?us-ascii?Q?ch87gDxcAs4LrbJpUKKJPu54+NVBRdq6w04s7rPjy+Z3mlVEJifUeDmn/LYm?=
 =?us-ascii?Q?uOTqAWrLuIP1eqjKXJuGVBKK7DHcueU4jQhxMhJwgOINup9u/1y4ra/fiACo?=
 =?us-ascii?Q?4DMnKYYGWxl7ayvu2Wklifhpsw24SUUmdQ6+HPjfhdhTl8J1AKjO3BZ5e4Go?=
 =?us-ascii?Q?lt4zmTL+Z6zhM+A/lwZbghvncxnc4KIgxq8p9t3DX7jD4bIuY3MwsXXW4Sl9?=
 =?us-ascii?Q?ygt5bMObA1R7C4dLXYESKHekBr8nj3qgf5lXycuJvVEux6SO0jiGwm1CMNd1?=
 =?us-ascii?Q?bZxIOWYJiAouE2zUaCZ4p2ZfWYwSco7iV77e3Bm9fO/uYAd5soBtbSVJfqFs?=
 =?us-ascii?Q?Ha/r9c9VEzWiVYMg9XNhNvkdKEwSQYFMEKq3HMXo8U2PjnOrd+RGJxG28Oee?=
 =?us-ascii?Q?nAPP9Ft7lP1KR8iMGwMHMKQ9oYKfOof6YzWuz5NyY2GipD6dc4cbw9yF460Y?=
 =?us-ascii?Q?te1M2U7lt9/NI3Jc66u0zA/MoeJoWx0qieYnTJZNMeyfALjjTm2LW6ssIYJK?=
 =?us-ascii?Q?6un7CzFKN0LD7vZUOIYfarCGQYtpLCwZjY1vhy+pBZB73KuOpkMxdcao7N8u?=
 =?us-ascii?Q?tI9LUu+qysPPZD1YNrwS5UX6gcL927H98kEnAQSzhc2DV2bub0MmxVH39UlR?=
 =?us-ascii?Q?Ycu+RczM0c6i7aDvFN9BwsTh2FQNCe8K3gNPZyJZ+9CpBSPTE3gAugbe2Zne?=
 =?us-ascii?Q?y1wjYVkPo7nRrAv6/AzzZVTe9FkNzo0grK3omNrCAjoAMAmP5fK+Ej2sp5tT?=
 =?us-ascii?Q?lZd/wbxYmfiMY6hufsaCAM6wbFZe/jHy/DbbkMQpm4fJGbLlQMV9a6so4uUR?=
 =?us-ascii?Q?cGnF+Os5ki+x4GPQ9QHk+kx0zWLEwfuxN99Ip8mDaNtiROYg8D1YcJAdoKI0?=
 =?us-ascii?Q?2UmOMGrR1wv6pMMeTVhSX+xV4J1krPa92SLEw3f8r9zELAqEci/N/AAPnkjT?=
 =?us-ascii?Q?g6e67XyufQVoTTFRZ0ZjhVMi8nyzVW9wUscjrgJYVVWgR9hXhs+PenXXEFOh?=
 =?us-ascii?Q?B1Nq8vPcQGOzpDeHibAJ7C3lINI/HaWhLWY2bqIoHuBSQszdOmoFxLjcRnu9?=
 =?us-ascii?Q?cUEGfDDGBsIkQtorpvigU6OXASm8OqeVRYTVh7937AQCpcjZhNTwMN7y9Edc?=
 =?us-ascii?Q?KTF688YT64jtN9ZUdQkRAVEoIKRdp2JgUroNRjiEtr9/G08dJMd08H3TcDdt?=
 =?us-ascii?Q?iZcwHkvC+t4s8MjcBOlStCGrAy/GOSmKEofu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KmZ361HGSwAb3lpm0LC44fZ+BIYd2yO9ww12uV/ALW30gJ7TS+/XbhP7654?=
 =?us-ascii?Q?cIYV5T7cBNbNBdVi6ufHRaanWjLz1BiaCAp1nEJ86Kd7ktfSOwKETzmIb2Xg?=
 =?us-ascii?Q?QPHOwIk6L3QDZIiKUQ5ycxMPBo5n+Hah9C6hvfK6Y5B14v2JB8Nd8d0ePbKS?=
 =?us-ascii?Q?NaCZp0HwQFHNLAfJz6tSvXw9hSprQL9+G7KUtkvPr8lDJsWG+it6V41gFI0y?=
 =?us-ascii?Q?pjQBlBAjl4lH+sWdt9wu8LsSYkHhRrF0lcManIYnk4nOXL9o2B/PMDVNl7We?=
 =?us-ascii?Q?2bxeKQo+c2vdknErAYidMETHIVyDQ3YT/pa3KHD/dvl8pDIGSw0XLnVnhSxM?=
 =?us-ascii?Q?q6IBTBVHeY2W8krdVgVqb4I+EPdX3fz4SLt6f3Rvbr6kimmDXi9ydoGLeaK1?=
 =?us-ascii?Q?x/io+/C4ThOKTYpOPe1uZ+mnxsCSi/KL62TO45pd8agbOk9TUyTxG332otQb?=
 =?us-ascii?Q?So66pxgRIG2UnSgyjsPwcNqcrdpQwLHX0+dqjkyhAOfqv9L2CWMFXm9gDiG5?=
 =?us-ascii?Q?48si7+13Y9F+b5IrBngVNq5JzSq1RBd6bBZfLOuALdHM9sZDzjhChLxCE3nM?=
 =?us-ascii?Q?NrkJ4h0qqOZl2sKlAwSSHSJb9/GCKbCWmdpdoX54yAf/yKGKkzVeJ5yf763A?=
 =?us-ascii?Q?EPk4WUDhyp8fnnI9ZxmQmzMn4/NX3u+VY7KB9/uiLzqcZLHQNZgEqBRUSBKp?=
 =?us-ascii?Q?zngnu26qsAfF7Vvlw53IXP18zfbbW3qSj5RWJyz+X5VZFB4j3nHV7qFw1Kca?=
 =?us-ascii?Q?0O2FSJbR7/4PV3kIrV6nq0GNpNcTA0AOHO9FSB7NkAwlsYSvAfe+2j9bi7c3?=
 =?us-ascii?Q?7bFAGFMC9Q5KqfDIwzIkYjKMdghphLWMd59NwQ5/sRYN273f3Q+1ukLJULC+?=
 =?us-ascii?Q?jAqa59K/f91l2iOD2/7V1M6ganhyEVg0LSUB/tmSENRWl5CUeiPB784tODYL?=
 =?us-ascii?Q?6TxF05ei+shAIA8z9hF9ibDYH0h5btybYujscBNxckermcGsDUJt+4rmVdvy?=
 =?us-ascii?Q?Cp9XzVX2fE9S+Hx+bUQTjbRbCGsjor8uYFanDRDTzKYNxNi8iJXe1X8iZGuw?=
 =?us-ascii?Q?RnibmXp/Agvc31GXAkkH37GAnLgXopPcMOb+FqdLr/anFqi4CY2MNI29VEq/?=
 =?us-ascii?Q?uVQHmgyKA7jAxSkLX1EjoKWuy84IyNXhuP97nrmCUIcgVFgaQwsK7SFkkwbg?=
 =?us-ascii?Q?ZPrWH1hPhWgORQs0odP0ErxY45AInh3TEfdx5hjWHaVfwV+0WB2kEfzf/CBG?=
 =?us-ascii?Q?z6ZOpR9bAGg1XXzVKSdXbqnoWu9tGTpYniXGkZFEZiiicX/orJqZvQmTf5cs?=
 =?us-ascii?Q?XaI3dOMSxS36rQ7iYiCkcCumIcirOMB/DpfURESvuzv7L6v8kmMfsryva7Tc?=
 =?us-ascii?Q?j2iZAYNosozop5slAC8/HhpHiZdGnplImBJwLa3cg93/z5Gkp1x8Kl5tgjpo?=
 =?us-ascii?Q?2Z/Kq4XSYDOKQmNIsjr/K+VKELYNvtCIOu71CCMb2myid7a6SBR5IiZ2ECUF?=
 =?us-ascii?Q?Q/qNmTcAWrXJVPqu4G7SNjLB/Dx+CVPWoz7ZAI9PsPCj2FmAZaOnIa+yLlHg?=
 =?us-ascii?Q?R43eT+MLFz1JhfnwZpleVx5mtMPYRnZnK4U0teU0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bec741-c4ad-4ece-4277-08de0abe9012
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 01:11:11.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHJfmeO+TZVW1cx+5KCe+7UCOabev/8MkBVqGAinSt5vCUS0GQ9TSW1DCw8JuyNIj6Qx1sAXnnWNVpcUAl7V2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10423
X-Mailman-Approved-At: Tue, 14 Oct 2025 06:56:55 +0200
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

On Mon, Oct 13, 2025 at 11:41:25AM +0800, Ye Li wrote:
>The patch set adds basic support for i.MX95 15x15 LPDDR4X EVK. We share
>same board codes with i.MX95 19x19 EVK since different DTS is used.
>
>boot log:
>
>U-Boot SPL 2025.10-00455-g648db5f1a0a6-dirty (Oct 13 2025 - 10:56:03 +0800)
>SYS Boot reason: pmic, origin: -1, errid: -1
>SYS shutdown reason: pmic, origin: -1, errid: -1
>Normal Boot
>Trying to boot from MMC1
>Primary set selected
>Load image from MMC/SD 0xc4400
>NOTICE:  BL31: v2.12.0(release):android-16.0.0_1.0.0-rc2
>NOTICE:  BL31: Built : 04:04:45, Sep 10 2025
>
>
>U-Boot 2025.10-00455-g648db5f1a0a6-dirty (Oct 13 2025 - 10:56:03 +0800)
>
>CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz
>Model: NXP i.MX95 15X15 board
>DRAM:  7.8 GiB
>Core:  280 devices, 22 uclasses, devicetree: separate
>MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
>Loading Environment from MMC... Reading from MMC(0)... *** Warning - bad CRC, using default environment
>
>PCIE-2: Link down
>In:    serial@44380000
>Out:   serial@44380000
>Err:   serial@44380000
>
>BuildInfo:
>  - ELE firmware version 2.0.3-5f1204b7
>
>switch to partitions #0, OK
>mmc0(part 0) is current device
>Net:   WARNING: no MAC address assigned for MAC0
>imx_get_mac_from_fuse: fuse read err: 0
>
>Warning: enetc-0 (eth0) using random MAC address - f2:02:36:b0:80:06
>eth0: enetc-0 [PRIME]WARNING: no MAC address assigned for MAC1
>imx_get_mac_from_fuse: fuse read err: 0
>
>Warning: enetc-1 (eth1) using random MAC address - ea:ad:db:53:30:f0
>, eth1: enetc-1
>Hit any key to stop autoboot: 0
>u-boot=>
>
>Ye Li (3):
>  imx95_evk: Share the env file for both 19x19 EVK and 15x15 EVK
>  arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and binman
>  imx95_evk: Add basic support for iMX95 15x15 EVK
>

For this series:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
