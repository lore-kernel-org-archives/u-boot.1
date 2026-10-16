Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C877CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 07:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6C6E60AB7;
	Fri, 16 Oct 2026 07:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Klfh7RdeGjqy; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC2966063E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792135652;
	b=XROmIHI/51FstNeRqgvV+NhDF8mMbAXUXQZ7WzTHwDjDDcfma4QRWChr11RcvWrQN4SH
	 xTMmp6UTE/mLetLRGbIqPHqIAMaVBc4aatnJKikpiz8NY9j9EG7Bhabpcqh85DZdNjggI
	 9iUgleOsvA8e/GRnSRofhvbXtRC2m0dKArcmErRt1PgGs5N7PM/zpLbNFlqXVQZQ0PVr8
	 ZHdnQhKpBa1cEuYfkxugSxgUJnD1fok4O9GYTZW7AAq4ZshPUlqPmeoeBpNs8v/yt2lag
	 NzCkSdjf+89pj1pSm6v5VpOtGfxAQAykNgPHjUFEU092mgFlIALwtgM7SnSkL6om0SA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792135652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P3HOkn3NlJdY4ku+nuXdXHpWLdTeqwlUJwWD9h/T5cU=;
	b=PZGU4s1r6w2+9tb420RfZKDUyoD9I+CHjp7TfM9D7RM4Zn0HyzbnN6v78iODNnutLIyi
	 lC4J0HSO1mlU82o4pW7zdWR5Rky7PXdOXUJ9L9aT8/2P8PjiagJ6WLfaT2NCST06Zxc7Q
	 7kYX6nmYGvVnjaE6nM2iEGM7mUIOVVpgON6HEKDMZT7Q33AekZQVXixSf+msArHQn3ZIi
	 cYVgg7EG2KP1e/KUVFEeJh5C3K/Kz75USZ0sub+Qpedd60v/SOEzHaDXZeTI3KUIU9og4
	 wEINfAm511VhdtlBb14TQdwpv2yhIRvWDFr3+NrdtU+ZZjDoTF7BgdvBvECh5lzNWpw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792135652;
	bh=P3HOkn3NlJdY4ku+nuXdXHpWLdTeqwlUJwWD9h/T5cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JG3sMGWs4DWtu/Wp9HUKF+BXT5A/2wglLMLIC58cVRtfRn8/l+w8u131u+MNBuVDs
	 tvavHvSq7CpM8L41NLaukwvlq/EIAkQG0r18rh/96iJJwUoVkCrn95jQTgg1Ku9HsQ
	 0O2WbMOHUDWYRHuuG5mkEQJhXl30CpDAUcbV8JqY7tlxifAbRU0ZNwFXRQi0PEcqZe
	 2vyvPmzxIapUA4BeicXI2rWiP8L7m6AFfhvq/fmLWz2A8H9Z+iB7WaPp6aXw9CUmy7
	 4X64iXEeIA8uW1zYL2pBCp231MgJx52fxcTOs5Vx0fw/zQ6KJ5SoS1wsMy2EfzAoFb
	 HjfDOpcnhVOQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC2966063E;
	Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58EF11DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B1EA4022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vghdZmsm5NM for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 07:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E91940050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792135650;
 b=Abxa2i73ACXjJxbs4AQbCe2KBBsq32KouL10Qwk+1F+qcx2A3U+1EG1LHnW5XJ8m2G/0
 cfd49hpv0pr3Qxe8j12WUw3NTtP3pt1IWgJEWmeKiKTeYfFcDj0ldzf5PvVzKztESaG0f
 RBwveuPEffwZtfz1/FNNzhNFzDtb0XBEZO1vY9P39+/2F1zYZxc02bAzIL83KQ8cMzFCG
 maXQy984RUOwZ/1HZzllREJ/kHlEhJ935tL7YAWMxx9U48yDMwu5S3RtQnTRLppfZaSLy
 +M3DKcVGREGpKC/sR5H5Ecn/nUzPNzE/hbjmFcBxs/+MPHCUYJ7Z39jSAtKmSeAbIaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792135650;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=P3HOkn3NlJdY4ku+nuXdXHpWLdTeqwlUJwWD9h/T5cU=;
 b=QSJDcqdfIf/9jORoBHRv+D9P+nPEmv2TzrUQa8BSIfdR+u5eR2+xQlWOwE8qQPzLP4Nd
 3C/r1LPZtA2l98tNNlpc6FjAXuF8Xk9g6OGluB3Znbj5/e930AUzTabR0V3ngXylnJbxH
 5hRjDva1pfo/Z5Ah7MimJmfAoSSCfGNru+Wj2bzI4PaqJumWbpvWZXFyNysf4cCUBUHKJ
 LfDTYKE6KsGO+RKylrjvVzilE6fyXhL8yJpbfRHmL0R+k/sau2aNsxzxGRQhPHweNgaWs
 F2BzR36ImGXcxNqNzYvcLZP7PXnMMz/H70kb0Xh8ObUeTaVTq7JLDVGdyiCqRGJG61g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=emteria.com;
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=WClf3j9U; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=WClf3j9U
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E91940050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L11cFdwSYcIPJM8qvsm6D1Yd0slPUg3zbniaVYnH/FBtIYOYCxI1BqSiZW5lWOrVdlqj1TW9e78evUESPiVdZvajHRdxpNyN23FBfO9amUT/EUBi9MITIZdlopi5Vy++TY0e/BgPza20idXvNAtoUIEFhQJO/BUgH0yyKBm9h9TyCyy0Ih44p/j/DzKUluBXnYCtny7kKe8Hwk1UAQfSnqtlGUzxSGYrUAXNHYKikY8vKs75jGKfPtswPjQ3FtEZUQXXnUDsxVBhOUBgSR7U2DPA3niuZpMBLfN3oIbVJtvkYewlC063RgtyIvR3VgpJgU5O1QJtbnTcK4Fc5J4CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3HOkn3NlJdY4ku+nuXdXHpWLdTeqwlUJwWD9h/T5cU=;
 b=BHjXJMjTNiyVhlBn2R2V/qqeO1gQl7aA9f8NZm9Yia0scvCtYqItVvJGZjlGe6hwGtoJawpSr9eeXdiNdmY7nb5TvSrRqMULOtcHBov4y6sv8mGBhLycnpYhKni/lv3xY7bgPghUUG8wA7KUvyQB5xetQvdISDBC4svuHullt+62FGypTiQuWboyj7zhGhQLsITLp9t/KL1HYs8uIY2WOkAW0VXUY2s/NcPfH9klfXZOhnRM9qvo9tqUX9vbLOJ0KjGlmapePVMP6dPmMgUlyLfSFhDWaWr3GLJSO02RHZrvBkLgdTr+L4kjOw6kJEfOWAALsjp5wgHWzDW2nkbDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3HOkn3NlJdY4ku+nuXdXHpWLdTeqwlUJwWD9h/T5cU=;
 b=WClf3j9UFAYo2A4XrsCbYO7t1eax/q1ZpaMZ01QYoFhDx+EBx5XNWN+bW9rX6+3u4lRfIEETs1NuKvTECD7lnVyuau67duOqvlBvXqLDJF2IFjWpQpcCM8aeDYKD4sg/9E006W0eDeKXPQNpW4A+TXWbl2/8VaWIqmCfJBQm0ps=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:27:21 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:27:21 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@oss.qualcomm.com,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com,
 Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v3 1/3] avb: Drop the mmc naming from the block IO helpers
