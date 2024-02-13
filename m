Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3804C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 13:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4C087D64;
	Tue, 13 Feb 2024 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rD9UEFhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B31287D66; Tue, 13 Feb 2024 14:07:54 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636FA87D23
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O70BSD95SBXye4JxXYhkaWQ9+QR/a0UKoytChHB0nec0ShWEs5t3UvjYtRq0BqWNZ14THJvwUNEKCc6A/y1Z62JuAbQHN0OWQI3RdntiRR8N3FmcXbVhOZZjJMu1b5Eq5nqXc92U5QaUZI65f3/0LsqeHwULSJPY3Qa7rBaq6UCW6PyU6g2n8sPzC39Oo0ZMUsW+wtNNQfB6mQT3qrItzp4jP+gpDdUgDToPKo26k+s2z6X7r2gqLEWpdHD1/1mgpyiGw6Z987V6DZPvV5waD/F9ip+gJk/je10vhoS7cx7LIOzrT+mVtO4E7kDkhDQ2rISs12rh/QkTqh6h8/X5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=327u1TqXfr+ELZYaKWJKsDo5HZ6PrufdRh2dW3LwbJg=;
 b=dhRE0lVg2aXSf2/nx4oi0QKFz0E0kARvr+A2L0rq6kgNKFyrpEC7+tOo9pUsLSlupfU5nNau9Q/r+XS69MCAW6Bz/k+nKOIvYGkRptXpOxfeCvB/YBi5W7kpa0MJMEDYed/0fJyW9UnjTwgef+/1y48mixJChT9gWLneTXu8W9bDmcdzeuxeewdKJd52eKfY4NjtrYgZCjGR2uWmmwp/bvcDkpvdBciOdNqACkBGfAZWq466QBAdMK8gNdtJy1vA2geqiXwp+9lwux52Zd9wcx0hy39S7TK919waP967wBQ7gjeXJQLrwK+G9JVrIOPc3DQwXKqh3pkZ8buMjtZlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=327u1TqXfr+ELZYaKWJKsDo5HZ6PrufdRh2dW3LwbJg=;
 b=rD9UEFhk+AnTmO1DFPOqaPsllET4Kq2jo1JEdH08rAlJT0FA39TgKcsOBDkkDxH0pTSnoi0mzQ79yZESQh8faE+SnnwNj+zZQRfBUqZfUADfvGWBqJGq/8lJThaFqValsZ7Wtk+t/7XCYE0976F7kTmNpdHQ9nJDEuOlaYHK20U=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9195.eurprd04.prod.outlook.com (2603:10a6:10:2fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 13:07:48 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Tue, 13 Feb 2024
 13:07:47 +0000
From: Josua Mayer <josua@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>
CC: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/3] arm: mvebu: helios4_defconfig: enable setexpr
 command
Thread-Topic: [PATCH v2 2/3] arm: mvebu: helios4_defconfig: enable setexpr
 command
Thread-Index: AQHaVepnSgoyC1KjW0SthlwTpxzP8rEHO7cAgAETu4A=
Date: Tue, 13 Feb 2024 13:07:47 +0000
Message-ID: <422d9560-beac-454d-a516-1ab8027f6d95@solid-run.com>
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
 <CAJesf3OEfkTw_02jX0rnT2mRqRkHOHRrwpGqTvXHw6rcWAY_8g@mail.gmail.com>
