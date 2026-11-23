Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33C606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ztxAAYwL;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AZdX1D67;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AZdX1D67
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF5AC80D82;
	Mon, 23 Nov 2026 13:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7ebDZDJ2nVC; Mon, 23 Nov 2026 13:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B1C7080E4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440237;
	b=I/Y33Zy/+f59Zqfs2pqAq4w2l6HPtfQEsDiMv2zd045NE4v9EdrmDUgPYkUjgu6JrCtW
	 ECSlHuxu0oAKkHWjMUyYMBONi5ZHPf9kyAJVjALy8O0SKHkHr4r5LNtDfg0OrQ4LA/BEf
	 aydoFpkr3Z1wbGGNAp8byIrUcKwrTuFoa8+vq/oq30h31DbFzD0LMja5rH3zNxNPWk7BS
	 O0kgTPEUnw/Us9alikhyMW1yhEL3yzITaNOVbEf97IQVW7gzfRvVqoV9mFLTO+eQkV4Q+
	 fWXphpAldeMNxto/PoJ+LsnB6J8GQjnljflvKxAOJZjAK24NbZqOxBbxo+R5QPshzFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440237;
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
	bh=Z5oDqlPigxYL1TcoEtBzim0hpaz+i423qYSblMEbk0k=;
	b=Wu5CuEYly7Sta+062Oo9OpDRjPOJ4HPlIhty5aUCTKlcj9HwQxWsCVHuDYTb1AtFoMJ5
	 jdjMDOFh55QJCTljPcmC4b2QNsv16XdNsxNv+PIBhi2DTbuxQuBx8ZVrwQgyD3zZL0ASl
	 PQndLkqD6BZ5b4eb4J95dBSQndLDREyUAcO2fMdqv9DfcKi8NvEjZBIepfiBTwgmX4BND
	 xxKWd8DDy4aVNmfKZLVurlpq/j4Co9R6NtsTKgUu346baaqG1PA1d7OG23d7ioL1Vd/UF
	 K61OZrj+mUx24NtVm0XeQJokDAxqOdcjeJ/oWnw+jWcf7EmrYL5bO/y5Qxo0K2qL4hw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440237;
	bh=Z5oDqlPigxYL1TcoEtBzim0hpaz+i423qYSblMEbk0k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztxAAYwLVpx5+IFXpLHksCeDWKY2tAGwvZJ81IJ/KE9bzmwpzLOmL7WaAJqIzkYpb
	 TBSxBN+8+DlhoiLw69YOnB+ankCNaMXXkpOdq6s98eV6VD+910hsmraNBE/SMx+C9D
	 YXA6hMImStZ5BKLR8fftwPwjDk2M17btrge+1J+Sl4ex/pI1WDv6s0sJNDGk4JoaDf
	 sQy03FbfQesod3NBUYbzSGT8RbEEIPa9qfch5zq3B9r/mKX+kPT3ueK91PhxkH7ahC
	 /4Du2UI2exY4qu2lFmAB6BAg4HRXf7mTN1WvijOwlJkFLMhU/3r49XPH49Zk1bK+YR
	 cT47bCbH0upCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1C7080E4D;
	Mon, 23 Nov 2026 13:23:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4CF93A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA9FA40718
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmwxQrmKlH3B for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B54240712
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=AZdX1D67; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=AZdX1D67
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B54240712
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5oDqlPigxYL1TcoEtBzim0hpaz+i423qYSblMEbk0k=;
 b=AZdX1D674eVXdFRclyyA3H8PZV2wKoMyfUPHlhl45qnEN1WwI+PBfDkuVEM+AZ3sr5JZKimFiVKbNSKfKaD0iEEUryzME8NPvSMQX9apgcScbmltMM0BjpsjThRgdZgAVMYqE5VkrAxKqQWobHmGEPO4Q/fyYV8GrxZNzliEhL4=
