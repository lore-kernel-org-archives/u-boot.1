Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEC4C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5BB81D5D;
	Wed, 23 Apr 2025 16:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dVybup68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8D4809A5; Wed, 23 Apr 2025 04:52:47 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399738091A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 04:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFKU4XtKGvYLTj5r4XmedzigMha4y5hTWBrNYPZwHHQF2rdES5Cd+L596wiu0FDDvjCWwq53/X63Zki163GdvYtIYHEbC4aSgUZIHrP+yriiemgCDogJksyzBsZkRlaW+K40HmS9X0s4Wa2z0Ak5sAmWW5WTgtnjay7SuWldiSsj0uC1jpIP6gwK9dRFDsRGfgO1yjQXEH/yj9WSZuSA+IO4OLZUrAdBO9oYaQyn8khAkC1N1t0umRpg5FmwyDJGYNn2FIC7I56GF5h+8KB0fmaC5mMCWfMX8MoUg8HKFpS3RpJn1XJNFwTyXmNkdk0PD85ita5S3Nz31eS6xdr9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0IzSktRUhRrpPRh03xT7RIOnxBDaQjNZwdkGYaJyTc=;
 b=OgGvHXsdg8kMjcR+pnuCmJR12YZbWne2XA6kXuaviKj0+DbsQLDQyQA3zumxn1+8TDSOxL1u4vQiuddkztG7hdCtZSioeqC+LLjxiwH34i1gfVgWvnNoYzVHBN5qTvJG/dTIw7rpDQd8btGLdp3+p/dE+E3uaFhbb35/e2AFGhNoDR40DNXARwNmY1qx2xylZXvJDn35Gj0CPGX+Cy5ap8V6KI0mPYZ23pjEnmKdV7+ZgFYup+rA2rLDkb18RwP14mVbhnU1lVMQ27Cwzt1WqHtQD3Vn/WUnI+kyJVhqIkWJOZFFovqIffstBOjF5HJWsRafLGQk72Bf6O1mSnHmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0IzSktRUhRrpPRh03xT7RIOnxBDaQjNZwdkGYaJyTc=;
 b=dVybup68olkUHayEwSEFjDuDfln+p8NkXbuReUiN9t+xvNBHAuUckpsXIgX9QLARmiRHf5uazm56chW+KXCni1NBmUgRNAw44L7B7mhqMpZrr6F8eXHYZ9rjQZ7AoG08sJLbsZdS8dEf9SbFAX4CnsMMENAGHPSNFFcgeManiBXO2yFZIxiYVgziGD8iuzkGszcEP8nyS+MwtmDsdM1ojj5lf125qFIwtu6RIsx6Jk8KYJJzotvUuiTQZJda6tTAsKsUbR8M+jmXRWrRiYFuSeJO90zDCfYdvomxk2aOvYQkjyEJaTUg4bavbP3+QIp6QEDbYS1/Jdh7Cho8EHzGUQ==
Received: from SN6PR03MB3421.namprd03.prod.outlook.com (2603:10b6:805:47::31)
 by SA0PR03MB5643.namprd03.prod.outlook.com (2603:10b6:806:bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 02:52:41 +0000
Received: from SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::6b26:9fef:479:95ec]) by SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::6b26:9fef:479:95ec%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 02:52:40 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [resend v4 03/12] drivers: i3c: Add i3c uclass driver.
Thread-Topic: [resend v4 03/12] drivers: i3c: Add i3c uclass driver.
Thread-Index: AQHbrz8ziD6e6sj+C0m79mJc6q/L57OneTsAgAkb9lA=
Date: Wed, 23 Apr 2025 02:52:40 +0000
Message-ID: <SN6PR03MB34219B1E1FDD62071752D813F7BA2@SN6PR03MB3421.namprd03.prod.outlook.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
 <20250417021840.6212-4-dinesh.maniyam@altera.com>
 <9a0ea314-8ff8-4ab3-8d75-4c5acdfb2c7d@gmx.de>
