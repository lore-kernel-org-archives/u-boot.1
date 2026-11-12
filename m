Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA18606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DyiN0QHX;
	dkim=pass (1024-bit key, unprotected) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.a=rsa-sha256 header.s=selector1 header.b=EnKKvyk7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF20B80BB7;
	Thu, 12 Nov 2026 16:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syKcVfbgpAt6; Thu, 12 Nov 2026 16:04:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17AD88120E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794499461;
	b=W5rLiqzLTxgZl5Pt2uvwm+dZwjlDsfl1Vy0jxxKOhdC/G75/eRtwONFErEcdPAM3LFnz
	 sjb2Iqv8dCIbg5YpXmX9Ei09X0UM5vHMTJR5uz0Cq8fSh1HCYn05zsk6g/1PkO0txi2jk
	 nFaDU2jVYd1El/W7cXuTtifv9R0FIz/UalBf70Nu89sOyHtcmNjP87+pt4h3iDo3ajk/9
	 ZS+NAjK1cUWWc55nV/cCyGG7NcKvsCUg+N7NQONt3poGLDL7D+QPLhZS/gi+eWG6+jKVq
	 gFJWoI/UD2Ru521WfN08CC4hKf48YaEXnCO2Pw9OGf3wA4+nh2ZBVz1Qv9kKhfsZvCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794499461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-OriginalArrivalTime:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-SET-LOWER-SCL-SCANNER:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=tP4vu34GX13H98qngDG8sSO5W4nKtwStMXoupXh7hsE=;
	b=pXPKxqXwB5DtE/dsJFxjeB2zXv7beo3KTy1YjEofgmf0jKatZPvh+x+paX/rPj0xkJjB
	 /uy+bxisHzp4T6iEcPGXcfhAz2Ecju9GPv0v1bTpSypO+wavvv38zJwSuNmrOpiaYtHPJ
	 69jHbs3J39TSYASNvbXyH8MYHLi3cUIjztbaBNxf9v40TTWTRJj0o12+5WHY+wHcdnONY
	 xh9lIGZXBVtGC/RCrO3LnBvkzLFJLH/B4ZHknBhSfOHD5SqILyy+cP1smKBGKZd6XMt0P
	 EvQBsFwWwcJEguqywYy2FR9YQpJttiQ1F9JAJA1Dw2d8vnwTUrX/vdihbtWtjgbEskQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794499461;
	bh=tP4vu34GX13H98qngDG8sSO5W4nKtwStMXoupXh7hsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DyiN0QHXKiXmWhpT3bD+aOcWBHBBZ2bssAUgne9i7g/8b9fNsuN2sZawuWQZfP0Do
	 pQvKxcVepktlxE2MVxSQe02rKKqqDylePN/NHOe5U99JyZgBZxrLSpojxpKyl+RMyW
	 K/tjaHEubvnfEoPblpup7rlYoW1Bkr2thI1ds7NDU7gLDkSZ/pXyuGk1Q5bV0hGXAb
	 0riH5saiSpx++q03EaKcfgfON2jSR7d+I01I9yqYWoGJxXtSGbpqV1+LKB3R6+lL+9
	 KYkewFstQO54nsmQ3YrCF/CMLs89LC26No2aZ6+gAVrNvI+C8f9hXIrSwoT25qsEfb
	 ZTQ21nmdcBrGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17AD88120E;
	Thu, 12 Nov 2026 16:04:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 408D1235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25DBD401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Tq0C0-jHCLQ for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E2D740257
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=johannes.schneider@leica-geosystems.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=leica-geosystems.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=leica-geosystems.com header.i=@leica-geosystems.com
 header.a=rsa-sha256 header.s=selector1 header.b=EnKKvyk7
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E2D740257
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP4vu34GX13H98qngDG8sSO5W4nKtwStMXoupXh7hsE=;
 b=EnKKvyk7yXBRSOdlp3+sjXaaJkxEZMF6m79pSmXNARYhgoCBhdRO42/PbVG+XW1KrulW9vFUG0lUbNJG63/Z/xPFU7J1WDczAuAW+CDg90sQJyoxU3iWejJDBoOgzDiDO/vXh0A8s/fqMfAnIIVkaY5BhyFdVWTiTcP49Lj+DMw=
