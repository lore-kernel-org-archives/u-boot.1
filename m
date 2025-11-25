Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80668CFD376
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 03:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D524883F4C;
	Tue, 25 Nov 2025 04:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AxftSPr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13ED283F4D; Tue, 25 Nov 2025 04:31:47 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5105883F2B
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr2/Ph5hPuv047Q8as9kAXs1LZc4DkLP5IJgT0JkRxBuvbrKTer9S3jtYcdUfugF1DnYmjEH1WJ8ahEFU3nEr6ncKK8eKYnBdmNxZ0hmlxQ2jqYL4qr3MBHavVI997ndbQm/2TXVY96G83lD5Te+Asdn5hjxZa/kDcIHOTaKjPYnK//WpGNONTFy+kak/oOJbpaDNPwCIzEcQujL0c15cb45mMfOmGddff/kjPF1QzruqBWwFkFkjfVYZObaJUOrHZFJdw1ERtNL2bH19yXwb5ydr17DUIppgsGAJu3PgMP4B96XzUsQdod05sxaAdKNCHowsRzW0pOTdbWwmRbVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mxP7C4DZFKqnxh/zJ8JybdFaYYgRDJiY2rud/cbEu8=;
 b=Oo3OP1TzI8i107wbVM4XFMBlYHN2jLBkdFr24ywX+IZNCe7PgmMfd7AFpps43cke+l1DKnkWbiorWw7rh5s0v2fzYDgZGBThtjz6/3AnfjkEBsLiI6LXuuh76x4GBcbCfqZ0/zjqisRbcorbWJWPKq1KgwIql6V6OEXL9Bzc05WF5MI3wqd5tc1dnD1dFRm4dhjJITUIyRCiW7i/j9IMLY86Duc7BBQEa5IdPv1lnri5JDaqSdI4VHvf9M92a/vis/vvJ2xJjzKB9bOMQ0X+McVhxRyzWCnbI57NSuZCJxRIHOuJ4lOtsXst5AI1Cr4ExyNggmFIwT9+e+GvW0IKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mxP7C4DZFKqnxh/zJ8JybdFaYYgRDJiY2rud/cbEu8=;
 b=AxftSPr7/XMyZm0sRS02Zn7uUgQTqssz47ZUY97bLuUu5s8AQVVjJetcKSAKwKs0Tq0gXJhv4bmGzxVO6gOE9npQTAoB13kn5YiJbRcchxF1dUmiW0MZKSMmc2rczGWLJxg3tUhs+BY6QHNr+dWfSy7lbUhpG6eeh0jLUh9Trq5UMexNOCVXm7or8qPBkucLm6Oxkq53TN0VdxquH565ANz+ryH32+ehUV/0PCi4eF2TfnzZ8dizYucS8vYg06aipNrpGbBU/6bIi4cTzi4aj6BTSwbx4LAZvMHEOgECGgnKoLuAFyJ8V9WGOZ+PwpwMxql5N8j1tN2bmhweOriywA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB7369.namprd03.prod.outlook.com (2603:10b6:806:382::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 03:31:40 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 03:31:40 +0000
Message-ID: <3682cf96-0cca-45ce-92ae-9fc33345e3ee@altera.com>
Date: Tue, 25 Nov 2025 11:31:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-socfpga: Fix non-Agilex targets
To: Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Sune Brian <briansune@gmail.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d5d830-7416-49ed-4a95-08de2bd32548
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUJpZ2hheTdobDVEbjVNMWVZV3h1MXBtUzhqUUMwU0hneEhOSUN2M0xSWUJq?=
 =?utf-8?B?eXl4MXR4bTh1cGlNVFczWW9na2dxTkNYbG5DV0RNbEJFSGY3Q21PZWlibks1?=
 =?utf-8?B?QkQ2dGc0ZzNIaGhoZUEvaXJSTG9JRi9vZ1ExVzJqbzd4bnIvNStLRjVsL1N6?=
 =?utf-8?B?REI4ZjNKKzg2QkVMYll2WCswU2NqblFhMkNxb1NGNHpRUlcvWkxFQ2J4cVRR?=
 =?utf-8?B?RDY3V2h0RUdqbGVyMnVmUkdNM2grRGpGR3RqUnovQnZPc2dodkFseFozcHk3?=
 =?utf-8?B?TEZzMzJ5dG1WdUZ3WndzdklsZjJtUHZsTlNwMWRwZ095bFZ0RkpwZkhUQ0Vj?=
 =?utf-8?B?d2cwbXk3YzVpblpEL1lmTmFuaEsxOWZZMk9GWnhiL1VUcmxkV1V6RS9xY0Fv?=
 =?utf-8?B?QWZqYm9kS1N2NkRxbTZ3WUV5VlVicEszQ054aGlOdjk2dGR2MlVrdWxJbTc0?=
 =?utf-8?B?K091a2NMVnRFSHYwekNhN1FCQmRPL1VwOVNOcldmaVV3S0hiVXdiYXJ4NHdk?=
 =?utf-8?B?MFNGbW5OUzdxaXErMFVPT01uNnNTMGcyWkIvZzZDdmNzZVdWaFFnc0tjekVa?=
 =?utf-8?B?b3ByUlBIaWx5R3dQZVEwZlBkanhBWS9VSUxLaUwrSjBsT01QMjlZNlMrbWN4?=
 =?utf-8?B?dUN2YXJFaGl0YTFRV2ZMWWdtK2RXVUhXdStvbXN0SG1lUGZxUEVwNmVMdU9u?=
 =?utf-8?B?emJPVHIxUzNSUjR3d29Ocy9nV3VGV2l5Ni9GQ2ZKc2tyRnJJQ3dmUGRmenpp?=
 =?utf-8?B?Q01QM29FZS9xc1VPSmhIQlBzK3RNSi8rM3VoQ21Da243Ym5VcFlQeDcrZkZI?=
 =?utf-8?B?VC8xK3ZFeG9pcWRFekcrY0VRTWNtSzFNbFlrNS9MVnNhZ1IyajQ5bldBUmVW?=
 =?utf-8?B?dllzejBUT2FpSEFybSs3cTBkVWpxcVo3anl5RUtPRUp4QUVOZzVLbEZJWEx6?=
 =?utf-8?B?MjFwNEZpRytKbXVoZ0JYcmV5NW9YVFo2dXc5aHEzZGhxcitid1o1RDN2QWRR?=
 =?utf-8?B?V29IT0l6L2k4anFiZk9ibTBqTVNKbnp6ZHZ0dTZqcWJBNTBFNCtQMXQxc0Jr?=
 =?utf-8?B?aHVLM1VjdjJLbzFKRUZwMDFjUzNwbGlIQXIzY2lXRm90MWxPZFIyWjNUT3hj?=
 =?utf-8?B?VE1xY1BlUGhmcWh3dzNDZjY4WStlMFI5OFNsNkt4YmQ2R3I0cGo2UktDMi9r?=
 =?utf-8?B?NnR2WGIwUTBRQXNqYmUxdU1XU2hJMStpdDdoUmtCbVdFdi82NTVmT2JvMUJD?=
 =?utf-8?B?cDg1dHg4VG1YcWF4UU5FSldtKzdUcklGZGxCckVDTkRJNzU0SXU0NlM2aWVJ?=
 =?utf-8?B?QUprc0J0Wklkdk4yUkN5UjlxQXlKM1RXb2IwbDIzMEN5dTJpQ3dIWnVwSlVx?=
 =?utf-8?B?R1huUm5rejZpbGZlaFoxSVN4a2pIVmxPeURSU2hzNGlhTFhLUk9MTmQ1SU4x?=
 =?utf-8?B?eXBLTU13WVV1ZW83dzFMQk81WE5XM1ZsWnhUTEx1b3ovYkRXbzlITGkrdGlk?=
 =?utf-8?B?NHc5NHN0YUN5dWwwb2w5eDB0bjZyY0thZXdzTEhySVpMTThRQm05TkE3cms5?=
 =?utf-8?B?LzdVMWVYVSsySHVkUUZsak4yVUhvTXdsYkQzcEE1WDY1aDgxeXZVc3dvZFU0?=
 =?utf-8?B?ekNuMVlCS25zeHJTcFRqclIzNU1hTTkxQkU0dzB0bzBRUlVLUjcyRXl0OHM4?=
 =?utf-8?B?WlpCSzhlMzlCZ0RNbXVEMFAzNk9XNFl6RlE0UENZUjdzb3pCdkhEcFBKVkta?=
 =?utf-8?B?b1hScE9nTlJMaDZUalpuY2piNkYrTTFyV3AwWDVjaUd4MnE3YmRUT0doTldI?=
 =?utf-8?B?WTdKeE5ZTnMvZjhWWW44VjhEa2EvalJxRmhxSkNSRVEvZVBIRlhWamVaY2FV?=
 =?utf-8?B?WnM4S1Y4YU9Zenl5LzR1cjZKcVNtamtITUcwTTFIeVcwWlJyK1l2SW9FeDhP?=
 =?utf-8?B?YnhDak9KM3liMGw0SDVaODZVL2J1UGdRTFllVGliV2ZqNExQTzVydnFwYVpq?=
 =?utf-8?B?cjcxK0Y0b1B3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJwdE5rWEtYeVR0YTJqR01BQjUyYThpRWQrY3V2cUl6ZzYvb0dKMWQ1SHVX?=
 =?utf-8?B?SmxFZ1ZzSE1FM2ZhUGw4RjlUeDZUUTFtTk9ZQlpVdVpKL2JXc0lKMjBZdXdl?=
 =?utf-8?B?emtIZEtEYURCL09rdWR5dDNPVmZiRHZjOGFzZjFxclpUMHorbGhkaXZWUFJu?=
 =?utf-8?B?Vy90d1ZHNmVTUkJyQVlzTnhNZkxsTUNjenZEWUtOYlB6SUE1OHVacjlBUGZI?=
 =?utf-8?B?R2g1Y1ZueTFCUUtLR2w5UzlIY1h1Ui90YTBmV1MydC9VcGZCb3QydGxiRDR5?=
 =?utf-8?B?MmVIVThPQ1pEL3dNejU5RWlOTEVJS0RHVitHQW9jc2ZpY3QxYlNtMk8vb083?=
 =?utf-8?B?KzkySWFOTWtVclYzU2pmTXlRY01JbUE0M1Vlanh5Z0NsVlpGdmZsQmN1ZUlr?=
 =?utf-8?B?bEMyV0FRYmVzY1NxTk52U2UvV2xrTUpseURrWTJDQU9aM0NiV3p1WkFJVWRH?=
 =?utf-8?B?Y2FsbUJaT0VYK0FJZUlaczRXbEhHUUgrMFl0MWQ2MkRUS01KRGdObEhFWlBj?=
 =?utf-8?B?QjVZdWUyTWxkaEZqMituMGJtdVlFeXZYYmxoRUpIMVVmd3U0SnlEdmdjRlVO?=
 =?utf-8?B?ZVJUS3dkNDYzVEtaTnJKS3JFeWcwZXZ5c2hid2Exc2pnK1pwdmVMT1NOek5V?=
 =?utf-8?B?Rnh6RTNlR25sN2E4a3VzU284a3ZaVEcrZnYraXRrZXZoOEN3MmZoM2lXMzRW?=
 =?utf-8?B?YWIvbXZPc1pFV0dDV0FqQmlQRGxacWlTVFFMMkZudlRpMlh4ZSt5QUFUZ016?=
 =?utf-8?B?cytvQWwrU2wrTXBtaFh4bUxVa2hYSHJtSndBMXZVeDFtcW1TMTY0TEcrNUI2?=
 =?utf-8?B?Z1p4REpHSUJkdGZsR1IxcnBQZTRnUE1DKzMwaVhDV3NFT0ROVFhnZlZHOG5Y?=
 =?utf-8?B?U0xYa09wR3FvdXZhVmY3M2Uwb2JRdXJmd3J2L1BOQzluaFdva0JSY2dlQlIv?=
 =?utf-8?B?a05jN3c0UjF0QThQN2lWdEJRVEtMeVdTemEwKzZUSk80aVNRSmM2U25sWDFj?=
 =?utf-8?B?VGUyeFVnUTQ3aWxqdDUrZThiYkp2UHBPRG1FZzZBcjd2YW9HV0h6QVRzME9h?=
 =?utf-8?B?aGFudFdUUzVhQk12cENka2s2Zlc5OVVwNG1HOXUzaU1hWW9UbzdhcTdmK1ZK?=
 =?utf-8?B?TjR0Y2piUUJkQ3Rjdk90dlgxY2p6MkJjUUZYRlJDZXdQbG5sdE9aR0MwU29u?=
 =?utf-8?B?b1RPdWwyM0grWGpIc1Q2NVhGODdKbGVLK0duUHg2TVlRVFlIbCtTRnF4UFl1?=
 =?utf-8?B?OXpjU09jcE02RUFjYVN6KzZFNlA3dXpXeW5kMUtLeXNSMGRrS3RBbTlXNzRB?=
 =?utf-8?B?M3F2NEQwS2ZQaGRDKzFyRy9hcThQQmd2cWc1ZjY3OUFxNHgvTVNxdHExQkFG?=
 =?utf-8?B?RzUwdDd6OFdZeU5FY3NiU3NTbW4wMktFd1hmNTJHWG9XQXNPRDBHeTBNRG5N?=
 =?utf-8?B?WkdpK0dDSlBTV0ZKalVwSE9NUm94eVRPS2Q1aGZ0aFh4QWF3UlduVmFJMVg5?=
 =?utf-8?B?UHl0MW1oUlYzSXhtdmR0QTd5TnhEM0RjbjErSUQ5MlBWNTdOcFhObFU5b0l5?=
 =?utf-8?B?aGE0NTlINTlkWm5rSXRYNzZXeWtoRmx4c0ptZk10SUs0eHFlY0ozY3VLNVk1?=
 =?utf-8?B?c0MwbEJ1UDFPMHdrSnFSNDY4WnU4THRhc1ROQXVMbFdYVHJ5enNvK1VUbXlC?=
 =?utf-8?B?Qk9sZFVLMmRPM2EwOVoxS0NQbWdvWWxXdEl2SFJsYnBBekg1VUxEdFIzNzdv?=
 =?utf-8?B?blBFUjJPZ0xycm9IcXVJL283bVBBaUlqQXRJVnRHN0pDVE5wc2tzNFhabjl5?=
 =?utf-8?B?QWozb2hzT1RYZlJQQ2hLUUpkZkw5YWpRdDdQcmdrRzFkUFZIczNhTGo4cWZL?=
 =?utf-8?B?ajE2dHlwL0ZnTVdNT3FXbXpocjdOSjgxS2JHU0xhZFd4V3BqUVVwRDNMem9l?=
 =?utf-8?B?clRXbEJ4ek1keWJjTFlVbithalNVOVlCUUxFQVYzOGFyWnphM2MwVml2Y1RN?=
 =?utf-8?B?OHltTFc2SFpmWGUyYkcveHFvYkk0dDY5WEp4bm9xczZMOU1ndlhDWTlyUFoz?=
 =?utf-8?B?TU9xVkNvc0pQMmk4TEl0QThsbE53Mkl1S2V4VDJ5ejV0OENwdWoyNExwL2xr?=
 =?utf-8?B?enE2NFhiODlhcTdaeFRRT0N0NWlSZ3JoNy9KYU1OOGdpcXl5VU1TcGxuaWVD?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d5d830-7416-49ed-4a95-08de2bd32548
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:31:40.3665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO0WNeiLC+oVmkHM5MAzaJgUgVuifX/+c5mCIHQiMp82re89Gy1CrGbPAP9ZvVa9tWmhuprwPyXk/1/wX+tdzxvDqZ2gFO9tBd3CEI495TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7369
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

Hi Jan,

On 14/11/2025 8:07 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The Altera system manager device is only provided for the Agilex
> targets. All others were left with an uninitialized socfpga_sysmgr_base
> after that refactoring, breaking any boot attempts already in SPL.
>
> Tested only on Cyclone5 / DE0-Nano-SoC.
>
> Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for system manager in Agilex5")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   arch/arm/mach-socfpga/misc.c     | 7 +++++++
>   arch/arm/mach-socfpga/spl_a10.c  | 1 +
>   arch/arm/mach-socfpga/spl_gen5.c | 1 +
>   arch/arm/mach-socfpga/spl_n5x.c  | 1 +
>   arch/arm/mach-socfpga/spl_s10.c  | 1 +
>   5 files changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 76747c2196a..f859d54dce4 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
>   void socfpga_get_sys_mgr_addr(void)
>   {
>          int ret;
> +#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> +    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
>          struct udevice *dev;
>
>          ofnode node = ofnode_get_aliases_node("sysmgr");
> @@ -293,6 +295,11 @@ void socfpga_get_sys_mgr_addr(void)
>          } else {
>                  socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(dev);
>          }
> +#else
> +       ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
> +       if (ret)
> +               hang();
> +#endif
>   }
>
>   phys_addr_t socfpga_get_rstmgr_addr(void)
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c20376f7f8e..26828077c51 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
>          if (spl_early_init())
>                  hang();
>
> +       socfpga_get_sys_mgr_addr();
>          socfpga_get_managers_addr();
>
>          dcache_disable();
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index df79cfe0f7f..f1c654e1566 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
>          if (ret)
>                  hang();
>
> +       socfpga_get_sys_mgr_addr();
>          socfpga_get_managers_addr();
>
>          /*
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index 81283ef7162..ed4e6f38b31 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
>          if (ret)
>                  hang();
>
> +       socfpga_get_sys_mgr_addr();
>          socfpga_get_managers_addr();
>
>          /* Ensure watchdog is paused when debugging is happening */
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index fa83ff96adc..460a6f88416 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
>          if (ret)
>                  hang();
>
> +       socfpga_get_sys_mgr_addr();
>          socfpga_get_managers_addr();
>
>          /* Ensure watchdog is paused when debugging is happening */

Thanks for the quick fix. I’ve reviewed your patch along with Brian’s fix
(https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-briansune@gmail.com/).

Both address the same issue, but Brian’s approach keeps the change local 
to misc.c and avoids spreading SoC specific conditionals into SPL paths, 
which fits better with the ongoing DM migration.

Functionally they both work, but Brian’s version looks cleaner for 
long-term maintenance.


Could you take a look at Brian’s patch as well and let us know if you 
see any issues or corner cases we might have missed?

Thanks for your help.

Tien Fong
