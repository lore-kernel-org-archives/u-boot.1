Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7657FCD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED63849F0;
	Tue, 23 Jun 2026 15:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="q1bA4ByR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q1bA4ByR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A916849F7; Tue, 23 Jun 2026 15:02:55 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8631849ED
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O4CgMdvbbJK3o5yGEsKLud5FYHUwPnWRpogrZJtC7AmJx7yNEjIqSmujPLBBs2AkUsPCortKxWiK/aqKWFV6I0WnPCGcGLPOTHQxIRV3QwgiycwV+jocB4IkEw+r9SaL164ktuRGRDZpwTdNNAv4z4fVnb7PgGwet9r8Q9dw43hUsygYOBmIrj9jlctc/0L9azpKy/eZ3w3SIPmWvKJw/PinihB9Pw9rKsG9KxfOQOeOZWwNQcE9/v2OG7ubKq+/dN+aimXpctQkoptAx61TmgxSy7bUIqMuzJ9ZxY1ob1Gm2tvMigFDFhC8RK7x59DrHxmOs1nWv14GGGurewbaFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsG9Znko/0luWDSMzeSbWZt1ElHw3p2BqNA389DofYc=;
 b=zDE4ZqrmOOfHgJCI7/Y6SQf2BZl1YA7LOfRNdEIcsyrxJLiP1JZ1J01Xo/nqtauR5ETcLMwFUOlLHRayJ8PsZXVMwUq8pNLMBK53P3C+y/picUjlw2CijwImEnmAdUFuVg4NLRidrvEt8cKMjt//aIs9xcyYOAOXBPhEktpJvan0xcKEL3GQOq6NOuXnlsSdRxefbfwfJk2xYlDX/jhWI9TSplgiT/o+alxg8uA/ktPln+NyqU1s+Fu94dKJQvXFAUVEp95vfyMRVuWEGg9H6Oew+W9T0XWXvke2tuItp4Mc6Ax23DH8ENSrX0luulBpGCwlOhPIGFNV1gPLB3cSwQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsG9Znko/0luWDSMzeSbWZt1ElHw3p2BqNA389DofYc=;
 b=q1bA4ByRdNsutW7V98PG10qk82e1UD+l09KxKPyQx7wEURcvlu0n158CBJTrbGA65ocFOFOaHO8AwMPm9lf9AT0pPI2/Vg7Hpgg7VQC93zO9/TFSxaR106Vkdco0bakuMc0s0Pjv2AOXxhxSYWED6UwDvhNEPYzlKK94dtexV1E=
