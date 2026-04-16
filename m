Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D628F4369B
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F8C8432E;
	Fri, 17 Apr 2026 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LgXO6vaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BBB83FC0; Thu, 16 Apr 2026 22:33:53 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F45B83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN7NfGzZJzkHUtoFKJKYKbrvM2BvSCpPfaDdjVUMMHik/CoC7FcMF2n20tbScaPSNVICmB3D1Sup0w4HO/I+PFOSaeZhzlYDIKRfitjp+KVH6p6lspaDKS66ft0ccS0ahojXcmFfufIkSmBo3ZWOMrQWGhQbO2PAAUsrRr6ZjxjOjIo3EvlkFMFOXkeKKBJKdgczE8o9aa4f05ADs70Q8JHUx4CteOl7DYAVL5c9MKSsqjn4wJpQ5mGrCazpst6j21eS+K3m8oIVHLMvO+bG4StMDE5TuNoRElLwd30pLS0DbfCfJFBkhvyPcAngc8n6jmmfm3Q3p05csbL00yZ56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9fc6mxK2/+JPlvrERxlRsn3QB7dSGcOadEy1zuNqa4=;
 b=Z8gll24hhjM0wBj7b2yo6WwQqW41f8p9q9YmqsDS34ykj1iCQxHoYyWRzDG0/wmJu/Vk6Dm5eeud5kiz9gX2doez44+GvjycVINDVKtSSqfvhO/Dthy+0XgQ4YciKAATaEofvdgLK8DDtSL2bj7w9oHDjlO5pDWdg4hktPpsQJ1JRTSQXXG6pUn+FOVcPfJiaM01V/2b6kpiK9tSF/eZtjlmY5dWbar+KPuQYhzzrE5wguqrlbpdK8lTsI4OzcgBpEXpVcgHwwD1uRg55B+Umsv58LX+ukGx52UkN7ReirhRzSb8py2KHQmz3uw9dZsRxPOkmoq9b985gwpBX+Vx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=paulk.fr smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9fc6mxK2/+JPlvrERxlRsn3QB7dSGcOadEy1zuNqa4=;
 b=LgXO6vafSt/fJ1PdLLJBQ8WW6Q6SSFW2wSA04HDVPJXYX4B1R3y/3cYhLgVgTGApOC3Okk0vtoH+UhXwI070d1BjJ0XFQfMkLeWDPctPfN6DuE4iIQhr3pvxnzP/Ba5rVg/FYlv0oEOeq8tsdizStexkn4AfRWQmALg/V9GQzA8=
