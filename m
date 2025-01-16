Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B24C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9378075F;
	Thu, 16 Jan 2025 14:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="hgRjdr7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179E18033D; Thu, 16 Jan 2025 06:44:38 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1009E80040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGp4YZ+huN5umSjn1rs0rpI32vH/Bbnr/RmgmUrX6iaQ2P7mDnISsLcQRbUuxwvqHygFTUw7KL7ts7dGTLjoVyLRrlBAJNgMoX9TZnTVNshJQ61M2Ncg/24yfL1uBQcrFIqd1W8euVT5VD3eFz46K98jc4rEkW35JECBZuDdLMYk9MwsSoB3Rj33RhniIZCOe76eW334cxTukyCHr7hBQ2pgD1GpoDnH0fi2YiWsqY368DNnf113VdcpWspXD1Sfx1ZySLFCiA+rpyBSKVVVADhAd6r/PGTfGyiQTiFSIy1toVUjY91mfIUAJ2/wtJcdMIyP4LifI6ZN1PcnxPDZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r6Ju7wSftUb2ceLUUYtLJ31ElRN0E5CY58mx49WXsA=;
 b=lse7lf9M5kuYyGA5hKVi2c1tXKYQLElwNh6n9dvyCze06okn4VOMKya/ljl+o0i8x5y54p9/id+UY8FxidpH1svaLM9z/j4VHq3I/AcmDbD3IcnIvK8UsFVxfDumMRipPD8hh/R6kiisrRPQJ5qycoV2YWSrXwpNqgHSS7qyug/Xdz0i2oLA0kGhHcvkDiEKVVCJGrxbXrtgvL8Ou5kw1gRpYw1XaHc3xOflH0CFlj4fm6p78rXANPFWB+3PBg+ACZL6ejAT/JCUSiNNYZrozL5ST6s5Sev/7r3g2tFk0J8Xl4LjTTjvv7X/hy7TQCyfRmH0aNub+8glL9CQEdBm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r6Ju7wSftUb2ceLUUYtLJ31ElRN0E5CY58mx49WXsA=;
 b=hgRjdr7BGr40zmsoJY2nIgIYDLycYyCLh00wM7roB9BjAcJOZcNhf6u03Hv5slM5w9IYrWHAwTy+O5834oeqmb7b93rTIm8X0a0TAyLNanbwsmHfl3wnfGZ7pSeejFhkwCcQeCviY6xRxHOiv7Baeb2GbWUp4vkywP3LV0IHlEJLJN/bqNT8NVyT5p8jswXPVxIo4qkZSPwjbY2bbaG7d3t84qFKvermEZPBb9vvk3OBWH7tNoAfbTt2YiNvo3f4H73mUHQFfKVuuvX0SFsnp6v21WhWC8tBBt0EaTaPIPvuFdjhueQBNF4Jdwluu7bj7EHHsd1MzV6aVX/JQ4dn/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by DUZPR06MB8794.eurprd06.prod.outlook.com (2603:10a6:10:4db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:44:32 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:44:31 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] Fix bridge gmii2rgmii
