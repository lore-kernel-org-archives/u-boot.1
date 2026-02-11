Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8511BEB5967
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 06:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02C783A47;
	Wed, 11 Feb 2026 07:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PdhsgR3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D5D83D6C; Wed, 11 Feb 2026 07:25:10 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9889B82BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrRijrciI6S6p2fWhl0U7eMNELfGoFOR79TPsnOqvjMH7iJzFDC20+kPWdoFFrMZY6+CUTzIsNUTRznTJig4+FPE4wNA0ZsDi3ceuE04411nEDXis3O0G5QUUc/ymToCjEd57GPlw/4IU/r7cYThKLE+eXu0PD0sqSO/rHvjB46dalzoqV0L23PGf/+lMKIzmrY8MiA3T0oV0X9uWLi5NXG1duH3fi8+rGqPEm5sb+IAZOrVcQ7tdHMXoZh21kYp6jtxRNapIGSAbtkyEDMrPzTSb4VvPQ2HV6tgSgtW9n5OF65Ut/UzjuRAuPn6BltpJX6SHdhXsR9QAiIos1GtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oYbTtjhts6qlbEmX2WISKx5tC8+sHLdol1bb/O6muA=;
 b=rhWiucPg2iXiPw7PhwEfzEgM9w/nuLaHc5kRRAk66T3i4MaPJrwjyHup7CjjeYhITJCDeHUt4zGhbGGkkQ8e1d9yFNyehZpGuFrveIe7W9tfuvhdYH+1BA6SV+JJ4WqGaZGEa6Df2/5k3O5ifXEAD7S4W0VhcwZngV4oAzG3cir9uEmaLKHGzg7+65STlPWJUQnfDHj3gPob7ALATCrP7BTvvkNiPOlwt8WogzU0tyxpTVyZ4eEMstRxZ8x32KUvMJm+qyqS5IKOGIxCM8pc8UmBE5MUmCY4ZKqV98QOTftb3Z6eQ/7/PZ55xhPdJCBf9JXqSmopQ/FUf0sR98/c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oYbTtjhts6qlbEmX2WISKx5tC8+sHLdol1bb/O6muA=;
 b=PdhsgR3wTTTRkSISoCGbG+j6exn4RGps7iCRxRRNhlhrrRx42UNxgBEE5EXfTDOEzl1Ytwa9xiQxEwAzsWJCx9JltupiX+FpAFf6GQ9upA9k0HCR5HwzcadiMCVtXoIjtFp3YY3b8VUhoFgm9zxNhZk4cH8SDMjExDfF3FbXZWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 06:25:04 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 06:25:03 +0000
