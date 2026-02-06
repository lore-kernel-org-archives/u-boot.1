Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452EEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528DA838FA;
	Fri,  6 Feb 2026 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="HxdOTP95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1912A836D3; Fri,  6 Feb 2026 16:04:49 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD16B83AA9
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBtGSRmhsrk3UobuerKqBDAX5hFBWOmaliTQ4gw659ISb3vTNH+cqWHGmudAiRIMdoLIOVqPh9g6uJdXs6jsyY/ygEUp7FCM3BIGSczoGErcQ2VHirtYL+2muqc+TbMsBMtYoA0mPA9i1E5tsMWfgf1EThcI0hNq/bVVGXUn36CVHkCUGCHxy7dV71gvqvhz646AuYzM0VctgL0gI/fGSo51E+Lhyeh4MHHpU/LEn2OPIRDTln0GSB8TLJ/gTFAEMmkYYRb+OzC3RNFgjaEXDgELyqYt7EPKpRcGoV4ESRyeWofhQh+kiqlWactvbyjKvJDy0kIQgVvgSPmb99ocbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRJBSBDVI0SGJUCtf6hHntbX+I5E+FgDAabSPOcVD+g=;
 b=psiOHJ5BW59yuwdOvyMVc5UrK3EGrYdBPBZvl637192psuvyEezZS8hHqXu21n58AqCVm7yYmL/8UDz1WvebxSciIraAhd/Tf9M/mqykptX3N3BDRtW4yLR778h5MfjCS4PTZGhU3/HCt1AGWlYoHYE9sPompUT4/K26iWPyOmkydTEQ+WGCkr545hApbrCUNSKZEtPbhpMil7lDteAI+ebJsya/lsrkoPUBXqJbKtURuVc6ZCuS/GJkeFRJtSIyAKT1wlOw50w/AZxnSYLPqk7VS96fcXY1FD/PAjlW9irm7AWXtYpRSpIgG5t7myYSK+3LMP1tJMhZTCj/YY1JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRJBSBDVI0SGJUCtf6hHntbX+I5E+FgDAabSPOcVD+g=;
 b=HxdOTP95k2H7XGUtScmN0qISzPuKKWgLZWcMidcFnVVamTOQ8K4QPG0QMpYTD7q4rIHCfI72eJKiZKHpelSyQqP2p7phkKEAsoWsTy1Z0mKROhavBtSKCVv2Z3DZlCdC1ASwSTd/TW11BY5EVkmdCFaRmGR/v5E0OSa1kZ2K/WlWYICtVZqCoYhavLnODkc4BYYz+/+9dsMn9dhLzenxLrv6zpjGvKJV8SMzx074fzaf45X5dMuyWD1HVWPtgNbsN2cFJC4dpiuhebDMx8OHrrwRjTx23dHdrK2xO5jfct/WXI15muDo6hbKybRbuaLY1aFVIO8dSvPbUN6iqDebIQ==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 15:04:41 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 15:04:41 +0000
From: <Jamie.Gibbons@microchip.com>
To: <trini@konsulko.com>
CC: <Valentina.FernandezAlanis@microchip.com>, <xypron.glpk@gmx.de>,
 <Conor.Dooley@microchip.com>, <Cyril.Jean@microchip.com>, <sjg@chromium.org>, 
 <u-boot@lists.denx.de>, <ycliang@andestech.com>,
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Thread-Topic: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Thread-Index: AQHciiF0YRm86pfc8E+QGT81o835bLVgNdMAgAWmFICAAEnoAIAPuxgA
Date: Fri, 6 Feb 2026 15:04:41 +0000
Message-ID: <3963fe8f46c85646da978216a82121bf2e6ce010.camel@microchip.com>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
 <20260120153314.95091-2-jamie.gibbons@microchip.com>
 <20260123201540.GA2406606@bill-the-cat>
 <36c8cbb602754cdad8a20221548da8a79d81b3a2.camel@microchip.com>
 <20260127145554.GB3416603@bill-the-cat>
