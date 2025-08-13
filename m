Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C136CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E80835B3;
	Wed, 13 Aug 2025 13:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RMFet5nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E06682ADA; Wed, 13 Aug 2025 13:55:06 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F4478353A
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwhOuYlawdZlWpgzsc/I+5KeG1JfYBQ5sCOOogKY+uNOUaPhcW30/qmWX8iIoz3dUyhI5s9znsqKbOav2SEAxUQJJfGod3UuvdIz62Sdbo9ZBag/KC8+sNdqDp+2KpkTjCjnQt6RhfJfKewNkiUGWGXrDmHpN3K73/cCPvlerr7buZ8CpGpV0af6vEPbuYrTLCxcMLaEHo5ANi+/uNHkWJ+uDHY1GUZe8npE+SCLsqyLQq3hts6M7nYp/q5qSHHp84N9fxFsZEyspnISYDbLP/RfrkjaUpeUzQNMk7Tnz2ul/o9CkgN+Nz7eNxJmgYPvQEAzDGshXrHqL5CUt4c/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqynucCsp+Px3P5zXQKwkE7jMAxnH9xkfTs0Ao5Bi2Q=;
 b=i3S+nlugcHqVKItYMSFJ/mKJJbhxdtK2b+8GMnO6xxdc3Ev904CrG+uNNFAvTjOrgMFsE89oh4dauFnV9FoLR+VXaLCKu7b0CeXhN7K9JCU4N5g5DDBa4UrvecoKNUrMwKk/RYrNBQznzypDP43XYhvI92UFJGpCAwBDNV1kjpgTROv4RDsIhg6LXruGNv1r9B7ZFte1Sc0NGArPyNmxrbfZqJg6i1tknEFrrNxymaR91z9Z2zj6192JMG3w0eErRt/WGCIfDH8OlG1upJfPlhivOgVXUE7HV3C0vC9rZa1PA7oz6YoL1JDKCPnNzRSEkDGoWDqi9P5Da5BIT2A/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqynucCsp+Px3P5zXQKwkE7jMAxnH9xkfTs0Ao5Bi2Q=;
 b=RMFet5nImtMlMMwqkjeWRDPZPEJ6EQNcLf+nS8OV1vmbAvvlkLh98oM4SL6VqMBorQUoqr9tbVsep7J+aiqMIZ8+gz/AT+NS45xyXtAS8LpJo0hLxtKSg/g949JFRP5oDIkWGetxHLzVqH6E0vipjtqNqYBexX+KMV3EUoddjiXmgovoT7tQIMSISlg8u1latlabbXLrNlRs9Dvv+EBBPbNWI48vabnPqwa+k6AdFX2ZKV0wfxqamTVXpltDIoXcfFBbyPvWYhk49waY/1+kqL0FxFDs80d4/T8r3dENyQesnLXT1dOcH4pZuGWLFd88b4mDAytlfaFnRYTVZtc9rQ==
