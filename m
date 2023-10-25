Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB63C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99BE86FB9;
	Wed, 25 Oct 2023 10:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FfbzT/1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01EC87A70; Wed, 25 Oct 2023 10:23:13 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107B187A4F
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2zPeqR29JJ+nCMTRPR1UtHGDcZMtulsYHzKhcad1mYQk7j1/1E6L8eHNfci5i/L97rHCiNtuFNaYsAX/E6sglfpALvCEAFYeCD272gqyj9rU5Y1VewvSsXZzcMokx3U/tBT5L22vqDOIkv90RfYOPtAemvzwSVL96Bjg5pRYZrGFEksVjH4aUCaLfYVqZwWV2ZhrbdUpwVaxN9HjG/0sHYBLDhs86vZQ0ntRsIy/qYmtFJmw9vkudRgPqbuKyZ3B00YYEzFaqDjJfzaDjxmd2f8KHpEiigAZ5GIYitLgfeqvOlwr33eH63XTFQdArhLedkO9zL3DgeVQSZM1UBgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sehzHoBc++jXcS7SrpolttXGljp27iPLIAh69vir9k=;
 b=BT6bjTtsfnxv+9mjTNGze9wh4bA/qYkzsVnr9eYamj5AHyAtOjxEKB3yebtPfr94x4HCekUNPVDfvZP6+dIvxpXL5P+wuPy5xwNMdafOGVGN+ODMg1MUApG4oR2CaqwBwpfLuj2MB24Dz5dNwRNmuNa++k1+QcGijgjhDRYEM/deGi9JQAdRaArCesaJ6YVn1KjqoiphV71vxT2vRtvEAWb+nItI8nDaReTshmwrzvsQuoLV/NFPK9ZFJ+uv0zwo2hzRA0CtXL8sobty3utiOOab3fL2t2y5XzE4KamQFjgrmWqVBxTvNFB2q/Dq1jM7sbmSn6+Zdf0fR47DzQxZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sehzHoBc++jXcS7SrpolttXGljp27iPLIAh69vir9k=;
 b=FfbzT/1ivYZgLDXcDtnd1ivIEwtmEPdACYKxU+aCje8ppNWH4C5xOy8XgucX5VkQhAZnf90Sthsl64737f35JESDS6WJpQAwbTjCEZ2PC8NA7trGOdx/hmi72o0MM0iklVShhWA1tlP4Wx19yAl2FcQHl3/N6BZ6CuaOas24cpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8410.eurprd04.prod.outlook.com (2603:10a6:10:24b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 08:23:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b%6]) with mapi id 15.20.6933.014; Wed, 25 Oct 2023
 08:23:08 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/2] mvebu: clearfog: add support for emmc boot
