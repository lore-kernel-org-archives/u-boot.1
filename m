Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03395CF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABD888641;
	Mon, 30 Sep 2024 07:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4eiMw/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C6F88975; Mon, 30 Sep 2024 07:07:23 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CAE88641
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2H6/VTkrG6E/pB1y7vI8ge3VGSFHrNJPFtM4iWb/wrwbNqUshYxvE2uiOTjG1SrcPJFMKgZd3fFrbKBFvkRZwfSEq5XiGB3iOSrKUGpdaj5Bt/XRpjKlPfmNc/ePdWFNQrWjwACFzwqPJLPFASCic17hI12DovV8YA5JbuNLipCT9vTtYrC/WnpB05Syj84tCjd6HQgbSicKMSTRrb/i9NA7uRUE+GJkBJlF3jwjAp3Z/cbNDr1SjDF235vy7BXKB99WqpeKdtuu7reKlR5206kJCEc34LoHQyPs812X9Q7j9vH5Rw5bScXDI71fSBy0Nu9c9dZXb5Qp2EG23GKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9Wh+z77INUJzYciDnuCHgImVM2yEuut8ikiZNSefOs=;
 b=Yut98TNvW/C34OQZC5+sxqUQ9mdJBRUXiCDccJkbUK3XXvObAQPnUQiNCD3Z/bKVKHGqUmM1j6saY6Mue2I5Aox09j2XyaaffqRTyqOtAKAEF+ldc4fPSA6x0g9/WNQK33rVr5ZN9IaV0ipIZnQA//4Zt+RxRqmigfnVHTgUIrMwTv63KcbNpTg+WlkTGZ2u+fjyYGhzqs2kf5Gcg+/qO+3UAI+zaho6DKv+ThenYUI9wOgtqWTNmtQ6QcrgBivK8Rf+v+hu5z39E4DUGxNKM+lu1HnSjJmeo2YwCNC4r99iqdBnmCPnlRcbBs2L5EVE3nY/MY+RfjkJibRd8m0CLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9Wh+z77INUJzYciDnuCHgImVM2yEuut8ikiZNSefOs=;
 b=P4eiMw/Opf9ud5y8dTCSS1sCfABKj6gORQ4Of87mvgmEIUcCsbenJXQ4SiPg2iZ+XTzJ6IJ6ZA5A29DQyg4UAARtj79THgJN19XTzRixj1r3DEfckL4XpJJeuQ/gZD9risSAs+/nr7DY/09+BWn/ZeVW3PqgunkfH5XBTY+4mHQ=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:07:15 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 05:07:15 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v2 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbEKskBzge3Uzx8k6BKhZYfSLcJbJsGCMAgAOy2CA=
Date: Mon, 30 Sep 2024 05:07:15 +0000
Message-ID: <SA1PR12MB8697A7F6C5851DA65B6EED2398762@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-2-venkatesh.abbarapu@amd.com>
 <b03e60f9-dcdd-48ef-9b5d-ac75b0f3dda8@denx.de>
