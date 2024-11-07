Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E4D5AE72
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9323E89221;
	Thu,  7 Nov 2024 09:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="NBHcvKtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FD2891B0; Thu,  7 Nov 2024 09:24:09 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A5588C4D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmtUD1JafSr0yqSkLDEyFS+1RG/lF2dot2qEtNb859seH/TwFY3RsKckAgmtUFhNn++UsOVKe8ig6hPuxU41bNaV+3txIW2GOVPc/vuLdUD0bGg6H/JuCw+OjtJVzZ5UmRszXuT8KnPx3LdX4YMm+LX5JhiI3QwMlYeQyKEcbHT5E7sMnpt0v2hO0NxLTkR1M0wbUy7PwNWJcwy8Gxet4LYgt9KrQQjPA4dYg8z4vIaJYZU99pzL33Mi6VKWXtkKsTwJYhcYHthSKTsWT6tdbIiMyXHiYwx8S9x/JvT2wU4CF4OR5tfMPoHXSRaqgrXxonGpMixKudU0vwLublW67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Uc8uvBnouJIsZHBshbsxl0GsbPq9jmiHby212Padk=;
 b=CicLtRLlvMAgWXJpJQuKBhDkHGMyrtswRCyQnyTIusRLhzX2fJYc+3vZtp35vYMtpgPdFHo1svut22BX/A7hd8SBaULaGv/RmLWblu31C1o/lgmhWNnQ5Eryt9BANPo3fZBwIEn+xE1DJXMaC6vSkzf0zDGXWtZSc3fY5luMKgnhT8Kg6JwTw2/Uc67NUFEizC/JwtJeTbG9Yudfp3/XusawOlORWV1iTPZ4VKjcfsIdKOtPH+lBHux5BdlczwAQ9Th1FmRKsHTXnEZpEAyqmfop7wr9iM0TT5TmDvSW8EPpPMHv9juAZsAT5wFw/wpKFZwnrzr9junQmkl4GMjRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Uc8uvBnouJIsZHBshbsxl0GsbPq9jmiHby212Padk=;
 b=NBHcvKtthsuYnz6lzdpc9Iaem+AVi2MTt/nF/8GSMLGN07suJ4KQ2EusJ82D2QiQAcB0Ic0RLePgP11eN6UjdkMtopNMKCDTfaWv2iv050OypOiGGHLjMkvjlQc/cev7EXSuQmeZd8/xPtitsEGBoOFwDyqCikn86u/FY/iBslY=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by PR3P195MB0474.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:24:04 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::b) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:04 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:00 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:29 +0100
