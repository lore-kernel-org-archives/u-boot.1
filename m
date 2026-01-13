Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400AD2502E
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED3F800AE;
	Tue, 13 Jan 2026 16:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PvS6lpFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC619800B6; Tue, 13 Jan 2026 16:08:04 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A41080050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRcad+Hm8DTpXaekdXivuVhaR+CNKy4IlDmDGiKoxzZ2Vhr+4lYqP1hMklXlHYYj1zKYMkCXG9iG4JHP9216oPBRTn8/JkDiFzwF5uMyzieijmAuFoEtCxvKL9AOKFsQXLaP3CFfhC863SRPXzbg6S8FTIZ3zhNwxjcANdC1X+cJUsCJNbzTe2Ka7FJxq1do/SmNA2us7VUb5zbmFOxcim8ui5dBofaXWMNPx5Z1+DYk+OUiXJaZsU4WIXov/aj04bkSiS4sf0aFZn/zXie8pOqvS1wZTBrWY/HfipmwpnCggK8rPlh7/YhkvhuueMdmQ0SUqJDRlPHf69kA7ynAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQYl5Dp0Gn2gOIAgcH+CJ//jIxVB4/DwpVSmiYKtcKU=;
 b=ZPN2CXybNSLYHy4gZ9cZRTzi0Qw6PyNg1lianLULs2kA3DlgkOJ3OSad1D0ZzMBTLUCWCsv2eTv5VRINTrPRQIio5Hz/zlBpmD4A/0aKoA7m0YVmOWFke4wvtzQw9zFfADLsnD735kYhKCzUvYquFBXdg22gmHRQc/QSHigiMQ2ayVTeue4E7cAyB6q/k3WaRqsWrBVxgZrg5s/y+VXkBQD9nxT74Js2h4Qy2+lmq5OB4txb6/hFJKfZPhUxKHPdlqOOEsBTZWeTp2ioNSVrKIlTAt7sunstmtCmb4xi5R0Jn0a0I4K01DMWj+ogjba1NgrybXTZXksHbq2uMcpXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQYl5Dp0Gn2gOIAgcH+CJ//jIxVB4/DwpVSmiYKtcKU=;
 b=PvS6lpFfco1ZdR6p63LmPpSkI/1MTrnXE4j6sujXuP6FhbmE+hLLPSMN7e8W3E7UUPTVN0Q0GM6p+g6O4b3U9LJV2QNF3qBSgOObMbwUtXJpGNXdDDQzL1YvX3ZtYjonqUWO9lDV3hez0gINkyUzBUIY/2p9HFYBWxq+Zr+DJYE=
Received: from PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 15:07:56 +0000
Received: from PH7PR12MB6696.namprd12.prod.outlook.com
 ([fe80::3f0:b0e5:e6a0:9016]) by PH7PR12MB6696.namprd12.prod.outlook.com
 ([fe80::3f0:b0e5:e6a0:9016%6]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 15:07:55 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Tomas Melin <tomas.melin@vaisala.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] rtc: zynqmp: Add clock framework support with calibration
 fallback
Thread-Topic: [PATCH] rtc: zynqmp: Add clock framework support with
 calibration fallback
Thread-Index: AQHcfvUeTBOkXJ3z2UW87BtSwOTCK7VGqaAAgAmOcOA=
Date: Tue, 13 Jan 2026 15:07:55 +0000
Message-ID: <PH7PR12MB6696D59585A093F61891160AFB8EA@PH7PR12MB6696.namprd12.prod.outlook.com>
References: <20260106101247.1381214-1-pranav.vinaytilak@amd.com>
 <4ac1de76-9d75-4094-aeb9-c2f413f75ce9@vaisala.com>
