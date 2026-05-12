Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06ECD4F35
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5436C836AC;
	Tue, 12 May 2026 16:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SCQm6LZh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SCQm6LZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3DD0838BB; Tue, 12 May 2026 16:37:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2682D803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Py9veTDb9nuTC7cY19OjQq4GHKlf/MQdki251Yt3f6jyVjD3KAH6+HVD9Ks976Jnn4k1kut+L+oSzCmu/wG8Cyw/cJOMeIBX+wqSl3MO1jz58IoKchKWGCc9W4pkj1b7gJxBXv121oxMoXCYXQ14/IzMGiPSD/ag4rF9pZcuGY9h219ZY6xgzKwTf3NVRVwkQteKwQ0gi+Q0/JBDJgGQ4DC5AdxNpJQOBdA6XI4I94A3oHZuC3zcWpbm5QoIYCghAGWBqlqvwfd6aiJJ9fix2mLl1nI/hNrL4bd6CeotsDoGwzDxPjs1lXt2GqgCSvW7DTQlo/C6yb5XMAk03/P32Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTE2trD21be3iP4YtC0JnbhsEXEABwKREul6sQWjBts=;
 b=OsnR0QmXTcXi9aet3t5dU/f5f8xtOspJ6ooys8P5fnZqtVBVw93fSw20cMCikGeEzK8FIwO2L04l0v4Cosq36c8Er5uJIRi3ufVxv0At2NtPVweT89qOkhmbl3VFaU1n0lB06lwmo1+/9Yvg02wktb4u8YZnFMjZrdsgZsy4Pd/jEIUET9xkHd4aJI89ENhpB3mzP5ePyGk8/b6uWh5ubRHcYYZIr0N0+pNrdRsZ0cWrfAG9P3I+RlLTiEfKYwFE7C7wBlMCAtRkN71ZiPnx4TuGRsjkjFlmzcmzQLmEZMBMb0NowkZjNtO9s7yUXRJfMk8SCCb9mfoErDfh9ZQPlw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTE2trD21be3iP4YtC0JnbhsEXEABwKREul6sQWjBts=;
 b=SCQm6LZhOjI391rcs7+GpDFRO8j0hH5Nylanq3uGjVImpaogtV3d6TrnNctzfrwovYU2u2KZdJe/bl/fRqZEeDgFpdXJXoOozQZLtdYPoXspuckaFPfocrxOr1HqlDCRHpvQ5cfKKV956AU5B674zGFeHRufJxqOKsZrW6DmX2k=