Date: Wed, 25 Oct 2023 10:22:52 +0200
Message-Id: <20231025082254.31630-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb03ef7-5003-4859-859b-08dbd5339e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzE7FanYpVgtnapFlbW8U2yDrlLabagMJPqXQBEWzgkhZ/Rf8sa2CbRODkokmoXg3RNbY4m0HtqEGaFQJw+/S2+h5x+tYXuXnF2VoaxfTixwuWJAyr31EGXQuVwAMEDvzQFUs5Htulzjj9EnDlCJnJdIpwHfVTwU7ZX5uumwsvvAMAJgyBhs4ZTZDfS5daOTWXwowwgWq9Io9aODSURLc+RQsppatLtK7lwaKFPDftbp6uzXaY+cReCPHcO2s9enpw6FI3QzjviBdUJ4bRH/e1ygAwEOsuWD2lWpVOgEiybzvNg7DyVAvmg67oA8DxJ+wmiJ2yBG/hhou5ebAW3J83epK34d07HxCEN31aP1M9tMC8fXTX+N9k/OpJqZY7uab9JxW1Sh+NdmwZsjaNiah1hmep3oFsJNlz02fp4ar/mlq3n/JFU68xa+GhKi60n5NOm861n6UUOTF+aQvrWSFbG8M0dwcmOdTKCwGiUxUJmk9iVOzajz+gpaOpEcrEzkESmlPhqe+hKcU7Mf6w1yOsXmV40Vegan7epIxFoIDAsZtbAdhxvJT7JVcYUJhDmQqXPvgmzXb/IkO+5GVL3ter6RPUhfaPOeDR7kw7Kidc5OxvBm371Zc/RHJOogoVJS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(36756003)(38350700005)(6512007)(316002)(66946007)(66476007)(66556008)(38100700002)(6916009)(86362001)(52116002)(83380400001)(2616005)(107886003)(26005)(6506007)(6666004)(4744005)(1076003)(41300700001)(6486002)(2906002)(8936002)(5660300002)(478600001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RfijftKMAkTuq4EHLzR7/HYIqymfIuUp7zlGAW30QQOOZsWNGwc7OedMu+R?=
 =?us-ascii?Q?V1+uvOvNL6fO0UQwzz+QY5LJN/zwAlWYCcPcbjtK4TuFDKfuzXjDMOe4eWzt?=
 =?us-ascii?Q?O1fjoB9prXliU7wPusPd13ZWjRX0dLgGeP3oZ/VyW142nY+6kXBZ2w11FPfo?=
 =?us-ascii?Q?BUvCx6uMkdbBCt04YmaDSKIchJfMR8IfsyewTQetJYXOx0DfGxivPU1g8pQE?=
 =?us-ascii?Q?dhGybr54wK9s+0JNLyevsuX6fe6gKMiEbnvvxRv7Y2zc0UeF9fho8HAqG38j?=
 =?us-ascii?Q?chIn7E9VILmiqUFPM/COmNJ9rQM7uwGfLV4y/bhwjwurAWIc5g9HQw44Wtji?=
 =?us-ascii?Q?M3in3/5Yy515ZM9UCUDhKSrNZ91UzuxVFa3eQfNEXM3+sPdBzUOQ5RZ3eusq?=
 =?us-ascii?Q?pduYR/dXPNZgzLojSKD6/PYUfi2Gm0XDmA13hf5bvzHgiMI4G8L7Y8YtT326?=
 =?us-ascii?Q?0WlBeEXUXhfNKmgQpayS6QRP4AGtz6FvPO+0POWtUBaFiqbrVgwE9jNkreRO?=
 =?us-ascii?Q?9RYvfgRastGfLDVFB3NZraFL5HtamilxuYnwSJnJ8Dm2ppWDxhbr7n/lsmwF?=
 =?us-ascii?Q?yOHQkm1JMvSEWzI904tp7RdL7jfhOUa+0J9kR683oKKyTyBLK0f6GRbiawWF?=
 =?us-ascii?Q?HkPfZ0aMy96XeHDrVPnAKY3JT4f6i+zB5pNNiKxnmjdmllRP0LIiEuAYqwh9?=
 =?us-ascii?Q?CmLWWc8JITsy9nN2oM07dnlgEkMT7kZFdiRHKyJHoUHCmifS7DuydWLqTZHD?=
 =?us-ascii?Q?2U2aGHCsnCASbB7Cgr/ovU/sob6gCpYNODKVoHqaWTWo+YN8fYWZrw3j86uS?=
 =?us-ascii?Q?/7Ml9Kn1zT9SWb2fnS4veIZrqotRzdZJR4Zbs4J6yIlVKXzqMJgQBYD+IjCE?=
 =?us-ascii?Q?BMwJlSlSCySBmMT0lAgTGlKRZptEAFqW+H5PUFR+q1reXZOxgFcZ0QvQjoI+?=
 =?us-ascii?Q?ecfVja6PJGE3fykOxLrkxPsipoESHuImsPZv6rG8BEwgpqw3BUanL0sJ5b55?=
 =?us-ascii?Q?t6usO/pNcG3f688kBnu6ahzGn4bJChj9dZbxATkJ69i+wrKwQnoNjEZEVpWf?=
 =?us-ascii?Q?v/li1XOO9hY0R4QA/kcF5nXAI3+/PqH6AeNxnyytqQ2oQFwfSBdzUAXBHxQq?=
 =?us-ascii?Q?0hwAYBhxjhPoMcADjJAW3EGsT/v8fJN1GcBks5r0NN1xbC7/xGQPix5jYAhC?=
 =?us-ascii?Q?eTMg7aY7nv7OUggMsmztrNkdzWinR349HGFvIZr5qCWR5TO/TawWXRh6atMJ?=
 =?us-ascii?Q?f//y9K6Tlv9HoL7oFYpgH8LTynCXaX7Ax4B4oIsMy9YL8nFkOM26mm1IKVyr?=
 =?us-ascii?Q?OAfsKHxKk2Xfqv00XrX5S3WeAyhhSj6RJxJk7+kJbv6laFwNfYWxgyDtWhPp?=
 =?us-ascii?Q?3HUQg6jYdnkzZ0IIJcxImALp/jr4R/0bX5B8mQ/kem1iAJM3o4MOTrbuiTZa?=
 =?us-ascii?Q?4yALrJV1/1oYxBYGcKY3AfBoYPxwD1KJgwLST2RXRKUbmbdPFxjDCqRBFdZ2?=
 =?us-ascii?Q?25arFAy7s3pItem5n+TFDsn4NYR+UyEFJGzxpQBLK5UpQS0NUtcZ0ywQqBqG?=
 =?us-ascii?Q?VigWRpJRWtmwPuBe0lwaQt8FcX8deqv7ngkRL3ay?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb03ef7-5003-4859-859b-08dbd5339e18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:23:08.3945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUIJX0B6o9teJ8MzQZyjeYIO7XEp+K4b0Ybw/lb9q1itKpLh7lFBoLAkaPAvO4UTRDNY9eo/NHNow0G/DOVEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8410
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

On Armada 388 booting from eMMC is different to SD-Card in two major ways:

- Environment location
- Sectors scanned by Boot-ROM

This patchset first makes it possible to select offset 4096 for
eMMC partition. Here U-Boot can be placed to avoid conflict
conflict with MBR.

Secondly the bubt command is updated to use LBA-4096 for eMMC data
partition only, keeping previous values for SD and boot0/1 unchanged

Changes since v1:

- New defconfigs for environment location are skipped in this version,
  pending further research if it can be auto-detected.

- invert logic of if statement allowing it to compile both with,
  and without CONFIG_SUPPORT_EMMC_BOOT defined.
  Reported by Stefan Roese with turris_mox_defconfig, thanks!

Josua Mayer (2):
  arm: mvebu: allow additional 4096 offset for bootable mmc image
  cmd: mvebu/bubt: move eMMC data-partition uboot from LBA-0 to 4096

 arch/arm/mach-mvebu/spl.c |  5 +++--
 cmd/mvebu/bubt.c          | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.35.3

