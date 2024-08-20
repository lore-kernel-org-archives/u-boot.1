Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E202CC531DF
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 11:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AB8883A4;
	Tue, 20 Aug 2024 13:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lSthrYh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0F488A3C; Tue, 20 Aug 2024 13:51:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7341886DBD
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 13:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2KTf9Njct9EBKzyfFAdMtLs5I3nqsRCWPpyJG16ZEaPBhTttyahyDpnHZe0Iga+IfVlwbqCZ6VBj6S6lI1Q1hXE2mtEy3vkF8a27JXGEQuQROeLeJGzQjxnjlMHDmAwo61Vr/AQ+SMqMx2OFZPQOcBsYcegk0roDb+nPqu2vffp2O5AZUDkR1FSuYBlPBBhJ29FTL7h3KFJmksgcuR/WL3KHgg+jNooH7diLVGcSO7cG31FRmaW1KayPj9sOJvfD0kdMQirzMKsYkRi/pEEGmrZBP72pPletCGhAncZ//ga1NOCwwGpW1dQ7yn53bpuWAO8ZhuLKT5iPQPXRksniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsVhJhFiGeEf3jV6+L7otS0MD33aXgx6KNJ+CC/bX88=;
 b=KLhO9l5x/IPbfUZvHBbnoN40LYn9Bl6qfv8tA3RRoT4HZnFEAEZiOjJRpGKE33rZK6ySSd7brBkTQtwLRsRWWwwjIfSiJEErEn60s4O+vPlhnYegBWOmwHAUUf7ztuqlUWmvX0AS3831uTwCnzI47DFwmSXDX0TZhnhU5i7gjCkLviHGtRxSw1JUCsb+BkX2x+Tx8VFGFozGOQl1FXvGyHw3tuE0d4Ki90GEyajuqr359o/GN4HiVhUha49E1EBIXDhTjeu6KRMGRjpVbU1T0nlBgyBaerr8x0qbUeV/2uc37A3DLufw/LU3prPXq3i2d1UEUWcESuzzS98Kjf2GLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsVhJhFiGeEf3jV6+L7otS0MD33aXgx6KNJ+CC/bX88=;
 b=lSthrYh9DOS0Ka+AnfWdqPYjve7ixVXKeDng4kMQQGMYGIZV/PXMZDo0U6hh5EVgByunFGH074nTviLKTiyztPaP70wz+CFCrXCZwr7YrzGIf4cpetcXyhdTQqJXj27j+A8oV0+j6k0v2tfYJq3zuRqCafaLa2KYsXtq7UXsWrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:51:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:51:48 +0000
