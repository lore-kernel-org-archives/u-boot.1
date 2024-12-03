Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD08E64A84
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D828895C7;
	Tue,  3 Dec 2024 13:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EPRDCE8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0D789653; Tue,  3 Dec 2024 13:00:48 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806A08958D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzcAzxiFqKsCub+cAy143BP1pvM9qmZl5hcc3bNx0gfAKoSYdAU4sXDIXj/0aF4asP//C9+c7Q9H9P57ZS+RjOHOBFPN2VxwMRxM4yc8LRl6QcwTJly+sv5Zjadlznk0ACvacGTwTcULGFe/Ty/Q+DnVKgFtsQR6OSZETJWJHemGtiGTxvl3TRGx2GDPqzx5Ndc1cKXF1TCqUMxzio+zr0tg7YaHIEQKIPHv29R54mrpRi7LwqeYBudwpClbrrJ/fEc2WmsHP81waKDHHOHzczEulqgNIgGkxgeE+AKAMhuIpa6dcpIeQrv2MwGGSFw1+1AG/n1SfmaQ/0HbmKcNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9+wjXBbIqArSs113pnYI58u6tEdMIhtbk5YfZ42WMU=;
 b=ROfzY76zBHBhyFZZ6sCQlwaDiQQQj5EXZz91P9ZBgAnTNP7zNh5VPBiugzUW96y3sqnJsTdtzPiKgWL6w2uK9GtEI6BRj9ZLG2OPRV4O2fqU8aXXkKVcO5O7ZJb0bFOmpT1D7gZIJWqG+EBShL0s5ISxnYHGlRGPhsbyE7XVM6C/eGdcXnko7OiHlcc30BOxWEjDr9HGdPUF9bZPIkFht4ngyQnaGEDyx/71TIBFmmIsPm/xwLKHsMi7m0JNsB/lw+K68/glSDR3tTlsGePiUp4Gr/8qddPa7LY6j9wHXA12mby/1uSH29mHQoxRlFZhh8qQ8GVUOJu7PhETGVJJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9+wjXBbIqArSs113pnYI58u6tEdMIhtbk5YfZ42WMU=;
 b=EPRDCE8gxufC3SjBFYVZ7AlTLyuM1qXTN6KPMcLp4Wh0r1gnu3Vp+Y951RO/XKRg1JpWrmCKYVD48hnFBgyXQjngaCJK4fLhhqMB1GzpuFWr+jZwOC1MyYajYXJR/Z56kSmVeangmTyYgF92MI9PRc6Ajts5A9GvVMBpmDl5JSo=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 12:00:38 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 12:00:38 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Dominik Wernberger <dominik.wernberger@rohde-schwarz.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "Simek, Michal" <michal.simek@amd.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "vigneshr@ti.com" <vigneshr@ti.com>
Subject: RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
Thread-Topic: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
Thread-Index: AdtFZ8SiMsssq5vATxyiCrnijjyGxAAEs9PA
Date: Tue, 3 Dec 2024 12:00:38 +0000
Message-ID: <SA1PR12MB8697341C5E1388097FD7BEB198362@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <db4086b015cc48f2ad9d9bfe97b338d9@rohde-schwarz.com>
In-Reply-To: <db4086b015cc48f2ad9d9bfe97b338d9@rohde-schwarz.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Enabled=true;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SetDate=2024-12-03T12:51:08Z; 
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Method=Privileged;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Name=COMPANY RESTRICTED -
 BUSINESS USE;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SiteId=74bddbd9-705c-456e-aabd-99beb719a2b2;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ActionId=6120cf0a-b2bc-438e-8b4b-106b503b180c;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|MW4PR12MB7311:EE_
