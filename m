Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D203C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 09:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D3F80BA4;
	Fri, 28 Feb 2025 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="6pS5odmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7F880FE1; Fri, 28 Feb 2025 10:50:41 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7501809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxX30/az6hMAym5snV3pG+40mSRHC6akpU1HI974cR0v4oNzbFtqC3ZtXG1VYIxnnPDxeE2+VAAg4Jy3ZroAefO9mFFGJwuabJJrFLbG12T0FvxQ1uVWLtWvhen9UWN5Edl82rzX6tZk6fvcNa5vem89l5BpszLXJdCO7LJRdwuNifyOc6TSncv2ZsTUJgO95/2XKeltWqVQCQ9AhVB7bbKL36oJgQyIBOCYJetZMkLkNmLVV3njbUJPJcWTNFVmI5pDDi2ElfqsjBorrTZEvG7Q90iOYjfEnWGVbONtDKYonMcaV+n4zII+RZKg9wPwfeyTbL+870kMhuUy6x6ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR9ndByesqaZltbh3MzCPJrVNF45A4nw4sQdcfzMyNs=;
 b=nhnCFFud87Ghtgsm+FGVBQNt3uZYD/LG299e2Kpwl3qjdVQCA8v4cdL/h4F8lMNo+MqI5AgVz5DWWsg9vORwqqytYv+c6V6e3SsfVJHVzDFmuBTy3MQJtCbckE+8MpxwnsUqMEtwheNUmJgee8Z/n/0QfkwYapcN2DQW1whMlfZot2kE+HwGfc9dSbR2dDVfymi+EuOEp6g8bSvrDO4swY2QDNrnBdYEui+dAQBhJodIkKFq/yXz8OFxpRwlssEPJu7hF1FNVxLWLUg07DpGv8WM+OIIraMrA9MzWUU/Q0p+MB19B6K/FBHvTW5sPeT93wwQ9nVMPLFmF5LGUjP95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR9ndByesqaZltbh3MzCPJrVNF45A4nw4sQdcfzMyNs=;
 b=6pS5odmm4KF0nGYr2cHQfdio4HF4GcEoItqJzMztFa9V9BLVnRqIEfoUkTpet4pm6NMMZ0d9Hk3pMxAxgBuQZC0dLkzwz5A5+tmBjeVUNIc9cgXJbrdaUxIlE0bsn/oz11m4xd9yiZcAFqpqWBJMCRIVWushJ/fBYSJeN0XqKSC1j9C2PTVH0ihTlmxDTkACduvTXVairPhu0cEQOo1DHyin3EPhhl1AWjbsjg8tT+QlpqojstVTn7GTvJunDEbraRjQ6ZYPzxdeGcmdEggR42CibO1p7GzV3pP0jMVKxGvy7DINet2uMJp5Xg/C+xOBc27Wu+vC6IRSjvyar9k25A==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:50:34 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 09:50:32 +0000
