Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C1C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 10:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8511883A1A;
	Wed, 28 May 2025 12:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5RGOduTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66A783A24; Wed, 28 May 2025 12:16:59 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19D183091
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stOb1+NL2xYZQF09b4AVGI9UJh2RBxgDSRX5YkdbFFVD1mdgsczROLK197CyVgnV+IgerrY4BgjriVMyEcUdf+D9dpmSK3lQJGH7oAqizumVa07aOV25Qi6YCJG+ZcFp/qqZvNILteCFI3InZYjwe3XJ9yxbs3jxJwL5bt7gCI/ihXRDx2Yfdr98f1YWhJ1J03Ag/vU8YV9I+KeLdNJpqa9tMm6ZHex8YzdtxLZKQm1G+mriu1S8zOndkrVttaT5bWZAQbglS9ldx3K+84AeKpyGEV0aygqhhT13P+akEw8srtNi/ezsjXvdvWQRgm2oTGDUxrAuEaLOWVIn5wqYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sBOAHp3F2noqGCKgu5aHN7xfKRwGU/PKf2hS3V0xLM=;
 b=uzUZraoj8+KRSThdc77wEAmFEdrKfU8SCoeLtvX1aUMW5EKg0YKoj1BQLdjmIlYG9WvN2B6BAWox9OSnKgpacDLUsGTkN6Nhag4A43ZM7YJdT2FX3shwKk5/p8Nne5+jETK9FmVnqTZWqtG5nzUe6tW+kS08nboumQE8icdJv0Zq5hHACJSUstVpNtuyPjpHM4ecARpdFSMsFemaI7e/8WAMEA7T8xP+ciEUY76APkVLFQV9qGIYKdZRcWsmN3yGnXdYQaQbOxqhYHs+KrnJONSwJWZ5JnPvNkwD0hqOy0IcE3GVTlLreo/9XRbSUSNrzg3eWUm7wsSFyw6Fq0PAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sBOAHp3F2noqGCKgu5aHN7xfKRwGU/PKf2hS3V0xLM=;
 b=5RGOduTAMG6lwbJQYz7EDJHWektf6gNnKdsOz9JWgZW15SY67RGIZ1lqEDTAcjVSDsJMBWkrDNX+yiu71Rb2pCtrdXCcOp3oHMOerRVULitYe+KXLyySyAzxYSadcM7iUkjZYPVltFiD3xcsjA4qYGzYJtENWVOpwbceOk2d7y8=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 28 May
 2025 10:16:51 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 10:16:51 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Thread-Topic: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Thread-Index: AQHbz356yVYZKTVOZ0GdNKuglyzjFLPnyJAAgAAKqwA=
Date: Wed, 28 May 2025 10:16:51 +0000
Message-ID: <SA1PR12MB8697D1BE095030270EE6B1FD9867A@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250528031255.1762438-1-venkatesh.abbarapu@amd.com>
 <0f2037cd-3bfc-bc50-79e0-e84d8bf6766b@denx.de>
