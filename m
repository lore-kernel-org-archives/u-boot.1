Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4072FC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E344484C5D;
	Thu,  2 Jul 2026 11:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vpLnc2Ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA2884C7B; Thu,  2 Jul 2026 11:10:07 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A9D80398
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQx1n1aCXHLGFYFdWzOfcDO3sLfdryyhMVz3KfJuW2COJz7L3YSxO40H3Vgb9TRVfSbNi+LJWhN4cawzBnDMmPE/O4jscfByQZVeuPIkfrw86CCGVy94Hny+/7UvKsh0WvYXI2a9hH/rSUFWuvG/7MGwQheeFGWjHRdF2uOhwWHC5QbS6N6NnrJSqUBGUpSKPOJws/NfDDLjg1vXA5gf4eEduXjOwQCV8GNgSOXTHHWuAwQaIWCwVvtK/whmBkMvZrdqs0zrqK3VmwwHhz/4MFTzgyW6XgAy3bZ6XOkV1oavwigavu7q7w3o09Z9SvhRCP29rLBa1ofeiprOH/ivLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37FGcw6W8PY9mViziJGhFKLFzmSRP9xIzmxV7TAkpQ0=;
 b=KHlYugxJClZ4HBElo7ARjFinNkuJvuZ2qWukCM2cO0XCXl0O8wswsqvoTY9a5ZhYYULs5m73076htfIrQsUP3jGqr4AMoS3Qdrp3odURWNeG34Wq+6kAvy72ft1foxNycvONMSNnu75prlMLYDiZdKmnbVcRZKJdOkeTBB1buqPEuxDIRINbE4qyAo0dzJgtndTGhoGH8IzOgiRL3qdzsZE5499KEPeeM7Ri2vTKTh5PJNPvlQegzxPqvGYVbbXkLeaTolRzfln1FxBf9aVbCBt9qwSHlJkpqSPHmjYpBFlymKdsjYd3SRMmK8Uml+Vw9JTZFNH5t20QzM2ny8OgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37FGcw6W8PY9mViziJGhFKLFzmSRP9xIzmxV7TAkpQ0=;
 b=vpLnc2OvFdN3CuJYg6vCRMxtoHFO3VZUFEfAzNlor7RIhv8uXpI7cSrrNQk/0bvjRMFqeENxMq76OjEs1KUJxKn1B7qJcnwakeWmL8kmdGqN6U9aS6XY1KA6fEblCPBOBE77UJSe1+CtWypWqJ5zMWhf0jJOmbMicq7CBrbAsl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:59 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:09:58 +0000