In-Reply-To: <9a0ea314-8ff8-4ab3-8d75-4c5acdfb2c7d@gmx.de>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3421:EE_|SA0PR03MB5643:EE_
x-ms-office365-filtering-correlation-id: 1520a05c-f22a-4899-d347-08dd8211ea0b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZnIvczBtQkNXNU93OHd5NjhzampXR2dSVVdpVlcwWnVZSWZ2cUVmR1hJL2E0?=
 =?utf-8?B?dnFtdWU2NjV3SFlacXIrbXcrTCtzNUdWbWcxV25CWW43bTd4L1ZtNVJyV3ZZ?=
 =?utf-8?B?TkdkcXQ0enFTbDVDVXRHQUpjZVRQR1VOeUh1NnM4ZnpKd0hLNVlXUDdFbk1V?=
 =?utf-8?B?Z0lRZXlDckhMS1RFZERGZ1JJL3RJeXpOTDlMdVBLc0djMkRHbkc0NWo2dGVY?=
 =?utf-8?B?QUNKY0JJaDNWS3o2OFdsTlJxdUtFWUJVeEluV0lVelpIRW8wd1hBSDlnVHlI?=
 =?utf-8?B?ajZ4eXZpaHdWcUk2NHBzK1pmOW9oN3N3OCtIWDlJMUY1YTlHc2kybTN3OGpS?=
 =?utf-8?B?VmN0WHRhY3pzM2trZStld0p0SXlvWU14ZDdQaERIeXhiWWRtWDMxL3RuNk1x?=
 =?utf-8?B?TlhBby92ZTZjMzFlOTV3aXVVOXpnbUpFOEF6WitFU1dUSHNZTDZoN1hwTGVl?=
 =?utf-8?B?UHpxQXdYMmhId2dtOXlWelhpbC83Zlk5ckR4NVJqOVU0TkZ4MklOaXZtRDZm?=
 =?utf-8?B?YVFRVnBtdFJUV3lrSkRpZ0hrQXZvR2RqWE9ZRWF4eG1aajJMWWduR2FBZWFq?=
 =?utf-8?B?L0JmZkRkeW1ST2RVUmNyd1FXU1ZBd3U2bGhsZXR3RXZVcUtSSTNpc1JZUTlC?=
 =?utf-8?B?T2loN3dqTG5uTTFyMjRIMk50bFh4Wjk3MkZ6TVZCSlZQSkNzMEhPOGs0SFov?=
 =?utf-8?B?TGhNSEovN0hjdXdpOXlyNEtjc2FCNjBoR3pnVCsrNzJFeDdmejZYOXhSZlhE?=
 =?utf-8?B?US9nTi9OaXQrYjVEYWRzWXY4QkFzVzhHTFVPbGdHQktzWTg2SU9JclBvWlJr?=
 =?utf-8?B?eEs1Y2xZcFZwVVJ4QjVtd2ExWGNqK0RCZ3pSekc4M3FhTFZCRGJUWUQxRGx3?=
 =?utf-8?B?bkZuWTlnWjk0QmMrdDBjMFhocVNWUk5wdWl2Yjc4eUJEZVNldTBjVlhhTGgy?=
 =?utf-8?B?bUoyNE9oSzNsOTFtc0hpR2ZCdzZGVWM0ZWJKQUtidE9VQmJsV1pBYzJzd1lV?=
 =?utf-8?B?ZzAvdDgzMUUxdmpsOXFhZHFqU3VOdUZlTzZpTGQxYnNqWm5LaDFpOTl5bmg1?=
 =?utf-8?B?eVJ6NG8weFh1ekhxN0tGc2JaNUNyZnFHZGxOV3JDQUhWN2dtZ1B0WGFyL1M2?=
 =?utf-8?B?VWU0M0U1Z1gxNW9acVk5cUFRVlRlWTArMzd0dW01SW9OeWYvZzJNUFVFTWI5?=
 =?utf-8?B?dEVsQWJURm9pcU5YOEtyaUxiNmhpSDRUendpSUZYWGU4Z3pYLzErbTVEMXRw?=
 =?utf-8?B?WmhRUUFMVUFqYlR2U01qUEJFVUFHRmVVaHpNVFdZejNaaW96RkZjSkk0MEJI?=
 =?utf-8?B?WmsrdmJiZ3Bjd091NHNoSXhVV1V0a0lJV3FNbUdiV1JDUmV0YkJQbkdBcDZ5?=
 =?utf-8?B?M1I0T2g3d2hZQ0dQSlJrV2ZsQXFKc2o4amRIRGhVcUdTempaT1lZK3g2S0VU?=
 =?utf-8?B?MVRaZmR2S1dKd0xNZG1WdjQ4RlkyeFdBTTNUNG50VHE4OWFWL3dPMTU4TDZn?=
 =?utf-8?B?MXFtU08zZjNaYUw1WWRDQTZHWDdWVGVrcWlxbkNmc2h0cXByTThrRktXQlYw?=
 =?utf-8?B?a0IrUlJwSGNDL2hvd2RaejJiaU8ybEk1WmM3LzR1NzZIU214cGNnNlUxbnUy?=
 =?utf-8?B?L1BXQVY1NnI5eVVPeGltRVBSZEZXTTlRRS9STSs2bktlWUlsbEdtOWVHRW5G?=
 =?utf-8?B?MHhGU3FwcmxZVnFmdVJXTk15YTRYOURuV2JscGcxRzNxRkhoS3poZUZQYkI0?=
 =?utf-8?B?YTlDa2VtbUFNYmkzYlFZaEczOW5UbFAyUVJKamYxb3RrREhsclAxMlVnZmF3?=
 =?utf-8?B?VkNwMTRlWHFJYXVkcTVReDhNeDdSTzZmV3BZOSsvQ3NZY1JVOG9LcEhOTWc5?=
 =?utf-8?B?bDBlMEF3SG1XV0ZyS2VaWlQrZWFGQ3FRM2lTSzdMSUpZVjlKaHZqT09VS2dP?=
 =?utf-8?Q?UBq0nKHrzcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3421.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVl4UjBLZGZzZGNEbFp4UXJuYVFyWlJCNEpUUURSak5mTzl3ZEVqcldVazVm?=
 =?utf-8?B?RmxmN1NPUkk0MDBEVmJpYjlNdjM2cE5TbWFQL0ZsY3ZvMnp0ZGprbjh0ZnVs?=
 =?utf-8?B?THZYMVhISTFuc25VdVpSeGRxc3VlM2Q3UWhrQWtwUFUxNUFmVmI1NXNjSmlI?=
 =?utf-8?B?RjZEc3dQQk1jUnRNbWlON0pkdVdPQjBoREkxbi9tb2MrMFRMQTliV0tzMStS?=
 =?utf-8?B?bEVyaGZ1engwazBmVmZkMGtTSHU0emUreloyWExrRmhMQWVaVkxIaXg2aUVp?=
 =?utf-8?B?aVNnRFdjMmdOOTNmWDJua2xSRXNJa2gzNzEvTUtCeXkxQVo1ZU4zQVFpMlVT?=
 =?utf-8?B?am41RWI3VjgrNTlJc3F0M1B5RXpDZHlSWWFpbklMMGVQQVNyNnRLNEpIT0xp?=
 =?utf-8?B?TmxGaTFLa2xBT0FDbFovRWtMQzhJdS90U1lqY1dCdWx5N0hrVXdKTk9tWU5P?=
 =?utf-8?B?K05GVnZITkpNSjloT0Z2dWdxWXo2YzNnVXF5OTlCd1JFOE5YZ1lVRnZwYkFD?=
 =?utf-8?B?cm11OW03ZWFaMnZVczZHTUZBRG5uUEZQRmRxSEVqczdjUG9NUGJ1NEJDUlAx?=
 =?utf-8?B?TVdpMXVhUTh2UWVwcVNyeFQwSlBYa3BRaUhOaFNsbXpDcDlIZEhRajFXejNK?=
 =?utf-8?B?SmdTYmdQalZqWk9penlHcE5vWmRhSkZyTXJ2L1F2bFJ4LzVlZlBOY2swdlBM?=
 =?utf-8?B?VndJWXRSNnVqbUV1Y3RKM1pESW9WUEVJN1Ard2ZOVTUrcHFyN1BSY1RibkF1?=
 =?utf-8?B?cjVyYmZ0WlJpbUJjSkRQd3pzWkYrcEZLSEl2OE45Z0RtTlRxejlBaG41T3Rj?=
 =?utf-8?B?L0hkWld3ZXY1bS9jUlgvMU90a290MlB3c3FNY1Nqa3M0blY3QU5adjJ2aW0v?=
 =?utf-8?B?RHFrbVhCYXBPUklaVGtMd0dGam1ycDd2YlV4TjY3NGRwMVFLd3Vrd0cxSUhy?=
 =?utf-8?B?ZG5ZV2RKOHJrZUpUcnZOTXVTWmJFZlhCdVg3eTFIUms4VnNLbTl4WnpPMU9T?=
 =?utf-8?B?Wnd3aVMrRTlYa3cwNDVKNUFvM3JpckVRVnJiTnNzYUpzdDVRcEMrMytIZGNy?=
 =?utf-8?B?OC9hS2tPa3ZVaTJnbGFFS2wzQk9IcEZaVjM0cnhPUDJHUHk1Nk1tWWdNS3Uv?=
 =?utf-8?B?TDduWE9LWG1IeTJIcEFZRXdSeUxFZ1dPdW50YU15QkZVaFVScXlqeVcrajNL?=
 =?utf-8?B?QkZtd0NFcXhmWDBiRXI1QkhTclJVRHVGMS96YkVQcU1HYUdaRkpGb1EzYmNK?=
 =?utf-8?B?emdqVllEMG9rUHQ4UmxXTjJYV2ljMVZpR0RTS2R1YVByVEVFcG5MRlAwTEpO?=
 =?utf-8?B?SDdNVkpXSDd5UHJzT0JrclpRQWFsS3hqNkt6MHZGNUJ0RVBRc2hJYzBHRjhB?=
 =?utf-8?B?N3JscjhCY3VQUVBrM3Vma0dLbjBDcEoxSmYxRXdlYzljZG5VOTlmbU16SUp0?=
 =?utf-8?B?MG5vcng0Q05BaVVFMmdqQk9yNEpwYytkZWkxb1pxYTNRek1HdVBoWU5BNmJu?=
 =?utf-8?B?S2d4c2s5RzVjMzZ6ak9LYTJVeXVHT3JuUTFqWHRydEhqSFpxSWluaFBla3RN?=
 =?utf-8?B?OUIrcDlZZTNrWXFYQ01jVlE0L0VOanJuazAyYkdZcWYwenFvMDBzQko4cm1h?=
 =?utf-8?B?dmp1V1lNWS9Yd2RQcTZRMGR4L2hHbkx0VS9ZWEUrZTNoWE9rQXQrYk55a3pK?=
 =?utf-8?B?aWpiRnc0RHRRTEFybGtaUlhCemIyc0VXWXV1a0xMVzRIUFJSb25CMXdXYktS?=
 =?utf-8?B?dHlsd1FYWnlCRVVjOW1yTVBKK1prVU1scmU3QWE0cDdML2lUNTJYMkV4aXZz?=
 =?utf-8?B?emUxKzlnTkUzUXhPRXBMSnlKMnFOUC84UHpmZFozMDQzVllQVmJhb3RWZjM4?=
 =?utf-8?B?TDZDc3ArVlA4dVduZ2pwSzdCYmpMWEVPc2xuQUhBZHdBY08wUlQ3QWJrWER2?=
 =?utf-8?B?RDdTd0JPTU5WNW0wd2lnUjVsVG1XS3VIbVpvRGk0eklpd0hhM0wzYWpvOWpY?=
 =?utf-8?B?T0dwbHEvUVNiS3BjY2wyWG5DMURJd0p1OGZhRlZtVlNNVVVYMXk0WDRXdXRV?=
 =?utf-8?B?aVV2d2loU0o1ZzhYaTFac1crMkpwejZpc2lxb3hQUlBkMUJRY25rWCtPdnFS?=
 =?utf-8?Q?UjzkZTmgAlPFxIYepfCgs7gGO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3421.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520a05c-f22a-4899-d347-08dd8211ea0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 02:52:40.9143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R52tDvVeoQ3ho0EDK3YT86JMhhimfOGurfH9jn4w4Bt9B3iA2c1L1FKIn7g86Yfl0NthlkZn1FZcAF+rCJScSRcR8664VISHgf6Drbc3Lhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5643
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbnJpY2ggU2NodWNo
YXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBTZW50OiBUaHVyc2RheSwgMTcgQXByaWwgMjAy
NSAzOjQwIHBtDQo+IFRvOiBNYW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5j
b20+DQo+IENjOiBNYXJlayA8bWFyZXhAZGVueC5kZT47IFNpbW9uIDxzaW1vbi5rLnIuZ29sZHNj
aG1pZHRAZ21haWwuY29tPjsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBUb20g
UmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgRGFyaW8NCj4gQmluYWNjaGkgPGRhcmlvLmJpbmFj
Y2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgSWxpYXMgQXBhbG9kaW1hcw0KPiA8aWxpYXMuYXBh
bG9kaW1hc0BsaW5hcm8ub3JnPjsgSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZvcmlzc2llckBs
aW5hcm8ub3JnPjsNCj4gTWF0dGlqcyBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGJheWxpYnJl
LmNvbT47IEliYWkgRXJraWFnYSA8aWJhaS5lcmtpYWdhLQ0KPiBlbG9yemFAYW1kLmNvbT47IE1p
Y2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBEbWl0cnkgUm9rb3Nvdg0KPiA8ZGRy
b2tvc292QHNhbHV0ZWRldmljZXMuY29tPjsgSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNl
PjsgU2ViYXN0aWFuDQo+IFJlaWNoZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+
OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0BhbHRlcmEuY29tPjsgQ2hlZSwgVGll
biBGb25nIDx0aWVuLmZvbmcuY2hlZUBhbHRlcmEuY29tPjsNCj4gSGVhLCBLb2sgS2lhbmcgPGtv
ay5raWFuZy5oZWFAYWx0ZXJhLmNvbT47IE5nLCBCb29uIEtoYWkNCj4gPGJvb24ua2hhaS5uZ0Bh
bHRlcmEuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWlt
aUBhbHRlcmEuY29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltIEl6emF0DQo+IDxtdWhhbW1hZC5o
YXppbS5penphdC56YW1yaUBhbHRlcmEuY29tPjsgTGltLCBKaXQgTG9vbg0KPiA8aml0Lmxvb24u
bGltQGFsdGVyYS5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFuZ0BhbHRlcmEuY29t
PjsgdS0NCj4gYm9vdEBsaXN0cy5kZW54LmRlDQo+IFN1YmplY3Q6IFJlOiBbcmVzZW5kIHY0IDAz
LzEyXSBkcml2ZXJzOiBpM2M6IEFkZCBpM2MgdWNsYXNzIGRyaXZlci4NCj4gDQo+IFtDQVVUSU9O
OiBUaGlzIGVtYWlsIGlzIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gVW5sZXNzIHlv
dSB0cnVzdCB0aGUNCj4gc2VuZGVyLCBkbyBub3QgY2xpY2sgb24gbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyBhcyBpdCBtYXkgYmUgYSBmcmF1ZHVsZW50IGVtYWlsDQo+IGF0dGVtcHRpbmcgdG8g
c3RlYWwgeW91ciBpbmZvcm1hdGlvbiBhbmQvb3IgY29tcHJvbWlzZSB5b3VyIGNvbXB1dGVyLl0N
Cj4gDQo+IE9uIDQvMTcvMjUgMDQ6MTgsIGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20gd3JvdGU6
DQo+ID4gRnJvbTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQo+
ID4NCj4gPiBFbmFibGUgaTNjIGdlbmVyYWwgdWNsYXNzIGRyaXZlci4gVGhpcyB1Y2xhc3MgZHJp
dmVyIHdpbGwgaGF2ZSBnZW5hcmFsDQo+ID4gcmVhZCBhbmQgd3JpdGUgYXBpIHRvIGNhbGwgdGhl
IHNwZWNpZmljIGkzYyBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5lc2ggTWFu
aXlhbSA8ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
aTNjL2kzYy11Y2xhc3MuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5j
bHVkZS9kdy1pM2MuaCAgICAgICAgIHwgIDEgKw0KPiA+ICAgaW5jbHVkZS9pM2MuaCAgICAgICAg
ICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxMDIgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvaTNjL2kzYy11Y2xhc3MuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvaTNjLmgNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kzYy9pM2MtdWNsYXNz
LmMgYi9kcml2ZXJzL2kzYy9pM2MtdWNsYXNzLmMgbmV3DQo+ID4gZmlsZSBtb2RlIDEwMDY0NCBp
bmRleCAwMDAwMDAwMDAwMC4uNjQ0ZjU3ODg4OTgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9pM2MvaTNjLXVjbGFzcy5jDQo+ID4gQEAgLTAsMCArMSwzOCBAQA0KPiA+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5
cmlnaHQgKEMpIDIwMjUgQWx0ZXJhIENvcnBvcmF0aW9uIDx3d3cuYWx0ZXJhLmNvbT4gICovDQo+
ID4gKw0KPiA+ICsjaW5jbHVkZSA8ZG0uaD4NCj4gPiArI2luY2x1ZGUgPGkzYy5oPg0KPiA+ICsj
aW5jbHVkZSA8ZXJybm8uaD4NCj4gPiArI2luY2x1ZGUgPGxvZy5oPg0KPiA+ICsjaW5jbHVkZSA8
ZG0vZGV2aWNlLWludGVybmFsLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPg0KPiA+
ICsNCj4gPiAraW50IGRtX2kzY19yZWFkKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHU4IGRldl9udW1i
ZXIsDQo+ID4gKyAgICAgICAgICAgICB1OCAqYnVmLCBpbnQgbnVtX2J5dGVzKQ0KPiA+ICt7DQo+
ID4gKyAgICAgc3RydWN0IGRtX2kzY19vcHMgKm9wcyA9IGkzY19nZXRfb3BzKGRldik7DQo+ID4g
Kw0KPiA+ICsgICAgIGlmICghb3BzLT5yZWFkKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9TWVM7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBvcHMtPnJlYWQoZGV2LCBkZXZfbnVtYmVy
LCBidWYsIG51bV9ieXRlcyk7IH0NCj4gPiArDQo+ID4gK2ludCBkbV9pM2Nfd3JpdGUoc3RydWN0
IHVkZXZpY2UgKmRldiwgdTggZGV2X251bWJlciwNCj4gPiArICAgICAgICAgICAgICB1OCAqYnVm
LCBpbnQgbnVtX2J5dGVzKSB7DQo+ID4gKyAgICAgc3RydWN0IGRtX2kzY19vcHMgKm9wcyA9IGkz
Y19nZXRfb3BzKGRldik7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghb3BzLT53cml0ZSkNCj4gPiAr
ICAgICAgICAgICAgIHJldHVybiAtRU5PU1lTOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gb3Bz
LT53cml0ZShkZXYsIGRldl9udW1iZXIsIGJ1ZiwgbnVtX2J5dGVzKTsgfQ0KPiA+ICsNCj4gPiAr
VUNMQVNTX0RSSVZFUihpM2MpID0gew0KPiA+ICsgICAgIC5pZCAgICAgICAgICAgICA9IFVDTEFT
U19JM0MsDQo+ID4gKyAgICAgLm5hbWUgICAgICAgICAgID0gImkzYyIsDQo+ID4gK307DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHctaTNjLmggYi9pbmNsdWRlL2R3LWkzYy5oIGluZGV4DQo+
ID4gZTM3ZmQ0ZGMzMjUuLjkyMGYxOGJjY2I0IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvZHct
aTNjLmgNCj4gPiArKysgYi9pbmNsdWRlL2R3LWkzYy5oDQo+ID4gQEAgLTcsNiArNyw3IEBADQo+
ID4gICAjZGVmaW5lIF9EV19JM0NfSF8NCj4gPg0KPiA+ICAgI2luY2x1ZGUgPGNsay5oPg0KPiA+
ICsjaW5jbHVkZSA8aTNjLmg+DQo+ID4gICAjaW5jbHVkZSA8cmVzZXQuaD4NCj4gPiAgICNpbmNs
dWRlIDxkbS9kZXZpY2UuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4NCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9pM2MuaCBiL2luY2x1ZGUvaTNjLmggbmV3IGZpbGUgbW9kZSAx
MDA2NDQgaW5kZXgNCj4gPiAwMDAwMDAwMDAwMC4uNmVmNDk4MmRjZjYNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvaW5jbHVkZS9pM2MuaA0KPiA+IEBAIC0wLDAgKzEsNjMgQEANCj4gPiAr
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ID4gKy8qDQo+ID4gKyAq
IENvcHlyaWdodCAoQykgMjAyNSBBbHRlcmEgQ29ycG9yYXRpb24gPHd3dy5hbHRlcmEuY29tPiAg
Ki8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pM2MvbWFzdGVyLmg+DQo+ID4gKw0KPiA+
ICsvKioNCj4gPiArICogc3RydWN0IGRtX2kzY19vcHMgLSBkcml2ZXIgb3BlcmF0aW9ucyBmb3Ig
aTNjIHVjbGFzcw0KPiA+ICsgKg0KPiA+ICsgKiBEcml2ZXJzIHNob3VsZCBzdXBwb3J0IHRoZXNl
IG9wZXJhdGlvbnMgdW5sZXNzIG90aGVyd2lzZSBub3RlZC4NCj4gPiArVGhlc2UNCj4gPiArICog
b3BlcmF0aW9ucyBhcmUgaW50ZW5kZWQgdG8gYmUgdXNlZCBieSB1Y2xhc3MgY29kZSwgbm90IGRp
cmVjdGx5DQo+ID4gK2Zyb20NCj4gPiArICogb3RoZXIgY29kZS4NCj4gPiArICovDQo+ID4gK3N0
cnVjdCBkbV9pM2Nfb3BzIHsNCj4gPiArICAgICAvKioNCj4gPiArICAgICAgKiBUcmFuc2ZlciBt
ZXNzYWdlcyBpbiBJM0MgbW9kZS4NCj4gPiArICAgICAgKg0KPiA+ICsgICAgICAqIEBzZWUgaTNj
X3RyYW5zZmVyDQo+ID4gKyAgICAgICoNCj4gPiArICAgICAgKiBAcGFyYW0gZGV2IFBvaW50ZXIg
dG8gY29udHJvbGxlciBkZXZpY2UgZHJpdmVyIGluc3RhbmNlLg0KPiA+ICsgICAgICAqIEBwYXJh
bSB0YXJnZXQgUG9pbnRlciB0byB0YXJnZXQgZGV2aWNlIGRlc2NyaXB0b3IuDQo+ID4gKyAgICAg
ICogQHBhcmFtIG1zZyBQb2ludGVyIHRvIEkzQyBtZXNzYWdlcy4NCj4gPiArICAgICAgKiBAcGFy
YW0gbnVtX21zZ3MgTnVtYmVyIG9mIG1lc3NhZ2VzIHRvIHRyYW5zZmVyLg0KPiANCj4gV2UgZm9s
bG93DQo+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2RvYy1ndWlkZS9rZXJuZWwtZG9jLmh0bWwj
ZnVuY3Rpb24tZG9jdW1lbnRhdGlvbg0KPiANCj4gQHBhcmFtIGxvb2tzIHdyb25nLg0KPiANCj4g
UGxlYXNlLCBwcm92aWRlIGZvcm1hbGx5IHZhbGlkIGRlc2NyaXB0aW9ucy4NCj4gDQoNCk5vdGVk
LCB3aWxsIHVwZGF0ZSB0aGUgcGFyYW0gYW5kIHByb3ZpZGUgdmFsaWQgZGVzY3JpcHRpb25zIGFz
IHBlciB0aGUgZG9jdW1lbnRhdGlvbi4NCg0KPiA+ICsgICAgICAqDQo+ID4gKyAgICAgICogQHJl
dHVybiBAc2VlIGkzY190cmFuc2Zlcg0KPiANCj4gJXMvQHJldHVybi9SZXR1cm46Lw0KPiANCg0K
V2lsbCBiZSByZXBsYWNlZC4NCg0KPiA+ICsgICAgICAqLw0KPiANCj4gUGxlYXNlLCBhZGQgdGhl
IGhlYWRlciB0byBkb2MvYXBpLyBhbmQgcnVuIGBtYWtlIGh0bWxkb2NzYC4gVGhpcyB3aWxsIGhp
Z2hsaWdodCBhbGwNCj4gZm9ybWFsIGRvY3VtZW50YXRpb24gZXJyb3JzLg0KPiANCg0KTm90ZWQu
IFdpbGwgYWRkIHRoZSBoZWFkZXIgdG8gY2hlY2sgZm9yIHRoZSBlcnJvciBpbiB0aGUgZG9jdW1l
bnRhdGlvbi4NCg0KPiA+ICsgICAgIGludCAoKmkzY194ZmVycykoc3RydWN0IGkzY19kZXZfZGVz
YyAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGkzY19wcml2X3hmZXIg
KmkzY194ZmVycywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIGludCBpM2NfbnhmZXJzKTsN
Cj4gDQo+IFdoeSBkbyB5b3UgYWxsb3cgbmVnYXRpdmUgdmFsdWVzIG9mIGkzY19ueGZlcnM/DQo+
IA0KDQpTaG91bGQgYXZvaWQgdGhlIG5lZ2F0aXZlIHZhbHVlLiBXaWxsIHVzZSB0aGUgdW5zaWdu
ZWQuDQoNCj4gVGhlIHBhcmFtZXRlciBuYW1lcyBzaG91bGQgbWF0Y2ggdGhlIGRlc2NyaXB0aW9u
Lg0KDQpXaWxsIHJlY2hlY2sgdGhlIHBhcmFtZXRlciBuYW1lcy4NCg0KPiA+ICt9Ow0KPiA+ICsN
Cj4gDQo+IFBsZWFzZSwgYWRkIHRoZSBtaXNzaW5nIGRvY3VtZW50YXRpb24gb2YgdGhlIG1hY3Jv
Lg0KPiANCg0KTm90ZWQuIEkgd2lsbCBhZGQgaXQuDQoNCj4gPiArI2RlZmluZSBpM2NfZ2V0X29w
cyhkZXYpICAgICAoKHN0cnVjdCBkbV9pM2Nfb3BzICopKGRldiktPmRyaXZlci0+b3BzKQ0KPiA+
ICsNCj4gPiArLyoqDQo+ID4gKyAqIEBicmllZiBEbyBpM2Mgd3JpdGUNCj4gPiArICoNCj4gPiAr
ICogVWNsYXNzIGdlbmVyYWwgZnVuY3Rpb24gdG8gc3RhcnQgd3JpdGUgdG8gaTNjIHRhcmdldA0K
PiA+ICsgKg0KPiA+ICsgKiBAdWRldmljZSBwb2ludGVyIHRvIGkzYyBjb250cm9sbGVyLg0KPiA+
ICsgKiBAZGV2X251bWJlciB0YXJnZXQgZGV2aWNlIG51bWJlci4NCj4gPiArICogQGJ1ZiB0YXJn
ZXQgQnVmZmVyIHRvIHdyaXRlLg0KPiA+ICsgKiBAbnVtX2J5dGVzIGxlbmd0aCBvZiBieXRlcyB0
byB3cml0ZS4NCj4gDQo+IEFmdGVyIGVhY2ggcGFyYW1ldGVyIGEgY29sb24gJzonIGlzIG1pc3Np
bmcuDQo+IA0KDQpXaWxsIGNvcnJlY3QgaXQuDQoNCj4gPiArICoNCj4gPiArICogQHJldHVybiAw
IGZvciBzdWNjZXNzDQo+IA0KPiAlcy9AcmV0dXJuL1JldHVybjovDQo+IA0KDQpXaWxsIGJlIHJl
cGxhY2VkLg0KDQo+ID4gKyAqLw0KPiA+ICtpbnQgZG1faTNjX3dyaXRlKHN0cnVjdCB1ZGV2aWNl
ICpkZXYsIHU4IGRldl9udW1iZXIsDQo+ID4gKyAgICAgICAgICAgICAgdTggKmJ1ZiwgaW50IG51
bV9ieXRlcyk7DQo+IA0KPiBXaGF0IHdvdWxkIGJlIHRoZSBtZWFuaW5nIG9mIGEgbmVnYXRpdmUg
dmFsdWUgb2YgbnVtX2J5dGVzPw0KPiBBbiB1bnNpZ25lZCB0eXBlIHByb2JhYmx5IHdvdWxkIGJl
IG1vcmUgYXBwcm9wcmlhdGUuDQo+IA0KDQpZZXMgeW91IGFyZSByaWdodC4gV2lsbCB1c2UgdGhl
IHVuc2lnbmVkLg0KDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogQGJyaWVmIERvIGkzYyByZWFk
DQo+ID4gKyAqDQo+ID4gKyAqIFVjbGFzcyBnZW5lcmFsIGZ1bmN0aW9uIHRvIHN0YXJ0IHJlYWQg
ZnJvbSBpM2MgdGFyZ2V0DQo+ID4gKyAqDQo+ID4gKyAqIEB1ZGV2aWNlIHBvaW50ZXIgdG8gaTNj
IGNvbnRyb2xsZXIuDQo+ID4gKyAqIEBkZXZfbnVtYmVyIHRhcmdldCBkZXZpY2UgbnVtYmVyLg0K
PiA+ICsgKiBAYnVmIHRhcmdldCBCdWZmZXIgdG8gcmVhZC4NCj4gPiArICogQG51bV9ieXRlcyBs
ZW5ndGggb2YgYnl0ZXMgdG8gcmVhZC4NCj4gPiArICoNCj4gPiArICogQHJldHVybiAwIGZvciBz
dWNjZXNzDQo+ID4gKyAqLw0KPiA+ICtpbnQgZG1faTNjX3JlYWQoc3RydWN0IHVkZXZpY2UgKmRl
diwgdTggZGV2X251bWJlciwNCj4gPiArICAgICAgICAgICAgIHU4ICpidWYsIGludCBudW1fYnl0
ZXMpOw0KPiANCj4gZGl0dG8NCj4gDQoNCldpbGwgdXNlIHRoZSB1bnNpZ25lZC4NCg0KPiBCZXN0
IHJlZ2FyZHMNCj4gDQo+IEhlaW5yaWNoDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lLg0KSSB3aWxs
IHJld29yayB0aGUgY29tbWVudHMgYW5kIHN1Ym1pdCB2NS4NCg0KRGluZXNoDQo=
