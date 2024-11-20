Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DBD63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0C98967C;
	Wed, 20 Nov 2024 14:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJUrhlzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B179D8967C; Wed, 20 Nov 2024 14:20:55 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DB189277
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgSS7o2c1YTAQis20V62anTxdgBQdRrhbafOf00zDKsCiCSRe/Ue0T8okj9ExgJEHCxJZ2ASCnoYW3cdrCNp0/D2za//f5Wtr11p2OT+JhW/aGlv0T6b/JLNZF51ohdRdh4ofTEJ6dZJjAIK4enwblsLSnGv2/ZIafjuuHqU9BrZr/T0Iip8nMzRn0fgiVm9zFV9cn9/E6qLHiQY8kcjTudE7ipRmscNknnBmWQLkYQRcNgiIAQeaN1wtPSCwv/g3T9fVMlGIgy+Hzqfa0FWV/VSthz/WF50DYua7vkL7D1e8TwuiCtKznOeaEs+LIbS4RdmhHqYQI+S9qHpYFU7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbQLRXmB1kN0r4SXP9dMhurJwmBEXJ3WuvG2iqo12pc=;
 b=qulli3nT7HM2ZbQlrqp0EdnMmUg1lIDQPziCtd3+/AfDa54iv1kAu5gK8XrpRM1+7BRx1VwtfqW6o8CS6jojEiXgSNj92ztGE8XF4vXxUE6Rr2JTk3V2nFjON4pVkwZBzChWSSoYkM/4DzD3QGKk22RnoFhgKOQnCpSI0Y8lH1SiAHaFLU70LvH0eiUQX77V64+rbhQs9Pb0nFRcDAGhEQV44JQbEdMaKTOW9VZaXndkNPRVUotjAwcY9jj17LdRbkp97RuPyph2mPx2mazCDU/BE1dWKKcrdgtypbozCI3lu4uGI6+XTyDd6A9ZYetickq2yAe7TCASNlty4AiQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbQLRXmB1kN0r4SXP9dMhurJwmBEXJ3WuvG2iqo12pc=;
 b=PJUrhlzlTF1d7wzIKLYzDPtXRypu/X21zD5aWDfR2C9k3B7H1NkZo/ixalz+9X2g5OREkoO0fR3NUdjq5U8Qak81OjKv36D7Hlgx25bIONJ9tYP9E6X9t/7yKFGthzSUUFuDD6uYZVkkgBD4kklEOBUar9E9y8c6IMgwzX7BI/0=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 13:20:46 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:20:45 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3QgAC2pYCABkWfkIAAGvuAgACzSwCAALpXAIAA6oDggABK1YCAAEv9kA==
Date: Wed, 20 Nov 2024 13:20:45 +0000
Message-ID: <SA1PR12MB869756F1B9384CE299FA1C4298212@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
 <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
 <SA1PR12MB86972FD15A7312EF59F1A5D298202@SA1PR12MB8697.namprd12.prod.outlook.com>
 <da8d990f-b2fa-4f21-bee5-7d609e9364b2@denx.de>
 <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
 <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