Message-ID: <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
Date: Thu, 2 Jul 2026 11:09:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0059.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::9) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: efb02e55-0cbf-4834-91a8-08ded819b0a8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: IVZei8kMxhlhebjbilEYey0ls5mXNuJKFGUCvCQ18KwIIQfUWeToa9dg6n5ohqNr1X8hLaqMgYGe/8g00qDOxjXK01BFAzx1qtIyi64SRnOQMApbJZ+BKQvUXWWj2XzQIinav8F8pOCW1VLRZSyGBxvxNUewH8G8SV6LtdrBJHABdgo8AkPAlbUz3zH7wAlhxRDY6ftiTl3QJLf526h8Wc5cp+89c+FdbfG28TA24BgYwt+uiYI7MJsIa8RPiGr64ABLsOYQidOPsQN0VTSJqj/1jSFP9sXM1BM7kZtxQREuFlAWLfJ8pGEXktSs85RLgGAx95LMATkmdcHpbRYZefOtVDC6yx2CkYmaZLNsYPX4NSqx28vm/uZBjXzK3rAhNCJ6kg2G+qRXx44OR3vgd2AVWGLhguBkE3KhQp8Fv1BH15pCtkh+Xr/oF3+wNhKFisn63YxFt1x8evWKf3LsFSb0t769SOEsr20haP2CuixDg0Or//cdXYInaCn/x46G02QDY5mtuk2nx+ktU8qCz2kMGWD4HkKXzbBl5Fh/R/YzhN7lR0T8IiwX74SXTKEuT7wBn0rZFWdRRvbEWBzVVjGyzKecAiVY4m75+NpOL8cMk1CRY9Wdez3vpSZhX7zgBYURXCP/31w9jjl53rz5S+/CIbDuuT3NTcDl/ooZAvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akwrM2c1NUVCQ1JncElrMXh6cHNZYnB0Z0FlYmo1alZCRXQ4ekMxU3NRYXlS?=
 =?utf-8?B?Q1VLNmM4c0o5eFV4dlFGRHdBTHNNNitPWU45UWxxbUJCV3VJSzZkMnNFNFk0?=
 =?utf-8?B?blZNL1BtRlVodzV1RjMvQWZWR0JsT3BNRlJ6eWlFTWM1cU9BZ3N6Wk5hTmNV?=
 =?utf-8?B?NE5PTkU3U3Y0K2haVlp3eGFCMkxDUHNGUFdUamVaNGdUc2VPWCtzUVhvdU53?=
 =?utf-8?B?NS95M0FrUUdyUk9jelJ6aVN5dHFyLytNdUZuRmh2QXVGaitYUjdhZDU3RjMw?=
 =?utf-8?B?R2RGbFhMbjBoMVRLU0RPY0hXTVFHS0FxcFlPcmZhZmZtOWdKT1hnQitYN1Js?=
 =?utf-8?B?WDRwMDFFNjZOV25pRFIwS3ZFVVlzNmxJcC9YeE5kMmRpS2ZCaGNoTHNtL2JP?=
 =?utf-8?B?U2tlVE5tbE0ydlcxT1pYT0NSTWdCdWR6UU1SVmFKbm0vOFh3Q2VtdzdBZTlx?=
 =?utf-8?B?a2ZHV21tbGs3ZldYMGZrSVljMitubGpFVjJ2WnAycW5DQlBFZXFiSnA4N2pH?=
 =?utf-8?B?S3hmeDV5Rlo5eGxMVFpzRlh5Mm9qMVpub0tMRWV3UmdNWXdiQldhcjJFbkRi?=
 =?utf-8?B?ZHRMZ3R2WXBKREZmN0NyT0tMaDh5cVJJejVhdGpHNlNYb0RlbFZLWGhXa0py?=
 =?utf-8?B?TUZISEF0cHc5RS9OTzcvaW91UXMxSW9MamJPZlA0cnYzR3JEQTNlSllZNm50?=
 =?utf-8?B?M3Z2V05Cc1NVQURMcVQzN0dVZXNRYUtqS1dxeGlZb3IyT0lJMTliblpnZ1E2?=
 =?utf-8?B?RHYvbGVPSFZmN2lyb0JndDNGR1ZOa2lBcnlLdUEySXcxak5sd3Bva0c0bWI2?=
 =?utf-8?B?S2twLy9zZkFlbkJXS2FpMXU5T1QxaE55VVUzSFI0THVLWExSRnBMV2FSa1Uz?=
 =?utf-8?B?dmorMHFXMytpTU1UeWtuMDN5b2hXd3ZjV0Q2RXYyMXVFZ0FGVnFLbjhINHBx?=
 =?utf-8?B?MnFmWVBTUVF1WkVuOFdRS1FCYzNCaXlEb25LcW5tTjVRZzd6TG5WOHQzcUow?=
 =?utf-8?B?dUV4aWtscHd1UXFnWnZ4NzRLWDBFL0N0M2doKzJXazVmSktGV1NwWVJoOUVz?=
 =?utf-8?B?L1d0Z3BPcDI4bHYvTG9wQnZ0WkQyY01uWi9TTlpEeVUvS1AyT3R1WmVzUXpI?=
 =?utf-8?B?VXVVd1UzODMvOVhFbHVuRXhZNGx1Q0xzZGxPMDdGdFdnY0ZQZmhLNnZ5V0FV?=
 =?utf-8?B?NElwNW5JaE5JQVkrTHF0ZHF0RktWVHBLM3dqMW16cktUZ1ZuSVRTTnZpejNx?=
 =?utf-8?B?K1FDNm85a2p4ZDZvZVJHek45WUxleWtFM3NJQUhiTk82MzNTZmJCdHdjL1pH?=
 =?utf-8?B?STYyNmVBRkE1QkFMZlRpaGNwQXBTQUhmM2dZVHAvUkhVQS9NV2QySG1YSUk1?=
 =?utf-8?B?TnhTOFhqbHJoTGFYMitTN3RibHR5aU5Ydm1PV25ENzlRQkFLMUZBeGx4R1cv?=
 =?utf-8?B?ZGZDZUJRWnFBaEx4UkZjbWI4MEFkQzhWOTlvakh1eFV5WnllSTJaZTc2VU1n?=
 =?utf-8?B?VkhvM0hUeUZ2SjV5YVd5SGREa2kwRUJWWHVOWUNqdmVFaHVIaUFSMUFrMDRu?=
 =?utf-8?B?b2tteTYwK091RG4xR2htN0tkc0NSQ3pQUVVBRjlKSExQQ0FSa1lab2l2R29i?=
 =?utf-8?B?Q3BLd0paQkRhYTJnQ2hMOGQyRDBMVEw2ZGtEZWFkWHhxV0xoRGpWeWxHOC8x?=
 =?utf-8?B?RkJkKzlhS09JNDJvbFRXa21vSTJkMHE5NVBRNGVQNnE1andzVTIwMkFPR3BC?=
 =?utf-8?B?SUdYeHJ5S3FZZ1p0Skx6VDk3c1hpOVhNTHFzR3JWVFl1ZkNMSEREbVBpbW5t?=
 =?utf-8?B?YWRnTWgzODdYYy9YdVlGcGJlNW8xQVBhbCsyQ0I2OWFsOWduMGFwRE5lSTFS?=
 =?utf-8?B?NFVXYVlKOWpUU202Sk1OL3dCaFM5V2x3QVFhNEd1V2RwdUNmVDgyNkFScGJ4?=
 =?utf-8?B?YXY2SVl6QjlnVjR6Q2J1bW53YWNvS0kzZUlUMG9ONzdJU0tnbkRCcXZxTzBK?=
 =?utf-8?B?bituaTBFcU5leGVLL3krblN4Qysza1RsSnVzSzBieGxVS3MwNlNhbitKWHh4?=
 =?utf-8?B?MGhGYUhpUmRIWmFiN3JqcTA1Qi9pb283dTVZcmhZdWVOUzgzYXIrd3lHbDc2?=
 =?utf-8?B?d2FldFBMdDEyR1JSRFlZZkR0VGkyZS94dVdQT21ycUh4by9LYkpPaWwySUVx?=
 =?utf-8?B?M1RLNmR4V2pQS0hXTjAwQjNOTU1HRjJ6bDZvNjZ0STRlMjV5NDhJcloyd0p6?=
 =?utf-8?B?OHM5cmxFUnQvRkg4b1dSUDAvUi9jRDVkZDJ6b09SWVpsTldRcFlRN2toNWR4?=
 =?utf-8?B?NkFxUzVhcWc5ZGNwWlNwa1phMkVuMjJHVkZhZVQvQ3BNTTBnSFMwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb02e55-0cbf-4834-91a8-08ded819b0a8
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:58.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zutm7E53iCBmBXytnwLTC5SAukizNtdM4CvraNMBSRVxJa0OQDObCytG5hJBF0O/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
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



