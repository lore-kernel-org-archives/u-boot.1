Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6720CC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 12:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2533848EB;
	Tue,  7 Jul 2026 14:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kk5EssYC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kk5EssYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9549D84942; Tue,  7 Jul 2026 14:24:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A177084852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gnFVqHykUScFiqAd26yI8QKoXBAN4Gn3/L99leK5q9U+wr2FdI2Euix3U+LZIqbzWjR8tzqb4XkYfiaZAbERwMEVgvZp72TbtbeQYaBHuWgPKRublCn3OcJu0r2xibnwmwTf9xLZNjpVzAxu/vagbN/qFmruW2YE93WvC+lgCb20XGCIxbpbsAbv++xCAmATML9Y2KTZx6ZKWGzbPAPbrc6ZRBZKjr2mMRtXpTdhmb4RbwMK346klv8cPwEFIydG6rUXNQyje1HdonFuVArpo6pgWTKtNgNroPhuhh1aNK7WFSa7fPRuZmE/DUkE1EOoHLX3KlvXSKJp+It/8qw8ig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzPieVnGwksphIXztaoh/4knJtYWV/SUX7cSTWiTeYk=;
 b=UYRC4SA/u4HEzLz6v1ER37GtFThf7fyT7PMh4Pye6UYtRQg/fM+6+Fte6d7I0oKNpe5XxK8jU+uOE6zCoeBaNyRuNQkpfIiQjA8Jy6BKE1UtLk9x2EW5BjP1T5/LNftKv2kOtMRPiNiyTqqaICDEt/sitWSlPoN4wpQSyaW1FtEQpcL8SzdRH7t8pAtjWOky4ajeuGIcSP1/ThBWSG+7tAQLF2+BCIFqYTOLOZh4gieTxWo3ajwUQJwnwM7e+r+1hsVcAn7AX4TZOH9lyjPdx2KxUitbGqtP0cAbYmfr8aG3/6VMgHeI9MX9/b6Jiv3hHLGJ8YM4rFkqgwFey3N00g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzPieVnGwksphIXztaoh/4knJtYWV/SUX7cSTWiTeYk=;
 b=kk5EssYCcHscUFZCl60t0rRx9KEpjYA5u374qgq6HvmQC0nLrLA4p6T3EVrd7LJhAkuczNYo0yneL3knADI2jNOgqrWY+w6mti3fQZTzDuYCXl+8sBq2HyPHmvaeS56o8W6FQc9aCI+brSwS6Ifn0wt8t2RwPP9KOYbjl2Y5w+Y=
