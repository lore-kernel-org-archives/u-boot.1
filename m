Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C33606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jpCXwKvd;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=geQ0muKH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8738E60672;
	Fri, 23 Oct 2026 09:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfN947m2yyXM; Fri, 23 Oct 2026 09:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACDEF6063A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792747583;
	b=SSl2G9Opa80rCvv0c26zXpITpnN3Cn+JdrnBBBiUfqIzUT5mj/htm87z9oWQoPSrrYee
	 IrhsBt8f/+qXwiBwCYKycwPilXXWhigxePK4QsdWa/9GHTE1M4FTZY0reMi6D4c4AIhr0
	 9Ke2iYZWc2RsjCwo9U0/6JFbL7F+erMbowkUS+3rInUCx2r/ovi7GSpVzxd3xQ+YJOsg1
	 UVYZxcaj7AJ6InfkrJWQWN+PZf9qEG4yXGKVowftchkRLembBbey3k1NRWlGvMnFy8icH
	 bPShW+6YbfBOtk3AE/+SbArsVHU3wBm5ziHOs0kujw+EURI+BR6/r4bwD8eTjuFjnsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ja723O0GmENkdCl8HEuP+zXPy/K5yu/FGxXefgLKscc=;
	b=OaWnwi+ciNzCyG5u9+VVyGjpRWinigNqBuO/hb0Q5yPb2/u7fFgCswGf4SeO6+Cxy4sb
	 TUuuFPvaFTclP00pEzc4QzLBou2h3wFCNPkFHBNWTHgye+42mAz6WlRZMxd3cxywls1Ba
	 S4KBXmj7DBpSpEmtpdGFl3n5UrQnLWZ7qmwesdR26cG1UDaqL/Ha4zKmrMpgUJS8mmlOJ
	 fn04vl5wdrDngDnGgdCoPt0LwmfjtbOQ5pNQq2JPHlVWEzVDcGEGU+b9GkQ5C+kmzDySa
	 qg13lE6732XW77scAjnEJ32BPbX/xRactsvF/Q5qZpVLFmFU9Ndb2G6ryE42XQx/AXw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792747583;
	bh=Ja723O0GmENkdCl8HEuP+zXPy/K5yu/FGxXefgLKscc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpCXwKvdT16VdIg+JHTmnfqRdrWuRg7VbXqobuSiAzDe6yyTO3B1ZL+5Nb4XNwgIw
	 38Qi7yrwEf9RLCQkQLvNncXQToonDTPGbnLkxVDjnYNmy6314AQgqF4rxILDWUZWeD
	 HuwSlgaSUgXRCNplmKaNTEBiUEYIMxGwsY+ZwPaV+7pBqNwg8pmdc8kvrfziLW4m9m
	 qim3V1bGXDIxOlNRXMhNvod/MoFtfKhPf5L6sjMNeOUp0OoRYKZtUYRMZVcBYI+qXY
	 9OBH/eY7jvr8tKFDoKIZY7iqODjjxcb8EZePjLidV2rS5kTlP98dtjOOnq5rlwtmE2
	 LunPG/4yKUllg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACDEF6063A;
	Fri, 23 Oct 2026 09:26:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DBD4371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 334A38119B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id se9XwefjhZNN for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B1E181195
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792747581;
 b=CjUCADU7vO8IiqtfHJkqL9dowY2uSnxiYiWyhk30WgqSOxcPYtSdkSZ9Uv2egZ8LMh5+
 2INm0mpnBjzYJCtsZOtEWLr3mO98FYhui+H0Wt9I8fxoqq2wvBoAsw27RlTduTNWwWO9T
 B8naFfjQWmg/rZJPWMEqpr80Tlu4L/38Qir3pWJzEKw/oWWwtGCShZpmMNCKtvApP8n3m
 uKcUNAwEc/AJSCvAUzAmCEg473xyjbK4OaR4YPleqvSxDdEXk9Rhcrureh6qMWJazLJjy
 +5YBCyU3PuINr//+utFAzU9z1knYoMKUaOjkuxFfVfN524Wvlv7PXdao6biqcG2nMXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792747581;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Ja723O0GmENkdCl8HEuP+zXPy/K5yu/FGxXefgLKscc=;
 b=EhPRMI+fTWVbfLfPDoQKHn/HZSKmjlMG5FnYPFP5YI27x+ul9EaSs/oPtwBX17dADEOd
 d8LrzIOMoaJzS5c9L0T0E0ufR/GufeNJj09FrvUWWOv+4mUuxmdsSc9M15P1v17DkFyIY
 caAEs7pfZUGRhag/Ew2EKzZo0xtw93RycCC1xYU3dfN/yXFph0Faw8AdP+AGD+Ib4V/FE
 SUgSxPHbhTDAg1CAMDFs4s/XSIJbwot1oZrrHcGJanGRoqbUktu2PYK7snL0YHM2rS9z1
 gssowffjHvjPfQIC9xgFSqbFDI4AlxwG/llNnidh5Kq04boPwOpWyY5FTKBnKfvcvzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=geQ0muKH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=geQ0muKH
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B1E181195
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFPhBSxn9QHBtp2FP+LeJoWYCBpBwI5TBIoMl0utT/CLrbJ0zD1CEJ8i15NpTgLYTmju0sps/Wj1EaOdQo96KnxyyDWDTjAm7qexKEl6ol6WjoMSGblJtP3mUHOgukzN+yJh11c5nZnX6Lyl4Xu00EVo/vqFw3my813iKDKSRTdRUkuDoXG0qtyWpzUVfu6QexOQdWOXRKqhgzzAARBLunCsQnqAPrfENIYYs7BAz6//TybFzJVqWqflxa9xJNeeWD5Abr2jNFJFF3BAOFu8S0mx3CKdSM7JUqSteWL578NgEseHlbJzfOer/ZuAHXcxSuVLL48OmEETcFbIT+zyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja723O0GmENkdCl8HEuP+zXPy/K5yu/FGxXefgLKscc=;
 b=hUvdJbIhn/3dHV5ts3SHHgdniAAJn6iyioGXoX0qaz0B6gixmbNbHQngsZ74SjhqfViWLXSy5KPsv8VmU1HBeF3+FbVvMGcfOEwo1GpULuzIedgDa4WAQkxcc8MXX0d8YZyfyfPNlgenEAYw2HK7vlPddYKBDecKAUZET8x2n0J4+GP0W3nH2aWzlYBOoDfebdhpUzJwqYOpndfRURtOHYrCGfslE87Ehwh3lrjf5JUjRCJghIVcYMFCiHaVYtCwaOejLajmGnY70/gqlP+uLisbS5L9JR2zg9JrrJOt8neppdM38Je7cD1s81YpbzaO1aEpS7oKYdMfg/ReCfttzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja723O0GmENkdCl8HEuP+zXPy/K5yu/FGxXefgLKscc=;
 b=geQ0muKH1Ng3ZHQ3Hn7dg8xXcQLEw8qWpdKyskfRjHU6vLsU9s19YvD0cVDX2qBCk4IKwsiu1h0SVDoOcXcKONLqIk1eKRgHI2ba8YWDmVh+2qRVNnU+Yhs4g6KqgeqKHzZx3WwuP4+2fdz7z7qiThNVN8S5jZtoxk2oDitGJMA=
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 09:26:10 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::d4d7:bf8:c51f:6473]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::d4d7:bf8:c51f:6473%2]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 09:26:09 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "trini@konsulko.com" <trini@konsulko.com>
Subject: RE: [PATCH v2 0/2] rsa: fix rsa_gen_key_prop() buffer-sizing and
 zero-modulus handling
