Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFB5EDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 02:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18ED88EBC;
	Tue, 10 Sep 2024 04:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="p79/VVsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8321388EDD; Tue, 10 Sep 2024 04:33:04 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E295288E83
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM1XyiAhNMKnw/kep6xqi3xojYVUOdEm1MzkmqHFQfMewW8b7vJBPlZDqk5Ul8Y4k8gkd3U39xZsJcAj6JkhtSIKQ0qSqA2sJ3GXoHFIO2u3z9CYj5y5yQGk1zLgvBRkltXo7KPwKbSSWlajF6x+qQhXWtdZFzAd36qFhlUGC7BoFLRD3f5dxhUKpcZt+3ayo24Ukx/kXVlXV1oV6aDdZ/Xr1MJyQVvzd9/PVOqt1QfhdEpO9QDNeFeaATEyVc+KJnz9XBrJGiY8SYOTkAg4R6XwOL1olnV10tX0Bsp2iQYVoqMRprM/RvYyP1wH6IFUJHT0Crhbk6klXIM0sSL86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82m8f/Qwj+uspCS5B+j5CzKcveLLBRjCH2yzyFn33v0=;
 b=tvo0y9GmVYwwKVsXDOrqhRIQSznN/X3A4ijJP+ex8zsc1OATMSYPIPRx0Bcgx58XVU2nrGH3MSZLPGeNFKdYrEakiidkhULAhiYHdaPLPZmIKo3AwV2kwdQwfagMI3eGW/j119r4UHo8Ju47Z2rIrYlTvXcLXK6tdEWYuDmB2nNVjhCM6R6aF3oN4llwX4EV4mbIxO78AgfPWIRTWAZvwLoLlZ6z/0Ip9NZ9P+z+9GlHny3tKi6CbOvvU5UV+Lmr2rWac7XDJl6gpG0mxY6e20MI2yO4zNm8CmI0Ckb4Qxmq1mSZgvLslRIBCjWuYKckIJbW5SkXGVM/E8uAmACblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82m8f/Qwj+uspCS5B+j5CzKcveLLBRjCH2yzyFn33v0=;
 b=p79/VVsO7eqT6VZ8xmfQPSu6BLQn0ut6YLhWtM8QGF2rYMtQUAeDbf6ypbKKBl8+JEnPNpwQeAXJvhYJggDTFmmFeeaNMTAjyoDeezMPOgsUsAJTqz3s6uBo/mfRY8jCMVPCetvAOJ2z3z644PuDBxF7qsHUWnqQi9OHqkIw4qH4hqqd44tugfQQXfc9q47L8dNDMPiOwW2gkh+iB9hbPLwgmTU4vFS9WNNzdJHV+jL0oT9HfZ4BB/i+B7mHm+Lc69NgQmMTA2uuW406c9k1X3YW20TXA25wr8K2DQjWpCykP/pFbk81bEKXM+FvI+34VhiOazvyQpMIO1UsGceaHg==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by TYZPR06MB6548.apcprd06.prod.outlook.com (2603:1096:400:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 10 Sep
 2024 02:32:52 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27%5]) with mapi id 15.20.7875.019; Tue, 10 Sep 2024
 02:32:52 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Leo Liang <ycliang@andestech.com>
CC: "rick@andestech.com" <rick@andestech.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 4/8] riscv: Add AST2700 SoC initial platform support
Thread-Topic: [PATCH 4/8] riscv: Add AST2700 SoC initial platform support
Thread-Index: AQHbArI/pgTvz/06Kk6mbxHEdPnbrrJQTKrQ
Date: Tue, 10 Sep 2024 02:32:52 +0000
Message-ID: <KL1PR06MB66520862710117857CEAAC97919A2@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240819101704.1612317-1-chiawei_wang@aspeedtech.com>
 <20240819101704.1612317-5-chiawei_wang@aspeedtech.com>
 <Zt7nSz9oUJiPiFrx@swlinux02>
