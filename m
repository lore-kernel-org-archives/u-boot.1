Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE537E77171
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 08:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29369891B1;
	Thu,  5 Dec 2024 09:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNVh5KPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66CA891C4; Thu,  5 Dec 2024 09:15:24 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A866891B0
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 09:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvHMdJRH8yZSiZEDn25uQ6h6ZRLM7TIvoa9xD9QqNx0D3NbYJcMOjq5MZSWAVACnoJXmSi/lE5nMKEjinIh5QXX+Dvxtov4/9l+UMdFoGN1wH5Kgu4loDeGRmJxsIKwzZpNh86jcRwC97TqfNlEiI+ciXRV88rNbanK4GvO3wlOr/3sBbcujnyV93BoSjtOd4IG98ovtLjrDxVZTNXLU+JFiYu8r+kk63B8DAPJLrHowttLyx+4RoFT5bOHmLM1Jhtniicd1VNX6YKAM4J5ruXcVPSl7/03ufKqmG1Euyav/BnAtuThzNDjN6xRabVjJoa5crSH4sFaL3opXNzsuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4rwnO27G9h+atFY+MA0PK5wMXT0kggyAGaryPIp+Bk=;
 b=S5+efYhT32KprkVDc3W/dzUHPRzloBcqkQJHgMfPtOzWm+q+mMVq2np4HPxpcZqtfWMNcAlMtrXAGvWcJ1N9QxJb30EgZotpwwEj8crgBs6nCr81oJf3V5UIEocdCKgEtYyVDuYVTfXgo0ky9N/OUERVw7Hnf6py/kqJFNh3dhOe3kmlYGC9cwSWRXDEC+MDDCwAsEGzk5USSIRD303cHunZ8Zii2wQ8J/7KJkW4qsLUl9HSW3MT0uqeUlgqWoakOKYI+cB9GBX/VgbntAxnO50hhn6Nt8ECBgG8ASY4suKIMighrBrAV7DWAw7YGB92PYTZ0PIg3ejvvOzXcZw6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4rwnO27G9h+atFY+MA0PK5wMXT0kggyAGaryPIp+Bk=;
 b=MNVh5KPYiYPwHVtmNDG+yzabIwW2fqCBSm7Mx8qMn61WaJW+YskM45jhkNgQZr5vz5zungR3d/WAHtovFtHxLpk3exRTI2OS/OgQXrOQJGYnJF0otfwQquseR9nqvwfsT1VQelg9lEpWPPZx5eIH/ThNXEQxSgLOhAZ8/4tH6zA=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 08:15:15 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 08:15:15 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "j-humphreys@ti.com" <j-humphreys@ti.com>
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
Subject: RE: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Topic: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Index: AQHbRs5Q31mSoP8Makufz6zCdH/DNbLXRw0AgAAEyjA=
Date: Thu, 5 Dec 2024 08:15:15 +0000
Message-ID: <SA1PR12MB86970F2A723136A967B1633698302@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241205042919.297068-1-venkatesh.abbarapu@amd.com>
 <19873424-f054-45d5-ba3e-9fb484ceb6e1@linaro.org>
