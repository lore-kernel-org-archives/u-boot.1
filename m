Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62F4C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 708BD80F16;
	Wed, 22 Jul 2026 12:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqjOa3LdcOJs; Wed, 22 Jul 2026 12:32:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ABBD80F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723569;
	bh=WEP3QU3856xBkdFXLSdiFepZ4UD9fdb0wslNN6ydDNA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HAwwuQRV12f/wWqgxUmwfQ3z7h3iiwMlpJ/rscUI4mrY9jGlRt0VsEKnV10E8H9wC
	 FUKqjpj9MA7wLgqB2qqzA0lQoOPKzuBvaNVYYAIfW27w6CK2yn+9uN/FDDAX0MXi8P
	 RvFrWdTuR29IG2TDXNZiNXodLBTvWmylO4ENzhh8CXSx/BR+Mk78fNzwxpfidRSbAN
	 eGWUXg0FbLb7IzWrT8fpBGXdOa/xCInOgiOyV4JyiPfMbF0/yGDWmT0M0UM2G2fB1v
	 nWv6H/cKEwc/feAxq2SDVwva+J0BHXICd/3hJ+IQ5dFZsEBp5iKczMMLBvrWeg5JZJ
	 oTUKllD295arQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ABBD80F2D;
	Wed, 22 Jul 2026 12:32:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 616AF224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F1086071B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFsojFjhyuiW for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:32:47 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D9539606A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9539606A8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9539606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:32:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68341848BA; Wed, 22 Jul 2026 14:32:44 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7468803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:32:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgOHu91aftuyWpjF8vy7UQu3qIP2dnmKj/+pYoXn8FlnevmGEXQhoi8h/Dx6AxS3+CkFtwiAyUJAu1XyYCP6mu1XdJHTktJgi4MmsYxStD6qxK36pNCsWE4zGg8RrKLNtMLGrmc1vUntAdhUa8zuxTfPwYYraySeGXbFy64dAylh2PoklYinwcWGctdXfIx8TNy+M9oH4gPGoB6IuUKdwyJY4m7Q/3ByL5TxSwAMpitO2GyOFdnzM7WgjjeWv1U1isDi8cJBV8AY/zwFSzIanVpkyZOT6eJ8aUwPOmDjStfeJ3RmZ5dxemkTFeofHoz1N2mrX5anL7bQ0PsJgINhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEP3QU3856xBkdFXLSdiFepZ4UD9fdb0wslNN6ydDNA=;
 b=RW3DRnTsTQ1kIJ74uQts/zox5FQ4k+Bdy/FDw3x86LyXBK/Qo1aAgSzuuSG3kLbnJqJqs1Lk1UrZmcI+2Pgkeu0wfl0clFMFKsDFxpK0UCIEMdYinCJ5MyoRLdarUBrsfoMUUAzf6hl27IhAYbsIFpVjc9Ep5MSn3TDSGIhrDYhGSd2sNE+9YnJ/xaRTc9zMXfkMKkBF5s/hITgermUv8ilN2funWoRYjTTKHCXesYR/9RcHqqaw4IR5qClHCRYoEAfrZdVBXl2le9GWqTP+vak4gCrjoyb3SSeypsC2eNgwTp8/4Eqz9YJWD5jWIsQPqGwdNLhIrMJwYWCF5f+utQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:32:35 +0000
Received: from BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24]) by BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:32:35 +0000
Message-ID: <1d8f89c2-3247-4897-a5a9-76fb4fd7c421@amd.com>
Date: Wed, 22 Jul 2026 18:02:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
 <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
 <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
 <6051fd86-9f84-4a43-9788-1fa07510c4c0@amd.com>
 <1002cb3a-5f11-4d25-93de-f7965256903f@bootlin.com>
