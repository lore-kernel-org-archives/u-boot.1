Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFF3D6E2AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 04:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2999689347;
	Wed, 20 Nov 2024 05:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wh5ERTyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B528962D; Wed, 20 Nov 2024 05:22:10 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B43089347
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgM1fT3C0tjYZdwtm3x6OvsNmHVnB/z1uJO+cyTrbdsUZBPxPLiWS7uEEQ7Sq/REhAse5gnPA50e2IujpdJps7RdbUb6ZDo3f3kwNoyZxChVEdGXQHL1QJDbJVjc0Da+zfOsph6DBvf9iLOXNbEAj39STyGiZPTutf145LyDdZhH9L1Gan9TNGaZ9t55Y/Vd5Ce8JBbnXjoL4Vs+R5J46ivZxSdVqmjEzc88M4VwoTjPormJQtcexK6Ha8nCWkx0+VEN2stCqQUyx6/yT0iFnyBVwEw7T1ljrHLZmVv5SGVGjoi2wal6iZXjl922u3jsA6OC6XFp/L61WC1WpiRkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5yPVd0ZR8VmUcyR4qp7oKLRRkvgHIXrqVr1LO7dHd0=;
 b=tMj+0Dn0ZPaaPOpzUywqXmaSgaf1RlQLWo1jjsPpcYu3KzXQijrH91Gk1C3sRuglT/stubGYuWmcnICjTi2wZpfYNhzruDCMP6kEjACTZAnv4PXsGa1io3UxnAyk7qvRj3g0VLbWOgeX36RZqH9t6sQ5PjdeLWQl2KDD2uwcVjPQYuOxlzVhiKkaJFxtzvJSA5owJY7yqPivgjzv2opiZqfoYwqyXfyUGXd2uZwcufYlWdl5s9arrEmk/kZNRKeC0cFdD+8S3fec88ACyWnDfgXhWSsZ336baQmvP2qJGncyDjOAAolspeMdlLK4wAKHMRp1Z2BF6RPKgt8gkdSbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5yPVd0ZR8VmUcyR4qp7oKLRRkvgHIXrqVr1LO7dHd0=;
 b=wh5ERTyMgVLTTELmWRTDdfSGL38JCganZxG8euHqcBM+W9t+OT1/zvM8g2R6tFlMXEHBWbV9zxY8kfwY7ZK8c2u9aTPQIzKbA1V2Nu3Ioztton+iitQP5Y0ue6HTfnzW+8lqmaVtAj9r+B8EsOFZJIznepISHCLBcIFuLC5DuOw=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 04:22:03 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 04:22:03 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3QgAC2pYCABkWfkIAAGvuAgACzSwCAALpXAIAA6oDg
