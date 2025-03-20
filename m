Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E32EC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 07:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABB6809D4;
	Thu, 20 Mar 2025 08:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Bw3TXpIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33C580F0E; Thu, 20 Mar 2025 08:15:10 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E418083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 08:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMlBu3MsVhUEqen1p0EB5zw3cYh7ymoYYL+cF8qMSUkIgDsiTMewhQXovE7XaeG3AvRUlh3t+PHhJXkuV9WkgCvMUkPHRuvqfoC5PkxOfVu5YDGl/eO1EThRRUs5Vn2w1Pe+ZEt+oFHSKFv6xfD9l6lLTWnDnVR7aYeFLhC81MqSEFAdCYmN046eL39v1Wg8O+EmzkCa4YbBkK//HXvIW26BMVH68SSVVpw4AQf3rv+M6mpoPqkJYmBEoByKYJyLXlRG+y5XhJqfBSMCYoCM9XF0/sBy3wtr0QN94j7+8sdlkDXZCvqYNj7tEoux+w1+Okys0HplBROn92DJPQQrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEKqkYRfIjpEAFNoXIsnzNE9jz/P8FRPUk5ftw3KxHE=;
 b=D7dN0OpzuyzZ6kossN9KcLGGrljl0zqNMPUjmRVBoWyIFksjhTfP9DA9J8LmF/2INeZutKmlBcL8YRh8p+LXtjYmQkewubP140NS5BmdlWh1TqZR6aUoUQkw/60ydLgMM4uLzzIKHSHyJJA1zB9lQnXs9Oz4ktbT/pRNB9wjKDMJVnnmcoHC+0vwABKyd7aSY+0UVoFS9Z362RGoSgASaM4FWbuQq2zrH0/rS/UdGMig/nDOTTKTKmU0tC4Tfp0Lp0l5ZAySDzoCg+5HXiGUUW59Dg79urm9I5u+7i3aEMietvgZQ3gI0cDTf/i/YZsACAJ0OxMJB7lVJkBZsPXkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEKqkYRfIjpEAFNoXIsnzNE9jz/P8FRPUk5ftw3KxHE=;
 b=Bw3TXpIa6bgUj0baNczNvotQQKjR7t6HicAjhbUde+6ljzm/PputIhZBUhTQ2EjXGz0lZHzNaAGnAGkKvC+lG6paBk5NCU6Bsigt+y4RCRxPAsFL3vGudA6bbqvK7Ihh419NI/msBh0vdeQc+fDYMskUmW8OiqeJG8kRSrpdtGTLQ4b+gw1VBOWFYULqhK+LfBPMSgBVRK9Ur5LrFlQmOLn7UztmSyWJSNngCq9HGR23b2DjmC8QmC5Kp9BKu+xZzp5mDcn1LTO3u2vf7iHN0hy5i7ZjwF8liEnKz8pf2GRRIC97wcKQHmITCdEdoPQEQ4uLojKCKo45aZ3UMhVcUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB2020.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 07:15:05 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:15:04 +0000
Message-ID: <37787903-8385-41e9-91ee-9c7db33f413f@phytec.de>
Date: Thu, 20 Mar 2025 15:14:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
To: Tom Rini <trini@konsulko.com>, "Vankar, Chintan" <c-vankar@ti.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-2-c-vankar@ti.com>
 <20250107142258.GH3476@bill-the-cat>
 <91021f80-2d2e-47f9-bdad-a652ebea7986@ti.com>
 <20250109152707.GX3476@bill-the-cat>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250109152707.GX3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:303:8d::14) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB2020:EE_
