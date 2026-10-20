Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A473606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yG92sRSm;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vjppgr0b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08A35407E6;
	Tue, 20 Oct 2026 14:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTD89OWCly5C; Tue, 20 Oct 2026 14:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58D374073F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505426;
	b=M7wwfwflIfzM++3Cbl/umC5ztUy0G55KXA4oCJtaTLF9yWr3vxVzXEOLovwTd6Tg2zQd
	 QxtzmRAtlMj12eq+0LN5qM6nkPL3nygELUux5SrIXGJ7a/WdLbL8Pj0H+QJhenu8zmHq9
	 1RF5mikmM6PAH64k7mPZ9M9fjS7INiu98F3HK6opyQKprWpxBfjx7NTGTswrceLiZDE45
	 qENvtvnHv/RpP2naLmsmsuKiy6z6c1HbEoBvIdwmCXlLGmh5wFH3E6AaN6GLIL9XD9bkW
	 ouSsfsz9NW9YlNOQ7TMdy4+GZFplNJXBDs55jjip8x0PCnxmE2NUcKHrZXBGOHpuBaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UL2XDR//EtIhwhf2fcmRV21GkgRWb9poBSEoTd7KHr4=;
	b=B7iwBxwKMp8fGvRBFiqwVqky/aKBxxcfumz9E43ZlRY553wjJcJJb0zEaNQLMH7/hvcr
	 +V6u+QlpJzdKTziQ8jrYANCV6GFSmU20IhGA3P3qE8tSsC9bEoqIwCcB93a3FORf/U9th
	 GUFStrAe3rBsfQKAHxgpuVkRRF7jrYte5ksmjcZbsy2sdCXuvZ6BA6uP1bQ7fsU9rDyEF
	 j/XmK6Px6v7uhkg0GFs4oKPeNg6Z/3nG9/NmNkdIaqmflwUlJYk0+PbTQkW8HaswLevSZ
	 o9wMmcvssBVjLeTrQ0tTwZuooR6N0TckdGelFb821w7SiMzJbUeRoNfYg0b48kdAzvw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505426;
	bh=UL2XDR//EtIhwhf2fcmRV21GkgRWb9poBSEoTd7KHr4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yG92sRSmQ+8pAh7Bs1PZUGeawQATuAwnWIV0IZbU1o6H6y6dUDgkCxAblaZHCWcTR
	 BdbqZ6ZC0zCd0bBiYhjcw6K+mARYmWJMP9qw4bywkAipkAJy56LDkyUdxM9IdkFG/r
	 e3dUjT63vAtl0CLCJPaccAkO8wrjX82TWYAXhxJzMN8qZ+GKirTrnAlHUb/cXVu21N
	 yHyeW2NhxeJDJWI/ItnaKQedV1SGfDzgK9OX2n0ip/uRXIy8A4VAAQkoPaeUJ/mMOn
	 9trhrVvI9gjk96/I1Nzz8LDe0FXtlAmBwjyA6F3Ph0u/l/LFBbjdZ9X4qVEOaZ52xt
	 s8dViDHNIVpLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58D374073F;
	Tue, 20 Oct 2026 14:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2D5E255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4B6B40359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3loXBGpEDikc for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7E4F4034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505421;
 b=WfRzBGBRe0glrone1hBU5RSnrqdcikSpg1OZo/bLEyTz1U3UKWZPrKd4iViF9O5l/GSC
 iDjwZyob7Bxt28k45DnMHNk6hd3HZzDul+QfPRhhtoNIYQVuu8+hKAkD2kuQNHSbp/wPM
 uQ/iM/SsH/uQRfaga+unDw1HJqfIpLSKli5X6sdLZ1h6r8/Qa5bVE4wA3pi5XD/Ex25LA
 ZbnM0vXDY8YswVRHEvshMhMptIvIig5gcFJ+2bC/dAQvPVJtthw+2cJPr+M/StXbO0Dpu
 MV8hFXotQTm1RiBA0jF/q50H7GrBwHmlbZypetV5LkdVFgxHGw3W1yqciKA3LPbvhFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505421;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=UL2XDR//EtIhwhf2fcmRV21GkgRWb9poBSEoTd7KHr4=;
 b=RkT7aHe6Lioa+HQJSeWkxt1p7ENFZXUA/HZ/VbgQbORnVDNeAKpltg+9o5q/7GyhTifi
 lRT3OcefeZ8RJQl/fhwyTpe3xOwGBX4f1IgKOgnMRBtiBrMpf0suy6BGLFbxFEBrvXJt1
 fwn/5t7c8Uk4xOL+AV7nuG+hkytC6cxUVumuDUgHaIjF21a1GMWTpRg7uVsJOO7I7zcGJ
 IKKRGKoJ/DZXbae3RdGp3yr0j0skjMu33Ge07TGD/TpfPLGCJ/FNyFdrcHKRrqdBZtQYB
 /FbuNKDDdNY1unQVfDWWt5p7o3FLpssexys32BMZMFZR5z5k7DnzOZUOe/6JGDrmxLQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vjppgr0b; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vjppgr0b
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7E4F4034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmp/4fB3zSpMmqsBFfHgJOtPbakASEH1sDwzKXjwHn7x4/F05iSQwEru+PMYnKfT/RdjUHlCxjBq/bk2rf1WydtVO637hPF3yWFQ1ml+elcakdYFoymoeUd2db61ew/rq3RTCwSrps7qzCSgz9sGWfeu5ULAk21mqiBGkf5Lent4ZpTRY+BUeppX28ZrGzkufI2jm2emedOqNTeSaR8bghar9iYNaYqRvBLF5A3ywLKe0JJ3UHvJapXz5wyEMAI1359eY+T1q4bvJO/shrxaFJnkRgR+TmovwDWPxPwakj0omnncjlqlvhKno0g0WWToJy7MhQfS14zkYbcpYy83yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL2XDR//EtIhwhf2fcmRV21GkgRWb9poBSEoTd7KHr4=;
 b=NdU/lszpb5tb5TK58rGF5tuY0YkJXCRw7RrrsdoP3gBV2N6aaDexQE0bx95j3Sb13vaiKLUlVrxgoRu48DEi1VRlh4kYUFdEgQUisWfsBoY05lK8uk0httfH9pVt0RumpicYKnfhKfwBX398LwWCvTtEKLRZISu6Jl1mIJqnXt9aP5ESxBF6ssRJcuI/slK4PiNfrnuO6l3w8gRPQu9e0fFQfO+G0W4u9T8LojrcroG850FvxYlGpSMMUaHr3TbCyRvK8NNE6Eu+3xeNhE8+sGvVaKR8NgTZQWYrhHnXK+mrupQZrN6Zw+O1V3bssxpgWN4vGgl18tv+A20tJIvO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL2XDR//EtIhwhf2fcmRV21GkgRWb9poBSEoTd7KHr4=;
 b=vjppgr0b6QT60NfWWESZ5xon8Z9RyprEZQqB95mufJLImxrkpPtEVdnmLpBuRQpOSVTf/hCD01d8ticrZKtGSWQ6xLyW4ur25vH06LKdJVJ5hJKfKRW7MAggyu1NW6z67LHYJLR5zZbzbCNQwzV4M9Wb0OGoFfc1cHM/QZZybiA=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Tue, 20 Oct 2026 14:10:15 +0000
