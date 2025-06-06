Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E151C61CE8
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 13:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5940982AE9;
	Fri,  6 Jun 2025 15:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="osJV6KC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F1782977; Fri,  6 Jun 2025 14:34:44 +0200 (CEST)
Received: from outbound-ip24a.ess.barracuda.com
 (outbound-ip24a.ess.barracuda.com [209.222.82.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33D881F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 14:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82]) by
 mx-outbound11-60.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 06 Jun 2025 12:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC+5L33rfbrLhtEEFOPjmay+0FjmWzpf2GCi0ROBSxWU4/9LKYAF+vGp9RSwyXidyuD2qF4w7Ze0teR/DTOJhzSToMAstvE/EdfyKEao8Jd3VgGFIcEeuNb4ZyylrkrFcDWYAz5Ps74vjykxcUzF6rkn4hbjPEj9WW8KbqP4eoo4r6pFLUHPGcc/EUBXpR15NO+t1dBE3d9n4an1J7zcj2iIgwEYGFVbxhGeOYFTjjhV+VUGYQu+rTtqG4bbWFNgy0yu0l4h0ZDheueYMK+ZSfbBD8bDzvb/wNgO6DiNZEEKcPnLSwq4ikRMoZeiwtY+bSkgaN5M0/yq3hTYGlU1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af8txzG/f4xfxYlEvzYmKqZzRYdTMJFnIfdvcmth3cQ=;
 b=gddoNb9IrJiTVlJsH7eNU+8FEInwV7MXWEqGe92CHC/a9A51kIWsahSm6lMsMV5EocC5ZC+04nNyOBGs3/fD6POiQ4bObrZAh1cN3RDqUguNnTKDAIlKzGGsirpo8f45rQTGaZkRxxqmtz0Me24iPjk2F9PWNV1/gahIVFKostWp2tsGCA9Bqbu/syiAGz9M1TfQtaDKjCY7jHlmCnc+OkRovx79zLTXnVjJy+/0E7/lfHJsU0rYo2EuHaUReAEWB/Q0LGxfCo7zly/VBwgnlN9VJhNZeGZjmpvoqdf1Raz4AfNRsaSF1Jpz6Hm1kADU9AeMavjI5+AV9OJdSgH+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af8txzG/f4xfxYlEvzYmKqZzRYdTMJFnIfdvcmth3cQ=;
 b=osJV6KC6jThjqi6z0FnGwcUI5t+I3VXx8HhAyCKzKtXcZTNllqRapSJ6Lnhd4/iZwEBLZ4PNjyMRinnRKqDuLvnJ7Dhe5K6LsX5mvO5dshtgbbO7OLw9aOlzQRYh2I7OKrA8ZKGER/jPsXsXtjn8PZUFFsxa72z88rFHd3wH8bJnAbw5AFrgAEYvdFyttRdRIb9aQJdFKpQ4X2cRM9vwOMKXHDHWdJB4/RZtO3yeH4aiMhIUFrPBW32QSYnYMniK0M3t+OZXscb027X43Fq/feD9P4ifmNhL5CtlXQ838T7fx3nSKB5tgWWXKH+QZWb0uPRf3CRW4hyEOwKW/yjn0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by DS0PR10MB6029.namprd10.prod.outlook.com (2603:10b6:8:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 12:34:23 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::e024:9e13:d386:d19e]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::e024:9e13:d386:d19e%4]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 12:34:23 +0000