Subject: [PATCH v2 2/6] phycore-imx8mp_defconfig: add optee load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-2-bbc3747a60e8@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|PR3P195MB0474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5934fc-cd4f-4901-4b76-08dcff058aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkI3WlhCQ2tRVW81OTBWNnlXeUpmYzA3Nm1mb1UxZEhScVlMcVRUc1J2WkV1?=
 =?utf-8?B?NFloZ3NYdjhBdklYUkdaNGlBejRMUTd5ZW00NzZoNlBZWjkwdEt1blFhQ3VY?=
 =?utf-8?B?c3dMVE8xQk1tTGJkb1o0ZFRlODhUMTVZTmk1LzhYUW9wcmlpMWhDVUFkNmlC?=
 =?utf-8?B?NnlHdWpxTlZ0djRwdDhrUmxUMkg2bE5Cd1BmejNpNGY3K3BnSzg3Vk9ZNGIr?=
 =?utf-8?B?N0dHMk93TExLK0VOT2F5bHRZN1JZMEVKUzRjR2JEL2QyNm42V0R1ZG8zWlNm?=
 =?utf-8?B?akNlMnU3aDBQRmFmTVcweGRGNjZRY2RHRlZNNU03WVJIeVc4R0tRdjZzR1Ft?=
 =?utf-8?B?c1c3RGlsNXYzSjU2b0k1SmtwelpJK1RWUzRhUkRlbDJMVjNJOW1USlp5b3ZY?=
 =?utf-8?B?azJTOExPNC9EWUNiUXp0eHZwYlcrSC9rRmJUQ0o3OVlvay9LS0NkaEUzZ3Aw?=
 =?utf-8?B?YlpFSzJYZ1cydEFVL0FDQk9WSkVSRDBXSkc2MHBxSVNLS0NMRUdOMS9BZ1R3?=
 =?utf-8?B?dHBDZWdJTkZpYkU0Ui81RmU1OGF1MVBCa2tONWNyd21qbFpXTG1MSGRnR0FN?=
 =?utf-8?B?VVhFMHpCQlBwcjJqYXV3Z09xWmRNbGd6NVloNUYrSXdoL3l6Z0dGZ3ZHaExn?=
 =?utf-8?B?MFZ0cDBobmNtdVhkZ2tNOUhyb1VqQWlQNXN1ZW00VnVTWld6NlNna3NybXZV?=
 =?utf-8?B?WW04Wm56cmFtTEJUblNqNkJBT0NNSXV2Vjd5K3MvbU1NY1lZWWFEUmlWMlpt?=
 =?utf-8?B?UU1CUUd1MmN1dk1kdmtySkN1SVpDY0ZZK1hhdGN6RDVQaDYzVTFHbHVQY044?=
 =?utf-8?B?em50S1F3V2E3dWN5Szdjc1lxK3drd1N2MUcxZGl4UWZkVExZaUJYbHk1cmFw?=
 =?utf-8?B?blI4RHFJdlNReFNpcVEvellQNG1FQzhiUGlKaTdjRW83Y0VLbm1aWTRmbHRD?=
 =?utf-8?B?NzFqb1phcnEyRWttYU9tK3g4VkZyNVdPeTNjYjJlTnp6aUlRWEwzb2wzakhh?=
 =?utf-8?B?citmcEdKQ0I2VUJqZ0E4bmJWY0s3M1dZWXBtaDJBNTFkdWRqcFZMdDhocU1i?=
 =?utf-8?B?RmU3RTFIOWo1eEhtSi9yQTh5UlM3djhRSkFhbGNla2tzaks3cEVVWFhVYTM1?=
 =?utf-8?B?dGRFcXpaRDZIU2VaMkZwV1BxMHdUdDl2SC9RUElsUmg4VDJjcU45NVdEQnFm?=
 =?utf-8?B?YkxEb2NOeHM1RzRsdE1hSlN4VFExNHE2UXRieXBPdTRzelV2c3BHQWg4OTkz?=
 =?utf-8?B?bHdrWFZCcHg4aEhjbURXNTM4QzgrRVg3VlFVMlI3US9xVDFKdnZZbGg1ZEdm?=
 =?utf-8?B?UlFDenVEM0JTRXlCaWFDZDhSN2NUcG5SRUZkc3FzbEdjbkE2TEwvVmJVWHoz?=
 =?utf-8?B?VU1NY2VFd2MrREZuaGlhcUJXcFhuYVRxWTE3Ym42VCs4MngraGVwUTY0K2hO?=
 =?utf-8?B?MEFuMXNwd3dvOEVkQkR2SnYxTnNmZEp5cjVIbWFESHlXTEFsdXZuK3o5RU16?=
 =?utf-8?B?LzFwV3FXQWJMK0tvK2RHRGxZbUZsVDBMODB6RHc0WEJuZU5Zcm9lb1pyMG5U?=
 =?utf-8?B?OUE3ODVOTGJrZmhsbTQ2STZ0NmRJZjl4OWd1VHNZRnZ6ekx6MDNpZzNraTBC?=
 =?utf-8?B?QmsrNitxMTJ0ZFFZanRBazY1UVU4Qm13cnBWT2dxeVpnRWFza1RmWWRKUVZ5?=
 =?utf-8?B?NXp4NEd4bWxkSkZTS1h3Ym56QnUrbld6WTZmUkVScStRV0NobnR4Q2N2UnlD?=
 =?utf-8?B?aExUSnRtekRrZnlaR2N5MFBiazdWSnl0UkdxMzk5cnlrU3BCV1VITnNwUFlz?=
 =?utf-8?B?TmkwK2hOcmNqN3QxbGRuWFlkbEhhazRTT21acHlZc1Y4amcxL0swSUs5UWIr?=
 =?utf-8?B?cDhUcXdCRjliRVVEbm5Gck8vcVpBc2RWUlhpQkp3aEowanc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:04.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5934fc-cd4f-4901-4b76-08dcff058aa2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0474
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

The phyBOARD-Pollux expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 1240c7fcbd0..910109afd80 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000

-- 
2.43.0

