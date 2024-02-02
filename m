Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB38C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4307787BFC;
	Fri,  2 Feb 2024 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CraYZEcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 615B287BE5; Fri,  2 Feb 2024 16:13:45 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89A387BF2
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1fhjsbpUARl4wjk/gCbFeVIRpI18PyjET31XNgs10LkEIA4cFEws5qflYoXp+I3ZUjCqV0/kECK3W0wbnBnMuWn2rnO6LAaFt3ZTmYYTF+FJd2X4jxPIBFbdcahF4i5A0wHqOXqb6CAUlqMIYV+/1c8RigIrMKu0kjFCVCVZk101x1k7N1SYnS7ijKnn/rNBapUB9HUq29NcPtz57Q7+6T3xBJOQUxrASWqUCz/wZo7I7v1o2HF0qVBI8SVvEZwPYeZWamw1PDMXRj4scYrXRJTXtyQprnGJ9eEyW4F0FOkEmaZp5zDUucCmz1Dbm38fb6ew+WnxaRimKC+ZApcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmV0zV3l/PdBKU2RuLmh0s6ACnyXG/WvynqbHq78Y1M=;
 b=HyUQpUi3cZaQY3+fpCciuAy/z6/KTQt8o8WWk4SmoV571GQJ281yGGNh2Dsvl5BqiWxFrQAfSb9qqwGdnQlp8MkXHkQkB4MK7+2mOIhLZ/q4R2/cuxHD98n367yFnj5htLnHC4CDztY5+U3zxlVx5hhdkp1NQ8sUOkQt0Xlmvbl2F3jSfWudfU5uh3jZD3cyEj46cx8RuspIWWJikYMYKSD2H/knybFSDnlL6WOHDr3U/O+tG5pRzmAO+kdQ9S/BRAKA3xAi7pzDqTjKPNzt2pFrgJN/OXQXt1l4M5mDBobdK1AHayfUN8NOehzih3xM5oD9D90biOjWlgxJVaZuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmV0zV3l/PdBKU2RuLmh0s6ACnyXG/WvynqbHq78Y1M=;
 b=CraYZEcvDZsaL3Oxg+wSajt+uGCZx2qXKCa54bDCoFJykYu1Tx8p2tBUj4kPZ+UG7M/aJ8gJeGuTr+JjH/ZDsOQ1pr6PRKeANlVF5QX1ZRGo532UjGFtlwHIitXWq9VHQ5AZxWALJJaIJCknltrI/UEAySuClQd8mRZJqyqmzoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 15:13:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:13:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 16:13:33 +0100
