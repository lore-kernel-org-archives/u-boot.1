Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7980C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 13:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C1780FA6;
	Wed, 29 Jan 2025 14:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kTNP4GRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C768681951; Wed, 29 Jan 2025 14:10:32 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7538083F
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 14:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=magPcl9SVtuE3le1rBJJv4y3myOZHdtxb4KA5MFDf+Ypwzl/63j98NWablKdwyifqN+UYN9mFo6gcN8oHB0lrSziBPzJ2kZbM5Nejx8Gns+l4qBVTIWBem4Si2cnG42x+0zRybTPPvY+k2X6SHKNdsjfR4qpxIraD1FHH/Y3uwbzO9SdtZAMG1xkyOpkMjWZsUxNnDm6LL+oPBGtRARJKie9eo94Ws6Lphx+M8jpm657a5+jIeuWC6x/zQEZGLtuOR55yq8LlBupvLTse0WI65ndImO22M92okM8vcrxnqQpx8YDAWj74N5odYTZiQo+UrTQPU5YeL43TUl9Iut88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iljQTPsE5WJZe92jAidXXv1o3B05Esa6pJtd0PduwjY=;
 b=wlc7oknNcyr82yrdlzWLEZbmhVsSeFYkUgQlQv/VKLYP4Oy55ZiPMODviBJif9Z4TwFoqhz8HoP/uatApyVwFUnggMn5JT+a/QeDtRV+UTPSwHchrss9ZJ3SZsUcMb9O+uN9Y5e7OAHzvvRYuN1MHmBPj9Oq2MZ7Au7cK6AQzb/3dZDbS0ZEcU4cF50ZoKU5O9Sa0PpL+v4vFP38PdaX/XMhnS/q5DtqMGvBvwEFXfVvhuu754jDfAJ9/KzcA78+sb9d8LF/xqe+B/j1QbGuCRqRmQaApo4T6GfC14J12iPVwBgzhTGEV1FXUG7JNPoYI3nzt5dkhwMc66GH6m40iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iljQTPsE5WJZe92jAidXXv1o3B05Esa6pJtd0PduwjY=;
 b=kTNP4GRjJ5qD11x5vgFt2gMVSKFMDnWVrRgmt5nj6OW/35rJ5Fj/C4UXJ8tjKi5i5uFLwvfkwmERXkhvQlNYrISW4Tx0YYCXwMf346Z1oiQy3xHxJQcN7FkIdy7UUND8dr2F68xiUqTtnM5zFzFKnk6xZ0OJ2W2JWNlEDtN4fRvyB4OpG5hYOw1Jvm2Yi/n2mbFMDOceSAMrAjIBYtVLBKmFFzKmaMdy0+/AHAACsFZZFn69+R7619910mMRMXm5J7Mp7C5nOvTeWUvzR8Y/n5C44V3Hh626d72tmKVEtsM3FXuSZPchn5aff1okI1lq2bi4vl94WnetcQ6IOh0l1Q==
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by VI0P195MB2624.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:10:27 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%6]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 13:10:26 +0000
From: Daniel Schultz <D.Schultz@phytec.de>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] remoteproc: k3-r5: Add support for R5F cores on AM64x
 SoCs
Thread-Topic: [PATCH 2/4] remoteproc: k3-r5: Add support for R5F cores on
 AM64x SoCs
Thread-Index: AQHbbTNX+/QuEfJgBU6CZFDikeR9LbMtw+qA
Date: Wed, 29 Jan 2025 13:10:26 +0000
Message-ID: <f3a68bb0-f44f-433a-ae77-5c6066e7ca11@phytec.de>
References: <20250123010759.810799-1-jm@ti.com>
 <20250123010759.810799-3-jm@ti.com>
