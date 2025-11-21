Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0273CFC283
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BD68393F;
	Fri, 21 Nov 2025 16:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UZcG2x3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFAE8394E; Fri, 21 Nov 2025 16:00:27 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82C18391B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj4xG4Pb41LDe/BYU4sTvraiFea1Cf/2142vSKnzv3Q9+qAEtn8/4JEuVp3JRIi0VkE2wFDJaiMf6HC9Q7hn5w3KOmYseAtECBy8cJ+Jtw/O7eLWWKWW/abaMOzjqyZ6dByFSNVavh3JFCYKwDtQsF4VE5zADdpu3KIMHNeXZ5vrmtMGIM1P1JVAi02Y2Ui8g2hNvtJeBHeB10uKY+3b0SWZoVsAGunEKjVya9n8Ge0Zu3H6gS0jjPJ9a5ViVD+BjOKRdh2nKPdFNdQgfjE/YVNQ6xFlwXyzIhokXj5/QL96OGtTQDCVtydx5I2G0mB2l/9bvgBhMjvUyr3TzWjBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPnaZK8vF3IhMjxs7ScgsVOvq+FyaV2CrtJHGpakVLg=;
 b=H+uIB7NIBgvBgVflFiCgJTlLSia9QuMAROslsE6f47F+Ih4jlSAjmMmJrHUgpbl4f65vZ2wRiM5epQ7mfxrGcm7J1dx/S7Ucff/Jsd6KeJM6v8mCNVeeROHmYuR/bZSCYUgvIlRMqzg9Dxwq6G2MIsi6mIkzVvN+QMm/mxFSlWOdFyYPUDR7KmOw/og9y2ZEOXxjw2tIJHLg4MKXKWgN6VKBRAajcKni8S9BfbVXgws3N6Obvg+GVXcM35V3kA7x6qlmw2iUGC3XoYX/fLj//3etB4GWtdh05A3k1q1vLUQBte3Dmfu4Q6owfAcghyUY9Y0UZsrZjea+jyFiq/R+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPnaZK8vF3IhMjxs7ScgsVOvq+FyaV2CrtJHGpakVLg=;
 b=UZcG2x3br8RiLM04S4yzOsPEtr5dbdJFQQ3+GEWj/XNMzJsbnfcFUDjluUIDb8rVi+dDjhXix5l4QIVBiaNKxonVxi30btl+s21mjq5mIctFNWvcz0zYogEYQjlsgvO1O1n6cj9zBye7NJGHNfqIUCHzktPwonkkxejmhFBHWp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7093.eurprd04.prod.outlook.com (2603:10a6:20b:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 15:00:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 15:00:21 +0000
Message-ID: <ffba9bbf-f03d-4006-b2b1-259b94181370@cherry.de>
Date: Fri, 21 Nov 2025 16:00:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/3] CI: use mirror for gnulib dependency of grub
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
 <20251121-gnu-mirror-v1-2-548e6cd2665e@cherry.de>
 <20251121142458.GS2125796@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251121142458.GS2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: f89aedad-4af2-4f38-156f-08de290eaf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFhTOUVwL2g3S1B4SVFERUQxc2l0RktRbE8vMW5PODYxVmt2anFTVC9zSHJR?=
 =?utf-8?B?bGF2Q1djalgwekd6elBTS1VmNG1DdThBNlhXdGZSdXU0NVBRaC9LVXFDK3VH?=
 =?utf-8?B?SytiTjBNamhHY1R5REIzcFNxV2JNeXV4bzFVaS9wK20zQ1hXaW5kWWNSWkdU?=
 =?utf-8?B?UGpSVDRzYkIxTWlIN0FMdldWRkJ0R3FBcWJIdzJjRVEyU0dJWStmanBhQ2pK?=
 =?utf-8?B?dWpNZG15d21YS0FhMjVDMFd1VWJUOVYrRDZTTGpncHNtUjgxNGE0UXBidHVY?=
 =?utf-8?B?SGNuR2RsSWp0aVFhVWZjNjkwbHNXM0VMeFJmc0FFUlNhZEpLclR0VnJseGdI?=
 =?utf-8?B?b1VyU0V3aisxbkpaTFVwU0M0YTNmcVlnUndxeERIQ3lNNlBsbkR5dmFTOU9Q?=
 =?utf-8?B?c1IvdDZwSHZZUnZxK1VOUS9nUEZhMXUyTTMycVlRY3pST29naUR2TGdScEN5?=
 =?utf-8?B?NFZhTnIyQkZWbS9sdllYWnhlcHcrdUhyd3dwK3lTZElBSXh5MlhwQ21UV091?=
 =?utf-8?B?YkhHYTVKN0pxYnp0c2dWOVo3UnJHVzUwV05aQjFqcERWOUdhanBhaDhGT0xZ?=
 =?utf-8?B?cFM1ZWdFN0pMdnBuWDJFL1d5Ry9qZHAwdlNrb3k0RjlpWFBZb0RKTi9OV0pW?=
 =?utf-8?B?VmlsZVNBV1RXcmx6UVpZSDlOR0dKYzdEb1ptcXFQaDZkaUxwVEprKzZFU2ww?=
 =?utf-8?B?K3EzUVB4RGFGaTlkZHRmMEJGV0VrdmgwKzNRZkdINTlNdHExSC82RjM1Skds?=
 =?utf-8?B?SkYwcnc1cG9HdVhRU1VZSlZ4emlNWEMvYXR3ZnZaaVN3R3Rtang3dEJKL1Nq?=
 =?utf-8?B?cVlGaDc4eHdlUVFOeWY5T0NUQkdiS3F6VzhWK092aEpjTjBDWWxDNzNqSjFq?=
 =?utf-8?B?Mkg4UmRUemJ6MFJORXhZVExaY2I5VWFFQlYxNUttbjFmc29mY3h4RGhOMmJp?=
 =?utf-8?B?RG45MVdHRmJaV0VNWm1BWnRNMkwrUHhoR3lrOEdYanFjZHJieTRabHhjRHdS?=
 =?utf-8?B?cmQ1Uk5JUkFJRXdKMU1WeDE1RXd4WHpuR2IxUXZFNTNXOXRXS3lVbng3OVc1?=
 =?utf-8?B?NDFXVjN3ekwwWllmSXRGcnJLaE5GZi9ZaGxYem5lelNGSEszU2wrRkdJemU0?=
 =?utf-8?B?R2Yzb1VuMjZUZDVMNkdlVUQwajhEN3hhWDFweklGREZIQ05KUHFaVjMwZ01O?=
 =?utf-8?B?QXJjSmlWaEFCNldiell1WERpQksrWXZ2QUtMaXBURUVmZld1VkNVK1g0c2Uy?=
 =?utf-8?B?Qkc2SlRPaE1FcHQrZy9vZ2YyeU9RRWg5a3ZJR3RKUURDUWcvUzAwRktxNGhu?=
 =?utf-8?B?ZU0va0lockdxYTJjQXRicUFMYXZsVkkwWTdxZ241Q3N2c3pYQ0J5Mm42Qklz?=
 =?utf-8?B?d2VvTno5TVlmVHFaaXJBK0d2ZU5MUU1nUzBXMGhEdWFJVmlyTkY4U2xzWlNa?=
 =?utf-8?B?NkJNYXE0dWJ4aVIybEFRaFNGdmtkRXpwM3FaZW5oWnpUMy85RTVhajZNV3Zw?=
 =?utf-8?B?TVNEWXEvdlFBa3NJb1MwaUk5N05mOG9yL280YkoxUVZkTjRXM0Z5UHNpU1ZZ?=
 =?utf-8?B?aGhNdzlreWd5T0RlZHRhVlpqQkVLVXY2SWJBWWNCZUtDWkJMdXlZL0dCdVZl?=
 =?utf-8?B?VEtFWmxyMVg1NEIvRE5QS1MvWENQanFMaHBrQTlCbjNDelBFNmF3T2Vnc1pT?=
 =?utf-8?B?V01SNjR2cGhyek8vbjF5SHFwZ2JiZFUzQW11SU1zRHFvTS9yWjNlWVdRaFZ1?=
 =?utf-8?B?dU9wNkxUQ1JqUDJRYTFCMlRZNmloaHFqV0M2VnMzT2U3M0E3UXJObmtCRnk1?=
 =?utf-8?B?WnNud2FiOHZVRXdhRzIwUVVOUzVLNTlUNTBrOCtOSGxYS25ZSU16aEdORERR?=
 =?utf-8?B?SmljVnFZQmNQbUFOWWtrTmJ1T3F2VWtPUiszcEU5c0RGU0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGM1UmFXNGRiTHEwQ2NrOUlSRHNyTTB2K2J6VjRqbGVaZDBRUHlzeTNTMTFK?=
 =?utf-8?B?NkppQ3c5U0c3aGFkQ0pEeWJySEZIbUhveG96VFF1RlJnZzgvMFpPc3FtWlBI?=
 =?utf-8?B?aVlZMUt5QThoLzNzc0dxNjZZYUtjTU05S2gxQW1Nd1ROLy9uaHg3N2lUMmpY?=
 =?utf-8?B?MWp5cWw2TUlWZDZ2eEFLTnpiZnlybkpoNnpTU1VrVEhCWkxGQ0JCZWhiTnlq?=
 =?utf-8?B?YXYzdVpud2Z3aUVkQUNlL1BhcGFoUUhjM2lTb2Ric0k3aThZZkJUU3lKVG5C?=
 =?utf-8?B?ZFBvTnlNZ2ZzSlFlZGV6V3J1ejRnYlRDcElvWm0yVkczQlI1TDdqbU1ReVg4?=
 =?utf-8?B?VStzTlBPR0svTnMyTVExdXVEUGlURDVrbytyTjJ4SVlwaXZaa1o5YUk4cEkx?=
 =?utf-8?B?N3ZsblNsMjhZdWtMbHRlNVFYc3JTRGlQK3ArTGdQdjFQanA5MTkvVUx6bVhU?=
 =?utf-8?B?Q1RoMTFyZmhXaVR1TVBGVURWRW01dzlCVmg5NmxvQS9GdU5CTUJWdklEU0xv?=
 =?utf-8?B?Z0RMazNJdkxIQUF5TTRuc08zdDVWVERWMWpNcWdKckViakJmYm5PY0dMMVp5?=
 =?utf-8?B?VlhTZnNCMFdnckk2WnZ0RzdtQi9HUi82eUxoUEJGb0J3NzU3dzZZZ0lPbVpF?=
 =?utf-8?B?OTRhcVpOMDFGRkdkMXVVampGRkN4OHdnY203Uzh0YlJuYWtJdDQzYUFHak9o?=
 =?utf-8?B?RG9Xb0pmbFRvQXVCbzgrU1JTZm9hS1lyNXBqTUhsVVdTWDNLUlA2SkpXYUJo?=
 =?utf-8?B?OHJDWW5IeDVxcytzdWNhMTJkVUZPbmF6RXcwUkZoTVNPZTNiTlliWTk4cVcv?=
 =?utf-8?B?NVVzZzQyWStuOTNmSkk3VnQ1RE5XNEZwK3BRREp2VTNjaVJPV1lad0lpZ0dL?=
 =?utf-8?B?R0lXT3ZVNGlyT1ZlNlBOOXlJL2pqcUoyTjlOQ3gvaVAxWFRpRkdCYmxuK2Iw?=
 =?utf-8?B?ZEEreFFRME9UQWJHZDRUY1JBMzhUNnpyZDJGeDQyeEU4TlpBNTFlWklPU0tv?=
 =?utf-8?B?cnduNGlCdGhxZWpCRXRCNExsYkVhRE45M0ZJTlBjN3VNV2tacHo0dE9aWk5Y?=
 =?utf-8?B?Zmdod1pyMnN3ZmpnQllCWjNRM3dJc2g0Zmx2KzB1VXNqRHJJblhId2pBZFg5?=
 =?utf-8?B?djhwVFZKallVaFd6bDhkVEVYeVFhNjl5Rjl2blpXanJ0TnhIR3M0MHBYMEQ3?=
 =?utf-8?B?enJXc3hZZFdiclRtd2g0RkJYM2g3OUlqNllhdXRoZnF5UlBTZjZwbTJpbXhU?=
 =?utf-8?B?VHkxSUt4SUpvODNYVVd1R0NmcmtIME9LYjhGaDF6T1J1aCt2L0tEbUgvSlcr?=
 =?utf-8?B?dW5ZUUpqdm1BWndNYndkY2U3c3doTGFZZ0w0Q0VvbVlMMXgzTzR4T2g2cGhX?=
 =?utf-8?B?eWh4ZXZZR25hN0d0RGhWRHFJWE1HdUM2ZThRMzJKL0ZOamVjbWRWN0dIbE94?=
 =?utf-8?B?NlNSSjVJN3BsVGR4dkdCZDBST29ON0dDZllOWDMvbVpPblJlR1puSWkrMmhT?=
 =?utf-8?B?R1dZblZTOVV4WE11ZnEwdTRjdE5idnV1d0JjZEtkVmxYdHg4ZExNTDNyRE40?=
 =?utf-8?B?eExQdDhjOXpsQ0lSQVJvcnlFOFVyRFp4aHdTMUtCbVh2K0N1YU4yQ1JTenNy?=
 =?utf-8?B?YXptR1ZDM3NrT0FITXdjTXVtMHhXVGJHc2pXd2FRa2UvcUxDaGNEZUJ4aXNY?=
 =?utf-8?B?TFNnemxVN3pLOWkzWklyTnBzcWVBVHJOUDJORmdsTk5vM3FjV2VTalhLUEpi?=
 =?utf-8?B?R283MVRRM0dmWTM4aVZaUjZiWVpKemdMT1Z2ZUxyUExvV2dVby9lODhuTFA1?=
 =?utf-8?B?WWZGd3dxMFRwVkZVSXNCbGtjNkVzT0N1YTNEdmtSSHVZRW1tN29ieTAzVDAz?=
 =?utf-8?B?VjdlQkRiSDFXYUFJUFl5NlVSakhFbGQyTzVINnNsWDhua1NhWGVkdkhuaElz?=
 =?utf-8?B?K2MwNmdmVWNpZVBlbVQ0SXJ0QVp4U0RNaFd0ckVaVUEwQmVoWTA3MzA5WnBP?=
 =?utf-8?B?emh2WTRLMVZ1UjVhcmNFdnVKNmJSTzVqWVk3NFJjQ2ZBTk5pUkk1MnBERFhv?=
 =?utf-8?B?bzJSRVdicHphRTJzRFFsajJjb2VmWVJOVmprTWljcXVETVJqQVJzVDN3MnFT?=
 =?utf-8?B?R0llZGRxSkRyaG9UeElOQSs4Q0E2a2crQk9JWGJVOVZaR2p4UFV0eEdQSDRP?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f89aedad-4af2-4f38-156f-08de290eaf93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:00:21.7832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ47SmXuGsXPhY7WkhrcxFJ7HqRSklYN/5yXxY6PSaeFwAkKMnrUmW85IBjhqoaHBqeT+Tz5cP92kT3OC9avxdmjGOvOxZ6GcN3+XtuKQsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093
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

