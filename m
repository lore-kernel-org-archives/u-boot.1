Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C935C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983B38210D;
	Tue,  6 May 2025 16:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="T0oORXJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7EF82905; Tue,  6 May 2025 14:50:06 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c004::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B048210D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 14:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZivLysLbyvPm/L/HaVWWkc8SYicoJu2F9fjt6dI96L7d9iMpJ+7mMapA3PA2Y5SKRkrI6VgDVGF1kxK/HEQ5RqLKQ5sWgs0piBkWWspKOjB4qkpQOKYk+QN8jswiLBr9XWqFnijFbzgeQmeYYP642n60y432xeaJVWOjlRB7Rz0JpbHtk5sFu8QkJ5h5jbFx2lYAf+tKCb6/aqNUml1MR++HfeaAAzW3EFAUqDQ21eTY65WfV1btqUmN37rqDLP41b8M4yhqO8DpVJegTb/fj9dffjc516g6dOXR2A3NpaSQm3twrG9nrqJDe88KGWNhDM/gu0QtK6yOcuveXHp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz+8jpwUnPH/98GILMQjPnuuOdJKAYwBL5XUjCZoTWU=;
 b=kVa6Ve4AVZVRwpDFcx6Xc7g57Xfz9+FrAsIU1j6r8PsAS460fBRek5JLIba+J2jOC1Qh2plVXt3U5Q/f+0llE6Q4DZNn2SGjtC68RL46Wyu8zxquNRhF+oiIs/RySlWNt1zY4NfvJ/Dq7tSJON6OKcuJQRcgDaYHewTIbtnyYx+ubbRyEDUYK74VL5iDft9ga/ZMGy07e6sGl4M/CFgHi2V+tbwFG6xNHnbgCF9Futr/lZZ/7X5tVNV6sLvrxngcHfrGZDVfgKcUR/+7EeJwb///Wh5phos86EWkG3x4JJrcpXD5DtcMCaOzSC1tQH5Mq+qjmsn9oJMr/4RjU40jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz+8jpwUnPH/98GILMQjPnuuOdJKAYwBL5XUjCZoTWU=;
 b=T0oORXJDukGVO878Ow0nmHc8MCwYWIYSDLjj0nzbYaLLTkPr98+3VSGRi6Yo97WPWcNjMVM3wc8YDYHsy15MUtnwCDSKtUvLbwGXohFo1w9qw/krRNYWN4tsGAdSPyb7Y1Nx4lUEFyXwvT1ztUtWWeY0rks+HDq51O9T5foeg7Q=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by DM8PR07MB8776.namprd07.prod.outlook.com (2603:10b6:8:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 12:49:56 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7%4]) with mapi id 15.20.8722.018; Tue, 6 May 2025
 12:49:55 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Thread-Topic: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Thread-Index: AQHbu5Fxz0lwA0vEHUqimb5OZeGX1bPAKfeAgAQwhgCAATefug==
Date: Tue, 6 May 2025 12:49:55 +0000
Message-ID: <SJ2PR07MB9711B7D339A7C25641310B018189A@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
 <20250505180916.GH5430@bill-the-cat>