In-Reply-To: <20250123010759.810799-3-jm@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P195MB2484:EE_|VI0P195MB2624:EE_
x-ms-office365-filtering-correlation-id: d96020b1-48bd-4e4d-fa38-08dd40664c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T0NZWFVJVnh1YlpnRzhjYWMvcThMbW5lUjRtaWNEQjUwRWx1bnBtK2JOZi9S?=
 =?utf-8?B?T0k2YVBET3ZzeldONXRMazBrZS9qbkIyeG5taVUrbExSY1Z6SnJSOG5FaTdk?=
 =?utf-8?B?Mnd6T21NTDZqaVVPc2w3VGxQVU1RVEZzdUxqM3hSN0lUUkl2SkkvTTR4UFRR?=
 =?utf-8?B?ZDA1anFraVozWlQrcWViakJvRFZJWlpCRFdjd3crQTcySEVQYlR0akFZQlpt?=
 =?utf-8?B?eFc1U3dZbmI2YVVMZjFPUXRaQlIxbHBEbHdNOEU4MkQxYnl5K0huK0ZPRnho?=
 =?utf-8?B?eUdRR1lzNEVmQjI0MkorVXIzVkgzazlNRHhaandZOWNTTmlFQkJ4RG5Ic2do?=
 =?utf-8?B?aXZqTVpaL0NGWTV1cHV5Ymh0OE90ZzJrbHpGNFQ3Q21KMXQwKzcvOVJqdTNQ?=
 =?utf-8?B?UExBMC9uTEozcVBGdXNZVXhLdVVrSVRxakE0N0JIamg1ZHVuWGQ4YnlqNmJP?=
 =?utf-8?B?UFc5emV6SWxSdFFDK21jemJQMGRYNU9rMzBYRkRLNUVKMld1eDBOZllWY3Yr?=
 =?utf-8?B?Zm9mbVdldmdOMGFSSnVPOHJxS0VhMkFoM3R1MUJBeTFFQVBWNFhZRm4yWG9q?=
 =?utf-8?B?dFhhWGJDeUtEU1dORlliaHpmSWZlSDRRZkhGODZBUTA2MUpxdk1Db2RydDJs?=
 =?utf-8?B?QkRDa1hGVTBicVVnVU5UQ2pTbHJReEhIeDRNd2NVdlFzNndZTnZBYXZMTHdt?=
 =?utf-8?B?OEV4UFVQcCs4YXhmVXlFM05DYkxLR01qeHlycmdCa0xKWGNNa2pnQk5BVHda?=
 =?utf-8?B?ckpVUDBxUGM5QVI4RWo0ZERBQjFhSzE3R0lPSE5vZFhwRXhTcEJGMUF4dHJE?=
 =?utf-8?B?Vm9VaWRzM2g3VHpDRnk2WlpZUXhnTHdERlJvV2hOL2xud1JCR0Z3aTJYZjB4?=
 =?utf-8?B?c2ExS0JkQ2pSKzZLek9lYkdyR3B4endac0R0czVyanFwZkR3dmtGMkpUUklJ?=
 =?utf-8?B?U1ZTSnJCKzJOVGROd2RXaDdxOVVuN2lxd2lUUUp0VnVzY2MzTUNNOHhFeG5I?=
 =?utf-8?B?b3hKbXd4aWMra0ZBamhsbXNiU3VxZ1dsTE5ObmF6OEZaSEtFdWg0OVRobHpk?=
 =?utf-8?B?SHhXR1hqNWlYcHBPUDVoSFJDajRkaXBKMUtEUHFJMzVxUmpxQTFqRVdGZzJQ?=
 =?utf-8?B?NlRIOEgrNVR5OEhkaE5adzhpL1JOWWI5ZWNCTUV3eW9rdjZWV0xYYk5jVVVL?=
 =?utf-8?B?aFNqWnBoODgzRGFaZ3VyVjdoYkYwSTBTMXhsbDRXYzVkaEhJdjQ0SEJxQTJQ?=
 =?utf-8?B?ZmlXRnFYVTVQZ0hRZDQ5ZFd1b0dVRDVYd0VDemtHcDA3ZDZMbDhzb3k0N1Bj?=
 =?utf-8?B?SWhrYTBMKy9lelpud0V0MkJIdWxsbmZVSkk5djVYa3dab05KMGNkY1FNOENi?=
 =?utf-8?B?NDVHb3drU09LNjFrVkR6VWVERzZzVjFUU0I2K2lHZHFqYzBDbS9TTmNyeUhI?=
 =?utf-8?B?OHNPa3RvSWZEd2dYQ1NSOEhUSG1sbUMyS1Mwa2R1Qjh1RVV0UU5sQjJMM3h0?=
 =?utf-8?B?WHlLcXduYXBnYm4vTWJzWGdXN2RBZnlPWlhwQncvZHB6YXhHVWZCSjkvb0dw?=
 =?utf-8?B?Slp2U0tKbDVJa2ZkdkpsSyt5Tll5bWZnRW5JeThDSUhhdE40V0NLNWdUT0pk?=
 =?utf-8?B?NDdHK3A0aFE0WFRDY0ZRcjZGanFPTUdKRm9vU0dFdFRBTXFMV2FENTRBbFA4?=
 =?utf-8?B?VmpCeThBbW9sOHU1NHJqT0tBeFdSeUdodmhsUWhLMTlHVm04Wjg4NHkyaHRR?=
 =?utf-8?B?bzB4Vm1IemJZL3hLZ2QyajNkdkpYWmpLdjJUZjBpdSszRmF0ZXpIV0pOTWd0?=
 =?utf-8?B?MTFwOExwajlmWnFFdlc1N2gwUHZNQlUzNThOOC83TXg2djh1ak1xY1JNSDFm?=
 =?utf-8?B?SzhJSE00aEVPZWtNamNQQmJyWW1xSHRtTm9sZEozVlZUZi96YndDZzhpQVFh?=
 =?utf-8?Q?67fPgNJwvY8W13uvoGwJurzBi10OWIre?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2dLWG9qUlZKTFU2ZzhzMUsxWTNTVDA3a1o0QzVQd2xNdWhnYnRuODIwSjE4?=
 =?utf-8?B?VFNWTzZRcVB3TllvUzB3aEEzNnlzTTFEMktaUW15Q0J6ZENwVmJKOFl2Z0V5?=
 =?utf-8?B?Z3hmT2p3aTNxem9tODQrM214MHZ1eVp0OGEzdyt5TXhpK29mZnlneWlBZXpo?=
 =?utf-8?B?YnBBTEpIdUMwM05UblU5NHc1L29zNjdnQWxrSng2K2I0T1pyL1ppOHQrWVE1?=
 =?utf-8?B?aGlneTNJVmMranFjSFBkUHhERzZlUVIxRUF6UmN3ZklhcW5XdDZWUVkxbklE?=
 =?utf-8?B?R093M3FObDM3SEwyb2FWbERIQkJtSkpQQlcvekRyMENKZHB6Z3VIWkpRT1R5?=
 =?utf-8?B?TmdTcHV0dmloeDd2ME9naDNUUHNHSGVnWkdBM3R1OUFwRStEb1g2clF3TkRV?=
 =?utf-8?B?c1lVYS93VE1oaE5iNmRRSFphQWlRVVI5QTVvMlBTVkhhL1JNRHZqK04xRlRB?=
 =?utf-8?B?V3lVQkpGT2dUMmdzVWlnaVlkOXdIVXUzbEJ3QzhMOVJ3MC9sT3Q2MDlTNVkw?=
 =?utf-8?B?RWlFRGNDODc5d3dLa1J4U051b3k5SHJiVSt1UlZVbnRMQ2QrNjhJd2NYY3FC?=
 =?utf-8?B?eS9zL1lOdWwrY2F4VWNmSWczT1laTWdvRm5BcVdrdmR3WnphVVM2aTY2cEFi?=
 =?utf-8?B?UDBVY01MWi9DaXVIR2hUYnY3Rm9DQUhtTUZYekFOOG1MQ0srdXIyNzRTcXpq?=
 =?utf-8?B?QTlnOE1zTXFraUJpNU5FZU1FZ1lLL1R2aWhtbFI1Rm9heWVzUExLOUo5S0ts?=
 =?utf-8?B?U3RPK3VrRWdMWDZQcEs3ckgzelp4MytJZ1V6UkZjZDcrRXFvVkg5NnpXUWN1?=
 =?utf-8?B?VzJFa2FScUpKeDhPajMxNFl0NnpZTXBGWU8xeVJCTjhUL3BuOTdPRVIyRVdT?=
 =?utf-8?B?WTQvSHNqWGxJcDJNQ2xGdnpzQTB2MHYrTnJEQzNXWjRyVFpwNGVXSnR1c3JV?=
 =?utf-8?B?ZG5FbExFL1lPTUF6bkk0WjZCRXRTUk5XT3RxN3ZTQ2FCeVFCNkc2RjR5UWlX?=
 =?utf-8?B?T29VSE44dFowTDYrc3VsUGxkSENWQ0dXdSthMDFQd0RWZXMxNExsZGlwRFk1?=
 =?utf-8?B?TFByb0RHRmZ1NEdLbjFXSjg4TldEaENCRnlCcHJidC9PVW9xTGh0WFU0QTN3?=
 =?utf-8?B?VFJFOElibGptekpabTF6bHRIR3hiYUxlUXlEVmlxNkh6VzdPZ2ExcGlxMnM2?=
 =?utf-8?B?V21iSll2ek9vcXRraU12Y1F1TXZBYmxiUEJ0MVd2S3h1bDVDSG56V3dQWVpz?=
 =?utf-8?B?eCtEeVZhaEpTNW5IenRXRHdKNkE3TUs0QnErR01YVzJKckxvSmhqRWRSMFIz?=
 =?utf-8?B?WXl4dzFTbU1Fcm05cU80U0s0WHQ2RDhENUFRbG1FWFdWUERhSUJzM0NVZEds?=
 =?utf-8?B?dzRmRmdTU1l5NHRWNFJabi9hVjBCQmpBSUVTQ29PeDMvRTdSK0FJVUlKTVZ3?=
 =?utf-8?B?SXcyY1pCTlB0S3ZxMWFyL0E3b3BSZTZmcFI3d2NqTDJVRmkvZEl1anJlNGVO?=
 =?utf-8?B?U1dyL0t3cDl0ZzRFN2NCSytWVkpFK3J1amtaRldabjR2aTI4SkszVVl1c1ZQ?=
 =?utf-8?B?TGY1YnA1QnhldE9mNHpuZXl4WXRpS3FWenZYdk9wOGNFSWJqUUozNVJGVmEw?=
 =?utf-8?B?V3ZqSlpLMGF6RjVmQjFUcThERlUyWW5hTzNrNEx2cjNWS0F3OE04eDdMNzFY?=
 =?utf-8?B?NjJsZW9Sc0Y0aWluT2hub2Ftd1ltak5zYXlvZ0RhMUJYMHI4d2ZjSDA2ZUZG?=
 =?utf-8?B?YkFsbjA4aWZ0bDQ4MUVjakVjTmtTc2FxSEFjVEE2UEVBR21ha2NQdEJveGgv?=
 =?utf-8?B?Y2JQRE1VUmNILytaWXltQUYwNEl6V3lhS3pVamQzRnhkMnFjU0Ryb0doQm4w?=
 =?utf-8?B?Uksvc1ZuYWErWXY5RXpHazdxOFZFdXdUaHEwUDBHT24yem50Vmswa3drNVBR?=
 =?utf-8?B?b0NWaUl5WmFpUThoUVJTb0svOTFxcmp6Q1JYUHdXQ1R1cWN1U2dXWDRCcXpI?=
 =?utf-8?B?SWZ5bUR0N1VrU21FR3RrcVB6K2QwVWY2RWZUbkc5YW5WV2Vpa0NJMHRyN21L?=
 =?utf-8?B?OXIwbkNDOU96QTFxN2lGR0g0Ym0vK0FFSzVKUUIyYkRvb3ZqbHB0VlhUZjlp?=
 =?utf-8?B?WWZCTWZXL0xweUIvZ3F4dGZxNzB3UWNkbkZvV3lSeS91YzZ2dlFkUS9YUmE3?=
 =?utf-8?Q?EE6SzOog5ldl26I2kX3Ba00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D28281F7E1181A44BB3B45257F9419B5@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d96020b1-48bd-4e4d-fa38-08dd40664c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 13:10:26.7705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPPu1YpOz2Xv+kJczbg6Sanegdl5bugFXNA/n4PKNvbe40Na4Eq/I7sQKqzRRMyZgt3n+lA6c2NSE7rWJfSluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2624
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

