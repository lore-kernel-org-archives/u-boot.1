Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A78CE7A96
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 11:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656ED86BB2;
	Mon, 25 Sep 2023 13:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Y+TVZhnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331C986C27; Mon, 25 Sep 2023 13:01:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE2B86B8B
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG2te0sLAZyJv/d0w6lBRD7PRmldUGQCzq9x7J2p3F3YTSe6/GqSPqGyIqYHi/tsJAVhbme6R0oefDi9uIVRWpSoUAqRYtMsrV+AW75Da9Rze3t6/vpMNqPfrrOAfiS9RUeuKxrPv2yS0Q4apgXFtU84GXIY2DhJ+KE6RQRBOutdH0cXhd8zUdaSxt1kNYy+o+oqAmpLqDFhmEL0xOCl5ncwnmEprYojoX8MNddS94sTaErnH154Z4mw8StVJhLp0EteiWciewJMKEpkLkdgXdTfGRaCyAAv90SOHg0rSeup+KHkfobVF0Al3HyxP3m5jS8krl6k0fIEcf0XckeivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c32eKaz9cEJJA/I469nOCXr4wk7Coee9+z7oyvCj9RQ=;
 b=W6DRRmYM7837mksbzEXk6Pq99ybbmTWrYwqyyFa8pcPmfF2Zp4a7YwX8nClO4JvQQj49SlU4LxeeXnDh+IXXdg8v4opa/TZkbrl3BtGqoZ8HpbqtTj8lwjLZXrKQkjZSPCvg8fsm38TKHbwQiJ7llge+htsyXJ/TwbJ26HvkisGzksmVNgkfkXAv41P0fMOs9d2uBRZ93hflmebHihKlhzCsMwd4k/GDJd6kkPlxvONbF8cTOgVkx7JUvCOl3gcZ0cxJ3ASFvfPyCCiied1DpoRCz3tBzgy6njJ6uxPWJJDBksnBa9GdJBjzEi4KbqtCsIbAh5f3dwxb0DvOhvimDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c32eKaz9cEJJA/I469nOCXr4wk7Coee9+z7oyvCj9RQ=;
 b=Y+TVZhnfQxS6h3WB3Ma7yKkUZlR3C98Jwiu1P3yolJxdoGrdUUn0p/ioWyuN0wsN8okVcgFavP2eLmZwb9ROK4YLPB1l1fIdrgGpKSeu8qLrk56V5iFgeF+J+DcdvBa5Vfmzm/y1LzooAbbUvHefs3iDpx4hTGoQAhCSLtY1WCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:01:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:01:09 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Date: Mon, 25 Sep 2023 13:00:59 +0200
