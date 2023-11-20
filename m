Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708DC54FB9
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 20:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B82874FC;
	Mon, 20 Nov 2023 21:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=matrox0.onmicrosoft.com header.i=@matrox0.onmicrosoft.com header.b="L3U94axH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CBC867E2; Mon, 20 Nov 2023 21:21:55 +0100 (CET)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC9D87581
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=agendin@matrox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOHVyYw7RU1YYBp777e3uwZz0ljiPQd070ykEn8Y3uF2Zn9nOIgDOBK9+tzz4XxgHVSGq6/FdknOz+5vIKqn0J2ArUmws4kJBWBBzFTJYqESYFA/zHZEEqql7wXogwQNv9qk6nkskN0RQx6PCLnRAgxMu11dBVn41IE0FxuJzvghYW3iPgBELNrM42prtUAGqzjJyEsvbTknh5bV3ADMN3ZCMIwVBT1YfLTXPBPqgEwJb7XWzDf4jYt5f7UMw9rX/6d5DlSf5H7aGO3MnyEaPgb0iPEyfB79QJsfEV/sL9Ch+nMBfI3ip95eBmZWrkoHIyC31vXgj7bKlcv/B2p9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwgSByvaeELvnVIXyZIdAmplujPWm3FmWg1DHLVdGLI=;
 b=enu7mg8bzhU8tyg7zfihGPgngYd07Q21kbpJBIfy6bIg6zlwdDOlviJOwe7rNuVIEnwx2IHmBNzxvTSXyKxSeIV6cdXee9D4E9qQPA4+hgcXA+vP34+84fnSsciqzoVrd8wfcbB/sXif5PTe9kksDDg5wAEiQSnNLf41gHkDC8aoFZ7O9Daf0dAVwuEbNzevonJ/J3AXo7fndbyUTdBAaQrnMgSEvZepaz903ds0w2EsJG3Ykm48Y84gWedl+NlZWGcNkj00+aIEk+acdlgzZTQ0zHg/u/5jx5PNYAGrLr+lean5CSa1GodmlSEzdrlEPElg7sCQFi8fXLjfJ2VYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=matrox.com; dmarc=pass action=none header.from=matrox.com;
 dkim=pass header.d=matrox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=matrox0.onmicrosoft.com; s=selector1-matrox0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwgSByvaeELvnVIXyZIdAmplujPWm3FmWg1DHLVdGLI=;
 b=L3U94axHLJjwo13rzepH3KAXrt80V9LDT5TCLhpOv6C7tGWKLgVdJdmXXwOQeY3aDtmlSwH//L1ShvlpmO87NZA2zkD/6sTtwz7hf+JpxTtPxJkLJhSKg6K2+VndsBb1E4yr9213fBzqHUg1+tbDZejH9hUMq9nGKYNDuRW5psI=
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::18)
 by YQBPR0101MB8446.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:55::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Mon, 20 Nov
 2023 20:21:51 +0000
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2980:e9c9:35fa:f866]) by YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2980:e9c9:35fa:f866%6]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 20:21:51 +0000
From: Alexander Gendin <agendin@matrox.com>
To: U-Boot mailing list <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] drivers: misc: Kconfig: Fix SPL_FS_LOADER prompt
Thread-Topic: [PATCH] drivers: misc: Kconfig: Fix SPL_FS_LOADER prompt
Thread-Index: AQHaG+8xozjIXlzQKEKDwm3PfI1yWQ==
Date: Mon, 20 Nov 2023 20:21:51 +0000
Message-ID: <ZVu_3pxqP7Xg7DTn@alg-gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=matrox.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB5626:EE_|YQBPR0101MB8446:EE_
x-ms-office365-filtering-correlation-id: b7296bf1-392c-4aa7-5746-08dbea065482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gxtb+Wmv+kMlcUnddaUW9j5xsFyMH9UfKHmarc5KO3SkMQ8w5OaG/0FlpWQ+efpwGyZeydnDdHTPHALcq9NTSva2Ym/cdA+b6WJSk1k4pnJltJE06kStkRAkPmDF73sjbLaSpnBkc3LyDGGMpMw8w3G30GtuIDRS/VC36gutZOkq2qOhLwGLbH2VSUaAz2ciIOLRCJulPPtZifPAKF695JNCLAlXTHuFQOgkJF6LmtpnInK+H42/thTeTYXV/3c2FdD7bN/yNls5sQkfzX9Ed2ZogcFsv6l+xnjCztn7p6AlGVe93t0KsmZx2FfyiEBs7I6iF5VkjkkfqMFOytQpOb9+tuNdDu0vQ8/2uxRNm+vDl8FKgWfc/sH0BoRn3hzpw18pBtIJ9gF65ogFyIUD/4HRGnx67G6pWYd8RW5O7HvBT5IHYgH5pON91l4Y1/UPpaJjRqA1J+rXcfcm/kx1ypsE4gQDZmqMaTt9/UjSStxxnROfbajOb8UTSUFccC7y5H48b3KNkhTJrKIwocegZGvKxyvQEg7NxVydiTs79snlP27txtbyEXKg1P/+0KbYHW7WF9cQ2bZ5SETCjiAxk4DYcahlcXJqsCev9wfGjxM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39850400004)(396003)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(4744005)(5660300002)(4326008)(8936002)(8676002)(38070700009)(86362001)(33716001)(38100700002)(66446008)(41300700001)(91956017)(122000001)(76116006)(478600001)(66946007)(64756008)(66476007)(66556008)(6916009)(316002)(26005)(6486002)(83380400001)(9686003)(71200400001)(6512007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEd2UXZvQ005cUQ2MC9PQ2Q0Uit6MEkvelg0d0JEZUxrdlpSbDJRU2s1bHE0?=
 =?utf-8?B?VUlra0g5SVIrcDg2YkpUS1lGTU84UWpqRE43R3R2clNWNHBGWjFjc2VoQWtZ?=
 =?utf-8?B?d1ZSSklvT21oWlJrdUR4RzFyelJ6ajE0UGdJODVDY0xCMXpJQkVPOU51S3I4?=
 =?utf-8?B?NVcyUEdZRkhkM0pVS0ZRai9Td202Y3pDZTl0MVJjOXFvNW12SjZIY2tVQ05K?=
 =?utf-8?B?R1JFRnBnZW1odGtoYzlVNkVBcHQvcGlJbzJkMVR5MUxMdkduZm1JbzdJd1BR?=
 =?utf-8?B?ZGNyb1U4ZkdIMCthMnF1Y3JVTVNTd1Q5VkVTOXRocXBReDk3OG9aTkZic1d6?=
 =?utf-8?B?Q256cWtvNmhwcStuOS9aWFEybFkvQSs3bVFrRTlsWFR5cWFFNGpRVENDTCts?=
 =?utf-8?B?MUwya1NKemVBTitxMERZTTJET0lmSDhFVnNRaGpucllEcjFyNVdMRVhrMXB0?=
 =?utf-8?B?eDl5elFNMlUzUktXVlNZSWdsdEJHdWtHVlc2NVJrZnN6QU9HbVk0WmI3WjF4?=
 =?utf-8?B?ZUxwSEE1WVFWNlZuRUlydHNxLy85dDYrS2JiN3M2RnI1Ny9CdVRjNUFOMmFs?=
 =?utf-8?B?Sk9IVmJkY3lXZGNzUFFHekZHN0hBb0NqbkxCd2VtN0oyL0xTN01sRkRkNDhw?=
 =?utf-8?B?ckJuQ2VmMHpVU0VCY0N6Q0RibGcwVVBibURLSTZWQkdRc0FQb29BUXc4dy9O?=
 =?utf-8?B?M0NLeGtPTG0yTk1SK3VUYXp1K1dVcGZhOENVNjIxbDEwMy9acmhneHczVFNX?=
 =?utf-8?B?UFRud0ZkVWJKVW5sL2pYYXBnTUc1czNSZ1I4a0twN2tMQmRzb3VEdkNjb0p1?=
 =?utf-8?B?YzE1Um9HZFFMaFZOanNmUFBlQVh1RGNPZzdTZlI3RFo4TXA3V3BPZEVLYUZa?=
 =?utf-8?B?M2dlNGVyb1ljams2TEZNZ0NaK3pONmR2NlRDZHJxZzdldUpXVFdlY29rc3Iv?=
 =?utf-8?B?RUlycElDN1kyUkxCM0Vlb0ZhNlFvZkU0Yktsa04xbVd1REJZT0V6MDZIamJF?=
 =?utf-8?B?T2d4aW9GVHZ6Q2pPTTNMT1RjeWtaQTVuVnNhenFSU3BlUTMrL0NJVVJrTnJZ?=
 =?utf-8?B?OEpsR0ozeVNydk1CRm4vU1hnYnJ5S1Q0YzlOZ0UvWW1ibER2SWQyTUNUcUxU?=
 =?utf-8?B?aWh5WHJmQ1hWQklnSUpNVk12bFFnaDhmVEpKcVVnNWZpNS9FRE92UmxmK2ZC?=
 =?utf-8?B?aHdOclJubXJ3SzVKM0FJbGkvVmhsVjlWQTZ6TGYvbmp1NkhJWnk4eWx3V1B1?=
 =?utf-8?B?azh2VFVJRmNPVkZRQWwxWVNmbTJ4UDMrM2ZxczMveXVkTkxESm8xK1hqa3N3?=
 =?utf-8?B?cVhuVlZ3cFFyaTEzMVJvOG5HblhyOFdjS0QvYkl0bFdjVlkyVms4VWVFdSts?=
 =?utf-8?B?RUhuZGphTXBCUFlqUTdmUXA1WlJsWFM0TU90cjV2bkp6OW5aK1oycXFwcWky?=
 =?utf-8?B?bmVuWUl3RVVMTXRhb0dsRWVVcDl4VVQrbUQ5NWcyN0FMUnlaRFA3MlBVMGVO?=
 =?utf-8?B?aHZvOFFsTDhxZFVnU3Z6WTdBa1ZHdFFtcnhiRWVBVmlHWjVEOVBnd0F3alRs?=
 =?utf-8?B?MVM4RFM2WTA4MEQzMmQwMzhRdlFIKzRMV05LT0hMRjI5ZDVHNEF3WnlCTkpX?=
 =?utf-8?B?RUJVY1prczhSSXNsOGtSZkpMaEJxSld5MzI2eVNwQ1BkeFRidGNDM3hmSWg5?=
 =?utf-8?B?T0U3a20yU3FuZzFjS1RaWGpUdXlwQnRSeXhSZFhxNVhkOHpDSGFTdm5WaDFt?=
 =?utf-8?B?d0RaS1p4WWdqZ2x3YmpvRmxLcTZwQkx0VUpxQ1UzUWZRMlpCQkhTY2ZvQWZx?=
 =?utf-8?B?YnNqL0FkMlMwVXZIRXdFNmFMV3E1aUYvTERWWFppTThjRXBvcUFKOThuQ0hu?=
 =?utf-8?B?Z3BOQjBXSitvdkdudUNKTC9yNFFPZE9yaEdQNXl0S285Zm9WZlFlbFdlWjJB?=
 =?utf-8?B?VHVEUi9TaVUvOEVuOVRNSVZuMGxlbUpVdHM3S0Y0ZU5nZytta2lEQk5yVnpi?=
 =?utf-8?B?czRMQWVwb1N0RGZmL0dLQ0pJREZIUmp1MWpaelVZdm16OVoxOFBZRDdSSEVD?=
 =?utf-8?B?d3ZNa0RkZWZYRFBCQWZWWHl2L0FjVmprVEJDR3AzZUxGYjRpbThHa2RiWjcy?=
 =?utf-8?Q?gkSgDJz/MZRWt7aJwTV2sxsD5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B590B1AC6F9B742B7A4510575927720@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: matrox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7296bf1-392c-4aa7-5746-08dbea065482
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 20:21:51.1070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 09c2e324-8cf7-459c-b6b4-e23db24b9d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+O0v/e1fuO5nhi/jzdFmrVmtUifcEHmI9OK89ZAFumbHzxwYp61uuyjQ2zoBZSjC+zc7T5jxPEqNxjrlg+Fog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8446
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

Qm90aCBGU19MT0FERVIgYW5kIFNQTF9GU19MT0FERVIgaGF2ZSB0aGUgc2FtZSBtZW51IHByb21w
dC4NClRvIGF2b2lkIGNvbmZ1c2lvbiwgbWFrZSBwcm9tcHQgZm9yIFNQTF9GU19MT0FERVIgZGlm
ZmVyZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR2VuZGluIDxhZ2VuZGluQG1hdHJv
eC5jb20+DQotLS0NCiBkcml2ZXJzL21pc2MvS2NvbmZpZyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWlzYy9LY29uZmlnIGIvZHJpdmVycy9taXNjL0tjb25maWcNCmluZGV4IDk3MDU3ZGU4YmYuLmVk
N2VjZWRkM2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21pc2MvS2NvbmZpZw0KKysrIGIvZHJpdmVy
cy9taXNjL0tjb25maWcNCkBAIC02MTUsNyArNjE1LDcgQEAgY29uZmlnIEZTX0xPQURFUg0KIAkg
IGllLiB0aGUgRlBHQSBkZXZpY2UuDQogDQogY29uZmlnIFNQTF9GU19MT0FERVINCi0JYm9vbCAi
RW5hYmxlIGxvYWRlciBkcml2ZXIgZm9yIGZpbGUgc3lzdGVtIg0KKwlib29sICJFbmFibGUgbG9h
ZGVyIGRyaXZlciBmb3IgZmlsZSBzeXN0ZW0gaW4gU1BMIg0KIAlkZXBlbmRzIG9uIFNQTA0KIAlo
ZWxwDQogCSAgVGhpcyBpcyBmaWxlIHN5c3RlbSBnZW5lcmljIGxvYWRlciB3aGljaCBjYW4gYmUg
dXNlZCB0byBsb2FkDQotLSANCjIuNDEuMA0K
