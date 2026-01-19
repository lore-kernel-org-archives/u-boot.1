Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BCC98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642A083956;
	Mon, 19 Jan 2026 01:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XY8Z4T3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3608004F; Mon, 19 Jan 2026 01:36:27 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444518307F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+0y0D7wLlgRtNEfms+sfxgcdAIw2WRYr/HG4zM4IIlT4Rq/+fmcEcVGuUtnw316WpSdyv8WZff0dR0kYnEwQX0+lh1cGvO7qCEdbAkVIn/LmgU2zEa0YPPL2ABElATkCNQ0YCqCm97CKIyLtyO7+K7vc4yNm1xtkUaOUqY33vNgdK1aSWXUenLgBBGShPl5JMs9vH92FEbALQ9NUA1WWfXu8YoaAShEwn86fmEoh7sWznFewnuYYMs7K9jyj/RLpK7+HZ5KzofuLHMzJfKGOjqO06hrlEylT1ErEXgrNH5gmQlDGgi4wg75hhgvKB4STp4nWTimi9HQ2xiMjwVjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOGyH5KPMkZ5JL+DVTLNDG+1LeO7tbaHN81+GHxVhHw=;
 b=s0sdW07dcnB3IDMLbS1kHSFfHxpyQ7P9PkEihdSz+ANImy6/q5Euy62lJhIRBbIFwq82sn3syfZTDjn830EwsPDiXTrT1CoIfTJY1ZWqUB5GyFD3kivc92IB2URULLFIiVgfpB9L8arKggYOhc7LDlsBd3QctvJt854D9zd7ITqg4ZsA6qqFZAlFHV07vlRZWBTb+epdvfQayP5umVoeN8ySc91kCWcX6U6T1uenvPaRvTMNQE40xYbOrjdG62pbkknYDasZA9rSzga3+5lAuDKyJnNMchQRbRBxKDyg9BOuTS7CwF6NU9HNh8ocaTf3GTUuWL0RlMyRPpSgyQu/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOGyH5KPMkZ5JL+DVTLNDG+1LeO7tbaHN81+GHxVhHw=;
 b=XY8Z4T3CzQ+X/ammW7xSq4br/AzPONzaFT7km62NC+BkVg4J8fdv8zG/SvGFwSmqEgTO2e06T0nc1mIuK7PaXyd5VkeylCk2TIGbaaNODy4LdRUoy7eFGz8Co9XLWNRCV4kk+NlIqvpLeqO8mG4lJWzMpDPCAYS8qSycri6AcP4DGUt5Jwt6UA5YYqcbPwxrU5ruj73Nu334f3hZglAcfB8h4PCuFZYKKqz8kbT8XusG5pBpW3n8o+GBh92c1O16w2l7zyvIk4PpQp+VWzlc4vifpoHYocdtDGAC+cydJnS44U+eSX06HEUOzDMxLY+kKd+UGCULVOKS8WpjTz2JuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB10761.eurprd08.prod.outlook.com (2603:10a6:150:151::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 00:36:16 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 00:36:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] part: fix partition searching
