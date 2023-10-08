Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0D4E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 14:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9ACD8656E;
	Sun,  8 Oct 2023 16:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="foVIE4Nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC5786524; Sun,  8 Oct 2023 16:59:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBC586564
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 16:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoKBKp+x9UJR3MShpl4PQz60UrPMPUyadMxj9M6OJ0bsGGDa0hTCgthdmEL39OePI9vRMkQaqqOVUhO4LINMOHfMvOoXpnLLKi3T7zkKdbDb7t25spnVDgSWzHblGg0+U9Ex6l02otacSihFJJJP+XaE9mxX1BAXt6+mMXakutY3PmwxJMv+WLI7Y6J+KUbICPH2UQO922FX19FKm2hlwRD1kNCZeCyB/tR3ZG4XHtDnzXeyOSJ10k/S+ewGWz9P8aoiFBUSEy9ahRoBRxSlnep7cJXDEodf45KRAdyORcnnJ0YQ0yGa01cdSvKDM32p6Lsgi78P7FlC3jfKTTrgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lbT5Vsu2TZX9RMU5A2g+Z/QjvvIIYWd28URj9NqsA4=;
 b=KLCcA95P4UrPveEA8W9A55wn0wmObX5Ckt6oNHPrZ/V/EYYw5/TLcx0VWjQBGMN11EIiePLErjE3f8fq1K8bcnnWbSYDr98I4akX22GdAhqi43NJMfJfEZ8+Wy3+ziaBnfriIIk+a6tPA6E9GYH2fm8yk2nSKRjRjXdaPGGBVaOITR565/zKyvBHErJPvvSYCoSXqK74fWmSe3tBHxQ7GecXp1wI5+6af0gPCllQNEA5H77Bne+igIULxvPPhX/2gmZ5l7Xnt9BEolouSVF7433HSLIzJlARk0iq5qQ8LUwZ4GMC+RLbKaD0+63thnXCvkONP0I8SxF12Ca9C6H31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lbT5Vsu2TZX9RMU5A2g+Z/QjvvIIYWd28URj9NqsA4=;
 b=foVIE4Ncgm1G4L5I6lqKojbfPEzQHflqI/B2m5q9J1S3PsQV7ZIMutuwWahf3tHKNR/Mzv4FdtSjeJe0veoeJQbUp2IQNCH3l3GWPf0COZp+Tv8viA4dJeDgPzY/bsSPoWzo4jEmph3+2Wt9NEGEQVkioofcAjVIbP3Z3fB5G5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 14:59:21 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 14:59:20 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] arm: mvebu: clearfog: support additional ddr