From: <Manikandan.M@microchip.com>
To: <eugen.hristev@linaro.org>, <sumit.garg@linaro.org>
CC: <lukma@denx.de>, <seanga2@gmail.com>, <kever.yang@rock-chips.com>,
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>,
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <Nicolas.Ferre@microchip.com>, <Mihai.Sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Topic: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Index: AQHbiPsjoBcXgMo1hUCbV6M9r8wp7bNa5k0AgAAO6ICAAD3FAIABR3iA
Date: Fri, 28 Feb 2025 09:50:32 +0000
Message-ID: <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
In-Reply-To: <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|SA2PR11MB4889:EE_
x-ms-office365-filtering-correlation-id: 37ed698a-0842-4495-2807-08dd57dd5763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?amtPblN3OW8rUFl2WC9vYm03WmFUNDJQVDNDTGN0QXMrT1BrQmR3ak1mVDlZ?=
 =?utf-8?B?WnRsdGxJWU9STTl5UmJvdGcwUzVjTEJGRXUzaDN0TXRma2lqZ1VHSDUvWE16?=
 =?utf-8?B?dmt1Zm5EallRS3BmMWQzUWw2K2NUdDhuRy8zd0t2MDNlbGRPMVBDc0ladE1u?=
 =?utf-8?B?d3BSR1hIM2dNQWR3N216NmwxRHFBMlByVkE2YngwOWdmRUc5cXhYdEtCcjNE?=
 =?utf-8?B?WnFqeGNReW4rNjFCT0phazhnWkFKNllFaXFueEd6enlDdWp0dCt0SzhGS1d5?=
 =?utf-8?B?d2tlaXdkQTg1UTYwYTNvSk16cFptNUw5OE9IWnNvQnVxa3BmVUsrWS9aT0VK?=
 =?utf-8?B?VnM3N0EyY25qdHpXa2tEcVJQdDRZNW1qRkl5TGt6VVJERnplTGYwYml4Z3Zu?=
 =?utf-8?B?NE1TU0dZOWoyc1grblcybnVSZUVDSFNpbWV3T09TcXNySTh6a0RnaGl0L0Jq?=
 =?utf-8?B?UW1tKzFYQmdSeFllaFR6YVFVd1FVQkluWVp1ZUFFV0lxYlhrZW9ZUlA5NzNE?=
 =?utf-8?B?YllySkY5NXlJcHRVMXJvRGpZazNJTitRTjZrVnBERS81d0xLK2RKeEZ0UWxp?=
 =?utf-8?B?UmpLM203dTM2dmhxQ24yUFljNmlQeCt6MDAzWVd5eVo4L2pYTUIxT2N4Sjhn?=
 =?utf-8?B?NlV1bjZxZG9LbGdNQlpCUDFDblU1aU94dERmdC9lajJ3SDBTVXFPTkcrdDdB?=
 =?utf-8?B?RzlmdDN6MC9RdDB3Q1VrNlk0R1JvbkdPV0pnSlhsUDVYa3BTZUp0VGNneEsx?=
 =?utf-8?B?U0NyaklYcjZIWFdwSjZxUHpTU21DU2I0bmtGTTVDVTEzNmlGMENBK01mTFZI?=
 =?utf-8?B?Qm5xS2krdG5rS1RlUitrYXBwZjZRbzkwalFCbjdBTHkzYm9ncUJ1c3lkSEpY?=
 =?utf-8?B?UXdqS3A4MytzKzY0UnZ0RVJsTlFpdHVCc0NaQWNKcm14aEptYjgramhvZ3N4?=
 =?utf-8?B?ZDFrc3RrdnlLSGFOek9RcUhoemxrSlJBR0RIbWgyQ2loemF4RnF1dWNFZTg4?=
 =?utf-8?B?cXJuVUNleTVSZ0l6a2NuOXBlYWEwQXNxUU9JbSs0SVVCMkFRNW9DblROdzZM?=
 =?utf-8?B?Y3hnOVVBbTVQbVVJUkVPUkZEWWUrZE1NVm9VSGRtU3htaS9xajRxWlQ0eWtB?=
 =?utf-8?B?YkRPSjBnMFM4dXJxZGJtYUdQeE9DTHIvVHRDUG0xbEdoMStRK3ZNclpRcnJB?=
 =?utf-8?B?TjJGOWl4eGZUNUltMllqeVFxbWJmKys2SkRUSUhNQUxZS0h5MElwV3AwUUtC?=
 =?utf-8?B?Z08xTDJLejdYRmM2N0FxckRyNWhjMGptNFVZUjd6SklPN2NJa2lndEtmV0ll?=
 =?utf-8?B?bkRGcXdLRmJsSVU5SThaMmtoZnljclg5c2VEZ1hVeUhyc1hWNER4SnFRR0hO?=
 =?utf-8?B?RGZKNS9tR1BXbjJxVjNRTXdqNS9Qb0tVOGNMQk1HTUNGd3hIVGd6NmVOTzF5?=
 =?utf-8?B?SlllVnZWM20yL1JsTE9YaFdMc3hZd3dRZ01lNjRpNHB3cjVvaHlDcUtQK3h4?=
 =?utf-8?B?T1lwczNoRE4rRnVtbndiWW9hYzRKNytxVjRQSXdVd3pHaVkvZC9ocHFZUXVw?=
 =?utf-8?B?c3E4MDJpTWlpN25hS0h5TzJiRFdDYVFpSXUxc3YzOTdaeUJkRi9mOGpNYWJq?=
 =?utf-8?B?djI1ak9qYlJaaks1YXZhMWl4cm9RdFdHVjNzNm1Id3J0OXVROGdtRjZ2S3Fz?=
 =?utf-8?B?RzB2Y0g3Q25JSUtGNDNOUTdXWUtnOVdsRXR4NXZycWhnclFLQThSU0JLT0Fk?=
 =?utf-8?B?eHNXalRFZVN6S295OC9TQnluRE1kMWErN05ONjd6L3BFelNyV1AzbkFvUURw?=
 =?utf-8?B?Z091UkNaVFdld2kyMFo1T2I3YVYxbHM4MEVpdWxVSjd5akNTMEdZSXVIM1po?=
 =?utf-8?B?eEE0MjdxVUttUWttRStWRGhtWU8vQXJlWENOQkVZbTJqZXgxWjZzUnEyZUhU?=
 =?utf-8?Q?NDSaYBF6Xit1baRge5kxnIHm3YPw8Cei?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJlZ004a3U0Zkw1elJnOXU4clZVSUxtazE4cVArdVJVNW90dDBKbzRkMUdx?=
 =?utf-8?B?b1RxNFhlSGlKQTlueVV4MUJ4YnBlZmVEa2hwL0xuVWdHeWJKVXBKUmNlajNQ?=
 =?utf-8?B?NTlJMS92K3QxZnlSV1ltenlHblF4ajBybExJWTByaHd4ZG54ZWVNeUZBckhv?=
 =?utf-8?B?VzI5Zm5OL2lvdTU4bVg4ZDdwZXRTd2xRTzZ5Rk5NZWJQaC9ZcmlIdkNoOThu?=
 =?utf-8?B?Q2dYUjJkaWxob2plODBxOUFsZi91VTJ2Q2QvMi9aTWppeVYvQTJ1SzUxOFBO?=
 =?utf-8?B?dFd5VU9oUnE4ZERXNEs2cXpTdWx0eklyZVRxZi84MVkwU1VvRDUzK2RDcU95?=
 =?utf-8?B?TmZHN3M1ZFJWU3JMM1JxSFJDZEZrOWtEcHdkUHI1NXB6ejFGRlBGU1RsdVFq?=
 =?utf-8?B?d3VKQTB6NDVEVXNoM2RKZVUyaUlwYllIeWhSUjVuSVp0dUlreWs5YXZiSCtG?=
 =?utf-8?B?Y2J0ZW9wRFlrTEk5eHhPUVJqUXVIZ0FXblh0Y2J2WEhxeG5hazBIQllZOXJM?=
 =?utf-8?B?K1BVNlNtaHZpZlVZSFhjSUsvOGdWazhMZVc1enNpQ2o0ZGY3a01mclozQ3pF?=
 =?utf-8?B?ZjAwWlJGaTAwRkJucnpkQWl0alluUnFqN2V0ZUUvOWtoeXZVVHZ4cDM5SVZ0?=
 =?utf-8?B?UEsrUzlZRzVYeVMxaTZKc0M4VHhHdFE4TitLMzNsYnN6aVhtMHRJaENibDRo?=
 =?utf-8?B?ZkZSeEI5TEdleWNNaGhjcGt3UzNTT1hrZlhxVmliMzdpYjBjMjBDQWtIRy9v?=
 =?utf-8?B?cWtWWEZVUlZjWVBPUExIS0lNMHhMd00wanQxUXpLU01pTmFNQkw1bUpZVzNr?=
 =?utf-8?B?SmtMd3Y1Z1Y0eWtoSS9Vb3FkR2lkYmk3TFJvM3RsemdYUDBqQ2xaTk1vZ3VD?=
 =?utf-8?B?UFd0blBhRlpBK1haUy9MNHNaUG9LVmdqTldBUExZQXZOc01uTmhCc2gwcjJQ?=
 =?utf-8?B?djN2SzVsSFl0VE9DWUQyUndiN1lQd2daUjJJR0RBMXkzSSt3S29oRlNWRzRt?=
 =?utf-8?B?MFBTTFhIcDVHNHk4VEFlZnMzN0dCUU1vaUNZdUQwSXQydGFudnEySmFCV3Bv?=
 =?utf-8?B?Wmx5RU5NNktSVlhOSllSZWNpL042aXFrcnFhVElCV2lOSEtWcDZ1NUVxdXpt?=
 =?utf-8?B?TWlzdEhrVlp4aDJpR09kSzVtOVBnYllDTlZ1UlEvMldUR1M3RktTSkxiVkRp?=
 =?utf-8?B?M0d2SnhNZkdKc2RIQlZGYzVFV0VCVjNGZ2dsbFVDSDBFYkNnNVFSMlJGcXRQ?=
 =?utf-8?B?Uk5oTUQ5WUZCemJ5UHN3NXFsL3I5eis0SUVUN0F2OVF2ZFhyU2xLcittc3pB?=
 =?utf-8?B?T2crYzYrMUJxZEdPdGk1UnVNakZoSHFOc1FUWEx4TFM2Rmh3NTh0cTF4dWpD?=
 =?utf-8?B?K25NOWpSdTdIT3FmR0hqL0o2d1l2MnY2SDFmTktMNVF1UkdXUGtTQVJINDZm?=
 =?utf-8?B?ZGU3MG81TGZrMzVOb3g5b2licW9XbVIveHZ0OVRMY09xS0NydEQ5NUp1Rktp?=
 =?utf-8?B?RHBOaHJyNG94MzNxSWp2YmYyY085NmFsaHRjNTF2cUI3TW40YkpaZHJ1M05k?=
 =?utf-8?B?YUJlSTRmR3ZYVWhFNkpYYTgreHlscE93dkhOMHFheEROWXJQVGNsNG5oTEVP?=
 =?utf-8?B?YTh5aHcxL3ZqcStScjlDM3pNV3dEeHl0Zm9QeUNubEcyajNJQ1VXaHRRWXRG?=
 =?utf-8?B?NFpLR1Y3M0NjaTlMK2FXdng5SkdvRzBiMFpRUFdDdHY3WHJobUhFbXpEZ2dN?=
 =?utf-8?B?QTR6dmJ6dTd0WDlOZzJtTy9uNlJCYjQrQVhlVi8va0pwZ1BYREo3dFN2VEE1?=
 =?utf-8?B?VHBuVUdESHlVb21Hc3hNZVI2TDNmK2JzSHFUTU5GY0c2S0ZDU2JpaDBDTjk1?=
 =?utf-8?B?YW1NbW1ZSFFaSG8rL1pZWlhaT1ZlQlZld0xSS1hkeG14N3ZHTXF0VFN1UnNz?=
 =?utf-8?B?NXdqdzFCZmJZTVVYYkl6VXBWTDVlaURJdzBwZkxzZW1DT01HaTZGWS9hNVNa?=
 =?utf-8?B?dm4rODZuR1hQdjNXWCtDZm00NDZoZ3hPQjRCRW9PSzhBNGExME9OTVpKeWts?=
 =?utf-8?B?N3AvK0w2NTdQL0NmNkFVSlozNGZSS2Q0VnZSOHNRNy9USU42UjlOcG8rV1pJ?=
 =?utf-8?Q?iVJSFGIsn6bfpoJ/6j7lcK5GN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0860DB4382C06409AC0056FA5EF849A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ed698a-0842-4495-2807-08dd57dd5763
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:50:32.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eygmpZzN9mkZfmKK/TOC9H4wXZkATCfkhKlyzp3vPyci6CQPeC0Wt9A0/vXn1lDlHOuOA2wptK3G2BgA4il82LzkEXIF5ZnjqduOh7fN1fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
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

