Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE516CFD376
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1088B83A03;
	Mon,  1 Dec 2025 04:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pyZTGo08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5AC83A1A; Mon,  1 Dec 2025 04:06:44 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2462183935
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F61brg67j7ISFbEVBi/+egCjgodjAzfMZx1dWRkF+pq8cSWRWP2B5nJoIv8wL4Tauog4V8PxGr7PobGcJqCvySYj43EmZ3iFF/OJfk1RhSNUev9njQ3NpDvrR+EHTuIYx4oAAVtBsn/Hlb2ZepqwDJEw2IyPnEKxOHK5Qg2it3vZ3eWk90lVx7w31ZXL1V23PEPwXh6oN+vy7/kKPO3+SBbVWu67bkZlf6PBcGCq3opvYV3LqqzkANkMGs2I1hyKJvZ84aKjdz3FuunlB8Pe6oGkQBwzYqN48NZSqPbTn09GU+GBGDe31u5d4XoSCqmVwQAWyEO4k67eEr9v8dZE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDtlrq7iU90bx/lVE2yD2wufezNcIxpI2ffl51VnOZo=;
 b=ubZVJVFMGBFiXHmLjmW1wOc5/CPudaKtqpsX+mp3pWqH9JuE7LOOUN3nJiRmeAf7OH2e+KCoCVwsSamhGstSoMnpH8E98DHUjDQA+BXNdMaLUx//M0Zk4fVwmJrYTfFj1Yj5WWd/c8xAzOe44Hf59z13XHgsG3ShwP93mRBSa801cD4GNxCoZlFu+avkW4/H3APQ2E7AM9BixX3w42R2R8NEyPWkiA+L4Pyg1iAyZjLAutJnbZ5rnOp9jjlERdfQ5nDnp9oN7drgcEMiP2qDeNqSDdexg9uoA9ma67LiHRFFYk0r77aSc2v2p5buhbmmbKVjI/oEb4Ga7LsUsf/qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDtlrq7iU90bx/lVE2yD2wufezNcIxpI2ffl51VnOZo=;
 b=pyZTGo08Q3fYOrp4v6kiYNJHaSo7f4xh2i1mK2YEuW5iWze56Zupe5KWkU7NPt9uAxZlgk+GR0wfO7mI/Cecg+EOYKw92u2cDv3gptPNvUdpUjrBEmDsUh0cCCWOQIZHkQuo4dOmx7KN7HUt+pWter86GSR2tnpB2UShjAxD99rIAJt+C8KeTyP+4IHkDg0LzNBngNOpXDjgmLoT4oQ0mo+L7jQQcJcE3SAD3GFKdezD+HUlDUCxfKk7Q5C25s26n28tFQzYEJyG7vsltT0lSThZ8RA2OAo9eWLXVSgFM+iYSozVqAVyPabj9ZXJAL0sdbgpuO+KdoeFrFIipkfVyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:06:39 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:06:39 +0000