Received: from PA7P264CA0137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::6)
 by PA4PR08MB6303.eurprd08.prod.outlook.com (2603:10a6:102:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 13:23:45 +0000
Received: from AM7PEPF00000053.EURPRD83.prod.outlook.com
 (2603:10a6:102:377:cafe::3b) by PA7P264CA0137.outlook.office365.com
 (2603:10a6:102:377::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:23:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000053.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Mon, 23 Nov 2026 13:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5oDqlPigxYL1TcoEtBzim0hpaz+i423qYSblMEbk0k=;
 b=AZdX1D674eVXdFRclyyA3H8PZV2wKoMyfUPHlhl45qnEN1WwI+PBfDkuVEM+AZ3sr5JZKimFiVKbNSKfKaD0iEEUryzME8NPvSMQX9apgcScbmltMM0BjpsjThRgdZgAVMYqE5VkrAxKqQWobHmGEPO4Q/fyYV8GrxZNzliEhL4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5596.eurprd08.prod.outlook.com
 (2603:10a6:102:88::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 13:23:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:23:08 +0000
Message-ID: <feff6af6-a52e-4aac-ab2c-86401ec622a4@arm.com>
Date: Mon, 23 Nov 2026 14:23:07 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 00/19] net: lwip: enable IPv6 networking and boot clients
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Igor Velkov <iav@iav.lv>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Murtaza Munaim <murtaza@saramena.us>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Drew Kluemke <ankluemk@microsoft.com>, nd@arm.com
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
Content-Language: en-US
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5596:EE_|AM7PEPF00000053:EE_|PA4PR08MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8601f87b-7678-48db-c2fd-08df4964ffce
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|261021135927099003|261021123027099003|261021121427099003|261021133027099003|261021130227099003|261022105027099003|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261102123227099003|261022113327099003|261022115727099003|261022075727099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: GHC+HBf+T50UOXux4g70TpWw7mokYYuu3uDMt0CueHXj96X+zv/h2dLFz/sSxe1dHnz+6tsU3uxF4bLkMqzkwC3vYs88cOHZ5L4a96uP7164Jg6+PGolOOj2N6zf0OzwyJsiMlIqpykdLTcTNvKBrvIiGl29VrLLpjyrSM1n6yGXtIAgdYkt3JG1j3u04mFvARril1azdKyiPGG/HELrkI882QpcopqbselO53kBLswCXd789epREeRn4q1io5ScB5svn7ByNfAcPUI4bHXPonSNFBp32phtJy38YDax3narJN+Eg+YjeiEj64LGeSx5LYzvO3LFCUfiy/vxQFocf/4K2+nVtrz2da3LTyfD9evbSOsdVcIKo2mNzVdxYqTjbuV3Pvshwot3kzZKHm9Zt8tw/4dsu+jvQrqZa7amccR64g0pYVEIw/OXbDxbsQAvrK479fBTRTCL6NnNL+81TgwHPwCvyr095Jl/7uib2L0ZuG7oFd0x2kbH+4e9UXiq+FhZ9MB2AtVR/dskTNhnw33GOWtGOPZ4z5G/bjb/DPqh0/GvLrE16pYAu5Vx1ciXdEi9aEaQXLC/Xjh8uAfTOkT2hDGzUV6AF8zBwSA3IFw4IW9FKtmKMOHOpVNb6VXk
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021135927099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021130227099003)(261022105027099003)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261102123227099003)(261022113327099003)(261022115727099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: HyxLKu5ey2GKHgTzqF6F8SHCBrnrB6CGoZfWEmFrLJuuFIv8Lh90wEjLluZYDm3ypnqVHcuGLXRfVIPilGmt8jez4feRGPvqYgwJgCQpkn1s6IKWbY1SYF4+EHpAzB6H/EJeU7AOV4T4mPcd5lvn6mlgzQaxSVn4WItAfyqOKM/QkVBcfc/vAjx/oe1DWNpOGI79/GJLVCnU1lNQYhJhqnBLdITtFfhbwFbAmVxxOLk1FxiLNR+ZSU/ueKSpxymTp4J+sNiSg8cWcLzWLSw/ScIfBOCAevJT7nn67NO+ccJ86zns10jWEzt2/geQ5mr3zlBNEvCyrOhm1ulD2R46qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5596
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 488fe505-2f7b-4dae-dc96-08df4964ea4d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|14060799003|35042699022|82310400026|1800799024|7416014|376014|261026121527099003|261026135527099003|261026130827099003|261026140227099003|261022075727099003|261022113327099003|261022105027099003|261022115727099003|261028144727099003|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: XcqUBw6SOhH+fCEKOgXvPdPqCkHdZMoQxv83CX+L0FG4NYWsoRTNh2LPA5sYv9P9x61kT9cqo4czwVCFnrUl1njVpk4HTN5gSnKhbZyrJpC7e72O/bkxR1uaA0raq1axUDqGt0kKR+CuePeKEbWl7H7UeVJBK1weNLFO2lQ5fz9FL5els41aulmxwcdQ2oqxFfZ0igCQBGyMi2XJs6TZssxpN1RXwXleE9PojTwaFx1linW46J7ry1zwnZ26OOkcAyZvg5atbnDWbIfubl7CPwIwrx2DG01TdcvGQe5L7rmuDEfc/qr6dk3jmGx+XOZiJ7iTZR3g1/MMkT2c2c0KMitntx6IAQ8rwBgGIbjRDUMjVoR2ZBeLExD/eri4Fzl2Z5sfN8MHGkQEdUDkLU6enWyRnLssp7WqWfBUMPckklCWhIILpklX7Rkq7vBEdqeZxd0WCrsI+g4tcnXbIH+1sxRrebJlcOIOm30pG5SzoveWYx1WeOFwtynerxeQEOv1LqZ0Pmc61f2tB/EqeHb9hnJJ95KOnY1IfunndNevh9PfXcpEuA90BFeiAX6gWhIdrfxWqhY1ERNMNO59cM1idGPrsN0G85iJiTt1Z+C4m/Dm8Iq76GtgQYRxBiw/d8O+CZrUDuORp5J+aDsrq7TXGMSKsV/HgX6UxhhWDTMz3AI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(14060799003)(35042699022)(82310400026)(1800799024)(7416014)(376014)(261026121527099003)(261026135527099003)(261026130827099003)(261026140227099003)(261022075727099003)(261022113327099003)(261022105027099003)(261022115727099003)(261028144727099003)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UBt6K5XoOyR/xjFc0eQ+iZcbeiiuUrj1D2cc5Odc7q8Kf96yu/OQCi7Owx0Kohm4PvZNJmwnfz+JJIOHBb7XYmBQaedyN8BW7hS5KFRIufvD01HZgCBONgoxBNuy6gIOF1anN1b9GZ+Fy5n2CM+owwOFzFM1T0hSHFvUzRk1oxWA+7ARUipGEXmXZWXHxE5LIni02TIAT3QU8U0WO4p9Dz8q+hfFa3AJgWpThbjnLNh46wy80PYMjkB2E0s2IlViV/ImM/njn5WIK7h0rdli/zXachdon1gPKYst7MmMHp64Qga7aop3o27BzEyX5F9NvTyW5KC4hLYWFstRU6YqnbNpc0+5dJR0RcHCJtFaVWi1QwaMS4BPfyqWMhrE063RVY6nPXxfeAjxe8PSpETBdt2TaL8vNdxeuwb+SQ2K82V2gTC38cNKg/f1Dmcuu2Wk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:23:44.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8601f87b-7678-48db-c2fd-08df4964ffce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6303
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

> Enable IPv6 alongside IPv4 in the lwIP network stack. Configure link-local
> or static addresses on the selected Ethernet interface, perform duplicate
> address detection, and learn prefixes and routes through router discovery
> and SLAAC. Static addresses support explicit prefix lengths. DHCPv6
> supplies addresses, DNS and TFTP or HTTP(S) boot URLs, and renews or
> rebinds leases while networking is active.
>
> Extend ping, TFTP clients and server, HTTP/HTTPS, NFS, SNTP and netconsole
> to IPv6. Resolve hostnames in the active network context, including AAAA
> lookups over IPv6 and DNS servers advertised by routers. Preserve the
> original hostname for HTTP requests and TLS certificate verification.
>
> Clients share the network runtime with IPv4 and persistent users. Transfers
> wait for a usable source address and route; lwIP resolves neighbors as
> packets are sent. Teardown releases learned addresses, routes and DNS
> state. Finite learned lifetimes include gaps in network polling. DHCPv6
> retains lease age across commands and rejects expired or withdrawn
> addresses. IPv6 NFS discovers UDP services through RPCBIND.
>
> Preparatory changes make address users dual-stack-safe, keep sandbox raw
> traffic on the selected interface, map CA certificate buffers, preserve
> the scheme and authority of wget URLs, and handle TFTP headers split
> across receive buffers after IPv6 reassembly. The series also propagates
> IPv6 port-unreachable errors to active TFTP transfers and adds sandbox
> protocol tests.
>
> Based on U-Boot main at 8ea02c99391d.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> ---
> James Hilliard (19):
>       net: lwip: handle TFTP headers spanning receive buffers
>       net: sandbox: bind raw packets to the selected interface
>       cmd: wget: map CA certificate buffers before copying
>       net: lwip: recognize wget URL schemes only at the beginning
>       net: lwip: prepare address users for dual-stack builds
>       net: lwip: configure IPv6 on the shared network interface
>       net: lwip: add the ping6 command
>       net: lwip: support IPv6 TFTP clients
>       net: lwip: resolve hostnames on IPv6 networks
>       net: lwip: support IPv6 TFTP listeners and server names
>       net: lwip: report IPv6 TFTP port-unreachable errors
>       net: lwip: support IPv6 NFS and SNTP servers
>       net: lwip: support IPv6 HTTP and HTTPS transfers
>       net: lwip: support IPv6 netconsole peers
>       net: lwip: acquire and maintain DHCPv6 boot configuration
>       net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
>       test: net: exercise lwIP IPv6 addressing and DNS
>       test: net: exercise lwIP IPv6 application transfers
>       test: net: exercise lwIP DHCPv6 lease and boot lifecycles
>
>  arch/sandbox/cpu/eth-raw-os.c                     |   12 +-
>  cmd/Kconfig                                       |   25 +-
>  cmd/lwip/Makefile                                 |    4 +-
>  cmd/lwip/dns.c                                    |    4 +-
>  cmd/lwip/nfs.c                                    |    5 +-
>  cmd/lwip/ping.c                                   |  127 +-
>  cmd/lwip/sntp.c                                   |   38 +-
>  cmd/lwip/tftp.c                                   |    8 +-
>  cmd/lwip/tftpput.c                                |    8 +-
>  cmd/lwip/tftpsrv.c                                |    4 +-
>  cmd/lwip/wget.c                                   |   17 +-
>  drivers/net/netconsole-lwip.c                     |   86 +-
>  drivers/net/netconsole.c                          |   18 +-
>  drivers/net/netconsole.h                          |    8 +
>  include/net-lwip.h                                |   28 +-
>  lib/lwip/lwip/src/apps/http/http_client.c         |   27 +-
>  lib/lwip/lwip/src/apps/tftp/tftp.c                |   12 +-
>  lib/lwip/lwip/src/core/dns.c                      |   28 +-
>  lib/lwip/lwip/src/core/ipv6/icmp6.c               |    9 +
>  lib/lwip/lwip/src/core/ipv6/ip6.c                 |   14 +-
>  lib/lwip/lwip/src/core/ipv6/nd6.c                 |  339 ++-
>  lib/lwip/lwip/src/include/lwip/apps/http_client.h |    3 +
>  lib/lwip/lwip/src/include/lwip/ip6_addr.h         |    2 +-
>  lib/lwip/lwip/src/include/lwip/nd6.h              |    4 +
>  lib/lwip/u-boot/lwip-hooks.h                      |   41 +
>  lib/lwip/u-boot/lwipopts.h                        |   12 +-
>  net/Kconfig                                       |    4 +-
>  net/lwip/Makefile                                 |    1 +
>  net/lwip/dhcp6.c                                  |  999 +++++++
>  net/lwip/dns.c                                    |  245 +-
>  net/lwip/icmp_unreach.c                           |   33 +
>  net/lwip/net-lwip.c                               |  487 +++-
>  net/lwip/nfs.c                                    |   48 +-
>  net/lwip/tftp.c                                   |  167 +-
>  net/lwip/wget.c                                   |   84 +-
>  net/nfs-common.c                                  |   73 +-
>  net/nfs-common.h                                  |    2 +
>  test/dm/Makefile                                  |    3 +
>  test/dm/eth.c                                     |    4 +-
>  test/dm/lwip.c                                    |   49 +
>  test/dm/lwip_dhcp_policy.c                        |    2 +-
>  test/dm/lwip_ipv6.c                               | 3098 +++++++++++++++++++++
>  42 files changed, 5690 insertions(+), 492 deletions(-)
> ---
> base-commit: 8ea02c99391d2d922810065206721ead2863f075
> change-id: 20261109-submit-lwip-ipv6-v1-22dd73c3b448
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-next [1] with local modifications, thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/19] net: lwip: handle TFTP headers spanning receive buffers
      commit: 240e055c56cf43951322fd9f79917a8973ff5f4c