Received: from AM6PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:20b:2e::15)
 by DB9PR08MB8740.eurprd08.prod.outlook.com (2603:10a6:10:3d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 13:02:50 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:2e:cafe::5) by AM6PR05CA0002.outlook.office365.com
 (2603:10a6:20b:2e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 13:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 13:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqttJzRMZsvOU5IdNPlpDMxX0Enzq2Hl4tBaxf3iFNsSXYRHCL7B5eqpdr9tgQEuQMPdH7QvZgDt+librtggdHZoVgTXmC3AwEdhLxXcMyFcEeGOV5QDcjgDvcdw2KFRY+OAS85/6pVx534ccere1gn3+Xr0bYVAj9o74E3fxMTUXT3wTrqO0pzG9OdIB8tbWBooq26/Y6IN4VYRfyfsmiaCO9nK6bLDHpQRarg/32VHF7w7hgHz76TFULc4Wc2r5R8dz+S+zTforFZJngK+XlT6X8HLixJIpRrFSNZqQr5Q8h2pCcA77kofLBRGLAZ+nMvcGAIHucK50mCNw1MtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsG9Znko/0luWDSMzeSbWZt1ElHw3p2BqNA389DofYc=;
 b=b9YaE4dKRz/B6tU6IWfEeDPQkki+hiudcfVb+smJJTnW54NGcdpuaJj5L5m/zeLIsLzkOqnKhCvhgnrGsXEoVkw5CZ/kTLDjJbV+j3D1Y9LECThJxl5ppNX1geNNpsA5idXaE2Vki3jgYDSsJSD9oX25ohnWajV7AQtUI79olNSyF0qPKk8RpoRbOLEhIZbhx7PL86RUAbasyt4R6yNkMvQ5HurK1cHQVXY6gm2S0ieNAjbX6R+TNcpUj5ZBTZErPWRuJHGQt4y+1raSph992eBa6F3kxs39n2Sc7bwhwuqH/JXQU4SllaixGSQ2081+MW0ZqjNjp2mmjLR0iL0kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsG9Znko/0luWDSMzeSbWZt1ElHw3p2BqNA389DofYc=;
 b=q1bA4ByRdNsutW7V98PG10qk82e1UD+l09KxKPyQx7wEURcvlu0n158CBJTrbGA65ocFOFOaHO8AwMPm9lf9AT0pPI2/Vg7Hpgg7VQC93zO9/TFSxaR106Vkdco0bakuMc0s0Pjv2AOXxhxSYWED6UwDvhNEPYzlKK94dtexV1E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB9663.eurprd08.prod.outlook.com
 (2603:10a6:102:2e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Tue, 23 Jun
 2026 13:01:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:01:43 +0000
Message-ID: <77625247-d661-4104-b3c5-61dd0d413d5f@arm.com>
Date: Tue, 23 Jun 2026 15:01:41 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260623
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB9663:EE_|AMS1EPF00000045:EE_|DB9PR08MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fd91ea-2880-4547-284f-08ded127bb17
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original: o0YFTrESbBfYOY6c3QulHmH1rYWOWwvVJQxYH/jB7iyj42tWfGnDXs8sOtGdoEjrGp26PnT41pgaTtTcYPfh4ZJa+JAxb+d2fb1g/dN5A47nJdCYQqYXSfzJjegjbCrLl3RYYru3dXsgSpKBxf0gINYNvyDBUI976FF4BC9tnubLrJH+4hhauxN6pZskW5AFOMCDJdyg3QyJGEjxM1a/631/yIHuqZ1UQBZn5qGHrpX3/v8KrztMPBYWql+r4pB5MYT0MHuOSAKLXTeDXl57KtEBM4b7XaDIIZG3T4nMtfHRRIro3kDmxV7CwvA92CIRCQ8+apmWUUdEIl087FSS89qceYF4c3KhkUAO5DVpZE/AGrKpsC6NHI01+HlDFrkKoD1Mn0OuxI1CDcI0mcZ21hBxFKre1ieM4znlIPwUylGv08N3+QvTqwMRddoXkmvFmutnF4iJT9kBJ/inaSHuhL6zJG3LLXtw6ZIDAVKjP3A+uaWVN6kcBFcLlkRMft0ZbKqUUJ7yrwmwO1nQcu1ouwNVFXl70ni4lhq1qkO0ZhaXAJ9T/mb7aTMBJ3tEQgdIOFWqxczZGFFU3+KbZdg+C5LDrM8IROMoRAD8DWD57dwOdZb0UW32aRBUYoggsNoY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ro+CJjADEXy8DHdpr8dFFXxQGjyHBntQANJuCtN0+lxlQI1/pMRrp9H9vXdO79fphpOzLxjc2ZryEw4zVo9Pn2aKnrayBhB60L8AqtD/RX/dM1UBrGPd4ZvDkmjiSALzsyf+Tw/BOE0vOb4J/1ejtnwrITtO1LTYiOr0f/eoUm/7oEqZXZnpAQ1TAqhqMCkkGYhNkYC2bwB2XFyZt0wpV9cT8o4xPFBLlE/C3Eu0bBtDlQgxdaHmYY+N5Twtk+TYmdDSRc3IhI5709UyQgtHekHXwhX+Xgc1yN2bDevVhZ829/d5mcVgmhIYT3whscC3N+xbTQO9va4raMHS4zLb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9663
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 80c018df-12e8-47b4-bdb6-08ded12792d4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|23010399003|376014|36860700016|1800799024|18002099003|3023799007|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u5DLWxFbMYrI6WJ8XI0oTxrzgTneqBNyT3zEDFB0KBrABHreTI3kNpSnNnQrJthh8SKFvhv3Mfh0xxgzECYpGvjn4m5O0hPNU0NCBiSARmqZs7XrYBiBuJKEDYvC5K0tq8DIwF78LNt1nfhYPNcnfQ7JYSP7tP/57S6mSzJB74UDiHsUXqKoBqa3tPxMHTmZ5diIGnqLAohfuFUUVS89VuNFEq6WPqfSBey4xMk2m36T9Akm3mr9lF3vO3RjY+RdaZUGXVEjDSb7ZXYD38K1zr30i/qbIPJhkJmgb54u+YuctVEcbHzNNauNGa34kNcWgZLfT2FuhmFW+UP3b4WsNbYBxvrgQPaRxhkwjP3Evb4rmLMZNMs8Qarhb20mkquzDFLoBFHHW20cf2ph2VZmu46kQvY4w0fNvp6ma5EfDrjQq+ZbhqFZO2RVAT6SOUvUdB9nybnfNVgPft6pieD2c8WLfqYvyH7z8jxjFXDvzHyJFjA9xNEXsENPBBChjlPPIpIEWwe9dsVwsQhJrs67Ye5tKqREAOpV/+XaNQyYPCmSmdNQ89aH6pag4jgIxmyIk8bWyUYHuSPQDgRgmvfgNJ255D1yjauLjVreci/x+px7+4+hz4cFXduYWioBt1SPi+++0PdThkA7q5c7EAWwug==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(3023799007)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KoCdkHNUO4ZBKhCn0ZpjCwN9YfV+czZOaJOCp5Vc8KQzfb089rq/16WHsvygEGhdY7SJIZmfts6u80Mwo9+3a/hMe4C5Ej/yFTlvcNn90s98HlFaPEQhsxNnLy3bSrbRPPzLi3ZZErP4JG+ZRicETXaIOQ+r8SOfFswRVGsdSViOdF8kQKfRxNNiflnCc0a5Hw7iteiJrC13oC0NYebRX0XCWWHP64P4rQAjOZB3lDqHjCsH2QGyfL4Yid4MlfZKq6evuAcukje203pRCESGbTCUGtQ0qo92YCcFa3hCPRnAnSiKUFZSWE0i3aSXrB7ZpwNKzjrrRJaTr4YsSLmpW0DASY+tmqBQ4OXApb42R887hvXttMoF/Qjyz1gsWoCmN2DQ/rEBcxZO8cFU9LdqZmzf+MysD6roXE6LuvMPLOrWMBkwa9dFFC4LR8a0sY2y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:02:50.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd91ea-2880-4547-284f-08ded127bb17
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8740
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

Hi Tom,

The following changes since commit f072620dc9ffda00b010783da27c41231c3a439b:

  Prepare v2026.07-rc5 (2026-06-22 16:22:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260623

for you to fetch changes up to 91d5e0ee3e857c76bb05f0c69c21f3d4a150a2e6:

  net: cdp: reject CDP TLVs with a length below the 4-byte header (2026-06-23 13:13:16 +0200)

----------------------------------------------------------------
Pull request net-20260623.

net:
- airoha_eth: fix mt7531 mdio related initialization bug

net-legacy:
- cdp: reject CDP TLVs with a length below the 4-byte header
- Clear IP defragmentation state after returning a complete packet

net-lwip:
- Halt ethernet after network commands

----------------------------------------------------------------
David Lechner (3):
      net: lwip: wget: fix error handling in wget_do_request()
      net: lwip: wget: return errno codes from wget_do_request()
      net: lwip: introduce net_lwip_eth_stop() function

Mateusz Furdyna (2):
      net: clear IP defragmentation state after returning a complete packet
      test: net: add IP defragmentation duplicate-fragment regression test

Mikhail Kshevetskiy (1):
      net: airoha_eth: fix mt7531 mdio related initialization bug

Piyush Paliwal (1):
      net: cdp: reject CDP TLVs with a length below the 4-byte header

 cmd/lwip/ping.c          |  19 +++++----
 cmd/lwip/sntp.c          |  10 ++++-
 drivers/net/airoha_eth.c |  78 +++++++++++++++++++++-------------
 include/net-lwip.h       |   1 +
 net/cdp.c                |   8 +++-
 net/lwip/dhcp.c          |  15 +++++--
 net/lwip/dns.c           |   7 +++-
 net/lwip/net-lwip.c      |  16 +++++++
 net/lwip/nfs.c           |   4 ++
 net/lwip/tftp.c          |   4 ++
 net/lwip/wget.c          | 107 +++++++++++++++++++++++++++--------------------
 net/net.c                |   9 ++++
 test/dm/Makefile         |   1 +
 test/dm/net_defrag.c     |  82 ++++++++++++++++++++++++++++++++++++
 14 files changed, 269 insertions(+), 92 deletions(-)
 create mode 100644 test/dm/net_defrag.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/30518

Thanks,
-- 
Jerome