Received: from DU2PR04CA0338.eurprd04.prod.outlook.com (2603:10a6:10:2b4::8)
 by VE1PR08MB5726.eurprd08.prod.outlook.com (2603:10a6:800:1b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:37:41 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::c2) by DU2PR04CA0338.outlook.office365.com
 (2603:10a6:10:2b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 14:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via
 Frontend Transport; Tue, 12 May 2026 14:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQURiwi0uk7HaNy+EZXyBUBVohlmekMEYfS3xzF7TQeP1P6Myg5udOP09phbyZB5HYh+zPHz9XzZUJjwPtN61tRP0kRduR1sxQm2nJR1WFLGk0OZvPzpd6eNUTt7qG+WlM55yk0/PrF6WnRjmi1z1tvqzycsWvx7l9sRGDgD4VisSokmY6QzEWJU+BK/zfLrzYSMhpNks8/Wg1UAXLgyjTsQBQfjWW1ZPoEJ6I6ejRMU+M3fOTTcwI54d9uz7QL/gra8YHnSx/6faMaDlsE7VdwaSI2iROMh2wZQmGmuxvGU6jcOGOf1aO8ZHv0HNqcKdYtLKgbhz0bMk3HESDqgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTE2trD21be3iP4YtC0JnbhsEXEABwKREul6sQWjBts=;
 b=Em2BepU9FRRILqmMLJu10YfDD+RSTOOl8az54b4xGrBbigQQfQ/4fxAkUoCrmB5KqsNMxabl8xYS/o2Ym4Clv433rpp7WvigZe3inUO3XCevgQPTp/LTNxRaToE+PkrXKY5lRiq+f8jgqH+r1M9aqZxnPwpJV0kCrQU+dkbnbC8x7SS7oIWTZ+98l+/OofVbyeLHUoSHEeC5XZBY/NocRuI6DKct0sHgFsW34lLzq7ygOY0eIr+44kDxWPFWRD1trR3LlDZmygK0KyGGt0EyJLRs7YyLZjmzydxB6FbdTrfk5XP60vhubwhfg3m6T+9tVjmJS30UaOKMAoRW7P/t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTE2trD21be3iP4YtC0JnbhsEXEABwKREul6sQWjBts=;
 b=SCQm6LZhOjI391rcs7+GpDFRO8j0hH5Nylanq3uGjVImpaogtV3d6TrnNctzfrwovYU2u2KZdJe/bl/fRqZEeDgFpdXJXoOozQZLtdYPoXspuckaFPfocrxOr1HqlDCRHpvQ5cfKKV956AU5B674zGFeHRufJxqOKsZrW6DmX2k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB7846.eurprd08.prod.outlook.com
 (2603:10a6:150::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:36:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:36:35 +0000
Message-ID: <15d24b12-a5c1-4d10-905c-c28d8c3fcb23@arm.com>
Date: Tue, 12 May 2026 16:36:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
To: Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
 <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
 <c92efcca-0b81-4b67-a628-0ee93da6862c@baylibre.com>
 <CAFLszTj1y0=N2=PqW75q3-_3E88XLArDUPfVDOH9X_Zky6NQTA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAFLszTj1y0=N2=PqW75q3-_3E88XLArDUPfVDOH9X_Zky6NQTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0695.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB7846:EE_|DU6PEPF00009524:EE_|VE1PR08MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6339c804-6485-4c9d-0519-08deb034056b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: nwvcnedeX19z0Qobl+gfvBYMIZgd/FL4go76tf8ctg3J3rc4pS8ymqSB/hSVyXpKAp9et+dkiJn2/zC1IehIkc4lu7GHrR0Ws3kY20SkI5dcJ1tnAYSeFRP3Bj7dYd7Dj1a1e6JJs9/oUVeKAp9tNXvd+wPX+tqLbUhyrd4Fhd+InXxpMhhEwIhIwj6chpd33bGDrUWIblZW269WkkfNMBzFTYSStGiIBsBQvbfIaB5neJ1OzrN5oWvmH4IvfXM+30magYL7TqJYJvsHbkKHAijPIic+YVC2r0MFLUxpHBVBtQlOynjQbANDn0a2tPC0BWZHpk+8/xBnE5VuAd4a98TuMBidgm6qLKuuEefatIka+dtkgqYSaDVqSCMxN3TYhToM/Cp7nr+tRbqvqr2TTi8kK+5A7Ezeu68h62eLjr4dShhv/UcQWJF9/Cv5U1vjbiCIRzOcmzPglBVBUYnljI2QLcpt2Q79Sys9AP4yoUXXKH9pfVzUNGlWTa0d9qkx8qQRLtZyvYF/IATkQabuNTnsGPM2f/EorgVP3p9Up59fcPps12TzCXvkh4zyQYkGz8sZ7Qaj9SuOfW1+HaUYN8T8UnFrMpfyGgQueZ08vPFo1v5ei5R9Pse59/H9A3XMXqAnACUUM9xOAf/M/tDmTI06r9ZR7bXyqD0v7m4LO4wKKFokGJZU+Up+Ac06j6ow
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Yg+HcpN5oB7RuXnKBkQG8W/8AJX7aSp2vhOw1NVN3xIc8cmNqBTnKEviCd51jW64GjF/ayjrPZPFaF0ydVdMc2QDy/kkQcNkv+IehTfY8jAgCij2BpVZMkjUDuVcfs+GyNf31+0Uxa5u/oibEVgqpRX0TrzrCN1QV65AOlrfbiLO93RP8S+MuQx0Ww+CaaeZ8pa19VAgrq1yTFLDgu91ljarWyUP97N9qEXzmgsFEtgs3qKyWSEEY38rKCNz7qyCtuxSv6ljAO6TlTfFM1gp9q+koxl4pE4NeyOz2tq6lsROxXwz8PZpy5EL5r3gFfWXBz2I6gG+PLG28wRcdU3Paw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7846
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 78a25660-3717-4640-b7fb-08deb033de3e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|14060799003|376014|35042699022|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: fyRwQpk/QDlaysKTVf2nGasPefb2PGl9bKqjfk6IU12zBPoet9rlZ/B2SPsNXrHvQUZDiRk8yY0s2gzD0nklssQnFnZPXmJCqS4D9IByYDhk4N6NGsxv5GZsMoCy3LOvnIzb8OMG4Od/YUplU4hf0+pSN9KhOgaz6FRPBSF87lKujtXLCu3BUD/bHMw+LF6GXv9VKd6+1i2xPV7fUoGmAm05sfYTXoWaLjWZHX9ArsxjlZXOEvpEdDgz/PoFLUkcd/nJhBQzPh8DXzd27iHVmIptdrekNSbXpaw4Kw1bUlBT5+7RZ460+3Sq8P+ZAT/MIzcHLd2eid0wMpiibWxS40ABhJ14DRLDIFSEA9wehyK8/rhDQ+fKAhKOBrOTPXg8YWDfMLqyWEj5d9i8BntMeMwRRYbIkaMT1S9lkAe8UaEWKFXP56uoGWBP+GiRVKiQtACm9P2ok0PR+rxIiAndjAoyE6t8ahDNnBoAkUdO4v+0TdzCeXPlTH4xKa7HCwO4WuNJNuC19HpUSrsnzd+zqfKogPektCQ/+ZevDjv3cyi4ywr4nKuO+7B3TTivM3PSe8t/Zw6qGLxgse7QyVUMH9eWKeAQr5ssq7dBrZL7ZGuo8Ia0B7M+dYOxLCDdks4J3ZBw7SfwCzsnxrMA7fmBNvKgJMOmzWCsjF/ASHEMXFE12w8jRFO9nPQRky8+EvwjGqyKOZVXOKa6qQnnTDC2+Fj9QhqBsbNtdmq9dB5A7NA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(14060799003)(376014)(35042699022)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CddpumWoiZUtCUSuZqfDaDBuoBuNPrK/hDjbe9cdRNXavUe1YsN/+gRE7qdpdNad5TO3mYUkOUlxq+cB6JyceqZi1CAjA8M+RjFEywu3QMpHzR22vv1caZ0TpuJ1+wlmcRkwq+FGUGSIVtjt/rl06JL4K6CLYgCdPKUh7utH9ByD/41x8mG8f3q5UP4McM8qGDtrXaYXVrSNauGpjF/U/wyPK/amQOVzrP5810PmEpfT4MC8KI9c83dKA4tuqz2lcgTcqBicix1CtEsuDqvib2VQ9jjZ8nIXoYGPF3k2qCa7jWOo2f4CM0mlW5iYulCL5WdJzhPpKVgn+R6Hnkw6+qaSJJlQ/gS/9C9bluw4luTd0VuYWgqTiQ8qXRemfAPko2OcIqVzgGU2Oa0XixJM72S5ZsOGs3bp3wiuC1f0eqCt411HkAzNsRIN9++AIRJ1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:37:40.7857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6339c804-6485-4c9d-0519-08deb034056b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5726
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



On 12/05/2026 13:41, Simon Glass wrote:
> Hi David,
> 
> On Mon, 11 May 2026 at 15:48, David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 5/11/26 1:08 PM, Simon Glass wrote:
>>> Hi David,
>>>
>>> On 2026-05-09T17:36:26, David Lechner <dlechner@baylibre.com> wrote:
>>>> net: lwip: introduce net_lwip_eth_stop() function
>>>>
>>>> Add a introduce net_lwip_eth_stop() function and use that to stop the
>>>> network interface after each command that uses the network.
>>>>
>>>> This makes the behavior the same as the legacy net code and avoids
>>>> potential issues with the network interface being left in an active
>>>> state after a command finishes.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>
>>>> cmd/lwip/ping.c     | 10 ++++++++--
>>>>  cmd/lwip/sntp.c     | 10 ++++++++--
>>>>  include/net-lwip.h  |  1 +
>>>>  net/lwip/dhcp.c     | 15 +++++++++++----
>>>>  net/lwip/dns.c      |  6 +++++-
>>>>  net/lwip/net-lwip.c |  6 +++++-
>>>>  net/lwip/nfs.c      |  4 ++++
>>>>  net/lwip/tftp.c     |  4 ++++
>>>>  net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
>>>>  9 files changed, 68 insertions(+), 22 deletions(-)
>>>
>>>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>>>> @@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>>>>       struct udevice *udev;
>>>>       struct netif *netif;
>>>>       struct wget_ctx ctx;
>>>> +     int ret = CMD_RET_USAGE;
>>>>       char *path;
>>>>       bool is_https;
>>>
>>> Initialising ret to CMD_RET_USAGE changes error paths:
>>>
>>>    netif = net_lwip_new_netif(udev);
>>>    if (!netif)
>>>         goto out_stop;          /* ret is still CMD_RET_USAGE */
>>>
>>>    if (!tls_allocator.arg) {
>>>         log_err(...);
>>>         goto out_remove_netif;  /* ret is still CMD_RET_USAGE */
>>>    }
>>>
>>> The fall-through after 'Certificate verification failed' also lands on
>>> out_remove_netif with ret unchanged. These paths previously returned
>>> -1; now they return CMD_RET_USAGE (1), so the command framework prints
>>> usage for a network/TLS failure.
>>
>> The code I am looking at says:
>>
>> enum command_ret_t {
>>         CMD_RET_SUCCESS,        /* 0 = Success */
>>         CMD_RET_FAILURE,        /* 1 = Failure */
>>         CMD_RET_USAGE = -1,     /* Failure, please report 'usage' error */
>> };
>>
>> So I don't think these changed. CMD_RET_USAGE is -1.
>>
>> Happy to init it -1 though as you suggest if the name doesn't make
>> sense here. That is might be why it was -1 before instead of using
>> the macro anyway.
> 
> Ah yes I missed that this is a pre-existing bug. We should return
> usage only when parsing is wrong, not when something fails.

+1
 
> So what you have here is fine and actually makes the bug more obvious
> in the code, which is good.

Yeah :)
 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

>>
>>>
>>> wget_do_request() isn't a command handler either, so CMD_RET_USAGE is
>>> doubly out of place. Please initialise ret to -1 and set ret =
>>> CMD_RET_FAILURE explicitly only in the paths that previously returned
>>> that.
>>>
>>> It might make sense to split this up function (perhaps in a prior
>>> patch) to try to make the error handling easier?
>>>
>> Sure. Is there a common naming pattern for that in U-Boot. I would
>> call the inner function __wget_do_request(). But I know opinions on
>> such things can vary widely. :-)
> 
> If you do take this on, I would say better to rename it, e.g.
> handle_request() - strictly speaking we are supposed to avoid leading
> underscores, since they indicate symbols used by the
> compiler/toolchain, particularly the double underscore. In practice
> you will see use of a leading underscore in the code.
> 
> Separately, I am taking a look at more use of getopt(), which would
> make parsing more regular, but unfortunately adds code size.
> 
> Regards,
> Simon