X-MS-Office365-Filtering-Correlation-Id: 009e0d90-dcb4-4b19-8e88-08dd677eefd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTh4ZDFqMWNKaDZpd1FyMVdnbER1TEVubGtNQ1Rrd3U2elowNTlwSkl5M0po?=
 =?utf-8?B?S3kzQkU2K0FTQVpXRTJ0T2hlVG96L09QZUNvQTFTUXJnN0RtSWtqUWprR0c2?=
 =?utf-8?B?Mm9EdVFDbFo4T1NXb2dqcTVrQnIwM1M0Y1JDSEtIaDVqd25YM3hLWDZSeWQw?=
 =?utf-8?B?Sm9icFFiYm5IekFUR1pVR1hsRTk1anVOTURsRzIzTGlLeUtWVWlYcGFXVWVX?=
 =?utf-8?B?RzQrcEVXelVKL2xLMDNNeWU0YzJIUWlLYzl3MUxwNzE0ekxHVG5PMFVxM2JX?=
 =?utf-8?B?YkdzOXJ1ZUNzVlB2L3ZURWxKb1dCb05UVHpHSjk2WkU4YjV4d2hWTUdmaUtT?=
 =?utf-8?B?SUpWMWs0NnhIcGxNb2toRnVhWkZZZG9YbHNyRmY0MnJuQnZZb0dHQmFGaDVM?=
 =?utf-8?B?VUNjQXN3bkFYYTRwOVVsMkdsTFRCQlhxK0Rjc3l5WDZVNG1vQWtLMXdwdjJZ?=
 =?utf-8?B?Yll1TGVtS0hKRlYwcEcxUU5vOTl5Q0FObnY1SysvaDhKVi8wR3hHN1dJdUZR?=
 =?utf-8?B?alFuK1ErdFZ1b3hJYmgwQ3BxcllaWm9SUUpOZVNSY0M0YkxpWjIrSm5OWFY4?=
 =?utf-8?B?QzMybDFGa0EySVhCeU44cVE0cWV6d20wbTltcVdrZWEzb3NrN1ozUHo4cnNH?=
 =?utf-8?B?cHFCd2NxMlpJSFhicWpoZlVyS2tGQ1JjVGNza0IzU2I1OFNBdkRXRkJRNHRi?=
 =?utf-8?B?Zm42TXVjSVdmcy9PZzZUYVdwa2xXNEgvU041TnE1Tm5wL0JVL1pDSk5ZK1FM?=
 =?utf-8?B?UkRNTzBJUVN6UWpNbStObUdNRDBhdEd2UVRja1RITmQ5dEViN0tzMEJHR2Jq?=
 =?utf-8?B?VWJlNk9ZMXV0V3FVL0pLZ0h5Ulc3d0UwYVNxSiszdlhZWmpPU0JFVFhJSTJt?=
 =?utf-8?B?dnB2M3JsY0JCRjdaM0s5eGVNN3pjd1JjbXgxZS8zcGZLOVBXazFkSTAwS0xj?=
 =?utf-8?B?OERiVUEwRXRNeWYvT0sva0JYVytqNVlRQXhTNTNlUGhFMlpKajBUanZrZUxJ?=
 =?utf-8?B?VlYyRjBOSEFoTmZhTkNRSkdjMk5TdSt2UUloM2F2a2VyTndreU9FeW9KYnF2?=
 =?utf-8?B?SGlhVjdvY1lUVDM4NTU0OGwxbjY2bGhLSENJM29PN2lRaHk1V0pHbU1QRnln?=
 =?utf-8?B?TS9yWjQvMTNZdWJYbTNCTU90ZU9GTVBDTWRINUVZOWlzSnh1dUV3dzJlQ0Vu?=
 =?utf-8?B?SlNvWnd2eXk3YWNUWHZLUXpoUzVVV1dPTVVhSXRQVEptdWxsQXpSRis5by95?=
 =?utf-8?B?V3orQ1JtVXUvTk1taVE2UTgzemtmK05LNTR6T1RScDZEakdpbkE2WFBPZG1P?=
 =?utf-8?B?WDNCSEpjdGZHMXlTa0NOdkRrZld6bFAzWk8rUXF1M2NGcld2bjB5NDJmc21z?=
 =?utf-8?B?MmdUVWhrbkswVXZYem0xdkxjUnp1ZHF3RkhlakJrV3E0VmdCN0k2YVY3US9a?=
 =?utf-8?B?UkY4VDlVUGc5bGYreE1LS09IU3pZbWsrSXVzZDRKblNMa3o4b2xobmNOU3Nh?=
 =?utf-8?B?T0hZRkRRMWZDVzRVQVBqOW43R0hHNTJSNnBKVEhjNXNTVG9PeEo2YlpNSHJS?=
 =?utf-8?B?L0gxTjQzWUo0UW5CMHlkcEFmSXdQMXJHaHFwRmU0a0g1SXh5SEdpb1BscDls?=
 =?utf-8?B?Z1Zyb0loT1hzWS9oSnh6N21MMEJoNWJmSlZyU3J1UjNjTHhqQjV4VWxOZm1X?=
 =?utf-8?B?bFhMcGJYWk9LeFMxWGs4VXVCSEpDS000OVMyRHYzblVXWGZ0aHFJb3hhTzNY?=
 =?utf-8?B?cnltdklCakZyVWhadnVaQkRyalFodzh3cTlqdmRLZ09vcGJvNkFnaElmTUt0?=
 =?utf-8?B?b2RrbDA0OWMrUVJka3c5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWQyWnhJY2sveGsxVmM4QThjVU5TYU5uVy9PdUUwamEvUTQrN25jRHVDdVRI?=
 =?utf-8?B?NjJoVzcyR0lSK3kyM3F4b0VYTFY2Q2k4NnRDMDJPVGlVazd2RE1Jekw0dU9K?=
 =?utf-8?B?MDZWaUhxV0hWa1VTTmxma084Ry9iWWNTTHoyWGRCT2dkSmJxK2VpZVZ6V0Zl?=
 =?utf-8?B?aHpaR2VmRFhPd2ZiVzZVanY5Y09xR0xsQTBWTllBTDR3Z2lDdDlKT3ZyRTFP?=
 =?utf-8?B?QjY2TEtoMmpWYisyQzFhdlZHZ3dzTkN0QitOanU5eW5ucERhcWR6VUdUUHgz?=
 =?utf-8?B?OE50aThvRzlqZ014dkxnWVFxQTZsMXVHT1JkT1RnOEwrNTQyRGJ4SWxYeUJ4?=
 =?utf-8?B?Z0Y2U1Z5NFpUOUVKb3JISWJCSnBWWWU1VFcxY0M3OWpZTVNaRkhpQ0NkZUJZ?=
 =?utf-8?B?aTZNMmpRb001R01id045TTR1SXY5RVNYQ3FJU0o3WVZaQ0dKNnkzQUh2dGIy?=
 =?utf-8?B?bDYyMVIvVXVlLzY1b2RGeHpDeURxQlJNWUlza3FacnJQQzVsajk1SlkwUGNs?=
 =?utf-8?B?VWZ6Z0RVMWxTNTl4U1lubGhIOVhVc0RZMzU5UEM5cWhEZW00THY5UjJybmM2?=
 =?utf-8?B?bmZuRGNmTTFLMWV6Q1ROd1VhR0kycVhPTjU4bmlzWGRLVWVLN2NFVEI5WVhJ?=
 =?utf-8?B?VnRKVTlhekwxVVRWTWl1RW1idjM0eWMzbTB3aXVFZ0dBeHFnVXltNjc4eGhs?=
 =?utf-8?B?aFM1STZBckQ1SGdVbUFZdVIwWWY3T0trU05aNjV3YTJSSEZOZ3RpdHNKcXla?=
 =?utf-8?B?QzI5U1daaEhJTG5ZYW95TU5nU1FwbjErbFErZUREc09vOFE4VHlPbStQMms0?=
 =?utf-8?B?dDZ1ZFdJYlZIWi96QThOSlM3ZzJBVjZxQVlqcHkzZVhWdFpNd2VzQTJPUnBD?=
 =?utf-8?B?Q0RZWksyam9WbUUxS0xuaUNzeVZ5OFdYWDRsenA4RVIwU3FFZE1TeHpuK1d3?=
 =?utf-8?B?Nmd4K3FHUEZncS9DY2o0WDRMcENzd2t4a0l0bGpYKzhOa051b1A2bktkMExs?=
 =?utf-8?B?OWtVWVJSV2djRktEOW54M2p4OUZ4M0JZS0xMd1JuSlQ2U01jTFBTK0NRTWxW?=
 =?utf-8?B?dHBQZ0ptajVENUF6ZlNnaTRiVzhlVTlzdGFpRjZMc3VMTlR5TFRDYTk3Y1d3?=
 =?utf-8?B?bG03Ym9qVVFJcGtub29vbW9sL0lHS3JXUE42UndwZFdFL0EydnBLNHVoTmRj?=
 =?utf-8?B?Q1oxMFB2R296SG5aOUxnTElpTVJGZGU1cWZ6K0k0UUhScXpkTEZqTkwxLytn?=
 =?utf-8?B?Zi9ZdXJxY1l2aExhaDRZV0tFeHR1cEZuM1owek1EMnFkaCtVc2JsZFVOMmJk?=
 =?utf-8?B?R3ZRM1J5SFNhRXVFQ2NGcFFzQjBpMm45RmJ3Um1sdUM0MkIxWVpGZTNKbE0w?=
 =?utf-8?B?cEM1c05sMk1wNHZEUHZZTkk0WkkyMFZZYkFTUVZJYWY1d0ExbDkxVnBnRTBV?=
 =?utf-8?B?c2V1WVhmMFRJdzJRUGpRbS9iQ3BjODNNNDVsS1ZjWk9MdU5aUzBwR3dsTXph?=
 =?utf-8?B?Y2JFNCtnMHNyTU5IdFVWNkE1cWxyeURtbGNjckhMYjJzUGk4c2lSeFhsMkdJ?=
 =?utf-8?B?V3RuVWZPMXJnb2JoWk5kNzBKQUg4U3BtTitlRXhvVlFpUmxWZjN3VzZRWkdW?=
 =?utf-8?B?dXVtdXdra2dXdGY4WlNtUmNhU29ibnJQdDZTRUdyN1d3eklzNDExM0Q3SDJB?=
 =?utf-8?B?cFdCaFl0Nk9QT1p4MHVrcDhTVG1CY0RPc0lGdHZ6YzhPaVo0Qm5naUh0ZjZv?=
 =?utf-8?B?U3hZQlcyRlQ0SDY4elk4dzh5MW8wZ01QVjZoZVh2UExoajRIeWoyVWdZaGxn?=
 =?utf-8?B?RDRwU1BKNllPTG1kOWVvRkExYTRzVmJ6bldESTBEQjBLQ0lmbGpVbWFvTHNl?=
 =?utf-8?B?WUl1QVVsSnRZcy9hbFo4Z1N0OTBTZWRKTmVFN0k3WXY2dWQ3SnUzcjFzcTM4?=
 =?utf-8?B?cGx3enNrTzQrTU5ZQVYwdWt0eG1LRlI0Y0FsTitQSUhkOEJIV1V2UWZNZXVn?=
 =?utf-8?B?eSswYkc5ZFU1cGJoc0h1VktaQnc5K28rb2xnazk5aWJFN3J5T1gzMytxcGZ0?=
 =?utf-8?B?cFZEVkFsMEphcHRtZFhqamEyQklqUC8wcFQydk0zTEVqMWRrZTg3MkFBNVV2?=
 =?utf-8?B?SVNOZHo4blZBMVFTNXVsWHdRdFI0bmlEVDhBK0l3d3lva01VNHQ4Qm9tZG5K?=
 =?utf-8?Q?nU4/aOpdNq4uHU4W50BoRt54EWUbIn1tBC2VbWtZVXAx?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 009e0d90-dcb4-4b19-8e88-08dd677eefd9
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:15:04.5124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fygA4V19q27iBhd4ivOfh0lY2FwMzYaTLWrD3+tPaGI14ngJVEHz3MaCwQ7R2PUxhmumZEg2XJZHl6U03oLIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2020
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

