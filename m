Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACECE9D48
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBFC83AC5;
	Wed,  7 Jan 2026 13:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qWovN5Qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5944583B82; Wed,  7 Jan 2026 13:17:55 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8257C839F1
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 13:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AK6QnTRNRihkeeDa4dmqom8mKahPMme3TDaTwkiJRUeQdoiW4bTz7NwkHivHV36f+erACy2n4gCSLGt3Dcv3LyQ8ocE9ZeF8ekGwj8BDp0wdNVl9SWleIlEHmacC//SGBdeV9ciRYvBX/k/TNiVbhdWkD27pA9RpumApDbirQwIB2VrT9LQmmVo90QAysNYSXHe1GSctkcrSw5KgdiDvfDhXLrP+5Citkb9Vou5+jUmFf2crAuv6y2EhCwi8SNhyVqsYOffyQngzZkwZy757VTOn6zZDxOqTZcL/lkI7L0WSUFo6YTJkSLhr3a6/mgeBJ265eUStKNDXrX0YdrW/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2FllCFt4yomTBFtLeQcSY1wIEPeiXt8j43G/EFwwMQ=;
 b=FZ+DxmsL1Jci3VgOZ2M+RkPKS2kLsNSUW2icQXPAfHnCBio/p7LJGIsUKhWAf3QTs3o/w5fVfV0FfGhOfa8IsOdpjb7+XjaFJ7mGaGgQ259ThvCa7X2UL+jWEuRtshWnzEQl0LAmF0g/Gb4Y1pSqW+9G4by2msKP0BpRilG+nVHg4hlDnEolBHnIU/It1z55rZ2AO7kuNsAV8c2CpRgogPdwTwaeQSO7Xs/fuXyaEIlcQtvhxpPy+ii7drJoB+/dsWsCd9xQaxGpxbQufxvFypUV8j5DTo1tQ547eSBR9RgMz4RY4bIniVypxJLVw3XrZg09WYRgcjASfsp7LJBtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2FllCFt4yomTBFtLeQcSY1wIEPeiXt8j43G/EFwwMQ=;
 b=qWovN5Qb0TOy0DK9Xb0gY/BHJlh1boXmqxjFsHrb0U/JhBTPs2XGLhVB7PEaehy0dm/lh7/WMyUsrzxZj8rHBmoXu7uubpwTY21FO4d5lLxxnFIJijU2VZigsffqL8lOVfPS6fg+4upA/+GzpJhv3L8YdxN6WIyCJkUBh8NoJpo=
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 12:17:49 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 12:17:48 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: Tomas Melin <tomas.melin@vaisala.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "igor.opaniuk@foundries.io"
 <igor.opaniuk@foundries.io>
Subject: RE: [PATCH v2 1/1] board: zynqmp: add cmd for getting boot auth state
Thread-Topic: [PATCH v2 1/1] board: zynqmp: add cmd for getting boot auth state
Thread-Index: AQHcfye7tilhsDskf0+XbDRBcvD7l7VGjy2AgAAPjxA=
Date: Wed, 7 Jan 2026 12:17:48 +0000
Message-ID: <BL1PR12MB5032E0189CDDDD0387830A45F084A@BL1PR12MB5032.namprd12.prod.outlook.com>
References: <20260106161545.2416551-1-neal.frager@amd.com>
 <e8016430-2ffb-477d-b29b-378aeb0ac75e@vaisala.com>