x-ms-office365-filtering-correlation-id: c2facb7e-dd57-47d8-27ae-08dd13921a66
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M3hsait0QU9Gc1NIYUJkQzZtVEZudThyNGpzZ0xKcE1lUE52VFFFc2w0YWMv?=
 =?utf-8?B?VlZ6RkdJYWdCWmVWc3pSMW9MdldJR0VIcnBTc3hqdTZ3M0VJR0hJaDFwK053?=
 =?utf-8?B?b29EV3drQUZpbHZmdVVmQnlsZUM4RlptakRnS0VZMnJEbUxqbHdWOGtqeWlU?=
 =?utf-8?B?WFZWckZ5MkJzcUhnV1EvN3JIbzdyTks0WTNNQUk2enFaVDBjdnJpS1lLRlRX?=
 =?utf-8?B?bGROYjlXSEF3dmc1SjBmRlhsQlllcHNsSHZHazNycVFNc25Sem13UVZ4bWM1?=
 =?utf-8?B?TnNnSWFoV0l6RlM3eWkwZ0ZsWnYrbkUzQ2RpSmcxYTBVSjgzOEFybm5RelJD?=
 =?utf-8?B?djJaNXJJbzd0ZE9kMnAxYWIrNFlHdG9iUVY3ZTVoWDlzWVhKajloVkZob0dZ?=
 =?utf-8?B?V2piOGdDNWhkRnZrN212ay8zWWtNMU9Ta0dkTVk4Y0xIRTh3VmhhdVBjNlBv?=
 =?utf-8?B?ODRxcnFuOGVuTFZrTTBqNXZaN25VMW9uSEVIcDlvNnFNcEY0SWhMV0hzbDcr?=
 =?utf-8?B?ZXowN2ZEUUtoVzM0NDJOQm5pR3IxZkNUeGxvRVJDL2l5T2lESzBiMlI5ckIx?=
 =?utf-8?B?ZHVrN2hPMUZEdXFUWkpLNkluejdaL2Fhd2VvNkh3Qm1mVC9ydFFOOUtvNWNq?=
 =?utf-8?B?V1BSazdXM0c4dTNuSHBVWkZWUi9FS2hCVWZGZzl5QmFpNjlBOEh1TEJRYjNi?=
 =?utf-8?B?bjJsc2RreWI5dG9lYTBYMExaUTI0SWpLaUd6SWhwMzhJcFJ3Vi9GUGxoeGEv?=
 =?utf-8?B?YTVla2d3T2FLc21UeXRNaVJXaGJlbWwzcUNleGRWQm4wWWtkZklTYU9iY0Jn?=
 =?utf-8?B?ZGNmdUlsWWQ1Ri9UOWZOUFJrd1AwR0I1Q0ZRdWVqc2Q1RjdKaEJ3VTF6U1hv?=
 =?utf-8?B?dlI5SlZGelZSdkt6K2Vld3FodTJKMm5RRmkrM1JDZkFCVW9DL0JuaFNOTDRO?=
 =?utf-8?B?YW5RTEdMb0FLcTlsQmgrcXd5TVRvVmYramVlK2dkeWJiajJ1RklSNXdIOENO?=
 =?utf-8?B?bnovTXFPVVBSYmZwSFVNQ01USDVXRWVCaEFmSlZ5MlVsK21RK1pITGRoV3ow?=
 =?utf-8?B?eGREVWdobnpKRnN1VWJVU1hGbE9JZkZ2bUdjb056ZU9KeExhMm1UbFpCYlhS?=
 =?utf-8?B?NGxHTjUxV2RxV3dDLzJtSE9QOTc5Y2ExWFdCNzlKYjhLdUdjUGwzM2Q2dGdG?=
 =?utf-8?B?djhhSTdMclFZZmRsMFA3SU4wSHRkOXJTVDdwVFIxK0hCc2pCbFlEcGtwNmxI?=
 =?utf-8?B?RFF3N0VyZEZJZHRnWVdjSFoyVmxWZEM1WFFkUkhUeFlWSERQVjV6V0c2N1RH?=
 =?utf-8?B?bXp4ejU5am1QR0NwUWxDcVVPTUpGWDRPSzZGSEtyTnRTNzJsUnJ3WDQ1Z2hv?=
 =?utf-8?B?UWdLSmw0cVdCNHc0T2Z1ckhXVlRrdndBTEg4Nm1CbGVZbE1vVVB2cERLUlQw?=
 =?utf-8?B?NzBJTGlHcXh6OUo1M0JqNUgvTC9XQVhBRzNJZlJUaVdBbWp5cCthZDNhOFpp?=
 =?utf-8?B?ZWJnNkJSMitzVGpsU09MQWhDYzZkWUUyK25IazBHeVRrS3F5bmZ1b0hMdXg1?=
 =?utf-8?B?THM2bnpHY2VYNjVkNjBtMkxPd3NGZnRvdVRPcHJZdHBLWEdsTjNhaG1oS3hz?=
 =?utf-8?B?T1RWYjFjVjllZmFqWklPaHlTTnhZUEphMXFLQUk3Z1FHV0E0cHhlSGQ3bjhY?=
 =?utf-8?B?cGEramdwVUVOZGdTYUdNN3lWTkNRNW9VRTdYSFJUdTdpV1JwUzFwY09VWUZx?=
 =?utf-8?B?U2JNMVNqUEhvSXQ1dGZCQ1NXOW9nTjJHS3dUVk5tblczWEErVFp2ek53VGEw?=
 =?utf-8?B?UWNWeEUyc3Y3TnhlV2hkekQyTysvbkdvMysxMWJhc3pDNGUvWS8yVHluOWM4?=
 =?utf-8?B?aXl6bzZuaHkxS2FhVjBuNlpDQlc1dzNqZ0ZLUi9zU01nemc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3d3YjhVSkdtT1FRV1ZDVnU0MXZEdFJrR3Z1NkxNSDE4UkQwRk02ZFQxRVI1?=
 =?utf-8?B?MUplZ2RCcEZTY1hhWHRrakxxUi9rVkcvazNVcU1Xb2UxeGQ3UE9OK3MxdUpn?=
 =?utf-8?B?V1FlMGlsK1lBRlpaRURLNnI1dW1uWWMrNjBvbUxBMElNeHdGS2xVTEVvZE16?=
 =?utf-8?B?cmY2MWhmL2tyZDl5WTdRQnREdncxMkEvdG9UK1ZiUDY2NFJpVm5kY3ZSQjFW?=
 =?utf-8?B?dndCTTE0TkhRT0VOaTQwcDR0c3ZpMHpaZWQ4M29ERWJsdU9tQWthbEtLUld2?=
 =?utf-8?B?SFBCd1pmWkJtMVBYajM0STZpSzBEdUNyTCt1b3NCa3pvbStaZEJyMStwZWd2?=
 =?utf-8?B?cEE3UWYwWU9XZkNEaEVhck5GaDhoWGY3Y3VZSHZrMElCdjFQNVNYR1hVOW81?=
 =?utf-8?B?cGczak5BS21lUkV1bHFNbzYzMHVRc3ZrL3M1dGZTN09oNGZpb0FPZFdaUmVu?=
 =?utf-8?B?MTNYSXdYWDBjcG1ueDFsYmhzeTRxbkZmMlVoRkJPSG1HTXRVLy85SFkwcHM3?=
 =?utf-8?B?RWY3TXB6a3V4L1g2VGsxd2NiQnZMTHhScDRqZkNUSDIvYmt0YTR3UDJMNXFZ?=
 =?utf-8?B?aEFNazlocVlsU1FyRkw1ZG1ETjhJc0lReWYxdS9iYmpuTStGRE1sc3piY1o4?=
 =?utf-8?B?d1h4bmJmMEtnU1FtL29mN0s3a2ZnMXBxRTVndUVqQUk5MTFXS2o1MG9LN0Ni?=
 =?utf-8?B?cHpuTEtjM0k2amswYjJReDYzdjB4blZIZXJVODFsSnpWL0U1K1hnankvbVM4?=
 =?utf-8?B?R0NjVVJNZWlqZHFLRlczYmF3a2kzSUFGQzNpWmRZWWFNS0x5SmljUXNDdzRv?=
 =?utf-8?B?QlFxdzRxdXRkSzMzaDBtSkxyWTROaUg2a295WENwblI1ZDROd1lFaXMwK2lp?=
 =?utf-8?B?OExONFk2ZXhVVXRVakJodEc2WUh3UkYxUWd1OE5sUXJQNjR0aVNVTzhxSTBx?=
 =?utf-8?B?Tis4UUNSTUJBMEZicnd0V0Z4cXpIT1BHdFA5cVVkQTg5MHdhL2g0UVZRelJ1?=
 =?utf-8?B?L3RvVWV6MDR2bFROZ2dGaUNPbXBFVGxSam5JUm1wVld5U0tqYmtqclRLTHFw?=
 =?utf-8?B?Z044dGE4Qnh4cnJSN2czcnJmUDdQbzZpOEJrVVNTaWxuSEc2a1NUbWhpdUNx?=
 =?utf-8?B?VmZkcXRTYzlLSitzRlRoU09pOEdhQlhvSDNxOGZzUTFWYUZmNDJnZFlGbkZk?=
 =?utf-8?B?NDd1QXRSY044ZGtqK2ZrNHZFM1ZUV3VoTXdBaGVEcXBaTVhkcktDQys4RTEw?=
 =?utf-8?B?VnBmREhWM04wY1FEV2VMdDBuMnYvN25qUkJlTFFOY3I1NUVDNjFiMXYwZUdG?=
 =?utf-8?B?bExURVRPVmFQU0ZQZXp2VnRjOW5lMUhpbG9mMUlyNHRMOTBKT3ZhWU1MVkZo?=
 =?utf-8?B?aDZCQWdWVFBYd3oyV1V0dFJ6M0N1SXYrT0RCa2JDMWRzdWJiRkZaaFpZNmtF?=
 =?utf-8?B?MUo4bUNsQzk2cDduS0tIRThHZFdPZkZVb2lPbGduc3pZcXdqNVFYUmhaeEFr?=
 =?utf-8?B?dlo3bFlKT0h4VVBhSmx0bjd2aXhYMTc4NnRBQ29Gb2lqT2wrZmgwVEJ5bHJV?=
 =?utf-8?B?MGVDbnFPc3FjNnFlbzRqUkJGK2lPaXRaaHYyekVZaGR4bnVXeVFoendNc0RQ?=
 =?utf-8?B?Q0ZrdVpzam1iWVIxSnNHaWxOdlBBclJxSEN2RzBFNUlnU0kwcTNwa25kNTJz?=
 =?utf-8?B?VUhWYXFVeG82eFdCWHNGemFYY2xQZW5lbktId29ZTjMwMGswY3dTU3hGeHBs?=
 =?utf-8?B?VDhmeldRbmVHaDEvMWZ2blYycllqbFROVFFEWGJXaEMvV0wwTkVZdXcraUo3?=
 =?utf-8?B?U1JMeWl6Y0VMb3VvUm5EM1FNZDh5d3VQRWw3ZkdnNExJdmdnUUNqY2hMMjdn?=
 =?utf-8?B?YU56V2pjNE9PdmQ0dVlXMEJOQ3haL0xMRUczU0lCRnlTUEhLdHJYb1VSQTZh?=
 =?utf-8?B?b1dtZUhNRGpwUnpWQkFQV3N1U09Xa2lIdFkzbzBEWEo0NFBpU2loblhNNHYr?=
 =?utf-8?B?OVlDOGlObnFBMnBxMVNkdzJTUFJJMktSajJaemJCRDI4bTdCbk9jVnFRVjVq?=
 =?utf-8?B?Y0NnbUJ5Mkl3TE5pbTVFTDFEcU0xWEhvUTI1TWxEdDZ6QjE4WmRjVXhBYzNU?=
 =?utf-8?Q?QZos=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2facb7e-dd57-47d8-27ae-08dd13921a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 12:00:38.5020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+0Fpv9jvZnCeSvyZ/nx8rdJg0bnYpqgX7O3TYQljjYb3IWqOYbSDj5GUF3Vr+RneJYdzFly94MwkvOoXtv8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgRG9taW5paywNCkNvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgdGhlIGRldGFpbHMgb2Yg
