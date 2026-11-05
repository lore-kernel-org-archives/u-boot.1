Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01262606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uA3rwGlI;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ct6Ndn6V;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ct6Ndn6V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2823A60855;
	Thu,  5 Nov 2026 13:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbjy6gZ-_qGl; Thu,  5 Nov 2026 13:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30FE76080C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793886479;
	b=VhZGoLFju02DPzNXbL997q4Z+ARd41tawa0ygjDuUnig1QhN+26c4FNLjKqFVAtS/3nf
	 SHv5Y/LJBPoGj6/U2bAoOTyDXQDmqAe0wmEAStnPOl3gDQOoAiS2qWUhwjPWuNVYU7wwj
	 6/B8xJWN3R6qXoxLgEyohJEXatlScwhqqEPnjTZzf8b9KOuqlSBOm4NEi4GibuZlqGKfG
	 1mH6k8B2DD6Pi+a1osfJ78FjZjW/wucFcDbwAv/AfoHcFX2ZRkRSrqYDI3hmvFlncqDlG
	 Z6Lb7zsN/8tskxKr8iE/t1Tcqr3OnS5lv79Z407kXp8+X9wDMZTTuzjYFHfZg4rWPqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886479;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z/6G0GQU5ZWRAHBb2egNcRmgog1cnfsMmq85TrokRwY=;
	b=M9WsNUyQUfionFLpz6NjpdhC1IoEYefgvAyKCBigqA47L8nKXHsEhJdFc4q0SB3AvlC1
	 BY8uNvrWsJEvDndqD0ast00L9zCFjcoMgrwebqxX3ocAW0AfuhTNG5ysMPUOTYLLLWyUt
	 1SfsqLKp6Ewt6M+aKjd2AoBz3HsjPnolbNPEfbBL3IEeo+IrqB6gj/k9wdJpevWW6QBzA
	 ZC9et8W3XyyAUqTWMTHFT4PJUlb2rab8HQatCC/0qsZNJMpn6SLr3dd95sCRu1m+IYPNZ
	 wh/0D7rF4OIvMon3dxBfrKLKGRmsrRGOmk0SLIDga4XdDeqgwBkWNNh1KZmPIrXFTaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793886479;
	bh=z/6G0GQU5ZWRAHBb2egNcRmgog1cnfsMmq85TrokRwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uA3rwGlIWyWB0Rg443OcwF8kk56pz63MCHOixbQHh9v5RkOpY+na9Vcn8xyTm0dYY
	 GUQwXGDnwbKF1H56ond0Uh5JuXBHF9ZYPEMuyiMdO5e/12QuUJ+ztnAfQjMTrm5Qwj
	 vyYtDoPGRnB9VigLpZT4Toj4c0YZnX2dK6OdqhmUD42XqGi833JWOxoDsvpKcJBSX8
	 MLqS7Fh8jEoJ/YlWgjGhMTw27DEwtwSa0CCxgCce11D3TCQRSe6CZFh9lxWxDYK177
	 URcDFIdCtqBjv0lcIZdyvKAjHOdzbZi3/tHJ4CtmHK9cEgt1K9ONcH98DpwoNSwy0p
	 JgsDMhpbW0EvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30FE76080C;
	Thu,  5 Nov 2026 13:47:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 402511779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 315554008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4LRplZ0yl3k for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 11:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBF584007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Ct6Ndn6V; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Ct6Ndn6V
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBF584007E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/6G0GQU5ZWRAHBb2egNcRmgog1cnfsMmq85TrokRwY=;
 b=Ct6Ndn6VmHf+jpHcOKdBtBIr9UeKzfyR73l3xycAJY8nozqc7skYid8wEr1RrazG+JE7cJEzHcbidz3+01kCnw1dugMdNoe29u+TO7lnOkEaGZpMfyjNVgyRMym3QI+KxU001H0yt8LKeFJ1pY///icgaQPi7TrQbfR9xWYxI4M=