[2/19] net: sandbox: bind raw packets to the selected interface
      commit: 09de86137571800a9c3d3ea80c69354430e69b2d

[3/19] cmd: wget: map CA certificate buffers before copying
      commit: aab55c414ca817eb99ddc2a591dc76cd90bfbe84

[4/19] net: lwip: recognize wget URL schemes only at the beginning
      commit: 22f984624a9fa12fe77493032af40012d5a5946d

[5/19] net: lwip: prepare address users for dual-stack builds
      commit: f786c3ff090fdd73739c7dbab1c6e907d9fe66a0

[6/19] net: lwip: configure IPv6 on the shared network interface
      commit: 490bff404029f0f564339a0180c8a8b4d7cfec3f
      Note: Applied with local modifications.

[7/19] net: lwip: add the ping6 command
      commit: f012fcc19d36d0bfed92fb9e956eb1e7c05b1a05

[8/19] net: lwip: support IPv6 TFTP clients
      commit: 1b3ca749faabbc39584ff1e60f230ac82372f69e

[9/19] net: lwip: resolve hostnames on IPv6 networks
      commit: e86ac5b465b41af5c90850a9297fee6fa52e64b6

[10/19] net: lwip: support IPv6 TFTP listeners and server names
      commit: f9f7ede5bf75c1f1637c0fe4f45fec7e9e8fceb1