In-Reply-To: <e8016430-2ffb-477d-b29b-378aeb0ac75e@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-07T12:09:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5032:EE_|LV8PR12MB9135:EE_
x-ms-office365-filtering-correlation-id: 5eb15ef7-547f-4325-5c9b-08de4de6c5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?utf-8?B?YWlzR2RYZXJaODhrTVIzR1c2dUlHZ2dDRWZZOW1vNmxXVld6VjV2NmxFaTJK?=
 =?utf-8?B?aG93VGFqZ1ZFTk4zSjlNMXREdGk4Q1FXRDRacnV4N1VLYzBYR3dKYnFnNXZF?=
 =?utf-8?B?a2xTZkRTYmx1QUFZRXJJRXU0Vkx2cTdXSnpTOXBiWXhEYy9GM1R5ZmcwSllB?=
 =?utf-8?B?OTlwbVZITXIyT0p6RjRpOXRqcklHc044bmU2VmdTcUhPT3BUTDJ5SlRvc3VQ?=
 =?utf-8?B?MUR1QmZpM2M0bWhTVHJrZ3pUZTVJeU5hczdhSEh2UHhyTjRiMVFmdU1vUFNx?=
 =?utf-8?B?RUs3STdSUEFpNFdSay82M0l2U01JWHcwNEw5NG5GMVlPNkxMbC83YmZuRElr?=
 =?utf-8?B?WTZKZVJTbGJtejdMRnkwTUVTRkNXVFlGU2hSUDFCa2hkNksxdFZGd2dnczZt?=
 =?utf-8?B?aEN0Y1lqR3h5YWhId0RZUWdUcVd2MjNNMWdndC84S3l0ZURzdEM4d1BibCtr?=
 =?utf-8?B?eXVRQ2hlbGhQTWtBdVAvWXVuc3JRSkJZQ2s0bFBTVGF5YmZ3ZFZLU0hVT1BC?=
 =?utf-8?B?UUw4Uy9RbFFxRTBOOEZnbmtPQlRmK2wrd1JZRitFT1I5TEhyeHdydjNHTjdn?=
 =?utf-8?B?czNJTXhTVW9GdUhpeXpBdjZNN1pEaXovWnZGTTZiTnovY3J2STJMRVh1VGo2?=
 =?utf-8?B?SVFkTFB5UWM0TFRBV21KaGRsVEpNVEJyT0xWcytaVWJ4TkEzQ3A3UExKa0FR?=
 =?utf-8?B?STFycklZZlhSOTF5d0Q4VGZpZHNVZzQ3RnZsSzdta2lkS3Nrc1NzVmorSzI1?=
 =?utf-8?B?ZmRLbSt6VWpHTjVkY0I5ZnZRS3VtSXFraGl3UVlDdGM4TitrOFVaemtIVU1D?=
 =?utf-8?B?ZEZJT1JhWmpXNWRLRVI0Tlg4RzB2bCtPcUF6Vzl1S3R6T05YS1JSWHZHc2Q1?=
 =?utf-8?B?Skxaa1RPWms1dEFPZk4rTU5ENGxJRUR1NE9LakZ0RU43bEJzSzFWYTI4SFNh?=
 =?utf-8?B?UXhhYmZLYndhS2tvSTBmQVpTTVc3N0hacVQwZExhbW5uY1h1aXdad2hFYmpS?=
 =?utf-8?B?RThYV0lYZDRQdUhIa2dJZEg4WHN3SkNaUjJZdGs2TnpuWWdHUnpLdEQyWnZz?=
 =?utf-8?B?QkZBR1hDd1pXN3djZkY0LzBNcm85M3orOVpYdXRNWUN6R2FUZFc5SGxaMGJZ?=
 =?utf-8?B?MEpIT2lIejh3TmlwOFMwQ1AvUzUyTlZNTDNZVlNrblNnSVp4Ky9QeFFvQU4x?=
 =?utf-8?B?amI4UW5QekpwN2hLN2lyb3h2R2g1SjJxVDRtaVQvTVpEYVlpL0h3eGwyZjV5?=
 =?utf-8?B?czF1NHk4dXc3NzZhdWZ1b3JVeUMrTXJhVzI2QnNUL1MwQy93Ty85MWRFM05r?=
 =?utf-8?B?cGR3RkRlSUZ5cFM2RXFhajVBZGZIQ1RrVHBWWDRlandneVRBMnk3Nyt2RjJs?=
 =?utf-8?B?RDVTa1Y3SFJJdndZRnQyWjgxZEc1SWg4OG5kTmhvQ0ZCNExHNTh0TmN3V1Nk?=
 =?utf-8?B?V0VRN2YySHVyWk4xLzVuUWVpcC9UL0s3QUxVdDFDUnBFems4UHRLVkVmSzlk?=
 =?utf-8?B?VXRxZ1BSYlNENU9qT2hFSFpocDRVUnZWczN0ZTdTM2l1RGY4UDNKR29Ca1F5?=
 =?utf-8?B?OHFCTi9GVnkyL3oxaktnL0ZpVTdWMWxubWU3dVhhWUoxaXhNb1FXTjc5dEIv?=
 =?utf-8?B?eEoxYXBGa1JOL09aWFJ6NGNvUXVMdjBicnpJTTYrZDFtdzdiU1QrOW1kNlBM?=
 =?utf-8?B?VVN3anVGSUlSdS8yUkNpWEJ6UTh3TlQwaDVzV3dhbnIzUUZ2N2swRE42R1VE?=
 =?utf-8?B?VHN3OWEraVJQTjB3YldvbndxQklTYVVubE5FVXZIaUo2a0ZIMFVVc3F0ZUdW?=
 =?utf-8?B?N2JpNFhuNHVrb3FrVWhtRUJxR0NqOUZwZDQxdVJXSldDRWR2bDZzeThpbmRw?=
 =?utf-8?B?a3Q2ekhwclZXT09FS2ptcVJnQ2pZMFBGdWVpcHpLUTRjUjRMTGVNSjd4czJz?=
 =?utf-8?B?TkhySjFYUEUyTEpQNGlRNFNDR3BnZ3RLU0JrL2prZkF1SG9PSE9CMVBwdTlm?=
 =?utf-8?B?UTZlMkJUWW9reGR6eDBxS2hCaGdVeTdNR0tzWklhbXpDTkJ2YUN4MmpqSEdJ?=
 =?utf-8?Q?psRHFC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7142099003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjVPRHNrZzEvZmNUL0RrdDJBV050VlNsME94cGxoaDNOdzBjcGJGbU1pblYx?=
 =?utf-8?B?SjhsNXNPMTlETkZQTEUvakd0QVEwcWVITmxIZ1AzVDRTbjNLS3VrM25SVmgw?=
 =?utf-8?B?YmFGWVBxZ05QNVB3elByS1k2KzlaeFRGaUNGWlhpMGxIOFcrRG50UTZmTm8z?=
 =?utf-8?B?eHJ6Tk5wU0xsMXhwY3RGalFhRy8xeTZYRkh4Uys2cy8yY25HeXpCSytqUFk1?=
 =?utf-8?B?ZmFYWFllc08xVFh3RzlqWUppVHA2RzRQSm5Ob3NhYVdzL2lEalVVTDBoZ2Y5?=
 =?utf-8?B?ZXZKSHFMSEczNUxmNkxaTHlHUE95L3hUZytvTWdkMkEvSXlZKzFicUUrVjZz?=
 =?utf-8?B?eVpVdUtYK2JUZE8raHJCY3NTN0huejArUjB3NHRFTEY2bTlFN2EwZklYeUpS?=
 =?utf-8?B?bnZPekptWXN0d284d0F3ekV2LzNhYmdZK0pTUk5uOUtYM2t6eWJ1Qk8yOC9H?=
 =?utf-8?B?cWMrTDd5UnpxZjVCcXpsYmViVWZERkRGWFBIUmdlVEJEbUJ1bUVGcWpISDJX?=
 =?utf-8?B?TnVUWWF0US9YQ3pvUStyYUNmVG1hQnIvSEhHYkdTdHVsM2ZBWWdUcjRwSmZj?=
 =?utf-8?B?emd0bXlDbFE0c0g2N00zOHFIa0dsSnpaZUFXYmVmRGxQL3RMK29XUlhFbTN4?=
 =?utf-8?B?T0dCVnNWckZISDJNWnI1YktBQ3JMRVc0eUg2TmNTYnZmb3pRYklteGQyRXR5?=
 =?utf-8?B?SjBwMDBPbkY5Zkx1amhaNWZCaW0zeGFUVjhoMnNjWW0zR0JXazllT29pdUIr?=
 =?utf-8?B?SmVzVWZBZEEzSUQrVDNOcUJ3dlI5ZklxNDRNNzhJeXg3bWxKdWtHNmRnS25u?=
 =?utf-8?B?NEZHYmh2eFpQd3psSXBPN0E3b0dBYzRxaVNMMWpJUVJSZWNESFpJLy93aUxs?=
 =?utf-8?B?VmNtWEtHb29SWFB2MUJ5QTlOVEZYclFlU3c3V0xJVklwbmtEN0NNUjNBczJk?=
 =?utf-8?B?MU1aUGdmbmpZR2IwRWpLOEJXQXdYeTJKdGtkd3BsYldvZlEySGFLckJNNWxs?=
 =?utf-8?B?OGRyVlZSdkJ1LzFyNE5WeWgxaFhTZlNacVJmSGp4WjlMM0p0TXN6RFNpelVh?=
 =?utf-8?B?S1p2NEhrWHlMMWtVc1BuQTRJZ1h6MndIN3RNK2xZb1l6TmZ2T0hqWFZlTTJX?=
 =?utf-8?B?TStSNy9XVUd6OHN1MDhhS2JueEMzaTE2V2tIVVlVNkptRmRrTStLb3hqenlL?=
 =?utf-8?B?bDE3ZmZkMjZ4VmNwUW53cXZ1VkJMQ1o4TU11WDNGYW1YWU1hOGVYQk0yVGp4?=
 =?utf-8?B?dHMwVTREaFY4S0ZFN3ZwY3NDRUNvT0lyQlhiYlF0NDYrUGFCNEJTWllIenVx?=
 =?utf-8?B?ckhocStjL01MWEVZbDhXQnhuZUQwZkpqWFV5UmRZc2RYd1RnaytXaHM0Sm9I?=
 =?utf-8?B?U3lRbFRQNjYzUDRlc0w4K2xXZXU1eDZudzFJcHp1TklXdXR1Vmg3MDZISE5M?=
 =?utf-8?B?TCt2ck0wVmtQbHNReE50RjRiWmFhZktNWmdwSExJNXFZMmpUQW5PUVN4aHZJ?=
 =?utf-8?B?cVpPK3dNWVdLRlpGOXlSVlVTT3gyWmZKWDZRN01ySFZUVEhLVFBKYTlZZm1G?=
 =?utf-8?B?NXFlU2d4OWVEaXkvUUlCYTh5RGg3NENJR1dEa1JnQ20rdGx4MlF5V0tHalJG?=
 =?utf-8?B?ejRUV2RvcU5Cb3RKQWxWdjhGVmpYenFoYkJDOTlQc3I5UFJrSnovM00yaVJk?=
 =?utf-8?B?Qm5wRis1MHFyMW84ZDhDcUFYVlU0cGJOSnduYkUwdEJhRDd1WVlHQ25uVGR4?=
 =?utf-8?B?WG5MLzlHNVRaSVR0RlI0N3huNFZqSjRyVEVNdmRkWVhoV05GS3RycmE3WlJ4?=
 =?utf-8?B?S2xhY21IWXo5TlRVQmZpdWdlZkllS2lnZXB3SXFsWTUzanBYZy80YU5BUk1n?=
 =?utf-8?B?K2trTlBsWWdsQVB1RVlncE1PeCtubzU5NUdFZG5iQitpWDlTbXJwc1BrdFZz?=
 =?utf-8?B?dFJ6TVIvMDNBTytwRng1S2RyS1dSSERlMVV1MlhiNDdSYVBEOTZUYU1CWXEz?=
 =?utf-8?B?WjNsNE5aUEdPb3hWYlFnZjdvK0hDKzB3Yk1SVHk2R1preXNTNUVIYkF2Z2VR?=
 =?utf-8?B?RmNreXJyZi9iQStHd29DcmlkZEk1QUozS1hSdHQvRGs0bERzNWQwQ2hkTXA3?=
 =?utf-8?B?dGZXb01HRkNoWjcvcEs1MjN6dFJvM3NqSHlXc1RaZFF6QU9MNFdyQXcvdHFC?=
 =?utf-8?B?M0J5YWlxUXBtNEJHUW9XNWU4VDM3cmRjbXFPZS92RVBpTHcrSnR0SHNodFRO?=
 =?utf-8?B?aVdxU2MwZThJR0dHT1FnblR3LzNqdzFyUVpnWVpOU25UKzV5ckM1a21PWTZ6?=
 =?utf-8?Q?VOWSaqx6Wm/Fbt4Gtl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb15ef7-547f-4325-5c9b-08de4de6c5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 12:17:48.7454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUp0PWCrj7BO41VArO0Pc6DaBTCEDrVUM0iDy6aNxMsKGU7oBRPsQU67BcMqChgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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