Subject: [PATCH v2 2/3] arm: mvebu: helios4_defconfig: enable setexpr command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
In-Reply-To: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 4484e6b7-f6b5-4ae5-3c13-08dc24018967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SCsPZtASpe9JAqJNKEVSxRA6UgnT8eOIssGMEOPrimWLC+J/jHwL3cwl0UNafS9dJgHIBI1mpTjSppaSx4Co/qzxC6l46Ze5c+3pLo3i1Dl43TBhmszMpQ1WF+Rs6ftQxtXrLyZHMEtNAyx4Oa9XNm57npwxxWMq6A1YxJdFgWia8cgK7aL/LKXKC58PLiLGcXnfpp+JKldnMyJwqLXxDnEqPz74oOQtCKmuGdpMIaAlYRkCU9Ml5TFV0ItGFeruDhD1ePdz/fy9Zw224jLD0kOHL1C7OlQHOx6+Gv7IKuCEymAZdHpV30wPuM5dG1p29qc9jZE3seBu9TlTZEJQHzL+e/ip+XatHIwOpCqroWTGCJff8yq+PQrYCthKfms79psOmpdcmRHNOVbjxkH72eVfTLUhGDDMT4NxyyyFK72+QgrprDOwI5rzsgqKv445FGyL5h5J2RLTs9CwEDN3U5wz8z1isF1zBkDCXXxC3EJqoPte7FuRAnJ9bvq+AmSCRoROSnq9v2+jqwoEmY5mfv2wcRcR8t4C/cV8I9gDU7SyRIvVw/D+utgVKYUhixye5S8hNulUMJez06FPIP6/6VAOdLBEpMjpoVAqesaAiSafnRWgKoPt6PfueBC9/Dr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(54906003)(110136005)(38100700002)(26005)(107886003)(41300700001)(83380400001)(6506007)(6666004)(2616005)(6512007)(52116002)(5660300002)(2906002)(8676002)(4326008)(8936002)(4744005)(316002)(66556008)(478600001)(6486002)(86362001)(66476007)(36756003)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnMwWEV3eHFSb3J3a2xKVHg5T3p2TW5sajcreTNXN0UzRGZFMVc3Q0dLQ3ps?=
 =?utf-8?B?c2VLOUkyOW42SEhHMDM2ZExnWFJ2VjF6UGFWV294VGFveTV1OVl1Sjgxcm5V?=
 =?utf-8?B?bGVMUlh2TlpNd01CS003aTllNXF6eTVuNVdqd0VzNmZXd1hsOGlIU2czWG1N?=
 =?utf-8?B?ZWswcnNud2tOVWRVZVhob2sxb2FHdUJCa3Fpa2Q1V3NFQUE5ekNCekJsU1Iv?=
 =?utf-8?B?bGxYbGNqV0phREsxMWc0anNSSThSc1FVbVJFSi9OWndqeGJURVVCV0lvQ1g1?=
 =?utf-8?B?SGxmY2J4RDRtK3VZbXFkNCtadVBoVFFXWHFVZ1oyVFlmY283ZG5XdXd1Q29i?=
 =?utf-8?B?TkVWYnpDMXJiWURZNzNqQ1BraDFWeWtpdjJhSE9BQ004MWhLcWVqTkV5bGVw?=
 =?utf-8?B?V05reVhFMWcwQ3lIU3dKMkRrandCcHY4Z1lBZW52TUtIL2QzbVBZMFFUSFFz?=
 =?utf-8?B?dlhVUXZIQVQ5OEZxeXFhY0JwSzlhOHZDdlBFMHRaQWZIa2ZNdkJKb25ML1lL?=
 =?utf-8?B?S01aWGlYeGg0RG9NMHQzeDhtcndJRGJDV1c4a25EU0U0emVqM0JHcjdzNVI1?=
 =?utf-8?B?aEE1WlVRcEY2aktoOXo2YUVNL1BKMmg1dmNxVUVLeDhBY0dZNkM3T1JpeG5I?=
 =?utf-8?B?SlNVMUZDdWdZTzdKYVZOSGJDRnlleUhBYjJ5TEV2SmhObjI5d0ZVMzJHUm5T?=
 =?utf-8?B?RW15V05aUzRCaGpsS2Rid3cvZnRJdEExV2t5VDFsUmZMcjhCYkZrc0JvM2E3?=
 =?utf-8?B?Ni9kWTNkUGZvWHV2K3hLY295NWExSzVaYTBnWVB0Z1JTT0hCaFl1YWw5Tjg0?=
 =?utf-8?B?SVdUSXh4VUpjWklXZ3Eyd1U5NjJDNjc0cFVkQVVqVFZ1dm1qSWkvQXNwSTJm?=
 =?utf-8?B?bk01ellZbTdwR2RaQW0rWmdVQjJPSlNoMDU1eEtTTFBXZFFMdlJ4VXRSZUxz?=
 =?utf-8?B?YURhOTlVSkJ5TGhlVkdOM2x0UVNoY256NDRnVDRFbTZ1VWNRY3o5bUlFSXRQ?=
 =?utf-8?B?VmNrcmxTMlREaTZGdUttU1RtMXpnb1Jvb3BRTkZNeXMxUlpWTHZTb25MQyts?=
 =?utf-8?B?d0NnbXV1SVN0UzVTSGJoWmw0aFd4bzU1S09neHZpTEl1QnRsVlB3K1QzMmFj?=
 =?utf-8?B?QlBpc1NucWpoeGZzYTNUdVVTOXZRUENHS2hRU3BSc09VZVVncFYxMi80dldu?=
 =?utf-8?B?QjlZN3MzVFlmWGUxeWhxT2Rkc0YrRkRGOG5nQkhwWlJGN2VYZEpSTWc4OW5V?=
 =?utf-8?B?OU1hTitFNmk2d1lPcExTOThXeml5VUU2TlVIMXhrWXl4aXFPWEF4VmorZ0ty?=
 =?utf-8?B?OE85VVhqVXNZcFVjYi9PUlp2bUIxQkY4d2F1OUVPOVZlVCtNd1dubjZzMDdL?=
 =?utf-8?B?T2hzdnpDQnlFeGdGV1dwYVpQVWJrUnoxcDQrNVFBWUkyN2U4SHA5WC9md2Fv?=
 =?utf-8?B?Rm5TdDB6M25odXlUL2svLzM4dUVtR0RVKzg5ZGJxU0M5amZuUjQrSG9waTJH?=
 =?utf-8?B?cmplc0NKUm0zbmhUWmNyM09kU0R1WGhxaTZWZGVjWGJ3NFVGdTZlRWNKOTJp?=
 =?utf-8?B?YldlS0dJY2ZQRGh0NGRBZ3JsN05aaHRGRWxvNUhwc0JUTVpJNHIya3FIa3Zx?=
 =?utf-8?B?RklrbnF5ZDdhUjB3SHlUMGYrcHFNNTNmKzhHY2tUanphRyt2RXliaG9COW8x?=
 =?utf-8?B?UXRMZ3RGNWtURHh0UWRvdS9sNWlGRzFlRFVHMHNEeUNEVHhnYmREK1VNS1BS?=
 =?utf-8?B?Vkh0ZnN2Yk93Y0tqejZvNEUzdDQ3YWt0WGljcXcyN25jSk9YeEJiYXhITElB?=
 =?utf-8?B?UGFZNEY1ZHYxTWJHem42WVZnOTNzSzJqVEZsMmwxaFBBbGRTOElzU0lYaTN1?=
 =?utf-8?B?MnZ4NXNkLy94dGdPM3NJTFE5SHJpektNWVhtanAwcTVyT2NHRDgzQ0plWHEz?=
 =?utf-8?B?MVpLNnFDTVYrOVV4OVFyU2lmVlB6M01VaWpjUGFvandNdXhweGp3QVJweWRw?=
 =?utf-8?B?bm5UM0U4NWg1YmdnTk5oaUp6VzJDTVNpbVZOaU9lbnRkTWtrNGQxUHZEWGZu?=
 =?utf-8?B?U3FDekcybTZ3UjVQRzdqUVUyTmkzNndTN2Q0YmgySzRrQXpEVmxVQmlRRGlC?=
 =?utf-8?Q?DKjaeaxyU4x8ugm74YyOtnb1N?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484e6b7-f6b5-4ae5-3c13-08dc24018967
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:13:40.0945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7JphAPcQm3k1NNq2JFCAhE6tSDe1k9m2n9TVuBThUtw39EO+yRT3+2lJ7tTaB7CYbsA6CWxsdXovuehuOHTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
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

Update the helios4 defconfig to enable the 'setexpr' command, which is a
default and useful for various complex boot-scripts.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 configs/helios4_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 04194004f0..73f0638344 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -44,7 +44,6 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y

-- 
2.35.3

