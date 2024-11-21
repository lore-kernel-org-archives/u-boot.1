Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45202D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA0689637;
	Thu, 21 Nov 2024 06:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfgs/OaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013C38964C; Thu, 21 Nov 2024 06:08:48 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D2089637
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+Yskz1rwpdAg7UxyagjzDQwNaZBUIXYvE8vrVjpprMAIGJ5Ya0KCUsdg/O85LOy1tcY4Ve3gVUMUG8NFVKU63HGc5p1ArvsvhBtLMxIObXmaVMD7mXsZvsATMgbfvDlj5cYx1eolvkGT1QWzdq01HAjQ4ylF+HbmBIcyi9yhSSgYUjTLocv/nTSWwBPEbC0PQiaHu+De5CfWs+Njbty6Da/bTCwbfw1YCkWAQmQLRcWTcjiiLyyaB6SBuI/4uqnlh8hxA9jwzRnS2cSTnjrh8m8N5Klhpdryj6BE5UhCC4OLJ5ZUiPZVAyVWmjAP3FfNWGpeyx/i1tSzXrZ0kkW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UHw9qPJ0OrcfJ8qN20Eo+b+Rxsj0XfvRY7qvwoLFMw=;
 b=T4MZvIBP2AW7vu4Kj0AVmV5AC3OJGvDQ5DqoFWD7mhisoFC+xZUViadaJQUoWqyiR4AS3kx9ckJYD0NFNjqJCx44SiBjELBlNswm2ojKuF9odbNUHzq5O6b2UbLpyXaB9JQ/qmzFdNdYnInPph57iA6zTBNDqr9jdP2bNVS7/e7DkIvqFEOf/rfqmvS1rm8D+tSJb4h/7b6gpiXSaq5QOzEd2OHgq6A5UYUW3eJh1ApAex8yAtP8ovNwiJu91UeQEEh5dJNVvbY3qRA7GM5RlRlE7d8cIcu8rR7U4TssafjV5xsFSKVbhL05V40wdjI9DBbMxJGCfeFpzseXbrv5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UHw9qPJ0OrcfJ8qN20Eo+b+Rxsj0XfvRY7qvwoLFMw=;
 b=bfgs/OaQoBh6EHLIXiVrUc33hiFa1c+9N7fYPnx6Q65RnD7UkAje0vqZclc1CCM+CO+MdJJZD5dEU3u+6OjOQSVqicGBjZltXzXrNQ6yG5QFr5ZjmPTxqSP8Qerg+buAMdNzWfg/t/Z/zEY6mCWl/ykcQ7TnkLgjcFssjib8ExA=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 21 Nov
 2024 05:08:39 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 05:08:39 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3QgAC2pYCABkWfkIAAGvuAgACzSwCAALpXAIAA6oDggABK1YCAAEv9kIAAsjOAgABWgFA=
Date: Thu, 21 Nov 2024 05:08:39 +0000
Message-ID: <SA1PR12MB86974CFD8C5FFC7110BF72E498222@SA1PR12MB8697.namprd12.prod.outlook.com>
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
 <SA1PR12MB869756F1B9384CE299FA1C4298212@SA1PR12MB8697.namprd12.prod.outlook.com>
 <696e49d5-a46e-46dd-a44c-cfb72781b85f@denx.de>