[11/19] net: lwip: report IPv6 TFTP port-unreachable errors
      commit: 2d75b12aa39f1b58e0c899bc8b22792897e8304c

[12/19] net: lwip: support IPv6 NFS and SNTP servers
      commit: 770ef78185500d4a22eee9f34ecccbe5bb7237a0

[13/19] net: lwip: support IPv6 HTTP and HTTPS transfers
      commit: c681d28e0c2d450b8e0d536fdcfd9a1d84ff314b
      Note: Applied with local modifications.

[14/19] net: lwip: support IPv6 netconsole peers
      commit: d44ad525d6092470af0dfb90f59032639fc0703d

[15/19] net: lwip: acquire and maintain DHCPv6 boot configuration
      commit: c55528ddd21afe66e272028fd62b9e7774dc90aa

[16/19] net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
      commit: 3ad96df729add78bba959d1bbf5d2545e008b982

[17/19] test: net: exercise lwIP IPv6 addressing and DNS
      commit: 6310b6b1078da426f0790c14afd018be9410fa13

[18/19] test: net: exercise lwIP IPv6 application transfers
      commit: 133fc59726ade843ea7540594d5a3efee1f13887

[19/19] test: net: exercise lwIP DHCPv6 lease and boot lifecycles
      commit: 7fc6b6670d16f0893a1e450051fa6781bc5fa19b

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