Date: Fri, 16 Oct 2026 09:26:37 +0200
Message-ID: <20261016072640.772964-2-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016072640.772964-1-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6ba838-65f6-41dd-d381-08df2b56ea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|6133799003|18002099003|22082099003|10067099003|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: STGCmEeTrn//U7Xo4TQHKm1D1CuG5TGc1QdcavRg06CKJDeh9AOu0BqPrWjdTlG1xO3m1X4sPzXweCmv6Wqdre0icAw+oxXsf+GldsKeNVSWwPe0E+0+Mxa6n94/yvI+NV2ntaXXuEF95O7NoVkxrbNpnQdKjKsj4pOC02Ynutf/qstSm1h086VhKuMqHfXBqspXAQvzNoUTVp57gWGqVIuJZpbBN6KG4DnsIBogwQoFfoIdgPggRrNMv15t4z3JX5A7Wcb0g7s3B+ntJXIIDSAxyfPF74lg/wsqcMjay4JaTa3uePAOi7f3rkMa/zJ7PawEAF1/1jwQbdGokYsrryceQBk4kvmjtWUnDyC5aD5vmRIJiPgxNNiwE695cKXB/RMQ/WMv76edlnv/SPB9QqXqIli4X/lm51S0UYEm6yqcMu9/2gxfA2a/MgIGvta6j86ryDAhICxY/ffEMvMrbTFl0IcK5q8Bfzd+C+8Zx1mbIM4EhMA0Dy5BDTFpIfODtNUurNkz1UXjp4IoqzLSFCavxgosUHt/Tk6afRy2S37/baQ3n0Y6i0tMKJszYw5iojCi1SSv3+PDfk0zOwc+KQPuaDna6wJCSGyCl7lXj5VZZ9Yo7gILJshbFDiYwe4AJN/wKYBGsP+MFrR+rWQ+MX5bIqbAaLwW0ShsWDbXiTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGsN6QHyXkQOCmuYQ6Hx0EJonuP03TDHXf3asjDMp+DKYa5T8/VDKlaSs2MP?=
 =?us-ascii?Q?itrRId7vo+fRcwguf+ALq2YVDKMlVvHOWvzc7I0+xt7qHPwhhmcwnaBtNdKx?=
 =?us-ascii?Q?JIr5G6IjBQgiSwmhcmUF3HhqE3SsUzKDMdpXVUdQZro4B5OEoMbE9t80tVl1?=
 =?us-ascii?Q?pG6PAbtEk4fivHg1rrFqV0AoFkcC+IWzGrHn5FC//ap7L+cCwqCTCverTX8z?=
 =?us-ascii?Q?hdPKNbAyPTmiW1roUr746ZvRMr2+MMT0bEVTgiy+uWF/vv+Ila63fUhn+6sP?=
 =?us-ascii?Q?TSGz7G6NuHblk2vzDBDzcgwxcNvZlEOf7SCOZ85VtTYcDTHIbjh5/E9EnZg2?=
 =?us-ascii?Q?DPpqWM7UeCwNGlcfzRm0djE4+Xu14t1Ps7tHyUk2RGc2FBNCJ6tj+HQFvlzG?=
 =?us-ascii?Q?MLpKYxJkxXhy59LGm+BMtusqtGlAVqEp7I1KR6kYjRPn6QjKkR4jcTuzh/YK?=
 =?us-ascii?Q?BrLYccJ/BBm/JBRpa1YbWYMnqOYJ5YDoNguDYDbFBOxFoz2jrHrorUYabUlK?=
 =?us-ascii?Q?Lpjg5CgH7AEeagzNlrVO0peUo0bPp7FSura0hCD6QGbB+gtd6n0QgHQCf9O0?=
 =?us-ascii?Q?30CdB/s/HbcdHN7S9qh7TTueSMS9MfqnT0UNfqStuNzJ3H38xU6ZC7gMLCQq?=
 =?us-ascii?Q?qlM6a5xYV8dBMxt69pf2B711qSUG4MHM0//n/y5stDQ+gLU6zZsJHllz0mK/?=
 =?us-ascii?Q?YKfU2HnYX8moGs8qcnrNDwUfMFx1RYFqPf8Kswk1C+xGaYQ7RVmb56CK3kIU?=
 =?us-ascii?Q?xcj/vi6X1K1XsOe3zvFG/xy/v4mqfVrUF7Ods3/Duu2PkeQEbrWrss2femOT?=
 =?us-ascii?Q?GG/1u7iMbIiKXMxjI4GEhI3gBV6iYviP8QHgFSnXNPUV84p6qEySSe2QGKim?=
 =?us-ascii?Q?TDnl3mPxoSyTI4zQtyx3aCNYecs81SX9AzkSvuBHxv54JnL9ivGSZmTK5F26?=
 =?us-ascii?Q?W/uH34s4UFSnYFgeZdbshs3uB6NTWIVpMuZIUhKJ1Hyx9v8fnS0Iebw5D80W?=
 =?us-ascii?Q?/e9xJkithe0nlp4x08OHzzo2TInRwZbTKTs9qJNUHMedW1koq5XIg8wT7PWX?=
 =?us-ascii?Q?ts43V0ITgUXUp/DPnwimP7C0MMB6sua8fiE1CMOMvTecc4CxkbjUInWSLOTO?=
 =?us-ascii?Q?cFWm9tpebFKFgAj/aKO9my8PF+ZXyEgVZg2h+K7LNTELPvMPQLayXRNB9jgx?=
 =?us-ascii?Q?L47iMxet8CsmXA4pYUQPHMXGOA4oPLUoPcDylG1Hszp7mKFJBUMfe1QmK86K?=
 =?us-ascii?Q?GFZ3XDTKfSB7fFiwbrhrxeWTdfDJdXfptu7I3eb7le3F9FI6FfmZshsGtFE/?=
 =?us-ascii?Q?4C9IzwAPjsFQpyMgXsjSPdPOBVyQHe/THRljH8k+uoY94lTfVxSWdMagWFQd?=
 =?us-ascii?Q?vSjGyQjJJWWH6y7hCdz9cMKQsi3KDx9Wwej9au/BpCwNjxxGBmSVN2swFvYG?=
 =?us-ascii?Q?iEy4mw6qm+YYvbI9z8p1b12AOBT4kZ+TujXGWcHMaQU+BDZ+Czxi/sLramGi?=
 =?us-ascii?Q?WGguq8J1+k38wpCf0dtZktIPp3/O8fgoip3iYS7gLm0yxx69IsZ/SkYaSVgk?=
 =?us-ascii?Q?AVSsXFDSsaP7MAqTVtLOxauCsjdXHnJPo/JHAZo+DwHsCRCp3aKpJSJl6Cb1?=
 =?us-ascii?Q?/H5scybeYijbbtaD0Q+Lc60vBmAq1Anax7rriJUb2Fpl+5OXDA56XmBcuaQt?=
 =?us-ascii?Q?R/6ch3Of02o760RXf8z/sCl18JW6/QblYXsFsvytVwRZKEw8WgWIzsyBxjvm?=
 =?us-ascii?Q?OI7HECvDk9zAo5uMiHnHUjC42BSsBxabdsryXr2TOUh9QZBl0h0KwGJh4nu2?=
