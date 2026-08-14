Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC6C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 533B460626;
	Fri, 14 Aug 2026 13:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogIS-nqItcyD; Fri, 14 Aug 2026 13:53:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C81E608DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715597;
	bh=BGGZ5PntZy9bp38WqGT1pu0HLWFdxCrrT3KDDHYd5CY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v649UD11u0XN+xquR1U0yz+nSP0Xd3a+U/NleNCzF+dyMjL2laRFccXf0/sodpw0+
	 0i6RMSTul3H3/Y+bernrP+c2w8NkXyuuUbk6ivVPlWxETIZ0X8h1NX3z5zuaurw/fE
	 vvhNT4fBK0JKLBODb97Dqf1j2iDlbh76GYDSz7jXslHW0RqeUFE5QEr5gN2ha9+Dyo
	 oExOqHWqTEozqGOxGCxECOuhqfjYt46SCE/nyUvVHC31MCm/WcUuQI/utiq9NrfD65
	 yoHcDs/HMZXI6Oln1mYK5lPGSnFCJInCth+0qBKJ/25USnZw22DqdtSpoTJoF+uciM
	 U9Yc/YTZBqKwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C81E608DF;
	Fri, 14 Aug 2026 13:53:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B505139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78FD2608CE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXtvvvtnIxlW for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:53:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 11DAC608F2
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11DAC608F2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=pgBW7qmw; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=pgBW7qmw
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11DAC608F2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:53:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jbwZE6y576FX7VWZVJhD1UtLSZU/XbLL6vX8OLfaBYXYirebWcgSr5m9UpGPml/m2D/fi+KEjQECf+zXJrNUYlPecWOR0vfzrtgOFXSR8m8L6QD0UO+OL1jCINssSBi1Cyjk3z868P2KaMff84uX9SAcVMHxRtuLRLqFfK4qoinung8mG+jq7nCZ0NO/CVXDZXeEEkN7RGvETKBwwXEF0A6zq0n4HYslSDPeG1Ltfs4gIm5g6LepbX7AKr6b0yUOSyJjil55P82byaf3q/LlZFm8WIe9dmy3QgrjOc3GoVSGVvKZaqDXoikn4YzB6h1orh66DMXWAzohub0CMWBnzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGGZ5PntZy9bp38WqGT1pu0HLWFdxCrrT3KDDHYd5CY=;
 b=D2OkyjqR9ibkX2+Zv7/K7cEIZgFi/T0woEhDC+EUkswp3wbWRj6UWkmdg+SiZBZOsAvVHEP9VQllT1vrI/XhoUXhZqwlXXvEi+ixQ40T4T1W7JQyS0UjOP7aUVxPr/oosw6Lmxi227ral4k4FlJoGMPTiCecsXBhbM5uBZq/IX1el/GVHR6qvWGd47VZet5nrrwkSk993XPWU62rzM1K7osZFM3yfHy0auhf7u5JR6xRmP1W19WtHRj613RXE2EHJg/Tu+vxdLp3vI1ryalMFqmJFIcO+RKCrunLFiYtVebytRahW4QvZ69ijb6RhOKO5Bzf4qpf6yUD2kLS6PkldA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGGZ5PntZy9bp38WqGT1pu0HLWFdxCrrT3KDDHYd5CY=;
 b=pgBW7qmwws6VCH2Vko/7JWRD1Q8YRofwa54IP45rvUGLpi+54WqsOxK0WSilLKehhQL5Wab4cYGzi5L5+KHF+At8NYjMuxwVi/qiJQOZhqKylu42vC53j0cZIbnC/pL3E0hy/Ou7lYYY6PqEO4YU+wjreCKjf4DfchYEplfbKiQ=
