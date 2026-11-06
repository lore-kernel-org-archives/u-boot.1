Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BpkE5Zcc;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q7EtYdJy;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q7EtYdJy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56DC1812C8;
	Fri,  6 Nov 2026 19:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_LqKGROyiY5; Fri,  6 Nov 2026 19:10:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D8ED812CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793992257;
	b=J+KKFml9wJ0JyHk6qNZyZwz6ePb1ldvFwDnILDidWVhmTKGytWWq1yuQ4ouGOmvbc4mf
	 2dUQeEKbZysZo2gTcj6vC7IhnbVIEj4Ugs348BpGFAh74f1hAGIoN047uwBOQmXR5/Mt6
	 EuODHgdv7Sj7uSMh5j1juMOaY19xPznSdU127QTRi9h6Xr+veXlgoduZplTH/LdPcMYCD
	 rqoSHn1CGeOKGkFWKgaRJCQwcPcUMVBGa79AIfBR+dJkqSPQRJScOe/jajXy+/seTnWhf
	 QFsvC25PynqHV6kSAPHsNETSRYuPhyj3GbkbB2QI3kf6e3DKLVqfE3M0mgaasVJpFmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793992257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6yqRDJdXk0UCu0z4oA5z7Xaz7yQErfc917unDW2odoQ=;
	b=UzKlgmHBnjMKkFub7clfxvYLRd+lF5+goAyW4vw+F5PcsBZWl9v9TDKSV9rVgoEIm6YB
	 Wk9u02aSB2VPq/CStj2Q+N5jwvjKMnnlTCKwvkob2REFs3k5dPSFZjSgDt+KJBIp7tUVZ
	 7zu1g24+i36xbYFSTNqbz65ADke1l9fXRdafTuryx0hjkt1yps4X1rYFfmZ8FS7Sg0Ple
	 Zituf5k7ozqscod7ZdELzf2o4ceyA+11Fq7t8Jk3j3GduRR6Bg1SZtd7Mw829x/Bpgn5i
	 BLde9qgdxBjznHfTeY93gop9/5xuno6a6n/ADIyOYqAcKvVytJPZNC2MNV6/18TUOaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793992257;
	bh=6yqRDJdXk0UCu0z4oA5z7Xaz7yQErfc917unDW2odoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BpkE5Zccqa8HfdE5HO5RpRIQCyDFRp70rik8Q+c4+ope5t1IRYNolxdTXy93Uhe0f
	 gmulCaH4sDqYArIAdQqVA48p0BYR7SwaPagq38QWFyY+EiBiXWYFQrKVXOzYG3TBQq
	 zfPI6xcnmZ1TffjZ1lz7xkxVgEvDAeJDofu/965aSVdBfvlxtXFT/Vq44ECo+P5Q14
	 RPz8AqtZ5TMMIGN+Uc0gYODLCPQfzTcn8W2c05aRgUXRhkT51CrPov26ZFfHCm9ywW
	 B8rwHAHCoK/0pLfiG21R4lmZMoR+qiC0Bfv5Q5T13w0PZirXludgtQi2OEALsbxT0C
	 jIObJXI0emJGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D8ED812CA;
	Fri,  6 Nov 2026 19:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C93504B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEBFC40899
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xs1Xg43tcmbs for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33A36407D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q7EtYdJy; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q7EtYdJy
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33A36407D4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yqRDJdXk0UCu0z4oA5z7Xaz7yQErfc917unDW2odoQ=;
 b=q7EtYdJy3mSQcv2uBXHJ9Ihq7UR5x0OqvEFVGVTlU0OCgFeRQ7PfJ9Oe3xna/VnGhGgmhLZBP5DZNadX2UTOj1FdQUpgzmq7DJz4a2zC4F+lvKWDLoi0JRVJoTjANksX/UFhTprf7T1HE/Pse1UlvlN6P4BrWUj4Wp8vjq71mOw=
