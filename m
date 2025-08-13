Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B178CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCC783564;
	Wed, 13 Aug 2025 13:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DwOCSZrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3319E835C9; Wed, 13 Aug 2025 13:55:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B67283564
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oxp8sGwYc5bqFCCaozdC5smSyyj+iVWkaDzdgaHNQwcDkioEtXkyZ5xKj5w1JZyuXc/IV8vJ6IdNqrtvYIopD1zlRTcZY9u1oIyrSeWujqXtn1FS6WdUW506XIpnnH4GH3xGckRP4fWKuSfyjaS4Nbm4mshMNV86Vvabtgy/8EHT0DtUyp7Tf36tvSLBfipTYm4lNPXJaiZUwo+rOBiVor7pXnfwP/twmM1sOryjLkDbzI88UMVJYi0vRmI8vnnfkrcRrZmMN1T7oyEo5CKejNGuSCBVCtL7T+kYLluXIj9B0VHGiDIxh05Fb7xxvsbwbWFKMa1SuUuozVcC6lrzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Q4w5lhTFD3lOYglFRePvqPAZEh+IUUv20bEXjd5I8=;
 b=BfldTm5SbpaDj8dJIOHDHl6KiqV4x1JiAitQHoWc0dCMBKwmhhsMiiaQyl3eTMuZviW0jodnNlufnAtePoZQisd0WFkxuMTXU2kNmpwKwAaJYsdkxut1HmK4yEMKZ8T5vdhTOe/FgXSb/jVypapDDb4fSAr2hlDz/BTQNbOR5AlLW6nrCClrJhZ66fYXRxgNBZxeWY93lwoi3M8HhHnlq8qH5N2zBtJ1/danNnlikhYbF4V/9Y5Nqni7wxjk364rjkpUaiD0AEmX64EalVRe8hgt/gYEvk0b5eeiLrW3WfAjATBqNIdZiO5TVLGwInT3Qrw+1ElhVJC2nPJr8WvywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Q4w5lhTFD3lOYglFRePvqPAZEh+IUUv20bEXjd5I8=;
 b=DwOCSZrZToQdQDc6Uj1b4Bt3+L35n8+BsSDzO/gi64pnQFJVTPusXyXN678EPhwLcWhx8fGZ8P7bfI0cVeqdB36UNpXnUgREjSnXcriBqGN3V0fpwT/FaoAvtqMgJxnBIp3o60n2gEp5M8v5EGLLLyO8AkpydAzka20/F98rKlMQhjYrgoHDjAMxSkXnuKkaVMdt/0AfOvCTo6KfjduGe+eRuBExzzQLXfqU1CgxIaOM+53bDQeWjMPVdbFr/qwkrlh9/AH/TjHOsyasLfGOvHATNjLQMIgpzH8lwVfgOGQaQOY/BtuZhSUCWLGf9meQ51Ok3+DRma1j0zNDwxXW7w==
