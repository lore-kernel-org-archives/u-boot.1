Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBBC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 11:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8973781E13;
	Mon, 30 Jun 2025 13:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UK1U6uVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4746381FEE; Mon, 30 Jun 2025 13:33:46 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FD880B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 13:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnRhcnUWqQVWEFd+LY1U5klSx7ftd08EnrCZpdOyNXFkZYm+GL6r/tc0f5Y+EtfkW6KZTX/jW0H8cvqnIa/EwdCwuBrU6XUSXxsGc0TPe5s8tIYs1ejd4IyXcG1OXoWQspSEmlBBaWyhcZQPGtjsSlSc132N/sOGsIHQeLdHwVhaUCUeiPnxjKFHlXQvCENJ6L5UDYotrMGqkI8/EPa4Kngv0i7c5JRRL93Xit8mqFLzybP2Qz+Ri+ohGOsgd3A6zhZPva6SmtB37ROXGNZYj088avS3mTdGNIhu3d/ZOpymvaherB40tIqGyftTSO8xGISNp8pwWjlwzJA+O+2Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkvp+ZdVCirbm14SEZuHOQCLTR7r2U4UAT4OWfyj1eU=;
 b=hbNuy/hYsTGY4mzLV3yPyIn3EudzMAG//J7ZY4/aym1YxHmy2CqAlU03eIAjip1tgBQrDaEeb2YRZtiKE3+5/JxlORVtVEDhUVWjEZFZBD1+cID+hp5Jw7PQaMJq2zB0TOOvcF699+E39oCB3MtP9jDz/aGoTgWcwvPLDKB5OAh45fWMaDoJaqDOBaHVU14ruaXy+GLJMqCt9Wf4pmlNR4EI8XmUxOMqJ3YvxnXpNNuolNlpv51fNNmksYMCeWr8SDUmK+IcRz3U65sR80yZSiFbBXTo5zaB1vsPt7gYdABk4eQ79InrJ3W7eD3y6vwMygq+42WGTvfDpKVxrebE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkvp+ZdVCirbm14SEZuHOQCLTR7r2U4UAT4OWfyj1eU=;
 b=UK1U6uVXjyGIBWjszcCc/2TzP9yAMvGCGLp3rA7+EWhpli0wrvhsIa6BKW+6UqIiaXA4xN6EcAGmMsOdHedr2bBJ3613cgzyCRukgAxalJL/LWZXd0pS7MPSEJTadu5EWe9aamLyehtJxmwOLePTi46BktLo3rlE/KA+azhzV3Gy0Boh7yNypMODllU1zRMQtq1bj6uZAi2bYoX38qZKhKIXnpKN0WZWSigUx1SnSEMVHxHfDjX6XPq5wkN83d2OTymRsVZttwhRdMncfIPYFb+FdU0/1YOFh8L7PWXI8qv0npVEWsGbdQH5byaWyEGdefsAeUuMhWMK3YZtq61Igg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM9P195MB1268.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 11:33:35 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 11:33:35 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v2] binman: migrate from pkg_resources to importlib
Thread-Topic: [PATCH v2] binman: migrate from pkg_resources to importlib
Thread-Index: AQHb5zItdK+5Vk0z6UeQ8bP/e2MJFLQXbc2AgAQpbgA=
Date: Mon, 30 Jun 2025 11:33:34 +0000
Message-ID: <b391dbe5d921903b692403bc6844812c6cb6723f.camel@phytec.de>
References: <20250627-pkg_resoures-removal-v2-1-86b277b02552@phytec.de>
 <20250627200015.GI4003484@bill-the-cat>