Received: from PAZP264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::17)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:10:41 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:102:1f8:cafe::a0) by PAZP264CA0131.outlook.office365.com
 (2603:10a6:102:1f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:10:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 19:10:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yqRDJdXk0UCu0z4oA5z7Xaz7yQErfc917unDW2odoQ=;
 b=q7EtYdJy3mSQcv2uBXHJ9Ihq7UR5x0OqvEFVGVTlU0OCgFeRQ7PfJ9Oe3xna/VnGhGgmhLZBP5DZNadX2UTOj1FdQUpgzmq7DJz4a2zC4F+lvKWDLoi0JRVJoTjANksX/UFhTprf7T1HE/Pse1UlvlN6P4BrWUj4Wp8vjq71mOw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB11786.eurprd08.prod.outlook.com
 (2603:10a6:150:312::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:10:07 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 19:10:07 +0000
Message-ID: <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
Date: Fri, 6 Nov 2026 20:10:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
To: E Shattow <e@freeshell.de>, iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 nd@arm.com
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0289.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB11786:EE_|MI3PEPF00008496:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c57ba7-d1ea-4ed3-8e6b-08df3c39a60d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|261021121427099003|261022105027099003|261028144727099003|261022115727099003|261022075727099003|261021123027099003|261102123227099003|261026140227099003|10067099003|261026121527099003|11063799006|4143699003|260925021911599003|5023799004|260925022911599003|260925021311599003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: fOqCi3as1XXJ3X1r6BqX7P+ZODUYWyzBuyJ4lqa9kTjiaCtYzPX6+1rbWhjFsD+rbSf38klw1VGZNADR3yDwOMrK/3UJr6TNl43r30Enr3t2f5tSPB9kTqcQnfCXX5xlGzHP5gd+htoF2ukMt+2K6PQCMyKEVlAuy5P+Ay+OrABM5lxUHQN0GP6gsAtWAwesJUGy21pn+5At40OCEefBvposGWff670Ae21ubembHF/HuPAHiNtTzcPuGP2hDyJ1Cu2LXu2OrJQdjDcjeiuKB3m2i6X4ZsmTiND7QnM+bHFCA9F9aCST2NOwBgsen2aCi6/WXyvu0Db07Lxj2E3l/V09LNU47KTCLxhnTx5TR9yz4yLx5ySPrPqBTrTp2Duq97Ve9jiZ8mcRlsLCdiTQtbJgQabH1XVydkdUxqsX/5q37kyiR5KtKm30RRhpj6RrD/ELjRbKc1Z5bNp2owfOA3/qj7krSJOs1APdVEYyHE4VU7PzcaW48V4ubros0n+wPWv+YCwa3GRHD1SEFUNNHVxCP5tsL1F8tH6SUoPmyDJ8k7xX6ZvlvI/szow/1P8+UnRYDwKoc/sAyJpsp0VcpN9aMdgw94Ea/GYWnQkNJ6w6d/oTaaIahox7W+0cOte2
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022115727099003)(261022075727099003)(261021123027099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(11063799006)(4143699003)(260925021911599003)(5023799004)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Q0Ac+dcDMRYkErDxKKNT+4OZ+JXJg/3U8hHq7cjC5BFhi0RfmpUn0tLeDi9YY1wc/pO3W+ZVkj0zvhq5eFNvjbzN4KjgZjUiTPUp7M3gTR3WmQ/EMoDXG1TX83S+cBV/aVT6Ar4pu8grB7EyR10f6SkOk4RoBDD4LT2m8VQ27BO5LhT00MQOwUUYOxRTSZtXE/piFi1u01kdlNv0VgAs3ozowlro5GEkLfhXMZD43COZkLnRjURUgM7WoWnRCbDTn8X6v04jnyqOUnwo9xZl6fIQUHhHnziJw5tYCotokbT3FMN+UDh+oqhuDgJaVJtk+Ftx0Qg+DufREjn1N2NMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11786
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0cff2923-95c5-4e3a-92e0-08df3c39922b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|35042699022|23010399003|36860700016|14060799003|82310400026|22082099003|18002099003|13003099007|56012099006|10067099003|260925021311599003|260925022911599003|5023799004|11063799006|4143699003|260925021911599003|261026121527099003|261022115727099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 5OzU7O/obUpgpxNr/s2coDctx7f1jmWkpf+HLuATA8QA/31i29PSIkqd/A4oJ5ZQ6EHUFtKzFPRWFw2YENvZ4rbSG/yF00Rfe0oheb45ZiWvqS9gbw+YGiiwi+H3o6Tyhfszs937p0n+OWuNfVwSMzrYT+hwwslToUjpi11Zqm5pEKJi7uJ0g2uCD0olBsubctxZ67rr0pDAIIN3PDQog8AQwztDOI/Xa5LY4b4ud4hV7XiOYWYB9nLUwgQ25z4V1RRhSfEZe4udQAgLb0Aqr2v3KWlAWYrekA1NiXRIJObQW/GZWeSIMXcDhqOto+9rlRzIlDrvJgXN3yu5XBeiWutbERD06dFRJXE948klYFLmmBZdqE3Yf8W1EgJ5hzy/ogP/PzJpV6xDTCDgyZD/Vm4fH6jWFa86UXmDlur+TqqL8o6DmyLgOd/IVIrto9vDGgYeCrvgHYJmeygVgbEIlh4NFb/GSrRM7SlP9aN+xfFvzJQIiZcXpiPnylF0SoHfOICmdXOWEX9a3UMHDjhc47ao2fPon0Ex99gwffmZ/+qgL+OBsZndt6DOe3LxGZSumx8hpeGMfKcdxSNnADN0dIE0JkxEynaD6Ebq4bS0vJYDMOntUDbbJWhFBwPQwW9F4fCA4ErnRmCW5up9iHe9Kg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(35042699022)(23010399003)(36860700016)(14060799003)(82310400026)(22082099003)(18002099003)(13003099007)(56012099006)(10067099003)(260925021311599003)(260925022911599003)(5023799004)(11063799006)(4143699003)(260925021911599003)(261026121527099003)(261022115727099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8kQTciQgEKOaWR1+civ8jGDCVFuJL7a11tNHcoEt36HZSNfKsiYMa4Gx6UAP21FF13FwdyN7WhCrfLbdZLll+iXnoZyFSchXPkcYfCl7nKQB+loX7aubTlPXJ9aCQkxMqW9vioz90dN09xtAqIUi3wmPP4PjdXW2lhICZUkLHFZPR6h/3DrJ8chsPdpcet6JXex0YI8Ltt/hIfqpRxl7xg/8FWn9Kwc7eI4cmBCnpXxhP9cdpf6rri+7+pIsMPo2ywGqT4nfP+QEKtp5KPUQ8wR0FAR8BCq80wwB9GgmnjCwfxEhOTV2aCbfhRxDrEOitng2OHt6FtwZ5BOgkabRFpmmAcpL5ngwNFvbY1fDWUFT8aY13y+s+7ijpGebrLdsZ+9cnRmGvt92aCHazWvXn13RFIhIAoRo/vVb2haYMo54JaF552xTl9zJ2eg3xBoI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:10:40.4616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c57ba7-d1ea-4ed3-8e6b-08df3c39a60d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

On 06/11/2026 19:40, E Shattow wrote:
> Hi Jerome,
> 
> On 11/6/26 10:07, Jerome Forissier wrote:
>>> wget can write a disk image only after the whole file is in RAM. This
>>> series lets lwIP wget write the download to a block device while it
>>> arrives:
>>>
>>>   => wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
>>>
>>> The target is a whole device, a hardware partition, a partition by
>>> number or name, and an optional byte offset into it.
>>>
>>> Patch 1 fixes the buffer size check for a reply without Content-Length;
>>> patch 4 sets that check to the target size, and without the fix such a
>>> reply would be refused. Patch 2 lets a wget client take the data
>>> through a callback, patch 3 adds the block device writer, and patch 4
>>> adds the options to the command.
>>>
>>> Tested:
>>> - ROCK Pi 4A: a 1862270976-byte image to the SD card in 3 min 16 s to
>>>   3 min 35 s with a 4 MiB buffer; the first 1862270976 bytes of the
>>>   card have the sha256 of the image, and the card boots. A
>>>   2936012800-byte image, past the Content-Length limit below, took
>>>   4 min 18 s and checks and boots the same way.
>>> - QEMU arm64, virtio-blk: a 404 writes nothing; a file larger than the
>>>   target is refused before any write with Content-Length, and at the
>>>   end of the target without it.
>>> - sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
>>>   sandbox64_lwip.
>>>
>>> Notes:
>>> - lwIP's http_client.c reads Content-Length through an int, so from
>>>   2 GiB on the length is unknown and a file that does not fit fails
>>>   only at the end of the target.
>>> - EFI HTTP, the other user of check_buffer_size, retries with the
>>>   reported length when it exceeds the buffer (efi_net.c:1715), so a
>>>   reply without Content-Length still ends in a 4 GiB allocation there;
>>>   patch 1 does not change that.
>>> - checkpatch asks for IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM)"
>>>   in cmd/lwip/wget.c; that #if picks lines of the help string, as the
>>>   WGET_CACERT ones next to it do.
>>>
>>> gzip and zstd input follow in a separate series on top of this one.
>>>
>>> Signed-off-by: Igor Velkov <iav@iav.lv>
>>> ---
>>> Igor Velkov (4):
>>>       net: lwip: wget: accept a reply without Content-Length in the size check
>>>       net: lwip: wget: hand the payload to an optional sink
>>>       lib: add a stream sink for block devices
>>>       cmd: lwip: wget: write the download to a block device
>>>
>>>  cmd/Kconfig                      |   9 ++
>>>  cmd/lwip/wget.c                  | 107 +++++++++++++++++++++-
>>>  configs/sandbox64_lwip_defconfig |   1 +
>>>  configs/sandbox_defconfig        |   1 +
>>>  doc/usage/cmd/wget.rst           |  43 ++++++++-
>>>  include/net-common.h             |   6 ++
>>>  include/stream_sink.h            |  75 ++++++++++++++++
>>>  lib/Kconfig                      |   8 ++
>>>  lib/Makefile                     |   1 +
>>>  lib/stream_sink.c                | 189 +++++++++++++++++++++++++++++++++++++++
>>>  net/lwip/wget.c                  |  89 +++++++++++++++---
>>>  test/lib/Makefile                |   3 +
>>>  test/lib/stream_sink.c           | 137 ++++++++++++++++++++++++++++
>>>  13 files changed, 655 insertions(+), 14 deletions(-)
>>> ---
>>> base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
>>> change-id: 20261101-b4-wget-blk-r4-833f8a3d344e
>>>
>>> Best regards,
>>
>> Applied to u-boot-net branch for-main [1], thanks!
>>
>> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main
>>
>> [1/4] net: lwip: wget: accept a reply without Content-Length in the size check
>>       commit: 8498fbf8788eff07bc7fc59f9b15cf6c65025b10
>>
>> [2/4] net: lwip: wget: hand the payload to an optional sink
>>       commit: 40611fe0277a7a8f9639aab02a6f1a1e0e897d57
>>
>> [3/4] lib: add a stream sink for block devices
>>       commit: fdf4d9621c8b507f69fe0dd09fc53ebfe860fda5
>>
>> [4/4] cmd: lwip: wget: write the download to a block device
>>       commit: f0870bb385cf923bfab0baddacc952151efa4c39
>>
>> Best regards,
> 
> FYI stating my objection to making the wget command take these
> arguments, it seems short sighted and not very U-Boot -like.

Well the way U-Boot deals with command arguments is not its major
strength if you ask me. I think options are much easier to use than
positional arguments and can simplify the implementation too.
That being said...
> The functionality itself I have no objection to but including this
> command line argument complexity now for 'wget' implies that scripts and
> documentation will be built around this change and then we must maintain
> that compatibility, which is a bad design choice in my opinion.

...I agree that compatibility is a must and that we should not
introduce such a change lightly. Thanks for raising the point. Let's
see what others think. I will drop this series if it is deemed unacceptable
or if we simply need more time to discuss it.

Regards,
-- 
Jerome

> Respectfully,
> 
> -E