In-Reply-To: <4ac1de76-9d75-4094-aeb9-c2f413f75ce9@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tomas.melin@vaisala.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-13T15:05:48.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6696:EE_|PH0PR12MB7888:EE_
x-ms-office365-filtering-correlation-id: 8f04eae5-8dfd-4cc8-0d7c-08de52b587ee
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NlRUYW9vdWhNc1QrU2s0MEY5S3JqR1pmMW5xK2dDemJLMXJLa2R4RHZCenVO?=
 =?utf-8?B?a25CcGJCbE9yQ0JaMnJKYVNWanZOSFRCbm84Mm0vNGc5S0lkU2FsM0FyZE8z?=
 =?utf-8?B?V0t6Y1dSU3MvQTQzZTNzUUdsdVk4MWtDMjVsSUtZUHZ0T0dEVVNDVkZMbTdR?=
 =?utf-8?B?TGZjREVyQ3Q1NXpaUEcvQ09BNlk4NCtQeUJKM1F4ZFNyM2pJOHBSdk1iY1hR?=
 =?utf-8?B?YXBIRjVMS25tY0NxbCt5SDFCVVVGcVNGZ2ZkOXpOeXNIYWt2eVUrVjdhZWE2?=
 =?utf-8?B?RzZ6K1A2MFBEQ3Z4RmRWUXZrUzMrWk9wZkZqTnNrNDNiUFhidHNNOUc0WHZq?=
 =?utf-8?B?MkU0OHlNUFhocTFSUVN4Nkp0VmplWU9QL1FYQ1Vsd1RhVkNUVGRvQjJnQm0y?=
 =?utf-8?B?K3lsM1Y4UkRKMlEwRkMvVng2WmNlejk0NjZlTXlvV3h5YTdmcDk2SlZLclBV?=
 =?utf-8?B?NzN2b0MzVkNHcGJZUDQ4N05EL1VnS2VJV2IvYTlMWWk3dzFvaHY4VUtaTWxz?=
 =?utf-8?B?dUpsR2sxWDVFNWdZUkY0R1lGRDhGU0p3UmF1M3RpVENyKzVxNUFXTVgyUXVu?=
 =?utf-8?B?cFc5Mjl3NEN4bVFWNTdSZ2ozdGx3ZEhNMTRibEVPYUFUUTNpcjVQVEV6eGlH?=
 =?utf-8?B?QWJXblFkWDlSaGFhc2daRzAzdElob3UyZHBPTWtHbW80amdzaHJjZDVHN0p2?=
 =?utf-8?B?Q010ODFzdHF0Q0xuMGdQRXl0VXRabTBqR3ZSN0ZRTGdKMlc0QkJYWS9tRjc5?=
 =?utf-8?B?S0Z1RHB0ci92QTZtK05FMlN6dWZSK2w3eWxXQnF0aFNBSjZYU3I3clExdUxr?=
 =?utf-8?B?ZmhrdkZTZklKenhhWkJrMldrNmZITE1WblQ3V1FzVEh3YTMzZkhVQ3BlbUlO?=
 =?utf-8?B?QWZEcDg4UDJkb1hPb2tvaExTVVYxNXFaNzljSjJxUk5uaU9mVFphVG1IN091?=
 =?utf-8?B?blFCSThuLytPY0RiWWZPQWNoTG50Qk5FOTFZSHcwUy9PRDN6N2dPZEpXRnRS?=
 =?utf-8?B?d3RnN3dISjJSRVFMNFpzd29NZFM3RXFEUzh1ckwxL3ZPZW9FYkpQR1FtVWta?=
 =?utf-8?B?bWZyNkNISmRKQmhvNmRENlE5MVhERzdiR3E5OHpPc0IycWF1TmtIY3l4Rkp3?=
 =?utf-8?B?THY4VjE5UkZQUTJJWWRhNzM1ZStmVzkyRzRVdEZ3Yk9OYnlOTTNqQnlLb3F4?=
 =?utf-8?B?Sm5jWWNLcHBhcTE5M1lia2JzTElRSmRRaHNpSFI3ZzF4VFNTNENxd3FDTk5U?=
 =?utf-8?B?eEQ1N2E0SXo2clEvaUJyZFJndWRWRTBLV2xCZkFPSE40Z1UvZS9sZXhUQjlt?=
 =?utf-8?B?Q2FDV0RkK3hUU2tPMmxINFZZYzBmSWJNT2tFWnArMkpJcVBac2VDR3pGbHYr?=
 =?utf-8?B?ZEhMUnY0b3oySTZGdDFkQitKTE1USkpOdzc0UTVIMG1XQUxhNmdvOGdKZmhB?=
 =?utf-8?B?bUFrTC9CY2Evb3pDUzdwYWE4YzNNWG50Tm1SMWs5eHMrR3J3ZXNiOUlDa3I0?=
 =?utf-8?B?MVFZU0VkQ3J6ZWRiR0pVRkJ1TnAzNWsvaWV3SkFienNORk1ucTArclkxazhq?=
 =?utf-8?B?V00vdkNWTHB4NjBBb0o3bHUzcVp4Q2ErYWJRU0p5OCtwVllxbUptRUxkUWhI?=
 =?utf-8?B?N0VzdlkwME9ERXdhYmFRVVBteHA1dnJ6ZkFFYWZ6dWE1NWg0WUtDRnJUSFJn?=
 =?utf-8?B?OUhOblVKVjZKQllocG9vWVNDOGMvUlJucFZCcGYyWDdVNGt4RC9URldEeTFt?=
 =?utf-8?B?VWZGdXFEMkh4N3BOUkR0SVlnd1kvU2p5Zk5McnR3NXVKZmVQaXVjeHgxa2t2?=
 =?utf-8?B?eGhYQnNWeXhrYmd1TkxDT1FxQWl2VmNJUysxNFB4NDUxdE95aWR4MjlrREl5?=
 =?utf-8?B?MHRFZTNNeTFhRjByVnB0Tms5Z1VtWEMwNURES2tpQVZlMWp5V3grcXhmL05R?=
 =?utf-8?B?c3hlQy92djZ0R3Y3b0M2ZXVyaXluZ2M5cmNMamlVV2FZK09FQWlqMDB4WmpU?=
 =?utf-8?B?dUg0ZkpnQWRrc0E1RzJkdFlETzh3MWxSMnRCcG1MdVZOYnN5N3h5OTBTN1VM?=
 =?utf-8?Q?IHyGDR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6696.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDZyWjdpamRHcXdCRlJLTktYVXcxNWJDaW1xNkVFSnR6dXc5bEZzODFoaDdC?=
 =?utf-8?B?T0h2RnpjTHF6dWlSOEZqVkFFNTJYb2xkeVBlK3FtcGROdEUrWEtnMHl0RUJH?=
 =?utf-8?B?VlN5T1g5aFFRUVVtNUw1OHlXUzJ4cXNmcVVOblFMT3RHaXFwa1Mvbk44MDQ5?=
 =?utf-8?B?RXd6dWpmc3hOaFMveENzUDE2YjdGSHd3R2VZeFd6RUczU3cvVGFKMDRadVlp?=
 =?utf-8?B?d0ZwcjByQ0tGSlRSQU9FQVZqYTVzdjZiWHlQcHBsTVZyWTJVYUhVMWF5aVpE?=
 =?utf-8?B?ajdlS0QwOTB0OEZaQStzaGxlUDhIK2FaYkFjZzJuR21xK2tybHZrVzd2ZW0v?=
 =?utf-8?B?TGVEeG03VDNqSWpDRGJPazBlNEdHZjV2NzdiMklmWTJScnJ0V1k3aVN4UDlR?=
 =?utf-8?B?czB0Z2pFaU9hOEJHazFNNFhVdmlNSFRCZGV1RGhTY295RG1mSm1oWFBNQUsv?=
 =?utf-8?B?NXdnWDI0VXJvRzdNQ1l6cnNIdjU4Qk9keVFaUUp1cGgwb2ZOcUV1NzVRR1l1?=
 =?utf-8?B?ZktHS2Z1WDUxMnM1TXJhMWx6V3ZKZlBrUWZVTXFuN0todVh6QjZCa3FwQ0Fa?=
 =?utf-8?B?Qy9CZTJ3VTFnVzBFbld1VFpobEc3UndVNlZiRGVJSEdRQmFYUmQ2Wm5paEo0?=
 =?utf-8?B?azZaRU55N0h6cTNxclgwQkZuR1ExZFhCZ2Q5cDFxMEQ0UEgvVFZ4VFVxa2k4?=
 =?utf-8?B?ZFpYUURSK05heEt5Tlhjcm93SXViV1lCbFh4T1ZQWXlpSTlUU1dRYmNtdkpr?=
 =?utf-8?B?ZmliNVhGREtHdU5FcVFwY0o1TUNaTnlLTXkvKzkzV2NqOU1BZUJaeUtwWXhu?=
 =?utf-8?B?NTQ5czNvdWhVRkhSY2pPanlvcDQ2ZzVXSk5qcUh1Z2tSbUNwd3FpMnFLZTln?=
 =?utf-8?B?dUJBZmluMEVOMEpGQU9hMGh0QTM1d0s0ODRNUkR6c0NuZ0FUQTJDejlxRHJT?=
 =?utf-8?B?alRmdzkyWjFXajBJT1U4TEU1RnlKVFVVVFpSQW9kR3FvNnY0NytEZlN4ekJI?=
 =?utf-8?B?OXpEcjkzVGgyNW00VWxIejJGcTNoNzdYa3U0K2QvYXdGTkwrUGI5UVpEdlFm?=
 =?utf-8?B?QkhMR01ZZmpnengvQllsZ1p1VEQ0WnNFc3Y1QzFxN2RYVExzN0hyRkNHQ01v?=
 =?utf-8?B?QlNkQ2dZeC9TZmxsVHM4NUFHUmZkTSt1SCtRYVM3MU5nQXpDeDdBSmxzb0pP?=
 =?utf-8?B?cm9sMko0TGN1N0lsV2VFdTlrUEd0S3lVK2JRY2UxQmpjeGU2OFZhekIvMzJ3?=
 =?utf-8?B?UUxUSGw5MnJ2QmNjUmJZR1FIQWRaMVpERmNPRkg2empSbi8rVkp3cnFzVUJh?=
 =?utf-8?B?cE5ha0U4Vk1VSlNHVWxJbzVaa3d6bzY3QXdCcGYvZW1lL2ViYjBBakdFSGx6?=
 =?utf-8?B?d0c3SUVqbC9Lc2VlUENOQ0xtVjNmekpJZnpYTmZ4YUljN3ZOSXJUUGpEVkZ1?=
 =?utf-8?B?YlVNKzdReWdNL3EyZkZ5OTBKN1ppbTlKZ0t3ZDJrUVN1UU1USVMrOENMcFBn?=
 =?utf-8?B?MHRoZnpjVUx1cndpRU92NFB0TnpLZkFDYkpWQ00yN2tFK3VUM1J5dzNEeWEy?=
 =?utf-8?B?VEFmbTNQQUl0SlhPSDJDREp6Z3FZeUtBakozZzRjT0hqYXFSSFVKZGVXRU94?=
 =?utf-8?B?bk9UNTEyMnV1dUdwU3RzbnlxQ01ydlBLWVFsMW91dlZtZmRMMXV1THBmb2Vz?=
 =?utf-8?B?ZzlDelJxUTBHR085ekxlT1cyRjNLbnliaWluakwzWUUzNzRubmZOSmRiVHkz?=
 =?utf-8?B?RnBpNkhPLzZFald5OFpVdjllSDJGQ2RxTUtnV09sWXUwSno1a3VzQnJ3ZitI?=
 =?utf-8?B?OWtvcFVlWGgrR1VRS1BOTHZTVEpjbEpzVHpCK0xiTlR5alJFTyszNWh3NWxj?=
 =?utf-8?B?WGVKR1IxZmhiZmhKNHMyQW1BSE5yMWpTQWI2bjlsSHJWQzRwYUhHN2pFZksy?=
 =?utf-8?B?R1dZTXk0bG04WW9GYzN3RjVwVm8vd3YyN2JvNldtQldIVC9tNHpITU10RUVB?=
 =?utf-8?B?WjRtOWZhSzgrWW1qZENzQkRHcTVGN0VDdEFIVHZwZVRadWh5aElmSWQ1RVlR?=
 =?utf-8?B?eTFPUFpZYkJxb1Q2bVl4WVpkQ0huWU9pRjlJWHo1WmJWMGdobWI1SXBqSFUw?=
 =?utf-8?B?bE9kRzdlejdQaEFSUnc2RVBYaGJOclh2aFM5R01KWFdJQ1JSZ0JXMHEvOUkv?=
 =?utf-8?B?YzJycVlwT0twRW1pSUlmTGc1RmNwOVZ5ZGdxeUkwSm9icDJuU3lQLzJKQXRE?=
 =?utf-8?B?blFZZ29NL01VaUxFci9qNzdoMUJUMHFWbldlOFFPc1ZtbE4rN21zNUdrNDFm?=
 =?utf-8?Q?fMNfKzqCBFbmrniCP9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6696.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f04eae5-8dfd-4cc8-0d7c-08de52b587ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 15:07:55.6001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRkxy3UUCBPEmQvx6u/WIAXQTt2UrU9DWgFb8RHbV/jx5IlJtVzeuAACzSylmsX37k3TM2QYLrP0XSdAVS1rUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

