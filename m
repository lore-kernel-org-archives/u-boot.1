Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCEEC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042ED879D3;
	Fri, 12 Jan 2024 14:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ksHfp8Bh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD9F879FE; Fri, 12 Jan 2024 14:35:20 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEC4879D3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUPZ3gOMiOfKxDhPTAzN9SZpDYB9gCJZ338iNfKy4QbVZmSgZlPmd0J842whQ2Nzr9GdQFOHlf3Qy98TvYSlVaeY7kmoZ2RVKWLTTVQpPn1+iYPv6yaUhgighmTWeFQANO3R6DlA5r5c/z/uDCId38ocFBCrbx/qwVMxyov7ZnVZ5uUslXjmre/8EDhjdc557KNsdVFp5Bg+xTsnt04FkZwDg+25cnXSSOV+A1jFD+McqU+wLy/CJQIHOIIrrI+RIj+1OOuF6JxZuUqNkq9WjOT6kORyZLfua9Ao2X0pEGdFrOjHyd0AKdw1c6qTqOsbAUgZpwOFBgE73tmodlbuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKXUxjAZ1yvj5Llpm/rjvTY5yJAoK2+dU6bFA731Efg=;
 b=ApKjlxpws1VBNicRly1K/v0AFet6LARjnlU3HLZZPQwBmKmaT7xUJ5FCS0P3vk4Mvh9IphUUWRcKGqVUhDrUsXpiNoqP/S8V1xl3x+D04no8is/Nn14PhwvhSgHHiGbrIfRr8GN2HoeOt5IWlGbpwAxXiGjYlFX0l0zgd7f7m0LVTVxSy4jpej2AzinsgpR7HZLYrkq7aoa745iPEUtHCNxxY5Tx502a3qRImpXtl00fWsQAskHEryy3sjclDNurYLMOcioIzVs84V+QNuFDhdpvCHWeKGOuoAZs3wsRnR/Sum5L/wq3TjYYXUa8S1zv81zFSfcMF05z3hnqO7HIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKXUxjAZ1yvj5Llpm/rjvTY5yJAoK2+dU6bFA731Efg=;
 b=ksHfp8BhKItYcldPIEznthzX3daeWjAQ8m00Zm0EkELaeJvcw98bwuCMOkHy7TrKJsC5CcDO9PwQjQ4XXDY3MubTPJLYPxvBnCAVzcEPbVEgGR2Hu85zixEzbBZIhWGJTv+S9VNTwCka5zBpH8NulAvos8orQ76IxHQVnZbjoZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 13:35:15 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 13:35:15 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 14:35:11 +0100
Subject: [PATCH v2 2/2] board: solidrun: clearfog: fix serdes 1 / eth2
 speed for clearfog gtr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-clearfog-gtr-serdes-v2-2-4c24b751d838@solid-run.com>
