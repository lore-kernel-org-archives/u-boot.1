Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91015CFA440
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0929C891A3;
	Wed, 23 Oct 2024 17:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIgLPn5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE23688FA7; Wed, 23 Oct 2024 17:34:12 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F226892AA
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6+2k0LOOD6YcPrpKhhV9/2yXLcTHD25WweIFP7EBPLSLq+2f1zSgNzdfvX3PY6fpSe4UxazyWgp54uTJEoG1tI33Lz84hjQAMOxylXpPamg5gBiMxmi4VOhXczOZiJdR7AboU3AMR0zCr9BiuQvE6MXLpPJx6Mj6rKM4uBqt2IZiJpSwq5aEdQslgDLEaIqvvYM9d1cyoHcA4lJzCiudGDlVHycB7SZNeTegKQd6paPCH8jmRW2a01r4EGgMu3RCH9wTffm7Xs4+G0pzk71vtfSnjFOmSM2SjSS/j68NvnSiYjDpS9PT0LxVPkhXy2gRSe/9pJ32ol8+aw869jXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4efR3u6nWrKr8IahFzQDS9+zBRTKzoxXYSI7RP+1BI=;
 b=p2gIlWcJpl3lE2sshPMhiE+Mkn7OjvYzlzgvaH0gHd+DgFmPGEw7i/EsHM/g04BDirp2ekmAFABpDnrupcm3O9mf+COGOrI66GVyFs9xbZf/R9/UNSB6QJVRmZkdP2TzDNWuRcwV2zUWRW1VcwBKLXFIQPrGJb2F7Y077qVsEoV5X3PcsCHcUgeekofG6cFQugS3MVYIAqD0m8Rad1sR0LCiPqhh8naRKR1LUjv5CNAsfoF4x8jmM0DPrfUc1BB7Zylt4mL0qMHHxtm5jvq6ElIMJQUKrLhb4xEFbozLwrSj0PWNcon2HxmO5PAy6EMP1L1up1EYBdh1VexYbdUr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4efR3u6nWrKr8IahFzQDS9+zBRTKzoxXYSI7RP+1BI=;
 b=zIgLPn5kYfPvUQmDe8kqwfGBdT6gPUoLLahM1+6SFDzCIMdIqn3CarQDywfOY6UvzYER7BP0NpxGH8HbuvXD4ytiK5ZF9m8TjlX+3DbHPi1DY3MKFPWz8ub5CveGwXDne5zsT4hwx/0Ve0eXCuDhnlZ4vkLwUYz1YC60Kdq2yVY=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 15:33:50 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8069.031; Wed, 23 Oct 2024
 15:33:50 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Andre Przywara <andre.przywara@arm.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Jagan Teki <jagan@amarulasolutions.com>, Michael
 Walle <mwalle@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Pratyush Yadav <p.yadav@ti.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom
 Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
Thread-Topic: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories
 support in QSPI driver"
Thread-Index: AQHbJMZY/tA7en8DbUuS+Zl7COVM+rKTqicwgABbA4CAAAHK4IAAQkAAgAAX4vCAAAJngIAAAMPggAAEBgCAAAuzgIAAAvOQ
Date: Wed, 23 Oct 2024 15:33:50 +0000
Message-ID: <SA1PR12MB8697290C49119F89500DF2C4984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
 <SA1PR12MB869767A8D003AB114830D46A984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <03389ee7-3da9-4160-a193-00fd517ad56e@mailbox.org>
 <SA1PR12MB869722D8E2019193343572AF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <a78899c6-aecf-4eaa-a9c9-8f11758542cd@mailbox.org>
 <SA1PR12MB8697E723395F31AEFCD1C8F1984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <SA1PR12MB869790C1B058968E33C891CF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <d3a6617e-4ca0-4a9c-8434-fd859c4c78d3@mailbox.org>
