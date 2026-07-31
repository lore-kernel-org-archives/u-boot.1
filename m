Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2FFC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44F2E60B15;
	Fri, 31 Jul 2026 14:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FickF7bp3sE; Fri, 31 Jul 2026 14:19:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 704F560642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785507581;
	bh=/95iRcEL2l78yLrkX/Toc2x99EmqRuTkMd2S449c4JM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6czC9slG6/ZWp/fGInNHsNYTVmPoob2ZtZ7o1Ezfs1vY+LGDtx1UlUS6tjvwkCAH
	 8h86JJkYLyvwZVTja3/v9qtzamUzxx8HGXn+rShGPYrxNUGy1pB87Kvvb7yqGTYvBZ
	 hpvggHVh/dfAuABLGu0yz5vV632RCjrXF7S5sZqUUviYJxGojAWSqeuUMXwng/nhso
	 A/yiT46MX+v2kw7LTQNHAJkFckUdbFgdX0R9jVkJ2C7gqJ2yyOF6XUiyBBG2hVppeW
	 418XbUX7toyS/h6A4xUYjv+b0qjAbyAVzAHYLmOXBDVptxTiP9zJVGfb6nXKcdk3M0
	 DXNOquECnnbyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 704F560642;
	Fri, 31 Jul 2026 14:19:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E4A537F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42F5D410EA
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3uLf0aFfiBnC for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:17:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BF1DD410C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF1DD410C8
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF1DD410C8
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:17:43 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pC5b6kMMn9PQO4ePbl1ms7fiqyhzwvP3wY9JTf8bs0Bcv8iwH+pTRSvfKQcTbihu7Mh77gayQud2+l+g8rlf7LzJddQVVOH3lkRn5AUihf4dvTVtWueaceULhS8aC58ObTPy1bDEHJbl36QmBPCp3CSxxW4I4CalySeS5mEbeEblEUDLf4RPsUodGcwJK9OrJeojnHHZPpH7MZ0bLY7WMeZaEYQIvMYH0h2VYVw7djs3r55lH+1BEpiu1kSOXU9BvkpeHzl6PF5r4kBNv50vniuDQj2+HK0cs4SJhJdVu4tt4RH/cdbjvXt0FLi60/zBxTc/AcFbcy8eqfYtwj161g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/95iRcEL2l78yLrkX/Toc2x99EmqRuTkMd2S449c4JM=;
 b=xKc5nBPTtT+Js0eLc/zYUk2S9Eyqot61M/SmUl67f0akejN0m6J6om1r/XihoBHSHJ4BxNh48qFiEByWhSM572xqFSsAEIbJM7WH7cO8JA2MedmlQNvtR+sMjMncQHSegZotd/qHmzzEscVrfkb8VRmQJl9ahflepxgw77aV8FaEfHgnfj20W1cy0F7+vZGaBCwUSVzsmDy4AhtqutteK96L6uJoyCaRf0q60+k6EBbsnwqsD14xaqmgtJGdbQ4UMNReyEXxYpvLaq1vJ3duo54A6YPvaSCOGppqsHpzKXlJONZaopUQ1aRC7stbFRhopy7ZZWWz0U7/D1diLFnVKA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS9PR06CA0382.eurprd06.prod.outlook.com (2603:10a6:20b:460::11)
 by PAXPR08MB7465.eurprd08.prod.outlook.com (2603:10a6:102:2b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 14:17:34 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:460:cafe::5a) by AS9PR06CA0382.outlook.office365.com
 (2603:10a6:20b:460::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 14:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 31 Jul 2026 14:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8qlzCUW4lhpLpi2IMCUGTNHaVXv+uMXHny3GPl0KImANmqzA5JOEudDCNPWnIlFsodi91Ko843kBIGJZPz2ap4dJWykpMVZVSesoiDNJCuZ7hzJj+HxzmvHmmsiycBKm8yfHraFwEGQ/xmDAy6wTFLlxW291ZGZtkLCkOXztk5QY+dOlcCl761lCPSQVy2U4wmVRB18hR2H08gbRSglvp6xJFCtGrQhcPICM0wsydA3llHvyk+s6E32pGsQYnHyNyhKajvXQv2t7F1dFWqmUsRnaOIKxOMmtz90YTUKFXlyAH1ejJ/4Timi4OIFqkvLY1V3llKoh9BZFcPEV1yJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/95iRcEL2l78yLrkX/Toc2x99EmqRuTkMd2S449c4JM=;
 b=XZZP/LUzDNLlMNrMZuWhh0j9HdsuJzNbNJ/s5fYxf2oaAs5vKl0XvzfL8oc5UYu+H/KImN/AE1fMHVR+n1pLJd6ur2HTXO9Xc9UNyCHXN2bs83EDsTgY4vQsExFRQjRC4wUhXDSXGzNs/EUmh16ZwmpOIltDUt/pLj8SAbKGJ/YvPC/McR/x2R4tIeYtYtbRyJWJqzznAUrHacFlC/mNu1NBLV06wpu6PL4gff1nVukjWYwDgpbywWvoymu58/uBW5eVgW4Bm/bXmOgEGzHhiWc7DCB8n0bXSg75rGE8qoZWxOP58IYCzOjjV/qBDm9nd9YiTmqiHlDLsKviYkSKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by DB9PR08MB11546.eurprd08.prod.outlook.com (2603:10a6:10:60d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 14:16:31 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 14:16:31 +0000
Message-ID: <b4f8d148-ae3d-43e9-88b7-1362608985d3@arm.com>
Date: Fri, 31 Jul 2026 15:16:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 u-boot@lists.u-boot-project.org
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
 <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
 <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
Content-Language: en-US
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::16) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|DB9PR08MB11546:EE_|AM3PEPF0000A78E:EE_|PAXPR08MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1eb8d7-5e0f-4f12-9d58-08deef0e7786
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: VxLnP+ghoRImTWkbA8un3q4DKorpiNxzWUC1snqEsJ58ixx6CRL67pxtJQHL0hA2U+HqIWxxjrD5KyxLejgabaRzxXJPn/w7II6Sc4arMYTFMW185f0Wt+kQQr2c6Kx/Fpai3iYF+eaZgyQljGim31CWOTAqtLvDWOmlvaclhCDFAKG0IjIFvQhTrKbsC/cn9TRlTU2KU0cuPvuWX6fcJoPkKdKQ1jUP98TgDiMpGVxw605tntA7s9ysBWdoMc9Nm+Rk/UW036aXs60dlJCAtV3sbOOoHsy7TTQPdSrJUUKKtu8BfTw8k8vpm6D2Qq885NxUXhrvOvIpxBG97THNSkpgjYO2ht7V75UiM0nzHrqe1k5MSw/hVcPOMD9HGNsjAoyDzNBRV4+rSeKW32Ee4AETwV1EJ4G07uaiRQVHii7q0NsVEWGEnFMIOsCTVU/s4T2Vawr3kQSB1gJV/53k5LhRPlbrNik8kwE7DrqgpmuPuvPfgZ4brGKgFJE56S4uC4I2rsJahUOWn3ldp0eN6dBei1RKbQFj9My9WoE+RBfvEI4GqFospyTopHcqUA7gZKa9+GH1bcQ3BhJNkepFZ2Vvk5DIkCzcqSL9v2wRigTcaYnDQLZF225Jvsfo5d7E/ejKOiHG9sG9pZhqT+aj+ATfi8EXTtR9jjXaw4x/kMI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ELanUmDJioCe+ICP0vy5HqJVVvUj5pIxNTn9ATnOAt1ktZqJdEBlM0gNQTreZ4Bnz2HYdklLPf8UX8qNiimM+UXvl+i1IJRJVlZsfQZ/i1K6wtj9zKXOXN9poOioJKBjTR1DiSCwJQLNKZqWugr1g1OTnox7OTwoRJKPTEJUnPQl0jfntuORylbRyWCZnnCGzwyjUVxPQfUt5rdU4qoJxPcbtdhJUH9rppTRyofuQPbTBKwHT9w3f9ALzNOgMpo6REbhmXYRRh+buHnBNQ2brmVYqrKfA948dIOZbxzxYRHMSPNC6t/2CB8DX97dycRSLiI+j0HiFHbUKpP6AZ1ZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11546
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f61698f-1d13-43ce-1e97-08deef0e5187
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|36860700016|14060799003|376014|82310400026|1800799024|13003099007|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5JxF6u0xPadeLTRZBD3XsTLGOaN5s7IR5BxCSVU42Wq8A8pcGbNLbufkrBcGLJdb6UxQP9+heseLa386yVUU4xvca8ihebgXMiHnGqtI+z93oK0j0xdii/cf8dFIjnpxSc8Trv+lrFOarRIeRj85yVVbRSus9donLgBU8yC78DxT2Stq9OzPYNeJzIXL1uv9VpqpVriVEQkuXNDRGLT7D23Frr6mGc2lflN10Whe+Gx3b3vhN/smKQQteh0qBISp6k5pp4rSNSq5YSqKuKS+P/fuXGdb72aOycoVJy0TWUyH7QRwoGSK3sADVO33t1FFG938crCmjrgzLScE8puh3ntImpHz+Rp6Fg5FM72rznOMfa4JpSzmXpTXx8BU4xjP4NG+KN+dhTcfvFouBWX0bF+KuNf7HfpduHDp3OlgXQ1I6cLVMNJ1AqmSm7c5VSDyZCsZsDycjDUMIAOwJpwSMOMDUh9hfXWj8e1a+51NwtYHqAu8E7BqhVl74z7D3Ro9pvMDThjK/Yv07fXLBKCJVG+mwJpWbhzBzx05GVZtSaWFOC58k38b8TMWEqOElHkrhUPL1pdnT2JSO3aknRN/zJkI+fsm+P5tau0tuDOzz7pEq5RBbHUZOBzCA82YXv0kxAPDPLsbQGCUCmZRaI2ZyVpYGeVmny8g+BHrhHPVqgDK/jQ3efNOzassnJP2TTX2LHOPurvlXcZRVQ6Ql7PfVA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(36860700016)(14060799003)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6YEfNq1Sflazm5fPk77Y6f4m6u9Wtb22RJr6qDuozN6btY3qVFOdXjNYcmO8g7uTh/DYiiDRkijYRqHVb1MR+3T7dS+MjaB5lYHqGxJ/IVsAo285WMEXRv3e1Bq7BRvSOr1C1cXxjup4FSJVKmiFaXVsnkPKpEE4psmBPQ6liBRcILjFcYwts40irdDilc01v3ehYwuNFM4lKGqxrVxRXKbKZAMM+S3+1B4GpwcDLPDJWDU4uz5/WzrIHZX62UwnqpUX6WuNSlSdINqBn6rrSU/WApp3m3sQUPkbtDyqPC7RnMcnhQOo4uXPQ0W0GIpde/cFKHuAxNw+sxfb88SALfWL9GX/T2LIXYc5DeV6tORg1C23ioqQiKLoM30V7cJRwdWKzcDGYKeZ6zQKfzTNatXHw1eZ8+porpdXYmcKkfMaVu7IDdlV+6BmXmIP1MKU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 14:17:34.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1eb8d7-5e0f-4f12-9d58-08deef0e7786
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7465
X-Mailman-Approved-At: Fri, 31 Jul 2026 14:19:40 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/95iRcEL2l78yLrkX/Toc2x99EmqRuTkMd2S449c4JM=;
 b=JMgy5MvtQwg+RIYf1nvD5qN6C2SwCRJwrEuCOTzpr1rBOox7RLSv3Ttf8CP50Z1YPpaN9kWI45g8aJRWj6VLMSvJNV6uesz9Gm8MMQF5FDHckSaCyCVaT6FppPR2W4XaaDxZDz0JZU70ZG1rVBekhdCWuNrdS8vP1GOTC2LtiF0=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/95iRcEL2l78yLrkX/Toc2x99EmqRuTkMd2S449c4JM=;
 b=JMgy5MvtQwg+RIYf1nvD5qN6C2SwCRJwrEuCOTzpr1rBOox7RLSv3Ttf8CP50Z1YPpaN9kWI45g8aJRWj6VLMSvJNV6uesz9Gm8MMQF5FDHckSaCyCVaT6FppPR2W4XaaDxZDz0JZU70ZG1rVBekhdCWuNrdS8vP1GOTC2LtiF0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=JMgy5Mvt; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=JMgy5Mvt
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

On 7/30/26 13:12, Ilias Apalodimas wrote:
> Hi Peter,
>
>>
>> Hi Ilias,
>>
>>> I'll be off next week so this is going to take some time for a wider re=
view.
>>> Since this is quite a lot of code to review, I'd prefer being able to
>>> test all of the cases to make sure nothing breaks and add more
>>> selftests in the future. I don't have access to a Corstone-1000.  The
>>
>> You can get the Corstone-1K FVP here:
>> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/index.html
>>
>
> Ok thanks. I'd still prefer to have this on QEMU since we can
> reproduce all the cases there (variables in RPMB as of today + the
> FF-A variant). Even if we do use the FVP, I'd like to have information
> of how to build & test this as part of the cover letter, since Tom
> includes that in pull requests.
>
> Cheers
> /Ilias

Hi Ilias,

The instructions to build the Corstone-1000 FVP can be found here:
https://corstone1000.docs.arm.com/en/corstone1000-2026.05/user-guide.html.

For the QEMU/RPMB/OP-TEE question: QEMU RPMB would cover the storage
backend, but the FF-A runtime transport also needs the secure world to
expose the MM variable service through an FF-A secure partition. OP-TEE
alone would exercise the existing CONFIG_EFI_MM_COMM_TEE transport, not
the FF-A runtime transport, unless OP-TEE/SPMC is hosting an FF-A SP
that implements the same MM variable communication protocol.

For Corstone-1000 we are already using the Trusted Services SMM Gateway
SP. That SP implements the MM variable service and exposes the MM
Communicate endpoint over FF-A direct messages, which is the path used
by this series.

I agree that QEMU would be better for wider review and CI. I will have
to investigate the QEMU setup using the same SMM Gateway SP along with
OP-TEE/SPMC and RPMB, so we can reproduce the FF-A runtime variable path
without access to Corstone-1000.

Do you suggest that I investigate this QEMU setup for the
next revision?

The setup I am currently testing is Corstone-1000 FVP with the MM
variable service exposed through FF-A. The FF-A runtime path is tested
in two phases as follows:

The first phase (setup phase) creates the non-volatile runtime variable
before reset. On U-Boot prompt:

corstone1000# setenv efi_selftest 'variables at runtime setup'
corstone1000# bootefi selftest


Then reset the Corstone-1000 FVP and run the second phase.
The second phase verifies that the variable is available after reset,
then exercises runtime get/set/append/delete paths.
On U-Boot prompt after reset, execute the following commands:

corstone1000# setenv efi_selftest 'variables at runtime verify'
corstone1000# bootefi selftest

The testing steps are documented in the bootefi documentation commit:
doc: bootefi: note two-phase runtime variables selftest

For v5, I can add these tested steps to the cover letter.

Thanks
Harsimran Singh Tungal

>>> latest version of QEMU do support emulating an RPMB device. Would the
>>> changes above work with with an SP, QEMU RPMB and OP-TEE?
>>>
>>> Thanks
>>> /Ilias
>>>
>>> On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
>>> <harsimransingh.tungal@arm.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> This series adds FF-A runtime transport support so EFI variable runtim=
e
>>>> services can communicate with the secure world after ExitBootServices(=
).
>>>> It also extends tests, documentation, and Corstone-1000 configuration =
to
>>>> validate the runtime path and keep boot-time behavior aligned with the
>>>> runtime flow.
>>>>
>>>> Changes in this series:
>>>> - Add EFI runtime-safe memset helper and FF-A runtime transport suppor=
t.
>>>> - Add runtime-safe FF-A direct-message handling and ExitBootServices s=
etup.
>>>> - Implement FF-A runtime communication in the EFI variable TEE backend=
.
>>>> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName=
(),
>>>>    and QueryVariableInfo() over the FF-A transport.
>>>> - Add sandbox FF-A runtime transport tests.
>>>> - Extend EFI selftests for runtime variables and enable bootefi selfte=
st
>>>>    on Corstone-1000.
>>>> - Document the FF-A runtime transport and runtime-variable selftest fl=
ow.
>>>>
>>>> Changes in v4:
>>>>
>>>> Address Ilias Apalodimas's review comments:
>>>> - Split FF-A bus runtime support into smaller patches covering runtime
>>>>    private data, SMC invocation, direct-message helpers, boot-time reu=
se,
>>>>    and ExitBootServices setup.
>>>> - Split the ARMv8 cache range-maintenance runtime annotations into a
>>>>    separate patch.
>>>> - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
>>>>    GetNextVariableName(), and QueryVariableInfo() support into separat=
e
>>>>    patches.
>>>> - Replace MM SP status macros with an enum.
>>>> - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
>>>>    enabled.
>>>>
>>>> Other changes:
>>>> - Rebased the series onto current U-Boot master.
>>>>
>>>> Changes in v3:
>>>>
>>>> Address Simon Glass's review comments:
>>>> - Move FF-A ExitBootServices event registration to the end of probe an=
d
>>>>    clean up RX/TX buffer handling on failure.
>>>> - Rename FF-A runtime-context helpers to the ffa_runtime_context_* for=
m.
>>>> - Rework FF-A/MM cache maintenance to cover only rounded request and
>>>>    response ranges.
>>>> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
>>>> - Document FF-A shared-buffer ownership and alignment assumptions.
>>>> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
>>>>    entry points.
>>>> - Tighten sandbox FF-A runtime tests and reset runtime state between
>>>>    test cases.
>>>> - Update FF-A and bootefi documentation for the runtime transport and
>>>>    split runtime-variable selftests.
>>>> - Rework commit messages to drop redundant information.
>>>>
>>>> Address Ilias Apalodimas's review comments:
>>>> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
>>>> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
>>>> - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
>>>>
>>>> Other:
>>>> - Fix FF-A memory-share sender_id to use the runtime private endpoint
>>>>    ID after rebasing.
>>>> - Fix the expected QueryVariableInfo() return status for the
>>>>    TEE-backed runtime selftest path.
>>>>
>>>>
>>>> Changes in v2:
>>>>
>>>> Address Simon Glass's review comments:
>>>> - Fix efi_memset_runtime() style, declaration, and byte cast
>>>> - Tighten the FF-A runtime context failure path, clean up arm-ffa-runt=
ime.c
>>>>    style issues, and move ExitBootServices event registration earlier =
in probe
>>>> - Add shared-buffer bounds/alignment checks, and tightening comments/k=
ernel-doc
>>>> - Document the FF-A shared buffer cacheline-alignment requirement and =
add
>>>>    BUILD_BUG_ON() checks for the address
>>>> - Cache attributes before the shared buffer is reused, moving the read=
-only
>>>>    check earlier, and split the u16_strsize() related change in separa=
te patch
>>>> - Reword commit messages for the runtime helper relocation
>>>> - Rework the non-volatile runtime variable selftest into setup/verify =
phases
>>>> - Extend the sandbox FF-A runtime tests with no-context coverage,
>>>>    runtime-context reset, and separate errno-mapping coverage
>>>> - Refresh the FF-A runtime transport and bootefi documentation
>>>> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
>>>>    boottime capabilities in v2
>>>> - Squash patch 8 and patch 9 from v1
>>>>
>>>> Address Ilias Apalodimas's review comments:
>>>> - Reuse common MM SP error mapping for boot and runtime paths
>>>> - Rename runtime-phase tracking to reflect the ExitBootServices transi=
tion
>>>> - Collapse duplicated boot-time and runtime MM communication helpers i=
nto common
>>>>    implementations
>>>> - Keep the arm64 cache-maintenance path runtime-safe
>>>> - Move FF-A shared-buffer runtime memory-map registration to the end o=
f
>>>>    variable-service initialization
>>>>
>>>> Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-ha=
rsimransingh.tungal@arm.com/
>>>> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-ha=
rsimransingh.tungal@arm.com/
>>>> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-har=
simransingh.tungal@arm.com/
>>>>
>>>> Harsimran Singh Tungal (22):
>>>>    efi_loader: add runtime memset helper
>>>>    arm-ffa: store boot-discovered runtime data separately
>>>>    arm-ffa: add runtime-safe FF-A SMC wrapper
>>>>    arm-ffa: add runtime direct-message support
>>>>    arm-ffa: reuse direct-message helper at boot time
>>>>    arm-ffa: enable runtime context at ExitBootServices
>>>>    arm: cache: keep range maintenance available at EFI runtime
>>>>    efi_loader: add MM SP status mapping for FF-A variables
>>>>    efi_loader: make MM transport selection runtime-safe
>>>>    efi_loader: make FF-A MM SP notification runtime-safe
>>>>    efi_loader: make FF-A MM communication runtime-safe
>>>>    efi_loader: reserve FF-A shared buffer for runtime variables
>>>>    efi_loader: enable TEE runtime SetVariable() over FF-A
>>>>    efi_loader: enable TEE runtime GetVariable() over FF-A
>>>>    efi_loader: enable TEE runtime GetNextVariableName() over FF-A
>>>>    efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
>>>>    charset: mark u16_strsize() as __efi_runtime
>>>>    corstone1000: enable bootefi selftest
>>>>    efi: selftest: add runtime variable tests with non-volatile storage
>>>>    test: dm: add sandbox FF-A runtime transport tests
>>>>    doc: arm64: document FF-A runtime path for EFI variables
>>>>    doc: bootefi: note two-phase runtime variables selftest
>>>>
>>>>   arch/arm/cpu/armv8/cache.S                    |   8 +
>>>>   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
>>>>   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
>>>>   configs/corstone1000_defconfig                |   3 +
>>>>   doc/arch/arm64.ffa.rst                        |  88 ++-
>>>>   doc/usage/cmd/armffa.rst                      |  11 +
>>>>   doc/usage/cmd/bootefi.rst                     |  31 +
>>>>   drivers/firmware/arm-ffa/Kconfig              |  11 +
>>>>   drivers/firmware/arm-ffa/Makefile             |   4 +-
>>>>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
>>>>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
>>>>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>>>>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
>>>>   include/arm_ffa.h                             |  16 +-
>>>>   include/arm_ffa_priv.h                        |  22 +-
>>>>   include/arm_ffa_runtime.h                     | 191 +++++
>>>>   include/efi_loader.h                          |   3 +
>>>>   lib/charset.c                                 |   2 +-
>>>>   lib/efi_loader/Kconfig                        |   4 +
>>>>   lib/efi_loader/efi_runtime.c                  |  20 +
>>>>   lib/efi_loader/efi_variable_tee.c             | 739 +++++++++++++++-=
--
>>>>   .../efi_selftest_variables_runtime.c          | 715 +++++++++++-----=
-
>>>>   test/dm/Makefile                              |   3 +-
>>>>   test/dm/ffa.c                                 |   6 +-
>>>>   test/dm/ffa_runtime.c                         | 123 +++
>>>>   25 files changed, 2004 insertions(+), 498 deletions(-)
>>>>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>>>>   create mode 100644 include/arm_ffa_runtime.h
>>>>   create mode 100644 test/dm/ffa_runtime.c
>>>>
>>>> --
>>>> 2.34.1
>>>>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
