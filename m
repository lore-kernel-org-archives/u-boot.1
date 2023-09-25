Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E785CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD2A86BBE;
	Mon, 25 Sep 2023 10:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XkJCueaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6DD86B4E; Mon, 25 Sep 2023 10:10:13 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0727.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D0486BBE
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N++4aTAeRMFQtvYWdei6bzQWEGulNNkbtXONAxaRWsPKJcIsDvOXi35y++aAzFgZCf/QcAoorocPcI/LNxWODRIuVispjC2RLLr0OjKulMnCgILaO/aYYKr3bUneVIVtMwK/vnFvQFGEB84v6nrqYluhnL4JAmRkZgm2DWWVpt9DJQE9sm7i/EBG/UBU8dAP2zQHlmk5WwJQffFyZb6nOYwytvyMS3V5pJ1Wn9o6ZNw2DfI33bcalgZnl40ybjk77F2cto8Wr8lXultJyS87gm9Jd6MBNAQ4Yqxsx3kyGEAJqUGAASBWJ9grjfDKfLJJewPC3HfTJbi3mMFjFjbjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXdmI4SQ3utdFMzij1uCVJYdnh1rzySIpp/RCsTaIR8=;
 b=Tv/e/Qrp4OJwDVqYBmkUnIuBE2tmwXCZY0FIOYYKuYInEHBC6ONLWQRuYtPGbINRGTzLYdyE1zwIJm0s/v1pi7XqpHdPqm9LzikQxCOBSM82uM/gnouFBiQJaelhRNzS7DhhGMBnz4C8OMYP0Ht/xJak/dC0WMskuv2vQ+p+oA/UDsNDFEpSt8nk7hr3mcxPdseGPwQSR2gw39Xtz+cOMeVha0bkutJLMt+LzxaAW4wtPhoLUsdNgWPmK2+7814MVVM52X0ngZqvsGu1bGFYfSJ7v/jrqxFHWgvd7mHXYzAnMoE95eibek2uZ76n8uDlIUBX9RUI0aaXMfSsBJWszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXdmI4SQ3utdFMzij1uCVJYdnh1rzySIpp/RCsTaIR8=;
 b=XkJCueaDljn9rrXjC9nc+vIOkP/lbkflqhA4eL0qldC/53zrfYim9oxW1KkYPpFj41BGoITNtvKfnvyo/Hm+AmPln72eqcI0iRFWnNB/H1r+SI2KX4gM5Sx7nd+v3Ae73ih9qOUo0QY2DztTfiQeETbWIkNwTV8isqtmblrqxCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/5] arm64: zynqmp: rename overlay sources to .dtso
