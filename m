Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31092606D816
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1OVJMPLJ;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D24580F31;
	Fri,  6 Nov 2026 18:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hhn9bFRCdt8r; Fri,  6 Nov 2026 18:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB77B80C0D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988475;
	b=LNkHbndMEnLSbnnVxqK7eg0lt18jJw6lkTBNCg9B+NGDbCaMhCv2RAc5Yyt3clIWtKHK
	 9ru6I2u7fPhPiwRU/6+TvHbhxC7Gjax0QgvgLw1t5wEGoByff8zxN/xsRTpbw2C4SgEsF
	 OS+81slAQK9VhwsQMQ7bGv3QsSSnIv/Alblkuqdw2jKopRYrMQHxcqWymGh4y57PIBTh1
	 S8TC7m1O/H8ulD/wbDXA3iSxFab8fYlZ5WyBEVaCvCTSXP98Tvhj/EF2BlFNrY8F9ZwXE
	 +0DAXC2K7DvdJ7gibs2TK8mt5Lk5MW0OORx2k/kc5CSTaa8EhQGnkGH4tspQKTIC67A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
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
	bh=g8wKupQ0EZNel5QpR7GHcwy3vZ3jzRplMnKP/B13BUM=;
	b=QaCDvWyMU+hF/t0tm2bas9zdJKXIsDfoOoY/JxPkk+r9SE7PpuwJApoopfw7vAgelOSu
	 FSZhJqnjHb3/m0u8jnhrGqXctzEjLbyY8+87eHYA6b7hqZ/NcH+swdjEhm8btdOAEh3rh
	 FG+6H3ABA8FbdVYXAhD3YOX9HOGLf+Sa6NkDuLl5rsTH+T5Ym0CT2dnmsd//u40vz/50a
	 +4pRdENT9V5xg7202fU31pdBL93oo5mNhUQ+BR0Hc7eMJ1OQnH13jMENAlO11S248IE2+
	 X8PpGTudFw3Au/I4A6lXlQF4Sbq0HJQJBhwQd7YOosAn7fKDx0j4Z70LLMVWcG6fE/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988475;
	bh=g8wKupQ0EZNel5QpR7GHcwy3vZ3jzRplMnKP/B13BUM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1OVJMPLJrlS3VHj4DtrRESkNGw1FZgZhrvTQgKF91i1bSbMdanveBNwgtayy7dUC/
	 BT3iG/E7pEbYvBmVCbtsS0LBrT9klA9+0+nxMmWH2WtnzdUFBGoe1VE/wVX2qZypt9
	 HSkPbSp6LY0ebLhW4SeiIxRmwunAVP8Ds8P5k2GxNvLe5eC7R/O38CAiTjUTdFu3h0
	 nqlZ8pcyWQbG/nL0V3s0RDXnY/1LoRHC6AKaKn49ii16aut42pL2jSPGGrg+lLa35J
	 2zQPjmWXVIiWnDZD+hA7LkZfGAdjC40ne4zMHTyl+zeo/IPQX7Vq556TkUAarlK7Lr
	 kExaZGR+7d5Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB77B80C0D;
	Fri,  6 Nov 2026 18:07:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D15EB2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE6F380C0D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDbyTVCtpk4H for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92D9880AF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Mepw+c0U
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92D9880AF3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8wKupQ0EZNel5QpR7GHcwy3vZ3jzRplMnKP/B13BUM=;
 b=Mepw+c0UlkThpbEJsVpgIuJWzG37BjCvB7VeG57lVDW88/1mQL1uUG3JO75/6LFtMaLcgwzAQbrfpEQxM/bTHvd5G7GuzjGUnJZEtOXo+kTNcLe/S5uXzL4da39stU/+s6Zi0VSdBFeiaPFkW1j6CrEcxMmn0ssZAhjcYm9Zoq8=
Received: from DU6P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::9) by
 BESPR08MB11957.eurprd08.prod.outlook.com (2603:10a6:b10:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:46 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:10:53f:cafe::1a) by DU6P191CA0030.outlook.office365.com
 (2603:10a6:10:53f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:07:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8wKupQ0EZNel5QpR7GHcwy3vZ3jzRplMnKP/B13BUM=;
 b=Mepw+c0UlkThpbEJsVpgIuJWzG37BjCvB7VeG57lVDW88/1mQL1uUG3JO75/6LFtMaLcgwzAQbrfpEQxM/bTHvd5G7GuzjGUnJZEtOXo+kTNcLe/S5uXzL4da39stU/+s6Zi0VSdBFeiaPFkW1j6CrEcxMmn0ssZAhjcYm9Zoq8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:12 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:12 +0000
Message-ID: <537ee802-a68a-44c6-a955-89de64674f6f@arm.com>
Date: Fri, 6 Nov 2026 19:07:12 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/6] net: ftgmac100: Add RGMII delay support
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley
 <joel@jms.id.au>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