Date: Wed, 20 Nov 2024 04:22:03 +0000
Message-ID: <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
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
In-Reply-To: <da8d990f-b2fa-4f21-bee5-7d609e9364b2@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|LV8PR12MB9270:EE_
x-ms-office365-filtering-correlation-id: f5ce4217-2cf6-43ef-1a35-08dd091ae2c2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SHJkOG9sOUk3UzBSWE10Z3hxL2lyNEU0WmhPVjJZTDhheVlLNnhsWWMrdmcw?=
 =?utf-8?B?L2ZwUTdnRkRVMXkzSGQ5UXNGa1EwWFNnRXdaTllZcDAwcWc4Z0FWNDlOb2xH?=
 =?utf-8?B?UEFua0VhRlJuYzJubTlJK3QwWVM2S01UWHptY3hJaW4yWWhCMUtVd0EreDRa?=
 =?utf-8?B?WVhsS0l0bGd0VVBQVlYzN3pzdTB5Z1F5NUtsY3NzaTFHVVljZU5NTnVFQXZJ?=
 =?utf-8?B?WURqVFZ4LzF5VjAzK0JUYXlTQWdwM1JBR09hWjFaNnp3ZlppenJNb3BsdlBo?=
 =?utf-8?B?Q0x6ODZ3TGdUYUZEWVFNU3hqSi9PNkNlc1FaY0dxYW1NaWJ6bXNHbnVIZ21P?=
 =?utf-8?B?MXFoc1RsNm43QzBYaDRGTWhScFM1WDhsSTlNQ2hDWk81aWxFRmFuM20vY2tQ?=
 =?utf-8?B?Vk5KMmdQVmJySjVXNXhKV0lFeDVXeDU2a29DTDVkbEZEL3M2KzEvRlVNOTVp?=
 =?utf-8?B?ZlpHSHJKc3BoTFREWnJvdUxEZmlrTm55b0FzRmo5T0FPdXVjTVlISXpONkE1?=
 =?utf-8?B?a3E1NE03MEV1V0JyczgyRDJFek9UdHVERDZQbTl4ajhwRTFhYWxmcmphdTFr?=
 =?utf-8?B?Z2FZYWhBTGZNZVpjbGZMU2t2WHpqZ3VLWG5YUVJjSmpLTWJSVUhQc01aSzVn?=
 =?utf-8?B?WlYveVgrYytsSDFGZlFJWGkyeVdOb2FPZzUwdXpxV00zZlJ1b3FCZjNYOEZB?=
 =?utf-8?B?NjVVdm15dm4zblJraTNDZDFRRVlOV3lGK09CM0l1bkpoeWFYMUJrdUttWjY2?=
 =?utf-8?B?cjQydTdxZUtkMCt5dFprck11MXFTc1FrM1h5OStFZXJQNHU2Ym41ekM3dDFv?=
 =?utf-8?B?ZVZTZHpIMEVzajNQbmNYMHdjRnBybUFpV3FxRXl2NWNmQkJwU21WWUl6aWVS?=
 =?utf-8?B?NU1GdnowQmprOGw4UGZNaTE4bkxjSmlGZndpVWtkdi9RN2NmbWxMSExZUnF6?=
 =?utf-8?B?aWwyMDdLRkZxS0VPVHZxbm1WUkJiOGNwY3FtOFBLU3hVVlF0VW9FV0QrVkJX?=
 =?utf-8?B?Tjd4WnhtZFlpVXhvUGxPNzJ2NFRmOXdZTC94dC93STZOV3NTbWdOUlhySWtF?=
 =?utf-8?B?SjMwckxXUHIvSVAxVU1DTHY0bWJvSmx5STluUllNWmx3c3BXbG1mdXRMM254?=
 =?utf-8?B?NER6ZWpVMmg0T3AwckEzWXE1dUZRVGhRRU5rclhDaEpNY25JY0t3djdJU1p1?=
 =?utf-8?B?bVFxYysyTFNXWFB4ZG5xaHNwNHlkOTRrUEo2Nmg2Q3NENDZFNjhJMDZjaHpG?=
 =?utf-8?B?N0M5RzRUdzlzM0wrL2FZQklBMXlJa1h5Ni93RENJYWd6dmdwejBUUHRxVzda?=
 =?utf-8?B?ZzA1ZVp3QzZvbnQ2M2R2TDNyMHVBKzdQdUg5ay93TjI4cmtnMzJ3aDU5WnlO?=
 =?utf-8?B?VSt6TFVVSUQ5RFQ2VkRwbHBlUTZTR2RMME5IQjY3T1E1TjJMZVVrcnRoT0JT?=
 =?utf-8?B?UCtkQmF5WHVvaXR2NVREYmorNXpTMzB1Um9Kai9GTXJhOHowVGVJc1kxbGt2?=
 =?utf-8?B?N2tzeEZxZTYrRUoydzFSdkpGZnBySTVWWCtSbmVqNUFhMDBpWmRBeDlhQnNo?=
 =?utf-8?B?NnhWUGpwM3pBSW4zc2ZxbldYOFJBVUwzNUNTWHhxOFloU3FKK1c2QlFPZzhz?=
 =?utf-8?B?eEtxQmRtZlYyTWhwVnlNYnMzSUx5ZkZmalNqWXhQb09wVklhVTR3TllRSVA5?=
 =?utf-8?B?V3BoYkFNSG9uL2gzRXNRaTJwdnRRRVBvMFhQMDN1ZHR5OFNERDhkVVZnTWJO?=
 =?utf-8?Q?6wl/61ASqvk2FrMp7OaI3lI5+b1BxMIOzmonI7O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUttRGt1WUpKcVZrK0F3SktvSXlORTlpb0lzQk4wZ2VESHIyR0NwRlV2THRQ?=
 =?utf-8?B?c0xxcGJMejA4RFF1bCtsTTM4SWlwWlZIelVjQ1RoTTVMdXBrS092eld6MDhN?=
 =?utf-8?B?WUhIRkJRbGVHaWE0ZnRJa1BuSHo0TVdBbzd6M3l2K2w2MFJwNnhIeGx4aTBL?=
 =?utf-8?B?Y1JpanZtSnFxdk1UM2VDMHkyZDFsL0ZJK29keFRKdmcvZlRTNzlQYkM2TktF?=
 =?utf-8?B?S1NQaXNka3Era3NFRHRkazlQK0RuVVFPazljc0h1SWtvR2g4VkFpOVlzOExF?=
 =?utf-8?B?bTN1QUV2Nm9mZjJGTTFPTE9MelFLeUlwdkMvaDBPZzZTb2k0RDdHZUE5OWhY?=
 =?utf-8?B?M1FBMzVMcC8zVGQwL1kweXBuTlpZMFJWa0RDcFZSN0JrTVBjaHJHeTJKTm1S?=
 =?utf-8?B?eG84WVV2bHFpcDgvd3RYT2t4L3h4czFOclhRbVJjV0creFNXNitaT1RYSWR2?=
 =?utf-8?B?M3cvUDlJZS83bEFkVDIxRDFwV1U0Y01RSUcxYlVIV0V6S3VCWkUzWS9GdWw0?=
 =?utf-8?B?UGN5YTdCV3F6YUsxSld1RVFMSGJ4WFRhQUoxaUxjaFBjR3EycTQxekdEUyt1?=
 =?utf-8?B?U3BKQUtkRVZPSXhkbStWRGpGeVJtMkZTTEVZSVhrV3plK1JvaGp2WnNjWXc1?=
 =?utf-8?B?RmZQc2JUc3NMRi81RUg1czVvV1orY2ZLZDdOQjBzYk96SVJhQXB1c2d4NThm?=
 =?utf-8?B?dnZVWVpXUHpBb3YrUHAvMjhQTEtuMUpOa1E3SlhNS3Bzbkx5QzduajJJc0VE?=
 =?utf-8?B?VC9DK2lYNFkxdGFzQmJHelhzTFVzVFBPcHJxcGFkblZqZjVNd3VJeHl4QWlE?=
 =?utf-8?B?dHpvZHhIem9WdGM5U0ordEtxdjRQaVRNeld3MVQvaW9YQnJBeTFxWVZsNDNw?=
 =?utf-8?B?elA3ckZBNDdqNjB0QlhRQWRDOE9qdmx4YmZOM0J6VHN0Y0Q3ZThnaTVkTEtO?=
 =?utf-8?B?aUFPaisyemQ4dXQ2Y09pdjVvTVowOEdjZWlxS1VaL0FkMXluSHJXclp4WUNY?=
 =?utf-8?B?UTBnb2dwVjZaaXh5MnRtb05iekxnY0FHYU1IQmY5bkcvM3V6VW9WMjl0bUJN?=
 =?utf-8?B?UGtpV1UxRkY4RmVON1hVRU1TcnA5Ri9LeUdZVk1kMGhWdWEybEIxaTZEMGIy?=
 =?utf-8?B?TlRPVjdRWlIwNlh5Q0J6bHdDUHhFMi9xdEI5UHR2STFqeFpudG1yNlkzcldO?=
 =?utf-8?B?TURPbHVlUmFVU0haTlpYWXpZZzY4bUEyN3hkMkJERDdzcXE5THJoZytiYWl6?=
 =?utf-8?B?WldYZWhGekIvOXdDcThQdEdlbU1OYklBZUpyYUpKMksvZ25NNTF4L3JvVVJ4?=
 =?utf-8?B?N0d4NFEySDJSQUtjcDhSdmZvTG5EQVdDMTdWSVBQT05GbmFBeGRGMi9TR21X?=
 =?utf-8?B?WU4zRUozbXNFaTFNZnZOZkIvWUtJZXQzUGJDT3d3aGszUlJzcUhJN2JIUnM3?=
 =?utf-8?B?UHlGOVZxQkdZTUhyN0NSNmgrRW9aejhLeVJEcVluTHFNV2RPVlF5d2YxR3B3?=
 =?utf-8?B?OCsrNGJwOENCbGp6YkR1NEJTaEcrRjZrRldrK2FPRGx5SUhkZGhSd2k3SmlR?=
 =?utf-8?B?aU9JdEpEOGthSmpCTkxlMjVFQ1JwU0U0em93MGoyMUZTbmZDRExwVkgrM3A2?=
 =?utf-8?B?bUJCNURyWHJUUWNQMDRFeVdYT3FCb2krRmV4T3Uvd1dlVmtWcHZOQXIxdU5o?=
 =?utf-8?B?bE5YcEZSN1YzUjFPQWpNOVgxa1BaaW11alB4R2YydGlyV2ptYlVpcDQrNWRM?=
 =?utf-8?B?eW9pWHFpY3AySStEUmFKdlh5TFcrM0lrY2RCaHF1bFBxcUFYdjRyZm1la2dW?=
 =?utf-8?B?bk5CcnZ4V2EwalVuL05ybGpDdmZNL1hjYjMrZ0lxTTVsTTQrRDBCbENmU2NE?=
 =?utf-8?B?VHA3VVQ0VzVWWjBQdXhBTkV0cnR4TWRJa3NpaUM5bDByYWxWQWVQSUpNMjFN?=
 =?utf-8?B?c2pRM0FEaTBJeTI5ZVlBQXVTUGU2STZlckYxR21iSUJQMGc0STRoTXRzVHJh?=
 =?utf-8?B?WVRUelY0ZE5MM0l0cXNTay9TRlpDV2s3WDV1bVhacTZmdUFQWm5laUYzNjk1?=
 =?utf-8?B?WkY0WFlNaEtpd2w4NDlSRjBiMXdWNkpTTnBGY2VyUmR0Qmx0eHAzc29NTElB?=
 =?utf-8?Q?bXgQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce4217-2cf6-43ef-1a35-08dd091ae2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 04:22:03.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jACcDDaAqwgs50/hG/kpvxpY0OoUR3FXJEwBYGOucRcWaMzAB3GoC16ITnzTZxDjBuBdzlz3eV3sYE9OS9vfiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDI0IDc6NDkg