In-Reply-To: <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CY5PR12MB6599:EE_
x-ms-office365-filtering-correlation-id: 3f52f5dc-c170-42ee-cabd-08dd09662436
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q0MwbjVCVi9abDFBc2hyNC9HYitYNUlmaUtZclhLdnMvRHBVZm9jZEo5L0pY?=
 =?utf-8?B?bDJrMXFlMW1WU2NJZStKTlN4dytZdVptTlZQd3Nwd0Q0SVFZRndkRXpJaTgy?=
 =?utf-8?B?bzBmZjA2b0svNzRQdXExRnhadGd4MmN0ME4yZnZRRjkyUkYrbDcxWjJmK1F4?=
 =?utf-8?B?R3YyZ0JRQTNMUEJXN2Y1ejRzMTgreHBvc1d4ZkpDblZsb3o3WXNCS2k0dy9j?=
 =?utf-8?B?Y1VlU1NUekl4Qld1d2ovcitHTi96clErVC9wTTYvN2JTOE5Va3JncllCaWhy?=
 =?utf-8?B?QUIvNzdoT29hL05Wb0xjYTBIbjcxN2tFUmw1VDd2YWF4Zit4T05TQTZ4K3B5?=
 =?utf-8?B?RWcydDUzSyt6bmJHYnY0T0xHOXFOTVlpMDl5OE9MWkpBbXppaXpmbjFrNHl0?=
 =?utf-8?B?SjN1aURHLzZKUDRHR2RxaUpIdXZiRm55cmQvVHhnV2NVZS9uazJMbFQyYU1E?=
 =?utf-8?B?YkFJNlBHTExMWjh4Uk0yRVU4SWJGWUpGVHNnRjAyUm1Vd0NnanFIQ0JwZENZ?=
 =?utf-8?B?SEJYZHBsbjhiQmFCb1Z1c0pYT2xtTG93RXEzTTFQU2tablB5LzNUdXN6YUVU?=
 =?utf-8?B?alZGbmJFTzVCWG1QeEdsVzBCYVhNOThnRzhuSHJRYktack5uaitPSnR6ZXNl?=
 =?utf-8?B?cDhBWnY0c0hzbkwxN0lQVkN5ajJTRnNLU28zajdMT2RxUTgxM2ljWkVOTFhY?=
 =?utf-8?B?RldPQ0dUdU4xS256MTViKzJyTGdhaTRtdXdNNmtWRGN6cTFxdllaZmtoYUJl?=
 =?utf-8?B?WUdrSi9lb0ZuSFJrTyt5MklDWVY3MG1OSjhFNHdINjZDbHRsdlFwWHpTcjI0?=
 =?utf-8?B?ZVhUOW0xWUg5OFFMZVl3ZG9Pd3NJdTlvQWluRlhxSVJLRERkc3ZxS3BVNWZs?=
 =?utf-8?B?Uzc1amdVcy90Zm5tT0NVclF5SGhWS04rTGhBa2NrU0hkTlR0ODBBcyt4TUVW?=
 =?utf-8?B?NE5nSDJyNlFEZXJzSXRUVUVEdHMrVmVmTDZpSWhWMXBSM1NKZ1UzVkNTeG12?=
 =?utf-8?B?bStENXZGWGdyRnkwQkpKT0xFMUoyb2h1MWp0S1VoQVVUdk9JREZWWnIrN2Zq?=
 =?utf-8?B?VW1yRWxvbzFZQS9VZUpTN3k0K3BUOWRJN242Yk1ycEx1UHlUb0cwQlFYdW9L?=
 =?utf-8?B?Wno2VkZkSTF0RmFLU2tuMk1QMmUrM0RMQmFXeUVzenh6dzZuTnZ0TUNoSzdN?=
 =?utf-8?B?cXhYZjBJSVV4YXhSdW51TGwyQXNZUWFZTGVheEZjUmRIOGJKcFVxdStzSVNx?=
 =?utf-8?B?bEFyTzVZMEhoa0pzK0hHZU9BNmFtZ2xjNUVXbjBnS3ZKRWtKK2k5YkRhOXlk?=
 =?utf-8?B?Zk05bHJRUjcrSUcwZ0RhcW1NTlZCdHVTb1dITFZGSzlJMGltZG1IbGZSYVdx?=
 =?utf-8?B?NjhKcWFEczkwVkpFeUttZGUvR291NGVwei92SmxnQ29zTDUrRU5kZWhjNGtJ?=
 =?utf-8?B?ZXcweVRtZ2hjT3hqdG92L2pzMjM1SlA3QithV2RUM3o4WGlGc0JPTUFIcVNr?=
 =?utf-8?B?TENNV1RsbnpYMjMxT3NOa0Qwb1I2c01ZZmNUTTZ2WG5rcHFYMkdmVDJlTWZp?=
 =?utf-8?B?UkZmajE2dG5Pa1FMTTE3S1ZXYzBqRndscldUQmdZUGN3VlNZdU9DeVZEUHgr?=
 =?utf-8?B?R3JyU2NlZVBxY1JEYjFmQkJCTDA2UWhxSWVjNXNnL25UTVZUQkJGWHczbGgy?=
 =?utf-8?B?UkJXNXJMTjltZlNtZXZrcDA1U2dSM1BTRUpraTdDZTlmN1A0Uy93djl6ZXp6?=
 =?utf-8?B?cGg5K3B0NzA3ejlybkk2TktZUm5sTTBGTzlFZUJDNElOMVBRN1hTUUpsVElR?=
 =?utf-8?B?ZDFuZFVNMEV3MnBrWkJpUnpsUmFFdWJMYW5HL01CL01sNDQ0Y1RmUWl0VFox?=
 =?utf-8?Q?3+RLnAvs79/Jh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFVqTjhsSStXKzZONkFGY094UkhkdzZEVlpYdlRLTlNvTXk3SWE5c2dIQkhK?=
 =?utf-8?B?QzREb1RVUjZBUDBQeXE1c0JNOVNQaEFpUHFIM3p4RzNNdDhGUEJHcHVaNzla?=
 =?utf-8?B?V3NkUWJhVmt4NmVnL3NneWJSYkhyaEhNZDNmZElaN25RY0o1TjZqeEpDQ2tt?=
 =?utf-8?B?T0hQclBzeEsyd1ZFUlR4RXJVVVhDeWlWTU4zamNBNTYzT005ZUNNelNUQmJZ?=
 =?utf-8?B?VUJwSlo5cHI5b2w2SElzbDJWcUFZR0l1Vy9QcitDdE5nQW9QaHNPdHBZWWFW?=
 =?utf-8?B?Vkk3aiswQUxwbDVHcWxUcE4rNXM0NVovamZyNVROVWJuSDV6Z2M1N1V6U1dw?=
 =?utf-8?B?V2tEK0FwY1BQMG9CdXlDZFJjcVhoU0FWcllYQlpKNDl4MFVGeFZGNW9OV3lR?=
 =?utf-8?B?OEptMzZPcTNXMEZJL25YOG9nVkRJS05FZmlUbmZjVzlNSDRWL2JHRCsxczJX?=
 =?utf-8?B?MWMzTkNxRnowVVhxVEhSYWY0a29MT2FrLzBjS09IeDZCaUorbjdwNDV1OEJo?=
 =?utf-8?B?dHExSEpkSHFucDZqeTViSno2Q25FVW5JaUhrQVIvcXhFR0RZMzh1UEhkZkpV?=
 =?utf-8?B?ZnFHUVBoL0MxbmFXYU5uMStiRXpFUGxmejJ3L0RlMkNaTFcwc09VVDVpdWdj?=
 =?utf-8?B?K1UzbVZkNzBOUU0wVlVIeVZwRUxMN1VEWDlKL1owUTZ5Q2VtSHFtUHM4OTNM?=
 =?utf-8?B?WHQ2RlEzdktabkk3VkhieEo1N2FZc3ZqZlJzN21mNzgrSXhMOSs4RGVCTkhy?=
 =?utf-8?B?eS9nZTJFb1ZudDJ0NFN5aDU1S3NjWlA0RlpPZis2UGJQUnp3VzdsaU9EeEJO?=
 =?utf-8?B?MEE3NkdPQmdnaExCS0FTYmFabHNYZG9qYVR4RDcxeFNRa1B2cWZ2TlJ3Q0Jh?=
 =?utf-8?B?aDExYW9lWkJWZzYxenRYU3BpcGVXOWMxdTBmR3lwRjl2VTByaFd0VFlTdjNM?=
 =?utf-8?B?cTlPbXNDczBBVC9GM0xGbDd1K2E4Q1l4U3NITjBud2NIeDVCdFNYT254Rmo1?=
 =?utf-8?B?eG41SGVHcUppMHRCaTAxRVlsQW5mYlljQkM1TmVqQUh1emtqN0MwNmxUanFM?=
 =?utf-8?B?cTFVVFdVUDQwZmZWQVFjeU5SUHlGTElkUEZZN3NrZ1I5ZEJMR0p2SG5WTVRH?=
 =?utf-8?B?YXc3VUFGMTV4NEZ2b3NkK0k0d3NiV1lTNWMzOXBVaGdyOTVJTnh0ZzNHd3My?=
 =?utf-8?B?K0VqUm8ySDBxb2syVFdIUzd5ZTlNZHZaTVFrRmN4Q0FWeVVyRXNkY1U1eVBw?=
 =?utf-8?B?UnlmR28rMFNBTFJrdGVoSE5FaHh5UWhlRjdpRUJGSW5QMkxaUFdaZkVMWm9j?=
 =?utf-8?B?UXJ1YitoZ0p1dGpndmF1TklQMmlxZ0sycWgybW5BY2kxTTM2cFBMdW9WcmFW?=
 =?utf-8?B?Wkp4VEViWWN5cnlCb29DYjllbUJ0ZENtcGwvd01pMVhpWlVkblgvSDRKUHZ6?=
 =?utf-8?B?amNiUjVnNzM3OTRmd1JrcUZKYlUwTGNiWVpZTVdkdng1K2hCNmQxM082QjV3?=
 =?utf-8?B?NUh3Qi92azdtb0xDVmEzdldhMHZLS3RuSjFsNWFmdjNXcncxVjNySVV0cE5I?=
 =?utf-8?B?Zm9GeUJYZW1xaUlsTkdZOEVSaEhLTDBaalVMSXgybnRYYklVU2JlKzB0bURI?=
 =?utf-8?B?aWJrNGFqREpFdVVOVlFUUmNuVlVrL3hDTVhleDZwbkZnT2VLaUgwS1orRzFj?=
 =?utf-8?B?b0QwMElzVDlmZWZRMjFUQldZTWpaRnhBT0ducG1md3Y3MXc4SDA3emFpSVZU?=
 =?utf-8?B?aEs3dFlKaWNaSXFmVGpoQit6c0RnUlJNWEc0dFZCSXNvUEwzbytZVkxnNkxQ?=
 =?utf-8?B?Yk1YTnplZHFyZFNlajNwaWl2ZXZWRW5EdU14dExIZk1wUmVuRmhSZkF5NTdu?=
 =?utf-8?B?SUVaMklCalRmcllpMFZ6TEN3bGMrSVI1YlFQbXF1Vk5FYnNaR3AxRUFBaFYy?=
 =?utf-8?B?U0JxdVdlWFBFTG1FUXV4K0dJSnB0S2J1ci9ZRFBXeG8vdms4c1NLSmxEd1BR?=
 =?utf-8?B?YzJ5N1M1RUt3Y092djB4cE5UdTduenJRblN0Zi96clB1dk9BdzFhaTd0cDI0?=
 =?utf-8?B?Y0J5cGxWbG9OU0ltN0VDY3ZibFRBNU1ma1NTS2tsMXlpTmlWb1dIUGdKSHB5?=
 =?utf-8?Q?k7kU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f52f5dc-c170-42ee-cabd-08dd09662436
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 13:20:45.5275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoS9+zbAP7d6v+lFJSmL6/oVyMrMsflh9iH2INe0RrL9HkTLaKyJsTYveSp5Se00TGIVl5ugolOux8F4okRwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMjQgMjox
NiBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5j
b20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNp
bWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAoQU1ELVhp
bGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAzLzddIHVzYjog
b25ib2FyZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXANCj4gVVNCNTc0NA0KPiANCj4g
T24gMTEvMjAvMjQgNToyMiBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPiBIaSwN
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJlayBW
YXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIw
MjQgNzo0OSBQTQ0KPiA+PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFy
YXB1QGFtZC5jb20+Ow0KPiA+PiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiA+PiBDYzogU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiA+PiBmYWJyaWNlLmdhc25pZXJAZm9z
cy5zdC5jb207IGdpdA0KPiA+PiAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMSAzLzddIHVzYjogb25ib2FyZC1odWI6IGFkZCBzdXBwb3J0IGZv
cg0KPiA+PiBNaWNyb2NoaXANCj4gPj4gVVNCNTc0NA0KPiA+Pg0KPiA+PiBPbiAxMS8xOS8yNCA0
OjIyIEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+Pg0KPiA+PiBbLi4uXQ0KPiA+
Pg0KPiA+Pj4+Pj4+PiBJcyB0aGVyZSBhIG1hdGNoaW5nIGRlbGF5IHJlcXVpcmVtZW50IHNwZWNp
ZmllZCBpbiB0aGUgVVNCIGh1Yg0KPiA+Pj4+Pj4+PiBkYXRhc2hlZXQgb3IgaXMgdGhpcyBhIHdv
cmthcm91bmQgZm9yIHNvbWUgYm9hcmQtc3BlY2lmaWMgYmVoYXZpb3IgPw0KPiA+Pj4+Pj4+IFRo
ZSBtYXRjaGluZyBkZWxheSBpcyBub3Qgc3BlY2lmaWVkIGluIHRoZSBVU0I1NzQ0IGh1YiBkb2N1
bWVudCwNCj4gPj4+Pj4+PiBidXQgYmFzZWQgb24NCj4gPj4+Pj4+IHRlc3Rpbmcgb24gMiBib2Fy
ZHMgd2l0aCB0aGUgYWJvdmUtbWVudGlvbmVkIGRlbGF5IGkyYyBmYWlsdXJlcw0KPiA+Pj4+Pj4g
d2VyZSBub3QNCj4gPj4+PiBvYnNlcnZlZC4NCj4gPj4+Pj4+IElzIHRoaXMgMTBtcyBhIGJvYXJk
LXNwZWNpZmljIHJlc2V0IGRlbGF5ID8NCj4gPj4+Pj4+IFdoeSBpcyBpdCBpbiBhIGdlbmVyaWMg
ZHJpdmVyID8NCj4gPj4+Pj4gT24gb3VyIGJvYXJkcyB3ZSBvYnNlcnZlZCBpMmMgZmFpbHVyZXMg
d2hlbiB3ZSBzZXQgdGhlIHJlc2V0IGRlbGF5DQo+ID4+Pj4+IGFzIDV1cyBhbmQgcG93ZXIgb24g
ZGVsYXkgYXMgMW1zIGFzIHBlciB0aGUgVVNCNTc0NCBkYXRhc2hlZXQuIFRoZQ0KPiA+Pj4+PiBy
ZWFzb24gb2YgYWRkaW5nIDEwbXMgZGVsYXkgaXMgYmVjYXVzZSBvZiBpMmMgZmFpbHVyZXMgYW5k
IHRoZQ0KPiA+Pj4+PiBsaW51eCByZWZlcmVuY2UgaXMNCj4gPj4+Pj4gaHR0cHM6Ly9naXRodWIu
Y29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC85MDhmNjFiZWRiMmM0MGM2ZDg1NmJiZmQ3DQo+ID4+
Pj4+IGY4DQo+ID4+Pj4+IDcwDQo+ID4+Pj4+IGI5NjdhNGNiNDk4IERvIHlvdSBoYXZlIGFueXRo
aW5nIHdpdGggcmVzcGVjdCB0byB0aGVzZSBkZWxheXMsIGFzDQo+ID4+Pj4+IHlvdSBtaWdodCBo
YXZlIHRlc3RlZCBvbiBzb21lIG90aGVyIGJvYXJkcz8gSWYgYW55dGhpbmcsIHBsZWFzZSBsZXQg
bWUNCj4ga25vdy4NCj4gPj4+PiBJZiB0aGUgMTBtcyBkZWxheSBpcyBhIGJvYXJkIHNwZWNpZmlj
IGRlbGF5LCB0aGVuIHRoaXMgaGFzIHRvIGJlDQo+ID4+Pj4gaGFuZGxlZCBpbiBhIGJvYXJkIHNw
ZWNpZmljIHdheSwgbm90IGhhcmQtY29kZWQgaW4gdGhlIGRyaXZlci4NCj4gPj4+PiBQcm9iYWJs
eSBhZGQgc29tZSBuZXcgcHJvcGVydHkgd2hpY2ggc3BlY2lmaWVzIHRoZSBleHRyYSBib2FyZA0K
PiA+Pj4+IHNwZWNpZmljIHJlc2V0IGRlbGF5LCBidXQgYmUgc3VyZSB0byBydW4gdGhhdCBwcm9w
ZXJ0eSBieSB0aGUgTGludXgNCj4gPj4+PiBrZXJuZWwNCj4gPj4gbWFpbnRhaW5lcnMgdG9vLg0K
PiA+Pj4gVGhhbmtzLiBJIHdpbGwgY2hlY2sgaG93IHRvIGFkZCB0aGUgYm9hcmQgc3BlY2lmaWMg
ZGVsYXkgYXMgbmV3IHByb3BlcnR5Lg0KPiA+Pg0KPiA+PiBBZGQgc29tZSByZXNldC0uLi4tdXMg
LCBzaW1pbGFyIHRvIHdoYXQgZXRoZXJuZXQgUEhZcyBhbHJlYWR5IGRvIGluIERULg0KPiA+IFN1
cmUuLi53aWxsIGNoZWNrIGFuZCBpbml0aWF0ZSBkaXNjdXNzaW9uIHdpdGggdGhlIExpbnV4IHRl
YW0uDQo+ID4NCj4gPj4NCj4gPj4+IEFzIHRoaXMgZGVsYXkgbWlnaHQgYmUgc3BlY2lmaWMgdG8g
dGhlIGJvYXJkcyB3aGljaCB3ZSB0ZXN0ZWQuDQo+ID4+PiBUaGVyZSB3b24ndCBiZSBhbnkgaXNz
dWUgaWYgd2UgY2FuIGFkZCB0aGUgZGVmYXVsdA0KPiA+Pj4gInJlc2V0X2RlbGF5Iig1dXMpIGFu
ZA0KPiA+PiAicG93ZXJfb25fZGVsYXkiICgxbXMpIGZyb20gdGhlIFVTQjU3NDQgZGF0YXNoZWV0
LCBhcyBvdGhlciBib2FyZHMNCj4gPj4gd2lsbCBiZSB3b3JraW5nIHdpdGhvdXQgYW55IGJvYXJk
IHNwZWNpZmljIGRlbGF5Pw0KPiA+PiBSaWdodCwgdGhlIGRyaXZlciBoYXMgdG8gYmUgZ2VuZXJp
YyAsIHRoYXQgbWVhbnMgaXQgc2hvdWxkIGNvbnRhaW4NCj4gPj4gZGVsYXlzIHNwZWNpZmllZCBp
biB0aGUgZGF0YXNoZWV0LiBCb2FyZCBzcGVjaWZpYyBkZWxheXMgaGF2ZSB0byBiZSBjb25maWd1
cmVkIGluDQo+IGJvYXJkIHNwZWNpZmljIERUcy4NCj4gPiBUaGFua3MuIEkgaGF2ZSB1cGRhdGVk
IHRoZSBkZWxheXMgYmFzZWQgb24gdXNiNTc0NCBzcGVjaWZpY2F0aW9uIGluDQo+ID4gdGhlIFtQ
QVRDSCB2MTMgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlw
DQo+ID4gVVNCNTc0NCBQbGVhc2UgcmV2aWV3Lg0KPiBWMTMgYWxzbyBlbmFibGVzIHRoZSBodWIg
ZHJpdmVyIGZvciBYaWxpbnggaGFyZHdhcmUsIGRvZXMgaXQgbm90ID8NCj4gSWYgc28sIHdvbid0
IGRvaW5nIHNvIGxlYWQgdG8gaW5jb3JyZWN0IGJlaGF2aW9yIGR1ZSB0byAtLSBub3cgLS0gdG9v
IHNob3J0IGRlbGF5ID8gSQ0KPiBzdXNwZWN0IHlvdSB3aWxsIG5lZWQgVjE0IHdoaWNoIGFkZHMg
dGhvc2UgYm9hcmQgc3BlY2lmaWMgZGVsYXlzIHZpYSBEVCBmb3IgdGhlDQo+IFhpbGlueCBoYXJk
d2FyZS4NClRoZXJlIGFyZSBtYW55IGN1c3RvbWVycyB3aG8gdXNlIHRoZWlyIG93biBib2FyZHMg
YW5kIHRoZXkgbWlnaHQgbm90IHNlZSB0aGUgaXNzdWUgd2hhdCB3ZSBvYnNlcnZlIG9uIFhpbGlu
eC9BTUQgYm9hcmRzLiBEb24ndCB5b3UgdGhpbmsgd2UgYXJlIGJsb2NraW5nIHRoZW0gYmVjYXVz
ZSBvZiBvdXIgYm9hcmQgaXNzdWVzPyBXaGF0IHlvdSB0aGluaz8NCg0KVGhhbmtzDQpWZW5rYXRl
c2gNCg==
