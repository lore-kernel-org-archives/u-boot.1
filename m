Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA8CCA5FA0
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB4083B21;
	Tue, 20 Jan 2026 17:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="NJKtFtjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C0B83B0B; Tue, 20 Jan 2026 15:56:36 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D176983B22
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxhoOALJCXZaKLrOSp6kSxiL0+DcUfIcYHoMRJQOQwfMsykiEjrpQAhYUGbTQDcJ1nAg6/bTsWGDObuc9D/avZMF3oYHqonczUICAcFSpIgP19EG/Btov3S+sqYvTHhqz0M16Tk27KQVtEoLUgLgCSu8/9frmC8KDmoYzoBcfF/bi+zPqFiYeguc8/sL/VV3F2uLhAWzE2/m97oOIzIn74owK5JJkv+t2NbkexL0RJjfgBFFxHER164qUFjeVmsLIyPozy1ku6N5vLNPZovKgo3Kigs5ySmeKLuA9+XN4Bro/Z2xXaCapAqxTUAXTgUH62b9iTHgNlCll/UbF9HRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5ES+Zb0NYNvoegIIx/Fg28i8x6CbrLCNlQP9EjCnhA=;
 b=Pio8cW1WP7X3pF/utlEsvl6Yrs2jiZCS5WGTLDDLQR0VEAN3RoN9M+ocxaAfQ6p5L0BbIcmcw/p3XVGH68lNdKbzL1GE/MH7ReYzjhb1DACUnXh25KdFm470CKvc/nqfikhuZbscdzWRQVMgf1nV9C1tk5ssAdhD1atyctUmjjMEul5WLItZUgLHSEyX3x/D5cvTglKtsrNGzfiqAIxQP0KNG2VNzVU8QmtlH/4pgMP5uKSofXztt6O74d1Ynsty41bGymhXcK7NDJQ2YjKcwEKLD/FKByuvUU0B/3PuDSZ3vihT/ZmT4qayPv5YIeKasstslvlRcvddCInpJsad8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5ES+Zb0NYNvoegIIx/Fg28i8x6CbrLCNlQP9EjCnhA=;
 b=NJKtFtjcU2v2rOfnCqOA8S6YJnC39hzStdRc44hk4j0b9Gn9VJMUFGuhraoIShGrdGDy8Vfm9kuihS+OZ618yRicOPWqOJwXIpRMBXHxo0vwHhJXq2msTh+xRmZ1HTVZqTT+FZbo79pAMdTu+/hrbBtf4tSO5+7AAdDHSj0Tjwn5JLHQw9st3Vqe5ojR6mPwhQCMFza2CNMVhPLoqyVlZF/hYXo6b9Q1cdKZ6+7a7zT1TNLsAN4EcHlDx3UonX7cUIHLe0vbSBvcVB6D8wxCFT6VSSeAf9jfbBZsMnBOzP2TsKUHcSuVc//ovKvButlVeQE7D8aCFAQzb21d9HGtMQ==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 PH8PR11MB8288.namprd11.prod.outlook.com (2603:10b6:510:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:56:30 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 14:56:29 +0000
From: <Jamie.Gibbons@microchip.com>
To: <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Topic: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Index: AQHchwFkjqXL5NuND0+6jEwP8Ex5sLVU+B6AgAAFeICABMM6AIAAKjaAgAD8CgCAAAJ4AIAAMgMAgAAJuICAAAZWAP///2MAgAACR4A=
Date: Tue, 20 Jan 2026 14:56:29 +0000
Message-ID: <6a48db81abdeb6e6620d9b7afcb25a03ee4aa97a.camel@microchip.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
 <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
 <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
 <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
 <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
 <856f8b6cdbc2311ac535d9b03c6e2d21a859c526.camel@microchip.com>
 <d6ea8e7c-1fc4-4f05-8a6b-805c0be12f4c@mailbox.org>
 <f6e27291ecd42a2563034250ac0016c75b61d35c.camel@microchip.com>
 <c225d39c-837a-4b5a-b836-5f12c1cc686f@mailbox.org>
