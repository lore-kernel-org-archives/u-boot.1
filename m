Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672C606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h+R7TEYr;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=BFahTMkL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 541D7606D0;
	Mon,  2 Nov 2026 13:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsNVq_Jkqwx4; Mon,  2 Nov 2026 13:42:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71C6460658
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793626947;
	b=rcQIWIv7YLOtNg0NxXdd5b3iiSbp0vH6QbiUuytFEe4OAvrG7QIYUPKjPnyuf3Vp5eER
	 8ejhUAztnmiJFQewBAPlMyqxFtwC+0yTO9kFdDQB2Ji1/exIGOAzkckvHTlK3JFXycZ6m
	 fJrDYu6YJA7Hwekgjl5/CxVqhSS+FrqIo0qVeV0hsrPy7mgpWPvuIjOYVFW7yzB1I+RDK
	 Hfpi3AwBzOovvLdCYAdnvSTcJhuUmo7tkH4obg4h0SPzax30yBXYc1mW2ZmHpG71QeVRl
	 T2/mmxWJJGeSHmuUTs1JlkUtX38TTygVGvBoqA4A5U/6nxTraOZmfzrPS1+vTlX9MUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793626947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=epFQ+9xowRwYyDUlQvgoyMsltJ221/Ym765HbJkk9Vs=;
	b=lqOF5I7JZ8GG93eC+lzPdniAyV7jVJY9tSHVleL2DJcxoG7X4s1p8TGiP5C+dyIRX+jL
	 LnMAXdD6wpgMHZVRGoPx200RWqYgHxYW6oiaxfXUOnUwDGvY0JyXMwldFm9HUGZrSIKP4
	 3OOGeJm1b6dr3iBLRJdwstQlCjhkHnDelvDTXW8Z7hGbFepBSmov5qUt1StoexUQxeK+2
	 88jguehtCRHsvDMbi2NBz946t1xD2f8mT4t3FGTYM/n5cDGp9lHjGCQ9tkj5uHEFKBB9m
	 l9Nw1FGGQDe/aZLSb30hplMskICJP8Lo3cboA3rTfgvwZ7zt6avJN5F5WmEmbaowGwg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793626947;
	bh=epFQ+9xowRwYyDUlQvgoyMsltJ221/Ym765HbJkk9Vs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+R7TEYrOXyKkE2KrjSENs3ytGc+Xdjy5xXLSjlr8RMEfPAcb1K6AY6Mx+F5mriM/
	 rPHT0mg8I/kI/KDap22ZmbVIaTLoK58+cANA6D5k1eMNGnLEM6dHiPaiq9mAW/U1+T
	 eMSNPxaWty7kIUCC7Rbuo+fYnGHFGAFBAr8R/Lj5UVQ5ZzMZwg7/R4/Ne+T+BvHKlw
	 iap9yaIBHPOtJ/OF6fOZzIzEANq2kOntlLP+mb/KeYij2lL7B3iHrzwNOo88Auj3qn
	 ev/n7WnxlijGMxRT7/kZ6v6vx0CMbt4yLIX7U59h7UqNV7rajUoL7cfac92mfJmOZ4
	 VUdyCqmchu3pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71C6460658;
	Mon,  2 Nov 2026 13:42:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B761411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20DC940050
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KsQ1QuWOVtss for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:42:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DF9E4006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793626945;
 b=dhFXsJ+j8ozjcdgz3UcBsBZS8I+LDJH1JDIcq7NuJ/vGTcksOfZbzhQ8l1UJr1H7fZv5
 MRO0t2phHz0H0YOXkZw5/ht0O45B52YgqB5U0zBkUFGHvN960C+VsxO3BosKO5ppBd/2f
 stzDxcYuz2rLVAqlj8TAi29L6f9FGSjY32BnlNtaXmU+HLjUPeJYjgdfumtqIuAuuOjCn
 x9LdI67HoAJnO8eZyov/ZPnLVj2awsM6YGTLd3ZsR6ZaqXCG5Rgxs2SRsi+0x4kunIQ8T
 MG82Cj+SHR0xUSiSBt7p+0Kav/WkSuqXgx4Cj7MpO6yC6CFxh49Ur064M1TdY9L9Aqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793626945;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=epFQ+9xowRwYyDUlQvgoyMsltJ221/Ym765HbJkk9Vs=;
 b=M1QUHo2oPEb/9v8hkfaxlcXF0JDqs5ir6QcMyN4WRJkfyboM6E78M8KzwHJif8oYuZkr
 511PXdSBMJQAEOEICyOz+gmph0PZrnCtbM84JlgjBWEgUtmsnj4lSINhYbrRMosTBn7xA
 PHCxhdee9Tf8Ruc1ZHiusI7NYrPV2rr6z8RnKtN03bM5aiwZIKC31ossnRx9rC64mfstr
 IQ6nSG6aMEFd/sASpHCUJGwuIvbUcYmbHZqMCF0B52UG8XaDuIwRnC9wivoAkH2Nezv5R
 FfjJ3x2RZrkmVUMahDq6GEEFNRX7uk0H0WRl288CxttTriymVCal3RfMt/laXGS3Nxw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=BFahTMkL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=BFahTMkL
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DF9E4006F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfU7qB4ZL170MSKmpdINJqX2QtGM8J4z1QdwCfVogOC8sngLN5OyYeAbmNwCB5WNywOdkBP1SQgbQeZckpTocVcwnJgkhvDFw9h3cCUrbz69zvwXAh+JtIYgt0rD9XOnAwVqG3LjbOqgLrrkItiD8/ATk+JcHJlpQHkjYmdCTuNRiOaH1QH2V9hafpaaquDmbjngtSOls9NfR/lQKxbz2lDIiANYgJNo7+3tpLodUywZojrXo16ElmnvJRMq2DzLWpbGh9G/5jQjbHI4RCFJ9hgxDRgONS9FioHDvLpwF8pzta2cJ7mf9uxcxgWrOjrIUhbrPm+sInJVcYqmrI92XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epFQ+9xowRwYyDUlQvgoyMsltJ221/Ym765HbJkk9Vs=;
 b=QtjRGEXhvl0eLD4yRc9B4Wa3VU//REq9/izWwPEw4nqDsl3rLHdONuVG4s+HPNHpIMUVVur3+N5OnX0FqKcyPVqgj83zqeUzWE+aOf0UuFdCHzdlmfSpFDd4x33UFnevKv+dq4uD4LzPFPHsCdZl9+8Xu0ZgquQZbCdSEUk565J1KcVeW7XC+LER3Xfa9KOoRvA4/Aq8O8rspNYCDb96gO7dpU1BoaRSur+zKyyByJwzs+r8zxegJmeW40+VQuUfEhfZb5iQCMma+D/lLY7DA6fWps40NO/0oMJ/cjLtyxVT5y3FBLBktvo+uRR52yaMBj3d3fSwbY6tiy+5PscVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epFQ+9xowRwYyDUlQvgoyMsltJ221/Ym765HbJkk9Vs=;
 b=BFahTMkLnVq/G9F8UmlOBQZtHSKzqCaPTIVEErE8uRACtrVSR4Tu6sc+gR6P+1xu+ldU2DBSuoG2h2t43PxSI5vR944kZaaIQAQWDE5T4woa9bmoscsgQLxxtA+4uElTs0ohPYX078lxAkmy7AezoDJODU3usUneHMgT0wd9EhpVO8+bIRpkGjPBR9x6OawFADDzTjK/xGjU6y0/EdbydMyGJhHK3NWgcd9Bivj3k5c2lKFBvpiB/zqHLWe0w67xvYeGVCdgVcnHAetZGeGleqP22F67ZwTxDVTsDksZO4jYmoQssM8gqz2pSmqlKBEhMqu+XTKI6Q0Ot8jXdMwRoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB5242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 13:42:17 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 13:42:17 +0000