In-Reply-To: <20260127145554.GB3416603@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|MW3PR11MB4522:EE_
x-ms-office365-filtering-correlation-id: 797c623e-fbd6-430f-9687-08de65910dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ei9icFlHQUR2b2s3YXZ1TG5WNUNCdURnMFFVQlJDcFVzQTExbktOTUVHbEE5?=
 =?utf-8?B?bEJObEhCTGZtVVllS0Rxc0tFMWRsUURTZDJqUm9GL25Dc3czTVBmelhVeU9R?=
 =?utf-8?B?MzlqTXliOE5FeDZXdDg4NDVYdm8wRlpNNUppVW5JaWJXNTF2Z2c1ZVhhMm9o?=
 =?utf-8?B?RldPLytlSlBiMU5MQytyenBCREVIN3AxMXg3dlpEdk1yMEpHQVlFUWkrSEll?=
 =?utf-8?B?YStQT01zVFJ3Mmk0dEJmNzVEenBDSDlQdXVMeXR6QzBlc1NacWFZekFycjdM?=
 =?utf-8?B?cG5tdnFXTjlreUZRb1pwNFZsci9NcjlNdElCVmw0SVd1d1VlOEV2VjRWdDVH?=
 =?utf-8?B?K0FubThRYUdHOTZVRjkxSGxXWS8wOFdxSTNpbk5mM3hXUnZKeGZrbEhrUTFR?=
 =?utf-8?B?YjQ3anlSQnphUnk4aHVUMXVVVzdncGlZUi9SR2NJeFZUUGJJSUdzTzdJTzky?=
 =?utf-8?B?SDQ4R0cwZnF2c1VEbXhYcGoyazhDaXdiQjM4aSs5VklSV2NzZTUxMnd0b3Av?=
 =?utf-8?B?Rmt2ZENjSGVLRHYvRFlBTEE3blpiUnBwWmlOaEUyMlMrMVN1WEtoRDJMbXZG?=
 =?utf-8?B?RTZScnQrbDV4ejRleFRhWEFrT0t6ZmZKeGs2Y0Fyc2swYm5MN1VZdVlNa3lO?=
 =?utf-8?B?ZXFGTnBTUVRIaERMOEllT3gwYjhqU1B3K1dpK0lEdzV2SVJzdTE3bXNJZnht?=
 =?utf-8?B?Wmd1MCtjU3pjQUZTTmhoSXVTbWtwazcybEFEMmJUem5YaWFPZnp6THE2R1Fn?=
 =?utf-8?B?bVRmTlFvdFZSMWUvOHM2MUl3QXFRUWlUdjludkExVnhIbHMyMkdtN2lSU1BC?=
 =?utf-8?B?QTJSRGlyT3cxYkFHdmVOYzh0aEtaUkM3TFAwU1Bkd0RSVXZ3TnZhM2VGeW5z?=
 =?utf-8?B?bWZKaFdoNHVOQ1RNZVVlekN3M1ZnY2ZoZ2pFVzVQczQ4MG1RWjJLLzBLTUxs?=
 =?utf-8?B?UDFJMkdFTURiUEhQMWVXQWNJTmFJbGtrTWJOLzN4WjY2TXhUV1JRSWlBZDUy?=
 =?utf-8?B?TmNoeXI3bTdIWm1tL3FPNG5mYlpsc3ZMSkg2S1pKVkNOKzR0UHBtTi8rUEtp?=
 =?utf-8?B?RkY5cWo2VFl2bHVaWkZrdUlJRTlZNlhPcnVCaE9UTDcxMmVOY2gxdW11Wngz?=
 =?utf-8?B?aERDa3lvOEx6YVVSV2R3WUNWTWpxUGdqMVFQVytoN1h2Uks1SVVmQ0VTVU9Q?=
 =?utf-8?B?T2laNjkvS3hTTExWV1p1emRHQnlIRHFPaXBNZXRzcDBmVFdDMzQrVHBaNmtD?=
 =?utf-8?B?TmFsVnBJTDdITHR4b2xNU24wVDZSL0JiTytMRy9DcFRJUWZTZzlXSE8zWEhs?=
 =?utf-8?B?b1JwS0ZNQnlVb3Y1SVhwMUNQbEc3aUErWldRcGxGY1JUMFU4MG9Jc09QbVlx?=
 =?utf-8?B?K0VscFA4eFh3YTFnM0NaVzU4dFhqU0dicnlBVzBsdUUvb1hqdWZvVDVQdnlS?=
 =?utf-8?B?Vi9kVWs4Tk5PaW9jU1QwV1l4RGNreTJLSGVBSHl2Nk90S3hScCtEbUFLQStH?=
 =?utf-8?B?Y2FLMEoxK1psKy9pT0FPc3I4QU9XSnkrMDJjeXRJVnJUdyt3NVE2UjZObjZD?=
 =?utf-8?B?NXVBaEdtaE00ZUVyNE9oQjE3c3pEYlJ0ZUtESU9MKzRHK3lXcmIvQTNya1VN?=
 =?utf-8?B?Um1uTnZvb3lzMHpDSmZNOWttTGx4S29tdHNEZDdlZ3hlRHJmRDB1bHNPb20r?=
 =?utf-8?B?QjdDZ0NtVzNKWFZwSWw3TWlzWFZ3RVlyVTN6VjlCbHAyVXZieVFVaXFJZjJp?=
 =?utf-8?B?cEhpMmZsN3cvMXh1UENWOWdBRU5HWmZSclkyOVoyeGpQdlNtRnhORGZSdEE4?=
 =?utf-8?B?R3loVFdZaWxHbklZa2JMVUxDVm95ZnY2RmlQNTRiaCt1Sys4QjBDSG44WGJD?=
 =?utf-8?B?Nk1OQ3JRUnZmb3dwdFRJZlhZemFNcVB6VFIzczJYU2dnMFNKWThkN1M0UkdW?=
 =?utf-8?B?SkZNbnh6eUhCUThOR0VHVU5ZTk1aTXN2dkI0RFZZR3pZbDB0R1MzbC9hdkU1?=
 =?utf-8?B?ajdQWlJqS1RjSUliT25sUWpDSWwycEYxTU5Xbk1BTzNSMHhvVHRmeUNvYmtG?=
 =?utf-8?B?K0tmUTd3RFRHVWtpZUVMaGlnZXZsQXhxZ3NTV0JaTXZCMkhVdlJKMXU1bmxY?=
 =?utf-8?B?YWt1WFl5UnptSTJ6Rm5WUHc4d2RCeFZody8xMDhVWm9EcVBTMWZpaWdQWWZW?=
 =?utf-8?Q?G427HttxljZZu0bUp9lWd8c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJBWkFhenB4QUxWSkRwU3RZdmR5RHFWaGoyREtPR2FjZEIzRUpiMWRJalRD?=
 =?utf-8?B?SkN3YzFKMDc4a2xnNjcwMmQ4R0N0RUMxeEZEMUlVMXBjcElSaWFjZGx6N1dZ?=
 =?utf-8?B?Y253QWJEWkdXUUVWZXZkZ2tiRldmT1ZxN2prZXZnMWIzZGo1Tm9wa1BrcUdD?=
 =?utf-8?B?ektCL25TWjhCMURTMDYzWnBPTitPc05aT3YvZXNtZm1zNG1XdWVWMkYrNExm?=
 =?utf-8?B?M3hBTk5pT0dJVkdkUlZLMmRqeGFid1VTS1lVb1JEenR6YTRucllva2JlV3Zj?=
 =?utf-8?B?ZVhjUTBtS1dIWFpkVnEvZ2tXMGtPaTM4N2VwY0lqT2ZsZ1VUeEw3eVpVS2NT?=
 =?utf-8?B?ZmJBL1V2WkNkWkMzNldTeG1SVjNTWVFiVW5MREU5dk9kTWNuKzFHZ1VKT3Yw?=
 =?utf-8?B?L1RuMHgwbzR2eEF2RDI3U2lJRGRBVWtpZ0lLaGN3dGRRWTlNcU5Bc2FHVFR3?=
 =?utf-8?B?U2VjOEwxQkxmemtrYTFqWityeHRVSDF5N29WMTRsTEU5UytWNm9mVTNnSlJK?=
 =?utf-8?B?SDg2MXJ3dkgzM3J2Qk9BUS9kVXNucXZCUm8xRXpycUd4a3hjdHFvK204V3N5?=
 =?utf-8?B?MTJLWm1UT241d25EYVUyNndKSC9IbW9OcDMzYmVpV3E4bUc3RUlHZnFsMC92?=
 =?utf-8?B?ZzdXczF4WURSc09SQzRXV0ZnMTQ5Um96cXZtdk9naEh1a0o2aXVOZjRKVWMv?=
 =?utf-8?B?TXhXM3NlTGlsTmg0NE9XdUQ2ZFF2L29zNXhsRGVCL2t0blhMbGtnYmFQOEJO?=
 =?utf-8?B?cmRqNVBPUGtuellodmt0cVE3VUJUWEl4RWV0aWdya0lsT21pMUlIb1J0N0xF?=
 =?utf-8?B?Mkd6MmIvcEZxNVhjRVI1RGJwb0t3dTR5NzJuTG9YNmlmdW82N0R3b2gvN3dw?=
 =?utf-8?B?RzZiQzZwL2lxVnVpMllSWW9Rd0ljWkY1TkNSV3oxcjFtYjJ3MnZwaXFVNWVJ?=
 =?utf-8?B?TUp0T0t0YTNFbFYweVRNZHlHWmlTcUltZUh4empIV1l5OUplVVZPcjhRQ21Y?=
 =?utf-8?B?aVZzUmp2Y1VzTkpOZVpJOG1MTEVDa3dDR1R2MFNVeWxnVVVTM1AyNFBuSnhs?=
 =?utf-8?B?ZTZBYlNPUzhuMG5kajFaQkoweE9EdTlWZzltYjRFRnR4b2hBREgxOXg3Mzg2?=
 =?utf-8?B?bVEwM1Fham1yYjQxT29zVk9aZyt5SEtENUZpZVN5V2libDZBVHNyS2dyTFNw?=
 =?utf-8?B?Sm0reTRyYzB4NWxQVmRwbThpWVZFVjIwbHNUeTVJWkFjcjlzVHNSOFNEUHg0?=
 =?utf-8?B?aEN6cG8zV2c3dzdTVkhaZCtsSmRwclVaQjh2bFZCdTZlZ3dpaUhtanFWMm8x?=
 =?utf-8?B?SEdmWkNoazFjdVlOM3owZWxJUFF0TzFOTyt5dUM5KzRRQTVuRUptVW5zbElG?=
 =?utf-8?B?alJEM1FhTElLWTIzOVFrRmloQXNxdXo0QXI3ZkNvVDFKTFVEWFR3SlNObHNY?=
 =?utf-8?B?dWRKQmRqVDdUdWdaT243WkEvMjh2OWFUTTVJdzh2dDlWeisvNDBTK2RCVFBh?=
 =?utf-8?B?OHBKZkJydTQ5UENlelZZVm9ocTlVbzhyQ1ZaTW1WZEYvS2hReXkxV1JlMkhC?=
 =?utf-8?B?S0RMdkRPR2NrSkpoMjZpL2hqTEdxOTZsSnRJL3EzSmhPY0RleHNOZDdXZjFO?=
 =?utf-8?B?QjNhcGtOeEE0ZFIvQURlQWVUaDIwQ0Z0dTUxTmJuUHc4M2wzMVFDVXpRY1p6?=
 =?utf-8?B?YkcxcngzbnIwUnMzWE1ZcUVwaGgwSFdvTVJNdXUwcWpKRk1ScUU3WmVkOWtT?=
 =?utf-8?B?bVl1RmVLS3Z1am10ZjEvNFBrb3JSaThkRnJQeXFvWXBIYWhER0V4dEd2TXBo?=
 =?utf-8?B?aG05VU5xRS85b2pXN1kvbFhaVTBlKzdjUUhYSEh5SXlPTm9LRmV0UEJ6Yiti?=
 =?utf-8?B?Sk9DWnZQT1ZIYmZCYlFGbFpTNTBQYTJxNjQ5SGQ4K0Vwd0U4aXBaaHcvUFRo?=
 =?utf-8?B?OGVoUU50a0VJRWQ3UWpYdEFLeUZQTHhYWndiNHhHOEJ5OTVDeFVOZDhySUJ2?=
 =?utf-8?B?UFB1dGFwQWY3bXhSVm12OEYrSnIwNWdJTkZmQUZHMlJoZ0RveG1Lb1FBa3Fu?=
 =?utf-8?B?dUFaakJJTDRWb1hoV3RTL3dCNklBTkQwT2FJZnVudDZBUlQ2cC8vM21ZeDh2?=
 =?utf-8?B?cHdXQisvbmNlNU1DNVpPV2NTR0FKQnA3dXRZcnRSbGttMkpMUnNyZlRsTFdz?=
 =?utf-8?B?N3VUODF2Umo2cTFHOEVneWZ2eUpIS0Q4QnhMNm03dVN1MjNxVFEvNldzb3Bk?=
 =?utf-8?B?Zy9zU0VyU3Q0cHNNbUJjR0cyckJsdUhydXBjV1hjQXpYRG1NNm45V3ROMm1p?=
 =?utf-8?B?dmo0am1aS25TQ3Nyd2tZeVZYcXVoTzllNG0xWHJzU3lKN1pMUk5uS3NxeVR3?=
 =?utf-8?Q?84OvxEtiEpXxKeck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54207AD091877448B475EB7BE2094978@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797c623e-fbd6-430f-9687-08de65910dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 15:04:41.2434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvAIm/7v0QU/peJAoq5kPZikAK8TJdW9v3uOYF4LCPxgHdJ7CT4bi05zJ9c/nyuf8k5MWELvcIbM1KWwufI3aY+0xUpSSiQXmd+5QNPTIYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-Mailman-Approved-At: Fri, 06 Feb 2026 16:12:47 +0100
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

