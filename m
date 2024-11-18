Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6E3D49231
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 15:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63DE89461;
	Mon, 18 Nov 2024 16:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ErshAmUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2F389468; Mon, 18 Nov 2024 16:10:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A5188FCE
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 16:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmUA+0Efqlan01AMue3UuoPW1U3Ud3knMFg8W5i5EFzBCU+2p/5EbL288cUJeDuLqnSttLL+4sQZaxDcPkWTxCMZ2PK0IfmxV+aSeO0irg51254G/PZ57A/7FlTCJ0Dzwp4iOSUmcdZ2F35IqQWs3/jbDngHujWamBJTWJ6Mqy1T2sd0H3IcL4Tf4ELW1jNqtnm2lU0b+zyP5arM7YY8KtzJQuhNPYXii+Q0XTFqdINDgftqaV02O+mEA/lj1fgJH5rSh/7gj6kDeNBBTk7XVIl3HjMP5/ItEkjZ/TotDi6i5ChFxm+GGIT3PkYcsCnE0v2MfngGvwdgBGRRleC2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMDu8iJOUEaLH38pyWgxptjEk9G83JkaNT2YawhOBJg=;
 b=Eqrp/JYJrKIxKRJ2ogk26XSfGyc00PXlYYsXnoM7IAC8xmLD6fRh4bixTkFrwrO2ZbodfpOasW8wznBQGza/Cg8Y7Rp/6xejHPgiivct5XPCeIWB5qhYQM/ag/QaLDGnKkH467ReiZev6mFY7dc4/AhsBAU5TKkHqgbsKeWjYrwep4Zhj8xOcGCPuOrGC9yfIGb+mlFvCvM6cleY1mJRMp1NlAOrlE+qVB7DGHrh0Xn/RZxUq57mZS0QOStOmTsMvCyQ53hnQ5viYNjZjXSMLdKDN0bgCn9qwQzRYWIgSoDk1rmEatnbeSIpKFr74skwXFan4Zmu26up3SY9Lj918A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMDu8iJOUEaLH38pyWgxptjEk9G83JkaNT2YawhOBJg=;
 b=ErshAmUhWjIa01e71VWzbaCXyF9gPN99PKw5pTpHlcARc8SugvVcYKCLqjFmQDfbsIW1x8mo1sZ26TaCFSQCuVMtzxY7jMFIllc9PqNP9qtQCnTV/+GmidrR4RqjsxwnqfUMrp/bfnwLeOci2uNBmEiPymw9u2LY0RV5jr/8uKg=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 15:09:58 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 15:09:57 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v13 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v13 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbObnFvROnGBVGfkarBxoUrTSMH7K9BVSAgAAe/wA=
Date: Mon, 18 Nov 2024 15:09:57 +0000
Message-ID: <SA1PR12MB8697FDC4A698C737ECE50E1198272@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
 <20241118100747.30121-4-venkatesh.abbarapu@amd.com>
 <f32d7e41-60dd-48ea-8700-a9545d02bfe9@denx.de>
