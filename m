Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EFDC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AEC8212B;
	Mon,  2 Jun 2025 14:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hyPV3TnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF2482145; Mon,  2 Jun 2025 14:28:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF123803DF
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Goh7U4lJ/79Pz3OxQaXz4Se8i2gptZ++v0tXFZHp6dU82A75JMYn4AdRXIr9Nhjm04K6OMvrEa56y7F8S9IYmwaSGO44goidw42csey0ATzOg8LeCzKtZVpdRZ36jTV+pmL+kEIu8vQTYp444+EQd+22pCnoimWqNqis8Gci0CTc1BVR2SIqtqQqV21pxBDeIB3EfPE97Jr/rHczGvdNLoxDl/XZGqzOPMoFeVQPwOdQvAdqnSmjy/B9S1I4j0eQ0EaWKq1wU7ePa6WfPyJdUS9mnNtc0vJj+RFBv6oIEUZW3rmiK2wgQf80izJsSv5ww88mx0Sq0rJPULKfDWzs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnyQdPw2mSBN+hYzG5Gl63rkepGG1cYVbx4Y5v3q988=;
 b=PbqjnKHEP7f98x7qDS+LlX346cEj4jx0OLt1GZSk+22SZDRB92WeOZZFfkjAePozaeOrapnOXXxngZ8k5rL4n6ja3oWetmfItZyr4kw7lkhjNh8gqy43+0UUYCE3pqL+w2bQ02NTGFzGEfAIiqPkOgz38tdlS0HaAnlILkdpRzqPhBipVY+QhKNF3vii4bV6rRF8FemEqT/+fJYK6yiXYmmdqxFo5TIIEvDPSFQm8LwwsVANG+Q1hBnziyDWU/8kvWdE8HDFpiOJ8Eji7sTS7jlGA1of6br+prcXM/akeyQcUuAH7mwESM/k/2R9+S9eVNDXVce5ymnlXsqgcyouSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnyQdPw2mSBN+hYzG5Gl63rkepGG1cYVbx4Y5v3q988=;
 b=hyPV3TnAFQSlogyRocpjKyWX/jUnE7kEywYUZjVtsyLLm8EoWNeYBnkVTHlZHixIglyXCjYSWguo7tdfYpVh1CktTXd/TS+qpNIsfBqbzWHart7qXbnODZpENd7DkJ/KXXNN6PzDoOC+uFr4PUvuYKe+IdisUYqNf+LnmYp0a8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 12:28:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 12:28:28 +0000
