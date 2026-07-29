Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA14CC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76ACA60A4D;
	Wed, 29 Jul 2026 05:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8VMcasWuixGo; Wed, 29 Jul 2026 05:11:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD687607EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785301913;
	bh=u8EidJhrcjYGBFNC77Y3nWlY+xOsbXxXcd9CKAUOH7I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x3s1owepSJLAmI++T81/yfDpTLj/QpjJK4HTu+RQFfQ8imsWTwubyXAATLnbutwu+
	 Ht3HhqkOUmtFhm23B6sEilFr6M5PzTJQt+8rn0OG0tpHtFbVz6W3M2ioRFJ81yDW2S
	 lbL7qYIyzVb/MxViDgd5tDFJbGcchLNZbJU7cTYPRb7JTLNc93UC/V7JKWba+nOw0e
	 1OP96nHUkEbEumsj45ZlQMnWYIG4SJyDT8DGU8UbAmouh+asae5+2uNOC+TMT2A8Rd
	 VIAljT45cVHjKxx3iVKWkoTI/FvcEGhZm3/hftUQdyXMNfAM0AoUin/YhR25csNhE9
	 eQXW9z3Vr98AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD687607EB;
	Wed, 29 Jul 2026 05:11:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E632788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5A5B40A9D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmPpINwGPbrW for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:11:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B7ED64099D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7ED64099D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7ED64099D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:11:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A4C38494B; Wed, 29 Jul 2026 07:11:47 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5C58404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:11:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWCBV5t7ApqeMadev0RKMld7NSbmmzewl8GFngFziKfpstvD4oJo1btwaXUp/l5GLaGMDwsGyCAfAfluY5a9cxSwqs+sWa7XbObQtSuomtHfL67WdAWQ7OOQCq1mAhKysS99RAdAoanMl94CNYM3+VApmnI6pEMdgI6riVKmvzNVqRcoN9DfSGhf/J+9L4OELVDGE+WKuiEe3IfAy3UDChJPDL4CijHjeloS48J5DlXrkxUM9Q2RAXViSPH7AAh2+TrKWNHcT/Jt6I3nwt92+3uhHpqU7Ipmd4lIkXR3tXyNdfgqBfYG9jyOHUGsy7pkC5WBqR7kjf55Mir/BMzpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8EidJhrcjYGBFNC77Y3nWlY+xOsbXxXcd9CKAUOH7I=;
 b=iEtBw43UXaf5ay5wulxhBoC1vvHkmOWeRUKA705UKP1wWxcs+95U0LiU52zitElDMJhPSOY/8WsNK8JmskzN8DFGMykBR3HAl7Szkt+lFKoynAtaH4RDKdonItOtk9p+qDQTMnuLkpCQv0NmJzLUQ3k+EiI4rjBg9eqzIUHhmYKtsopBeyNdtyeARZvKh6jpIs4cBYnNiWV1eXaY1LgFRyeRt6hX35B80s5g7DpNlb5rV3OG6BDLcL0Hi5Jmt0INGdlzKVRQlsY1hw4PeZXlsIK2xi3RM3so1OztTp/rkHKMTg7Q4Pe5Zl68xWAL3sOJw+1UQB49fo5hkNJ7vtBn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:10:42 +0000
Received: from MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::c0e9:462d:f3ab:6c77]) by MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::c0e9:462d:f3ab:6c77%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 05:10:42 +0000
From: "Sanwal, Pranav" <Pranav.sanwal@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [0/3] gpio: improve claim diagnostics and fix gpio-delay offset
 handling
Thread-Topic: [0/3] gpio: improve claim diagnostics and fix gpio-delay offset
 handling
Thread-Index: AQHdEwpAg9hYHg2yjEmgj4VWd66icraEAFhA
Date: Wed, 29 Jul 2026 05:10:42 +0000
Message-ID: <MW6PR12MB8758CD41D5308A7B63D6EFA9EFCA2@MW6PR12MB8758.namprd12.prod.outlook.com>
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
 <CAFLszThNYaMRxxqcZa==hvGt+QiNpNYb+yoy6Dmamysrx6ZT_w@mail.gmail.com>
