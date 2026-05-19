Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36019CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9648465A;
	Tue, 19 May 2026 11:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="M3cy+UCN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M3cy+UCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8005884688; Tue, 19 May 2026 11:26:48 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D4B843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aRXvliVEj8XiyvALEnjiCr1h2YTOahEjpwYGxth/LvkjHtPihHoRHnsd+kSJjbGQHBX+tY1ZiRrLoSQ9pSNKekVxekl/u7eQ/2HgQ+bi3xfP378uBNutlZVr+tJjpyfH3fF2YTWTXQk1KgRlJz4/6hYLCFdhEEdSnYesuBUN+Lwuj+iZQRFJAPE8YcxDHWQaPeOuTihva/Hp18I/5NRI9VTVLi5TE5QGgfADj5dls/jDL2Bme1cxba9hKqah8onztGTDmi8vaPN5/M7nLe1O73J0a8GuqV8qPrR9/F3SnKEG92rnCsiBl9KJF99Fr0abja+00rKdK5kTEug/A9DsYg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU810kg29A2g7plr1za++zaZZWmsK1vopSAXPLo6iCU=;
 b=OhH8xa9kMHrtw3iVLHtGi9f7NJ4BGJ8cbj6KKwKOPV2KcWNFsud8plVPVgcMEu8ay9X87LGng4jOwamMtA3hpdB5HQ8B2Anr5710A6hucw9kVcELLt+9vpno6XztFnEv+0Tu4tDyrWAZc1+8YhlIhpGMi/Ul02jrjwBp618EuIfHI+bfDSHI3ndpUtKFhkumfH3jESNzH9oUJNkqyTGJ0ugpilAjRJ9IIjnz2e4AWroSXCMpk5RgEPJ9Yn9QzP2XmjKUDV8pQjPHqpy6v4vzK1KVbas5RYMhUPcE8vLqVTLMF4WYCsgIoPv1+vIeKkCzrpu+RDPj/51ciLgAMftGiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU810kg29A2g7plr1za++zaZZWmsK1vopSAXPLo6iCU=;
 b=M3cy+UCNQ5Gn8+lX+gtP/zi67mS+216mJWz9yBV3ohY7b+GrOqMYECfK8gjWd5YQTviP7rAaLOeI+PPy7TXKb8p2+t7ncesrhatooBHRC/SX2sTn2zs5jXGapCeOf/keQAdBbHhHp7BBZlxk3TzJ/oo3mnVn6WjN66+U1VpT1Vg=