References: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
In-Reply-To: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cae092c-f935-498a-9388-08dc13734f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFw/rwCzXH1HkYdU02Q5MKsUhXeA/P8rgnaNr7Ez2ylMOupBZtMDx5RTV7Qi/QggU1eSgi6EXYoOeVKf0XOeVL+D8xwOGK1Br5Lhu1PZa4JSV8JzN7/bS6vEfAzevtVOVZ1zCOb/DYlnb9oayJs3Ur1PVORggOj2vXqRkPO5ZEV3A3u4TeM+zauEv5hgE4KpOG5D54t9yvW+BTDyHLTfqqsJMNNSd5mh6A5B8cIJLFVBaGfVh5q1cjtC7B59YCCREedBBM/wjDvDeHeNEf1pE+wMkxkfIzpnoQr7GwhrgqLuWhLImUD7bjNIG82rpjKhKEgC6SvvpcnHVGYK7NqGyChs4OfMyhxuVd6QLLZ0cg0CqNoeaCTao47UnPYeKIEI48b3dr2gcold5KKydNgiMLOV571GpkbXwHaQ3OS/Fohcub3Z2niuzQLXH7aKkLQoMcqvM2ZZlgVztCVPjsBWs+NoXyeuiyU5EADekTM4QSWCwocQ70InpIp9IpzDnii2CDtWMVi0juwp/gQ5m0bdz88PLNts/LLqqtmnNC+8bJuuIr/Q3b0AX6br0RSvuu+wOqnQOfSXhXfXG/merC3Gq0Tri2TAT1GkMKChGU5LPEbor5yvzk8mH4qy0lsghFET
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(2906002)(5660300002)(8936002)(8676002)(316002)(66476007)(6666004)(41300700001)(66946007)(4326008)(66556008)(38350700005)(478600001)(86362001)(38100700002)(6486002)(107886003)(26005)(6512007)(2616005)(83380400001)(36756003)(52116002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3Y5T3lFYmo2ZXQyeXdMMDBWd2tOaGVpV1F2OXZ6WjFHdEdoVUJwb2ZvTzRs?=
 =?utf-8?B?aFg5YUtycUEwWnBEVU55bDJ6Nmd3d2dXN0NmWGVGSjBXLzU0VXRFT1VHNzln?=
 =?utf-8?B?bUpIRlVtSTdueFZiUTJsak9FYnNpbUFJa3dxSzZ0SjJOaUhkdjNUMlpGeFBt?=
 =?utf-8?B?MklHdW55WDZpY1ZMbjNHS2xFd044N3k3K0xrVkJhMEhjMm1uQnAvaUhsWnFQ?=
 =?utf-8?B?QXYyWmtURWlxTzN4REsyL3g2YnhUMjV0ajRCaGxwczNwcFU2ZGZZSFk5cDhh?=
 =?utf-8?B?RUxWczF1S08vd1RrcXI4eERvRFZ6c01LVnJaRk9PbmNqZy9nZmIrWUZxeUFG?=
 =?utf-8?B?bjNvMHFFU0YraENGbVpEeDNnVys1ay84Zi9FcEdOWVlGV0NtaytEdHVtOVRi?=
 =?utf-8?B?YzRxUVFKYjdyY1pKZHE1blJ5MHd4NW9ON3p3bmVMNWFsVnJIWXJhdUk3R1dF?=
 =?utf-8?B?VHJpaHdBUHorTHFzbkRDcGhudGFnWVpWdnkvZ21acXhPMWwxODN5d0xjb3VC?=
 =?utf-8?B?K2hET2QvY3pLeHFZaVlyNURPSVI0TVIreG51dXZ5c3pNZkU4a09uNkE2QkVq?=
 =?utf-8?B?Q1oxaDRTZTlZRWxsZXY4VEVHaGQwQmxuNGxqdjhoR3hXYUlENkZIb0JWQkZY?=
 =?utf-8?B?c1IzOW5IdVVKbjFjdzUxQ0NSa1ZPWE5YZ2dDUXpkeGRmTzU5SEJFUTNjN1Zm?=
 =?utf-8?B?V284a0RuMWVRU3VqcjcvN21XNlV5TGJZdU9zT29zMGlxOFJoR1BCVUFWbmhZ?=
 =?utf-8?B?ZGliK25QbXJXVXpGaEVmdFBTczRIMXRxby93dFBQTWxFNVU3VXk0UWhsWVJ5?=
 =?utf-8?B?MnZTb2R6S09DOEdtVDJxWXRFdWZyZU1POGtiWlRUZUhSK1JLUVFZSFJFaFlh?=
 =?utf-8?B?WDZoTFFFRUlWTlJmZ3RaQk1lSEt5TEJxb0V0c2tHd240TmNRbTJMSGRuSmVQ?=
 =?utf-8?B?OElRYUpyc0pJcnV4S0J2K2E3SWYwMlpqZXVaekJ2ell5dHVPU1Z2c2tQbGll?=
 =?utf-8?B?STlIc0MvdW15MGlKY3dqanJGS0dZQ2twbUVOOExiejRyKyswTFhrL3A4NjY3?=
 =?utf-8?B?cEZtYjhWMTZ6a3lpc0UxL00zZmpNRm5RenJUTzFKajJoTEJ2NUQyeWhuSTl2?=
 =?utf-8?B?Zmo5SFd4MlgxTGhPZWxYTFFpdGJzWWk4eUl0TWp2TE15cjArVmRZdkdwOHlY?=
 =?utf-8?B?TW5RUmJBeWpoUWtmb1M2NHkvS2xyTlR0dXl5bWxyRXFybkZZelpMTWtDZ3Fu?=
 =?utf-8?B?V1hYMTM4SUdLV05LU2tHOGtucHBVajRCMzRyTzJDMlkrUTR1NVBzMi9VM3Bn?=
 =?utf-8?B?RTBkU2VtWnpnY0dmNmhxaThYU3h3QjFpZGxkY2FHMFFHNWk5QlVrZjJHSXVB?=
 =?utf-8?B?Mkg4bDkxVmVObWtFMXdzQXVFeXh4MzBVbFlBSGJVanhpb0F3VGdMMUZlcCtP?=
 =?utf-8?B?T0Z3a3FmcmJQQ0hya2NiYnJBVWNjUE1MMnM3Q0RhZXF4bDRSVVhlSHBDYjJl?=
 =?utf-8?B?dmhsUi9zbnpabEMwWE9zeHZlQzNqQ3pGMVdFVFYxclRtRUc3d2hHOXZBVUxQ?=
 =?utf-8?B?UHRzQ0xRL3FMUGYwS2hPaFZocTh5QnZlRWVMb1hzcUdQamJrWUhXMEgxZFlW?=
 =?utf-8?B?YkdTZU9RRGdCSENWQW85dU5jNHdHTHgvVXErQWRpRVZJNnF2TGovMklleWJ1?=
 =?utf-8?B?MnZWOUx3MEhGeHJXaHhzbkRwckZHOG12YVg3R2FzSkwvTlRkNzNuZkFvM2tn?=
 =?utf-8?B?YkF5cEhlVjdWU25odDhBYUYyNWtmcVkwWUdpS3BBcktXS3dUdi94YlhoRUE1?=
 =?utf-8?B?cktvWXdSU0QwSlBOQWNZazltMVVEMGxnd3pHVkRnOFZIUExiZjJGaGZoVUlG?=
 =?utf-8?B?OXVwZURlUTBnaUt0UmcwdmhZYVJYOXVTaUlVbVNTZzFJc2J0UUV6MWczQ21U?=
 =?utf-8?B?cEZJcmcwOGdpSmcxV0dkY3pZVi9nMW5wd2ZPNnd2RThzRVBLejNSTFZzVWhF?=
 =?utf-8?B?TGsrZGZjSWxONUUycXozV3FhRy8rM1o1WmVMYUp0cHlDUkdYMi9oK2p5bXZK?=
 =?utf-8?B?Z0o0eVo5V1JseTNCN3ZiV2NjTGI5NGc1a0NuZ01ZZjBzMFgyTWJCQ0ZaZE1r?=
 =?utf-8?Q?+z3CmmYxajM5/com/wXrkiN/m?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cae092c-f935-498a-9388-08dc13734f57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 13:35:15.4840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7H695S1A9836K4Dm/tLds/n80TX8pfnVnpsBey0dK8JfF9VjSOohghNHPjLYpi+dcN6WOqhFni94RG1/v6zYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
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

Clearfog GTR connects eth2 / serdes 1 to a 2.5Gbps capable ethernet
switch port. Linux already configures a fixed-link at speed 2500 from
device-tree.

Upgrade serdes 1 rate to 3.125Gbps to support a 2.5Gbps link.

Additionally add comments documenting each serdes' function of clearfog
gtr, which are shared with clearfog pro.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/clearfog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 51c5be518a..6977db0a9e 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -98,6 +98,14 @@ int hws_board_topology_load(struct serdes_map **serdes_map_array, u8 *count)
 			board_serdes_map[0].serdes_speed = SERDES_SPEED_5_GBPS;
 			board_serdes_map[0].serdes_mode = PEX_ROOT_COMPLEX_X1;
 		}
+		/* serdes 1 is 2.5Gbps fixed link to ethernet switch */
+		board_serdes_map[1].serdes_type = SGMII1;
+		board_serdes_map[1].serdes_speed = SERDES_SPEED_3_125_GBPS;
+		board_serdes_map[1].serdes_mode = SERDES_DEFAULT_MODE;
+		/* serdes 2 is pci (like clearfog pro) */
+		/* serdes 3 is usb-3 (like clearfog pro) */
+		/* serdes 4 is pci (like clearfog pro) */
+		/* serdes 5 is sfp connector (like clearfog pro) */
 	} else if (sr_product_is(&cf_tlv_data, "Clearfog Pro")) {
 		/* handle recognized product as noop, no adjustment required */
 	} else if (sr_product_is(&cf_tlv_data, "Clearfog Base")) {

-- 
2.35.3