Date: Mon, 19 Jan 2026 03:36:03 +0300
Message-ID: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb679ff-5dfa-4ec2-5c20-08de56f2c197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4EbL3vt/8TeTTVA6vRgapOJekioThGYvokZV95ShVGscFOpkGP0r2GEoIwiM?=
 =?us-ascii?Q?qKLQ0uD4RWUw6P7nhUjmuLzT/ToZB3OxZ+bf4swJ7s1VFp3jz9/MV2n6rEd+?=
 =?us-ascii?Q?4PV6o28jU6kc2iwGaT7f8FsW0wM6ubAukT6TtXw1I4PeLaswZ8JXounFZLCD?=
 =?us-ascii?Q?zCFzRph/t+wAS/v/iMq1Sy+F3JdHTJdWAisAWZl85uPMV/SymI7xGYjghQVI?=
 =?us-ascii?Q?tmMpnhpx6RJsyh7nMAcKRTnpRmI0DV3ayFtM30zYY/58qiedfELBuetSX0ft?=
 =?us-ascii?Q?y9c4fpPQjJ6XpSGkK/JXGd3qYQe6nU6alXp1mWjr4bIPrzj7BzHGkllIB27C?=
 =?us-ascii?Q?2tM/zv8x6UEF/Ovge5RO1q51pZeawjalIZ5G6z0zdq9NH0Zt2pNw2X+FVs5W?=
 =?us-ascii?Q?o027BGaX5KUWdp9V7WFgwJmSJFYh81EzMKOnLq4Wp6u3TTIhdS2bK1mfFEcK?=
 =?us-ascii?Q?ZwXgNq7tJwCvCwzT95BNpZAsw7ky71Hk0U2LLZikKGT6/hkjjQCunVQyfpwJ?=
 =?us-ascii?Q?K/KTXX+lJyVz3ZIKR0s444yxqDsa8MWephEi6TYBB0nBwz4sygE2mSIFVtRB?=
 =?us-ascii?Q?tLYBuGsUoe9ZAvjeF3W+fKmqiVJ+bWW9MRWXTBSm0wkbMszC+nIfJVSOpWTm?=
 =?us-ascii?Q?kqulMvjG+P6hgu0IgjOhWD12hJSgDNvg5EnVJ0H2YOaPTrmGtpb/GfRCe1FT?=
 =?us-ascii?Q?mqKGpFWqQ+Nda16ErzUhRDp9ro+oMfACGCP8XasmMY0BWUwSGwc492iwLCyV?=
 =?us-ascii?Q?EVV5/H8Xo6zer9FB3mijGMxbj8MtIH1c67nY0s9WihGAmsmNl0R5R0gpN7i6?=
 =?us-ascii?Q?MuDbwl35O5QzV0KOKXxRi1vfZ9gHUO4SIljgEJbLLrh0GEgLDXyTAT/XHHwl?=
 =?us-ascii?Q?keWI1pJzVxhF3Pj4OIuQ572jeQ/2sJQL8b97UDlkaZhjBFiSurRSoqkhv6al?=
 =?us-ascii?Q?AALSHIK6Q6Xq5g2LmRSo4hkJIokkOe9kPdKikAhuX2ykF/elDlYJPhAE9i44?=
 =?us-ascii?Q?katMsfHgUGwlV8Vn3BKhmuaArL0wfGk3JXlpRsG4qqgUao6H//543SkAasAS?=
 =?us-ascii?Q?m9j6gInjizU52VmVic6SUOKlcTh0P+g9eYJLu6rtcz/GAgEMMgDaDL8+c4Rx?=
 =?us-ascii?Q?FbxSBa1z966uZQu80ZdMnqiLE2rB0yvozlrpJFfiz9emC1s71Rd+5eXyeFct?=
 =?us-ascii?Q?8z14SkAih6RpEZYQ2WurVp4TEeEEqpe8oS4zLGUqRKdJpaNNMNmU/uq8NI3I?=
 =?us-ascii?Q?eKGwc2SGdz1OAu9Oc/qaVHkVGneWVeMYGkvmWH9ziwigqvW/0h4x+lg+Xeew?=
 =?us-ascii?Q?hfYZ2LcwQUutDOV+vCpPIkoCAKsqPzrA3kpk0QESjv/giD6vXH3Jt9VBueZi?=
 =?us-ascii?Q?AyVzBZP/KHOGtEIZTsUhs/Rgv55kNFLybIz6pfVLLyXqN+/XctqIpaPDtnFj?=
 =?us-ascii?Q?jeSarVKemlgHW6LAVizAeK/VcJfvW51LEnW78s91p14pcvRhOmJtSpaHXXnG?=
 =?us-ascii?Q?K8f84Y+C7yDZpN7OAsWu8Gram4Ny4bRQv+EWVFsEJhP+R1Tc4WJmFqQkI8gU?=
 =?us-ascii?Q?xzlDTqNZJPNXscat19bLodhBHKhdJ+Z5lMhV5PDPjUEi0Q4aUu6gBw5iG4pM?=
 =?us-ascii?Q?xZY9mgBczyCfUD5V2P6AIoUPGjwuNCRq3fypqJZFaGkV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O51+7xeZlH8GU8iGQbSsYwYo4N8V8hCWDsqm12XxA0vLLn5/2KOP0CP5ZsxU?=
 =?us-ascii?Q?Uy8TxEw0tvwii/cDyNIbGyePHYVNOoeSkjX4REoEa2iVd9xtATGtWbJylAmk?=
 =?us-ascii?Q?cJRQ+rXOmW7s55ln6W72vdy6BF66nMAO8eCzR3PBYRITFXZgY8MQy8fPyHo+?=
 =?us-ascii?Q?oduP7SCgZmAjyLnBNSvM5/xGDjS4sIhEmHm1HvWSi2HGz73HTTs8IvxSl9jG?=
 =?us-ascii?Q?FLID0Cq6kiGNqrmwxz62EtUvZI0ao37A/kpNJh3TabNbwqfbYcSxiphLq7jT?=
 =?us-ascii?Q?8A2Rd3CQUaC9365nDddovLopl8PHE0kCy241c9LITa4slcHlZ2ZRy/FsqxEd?=
 =?us-ascii?Q?mtKpdDsAn3W+oPbgw7EdY3UYueYJiUUlppF90Djbbz0/jJjS15JlAZr3EG0N?=
 =?us-ascii?Q?aJxGWs5sxfXpy0ULfEt2u8QYRmLGlHTwwtS3mYI9XtXwaHSFX9ZvUVXkiqkk?=
 =?us-ascii?Q?AMrxtpf45NV06m2LplU38JSYd4acgSbJ6z1j7+gtjZb6cRLFeYqj30XIjZs/?=
 =?us-ascii?Q?oALvgtclXfEIIt260gQKl/iJVoAPccKoI5gWTePm+A7JqLLjtC1OYp8cOifr?=
 =?us-ascii?Q?Cw+2EcPxH98d2PljXxz+wubLi6/QQR3HqPc1wVP1w5/F8QLAXNamoDwJWqEU?=
 =?us-ascii?Q?O/re5HqynWGDn1mVX8CbbyXpHoJoutQZbrBJgW0185730cnKOg1lXoYSV1qT?=
 =?us-ascii?Q?Pn95oRJ3UkeKUlG0vVui4KFNfiMadl4j6qaIDAakTePPU7it9RsbSqEn1jWZ?=
 =?us-ascii?Q?i5i0uqZe3oRQUgP4YjkQ82b75tSmAlEq4R6QdEW0GifW9nU4aBvpaCgv5v9b?=
 =?us-ascii?Q?PtUMsNl+DXVljpwXS67Q35C3m0O7i2nCMdFMPTRdpD6Q6AGqjHy1gVI7175l?=
 =?us-ascii?Q?ZUvuRTonUrkfDEl06wPtayj49Ale3/XmsoC6u4ANmuiLmHkuNhT9oPeSSn6M?=
 =?us-ascii?Q?FqHwiqJYFsT/AtU1lz1kt8EpkxbuxHP2wWrctARR1Mr7SHxEmsJjh1jF9DOp?=
 =?us-ascii?Q?dwvSvGCdYN5f7Ag4lzqqVXtO7uAF8eh723KUZkcdMrvdMHFT6RNe3gks7hXq?=
 =?us-ascii?Q?tu4CRWDOvdkq9HhCLIdoiO/gKjxo+hNtXV0HTzy/3X5+EeAqLRXZjaYFRrpB?=
 =?us-ascii?Q?BsIeWtkyX8fs9t45Q/8MArguiSr3SnxTJyWYp8haAYF+5sax8A4New4hjaOB?=
 =?us-ascii?Q?iaZTh0jWUJvmisXoF6EPO6j1pZyRSoIEmMHC6zsKNgIps2haKhquiqcJBevY?=
 =?us-ascii?Q?2RppgorYTKfyXqTqt7F+VF6G36FSKJxBbEvrxuYFBK2Tv47xuo/ijVQudGlq?=
 =?us-ascii?Q?MlEqBnQLodGKuFJNb9OkpSYZiDwxT2CeO5Dj5AJlbKnbGm7volsNrMlcqj79?=
 =?us-ascii?Q?guaALkM0Ns0vBrSlBcj/4S1Ph3CYYeDBfLdMhC46KK7Q8K5Mi2hMXF7knPDP?=
 =?us-ascii?Q?pk2zEaW06672AJL8fO9ep6KaHwlubv0cAGGJ4hD9EkhsB0XrQEYhtlCTSV7d?=
 =?us-ascii?Q?ElBjKl++3aC+xURDQ9jMoy2tKbA6ytZdSAeagAXMK0aDFzNgbQXUb8O6jqPL?=
 =?us-ascii?Q?YchntgQehEnhVCRJgEQdpa5+13HipDAPaCAzMSqSISgPTCRd0bvtv3hnNDXQ?=
 =?us-ascii?Q?M4JTZ0kXcWYGSgtz3mT3h9GXQ7Bt+gP0cIKduLr4pcg3j1OWoCgUK6Q/chTv?=
 =?us-ascii?Q?v9j6YV75KQPjko0JA+2PdNRNOKMC4fnkRgO8kXZv/clGjRfGgogcIpAitZYU?=
 =?us-ascii?Q?kBgvFgguXuc8EfpdGurGpG0ySZ1Ow0A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb679ff-5dfa-4ec2-5c20-08de56f2c197
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 00:36:16.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yV3WUlMUX9pjjrcP7QtZbdFP7RbXaQH63ma2oPr2HAtp90L/wLsUB3rfiqVNRYMcleE1hvWGF5S/pe7WTA9DbfzeeLJ1rd2tUGiBSd7xViA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10761
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

It was noted that a GPT partition with the maximum available partition
number (ex: /dev/mmcblk128) can't be read/write from U-Boot using
read/write commands. Futher investigation shows that the problem is
deeper.

This set of patches fixes identified issues.

Changes v1:
 * fix partition searching inside read/write commands

Changes v2:
 * fix partition searching inside gpt command (thanks to Quentin Schulz)
 * fix mtdpart partition numbering

Mikhail Kshevetskiy (3):
  disk: part: fix partition search boundaries
  cmd: gpt: fix partition search boundaries
  mtd: mtdpart: fix partitions searching

 cmd/gpt.c             | 4 ++--
 disk/part.c           | 4 ++--
 drivers/mtd/mtdpart.c | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.51.0