Received: from AM8P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::10)
 by VI1P195MB0781.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:54:59 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::45) by AM8P189CA0005.outlook.office365.com
 (2603:10a6:20b:218::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 11:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:54:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
Received: from lws-schwan.phytec.de (172.25.32.54) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 13 Aug 2025 13:54:06 +0200
Subject: [PATCH 2/4] bootstd: rauc: Don't null bootflow->bootmeth_priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-wip-bootmeth-rauc-priv-free-v1-2-1ef928169469@phytec.de>
References: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
In-Reply-To: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|VI1P195MB0781:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b6f83f-5742-4163-9430-08ddda603aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnpPOTR1SXo2M3lEK1cwTzdkb2UzSGoydUlCK2dsd0tDOWxGeVBndTkvTEFF?=
 =?utf-8?B?K2t5L1lnQzhFeDhMckVQdW00N3l3MTJiMk1QUzNsUE9NZkRDVkI0djlYL0RL?=
 =?utf-8?B?M1g1ZGk3Z282cFFRMmdsUG5aaXJJbS9Ta3NlK3UxRndLc1IxN3E1aFlTaThs?=
 =?utf-8?B?OU02cHRzbmdLUUFqYU93NDFYSDdOQnBUN2dCUk9Ra2dKMDlvY3VLeWpwTlds?=
 =?utf-8?B?YTAzR2JJWWduV3NzMjgyRVFRdTk5d3FVdExWNlQrVWQ3ck5pcU5Ud2xvVW80?=
 =?utf-8?B?dENKMVkxN2xHWVJubjNsSkFOWmJ3ZkY0bFJJSVdnMXNlZS9uSktubkx1RHE0?=
 =?utf-8?B?aERrQUZqd0pjeVV5TUJLem5POUNTZUdDZ3dYUTNnNGcyeFhGM2lDYUx6K0sv?=
 =?utf-8?B?ejNtSlRTZ0o5dnRoelNzRUlxV2IvMFlSS3pGVENOSFg0MGwzeUY0TmM3aHpM?=
 =?utf-8?B?VkRONW02MmZMZERYSzlqenlBMUh1Z25MSDE0NWZHcjAzWHI5aTRKYjAvNW9l?=
 =?utf-8?B?Nk5iNXFWOHM5bXNqRGlNdS9mZnU1bEQ0TGxJc3BmcGhqNllrVlRsMXBxZVU0?=
 =?utf-8?B?MTQ1VjIybnQ2UmJpVFpBZEdPNmROaUl2OEVrRjg4NVZWQ3ppVGoyelNsUjB5?=
 =?utf-8?B?NnhNYUExdnVtZ2g3UHVLQm83TjVpVHdnWXJ2QlFVTyt0b0ZERXdTVG4yWHhV?=
 =?utf-8?B?UmFmMXNTQzMyYkVBbzAvVU1xMGRra1lhY3B3R3greHlHVm44MnRyK0pOWmgr?=
 =?utf-8?B?WkFBTm8wbzBuU0NoTXJDbnlzelZrVW82bmhnNWpOZGQzb1JNWXBmRlI2Rkds?=
 =?utf-8?B?QXNSSzlWWnFaTDB1QVVwSGpQU0dKMUpudjJ4bG1aOXg2NTEwTnhLdytiNG5D?=
 =?utf-8?B?azdyMUVCc3ZrT3U5Z3IvZmhUVjB1U1BJS0ozd21IYysyL2ZGZkw4d2lSRWtP?=
 =?utf-8?B?U2tHUFhmQkxhNjVQc3RTZXU0Sk1VeFlGdDdGKzVYc1lRdmo4bzF0UXdjNjFV?=
 =?utf-8?B?MENaQkRsN01xa21jWUh0dnNZdzBxTllQRjlxOHNxcjBQdjY4bi9UV2NTTnIz?=
 =?utf-8?B?VVQ5REpjb0lMS3hpT3dBb0wyYm13L3ZkbTZ3ejJCUDIvTkZ1L2g5UW9ORzNF?=
 =?utf-8?B?enlidmgrTmxhYXNUNjZjVENUbTFrQVFKVmZOUTM2L2RjWFJsQWpsMDZHTlll?=
 =?utf-8?B?b0t2dE0zcEZ1ZUZSdmVBNEZzalhCWmJpK2l4THZjZVdqRmR2MVpYT09QeDli?=
 =?utf-8?B?Y0lNQnFSNWlIQ3RWSSs2b1g5WWdwRUVTZDlUdm1sVVMwR1R2M25POENtMUNC?=
 =?utf-8?B?Sy9JWjBKSkppR1NOZFg3OHJIZ2Qyd1JnS0FqMForQzlqUmt2dFhsYnZVK3RO?=
 =?utf-8?B?cWsrQzV0bDlvcTJZRVpmdzBlUWNBWklDeDkzdks4TDJyUU80S1RsUEFuSkFr?=
 =?utf-8?B?RFZta0NUVzhrM3U0Tm9KSENmOEk4bE03WGwvYkx6V2wrT0JtYnJKdTZUZjJV?=
 =?utf-8?B?dGpmMnkvUEowcndOK000Uk9aSFZqeXdFRWN5amxqNzdxMEs4NEJ1Njgwa2tJ?=
 =?utf-8?B?N0FNR0ZqU2x6UC9LaXFYNEw4UUZPUGNDL2ZrbFZ6NFpQMllheDFZeEErOTZi?=
 =?utf-8?B?NllCN3E4Tm51U25wejYzUExPVHRnL3BmZGkzUFVwR3djMzZXN0d6dk0vUFV1?=
 =?utf-8?B?TXgzSzZtdlpWUldPWUlpbG5lcTZoSFpMdUVGYXVwZ1gwTjkrQU9Hd2hMRlZt?=
 =?utf-8?B?cys4aEFJWnFkTU9xbG80UjQ1N3BEb2lIOFlkM201eDIrSDU1aHhROW91UGdK?=
 =?utf-8?B?aWkrcUhZNlVTUnpGbnF3MTF4a3VxUk5ScEw0ZWUvcjBPVjl0dFR3S0xQMWF4?=
 =?utf-8?B?c1RLNW93LzhRZVQ1MmFqd241RS9saTAwK0htN1Vhc1FXbUNQN3R3OHo0cjZw?=
 =?utf-8?B?ZmE2MUVObVU2emZqUTlDRHlMcUQzRWcxZ3Z1ZkJFUmFMaUtPQnRSZEgyNzZS?=
 =?utf-8?B?clRKd0gycjVxU3ZWbFNyaThXandVbERaanExaW9SWUkrYnQvUkxiMSt1U0xh?=
 =?utf-8?Q?qBzWLV?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:54:59.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6f83f-5742-4163-9430-08ddda603aca
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0781
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

Don't null bootflow->bootmeth_priv, as the private struct is freed later
on by the bootflow.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index a27c85c4ff07b88fd67d6a542c622840245dd397..c8efdce75b9134d1c329be40a1eecc57977ffff1 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -193,7 +193,6 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		}
 		free(priv);
 		free(boot_order_copy);
-		bflow->bootmeth_priv = NULL;
 		return ret;
 	}
 

-- 
2.50.1

