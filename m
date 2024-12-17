Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE8E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05CD801F9;
	Tue, 17 Dec 2024 12:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S/h11if5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629CD801FB; Tue, 17 Dec 2024 12:05:59 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3053E801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCji5hM/SyqV9ysixHf/0fqFDfFZVzlixFzYLWBNy05kXBC4wfbvsXExZgRfWXW3dnzKuWvSqlBemdQUH6nfBYm5iH5Y0pCbib3uO74y7bjRPh2Ynw3oODZnjYQ7OPkhxo1FDGAqVppvHUFvFG1vNEN7o0HeX6vM+zVqaPb3mm3B/0NiQMJLTrPMO1GfpRiRYztiP4MXkSwz2DNcyEVhbvVmBZuVllIyt58j2negmVqCWVehGTn+tr8JqhSBw5MK5Gl8SxosjrYNu6xGjVUuYVEfOSWMwDD5oOYUcbVZSj9bc3/PlroBB3cJIKxZLQUw0HvEicmo5rNTujPvLUKhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL6t73/drfsYeJ7qV7ipz1TgGqWCBcWzhN2w8ipw9Zw=;
 b=Xy/2Ui6ol8U7QwmeiUsCSIs+QVoGqHLzziOWFxdYAuoba1YWZycg+WL358MBfwRKaOPASCE2Jb2WthQQOHZsjTrU8C/I6guuh46V2qGgm82BVL0l/uKQDWZttrncV1tUa0csYy74ug72aHOphSuJnCKbNyh8CkntpjGBcniH6CSVSsXMiIwNoYKCLavw3dv42J0BiNhorQvvnbl1NNhZ4zT+KjmcJAdNq+LU69JRyLG/hT8EO2awb1SUEZcXGWez0u+mT4qk02ZxcxH3zxyGW3ocWPPCZ24f+j3ugoqBwxZeXI5CX7ts6oYLorALBlhU3IrKPSdJ3eNf4ZIrcFCDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL6t73/drfsYeJ7qV7ipz1TgGqWCBcWzhN2w8ipw9Zw=;
 b=S/h11if5ndQeRIQX7Ov+dfLLjscyqBz9eSldIAS4kdkCOB4ORGMK/d99ENo6pyMhRI0+s9HlqcvU07mSlA24p7Z/TINUCarLF2F5q4mcZfhEHpn/UNhSHoa6oUVrjjZSOCTXDeevMipHCrjkyyRbyDUUuTHlkZoHid2qow+gUdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 11:05:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:05:54 +0000
