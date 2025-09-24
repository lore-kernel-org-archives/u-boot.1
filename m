Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7417CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB9083071;
	Wed, 24 Sep 2025 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="RSNST4i5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE0B82998; Wed, 24 Sep 2025 13:04:56 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B0A8004F
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyN8aPULJ0qXlJrtoYVMeAx2tzQsOuoLWtCHueF3rOyKH1EupaaLhp8iC7wBkfqdJEJW2Q+F1X2m1lD/oQpj+pOqGeoGum2xCCsFdMDzWqeBAxW6rfcjLs5fcvhlHW2Ac+SJ854DHlw6TbvIT9Sx5I0RqRHid023Qp7ZSCR8C1oRHJOtCt+deA+MNior4pNAsOThwvI25C3VP+NpuCzeqMi6XBE78K+3XN01bfLWag99OoI2mrEur/CVzbvz1NnhQPOt67FGQVNd3impSHB3VMmFokh6ANwjgzFCCFVR8SU2+paq2vdaQ2n18dPW5wAgyzLiD4Fb8/XVOGlaxseIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snuFO6IuZWr3mnAb6hmMIpat4ljn4onyWRPEa/AqAsI=;
 b=SZOLuzQ323KxuUP6ZXgJYVyWeL7SOJelWCa3mbmg9FdDJyGkgId1LhXoNeGsfYvKl4k+lNki9Fe3zyMvq3VctHoQNeh/R0psYKrWBfTst12YmNcnrV0CIp0wvVef4yclfDf7PxqRgkV2rCU4vl7ltd0eImrHc1Qma0zSBBI5Kwn38FshK+LgOXovE0+pwik7PxZxzIaUtd0hEIgl8rNqS2YvfJ/7W7TKl5OP2xWCz92u7kRSmEoovDpMm2yWsc4LtCUzaVy0Hyn4B0mrCZ8DDQQhZCH7zjgDcJG4PmhhGs9RZPFlwSQVyKnq3mi5Tv7UYTvM9EZsJE6iQvqRc3r70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snuFO6IuZWr3mnAb6hmMIpat4ljn4onyWRPEa/AqAsI=;
 b=RSNST4i5nDZL0csJneRXFGNvAhojb7MNQhpPLlnU7OtboCEGgIH/LT+HU2FViCworRTbp2gYp4/gUdff4ek1JnH2qdpLlrfrRVCEuZflc8P30FpWwerXugUCWQLTRuYA6JtI4iHu9KFV8ssImvTuqNQoxQX/BDQg9xsnfAeTUFBdanrCB10beXLBG7VyETM1buysCeqCcc8we6SLFAJmL+C8zVicasanegGp6H9f3D7en9prkvA+wQT0oPYdTKduUYrzdrbJ7u4z9UE2uIthDRpA/IzbWcqFNDIboXGeuZ92/RrGicX1/27Xj4oG5rjXjUxVy1i0DT2ByXnQNpP6nQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AS8PR09MB6043.eurprd09.prod.outlook.com (2603:10a6:20b:56a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 11:04:44 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:04:43 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcLUMI755g8v3+TUu2mRAce3sZAg==
Date: Wed, 24 Sep 2025 11:04:43 +0000
Message-ID: <c2e28cdc-5975-441e-97be-e59ad42f4d4f@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AS8PR09MB6043:EE_
x-ms-office365-filtering-correlation-id: 66d2b57b-7d43-44ad-3b8e-08ddfb5a2a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NjlGekFrUHVRWS9DR0t0RndJTjFkV3dvYUU5Rm1SWVJ1Z2ZJOVZMUXNWc2hI?=
 =?utf-8?B?dkpGNXJBbmp3Qjh1TjdFN0g5THNoSi9ud21aUjJsVFNIcDNWeUZCNmVGZGh5?=
 =?utf-8?B?ZEJOSmFDZmtBdXY2ckVvN1g3WlhkTXJGK05xc1drbGNhbEx4ajlBVzQrL1Fm?=
 =?utf-8?B?TVpWU2cwdTdQa1UwYzB6Ni9UL0RVTFNNWDRrcU9SME1wZEFkcXBWcU5kWTJs?=
 =?utf-8?B?NEYrMndJOUJVaWUwNDB6cmxUT3QzbGVjSXd2Nkt0YzRqR0tkR09TVFZBL1E4?=
 =?utf-8?B?NWtCdmNkNDdJTHZla2MzNEM5TTNFZkZBem50bjFZdzlneGxKZTRNWU1Vck0x?=
 =?utf-8?B?ZEdWUVRVcy9taVZtbUJDRUttY0ZockhiU2tyZ2dLS0traDZSS0tSV0djemV6?=
 =?utf-8?B?NkVjV0FSaGFDQmw1Q0t6eSticTQ2enhoUGJqWVpBQ2h5Z0FacnZINjVVazVk?=
 =?utf-8?B?THZQaWlHQ2dtUW04d2dDNjR3d252eEdESHZSTXo3Wmxzdy9OSDlIRncxd2xy?=
 =?utf-8?B?VDBxYTFILzVCL1hzdWo2S3dMbWtpaEZjbkthamg1YS9TcmxKbEw0MmFXNHlD?=
 =?utf-8?B?Wi9vOUVnS3RwcTJuTGplRXpMNGpKR1kzOE13ZzBlYi9pWGUveUFjalVLeXRT?=
 =?utf-8?B?K0hLRFg5UWUwRE50M2dNZlVsT0FZc3BVSkFkM1pBWVNkTmxiSXhLL2YwWUJI?=
 =?utf-8?B?MkZoT29vdjRZYjVWU05QaEFnbDlqalJ6cWZBVVZLc3Q1Rm1FOEZzZi9GWDBa?=
 =?utf-8?B?R3lqS0tiTzM2TnZhSWprc2lyU0xnQXNxR1VZYUpDajZybTYxOTFWYk9CRGlZ?=
 =?utf-8?B?Tzc0aExoZ25ZUXY1cTlMalRBL0dPd21ablRWRzZocExmWEpJb3lvKy9Ya3pM?=
 =?utf-8?B?KzhhVnpYVjBkREhlUWtlMmNuZnByMDVTeDE1SVkyVkJ0ZGJuQVhaV0N3UU1w?=
 =?utf-8?B?T1BQVXdPRkptVjY2TUs0Qzh0QTZQemJTZEFlSmxmeXRFZHkzSVhDSTVuK0t6?=
 =?utf-8?B?WEhCZmdqK0pHTG9ydGpKR0liVVVBcDBsdjlFUVpVVXJST0pTaE44T0hHWEJt?=
 =?utf-8?B?ZlRINGZ2QXBHUnNwRWxYay9NSUExd3VZYVRjMzBXcDRWUlhSeUsyYXVIaWtY?=
 =?utf-8?B?OW5xb3hjMHR2S0gzdHNKV0M3NWI5dWFrZXRGdEV4bkJlQ0FuczBIdmFMbmpY?=
 =?utf-8?B?M3dmM3NDKzFrSHpKVnR4K2c0ZDJ1ZFY1UWIxWHNHTlQwRVY3YnRjbU16cG1C?=
 =?utf-8?B?d2JXUHBjR3VFdjk2SHVCQVA0NStyanBwTUt3V3lxOEY1NjBtZzY2RVlrb0Jh?=
 =?utf-8?B?WGZsVVFlZExhQUlLdGplUVhiWnhNWHZzVWdIdE1SVldYZm5RNlJWTmJpbUxS?=
 =?utf-8?B?VFlRNm9XeCswZTliQit0T1lFZDFseGZreDJ4bHdHR1R1cGthMEd4WjlnUEM4?=
 =?utf-8?B?aEUzQjFRQmJWcFNhdjJPQWRYcytVNHVLclQrZFUyMTI4NXR6VmhHMEs3MEpv?=
 =?utf-8?B?ZWxTRTlleWhodnQreGgyaXRRNzVtYVdwZWQwOEpaOTEzb3lBQS9ybUZ4WUEx?=
 =?utf-8?B?K1doYjZSL1Z5aWxYbjBaOU1GMXhURzRUTkVtdm9SUVdoeUxCcXRpbzFPdXJS?=
 =?utf-8?B?RnJ1RnRKK0hsY3VIdFZOeFM4S3FyRTR0ZFlGYmI2NXI5WVUzSkFKclNqS1V2?=
 =?utf-8?B?cHhtblVNeUFxNW4vM3BhWm9sMWdEQnkzRnRYdW9TQTNsakFFYXVWNEF2N0RH?=
 =?utf-8?B?Z3luQUI1REM1bU8yQ2kvcXFHcHJWZWhrZWNQMk4rdE0xVHFHL3JJUFQrMTM1?=
 =?utf-8?B?Y1QweVp2KzhNZ3ZRd2R1SnFZY1dSQkJaSTFKM3hpcjAyNWEwZi9nclV5TFVw?=
 =?utf-8?B?ODQ4Vzh1WVdhUWUya0xwVG1TdzY5NHlrSkhxLzVrR1B1N1B2dm1jaTFuclpW?=
 =?utf-8?Q?3WsHJyXY3CA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThhMEpuNW1xYzZzVDRDd0pMZkc1cTF4RldTck9jUTJaZ0k1ekQyaHY4WWx2?=
 =?utf-8?B?UUZpMFhoWkpDcUJCOXlYQnEwWVNiR0Vza1JTbnJNS1hYVkM3b1c2U0xyR3Zz?=
 =?utf-8?B?eUpmK1FBYklFaWJsVnFFMzFvK1lsZlhiV2h2Z0d2V0I3VXI3WWplSG1kaTFs?=
 =?utf-8?B?RUpkQ1RxMTB1cVZKcFBYQURyaUxod0cxUU9xS2NiUzl1NFFTdGZ4R0xvMjQ3?=
 =?utf-8?B?R1ozd2lCU1dkN2EzVkhvVlozVWpWSjhwVmdZNFJXbEhEeDBBSU5icW5DUERi?=
 =?utf-8?B?TnNheGppZEpYa3JmUHk0RkpWR2JRTVRCbjlnWHl6UGFVNnNlRXdnSXo4dG5o?=
 =?utf-8?B?NjNSb0VXdEt6b29ieGp2REE3bGRDcGo4cXNSSFVXdWJ5NTUxMHJpTE91TmlD?=
 =?utf-8?B?cnl4amZ2M21YSGR6VjU2ZDRkUlBlNnZEMmxleEdIcTlXQUJ4K2tGL2ExL250?=
 =?utf-8?B?Ylc0RmVyOGozaEladXZXdFdLMVVoeUZYR1hiT3dtU2hwUk9RdDM0KzhBVzVV?=
 =?utf-8?B?bVkxTTBoN3hkZ1UrcUNKZ0FTQ01lNlZ3c3dBcGdEU2NHS2lWVFhldkt0VjAv?=
 =?utf-8?B?aUhQOEMwRW9KcnZxQWJFSXNBbzJRQ1R0SG1ZdWlxTjJnVGlWd2EyMEdNT0V5?=
 =?utf-8?B?VU1CeDlPTTdKOEk4NVhRY1NPWDBVRkl1S0Ywd2o4UFpmb0ZIZ2N2T0FKY2Uv?=
 =?utf-8?B?c1VYK3lXbmUwa0tOQjViM1VSOWRYVDYrSk41TURuTWkvQXoyek1KZU1BUWlX?=
 =?utf-8?B?dENzSTBXcldMT0taaE1CZzQ4M1lENVpDREdUUlpXd0NYQXhYQVg2WHVxYlJC?=
 =?utf-8?B?bXlPdm9EM2Vmd1VnRHhNRHRJeDRCMDR4TzIwbmIyOTh6SlBDZytvbVRTNGlT?=
 =?utf-8?B?S0pWczlFL2NKZGZISEpUTW52VEgvUXNTM0FTTkU4VmtHZElHVnVNS2s5Y0Mw?=
 =?utf-8?B?RHc1ZzU2Vm9ORHJPNHZFSldhSno0RUU2cmhLNk16NEZpYTBialFKNGMvYUxU?=
 =?utf-8?B?b2xrQ0JCRXI3SzBJUThkM3VtSmhqWnpPRnlZc3dKVFlZdFNsNVVaeGFzN251?=
 =?utf-8?B?eThNWTJVZXBISktGZGsvakhoczZTajUvSUpaaFVDWkx4eURsd1hPNmZzcnAv?=
 =?utf-8?B?M29iWC9WbUZGckhYb1RXcHlBOElhbHhHb1o5SmpnNnVKRmNDbDZ5WGd2dk5o?=
 =?utf-8?B?TVlESmRYUDJWcGNIQXVudjBWTkc0OUhjekk3L2lPSS9CYjVrbGJSbWo3ei9H?=
 =?utf-8?B?eUZuenJPZ1dma3RFTVl0YU9lY3V5UEFialZqK2NIVmdBRSttOHNSUVZmYXlE?=
 =?utf-8?B?NHFOTFkyQ3N2emNMOURVd0pnemFFZy9hc1JLRVIrSGIrMzJidWlrWU9Zem9I?=
 =?utf-8?B?aHQ3TG1kem8yajFmcFMyNFJRbmt6Si92bFcwN2FXT2xmOGpDUUJkU3lady83?=
 =?utf-8?B?M0xhSHJkamtIYW1ya2U5dmRFd2hLS0ZOTE1OYnI4bDR4VUVrbjE4T1Vtakpu?=
 =?utf-8?B?REJrUFhkalhybk9FVVY2N2pscVEzVWUzQ1RseDgwUkRGUHJDbU5xbW4wYmFR?=
 =?utf-8?B?dWE2RWJzYlBRRWZvZDhmRGh0M3dhTnZEQjkzR3VjKzVqeTkyZVUxY0FaSUZQ?=
 =?utf-8?B?VmNSRHFxOFg2ZmVrU1c5YTlvRmExZHJ3cS90S1ZuQ2FXRXpKSXhGbC9tS0w4?=
 =?utf-8?B?SWJXbzhWTkNMRWQrMVk2TjNweTN4dmloeTVsdGxqTW1WcHNYbEpwY256cVZB?=
 =?utf-8?B?YW9yVCtFYTM4VU84WTR1MGd2YlNYSkJnZzR5R1BBb2Q5SzVFSnRBQjMzVXZt?=
 =?utf-8?B?aTFTaWlUTUhvSnRiVzZCL3VLYm83azcxTFRSdUlkK3ZaSzNvQ1VrS2N1d1FM?=
 =?utf-8?B?QVZSMGM4S2Z6MGJiQVlJdWllaDgvbmh2YmYwaHRneUtzc3lGYVNBTVBrVUpR?=
 =?utf-8?B?NHpXYS8vMWVOeVliY2xWbm0wMDR2QW1ZYzVSOXlaUE44LzBtNTdCQmNEMkNt?=
 =?utf-8?B?R3BJcXV0d0ZURHdPb21IK0hVd0hSdEdhc0haMTduTHNDODB5OUs2dndNWXZz?=
 =?utf-8?B?Vi9ucFByRFczLzB6c1BuNGRNb3FkZmM3NXF4ZzVENmhpL1pqd04zZHNlWFRh?=
 =?utf-8?B?RmcwdVEwMEZMaDE4OGxlTVJ2R2QrZGd3UHBKMm5OTHhhbFpEdEhyZjkxOTJ3?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75729779A08C994D8C311CDA4A7FC84C@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d2b57b-7d43-44ad-3b8e-08ddfb5a2a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 11:04:43.6214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om5+HQlITYqulAQ00+EbcHAMu2ZLVEYL0qYr2qSTxKvkED1B07PlvPMoJ3ekCGwDsPI+Dxsr/cHOGYkpCapPqh4sisJ8vfBnEK8nLa6vmHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6043
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

SGVsbG8sDQoNCmp1c3QgcmVhY2hpbmcgb3V0IHJlZ2FyZGluZyB0aGUgc2VyaWVzIGxpbmtlZCBi
ZWxvdw0KdG8gc2VlIGlmIHRoZXJl4oCZcyBhbnkgZmVlZGJhY2s6DQoNCmh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9saXN0Lz9zZXJpZXM9NDY5ODcxDQoNClRoYW5r
cyBpbiBhZHZhbmNlIGZvciB5b3VyIHRpbWUhDQoNCkJlc3QgcmVnYXJkcywNClVyb3M=
