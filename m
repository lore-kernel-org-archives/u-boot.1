Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA67CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE32C8312A;
	Tue, 14 Oct 2025 18:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iYcOTe1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFFD80422; Tue, 14 Oct 2025 12:14:11 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DA28004F
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 12:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncsRFET9kqjz9MKc0BTQ3z0IlU5hnSVOUbKJyNcgSZ85a+fMHGY5QtIhh0BPl5P3mgeHSZdXoj1NJyn48ooeCdA/p0XHm6d0t5XPguiKcyHxOWrIg0M/UJK92Ti5nKrODyvDRilAptzWmxS1mNCfzzLALHJquphRyVOawUahLNek8U5D+1p+RqAMMopXLutXW0eXmeLlyqtXfsgD/YAdtXvko61VGKWMxBkvlKvPYWVlYScQeSfq6M+3/kd59ss08MvduPip1ykBLsv1pwG8TMiKjJoQf5o74TJJB38K49ZVM0cDI5L1UWq2a5aEQo7ZcXeAJOSOwk6NNTgFbYbs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpmovaFOVcuI7KCr6xw4BUti+h4GKhFLIGWiaRCQdxE=;
 b=dT5pfKquI+auYgetjh6myXQ04I5xcg+BudfkyHllrAawsBsB04rNOCkhsq6EmKfqgShKv3bAoURr2mintHFvbzpNoPmsdh3aLXdJZO7Yzb7BJXXj0mJzdsDA3F9Zx6b//dzA9oPSiiiSK6NkIP/UMeKx3O8e9jWnGUJLP+MPfB+VzLRoIx24XjUXaCdcPfRU/cIyz4aCQiq0M9SIQxjGdOW4UUSFde+niL3kE90swR9Uj72NnY+gajdqhfd3vImdyUTrH9nFCG/pKMN6Mj5Mgrqa6XA5PemZAvdt2dObs8Uy1y3V8N22mXAczEWFAe7WopkmWPIqLSLuluCcmcNxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpmovaFOVcuI7KCr6xw4BUti+h4GKhFLIGWiaRCQdxE=;
 b=iYcOTe1AeemtpCas0Ry6dv4rT9qgB8fjcls8GV4LtH9kogVcytw5jnKEb82ylt8Xs6rI17m7rciizPYh1UpTQ1fM4C3/SVD7SgEI73L43arB5ZKz5IFzolZJBu4ntuwc7LpUK5l9pYV4X8gr5juoHLKFyfYgnQ392m/efHkSBsd8zBxNqs5cZHznLw6+OqfymOiCXu8gtz/ucPrN8BzCmo3Gi/jEJv36aUQRQu8XpqJo/y9YKhU313M3a8EUajfrb6aTTLiRkaPfv7LF+pyY+p0TyLi4DnWJ2TQC09H6VyRvEVhyugHfGk5eq/3xIE/wXLpCZe8pPWCJ1bWa4HZlTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5056.namprd03.prod.outlook.com (2603:10b6:208:1b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:14:06 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:14:06 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1 0/2] spi: cadence: Add xSPI controller driver support
