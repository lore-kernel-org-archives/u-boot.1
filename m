Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD5E109B461
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A34F83DA6;
	Tue, 31 Mar 2026 15:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="UXwXeduv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B7CD83DA7; Tue, 31 Mar 2026 15:00:47 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B231483A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 15:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2aizaTeKCj0L8dLNQSGssXMHtTLeXrSpJkE5BqZm5px6dJ2BxYqHcF1tFx5q3/Bb6/bjxyxI44lxi/xsKQBaS4v0pi2JZ7a6GO1O7cWjSHjCGM837fRg+6IP7A8pTJ+tfeNCNdrzB0nzO32tsaVXs83Di7CKUbqEj3N7iFZ7x5LK4iFGcqB7S65Q7F5fGSDhV4WFy+Lda9mbiUHupYWRkS/UJJbL0dNxJ1K+8Cql2/lKZAoQPiApiEOUlrNo5dH5vfnhTCMVNkc/5mpN+ngQm5/A3EuuqTgw6f4gx8uowpd/El6DvqMF64WLn4GOEv1YYwRH4b5WzhG2jH2SwDVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNDmPKWzk0EarJ8jc2v/2WWtfXslva+BhA7+Dm1J9Ws=;
 b=L5yFOvgCHCPXiXKhEyXCfUis6GABHaO2omDqspPyxmfCIqACAJwWdYYvZi8+vX5LK+pAbwY4AJCPue5vget+QZC2E+8VMdFMu1YQ17JLLezmBW5encuidHgnY0+6BwS8aqAAOH5yChZe3MuD+7aM6G1TEDOKS/yhxUs3BYwo19LCJkr5a/KRz/4HoUVI+BWTagB83+hXuJPOMpTL4/G36tjaUU67RvCVwH6OmvWVPQg4KQU8pVg87j4GYfiSUUUTvnFb06Q4Q5PUtF0oH5OdYDAK4xsxeqzEVYaFRs5B+U44iVWWk+Pl7CDSokJAHovEhs9WJ0iZ0vK1G7ZjBibU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNDmPKWzk0EarJ8jc2v/2WWtfXslva+BhA7+Dm1J9Ws=;
 b=UXwXeduvbsd/TubvSpmtt/dsCE6VzSqIUxo7Nd5XGTVcsAB2a65UqAE8eSs5dMb4b6eRwV4XmHr9ve9aZoZ82HVUBmDqeLUS7b1LH2rdZwR8RzD5RyQmpnawjlyzR0Uy935ZT+hr14no20STFfoDnxjpNkgriCu/6TMZ78MmrjiCgZJ+5rR5HjoDLcW4Prj/J8C2VdfxuQ34xXWitYXBtNe5c7ukEfK7Ikasz9HkpnWoDigVSWMEXNe3pzpKxHg4pmu2drA8EvmZ3NRvnjl6zxhdIB5zCPT/NZrEdPbKeHVVJsjD3bTM3815K0O/jvFOczsNyZ2t8eOPlezwmJYWLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB2712.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 13:00:42 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 13:00:42 +0000
