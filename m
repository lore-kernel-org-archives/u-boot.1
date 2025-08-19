Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A1ACA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3985882AC4;
	Tue, 19 Aug 2025 09:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CvHsKRzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5935F80422; Tue, 19 Aug 2025 07:55:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6868E8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdm66gwjXC7RqIrfc1KAfPnkzbitLAhOd7due4oIbq3mmNoBAYbrjU9gUJ6EpbsGXFRbhh/zEQRjvbeWRb7lubgacaMq3liMeywybMby67VuqK9CAU+HWz7b+9h34/JnQ6AhNjlgOve3ElBIScewbXNDJ/YM2qDdzJpzaDi1LMys+Q/uLzvDfUaoyofsci2q9w6NQG85Ukj2Vnot9ypdCsKHzMEb6Q4JUNKryTbWTxp1kloPsxAGLf+hLpZ2np6eSDPgEDXXLPOb9Azf11XV5+3uIj1/QpXnTQ4+QId4w4QYOhCDd1XE3DT30Ij+B7pN7bNlzQDMT2OdackP6O9aiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATTBhHN5XSby7XX3e1H0KvYuaJuIPcAQ2BOT4i96eak=;
 b=pRrdGJxG/Iyz+fbRk02xCEejRB+HFNw9JWxnPPfS32dwJ9yi1AKIHyz8Jc+AnTTE9yS42nh5RNFpklsMBKlEY01OEV5b5vvbWsbwk2gntOtvEpUKeiBYhwBL8AlHwPLNIIoTUpv6Vjv8yWfXEUVp6nAZhI0M0+8kFN+lFYCzuctyZUqNPz2NUfhLKrHXbbh2LQLSY3rKDlIC53Dkags08aI6UuX6aBL6MsRyNk2416UxZNq9fUumsVl6SMouAPB1TkC+TQDHAGEoxPJ21Zu/lfmOTN9w7Tq5HuPvceWzrJgoPDI30JseNXJpN5eQAu8dzxgqy1XszUpSW70LVpCmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATTBhHN5XSby7XX3e1H0KvYuaJuIPcAQ2BOT4i96eak=;
 b=CvHsKRzO1WMVP7VtKw+JYaFwsTmpFTdSiPUYLbu9fc4U6GRpf6E1MDikZiQsETgxGthWTOdw3HQbV2J8a9u1+ezLX5UWkqFM8J2YNkCJdXXy01LNT8tSf+S6wfXHPvj60tefmGCEWBlDLUbIRzwTch/p9yZ7di/ATsXXuxFghBCr9a6xl/74qTYyxFFNWk9xjQHAYiGQhPnUyKADJl/MjfJfbuzQVgr8K4AE2nT6CXqKxbM/zDdoblpOweLo4SFuKnbzAHBYXCo49IZA/4+QBqOQiyse+ZEK7LZFmaXZ6PwZHkTyqUEkf9wdL8bzKh9TpmyFWLIZgJ9b33Gl3JH0jg==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SN7PR03MB7205.namprd03.prod.outlook.com (2603:10b6:806:2ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 05:55:27 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 05:55:27 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: RE: [PATCH] mtd: nand: cadence: Fix device assignment to avoid warm
 reset issue
Thread-Topic: [PATCH] mtd: nand: cadence: Fix device assignment to avoid warm
 reset issue
Thread-Index: AQHcEMk+PQLwwDOnrE2J4hyrlOEqAbRpc1QAgAAGlJA=
Date: Tue, 19 Aug 2025 05:55:27 +0000
Message-ID: <PH7PR03MB69426C29E1A21BA340B39E04F730A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250819052204.2628-1-dinesh.maniyam@altera.com>
 <CAOf5uwmrQEUXNcVJWi0VkfLMLN-jfxu007MN4cHhnQwqkE0x0Q@mail.gmail.com>
In-Reply-To: <CAOf5uwmrQEUXNcVJWi0VkfLMLN-jfxu007MN4cHhnQwqkE0x0Q@mail.gmail.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SN7PR03MB7205:EE_
x-ms-office365-filtering-correlation-id: edbc50ab-6860-4b5b-df57-08dddee4ff6d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?NmQrWDdkMm5uQ0ZBQWkwZXF0emZ6Wm1tWDlUZ2JtSzB3b2w1K1NvZHpySG1B?=
 =?utf-8?B?cEM2L0VVOUFqcmRiVjBLdEZyYWl5enRrdmpJN201VkluTWw3V0hiZWNvL0Q4?=
 =?utf-8?B?ZC9mMXZjQ2g3WTBQVzRHak9SM2F4anNjOEl1YVFDb3ltZ08vM1ZibEZSRGgw?=
 =?utf-8?B?SEFnNUF0cmhUVFdxUTMxRTNuWW1zWFhBMk14Y2dhWWdQdDVMK0s0c2pMbEVs?=
 =?utf-8?B?ZW40Mld2N3BsQWNhTkIwWGw1TGs5UStSUTFZdldNanlEUkpSaDdMallVeWQz?=
 =?utf-8?B?YVY5NkxvU1ZKUy9MeFRpTUsrWG9yRjhVNDNCMjBzUXFLYUllelBaY3hNbXUz?=
 =?utf-8?B?bFpVNmZaOFUwYzU0bXRrV3gxSmlyWkNCV2ZTeG0xbTVrSmM4QVBQWElFQ21a?=
 =?utf-8?B?eGxmNUJiTytPSUt2Ujd4R28zSmtMeTZHcnY1Mk54VkRUNVdFVllvbjNNYmds?=
 =?utf-8?B?aU5WbEFoQ1BaMVhGUjUzN1pkN2V0cVN6Q2V6c2E4YzhmMXNTTFJndWtseUdj?=
 =?utf-8?B?M2VUYmNYSTdsREphYTVQdDZMcXE4VkJwWkJzeVplL1JvUUcyTlRacDd6V2ta?=
 =?utf-8?B?WDJhK29PL1AzV2QwbTNxMkJRaXdRM2haM001Z3hVRGlEa1BuQ2lXdlozRTJO?=
 =?utf-8?B?K3g0WXN3eTZkbm9mOG8wTmJzdDNHYkhXYmdFd3NseURjN1plZUp2K0pCNUJ1?=
 =?utf-8?B?ZDBGUUVhSWZXZngrYUo0S0ZrU1IxVjhZdnJWc0ljRWEzWFV4SnBYNTcwTjIr?=
 =?utf-8?B?a0dXdjQrN0R5U2RLb2k0YmhGYlp3NkNBeURsRUF6VkptSDlkMmFWdW1IdDRn?=
 =?utf-8?B?eVExdG5IYUhnUWNCN1NLWjFYcGdNeDNtWE1FbGh2MVJNOTNDWnFpU3JKY2kr?=
 =?utf-8?B?ZVFKUFQ3aXNYM1lZWWhSWm0yLzIzdDNkQUlBZm1DOGk3WmJBUmU3ZzcrSFRq?=
 =?utf-8?B?ZDJmV2wvajBqbjV2Y1JDSGVmajR6b1VyaW9XbU5LZGJ2MUZtbTg2VzFoOVZ6?=
 =?utf-8?B?Y2w0SG1YcXdGYlpHR0VPZTk2azVmQ3hFMjgxSlJ4VW91czB1TE42WkJIQytL?=
 =?utf-8?B?NTd6L0ZyWUptS1VmVDVEajJDc2Q3L1NlS2owbnZmM0QzSE1zWS9rSFpOblVK?=
 =?utf-8?B?K1hadkFVSi95OEx0UHg4MnI4c0I3cFptdHZCejNWWmd6WHlHWVJERkxmcmc3?=
 =?utf-8?B?U1pFQytvY3h1Vkoyd1VUOGNJS01DM1d6YjVhenpsd2FLa1ptL3doeklCWmhD?=
 =?utf-8?B?dHo1Mnc0U1dHSDE2S3VWMmVpUnpNNzlpODE4LzdqVlB6d3VRcGNLQ2NZQVhV?=
 =?utf-8?B?dlB3ZE9yZzFOS2VUSThGQ0VLaWxweDI3Y3puREt2MTRhY2xtUk9WQythU3A3?=
 =?utf-8?B?UU11ZW42bmgyZjBheEZveXpsNmI0K0ExY0V6Q1p3QTk3dzJVdzFxRXpaZWow?=
 =?utf-8?B?RG5MNlZUUngyYXJLeEFsVXpNYWkxVVFTSUZkUE91VzRlWDNqejcxa2xBMHN6?=
 =?utf-8?B?elhlWXZhTTg4SmZFNzdvemVVZUFBSnMwdlJkMmZoVG9TZ0s3SHJzeStudFgx?=
 =?utf-8?B?TVR3WE81SmNDcEtlMlVrTmdVZ2hyZ0wyV0U1R01SdXliYmZvT3F1ZUF4cjhN?=
 =?utf-8?B?WDlIcUl5Y281UlcrMCs4ZC8rd01LRklFM1JTWjdYMVJsRitaLzk4TTVPUVd0?=
 =?utf-8?B?YjZLcHR0S3BVODl3ZGZSckpKNERvZnNNOTI3KzllM0VpdERXbFNWNDMwYWFj?=
 =?utf-8?B?VVlUc3BraCsxQjUzdjNFcE1HT0hEMHVvZ1VhblJNNEVoMmtydWl3SEw2WTRO?=
 =?utf-8?B?eDhHQnVFU1ZQNUd4VmlnVjQ5VTNJOEZ5dUU2U0Jia0I3SlcvVHVaSHF6WGZy?=
 =?utf-8?B?am15aGRzMjhGUWJCajdOeVY1aDFXdElOZ1ZkZTlaTmhoTi91V3lqNFB0M1pu?=
 =?utf-8?B?c241UWlLeEhGWERHR0xzRzhVR1BwNVRPZWNCcVUxeHVjVEQ0bDJrUnRhWHcw?=
 =?utf-8?Q?OYWwzwu9YAspJ6aWGH6JnEL3y/aKHQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXp4KzJUcGhqUWZPZldoRzdRc3R4d29Lc3ZtZmdZQnVYd0x4anljSnRoS20r?=
 =?utf-8?B?N1RqMDhvRzc2RE9rU2tVeTYybldTWStDSngvSFZEY05rejZaOVlTZ1FiZ05o?=
 =?utf-8?B?MlFkc3lJS0FYTWlrbGtuemRtK05vanVnbnMzM0djeUFlc2lPYTdON01KVVNQ?=
 =?utf-8?B?bytBK3FjUjkycDF1WUgwTTZ3TG1MK2U3bGd4YmM0b2ZORW5GWENZdWdpVnBy?=
 =?utf-8?B?djZ0VlZ0QnRnMDkrYUVZbHZKaEdkT3NpT3IweEljT1NrWWNxanhjV0hyends?=
 =?utf-8?B?N2hFYllDaEdUN0FQYXlqRjRldXJtdTArVjNRRXg2c3JYNjBTOERnV0xBTVh0?=
 =?utf-8?B?czNrNXU0cU01QWt5OEhrUG9xaFNoTlEyREJNQS9kdDlqRngydytONjdmNk9R?=
 =?utf-8?B?M05wczdaOWpJbEMvWCtuTFIzTU9nekNFV2pyZlpkcUtQdDk0WFR5aXFqUU9h?=
 =?utf-8?B?eUsyUzk3ME5LQzZKSjNXbDEwS0JyM0FQcE95azFoYmkxMlU3cGlETldBQ2JM?=
 =?utf-8?B?akVwSTNObWNyd2tmRDVHTG9tbERReFBJbE9wK29ySjBpQWwzYjk3LzZwa05S?=
 =?utf-8?B?MzZpdXAzc3dIK0tjVmMvOGNLdTZ3blZJcjBFem1IbWF3QTlWc2haenhoTnlF?=
 =?utf-8?B?bEpGN3d6RXRRZHNoUlJrb01uTTFIc1pvZEdPdGNLMS9DclIwSVpxL0dUdlQ2?=
 =?utf-8?B?YmgyS0ZpNGNJZTBka1IyUGJYZHJnanBiOUVvekJ4NDJ1QllHK29xRTROM0Nz?=
 =?utf-8?B?RWNtbXdkR2EzOEM2UmhWdWh5bzBycXY2ZFJVR3BFRml4NXFURzUvdUdSZnJk?=
 =?utf-8?B?S3pvZFZUWVZydzZKaDJkenQwZ25ZcXh0Z3lxSkFuRklSbkQvK0RGZ1JHZkt2?=
 =?utf-8?B?UXk5ejZoNWQ0dXNldU00dDBUQk9Ed1RyY0NsOTkvWUxyT2s5QURTQy83dDd1?=
 =?utf-8?B?ejd4U0FNem0rVUVac2RyVW56NGlqbnlQbVJkT1VneGNKS0hMWjYwVEFMN3lF?=
 =?utf-8?B?c201UEFLMWxXNHJrVVJCdUp0b3ZwZ0MyQzQ4M3JJWUVlU1BMMUZBdFBOUFpt?=
 =?utf-8?B?MlFGSmNGbzg0cXdwNVhFemdxK25uZEdnRkZIWXBJV1RaaVdHb0QvU2RsaUJN?=
 =?utf-8?B?NjJicEF6U2JNKzJxMkcyeVRwazBGblNIWk1VWUJ1VFg2V0didGpNc2tEY2NP?=
 =?utf-8?B?bVpXNmp1ckFONFV2VEJCN29rS2U0em1UYWN1Ykk3VkFUVkFqbmR5ODlHcC9z?=
 =?utf-8?B?SUNha1JHZ0tWalRQTWpkVVhWRFM5TElydVBqWmhVMzAyZXZRWk8xUERpYm9L?=
 =?utf-8?B?bk9DaytkUnV5WGJyS1duQ1piTWNWOE0yMHpINW93RmxNb1RYdXBFbjg0SGU1?=
 =?utf-8?B?dDNOQWNrRjREWEZWNEd0SnBhdWZsUkFhNDA3ZlhWeWdPbnYxeFRGMGduWUpH?=
 =?utf-8?B?QUkxSmkyYVl1bUhDV2dGSU9xcjYzY3V4ZFhwQ2xpYnkzMExkK2I2TmJ1amN4?=
 =?utf-8?B?dlNtck5KQVRkMnpuMTVDV3J3emp1YkRhM2VtRXprbDJiTVFSU0ZJNFZ2SWVB?=
 =?utf-8?B?TTU5T1BzMElKZThhSzRiY2hXM0wrRzcveTJGSXhDV1JqQTJSZ0VTZmV3Vito?=
 =?utf-8?B?ZHJ4S3JybUdVQUlHM0t6THlIVVR3SXE1UGNCMnh5YjBTOXc1ZFZSem81M09N?=
 =?utf-8?B?b0VEOGhBaG9iMFRqY1NiNk5TTnk5T1dCMzFCdjhNR2kwT1pVQWFPUUFKQk1Q?=
 =?utf-8?B?Qkw1cGxRV09BWWIxNTUzenZWc0srYjFSUnYyamZoSVFUazlvTEpPTkk3WERK?=
 =?utf-8?B?T0t0bUpyUWVvSXVpZC9yL3NKQllXWEhaRFp3YXNZNEhnSk1DQXl6Zng1VEdj?=
 =?utf-8?B?eVhyOWk5aXpzM1ZNaXBTK2FsTFE4aDJsT0Y1NjREQmY4VEVuSmJNdGRjaXo0?=
 =?utf-8?B?akFPNlhleWJvci9RU0dXQkxoT1JDUmR5d3dZQVdEWnJZOUNUa1dqUFdUYk0y?=
 =?utf-8?B?dXovUEIrUDRmb2RDRU8vZDAzOHZ2LzN6OTBBNWpqeFY2RFVvejh4Q3prbTUx?=
 =?utf-8?B?cGtIWklCa2NoLzl0cTdadnNLY1VxRmZZdHNsM1YybWJFSHg2OC9rNUkyVDJF?=
 =?utf-8?Q?LgZIn5o8LhPw5ktbnaL6sQj63?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbc50ab-6860-4b5b-df57-08dddee4ff6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 05:55:27.5413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H53sO9BjuCDtcd9VvLmnJgip0dBzvBetpqptu20+RToTh0DmxaMk1ZEF6CsZwUK1VMPhZLsVD6qvSf05ilGDfCBhyry7nIJ6rkb39tc9hjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7205
X-Mailman-Approved-At: Tue, 19 Aug 2025 09:16:29 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

DQoNCkZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29s
dXRpb25zLmNvbT4NClNlbnQ6IFR1ZXNkYXksIDE5IEF1Z3VzdCAyMDI1IDE6MzEgcG0NClRvOiBN
YW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQpDYzogVS1Cb290LURl
bnggPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgTWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiA8
c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFNpbW9uIEdsYXNzIDxzamdAY2hyb21p
dW0ub3JnPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IERhcmlvIEJpbmFjY2hpIDxk
YXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT47IENoZWUsIFRpZW4gRm9uZyA8dGll
bi5mb25nLmNoZWVAYWx0ZXJhLmNvbT47IEhlYSwgS29rIEtpYW5nIDxrb2sua2lhbmcuaGVhQGFs
dGVyYS5jb20+OyBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAYWx0ZXJhLmNvbT47IFl1c2xh
aW1pLCBBbGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNvbT47IExpbSwg
Sml0IExvb24gPGppdC5sb29uLmxpbUBhbHRlcmEuY29tPjsgRGluZXNoIE1hbml5YW0gPGRpbmVz
aC5tYW5peWFtQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG10ZDogbmFuZDogY2Fk
ZW5jZTogRml4IGRldmljZSBhc3NpZ25tZW50IHRvIGF2b2lkIHdhcm0gcmVzZXQgaXNzdWUNCg0K
DQpbQ0FVVElPTjogVGhpcyBlbWFpbCBpcyBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24u
IFVubGVzcyB5b3UgdHJ1c3QgdGhlIHNlbmRlciwgZG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgZnJhdWR1bGVudCBlbWFpbCBhdHRlbXB0aW5n
IHRvIHN0ZWFsIHlvdXIgaW5mb3JtYXRpb24gYW5kL29yIGNvbXByb21pc2UgeW91ciBjb21wdXRl
ci5dDQpIaQ0KDQpJbCBtYXIgMTkgYWdvIDIwMjUsIDA3OjIyIDxkaW5lc2gubWFuaXlhbUBhbHRl
cmEuY29tPG1haWx0bzpkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPj4gaGEgc2NyaXR0bzoNCkZy
b206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb208bWFpbHRvOmRpbmVz
aC5tYW5peWFtQGludGVsLmNvbT4+DQoNClRoZSBkcml2ZXIgY3VycmVudGx5IGRvZXM6DQogICAg
bXRkLT5kZXYtPnBhcmVudCA9IGNhZGVuY2UtPmRldjsNCg0KVGhpcyB3b3JrcyBpbiBMaW51eCBi
ZWNhdXNlIGBzdHJ1Y3QgbXRkX2luZm9gIGVtYmVkcyBhIGBzdHJ1Y3QgZGV2aWNlYCwNCnNvIGBt
dGQtPmRldmAgaXMgYWx3YXlzIHZhbGlkIGFuZCBpdHMgYC5wYXJlbnRgIGNhbiBiZSBzZXQuDQoN
CkluIFUtQm9vdCwgaG93ZXZlciwgYG10ZC0+ZGV2YCBpcyBvbmx5IGEgcG9pbnRlciB0byBhIGBz
dHJ1Y3QgdWRldmljZWAuDQpEZXJlZmVyZW5jaW5nIGl0IGJlZm9yZSBhc3NpZ25tZW50IGlzIGlu
dmFsaWQsIHdoaWNoIGJyZWFrcyB0aGUgZGV2aWNlDQpoaWVyYXJjaHkuIEFzIGEgcmVzdWx0LCBj
b25zdW1lcnMgcmVseWluZyBvbiBgbXRkLT5kZXZgIChlLmcuIHBhcnRpdGlvbg0KcGFyc2VyLCBy
ZXNldCBhbmQgcmUtaW5pdCBwYXRocykgb3BlcmF0ZSBvbiBhIGRhbmdsaW5nIHBvaW50ZXIuIFRo
aXMNCmxlYWRzIHRvIGZhaWx1cmVzIGR1cmluZyB3YXJtIHJlc2V0IHdoZW4gdGhlIE5BTkQgZGV2
aWNlIGlzIGFjY2Vzc2VkDQphZ2Fpbi4NCg0KRml4IGJ5IGFzc2lnbmluZyB0aGUgZGV2aWNlIHBv
aW50ZXIgZGlyZWN0bHk6DQogICAgbXRkLT5kZXYgPSBjYWRlbmNlLT5kZXY7DQoNClRoaXMgbWF0
Y2hlcyBVLUJvb3TigJlzIGRldmljZSBtb2RlbCwgcHJlc2VydmVzIGEgdmFsaWQgaGllcmFyY2h5
LCBhbmQNCnJlc29sdmVzIHRoZSB3YXJtIHJlc2V0IGlzc3VlIG9uIENhZGVuY2UgTkFORC4NCg0K
DQpQbGVhc2UgYWRkIGNvbW1pdCB0aGF0IGl0IGZpeGVzDQoNCk1pY2hhZWwNCg0KU3VyZSwgd2ls
bCBzdWJtaXQgbmV3IHdpdGggdGhlIGZpeGVzIHRhZy4NCg0KRGluZXNoDQoNClNpZ25lZC1vZmYt
Ynk6IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb208bWFpbHRvOmRpbmVz
aC5tYW5peWFtQGludGVsLmNvbT4+DQotLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNl
X25hbmQuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5j
IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9uYW5kLmMNCmluZGV4IDI3YWE3Zjk3YTQ1
Li40NzcxNDQwZDFkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2Vf
bmFuZC5jDQorKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX25hbmQuYw0KQEAgLTIx
OTYsNyArMjE5Niw3IEBAIHN0YXRpYyBpbnQgY2FkZW5jZV9uYW5kX2NoaXBfaW5pdChzdHJ1Y3Qg
Y2FkZW5jZV9uYW5kX2luZm8gKmNhZGVuY2UsIG9mbm9kZSBub2RlDQogICAgICAgIGNoaXAtPmNv
bnRyb2xsZXIgPSAmY2FkZW5jZS0+Y29udHJvbGxlcjsNCiAgICAgICAgbmFuZF9zZXRfZmxhc2hf
bm9kZShjaGlwLCBub2RlKTsNCiAgICAgICAgbXRkID0gbmFuZF90b19tdGQoY2hpcCk7DQotICAg
ICAgIG10ZC0+ZGV2LT5wYXJlbnQgPSBjYWRlbmNlLT5kZXY7DQorICAgICAgIG10ZC0+ZGV2ID0g
Y2FkZW5jZS0+ZGV2Ow0KDQogICAgICAgIGNoaXAtPm9wdGlvbnMgfD0gTkFORF9CVVNXSURUSF9B
VVRPOw0KICAgICAgICBjaGlwLT5zZWxlY3RfY2hpcCA9IGNhZGVuY2VfbmFuZF9zZWxlY3RfY2hp
cDsNCi0tDQoyLjM1LjMNCg==