dGhlIGZsYXNoPyBJIHdpbGwgY2hlY2sgZnJvbSBteSBzaWRlLg0KDQpUaGFua3MNClZlbmthdGVz
aA0KRnJvbTogRG9taW5payBXZXJuYmVyZ2VyIDxkb21pbmlrLndlcm5iZXJnZXJAcm9oZGUtc2No
d2Fyei5jb20+DQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAyMDI0IDU6MjEgUE0NClRvOiBB
YmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT4NCkNjOiBnaXQg
KEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBT
aW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IHRyaW5pQGtvbnN1bGtvLmNvbTsg
dS1ib290QGxpc3RzLmRlbnguZGU7IHZpZ25lc2hyQHRpLmNvbQ0KU3ViamVjdDogUmU6IFtQQVRD
SF0gbXRkOiBzcGktbm9yOiBGaXggdGhlIHFzcGkgcGFyYWxsZWwgbWVtb3J5IGlzc3Vlcw0KDQpI
ZWxsbyBWZW5rYXRlc2gsDQoNCklzIHRoZXJlIGFueSBuZXdzIG9uIHRoZSBzdGF0dXMgb2YgdGhp
cyBwYXRjaD8gSSdtIHdvcmtpbmcgd2l0aCBhIFp5bnEgN3owMjAgc3lzdGVtIHdoZXJlIDIgRmxh
c2hlcw0Kb3BlcmF0ZSBpbiBwYXJhbGxlbCBRU1BJIG1vZGUuIFRoaXMgcGF0Y2ggaXMgZXNzZW50
aWFsIGZvciB0aGUgY29ycmVjdCBGbGFzaCBlcmFzZSBpbiBVLUJvb3QgdjIwMjUuMDEtcmMzLg0K
DQpXaXRob3V0IHRoaXMgcGF0Y2ggRmxhc2ggZXJhc2UgZmFpbHMgb24gZXZlcnkgc2Vjb25kIG11
bHRpcGxlIG9mIEZsYXNoIGVyYXNlIHNlY3Rpb24gc2l6ZSAoRkVTUykuIEZhaWxpbmcNCm1lYW5z
IHRoYXQgdGhlIEZsYXNoIGVyYXNlIGlzIG5vdCBpbml0aWF0ZWQgb3Igc3VjY2Vzc2Z1bC4gSS5l
LiwgdGhlIEZsYXNoIHNlY3Rpb24gaXMgbm90IGFsdGVyZWQuDQoNCkZvciBleGFtcGxlLCBsZXRz
IGFzc3VtZSBhIEZFU1Mgd2l0aCAweDIwMDAwICgxMjgga2lCKS4NCg0Kc2YgdGVzdCAwMDAwMCAy
MDAwMCAjIFdvcmtzDQpzZiB0ZXN0IDIwMDAwIDIwMDAwICMgRmFpbHMNCnNmIHRlc3QgNDAwMDAg
MjAwMDAgIyBXb3Jrcw0Kc2YgdGVzdCA2MDAwMCAyMDAwMCAjIEZhaWxzDQojIC4uLg0KDQpOb3Rl
IHRoYXQgZXhlY3V0aW5nDQoNCnNmIGVyYXNlIDIwMDAwIDIwMDAwDQpTRjogMTMxMDcyIGJ5dGVz
IEAgMHgyMDAwMCBFcmFzZWQ6IE9LDQoNCnNob3dzIE9LIGV2ZW4gdGhvdWdoIHRoZSBGbGFzaCBz
ZWN0b3Igd2VyZSBub3QgZXJhc2VkLg0KDQpJbiBjYXNlIHlvdSBoYXZlIGFueSBuZXcvcmViYXNl
ZCBwYXRjaGVzIHlvdSB3YW50IG1lIHRvIHRlc3QsIEkgd291bGQgYmUgaGFwcHkgdG8gZG8gc28u
IEknbSBsb29raW5nDQpmb3J3YXJkIGdldHRpbmcgdGhpcyBwYXRjaCBpbnRvIG1haW5saW5lIFUt
Qm9vdC4NCg0KQmVzdCBSZWdhcmRzLA0KDQpEb21pbmlrDQoNCg0KQ29udGVudCBwcm92aWRlZCB3
aXRoaW4gdGhpcyBlLW1haWwgaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cywgaXMgZm9yIHRoZSB1
c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudHMgYW5kIG1heSBjb250YWluIFJvaGRlICYgU2No
d2FyeiBjb21wYW55IHJlc3RyaWN0ZWQgaW5mb3JtYXRpb24uIEFueSB1bmF1dGhvcml6ZWQgdXNl
LCBkaXNjbG9zdXJlLCBvciBkaXN0cmlidXRpb24gb2YgdGhpcyBjb21tdW5pY2F0aW9uIGluIHdo
b2xlIG9yIGluIHBhcnQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGVt
YWlsIG9yIGJ5IHRlbGVwaG9uZSBhbmQgZGVsZXRlIHRoZSBjb21tdW5pY2F0aW9uIGluIGl0cyBl
bnRpcmV0eS4NCg==