On 7/2/26 10:03, Ilias Apalodimas wrote:
> On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 7/2/26 09:41, Ilias Apalodimas wrote:
>>> Hi Michal,
>>>
>>> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> On systems with FWU enabled but without the required DT changes the FWU
>>>> metadata device is not found and fwu_boottime_checks() returns an error.
>>>> Being an initcall, that non-zero return aborts the boot flow
>>>>
>>>> Return 0 instead so the boot continues. The preceding log_err() still
>>>> tells the user that the FWU device could not be found.
>>>
>>> Won't that affect the board later on? E.g When you do capsule updates,
>>> updating the metadata will fail
>>
>> Do you mean on systems without mdata?
> 
> Yes. if the config is enabled it will make the capsule update code
> searching and updating metadata.

fwu mdata backend is not enabled hence not used. fwu just returns 0 in dump.
Updating metadata will never call any backend.

Some logs below.

Thanks,
Michal


ZYNQ GEM: f1a60000, mdio bus f1a60000, phyaddr 1, interface rgmii-id
eth0: ethernet@f1a60000
ZYNQ GEM: ed920000, mdio bus ed920000, phyaddr 0, interface 10gbase-r
, eth1: ethernet@ed920000
Cannot find fwu device
Cannot persist EFI variables without system partition
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Hit any key to stop autoboot: 0
versal2>
versal2> fwu
	FWU Metadata
crc32: 0x0
version: 0x0
size: 0x0
active_index: 0x0
previous_active_index: 0x0
	Image Info

Image Type Guid: 00000000-0000-0000-0000-000000000000
Location Guid: 00000000-0000-0000-0000-000000000000
Image Guid:  00000000-0000-0000-0000-000000000000
Image Acceptance: no
Image Guid:  00000000-0000-0000-0000-000000000000
Image Acceptance: no
versal2>
versal2> efidebug capsule esrt
========================================
ESRT: fw_resource_count=1
ESRT: fw_resource_count_max=1
ESRT: fw_resource_version=1
[entry 0]==============================
ESRT: fw_class=ED9E7FCF-47B3-40CD-B6E3-565F14676D82
ESRT: fw_type=system FW
ESRT: fw_version=0
ESRT: lowest_supported_fw_version=0
ESRT: capsule_flags=0
ESRT: last_attempt_version=0
ESRT: last_attempt_status=success
========================================