Message-ID: <8f4d4092-7c97-4f4b-bb81-3104ac47fc7d@amd.com>
Date: Tue, 17 Dec 2024 12:05:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: add clock-output-names property in clock
 nodes
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <1080e31393c3e1b49735b77e7ddc14d570b83222.1733991159.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1080e31393c3e1b49735b77e7ddc14d570b83222.1733991159.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f35622d-5202-4086-b53c-08dd1e8ac694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUQrUW95OXRkdkR2bysyWEUvajhYR3JYdVNVVWt6bnpjZ2h4cXUwMGdtSG9o?=
 =?utf-8?B?RXZRTmdhVyt5QWdmNDZreThrZUxQQ3pnQVZJUFZneThrOTFzM2daMjZxeENx?=
 =?utf-8?B?cTB5Wk1qZ0F1V2ZuRVRYQ3ArRHhNYVRDRytGaXNzVzdOYllQOThMU0h0Q1N4?=
 =?utf-8?B?LzcvWDN6dGdoL3ZDZnRHQVhmVW1sNElWMXZWajc0a09OQmtuUEJXM280MmR6?=
 =?utf-8?B?bWRFNzhYaHZuaTZUQ1lRcmRaS2V2T0Vjd0pDNVU0RHpsVitUcTNPanNDQWFW?=
 =?utf-8?B?SGpocTZJN3FMUGJyUi9iWUhlMmZoQzhhNFBkVDlmeFQrU21md21RZWxtMzdW?=
 =?utf-8?B?ZUVtOHpGU3NFVyttVFU3a3pybVVQYzdNazB3WXJKbk56RndmQkZmZ2M4K01D?=
 =?utf-8?B?Nmd3a2VkYjJXb2RPZ1BqZTRUeG5rcCtBK3kyWXZRYW43NklvT1k2WTc4R3Zo?=
 =?utf-8?B?bituR3FzRXpCVkxxeXZSeEVuZXFTU3pXc1Z4bjA2OUxuY0EyN0ZVRDVyOGVR?=
 =?utf-8?B?MGlFRnBpR1VMR1pQTkZSK0ZSc0lscjlVNHdMSWtvRXRuMEpiQkVoZXZSd1h4?=
 =?utf-8?B?LzgyR3JSeG9FeHlmYmtxWGZzUlNJRktZMHc1WDhwckhQL0V3dFRUSFpNZ1NC?=
 =?utf-8?B?VE5yNHo4MFhZTCtqeEJVNmt2UTRuRXJnQWhpUklxR1g0QklyYXlFWGl2QWx5?=
 =?utf-8?B?dkV5VXZjaFpQUnN6Z0hZM0xxdWl2N3FsNy9JZXdCQVZJZmJsTFN5K2pXNFAz?=
 =?utf-8?B?RXQzUEZjYUhDWVNOK2sxZVZZc1A1QWNwS29wWWRPd3RrVXhUQVd6elJuRmlG?=
 =?utf-8?B?eW8vdlF2bUx1ekJ1cGU1eDh3RW5Ea2VrSlZxckFnMU1TNDNWVElkcUZmRnZ4?=
 =?utf-8?B?elVKUlQvWnB1SzRTWXFwQXppbzlINlo4bEdjNlhmVzQvdkJIVVJJUzRnT0hK?=
 =?utf-8?B?NkFoMEMvdWRLMUoybWpqaEV4blh4ajJtUnVPa1MydW1uNzljT29WMGJCMGVq?=
 =?utf-8?B?UlJlNGFNemRldUVkUytjWTNSTmdFdXlrU2hKWFJKcTZOQ0JGeXhVaFFQVXRr?=
 =?utf-8?B?WXRoU2RQU0l2dHp3SDF3WGRBdUppNHM0UGp3Z2JSNFRjVkdDRVFpM1lrL2NU?=
 =?utf-8?B?d3l2cUV6VHQ0TUx0bXFFa2owWlU4bldmM1QrV2tPVExoaERnOVY4NTlhSWVU?=
 =?utf-8?B?eUFuelVRTnlGUTRrNkhmbytvMGo4VjZqSHFzRHA0aHdmbDdpeEpiWWJDeGxZ?=
 =?utf-8?B?S2dJMmdYOVh5aFE1bE10SnZYYUVKWEVnRk5jSmJQSXpEbVVkMjRHOEkrQmNZ?=
 =?utf-8?B?S21CQmUySFV5UnROU2xwRnJWd3RtdW1NdmNTYkxVVEJnNXhqOWhpSTVZdXZp?=
 =?utf-8?B?MUkzdW9Nbmcra0J2ZUJWUDlCYktkbHRTV1A5eG5JdWMvaGxWNk9XV2kxOXJy?=
 =?utf-8?B?QXpsMkZubUJvN2orcUhNMndXUG1HVjJFL0pUV1puSWNwd05SUDRycEUxbmdT?=
 =?utf-8?B?ZjAwYVdmRVdIeXZTRVRZeGRSRlplVTZ0T2JadnZuQWFuSkEwY0VRcE1YNUd2?=
 =?utf-8?B?T1V0aEY3U3JMR0tIRHlmRXZFTUtZY0ticHM1VGZMQ3A4RXJTVTJkVzAwSnIr?=
 =?utf-8?B?Sk9RclJUVXlkaFdGWUwrZkdQVHV3NDV5N3R5ejRUemNUdHdnSTlzcmZmNEpo?=
 =?utf-8?B?QUpGQlhXVzBjMXc0QWpWUHJVMjNFaC9GY1RkZ0FFcFhHRlRiNkw3UENGa2Vm?=
 =?utf-8?B?eGxydjBRa1RpWURVWGJ1T2ZNY0w3Um5vVzBoYk1lMFRpalFvQy9nRVkwN2Zm?=
 =?utf-8?B?c3o3OFEyS08xNCt0RUE0VGJqU3V2Y1NJSkQvSFNQdGR5ZE9KanJqQ1NhNWU2?=
 =?utf-8?Q?R1Jf047oCW2s8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtJVWJKU0lkUEU3b2RlUUdWQXA2bWVLbW8zQjlhTnNtZGdBSlNLZ2d4L2o1?=
 =?utf-8?B?dnE0YXNlMEs0Yi8vM0ZZVHJpZmcvV0JQSFVsWDhvT1BtbEh6SVNocnZvditD?=
 =?utf-8?B?WTJ5TU4zVDViNnJmdTNSeEYraUdIY1k0cEN6cWM2MDk2cEZ2Tnk3MmlZbTVI?=
 =?utf-8?B?R2lVMnNQdWxxK1Q4cW9oQ0p3Y20xWTJQLytHWTZWWVpNSUk0Y3FBSS9LWVBU?=
 =?utf-8?B?TjhsRjE4VXFSTUZacnc5clhPNXlFdm9wb2ordlNRY0ZUZkJmSHhkSzljem1s?=
 =?utf-8?B?Uy8xREtnbnVQWmk1WFV2amF0V2ZNbkdXcjhRUmN6OXVCLzRIL0hJb3F3SnBp?=
 =?utf-8?B?TkJKZHBjd1phdERlNUIvaFFaaDBOa2N3Ti91cXp2OVozbVVYRjhOajdkdHd2?=
 =?utf-8?B?cU05QTFpOFoxYVNYOU4vR2pWelpsR09md0h6RlBRcG1sTkVWckxUMVdGaGZY?=
 =?utf-8?B?c1QzeUxxNzZnbUpURWI3N1lOMVFvV2N5OFhUM3M5b1F1bk5nUUlqR1B0L0FO?=
 =?utf-8?B?QlkwQldYS2wyeGRDME0rQW1mMnV2cTY3anlCMndvR2NhNVdCT3RHSG0vaGYy?=
 =?utf-8?B?ZzNZSDYvS1JzUFA2QWJaMnJiQTZkTUgzdUdYc1BMUDlTcW9GRnFKR3ltc2dm?=
 =?utf-8?B?OEtUTGdmQmdIQ3Uzc1BqOHBMazN1YU5Vb3cvUWNEbXVLZkJWMHZRa215OGVM?=
 =?utf-8?B?VGNNYXVqUEQxWHBBQ05UZGVMckpBNmdqSEpuT2VSR3hXd3BYY0NJM24wdlBv?=
 =?utf-8?B?bnJJc01DV2k3aWdiQVJvV0RmVnByVi95MFZ3UFk1Rk9YQ0lJVkpGdkxNaUxU?=
 =?utf-8?B?M3cvUXgwNkgyYVdsRnloQ2FkV3p2MFMvTGFDbXhpdGdhNHNTaVVpaUV1anJT?=
 =?utf-8?B?MHYvK1ZTaE9KTmRycUlQelpnMzZjOUZGd0RxWktNdkQrVWVwU3NNUzRRV000?=
 =?utf-8?B?N3FKc3dVbXhBbTJSYmJCUFJLWWlIZ28zSVh4dHowczVBY0ZnUkp3c0RBSTZs?=
 =?utf-8?B?SGUyTHBZeEdZV0RXMFRId2NtWnVxT1RVQmw0RnpIb2Y0VkpGZm5CUy9PVnVa?=
 =?utf-8?B?RU9GVTRTRnVJamVkdTlvZ3VqaUFUR2ptclhZbEZhbHNvZzdsR0N3eWNlOUJM?=
 =?utf-8?B?N3JueitBRnpDOHRuVHkrTW1DSWVtQlBGVkVUSWttN1pRMXIrOWM2Y0FndHpi?=
 =?utf-8?B?QkM1ZCtnVWRMUHI2SVg2K2sxYmxPQTRWV043b2t3WUhmYkZUQTc3cnZQWjBn?=
 =?utf-8?B?YlJ0Umt3WDJ5M0NzV2VObjdxOTR0bmRMRE1DbjBlQ2dDT0FJeTdsTVNTUFEw?=
 =?utf-8?B?SVZudUZzYzZmRlc3OHlNZmV0OXd2eWZ0dVI5VjY5VTRERHFId1hzcmRvZ1hh?=
 =?utf-8?B?OHJQYkJDSk9yaUJwTURUMlJkdmdkRmZKbzdTN28xdE5vaVIrc3Ztc3JvbWlu?=
 =?utf-8?B?RUw4OUdhVkRENDFYaXBSWjRQZmJPZU5Ba3loZ1dEdmM3Z09MU01ReEdsZWRD?=
 =?utf-8?B?MFRvazUvb2d1NHJHY0d5dUdzK0V6U3J3ZElWQ2kvVVFvNFVVT21IRlYwZS9I?=
 =?utf-8?B?T1FsTnN1OGx3TEZxbnA0UnVHU2ZHaGlQc0Jha1JETkpTbUs0alFaWVhnVXlF?=
 =?utf-8?B?UDQ0WElhSW9TdjlvemZETnJmREJXcXo5OXpvc2hlMWtISDBPbXFXR210VEFx?=
 =?utf-8?B?eE1kNi9XcWp6ZVg1ekZNcEFGZ2dnQTQ3TDNaRWhaNjYzclRSOWJlTkdidXlS?=
 =?utf-8?B?L2ErSUgyQmV3RmJTaDE4NjNaa0JEYU5pRCs3alV5M01SSXpzcmFNaHltT2VU?=
 =?utf-8?B?MXJIbUI2NWt4VmduTHd5OWVwalNseHlBRHlqWVpvcWlXME5rdnJBcXZtdE9v?=
 =?utf-8?B?YmRxYklCVGt2MkZLbWw2MUltUEltTFVhaytGbzVualhkR2hoU3l5cU9nTzVu?=
 =?utf-8?B?VUU2V3BuZnIxK0Z3ZU9KRFNBZ2pnYS9TdVdqR0x6clErWU9OZS9SSndUTjAz?=
 =?utf-8?B?enFaU0tjcEZEa1RRdGpyMy82TE4reU5ib3hhc0EwNUszRDlDdUk2WCtjanR0?=
 =?utf-8?B?UkgvVzRTYzc1MW9sUnc0QzU2eW50TXl5RDQxNDg5RDVXMk9PUWY1YUt3cTVV?=
 =?utf-8?Q?IcHHLmxZojewMhRm2F+nvfBmw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f35622d-5202-4086-b53c-08dd1e8ac694
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:05:54.4953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyHqddsa48qgwP9e46rL7mCawZ8p++hGChNY636kQgHnpOpYGr0qnZzGrIRex2R7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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



