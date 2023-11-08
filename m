Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA39C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00C47875A7;
	Wed,  8 Nov 2023 13:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="FGzINNPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5978721A; Wed,  8 Nov 2023 13:12:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D725D8721A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMmzOJDCx5GRxch4gJZF311cYY/Kk1c7/kG7N0ZYbDDEa4YONsTpQcrkBN1j+qFEbUGoR31FjDpDZEwNLz3L3OinZvRUC/DBBGMMZnjkUPuTYxbMiGzcDsYgy1ZeK924VJcXtbcjiRVpRYTtSyPbUaVbC0J2hu7+C5N4KcueZVzFmBCtL+wv29oXLileJS9fjSJ1ijUjLvhcB6utY8NmOg+8xLG6KHLyQVbFBjdwcSGcDefRXB4Um0swlP2/oWAylMl5iICn7APXm1HpH9xSwe5eoKg+UXtOM6E3cTDjcUr6aI+Cq5jManBTBFggkMA3/vOhU3V2CJewIoIQ1SHgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcsxypCehhubfs3KzCn77VoMHTJ3+KzoRMTAMKviLeE=;
 b=k4pAQhqOIVuSnVsiKPkT/CIYd/N8AqpxVfnSXoihhrAI4kDJLjaXWn85+TzvkSGNqpDpKl9qZ1xZ0ZHofvsdbrYnnUwK+LYAaSdlpX3nVDioYwxE8FQeiYYzXG8U9MsuZ/BjMkPuG2SmGUM8iDqqnRUsdDDodIsP4sGUEcI0fjzGaGj7fA7Xu6mjAMfsIVcp7lez0KBqTsbYb+CQzwieLucKIMBE67ktoIuh6rAemjoWRE2mz2u+yoIbHUGX0ziCu9FQ8LVOeeXBpAzZyeilR/OJMisEKhisYe5A3ieL6jaSZ8sqa2AIKEHoYHqmxyk3zzmmuZs5gae7XoEgdtlEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcsxypCehhubfs3KzCn77VoMHTJ3+KzoRMTAMKviLeE=;
 b=FGzINNPQNieLuJGVrt/GTG44c0JrCfwHeV/VwgodcB6TnK86wpcrJGmIvc4VKx29Mz9IQw2eHuWB18Np2/7ONldQ5k88HdWUUm+wyRsvtl4kSx4jcLxmpcfqjXnIniECgerL1n2BY1pR3TH95CoGfw0c3HISLUw+xF2efus4oPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DB8PR08MB5386.eurprd08.prod.outlook.com (2603:10a6:10:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 12:12:53 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f%4]) with mapi id 15.20.6933.029; Wed, 8 Nov 2023
 12:12:53 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 0/2] fs: fat: calculate FAT type based on cluster count
