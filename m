Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19506CE7B05
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 08:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAC0869CA;
	Thu, 28 Sep 2023 10:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="g9eS7gMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF1386E13; Thu, 28 Sep 2023 10:03:13 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9785086844
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 10:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkXie1bWpKaOCKhU/KRK7W7RvyL29BNabEvWdYAshkDU6ATtF/y0vi8OIfFm7fO8kR4zWNiTpGwmtcp95IcMkBEU9mkeH+Wzow+h/F5UYKgxBEEqAVo/q6y++GfrQhSW67U8barcGrEdqwEuHQdp5yMyBxFfWUeJ94dztEtypjiPbX1BIr/Ih6Mnnk2tlxAucSwWVforj3aZ2w1eBewE/5bLGhSvI4st/jaKKfseQVkCbAHK9eaBKOZyHASptOxxRA9MHPrBS5JSNiV3eOSMW5QK39EJxAaJtvilhG+Gnl3LukuPmQJcbzRt6IZbXaLiAdxWFnpFjS0QMT/3ZfcYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxBkGPHo7hlTNbXNFyAjy+e0A2ee7RBM7+7cgU59w08=;
 b=lo3zpx89AsG4KMJ6ewgJP/6DeHoShnpkBclQIoy+CyASM7TPF7+VN6x5w9PbTrVV4kWB1TpHy6071Pc32gAdPjZw3/JZRcC+0ICc0AlJDu+jdM5EWdlk76wtNl2Fs63hIqY6DTjwo6udsPx00DtZJ4QKuJVFgSMKjOmw3qyYXBwLz6lKFZwG9iXhmWQwDXwwExUHLLibZyKwEnXvEYDRzvpe28l/XJe4uOn+L1TWrEtqFJJ+TUybsneIQcZf8e8FDrn2nwTX0J3vwYjlQzsP8Abuc829+696XX8U99L4vM1Sh0MF900Zm8C9PTisg3dMhjAwyDbYKeJIPa2Pd1+xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxBkGPHo7hlTNbXNFyAjy+e0A2ee7RBM7+7cgU59w08=;
 b=g9eS7gMaSqxjrsGie6NK19NUXQxD6t/2FzEQHX+Wd1Mdkzzpuw070hlg97WKPEJ1nMBRFtlvz6R3QkpHuUgnK5ScdpN8nmCSplhs1x961QUZwVu4yV7hVOJ0FqMh1/myoGdCGjDyO1eweNkqgvcZ4A6QoIm5+UpLUsl0tg30wAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 28 Sep
 2023 08:03:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:03:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 5/4] mkimage: update man page and -h output
