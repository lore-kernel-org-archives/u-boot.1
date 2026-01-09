Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB17D1A62D
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664538432F;
	Fri,  9 Jan 2026 14:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d17Pwlr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C57A84353; Fri,  9 Jan 2026 14:57:01 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEAF28430F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 14:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/N4JaFveUW0nTte6YCo9+nV2Vy6b2bqm2C22a/HolSWUY3ic3An5HgGFB/7K9kQ8Btnc+eYJAgUIDJCMbbbM+wO7kUdCdlDoFVpYbtulTAqp9m6+1aPNKmCnRjDKXczjXDHBwcoJyiyrbjoQcIH0a/4ACtscPOurj+4A8bPiNFkvfCw4JEMgLAtET8mvBfct1NqArEgaVXc3g8TJojLUn2bmhXclLfn2c5m2b3NBWObVx7ArVhb9233NY0trNnm8XwJh7YWqte1jZfPHG9xegzGF/8E6Oz3UbwQOVIEEZ7IQc9O9WrFWBZuRCmYtABCcIlqPEPQnrqLeVzyI/96sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv+RZxrg/oeN29W5aXFaRdXTaOfTbuyL/IagDDpdzuk=;
 b=mQrEx4Ek8YwJm/TUvLrHKtat3Z9+2E7GTaifPOowo5Bof8jeVVM3/JBVzGLtBPTPPLchb1Cva+qSUM7ILc39VcNg+/tv0KFrAFkcMnEWOsM9h02FvtHMJpuNrhcGLmy4WO6jdpqhEaa+nFuf77fi/oW/4wRE252PwUBV+Lx0Q90gpzrph5532cEI/UWjL6ybh2QUTkO9CprQLOfmTL7DCrSg3y42DSbQj0vsEl0YudSvSZsMHC8eN7584zCpiKZE2Op9hMS28HLCCYtp4cNlcM8C4t3F9uxE4Q3OuBd1n4kDZM7NghB9ZkF1kKoVGiu5hJXvXk2bDok59fcg6PCv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv+RZxrg/oeN29W5aXFaRdXTaOfTbuyL/IagDDpdzuk=;
 b=d17Pwlr8VVnXVUO+sF+Y7ApKb5JOrnDKRap9oPwQHKZJBEPacymNUtwiJmffBtBSdUQxaJMRgWINwSS8y5IkMK+2k0BZA+eN4MG3IfTfXpYvm0VKV/1QOa+0hWOsMG9DRA8r4aacMup4RxcNFDlmjwBLC8bHR5rHlXTsQ26FxUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB11588.eurprd04.prod.outlook.com (2603:10a6:150:2c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 13:56:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 13:56:55 +0000
Message-ID: <24d5244c-4e00-46d6-a322-2da101ce057d@cherry.de>
Date: Fri, 9 Jan 2026 14:56:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FDT overlay: lost in the documentation
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
 <CAFLszTgEMx7NZpTO0tTx72AMjZr_w=A787hhLT_YzHVTt=h7oA@mail.gmail.com>
 <CAJs94EYXUdeAyGahUR-BPcnFTeYZvJLVSqxarD9kv-9KuMV87w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAJs94EYXUdeAyGahUR-BPcnFTeYZvJLVSqxarD9kv-9KuMV87w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB11588:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ae9869-abbf-401e-e738-08de4f86f315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZZMm1WcW9iRGhFM0s4S0xQV083aGVOVVU4Ylp1ZXdudWJwNmxONUpmK1A3?=
 =?utf-8?B?NHJXRHRsZFV3YXVaZVdxYzhYM3J4R1Z1eldTZWVLVmlvR2xsQ25uVFdWVlZV?=
 =?utf-8?B?NFRmeDNWaE5HcUdoTjhSSVZvekw3T0VaNWNZdjBQWEVGaFFvNUF2WFd6Tm5C?=
 =?utf-8?B?MnMwUFJ5YWRmZDVJTjFVM01xYmhlaURqMUlLM3FiU25mSi9yelNadGZFaW9n?=
 =?utf-8?B?STBtMHl5ZkhVTFZvdjlBS3JXbmE1clBhU0Q0MTc1REZXcnhiTzdIdjhRUmt1?=
 =?utf-8?B?UEZqRzlhZmtZQ0k5NWFpTUs1UEE5TXI2YTFscDRJZTlRUWFTd3d0bE44alpE?=
 =?utf-8?B?WDFTaXhVcTVuL21aQW5rb1hXdjU2TjNYUTdPWUprUWhyY092eVhrUkFHazgv?=
 =?utf-8?B?VTROZ0QzR2ZCUDB0VGJLbUs1Tmx0bEhBWVNYbytVVVFnczFOeGEzbUZ2Wklm?=
 =?utf-8?B?eVNSRHdISHNRUWJwYU43ZHloaWo0YmdXV2Zxb3BoMjNWN2xNSG9uSWlNb3dl?=
 =?utf-8?B?NmF1dVNOTWxLWmJaUDZ2NzJyT2VCT2wxVi9PNnVmaldobWFZWmQyaFgydFFQ?=
 =?utf-8?B?QmtLVUxNVUN6eFE1bWpwT25KQnhKUkkxeVBkVTdKZGNaWWpCaHo5WkpDUWZv?=
 =?utf-8?B?TnFnN2FSYmdHc1k5eDQ5UHB6dVZKOFZBVXBsMzdEVjNUY2ZtVVNMeVFDdDJJ?=
 =?utf-8?B?TWkvTElHcG1GSnZXM0tEVU8xY1dxNkpnWFpyaTUxM1ZBVUFpMjVCQnM3TXM2?=
 =?utf-8?B?bFFMRExlMFJ1cDVqdHJOUnEyZjdoMmVjQXhNOXZtdnlud1Z0dTQ5bHZhdFk5?=
 =?utf-8?B?OWlKa0tFdFp0WWRDRmRNMGJMQ3QwTDNQTWpYSDlPZ09DQzB2em1uM3d6NFdR?=
 =?utf-8?B?Y29lbUpNMjBxdGlTaDgxYW5xbitoZXVWUU5uNU9kS1luc3VrMGlMZEdpaHR3?=
 =?utf-8?B?bThxd3g0Q3VhUWxDNG8rVXNaTmxDY3oxM0p4czhjcGdQR0k0a2xEMk0wbTlo?=
 =?utf-8?B?djZUditzOVBBNXBtNmhVSXFTVllTaDJpekZXUEMzTUN4M3piWjZ3Yk1VdTl6?=
 =?utf-8?B?SERMU09iTkJLcDJBTmdYRXIyUUZCTm5wRlB1MHhoZ2xBdE5uaWdvSFl4UWNk?=
 =?utf-8?B?aDVNYTFKd0svalh4ZkcvRkx4R0hUQ0RXU2RWbE5jbjhQT1QrdW9zSVZtTW9T?=
 =?utf-8?B?TXBDZE1sZ0kyNDkwandadlRRb3huc1VHbFZ0ZWJvOTBLdy9rVEFHcjdUc0Fk?=
 =?utf-8?B?bzhQZ20zS1NsZXRwYnVFbjdMb1UrMmhGdVYxaXJCaVpiS2RSblMxUXZYZ2JL?=
 =?utf-8?B?Z3lnZjFkS09KOVJ4SG1VSVF3NzVpd3krRG1qK1JRUmVQZW5GTlVlOHVES0dz?=
 =?utf-8?B?Q1ZFTTA1Z3JLSHU1SjlzVFZRN2JzQTF2UFdwWnc5QTdjbDJKc2t1YkhXc0Iy?=
 =?utf-8?B?S2FUVHMybkpyUGRhZTAxaEVWWkhlbFNzamZrZGs1dnU0UStTSVlmdjZQMUph?=
 =?utf-8?B?cWlQd3MwM2kvMGEzSnUyOFI2RXlUYUM0MHUxLzl1MXdWcVBneFdtTUJtd0Fi?=
 =?utf-8?B?NlJPMGxXQ1RDWS8rbTY0UUtFSjRzMlV5Q2xYajlFZlRzUDdqdldEYVVUZWdJ?=
 =?utf-8?B?SUJ2dXBTOWMwRkkyUzd2dWQ2UWs2UWdlK2p0VlNJa04wRm0yQlh0TXhvNUI4?=
 =?utf-8?B?TEJjSWRJRVdoazU1b1ZzWDJMWC9ZYllvNzd6YmU4Vmp3VThMbVJxOGpMb3My?=
 =?utf-8?B?dmtQU1gwRDk4eXpPSEpYb2VxZXArWVBoTEo2dHVYc3UvSDNkZGR5Wi9yakpV?=
 =?utf-8?B?alM2RXlpNWIvY3piOWIzZEJia2dFYmU2RDBYc2lXeEZqU05IbVViUG0xbXhq?=
 =?utf-8?B?bS9OZGdGdEltUTJPMDVIRGJPanErSUZjcGlLS01iaC9aeFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGx1NEFqb2MrYTZTRGFZRHZIeGkya0lUS29KMWpZalU0bzYwRDZuQm5Gc3dO?=
 =?utf-8?B?UGVTSlB5Nm0zZzAwMWJHbGpPeHM1TUpJMSthVW54WVhldG9sQkZmOHkrNFAr?=
 =?utf-8?B?WnYwaEtJZ3d4RlJxTEJMdXltM241SnhpYmVFMEVJZHZpTFNiRHgva1RJK1h1?=
 =?utf-8?B?ZURjcnBLM1NUVHkxRmlTaExReU1JM1EyMGRtTXcwNndMRUdkZVFaVjRXa0hC?=
 =?utf-8?B?bFJXVlN3Tk1qdUdhZ2VkdVpsZ0NRL1NTK1F3SGRVdExSV2I3OEE5UEhheUF1?=
 =?utf-8?B?bUdZeGhmcndhTHJJWllmVEt5N3pSUFNNNXg5Z0M5Znpyc2JZOXMvV1dsNFJL?=
 =?utf-8?B?Y29OcG9tWnVidXNYTWdzSDJrNGcxa2h3NHpYdXM1NG5RRUtiUVdUaEg3dE5S?=
 =?utf-8?B?RzZVcTM3dDF6ZVdzeWRIZk1EdzhlRUxCWFMyMjZiUGZCak5YUU5IUUFvMjJH?=
 =?utf-8?B?ZVVFcGpnT05jWTFDRTJwM1kzSUZuTzFreDU5OXlMdVh0VGtsQW4rRWpnTjVp?=
 =?utf-8?B?SHNyVlUxNEsrOFR1WExUYzJnUHFsSi9rR2dWSEdYcXdUVHVwR0xNRDJUZFp4?=
 =?utf-8?B?dGFWbHNIYzFacklKNjh4SFMzUzRFQTJuN3V3ZXNoMHAxNFUyK3BIUFRLZG5M?=
 =?utf-8?B?ekNFb05HRE4xZnY0NDZvMkg5Znc2QWFVNkR6cDBPcE1aVGk0VVR4MHp0NERw?=
 =?utf-8?B?YlJONDRCTFBscy9JOVBvOTVSQ3MyMzJWZk5FNUdnTkRydEtjRm1jK2JYWk9C?=
 =?utf-8?B?OVVzN3dzQTdCUk5WQ3cyWG8rSStVZkdYams0TjFJSUVrMlhsSVd3ZzEwUXJL?=
 =?utf-8?B?V29NY04xS3M4RWFucm0xMnV0TCtqUiszWXEwcDZWSktuTVhJUDA1M0Ziem1x?=
 =?utf-8?B?cTl0aGQrbVdtTXhJK1RtdVdzbTNNVThoUVcvc1hPcStONE03czkyZklzQkx0?=
 =?utf-8?B?Tk9FWVluSjJBbzZodlg1Sm9FUExnQVNhUkhSa05LeDBsdjZQVGNsdlU1aVZy?=
 =?utf-8?B?MjlEWndrWDdGaDV1dEFqZUpUenpRZUM2SytYczhaWTk4dkZpd2s5ZVVjN3BO?=
 =?utf-8?B?a1pwRDMvQStVdkhGVTJqdWFjOFBaR2xBVksvcndVQ3RMQTZOanhIWlFYc1Q5?=
 =?utf-8?B?Yi9kcWJXMUdURWtoOGhpRkM3blExTVFxWStwejYveXMvdXBTOXRYVVdBQ2s3?=
 =?utf-8?B?T1NrbE1YakJQVzVJVHppM0ErUEVLaHhGdmQ3VHVycloyREtSaFVJQUxWRElz?=
 =?utf-8?B?UGxCQUlGdnRWRW1RVVdreEswUHhpV3ppb3diTHdCaGpHSE13SjNhSjdjN2RL?=
 =?utf-8?B?R0p4R1ZYQ0VDZjh0OFRLaURJRzZpMFh5N2t2Yk40UDNaTndmdlk0WS8yOXY4?=
 =?utf-8?B?bXQya3NrK0MvK3Y5MkFNVFBzT2tmSk1lQUFmQ1FrNzFZbUR0TE5nRlFWbk5l?=
 =?utf-8?B?QWtUaHErOVhPUlJrS0tFWVF5RjJ3RmwrcWJqNHJVSWtHV3BGZThNa01EbTho?=
 =?utf-8?B?OFBHM2h6d1ZiR01mVGd4Wkc2aUFQd3hWZjF3NFFOWmtrYlZNcUFjQnNSZklm?=
 =?utf-8?B?ZmZtSWRJOC9ETW1XK0xBUmJPbWllcVlHZTN2QXNCTWQwQ2taRTU5MkJEV1Ew?=
 =?utf-8?B?dWJ5WG0zUFhqbWNaam9tMk9UYTBuUE5rZDlibHJRRkpDMFBlUmh4RmhVaW02?=
 =?utf-8?B?ckhWOUdGNk0zWDhGTm9Ic2NISmdwUHNzS3ZoZ0t1ZDNaQ0VuNlpEb3ByS0hy?=
 =?utf-8?B?OHkyTUcrMlprUExuUktKSUtTOExKVlJ5RW1QZkxmMWYwMk9XN3QvRFYzWERm?=
 =?utf-8?B?eE1CMGtmTmRzbDVUYWJzTmRjcXhPdW92TUZRa1YvNGRWd2tYNGdnTSs0cWta?=
 =?utf-8?B?cC9mMEt5TTczUGtZdG1JRnRVK2d4VGEwUktEaFd3WC9ObjJzbDJqU0dLUTkz?=
 =?utf-8?B?RXJoRW5aZndrNjU5Rjh4cE56dldaS0NrbklaeVFqWk1LWC9KeWd4TzVzbXc3?=
 =?utf-8?B?Rnp5T0NRR1ZtRHlwOHNCckJGRXljUnVOaUJINm1QbmtCT0QvQnNBZlhPK1lM?=
 =?utf-8?B?U0tWOUdycTkySmRGRlowOE0rbGRSK1VnMDYrZHdpYURPU0RSbmNJdHZPSElm?=
 =?utf-8?B?Nmx0NDhRVVNiYUJ2cWNNT3N3bnUwQ1hTa2ZEVVV4WEJ4eGdCSVFwWmNLWTJM?=
 =?utf-8?B?MVF2Zk11Y1JtaWJzR3kwV3ZSRFVyN0pnT1J0cFQ0Q0pHbG1ESDZwb25BUHdw?=
 =?utf-8?B?YXRZTGtuWHFocHV4T2M4cmt0aGFQTHRrTWNkQ2RDQkFWd2FuZVd1eE1nWHlv?=
 =?utf-8?B?VjByeDRiN1YxbnhvSDl5bjg5b05ERExQSzQxVHh0T2xUcFl0R3RCUGt6SEND?=
 =?utf-8?Q?I/q83Fs9A8FuiICA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae9869-abbf-401e-e738-08de4f86f315
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:56:55.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzJwfFKuSxEby5z1092a/8zMs95Lk2RdYa9s8wVyykyYsGgguKqUMvXjjw7HDcaaoGI/BBK753srZOYfcmeT2IhUh78xLRJb9j1Y+s6u7VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11588
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



On 1/9/26 12:45 PM, Matwey V. Kornilov wrote:
> With best regards,
> Matwey V. Kornilov
> 
> пт, 9 янв. 2026 г., 14:33 Simon Glass <sjg@chromium.org>:
> 
>> Hi Matwey,
>>
>> On Wed, 7 Jan 2026 at 06:00, Matwey V. Kornilov
>> <matwey.kornilov@gmail.com> wrote:
>>>
>>> Hello
>>>
>>> I have a board with SPI where U-Boot image is located along with
>>> environment settings. The image is supplied with correct FDT, so no
>>> additional dtb files are required to boot Linux from MMC. I.e. fdtcontrol
>>> variable is set up by U-Boot. Then EFI is used to execute Grub2 which
>>> handles the rest.
>>>
>>> I've read
>>>
>> https://docs.u-boot.org/en/latest/usage/fdt_overlays.html#manually-loading-and-applying-overlays
>>> but it describes mostly how to do the overlay loading manually. What I
>> want
>>> to achieve is to automatically apply FDT overlay from a specific dtbo
>> file
>>> located on MMC at each boot. What is the recommended way to do that? Will
>>> rewriting the bootcmd env with pretended commands work for me?
>>
>> We should really be using FIT for this. It is designed for this
>> purpose and is a better solution than individual files.
>>
> 
> Ok, I see. I just want to make some experiments on the table. So, my
> concern about FIT is that I would need to reflash whole bootloader for
> that... and then revert back. Isn't there less destructive way?
> 

I don't understand what makes the example not match what you want to do?

You want to apply a device tree overlay at runtime after loading it from 
eMMC.

The example loads the device tree overlay from a device with the `load` 
command which can read from supported filesystems on supported device 
types, see https://docs.u-boot.org/en/latest/usage/cmd/load.html for how 
to use the command. And then applies it to the Device Tree.

If you desire to use the exact same FDT as U-Boot proper did and apply 
your overlay on top, I'm assuming you will want to use fdtcontroladdr 
environment variable as the address in DRAM of the Device Tree Blob 
(DTB/FDT) U-Boot proper used for itself. I do not know how the device 
tree is passed from U-Boot proper to your EFI application so there could 
be some research to do on that side.

If the example doesn't match what you want to do, can you explain which 
part is confusing or not matching what you want to do, so we can try and 
help guide you towards the solution?

Cheers,
Quentin