Message-Id: <20230925110101.376878-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7d32d6-a747-49c4-5b6e-08dbbdb6b903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2vua1WqlKgk4IZtFNHEtbiJq1I2As9PTZfVG9GWXt+msJbiKoCj9C+IiUVUzLoUQ7/jkbjqMRKPu5dbnw7RW66b7bOsRAWCLb8oNJD3I8zQgyz7ZGWm02ZrlaUqzihWVon7/ulcNxCOE8lpGqK1w72UlD3D6Ufwoio4z6WSrPY1r5nZKA7QwyGLbyF6Xw7uwAUs2rHf6RgRXjQrsqRt70WBnv1qY43Eh0AbqsYeZaUEARwW47wCLvtNCPyLOnztwGAdDuu5LWW4PcS2SSOnOkBXKeNDOA4V+UACqIsVqtPaOQictmQF9PV2/iJ5T9tiV+E/VMkkalVNAS3lWjTBSkmxqMPLPjnayo2+niGLvB9YMnMmnarfGJM692M8jUVX/msNQSI9Jzw57p012R9X7DKlHJF7NoICis9yPoOzJgB8Z3qnmIHYKHImwg2yks0EJP+19ePtiju/0OpmVRGB4L8HWQ+DARlRWBhAK3/Rfw81cXED8KfCFKzdFQmVrypo6Yk6WJxI5h7mehKDn6tz0Me6yihrEjXVkmJ+iQrk1AwNN2oem/ORvKNsaV+eppTw853M4Sp14OST21W0hzhkL9c7zjaeqWzfNKMgPDadCyjTYRfmxN8i7wvm7tFZ+oH5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(107886003)(1076003)(36756003)(86362001)(83380400001)(5660300002)(6486002)(52116002)(38350700002)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(8976002)(4744005)(44832011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ee7aWkggH3v/ZTogMPfXYTGANeyYkpvGIsfsVFXR97bte7LP7F1SDX0qudnx?=
 =?us-ascii?Q?u2+ZHWVb8lGXj2lBeRzTa8iowNSTLofBLaMtHZxXC5zYtx8tTG2AXO/632zC?=
 =?us-ascii?Q?20Vz+4z+W3XCKcKGfjTmeULlkUK92INbajN6p3hdWaRgoIT/AY66yRjiqQNX?=
 =?us-ascii?Q?ifTkLlmb0GAhZ10iL2twxi5NZS2++3SMTf+3l0Jjiyr8gHfSYyva+CkmFVeR?=
 =?us-ascii?Q?KeM+Tu3la8b19qljrwPAG6MwF27FoXL4xKYnyN5V8a0zfoeZZSqB11u2L6bz?=
 =?us-ascii?Q?zOGjQo2RzLP4mh7y8ufkOh/2qt1JrtPFFNH2Ixy7hf8/dg/MHuGfu8WM00kf?=
 =?us-ascii?Q?SWLQS3nYhygLfoc41rgj/cL7HzJ6g9n0NIIL/aC9EYZH/95ctn8AEsy0+8KH?=
 =?us-ascii?Q?J0fBpeTSXBshPVvQMww1YjuXx6yxql+OBr8Gdo+o99M5P5jcNRCyu9iTlELL?=
 =?us-ascii?Q?UM21yiqvvl4Chk5VXoegvKqnBS5IKkws6vDHd6lNzR+vM3hTO8X97JATT/zZ?=
 =?us-ascii?Q?NBwYOEhCzsmp0V5CqQAXlMpr5aMQ15WDgN26hOHDiqFPNdVrcszjwgm1FTU6?=
 =?us-ascii?Q?hn4xXrKYOrYmqPJQC9Yw/+9Pq46vAYXQNObEhX2G5563UxMxVC+r4b4TApQU?=
 =?us-ascii?Q?8U/174VYK4C1Ozku0Q6mYYHZxYgvQpnkb4rTkswkjQARj3/qyNpyEaf+yN/k?=
 =?us-ascii?Q?wqCJv7A5fpb91kCtEfL8bOlqT8bNxooNvuSVK0Rzrz+6kgM4tPT0417H1hZf?=
 =?us-ascii?Q?4x6jcl9Lv6MUtGGEH+WooWbcd09n3pNN6Al7vtJekUQTTUyF44XUjh3sirIz?=
 =?us-ascii?Q?DsoNOl2dEMyZs+uBtnG8A7NWwUvdZxCR3IKfMnbI+JHeZAWDWuax377I/vHd?=
 =?us-ascii?Q?uGgKZzSApWKXvZEN92Z3bLiXEZvpxXYtDh2ZAtf+36hvNx8k3qSh9CImkLgz?=
 =?us-ascii?Q?DoEzIWHZqIWDjRHJ4OU2Ol2heSfwaugsDFlLE3DHvSuxz/IJEXnpFTyEAYFw?=
 =?us-ascii?Q?k1KUdyLYN0epUnlTXHFrLJEVMus8INEXGXR7dRK2fJydy120ttQEikuumlKj?=
 =?us-ascii?Q?GooqpGmOpKOlFKWFUFgALCFEbwDLhb5chw01vnZCyuUQ9icB2pMo75Yig/iJ?=
 =?us-ascii?Q?GbR4RSR3E2PGGC155aG5cdO4qG/g6chzbv6UT1fBAYt6dPunAOEu80D4vG9o?=
 =?us-ascii?Q?JC934NWxNnci0Voyt2QJNY9X6+nVIY/EOJ3xgI6Cx5OFeF7ttLaHxG3iYSl4?=
 =?us-ascii?Q?IPwpWpB67DgONjNCiQS29LjP1GJIB47oQxo2Z9tKfiBr3f7kJ8XIw9z/r0h5?=
 =?us-ascii?Q?O5E1U9Lpa43Mvf2K5vXxmexof6bgfjNw5nT7NePFOrsu/rNiZE/3VeF/Le5B?=
 =?us-ascii?Q?VrxpEZM0PKedDgLMKlClyE2x/bm39mvjSm7S+DSk5REm+KiigWF/xmB4iT8m?=
 =?us-ascii?Q?hbK7ANVRYaoN1/B4tVFW5Io7cGllkjzsIBk4W3qQgT9JRkpg23mHEXwX61yw?=
 =?us-ascii?Q?jz2+EeTbMnJQlJvMr7KGfOoQjepKYo8d99d+rt6LVDW81KXfq1OMdCWvTjMj?=
 =?us-ascii?Q?CAtbOqyLifsnPDFiT9fAkiUV2YyfwaXkDkU2/GPyoTtji14Eu+hHJK2d4JiP?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7d32d6-a747-49c4-5b6e-08dbbdb6b903
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:01:09.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+DHHzaUnb4IX+6glqiZohoFrRbqeLV9+N+F1xIhEG+jS9e14NT5xb8Gr3ypwgS1pO8/cKbdsTBs/DzgXUGr7wCyzVkWWe1fhHlH6iDS6w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6060
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

1/2 is trivial prep. Commit log from that 2/2:

When debugging, one sometimes only gets partial output lines or
nothing at all from the last printf, because the uart has a largish
buffer, and the code after the printf() may cause the CPU to hang
before the uart IP has time to actually emit all the characters. That
can be very confusing, because one doesn't then know exactly where the
hang happens.

Introduce a config knob allowing one to wait for the uart fifo to
drain whenever a newline character is printed, roughly corresponding
to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.

Rasmus Villemoes (2):
  serial: serial-uclass.c: move definition of _serial_flush up a bit
  serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE

 common/Kconfig                 | 11 +++++++++++
 drivers/serial/serial-uclass.c | 28 ++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.37.2