Content-Language: en-US
In-Reply-To: <1002cb3a-5f11-4d25-93de-f7965256903f@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0274.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::10) To BN9PR12MB5367.namprd12.prod.outlook.com
 (2603:10b6:408:104::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df54316-30d9-4d17-c363-08dee7ed4eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|4143699003|3023799007|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XmdVzVLK4sLNVDEl+w8ZgJUCXW3Nb6+xxrp1/PuSolCPPRLiZ0fowgswkPjW6iwexjQHYn00hLO9UuWm8bDJr0Bpr77vf1Sc5xrdaVIkgIzFnDY4V12db3xffVIYk4xcmTDAsscsZia05LEWhxXrgwlToIIB9SmXu8JfMCrsN3ekT6dgWCp0VwjLOKwrBS62WP0DQP1rxdqdGeagn1KZ+ultDTGuU5hUsk3OY/vxyvGRPb8/klswsBnk10mkK67pTNT7iI75qOaWfmd3B8FXl1qubyzWE/xRBYrwkEJPL16UEQOKDIhLUei3ZaMHxgMzwPkwuxLY638fXybqXF+Xx00d5eFezagnrI6IrHjwBXImepuWofN2P77z9Bc3hqgDAAz3Kk6nJRYEXx7TUUOl+0EAuBu2+xguaUe4lV1HeDyv2ujqPU8/37LMNOmdGHvAXEOcSTAoVLKWTZFKkIKHEC1y0mz0YCBREHMEgUr/ISmUwrPSiYCGYpqYpg5C2a6hwYveQdb62rTNUeMnT+qsmTEo1Dmvtasn+ZAMZUkQiRnx7jMyrP6rfyv2EJFvcjEWfIoRQtp98HjlfJQVC8wFokBpUhoWWUlwOySo247+0e/BMimpb5mt8mv53XmOR7FXSqkWn0MfZblg9aNIfQkPKnCTjnv1UjLwz/7I/mnyf+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5367.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(4143699003)(3023799007)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWU3NWZhZFV2VjRpM3FLMHlnT3d4dDBjK3VQTzdKL2pDcjNoTWx4dTlJamow?=
 =?utf-8?B?RnVVeVJ1YmVWQmRHN2ZrWlhCMjg2OU9YaUt2Q0VlR0wzTkNiSTVXMXNpbjFB?=
 =?utf-8?B?NU90dzBsUDQzaU5QTVFQZnhhK0dkWVdHQjdCK3JLU0JNdGJMMzJaK0ZUMEt0?=
 =?utf-8?B?eFBENC8rK1YzKzJXKzZDRzF2Z0FyMThsM0tIcU9FSkZBZjBWTzlDWWg5STBJ?=
 =?utf-8?B?ZkMvVXNEN3pTWHZyMlU0NWtkYTJaTUVVdzdJU0xyUkdhTE1McmpaSHU3RktQ?=
 =?utf-8?B?RzBQNGlzTjZuT3BzOG9oelR5cm0yNnVNeVBrVXNRdzJQMjJiUk16ZnlDazRs?=
 =?utf-8?B?Q0RhRnVvbmdXUUlodHVQeGx3MVlma3lTQW0wTkFIQVgxaEZlUnZidDFJYjJa?=
 =?utf-8?B?SkF5L2hxNU5jREhoT3V0TFdrT3FjQ2k0dXZ0M1k1aWplK1NleWlaMGpENGs1?=
 =?utf-8?B?U1hacnk3R1BPbi9HbUJ5VUJHZlpsTXo4UWE3bjRQMW1CeXRwb2Jib1FqRDZt?=
 =?utf-8?B?MmFEcWUwajNHN3ZMbmxwbi8rVzRxTm1BOFgzWnN0SG1lV0QzeDFLa01FbnAv?=
 =?utf-8?B?VnFFbFhPcmMvTjFpYUFZaUM5Myt2MHNNUDlCTkhteVhCQXVla2lTRy9IL1di?=
 =?utf-8?B?US9QVVhNazVDNkJGaFNGT0pWN0k3ZjJLME0xNFo0TDlkdWV2TEZhYWhxNnJH?=
 =?utf-8?B?U3dxcGdscWUvUitFR1lOclNkbkh6cHF1YytTRFBqdVVRWkorL0xNWnRkM2RN?=
 =?utf-8?B?dGp2dG0xb1I4dFowV1Yzb2h3S2c5VzZmbzBWdFFNOEQ0QUNIWjNKU2R5K0ZO?=
 =?utf-8?B?VmpiYTVGeGU2YVNpZ0F2TE1KL0trcERPdUlic00rT0hCR3lNZjFmUElqTkgy?=
 =?utf-8?B?b28zRk5vaExUNU82d0pHTzBWNXRnb21jenVLTlpmVnJiYjdMNytudDdlM2g4?=
 =?utf-8?B?Slo5QmptWXFYMTFaK2cwWDVUc0JhNjBnaThWdDZtcGFLZ1JSMTVETi9SbTM0?=
 =?utf-8?B?RmphRlV3UDBYS1JHV2Y1VVZjV1lHalo0dUZkanA2T3RtUTdTVTZWSUhYQmc0?=
 =?utf-8?B?UmdaM1F6Yk02MUdjUktUSzBZeUE1cDBPdkp4UTdUczZZTnpTTjdBSFBqSm8z?=
 =?utf-8?B?REVVakFrVXQ0TVJLZ0xheUNRN1pVaE41R0JqelRmaU5LY0tsY0MzVnJVd1ZV?=
 =?utf-8?B?M0M0eWxWOVY1S3paZ2RWMVJ5LytCdGU4T1ZNdEtQUDJpejBzZDJZVGk5VXM4?=
 =?utf-8?B?NFhqKytSdHkzTzRwUDV1elh2aCtnV0t3R1BHNFNGY0o0TnE3Sm5EV2EzZVN2?=
 =?utf-8?B?NDY0NEswOHZ1WlRNRFZqZDdlZGxWMnh3aDR4NVNWbzNSQWtmTUhVdUZobjU1?=
 =?utf-8?B?dTZ1NjRrd1kzWGJ0WW1GYVFiOTZyU2VhVjFwOHRLdUovNHV1YVNZWXlrbFls?=
 =?utf-8?B?bWw2MGZHZS9TYktEclJzM0tLM3R4TFZNUm5tQUtOZ1Q0R0xITFhSK0h4Z0VW?=
 =?utf-8?B?U3pBd2U3U1NxYkpieHAzYWVSZmdWL1h2bkhQVnRDT2RQU3k4R0piMXZKZVJZ?=
 =?utf-8?B?R0taQUJxS1lTQklmb1o4WStmSXl1S0hiTmgrdVRsQTQwbExwSlVDVVRHemUx?=
 =?utf-8?B?a2hiSXpmaXhLZThHcSttWWRJWklVOWRIYmk0RjlUYVFRRWFPQXpqSG1jeTM1?=
 =?utf-8?B?ZitodzhUd0UxaHZrN2Jab2V4eU1tV08rL2k1dkFGZ2J3RmtKWDJ4UjdSMW83?=
 =?utf-8?B?OEFpWk43L2FWUkJCdFU5eUVTSjRzcHFHdC9yOEovVXp2bzcvY1V0UXpUWjgw?=
 =?utf-8?B?V29qVWdmZEV5Z0ZLaGFxQ1JyaXN2NVBXdEF3Qkhwem1IMmxTdEhCa2pUZ1Bl?=
 =?utf-8?B?RXgxYWkyVGd4cUJOMU1IZExVUW55eW95RVdJT3FjM1B4S2FTSVJJbXNrU3Na?=
 =?utf-8?B?Vlp0UkJta1dSQ1lTWGxqbXVBeWhneFJubjNBQUEzWFBieFl0TGNmeVpHY2tG?=
 =?utf-8?B?L1h4dnBON1F4OFJqYWl6Z1VJeXRUcENOSG5KVm9PVHM1ZFptYVZ3UG1PTm5y?=
 =?utf-8?B?SWxvQnBoNXA1ai82VEFZRVRCd1V1aFZ6ZWVhNWlsWm5tcXR5T2NOYllLK3VQ?=
 =?utf-8?B?S25NOXpaY2IrVUh5MFNhM1RCSmtkMlhkRGpJaDBCL3U4MnRGcGpIZE1Wd2Nr?=
 =?utf-8?B?YkdoLzg1UVFLUlZGT2swbWg3cHlVSTZhUU5Sd2lHRG02dFBYTTJaQlkvaFFQ?=
 =?utf-8?B?ZkNJeTRDbk5nUEU4NEtBbGJueVJKMWwwdjFMS3FhWWUxRVV4SFljc0xCZDhs?=
 =?utf-8?Q?G273M5R8xs8xLtHZcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df54316-30d9-4d17-c363-08dee7ed4eca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:32:35.1817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpLFBBlo6ELBEAfCLs8T0U2q5cBdCEs2OpJdgaCptcWxOJiwSnt3Jnua2bGfEJEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEP3QU3856xBkdFXLSdiFepZ4UD9fdb0wslNN6ydDNA=;
 b=wxy9F9DOpQPmPo4CTvze15aJuikLNKbnH5d4QMZSx3I8Px5W3S9mNE2KGAyqKjqvg97IowqfHv7S0/XrpTpqVu2oNH4tIToPChVDUtF9NbrN2ZUNKz1g/DWobUnPB0+qGFzSISS6iKMWvmgAuv0W8S123MlUwfAXss2lTGzcLEk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wxy9F9DO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=love.kumar@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="wxy9F9DO"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Kumar, Love via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Kumar, Love" <love.kumar@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bastien,

On 7/17/2026 8:21 PM, Bastien Curutchet wrote:
> Hi Love
> 
> On 7/13/26 3:52 PM, Kumar, Love wrote:
>> Hi Bastien,
>>
>> On 7/13/2026 3:18 PM, Bastien Curutchet wrote:
>>> Hi Love,
>>>
>>> On 7/11/26 8:36 AM, Kumar, Love wrote:
>>>> Hi Michal,
>>>>
>>>> On 7/9/2026 11:23 AM, Michal Simek wrote:
>>>>> Hi Love,
>>>>>
>>>>> On 7/2/26 15:08, Bastien Curutchet wrote:
>>>>>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>>>>>> - flagging the most hideous parts (where Micron on-die ECC support is
>>>>>>      hardcoded)
>>>>>> - enabling DT support, eg. for reading the ECC configuration
>>>>>> - fixing software ECC support
>>>>>> - aligning the software ECC OOB layout to the rest of the world and
>>>>>>      allow a working interoperability in Linux.
>>>>>>
>>>>>> I then added a patch to fix writes when soft ECC is on.
>>>>>>
>>>>>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>>>>>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>>>>>> ---
>>>>>> Changes in v3:
>>>>>> - Add patch 6 to fix write issues in soft ECC.
>>>>>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>>>>>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>>>>>
>>>>>> ---
>>>>>> Bastien Curutchet (DAVE.eu) (1):
>>>>>>          mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>>>>>
>>>>>> Miquel Raynal (DAVE.eu) (5):
>>>>>>          mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>>>>>          mtd: rawnand: zynq: Add comments about very bad practices
>>>>>>          mtd: rawnand: zynq: Make sure an of node is attached
>>>>>>          mtd: rawnand: zynq: Do not fail the probe for no reason
>>>>>>          mtd: rawnand: zynq: Fix Software ECC engine support
>>>>>>
>>>>>>     drivers/mtd/nand/raw/nand_base.c |   6 +-
>>>>>>     drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>>>>>     2 files changed, 32 insertions(+), 89 deletions(-)
>>>>>> ---
>>>>>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>>>>>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>>>>>
>>>>>> Best regards,
>>>>>
>>>>> Please test this series.
>>>>
>>>> We are again seeing the NAND write issue with zynq-zc770-xm011 board.
>>>>
>>>> Below is the log snippet:
>>>>
>>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>> nand write 0x80000 0x0 0x126f80
>>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>> NAND write to offset 0 failed -5
>>>>
>>> The exact same command works in my setup:
>>>
>>> ```
>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>
>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>   1208192 bytes written: OK
>>> ```
>>>
>>> Can you please share your device-tree / defconfig ? I'd like to dig into this a bit.
>>>
>>> I'd also be interested in seeing the output of 'mtd list' and 'nand info' on your side.
>>
>> I have used the xilinx_zynq_virt_defconfig with zynq-zc770-xm011 DT.
>> Below are the log snippets for 'nand info' and 'mtd list' commands:
>>   Zynq> nand info
>>   Device 0: nand0, sector size 128 KiB
>>    Page size         2048 b
>>    OOB size            64 b
>>    Erase size      131072 b
>>    ecc strength         0 bits
>>    ecc step size     2048 b
>>    subpagesize       2048 b
>>    options       0x40000000
>>    bbt options   0x00028000
>>   Zynq> mtd list
>> List of MTD devices:
>> * nand0
>>    - type: NAND flash
>>    - block size: 0x20000 bytes
>>    - min I/O: 0x800 bytes
>>    - OOB size: 64 bytes
>>    - OOB available: 38 bytes
>>    - 0x000000000000-0x000008000000 : "nand0"
>>       - 0x000000000000-0x000001000000 : "nand-fsbl-uboot"
>>       - 0x000001000000-0x000003000000 : "nand-linux"
>>       - 0x000003000000-0x000003200000 : "nand-rootfs"
>> Zynq>
>>
> 
> Thank for these information.
> 
> Have you explicitly enabled the soft ECC ? I don't find the nand-ecc-mode property in the upstream zynq-zc770-xm011 DT.
> 

Yes, tested it by explicitly enabling it with `nand-ecc-mode = "soft";` in zynq-zc770-xm011 DT, observed the same behavior - NAND write fails. Same issue was observed without enabling ecc mode as well.

```
Zynq> nand write 0x80000 0x0 0x80000

NAND write: device 0 offset 0x0, size 0x80000
NAND write to offset 0 failed -5
0 bytes written: ERROR
Zynq>
```

Am I missing any other configurations?

Regards,
Love Kumar