In-Reply-To: <20250627200015.GI4003484@bill-the-cat>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM9P195MB1268:EE_
x-ms-office365-filtering-correlation-id: 731bd37e-b436-4781-1884-08ddb7c9f301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEZlSEhGeUhId3lUNHUza1JDamJkNnpSSFMxTXZVSlZmRzBydVU5bVR5alIz?=
 =?utf-8?B?Y0Jmdi8wNiszTThUQmhtYXdtRjFUTStNUTZWdjB1Z0w4RjZOaFpxdXdKVlk0?=
 =?utf-8?B?UlA4cGorS1ZDL0FTQUR2U2dWUTAweEY0cTVBTVkzTDhudWhaRzBnNVlCWWhh?=
 =?utf-8?B?dElJSmpIWU5xQWh1OXhYeFJZR21DQ0NzYXIrYkFJQTF4V2M0SGdrQTdLTnRl?=
 =?utf-8?B?Q0pubXJ6cUJjTmxMbmw5emx4VXEzRXVRL0VSMnZwT29ndnF4MkxodllXSS9X?=
 =?utf-8?B?Ri9Bekhtc3JycTNsMlk5NTJTRE1ZRGlNVHpaQ1hxcGwxZmNWbWtpYWlyN0FR?=
 =?utf-8?B?R1NxYUlrdG1DUTc5NUM0NlVsSDdacmo0QnI1UWpEeVpGTFBoU2lBb0hCQXVX?=
 =?utf-8?B?Q0I4SW16UkhrMktDaGg4eFZEbkZzL0p3NTNhN3N5Y2xUSTM3bjUwNGxlNTBQ?=
 =?utf-8?B?UVpiTHZGWVpMeVY3VlBKclcrMHdIVW1mWFVvalJKRy9zcENtc2s4dm1ybXR6?=
 =?utf-8?B?b2xoQ1NLdnZRTlFkZEQyZmRNMXkzbFVwNDZLS1RDL1Rub0ovSEZIS2lZNVZG?=
 =?utf-8?B?aHVHVnduWFAwSndZR3NzSFBxdHQwRDA2akNldmRObm9DUENLdm84NnBHcVJm?=
 =?utf-8?B?d1l4NjByNFltRElYd0JqdmswbjM4bjE2RUxwdGUrVVo0cnhEeTFDTzZVdGNw?=
 =?utf-8?B?RG1mWkZQRkh5Y1cyT2toWG80d1JnZXZ1blIxeVBxVXpXendrUnNJYWtlMCtv?=
 =?utf-8?B?cTNZUTRXNmdjMHVLYUs3blREVnRNeDJQZ1YrZVFES3dZNlZWZ1RLNzMvNUR6?=
 =?utf-8?B?SUxkblNXZkVQWHRZSVoyeGcweGZLbTV6Z21vVlI1Z2RYb0k3WnhZdmMxTG9n?=
 =?utf-8?B?NnN2d3k2eUVub3o4aklEemlBbVV6d3Qyb0NnODZwNDZUTHFwUTRxZ3JTeFE1?=
 =?utf-8?B?L3A3NUtreHV4SGIwRFMzYWd3K1VTQmRFanZEcFNHQWNTLzIzS0hMYmZKZzFh?=
 =?utf-8?B?RWQvSStCVXJwcHFGS0V3UU45MXhMbUVCQWg3UzhsSGZZNjVXRlIwZEtOQlhC?=
 =?utf-8?B?clhMdEN5L3NwdHdUTzg5Z2NtVWswYWxvYVJ4Ymx4SGcvalVNRTB5NThmZkFO?=
 =?utf-8?B?aDZaMzFqNnVpNDgydzd0c042TEl2UTRLUkE1UDRmc2pyVjZhU3VYQjd3aTBK?=
 =?utf-8?B?NjBJa2o5eGZvd2dETUlnN2ozVW81bHhNSzNsRzRQZjhzU1BkTjlvT0dTNWkv?=
 =?utf-8?B?Rm14ejJoSGNvTDdDQ2xtdjdZUmo5RjROWnA2SllPRkJINi9sL2x3TUJkMGU5?=
 =?utf-8?B?VzFWMmMyTmpRbTBQVG5OR2RZK1B6SlRYcXdsZFMvSXBiRzNhZ2pmUzNDNjhW?=
 =?utf-8?B?a2hNOHZRSzIyZ3R3SHJSQmRlcDk0Rko4eDh4TlVUSjZxdGU0V2RaSVdYTnAw?=
 =?utf-8?B?K0pCVGRJdXc2SUNJb3pIN2VWZnJPUWtqUy9TY0tYUzB1UDlFOWo1c2ZkNmwz?=
 =?utf-8?B?OG1IOUpsM1B6bTBMZk95UXhCZGpSSnU3bWJvNnY1a0FaZFp3MFoySkd5MGhL?=
 =?utf-8?B?YVVOZU15bUZkdVV6d3hpYmtia1F3VTNNSXUwa2pBSVlzQzhpMnFobFBoQkh6?=
 =?utf-8?B?dXFWV2tmYXdLalV0UjVxbnVZSDFVQU1zTE92cnFsQk45ekROTHMycGRUbjZ5?=
 =?utf-8?B?cElpTHU3N1p1dnBPeUF4emxPUVhLQ010bWt1TzVMeFlZVW1WQXlhV2ZhbFZ6?=
 =?utf-8?B?cTJTWFVndmlOaUV3NDA3SDV3Zm1JbEg5N21WbWdJRGZ0eWRjbHVXMXhkeGl1?=
 =?utf-8?B?L0FSM2VIRnRiTVQ2LzJ4UVlhM1oyalNVc0NId0dCTVBpekJqTldIY25ONGdy?=
 =?utf-8?B?dG9yUEQ3bWx2MWRPdnQzdXlpWDZUZXVoemRGOFhhMTd5QlVCUzQ3MktGR0V4?=
 =?utf-8?Q?GkydjUOK+R0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3UwVUtoZnFXVFdtWTgwbFRGY2d5SUdOMFZlVVN1bVN5Z1ZjOVkrYnNyaGgv?=
 =?utf-8?B?QTBoV0g4aG9JeEJNTm9wdjdzbXZvT1hVY3V6Y0FyUUR3UnEzVjlwVnpHZ0Qv?=
 =?utf-8?B?YldGa1gwSjcwTVpxQzd5MW95UjB6Wm5hcWUwc2Qrak12QTE1cHFXb3EzU3c2?=
 =?utf-8?B?UFhiUXhyNWhYdzhXTWVkVHJGN0RkSjZzcStycFZWRkd4RzhmRXgrKzJFZVV2?=
 =?utf-8?B?TFJOcU9yZ29MSUNhemZwNUYrMmZidGVYOHZHbUxKTzJXOXV2M1NjTWJXUWlY?=
 =?utf-8?B?UjRKZEpCeUJmdDVvTWRkS2dHWnBHVThzYmpKcHJrTTJkRTBmNnZiMmRQb0oz?=
 =?utf-8?B?S2FrZnJsS0dzNUNoV2o4SGpuK0l6OXZMTGFxZ281YkpsT01iWG91TElQVU1W?=
 =?utf-8?B?VVVXeExTR0JLWHp5djJvblhkZzY4NGxSVmEwSjdxVFRLM2Z5K1A2VVBFaU5Q?=
 =?utf-8?B?UDY0STFpMjhzRDFCaDBublcwaDd6S1hWVXdGWmUwMDdpTFM0SG1TNEJxRkN5?=
 =?utf-8?B?WEZHWDNuUGdHQmVYdERpU1BMZGlxaERkdWx0RWVscmVJWjAzWFBDT0RZYmE5?=
 =?utf-8?B?dlI2eWlRd05ycVF5aUNNWlYvLzJWWUg1bXZXdmZpSDVidnFUZ01LckwwV2Ez?=
 =?utf-8?B?YmlTaVNSV0ptaHZoOXEwZW1yMWpyMWVUbFE3OS9mc1NkQngwU1BFcmtkSHJF?=
 =?utf-8?B?S1o3SC92aG1XdUp3NWl6MUg3bXV6b2FJVVFmdVpHclI1L2d2WFFEZEEzRVBR?=
 =?utf-8?B?SDdvemcyMzRXb2xJQjA5QXB0TkFOd1FidnA4MlYybnkyUkwyVTR0UXowb0Fp?=
 =?utf-8?B?TlpCRk9OY1Eyc1YydUV2S0dTdmpJNC9tbE1GV3FCcXVTd2FMa0dzUitZSWVY?=
 =?utf-8?B?dU9yTHdYWFIrTEcrOUdXaFQySy85SzVveVlQU2ZWcW81MEJNeHc2SEhQRnF6?=
 =?utf-8?B?bGNGMHl2dkw5TlpkQTFmbHhPN1ZOUzJpVFMvbXphRGxpdS9JRks1bDZHUU1L?=
 =?utf-8?B?RnhrZVp0UW1ZS0NJYmNRWnB5akNWTnZDNzd5dEJSVkM5YXdkRnFYd2VpZjJP?=
 =?utf-8?B?ZituczdGbStWcTNwUFFnaE90ZEhwQUNDemhTcHY2UGdUck9hRHJFUE9KS09N?=
 =?utf-8?B?NmFSZWtZSnZXNXJaTXlvVzlNTDA2UlBHYmZBUnZCZE05NmxkSkVzem90RWN0?=
 =?utf-8?B?NXVYcW5OVEl4bGJ4Wkg0bFlrYlVZSUk1cytiaU5JNEo2alJGSXBialNNMGM2?=
 =?utf-8?B?K2pHc3g5a2hOVHZBUm1nQWcwbHh1bWdFSTdQTE9DSU9vNTRDVjlaKyttbURs?=
 =?utf-8?B?dzlWekFIaHZZMWpTTXdXVFNhUlIvNEdtVE9kZWljdlhMZTl2cHlyM1J5TEZp?=
 =?utf-8?B?MEJpT1dscGhqSW9UTVpPa0d4YmFZN1JXd3VzakxtYW9CQjlXTStGTjJ1d3g5?=
 =?utf-8?B?M0Nhcy9ma0l3SnRVSXVGalRWdnYxNkJKRDUxZmdXOE04MGd2UzVjYk1FdVJD?=
 =?utf-8?B?OXlZTUtlZXVJN1pQOWw0NDZKZ2x6YzBwdVYwNkNNQXgwSG5jT1NMcmJ1VGdE?=
 =?utf-8?B?OVo3SUZIZjI4Si82L3ZjNDZJcTRzR29ldmU5cTdTd2FvZWRoZTZKVmFlTDhn?=
 =?utf-8?B?Nmw1K3I3cFVzOFBOZmlrNEZmcy84TndOdm1uVlJFcmxGaTJtd0c5U2Z4bHpT?=
 =?utf-8?B?WjZ0MXp3Qi9YRXdzZ2x5UUs4Rk42anhHOW45a0tXYm0vbDZ0cnBYd3p4UnFL?=
 =?utf-8?B?WHQ5MjE4ZHFiT0V6VXZuZXBIU1NJNkFMcVhNRkloSzcvT20vcEFNNzZHSE9U?=
 =?utf-8?B?cGFPMlI1S2JpMlFYZmozWnc4NVhjSEJrVHRPbmdiUmp2SE91WXpWTng3QytO?=
 =?utf-8?B?RnVSRXB5QlRuRTRDT0hJUVR3cDJMZnFxY3JsbSt4OFU1UG83Szk2WlFxdnBC?=
 =?utf-8?B?MzFVUjZCQVNHZ0NkWkh4eEhqeVhLQXUwVzRYNjh1L3p3djBQalFBbm9sL3hU?=
 =?utf-8?B?Rm92V25FemhLbE52L2lSZFQ3dCs2VERGQVhPU0xZNXhjK29HWG03UjlMM0Vu?=
 =?utf-8?B?QW16SFZtUGV1d1NiZFNXY2xoanNSTnJsSUFaTXkraS8vUTJCSFJTR0tMclFG?=
 =?utf-8?Q?CzyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2F5A7AC64543F4381D9EA6168306E00@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 731bd37e-b436-4781-1884-08ddb7c9f301
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 11:33:34.9155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9G/s1BE2sLODOxUfe7cVOSrEh67xG0F5plSKqwucc8LJZ7mbq60ZghtJ8gtme24CcyU3wdrxql0XtCr7saUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1268
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

