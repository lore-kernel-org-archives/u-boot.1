Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D100CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 09:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C08832DD;
	Wed, 13 Aug 2025 11:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YHjpO3nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9BA83323; Wed, 13 Aug 2025 11:44:13 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56328832C8
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 11:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwadiXMdcuZj+HMARaUBiFss74MLQ2GHxpvxR4kP0NixH4Kxi8txeD4c2Mfy8A7Eio4euvQ/3ai2fpqTqf10eGVsABf84te1bJGjPHPJQObhSEkpFAfPGZGvzVRng0Q/E5OjCA7Fl6FwHezl2FTKj0z2fSxgqpQK+zRQ7dQAS8z8qNu9bv8QVVzcOW+7+4jFXZcwohxjKpaSmTz0ucMYf9sEr/l3n1kSol0Wfb4pBaCyO2oXtVnFqAAUG1COnJu9ps5KS7KFF8go5IBn7ZG2OIhqwNpbg6XI3AFUB12f1Mpxfe7SahqprDdHaEPy1OLrEK1fNv+M3OKtWEO6zne7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OweVz8RRyD8lDUieASbl9zdBoConOi6OXrFQrII+Els=;
 b=L4xv//dSd3Bp+eplhDjq2E6sms+sKJb3CyKfyZBMod8nGRd+J+KlsSAs92QrkMCHV9Gp2Dox7r7jBunysimJ8HECFiuSyjfpB8xBHUBMMyMOKZk/yVNQt0wGqqh8XXKXeJkdt9iHDnSaRehH7xZCkhvL+buKNPwtBU3tw6AEoMTeLtWgcbUvR04hR4KP1yIUfbtT6bCFYTIddKgSuCOb+3gjdo0utEroaoV1DXbUWnyXuyipxnoAe3y8quwn1njzWdAbK4TbUfV5LCTaihZTJeBP2ri6Tj4zQG7T54MQO83BCu4M17rI3BEy9vXKmHszmWmXOPDc7EI9gRea9QoaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OweVz8RRyD8lDUieASbl9zdBoConOi6OXrFQrII+Els=;
 b=YHjpO3njFSHPbj7cPBxS0UhFgYQILW10eA5fy6sKr3xlFZb5iYYvzzRaeYKUsHdguj62xwAfTKTlZOmJHoUgGOJm7Ol4hCAB0nzXGt1nxPhuPMr4ihlOoZf82DWJvZi61IhCO/2qjbhfraoR84r0Xk2/gHIylgyw7iSx/bI7P8cRwlqEoA68IfcGqLEDYunnJXaumHcqQrB7zBRQeiOVzYpkdXZkpUoMJpmnR440EQqmRKVjq0oF4PHjWLEBTTd9y/+lCQuVmibB34/giHpFRpFVyKJaJpaGh+ADiJgH+AH6ncOa4o+pU3dj2Iv+mYyf+mZvY8je4YNLpqnI/NNpJA==
Received: from DU2P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::15)
 by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:44:04 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::cf) by DU2P250CA0010.outlook.office365.com
 (2603:10a6:10:231::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:44:03 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] PHYTEC imx8m boards: enable OP-TEE as default
Date: Wed, 13 Aug 2025 11:43:31 +0200
Message-ID: <20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENenGgC/x3M0QpAMBSH8VfRuXZqJiavIhfYH6cYbZJa3t1y+
 bv4vkgBXhCozSJ53BLkcAlFntG0Dm4Bi00mrXSlTKlY9qfZ+TgvgOGGcQNbq5uxVFVRG1AKT49
 Znn/a9e/7AYGF+VpkAAAA
