Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6EFC47077
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE64287A0B;
	Sat,  6 Jan 2024 18:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KVxzr+BB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B62F879E5; Sat,  6 Jan 2024 18:29:33 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2354287A03
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goBRAMVTbWQmumZlSfN2EYWxWq9+W1yNYIeGrzUa1TeYN9O8Su7AEO/z7nLVaae9NG1G0WZ7VdqNaVWTCKy5Ah8r2wl2b4ZMAJASW0Knp/wrSTKIxc5bcJYWhBdtMKOTnqhK6mmgdEEH+lNRoNWwHdRipqzNC5Q3QglfR+/NdtatQ/qI2hSvp31OAkUXuzYmnywsv55gMCScxa8rDjupS7/GzFctm/l6Us2GHFf+vFJ0UhLbdM3lFWSyQT4mLOCX9xxyGUMe/I82xaahW7TIYj12TCB7nYUUoPoMb9c1TvoUA0cpNID9+iKQlMkfPmeeyYEORKM1b6/VIhU9w3mfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKXUxjAZ1yvj5Llpm/rjvTY5yJAoK2+dU6bFA731Efg=;
 b=kf5d48C8aE2G5wYfS7lFrBR9g2jol6xOiBbeoNKj1wtK0XGEVAc4e7JIgYEw89K+QaUC7YieDQ/2Uvn78vtV+Bql1ZzuWVMSG6YiCksgb5ueyWitZeJmOcJBXJw7HFMmRA7SDdTuFUQLxVMUsovLSu756YmD3HxuwxQkHIZUGzTHtErfYB1OK6cgbd4EdDWDPqwBwCwTIzHkTqOm4Me2atojb/GVzpQR9E1GcMBGfucsWIdHeyGGMKx8TDRzyZibarSI2uD8fb/Us7bBAqaF1gsn2eDx9Wukh8zotYYx/6SjIkbR4olqcfhmEUbXs2GX2FzppBnCs04S3JdFQbNKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKXUxjAZ1yvj5Llpm/rjvTY5yJAoK2+dU6bFA731Efg=;
 b=KVxzr+BBGjUU+/GYutINa8dttXSjy5/SeN8sAfHE917q3M1cDe5UEZrgNi77xZl22IoiAbvl/BI1RAkZaV5Q3MPZCkEc27xhyLcH0PpWHR83crBOOKBpjSwUlQre42ckNvU9igVufn+0GzRFM3AtEcYtBUYUuQ/816A3wH+xHZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sat, 6 Jan
 2024 17:29:24 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 17:29:24 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 06 Jan 2024 18:29:18 +0100
Subject: [PATCH 2/2] board: solidrun: clearfog: fix serdes 1 / eth2 speed
 for clearfog gtr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-clearfog-gtr-serdes-v1-2-66cbc350c58d@solid-run.com>
