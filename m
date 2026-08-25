Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7C5C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96E85606C5;
	Tue, 25 Aug 2026 13:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2k9jBElUqnyE; Tue, 25 Aug 2026 13:19:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787663960;
	bh=bFk9vSMzFW5LBNgXYReeNUEUa4bhM1hiNpNRFq3FwxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x19QGn8LOTc3+Y3jKOdPhN4Bpa12nAt9MNwyKSWNS1nsCN4uh1XdWmb2iVhMZapWZ
	 OpeiSELxzRbImdNXvNtmuFgJ0LolFPvA7rfY5m5EXku3/oPvMMc8XsbiUsK+qHouoV
	 gNlAxmseVTQrsvozSNYYER5sSl62/5ofE2iSnahf5ijuE0xH83tsJyfuuq/MXvx3mT
	 ufdNJK68+Y8H3jHTVkGqYaoZdqr+3lCpKAkhuTpirbe3Axbh6xZy+jIaV/ZCRWJH9W
	 lkKpzpLDj5jAniAnOGnu/EcU4WGAHIxforY8wP2PROFuJ3kH9hX/DzLtd+ogJaDMlz
	 iwgu6m2885b1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B54D5606B4;
	Tue, 25 Aug 2026 13:19:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E3A335E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3357540591
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnX4BYZoe_BA for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:19:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ZtaqqtZc; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ZtaqqtZc
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2D7B40598
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:19:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WwoIiFjnpXbpog83E32a0XMDucs26cLNe3gV1Y98GcJJIp4nOA//C3cmxjjEIiKZfLb0+4en9BWezIugBEvXm/AOEje+A4dXz26K1eI54eanETjpFlwUxnZNtijSnBLBKvhUlNkIz2M7Q3OqsoVAe7cHNqtqafn87A0vJ+fKD7NTAue/U+OyxqAnP6/BMoOMrJSiQaecxOcUVTRh8HL6PEpBhoYbBlAbo9zYwA2vPLboocOmQOzHKd3RqXrRe+MG4YoTZbkI9/xMp3CnncwezyNU9wcg+IFZ1b7ajv/KYT1ThB3tDjoNIPwswsjHGd56xosXYhUn3ZnFHF+IyFaFMA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFk9vSMzFW5LBNgXYReeNUEUa4bhM1hiNpNRFq3FwxQ=;
 b=SULy41tjmStkWjQuF+55hCkeLr6aUOTrn39JtxnvUvFjCoh9NXVGDxoKG4OAKkt+uhpJaqerd1h1KOS66B47QBRZTsja1wiX9M30ypZTt5smBDRKwcoSaG208ns6BgyrDt5q8Zpkb8TnTHlRKIk5a5Xh8Hd99nSlH4k7Pnyd1W37JGZdyQBGxt1L+ADJodsKoaCOvtnFtRP2Pzgz2/TUlwOk7kG8RE71ZwzTuddfywzyV06SZxtHqBYhmKIo1E69KN46XMqY9M70SshXq1GTkm3+mf/ALjjrGO1RPSIqqWR0PQqAYlXJapg8reSLwVKy7lIaZVdPFW3LyB+WSh2u9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFk9vSMzFW5LBNgXYReeNUEUa4bhM1hiNpNRFq3FwxQ=;
 b=ZtaqqtZc5m8cH8/EJs9cI2XhcrvxTQ3TpllSBbetfnGo7dgpkIFS1j3XRnh7w1TBBniKqiFk4UFMqbG55yX5Y/Cp1KNCFughYlU/LV8zOyM6Lm/9b14qX9aGI9D0zvu7pbxf4mjmwrdyQhSHwMfF62GvTGNVSpzQeSAHJSOcesg=