In-Reply-To: <20250505180916.GH5430@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|DM8PR07MB8776:EE_
x-ms-office365-filtering-correlation-id: 25efbce1-9f5b-4041-0cd3-08dd8c9c80ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UzNZbDNOYlhnMkpzVzlHdUd3RitrUjVPQUdrS3RWQWNqM2JTc3ZvWVBZNWFN?=
 =?utf-8?B?Zldzeng3U3dicW1oeEY4MjYvdGhFa1hNTjg4dER6Skh3NWtWUWJBNEY3SjNW?=
 =?utf-8?B?QnB3S3Vtank2Nk9pVEtNOG43dVFVbDlmOXhPOGYvWThIekduL2QzU05GUnll?=
 =?utf-8?B?TU1KVG9VR2hkdUN1ZlZiaG4xQ3AyRHVvNFY5bWkyV1A5ODFWaFBwTDZvWnBl?=
 =?utf-8?B?RnIvN0d4NjA4TFQydXA0dFVVT0JnNE53UG1Td3BBa0JuTS9MY1hJbVNCeElo?=
 =?utf-8?B?YXdNeWh1c0VPQW41V3NFekc3bC8rQnVHRGp6dDNHcng2TnBSZVRPemZqYTFy?=
 =?utf-8?B?VUl1VWpMOStjdGJOckJJMUxWWHhGbE1DNzlRUGdVZXZaVjZTVGs3NDB2Qk5K?=
 =?utf-8?B?NUNldmhLMklyMUhDbDVDcUVkVHRjTDlnckdCaW94VEF5OFY4emN4U3lISUc3?=
 =?utf-8?B?WGNxRWxhdGU0OG4wa0JNanlBaisrUlo3Vld1R2dJVCt1L291bmlUdzJta2pS?=
 =?utf-8?B?NEdodW5xWUF3VW5BU2JMSGt5YmVEUk92bFpicEJMckNrUnBHWXFhZm5QNHpj?=
 =?utf-8?B?cTMyUXNxazUvUFV1V0NvN1hjNjZIU0s3T2hORi9XRUQrSytQa3BKY1JLazlJ?=
 =?utf-8?B?bGhKU1VjRHVaczcwKzMweWhpbTRZN2NiMFFNZWhZL2g0QjFQRFpKYVM2VUw4?=
 =?utf-8?B?OXNET2h0OXZYMzhwOGVWcDlrd1RzeDlCdkJCRy9JcDF6UHp5MlBOMDFudWc2?=
 =?utf-8?B?TCt4VlVYMXlMcU9VUlNnendhTXp3R2pmaEFsU21HTTIvZTdWZ1dDbzBJaGsx?=
 =?utf-8?B?bGMrdkM4TERUdjJaSDVrME9mQm0wZ3lMeDlZYVlRL3F5d2pEMXd5YUtXTk92?=
 =?utf-8?B?Nk5rSjJHZWkrSzRhVTF5NFAxUFRScnVPVklzeURSR3dsS2FtSE5qRnBzbllQ?=
 =?utf-8?B?VWFWOHlKNVZya3EzakhEWDZydUJ2VFdGV3Nad2lueUxFeXovd290Q0tyZ0I1?=
 =?utf-8?B?NWY3OWhudzhIbC9uRWRuMFI5TjF0eUVaVXAzRmpMUVB0emJWTmhoK21aeTVh?=
 =?utf-8?B?UXNaL1RHcFZPSkFkRERPVWRHZ2U2TW0vN3VYZnZCQ0xWN1BVUlFzaVFJb0dt?=
 =?utf-8?B?UXY1NnJBQzRCRk1WeUtkbVhFVHp3bzZWL25lcXpLN0hRMVU5UGl0MGJTekxF?=
 =?utf-8?B?RHRTSlArazNxRlNBOTl6QW1VTFQwdU9kYmk3TjlhQjBQbHJKaUR5OWVlSmds?=
 =?utf-8?B?bXNQRzVNb0dBMmxaVlFVSWF5T0RVYzRaeDRQZHVKTUtDczFlalA3RUJKSTJm?=
 =?utf-8?B?N0ZhdEEwT0JBQzZnWlJuZytJcE5FQXEremlYRG1YTDBrbVJMcFFROEdCNURR?=
 =?utf-8?B?K0luQ1dFUWVoVFZzRTQ1eG1IblFEZytmZmFDbWlOaUVIRmxNeitEWG50aURG?=
 =?utf-8?B?bjZib1pyU1JGUmhHVGdhSzhTOHVLN0dndXVpMCs2cGphcWNOL05DalB0bSt3?=
 =?utf-8?B?eHZhUThKQ1RhY29jSVlCVUozeUdxTjBiVEpmaHNvdWJvV0lhaVNWMFJxSE84?=
 =?utf-8?B?WEhXbkNZNW9YOWxZQjAyTkF3YUlGK1pUNENqU0NGWVVMbStWZHBaYVV0aXAz?=
 =?utf-8?B?eDBRdUs1blVIQnU0U2hlUjFWUjZiMklHSnNGN1hGQjVEOVVSZjR6SExXM1Zw?=
 =?utf-8?B?UTJ1MVprMjFpcU9rUmxkbFo1NlhETjVaWEFNNklQeVovRVRrZzlSRWhwSjNh?=
 =?utf-8?B?c20xRko3WVN3S1BIeGhjMFNBSGFvRjBOTDdiZlFuREIyZVlHTi82QUJFN25E?=
 =?utf-8?B?Vmg2STA4VHEvR2FYVnpSeG1mWmNEWFA1WWVSQ0RBdStlSTcwUXBLODBZUVZP?=
 =?utf-8?B?ZGRWUkpNc0FQVGttQitITHQrRzlub2prUmcvYitxVGMwVTBYY3RiMlBOUnBS?=
 =?utf-8?Q?VWzO/Qf2H8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21STjN4cHhTS0NpYlVST2RvRmZ1OTJUbXFaRndPVjVtbUxlSlI0TlQzaSsz?=
 =?utf-8?B?eVUvYVkydG03WStrL3EyK1pXa1FPL0lpUHF1VTl1L0M3dDVpN1VBcDlEMWtm?=
 =?utf-8?B?WklUUGlJTlBzUmxtemc5UW0wMVBhTU43WmpVRGNuWlc0b3lvRVZWckhMWnRR?=
 =?utf-8?B?N010M2tqQ0diRWVMR0ZUTjIyeGFCK2ZKNlBTMWdFVGNuOXNpNkNkSW1NbW55?=
 =?utf-8?B?aVg1V0Q5eSt1UzdLZUNmTi9MOGRoUkZkZzBlQXZlc3o0QzRHUzJ0VTFRTHhO?=
 =?utf-8?B?c2ZKR0oyTDk1UzBMbU90clFyMVArbkZTSzF0MnoxbmoybE14NGdqYnZXakI0?=
 =?utf-8?B?N0xzcDA5OVBNWVIzcGp1RmZ0dm1yWktqOVZJOU9ZUk8zU1E1UVhmZm1EMmpU?=
 =?utf-8?B?Mk9pOEE3TGFjV1JMUi8yR25NSDlzTGtEblhDSmFDemQ3TC9vZjVGUldCa0Vs?=
 =?utf-8?B?UW82L1daQkVYK1E2ekY5d2RGNzY0cWE4VHpEYlozVUoyNndzOHRCM2c1OXMr?=
 =?utf-8?B?VGVlN3FNTVowb0Z6TithT01qcmtvTDhyNk1vdmdSeTNRUDhIN2lGQndoUGhQ?=
 =?utf-8?B?WlphNlB4YVdjYjVBRDZheWlVWVVENnRZMkVlTnBnLzVTRGZkV1ZweFZhY2lr?=
 =?utf-8?B?SEZaTHg3V3lIRS9oNXdoWExCZzN1b3gwLzV3eWJ2bUJZN2ZyZTY2ZXg2bmlF?=
 =?utf-8?B?RzgvcWUwUkRLUnRKcHk5aWl6SUpxTTVzaEJNZitVVkxsb3QvTUt6SWp2V1Fy?=
 =?utf-8?B?dEZQTXN3Zld6NXVjaEtBMU9MQkZxQnN0K2UyRU9EZVVXTk55aFkwQnR5c3d6?=
 =?utf-8?B?Y3hhYytKaVljRklhM0ZZWHJHdHlwUGlib2h0T0FCRGpmRmRHdG5yR3RtWlhw?=
 =?utf-8?B?NXpKMFZReVgzTFFIdnJkR1ZzT29EQUlUN3ZZY2xYbHRYWnQxSjBnenNhcW1M?=
 =?utf-8?B?RThGcklhYVF3MTNvQW5VM2pidjZZcTNUNG5UT0d1VzZkc1F1WUxqbDVSY3Jz?=
 =?utf-8?B?WmppQ0hzMHJ2Rnpzak9nNDAwR1gwZUFKNXhFZGozendac29tS3MxNHFTdU5x?=
 =?utf-8?B?ZUhyZVdESGw1eHpzVDFSVzBDditxdVRwYzNWSU42cTUzcmhsNHEwNXBKRm83?=
 =?utf-8?B?MWZWVU4xZFNPQU5nYjB3ZkpZckl1YVM4SDY3MVRWU1JRZVd0MWhsR3ZRTkN0?=
 =?utf-8?B?aDFkMUhJYXNUeDZNMkEvYUxBeXZmU0tCMmc0KzVseTlia0Rmb0RyRE9ZMGw4?=
 =?utf-8?B?VFBoYzN1c0U0WklyNFpnRDlSYkRWRGNrWHlMM1BSZ1kwcEtRTVJqbkJzVDFu?=
 =?utf-8?B?ckcrcWwvU2NNMU5CZjRHM0lqQkFCK0doanlSc2ZBV1FoY3A2dFIvQkFkRXZr?=
 =?utf-8?B?bVVFQS8xcWQ0emNEbTdCdExNMlFUV0xYc2ttUGZlT0xnS0tZUEVoU3J1VURm?=
 =?utf-8?B?S2pkSnBkcWRQUlZaNjFuWko5N3lYUmVkVWZscUlZYUlPNk53ODlSOUQrWjJh?=
 =?utf-8?B?YjNUZ05OQVZQQ2EwWHluUVhacVpZT09SYkFLOFd4SDRTQlQ2bGFWWG1pSWJ2?=
 =?utf-8?B?OGk5dHgyRU1BZHQ3TjJVOHlUb09VNmlDY3I3dFYwVUMzcTR0YmxQQUx1Mjd6?=
 =?utf-8?B?bVNJek5pMlpVL2IvL1NSVVBla3pLd1JSZTJXV3U3eWJReVJPQkVKRmJRN2dn?=
 =?utf-8?B?aGQ0TGF2SlNZTm5vMi9FeUFkd1Uxd2hUNXFUaFpzaFJRTFhGZHBYSTBBUGVS?=
 =?utf-8?B?SzY1UkM0bFR0YzZ1Y2o1NnQ0eVg1K3NJNmZXNVU2NmlDOWF1Z0Nwa0MxQWJW?=
 =?utf-8?B?aXhNL1FOZ25weUMxaEFZekhwL3JGa21qUzV3TlFTQkNVRXJlSlkvZUNYZTcv?=
 =?utf-8?B?UEFtb0czZi9MakFrVS8wUU9vaFNYWkh0N2hmejJpYUtHazhZWTdQOCs2Y2lv?=
 =?utf-8?B?T01PbWdIR3lpTTlFTkxFSXhMVmlKRzRhdEFEUVozZTIxM000ZVRmR2g3QWJQ?=
 =?utf-8?B?eURycTZuWUpka0JQWXZWRnhPV0MyTks4YXBreVlad1dRQjNGQnFrMU5WWGl4?=
 =?utf-8?B?SHZKcGJ5WGpvcFFLSmVEZ3VyK2Z6L2hGQW5NVXloazBGTUhmWm5aSG9tV3Bz?=
 =?utf-8?B?VmVEa3cvc2lQUitnUUJqWHlaWmdZc1U5TUxNUGp0Q2hQeG5xRWl6R2llaXV1?=
 =?utf-8?Q?zaL83IwOkzyMrnV0DN4SRC0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25efbce1-9f5b-4041-0cd3-08dd8c9c80ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 12:49:55.7978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1pt47gopRjJTgGIcp0IKoos+c1vYV6ixA4XH0YJU4Z1hGN0TjhMuLWuqULEAUGBy3iVIA7Lzwcx1DdHrC10WL+gzNajXqx9uY9xfeeKSbzY36038CDNRZj9OtyRBuBBrUaxyBsiD/t6tMC7JMIZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR07MB8776
