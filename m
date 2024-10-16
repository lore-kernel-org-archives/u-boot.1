Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A4D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5A388B39;
	Wed, 16 Oct 2024 08:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QceWEOkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E2388C05; Wed, 16 Oct 2024 08:12:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EF688B39
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkCKg9whRVC5bPTS+AwxE83HPCM7HYGiuUnMxmpW1vZZ2E2UY2dHAeeWFVOSsSVOJ/XT0cWcMQMf0AElmCOJSl2XQwYxn/eeK0vLASpaor3Um5RfyS7R4GUHkW+Vf2oMd9/7a/jwAkifd0mIxgoDMH183+JAhs87IDBDZ5EEH/IQ1IaY/M56gRRn/+MNaLawyRMuD6wFOhlz3nOkHpJl4VtHyUi/mjyTEEhJbn5COgMQJ4EKgE376JFuAiqH2XBWGZIuEhHuAQWs1L7fAKkf1FZsoMqHyEfnmXdObZVZBjJIssh8JtvD2g9lLNirWWjWchR34JP9+ltDOiwVA0+Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcZrb5DGIjtDLAzovHzsEQxmkCYTpXl4WMtdMhTb5Ec=;
 b=I2ztNtiqJH+rQBVeN95SQ51lQgGCrBng8BKdSFNMaecuQDqON54QgC1JsQ0x/wyLhsgb84BJr6VvZjBFoWfcCQbdU1n9lRaGj+PM4j2CDLzSjEr4PkPom1pqkPZqPo2v/4JFpmu+1PqP+uANO2Ltxp/l1nA7ZCbd9cwxF0agTlsf0n0jNabsJ1YSW8XvxA82bvIBSHojyzQFV3ZMKZAWywqaYMAvDF8E+qotcjpt/cYQ2+cZX680nQ0ko0cEHu1Gnr8LffqCEUvMOItekYbJIGTj+BPRN/GCOVV3Hm1pNX64BMKFRDhfgm6Dq+HS8IfM3k1rE3uJJ4lb8EbEY3vT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcZrb5DGIjtDLAzovHzsEQxmkCYTpXl4WMtdMhTb5Ec=;
 b=QceWEOkGYFzuqs4yKKrgzpXB2OxS1oWiGrK2hVYdWvcOQrYZCHBcp2DZkuuyB5GPICEE8BTM9oPppl2B8CMiTgLdUYPinGgIKHT4MXqu/4JTJfz7hKNY9qWAgnHcWEWZHyX+1CORUA1p32SG6TigMRcL88N86GarmO1EcyBpgu+vZBluO0MskFNIgiBBvdfHAR/7n8KNuYq6C8wS/0f924RxuL24/55CvC92Qb2W5tmA+Ly+o3Qa9AmfwpA5Ss2eWjnHYiAjyRLcHil91w1ugrmtmlfBKCR+7Py6lJZ0kbf4DFM27I/6blKlHSCPZF05MiFWp9CwWI2Gey3qiRRaCw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8376.eurprd04.prod.outlook.com (2603:10a6:102:1bf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 06:11:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 06:11:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "hs@denx.de" <hs@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico (BT CPS R&D
 ZG FW CCP)" <enrico.leto@siemens.com>
Subject: RE: imx8qxp: deneb board fails with current HEAD
Thread-Topic: imx8qxp: deneb board fails with current HEAD
Thread-Index: AQHbH41WAFKI4zBF3ES21nZYTjTvMrKI5R8g
Date: Wed, 16 Oct 2024 06:11:58 +0000
Message-ID: <PAXPR04MB845969EF200C1F0A6AF7976488462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <67ebc675-d681-3b63-b642-f32f5e6a6b38@denx.de>
In-Reply-To: <67ebc675-d681-3b63-b642-f32f5e6a6b38@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8376:EE_
x-ms-office365-filtering-correlation-id: bc777631-889c-4bc8-3350-08dceda97114
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGpiMFROcXdOWmR1RzhQOHpYaUt5bDNEVjlrZENCc3E1SFhMNTNQeDZQVmtX?=
 =?utf-8?B?UTV2MTU4Z3N4TDNtVWFZWThhN1VHUHFvb3QxS25aN1dkNjc2WlRvQkJaL1BI?=
 =?utf-8?B?bGRWRGJGSllYalYrRnFBaDFkalVFWE85ZFkzL29mWDNuZTVEZ0pQMW15eVNK?=
 =?utf-8?B?K3JQVEJaVk1WVmIzdHQvNTlJUE1MNVBuNW93UWFnb2dXTDdrSGl3K2p3ODRF?=
 =?utf-8?B?eVpUTURRQmZrMWtjUWwrb1VyTmpvSTNRQ1RPNHBybCt6N3hZbm9vWmZOTWFC?=
 =?utf-8?B?WkdTZXhUU0Y1dE9VNjFHWGgwb2NiZ3YxZTh6dTRYMkNvcnYxR1pvbllBWGlo?=
 =?utf-8?B?QWdMK3Q0a0NqR2l1b0lVc0xzU3J3QTl2NGZaSmpTajA1SEJFSnhMOC8wMGRL?=
 =?utf-8?B?ZTEwaC91dGdGZzVaVUIrcFZkSG96SXZML1hxYlJkTW5kdnVxVXlVR1BPaEhS?=
 =?utf-8?B?OVdEMXFYTG1HL2YzQXVOeTVzV3ZsNkorWXRUdGdKNHV4dkFXMkZtczJva243?=
 =?utf-8?B?QTh5UHRhTWpydlYxU3JwdG1pamtZeGI5eUFMR2VTeS94UStFUHY2MkJtalR5?=
 =?utf-8?B?SElGQlZIL1VRYmxNUUw0TndnZnlXU1MzQjRSNjd2UzJtTjU3eklTbWZueEpr?=
 =?utf-8?B?TERCaXpjazlBR0ZBOGJYdENRMXlWMjJUVXRGNXJzL0xJMWxhSnlxWE1EeVVs?=
 =?utf-8?B?dGVQU002R1YzVDNzTk9uTGx4cUhvU1BoYlA4Y2RSWjZaemdZeXRYWGdjNnZY?=
 =?utf-8?B?VWUrajB3cFdTTzh2VnFrWnNiZ29sQStVWG9FYjNJSFJSczlpSklSMnhaUUp3?=
 =?utf-8?B?R1IwY053aGdmK090V2hMVUg1QVh3dmN2N0RLQWRlRm84WkQ0bW5IekQyMzdt?=
 =?utf-8?B?VTl3UGNvTmdUOWhsUTJDUWlYV3IzN1ZTbEN3WmtPTUlQdVlPSThTU2EwaWo4?=
 =?utf-8?B?bEE1d3ZpeCtJZEV1dW8ydmI0bXdmYWlGK28wTHBZUWdkVHUwYjZUaXVWMlU0?=
 =?utf-8?B?UXlXSERBUERwbnhTM3JQb3RwbzkwM01BTEhudEFsNVZMNnVCNi9wWDdibHJE?=
 =?utf-8?B?ZmRraEZPckdCaXR0WkZQVldWb2tUTCtDTUZGYVd0U2JEeUVtTFdaWm1UZWtU?=
 =?utf-8?B?dEY5RTJXeHVYcDA3U0NjSFM4STZNUVgyREhkam44MUhVN2Z0VHhscXlwalo5?=
 =?utf-8?B?eUtLbitLZ0ZLMTUxL1czRU5GdWpiUEk1Nkh3UEtMbjFYYmcrZUQvMnFHcE1Q?=
 =?utf-8?B?c0Urc0FTVkFnMFhlQXgwRHlVL3gyVXBQdWo1V2pseWQ0ZEF2akxybnNGT3d3?=
 =?utf-8?B?d1NKYjJDVnZEQm4xVU0yQ0J3dWV5WldoTjZtQUJnRDBOcEJMeDI5YWoyc1dB?=
 =?utf-8?B?RVNQYUFsck5MbXhod2hMdEZ4REJOc1Z2Vmc4TFFJSllTVUhDV0V1YnFGN2k2?=
 =?utf-8?B?VFU2bEhsemhBa0hjek51eXAyWktjUXZ5MTNzNjJGcHpUL0pRc1ZRVUFhSkw1?=
 =?utf-8?B?YkFKcHVEM3loQ3haUW9ybXhBLzViWXA3K3BEeTA4R0ZkMEYyTFlsU3lqdXJN?=
 =?utf-8?B?NkNrRTlZNjNEWXIyRTNOejduL0NkWkh2ZUFrRXc4TlRQZ3BFYlBQTCt3U3JW?=
 =?utf-8?B?RVp3VEtVTFlCYUVlclJpWHk0ODNlUUZqV2RXM2JMcDNNT1B4NTZaeFJLNUJW?=
 =?utf-8?B?cjB5elJhUmdHWTRRK2U5cGtIeFZmdy9rOTkxQUJQMDcxQU9zME9hNWZhN3Ay?=
 =?utf-8?B?MUlUTGk2aHFaQzJ3ZVpMUXpIRHlFN0o2THF1S3UvOGJUQ1lRRE5qQlVhczBL?=
 =?utf-8?B?bWxmRDVxeVUzLzc1R2FJQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3VBQlkydmdub2RmamVxdTVoMlU2QXpGQXkwb1dhdUVBb3I5SENGUlI5NEFa?=
 =?utf-8?B?K1VNR1JOR2pja0QxV0tsckhTWHlRRkRSOEphOVRYT3U3LzdsM2VLNVlKWmMx?=
 =?utf-8?B?YnFvRGZqTkN0MU9JNDM4WlBKdGZSVlpDY0gydmJRalh2cGZzaUt5R3lYNDQr?=
 =?utf-8?B?dnVJOXY5eXQrT28xL3ZHRThsc1VKUlhUb3p6SmtmakQ2K0E3d1JzSDh1dUpH?=
 =?utf-8?B?czNuY243QzNZMVdLYk9CNUpuWGpiN2xjNXZQQ3pUMG1VVTM3N0xlMTFTRlQw?=
 =?utf-8?B?eGsvSnJKUnNQT0h3L2Nza2ZlSnZWeUxEQjduTjhFMFJpOWxCbFZ3eW50ZzBz?=
 =?utf-8?B?Ris3d1BNRjQyQ3lsT1lOemNqQkNNMXpuS3dHSk9XUEhZVGJ5bUE4bUI3L1lU?=
 =?utf-8?B?M1VpNlNKdVRiaVNkUmREOFo3cUcrNGxRTkZkbWFCVVZaMHdxaXpHOVJ1Qldt?=
 =?utf-8?B?eWNKdkJJSGFPZEQ4RlFzLzc4UjNPbXRFamV4TzQrMmtIdnA0OUIzSHIvVDJs?=
 =?utf-8?B?SlFWamRKelZzR2sxYTFrVFhucytnRmhJRTMycnB5ZzlaMXZRd21sY0E1TUZm?=
 =?utf-8?B?T1ZvRGpkbmN0eUtLTmo5VEFIYzdpOU1MenkvRTRIczRFYTJKWXNKQWZ6UTZq?=
 =?utf-8?B?eDBGNUpJZmh4cU1pRitHR2dhbXliSUhVSlptL0RYcS84dDZIM3RGdWwvbkt1?=
 =?utf-8?B?d1JDUzJINmpFUEM5YmZtWXp0SEc0ZnNybWhqVWdubUYrR0o4MWI2dlF5amV6?=
 =?utf-8?B?ZzFTMG9iU1Z1c1QxenltN0ZtV2M3Vk1uQVE2WTM4Nk5VTE5DWCt6czE0aWo0?=
 =?utf-8?B?cE9wWFlhM2NlalQyRitoOGo5Vi9hNm4rZmpFbVBCT1U4eHZiREJadWpvRDRs?=
 =?utf-8?B?WTZLWG4ySUQwWkZiUkxtOFg0SjhZQXJoM0QwenZUYkp1akdwYjB4SHNDZDBr?=
 =?utf-8?B?a2VZaFZwYytYWGpSL2VEOXd6U1JtMlJWSzZzTmZJSDNOQnFWTlNHTnFOVTJv?=
 =?utf-8?B?b0RQWGlGOWl1Y1MxS2doRmFYa3dLQkxlOW5qSzd1Uzc2Y1NWZ1p1c3B2c0R0?=
 =?utf-8?B?ckdVZE0rbXF5QkhuY2FUK2RnRjlBeG9FSkxwb3E5ZFBWcmFpb243TEsvQ0Rl?=
 =?utf-8?B?ZDM0MncxejBRRDE1ZWJva3o5cXhJeU0yWVRsODBNdzZDZml6L0tJd0FpOUU1?=
 =?utf-8?B?WlBMbDMyejhRUjFwMVJibnIzOVJUUHV3dStRaU9CU1RIV2lnTlBXNVdIVy9Y?=
 =?utf-8?B?MmpZcmM4OUdwNXphS2o2enhlSDZGVmVodlRReFoybzJaOEMxSnBza2s1Wjgx?=
 =?utf-8?B?SjcxTVAwa3VGZjNVcEFCVms0TDc1cS9XRHZia1VmdW1UNzJjM25xeXgxaE5G?=
 =?utf-8?B?M3VBZ0JGcTNGOVZ2amFhUnpPQjNHbFlrUDYreDlGZE5HcktETFp2d20yY3NR?=
 =?utf-8?B?WWRUT09XYUFBOXZjRXo2c1Q1TExSd0VlTTU1aEJLUXIzeis3SElYZzVieitl?=
 =?utf-8?B?SW8xcnlVcUNPSkNhK2JaT05JYktTU005RW1ENmFoUUZEeTRyN0RiRUY1SmxL?=
 =?utf-8?B?bUdMd3RUOUR1a0pBeXVXNDgyT0FMWFZtTW03V2Y4UW4xNC9oNWhuazE4OUFQ?=
 =?utf-8?B?bnQxWGJOQ21ZLzdqQTJiUFZhSEl6RlQwQ2krK0JPRDdSZ1dRYzBPMXZHM0dl?=
 =?utf-8?B?dnUyaVdJZTlYblNZZjQ1alpFcGlqNHlqOGlweUxxTW0yV0lGT1h5WVI1bE1Y?=
 =?utf-8?B?Vmt5U3MyWi9FSUhLM3Bkb3ppKzdQalBNRU8zamZaOThqdmo4YnlVVHBXdlAv?=
 =?utf-8?B?LzQyZWhlWFlhenZpcUQ0V09sNm9JVzJsaVdLaFRPMDZpR3ZGbFpSUzVQWW9K?=
 =?utf-8?B?NEpFTmZ4QjM0Wjg0ZSs0eUdNZ3NtTXdNUlVXeU14TVI5Q2FIS25QZDdBcDAy?=
 =?utf-8?B?SnlwRVF2OXA2azE3U2tva0NOY1ppOTVDRGg5MlIzbEoyTkIrUGN4SVdad1Zh?=
 =?utf-8?B?Y0Iwc2k2Nmx0OUZFYXErR3QwR3phWWVIekZtZkNIbTdMenZqMGxGR3V4K0tw?=
 =?utf-8?B?RlpaOFV3T2hNSGJjaXJwcUpnSW80QXlWeHh0M2NHWHMyNmp6ZW95MkpVeFQr?=
 =?utf-8?Q?ia3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc777631-889c-4bc8-3350-08dceda97114
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 06:11:58.1771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Z8WkGaOACa6pbGl+ZzDJUOVsnO3WlbwtX5M5oKFQghFhrSkUpSoIzbdrJfXHauYkBKbjH9zQngxL8+DjEpA+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8376
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

SGkgSGVpa28sDQoNCj4gU3ViamVjdDogaW14OHF4cDogZGVuZWIgYm9hcmQgZmFpbHMgd2l0aCBj
dXJyZW50IEhFQUQNCj4gDQo+IEhlbGxvIFBlbmcsDQo+IA0KPiBJIGp1c3QgcmViYXNlZCBteSBj
dXJyZW50IHdvcmsgb24gc2llbWVucyBkZW5lYiBib2FyZCB3aXRoIGN1cnJlbnQNCj4gbWFzdGVy
Og0KPiANCj4gKiBkNWNhYjBkNmFkIC0gKEhFQUQgLT4gbWFzdGVyLCBvcmlnaW4vbWFzdGVyLCBv
cmlnaW4vV0lQLzE1T2N0MjAyNCwNCj4gb3JpZ2luL0hFQUQpIFJldmVydCAiTWFrZWZpbGU6DQo+
IERyb3AgU1BMX0ZJVF9HRU5FUkFUT1IgLyBTUExfRklUX1NPVVJDRSBzdXBwb3J0IiBjaGFuZ2Vz
ICh2b3IgMw0KPiBTdHVuZGVuKSA8VG9tIFJpbmk+DQoNCg0KTXkgYmFkLiBJIGhhZCBhIHBhdGNo
IGluIG15IGxvY2FsLCB0aGlzIHNob3VsZCByZXNvbHZlIHRoZSBpc3N1ZSB5b3UgbWV0Lg0KDQpG
cm9tIDNlNWY4YWQ2Y2I5M2I5NTM4ODUyMjMwZDAxYzAxYjUyZDVjMWM5ZDEgTW9uIFNlcCAxNyAw
MDowMDowMCAyMDAxDQpGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCkRhdGU6IEZy
aSwgMTEgT2N0IDIwMjQgMTk6NTc6NDkgKzA4MDANClN1YmplY3Q6IFtQQVRDSF0gY2xrOiBpbXg4
OiBBZGQgZHVtbXkgY2xrDQoNClRoZXJlIGlzIGEgZHVtbXkgY2xrIGVudHJ5IGZvciBpLk1YOFFN
L1FYUCwgc28gYWRkIHRoZSBkdW1teSBjbGsgZW5hYmxlDQphbmQgZ2V0IHJhdGUuIE90aGVyd2lz
ZSAiX19pbXg4X2Nsa19lbmFibGUoSW52YWxpZCBjbGsgSUQgIzApIi4NCg0KRml4ZXM6IDc2MzMy
ZmFlNzY5ICgibW1jOiBmc2xfZXNkaGNfaW14OiBFbmFibGUgQUhCL0lQRyBjbGsgd2l0aCBjbGsg
YnVsayBBUEkiKQ0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQot
LS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jICB8IDQgKysrKw0KIGRyaXZlcnMvY2xr
L2lteC9jbGstaW14OHF4cC5jIHwgNCArKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OHFtLmMgYi9kcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jDQppbmRleCA2MmZlZDdlM2UzMi4uNDY2ZDcxNzg2Y2Yg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jDQorKysgYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhxbS5jDQpAQCAtNDgsNiArNDgsOCBAQCB1bG9uZyBpbXg4X2Nsa19n
ZXRfcmF0ZShzdHJ1Y3QgY2xrICpjbGspDQogICAgICAgIGRlYnVnKCIlcygjJWx1KVxuIiwgX19m
dW5jX18sIGNsay0+aWQpOw0KIA0KICAgICAgICBzd2l0Y2ggKGNsay0+aWQpIHsNCisgICAgICAg
Y2FzZSBJTVg4UU1fQ0xLX0RVTU1ZOg0KKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAg
ICBjYXNlIElNWDhRTV9BNTNfRElWOg0KICAgICAgICAgICAgICAgIHJlc291cmNlID0gU0NfUl9B
NTM7DQogICAgICAgICAgICAgICAgcG1fY2xrID0gU0NfUE1fQ0xLX0NQVTsNCkBAIC0yNjQsNiAr
MjY2LDggQEAgaW50IF9faW14OF9jbGtfZW5hYmxlKHN0cnVjdCBjbGsgKmNsaywgYm9vbCBlbmFi
bGUpDQogICAgICAgIGRlYnVnKCIlcygjJWx1KVxuIiwgX19mdW5jX18sIGNsay0+aWQpOw0KIA0K
ICAgICAgICBzd2l0Y2ggKGNsay0+aWQpIHsNCisgICAgICAgY2FzZSBJTVg4UU1fQ0xLX0RVTU1Z
Og0KKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAgICBjYXNlIElNWDhRTV9JMkMwX0lQ
R19DTEs6DQogICAgICAgIGNhc2UgSU1YOFFNX0kyQzBfQ0xLOg0KICAgICAgICBjYXNlIElNWDhR
TV9JMkMwX0RJVjoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxeHAuYyBi
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14OHF4cC5jDQppbmRleCAxOGJkYzA4OTcxYi4uNzkwOTg2
MjNiYzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxeHAuYw0KKysrIGIv
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4cXhwLmMNCkBAIC01MSw2ICs1MSw4IEBAIHVsb25nIGlt
eDhfY2xrX2dldF9yYXRlKHN0cnVjdCBjbGsgKmNsaykNCiAgICAgICAgZGVidWcoIiVzKCMlbHUp
XG4iLCBfX2Z1bmNfXywgY2xrLT5pZCk7DQogDQogICAgICAgIHN3aXRjaCAoY2xrLT5pZCkgew0K
KyAgICAgICBjYXNlIElNWDhRWFBfQ0xLX0RVTU1ZOg0KKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KICAgICAgICBjYXNlIElNWDhRWFBfQTM1X0RJVjoNCiAgICAgICAgICAgICAgICByZXNvdXJj
ZSA9IFNDX1JfQTM1Ow0KICAgICAgICAgICAgICAgIHBtX2NsayA9IFNDX1BNX0NMS19DUFU7DQpA
QCAtMjQ4LDYgKzI1MCw4IEBAIGludCBfX2lteDhfY2xrX2VuYWJsZShzdHJ1Y3QgY2xrICpjbGss
IGJvb2wgZW5hYmxlKQ0KICAgICAgICBkZWJ1ZygiJXMoIyVsdSlcbiIsIF9fZnVuY19fLCBjbGst
PmlkKTsNCiANCiAgICAgICAgc3dpdGNoIChjbGstPmlkKSB7DQorICAgICAgIGNhc2UgSU1YOFFY
UF9DTEtfRFVNTVk6DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQogICAgICAgIGNhc2UgSU1Y
OFFYUF9JMkMwX0NMSzoNCiAgICAgICAgY2FzZSBJTVg4UVhQX0kyQzBfSVBHX0NMSzoNCiAgICAg
ICAgICAgICAgICByZXNvdXJjZSA9IFNDX1JfSTJDXzA7DQotLSANCjIuMzUuMw0KDQpSZWdhcmRz
LA0KUGVuZy4NCg==