Received: from OS6P279CA0017.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::8) by
 AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Tue, 25 Aug 2026 13:19:07 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:e10:33:cafe::17) by OS6P279CA0017.outlook.office365.com
 (2603:10a6:e10:33::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 13:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 13:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOYRzQbTnkODkmhJ6iKDH7RAbE/K7vSZ7kMjfR/bgM8OCko+0ns0UslVc6tDhSFQ9zM+r9wn8sa5Nc7XeDO0zaKDTPNzD+LSNoHpJIdTywNU6yeZ7RdPXhVqIvlEE0hSxJenzim5NYtDs6liR0bSOkcjLcmRkPQij4qVwInMt1dPTr7eZt61ucPbNHqqsO8MZZ5vo10aI4AEBH2xTmTQo7QxjAZ5mqEF6lKeMY64ALrO6T0PJ+sH5dFLM1s48C7j5eYy1EICm90IO603lnWoy3uMC9jRHbjsm74V0KAqZDfFvMsSQQArkua5NUlsuCHtjJyHX5kLDdNQ9WvzwO9t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFk9vSMzFW5LBNgXYReeNUEUa4bhM1hiNpNRFq3FwxQ=;
 b=ZM0BSGLujfzjuYknwWbpjzVlCdHWSJ2J5M+IHBazypSC3wlBR0X1bsGPd6vhGnVmtuoBvwbTdR6QLJrjkQJxrOxsoEwB5V8akveic1bZ7DL2xZcihYYXu5bHoujBSPvYgWe6mUyg7XM+sYl5n9ZM4ngrs0StbaKr0to51yrourZXqgyYxxEcug7z9I2ZeLnttgKHb+zg/ugwbnL6Z7H/Gv2ZM8mlRV7NqrIhSlysNCySmuCutgcG8SGLP3D09GU2+CFwH70X+MbvTsrKZqkBbA2a555EA4BMdk0/ouLjjGw2QHx7YtdqI0VdQt+S4OABP0KHtYxuE9Rj3WzLEs+cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFk9vSMzFW5LBNgXYReeNUEUa4bhM1hiNpNRFq3FwxQ=;
 b=ZtaqqtZc5m8cH8/EJs9cI2XhcrvxTQ3TpllSBbetfnGo7dgpkIFS1j3XRnh7w1TBBniKqiFk4UFMqbG55yX5Y/Cp1KNCFughYlU/LV8zOyM6Lm/9b14qX9aGI9D0zvu7pbxf4mjmwrdyQhSHwMfF62GvTGNVSpzQeSAHJSOcesg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB8387.eurprd08.prod.outlook.com
 (2603:10a6:10:3d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:18:30 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:18:30 +0000
Message-ID: <53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>
Date: Tue, 25 Aug 2026 15:18:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dhcpv6: support rapid commit dhcp6 option
To: Yuxiao Zhang <yuxiaozhang@google.com>, u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>, Johan Jonker <jbx6244@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <20260819191046.4125809-1-yuxiaozhang@google.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260819191046.4125809-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::23) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB8387:EE_|CPH1EPF00000520:EE_|AS8PR08MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2729465e-5edc-4962-9214-08df02ab70d2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 4zXNvkzayMg43DvVHSKSdFBx+6d1dEd7yKmSgsJ3B5DSFmHMjdU3jnNOIJnXQEG2JpPaKzpUHEa3NAlW3XZPfzsbA+ZHQpwYyuWF61o5zQPMRjYVpmJ5A0juUeSsZCQgqM5y1scKel8Bv7KDhEjUctTTKVlbZRERrXsrOnds/5BNaLYtwkxWPF/5Wb65AuQ2jo9xJknHA4cT19JhwlY2yjpaED/nPDUzD2V8bQ20bxn6TQ6EkIGJsZLgdBr9A5dDnskTo2UEUMH327ygDnkbvgj/UHkmqs/a3sYmXyCVOqab6LF3g9MZ5GXXAJ93T0o53WEOD/LlxKYIFXCMOHzHNjCQi3ow3nCtaXIIsgbPuQ+QF8uqxJnnfgNrv436XvHAdMJoyyQCe8NSkTAMk6gmHvsP/07t6mK2QgxTkbnxhdV71Em5RDyhJrTmydnESv1rIt0FbVnXenlASwTaddIbGP316IXWwRrmSgUeSAkzRj3kfQr4lWvoKithxHVI9PODs2oFZYv3kMm48HrQLIZPPJ7aSHm3wqJq7KGcWJf/dQrduoD1nI2uMe0b83h8omAzDGNeOSpFZQ+wZLeGUP7Tc7e68O5NCqRJ+TvqYZrnlSxzhT1ZZbRpt/huQOq68psWKlR7yvr/uaZ7pgBHhPqaaxV53SLjPIc47PzqZR56PO4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: TIlzh0mXZjz49uNbq0oM7w2D1epbro7W7BnWW2GuY6FCV91z3djLGaF/WFXnxW82U2ribx0KMKf0P36sliOLr5OqWPk4nt2yvRHiK2T2rtxkwaPM6NaEH3Xj531BHcelIDuYDxWAQu1SVW4zaCa3DPobh1F3GrlRjcIJmCs+kbh8pzxcCeOxWOejqWrMt1BDFu2vFd/C0t6WhbErgV2M03bAn5bpkV2h+MiIkGU+AyVNy1pM868S1bytnMPij1W4eVUbX1DwUOJJ+hs5d9ufP7miqXxseyCXgDDVp7jWZBFKdY+BZVe6dbTWS6Xainuz6VABUqkoD4d8KhVCzBwrTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8387
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ad5d6561-f9f8-460f-5009-08df02ab5b2a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|32650700020|36860700016|376014|35042699022|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n/sCN0lIAAWVYt/QXYFZieFQzorr5F2NOKbQIoMar3uulVgx2wxH5eduv7d4UqCULBrePUUn130Wv2iC/uuNQhsQwBGyQY7RtnVKNlGypSnyeC5iJMBoTmp6xTvP8a2W2yQmF6pIZC7pGmma/TR8N3UfRSevLWZJBHRmSk7fuKL64jMUxxNLBgLBcsC6mZCl2lEbHnu4mLoSq1KMcdyrhVVZ7I8xC4QdoEPrEWrjmg6UchzqtoYQ6iFD6B1B9/QyXsQ6DiBBVEIdphUmQVRUOq0MTfR7WwOGonyPQc124KIXyDrKqBlNSgeQZFDwjgeJBQh/kECzOJAaODAHB2GRWhayitMl8dDxZTGSfASIAkhsR79zV1NHz4EEI0UsQQ2fgVf2hdBzc5z+ZDEIiXRnz0Rq4yqbl3u4zqjdVqBH6kDxPEf+X1PxNdpD2EEronVOWFHm9XRry56+yIADvqK9xlPg19zyrb6rdolYMaq7fYcfEXUEogbOA0o6fCxkX/CoIZH+U2gqjsMhgp8sdcQ4RqL+c0PKo5p/QsuOq8QRw0+IpRAopjuPGERObcjlnR5NZR+Gj/nF7phuJKhFwCijeaup+uTtitkjs3fFWYhrzxzhkAVDcmxVwnSpQ1HhSVMvOwPFTkWCrKhh4NIxlBT58TQqhzBzo4YTgOMRtC6B1q/d29UiG++TRGQNhc7yi6nZ
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(32650700020)(36860700016)(376014)(35042699022)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vqvPBTijdHAqWr9aTGpBAKD1p7ETO7qd11I2B3yOwBiWArm8QgYTHJi+UqEG2IgM+DybLZqdQx2Rgn7z36jSLsh2OuPMGiNuTlmYNyWzSRgV5y89MyPOA3HAfyFFQXvkPi1JU5sYwYjH7NOTzTrYxT19Zw1UrhyQwxPkFaLnsHNcVTn2udm6hhW8lgccfApNiZ3icFewhQDaFjG1mpMbQe5jyu4yUsBebNAfn60uTUSPestuu55KsO0GmZFhigQ551wldKnesVxHRPPH15mLaxEiLA2zxhBJqERefoRnitSWBgcPHqwSERl0RgzNMIQiLyu9ZmrNOq6UJeTwr3jR5uAmRPFA1gIsK8U9W/syfUA4Gs12L8ieYTB4cZkda7xIMZvdEtH7icqfbo6IYPfKmskMGfxyaKcxdLemd1aR288z/GdkZ+uXmcS6Y9NPibuf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:19:06.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2729465e-5edc-4962-9214-08df02ab70d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314
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

Hi Yuxiao,

Two minor comments below. Thanks!

On 19/08/2026 21:10, Yuxiao Zhang wrote:
> Support rapid commit option code 14 which bypass the advertise and
> request state. The option is enabled by DHCP6_RAPID_COMMIT.
> 
> Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> ---
> 
>  cmd/Kconfig  |  8 ++++++++
>  net/dhcpv6.c | 39 ++++++++++++++++++++++++++++++++-------
>  net/dhcpv6.h |  2 ++
>  3 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..b3cf3a6d8b6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID
>  	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
>  	default 0
>  
> +config DHCP6_RAPID_COMMIT
> +	bool "Request Rapid Commit (2-message exchange) from DHCPv6 server"
> +	default n
> +	help
> +	  Request the Rapid Commit option (option 14) in DHCPv6 Solicit
> +	  messages to enable a 2-message exchange (Solicit-Reply) rather
> +	  than the default 4-message exchange.
> +
>  endif
>  
>  config BOOTP_MAY_FAIL
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 640f089a2e1..1e51e6de256 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
>  
>  		opt_len = sizeof(struct dhcp6_option_ia_na);
>  		break;
> +	case DHCP6_OPTION_RAPID_COMMIT:
> +		opt_len = 0;
> +		break;
>  	case DHCP6_OPTION_ORO:
>  		oro_opt = (struct dhcp6_option_oro *)dhcp_option_start;
>  		oro_opt->req_option_code[num_oro++] = htons(DHCP6_OPTION_OPT_BOOTFILE_URL);
> @@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)
>  	pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
> +	if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))
> +		pkt += dhcp6_add_option(DHCP6_OPTION_RAPID_COMMIT, pkt);
>  	if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>  		pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
> @@ -448,6 +453,12 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			}
>  			sm_params.rx_status.preference = *option_ptr;
>  			break;
> +		case DHCP6_OPTION_RAPID_COMMIT:
> +			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {

option_len != 0 should probably be rejected here

> +				debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n");
> +				sm_params.rx_status.rapid_commit_found = true;
> +			}
> +			break;
>  		default:
>  			debug("Unknown Option ID: %d, skipping parsing\n",
>  			      ntohs(option_hdr->option_id));
> @@ -618,14 +629,28 @@ static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len)
>  		break;
>  	case DHCP6_SOLICIT:
>  		if (!timeout) {
> -			/* check the rx packet and determine if we can transition to next
> -			 * state.
> -			 */
> -			if (dhcp6_check_advertise_packet(rx_pkt, len))
> -				return;
> +			struct dhcp6_hdr *dhcp6_hdr = (struct dhcp6_hdr *)rx_pkt;
> +
> +			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &&
> +			    dhcp6_hdr && dhcp6_hdr->msg_type == DHCP6_MSG_REPLY) {

dhcp6_hdr is necessarily non-NULL here, so please drop "dhcp6_hdr &&"

> +				if (dhcp6_check_reply_packet(rx_pkt, len))
> +					return;
> +				if (!sm_params.rx_status.rapid_commit_found) {
> +					debug("[DHCPv6] REPLY received without Rapid Commit option, ignoring\n");
> +					return;
> +				}
> +				debug("REPLY (Rapid Commit) good, transition to DONE\n");
> +				sm_params.next_state = DHCP6_DONE;
> +			} else {
> +				/* check the rx packet and determine if we can transition to next
> +				 * state.
> +				 */
> +				if (dhcp6_check_advertise_packet(rx_pkt, len))
> +					return;
>  
> -			debug("ADVERTISE good, transition to REQUEST\n");
> -			sm_params.next_state = DHCP6_REQUEST;
> +				debug("ADVERTISE good, transition to REQUEST\n");
> +				sm_params.next_state = DHCP6_REQUEST;
> +			}
>  		} else if (sm_params.retry_cnt == 1)  {
>  			/* If a server UID was received in the first SOLICIT period
>  			 * transition to REQUEST
> diff --git a/net/dhcpv6.h b/net/dhcpv6.h
> index d41a3c30615..49f20390730 100644
> --- a/net/dhcpv6.h
> +++ b/net/dhcpv6.h
> @@ -24,6 +24,7 @@
>  #define DHCP6_OPTION_PREFERENCE		7
>  #define DHCP6_OPTION_ELAPSED_TIME	8
>  #define DHCP6_OPTION_STATUS_CODE	13
> +#define DHCP6_OPTION_RAPID_COMMIT	14
>  #define DHCP6_OPTION_OPT_BOOTFILE_URL	59
>  #define DHCP6_OPTION_OPT_BOOTFILE_PARAM	60
>  #define DHCP6_OPTION_SOL_MAX_RT		82
> @@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {
>  	enum dhcp6_status	ia_status_code;
>  	enum dhcp6_status	status_code;
>  	u8			preference;
> +	bool			rapid_commit_found;
>  };
>  
>  /**
> ---
> base-commit: 527115ef6783cec49e5610c523c124b399011361
> branch: main
> 

-- 
Jerome