In-Reply-To: <CAFLszThNYaMRxxqcZa==hvGt+QiNpNYb+yoy6Dmamysrx6ZT_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T04:32:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8758:EE_|MN2PR12MB4319:EE_
x-ms-office365-filtering-correlation-id: 1458db9c-1254-419c-e4af-08deed2fbd04
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|22082099003|11063799006|56012099006|4143699003|10067099003|18002099003;
x-microsoft-antispam-message-info: vQ9N255CjEwQeyxKHVwxdBuYNAqYmh2JkN3Zj5KhlMZBIY26PCHjEIrPKC8kUNBG9PMvO558nbtglB2qR6RdlFRpezNGb0bReQAsJAWBtg5Ssev475QMwpgbm3xzI9Vp2Ny/VniJnO5hZApS4N0XmQjuZjOnwo6qH24kaFdDeuvG2RdxdtNShQx1uzl66Xahc9EcfoaNkmj6w+i0Ti5Fa/qyoiEmEGhOrLtYXdSCdS+xRxCo1wFJsCoVFddtovg2BhbD1ERnNMSjBoVpOtovyL+y5450lwHPXE8cUpNORlf+2KKJgZPYG7ZnYGe+/KK9ogUhpq+6SEHUcGsDQo2FfaRqGkGNPSrQUVlASDlfaCSudeX0OS3P33yUYni1Jqjd7OrKt76PaUl2U/tYiR9DkHlDT3lucaKNHqbGlWnS0/YlxeoJaFwZooqQlgj4Ks1+8Ryd2nNB6nlQllNx8TXAsitFHVByPIosISNf2dwLyYASq1wI27mhJhWp8WHiQcvuijYo2gY/J99LLEJUn5AVVFlOkFtboK9DSJ/rd1YX84cBysB+SbPDf9y0T9sZHqqpcXVExoIUoU2Am0XWFC1IT2Waa5NHGuxw+kEjna82thYipHGqd9Ci1UVYhYS8VoZmmjoHaoFeh4HqdyI2/gkVq2+aziJhzQtzxAbMN8WhsMush++9RxBn33ZMKnn7dk/QxkyUdiehQsON0DI3s7J3HYNRk/Fur4wx2BTce4oYPyo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjN5cDZ2eFNuaXZETmtidnBIUEhHb29NOTVOWmUxL2FpUTZQck14U0JnZUNK?=
 =?utf-8?B?WVZwVkJBRnZKUUo4MTV6d2VzbEc3aXFvYlEwWUlkMUsxdENIRTZtbmFlWTlZ?=
 =?utf-8?B?Z2NIbjV0VEpZbG1KNkVUNVFZRnduVnFyeGxDb01SL2xWMWlEQVFDZ0VlUkFQ?=
 =?utf-8?B?akx2eWtNOE5mdi9LRUhYaEJseDlSMFVwcGZ6VzErd2ZCUHJvTkVhVkhsMGUx?=
 =?utf-8?B?NVlhbXQ0K0VoM2Q4MjdWZ3AyYkU1d01FSkVsOWF1SEZCdFljcXhhT3dZWWlP?=
 =?utf-8?B?NFpiZEJwUzNlejI1aTd6QVVaRWFaT25heSsyditmZVZab1ZFNE4zd25xZEx6?=
 =?utf-8?B?M2pLa21uL3RXWVJadkpvVmRRYWZXV01QK3YwRzN6aUx2NEtWTU5INGllRUZ6?=
 =?utf-8?B?cUZ6MWsvQTBtNG4rbUFGV2tLY0lJNUFOYnRuNHpIclN6T3RPckVLcU40SndQ?=
 =?utf-8?B?aFg5REh3RGNCQWhpcFhaVHA1NlZiZWNxZ25TaWRuWmpFeGpHU0ZjMXltY3BZ?=
 =?utf-8?B?VE5kNTNtVFdSTVRpN2l0Z0hwZDhFenpkRGtVUEl3Zkx2VUZVVmRkRktoL0hD?=
 =?utf-8?B?L1pnTVRTOFgzMm45RWYrakU0VWt4SjN6RDJGMWdqL2tMZ2ZSTVBBbVFHWmhp?=
 =?utf-8?B?a3NLeTRLbWc5MXZCOHU0anZ4MEtoaGxscTBTNzBSK0pmZXN4WGl3SEw5Yk1z?=
 =?utf-8?B?VXBtSXpoV0k4MFJJa2FMakltZWtBQkJSMGNxcnZKK0lMS2M0dERaWFlWZTlV?=
 =?utf-8?B?Ky9rY2VYTXRMWWFWbWhoU3UwRzFnbjA1NjRzRU1BK0FucjJyaXBXcDNNekRH?=
 =?utf-8?B?V1hJUVJsTkgvWUR4anA5L3FvNUNDRXhXUk1IaGVWSUZReFdxd05PMXo0NTM2?=
 =?utf-8?B?bHRLWUZ2TVdkNlZ3cVRmL2NUcjRuS0JJV2F1Mm15QWthSjM1M2VMelJrbk9E?=
 =?utf-8?B?cnVIUzRkSllweFpHNmM3UUl5dGJWOUlQYkFQRmN1RHlFUjYyMEJURnczT0Zi?=
 =?utf-8?B?Yk44SmlyNTBmLzF3Q2dWeG5qL2JDSkZvTmZEeW94S2hEMVBzbjdBQ29ETGNJ?=
 =?utf-8?B?VTFsK2laYlh5VkpJMUdLcUNJOGRIbW1pVjBOU0xFMjR0NFl6SWRkNXlLcjVl?=
 =?utf-8?B?dTl5QlpLRWdxWStPVWRYQUhSRkhpcm1KalBCY01xaHBYUUdnWUROdm4vWmRm?=
 =?utf-8?B?U1JWS0hjc3FBYmI3WTBoSHdaY0Z5ZStVdGhocE1FMXd5Vmx3RExXS3ZBbk95?=
 =?utf-8?B?emdKUE50RXgzK3BvUjBscGw4YU4wb3hJS2xXNUIwTVhNVVRLa1Q1Uy9ndlZ2?=
 =?utf-8?B?VlZTZEY2Vk1CRnRndXkwaEVpZzIrRTVMd1ZFaGVrRlFzSkZpeEYyOE1Eb1pM?=
 =?utf-8?B?bHNXclZSYU83T0wvSDliN0pSdVVxOVBJcUIwZ1FJSDROSFpBVDJzcTh0Qndp?=
 =?utf-8?B?OXJJUkZ5bEVtUjRjV28rbS9JSEFYcHpDMEtCNHl3YmN1a0xXZ25OOVV1cHNU?=
 =?utf-8?B?bm5uWTNCaXBqVitGbEoySHp5NE1Nb21BUEx0OU50K240aUIxSFM4eUJabGFQ?=
 =?utf-8?B?SkFoaVBlc1dPYkROYytXTDRGMjNweXN6U2dXcUZodTZJL2k1bHA3aHVmeE1s?=
 =?utf-8?B?UmRVVEYyR3pKMjR2Ny9wZGVJUlFQQklhUWJwRlBkOGRheE43MTNPSzRTWEdH?=
 =?utf-8?B?UjVXNmJvV25ra2g3Q1pEVnkyUXhZOFF5QjFKcFVHLzJSaXkyYnFwOEpMZllz?=
 =?utf-8?B?UjRYZWdHeTdXZXM3Y2ZHRnlXWmV4dHRJZW8wc3hoYU5OT3VTNEpDMm1POWZ6?=
 =?utf-8?B?UGRDTXJ0RTNNMFM5VURuemlqcGRqbG9QZzNCYlk2OHU1eWMyNmVYRzJxam5T?=
 =?utf-8?B?K1g5STBGaTNxeUdMbVhJaEljMEVKTkdrYmV1cG9scy85eXFjdkw2SGYwVlRM?=
 =?utf-8?B?WjdSa1lpTFZaL2N6R1cwRWhjWG8wZnM3N2lsWUZoY2NtdFVQeVUyVlpzZkNH?=
 =?utf-8?B?V2xKOGVkWEV0YzdFdi90dzErUTBNdFRvTENLT1Z2dGUxaTFlT0sxbG5Bd0VE?=
 =?utf-8?B?Y0pqeGhUam9oK2RPclpUZ0NxMVkwR0tPT0V6WkZUUDlvU1lVY0xOZFBSeTg4?=
 =?utf-8?B?RlA1NHBFdlQ3ZzJBZmdnVkNWZGhuRXB4L2hzR3kra3FtVXpjV0t5R1l4YjZk?=
 =?utf-8?B?T213UUY0SXF1cEtwVDRIVUdPMlhZSmUzR0xkR1dUNURkL3M2dFJBREhEQzd5?=
 =?utf-8?B?QzFDMTNJeWplVkJVRFlKTm13NUk0Wnp0QVNRakNoOGJ2NEZOZ0x3dDlkdFJJ?=
 =?utf-8?Q?rkZGJipnSr0Bt/cgtj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1458db9c-1254-419c-e4af-08deed2fbd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 05:10:42.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fe6W5MNXHB3nccE2xJJS/KG0ImvrQIcSa0sM7TT9sD6BHhTuuB1u/qcWXtfLTC5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8EidJhrcjYGBFNC77Y3nWlY+xOsbXxXcd9CKAUOH7I=;
 b=MAGO05GhHcsLoAFWZxxHYlsYar6bttm5JyLspM5VbUICVcCFMo/N0C4XzhBPfirBAmY8LBV5ogyqTr0n11fdzZZzqRgOGTWKN4ZNvcFjDGy7cLJxbBsBTW9v2xe/DbuGdLLi9LzDf04LDHdQIUXi+IDeahiKIYMFXkctiyuou5k=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=MAGO05Gh
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="MAGO05Gh"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

