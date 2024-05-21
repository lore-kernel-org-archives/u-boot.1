Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A4FC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 14:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4008875D;
	Tue, 21 May 2024 16:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="ehqDr/Az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05A588775; Tue, 21 May 2024 16:31:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7200C88744
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 16:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L9dMQF025509;
 Tue, 21 May 2024 07:30:59 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y8s60rvpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUtUB3OHXBc7rc9o7y/fh/sSdtoAfRDPh/vyxNyc8yraNBKOyt4689fIBkuW8p5Ca7+1dJQqWvVS07H0p0HuOnbLlROO89/Jv8JSRmtpgpY4XwKAR9vedmEdvaKfPNdVk4RtGYvpePGfs0hWO9SP/iZOhj2hpCyhUZKaRDVoQxwF9jcWAiZ6cliEycPUG7w+E/wGXmGC03RfngW37sxRfEtlg6uL8LK2+YHqmM3I1qUvgDDsuqW5T689bc3vG1rICkR/qMLhzk2VEtJYrik7s4a3l804TDAMd6ZXj87uwzqTKuaOvGN8Q0AnXq1XlX8r5TPdCUvY8SEnJ8uuJnAV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFn1dM98syKWENMWk3KIdraGz2ROBUFzTPGKInIaKSY=;
 b=K3U754uOumoQJ5K4AhmHWEAnjENt8qwE2KgOG3V2GQqtHEkUgR9HIErz3DVwOFf9iIwLBfF9PivxNP3NiM8LmI3NZJE1l2Vr+x+nQxQ27R8b8yz+kY4Sl48G/v3n5UkISAJu71uT5Gwkm0mUHRewcXy3HR1C8L9ayCgqf5xT9b2e4oWjT+HVxYmiptRZYsej1hF2MvCdtoHq8SYWvjlYZ6zz7Wgv+gP8zUNwMvX2dJEJafqtDopEtY/1OgtiQBg832oRUYjNYk96M7j3VhpfNuiP8A0qHahaoqNPtQ8TFt0/PqT+24sBDO9pnRzOB2u4NrQTODw2co296ZDt931ESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFn1dM98syKWENMWk3KIdraGz2ROBUFzTPGKInIaKSY=;
 b=ehqDr/AzNRN9o6oWDxvIHI4yAWweEhyyJmGHmUVRdhV8EFVomVZx6Ft3wPwQeJa5UHMClK9JN7nHW5o+9mDshclQ9EiC4S9cmJ4a4XaY7AEiaH6x/IFwVmkrYqxRX4fURdBKHUmZ2jv1R1bEKBt+fK6kJCufmed+Y9kc2eZHLYs=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by MN6PR18MB5415.namprd18.prod.outlook.com (2603:10b6:208:473::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 21 May
 2024 14:30:56 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:30:56 +0000
Message-ID: <89eef6cf-c2c1-24ac-225f-e104580e99b8@marvell.com>
Date: Tue, 21 May 2024 07:30:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip
 return on page read
Content-Language: en-US
To: trini@konsulko.com
Cc: Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, hs@denx.de, sr@denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
 <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
 <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
 <CAOf5uwktymi4uvZTBA5hJ6EfdyytteSUDM_b2TyPKFJsu2LLSQ@mail.gmail.com>
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAOf5uwktymi4uvZTBA5hJ6EfdyytteSUDM_b2TyPKFJsu2LLSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|MN6PR18MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 395ce88d-94ac-4c66-7d69-08dc79a2a056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjlzVkE5Rmd6R3J6M2VFWWQ0MDRhZi81SVVpVGJEWjByQm51RzExSFlmMG14?=
 =?utf-8?B?R293bFZlYXBUR1U3SXhrTmVJc1BXT0VEWkJ6QXFNd0NpcDAxOHZrQ3JyRDhl?=
 =?utf-8?B?ZXFKNHJBNm5wblRGRmN4RGREblFZQWRVcFl0L3pCb3FuT2ZEcVcvck5iV1Av?=
 =?utf-8?B?WFlWZ3pEUEh1SkFmMmlNbTNDc3N6bmc4cnJBN1pRNTJzQ2d5Q21PcVMxQkhr?=
 =?utf-8?B?VXZEM2Y5OTl3Z01YejRjQ3lwOEU4cUlEMEtJWTVRditCbmF0MXhycUhobUlH?=
 =?utf-8?B?bDR6WGxTR0VrbTVWSjdZdFBsTmhBU09VSlU4R052d2lNb1JaSkExV3VFWUVr?=
 =?utf-8?B?cTNGRFZrSUdnZE9XN295Zk9MV1I2UzYxNW5VOVRXWnMzZTZHeXBGakRYTUpn?=
 =?utf-8?B?YlZLTk16NDFTMzl0SlRpdmErYnZvNUJmSE05aGpYMHlwYVlFdFRZNTh6Rm9H?=
 =?utf-8?B?d0ozZTZxWmdWYnUrczlLQlVvYklTclljNkoxaTR0d2dSRVNPeDE4QTgyZWNV?=
 =?utf-8?B?MHdMaDdPRnc2cVBudjZUc1Vlem05ZHY0N0YxRkZuQURlWU40OFE2OTMvTmVu?=
 =?utf-8?B?S3gxTkFXM2xJSEFCK0l6TFR1clIvcVlqZWlGMnZmeVNxdlVxck1jVGFRYWx2?=
 =?utf-8?B?NDNuZjVMZy9YSU90eFhtTmVHR1JEVGJSMHJTektRM0daa0tUY0ViWGJ1eldm?=
 =?utf-8?B?d2psTjlzeXBjeUxlQkNjblEzcGdGOVp0V0RiYUdXTkMzZDc4Y1RySTZSUVpS?=
 =?utf-8?B?VGdTNCtTVm1VZkllS3FXbmYrWGdKNXdVdmdEVHhHY0wrTnMwalRxUUNSUU8y?=
 =?utf-8?B?NWRaUEM5WmtXZCtVcDREb29LTll3WThPd2JFaGd6SmlRZE1MUVA5REsyUlhG?=
 =?utf-8?B?c3RDT09VTzNsUENyUkpHdVZRN04xb1ExYWRJOE9hQmRqOFBJMERCQWdnTk5s?=
 =?utf-8?B?ZENMWllwOVgxL0RJYXNCTG9QVk5vZG9EUUF2MXZsU3ZncXBudHJ4SkZBcGxC?=
 =?utf-8?B?YUlYdmdrTVNaQXVZSlJIaUsvdnJpYzRZaklVbFkreHFZN0JSbmpxREtOV0xM?=
 =?utf-8?B?ZEkrOUQwWFlsTkJXTmlQaVE3TVV2MG1iZkJvZ3grd3RjT3RhRmhFUnVEUjhY?=
 =?utf-8?B?UzdBSUcyd0U1RDVic1lnQnplLzRZMFZTR1ZjL00wTjh6OFJOSHBxek9mRW8v?=
 =?utf-8?B?RERmT05XOUtLMy9OMVBGdVFJcUFKb211dlVpVWZ6RWJoWXF3MUtMR1YwSWRX?=
 =?utf-8?B?eTJ5cUlidk5mbjFiSEU2bmFCNlRVamxZMnFLRDZDcVZJL3pQWUQ2SGgyMUhJ?=
 =?utf-8?B?OU1xL25PZ2hIMDVBenptRldzNFB0dWhwWlptUjkySEpoWG9kbXY5Um56dDVF?=
 =?utf-8?B?bzZxcVh3MFZHZzQ1UjlWR3VmWDlYamIrMnJpWktJOERPbWRSWVgybE1qOTZW?=
 =?utf-8?B?SExoUkMvNnBlZEZ3NWM1ejNldzdHWDBDUWd3RjF6RGREZWczMXB3MkV4cGFC?=
 =?utf-8?B?WnNKa0U2UVZGTlVpeDVGM2ZmQ3RPZ3lsRFBidFdjdm96S2dTSXprdktBeDdo?=
 =?utf-8?B?SlFhQldQQmsrdmNUYUwwSHlmamdPZ3o0YWJVU1RXR1cyYnJLSFlXbS92Ritr?=
 =?utf-8?B?TmV2cFVnK2l5UEZVbHJzMVplWDNkU3VTNHhUZS9qa0cwNVNiT29zMC9OSE9o?=
 =?utf-8?B?U2lXaUI5WmdoSjBYdWo2QUV5azBjUXFveG96clNIckF6bnduNlpyQ3FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXljREdoamx5SDAvdndPOENFN1BhZG1kOWZVREFlWW53T3ROdVhFcUNVeUFq?=
 =?utf-8?B?T2swenNrR0svcTUyNEEycU5hSnhmeFo3d3Fpd0UvNlJKMWlxRzFCREh0Y1U5?=
 =?utf-8?B?S3lCNW1Bc0c0VHhoRjhCa1l0VUtZV0V4NFZYelk5U2hZWXowdFQzSXpNL0pW?=
 =?utf-8?B?ZmpjZXZVZjlFRjUzOVNEZkJILzJYODFVMUhhNHJIUlordzIvYkNnVHZ5dG1m?=
 =?utf-8?B?eGpNZy9CazBocjJxTG95d2gyWVZZRTF2ZktQQUhZOWJGREIyN216VitHamIy?=
 =?utf-8?B?czNLWXRTeFRqN0J1SFR6MTRNRzAvQ0s5RTU1S1lJN3BzbWE0ZDRlQ05YMVhi?=
 =?utf-8?B?KzAzSDdBN3FjNXdUQXk2OWZuaDJMR3RlR1RpaFA0N1RVMkdGYXJlTUNLYXNh?=
 =?utf-8?B?RzFVcnFPOU5MNXRuaUhSWW9IUVdVWnM2SGgxeWFYYkJnWW1va0wyejVoQ01p?=
 =?utf-8?B?dDhWL0VNVHRHQVRvdFRPMXdyZENKNzN1aFZZR3ZaWDBkbG4vQXFrNDAwTCtw?=
 =?utf-8?B?R2xqWXZ0OUhTTkd1SVFuUWdtdVUxMkZROSswMzRFYjNsTEpkQXdsRVpBK1Vl?=
 =?utf-8?B?cTN4UG9UV3NSQ1JZbGM3czZjbFYwTE9BS2NnVlpIMkppKzY0T0U0alNiQ0lv?=
 =?utf-8?B?d3V5M1pJL1BHYXd5RDJRL1NJVjFCanpnRFRVQU5FZElrellVc3hsRU1wSytv?=
 =?utf-8?B?R2dHTUZ4a0Z5clltYmQrQ3k5WU1tNVJCZTFJVFlkRUx1TnVjek9wazFCU2FO?=
 =?utf-8?B?Vk84WUxNaWRGS2RJTEFSdGpkaWFJUHVmUmVlcElUYUcyTzFKZE1pS2hhenls?=
 =?utf-8?B?aVZhM3BCUVd2MUp4WGlraUcvYnhBK1hJS1lBVFlhK01VR2dycmY1SzNBa01t?=
 =?utf-8?B?TVRSU0Q5MmtpNCsybkxMeGNCVnQvcG9CZGZXNlA2UmtHMlN0VCs5TG8rNms0?=
 =?utf-8?B?YVl4WllodHRhbllaNlRISjVWUEx4eEJ2YWs0QXBoQlU4UGl4eHpsWVZuVk1m?=
 =?utf-8?B?eTVVb3BmUWk2akJYSncrR2NFZks2WStqMmtla2hWeHRlc0ppTm5ucm1KWkI0?=
 =?utf-8?B?L2c2UklRMC8vNnBrM0RXUnBDQnIxRlBubVVqai9EUmpUUEY5cjE5VnZIQi9r?=
 =?utf-8?B?eVY5VEpTdlV3TXdyS0xVNUJLbjlGdnovWThrL0tNbXgvRDZIYlAwUndyZGE5?=
 =?utf-8?B?S2tHOElXa2QxQlZaUHdFSldnd2hVa0hiL2dveVBZMSs4WHgyQmxpNUY1MUVE?=
 =?utf-8?B?OE9DUjhJdnkrR3dMdkg1bWF0UU1nQVQxbzNteTc0a0NuRVJyKzZxWFhVZzFz?=
 =?utf-8?B?Mk5uU1p1c1lPbkF2TzFYNlZjalgrdW9FUFlzMUZxRzFMRFNiWUc3T050a1h2?=
 =?utf-8?B?dlh3VXVBRjlJTzVVdjVPUElVZENiTnJPbHlsQysrMjhENDhXMnlEVC91YStM?=
 =?utf-8?B?YlRMaEZLQnlWNnlOT2h1WWs0eTFiMFNOdmRYZm1TdytaUVJKWWg1ejFtTlor?=
 =?utf-8?B?MHF2SlhMVkRyQjRBbVF5dEVaVkwvL0dkSlh6djROdTA2TE5WUWxkdE9Qcmds?=
 =?utf-8?B?cmZvTTQwL2tqZlUwYnFBZ1lWK05JbmpDb3lsTTgyN0FoN3FkZDdZdU5VL2Zp?=
 =?utf-8?B?bmFJeERxUHUrYVZlcVJ0MGNzZ29nS3A4cTJvdjFuY1l0VUxGMXl0R0ZXMlNB?=
 =?utf-8?B?MTgrN1hJV3h5TUtIQVNyRER4SUdjcDR2U3FkQ3JJaXVwMktSVnF2bUh2RERX?=
 =?utf-8?B?djd2eDBiZHNzd21pVVlITmUrS295NVdFRDl4cmd6UDVuQ1dQa3pKRmJrUTE2?=
 =?utf-8?B?dzd5Skw1WGxIME93TUhRVG1vNXRpTWpHU0xEZ2c3dzlONlc2ZmUxLzNNVnBw?=
 =?utf-8?B?UWpKM2o5Zmtib0pFSUpCOUhnaFhCaGUvKzVYdTgvRXZvZHE2Z2VGTWV3V0NT?=
 =?utf-8?B?UDhKTWJuWTdYZTZ2WjdtVFNvclhYYWJUbGg1NXQvbmU1a1RtUmo4WGFSQ1p3?=
 =?utf-8?B?Mi9RS3QxaTl1Zmg2VHJaaGZ5R0ZObGcxT245N2dSODM5THAvT1ZCSmVjcnZL?=
 =?utf-8?B?UHFySzNTdHNhVzJvb1NBMlhQM1ZuSEhvQ1BGbG1OT2E2L0JxSW5LeEtxdkVY?=
 =?utf-8?B?azd2cmhrcHZMQ1lhY2hnN1FxZ2VrWDlZZDJ2UEUvTDlrU2dmeElxMTJ2MDBu?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ce88d-94ac-4c66-7d69-08dc79a2a056
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 14:30:56.2780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TlGKJDK1xvx1jDngUdX5J8dFyOXdWjcfWOhjkDmULXwdeHgD8RaQzD/AdznzHqu08KEP2pco2Dnks0Rurdk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5415
X-Proofpoint-GUID: pl6n7Qs6fCd1seW6pnL6n-pD8oKsX301
X-Proofpoint-ORIG-GUID: pl6n7Qs6fCd1seW6pnL6n-pD8oKsX301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
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

Hi,

Can you please merge this PR, if there are no more review comments?

Thanks,
Ravi
On 5/6/24 11:28, Michael Nazzareno Trimarchi wrote:

> ----------------------------------------------------------------------
> Hi Ravi
> 
> On Mon, May 6, 2024 at 7:33 PM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>
>> On 5/6/24 00:35, Michael Nazzareno Trimarchi wrote:
>>> Hi Ravi
>>>
>>> On Tue, Apr 30, 2024 at 6:25 AM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>>>
>>>> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
>>>>
>>>>> ----------------------------------------------------------------------
>>>>> On Mon, Apr 29, 2024 at 6:22 PM Chris Packham <judge.packham@gmail.com> wrote:
>>>>>>
>>>>>> On Sun, Apr 28, 2024 at 4:15 AM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>>>>>>
>>>>>>> Once a page is read with higher bitflips all subsequent reads
>>>>>>> are returning the same bitflip value even though they have none.
>>>>>>> max_bitflip variable is not being reset to 0 across page reads.
>>>>>>>
>>>>>>> This is causing problems like incorrectly
>>>>>>> marking erase blocks bad by UBI and causing read failures.
>>>>>>>
>>>>>>> Verified the change with both MTD reads and UBI.
>>>>>>> This change is inline with other NFC drivers.
>>>>>>>
>>>>>>> Sample error log where a block is marked bad incorrectly:
>>>>>>>
>>>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>>>> ubi0: run torture test for PEB 125
>>>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>>>>>>> must be bad
>>>>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>>>>>>> ubi0: mark PEB 125 as bad
>>>>>>>
>>>>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>>>>>>
>>>>>> Looks good to me
>>>>>>
>>>>>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
>>>>>>
>>>>>>> ---
>>>>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>> index 1d9a6d107b..d2a4faad56 100644
>>>>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
>>>>>>>         info->ecc_err_cnt       = 0;
>>>>>>>         info->ndcb3             = 0;
>>>>>>>         info->need_wait         = 0;
>>>>>>> +       /*
>>>>>>> +        * Reset max_bitflips to zero. Once command is complete,
>>>>>>> +        * max_bitflips for this READ is returned in ecc.read_page()
>>>>>>> +        */
>>>>>>> +       info->max_bitflips      = 0;
>>>>>>>
>>>>>
>>>>> Why this should not be put to 0 in read_page instead on prepare_start_command?
>>>>>
>>>>> Michael
>>>>>
>>>>
>>>> ecc.read_page is invoked after the read command execution.
>>>> First chip->cmdfunc is executed with NAND_CMD_READ0 and then ecc.read_page is invoked
>>>> to read the page from buffer. So, by the time read_page is invoked, info->max_bitflips
>>>> must already have the bit flip value.
>>>>
>>>
>>> All the other implementation has a slight different way to handle.
>>> From what you said the reset should
>>> be done on for NAND_CMD_READ0 command and should be sufficient.
>>> Technically should be moved
>>> in switch and not unconditionally.
>>>
>>> Michael
>>>
>>
>> max_bitflip is not being reset to 0 across page reads.
>> Once a page is read with higher bitflips all subsequent reads
>> are returning the same bitflip value even though they have none.
>>
>> This is causing problems like incorrectly
>> marking erase blocks bad by UBI and read failures.
>>
>> Tested it with both MTD reads and UBI attach.
>> This change is inline with other NFC drivers.
>>
>> Sample error log where a block is marked bad incorrectly:
>>
>> ubi0: fixable bit-flip detected at PEB 125
>> ubi0: run torture test for PEB 125
>> ubi0: fixable bit-flip detected at PEB 125
>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>> must be bad
>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>> ubi0: mark PEB 125 as bad
>>
>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>> ---
>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
>> index 1d9a6d107b..97f250483f 100644
>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>> @@ -803,6 +803,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
>>
>>         switch (command) {
>>         case NAND_CMD_READ0:
>> +               /*
>> +                * Reset max_bitflips to zero. Once command is complete,
>> +                * max_bitflips for this READ is returned in ecc.read_page()
>> +                */
>> +               info->max_bitflips = 0;
>>         case NAND_CMD_READOOB:
>>         case NAND_CMD_PAGEPROG:
>>                 if (!info->force_raw)
>> --
>> 2.17.1
>>
>> Thanks Michael. Fixed it.
>>
>>>> Thanks, Ravi.
>>>>
>>>>>>>         switch (command) {
>>>>>>>         case NAND_CMD_READ0:
>>>>>>> --
>>>>>>> 2.17.1
>>>>>
>>>>
>>>
>>>
> 
> Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> 
> 