Message-ID: <2de4ca6d-8de0-4479-832f-7b344518b976@altera.com>
Date: Mon, 1 Dec 2025 11:06:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] configs: cyclone5: Disable mkeficapsule tool build
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b52ba3-d58d-4a14-b427-08de3086a4ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3FIdjRBaTkyckFFVTB4QUkvTXhtd3FtNC9nNTFtblNHUDc4MThLWjdzWlQz?=
 =?utf-8?B?VWpHSGxNeWJSdlJwODByRHB4MVdGalM3Zjc1Q1VmRU14ZjFhV1UxaVZQUEhL?=
 =?utf-8?B?ZlV6SGwvcVh5clY1SElDOXRvT0I3M001SzR3OSsweGZXQWVObSt2V3NqdS9D?=
 =?utf-8?B?NmdKc3luRzlKS2MxanRMeFdGZERrRmRCSXZkaUZvN1V2V0plQ01qemJnS3pK?=
 =?utf-8?B?QmRrR0p1WGxDZ1hvcDh2V0J4UldOeEVsYWdWVGVKT0VSeklLYTYvdStSYVEy?=
 =?utf-8?B?N1VqSEQwU2VQMjBGUE5SY2Z6WS9pcC81cVlNQk90VTBJRk1JSnVpM3AyeUk3?=
 =?utf-8?B?cm1DaXo3ekw3UGRnR21EVkQ4aS91V0ZDZkFRU0ZxYkxkV01ZVWZITkR5aUla?=
 =?utf-8?B?Nzdhd2x2NjgxV1kwa0JPTlp5NW1ja2NiczlvdGZtYnFRb0pOVytGZkYxRmcz?=
 =?utf-8?B?V0JzVUpvRGo0WmNoTW0vM0xWWXoyb2NnN0lqQUdIb1hYanJzUm1LRzlpMnht?=
 =?utf-8?B?Ylk3WmNmRlkvRERWdGxsRi9wMmtpV2hQeGtrRWo3QlMza2NoSW92VSs3UHBy?=
 =?utf-8?B?ZzBDOXUvM2Q2VGl4WXhGc0ZNSzRvaUY0QXdUdnF5Y1h3c1FTWm5sOXJCdjZE?=
 =?utf-8?B?N1hFVFdVQTFlSytqQ3ZUWkRaZlpLSENUK0ZQNU9PY2RCU0JiZ2pjOTNhNUcz?=
 =?utf-8?B?cDFvVElCbVBwZHpKbDArQlVnazlQN0paMGpDVVpUQXptRmxiRzErT0hJcWhJ?=
 =?utf-8?B?TkhwalpSZ2pEQmlvcnhMSUN3VGZwTzlTNDhST0x1OG1EVEx5Q0x4aG5jT0cx?=
 =?utf-8?B?ZHlVeTJZcEg0UG41ZS8yWkdBdkZVUGRmeGtDZHB6UGs1V01BbTBOUkZDVU5M?=
 =?utf-8?B?R0pocWdtbkJDdU5VWTZ1c3ZPMHNhNzRVY0xGa09SS3hRWmxjNHlXZGhlV0Vs?=
 =?utf-8?B?akZRejdHS1p6bmt3Vk81dklZd0xmMmNnWDlYZ2w5bkRQenAyQlpmOHhVMXUw?=
 =?utf-8?B?RloxcDlLTG83Q1hyZkJ2ZnJidUhQVXNEdHdlZ0ZzNGs4azRSKzEzVmU5cUNE?=
 =?utf-8?B?bjVxUHBaSTNvU1IzZ2FXN3Z5dUhvTkV5aHcrVVZkNVNJcEdTbVVma2ErUWho?=
 =?utf-8?B?M21LRVdML01hYWlOeDFCRndvbTIzNVBvazR2TlVuOTZvMGxvRVJ4aUJDRW1U?=
 =?utf-8?B?cG5CZUUwQ2JKM1NpNGdhaWMwakpxMDI5TW9rTnFoNTdQdUdsSWdZR2Nra0l0?=
 =?utf-8?B?RGlDZUFiR01uNkl2WkloWmV4eUJJMGNwTjVPeGlsaXNUelRNRHlMZldDVVVE?=
 =?utf-8?B?S0duOVNGekthTDZaalZrQmxHQ1Zxc3VlV3BlRkZiZ0NNZ2FybEJaRmo1UU5s?=
 =?utf-8?B?ak9BbmFVc1ZSSkpYdHFxaCtuS2wwcHBXOXhMRVQyR0RMQ0p1VE1sZ2M1Sjdz?=
 =?utf-8?B?TWpsV2lpV1JrVlN1aHhURlBTSG9oT1pOZVdWRjJQRGsrWHZzNjVyZC9mNVBO?=
 =?utf-8?B?RlRYcEpGZkt2UTZoYlJjMzFENmVYYm9XV3p3RUdhNXoyVk1WbEcxZWFrK1E0?=
 =?utf-8?B?ZWxHV3o3RjlTR3dmeDk2NHQrUHlXeE5jeDNudUQzc2V3S1NVb2JTdUIzbGhJ?=
 =?utf-8?B?VDJDMGZIYWlzVjcwMDVaVkFpZWJpYkJLSThxajZ6UW5Ea2ZPcStaNXExYzJW?=
 =?utf-8?B?YUh5ZUhOMTNqS1RyYTZIRXdPOHBCL253MHBYTEI4TGxRUnpCb0hUY0tZV1gr?=
 =?utf-8?B?cURLYmZpMlB0UVZFZzE4OTBZcXIrODlMVTlrRkpKMFg5QWF2Q2sxRmlTTVdz?=
 =?utf-8?B?TzdxbW1tZkgwTkRwMm1nT2JXZGN6VGFxK3pvbHMxWGsxMk5oTzdyTzhudU5N?=
 =?utf-8?B?azJNWWhaSTQ2UjRCVWFqU2hmWWt0Um1oZzhHWklCdjFJSUtJZEkvVEF6eFJT?=
 =?utf-8?Q?LaIPkpVobdlluDjFQBfK/rpzN+J24JHf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBKdUdsWFNTRERUUVR3c0cvZm1DckpRR3MwUXcyc3pSTWd2Szl4QWpJYTBQ?=
 =?utf-8?B?YnIwYU9Qa0NRaE45NDJiMlFWZjZoWm5VRkNpa09DTEM4Wk5QNE9DMkpEcTYx?=
 =?utf-8?B?YkxlMHdrQ2c5Q0taMzBTc2UrRUVrajBqMXEyRElNcmd4Rm5DTjdhS1lpVDdU?=
 =?utf-8?B?N2phZUNzZ3FTclZ0RVN0L1F4M1VJU2hvRGhacHpxdVRRTlNGaEFBVC85S0lX?=
 =?utf-8?B?cGNxdi9qUWMvY1dIUFFtRjlBRzI5cWNvN2FyQm1QdTBUU3JxeVZaTklwdmox?=
 =?utf-8?B?QmlKVW9jeFlKblVWd1RSalJLTS9JSjFSdXBRM2k2L3lUOVBUS3ByQnV3cjZJ?=
 =?utf-8?B?VVB2MjJBKy9tWkJTSFJHdnhyKytqZmZ6bU1wcWpNM0FWc0p6SUYyVVpDTklR?=
 =?utf-8?B?STFLaFEraUYxSmhiRUQrVFZ1Q2VQVGhlalBBMTI4S2tnb1g5UkRUbTJNUU9D?=
 =?utf-8?B?UlkrOTVLaWNlYk8yMEdkajNXSGdwYjBxcmh1R1liTUR1eUZyVVpPcnVkc2or?=
 =?utf-8?B?cldiU3dveGg3Q3RRcDJnS010RXdvcyszLzk4a0FJdDltM0VsYmtpQWxQaGxQ?=
 =?utf-8?B?ZGFyZ1hWMzIwK0piZmtVL1BsdENmMmZkLzhlOVpmcUFrMnpQZVF0b2FYRWFF?=
 =?utf-8?B?WmY3MVFCa3Y0S0diYUt0Vk5CL2lWMFdpY0xvRXE5VncxY1FQUVQvWXd0NFdi?=
 =?utf-8?B?QXEvYzU2Z2QrMkFKbnQ4cG91Snk5ckJCdlZ1NFcxRzEwZU5VZmFQRWc2WU9K?=
 =?utf-8?B?NUdSV1pFTGZsS2ZtMElDcm81YVF1WEQwY09ya0RvSlZvK3hOZ3lLdmZGYWx2?=
 =?utf-8?B?dkE2Wm5XQ1RQckExSExIN2pVRTYwUmoxRFFGZ2ZzRWRuVnZxb2ZPMmRqazBW?=
 =?utf-8?B?b0phWnZWbU9HazUyd09LT1Bta2RCWXE3ZzRaYkF0QjRzb2NYSkxMQ3crZHBQ?=
 =?utf-8?B?QmhldkcrYStTMXRaekFqNE5vVG90b2xTUDlLTFJGVWlZYmZKWnM4Z0NkSFFU?=
 =?utf-8?B?V0hZc3JmQ1RwK2l6NjE1cXRHK2hSWTlBRGhteHFzVyswTC94Y3dHakx1c1M2?=
 =?utf-8?B?eFBiL3N1M280djhkUEdnN25sMktCa0NxSnljcVUyRFNHRm1rY0RkMDE1U29E?=
 =?utf-8?B?c1NteW1FS1BHd21lVWJvUUFJWFlxQzNrbVV4c2E0UkhESmh0UEN3ejFjSDdU?=
 =?utf-8?B?dUFsa3cxM2d5MTViVUNLUGg2ME1PNUtQY0ZwcXh4bXRRajM0bDYyTHpEVUtK?=
 =?utf-8?B?WE1CZVhtSk5pQ1RzVnBBNEsrWlozRy9LTUREZGc4cXJCeERLVEx4a0RUc0FX?=
 =?utf-8?B?NGwvKys4YUI5MmZGNW9BSkx1ZUI1R1dJUVBWSW5uMEZxcEZYd3NBQS9CdmFt?=
 =?utf-8?B?RGE1VERTQWZmTStKY2tvbDhlYmNWZG9tQzdSNjZKTGdiUG9sSXovbzRpMEU2?=
 =?utf-8?B?UXc0bHpteTlnMVQzTWNGNlpkSE5MekkzT0NWdTRsbUhUY1ZPWk1ja01keDZE?=
 =?utf-8?B?Z3FPWlhMSm04ajdTSWp1eVZ5dFh3UHNBeDk4QkdYWU9nMTZwN0Y0K2QzUnJJ?=
 =?utf-8?B?ZlVXY3NhZkdyNW9QOUdmSExMNGxKc1c1ZWVzeU54V0R4aHlUd2tQeXdPd3hy?=
 =?utf-8?B?MVZOSlNjTEJoaFdlSnRTZFVYQVpza1ROTWFwSnNxbXhjUHZqdG1iMEpmVFZp?=
 =?utf-8?B?QkZnZ3gweUF4QjBCb3JXNHBHNi9EQ1pYOVB4SU1LODYraTZnMDlycVUvRHVQ?=
 =?utf-8?B?VGkzRWh5N0NKN0tjUkZXMjVpK1BUUnpHRWpJeXlTWlJXUDRvQU9rbmt6ajZT?=
 =?utf-8?B?cHVFZkdMZjJQMmxrSWl6ZzVOMDVoSlU2MndVbDJ2YmxiWDRRblV4aWpWUmNy?=
 =?utf-8?B?R3BSU0dxVVhjMlVlOHlPWkhNN0hpT1pEdFQ1dzlvLzZLZ2RPTGdlUStvSHZP?=
 =?utf-8?B?cnhVN2tPYm9UbWVJdjhtODM5Tm9lZkMyUTZYaXBPVGxoVjFDbnRITEpqSGl5?=
 =?utf-8?B?Y29HN2V3SVJhdHE2MUZrMEdJV3J5VG9aanBHb2llOUI0ZUZRKzFoWnpiRmEr?=
 =?utf-8?B?SzZGM2ZSbXZNUmpIbVEzR2RzY1Z2a0xHOVdwQVdnUm1XbXZXdHdweXBxamRI?=
 =?utf-8?B?SnFiRjhrVEROS1ZSRjZxYmx0ZEJGc1VJTU5CTE9OTkRNNVl4MVJuNGdaODJQ?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b52ba3-d58d-4a14-b427-08de3086a4ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:06:38.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSVvmVARw4ECGNhg6dXDpdX81/IlZM1+rwEPZyBmeF3iDCQN8B77rUbeN/v+gBbi5BrrZjmazjkoe2NCiuuzcWq0xdWsbLVZX8kDabRyGTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> mkeficapsule tool will be built by default if EFI_LOADER is set due to
> commit b7a625b1ce49 ("tools: Build mkeficapsule tool by default if
> EFI_LOADER is set").
>
> This will cause compilation error on all our SoCFPGA devices, hence we will
> be disabling this config as we do not utilize this tool.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_cyclone5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index fef4cb90516..4a6f9b336cb 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -79,3 +79,4 @@ CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   # CONFIG_SPL_WDT is not set
>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