Received: from DS1PEPF00053452.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:10:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00053452.mail.protection.outlook.com (10.167.23.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:10:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:13 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] xilinx: mbv: Disable SPL raw image support
Date: Tue, 20 Oct 2026 16:09:31 +0200
Message-ID: <d2b858b921c54c54a5aa443eb731c2484afc5936.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=yf3IUVNteJQZwcqnYo7fwBEo+UDnkyMUQLkAl0Z0cNs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL1N4t/h4DKPqe9V7Xj3zO5Y83HLp881bUyfW7Jj+9
 PPGIuF3HztKWRjEOBhkxRRZpjPpOKz5dm2p2PLIfJg5rEwgQxi4OAVgIpZGjAxz5D9U8134xL3b
 YOOSH1oSylla979eaJScu3TG3yyVrzenMjJccHs0NXbGgUvL1Sx2v1vGoTfn9gbNieLL/v9YsGG
 Z93wHJgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053452:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c22009-6bab-429b-9ab6-08df2eb3dd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8cc/ITFlihoKIajd/aBOhlcs2/rxcU7RuaowYZVmrTfSVA34rkJTpOKd/FoAKYjhzkYS44rq+mz0UZy0jday7mQgHn6C096KfKyCkHjRMYJyp69xMMlLTVliDlz52rUqKnBFn0L/SP4n5DjBv1PD7+mvxjcGBFEesXekFDOswKC+y3ZsI8denLSEkTALK8i+xYgKdIZGFvkeb96pH/4gwY/SAuuft6Qdadie64nqJcq8SvWAWbdLRSIrws7h1Jwi3RYzH8MBUa8Z2vxyZKgFTHcXCdjozOpcbohXsgVvXA+ZyQq0obglEc1vyPqQtRdVehh5swlHeIljxUSDGGFnVT3Yd/do8RUbD6FmdHRq9Udouhj8/4SYQ8imJN13MI0TarvZaItwFww2IyBksNOFAmnI0XpOW9womF1GasVePMBQd2ihMgy04a4Y7eyx6FxfCHEnFQDAar8VZ7MW9qrvNQI4hDClLmBjWTAQVn/bEvq19PeXoUbDiakQ/DG9KL61atCX8OvlUUdNwpHDXqThUm5Z9RzpQH6YoerNN197zuBWzn44ewlgXVcFHPvr4oiJk+oHT0ucVUI2wHQys0CBeDbL5sx9vlapccTem9RYbJYIMzAtWIKTbPYbpYVqahrZ7DsyfcAIllTJhrgmpw0SjQ2xWSxwjfW6j3H3Z5huKEK/UOMMOujsKemeczdNR940bVzcQU8MLmdWRPoHid+vHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WPyQvp15A8MTvU4Dh036xblbjiv0wcpAuzCPSquYAY8VmVFioBLvdQT51kiAuK+SVoiaO92FDiGhoUKM6RStuju63Q/vE/UqrSSv7xIb0YEWmCiwl1GbZ/NHGDC0XLzDOi9jcWUupjzFxApbrG4TfefrCEr3si1Ggh7f6/QyPs8SCmd/8wws2J8pXxs9JbSRG6AEoMPlhUhqVKXqSt4jx05xE1CKzWU7CByhq3QM+A5XLOVxYgvUkeUnZvDK9DjHYlJ/6EFlRjmkCf9xjievnjDIUwdpk9cSeI9kKadJC5S+6CvSCK+CbFBXrS5pJGUyvgTk4L8AgcY2J5u5LrW1MdDUnvliBY1dv+y69WL6UNQG47EGAoklhHSuGPy0wwpIsE7Zw+Za4l8vvwCnWhxMM5z0776Y1ExiU8FDXg4fD3rESmQxW0RhIXAxGqLQX3iU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:15.4070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c22009-6bab-429b-9ab6-08df2eb3dd30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053452.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

When there is no valid image in SPI flash, SPL falls back to raw
image mode, copies the flash contents to CONFIG_TEXT_BASE, and
jumps there, causing an illegal instruction exception.

Disable raw image support so that a missing SPI image returns an
error and allows SPL to fall back to the next boot device.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 3543ff345f45..2fa464ae9213 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -37,6 +37,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_SPL_MAX_SIZE=0xf000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
-- 
2.43.0