In-Reply-To: <f32d7e41-60dd-48ea-8700-a9545d02bfe9@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|LV8PR12MB9112:EE_
x-ms-office365-filtering-correlation-id: d870ac4b-50b1-4cf0-e749-08dd07e310e4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3dFQ0xxbEJ4T20rZGRVakZrUjZkVEdJRkNwdDJ2S1F3T2MwUW8wYmp4ZmRB?=
 =?utf-8?B?VlFHM1YyRHB1Rk1mZThBTkRKTWNOZ0gvaDNCWEp5UGNSdmhEMk54UGpRUGZW?=
 =?utf-8?B?RVpuUEZYQmR2d3kxa1FnTGdhakpKbUJmNDNHZytUempzVnIzYmtHVWNic0dX?=
 =?utf-8?B?SW9HZi9Ibm56RUwyb0xGZFNxV2RxNE4xdzdhSnMrdk9xRUdwRlErelY3YkFw?=
 =?utf-8?B?ZWZmVlI2Z0xNajlKTGl0MzYwN0ZucTJycEtkaWh2OHp0ek15azhRelpWZW1h?=
 =?utf-8?B?ekhZMkNIaVdWMmZCa3RGeitxMk5NK2dScS9QTDFCcDhkNVB5MHJEcHgxWFZR?=
 =?utf-8?B?OTVrUmxUQUs5Z3VuWWE5NC9POXdNVFpNSUFxSDJibzV6ODJkWVdqeGo3bU1h?=
 =?utf-8?B?Mk9uZEtld3drVy9IT05DS3Z5WmtXTlg0NkN6Qnd5L1hBVjIrVnNqbEdncTVk?=
 =?utf-8?B?QjFtcmZLS01yY3IwQ2tsZko2T3JGdjFnYXBtelN4elN0MnJsV1QzbitYdmlR?=
 =?utf-8?B?VTE4Z0UyU0g5NlhhRld1K2lsN1RkTjY1THRKYWlUeDhoUWk3enl5RWFBMHV0?=
 =?utf-8?B?MzBkYUxkRVRrZzBjOHZMS0NYVlZBbkg3QmI1L21GbmpFa3d2TCsrSGNpUmUx?=
 =?utf-8?B?NjJjZGI3U3ZDWE40dmdDZVY0UkRyVVZQclNydnpQcnF4bWw5cVUzTDlCVXhR?=
 =?utf-8?B?TnVHSDRoU2tCdWJaVllWSGIyQVk5OG5JL3FKRXpOL0N3VnI1bjdTYkl4OEpu?=
 =?utf-8?B?cjUraDU3L1o0ZXVwNTRMbVVCR1JaNzQ2d29iWFNXck94ZE0ySVBYR1VIYmNp?=
 =?utf-8?B?ZGhWdll2YW1hV29IYVQ3TS93WGRCa2YyUS8wdVNQNFJjZXFmTGZoTm4yNTV4?=
 =?utf-8?B?M3ZnWHRUNGtnVS9HcUszeGVVcmIrWnBlL1k0N3JMd1dDMkJSMnpOUEJFWmNm?=
 =?utf-8?B?Vi9xNmdidHJpYzFWZWd5N1lhcEhsTGZxSlFkN0F3dWIzV1laUG15dXhqMitr?=
 =?utf-8?B?ejlVQ2tJOVE5M2JHSE9pUGx5eE9ZNUE1Z1ZoWDRXcU5WUjV3SDRkcENaVE1a?=
 =?utf-8?B?SStRNURLcUxuRlNLeEFQV3NmZzFZck5SWWkydkt1eWZLK0xUSXhkQWo2ZEh5?=
 =?utf-8?B?ZnkwYXhraTg2SjFuV2h0b1ZxeDRQODZ2Z1dNamFSN2IrZVJ1akZzTWk5RTUw?=
 =?utf-8?B?SU9wS3F5eVREZDFSY2duRFdUWmZacktUV200NE5kNnNxVXNDTmpHSzZ5VStC?=
 =?utf-8?B?QnpvRnRPT21TaCtiMFVEYnVwVGZIWGViQldRV0RMMkNFMnFSL09zbGZXTE5i?=
 =?utf-8?B?Q29nS3RFT1ZKYm4wcDgxSGtGcEdoM3BUY3g2L05ScFBsanBzZUZpZWVTbVg0?=
 =?utf-8?B?ai9rT2VncEI5VC93NFA3VzgxY0tRT0VPR0dvLzlvRU1JZndCTVQzdXBGbmlS?=
 =?utf-8?B?b0FIRDhSQnJUSGlNSlhZN2YyVzVHSno1R0trdjh5WDUwQlpYczlhbldOTW1R?=
 =?utf-8?B?U1E1aFp3MzFta0hNV2FXVHQ0UWNBVUYydUxTa0VNaU9Ja01CVVg5R3Eya2pk?=
 =?utf-8?B?UUx6eWVwTEV4c0ZiSi84V3VLOHhFM1FTUkdXeWprQmo1TzllWG1SajN3TFQw?=
 =?utf-8?B?OTljKzkwL2Q2UVMvb0p4RklDYytxQityekFFTmFqSExZSFRRUlRvc3BiRnlh?=
 =?utf-8?B?YU9QY0FKRGV4c0wxYnZmbVFOcmFQN3RYVWhreG9TMDNJb3lTeWRVWVkxaVYv?=
 =?utf-8?B?a3dMZHNVRmx4OHQrS0VkOXU4TjBhOVdpMXU4UlNwbGFib0FQckRyODQ1RVFQ?=
 =?utf-8?Q?BJTNGTwYFnx+BkX4Kgt9usYNl1T324VghHlCU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UitVWkpTSmptRGZtYzFMMzFWM25pMGhOSUtEQlROeU95VUhZd1pqMTc1YmNh?=
 =?utf-8?B?N01HQTExTnpjUHpWVVhnTTVaM0pJaGdKd21Ud2laRENHdHBzTTJuK2pQNVkw?=
 =?utf-8?B?YXlTVjhRSlZLNzVVaHZ4QWlYNEQ1VWM0SWhhQ0I0RkV6WDA4R1AyTHBaeG1S?=
 =?utf-8?B?TEwzYWh4TG5URmYwcy92c2d2eFRHRnlMTFdwRDcwQkl0OHZFb3phZ1d5Mzla?=
 =?utf-8?B?bHNwU3JaTUF3NmtUb1pUVmp3QktwcElpbEt2SlhQZWI3bVowa2NlWEllSUx6?=
 =?utf-8?B?d0RMTUVabUdSZHoveVh4UnIrelhLMnNmVmlJSy80c244ZmJnZnRLRUVVY3JH?=
 =?utf-8?B?V0QzQWczUHN5QmNBaFc5Yy9GMklXUE5RYjVuY25ScjlaRU94WmNOaUIvYkZo?=
 =?utf-8?B?QjFBRmNIWFpKTW5EV1hocE9wdjJWcFBUMTdVSkFNZkxYWjN3ejgvdm5VMEpZ?=
 =?utf-8?B?VWE2T1IvYjlWTWRzUGovenN2dTVuVGhiMWlzZ3IrbjZ6MjNCaXNaVnViM3JP?=
 =?utf-8?B?cWJoK0F2RWJKT2NTRDQwTkEvTWNnT2JrZ3FobUJ6cHFVSzZIV0s3NnZVY25a?=
 =?utf-8?B?ZHU4VjJKRUU4a3c5L2lUYkFTZmJLRUhRb2RQa0FaRjBtanRjMDE4UENBa1J5?=
 =?utf-8?B?b1hMeXM4aWNlbHo5Z0hHSVp0VE9NYVFoTjZZU01LYklDTzQySzhKZDB1NUFF?=
 =?utf-8?B?eSt4cHIzTXVxbkNVMGNveWY5TmQvb1UzdVl3V1hwVVJWV0FZZHQzS2F3RTdN?=
 =?utf-8?B?TVluTCtSSkJVa3IwdG53am5FVllDZFhUNkFNUGV2a0tGcVgxaXd3T0NYWms5?=
 =?utf-8?B?T2ZCVmtCWWxVa2xpclZCOUsycCtPWHdOa3VGb2JYK0xVRzB1UWRVQ01TMjEx?=
 =?utf-8?B?ZDJEdlRJUDNzV2svYzY1M3Znb2NyQlZsTVdORjN2bi8rbk94TUhMaU85WGN1?=
 =?utf-8?B?cjczMURtL3BiMzlZaTZSUnBwcENQckF4UTBEdGFMMjZoK2VkWUYxelVSR2c3?=
 =?utf-8?B?RGt6RlBTOFVCSjhDY1VhT1NNU09YVStRamFzSGpRQ3RTb3VQVHRmeWs5RVVV?=
 =?utf-8?B?YW1sTEllNWZENFBIbmwvTzI5NEQ4aEhIUDRsaVdqTTdESEhJNVM3UldaQzdX?=
 =?utf-8?B?YVEweFVLNkxqdEY4dzhwMjRSclN6c3pWeXBIQ0xvQzVtWEZBbEMrUUQyVGNn?=
 =?utf-8?B?cE5tTTJkZXpyaHlhZVZpTVNsUTRSQ05pT1E4MXhnU1JaS3dVL3d4TEhaV042?=
 =?utf-8?B?M3FITXN1ZDFlMEVMYXJIUSs3TXdWRlIvb3FUVE5HLzJSUDh5YVpBWk1qVkhO?=
 =?utf-8?B?b00xSDlQZzRoNmpTeEFRK2V2bXpIekU0U2VzMVZ4eFZheG5XMSt4MVFkNTh4?=
 =?utf-8?B?N3F4SGU0QkZUVVg1MGdrSEt3bUZiUHFjb1ZVSUdSY2w1SzB3ekxGTW5tN0Vt?=
 =?utf-8?B?VGptNkxvOTBySFR0WTJzU3dSYzZTRmpTaEVLcFdrak42Q0R3ZWRodmVXVDVl?=
 =?utf-8?B?Zy9pUVhGdkY0cUJRekFZYXRVUDU4SFVYOWtmUkZsS3NwRk9CV2o5TC9LY2hL?=
 =?utf-8?B?Sm9TZVk3V0hwOUlkaUNEV3FOWGxGM1p1UU9zbXhMTmtRcDVEd0MyUWNDTjI2?=
 =?utf-8?B?L3ZRaTFkLzk5dm52Z21Gd1NPOG9VY0oxNVRGZkRWV1g0T0JjeWtZNmh4SWhC?=
 =?utf-8?B?dTRodjNHMU4rV1N5Y1VWVVFsZ042TkYyUHhMbXdiMVBia1NFRnIrVVBYMS9M?=
 =?utf-8?B?ZXZNb2FYMnN5aEw0SmQrVU5rYzdkTDNLK3BUb2pkbE9mUGg4a2FKM1B6YTlv?=
 =?utf-8?B?SXNrMWR4Y2NvdGErRGJQL1dZc1NBT05EbHRRZ0NNTHd3dTczbzBneUN5TTha?=
 =?utf-8?B?YlF0ejFHKzRIc2Y0dFYrSjZvMGE3ZUppa3cwOFJEQWpONTM2VC9ubFprYWt2?=
 =?utf-8?B?YjFmM3plOFBBWmxUallWMjQvWWpzY2ZSR1hiQjJCa0VTSXZDTHh6N1lrWnI0?=
 =?utf-8?B?eWpqQVpEdGJmY05QRTcwWVlVSVdjcFZSZjR6SUlwRlY1Q3VLVkJuTjg1Y2kw?=
 =?utf-8?B?dnhUVVdaQU4zaEdsajB1K3VmMnQvV0dFclBpN2JqK3hvN3BUMEFiVHdOaGtt?=
 =?utf-8?Q?bwJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d870ac4b-50b1-4cf0-e749-08dd07e310e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 15:09:57.8456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iS9YEptLnNjxbtL5cB/6DMBRCprnuZSGTCuu04cOcw2rSS9XU1RKDxMTKpUjZITgJppwZ6ZTH4T+k4FgMjMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgsIDIwMjQgNjo0OSBQTQ0K
PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFt
ZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAoQU1ELVhpbGlueCkg
PGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMyAzLzddIHVzYjogb25ib2Fy
ZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXANCj4gVVNCNTc0NA0KPiANCj4gT24gMTEv
MTgvMjQgMTE6MDcgQU0sIFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSB3cm90ZToNCj4gPiBBZGQg
c3VwcG9ydCBmb3IgdGhlIE1pY3JvY2hpcCBVU0I1NzQ0IFVTQjMuMCBhbmQgVVNCMi4wIEh1Yi4N
Cj4gPiBUaGUgdXNiNTc0NCBkcml2ZXIgdHJpZ2dlciBodWIgcmVzZXQgc2lnbmFsIGFmdGVyIHNv
ZnQgcmVzZXQuDQo+ID4gVGhlIHVzYjU3NDQgaHViIG5lZWQgdG8gcmVzZXQgYWZ0ZXIgdGhlIHBo
eSBpbml0aWFsaXphdGlvbiwgd2hpY2gNCj4gPiB0b2dnbGVzIHRoZSBncGlvLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJiYXJh
cHVAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+
DQo+ID4gLS0tDQo+ID4gICBjb21tb24vdXNiX29uYm9hcmRfaHViLmMgfCAxMSArKysrKysrKysr
Kw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9jb21tb24vdXNiX29uYm9hcmRfaHViLmMgYi9jb21tb24vdXNiX29uYm9hcmRfaHVi
LmMgaW5kZXgNCj4gPiA4MTJlNzc0OWRlLi40ODYwZGU1MzIzIDEwMDY0NA0KPiA+IC0tLSBhL2Nv
bW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+ICsrKyBiL2NvbW1vbi91c2Jfb25ib2FyZF9odWIu
Yw0KPiA+IEBAIC05MywxMCArOTMsMjEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvbmJvYXJkX2h1
Yl9kYXRhIHVzYjI1MTRfZGF0YSA9IHsNCj4gPiAgIAkucmVzZXRfdXMgPSAxLA0KPiA+ICAgfTsN
Cj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9uYm9hcmRfaHViX2RhdGEgdXNiNTc0NF9k
YXRhID0gew0KPiA+ICsJLnBvd2VyX29uX2RlbGF5X3VzID0gMTAwMCwNCj4gPiArCS5yZXNldF91
cyA9IDUsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1ZGV2aWNl
X2lkIHVzYl9vbmJvYXJkX2h1Yl9pZHNbXSA9IHsNCj4gPiAgIAkvKiBVc2UgZ2VuZXJpYyB1c2JW
SUQsUElEIGR0LWJpbmRpbmdzICh1c2ItZGV2aWNlLnlhbWwpICovDQo+ID4gICAJewkuY29tcGF0
aWJsZSA9ICJ1c2I0MjQsMjUxNCIsCS8qIFVTQjI1MTRCIFVTQiAyLjAgKi8NCj4gPiAgIAkJLmRh
dGEgPSAodWxvbmcpJnVzYjI1MTRfZGF0YSwNCj4gPiArCX0sIHsNCj4gPiArCQkuY29tcGF0aWJs
ZSA9ICJ1c2I0MjQsMjc0NCIsCS8qIFVTQjI3NDQgVVNCIDIuMCAqLw0KPiA+ICsJCS5kYXRhID0g
KHVsb25nKSZ1c2I1NzQ0X2RhdGEsDQo+ID4gKwl9LCB7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAi
dXNiNDI0LDU3NDQiLAkvKiBVU0I1NzQ0IFVTQiAzLjAgKi8NCj4gPiArCQkuZGF0YSA9ICh1bG9u
ZykmdXNiNTc0NF9kYXRhLA0KPiA+ICAgCX0NCj4gPiAgIH07DQo+IExldCdzIGZpbmlzaCB0aGUg
b25nb2luZyBkaXNjdXNzaW9uIGluDQo+IA0KPiBSZTogW1BBVENIIHYxMSAzLzddIHVzYjogb25i
b2FyZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXAgVVNCNTc0NA0KPiANCj4gSW4gdGhl
IG1lYW50aW1lLCBubyBuZWVkIHRvIHNlbmQgbmV3IHZlcnNpb25zIG9mIHRoZSBzZXJpZXMuDQo+
IA0KPiBJIHJldHJhY3QgbXkgUkIgb24gdGhpcyBwYXRjaCB1bnRpbCB0aGUgZGlzY3Vzc2lvbiBp
cyBjb25jbHVkZWQgdG9vLg0KDQpTdXJlLi4uVGhhbmtzLg0K