Date: Mon, 25 Sep 2023 10:09:07 +0200
Message-Id: <20230925080909.365098-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfe5cfc-16a8-4e4d-605c-08dbbd9ed4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObORy1IKsUvoOlO5vEsRrl/e39xX+DjY+qdYWIP9w0aictR9pfsQhN+tioLAAVMI4yV4j1ifdBP6JGtw90LYsNAak+XHHZGG2L1HwgsDJAVOHfbl+UAEUlGjGI21tskhXI7e2+Rllf9adrn7o02z0LqPffbLq18Wqu+AUcCFfQ/jnUcwY97UxWNJS4Hzd/Pq0JEIOFHRks465slBMFcwj3IRm6F8/2Yq/mt6esOGWvCy4EPmH6dv3/QB6CrvqsMXpTOpeD6SIWGvnbeUyBbHLa4e+tGiPiInSf4a3v7rpfyox6jUHLdElUkXn0GV6+6mDCkomVH0AnHpg7bkz+lU55/DEmjD8X4+p6oIZPRG17JMopv4F5zfUUZ0Oi3JtgEe/e5Q8Q5XTDO0abe0amy32GbFyv8AgNlb+bggj6w7mDqcVnuDMxusDoYei/Q4/PeEfoSqgVvS5DFvXCl+TCaCvkiQWp2Qslaq3+jymaapE0bBLVd92yYT4qT5mlKk5SjyNMAn2/KztKxKQKljtvO7FP4dAoSX8S2042F9yGxmmJLNL2Pr0uSC6ZgB8YbgLYPX8/r1sJcYjFBI47pP7m6c2srnkoHyuEoBcUYcf4hp45RbQWtqP/c9d75OhdyFOqzjacygTzL+InM3GJKjLYUFaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iu6WwhrV2dRoZAmFNGZGbY/2pclyiWZLLAB5PcLmV8nv0sWkxOFrlPg98O3p?=
 =?us-ascii?Q?dwwYjEMIIQTOZd+YErb7tR69QAtIrMdqCEnkYUkciMpm6UgHJRvFoJU50WEr?=
 =?us-ascii?Q?ewEzDP0wqmxqGf5D71Hf8MHEZDzPWBlNRKGep7hXp+4QDQKGzcAYES3cZckE?=
 =?us-ascii?Q?dS8SfLRPaXrACu0uKyeTCT2ANZ3mYj+ZDFk/EXcO47smM5DUGHQxoWHqeaws?=
 =?us-ascii?Q?aj0TeoPdPjZRjHYakifD6XJllSzDrRu8WEg/XtpZ/h3v6dozlZae3CIIkrWY?=
 =?us-ascii?Q?SMv+VtF+gf58HEpBbhTCpG5PTj2dDUwr6dBEIqsrkSkGuMxdzmtskDsxg+Au?=
 =?us-ascii?Q?vGJbLPJAFdBS+LxiWU6hvkeBmc8c4e9iEwuXUFZu6q/7ZNSw5cJXsGVObmD6?=
 =?us-ascii?Q?rCTchx6llEPuJCTRwJFRC/aICuJ6TBFmIFYmZY/GXc+aQB9p4wjmSurKeUJP?=
 =?us-ascii?Q?VMsWhkjJNalcPZlpf+hBR66ny1wuLLME+jLS7hV0x+dOEO0SzIrKYxsi5h++?=
 =?us-ascii?Q?JEJj/+ZMSEoOkssympjrPAzHenW8FSEeqh+5TLYfhJkGeSViE/qLe0dddhgE?=
 =?us-ascii?Q?nqjwL3zT38KxiLieqk2iBc4dJRbN4BPgaCDkAvkujokWQSmzjQHGTeJtpQuz?=
 =?us-ascii?Q?mjKFaYdcPwhwZ5qsHL4nprMepZvVJqZTMa6ZVHWWnI+AhLWdWmSEOFRmnHYz?=
 =?us-ascii?Q?otYMI22axgRJABeT3uyQZPC93KAMQIIpldPyN7Te/o9EnJ0ekuK4vumXsMI+?=
 =?us-ascii?Q?GnOMVAV0S26Hniw/REaem1TWrWZqFwgqKYc1DEKzMgnAtEl+/72whYxEG2BH?=
 =?us-ascii?Q?z9qM3ytW9KZg55iuRFcuAliCgOOjgiDKmgjup0iK59gS3AN+N0uVG+8+WwZA?=
 =?us-ascii?Q?TpkjYkxJ8n9Q6Movrx1amLDfoKxYRW7xVwWqP5VXW8tyW1AbhDdOUHHzZSVx?=
 =?us-ascii?Q?UnCKPKiOvoPZ6FmVaw3wvlJxt3Hp25eYYjSM3JHc9m/iRSuHezU7H0ok8xzm?=
 =?us-ascii?Q?uMk4ZW5xe9bs8BSuD0nmyukG46dK5D8cHiV93Y1SWkfAWcnscu13DDE6IOtc?=
 =?us-ascii?Q?p5sZoT+a/qLnGFAlOCSMW0E8tV6Dc/FyZO/1yyUuPj2gDNJdBGumPUrVB2k1?=
 =?us-ascii?Q?SlMGh+xGCJXCCwhj6y6Nqg/KX77OXcXgHjqgmQ2TQ8hjjXIIkRi9QYEFn2ar?=
 =?us-ascii?Q?2jF1HDreJYgNYawOzVRFbDsZPYu42f3RySGZawxK4oKNxo3HcPp3dnJLTVAC?=
 =?us-ascii?Q?WFWL3YHhw1DxgWVsqI7/bidddc7RF4ekAeEUXXdyOfuGgNMRtcMnxEu+eP0h?=
 =?us-ascii?Q?uCEd9Qda1AyZxQbaZwJW+yecIEJuDmLHE0+jQ7sd8DZ7CfRUoSOQ3pAwtg/t?=
 =?us-ascii?Q?390u98/G8frK1/O+vOqItfsSeqm0knySK4Es5+qQL0hW2q0TlupMWPOIAuUX?=
 =?us-ascii?Q?rmn+Ol9UIGIVQzbljs1U5chVg+6BHZi8n2S/SWGIo4Ud2qRLVg3dx9V+/ZMl?=
 =?us-ascii?Q?f8/js8Zvje55XShzGtflJ1a+QkG1FKfubgBCJotCX5355K3AC4cOAf0O8SMt?=
 =?us-ascii?Q?Z3K2jhE16lUweXDnL5cIIXIik6Nm9cxxE62t6HCyVGX/59xcA5+KT35uHb/l?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfe5cfc-16a8-4e4d-605c-08dbbd9ed4d6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:07.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMYxpjSZv4xaNuzjycczr7526ouRXLQsU+lI/gFYqqr+kykgyjK6ZO2UdQq5RJrEOSy/hFBbxht/Uf7FIGDAnkutzqnZBiQGyWmuw8UC98Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso}   | 0
 .../dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso}   | 0
 .../dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}   | 0
 .../dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}   | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kr-g-revA.dts
rename to arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kr-g-revB.dts
rename to arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kv-g-revA.dts
rename to arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kv-g-revB.dts
rename to arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
-- 
2.37.2