Thread-Topic: [PATCH v2 0/2] rsa: fix rsa_gen_key_prop() buffer-sizing and
 zero-modulus handling
Thread-Index: AQHdVYNPTerrz4Htb0aBt5CjVj/26Lb4Cj2AgBLp/HA=
Date: Fri, 23 Oct 2026 09:26:09 +0000
Message-ID: <CO6PR12MB544450CDB5B71E0D1506331982642@CO6PR12MB5444.namprd12.prod.outlook.com>
References: <20261006110919.396293-1-prasad.kummari@amd.com>
 <CAFLszTj=S5qCd9VkafcO_8q5EBa3yY7+Ma_=mX3eGO-_B0gcEQ@mail.gmail.com>
In-Reply-To: <CAFLszTj=S5qCd9VkafcO_8q5EBa3yY7+Ma_=mX3eGO-_B0gcEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T09:19:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5444:EE_|PH7PR12MB7913:EE_
x-ms-office365-filtering-correlation-id: 3680691a-8464-447a-38f9-08df30e7ac39
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|261022105027099003|261022075727099003|11063799006|4143699003|261009223027099003|261021123027099003|10067099003|56012099006|38070700021;
x-microsoft-antispam-message-info: QBtWLwcyHNnyb5XW4B+v6wCQpBqB1+VYvpSR6XXkJ80OlF2cvEjIYzLyomiyIB9Ku4nLOUTwETY/fqrxXn9pweNH7oIYZTxyiSnyEWXyDRptekjEMgW1VeAKhQDJtIS0RYvAsD1Wq3zNv/yhs/cbFNwf9oXKY7yAA8XXDMUcNh5Of0V/Irde7PP2zbZllhQTjWKJ13VBcGsXHBsi9cu4CfucRTTafmoW3x3SB6vuHz3i2mDfjrRpV7Ogt7ryU0cE5zKOju1Ap+u9pfQXQvB0c/Nt1X1TCLaNAFUPMQ1b2pm3yw/0jOmy4jriW1lEcTgM6IGTwIiR/rfdxnC8SQnY4Q47Yvjl6zuE/c1hdApdoAAXFw1fAHtA0vJqy4xpycZMcFZdc0s0gpUEjFv6sATM0l+mHTOoylETxGmK0T6nn41nK/4JOBfc9kg46ZXB0tE4gLR3D5KcW4F6mlEyg2ulikVL5mg0ouki0cgVjJRE/p5eN+dUzjsxtttUl1h73csbKc7JsrOZcg77QdsmG5J06kDUfXv3Roq8HuLYYjfmx+TC6rEw1sdtyckY7nkIm2K4c22LV5cvyF5jiXpFcIjJxOnRPfGuKpfSwhZtiI1Sd31WosLlcBDXN0oekoXhAXpi6HkQNzCRt6gpH9AVP64UcC2iuugAtF65VUFgKgYejVbhwXemuf8OFd2cWwn7SGaVT6qAmqvrijvxx3LBF8Cu3GhpnJduMotylZqhM4W+A28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5444.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(261009223027099003)(261021123027099003)(10067099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHNaV0J2ZTdzQWM2Z1JXQ2VqUC91eTJxWDkrVWlCQmhZbGZseWtCYnptWWJ0?=
 =?utf-8?B?MlBndHRMbzFJell1U1BVOU5OUlJQcXV3L00rSmhrL3dqTUV4U3cyUjkvb0xS?=
 =?utf-8?B?ZkNSZWJZQkpsdW5GdGFVMnRrSlZsSDZHNkZWY2I0bEFlNVpXNGpDYm5HSW9k?=
 =?utf-8?B?aFRoUUlQWkpyZVEvZ1pJOEcxR0pkVlBxNHRMNmtuUG9PVG43ZUtqK2RIL2hs?=
 =?utf-8?B?VUhXY2k4V2Y3ZGlkVk85a1NNUHVoMjBZSzFMWm1tdzFTQ1luNGdwZGZmeU5V?=
 =?utf-8?B?b21hRFFIcTkrWjlkWFk2aU1FVXcwUGlqZTF5Mm4xWVM5cHpIeEdOdU5vaVFW?=
 =?utf-8?B?TzdoZC9kWEVvaHlSMlc3ODVhdmJkSzhlc3daZEF1TU50SjhPd3IrV1ZqRWY1?=
 =?utf-8?B?YkE0aU50bEowdUszdnJqN0RNRHlLeUxIc2xrVmFqTWdZQUlHWWdEdWlJellS?=
 =?utf-8?B?cHRHbUFKbm5haUk0d05yK0hERW12RUpONjRMejVuRjRlMEMxRTd5NkpERGNh?=
 =?utf-8?B?eEJKZmVmclN3MGpKU1VTREo0Vk1jelJsejVtazNiTGZkVGh6VlVxZCtwM0xJ?=
 =?utf-8?B?aWtvQjVtQTFCQXhJdUdyM2h1SFhhTEtKNmVZdVhncnBYcXhneGs3OTFZSE1S?=
 =?utf-8?B?R1NHYm0wdHgycXNoSW1RdFlHU2Q4OVk0NkxhZjlXOE1jUGp4MENrOCsvL2No?=
 =?utf-8?B?YzRvUzBvcld2cGhodHkrek8yL3VHRzQxMHd1SU44OGFnZjZrVndFQlRlSmFn?=
 =?utf-8?B?QkxyaVQ1bWNQTUR0L3lmZGZLWVl2UW1yMzFCNkt3OUxBLzU0RTdWYVN5elVF?=
 =?utf-8?B?b21PSXRSdzRJUFVmM2FwOW1waGJPMzhvNjNqTnBKNHRySHVENXVOM0psVkhy?=
 =?utf-8?B?aXUvS0dvbTFQOGoxb2U2UlpBcUFBNTVvQTQwekdnV2JhZWMxWGdhT0UvRTZq?=
 =?utf-8?B?YWVXdTNuZHdYQk5Yd011SjZkK0gvZ3JDZEtRRk5UVkdMelNkZ0J1Zkpqd09T?=
 =?utf-8?B?V2VpVHBiVkJxUTllV094ZWZxUmVYLys5WXp4a1FHcTVobE1vZWxMTnBSUCta?=
 =?utf-8?B?bkJZZGFSNDNHQlZVK244WUNaZVplS2NkbGtGYkMvSElrSGJ6VDMyckVPb1lY?=
 =?utf-8?B?YWJjMzdHYkltTXlSNGlkZG1KbU92ZC9iVzQvMUd5Ujh0Q1paL3JMOFVpUkFh?=
 =?utf-8?B?VkQwdDJjVlhWSEJGcHB6Q2t6MDRlOGZTVzg0a1JuazNqRjAzV21ZZDRtbTNX?=
 =?utf-8?B?TUFyQS96WStHUjJ1MUd0OXZ3VlZZakluQ3pMKzBxblBMbHllczdxMG1QaFk1?=
 =?utf-8?B?WDRqcUQvU1Rib2xsT1hQMTBmdEZiMlkvN2tjdmxRakJTOTEraXc1Slhmb2FE?=
 =?utf-8?B?OU52RWhva2tkcW04S2QyamdWbEhtWk1ObWhJTU9GMmtsbVBzUjN5Y2xPWWpI?=
 =?utf-8?B?YTRzejFhQ0xKMmRFcDIxNlArTVhjckFpYzEyNjNtbFdJcWlsN0lSZmFaZXRV?=
 =?utf-8?B?RFhRemx3N1M4SHM2R085UVVvblB3T0t5SFhONlkvS0k1RDlIVFdWSE5QWWNS?=
 =?utf-8?B?UTVnS0ZpOGVZQmsxczc4RjJBa2p2dWZ4bnQwelVwRUo1NkRDYWcxczJ3MXV0?=
 =?utf-8?B?dzRIbE9WbnlmK3dBMlRIbnpmcjVPWDRzQ2xMNVdWbVNSNVgrbEdyWUYrRi8w?=
 =?utf-8?B?SFZ1ZldnQW5aQTViQUhnWThGT3F2VzE4VlA5SDZlWVkwbjJVb3V2NExIdkZC?=
 =?utf-8?B?REMvZEJpR0FhWHg1WGdnb1FQSm8zYWhrdzBZOUtyeU9HU2FkZ2RLMmt6Tndu?=
 =?utf-8?B?akZ6VFBLSG5LVWp3V1NEeHE2bTV5eGdsRFlpQWFpUzYwMlpLMi9lQW5lS2Zt?=
 =?utf-8?B?czlkUURmd0FIVE0yYmRqKy9zYS9BTnI2RTNpT1ExQStmVDJzNnNHN0dPMTdw?=
 =?utf-8?B?cWdzRmowRFZ1YjRTMXlnNk43UUJKZjJNbFQ5LzhrWW5uZ1dSR2l3VkdJNGQr?=
 =?utf-8?B?aVNLdGN3ajVEVnluVXBkYnlkL2hRVUxoTGtuMjdyRVdMWlpnUkttaVU3dElY?=
 =?utf-8?B?bnlXOWloYWp1eUlxeUphYm8zeUxReElMVzJZVzNJdmtEMzZTMGM5MnZPSTFY?=
 =?utf-8?B?cE15blJzeXNEVlJwV2ZYN1BjbFhXRGF4VnZhMmtYc01PL0UyeVhBdW1GazNn?=
 =?utf-8?B?Y3gwTDZ5ZlBwaG5QaXIyVkR1WG00Q0pQTmh4NHVDUW9FZHdoMlpYWGcyZEVW?=
 =?utf-8?B?RWZkODZlcHMxN0M1dkNpTDNtSFZVcE43UUdrcEdTZ3g3VWJMWlptczdwQXk1?=
 =?utf-8?Q?opHzZw02d+9TVFA1LA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3680691a-8464-447a-38f9-08df30e7ac39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 09:26:09.4702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mx56+b1DvP2DTKxKNjL3TIyeOQMkumqjjxeIz8j4EDzmcWK2c5XRIpgG3Tr0aN82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFN1bmRheSwg
T2N0b2JlciAxMSwgMjAyNiAxOjU5IFBNDQo+IFRvOiBLdW1tYXJpLCBQcmFzYWQgPFByYXNhZC5L
dW1tYXJpQGFtZC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMudS1ib290LXByb2plY3Qub3JnOyBn
aXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47DQo+IHRyaW5pQGtvbnN1bGtvLmNvbTsgc2pn
QGNocm9taXVtLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvMl0gcnNhOiBmaXggcnNh
X2dlbl9rZXlfcHJvcCgpIGJ1ZmZlci1zaXppbmcgYW5kIHplcm8tDQo+IG1vZHVsdXMgaGFuZGxp
bmcNCj4NCj4gSGkgUHJhc2FkLA0KPg0KPiBPbiAyMDI2LTEwLTA2VDExOjA5OjE3LCBQcmFzYWQg
S3VtbWFyaSA8cHJhc2FkLmt1bW1hcmlAYW1kLmNvbT4NCj4gd3JvdGU6DQo+DQo+ID4gVVQ6DQo+
DQo+ID4NCj4gPiBTYW5kYm94Og0KPiA+DQo+ID4gPT4gdXQgbGliIGxpYl9yc2Ffa2V5cHJvcF9v
b2INCj4NCj4gSSdtIG5vdCBzZWVpbmcgdGhpcyB0ZXN0IGluIHRoZSB2MiBzZXJpZXM/DQo+DQo+
IE9uIHRoZSBvdXQtb2YtYm91bmRzIHRlc3QsIGEgb25lLXdvcmQgaGVhcCBvdmVycnVuIHVzdWFs
bHkgZ29lcyB1bm5vdGljZWQsDQo+IHNvIHBsZWFzZSBjaGVjayB0aGF0IHRoZSB0ZXN0IHJlYWxs
eSBmYWlscyB3aXRob3V0IHBhdGNoIDEuDQo+IEZvciBleGFtcGxlLCBpdCBjb3VsZCBjaGVjayB0
aGUgaGVhcCB3aXRoIG1hbGxpbmZvKCkgb3IgYSBndWFyZCB3b3JkIGFmdGVyIHRoZQ0KPiBhbGxv
Y2F0aW9uLiBPdGhlcndpc2UgaXQgb25seSBzaG93cyB0aGF0IGEgMjA1Ni1iaXQga2V5IHdpdGgg
YSBsZWFkaW5nIHplcm8NCj4gYnl0ZSBpcyBkZWNvZGVkLg0KDQoNCiAgV2l0aCBmaXg6ICAgIG5f
d29yZHM9NjYsIHJyX3dvcmRzPTEzMCDigJQgZGVjb2RlIHdyaXRlcyBpbmRleCA2NS8xMjksIGZp
dHMgZXhhY3RseQ0KICBXaXRob3V0IHBhdGNoIDEgZml4OiBuX3dvcmRzPTY1LCBycl93b3Jkcz0x
Mjkg4oCUIGRlY29kZSB3cml0ZXMgdGhlICpzYW1lKiBpbmRleCA2NS8xMjkg4oCUIG9uZSB3b3Jk
IHBhc3QgdGhlIGVuZCwgYm90aCBidWZmZXJzDQogIG1hbGxpbmZvKCkgZGVsdGE6IDYyNCBieXRl
cywgaWRlbnRpY2FsIGluIGJvdGggY2FzZXMuDQoNClNhbmRib3ggbG9nczoNCg0KV2l0aCBmaXg6
DQoNCj0+IHV0IGxpYiBsaWJfcnNhX2tleXByb3Bfb29iDQpUZXN0OiBsaWJfcnNhX2tleXByb3Bf
b29iOiByc2EuYw0KcnNhX2dlbl9rZXlfcHJvcDogbl9zej0yNTggbGVhZGluZ196ZXJvcz0xIHN0
cmlwcGVkX2J5dGVzPTI1NyBudW1fYml0cz0yMDU2DQpyc2FfZ2VuX2tleV9wcm9wOiBuX3dvcmRz
PTY2IHJyX3dvcmRzPTEzMCBycnRtcF93b3Jkcz0xMzAgbj0wMDAwMDAwMDFjMTM2NDkwIHJyPTAw
MDAwMDAwMWMxMzY1YTAgcnJ0bXA9MDAwMDAwMDAxYzEzNjdiMCAoRklYRUQgc2l6aW5nKQ0KcnNh
X2dlbl9rZXlfcHJvcDogYnJfaTMyX2RlY29kZShuKSBkb25lLCBuWzBdIChiaXRfbGVuZ3RoKT0y
MDU2IG4waW52X2lucHV0IG5bMV09MHg5NjhiNmE0ZA0KcnNhX2dlbl9rZXlfcHJvcDogcmxlbj00
MTEyIHJyIHplcm8taW5pdCBsb29wIHdyb3RlIGluZGljZXMgMS4uMTI5DQpyc2FfZ2VuX2tleV9w
cm9wOiBicl9pMzJfcmVkdWNlKHJyKSBkb25lLCByclswXSAoYml0X2xlbmd0aCk9MjA1Ng0KbGli
X3JzYV9rZXlwcm9wX29vYjogbWFsbGluZm8gdW9yZGJsa3MgYmVmb3JlPTIyNTM2MTYgYWZ0ZXI9
MjI1NDI0MCBkZWx0YT02MjQNClRlc3RzIHJ1bjogMSwgMCBtcywgYXZlcmFnZTogMCBtcywgZmFp
bHVyZXM6IDANCg0KPT4gdXQgbGliIGxpYl9yc2Ffa2V5cHJvcF96ZXJvX21vZHVsdXMNClRlc3Q6
IGxpYl9yc2Ffa2V5cHJvcF96ZXJvX21vZHVsdXM6IHJzYS5jDQpyc2FfZ2VuX2tleV9wcm9wOiBu
X3N6PTMgbGVhZGluZ196ZXJvcz0zIG51bV9iaXRzPTAsIHJlamVjdGluZyAoLUVJTlZBTCkNClRl
c3RzIHJ1bjogMSwgMCBtcywgYXZlcmFnZTogMCBtcywgZmFpbHVyZXM6IDANCg0KPT4gdXQgbGli
IGxpYl9yc2Ffa2V5cHJvcF96ZXJvX21vZHVsdXMNClRlc3Q6IGxpYl9yc2Ffa2V5cHJvcF96ZXJv
X21vZHVsdXM6IHJzYS5jDQpyc2FfZ2VuX2tleV9wcm9wOiBuX3N6PTMgbGVhZGluZ196ZXJvcz0z
IG51bV9iaXRzPTAsIHJlamVjdGluZyAoLUVJTlZBTCkNClRlc3RzIHJ1bjogMSwgMCBtcywgYXZl
cmFnZTogMCBtcywgZmFpbHVyZXM6IDANCj0+DQoNCg0KV2l0aG91dCBmaXg6DQoNCj0+IHV0IGxp
YiBsaWJfcnNhX2tleXByb3Bfb29iDQpUZXN0OiBsaWJfcnNhX2tleXByb3Bfb29iOiByc2EuYw0K
cnNhX2dlbl9rZXlfcHJvcDogbl9zej0yNTggbGVhZGluZ196ZXJvcz0xIHN0cmlwcGVkX2J5dGVz
PTI1NyBudW1fYml0cz0yMDU2DQpyc2FfZ2VuX2tleV9wcm9wOiBuX3dvcmRzPTY1IHJyX3dvcmRz
PTEyOSBycnRtcF93b3Jkcz0xMzAgbj0wMDAwMDAwMDFjMTM2NDkwIHJyPTAwMDAwMDAwMWMxMzY1
YTAgcnJ0bXA9MDAwMDAwMDAxYzEzNjdiMCAoVU5GSVhFRCBzaXppbmcpDQpyc2FfZ2VuX2tleV9w
cm9wOiBicl9pMzJfZGVjb2RlKG4pIGRvbmUsIG5bMF0gKGJpdF9sZW5ndGgpPTIwNTYgbjBpbnZf
aW5wdXQgblsxXT0weDk2OGI2YTRkDQpyc2FfZ2VuX2tleV9wcm9wOiBybGVuPTQxMTIgcnIgemVy
by1pbml0IGxvb3Agd3JvdGUgaW5kaWNlcyAxLi4xMjkNCnJzYV9nZW5fa2V5X3Byb3A6IGJyX2kz
Ml9yZWR1Y2UocnIpIGRvbmUsIHJyWzBdIChiaXRfbGVuZ3RoKT0yMDU2DQpsaWJfcnNhX2tleXBy
b3Bfb29iOiBtYWxsaW5mbyB1b3JkYmxrcyBiZWZvcmU9MjI1MzYxNiBhZnRlcj0yMjU0MjQwIGRl
bHRhPTYyNA0KVGVzdHMgcnVuOiAxLCAwIG1zLCBhdmVyYWdlOiAwIG1zLCBmYWlsdXJlczogMA0K
DQo9PiB1dCBsaWIgbGliX3JzYV9rZXlwcm9wX3plcm9fbW9kdWx1cw0KVGVzdDogbGliX3JzYV9r
ZXlwcm9wX3plcm9fbW9kdWx1czogcnNhLmMNCnJzYV9nZW5fa2V5X3Byb3A6IG5fc3o9MyBsZWFk
aW5nX3plcm9zPTMgbnVtX2JpdHM9MCwgcmVqZWN0aW5nICgtRUlOVkFMKQ0KVGVzdHMgcnVuOiAx
LCAwIG1zLCBhdmVyYWdlOiAwIG1zLCBmYWlsdXJlczogMA0KPT4NCg0KUmVnYXJkcywNClByYXNh
ZC4NCg==