Message-ID: <df29bb83-9b4c-44ed-bd93-667636486a41@amd.com>
Date: Wed, 11 Feb 2026 07:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, dlechner@baylibre.com
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::8) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 73145df0-ad2f-4b0c-5342-08de69364a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnRvZjF0d0tNUmR0OGFaM1N3MXNRbVlDSHRTMkNvYkdwTXBQd1dSbThJZEgy?=
 =?utf-8?B?WWJUV2M5SkkvNXU3YXdIbUJqR2x4dWRGL2NLa1FkUXNQL1Y5TmxBTEI3bWZN?=
 =?utf-8?B?cnorZU5iWlFZTGZzK2hpa0JsenNENkR0L0xvRVJxbGlCQnBjVGYrbkFwYjVY?=
 =?utf-8?B?UWR5ODRCdEZ4WHpwOStIZmFnZkxrcHZHblNERzBKb2Q5UldHc2FJYkVueVNG?=
 =?utf-8?B?b0doWnQwcjNNbHAzNlVybUx1dmtFT3lkNkRsT05pcWxtcGJ4cnBobkFMbWs4?=
 =?utf-8?B?Q2FkWThGR1c0Y2NhN1NpbVNvbnQvRTVaTS8wRjdrejhSVldJWllVWVRYUDNm?=
 =?utf-8?B?RFBUUm5iUTV1NyszSE9VS2VyNFV0RmxMcFp0Y3FYdW9YUXg3anFCdlRsNDVz?=
 =?utf-8?B?d2ZBZVZZZXlwcDBuNy81SW9GQWQwZUJaeU5HRVZEVHRGcnA5eUwwQTNBL2xi?=
 =?utf-8?B?aFl3QVdtVkFsVzltSUVsY0hONlV4S3BUaXJZVjM1aXpkY2p2aWtvdk5KS1A5?=
 =?utf-8?B?NU1YY29DMHFBNUdGYVNrWnVNZUdidEl3aHA5NEpkUEtqditxVGhHSmlLUHE3?=
 =?utf-8?B?dDBHN0dTZHpjbUVuOG5sKzVCaHROUTBPNXBmMFNSeFVYeDZub0ZVVWhXdWlt?=
 =?utf-8?B?ejlKWVZaMytybmtQSzlaVUJuN3FKcUY4TTJJUWpGMFJrUWpBMDZLcUlWUGFX?=
 =?utf-8?B?Yy83enIreGZBa3pEOU1pUHEzU2MyMmx3QkpIY2dmcXUvU25nN2hxREpDb1JY?=
 =?utf-8?B?YWE2ZnErUnVXK2RLMUVvMGszaDh3YlR3cVJydURYdU82aWNaODYwdjl0Y2lC?=
 =?utf-8?B?eUpWakFSNm9xZUxsK1BKQnZoa3RyM3FJM2RSdWJOVHYwOXY2VGNQamxIQm1K?=
 =?utf-8?B?VGdoU01UQlpFUHIyYlZGb2lTZVJYNlNPeFcvK2Q1cVVDeFhoZDZWb0p1MnZD?=
 =?utf-8?B?OFhSb0k2bnorcEpYQlF5a0JuckhGN2ZzUS90dmNsSEp1bWxDaHlwYmtzajN5?=
 =?utf-8?B?UytkQzYzSUxibUFiOXRnWmJVbFluN29SaElwQXMybm1ESEdwNzBJd1IwUHR3?=
 =?utf-8?B?dVY0SUVtTk9qSmlMeXI1aTFJUUM0blVablhqNjRQTHR6aXpWU25VUTRvR3Na?=
 =?utf-8?B?cEpoUURhUTBOL2xIVEdERzBRSXFCd0wrVXFwM3FQaWxXeWx0SWRINW5CSVRS?=
 =?utf-8?B?dU13R0U4U1RCVGVMVnQ3dURSVXRVTVoxNEhPK2I0bUhQZHRuNERKQzhSWUd6?=
 =?utf-8?B?T3ozM1VadmF4VjRjVjFlZXRob1k1MjBnWmRmb2diSjloRFp4YjZOT1hWWENV?=
 =?utf-8?B?ZVRsTUk3eU5zUldqQTJENlU2dVBNMGM2TEFsMjVJZm92L2VtaWpkSXB1TzVr?=
 =?utf-8?B?aEl3VmxFM3RqenFlWDR4ZW14U043VHg5eDhqODR0S29tWHJMU3N6emE2Vzdh?=
 =?utf-8?B?Zkx6bHFuMGdZWTFGRmpONDc0UXJVclVUN3Z0YlZrcFFhaEZTbTZZNEpEMTZ1?=
 =?utf-8?B?OTRNWjJ3dXVhb2NUVmhHY1RXekFNbUg0TUtDaW01dW9VbVpMeE1tMGFVa1lZ?=
 =?utf-8?B?VG4yMitNS3NyTVlwRlJZcEJjNy9UYXh1Wi9wNTk5VjJRTHpoNkZRWUtKZTg0?=
 =?utf-8?B?Z3NDTkk5anl2azZRSVBjUk51SXp1cFZlV1JTN2FKczM0S0hSVjRRbmFOSnVS?=
 =?utf-8?B?dWhsRzdxeFJjZlpyeWc0L0V1cnM0V2duckJoRXp4RDgwSXFzVUFmLytRYlRM?=
 =?utf-8?B?czNiTnVmTXdPODNONlNtSUhVd1RuRGlWSzZSSmczeUR4a1EzSTMyb0tqV1Uz?=
 =?utf-8?B?a0hmeG1RVXp0OUZzd0RqRHVjZ29qdXlqMTVOWmdaNzVBQnF6a0sxT0x1U0xL?=
 =?utf-8?B?Q1NSMGY2TW5kMXBTU0dPcTR6NzVaQTFPT001NXFZTDBsQWtHaS9DNkRJNnA1?=
 =?utf-8?B?eEZFdEt1ZW9qZmQ2aTJDbWRBMndvQUhpRnR0ajI2U29OZE92MXAxT1pCbHFU?=
 =?utf-8?B?dTVYT0hrZzdYTHQ1aGxsdFk3WUR2OG9MY3JLUnNzaU5TR2E2cU5wRllES1F3?=
 =?utf-8?B?YnB1a1VZNDVhV0NWc1dyazlwVXY3ZWQ0ei8wUmhsVy80N05LdWFDRW5BaHZJ?=
 =?utf-8?Q?qA4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmloY0dBVmFnWCszL3N2UWFnUnJGN3pYRSswRnNyK0RZblJXMmliby84bTR4?=
 =?utf-8?B?L0sxclM4b2hndGJ2dFFYOHVCQlliSGxod29jb1REWXVvMi82NkZiM3pOOW02?=
 =?utf-8?B?RUN2U294UXNUbktDcnNSNHd6Z29uYTg2WVgyaW9HOWVIMnRxQ1o5azhIYVBT?=
 =?utf-8?B?dTUrY0lUT2VmZ2c5TTRXRHh4RFpYdzhtcE9zSVRrSXRJR2U0Q3lpNFJrY3Z1?=
 =?utf-8?B?VmpqdUlMa1dQWm5nd1poV1BQbCtEaEtCQjhyWmpvOTZIN3g3YlJhR1A1aTd5?=
 =?utf-8?B?K0dkN2Fla0gyT3QwQ1NYYmJVR1E1RWJVQ2xIMm9yMDkySVU5d3I4N0RBa3Rp?=
 =?utf-8?B?b3BYQnpBQWU3dzExMENISG1Tam1ULzRySStvL2Vkclc2dmtadU9ocE1MNW9U?=
 =?utf-8?B?SEF0WUdkeFFhUms2cXhORGhDTTFpVVJJZ1JBU21ISThqYkpwY3VBdUJHQUZM?=
 =?utf-8?B?UTAxN0ExWmxCNXVOeHVCeC9OMUZiRWVlVnBBVko0djcvVmJVMjE0QTVtZ0VQ?=
 =?utf-8?B?bW00RnN0Y0wvZGdTTmFNdUVMaXFCNWZ6cWIxOGxNeVZDQkRVeHZ3MFN6US9B?=
 =?utf-8?B?VmxVY2dNMHBNZ21mRmN4N1hhRmxDMTViK1BjemlKWU8xQUtXWDFHU0dpR0Ir?=
 =?utf-8?B?SEx2clZXSzlkK2s5bFJoZ1BCelZUZ09YQ2ZBVUYzQ0NGSHY3aVNBb2d4dWtP?=
 =?utf-8?B?SW1PV3lYdTU1OXhjUjlhcy9VSmRBR3hIQnVTQWl0QTI0RURRNGxPV1cralJG?=
 =?utf-8?B?YVdmbHYwZk1KVTYrbzRMVm02UDFlYktOTDhwNXRSSWNUOGQydXhmTXk5bTAw?=
 =?utf-8?B?MEtvMysyeDVtR041NXYweTF6M1U2dGVIVlBycm9TOG1xVENMRThXUHM2emFN?=
 =?utf-8?B?THdEZENZbVdXR2ZMQUpFamtHeFhaODk0V0RjTHp2YnlNTE9ET0ZGR3JGcXRw?=
 =?utf-8?B?NUc4NkdGdGpUTldzbjRnZGR6Sk5EemZ1M2FQaXBVYWd0MHl4YXhTWXZMMkNr?=
 =?utf-8?B?Zzc2SW1ZRkVpa0xDWnMxaER6UlhhZEx2WlpMR2IvR2ZhbEJzUFVqVzhYVSsz?=
 =?utf-8?B?SWozTzVCc1owZTNKZUFyZlEraFNwdWhraDBpNmpLRkNQTXI0UkZTZzhBbUNO?=
 =?utf-8?B?QnJXaHFEV1VzMlJYWlJKNG5qQ3U1bXdpbjRBZjRVYUZMSklTdDdvUEM3UStY?=
 =?utf-8?B?V3BCMTQ0ZGxyalo4MUFDUjdlbkx5ZjlEL3VBeTRQakhvUkpzVzFBc0hVQjQ2?=
 =?utf-8?B?RDNpK3JRN29tdG8yZktxSzR4RUJDTGlNRllaaVBGeEJyRzdiN1ZORThwQnNu?=
 =?utf-8?B?N1didS9FbWhJRWo4YmpkU2FJdldVazVNZVBNcmx3SkdjaTZESlVxOTVoekNm?=
 =?utf-8?B?U21NeE8vMyt4Z0gxWmoxdVFJWjRhTklYcnRZVXlIVWxpU3lsU3MxcFVuWHd2?=
 =?utf-8?B?QW53QmxPT1Z3ak9lbzBxWXBzNE10YWt3Q3d5UFdINnR1UXcrL3I5MzJnRGE3?=
 =?utf-8?B?Y0x6ZlFCWlI5UnNXY1VFZjkxSVVoQ2lZdUFmejd2emdmdXpCci9DWDlyM1ll?=
 =?utf-8?B?SWQ0ZHI0Z3VRdEt0VHV4SDMwdWF2SVo4MlJhWE5HMDBZWEY3dmFDRk5oc29j?=
 =?utf-8?B?ZlJ3a0dxL1VyWlRCVm02VERSUERoWE9GYWxhUCsxNXRRbDRQYUk1SG1Bc1lt?=
 =?utf-8?B?cFRoMGxYUW5oTll1dVQyaEJreHhqSHNheUF0d3lGbHRtdnlweWMxd1liNm51?=
 =?utf-8?B?TTYyK0NoMGthTHNLdFE1QkFqUzJDdnkvNE9FdFAzdGhNRUUzY2NtRlVVRUps?=
 =?utf-8?B?ZHpqYjg1WjJreXYweGNoSEdtSVg2OXV0VkRhaGY4RzJPWDBJMC9zV1hqSllM?=
 =?utf-8?B?dklvVVdqV1VYcGZHdWZKdTZtYmVvd25iZ2NTYVdrMHZRVTMxMkgzMC96eExz?=
 =?utf-8?B?bi90SXI3MkduVng5MnlWTnFyWlVOMmsxcGg1UDV2VXVGMFE2SExiSUhCeVdH?=
 =?utf-8?B?bnJQbzFweVB2VzdrU20vbEdOeDVGZDY3RVRYWUVzZWZpMVJMN0g4QWI0RzVF?=
 =?utf-8?B?bTFIbWJIa3h2NEM0SWdlclE5cUN4MVFJbjJFdG42SnFNMmlydjBxNHJVbDFI?=
 =?utf-8?B?emNzQnVlUU9KVWxpdENzS3Q0OTVUa1VxczZWMFd5bVJXdFFuQTE0MDZwYUFW?=
 =?utf-8?B?UlE2RlRyNnNTR2JhUGFLK1RkNlVmajlXZlRBU3FPamtoRndESHIwSlAzMjdI?=
 =?utf-8?B?RXRMTEpFSVF0REswYzIyTWZwOGdOQlFCK1NlR21ENDZURXEwa2NXaitLU0hG?=
 =?utf-8?B?Sk5Xbll5U1F4N1BVYlBTRElsayswcElxeHd6NmJXN3pJQlVSbUpWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73145df0-ad2f-4b0c-5342-08de69364a9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 06:25:03.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihdcb/owRP/nDBo/w6S3mGwK/BJzJpG1x1JlxLoierW50Mjs6kp1SbVOkUebiUHh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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



On 2/10/26 17:22, Julien Stephan wrote:
> Introduce ufshcd_ops_phy_initialization() as a helper for invoking the
> phy_initialization callback from ufs_hba_ops.
> 
> This mirrors the existing helper pattern used for other ufs_hba_ops
> callbacks and keeps the call sites consistent and easier to maintain.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/ufs-rockchip.c | 10 ++++------
>   drivers/ufs/ufs.h          |  8 ++++++++
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387d..cad753d5990 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -30,12 +30,10 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
>   	ufshcd_dme_reset(hba);
>   	ufshcd_dme_enable(hba);
>   
> -	if (hba->ops->phy_initialization) {
> -		err = hba->ops->phy_initialization(hba);
> -		if (err)
> -			dev_err(hba->dev,
> -				"Phy init failed (%d)\n", err);
> -	}
> +	ret = ufshcd_ops_phy_initialization(hba);
> +	if (err)
> +		dev_err(hba->dev,
> +			"Phy init failed (%d)\n", err);

nit: That can be on the same line right?

M