W1B1YmxpY10NCg0KSGkgQFRvbWFzIE1lbGluDQoNCj4gRnJvbTogVG9tYXMgTWVsaW4gPHRvbWFz
Lm1lbGluQHZhaXNhbGEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNywgMjAyNiA2
OjE3IFBNDQo+IFRvOiBWaW5heSBUaWxhaywgUHJhbmF2IDxQcmFuYXYuVmluYXlUaWxha0BhbWQu
Y29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBh
bWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHJ0YzogenlucW1wOiBBZGQgY2xvY2sgZnJhbWV3b3JrIHN1cHBvcnQg
d2l0aA0KPiBjYWxpYnJhdGlvbiBmYWxsYmFjaw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ug
b3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9u
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQo+DQo+DQo+IEhpLA0KPg0KPiBPbiAwNi8wMS8yMDI2IDEyOjEyLCBQcmFuYXYgVGlsYWsgd3Jv
dGU6DQo+ID4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20NCj4gPiBwcmFuYXYudmluYXl0aWxha0BhbWQuY29tLiBMZWFybiB3
aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4gPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2Vu
ZGVySWRlbnRpZmljYXRpb24gXQ0KPiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcgUlRD
IGNsb2NrIGZyb20gZGV2aWNlIHRyZWUgdXNpbmcgY2xvY2sNCj4gPiBmcmFtZXdvcmsgYWxzbyB1
cGRhdGUgdGhlIGRlZmF1bHQgY2FsaWJyYXRpb24gdmFsdWUgdG8gMHg3RkZGIGFzIHBlcg0KPiA+
IFJUQyBzcGVjaWZpY2F0aW9ucy4NCj4gPiBGYWxscyBiYWNrIHRvICdjYWxpYnJhdGlvbicgcHJv
cGVydHkgaWYgY2xvY2sgdW5hdmFpbGFibGUsIGFuZCB1c2VzDQo+ID4gZGVmYXVsdCBjYWxpYnJh
dGlvbiBpZiBuZWl0aGVyIGlzIHByZXNlbnQuIE9ubHkgd3JpdGVzIGNhbGlicmF0aW9uDQo+ID4g
d2hlbiBoYXJkd2FyZSByZWdpc3RlciByZWFkcyB6ZXJvLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUHJhbmF2IFRpbGFrIDxwcmFuYXYudmluYXl0aWxha0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3J0Yy96eW5xbXBfcnRjLmMgfCA1MQ0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3p5
bnFtcF9ydGMuYyBiL2RyaXZlcnMvcnRjL3p5bnFtcF9ydGMuYyBpbmRleA0KPiA+IDE1MTIyYTA0
ODM4Li44M2Q2NmFhMWFhYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3J0Yy96eW5xbXBfcnRj
LmMNCj4gPiArKysgYi9kcml2ZXJzL3J0Yy96eW5xbXBfcnRjLmMNCj4gPiBAQCAtOCwyMyArOCwy
NyBAQA0KPiA+ICAjaW5jbHVkZSA8ZG0uaD4NCj4gPiAgI2luY2x1ZGUgPHJ0Yy5oPg0KPiA+ICAj
aW5jbHVkZSA8YXNtL2lvLmg+DQo+ID4gKyNpbmNsdWRlIDxjbGsuaD4NCj4gPiArI2luY2x1ZGUg
PGRtL2RldmljZV9jb21wYXQuaD4NCj4gPg0KPiA+ICAvKiBSVEMgUmVnaXN0ZXJzICovDQo+ID4g
ICNkZWZpbmUgUlRDX1NFVF9UTV9XUiAgICAgICAgICAweDAwDQo+ID4gICNkZWZpbmUgUlRDX1NF
VF9UTV9SRCAgICAgICAgICAweDA0DQo+ID4gICNkZWZpbmUgUlRDX0NBTElCX1dSICAgICAgICAg
ICAweDA4DQo+ID4gKyNkZWZpbmUgUlRDX0NBTElCX1JEICAgICAgICAgICAweDBDDQo+ID4gICNk
ZWZpbmUgUlRDX0NVUl9UTSAgICAgICAgICAgICAweDEwDQo+ID4gICNkZWZpbmUgUlRDX0lOVF9T
VFMgICAgICAgICAgICAweDIwDQo+ID4gICNkZWZpbmUgUlRDX0NUUkwgICAgICAgICAgICAgICAw
eDQwDQo+ID4NCj4gPiAgI2RlZmluZSBSVENfSU5UX1NFQyAgICAgICAgICAgIEJJVCgwKQ0KPiA+
ICAjZGVmaW5lIFJUQ19CQVRUX0VOICAgICAgICAgICAgQklUKDMxKQ0KPiA+IC0jZGVmaW5lIFJU
Q19DQUxJQl9ERUYgICAgICAgICAgMHgxOTgyMzMNCj4gPiArI2RlZmluZSBSVENfQ0FMSUJfREVG
ICAgICAgICAgIDB4N0ZGRg0KPiA+ICsjZGVmaW5lIFJUQ19GUkVRX01BWCAgICAgICAgICAgMHgx
MDAwMA0KPiA+ICAjZGVmaW5lIFJUQ19DQUxJQl9NQVNLICAgICAgICAgMHgxRkZGRkYNCj4gPg0K
PiA+ICBzdHJ1Y3QgenlucW1wX3J0Y19wcml2IHsNCj4gPiAgICAgICAgIGZkdF9hZGRyX3QgICAg
ICBiYXNlOw0KPiA+IC0gICAgICAgdW5zaWduZWQgaW50ICAgIGNhbGlidmFsOw0KPiA+ICsgICAg
ICAgdW5zaWduZWQgbG9uZyAgIGNsa19mcmVxOw0KPg0KPiBVc2luZyBjYWxpYnZhbCBhcyB2YXJp
YWJsZSBuYW1lIG1pZ2h0IGFjdHVhbGx5IGJlIGJldHRlciBoZXJlIGFzIHRoZSB2YWx1ZQ0KPiBj
b3JyZXNwb25kcyB0byByZWdpc3RlciB2YWx1ZSwgYW5kIG5vdCB0aGUgYWN0dWFsIGZyZXF1ZW5j
eS4NCk9rLg0KPg0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgenlucW1wX3J0Y19nZXQo
c3RydWN0IHVkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkNCj4gPiBAQCAtNzAsMTMg
Kzc0LDYgQEAgc3RhdGljIGludCB6eW5xbXBfcnRjX3NldChzdHJ1Y3QgdWRldmljZSAqZGV2LCBj
b25zdA0KPiBzdHJ1Y3QgcnRjX3RpbWUgKnRtKQ0KPiA+ICAgICAgICAgICAgICAgICAgKi8NCj4g
PiAgICAgICAgICAgICAgICAgbmV3X3RpbWUgPSBydGNfbWt0aW1lKHRtKSArIDE7DQo+ID4NCj4g
PiAtICAgICAgIC8qDQo+ID4gLSAgICAgICAgKiBXcml0aW5nIGludG8gY2FsaWJyYXRpb24gcmVn
aXN0ZXIgd2lsbCBjbGVhciB0aGUgVGljayBDb3VudGVyIGFuZA0KPiA+IC0gICAgICAgICogZm9y
Y2UgdGhlIG5leHQgc2Vjb25kIHRvIGJlIHNpZ25hbGVkIGV4YWN0bHkgaW4gMSBzZWNvbmQgcGVy
aW9kDQo+ID4gLSAgICAgICAgKi8NCj4gPiAtICAgICAgIHByaXYtPmNhbGlidmFsICY9IFJUQ19D
QUxJQl9NQVNLOw0KPiA+IC0gICAgICAgd3JpdGVsKHByaXYtPmNhbGlidmFsLCAocHJpdi0+YmFz
ZSArIFJUQ19DQUxJQl9XUikpOw0KPiA+IC0NCj4gPiAgICAgICAgIHdyaXRlbChuZXdfdGltZSwg
cHJpdi0+YmFzZSArIFJUQ19TRVRfVE1fV1IpOw0KPiA+DQo+ID4gICAgICAgICAvKg0KPiA+IEBA
IC0xMDcsMTUgKzEwNCw2IEBAIHN0YXRpYyBpbnQgenlucW1wX3J0Y19pbml0KHN0cnVjdCB1ZGV2
aWNlICpkZXYpDQo+ID4gICAgICAgICBydGNfY3RybCB8PSBSVENfQkFUVF9FTjsNCj4gPiAgICAg
ICAgIHdyaXRlbChydGNfY3RybCwgcHJpdi0+YmFzZSArIFJUQ19DVFJMKTsNCj4gPg0KPiA+IC0g
ICAgICAgLyoNCj4gPiAtICAgICAgICAqIEJhc2VkIG9uIGNyeXN0YWwgZnJlcSBvZiAzMy4zMzAg
S0h6DQo+ID4gLSAgICAgICAgKiBzZXQgdGhlIHNlY29uZHMgY291bnRlciBhbmQgZW5hYmxlLCBz
ZXQgZnJhY3Rpb25zIGNvdW50ZXINCj4gPiAtICAgICAgICAqIHRvIGRlZmF1bHQgdmFsdWUgc3Vn
Z2VzdGVkIGFzIHBlciBkZXNpZ24gc3BlYw0KPiA+IC0gICAgICAgICogdG8gY29ycmVjdCBSVEMg
ZGVsYXkgaW4gZnJlcXVlbmN5IG92ZXIgcGVyaW9kIG9mIHRpbWUuDQo+ID4gLSAgICAgICAgKi8N
Cj4gPiAtICAgICAgIHByaXYtPmNhbGlidmFsICY9IFJUQ19DQUxJQl9NQVNLOw0KPiA+IC0gICAg
ICAgd3JpdGVsKHByaXYtPmNhbGlidmFsLCAocHJpdi0+YmFzZSArIFJUQ19DQUxJQl9XUikpOw0K
PiA+IC0NCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMTI4LDgg
KzExNiwzMSBAQCBzdGF0aWMgaW50IHp5bnFtcF9ydGNfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRl
dikNCj4gPiAgICAgICAgIGlmIChwcml2LT5iYXNlID09IEZEVF9BRERSX1RfTk9ORSkNCj4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtICAgICAgIHByaXYtPmNh
bGlidmFsID0gZGV2X3JlYWRfdTMyX2RlZmF1bHQoZGV2LCAiY2FsaWJyYXRpb24iLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSVENfQ0FMSUJfREVG
KTsNCj4gPiArICAgICAgIHJldCA9IHJlYWRsKHByaXYtPmJhc2UgKyBSVENfQ0FMSUJfUkQpOw0K
PiA+ICsgICAgICAgaWYgKCFyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgc3RydWN0IGNsayBy
dGNfY2xrOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLyogR2V0IHRoZSBSVEMgY2xvY2sg
cmF0ZSAqLw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBjbGtfZ2V0X2J5X25hbWVfb3B0aW9u
YWwoZGV2LCAicnRjIiwgJnJ0Y19jbGspOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXJldCkg
ew0KPiBJbiBjYXNlIHRoZSBydGMgY2xvY2sgcmVmZXJlbmNlIGlzIG1pc3NpbmcsIHRoaXMgd2ls
bCBzdGlsbCByZXR1cm4gMC4gSSB0aGluayBpbiB0aGlzDQo+IGNhc2UgaWRlYSB3YXMgdG8gcmVh
ZCB0aGUgY2FsaWJyYXRpb24gZGV2aWNldHJlZSB2YWx1ZSBpbnN0ZWFkPw0KV2lsbCB1cGRhdGUg
aW4gdjIgcGF0Y2guDQo+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJpdi0+Y2xrX2Zy
ZXEgPSBjbGtfZ2V0X3JhdGUoJnJ0Y19jbGspOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IC8qIFVzZSBjbG9jayBmcmVxdWVuY3kgaWYgdmFsaWQsIGZhbGxiYWNrIHRvIGNhbGlicmF0aW9u
IHZhbHVlICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHByaXYtPmNsa19mcmVx
ID4gMCAmJiBwcml2LT5jbGtfZnJlcSA8PSBSVENfRlJFUV9NQVgpIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHByaXYtPmNsa19mcmVxID0gcHJpdi0+Y2xrX2ZyZXEgLSAx
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJJbnZhbGlkIGZyZXF1ZW5jeSAweCVs
eCwgdXNpbmcgZGVmYXVsdCB0bw0KPiAweCV4XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcHJpdi0+Y2xrX2ZyZXEsDQo+ID4gKyBSVENfQ0FMSUJfREVG
KTsNCj4gSW4gY2FzZSB0aGUgZnJlcXVlbmN5IGlzIGludmFsaWQsIHRoYXQgaXMgYSB1c2VyIGVy
cm9yIGFuZCBpdCBzaG91bGQgSU1ITyBiZQ0KPiB0cmVhdGVkIGFzIGVycm9yLCBhbmQgYmFpbCBv
dXQgaGVyZS4NCldpbGwgdXBkYXRlIGluIHYyIHBhdGNoLg0KPg0KPiBUaGFua3MsDQo+IFRvbWFz
DQo+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcml2LT5jbGtfZnJlcSA9
IFJUQ19DQUxJQl9ERUY7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHByaXYtPmNs
a19mcmVxID0gZGV2X3JlYWRfdTMyX2RlZmF1bHQoZGV2LCAiY2FsaWJyYXRpb24iLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUlRDX0NBTElCX0RFRik7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIHdyaXRlbChwcml2LT5jbGtfZnJlcSwgKHByaXYtPmJhc2UgKyBSVENfQ0FM
SUJfV1IpKTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHByaXYt
PmNsa19mcmVxID0gcmV0ICYgUlRDX0NBTElCX01BU0s7DQo+ID4gKyAgICAgICB9DQo+ID4NCj4g
PiAgICAgICAgIHJldCA9IHp5bnFtcF9ydGNfaW5pdChkZXYpOw0KPiA+DQo+ID4gLS0NCj4gPiAy
LjM0LjENCj4gPg0KDQpSZWdhcmRzLA0KUHJhbmF2IFRpbGFrDQo=