DQpPbiAyMy4wMS4yNSAwMjowNywgSnVkaXRoIE1lbmRleiB3cm90ZToNCj4gRnJvbTogSGFyaSBO
YWdhbGxhIDxobmFnYWxsYUB0aS5jb20+DQo+DQo+IEFNNjR4IFNvQ3MgaGF2ZSB0d28gUjVGIGNs
dXN0ZXJzIGluIHRoZSBtYWluIHBvd2VyIGRvbWFpbi4NCj4gRXh0ZW5kIHN1cHBvcnQgZm9yIFI1
RiByZW1vdGUgcHJvYyBkcml2ZXIgb24gQU02NHggd2l0aCBjb21wYXRpYmxlDQo+IHN0cmluZ3Mu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhcmkgTmFnYWxsYSA8aG5hZ2FsbGFAdGkuY29tPg0KUmV2
aWV3ZWQtYnk6IERhbmllbCBTY2h1bHR6IDxkLnNjaHVsdHpAcGh5dGVjLmRlPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL3JlbW90ZXByb2MvdGlfazNfcjVmX3Jwcm9jLmMgfCAyICsrDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1v
dGVwcm9jL3RpX2szX3I1Zl9ycHJvYy5jIGIvZHJpdmVycy9yZW1vdGVwcm9jL3RpX2szX3I1Zl9y
cHJvYy5jDQo+IGluZGV4IGQ3OGIzZmExYmJkLi41NzI2OGU3ZjhmZiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9yZW1vdGVwcm9jL3RpX2szX3I1Zl9ycHJvYy5jDQo+ICsrKyBiL2RyaXZlcnMvcmVt
b3RlcHJvYy90aV9rM19yNWZfcnByb2MuYw0KPiBAQCAtODg2LDYgKzg4Niw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdWRldmljZV9pZCBrM19yNWZfcnByb2NfaWRzW10gPSB7DQo+ICAgCXsgLmNv
bXBhdGlibGUgPSAidGksajcyMDAtcjVmIiwgLmRhdGEgPSAodWxvbmcpJmo3MjAwX2o3MjFzMl9k
YXRhLCB9LA0KPiAgIAl7IC5jb21wYXRpYmxlID0gInRpLGo3MjFzMi1yNWYiLCAuZGF0YSA9ICh1
bG9uZykmajcyMDBfajcyMXMyX2RhdGEsIH0sDQo+ICAgCXsgLmNvbXBhdGlibGUgPSAidGksYW02
Mi1yNWYiLCAuZGF0YSA9ICh1bG9uZykmYW02Ml9kYXRhLCB9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAidGksYW02NC1yNWYiLCAuZGF0YSA9ICh1bG9uZykmajcyMDBfajcyMXMyX2RhdGEsIH0sDQo+
ICAgCXt9DQo+ICAgfTsNCj4gICANCj4gQEAgLTkzMCw2ICs5MzEsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHVkZXZpY2VfaWQgazNfcjVmc3NfaWRzW10gPSB7DQo+ICAgCXsgLmNvbXBhdGlibGUg
PSAidGksajcyMDAtcjVmc3MifSwNCj4gICAJeyAuY29tcGF0aWJsZSA9ICJ0aSxqNzIxczItcjVm
c3MifSwNCj4gICAJeyAuY29tcGF0aWJsZSA9ICJ0aSxhbTYyLXI1ZnNzIn0sDQo+ICsJeyAuY29t
cGF0aWJsZSA9ICJ0aSxhbTY0LXI1ZnNzIn0sDQo+ICAgCXt9DQo+ICAgfTsNCj4gICANCg==