Received: from MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::18) by
 VI0PR08MB10389.eurprd08.prod.outlook.com (2603:10a6:800:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 11:42:37 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:290:2:cafe::4c) by MI1P293CA0007.outlook.office365.com
 (2603:10a6:290:2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:42:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Thu, 5 Nov 2026 11:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/6G0GQU5ZWRAHBb2egNcRmgog1cnfsMmq85TrokRwY=;
 b=Ct6Ndn6VmHf+jpHcOKdBtBIr9UeKzfyR73l3xycAJY8nozqc7skYid8wEr1RrazG+JE7cJEzHcbidz3+01kCnw1dugMdNoe29u+TO7lnOkEaGZpMfyjNVgyRMym3QI+KxU001H0yt8LKeFJ1pY///icgaQPi7TrQbfR9xWYxI4M=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB9792.eurprd08.prod.outlook.com (2603:10a6:20b:613::5)
 by VE1PR08MB5614.eurprd08.prod.outlook.com (2603:10a6:800:1a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:42:02 +0000
Received: from AS8PR08MB9792.eurprd08.prod.outlook.com
 ([fe80::dcb0:37c8:d77c:438c]) by AS8PR08MB9792.eurprd08.prod.outlook.com
 ([fe80::dcb0:37c8:d77c:438c%3]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 11:42:02 +0000
Message-ID: <1a4b268c-0a5b-4202-8027-eb9e926edd7c@arm.com>
Date: Thu, 5 Nov 2026 11:42:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
 <c927a9789a43f0903237040cced800e077bea7c5.1792001844.git.harsimransingh.tungal@arm.com>
 <CAC_iWj+yDFHL7AWT+z0caOWMPFWut7CkOX_2vJM5HW3xrU0-ow@mail.gmail.com>
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWj+yDFHL7AWT+z0caOWMPFWut7CkOX_2vJM5HW3xrU0-ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To AS8PR08MB9792.eurprd08.prod.outlook.com
 (2603:10a6:20b:613::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR08MB9792:EE_|VE1PR08MB5614:EE_|MI3PEPF00008482:EE_|VI0PR08MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: f865d543-2fb3-42ee-61f4-08df3b31e3f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|261026135527099003|56012099006|11063799006|261026130827099003|4143699003|261022075727099003|261021121427099003|261022115727099003|261022105027099003|261021133027099003|261021135927099003|261022113327099003|261021130227099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: KC6naCJR2HgKcjATkQcneP99X1By6i4VQwURlk86CAXfi4g1zyeDFN43kI099+lyBLucrAMw+sZfa1CrbhS8+Dcuo8SlR3BvI9HsaIMI5Sf6JilK1ZOjqjiuh5ITr4D4H5y4Czb0Hn5fxh2P9UP0u9vroVJfEC6Agn1hkC8A0V82QJJZO6ZEkcfGa7lAE0qERtpg2UDw05nQ1nBsajpsIxveuHpvJyHuD2k/7aJDQaD88dQF6Qxft2+V2qRa3p1T+Iewbz4bV6rqFIpKALxSYf1bupadfeDCBRNJ7WXbD/8cla/Em5QSzmw4I+GxkkTuey1dGeXf6DWsipxi+ENrHsMMR67NcV7jbSf5pd018LW7DMsv5pC0omDWrOMlEKkpMBTkxGMSl4N30uvCw7/9uRHI/RV4IWsUtM99BFu+0YjslYCLgZTQ+aPxIHQORgXR7PmmHgFUShcQh9drmX1olz/vnVm8VdiVgjjXFbJIDPtDNhB7Jsa14YGp+CSNkVIZ3nT9NIIZBKdVztNin3Qst1azLcZrnmBZ2xWr0yWu7FNHonqVEQGiPlz4ZHuJwLE7GK/Mj0JfH1vR2PnIfy4TFcfFNUDmbCE5bD5wz7EBOy0iOYSuxpCrXKXVHzGQI6bwReRlACYe2HCcx4KaA3Op3UZNoaXFc/fGFvaul1UgdjE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB9792.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261026135527099003)(56012099006)(11063799006)(261026130827099003)(4143699003)(261022075727099003)(261021121427099003)(261022115727099003)(261022105027099003)(261021133027099003)(261021135927099003)(261022113327099003)(261021130227099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bRcl8LhtfK5wR89yWMGailvnTPHqx92fl/SfxEGYIgbYyIKmLwX4Dxi+R11p7eTLHhCiHhkdIncAcu+hDA3D9aix3I+bilxXekWs3OVbKdcuYGhq1XkYHV15tMb8U0U9Dut9FkiUiOuhctrdQNlDCjA6xYaW80/AULpTfGxvl4e3BUgcVH6KvFby8xe48BryL7utIyUSv7NiPZ2u64Ru5kIe2BGrQlza+B6ivzSc8S/aBqeXqfDmyvhDCMAZJaJUUNK1hrg9NWDjfvE74MLiHnjQROL6kFqD5Tnq66SijF62xYl3gqVENUHzrk/6x/WA2KZ1KgHm2V/WPB7GvYOBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5614
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1075f94b-0f1c-40d5-7a4d-08df3b31ceb2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|14060799003|1800799024|23010399003|35042699022|6133799003|10067099003|22082099003|18002099003|261102123227099003|56012099006|261021133027099003|261022075727099003|11063799006|4143699003|261021121427099003|261026140227099003|261026121527099003|261026130827099003|261022113327099003|261026135527099003|261028144727099003|261022115727099003|261021130227099003|261022105027099003|261009223027099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: kDrDHumyTR1H63paQ5mPZ0DHboyNq32GF8PwIUgnU7mvqFGHRtu8ECS8jpeKvw/cLbvB874ymiwFqZtaY67kaiVS5oYa6Ws01wyPKkaCWYxh215oZqvhBHA5znE2jS8Py65UJ5eIUOak+dO3cFkk/KUiSo2UFoFtUF9oBWFa/M8MnfQuybZojvLdBaN2FSqEI+ulZKj3286XQnJfuJZ5o8+W+y1PuoQMlP8RpRCLyrlbOlZ+fWy43S0PDSPHnzruHEHkNxwJpBVVpPPjGbxe4Z0MC3wlxpm9KRt3YOk5f5mY5IkjGmHPEeNoRbqxEv3qjgB8A4c/JJXY33jGcMQ3iUyVWWl0Yffvy6xmXrGdKPKBsILfUBBgBPOXu6d0fUxYmRdZdF1wxaDulCBwF+wjB3sNvbJ7L47uf7ebw68BdxrZ+0xcR0tEl0y5biyHLO6kiG2bvh95iXPfQAAKzztJ4NtsxgHl2C+Zzss7O6zICiFjNVc053ued2QZh1H3GMcnX3CgJjbtJa84KQ8E0NCfi1yknh9Rcfcm3pcyvvuyc9qvWRrKkwGjFlR/cdL24dEHZpFyaCN6026u1kVvR8wg/p2Uq43Ih1FEJuTdMMSt0VnB/atLImq5oJX2NmL5N8ydF6ntdrFma6kB8FktMgIkZJSzpd00TkXwqf/B4clWi4uZagr8ckiQMyPt2d8mY6bRvSGtEsVnXfSRwe2W+Kz90A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(14060799003)(1800799024)(23010399003)(35042699022)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(261021133027099003)(261022075727099003)(11063799006)(4143699003)(261021121427099003)(261026140227099003)(261026121527099003)(261026130827099003)(261022113327099003)(261026135527099003)(261028144727099003)(261022115727099003)(261021130227099003)(261022105027099003)(261009223027099003)(261021135927099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VZ1WFuXY4k2ruFG8c+j8k0PDfvqAMzMf7aKEiYf0cH7kTmzovgbRx2kxDDwwMt3gIe1YU1+OYSYRfNiddxL92MGvIReBXFA5lfyQf7jgP0kt8Yq0JmnQeKrzYC0/8aRxnEMZ3Ze4UUwPR5XwnogC1C60OY6rt9yc5Ce2VQqRoD6dVZEYa53wPFhGomSYpTnZwIBXkkte1T85kT6Q0tPWp2/sX2qm6JGuCPwCi3jAnp5dgl8/quXLyRaM6AAgmDp5c1RbVFjOGKkfnlk7QuYcYiL5es4I4hZXj5p7zevBw6H8hZVHQC98yuJ6Pzv6n4iDyotnNStDcvgG2baokpuixSrHlIDZZsuTCiY9indBOoRQpGZqWEqv2Td0WYovDmKvmOzHijU2Hu0LuD0OBgOAeNZtnGj8OvAyWKw/DmbpIflRAtwv9TLr/U3EWZFIBwtj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:42:37.1977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f865d543-2fb3-42ee-61f4-08df3b31e3f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10389
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:47:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27/10/2026 11:45, Ilias Apalodimas wrote:
> Hi Harsimran,
>
> [...]
>
>> +       efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
>> +       struct var_check_property var_property;
>> +       struct smm_variable_access *var_acc;
>> +       efi_uintn_t payload_size;
>> +       efi_uintn_t name_size;
>> +       u8 *comm_buf =3D NULL;
>> +       bool ro;
>> +
>> +       if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       if (data_size > 0 && !data)
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       /* Check payload size */
>> +       name_size =3D u16_strsize(variable_name);
>> +       payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + da=
ta_size;
>> +       if (payload_size > max_payload_size)
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
>> +       attributes &=3D EFI_VARIABLE_MASK;
>> +
>> +       ret =3D get_property_int(variable_name, name_size, guid,
>> +                              &var_property);
>> +       if (ret !=3D EFI_SUCCESS)
>> +               return ret;
>> +
>> +       if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONL=
Y)
>> +               return EFI_WRITE_PROTECTED;
>> +
>> +       comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
>> +                               SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret=
);
>> +       if (!comm_buf)
>> +               return ret;
>> +
>> +       /* Fill in contents */
>> +       efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
>> +       var_acc->data_size =3D data_size;
>> +       var_acc->name_size =3D name_size;
>> +       var_acc->attr =3D attributes;
>> +       efi_memcpy_runtime(var_acc->name, variable_name, name_size);
>> +       efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_s=
ize);
>> +
>> +       /* Communicate */
>> +       ret =3D mm_communicate(comm_buf, payload_size);
>> +       if (ret !=3D EFI_SUCCESS)
>> +               mm_communicate_ret =3D ret;
>> +
>> +       if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_=
READ_ONLY)) {
>> +               var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_RE=
VISION;
>> +               var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_R=
EAD_ONLY;
>> +               var_property.attributes =3D attributes;
>> +               var_property.minsize =3D 1;
>> +               var_property.maxsize =3D data_size;
>> +               ret =3D set_property_int(variable_name, name_size, guid,=
 &var_property);
>> +       }
>> +
>> +       return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_commun=
icate_ret;
>> +}
>> +
>> +/**
>> + * efi_query_variable_info() - get information about EFI variables
>> + *
>> + * This function implements the QueryVariableInfo() runtime service.
>> + *
>> + * See the Unified Extensible Firmware Interface (UEFI) specification f=
or
>> + * details.
>> + *
>> + * @attributes:                         bitmask to select variables to =
be
>> + *                                      queried
>> + * @maximum_variable_storage_size:      maximum size of storage area fo=
r the
>> + *                                      selected variable types
>> + * @remaining_variable_storage_size:    remaining size of storage are f=
or the
>> + *                                      selected variable types
>> + * @maximum_variable_size:              maximum size of a variable of t=
he
>> + *                                      selected type
>> + * Return:                              status code
>> + */
>> +efi_status_t EFIAPI __efi_runtime
>> +efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_stora=
ge_size,
>> +                               u64 *remain_variable_storage_size,
>> +                               u64 *max_variable_size)
>> +{
>> +       return EFI_UNSUPPORTED;
>
> This will lead to a compile time error
> lib/efi_loader/efi_variable_tee.c:1179:1: error: redefinition of
> =E2=80=98efi_query_variable_info_runtime=E2=80=99
>  1179 | efi_query_variable_info_runtime(u32 attributes, u64
> *max_variable_storage_size,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/efi_loader/efi_variable_tee.c:1074:1: note: previous definition of
> =E2=80=98efi_query_variable_info_runtime=E2=80=99 with type =E2=80=98efi_=
status_t(u32,  u64 *,
> u64 *, u64 *)=E2=80=99 {aka =E2=80=98long unsigned int(unsigned int,  lon=
g long
> unsigned int *, long long unsigned int *, long long unsigned int *)=E2=80=
=99}
>  1074 | efi_query_variable_info_runtime(u32 attributes, u64
> *max_variable_storage_size,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Is what I am getting locally.
>
> Each patch needs to apply individually without breakage/errors.
>
> Cheers
> /Ilias

Hi Ilias,

Thanks, you are right. The final tree was fine, but the intermediate
SetVariable patch was not buildable.
If you have already spotted anything else in the series, please let me
know. Otherwise I will include this fix in v7.

Regards
Harsimran Singh Tungal
>> +}
>> +
>> +/**
>> + * efi_set_variable_runtime() - runtime implementation of SetVariable()
>> + *
>> + * This function implements the SetVariable() runtime service for OP-TE=
E
>> + * without FF-A runtime transport.
>> + *
>> + * @variable_name:      name of the variable
>> + * @guid:               vendor GUID
>> + * @attributes:         attributes of the variable
>> + * @data_size:          size of the buffer with the variable value
>> + * @data:               buffer with the variable value
>> + * Return:              status code
>> + */
>> +static efi_status_t __efi_runtime EFIAPI
>>  efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
>>                          u32 attributes, efi_uintn_t data_size,
>>                          const void *data)
>> @@ -1124,12 +1233,16 @@ void efi_variables_boot_exit_notify(void)
>>         free(var_buf);
>>
>>         /* Update runtime service table */
>> +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
>> +               efi_runtime_services.set_variable =3D efi_set_variable_f=
fa_runtime;
>> +       } else {
>> +               efi_runtime_services.set_variable =3D efi_set_variable_r=
untime;
>> +       }
>>         efi_runtime_services.query_variable_info =3D
>>                         efi_query_variable_info_runtime;
>>         efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>>         efi_runtime_services.get_next_variable_name =3D
>>                         efi_get_next_variable_name_runtime;
>> -       efi_runtime_services.set_variable =3D efi_set_variable_runtime;
>>         efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>
>>         /* Record that ExitBootServices() has been called */
>> --
>> 2.43.0
>>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