QW0gRnJlaXRhZywgZGVtIDI3LjA2LjIwMjUgdW0gMTQ6MDAgLTA2MDAgc2NocmllYiBUb20gUmlu
aToKPiBPbiBGcmksIEp1biAyNywgMjAyNSBhdCAwOTowNzozNkFNICswMjAwLCBZYW5uaWMgTW9v
ZyB3cm90ZToKPiAKPiA+IHBrZ19yZXNvdXJjZXMgaXMgZGVwcmVjYXRlZCwgdXNlIG1pZ3JhdGlv
biBndWlkZSBpbiBbMV0gdG8gbWlncmF0ZSB0bwo+ID4gaW1wb3J0bGliLnJlc291cmNlcy4KPiA+
IEtlZXAgdGhlIFB5dGhvbiAzLjYgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuCj4gPiBUaGlzIGFs
c28gZml4ZXMgdGhlIGJpbm1hbiB2ZXJzaW9uIHRlc3Qgd2hpY2ggZmFpbGVkIGZvciBzZXR1cHRv
b2xzCj4gPiB2ZXJzaW9ucyB0aGF0IHByaW50IHRoZSBkZXByZWNhdGlvbiB3YXJuaW5nLgo+ID4g
Cj4gPiBbMV0gaHR0cHM6Ly9pbXBvcnRsaWItcmVzb3VyY2VzLnJlYWR0aGVkb2NzLmlvL2VuL2xh
dGVzdC9taWdyYXRpb24uaHRtbAo+ID4gCj4gPiBSZXZpZXdlZC1ieTogQnJ5YW4gQnJhdHRsb2Yg
PGJiQHRpLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVj
LmRlPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gLSByZWJhc2Ugb24gdG8gbmV4dAo+
ID4gLSBMaW5rIHRvIHYxOgo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDYxMC1w
a2dfcmVzb3VyZXMtcmVtb3ZhbC12MS0xLTk3YTI2OTQ0NmQzNUBwaHl0ZWMuZGUKPiA+IC0tLQo+
ID4gwqB0b29scy9iaW5tYW4vY29udHJvbC5weSB8IDEyICsrKysrKy0tLS0tLQo+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IFRoaXMgc3Rp
bGwgZmFpbHMgaW4gQ0k6Cj4gaHR0cHM6Ly9kZXYuYXp1cmUuY29tL3UtYm9vdC9hMTA5NjMwMC0y
OTk5LTRlYzQtYTIxYS00YzIyMDc1ZTM3NzEvX2FwaXMvYnVpbGQvYnVpbGRzLzExNTI5L2xvZ3Mv
ODMKPiBhbmQgYWxzbyBHaXRsYWIuIFBsZWFzZSBzZWUKPiBodHRwczovL2RvY3MudS1ib290Lm9y
Zy9lbi9sYXRlc3QvZGV2ZWxvcC9jaV90ZXN0aW5nLmh0bWzCoGFuZCBtYWtlIHN1cmUKPiBDSSBw
YXNzZXMgYmVmb3JlIHBvc3RpbmcgdjMsIHRoYW5rcy4KCldpbGwgZG8sIHRoYW5rcy4K
