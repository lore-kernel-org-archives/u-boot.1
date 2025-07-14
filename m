Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC387C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12C882AC4;
	Mon, 14 Jul 2025 14:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Szzj7mXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDAE82B07; Mon, 14 Jul 2025 14:26:02 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E738B805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb0P3mX77lReuHQ0YJCYvIfPlLZwY0Wy71FhuLPv6FsrZZC8FtbUzJ7D2c1mMnNs7dXNCkivKpWr4hEWwM5CIEjgZKkHrAcu3Q735rhdDWdz0Qr+0xJyvg+Z/YBD3cSzIBNOPLHkHDxA65XG1IcXzTU0FQZzXCG3q+rZlcK6ZeGDOnWLk/s2A024qAgrCad0ll2VDGuu5vZyGcjiuOjqmPlDh5mhHWHUn+ZKF2BtZPIweLnv6qi3aqyqmt/Gs3Ve8kutWZobn8/A4mwY4iQ6syLjO1nGmo6BizsgFWXeIrHwZF8vdQ+HgKfMs0mSBXE+STWI3fqYpI5ZJv0J9yWW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdzLb2sbU7/gB1nxI+YbFhOEfSdBzJej87uC4NutMAY=;
 b=yKOU2EgqPIhsZ/JNvtXAv2pLNYuJe6Gb8Kbkpr4zuCqkR6pft4ndiRvWD15QQCVJ7XIaWrRwY7+I3XS3rtPvsTMEkV22Jf3hP+5kdjZ5HFWGStglvx3vUix0AZO8ZfaPdiYdsPOAsV3ZAFUtgDlVPmwg+Y4zmTwrO+4sTS+P35dhKo6fwcrJ8mM+QD4FYn7VWWaz1TbgVup/+2vYDe05a30GG9mH4rlsnjBYNeVG6hsQ2Nx0fklZqfiHa3i+eIcWwfETG8fZS+DANQEQ1Rb6sD7Ei481Vxn8RXX8Pq5YQb+CZa+8axftWNXnVLhVRWD+EpBDN+8MXhVQQoROBWKMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdzLb2sbU7/gB1nxI+YbFhOEfSdBzJej87uC4NutMAY=;
 b=Szzj7mXcKnVhHXCbGp12o9g2UeqJw7U7M8JDMCDRlMkY+qg5GzyMiYjJhWs60xcGe1aAF//eaI4WtTeKKAmoUY0g5yc/7feGchFmFYG1yr95ukDnR0J/jN7nwlXPVhNJGwixaOfyp0zHMXsGjD5lL0yKysJA4TzBL1Qa5UMz2zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:25:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:25:56 +0000