X-Change-ID: 20250730-imx8m-optee-enable-dd28b305167e
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755078243; l=1295;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=NKw4+B/Zye4gTeRbyyf1I80mr7q/pm8euvl3QJGUIjg=;
 b=0Ax3tZ9jdeqqVbCIDNnfYzuTXm9EtecNiqCy0/B89x8+Bkunek5iaQE+VC0VfgQpuRabgMcVD
 Oty7VkC93f2DqBI60eOu9aE0D0XmKgrMwvGvqubWkeOy74QZ4TqQ/2S
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|GV1P195MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b3df5b-813b-4ffb-683d-08ddda4df099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjFUT0NNUnhkU1RYRUZWSURjRVhHcWVya21CY0JyZHZpSHEyRmJmaW5Cb1pD?=
 =?utf-8?B?QWJZdXJTdkh0MHdDcksrNWgrNHFpQTdkeGRwN1E0TFo1UFNuNHlzZWwrYVBD?=
 =?utf-8?B?cHVwV0VnbVB1eFlNRTA2bTFadGxtZHk2eDllMUdPTjcwcmREZGlqbGVLY0lq?=
 =?utf-8?B?K0taL2JHcUQ5cE1TWDZvUmtzVFJuWlNsQjBkWjhibHltYWRaZkhOQVc0OFR0?=
 =?utf-8?B?V0hKaGNGblhseEljZmN1TEw0aDZEcEh4ZEdtaHpYeE9qK2NHdTFyVjhqejUy?=
 =?utf-8?B?U1doZ0IyTGNGSzArS0d3TGxEbDRwYzlBdkpIeXZENzNlRFdiZE1QYk1NL1M1?=
 =?utf-8?B?ZmtraXRKQWVrUXFqRFBBaXpJNFIyWXZSdnJSZ2I3YXRrRGtZWmIzeTR6d0Y1?=
 =?utf-8?B?cXk3QmExVlUxRE5ERnhUclRISmRScmNGOXZEa2JoZ0xwNGxod2NlOHVCTFJ5?=
 =?utf-8?B?VU9kTG1ISkVYTHA4RU8wME1yamhPQ0NUM0o1QWF3U1QvWnJVbnVESjJCbWY4?=
 =?utf-8?B?RFpDK0E5R0w3eldPWVNHMlA5UkhuaWVqWlRUYUIyMkEwU3hFeTBtUGU0aXVa?=
 =?utf-8?B?aUQxbGJpbXliYmJmN1ZXRWtaV0Nzc2xFbHdCWklqZGQvTDV5Mm03N3dvMDkz?=
 =?utf-8?B?SGxiSkxYOHFTZjFXZWxtNzFIem1TSFcyaWdwRStaZHc1VjhCakdNd0RlWXhC?=
 =?utf-8?B?TzBVb1NSeW01eUt6eWFjeExwUkVaSU5TSjRtdk9ZVzlJTlFFdS9mdDN6V0Nk?=
 =?utf-8?B?SFIrYml4VFpwdjluOExFR3lTb0dqaVNGUFVyaFljcEMxcXdNMWlpKy9YSFFt?=
 =?utf-8?B?K2RLb0NORHNQQ1F3WXBVMDFZdS9BbEVNa3llQjdaSUY0MGxoRDJjajVEUk9h?=
 =?utf-8?B?RFRjeENrTnVWYjlWUmdZY0VJTkh6R3FvdXZ2T0RmS1FZUEU3SWxpd0hnd2NC?=
 =?utf-8?B?eTU1bHZKMUE2ekM4RCt1REdsMUZWS0daT1h0bFBnaVphUUl1Tjg0RmNuUDRl?=
 =?utf-8?B?c3JRSTVURXRxcnlDbjZ2c0VsSEo1alh4SUNoQjVqK2ZDaEpCZWxzQmZMV0Rq?=
 =?utf-8?B?c3VpREhYZDhPaWRrMXA2WmRKOG5IeWxWMTVRUkZoUy9FYVRnNXpTanBTbFc3?=
 =?utf-8?B?bk1iUUVIRHdSZHMzUTFTNGJGQkVhUTd6OHFwSUp2d2VhZGNQdGtoTkZNM2dJ?=
 =?utf-8?B?OWlLbWNZTTFCcWlBTy9qVzZReEtpQ0t5eUFCZ2hyVWlHUFBSenBBMkNtcWwr?=
 =?utf-8?B?Q2FEcmF2dFpub2ZOSFhzWWNzOGVPdlhHbzBjdlFSS0N3ZUJyUTdwNE9INWFt?=
 =?utf-8?B?TWhtaXl6cmFmNTZOODBpK0R3aUh4UDAvWVhQRTJ0UFo5aGNQWmUwcUhETWhS?=
 =?utf-8?B?R2Vqa1FJTXFzRWszaHlqK2E4SlBJN09OK2MvVXc2bWRHTjVmMWlmbmY0eEpr?=
 =?utf-8?B?VVl1V1B5aWtnTDBaenZYMkJRazJvVHp0N2wzZGdnWlZtTXVHMEUzRGxCbW9L?=
 =?utf-8?B?UjJWM3BtTHFoOEQ0N3ZGd0RFclk1UUFnYXYxeVpBd1ZGcFpidjRXSE9ZWmMw?=
 =?utf-8?B?eEJQYnNHTDJSWDg0anI1M2pmNEZSWW9ubU9mSU1qdXBBdWxCbXRSNUdLbVEv?=
 =?utf-8?B?WmZJdEg4RVRndlQzYVFVeW1IZXZ6ZXRLMk1oRjZ4dUYwMC9nMGFCNHEwaHhB?=
 =?utf-8?B?UjJiVHJ5ZUJ0UTBjOHlxcG9VYVJtSkJ6ZnFWeCt2Ym1CR0ZKdDN4QVFlZlN5?=
 =?utf-8?B?bGxRZTZuMXpFV01mZWd1QjMxMlJJNjRNZWdmblBETkovQ1VIYVlmb2d5dUox?=
 =?utf-8?B?dElDQitkcldNYkNDTGFpZmloSkkrWDdjc0xCWWFIckpRMWgzZlRDc2NHTTdX?=
 =?utf-8?B?MVlZKzZyTWY0a2hib3dsWitvaldwNGd2ZU5MOXVoTGRwNDNCZFBHT28rWHJC?=
 =?utf-8?B?eU5hZitsdlpEK0pYaUhxcm9la3M1MWdkd1I5WGMvVGZPMTRPYmlibVdWZFBy?=
 =?utf-8?B?eThXbXZMUUlYbWNTVFU5WEx5YWxzNmFHTE8zK2JmZ29iWlZJdXNZM1NZWVBy?=
 =?utf-8?Q?WmEEi0?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:44:03.9704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b3df5b-813b-4ffb-683d-08ddda4df099
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2055
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

OPTEE config was unset by default and the doc for the boards was not
quite accurate as TEE configs must be enabled first in order to be able
to build with OP-TEE support.
This series enables the config by default, i.e. when wanting to build
without OP-TEE now, configs need to be modified.
Update and clean up the documentation:
Change instructions on how to build bootable image with the new OP-TEE
related changes.

---
Yannic Moog (2):
      phytec-imx8m boards: enable OP-TEE for KASLR
      doc: phytec: update imx8m docs for optee builds

 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |  5 +++-
 configs/phycore-imx8mm_defconfig            |  5 +++-
 configs/phycore-imx8mp_defconfig            |  4 +++
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ----------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mm.rst         | 43 +++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mp.rst         | 32 +++++++++++----------
 8 files changed, 86 insertions(+), 60 deletions(-)
---
base-commit: b6e2cfca1a6fd10c8f12016a40d690d2ec61796c
change-id: 20250730-imx8m-optee-enable-dd28b305167e

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