In-Reply-To: <b03e60f9-dcdd-48ef-9b5d-ac75b0f3dda8@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SA3PR12MB9180:EE_
x-ms-office365-filtering-correlation-id: 26622c0f-d141-43f6-3194-08dce10dc04a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlB4Y0NHMkxxcGlKaFRXa3hqRlZwNU5rR3NKUi9uN0ZMbWxuaGZjSkNjeCsr?=
 =?utf-8?B?aU1IQnJNcnVTM3pHMGpYOHd1SmFhTEZBVklaeFJDb3E1QStLYXJTWGVIellz?=
 =?utf-8?B?SE84TEdxY01MTk5KcFpXK1dWcTZTZGZiN0VleHprMis3QldlcmFXdDlURmRP?=
 =?utf-8?B?djVjMHRWVGVtN3NyWDZqYnBOUkVFeFN4V3I1VTBJalcwMzNnc0RvTEdWdEJ5?=
 =?utf-8?B?L3V5QXowT0VrYy9Ed25Fd3pUWDlJMDZ2NDdGQ3d6Ri9iT21uUHN4MEpQbkF3?=
 =?utf-8?B?VmtXOGdNL1VNbTE5QndwT2ExSHNheElrUEVqcy9lUXlOb3c0cmJ3ekpGMDJy?=
 =?utf-8?B?OGRuRVZ3UTVlamhDWHlmTkhyMHVScFcxdno5M2RyMlNSYXRwamVsM0VyM1dE?=
 =?utf-8?B?dS91ZE9WcFJ1UFNVUGhZNmVwb2dtZmJ0Tlc1RVF3K0pHTFE2M0RBVUVVRWEw?=
 =?utf-8?B?QTdZK0ZzOXhmamNzd1RWWlIzS0FXcUxzSXQvVXpTMzNBN1JDaStOZTAyQ0l1?=
 =?utf-8?B?dWNrN0RDRDdDZTNubHg1MjFtd0RhSmhDZmgvZ2ZHeTlQTndqZW5zYlI2VWtp?=
 =?utf-8?B?UjRSZHJUQ0hEQ0w5SWlOWnFIeDJieHRpcWNwNTBhZTFramlGM2xHSmdmSzQ1?=
 =?utf-8?B?ZWNoenVsRStYNGd1eWxxOHcrQXovUnBXeHRsd1JaWFdGNHcwUHBMOW5jMG14?=
 =?utf-8?B?MWwrek9ycll4SzFBL08zWFJZR0xHKzJqZ3NYeHR1OVJKK2pQbGRINEd1SjhD?=
 =?utf-8?B?bE1RejVTUVEyUm1vRlRjdHBJcnJiSXlOY1JraTVvZnVpUVgxVW1lRVkvY3Nh?=
 =?utf-8?B?ZnJPTStybW5HRDRXcjluVStUREhTMDh6cGdlYVhwRjdTSVV0RDhhcGpwaUE3?=
 =?utf-8?B?V0xzY0poN28ydEdmTnh0ZzFKUWYyVjdabnZ2dFVnK255TGw5dU0wNGtKOFI4?=
 =?utf-8?B?bVlnRFJPVHlGODJCeFBxSnFXcS8zWHgyWWRoSGN6dW9YTzhjVXVJd25wQVhi?=
 =?utf-8?B?TlByVDFWMXdsR2g3YXp0dUZoZkJmZmJzMUJnSVUwaHE3aVVpMWdZRVlMSDd2?=
 =?utf-8?B?SnFGU0pXOFhCUHJGSk5jb3ZLRzY3ZkJCbjZVcjlNZDNVcUlsNERnSkx2cmJB?=
 =?utf-8?B?NzIzcVJvZUJEK2xkTi9qZ3l1MjIzZFhOaTVURkNDRDJPd1k5MkFoVFFxSDZ2?=
 =?utf-8?B?OVdQMnBjQ1hWTUY2dTBVR3J6UWsrcy9OYUlScGgrbEVpcEYyUEd2R2R6RVVF?=
 =?utf-8?B?Rk8yeHJWS1g4RWZQS1BPWFo3dVNpRUg0THBVUlZGNkxOdkg3cVJMTmZMWTg1?=
 =?utf-8?B?d1V2UzJlN3g4VFVkVEF0RElqL1FnMEkzMURRYmMxWDN4M0MvYlRTdEtoRWVZ?=
 =?utf-8?B?N0Y5ZGpRR29tWWlMZnhkZlNRUS9teGgzK1BGMXlnWmxLSFoxemRpSXlPSlI4?=
 =?utf-8?B?UnYvaEh0dlhZd1FSaENJTzNBSDU4NjdQZ2M2ZTkxaGxicGhMR1dCSm8xbWcr?=
 =?utf-8?B?QW00YkpoaG9uK3NqcUdoanl4eHMyYUs2TkdKYnRDZ0xqL1A5M2V0bDJyQ3Bl?=
 =?utf-8?B?VnBveXlpbGJMQ1dCOVpBTUJFUXRvRE9oMFpkR0NYdFNpU203RDdjQVM0NzVF?=
 =?utf-8?B?cllxdDF2NjFaNncrdjBqbjFhazJheDJxYzhNQ2d0dWp2NTZMellCY2d5UUIz?=
 =?utf-8?B?QUhaRm9RUEhhOGd0UnQ3dEpxeXpoWTNnVEp1OGhrejFJWDk1V24zNk1yemFr?=
 =?utf-8?B?NWdycUs4VStpWWg4eENuOVl6QTJwU0tnSDBvSzRBTlM4ZUJwb0JNQlEyUklN?=
 =?utf-8?B?N2NLVlNyTUp4aGNPeEFyL2UxcmpjMkIxM1NvM3cwSHRQTGJKTW5SRlVSTUhl?=
 =?utf-8?B?TEY1UytjalNjVWN6NTBOeVJFVkRqSGJJOERKM25vSWFaV0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDYxTFRJK2xvTUllTythS3V0ekdBaWp0aC9iNWJHcXl2WmFHaERROWdjQkJv?=
 =?utf-8?B?TktwRGpKVVd4ckpEUWxKUTdEeTJzWDR1RTAvVjNZODBleVd0ZUZKSmg0Rzk5?=
 =?utf-8?B?NnNqTEdvQkNSZkVIMko4SmJ4Wm5OVWJNQy9pcDhwMEFYS1JFejN6bnU5T2hN?=
 =?utf-8?B?MGVIeTdqU0tWV09nQWFtZFZhS0ZCeUhldUJ2djVQZ043cFYydUcyenVEQVkw?=
 =?utf-8?B?Vnh1MDV2QksyZ21tM0hUd0dJOXlaazJxOGZrOFZXWXVudGp1UmFUQitHZGUy?=
 =?utf-8?B?bGlwZmZ6UWF5eXQreWJ4d0lrQkFEbDBCbFhnWnd2WmV4K0dKZTY2R0gwQThM?=
 =?utf-8?B?anp2a3lIZ0tEZmg4aGtiempFZzNjaGJnUWt0U0hXOVQwdjB1TmpXRWFXQlEy?=
 =?utf-8?B?QTRyY3hiK2xjb1Z0UHhsOEh4TXlQd2VYd3VFYmVQYnQ2WnEvemhkSHFhLzRY?=
 =?utf-8?B?a0g4czZIODJ3UjIzTWdBVzdWZWFOV2l1a2JKRDR1WjVtL0VJaTFTLzczb0E0?=
 =?utf-8?B?NkhCY0hmVnRJcWhiWCtiS3Q1UEs5d3JPbXIyN05uaTBrYWNDMkJkSy9taGJL?=
 =?utf-8?B?UXl5TEdDaXZZOFVuMmVPZHFZdFpHZ0pueUZ5VWJwRmxCUE85TVluN3ljOWVY?=
 =?utf-8?B?YWIwbEdHLzVFenBqMHVNS1Vya2gvY05lNEpHdTdqZmpjQmpDQ1lOK2x3L1l0?=
 =?utf-8?B?RjRTaU8yc1ZOTGY1K0pzWEkzRTAraUNkN2Y3dUZIOUg3NUp4QkJpNitVUXNW?=
 =?utf-8?B?dmxENyt0TEpIL0wwUW5oRGRtRjBOcHJHeUtPMllaRVNVeVBaTEtNaWl2R0gy?=
 =?utf-8?B?T1lTNnZiTkdBc0ErL1AvWS9lSjdQVEVleURzbmhSQXZTTEI1RVFQUFBZQ3cx?=
 =?utf-8?B?aWZlYWNyTUlWU290WlFmU1l1dWxHb3dGYmlHQmxObzZtR0ZVRC9ZeDA3L1RV?=
 =?utf-8?B?ZWJ1d2NFa1dQbUNlb1dRRitxZ21jQ0VVZENkU2VQRjJpdU1MTWtXcEZ4dGpF?=
 =?utf-8?B?Y2hSNlc4eHdIN2w5KzdML2JkaUJMVXpXcnU3Mk9WME13N2s0Y2JYcUJvRERN?=
 =?utf-8?B?OWtucXhhbHRVL0lRb0dHOUxtTE5WMzFSb21nZ21VeUNWUW9XS1M0aitRLy8r?=
 =?utf-8?B?d2hBUzQ0MmVGbkRrZ1BaTkxMTk93UXB5K0NwKzh2d1ZkYVNrS1U2Rm40KzEw?=
 =?utf-8?B?WjF0ZkUvU2taOHBwR1BEYVdvWVBIWjB1d0xBSGJuLytTaDRob2EyY0l5a3pp?=
 =?utf-8?B?Z0p1RExabndHalFzMDlMdG56MjFSdytMbENnT2NWZk5adzVtT2VUK3BuSnlz?=
 =?utf-8?B?cmZSSkdoc3prWmJ3VE8xMldBd3daY1pQL0hjTERzdnhlOTA1VnVpV3E3NUox?=
 =?utf-8?B?S2lUMnRWL2kvKzRqSE02b1I5NnFSTkw0UXpuTzZ2dlNwaUhBR0NmUm1VeW5U?=
 =?utf-8?B?UUtPZzVQV1VaZGh5N1VaUkw0MmF3c0xTK3ZVc1ByWS9LMTRlekx5c24rVGNy?=
 =?utf-8?B?SUhBdHkxR0dodEhTY3B4UkNpRGY5KzdXN2NUYlpxOFBKT202enA4MWE0TUxU?=
 =?utf-8?B?N1JUNFB4R3E3ZDBxK0JrMjBHSC9HajFrNzJPV3lNU2pQTVo3VU5qZjdFTTJP?=
 =?utf-8?B?KzBuY0xnc1dMK0t1TjdjeDJBMGJnWXB1WUZ4WVh3MG1OTldtcGtHN0laTSt5?=
 =?utf-8?B?UmFRNURJSnVEWDVLMDlYb25hVkd4eXJMa0hDRklFTUVrYmtsdGNWMDlNV0Nr?=
 =?utf-8?B?L1pxak9vS0t3d2lrTFpydThOc3RyS0VxOFBTdUZ4Wm5qdmFlSjhGU3FjbkVT?=
 =?utf-8?B?UVJDVUlIMG5EOU5KdlA3dGVGL29xcmRac0ZjcXl1SlRIZVhSRzloL1FuUUx6?=
 =?utf-8?B?TGptOUFyZjVzMm1ZSHRRbW9PTUpjeEs5bkdUN1N3ZS9YaEFZc05EVC9adklG?=
 =?utf-8?B?KzFtcitzR3FBT28yYU0xTW9DN2dqZ2Vmek0rU1V6aThLeTRoSHFaczBGOU5U?=
 =?utf-8?B?NlI3bXMrNHg0UzJNdFBxMC9VckxHeGVrRmR6UjdVeW1TVDR5aTR1MHd3NHNZ?=
 =?utf-8?B?d0lqQ0p4Q3NGT0hPcVhqVUFjbjBNbkdzMmVsNGVmNEJOaXdpV1FsaUNOcVhE?=
 =?utf-8?Q?i/io=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26622c0f-d141-43f6-3194-08dce10dc04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 05:07:15.6500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZX/34qxRzy1kcbKkuH3qhkvSjoqJ3L4w/WpRefCFfIi9zlNUq91Z7l48hU0YTzR7K75PZO/Cz91V8ezTabteHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
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
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjgsIDIw
MjQgMjowNSBBTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1
QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvN10g
dXNiOiBvbmJvYXJkLWh1YjogQWRkIHJlc2V0LWdwaW8gc3VwcG9ydA0KPiANCj4gT24gOS8yNy8y
NCA5OjAxIEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0K
PiANCj4gPiBAQCAtMzAsNyArNDAsMjQgQEAgc3RhdGljIGludCB1c2Jfb25ib2FyZF9odWJfcHJv
YmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgIAlpZiAocmV0KQ0KPiA+ICAgCQlkZXZfZXJy
KGRldiwgImNhbid0IGVuYWJsZSB2ZGQtc3VwcGx5OiAlZFxuIiwgcmV0KTsNCj4gPg0KPiA+IC0J
cmV0dXJuIHJldDsNCj4gPiArCWh1Yi0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsKGRldiwgInJlc2V0IiwNCj4gPiArCQkJCQkJICBHUElPRF9JU19PVVQgfA0KPiBHUElPRF9B
Q1RJVkVfTE9XKTsNCj4gPiArCS8qIHByb3BlcnR5IGlzIG9wdGlvbmFsLCBkb24ndCByZXR1cm4g
ZXJyb3IhICovDQo+ID4gKwlpZiAoaHViLT5yZXNldF9ncGlvKSB7DQo+ID4gKwkJcmV0ID0gZG1f
Z3Bpb19zZXRfdmFsdWUoaHViLT5yZXNldF9ncGlvLCAxKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+
ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCQl1ZGVsYXkoZGF0YS0+cmVzZXRfdXMpOw0K
PiANCj4gV2hlcmUgaXMgdGhpcyBhc3NpZ25lZCA/DQoNClRoaXMgaXMgYXNzaWduZWQgaW4gdGhp
cyBwYXRjaCBodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAyNDA5MjcwNzAxMzcuMjE4
MTYtNC12ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbS8NCg0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b25ib2FyZF9odWJfZGF0YSB1c2I1NzQ0X2RhdGEgPSB7DQorCS5yZXNldF91cyA9IDEwMDAwLA0K
KwkucG93ZXJfb25fZGVsYXlfdXMgPSAxMDAwMCwNCit9Ow0KDQoNCj4gDQo+ID4gKw0KPiA+ICsJ
CXJldCA9IGRtX2dwaW9fc2V0X3ZhbHVlKGh1Yi0+cmVzZXRfZ3BpbywgMCk7DQo+ID4gKwkJaWYg
KHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJdWRlbGF5KGRhdGEtPnBv
d2VyX29uX2RlbGF5X3VzKTsNCj4gPiArCX0NCj4gDQo+IElzIHRoZSByZXNldCBhc3NlcnRlZCB0
aW1lIGFuZCBwb3N0LXJlc2V0IHRpbWUgaWRlbnRpY2FsIGZvciBhbGwgVVNCIEhVQnMgPyBJIGRv
bid0DQo+IHRoaW5rIGl0IGlzLg0KDQpZZXMuLi5pdCB3b24ndCBiZSB0aGUgc2FtZSBmb3IgYWxs
IHRoZSBVU0IgSFVCcywgYXMgaXQgbmVlZHMgdG8gYmUgdXBkYXRlZCBpbiB0aGUgb25ib2FyZF9o
dWJfZGF0YSBzdHJ1Y3R1cmUgYXMgDQoNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9uYm9hcmRfaHVi
X2RhdGEgdXNiNTc0NF9kYXRhID0gew0KKwkucmVzZXRfdXMgPSAxMDAwMCwNCisJLnBvd2VyX29u
X2RlbGF5X3VzID0gMTAwMDAsDQorfTsNCg0KDQpUaGFua3MNClZlbmthdGVzaA0KPiANCj4gPiAr
CXJldHVybiAwOw0KPiA+ICAgfQ0KPiBbLi4uXQ0K