Date: Tue, 14 Oct 2025 18:13:52 +0800
Message-ID: <20251014101354.11182-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 550f2366-0824-4311-0a7a-08de0b0a686c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2JVLp4lQZ4QkTEtX9pM/PWokss/LNYsphhyOD4NgsKUSO9IBCytraVY0JI0d?=
 =?us-ascii?Q?5DgX6Nx8YLlUy4V2J5f/94hb7dHhsHabKk2t18P/qrwNW8EJQbfdCO6efOmX?=
 =?us-ascii?Q?LVfYqwAhmfRqWsJlMueysPOfDZBjFaiZDjDG3FYHZs/PiYHM/WUCP88QfuG8?=
 =?us-ascii?Q?s4Nnza8nMK3UlSkkkuGeEaEe0frT63K+TqrK/vB2l+r4yMIUJz4giIt0c977?=
 =?us-ascii?Q?seDzsVZENvk81RYlI5uCAlNAJPuLQ744ITFCjTDmKfYeBIiKficuIG9QDAnq?=
 =?us-ascii?Q?MFfOUfUH8wSe/Lsbp8CiMv9hlGHEDiSV5IDmiTbKQjLpt6ukDofUl/ea22tx?=
 =?us-ascii?Q?Nu9B9KooSBvCNLVy/PTKlCpbxxbCZ3gCGpjX7ZlM51qJ57qko+DwJVhCTdiI?=
 =?us-ascii?Q?J6tJPZjR2dmWzZ41hnOOSxvGeRX0bO/Tc3GosmRkNvQMmv7Xpx5ZrY3YQWbw?=
 =?us-ascii?Q?Uk/QKEJAImK/vRzubHclupiDjxd31wzWJCGW0LUNFV3Djk6D0w7fJjKPAp7q?=
 =?us-ascii?Q?heNgNOJUJPk8qsS0VNhz8aIQ2+rRaIS4fTw9j+r4Exwwzn4H0voHIQSxZomY?=
 =?us-ascii?Q?WQxLG0E8v5BW7/v9PSMy5gbVKKJpO/4Cqia5y9xP9+u9nkKmVosz13qMnkro?=
 =?us-ascii?Q?fCOdIYOyiS4IZgGjfFd+L5z+dwxM6zo6pWHZ6QYivTrggxVywEmOsheGf7qE?=
 =?us-ascii?Q?rmnggJu0jmcY1p2HsiLtu8EOCFtkU8VbUbTF/Smum3h3DDTQE52Oyv04BLqf?=
 =?us-ascii?Q?hfSxrDVkqnfYN2mJD51tvAxIQAq0o4IhL0ejHUbjYfr+Esf9OQOKOF928hXT?=
 =?us-ascii?Q?9z/Sl/J/+XLwhl+6u1MNXdPmffyNDZlENNozhsU64QW16LjuCsFBEsydXpeO?=
 =?us-ascii?Q?8quYsKuIQxM1BL6j6meUuBkPCWUTB/b/8O7wD/A+SGV43HevxDOdw5PZOZ+S?=
 =?us-ascii?Q?R5zDFZnbDsMLfJ1f/f1XY4EMbaudKOfySXAfXG9cQCNNYnH1UV6eDIdEw6WN?=
 =?us-ascii?Q?aq8qG5I07DbcK3mbGxerq/VA+Dk7wRQBxVLVzW09zcLyY4fypCS74GS+StN9?=
 =?us-ascii?Q?T3murp+t9s9tRyg97+DwtRELnBAK3byht9KvmKdMNcvaZ35ZWFfXYDPZLMfA?=
 =?us-ascii?Q?FQpeQKPIZ+UNgR7RxZ/rhBHlx/AlBCRJH9fqh+ryqHrkknJwKGaki1w/mzf7?=
 =?us-ascii?Q?tNDvPG44NQ5SYgVk3+q0IvFGBfZ6MEufGZbB3ex2R3qzNA9fM3Y+kkRaj5L8?=
 =?us-ascii?Q?XFTUEYJTnWaFw1tl+XNESYkyf6o/HeQAWsqC/599+bbP6K3I22Hs8c7it2HH?=
 =?us-ascii?Q?5W5/rvqxRwMsf0P8uguq55SU18lx/MhTKsWjyEu7f9GDIhW54Ynn2cTUCwYN?=
 =?us-ascii?Q?Rt7D9Y1X2nrR5v3CKRrahix4t6pVv5fQNG25gUkBYrfen0mf9Ho1EQGSJeB9?=
 =?us-ascii?Q?6DGYA/sTFoFNNV+pI6h4YRgI6z4lYFHU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/uUzWHn5K4uyq4kWrDLCIvCXjz04dbjedhIW6RgGXkoFGHjqb2fsWiOQIZb?=
 =?us-ascii?Q?HsngJ5Yh1pStCP6IweEKXDc/ebKAfZ7+OzDrWX6xmz5ZRy7ILjR3kggxUOWT?=
 =?us-ascii?Q?67uIZtzPKqUEvXFhCcDXNwp1NJ8ARURD7HNhjY4dLXDeqaSonDlq/Ueu+gmW?=
 =?us-ascii?Q?6SelOdZKMg8Ejf7j6QUz8aqEOEM/4XuyCTL/KcTjGbdcYZ6bd8wQBAok6Qyh?=
 =?us-ascii?Q?6m5s+SyC++QN+4DwUdQKA4erxH6WyiyFJX5JQMnl7et15HvZ8+PFizqVJ9Ma?=
 =?us-ascii?Q?FsalqkPxG/xRaEiA0bD9rkHLgFo8LS2eaKXPND+USVRJEImi7VLY+1LZQm+8?=
 =?us-ascii?Q?h10VCKHwUJct2jhiF0PTy0giOwD0O6auYAm0zY4cFj9zxiTMI2IzI0Jqidwk?=
 =?us-ascii?Q?WwTZxPOrAV+GoSn3nBXsxloJOAcjH4BaP8wU05Q2N76BkD4ubkQ5ShQroxxy?=
 =?us-ascii?Q?fgdk9ONNywp/6lPBnTczjFQdhIac5Ve9hds/KOOmuZTxFevGkAPoCIWy1IrY?=
 =?us-ascii?Q?unsL4q1DiA51nFmmK1LBAyhJQ1DbHVRSVCI5wf0YlAIOMC6GhdeoQuF4yhAv?=
 =?us-ascii?Q?CW6W7JYkkldx++mc6qdz8y41yNuXpLuBPhrJB6XNfsmagagNkid1w/dZzxcv?=
 =?us-ascii?Q?d6ZyRhoVWjgOrn713kVEvQDYC5dyqUlti6XFYm/agqbQ4kh5MlbSFx1NME/L?=
 =?us-ascii?Q?oQP091eG9v6aFD2PdyZDZrIGNsrrd+pFufcwx24zErF4Q9idCEzfG72ZcgAI?=
 =?us-ascii?Q?LmrBkYoB9k5MvSEHSNyNBd03V0l9YwBBFyDnfcdqH4k5NPahV0XRBZiTm2/h?=
 =?us-ascii?Q?YuRVDvmXYO0WPIaiAAFjmtQx4UvyngMBbpATkGS20f/+kEWGGjGmzcwhV4iR?=
 =?us-ascii?Q?Q6GjvFQWVapGVITLmPJJ/+5cizrblhbI5DTSzykMFBkT5IcYA4JH+rXjFdc6?=
 =?us-ascii?Q?pUuSC9CZWigWXwpOcXw4MKoM/fiM/zVUBR9q3lBpniX2uSZLhehRYYfBhTJ1?=
 =?us-ascii?Q?pAhkOXDXEtO/HBGeQql2W3wxRTHNt9bb5b0ANs4SWqgDam1I6at9qRgQf0kZ?=
 =?us-ascii?Q?2Ju7yKDl2HWj0KTrqr7lFSy3TQu4s3rXuP5c2ON8nM9B1i8BezpuGUOgdXTx?=
 =?us-ascii?Q?efFUswI5jJo6IMVH5JgFku5Ej9JAAFZqwVVlB1wTF8AQU9W2Vg14/vBbY2ac?=
 =?us-ascii?Q?3wkqa3RpzfX6ZqOFZ12MPjVaPAglEuu+qeKoP1vj0QW8bYUgYIzB+APp+cN9?=
 =?us-ascii?Q?9fyyan+csjEvzS5QMVUlzcPDK9vqvZPJWIjXA9nfr1GdHXgqIn5Vkivkmib6?=
 =?us-ascii?Q?Cd2CFBbP/oWpLvyeqF2suH840gKqzwutTZLxcjCjUJ28YWf85RHjCpLCcoqc?=
 =?us-ascii?Q?CD36r0EoD7BCdZek7fMjrFDdHHxieqEL74lZ+VJX1k8k0fcv09t13z4lBpvh?=
 =?us-ascii?Q?BV9wpaqzcaAsPELdGMoW+XSdoS43AT+39uQqPHUxMQoXRdXR1OO2K3vInGXj?=
 =?us-ascii?Q?HhjKrNNkNMRj9bulLpI+CZxLM/YaeXKrIJAV868kkNlLPsmyJQiWRVxfCJFu?=
 =?us-ascii?Q?JWPSDRJJrTAPKazP8WhQjLMbAldngAcyMYu4SrkP?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550f2366-0824-4311-0a7a-08de0b0a686c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:14:06.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa3lDhXJ1PRY8eXHE3mDp7iX8XvaIPw8blsp83AnzyUDiQFDR+iBaz1loGQ0p1tUkyCLz9R/V1zR1TE+2D3+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5056
X-Mailman-Approved-At: Tue, 14 Oct 2025 18:06:29 +0200
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

This patch series introduces initial support for the Cadence xSPI
controller in U-Boot.

Patch 1 ports the Cadence xSPI driver from the Linux kernel. The controller
supports three operating modes (ACMD, STIG, and Direct), with only the STIG
mode currently enabled in this driver. The driver has been functionally
verified on the Intel Simics platform and is intended for evaluation and
experimental use at this stage.

Patch 2 adds the corresponding Kconfig and Makefile entries to enable
building the driver.

Boon Khai Ng (2):
  spi: cadence: Add driver for xSPI
  spi: Enable Kconfig and Makefile for xSPI

 drivers/spi/Kconfig        |  15 ++
 drivers/spi/Makefile       |   1 +
 drivers/spi/cadence_xspi.c | 449 +++++++++++++++++++++++++++++++++++++
 drivers/spi/cadence_xspi.h | 226 +++++++++++++++++++
 4 files changed, 691 insertions(+)
 create mode 100644 drivers/spi/cadence_xspi.c
 create mode 100644 drivers/spi/cadence_xspi.h

-- 
2.43.7

