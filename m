Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E46C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE55F83015;
	Mon,  7 Jul 2025 10:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g6A9SdPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF0683043; Mon,  7 Jul 2025 10:30:40 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E818882FC7
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjnO9s3zgTv0sNcCM7gtHRJZqQuTK/03+xN/HIFgJ2/U3rgm4Ba3cIJAdTb+hW4GJaG5jOYM+RnVcRVvopwc7sufbT82i4Q1kwnSuSZ2C5/sJMcPOkrBZY+1D9RfPLIYkMG6bqKn+PSD9nHKl1OS7d75sBaPDNUy+551psDPqYijyH5otWorianbHNdvG27Wf7FT+x+vU2jxLgaH5h0vzRhWVETwPgSTWoOqzr6DlGP5w8H6pwVUHFovbPzoIpL4CYAv2CTciYgR552OzkaglqNJzSxE8Cy9NfgD+VF0Lz6j2ibuniECJgQLPzNvU3NgWMIf3tlJa9vgDY3o3x2ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tehLeFp5cflxkuzHroKmaScWC6lHMWnS+2yuODW0v7w=;
 b=O2jfCP3ky7aj0qdDYYjo2+XlGjWLBwxOTqXuE39DBdvnav0iSJECcWGznpRu9aNqs9yu4gvRZDprxqPOiQa5CSykoCE4mUPyKu7ydXvWWkbkdLJRMMnIoFaOI0Uv7ZRoc8cQmk+rbYfd3UFfONj9VmhhjTzNFgT6Jjl0FNIIUNOLplssMg2IRv+cXRTkUcmWIq9duptUTQHXvGo+aR8LB+nxPU4FhaHgPptvv67AAVp8M80NkUq/03f7YhLDRILK/ppqoHy06/Lo4Jsu9dtSbErrD0V8PosNY3TjVwqfvoZ0HH+gtap8JM4f20JKX7l+qO8jxOxNQavGlnVmcSaMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tehLeFp5cflxkuzHroKmaScWC6lHMWnS+2yuODW0v7w=;
 b=g6A9SdPcqduEJ2WFYVO/0IKvZwJIiKBT1PyyaNw0sBoAlnuPYu1+0si0zZeil0DVdUunATv0RogchDITKRsD//zCiII4gEAj8ViNFpKx6tmhj7f+zPXNaQn8fcrpu1NDgR27cVnxNXMUdkO+3nQ1nbpE7zSg47+Jhd6/1Y39pvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 7 Jul
 2025 08:30:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 08:30:32 +0000