Message-ID: <0e90f488-6263-4374-b1cd-df225abaa2c4@cherry.de>
Date: Mon, 2 Jun 2025 14:28:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: Move Kconfig options into their own menu entry
To: Yao Zi <ziyao@disroot.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250602101515.37384-1-ziyao@disroot.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250602101515.37384-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::35) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 09960e55-bc93-4c3c-d7e8-08dda1d0fa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9LVHFFTC9yWmMyeHRKdnMrTStVVENaRlhaMzJleU94UXlzOWl4bElFbTJK?=
 =?utf-8?B?NXlOVVBDK084RGFxV2dIVDZ6L1U1TGpLUyt4SENRREFkNEs0L3NYRjVnMjFv?=
 =?utf-8?B?VElZRWdvR1FtRVo0TzQ0dEhsVXJWMWVoZmlVRC9ZbW1rMVFLSmx1MnpEdUJy?=
 =?utf-8?B?dVhkQzFTY1J2Zjk2NXd5b3dDbVBoOHVIWTF2U29CNGhITk02MENId2RudmdK?=
 =?utf-8?B?bVNsaXVxdHYvOHdaekFmbnNkckxma0IyNzZ6Rjk1ZkJpemR4V1VnSUlRYVVE?=
 =?utf-8?B?VmEzNkF0YkMvSk5OeTBXNzFvQUZnelNwazBzRldYRWt6NmdQVDdON1VwU3ZI?=
 =?utf-8?B?NmlFMlNUa2VmdkNHWGhHaFZoc2xpeDlSclAyQ3VaeURWMEtTRmlMWitYMDJw?=
 =?utf-8?B?Z3NYeFdzOVRBSnFNTkh3UkMrN2p1MU5xOFRNcmgvZXdVVEN0UUFweWlpS0pi?=
 =?utf-8?B?VUk3dWRDWHNObUlJOE13ZGZQTWkrL09SUER5RGxuSVNhNDV6Q2wzNkRmVUsv?=
 =?utf-8?B?RGxJU0FHcTRqa09pd2tCcUJHQkJPY2NQSFY1cEg1aFI3WmQ5YTJGUjdCd25a?=
 =?utf-8?B?d3hjR0xwL0toelZPS2wwYXkva0lWTzBuaUZiajF3MUlwNVlkTE15UlI0akJI?=
 =?utf-8?B?RFBHMUJodkROZkExNkcwVmRjQU5oejFsQ3RlWERsSitEMFFtMnBqUE9QSGVW?=
 =?utf-8?B?MlVXcW82dHpsS2ttUVZiK1ZaYnM3RWJDUFhtN3kzS3Y4MFdxQ2VBUGJhQjRL?=
 =?utf-8?B?RDM2L0dQWnRVM0pHREErMUsxYVY2eWdGVW80SHByNTc5NGJMRmNIQXg4YU1P?=
 =?utf-8?B?a0FyWDVSTmRsV1NYN2tNM1U2cDVlZlVYZXFpOEtEZDNkNEVWSlpBOUNmMTAx?=
 =?utf-8?B?UjBkbW55QnQzYjBJTUl4aW4vbXVYQ3FKbURnMUM1Y2tTMDVtWU9lRWxmUlUv?=
 =?utf-8?B?a21yOWFkZEVQbjNnd2xzN1AzZjRTVDFhSm9rTWxXVXUwNDZDdDlDSGJEQ1Rv?=
 =?utf-8?B?TU12M21JcW1EaGVwMFJkRlBxRGZwZzVYOXcwTTNFMkEzaW9zNER4QlcrU1dU?=
 =?utf-8?B?VVl0WVJlaXl5TWM3L0lqakNqNHdQUk9hS2RmNWo5L0VZUHhpOFRiK01OZ2xB?=
 =?utf-8?B?L3YrYXp1Q3BzUlByYlI1VVZlZTFTUjJNU0drMDhObWxRWTNDTTFRUFIrWGVQ?=
 =?utf-8?B?TWRUeHFhSGVKNkVWZXdSOTBrbmNXaCtDeVE5VThxcDV1cnFxTXBEdVNpRnl5?=
 =?utf-8?B?cHFNRkdmcE9PQ0YzcEpFSW9wM0Z4Yk85bDFRQWc0SU1XOW9jcFptOG53ZFQ1?=
 =?utf-8?B?aVRwck93RUlFOUNDNHBqOU0xTlpYZlRkZmo3alZob0xQZk9iaEpMS0Zxa1dO?=
 =?utf-8?B?WDljVCtiKzN2NjZHcGpxdlNDekdReGkvOTZkZHFqZGIwcVE3QzB0WlhLRGVZ?=
 =?utf-8?B?WFBBQ1pJNDlHaGM4REFOUDVFNkhEdDZuYlRyS0t4N0JwMWFtWGZKMVgyT0s1?=
 =?utf-8?B?SHZ5UHpuT29CdlFqWlVhSmZuQ2xvVHVWVUk0bjhsNzlpaGJmREphT3NsKzJu?=
 =?utf-8?B?dndOM2JsN1RBNGxLWmlCTTN0bGk5RlA3RGZ4My9KZ1FEY2dqakxiNWtxaTVP?=
 =?utf-8?B?d0p6dHlXdFJzeDZMaDQ1NEd3T0tiNk9NT0I0ay9EUDYzMnZsZkFxSHc0OXlG?=
 =?utf-8?B?dWJYRmNSek1BUmVTRDRjMzY4QzllcFAwUjBreDF4c1o5LzJTUiswUlhLS1F2?=
 =?utf-8?B?TWpESk1rclVySERNN1ZkZFJQaC9reEV5VkNuVGtUS1YwVVgxeDZlSEhmWDhO?=
 =?utf-8?B?SkUrQWc4ZDBJZDBlOVJMZTcyU2dMZ0hPdnNkWWZFV0tJQVZnU2hOZVo5VFhk?=
 =?utf-8?B?b25ObTZsd0hoZjZ4NXM1YTg2N2gzdDgxc2MyeDdBUG9OMkllcmhBTllEaENv?=
 =?utf-8?Q?JzK7NmkoFFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtNRElYS1JkNktBNHZ1aEQvSy84RDVxUHhlYUt4MTRaRXlxUU92T1dMbUR3?=
 =?utf-8?B?dHFDbzQ2T3JoTW5EMUZKR3Baay9rOXI2TEdud2JISWl1ZEZ6Y2RQNVNKQnE3?=
 =?utf-8?B?Zi8vVG9aVTR4M0NDK05JZjlmVHZ6WTZFZ1FkRUwzeXc3QzljVEhoNEs2MkRC?=
 =?utf-8?B?OG5SQ3JiMFR0LzlYR3BCaGVXVDVzdWVqS0xzVTE4TVFBRUU2WGk2MlRBS0tv?=
 =?utf-8?B?bVJibDBPSXhWZ3ZJSStTR04zU3NlWUZrUm12YzdaSDJ4T1VOV1NOclFCUXcv?=
 =?utf-8?B?T1pCcFFvQ3daMWdYb29sSUR1azREQnVzYnVnRXZrT0VvWkVzWEtlRWQyaWNt?=
 =?utf-8?B?UGVpRERPQjcwSGk5dlNNZFZ2TVRCY0Z6Vm0ydUxZcWtUSzltTjcwT3dkWkgy?=
 =?utf-8?B?Z3J3YXhCM3BWTjhORkhLaFd4M090dEZRYkVzelZ4MzF2YnZNTUZsdnJZbml5?=
 =?utf-8?B?NW1sclVGUXN2cC9SczZDenNGVS9hdDRsRi8zRzJrTmdUMzRqbEhodjNPQUI2?=
 =?utf-8?B?Z01QWXFOREkreTRGTUZhWWhpbTFtNXljaUJ5YlRmZ09TRWV0TG8xajZrWExt?=
 =?utf-8?B?UGxhdGc5NWRmRTlZZGJ2QVBoQlZGY21HUWZmbG50aEVUR3duOUE3cWtxNWs3?=
 =?utf-8?B?Rm5xV3MxUk1tOHV5TFhFcDZHYzZqcWMwQ25lWGpqU1N4dElNdVg0blBBTmdu?=
 =?utf-8?B?R2lFdXl4cDc3b05ZSjZqYTM0eUFId2g4VnBTZllBRksxWDRwcVZ3SndZNERZ?=
 =?utf-8?B?TFdjSThUZ29UWFJXQUc0THRQMXpURVNuRHJ0L1U2SnEyalRnSFBiQ3BETVhY?=
 =?utf-8?B?dVY5eWI3dy8yUDBKWHdLQmRoNFZ1VkFvclBRYkRQNlV5WUtweGNnMkZ2c0Jo?=
 =?utf-8?B?UFZ5ZXBhb3F0ckc1Qi81Nmh6RjFIMGlWdEY4dXhLdCsrZ0dKUUJTeHV5amF0?=
 =?utf-8?B?RnU5WFdvL2NEUHpScE03dk1MSmxmV2ZheFJUOWNQOW9xblFkdG9hTTVOWE1R?=
 =?utf-8?B?YlJ1RDhIWVNYbXp6U0VrUDZMc3laSUFsZW1NdGhIakVZSExyT1dENy8zT0pm?=
 =?utf-8?B?QlY0YUplQlhxNW02UDZ4bHJIeEo2T3hRTTNqTzhpalpFZ3V3eDBvZUpOOUVR?=
 =?utf-8?B?T1VuSyttVDVxN3FrcEJ2YWdlc2liYjErMFR5K2pYNmw5S1hYUDRuenFIL2VM?=
 =?utf-8?B?LzZRU1U1Ty9rcjZBUGJWMUxhUjZsK2pFbDM2Y2w0RmFkZGVyVFBCQWpsM2w4?=
 =?utf-8?B?VXBleU13UzV5SGlzNGlEMm5jRTc3RmxxSnd5d3VjandFNW0vOUVsaDBnaXp1?=
 =?utf-8?B?b0NwSnl1UE1la3U4OC90NHB5UGZ6bVlZT0hkc0F6NThUcTJrVm1LL2xTT056?=
 =?utf-8?B?UG9DajNMcjQyNU94VHNaUTM3dzk1dFNWeGVVaWVNZ0VuMGNBa3I3b3RTbitU?=
 =?utf-8?B?VDNDNlpaR2VWbVJYZU1NbmpVYXN6TUtBNVRVT29NUUtyKzFxVVh2MlBEVEIz?=
 =?utf-8?B?UHBsRUVuM1NzQmFEVjJJTnd3SG80L3pYZDIrV1dvZTBSL3VKbHJRTUVMcUl6?=
 =?utf-8?B?RGNxMDN3aG9nM2tHN0NlczY0dGRzcnZTWkNBWVFJU1RTSGYwRG9XL0Uzajdq?=
 =?utf-8?B?UXBwMGtPUnNjSHBiTmhLdVYwUkFDa0R6aGtBK1NNZjZOSHBRWDl2bnluVVBx?=
 =?utf-8?B?dXA0dUpIdjVIaU5HV0VGalBnditZVU5xczNhRWtuOGw5ekN5UDRHSTFYTmNw?=
 =?utf-8?B?aW00a1E5UFRSZW5JdmVCQkViV2ZyQXJqQ01KQlZTS1FsU25VVTBoVmRHK09J?=
 =?utf-8?B?ZzFXOUUzNUp2NDkrSjRNTGxlZnRpZi9NSm1HMUlNNk1GaVl3U2VyeSsvQ0Fz?=
 =?utf-8?B?ZzllNEhwVm4rNmRLZXpDVVBSOEJ3MUJxd21FU3pmcDkrQ2hqb2JFbEhTV2g5?=
 =?utf-8?B?MnpkMmtZS0pKQUFQVjNPeTdPVTNRTDFHV0wrUWFZVFJ6T1pYS3cvR3ArUDBp?=
 =?utf-8?B?RE9SaG5ydjQvU200ZU5KV0x1MDc5V0dMRFZaNzFhN0NCSUJkaHlhejk1bm96?=
 =?utf-8?B?cDY1R3RaMTlUNjBaS3FNN1FmenZJbXpuQ3RyVHhtaFNOWWQyYkRNMUZIaG5Q?=
 =?utf-8?B?cFFWWGJiOXh0c3l6ZEhvdDJoeERlN0xPQTljUHZtOEYrZ054bHNLVC85OGx4?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09960e55-bc93-4c3c-d7e8-08dda1d0fa26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:28:27.9826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTyhJiAB9xL1Wt2XRWzxLcZmxbQhdQFW6GwLxCdICNHcd3xkZlIZUNHTexCUp2s0WDGpf690y1N6KEEEih1e8nB3+A1F0Cpj5oFrN+bRG4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726
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

Hi Yao Zi,

On 6/2/25 12:15 PM, Yao Zi wrote:
> RAM drivers using Device Model currently lack of their own Kconfig menu
> entry, which makes Kconfig put all options of the class in the top-level
> menu of device drivers. These options are also incorrectly grouped with
> pinctrl options in the generated .config, which is hard to read. Let's
> create a menu entry for these drivers.
> 
> Fixes: 6c51df6859f ("dm: Add support for RAM drivers")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
>   drivers/ram/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index 39d03e8d3d3..edb8e254d5b 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -1,3 +1,5 @@
> +menu "RAM drivers using Driver Model"
> +

Considering SPL_RAM, TPL_RAM and VPL_RAM all depend on RAM, you could 
also go the same route as AXI and have:

menuconfig RAM

>   	bool "Enable RAM drivers using Driver Model"
>   	depends on DM

[...]

if RAM

> @@ -136,3 +138,5 @@ source "drivers/ram/stm32mp1/Kconfig"
>   source "drivers/ram/starfive/Kconfig"
>   source "drivers/ram/sunxi/Kconfig"
>   source "drivers/ram/thead/Kconfig"

endif

Up to you :)

Cheers,
Quentin
