Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7900C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D30284942;
	Tue,  7 Jul 2026 10:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FPxcsHRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459CA8494B; Tue,  7 Jul 2026 10:36:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64397801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 10:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raphael.gallais-pou@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBqfb7z10yTOEGc8VCjFWPHCg37lEHWZ4LVI65rExgoPANwJ8Touy8vWkKVxm5X3J+49p45LtsznI1ZYXrrPB8fjmwRL7vMu75Fo8m1Jk6H+2sxkNMktQk5ypBuH+/gzNp9MRJrFgLrmzkIuZf8/Bq7jMZVV7tdrgEa/Z45yQP8gitswmh3AI/lk5kBLi7vZC46xiMCcAj+DoEbsvg0P6hVOszac9yMp8A4QqvsTyZsLcCBUuiNRKuSJ6rtKMvO8nRCperoqIdJSzIW5YOh3rTWuCMvdGC2rq4DJMMvvZEWLoAxCgtdLww8PGkMtEjDFXfZDj+0p7Ri09mH/AfW1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcVd0En7Ew9pNScTX+O0i5ljPdKrtnV0/XpRxYEG2EI=;
 b=cc6u6G2BS7UdBEiLvKwtms8QQN/pCkVAQi8BtWIoMPgboRukfh+J6fNFhQANt0o6pgrvD23wypIuhlepl80VnMu2WrYEZOIE9DRYC4PUB75EG1xE0hE4N8jifLo0JMds77VlQMzJgOTpX17Uc5O+cjnTEBUZ6qjYWN2bUNeyX+EphcQeKCCDgrEO6YWrWLdjunDE2LECHf/ANCj/myLSgUVj7Y7Rzsr2+YT4bvFaI4Y2+qtG5und1JxwgsKYDpdmEKvSgBa7/J0mnFinHm8Buqxi6yk969Sphcv18mrj9M+dKoLppHf71ejNfLpxqMqoNLKE9wqqBSFvEs7IZVtzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcVd0En7Ew9pNScTX+O0i5ljPdKrtnV0/XpRxYEG2EI=;
 b=FPxcsHRHe/zP7LjcYsDoTSgNIQr35VUh3w1iXMGzkm/Yx57HcGgdN+kINTQ81GDPNJZfl5vjEuuB4r05YQZDeVhjEPqF6Ckc35nMk1djrO7rn7kv4/hA0McUBy0admxefJKhZ3aJMZ0F9SC/OQJINsXACRH/Bgr3P0NTzT6SwXLmI2LIdfUUl8l0pf99iNvGDMKm9y85czW+SnxEl8LKJxFIkiW4uDl5sJNFGxwg6If5Lx2uH5GwjuB3KBoUnVUOS+xlcrHxAEn/ouHXBC+ulSC8dsJfx/Ke8epHrCWRlTdspG4E4SReUR3J3YqBPaFGl5xLMD+4iD9NU0KcnO1dqA==
Received: from DB8PR06CA0059.eurprd06.prod.outlook.com (2603:10a6:10:120::33)
 by AM0PR10MB3730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:36:25 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::2e) by DB8PR06CA0059.outlook.office365.com
 (2603:10a6:10:120::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 08:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 08:36:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:41:14 +0200
Received: from [10.130.76.182] (10.130.76.182) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:36:23 +0200
Message-ID: <c43d1317-320e-4613-800c-55199ef657cc@foss.st.com>
Date: Tue, 7 Jul 2026 10:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dm: core: fix wrong strlen check in of_add_subnode
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <u-boot@lists.denx.de>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Rasmus Villemoes <ravi@prevas.dk>, Casey Connolly
 <casey.connolly@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-2-076d395bded4@nxp.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260703-dm-core-v1-2-076d395bded4@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.76.182]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AM0PR10MB3730:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7a9531-f69c-4823-521c-08dedc02d4e2
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|36860700016|1800799024|376014|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: FOoWiru+D/xFbhPth9/lvJ298DZokOjG/7C720WqTBicPCWqD+1E6vhGUxPkoO0kus8HOEnBjMpWhgqdUgRwPH+EiBRtnXsvWAQyFamrEOqyEg8Hxq5do0SAVfkSTaPwUtkVKtZLY3WZfjnyOJtBThzLueXH/U+RRR9tZuZoe6CaUfFxy6lvXBXBKcws0we1K343LWZ62BiEC24kBNmyufAd0u6Qg2nVQ1zPlOsa7ZprkBmr0GRp5AeGovJHAMZq1be8PbKyfUovO3AVNBJFCVlW12s4K0Y1gyFWgyhfy14CjbO1wHKP5HNjEFdkkTQBoBtv4rBdzgU7NGS/6CTlG2FIGi7f3SeiortGQnrO2QPMlVD5k9L7Yi6ewyE8v8Wn5DH250TJvLTaHrntcmh7fk63YwWhek4bRW9cVDObUrpxT7SUVFtJwdE1UGk6BQlQP647/8EoU1lArgyjEZr9gItdN5eqZNy3ap9TesSr3SZf9hsnZiNqG/CoWCkuOR/ZDcjaX83I2BNQiT/Lrvhhpiaix/TFxSx1FYcKHuPRpUvOANGBZMSWZ2BK/p7BJ9qVV1Q/cQgo0JTCcwxGAsGShJWcBXC6+7zeGe+w8i5K9aZAuv7KPKU7jscULvNBlwD8Mcq2YpU0aC+iye3sAHcdOhArG5xIVIlxDZB/01m1chI5a/PXGub/uiKAS7LVQe+8KDZdQJjuA9G6Wdvf9VYVEw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(36860700016)(1800799024)(376014)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DpZDLkKGj8ASma/x5pZASO8p5ARbe3YPQCzfLX7qfSZWKKxNDOdYgoTaBAt4Qv0PTsXDVyX017nLQs83KCcEDvVY0fdycrxxa7Kdm9UPef7asFgBDHV5SuEM4t8e1ICDDczXO4gINuzpEwRs7GHL7o8jJeEfAX2MbUOzcS/0rIqZO7wnKr/hLje8Qe9cLXxguxMRJC0wRcBZ51gKJJuOZPi4OY1Xp5hLFm2Vqs95EeilwzhswNiYEyxqk2HRXPYWTCLmJPhwlSL5L/W2bj/fKXMY/Fwx+VFCE6jpwkNunYHGdL1qcf/ElY29Z/C9OFPcOPNxR2HovahE0j8aFkCMp+cEGAKBwO9PRR16k3lJvEQoreQt8wc/dgnaSFSOfZTCGlIeglWUAqBzXovsMf/pklt2r0g6GAIb8NlXAjyg728zNL0w6+P990e1o8GvPpTA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:36:25.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7a9531-f69c-4823-521c-08dedc02d4e2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3730
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



On 7/3/26 11:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>The duplicate-name check uses strlen on the
> search name instead of the child name, so a child named "trevor" would falsely
> match a search for "trev". Fix by checking strlen of child->name.
> Signed-off-by: Peng Fan <peng.fan@nxp.com>---


Hi, 

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Best regards,
Raphaël