SGkgVG9tLA0KDQpPbiBUdWUsIDIwMjYtMDEtMjcgYXQgMDg6NTUgLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOg0KPiBPbiBUdWUsIEphbiAyNywgMjAyNiBhdCAxMDoyNjozM0FNICswMDAwLA0KPiBKYW1p
ZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IEhpIFRvbSwNCj4gPiANCj4gPiBP
biBGcmksIDIwMjYtMDEtMjMgYXQgMTQ6MTUgLTA2MDAsIFRvbSBSaW5pIHdyb3RlOg0KPiA+ID4g
T24gVHVlLCBKYW4gMjAsIDIwMjYgYXQgMDM6MzM6MTJQTSArMDAwMCwgSmFtaWUgR2liYm9ucyB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBBZnRlciBVLUJvb3QncyBEVEMvbGliZmR0IHVwZGF0ZSwg
ZGV2aWNlIHRyZWUgb3ZlcmxheQ0KPiA+ID4gPiBhcHBsaWNhdGlvbg0KPiA+ID4gPiBjb3VsZA0K
PiA+ID4gPiBmYWlsIHdpdGggRkRUX0VSUl9BTElHTk1FTlQgZHVlIHRvIHRoZSBvdmVybGF5IERU
Qk8gYmVpbmcNCj4gPiA+ID4gbG9hZGVkIGF0DQo+ID4gPiA+IGENCj4gPiA+ID4gbWlzYWxpZ25l
ZCBhZGRyZXNzLiBDaGFuZ2UgdGhlIEZJVCBpbWFnZSBsb2FkZXIgb3B0aW9uIGluDQo+ID4gPiA+
IGltYWdlLQ0KPiA+ID4gPiBmaXQuYw0KPiA+ID4gPiBmcm9tIEZJVF9MT0FEX0lHTk9SRUQgdG8g
RklUX0xPQURfT1BUSU9OQUxfTk9OX1pFUk8sIHRvIGVuc3VyZQ0KPiA+ID4gPiBvdmVybGF5cw0K
PiA+ID4gPiBhcmUgbG9hZGVkIGF0IHByb3Blcmx5IGFsaWduZWQgYWRkcmVzc2VzIGFuZCBhbnkg
YWxpZ25tZW50DQo+ID4gPiA+IGVycm9ycw0KPiA+ID4gPiBhcmUNCj4gPiA+ID4gcmVzb2x2ZWQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBUZXN0ZWQgb246IFBvbGFyRmlyZSBTb0MgSWNpY2xlIEtpdA0K
PiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDA1MzVlNDZkNTVkICgic2NyaXB0cy9kdGM6IFVwZGF0
ZSB0byB1cHN0cmVhbSB2ZXJzaW9uDQo+ID4gPiA+IHYxLjcuMi0zNS1nNTJmMDdkY2NhNDdjIikN
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtaWUgR2liYm9ucyA8amFtaWUuZ2liYm9uc0BtaWNy
b2NoaXAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBib290L2ltYWdlLWZpdC5jIHwgMiAr
LQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Jvb3QvaW1hZ2UtZml0LmMgYi9ib290
L2ltYWdlLWZpdC5jDQo+ID4gPiA+IGluZGV4IDJkMDQwZTM4ZDk3Li4zYTMyN2QwNzc4NCAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvYm9vdC9pbWFnZS1maXQuYw0KPiA+ID4gPiArKysgYi9ib290L2lt
YWdlLWZpdC5jDQo+ID4gPiA+IEBAIC0yNDgxLDcgKzI0ODEsNyBAQCBpbnQgYm9vdF9nZXRfZmR0
X2ZpdChzdHJ1Y3QgYm9vdG1faGVhZGVycw0KPiA+ID4gPiAqaW1hZ2VzLCB1bG9uZyBhZGRyLA0K
PiA+ID4gPiDCoAkJCWFkZHIsICZ1bmFtZSwgJnVjb25maWcsDQo+ID4gPiA+IMKgCQkJYXJjaCwg
SUhfVFlQRV9GTEFURFQsDQo+ID4gPiA+IMKgCQkJQk9PVFNUQUdFX0lEX0ZJVF9GRFRfU1RBUlQs
DQo+ID4gPiA+IC0JCQlGSVRfTE9BRF9JR05PUkVELCAmb3Zsb2FkLCAmb3ZsZW4pOw0KPiA+ID4g
PiArCQkJRklUX0xPQURfT1BUSU9OQUxfTk9OX1pFUk8sICZvdmxvYWQsDQo+ID4gPiA+ICZvdmxl
bik7DQo+ID4gPiA+IMKgCQlpZiAob3Zfbm9mZnNldCA8IDApIHsNCj4gPiA+ID4gwqAJCQlwcmlu
dGYoImxvYWQgb2YgJXMgZmFpbGVkXG4iLCB1bmFtZSk7DQo+ID4gPiA+IMKgCQkJY29udGludWU7
DQo+ID4gPiANCj4gPiA+IEFmdGVyIHRhbGtpbmcgd2l0aCBNYXJlayBhYm91dCB0aGlzIG1vcmUs
IHdlIHRoaW5rIHRoaXMgaXMgdGhlDQo+ID4gPiB3cm9uZw0KPiA+ID4gYXBwcm9hY2guIENhbiB5
b3UgcGxlYXNlIHRyeSBkcm9wcGluZyB0aGUgbG9hZF9vcCB0ZXN0IGZyb20NCj4gPiA+IDhmYmNj
MGUwZTgzOQ0KPiA+ID4gYW5kIHNlZWluZyBpZiB0aGF0IGFsc28gZml4ZXMgeW91ciBwcm9ibGVt
PyBJZiBzbywgcGxlYXNlIHBvc3QgYQ0KPiA+ID4gcGF0Y2gNCj4gPiA+IHdpdGggdGhhdCBhbmQg
YSBGaXhlcyB0YWcsIHRoYW5rcyENCj4gPiA+IA0KPiA+IERyb3BwaW5nIHRoZSBsb2FkX29wIHRl
c3QgYWRkZWQgaW4gY29tbWl0IDhmYmNjMGUwZTgzOSBkb2VzIG5vdA0KPiA+IHNvbHZlDQo+ID4g
dGhlIGlzc3VlIC0gZmFpbGVkIG9uIGZkdF9vcGVuX2ludG8gZm9yIERUTyBkdWUgdG8gbWlzYWxp
Z25tZW50IG9mDQo+ID4gb3YuDQo+IA0KPiBVZ2gsIGRhcm4uIElzIHRoZXJlIGFub3RoZXIgbG9h
ZF9vcCBjaGVjayB0aGF0IGNhbiBiZSByZW1vdmVkIHRvIGZpeA0KPiB0aGF0IGNhc2U/IElmIG5v
dCwgdGhlbiB3ZSBuZWVkIHRvIHBhc3MgaW4gYSBuZXcgZmxhZyB0aGF0IG1lYW5zIHRoYXQNCj4g
d2UNCj4gYWx3YXlzIHJlbG9jYXRlIHRoZSBkYXRhLiBUaGF0IHdhcyBNYXJlaydzIG90aGVyIHN1
Z2dlc3Rpb24gYXMgd2UNCj4gdGFsa2VkDQo+IHRoaXMgb3Zlci4NCj4gDQpTb3JyeSBmb3IgdGhl
IGRlbGF5IGluIGdldHRpbmcgYmFjayB0byB0aGlzLiBUaGVyZSBpcyBubyBvdGhlciBsb2FkX29w
DQpjaGVjayB0aGF0IGZpeGVzIHRoaXMgYXMgZmFyIGFzIEkgY2FuIHRlbGwuIEkgaGF2ZSB0ZXN0
ZWQgYW4NCmltcGxlbWVudGF0aW9uIG9mIGEgbmV3IGZsYWcgZm9yIHRoaXMgYW5kIGl0IGlzIHdv
cmtpbmcuIEkgd2lsbCBzZW5kDQp0aGUgcGF0Y2ggYW5kIHlvdSBjYW4gbGV0IG1lIGtub3cgaWYg
eW91IGhhdmUgYW55IGZlZWRiYWNrIG9yIGZ1cnRoZXINCmNvbW1lbnRzLg0KVGhhbmtzLA0KSmFt
aWUuDQo=
