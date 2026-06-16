Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D12CD98E3
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C662848A6;
	Tue, 16 Jun 2026 17:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="f1TnMgdV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f1TnMgdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB83848BF; Tue, 16 Jun 2026 17:30:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51006848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UjAwvXYIeyecK2CogRYcHPGO9cs/NY8P/R+WmbVI4FHZAbUXJhL77gAi1Kra9giT/jq5GxNcP91HLZxjHpk6acI8wF5sdVChRrgJsJE27+Pt8hY4x3s4qCZUusFtClOXFgYqmEIR58qHiwWiaP/Fxr/1mFRQSaZm4E9MfArt++k6w8GoWTEIDarON+Py9SHezphPRSmvlm675Q7zo76lTxxRFJkkjXb1iLxUhjd4heZf5g68IeHLMesc2nrC5xF4eQZonVTeN+vBdqLUDDFj6ttRteHwMY5Kh0joYjFsnMIgIVDa3KcEr8SNo2NjD4bfoABnK5Xojbmiaw32PmdViQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02HKaU68opjd8+qn499OVa+sBKL2R4M0MIv+WGqCScM=;
 b=xnPx3l/3FmezeApMxis5M5fratfiUFGFElGl5XvgAlP8NwgpzyS0oBDf+kr1b8gqXRemkhdoxwW2EC0uQNAaCZYzXD1y+p9GrW6gbOQHRtQvRN+0aI/Wh/rX9Os1DKUsg+fAICXa2AITSZ0ML1AI7RncLjvV9dSttNeYYLs5DgnrMzUARVw2whNDZfJKXUViucySM+hvU0MosYBm5P1zpIaOphmwBPWPDmjVnLnAv1fQL6oANhZFMlfNmry+c0CreoMHAEcI6AlISOwQPpns6TKYDz3RhsaRcgOZ0R3ZevHmIPqakid+fOCvENBHQq1zkPhdkz62J0wkcKjcnQF8Vg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nokia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02HKaU68opjd8+qn499OVa+sBKL2R4M0MIv+WGqCScM=;
 b=f1TnMgdV9rFV0N+5+kmVH4i+tO8jf8yEI95rStHnXcLVzLnp3cfmVJjNSWGdYQYjBei5+4zpQp4jZi3xtfMAh7v2CXt6iQCuYvLXfEw7UeG/3h+rO6DmzTYq/K2vSwWpflSL+rU2nbA/ZoY6q/NE8JonA55HPMzj6G5k7YqETfM=