In-Reply-To: <c225d39c-837a-4b5a-b836-5f12c1cc686f@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|PH8PR11MB8288:EE_
x-ms-office365-filtering-correlation-id: e1f697f1-bdba-4e55-5c91-08de583417ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RXc3end2eVhUVWxxK2Z5d0tDMnZrRlhEbEdrV2x0TUpvTzRGUjdGNFk3d0FN?=
 =?utf-8?B?ZXJZNnBDM3drRUlHU3dnbE1wMHFlMjBpWTF2S3NNejdSVi9FYmtqcjc3T2U3?=
 =?utf-8?B?S29EaldyME5iUExXTFM4dm0rUStVcWZ0QWJGVTViYU1xWjhnRHludU5NRHVq?=
 =?utf-8?B?TkgwT2x1YlhIL2ZjQ0xERUVNQ3BwNzJBSTNYWTkwQXYwSzFubVdVaWtQSzFG?=
 =?utf-8?B?OFI1bzdqaTU4cnJNakJCODgvVHlOb0FzNnJmNkRzUFBqVmxyT09BN1RSV2th?=
 =?utf-8?B?UGVnd0hMUGt1YldubzFMQkZzNUpsZ3ZKNnVsZkt4bGV1bzErSHdLZ0REcW1v?=
 =?utf-8?B?Z2ZrUlMvOEplZjZkRkNGNWlyU2VYWXg2d2J2VkFQRmpvR2xxaUxTbmY2ZXF0?=
 =?utf-8?B?NDVOVUJhQWF4UncvcmNQa0dYSHBpUVIvOTZPdVcySmh0NU1DbE5yUGNwZkQ4?=
 =?utf-8?B?UjVrc21tanF1TWg3NGVrVkNhRDFyaXY0REZRUkg5RUsza3RwdlhNVVI5bXNB?=
 =?utf-8?B?VkRkK1AvcWZzRzNwL3hzSFN3aXYzT3o3bkVRUTJZdnhoTU84ZlZkTFRJWGpx?=
 =?utf-8?B?eGFYMEZKZGdQdEZHbXVxSFdZdEpFRXlkUUpEcFhtOFRLV0QvRCs1RithdEVh?=
 =?utf-8?B?QTFHVWQvODNDS0RUQVpQYmplZHBhVGJRRThQTmhoUVlLaDRkMlptTFRFNmlO?=
 =?utf-8?B?dHVEaTVMeTB3NHd1blhvZE5VYmRtZDNqeUxrZHU5cmFSMHlZYzRnRldtZm4x?=
 =?utf-8?B?a01VTDdzR1diYlJzNFVVTlF3Uk1QSUFYUzZWeElXcnpnSkprOGxuZGJOR05V?=
 =?utf-8?B?aVBTeEJXSGhFOCtXTGFlSzliS0FBNDVnV29Hay9IY2NiaFdvYlZ1TUxHQld0?=
 =?utf-8?B?dnlkRjlTV24vZWJXTDRHSjhLODFqSDZQWXd4TDg2T3g4Q28xemFYSFdZRGNO?=
 =?utf-8?B?b0x6N0ZOSnRCZlE0Z1E2UElIQ3EzeWx1Q3c2ZGNQMXp2SXdHaHdyT0plRnZQ?=
 =?utf-8?B?dVo2MDBCZUlwbGc1NHRUQmMyRGc4WnFHYk5mQ0pOcVBoTVI4azUxWTZsQUdS?=
 =?utf-8?B?ZWNYaXpxV0hQdERFMDRlL3luN3hobWV0K1g3ZThjWmdVQ3RlbGVCamEzVlBZ?=
 =?utf-8?B?aVpWTUhIUWFyVjdjNUlPWkJ0QW9uWk5TT3NyM3dyZmZZTmtYcmU0ZnQ4U0po?=
 =?utf-8?B?QjNsTmlKTVd3VFJHaU9IWWVpdG41RmhFY0tvQzN4OGE4UEpYczd0ZkJYd3BN?=
 =?utf-8?B?enp1S005QW5WZHBiUzhlZXlNaGpINWZTMVE5YXNDZE5Sd3ZEKzBjMzBoRmlp?=
 =?utf-8?B?L0hXdzBER3V6QlEzbXRyVWhTRVR1SlRjaFRGODNyalA5V2l3V3Q3VW1lQWdr?=
 =?utf-8?B?NUV0VXN0NFJXNlltdGlGWU5zZVJITlBpR0o5REtyV0ZBdWtmbVByR1pVS3BK?=
 =?utf-8?B?RFFsamYxeHpzY1RJaTJSZGdEOHpsOGJZa29JZGdIM3c1RUMxTjJiYW5XdXAv?=
 =?utf-8?B?SVpNZ3JVL1BtUmtFNXRMeCt4dVhWTU5NS3FsM3dVSzhyZTRoeko5K1FHZDVO?=
 =?utf-8?B?aDFFWWhscU5mSDNUK1B2bSt4S0hGa2hrajlRMElaOFV2NnRackVWazhmM2ZG?=
 =?utf-8?B?bXYyT0ozVUJ6cXV5Q3AveFRPcEYxRDdYbXBXdXZFM2xUNllWQklJMlJGOW90?=
 =?utf-8?B?YWJFbW5acW5FRkgrNXE5U0VuRmszeTVxMzJNODVSczY4eGxsaDVZL0VlNEs4?=
 =?utf-8?B?Ti8rTkVXcUpxbXhNV3l4dmtMM1FjTkswSGlyK1NxT0ptcS9qMFp3VERtRVNX?=
 =?utf-8?B?cEt1WExheTNDSVU0Vi9jU2V5T0h5NnVWemc2WExlTlExbWFaVjJKNEVUWXJj?=
 =?utf-8?B?Q1dJdzdTU0ZoSUkxZlBrdVE2MHFINGxEcXlOSk9Vc1lEQ3pINWtKY2kxaHpt?=
 =?utf-8?B?RkhMMGhvOFZocmYveHFVckRKeVNEQTVnZEJmUTVBWnFPZXJxL1JiZUtOeDhp?=
 =?utf-8?B?Q0dPS0NNUFhRVGZXZXFXQXVKTkFmSnNJc0FuUnNhOWxKSSsrVTc3YjJQNjV5?=
 =?utf-8?B?MUlZenJaWmk1enVoWjZkelYyN3pYQlZSbnFsYnJqSjU3eDBkZjdPcHJXSm1z?=
 =?utf-8?B?ZmlHTTBMOGJWWkJRbTBZelNEZlhjZDdEZU5kQU5jaW8rTWo4VU5qb1kzZE91?=
 =?utf-8?Q?/W98OhQ/or7zg4dEB8/zLe0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHR2dTZuci9hL0RYUnJyNkZVYnpJNzRsZ1R0TTJ3OHpORDAxM3pkaCtRM25P?=
 =?utf-8?B?b1dMN2dFaGtVdFMyRnVvRDZPdUlyaGV1Q2pNVHB2YXpQRDFsRkxXVFZJRWcw?=
 =?utf-8?B?UHZnaWhvZmYxNXR5YjY1eVFpMHNud2N1b0d0WFgya2kreWREYVpKcUYxNndT?=
 =?utf-8?B?QTJ0ZFQwakluVGt3Rjk4VG1TbTNBYnpCNVhWV1h3TWFGa3YyVWh6ZzhIMGEr?=
 =?utf-8?B?Z2VQeWRHRGFiZFRsanprK1V2anZYLytWeHZiVDA3cDJaNkxEZXdyQXdHS2Z4?=
 =?utf-8?B?S0JxcEIrTnVMWVVkekx3KzhESzdqTkhRWUt1Y1VGVWtLUmRIaWY4TnoveXls?=
 =?utf-8?B?cXFtbm91amRuWlBhbmtvd0xaeG11Y1RocVFoYmdFVXN3NHVidm05NGVjc01Q?=
 =?utf-8?B?dWE2SGhKalFldzZzZjY0Q3JtQThGNTdBbVBwK0w2OW9xWTNTdlpLVTJpVm8w?=
 =?utf-8?B?ZHJLenN2QkZ1Z3RyZ3dyTWpmaDRkdDhTWU5pV0ZZOGI1bnJXR1hZaVhTQndS?=
 =?utf-8?B?MFBHS3RTREFTTCtLVTc1ZmdITzM2R3NFK0tWUldRcVBmK0RFVnV0Y0Y1K05S?=
 =?utf-8?B?bVRTZC8yTXp0eTdldGZnUVdZVWhnU2dyaGQxSWhIcEU1amxoUVBlSjdWVldD?=
 =?utf-8?B?UlhzMlRpeTVMTFRaa1l2RmlKN1NDNlRiR2RZdjdqT3QvUnh0TWt2em95elQ1?=
 =?utf-8?B?bVlBMml0WGQvMWpXQk11WVNLMUk5bkdPbzh1dUc4VUZOZitxejgxeHJLbWdo?=
 =?utf-8?B?b09PQWRIUjNXak8vS05ZUEx6MHBhNHdlQURMNTNCVmJaOGNOZ3VtdjAzS0w4?=
 =?utf-8?B?emZlbHA2dnJzZlNIK1J2RllHZkhpeEhtdlUrb2pISkdtMWkrditwYVdQVEVC?=
 =?utf-8?B?bjVaWFIwcEl2T0pJN1kyYlRQWEVWMFlRQnAvUmNpQ3A3T3Q1L1RJY1JjR1dP?=
 =?utf-8?B?SE5sNFROU25HeHlETU5SdTdTRm51eEJnWU1xV1ZZakNjSVNQYm5iay9mNjl6?=
 =?utf-8?B?UkVJUEJXQUlsNk9pb2lLNVhSNlRpc21VaVhTWjljMEc4dDRnSEljWUpyYzZJ?=
 =?utf-8?B?TTg2NklMcU42R1ZSV2tFRFl5ZTFRQ2xCcDFtTUpoaVA2N1NBREJpNXFBV0Fu?=
 =?utf-8?B?NzhiSEd1d1lCOEZjTVQ1ejJjQzloMllHRHJIQXJid2h2aW1KNU1nd2RIeUlY?=
 =?utf-8?B?MmFmYktuNlloamMxbjZ2cTl2MzcyUzZWZUdzUldKRWROSVYxMkhLdVNYRWw5?=
 =?utf-8?B?T1hzTXZFSWw2cDArVmVVcFJ5b2J6TGtyTDdwWVpBWTJVSXJ0N0pTdDZEVjB1?=
 =?utf-8?B?U254R0E5bjdXa01FRDU5NDNNVXEreXRMRzlTMmFjTHFUT0hBVzdvelBMTmlC?=
 =?utf-8?B?NVZKZWUrMGROcXV5anVtaW1DekNsa0s0aEtETVhFOXpqREtxWkVQbDJDT0pu?=
 =?utf-8?B?Z0syZ2g0Ky91Rktvc2REYTNWbHplZGxGdGNlWWN0OU9sS0hiQnorWjdzdFY5?=
 =?utf-8?B?YWVJdkRvU3BGMjhiMmFnOXd0Uk5oekp2RzhaVERZRXBYMGtWbmZIblIvVHQw?=
 =?utf-8?B?Y3FUZk84NngwUnpobC9VTHVFeHQzaGZLTjMyczJQc1ZiNDAxd05QWWhiSjNF?=
 =?utf-8?B?c2ZOY3MrenRzU0dnWm9kZWdBRTh3b3ZwWTBOQkZjbHJhQURHSDQ3a3N5K283?=
 =?utf-8?B?S0laUitqa25DNWNEaXp1NFQva3ZoaWM2d3I0ZDBRZ1FOdXpjRnlzT1huOGFi?=
 =?utf-8?B?U2M2RTJYTS9aSnJ4bVVzb05qcThNL2llazVUOVN4RDQ2aUUxbnMwcXVHeVZt?=
 =?utf-8?B?dVNhY1VTVWtabVpSaVBTK05PT3NsUUs2cEcwL0FRSWtTSlZOWG1vTXZDYU5Y?=
 =?utf-8?B?dzhDTUYxM0RXNDhRdDgyNGUxVHMxMnh0dU9aaC9aZnNzclJDY2thcG1rNVM1?=
 =?utf-8?B?cVkwNlYvcDlGVHVjUVNJSjJBTndNelZIc2ZFTmdxQ1VVQUFJS0J2SEdVTnMw?=
 =?utf-8?B?aWMyMmVWYVowTXVJRDhEbThPTG42U28zM2QvNnlMeWsyaVBZV0ZSU0F5cUdj?=
 =?utf-8?B?QXU4MVI3eGFiTE9xVU5ZMGJIelk2T1FwWHQ4dTZtdHhSYzFETk5TOGFyOHdi?=
 =?utf-8?B?YkE2WHY3amhmSjdiVitsYy9GazgwMTJVcjhtWThVNHhuWXQyNHhKa1R2Ymtx?=
 =?utf-8?B?VjJuU0duQUxaUHd5dHhSOUR1Vm85L2l5ZWhPZ2VPTm5Jd1J0bW1raXU5SG9u?=
 =?utf-8?B?T0sxWXRJYXlkNk5iKzVWT3NaL3Fyc3prYTBJWmVmalFUQjdKclphUlViQjJN?=
 =?utf-8?B?WUVPNnoyTk9xVU9CeFgrV21aZ0JaZWRHVEk0VHZaWkpHcjltSXdOSytmc2pq?=
 =?utf-8?Q?/nJgs7iu9BhASp78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CE3D17DFA02241ABF1D20E7F0D6DF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f697f1-bdba-4e55-5c91-08de583417ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 14:56:29.3341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljgrPC7giGd7bGNy19uN+5gg8R9OURvIxo8J3hN+WZ0VC8U6QIt7fJ833lWorrmzFWgIeCl0wouPLT89wUeZOfqgxLxsd1M6OMQcnTgRIPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8288
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:15:29 +0100
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