X-MS-Exchange-AntiSpam-MessageData-1: 6m+jqIU08hAg1A==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6ba838-65f6-41dd-d381-08df2b56ea98
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:27:21.3856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7u4G1rY5bqgDUhmvLSEHlimI883AlKjQ3cvTiv0Q+5P+fazuHLMZ99p3jo614WfkQ2r16dpFNJy07ORciVNEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
nothing in them is mmc-specific. The names say otherwise, which makes the
mmc assumption in AVB look wider than it is.

Rename them after what they do, in the AVB namespace rather than the block
layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
The block descriptor field loses its mmc_ prefix for the same reason.

No functional change.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v3:
- Unchanged from v2, with the review tags collected there

 common/avb_verify.c  | 106 +++++++++++++++++++++----------------------
 include/avb_verify.h |  12 ++---
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index b96cd1ebd7..fc29433c3c 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -304,13 +304,13 @@ char *avb_set_enforce_verity(const char *cmdline)
 
 /**
  * ============================================================================
- * IO(mmc) auxiliary functions
+ * Block IO auxiliary functions
  * ============================================================================
  */
-static unsigned long mmc_read_and_flush(struct mmc_part *part,
-					lbaint_t start,
-					lbaint_t sectors,
-					void *buffer)
+static unsigned long avb_blk_read_and_flush(struct avb_blk_part *part,
+					    lbaint_t start,
+					    lbaint_t sectors,
+					    void *buffer)
 {
 	unsigned long blks;
 	void *tmp_buf;
@@ -342,7 +342,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 		tmp_buf = buffer;
 	}
 
