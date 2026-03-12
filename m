Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED4D106ACC2
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B94842A7;
	Thu, 12 Mar 2026 17:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SbB4COke";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SbB4COke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4427842AB; Thu, 12 Mar 2026 17:06:59 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417BB8423C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 17:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WTIV3Xc7CaEIdzD83UwN5zh0E5OP8omRr7a068a1iHsk5xKQKmiNEqX8zZlFw2Lb/yB6Hd7i1k7WVCz1kRO3+DhnGylOykJyOXp61E6yjcQtRcBUhLT3U8bEL6mn88P40gM8uOtgR2qORIIo+Y5FXXi/vqWxYvGJWVzienYHoZ2Pg/ltKDOdkrkGKuCy3u18Uo0D/dBF6D+CX6FQnm0wcNiCZCIw/ySnQHRjzjoxvGLCoDAFeKm6KVCF1KTCiQUNbV+KDKVfbRLyP/fOsdrwQgSmOZM3GLOX0WbxDonXjUOtyREDUKgaWzfeHnKTv1qMx52snOqbdLdHC9nQnE2Upg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwKh5/HxZTRwIOJg/k0aIWrd7IXqjMu7mlUAigBDVPw=;
 b=DtdTTc2Ptu3HtKgXptOmt3zHcpQ2YQnEKKID9XB6uWaBHEXxGSyh5VxT+iZJHU0UTyCSTvw18tT54XWLhT2HgNPPigMvml82dXIq/btvtFstfuRAP7L40wxFld0K+eyyDfqdJEk5tNB43ds+iblf9rVmLAkfM7qtQTILJ8cZZzSNflmi+ecBFmERG8STSM2CmKEMK9HWbzHZXlyU690QZmsUz133GUDlyljmK1PyyPb50mUzMWkkuz6g8IVnI/4lecz2LJIi+YAFhPuyPoZ/7H/O+QG2lVFLZXf7hb/TpnDSb7lQL+ao0R3e98d69r0z39+35zTfvgf7mXD4WZP82Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iopsys.eu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwKh5/HxZTRwIOJg/k0aIWrd7IXqjMu7mlUAigBDVPw=;
 b=SbB4COkee4hBlf3ovKxUo1qbDoXIv2tzBNsPf6Q7NSHK+iD+miCMzqPnmeumr4sldZI7r7Mm7uDFUGt2QwFuQ9L5Wru99WcxRw/tG6LuVIeZccR9Ed+uCECICIH/I2+bvsZ4htWQsxHhDc8tloFZhugJmUBrnZlLPknYPod3nag=