Message-ID: <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
Date: Tue, 20 Aug 2024 13:51:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: clarifying i2c_get_chip_for_busnum()
To: Sahaj Sarup <sahaj.sarup@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 39aaf742-b968-4326-dbda-08dcc10e792a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1l0UlU5cWxBUHJqbGJuZDRtYTRTbzF5dCtFWWZhOEsvbW1VMDArYVQ4S2xO?=
 =?utf-8?B?WkFsUWZCUTlNaERXY3JMaTdWVTlSRVBna2g4MzhCUDY2ZVQ1ZGVwbHBTbE5C?=
 =?utf-8?B?ZFNMNFNSeThpVUN1ZjNsYWV4UEx4Y3ltcjRHTytLR3lpbXYwems4cUtBWEdv?=
 =?utf-8?B?Z0VoY05aZFlFZnNlenFKTUE0eUFwSWR2UXdSUjh4WC9vRjBmcHJreHBTdU81?=
 =?utf-8?B?d3Qzc2ZnU2FRSlpnT2NreXNMalpsSGhIVkxMeXMxR1MyK1NUakMvNXpJWTFy?=
 =?utf-8?B?RTIxVDJtWXBRZVBuNVJJZ0NvYXc3OTBrdS92T2QwcUpqTFVPenpEKzR3UzN0?=
 =?utf-8?B?UWt2NWtOdTc4OFFNWmpWbGtLTE9VVUxOSDU1VXRtcmlDYTdhdVFWVFJaRGpy?=
 =?utf-8?B?SjJ4NGViYVpITWlEZUtaV0pGYk5kS3AzaUdyNTV0b2JXSll3SkZDMWZYQjRk?=
 =?utf-8?B?bWUyWDA4ZVZqZUZ5alFRS1d4ZzB4UnNQVnNwYXlsTXg0QXl4RUJ5djFEcHhl?=
 =?utf-8?B?ZnNhaFhSYm80K09NV3Z0T0pDODQwYUpTOFh6emVGcm1GNHZVNm9FdDVkT0Fm?=
 =?utf-8?B?M2wyejlqYXBJVWFEMVcwaVpuNklRYmRwcXBRNnFDZS9Hdlc2OG41V2NNRXVZ?=
 =?utf-8?B?YlU4ZXVtSHAzSFVvVExud1Z4UXNsMitMOFAxN3hEaExPUldCL0d2dmVqbVRG?=
 =?utf-8?B?cVQ3Q25LcnkrYVhaL3JEbGtuTmVJR2VQQkRaL2Uzd0ZHNHF5bGNNZk44RXNO?=
 =?utf-8?B?bTZoMHJqTjZEUE1laHloZVp4ZGJyT0l3Sk44RnRIeXpNMzNmeS90TXVrMVpI?=
 =?utf-8?B?TXEyYjNDWXZkblRmMXNyUXM3a3RmZUFNcFlzb3pmeVhCMnExWlhvcTVlcmFC?=
 =?utf-8?B?S0NQVk51akNFUjFwQXRia3Q0Q28yM2luajRYY2FlR0ppNEwvdWJRV3lpajlG?=
 =?utf-8?B?WUh5TmNQcnNsRVo4M3BYaU8zVTlIeDl0MDg0VFBISkZSeHJQdVB6VFVtKzU0?=
 =?utf-8?B?ek9YaHl3cHNWZkZZSFlaaU8zME5GeklkKzFYcGdOZ3dpQSt4R3BWakRGZndu?=
 =?utf-8?B?L0JPdVlnMW9sR3h1cHhMOUpla1NCbHRxWkFvWmtsWUcyR0VMblVZZW5XelIv?=
 =?utf-8?B?eEFDMnZFMjFvaTBOK3FyUkh0bEpYTStTM3ZDSEJjY0x0WDRxd2lqWHFDOU1t?=
 =?utf-8?B?cjFnVHdGdVQyUEIySnlIZHZXeTJxSlpzSVFBWnI1SmFVN2NNRGc2NlQwdDhI?=
 =?utf-8?B?SU85a0NWcm41cWh5NDZkVEJOeFBmTU5iWWlqNnFVVm10K01Tbm1DUC9XUXoy?=
 =?utf-8?B?V2U1RTQvRzdZMGY4OTZBMmZQTi9CUFd0dXhtb0htZ0M5QjlIMktWUkxLMUQ4?=
 =?utf-8?B?OE1mWTlxUFoyNEZXYVJ1QUJRRVlBWHk1OER1ZWhhdmZxMEtGN3pHY2FERG9n?=
 =?utf-8?B?TXFjZ1htSmZyamUrd2ZSb3lGMFVWNjNMdWFjN3VsdkdOVTd4eHBic25ZcUlS?=
 =?utf-8?B?OGZGSGdFalBXMktab1V0NFJXcEhsWU5uaWVmVmtXdHpRdzRoQ2Y3cTE4Tm1p?=
 =?utf-8?B?bEZRNE95R2s2c2ZwZzA5N05MdFY3R1lqTmxPQlJ3aFBuL3oyelRvVEpBYmZP?=
 =?utf-8?B?b2lxNlVWd2szMVFUTHhOdGd1SnJvVVd0V1A3MHhrVjlIYmIwbzVaWFNjK2Np?=
 =?utf-8?B?VHdTRDBXcWs5VHkwSnpKV0E0ck00em50bkZ2bzMxa1Q1N3U0eGdCVmgvN3Y4?=
 =?utf-8?B?SHB5cHdZTDMwcHl6NEFveVNHbUhmNkJBME94dlg4REFNUzV0U1Nzd2laVUtW?=
 =?utf-8?B?MjRIN0JRa0VzUmNpcUV5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkp5ZVhhSklrVW8vY29wa3hoMCtDRFlDWnR4amhPK2dDTmNWN1RnZE5UTCs4?=
 =?utf-8?B?SzdBYWtNV05FY1ArZWppSlRRSzhoUTBEUXlKSWNPWHNtRkUzQmJBNHRtSzRj?=
 =?utf-8?B?WXZySkZXei9hNVBaK3UwVk9MTFkveEJwdHRHYzYzT1pPamRVdjR4c2FTNkV2?=
 =?utf-8?B?VWc5V1ROT0FYOHJHNStyK3lObExicjU3NmErdjZHRFpZTklIeDl0UVBUZ1ZZ?=
 =?utf-8?B?aTFMV3oxTjhZakxNZG1yamo4K0doSGt0NkhQbTdDYmVsZ3N5MnVWaVRsYmlU?=
 =?utf-8?B?ZWx3bDhRREFKMC85SXYxT0FsQUZ5M2VGdGlNUVJLcVFZbGttdDllclprSkhL?=
 =?utf-8?B?MmE3NU8xWTlaT1dYQTY5RmFZdmVVWFF3dzJUMVgvNlhtelVRbFFRY1pKVDdZ?=
 =?utf-8?B?SDVOOU5ZNFNlaW96NVVzWlZ6ajFUKzFtaFhnRXJCalRSM2xjM01GMEZKN1lz?=
 =?utf-8?B?bXJTRE9xbzZOSlJzbGpQR1lVc3Y2MERmYVVoeVJjUHlBRzFrQ3VmaURzNG8z?=
 =?utf-8?B?cUhOWEJJa1JQR1RXRHZDeTZUNDZhYmFwWTgrZUhhSnEyYmplVFgrcHZ2cjgv?=
 =?utf-8?B?WTZVYXp1TkFXVGJyNTVwVTdCMXpBaFo1cmdYR1RDUG0rTzV1Z05WN1dvRlhB?=
 =?utf-8?B?SGI0WEpIZ3hma2NSb0lhZWhRRGdVTDBId3p6UFhJK2g3UjhoY2FCOEczdUdz?=
 =?utf-8?B?K0NLSFNiRjRvY0xyYlRLL0hGUTF3aUptZllhdEZOeTN2ZVJjbC9vR0hjTVNR?=
 =?utf-8?B?TWtNRnZ5cmFXRTVheEdnVTFrZHBMcmhUVUhLK2V4QW5GSDlJRW13OXFXbVNJ?=
 =?utf-8?B?UHRmUzVKRzQ1cm8yclJnRGlSbDVQZlVIek5haEpUZ2UzSDVua1g4U1hVU1Ax?=
 =?utf-8?B?bUYwa2xYM3ZwMTdhVXVROXdYdlhKbzFSTWk0VTZ0NVRYSjA1OGx1NDNtRHAz?=
 =?utf-8?B?czVlcHE1VEgzcTJTYVhBZXNPZEY3Ui8ySWtkckFUWEdyWERVTVEzN1ZwY041?=
 =?utf-8?B?aU5CRDVlOVhrUmVYNWZTbGJyeU5QaU9yQVFaNXE3WVl6ODZGcGhNV3k3RzJk?=
 =?utf-8?B?VDRRVEpaSGRXV3l4L0d2VWE1NVBnOXpEaFpSZGJQalM2NCttNHIvNFB3Myta?=
 =?utf-8?B?eTBhYnVXcmJkZWhITlkrZTY4RnJRUjgyaHdYYXJNeVhNRW5zL3JJQ1dBUFdE?=
 =?utf-8?B?UnJJa1RrR0lIVVBZVTZKcS9CUmdLbXZRVC9TVG55Q0RjQUJvTlFlU3RYY3Rp?=
 =?utf-8?B?SkJHTkhUY1pxblRKZXJobkJJYk1tVFJyODFyK2VOMi96eitjUEpMOUV1Uitt?=
 =?utf-8?B?djRncGxzVzdycis1SDN2ZDRNdW1zYnllS3BWZGNHVjg3ek4zM2pYRHQyV3NQ?=
 =?utf-8?B?cnhHbjZwV2RMTi9jMy9NaWIrYUZEVXBFSkRXRDM5T3VBOXBHaFF3QTF6ekJu?=
 =?utf-8?B?c0lqUjFHbTEyaGs3cmtmaDN5dm8zdnFWcm1QM2g0YnJ6SC85V0lidURVQ3E0?=
 =?utf-8?B?aFV4c1U5RFRDa0NNUm5QYTdZakJ2aWYyUFNIeTB3dDVOZFVlQzVlSU91VW54?=
 =?utf-8?B?N05DY0FaS2dPMlUxbWRvTXpHWmViM0NPa3grQTZiVTJWbmpIRWxNQktnSVgv?=
 =?utf-8?B?bDFVc2tHbjdEYTJucnNsemxDcEJHWU15YzFmS2Z3bFYwWjgydm9BakRQS3Vs?=
 =?utf-8?B?ZSt3TDNRY3RLY2llbEI5TW1HZkZITVpBSTlHcjJ1cVozVXRaU3F4cVp5aEZC?=
 =?utf-8?B?VW1BYXZ3Y0VqZFFyNFFBSTR4RlZUTVdjSzVxVFZMbWVBNVlGanBTajM4ejZz?=
 =?utf-8?B?dzF6NWlONmpYdEV2SWVtZTh0OG5HdVgydjNiUExTcHpncWtxeXo1c3hTK3dP?=
 =?utf-8?B?S0daV3l3Qi9JdUpXcUtDZ1dJa0VlbWY2TDR3dWV0aDJydU9uWmVJTEpMc3ky?=
 =?utf-8?B?K3IzbDk3ZGJxMWFQMGpCcXRvR3FGZS9KU2hnM01NOGFEdnJ6UHltWlZMOGZ6?=
 =?utf-8?B?UjBwVFg3UFQ3Z3Rxa3BEclJSK1BBMHpDcXFMdTVjbDh1VzdPbC9GNU5mcnJr?=
 =?utf-8?B?czg1bzRhQ1pCNm16bkt4REdKM21tYVk0SS9wQXlPU1BWN29EZ2xkM29CM2Rl?=
 =?utf-8?B?YjZOSDJJeUVSRkhBbnBDMlpuM2FUMDl2OU9EWng4RGtoWkQxWEcrV3JFeTll?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aaf742-b968-4326-dbda-08dcc10e792a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 11:51:48.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVXc8Xp6f22PUJ2E+LTDHBNmzilpf+yrCW7Pf85mRS5hBb7yLNjbiJDvPc7+uY3Ipg6/5OF2ZGBa5PlRLlBO/vhBincCyFLSzhb2Ik/Q2Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413
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

Hi,

On 8/20/24 11:12 AM, Sahaj Sarup wrote:
> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> In `include/i2c.h` , the udevice pointer and return value definition
> seems to be confusing.
> 
> ```
> /**
>   * i2c_get_chip_for_busnum() - get a device to use to access a chip on
> .
> .
> .
>   * @devp: Returns pointer to new device if found or -ENODEV if not
>   * found
>   */
> ```
> 
> Should this instead be:
> 
> ```
>   * @devp:   Returns pointer to new device or NULL if not found
>   * Return:  0 on success, -ENODEV on failure
> ```
> 

For the @devp part, seems like it as uclass_get_device_by_seq sets it to 
NULL and i2c_get_chip only modifies it when a device is found.

For the return part... not sure. We don't overwrite the return value we 
get from functions we call, so not sure we can guarantee that only 
ENODEV will be returned?

Cheers,
Quentin