Received: from GV3P280CA0099.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::34) by
 DB9PR06MB7481.eurprd06.prod.outlook.com (2603:10a6:10:260::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Thu, 12 Nov 2026 16:04:10 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:150:8:cafe::1f) by GV3P280CA0099.outlook.office365.com
 (2603:10a6:150:8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 16:04:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none
 header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:04:08 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com
 with Microsoft SMTPSVC(10.0.17763.1697); 
 Thu, 12 Nov 2026 17:04:08 +0100
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 1/3] Add support for OpenSSL Provider API
Date: Thu, 12 Nov 2026 16:01:20 +0000
Message-ID: <20261112160408.2321891-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d9d0d343-c615-4a78-9f24-197ec3fbbee7@cherry.de>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-2-ekovsky@redhat.com>
 <d9d0d343-c615-4a78-9f24-197ec3fbbee7@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Nov 2026 16:04:08.0367 (UTC)
 FILETIME=[72F08BF0:01DD72BF]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|DB9PR06MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: fca55214-bbd6-479b-41cc-08df40d69594
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|10067099003|4143699003|56012099006|261022115727099003|261022113327099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XeH4U68yucHWgEvv1cJFbLMm6R/50nuLIdxb9NEZ/sY0qj8c3Bm7v9/ZbZ5rRNOpUjszUcKqMtv1YHi+GRAu7iJz/wQFiloYGf4Rl2VbFrQ/LJWCTBhYIARg5XXmxCvGhwy1crHHvDX/WiQbPKyJbwLYHr0P6czxKeLdZUvoP4ngCay3m9pnQZOqwmtUMaVtxvlK3i8Bw+EsX8azfBq8ApQGrvyfjR72tZRBgZWQ7+dQP9G4uMjro6EHpOSwNHuQz1MnKKIRkhb+AmTmYqHptorld+WPVCQXQNYJovBiYc0gEGzxusetVOqNX8Sb5Miq5qF4aW7Blccry8Mibu4tKenZ7VjaVuNshDEM6T27pOAh+v9EylrrKN/bOC8Is566aOU4MjNC+kCNhoQHrhWIdNaRrRLHN7DniJ1V9yCiSrYJHFS07O72uZfaHZakgPKT7UvOTm/Qi5i8gmZnT+38+efvV8E/U8XNfBcDUyJF8zhrFVW9/oejoRU2XGKZyGbb7SyqNgqf5f56kbxXRUAv5Xat+y/FuU/b16xXZ5BXi3aynbCjfcBt3k6/ryIevJ4+ZIU5Qj+V/TyTjXPnpyqvBXHt9ySFFVajbkdqkK4O3AijcamlTlr3Kld6d5Wh21goMjlavUiHupiGJw6FHenL+vgTw7RLGHrn4/kdRpVkRcbCjKb70Pm92ZDd5Hpo+d6oUA/Q/cZrBac2O4umDz5P7A==
X-Forefront-Antispam-Report: CIP:193.8.40.99; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:hexagon.com; PTR:ahersrvdom51.leica-geosystems.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(10067099003)(4143699003)(56012099006)(261022115727099003)(261022113327099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1tqDeA1A/ZRafY8AqGYjp00VOJRu82RsIFqjke9zb4xSlkNdXm6inTfVprHIEPMIEMtRVEIGJ3xLiLjv8ymlBiY2JTWJsA9+tGmCaWOEZXknbiMprbbdKRWo4qSbkOztdHYZPe4mm/oPoSqL4HeYgcW1SL+1DhHc3JTgt22HKYMY0eJxZNiQf9Bt1chOBvyDLRsV35nMxhuyapgH59zNB/OowIEqxAE/tJZYovSN/bs/mQvITkcWcYcMuAn1OXgNkL/Bn5eUGQsgjNQHfgN70fr0IVnCScSsYao9UEBJX3V+Ads4nQ5i1f4ZmZako5NLHt7vsGIxMPSfsfz4gF7KPwFeySqplGAXoTq0MVgbSaIeZdkfR8WMmuoZNSNcpQqfnBfHWg720z+YgNOz0nHp2/lUkZYYXMqcszssR4KJm7tVkS5/KA5CNB7a3a8JTN/S
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:04:08.6020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca55214-bbd6-479b-41cc-08df40d69594
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a; Ip=[193.8.40.99];
 Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hoi Quentin,

On 11/5/26 6:05 PM, Quentin Schulz wrote:
> On 10/29/26 9:13 PM, Eddie Kovsky wrote:
[...]
>>   static int rsa_get_pub_key(const char *keydir, const char *name,
>>   			   ENGINE *engine, EVP_PKEY **evpp)
>>   {
>> +#ifdef USE_PKCS11_ENGINE
>>   	if (engine)
>>   		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
>> +#endif
>
> issue: we should fail hard if the user requests to use engines but
> mkimage/rsa is built without engine support otherwise we may incorrectly
> sign/verify things with keys the user didn't expect.
[...]
> What I ended up doing is:
>
> static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> 				  ENGINE *engine, EVP_PKEY **evpp)
> {
> #ifdef OSSL_ENGINE_SUPPORTED
> [same code as today]
> #else
> 	fprintf(stderr, "rsa-sign compiled without engine support\n");
> 	return -ENOTSUP;
> #endif
> }

Checked on OpenSSL 4.1 with main (3cb2cbbc) plus this gating, no
provider code:

- It builds, and signs with a key file.
- mkimage -N pkcs11 -k ...: "rsa-sign compiled without engine
  support", exit 1. Good.

[...]
>> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>>   		return -ENOENT;
>>   	}

Without -N, the same hole is here. With the build fix only,
mkimage -k "pkcs11:token=...;object=dev;pin-value=..." (key on a
SoftHSM token) gets to fopen("pkcs11:.../dev.key"), which fails, so
this returns -ENOENT. image-host.c ("We allow keys to be missing")
turns that into exit 0; the signature node keeps only algo,
key-name-hint and sign-images.

-k pkcs11: without -N is how 3/3 and your c3855b08 select a token key.
Your branch closes this once providers land (fba37b81 drops the
fopen(), b00da645 fails hard), but a build-fix-only 2027.01 has
neither, so a pkcs11: keydir there gives an unsigned FIT and a green
build.

We already hit this -ENOENT path once, via -N: v4 compiles the engine
out and ignores -N, so our old "-N pkcs11 -k <uri without scheme>"
call opened "<uri>/<hint>.key", exited 0, and only the bootloader
caught the unsigned FIT. Our current "-k pkcs11:..." call is what a
build-fix-only 2027.01 would break the same way.

Could the build fix also return -ENOTSUP for a pkcs11: keydir, like
for -N?

Gruß,
Johannes
