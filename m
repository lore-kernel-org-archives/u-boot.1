Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DDBCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 13:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29729801BE;
	Mon, 18 Aug 2025 15:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhbOhHnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D18E801DD; Mon, 18 Aug 2025 15:18:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7288880107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 15:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE4vxX7BSJoe2QB4sBvG1QSbYTDuEh07EpnZhrLj0uER2LEcaBv2Tt8QsaxDPASaeEt6XGEcf4KP1XxHptDDch5KcoSxWcCkOT9Yb7ixiLJT+DtisnfSGSMsM0dcr73oUQjl8aE8NjYg+81NJNxJNftFD6jfrpbwgMZc2loBitVLFno+EwaLbVvzv5HmFZa+60j9I55zRlSFUMMyZFTEHLtk5/3RhmlAfBwg6gLM1foK4Z/qogZWfM6iWbz0rf10UuEBTxL3cE7P1OALV3yZPAAR8IKe0HfVHlEHNVnYW3qi9EXnENrTE2dOnzgUoP2lNA3J7Hff+zVj8COaD11aeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgvf1NlPDoeKwEIJt4PGE7wtAkSybVX6/Wj4DVGYJn4=;
 b=Cq6hTmr6y4QWuttIbOPN7OgTcT3BajnNJW+sPhEwx8SOlOLQUFhQw2VfP5RhHN+CiSNlWmzRUR3rGhIgbs8ixxjDPycSNPjk21O73sAUz3uJHjphQvJ9sFMCb64GJMpH5FUU4p/oOmAfGn2N381xXEuf2OeRMozpC3qNt9ZnyStXfvqalZLhRO9vcd9oiflgjM/Jhk4LBIKi3o3v/eXMuwLBKHXb6HyAH9m3HrqeBnHwKL6lLOFh0q13FUq1zqHEDFf1FzQkdtlmyTK7Ar38GgQONfz3WW94q8Js/NakfWsbCKLlhWQrCJJ51m2ARyhuKRHh7gwwc5Jx4xSzNF/Mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgvf1NlPDoeKwEIJt4PGE7wtAkSybVX6/Wj4DVGYJn4=;
 b=yhbOhHnEiikZe6zrVRulGQPabquai0YaKfAK1Dk6S0mNSOiy/6dbooqpe7jetoRk3qRNUjWnv05xN+EgzTOPVGZ2+YjiIZcHhIqY1lG+e59uPiITFpg3zo/jhrCCaHxCX5yUVywuYytmFsoQLs69NPSRYboCVWiOt6NJGhzTstY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 18 Aug
 2025 13:18:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:18:03 +0000