UE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29t
PjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFNRC1YaWxp
bngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9u
Ym9hcmQtaHViOiBhZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlwDQo+IFVTQjU3NDQNCj4gDQo+IE9u
IDExLzE5LzI0IDQ6MjIgQU0sIEFiYmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+IA0KPiBbLi4u
XQ0KPiANCj4gPj4+Pj4+IElzIHRoZXJlIGEgbWF0Y2hpbmcgZGVsYXkgcmVxdWlyZW1lbnQgc3Bl
Y2lmaWVkIGluIHRoZSBVU0IgaHViDQo+ID4+Pj4+PiBkYXRhc2hlZXQgb3IgaXMgdGhpcyBhIHdv
cmthcm91bmQgZm9yIHNvbWUgYm9hcmQtc3BlY2lmaWMgYmVoYXZpb3IgPw0KPiA+Pj4+PiBUaGUg
bWF0Y2hpbmcgZGVsYXkgaXMgbm90IHNwZWNpZmllZCBpbiB0aGUgVVNCNTc0NCBodWIgZG9jdW1l
bnQsDQo+ID4+Pj4+IGJ1dCBiYXNlZCBvbg0KPiA+Pj4+IHRlc3Rpbmcgb24gMiBib2FyZHMgd2l0
aCB0aGUgYWJvdmUtbWVudGlvbmVkIGRlbGF5IGkyYyBmYWlsdXJlcw0KPiA+Pj4+IHdlcmUgbm90
DQo+ID4+IG9ic2VydmVkLg0KPiA+Pj4+IElzIHRoaXMgMTBtcyBhIGJvYXJkLXNwZWNpZmljIHJl
c2V0IGRlbGF5ID8NCj4gPj4+PiBXaHkgaXMgaXQgaW4gYSBnZW5lcmljIGRyaXZlciA/DQo+ID4+
PiBPbiBvdXIgYm9hcmRzIHdlIG9ic2VydmVkIGkyYyBmYWlsdXJlcyB3aGVuIHdlIHNldCB0aGUg
cmVzZXQgZGVsYXkNCj4gPj4+IGFzIDV1cyBhbmQgcG93ZXIgb24gZGVsYXkgYXMgMW1zIGFzIHBl
ciB0aGUgVVNCNTc0NCBkYXRhc2hlZXQuIFRoZQ0KPiA+Pj4gcmVhc29uIG9mIGFkZGluZyAxMG1z
IGRlbGF5IGlzIGJlY2F1c2Ugb2YgaTJjIGZhaWx1cmVzIGFuZCB0aGUgbGludXgNCj4gPj4+IHJl
ZmVyZW5jZSBpcw0KPiA+Pj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1p
dC85MDhmNjFiZWRiMmM0MGM2ZDg1NmJiZmQ3ZjgNCj4gPj4+IDcwDQo+ID4+PiBiOTY3YTRjYjQ5
OCBEbyB5b3UgaGF2ZSBhbnl0aGluZyB3aXRoIHJlc3BlY3QgdG8gdGhlc2UgZGVsYXlzLCBhcw0K
PiA+Pj4geW91IG1pZ2h0IGhhdmUgdGVzdGVkIG9uIHNvbWUgb3RoZXIgYm9hcmRzPyBJZiBhbnl0
aGluZywgcGxlYXNlIGxldCBtZSBrbm93Lg0KPiA+PiBJZiB0aGUgMTBtcyBkZWxheSBpcyBhIGJv
YXJkIHNwZWNpZmljIGRlbGF5LCB0aGVuIHRoaXMgaGFzIHRvIGJlDQo+ID4+IGhhbmRsZWQgaW4g
YSBib2FyZCBzcGVjaWZpYyB3YXksIG5vdCBoYXJkLWNvZGVkIGluIHRoZSBkcml2ZXIuDQo+ID4+
IFByb2JhYmx5IGFkZCBzb21lIG5ldyBwcm9wZXJ0eSB3aGljaCBzcGVjaWZpZXMgdGhlIGV4dHJh
IGJvYXJkDQo+ID4+IHNwZWNpZmljIHJlc2V0IGRlbGF5LCBidXQgYmUgc3VyZSB0byBydW4gdGhh
dCBwcm9wZXJ0eSBieSB0aGUgTGludXgga2VybmVsDQo+IG1haW50YWluZXJzIHRvby4NCj4gPiBU
aGFua3MuIEkgd2lsbCBjaGVjayBob3cgdG8gYWRkIHRoZSBib2FyZCBzcGVjaWZpYyBkZWxheSBh
cyBuZXcgcHJvcGVydHkuDQo+IA0KPiBBZGQgc29tZSByZXNldC0uLi4tdXMgLCBzaW1pbGFyIHRv
IHdoYXQgZXRoZXJuZXQgUEhZcyBhbHJlYWR5IGRvIGluIERULg0KU3VyZS4uLndpbGwgY2hlY2sg
YW5kIGluaXRpYXRlIGRpc2N1c3Npb24gd2l0aCB0aGUgTGludXggdGVhbS4NCg0KPiANCj4gPiBB
cyB0aGlzIGRlbGF5IG1pZ2h0IGJlIHNwZWNpZmljIHRvIHRoZSBib2FyZHMgd2hpY2ggd2UgdGVz
dGVkLg0KPiA+IFRoZXJlIHdvbid0IGJlIGFueSBpc3N1ZSBpZiB3ZSBjYW4gYWRkIHRoZSBkZWZh
dWx0ICJyZXNldF9kZWxheSIoNXVzKSBhbmQNCj4gInBvd2VyX29uX2RlbGF5IiAoMW1zKSBmcm9t
IHRoZSBVU0I1NzQ0IGRhdGFzaGVldCwgYXMgb3RoZXIgYm9hcmRzIHdpbGwgYmUNCj4gd29ya2lu
ZyB3aXRob3V0IGFueSBib2FyZCBzcGVjaWZpYyBkZWxheT8NCj4gUmlnaHQsIHRoZSBkcml2ZXIg
aGFzIHRvIGJlIGdlbmVyaWMgLCB0aGF0IG1lYW5zIGl0IHNob3VsZCBjb250YWluIGRlbGF5cyBz
cGVjaWZpZWQgaW4NCj4gdGhlIGRhdGFzaGVldC4gQm9hcmQgc3BlY2lmaWMgZGVsYXlzIGhhdmUg
dG8gYmUgY29uZmlndXJlZCBpbiBib2FyZCBzcGVjaWZpYyBEVHMuDQpUaGFua3MuIEkgaGF2ZSB1
cGRhdGVkIHRoZSBkZWxheXMgYmFzZWQgb24gdXNiNTc0NCBzcGVjaWZpY2F0aW9uIGluIHRoZSAN
CltQQVRDSCB2MTMgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQgc3VwcG9ydCBmb3IgTWljcm9j
aGlwIFVTQjU3NDQNClBsZWFzZSByZXZpZXcuDQoNClRoYW5rcw0KVmVua2F0ZXNoDQo=