On 12/12/24 09:12, Michal Simek wrote:
> From: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> 
> Replace underscores with hyphens in the clock node names as per
> dt-schema rule.
> 
> Also, add clock-output-names property to all clock nodes, so that the
> resulting clock name do not change when clock node name is changed.
> 
> Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> Acked-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> index 60d1b1acf9a0..385fed8a852a 100644
> --- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> @@ -10,39 +10,44 @@
>   
>   #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>   / {
> -	pss_ref_clk: pss_ref_clk {
> +	pss_ref_clk: pss-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>;
> +		clock-output-names = "pss_ref_clk";
>   	};
>   
> -	video_clk: video_clk {
> +	video_clk: video-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> +		clock-output-names = "video_clk";
>   	};
>   
> -	pss_alt_ref_clk: pss_alt_ref_clk {
> +	pss_alt_ref_clk: pss-alt-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <0>;
> +		clock-output-names = "pss_alt_ref_clk";
>   	};
>   
> -	gt_crx_ref_clk: gt_crx_ref_clk {
> +	gt_crx_ref_clk: gt-crx-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <108000000>;
> +		clock-output-names = "gt_crx_ref_clk";
>   	};
>   
> -	aux_ref_clk: aux_ref_clk {
> +	aux_ref_clk: aux-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> +		clock-output-names = "aux_ref_clk";
>   	};
>   };
>   

Applied.
M