Date: Wed,  8 Nov 2023 13:12:37 +0100
Message-Id: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DB8PR08MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6666ac18-d22c-4541-7c63-08dbe0540907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDwWCNYxwU3UpvB/+KlpVjjuHYnqqKr5eG3PVoHXI0qEoAVzxS7xOAfvArnauj58dV+R3oUWAyYDTCcwqVj2SoZvnfsoGe3AjYnUfaT6dkgOflvcbM8wGi66L+WX4iEBKqorgWhNfgANVMTR2Swjf3VaRkhMp2EQ53dIyNysZB9dST/8FCvIwiHTFIrVAij4iWnZi5a7Xc0AeRKj/3sTup5PulOn6EmAxd8H+OfKD6bUJqgXgJmgYehzCX1GXgBgM0bG9PNqIml1QcblNNiTSOMBWaLDyfTTq8eKDiJcFI+NDTbzPRCTTnkUBufzusfWCJ5lZ3stRXTyjPL7d+QdrIm8LjPjVmLPlPbV6zsH+s4HfwafYVL0XKnEFh/3ncrBylhYrzQPi/+AonTVfDHj2PmPK49VyqMkjbqO9qtqVnDqeQexR7jPv53toD4WpG/4zacDJ/LPkKR87pez9R3PYbD7aho2AnpXFBwE1dcVnhSc9BGoaVaWkSEB6TFRtM3kzmcSL9Ex/PQor9KlvhFd4RwcvtM+uFsN99YTpqpsVlAOJcfTnWQ/54+RgjPWh2C/c4ZvS1ztU8RY3ns4QS67de9iAxXPCf8CExf3CStYD9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(1076003)(2616005)(6486002)(478600001)(966005)(6666004)(66556008)(66476007)(54906003)(6916009)(6506007)(52116002)(66946007)(316002)(6512007)(9686003)(8676002)(4326008)(8936002)(4744005)(41300700001)(26005)(2906002)(5660300002)(36756003)(83380400001)(86362001)(38350700005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObYb+8DLiuLW7c+OAR/zF6VXnXAZU6XLXFTDr2/1Ri2NGso7WHw3QXN1qW25?=
 =?us-ascii?Q?Q8v2plsD+b5jvqW4otThM9ckHqbkBd+ppYli3qhpgSUXdVfAYGXPWTkc2Rfa?=
 =?us-ascii?Q?bb4p9lljmqldFDydX1u3oxwM8rQ0QRGLUygPwxav90T2zxTDG4UmwcE/NeJo?=
 =?us-ascii?Q?CI7HlkucYP0fO8C/J38y7x0cS2s1u09MMrFvd57gNDTagEwifRGL5WjFOdWk?=
 =?us-ascii?Q?HayuiPY/bG7qynAu3GfiQHu1b/PeXJw1u9yO02FSPyIb+Is2tX3I64C2Q2ke?=
 =?us-ascii?Q?BJdI3vr7zdyZt+mMfUD3xPzuJuu6vOZ8RK0mG310CDDljgDAeL3X87Rvf3uL?=
 =?us-ascii?Q?XbWaxQH/cIFx6DeIrmSrRdhYH6l6n7op3MzgB31Jmo5VJzhpWRHKf6d2D3dt?=
 =?us-ascii?Q?X+lb+1SU3q+EvOxG+s26d2W+z/eWU9XRkU6H6SfQZsDZA+RfMkl+24cGOzBA?=
 =?us-ascii?Q?9ngkPASCTR6prJYEM6mAjZfO3zAOJEjb2CIk29a5CftnJIyDq3AwB+0MDmIk?=
 =?us-ascii?Q?AzvKQ7vZuuenuSJJu1Z/Z4u8Khqts38VeJpgRIBWbspTKO9KpJCHbsR0f0uQ?=
 =?us-ascii?Q?VCysmtykhicOqs2A/4pYwCO+ppHapoWNuG/vMw4Y9IIi9PWf6zgAH2Ek88NN?=
 =?us-ascii?Q?uwW6rlV+N90ThCv89RNwbRalARzN6+lhKO46YCEVADV5HbqhhDGHgxw1UEZj?=
 =?us-ascii?Q?8sOTONk1cQJSAR2RlZobK/IKjE0pWNvKp+G3G9rggO4msVenQIsH7ZoLXt0P?=
 =?us-ascii?Q?EirdGjLhby7YgiNwt4O/bkMNWs3q3W0YY25m8CpdkOCUU6ovY+23fhjqZ1Qy?=
 =?us-ascii?Q?RUBrj6WejmJroETV8OA4Dhfr0Lzsh9SlJoFN2yeRBEwOhaaxj9V+cTtF5tFE?=
 =?us-ascii?Q?5yDU4cSCxyHq5sNB0pu4QZcMML9r49JafLLkajZvdwy1jY3gYCCzyWd8p1l5?=
 =?us-ascii?Q?UxNvJE6qsBI9GAUGVzCQkmPuUlPsiZTPz62e5Ava1n9qhLlgtajEkMIpzW7X?=
 =?us-ascii?Q?c5kn3u5SWdBj12O6qrP5dmItc54a5+pzg4CXJ3PDvMbV15LwCa2kBSwii34+?=
 =?us-ascii?Q?rLQURI5JCMK6EsTALSd6vQz1BxGsr+Y420j9SkJxqs4gsxbqveEVMuTxEf+d?=
 =?us-ascii?Q?jyXWHDzUvLEBAahrn74b9dTNywR4flZV7qsTkunYrznT57lrSX2fph9IzlaW?=
 =?us-ascii?Q?XCHU/Jvfp1FUZirQmTMr2yYj07dD0cupkXi1K8pbA5hiPQyCtqsxu+i8O3UX?=
 =?us-ascii?Q?Anf026yVocMlxN6bs2kmJEr3xKKc91cjA5/CPmYUn+yos8QQEepS50gr/ZXG?=
 =?us-ascii?Q?5LrT8p8jmFScGo2592Hw1uCxj2jAUycOgqjx2pg9G12/QjBZOTqLyc/D2eZ1?=
 =?us-ascii?Q?PgO5ZQchwayVXPy1PhkXHQoLFvJ3Cn+Vx3Jt5rkQB4Z6yvCdcUiw3WWQbFVo?=
 =?us-ascii?Q?2WuH1X+oyVWCY3K9Y3qZr/OtqGPfkTdkAMFcGyYuQS9aynwGyXjR6Usu/80j?=
 =?us-ascii?Q?sYb5+Slid83fUpowZh29Ugge3D0hX/3ifS2TUEa4CAZFIAK9Jitak0wpw6IM?=
 =?us-ascii?Q?AdfrHV+jniQa6IdXcOdV+h253Ox56Zt/qJnI6gb+q9HrDIAlT7xO21IJ7TyJ?=
 =?us-ascii?Q?rflTdq58ItwJl+7lpFjQGQ3LohMcbv2KzBYLfZuaPYiF?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6666ac18-d22c-4541-7c63-08dbe0540907
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:12:53.7494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82msY5p2l3s8JbyW9nVh2DDpnrzlJS9NUdXyl3LxjRvAEDGkS79vebSOubyZ1cfxdSh73ewspmOLhw3Er6yXJRqAHPY3BZz6sWbdWhtc0q/8jlQQIn7EZT8T4sTiO83Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>


This series fixes an issue where the FAT type (FAT12, FAT16) is not
correctly detected, e.g. when the BPB field BS_FilSysType contains the
valid value "FAT     ".

This issue occures, for example, if a partition is formatted by
swupdate using its diskformat handler. swupdate uses the FAT library
from http://elm-chan.org/fsw/ff/ internally.

See https://groups.google.com/g/swupdate/c/7Yc3NupjXx8 for a
discussion in the swupdate mailing list.

Please refer to the commit messages for more details.



Christian Taedcke (2):
  fs: fat: add macro to convert u8[2] to u16
  fs: fat: calculate FAT type based on cluster count

 fs/fat/fat.c             | 67 +++++++++++++++++++++++-----------------
 include/fat.h            |  6 ----
 test/image/spl_load_fs.c |  2 +-
 3 files changed, 40 insertions(+), 35 deletions(-)

-- 
2.34.1