-	blks = blk_dread(part->mmc_blk,
+	blks = blk_dread(part->blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
 	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
@@ -353,8 +353,8 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	return blks;
 }
 
-static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
-			       lbaint_t sectors, void *buffer)
+static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
+				   lbaint_t sectors, void *buffer)
 {
 	void *tmp_buf;
 	size_t buf_size;
@@ -382,19 +382,19 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 		tmp_buf = buffer;
 	}
 
-	return blk_dwrite(part->mmc_blk,
+	return blk_dwrite(part->blk,
 			  start, sectors, tmp_buf);
 }
 
-static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
+static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
 {
 	int ret;
 	u8 dev_num;
 	int part_num = 0;
-	struct mmc_part *part;
-	struct blk_desc *mmc_blk;
+	struct avb_blk_part *part;
+	struct blk_desc *blk;
 
-	part = malloc(sizeof(struct mmc_part));
+	part = malloc(sizeof(struct avb_blk_part));
 	if (!part)
 		return NULL;
 
@@ -421,20 +421,20 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
 		}
 	}
 
-	mmc_blk = mmc_get_blk_desc(part->mmc);
-	if (!mmc_blk) {
+	blk = mmc_get_blk_desc(part->mmc);
+	if (!blk) {
 		printf("%s: failed to obtain block descriptor\n", __func__);
 		goto err;
 	}
 
-	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
+	ret = part_get_info_by_name(blk, partition, &part->info);
 	if (ret < 0) {
 		printf("%s: can't find partition '%s'\n", __func__, partition);
 		goto err;
 	}
 
 	part->dev_num = dev_num;
-	part->mmc_blk = mmc_blk;
+	part->blk = blk;
 
 	return part;
 err:
@@ -442,22 +442,22 @@ err:
 	return NULL;
 }
 