Message-ID: <5bfa6dbd-92f3-4aea-b248-b1696f064d5a@softathome.com>
Date: Tue, 31 Mar 2026 15:00:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] mbedtls: enable support of ecc
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-2-philippe.reynes@softathome.com>
 <CAMDkj5wK7H7kZ=3S_VZ3WiuTBF1LOEKE=cBvfkURLJVVhoG8OA@mail.gmail.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <CAMDkj5wK7H7kZ=3S_VZ3WiuTBF1LOEKE=cBvfkURLJVVhoG8OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::10) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB2712:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a1c4f8-b847-4e8b-1008-08de8f2583ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5EIbZlnWYI/bRZ4NarzBzHtCBipUCvgzZVMT2SRetKBOZx7hVAMKGN9KmezXZZNUOFkV9N2o75VRD0Y4aLNZr7o00dPj2OhV07OONNq5i55KyIVrbEteykk0KaGqK8H07S46K4NoKlnBKuVkMO6OCT9crzhJl58iXNBfPhzznTgZ79FQidvL0X6ToOgyh4K4LgtyXzdftt9TDdQipxOcKLBP2uDzQDW3RLckebQ58ft5cqO8bAUhXvrt4KIWUcaf/54MhZk1uVHH5rUvqDpU5prMqsCL3rm5OS0rGeSEzVdMxwBX/L7V+u3JgdxS5+sC0xGmRx9HuJifGP+0v6yxpjQZT0MvZM9SISsoUy5Ytb5IEGNT+n7dqLK3MykjZSgPJ1G4/S0PZY6ypmUaNSJ2sl5W1+5v2uZcqYPv/sJrp2/dCbIK2swfsmq/RyDJN6HV5ebfKhhhePVE6Gqi33D/d42lwzwUE+sEbBhyQP7Wj2KxhIfOgyWTGBwMN9Q9ThqsJ8CC+VUWUWnYy2s/YJxEscS5iZw1Xw+qFKlqzxiM1Dk7PMfSwVr88nw2HNuPgQNEtXYoVjZmO0fGfQZPbi4iTaoGT6NGOxuWH2PjhbZf0aCS5tNWDKP8Yfsa7nat6ILUPjWqAARYx3OCPDJ4tICDUG83/BSffzJotdZfG8smfhOGTj8r9bIxPHTFz0MulRTamaB0FKNWsX453MeXpQyGvjeHm3MtsWf5YKWh3fB5PBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhEYjBDaGhqVHY3M28rMGc3Q1NnMnI0ajV3dzhzZDJnQ0dyd3REODZmSmti?=
 =?utf-8?B?Q05ybnp6R1RUekl0UVlla1B0VDZNNmFhMEp3VWV1Wms4ZnNMckJTb1A5Nmlo?=
 =?utf-8?B?ejB0cElrZ09pUERaUnNHZWtvZTdndCtVakw2RHRyclI5U1Rrdi9uTnB2cHV5?=
 =?utf-8?B?NVZ1aDJzREl2MmZxYUNJWXlDK2NGU0dta2VyalloaGFsRy83QzVGOTlYZytm?=
 =?utf-8?B?SDkwK3VrVkdrOVluaEgrS095QXh1ZlpvRGhDZXIvbGpQaUJqTFZ6bzFmR2J6?=
 =?utf-8?B?UFE1SGR2MENmYlpEWlN4ZEVKcWxESTdTanhQQzluUmFZUE5sOHUvN3Mwa2Jm?=
 =?utf-8?B?amdZZlhRbGdIUnBCVzdpOTlSZzlndk0xcmNhUDhLVDFDN1NHc0MxMHJyNmNl?=
 =?utf-8?B?UGcrUmVBNnVSTCtTWHJpNFluUU00bitGYittTHlzU1NxUkNwaHRjclpwUWd1?=
 =?utf-8?B?dGZZeGtzeDRaZ3dqd3JVczdzSWtzY2NCTTRWbWtGVEVOTWQzR3lXUldHUFNi?=
 =?utf-8?B?M1dveTUzeVhuUW0vbklZY2hncEJBOE90NkVmY0VrTlhQbEovMG9IN1FraVRS?=
 =?utf-8?B?eHhQMWRGSmZ3SzgzcExLend6UG9WZmFPbUhhRWtQYUFYM2VVZnF2RGs5WGo4?=
 =?utf-8?B?TkZxREdSYXg4c1YzZGJibnJRQnlmU2xrWmZSQzFXVm9HMEMxamZFaks1bEpR?=
 =?utf-8?B?VkRmNzdHZ2tGMk5QQkYxbjh5Kzd3YjhFSWMzMlZ5VytxWEVBWXg3NmM3T2h4?=
 =?utf-8?B?cUhOeEFDM3U2Yng3WUR4QlpTR0VtcHNEc3dKbGJRNGM2QmRkQ29LZlhvbFN4?=
 =?utf-8?B?aitoekRxV1B6K1ZkaXBjdnpLbWdMZWZvZUNXVm4zUEJIemd3SS9GUlpNVStT?=
 =?utf-8?B?MXczdWM2NWdlNUN5WnU3eXY0bG9ubVRjNVgxNFh4eWQ5WnBpcXpIb05RVXhW?=
 =?utf-8?B?Snp0dGNyRm1BUDhJQkZRd25QRjRaL3dHNzh1b1cyZGtIMHpkTDVNQjY2b3JK?=
 =?utf-8?B?THd0eFpZazFNQUhKM3B0OXh4eUFkK1Q0WlRCZmpwbTVrV1VqTmhMWmJCU1Js?=
 =?utf-8?B?SWtxYXRGTitpdVladWZ4aVQrWVZNTFFHM2JnZlU4dkEwSkd0OE1taXNFbS8y?=
 =?utf-8?B?Z1dQbGJ2Y0RVa2JHWCtIdDBrN0JkUTgrVkc4czV6cy90dHZxYTI4NmxZN2RH?=
 =?utf-8?B?Wmk4WjJHaEdKM21xTG1uQVBtWlp6NnNFeW1jWHo2K3B6VFFiRTh5ZEFrVDZ5?=
 =?utf-8?B?dTZtSXQ1TzVQaFBteDJaNkVrZHdrd3pkRU8yclM0SFZtbzNvTmRPdmc4QjB4?=
 =?utf-8?B?Z3BUYlRPN3lUbVVEWmI0dWV6WWZ3NnlpUmgyNFhqSTdXdTNkdFEvK20vR0JS?=
 =?utf-8?B?c3htRU56Vjl4VXhrcHJ3N0JLTUQzNXAxUVRaUDNhSEtyWVI0Q1BwTEVhd05M?=
 =?utf-8?B?b1VURHYvQjR4eHZjeXV6eHVFejF2Yk5zaFlxMGp0NjBCTWNsSVlwemxKeUUv?=
 =?utf-8?B?N1IweWtQWFZNeHJhRVBRRkJNZXhPZXB4OUMrOWk1bzVOUDYrNEd1c3RnOXcr?=
 =?utf-8?B?RXp3YUlHVjJMUlpmdEhiWTl1NE51bjZoRkM5ek9DR3NsY3plYlcrL3kvK3JI?=
 =?utf-8?B?bmhhd2NqREt5SnZWWmhVTVplaWN2RE5kWW4xVGpyNCtienU5NVlJVko0dExs?=
 =?utf-8?B?Z1A2MTU1aDJPRkUrOENObzNydDZGYjcySnNRczRKZEsxc3VXeEg0aDRhT2ow?=
 =?utf-8?B?bjlpeFRpY0VFR2FlRUFvY09RMWd0Rno2VWdHYzk2T3haRktURDNHSCtiM2Fw?=
 =?utf-8?B?TXVGSDdlZkloNHdhT3R0bmtIRkNxdU9ickZMZFdSRjliTGRFOTJBUW1JQ1Ev?=
 =?utf-8?B?T0pFc3RkUHBxR0ZVSnBxMnZqbXFLbUh4RHhnVE84ekdSNkZ6YmFXd05aMU9p?=
 =?utf-8?B?eWQ2U3hMMS9HVDA0b0pwaStrUGU0MjBseUhDMTRpUkhRQkdoWEpVekJDbmxw?=
 =?utf-8?B?dllybnZTVHFUbU4vc1lybE5qRnBTMk1TZGIwWHhqY2NZcHF5bGQ0Zmg0N2RM?=
 =?utf-8?B?dFE0cVI4dmdkVlFnQWNNREYyME45c2FjZUw5akJPU0RLTFNEL0k3MjZyMkEx?=
 =?utf-8?B?NVNrTnRPZlU2VHpmMlNKbTVaQmxjWm5UZmppelZwV0F5WGZERjJrU0N4a3o5?=
 =?utf-8?B?WitOWTJRZE11d3pkb1ZEckNBdkY2UTMxZnFoT2tnOFowQzh6K1JXYVJqVktH?=
 =?utf-8?B?SGNhT3hVZ3dEMWRxV0ZHWG9nZEZjN1J4dkhldHNTNnFzbzFOeVNQS0poNWk1?=
 =?utf-8?B?eTBiMDZ2Q1pOZDVZUlpMaHhqT0pZOGdVaTFPZGZVQTRvc0tSK3F1d1RYMFo5?=
 =?utf-8?Q?z0GGb6s77YCEzk5JTyQROmJwtq94Z3tCwjnQYlIbEsWOC?=