T24gVHVlLCAyMDI2LTAxLTIwIGF0IDE1OjUzICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIDEvMjAvMjYgMzo1MCBQ
TSwgSmFtaWUuR2liYm9uc0BtaWNyb2NoaXAuY29twqB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyNi0w
MS0yMCBhdCAxNTozMiArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6Cj4gPiA+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91Cj4g
PiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+ID4gPiAKPiA+ID4gT24gMS8yMC8yNiAyOjUz
IFBNLCBKYW1pZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOgo+ID4gPiA+IEhpIE1hcmVr
LAo+ID4gPiA+IAo+ID4gPiA+IE9uIFR1ZSwgMjAyNi0wMS0yMCBhdCAxMTo1OCArMDEwMCwgTWFy
ZWsgVmFzdXQgd3JvdGU6Cj4gPiA+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzCj4gPiA+ID4gPiB5b3UKPiA+ID4gPiA+IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBPbiAxLzIwLzI2IDEx
OjQ1IEFNLCBKYW1pZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOgo+ID4gPiA+ID4gCj4g
PiA+ID4gPiBIZWxsbyBKYW1pZSwKPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IDI0ODnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWJ1ZygiJXMgbG9hZGVkIGF0IDB4JTA4bHgKPiA+
ID4gPiA+ID4gPiBsZW49MHglMDhseFxuIiwKPiA+ID4gPiA+ID4gPiAyNDkwwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmFt
ZSwgb3Zsb2FkLAo+ID4gPiA+ID4gPiA+IG92bGVuKTsKPiA+ID4gPiA+ID4gPiAyNDkxwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3YgPSBtYXBfc3lzbWVtKG92bG9hZCwgb3ZsZW4p
Owo+ID4gPiA+ID4gPiA+IDI0OTIKPiA+ID4gPiA+ID4gPiAyNDkzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb3Zjb3B5bGVuID0gQUxJR04oZmR0X3RvdGFsc2l6ZShvdiksCj4gPiA+
ID4gPiA+ID4gU1pfNEspOwo+ID4gPiA+ID4gPiA+IDI0OTTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBvdmNvcHkgPSBtZW1hbGlnbig4LCBvdmNvcHlsZW4pOwo+ID4gPiA+ID4gPiA+
IDI0OTXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW92Y29weSkgewo+ID4g
PiA+ID4gPiA+IDI0OTbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJpbnRmKCJmYWlsZWQgdG8gZHVwbGljYXRlCj4gPiA+ID4gPiA+ID4gRFRPCj4gPiA+
ID4gPiA+ID4gYmVmb3JlCj4gPiA+ID4gPiA+ID4gYXBwbGljYXRpb25cbiIpOwo+ID4gPiA+ID4g
PiA+IDI0OTfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZmR0X25vZmZzZXQgPSAtRU5PTUVNOwo+ID4gPiA+ID4gPiA+IDI0OTjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gPiA+ID4gPiA+ID4g
MjQ5OcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gPiA+ID4gPiAyNTAw
Cj4gPiA+ID4gPiA+ID4gMjUwMcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9
IGZkdF9vcGVuX2ludG8ob3YsIG92Y29weSwKPiA+ID4gPiA+ID4gPiBvdmNvcHlsZW4pOwo+ID4g
PiA+ID4gPiA+IDI1MDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyIDwg
MCkgewo+ID4gPiA+ID4gPiA+IDI1MDPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHJpbnRmKCJmYWlsZWQgb24KPiA+ID4gPiA+ID4gPiBmZHRfb3Blbl9p
bnRvCj4gPiA+ID4gPiA+ID4gZm9yCj4gPiA+ID4gPiA+ID4gRFRPXG4iKTsKPiA+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiBUaGlzIGlzIHdoZXJlIGl0IGZhaWxzLiBJcyAkb3Ygb3IgJG92Y29w
eSA0LWJ5dGUgYWxpZ25lZAo+ID4gPiA+ID4gPiA+ID8KPiA+ID4gPiA+ID4gPiBFbmFibGUKPiA+
ID4gPiA+ID4gPiB0aGUKPiA+ID4gPiA+ID4gPiBkZWJ1ZygpIHByaW50IGF0IHRoZSBiZWdpbm5p
bmcgKG9yICNkZWZpbmUgREVCVUcgYXQgdGhlCj4gPiA+ID4gPiA+ID4gYmVnaW5uaW5nCj4gPiA+
ID4gPiA+ID4gb2YKPiA+ID4gPiA+ID4gPiB0aGlzIGZpbGUpIHRvIGZpbmQgb3V0Lgo+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+IElmICRvdiBpcyA0LWJ5dGUgYWxpZ25lZCwgdHJ5IHRvIGdl
bmVyYXRlIHlvdXIgZml0SW1hZ2UKPiA+ID4gPiA+ID4gPiB3aXRoCj4gPiA+ID4gPiA+ID4gIm1r
aW1hZ2UKPiA+ID4gPiA+ID4gPiAuLi4gLUUgLUIgOCAuLi4iICwgZG9lcyB0aGF0IG1ha2UgYW55
IGRpZmZlcmVuY2UgPwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhhbmsgeW91IGZvciB5b3Vy
IHN1Z2dlc3Rpb25zLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSSBmb2xsb3dlZCB5b3VyIGFk
dmljZSBhbmQgaW52ZXN0aWdhdGVkIHRoZSBhbGlnbm1lbnQgb2YKPiA+ID4gPiA+ID4gdGhlCj4g
PiA+ID4gPiA+IG92ZXJsYXkKPiA+ID4gPiA+ID4gYnVmZmVyLiBUaGUgZXJyb3IgY29kZSByZXR1
cm5lZCBieSBmZHRfb3Blbl9pbnRvIHdhcwo+ID4gPiA+ID4gPiBGRFRfRVJSX0FMSUdOTUVOVAo+
ID4gPiA+ID4gPiAoLTE5KSwgY29uZmlybWluZyB0aGF0IHRoZSBvdmVybGF5IHdhcyBub3Qgc3Vm
ZmljaWVudGx5Cj4gPiA+ID4gPiA+IGFsaWduZWQKPiA+ID4gPiA+ID4gZm9yCj4gPiA+ID4gPiA+
IHRoZQo+ID4gPiA+ID4gPiB1cGRhdGVkIGxpYmZkdC4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IEkgbW9kaWZpZWQgb3VyIEJ1aWxkcm9vdCBwb3N0LWltYWdlLnNoIHNjcmlwdCB0byBnZW5lcmF0
ZQo+ID4gPiA+ID4gPiB0aGUKPiA+ID4gPiA+ID4gRklUCj4gPiA+ID4gPiA+IGltYWdlCj4gPiA+
ID4gPiA+IHVzaW5nIHRoZSBzdWdnZXN0ZWQgYXJndW1lbnRzLiBXaXRoIHRoZSAtQiA4IG9wdGlv
biwgYWxsCj4gPiA+ID4gPiA+IGJsb2JzCj4gPiA+ID4gPiA+IGluCj4gPiA+ID4gPiA+IHRoZQo+
ID4gPiA+ID4gPiBGSVQgaW1hZ2UgYXJlIG5vdyA4LWJ5dGUgYWxpZ25lZC4gVGhpcyByZXNvbHZl
ZCB0aGUKPiA+ID4gPiA+ID4gYWxpZ25tZW50Cj4gPiA+ID4gPiA+IGVycm9yLAo+ID4gPiA+ID4g
PiBhbmQgZGV2aWNlIHRyZWUgb3ZlcmxheXMgYXJlIG5vdyBhcHBsaWVkIHN1Y2Nlc3NmdWxseSBp
biBVLQo+ID4gPiA+ID4gPiBCb290Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBCdXQgdGhpcyBpcyBu
b3QgdGhlIGZpeC4gV2hpY2ggcGFyYW1ldGVyIG9mIGZkdF9vcGVuX2ludG8oKQo+ID4gPiA+ID4g
aXMKPiA+ID4gPiA+IHVuYWxpZ25lZCwgdGhlIG92IG9yIG92Y29weSA/Cj4gPiA+ID4gCj4gPiA+
ID4gb3YgaXMgdW5hbGlnbmVkCj4gPiA+IERvZXMgdGhpcyBoZWxwIGV2ZW4gd2l0aG91dCB0aGUg
bWtpbWFnZSAtQiA4ID8KPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9ib290L2ltYWdlLWZpdC5j
IGIvYm9vdC9pbWFnZS1maXQuYwo+ID4gPiBpbmRleCAyZDA0MGUzOGQ5Ny4uNDlmZGMxZjA1MzUg
MTAwNjQ0Cj4gPiA+IC0tLSBhL2Jvb3QvaW1hZ2UtZml0LmMKPiA+ID4gKysrIGIvYm9vdC9pbWFn
ZS1maXQuYwo+ID4gPiBAQCAtMjQ4MSw3ICsyNDgxLDcgQEAgaW50IGJvb3RfZ2V0X2ZkdF9maXQo
c3RydWN0IGJvb3RtX2hlYWRlcnMKPiA+ID4gKmltYWdlcywKPiA+ID4gdWxvbmcgYWRkciwKPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRk
ciwgJnVuYW1lLCAmdWNvbmZpZywKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJjaCwgSUhfVFlQRV9GTEFURFQsCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJPT1RTVEFHRV9JRF9G
SVRfRkRUX1NUQVJULAo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgRklUX0xPQURfSUdOT1JFRCwgJm92bG9hZCwgJm92bGVuKTsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZJVF9MT0FEX09QVElPTkFM
X05PTl9aRVJPLCAmb3Zsb2FkLAo+ID4gPiAmb3ZsZW4pOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChvdl9ub2Zmc2V0IDwgMCkgewo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoImxvYWQgb2Yg
JXMgZmFpbGVkXG4iLCB1bmFtZSk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ID4gVGhpcyBzb2x1dGlvbiByZW1vdmVk
IHRoaXMgbWlzYWxpZ25tZW50IGluIG92IGFuZCBhbGxvd2VkIHRoZQo+ID4gc3lzdGVtIHRvCj4g
PiBib290IC0gd2l0aG91dCBhbnkgY2hhbmdlL2FkZGl0aW9uYWwgYXJndW1lbnRzIHRvIG1raW1h
Z2UuCj4gV291bGQgeW91IGJlIHdpbGxpbmcgdG8gc3VibWl0IHRoaXMgYXMgYSBidWdmaXggPwpZ
ZXMsIG5vIHByb2JsZW0uIEkgd2lsbCBkbyBzby4KClRoYW5rcyBhZ2FpbiBmb3IgeW91ciBoZWxw
LApKYW1pZS4K
