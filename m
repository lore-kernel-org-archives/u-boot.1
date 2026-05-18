Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC96CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 11:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108C684676;
	Mon, 18 May 2026 13:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S1V5YlDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59BE83EF9; Mon, 18 May 2026 13:54:19 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C4C803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 13:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7JsjLAQcIGCjSKBqmIT8LCxFWMXo0HeStCAuUvgMuW2f/MOCQPB0XFcb75piTVD6mMutaqCf+Cb7mw8ooRcYCaIDhVNnNjgwgWpfn+LeRNPYjEBBm042Nw8Qt5JnPKCRO6T4cGx01ci6D7eLhr4xWpmbjcShXQgnknCqKVH3I/YI6CF3mtcYsIUYPecEhWKB0ZKu6fKcT8fk3Coa8s8LJYOOY6VXvlRfL9Wf5dNF+XgtRkP34JSVzK3Z/zl0wMGdWByj8J/NZrA1Shnu80a5fuVflOtcc1OTlr7r5IdU3jwmPFGT4Iput6A3Ce5i1kueuPtt3STO9MwzW5GkZTRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHmY13hUne7qXM5LkYw3rMBb6D7UmjIXW+bZ02yZ+hs=;
 b=rv0ynzFe9ckQ0eWUcDUkI9PWGEuBRsk7teSJay78aj3okjXzokV5uDVN3WnXaIfpXDhW1Kc+iRGk4xiMFOf2bJETScuJAMOi/stmlyIEtt5RgoSoO9IEostEUtj1WbhlTgvNuE8fFQp99xXLMzYz5zcSV1CAPfyxeiuuprSlMqEVsbTKPtfhmJalSbC1T1g05Nl6bVFxIg2QypnAM2Ys9fZQ2ZMNt7TlNhMO9bkDA2tyJwMQXB78UBYwV30++ZH56+n/KBrlaL4WXL8omMUn2j38oTGzFzR043quKqGCgY1IkroeYsUyzmXVk2imxOg0h8M8SFYorW7OlkjHf7gqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHmY13hUne7qXM5LkYw3rMBb6D7UmjIXW+bZ02yZ+hs=;
 b=S1V5YlDbB6G6CmRVdswonUo8quvoNhpFQrPd2/IF8XknA9f8UNIS1/Ra8hbOaNt5m1x+7M3Irz0QLaYLlYbr7RLIfWon9Rp7Dt3TZvGjlGJue9a1h84YWGe5ZG6vbGBd2/I39oWGrmDdMEJHDYe57ykwkt/tPtzc7Pyd2piXUmc=
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 CH4PR10MB8097.namprd10.prod.outlook.com (2603:10b6:610:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 11:54:12 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::67) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 11:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 11:54:11 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:09 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 06:54:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64IBs7gg1269152;
 Mon, 18 May 2026 06:54:08 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH master v2 0/2] Fix speculative access to firewalled regions
 on AM62 SoCs
Date: Mon, 18 May 2026 17:22:48 +0530
Message-ID: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OWw6CMBBFt0Lm2xpaXuqX+zCEDMMoNRRIWxFD2
 LsFN+DnPbn3zCzg2Gp2cIkWsDxpp4c+BHWIgFrsHyx0EzKoWOVxJpVAk6vqri2/sesqnolHHzY
 BzULFmCQZERb5GYJhtBzwbr+BQefZQvnj7lU/mfym3pqtdn6wn/2NSe79vy5OUkiR1qpIC3mqG
 6Sr10caDJTrun4BIers9N0AAAA=