In-Reply-To: <696e49d5-a46e-46dd-a44c-cfb72781b85f@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ0PR12MB8614:EE_
x-ms-office365-filtering-correlation-id: fcf11565-eb7a-41b5-0168-08dd09ea8fca
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RHpUckx0aGs1TFNBbDJTRUhGbmRKRmJlWkphRTBUZDJVYW8vVG9xTW1Mb2Zl?=
 =?utf-8?B?TzJzc0NZTDQ3TTFKc3E4ejB4UzNkT0huU3NOSlY0U2tGd0dLa0tRb0gxZEx5?=
 =?utf-8?B?akVzYU80WU4xcGhyb2Rxd0NzRmFncHQ4NUF6dWptUWpYUnhRODVIVG1mVi9v?=
 =?utf-8?B?S1JGNzRUMVhxdG9TbWFtSlNJRTZoNUloYkx5ZGhnQjRXN0p4ODQxbXdtU3NW?=
 =?utf-8?B?WStRR0krN1RqYjJJMnNNNStmbG5XSytScjVJVXdxeXFTN1UrN3d5SW5CVmFi?=
 =?utf-8?B?VGoxMXdsaHFFVjJWd3dOSEdRZ1dEbk4xVkpWREw1enUyT1dHczJVYjRTVmRI?=
 =?utf-8?B?MUptaUlRanB0WVFrU3dieDBENEF1TElBelUxNVFGcXU4WU5NNEpKQVo1eWtE?=
 =?utf-8?B?dVl5S0libmV1RWFZWEE3cXV1VWhFR3pBdDdtZ3UvbXAxQzVxM21SbEV1NUx0?=
 =?utf-8?B?YnB1Ly9UTFAycnE2Rzh2MWlsTmJLaldVNVcxb1pFMTZYZUhkWEVsWkE0eE0y?=
 =?utf-8?B?VmZ0TDE1UUs3RlNIWlBVSm1HQ3dUMmcrTFB2ZGRnS05lY21YRzRxVzNZQmdQ?=
 =?utf-8?B?MmlzZ1gxbXZuNzJIRW1JREZlR2JjZEhjVDJaODdCWkdHQk5jWHliNTJEOEVp?=
 =?utf-8?B?RXBUT2xpem12RkpBUWE5bGVDdW1Bb0tHWXRVL0NKT0RXdXZhWUYwRk43eVVD?=
 =?utf-8?B?Nlplbi9SVzM4SFk2aDM2UkprcTdYYmZ3TDlQczc1b0ZvU0ZKUERHaWdtR0pE?=
 =?utf-8?B?RnAySmVWenVMQzBaWFFsNGF1TFFXcFBxd2E4a1JCWVdqOTRXMjNaaldlMk5Q?=
 =?utf-8?B?bCtlcDIyM211NXc4VDJId3VCQW03bEk1Y3lqU1lkT3E3ekVIamZ3SXcwb1Fp?=
 =?utf-8?B?MlRFWmM4U0ZmZW9QSkVYNzdKMktsVnQ2Z0VLaG9EVTMyOHN5R1dxMmJYeHF6?=
 =?utf-8?B?bUwrcjBuaWt2ek9hODZPZ1JVTUJxQUJLVEJhMDhQYjZBNllVT0twbGJkeExD?=
 =?utf-8?B?aTBvU1JwbXY5anVCUWhSRG9iSFZ1NFhnd1FYRmt0ejRJbGtOdG9PVkJuU3cw?=
 =?utf-8?B?WlY5QXlrV1FTTzg2L3Q0MEF4dzBUU3Y1TFkra2tvaFhwVGVuNFZVems1RHor?=
 =?utf-8?B?bTdTdzBqSjdKc3N6Zm9PYXVxdlpXbXZWZFVEOVVxamR0MHZ6bzVpaUpaTENQ?=
 =?utf-8?B?d2ljeUs1Z2c3SnRUbDFDN3VzUVlUcFREUVBEOXVCS25BVHp3c1N6bnIrYkQx?=
 =?utf-8?B?eWlOQlV1eWFkMWVKVmNTRUVLb3ptYzdlTmE2NUxLa1llbTd0SXZpWlJSUWUy?=
 =?utf-8?B?K2tlZlBmaTJlZkJIQ2MwL3ZwNWlZbUlOOW5TcEtDOGVxdTRtUC9iV3RCWjVR?=
 =?utf-8?B?cmJMUTRHeFdrQ1NMbjVXYmpESklGVmltc1Vha3ZsWUZRWEpNdmJLb2dTUzk3?=
 =?utf-8?B?RHJiR3AyYndEZ1djdkNmeFhqeVJPb1FBdnIrQWFBL05ldUVkUVV2UDNpYWlu?=
 =?utf-8?B?SXNZbGJHTzBCNSt6K2grTUVWQ1JsQlA4MmMwVmxveVdTS3hwSldGNUlEeDgz?=
 =?utf-8?B?MndGWU5BWFVVRXJMRGNJVzZFWEpJMVpjMU9TZXJTQUNKSW5uaHhoUSs1TWJj?=
 =?utf-8?B?MGR6akliQWwwY1RyRGJNK2VQSGRaUnAxNTYyU2VRQWZCeVViWlBUbzBCaWQ4?=
 =?utf-8?B?eGJyN0NQSFJ0OUV3ZVppeHAxZWxkT1VYcTBhTzk3V2Q0bll0ZXJrQktDSjZ5?=
 =?utf-8?B?Mnpqem1oc1M4c1Y3ZHhYeGxkcGt4cVhHa0dJYnRKOGpXdDJmdE00aXdPNmln?=
 =?utf-8?B?M3RRdW9XeHZHMDNUUzc4UTBRNE9vaStNcmVTcWdFWGNzMkFRMThtKy96MDNH?=
 =?utf-8?Q?AMFW7+Ic2pfD9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZDZW5WS04rcFZyTjV4eVpJMTYvZmx2QzFuSS9GempnNWR5a2l5Yi9UMGgr?=
 =?utf-8?B?R0JiakRNcjVFK3kvb2VBQktSTjhRZUNiWEtyYjMzSUY4SktweUR5T2VPcGww?=
 =?utf-8?B?YmEvenlIWkFBazAwOGkwSUhwVk91Rm10WlpObUY4YmhacjUvSXNoRUhBRmdT?=
 =?utf-8?B?VStlVER4c2pxR0NyLytWUDJJM0xuZDQyK1lhVi9aa0FlNjlsakdyNzR3ZGlT?=
 =?utf-8?B?MkY3MzIyeFdwNXZ2dm95LytwNkNmYVdiQlpsY0ZnczV0amsrRVJWdWl4WGFy?=
 =?utf-8?B?aExaNUNpeGdDVDNXajJRbXdMQkVIS0dmQWJLMExpOWhSSkV2Tm8xTDlyVnFW?=
 =?utf-8?B?cWZ4ZUNGdFIyQjUwWldMSnhjV1JzTit0OWM1M1V6NDU2YzhDMlFxYUpvbUY1?=
 =?utf-8?B?bER0eTRPSS9NM0kzV0N1RTJNYWZUYnNmOHdXRmJBV3pBVmtreWhaUVpCV09Z?=
 =?utf-8?B?MGQwWHZWRWtCZ1FCWmhYbDFmV0lDbWVPYTRrMW41ekxIWlA3TitpaU1lbVR3?=
 =?utf-8?B?MjBuR3JSYVoxMmJLeVFWNDJjRTh6VDdXemJFQmJOQmFjbmVyNVd5N1F4TzNa?=
 =?utf-8?B?d1Iyb2VPeFZWdVFpaUNWWnFCNFJHWTdhRlYwYll6ZHcrWWc2RkNiNGI3TFFo?=
 =?utf-8?B?UEFOSmsza0pDckpMb20xa1VSZWJRby9RWmtKTTFjQmlhaTVnYjRQSXFVSytQ?=
 =?utf-8?B?SFBGRUZDT0tRdkZjaDlqcDcrOFFteFNNTkRGemYwRSttQUFsQ2hvMnpYSnlD?=
 =?utf-8?B?SHFBdEtuajFPQ2JpOE1Sek1mLzE5UTFXRmRIYU9jT1VGaWJINzgzTk0wV2hU?=
 =?utf-8?B?N1ZzUFJxOHYxTjNQZkc5c3k2OWowZDgybC9FazV5Vis0MGF1aVo2QzZMUDJP?=
 =?utf-8?B?NWtMa3Z3L0d5bnh5Tm1Ea2cvWmZ4dkYzNXc2K0t1ejNMaWN0U1p1c3NRaWZ3?=
 =?utf-8?B?Sm9pL0w4TElLUG9CZ2wzSkg5cFVWZk1oU3RacEN5SW0xSHlsT21JK1Fhd2c3?=
 =?utf-8?B?aXVmSHBuNmlVaXJ3QkJUSmtOcFgzQkxxcXk2UGtZQTVReEhESjJkc09VVXh1?=
 =?utf-8?B?bWdQSUZzMjNlYlZNTFVyb3hHRHRqVVpkWjVTcDhyblBYcTFHUHRuMzNWRmlS?=
 =?utf-8?B?Zko5VjlqbFJnYnlHSkdOVWZydEtRL3Y5cXFkeHAzT3RsckRKWndBRlNiL2hD?=
 =?utf-8?B?VXFOQkVxaVJCWElnQ2dpQnBrRDFJUElKOGRRdk1kZVNhaWVSMXpYTUVuMjBw?=
 =?utf-8?B?VEFyQ0E5Yk1mVFE5aTRHSGFORmFMNmVwbXprMzNQVklmVGlCL0c1TUh2d2M3?=
 =?utf-8?B?bHlDTExSWVpxdnFjWFVXSExhbnA1eFltT1l6dVNPTEJSaW5IUmQydy9mSldZ?=
 =?utf-8?B?aURqSVRCYzlKS0RtdXczcjQwY3Z3a01DaEorcGNTOUdQajlkRzNnS3puL3Vu?=
 =?utf-8?B?bWxrU1J4ZmZuU2dVdStXcnFtcjNEK2dvM0RGa1dNL1ZDeDF2bzBXWVRDNHJW?=
 =?utf-8?B?N3F3amRZV1lrY0VoVE02NldNNzgxWVdGbUpxS3NXNkpsamRlRkRyUW4wQ2Ur?=
 =?utf-8?B?Z1ViYy9RR1hZWnJ1UWo4ZC9iVnNteUpkUnZVbTdhdGFyeWJTTklFZWR4bml4?=
 =?utf-8?B?NGVmSmRBVVpJMUZHNW8yOS82UG9OT3h1SlM3MjV4V2lueVpsUHZTYWNrUGxr?=
 =?utf-8?B?S0lyT2w2V3ZLaFZwbU5ZbHBBRlI3THJWcDJ4RXJxcWxBbkxGd3VnODJrWm1o?=
 =?utf-8?B?cVk5Q1JaRGNyKzM3cDBXcW1vcXcyREVUNzRWZTl4MEdKZzFIZjJPWjFYUjhE?=
 =?utf-8?B?Z0pTd2VQVTl3VUdFUmFwNGdyMVNEY0JyRElVeEFrd2tSeEZnbHpMMEd3R0Nt?=
 =?utf-8?B?Ry9ialA2NTBOS3c5aG1WMC9OQWRDeFBlcUo0cm85UnBMblc1T3h2eENFOHJw?=
 =?utf-8?B?ZGtJUHN6cjg3V25CQXZvUjBER0s4OFQrM3BSTUkxVUo0V1hENHV6a3prSVF3?=
 =?utf-8?B?N2RxVnR1R2FaRTFWQ05VVjh2VGQ0YnoveExpbS9zYlc4U0h2MEJ6c2tJVHVP?=
 =?utf-8?B?M2lSSDZkSXlwNzVLVzQwSzQ4eFdPRWxhOVgrTitUWllRdzJDQnVZdXZRcVdN?=
 =?utf-8?Q?2Bvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf11565-eb7a-41b5-0168-08dd09ea8fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 05:08:39.5373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8aCrTibSNJl3vHyinNIx32m6onoIePHQJtBAEnkgA/XxyKaT/G0KRalFJTdDFPipdDokg2f7y3lGKIumWUn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyMSwgMjAyNCA1OjI2
IEFNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBv
bmJvYXJkLWh1YjogYWRkIHN1cHBvcnQgZm9yIE1pY3JvY2hpcA0KPiBVU0I1NzQ0DQo+IA0KPiBP
biAxMS8yMC8yNCAyOjIwIFBNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+IEhpLA0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcmVrIFZh
c3V0IDxtYXJleEBkZW54LmRlPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIwLCAy
MDI0IDI6MTYgUE0NCj4gPj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJh
cmFwdUBhbWQuY29tPjsNCj4gPj4gdS1ib290QGxpc3RzLmRlbnguZGUNCj4gPj4gQ2M6IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4gZmFicmljZS5nYXNuaWVyQGZv
c3Muc3QuY29tOyBnaXQNCj4gPj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQgc3VwcG9ydCBm
b3INCj4gPj4gTWljcm9jaGlwDQo+ID4+IFVTQjU3NDQNCj4gPj4NCj4gPj4gT24gMTEvMjAvMjQg
NToyMiBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPj4+IEhpLA0KPiA+Pj4NCj4g
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IE1hcmVrIFZhc3V0
IDxtYXJleEBkZW54LmRlPg0KPiA+Pj4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDI0
IDc6NDkgUE0NCj4gPj4+PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFy
YXB1QGFtZC5jb20+Ow0KPiA+Pj4+IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+Pj4gQ2M6IFNp
bWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4+PiBmYWJyaWNlLmdhc25p
ZXJAZm9zcy5zdC5jb207IGdpdA0KPiA+Pj4+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+
ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQg
c3VwcG9ydCBmb3INCj4gPj4+PiBNaWNyb2NoaXANCj4gPj4+PiBVU0I1NzQ0DQo+ID4+Pj4NCj4g
Pj4+PiBPbiAxMS8xOS8yNCA0OjIyIEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+
Pj4+DQo+ID4+Pj4gWy4uLl0NCj4gPj4+Pg0KPiA+Pj4+Pj4+Pj4+IElzIHRoZXJlIGEgbWF0Y2hp
bmcgZGVsYXkgcmVxdWlyZW1lbnQgc3BlY2lmaWVkIGluIHRoZSBVU0INCj4gPj4+Pj4+Pj4+PiBo
dWIgZGF0YXNoZWV0IG9yIGlzIHRoaXMgYSB3b3JrYXJvdW5kIGZvciBzb21lIGJvYXJkLXNwZWNp
ZmljDQo+IGJlaGF2aW9yID8NCj4gPj4+Pj4+Pj4+IFRoZSBtYXRjaGluZyBkZWxheSBpcyBub3Qg
c3BlY2lmaWVkIGluIHRoZSBVU0I1NzQ0IGh1Yg0KPiA+Pj4+Pj4+Pj4gZG9jdW1lbnQsIGJ1dCBi
YXNlZCBvbg0KPiA+Pj4+Pj4+PiB0ZXN0aW5nIG9uIDIgYm9hcmRzIHdpdGggdGhlIGFib3ZlLW1l
bnRpb25lZCBkZWxheSBpMmMgZmFpbHVyZXMNCj4gPj4+Pj4+Pj4gd2VyZSBub3QNCj4gPj4+Pj4+
IG9ic2VydmVkLg0KPiA+Pj4+Pj4+PiBJcyB0aGlzIDEwbXMgYSBib2FyZC1zcGVjaWZpYyByZXNl
dCBkZWxheSA/DQo+ID4+Pj4+Pj4+IFdoeSBpcyBpdCBpbiBhIGdlbmVyaWMgZHJpdmVyID8NCj4g
Pj4+Pj4+PiBPbiBvdXIgYm9hcmRzIHdlIG9ic2VydmVkIGkyYyBmYWlsdXJlcyB3aGVuIHdlIHNl
dCB0aGUgcmVzZXQNCj4gPj4+Pj4+PiBkZWxheSBhcyA1dXMgYW5kIHBvd2VyIG9uIGRlbGF5IGFz
IDFtcyBhcyBwZXIgdGhlIFVTQjU3NDQNCj4gPj4+Pj4+PiBkYXRhc2hlZXQuIFRoZSByZWFzb24g
b2YgYWRkaW5nIDEwbXMgZGVsYXkgaXMgYmVjYXVzZSBvZiBpMmMNCj4gPj4+Pj4+PiBmYWlsdXJl
cyBhbmQgdGhlIGxpbnV4IHJlZmVyZW5jZSBpcw0KPiA+Pj4+Pj4+IGh0dHBzOi8vZ2l0aHViLmNv
bS90b3J2YWxkcy9saW51eC9jb21taXQvOTA4ZjYxYmVkYjJjNDBjNmQ4NTZiYmYNCj4gPj4+Pj4+
PiBkNw0KPiA+Pj4+Pj4+IGY4DQo+ID4+Pj4+Pj4gNzANCj4gPj4+Pj4+PiBiOTY3YTRjYjQ5OCBE
byB5b3UgaGF2ZSBhbnl0aGluZyB3aXRoIHJlc3BlY3QgdG8gdGhlc2UgZGVsYXlzLA0KPiA+Pj4+
Pj4+IGFzIHlvdSBtaWdodCBoYXZlIHRlc3RlZCBvbiBzb21lIG90aGVyIGJvYXJkcz8gSWYgYW55
dGhpbmcsDQo+ID4+Pj4+Pj4gcGxlYXNlIGxldCBtZQ0KPiA+PiBrbm93Lg0KPiA+Pj4+Pj4gSWYg
dGhlIDEwbXMgZGVsYXkgaXMgYSBib2FyZCBzcGVjaWZpYyBkZWxheSwgdGhlbiB0aGlzIGhhcyB0
byBiZQ0KPiA+Pj4+Pj4gaGFuZGxlZCBpbiBhIGJvYXJkIHNwZWNpZmljIHdheSwgbm90IGhhcmQt
Y29kZWQgaW4gdGhlIGRyaXZlci4NCj4gPj4+Pj4+IFByb2JhYmx5IGFkZCBzb21lIG5ldyBwcm9w
ZXJ0eSB3aGljaCBzcGVjaWZpZXMgdGhlIGV4dHJhIGJvYXJkDQo+ID4+Pj4+PiBzcGVjaWZpYyBy
ZXNldCBkZWxheSwgYnV0IGJlIHN1cmUgdG8gcnVuIHRoYXQgcHJvcGVydHkgYnkgdGhlDQo+ID4+
Pj4+PiBMaW51eCBrZXJuZWwNCj4gPj4+PiBtYWludGFpbmVycyB0b28uDQo+ID4+Pj4+IFRoYW5r
cy4gSSB3aWxsIGNoZWNrIGhvdyB0byBhZGQgdGhlIGJvYXJkIHNwZWNpZmljIGRlbGF5IGFzIG5l
dyBwcm9wZXJ0eS4NCj4gPj4+Pg0KPiA+Pj4+IEFkZCBzb21lIHJlc2V0LS4uLi11cyAsIHNpbWls
YXIgdG8gd2hhdCBldGhlcm5ldCBQSFlzIGFscmVhZHkgZG8gaW4gRFQuDQo+ID4+PiBTdXJlLi4u
d2lsbCBjaGVjayBhbmQgaW5pdGlhdGUgZGlzY3Vzc2lvbiB3aXRoIHRoZSBMaW51eCB0ZWFtLg0K
PiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiBBcyB0aGlzIGRlbGF5IG1pZ2h0IGJlIHNwZWNpZmljIHRv
IHRoZSBib2FyZHMgd2hpY2ggd2UgdGVzdGVkLg0KPiA+Pj4+PiBUaGVyZSB3b24ndCBiZSBhbnkg
aXNzdWUgaWYgd2UgY2FuIGFkZCB0aGUgZGVmYXVsdA0KPiA+Pj4+PiAicmVzZXRfZGVsYXkiKDV1
cykgYW5kDQo+ID4+Pj4gInBvd2VyX29uX2RlbGF5IiAoMW1zKSBmcm9tIHRoZSBVU0I1NzQ0IGRh
dGFzaGVldCwgYXMgb3RoZXIgYm9hcmRzDQo+ID4+Pj4gd2lsbCBiZSB3b3JraW5nIHdpdGhvdXQg
YW55IGJvYXJkIHNwZWNpZmljIGRlbGF5Pw0KPiA+Pj4+IFJpZ2h0LCB0aGUgZHJpdmVyIGhhcyB0
byBiZSBnZW5lcmljICwgdGhhdCBtZWFucyBpdCBzaG91bGQgY29udGFpbg0KPiA+Pj4+IGRlbGF5
cyBzcGVjaWZpZWQgaW4gdGhlIGRhdGFzaGVldC4gQm9hcmQgc3BlY2lmaWMgZGVsYXlzIGhhdmUg
dG8gYmUNCj4gPj4+PiBjb25maWd1cmVkIGluDQo+ID4+IGJvYXJkIHNwZWNpZmljIERUcy4NCj4g
Pj4+IFRoYW5rcy4gSSBoYXZlIHVwZGF0ZWQgdGhlIGRlbGF5cyBiYXNlZCBvbiB1c2I1NzQ0IHNw
ZWNpZmljYXRpb24gaW4NCj4gPj4+IHRoZSBbUEFUQ0ggdjEzIDMvN10gdXNiOiBvbmJvYXJkLWh1
YjogYWRkIHN1cHBvcnQgZm9yIE1pY3JvY2hpcA0KPiA+Pj4gVVNCNTc0NCBQbGVhc2UgcmV2aWV3
Lg0KPiA+PiBWMTMgYWxzbyBlbmFibGVzIHRoZSBodWIgZHJpdmVyIGZvciBYaWxpbnggaGFyZHdh
cmUsIGRvZXMgaXQgbm90ID8NCj4gPj4gSWYgc28sIHdvbid0IGRvaW5nIHNvIGxlYWQgdG8gaW5j
b3JyZWN0IGJlaGF2aW9yIGR1ZSB0byAtLSBub3cgLS0gdG9vDQo+ID4+IHNob3J0IGRlbGF5ID8g
SSBzdXNwZWN0IHlvdSB3aWxsIG5lZWQgVjE0IHdoaWNoIGFkZHMgdGhvc2UgYm9hcmQNCj4gPj4g
c3BlY2lmaWMgZGVsYXlzIHZpYSBEVCBmb3IgdGhlIFhpbGlueCBoYXJkd2FyZS4NCj4gPiBUaGVy
ZSBhcmUgbWFueSBjdXN0b21lcnMgd2hvIHVzZSB0aGVpciBvd24gYm9hcmRzIGFuZCB0aGV5IG1p
Z2h0IG5vdCBzZWUgdGhlDQo+IGlzc3VlIHdoYXQgd2Ugb2JzZXJ2ZSBvbiBYaWxpbngvQU1EIGJv
YXJkcy4gRG9uJ3QgeW91IHRoaW5rIHdlIGFyZSBibG9ja2luZyB0aGVtDQo+IGJlY2F1c2Ugb2Yg
b3VyIGJvYXJkIGlzc3Vlcz8gV2hhdCB5b3UgdGhpbms/DQo+IFN1cmUsIGRyb3AgNiBhbmQgNyBh
bmQgdGhlIGN1cnJlbnQgc3RhdGUgb2YgMS4uNSBjYW4gZ28gaW4gSSB0aGluay4NClJhdGhlciB0
aGFuIGRyb3BwaW5nIHRoZXNlIHBhdGNoZXMuLi4NClRvIG5vdCBibG9jayBvdGhlcnMsIHVwZGF0
ZSB0aGUgZGVmYXVsdCByZXNldCBkZWxheXMgbWVudGlvbmVkIGluIHRoZSBVU0I1NzQ0IGRhdGFz
aGVldC4NClRoaXMgd2F5IHRoZSBjdXN0b21lcnMgY2FuIHVzZSB0aGVzZSBwYXRjaCBzZXJpZXMg
YW5kIGRvbuKAmXQgd2FpdCBmb3IgdGhlIFhpbGlueC9BTUQgYm9hcmQgaXNzdWVzIHRvIGJlIGZp
eGVkLg0KV2UgY2FuIGZpeCBYaWxpbngvQU1EIGJvYXJkIGlzc3VlcyB3aXRoIHRoZSByZXNldCBk
ZWxheXModmlhIERUIHByb3BlcnR5KSBmb3IgVVNCNTc0NCBieSBpbnRyb2R1Y2luZy8gZGlzY3Vz
c2luZyB3aXRoIExpbnV4IGNvbW11bml0eS4NCkkgdGhpbmsgdGhpcyB3YXkuLi55b3UgZG9uJ3Qg
c2VlIGFueSBpc3N1ZSByaWdodD8NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg0K
