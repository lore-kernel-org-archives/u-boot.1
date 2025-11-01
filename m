Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A27CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 04:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71555839E8;
	Sat,  1 Nov 2025 05:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YZ9m4ax+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F152E839DD; Sat,  1 Nov 2025 05:24:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06CE839DD
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 05:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR2Q1WCshgF0J6UE+p/ertPw9rQmKFXwzyEGht31pbJ8xoXjsae7KVT5nB3V3cQHFrDE6LyChrbwPmy2WsjBaoCY6I1P9fsnl698IVzDnTE7/vgJwEakQyL2fVHLvqKOlfB84QOl+twu9KWCiyqxbg1Kd/+iePgEJM4zxECiFOEFote2Ud7zABYaGu/YSd7yxh9JUQt4UOOokxCkq9YCQ3ZU5XKR0jnFLeeNJbftUHUSAKFLM1fGlw/TleAii/7FYUnLX0xJ3lgLP3R8eGXd/9RqD0+UNtH//9Puwq6j12t3VLHGFMHPwJJ3dGxdIXtvnN7BP3Z6vcrZNjyiGl/1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63iUcw0PsomSz0cmBOpLJJ5HepPRypTK75ufiVBdG60=;
 b=SxmIHsRkgx9W0nOidiNbBoTrY3Gp/VimSDmScmr4o/80yZH5ahNEa0EqG0e4QgXQJbm5ox57rtQaq8QRKqJusuPOwN9e/jBHIat0IlSILDBu1j+3VlaDYKQCCOrW6uKJUmYKUTxbRT7ba4ThD9DV/k7HrIo5i8TNTn0c+AWW5bIJRil5J4BEJC0dD3mMhywPyalv5lwl/W/4bfx5ZAduSoydKuTiiJHKwGA3YBfVozKV7Y4Rovk6TFbE8lF7bjAzbfC84AYh9ByPDauUULZcpZFt5gxj4ERn5TaTKj+Dza8fL2lHv/ZRO7gYdCSAC5aZ18vvQqeIeP5WdAYW5Y3b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63iUcw0PsomSz0cmBOpLJJ5HepPRypTK75ufiVBdG60=;
 b=YZ9m4ax+Upp8dk1Aq67wORrOMDCDVY2QNV3CXD+udtJPMlxbfzDNHxLygNsiDQCteaTRE9+5l2ChGB+lq787Q1HPhKz7itpVr5kgfrjFrD6MF2Rhc58XvOwzpBc8VoTWQtJyvCfP1gh2hDWQ4oC7rfqgbIIVBLzsNLyyhY6GKPptioOGVjWHVhfCl/+OI8+bkuhFeEx9VBaz9N1serfLE7pKzeGjRhztQTRT4TPnbcwPSMDjLB6S+sOi2PIF/4/tQSvaPvlRRBbypJwlecGvSZ46eIkfAZ4Ngkh9iObwwz5IpqpI1NuHXNS19X2RWSiFXlLmbaCbaE1FSIlS1aXe8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8323.eurprd08.prod.outlook.com (2603:10a6:10:40c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 04:24:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 04:24:31 +0000
Message-ID: <04f5882c-2d90-46ed-ac14-29d2eab964c8@iopsys.eu>
Date: Sat, 1 Nov 2025 07:24:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
To: Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: u-boot@lists.denx.de
References: <20251030190710.18848-1-cnsztl@gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251030190710.18848-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcb5fbe-d67b-484d-a3b9-08de18fe8da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjBZRnVtenFaaDRHVmR5dTRiak13S1luZko4eVBnRTBLV1BybDl6OW4vS1Aw?=
 =?utf-8?B?WUZHT2t4dUt4STZIUEh6ZlF4QTdHSWVsRlFmRFpaL3ArL0tXWHVEYkpCcHhV?=
 =?utf-8?B?aEljbmlOVnlwZmoyMVNLdDVPd0NYZ3BPRkpyVWZ3NkFvc2pVQWNFclFpTDll?=
 =?utf-8?B?TEZjRG9mTk95dEx0MkZRS1k2bTRramxtNjNjTXkyWWpJcFVwSGtrUnh4OHZI?=
 =?utf-8?B?aGdLN2pYRk85M0p5RjdPYXpwSHRkRHhUdXorS0NiTUhSdWFNT2tnNUk5Mkhr?=
 =?utf-8?B?ZWV0cVgvdkI4M08wZ1BWWm9CbWJOcU0wTmx2M21HTEROSFFWQWgzVFlXSFVa?=
 =?utf-8?B?ZDNZbi96MFd6SURyTS9SUlYrekdZa0wrcGh0UU5sTTRjN2xXaFBYTUZDSENH?=
 =?utf-8?B?WFFONTNWeUxBczl4M2tCQTlneTBWSlk0WnhRN3E5QmcvSkV6RzNycGlhNU1v?=
 =?utf-8?B?QVorblJJdDZrWTVqRFQ3V0Z6MWFqTk1Fa3V4M2V0NGhoMFc2NUNKK2dSeWZG?=
 =?utf-8?B?M3JHZG5HUHB1bC9aUFFLVHViUVlWMHFXRWV3QjEzc1p1WnlDRk9NY010UHVP?=
 =?utf-8?B?VlA3TlEwNTdMeXRzTmdYYVozR2VWNEcydUVkcEtZOW9ESUpSSlVldkdXc3ZW?=
 =?utf-8?B?YlBWdndubmtIb00zVjRPa3YzTnFQNzRxdkgrY1NjeDVjUGJvZ1ZoenFGTytZ?=
 =?utf-8?B?SHp3MEhPSU5JeUJIZWlzMi8xVWw5c3Q0dU1SV2RFM0luYmRVRFRzdXNMYkMv?=
 =?utf-8?B?NVNtRkZraFVyNk03R3F4VnNTMWdHTDNlam1qSkt1OTQ0NDJXNTg2WGZZTHI5?=
 =?utf-8?B?dU5WL2t4YlZidjdFOXdmbkQ5WXY0RU5aQ3djOGtHSG9FVHRpUVJUZ1NZVzJG?=
 =?utf-8?B?eXFTS3BXL2xlb0F2SHp4VEJmcFgzdUwzeEZhb29nVDN6SGE4VHcra1ZqdnR3?=
 =?utf-8?B?amRCNFlFTjFObzBpb2didEIyKzQ5TUp5K3pGa3JVTzNpS09DakV5RFB3MFVD?=
 =?utf-8?B?MTF4aTBKNnBHbW5ueEN2cWV5b09OUUF3azVESEFGZlVVa21kc3BZNXpZVE5K?=
 =?utf-8?B?amx0S0NJcFZpQWJjbVhnLzhBTHIrMThubGFicmVFMlM2QlIwQk1vMEhjL3V0?=
 =?utf-8?B?Z0R3MWN0QTdaVm5nWFE1bUhyM0ZGM1NrY2Z6VDM3NFZyYlJ4NUZtbXZnMmtV?=
 =?utf-8?B?Y2dnRVJPVjgzdWxFTVNJQ2JCbG9JemhkaGpIaFFnS1RSY3JsZG00QmdCS0I4?=
 =?utf-8?B?MmtkNUVjaHR1MDBSamZOY3MvZ3hmSTVRL255RWk5ck1Pb0VLQ21NcVJzVTdG?=
 =?utf-8?B?amNFdWxSNXByZmFWbjlMY1A5OGRsM3kzOE83ZEdyZk03K1ZuVEhUaU1xUzNX?=
 =?utf-8?B?RnJPRVBaKzRGM2IybCtsMTl6UXpVZEdqMFdMZ3lBTzhqbUZCOG16aENXNjUr?=
 =?utf-8?B?TVplRWRML1BvL1BhdVh1aUJmKzdqUklrSVU0YkhINVZCYXVKb2pxM3JCUi9y?=
 =?utf-8?B?cytjQlFKYUYwM256U0FseXh6bmxEWjJDZXBuMkJxKy94bktLRXJjOGMzL29Z?=
 =?utf-8?B?TWdNVVliSTlWOVhvd1RuYUM0VHdjY3lRSEdxdnRLZG40S2I0bGhSV04zY1ZI?=
 =?utf-8?B?ZVIvOXZBZHl6Zmh1Q3B5VHorNnpKL0hrUytmb3diSXR1S2RFb2VUUzNCbS9Q?=
 =?utf-8?B?Rlp3Rng3SXNNM2hYUVE0R09mWm1zNGdXUzJvTTdGWkJ4dEN6eHEyc1RjZ3o0?=
 =?utf-8?B?R2tndENQZTg4K3NVaUM3aGVzaFJ2Um9aTmVBWnZ1bysyd01mZ2ZqK2l6anMw?=
 =?utf-8?B?R1lETWdHZVNUSjA4czNUZFdrQWo4TlpNbVd3OEZqVW9qTEpaUHJMK29OR2Y4?=
 =?utf-8?B?ZzExbllWMmdWd2JSNGNJeVg0b2syQ0pNYVo4Yktxcmp2TlAxeXE4KzNteWI5?=
 =?utf-8?B?dGs2SmRGalRMZloyTDloOFY5Y1ZBeGptVThVSnFPbkpRM2NXR2kvWThKNTY0?=
 =?utf-8?B?MUdBSWJ3dXB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtsYzVGN1R1K2QyRjYxWVpMVGlsSW5mOHZubzNVYW0rN01IWEd5aVFPSXlK?=
 =?utf-8?B?Ty9NSUZGOVNRMUZvdTVDVFdVZUFiaHQ2R2hhWld4ZXlZMGFVOXZOKzJyampm?=
 =?utf-8?B?ZzFDYTBLVVRRMjFPUHVyTFBsMnJoMkIwVXBYcThMOVBOZCtkbTQ2aXBUZGtB?=
 =?utf-8?B?U0FPdGx4S2UxNTdMSjFvRUhqWWxpWm1uZmJGVEtLZTdhbk41a09CTDdqb0tn?=
 =?utf-8?B?ajlZMUV6aFlFQU03N3BDdERJYVhOdzVvd2ExTnRkQmdqRW9sQ1V2N0YwSzEy?=
 =?utf-8?B?Z3piK2NPRU9CMUdsb3oxZnpPVUlRUGhodTcwMXBaQ2pWejdWazZlSnRNbTBS?=
 =?utf-8?B?clM1bEZ4Q3JadVNmOUo4dVVBbTNPY3kzWGRjQ05EZ2FXMG9xb1NHdk5YN3RY?=
 =?utf-8?B?SHVvT29MTnZkODBuY2VNZHdPTGFXSlhyUEhPUUh4dWJ6VG9la1RNeit1cGZH?=
 =?utf-8?B?RmZjN0Zqam5QZHRBMXp0Sm5yYTRKYndyUFlrYVNuVUt4a1RiTWNKdDYrRS9D?=
 =?utf-8?B?YkZaa3ZGRGVNbUJMeGRRejlWTzNTM2RpK3hXQ2FuZTdiYnFjNzVOcU0yRTlO?=
 =?utf-8?B?Ym11Nm5vRklmYmF2bzMrejB4MHg3M1lCTTFKaWZpVmIyT1Raam1JVm9VcGxV?=
 =?utf-8?B?cTJUSUY4TEJpSml1dkpRSHhrOEJkWnhERE03VXhXMzUwK3FSOFVwQllOOUtU?=
 =?utf-8?B?aHBPbk5CYTFlZWM5UE9JWGdReUVJdjNnTVBweFNGV0l3UFpURVRrTUlaTS9r?=
 =?utf-8?B?Uk5BRGhpOTJGMFR1cHBpT25CY0VqWnV3d3M3S2k3b3o5U2NUVnVPYks3Vnpt?=
 =?utf-8?B?dXFmVE9jMmpkMDhmRWFJaUNTRXRsT1JzK09mQ1JNZ3ZMRnZuK3FzSml2aHl0?=
 =?utf-8?B?MjFwVlJsb1pmM3ZiSzdiWkNsaGVGK2Q3NFdDSlVLOENVeENsK0UwZ1BnNm9Y?=
 =?utf-8?B?Z0VFTys1Sm1NTmEzWXZLdmdKNW54b1RkaUFrMXV3UzN6NUFIbkpsMFdkZWMw?=
 =?utf-8?B?YklKNEUwZ2dUUVRyNXRCVlF0dmUvcWhXaG54R0xBbUltKzJFYW1FUXJHclly?=
 =?utf-8?B?d3ZCNVlZSSt0OXptMkVHRlhRZXRNUXZ3N0FZVEROTUZXbzJNeVprNWJlbHVN?=
 =?utf-8?B?M1BNdlZZc0t6d0hsYmpuMW8yWnpmamVqbEtVdjBFSHMwLzI0TUtjNkZJam9i?=
 =?utf-8?B?Q0V1UTF4Szg1cE5IZUJwaTlrSUZJdmIrOWxWQTlVMG12R0JTSmU3OWYxSnpn?=
 =?utf-8?B?QlgwR1hMK2x2WEIrOE5BUlk5MmRsaVIwZjNXYjJsRTQ3TXB4MW16VXVFTVhB?=
 =?utf-8?B?MDB4ZFNseEVVbjRFb3I4Z1RIWWNJTUphK25La0lCZzNTSFYxOXJ5QmJDMzF3?=
 =?utf-8?B?WVFOblV2MEVJUngyQ2dCK1B5UWFiSGhJWkI0NmlsckUrNUJhUlMwLzRsWXky?=
 =?utf-8?B?bEtFbkJ6N2xEN3c2RkVPYk9GR1EwT3Eyb3JTRjd1RE0vNjRrc1BCMTV5NWZa?=
 =?utf-8?B?bFpZZUFGSEd2NmpKOVhEWlZGcTlnWXRSK3lObWhjUmJWcVp3ckRUdFEwZXNz?=
 =?utf-8?B?Mkl1YmpsZGFaL1JndUpNL1U2VGowQVVXcitzbmFmaFJmSDBlSDRyTE9ZdW80?=
 =?utf-8?B?VGg0UUFqeVlPdnZHRVkxUms1TUpycVAyZTZqSVMvUzc3WWkrRTdlV0VKVjJl?=
 =?utf-8?B?TWxDYmQ2NG1FbGhpZGExaDFaeTRGSWRycWFES3E0ZStJdW9lcWFXbkJaV0JD?=
 =?utf-8?B?cndCbDdabGVUTjh5NnZmcEliRFBzNk1vOWZnWURPOU5Ga25yaE9HUncyemZL?=
 =?utf-8?B?aFozV2w0TTVEb1NKWVA2bkNaa3VmUEt3bFlkN0RmQi8wa3NRb05uV1dJQVYz?=
 =?utf-8?B?d3dLY0xQckdCdEtzMlBjZFJZcktURFhoQmhuYUtzTUpZbVpTcmF4TWY5ZjVI?=
 =?utf-8?B?RzBiTm1JRzN6OTk2em04UHpVRFM3M09wVFBBdEtvd3lna216bmdHai9LbWUr?=
 =?utf-8?B?cnBBRkNITlJhdkdReXFidnBGVUtDcjZZUTRtR0lyc3hLUjMyMVIzUnVDVmI0?=
 =?utf-8?B?Vm1FaWlVbEw1UTBuRTZFNDh1djQwNWhkdkR3LzlIQVdPNlRaQUFzMkZLdkF1?=
 =?utf-8?B?RXFvZnpMT1hoYXhtUTFWcnN1R0hBNXA2S0NZMURuWFVpMUIzaXpvek8wQTcz?=
 =?utf-8?Q?0kgAR0/buxmov4vJLO92PXM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcb5fbe-d67b-484d-a3b9-08de18fe8da6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 04:24:31.1833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TDiGE588O54tHMr6lH/7EPUnUEwvG1WvsbLJnKp1hjrOwJi/+zMsb9E2XnI5DXmbWAo34U8TEbRkHX7LqH3LMn1tSCY7qcBekQwqI5rBhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8323
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

Please also replace spaces with tab where possible

On 10/30/25 22:07, Tianling Shen wrote:
> [You don't often get email from cnsztl@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Add support for FudanMicro FM25S01A SPI NAND.
>
> This driver is ported from linux v6.18 and tested on a MT7981 board.
>
> Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/fmsh.c
>
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 152aa1a3783c..a7a0b2cb4b9e 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  spinand-objs := core.o otp.o
> -spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> +spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>  spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
> new file mode 100644
> index 000000000000..84a567919ebb
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/fmsh.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
> + *
> + * Author: Dingqiang Lin <jon.lin@rock-chips.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_FMSH               0xA1
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       return -ERANGE;
> +}
> +
> +static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
> +                                  struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 2;
> +       region->length = 62;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
> +       .ecc = fm25s01a_ooblayout_ecc,
> +       .rfree = fm25s01a_ooblayout_free,
> +};
> +
> +static const struct spinand_info fmsh_spinand_table[] = {
> +       SPINAND_INFO("FM25S01A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(1, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer fmsh_spinand_manufacturer = {
> +       .id = SPINAND_MFR_FMSH,
> +       .name = "Fudan Micro",
> +       .chips = fmsh_spinand_table,
> +       .nchips = ARRAY_SIZE(fmsh_spinand_table),
> +       .ops = &fmsh_spinand_manuf_ops,
> +};
> --
> 2.51.1
>
