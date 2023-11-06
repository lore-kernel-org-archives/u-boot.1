Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22B0C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51FB86564;
	Mon,  6 Nov 2023 13:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8VDeHCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF5C86844; Mon,  6 Nov 2023 13:43:41 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27FC8864E5
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU0q1zLYl1hZAV1S0VjDS5ZUIcZFP7a9i+F7sJ/DtB61wVTR1N920i6pedTPomvt0Db5AXocRxbzdvNVe5o3/wGmHpRd0Q6xKY1ZNp2jeoS1OfvjqrMaktUcN2ykWHYM6SUjjB7oo35zO5XCiQqjpRbqt11IEHZz+oYXaKCjE/Vr3nt71c7FOd/Sl7VoTVW99COTi4Flr1hAKfTTJagnTPAcFB5J96O5IIDptI9O9W0GIlT7DZVfvMFUz0CHVCvMlQpHfPaCGc4svqiVtn9jDIJePuAlb6wgH06BTLRqoAa9jYdvql+JRqzc6i0S22ODR3zl/w9yBId4ji2UGob95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7oh57p6a9PwDs0g4SkdNPi6shiK13zUAta2PT5GsUg=;
 b=GB9urj6+7JzRBv6yp2hrrAA1do/HI5aJ66dZDz3VsaG6QOVdtKBid5/WAF9PvL55WCya+tVq4aiJiawwTX2U3bi5w5d2gNfUZtm01wMK2mV4zf7HorQ0Tg8AOH+1yDtTcklhtTHd3RCu+eJVFeqPo2bffYeNZXvaclrI8P026E+04mE7qymz6yjqROj3BaOLqSV8gzyzivnS614RHYmz2M+3ZsjvbJnnY/gAhq+4tyJj0/jp09emzBJlsvwYXdKUggPksomCCiZAjuDlBPFkX3/rt07L67qjQ+BvxFqU/cc9OU3/BqnGBQwhQ6Um5KMh3+9tLQfSSpYEpJvVBemh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7oh57p6a9PwDs0g4SkdNPi6shiK13zUAta2PT5GsUg=;
 b=k8VDeHClc50SZh6hQF7EcPo/4WvS9HpKMM/WmfiK1mtHoQq1VHZ05FKfJ54KFN0Ainpb7hbPa/onmAPD7g7BwQVncFWkFcVV+oRY+goEacnEPPh7qd3aH5A+Phq1NZ0kI73trdEd6IvgSZyVXAPm+RsvUHvo7g4rpzk7lL4PCRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 12:43:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:43:33 +0000
Message-ID: <9b8b441d-e6e3-49bc-a2c1-816a0d900f88@amd.com>
Date: Mon, 6 Nov 2023 13:43:23 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [RESEND PATCH v2] xilinx: versal: Setup 30MHz as default spi
 frequency