In-Reply-To: <0f2037cd-3bfc-bc50-79e0-e84d8bf6766b@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bafe6c70-f625-4b3f-9e7f-623e54bbe333;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T10:13:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DS5PPF4ACC15C0E:EE_
x-ms-office365-filtering-correlation-id: b78dd3c8-aa34-4bca-a8e7-08dd9dd0c379
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkd0M21lcFBjSXZJT0dnODR3NmpFN0NUL0h2bDlpSDV4REFEYkozd3BYcTQy?=
 =?utf-8?B?dDlmZm1Pd3gvbE5taXBBazZpb0pVeTNqN3B1KzhFajRKcy96NG1RVVpVc0Vp?=
 =?utf-8?B?amxYZ050MUZ1dmdnSlFuaW9PM2VyaFFYTUQxVkNiT1h1MG1LY2ZLUjI0QUhM?=
 =?utf-8?B?cXdTeDg2VzZqcjNxQmN5VU1GVTFSb1hqM0x2SXNFVVZPc0U0aTM4RDdnc2Jj?=
 =?utf-8?B?c0pmdzhKOE9Ldm1QMFBqM0kybmNXMW9lQjNiK3hmMjNsTEVLV2hnejJNU09F?=
 =?utf-8?B?ZUJDdmdTa1JrL0wyMzljVFBOQ1c2ejVPaE5CK2NRdDhhT2hva3FjbHJWTzVF?=
 =?utf-8?B?SnowV0JyNUNRSnVZVjBuNjFNWjRwNmtVWmh4TUc1a0kwenlVWll6WUpUc3FH?=
 =?utf-8?B?ZUhzcG8vU2FEYTdYcUhZdTM1ems0L0Jja0RyS3hpQU1IOEdtSHBJWENRbGh2?=
 =?utf-8?B?eTgyNUIxUzNMOEl3SUM0emp4bEdlbzMzY2w5SWZRUWxlNFNCTHZPbEVYemZn?=
 =?utf-8?B?dGRaS2ZBbGFoMjgwWFIxWE9xb1d5aVpNYzUvTnlBN2REUTRyblF3TUJlZmZU?=
 =?utf-8?B?RkJtdmRWZVcvbEVCQTRMRDBGQSs0aDB0aFFrR012K3FYRk9paUNuVzBkTXJz?=
 =?utf-8?B?V1ZvMW5HNDhKVTJoU2FWdTlqSlUrbXVtSWhXeDZEbGxiTk1XdlNzbkdDZXEv?=
 =?utf-8?B?NFAzZDZBNGc1dTRxeUN1cE5Gb1lhV1k5SnRzRG1DOEZUVVd2UlJhTHVEVnhn?=
 =?utf-8?B?M1d4TGprdXpGRnB0TVBxZEtMV2hXa0t3OUxKZHVld1B1ODY4ejhtTGJCaXhB?=
 =?utf-8?B?Nng2bDZxMHdlYi9mTG5lcEgyWDBMTVZyVVI3M3BvWk9tZ3NiNzF2LzFkZzBB?=
 =?utf-8?B?RnVRWll2d1JPaGVBcWlDV1JGbWFlbUFmVjFpUHg4THE4VXVtQW13ZDFKMXBY?=
 =?utf-8?B?MEp2bGIrMmFuVVZSUm90SFJtWTUrWTIwaW53Y0VnTkFPQXNzblFJTGY3RWZn?=
 =?utf-8?B?R1B5ZEk5V2dmbmkzUzh0aWpiVzB5VXNxdGg0L1lOR0x1RWpSUnJHallMYlNB?=
 =?utf-8?B?RkJsNHdXWjFzNzRWK0tNcGNTOHpPRnVvRUI0eXFEeDFHZ2ovcWQ1ZXZZSEJi?=
 =?utf-8?B?U0NHL3BuVTV2TXpEalVsMzNuNnFHMkE5aERWOEg0ekpMb1VpWUR1NVBuNVR2?=
 =?utf-8?B?SjFROTM0NVRyRi9LUDRWNUlUV1JrbVJDTEpCTHFmb0g3NkFkRGIrYU41YTNp?=
 =?utf-8?B?a2NqUldmRmU0WUwvWmg0NlR5SWx5ZDZaa0hQa085WllKdWdNU2xJSFFES1dq?=
 =?utf-8?B?U0lwOE9HWldxb29EN0RidUt1SUhYelFWcVJnRWowUmpyM2JxdzlmN1FVbjhM?=
 =?utf-8?B?dFdCUTJ4SldGK2hTb2YwYUpEL2p6bVVocG5USXNqSnl6dTlkMlZYc2R3VzlG?=
 =?utf-8?B?ZXpkUFg1dGQ2b3ZrV2JzajJ0Q1FlRk1taitZZysyb2ZrS3FrdzgzSHFwZDZY?=
 =?utf-8?B?YnBFc0k4MVpYVVZZWkVOVW5BdTdQNlh5UGgxcnVpQkNVQWpFQjJJdTlBRGRx?=
 =?utf-8?B?dW02WGVKYTBxRitwMVExUklDVkg0YjBUcVJoZmxselhuMWJXSWVJc095VU9v?=
 =?utf-8?B?Vk5sb3JmV1Mxckk5dXVLMjhwUTdQcnlWbTZWdjdKeXpPK2o0UnhNSDJYMDZX?=
 =?utf-8?B?QXRBUmNtT3BtSm5yL2NITW9ETkYyMzg0S0tmYUowa1k5OXc2OXlncVBDY210?=
 =?utf-8?B?SUpCS2lDTWR0d1l6a2RXcjB3VklXWDliNGwxWGxLaWlpR0oyYnN0KzZiM1g4?=
 =?utf-8?B?L0h1RnFxdHVLN3c0SnRJYWxWYVpHenVidmNobU1PbUZZT3BaSmhWUjF2blhi?=
 =?utf-8?B?QlAvUmpTOWdqKzRGYzdQVUNqN0U2a2lJMTJBTkdCL211L2JLR3NvdlE5aWtE?=
 =?utf-8?B?cEdKcTZldlg1UzlRWjJ1R2pyRE8vNDFvYzhhNWErZXFMMmlQQnBhSDg2aU9s?=
 =?utf-8?Q?M4TuSRfTsCY4ndLCEupg3L2Fe6SjbE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nit6RmZ0bWloLzZsNlJJWUZKQ2Q5UjNjc3lDWksrMkkwNjJQUmlIUHRyRDBE?=
 =?utf-8?B?WSsxV1NWdUtUWE14TXhWREVlK1o4em1yOURQNXVSMGY5eUxZd1lIeW9uaEV1?=
 =?utf-8?B?QU9LK0VKaVhZQTBPMVIydUs2bTZvQlg0VEVsZUF1L013QUdqZ2ozZ0xVMC9l?=
 =?utf-8?B?bGFmZkFhRzBoY3d6bjgreEpRQThuNUY1ZjNHK3RCMElCRW9HcVVIWkxoWmxX?=
 =?utf-8?B?UlFuRXRHbEtWZU5mOTBjb2ZtanFTbzlXbWJLNCtBaHdEbXI4aDl3czlvS2k2?=
 =?utf-8?B?NjhnS1VoSDkvbjFVN0JwV2NyWGtlTmdlbWx0MHpjSktlWlh6eElDVFpRWUU3?=
 =?utf-8?B?cTl4SkRQZlFUZm8vWndXaDUwVWwrbzdwZVZhM0FSNmhpMTN3RVNLV2NqK1dr?=
 =?utf-8?B?UjBTL2M4TGxCN0gxRnpDY3pPbmhTVmlhajNGVzJ6K2pHeWZVcURoV25uN3kr?=
 =?utf-8?B?WVNUT0twMVlCUHl5L3hmenhGMDQ0ZnhZT3YvdDV1M3VuNjFtVFpxMy9NR2VC?=
 =?utf-8?B?amcxcXhsWUJrcmVNU0JodGNTa3VxM2RoMnhmTnZKYkFmcGJkOExEWjZpRzVh?=
 =?utf-8?B?RTdmeDhkZ1hJYWxaTTd6OW83WFdJb2xBTXl5cmNFNTdEc1RyK1M4SSt6eXNh?=
 =?utf-8?B?aE1pb2NXeVhZOHFIaE45aUdDUXFIQ2lMTTNVdFZ0UUNyMVNLZHkrRS9Hd1Bi?=
 =?utf-8?B?R2NTOVNmMWtGaXkyaUlobXV6ZEkvbldEYTFVYjNIdW04Snl2MDQ3bWZCakdW?=
 =?utf-8?B?ME02VU5qdFU5R0ZpWmxpUDhXbWRBaWY3aHBkU2NGT0owZlNVMTk3UDAzdHFv?=
 =?utf-8?B?ZEZ6WFQ3Q3BERzFoU1doUUVDMmwyTVRuUXNCMVJqSmJzR0RLSVZPUE5QeUVD?=
 =?utf-8?B?QUNTV3lYMUpLeUhKbTNhV0E4UHYrS2c1VGVVUFJaMC9panJpaFdDdytoRmRr?=
 =?utf-8?B?aUd3QU9BT2VKaEphSUVISkNINEdzam90R1B2SXU4T3Y5L0U2em5lYlk3TEZo?=
 =?utf-8?B?MWxpcVpsUHg1UjRTTDFwTi9rbGdBVWh1UGtDYlJjeWI5VkFueWV5aDVRZ2tw?=
 =?utf-8?B?YW92SUNySzZIK2dmOEZhRGVycnpESWtHNnIrZHRKQ0s3NmZReDRjdHpndzM0?=
 =?utf-8?B?TkVSTm1aVEcwbDNUTnEyY2VMQ3o0eW5ZVUY5eTVINFhrOHYrYlVBamtyZGsr?=
 =?utf-8?B?SHZtQmtvV0t5MGE2WnFhRTU5aHd3bU5GSGpvN2NLMmgzcHJ1b245ZVpUL2hE?=
 =?utf-8?B?Ny93QlRHN3ZQenVFNy9VanVRd2EwczhaNmRwNG9oeEhWVzRxeDlIb1Q4L3Bv?=
 =?utf-8?B?WnBrUFdQTFZwK2owNXFTM0tianROejdlRW9TakdhSkpITS9NZXdpS2lWZDBy?=
 =?utf-8?B?ekE0aTc5dUdRRVdDWUxVeDVXbHBnSnFxTVRRZVNpaHFGV3JqQTRCQUlRWlhX?=
 =?utf-8?B?VmllK3dJQzlZOWEwV0NNeFArRSsvRTE3eTNMK1RIVzBFUFRZWTdIWWF0c0E5?=
 =?utf-8?B?WjhCWGVRNjA1bHdYeWVDVTBIbmdMbzZkM1VhY01EU2lVeEYwRjAvb2ZveGRD?=
 =?utf-8?B?YXRYTno3UTZZTjgrRTgrSC9JMlh6M0FnbllmdUkvZXc4NWxuZDlNSkQwSThP?=
 =?utf-8?B?Sm5paGovcHNCb1VvRld1YXZqVkd1Y3Q1T1d6MFZYaHk4RjE1eWZWTmlJSmh2?=
 =?utf-8?B?am1ab1hZQ1FaWkFSZDJLdTlCWmtmbU51ZDRBR1c0ejF5WDBuWHVFM3ArSWlz?=
 =?utf-8?B?UnJmS09tc2xjTDVEU3l5NDJlL3lWQ2NNdG9wTzFka0hwYXozSHl3cFJzT3VE?=
 =?utf-8?B?Q2tLNklwckVidGVSaVRjaG1OYnhnMTNTM2NPOC9jeXdnN0oxMXltam8rbnhw?=
 =?utf-8?B?WDh5dXBtaE1FNG10WHhkNEFYQkZwM3Jqcm4vSU8rbzRrcVNzOElUcFFEa2Rl?=
 =?utf-8?B?NFpsWWExYnU1Ukc1aHRJZmwxRkV2aGcxTmlnaWNBN1grY2ZFR0djcGRaWlU4?=
 =?utf-8?B?bi9UZk5KUWtUTmJjZDRRcWRqdktnZ1BmR2xJNVJkSzlrSXpvS0RtelVLczlC?=
 =?utf-8?B?Um5kTlRxSVRMcHlKRkM2M3lIV2RuU1Mwd1ZJMzZQZTF3My9GS3NxbE02MS9z?=
 =?utf-8?Q?RPbY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78dd3c8-aa34-4bca-a8e7-08dd9dd0c379
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 10:16:51.4321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CqCLpLRIK2q48teNpVO9RpU2ftC09cwT7jVmUv2LApRhymDx30IkrHO/dzBja7QSq1PGy0JXVor9vcAhdUzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgSGVpa28sDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBI
ZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjgsIDIw
MjUgMzowNSBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1
QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJv
bWl1bS5vcmc+DQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IHRy
aW5pQGtvbnN1bGtvLmNvbTsgZ2l0IChBTUQtWGlsaW54KQ0KPiA8Z2l0QGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGkyYzogbXV4OiBGaXggdGhlIGNyYXNoIHdoZW4gdGhlIGkyYy1h
cmJpdHJhdG9yIG5vZGUgaXMgcHJlc2VudA0KPg0KPiBIZWxsbyBWZW5rYXRlc2gsDQo+DQo+IE9u
IDI4LjA1LjI1IDA1OjEyLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4gT2Jz
ZXJ2aW5nIHRoZSBjcmFzaCB3aGVuIHdlIGFkZCB0aGUgaTJjLWFyYml0cmF0b3Igbm9kZSBpbiB0
aGUgZGV2aWNlDQo+DQo+IFdoaWNoIGNyYXNoPw0KDQpPYnNlcnZpbmcgY3Jhc2ggbGlrZSBiZWxv
dw0KVS1Cb290IDIwMjUuMDEgKE1heSAyMiAyMDI1IC0gMTI6MzI6MDEgKzAwMDApDQpDUFU6ICAg
WnlucU1QDQpTaWxpY29uOiB2Mw0KQ2hpcDogIHhjazI0DQpNb2RlbDogWnlucU1QIFNDIEsyNCBS
ZXZBDQpCb2FyZDogWGlsaW54IFp5bnFNUA0KRFJBTTogIDIgR2lCDQppbml0Y2FsbCBmYWlsZWQg
YXQgY2FsbCAwMDAwMDAwMDA4MDM3MzY0IChlcnI9LTIyKQ0KIyMjIEVSUk9SICMjIyBQbGVhc2Ug
UkVTRVQgdGhlIGJvYXJkICMjIw0KDQoNCj4NCj4gPiB0cmVlIGFzIHBlciB0aGUgRFQgYmluZGlu
Z3MuIFRoZSBpc3N1ZSBpcyB3aXRoIHRoZSBjaGlsZCBub2RlIG9mDQo+ID4gaTJjLWFyYml0cmF0
b3JANzIgaS5lLiwgaTJjQGYxOTUwMDAwLT5pMmMtYXJiaXRyYXRvckA3Mi0+aTJjLWFyYiwgYXMN
Cj4gPiB0aGUgYXJiaXRyYXRvciB1c2VzIHRoZSB1Y2xhc3Mgb2YgbXV4KFVDTEFTU19JMkNfTVVY
KSBhbmQgdGhlIG11eA0KPiA+IHVjbGFzcyBkcml2ZXIgY2hlY2tzIGZvciB0aGUgInJlZyIgcHJv
cGVydHkgdXNpbmcgdGhlDQo+ID4gaTJjX211eF9jaGlsZF9wb3N0X2JpbmQoKSBmdW5jdGlvbiwg
aWYgaXQgd29uJ3QgZmluZCB0aGUgInJlZyINCj4gPiBwcm9wZXJ0eSBpdCB3aWxsIHJldHVybiAt
RUlOVkFMIHdoaWNoIGlzIGxlYWRpbmcgdG8gdGhlIGNyYXNoLg0KPiA+IFNvLCBhZGQgdGhlIGxv
Z2ljIHRvIGNoZWNrIHdoZXRoZXIgdGhlICBjaGlsZCBub2RlIGhhcyB0aGUgInJlZyINCj4gPiBw
cm9wZXJ0eSwgaWYgdGhlICJyZWciIHByb3BlcnR5IGV4aXN0cyB0aGVuIHJlYWQgdGhlICJyZWci
IGFuZCB1cGRhdGUgdGhlIGNoYW5uZWwuDQo+ID4NCj4gPiBodHRwczovL3d3dy5rZXJuZWwub3Jn
L2RvYy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hDQo+ID4gcmIu
dHh0DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZl
bmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pMmMvbXV4
ZXMvaTJjLW11eC11Y2xhc3MuYyB8IDExICsrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtdWNsYXNzLmMNCj4gPiBiL2RyaXZlcnMvaTJjL211
eGVzL2kyYy1tdXgtdWNsYXNzLmMNCj4gPiBpbmRleCBkMTk5OWQyMWZlYi4uYjE4OTk5YzFmZTMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC11Y2xhc3MuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtdWNsYXNzLmMNCj4gPiBAQCAtNDAsMTEg
KzQwLDE0IEBAIHN0YXRpYyBpbnQgaTJjX211eF9jaGlsZF9wb3N0X2JpbmQoc3RydWN0IHVkZXZp
Y2UgKmRldikNCj4gPiAgICAgc3RydWN0IGkyY19tdXhfYnVzICpwbGF0ID0gZGV2X2dldF9wYXJl
bnRfcGxhdChkZXYpOw0KPiA+ICAgICBpbnQgY2hhbm5lbDsNCj4gPg0KPiA+IC0gICBjaGFubmVs
ID0gZGV2X3JlYWRfdTMyX2RlZmF1bHQoZGV2LCAicmVnIiwgLTEpOw0KPg0KPiBTaG91bGRuO3Qg
dGhpcyBmdW5jdGlvbiByZXR1cm4gLTEgKHRoZSBkZWZhdWx0IHZhbHVlKSwgaWYgcHJvcGVydHkg
InJlZyIgaXMgbm90IHByZXNlbnQ/DQo+IChBbmQgYWxzbyBpZiBkZXZfb2Zub2RlKGRldikgaXMg
bm90IHZhbGlkPykNCj4NCj4gU2VlbXMgd2Ugc2hvdWxkIGxvb2sgaW50byB0aGlzIGZ1bmN0aW9u
IGFuZCBtYXkgZml4IHRoZSBwcm9ibGVtIHRoZXJlPw0KPg0KPiBBaGEsIHRoaXMgY29tZXMgZnJv
bQ0KPg0KPiBkcml2ZXJzL2NvcmUvcmVhZC5jDQo+IGludCBkZXZfcmVhZF91MzJfZGVmYXVsdChj
b25zdCBzdHJ1Y3QgdWRldmljZSAqZGV2LCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQgZGVmKQ0KPiB7DQo+ICAgICAgICAgIHJldHVybiBvZm5v
ZGVfcmVhZF91MzJfZGVmYXVsdChkZXZfb2Zub2RlKGRldiksIHByb3BuYW1lLCBkZWYpOyB9DQo+
DQo+IHdpdGggZHJpdmVycy9jb3JlL29mbm9kZS5jDQo+IHUzMiBvZm5vZGVfcmVhZF91MzJfZGVm
YXVsdChvZm5vZGUgbm9kZSwgY29uc3QgY2hhciAqcHJvcG5hbWUsIHUzMiBkZWYpIHsNCj4gICAg
ICAgICAgYXNzZXJ0KG9mbm9kZV92YWxpZChub2RlKSk7DQo+ICAgICAgICAgIG9mbm9kZV9yZWFk
X3UzMl9pbmRleChub2RlLCBwcm9wbmFtZSwgMCwgJmRlZik7DQo+DQo+ICAgICAgICAgIHJldHVy
biBkZWY7DQo+IH0NCj4NCj4gYWRkZWQgU2ltb24uDQo+DQo+IEBTaW1vbjogbWF5IHByb3BlciBm
aXggd291bGQgYmUgdG8gY2hlY2sgaW4gb2Zub2RlX3JlYWRfdTMyX2RlZmF1bHQoKQ0KPiAgICAg
ICAgICBpZiBwcm9wbmFtZSBleGlzdHMsIGFuZCBpZiBub3QgcmV0dXJuIGRlZmF1bHQgdmFsdWU/
DQo+ICAgICAgICAgIE1heSBhbHNvIHJldHVybiB3aXRoIGRlZmF1bHQgdmFsdWUgaWYgbm9kZSBp
cyBub3QgdmFsaWQ/DQo+DQo+ICAgICAgICAgIFdoYXQgZG8geW91IHRoaW5rPw0KPg0KPiAgICAg
ICAgICBUaGFua3MhDQo+DQo+DQo+ID4gLSAgIGlmIChjaGFubmVsIDwgMCkNCj4gPiAtICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAtICAgcGxhdC0+Y2hhbm5lbCA9IGNoYW5uZWw7DQo+
ID4gKyAgIG9mbm9kZSBub2RlID0gZGV2X29mbm9kZShkZXYpOw0KPiA+DQo+ID4gKyAgIGlmIChv
Zm5vZGVfaGFzX3Byb3BlcnR5KG5vZGUsICJyZWciKSkgew0KPg0KPiBJZiB3ZSBmaXggaXQgaW4g
dGhpcyBjb2RlLCB5b3UgY2FuIGhlcmUgc2ltcGx5IHJldHVybiBpbW1lZGlhdGVseSBpZiAicmVn
IiBwcm9wZXJ0eWlzDQo+IG1pc3NpbmcsIHNvIHlvdSBjYW4gc2F2ZSB0aGUgaWRlbnRhdGlvbiBs
ZXZlbCwgYW5kIHBhdGNoIGxvb2tzIGNsZWFuZXIuDQo+DQo+ID4gKyAgICAgICAgICAgY2hhbm5l
bCA9IGRldl9yZWFkX3UzMl9kZWZhdWx0KGRldiwgInJlZyIsIC0xKTsNCj4gPiArICAgICAgICAg
ICBpZiAoY2hhbm5lbCA8IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4gPiArICAgICAgICAgICBwbGF0LT5jaGFubmVsID0gY2hhbm5lbDsNCj4gPiArICAgfQ0K
PiA+ICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+DQo+DQo+IFRoYW5rcyENCg0KVGhh
bmtzDQpWZW5rYXRlc2gNCj4NCj4gYnllLA0KPiBIZWlrbw0KPiAtLQ0KPiBERU5YIFNvZnR3YXJl
IEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWthIFVudGVyDQo+
IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVu
emVsbCwgR2VybWFueQ0KPiBQaG9uZTogKzQ5LTgxNDItNjY5ODktNTIgICBGYXg6ICs0OS04MTQy
LTY2OTg5LTgwICAgRW1haWw6IGhzQGRlbnguZGUNCg==