In-Reply-To: <d3a6617e-4ca0-4a9c-8434-fd859c4c78d3@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH8PR12MB7447:EE_
x-ms-office365-filtering-correlation-id: 984fa04f-3c35-4691-a512-08dcf378181b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?K0dSalkrZE1iRmtpeE4zNEh5SWhyUDQvbytpSEdLOWFXYzNYdktjVmtDaGVr?=
 =?utf-8?B?K0NTak5zamxRanVBYWdDWUdVeGpKZ0Fsdk9jVVdRTkJxSTFHaFp1eDVYK2FQ?=
 =?utf-8?B?QmtBNEpXN2NxNks0aWtHVk9WVEl2NHRVMkU5NnJENGpRbVBraXdlOVd4QjVD?=
 =?utf-8?B?QVV6WjVkaGJoNExJb3A4T0p2MEhkYW1IWGUwczMvQytONXdJMjB3QVF2VnMr?=
 =?utf-8?B?eG9qUHgrcnQ1L05yVjF2K1hhNDhOTlJ3SHhmRjErWHd5MGVxMUJkempUN0Ix?=
 =?utf-8?B?U2xFNHRRdVVySXUwUGNaUTRBMDJUbVlId2hheTdLcWpUbHVkRExaRlRMb2x3?=
 =?utf-8?B?UThucVZybTV3M01NdUdSQTN1dGhObTlCTGViZldTTHYyKzF3aEtHYVB0dHJO?=
 =?utf-8?B?VXpaM0YzMlUxc2JjeHRKRmx3YUY0bUx5NXdUMkZXUkNQU0tGaUkrTUJRbXpN?=
 =?utf-8?B?NmswODRHRmFrZ3gyckNVSk9GVzdqZENTVnUyVHdnS1oyZTh6aEYxL2wzRFB5?=
 =?utf-8?B?QWJkRmZLZ0VVbmFTMDRnLzBkU3hXOTJvdWhkV0xxN3hLL2dRcmZSNlloWWdk?=
 =?utf-8?B?emZ6K3AwNm9McUlPYzRYVUxxaXhmbnZlak1FYTk4a2h1MnowUWtQZUQrK2x6?=
 =?utf-8?B?OHR1b2llR3VDdUNnOE9nMlBNUGFxY2I1eHhZakE0dzBaNklVRTJwZzFhSVhz?=
 =?utf-8?B?dElNQ1BtdW82U2RCZm1GYWhxUkJ2N0FFMHdpV1NvRE9qQ1RHSlhCYXY5Z2ZH?=
 =?utf-8?B?MWlIT1dHKzFQQnduNUZUNjRORWZ6M1RBdXBGUHNtV0Jya0ZQTWRoNnRtQnhm?=
 =?utf-8?B?bWc5Z0NIVW9YZkRJUXhwTFJlQUJlY1JIU21HTEdBRkdmUTZqdi9tTERSelFN?=
 =?utf-8?B?VFN3dEN4SzkydVhvUjd2U3BjV0pXdW5mTGVJaU53NHBhTnlXaGVDL2V6elM4?=
 =?utf-8?B?cytXQzJwbU5OVlYrdnBYZWdDbXd2WGU1aWpqSjJPVTFJNyszS3k4Zit2bDY5?=
 =?utf-8?B?NFlEcDM4RWNkbkc5d014U21iQ3VleW8xbllJNlpuK0dwYUs1K003dXFrZGU5?=
 =?utf-8?B?Vm9FNDh0MXVTRGYwMmFJYXdSS2NUVEZYQ3ZmQmtWS3hsa2xDTzd2dlVZQjd1?=
 =?utf-8?B?V2dzTG1hUXcyRVM4T0N3UkFKWVlpUGlaNDBBVzl2Qm5qcmkvdjg1Z1hLTnpF?=
 =?utf-8?B?ejZzR0NuaUJsbVlMNHhRU0JleEZXOC9ySGlLbm5Oa3dGZ1R6TEpSUHg2dU1m?=
 =?utf-8?B?UVdBYm5mUTF5QUpnQzhyODZ0MEpocndmNEl0L1pobVdFd1d4ZXdFeS9id2Uz?=
 =?utf-8?B?Z0F6U1NjV3RHL3A5QmpSOGY0dzZ5Z1lxTG5Zd2NwWFNQbjBlMm92YkVoVHI2?=
 =?utf-8?B?Mmo2R1VoODg1cDZENWtsVlAxbHR2R1N3UXFMc0pLSS9RY3oxTUx1SVF0NkhC?=
 =?utf-8?B?THBWcU5jWGdMNG9Zb3Juc3RUZGZIamttK1UwTnc2UTRueHZYNjMzTkNIL1dW?=
 =?utf-8?B?VDJBMTUzaERlQUE2THBDUGswbHVmZjYzRWEvMkJtR2JIT2RZTFZPWkJtczNr?=
 =?utf-8?B?NmxnTm1JVUNVS290YlQvTy9BSWdROHA2SzVscnNVbzZ1cWRjMDFsRElLcmts?=
 =?utf-8?B?eXhyOVdVWmZFMlFNSTBqUW9NNzBURzlwSFVvOWlaM05TWWlsUVhDcEFHTnBo?=
 =?utf-8?B?cUJxOEluTHBlZC9MUys1MTdNMG05NkVKTHMzOVdTOEVNRCtlam9GSUd1QXZI?=
 =?utf-8?B?SzRCeDRwbDlaNjVGVTVIRVlWVys2QzlSaktrczd0bzAvUTFrNlJhQ1FIVHpO?=
 =?utf-8?B?alJXUGZqWTNYUGE4eG42ekJWcXl0Z3QzNGFraWh2RmJtU1lhdDd0Q2JWNUNZ?=
 =?utf-8?Q?YuLVkrf/j8ihr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJFQXhWYnNqVzJscGlNZ2F4Mm5OZExoZVRYT3JLK1I4UkVKMWJUdDYyU2Rk?=
 =?utf-8?B?cjI2NWxXUjZZZHMxNCs0VG9pOUM0TzVqQzllNFNuTnRHUStML0VVTTlJQmFS?=
 =?utf-8?B?MmNyYWtIVUllcXoyNExqd09yWFhjZXJFKzNjSnlGbjR1dmt5dHZvL1FFWVNh?=
 =?utf-8?B?bVFjWCt3eXRtT1JSMzJzdWZoYTVVOSsralRLVGhxOHJORjRwd2k3blZsWVZo?=
 =?utf-8?B?V0U5NWVaL2RENlZJWStTS0I4ZkF1T3NScTVsZFhPTkFpdkhFejIwY3pyREZ5?=
 =?utf-8?B?TXJnZENCK2xjUkxpR1hnY3RDSzJUWUVLVTJUMi9BK3gva010SjYrc0d2WXMx?=
 =?utf-8?B?U3BHWXUyRmg3Q0k3NHlxd25CZ0ZSTTdEZE1GczRFazJnNmlyQzhIWlJEdWt3?=
 =?utf-8?B?MkRRMXJyaWlFMHhuTi8rM3VUKzM2dzZQQ2UweUxPYWpJYXkzbVZwcXcwTTY5?=
 =?utf-8?B?TXkyRWVlSkJVVDg0K21QMmxXZ1RYUmZvWE8zNW42bWpQa3dORUVKaGhVV05H?=
 =?utf-8?B?RDlZNjlleHpJY0xPd1EycEVhMTF4SGFFeThiQW9sSDZ3eVlGZ3ZzWWhrNy9i?=
 =?utf-8?B?OEhNaEMwKzlrMXIvR3pYSFdKU3dOSUQvU0RQdXprYVZGTDJzdm9QWU1JN2xr?=
 =?utf-8?B?VXV6VXNxM0ZNSlcwa0hwS1ZidWx2UlFRWjdTY3pXZ3Brd3A4TVp5amNYVXFz?=
 =?utf-8?B?Yk1DOXE3MXh4REE4TExRZFl0TUtNZmRqZ0lQSURpNkxHdkZ0NjBBbXJRS25w?=
 =?utf-8?B?dndweExMNkdkcUYycGpqQ0p1SlJINEkrZG9BVGpTMjQwSEp6TWlXYVkrMnpK?=
 =?utf-8?B?cWFaakRFTGtTNnIvTnBXOSt0S0pLekpMRlZ0Y1dlRVhXeXJUVmU0VytRZmwr?=
 =?utf-8?B?SGRkaGIwK1QrOFlkT0FqUFA3dUkrck54QjNZZTlnWTkwQTFYQ1YzdlRrY1ZS?=
 =?utf-8?B?Qk1wcVdtRXVCVy8yYVo0eENzM09HRXhSR2g1bmtGLzIyaHh4anNCRy9RemE0?=
 =?utf-8?B?RGl6TjhLTENCMEtKSWlhK290aUovVi9sZm5FK0xyNkVyQTdzYTVzODkzbjlG?=
 =?utf-8?B?anNSa0Z2QnBsRTc0cU1aeWRvSVNHeUVvQjcvcUZXQldLUmZQYTh5M05SVHo3?=
 =?utf-8?B?RXAwVE1qQXRNMitSaDMyZGFBQU9laGZoNWtWTVloVXludkdIaUY4Vk5UOHdQ?=
 =?utf-8?B?SmtUakJ1N3hQNWQ1VkNWNWpvUEozSk9LMVVsbDdyVGdWZUFPNTJrdFdwcVkv?=
 =?utf-8?B?SkQwT1lyeCtwTFBHaUIrL1lUTGU1eWFmRlVGa0M1OGhuSEZZZ2txNGtnTEc4?=
 =?utf-8?B?T1pQRnZROXVWYlpSK2wyc2NWVTY4T0lsK0l0MjFCV0NMRDBtdFc1UzZxc0hp?=
 =?utf-8?B?aklwQmdsdGp6S1ZpMGh1SW04bmY4OFdVZS9QTzJIQVh3VzdWUzFrSkhwKzRR?=
 =?utf-8?B?SjdzRzJoeTNvTmZpb21kZnNzRTRTNXJPcjFROU1aNXhzWUZCT05rZmJNSlVy?=
 =?utf-8?B?SmtGbENWMlFKSXkxQ2ZMcXNXRTVod0JqU0cwOUJPNzkzS3k3N25nT0s4OWlr?=
 =?utf-8?B?Ukp0L2dTOEs5WEJZYjVxV1JTVFlSVW92blV4WUU4Qy8walV3NjROSWdlZG9Z?=
 =?utf-8?B?RGdGNkw3OHZYWlZKaGhaTXd1T3kycld5MmUvTnNhUkd0NWFlNTJTRVRMczlB?=
 =?utf-8?B?WWx6YjhDRGJ1SkVGQmRKUXhmOUF2YmNJeGVSd2pqNTBUaVJib3lUVU1qa3Fi?=
 =?utf-8?B?RURvU1prUElTYmFPSnpLa3hNa21nSXMvNERCUDN5Z3NsU0hGL1I4ZUh2NHo0?=
 =?utf-8?B?TzhZVFhYVXJXdC9ZWFhmUEVGaEthTnhiWG9vSlRCQmxFNTV6S2NBYi9VM0g3?=
 =?utf-8?B?aDFXNnA4c1NONmFTaUJycm5wNG96V3M4eVJRdEZVU2hBc3IzRzY1ZzBmaE1x?=
 =?utf-8?B?YkZnVHJoMGIyajYrdTJvbzY5NlVBR2djOTBTQzZHWHh5b1VkV1llN2xnbU5n?=
 =?utf-8?B?VWcyOHF6RTZTbEtjMy91SDhlZ3dMZVlLektZS1g1cnF0QXBxVFpKRng3V3c5?=
 =?utf-8?B?eWU3d2UrdG5nNHBlK0lBRnIvZGp3V1ZJcGtlTWxWZmFsWm5HbXBFcHQwZGg2?=
 =?utf-8?Q?t2bc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984fa04f-3c35-4691-a512-08dcf378181b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 15:33:50.5637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXJd/GMADKY4qIDAmEOQyg+D14glCK5NT4UN3GMioJTUl2QoNm5FYx/YRngsDX09pz7OZa3zvTo+kxzwOjQ3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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
