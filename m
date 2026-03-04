Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97CEF9002
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 16:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F3A838BB;
	Wed,  4 Mar 2026 17:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Qv5nqdKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C122B83F7F; Wed,  4 Mar 2026 16:32:47 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D535483F8A
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baGvsFb5VZE8v7/lewmvLywVZsbcP3YIjX4v5rLUcSBuhNvCzoR/U/mxNSPRm5ojVNS/Y7IQeNIubtXObfB6qgF/WugdmVsEL44s5sg6tm+ATDnetXdIrPvp2dLlXE8VsmX58nNp+l8eic9JlEuVhiU4I3H+1aclHDNOTf0+BQDny2GVzB9FBvraf9oSCpO4fuIsV4TV9Qy3w0Ifa+4nU+7ef53wihM0Eyk3CMH3pwMELat1tPx2Ih6+DQpsMOYK6FdRk/NIfS4ilfpTTYIl5MHNbVkuhwPqJhYEwI9xDLtFKIr4zuWBvUqal+vcNrCqqTsz6U/pmEPou3Y4aFEdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AIRz2ZObyDpKeDSvbXjdB9YEGmQUU79IxxIBRClRGQ=;
 b=vFePD4WOlY9IOV0OlfdNgbktIiykzAvppY5UdytAC+QVJwSxnfQHdAmi2n0eyX4NzqR5yQ7ZBmwCF0RDKf183PHp9GL4Kbk9rvOiErKpLRvRx07WNUftLjV3/HXSGMMIx+LM9yLILFSXz+yWrvnbphWZGuEy4md2Nhvpij8iCtsXC5ENsqAcEVU5hDGY3yGtd2YpKfSekizKPkp5WZcyJpvgQnUM92flhJJqKzbDGD8KEFnKj+Nsmmq2spI0Ee2iqewjEkw9t7JOsWDJ0SlkE2Sq4l8rlcBoK7JrVm9zpWsEiRv1RrKlh6QlhTiIqLR8QddG3IgnenS4GVn7aYIG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AIRz2ZObyDpKeDSvbXjdB9YEGmQUU79IxxIBRClRGQ=;
 b=Qv5nqdKiMnLKonvhAFvSWIPuli3h74Ftzsv/fQP3bX5kW66RjzDil5iOIZzdOy9wINqnoiS+TGN0VH/af6tSYUfEyR91RUc+SJMaExOaTcmYXhPwvzRzx6fFQXKlaas6Zt53MmenjQTUjiVLfgReKejYPO6+CF2RKK526HhtgwhpROYJ38AEVHc5leVIoxgMZ776Do9xxA3UDOXY9ucpGleWc+Xx4JlbZs0qkV6cvbVr0Fm2+V1oZg+SaFQ0SjlInqQfzbzwheMKZmg4AFzOpww6L2+fBBCbghFtVXmnbJ0fC4z11Bj7iWbZDqWN6239G0LWT8uY1A0IrmO6KTV5gg==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PAXPR09MB5510.eurprd09.prod.outlook.com (2603:10a6:102:274::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 15:32:41 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:32:41 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "ycliang@andestech.com" <ycliang@andestech.com>, "rick@andestech.com"
 <rick@andestech.com>
Subject: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcpmlCiAymLWRmJEemi0BqvIAyyLWei3MA
Date: Wed, 4 Mar 2026 15:32:41 +0000
Message-ID: <17b21670-197a-4dea-9414-6f847baf3850@htecgroup.com>
References: <073d22d7-86c1-462e-8bda-c3e14c209376@htecgroup.com>
In-Reply-To: <073d22d7-86c1-462e-8bda-c3e14c209376@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PAXPR09MB5510:EE_
x-ms-office365-filtering-correlation-id: f9086972-046a-4a46-1a26-08de7a034638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: ob0kPn/X+H/GtCekVNxRs88fAyYTnrXiQfNMaSl6qt9z8+feJ76MGk9EDBlqONnVjfQMEhlFV/4K2A06APgwe0WObAZxeADrbMVxEmt9TpP5wgMytDgPEee/lK+JT7ZRIEII+5jPxetr2MpzTQo0n1JXXVV3q7lg52Q5XbIpUi3g3MaKV3y6rMeoyKNQ2pTa1DOe3+QOTn1pRH+or1BAgHsFs7v0kTOvZETniMeLzaKm2X6P3+PcsQAO7IzKsd6Zd4v/5V7mNjgJZ8SEivCm0IOOaSzjhmg/6JTFr9IA2og7kHx12iiDPtRXzbSgqiWKZnRB/nmBnSBlLnj1MbYTS4+ZVDxAIZhS1s3Mm19Z0QZmz8mGXnEBy5HmmMRKZ2TzhzL02VIrYnS8AVSKNexcCCd6lnzSZggiPRgj1jwCJPLmj8pQ6Lz+Wy9atn8vQX5qu6+D9kyJQIRWZXwzifxUMGz0RjBz0rEWrVKFT/dvq0b34J6dU10wPQ+qhjaGWKWyQDuHLIm3YdcJHuWCov5dELSZSDW/yGZ9m3cYfaFMFxUa3JUrkgxJvgFVY12QNduY9w+zbMS0Qls2yrBgY33t+5vCZ+1hhzvjEXgkGTINHWtvsgTGoyYAHcHao04ocvn7U8t9qiMxQxV5ycJpmth2p5XuVYyyxq5qxjXE6G2GIFZiAroPcSum4GV66RN0IYoqbQq7i4m8hosQ1JamshD1lR2sxFg08WH5ox1hOliZwvTpT9H44NFaAsLItrLuULda4zx9MyAl0HdqDzsVxmKOZ0ofy4Liwvh9WaMIRpG+HN4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STU0bGUrNFRabnhMci9yWGMrSm9BN3Y1ck1yTzJTSFI5L2V5b2VFck9zL2pE?=
 =?utf-8?B?eDBFTlkvQVZaZkdNWTJGbmg1VkMxT295TS9ML3h6b1kyLzl2SFZCV3QxTHdN?=
 =?utf-8?B?RE85cVR5N2x2ZnJQYTZjTGJ0OWFOWmJsYlBjdVNra2VGbGxnU2ZQcVNPdmEz?=
 =?utf-8?B?SWU3TjhxRVBlczBCSUwyL0hCMUsyWkxJeTJmaTZFakptOTFVSCtEUzhOY01E?=
 =?utf-8?B?WGM5MGVZT0JYZk9oeThFcHQvakp1YW50RkxacVkwaUhNZkNOWlB0M3NiSERr?=
 =?utf-8?B?Ty85bkhxMzR4MVRPVmxLZE40V2VHQ2s0emFQZmpSa0pFT0lWSjZhNTh6TTdO?=
 =?utf-8?B?TFJEUlBkaU16NjBtdGtReFJSWi9FbDVzdnhYd2dsc0hXWWtNR1kxdUlxWGVQ?=
 =?utf-8?B?UVdEc29ya2xXWnIzdUlibjZpc2lPYnFnQjlLcDVUZ0pWNVEzMFpKZmlKWUNt?=
 =?utf-8?B?c2ViWmlxUW1tWTEzd1VXYlNZbVpSdVNnUlcyU3VqbW9MY2pKaTJ5MTdZMFlU?=
 =?utf-8?B?QzlsWGxnbXQ4SGF4NG1ScFhtYnVkSWt3MU52SlF6SC90ZVRxdXIrL1YwclZv?=
 =?utf-8?B?MHdCNHMzSDBpTmFkMXRqVzJjWXVheXl6TDdmUXZZMVVjMlhzOVVRVjBBUno5?=
 =?utf-8?B?cWwvY0M3MmNzektTNTJLWk9KSXNhSThTaFd2OExjb2lBRnlpV2tuL3M2dVlS?=
 =?utf-8?B?ajIwSVVUcTdIWW5tTmtTTDMvTlA4eXRLdVNiaSs3amlyOGFLS1YxMUcwQXFF?=
 =?utf-8?B?WWJMaENuS3YxYUVFWkVyc1FUQkZWbjZseWJ0U2FzMk9Hb0dxQkhTQWJKUExC?=
 =?utf-8?B?QTdUYUh3R1ZGV21sUmpFKzFRak9SNFVMbjEwazkzdXNNaUd1N2xxUy9JdzRa?=
 =?utf-8?B?R3RnK3FPQVZKYXBuc093bmZPTUpoSDZHb2ZaeHExems5eWJ2YXM2cnhQQnlB?=
 =?utf-8?B?ZUpkSFgxbng0bzdURHpSSWVwYXFPaHRmSXB3TmVmS3Y2bVhRTjI4eGc1SGtZ?=
 =?utf-8?B?OW5TUzRZSk56Z0Z5ZlFhY09yeTl3QUZnVUdDUjU5UWJ2Z1pHNHgyTERSbUpo?=
 =?utf-8?B?cWVyd3BTcjl0anMwVkgyaDQxR1BnWGdRakpSN2NwWE5idzIxZGp5WUdQa2F5?=
 =?utf-8?B?bjY0MnR4VHZ6a2hwNGhOTE1ja29KV1M2ZGVOanE0VlExS0tEWGRybUVHZTMv?=
 =?utf-8?B?ZmYzNGZkSnlBRjFOdTU0MHVRandPYVJ1M291RUp1SHJVRW5jSU4zd3BRbklO?=
 =?utf-8?B?d01FM25XRmcrK1piaDJoZ3grQXlFWHQ1dE9lclBleTI4OG9JWVo5MTVpODBv?=
 =?utf-8?B?RGp0eUdNUnMyRXViQWxRYll0WVdUVEl3a0ZCNnkwWGFwWHZqTXIrVWVubFZt?=
 =?utf-8?B?aWZZa2JNWlRLOXF6enZZTGQxYlVkVXVNM0x4cFdZQWNCTXFCMjNpTlgrSlVL?=
 =?utf-8?B?N2pNL2llV2J4N0svYlVWaENrSjQzR2hnVy9IRXhjbDRyVWtCbEdibjhYeHly?=
 =?utf-8?B?OU1NbE81SEl0YjlhdlhaQUgwSFlHZVF0YVlkVzdSVi9EVDI5bzRCTGxud1ZF?=
 =?utf-8?B?Z2JDcEV2Q1BYenRXM2ljVVZ2elB1S0dreldnUEdyQm8yemhPK1FjK0p2Y0tD?=
 =?utf-8?B?WnhCTHBEZmRIeTRRN01SZHNkQ0tzakZUb0dQTEEwMC9lUmtwa1VaZXJMbktT?=
 =?utf-8?B?TzNjMDBlNThidCtpSnE2SXVITGc3OVgzUEl1NDFiK001MVpIT0ExZTd0Z25n?=
 =?utf-8?B?ZTdDNU1RTVBvczZsSlJkeXJZbGt0TXkxU0NZWThrcHlObnlpNEFtT1hjbHB5?=
 =?utf-8?B?bWhBSi91VEsya0tWUVVLWnR0aFVPRkZvZVlKcDJac2JWWk1CYW5wbENmeE1D?=
 =?utf-8?B?QmFlYmpHaTI0eUptTS92VXRzbG1HbllFZWNHczgvNTA1MkFjR3lyTFVBY0lx?=
 =?utf-8?B?SjZJdWg5d0Y3Z2tVdDNuTG1yTytTYmU2bEhwb0Y2MVdCUFhWTldybjBDNXMx?=
 =?utf-8?B?WXZuVFNjbnpXamc5ay82UWVOUUtJeHNuT0VIZGVuUWczRmUvb0ZkOTh4R3lp?=
 =?utf-8?B?SUZhejdBTG9tcDFUMlplRzIyRGtzNUtaV0hDTTVEN3UrSGE5QlFFenlMU2Rl?=
 =?utf-8?B?WlYvZTdTTWM1T0hiTXBUdE1ad1AwZkxTYU5xRi9CUUphTWMxMEtlMEJPSk8y?=
 =?utf-8?B?V0xnSTlhME9DdmFweTE4MFR5UjVJQW5ka3hlZ1REdWJURlpPSEZyZnplZkZz?=
 =?utf-8?B?SHgzVG9oeWEwK3cyVWhDQ0R5RmRnRTg1cnAzSzlRLzkzMDlxUUpJTmxaR1I3?=
 =?utf-8?B?SS9scytFSklzemFhaG4wbEJiVWhsdnh3T200WTExWTJCa25CRXVsU0FkYkhV?=
 =?utf-8?Q?mE56ppEV+rV9A7Xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <183B4C5B32D76E4B844E424D7618448D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9086972-046a-4a46-1a26-08de7a034638
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 15:32:41.3971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUe0pbLEDEQFubVdf5TUfsqcA3dNk/0+VVKiV87mFKUkCCBZ+dLZ/XgOQbw8UeqrYb6isH1n2vhiTIiGtigiMSU3/wH6kVPUi7copxwUIjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR09MB5510
X-Mailman-Approved-At: Wed, 04 Mar 2026 17:13:43 +0100
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

DQoNCk9uIDIvMjUvMjYgMTY6MTMsIFVyb3MgU3RhamljIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+
IEkgd2FudGVkIHRvIGZvbGxvdyB1cCBvbiB0aGUgcGF0Y2ggc2VyaWVzIGxpbmtlZCBiZWxvdyBh
bmQgY2hlY2sNCj4gd2hldGhlciB0aGVyZSBpcyBhbnkgZmVlZGJhY2sgZm9yIHRoZSByZW1haW5p
bmcgcGF0Y2hlcy4NCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91
Ym9vdC9saXN0Lz9zZXJpZXM9NDg2NDE4DQo+IA0KPiBUaGFua3MgaW4gYWR2YW5jZSBmb3IgeW91
ciB0aW1lIQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBVcm9zDQoNCg0KSGVsbG8sDQoNCkkgd2Fu
dGVkIHRvIGZvbGxvdyB1cCBvbmNlIG1vcmUgb24gdGhpcyBzZXJpZXMuDQoNCkFyZSB0aGVyZSBh
bnkgYWRkaXRpb25hbCBjb21tZW50cyBvbiB0aGUgcmVtYWluaW5nIHBhdGNoZXM/DQpGdXJ0aGVy
bW9yZSwgd291bGQgaXQgYmUgcG9zc2libGUgdG8gbWVyZ2UgYXQgbGVhc3QgdGhlIHR3bw0KcGF0
Y2hlcyB0aGF0IGFyZSBhbHJlYWR5IGluIGdvb2Qgc2hhcGU/DQoNClBsZWFzZSBsZXQgbWUga25v
dyBpZiBhbnl0aGluZyBlbHNlIGlzIG5lZWRlZCBmcm9tIG91ciBzaWRlLg0KVGhhbmsgeW91IGZv
ciB5b3VyIHRpbWUuDQoNCkJlc3QgcmVnYXJkcywNClVyb3M=
