Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6656CCA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6D0831EA;
	Thu, 28 Aug 2025 08:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hHZie/Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465DD83285; Thu, 28 Aug 2025 08:24:32 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D10831D5
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr7aISvqk/QTE5gRnRWQM1ugUZexQHlfLkovmLC607GU+eT5radc8OuHBF8c01k516MW8Y8hPGSU6QJ8DmxXn1r58A6c+PUX9ns9kGxcE3D7HpLMZg8K4AjDh7lq/YanHi5cc6lr+guKgHYleBDs8wPetpAqdmwnhb7CsybkHj51Eo42vixR3APyKlm9keU5S80d9HqmaVIaVzlNNAOZe3gwsiq7r0SPzKKc26AYZBWd61QOnJFjFjT0uOlu+3pAWpV9GwMh2TJq+SSwrNzYsEBapqAhxzE1UgWJ5nERHpYCQBOLdkoxYim7IefBfl0/DvvgcCogTuvJC10T4Kj5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNaSZmBbruR0iUbCPl+nNeOOhsHFW+AvCUZTmYuCESw=;
 b=FsP+N6ZdofCommLPkgrXboGi4OI94pCEndw6greWJvltARnaJrSShbSYbDO18c63c6ntTD7PDoPmelFv0Txo6QJq4/i5BgIGw5MfzFxcSHz0pntNSgjOPFu/ptPTQMwZl8uCPia25uVMRVIOguG1yjTWTToXsRuuw0V5uWalouoqNA0w/0Tc9xv3nUILvo/FDYJCv4SGSnk9c8FJxK09o3g7VezHy7Wwk659Ut7IJ/0rPLLaBKTcO/SaV7yV1rTTrFvfVMCihZbzQGYfW3oU+onJoaTKmwkVquEsHhL+efR5tSUO6+0d+2DvvXzXlCG24+KdNWtN44jJts8pX3LY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNaSZmBbruR0iUbCPl+nNeOOhsHFW+AvCUZTmYuCESw=;
 b=hHZie/Nf8z0+A1oSKxMTQwjWBP//6xfaGZtkpX2QnZKJrZn7pGunBkMB4sewabwNnhoPExB8Oox3y0cnuJTMtdeTb47eE/P+ZTleVH1BPk4eGCE96feLRDedQz2mVEvqzS3pxS8Cb1u7Mjptx53phTSaNqkV3A3XWEIu4y7+NkelFfKfgfM/1oK/0b1fY4VgQJauhDAC3HAPX7ldxZ5pzgZDbfjPVeIl55lhdwri5BhdhnEsmHMU6R/r4QWJh7BkU1lvDOT9/pFqRwbLV0YtYMyFZWNPo54rjNM7ir1vfGEpCDuDgPrfLFVW5RkarYw5oZNgJeP38f/AfMXrYlslPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5676.namprd03.prod.outlook.com (2603:10b6:806:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Thu, 28 Aug
 2025 06:24:27 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:24:26 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Date: Wed, 27 Aug 2025 23:24:16 -0700