Cg0KSGkgVG9tYXMsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiBBZGQgY29tbWFu
ZCBmb3IgY2hlY2tpbmcgaWYgYm9vdCB3YXMgYXV0aGVudGljYXRlZC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAZm91bmRyaWVzLmlvPg0KPiBTaWduZWQt
b2ZmLWJ5OiBOZWFsIEZyYWdlciA8bmVhbC5mcmFnZXJAYW1kLmNvbT4NCj4gLS0tDQo+IFYxLT5W
MjoNCj4gLSBleHRlbmRlZCB6eW5xbXAgY29tbWFuZCB3aXRoIHZlcmlmeV9hdXRoIHN1Yi1jb21t
YW5kDQo+IC0gY2hhbmdlZCByZXR1cm4gdmFsdWUsIHNvIGl0IGNhbiBiZSB1c2VkIHdpdGggc2Ny
aXB0cw0KPiAtLS0NCj4gIGFyY2gvYXJtL21hY2gtenlucW1wL3p5bnFtcC5jIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNo
LXp5bnFtcC96eW5xbXAuYyBiL2FyY2gvYXJtL21hY2gtenlucW1wL3p5bnFtcC5jDQo+IGluZGV4
IGMwMzk4YTQ2NmZmLi5iMTVjMzE5MTljNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC16
eW5xbXAvenlucW1wLmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC16eW5xbXAvenlucW1wLmMNCj4g
QEAgLTM2Miw2ICszNjIsNDUgQEAgc3RhdGljIGludCBkb196eW5xbXBfcmVib290KHN0cnVjdCBj
bWRfdGJsICpjbWR0cCwgaW50IGZsYWcsDQo+ICAgICAgIHJldHVybiBDTURfUkVUX1NVQ0NFU1M7
DQo+ICB9DQo+DQo+ICtzdGF0aWMgYm9vbCB6eW5xbXBfdmVyaWZ5X2F1dGgodm9pZCkNCj4gK3sN
Cj4gKyAgICAgdTMyIHN0YXR1cyA9IDA7DQo+ICsgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAg
cmV0ID0genlucW1wX21taW9fcmVhZCgodWxvbmcpJmNzdV9iYXNlLT5zdGF0dXMsICZzdGF0dXMp
Ow0KPiArICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgcHJpbnRmKCJDYW4ndCBvYnRh
aW4gYm9vdCBhdXRoIHN0YXRlIik7DQo+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiBV
c2luZyBib29sZWFuIGFzIHJldHVybiB2YWx1ZSBoZXJlIGlzIG5vdCBwcmFjdGljYWwgYXMgdGhp
cyBjb25kaXRpb24NCj4gc2hvdWxkIHJhdGhlciBzaWduYWwgZXJyb3IgdGhhbiByZXR1cm4gZmFs
c2UuDQpHb29kIHBvaW50LiBJIHdpbGwgY2hhbmdlIGl0IHRvIGludC4NCg0KPiArICAgICB9DQo+
ICsNCj4gKyAgICAgcmV0dXJuIChzdGF0dXMgJiBCSVQoMCkpOw0KPiBJdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gaGF2ZSBhIG5hbWVkIGJpdCBoZXJlIGluc3RlYWQuDQpJIHdpbGwgZml4IHRoaXMuDQoN
Cj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkb196eW5xbXBfdmVyaWZ5X2F1dGgoc3RydWN0IGNt
ZF90YmwgKmNtZHRwLCBpbnQgZmxhZywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBhcmdjLCBjaGFyICogY29uc3QgYXJndltdKQ0KPiArew0KPiArICAgICB1MzIgc3RhdHVz
ID0gMDsNCj4gTm8gbmVlZCB0byBpbml0IHN0YXR1cyB2YWx1ZSBoZXJlLg0KT2sNCg0KPiArICAg
ICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgIHN0YXR1cyA9IHp5bnFtcF92ZXJpZnlfYXV0aCgpOw0K
PiArICAgICBpZiAoc3RhdHVzKSB7DQo+ICsgICAgICAgICAgICAgcHJpbnRmKCJCb290IGlzIGF1
dGhlbnRpY2F0ZWRcbiIpOw0KPiArDQo+ICsgICAgICAgICAgICAgcmV0ID0gZW52X3NldCgienlu
cW1wX2F1dGgiLCAiMSIpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gQ01EX1JFVF9GQUlMVVJFOw0KPiArICAgICB9IGVsc2Ugew0KPiBI
ZXJlIGl0IG1pZ2h0IGJlIHRoYXQgcmVhZGluZyByZWcgYWN0dWFsbHkgZmFpbGVkLCB3aGljaCBz
aG91bGQgcmV0dXJuDQo+IENNRF9SRVRfRkFJTFVSRSBpbnN0ZWFkLg0KSSB3aWxsIGNoZWNrIGZv
ciB0aGlzIGluIFYzLg0KDQo+ICsgICAgICAgICAgICAgcHJpbnRmKCJCb290IGlzIG5vdCBhdXRo
ZW50aWNhdGVkXG4iKTsNCj4gKw0KPiArICAgICAgICAgICAgIHJldCA9IGVudl9zZXQoInp5bnFt
cF9hdXRoIiwgIjAiKTsNCj4gQ291bGQgdXNlIGEgbW9yZSBkZXNjcmlwdGl2ZSBuYW1lLCBsaWtl
IGZzYmxfYXV0aD8NCkl0IGFwcGxpZXMgdG8gZWl0aGVyIGZzYmxfYXV0aCBvciBzcGxfYXV0aCBh
cyB0aGUgYm9vdC5iaW4gaGFzIGJlZW4NCmF1dGhlbnRpY2F0ZWQuIFRlY2huaWNhbGx5LCB0aGlz
IG1lYW5zIHRoZSBwbXVmdyB0b28gaW4gYm90aCBjYXNlcy4NCg0KUGVyaGFwcyAiYm9vdF9hdXRo
IiB3b3VsZCBiZSBhIGdvb2QgbmFtZT8NCg0KPiArICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gQ01EX1JFVF9GQUlMVVJFOw0KPiArDQo+ICsgICAg
IH0NCj4gKw0KPiArICAgICByZXR1cm4gc3RhdHVzOw0KPiBTaG91bGQgaXQgYmUgQ01EX1JFVF9T
VUNDRVNTPw0KSSB3YXMgYWxzbyBob3BpbmcgdG8gcmV0dXJuIGEgMCBvciAxIHZhbHVlIGZvciB1
c2luZyB0aGUgY29tbWFuZCB3aXRoIGENCnUtYm9vdCBzY3JpcHQuIEkgZ3Vlc3MgdGhlIHUtYm9v
dCBzY3JpcHQgY291bGQganVzdCB1c2UgdGhlIGVudiB2YXJpYWJsZT8NCg0KDQo+IFRoYW5rcywN
Cj4gVG9tYXMNClRoYW5rcyBmb3IgeW91ciB0aG9yb3VnaCByZXZpZXcuDQoNCj4gK30NCj4gKw0K
PiAgc3RhdGljIHN0cnVjdCBjbWRfdGJsIGNtZF96eW5xbXBfc3ViW10gPSB7DQo+ICAgICAgIFVf
Qk9PVF9DTURfTUtFTlQoc2VjdXJlLCA1LCAwLCBkb196eW5xbXBfdmVyaWZ5X3NlY3VyZSwgIiIs
ICIiKSwNCj4gICAgICAgVV9CT09UX0NNRF9NS0VOVChwbXVmdywgNCwgMCwgZG9fenlucW1wX3Bt
dWZ3LCAiIiwgIiIpLA0KPiBAQCAtMzcxLDYgKzQxMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY21kX3Ri
bCBjbWRfenlucW1wX3N1YltdID0gew0KPiAgICAgICBVX0JPT1RfQ01EX01LRU5UKHJzYSwgNywg
MCwgZG9fenlucW1wX3JzYSwgIiIsICIiKSwNCj4gICAgICAgVV9CT09UX0NNRF9NS0VOVChzaGEz
LCA1LCAwLCBkb196eW5xbXBfc2hhMywgIiIsICIiKSwNCj4gICAgICAgVV9CT09UX0NNRF9NS0VO
VChyZWJvb3QsIDMsIDAsIGRvX3p5bnFtcF9yZWJvb3QsICIiLCAiIiksDQo+ICsgICAgIFVfQk9P
VF9DTURfTUtFTlQodmVyaWZ5X2F1dGgsIDIsIDAsIGRvX3p5bnFtcF92ZXJpZnlfYXV0aCwgIiIs
ICIiKSwNCj4gICNpZmRlZiBDT05GSUdfREVGSU5FX1RDTV9PQ01fTU1BUA0KPiAgICAgICBVX0JP
T1RfQ01EX01LRU5UKHRjbWluaXQsIDMsIDAsIGRvX3p5bnFtcF90Y21faW5pdCwgIiIsICIiKSwN
Cj4gICNlbmRpZg0KPiBAQCAtNDQ2LDEwICs0ODYsMTIgQEAgVV9CT09UX0xPTkdIRUxQKHp5bnFt
cCwNCj4gICAgICAgIiAgICAgICA0OCBieXRlcyBoYXNoIHZhbHVlIGludG8gc3JjYWRkclxuIg0K
PiAgICAgICAiICAgICAgIE9wdGlvbmFsIGtleV9hZGRyIGNhbiBiZSBzcGVjaWZpZWQgZm9yIHNh
dmluZyBzaGEzIGhhc2ggdmFsdWVcbiINCj4gICAgICAgIiAgICAgICBOb3RlOiBzcmNhZGRyL3Ny
Y2xlbiBzaG91bGQgbm90IGJlIDBcbiINCj4gKyAgICAgInp5bnFtcCB2ZXJpZnlfYXV0aCAtIHZl
cmlmaWVzIGlmIGJvb3QuYmluIHdhcyBhdXRoZW50aWNhdGVkXG4iDQo+ICsgICAgICIgICAgICAg
UmV0dXJuczogMCBub3QgYXV0aGVudGljYXRlZCwgMSBhdXRoZW50aWNhdGVkXG4iDQo+ICAgICAg
ICk7DQo+DQo+ICBVX0JPT1RfQ01EKA0KPiAtICAgICB6eW5xbXAsIDksIDEsIGRvX3p5bnFtcCwN
Cj4gKyAgICAgenlucW1wLCAxMCwgMSwgZG9fenlucW1wLA0KPiAgICAgICAiWnlucU1QIHN1Yi1z
eXN0ZW0iLA0KPiAgICAgICB6eW5xbXBfaGVscF90ZXh0DQo+ICApOw0KDQpCZXN0IHJlZ2FyZHMs
DQpOZWFsIEZyYWdlcg0KQU1EDQo=