SGkgRXVnZW4sDQoNCk9uIDI3LzAyLzI1IDc6NDggcG0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMi8yNy8yNSAxMjoz
NywgTWFuaWthbmRhbi5NQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSBTdW1pdCwNCj4+DQo+
PiBPbiAyNy8wMi8yNSAzOjE0IHBtLCBTdW1pdCBHYXJnIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gVGh1LCAyNyBGZWIgMjAyNSBhdCAx
NTowNiwgTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4NCj4+PiA8bWFuaWthbmRhbi5tQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+PiBBZGQgUE1DIGNsb2NrIGRlZmluaXRpb25zIGZvciBN
Q0sgYW5kIFVUTUkgd2hpY2ggd2lsbCBiZSByZXF1aXJlZA0KPj4+PiBmb3IgdGhlIHNhbTl4NyBP
Rl91cHN0cmVhbSBEVCBzaW5jZSB0aGUgY2xvY2sgZnJhbWV3b3JrIGlzIG5vdCBpbg0KPj4+PiBz
eW5jIHdpdGggTGludXggYW5kIGFsc28gaW5jbHVkZSB0aGlzIGhlYWRlciBpbiAnY2xvY2svYXQ5
MS5oJyBmaWxlDQo+Pj4NCj4+PiBZb3Ugc2hvdWxkIHJhdGhlciBkcm9wIHRoZXNlIGxvY2FsIERU
IGJpbmRpbmdzIGhlYWRlcnMgd2hpY2ggd2lsbA0KPj4+IGFsbG93IGR0cy91cHN0cmVhbS9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaCB0byBiZSBpbmNsdWRlZA0KPj4+IGF1dG9tYXRp
Y2FsbHkuDQo+PiBPdGhlciBTb0MgRFRzIHdoZXJlIE9GX1VQU1RSRUFNIG1pZ3JhdGlvbiBpcyBu
b3QgYWRkZWQgeWV0LCBkZXBlbmRzIG9uDQo+PiB0aGUgbG9jYWwgRFQgYmluZGluZ3MgaGVhZGVy
LCBkcm9wcGluZyB0aGlzIHdpbGwgbGVhZCB0byBpc3N1ZXMgd2l0aA0KPj4gY29tcGlsYXRpb24u
DQo+PiBXZSBjYW4gZHJvcCB0aGlzIGFsdG9nZXRoZXIgd2hlbiB3ZSBzeW5jIHRoZSB1LWJvb3Qg
Y2xvY2sgZnJhbWV3b3JrIHdpdGgNCj4+IExpbnV4Lg0KPj4+DQo+Pj4gLVN1bWl0DQo+Pj4NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5k
YW4ubUBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbGsvYXQ5MS5oICAgfCAzICsrKw0KPj4+PiAgICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2F0OTEuaCB8IDIgKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xrL2F0OTEuaCBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvY2xrL2F0OTEuaA0KPj4+PiBpbmRleCBhMTc4Yjk0MTU3Yi4u
MDE2YzZlMGM2MjAgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xrL2F0
OTEuaA0KPj4+PiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsay9hdDkxLmgNCj4+Pj4gQEAg
LTI0LDQgKzI0LDcgQEANCj4+Pj4gICAgI2RlZmluZSBVU0JfVVRNSTIgICAgICAgICAgICAgIDEN
Cj4+Pj4gICAgI2RlZmluZSBVU0JfVVRNSTMgICAgICAgICAgICAgIDINCj4+Pj4NCj4+Pj4gKyNk
ZWZpbmUgUE1DX01DSyAgICAgICAgICAgICAgICAgICAgICAgIDENCj4+Pj4gKyNkZWZpbmUgUE1D
X1VUTUkgICAgICAgICAgICAgICAyDQo+IA0KPiBXaGVyZSBpbiB0aGUgcGF0Y2ggc2VyaWVzIGRv
IHlvdSBuZWVkIHRoZXNlIGRlZmluZXMgPw0KPiANCj4+Pj4gKw0KPj4+PiAgICAjZW5kaWYNCj4+
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oIGIvaW5jbHVk
ZS9kdC1iaW5kaW5ncy9jbG9jay9hdDkxLmgNCj4+Pj4gaW5kZXggYWIzZWUyNDFkMTAuLjcyMzVi
M2JhMDFlIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEu
aA0KPj4+PiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaA0KPj4+PiBAQCAt
Niw2ICs2LDggQEANCj4+Pj4gICAgICogTGljZW5zZWQgdW5kZXIgR1BMdjIgb3IgbGF0ZXIuDQo+
Pj4+ICAgICAqLw0KPj4+Pg0KPj4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsay9hdDkxLmg+
DQo+Pj4+ICsNCj4gDQo+IEkgZmluZCB0aGlzIG9kZCB0byBpbmNsdWRlIG9uZSBhdDkxLmggaW4g
YW5vdGhlciBhdDkxLmgNCj4gDQo+IExldCdzIGNvbnNpZGVyIHRvIHJlbW92ZSBvbmUgb2YgdGhl
c2UgZmlsZXMgaW4gdGhlIGZ1dHVyZSwgYW5kIGhhdmUganVzdA0KPiBvbmUgdGhhdCBpcyBpZGVu
dGljYWwgd2l0aCB0aGUgYmluZGluZ3Mgb25lIGZyb20gTGludXgNCj4gDQo+IE1lYW53aGlsZSwg
bGV0J3Mgc2VlIHdoZXJlIGRvIHlvdSBuZWVkIHRoZSBQTUNfKg0KVGhlIFBNQ19NQ0sgYW5kIFBN
Q19VVE1JIGFyZSBkZWZpbmVkIGluIHRoZSBkdHMvdXBzdHJlYW0gc2FtOXg3IFNvQyBEVC4NCnNp
bmNlIGR1cmluZyBjb21waWxhdGlvbiB0aGUgY2xvY2svYXQ5MS5oIGZyb20gdS1ib290IGlzIHVz
ZWQgYW5kIHRvIA0KcmVzb2x2ZSB0aGUgc3ludGF4IGlzc3VlcyBJIGhhZCB0byBkZWNsYXJlIHRo
ZW0gaW4gY2xrL2F0OTEuaCBhbmQgDQppbmNsdWRlIHRoZSBoZWFkZXIgaW4gY2xvY2svYXQ5MS5o
DQoNCmlmIHdlIGRyb3AgdGhlIGNsb2NrL2F0OTEuaCBmcm9tIHUtYm9vdCwgdGhlIHNhbTl4NzUg
d2lsbCBwYXNzIHVzaW5nIHRoZSANCmluY2x1ZGVzIGZyb20gdXBzdHJlYW0gTGludXggYnV0IHdp
bGwgYnJlYWsgb3RoZXIgU29DIHRoYXQgaGFzIG5vdCANCm1pZ3JhdGVkIHRvIE9GX1VQU1RSRUFN
IHlldC4NCg0KT3Igd2UgY2FuIGFsaWduIHUtYm9vdCdzIGNsb2NrL2F0OTEuaCB3aXRoIExpbnV4
IGFuZCBkcm9wIGNsay9hdDkxLmgsIA0KcmVwbGFjZSBpdCB3aXRoIGNsb2NrL2F0OTEuaCBpbiBk
cml2ZXJzIGFuZCBEVC4NClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGF0IHdvcmtzLg0KPiANCj4+
Pj4gICAgI2lmbmRlZiBfRFRfQklORElOR1NfQ0xLX0FUOTFfSA0KPj4+PiAgICAjZGVmaW5lIF9E
VF9CSU5ESU5HU19DTEtfQVQ5MV9IDQo+Pj4+DQo+Pj4+IC0tDQo+Pj4+IDIuMjUuMQ0KPj4+Pg0K
Pj4NCj4gDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0KDQo=
