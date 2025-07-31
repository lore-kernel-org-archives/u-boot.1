Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AEDC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DF58334A;
	Thu, 31 Jul 2025 09:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ueFQLcUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48640833D1; Thu, 31 Jul 2025 09:21:35 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5EF8318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlpj31EwPZNrAJ1PQ3HAUvdy0T7IhkyL+L9CfbcU+OlS44fnjl//kGIion9KcLhIMRrNMCcSOjUHPWjPVSVcZgNfpt4HnwH04mQnWAr3Zksp9/ZybuDOUBEl6NECDay32Hf6jdThSCbARMpkPA8w8vEj1mzpWQZh/nWmYRy0iLjKyQnnaW4VeE5E5OFk/jyo3BApgjOvO6T7uiYWAzNLY2i56RlAzyKLRetbHqNTmvD7mVmjWEtXB4UNL7Ta+4noMwETp5rUppjvhDSNxWfwOYw+KZRqcX1qtCYVquSa/DoRXD4ApL3kfBIMFXodF7O3GEpzFWW0ovi3yUcAQtaDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ7ON+BdOknah4ZQB15svoO92IOuDc9wUBcq4IyM5K4=;
 b=Xo3rASq2rq5HC0DBk5QQmJotCsVEadkCRAVus9qoKTUeoyRpyMBPZEPrI7ZjLn+xF8bsg8iLSR2IPAHahvfSD6rgROxLV/IgjZm8vTu4RF3Bedf+fUePmqsNNwvF4UKpWGwV4fa5xH2ywWlbHtgYnk2ah+1++BY8MJEvdmfKBIDZckHjf8eTwAoV/h/3rSQ+kmcm7OEL8XviFqjrZL77wFBcpnYiQtRaM2K63VtS58NzIacIriHAnHG0hqbLMAzWDTXYul+pz7/whe3gR/Gg5D4KKNzJjZHJhCgj+Q3LtT4V+0R5Lwu8WMSkxASUl5X5P8HY1SW+FjTZQTfXPoQwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ7ON+BdOknah4ZQB15svoO92IOuDc9wUBcq4IyM5K4=;
 b=ueFQLcUoHeoKkAKHdBkhwuY5GzNMxP2m6NCqAjNeWvbVSjgQihquHTl2k27+tK8gCwdbd/FICOO6qDKLMnzLaULvSEGA5O7pXJKncPl0oP2IYGtnIndbuIKhHRflHoDvSIMlB5ykr0TOpY6qsj69gAdzpfh7zwbqzuZ4XhdUqg/5WRGGj3kPay9Pdjg8DP/W9uvrjSEVnCT+iNEPLIySygn938nzoxnVEfY7jq4W07wBcWZrGoxkryhGWo+dLL65fse9sbNl+1IF+ezk0Jx7MxM+WlNfEccFrxoKpTejTMLqtI6Dhh4zIWnFp3mRAs80DTK0auwkkwNaSJEIv7dZ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 07:21:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:21:28 +0000
Date: Thu, 31 Jul 2025 16:32:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Tom Zheng <haidong.zheng@nxp.com>, Ye Li <ye.li@nxp.com>,
 Florin Pavelescu <florin.pavelescu@nxp.com>