Message-ID: <b61eb3a3-1c86-4d03-9a80-642ef64f71a6@amd.com>
Date: Mon, 18 Aug 2025 15:17:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: axi_emac: Fix timeout test
To: Anand Moon <linux.amoon@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
 <CANAwSgRvnJcZ71eNRCf+9G2NJjq8CxzV43h6w-cGEsmHLGGz+A@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CANAwSgRvnJcZ71eNRCf+9G2NJjq8CxzV43h6w-cGEsmHLGGz+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcb9d51-36be-45bb-fc51-08ddde59a963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVRd3htRW9icWxXdk5HL3krSFAwbjM5OWI2azNYZU01UDFiVitaR1lpNHQv?=
 =?utf-8?B?V2dzVkMzKzhHTlBIbXFEY05pTm8xeUpTbGZIV0dEQ01YVVVaRGErbFpxQlpm?=
 =?utf-8?B?TG9wdjNCblByRHJxZ1ljd0FSakJ4UHJYUnBsU20zcnJaSWJ0YXlycHREdXox?=
 =?utf-8?B?MjRsS0J4YmI1c3UvckxPTHhKcjRGb3dvYzlIblplK1I2VUdRRzNJK0d5a1R3?=
 =?utf-8?B?RFpIYTQ3RzJLQUZuNlV0dkV3enF2bFFMQWRUQVdBeHM4TnZnOG85Z3ZQTVh3?=
 =?utf-8?B?NlpJZG1TMFRLVFZETkJzR0VBN0ZtMDNMK3FLRXRjcTlwbS9BRmlBVStudGQy?=
 =?utf-8?B?S1htZ0dSWkVyK1p3Z2hQclVQdXJwTDN6UnloYk1PVkM1V3h5bDRqNFczZXFS?=
 =?utf-8?B?WWlzZzdjbFJMZExWamp6aXh2NVphWDhFNmRyZHRaQ1JQREUxbERxLzNZTDBk?=
 =?utf-8?B?TDVMbytXTFNsT1dEMWg4RkVWcWNZZ3VDb3RIQjEwT0JURW5pL1VkYkY0bVR5?=
 =?utf-8?B?eGEwWERDZERZbDVFWTJHWmJ0RzVJeDNqK3J3eDMrZHljSk10TlJTYjdESnNj?=
 =?utf-8?B?WkdITlNSM1VjK2NNeTJyeDhscEJrZzJUVGNmcUZ5Yk93QnNYRWZvQlRVSVpO?=
 =?utf-8?B?RjlDTUFkMWpjdE5YV01KNGwrdFJ0dHZwam4wbWtJdFJLdjJXbjBhR3NGc09D?=
 =?utf-8?B?UDdObm9KRXVsM251ajlYbXJLN3lCMUUvMVVDZ3RFQndyVE1pWmkvV3JpMzN4?=
 =?utf-8?B?MlVmaDhHMytYdnVQaWY4dDlGMVlMa3ZWTHh1TGZQVklMRXBtTG9TVWduN1l5?=
 =?utf-8?B?TG1kV0VDRGhWNStaTkhGMlZZVWthVWwzSUhlL0FBQ1d0OGtlVzJQQXdwL2xR?=
 =?utf-8?B?VkRJalVDd3NMbkFvMlNZdXJrSVo0TmN4UEtlelFMbG9NMjBjVWl6NWsvcjVq?=
 =?utf-8?B?ajVtaDRwbkUyaTB3ZXp6ZGpvM2s0azZYaU5ON0x1ZUV1NkNYZDFpV3M2T3Ri?=
 =?utf-8?B?emd5R0JtNnZENHRHUnlpUVdkOXBadmJSYkxZTnlTS09lMmM0blBxMFZuZTNT?=
 =?utf-8?B?RVhZeFRPOVlMQjRxQi9xdGNRNXppSTFWUng5cm95QjZkZjhPN3V6NC85R0pS?=
 =?utf-8?B?bkZkbDkyNFd4VTkwNjllcWUwTjVNbk51WWUzdU85akowRWdEL20rSkt4anRK?=
 =?utf-8?B?NjJYSjg1a3hVT0p0Mm1MS0IvbUpCbVNqT3ZmbmgzNFFkdTh4dWkvY1RkNEtS?=
 =?utf-8?B?am8wbGZuY3dLTHlLcklkVWtNcjg2Sk1uY0FHZnFaMmhyUkNMeGwyemdsT3Bq?=
 =?utf-8?B?VE5yQ3F0czBxbDZ2azRnRUd1S1hnVjFjRmFEMXBuSERQYndaOWZTTDRoWUFB?=
 =?utf-8?B?aDJoQlpMbHQ2R0RuU2N3cytiMlJ3QzR2ZTZKR1pQYU5KV0w4SzFIMHdzRnVE?=
 =?utf-8?B?Y0gyemF5ajJybDJSMnNua2pBSElkWDJGNDZJQVhEd2w3U0JvUVk4bTg1dGts?=
 =?utf-8?B?bXppRkxuRHRFM0dCaVY4M215TEJZUzkvYnJTVS83VjRWOStNck1CQlVPSDhR?=
 =?utf-8?B?eHE0WHZVL0hQcU53cXJXQ2hRY3owcjQ1b1ZTSFNaRmRJSDVheVplMlZwODFR?=
 =?utf-8?B?RGRmSjRkUFZ2Ti81QWVsSTJ2RFByVEpjUWE0bFl0TWFnSHVQYUo0MTlsVnVr?=
 =?utf-8?B?VS9rL1ptUThuUlh1TERmUlNTR2l0U3NYM3ZaRGxVNmpYdlZtMk44WUd0K3Na?=
 =?utf-8?B?UUtkYmtQRlE0MWlUQktxY0xjbEpEZmk2d01kakdEaWJzNVhRV0pmOHFoQVRq?=
 =?utf-8?B?bkNlQzhWNDhTWUgzZGhXN1c0MEJqY0ZPZ3J4eGplZkMzdjQ1QytwRVhOMnhx?=
 =?utf-8?B?ZitxT2NYQ1dZRi8rUUsySXFzUkkrTEI3M2EyZjRYOHVJT1kxcEcwRWtjK09O?=
 =?utf-8?Q?whqr8tcaWCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RXU2pxM2JHUHk0Vk0yaUdPN2RqQzVkSnp1NjJzS2txVUZsZnIrRS8wa2lT?=
 =?utf-8?B?bk53VkFScUZmdURCcEU1OTNTME95cGF5ZEtVUDRNY21sclpiTU5WdE5ZT256?=
 =?utf-8?B?ZnVNajBSdDh1NFQ4eG9hZ0FiMTlXY2thM2txV2RYNEZrYmlWbnNiZVBNQWNJ?=
 =?utf-8?B?RGp3eUc4YXNZRTlBbG13NkR0aGNvYlY2aE9uSndob1MxUFZnZFFMV0VZMXZS?=
 =?utf-8?B?aU00U2hTb2tJMElraVlJUVJCKytqQjVNdjdaWlZMRjNwOTdPcHdud2g3L2Ft?=
 =?utf-8?B?SmlZRkpqS2ExTjZHdFFiZWYvcXNUVVVQdytOa1VtajdFZ3gyMVBwYTR5WDV4?=
 =?utf-8?B?WVNUVGtVNnJmdC83RWRTMnJZbmRvN25QNzE3M2hFR1ZpSjQxSTVWVDBrcHR3?=
 =?utf-8?B?clQ0UHlQY1R2M3libS93aVZ0RGFVVlpMZ004WnAvejJ0WU91MDMyK1VZWmJR?=
 =?utf-8?B?eFk2Yk0yTFNmbWtCWG1aRTVVQkRPdTFLYUNTdzdXN0h6MG52cnNaN2NqUFpr?=
 =?utf-8?B?M2hKdWEwOWVndTVFNDZlUFc4dkNET0wvNDFBVXFPUS80T0hDTGw4VHFWb3Np?=
 =?utf-8?B?a1liNHRVVWxsaDVEQk1NbkNNdkRVTWtNdlM2TTZITURBZk1DWThXSkRreHZn?=
 =?utf-8?B?c0hOdnZ6WEp1NGFJdVoreHlIWnFoZGNCakxVZ0NYTGx5V2o1Y2F4UjRJRGpD?=
 =?utf-8?B?YnZPUHVXSXVvc1F2bEIraHJvU2FGbTFRRkdLZGhSWmZBWXFTaTZSN3BQYUNy?=
 =?utf-8?B?YWxJZFJYU1RYZm1jY3phUlgvazY2bkgrczN0NUVRWEYzSVFhTG51UUZvcHFF?=
 =?utf-8?B?OXpNcmJWT1JTLzNTb3dGT2ZGZHZ0eEFFamtkRGh6Y0FYM3BYR2hXS1ArSFdY?=
 =?utf-8?B?aHg1czc5M3E5WnVKVEtwVHliSmJib3RqUmh5d3dPeDBWMVIzT29EdTB2dUg0?=
 =?utf-8?B?Yy96dGdReTRBaUc3UHBrdmFvcGlaeDNsaUJXelFxUUJ1RDdjdFhZeElmdFVC?=
 =?utf-8?B?QWw0eUYra0xpL0hRUlM1bGErelJVOWlaZXpRZWd4N0J6RzhLY09DTDNyQTBy?=
 =?utf-8?B?S0d4Q0xrdU15Zyt6QTZHTDE4OWw1Y1ovckRoZHJFS1czKytOc2pNMVd5bFM3?=
 =?utf-8?B?UkxPbVo1dXY0TkVrUThkRkdQR1U2MUZHQjQ1S05xdTF4VEJOcEFvTHV5TExi?=
 =?utf-8?B?WlYwbi9ySHpDa2VoWTA3dEIrY0FHa0xYSUYydTZCRUJxYXNIWjA5bXJCMDBK?=
 =?utf-8?B?ZjR6Y3pPa3NHd3NTV3gzNDZnK1JEUittL29LdnVDVlphY2g0YnFGZlpRRFJu?=
 =?utf-8?B?ZHltbTNJSDZZRHVXbEJub2lNOEgrMElTdVhIRWEwU2pIZGJBY3FjcDdWNHlF?=
 =?utf-8?B?b3VYN1ZoOFoyWXR4ajRrdWQyK2c4Sy8vODQ4SW1kWHJtVnFVVlMxYzRsZi8w?=
 =?utf-8?B?ek9FTHFtL3RNSFJaSUw3V21Cd1NxdUlGQVl6b0hhVkxpalE5bU1Oekk0UUFV?=
 =?utf-8?B?ZWNBZW93Q0Rtc25WbjQ5NlUxYkZ0WkYwb09BbFVzQ2ZENDFTTlhDRk5wNnpG?=
 =?utf-8?B?SUpwZmwxcmk1MGZ3SXVtR25XbDg0Y1pBcjNhdUNIV0VMeHdQUDdkZXp1c2ZU?=
 =?utf-8?B?YmxwSHR0Mk1wcWhUbklIcHpxV3k0dU9odmhwUUwrU0p5ZkFZb0RxMWpWem94?=
 =?utf-8?B?VzlWVy9BZ3RGNzFGMGxkc2JFdnBqZ2RnakZ0SEUwT0pUbHFESXNHUlFUT3Bp?=
 =?utf-8?B?dmszMThrZmJQbFNXQzlTTTZINlZ4TFVoME10MUsyN3hWeTB0YzU4bXRPcUh0?=
 =?utf-8?B?Yzg5bkVFa1FFMVJwODFqNVQ0K3BrRnpRSnlxdW5heEU0R2JCc0t1dFh2cHlE?=
 =?utf-8?B?MTlRUzM5ekhheWw1NHhXdUUwNjZ1RUVmak8rRjlsNzZrbXJ6Mi9ocVZ2eGhi?=
 =?utf-8?B?dHZJQzNYQXMyYjFrNUJCYlRmT1VUd042Y0JnMHIyMWlsOTZSeThseldRNDNI?=
 =?utf-8?B?WHBJRVJEYVJUTjZWOHdwSXpncTlGR3M4aUxTTldlSGpudnVLdjJGcDdpVVJG?=
 =?utf-8?B?dTl5Yk1DZ2RTSmVtTVExV1FPZUZPN29Gb3ZxWG5xQ0NzY0ZTOU90VCsxVmYv?=
 =?utf-8?Q?f7oycmHwL4cJj6TyvDTiIG6+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcb9d51-36be-45bb-fc51-08ddde59a963
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:18:03.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVYFFVxn5d9majsCiiMytTqBAsVp2ioRq6ief9I/wH1VnCNRDxEHYf/JQ+IYEuxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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



On 8/18/25 13:40, Anand Moon wrote:
> Hi Andrew,
> 
> On Mon, 18 Aug 2025 at 14:54, Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> The timeout test in axi_dma_init is not correct due to the
>> post-decrement used on the timeout variable which will mean timeout is
>> not 0 if the timeout occurs. Make the timeout variable an int instead of
>> a u32 and then test for timeout being -1.
>>
>> This issue was found by Smatch.
>>
> You can use read_poll_timeout instead of a while loop timeout?
he could use it but then this should be split to two reads because two 
conditions are checked and not sure if it is worth to do it.

Thanks,
Michal
