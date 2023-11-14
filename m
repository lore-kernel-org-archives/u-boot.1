Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07104C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1713987282;
	Tue, 14 Nov 2023 13:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="gOIH4As2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C62486FF2; Tue, 14 Nov 2023 12:30:38 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9785C871CE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=inmusicbrands.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jkeeping@inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvIEVdQF5pFL0auJ5BjiZNoqpyoPwlvZt4/CD0/WOpEQI1Jn+yAkGPK9D+wSzQV/Azpkyzjs7iVssx60A3qokEsV6OlFRzUTqAdWVD7rprFeU39o9vvzbGF3LJi+rIF4pBkd4Ahhs6DHSxgy0SqXUW7Vg1VdMjBG2ePVqLYJVwPVgb029j1FZHpRCseyRCq8c29mWXeHy+5+fwSUw8xwdZKsNotfICi4eRrsAm0bOUrnr+Rpgld9errVC3dlycWuFzFovaZfYlAGVzIF7enFK2BtdGky/krku/UWHVDOnrbxixSQMxYJbHZtrDJ+zS2o4ysnTol+6mqsx2cKhBgvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EljDvVryW3iAqn5Q6bKFFR1RbkMcYIj623lVYUyUHFE=;
 b=JiKjEXr0V37oqXPdjhP1HvoOvFzZAn42n9Bvxm5PNLB5zbJMjw6PG2kW7UFo2Ml2bolUNpml8zMYTydsXdQz8sIE4uQJcxc4U44mmFyxkn4Qq02VmnaX6hJkAbNAnRWE3Pnd2x1+IiRyjc4D0B3zHSNEUWsivGcCvxdcdtpm8/NUfqsJWY/OB09FEOv0a3o/mdj4psduqncwPLnFE7+VbHI4SSooAY7Yp6+EeBUIpSvYAqsK7t3efJUD2m8phFOsRdWEJEMykCXnGSX+EuKaUzmnnNuMX2kWAgN+fzE0PLSOWcu5G1QEzubetBSW1ryTLTDkGtcExmVTjItOwFiRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljDvVryW3iAqn5Q6bKFFR1RbkMcYIj623lVYUyUHFE=;
 b=gOIH4As2nyevvI/a/H5piMFVJeDXoic1AxQ+heOslMjTDNs7epjzbQjvXBDWY1MNNcut1AFTR87sVPWtoUmboyYBQziYKs5Pmk+UDrCWAb9Rqvrs9xUiG4R7v9oDPVyn3FJ3xh1B9zOhfWbTkO2ocBDkWo8mv3Ts7hH2cKiPIw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from DS0PR08MB8653.namprd08.prod.outlook.com (2603:10b6:8:15e::9) by
 LV8PR08MB8955.namprd08.prod.outlook.com (2603:10b6:408:1f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Tue, 14 Nov 2023 11:30:30 +0000
Received: from DS0PR08MB8653.namprd08.prod.outlook.com
 ([fe80::6ed:7588:67b:5e22]) by DS0PR08MB8653.namprd08.prod.outlook.com
 ([fe80::6ed:7588:67b:5e22%7]) with mapi id 15.20.6977.022; Tue, 14 Nov 2023
 11:30:30 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: u-boot@lists.denx.de
Cc: John Keeping <jkeeping@inmusicbrands.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] spl: fix TPL_SYS_MALLOC_F description
Date: Tue, 14 Nov 2023 11:30:17 +0000
Message-ID: <20231114113017.999079-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.42.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DS0PR08MB8653.namprd08.prod.outlook.com
 (2603:10b6:8:15e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR08MB8653:EE_|LV8PR08MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 964de354-a0cd-404d-1a70-08dbe5051b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ljmXgW5wg73c7VrI6t3i8mP+Fq5XfL5IBuOyGERVCmuRk7oTSBdLywMz2ICqqXaB77Hyta8YBwLz4avej7OO4FUWHDM1KFHe8PvDrHoet4ogRq3UV5GV+Q14Q2h3QfVbype8Ob8KqDgdjlDRJZBiZ1gsoIQnlDyXISyIYq0s4m2HlK+WjkVoYlUH8IkfYof5MyspVAbq0egTdme9cBKMSYfh1J9fFHowgNSwhspfYZgjksJZ4bEfIhQgr3+gB6h2WdfEzugZY0DtzaNLv6mQXIwfaPnyp/z5ss2d2M0CzDubLlTvDscnU3x+4Kdil1Bf8d9uxh5+ya2FR8FiUUyhGt/iUibSJbGD7oQYVYf46oiF6DGVK7ZbOyI/JoDic2W3BzZ/+I+nOgefGBwJYv/SUhqiiyqre7RHStvXGo93gcyAxAL/U/Jff8yx958JuLkxkdLc5foV2VHohkYvWXGtuv8aPUirTDL0imOr7jaFP17iETJjB96tpruuYDT5LAsO3cCYEx6TI+qYdB7KvSRHivpbQ1torNeHWDS928gjqBBVabwUILrs9tBRpEOM97mi4rLWqNJXhe6aCzxH5Y+Jjt2AEzeOsLEhKhKJTFaj3W7xQu0mas+/TPEw0hLNJyY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR08MB8653.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(39850400004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(66556008)(316002)(6916009)(66946007)(54906003)(38100700002)(36756003)(86362001)(6512007)(83380400001)(26005)(6666004)(2616005)(52116002)(6506007)(4744005)(478600001)(2906002)(6486002)(5660300002)(41300700001)(4326008)(8676002)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBMQxQ2wlNj4MsDQzdZbsyyU6CIPLPz8apz7WFtFGcYG9pnazSieFX8gn5YF?=
 =?us-ascii?Q?243rMU8v+JuJHsP5DsTM95sTU785j04Mt6ZTtaNF7D0GuM02cEMLLwzM8wgS?=
 =?us-ascii?Q?MShqou4BlgVtZEIHilfbDgtBQjeROvBLrOpBK0Ye5LnGRk5LwTCFICtPMhup?=
 =?us-ascii?Q?myBpqH+sCZphTDcaehfimKKmhHxZGYI/t/pvfoKmA7+rnzh87ImCRYE4X08U?=
 =?us-ascii?Q?qbp5iConIIZElBXua364yXF8seOolQC+MizBATIAq8mT6x5mLElRQkD1v4Po?=
 =?us-ascii?Q?y7ApfTiOLjd6h2bzZVFpH7PWR1N3d3/JD9fVuwZSoUv12uaDAnBb1XrX5pi2?=
 =?us-ascii?Q?XFCS/JuvCscWR2J16LMa8OKiq21Fr9g01b09clYzZ8iFB3f7pCt3rVAzTtqj?=
 =?us-ascii?Q?78QxDrYjncAt4558/dHiFj0HCxXo7VSeb8O8cw5ZQmQ2mFD1GDmPOTkP9HIb?=
 =?us-ascii?Q?ETEJAL9HZfpqW2Ssu1OqqOqtloMoCPEUsR7ruKROQw3orV3bhtzHo83g63a2?=
 =?us-ascii?Q?Zw/pjVpCF6UB8J3VdHDv2jGdp6Mh1CvpPyNlPqAMDAYP8JwsZedEWBmg/yuX?=
 =?us-ascii?Q?9UXlkqBKh9wuDFvyH97Z80LlXaPdvuDyeVTO/W+WoumNizCPqJ3XhADJthIQ?=
 =?us-ascii?Q?yvw5bPj+2uBzhb29ImE5mox50YhT42c+7cl//QMJB4N7NvCyhpUWAVTP/UId?=
 =?us-ascii?Q?V01vAv8bJjPwN6NAc7kL1RoJGziFQwRBFVk4m2NH8KOEFdhBBD0EbZodMzIj?=
 =?us-ascii?Q?2XnWSkk7P0bswstkzdxo7dtoOr7h1f0sfQ9XNZPe6dm8c4RJN1y8VvJfbaQ7?=
 =?us-ascii?Q?WBzLOfKAaQJgr8kk5o4J1UIIT4AkQaZKg0Ndw3hpQb+8GfIDpS0BsQW9VJ4K?=
 =?us-ascii?Q?b5i1mevOPJQSbCVm3Os2MWtjJXKXMhBO2gcO+59iOT1Ggu66U+sQKoQ4AnbS?=
 =?us-ascii?Q?sKd42Hn0YuX2BPtZBGW/zGdek6GdgDpMvyBs2mx1ASIP39cr2UoeUU7phiXG?=
 =?us-ascii?Q?V2t+zN0FVPuQV7FM8b7rOKKh5o5ZeEhUuIfN2zpd32kdFZTDYGk/oTWy3Su5?=
 =?us-ascii?Q?Oo7m+cD3YbB0RFMF1qgPSoEHKRc7HLcawYwvGPF4qOF+P/QI8r4HpQbvI3js?=
 =?us-ascii?Q?PSKIuSXAoGa5Vbp51CPn3EqyUW2n2ELcbBYnT2nYKYmlz4UGG0UKRcOyuVY7?=
 =?us-ascii?Q?8gXlMcznz4J49/SeviNEmSzRTFhBHZXQiCuxPTwqpqtc9j0vTy3DYKUUKzhz?=
 =?us-ascii?Q?eBheE76ZknfWq6d9624PgiGwZfV+6kL4GqVoWCDszw9eXf3qzhihyOKwPFCM?=
 =?us-ascii?Q?0Aw1x4k4g0ORuf1tbQyp0LFTvaSngSaKQmoJ9qkDyI8qw3ixPrUjyjzYNn+5?=
 =?us-ascii?Q?EVmQ4QX5sKqYObbI4BMu+klX9/W4034xGR4E50wXAZB3Na7sp6hutZZaiNca?=
 =?us-ascii?Q?ecCi/prH8Dst2hqOe3zLW+PUSWzLTsVVD9FGpndLL+XPxs2qP2vfC4PwS/df?=
 =?us-ascii?Q?4Tg7EgPoHZtuQinjrjgDlFyzASFrZC/G8uji6t//+MQQ5ysNJg+BWRcU0wwb?=
 =?us-ascii?Q?qJtgiNJ+d7QJIE9qgzImZWBNS3fOBO31SFoU0C9VdIdce1LQpjRC177q282p?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964de354-a0cd-404d-1a70-08dbe5051b62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR08MB8653.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 11:30:30.2591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: St9++d09HWr3M791rVCgVA7AdxShw/oIxFQcb12D/MeeQRx0wCiatJ6ARRdrSwZattpKXvCskLAMLso6OwUgyVyozHR7AzNllMDXTBcpmAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB8955
X-Mailman-Approved-At: Tue, 14 Nov 2023 13:34:03 +0100
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

This config option enables the malloc() pool in TPL not the SPL.  Fix
the description to accurately reflect this.

Fixes: fd8497dae54 (spl: Create proper symbols for enabling the malloc() pool)
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 7df91d789f6..00ed1ecc173 100644
--- a/Kconfig
+++ b/Kconfig
@@ -327,7 +327,7 @@ config SPL_SYS_MALLOC_F_LEN
 	  malloc() region in SDRAM once it is inited.
 
 config TPL_SYS_MALLOC_F
-	bool "Enable malloc() pool in SPL"
+	bool "Enable malloc() pool in TPL"
 	depends on SYS_MALLOC_F && TPL
 	default y if SPL_SYS_MALLOC_F
 	help
-- 
2.42.1