X-MS-Exchange-AntiSpam-MessageData-1: UhNhUkUCpg+1spy3mYCVktEvut9PKrfS7aQ=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a1c4f8-b847-4e8b-1008-08de8f2583ab
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:00:42.1657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugOBrC08PCVjclTAYnuyQNRYfQl3TADgkzlJVigjESGCdqmGUYR30RUtKU5oVTHDbVEdvSGgSr/kb/Cmzt7lstahSeEVQHYUeyBK84CjJgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2712
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

Hi Raymond,


Sorry for this very later answer.


Le 20/02/2026 à 16:18, Raymond Mao a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> On Thu, Feb 19, 2026 at 8:26 AM Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
>> Enables the support of ecc in mbedtls.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> ---
>> v2:
>> - move ecdsa to MBEDTLS_LIB_X509
>> - enhance depencendies
>>
>>   configs/amd_versal2_virt_defconfig       |  1 +
>>   configs/qemu_arm64_lwip_defconfig        |  1 +
>>   configs/starfive_visionfive2_defconfig   |  1 +
>>   configs/xilinx_versal_net_virt_defconfig |  1 +
>>   configs/xilinx_versal_virt_defconfig     |  1 +
>>   configs/xilinx_zynqmp_kria_defconfig     |  1 +
>>   configs/xilinx_zynqmp_virt_defconfig     |  1 +
>>   lib/mbedtls/Kconfig                      | 16 ++++++++++++++++
>>   lib/mbedtls/Makefile                     | 16 +++++++++-------
>>   lib/mbedtls/mbedtls_def_config.h         | 18 ++++++++++++++++++
>>   10 files changed, 50 insertions(+), 7 deletions(-)
>>
>> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
>> index 0344089030c..702bf28405d 100644
>> --- a/configs/amd_versal2_virt_defconfig
>> +++ b/configs/amd_versal2_virt_defconfig
>> @@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>>   CONFIG_TPM=y
>>   # CONFIG_OPTEE_LIB is not set
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
>> index a974970c3d3..ab6302b67eb 100644
>> --- a/configs/qemu_arm64_lwip_defconfig
>> +++ b/configs/qemu_arm64_lwip_defconfig
>> @@ -11,3 +11,4 @@ CONFIG_CMD_WGET=y
>>   CONFIG_EFI_HTTP_BOOT=y
>>   CONFIG_WGET_HTTPS=y
>>   CONFIG_WGET_CACERT=y
>> +CONFIG_ECDSA=y
>> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
>> index a754134a313..508bd465704 100644
>> --- a/configs/starfive_visionfive2_defconfig
>> +++ b/configs/starfive_visionfive2_defconfig
>> @@ -156,3 +156,4 @@ CONFIG_USB_GADGET=y
>>   CONFIG_WDT=y
>>   CONFIG_WDT_STARFIVE=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
>> index 323b5606566..8b760beab03 100644
>> --- a/configs/xilinx_versal_net_virt_defconfig
>> +++ b/configs/xilinx_versal_net_virt_defconfig
>> @@ -154,4 +154,5 @@ CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>>   CONFIG_TPM=y
>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
>> index 652121e27a0..6dd8620cf51 100644
>> --- a/configs/xilinx_versal_virt_defconfig
>> +++ b/configs/xilinx_versal_virt_defconfig
>> @@ -168,5 +168,6 @@ CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>>   CONFIG_TPM=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
>> index 8ad05e37189..d23452e96d0 100644
>> --- a/configs/xilinx_zynqmp_kria_defconfig
>> +++ b/configs/xilinx_zynqmp_kria_defconfig
>> @@ -219,6 +219,7 @@ CONFIG_VIRTIO_BLK=y
>>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>>   CONFIG_PANIC_HANG=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>>   CONFIG_TPM=y
>>   CONFIG_SPL_GZIP=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
>> index bb79ddf989e..01370a215d4 100644
>> --- a/configs/xilinx_zynqmp_virt_defconfig
>> +++ b/configs/xilinx_zynqmp_virt_defconfig
>> @@ -237,6 +237,7 @@ CONFIG_VIRTIO_BLK=y
>>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
>>   CONFIG_PANIC_HANG=y
>>   CONFIG_MBEDTLS_LIB=y
>> +CONFIG_ECDSA=y
>>   CONFIG_TPM=y
>>   CONFIG_SPL_GZIP=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
>> index 789721ee6cd..8bf8809198f 100644
>> --- a/lib/mbedtls/Kconfig
>> +++ b/lib/mbedtls/Kconfig
>> @@ -242,11 +242,16 @@ config MBEDTLS_LIB_X509
>>          select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>>          select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>>          select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
>> +       select ECDSA_MBEDTLS if ECDSA
>>          help
>>            Enable MbedTLS certificate libraries.
>>
>>   if MBEDTLS_LIB_X509
>>
>> +config BIGNUM_MBEDTLS
>> +       bool
>> +       default n
>> +
>>   config ASN1_DECODER_MBEDTLS
>>          bool "ASN1 decoder with MbedTLS certificate library"
>>          depends on MBEDTLS_LIB_X509 && ASN1_DECODER
>> @@ -264,6 +269,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>>          bool "RSA public key parser with MbedTLS certificate library"
>>          depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>>          select ASN1_DECODER_MBEDTLS
>> +       select BIGNUM_MBEDTLS
>>          help
>>            This option chooses MbedTLS certificate library for RSA public key
>>            parser.
>> @@ -292,6 +298,15 @@ config MSCODE_PARSER_MBEDTLS
>>            This option chooses MbedTLS certificate library for MS authenticode
>>            parser.
>>
>> +config ECDSA_MBEDTLS
>> +       bool "Enable ECDSA support with MbedTLS certificate library"
>> +       depends on MBEDTLS_LIB_X509
>> +       select ASN1_DECODER
> This should be ASN1_DECODER_MBEDTLS.