Message-ID: <6f4c78e2-d3ba-46e6-bcf5-233f7fb1c517@amd.com>
Date: Mon, 7 Jul 2025 10:30:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Remove the ZynqMP Firmware from mini ospi
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250707041311.769577-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250707041311.769577-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 4520a4eb-7b05-4453-6c44-08ddbd308984
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUlCQUF4YVVqemovUEFybkpMMEZxR1FYNEZIK1N0VzZ5cjVydWh1SEZvVUtM?=
 =?utf-8?B?cFFnOXIyWksreUtGVURlZWY2ZzhsZ0lBYXQvRzljbDEvV3g5SUo5MzJydkZl?=
 =?utf-8?B?dDZZY1RGMXM0azFZVHRRbnJWbUo0aXhLRFpHZ1UrTWg0eGhQbnZjM2dWazlT?=
 =?utf-8?B?WTVsQWZWWk5kamZ2eTQwanZtTmNDODFmbzZMb2RIUWRKbWhKVVNCTU5xVXM4?=
 =?utf-8?B?K3pKUURMNmRSSjRyOEdJdHJOeU9acG9GeHpMYUNSS0Q2OUM0QVNldHoyamp0?=
 =?utf-8?B?dSszM0JBVk5qUWNJN3VUSlkyS094eFZvVTgxZSs4YXhFK2s4Z0xLUmJPUUJO?=
 =?utf-8?B?c2M3YkdrbGFNVHlucVFZWGFOQ1hPbmllVnJYeXZOYXpUYWdMTTBHMnRFd2V4?=
 =?utf-8?B?REphL21vbWJSRk1scmRWZmgwSHZ1eWVjNUxXdjRCOGlvSkJoaC9EUTlwb3Vm?=
 =?utf-8?B?aXZ1VUhULzFRZVZtaytJZzB1OXF5ZE1yZmpES3FGQ0poSUw2YkVRd0xHUmFn?=
 =?utf-8?B?WHB5dFFoL2pJaGdKZVdNdnVENmk2VkthdEs3VVc5U3RDa2k5VHlnVjI2NjZ3?=
 =?utf-8?B?bUh1bGhNYklqZzJFdVRadGk3akZqT2RnMWhzZmhNVU91Nk1TOTJGd3h5MWgz?=
 =?utf-8?B?bE95bFFqYjMrSGhUZU9ZQklWNUpVMURGMzBZZlU3RzJ1SVlIUUtWdXVyZTlI?=
 =?utf-8?B?QWxUZ0JhcC9QalRpNGZLVWg0bWRtN1JnVDBteUd6Uk9xRURLdWNuUXFoZkFI?=
 =?utf-8?B?ZUxUYXVlTXJEd1VwNXVTRmxqNHpEemNHSWxMRFpIMDlBYkxmOURjdkdIN2Vt?=
 =?utf-8?B?ZmxuK0I4RE8yNmtYSEZUU24wUGcxNUdqMnlvU1NldmY3UjRWcDlHR1IwanJE?=
 =?utf-8?B?NERQMGs3ek5VWDQ2b2FmVDBoeXdxWDkrS3Q5SmtzeTlWbG80QUVaNWVLSGJM?=
 =?utf-8?B?YXl2Z1V1NWd3NUZvR0xmekZkMXJaL1Y0dXBLN1JId3A3RW5WUHhrTlZlNkUr?=
 =?utf-8?B?UjNSZDQ3UCtYY3N2djNWWDVqZFBSWWZJWVgxeGdoRTlLQ2pMYzZBSFpnMG1L?=
 =?utf-8?B?ZTgxdjZVYjBkbGlzMjE1Sk50WS83emZBek9adVcrTk1Sd1VHQnlYMWFXWTgz?=
 =?utf-8?B?Q3RqTHVLMmcvNStMSktrYVhpY0RhL0krR1E0SHNySk1BV3RZbWdwbk83NmRM?=
 =?utf-8?B?eGdOazdaNGlJOHo5MHJOREJtdFVsVkUwR3hjREcvQk5NN2ZLTER2bjMrb3Jt?=
 =?utf-8?B?S3JLeHhQRC9raEVpS3VBRUc5ZU44UzZWTktBNFljYWZ2Um5rUXZhNVpkb3pN?=
 =?utf-8?B?VysrdGRCaGF1SXpnbnBhU1BsK1lJd2hJT2hPVkwrVjdmUlEveGg3YVFNcXJK?=
 =?utf-8?B?WjFMMEgyUkFaWTdLeUdCSkJmTnJ0Z0RROG1RSzlXTXRsYmdKRURzY0c1ZnlR?=
 =?utf-8?B?M0RxVFJ3aXhaYlFDSDNxbFhUc0FzNmM4S2xVQVlPenVFeERnUE9qVmFqV3RU?=
 =?utf-8?B?N2JvK29xMFRTOHpwamd5bEVsZzhGajU2UmwzWWFYVDJYZmZWaHdvYk1tNHVR?=
 =?utf-8?B?RFZCd29RZWNkUnlwaWp4WU5RalQ2cDA5UGhJQzcvdWxwQ05IQWlqVmhOT0V6?=
 =?utf-8?B?NzhLYTZWWUllWUdpWGplaFF4T0JtYVRzUDJKczl0OTUwTWtmcWJMZzZRZEds?=
 =?utf-8?B?bitjSzV6UVBHRGNPVnhLN01kMWJFV2xya3NCYVE1Q1U2a2NGZjVzdE9jVEFi?=
 =?utf-8?B?QkZpUzh3TEZNL0JudnRRLzhGd3FFWkt1TGt1VDRVemFLYVlFcGRxMElxd3hk?=
 =?utf-8?B?QnZzZjN4dGhwa2dQcWJneVgvR0tSRktNamRiZ0xBNVhVN3k1WlpoMlVVY3Fz?=
 =?utf-8?B?RldDbnE1TjZ1TDlSYWJnbEtPc1FDcGtQTW1MOGwxWHltUUlYYkg0Q0xCc0RG?=
 =?utf-8?Q?ynIYS/NBsRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejQ5VWd1TjdyU1g1MS96U2NabDJFSXd5RkZNaTlGZ3BRdnBxeTBxalZqMnBC?=
 =?utf-8?B?WFZJbVlDMktPVWhVYnBjbllhb0FwQ3JOaVpTZWpzVkV2MWk4dytEWWhxWW5j?=
 =?utf-8?B?NzZzUCtlU3pqVzk2aWxIU0hHZ0pSaXR4UkxYV0JLMTBEMVZhV0RaRE5jWE14?=
 =?utf-8?B?SHNXWWVmZkcxUjFjZ0YvY290d0MrK0ZvaTMvR2pFWEVZUTRHSEdZclhyazNY?=
 =?utf-8?B?TjBVR1g4ZTFUM2pQdmQxOE5renJWQVlONFdsL2RjRnhEdjVXWHZwV2J3dE5o?=
 =?utf-8?B?N3lib1FiUzM3OExUZzdDN1J5WTczcGwzUmNtbTU5NjdhU3lIV2ZaSVZXRlRO?=
 =?utf-8?B?eGk0cHAxMUdnWFJVU3R6OWRsSWYzS2RQTXVId2ZleU1zUzdiVHRYMXBkRXhM?=
 =?utf-8?B?aGNhT0xEY3hGYmJqeGhyV08xUHZGSVZLWmttYW10WnlqbWJHdE9XTSt6a1lt?=
 =?utf-8?B?VEd1Q1FBbjcvWi9Id0tNcFFTOXFLaXNNM2laTzJoVzlQSytoMmJTejBmc25H?=
 =?utf-8?B?cFRySXFXcnh2QldzNkgxeEVMOUhXRW9lem9iQ3NmbnFwUFdjUzBCTGxxZ29o?=
 =?utf-8?B?dWxqNHgxQzM1RUtLczBJTkI0N0l1bDR2dnY3a3JrdndQR1doZXZjc3dCZDJs?=
 =?utf-8?B?NzRFZkN6eVNWYzBOazhEZ2U4Q3c3S0lBaURsWHhVOW5HRGNOOHc3UEYvQnFn?=
 =?utf-8?B?MDJGMHdsNGVONjQxTlJlZG84Tlc2cjI1U3Q2VThnaHZFaFBZUG9xZkJWbVd4?=
 =?utf-8?B?UWtTRnJ6YjJ4cXVnTlhpbk8rM09FMmVnalRGOUQ3Ukd2QjNINUNSUU5ZeEZq?=
 =?utf-8?B?NGsrc1J3cXhhNmxZSUpnT2J2QnJDVjNVcTFmK2Y3SWluOHlzdDZoZDdpNWQz?=
 =?utf-8?B?SVoxQ3crZGtyYVRNV2lnSTNrUUs0R1hzT2MxZXdWeENVQWVSOGErUHc0SEda?=
 =?utf-8?B?QndTeEpNTHo2bmgzd1dGSSs2bnhCTVFuVW0yTC9WRjZRbG0wM3E0N3Z4SGNi?=
 =?utf-8?B?Nno4REw4NEFaSmVaWXRJSnF6Wm5SSG5GeFFiYUpxbnF2K0IrWmYyUTFWdVFH?=
 =?utf-8?B?Q1hFTzBmTTlzeUxMdXF6cTdnb2RrZy9iczI5dThBNXBSRWM0czk2MWd6eDdZ?=
 =?utf-8?B?RkczTFRVK0Joajd1NE1GUEhMUkFodjhvcGpFQjAvUVQ0NkgzajZBWEdSMHFw?=
 =?utf-8?B?bTlMdVRGbDNqaTBuOTd3R2s4d0RSTDNhK1p0bmhkaDJSaUNmQlh6OU93VjRr?=
 =?utf-8?B?bGh4TTlkL1dLTTBENC90ZkN5c0o2NXpBbTRZd24yMUNzbTFqM3JmZjBwTjEv?=
 =?utf-8?B?MGdJVDY4WFdZVDhoc28weEFiaVFhenF5WCtVK3hSb3FVVjFXNm80WnFaTTV2?=
 =?utf-8?B?ZFUvRnFRZE5haWp0K25QLy9OQVpjUU9tL2pYZ08waGJqaTJLYUxqQXRnMlVS?=
 =?utf-8?B?RVQzNkU2Y29CM0tIcmhnZlREUDNUSmtNYVE4ZmU3Q2M5UUZleThqU0xqWkpB?=
 =?utf-8?B?cDJiRXV4cXZrTldlcklKd0xBenVFSTRMTWQ2V3hTb0lCb0QvcHh2VW9pRytl?=
 =?utf-8?B?YVpaVWg1bjZGT1U2Z0Q2OExBV1RCYmZWdUhsaEtxMnBiS1VORGtCNmpxMnJN?=
 =?utf-8?B?ZjJ5QmkzcVlkam1lQituckFVazhkRmIveWFnem5rSVRSeEQ2R2ROMDJZVGlv?=
 =?utf-8?B?NEVnR2VocWhFeUhiOVlqeHdtVXlZQXlSNm5UMm82Y0xuSll6U1Rqc3plZzZZ?=
 =?utf-8?B?bWZ2NGd6Vi9iRXk5YzdDTEMrRS9LMDdYRzBGMUY5SktZRzRySnhiMVhHcVV5?=
 =?utf-8?B?N0owRCsxZ203TkkrQlE0b3RPc0hkT2ZuaEtCeVpGNXFyQ2tGU0ViditBaWs0?=
 =?utf-8?B?eUtwYy82bjJlY3hvQnFUYTZlVm9LQS90SS9YNDNtdzFjREZvNS9tZnZHL0R1?=
 =?utf-8?B?RXVhQWR3Y0d6VktubTdINGJuMjBReGtaK29TODYyNjFKd2tGK01aOGRaN2gr?=
 =?utf-8?B?cVZVOFhzVDVEbEM3VEdRcDdXdFBVbDhva0JwTHQxSXZoSDdDNy9vbThlNG02?=
 =?utf-8?B?ZXBnWGlIR0E1UjZYNEl6aXA4OXVFMnpRQTYyVnFKV1RxNlFrZGJ1RjJjRnRI?=
 =?utf-8?Q?RQQaGDUynJ18mhEZPC6HBzqJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4520a4eb-7b05-4453-6c44-08ddbd308984
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:30:32.1062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a7dSgTHXCGQQRGHb6asGP9EzqNZx8jNAdZVmKhkwy0kQ43fP3oRtyKpezNzdqHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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



On 7/7/25 06:13, Venkatesh Yadav Abbarapu wrote:
> Remove the config ZYNQMP_FIRMWARE and also update the initial
> stack address.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_mini_ospi_defconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
> index 54328e85784..55953d14200 100644
> --- a/configs/amd_versal2_mini_ospi_defconfig
> +++ b/configs/amd_versal2_mini_ospi_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_LEN=0x20000
>   CONFIG_SYS_MALLOC_F_LEN=0x4000
>   CONFIG_NR_DRAM_BANKS=3
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBFF8000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> @@ -57,6 +57,8 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +CONFIG_FIRMWARE=y

is there any reason keep this as yes?
I think you can remove it too.

Thanks,
Michal
