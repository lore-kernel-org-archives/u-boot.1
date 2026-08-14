Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8631C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B38C40EE5;
	Fri, 14 Aug 2026 14:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQvhdsQsTFfV; Fri, 14 Aug 2026 14:29:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F2FE40EED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786717742;
	bh=ntCTUUf4BY4sPyhEO208YrtnCNxmdnwOAHCjU0uSf3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLgCb4K8fpY+Ec+ah2juaczEC9Nmd1QM4dvLbYKd/cUNuQ27LLlno/IaMkiyrhOxa
	 RMdphSWo5BMt0gLqKS/nj1Ds3s1i+ZV+YA3IjgEs8wMtKUs5TXcu1fztMyctehUHya
	 vPQbppH7E16qe03JkxJqSi2nG4rtwhFVje01PxHOwIM+L5SO0cv6ncnITumQfkDdiq
	 II4ByDUymf7P5NVQweTNkawwF7AE/NM8GaF3F2OJ6I/rwpX7sqH5Wo+RDBcorRb58r
	 MZMYPOUxOIY1w0ZalhclgmRThPerxZtpKqM8QFR42hweuTps4l1Hou6nXXXZ7T780D
	 3BH/FhdeijEYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F2FE40EED;
	Fri, 14 Aug 2026 14:29:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5A6D23F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D5FB60834
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Acz7RDFinph0 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:29:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E2D26060D
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E2D26060D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=X8FvIm0T; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=X8FvIm0T
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E2D26060D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pG6iRitS1966OzjlVN80+EuapQ4U8v1kDm6KgGNha/fqibPQuh5Mj+7oECnuny2TdAK+9gPVGLItSLj6pOZpWjGbOhs5EtqKyUT7Nx08/ERcfHF1aEmrN7z2k0WI2Djlu7UObikP8bvRKBQA6Ci0CRq32PTMImfQckuHUlSpj5gzkrLL5wLr7nLUC78SIPPd9FHqgCODRnsLJ4QAHdlHJq07KgZzM247CEj8GTb7G6aZ8CEZvDksV7+vUX/gZ7p2XbND6KkadDV0seGfB4ZebfMw1V9oQOmqx0ysQzuPf+95vZYYMO33kD1F0dvi+FJWf3xaxxBVepi8WF0CE2sxhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntCTUUf4BY4sPyhEO208YrtnCNxmdnwOAHCjU0uSf3o=;
 b=UlP0QMotEb43gVoT4tC7F4XO5GCPuyClufUnyFm+O9W+cKRKbBCzlZnpgAupoMEJHiSLeex6OSaHFzLafq5Nk+Pcsh+4gMMcDybv1b544VSIqLZTygeH9ljl4hwJXnx+anVoPfUFHYs9DnfJJtv3p7Osq4htKyN+PXK4wVSvXIXLIIof9buenUc8yRxd8BrCXo1xZZ4pqlEfDoUM99nNgqjwZCuZGsVfdY0xaYGgkcZvSs9GxGCtWQfii0vvkwthsiGzRPlCODYYpv9PaYTuMyR/w28wmADHaZomX8BUbooUIcDnppeOyPO1/ba0rj58XNd8TTmS1UJgKWfbNH1qew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntCTUUf4BY4sPyhEO208YrtnCNxmdnwOAHCjU0uSf3o=;
 b=X8FvIm0TNV1v/p/oBoECkxbIokHQHj7v68eefZtZaMfElDugN2rnPHX6lkFHAsXWsa3psPDpZBj/pRspNq8vj3CwWzJFi4dhHwHgn/UYkYoe8w9Mf5JQjBQ7QkYogOHtaAS58Lkp438GZk/WLmC9IXEIDxz8LGKtwflpmD8+Xj0=
