Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053DBCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AA084693;
	Tue, 19 May 2026 11:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RPtgOX+P";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RPtgOX+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C197D8469F; Tue, 19 May 2026 11:31:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBE0843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NLDOQOCVtE4sghiKeDVPLdgNOQRx8V6A1GNVoqlUlhmZ6h25O/L83iyJFCaG2JWUPv1RqzHhk8tCgcxaFeWh6oF56RkobUF45ROl2aNMYZiDdXq39CDUUGPmthMRYlECAzUf4YMSLcY5fZnw+w+yMAC/0/xZEvnl8zj24T5NevLAT0dG5+2+8IHr2Giz3EeManXrlvIAF7FiNz6W2Wk3o8Uav37J21RehPUi5FY7auevvVUfrVUb+ijAMWJCBuXikE8nX5+by1PHokTnIVkAcW75a9TKqkSbN4ROR+HTwlKQH/UaVa/6RydSDx5Hwyd2xxVNvAJfWz92FeDwh2tnkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7WGN5HcF58cN+Nvrv9dCy9OmtRgHsZJwmrWEiQaprs=;
 b=ed+mYgyje4Y++h9MSidiUw2GOxTO+S5wMdp4wcKQ+R9Yf+nRrGyvCf8bPjy6SimASvz8eiuMu0wE/FZWDiUDdQVvEx2TG067BltFFOAmasaIj0HycQ/DtR+jw4EygJpj2sM8RyICHVeOlra/4pkR/0GaS33z91YJvjm3UyAE6/2ZqzTtvFSdrFpA39SnCwifOqKEiMte7lIo8oem6M8IhMOJo/uRuRSY+5cTiPXeqRG0ZwEfcO1DLl2COA/np0E1Z7sbds4geEjlHFr+C0rWH/MA0XOjwgItVXDIJcBSJ3m7vi6LD8dHlyr9Imcyr37L/qZY7Glg8JMns2It+T1daw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7WGN5HcF58cN+Nvrv9dCy9OmtRgHsZJwmrWEiQaprs=;
 b=RPtgOX+PShj9EBefsgrjBLdW+8KEM8bxWA6Y9dJwqkOEtj8QhcOMiMbT2owLMnB6Uhvm0R7+Xe+eGhaLKOFuw5k9LtVXvcGlaFzy521Q4Znhk/N4YK3I3FJyk0OGmEiaBBJfSAzUvT8urQmBsuvb4nIRl35xxzMwswXhLL+AH4E=