Am 09.01.25 um 23:27 schrieb Tom Rini:
> On Thu, Jan 09, 2025 at 12:41:56PM +0530, Vankar, Chintan wrote:
>>
>>
>> On 1/7/2025 7:52 PM, Tom Rini wrote:
>>> On Tue, Jan 07, 2025 at 03:08:28PM +0530, Chintan Vankar wrote:
>>>
>>>> 'sprintf()' function defined in 'tiny-printf.c' is returning length of the
>>>> string excluding null character. Fix this by increasing TFTP pkt length by
>>>> 1 to avoid TFTP error of request being not-null terminated while
>>>> requesting length of packet.
>>>>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Tested-by: Wadim Egorov <w.egorov@phytec.de>

>>>
>>> Erm, if tiny-printf's sprintf doesn't work like lib/vsprintf.c's sprintf
>>> in this regard, we should be fixing tiny-printf.
>>>
>>
>> Hello Tom, I have observed that 'sprintf()' defined in lib/vsprintf.c
>> at here:
>> https://github.com/torvalds/linux/blob/master/lib/vsprintf.c#L3035
>> also behaves the same way, that returns length of the string excluding
>> null character.
> 
> Then please rework the commit message, thanks.

Any updates on this patch?

I can see the exact same error when using ethernet boot on phycore-am62x:

Filename 'phyboard-lyra-am62xx-3/tispl.bin'.
Load address: 0x82000000
Loading: *
TFTP error: 'Request not null-terminated' (4)

