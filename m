Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B23D2E9FF
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A5688815;
	Mon, 11 Nov 2024 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="owFsaSQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E31988599; Mon, 11 Nov 2024 15:10:52 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0778988815
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F88bRSMeQFNOlnJgHwcUIvJuW8nD6bmt1KU6jw78JsepOaxgWkOuFlkqCLeFb5ktyZF2lypkXR2/aKWETQ+mw6+J16cI6hDMwRo3a4sgle74y8tp7kWxuTwuiSd2fyQqiI/b2Wq3tEweA2KgcsmjNqC4O1P5yx3v/urICcZKEYZw7KYED1rIjFeXN5lpv1k6xZL3FJrd53ETuVREeVflW44ZXDDX9EFJmY9FCw4p27J7CZFEkEFjU9iZM1ewDZ2SKaz5XYq0nx8RUeYeYX5CaucdTUMsbc5nMjaub5i/BmHiq2EZA3BLxktbBrByCEoZl4bvDmmFEUbv4eQ7A/qkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxqzc0oMmWVejzn1+VpHLnTE6pV6QkZlBov8Hcs1OJk=;
 b=jc+EnN2C3hMyFqK0zz19WfUn2xhHb418SqTwU+MUV6jY+yx4nkbDUiOzDuH0lhmg6zLpTLn0fPNIMd60f+1PIYL9oSsbIDACzxECNMsZM7eDjmmcBJMAX/+vYi+tHE339hfT+4YYaJJYbxerxXhwyCTbKfhor54UQHkRaMbUvEqDhHAq4rteQp5JvGYtJrnktgpCj6PVunU8ZrEX2e6t/qHRN7scu7wLGd8VBxbOPUnb97uBWE91V63QbDst9hiE8PjgVvyZUIpvQnaAoYBOik4RHGZwN4oZNgHEs0LK5/LPGzCF5mL/WctskbYz6s5jd8HCbxzSNPPxIv+56bVV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxqzc0oMmWVejzn1+VpHLnTE6pV6QkZlBov8Hcs1OJk=;
 b=owFsaSQKuvRYn3jv7XefkSy7F03P54TTGg3isgkub95/GZS1jqpprRGML0CZZUsZcz6WtjV7oZ5f3fJxAu4EFEgvYmIVwX6MzUL1ufHjWSYNARSPwOyVbhWNRjdVxYW6RUSMn8Ltnnj3VY/PU2j7rnjy8UYdsXhC3tkJ5cElOec=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:10:38 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8137.021; Mon, 11 Nov 2024
 14:10:37 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbMZOpreXw4nsJoEGbYoDvY5EGT7KyAz+AgAAeS8A=
Date: Mon, 11 Nov 2024 14:10:37 +0000
Message-ID: <SA1PR12MB869768EB5D98BA2231B89C3898582@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
 <20241108035959.19970-4-venkatesh.abbarapu@amd.com>
 <33e22746-20fc-4956-a4c9-ef6723af33e0@denx.de>