Subject: Re: [PATCH 9/9] ddr: imx9: Add errata registers support
Message-ID: <20250731083212.GB329@nxa18884-linux.ap.freescale.net>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-9-73da75bb33d3@nxp.com>
 <CAOMZO5D_byNG+rRmM=ax0w_gspcqi8k7EFCgzhsnv1GaWmZ1Bg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5D_byNG+rRmM=ax0w_gspcqi8k7EFCgzhsnv1GaWmZ1Bg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 105ee4db-8c25-4905-f44f-08ddd002ddb4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d7JSpnvQ3jo9EGseQ3KiXh/aQhI3FC/YO5q4UzN9sXM5VJCPXcO+Gu4Swrey?=
 =?us-ascii?Q?lgqWphs6M4+A2TdJMh6vpPN8AoWlRpJlNAB8aO/lTmX5fDrRxrsHz3UgKXcu?=
 =?us-ascii?Q?64LfciBLjyfSY4gzLy/nmOrV6TmSXZyVFGj4Y2ffy5PfN0uUgr9DEAd7PCPJ?=
 =?us-ascii?Q?nMZIVAJ9zwHo2SZPawEsp498gE0xK5exPq3+eNlhY4MhiX3yQ5AOy7YCGoNy?=
 =?us-ascii?Q?BLr59+wtNkwbw0j+F8TOG2nRwPo9mF7EXocWFpXMDgf8x6bQCOj7ZF/vjBJ9?=
 =?us-ascii?Q?Bo5BM8Lcga8Zzzh4tYZv/Ege8pU5H5lw0kWcVfECSsmlxuWF/Lxs8TZ/RUWy?=
 =?us-ascii?Q?GM5H1RPtI7AUWfKiQR2F9jmXZTLHCpKPbffyuG3VwHO5AOp0Oq8WBfiod+sj?=
 =?us-ascii?Q?LFD6B27VBd7RXt4vhcF/XWkSk6kD4dIETVlrvfOmflgI5oObEaXOD0MvbCGs?=
 =?us-ascii?Q?FoiGQHBld/74vmK06U6aBa3eDk+tgr5ShmpOHntnM3GLFc9vI94aPKAnor2c?=
 =?us-ascii?Q?HLdV2wJ2d1L6MR0zJWrdnubRf8Ibv0ZBZVnCXfKllxg67vpKId482K2jug2z?=
 =?us-ascii?Q?FqrS1Hy7ERnCnDkexVaTkJB8qvTasww8pbfF0FX98Wej4hmaCZj6Rm8XSYOG?=
 =?us-ascii?Q?ln7gYLSc/cmSiMqQsxvYlCdyYLC5II1c5f7Nm+J5m8VfSHLu67Eylx8TxOor?=
 =?us-ascii?Q?KOLWjzEHDaLtOFKm1va0roAXEcZ9aUdUlOXzfqMyMCmh/LBMQIsVq7WRzoQ1?=
 =?us-ascii?Q?FwLmHLTcfVgwAdUx6ShgEJe6vMO49jZtil7j5xydjDZBUFV1ThUqMv3NyV1D?=
 =?us-ascii?Q?TBalzEZxBFrrjvKpw52JsQplAzjJumnJU3LSIg+JMCQvWwC9qwc7tDqDbMO3?=
 =?us-ascii?Q?ozG9yp48+cD4pTebUQHCbak4AFYhb9E+CNXnYWVNahvC3AGpQ7eB3LyTocWr?=
 =?us-ascii?Q?SCF/ATzav2Cb+9RMCvuyAff5fk9ID6ZYWEM+zuhHW+7evyxr3zXpyuCkV2u5?=
 =?us-ascii?Q?k1Ja/yOtPvYiz99UMR/tiLLmFXN+LXvFju2Ro77DbRg+097oAgK5lk2hBsZz?=
 =?us-ascii?Q?tBbQFz+r5A2GOsXhCN5rW/kS6I7dWiwFh6V6eNUYgS5ImmYyBWFH6dYcZ8mY?=
 =?us-ascii?Q?+hyZAOw+mI/q4xeAMQX52nPCyoVYsIVsrHIFJDWNg2zOP+Vx2jrRzPpZ9/Am?=
 =?us-ascii?Q?3MDj3BkfoXMaXUxeXrFfwmlCtryV4TC+Q0TU78sIUZtntks1oiVJvdhReCGD?=
 =?us-ascii?Q?2YRBqbuSrZI7uXcUr3811NuDGPwXO/jNqjYJdkjCKBd8N626F2wrkzFPuDE2?=
 =?us-ascii?Q?rv1lEA/8DQEC30HpCubnLHgDNZRkOzvlTw5tUdyG5OuxkMf763hPUkE0i0cK?=
 =?us-ascii?Q?9+AdWT358WbcNC4Z2W+AWSb6S943mghpYLrO+ndHPVK6xP3+TSKGi3Sj69FG?=
 =?us-ascii?Q?savpmP1qA9OMp7DNyHdmZWg2p9/v7b3HL3QJjV3VTgWH9Z+gYINUYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TjLgZOHBxCwgeUgjXZkRplx6udgM298EIjQAX+teuBXaUPZHIFt6mujO7bZV?=
 =?us-ascii?Q?X9QbktItLqDb67YPxicDfBU69ZkiCsBohZSjWq4zIREs7CmlPbyCMYOqtmZq?=
 =?us-ascii?Q?fHyLz9jplvupRnBb5qYcr0gZ1dV6hOZdcsIWLYhH1Ple8FXRZTmlTGyrqdit?=
 =?us-ascii?Q?lZoWOzxOw6Egfg0//RiwppdxHk7/0I1T0tPhLeTQaTg2P60d0ATLvQtw7dlD?=
 =?us-ascii?Q?r+6QM37akPMc5CbZZJ6g2MdJVj5gL15IumCqjazby4dQmsdnn9HmoQOhiHDV?=
 =?us-ascii?Q?6MI07CsCritVCNb+ZvdWLlesPDch+46DLXib59nj0mso7FBQE5DeBZaYZ471?=
 =?us-ascii?Q?COc94x3IHj0JNgWpRKEC7/ikU/N7WFfw1Z5c8nimV/bKYuuDg7bZThY3VNPW?=
 =?us-ascii?Q?zR4YYM+Fpowqfr5nuid/jqCyFCHrovUtqemu4amjezX7XLHLnURe8giuv8rF?=
 =?us-ascii?Q?sfwUrmx9i2NCNAmxigDOeF/qR9vA2+ubOvefFme8dMQ6wkStrALpSm/retzt?=
 =?us-ascii?Q?wZj22x4Zr7P0AJL/z0qd9jCQBkwMtzzxEIan976U3d9nooKMvPjdvrYR6Bf2?=
 =?us-ascii?Q?uweI++NT0+YFM5Ng3z/a7/3GYkq0jUqHYR7Miw++CyvDiUT1kg56h/MVXx5l?=
 =?us-ascii?Q?jAVKR6jj58iLLNS84vG5uiAM5H+kwxeWAX8W7V4mHvz7JA2d18KKRQq2k6Mf?=
 =?us-ascii?Q?8j2peE4CB+qc6KfxHzz1v0Q8u+AfszOEROmkir2yEtAXyvct5mz2TLTIBCy+?=
 =?us-ascii?Q?Wb6/3nPPq0bMCsRhdu6Ir1klVwXrLaGUlixMZeJzPXEkpa77HeOvq70MdeNw?=
 =?us-ascii?Q?LX3cdR29dRi8XjgsIMvBX/d43dm67UXbNQmsqaYHQNvaWZ250Ginf2tl/CAj?=
 =?us-ascii?Q?EoSntloJle4xvQWKjVc9os8XIT7NimJzCpCBf6iEkwLt3KXXu9mwywEw3IMi?=
 =?us-ascii?Q?sb27PJnmjKQL617nea9Xj+yJ5pHeqevw+wJ6XQquOKsdQb1Z+2sbZXjtQKnP?=
 =?us-ascii?Q?HlLLUOc4m/WL9niFNkl2o+4dYotUBrC6IaQrYEbRu6fi7zKxSfNWHvwrTCdg?=
 =?us-ascii?Q?8jueSkoM/3365O5A1tP1ASTLq/Cr6fYRHvuh6lniggel5sAbHAKvuAHF4wsd?=
 =?us-ascii?Q?4BpkA3ATqb0/47oQs4Z0kPDVZS35V0rvPXC1Z7wrK5/Y/nuMjTn7gc5j+/Oi?=
 =?us-ascii?Q?SBFjAbEpx5EHqtSNLPeM7WAe6rL2DJ+oONoisI/rmnktNfKOciJodDmYSGMW?=
 =?us-ascii?Q?Lt+2L6cfSAG+hBEP3OvKRRemh7hnIJ7qN8oZaYsy/wjxisaK/YgI6dtaLH7J?=
 =?us-ascii?Q?CelgzejOVVxKD/8Bu3px2lUZt5dMwznsz+kGeI5cdF7CfNv/dxItZHLB24dR?=
 =?us-ascii?Q?o3/KzWP4xsuI0x0lOiLlxP8XzZeTPnTXMP+5yedL3wOzkxY+nYDL33uOSrsu?=
 =?us-ascii?Q?0cQ0r10w2lCXhM2SqyEfI9VTpyV02K1amEjc8bjseJurflViFxdm3e5DKWW2?=
 =?us-ascii?Q?V4QwIBG7P6ffvipVjhv9pksfW+epF0MpQ2sypWeOPWUPA08cecYBvJAQveYY?=
 =?us-ascii?Q?PXC5OnbI9tsqb+Sfx2O6jIdcVqYu0l0EuR6XNmWV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105ee4db-8c25-4905-f44f-08ddd002ddb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:21:28.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzJm37TETRjP7gC/aEU3Z/wJlzE8eoZ2UDXOHDCwIzAnjgpuG2q7OcgyjhQlGHskMrLtXp4iNxLq6PMJi+9WPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
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

On Wed, Jul 30, 2025 at 10:51:35AM -0300, Fabio Estevam wrote:
>On Sun, Jul 27, 2025 at 11:14???PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Viorel Suman <viorel.suman@nxp.com>
>>
>> Collect errata registers values after the training and restore errata
>> registers values before starting quick boot firmware.
>
>Please explain why.

will update in V2.

Thanks,
Peng.
