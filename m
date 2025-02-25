Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65069C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 04:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7764880805;
	Tue, 25 Feb 2025 05:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3G6Zywle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B86F80977; Tue, 25 Feb 2025 05:18:43 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1955807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t06DZGj6Il6h27krkCSwPamYYtYpl9kt/3hexGnzLw4TsGOPEFvAJ9bOvXsOqeXHAgouxdcO8rDtT/+m3rAsVRBF4ch7uZR6T6OZaMmH2H/9WxMdGoKoXiQdO6unYOYaA35+EiAEENnK9QhNZ+p/HWhwvz4bHkC1ybc6sTdUp+IpifL1Pu0ZSUz9Su/txZivMhAqck9H6zUUDnj4EDg+PuRi0H0EKLKM35NP4uPaSYJlY07nlk8twXAruKPtKlHrD8J8Emc4jWHYDvOg5EsLxqJqsQgFyCUBCmFnzy0a22k1k5J50GNH3C5BBgFZeCSAWPqi7xZMkBBQvFnPRR8h9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF1qhrRAsXc5QAlbClR93sTce8i+/SHZ6gZQcMLGB8c=;
 b=ibZE6a8hGNDIAUYgltDovCUtxZgVGm5f7WH/a98hcQjpuqvB2wlAa/6ovgyNsqcb9nKblAKjqy5O3QHw+RElQttpVJ20sXood+2Xsf2L4MjcUrmu3fQGXZscXGi+TcN+BLewjj+OSSOmelcC2tPxnua30Fy2LpcKp6J6WdBsZ166/aE/WE+V/1GkgqOViNec2HhTuJNLkl71KS7830TMFgKu93Ii9g3NRY74nVfKmrzSw7qaFKZydGK7axfGQ9ZEgXuoQpk0uZdmpnkaNYkyKgiSg4C/6YaLdh5zRcVGmJ6oIIrkfdYPjQrQU92joZZRTnahWIJ2+yhjuq6ufRNj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF1qhrRAsXc5QAlbClR93sTce8i+/SHZ6gZQcMLGB8c=;
 b=3G6ZywledAuWsT7UtsJDTmAGxwr0onKNiERYaRzj+AIN1OSxvOUj/T+Y3zREVF9xt/6gjIcskZiSXpepBrUplbxPymfygBAbZBZBexafWWskqJRSoohiqlmUbL8lmEZVH6rcBkew6H8I25xRHI7uo9j4prLe0CB2++G1T92pcdQ=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 04:18:30 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 04:18:30 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Marek Vasut <marex@denx.de>, "Abbarapu, Venkatesh"
 <venkatesh.abbarapu@amd.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [UBOOT PATCH] spi: spi-uclass: Fix reduced read speed when
 parallel config is enabled
Thread-Topic: [UBOOT PATCH] spi: spi-uclass: Fix reduced read speed when
 parallel config is enabled
Thread-Index: AQHbhEcTayoASnp79USagNoveumxHrNSC8cAgAVj+wA=
Date: Tue, 25 Feb 2025 04:18:29 +0000
Message-ID: <SJ0PR12MB6685A6E44654C7B16394A85E82C32@SJ0PR12MB6685.namprd12.prod.outlook.com>
References: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
 <e4258db2-d236-447d-93aa-70444b722b62@denx.de>