In-Reply-To: <19873424-f054-45d5-ba3e-9fb484ceb6e1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DM6PR12MB4338:EE_
x-ms-office365-filtering-correlation-id: 15da5cb9-b881-4c09-f46e-08dd1504f2c5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R3cwbCtOSEZHTURJdC85YjBKeUNTSVpRQ1g5Y3NHcFdBUldsRU9hQlZGYkxZ?=
 =?utf-8?B?UG1kZyt5WXRZajFWN25FdWp5VzVodm1IN3RXd0w3U3BxcmMyVDl5SDdSOEFk?=
 =?utf-8?B?WFc4Q0FuVW00OVMrUmIza0ZoQjIyNUxHZE05QlpweFF2Uk41QXp1MTgvTERx?=
 =?utf-8?B?MXVVSXRQRHB6Ulk2cmFUYjdia2dEc0M2YXFPNnRveXJtdml3cHFJSUtYdmkz?=
 =?utf-8?B?SmNrejRPTmJ1a0VweHAvMlh3RmVpdzRsTUZtd1dlampaanRTc3k3SWxKaTZy?=
 =?utf-8?B?RVl0aWZqcU83QzZaNkk3YlNvbW9Mek9aSm1wQVoxc25teCtDTVFRWFFNd2Z4?=
 =?utf-8?B?WEovRVVVY29WMVVYQlJkL0VlbW5tL1NubGN4bWZhQythekpWcmVxVGFVaENz?=
 =?utf-8?B?c3pDcGZObXYyVnllNTBPaFV6bit6T3ZpMHc5YXVIWG9ZWTBPNTJyYUZnYkI0?=
 =?utf-8?B?Z2g1cHJrbEltOUVQNERsbFpxVVdnOTN0d1o4Sjc3cWRVSDlEQkE1WTBQcUJB?=
 =?utf-8?B?NmV1MXJyakEwSnZsWFVPaHpFTWhvNjhFc3ZXWUd4Z2JSMDRYa2Z3cTBSMFNi?=
 =?utf-8?B?cGgxSHhXdjBSNVN2OUIvNDc1VUlVTFVSbEhwaFE5NkZuWmt5ejdGOHV1STlt?=
 =?utf-8?B?dnRFeVlkYXFWNmoyQVR4Z1VLNjdUMFpMcDhzdlBES2p4NkFDd2lQWkUvRVd2?=
 =?utf-8?B?cTBlb2dIeTVCR1dCNDVTd25pZ09sZU5KaGxoQVJvVEpZemh6YmpsWitCMXFQ?=
 =?utf-8?B?b3Ava1JkbTZsVnlLYU9aTnhVaEdkTXJhL2ZXb1U1c09QRW8zSXNTMHJaa2hq?=
 =?utf-8?B?MDdRRUZJcVlrZDhMSlFQVDlydDJlT001YXMweXNoWXBaeW8vZ24wcVNDaEt1?=
 =?utf-8?B?Q3NaVVppcHR4YnVEL0ZwWmJVMkJ5a0wwczNzVE92VEFscGhJSDNiNFVIcng4?=
 =?utf-8?B?V0l1YTdheDZwQXpvdGg3SmE5WHY5UkE0MDg0anNxTTB5YTY1bElUU0VwSmU5?=
 =?utf-8?B?WU9wN2huNCtFaTZLazNKWjhjMU9rZU1IY01UWk9tcXpSK00vSDdaTEd6T1Vr?=
 =?utf-8?B?UWRmVUMva1RUTG5MK1Y3SzVXdUl2TFRTQ0k5ZFN4akwyZ3NWcVpXTHduV1Qy?=
 =?utf-8?B?ZVNac201WW9LUWhhU1RTSzBXQ2VVT1JpTGdQaFI1UjdkYVFHY3ZKVGFYQ01I?=
 =?utf-8?B?b2o5Y1VsSEhqakVyL1FIbFBhc3BVcGtJZWhnK2tEdXlCRHJYQmVVRjQxaEVh?=
 =?utf-8?B?OXhOVXB4MWlCZG9kVk9mRVluT1Q4R0hsbUVLMUp0QU1ZdlloNHh6L1Y3RnhV?=
 =?utf-8?B?K0FQTDJSVm1WQTNkWUpLQmtweWdLUjROa0w1Q3pLV3A1YzdoOHYrSkxLTjNt?=
 =?utf-8?B?RkNTVmJ5bXVhdTczc1E2UEFFZ1NXNm5rUTNuYWUwQTR0ODlvODQ4dk1BWG93?=
 =?utf-8?B?a0szejJiYm5URWNaeEJVQnhVR3V2bnk3VExlaTd4KzFDWlpBMlEwSElnaExs?=
 =?utf-8?B?K2VvWldjRjJIYnVvOUVoN2lMMmN4Qm9xM1lKOEY5bWVKdElaWUVXZ3N5dm8v?=
 =?utf-8?B?dXlMcm14UHRxKzNSWXF4N2tVS1Nycm1WajhBVitidTNRUW8rSFVLMFJGc2xT?=
 =?utf-8?B?N0VtcW80WmQ3bmhwMWVVb0ZRTnhTMHRlT25MTHpoa2ZObU9vdGwrOUZKck54?=
 =?utf-8?B?elFGR3loaUI0SmczTWd2TUxvTWtESFo2dEZkY0JIRFpqRmZqMEUxSjV0SU9O?=
 =?utf-8?B?T0Y0VVpuSjRCc25ROHZab2FWbjM5UUc2K3lNd1pwMTgzalVDWVJyTUh4V3VQ?=
 =?utf-8?B?RUdTYm9SdGJBL1c5MmRYdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWxTVjd6MnJnbG4rVytWdExFVUkwRFBVbmNTYllZeWJNdWpCb2hodlBsVlpK?=
 =?utf-8?B?ZHB6M3RNYXBzYnRQMHpuTUxWODRBQm5LNStHMk1UY3dwbTBUTFF5SVFoZEJ0?=
 =?utf-8?B?SjNVbFZ4UUl3cUJTdFlxSEswRW5EWFhDS2RjZVIwYUFHSS9wSCt1VzQvVVNL?=
 =?utf-8?B?cWUwRlRwZTNqREpnMEduYkRKOWVuQVJONG53Vy84NTcraFVqb3o3NEF4ZXR3?=
 =?utf-8?B?dDJtUFdNM3dwaDVxM3Q1YzNuR01zVFIvbnlrd3hwZHo3WUl5c2RsaVdQZVN3?=
 =?utf-8?B?SVN6dTdMbUgza043WGtLb3ZaeENGVnZtdUJYSFZRN2VobE5rcWZra3NjNjRy?=
 =?utf-8?B?QlBFalRWZzhaQWYxMG5hWk9DZk5wNW9ESnQ5eDNqazMyVW41UjJqOEJYNEMz?=
 =?utf-8?B?Sm9FblVoWlNxa0FSTTYvem1PbDJmcHYyNWZaaVM0aFh1QmxGRjYrNk9Fbnl1?=
 =?utf-8?B?YTFEb3gvcUJOUTR2cnZ5V0MwSzdwUHprcmtkS1V3ZU9LaTRaSEhGa0puWUVJ?=
 =?utf-8?B?VlZQTTN3NHlGaDBzdHlxcUttTkYrdU1XMEI3NGVSdHlZeVg0RkFyUms0Tzkr?=
 =?utf-8?B?QTJMdzBGY1RScVYxNVRWeWtJYStacVRvOW9qck4rdnJiTWdZc1UyOHdidHQ0?=
 =?utf-8?B?alZWRE1DWXk1citvcC9lbmN5bzZ2dGtkdnBSM2k2TmRUZmlCYUZoOFBZWmtp?=
 =?utf-8?B?RFZHeElaeDFhcUx1OGF6aTJlSkdnd0Q3YkxNajlZRlMxYXJmU1k3VWR6bEsz?=
 =?utf-8?B?R1JUbmJoaldpWkpERTBvREdFT2pYOUtnWjl6ZmM3NEtPc1NFNy9SWldhUDJ2?=
 =?utf-8?B?RXlOZHVDV0tkQm9mUDBxTTdUTGpRS1NMN2VWWG9EY0M5NHoxU2ZDQUpqWmRN?=
 =?utf-8?B?OVFBc3I3bXVua2pGK2hXT3VQWEhOU2N4RElpL3dsLzJMT0U2dHBORW9hQWZz?=
 =?utf-8?B?Tk84WTAzOGR0SjI0ZmowVE5PQm1uU3pRZ3hkTGtSSkkwNGtkdFF1eXh5OW5Y?=
 =?utf-8?B?TDdkZEFzZHVZcW1RSjk2eXlvazNZdVFYSU9CekZ6ZUdUQ2M3VlBrdUg5R0tJ?=
 =?utf-8?B?cmc0OWdUMFdjV1E0Njc0RG1adDFjNzk0aHdlNEVsUUdrVVRJSVRUT0pWQll1?=
 =?utf-8?B?eFVjeEU5NkpmTzg0QllHc09nNGdVMGNtUmRyeTl5cTErQ1M4VlhKODEzaFlo?=
 =?utf-8?B?ZkVPV0hwU0dab0JVemdBa2laeFBpRDg5QmUrbzRnb0pubjRCSy9sUXlTbDFv?=
 =?utf-8?B?VTFDTVBFY2pRZmdNVXFBakRwSFIyd0hOMlk3cWRZNjlTTTlvbVViYzJWUU8r?=
 =?utf-8?B?bkl1dmF2ZFR6SkxjQUFESWs1VEh1VjJVc3JNalJ5dFFBa0xVSHdrT1dWWHI3?=
 =?utf-8?B?cFk3VUhad2xVTkNURWV5dUhseEw5eDduencrdFR6dmNCWHZLa2E2UytpTGxT?=
 =?utf-8?B?WkVwNWNPMVhUamo4dnhXSWxhcnN3cW1FUTBabDFjZ1pRbTdaS2JCeWkvejFV?=
 =?utf-8?B?YWxIcEhpT0NzS2ovWWo3ZU1IQ3NRVXgxSE1lN0lSZG05VWtjUWlRa05nYXli?=
 =?utf-8?B?eE1sT21CTnMxcnoxMnpVclJQTURQY3ZUakZ1L09KNnlxNGdseGhKZklMWGl2?=
 =?utf-8?B?ZmR4Uk15WHpMV0pidjFaWm1uSVZRaTNreVdMUGlKZHlpbmlJN1FSUHVwT01a?=
 =?utf-8?B?TTN6SWNvWGVXWHY5M2ZrdHF1TEgzalMvMEZSeGgrN21Ja2lYRmhwNzBud0dw?=
 =?utf-8?B?N2lCMzNEL1JNZ29kREJabkJCTTZLR2FGUWlUOUIrUUxpTFVtNXc3YkloeVJX?=
 =?utf-8?B?UU5wVjFZNi9nMHhFYnFjbDNNNXh1Wmh6ZUJLOCtJUGZqd3VPK2NVajBnL2s3?=
 =?utf-8?B?OXV3b3F3ZWMyanFIRTNSaUplMTgrRXJWSEtNMW5CaUs5ODlZb2k0cXFrUkFE?=
 =?utf-8?B?Q1R4Y2FuVy8xYkJqdmNiemhzUkZCaGh6KzRhQkdMQkNDcENyNzRZcVU0Nndl?=
 =?utf-8?B?cHRpV0IrcmNRNEw3b3kyVzRRZEpvZDJJdGNYclVHRnRBUGxZWkR1N0tEMnlF?=
 =?utf-8?B?RkpWaFpNdEUrV3d4NlgrNEdiOFJBVklFV29wWFVMcWNmdC9ZK0U5TlhSQWhm?=
 =?utf-8?Q?zXEw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15da5cb9-b881-4c09-f46e-08dd1504f2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 08:15:15.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jx0e/mYe3F30nSAhFUr9mIrTTva6WQR6eyVfJhdeeizfG26BMvwSzILXsC1jpB0YkhztV5fi1bqv92GukRZ5/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgNSwg
MjAyNCAxOjIwIFBNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJh
cHVAYW1kLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiBqLWh1bXBocmV5c0B0aS5jb20N
Cj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgamFnYW5AYW1hcnVs
YXNvbHV0aW9ucy5jb207DQo+IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1hcjFAdGkuY29tOyB0cmlu
aUBrb25zdWxrby5jb207IHNlYW5nYTJAZ21haWwuY29tOw0KPiBjYWxlYi5jb25ub2xseUBsaW5h
cm8ub3JnOyBzamdAY2hyb21pdW0ub3JnOyB3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTsNCj4g
c3RlZmFuX2JAcG9zdGVvLm5ldDsgcXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlOyBUYWthaGlyby5L
dXdhbm9AaW5maW5lb24uY29tOw0KPiBwLW1hbnRlbmFAdGkuY29tOyBnaXQgKEFNRC1YaWxpbngp
IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbXRkOiBzcGktbm9yOiBF
bmFibGUgbXQzNXh1NTEyYWJhX2ZpeHVwcyBmb3IgYWxsIG10MzV4eA0KPiBmbGFzaGVzDQo+IA0K
PiANCj4gDQo+IE9uIDEyLzUvMjQgNDoyOSBBTSwgVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdy
b3RlOg0KPiA+IEFkZCBTUElfTk9SX09DVEFMX0RUUl9SRUFEIGZsYWdzIHRvIG1pY3JvbiBmbGFz
aGVzIG10MzV4dTAxZyBhbmQNCj4gPiBtdDM1eHUwMmcuIEFsc28gbW92ZSB0aGVtIHVuZGVyIENP
TkZJR19TUElfRkxBU0hfTVQzNVhVIGNvbmZpZywgc28NCj4gPiB0aGF0IGluIGRyaXZlciBtdDM1
eHU1MTJhYmFfZml4dXBzIHdpbGwgYmUgYXBwbGllZC4NCj4gDQo+IFdoeT8gV2hhdCBwcm9ibGVt
IGFyZSB5b3UgdHJ5aW5nIHRvIHNvbHZlPyBTaG91bGQgd2UgaGF2ZSBhIGZpeGVzIHRhZz8NCg0K
VGhlc2UgdHdvIGZsYXNoZXMgbXQzNXh1MDFnIGFuZCBtdDM1eHUwMmcgc3VwcG9ydCBEVFIsIHNv
IHVwZGF0ZWQgdGhlIGZsYWcgU1BJX05PUl9PQ1RBTF9EVFJfUkVBRCB3aGljaCBpbiB0dXJuIHVz
ZXMgdGhpcyBzcGlfbm9yX21pY3Jvbl9vY3RhbF9kdHJfZW5hYmxlLg0KQWRkaW5nIHRoZSBzdXBw
b3J0LCBub3QgZml4aW5nIGFueXRoaW5nLg0KTGV0IG1lIGtub3cgaWYgYW55dGhpbmcgbWlzc2lu
ZyBmcm9tIG15IHNpZGUuDQoNCj4gV2h5IGRpZG4ndCB5b3Ugc3BsaXQgdGhlc2UgMiBjaGFuZ2Vz
IGluIDIgZGVkaWNhdGVkIHBhdGNoZXM/DQpTdXJlLiBXaWxsIHNwbGl0IHRvIHR3byBzZXBhcmF0
ZSBwYXRjaGVzLg0KDQpUaGFua3MNClZlbmthdGVzaA0KPiANCj4gUGxlYXNlIHJlYWQgdGhlIGZv
bGxvd2luZyBiZWZvcmUgc3VibWl0dGluZyB2MzoNCj4gaHR0cHM6Ly9kb2NzLnUtYm9vdC5vcmcv
ZW4vbGF0ZXN0L2RldmVsb3Avc2VuZGluZ19wYXRjaGVzLmh0bWwNCj4gaHR0cHM6Ly93d3cua2Vy
bmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNk
ZXNjcmliZS0NCj4geW91ci1jaGFuZ2VzDQo=