Received: from DB9PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:10:1d9::12)
 by DB5PR08MB10113.eurprd08.prod.outlook.com (2603:10a6:10:4a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 12:24:38 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::2c) by DB9PR02CA0007.outlook.office365.com
 (2603:10a6:10:1d9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 12:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via
 Frontend Transport; Tue, 7 Jul 2026 12:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmjoOUEoPiSgSiSf/pPXDQK3AEIwJMut00+58rWm+owCGRYg4es8eBtwAMJynS+dNrwadMgZyA4jtGYlM4QM7MCw54i4Cw3uh6ZRO23cEAK/bs/vZSKLbs2+D80jPppRhtib0zquSexngrbBLdmXSoh6QYdYWprHJHiuppiRJqOX3Igy5ERzPy18/wYhgHTaOmiCwGhrHuMr7MxzGNJ4FNeTtGzEtOPNr4xYPRQkuls40Gt4Mnfmp4YiWJuxZJdkgkoRm53HkeTs0Cp8edTBmds/YtEmy3xYo/h1PcLgWvnnDAxR7yHjgejCa9jt1NY8FHbfPdDrj2uTdHJvuJZi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzPieVnGwksphIXztaoh/4knJtYWV/SUX7cSTWiTeYk=;
 b=pJmYIZfU9FSit4DxFzDhtjvvmh7xuYaBGK4C2C8aArnne6tiiX00Tv72MZJwLWkWFqMvwFNqW+kxuAA9j4WXlWPcVAOiezzCD7j70vPLpBTVhAQAQrIlmkx2eZg3P6u6rYBatW7KmFD/UjAbau5I3Qgu0Wq+KsaPN4TF94RefKVAHx+OGq55loCj7UMbeUNbe+725AJAjBdE4cItx1eg7J28OhPp83MP1sssssiFkOMEtB1FFwm+SD4ToVUQ2uPm9Yv2bEkSMkVV0k+Jqj4dad5Ldlms65vy2p17nSLy0surumAQqPxg3DTDOZJdoPChEvFBhmSRNTJdihtEU760YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzPieVnGwksphIXztaoh/4knJtYWV/SUX7cSTWiTeYk=;
 b=kk5EssYCcHscUFZCl60t0rRx9KEpjYA5u374qgq6HvmQC0nLrLA4p6T3EVrd7LJhAkuczNYo0yneL3knADI2jNOgqrWY+w6mti3fQZTzDuYCXl+8sBq2HyPHmvaeS56o8W6FQc9aCI+brSwS6Ifn0wt8t2RwPP9KOYbjl2Y5w+Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB9347.eurprd08.prod.outlook.com
 (2603:10a6:10:41f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 12:23:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 12:23:33 +0000
Message-ID: <c38da27e-2555-40d7-884d-ebf8437ca698@arm.com>
Date: Tue, 7 Jul 2026 14:23:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: lwip: add tftpsrv command
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Harvey <tharvey@gateworks.com>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20260626232714.2975647-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260626232714.2975647-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB9347:EE_|DU6PEPF0000952A:EE_|DB5PR08MB10113:EE_
X-MS-Office365-Filtering-Correlation-Id: d45c84e4-7fa9-45a0-309a-08dedc22b66d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|366016|376014|56012099006|11063799006|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info-Original: /+6SlbjQ9Yuxpwx0RabRrup4vYyrqFQEqUYAu5knc4jqyv5uYfi5vRM4lncuggaNKMae2101jTUg/eeu91A/h6h1H7A1sIdTbPTvEbqr/RHF5FgvmarjeSMUF4KoEN/lx/60nqZRk6YZWZEN6NLNzCX6+LSONx/fTjjHIeMp0vypjsagQ0Nz5cYIkQFt+9zkZfSgd6/fp+gkDYzOu0AEqPQFjlEIH4V/sLqFIn114bCXapohVxWjgew/nYhW3jYomzvkdRW6hBoXo+vawNbnipV8f3EXjTcQYLdaczXw3ZxYOkrCiUYSiKCOOaVKN5no7R6++z95WMyXigXTeoIED+1k6g5Mss7hJqjuu5LEqD0DdcCmwt32IFym97emoCAeqRgFNwTEitare59JRD2BAPwkAhOAyKqZaleVGNCuQNRlTOaS+aRACemUlXn9/5GUZ1gtkpK+v6PqC/YBxKL2jDOiBDdaSIJIrscvylIzpEpXYcLYWeLpKGgbLwWItpt9byIuLVbowXrNdVt7ZBndTgjJn9W2acy8wQQu121lpIFguHCBSMGK8le8rCScNe9jh+l0pzVvaqGHqn0ypA8h16ztNis4RqbaqcVBiSdKIf3/RCnIz9CWCrvdrdOSGU1w
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RMk8hQov4TZWNt5u9G8VpfLtYIYm6qlZyELY1r9GdRM5DNW9anNpkHTfV9Jtp5CiHelQH6JBWa0uBiQbBnCpKx12j/CkNf8SQo0AKrfiHHKyxOeq7m2WZ4/1kxso3yRnLoxe3G6etLKkOgtFDT6rmobMBOCWEAuC4EO8zyNtQiORUi77m433GNsvBJ82hKYpnygtBmyw0CcuQccnMwGXnUXQYIzclHoQbyYmVgUfcqWQJVsH5wpM5YSsZdvnA3i5qLC0dxV4I6mUlRjMvhUNgHkgPj9fxiGChNKrtt3esF1eORNNKxfsqgcEqp4BL9arPbPG2qh7C+Kz1dFloz47fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9347
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c3ad918-d648-4b10-7e23-08dedc228fe4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|376014|7416014|23010399003|82310400026|36860700016|14060799003|13003099007|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3lynDB2SlKhYTW85JOBWI66Vmh+jy+irH6hLdhVo1eP/MHtr0cr59mSP8ybKElIa276BpXNCJz18vRdTVq9gBW5ZNCLo8Kdy17SUTlEnC/3uNDoXPHsSV+KnCubpS1K+aztlvdmtUCnzTLkiqXE+eIgfnppTFo41g2cEgmwTF8uwQss9WnAU2b+cyBEip5wYbIprkJTnAEuK0wvbrDtdV26US0ZHd9ggF/QVkftA/DUAcbE7+9mN1YAdhdYxYYrGym3lY12JALxiLcB5DH2XQ5zWJfxRKN1guVfIgyTop74v7whTWJEJXu8NP22y9/UINFu7tESbhCVL8aioUjQxAF/+DwYnYtZQxNeaY7rclyfNJTERc65BwVcENLqWMVSk7fS7BgLomv69cjYsDbqkLKDxzN8AQK3ia7lsl2Xz2UTTU3z4nwXLailbPkQFlRFjt6f8/O/d2yz5ycWbYQ8PfP/SKks6tLgDYYws64gBM+kkQ8KjbOo/fnqb3YXb24M+cEgeT7H3jJ5lu2ZjG2HAlrF+4iQ6LlqMwFOm6TdMLsCjwOhIQZ5tLcq3e/GLoOWchsCFkevMb2JNl4lnAiKVMOT1YjCs08NnAF9LhTSvDwfmG7FUD/hQOlm8Df/yHdZZ8wZhseVRxJx3aHih8+Hn7JXPWtjgmNTOpVhv/BBAmrM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(376014)(7416014)(23010399003)(82310400026)(36860700016)(14060799003)(13003099007)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XIsMDViUpPgOUu7ijlwZGw211jk+Gjwr220Hn2GFznnN8KA314w1AzD2UMdGroXTwlgE0Rz5/bAQzylLVOZzyqobecwzUA6tLN/Z7hksF9iazUzBvoGzjTGdLuUd6QeuE30diPpWcSSspTtdazh6bpaXvwxM6QBis9bjhPzWkeCWVVFyp8nUtmS25o0oSstMWOlVNZ59JtYrOSoB72Aioakx8ZlUVe3u/0MU36s+8kRsanKJgbaqsmDe612Wlp7tWT59IciycbRGxvQ2zyxejq4BK/AR+GqT4b8VwciO02xz+avjvF3URybS6DsMbHwIV3DuY/KF9qbroRppeKo+1cLN3fex9nAI5VutUfY8h4fAKPDZSYfhLCbLVfd+8NAshta3jt67Isn49RHgHkCnLEhIPESrJg4go7f7byfY1/ijOdtXD/P6arNOk0vrbDd8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:24:37.9704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c84e4-7fa9-45a0-309a-08dedc22b66d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10113
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

Hi James,

On 27/06/2026 01:27, James Hilliard wrote:
> The legacy network stack supports tftpsrv, which listens for an
> incoming TFTP write request and receives the first file into memory.
> Despite the old command help wording, the command returns after
> receiving the file and does not boot it automatically.
> 
> The lwIP stack already builds the lwIP TFTP application, but only wires
> it up for client-side tftpboot. Add a lwIP tftpsrv command and
> implement the server path with tftp_init_server(). Reuse the existing
> lwIP TFTP write callback and memory copy path so LMB checks, progress
> output, filesize/fileaddr updates and EFI bootdev handling stay
> consistent with tftpboot.
> 
> Track receive timeout and write-failure state around the lwIP callbacks
> so a stalled or rejected receive is not reported as a successful close.
> 
> Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
> enabled with either network stack. Update the command help text and add
> usage documentation for the receive-only behavior.
> 
> Add pytest coverage for tftpsrv using a generated host file and curl's
> TFTP upload support. Enable the command in qemu_arm64_lwip_defconfig so
> the test can be run with the existing lwIP QEMU build when the boardenv
> provides env__net_tftpsrv_file.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Add tftpsrv usage documentation  (suggested by Quentin Schulz)
>   - Add tftpsrv pytest coverage  (suggested by Quentin Schulz)
>   - Enable CMD_TFTPSRV in qemu_arm64_lwip_defconfig
>   - Allow tftpsrv pytest coverage to use an explicit upload URL
>   - Keep tftpsrv pytest coverage gated by env__net_tftpsrv_file
>   - Clarify that tftpsrv returns after receiving instead of booting
>   - Update legacy and lwIP command help text for receive-only behavior
> ---
>  cmd/Kconfig                       |  14 ++-
>  cmd/lwip/Makefile                 |   1 +
>  cmd/lwip/tftpsrv.c                |  11 ++
>  cmd/net.c                         |   4 +-
>  configs/qemu_arm64_lwip_defconfig |   1 +
>  doc/usage/cmd/tftpsrv.rst         |  73 ++++++++++++
>  include/net-lwip.h                |   1 +
>  net/lwip/tftp.c                   | 181 +++++++++++++++++++++++++++++-
>  test/py/tests/test_net.py         |  94 ++++++++++++++++
>  9 files changed, 367 insertions(+), 13 deletions(-)
>  create mode 100644 cmd/lwip/tftpsrv.c
>  create mode 100644 doc/usage/cmd/tftpsrv.rst
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a19..303acf8aa31 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2127,12 +2127,6 @@ config CMD_TFTPPUT
>  	help
>  	  TFTP put command, for uploading files to a server
>  
> -config CMD_TFTPSRV
> -	bool "tftpsrv"
> -	depends on CMD_TFTPBOOT
> -	help
> -	  Act as a TFTP server and boot the first received file
> -
>  config NET_TFTP_VARS
>  	bool "Control TFTP timeout and count through environment"
>  	depends on CMD_TFTPBOOT
> @@ -2279,6 +2273,14 @@ config CMD_TFTPBOOT
>  	help
>  	  tftpboot - load file via network using TFTP protocol
>  
> +config CMD_TFTPSRV
> +	bool "tftpsrv"
> +	depends on CMD_TFTPBOOT
> +	help
> +	  Act as a TFTP server and receive the first incoming file into
> +	  memory. The command returns successfully after the transfer so
> +	  boot scripts can boot the received image from the load address.
> +
>  config CMD_WGET
>  	bool "wget"
>  	default y if SANDBOX || ARCH_QEMU
> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
> index 90df1f5511c..245683a9672 100644
> --- a/cmd/lwip/Makefile
> +++ b/cmd/lwip/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_SNTP) += sntp.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
> new file mode 100644
> index 00000000000..6370c900489
> --- /dev/null
> +++ b/cmd/lwip/tftpsrv.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <command.h>
> +#include <net.h>
> +
> +U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
> +	   "act as a TFTP server and receive the first file",
> +	   "[loadAddress]\n"
> +	   "Listen for an incoming TFTP transfer and receive a file into memory.\n"
> +	   "The transfer is aborted if a transfer has not been started after\n"
> +	   "about 50 seconds or if Ctrl-C is pressed.");
> diff --git a/cmd/net.c b/cmd/net.c
> index f6f556f36ae..0f0b2386d87 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -89,9 +89,9 @@ static int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc,
>  
>  U_BOOT_CMD(
>  	tftpsrv,	2,	1,	do_tftpsrv,
> -	"act as a TFTP server and boot the first received file",
> +	"act as a TFTP server and receive the first file",
>  	"[loadAddress]\n"
> -	"Listen for an incoming TFTP transfer, receive a file and boot it.\n"
> +	"Listen for an incoming TFTP transfer and receive a file into memory.\n"
>  	"The transfer is aborted if a transfer has not been started after\n"
>  	"about 50 seconds or if Ctrl-C is pressed."
>  );
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index a974970c3d3..06ed5a131db 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
> +CONFIG_CMD_TFTPSRV=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_WGET_HTTPS=y
> diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
> new file mode 100644
> index 00000000000..597a2f3a8bd
> --- /dev/null
> +++ b/doc/usage/cmd/tftpsrv.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +.. index::
> +   single: tftpsrv (command)
> +
> +tftpsrv command
> +===============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    tftpsrv [loadAddress]
> +
> +Description
> +-----------
> +
> +The tftpsrv command listens for an incoming TFTP write request and receives
> +the first transferred file into memory.
> +
> +loadAddress
> +    memory address where the received file is stored. If not provided, the
> +    address is taken from the *loadaddr* environment variable or the default
> +    image load address.
> +
> +After a successful transfer, the *fileaddr* and *filesize* environment
> +variables describe the received file. The command returns successfully after
> +the transfer has completed. It does not boot the file automatically; boot
> +scripts can use commands such as bootm, booti or bootefi to boot from the
> +load address.
> +
> +The transfer is aborted if no transfer has started after about 50 seconds or
> +if Ctrl-C is pressed.
> +
> +Example
> +-------
> +
> +In the example the following steps are executed:
> +
> +* setup the board network address
> +* receive a FIT image from a host
> +* boot the received FIT image
> +
> +::
> +
> +    => setenv autoload no
> +    => dhcp
> +    BOOTP broadcast 1
> +    DHCP client bound to address 192.168.1.40 (7 ms)
> +    => tftpsrv $loadaddr
> +    Using ethernet@1c30000 device
> +    Listening for TFTP transfer on 192.168.1.40
> +    Load address: 0x42000000
> +    Loading: #################################################################
> +             6.5 MiB/s
> +    done
> +    Bytes transferred = 1048576 (100000 hex)
> +    => bootm $fileaddr
> +
> +On the host, send the file to the board while U-Boot is listening:
> +
> +::
> +
> +    $ curl --upload-file image.fit tftp://192.168.1.40/image.fit
> +
> +Configuration
> +-------------
> +
> +The command is only available if CONFIG_CMD_TFTPSRV=y.
> +
> +The command is supported by both the legacy network stack and the lwIP network
> +stack.
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 20cb0992cce..571d8941ff0 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -52,6 +52,7 @@ bool wget_validate_uri(char *uri);
>  
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>  
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 7f3b28b8507..af25aabc973 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -11,6 +11,7 @@
>  #include <linux/delay.h>
>  #include <linux/kconfig.h>
>  #include <lwip/apps/tftp_client.h>
> +#include <lwip/apps/tftp_server.h>
>  #include <lwip/timeouts.h>
>  #include <mapmem.h>
>  #include <net.h>
> @@ -19,6 +20,8 @@
>  #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
>  /* Max time to wait for first data packet from server */
>  #define NO_RSP_TIMEOUT_MS 10000
> +/* Max time to wait for an incoming TFTP write request */
> +#define NO_WRQ_TIMEOUT_MS (TFTP_TIMEOUT_MSECS * TFTP_MAX_RETRIES)

