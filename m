Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51C9D41C00
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 04:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB6F89586;
	Thu, 14 Nov 2024 05:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxL/zJ47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0C889584; Thu, 14 Nov 2024 05:16:09 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608D989586
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 05:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+4g8TWOYYR/KVb3hgH9B9AvZFBIZFkLsW4a16vesUwu9IxNqHTURNV+s30YL+I86Wzchy6aZC8dMjzFUbv/oDHcEKSN3ZFE54PqSjF1sxD4KUahymmAMqTxEdtx6O3x/+9btKkEBcpPs6E9+fS1NzrCPKLez57+U5A+YNNy5zXZAIryN6kFthGCDYoykqVg74KioOpJEwQNr9hkif/rCmiqA0heTXrXrHNbbQ0B6WVSTHpqGU+62tyW9sMheLxIBOEvtVlVlN8wqmFSJhJe+I0ip6iMbMUOryfheLHD6fNcVjxGQrbqg0g9fEmpRXA5YjiH78oDZDa4QKIjFMlwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p3dqfojC7N5n67LR9vsB+HKKQQ9ayuZxd51MzYtQp8=;
 b=ySXFzhOn/qHN1KT1BK0wBBRlCk9CoIZzcKeYOaJh/O63VkTYIujnsNiIaW7atRivWnjm3YKmBY6ffTVf5CmrdEPJ48hlnFkwUXF78nvGrKlUYz1a+fSmOwJoJciCbUUsroFurWa35Ld7qYwO1HuQiWBNsHHkC57XS9/2k3Am3D1XPKcvf/LkER7vU7xQChabVLLUzs3JFzCSY4iRhKhVS2jHVmAeUgr6bfQ+j99lSYXzfCjk7OLwy5f81dPdY8hSUdb1FdLI8diG69SJHlREQtjXP26fbpOOAp+GVcrYCcLw30Kns6+UZmLT81egKfYmyWfKTl8E4Um86wAp/htMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p3dqfojC7N5n67LR9vsB+HKKQQ9ayuZxd51MzYtQp8=;
 b=NxL/zJ47JTujT/WNsMZmrA7gdolISap+ew2pI0HyYTcgN5/4BMqRtm1FUhBIdiFXorysxUS3fELS4rOkhIk47lgFDfBslL/APBTUmFvWeaXnkUaEmRoGMIKANhY9NHy6bZa+3G0SDZQOB3JROBQBLLOpzRTrW1MDAH7oGK7hHuo=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 04:16:01 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 04:16:01 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3Q