References: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
In-Reply-To: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 4956a05b-43fb-433c-e8bd-08dc0edd06bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgAFUnahrGhtHcoY1CNLn2/iPfVuqzd8fWo4ORnKx4NBmLAll81Nu1Js37cmGJPq/7yIexGpPog/N71O9e2iDywtjE0CbNF3az9cwxPRomdcpdhaZRayZjobl5//0tzcfysJCH/VUX6lmQU1guLsg8BhjGmMjakEuQ5PBXCG8uResNGQaenvG4dClOS4N/YQUq22zR/OluYDZua0FPAyfEJYhJNOoqGRhTxVnov+yp9qbI1F4NKEQF+y2GKRuXK/PHNlTAW7fsO7ed3R/H3HxG48C+l27/xD59EAIprJn9xQqOYewafsHhnCzjH2/zWljkk0pzeatAnil2chr8VpPD0YXloeHgo0SpSxenRUHjQO0tyktxANm1ylWNtvRTE+HIr5RAvYN0/KfSs/xx32/wFUzlaELpotSCCD2Ie2W92/QeDZymw6QlaxMkMd/kODFwFIZSliOApYqEjqQwZYZiRlbuGVKoINQ3CoKP1IJ6txMSXdTtfeFCq3PdkYU/adOeQ7fZINZ+JondHJvExUBUWaFLAvSx0ZHXMADMmMnWFcUlYqkyqHmUoW6NT6P2e5HXoBluKc2Fy8pH76XZQf3RKh/9UeiOt57DXsUsDZDzqDOvvUa+QTJg5CTsH+PIDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(41300700001)(2906002)(52116002)(6916009)(5660300002)(38350700005)(6486002)(36756003)(86362001)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(83380400001)(26005)(478600001)(107886003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRqSERlSUUvdmorcDl6S1ZGbGZDNXZVOVdLdHlPZW5QM3lLSjUrazAxYUxl?=
 =?utf-8?B?cEVDaHV0a2hOeXc2QjB2cjcvRFAwVTdWWWhJcnhTL0FHdDQ0cE42bWNmNVJ1?=
 =?utf-8?B?ZVcyVVkxVnlDVm5hUXlNUVVyV0szd2pWUEZqT3hOdDFJd09yd0xJcXNJVnJj?=
 =?utf-8?B?MFhwaGdPb1hleDM1bkxMMGJWaGYzVnFkNHRWd3ZXVEJmRFhDZHRzVkRYNldj?=
 =?utf-8?B?a1NQVmRTSUFCdzVmVjNhV2l3amR5NTliU3I5bTdpa01ZNmFLSnlNSlI0SXF2?=
 =?utf-8?B?N0dhdkNJL0RPMi9tSVdmS2dYS25vek5pL1EzaHl0bzkwMWNsVmNKc1JrZmJt?=
 =?utf-8?B?dWMvVU4waUkzaFlBWmxyNDlzc2VJdjFndHdWbmJBSzRLZFYyR0Z6RVJ6U3ZM?=
 =?utf-8?B?emZNU1hSdkRHRlBHTXNDL0NRbVloeWdBSXdrZ2R5ZXg0QWNFUGdZNHJXNzFq?=
 =?utf-8?B?cWhySXFpcmlnQlNHS1pYY0dyN3VITStqcXlJWWF4SEVRcmI5WHVmd2Zmam9x?=
 =?utf-8?B?VTRJMlUvSXk4dHorN0QxMCt4bmprbEsxdWdQMHk0bzAvNVhrZEhVa1p6VmR0?=
 =?utf-8?B?d1NWeFFQNUtFVHM1VGdMMC80bDM3ejFLeFBpL2pWNUtzN0p0UlY4ZHpVRWUr?=
 =?utf-8?B?eHN1MzdCb0k3OElrTkt6a2JxOEtGcHd1U0JhbEFXVEFmMnplb0ZCZkVUMEJG?=
 =?utf-8?B?Tm1HS1diZXUzQ1B3ZWxOQjVHNnlQbE84TWN1OEg1V2VCTE96amh5V1A3U245?=
 =?utf-8?B?TmMvNG9wQnkwZlVsY0NlelNkMDIxMGRjZjBCWkVTTUNlOStTYVRySHJZUWg4?=
 =?utf-8?B?b3dVeHRTMXA0N3AwUTJCeFhkQ1YwUWFMVjJqck0wb0J6RjNjenYyMGxJOXJr?=
 =?utf-8?B?OEZxOGdBYmVRZjQyU1h3MUN5dW9sWTJwSVVvNm9hUkJCeGV5V296TDFVRUJN?=
 =?utf-8?B?OGc1YnhDMFZGbHExN1pUVEVtZzZKNUFXVzh1cXZrN3FmWmVpS0JhczJqTkts?=
 =?utf-8?B?OEdrbjNxc0JuZklpMENicEJtdW0xL2lkNzlJc1c3OXliR0ZYTjk3LytDZWZP?=
 =?utf-8?B?YTNDdkZOckRJVEVDcnhnYTlHcEp6Q0dGMC9HTFczWVpuTnpHVHpwaVNZUk02?=
 =?utf-8?B?Wm81SnJUQVY0U05vRXh1Y1htdkl2em1DZmpFZmN5cjMrM05kRG5WaTgxTWdn?=
 =?utf-8?B?eDYrVE16ZU9sbDBVcEJFWk9EUHBDekxyQVpyT1VtbDA0aVBscWFiME5WSXlG?=
 =?utf-8?B?VUtlZ1ZtWndSOWpsWEFOeFRPRDl1b2xQN1l3VkNZQWg4QVVPZWZzOUNEZU1X?=
 =?utf-8?B?TDQ0MWwzSCtpUTZZSmJ3RDV4L3grQjlzVjdlYkwvQ2tRM1JlenYyUlBDeVR3?=
 =?utf-8?B?cEZMRDRrbXhIVnIxV3RSSWdKWU83MG9lSktLbExabGNJRGx2QWJpZVZ0Vm95?=
 =?utf-8?B?VFRVdUhMUUxMT1VHNGNYcnpPSk9wRU1FU1F4RUZjWFB6dFhGYng4SUk3MmZU?=
 =?utf-8?B?bUo3QVRYT1NrZ3YzaVFyV3NJMXoxRkJVdm5IZmFJUWo3VURCY0FBM2prb1E3?=
 =?utf-8?B?S3pRRncvZ2dWRnRLck1FbUY5UUdKRUtLeEw3REJZcjZyZ1lFSUtSTFNsM0Yy?=
 =?utf-8?B?YVRiSm83bkRicXJRUjg5dDlmSTlodVM3R2pMVFlyRkhtdHRPRTNFdFp0VVVX?=
 =?utf-8?B?YUdFTWFJSXdzT3IvZ0Q4V3Z1Qm4vQlNLN29NeGFVMmdOWXY2bXFEY0N2UUFI?=
 =?utf-8?B?b1cvWUJ4SlNEVTlJUGRwbW40RVhWaEdDSVVQU1BZVWM1c1hNRlJwYVJ6TXVT?=
 =?utf-8?B?YlFlSDQ4RitDVG5yYnBOU3FONzJqUUNFbmJjenNmN3FHRE5mQi85UEwxU0tM?=
 =?utf-8?B?UDUrWng5dTRVSVpMaWt2enZGWVR2bTM4bGt4RnFTOW42Q0ZBVUd6akZscnRG?=
 =?utf-8?B?aGNBNVRNSEpvMlVyME9pemlTanI2RGFVRVVmVHBUR0VNY2xyT0NhWGkzWmtl?=
 =?utf-8?B?aEFUb3RJWVliamJVUjVWbVZyK1BpZDhrSEJpUTdpc3RPcGkydXB1L1hDNFBL?=
 =?utf-8?B?SUZQTHFaOGt0UU51RUNzRSs3ZlRJV2Z3ZVkrYU5Yc3lFRDV3d2tHQW44VmZw?=
 =?utf-8?Q?LG3YWjjW1KX04J/Uh1sR2qkN3?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4956a05b-43fb-433c-e8bd-08dc0edd06bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 17:29:24.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdxjYBgowRKbmcgT/uJsnCrJXosBs0CZfV95xrO0tpFzXZFh8yLoybTWWFAsi4X0vvEfL3vP2lb87I21YyQcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944
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