Hi Tom,

On 11/21/25 3:24 PM, Tom Rini wrote:
> On Fri, Nov 21, 2025 at 02:22:15PM +0100, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> grub bootstrap script downloads gnulib from a non-mirror URL and thus is
>> unreliable.
>>
>> Instead, manually clone the gnulib repo from a mirror URL and pass that
>> repo to the bootstrap script via --gnulib-srcdir.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/docker/Dockerfile | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>> index 34713c5e8b2..85274c303c8 100644
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -148,12 +148,13 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>>   	zip
>>   
>>   # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
>> -RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
>> +RUN git clone https://https.git.savannah.gnu.org/git/gnulib.git /tmp/gnulib && \
>> +	git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
> 
> Right now, the next branch is in a funny spot. Post -rc2 I applied to
> master some changes to make CI more reliable which also meant that right
> here we do git clone --depth=1 -b TAG. And doing --depth=1 -b TAG is
> something we should be doing here for gnulib as well. Since -rc3 is this

No, I'm not sure this is something we can do.

AFAICT (haven't dug too much), grub will checkout a specific commit of 
gnulib, and that isn't supported by git clone, c.f. 
https://elixir.bootlin.com/grub/grub-2.12/source/bootstrap.conf#L19

This commit sadly isn't a tagged commit in gnulib (there aren't too many 
tags in this repo...).

However, I think I took the hammer approach to this, I believe setting 
GNULIB_URL variable to the mirror URL might be enough.

grub bootstrap script does something to avoid downloading the whole 
thing, c.f. https://elixir.bootlin.com/grub/grub-2.12/source/bootstrap#L769

I'll try something out and send a v2 if that works.

> coming Monday and merge to next shortly after, can you do that and
> rebase on top then please? Thanks!
> 

Sure, I only need this to be able to test adding one package to the list 
installed by apt (5 hours to add one package... that's a new low in term 
of efficiency for me :) ).

Cheers,
Quentin