PG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjMs
IDIwMjQgODo0OCBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFy
YXB1QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogQW5kcmUgUHJ6eXdhcmEg
PGFuZHJlLnByenl3YXJhQGFybS5jb20+OyBBc2hvayBSZWRkeSBTb21hDQo+IDxhc2hvay5yZWRk
eS5zb21hQGFtZC5jb20+OyBKYWdhbiBUZWtpIDxqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbT47
DQo+IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPjsgU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+Ow0KPiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBm
b3NzLnN0LmNvbT47IFBhdHJpY2sgRGVsYXVuYXkNCj4gPHBhdHJpY2suZGVsYXVuYXlAZm9zcy5z
dC5jb20+OyBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+OyBRdWVudGluDQo+IFNjaHVs
eiA8cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPjsgU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBnbWFp
bC5jb20+Ow0KPiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IFRha2FoaXJvIEt1d2Fu
bw0KPiA8VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+OyBUdWRvcg0KPiBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc+OyB1
Ym9vdC1zdG0zMkBzdC1tZC0NCj4gbWFpbG1hbi5zdG9ybXJlcGx5LmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvNl0gUmV2ZXJ0ICJzcGk6IHp5bnFfcXNwaTogQWRkIHBhcmFsbGVsIG1lbW9y
aWVzIHN1cHBvcnQgaW4NCj4gUVNQSSBkcml2ZXIiDQo+IA0KPiBPbiAxMC8yMy8yNCA0OjM3IFBN
LCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+IFRyaWVk
IHRoZSB0ZXN0ICIgc2YgcHJvYmUgJiYgc2YgdXBkYXRlIDB4NDAwMDAwMCAwIDB4MTYwMDAwIg0K
PiA+Pg0KPiA+PiBaeW5xPiBzZiBwcm9iZSAmJiBzZiB1cGRhdGUgMHg0MDAwMDAwIDAgMHgxNjAw
MDANCj4gPj4gU0Y6IERldGVjdGVkIG14NjZsMWc0NWcgd2l0aCBwYWdlIHNpemUgMjU2IEJ5dGVz
LCBlcmFzZSBzaXplIDY0IEtpQiwNCj4gPj4gdG90YWwgMTI4IE1pQiBkZXZpY2UgMCBvZmZzZXQg
MHgwLCBzaXplIDB4MTYwMDAwDQo+ID4+IDAgYnl0ZXMgd3JpdHRlbiwgMTQ0MTc5MiBieXRlcyBz
a2lwcGVkIGluIDAuMTU0cywgc3BlZWQgOTU4Njk4MCBCL3MNCj4gPj4gWnlucT4NCj4gPj4NCj4g
Pj4NCj4gPg0KPiA+IEdvdCB0aGUgYm9hcmQgd2l0aCBzcGFuc2lvbiBmbGFzaCBwYXJ0LCB0cmll
ZCBiZWxvdyBjb21tYW5kcw0KPiA+DQo+ID4gWnlucT4gc2YgcHJvYmUgJiYgc2YgdXBkYXRlIDB4
NDAwMDAwMCAwIDB4MTYwMDAwDQo+ID4gU0Y6IERldGVjdGVkIHMyNWZsNTEycyB3aXRoIHBhZ2Ug
c2l6ZSAyNTYgQnl0ZXMsIGVyYXNlIHNpemUgMjU2IEtpQiwNCj4gPiB0b3RhbCA2NCBNaUIgZGV2
aWNlIDAgb2Zmc2V0IDB4MCwgc2l6ZSAweDE2MDAwMA0KPiA+IDE0NDE3OTIgYnl0ZXMgd3JpdHRl
biwgMCBieXRlcyBza2lwcGVkIGluIDUuMTg2cywgc3BlZWQgMjg0Njg4IEIvcw0KPiA+IFp5bnE+
DQo+IA0KPiBXaGljaCBib2FyZCAob3IgRFQpIGlzIHRoaXMgYW5kIHdoaWNoIFUtQm9vdCB0cmVl
IGNvbW1pdCA/DQo+IA0KPiBBbmQgSSBhbSBzb3JyeSwgSSBtaXNzZWQgdGhlIHNmIHVwZGF0ZSB0
ZXN0IGluIHlvdXIgcHJldmlvdXMgcmVwbGllcy4NCg0KDQpUaGUgVS1Cb290IHRyZWUgY29tbWl0
IGlzIGYxZGUwYjk3ZDFjYmZkOTgyYjdhNTA3OTYyYmIyMWIxMmEwMjRiMmYNCmFuZCBhcHBsaWVk
IHRoaXMgY2hhbmdlIG9uIHRvcCBvZiB0aGlzDQpodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJv
b3QvMjAyNDEwMTgwODI2NDQuMjI0OTUtMS12ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbS9ULyN1
DQoNClRoZSBib2FyZCB1c2VkIGlzIFp5bnEgYW5kIERUIGlzIHp5bnEtemM3MDYuZHRzIHRlc3Rl
ZCB3aXRoIHRoZSBub24tc3RhY2tlZCBzaW5nbGUgY29uZmlndXJhdGlvbi4NCg0KWnlucT4gc2Yg
cHJvYmUgJiYgc2YgdXBkYXRlIDB4NDAwMDAwMCAwIDB4MTYwMDAwDQpTRjogRGV0ZWN0ZWQgczI1
Zmw1MTJzIHdpdGggcGFnZSBzaXplIDI1NiBCeXRlcywgZXJhc2Ugc2l6ZSAyNTYgS2lCLCB0b3Rh
bCA2NCBNaUINCmRldmljZSAwIG9mZnNldCAweDAsIHNpemUgMHgxNjAwMDANCjE0NDE3OTIgYnl0
ZXMgd3JpdHRlbiwgMCBieXRlcyBza2lwcGVkIGluIDUuMTg2cywgc3BlZWQgMjg0Njg4IEIvcw0K
DQpUaGFua3MNClZlbmthdGVzaA0KDQoNCg==