It was my first try, but I reach an issue.
If ASN1_DECODER is not selected and we select ASN1_DECODER_MBEDTLS, 
there is a conflict because
ASN1_DECODER_MBEDTLS depends on ASN1_DECODER. So to avoid this issue, I 
have kept ASN1_DECODER in V3.

Regards,
Philippe


>
>
>> +       select BIGNUM_MBEDTLS
>> +       help
>> +         This option enables support of ECDSA with the MbedTLS certificate
>> +         library.
>> +
>>   endif # MBEDTLS_LIB_X509
>>
>>   config MBEDTLS_LIB_TLS
>> @@ -301,6 +316,7 @@ config MBEDTLS_LIB_TLS
>>          depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>>          depends on ASN1_DECODER_MBEDTLS
>>          depends on MBEDTLS_LIB
>> +       depends on ECDSA_MBEDTLS
>>          help
>>            Enable MbedTLS TLS library. Required for HTTPs support
>>            in wget
>> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
>> index c5b445bd85c..5433e17cc64 100644
>> --- a/lib/mbedtls/Makefile
>> +++ b/lib/mbedtls/Makefile
>> @@ -39,13 +39,14 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
>>   # MbedTLS X509 library
>>   obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
>>   mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
>> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) += \
>> +       $(MBEDTLS_LIB_DIR)/bignum.o \
>> +       $(MBEDTLS_LIB_DIR)/bignum_core.o
>>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
>>          $(MBEDTLS_LIB_DIR)/asn1parse.o \
>>          $(MBEDTLS_LIB_DIR)/asn1write.o \
>>          $(MBEDTLS_LIB_DIR)/oid.o
>>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
>> -       $(MBEDTLS_LIB_DIR)/bignum.o \
>> -       $(MBEDTLS_LIB_DIR)/bignum_core.o \
>>          $(MBEDTLS_LIB_DIR)/rsa.o \
>>          $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
>>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>> @@ -57,6 +58,12 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>>          $(MBEDTLS_LIB_DIR)/x509_crt.o
>>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>>          $(MBEDTLS_LIB_DIR)/pkcs7.o
>> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
>> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
>>
>>   #mbedTLS TLS support
>>   obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
>> @@ -64,7 +71,6 @@ mbedtls_lib_tls-y := \
>>          $(MBEDTLS_LIB_DIR)/mps_reader.o \
>>          $(MBEDTLS_LIB_DIR)/mps_trace.o \
>>          $(MBEDTLS_LIB_DIR)/net_sockets.o \
>> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>>          $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>>          $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>>          $(MBEDTLS_LIB_DIR)/ssl_client.o \
>> @@ -82,8 +88,4 @@ mbedtls_lib_tls-y := \
>>          $(MBEDTLS_LIB_DIR)/cipher.o \
>>          $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
>>          $(MBEDTLS_LIB_DIR)/ecdh.o \
>> -       $(MBEDTLS_LIB_DIR)/ecdsa.o \
>> -       $(MBEDTLS_LIB_DIR)/ecp.o \
>> -       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
>> -       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>>          $(MBEDTLS_LIB_DIR)/gcm.o \
>> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
>> index dda3f4dd6e4..7d60bcc52aa 100644
>> --- a/lib/mbedtls/mbedtls_def_config.h
>> +++ b/lib/mbedtls/mbedtls_def_config.h
>> @@ -89,6 +89,24 @@
>>   #define MBEDTLS_ASN1_WRITE_C
>>   #endif
>>
>> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> In the 'mbedtls_def_config.h' file, we use the kconfigs without the
> '_MBEDTLS' postfix.
>
> Regards,
> Raymond
>
>> +#define MBEDTLS_ECDSA_C
>> +#define MBEDTLS_ECP_C
>> +#define MBEDTLS_BIGNUM_C
>> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
>> +#endif
>> +
>>   #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>>
>>   #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>> --
>> 2.43.0
>>
