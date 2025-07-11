Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D509BC83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3A8836F0;
	Fri, 11 Jul 2025 04:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QeU2Hdub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518A1837B9; Fri, 11 Jul 2025 04:58:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7952E836EE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIMIXHGC657UxPnG5oct+fZDcbmTFqrSJRzCHc1UYs3YRa8TQ7XMjhgpxiV9noL/M1xQM2zSu1ljMxW3pc8Tl7XepKR0NMWeA7XolfU6Bq4y4wfDVjy3i7I5f+efT6iqfWnfPZjBd4MaKa7DMhsfQvlDIzKuAbnnY2fELGIt3QNaZMQZvcw8xW4aBXGA7PLJ4/0M1q2B++/asR4R2Q1O117WXauYYyfAUUbV3nrNdHVerwSXxiOYw00XRhi2uW0R04WASphaNPB+wAJjuIHM2krrb3BykvfwBsFXfEHIc8dp0X++yplww961w5LYOa0fQfRzyc0TBqbKvqwYVpzQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob6UrprhO3TzWTGc8jXGN12Bk36cGBQsqwTaoIZBzj4=;
 b=boW+1N7ciTnolcWZJ5TpsukfNzTr6Zm+EFaXoCxfsdWLSwtxXhMdIl7uDrcLufRgWQ7Z3QkaS3jjUPaNos7qFt1jJeZRWqQRfWzJybpDOhUNK3k7VcDpEfw3TLo5cXIFKyTwFC5F3uVoZ1vmVsq9NQUAwfHqqR2SEhb4eB6NmQtCzHeHpU9h2dhtx9rjsrliONkmChDPGJ47u06ZkrO4pxysHV+1EPOej0rbVs0C82w+5dSz/7Uu+9e8lXJwRoA3j704gLNLyw+qJJ3xA1C/BCAETHVEnvGvzo+gGXwMaJg0eNiJi/4eEuf+NwF5ekq5JvGiiu6kfgivq7tx4ULaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob6UrprhO3TzWTGc8jXGN12Bk36cGBQsqwTaoIZBzj4=;
 b=QeU2Hdub5LNgKhBW2C/aNz4NNnbmX0lGYH4ynmJnQ1J7nJRWPPPdwknI16nh2TA7/lvMfcF51vWsIjPOe6kGslB5rU+AfvLHj5G7PwG6KmBgiUtZMb1JITkc71vKOk+CLN4mvFdquu9j0Y0ItxTDOAZKyaGy1SfH6z4ioWzTat+5Xn4w1OhhR9ygI+rvGQiX9puEWFrmy6ZttyurRsxcIj6Y+T3WpRBd0ZNFz62Zd5KnRAb/h/zj/eQ8O15KzmQURC3QlLmmoahDlvDE7Q/6Z/Aso0r1mBGfeKnZ5bvdTWHxYz/1zI1RRr/R1VtztglNryv8W1ZezYkkqoncaiywdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Fri, 11 Jul
 2025 02:58:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 02:58:34 +0000
Date: Fri, 11 Jul 2025 12:08:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] configs/imx6ulz_smm_m2b_defconfig: Enable clock
 framework