Received: from AM0P309CA0022.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::9)
 by PA4PR08MB6191.eurprd08.prod.outlook.com (2603:10a6:102:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 14:28:53 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::4) by AM0P309CA0022.outlook.office365.com
 (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 14:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 14:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZfA4+XM7UgABuKefgz86lzoLpIySoRVzvn5qX9L0l/VJtn6wkApTRkRBClhSTRlOGH8gJ8t/9itCF0fNEMga6qV29iaciWmxxVa3l5vm5yg5VPXFRA4Pl/c5JS0NrMm7HcK9X6aZbJNyDjUmU7ViatM9UbgO3Tv0JPvll4jRog2B+NTFVjY0LVU2WTiDWfQIpSuU0Ks4Y6Xe3RwYh1ofa4BUFOOv8lgBSTc2GMmJZKF5xapz9PCjp93YmcwO/HdI9H8OlBJqGLps4+1UfHD+m035/F4dJnyW+biN6jDpAsNlnsg8YVsmUZXhGID6sXkLSVKUt5bc6N8wtkMMFjIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntCTUUf4BY4sPyhEO208YrtnCNxmdnwOAHCjU0uSf3o=;
 b=LtKO2YROyaA/m17TsrotiCnG/VPzmgzs/y3pQRSGMVE2xPtLPnJi7V843vW6NyDPDMCtKtvN53AyKEqh8rKQQRD+HO55+VOA6sLcdDMH0G1CdzhhU5u6Ox2fM8hHoAd41IomofO9gWnxOh2JqFiaV/fjeF5vV/9l8D/75dMdex+4z80Dk8kuKVW0iX84/4nBf1VoLZMwN5MviT5hKfWIcUOWWJ2T3BorFk4DUsxW5tKD+zlUndHzj/cV0XgCiSOomWFLnRNt3FOdPzWroJa5K0twZcie1vyd6Du2Zzwt61KmstZipNJ1p6ISbqm97TrKYMSFoKlHKz8kHgOsmk98Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntCTUUf4BY4sPyhEO208YrtnCNxmdnwOAHCjU0uSf3o=;
 b=X8FvIm0TNV1v/p/oBoECkxbIokHQHj7v68eefZtZaMfElDugN2rnPHX6lkFHAsXWsa3psPDpZBj/pRspNq8vj3CwWzJFi4dhHwHgn/UYkYoe8w9Mf5JQjBQ7QkYogOHtaAS58Lkp438GZk/WLmC9IXEIDxz8LGKtwflpmD8+Xj0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10153.eurprd08.prod.outlook.com
 (2603:10a6:20b:64c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:28:17 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:28:17 +0000
Message-ID: <d2b5f9f1-724a-426d-bce0-7f9831fe9ce3@arm.com>
Date: Fri, 14 Aug 2026 16:28:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: lwip: dns: free the callback context after an
 aborted lookup
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
 <20260813-lwip-httpc-uaf-v2-3-1c3f0b3aa1eb@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-3-1c3f0b3aa1eb@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB10153:EE_|AM4PEPF00027A60:EE_|PA4PR08MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6366893e-1e42-4443-0b3b-08defa105bd9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: PMER611Jw5N7DgOTMuZ+pYutpoEh5Hg6PmZp3szmEhDDvn+qv6IrYbhDhcLtSIzJEzi2BUQAnwOSV7S9jxzbOjIvIikFGXfSvb4OvpAP73HEn0JuLlxfiSlJShOEWs/zbiWyDILlWlriAVzvyOXMUTwZk43g2Qp051dJNYEE+5LStZLUYFyIZAoqRz7ja+aJvC3ocn3ysmwCexgc5qkgXd2bWASFk//a9aBoOT+kfh4bodpOGB+D15ow5kAc7UZj4OaiWuOU59r31eNLlsJebV5dSYYrsYhMi7p71TX9IE4nyxY//MooI8G2qc7iEwVxpEYLaofa2q4NVrbdUrqPW6ThTb48fbWPDjUwxQuiS370wOkK/NM7V2zalkt7fdZx1r5p7/KWuoGh6+c0b2rMXEvlWRPr8Ez2JhB+SQrgz7ktp5wXavSoAwRCDOlN4BRdRQaaH7sIE0VM/Dac5Bu2h+vT/l/+F0d1F3ydkrtAABk16qZhip/Ix0Hxz18VZ2UtyYYi13Djl7saWTRkDe6C2hKciGDT2EFSv8Zdrn+rzXMPPVDD0pPLdYs0G9aHD3kW+aOHt6TjSA1rJ8eg2j3aVX/MWffUjPrlUBRVnX42uV4HgQY0qknAESJ/DAafSa0LD1eqm9bC2TMunhrDe4TimCFgc8ZTeIxD5qkF1TGAqR8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ofIo3ljJiWLWYa+IszgkReRvMHQdwCCXI5zMliM2NdfrPR/b9CIpLIoSe9guhsuaO0UpMvD35oS4R7MiEn0TeYzPVWhslzi4uNn4YcA0kARaz9DRcGEDMOOiFOfxriGc6+Ts0pAjJ9V9bBXdAFB4ycXqFEtir4kNZFzqsS4/53qtqFRCD+CR7tCf+dZcY0nI3NWtVIxH8/88LH7qe5ftZEJW8BQW0iIof0roQ4MKE4Wgik3h9qeS73gQbSJI63QLtNZ0ewYQupteDNQGfs8kkAMDXSiRJ2WSVwb6PB6mYLscGjn8p+syJRnrnlrKMH96NXMQ5ncKfoLjamaBPlLEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10153
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1d5f8f9-d9ae-4e19-f34f-08defa104812
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|35042699022|36860700016|1800799024|14060799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uc4gT1q+4VDuGV86LGpWZfp3NMKJvxxiJFnr+B2S+xV9roQaaPFG83aPEfzTlOHV65Ym2z67vFz+FlzUPd4eSp75T/WG3FpwUZnSG7bLl7oZAoYBrr8EuSbG6C8jS5KNY2kuMrrrTPjYzHtOsCGzx9mArWgQD3RvV2piugxDphDLsWpumiAbwSsAdNC+McghS0HXYAvlXxcaijVH9wiJ6uG8+Cf8iwOJLm1gA0hCqt218c7lEn4WAPI/+MvOktE+Z7iQfXbuSMBqIpVNV0UFSnHlHLnaLG3Bt3heRWo21JBdMQh2rLhXtJwEtH0jRkQWVz1bxISQ390W3PC56WCTOL681C5nEaE9fWNyItNN0VxVNd+tbu6uypCaOnM/0IVc0dB1+nidhtES/wn7rUDnC1ZvhD+Jwy9j9Y1iqXRPNVhXSUK7bq+Esewk/gv5GIXYYWrf5yB9HgshIHL0XzzxIswkHXwT+Mlrr77SoO5B1ZwG4yrv2tpW/LALTXjflA56Pr8F0oVcrv36i+bWw1EQcE48yDGoxSEQSQyQwStNXHkTQ/r/Gn2X0NSUO2Y0AKGr40C0ArM1GdKyXcQ4nJuw5lgXStsKTBB1bobZ01fQTD0+968lFHZPIDlX6iCCHavSplTjHHa7TZ/2UVIfX0hkyDpmoOktdIEMMpmFJa2fe1Z5o5xVF5xqb47BLLssekJxFqyJEo2w8AYIGSucAQFMSg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(35042699022)(36860700016)(1800799024)(14060799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fYJ/6/kzuUXf9UuQ2dNQPtyWQ7sO40XfxrfxqyfbwhwfvEftUIX92dhQjKnvodJzdiGcRGzOUgtcwvZn3wEhMl95Ndr/U3Kk1ZwKOuuk18SfQxJvg55NzlGVcWC3P0CDfLKChhQh7jWQMI49a9udr5MEu0xydGTdKb86TCGdwr/h7Lw0eqde8ijZvPi5tfKi/n2tsksIG9hzghcVtouLwiTvx8o2bRYhC+rnS6Y9qUUbQWM7tCylJkuVXDxixS4REDGHNmg0u0aUD7NAqieZYm0n8RT93+NRIN1UY6LSUMrxJBqcHR+P6t4vLJF9QoqUr/4tAhrytA+06TCIyijepMNeSdvcTOjY+Xkt6VbtW1oEOEgjTEdGX8z1U0MbMGgal7bKIAP/xzH/YR2KKGykpm0fIEcI9ngHVM3AAuJc+FEUvZxZMPyZDq7ckiOBJu/f
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:28:49.9632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366893e-1e42-4443-0b3b-08defa105bd9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6191
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Shahriyar,

On 13/08/2026 18:28, Shahriyar Jalayeri wrote:
> do_dns() keeps its dns_cb_arg on the stack and registers its address as
> the dns_gethostbyname() callback argument. lwIP has no way to cancel a
> pending lookup, so if the command is interrupted or times out while the
> name is still resolving, dns_cb() fires later and writes the result into
> the stack frame that has since been reused.
> 
> Allocate dns_cb_arg on the heap and add an 'abandoned' flag. If the
> lookup did not complete, hand ownership to dns_cb(), which frees the
> context when it eventually fires; otherwise free it before returning.

Similar to the wget case, this relies on a later DNS callback to reclaim
the heap context, but that callback is not guaranteed to run.

Here too I suggest cancelling the queued DNS callback before returning
from dns, while the stack object is still valid. With a small DNS
cancellation helper, dns_cb_arg can stay on the stack and no heap object
has to be left for a later callback to free.

Thanks,
-- 
Jerome

> Fixes: aedcfec9ed78 ("net: lwip: add dns command")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  net/lwip/dns.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index b620b0611d6..e93720963b8 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -4,6 +4,7 @@
>  #include <command.h>
>  #include <console.h>
>  #include <env.h>
> +#include <malloc.h>
>  #include <lwip/dns.h>
>  #include <lwip/timeouts.h>
>  #include <net.h>
> @@ -15,6 +16,7 @@
>  struct dns_cb_arg {
>  	ip_addr_t host_ipaddr;
>  	bool done;
> +	bool abandoned;
>  };
>  
>  static void do_dns_tmr(void *arg)
> @@ -26,6 +28,12 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  {
>  	struct dns_cb_arg *dns_cb_arg = arg;
>  
> +	/* Late callback for an abandoned lookup: reclaim and stop. */
> +	if (dns_cb_arg->abandoned) {
> +		free(dns_cb_arg);
> +		return;
> +	}
> +
>  	dns_cb_arg->done = true;
>  
>  	if (!ipaddr)
> @@ -36,7 +44,7 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  
>  static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  {
> -	struct dns_cb_arg dns_cb_arg = { };
> +	struct dns_cb_arg *dns_cb_arg;
>  	struct netif *netif;
>  	const char *ipstr;
>  	ip_addr_t ipaddr;
> @@ -52,18 +60,22 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	dns_cb_arg.done = false;
> +	dns_cb_arg = calloc(1, sizeof(*dns_cb_arg));
> +	if (!dns_cb_arg) {
> +		net_lwip_remove_netif(netif);
> +		return CMD_RET_FAILURE;
> +	}
>  
> -	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
> +	ret = dns_gethostbyname(name, &ipaddr, dns_cb, dns_cb_arg);
>  
>  	if (ret == ERR_OK) {
> -		dns_cb(name, &ipaddr, &dns_cb_arg);
> +		dns_cb(name, &ipaddr, dns_cb_arg);
>  	} else if (ret == ERR_INPROGRESS) {
>  		start = get_timer(0);
>  		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
>  		do {
>  			net_lwip_rx(udev, netif);
> -			if (dns_cb_arg.done)
> +			if (dns_cb_arg->done)
>  				break;
>  			if (ctrlc()) {
>  				printf("\nAbort\n");
> @@ -75,15 +87,27 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  
>  	net_lwip_remove_netif(netif);
>  
> -	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
> -		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
> +	/*
> +	 * A started lookup that never completed may still be pending in lwIP
> +	 * and reference dns_cb_arg. Hand ownership to dns_cb, which frees it
> +	 * when it eventually fires, instead of freeing it here.
> +	 */
> +	if (ret == ERR_INPROGRESS && !dns_cb_arg->done) {
> +		dns_cb_arg->abandoned = true;
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (dns_cb_arg->done && !ip_addr_isany(&dns_cb_arg->host_ipaddr)) {
> +		ipstr = ipaddr_ntoa(&dns_cb_arg->host_ipaddr);
>  		if (var)
>  			env_set(var, ipstr);
>  		else
>  			printf("%s\n", ipstr);
> +		free(dns_cb_arg);
>  		return CMD_RET_SUCCESS;
>  	}
>  
> +	free(dns_cb_arg);
>  	return CMD_RET_FAILURE;
>  }
>  
> 