Received: from AM8P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::19)
 by AS8P195MB2437.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:63f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 11:55:00 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::82) by AM8P189CA0014.outlook.office365.com
 (2603:10a6:20b:218::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 11:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:55:00 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
Received: from lws-schwan.phytec.de (172.25.32.54) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 13 Aug 2025 13:54:08 +0200
Subject: [PATCH 4/4] bootstd: rauc: Free private data when booting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-wip-bootmeth-rauc-priv-free-v1-4-1ef928169469@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|AS8P195MB2437:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea96190-443d-42c4-684c-08ddda603b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUo3WmVpZERLZTU3Q056ZERFUEpSWmZaZm1xc2NWNngxR2tIc3pTM3Jaa3lq?=
 =?utf-8?B?Sm45Yk9Xcy9FR1g0aTlsaUd1OTNtNUI4SW9VVHZBZXljWDhvTTZLTGFMWU14?=
 =?utf-8?B?WUx2NHZsWFRNSmZQNGZqRUc2YStpS0M1Z1ExRDM2Vk1Xa3hoYm5TUHhGTk0v?=
 =?utf-8?B?STZGZHprRVRtcGRZbVR6SjdPa0pwK0ovS2pTRFBSbkpQUnNiZXF2YVhLNXZR?=
 =?utf-8?B?Y2NMS2pJZmttU0lWOUlSVjdNSys0TWU5TGl5T3RMZXVwd1piWG1jVVF0dlBt?=
 =?utf-8?B?OE5PU1JyZmN2Q3czYnl3cU1tcTJvaVEwWW02bTh5ak9DWWtKRUUreHhGN1NC?=
 =?utf-8?B?dEVaMnZmTlVpT3BnNnFHM1QyQUFYUjlJYVNMVnprenk5RDFITW56Zm1CNVNE?=
 =?utf-8?B?KzFnODZRU2RxdGdkV0p2WlRzQU9kM3JERWNRMnlVUDVBS1RrMEpwQThMTU04?=
 =?utf-8?B?dHpVdVhsRkhUemhpc2NhMkU0Y0R3VUtWVHUzTWJ4SVcvZ1orN3A5Qm1PQWdK?=
 =?utf-8?B?MVc4K1Qzb2N2eXBmdElNQVJLc2xOQVFXRHA5UTBib285UTV5T2ovNDBsNURx?=
 =?utf-8?B?c1hqN1RXZ1Y5dE11ZHoxL3B6M2V3dWtKcjYxT2hrNEtlTDVTc2FFU2QyeTlx?=
 =?utf-8?B?VmlNMjhJVmJ5NHBid2E5ZEM4Z2ZCWWRSc1pTaFRQUEdyNmZ3Yi90YUVWLzVS?=
 =?utf-8?B?elFPcFY2STI1Z0NTSEZUbERNbmFNa0JjK081Vk9vajZ6OFdxckZyU05PTjNs?=
 =?utf-8?B?eEZhN2JoWHpvV29pVlRVMmJZQVEvMjAzMk1CSzdMTE45TlUrYkxmYVVDVGE3?=
 =?utf-8?B?eitIRGtkOTBKTkREa24ycWltTG90OHlicXNCNk1oTTZ5T1ViR09raVlWSlVN?=
 =?utf-8?B?SjJlTDFvajJZeUNuSEsxaTBZc3JKd09hRVMxU2t4TjVsYlBzSDV6ZU51RkVq?=
 =?utf-8?B?Z0lNMTBSZEdTWU5yWm15c2ZISk5hN0tNbWowdDhQS0h1NTRlTXpaNWVlQzYw?=
 =?utf-8?B?NklRL092bG9XYkVlUEZ5dUxkclZjVnlDWUZjd0c3bUp2VzNYbzN2cERGWjEv?=
 =?utf-8?B?T2xFQXdQOXUveWVtMVNUTTJkVnZROFVFRk10Q0ZBeGpxdCtVcVRLUWNKTXBI?=
 =?utf-8?B?R2V4eGpaeGs3TXl5VmFPb3U5eVNSZVpWN2lUSjFOQ0wreXVXTkFFMWFtRlJK?=
 =?utf-8?B?emY3N3RDTlNuVE9IYzBQdjdGVGNLSUpjVmtNVHZFNHNrUWVvOXltWExCd3Rk?=
 =?utf-8?B?WHpzTm1CK2NSdnZ3bFo3MUZ3Nnp4dmtTQTMvZHhSQU1nQU5meVpGaW1ZVmk4?=
 =?utf-8?B?SEdSYUpOZFdNYkhqRGRsZGMrUXN1SDhUVmNqNXhTNElnQmdJdUo5WEprVGhH?=
 =?utf-8?B?Nk5zYkN1ZFVGMGh6TE1XNHdXYXdzV1JTdUc5QU5pY3BEbzQyTEx4QTUrUFB1?=
 =?utf-8?B?NWlaT0tIOUpuelhGaDlGR3g4NHd6WXJ6L2IxM1dQaXNuU0NRYkhBcldtTXFN?=
 =?utf-8?B?MnF4T25CV2RuNjY3QTZ4OFkyQmNSREJSem1uYmZUSHc0ZWR1bnZveDQrY1hu?=
 =?utf-8?B?SUxiWlNDZnBmZlMvMENtVWVhNkFtWXhnUW5LZ2p0TzB3bEFxaE9CZW9qNFV5?=
 =?utf-8?B?UFhITXBHT2hBanlKK2pRaFVQVVpsZW5JQ21pU2JDa0FCdTYrSTNlaHgybnFz?=
 =?utf-8?B?c0hTYlU2dVZTeXQ4TGp4bFprQ0pVNDI4R1BxTDMxd01TeVVlV2IvVlRLajdw?=
 =?utf-8?B?Z2szQUpVU1huYWdCZ0lleTA2U1Ria1Bkd0dFcVVYdVV2QUoxZlpkU0ozRXla?=
 =?utf-8?B?S0gxTWxPOVRuaHJUcXdmSnZiM0pFdEY5blhNK24vMUFGdHVWOWVqWlQwWDA1?=
 =?utf-8?B?UUZZTVlSclZ0UzBqdldsd0pnM3VEdnZxYXlLS3dQd05BSnV3cHloQW9VQTJp?=
 =?utf-8?B?em00RUFhd0ltWVVIQVNieENTUTUzSlNvdFZxYmlwSmttQXVxZWFxVTgyd1pl?=
 =?utf-8?B?S2kxajNOeEdHNkZUVHlWM3FZaE9SNnhHZ0FhcHRmVXlBTWNZM3JPN2l2OGxa?=
 =?utf-8?Q?Boto6/?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:55:00.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea96190-443d-42c4-684c-08ddda603b58
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2437
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

The private data struct can be freed when loading the boot script, as we
don't need the slot information anymore at this point.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index f781a7fc0b5153b952afc8da38b17d93e073485d..9c082dabd2b0bb37cbddf7eeec050d3a21be0523 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -409,6 +409,8 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("boot", ret);
 
+	distro_rauc_priv_free(priv);
+
 	return 0;
 }
 

-- 
2.50.1