In-Reply-To: <33e22746-20fc-4956-a4c9-ef6723af33e0@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH8PR12MB7111:EE_
x-ms-office365-filtering-correlation-id: e6b2597c-405f-4dcc-532e-08dd025a9e00
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWlKc2JnSHYreTNMNlZCTmQ0SXd6MnhUY3gzRFZueis2VGhHek9odXNIMDRR?=
 =?utf-8?B?N0R2czNHV01MN2VJWCtxMXJFdUpjUkpaeEU5Rzk4ZmFjZXZ0UzNOQ2pwVk5R?=
 =?utf-8?B?bFd5eWhPVWxScFhCN2REc0ZJNG9TUGYwSEdIY3ZWUCt5Mm1CTkNBRHNRUEFi?=
 =?utf-8?B?ekRnS3NvYnFnd1FqM2IzbTJVSWZoY2NHRWh5enNnTFk3bGVEVVpPY1Vhcm9X?=
 =?utf-8?B?V1BYRHRTaVhSbHZoUFNZbktLWTcxbEJsOXNRY1VZR1VGZC9kUU9vVGZWM3BP?=
 =?utf-8?B?aTJBSU5WdEgxNFJzVkFyNlc2Z0hacFRBbm1QbnVEQ29Jc1A0TDRuNGtnS0JL?=
 =?utf-8?B?SzV5QzlQUlg4UHhmWkJYbVJhNDViSTlQNFB2U3lzaFJwdmdZZlJFNzk2T3lH?=
 =?utf-8?B?TkZ0emxlNG9mK1ZPQ1UzUGlxdk5pOElHN3d0emZINlY4U05RZDlQZTVGL2F6?=
 =?utf-8?B?cXdFRE9jU3pJSE51VWJjWER4ZmIxbTlzVGZCZlcreUYwd1gwckEyalJCbnJa?=
 =?utf-8?B?SEszQ1RQWFVRaitaM0VjWlJ0cVB2QS9QeE5hYWFqaFl3RlJrU0NQREN6emdR?=
 =?utf-8?B?MUpFQXZrcEJBZWJtbkd4blRqMkgwRzNFemxqSHlXWEhTSTdaK0F2SHVNUmdG?=
 =?utf-8?B?TC9jUEpkQUp0Zkk2b1VFOEd5Yi82eDlqbkNzckk3R240enE5UmFDY1FKNmFn?=
 =?utf-8?B?R0lvY0N2bW1EK0tMZ25XRktlWTBOVU9ad3VjbGIveXduOHVwMmxKTEIwWVRX?=
 =?utf-8?B?S3BwczZET2dKUWtSZ2VKT0tTendsMkpVV3RBMXZFS0l1OTd4TmllQytCdmF0?=
 =?utf-8?B?TE9Dak53eW9ldmhxNjNmRGtlYjRRS085cFZoeE0vRmo0UFJHRFNhbDU4a3du?=
 =?utf-8?B?bmlPSmhvbEhvY3QrUG5DSWRJRmpyYXBWZkpOOEFmRCtmek5lNXFjLzZ5MndR?=
 =?utf-8?B?L3laR1lweXZuR2M4RmlKZnZBbmFZQ2dSREd4WnpTRWI3cEg1YThPdWszQTJD?=
 =?utf-8?B?Szk2VTEzYUFKYzdZR2lGWTJvWXhZSmIrZUc2R3dTOVlJOE4yRHl2bGhJQXVM?=
 =?utf-8?B?REEzV08xeEdDWi9mdkN0Vzdob29XeGRTZUVUTHFsRzBGZGlmd25UY3RWdjVi?=
 =?utf-8?B?bGJFVTk5THpzNEN6YUVxQ3drb3lhNFkrdjZlaHpyeWQ1dWsyRXdKYkdHQVBF?=
 =?utf-8?B?YVJPaWlGaWJ0TGZIcnAvdVUvK0dEdjFibWRFcitPMFJQUXVyRHpXVi9QMEs0?=
 =?utf-8?B?ZnJJNWdkaG8rQ2RzTDV5MHNPMXFtQnJJenlLNTIyeEJLSVYyQXpiR2luVFA1?=
 =?utf-8?B?MmJHQ2t2YjZERlJTb1Q4RnNqZWdoQXQrdFk2WnRCdEpuSkVLTC9zQmZOZUxM?=
 =?utf-8?B?Q2duQUFYWTgvSEVxUldZekFLZ0gxSlpKWitlMTRLaTlPcUJFQXJPR2pheGYw?=
 =?utf-8?B?MGhUU0tpckdRbWFGc2hUSVhIMTlZblFGZ2RqV09tN1lYejdCL2s5NG80bzRV?=
 =?utf-8?B?NVFJL1dXNXZ2bVNuTSt5U3Qrd1hKWW1pbDh4NUFTWU5lMGJ2L0Q4dzM5aWpQ?=
 =?utf-8?B?bXZBaVhhRWJPdnVvcGJCVS9CaDd6SC9nZFFwbFRMSzFqWnRMVm5jNHAxWnFv?=
 =?utf-8?B?RjBHNlZtMjU2cEV5VlpEQXpmTldMalZTL2tKRDBuT0lXQTVabkp3cGlhK3Zy?=
 =?utf-8?B?d2pWM1RoRHZXSDhDYUd3SnhBWHBDZmIyTW1UNkhSWFJEWm5ZYkJBcGVURVNR?=
 =?utf-8?B?NHRHN2lSa0EvcFRhemc0V3AzQXJsckJaOGlob2VaamZ2cVc0QzFTS2Zib1hl?=
 =?utf-8?B?a3NzdENTWXNqRzFPU3NaNjRLVHA1R0RKUDJuLzQ5RENpTkpUZHFtOXQ1dW5l?=
 =?utf-8?Q?vL7O7GbWet7hG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVQ5aE1sMVJOODAxZDRZYmxnMXFFczhEd1lkMjRCekV6U042Y2x0dkRiUjBY?=
 =?utf-8?B?VzZlaVpEcUdxVVFCMnpBM3JXUmdBaWQxQVlDOWlZMHk5WGdJUzV1QTZhME9V?=
 =?utf-8?B?QmppaCtVMUFIZC81UXBEb3lQMmlwNSt3Y3lScnhnSmNLVWdXSmdDS28xem14?=
 =?utf-8?B?LzE0TTlVQUlVcENlcnpuZTJsY3M4Sklhc0htTWlmWkNkT2s0cnpCNmxOYnQ0?=
 =?utf-8?B?eVR0cS9IZkFEdXlwdWZKckJ5eFZQa3M4K2swbW5RRGpiVUtveUtHK1lEd0NM?=
 =?utf-8?B?eGtMdDM4WHV2TEc1VGRwaUU2aXAxNmZ3NU9icVd2SDd1ckZSTjVvNWNvLzg2?=
 =?utf-8?B?SHpFR25wdnhVeE9VMXlBaDBQQU41aVZFZldEQUUrK0lubjNBdlRHMVU2cks1?=
 =?utf-8?B?NnBYR0ZLbVlUNG9zYlJoY1JDRCtHRU50OWFsbkp3dVdaclMra1ExMmYrL0pZ?=
 =?utf-8?B?aTVOZzNEYW9nU2lCM1c3N2xqVWIzWVF3bHRGQkhXcmp3Qm4rR3U0UXJtSncx?=
 =?utf-8?B?NEFoOEtuU295eUFPRE91SkcyTGhhQ3paalJraDRtV0d2cU9JYmlmUDlOa1Zr?=
 =?utf-8?B?aFR4c2NaV2tkbjNLQlZYdytTaEQwYWY4bnFNQWRnQThvNklhMHBuRXBDWHlq?=
 =?utf-8?B?c25ySFZSWHY0d1hLUWNiaHowdHFaRmFsME1qWlVMU1d2cGFKeXFXSVdEUnN2?=
 =?utf-8?B?aWdOZG9EaFRuUWJoOXFiY0YrRWtRRGpzdHBFUDF0dW04MW5rcHZ1TEF6NjUw?=
 =?utf-8?B?Q1ljejdVSjZ4bURaS3JBZ1ZOcTNZNitiN0I0NjBSMExPdFV6S1NHYnhKd3o0?=
 =?utf-8?B?RC9DdWtMaFA3SHZMWHJFWDJFRjZCVUUzYU84cWtnKzYvSFA1b1VEUzlBQURm?=
 =?utf-8?B?eUcrdDAweE5jZHNVV3p1ckU3c1FvajU5Z3drcUp3blRSSmg3M29INSt2MzAz?=
 =?utf-8?B?VUNML1hyMEFwbk1mU2hkZ3ZjYTJ2RHFuUXpabVZSOWt1NDE2UUJwK21aaFU1?=
 =?utf-8?B?NVpEVytWUmpIc0M1Vlg4MFNpaUZQNzljN0JvV2pDcE15SXRkUFBRUHF3M3RD?=
 =?utf-8?B?UWN0bkFldWViTVBmbmFSWlowVjkzOTFyWVkvcDk1M1p6R0Njcyt3MlRiTXpG?=
 =?utf-8?B?VlA2NmphNU5KK3NiSUFQeUtZU245ZUFFazNGUWFVWW52T2lPTVRyNXlvSlBI?=
 =?utf-8?B?V1NUL1U5cEFBMFdvY3hta1hFWmZ2U1NHTGJENmNRc1pIaGtmYktiVnZwRjNR?=
 =?utf-8?B?NHVqdEhaMlVqa21GWndhVlg1Mk1GWjNidWlnc2g1R29CTDd0UFJOa2NEZSsw?=
 =?utf-8?B?VWlXdFduT1hpRHVVeThjSkxzRVpPekNVWmJ3cWlxQ2lkTnJQWHI3aUJZbGhK?=
 =?utf-8?B?NWtMV2hXMWFWNjNRMUxSWVpoanhybjBISVd0U2FSZEhpNUNNVVg3U2U1dGhH?=
 =?utf-8?B?M29MZjhpVUdpeDVKSk0wRWVDVGhnZUhuMGlMZ01OUFR4b01sR25seWliUThY?=
 =?utf-8?B?c2hGWkI4TlJ6WTQ1TStPT0NuenA3Nkh5bzlyYzFrM2hLbm54cUt5OVlGVDI3?=
 =?utf-8?B?OG8yWEZSZ21ZeWpLY2UzS0lqaVM4NTNHNHdrOFRGZndDWDU4WW04MjFpT2hK?=
 =?utf-8?B?MzVFcjFRTXNyM01wSW9EeEZIaGdqTnVhd1oxTjdlamtOeElmZEpyaTNRN00r?=
 =?utf-8?B?UzZvZmx6Y0tvSzNYdXk4ems4ME5id2Y2aHoyRHBwd29oZE9oRjVjQUNxbFRN?=
 =?utf-8?B?a2xuU1NaWWZ4bHZ5NTN0c1k5MnRueldWNVFQTDFYK0t2VzFIRE1IYysyenpn?=
 =?utf-8?B?aU8vZkRFdGVucXBFK3NxcmJlOERLbDR0eXAwdFdmRjVwY0c3Z1NEbVd1OU5I?=
 =?utf-8?B?eDBiZXVpWXk1WEwzdzJPNzJNZjdTVXRvYStPTHRUSTNmN05NVitCNjN2UVgy?=
 =?utf-8?B?anZ6aVJxdHIyYVZvQ3hjdUN6TjlZRS9wTStxbzBLTUowY3NuVVZ1d2kwWnlG?=
 =?utf-8?B?dzNyeW01SG9RelFFS0VEWDdENXpja3hCeWtNb1pJMUx6NW1TMyt3TG1uZlNE?=
 =?utf-8?B?OFpGMW9rMjQrdGZ0VVdnSEt2akU1NXE1eHhQSUpySWkyYk9yVXkwcXBQL0cz?=
 =?utf-8?Q?Nhm4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b2597c-405f-4dcc-532e-08dd025a9e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 14:10:37.7113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrZ4IboOpuAzgSv4cUxZiaeZVd/sCMIzDEt4TdgmI2uP5qMdDOKXK/YN1KOJKZ8CmzsHCofFGC5SJn8KUX20cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTEsIDIwMjQg
NTo0NCBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFt
ZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAoQU1E
LVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAzLzddIHVz
Yjogb25ib2FyZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXANCj4gVVNCNTc0NA0KPiAN
Cj4gT24gMTEvOC8yNCA0OjU5IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+
ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgVVNCNTc0NCBVU0IzLjAgYW5kIFVTQjIu
MCBIdWIuDQo+ID4gVGhlIHVzYjU3NDQgZHJpdmVyIHRyaWdnZXIgaHViIHJlc2V0IHNpZ25hbCBh
ZnRlciBzb2Z0IHJlc2V0Lg0KPiA+IFRoZSB1c2I1NzQ0IGh1YiBuZWVkIHRvIHJlc2V0IGFmdGVy
IHRoZSBwaHkgaW5pdGlhbGl6YXRpb24sIHdoaWNoDQo+ID4gdG9nZ2xlcyB0aGUgZ3Bpby4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBk
ZW54LmRlPg0KPiA+IC0tLQ0KPiA+ICAgY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jIHwgMTUgKysr
KysrKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9jb21tb24vdXNiX29uYm9hcmRfaHVi
LmMgYi9jb21tb24vdXNiX29uYm9hcmRfaHViLmMgaW5kZXgNCj4gPiA4MjdlY2Y5YjAyLi5lNjA0
Yzg2ZDhhIDEwMDY0NA0KPiA+IC0tLSBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+ICsr
KyBiL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+IEBAIC04OCwxMCArODgsMjEgQEAgc3Rh
dGljIGludCB1c2Jfb25ib2FyZF9odWJfcmVtb3ZlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4g
ICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9u
Ym9hcmRfaHViX2RhdGEgdXNiNTc0NF9kYXRhID0gew0KPiA+ICsJLnBvd2VyX29uX2RlbGF5X3Vz
ID0gMTAwMDAsDQo+ID4gKwkucmVzZXRfdXMgPSAxMDAwMCwNCj4gPiArfTsNCj4gPiArDQo+ID4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2VfaWQgdXNiX29uYm9hcmRfaHViX2lkc1tdID0g
ew0KPiA+ICAgCS8qIFVzZSBnZW5lcmljIHVzYlZJRCxQSUQgZHQtYmluZGluZ3MgKHVzYi1kZXZp
Y2UueWFtbCkgKi8NCj4gPiAtCXsgLmNvbXBhdGlibGUgPSAidXNiNDI0LDI1MTQiIH0sIC8qIFVT
QjI1MTRCIFVTQiAyLjAgKi8NCj4gPiAtCXsgfQ0KPiA+ICsJewkuY29tcGF0aWJsZSA9ICJ1c2I0
MjQsMjUxNCIgLyogVVNCMjUxNEIgVVNCIDIuMCAqLw0KPiANCj4gRG9lcyB0aGlzIGh1YiBuZWVk
IGFueSBwb3dlcl9vbl9kZWxheV91cyAvIHJlc2V0X3VzIGRlbGF5IHRvbyA/DQo+IFByb2JhYmx5
IHllcyA/IElmIHNvLCBwbGVhc2UgYWRkIHRoZSBkZWxheSBpbiAxLzcgLCBvdGhlcndpc2UgdGhl
cmUgd2lsbCBiZSBhIGZhc3QgcmVzZXQNCj4gcHVsc2Ugb24gdGhlIHJlc2V0IEdQSU8gbGluZSB3
aGljaCB0aGUgaHViIG1heSBlaXRoZXIgbm90IHJlY29nbml6ZSwgb3Igd29yc2UsIG1heQ0KPiBt
YWtlIHRoZSBodWIgbGF0Y2ggdXAuDQoNClRoZSBodWIgInVzYjQyNCwyNTE0IiBpcyBub3QgcGFy
dCBvZiB0aGlzIHNlcmllcywgdGhpcyB3YXMgYWRkZWQgYXMgcGFydCBvZg0KaHR0cHM6Ly9naXRo
dWIuY29tL3UtYm9vdC91LWJvb3QvY29tbWl0L2JhMWZhMmFiZGU4ODI1N2MyOWVlNGQ4ZjM4ODRh
YjY2NTdhMzE5M2EuDQpBbSBub3Qgc3VyZSBhYm91dCB0aGUgcG93ZXJfb25fZGVsYXlfdXMgLyBy
ZXNldF91cyBkZWxheSBmb3IgdGhpcyBodWIuDQoNCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg0KPiA+
ICsJfSwgew0KPiA+ICsJCS5jb21wYXRpYmxlID0gInVzYjQyNCwyNzQ0IiwgLyogVVNCMjc0NCBV
U0IgMi4wICovDQo+ID4gKwkJLmRhdGEgPSAodWxvbmcpJnVzYjU3NDRfZGF0YSwNCj4gPiArCX0s
IHsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJ1c2I0MjQsNTc0NCIsIC8qIFVTQjU3NDQgVVNCIDMu
MCAqLw0KPiA+ICsJCS5kYXRhID0gKHVsb25nKSZ1c2I1NzQ0X2RhdGEsDQo+ID4gKwl9DQo=