QU1EIEdlbmVyYWwNCg0KSGkgU2ltb24NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBhbmQgZm9y
IHRoZSBhc2sgb24gdGVzdCBjb3ZlcmFnZS4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgMTQsIDIwMjYgMjoyNyBBTQ0KPiBUbzogU2Fud2FsLCBQcmFuYXYgPFByYW5hdi5zYW53
YWxAYW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IFN1YmplY3Q6IFJlOiBb
MC8zXSBncGlvOiBpbXByb3ZlIGNsYWltIGRpYWdub3N0aWNzIGFuZCBmaXggZ3Bpby1kZWxheSBv
ZmZzZXQNCj4gaGFuZGxpbmcNCj4NCj4gSGkgUHJhbmF2LA0KPg0KPiBPbiAyMDI2LTA3LTA5VDE0
OjI4OjU5LCBQcmFuYXYgU2Fud2FsIDxwcmFuYXYuc2Fud2FsQGFtZC5jb20+IHdyb3RlOg0KPg0K
PiA+IFRoaXMgc2VyaWVzIGltcHJvdmVzIGRpYWdub3NhYmlsaXR5IG9mIEdQSU8gb2Zmc2V0IGNv
bGxpc2lvbnMgaW4gdGhlDQo+ID4gdWNsYXNzIGxheWVyIGFuZCBmaXhlcyB0d28gcmVsYXRlZCBi
dWdzIGluIHRoZSBncGlvLWRlbGF5IGRyaXZlciB0aGF0DQo+ID4gd2VyZSB1bmNvdmVyZWQgd2hp
bGUgZGVidWdnaW5nIHN1Y2ggYSBjb2xsaXNpb24uDQo+DQo+IFRoYW5rcyBmb3IgdHJhY2tpbmcg
dGhpcyBkb3duLg0KPg0KPiBPbmUgdGhpbmcgaXMgbWlzc2luZywgdGhvdWdoOiB0ZXN0cy4gVGhl
IGdwaW8tZGVsYXkgZHJpdmVyIGhhcyBubyBzYW5kYm94DQo+IGNvdmVyYWdlIGF0IGFsbCwgd2hp
Y2ggaXMgcHJlc3VtYWJseSB3aHkgdGhlc2UgYnVncyB3ZW50IHVubm90aWNlZC4gUGxlYXNlIGNh
bg0KPiB5b3UgYWRkIGEgZ3Bpby1kZWxheSBub2RlIHRvIHRoZSBzYW5kYm94IHRlc3QgZGV2aWNl
dHJlZSwgd3JhcHBpbmcgYXQgbGVhc3QgdHdvDQo+IEdQSU8gbGluZXMsIGFsb25nIHdpdGggYSB0
ZXN0IGluIHRlc3QvZG0vZ3Bpby5jIHRoYXQgcmVxdWVzdHMgYm90aCBjb25zdW1lcnM/DQo+IFRo
YXQgd291bGQgaGF2ZSBjYXVnaHQgdGhlIG9mZnNldC1wcm9wYWdhdGlvbiBidWcgaW4gcGF0Y2gg
MyBkaXJlY3RseSBhbmQgd291bGQNCj4gYWxzbyBleGVyY2lzZSB0aGUgYm91bmRzIGNoZWNrIGFu
ZCBhcnJheSBzaXppbmcgZnJvbSBwYXRjaCAyLg0KDQpXaGlsZSBwdXR0aW5nIHRvZ2V0aGVyIHRo
ZSBncGlvLWRlbGF5IG5vZGUvdGVzdCB5b3UgYXNrZWQgZm9yLCBJIGZvdW5kIHRoYXQNCnRlc3Qv
ZG0vZ3Bpby5jIGhhc24ndCBhY3R1YWxseSBiZWVuIGNvbXBpbGVkIGluIHllYXJzOiBpdHMgTWFr
ZWZpbGUgcnVsZSB3YXMgZm9sZGVkDQppbnRvIGFuIHVucmVsYXRlZCBDT05GSUdfQUNQSUdFTi1n
YXRlZCBibG9jaywgbG9zaW5nIHRoZSAiJCIgZnJvbQ0KIm9iai0kKENPTkZJR19ETV9HUElPKSIg
aW4gdGhlIHByb2Nlc3MuIE1ha2luZyBpdCBidWlsZCBhZ2FpbiBzdXJmYWNlcyBhIGZldw0KeWVh
cnMgb2YgYml0LXJvdCBpbiB0aGUgZXhpc3RpbmcgdGVzdHMsIHBsdXMgYSBzZXBhcmF0ZSBwcmUt
ZXhpc3RpbmcgY29yZS1ETSBpc3N1ZQ0KdW5yZWxhdGVkIHRvIEdQSU8uDQoNClRoYXQncyBtb3Jl
IHNjb3BlIHRoYW4gYmVsb25ncyBpbiB0aGlzIHNlcmllcywgc28gSSdtIHNlbmRpbmcgdjIgb2Yg
dGhlIGFjdHVhbCBmaXhlcw0Kbm93IChwYXRjaCAxIHJld29ya2VkIHBlciB5b3VyIGNvbW1lbnQp
LCBhbmQgd2lsbCBmb2xsb3cgdXAgc2VwYXJhdGVseQ0Kd2l0aCB0aGUgdGVzdC9kbSBidWlsZCBm
aXggYW5kIHRoZSBncGlvLWRlbGF5IHNhbmRib3ggY292ZXJhZ2UgeW91IGFza2VkIGZvci4NCg0K
PiBSZWdhcmRzLA0KPiBTaW1vbg0KDQpUaGFua3MsDQpQcmFuYXYgU2Fud2FsDQo=