In-Reply-To: <Zt7nSz9oUJiPiFrx@swlinux02>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|TYZPR06MB6548:EE_
x-ms-office365-filtering-correlation-id: e8b774da-5f2d-4376-a10c-08dcd140ded9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NllrVDFIRFpCU2s2TTJRNFd5bFdwemVmL2lYRThLMVhhZjB4WkJrU240TFBN?=
 =?utf-8?B?dVdNd3RpbXRyUDFva05kdnQrdEdqUXZ0Wm8xT3g0c0ZwNHIzYXhyWUx6ZVV3?=
 =?utf-8?B?bG5YZXVQK1NZZ3V5UXRjWU5ONDVIWFlqQ3IrRzRHenFmM3VHYXBqd1V6clFU?=
 =?utf-8?B?WXBCNzBLUytVYnVydnhHTDlFUmNpN1BEaGRwTC8vdmEyWjZJSk9GNW5NN29D?=
 =?utf-8?B?NmVCRXU5STRWbHlqWXNtTENNNnEwaTl1Zi84blpxUVpmK2ZTaURHRU1mazM0?=
 =?utf-8?B?OXZrNEhkaEF1dnFZMi9rakd3MHV3K0FVRmJWcTgwRWF1RmFwRi9xaTd0bm8w?=
 =?utf-8?B?dXg4eDRkMmdwRHJSY0JtOXdoV1d3S2kxYk45VVNXdUtaSkdZZ1ByVzA0Qmpi?=
 =?utf-8?B?MUJ2OW1aRmhqZDlqQUh3VEdBM3R1c1YxSFNSZmdDS1pUVlUvaWFYLzV2bEI4?=
 =?utf-8?B?ZjRqeXFlWHN4bjZmdy9vV1NNYS9WOVFjNDVtSy9uK3hiczVyNTRZS0EvTENQ?=
 =?utf-8?B?VUEvcDN3Rll3N0t0RkdZUUllNjNyN05TRmQ4cDV4RWRmSUFoRHdWaUd2aCtO?=
 =?utf-8?B?TTFONnhqekRKNEh6ZEhkMFE3NnpFdmtUblIyNEsvTWJvRXJtOFgrQWU1RkdV?=
 =?utf-8?B?eWhPWFlqeFF3R0Q4U2xpM3ZON3hiYWZ0RkptL0MyZGFPakhMWmNFYmU3ejdy?=
 =?utf-8?B?TW5YZFlsYzI1dm9WU2FxWDk0TW9QZXZ2SmRPcE9Za0NoeHozTUpYWWt3Ull2?=
 =?utf-8?B?dFdUdHFyd081cGNYcnErK29ZRXBRcmdxQ1VZWlF1ZlVxQmthQ0E3MU1wMmpC?=
 =?utf-8?B?NlVzYkQ1THdwZXloczRTOWxVclJUaDFhanRldGlZSi9QWmZrRkxWSzR1OEJ2?=
 =?utf-8?B?TFB0clgrL3pBendaem9lL3JEQTl2UjNkWmZnem1QYkFCdno4c05pN3NHT3hT?=
 =?utf-8?B?a0wzVER1ZXhJZ1FjK0lGUU1qUVZvZEl2bTZOK3lwMEhNTmo3cmNJbkFGUThG?=
 =?utf-8?B?b0RvQ3NJbm5CVEdSQkJUa2ZQUVlxNXFUUVlpM3dQOGJyZTFGRytjRnhodVBz?=
 =?utf-8?B?VEN2b1VMTEJjVGx4RG5aY0lMZjFrYmRKWnExb20wOCtDWkxkYzl5VUZId0dJ?=
 =?utf-8?B?YkNYajcwOVBIWk1SeEQ0bktaYU4zRkI3M0tEZDlvalhpeXliZHh2VURmVjI4?=
 =?utf-8?B?cHkrNkppTFpLeGcvU1ZoN3NDd3IyUEYxak1KRWMrYXYwWXhJQlh1ZUJ2bVYx?=
 =?utf-8?B?N0U0OEZkN3dUbUJ5aXBOTE94L0pQR21rWjJNdjFTRDBZUG5OVVRsSjVrRld0?=
 =?utf-8?B?ZlBpcno5VGIrVWZTZ2tCaVBScmxOL0h1UUdkcGNGVEhCZ0VyM2JLVnhzS21N?=
 =?utf-8?B?d3J6aEJqNDNnY0s3djdqaERSQVRONGtseDJiQnUxcmJ2Vk5WQWZPVVhqQkxh?=
 =?utf-8?B?NXVNUzY0QVpNNG5iNm8vdHhSbElTUGVkYkNKN3hCSThhSGZOODlHaEszNjdY?=
 =?utf-8?B?QTA4ZTlKWW5mK3BIZzJaR1FrR0RhaENJM3FLdm92dXV5VnRvT2pDODNHV2x0?=
 =?utf-8?B?VEdIdDJwVXVzSXhhZXkwV0lNMFBPUTdOaFFPUDE4eWdjdWZDSXl1S1dTODh5?=
 =?utf-8?B?WTRHcEEyYmU2NXBoN2w2eVh4TUdHM25HNGxzdlp1WmFNcmhKcHY3T3NCbWhF?=
 =?utf-8?B?NisvMEhxSWVMTVBEYU01SjNVdGFFSlE5TjJmRmNFK0xZdUNqaEl2a3dnemN2?=
 =?utf-8?B?akhWaGFMMnljNDBlNG4xblk1WWhSb3p1SXM3M0N4TFFPWmdDSmNHNEY5Ukdu?=
 =?utf-8?B?MGpick0xWWVLbm5ONFI1WkdZWkpXWU9MSElzeWV3UWpJb3BwdDdKYTgxS3lS?=
 =?utf-8?B?bVlpMXhvZUp4dVhtSEtiMlRDR1NmSU9yY01kcTFYQXhFRGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkkxMGRqS2hhait2aG52RHphSUZOZ3NidlhPTVNKYmZlaDZqVHdhUjdLbncx?=
 =?utf-8?B?TzU3MnBEMHZacTJxRDFMSDVpa2pzZzkwQVJYSVJONHgvbE5XNnl0Rjc1dVdF?=
 =?utf-8?B?WElNaXY3Uk5tYVBkbW1DNGN3c0tnRjdzd09tYmtIcXp3LzM0VGorKzl6RmFy?=
 =?utf-8?B?NGg0UU1IMXhQajVLVjZaR0RHbk9XOWZKVTN2WER4S3h5Y1VyWlRrUVllZDha?=
 =?utf-8?B?ckJpbldVYXBENmJ4c3Z0RE0vM3dGQzhkbWxDeUJFYm5TaURLMWpkZnlyM0hE?=
 =?utf-8?B?YlRqZk5oTi9udzIwUVJSOENGWlZDNDYyM0drVHhGd0ovb0RjSDRFTGlybk9m?=
 =?utf-8?B?cGp2SkU3d0x0Q0RmeFNvR0RqSWpNOXR0QlRXYW5mSUNqV3BvM1lyeTJEdVpF?=
 =?utf-8?B?TFJmeGhpL3pIelNYcTV0QWtldHhiZEdlNW5PcU9kU21mZmw5WW84WitwTDdp?=
 =?utf-8?B?aHQ3ZnFsYkdiNHFncWJHVmN0Z3hGcXYzbjRIYlNvL1d0eG4wNzVoODR1WFZZ?=
 =?utf-8?B?VmNLVk1VSjVkc0F5eFFyanh6NG9jZXduV2dYMkViMGVDL1FqQjE0WEVsamha?=
 =?utf-8?B?a29BdVFMNDNRcXpRUzdwalhQdmdKL1FIZjZxTlNyc3hpKy8zcStMcmN3SFpy?=
 =?utf-8?B?Vzd0SElvTklzUXNOSkY0UjJmWkIyODlvNHZiMzJsa3l5OC9zaEZvNDRyUU1E?=
 =?utf-8?B?TDBEc2JUNytMUC9UMVcrcGw4Wjg5VkdoNzg4WUJBWExzL0pneC9VU1ZPMm9i?=
 =?utf-8?B?N3RMWUtEcE51M1hCWXplYnU0OW9scXAzN2IzMEdrWmdCWFdBOGkxNGYweEpG?=
 =?utf-8?B?bTRTSlRWS0JRb3l4OEM2Y0txa1BVem80QTBNYTNKYnZzM0RBQnZta2cyWmgz?=
 =?utf-8?B?Znl6TkV1bWc1a1h1dytYNHUvT0dXZzEzcWN2NE1MaTdIajExbTNlL1QvQ0RW?=
 =?utf-8?B?VHFCWXRZR214MzhRL3NSdHVjTkFsVmp6WGNFMlNXOStWMEtNeUhkQkhZU2ti?=
 =?utf-8?B?aUJXL1hkYUZ3aC92Z05xNXlWSk5SNUg0YkFZbUVyQXo3VTZpT1BxMTZRcWxO?=
 =?utf-8?B?aE1pUTFSWDRmRDJ6aEJEalVaNk9xOEdheWR5L0JDb1M3SUVIR0U1U0oyVzBy?=
 =?utf-8?B?UVF4QWVhQWpEeU95RzB0YUxHN2JlT00xMENVZk9qcmFsZDcyb1ZCZ0IvVXQ3?=
 =?utf-8?B?c3lNR2JkSkFsR293VmZyR1ZGMWFadjA0ZDNSbGhnUlJOWExEdFFFdTk5NUUy?=
 =?utf-8?B?cDhTeFFDNCs4NHN3cDIwL05UekpXNjMvUytKSlpsWVdaNnhoZVkxV0lZTFlX?=
 =?utf-8?B?QzBOT0w0K0l1UkFSUjhUS1VMVXZIcVpic21YM1VjRU42M0JJTWNrM2EvM1Zy?=
 =?utf-8?B?V3h5KzJONFdDOWc0dC9VOUh6RDF6cVFkZnZNZ2poUHNXMmF5MStwUUk2T29q?=
 =?utf-8?B?aFZpbnZ6SG9BeW90NEErWlU2L3dsYnlhNkZBZkhldGwzNFlzR0d0WnhyNmY1?=
 =?utf-8?B?VGxUWXdMTGtYZmlsdC8rVmlNaXUzSDN5Y3hBRWNOUVBFR29XY1NYYm1nZ0lQ?=
 =?utf-8?B?SlZ2TXZnWVRYbHJrNXRMUXdSQjR4cEM1MWZtdjBlYUNpeUdvUnhPSmxkOWxW?=
 =?utf-8?B?Qk11eW5sRnh6Q04vZFc1VEFQQ0tpbmQ2WnF4N1VVZUFJRmFRNk9hZXNyYWp0?=
 =?utf-8?B?Nkx4N25idzhJd1JjV29ycXYrRHV4Q1hGZUVYcHVxZlVSZnZQT0VMV0tRMDNr?=
 =?utf-8?B?R05EMGVpYlY5QXRrTFdjNWpiY0RSTWIyTVcrRFIrRS8wNzM1OTB0U3ZieFp1?=
 =?utf-8?B?alhpa3VmQUJpazZML0Y4ajlEZ00wS3EyQVd3TDBwVmJDZlBNUDQ1OUtRczBu?=
 =?utf-8?B?clIvcFNGZ0VSUktwVW5SV0JoOUl0MU9mQ2dDSXBicnRZUU1rR2lWSlY5Z3ps?=
 =?utf-8?B?TnJsTUFjdFA2YmZUa1BJVkpaUFowVUZYenRPN1p3V2NoQVgzd0kxdkk3c0hZ?=
 =?utf-8?B?NWxVdnE3d1BpYmNrMlRsaU9pZkR2Q3VYSkZsUFdrSmR1UWFJNkxHNzI5Smxu?=
 =?utf-8?B?VkUxSHdLRXJvU1lidHoxaUU3NGFVT3JKRTc3OHAzVDA3bnR0VExNZjBGNDdQ?=
 =?utf-8?B?VUtpTE5lVU15ZElUQTY5SUM5a2JrbHZNUUZGNHlmL2xZTno2aXJtZWZCeWZj?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b774da-5f2d-4376-a10c-08dcd140ded9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 02:32:52.6105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/nYF3Sj3BdpLTlmKo2CtQPD6eThKPvfqbdYgHANNWERU0WwckQ1gsIe0okddsv2d9rp7VR7cImbl1ueHUyYfIuczUKmSYVXf6LIn1tIvV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6548
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