Received: from SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 20:33:46 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::92) by SN6PR16CA0053.outlook.office365.com
 (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 20:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 20:33:45 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:33:44 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:33:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 15:33:44 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GKXipp438153;
 Thu, 16 Apr 2026 15:33:44 -0500
Message-ID: <a02cf44e-c7ad-4abd-a102-59ab1963eb32@ti.com>
Date: Thu, 16 Apr 2026 15:33:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
From: Judith Mendez <jm@ti.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.denx.de>, Marc Murphy <marc.murphy@sancloud.com>
CC: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, "Bernhard
 Messerklinger" <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, Paul Kocialkowski
 <contact@paulk.fr>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <39c2f5f1-ba0d-45ec-92f8-2e87ddff1aae@ti.com>
Content-Language: en-US
In-Reply-To: <39c2f5f1-ba0d-45ec-92f8-2e87ddff1aae@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e4db5-da53-4d76-525e-08de9bf774d7
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xCtT5BqMtX2r1mm35uOhBRBJiO8c253z2tjmUn0dTbV5jkB6iNfNA85Eq6geOd5b+0mM9yaV6iAw+cEaAy83W+H9QnEXOt7XfU26eTSLxEFcF1cbY1zTmoR3lksmWe4jxZ+w7AbyJAsud+whHeXQklaYpy1lJGRmbIscsGmG962phvFnEHIqXwxUFqvTjwuOd0iuIoopuBneNV6FvvF3ul6sZh3D2leM0mlDWtb1ZGaiLIciSgdPEqI6KDz5t7gsjyX81s8mEd9CpxAm2QcQWyJAAihve9fc4woYlPuyJ5DjP0qGrP5LiZahoqVNh/6fzhv82G5lzFE75NgaTd5kmwFYljuoKhInVFGL6gsiKvyBQVi42yHN/eGfwppe+/X/S/K6fIORHmhugzltyx64OivAt+b/gRPcNWT/XNrBcCJyiRPfNTk712jy9dAE4QmGYMSavC24DSGbONI6N8wnVj+kjlwTEf9E3ey0Xt4Ga7MvHuxJV/4uK9gI/OnOX7FRRyFrrBMqXXmJhcC7amvcS8TFoD1Ih9PwHV1uRPv6ekV0K/MYFb5m0vtEwbdO/a/VbRmvAiiwDjtXEh5KZYxFl9LIyKFTb20W5O93wBwEQoymOBy/RdAtaVUodKpsfccmtrVa44YMKn1074kEPrfL8Exm1lYFKSAIdnUDVislrVZhrOHTKJAOCOiEAclF7vluyPFPdXk53ZLELV5UmPYK+oKlGVQO/270nRKL+jpv1nMGrmdmsu5vglGw/qcL56nmFV5FtLY5otvbR2+h+EDFmLYBZ+OQahDu3RyByvIL9K8=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jFFNSz2VHOPi3IiPG5XpxX6gMqg1w1munsJcLttNyuve+ke3/JPQUWXf4+CgLArlfyaaMz+CpHlOOJnJa9gsoi2SdfwZmtRW0mqWtuQIvLXHtQb5dg1iocNF5qfdzt/XqGclv1j/8odofVQwbCIL0G6leZ2koiiBQyuxslTuc4gMWrv7u8raukGzzJgvCanLJB4BOEr/ZeL/eEorbmvkenjtzqO0UBwFO0GdEFsNt1fVPg/7JjJ/TWcnDBe7DoFcgzcAbXjvEiNfpL78xueFBDgL58wnaJ1Tl2rnmB9b+7a6t3qrOZFM+J8HfcTjQVVkWCCwunq/3jCQq+7R4cu91G2YCkYlEVCNS8iyjuNPVYo16mRwpc210iwpaB8C7We8jnXCfOwOnlQqX917ghkGgfcmKjZQseEgxSMTO1Vcxq6ccJJln39jCUBB6M4ATL1+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:33:45.1926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e4db5-da53-4d76-525e-08de9bf774d7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Markus,

On 4/16/26 2:55 PM, Judith Mendez wrote:
> Hi Markus,
> 
> On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
>> The series is split into two logical groups:
>>
>> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>    with the current u-boot devicetree.
>> - Patches 4-14: Make upstream devicetree working with uboot. This
>>    adds tick-timer, adds compatibility of the board code for different
>>    USB probing, makes SPL smaller and updates the defconfig.
>>
>> The series has been tested on am335x-evm. Note that I don't have all
>> other boards built with the am335x_*evm_*defconfig, so tests are
>> appreciated. buildman reports builds are working.
>>
>> Dependencies:
>>    - net: cpsw: Add cpsw-switch DT binding support
>>        https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07- 
>> next-v1-0-c914724b13e4@baylibre.com
>>
> 
> I have been planning to test this series on a couple of AM335 boards,
> So far :
> 
> - am335 EVM: Pass
> - am335 SK: Fail (at least SD boot regression)
> 
> Pending to test:
> - beaglebone black and am335 ice boards.
> 
> 
> am335 sk:
> without of_upstream: https://gist.github.com/jmenti/ 
> e51e1fc1b25c19f94786ad39a38737b7
> with of_upstream: https://gist.github.com/jmenti/ 
> fc17347eff33991a78ce365c42a76a25
> 
BBB boot without of_upstream: 
https://gist.github.com/jmenti/b8f7151e7666ca16b9bec7ec5b2efe17
BBB with of_upstream: 
https://gist.github.com/jmenti/c22e017605d3d6c20189eaf3cfce6231

Seems like MMC enumeration is switched, BBB now boots to emergency shell.

Also forgot to mentioned that there are more failures on AM335 SK
than just MMC, related to USB and NAND I think.

~ Judith
