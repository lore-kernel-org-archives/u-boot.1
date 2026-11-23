Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987AB606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YUwA4kMT;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=puq8zZpz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64ABF405DE;
	Mon, 23 Nov 2026 02:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TieVxGsUNLFD; Mon, 23 Nov 2026 02:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A99B4405DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795399236;
	b=GVtxVDWD+UHH8wFs5xSSW3nHu2f1rmk3uNV5jSs2TVa8oGtFtvz9nhVuAfh03kY7zPO6
	 4sSWfd7Xp5yiUfOoqfQOeDF0REYr0R3fB/S/Ybk13K9MNYlrhWq2MZzsQCzu9dF/eyDRf
	 zW3qnquudYd4JJBgXhuG/Ym4yPF8gm6iY6pRYmfSzfkzvfQfktRJ/6xGOt+0PiSGnu/ri
	 QByD3D0G0ahbc+BwCckqC6BUnC7HSHGyTecFZTf+SnyqLwnf4cHX1UUjDSpfniuauEq1b
	 XKNe5eGdYmx9tyOOd8FffOAuNcJq6GPsD7BLzzrLopbG1uCBUEjTP3ose7YNYyPQDsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795399236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=ZkVHp2m+/PSaPJXfh3bNVoCN9wgKzAcYXlHsaknpOtQ=;
	b=E7OPiPDTRhDUCUb1tzkTNeZa9+a6xAc0KkdowrLa8w05rXd4iuXpEEVrl0X3vdxupmvQ
	 +oAbyinQNp3C+zCTLYhHWQ39jtB+1WmQmrnh8FWPAy3xZCJnDKhgIdrWU6EoFM/a1o/C6
	 6lE1PA6EMUc/JjrBh0yQBuCdl4/xDb9Ms8VtIkEaH9q0qIUJ9V7JtqMX6jCN6q/M7znGL
	 5w74u9feBXtG0ikg3Xf9tyb9AZMElr3zXBUhHplaH0Yu0k/IiakI+zfa5M8ORA3vGa7Xh
	 iMEn5DOsAC/+D5vUWRBMfTK8DVfgiTgPoB8LBsbhykAnQIzGlNpRb4ns6a53AE1Aj2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795399236;
	bh=ZkVHp2m+/PSaPJXfh3bNVoCN9wgKzAcYXlHsaknpOtQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUwA4kMTzSX1n9Q3cg98XE33xPJNGunqfOv2b1NGuLZuzY7T2QJbj/MJsH4PiXHZ7
	 CtISkRl8cEDxW8VCVYL7qLMEQo099HJlNGw0iqKYBWqhPQKT/xB7Hpu8iUagbYJP8F
	 sVdVYO3rYZY9S6OP6nV7TJGNJDA3k4SsEs2zFi6MEkvm5f+JrhBA2c/9r1JjZWrE1u
	 /YHO6FC7LsTjgGjRNQVJt4TukPXx1AHqBZDrIx8V6qJWT5XY3t9dIBMANi3Dv44hal
	 IzQYjbMkiCZ0TWfSXS8ZRdctyRDur1l5sBezIAqC0ocXtCJ8lxa+yVrIujp4/Y4YxI
	 xNdUjDUy8UjyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A99B4405DF;
	Mon, 23 Nov 2026 02:00:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CA62392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 197F780D2B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyN8wye5E9EC for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 02:00:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 069F380AC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=puq8zZpz
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 069F380AC4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkVHp2m+/PSaPJXfh3bNVoCN9wgKzAcYXlHsaknpOtQ=;
 b=puq8zZpz+Wh5fFQnjcagcU1QQmdondZVoYdmggO41rpxQsB2rXGvaKy+cofHOalM5UcFB/sET4zNKsFx/Ls2KQgD1Y4GQjvOHHW9I24YAEIOeOs26oslLvSlhHI6wD3vb4sYHhDO4flR7a5iB2NK9xFjdFVlG8VfuWhaTPKVsl1wlDrSHHF8jQwjc7pADW61StetYzz+Op0lY2AYjSCOiqTXhBDLvp3+7G2QHBk1b0vk+5+XS0uRF/NAmQrsGu8/q1eD4OxZXjrCZi7SC5hReT8eJSYZwUSHsSrXZfJmsD3vjkZlpD7fM0GEpKyf6MpRxJbfYlkgnlPygDtgT5SBpw==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6644.namprd03.prod.outlook.com (2603:10b6:806:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:00:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:00:28 +0000
From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.u-boot-project.org>
CC: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>
Subject: RE: [resend 1/2] i3c: dw: validate device index and clear slot on
 detach
Thread-Topic: [resend 1/2] i3c: dw: validate device index and clear slot on
 detach
Thread-Index: AQHdbZ2J8fS4VrIRz0+gDijwqpxCJ7col12AgBJncVA=
Date: Mon, 23 Nov 2026 02:00:28 +0000
Message-ID: <PH7PR03MB7063F9CF29F3C42A54895CAAAD452@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
 <20261106031830.13625-2-alif.zakuan.yuslaimi@altera.com>
 <3057eb46-25ff-a3d4-41ed-3a776a9fe117@nabladev.com>
In-Reply-To: <3057eb46-25ff-a3d4-41ed-3a776a9fe117@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-11-23T01:50:29.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SA1PR03MB6644:EE_
x-ms-office365-filtering-correlation-id: 9154245c-9bad-406d-9488-08df49058c25
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|261009220027099003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|55112099003|4143699003|56012099006|10067099003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: rePB4rgH5igmREWXo/uDbzQHOgX2e8ysD1KsdY7qpjispoSAyCLtZX6jiaBdb3fkFRulmBQgNG5vrhd2msdEZVZueUQ/UPjJpnLz+xFGFZjb3199R5Ey1Ny93ZhAh8uHQu95rfcBv1VAPpyimhiInh4bZaZpvR4IhF9lt8Exnq8ZR+7cgSJWBezdu8m0UgfgtIGj9sA+BSml5IG4r34X5WghvSdDe8AzuJdgt/7DPtabNNK2zPB4NQ78CAMzfCmNTEzdufdV2cZK4R2HC1ShoJU3au9dIX1AQewAXZgg+/E7rk6sVHknwNu3gQNjBn3P/bA1GsxXfzyenuxB8twbbUYDy86L3MRcSYQi6qekaMshDC8Y+6fDeOZUHz9l0PiGCcx5k4NabIqXZb4FbIZ+HL8UvzVjfJp+WLdTIhgHMKi/o2gUsmnaNlJJa9sfU5T4bqZqsCDVH+t+M1pa7K/ZyEupXhhsnCid20QXaasgiayIvs3KzAR6p90ZmKHFErEfFoJuor3nQEFKZj1C+Qwa1IepIAP1Y/4m6HpA6YAuxm9oQkNQ6UeV/89i7jjLf6IE6AhEPv5UP3ZishSnUHM5nSgVwCyRHd5oHYqxnzk4MoKdvfZFuyWcCNxgN6w6kUVw9oZRgiAdDNKrSU6U9HOy3sSQC3taucnRIOneRoKWulGnehezrOsFEU/dwv+ojmrwkV2qcEC27KhxcTQIRmkNFq92bQopWiPkAnHnTIcdsGg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(55112099003)(4143699003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW96eFRQbWdQaHNkV2krUTZpY3FrQkUrcWVBODliajExZUs4M2xhL0xUU0hD?=
 =?utf-8?B?ZHozVkZHSUM3ZmUrK0gwQUoweGR6Zy9EeEcveHVYYXpuRXJQUGJUNDNxbm5S?=
 =?utf-8?B?YVIybk5mTUNrV3JuMmpZTHVTeGkyTE92ejIxcjRSbDRoUlNINUdhZUkrQjJY?=
 =?utf-8?B?VEppb2JwZ2pFK3RFTC8wcGJ0Uk5TcTkwakFwcS92VVUrK2QrNmVBQ3FjYW1C?=
 =?utf-8?B?SHFsVzdOaTVzOWptdzRQVGFtdmw4dWRHelZqeHBQVnRLQlZuS0VLeG4rYVVT?=
 =?utf-8?B?aVFkOWU3WU8zbEpsU0duWkM3bnIyVVZ4bjVPQVZHYlU5TFN2elpwTGVHS0k0?=
 =?utf-8?B?c0NHSUJWNDlKNFI1RVFURC93M3hHUzVkakF4L0ZnM1dPa3UvenIxVzFXbXRo?=
 =?utf-8?B?OTUzb3ppalVLUmdaR2xhNGRLUlJJcVNkWmQ0NWN0WG5wQmpOQ0ZPUWNkajhj?=
 =?utf-8?B?R2t5d3dmRTdQM3NvYnhpdHl4MUszTS8vOXFkVEtWSnZuZ1krVGgxV2YxRzZh?=
 =?utf-8?B?MmEwQXoza2tZeElaby9Tam92Skt1UlgyVnBzaW9LeDdNM2kyNmZ6N09hV0hW?=
 =?utf-8?B?c1NaR0s5cm5ncjlqZE5wUEp5b1BQS2NRRkd4eTE5ZE5sU21BcWg0aHB1WnRw?=
 =?utf-8?B?ck8wd2w4SXVRYXpQMnlOcHNhemZERDMvL1hlMFFtZG9ZVUxTd1J4YkMveWNE?=
 =?utf-8?B?bUlvYlY4ZkdYeTEwWXE0b252VkdZbHZaeHRqd1J3WUp6Y1RlN1crcFVYWGtE?=
 =?utf-8?B?NzdDK3ZROGIzNU54ZHdodmYvS1VJTFpIUExUa3p0Wk5Ga1RmdVZyN0VZL1dm?=
 =?utf-8?B?cG0xQXpZUjM0bTc3VVpwT0g2RkY4SUFKWTFlTDNtYVgxZmdEMHowY3UrQ2R2?=
 =?utf-8?B?S3ZwbFQ4cmxjL01pcXRjdEVOSng3a3dhL3I5MHloaVQ2MU9GeVQzM2VOVWxU?=
 =?utf-8?B?VkxLejlSUUJKQTViSkJSaTdXYWZNODczZ2NzR0M5Ly9ETzhHMko2RDhSNFdD?=
 =?utf-8?B?S3cxeHJYNW1vcmZ6KzhKQ0kwWW1SenllaWFaelhiZWZ3RUp2YXE5cVJybWlC?=
 =?utf-8?B?SzA4Z0grK2xWcmc0cFU4WDVXQWpuVHBrRXRpNytvWXNJN1BZaHBpaE5iSXho?=
 =?utf-8?B?T1FyaE5nSTFTZ2RKQUF3MTRZOWV5SlBUUUFOckdGNFlzTy9IbFBVRTI1cS9Y?=
 =?utf-8?B?bGMwdDBSbzhGcFd5UU8rVXUzOW5tR0c3Q0pENEZ0SS9zQ2puT05hLzQwemds?=
 =?utf-8?B?YlhBcm05MjgxSSt5RFZ1T3IrTVphaFBhYXZxTWRVdzR0ZzEwdExRckljNEtm?=
 =?utf-8?B?Qmx5VzZXU0lpVDIybnBVeGhmaWMvUmpBNDBkRkU3enoxYlIrNDZaNTNrOTl0?=
 =?utf-8?B?b2VGd2Rtd1FVbkZSYlRGcllMcG5LL21zcHRJc1NMWGR0dE00M0RoKzRBNGhH?=
 =?utf-8?B?U3dyTkdmd3VqM3VoMnYxZXExSXI5SUx0Y1NyL2NGWEFSMHFhY2IvUlA5Rlhk?=
 =?utf-8?B?a3kzcHh0cjdjdlM3cnB6SlhJN3hiWk5BUkUrMHpLN0lkNmdJWldacG1OcnNw?=
 =?utf-8?B?U1RMZVdmUHJYMVV2cWNFdDQ5cUlqODJkOC85VmtXaXBPelc2ZDhZbStxUTlo?=
 =?utf-8?B?SnFUOEdyRGEyQUxlN1kreUFTeUFuZWdCNmhKQlg5ZGpRYkRSdTdLOWRYL3NB?=
 =?utf-8?B?UUF0SXVVOGVSZWJPZytDbkF4R1BhaUNQbDE3amsyOGVGeDBJc1FGQzBZditW?=
 =?utf-8?B?VU1JSHFMY0dsc1pSa0wrVFdmRUdMTDRkUE9vTFYyWXhPOEFQNHZFaWs1QjJM?=
 =?utf-8?B?SFZrT2Npa0U4REJDYThpRklydFh6ejRrcURQVS9WczJKdHRDWjhTK0poYVNI?=
 =?utf-8?B?YW12VjhuQjA4U1R5cnhiTzNWWTNlMm5RMVRhRVRhMnpnVzlPRkhjSWpoY1I1?=
 =?utf-8?B?YWh5eFVKNncrWElkei9jMnV4RkVKZXNZMWw4K2Q0dTlack5Hcmx5a1BveHV6?=
 =?utf-8?B?WE9QcTd5WFNuamJXN29tUXVPbUpRVGlSUERrdlVwbmtKbGt1dEhQQU85WDdV?=
 =?utf-8?B?aUxSbEtOOTlxK3plRGQyMkZMV0NRVU9HWHB3bzRyNGtQY1NtKytoVkIwMndl?=
 =?utf-8?B?bTA3a08wZHBnci8yVFh0Q3lnTUlxcXBEWnJlcXRWTjNNZEZFcXR1M2l2K2RG?=
 =?utf-8?B?bFZhZU0xZzNIWGhtQm03aVVBblJZWlJBbjFZMUFIc1lHa2JlemJxbFU2WHRk?=
 =?utf-8?B?ZUQxbFRBejVHSko5dDJvTFRQTExLZTZzNmY5UVZCcUxRMzEzbzNLcHV0b0xy?=
 =?utf-8?B?RmREQVJFaklNVGFoaFVocnFhT29ZVU1oYTJwOFRhK1prdVVsd2huTk8ydTRW?=
 =?utf-8?Q?WzwrtIcLeGgzgrZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9154245c-9bad-406d-9488-08df49058c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:00:28.4171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNX7dxxm4lqNDNxsIU2jh7j8BosucCPNLGcxhbykgPolkqXPNsw6xN6i4bDu/oLxNiDGVzfEjd2O/3aEaEUSZkWddG8rtGwitFnrLaqLXLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6644
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSGVpa28sDQoNCg0KQWx0ZXJhIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDQ6NDggUE0NCj4gVG86IEFsaWYgWmFrdWFu
IFl1c2xhaW1pIDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPjsgVS1Cb290IE1haWxp
bmcNCj4gTGlzdCA8dS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz4NCj4gQ2M6IERpbmVz
aCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5p
QGtvbnN1bGtvLmNvbT47IFByYW5hdiBUaWxhayA8cHJhbmF2LnZpbmF5dGlsYWtAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtyZXNlbmQgMS8yXSBpM2M6IGR3OiB2YWxpZGF0ZSBkZXZpY2UgaW5k
ZXggYW5kIGNsZWFyIHNsb3Qgb24NCj4gZGV0YWNoDQo+DQo+IFtDQVVUSU9OOiBUaGlzIGVtYWls
IGlzIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0aGUN
Cj4gc2VuZGVyLCBkbyBub3QgY2xpY2sgb24gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyBhcyBp
dCBtYXkgYmUgYSBmcmF1ZHVsZW50DQo+IGVtYWlsIGF0dGVtcHRpbmcgdG8gc3RlYWwgeW91ciBp
bmZvcm1hdGlvbiBhbmQvb3IgY29tcHJvbWlzZSB5b3VyDQo+IGNvbXB1dGVyLl0NCj4NCj4gSGVs
bG8gQWxpZiwNCj4NCj4gT24gMDYuMTEuMjYgMDQ6MTgsIGFsaWYuemFrdWFuLnl1c2xhaW1pQGFs
dGVyYS5jb20gd3JvdGU6DQo+ID4gRnJvbTogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYuemFr
dWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+DQo+ID4NCj4gPiBkbV9pM2NfcmVhZC93cml0ZSBpbmRl
eGVkIG1hc3Rlci0+aTNjZGV2W10gd2l0aG91dCBjaGVja2luZyB0aGUgZGV2aWNlDQo+ID4gbnVt
YmVyIG9yIGEgTlVMTCBzbG90LCB3aGljaCBjYW4gY3Jhc2ggb24gYSBiYWQgaW5kZXguIFJlamVj
dCBvdXQtb2YtDQo+ID4gcmFuZ2UgYW5kIGVtcHR5IHNsb3RzIHdpdGggLUVJTlZBTC4NCj4gPg0K
PiA+IE9uIGRldGFjaCwgY2xlYXIgdGhlIG1hdGNoaW5nIGkzY2RldltdIGVudHJ5IHNvIGEgbGF0
ZXIgdHJhbnNmZXINCj4gPiBjYW5ub3QgcmV1c2UgYSBzdGFsZSBkZXNjcmlwdG9yIHBvaW50ZXIu
IExlYXZlIG51bV9pM2NkZXZzIHVuY2hhbmdlZA0KPiA+IHNvIHRoZSBleGlzdGluZyBkZW5zZSBs
aXN0aW5nIHBhdGgga2VlcHMgaXRzIHByaW9yIG1lYW5pbmcuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGlmIFpha3VhbiBZdXNsYWltaSA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaTNjL21hc3Rlci9kdy1pM2MtbWFzdGVyLmMgfCAx
NSArKysrKysrKysrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBSZXZpZXdlZC1ieTogSGVpa28gU2Nob2NoZXIgPGhzQG5h
YmxhZGV2LmNvbT4NCj4NCj4gQERpbmVzaDogVGhlIHBhdGNoIGlzIGFwcGxpZWQgdG8gbWUgaW4g
cGF0Y2h3b3JrLCBjYW4gSSBtb3ZlIGl0IHRvIHlvdT8NCj4gKFBsZWFzZSBzZW5kIG1lIHlvdXIg
cGF0Y2h3b3JrIHVzZXJuYW1lLCB0aGFua3MhKQ0KPg0KPiBieWUsDQo+IEhlaWtvDQo+DQo+IC0t
DQo+IE5hYmxhIFNvZnR3YXJlIEVuZ2luZWVyaW5nDQo+IEhSQiA0MDUyMiBBdWdzYnVyZw0KPiBQ
aG9uZTogKzQ5IDgyMSA0NTU5MjU5Ng0KPiBFLU1haWw6IG9mZmljZUBuYWJsYWRldi5jb20NCj4g
R2VzY2jDpGZ0c2bDvGhyZXIgOiBTdGVmYW5vIEJhYmljDQoNCkRpbmVzaCBoYXMgYWxyZWFkeSBs
ZWZ0IEFsdGVyYSBhbmQgaGlzIEFsdGVyYSBlLW1haWwgaXMgbm8gbG9uZ2VyIHZhbGlkLiBBcmUg
eW91IGFibGUgdG8gaGVscCB0byBwdWxsIHRoaXMgaW4/DQoNClRoYW5rcywNCkFsaWYNCg==