DQo+IEZyb206IExlbyBMaWFuZyA8eWNsaWFuZ0BhbmRlc3RlY2guY29tPg0KPiBTZW50OiBNb25k
YXksIFNlcHRlbWJlciA5LCAyMDI0IDg6MTcgUE0NCj4gVG86IENoaWFXZWkgV2FuZyA8Y2hpYXdl
aV93YW5nQGFzcGVlZHRlY2guY29tPg0KPiANCj4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQgMDY6
MTc6MDBQTSArMDgwMCwgQ2hpYS1XZWkgV2FuZyB3cm90ZToNCj4gPiBBU1QyNzAwIFNvQ3MgaW50
ZWdyYXRlcyBhIEliZXggMzItYml0cyBSSVNDLVYgY29yZSBhcyB0aGUgYm9vdCBNQ1UgZm9yDQo+
ID4gdGhlIGZpcnN0IHN0YWdlIGJvb3Rsb2FkZXIgZXhlY3V0aW9uLCBuYW1lbHkgU1BMLg0KPiA+
DQo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSBwcmVsaW1pbmFyeSBiYXNlIHRvIHN1Y2Nl
c3NmdWxseSBydW4gU1BMIG9uDQo+ID4gdGhpcyBSVjMyLWJhc2VkIE1DVSB0byB0aGUgY29uc29s
ZSBiYW5uZXIgbWVzc2FnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtV2VpIFdhbmcg
PGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9yaXNjdi9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiA+ICBhcmNoL3Jpc2N2L2Nw
dS9hc3QyNzAwL0tjb25maWcgICAgICAgICAgICB8ICAgNiArDQo+ID4gIGFyY2gvcmlzY3YvY3B1
L2FzdDI3MDAvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9yaXNjdi9jcHUv
YXN0MjcwMC9jcHUuYyAgICAgICAgICAgICAgfCAgMjMgKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2R0
cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGFyY2gvcmlzY3YvZHRz
L2FzdDI3MDAtaWJleC5kdHMgICAgICAgICAgIHwgIDIyICsrKysNCj4gPiAgYXJjaC9yaXNjdi9k
dHMvYXN0MjcwMC11LWJvb3QuZHRzaSAgICAgICAgfCAgNDAgKysrKysrDQo+ID4gIGFyY2gvcmlz
Y3YvZHRzL2FzdDI3MDAuZHRzaSAgICAgICAgICAgICAgIHwgIDc2ICsrKysrKysrKysrKw0KPiA+
ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2FyY2gtYXN0MjcwMC9zY3UuaCB8IDE0NQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1hc3QyNzAw
L3NsaS5oIHwNCj4gODIgKysrKysrKysrKysrDQo+ID4gIGJvYXJkL2FzcGVlZC9pYmV4X2FzdDI3
MDAvS2NvbmZpZyAgICAgICAgIHwgIDIxICsrKysNCj4gPiAgYm9hcmQvYXNwZWVkL2liZXhfYXN0
MjcwMC9NQUlOVEFJTkVSUyAgICAgfCAgIDcgKysNCj4gPiAgYm9hcmQvYXNwZWVkL2liZXhfYXN0
MjcwMC9NYWtlZmlsZSAgICAgICAgfCAgIDIgKw0KPiA+ICBib2FyZC9hc3BlZWQvaWJleF9hc3Qy
NzAwL2liZXhfYXN0MjcwMC5jICB8ICA4NSArKysrKysrKysrKysrDQo+ID4gIGJvYXJkL2FzcGVl
ZC9pYmV4X2FzdDI3MDAvc2xpLmMgICAgICAgICAgIHwgIDcyICsrKysrKysrKysrDQo+ID4gIGNv
bmZpZ3MvaWJleC1hc3QyNzAwX2RlZmNvbmZpZyAgICAgICAgICAgIHwgIDkyICsrKysrKysrKysr
KysrDQo+ID4gIGluY2x1ZGUvY29uZmlncy9pYmV4X2FzdDI3MDAuaCAgICAgICAgICAgIHwgIDEy
ICsrDQo+ID4gIDE3IGZpbGVzIGNoYW5nZWQsIDY5MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9hc3QyNzAwL0tjb25maWcgIGNyZWF0ZSBtb2Rl
DQo+IDEwMDY0NA0KPiA+IGFyY2gvcmlzY3YvY3B1L2FzdDI3MDAvTWFrZWZpbGUgIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+IGFyY2gvcmlzY3YvY3B1L2FzdDI3MDAvY3B1LmMgIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IGFyY2gvcmlzY3YvZHRzL2FzdDI3MDAtaWJleC5kdHMgIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IGFyY2gvcmlzY3YvZHRzL2FzdDI3MDAtdS1ib290LmR0c2kNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvZHRzL2FzdDI3MDAuZHRzaSAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+ID4gYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLWFzdDI3MDAvc2N1LmgNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1hc3QyNzAw
L3NsaS5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9hc3BlZWQvaWJleF9hc3QyNzAw
L0tjb25maWcgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGJvYXJkL2FzcGVlZC9pYmV4X2FzdDI3
MDAvTUFJTlRBSU5FUlMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL2FzcGVlZC9pYmV4
X2FzdDI3MDAvTWFrZWZpbGUNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL2FzcGVlZC9p
YmV4X2FzdDI3MDAvaWJleF9hc3QyNzAwLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJk
L2FzcGVlZC9pYmV4X2FzdDI3MDAvc2xpLmMgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGNvbmZp
Z3MvaWJleC1hc3QyNzAwX2RlZmNvbmZpZyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gaW5jbHVk
ZS9jb25maWdzL2liZXhfYXN0MjcwMC5oDQo+IA0KPiBIaSBDaGlhLVdlaSwNCj4gDQo+IENvdWxk
IHlvdSBhbHNvIHByb3ZpZGUgcHJvcGVyIGRvY3VtZW50IHVuZGVyICR7dS1ib290fS9kb2MvYm9h
cmQgcmVnYXJkaW5nDQo+IGhvdyB0byBidWlsZCBhbmQgcnVuIFUtYm9vdC1TUEwgb24gQVNUMjcw
MD8NCj4gDQo+IE90aGVyIHRoYW4gdGhhdCwgTEdUTS4NCj4gDQo+IFJldmlld2VkLWJ5OiBMZW8g
WXUtQ2hpIExpYW5nIDx5Y2xpYW5nQGFuZGVzdGVjaC5jb20+DQo+IA0KDQpIaSBMZW8sDQoNClll
cywgSSB3aWxsIHByZXBhcmUgYSB2MiBwYXRjaCBzZXJpZXMgZm9yIHRoZSBidWlsZCBkb2N1bWVu
dGF0aW9uIGFuZCBjb2xsZWN0IHRoZSB0YWdzIGdpdmVuLg0KVGhhbmtzIGZvciByZXZpZXdpbmcg
dGhlIHBhdGNoZXMhIA0KDQpSZWdhcmRzLA0KQ2hpYXdlaQ0K