Content-Language: en-US
In-Reply-To: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|MAD0EPF000008B2:EE_|BESPR08MB11957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6ceeab-9f19-4276-ac8c-08df3c30dba4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: mCPGBRKbQOI2uwhJLmZQwYcUvGXzAQQVOaKvzOwljEfup3XK7sxcsqEJaTd8hXb3MgaVRRT2kyH/x6WJSONI6MGN31BdSaTaoa96UeT1A4KuF4ApoHrCtqbkCLoHyd8YPj+S60/0xuxBzXLr+V4SrV05AJy1Lsosa5cXyoIIrnLM5QfPuMgXThlcA23xoN1To+Y3DAZHmHQ2V13dW1QJ+Y9zNkVS/cUK+4e9dZYZJPkBAZj/2HOa6a/emZYTMYbtEo+60J/A9H+ZbcORCTrVRWYnoDhpdYFs05IQ5lxibe+XnAThUSAi/p8LErn9DgolvktYjYKZnLPPIKZKjGxBm7bwDW1wkdbh3jMZKhAP6oDVFEBBaQJj8VwUYejVUH7yL3lU6WR+sKqvbtO/XISlBX2RVdDeQZ6oYeKutSykPzthstownzXYtW4AjE6sIZ5xTEMhQzBOMEDqWehLJAMnF7mIO2WcDD0RHqKbqB7eBct6iGslWoR7f8iiZa1CrjFR44au0CqQalBVNqHWckTEHE63xEnU6ISdWOteVPTFmcbhedGt7xbRJq3vsM6/uOCbG2qfQ96oFqk0MZNWgEzEGrZN7lnqflwnuKQmsMVbhz8vuvQNDN6wDvpRBTG1edOP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: gxtoZ0751VX5sJn5YgXnPuYc7kiVVvM51v05gzoXEBG0aAmRGs73Kpb1Fssvy7OjgxDP1jWab9DWB1NwxbTDmMpBQWKEPpivfSLneQJGkKMoQhqQg34uVnXTnXIiYriBVk1epgsewwP0dXIqNQ2FDbExczIRkjcOukewRo8ZrBala2hhc9z5Rekbi7SZTRK5xnTunWFjsCC4VtmWq/TkWph/V9wB0SEkA/Pl+WuXdYK+If6RGaBtMn4dPQcEpPZlHEoPqxBwkhHCw/wFIqdP9vTyTFJh183RYns7hYgqzhlYQ9a0Z1QhmrDVmN5aHreCEf6NuAfptTCidIaSHwJ1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8255862-cf4e-401d-334c-08df3c30c85f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|7416014|23010399003|1800799024|82310400026|36860700016|14060799003|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: js9/kZbB2Yr6fMvg7yqQbuEPIymx/trIcGPVaCu45pBXW8hV3YzpCterivRkUsCC6nfampNb3UbsgpmMlVYADtUqunfycGydWHjttl2UQ5P4E4SFfv/+KKg8+VGYfJO8iUizmkQskLzlvBUyief4RC5qSEehuOFY3Nh8LAKuq6zCf0Gqf+1nIWeZfrvTcZAFCsa7Ua++Zs/NKuRArmebOvFZEU5eNP7YDyI1JkSH0kEJGlAsFJ4+EpIKDKFSQnPgxGmHuYLTdqW3u0lR1ej/kwcx+zWHiB5ktbO5uWsTFcyiseWv/RSAUa50a0w7+g7sOW/ciQzH9cpGCJRK0PaYHYZXxFuj0Fb6tn9Yupk4dz80NXl35cUjE9iEK0XDp2cpCxwxpmTE3DIa80SUNp6vf6BBUUzKa4LaOvw7t1Au+LDBHXvYjTarsbOpnbnrUFyLpmMsnLKMRVPefUgh5EGyLUBKKYpbT+b8Oqk7hWUheCrr5aX+PZlm26uP48VmnNBdnVgc70KDs07sRzcVqJJ0vq+xGbOrT6Ql4LXcwp1+hk4adZgvPqpXk8mSM8ypSHKLs0Jz3gwIX++ChuCHNbMgXNuRpsr5tD/6yOZ/1gnBDhd9EJfCXcZgRpZvF9dD5YnhQ62OAKz8acoTDp06L3xT6Kk59OEMrbkYgwkZn1UQ784=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(14060799003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: joiqpDj83orJqMPerRavOn1hg0oBLd9p0BkMmVEuGoWwFDvMzLCPtoVjJbfktlHMjlo8saIUgQmZd+L3/wL/FxTu4MDgcvNOfIdZIoptWc358O8xDg1NViTw0Fd3rb6XIrCzFPmdovYgLnb15BB4fjSnLPk5nvFclPAbdTNcWq4NSf4cPZTzjES0YuinV2ee4tHAv0p6oaW9wfdBBQ1vxoX3BdiPbK9cQAnS4Frgjg3s99HWQ9vLbnLMs3vgPFdtmrx+jwOKzdh0lUruB+punxvnV4D7FXMqWDwf6gn2uXUkZXc2bCfWyYIdEhcMUfaHL9G0hopQ420nWVXMVbJAYRMOjRU6YjWmnfQ0bjC+zbV1MqSatfZty4hpk9YjttkcBNKm5mUG6N4Xds3PqVLwL57+Wl/JWr4BcgmBOLvwf0wpkWRLZgjDkVqbOoUMb2mz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:44.9386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6ceeab-9f19-4276-ac8c-08df3c30dba4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB11957
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This series adds support for configuring the RGMII TX/RX internal
> clock delay on the FTGMAC100 driver via the tx-internal-delay-ps and
> rx-internal-delay-ps devicetree properties, matching the convention
> used by other Ethernet drivers for RGMII PHY delay configuration.
>
> On Aspeed AST2600 and AST2700, this delay is implemented as a
> per-MAC programmable delay chain in the SCU, so it needs to be
> configured by the MAC driver rather than relying solely on the PHY
> or the "phy-mode" strapping. The two properties are opt-in: the
> clock driver already programs a default delay into these same SCU
> registers, so unless a board's devicetree provides at least one of
> the two properties, the driver leaves the delay chain untouched
> instead of forcing it to zero and regressing boards that are not
> using this new MAC-side delay configuration.
>
> Patch 1 adds support for AST2600, and patch 2 extends it to AST2700.
> Patches 3-5 wire the feature up in the devicetree: patch 3 and 5 add
> the "aspeed,scu" phandle the driver needs to reach the SCU on AST2600
> and AST2700 respectively, and patch 4 switches ast2600-evb.dts to use
> it (phy-mode = "rgmii-id" with 0 ps MAC-side delay on all four MACs,
> replacing the unused legacy mac*-clk-delay properties under &scu).
>
> Patch 6 is unrelated to the MAC-side delay added by this series: it
> sets the TI DP83867 PHY's own internal delay explicitly for mac1 on
> the DDR5 variant of the AST2700 EVB, documenting a value that matches
> the driver's existing default instead of relying on it implicitly.
> It is included here because it was found while bringing this series
> up on that board.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> Jacky Chou (6):
>       net: ftgmac100: Add RGMII delay support for AST2600
>       net: ftgmac100: Add RGMII delay support for AST2700
>       arm: dts: ast2600: add aspeed,scu property for MAC
>       arm: dts: ast2600-evb: Configure RGMII delay for MAC
>       arm: dts: ast2700: add aspeed,scu property for MAC
>       arm: dts: ast2700-evb: Set TI DP83867 internal delay for mac1 PHY
>
>  arch/arm/dts/ast2600-evb.dts |  33 +++---
>  arch/arm/dts/ast2600.dtsi    |   4 +
>  arch/arm/dts/ast2700-evb.dts |   4 +
>  arch/arm/dts/ast2700.dtsi    |   3 +
>  drivers/net/Kconfig          |   1 +
>  drivers/net/ftgmac100.c      | 239 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/net/ftgmac100.h      |  33 ++++++
>  7 files changed, 283 insertions(+), 34 deletions(-)
> ---
> base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
> change-id: 20261021-ftgmac-rgmii-delay-1aae6ff0bdea
>
> Best regards,

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/6] net: ftgmac100: Add RGMII delay support for AST2600
      commit: 3a4df969f9b1a514f5ef9ae1998f9e2c459ec068

[2/6] net: ftgmac100: Add RGMII delay support for AST2700
      commit: 7be6cacf088bb8c39aaf350df705ffd3046f4a83

[3/6] arm: dts: ast2600: add aspeed,scu property for MAC
      commit: c687ee1b0f2ade2a55f2311cee65a09deefe93b1

[4/6] arm: dts: ast2600-evb: Configure RGMII delay for MAC
      commit: e2d3ed713ac523c1bd2c3a4cf785912b0a8776aa

[5/6] arm: dts: ast2700: add aspeed,scu property for MAC
      commit: e0acb7626cf1d742e9c018deec6bf13124e7e6ec

[6/6] arm: dts: ast2700-evb: Set TI DP83867 internal delay for mac1 PHY
      commit: c35db056f4bbad029d8a22561d481453032641f1

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