Received: from DU2PR04CA0284.eurprd04.prod.outlook.com (2603:10a6:10:28c::19)
 by VI0PR08MB10448.eurprd08.prod.outlook.com (2603:10a6:800:210::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 13:53:07 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::9a) by DU2PR04CA0284.outlook.office365.com
 (2603:10a6:10:28c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 13:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 13:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ornD6GV35+fFvOBc96qaqGLJ9H4VLe59gYuacoo6Cr7IiPLVGBF0EOz/wPAOfGIhM29LVxApE1cndTSihxNR2REiZmuXH/ED2XnZyd0RLaCubIS02cZ5848O7Qs0wyy+vR9onbcnvRcMFJwhjI+gdxUUnS3wWodyBpEwkwu3IwU/EFZCIpE7Ed/yKn77NdvhsIA/uOV+J8lweYKvATePGvToNvN9RjM6t3ShxN7BeB9r08PnTQBy2H7cQNO3lUr5nmfiwK/ovcgOXf+pKs3JqJ6qOzYinuHuhpSNHOb06wIubysfCVkNp0SC1TkrfYwonEXb8L6A9j9DIOGrRaFMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGGZ5PntZy9bp38WqGT1pu0HLWFdxCrrT3KDDHYd5CY=;
 b=kq3GyAQOWdUM8bP+EAHgusB16LuNSLCCQA9AkqCYTWemc70gUW9ZFZa+1U2G5Dv4j51c0sQ0+btv83ehnXNz7ngwlbOCsD46E50XN9O2OHXL5Nd2PAN6x9i4SJPsoJZFYmMoWgVSV0brgRqrNqg0Bp69CnLzhqFVT15zrOgKhWiMA4Cn1/ql3/9hpoRNyoKXg01CRUUXAGr0kNp7WzmANMV4JErVVbFnr1VNhKqSA2+mFmrMWtTGjRCWGHXNFPFQwQCWK5OdCp+I2g8dvS+XlsptvEGXIXTNGcD5rkzmo04xB4h7t3YaqtDAL2tyUha/yCK8rp+CYZYFuq+CR8yUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGGZ5PntZy9bp38WqGT1pu0HLWFdxCrrT3KDDHYd5CY=;
 b=pgBW7qmwws6VCH2Vko/7JWRD1Q8YRofwa54IP45rvUGLpi+54WqsOxK0WSilLKehhQL5Wab4cYGzi5L5+KHF+At8NYjMuxwVi/qiJQOZhqKylu42vC53j0cZIbnC/pL3E0hy/Ou7lYYY6PqEO4YU+wjreCKjf4DfchYEplfbKiQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB10210.eurprd08.prod.outlook.com
 (2603:10a6:102:367::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 13:52:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:52:33 +0000
Message-ID: <f8a92326-bca9-4877-871e-1cd767852ed8@arm.com>
Date: Fri, 14 Aug 2026 15:52:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: lwip: wget: return ERR_ABRT after aborting
 the connection
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
 <20260813-lwip-httpc-uaf-v2-1-1c3f0b3aa1eb@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-1-1c3f0b3aa1eb@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0239.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB10210:EE_|DB5PEPF00014B9A:EE_|VI0PR08MB10448:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cdd576-4583-4d1c-68a9-08defa0b5e5e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: Viyo0IPPONBh6993VewXUOtMhn5PPDmVe+SHLbfM+XqaNLuL5Tep5nA+l2rm/wq2vGIOpP2o0llSJmW37DKA+gZ99fRvaCc4JIZcSCO4iWcwN92/JTrjwWTdNfrpHaLNU+TSHhJTlgeVfWijIE0AylhmEIKszFNi7H2bXHwMZGkvmMWyNcob1t87hLmjH1JCtpL4b6xeslNoYDc28tfrwnz9fRZmkZ44dgcMl/P2sIe+dJNSFx25v1c2WZD0emNamWPi7uH3P+oDJluImVkyQ2oGepEirO76C1Pl2ZM1fMq9TAaL1DXCIBdoSpLEIxr49L5v1F60McO+v6gvmpvDVphesV27XaoWyhxymU2BO9ko4KBdCP0/6nJ3lXbJz7edQbIZsIpDQ34NjNP+mhoHLm+zzcQd8PCTAaQy0Vh3T5fkEO1tmxFJagBNCYQg5PTBzmVUv90fWLy/xLRyorZCQubVlrEfAEjNMX4G6u37Dy+bSgRY/mfQ0vUMB2hd2MR8IkVci7lWZlcGnRvL5EsNvopQZ/505hnCzMVxt3DpSTBuSiCxksYab+aNGO9uy3ZflrWNUlfS2HHrJuZ90RGkE5bKqxIJQBEDUx2kJz4eZ9PGVAJRTjHRQhjl0SwjKkA6tyeJavH7Oe3OyZ0hEzFlisRvgM+axHyMt7znaCY0n5g=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: b7tA12lgwAgtV/OTKniF82z6QokKax/Q9dAiaPgKJuS/VntA2kzJ3mwKJcDzgkEL/DJ6qkOT7uBlR3HdcU6rthfvd4mdZG9su+pdbUKHAwS1wvIxb9jvKPn6LqRnSqPGNFKK8E3xE2pLXv2CmwSP5b8dSl+TVR+w5Jsk+5nywWIcQ/3OshU+fNYNLhGKPeFVHP6SN9O61KkiTJfbOAmBp3BeWbwr2ASFnGzJr0WVbmAt2MQ1Oy9cdugzSgVRQKEj0kytrgSZKbkWrzDywtJXoMuONIElArNzFuBH09AcRB8kLGgrKfrwNpEcbG0iPbll11gSrqEH9N/5oxj9iz02fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10210
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: db785abf-22f0-41d8-6593-08defa0b4a34
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|14060799003|376014|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4x37sKH5c5IhPR2VJTEDMVu+f8DMwE6wN7PcIXgIBKr+iiS148DPgZlysf7DLtuvTKqWo44F27rnnLTsi8hD9plBSDEnGDnI5GkA7P+baxI1BRuMCHHLFBlzw4g8opuN6g5yyA1EdSzDzBR+k6hqSqmlsJkQ9PeWtumo6PNbFCkzdvZsG1bhhqHUXDBjoTr3eBElJdHkzgwxQxact2ZiLl3TrBVamO/xW8JrqwuzHCbpq76kxxTbK/ciDBBVOod5S7il9UwPH+TdVPAlunuJ9zwGGUZlNsP6oZ6WfW4N9ffKMcWI2xwBI9FyfhJG/Gu3Cv5vbd6JaQk/hytErKqyJWPbibMyNR7tfvJCj8OPA+L/vh5Zn6cEb62U1dZ2J7hsFoYiMNYrQ/rTDkJMKTFwxbSeLTSQHiJU+LScPBp3FnE5xWIqofFfr3VWVjrIGgrLGm0wDarlyOtuw6GBXHKkie9WD5NxiIWXLMrvQXn7zQ2A1ZLpg80UiEYbqpuozLpDEs/4Vda07ZxjBGfmHw8lnbiNTSlC/xsWuU3hWjrC5t6szWakEQzOIZvBAbKdK/iCHWPsgdzQ+UOI96nCizzrCQ13N7t3InJJlpDZwfFlb9FD0sUkFhAhZ/cm0BhcL+N7afPUT2ccen1qDWhdxeSzBo660WWva8z+iK2nicnXjqy4itZ0PKgtPJYc8QGOcSflGG/o0RpfADFiIQTOUS4+vQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(14060799003)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nL4GWZD+181UHqvnZPwXvEtjUAQnKgsqxCtzODCjH0ySse0QedtRnrLPbdDUxAqv1Jcqh+pKAjvFVRuLr1VkXtaIDelNjyx0f8wblejyUd7uJHC/AHeLwxmCcj3CsesyR3pGMKYd19Pl+LOWtnG3FelJ8kJURR+fIaA2JOFXqD0smncDYftpePM144KnKzGZJNgfs/wnfyWEBbaqsMuKWCJc98xzktfJh3V9wX4gp2PR39/xQTVFxOmByLRNy6mtJzta5PM3jgNtHy9/vEeW+KF3FR0x4gDPf7Rz55UWpd/c8uclY9EppxmQiSqRi3wUCx+VEnbHlKwJLespuc+IbVzTiomdvjrfPVwQzfLSRw/rOBjuQiIhx3b5P04PCtpjk6mrIA98SaSp35imjLyXLLszqk07/iHdJ1hC11pJDoysId46XCE2QtoTqtvU0I0w
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:53:06.7013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdd576-4583-4d1c-68a9-08defa0b5e5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10448
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



On 13/08/2026 18:28, Shahriyar Jalayeri wrote:
> On a store_block() failure httpc_recv_cb() calls altcp_abort(), which
> frees the pcb, and then returns ERR_BUF. lwIP's receive-callback contract
> requires ERR_ABRT once tcp_abort() has been called. On any other return
> value tcp_input() keeps using the freed pcb (for example it stores the
> segment in pcb->refused_data), a use-after-free.
> 
> Return ERR_ABRT so tcp_input() stops touching the pcb.
> 
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  net/lwip/wget.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 247ece18e2b..9e93765926d 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -205,8 +205,12 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>  
>  	for (buf = pbuf; buf; buf = buf->next) {
>  		if (store_block(ctx, buf->payload, buf->len) < 0) {
> +			/*
> +			 * altcp_abort() freed the pcb; the recv callback must
> +			 * return ERR_ABRT so tcp_input() stops using it.
> +			 */
>  			altcp_abort(pcb);
> -			ret = ERR_BUF;
> +			ret = ERR_ABRT;
>  			goto out;
>  		}
>  	}
> 

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