Received: from DU7P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::31)
 by AS4PR08MB8242.eurprd08.prod.outlook.com (2603:10a6:20b:51e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:31:14 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::b) by DU7P189CA0017.outlook.office365.com
 (2603:10a6:10:552::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNAXdYoYBJaKJHoztWpe0LMn4H/mhT772TzsDvpU0iWH/RUCYqLq0IDbdICwJRBwO0E+vV8fOcwvEfsiNWknajN6uoMndfXER3k9Y2BRWBngJRRmccerQu+y2aA0IeYtiRdduFPQqbzKMyEJ8zlgyjZnuUIjxlQQVrjSQMRscPQP55IVWZQZVx5eFpUe2F44Hwv1laPBWEQg/kPNN9oMlDoj0jxBVPLenVv815xPXx6B2tlxwZ04WLXLpf41u65qYW3jqz96Xi+o61A2p2NDfNOCjAH6WxW3xQPO7of93pi7Gb/nZdwWpx0XeoUy9XDCjbjtKs3lNjYXJgRGvg2M1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7WGN5HcF58cN+Nvrv9dCy9OmtRgHsZJwmrWEiQaprs=;
 b=J7UnL481bAk6U1DuE1swWJC7BifC3ob9aOrVHZj6uZ3nlyZ0z8Lw0zhS1zcLEgUyuqw0QsCk0vdTiwLWVCCeBcjnpIyGxJVldHIuGWAaP68uEidQVEHwGNnSJj3SWvaq04sRR++SM+8ck/ZXWmFla/l6biVkkWlJYQMt5p7exRFjTbLEJqn91j+lZRxlq1lMm/rnowmR7hdepA2GHFgXM7+WISJtHn6pYOZqBSCIq4ubAwAP/ISyqFVvdjHffQ4wkOK4ApQfVLrdqZyMwB7dqR2X4ur/hI0aoV90CkSIF2+98WU70a95RMyKPUdOQGrXyR7FqRR0UiPo1a5BZ3IgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7WGN5HcF58cN+Nvrv9dCy9OmtRgHsZJwmrWEiQaprs=;
 b=RPtgOX+PShj9EBefsgrjBLdW+8KEM8bxWA6Y9dJwqkOEtj8QhcOMiMbT2owLMnB6Uhvm0R7+Xe+eGhaLKOFuw5k9LtVXvcGlaFzy521Q4Znhk/N4YK3I3FJyk0OGmEiaBBJfSAzUvT8urQmBsuvb4nIRl35xxzMwswXhLL+AH4E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB5506.eurprd08.prod.outlook.com
 (2603:10a6:208:17e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:30:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:30:08 +0000
Message-ID: <436fedbc-8b0b-4d63-933e-73e5bc8020de@arm.com>
Date: Tue, 19 May 2026 11:30:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dhcpv6: Prevent out-of-bounds reads while parsing
 options
To: Francois Berder <fberder@outlook.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB28053D6BAD2F0C937D848461DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB28053D6BAD2F0C937D848461DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB5506:EE_|DB1PEPF000509E2:EE_|AS4PR08MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1faf5c-0d89-4ce4-a791-08deb5895eb1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 4G3urg8bkzpycQ/KsBW1KEugbUBpOwI2Fwg2U4Mkp0+Seugd3hOh/oYb7L8zJq1vXy3+Dkqt2JM4wcpiB0xnYhwWXQsqs7dFLFNE6U5h1iIyji78lVRpG3R+sYogtbSNwldpk1ojbP6AXD5nfIn/4joaiGADPMv3HMTCZ3rmFa2bEoniHVGKMtDTEYmI9XgG5i11TcaaS9MI17Jm6Y7noogrPSW8W2q6nM9C84cc2+dJrnv53lDulrTpFZv4VARi9KDtA3kkuTAp2y20wDj4qPTD/BK+xsWFREOcRTlfCce4I11GVAyWInsENBxuw6sw36YUX3NBXmnhfA/tlZbOLJrkpT49XxXhFf46+IJobIHWBrFXyeJJ05sVHKFVtL86/AN1FQkHycso0QiXjoeA6qpvYOyQ9iBp7mugUEMEJ32bks9eDIjJZG24Pos+x0/7DTfv3OCqMwagMohBeui246DJzobNouzSQNYzFk9SARnnYRWad0uBq3njIDqIZRUBGCdyRKwUDpNL/3xp+18KVH3a+UwKCsITH7MuS0HCMgEOxu47x1oHbjhFAwXPloR5U2TfGHQ+HYTOc16pgMEdeUCKis+zaki6X9NTlwUWw3/GGtElCBUiXWMXZSqGBNH1Qv/gJDK30Mb7MiD0sq6YyKZORL1Ex+KwU4D593A7cDjzcj9AHPvg/KBIM+/PiCXM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Oph2k0g3dSRu1c/AHzL66DQLAV8ElLm617pDr1DmV0Fof7jFbWiym/xHE3sEbHdC2UrDFrEdn2fIEcqSSgwVdbe+T3tg4ivrFsEfs+T0jTTJfcqyr2eIHE/Tg2Q9PF0XJGN+OlGzirapc2GsOHszLSY2Ll+b8t1RSATNA9MdpcjDjQ9Ea4Se29VxhUnjRS3HG33Sos7k8xLwh0Qi4dxF1W20BBYdvvDcx0OHaG5U3DEiimKYZMkIp7jcKOPEA03ZbYcJTWDmmFzb9cYcMnPOyqjwY7aSKFiXtw19q7f2OIh5LoPnaG11wHFuxoF3PzwaGhjxN1Z+ADbBuocG5Vr3ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5506
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: abdf1d6b-aa83-4ff3-0e74-08deb58937ca
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|32650700020|36860700016|82310400026|376014|35042699022|1800799024|14060799003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OcTAoUs+1d1k2loHCzhEAZ2RZwDKj2xHQDepZsFYqQjhYfrpAtcW+V/jKxyNVuOQh/iwRMrDvyV8RPXvV9iPqgNKLdepefCJcXJcW8o9AVHcAh+U5E0c5q6VS1T94g5XQNTYzIxkJKlewOyQVAIe+37Qu0SuNZeFm0BDQ2WVpdHG1aByCwHSei9fp1coxYpIGn3Bjorq4S8cYBUUhvHQZyvpEmfC51bHIIMDVkh061zsdJcrCdtixh3Uod2zBx4AWKrT0nbULJ+7Aw+dP2rnIfC2Lu4mHsAPyz27ttx5cYau1zPyGxCT17NJZ/XrE5EAn0g5OSf3wunwod5EZAIIHcECzdop2I7gVH3VDk1ITUiW/P+r0OcEB1XfpZuxwdnJ/wbzqT02GzgkIQxWJlQ1axatfqehr9ok5V40fTKbNI+cY5+gddTM5YiYIQfIX/o0nkj1rMzOr4g1v35T3TqiaIX/9x3y2Povrq+iA24xq3t4eIO/tXOabnaSzQQS5T0Y51A59LqvGtWZrn0Xrsloo1LBNY6QsDqDAJ//I9ZPyYP8bp31GUgsyqjI38raFEV34pAk2EYZPFJSzrV6XJq0C0e+XzmjSS+Km7jJanV50NTWug9A0AbTfbjwCkeVtkWjX9j+dMWb1e2vwFyP2dnuElvTHqcBm+ptsIhE1wICfpViUSxgaJ4whAlIs2S2reg+pXYtuptfkjfaAOJxF4AI5j5Debi1eUbMarH2MNZvVBU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(32650700020)(36860700016)(82310400026)(376014)(35042699022)(1800799024)(14060799003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EuyJOwBugtaf3Ecm+zPX47dOTEGH4foVqEnCgdqkXiEhT/Xd6b0l9Hjr8K/Y3VGSDqcxLYbIIuR2cKXkpAMfGIRzJgN/5ureB1Zsn0QJ+NT47e91jbhHtcxKMnpyVGeDBSYAstVqZlup62m03YwrG95sfD9dzMU6KFXUhV9uEZunbQR70pGN4E8RULXBZm3wxwxyo2xdx0Mrx+AzFipnqOoVbLJXtmmsXmJX9SDUWbFGkesQSJLbWcL7iBHNmCfiXc+yAAmJ5982y2G7CNH0phnebD7bWD7HqWqjLcg5c0allSEgUUqRmQ4oAk/JspWVnatCfVqvs4DOE5WWiPGkWrux3/AcyurfpsWTqzvZqiONMqmwp3Zq4yBHtL6bNVeaPfgsVkWlzkSRjo57rSNhYa6RLwd1RCNT3AxzuDMjE8YX4rOKTuvLOTDSZLFIwZB3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:31:13.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1faf5c-0d89-4ce4-a791-08deb5895eb1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8242
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

On 15/05/2026 18:53, Francois Berder wrote:
> dhcp6_parse_options() verifies that an option's declared data fits
> within the packet, but does not check that option_len is large
> enough for the fixed-size read each case performs. A malicious
> DHCP server can send an ADVERTISE with a zero-length IA_NA,
> STATUS_CODE, SOL_MAX_RT, or BOOTFILE_PARAM option, causing the
> parser to read 2-4 bytes past the option's declared data.
> 
> Check option_len value before each dereference of option_ptr.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  net/dhcpv6.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 51f44979f8e..640f089a2e1 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -339,6 +339,11 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			break;
>  		case DHCP6_OPTION_IA_TA:
>  		case DHCP6_OPTION_IA_NA:
> +			if (option_len < sizeof(u32)) {
> +				debug("Invalid IA_NA/IA_TA option length\n");
> +				break;
> +			}
> +
>  			/* check the IA_ID */
>  			if (*((u32 *)option_ptr) !=  htonl(sm_params.ia_id)) {
>  				debug("IA_ID mismatch 0x%08x 0x%08x\n",
> @@ -347,6 +352,10 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			}
>  
>  			if (ntohs(option_hdr->option_id) == DHCP6_OPTION_IA_NA) {
> +				if (option_len < 3 * sizeof(u32)) {
> +					debug("Invalid IA_NA option length\n");
> +					break;
> +				}
>  				/* skip past IA_ID/T1/T2 */
>  				option_ptr += 3 * sizeof(u32);
>  			} else if (ntohs(option_hdr->option_id) == DHCP6_OPTION_IA_TA) {
> @@ -358,12 +367,20 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			break;
>  		case DHCP6_OPTION_STATUS_CODE:
>  			debug("DHCP6_OPTION_STATUS_CODE FOUND\n");
> +			if (option_len < sizeof(u16)) {
> +				debug("Invalid status code option length\n");
> +				break;
> +			}
>  			sm_params.rx_status.status_code = ntohs(*((u16 *)option_ptr));
>  			debug("DHCP6 top-level status code %d\n", sm_params.rx_status.status_code);
>  			debug("DHCP6 status message: %.*s\n", len, option_ptr + 2);
>  			break;
>  		case DHCP6_OPTION_SOL_MAX_RT:
>  			debug("DHCP6_OPTION_SOL_MAX_RT FOUND\n");
> +			if (option_len != sizeof(u32)) {
> +				debug("Invalid SOL_MAX_RT option length\n");
> +				break;
> +			}
>  			sol_max_rt_sec = ntohl(*((u32 *)option_ptr));
>  
>  			/* A DHCP client MUST ignore any SOL_MAX_RT option values that are less
> @@ -394,6 +411,12 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  		case DHCP6_OPTION_OPT_BOOTFILE_PARAM:
>  			if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION)) {
>  				debug("DHCP6_OPTION_OPT_BOOTFILE_PARAM FOUND\n");
> +
> +				if (option_len < sizeof(u16)) {
> +					debug("Invalid BOOTFILE_PARAM option length\n");
> +					break;
> +				}
> +
>  				/* if CONFIG_DHCP6_PXE_DHCP_OPTION is set the PXE config file path
>  				 * is contained in the first OPT_BOOTFILE_PARAM argument
>  				 */
> @@ -419,6 +442,10 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			break;
>  		case DHCP6_OPTION_PREFERENCE:
>  			debug("DHCP6_OPTION_PREFERENCE FOUND\n");
> +			if (option_len != 1) {
> +				debug("Invalid preference option length\n");
> +				break;
> +			}
>  			sm_params.rx_status.preference = *option_ptr;
>  			break;
>  		default:

Ackeded-by: Jerome Forissier <jerome.forissier@arm.com>

...and added to the net queue. Thanks!

-- 
Jerome