Message-Id: <20250828062418.17945-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 394e58a7-9578-4e80-1ce4-08dde5fb89a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?itNz0Jbk7aK9Tnh/uCmW7z9J2+V9cwktUA1zSS3cMb5FceOqXSgXjl1+HLJj?=
 =?us-ascii?Q?uu5ySd0ZGUoITwgysbjWeZjWo+EZJ+db7MjdZUnYDfL85ynzW4ODYBRK2vgJ?=
 =?us-ascii?Q?GqYXYx+4QAgv3VTzZHSZkEIw0irara9tUnBHL4x5zvGo6zXdpSObsHW9WH8j?=
 =?us-ascii?Q?akkKLH9f+3wH9zI6OxEokj8oSBaXvNwFhz3X7odyukasziyH05u3d6E4w8Sd?=
 =?us-ascii?Q?WxjkcfB8v/nzGa3D2AkzM163df4OcrkbULTut882vwHAXdEyKvQmYoeGLJEk?=
 =?us-ascii?Q?KO8AfMBVTghmVCcvPHZs6hnIk/t1nRzurde3hCMy09XuRQySFayedRMr6zbl?=
 =?us-ascii?Q?84RAr2icFFuK/VvBTsQ1yw9ZU+rBlhqZSQ14ouasqOx07pKlHVV2CUl+qLeb?=
 =?us-ascii?Q?ENT2wdJ8IDIY7vfKZep1lEzb+1jwMtO+mlVbwVGYrzUUqGwX7Nif2nbnwVzd?=
 =?us-ascii?Q?QHCCfyF6R5IB7sYAIOkWmTbAGm7jr6rHGTQBjW+nap4rxIBgKmkDgHXHHVk2?=
 =?us-ascii?Q?wHZE9jJAFBaUjpiSC8vYpuo4I3++lVg4JkFS9LYisWAV9dF7Dm+lz97+VMpz?=
 =?us-ascii?Q?WiVgVfvPU5gYz+Ad7cHH5t7DmrMcdiMF3oW/gdiznaQZZizPMa4W2w6zy/eL?=
 =?us-ascii?Q?aV88STeyLFWEp35dIn7BV2DGxXNL5IrNuXjcdbZV1o6w1IOfdYH1WmM1+J9v?=
 =?us-ascii?Q?3zfAAyr84rRQmDwt957t7wpOqn536m/PAWRPTD3S9yeP3A/RcH0eQIAcCBle?=
 =?us-ascii?Q?cpJksWb8UGz5zAjOPgWvBdrnJiDEi0eeSGGhjDVolnanZKIQLsMCe1b064Aw?=
 =?us-ascii?Q?EFVN+Fvkv68+tulxiVO9OPPJiEpEWkLUBKmwcloqU2KWCqOjAbKaTpMoDwGR?=
 =?us-ascii?Q?c4mt7ZCbWSzdkcBk76+LwIT0qggD95FJqH8K4AsNk3lTFe/u8LP5cHMlm62W?=
 =?us-ascii?Q?kmk1c/pzy44rjHWNhdmHpxt8UenkX/J15u79Cl7gd3dvZUl8NqiOS/Ajgqin?=
 =?us-ascii?Q?bUqUpfHFr5BpLauwFHGpZcXPHK5j6WgjhNCj5ICitrRaut/gxZ0zVLss6wPh?=
 =?us-ascii?Q?7IohAXUoolJ9wbAprcoJ2GPdFITjlQfwaW+IKTKMmsx4m4OwMEWfUpp5BFlX?=
 =?us-ascii?Q?R7kNxtYuv8zXiYDO9TlVgT4JAZtXprccakaGjoQh0/UGHUCW/b/pAa9wovqk?=
 =?us-ascii?Q?FkzvErKjyJNGflTxDyQMxpPbdNR0r61kzJBe5E1yxkMJQZ+1UFKpUh7j6pOl?=
 =?us-ascii?Q?ceMt5YXwYTs68W048kJo4loCcCi3UBefx6fSLkCh+dggSNF2xAeEiv65olOT?=
 =?us-ascii?Q?jastI4ti8i0yJFUB6kSAJFXNfYHtSuXmpsEGvSagYOgQYtTDTvw4JLrdW0se?=
 =?us-ascii?Q?pf5vz6/FIrkAKbffSV5p89/l26XzN/7xxxERxl6iVmETEm2KGHwjXGsgPdoD?=
 =?us-ascii?Q?Qkv+jGGxcYk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfGrN0x0/uCRFY9Qlb2KCwL2hEUzFcjYdibgjlT0MzRtfiOD+OIHlmx/SjIh?=
 =?us-ascii?Q?+J3tZuT/b90G97/jlD1EBjQvWs/ArMoHpHS8y55ebA+lsDixysP4bkXkPBFN?=
 =?us-ascii?Q?kKnD9ZAy6S0Yri83mE4eh51mfy+PSrdOp/t5N3TNAgKrtn55d9bkyi2ZLtca?=
 =?us-ascii?Q?xAO80MJHxq+mMdnf8+Jtl2tZwMjyS9TmastLiGvlxpI/K+KYk6tjGIu3BBf4?=
 =?us-ascii?Q?ycK1H1zvp0/BQ0P+9HEO4ajSfl3XcYYx7zYsijWhsE4daKhpZfaA7sooNv4u?=
 =?us-ascii?Q?MO4lVkFJfFfMdAhsCiK7GcapTg0IUZwOAEyKMTlyLmwpnYDcuQ1fbSTf0APj?=
 =?us-ascii?Q?/XRezORiAgE79pt2mY2Rp3IGLDKScv9LYrMgTdVME0iUHklGWLRrWA4dBYbo?=
 =?us-ascii?Q?yjeSlEv2yba67CB5xh/ljohvGKdbKFsTZe6nbeMNEsBurYDZ8IalbqNvoVQF?=
 =?us-ascii?Q?aqVcM1hlLb3BluYKNbcikOR9vGrvB3ne1akljUpcx/Fo4kI3oxLQK0SRCTqT?=
 =?us-ascii?Q?WAttqItUzd/+NUsnoYeLaCd++lXd74zc4uIRrwrgEgHbMkFVNf0j7+wzDWus?=
 =?us-ascii?Q?VkrZRHMb6NsUOPOgySaX3tQAGS41Br6F/w9Ep8IYfSRLm+d4oqoOz6svBHGf?=
 =?us-ascii?Q?Zva9BFHFXEpaqQwh0DVPpOoNlf8TfCb35vy8HBMXYCVeAKr24RSPzDA3XafO?=
 =?us-ascii?Q?IVAJ9MAjy2MooA0BDIORRx4p94RmqazWeU4KFAT3Cvy8eYp+gAgMwDngeBk/?=
 =?us-ascii?Q?jl1dxGVREq3x6A21jrqWXArLzVmh6GN3JI1D4B9M/w3hAnxqztYAqXVASBbT?=
 =?us-ascii?Q?KVCycMR2tIJIpYPXS/4jLuNYBzXTU/WbfwBuBEHgzGfJGdWuONJE6pmnx2k9?=
 =?us-ascii?Q?lPTjKHphbZKVOmN5kHyGQEl6/gembGxVzoO9nibYKUzkHEk3d9ebN0iRZ0Ku?=
 =?us-ascii?Q?c57j9jg1KtWXLBRzCJfGWo8hCDKbdp7yTx/WAzZgbLPuCUeN6ikPZL1PYwsh?=
 =?us-ascii?Q?I2bk3COVtwnh3j5vpjJOSR2tEIdPmJ+HG4WGVsw0tYBBjtSGyNvFRXHSfYwu?=
 =?us-ascii?Q?ihezuAz/c3MkK7nXHuVu8Bax1NHljDtMBlZvHXLWv3CY+JJk6Y3df3jPxW/i?=
 =?us-ascii?Q?MwbOU4QX6o6oWiw/0Hwtv2m76WOfwr8WNEagH9QnN873H0boTcWR2XoISDKp?=
 =?us-ascii?Q?86lQ7zdYhjlakhPvaT8kSO5a7G6oGwcuGlyu1wTMpQkV1yOJ8ixEP1GwPNLB?=
 =?us-ascii?Q?v+l+AEkoKRgWHdO0nvnDho8v/9fUqoOqydCmhmXdm2zRJdueInV2Q/vmSJin?=
 =?us-ascii?Q?3IMkkICAbMtZfbKihY/mL4ecTShQHrjAlYanIjK4rSU/qRc8Yjm+b3a8QLNJ?=
 =?us-ascii?Q?0Wm23n3r1P6Z6bl13ArRGCleeY7kluIsK8RN0m8zkIF6rlppMeOKa6WIStOJ?=
 =?us-ascii?Q?AKkHAwO2qptq/W/H3v5ZTCGfPiulY5X39TSbk+nYDuFLjWqdi/WDj450Q1o2?=
 =?us-ascii?Q?pzq4GUOAa3TMnJeHJkXWlK1LSntu32crE/PaAz9iOOmkaYnf+iWMO24j7DNZ?=
 =?us-ascii?Q?PnOu3NIQwvcTSRMuy/RnBIbvx182evepGMI/EgOv/a/IS+NMEsrifgGNr7Zz?=
 =?us-ascii?Q?3FCtSyt90J+7qq06oYAqTE8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394e58a7-9578-4e80-1ce4-08dde5fb89a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:24:26.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: natGaFmd3XMXY4ee+YrtQ+FfUIx7D/kq5w9YiwWm5X1fmws39qDKsHPzwfW2l7nlglyT6Bjv/60ORw4/ebecdQ4i/IBoIz+Ph6jC10s+mADBLbmw0A2yNXXyYKtWvHaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5676
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

Required USB DWC3 host driver configurations are enabled
for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index cc812c7008c..859750f02e7 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -98,7 +98,9 @@ CONFIG_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_DWC3=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