Date: Thu, 16 Jan 2025 05:43:22 +0000
Message-Id: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|DUZPR06MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d2ddcb-d886-4158-e14c-08dd35f0d978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wA9y1KaswZiw3W1T49zr/FQmuWtZ7BHpngcKcU6WZwGp/M/uDJcs6ZiKb1Hy?=
 =?us-ascii?Q?CrYqKVQ+brHZGrTQhl9c3F4KL0ykgXQ6q4auqfo4vY0AfvNhnfgLLM/bCvWa?=
 =?us-ascii?Q?wv1grURBdnYEFoKeLTkl/gJoi4DAKQatcD2+Yi/I0vxttdHLLIMAfu6wUTHX?=
 =?us-ascii?Q?jdaRzlP64M7EIKe817Ws+OxPN6noW9QBHIHf9nut6VepOy3ZKZQsAPmhFC8W?=
 =?us-ascii?Q?7WwToDLnQvJbod25I15kb+5fIzCmjN/Gz//a93uql62mkXuO2c//wWHhCmQu?=
 =?us-ascii?Q?hXw4GqZo0yMRNlLz/rGn9dPJspwoaNXRQFpL6ghctWQjqTkCOv8kQNEmHxK9?=
 =?us-ascii?Q?FacM/Cdfv6Z8/bY+GXqHmfqC7SRVXcEbpXJrEGzA/ZZa0aTcEq9BCJ6/XUQA?=
 =?us-ascii?Q?2A99s97XquMDho6y1cgpfkRWEZ3xJ7iX3P/17eYQsXlkrlTi6gOTUPQd9dVH?=
 =?us-ascii?Q?3R5D2TtTqdskZE37hoDnnDGp9F3upFan0Y24d0Eo3I51VHk/iOuqr/fxrB74?=
 =?us-ascii?Q?eMEtjiQ0jV1OGkOJzTo6IjaBJ4e3TvonYqF6C5Bzcr3OYg3vwRGmUCo75k3D?=
 =?us-ascii?Q?pfHBo97zOAMzqpAdeImPuk5tiC4g+eY9IuHijKVE4YiOCrzDMY5AlZ7UYEQ4?=
 =?us-ascii?Q?XJl7Xpv3QF/kDkjGtPOUVfgbXKyDqtWqfyqOa/cNharfJr2toYhvOEMO+7vK?=
 =?us-ascii?Q?/BcweRM1WGd9LQ7tba/tR5DNd3CF+vCIw7C5rwaM32cN4f38dPD2RnRaXJ+T?=
 =?us-ascii?Q?19fdPqVUIShj5iYMuaNEBD31UAPh/ZrtTJjQsG+Gtwo6GCJJe8o6rC+jcn7w?=
 =?us-ascii?Q?WffBdfhaYnrGvWUzIc4BOqoLjLidV9dAxyG1ZTzmhkpnzM3WnG9F5ATHlJ8a?=
 =?us-ascii?Q?DR8EboStm6NxLS9FvonDAqXpjMqkLHQKfkpFe2XnVAzpyPq60wxOzX+VdCAj?=
 =?us-ascii?Q?+9jKCGS/sZMiHRgHPq0Pge42xI4BkjVVmg6bbYh3HGQPeyExBrjq6f8D/IsA?=
 =?us-ascii?Q?21XioAr6nxvn2PMZt9wzedMxLHQOz2tlOqbV5S7WBloZtnB+ZR2mEdbQS6A8?=
 =?us-ascii?Q?MRHyfVX/bnAUn+9sGDkP+DNd1tJTtgVv1Df88sqaui9do3bN4HR/JhNfVPOl?=
 =?us-ascii?Q?93cJV/ZIahk9VQ9Z2ThcbATZmr6lJHAaQlygcSDqfBNe+kFgesLqt6bsQxGJ?=
 =?us-ascii?Q?vuDdtU6owpE50NvS0utdHYhiBlUWVwVOFL8uk5EpLlePVHKIojTKtS/Xb0//?=
 =?us-ascii?Q?E4aEBGwVMV6M3sPg/dpXpVt5lxKdPj5k1iYbq50s7cQu4w7gOmszJuKSG+n9?=
 =?us-ascii?Q?Fig97G4YRzgdwuVsC7afSvatYRnvYBMIaZ2p2X72xq8RM2ZojvPJ5J77qAqT?=
 =?us-ascii?Q?kdw9XhkrCkOJg04OEFFKwmWE49K9GC0fuDNG0nEHWVPdKBBRW4Flt0zkJYCg?=
 =?us-ascii?Q?/9CcZC9Lmcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ortWjOYs7zG3AuaT+q8aSDh/sr9ae1Wqkt9E5gRS9Bip6yKDeVsVPAOMNUVB?=
 =?us-ascii?Q?tPbspDtp4xAp+w5TCH40KJ59qPBy62Av5ubXlN2JfalCoAidUibvW7AZVKZA?=
 =?us-ascii?Q?9du0gZ2vFofwnIP0bQkM9mwXuQitlAAnKywwGMnH53FgRg1ovTpqgPidIYx2?=
 =?us-ascii?Q?T10DVtcYwaT8ubDT2z5IwaImVMzfH98q3+b2C/EyiU95AfzvPRfOIVQc2X7A?=
 =?us-ascii?Q?N19+fAP+TAATds7gg8PVIJGNFQBWdS02QenSYNMmR3ztgIOt3AgncPu3sa92?=
 =?us-ascii?Q?2OUN7oSOtYWoZCSezE5rJnvyKRp19RtMIywHkScsKrXoj++8Gh1QhvYTYgKG?=
 =?us-ascii?Q?15d5MIVOmZYyk3dWZsSpJVonqicTEaVE91gUzFL48SLD8yBLGPiEA0tUWqHb?=
 =?us-ascii?Q?HFnewCoi4jNbDGh3Gt4AkacenjURFNmOJsRaFqzJKRbz1zae3tNkm/fDxfzv?=
 =?us-ascii?Q?2pqTmZejo06Xw2aZoXGWPwUDZhW97rHHIfd7QijvH9BNCQ+cJMXRhj7oilik?=
 =?us-ascii?Q?C/xghH0VcT8cOppkmHsQVoWXhUoVDzyMMdOkPZikscdAgUdqV5u5Gfhctt+f?=
 =?us-ascii?Q?N0nXLRYEL15VV1Ba8NMEEzpQd0IJakWGJjEZvkC0opIW4KTDhVMoJIjSpMKN?=
 =?us-ascii?Q?7BbwRiNl7tqLlkY0437rh1WFMT3XMAXUwTQH5bOJIF8bp+6gVQW2wBOPeZpr?=
 =?us-ascii?Q?k/z8wm6Wb/O7lO4GPeHP8oQnRf1fYPFEGmqTFcThF1kbKbNEznioyAw1nDO/?=
 =?us-ascii?Q?2dNbqrUcVKFPZQOBluV4q3mrAdeK3nqP7HluCDqDkibwN0sads6chilND8Z6?=
 =?us-ascii?Q?fmmoo+ue040cFxkffT0fJS2cM5+bsCeraCbJg3dsc7KPLh5zSEDfYEG7eBiX?=
 =?us-ascii?Q?9rHYf5T/tsxq1xcSY2o44zmwCuiatIejjK3/hEPJ/q0MaZdKBV3AKU5RIKV8?=
 =?us-ascii?Q?RM+AVQklfrGzbhxprM7mrcy4JuaaanIsfxRkxS/peZmaVHrU1oeaVim4qI52?=
 =?us-ascii?Q?by4LFyYHRx664rlV7s+vqOvv4nBlI1LCQJG3rmxfzwrtjl1t8Ep0iYFRV99f?=
 =?us-ascii?Q?MFhZfzEkN1f0IzoF2SXv8PDNdw4iz615O6G60DTqa0KW/McPy8JZ4NQ5UeNd?=
 =?us-ascii?Q?RfYKIXB2LP1Xh7n/gLZxWER6WOuFheCziqi8pFUF8iAOmVi6x7zURYizv5B4?=
 =?us-ascii?Q?Es7YGT02wrpXiJPvFdWXyGmL3wpyIqWcGwRNCwqU8wkIW7Qd5d8XtRrV6yNm?=
 =?us-ascii?Q?jkBHLyUuv6a59V+S5sDNoS3mHjPN3UJcNfZkFMF64yGQErx4jS6j5gyF3Qag?=
 =?us-ascii?Q?6EeqznYHC5xccnJG2cAkyGi2IvGOCSoNrKeGAuyFYZvbfw6IN0AeVN3FQRO5?=
 =?us-ascii?Q?lph3Fll7Npbpe4P5XRLdsc4iodcf+rOfAL85/IInou5vnf9iVDDgaGZdS1Tr?=
 =?us-ascii?Q?+uEUGktdM1DdlSjT6eElzrlSEt/9mgIWotoRgoB/aax3jtqp4hxs2RLvu6+g?=
 =?us-ascii?Q?u5U9eKPBb0V51V0ODmejTeUnBRBDfG0v7i9LCtsDkEqSL+j1BMdhC2t/EV7T?=
 =?us-ascii?Q?VC9Z0YoHb87HDvpNyRfFUnNclnIfiJ+Sghkoww7dLSUmsHhWVZv+H7LTjOUV?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d2ddcb-d886-4158-e14c-08dd35f0d978
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 05:44:31.5429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFS7k3dLzliVBDIb8nQtFwSsJvxS8FzAbNVSluHiSjnwocEmFa55PFt2Kam4pOwqJTqyniIFi9gIq02vh/L0OZ/JEa+lGjApzlCWeJMZgcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8794
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:52 +0100
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


When taken in use U-Boot v2023.04 one our board's ethernet stop to work in U-Boot,
which was working in v2022.01.

In v2022.01 the gmii2rgmii was called before PHY was created.

This patch change back the order and fix the problem. Also the ethernet-phy-id
driver is taken in use in gmii2rgmii driver.


Tapio Reijonen (2):
  net: phy: Let gmiitorgmii converter create additional PHY
  net: phy: gmii2rgmii: Add support for phy ethernet id configuration

 drivers/net/phy/phy.c               |  8 ++++----
 drivers/net/phy/xilinx_gmii2rgmii.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.39.5