Received: from AS8PR04CA0171.eurprd04.prod.outlook.com (2603:10a6:20b:331::26)
 by DU0PR08MB8732.eurprd08.prod.outlook.com (2603:10a6:10:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:30:26 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:331:cafe::17) by AS8PR04CA0171.outlook.office365.com
 (2603:10a6:20b:331::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 15:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYCKA95ZK9dfwICd7OtlaC931x3CbmyPuseOW/zsNs0DYocx0F7qd+pxj5PZ0Pexj34Esc43v3D44IThEZQEQBWZAq+GxlX0CTTWWxwgljAzPcUDmq+Sowrq9l3ja96q8X8kALXxhJ3hEHdqfpTSFv0viK1eVJGD24/spGOtCRes5EzW0w3QDljW9DPPgvX9dn5Pj63qt2hfGMtPfJkVB+zQqeBCUfs954LKPb8OBFn1jb+Zq+Zl4lx5MTKUrMq7lSz4KoWrcbSJQzruQ56BtX3BOlb2AhYOhIkQjNR6G2F0wRzFtSDuyueFq+eGs/ISJwqZodXVLizDMrpuDvn3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02HKaU68opjd8+qn499OVa+sBKL2R4M0MIv+WGqCScM=;
 b=w05Kqcu34F/Yp1qsQgveNCUdV7oFDqPlULOTBGuK2hQnYowRniXfdkr6Ycjk5AdYpctSyYV6SYZf2wTVUXuMTDFfTyJlhUIoRhrdTPPs8L2Hz8UXSWIqZXnsn2kzB70k5CTh0Pm/i5QuvDWj2RfQajeaHYnyEFPLBQ4v0ZbvOy1/NVKRNtiDDNq2siR3/7vSPrvYBVxxo597WRPMsxal/dA6oqdlDwKL2j4FlLXecDitjMzJpHQaGr/MrlRrhJZenoEylW+tp4EcW6ZU7lJFHgj3x5Wy4uo4qGmKqpk+EI0FbRrUIDaYH2z+i9K6nE4dSDoSWlSk/QkGa4g9wzyONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02HKaU68opjd8+qn499OVa+sBKL2R4M0MIv+WGqCScM=;
 b=f1TnMgdV9rFV0N+5+kmVH4i+tO8jf8yEI95rStHnXcLVzLnp3cfmVJjNSWGdYQYjBei5+4zpQp4jZi3xtfMAh7v2CXt6iQCuYvLXfEw7UeG/3h+rO6DmzTYq/K2vSwWpflSL+rU2nbA/ZoY6q/NE8JonA55HPMzj6G5k7YqETfM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB6712.eurprd08.prod.outlook.com
 (2603:10a6:20b:393::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Tue, 16 Jun
 2026 15:29:23 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:29:23 +0000
Message-ID: <52cf286a-0145-47c2-b0db-d6d0b2c5f8f5@arm.com>
Date: Tue, 16 Jun 2026 17:29:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net: clear IP defragmentation state after
 returning a complete packet
To: Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>,
 Mikko Heinonen <mikko.heinonen@nokia.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alessandro Rubini <rubini@gnudd.com>, Simon Glass <sjg@chromium.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 nd@arm.com
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB6712:EE_|AMS0EPF0000019B:EE_|DU0PR08MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ac06b5-735e-4b70-976c-08decbbc3042
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: IWNWMQWJXTAWbWMMHyvaRSEw03wShbEKd7eq+vTF0hyKvz2qcx43oW2ZjvS2hL6SPKJ82EkNTynJqxaBRpxyyLsUvdKVTjanoTGrhi/l4aCeuANbA5lT5mMQQ1ymZmobDeTh1YsS2SwW1l2b7hQ6Lwt/jwvtd+Ko8Uv0NyuEw793uOcBHwa2HEJxXmWDYianAmQjdf2woXI6gsYniuAnOfWsNhHpuaJKtUbytoU7ulc8QSA4zECp5LtR3WS7XTD423w7qP8+5nYl6ZaadowIsUB+CYx9kBouajVrPl9bhc91/p7dbqPfwl/r8v14m2nG++m/9BPD0NoGwyoTj2fMWK6cIo9Q/Cp1zwZm8h2AIz806LvE9gAaWgNTMEHqQBZYennBf4eqjUvYu0aMnf766w0fassA5xLgepakVkCQt5yXK/zln35tfDkJKMVW/0L+1//Y0K2vUlbu/VoIC7i5AvAXUeESOujdMWB6w/zh6fHkLQ9Gixb3C04K6ekH2Hr8E6k1IQrNpqykG93QQVNhMGDxKlXVst+e63lzshp6dY8GfVag0l8a5ZmUE9sXMPY/OCu2FngXInb3AUlBx1AonSryghUGZ+uG3MJA/xojMBuKzETsvmdjHIDzulRGbBMGNKYrK/8oSSKMw23Aks4HBdyxRLpO3vwiqXgHPCGmxY1qoMgEXuz5Im79Ewliwwf8Y9itwhbCCNtb3RqmJJ9M7Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: LEhcSKsHvmdb26PektWi4hZTlUdhvCyKfWcblAHfu0nZGx5f1Bk8AvDaHJS5J5I8m2iErweOCircwy1L+0ld7Kr0E/lLFXUtdfRcT52tSa5HfOrBARZ/gbV1ODBqjhuWggh/xxWSy8oW2UHUJWHtDrvBTrYl6JReKJGrNn+CkVo012/zzwmQV3GUBwBTE3+0h+yG5wA2PEs6H5K10RWLH79opoIEbDcvXBkbN1NSfBU9iprKho6vwbusbTXw/XxWG70gEp+qjscsfAibL3vYrbXlHay/mUjnOWythacO0IZ82b+xwNhS8j8SEPruVtD/xl6+zFh/R7GVKYafEUoxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6712
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7cae981d-0492-48bd-b59b-08decbbc0acf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|7416014|376014|23010399003|1800799024|35042699022|13003099007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: G6mPhcWf1V4lRo2231wMh6CGxhFs8cw5juI/GL2gejWrWhCxj7XJus7IHzF0Aykby1FoYKO/Ui8lHPKovUQqfDGhSzkWDuwHpJ15LiGmL091P0+vLIf107+JBC3EP1SFcDUpDEWPlpliW+6tiFJZyiwvG/smFRvoPGAkCxR/SvL+0XRsOFAsgrSNycvwKC4G0qedtpM80RrRd9Wdgn0YvB3Xpm7nJvqQW3KVeisnpHi9zKJ+Agm64f4dX6YsYLeywAofH2R+YyC7Iyx7ZD+PTTB7wSZbk0O92ALgsFpg+/6GsgwGEd4lGhse8z0IXvrVOxN7ep1Rvn56UrDyBEtfrWL8o6mu8gv+qm2TKPMrwwVBI9/BD7wdgsziDbBuVP7+p2KDmZkvUKa9kLf1x60+yKSSn8XPf4sz6it1zVaX3Zl+mYb0f/FFCbggIHwKUqr2cuPoq0Gj7Zsg07OzL3z2r+mI6PaiE/ds2cmaou3vX2yuI6I6/5s+jxHc6cyCHoQjCaEWJIunZJIFwaP08/fPWpilhmhhValllkJ+OlfEkPAiSYR913OSuCCTtB4bYgrFiUK4N9SmmpQVp9cgt+a3zCbGIrpRxr0gmcvo7xlgNCQnLqNWgXRE5qI+G0GQy25AvJAza34AjLF+/xHSvDtnayWUC6BN+6PYaPyMktDb3qlQFO/s7SAZ81JBbgt+U7YZxaAMzYqOYv/HjD5chLfdjZ3vXbnRGRi6wrUcyT1SdoE=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(7416014)(376014)(23010399003)(1800799024)(35042699022)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oglg6Mc2XkntcaMh1zmguBxEE+rGPL+ltWWrXR5UpTpp6j8+5c63RDSd8eKwpg6uvdt02SRonuP9DSOEcmAT36F42ga4+FuiMgIyqVHKp0byOe85V0+Vgxm2kjJvuY5P5iNteAWlJBfhhWfzW+LZkyazHG3vSJvP114DL1IQE7Md9iNhpqafxxfwSjttjTl9kcsfPlUTbrnWEzz6XwT5VcBFGw3WqH5EALTZFdUmUnWiHiE2r4SOazleDc/mBVQrDK1oqAxhqgaCu9krQuuror4Iot9LVxxwUdgF/Q0GANgrQ5vOyoU+qeSaUroFHgCeI3f1pd4yuJgaBubhntsjrpGPzoe8JqbaZtgKWbU90RnrTSKmvkkZHHXNg7c5xJITlHL4SuiKCtQ3vvQW7Q/0bhScpDZF4vOKN0dT59VnWbl7Y7FVqB5vP4d6qf+VKMjO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:30:25.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ac06b5-735e-4b70-976c-08decbbc3042
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8732
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

On 10/06/2026 16:25, Mateusz Furdyna wrote:
> This series fixes incomplete clearing of the IP reassembly state
> (CONFIG_IP_DEFRAG): the static counters and hole list are not reset after a
> reassembled datagram is handed back to the caller. A duplicated final
> fragment is then processed against stale state, mis-parsing the delivered
> payload as the hole list, which can lead to re-delivery or out-of-bounds
> accesses.
> 
> Patch 1 contains the fix and the full rationale; patch 2 adds a unit
> test (run via "ut dm") that reproduces the duplicate-final-fragment
> case and guards against regressions.
> 
> Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
> ---
> Changes in v2:
> - correct spelling in commit msg "mistakingly" -> "mistakenly" 
> - net.c: fix block comment formatting
> - add regression test (net_defrag.c)
> - Link to v1: https://lore.kernel.org/all/20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com
> 
> To: Ben Warren <biggerbadderben@gmail.com>
> To: Alessandro Rubini <rubini-list@gnudd.com>
> To: u-boot@lists.denx.de
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Mateusz Furdyna <mateusz.furdyna@nokia.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> 
> ---
> Mateusz Furdyna (2):
>       net: clear IP defragmentation state after returning a complete packet
>       test: net: add IP defragmentation duplicate-fragment regression test
> 
>  net/net.c            |  9 ++++++
>  test/dm/Makefile     |  1 +
>  test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
> ---
> base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
> change-id: 20260530-ip_defrag-130c345dd9db
> 
> Best regards,
> --  
> Mateusz Furdyna <mateusz.furdyna@nokia.com>
> 

Series added to my net queue for master, thanks!

-- 
Jerome