Date: Thu, 28 Sep 2023 10:02:57 +0200
Message-Id: <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6b0716-87cf-4ad7-8d30-08dbbff95943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2ITcE8Oe6fw9jDYaZDWgXOD0dphtOLV+EVAa1jDxkOufMA44OeOA+oF5uyBc/G1BeCzRS+cdAEi5NPvV2p1dB8AiUYWravkiIdP+/ONSLf4RDGC414pCRG6xdLz4bdnFdW8WPiqQ4CUTcW4ich+Qwje+d546cEQobyclx2xzfJEu4iCW9oQorOTEzLOmFiDtvlY8lnhtebxTYcNC4IoSTJQthuh9lV4Rkbg68WK09FLK9BMBLuz2xxGoDGQ00dsPq9L5wSFzyyGJ1eXUkpNyeEscXxrXFaB/R5lBHX+PKOV16eA9vJknMmBeEu8F9gTq+P1TxpIX4MjryTLCfEM2vfbRrmzctslVghJZMoIK02uKwGjClPFb0KX0jAiydjo+WBuE31D4OWc/oCG5b8i38oGdun78qUBnjg3erUGGdmEUCzfzNJa5yRNHdHK2Rp4b/U7VBl0Pv7ArYE6/L1k3B32aE8ZXMM3qlky2z+epaASsSvzVeUsoi5P7utL70boudzRTGFYRls5CSyWsMxjuhk4bvwiQK9nbVx3kKqj4/pPcVDb1T86leA6178KkoBpDYobQ8S4/nvzCJTpU/35ijd+GBjyrakfScnvXPM02uvXglyPcw0XHyAjM5C/34UE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(15650500001)(44832011)(54906003)(8976002)(6916009)(66556008)(316002)(66476007)(5660300002)(8676002)(66946007)(4326008)(41300700001)(8936002)(6506007)(478600001)(6666004)(6486002)(6512007)(2616005)(26005)(1076003)(52116002)(83380400001)(38350700002)(38100700002)(36756003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5NHiKBWsN+9GDcGtDwOnB/B2cMdk4SxuljGl3qRpnLkVmEE2/Zr4sg1IFBb?=
 =?us-ascii?Q?zpDVo5CrRZQQDHfalUbqnIyLiXSeo2NFw0EntVWWbUIG7A7dnGFESVDrdWRx?=
 =?us-ascii?Q?GyL03oaX4dZ0xWeOKp+SSfSHJ33TLoMmn3lqFpc+wf42yMjeI/7kxf/kPHEQ?=
 =?us-ascii?Q?U/fflGhaKYx9+10FlS3WhVsYoOmCr7iUCmQhMjq+Qxxt7HEeG1RmwslshoBq?=
 =?us-ascii?Q?PfJb7GL2AaWS3+r+HypslWmwVq3d+O6FY3PykhmblIxEk+BcjQ2fQ8u9n052?=
 =?us-ascii?Q?NtPwW6zsRngGJp3rIlZsp4nKaSjKcABIp/AVKXMIYN9XvnUlnTEXNlmfQAPW?=
 =?us-ascii?Q?OVO4ceHUgObp/rrmThar7sxu3Og3A5uiBeTz+BGewbE+1LR10H84+IAXd6hJ?=
 =?us-ascii?Q?nt4LefTj/WJgoVEY5xoVw0waPbuZiCvz9h2n/KqE+qBcqb8n1xOvQhNJiqAU?=
 =?us-ascii?Q?QFLtG+iLzP9vNch8iRioxJ2TSI5fWUfvLbuy3SIZ/a1LPmGDpSJ1g5wLf6QH?=
 =?us-ascii?Q?j1nfbNNeCORoC1ZUlY4Ww5KnpzSzaAP/0ol+UrwXWfDToJ0FquHQimAyKTN9?=
 =?us-ascii?Q?U2xbiru7RIl41WsklzZNFVIIXXX0eJsNefhj2qft+u3NPGJYFnicOUSL1ZhF?=
 =?us-ascii?Q?HkydzkLCcT+ip6ql6fx9L8ixRAYXkWVq9GJfVdqgZBJ6vIiWAPHbZjQUuWb6?=
 =?us-ascii?Q?Y2w/+M7UtIMesn9SvUr8CaDC/vzgTqG8IZFcoJ2NvhbGNckFBXuVCQnkvytA?=
 =?us-ascii?Q?0eOqS4pP2s/QHRXjFkBpcDXgFKJhe5xrCkWcJAFTA997b7sjzcj3c6lCXH7Z?=
 =?us-ascii?Q?S4sfF0Agy0+4EOUrwlbId52IwxSa6NMmfGuKYNdHWzTDB4c7WZ7yYp+fKF50?=
 =?us-ascii?Q?/CLcUl1O3c6zyzWC/sljlFHjUOGgtAGPqoGj8mumzWBApHO+s8BCXj9ZkFdR?=
 =?us-ascii?Q?sPsAfFoiI3aAf2U07pbbNTmKr133VPwm5VEyOVF4zhxRuuZj6rx2eG3F4xGf?=
 =?us-ascii?Q?niXL1BR5ElW8DGVI8ZyeFcgw3ZDxT5JgDBn1GHssEQkHc1x582cCP//1rlbg?=
 =?us-ascii?Q?WxtBh0//RB9srvd/Tsli/vrxJM8B8/bOYPgZZzI4+1b0sfkPaufLVW+Mmwef?=
 =?us-ascii?Q?MHhB0wfdkzdU+9sbT7QjBlEld/bcAkJroWjjpH+hLYidCYdiSbanoSEaHke5?=
 =?us-ascii?Q?muh8o22yrZFI9+BqSvz672bTj2hBa6HgzI398ZeRcbWYz+5wGQ7Q8buDxZ+7?=
 =?us-ascii?Q?xxY2p7ppasmWHmdc0kiUYab/TfUKZdHS5w+MyRB3IpD7oA/07uc6X5le8bBl?=
 =?us-ascii?Q?rAPOQ53qrXBJag20opiDeUDZkg92n7/94YSA8iXvhpfz6EWLQzCy+N0Niw0t?=
 =?us-ascii?Q?fEcUpMINT9+VXzXauHqiT86oEEqdMkz4gG5jGuT12Bejw718kdb+WbnH8fBO?=
 =?us-ascii?Q?uz3MrDkjG5pZUIeeD13Yy1nHyxdHIZdhq3H84yrW0t89shVUBxHSnUn9A21M?=
 =?us-ascii?Q?RZ8/PswSXOyeuMFbnGGCx/Pq2xn3Wu6r6mEm1ylL83W0DTOK4pF1P5l/iG7m?=
 =?us-ascii?Q?R669dzD3UkQvziS1eoXtzG9Mm9JvZOsc3mXziTDE0rbBbp4QJWqNYbbFIjeE?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6b0716-87cf-4ad7-8d30-08dbbff95943
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:03:06.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0aUKaBt17Kn7WU3/VptxxXz7ogJoWVBmHI/yddJvn14jDjmYLq1wqiAu+HPGswLeK5ZQziuebPu7qL/NjzpwVgDsnCe/QxIeMvWEJN1mtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6851
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

The man page correctly said that -B was ignored without -E, while the
`mkimage -h` output suggested otherwise. Now that -B can actually be
used by itself, update the man page.

While at it, also amend the `mkimage -h` line to mention the
connection with -E.

The FDT header is a fixed 40 bytes, so its size cannot (and is not)
modified, while its alignment is a property of the address in RAM one
loads the FIT to, so not something mkimage can affect in any way. (In
the file itself, the header is of course at offset 0, which has all
possible alignments already.)

Reported-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/mkimage.1   | 6 ++++--
 tools/mkimage.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 76c7859bb0..1a4bc25936 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -281,8 +281,10 @@ properties.  A \(oqdata-offset\(cq of 0 indicates that it starts in the first
 .BI \-B " alignment"
 .TQ
 .BI \-\-alignment " alignment"
-The alignment, in hexadecimal, that external data will be aligned to. This
-option only has an effect when \-E is specified.
+The alignment, in hexadecimal, that the FDT structure will be aligned
+to. With
+.BR \-E ,
+also specifies the alignment for the external data.
 .
 .TP
 .BI \-p " external-position"
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 6dfe3e1d42..a5979fa6fd 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -112,7 +112,7 @@ static void usage(const char *msg)
 		"          -f => input filename for FIT source\n"
 		"          -i => input filename for ramdisk file\n"
 		"          -E => place data outside of the FIT structure\n"
-		"          -B => align size in hex for FIT structure and header\n"
+		"          -B => align size in hex for FIT structure and, with -E, for the external data\n"
 		"          -b => append the device tree binary to the FIT\n"
 		"          -t => update the timestamp in the FIT\n");
 #ifdef CONFIG_FIT_SIGNATURE
-- 
2.37.2