In-Reply-To: <e4258db2-d236-447d-93aa-70444b722b62@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e20c2cec-854f-4fa7-be89-1615722d896a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T04:17:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|DS0PR12MB9346:EE_
x-ms-office365-filtering-correlation-id: c77d8578-23bf-4a37-7323-08dd555375a3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dHd2Q1lnY3M3Z3N0ODhyQmxJT1p2N295d3VBQTNpaHQzY21mWlJhTjk3ekxD?=
 =?utf-8?B?TU9obCtJbVhPYmJTY0EyeGEwNTA3ZDAycDZsTHFYbXkyQTZCUGJYOURmQytn?=
 =?utf-8?B?TGY1L3ExNER3ckMxL3J1dmFBWEdTSmlDSnpXOHRwcUtkZ3V5ZDZneElpRXJu?=
 =?utf-8?B?MFhhaVYwTmJ1SW8xVUdhdnhhTUlBY3hmR01lUnpxaUVja1dBUGhFN29pUlZK?=
 =?utf-8?B?bmlkTXJZUTM0Z0xQcU4xWlBrOFFmUTRGSVc2SldpdVRXcmdLRitqVGI3bDls?=
 =?utf-8?B?dzArTFExcmZlNHl6cXhYY01ENENGS1R2aUJkODlMWURncm9xQWVYNWJBVktL?=
 =?utf-8?B?RDEzRDZoUzVSK0lCRmRqZHVLZlBRaGlsb25mYWFrUytwMlVUd2h4Q1d3d0tv?=
 =?utf-8?B?L1FYbnF4c3EvcVNhYUJneE1NamtGT25sNm14TXhhblZ6b2sxQnNRbUFSNFpo?=
 =?utf-8?B?Sjh0NUVpMDluRkd2Q1NZekRwVmhOS0xoRzM3NDRlbnpCR2NHU1lxVEF2SS80?=
 =?utf-8?B?L0dacmhEQnJjZkJTbSt0bHA4em9SNzZzY2dxZnFPSmlIV1BIcVN3NlAyNTVL?=
 =?utf-8?B?SlNLU1NyZ3NXSGs2VURTLy9adHVGcDRVei9FK0JTdmVaenpMaVgvbjJORkdK?=
 =?utf-8?B?WDFWMFA5c0ZybjhlcDdjcHZFanRZYWlQY2pMSG45L2hwVWx4eFkrb05MM0ht?=
 =?utf-8?B?MFRUSTlLc1NGbGVvU2QwWHR4NXY3bXBNZmVsNFhEUCszV2JMMXN4NHA2b0Z2?=
 =?utf-8?B?aVdYdkttQzB2NkRhVkVqMTNQMUIvVVVnbG0xVFdMUk5TaU1xcy9meEdHSUQ5?=
 =?utf-8?B?NFhodWtCZ1JDZTJEaThJVy9VdVVQMCtiSE5qRUpIWHlISUhnUmlBQWRwZElh?=
 =?utf-8?B?OW1YUUVvMXZGaVlPYkw3ZzNjVjVseG1QK0FnR2lGUWk4cGcrbU0xVlBiTVA5?=
 =?utf-8?B?NFl2aURDZHo3U2Q0Vys3bTdma3JCUUtQM2I0UlNORXlwUFIvOFVMcjhIVW55?=
 =?utf-8?B?ZUhnQVQwM05nWngzOW5DWUdDTUgwYy9ucGpMRHlYbm5SQVpYUnU3eG5rQmxs?=
 =?utf-8?B?S2JCMTVRUTI4M3Q3MDI4anh1aS95QW9Kckw5c0ZMc3dvS2ZMZ3hYYlVla3Jn?=
 =?utf-8?B?OForWnVES3dkUFJFL3NJMHJ6blU2STRNU0lSZjQwUTdLdEZQcUVyTWc3NGhN?=
 =?utf-8?B?Tm5nNmlOUlFVdVpraEFjSGRWd3ZKNkZrdzNOeERva2dPNmVrcE5QbHRTMEEv?=
 =?utf-8?B?blNwWE1pcHBFbitmbzQwRG9RMnJoWVZUNHJCSG9HV01HeGExNzRUSnl0UVk4?=
 =?utf-8?B?WWt4SVhkdlgzN2xWb0E1V0dvTmZXN3hReXFSU1I0WFBiZUJtc3NTQ3VlWVVr?=
 =?utf-8?B?MXQ2bWg3N0dOdEZ3VVJkMmpvSjVwYU5aQnZXY05uOHZoT1FGaVVrNkQ0TWxS?=
 =?utf-8?B?cXJCQ3NMUklBZzZVQ1RBT1hpaW1scm9oSDcxVlgxS0JoenFDQnlkY2EzMGN2?=
 =?utf-8?B?dTFaWFVaRUFSZ04xRDUvUkZwU01IR000dG1KT2N2UkxZQzJTdXdHOTlBeitR?=
 =?utf-8?B?WTdoM0pmd3RwejhxSWdrcm95azF5ZTJXcEJBdjlqbkgreFY4b1Q4aHp3T0FF?=
 =?utf-8?B?REtEYzl2RlR0akdDL1FCTFEvNktCWXoveDhUZFQ3Y1BpaEg1NXFXSkhqWThk?=
 =?utf-8?B?WVVISFNVN25UaHV0d3VodWNFS0E2UlFQUkN1NTRpSXZ4TzFIb25wRXZDV0Jr?=
 =?utf-8?B?Sy9yckVabTBjbFJFZEZleG5hYjNGV1h1YlpvdTFwdVNZNVgvdmltSi9tbWQ3?=
 =?utf-8?B?RDRhcmUwWHBqTm5vVE9QQnM5SjlyT0cydmhiVXM0ZzF6ZzY3bC9DdlhDWEkr?=
 =?utf-8?B?WTVIak5CNUd2aFNPOWhRL3hPVmplL1EzL0FPQ2tudGVhNWZJWFJCMHZqeEsr?=
 =?utf-8?Q?ovFHvQF6Dnp5qN5Ys9hROD/YA8pwsE0f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25rZGFrTU9rZS9uNzR3czlUbXlHU3pBdGNFeXlyOHAvdnpBbk1jNkI3dUR3?=
 =?utf-8?B?aWpHcXlPOEx6UnU5ZmtNdGtoTUpybUpnVmVFdW81TzVHUFhFNlNFUXpTRXFz?=
 =?utf-8?B?Z0RaVkIvL1pxdlFmS2pGYldpRlJVZTFqU1pYTUhqeFZ6cDVFMUJlbXZ6dE9x?=
 =?utf-8?B?NTRQUml6NDNRbTZDWFc4MzhiM2NleHF4UUp1amdrbnlrSFRZVzZqMEZxM2h3?=
 =?utf-8?B?SjdUZnpHOU1sT1NxK3ltUGFud0ZkWDcxZU5iQ3MxWGlBUkN5RWxFelo3TWZL?=
 =?utf-8?B?bXFSSVVCOW9WaHoySTNmSEpmRHkvcVpEZzk3dVJ5UE1wR3p0ejBQUjFXckZO?=
 =?utf-8?B?Yy83NEhZaGtxeTZwL1QvcXk1eVB2YXZIZUt4SkF6U0o2V09MZW83aXd3aVBo?=
 =?utf-8?B?RXVBeEdFc0VqeVJXUUU0N3k0ekk5RURaSE9kWVkxTXJkZ0UzejhtSHB3a3Rm?=
 =?utf-8?B?bmlYd0d5dXRJZTQ2WHc2Y1QraExQdjhqaGJBNURFVlBod2xvU0N5VmJHSVR4?=
 =?utf-8?B?b1phd0FGOERNd3hBVTlvRFJ1SWRIbjduTnNpOC9reDFZcm9xS1NxcW5vTmZm?=
 =?utf-8?B?K0lyRzNlS2JUYkRCUVpIT0JtNjlHOWNzUGVNYVVUbitUTHhIcWhueEMrSW16?=
 =?utf-8?B?cHR4T29Bbzc4Q2JPMFhzY3pjaldsa1lRWk1OcVJRanlYRGx0aDBVUDJIckY2?=
 =?utf-8?B?Tlg4SDZOeTVEL1hreDBBR1JTRDVtdHF4b3JuUXJad2VpTTBESHJGNnl5RCtQ?=
 =?utf-8?B?OVNoTnk5amtkaXFsTmJXWXlIaXRiTjZpZ1VFWmhkc3JpWU8zVUhPSGVRZjRI?=
 =?utf-8?B?a0lRVmFpcFNTU1ozcE9DcWZuSkEwa3JSbzdMRmw2emtwUGprNFZWU01HV25F?=
 =?utf-8?B?VkV1dGZsWUtLSE9LTzdtaHpOakw1ZTlNc1BIYk9ETXN4MEVERXBFQ2U0cWVN?=
 =?utf-8?B?MXQwMStRMEFSeVh6U0JZa0ZDQUJsWWo2RTN2d0Z6QzJORHUwZU1pRWtSRVUz?=
 =?utf-8?B?Ty9URy84bEpXQnErc1VQZDhJYUd5alVOOVR4UWpQNzkrZDQyVWtBZ0RUNzRE?=
 =?utf-8?B?cmVsTFhVT09ON1VFdWVjL281UE81UXhudEU0UmZlNks2aWVMeWt2NHlOSndv?=
 =?utf-8?B?L1p4bExYN2N2TTM1UzdWM1ZVb3p6all2RWV4Z2pmMGc3WDc2cWFzS3dmanJF?=
 =?utf-8?B?TUxKV0g4UTZRSThIWk1TZXhyYnRVeW5VNGlaVDlSTjlqMmwvTjFlL2I2NWRS?=
 =?utf-8?B?U29FcERlTG1RMFZVcXpPanVUalRnaFUwNGpTcVJIcDZrWkJsMzk0L05SVHBQ?=
 =?utf-8?B?OTl6YUQwVlFqN3ByQ2l2Y2I0SmRBNElqZDcxclpvSnJpQ1JBcmdncGJYdzdq?=
 =?utf-8?B?d0FRcjJaM3ZKbHZ3M1FMS2lYVEtmYjhacjYrVTBkY0lQZjNrcFlyWEtLU2RW?=
 =?utf-8?B?d0syNzNtWjd0eHU4dmdsMWFud2JoRXluTFRTZG9IdEJ4cHRCZXBEZlhTSGZt?=
 =?utf-8?B?Vlc5T3h2SEhoa1hlVEhGMVBsczhuSUJiNjd0eWJnaUhoUXRMYkh5NjdWWXVB?=
 =?utf-8?B?eUM1L2YzMzVlRDRnV0dGU3FDdkw0eEV4NFZGNXJPSXlSUDUxOWRXTng4UTdB?=
 =?utf-8?B?ZjJNT0wvL3gyVnJiVWV2Zlo1MnU0WmJBK3Q2am1WYlJwSDFzVGdSc3QyaHFh?=
 =?utf-8?B?cm1qRHA3VC8wKzVvM2dDZFQ4WkJjSnhMUnJDWGVTQmRFMTVGSmJNUkJyNEdK?=
 =?utf-8?B?SVlpS1JqTXB0N0lCR1VwWUw1K3NKNlVxNnIzWXlRaDZFU2tmalZhUHZEcDJ4?=
 =?utf-8?B?eUpHV0lZb1lRSlhZM29pUElwODF0cGpWRHE5VTZ6S0R4bDE4aTVjalZuZkxC?=
 =?utf-8?B?NVZLQ25VcTc5LzRhaWkybGlLYXhlRjR2bm1WRU91UGprWVpraThoaUFCemtK?=
 =?utf-8?B?MUZ6Q0pJRXdWQlBhaktWRlJGS1lURWNoUGpJVmZ5bVlMRzN2VGtab3NIT09T?=
 =?utf-8?B?eVFvR280ZUNIbUNZcmdFQnBvU04ra1Y3Qi9nSzhXUys0amt0K3QvSi82d1hP?=
 =?utf-8?B?Q0xWWElOWDR2RzdKN1BQYTAwVWVmbWNHbXF6SEYxbGhCTjk2bngvMVAySWlr?=
 =?utf-8?Q?FWJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77d8578-23bf-4a37-7323-08dd555375a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 04:18:30.0217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBFWzMXaawQHsFKZnrU+oKuc8pxq2moI6yK43kidNRCv2QUef3rj0qmy112x8PSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFy
ZXhAZGVueC5kZT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyMSwgMjAyNSAxMToyOCBQTQ0K
PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+OyB1
LQ0KPiBib290QGxpc3RzLmRlbnguZGU7IHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZzsgai1odW1w
aHJleXNAdGkuY29tDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47
IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiB2aWduZXNockB0aS5jb207IHUta3VtYXIx
QHRpLmNvbTsgdHJpbmlAa29uc3Vsa28uY29tOw0KPiBzZWFuZ2EyQGdtYWlsLmNvbTsgY2FsZWIu
Y29ubm9sbHlAbGluYXJvLm9yZzsgc2pnQGNocm9taXVtLm9yZzsNCj4gd2lsbGlhbS56aGFuZ0Bi
cm9hZGNvbS5jb207IHN0ZWZhbl9iQHBvc3Rlby5uZXQ7DQo+IHF1ZW50aW4uc2NodWx6QGNoZXJy
eS5kZTsgVGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbTsgcC0NCj4gbWFudGVuYUB0aS5jb207
IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgS3VtbWFyaSwgUHJhc2FkDQo+IDxQcmFz
YWQuS3VtbWFyaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1VCT09UIFBBVENIXSBzcGk6IHNw
aS11Y2xhc3M6IEZpeCByZWR1Y2VkIHJlYWQgc3BlZWQgd2hlbg0KPiBwYXJhbGxlbCBjb25maWcg
aXMgZW5hYmxlZA0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFu
IEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRh
Y2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIDIvMjEv
MjUgMTA6NTcgQU0sIFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSB3cm90ZToNCj4gPiBGcm9tOiBQ
cmFzYWQgS3VtbWFyaSA8cHJhc2FkLmt1bW1hcmlAYW1kLmNvbT4NCj4gPg0KPiA+IFdoZW4gU1BJ
X1NUQUNLRURfUEFSQUxMRUwgaXMgZW5hYmxlZCwgdGhlIGNoaXAgc2VsZWN0cyBwcm9wZXJ0aWVz
IGFyZQ0KPiA+IHJlYWQgZnJvbSB0aGUgZGV2aWNlIHRyZWUgdXNpbmcgdGhlIHJlZyBwcm9wZXJ0
eSBhbmQgc3RvcmVkIGluIHRoZQ0KPiA+IHBsYXQtPmNzW10gYXJyYXkuIEhvd2V2ZXIsIHRoZSBm
dW5jdGlvbiBkZXZfcmVhZF91MzJfYXJyYXkoKSByZXR1cm5zDQo+ID4gemVybywgY2F1c2luZyB0
aGUgZXhlY3V0aW9uIHRvIGVudGVyIHRoZSBlbHNlIGJsb2NrLCBwcmludCBhbiBlcnJvcg0KPiA+
IG1lc3NhZ2UsIGFuZCByZXR1cm4uIEFzIGEgcmVzdWx0LCB0aGUgc3BpLW1heC1mcmVxdWVuY3kg
cHJvcGVydHkgaXMNCj4gPiBub3QgcmVhZCBmcm9tIHRoZSBkZXZpY2UgdHJlZSwgcmVzdWx0aW5n
IGluIHRoZSB1c2Ugb2YgdGhlIGRlZmF1bHQNCj4gPiBmcmVxdWVuY3kgU1BJX0RFRkFVTFRfU1BF
RURfSFogKDEwMCwwMDApLiBUaGlzIGxlYWRzIHRvIGEgbG93ZXINCj4gPiBzcGktPnNwZWVkLCBy
ZWR1Y2luZyBRU1BJIERNQSByZWFkIHBlcmZvcm1hbmNlLg0KPiA+DQo+ID4gVG8gYWRkcmVzcyB0
aGlzIGlzc3VlLCBhbiBhZGRpdGlvbmFsIGNvbmRpdGlvbiBoYXMgYmVlbiBhZGRlZCB0byBjaGVj
aw0KPiA+IHRoZSByZXR1cm4gdmFsdWUgb2YgcmVnLiBJZiBpdCBpcyBub256ZXJvLCB0aGUgZnVu
Y3Rpb24gcHJpbnRzIGFuDQo+ID4gZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJucy4gT3RoZXJ3aXNl
LCBpdCBwcm9jZWVkcyB0byByZWFkIHRoZQ0KPiA+IHNwaS1tYXgtZnJlcXVlbmN5IHByb3BlcnR5
IGZyb20gdGhlIGRldmljZSB0cmVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhc2FkIEt1
bW1hcmkgPHByYXNhZC5rdW1tYXJpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0
ZXNoIFlhZGF2IEFiYmFyYXB1DQo+IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvc3BpL3NwaS11Y2xhc3MuYyB8IDYgKysrKy0tDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS11Y2xhc3MuYyBiL2RyaXZlcnMvc3BpL3NwaS11Y2xh
c3MuYyBpbmRleA0KPiA+IGQ2MDQ5NzUzNzQwLi5hNzc4M2I2YjZkZCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NwaS9zcGktdWNsYXNzLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktdWNs
YXNzLmMNCj4gPiBAQCAtNTIzLDggKzUyMywxMCBAQCBpbnQgc3BpX3NsYXZlX29mX3RvX3BsYXQo
c3RydWN0IHVkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRtX3NwaV9zbGF2ZV9wbGF0ICpwbGF0KQ0K
PiA+ICAgICAgIGlmIChyZXQgPT0gLUVPVkVSRkxPVyB8fCByZXQgPT0gLUZEVF9FUlJfQkFETEFZ
T1VUKSB7DQo+ID4gICAgICAgICAgICAgICBkZXZfcmVhZF91MzIoZGV2LCAicmVnIiwgJnBsYXQt
PmNzWzBdKTsNCj4gPiAgICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJoYXMgbm8gdmFsaWQgJ3JlZycgcHJvcGVydHkgKCVkKVxuIiwgcmV0KTsNCj4gPiAtICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiaGFzIG5vIHZhbGlkICdyZWcnIHBy
b3BlcnR5ICglZClcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+ICAgI2Vsc2UNCj4gPiAg
ICAgICBwbGF0LT5jc1swXSA9IGRldl9yZWFkX3UzMl9kZWZhdWx0KGRldiwgInJlZyIsIC0xKTsN
Cj4NCj4gV2h5IG5vdCBzaW1wbHkgZG8gdGhpcz8NCg0KU3VyZSwgd2lsbCB1cGRhdGUhDQoNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS11Y2xhc3MuYyBiL2RyaXZlcnMvc3BpL3Nw
aS11Y2xhc3MuYyBpbmRleA0KPiBkNjA0OTc1Mzc0MC4uNGQ5Mzc2ZGJkY2EgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc3BpL3NwaS11Y2xhc3MuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktdWNs
YXNzLmMNCj4gQEAgLTUyMiw3ICs1MjIsNyBAQCBpbnQgc3BpX3NsYXZlX29mX3RvX3BsYXQoc3Ry
dWN0IHVkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRtX3NwaV9zbGF2ZV9wbGF0ICpwbGF0KQ0KPg0K
PiAgICAgICAgICBpZiAocmV0ID09IC1FT1ZFUkZMT1cgfHwgcmV0ID09IC1GRFRfRVJSX0JBRExB
WU9VVCkgew0KPiAgICAgICAgICAgICAgICAgIGRldl9yZWFkX3UzMihkZXYsICJyZWciLCAmcGxh
dC0+Y3NbMF0pOw0KPiAtICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgfSBlbHNlIGlmIChyZXQp
IHsNCj4gICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImhhcyBubyB2YWxpZCAncmVnJyBw
cm9wZXJ0eSAoJWQpXG4iLCByZXQpOw0KPiAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ICAgICAgICAgIH0NCg==