I don't think it makes much sense to express NO_WRQ_TIMEOUT_MS in
terms of TFTP_TIMEOUT_MSECS and TFTP_MAX_RETRIES, does it?
I suggest:

#define TFTPSRV_LISTEN_TIMEOUT_MS 50000

We could also make this configurable via Kconfig and even add
an environment variable but that may be going a bit too far.
>  enum done_state {
>  	NOT_DONE = 0,
> @@ -34,8 +37,27 @@ struct tftp_ctx {
>  	ulong hash_count;
>  	ulong start_time;
>  	enum done_state done;
> +	bool is_server;
> +	bool wrq_accepted;
> +	char fname[TFTP_MAX_FILENAME_LEN + 1];
>  };
>  
> +static struct tftp_ctx *tftpsrv_active_ctx;

Could we get rid of this global and allocate the context
dynamically instead?

The rest looks fine to me.

Thanks,
-- 
Jerome

> +
> +static void transfer_timeout(void *arg)
> +{
> +	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
> +
> +	printf("Timeout!\n");
> +	ctx->done = FAILURE;
> +}
> +
> +static void restart_transfer_timeout(struct tftp_ctx *ctx)
> +{
> +	sys_untimeout(transfer_timeout, ctx);
> +	sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
> +}
> +
>  /**
>   * store_block() - copy received data
>   *
> @@ -71,7 +93,7 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  	ctx->size += len;
>  	ctx->block_count++;
>  
> -	tftp_tsize = tftp_client_get_tsize();
> +	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
>  	if (tftp_tsize) {
>  		pos = clamp(ctx->size, 0UL, tftp_tsize);
>  
> @@ -92,7 +114,20 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  
>  static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
>  {
> -	return NULL;
> +	struct tftp_ctx *ctx = tftpsrv_active_ctx;
> +
> +	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV) || !ctx || !is_write)
> +		return NULL;
> +
> +	ctx->wrq_accepted = true;
> +	ctx->start_time = get_timer(0);
> +	snprintf(ctx->fname, sizeof(ctx->fname), "%s", fname);
> +	restart_transfer_timeout(ctx);
> +
> +	printf("\nReceiving '%s' mode '%s'\n", fname, mode);
> +	puts("Loading: ");
> +
> +	return ctx;
>  }
>  
>  static void tftp_close(void *handle)
> @@ -101,13 +136,15 @@ static void tftp_close(void *handle)
>  	ulong tftp_tsize;
>  	ulong elapsed;
>  
> +	sys_untimeout(transfer_timeout, ctx);
> +
>  	if (ctx->done == FAILURE || ctx->done == ABORTED) {
>  		/* Closing after an error or Ctrl-C */
>  		return;
>  	}
>  	ctx->done = SUCCESS;
>  
> -	tftp_tsize = tftp_client_get_tsize();
> +	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
>  	if (tftp_tsize) {
>  		/* Print hash marks for the last packet received */
>  		while (ctx->hash_count < 49) {
> @@ -142,9 +179,14 @@ static int tftp_write(void *handle, struct pbuf *p)
>  	struct tftp_ctx *ctx = handle;
>  	struct pbuf *q;
>  
> -	for (q = p; q; q = q->next)
> -		if (store_block(ctx, q->payload, q->len) < 0)
> +	for (q = p; q; q = q->next) {
> +		if (store_block(ctx, q->payload, q->len) < 0) {
> +			ctx->done = FAILURE;
>  			return -1;
> +		}
> +	}
> +
> +	restart_transfer_timeout(ctx);
>  
>  	return 0;
>  }
> @@ -204,6 +246,9 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	ctx.block_count = 0;
>  	ctx.hash_count = 0;
>  	ctx.daddr = addr;
> +	ctx.is_server = false;
> +	ctx.wrq_accepted = false;
> +	ctx.fname[0] = '\0';
>  
>  	printf("Using %s device\n", udev->name);
>  	printf("TFTP from server %s; our IP address is %s\n",
> @@ -258,6 +303,132 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	return -1;
>  }
>  
> +static void no_request(void *arg)
> +{
> +	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
> +
> +	if (ctx->wrq_accepted)
> +		return;
> +
> +	printf("Timeout!\n");
> +	ctx->done = FAILURE;
> +}
> +
> +static int tftpsrv_loop(struct udevice *udev, ulong addr)
> +{
> +	struct netif *netif;
> +	struct tftp_ctx ctx;
> +	const char *ipaddr;
> +	err_t err;
> +
> +	if (addr == 0)
> +		return -1;
> +
> +	ipaddr = env_get("ipaddr");
> +	if (!ipaddr || !*ipaddr) {
> +		log_err("error: ipaddr has to be set\n");
> +		return -1;
> +	}
> +
> +	netif = net_lwip_new_netif(udev);
> +	if (!netif)
> +		return -1;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.done = NOT_DONE;
> +	ctx.daddr = addr;
> +	ctx.is_server = true;
> +
> +	printf("Using %s device\n", udev->name);
> +	printf("Listening for TFTP transfer on %s\n", ipaddr);
> +	printf("Load address: 0x%lx\n", ctx.daddr);
> +
> +	tftpsrv_active_ctx = &ctx;
> +	err = tftp_init_server(&tftp_context);
> +	if (err != ERR_OK) {
> +		log_err("tftp_init_server err: %d\n", err);
> +		tftpsrv_active_ctx = NULL;
> +		net_lwip_remove_netif(netif);
> +		return -1;
> +	}
> +
> +	ctx.start_time = get_timer(0);
> +	sys_timeout(NO_WRQ_TIMEOUT_MS, no_request, &ctx);
> +	while (!ctx.done) {
> +		net_lwip_rx(udev, netif);
> +		if (ctrlc()) {
> +			printf("\nAbort\n");
> +			ctx.done = ABORTED;
> +			break;
> +		}
> +	}
> +	sys_untimeout(no_request, (void *)&ctx);
> +
> +	tftp_cleanup();
> +	tftpsrv_active_ctx = NULL;
> +	net_lwip_remove_netif(netif);
> +
> +	if (ctx.done == SUCCESS) {
> +		if (env_set_hex("fileaddr", addr)) {
> +			log_err("fileaddr not updated\n");
> +			return -1;
> +		}
> +		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
> +				ctx.size);
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	int ret = CMD_RET_SUCCESS;
> +	char *end;
> +	ulong laddr;
> +	ulong addr;
> +
> +	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV))
> +		return CMD_RET_FAILURE;
> +
> +	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
> +
> +	switch (argc) {
> +	case 1:
> +		break;
> +	case 2:
> +		addr = hextoul(argv[1], &end);
> +		if (end == argv[1] || *end) {
> +			ret = CMD_RET_USAGE;
> +			goto out;
> +		}
> +		laddr = addr;
> +		break;
> +	default:
> +		ret = CMD_RET_USAGE;
> +		goto out;
> +	}
> +
> +	if (!laddr) {
> +		log_err("error: no load address\n");
> +		ret = CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	if (net_lwip_eth_start() < 0) {
> +		ret = CMD_RET_FAILURE;
> +		goto out;
> +	}

Missing call to net_lwip_eth_stop()?

> +
> +	if (tftpsrv_loop(eth_get_dev(), laddr) < 0)
> +		ret = CMD_RET_FAILURE;
> +	else
> +		image_load_addr = laddr;
> +
> +out:
> +	return ret;
> +}
> +
>  int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	int ret = CMD_RET_SUCCESS;
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index 27cdd73fd49..a2007c2fd3a 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -59,6 +59,19 @@ For example:
>          'fnu': 'ubtest-upload.bin',
>      }
>  
> +    # Details regarding a file that may be written to U-Boot using the tftpsrv
> +    # command. This variable may be omitted or set to None if tftpsrv testing
> +    # is not possible or desired. The test uses host-side curl TFTP support to
> +    # upload a generated file to U-Boot. The optional tftpsrv_url entry may be
> +    # used when the host must use a forwarded address instead of U-Boot's
> +    # ipaddr value.
> +    env__net_tftpsrv_file = {
> +        'fn': 'ubtest-tftpsrv.bin',
> +        'addr': 0x10000000,
> +        'size': 4096,
> +        'timeout': 50000,
> +    }
> +
>      # Details regarding a file that may be read from a NFS server. This variable
>      # may be omitted or set to None if NFS testing is not possible or desired.
>      env__net_nfs_readable_file = {
> @@ -89,6 +102,8 @@ import utils
>  import uuid
>  import datetime
>  import re
> +import tempfile
> +import zlib
>  
>  net_set_up = False
>  net6_set_up = False
> @@ -460,3 +475,82 @@ def test_net_tftpput(ubman):
>  
>      output = ubman.run_command("crc32 $fileaddr $filesize")
>      assert expected_tftpb_crc in output
> +
> +
> +@pytest.mark.buildconfigspec("cmd_crc32")
> +@pytest.mark.buildconfigspec("cmd_tftpsrv")
> +@pytest.mark.requiredtool("curl")
> +def test_net_tftpsrv(ubman):
> +    """Test the tftpsrv command.
> +
> +    A file is generated on the host, uploaded to U-Boot using TFTP and then
> +    validated in U-Boot using its size and CRC32.
> +
> +    The details of the file to upload are provided by the boardenv_* file;
> +    see the comment at the beginning of this file.
> +    """
> +
> +    if not net_set_up:
> +        pytest.skip("Network not initialized")
> +
> +    f = ubman.config.env.get("env__net_tftpsrv_file", None)
> +    if not f:
> +        pytest.skip("No tftpsrv file to write")
> +
> +    curl_version = utils.run_and_log(ubman, ["curl", "--version"])
> +    if "tftp" not in curl_version.split():
> +        pytest.skip("curl does not support TFTP")
> +
> +    addr = f.get("addr", None)
> +    if not addr:
> +        addr = utils.find_ram_base(ubman)
> +
> +    timeout = f.get("timeout", ubman.p.timeout)
> +    timeout_secs = max(1, (timeout + 999) // 1000)
> +    size = f.get("size", 4096)
> +    fn = f.get("fn", "ubtest-tftpsrv.bin")
> +    url = f.get("tftpsrv_url", None)
> +    data = bytes([i % 251 for i in range(size)])
> +    crc = "%08x" % (zlib.crc32(data) & 0xffffffff)
> +
> +    ip = ubman.run_command("echo $ipaddr").strip()
> +    if not ip:
> +        pytest.skip("No U-Boot IP address")
> +    if not url:
> +        url = "tftp://%s/%s" % (ip, fn)
> +
> +    with tempfile.NamedTemporaryFile() as tmp:
> +        tmp.write(data)
> +        tmp.flush()
> +
> +        done = False
> +        with ubman.temporary_timeout(timeout):
> +            try:
> +                ubman.run_command("tftpsrv %x" % addr,
> +                                  wait_for_prompt=False)
> +                ubman.wait_for("Listening for TFTP transfer")
> +                utils.run_and_log(
> +                    ubman,
> +                    [
> +                        "curl",
> +                        "--fail",
> +                        "--max-time",
> +                        str(timeout_secs),
> +                        "--upload-file",
> +                        tmp.name,
> +                        url,
> +                    ],
> +                )
> +                ubman.wait_for("Bytes transferred = %d" % size)
> +                ubman.wait_for(ubman.prompt)
> +                done = True
> +            finally:
> +                if not done:
> +                    ubman.ctrlc()
> +                    ubman.drain_console()
> +
> +    output = ubman.run_command("echo $filesize")
> +    assert "%x" % size in output
> +
> +    output = ubman.run_command("crc32 $fileaddr $filesize")
> +    assert crc in output