X-Change-ID: 20260512-am62_firewall_exception_fix-20a335cca769
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105247; l=1786;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=yZMz9RIyuo7hKAD6Qd0VKpkNUE9PS4Iy88raJgSsYpU=;
 b=9IlYlYYHxL2C8sb7s+jOoO+QeuKDupamScO0qZ2ChEHR/VLlf7+o3NLY3SO66RYYS9IjW4iXt
 zKGIZNKh/YKBh32qulqy7qKWqiw0NEsss11ULDmrE1vSAzJ/5ZltMLU
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH4PR10MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d139d3f-a362-4569-6ca0-08deb4d42d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lxq46bGy6AVrM9Fls6uvZobGoS/wCwidxVLnnkQIA2UT7KAHjtBMbPT87DIYtzyeMaCfYUlQLyIgyQbWNq9vulFTBJcN9x4EEsZ4Wskx3og7VrEdfq0WuB3jYWaQtSJZBwPHcyvVcno/Xv46edt+kn+JYxGb8Xam3mAa1EIBt+N/x2eqger/75PtRhVCuYBqYJvMeGaCaYtRMVXcMLLBiz8n7ti9te6qmXgWvczheh+ARQ9jrMBT+2qt2psNwg3RnuJLYP4a0xuXl+wXyZuFcLMxFbOzzn1HPROFG+k+NhEj21Roken5Nhe0+JqUydO6+ImdJHFXZWwLa9zdJWwY08mqmI7V3QkXgb4DVaUefiNRSdALUWWvi+eEHba9/mUnY3N6RfpQbvFx1cMpAD1zYm5Z+8BOYhmLb6x9K0tXvXgMx8k0elFDymnH4vFTIx8+FgSAyToHGKPEv/UHP0NAFJTapNa5zsLL6JzMnkqxtc1AC3UA5NKKU4LPFo7+jxjZ6A+CG1eJetMciSW6PZQVBW54He3uNHzz8sA3HpFgxzO66xPG89cAZlfIHeVye7AAq/v0BspQ16GIkapBijQ2ttJNis7YZOKUfnRkb1FOEm5fR/Ml10Ij8I7EwEUjAlzdLFcwK2ijSlvQ741G/3Szmr7lKzrcIKm8QKB8CSz0m94ET6n/Vd1UH3ZLl9hdF6XH
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zp4+n/p0+BzB+EFOuWCpc2UYHP7X8YVIsc3MEDU3QcHN+TBVOydwA95x6R0FIMjy8VE1/Jr7WCjy6+5vYgv5XGEw84CaIyAvsti6pi0xfqbTk9nUJBU4SxNAGoSUlXdKJHaKEqcNYTPTDIcWbFTyT0OrC/idMcDx/Yu42x3ze1UWujGaIc02kIcAHoyrzaEBWGu9Mafoto6DBV6z2UxGVVA+hC0hw47LZ4mLtBm/5n7Sfr/KcmCkd/POXW0jL/OU0L4rOJkcUXnRSHVtlJNCfVA7YXWnNnjZmbmYw9Bpw6vao0dKrJF6ZjipSPnX7QSSQtupqi8AXzF0+8ILXDVGx/JTVR72QMbJ4cJextVna1VLn0F/FPwzwDNEPPhCyZw4TRSAC5yDuhsUqGq6JBs3IkOzJFtfz1le0cunvb9kLXpFb64gM8iQdPkOHsdKl9pI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:54:11.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d139d3f-a362-4569-6ca0-08deb4d42d14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8097
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

Hi all,

This patch series fixes firewall exceptions observed on AM62 family of
devices due to speculative accesses made by the A53 core to secure DDR
regions.

For testing, I had used an AM62p with the following diff to enable
logging from TIFS:

  --- a/board/ti/am62px/board-cfg.yaml
  +++ b/board/ti/am62px/board-cfg.yaml
  @@ -33,5 +33,5 @@ board-cfg:
           subhdr:
               magic: 0x020C
               size: 8
  -        trace_dst_enables: 0x00
  -        trace_src_enables: 0x00
  +        trace_dst_enables: 0xd
  +        trace_src_enables: 0x3f

Without this patch an exception[1] similar to the following is observed
at A53 SPL stage:

  FWL Bit  0x1
  Exception addr  0x45B08000
  FWL Exception  0x1000100
   0x60000
   0x80002880
   0x0
   0x141201
   0x40

[1]: https://software-dl.ti.com/tisci/esd/latest/6_topic_user_guides/firewall_faq.html#how-do-i-debug-firewall-issues

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Added Reported-by from Suhaas
- Modify ARMv8's mmu_setup instead of overriding it only for mach-k3
- Add mmu_enable to give boards more control over MMU configruation
- Link to v1: https://patch.msgid.link/20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com

---
Anshul Dalal (2):
      arm: armv8: mmu: move mmu enablement out of mmu_setup
      mach-k3: enable mmu after reserved memory is unmapped

 arch/arm/cpu/armv8/cache_v8.c    | 5 ++++-
 arch/arm/include/asm/armv8/mmu.h | 5 +++++
 arch/arm/mach-k3/common.c        | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 13c1e13cc7fb1fa07867f835ccf25913594c71ec
change-id: 20260512-am62_firewall_exception_fix-20a335cca769

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

