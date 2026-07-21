Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070C6C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05F1260822;
	Tue, 21 Jul 2026 09:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ucnSr9-cEcAN; Tue, 21 Jul 2026 09:08:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 064C1607FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784624930;
	bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EJNLxPBfi+lQ45RqoWmVG/hSJl2GQiEtUDQRksc+4qagm5DdVQvPsnErO084+B4Ax
	 xjGET6tyG7rrSD2TWid3n44pjJO0/eUGv28ylu2d4XMvgrhuxdHt8/u1174woJ4JzK
	 P0Y75iTD1WOFP4OPzXi6mUd9xZVDkwxbiD3sm943K8cCpe8NOnDQYoSY1Hn0GPyeEj
	 89thaxoiBFjWnEbJ91Rg2nJT6cYHDBVicXMXBtU0Iis6CHX2K662FYvmj2myEW9bW5
	 lpNGQvwSSSLA0lK1Ff78uFOAwiJ/cvEf+yNZuUtF9K19lMA8IsKHKsiKNcat87rz0v
	 YNbMXbE2ZAyGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 064C1607FF;
	Tue, 21 Jul 2026 09:08:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AFF9109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FC7440869
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30FCLos__u5F for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:08:47 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 31DB240863
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31DB240863
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31DB240863
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:08:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD92844F6; Tue, 21 Jul 2026 11:08:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41627803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:08:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0x3Xjg8fzvIO11ljkv+KsyL+iGMwE1dMvW/+0131PlLDddusrUgxsnYQ9OOWwtAssXiEADNtfWfxVKQVBtM6aC5sA3lD0fWeNJ/aCMMKwnWLFc/v60DRUqu996S0KDHCi9LQLEL23YK7gFKk+Mx1Md83MhuV4sBoDS4qPjFzGv5IUtLjfFCbHFnCjD0pmshZNAw1bLn5O2kPM5w8EUkO2tqnnR23rtfB1vDHGOBYBWMiIJox+98i0O1VSHiXvuWlCIpp5d9BGXTPGnJEn9CjiEWtlzNewdpOmiaitY35jRiMvCU8hGLOUzSY146l84CoKMYJah5FLwQOp30FcjTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=ExWTo1BjYa3RGEFdfKWSypQmn8wX2QvfALJhed15REeviKtlEK/7pBcqe2PIbTikjLKWcYFIx3QdJmsyNM2G2bo/Y8ReH5q5axgYFJZdpdD+UFQVPtDVrCJ9TS4CsdHneG0v2ACrlrxuGrnUocEuaofeBhPg73X20jM15uhCPV5f9fwMAr7qL86hMyp3zDvofLLaUSuVL5xwSThFq5QYEuYNDGc3bRzMxpu3HCy8YpTLLrkBPzoQxIoxW+oVmuxCusLiaz+YVOrZUZTMEvyCHMgH2OeH5oMKxUdzH8qWriusj/TOOr/R/WXJniScj6DPdzorDnRXdQ9QgScZUyf/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:08:39 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:08:39 +0000
Message-ID: <cbe3741a-5261-42f5-b983-f00d57308634@cherry.de>
Date: Tue, 21 Jul 2026 11:08:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] Makefile: Drop redundant CONFIG_TPL_BUILD checks
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0090.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: cf893e46-c85c-484f-0b55-08dee707a774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y+k1AYUCNuP2XEiv+3fWI1U8KqqN4v9S+8RRjL6Y3crRA7OEguqabvNZWJug215plUPk6jnaB52HBuv0ahap0XEJFumcuOMhq2d7HS6Uv+kVY7gYzGNG4hYfhoss78AoOS2iDLUQIpDrP2TvdYUnXA2Sy+HBtjU6G8GcnKExE1/tApvItVEOCehFh2sTrU/wJk//A5BA1Z4NWkpGaC8gRehVyI1enykn6h9jPHL9hAJtLy6RvWPvn7i+GmiTGj9VALb0QaCMtNvHQ/ADRfDWQts7neA7hkflhJAyVOgOx8uz45msG0JWvv7gULkPY7kdpc1Aa8Z6dwQaRaG18YpTdh1CAEr/qB2eS1+CDWgX2aiCCziytxV/IM0EzvT7UHUs9G5je/H134viYdAzE0YrvbSENdiJHxj/RW4civkkMHqlGbnZB9ro/6qzkzUZEJzH/ju4JL4R2st16T1XVjkcQu8kGFCZfwZx9Kw4RIbGK10bNL43AfRacEWd1jRvMI+cwgpU3LBzzL/dnmYcwKcb8fc8SRh8KiGT6dHvMvyXnLb84nulsLUXZIIMBHW6ansOFLFhws66Gt2oDXZgG/hVofc93IF7emuTXa6ROqFUxPjl+CM/yAJtQt+yMkFxccyDfF49sfRmGL1hVYBJqBMV5JdaVdEM7F0hhXcj/AHdcaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhQQ0V0TVBsOGkvYUdwa1ZESll0TWQxQUFrdGFwV0d5OWRBQUJrM29WUkRR?=
 =?utf-8?B?bnpBOG1DVHFYbC9GcGNYcmhzcXJ6K1ZrUHNET0lrSzFkUUxGNXVDM1BtREFz?=
 =?utf-8?B?RzRsY1FDVGlzSGptMnhPbitqeXVDdEdwMytnOVFjT2kxT3lWWHRzNDUycVcw?=
 =?utf-8?B?d1Z1Y1g1eTRLWnlZM3RSZktNaFdxS3hpdnNmZmU4aHNhOEp5U2xJMmVaVHRt?=
 =?utf-8?B?ZnFXeVhRcVZKenh3OEVVcVBQcUVJSFZVUWJkYm9GSVJCajFqdFBiMk9tdFlR?=
 =?utf-8?B?emNTdStNZEQwL2lPUFZNY0loQWJkZzJ2VU1JU2N1d2paMy94QVliYXpOT3F2?=
 =?utf-8?B?RWVFVkp2R1czNWE4SVhTbkp0WEN3ckVsMVpQV0daUXdMT2NHYnNDTG0xbGpR?=
 =?utf-8?B?NldRNUpMTzdXMlhFS1ppbFhpSjR6aWswTUp0ellHdEpWMGFPQVozbXNGa1ND?=
 =?utf-8?B?ZStHcXIyR3UyQk5pYW1xSmNCMzJQVTN3TWk2QStrSE96bk1PTGhCTnBUZXFW?=
 =?utf-8?B?T09RU2NwcUo3aTc3dVBqd0EvUUF2Wno5Q0pDOUE4OVJLdmh1a2M1eUVHWU1s?=
 =?utf-8?B?MEV0WXlZNEkxRS9yTXBLV3A4QWNuSEhwUndiQzgxK05Xb3RoZ284ZGRPTExC?=
 =?utf-8?B?WTYvQllnRUdvN0g1cW0remlUZFIxZ2RZcmg4K3NDekcvMWtSWTdIOUVFcFpl?=
 =?utf-8?B?bkJ3V3V5Um4wU1BWZnA5YnBieFVrdzhueTZmYll2Q3hVNTNLUnUvcVY4OEFB?=
 =?utf-8?B?RE0yVFJLdnVUOXI2dC9PYXA4emczZ0NxTVhlc25TSTcveGc2Z1RDalgrS3FY?=
 =?utf-8?B?WitrOWRuQ3lzQzZaRW1hVHlJeXhYYjFZbW4xWjZNT2l3bElKTkZJckNBZUJM?=
 =?utf-8?B?bzMxYndzVzFqamM1OFRNc3RLZ0diUzhMM3pSdndqVmFHMU54c1REb0JpNlpH?=
 =?utf-8?B?MjZxcDI0ZG5CSDY1THVEMXNBcmNyWElGYmtvUVVSR1dlM3Jrb1VrUWJHOGhm?=
 =?utf-8?B?ZDVGYjVNVWh2dUtLdlVqT0d5UUgyci83Wm8vTlFERFJpcDhEYkJycm8zekpW?=
 =?utf-8?B?VXFCdzhFMTRJTzBUekRSSkVmVjZxdzhZbm1UQ0IwWFVzcTN6cm5oVndTcVpa?=
 =?utf-8?B?VUV3Zkx2WWpJd0RzYmliUUdYemhpb1RMZEY2V1hjMElxNkJNcmpTc2YxZkNS?=
 =?utf-8?B?b0hXdVJKS01PdXBqcGx1M3c5bzVKQmsxM3Qrb2pLdE1MVTQwcGVycjRRVTdw?=
 =?utf-8?B?cllkSllRajdnSDd6Mk8yb3NxSEUvaTk2b3lRN2s0bnMzV0RIaElncFpxL0d6?=
 =?utf-8?B?ZGQ1SjJoYWgrcHN6a3R5SUJJQTllOGRsLzRiK2xqY3ExLysvSDR5eXZLdmNZ?=
 =?utf-8?B?TCtzbHhOOEgvbWlUVlhYSHdYNUM2QnZwMXEvM3UycUJZcnVvb2NyNWY1RVU2?=
 =?utf-8?B?RStMSG5UYURLS2N3MU0wZ3RHY0tORnJ0eGxud3IyVWVxMXN3aEhFalZUaE5m?=
 =?utf-8?B?VHRuWXJwekJsejdTcTRnb3B6MW5DSzlWc2RnWXFWaFhwbzM1R0x5VDZvN21Y?=
 =?utf-8?B?MDFLdXR1b3VWTzVXcHlpZTMvQmE0UmZ5UWdtQ1UrbGQvcklvOVk1eENObkpw?=
 =?utf-8?B?S2p6N3A1LzNtc2NOY0VpYW95Nld3MFdyZ3d3N1VscjJZcFRDMkgvcVVsc3VS?=
 =?utf-8?B?WkdqSldVU1k5eVppSEtEUWx4VUw1OFpUZ25Sa3NFNzVRZzNZZVRlSGNla2pl?=
 =?utf-8?B?aTRUVC8xN2tCcUF2TngvUDlQdERuUzQ0LzBxN2JuWDRZdndQQm8rMFRKOUx0?=
 =?utf-8?B?N0kxL2JOK2FKTmhkTWNvNzBmWStMa1JHcW1nLzRiam41emozendUL1BOQXUx?=
 =?utf-8?B?UFRnaDhteVBxYnJKditoLzZISGZrZXE2OS9YQm96L2ZacXk1T3ZWelFFWFAx?=
 =?utf-8?B?bDN4eVI0MkpiZkFCZ0RxbE5Fem01blJoRGNGRE5tVlg3dmovL2JFdUV4a0Fz?=
 =?utf-8?B?WWxwNXg0bDYwVWpxNnpZeGVMSDBjZGJzaVJEY25DYWx6d3AvdGFvWEltN3Fy?=
 =?utf-8?B?bUgvNVlJckVrVUU1dlJHczZXbkhRWFhIL3hzY24xTkx6d3VqL0IyRW5nNUxW?=
 =?utf-8?B?OWxPdVpoN2l4VENyMEhqNkF6Z1lqRFZMcnBMVjdGbDhib0xORCs1RXZ5SGlo?=
 =?utf-8?B?aWZ6cDAwWmdURjdSR0Rzb1hyVlV1ZnN3MmNOM3hwR2ZjZHRHYkQ2eXh2azlG?=
 =?utf-8?B?Vy83TGgxMkRaeWNQNS9NTFpXWlZqa3ZWOWNkcm95a3pQWTYwNkVtOUk2aU1F?=
 =?utf-8?B?aEhOWW1SamRldmJoR0w3dVBiQ1RyM1VwOTR4ZTgwQXQrSFNySC9lZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf893e46-c85c-484f-0b55-08dee707a774
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:08:39.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z10sMPo8byaPO6McQpMqweq+lF4UBcSesnXT9lAkWt4pGmuOm4LfbunrsNIKrJWblbVc1nKzwvIOL/wOYh2i7hn7VtqAS6/XBkH6a9CHeXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=Pde+Q3pG7UHDNTrm4KxyUOmrXUOj2/nWzc8zs2eymKRPmJlW4o8OiGtrQpReL3hhWp1Nl9f3G+tsoZIGyBeDmDlhCu3csBx1g3H8A1k2+zHNwZy+IVKhqXCgGGTlAk7Zd9FfWnhTXGGrmy89op0NY98K50VIEqXxkKyO07BLoKQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Pde+Q3pG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pde+Q3pG"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
> 
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
