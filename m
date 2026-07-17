Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E873C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2256784E33;
	Fri, 17 Jul 2026 14:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="sDoqRWhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6C584DEA; Fri, 17 Jul 2026 13:02:03 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3092584DCA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 13:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYvm7Gc8P8p08GJF9EetJbQvneJzrxQFTQvJzD4rQjci8TjC4Frq0dn+xsdKnO+5X56wK4mdmlqTyTY2cT498WKe3KgsMb6epNJZkolYj5RTl1PLsz98YuftoJsAoSDBxiPqzgkEjWgBEWaLB1n7/C2PDpRyy3eu+zucxazraNUCB9KOEGxAF2PDeg6ErCqzM3MwLFlye/93MPPhLx3Ozmbq/QZXllDa2c+zRwgzkByjf85P2uCZHGyVNhk2iWrO7g7R3vsXsNncPELitiu5xtVqhm9giQB2cPQfw64S36/wt8N6sKyLd/YbyWgNgU+wNjvObk+UyK0Zb0zvnjsJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR5hCM/PbLzAKgEKW23d2w9TMzKVZeQqQiU3H42+8qo=;
 b=emShL6OijLVCN8OyBMLtR/gqHy2LqrqFrX775gHmMFi2SWAg3Yp/7EG+a8LdS8GO9afQuo6UE22NxIQPtMlA9SwRagbjprYzNxiNQQJ97Cbv0NA7ujqp893KE3PuW9wF3MtCwbYP0WaQVryUtbDDayOK8n2sUO2WZ3ea51GzlCiPO+bkaNi5XoH/Aj4iLCnyaTOdkSDpUU5CSt9JuoaPbIwzs0mNKpXF8Zk/WVmwX8WH5JOAMuXPu8qbnqiNV8UzX76FrUxK0oUQyHg3ntABqTo/TUyckN1s3LCco4o0UPBH72stfzU07ts29GOTvVHBA8fnUX0i88TgOEGLYQCfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR5hCM/PbLzAKgEKW23d2w9TMzKVZeQqQiU3H42+8qo=;
 b=sDoqRWhpAsPH5mGRiga2kT6g38qHoYjoF87MzcrFaCP7LLy8BVp6a12Jh3BGv8SocGVxdD9OCvL4FUDH4qiRBbUii+bdauEJRUMb5PnBYEPboBTIosqAO0cBQBTa9m6VTjktWvlrNjqFRyepD/asdp6DwWbqpt9m3/TYir20ZD+sBLyjqoG6m6WLqEoAH/a107sMUgJ7RvyseXNGpHvosaEO6v/TaK2bdHXTaX3nnm+b/7ec9GJNxgNk3DuUG+97upaH5NfcQBJY0Sa8Vo/AjYQzGLhTaOOQXmWYVJAj6aLYCMWwgHv0nUD3+7WArdFOrvNhmsLzpKirQwi0eouN5Q==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AM0PR09MB3697.eurprd09.prod.outlook.com (2603:10a6:208:184::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:01:58 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:01:58 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "tim609@andestech.com" <tim609@andestech.com>, "leo.liang@sifive.com"
 <leo.liang@sifive.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Jovan Dmitrovic <jovan.dmitrovic@htecgroup.com>
Subject: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHdFduv9mDkT+6y9U22C1iPNgsk2A==
Date: Fri, 17 Jul 2026 11:01:58 +0000
Message-ID: <bda0ca04-40e4-4e5f-8d77-94f396f42b2e@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AM0PR09MB3697:EE_
x-ms-office365-filtering-correlation-id: ea345551-7ab5-495c-37a5-08dee3f2d23f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: hV0YXLRH3AKyyB0/o3wUYA96zPV7TSUmZNFISKPiRk9MwXCH6lu75IeqAPX9aOYoU7rA/x+LRKfXbx/ZWQtUOOt0qqzVnIWRp13MTrTVof7SUFuYYjjFMYYVVhy7MjfwgJpaDXi1ZEKJjJ5CSmnWAKtRRGGckh77Un8f3u/guzvZc6pUgf+aMDkjk+MWXiZAbhseehEaeHaSg2ndg5WbZcgXz5XnEO3XoYIGumIb+iSrJNE0a9idyV4doaWmuwAYYbJGCJNcsYfr6Vop73X/Mzi09KREl1A+O+QyeIZLX6siaoDdEhTLNpthlZj3yv50knDh92S4wKTCAhRgL4LFKhty2pgOpfOw6VXHE/gLr6kOlDZCp43G5n2oqWMD4GnVfTDWJZEtK2mqsXk06gGkloXpBL2nB3VTUnR8FAYnN1ihVTyRaWhqt3n9G5/m9woe0ruBKa3bAwBlzvbpfUPQaxJ84Z/DX/fOpiBVuRBxPKfRYzRettyfhcHiegsSRVvOFXmZ+Cn50fYY4W+lDawQslwCVWx6YCbriEwd/9wAGMWYhhEThzolA5MZHvwCw3Xe9dvRdHmZ7nUDS6MUEjF3aOkUwhfyT679xm15H9UnoFtSdIu9sthBUuJs39YIw4VoDp04C9C7lUWmT1Lnh+JzQmR6J07tYiCQkI6z2xkOXm54EZqfzPjv4pZtOPJdsGDnVMpgPwEU2cNmqYFfXqMuR15iQiqkU2BYo7QUVG4D68g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjkyR25lUjR6b0VwSW1TMFFPRVMydmZZRlFGaDI5V3hySzZrQWNreFdITjBx?=
 =?utf-8?B?NzJ1RnpjNytMV3ZMM2g1Q0NURnZURldTdXI4cEUrRTMxMDBTOW9Zcy9uTStp?=
 =?utf-8?B?aGlEMWdWY0htcGp2QzM3L2J4dXhtUkJMTTRXOS9XQUM5S0cyUjc5RGNlVjZ3?=
 =?utf-8?B?eTA5bW9idjdqWHZ4cDExT0VmSFArR3c1L1d6R2hib3lPdERvUFlmeDVNODhy?=
 =?utf-8?B?VVgyUnV0Q0t6NmJkYUtNN09Fb3laeUhwdlRBeWNIRlpSWlFXeVRZQ2tseXJX?=
 =?utf-8?B?OFhreXVpUE5jZUZudW1uRk9VRDdlOU1VbERPZUdQT3VRNDBWd1luTW1GZlFY?=
 =?utf-8?B?SmRVUEQvRVlib0hqeHVlT3E0UjVIMFJLZWxaUHdtb054aUE0OEpjd3lJMnZv?=
 =?utf-8?B?eHZUNnZVSjZhRzR2SjZpaktTSHFaT2VubUc5c1JpVlpMdWhYWlBWa0xSWUIz?=
 =?utf-8?B?a2ZKaG9pNDliR2RkeUQwMTBid1hTbXFYYW1ZQW9uYWxiK1k1NTBIVGE1Ti82?=
 =?utf-8?B?blBxVDZJSjZ1UE1ORUkzTkFYSFZlMjZqWjN2TUxYcnd3Nm9CdGpqdVpRdC9m?=
 =?utf-8?B?cTFNTVVRc3Q1dlluaTFaYkh5Qy8zcnNYTUJFYVFrTTBMMm9sYkVzQ3RWQ25F?=
 =?utf-8?B?dDFpRXVWYjNqYnEwWktzRW80VnJneU83OVpqL3dlUWw2clRpNUlXM2NvVVdq?=
 =?utf-8?B?QVNEN2E1eGlrS0kzb0d2Z1lPNThmRFJLWnloRElNSU9iempXWVJFQmhHYlNZ?=
 =?utf-8?B?OEhNQTFMZUdMWjVJM0lRMXNSN3dFa3FkZ2NKUEtUTXVMU2NFV2xxM3dnV3Nm?=
 =?utf-8?B?VTBBczRZUjNrRXhDZmlTUTFrM0FmVm8xZDZZYmJIblUvTWNEb1JNZk5NL0JQ?=
 =?utf-8?B?aGpyVit5bU1NcVVQY0dJNklobWNKa0FwSDZ3VTRkcEJEK0NMbm1ycDFlR3Yv?=
 =?utf-8?B?M1NJQkprWVJxTWFuNEFwSnhRSk1SdFVpN2syaG0xVGwvVDhjbnJ5VUpEcFNM?=
 =?utf-8?B?OHBjTVJ3WlFxQnlYeGxEUklEeXBKRTlDTGpDR0czM2xROGpibjRNcGFxVWVQ?=
 =?utf-8?B?ZXdiOUpGQWlETWVwSGZRV0M3RVV3UVErUThkem5VUnp3ZHdJS3hDYm01OXQr?=
 =?utf-8?B?ZEZncm5odytIVFhvWHh1Z2xOTWk1bVNGQnEyYllnQWs2U1kvb0lEelltOVZE?=
 =?utf-8?B?dTEvdGNSVGZiaVYxUkp0dXM3VFI0NXk1b2RlQ0JtSmNMNzFBeElpSTQyd2cw?=
 =?utf-8?B?Um9vUk5acFFxVlpvbE9vTjhKcUJSeTFISjl5MmRtNWhpOEdzT3N4cjBNL2Rr?=
 =?utf-8?B?bjR4bUxURWFwVlZYSU04NDhXVjNGVUpybmt6a1NoclZoWW0xZlZHNTRMZ3la?=
 =?utf-8?B?K0lRYlNzblAzWjI4YzY2RWJKUmFxM3pacGtncmZGaVpQaytpWVkrZVc1bUJk?=
 =?utf-8?B?RkZQQi9NNkpwRnh2UUZwNXArNXpXVThVaVA5VTM4TFpBdjZyWHRMYThZSndK?=
 =?utf-8?B?Q1JkWXYwVFpuUVFkNWdvQUJlQ3hUWFY5RDVYb0hqSVlYcVlNaWVoY3JLRGRL?=
 =?utf-8?B?WlFHOS9CTjREU2NoRVVtOVB6anZXa3Z6eXpYNngyY1hUUEhtRmVpbUNkWEhM?=
 =?utf-8?B?SHZrSXFwRlpubE1XcXhoV1MreE1nUTBoampoaDk4SFdJNFlPditoRWpnRTJ0?=
 =?utf-8?B?WjZZd2lTR242UlZzcVk3MmEySXczaklKOStXQmZuUWNXVFF2RGpHUzBBYTRo?=
 =?utf-8?B?a1ZDOWdhUkIyZEJ3U0EyL1BudENQVG5Xd2VjdEFnUWRkUGRnVlQ0aytYTmZz?=
 =?utf-8?B?Sk8zdVNPTFJqbW1BdmhlbVRhVU02YTFpTStia2h1QWpPRU1pMDYvMWdIQWxJ?=
 =?utf-8?B?NlgyRUdyNlhwN0dDSmVyYnpGQmcxUjFXV2lBUmp6allnWkNad3FqUjhUa3c1?=
 =?utf-8?B?R0ZubDZNQmxmQXVndDk3WElQaWFmWkd3MHMrdGF4TEtoQ1pZL1BtdEMyNzZM?=
 =?utf-8?B?bytNMHp6YUt0NE1zMlZ1VGxhTzVOVysrYkZOMnhZd2h2Mjg5V3VrYkZYOGY0?=
 =?utf-8?B?emIwSUFoVjhjcHl3WHJIWHcvQW5vY2FCSys4UVBoKzZmVU5sZENNK3hydjJU?=
 =?utf-8?B?QmdLTUE3N3F1Sy9CKzBtT0tMc0lBRGUvNXdvSTJzc21IbDFnWlRqNk9taFdz?=
 =?utf-8?B?SC9QbldGU1RpUTBQcGg2akk4TWh2dHlVb2JNOFlleXdLc1BuQzVpK1Y1eXZU?=
 =?utf-8?B?TUk4eWV4RXdpeFlCSXE2WEJXNlU3WmxlYUI5ZldkNWNyTjRzb3FKRVJEWk1u?=
 =?utf-8?B?cXpjU2RMcGJsekNZNGttZVVva08vYXByTFFOdklNSzZlWWlFcDhYQnpSZVBN?=
 =?utf-8?Q?uY61OWs7787c1mSM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78F764DFDEEB814F86012A28C5FF1AE5@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea345551-7ab5-495c-37a5-08dee3f2d23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 11:01:58.2087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HS1qcRUiazJc6c5WXoSAlC0QovZJAORRhj7vyjPtu/+1SHZUnZ/Eajz0p5GL0gCZBgWxdpvw/CMBHsAR33Q7gdmCteemBpb86RhBFPJYtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3697
X-Mailman-Approved-At: Fri, 17 Jul 2026 14:39:44 +0200
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

SGVsbG8sDQoNCkkgd2FudGVkIHRvIGZvbGxvdyB1cCBvbiB0aGUgcGF0Y2ggc2VyaWVzIGxpbmtl
ZCBiZWxvdyBhbmQgY2hlY2sNCndoZXRoZXIgdGhlcmUgaXMgYW55IGZlZWRiYWNrLg0KDQpodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvbGlzdC8/c2VyaWVzPTUwMDMy
OQ0KDQpUaGFua3MgaW4gYWR2YW5jZSBmb3IgeW91ciB0aW1lIQ0KDQpCZXN0IHJlZ2FyZHMsDQpV
cm9z