Date: Thu, 14 Nov 2024 04:16:01 +0000
Message-ID: <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
In-Reply-To: <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|MN2PR12MB4127:EE_
x-ms-office365-filtering-correlation-id: 437be7a5-b30b-4f87-9691-08dd04630c47
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2w0R3A4K0U4WTI0OHpCRDBYRk53VUxFOHNnNCtTd1pRZFFMSmRBWm8rcm5H?=
 =?utf-8?B?MnR1ckdFY1ZvcmFtUXB0Zi9VMXM1NHhvRmJNSHJLNVB6UHFHT3pzYVpZdENp?=
 =?utf-8?B?WTJydy9zM0ZzVm5oR0NjYTZlbzFPOXNJc1VLeGlkYXFsai92TU81RDlabmo3?=
 =?utf-8?B?RXFxTnNqYUI3RVg4UEJFU1FrK1p2ODVoOXdnMGxaaW1wT2c1RTcrMGpKRktx?=
 =?utf-8?B?QlhSMll4VDByRWxzdXFvdjVoYk00NTlQWnZPaGl5MWhid3BVNUlGYWpKdnpM?=
 =?utf-8?B?S1dtVXRNbFZDenpEcytHb2dOVkJkZVFvSmpYUkJYdndtbUlCOU1hZWVnTW9k?=
 =?utf-8?B?TEFJWHVvNW9KYWNwU21uaU1TQ3RMNnc2SGJOYkhyQTAzcEJVcFI0T29rUnc2?=
 =?utf-8?B?TS9yTGFXZy9kRjllanJhTUtYNnd2WWZmdFVlU20wUlZEdk82ZWRYU0ppVHRJ?=
 =?utf-8?B?RTlGeXNZc3NVMDZSamVTa1MxVUVoNVlyQWpVMGlzZER5citWbXhMRjlSTTRm?=
 =?utf-8?B?Rk9tSVpqMlprOEVnSTdCNzY5SDFuMXUvOXNUTWRvcmgzVTVNWEhMVFJsc0V2?=
 =?utf-8?B?U0NQYTVFWDYrWjNOUndhZjVhS3J3UGtrQm5NWTZPOWNMYVY1R2hlNGV1OHZ0?=
 =?utf-8?B?NUtiSjZkSE1TQ3V4RHNnQWhTclB4aTJ0cXFYLzkwYXJjazdZcWlOWG1WS2Q5?=
 =?utf-8?B?eWtXUFhtdTV0eXJ5KzgvQzFadXFlSy9NMjI5OGdSQ1lFc0dEU1NURFljTy9Y?=
 =?utf-8?B?S0xhQm5IUTRRSUgxb1Y0eVRhSEdvTGRmR2ZKR1FlYjBhTmlqdzFyVXpBWUZq?=
 =?utf-8?B?WlIvWFV1Tmo0UG9rTmZMV05qcy9YMlNKZndSVXhmMEdvYUFtTUF5dkpkWW5F?=
 =?utf-8?B?dFVlckNoV1pUbERHdHlGbWFjNU1tYWV1N3h5dWwxcTdDYlU0OWRQSVZHNDVF?=
 =?utf-8?B?a3pTbzhHNEdKaUU0WHJkRnlja1k2QnBVQlFvVGlseUlHdnFhbEdXVW5Fdk1T?=
 =?utf-8?B?MVpLOForNTBJaWdicTM0dGdLaW01b01EOFpSVUZFYUwvZ25WNzBXR0ozMlAx?=
 =?utf-8?B?ckN6aTkrZVpCak9kWFZCOEtDMGNPUW9LRzlTMTNVTGRxVkd1dDFTaXpBYkJ0?=
 =?utf-8?B?RVl5UlRCeG93SThiY0ltUDFoS0tPVU1aT1g4UzdaWTVvaDZtbHhMc1djdlBu?=
 =?utf-8?B?SmRjb1NkVUFkRTNZcWUvRW9haTliWnBOUXNHZWFGTVBBT05valpZMk14dnlB?=
 =?utf-8?B?cGlBRlZsb3lyTVgxYVRhcE5mU2VDakZxVklKdWk0WFB0V0RIVkI1ekdXQ2ZY?=
 =?utf-8?B?WFZhTWxUcXJxeVJMZG9TV05SVXFPeGNZK2dxN3MzMWVuVFlxTm94c2Y1bmdv?=
 =?utf-8?B?RW83TXZBbHJpM0c1Z2xFb1hROTR0V1NmTVA3dXZUL3E1RVFaeHhOMmhLTWhy?=
 =?utf-8?B?TkJoQUYyWjY0RnB6eE1vUFBLR05IeXpURUVWRDVaSnBQbnc5ZUNGb2NjQ0dX?=
 =?utf-8?B?QTRtN2JCTDBJeWhNY2pzYm5MOFQxdnZsN2g2WTlJSUVxZTNGVEZjaGs3bEFP?=
 =?utf-8?B?UEFKUzZNbDBVQWV1ZmNiaVVYbWRVZ0xtb1NobHlVUlFOK04yL2FNbHQ2bUVy?=
 =?utf-8?B?NkdZTHB5NW5DWEdtSWw5blRvNjRGdXV0bmJoL2hicmMvaVVZR0xSalF1bEJN?=
 =?utf-8?B?UXQ5Si9ESFFRZWMwS2JrS0E5QmJPaEUwdUdiUWNMU2dodWo5UWI4REtpbGdh?=
 =?utf-8?B?ZkZTYUYvelgrMGxuZzhWZ3lCVXRlNzl1SDVQQlFEeEhSMXJzc05UMEtnTUZ5?=
 =?utf-8?B?enpjTnlBNXRheHd4K1VKQVdsblovMk5rbTJocjhGRzFiSFdicnk3SWdHYXhC?=
 =?utf-8?Q?XtLlqSAMfiM6H?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2g1cUNsdC9ndHFiRzU0MEhMck5JazJPVWpKR1hZVGo0OGF5S01qeFZubGds?=
 =?utf-8?B?QWpzTU9uZlpjaXJRSVZJQVhudkFTb3RYanptajR0SW9YU3hETmxZaXhNTE9p?=
 =?utf-8?B?QUoxcGdzNG1yR1piMURRSjl0V3o4cXEvVzN2S3JKRGdBaXFzNGNjV1cyTGR3?=
 =?utf-8?B?SU9RR2IySHdpeUFiYlo4dnRvQ0tSa3crcTJrblhhRldrRGt5cHpkVzJrUHdK?=
 =?utf-8?B?TGdUaHlFWmtYNjliWGVIQ1pNK1ZwU2RiWnEvRHZDMVZUVzc4N2kzR3dtL09S?=
 =?utf-8?B?RHc0KzhzV3ZmL3dPazR4d3U4NnJqQTFWQndhU2pUN2pST3I1OCtlSVA3OENM?=
 =?utf-8?B?UmNTVkkrZXJjY1EzMWRGdEI3UCsyUi9BZnE1c1dmc2ZkQVJEWXM5MlhoTVhB?=
 =?utf-8?B?dlRwVnpqSXYzMk9ZZFJkVVhZdEN2QzdDTWdoeXVZYWhneGs4MG5VWXlJTUta?=
 =?utf-8?B?VzE5eEJFNGVVSDIrbGtDaGZUWndQaEkweVFyeTVIeU5LbFZUajZqS1hVZkNa?=
 =?utf-8?B?Q2h1Z2hNWWo1T2ZFdHN4ZVF3VFBlTzlYM1ZFZ0JYYVg5Z0VQK3pDMHB6Q21M?=
 =?utf-8?B?MGpOQkVlc0hnYmM2SE80dWJ1eDBDWEdEVGhhdzJ5MDZRZnZwRC9Db3hMRnhm?=
 =?utf-8?B?OVIrZ1NKWjJ1bDVManMzNEVCUkFSeDFJRk9vUUdnek1OZkd5b2ZRM25jeTdG?=
 =?utf-8?B?RVZBa0JFcTExWGtrZ2xLZUFpeVdLeFI4VUtONjZmcUdvVjkzSFdIQTBDakc4?=
 =?utf-8?B?R3JyUm93R1JNbFl0cG15Q2FXRkIrVkhSOUxNZHRPVmZuZzV2V2ZEbUFhQkZR?=
 =?utf-8?B?UC8vaURrMVNISFZJeU5WOFFsaHVSRlE3bC9CTXpmak41ZnRmS2NaL2pUK05v?=
 =?utf-8?B?Rnd6MXF6WXhpRTc4RmRhT0poQ25LODFSNDkwU2phMEY3aDF1Q1JiSFFCdWpR?=
 =?utf-8?B?bTFZNE1HeEJ4bTV5Znpna0FORWR2K3FpSzl3TXNVUkd1Z0pEcGxzWnJyUTVJ?=
 =?utf-8?B?S0hibERRQnVKZzBjbFdDdkRPcVJIb2JBM3UyR2JxbitNQkhpelRXaDBYMXFC?=
 =?utf-8?B?djlyWXZMVHo3emlpeTk5MjNOTTJYQ1ZNM3JqMXlCdGtwTWdWcTVHVTVYcnQr?=
 =?utf-8?B?OEwrWVZwVS93dnYrdUMwb2E0MnJXVFMrbGJXY2wvMDlselBKWHhNcHJHeWFu?=
 =?utf-8?B?WkZ4RE16TVZsTHBOb2VEL05adERvQksvdDRmdzBRTUV5TThRdTNwSHlHVXBQ?=
 =?utf-8?B?ODQwcUh0dWY4cXcwZ3lmMXVUNFlnaVBnOXFjVHZ4bUMxN0Q4Zm92dXovMkZx?=
 =?utf-8?B?azdOdnJPTXF0UDVybFgrcWxmSnBtV0drNSsyM1p3NGpHOXN1U001Rm5UbWow?=
 =?utf-8?B?eXczd3ZDcFNkaFBsWDJCbHNPT3FVZ3g0bWRUU043bSs5WDhmN0RQb3N3aHRy?=
 =?utf-8?B?RXNTM0V6emdRZEJaOUdBS2VQSzlEUDQwYVJMTnB5dm5MaEtqR1QrOHJ1c3lD?=
 =?utf-8?B?V2p5QmdlQnNHeWRsWklWeVRERG51TmlDcTR5dWV0VHZ6OWtzMXJrSjhLZTV2?=
 =?utf-8?B?cXh5WGNpenNCNzRPREVMVTIzcDZXY3pVcmhsUFh6aVJtdmEyL0JiQkpQbDQ4?=
 =?utf-8?B?Q2xUOUYrcXdST3RHVVRIQWtqSDltSDRUNWloTDNaREdBR3g1MmpRNEYvaDQ4?=
 =?utf-8?B?by9vUEt4akhRem9YK2RvbXM5Nm9TWGl1TGpLYncySHpsbE42M0hnb1hMRm8v?=
 =?utf-8?B?K0FxdzRpUVN1YXE0d21DY0crampjekxFMXN5Ylh5dkZ3bGJDRXJ5RnhycEZB?=
 =?utf-8?B?QXRWemp5c0JDNWhmOVQyWmpGNWlpNU11cUd3NlI2aGJrMEo0cER4SWt2Y3cy?=
 =?utf-8?B?VTVwTTNncDNlOENZK1JJcmczRDJCQVlCUVNJZDc3K0dkUXFCa2E1S2NKelhx?=
 =?utf-8?B?WGN5TWtKUm5OdUhDMzUxTzBaMDlvUEVYTmZ2Rkp6TkdyRDNjSTBEWlB0THE5?=
 =?utf-8?B?VGNxTjkyNnc3cWZQNW1BaC9oaWZDSmlCenk0L3pIcXFhRDA4b1k2UzA0YkR6?=
 =?utf-8?B?SWxXb3dTdGdUV2lhYm5iTUVRZTdmdnBDcHMxOUNUR2RJam9MaHFIRnRrTUd3?=
 =?utf-8?Q?O8FE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437be7a5-b30b-4f87-9691-08dd04630c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 04:16:01.0660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQmtrpRsNF3WI++Zlo1FVtEoqBrGVHvOBw1wl8ssscAW8c1jpi7NSmE7FWw3Yh/olQIvRyqa+bqXUBjqtn3Kew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIw
MjQgMToxNSBBTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1
QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAzLzdd
IHVzYjogb25ib2FyZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXANCj4gVVNCNTc0NA0K
PiANCj4gT24gMTEvMTIvMjQgNzo0MiBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4g
PiBIaSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBN
YXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIg
MTIsIDIwMjQgMTE6MjggQU0NCj4gPj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVz
aC5hYmJhcmFwdUBhbWQuY29tPjsNCj4gPj4gdS1ib290QGxpc3RzLmRlbnguZGUNCj4gPj4gQ2M6
IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4gZmFicmljZS5nYXNu
aWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gPj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQgc3Vw
cG9ydCBmb3INCj4gPj4gTWljcm9jaGlwDQo+ID4+IFVTQjU3NDQNCj4gPj4NCj4gPj4gT24gMTEv
MTIvMjQgNjowNyBBTSwgVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdyb3RlOg0KPiA+Pj4gQWRk
IHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgVVNCNTc0NCBVU0IzLjAgYW5kIFVTQjIuMCBIdWIu
DQo+ID4+PiBUaGUgdXNiNTc0NCBkcml2ZXIgdHJpZ2dlciBodWIgcmVzZXQgc2lnbmFsIGFmdGVy
IHNvZnQgcmVzZXQuDQo+ID4+PiBUaGUgdXNiNTc0NCBodWIgbmVlZCB0byByZXNldCBhZnRlciB0
aGUgcGh5IGluaXRpYWxpemF0aW9uLCB3aGljaA0KPiA+Pj4gdG9nZ2xlcyB0aGUgZ3Bpby4NCj4g
Pj4+IEFsc28gdXBkYXRlIHRoZSB1c2IyNTE0IGh1Yl9kYXRhIHdpdGggdGhlIHJlc2V0IGRlbGF5
IGFzIDF1cy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJi
YXJhcHUgPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IE1h
cmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBjb21tb24vdXNi
X29uYm9hcmRfaHViLmMgfCAyMCArKysrKysrKysrKysrKysrKystLQ0KPiA+Pj4gICAgMSBmaWxl
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBiL2NvbW1vbi91c2Jfb25ib2Fy
ZF9odWIuYw0KPiA+Pj4gaW5kZXggODI3ZWNmOWIwMi4uMWQxNDZlY2NlZSAxMDA2NDQNCj4gPj4+
IC0tLSBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+Pj4gKysrIGIvY29tbW9uL3VzYl9v
bmJvYXJkX2h1Yi5jDQo+ID4+PiBAQCAtODgsMTAgKzg4LDI2IEBAIHN0YXRpYyBpbnQgdXNiX29u
Ym9hcmRfaHViX3JlbW92ZShzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiA+Pj4gICAgCXJldHVy
biByZXQ7DQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb25i
b2FyZF9odWJfZGF0YSB1c2IyNTE0X2RhdGEgPSB7DQo+ID4+PiArCS5yZXNldF91cyA9IDEsDQo+
ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9uYm9hcmRfaHVi
X2RhdGEgdXNiNTc0NF9kYXRhID0gew0KPiA+Pj4gKwkucG93ZXJfb25fZGVsYXlfdXMgPSAxMDAw
MCwNCj4gPj4+ICsJLnJlc2V0X3VzID0gMTAwMDAsDQo+ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+
ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCB1c2Jfb25ib2FyZF9odWJfaWRzW10g
PSB7DQo+ID4+PiAgICAJLyogVXNlIGdlbmVyaWMgdXNiVklELFBJRCBkdC1iaW5kaW5ncyAodXNi
LWRldmljZS55YW1sKSAqLw0KPiA+Pj4gLQl7IC5jb21wYXRpYmxlID0gInVzYjQyNCwyNTE0IiB9
LCAvKiBVU0IyNTE0QiBVU0IgMi4wICovDQo+ID4+PiAtCXsgfQ0KPiA+Pj4gKwl7CS5jb21wYXRp
YmxlID0gInVzYjQyNCwyNTE0IiwgLyogVVNCMjUxNEIgVVNCIDIuMCAqLw0KPiA+Pj4gKwkJLmRh
dGEgPSAodWxvbmcpJnVzYjI1MTRfZGF0YSwNCj4gPj4gVGhpcyBeIGh1YiBoYXMgdG8gYmUgdXBk
YXRlZCBpbiAxLzcgLCBvdGhlcndpc2UgaWYgb25seSAxLzcgaXMNCj4gPj4gYXBwbGllZCAoZS5n
LiBkdXJpbmcgYmlzZWN0KSwgdGhpcyBodWIgcmVzZXQgd2lsbCBiZSBvcGVyYXRlZCBvdXQgb2Yg
c3BlY2lmaWNhdGlvbi4NCj4gPj4NCj4gPj4gQWxzbywgbG9va2luZyBhdCB0aGUgVVNCMjUxNCBk
YXRhc2hlZXQgZmlndXJlIDUtMywgaXQgc2VlbXMgdGhlIGh1Yg0KPiA+PiBuZWVkcyB0ND01MDB1
cyByZWNvdmVyeSB0aW1lIGluIFNNQnVzIG1vZGUuIERvZXMgdGhhdCBtZWFuDQo+ID4+IHVzYjI1
MTRfZGF0YSAucG93ZXJfb25fZGVsYXlfdXMgPSA1MDAgaXMgbWlzc2luZyB0b28gPw0KPiA+Pg0K
PiA+PiBBbHNvLCBpdCBzZWVtcyB0X3JzdGlvIGlzIDV1cyBpbiBVU0I1NDc3IGRhdGFzaGVldCBm
aWd1cmUgMTAtNCAsDQo+ID4+IHdoZXJlIGRvIHRoZXNlIDEwMDAwdXMgZmlndXJlcyBhYm92ZSBj
b21lIGZyb20gPw0KPiA+DQo+ID4gV2Ugd2VyZSBzZWVpbmcgaTJjIGZhaWx1cmVzIHdoZW4gd2Ug
dXBkYXRlIHRoZSByZXNldCBkZWxheSBhbmQgcG93ZXINCj4gPiBvbiBkZWxheSB2YWx1ZXMgbWVu
dGlvbmVkIGZyb20gdGhlIGRhdGFzaGVldCBzbyB1cGRhdGVkIHRvIDEwMDAwdXMsDQo+ID4gdGhl
IGxpbnV4IHJlZmVyZW5jZSBpcyBiZWxvdw0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxk
cy9saW51eC9jb21taXQvOTA4ZjYxYmVkYjJjNDBjNmQ4NTZiYmZkN2Y4NzANCj4gPiBiOTY3YTRj
YjQ5OA0KPiBJcyB0aGVyZSBhIG1hdGNoaW5nIGRlbGF5IHJlcXVpcmVtZW50IHNwZWNpZmllZCBp
biB0aGUgVVNCIGh1YiBkYXRhc2hlZXQgb3IgaXMgdGhpcyBhDQo+IHdvcmthcm91bmQgZm9yIHNv
bWUgYm9hcmQtc3BlY2lmaWMgYmVoYXZpb3IgPw0KVGhlIG1hdGNoaW5nIGRlbGF5IGlzIG5vdCBz
cGVjaWZpZWQgaW4gdGhlIFVTQjU3NDQgaHViIGRvY3VtZW50LCBidXQgYmFzZWQgb24gdGVzdGlu
ZyBvbiAyIGJvYXJkcyB3aXRoIHRoZSBhYm92ZS1tZW50aW9uZWQgZGVsYXkgaTJjIGZhaWx1cmVz
IHdlcmUgbm90IG9ic2VydmVkLg0KDQpUaGFua3MNClZlbmthdGVzaCANCg==