Received: from DU7P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::11)
 by VI1PR08MB5312.eurprd08.prod.outlook.com (2603:10a6:803:139::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:26:40 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::50) by DU7P195CA0020.outlook.office365.com
 (2603:10a6:10:54d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJCpbRoF9XIHOOzOs53OsUv/us7aDTYXr6Jku+eEcPFMfSf0NW4MPdssRhF5ePH/Y1dCX3douoj0hsB4uad3nXRgRBJIhsEDHVjWG/fS7wTlw9PPAHGq7E40VL/LNCbaI+KEyphDlW63TZht68Kfh07QuEqTg2rTtf/S6UJm38fKo8uQegPfCjSyzwAe7lw96I3Ax/5r1f1sL8V0vhYW+ATX3zxHnEFPLhGQeAavfYsvvY16oqBevckYLSsbpS1pjed2586xWHLNoM4f70aDRIJHPFeZp/iUHYsVeZdBhjAZE3gbNY/rSznR1DYv5Jk/HbNH1z16gVTc47hxR9r0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU810kg29A2g7plr1za++zaZZWmsK1vopSAXPLo6iCU=;
 b=y/gPG/uWH8+G6RCz/IgaWubjiYjVmVSlAmMlg52sKEiBW/RA2m4inuSqw9kcTLNXyiScZTlhNLm4y6zvWj1/34jjPKKuO0benhSqZujwPaWyzvgWrmo3KZfJCVkvI5cdCCejvinLTTE3QJwau5xQ/N+SD7pFcLS0mtF0GnPQqzhhyqoYNvzzhVzmM1j63E+BOHpJShUBYsBR7kTO0ae0BIZ1ekZWi/bgrZno2gq9C/DTrb+eup+GvIr/DUM2ApXSXMt3EMNfU2Ixdz5ieaC+AAykrOT7Zv+aSxO9igfKlqCeNkocTa5td5QMkTCuq8PkO/XFlgmXrE2iSvyNTL6eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU810kg29A2g7plr1za++zaZZWmsK1vopSAXPLo6iCU=;
 b=M3cy+UCNQ5Gn8+lX+gtP/zi67mS+216mJWz9yBV3ohY7b+GrOqMYECfK8gjWd5YQTviP7rAaLOeI+PPy7TXKb8p2+t7ncesrhatooBHRC/SX2sTn2zs5jXGapCeOf/keQAdBbHhHp7BBZlxk3TzJ/oo3mnVn6WjN66+U1VpT1Vg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5786.eurprd08.prod.outlook.com
 (2603:10a6:102:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 19 May
 2026 09:25:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:25:35 +0000
Message-ID: <c65c9b76-e036-45a7-8d65-4f91609f2694@arm.com>
Date: Tue, 19 May 2026 11:25:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg: Fix portname buffer overflow
From: Jerome Forissier <jerome.forissier@arm.com>
To: Francois Berder <fberder@outlook.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB28053AA411008729F40FC707DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <55e14878-7f7e-4c8d-8eff-71c14d5338a4@arm.com>
Content-Language: en-US
In-Reply-To: <55e14878-7f7e-4c8d-8eff-71c14d5338a4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0121.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5786:EE_|DB5PEPF00014B98:EE_|VI1PR08MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: df7a3439-9875-4835-e3b4-08deb588bae3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original: RhJlwCEvpe16ePZwb0dVtERdNqVvSharatdg+uG5nRLYSVAlbLb5Yt++XY8U0WM62rw3Qf7Q8GPI3I3P8rl9qPLucU3m36sLBnIwLbXkJvABZMPc6bMZBtbMJmyuenR770DLfFTlWSDh3Ej1n86FdsIW7ZOf9kQleCypxWgesEo2QfnKF69DPOna0fjJPUP6DHMD8Lib8KWqAWTREoL0uBLKP55LcIjb0g6VjhjP5F59iJGyKliwiI8isEkhUGZ9jWVFAeik7CN4CjReVL6BElNR9k20Qs1RU2oWdzqClJroCH8J5YnEj/5RH04xgxiRQah9gfGUv1K3SqvEjpxgdYDWryyVTiQtFxg1XZQ/vUtWGZLVtt98mobi55uea3lgK/DRj81zA7pFylPtAv0W8NdvDX/no6MUqQo3Q7POmMVqS0rerelf8nT0K+J9LpV50/6VxJZAcdaxblFoO2kGwbpZ9fi3j+sVzeiQX54uM+GrWbl3fkTu92trxWWwV3b3t0jlyBPPFgyQf2OIJC/8f83ebPwDiyxIA/y9MfmDy7ODZe9gzelaH7AELgW8uaPsE2sQ9rjy/Wq+Tm4/49suPDENn2sK3eCxBbBmiHkN3tnqrVOBESCKU3RMxCsEofSWVu0J6y7N4BHhrEyDkDAAakNDfvtcxi8lfQgeL5F2yddv+fGrMrPvJf3As7eM7F4d
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: D5P4ahOtrhl6lpTIC3QfEUZhQuX76tmoY8w6fcRZXB+jYADfKdG00KaPP4O5E9ZNtuKpPp+vrNMD6O14s9G2UEsI4ZiK4YlKUg/pqyX2h24uk7+L4SiiiuSseL2DQeBnzpxhgEssxrDal6+VZ6LKmNefw9Nt0ISQ+f8HN39zPwII2xXAprcc/eUUhDXiywNzzTgHLFjtyWl0B/3me8xGFrOBtT8viwsG/+KmLiYiTKrokcPowsT3Y11c+Gme9N3xD3+POOu6xgKVaLQny5m+uGb1ZtXn6Z/UaKUD1cqy8a1CiqMafB86ey/N7Qdg+EhE+XXzVM+2GVxp6ZWitxNLew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b29cbbca-0eec-495d-6785-08deb5889525
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|32650700020|36860700016|376014|35042699022|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: b8hs6WQsOlhLadruZ1ZjTkUbO7kN2+SMJt69KuyDF/oK6n0bvDdQZ91FfnbcjiaVQ9kXfYCkx9tyeDO83Q/6OtxTHqFEtcxfCmmPGJdt80Sh2JXzANSQXfPM3aHBvhv92WrpNWEsOyWSd16NeJ5Vr3Kh8qWVIHNCFP7vlm4zPAKcld062ZAaTPMEyCyTdwvFnVyBvIghDsxiJ9a78qdOCrgsHBkXJmd4T1LkrSov08G05/Mmkteg9ja2uTxDhev3Moy8TbH235Roy8Ul9LEmfkGxi7Sd5WE2Q770bMKnUUbPPj3/eC994aZynU4giH6bRJnA0wsV6UvDUqG3TqukH2YCEyLgtNEod/DPrpMwJowp4RecWXz/5Y8H40ZHBQAmI9o8BYOrgN8b/mi6veMBDk1V30dH8V8K2oFe18XNEmZjLgemox8wed33xWnR6vxONP1l4Ugv1C1r8ErUSMjwcguN7pRVXGhKZv3EaShzW7oWUgtRJ1zuOcCG98AtoohE9KaWbME3lzynE700kUnPBYYlA+VrfinE4PW0C6hCE5FCfy+WXQPc6/vNPX4cLOFjJoczxVVeh0RLvTjY0Eqvfx3SR+0lfIC9BtWEC7RMANoe6o5BisOBunanR7M14bwSMrWnmHAyqFClbBIzhXr4+RE5WIMRiMCXnXKCoqeK7wSlrwo9KtUmc4vK5UKVIyrlstHxldizmdKq7QdmK2r+ocQ6o1Fb1DcNCxcv8KHEQAY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(32650700020)(36860700016)(376014)(35042699022)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fwOI93YmuXkk6uE+Aw5zc7y0m9VmyiRBsS6I8EXX+YqqZww34EBF4wSKdVttFIQT6VrC+5LVCX1LHsuSwZi8QCV9lkWwOlDCYfhhRixigz6pcwQSOHOjqC+SkeC5N86Y+j7ETl1PEoC2hAgk1BBMhbB0sD/CV5yKIDxbCoeVh3fTiVk19us+QtCWUfTNcgOq10EuPNj8ZwfzdnGyPu4xgQunNRyTPWXyuD+d3l8d8O76n7IY0vR03a9v/fSNVmhckcNfLpkxIAICSd//TIklp7RO5/x9FuKll33hloHlUgzuKDdH1/23CA/bAGPFg8Bo7hdyqi2fPAPQHcKtbtDGZDrNr+7Mc3skciRloUGqS8xU5qE5cOc/L3DXImh3K+EdYX7rIAVHniWNGimITX2zrvZk2UgGyJTFiPaViWO5LH49wuMwfY9rckpfi0TnTtGR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:26:38.6192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a3439-9875-4835-e3b4-08deb588bae3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5312
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



On 11/05/2026 17:29, Jerome Forissier wrote:
> 
> 
> On 09/05/2026 22:01, Francois Berder wrote:
>> portname consists of dev->parent->name ("icssg0-eth",
>> "icssg1-eth", or "ethernet") and dev->name is the port node
>> name ("port@0" or "port@1").  Every board DTS in the repository
>> produces a string that overflows the buffer:
>>
>> "icssg1-eth-port@0"  17 chars + NUL = 18 bytes  (AM642 EVM, IoT2050)
>> "ethernet-port@0"    15 chars + NUL = 16 bytes  (SR-SOM, phyboard)
>>
>> This commits increases portname to 64 bytes and replaces sprintf
>> by snprintf so that any future DT node name cannot overflow it
>> regardless of length.
>>
>> Signed-off-by: Francois Berder <fberder@outlook.fr>
>> ---
>>  drivers/net/ti/icssg_prueth.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
>> index 12a162b9d68..4796d0d67cd 100644
>> --- a/drivers/net/ti/icssg_prueth.c
>> +++ b/drivers/net/ti/icssg_prueth.c
>> @@ -496,14 +496,15 @@ static int prueth_port_probe(struct udevice *dev)
>>  {
>>  	struct prueth_priv *priv = dev_get_priv(dev);
>>  	struct prueth *prueth;
>> -	char portname[15];
>> +	char portname[64];
>>  	int ret;
>>  
>>  	priv->dev = dev;
>>  	prueth = dev_get_priv(dev->parent);
>>  	priv->prueth = prueth;
>>  
>> -	sprintf(portname, "%s-%s", dev->parent->name, dev->name);
>> +	snprintf(portname, sizeof(portname), "%s-%s", dev->parent->name, dev->name);
>> +	portname[sizeof(portname) - 1] = '\0';
>>  
>>  	device_set_name(dev, portname);
>>  
> 
> Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

...and added to the net queue, thanks!

-- 
Jerome