To: u-boot@lists.denx.de, git@xilinx.com
References: <c1d6ebd659f3002649b1200c926f8b9ed3132085.1698749448.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c1d6ebd659f3002649b1200c926f8b9ed3132085.1698749448.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2cd73a-592e-4e92-4c16-08dbdec5fc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oqYIrv2tbbkjQ9o9UcdvnKivR9ohF4pe++Ra5m7ihkT/SqO85I/EqvrxMQKg3Ja7DIvBx3NTwHdmKcAs3dZN8DPhwXXtD19/t0e2aA4p+2mgiMeYQlqvJGJrsf9soNS35zAXlqBS5KEao0oFx78wJ3TYj31tek+KqWoOBnzGXE7yHOwDFuiOpjLkqlbbjcx9O6iDSTw0aa9JW8tXn7OfZsLtQ9PzT9wEz+71oXqa2QZSXHVevOON4IAhqEbNM8Fvk5yXke6IGEXLyUhNNoaClFIga0oV6kLkPBNcP3K+ZjhVsqE0BWUtvEJi6sINvU0aLBM9O/h69dm2SubeWkpn5UDCWXHhJycUvMfj0LjgvdOeE7yq/ao4O8tU/4O7nktIQu4SzK7yZHgZKJhUz7sABo0fitPXyllhLIoMXm1nZDxRIzQcugDwznyucpk42BdfeVboLwGOoH07RJ3crd5FFYSWVJDiL0dNF4LwuYIWJlX6WNsoNZbOVX8OQW2dzXIFeCz8HNCocSMJwTWMOcLU6X6UVAbVlpO/p6DB2bPKYwdcxoaLYlIW7lGd6oZ8Cf97kuZJ08C7epJ2zk5GhnSy4DY4tvvI9qOD+O5nFwkDGXuQBHFVzRbseKQhaZOA47Yrcxp+xAtmFL3ZwdmEsvCQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(53546011)(6506007)(6666004)(83380400001)(6512007)(44832011)(8676002)(6486002)(2906002)(26005)(966005)(478600001)(41300700001)(5660300002)(8936002)(66946007)(66556008)(66476007)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dNdFg5dXR2QjgwRGo4NFpWWlNGbVNvY3RieDVjazNXU0NmZ2VvMm94dUdW?=
 =?utf-8?B?UnNlTVRoMW5CSXlUbkdSa2tKV2JTTkxieHMzUTRnT1FBaG9reEdsN0QrZ0k0?=
 =?utf-8?B?VWxnZDcrQUs2VVVvNTJ3KzMvL2xwN2dQMVJGTUJwN2NreVVzb3FXZ29STlpt?=
 =?utf-8?B?NnJaSmFEVmV5S0lNZGtJSm1qUEc4VXpkKzFFc3NjbDY1QlZ4Y0RVQVgxdnhr?=
 =?utf-8?B?RGd5L1lHc2xlMm5oY3pqZFYwWFJua2VwY2IvNzhiUERGWFJNRGdoVy9scUNy?=
 =?utf-8?B?MzFhRytFbHI4T3VDNGNLVHFNV08yS2FmRTFKWDA0Ulhua0pmSHF1bWgrQUtN?=
 =?utf-8?B?WlNYcmZJNWVuUjZoV1k1TkNRYjJ6M0lhMWk0b25SU3laZUFDV3AxbjNOSlZw?=
 =?utf-8?B?SWVaNG1yZ0IvQlRwWjJTa2RCeExmUko1Vmt5ejRweDAyMzRhSjc0N3VackJD?=
 =?utf-8?B?NFJ2VU94Z09EMDB5NGdSSjhkZGtka2ZnUmhJOFAyVXhVamRRUXFXYU14emNX?=
 =?utf-8?B?ejJEQjlHTFVVbFZTdmFSc1JRbXNiVFpVZ2dJd3lyZWRGMjJJVzh2ZlhyeXpi?=
 =?utf-8?B?UExtdEtSVmNBVmhRSlBrWW1MenJyM3lkY2pnaXlBbGtlNEkySXZsUm5vQWJE?=
 =?utf-8?B?emhLMTRvRW52dmJoUiszN1BLOWVoNWM1Q0t2eXVibytKMHZmeVVjVEZYR3F4?=
 =?utf-8?B?Mk1TeWpLWW9Xd3Jpc3Z3alI0cG9HYjdPNjZ3TFVCZVdpZHNwd25NREpyUmVx?=
 =?utf-8?B?b3BKSmlnTzMyWWRRM0dGRVhPZ08rSzJOdGY4QzVCandjWXBpek5NUGxOci9p?=
 =?utf-8?B?dmZ2Nzlab2NWcDUxeVg5Nm1sUE5kc2w1TVlGZ1pTRkpDb0RSOHAzK3g2Vy80?=
 =?utf-8?B?MDFNL3JnMDA2UGd2dHUrQ2lWL1BmTEVHdFNUODlKc21nWGc3YnNjNk9OM29D?=
 =?utf-8?B?MTM2UEVwejBtcFJxMjVNY2hPeGZkOHo1bjJlWlpjMVhrRXppZkNCWmtSbTVn?=
 =?utf-8?B?RnowcTRyejRoSmJ2eFFEd1BHTlQ1ZTdXSndqbmh2a3UwM2pDRXBnNE9HcGc0?=
 =?utf-8?B?WHpTbXp4VlpTU0hCMjljaU5wVWlZUUp1d0FIcWI5WU14U2IvQmdaNmdwb0RP?=
 =?utf-8?B?NWRLa0hMRi9ta0p1VnVNVlUzaWxYekZrMTRnVzRPdUhzU25rZmRuditjdTZ1?=
 =?utf-8?B?Z2hBZ09kNTlDR3ZSK1Bad1Z3bDlwSkNXTjExeUFpdFh5bHFyVlV1WHQ2TCtH?=
 =?utf-8?B?NHJyT2dvdjBIT3ZkRlNkb3o5bkh3VkhFSWFFTGZWMlJQMDkyUFRCYlBMcU43?=
 =?utf-8?B?VFVIaDk0KzQ1cmtFUENwVFk2Y1MxQjZjb21OMGJ2TDJlMVBvTG9uZlZLMm5j?=
 =?utf-8?B?c1lBOWFxa1ZjMXBka05KazlGQlNoUUtQMGVib0FaOUorblRSQ2JieUdpRnli?=
 =?utf-8?B?ZUhNbWphSjI1N2lONDExT042QzZqVElYVHo0WjlidllKcm9IOXBLVFhidkMx?=
 =?utf-8?B?VG1wRTVvdDhoWEhldzE0NGx3bVd1YXBkY0ZQdDBZYkNDZWhFY1l2dDRGSUlS?=
 =?utf-8?B?Qm81bUEzM0lKM0RHMkV2cHpEcTcvdEUwZExucWgwQ21PdTJaNlZWdkxrMmZa?=
 =?utf-8?B?MmtJTTg4aENuU1RHNnZ6clJoYzlsc09oc1VGTHBuS2QyODF2elZVMmdmWGdz?=
 =?utf-8?B?RHBFMEw4MVg4UkFYNTl5SmRydVRwZXlxZjVmejVJcXZabi81R0d2cWZFUVp3?=
 =?utf-8?B?U2JCbTRIKzNtcmxURkNMVEgyZUJxME9YL25UOVJLYWxsV2JmQzZBWCswejJy?=
 =?utf-8?B?RHNJTmZiNVF0OHdPRlh5emRJcjJxSmhWbDB4WndQTnRpRTlVUmZuS1llMzdo?=
 =?utf-8?B?WUYwdVJKdmNVaXk2UHBvbFRDVUd2VG1vZlJSVlltTU5ZODJHTTlpL0FvZHVt?=
 =?utf-8?B?RXR6NDlwRTFmOTR0NHM1bkNwdENoRmdBSU1BV2FTZElNUHNxY1o3RXg1UFNK?=
 =?utf-8?B?TUdsbkdOeW1Nbzk3djNoZk1TckhUS2RTTjJMR05zbTRuTEVTdGx4M2FqNU1T?=
 =?utf-8?B?TXBVbjNNVWFqUmFvTHpmTVdENVlsZ2hBU0FRZmtRMXV5TjVaTFRLY2NBbGx5?=
 =?utf-8?Q?2HL9F4qNwB8QezyuEXiS3qPcz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2cd73a-592e-4e92-4c16-08dbdec5fc50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:43:32.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOfcLuDP8pi81B+r3cpVmiMgshNKgl94xj3WccDfosh1w7TkiRTT3sDj8PjwbILA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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



On 10/31/23 11:50, Michal Simek wrote:
> Align default SPI configuration with ZynqMP/Versal NET.
> There is no reason to run on lower frequencies.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - sync Kconfig location
> 
> v2 didn't land in lore.kernel.org but it is present here
> https://lists.denx.de/pipermail/u-boot/2023-October/535418.html
> that's why resend it to be able to have link to lore.
> 
> ---
>   configs/xilinx_versal_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index be86d446cf46..276ec2526ba2 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_VERSAL=y
>   CONFIG_TEXT_BASE=0x8000000
>   CONFIG_SYS_MALLOC_F_LEN=0x100000
>   CONFIG_NR_DRAM_BANKS=36
> +CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-virt"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y

Applied.
M