In-Reply-To: <CAJesf3OEfkTw_02jX0rnT2mRqRkHOHRrwpGqTvXHw6rcWAY_8g@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB9195:EE_
x-ms-office365-filtering-correlation-id: 42f56e07-5ba7-4b76-25c1-08dc2c94c67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpRCds4s3zDEmfEPBYRDCArx7P/EFLHgwiOn+pnMFKMLhJ7LDFKGMfbz5SMmuU1h6DI9Vv0SqxDWcHt2n52nH7rEerYMAcyWxcJVjNG0qVrgjuTlin6/FSLfnr4ynGraF1Cm7SLtXK/Mz3lSCSHWpPfE2BhwjjyVcZid8qHDDRFt22OJwR7xkv1a+PsHpIwOmPWerBfg/uKQXXml/JinO3IhZtgj9LXvjMr2pzCscTPpuYO+5BPQadYGrKlAuWz7bNkyWpe8uyRNFnU1BvEThOd7rsKPJNrOVDWsYPmnTWD5COi7R1MmXJco3HdiywUmf9mK+Ek+s5F5WB04k2jFnlX21TLWIlzEdR4VnKygcIZUpPS44V8o2ZjuS+/4nbncTO01YzY82K7zORTLcx2yT9FNVoniUfBPnrhZLLu4+1Pr2SnVGAAjHc0OTJTfcZGXhgfYISnWhBrKuP2WokNBNxIhQWJy4a2ECkS+qLvMgySqOuOF/8U6df+9SBsfnaIXtMzwmQcn1qeVPiFdlEItQCjoAKvEhVqZ11gUUGqKFMFE/sWaniEhlbHHypquwt7LYCRZm5fJOT3/Y1l+wNiy/sqn+ZgRtKCcRWRnPD8e9rIlkY0mbkSBz8wTk6yr20v5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39840400004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(31686004)(41300700001)(6506007)(478600001)(6486002)(53546011)(71200400001)(2616005)(2906002)(64756008)(91956017)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(38070700009)(5660300002)(83380400001)(26005)(6512007)(66899024)(38100700002)(86362001)(6916009)(8936002)(8676002)(316002)(4326008)(122000001)(31696002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDAvNkFMc0tVM0JMOEcxTXp0MWQzUmpMZFJ4YzAyUzRLQW9SUEUrUE1Za3pO?=
 =?utf-8?B?cEJkREhEK1V3Z0Q1RnpxVVI4TzF1MDdmZmRXd3puQVkrR0tvYjRGQXp5WXFW?=
 =?utf-8?B?aVJaOURzZTMzeVpIV1BiM0ZLRnV4ZU5NS0x6UFVMdUJDMG5ucnl6RXEwcUVH?=
 =?utf-8?B?djRzQlIvMkx6OUdxOHJyYjhCQXQ3dHFwZ1VwTk9TMWRCMnhoWmlROW1KaDNn?=
 =?utf-8?B?bzJNQjlpN0s0VGd4UGVlVEpLVjkvaDVCTlE2eFBtVFBDOUgvU3dDTlZCWjN5?=
 =?utf-8?B?bk1EU3VNN2VubHRiK29VK2VPZFhXVEFKUEcvTVBrNzZqOUNLcG5SQ2VJVHBR?=
 =?utf-8?B?anVtY2hpOTQ2UndOcGhYa2x5ZW9iZGNUQU0wTDRpcitTZXMxWFp6TG5iNDA3?=
 =?utf-8?B?MERMZzNNdXdZYTluWTBuSkVzeGNRcGZIR2ZKSjVmeXFnODhiQTZBTzFhTVVu?=
 =?utf-8?B?WmFkYi9KOTJUQ0tYVHlsT1J3ZWxYTnR5a0Y0QjhVV1c0NDk0T2pmQjVza0Zu?=
 =?utf-8?B?VVl2a2xTQVlZV3JPSm04MVFSSmc0c21yaW1pcWY0WUF2QTM0SkUxUEhWT2Uw?=
 =?utf-8?B?WFB1UC9YbjJDVEtPcmNFaHJyNXZZc2NmRXRDSkwwc2VUcTVIeDZJaW9iLzkz?=
 =?utf-8?B?bStXMUUxNThCc2lpcDFoR3IzS09SZ0h2V0xXWUJzYytiVnJpVHNsWGgwRTdR?=
 =?utf-8?B?em9yc2djRDVaVVE5bGcyQU5ycWtTWGFORHpNV3JKSlZKM2RwQW16am8ra0hl?=
 =?utf-8?B?aG1uajN1RVdtSk1LNDhFRng5Rk1PN3JtdTJoYnIzdDRPMVRYL0UrMldhNExa?=
 =?utf-8?B?S0NWaDdHcXpRWjlBRzlWWm9DTFgxZEQ0R0dRR2hxZGZmRlRXaHA2WmUwbWJC?=
 =?utf-8?B?ay9aZm9uWGd5WGtQM2NFS1NzSjR6TkZYYUgvdC9aMGZwQ3dIcTExd0pRWlo0?=
 =?utf-8?B?cUhDTTVXZG5lalkxYVd5YlpVU3F3SWtaUy9PV2trMmtpUHc5cm94MG1ldVpk?=
 =?utf-8?B?RlFrQkZaVXkwSnBaU211Sjh6OVJiazh4ZWJHSDh2U0p0cVh6Z1p5QjhxK3dj?=
 =?utf-8?B?TjA0cjEzNlZwL1NXZ0VoaHFrOGE0eVlEQjcwNTdkU1Q3eXZIQUhkK2VTSktC?=
 =?utf-8?B?aFNoVklsK3lhaEFITUpIOEQyeFNjME0yeU00V1djaWM3VEwvZmhzM0p0N1Jr?=
 =?utf-8?B?Tk0wZmU0MFRwTGdQRmNrRzRBZ2kwUjJGZmFBajBLVGVIaUd6a2hsOUtMOWg5?=
 =?utf-8?B?T2NGbjFjaW9pY0FkRmdQd05ZQXVRNW1Rek5SdTBUM1lZMDBIYjNldFpLK0I1?=
 =?utf-8?B?NEVyUFI3ekZoSC9wUTFJSlZKc0pGRGw1K3ptaEN0RlF5M29jNWZ5c1RlMWJE?=
 =?utf-8?B?NTNSRDRuLzFSbjR1b2JZczNWZ2VUaXVkSlVkYUFIQU8zYVFlWGdHYW10OHkx?=
 =?utf-8?B?UFBrT1Q2NjByUVBTSkZGV001c1lkYWhORkF5UlUwT1picnoyNWJ2cGFqQzNM?=
 =?utf-8?B?STV1RGJPSkpKSkI3TkNjR1J4VFh2VXBVNHpwV25qZXFmenllSmlEZG9lSXcv?=
 =?utf-8?B?ZjhKUHEwZ2N2THNlMDJ6V2k4V3I0SG9EOGpNVUI0bFQxMncwSjVFN2NQanFp?=
 =?utf-8?B?WXJ4SHFnNjZtTUd4SzUyWTZNZ1RmWlN5eVZTWlQ1T0NEaUoreEpkL2xXOFR3?=
 =?utf-8?B?SWFIbXg3NXdwRjZEc2h6RHJ3UEpLdDN4dU5UbFQ2R2FYa0s1aFJYeUp5N1Nk?=
 =?utf-8?B?UUJSZlJ6aHZSRlFXcDNGc1AwU05kRTJMelJOUlRCallVMG1rTGU2alM4SUlS?=
 =?utf-8?B?TTJqQldLMC92K3k4N2VwVUhzVERJZC9WZVp1cVM3czRHNENLVVJ0dUdibVRE?=
 =?utf-8?B?OXVYNkZDQ1FaRGR0Z2Q2dldyYUIzN3ZLaWx3ZHV5LzhnWG04WWZDOUw5NTdn?=
 =?utf-8?B?aHZzZmJNdjZYakF1d3Vab3hjbXpmZFNiak01TzRnRDMzQXEyeUVkUDhnMjFW?=
 =?utf-8?B?SWpFZ0NzeTRRcnJsTDhJOWgrMEh2aitBVTh3Y0xPTktuUWViQWVqZ08rYnBs?=
 =?utf-8?B?Mit2cW5KZ0YvN2lOZWJHcjBhRysxS0x4c2FUMGJBbXhNdkY1Z1ZGUTNndHI2?=
 =?utf-8?Q?UFwKUC/J1jBESyZFCoItpqvy1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698C064312A054459424B7498D2BBDDE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f56e07-5ba7-4b76-25c1-08dc2c94c67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 13:07:47.6189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyGNtno6uFafJIR2QcFHNfhQcDJQQkAZBo8P9LUq3YuLGuiG9gOgOFy3XKsvhb+LejfwaEXdiMQuMH6m6vUrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9195
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

SGkgRGVubmlzLA0KDQpVc2UtY2FzZSBpcyB3aXRoIHNlcGFyYXRlIGJvb3QgYW5kIHJvb3RmcyBw
YXJ0aXRpb25zIHRvIGNhbGN1bGF0ZQ0KbmV4dCBwYXJ0aXRpb24gbnVtYmVyIGFzIGFyZ3VtZW50
IGZvciBmdXJ0aGVyIGNvbW1hbmRzOg0KDQpzZXRleHByIG9wZW53cnRfcm9vdHBhcnQgJHtkaXN0
cm9fYm9vdHBhcnR9ICsgMQ0KcGFydCB1dWlkICR7ZGV2dHlwZX0gJHtkZXZudW19OiR7b3Blbndy
dF9yb290cGFydH0gdXVpZA0Kc2V0ZW52IGJvb3RhcmdzICR7Ym9vdGFyZ3N9IHJvb3Q9UEFSVFVV
SUQ9JHt1dWlkfSByb290ZnN0eXBlPWF1dG8gcm9vdHdhaXQNCg0KLSBKb3N1YSBNYXllcg0KDQpB
bSAxMi4wMi4yNCB1bSAyMTo0MCBzY2hyaWViIERlbm5pcyBHaWxtb3JlOg0KPiBJIGFtIGN1cmlv
dXMgYWJvdXQgeW91ciB1c2UgY2FzZXMgZm9yIHRoaXMuIGFzIGlkZWFsbHkgYWxsIHN5c3RlbXMg
dXNlIHRoZSBnZW5lcmljIGRpc3RybyBib290IHBhdGhzIGFuZCBpdCBpcyBub3QgbmVlZGVkIGZv
ciB0aGVtLg0KPg0KPiBEZW5uaXMNCj4NCj4gT24gRnJpLCBGZWIgMiwgMjAyNCBhdCA5OjEz4oCv
QU0gSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+IHdyb3RlOg0KPg0KPiAgICAgVXBk
YXRlIHRoZSBoZWxpb3M0IGRlZmNvbmZpZyB0byBlbmFibGUgdGhlICdzZXRleHByJyBjb21tYW5k
LCB3aGljaCBpcyBhDQo+ICAgICBkZWZhdWx0IGFuZCB1c2VmdWwgZm9yIHZhcmlvdXMgY29tcGxl
eCBib290LXNjcmlwdHMuDQo+DQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9z
dWFAc29saWQtcnVuLmNvbT4NCj4gICAgIC0tLQ0KPiAgICAgwqBjb25maWdzL2hlbGlvczRfZGVm
Y29uZmlnIHwgMSAtDQo+ICAgICDCoDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+
ICAgICBkaWZmIC0tZ2l0IGEvY29uZmlncy9oZWxpb3M0X2RlZmNvbmZpZyBiL2NvbmZpZ3MvaGVs
aW9zNF9kZWZjb25maWcNCj4gICAgIGluZGV4IDA0MTk0MDA0ZjAuLjczZjA2MzgzNDQgMTAwNjQ0
DQo+ICAgICAtLS0gYS9jb25maWdzL2hlbGlvczRfZGVmY29uZmlnDQo+ICAgICArKysgYi9jb25m
aWdzL2hlbGlvczRfZGVmY29uZmlnDQo+ICAgICBAQCAtNDQsNyArNDQsNiBAQCBDT05GSUdfQ01E
X01NQz15DQo+ICAgICDCoENPTkZJR19DTURfUENJPXkNCj4gICAgIMKgQ09ORklHX0NNRF9TUEk9
eQ0KPiAgICAgwqBDT05GSUdfQ01EX1VTQj15DQo+ICAgICAtIyBDT05GSUdfQ01EX1NFVEVYUFIg
aXMgbm90IHNldA0KPiAgICAgwqBDT05GSUdfQ01EX1RGVFBQVVQ9eQ0KPiAgICAgwqBDT05GSUdf
Q01EX0NBQ0hFPXkNCj4gICAgIMKgQ09ORklHX0NNRF9USU1FPXkNCj4NCj4gICAgIC0tIA0KPiAg
ICAgMi4zNS4zDQo+DQo+DQo+DQo+IC0tIA0KPiBEZW5uaXMgR2lsbW9yZQ0KPiBTZW5pb3IgTWFu
YWdlciBTeXN0ZW1zIEVuYWJsZW1lbnQgT3BlblNoaWZ0IERldmVsb3BtZW50DQo=