Message-ID: <273f9e01-2362-48a7-9a22-ac7912b197fc@digi.com>
Date: Fri, 6 Jun 2025 14:34:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
To: Michael Walle <mwalle@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Javier Viguera <javier.viguera@digi.com>
References: <20250605074610.1424953-1-mwalle@kernel.org>
Content-Language: en-US
From: Javier Viguera <javier.viguera@digi.com>
In-Reply-To: <20250605074610.1424953-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::28) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|DS0PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee2a5c5-ccc7-44c7-925e-08dda4f67784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVg4RUx6NU9UYmZpb29FYVlQZ1Z3bWVzalB2ajA1NzJ4WkFCaElvcW9QQTZz?=
 =?utf-8?B?dWJSbUJCOFJ2R2pyWUx0K2ZoUWVMSU5PbzZPeWZrNHNzeHRZSHp2VFNkQ200?=
 =?utf-8?B?S2NLdmU1MHhXdk5wVUVaV05VOWQ1bDB1RzliVzRhQzNPVitUbXZFMzJEU2V1?=
 =?utf-8?B?dmRNbm9UaXVUL29XUFkrbzFrQ1psSldMNUd6QkRKd3E3TE9VVGtaRXZ2dnRh?=
 =?utf-8?B?NFVWaW5FaDJEbHJxcGRQTHZYUlVkN0oxTk0rRXk0QnY2ZUZuTTVGbGl0QVZ2?=
 =?utf-8?B?SzJ0dFd1a25MUnFmVjRiWDNZZWpOZFc5WlVnZlVFdjF5Yk9xYWlpZE83bDhx?=
 =?utf-8?B?MkJDQysybE1pQzdDakRYZmM3ME5jQURCN1MwZTV0aXpoN2pTeW03c0VKb3Rw?=
 =?utf-8?B?UzQySnVJenlPc1p0THlyRldCdm9zMUx2b1B2YzFLdnVRU1hKaVNTVk1MYXlY?=
 =?utf-8?B?WUYvZC9wMndQY0V5cVdWeWkvaHlFQ25JbUZ4YXVEbUVzV1p4VDNNWnFveUoz?=
 =?utf-8?B?ak1TK3RaOW03KzRCMklMYzU1eVM3czZsYkthVGpzZzl1N1M3aTZkYUdzNENP?=
 =?utf-8?B?YWhLZlNKcFQ3aE5wdGxOM2hocEo2ZCthZTA3MWNzSHVrQXBzSU1pQjBnTEVV?=
 =?utf-8?B?c3EwQ2hUZUxsQlk0d3BZNjhadXpmSE04NFdSbUFjL09qdWVmd0I4SlRPcGo3?=
 =?utf-8?B?cmJRUHRzS3J4RkNTcE5RaURhdEQzaUNMcFhPaWgrc1VmZUV1N0Q2elJtZy9i?=
 =?utf-8?B?YTh6UzV0RmNUUkE4Z0xGZHJZLzdocnQ1N0p4WjBLNzE0UmVwb0Y0YVNvQnlJ?=
 =?utf-8?B?Si8xMkhVTmZQTFM3Y1d1MEpNT09FWXVjalkxdjBQd1BtSHZ1MjYrMVk5UzJh?=
 =?utf-8?B?UTA2YXl3djRPVFFsUjBwSEh3R2tGYjA0Z010ZG9xc05ubXgzNW52cy9LRVNY?=
 =?utf-8?B?V3pnYmcrTUFnS1IxZDhCQ240TmdJVTVjMDlqN0hDNkJucDNNVWpHejFqWFpV?=
 =?utf-8?B?ZzFqeUkxcSt1U0pFRnRTSE40aG1BbzRNN3ZNdE94MlozSUdrcDhISXRSaHEy?=
 =?utf-8?B?NDRVZC9ERUd3TWdQTldUelZKRy8vOGxJeFlvZ2pIZlI3ays2K3QwQVlsdlJW?=
 =?utf-8?B?TXZPd0ZabXRUTjZqdlpzSkEwRHZOdDFpY0ZiMXhIOTZ1aFUrNlRmdVNOT2pZ?=
 =?utf-8?B?ZjY2UDhWVlNFZ0dKUi9xa1hjczVWUC9RM0QvL3pSMWFzQlFyM1NCU1ErWGd0?=
 =?utf-8?B?T3lkSFdka3V5RFJuZUh4eDFQMUR5MUxxTHFyNUt2amV4VlVWRjNDd29zQjVE?=
 =?utf-8?B?VU5wdzNKeGR0aDlXVUkvcWExOHpKT050S3ZSVm1HcFZtTmFqS2hCT282TkFr?=
 =?utf-8?B?Ly9jeEdVeEVRY3JEOFBGejY3UU4xS2F2cjZJaHNPOVZLMjdxaDU1N05uN0k0?=
 =?utf-8?B?SGJvdEV1TWxSRWtNUUwvVDdwRDl3bW9HcU5IRlhzNGN2bDJHSUgzcnRoVjdy?=
 =?utf-8?B?RWdzZjJ1SGtnRmtRMU4xMFRSZWZRSzI4Zmp0WGtGMkVENzNzamo5Mng1QlR2?=
 =?utf-8?B?Wi9KK1QvSDdkdUdpTjRHLzhFOHY4U1paVVB3aXNJZzBkQWEzT0R6U3VkNXZT?=
 =?utf-8?B?REVML2FiZHhWWWxWSWJnSHd5ZXBQeldFRzBJYVNWelFJL3ppZ1RnTkxpNzY3?=
 =?utf-8?B?WWNyNmZlTW1sUCtjRUVESkFvVkt0QmZ4Q0NRQTc5aFZrMkpzNWtzaXNOV3lY?=
 =?utf-8?B?QzNxbVU2dTFhd29PRmhRY0g0VzNSNFJmV0puSlBWc055cDNObFMxSjF0K3Rx?=
 =?utf-8?B?Zk03eVh2NzhYYWlGa1NIbzB1YVJjbXhGY0NEQ241YjBUUks2NjdPbCtjWGlW?=
 =?utf-8?B?SExIUUUvem1OangxdGxYakxqUHR4TXpDejFRYitQRGVBaHdzZ0pSTFVMYUhD?=
 =?utf-8?B?Nkplb3VaWndDaXJDVkF5RlU4b20xdWNvMlpmQW5idFlUZzhES09iWFRjeVE1?=
 =?utf-8?Q?v53g48rDYcb+ARWjc3HDM7A2p0Onjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE43NFpjVHk5TkFRQU5PeUhGTVFoSG9FTndLYnJoTG1DVUR1bjBFYldmN2Fo?=
 =?utf-8?B?U0hIcW9ramVGWUtDTWg5S3JnV3Q2a3JTaWp2Zm51Ump2eVFaWGl1MDRZeHJO?=
 =?utf-8?B?bEtqQXAreTRRejF5L2VlVGFzT2cxUkcrRnVyVVBjTVZiN1kxbzdWS1lTN1ZM?=
 =?utf-8?B?Tk5ieWxpdnBrMWhLMGNtKzU0TlZJdkk3TW9QeUhEdmxxeXJ3QmxNQTk0MEVJ?=
 =?utf-8?B?Vy8rZk51RTl4RVVpVVM2RWVSaWJQVDRESFRBUGFQdUYzTVdQNkZDWWI1ckpQ?=
 =?utf-8?B?ZVNPMFFxUDN5L1NRZnh2QXR5RnJvWEtVTmxqOUdGSkZ5Q25kWXZxNUx5NnhG?=
 =?utf-8?B?TWZpd29TdndaOXk0WXdmM2xNRytIYnBXcUFrS2lVVU90bnZGeXkyaStxeWYv?=
 =?utf-8?B?Yno1M082MFVUTUtiYWpJSEpPZDQ1MG52ek1XbUJieHNvZDUrWC8rRm51b3B6?=
 =?utf-8?B?VmZ2bUh1azYxWUlKcEkzUnB4Z1pCUU1uYnZIdUpjNVFlUE12N1hFamQ1R1Fn?=
 =?utf-8?B?eGVEVUxJQUUwYnRlSDVBZFZWZ2JEQWRSdWNHendGQ0R0WlR0SGZ0ZHF3WXJ0?=
 =?utf-8?B?Y1VXVnNock9tQkRZUSsrSVEzeldmTElQZVl3SDl0N3JFSHJJTVIvVkI3NTdM?=
 =?utf-8?B?TWY0MXBLNHJUYVVhcGpTZ0NXcUQvaFFpRysycGwvUExDWVV1RStSMUJrQzNh?=
 =?utf-8?B?VUFsdzhJa0JBeE9jamNHVXVUWTVEVXlWaERaSjc2bjQ5M0YyMm5mZkZDMllm?=
 =?utf-8?B?d0FDWWJncWxsdDQxaStuZlprdjVsbUhQMnVZblNSL2E3a1NUVXNienJPa2la?=
 =?utf-8?B?bFB4RkVLNmNhQ3ZzYXplMTliVC9GdHd2ZXpaSjZ3ZlRmd09tdHduRTA4Y3VW?=
 =?utf-8?B?RXVUMjhNTk8vTmk4QVA0MVBodEdNRTBTYkQ1ak9zYjZhZGhTODVPVVlvSEUz?=
 =?utf-8?B?QjA5Uk4yV2QvZ3Qyekh5cUNHMW5xTGxUSkRBY1lLdldTc3Exblg2WmNMdlMy?=
 =?utf-8?B?VEJhVjdPVkFwUGdjTUFhWXpLSWIvK2oyYi93MUMwaTc3WEhyZGJEdkRmU2ox?=
 =?utf-8?B?bEtaa3BiRFRzQ2IyMzl6RytQc0RlM0lKZlArYWtSNFJtOEVDRXFoYjFXdlJh?=
 =?utf-8?B?TTk0dzVJanA4SjNUKy9CdTZCcGJxTlQ3Q3ZkUitlTzdqWXY5TUtwY01IK3hE?=
 =?utf-8?B?ZW41NzFGT1V3TG00anFaMVZWc1dDaWhka0JPZUFZNE9XKzdITHl2UVhaRG1M?=
 =?utf-8?B?YmNhSUNLdUdkQWFwb2NTS2JUUjhBOU9ZQ3JMMFpwT1pwcFRscmtuS1J3dUtR?=
 =?utf-8?B?QkIrSjVRUkRicmVYaWlGeXJTVmtKTG5FWnVsejI3d3gzT2ZJSDVMeVkyYTVq?=
 =?utf-8?B?RzlLL1RwSXBmYXVGcTlNYU96RlhHVHpyL1FwZ1hvSzYwYUJNWFpPc2Z2NjJC?=
 =?utf-8?B?cXB0bmdTL0g0ZFQyVkV3YzdOVFQyYmtsZzBQSGtNaFlxRzIvRHNpY05XQmZN?=
 =?utf-8?B?UWFPVTJlQUdlQ2c2NXg4NmdOcitGcTYvSUJpTWZDUXVTSjVUb2VNRXhRVmdB?=
 =?utf-8?B?aDBZOXdDMmlpTTZhVk5yb0tjOW1qRkRzbnlCS1lWWVltNXJrQXJVL3lIS1h1?=
 =?utf-8?B?a25LRHlIWko1NHpaR29tV0o4a0lpWTlXWEdXVDlKYkNCOWZYSGxWYlVHazlH?=
 =?utf-8?B?S0xtZUVkSFNPbFRCSzJldDYwcmhaWmRocHYrMGNGYTh3bWEzSHFqak9IQjNP?=
 =?utf-8?B?dFM2azBVQVdja0wvQjhYTGhZbXo1TTNXcTFKaDBDQ2RKQU9zaVppR0VCU2FW?=
 =?utf-8?B?UTNodWJtNHhTaWJrTU8xTnc0NE5Ma3JDMzQwa3RtT3I5VXR6V082c0lpc2dh?=
 =?utf-8?B?akRWRlZoL2Fpb2FOUmJSVDUyaVdrSm0zM2toZ3o5S0dDZlZXd2NDc3ZhRVkv?=
 =?utf-8?B?WEUyaUxVaHl6Y1l0NkNkVVFBbVAvajVNMzIrS0s5TlV0ejUweUw0M1JmZmd3?=
 =?utf-8?B?YUNzVER5bW9oWHBaNTROcnBGYXdwZHlERTB0bmNDNjZ0RUlFLy9xaVlDd1Zk?=
 =?utf-8?B?L3NrNHRHclFSa2hieWliZzdhS2F1OE1ROTYxLzZvVmt0RDJldmRGTDUyR21X?=
 =?utf-8?Q?lMweO+zP/BT0EpSGnpvB+AHeM?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee2a5c5-ccc7-44c7-925e-08dda4f67784
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 12:34:23.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptCNTC97BRzTZ7odJuayboF6SIZgktm9bG/z4q1w4odWkC+K7zjL+7myVHi8jJfdl3yJHmm0UrGZtQqX/PcB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-BESS-ID: 1749213266-102876-7700-4379-1
X-BESS-VER: 2019.1_20250604.1808
X-BESS-Apparent-Source-IP: 40.107.92.82
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhbGhkBGBlAszSQt2dzA0iQx0d
 DI2DjVPCU12cAiySLRwNAszcgs1UypNhYAi1YlV0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265137 [from 
 cloudscan12-89.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Fri, 06 Jun 2025 15:23:41 +0200
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

On 5/6/25 9:46, Michael Walle wrote:
> According to the help text, you can set negative offsets to indicated
> that the offset is relative to the end of the parition. But kconfig
> doesn't let you specify negative hex values. I think this fell through
> the cracks when converting the symbol from a '#define' to a kconfig
> option.

Not sure with u-boot upstream master, but with a downstream NXP-based 
tree (version v2024.04) I think it just works with something like:

ccimx91-dvk_defconfig:CONFIG_ENV_OFFSET=0xFFFFFFFFFFFFC000
ccimx91-dvk_defconfig:CONFIG_ENV_OFFSET_REDUND=0xFFFFFFFFFFFFC000
ccimx93-dvk_defconfig:CONFIG_ENV_OFFSET=0xFFFFFFFFFFFFC000
ccimx93-dvk_defconfig:CONFIG_ENV_OFFSET_REDUND=0xFFFFFFFFFFFFC000

After all, the symbol gets translated to a signed s64 variable.

--
Javier Viguera
Digi International Inc.