X-Mailman-Approved-At: Tue, 06 May 2025 16:42:23 +0200
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

SGVsbG8gVG9tLA0KDQpUaGUgbGluayB0aGF0IFNpbW9uIHNlbnQgZG9lcyBub3QgYWRkIHBhZGRp
bmcgYXQgdGhlIGVuZC4gSSBoYXZlIHRyaWVkIHRoZSBhcHByb2FjaCB3aXRoIFNZU19GRFRfUEFE
IGZpcnN0IGFuZCBteSBwbGF0Zm9ybSAoaW14Nikgc3RpbGwgaGFzIGlzc3VlcyB3aGVuIHRyeWlu
ZyB0byBtb2RpZnkgdGhlIGRldmljZSB0cmVlIGZyb20gdGhlIGJvYXJkIGZpbGUuIEl0IHN0aWxs
IHJldHVybnMgRkRUX0VSUl9OT1NQQUNFIHdpdGggdGhhdCBvcHRpb24uIFRoZSBjb21taXQgSSBz
ZW50IHNpbXBseSBhZGRzIGEgS2NvbmZpZyBvcHRpb24gdG8gc29tZXRoaW5nIHdlIGFyZSBhbHJl
YWR5IGRvaW5nIChwYXNzaW5nIHRoZSAtcCBmbGFnKSBvbiBtdWx0aXBsZSBwbGF0Zm9ybXMgYmVo
aW5kIHRoZSBzY2VuZXMgdG8gdGhlIGRldmljZSB0cmVlIGNvbXBpbGVyLiBJIGhhdmUgdGVzdGVk
IGFuZCBwcm92ZW4gb24gbXkgcGxhdGZvcm0gdGhhdCB0aGlzIGFsbG93cyBsaXZlIG1vZGlmaWNh
dGlvbiBvZiB0aGUgZGV2aWNlIHRyZWUgaW4gdGhlIGJvYXJkIGZpbGUuDQoNCg0KRXJpYyBTY2hp
a3NjaG5laXQNCg0KU2VuaW9yIEVtYmVkZGVkIExpbnV4IEVuZ2luZWVyIElJSSAg4oCLDQoNCg0K
DQpOb3ZhVGVjaCwgTExDDQoNCjEzNTU1IFcuIDEwN3RoIFN0cmVldCB8IExlbmV4YSwgS1MgNjYy
MTXigIsNCg0KTzogOTEzLjQ1MS4xODgw4oCLDQoNCiAg4oCLDQoNCm5vdmF0ZWNoYXV0b21hdGlv
bi5jb208aHR0cDovL3d3dy5ub3ZhdGVjaGF1dG9tYXRpb24uY29tLz4gfCBOb3ZhVGVjaExpbmtl
ZEluPGh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55LzU2NTAxNz4NCg0KUmVjZWlwdCBv
ZiB0aGlzIGVtYWlsIGltcGxpZXMgY29tcGxpYW5jZSB3aXRoIG91ciB0ZXJtcyBhbmQgY29uZGl0
aW9uczxodHRwczovL3d3dy5ub3ZhdGVjaGF1dG9tYXRpb24uY29tL2VtYWlsLXRlcm1zLWNvbmRp
dGlvbnM+Lu+7vw0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBU
b20gUmluaQ0KU2VudDogTW9uZGF5LCBNYXkgNSwgMjAyNSAxOjA5IFBNDQpUbzogU2ltb24gR2xh
c3M7IEVyaWMgU2NoaWtzY2huZWl0DQpDYzogdS1ib290QGxpc3RzLmRlbnguZGUNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIFtSRkNdOiBkdGM6IEFkZCBLY29uZmlnIG9wdGlvbiB0byBwYWQgZGV2aWNl
IHRyZWUgYmxvYg0KDQpPbiBGcmksIE1heSAwMiwgMjAyNSBhdCAwODoxMDozM1BNIC0wNjAwLCBT
aW1vbiBHbGFzcyB3cm90ZToNCj4gSGkgRXJpYywNCj4NCj4gT24gRnJpLCAyIE1heSAyMDI1IGF0
IDE0OjA2LCBFcmljIFNjaGlrc2NobmVpdA0KPiA8ZXJpYy5zY2hpa3NjaG5laXRAbm92YXRlY2hh
dXRvbWF0aW9uLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHdpbGwgYWxsb3cgYXJjaChzKSB0
aGF0IHVzZSBkZXZpY2UgdHJlZSBibG9icyB0byBwYWQgdGhlIGVuZCBvZiB0aGUNCj4gPiBkZXZp
Y2UgdHJlZSBzbyB0aGV5IGNhbiBiZSBtb2RpZmllZCBieSBib2FyZCBmaWxlcyBhdCBydW4gdGlt
ZS4gVGhpcyB3aWxsDQo+ID4gaGVscCBwcmV2ZW50IGVycm9ycyBzdWNoIGFzIEZEVF9FUlJfTk9T
UEFDRSBmcm9tIG9jY3VyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXJpYyBTY2hpa3Nj
aG5laXQgPGVyaWMuc2NoaWtzY2huZWl0QG5vdmF0ZWNoYXV0b21hdGlvbi5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAxMSArKysrKysrKysrKw0KPiA+
ICBhcmNoL2FyYy9kdHMvTWFrZWZpbGUgICAgICAgIHwgIDYgKysrKystDQo+ID4gIGFyY2gvYXJt
L2R0cy9NYWtlZmlsZSAgICAgICAgfCAgNCArKysrDQo+ID4gIGFyY2gvbTY4ay9kdHMvTWFrZWZp
bGUgICAgICAgfCAgNiArKysrKy0NCj4gPiAgYXJjaC9taWNyb2JsYXplL2R0cy9NYWtlZmlsZSB8
ICA2ICsrKysrLQ0KPiA+ICBhcmNoL25pb3MyL2R0cy9NYWtlZmlsZSAgICAgIHwgIDYgKysrKyst
DQo+ID4gIGFyY2gvcG93ZXJwYy9kdHMvTWFrZWZpbGUgICAgfCAgNCArKysrDQo+ID4gIGFyY2gv
cmlzY3YvZHRzL01ha2VmaWxlICAgICAgfCAgNiArKysrKy0NCj4gPiAgYXJjaC9zYW5kYm94L2R0
cy9NYWtlZmlsZSAgICB8ICA2ICsrKysrLQ0KPiA+ICBhcmNoL3g4Ni9kdHMvTWFrZWZpbGUgICAg
ICAgIHwgIDggKysrKysrKy0NCj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPg0KPiBUaGlzIGlzIG5vdCBhIGJvYXJkLXNwZWNpZmlj
IGZlYXR1cmUuIFlvdSBjb3VsZCB0cnkgdGhpczoNCj4NCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3ps
YWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjQxMjA2MTMxMTEzLjI4NjU0MTYtMy1zamdA
Y2hyb21pdW0ub3JnLw0KDQpTaW1vbiwgY2FuIHlvdSBwbGVhc2UgcmVhZCB5b3VyIGxpbmtzIGJl
Zm9yZSBzZW5kaW5nIHRoZW0gdG8gb3RoZXINCnBlb3BsZT8gVGhlcmUncyBzZXZlcmFsIHRoaW5n
cyB3cm9uZyB3aXRoIHRoYXQgcGF0Y2ggc28gc3VnZ2VzdGluZw0Kc29tZW9uZSBlbHNlIHRyeSBp
dCBhbmQgc2VlIGlzIG5vdCBoZWxwZnVsLg0KDQpFcmljLCBmb3IgeW91ciBwbGF0Zm9ybSBjYW4g
eW91IGV4cGFuZCB0aGUgdmFsdWUgdXNlZCBieSBTWVNfRkRUX1BBRCBvcg0KaXMgdGhhdCBub3Qg
dXBkYXRpbmcgdGhpbmdzIGluIHRoZSBjb3JyZWN0IHNwb3QgZm9yIHlvdXIgdXNlIGNhc2U/DQoN
Ci0tDQpUb20NCg==