Received: from DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) by AM8PR08MB6322.eurprd08.prod.outlook.com
 (2603:10a6:20b:361::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:06:54 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::f) by DB9PR01CA0003.outlook.office365.com
 (2603:10a6:10:1d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 16:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Thu, 12 Mar 2026 16:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyUU+GxAiOU1BrcYgWDTPB5xzt/M/QgjFuuLB69vzR0oZjIIvUkvX2vBA58+7s48pehtLiWRuv1Q0IFdaH9wkWFbjA8bj6AvC+kMyPSiIkxhnWtUd60qKAlC8H69FSYV9aIcfjJgn7J75HLIe/XMLMMK9McAoFhi0oPM4/YzzY6Cv7iABDPfprfWIf7lG/uZu008tY9USfucXewAg+SF10AFAlwD/S1htqGKI7Y3TbAU00/IhXvJtHpEjAonufybWbWg3Skdgxstzp98b4R6IPcNqlPyDkfVGxGU7rYJC08KV6qF5BGJuawTzW6OrWg14AibdmHWmoDbZxfl+4kRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwKh5/HxZTRwIOJg/k0aIWrd7IXqjMu7mlUAigBDVPw=;
 b=l/F7WRYwLSqfaH9t5KsbybyTIetKZn4hygAOqco2qVxxEBhl7PsSuVgGtsJkWAnNzJCy64CjZwb1LxrXTRSe8EHS7NnuH4SaskKWzZAJhMx2KpisghjwXlQEKl8zo+0i3vcE1oXdly4tTcloCT0BaSbdbcba3zZqO2NFc33itfCPRJvSnZo/XEL9/95WxCquiTCAeTxmTtM10MLdY5tqpigUCYelm5koRH9o+Bu5IxwD3tSFkKFKjYTJTJsX0ntg+vuwp2pj51v0+jpMS2/QHpHwH56a211bRDXOKRf2W6ooPqYzU2+ty+a0eg4WZaHifMDo1uhZR/Y+WWZlzHQjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwKh5/HxZTRwIOJg/k0aIWrd7IXqjMu7mlUAigBDVPw=;
 b=SbB4COkee4hBlf3ovKxUo1qbDoXIv2tzBNsPf6Q7NSHK+iD+miCMzqPnmeumr4sldZI7r7Mm7uDFUGt2QwFuQ9L5Wru99WcxRw/tG6LuVIeZccR9Ed+uCECICIH/I2+bvsZ4htWQsxHhDc8tloFZhugJmUBrnZlLPknYPod3nag=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by VI0PR08MB11231.eurprd08.prod.outlook.com
 (2603:10a6:800:2c9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 16:05:48 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 16:05:48 +0000
Message-ID: <49412867-f5cc-4f80-bd41-3cf0f027479a@arm.com>
Date: Thu, 12 Mar 2026 17:05:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] net: pcs-airoha: unify code using SCU regmap
 helper
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
 <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|VI0PR08MB11231:EE_|DU6PEPF0000B61B:EE_|AM8PR08MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8ba2b8-ede7-42b4-c32f-08de8051612a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: EFiN9L3rRz2p4eQLYaFjsXLctPCVSDB6Lyq3+4x0S8jQyZT3gEzvUPchRPCNqkbyVTiHzpJZEf6/GtOeKrf1ZCsPcT5cQfube1dyscrKpPezqI/gv35+BoZkmWhd5WkiNzxVEjFmEhfGmDBE4/CAoKxKWbqr3fQVegC+Up+hFDEQOc3IdIWgzFszW1JCh4iKj9zR7i+hqBvag6gU23Hq+gckAGjpOn8yxcv2m8gc7Jox6nZvA1KBnPcJKhfUbnTZMV6Dk2FLqARVevTkYSUqo7Yl7NxD2c4Q0zsZXMlB2mVO7t+gxDFLufjc4Xt+kRQ+emgT+oq8YZrCmPf8BQLK4gXXBwuv8st4GRdYlwWxi+iwQdTXS1rjpAVplcN6xy+Mzo+oQB/07USgt8lt783fe5ffDAjS10Dt1t0LPQLdZ5ORl//ZbWVwcu7qGpkd9Ov8IhszNUMcMqKh5TIKkpPDrjQfOrU9+fA/In5t52pJzyTkLoW1wUCyTwAsWwY9zSyHtCbntqwpnqIIghyc02COooLWJ1jW313VG78taZB0KNtbzNVU1B7k+ZmVNU/+BxANGegbWoITczyauFUt1OhGQ0cGE9CbxaMI2FNGlgPSdtnMs0ohhS1E+AwrQL0Nc+5rEImFFeN2nslFZenfzL3cyv5aOm3TSVYh+tnaKZ5pn+LmSoZFXZSBxZ03S6ataSXsva96YC9JS6a6CoGtn7GzkbeknxyqXY/melaTc8+HItK0r0TWjBDj5JkGTdxyOQ1c
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: LMkYWg3Nkk20KkAowvslg9SaZaY3uo17QExfk7FOFu4oCsb0LHo/R+8taQDISMew7veO1v0NaUjpc6RCkka+EZr3WNNE+vQdwQcCgxnw+VGPli+26e2NynbVFckBAGJRMlBJEuBvI3jFCEpoTCqrWDxn5HTAwv9fSv4sGJ2MNo8dDfG7ReJt4L+JfvC07aP748bTOnDoUtHVu0bXJeQcBCgUvtL65C0KYqikOWbQU5JCqC0LbxltdkzlWMEjLmI9VG2tK/9ZCCzkS9b4q3tptO3jRaWKk9cmGWPtQCfEbRNvqvcF7V6Tdp3NXiYeUTY+lfJyoL+kf7rh42wI1KIzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11231
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8497fc87-96c9-4868-d67c-08de80513980
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|35042699022|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003|7053199007|921020|13003099007;
X-Microsoft-Antispam-Message-Info: yljDm1g/oyl8pqgf3c6opzTzk3Lq0cFciMzk9cY61daOUazEwr1Cs8T7/m9d+Jfc5icoif+skkLE+nhBzpr158mvxfSkDH6Gm5srI/tLF9OrMFBdiNLU8uQPkmwfPZ43kRetFD46nJubLKkM/mQMjsRvtWUz5DXbAY6GeTfotQ/C5cFfc81bzYMz8Dx11ukLjcQl5Xdnp6/TpOMUK9z5pDOY79WyamQ2F2NYo1JlSdV5PHHCwHKLYG4iFWxZEBer8FDY0qgD7pea9ylzZdNqJtn1JFyr8fUaQOyPKf/15TwTmAknE6BRm1WKORhdLdIB+7U182CaNo1i+nmigvmfEZc/mu9XB1nuGNZjdsolCdQJBSs5J5PkKxC4KpdGK+2MJcISOntVsNOo60JSBPHpvlsO/CTsF+rkkRLtClCmh7wiSOb3VYGtWGEheQf05ooNk7EVAUaabnzqesrrxaNy5DgvYjxXPfxjK4xSlx3S8zTpu/G4XPTCMAgytYUyuDp4TtmeC9ylmPKDSWYhbN5pQ+fu8/BG7g7EZQSNXsJXpmQKbsrya0FL4qna8TXjV8ytxpHPTv45fxrHb6cKCf+cOswOPXRJd9knsV+xedXy3+GDqNZa72gI8F+UpXrkJnDkf0h8wQWn5fBFBjQoN5OyvPvw9h9dGcvwSPI8wYJJrbPVcDNPD4goAUIEd/N3/H2cr7MQRotloeoTz/zIHUU+TbQ/PBHyYciFSJsWemDLRRjgyY4jmqsKgmgLTw3Ev6VUTFWsk/I5yzccnALjWzvP0w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(35042699022)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 34DT91a+WhncpCxgVB5lC6XnzLs9NrklFde8jH5IU34guzfdmHDpcYeUS59nO1IEf/xbYBc5xfTH8i77ELfLD7jzDxlXqFgw7u4FRewFnQU+43TUmpSNt9aOdyhwbILGOqTVqtkWqA5QeGL1t8sQgHDyqHR/EAhxkK2JDq7hNz4UdbRWInJ1PwiipAS4lu+GCRK81qWETbiAixEz5QsAr4Ns1BDOKKW11/OKgARqQkmE+yMf2xK+snM/e0PEdTpW9bOJeC0eJKydjqGjBQ3hqEw5yPIj9ta2ZVS6BJDO9xf+Te8QDXgUsSLgHR3VQLcYwJObeDY7xOWOUFI0GT0qGajFQVJr08yRFD2QLwtz1+/pzYFMkMl+xpg2368kfpx3RMWjJS0i9Cgg3q95OdY0M+2CM88/i9KqVvRk3a3A/i+JK4srALqurzydYG+twXIL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:06:54.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8ba2b8-ede7-42b4-c32f-08de8051612a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322
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

Hi Mikhail,

On 11/02/2026 19:22, Mikhail Kshevetskiy wrote:
> Use common code to get CHIP_SCU registers instead of driver one.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/net/airoha/pcs-airoha-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


FYI, I had to left this patch out of my pull request to Tom [1] due to
a CI error [2]. The root cause is not obvious to me, and since it is
just some code cleanup I decided to take all the other patches and defer
that one.

[1] https://lore.kernel.org/u-boot/91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com/T/#u
[2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1396757#L1193


Thanks,
-- 
Jerome

> diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
> index 8784d92a7a4..16f0dac2951 100644
> --- a/drivers/net/airoha/pcs-airoha-common.c
> +++ b/drivers/net/airoha/pcs-airoha-common.c
> @@ -10,7 +10,7 @@
>  #include <net.h>
>  #include <regmap.h>
>  #include <reset.h>
> -#include <syscon.h>
> +#include <asm/arch/scu-regmap.h>
>  
>  #include "pcs-airoha.h"
>  
> @@ -755,7 +755,7 @@ static int airoha_pcs_probe(struct udevice *dev)
>  		return PTR_ERR(priv->xfi_ana);
>  
>  	/* SCU is used to toggle XFI or HSGMII in global SoC registers */
> -	priv->scu = syscon_regmap_lookup_by_phandle(dev, "airoha,scu");
> +	priv->scu = airoha_get_scu_regmap();
>  	if (IS_ERR(priv->scu))
>  		return PTR_ERR(priv->scu);
>  