Message-ID: <20250711040853.GD1654@nxa18884-linux>
References: <20250708103537.27632-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708103537.27632-1-michael@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2683c671-d2f2-4a50-352c-08ddc026d318
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exAoUuuYSuOMvj+KAArljDHLKqPfUkpoHxAR7fN9GZNXfMgxLOk7QdIMpOwQ?=
 =?us-ascii?Q?H7h1aHeeLkM5/LJ0sfE0G4Qa2MLtuHdikg3KULCfLEXUFQ/yLb5HHiiG2ims?=
 =?us-ascii?Q?2vG+BBVs65m8TYiTTHGjhXe/RO1mDp/tqWkBaiGUyRPHbMeH8055VfFCNfjj?=
 =?us-ascii?Q?3A9srDFNTr+CMOeHF0OC8Bel/ZYbpqcYLcTrwF5LqRPJoTV6QSXejAgzvw8E?=
 =?us-ascii?Q?ItomhJCE3134F4mrpSuo0InNrktc9t37HvMjf0W4V31Ne68Q2WDrkFdhF2b6?=
 =?us-ascii?Q?O+qwjyjtfTNnKTlFKxhjrzARO9JZwRwNo2apISBZj3V+DYZv11qEUIkaG0qC?=
 =?us-ascii?Q?qG7oSPGH80w8LpoKpww3xbigJVlqvun+1RWgGGIseNEdn53cWJv5WEiNf+F0?=
 =?us-ascii?Q?R9fAsLscq7Mnj10Yux43+3tw+EDtClt6AKFNTvticBEhvO4C4wjZduGIAjix?=
 =?us-ascii?Q?G1Zu4Su0MB3L6N6OiwWlNpN6Kjv3tWuDTGRlvq3AkvKawc99GkqM5cwfRddH?=
 =?us-ascii?Q?ddOPJPiSVeCh6jRhRihHzgW+1UzN0TGkD/asGsgQGWAZI7lRlvS+bQTGZ6RA?=
 =?us-ascii?Q?OezAvZQMMPLq6LrrpD0CxYkW13SHSP/0gp/9G5Hhcyi/+SH1iLwqKhwNlyP0?=
 =?us-ascii?Q?Mkekzt1rOrfBrTw3BwJO4ORG5LSPxbHPUBPn2dJ+JQ4OzKtvnm4YWnXvmzPp?=
 =?us-ascii?Q?QPKc9JAplRL765tofaBTEiPEDGz9+rc1wQgzzaN3VZ9JZtiMPZMwivfqhpMM?=
 =?us-ascii?Q?OiIrdja7++hdKp3XrDF55+UBsc+xankZDrOyFlixfK+OgPHttjW+8IXbuFf1?=
 =?us-ascii?Q?dj/V2cbHqVbw3xY8Jn3549DW7DuNPiNMTGWEEOKM9s5mLgA2yd+u2ucudw1y?=
 =?us-ascii?Q?vzJusiNa4F9bC7O7KqXDu/tZY+Vif4rSVLBIr2kkVslS4OjbQDZ/NxjmpcnI?=
 =?us-ascii?Q?CjSgiS4bILx5RZmO9O/XLFeFhE5asTV2kvsUvi1AL5VmaKGonOQfkUEUVK10?=
 =?us-ascii?Q?VQna6pw/HizLEhUMVg/Ga/QdOhHGXF7klh86qP5TDLbrOeZ8FUnyY3jdSHvf?=
 =?us-ascii?Q?jwE+3NWYqeEEeGlMlcmrVtEKRh1bUOhuq9/u4pgAGtlb4lOTbMk+SHd28kuE?=
 =?us-ascii?Q?+THWbn49RaKarw10wt6GcOy/ceMsjUiKyhDKOULAobYl30poWhWUwAZajpfL?=
 =?us-ascii?Q?UIYGMFaYJwCxml21ktoEPEDf1Nuv4XmL7XWM4pbDHABzyW7ZWB7xqAobsCkx?=
 =?us-ascii?Q?4fnDeVABXGEMjNrxS6okWYpbek47sS9uOaMjTwTuiYwvu6OhcLq/rayPiJor?=
 =?us-ascii?Q?XZOf9ik4d+O+p6WwhS1ssbSVsBVPK9QWT4fw2vHBtT6SyPF9JcrFA0fKwIn+?=
 =?us-ascii?Q?v1cdnOY+NidZZYJHVuCFBTeTbJ1kpbmyJO1fEvH04pzZ7gquu2b0WFuQ1j7Z?=
 =?us-ascii?Q?3YPAu2w3izWqJHHMXWQpEfb2hfRWxAEC6k0ioiPrQHRune5YU89DJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+5p8+/I0GvFb5E/vsuzlVULLkPVwdW3qOpzdNNClwC3N6hgQ9219KR1hFuK?=
 =?us-ascii?Q?ed9WQzq6REi1Ao0YxG7LxTR8y05aKptGyBPmzmg1vmoXWyaQ0jFiTNVLooUY?=
 =?us-ascii?Q?UVWvy3H/PpRSRqDMxKb0IrR7OGqCHAPCJ2/nS/ZJjf8JWE4NKkzYV9IqaDcN?=
 =?us-ascii?Q?/abzvtLASKN8iI615X1o0uFlOs4H5Cy1UqzuLG3reOpkw+so2aT8INW+3X9I?=
 =?us-ascii?Q?iGFqGz5/TmkfkqNMh5gfxMoCuQ3BaRoH4Tx9O3wAdvylrKouzdG0DKhGK0Un?=
 =?us-ascii?Q?k02w/3Mhf1TpWWdqUR6/YzR+2twsFcJjzoFfCnHmvCE3mQ4iNByrD+UnY1fh?=
 =?us-ascii?Q?nzmilUkA1gLPwoO16wfjYZKf7xmG8nm2EyjhMue8K3+lfGmLwyjZVINVImb3?=
 =?us-ascii?Q?zCmox02nNT1yCioNBl9wYuOrwcNIO/G13hR0Xzw4i8ZpvMR9oN+nql98uRSp?=
 =?us-ascii?Q?1+Fz+vPehGqgBFjiKA+p1eiilLoCVDf7+/wUuftLYNUrVWaJqvo8alf5dte5?=
 =?us-ascii?Q?3GEyd+y+5HChOcCzvz18K9w8kS4KM0hBc7pjMoQ8YoNRduXS+P3BRhuVmqdm?=
 =?us-ascii?Q?lJsHScP/WjDjbvuqWjSkzEpDqVpML3JtMmc45sz+a2jCbed0klFDxi+A27s2?=
 =?us-ascii?Q?g7XcXGpzCMakxwzv+I2QgGjtWC+1AKdmURw1cN4f/VybqTgHG7HjX8ZLEOjA?=
 =?us-ascii?Q?5NTueUCdkRYeLtAFWcQuV8foGG2oNgqOeDvAHIojnygkeb+BZec0z9GmqBbV?=
 =?us-ascii?Q?q/ljtnsapAjCbPVFnQZusQeTUDdH3jWZo9GeFFdPduzkl+zroOYAHGKdaucm?=
 =?us-ascii?Q?dHHlc+LuSA3tF2eeQ/X+e4lM36RWo0WCDRn0SomVYYyp6rKXE4H7dxiWkVVM?=
 =?us-ascii?Q?mpDwm4jdU9SPTiqWyADxYB+ASvd71aYvk6oKzgZn1KLUc84evFc45DDEoh6T?=
 =?us-ascii?Q?W3CxAzqkVcjxhi5geJsSjKYdTFrdrYF5Os8W5v8mrtwo+FVNuqE+4qictEKd?=
 =?us-ascii?Q?NxRd9S6qLiRr3Q0G6bz8iGGU0NVca6qYeAhw3koNfO5FWQ0R+u3SZJ86NB9b?=
 =?us-ascii?Q?AZQkWH0skirmvmr61yby7/aikKkr9OqGvY71Bfo7tmNjT6fAB0n8stIVEkk5?=
 =?us-ascii?Q?maa12qG/5bcvmayvZ4rD2RK2OuSkLZ5ci2IjB4sjnliAiJdDt48igGAI867I?=
 =?us-ascii?Q?MSSogsGcnfIPL+t5VADswhREmozp9SVW0hwW5PjlZtUC+iU8AxyNB3NRxu6W?=
 =?us-ascii?Q?NvPVM7+3ggPrrK6YQihM+E928I63JLQNQR2ZwOUhceu6GWI1l4LJY+FHHQF1?=
 =?us-ascii?Q?iLzVpdgnxrEatM1EgG4aB2Y5BhEaQGX8hr/toEbF9F/LXnqFg2iIgtKSivrT?=
 =?us-ascii?Q?LVnuEfyBPHmSAXznI9rxLx3xIk/DGRwdBgAuF7l6AnkSKXZ2hyS59lKIe6p4?=
 =?us-ascii?Q?HhOHv3VpFfU0mWBmK2ICkeUzcSatgmzRifzHv5L4U7wQKwuR6Sru4bdm+0f2?=
 =?us-ascii?Q?BITvYCSTSXjaNyd7L4gs/oZGFeIRyUwdLq89qRzH7cDWwN7/QV1WKE96Msfp?=
 =?us-ascii?Q?Q4ZmwBZ5kG0ZYFK5LVaFIFI5TaZ035XC5aIhCigb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2683c671-d2f2-4a50-352c-08ddc026d318
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:58:34.1048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3ZgKs2eMMKzC94YeRgk0hVmRYOIf8hsULo+2Eyv/CIUclRwnelWzNh3VYIX+5xxTrEydddDRSBw3IQHsxlt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570
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

On Tue, Jul 08, 2025 at 12:35:28PM +0200, Michael Trimarchi wrote:
>Enable the clock framework on the m2b platform as was done
>in m2 variant. This helps to increase the NAND controller performance.
>
>Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

As I understand, assigned-clocks will set a higher freq, so
performance improves.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