-static AvbIOResult mmc_byte_io(AvbOps *ops,
-			       const char *partition,
-			       s64 offset,
-			       size_t num_bytes,
-			       void *buffer,
-			       size_t *out_num_read,
-			       enum mmc_io_type io_type)
+static AvbIOResult avb_blk_byte_io(AvbOps *ops,
+				   const char *partition,
+				   s64 offset,
+				   size_t num_bytes,
+				   void *buffer,
+				   size_t *out_num_read,
+				   enum avb_io_type io_type)
 {
 	ulong ret;
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	u64 start_offset, start_sector, sectors, residue;
 	u8 *tmp_buf;
 	size_t io_cnt = 0;
 	AvbIOResult io_ret = AVB_IO_RESULT_OK;
 
-	if (!partition || !buffer || io_type > IO_WRITE)
+	if (!partition || !buffer || io_type > AVB_IO_WRITE)
 		return AVB_IO_RESULT_ERROR_IO;
 
 	part = get_partition(ops, partition);
@@ -486,11 +486,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				residue = num_bytes;
 			}
 
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -505,10 +505,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				tmp_buf += (start_offset % part->info.blksz);
 				memcpy(buffer, (void *)tmp_buf, residue);
 			} else {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -520,8 +520,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 					start_offset % part->info.blksz,
 					buffer, residue);
 
-				ret = mmc_write(part, part->info.start +
-						start_sector, 1, tmp_buf);
+				ret = avb_blk_write(part, part->info.start +
+						    start_sector, 1, tmp_buf);
 				if (ret != 1) {
 					printf("%s: write error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
@@ -538,16 +538,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 		}
 
 		if (sectors) {
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 sectors, buffer);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     sectors, buffer);
 			} else {
-				ret = mmc_write(part,
-						part->info.start +
-						start_sector,
-						sectors, buffer);
+				ret = avb_blk_write(part,
+						    part->info.start +
+						    start_sector,
+						    sectors, buffer);
 			}
 
 			if (!ret) {
@@ -564,7 +564,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	}
 
 	/* Set counter for read operation */
-	if (io_type == IO_READ && out_num_read)
+	if (io_type == AVB_IO_READ && out_num_read)
 		*out_num_read = io_cnt;
 
 out:
@@ -603,8 +603,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
 				       void *buffer,
 				       size_t *out_num_read)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, buffer, out_num_read, IO_READ);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, buffer, out_num_read, AVB_IO_READ);
 }
 
 /**
@@ -630,8 +630,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
 				      size_t num_bytes,
 				      const void *buffer)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, (void *)buffer, NULL, IO_WRITE);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, (void *)buffer, NULL, AVB_IO_WRITE);
 }
 
 /**
@@ -883,7 +883,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
 						 char *guid_buf,
 						 size_t guid_buf_size)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	size_t uuid_size;
 
 	part = get_partition(ops, partition);
@@ -920,7 +920,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
 					 const char *partition,
 					 u64 *out_size_num_bytes)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 
 	if (!out_size_num_bytes)
 		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 66655aab87..8c97adbfbf 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -32,16 +32,16 @@ struct AvbOpsData {
 #endif
 };
 
-struct mmc_part {
+struct avb_blk_part {
 	int dev_num;
 	struct mmc *mmc;
-	struct blk_desc *mmc_blk;
+	struct blk_desc *blk;
 	struct disk_partition info;
 };
 
-enum mmc_io_type {
-	IO_READ,
-	IO_WRITE
+enum avb_io_type {
+	AVB_IO_READ,
+	AVB_IO_WRITE
 };
 
 AvbOps *avb_ops_alloc(int boot_device);
@@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res);
  * I/O helper inline functions
  * ============================================================================
  */
-static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset)
+static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t offset)
 {
 	u64 part_size = part->info.size * part->info.blksz;
 
-- 
2.43.0

