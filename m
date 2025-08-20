Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B2CA0EF5
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 05:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1977580FA1;
	Wed, 20 Aug 2025 07:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UiqvaE+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31CC8211F; Wed, 20 Aug 2025 07:05:00 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC5F809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4jEcMDFtdHJzqR+lj/mYcTtNWj/PqtNGpoAikH2EfJf+4L7zx2qD4LMj9HK6VjyUzSSEtZ+J/4FkkItvRVOTdz657NH61eVPUXicCTIk92/g9/J4UbMACAdWQRy6bzYNHkIVSAnjnxcLG3TILXSVl6698rIuJ94oYXTmiHyyXUmcFhMYwSiDrWzWZmkS8qoRuZRNqbYtgjame3JcekkYaoeR8rMFwJ6i8BwJjs5zjYT2uZhVnPgSH04lnOYR8zpJtF0A+koMhVWUurvq0Sh38VU/62RM2pwKwsBD+Ax2JpkFKZoTtD/GY5yu57w4mmdKui1+K7DC5NEukAiHFOnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qfstoA6zP42hreJ08JfOXz/E+K+7pEH0s64wlcX83g=;
 b=u6BMIfB9LedpXzqN9gWbK6YEsZA5lLmxrtTNLo1srZe52LZehDguj3b8mCZDgPfST8tZLbstxGRG1cPyZqnvqmXX/jallYlVZco9zSmkT0/BmApl/yDvVpy0qGvFIxESAKjxAndRg6foNTJfJdVoAjwCn+ji7txOUn4zf08jTmseHTxwv9tYo7+KgIlM4E5t8b3OghAoZmOQjOs1CRvBIOVyYix8MQSPRE+V9o13VaAAqcyz1xvoLYSVoYOC2Hh5eU0BMMEhKRjTf1me32tYfRWaRMI15J0rDNtFTEJx8Ynr7oqJIhsR8HAaUDec5zLOSaycuy7I6iIYUHr+Yc681A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qfstoA6zP42hreJ08JfOXz/E+K+7pEH0s64wlcX83g=;
 b=UiqvaE+ANYrPuGGHnX/4EMKuB1orhIrRGczqozjBhKrADt52dMpE9a9h9JJDAO21UcUFrfNw9Q6AjLfGmZeNdEVqa4sLXMCSMwUVftVJfyRhjmFOp8j5mfqaKA7qpGkdXPuKLDlXStfkraxrbWSAth0beLAB6sopjP9ZIiMV33FyQoBU7j9uwOQGffGhqzdeyb5Mh7Kr5g8q7wy7u0o5q/lrhx005Lba6/AbJ9Hdd2Q6vRb9dMoxOuI24sQbXi7dZQkZ2tRlUH+vCCcpJ13GvqLiECM+l75Li2yUxJv6KUk9WVHslcxRZXNkgW/xg/GSaHvwxgF5Mrz8CyLxuojWXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 05:04:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 05:04:56 +0000