Message-ID: <43d2323d-5b88-481b-8882-6b9e78ebf632@kontron.de>
Date: Mon, 2 Nov 2026 14:42:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] bootstd: rauc: Fix leak of the active slot name
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-2-b5a878627107@kontron.de>
 <CAFLszTi8kS_-OpK_wOwW4m8AQkjVVMwVULJ+NTa9vUqJRmAhfQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszTi8kS_-OpK_wOwW4m8AQkjVVMwVULJ+NTa9vUqJRmAhfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcca36f-6fd9-4ada-22f2-08df38e71c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: CLh00IFAUbv6qYGr1Q6FYm3jzAcAy2dCYUky/Yo7scwghhWhdWjXZ0rT935utxMT1vVycEzwXj75+g1hXJZqQR30Xx2qCEdkXIV4omnjRHrJu57DWb1P4eY/ZDMMD/+zXpwh0anI0Dm5i/4Gi92MDrliQwkAwGPvdl9vTGWMTMVP7U4KnW6oQCzsLVdZqAUByXZkJProR0zkKlmFevVHYEsyrcG0hR1Bbm1x9pIF8bLBYzVb9g47MCZ2XdqPVwLbY/gJpVDZBkp/p7ueKWDZxLgwcAAQv08x28slLMFIDiN8U+nV9takX7TwEu0vVLd5HKUVAu/Jr710gJ2IdJkM5dl3fJ65UThS474l0ohMVQzQFdQ2PuR6LHECMquOooNk/GH+G1mPB15LYhcco9HHHyndrd9AC6kQ0SlQceeC1y6aqU4rRf3q6gQ/T3Goe3SB8RZA1mLHgaLvSnWUrJSY3EWAYQlOzVeRtXb2qSAWPiJYtbLEP0dkI/nTl4bvygIdSQRKcO+E1pzPpL0N2u3lz3JGHxKPfy/sK2F8WSxC1BCrtunkqobRCXA9X2Yk4PVXHuvydNjSvuX1d1kHDIydlTynTKcp/7TO1QKKD/zydhTx8Md+oJbVH4b0q0yqOZ2p1cqWxf8uzOa0UTdK8thePnPwJngHuhDfA4xYwUEmoq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NsaTV1Y3ZjT1ByREhXQ2RCUFBpTDFTOUFObGJrRGxiWHRRc1FIZkZycndp?=
 =?utf-8?B?aHVVN1ZzSzZ0U1grMGhFOXQxajRlWTl1UUFSWWpCWVUzRGZ1clVKc2U4K0Fh?=
 =?utf-8?B?NHVrV1hkNXBzQUpXMzl1Y0M0VjV1cTVxMlJpUW9xcklackd6bXRET2pGZ2RK?=
 =?utf-8?B?RmZkVDFHZHNCYjArcklwb21IVXdMbWg1WldTczhFLytQVkxNUkxSS3RXSDBV?=
 =?utf-8?B?ZHh1dVh1WEszQmVKSitHMERsUGJZWVhXckVZUTBUenJsWndKVGtITEwxYTZ0?=
 =?utf-8?B?RFVtNE5haURCWFlwUmZQK1BneHIzb0lXTGZuc25FUnhkNHA5aTdtaUNlanlN?=
 =?utf-8?B?UUlleHExU0tkQlM5Y2NFbEtrclpQTHN0VjVySUZhd092VllOWll5amJxaW9z?=
 =?utf-8?B?a1YwRGhGQldGYWFqaVNJRzVSWVNUSGQ2Uk5jb05HRTdZbVA1OHZpWWllUkk4?=
 =?utf-8?B?NjlBOVhZekhpWVI3WElBY1FVZGw4NUxER2dUVmNjZ0tNMWVrWXFENk9CS1NQ?=
 =?utf-8?B?SFZxV1IyQ0hMWjQ0Zy9VNm9NR0tSS1ZRMHlYS0RvODZXVkIvZUZUYjNwejdQ?=
 =?utf-8?B?QlU1b1U2d0hVcUJRak5WOG1IdXVYMmRadEdyUEhQKzQzWUQvQk5kWUpmM0sw?=
 =?utf-8?B?VWZXd29yOWhkMnd3MU1tWVVhendXdDVUN2RncURTY0xTU0Y4UkwvYmJSNnI4?=
 =?utf-8?B?ZVN4eDZwT0ZFMDRaUHp0T3dsSWFLaE53WXZkandhY2syOHJzOStPV09GVTU0?=
 =?utf-8?B?VW10SFNwZzdqcjVtMk9rOUVabXNJTXhidTNRcmVwSCtqSjZYNk5zNHB3Qzk3?=
 =?utf-8?B?OTRqUE9qaUlCdGlNTTVqVjNRcmdOOXJWVVMxaW1LZnZ6SkF0N2c2SGJockhv?=
 =?utf-8?B?aHFja1hnOWp4cUMrR3lDb3FRajF5N0xoVWN1clBDWWJkYkthWVMvMFRHTktF?=
 =?utf-8?B?OFZPWDlRU2dGSm5aK04vSEIyU1VuNXlTK2xOc2QrNXdiUFZFVHZTMVM0b3dW?=
 =?utf-8?B?cG9INExOUS9PRmw0TFdkeDNvL1NCWGsvZkpiem5nOHRvSG1jaENPbEx0eGlV?=
 =?utf-8?B?WmJKZnpDR3lHNHZCalJRS2d3Z2tkVUtkajdEUGlhdktxVVVGUHY4eXBzV3Nw?=
 =?utf-8?B?eXVyNmtFcDlnL0RWTWUwQmxETjBwQ3VDakhYNktaQ3hiTEluRGpldkh0ZWJj?=
 =?utf-8?B?em5QVjNvbE13SUl4OGtlTnM1VEt5c1VzNCtaOG5EanJ1eHdmbjRCNXFSN2F2?=
 =?utf-8?B?K3NQS1pDWXRSMHlDWmpXMXFjdkJucWVHUmhPeTNxRGROQkRUbmFVc1BTaEhD?=
 =?utf-8?B?K3YwT2g3aTdzVlRDdlh4VUR3MFl1RWMrcVE4c0luZXFMSko1Nk52N2JZNTZP?=
 =?utf-8?B?WFdYUHJrbkpZQnJPZ05VYkZkQ0NFUi8rb21qOGJOVUI1WFpJZlVqbWpGRUZ5?=
 =?utf-8?B?K1YybUpMcFltUUFxdjVaNkNSbkhNUml5ZHlOYndvdVVXb3NxS0pSNmc0SmNI?=
 =?utf-8?B?Z1hWM0ZlUlk5RXVoK3FNc0RVSXEzSUFsQUh5OUZlc3dSUnRxeVdPVlB3dDZF?=
 =?utf-8?B?VS9RZVFUd2kwWHlacy9rTFkrVzdLVGFnay9kRXF0dmF3WmRkalptaGhJbGZB?=
 =?utf-8?B?QnJxQzZaWnB2UFlVRytiY2xOSVcvN2p3U1NEQ1lrVWJiTzBLTGZOa1U2UThU?=
 =?utf-8?B?Wmp6N2ZvYlhETGswUlZMNEtjdTBxQWVjdkdKdERNNzkxNnhXWUFKazBuRGdS?=
 =?utf-8?B?V1pZUDI0UUw2cnEwN0wwaFdnZlFWTEd3M2RVbm9CSXd0TmcvNGJ3WURsaGtS?=
 =?utf-8?B?ZWNsRUhNY1B1MGNoVk1sczQxMHkyK1c1SDlQWXo3UzY5K01POHVNeWJtdUVi?=
 =?utf-8?B?YVBWQnZlNzh6N2djckdGK0d0S2JqN0FEMzgzNW8rWXo4cldlQldSNUpSdXVE?=
 =?utf-8?B?WmdlR212Y3lKU09oTHNrbHRodWVIQnlmd3phVU03SFJQQlJWL05UYmwzM1ky?=
 =?utf-8?B?MXJWQys0YkRTNzJVYmt3ZnRUNmQ4ekhyeTV3ZklhUE5OVjAvbXd2VmxJdmdO?=
 =?utf-8?B?VkFjd05XUUNLQzI1YlJCbzVCcTBzM2RwTDZGNWxjMTlpeU01bk8zLzR0Vnc1?=
 =?utf-8?B?Uzk5SjBCOUl6Y05SYnpsaGZ6WVlxMmxWSXJsTFNNTTcrelBkTW8vY0J6enhT?=
 =?utf-8?B?M29jZmp2Z1BhZ0FjZXRRcjFaak1iWm9vVG9pTDR1TGJtNGNpRG5sZE5CRGg5?=
 =?utf-8?B?ZHNISFZ4MVMyQXdEeklvMUJYM2R2cVBobjJHMkZtNGc1b3pGWmpQZG15Rjk0?=
 =?utf-8?B?OVo4L1JLNUhtYWJUclNqZkF1elZzVWpoWGp2RlBZQjRLbldoM2RTTmVGdGpv?=
 =?utf-8?Q?34KIsEo/Wa0/2cO0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcca36f-6fd9-4ada-22f2-08df38e71c3d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:42:17.3468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83MOGA1Q/zrc+KgiNPeAFoAaNEkm/0pPuzY8I0JQv8kT9+Ac9DRNDE3ESgFMqtkOKowM7PF9txIYFjehmZXpYZzfaZH6nO2KVXJpyZj2s8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5242
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 31.10.26 15:05, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> bootstd: rauc: Fix leak of the active slot name
>>
>> find_active_slot() returns a strdup() copy of the slot name, which
>> distro_rauc_boot() never frees, so every boot attempt leaks it. The
>> strdup() result is not checked either and if it fails, get_slot() passes
>> NULL to strcmp().
>>
>> Check the strdup() result and free the copy right after looking up
>> the slot. Use the name of the slot from then on.
>>
>> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>  boot/bootmeth_rauc.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
>> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
>> @@ -347,6 +347,10 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
>>  				return log_msg_ret("env", ret);
>>  			}
>>  			*slot_name = strdup(boot_order_list[i]);
>> +			if (!*slot_name) {
>> +				str_free_list(boot_order_list);
>> +				return log_msg_ret("buf", -ENOMEM);
>> +			}
> 
> The caller only uses the copy to call get_slot(), then frees it. You
> could pass priv to find_active_slot() and do the get_slot() lookup
> there, while boot_order_list is still valid, then return a const
> struct distro_rauc_slot * instead of the name. That removes the
> strdup(), the new -ENOMEM path and the free() in the caller. It also
> means a BOOT_ORDER entry with no matching slot is caught before its
> BOOT_x_LEFT counter is decremented. What do you think?
Yes, this makes sense. I will change it in v2.

Thanks
Frieder