Date: Sun,  8 Oct 2023 16:58:02 +0200
Message-Id: <20231008145804.25567-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::17) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 48701ab3-ead5-4886-89d9-08dbc80f26b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lj1wvPveREhBDJ3UOHqbtpr9tZ3N/n0JAk6y8JyEiAWK+yj/0nr/tNtmI7kt9j3JvCm87renJu4NivD9jVmwzpGjGeoPodzDMPPZBmtavKtE+JFuQ+opkaHz2BQTpg7tITL91asPfuIcGvvhpKG+NAQpFez+Em2BMQ5RdIn12bx8NSLuuOLZXjA6y1FPNbbj1CzGcLmMnKx1MMExvAE/EYF0GDiR3ez3YQj6Pkji/xp6kGxlyEIHSSr+eO2HTwnNKuM3QB+RshAlmhjWOE4Ewu64Fvsvu+Aj6VVaGtqGoclzUOL3wVRly7ZKDXOFhHQ+5Fu26423DCCASflw6SD/7yb2p4RqigXlLObr49WDl5t/JMlBBvDotSXfSCjAL1dp1IFE9aXAxe+XnxZ7nmVsUVxdTo3vvvyPK2+hfFv/QTEl/7kl4u6miV42TI/q8D5jDVrzptIRBlPa+ixLD0lMF1/EQQgSmRnNy8VQfmPM13O9PZNbH6CrTjSBGWD9Yms232Ga7RzWh0Eavf/KemOFE4Wqv9GIoJq9TEVPIaRd18yu8Dzd2Bpzj2YGC1bBepuEiKDABbMxaPnJQPP4gaWb+9JlunUkpoNKraa15oZHAEbMTCPyJ1BUab0/L0OeIggm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(107886003)(1076003)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zro9KVTlpVW9qWKeqRqZ8AIE5fANCJ6aF1uPvX83HmA1XnnyFBq5Nj3I2q4D?=
 =?us-ascii?Q?nBYvPDZcrdgK8srnVJa0emVi6cYncayTow9KAYBe8VKhHXJ7YYDoonaPwxw/?=
 =?us-ascii?Q?KCxbuWZHeCqVezRVn+ayM95YB33d3JdoKxLmT1+sXxAd5CYAs1GkY/88XIcJ?=
 =?us-ascii?Q?S+IuioEhJwC6zFAtwKPcJgMEIMJj3ppnmrsrovqwZmgH69E4vLuyZuuXLMSg?=
 =?us-ascii?Q?X0IKqg14gQj3TEqwCqvnsuKNrkzPliO+5Fy0M69T8bfRGeL1TzhUVKbOmMkI?=
 =?us-ascii?Q?BuhVJnEdGyp2K5Oo337wAIVbhLPrq8vhfxvf7PQiyZi8CmYbGCpV+fB/IqBD?=
 =?us-ascii?Q?FxMQnLndqxuyd47I0K/ZPlGaDemkIiLardl7b29qz0jaMJQjc59/WHqClSV7?=
 =?us-ascii?Q?4r8gHRGl6ClkEj0XaEmw6bB7A3dUbeidqf8lR6zYSEZmDr4jkDPXGaVG400G?=
 =?us-ascii?Q?6clF8qRlYCVsIK3r6FfPEaTon9PsXxO0F4Z5sAPmmso3LsSwXduJiXpa1hF4?=
 =?us-ascii?Q?WDj7Qd/4EPu66/QipDyHi2x7p51gdVrJeDb6WvLugwxu9VQ3vsb/qiuRK1Qq?=
 =?us-ascii?Q?vXbAv2BI4gx1g343qj4c1iH5n2Cfo+r78WfK3QUuNb4sx0q0pjZgcZpT4IJ3?=
 =?us-ascii?Q?Q+cBh5r5d2UlvzV+/uVTEfyCHvOVWVQnkkH5u5lBEtkfCOkX1OUjqyuDRu7W?=
 =?us-ascii?Q?rhnMdXxi5KwrGApWxT9yLGBn4riT9OSIyHErHX4qmCU8PscN8Ft5vxMDTFY7?=
 =?us-ascii?Q?YMt5q7CajpBgr+oopFYoqlYZIUCjAs/6J/I50HzyWykDk+YjUse38vPGvZGF?=
 =?us-ascii?Q?et1OMcQMDBb7nrkv9PnNEa7A1sNVla4Abl/M+soiTI0QxbCId7VtE6T9Pazl?=
 =?us-ascii?Q?Unquzf12Ebj5ot5GDq8n/iCLsvNV1GY/QfqAb4vjt7xTr6bjvcePY19ShwKq?=
 =?us-ascii?Q?rtwsP539NldyBU1fYp0//OPH10yeogkIpN0y/Bawy6IJu540PdyfWIjKd/zF?=
 =?us-ascii?Q?8KFRcRnjCfuImrGdz054vmk95FDUwd2BbRBq7PI8gN0/k97/yhxSaNT16KUe?=
 =?us-ascii?Q?3DOa/gxOe3tC287Ou2zjzgcMy8NZSI5RInZLa6dDEJILkb6Ak3YGELerm7gf?=
 =?us-ascii?Q?byIxDdMZmHkl9P8hscScifGWC7gxUWvwKE/w5rTWTmcCf1vXmHutP9HL1Lb3?=
 =?us-ascii?Q?XlU8I3cRVvedzcF/wih1wK8A7+SZMLjrXsB6qgKB8o9wwzHn6KY4y9cwu2ZL?=
 =?us-ascii?Q?mpDZJltDdf8ODyyMPcq0g8+rRACr7FJgFpFglnz0OlD66mNPuXW01sE5i7AH?=
 =?us-ascii?Q?moUFOk7yq0162Jejx6qrFWqAF8tzeuTzeh5eSmpDtwBWK2/PwLRUjtT4bRAQ?=
 =?us-ascii?Q?gPbvgiug380RaxhQ4KkAJc2LCAAcdIXKfOWvYeVZcU4eaeUslSk2/Mq3xDhb?=
 =?us-ascii?Q?IK+ea4dpmmJpRHaFWlx6RqN0nhDeSKrBGx7b6584VE4Mrm55DxKfYzVvMnc4?=
 =?us-ascii?Q?gzsuaG3pQTPZfxvUJHpJyX5hjGL7bvFRo2BiRebtYOBprqe31bkn4VorG43Y?=
 =?us-ascii?Q?l13B+eBC+nCXzscgA4lwO4zB8i38HXd4zHppdird?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48701ab3-ead5-4886-89d9-08dbc80f26b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 14:59:20.5609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeGlrrFS9XE3sD8lOHZnAF5QPjPr1ToPLJz5sw7crLGxfqo5GBvQy1kRirnG+se0NwoYKG2v0PVUxLROU8mZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
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

This series adds support for additional memory configuration that
were been produced in the past - most notably
a dual-channel configuration with two 512MB modules.

Josua Mayer (2):
  arm: mvebu: clearfog: read number of ddr channels from tlv data
  arm: mvebu: clearfog: support 512MB memory size from tlv eeprom

 board/solidrun/clearfog/clearfog.c | 17 ++++++++++++++++-
 board/solidrun/common/tlv_data.c   |  7 ++++++-
 board/solidrun/common/tlv_data.h   |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.35.3