Message-ID: <b8dc3f05-8e1b-4c14-b71f-a59f3e8333c5@siemens.com>
Date: Wed, 20 Aug 2025 07:04:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
 <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 3751c716-2919-48b1-6396-08dddfa71b24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWZPZVF6QXc1czhoUWNMaEQyTDB4aVRuNEprMzh3TFpMY1VjSzYybVJiUnlW?=
 =?utf-8?B?Yyt5d1Z3UEphdmE3MGtZWmJ3UmJqSk5ZbC8wcTIwN09Cb05YN1IxSGhVNVZ5?=
 =?utf-8?B?b29kaDROTzhGb0NUU3NvcU9MU3ZJQ05EbEFVdW9JTkR1am5WWjhIUXVwS1Az?=
 =?utf-8?B?aTViNXVGVzhmZ0w2WjhkMXQ2aENyakFBdm9MSHIrSjkvVzNKNUprenN2VE1B?=
 =?utf-8?B?QjVzMHVkUmR0bHJZUmFpVjlROFIwSnU3RnZvNUgybFpBNG9IcTdmbDg0WGVM?=
 =?utf-8?B?T014UEJkNU5oblluVExGNkk4R3lRS1dkbFRFM2JPZk1TZTEvNUZseERWRFNo?=
 =?utf-8?B?Sk9IdHpiRS9qNHM3QnhxQTh3eEdoMEh0bm1WTDloZWxBbU1CUE5xRElQUDFN?=
 =?utf-8?B?TkZiaHpMMUVvYlhISzBqdlJ3NkZVcmtQbUsrS1BrbWNUZkQweTE1NlJsZzVN?=
 =?utf-8?B?azhLdjlHQURnYzZub0lEdkFqcGJCQnlTeUpiNGhmWGhuMXBYYis0MXYzZ2pQ?=
 =?utf-8?B?R1JXdXVGQjI0dmtsd3hWRnFpQWV4eGg3cUhCRnYyZlRPNktYZjBzblBJekN3?=
 =?utf-8?B?Y0NxWlNKNWlyUGVYZHBKZkttb3BkVlN1RXFvV2FxY1krcGp6ei81VFk0a1Bk?=
 =?utf-8?B?TVFpYUkyQlFSaFl4M2dNbVZCM1lHdTYwVTBMSEJXdkdvUmpGWGxSdEdRVk1X?=
 =?utf-8?B?Tk1lMGp3eThKUm5vR0NBblgwV2F0bFZwRTM0RStpQUFYS0kzeGJjUlRmd3Fq?=
 =?utf-8?B?cnkyYWJoMHJrbVNaY3NqUCtPQWd4dVhUTDJ0SkVOQ1hQdlU0UEorVThUbXor?=
 =?utf-8?B?N0JjTVFlaDZrZHEvWUdBNkswVDduODdnb1J1b25xV2JtQW43QWpBYm4xSnRt?=
 =?utf-8?B?R3FWM044SWZ4V0FBN1E1U1ZtUE9OZkMxbjdOMVEyaGVRK0hKdFlzdmlReGRo?=
 =?utf-8?B?TGl5ZlQ4RFZmdDA1eGRqTUUwK0NjM0tjNlc3MGlXcjZEZDBJTThhcHNLMnNF?=
 =?utf-8?B?QWRIU1JZdGlHNjJlK1ZsQVZPK0xPWFdwZ21XRXM1dEYvbVU1Zkhva2RmazYx?=
 =?utf-8?B?VFBVUmlscEErWFVTVWNzVmVnaHlGSGRvWTE3Qnk2R1FTVFRkSW5UQThVeXht?=
 =?utf-8?B?SFd0RllFTFVpU1hzVnNTNXY2NVRnS00vcVR6RVpXN1FXRTFSOFhCbmlzWXFG?=
 =?utf-8?B?ejd4VmVwMWhFbU1Zckh1am1udE50OXE5QklRaXVPRWRtNmZhb3ZHVVVNMEE2?=
 =?utf-8?B?VEFsSkYyc3NrSmxzU3kvL2xJSzhkS09VSVprV1U0djdmaG4yeWNNNlZXNzdZ?=
 =?utf-8?B?YkhlR1plR0trenYzSkhDSFRGc0xyR0t2aXdaZXRyR1duc01md3gzOWRpNkJS?=
 =?utf-8?B?SVp6VEU3Mm1WNlBLS3VrbzRFSzY5NjFiNmgraHgvbW5jOXVkN2pFc05YQmYx?=
 =?utf-8?B?K3Y1R3Zhd3dQWnVveTc5YkcySzVtWks2VUNHckozWEp6cWQ0UFh5TnYrWVF1?=
 =?utf-8?B?T2ttVTlpOW00c0dRamg3dVhZbFZpZ0tncjRqZ0I1NFR1eTVRRDljc3R5SkhU?=
 =?utf-8?B?SXRzK1cvcmF4MVk0VVlCOU9RUGNEd0RlWjFSS2p2YVd3a0U2T0JGVldmc3RG?=
 =?utf-8?B?RlZ0QWdyWUdqUjY1bnFSMlFQT0NvWE1ETEdlSnIrYXVhK3dmTEFrQVFYcUJ1?=
 =?utf-8?B?eHVjTnpNOVcxWndiamUyOENEL1dKTUZzRUxSTGY0M2JPTkVXMEdZZStNWWpK?=
 =?utf-8?B?d2YrYSs3a0RHQ01qM09NSWQ5RWZZRVhaQlRtd1Y2cEFPUWVqU05MaENTZStx?=
 =?utf-8?B?TzhJMlhrUHQxRkxJdTh6cmkzWVJyZmRHemRFL0JFeHlvZE1GK0FNdjV4T1V2?=
 =?utf-8?B?MVVJOXM1NE1RZTJta1NPNDdnWWQvT3dRaUtkU1hVRlNuMC9uV0ZMNEZXcWhD?=
 =?utf-8?Q?6v+CV42haD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVZydjJ3blpNbVVXNVBNeXhZWDBjTnJ1RUpOdDhiQUxVTjlHNzM5RmhoTStX?=
 =?utf-8?B?bncyMC9TbzhSR0k3NkNFWDZHbHc2YWVLU3VnVkRSWGZIc1l6cnNycUhlOTBR?=
 =?utf-8?B?MnQwUjhEdjBNRDFKY0t3bk5TZVFjMTdDTHg3KzhFaVgwMFFHYmIwYWFvTU5S?=
 =?utf-8?B?N09NR0JqemlzZFR6VmQ4dW1Jb3F1Y0wzZTBIRDNUenowMUp4c1hwMHdkaHhC?=
 =?utf-8?B?VEJJL28zQkN6V2NhN1dkUUJSUngwRGVjN3lkazIvUktCMFp6bmhRUS9IdExV?=
 =?utf-8?B?N1dSNkRTeUE3WVZTQythNHNJTnFPdStkUlVtaExlYVFmS2NNNWpFY2hGSGRi?=
 =?utf-8?B?azFweXo0MW10UTJuU0JNSXdoclFxelNTMTBJZW5IS1pyd1lVSWxFdDB4dTZK?=
 =?utf-8?B?aHFFWmMrVUF1M25xVXQrT3pYdWh3anlhNHVPRFNEYlBrK2t3aWhjeVo0VGxo?=
 =?utf-8?B?eWtiK216eGo2NUhyU2QvNTErVGdKc0VjamtaYTluV1c4R0pqa0kxMVBIZnVP?=
 =?utf-8?B?dmlYd2tYaGdHMVVGNkdVNTF3ZGIvcTZOeVFUZk1YZHhpRlcrRTk2TVlmdXhw?=
 =?utf-8?B?amhkdkEvMlZSQS9XY2hzaWNHejRWSVRxRnRIL2dvQ2xiaUdGUGo5TWRlWGx2?=
 =?utf-8?B?M0pIRzZ3MThnZU8yRmZ4cWpDYktSMVIwdnkxRGNmZkFRSU5EZlFaWTh5aVo2?=
 =?utf-8?B?SjZtVnAzK3h1ZGZUbHJyLzVlTHJDUGdueUNpNlVWaGJWNGorOVN0ME80WWxk?=
 =?utf-8?B?WW56K2VXcFJwSE9xME8waVhFY1VWRE9mZ2d4aERGLzlCdGIyS3gwbWROaHls?=
 =?utf-8?B?Yi9GQktZaHBvY2NqT2s5QTg5MUtwSFlvVHFDV2xZcEIveEh4dFhJM0gvOFBK?=
 =?utf-8?B?Q1gwS1NJNTBKK3Q4SFl5MjdPTTNjQmthTjI0OFFzcy8zNG5sUnRWbERScS8w?=
 =?utf-8?B?ZkEyRmlud1E2UWRZOTFDNnZMTDZ3ZEROSTZlTEVmQTFuTWZsMjFEMi9Wenov?=
 =?utf-8?B?ODU2V1A2d1Z1OFU3dmRPSWxFQ201TTNicWx4UGdmNFZYSUJrNlZFZ0ROSHdu?=
 =?utf-8?B?ZTBvOGpKL2hTdC9Ta1B0Sk1IcFpLTmYyMy9WL0MwZUtrRTBrRUtBMkU5cEdV?=
 =?utf-8?B?QUxmaXFPK0E1OFMyWmkvWTJYVnJqTGF1aWZaZFRkL0VQbkhRUjBXVzgxbkhB?=
 =?utf-8?B?MmFMK2lWdmkrQmtZY01WbkZSQ1lNTFpZRHpxSlRxSTZsVyt5RzlMamtZV1d5?=
 =?utf-8?B?ZUVzWjdXYUdDaFpHSVpUSjlYV1VLL05wVVIwZ0V2NXg4UHpLNVVESjlEQ0dt?=
 =?utf-8?B?N2hZQkxkYUJweVZjbHZCeHhCVEJJb1hldHJEOXFaL01pdUJINUNrVG5ObEtC?=
 =?utf-8?B?U2RYRTRDdi83QnhYaFVDVXF4OTRNdXZBS0FhR2RPTitJODhxemZDSXFvL1Zh?=
 =?utf-8?B?OVhTdmZYOUNKd0IrOC93OFhjTWJEWDhadlAwZ2JHTHBGeWM3NXUwNHcwNXNj?=
 =?utf-8?B?bXE1Rit4ODQvSHZ1WDRHTzM1aVdLMmJpVVgyZ1JYL0lxRmRGL0dIYmM5cE9F?=
 =?utf-8?B?TDJXR0lRNWVEaWVweERoUHdrMVplVWtONmRyeFdzKzQxV2JHVEdZU25nMVFv?=
 =?utf-8?B?VXhXanhUUmxoUk9kOGJNNVNmeFhEMnRDZ3RWcXpGdE40TU5kdkJsUXl2Mmpa?=
 =?utf-8?B?OEZmVlJkNHB2RHBkZlRMbTkrTGIyNWFJUk0xakxnbHpPMjR4N1F1eFBTR2d3?=
 =?utf-8?B?RnFwV01VM1I0bk53VlE5OFo2Rnh0d1N4eVVxcVJNaHUwRXFKU2F0K0crTFYx?=
 =?utf-8?B?RVAwMFRHYVZ1Q1cyaFo5MXhGMFZTMzlhZ2YrM003L3l4aHJteXZNemMrd0tE?=
 =?utf-8?B?OTh2TFZhVitCSm1paHhRcnFJbk04dE9UY1JDNXRVMUhldEU5d3A2R3NDd1c5?=
 =?utf-8?B?YW1WOWFyMk14Tkh1Si9RdWRhTWs0bEZpanpXYlIxNUxsLysrNGJhbjZROS9H?=
 =?utf-8?B?Vy81Q3hRbXdXRmhXQW9xM3RZd2YrYjhEVjJ4VHpuY1JWb3dsT2VnQVJHUlRQ?=
 =?utf-8?B?bFFkT3RkWDBwSDRJd1pNSVlxcmlIdGp2Qnc1OFk5dVZZRE9FWXc2OS9FL0hk?=
 =?utf-8?B?SGFrTENMYmUxa25MaVk4MFM3WmpuUEVRejQxY0dNcG1sM2FEVjhlWlpmdS9p?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3751c716-2919-48b1-6396-08dddfa71b24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 05:04:56.5739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCVp2CsOqVX1Wzoz9lHIT4EEAOBqXEPppaVWavQkI9+7DtLdpoxhGtQ7ZkXjvjI0YGKjO1pgFS8mqTyGCkw2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152
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

On 19.08.25 16:45, Heinrich Schuchardt wrote:
> On 19.08.25 16:33, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is needed because distro_efi_read_bootflow_net will then need
>> dhcp_run which is not already enabled by CMD_NET.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   lib/efi_loader/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index c2aa88f59fb..a4055e1cb43 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
>>       bool "EFI HTTP Boot support"
>>       depends on NET || NET_LWIP
>>       select CMD_NET
>> +    select CMD_DHCP
> 
> It would be preferable to get rid of all CMD_* symbols here. They are
> just the result of missing separation of CLI and library.
> 
> DHCP is not needed to boot via HTTP. You can manually set up a network
> interface.

As I wrote, we need it in order to even compile U-Boot.

Should we rather wrap some bits with #if defined(CONFIG_CMD_DHCP)? Then
tell me, which ones.

> 
> Please, change your patch to use "implies".

That would allow to disable CMD_DHCP again, resulting in a
non-compilable configuration.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