Message-ID: <8d85b79f-ef92-450e-939d-9d8cb40da516@cherry.de>
Date: Mon, 14 Jul 2025 14:25:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c72047-9ed9-4029-9591-08ddc2d194ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3BMQkxzSEFrbjhyUldQR0tpa0M5aW1KR1FsMVY1ZHA0MW5Id2dlb1hjMkQz?=
 =?utf-8?B?RU0zQmNzdFpkYXh5YUlnbXJkbWVQN0RTT05LOENDQm9jZzIxNEVraG9leVR6?=
 =?utf-8?B?cGFtSFo3MDg1NmY2UmFld25sTVVsQm5JUStla3g3OGc1RDhFTlBsbmFGcE8v?=
 =?utf-8?B?LzlVa0I0a3VZTTBWYTBHMFFjS2JZNUlXTUFxc0UyV0tLZDV6dUdtV1kxUDN0?=
 =?utf-8?B?V1ZUNkUzdHdLQ0VWc0crRTIyTWVJMDNiaFpqQjZrMjJXRVFUWCtITTFqV0ZY?=
 =?utf-8?B?TkgwZFJMdlRXdTcxdWZHbXJQMEU5R25CNEF0TWdMYXlzcmQwTktwMUI2MTJz?=
 =?utf-8?B?Nm1MSFRFRlhrb1YwbEhVWDJBSDdkcTdBSjh6dTJRKytIa1pTeUlHL2F2MUgy?=
 =?utf-8?B?dytyVHZMNWNmb3F3Y1JXaHN4NUZlMEFwRXIrQTlNM3NxdWp2NEM0V1BqSHNz?=
 =?utf-8?B?bUFwbjc1ejkzTDFBeFJseGlNd1g1RXJHUnVNNGVtZ2ZidUFHVEpFU1ZTV1pF?=
 =?utf-8?B?MEozbWNzeXhvOVBtZmY4cmxXUm8ydC9SUHphRXl5cWY0RnNHM0lCUndVTHFV?=
 =?utf-8?B?SmNTcEd4aW9lbVJtN3QrMnp3VThSSjdaN3VYZEtVbWhFaDI3MDNwKzh3anZs?=
 =?utf-8?B?RU1Ick1lYnN1WmtjaFdDdXJjUG40bk9vYjFLWXZ0ZkhUZmpQZFNCWWk1NitG?=
 =?utf-8?B?R0pzSnVrWmxkbkJEdUNld1E3cEFrWW1JYjRHVmF6ZkVSREtzSEdTUGxHdW9H?=
 =?utf-8?B?QUwzSzMzVkttZU1FSXpkNnVFMWM5MzFLZlUwbUtvSkV1bnFneG83N1MvRkkr?=
 =?utf-8?B?WndTcDNOVzJ2UlpzUm40aWRlYVpPaGcxb2JseGJuNDVSelVNZ0FKUThENnNa?=
 =?utf-8?B?R0cxRmgvaDZpK1NrYVdsY1JneFdMMDdVcFhSQXJHN01PekFnbTV4OWNBMkZv?=
 =?utf-8?B?bUloSXpIMVZERzhOUXdkTm5yWWt4VW9ucittR1RybDZIYXJnQjNuVnZxU01E?=
 =?utf-8?B?YVFtNXhWbXRaSzJjUG5TdERUREtLOU9qV0xaR2hOY2wwb1JQZWhBcTB1bHNk?=
 =?utf-8?B?TFBybEVaQVFFTjdUR3NsM3hiZjZsaXY0cUZRZHVBd1JRYjlvUkVmK1ZxeWJr?=
 =?utf-8?B?VFBQcUhJUTJCT1g3RElIUFZKcTdnd25zZXJMZDVVVlpvTlJxa3Q3WW8vTU5t?=
 =?utf-8?B?c2s0eUhnZnFac2RNUWphTVhYaFkxMVg0bHV4d0NmQjRNUHIwN3IrekwrY2k5?=
 =?utf-8?B?Uyt1NS9Mb1Jqbjk1YUhuMkpIK2lEWVowbzRkVkgySG41eno4eGVSekMrcjIx?=
 =?utf-8?B?Q3JXZWl4UzU1TlpLRFpIcjJ6S3RMYldSZW5XQjRYNFgvZzVMOEF1a2MwazI5?=
 =?utf-8?B?RHc0UHUzUkhUVG9aem9IT2JTV2kvcGRXU0NlTzZuY3o3Tm12N3pYdEVHNGxs?=
 =?utf-8?B?aC8xZHVHelh1VzNNYkJlRmtCWW85cllEaVBJMlhsSE9IdDRWcWpmS3ZsKzk1?=
 =?utf-8?B?UnoxQ08wZEdNVU52ZG9nMG4xbWxjbzhUbHcyQjl4d3J3OHY4VElsd0FlcDlI?=
 =?utf-8?B?bHBuZ3dZZ0pTbDkrSzZ6czhBbmR6eE5EVTloemF2OXZna2U5MFB2bjNpcFl0?=
 =?utf-8?B?dE5IWm5ObktPeUU0THBRdmlMcFVKai9Bb2krb0FUeHk4L0o4WEtWNUlMclFI?=
 =?utf-8?B?aCtCQ1l5ell2RlZsNVY1SC9ZcEZ3dmZRNXVEODlob0hHcGZhVzUxMDJvYURW?=
 =?utf-8?B?dUpralVwZ2pOVFhBd0FFYnEwVS9HSlM1cUI3bytZRUVuQ3loTWZha29DMUJU?=
 =?utf-8?B?SFB0SXh2UXRhSEtUSkgvQ09RYWhTc1RHdVV3UWlIMnZxbDZ2dVVSWUlUOXdo?=
 =?utf-8?B?M1B2eFlObFpobGgvQzhnOHV0Z2FBY3FSYVVWQzZzLzgweGkwOWlGSkl4RHBx?=
 =?utf-8?Q?Pw2cS9vsSaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHh0ekx2SmdRS2NHYStMaWxjY0tEenN0UnA0SzlUUHZZTTB6aWdzcmtJZ1dL?=
 =?utf-8?B?YlZNSGVkT0ZoVzl4cDFDTTZKUFNiZStPWXk2akVVdWVoUW5BTnNzcVRwMDZS?=
 =?utf-8?B?bTJmRUxYZkFaZUVTZXFyYTU5OC9paXRwR010UU9sVUFjZ0puVCtLbzBlQ3d1?=
 =?utf-8?B?UkhXNkRrVTh4ZVJLcjExeUpWVVo1MG5MTzZLYmtjRGs2RlpIZjBCd2psMm13?=
 =?utf-8?B?dGpURVVJRGIzaUd1UURNVXdYVktVU0VZMmx2OXgzTHNwTnJ4TlFRSWdwbnF4?=
 =?utf-8?B?cFVneDc3clBGeXFqeFJvQzlzNlpqOE45aUlzeXkrOHVpYUVMU2RMRzIwK0M2?=
 =?utf-8?B?UXFBQ2J2Vjdkd2F2U1pvUG95bzV5eUVYRE1hVnhMYndxaUsrQmo5cndlTlJk?=
 =?utf-8?B?STRGakVrYm5KZ0JlbnVZSm9vYWZFY3BnV1BXVUxaTU5hRmdYMmtvSG9JWWpl?=
 =?utf-8?B?TFB4Q1VaZDdQNDhocmVNSThDNitRRFdYMkE0OGkzMldaNm9pZ3NOWExTdUlr?=
 =?utf-8?B?U292QVlNc1JvR0w3Z3RHN0NLWEplaTN0VThUUE9ibUhTeWtCLy8xYWZBcDFN?=
 =?utf-8?B?eE83MUVMMTNJeWxmN2tqTE55ZXZhaXV2RXB6WXlSblRLeEtMTnZFWG1mdHJP?=
 =?utf-8?B?VlpwaVV1TjR2R2xNMk9wVHFYUHVNMEtBbTkvbDZkQWcxSDd5cmdXK0FUeXJR?=
 =?utf-8?B?d0VMbW1XRFJYL0hVMGRUOVdBS3AzMm84UEt3S3VTMk1iNnBDajlObm8yalRQ?=
 =?utf-8?B?a3JEK3J4Y0xoWkpZbmdUdldqS0tXZ0o0YW1rcWV3NHVQVFl1c2RVRUIrcU5v?=
 =?utf-8?B?R3J3c2NlcGNDckZhNVQ3a2dSeDl4Z0pQMDA2NWxWWDBVS3N4aWJGb1gwRlEv?=
 =?utf-8?B?T1NBNk5JeUJyTFZKYXpkZE9JUDl1ZjZ3UXhGbFU4N3dZMEJRNEhNL01oU3pm?=
 =?utf-8?B?LytHWGp1YlZyK2JpR2QrUW0vRzhmdG9WNWw5N2ttVkpNUVd2MExZMlA0REVn?=
 =?utf-8?B?RUY0T1laeEgwK1ExVnpQdkNGdTNjSHhJNEFaVFJiU1FaSStzMHVMcm9GRGJV?=
 =?utf-8?B?dXhHb2ttTGQvZHJjQXRoUGUvY0kvRm9vNjZWV2NyT0hMMmRQTWRleGR4VUNu?=
 =?utf-8?B?VkNpWmdqUE93c2dOYWN1V1I2d0sxcW5QSGhkQy9FbkpGYUE5NlFBcTJXLzFR?=
 =?utf-8?B?N0hsOUIvQ1lZN0lmWURwcWRLdVpzZ2lkZ09CRkYrTmpwNUNuYnh6dm9ORkkx?=
 =?utf-8?B?TEhvR21LUlBsN3loOHdHZ1dDQ2oycjRiK1pHZElTYmJISkg5dTN0b0RkVWJN?=
 =?utf-8?B?QU1RdkErOEFGR0xacXAzbWdOUnFPNFRWa1JQZTFiZlFPeXVNckVwY2p6U01r?=
 =?utf-8?B?ZExIMWNuVTVZUzQrR3k4ejlrT0lQR2RFREY2VUMyZG1EZzRxYXRKMGRkYlJr?=
 =?utf-8?B?Z0E4bnZvSitxS0VDa3RZK0xhNXBtWG5BT1FadUxoYmNEV3dzcnAwUlNhWTFZ?=
 =?utf-8?B?eXZMZHBmaGZGZXp0SDdhZEdKbVgxOC9sSFNZN3U1TDZTNVJUTVlLdWhXc2tE?=
 =?utf-8?B?ODA2Q2E5RzNBT2o3YXVYVWNOOTR2akFvNGJ5Ym96NGwzcFVzYURmZHA0ZlVz?=
 =?utf-8?B?a2h5ajJOczc1TFFNeWRMSlQrVVJGMUJSdVRjbUUvUU4xa0hNdXRxZEJ3WVE2?=
 =?utf-8?B?RVh3WENCRDA1ZVpuVGxEaENpQXVUenUvcU1scVdaVm8yM01CSW0xd0JGaWlz?=
 =?utf-8?B?eWhEdks2eS94QUo3UjNLR0hiUmRDRmhFY1pidUU3ZkxxZEJXRzI1NHV4SlQ4?=
 =?utf-8?B?Z0tiNjJFWnMyRkJobTY4SXBTT2l3V0FVNEIrNWQ3d1JUdmZINTBna3dqM2U2?=
 =?utf-8?B?UjNFSDFKRUdRQ2xLOE9SZ0JqSmFRY1JLWDNUNGdQQkV0cXlmbzVPU08yRkFO?=
 =?utf-8?B?azVBTnBNaGY1K04vZlFXZVczYmJqSVhEQk1Cb284R1BIbFl1VXlrMFdRTFVU?=
 =?utf-8?B?YlQveVduL1JCaXVyQmI4NFZ6T1RPNi9uZTJ1NENJUUlEVng4U0dhazk2cGhj?=
 =?utf-8?B?T2k3T3FqUVF4dVZVaEY4U3Z2a1BQcVduVjk4YWljTVg3eGVjYlNzR3BqQXFj?=
 =?utf-8?B?Q2tuRXdRV25DZHpYR3VZTlVyc0NjaG1FNUJvVjhrZy9SMTllLzRQZjhkZVI0?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c72047-9ed9-4029-9591-08ddc2d194ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:25:55.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzAs50/+EtRiWGxOnLWCXG5c55ZxLOTVE+2MfWDdPIy2j9OBNG7KBFT4VIY6tdbiD8VQDx9EWRGXga8UDW9VbDC+S6WqCnbBIuDgO16h4dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607
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

Hi Andrew,

On 7/3/25 1:31 PM, Andrew Goodbody wrote:
> The for loop in se_desc uses i as the loop index and also to cause the
> loop to end if the passed in name is not found. However i is not
> incremented which could cause the loop to continue indefinitely and
> access out of bounds memory.
> Add an increment of i to ensure that the loop terminates correctly in
> the case where name is not found.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
