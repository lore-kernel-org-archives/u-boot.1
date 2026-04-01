Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89A5D3514B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8B884020;
	Wed,  1 Apr 2026 09:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PV2G1+Od";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PV2G1+Od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D3784073; Wed,  1 Apr 2026 09:26:30 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3108B83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 09:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cAIxXTZnbssJF6bQLJ3LB96r6BfZbTGHBs5qiWNP7vOxCgiCDg3J2lvVsDaYiph6NYL0FTY2xR8yGZ6HP0t3amTVCcVu4lmn3sCOobcijzG+iFyZWuUp9VL0NbpchK806SeRemalHuyUgruKrSpMZ8osaoIV1ZfNcqsbom5cvO/pG5pUl2mIW0OAczMfKMRIb5KU0PbGQu7yuvkxkcruh+dUrxLjxyHHkor2JYN1tDnVhd+h+O0chPfyiboNl4cch4L/5ZOdSvJEdx+ClaBHUAhcxNbiLVcCXgxmqAshW/siV/GtBBOUhjMTVnEiqW2PCGFWi1CAkUieBN0LeA6y1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6a3F/3rFxDK26TwiWyOBB1vjqyT1JUKoKkdHQta3+k=;
 b=W/dEHrjU7OlipmHl/azecMkwSvZO5emxS1h138MRGANyk/m7FCLjxZmYxH6SzkWQv+2KDESnEYKKuIEn8w7ZP1vOpZXnCmF+yG9x4iJ/fHHsx4J99b5WjWhdHhdifin4w2WkIQgy+X7CFhdswlWa9a9emYaAha7yR0LCbSMojimrrFemZZKV94B4aHiVoptNPBpfcwB13VX0Ch87Kpvn+7jyjwaYu/QsZxPHHR95xBvyRNGccEBjxHDOJf1tk6iIsXW7SLhez52f3fhblxCUuh/eJNy96QNJQbpxmAmVzu+SrGbJ+DXvhQk+eJQW/XM6EljbjOIhghHeul4lyNtAiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6a3F/3rFxDK26TwiWyOBB1vjqyT1JUKoKkdHQta3+k=;
 b=PV2G1+OdE59hKzDXwpy0DfLSF7kOFey+s3NW7cWW9naYH8B4zJVJqMn81nQPlrwhBa85KKxGpxDI6xiWCU+n9uAS+IrHJ7ZSiomVbVm7J2nrBj4gEYxrCHNJXu8diRccOy+jhKufCvB/KZ0iV4PdLAjsdGa4AcOQXdcQzT1Ii7w=
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by PAWPR08MB11439.eurprd08.prod.outlook.com (2603:10a6:102:512::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:26:25 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::b6) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 07:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via
 Frontend Transport; Wed, 1 Apr 2026 07:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo/2fVbxV5yZ98AuK7jC/4qa2tg7xU8s8ncWApC3YzUKQd2gYFOPUXDNsGCyj3g07s/BNl5W2z5vgDx7U2i9H+ISReRyfT0tE13rVxAqKvLXpLmultppSuyf4tg+KtVmlw0QTprcYyMzxZwIwbvb6kHDhVEIyPdl/sr9ntlquJgRj1NbrHrVfO56CKkk1RikD/ME4AXdEgz1TgqL41WrI2qk3II1gpukQg0F9zwu/9UBGVm4jsfGBprpGhwmGvkZr4WJ+CcsMaUtxYsqz8/E5F/SJu3/Kq/Qne+l2kIe7HU/MAkeFnNqH6Fa0dOseTWfab3OQZQV2EzAqly/huDz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6a3F/3rFxDK26TwiWyOBB1vjqyT1JUKoKkdHQta3+k=;
 b=O5lgWxIqM3Zol3o671WShCGMfbIGuM1aLNI6apR6nhyFZc1vLJSjyZIzGV2YhyYc0mlhSXOr3w2DpmPS0M/qEP25j8ERRuQ+0HFTCSEN2NKosiGjr5pW4pD0wmH0IwHt5VpBMvLR9Sxvdm3TkssIQVHWgfYFO1jzrtuF6hPuqgZbACC2QZAWd5G7ndN5irjluQ6+c7FB0+6z2uu7kvnU2ui7feMChGP7i9PRUC8D9nn8ZAlBB1Gi0xWIRSAPh3S4ArJ2h+Kv2bFOmQ6U4oVkAXMs7Mmuu2RrWdq1aj2cl377ZCf/EnVdQP+EVVoL47yxR4cQ1cGkL/X5kN2fu4uYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6a3F/3rFxDK26TwiWyOBB1vjqyT1JUKoKkdHQta3+k=;
 b=PV2G1+OdE59hKzDXwpy0DfLSF7kOFey+s3NW7cWW9naYH8B4zJVJqMn81nQPlrwhBa85KKxGpxDI6xiWCU+n9uAS+IrHJ7ZSiomVbVm7J2nrBj4gEYxrCHNJXu8diRccOy+jhKufCvB/KZ0iV4PdLAjsdGa4AcOQXdcQzT1Ii7w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB5327.eurprd08.prod.outlook.com
 (2603:10a6:803:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:25:20 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 07:25:20 +0000
Message-ID: <7876118d-d702-4b1a-a289-e230bc47f5e9@arm.com>
Date: Wed, 1 Apr 2026 09:25:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .mailmap: Fix Jerome's entry
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Heiko Schocher <hs@nabladev.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Linus Walleij <linusw@kernel.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
 <7d08e7ad-bd02-412a-a3d1-30a5edc27bbe@arm.com>
 <e096202a-17f5-4c0b-919a-45f2d232757b@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <e096202a-17f5-4c0b-919a-45f2d232757b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB5327:EE_|DU6PEPF00009529:EE_|PAWPR08MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: 50665c45-fd83-4cdb-9cc1-08de8fbffb37
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: /2fUxzxCpXG0UGPlJ78gStzYKZM3+GHqT0Nf0YQhikiMle/RG8w8A0cvZeU7QKYgmFACBnjecL1cBA0m4krLhkTVefDK5tRKcKrzuSqO6LyUMgjLAAIRU7VzcKAFRRHVrs9j/r7AOCEOa7xmJVla1Dt6wgZ/xrBtta2CjTzah0ppq/gRd5LBqPAhjjdapNWYAo4zT2uhGWyqKnEo4TOEnmRWP6QX5QSHfAkdeZykaAuxMhs+o8IFL5ckDc5Lwmd89A9+bOSZDM5KTbQWCDlwe3YlGCta9MPq478IhVtkGw2WJW9MeSlP8m3jq2Rq9WJFbGVi3Q/5L9uuryOnHvTSdx1Un7Z7rL34m3gPfxRrODy+qwQhuQzbWcDmAljcJPcujF/yEnLQpfBKIzt6I3fXGVNsuafm9QeJ7jgz59bVNHZmK+Tq5KD0uOO8qQLEmFuE3+4mB9f41W5/38qJGXsGfXc80l7kT/b4W+Qhck/A3Yu/lEgCAqFOVgkKGUxw06l96O5EBXKKXvN5go3AYQvRg6nDSg3/15ijeqgqy1xD90sKt1uFA3ojl+s1MztsyoUlvdAuDixnMe4pB4YIV5KWoAxRBD91spV7fk9kF1E7H6tSSodp9erxge+9dDNaa+lmRJSi3YQPR3u6rhv0oIB1ggigeGNmNDHrFZcEEctyjPZ9ViX6bJRfoSMm2YEf8caTf8DeMHPefCzDg14M59IkGsr40FkpZt29xeVgoZdkhj8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Izpg22p3Fl//mJ26VRjGCXSlIIXGty+kbn0Gy+ge5f5tlw+EfwZcfBPw2T5O6t6R4jmGQJNux2eduKaqNAnzAdyfD5HE7s81ZMizyaC8heXAKNTBDlDY8dnG/ehUXrZtl9FBYrh/uhVZyhEEsg1JTtDTG/enb1KZwRgpa287DdhsS/o0wG9OaQhqxi78l7xZ1US18MNAIOCwyCpNS+BW8oVYRG96n6Ap7q8BIw5dAIvOk0aCrPuyOnmXGePO3g9gaRf++XjJEmJQo4VeXkD2igDSzYzxwzs0tNcgzbUzEiI7jWAQW1RQUq41wJOIruWynZL/Ldili70Z8WEdXCTS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5327
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 26eefe40-5a3b-4c2f-a809-08de8fbfd49e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|7416014|35042699022|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: geBXm9F1BiO9RYITknSzoFVv8wVm9EcCPY2PwSyaWW8qHsDfF1f3ZMd6F2ZSuMpq24kQueYsiyH49CBDEQLO8a8ztbXjChalhtB7dYMDyII2waWxt6w+b324ZmLv+GoWVtqrplCK7WltAOAfK4b87mXiv9JIRelzV6N4bAo1y8fPiK+ShUTkLwCOqvvtL8iwGYrtn2UVqRr5Yv/JW1NQPSjGC/rTqepJCVlozmQ5fanLAaLjV5jfpp/jPmPO1sQM2e/1Cblgrt2ryLgwDyZY8uedmXMnj6z//TdKJ4uL5FWMv1GEXsTLftF1YwTK9jeT7xyhtfWZthHnsgxz/PcWNs4Hsa/UKlKLs+sdjUCt3i3/pDtlSbCS4sBo/U6xqiyAnz+ZqL35QGoH5GIQhRMMFF4ZAvClxhUIp/adlny2uPNW7aqCQankho5F2d+l4tbvo1uFOEvUH1hu5G3AWSr6y3PooygKh33lQtM/C38c6RZKhe0/Wnm+rGUx6iDvNuhryxni7mDk/Gz6DToyOcRCzM2n1c7Kz+CqFL7mYLSOi1f4X9bkEdP1p2YyrVCwlZoj6rWMZeaUvOmnxS6yTV3IcwihMbSo8H7j6BURSUnUTRAIjVaLJMXV6EO1FWi/xXWJAUSB7F6X0brifw9YZd9zhM60RAs1adHYDMoQeR/Hbnaj0gpC9OBNYtn2UT5Quhi0PANPMoyp/LYW3REIwugU1/SGEzDCXRMg5zoof6+bh1OTqPApZ9higYEFPWfITpVeg3yfcIu5ki3kPXgtqqeazQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eRYJZozs9T5q7K8Iq46HpF9aKoyedlV1Exyy/PVALQAO0AJBpJYIhk8K97wuG8qIxjJOmrn86M2mkrBKXikNW2+v/hILdYTXKBvy/gumyM6ZZuHUEfFDqjZfNOUQfi8WcfkFIGHgJA8T7VySTLmvxbPdMU/rkKhvThYeZ7AtCJIXGrpEU1n13GSYWEdxV2eAPT7Db1dHnGVD8fHfmZFqqenMEm2z1yJy4DLblQPjik+ONYf3ljugAiQEVGP7qPmhXS5iSX+QE6Ie/5iqwM3+aR7m2Xsxa8hoTzomMhrkDlv4RrJaDPoQQCLEr7TuJq2+dpMqlGrwi/96Mk1+QnYjeATKXFE7y3mRblofacUQPG7Ilznrz6vNVVppec9Fc8Xt8n4wVZiftUcAbNKGT4tO3nGtRRLn67BVoRXuwWrZIfWa7QVYD38XovP7YgfVFkZo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:26:24.8224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50665c45-fd83-4cdb-9cc1-08de8fbffb37
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11439
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



On 01/04/2026 09:22, Michal Simek wrote:
> 
> 
> On 4/1/26 09:20, Jerome Forissier wrote:
>> Hi Michal,
>>
>> On 01/04/2026 08:10, Michal Simek wrote:
>>> When patman is used email address is composed together with both email
>>> address from .mailmal file. Having two commit emails is not proper format.
>>>
>>> Error:
>>> error: unable to extract a valid address from: Jerome Forissier
>>> <jerome.forissier@arm.comjerome@forissier.org>
>>>
>>> Fixes: f2566c3a71a5 ("MAINTAINERS: update my email address")
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   .mailmap | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index 31d4970fff77..6ac4b9b9e5ef 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -69,7 +69,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
>>>   Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
>>>   Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
>>>   Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
>>> -Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome.forissier@linaro.org>
>>> +Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
>>> +Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
>>>   John Linn <john.linn@amd.com> <john.linn@xilinx.com>
>>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
>>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
>>
>> Thanks for fixing this.
> 
> Is this any official tag? :-)

Yes it is. Ah, I need more coffee :)

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Cheers,
-- 
Jerome

> Cheers,
> Michal
> 

