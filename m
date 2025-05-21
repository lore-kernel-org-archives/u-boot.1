Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A17C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E94482E31;
	Wed, 21 May 2025 17:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TBaFfT7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA49F82E9A; Wed, 21 May 2025 17:18:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9EB82E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqvAVrLrepnn7kM77LZ1SI7y8DBCr8geALf4uY+gA06hFPdEzd+1U6oXqm6vr/zsGqnkpFYASUx0V+iGyNfiFvg3H8Q/tlLIaBq29IQBkca+INl6NIlTqb5ovniQ5gec5nN09RJPDZrOEUHOB/KPRbwGRz/q3V2/ehPrJETxI5r8GrZIhszw32KnI6bNEZziW3W0LgnfIMBbqDAefbs0PxaNhkB99eRqG/D86cIQUNJ3LJtrZ1F7m9U25vzQHI9QpXNtc+4cHbotmNtN2QCmItwLlio+BCs3/MB2k2mb6a264S1oPb0ROu1pfiYP69k1YXMkcI1FEMIgBF3BiiyQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfZl/j/5wUlsoreDGhhZdJkZaQ3aB3X2pFxT9pwefoU=;
 b=sUw601TBi5moqUYZPSpg+51rF7esdSRu9F/gYeBJkNx+kMUMBjFu3kAMpTuU7xj3F5pxqJNOjmtcBduy68pD1/FaGBUNwiOVkSWzwYTj9BhXJzBIAqL/MOQcQrL94QEPOpPxN1dqvAwsG+Kp6DwaQJuaf235AEwk8Hzl0iAftelPqpCwKKlGFoCCNzAvXyjO6W2wT9Q+IE6KAJ8X99f5oegWd4YLpoc7uoaPKgiV9QG0dbfvWpXAbb9bZqZm1bxPXv7jpRRhAjTDfOpqJ4ql8fdVwGM2bWPn6Fs0UTyFAL32irTgJUEiJO30I38DzCsNU/nbfKhHpJ3X8vDLnY0/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZl/j/5wUlsoreDGhhZdJkZaQ3aB3X2pFxT9pwefoU=;
 b=TBaFfT7NsUN1iEEd6LNqShXftgslF14Ux0qwwVOtxiEe3MePDdN4Lip/up5Dzcv/hqhRFyRIJCttQ3KjuWluiGE+WrQWFq3k7a+eNlRw0L1X3vazpK93tL+xC9b2mPehwdGa+EzHDor3949hf1jeaJGZAWU2HHIEYj4LIUb6Mtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA3PR04MB11107.eurprd04.prod.outlook.com (2603:10a6:102:4b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 15:18:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:18:27 +0000
Message-ID: <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
Date: Wed, 21 May 2025 17:18:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200"
 <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
 <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA3PR04MB11107:EE_
X-MS-Office365-Filtering-Correlation-Id: e351189e-cde6-4d5a-1e16-08dd987abc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS9XeVI1NktnT1hOYWxZQWxwZEtqTlJuaXZyRklWb3UyYXRLcnEyTk5iSndO?=
 =?utf-8?B?aEZjZVdkZGtaVC9KUkxKcmsvVll4QzVjZlo1VjNreFhYckU1MmtaMS9mbkVr?=
 =?utf-8?B?UmlVU1ozYWswaWJUa0d0dzFvRXR0ZVNGNVFOSk1pV2l3RXoxdUNiZjhFZVlD?=
 =?utf-8?B?dmx2Sk1Lbzh5STBUdWNZRDhzNVluSisxWklYdVRYaEtsK2hJcFdrYm1YSWE1?=
 =?utf-8?B?eGJtcU1oZ05pUWlhbk9qMEVxbVVnNmVOTWR1dS95UHkxOTFlOWxBcTJtalNV?=
 =?utf-8?B?bHVLekc2cmx3aWR2UFVxTldkbWV1TjU2NDAvNUxDckozQWwvOXFuZDhZWHZY?=
 =?utf-8?B?MjFGdTdTeTZwRXhLbWpHVTkvWTFjSmJsYUhTQURuZnlVUnQyazFyNGd3VmpR?=
 =?utf-8?B?QjNWOVR6RUo5ekxaMWxSTHpJZVFFREpZVlROUVN5dndvbmQ2YWRQU3I4aG5q?=
 =?utf-8?B?SDBZQTdTM24vc0pjRmJXY3NyNGh2dE9OUUNmVFRXUlpXRGpYY0dZR0N4bUlP?=
 =?utf-8?B?dXFEN0E4alhnNGtoQUE0SmZnRFNVZnhDM296UjJseHgyM1lZUSthRFliWnc0?=
 =?utf-8?B?SzRDZEkyUVh6VWtINVJ3dzBzMWlVZldBWi9mZ0VtTmhiN0RZWTZ0bWwycXda?=
 =?utf-8?B?OWxtVmtGNGpib2hKYkpUYklJKy9KbXJnRko1cmhYSU1sSVlPLzhhR1JodllH?=
 =?utf-8?B?SFRJSEc4L20zaDM2bURnMWFIamx5ZjhDY1FpMnVPQ2pHclBPYWlyMmErdC9i?=
 =?utf-8?B?RkZGU1NNTHJhWGpvelJEeVMyK0tOWkJnTllTYk5MSlNET2htTzdiWWVTb0sy?=
 =?utf-8?B?cFlBQ1FCL1NnMWdjeVNwVm1iTndEeE5QcjMyWE9UYitoNWJtbDF2aDRVSWgz?=
 =?utf-8?B?TTVSZ3F1bTNBVGRoYnUvRThnL2NmUG1HbnRFanM5aEdLelNWRTErc0s2eExT?=
 =?utf-8?B?bERNNjBtSCtReDBHMVdwSFdta2w5UXZMaVgvVUgvTGdnbUhwd2tpMkJBNGxs?=
 =?utf-8?B?dlhTOXM3U1FTbzI2L1BrOXR5czZrOEVXSFdEUzZyMzhFdE1wakJabEM1SkJO?=
 =?utf-8?B?WXQzbjN1bWNib1hGaTE0Mk50NmxMWGlkd2x6dGhjVWFIQllRTTl4NzNVOVpn?=
 =?utf-8?B?cDdKMVhuNXhJOG1UUTBzTlFzc2Fuc3hVRTlleXcwSUgveklOZ2lGT2ZCbllJ?=
 =?utf-8?B?Tml6QkNUZHBYZkxoemIvclBSaTQxUGpHOGxYdU4wNk90L2d3c2xEY09vaVNJ?=
 =?utf-8?B?R0FidCt3V2JUejQ0VUZmcjNDYUJNNUQrMysxQXNmamExTzRpaFlwVk8rMTlE?=
 =?utf-8?B?dWd5MFgzSjJHTmVzQnBUYXlMYnZRY1dHbWZSeUhnRndkQ3FiZHYzU3hJank4?=
 =?utf-8?B?UG5SU1l5L3B2MG5YWVQ4NG54ZWNZQmNyTmtLOUVlcENmS2duLzYwMkJpMGh3?=
 =?utf-8?B?enE5Z3BEVmdTSXVieTlHS2V4YTR2bkZqMmh5L0tjdEVRWkhLekREajgxNnFR?=
 =?utf-8?B?MlEvYnora01vY0thN1pSKytCTFk5T0lXc3hKTGJ0WmdOaTc0QXg2Z3pEMGZ4?=
 =?utf-8?B?N0dCL1MxOS9VZytQYWEvK2Y5d0l1OWRkUit6NW9TQ21ENEQwZjhSTWlUaEF3?=
 =?utf-8?B?N0ZZQkhUakZwM3k4cFJUdlBHdmduVXRNZUx5U1lFc3B3OEVTdC9lc3MwM2h2?=
 =?utf-8?B?WEtvYTVON01mdGEvYWJwNXkvdlJSVHBIR3NhZC9tcUZ4anowdnNWVUlFaitF?=
 =?utf-8?B?VGxvcy8xbWRJQm5PWHhwZHJWYUZKMXZDL1hZUlFYcHRScjNtRS9RL2k1NThT?=
 =?utf-8?B?UjYvb05hT1lsTzRBTzhtOEt3VFhqUkVrYU4vZ1RtU2xLTEh2MGN5NG5GSFV2?=
 =?utf-8?B?L3pPSHZ3MGJCTkNSTnFvMWNyTUdJWWtiTjRrdjdkcVFreExxdXFHZ1I0NlRU?=
 =?utf-8?Q?CyR44FkbGKQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNsMksyejFmRlhwdDhIVkZMRlpIUXY2bTJIaUUwWTFiR1k3RW9DTXc5b0o5?=
 =?utf-8?B?T2RmTFUzY3NjWDVjQWhjNmgvQnl1ZkRCRUg2Smo4cUc0V2V1Y0VObjNWNURa?=
 =?utf-8?B?RnZaejJiZTB6RGhreXhjM0xYYTZqbTI2ME9MbWxDdHRwSmRKU3BjZXh0MHNn?=
 =?utf-8?B?NG8xL1UwRVJTRU0rdVZnMHNtZWV0bTZ5dmtNMHdsM1FEa004WW1sWVZWWmVN?=
 =?utf-8?B?dDc1YmlFRXF6ekFnN0RLZDhlOXM5ZHkyRSsveXZINldPR0puU2dKV1BreWtw?=
 =?utf-8?B?UHpUL1NtQjdhZkVEbm82QmlZd2FlSENzVTFBeEtWd3hWRTdxRVFCRGJmVThs?=
 =?utf-8?B?Z2JEeXI5L2RaV3gwRThNREFCWGFacDZQdkVkNzVCelkvQjQ1TmtiZUZueElk?=
 =?utf-8?B?K3Ewa0lld203Y2IybUtRY3ZQS0xVNXFBbGVtYVczU3RQM3pnR0JXM0pVZERO?=
 =?utf-8?B?WUM1dnltMU9oN0MzYk00WXdvV2Vkb3RFbFlITXRBbmxoaEJCTDBJTjZEc2VI?=
 =?utf-8?B?L1Q5TlM3cTdSZ3FlWnhsY0JVeXA5MXdTeWhRV3graGlEclBWbnp0eFBEOG9M?=
 =?utf-8?B?cFZ1UmNEQmloQ09QQnRTNDA1NE9EM3EwMXpYMG8zUWFaWTl2OUlLMEV3Vklz?=
 =?utf-8?B?L0VoU1NlSTF0WWRUR3hmd3VZbVBQZnNjYzRBQTY3Q0xSUCtiOWtuMXBhQTNE?=
 =?utf-8?B?eW53dVJTSVpFeklPelFmWXRUTnN6dTYyRjhMd1BnOEVCVFpZRS83TGowZDNX?=
 =?utf-8?B?UGc1dTZNMndSdXhZRm9udDBvVkJYZ1dUZGgzb1Bsb1NtNkg5VFhUNStnWXZZ?=
 =?utf-8?B?MGhBdnJ0L2VIRFEzS2lId1RiWUZzNVYzaUl6QU1BYXA2RW16THBoR21ZY1dC?=
 =?utf-8?B?RHRTVnJRZVlVbWtlL29uMlVTZzZxMjducHdwYXBRaTNzRDlaazg0TGhSazJJ?=
 =?utf-8?B?TmM1d0FCdEd6TlBuTUpaTlBySVN1bVBxUlg0K09qWGI5V0d2bG5JQVh4UjVy?=
 =?utf-8?B?QnJqM0lKTEcwOVFCQUhpeStwdjVNOVEyaWFpVHVDL2lmNGlxUnhQbTBJWXlR?=
 =?utf-8?B?V1MwLzdTMUptc2s0Ui9qTmc0YmEyd2FQWTh2dlFyU0RmbUx4TE93VGtyenBo?=
 =?utf-8?B?ZVBjU2NRUGd6WEsrZ1lxTC9qTmZWVnhDL0Y2OHJ4Q1Q5Um1MWDBJMHRBdzJx?=
 =?utf-8?B?d2h6K0w5KzNLZHRMTEU5QjhnWHBXd3NlN05zc1pOdTJzTzVhSGRoT1ptOG0x?=
 =?utf-8?B?WGN1UVN4K2ZtWVAxYXRySnkyNFlsakFUazJMdHplU0gxeURWZGpEcEJtNjZu?=
 =?utf-8?B?aEhYMzZtQmduZ3FaMGZGYUFmUmYyTU45OU9IZHV2MjltZjl0ZmN6RW9CSlcy?=
 =?utf-8?B?M3FCWk02UTNLT0JwcGFQRHBvZlZKS2ZwQkJOM0xuRlpBenMyYU80ZkQ3ZVhP?=
 =?utf-8?B?aUp0bnRvQXBqdGRHa3VBMkJ4dXNMVVFwSkkzOFE3aFJFa0lHVzM0Q0x6U2tm?=
 =?utf-8?B?T042ZzRCVmVFdVd6U2JUL0Z4eTNlY216L2xWaVhxb0ZDTjc1c1VRbE1hb3lC?=
 =?utf-8?B?YTk4TVJ4MGdrSmlLa0VqY0NSQzlPckRMSHN4aDV0aUw0QXkySGpYUC9ZaE9y?=
 =?utf-8?B?VndzNDRUY3BuUDdHUkxpcW1jOE9HMC9ZTTFJRmZRUysvSXhFSk1CbUpMOGgx?=
 =?utf-8?B?K2M2TithU3JXK1hISDl3WEV0V0ZPMUIzMER0Y1oySXhEYUh3RUIvdXhRa2xI?=
 =?utf-8?B?cGhmVjlUU0NSbDBIN3R4c1JoTTl3cTFnWG9sUGpuTFBwaE0xQUxxS3VJZW53?=
 =?utf-8?B?UTd5VFNPUm5lWGQvSzdMWjdwdjBzam92aTNiVjFOYVZEek45QkMycm5vZzRm?=
 =?utf-8?B?ZU5ET21qNUxEaitHbEFFMW14OG1CeHFjSWUxNm1mTXRCRUQ3dWpGZjZhRjl6?=
 =?utf-8?B?ZTRGL3MrdDViRDBwcWdnU2RKcldsdUZra0R6aGt6eG5MeDAwbHg5dS8wUXVU?=
 =?utf-8?B?NW5EQXM4NkoyVVRiaHl4UG5vbEUreE5HTEgvZlNWT0drVDlvczgvMXYvbW0r?=
 =?utf-8?B?MVRCNFpvZzNza2dYc3RvZk5uckZockdNV25WdVhvWGhwWUtxdmZjSkM0ZE1n?=
 =?utf-8?B?YVZwWjIvTWQwUmVtVk5wUldyL0hGc0FxbjBEUkl0eFR6eUx4RSt5UFgrTkk2?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e351189e-cde6-4d5a-1e16-08dd987abc41
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:18:26.9585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdpxraETCNCaDD79KQ+PcTBVhaBXO5wRvw5b3Ps1IH9d41tXp084VUuvSeGZTD9b/O6z7flVA1+WbmfAa9zSAouI7MsZ2PM76noR++HQWTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11107
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

Hi Michal,

On 5/21/25 4:34 PM, Michal Simek wrote:
> 
> 
> On 5/12/25 09:06, Quentin Schulz wrote:
>> Hi Anand,
>>
>> On 5/9/25 7:45 PM, Anand Moon wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz 
>>> <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Neil, Anand,
>>>>
>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>>
>>>>>>     CC      net/net-common.o
>>>>>>     AR      net/built-in.o
>>>>>>     LDS     u-boot.lds
>>>>>>     LD      u-boot
>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>>> `usb5744_i2c_init':
>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>>> reference to `i2c_get_chip'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>> maineline/common/usb_onboard_hub.c:104: 
>>>>>> (.text.usb5744_i2c_init+0x1f0):
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> Segmentation fault (core dumped)
>>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>>> make: *** Deleting file 'u-boot'
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> ---
>>>>>>    common/usb_onboard_hub.c | 4 ++++
>>>>>>    1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>>> --- a/common/usb_onboard_hub.c
>>>>>> +++ b/common/usb_onboard_hub.c
>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>>        int (*init)(struct udevice *dev);
>>>>>>    };
>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>    static int usb5744_i2c_init(struct udevice *dev)
>>>>>>    {
>>>>>>        /*
>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>>>        return 0;
>>>>>>    }
>>>>>> +#endif
>>>>>>    int usb_onboard_hub_reset(struct udevice *dev)
>>>>>>    {
>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data 
>>>>>> usb2514_data = {
>>>>>>    };
>>>>>>    static const struct onboard_hub_data usb5744_data = {
>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>        .init = usb5744_i2c_init,
>>>>>> +#endif
>>>>>>        .power_on_delay_us = 1000,
>>>>>>        .reset_us = 5,
>>>>>>    };
>>>>>
>>>>> I think you should completely disable usb5744_data in this case
>>>>>
>>>>
>>>> I would recommend to go the same route as the Linux kernel which has a
>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>>> the necessary dependencies.
>>>>
>>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>>
>>
>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with 
>> dev_read_phandle_with_args with i2c-bus?
>>
>>>> We probably should be careful and figure out which boards are actually
>>>> using the usb5744 and add this symbol to their defconfig so they don't
>>>> regress.
>>>>
>>>  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>>> which use CONFIG_USB_ONBOARD_HUB
>>> I believe using DM_I2C to guard the code is the best approach.
>>> it should be around .init() callback to guard this to work.
>>>
>>
>> I disagree. The driver clearly supports the USB5744 and the driver is 
>> compiled regardless of DM_I2C support which is required (as far as I 
>> understood, maybe that's incorrect?) for being able to use USB5744? I 
>> don't like hidden dependencies.
>>
>> Also, I believe Neil's point is we shouldn't try to probe the USB5744 
>> if there is no DM_I2C support, simply excluding .init() callback will 
>> probably just render this "support" of USB5744 non-functional?
> 
> USB5744 can be configured differently. We are using two configurations.
> 1. no initialization over i2c
> (but still you can have a need to have driver for reset or power)

Fair enough, some hubs are configured "properly" by default so don't 
necessarily need an interface. Such is the case for the Cypress HX3 we 
use on RK3399 Puma for example. The default is enough so we don't need 
the i2c interface even though it's exposed by the IC. Thanks for the 
reminder.

> 2. initialization over i2c to start the hub
> 
> And there is also one more configuration via SPI.
> 
> It means I don't think DM_I2C should be real dependency on getting 
> usb5744 to operate.
> 

Would diverge from how it's handled in the kernel (today) though.

Can we please follow the same logic as in the kernel though? Meaning we 
should report some message if the i2c-bus property is present but DM_I2C 
is not enabled, in which case it's likely a misconfiguration of the 
bootloader.

Cheers,
Quentin
