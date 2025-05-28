Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E85C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B1583903;
	Wed, 28 May 2025 18:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VLFP3KHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0B183955; Wed, 28 May 2025 18:15:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3318833F6
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWEoeQrRFPwBKM3wzStEnxSXWEga4FjRTEeWPPM960ChS4mWO/ukqQ07ETZk9jpLu9RhgxtMAzM5ay2GyX1IGa7KpTCCVO7HWsLmMXKkxJvij1BN3eVCUPGk5tRGJpICXarP6UxoWDnvNiuwIT+6HI3ApOtcvk1CAt0/66NqZyrttx31XABNWaNIcYkJhDOrpTIlCGyswv1gMDPmK150A4V97FFRzykB9lOLTqMBc7iQU8gCS94lksy6tspqvOY0NN+2HGZOYmRYQI7QKTaRVvgPbI/8MqKK/YL+sQiwQGH7f329fkbbIZA3MO13072GwiCXdYhBBjsZW8cPxzZ2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/nCdAhjkLpv4lr/kucAsV6/k4ZKpE6DohjsCRzSBVw=;
 b=PkcLuvGQHFNI/2Qsw/DVxwiu53sOCCL9tz8sGyH46i4iP+isM48XJxcnTDz/7Es57AM56iYVid6xIUzy3Wvx3P18YUAEq/d7wPE+AcCq/7AneN7D2YvIbP3mag40rb1MEL8oTBSB0YyRi0NB8B25wogd5bt24/iuoxcVJyIlD18UJSf9BSZqteBNLt9PzBtfxT1fwO291FSICNy2XMh778FqTC0Gt77Ix7j0ZW+XR+IJiUHBqbJJXalohckwl6nnKFYBB9nmcR+BeVGEQQ+uWqLmRWISgm8NITZ3l9Vx4AUdTyaGNjfHc92RZSC0JZ6FDYXL5EIFitdecOcVS+DRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/nCdAhjkLpv4lr/kucAsV6/k4ZKpE6DohjsCRzSBVw=;
 b=VLFP3KHkoNC/DQlXBnYXu3r9rUu0I3egzz75MFUW47SDdBqzBOude5nES4eT1SwlA8FFQy4XNewXtIZt7TMpidRthBZSD+cRpglqxMsdiBysB3xexQYM9SfxXJjKIOUhPKwYzeTCWW23urJ071SSnk26T7zQvGINOw04tkI2gr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB10033.eurprd04.prod.outlook.com (2603:10a6:10:4ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 16:15:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:15:51 +0000
Message-ID: <85b41ac7-a478-43d3-8163-5df008cd4833@cherry.de>
Date: Wed, 28 May 2025 18:15:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dm: core: use u32 instead of int for
 dev_read_u32_default
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
 <20250528-dev_read_x32_default-v1-1-6ab1734dd7a2@cherry.de>
 <CAFLszTjw2E3v4sWNtuMc0tafLmtPMv64z=xqzbQyHSQ04NE6Rw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjw2E3v4sWNtuMc0tafLmtPMv64z=xqzbQyHSQ04NE6Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: 18af88dd-a69e-40af-8045-08dd9e02e9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHZNUW51SGlXc2lkZkFZVUF6K21hZkp2K2pRa2U0NUw1UTcrVzZQdlRpak9t?=
 =?utf-8?B?M3I4ejMzTjlub3QxalFkSlJWcnQ0cVIyb0MrdUtPTXhCN05GWEZEZlhIdjds?=
 =?utf-8?B?bVc3aFJlUTgzbVgxS1Fad1RJL2lwb3ZaY3ZiYUsreWQ5TnA0eSsycmN0MHlh?=
 =?utf-8?B?aVpCZmE1WUZwZFphbWVwOWJ1K2dyOXBmVVhPUmhnakJ6NW1KWTFvaUpGVk8z?=
 =?utf-8?B?M1cxTXRCQVRrbVVENEZGUzBYNXBwRWF2d2I2blVQZkRuejVWWi9VTU52akMy?=
 =?utf-8?B?MitkT3RjY0JWY2pTUTJWV05MOU8zaDN2M05kQmRZUFhSY0wzbTBEbTNoQ3c5?=
 =?utf-8?B?bDdteXhDajRTTzJYckFPNTl0VUpQUDdUMGtWRlRNQlovMHpPYUI2ajVVSmk5?=
 =?utf-8?B?dXBYa0V6NjF4ak1Uc3doQTVOczNETEozMVJ6QTliRWZrMGFSd3N6OTJYRnFs?=
 =?utf-8?B?N0gvdmVtTithWVBTQ0pKSEFqLzRRVUV4bEJOcFEyVk1ZanRtOWJxWngxQXp5?=
 =?utf-8?B?amV5OXZ1c3RaSGExVzZHV1R4RE5WbS9YTVFNRlNKR2dEQm1FbGxTTGxZQWtr?=
 =?utf-8?B?NVNjN1o4cWI1VTFoVkxnV0N6V0FsVnQxR1N3SFpPL1NiNmNpUzVZVjJlckpj?=
 =?utf-8?B?S290MnZwY3BZTnNzZUpyWStuK0FWTTdqVHQwMy8xbGhNRUFjcmxKOUtvSEt6?=
 =?utf-8?B?R3BZbmJmVitITGpERUNTdTlHakRXN0JrS3owOXYvcXRkdHR2NE5JVEMzTjdX?=
 =?utf-8?B?Nk1JWnA2THIzaHJmaVkwcWNET1MwMXdaVm1BZEVaU3ZiTy8rdlNKZFN4TzBt?=
 =?utf-8?B?SVROS1RFcHFxMDZrSUVUalpQWHJuakE4bjB1WVdIZ0pMSkVHWk1DQjVhNW9l?=
 =?utf-8?B?SnlQazlrcVljN1BpcTB6YXBvbU9YckdjTXRSWWNPWVNRaCt1Rms4bXV6OWJJ?=
 =?utf-8?B?TXhNTnJWRzVkQzg1NFJDSy80VUhZWDYzLzk4YWxRdytuYW1nUGJLZTgwcXcv?=
 =?utf-8?B?R0R0OEZ5UFBlWWh1ekNlRlVTRnY5aVl0SEpmVmd0SGdDcjFaVmdnajNRWnZE?=
 =?utf-8?B?d01EMGV0ZVMyZEw1ZXovalRGeUNzS0ZsYlRuQVdSQTlOZm1Rb1FPOERMZzYx?=
 =?utf-8?B?OHVzNTZuMHU1SUI5a1lGbm93eFFGN2JnSUpDQjlDM2ViOEpDM0VqQnQremJt?=
 =?utf-8?B?VXl3MTlDeUZBN09MRW9RZVhPeVlpaWJVY05PZW9oQzF0SGZhdmxkcTU4L1M4?=
 =?utf-8?B?WXRlWkNUSUZpZWUxSVFTQnVnaUZydS95REZGSnVCaENKVmFDM3p2UldIallR?=
 =?utf-8?B?TzVvUkxYaVo0WDc4alRqdjNvc0F5UXVmN1BRdHhUTHE2WFQ1d2pybllMKzBL?=
 =?utf-8?B?aXBxWE55TDRZK2xpVjNWTnRZWGpkNGdZdk5xd2ZUemlVb2t1MWlIWDhzUXJ2?=
 =?utf-8?B?WWJqVytYS1pQRnd6dWYxOEdyYTFEVFZySk9XZHJYa2o5UHFFbVNqKzZGN01z?=
 =?utf-8?B?NVRILzM0SFo4ZUE0ZHEwaVplNFc1SE5tS0JmQUhRenI2S2paY2NIUkc3cVdt?=
 =?utf-8?B?bDNZQTdSYkJyYzRrYUxoMm5tU2lOam9SZkhneFlrMEo3UlVEem1XMW1EdXZ0?=
 =?utf-8?B?TmtpYVRhY1liQ1ZYeDVxdURVd0dYamxBRG0ybnY1QTZpTlZRNjVxd3VPQldB?=
 =?utf-8?B?dWdWL3FaL1UyU1Q2RUJ4c2VtbFJmRmJXV0ptZ2FyV1dGQURGS2hKbk1RVm8r?=
 =?utf-8?B?ck9JaGNaWjZFTGk5Y3phMmlIc3AvcDBpaC9DdVlvZndWY0t6T28vcjZXNmZ0?=
 =?utf-8?Q?jPy1OQ9ZQHrWSGGXU2J3Cxr4dKfFsSgmSYw+A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjRlWGdrOXlCY096ODBFYTdmczZMc1psRTNmalhTOU5RQjhuL0lkK3pXME5S?=
 =?utf-8?B?d2hxc0xoaUpvZEhOQ1cvaEZDa2k1YVJHTU1XNkc0SURtVGRtajJtQkJxWkxB?=
 =?utf-8?B?bVpMaHhKSnhRWGp0NXIyZHhOVWxJcFBkRzNoMmQ3djQzTS9XMDVUL3UyaHV4?=
 =?utf-8?B?Q1lMRU0xZGVoeEQ2aTdKS3JRUzZyWDhXWE9yRmtzZkxYQjBBQzdMdWo0S05F?=
 =?utf-8?B?WCtuMUhMSnpzdmlDWHc3S1J2bWxWODU2aU55eDduTTFpTmFRNU85bVErbWd0?=
 =?utf-8?B?VERIVklnQ3d3ZG9UUE1zVVVONTkzSlQ2WU1pckxTWmUvUHhJamIyY0o0Rzg4?=
 =?utf-8?B?cVdQV3JDVTd4d1gvVWEzbTZJVm5heFcyU1JNd2xRRnRhVDFGTW1oWkIzK0FS?=
 =?utf-8?B?ait3azJBWlErNitpNE9ZMHNDaTdQaHYxOFJ2RGZqQ3FZQUZwT3BLTTN0U2sr?=
 =?utf-8?B?TkZ5OVFVRGFtb0tjNk1wd1dJemM1clN6MUsySzlBUnFvVjhUVkNhaSthT0to?=
 =?utf-8?B?MVpmRnhTY3NKM0dKdGJLL002eW5SbWNHakFlMXZ2NGRwb3JFUm5nU2xLMU54?=
 =?utf-8?B?bjJKeVRUU0ZNVkQ3K1BBdXR1bXFDcmVyL25IVTY0RVNXd0N2MlBzTXBacHZ3?=
 =?utf-8?B?NEc2b2lpL1RjM0loVHNyRysxV2lKWGlySEZDaXBsWFppMEFPZFcyM0lYZTRB?=
 =?utf-8?B?SStTd1hCZVJreTluYWhYTkpZS2xyRlhXSnlxQ2ppQmlUelNtSlZCVFZPOGp6?=
 =?utf-8?B?aHIzSVYrRmRYM09YZFlGRlV4SnpSdlF6Tys2UjJGcjRRcTFjNndKd1J6ajdq?=
 =?utf-8?B?aXhVUDRrQXlFM0luMEcycEtOeEl1ajdKNGV5L3hFcG12MGt2YVoyVks0Z2Jt?=
 =?utf-8?B?aGQrTVFyVDNpN0VPWExXcFdJU21JV1VKSlhSMTU1Tk9senAyeUxiZmdDN0Ny?=
 =?utf-8?B?V2FXeXBud1FucmRXL093a3NVNVUxWUl1dHUwUkNJUFczd3FyRmRsOHFscmo1?=
 =?utf-8?B?OVZzZkkxZkZmZUJKd3I5TW50cXg2ODhSQTNoS3VEdmFJVWw1UFNudWZGejJ5?=
 =?utf-8?B?cWxIeXdJSFcyZ2ZtS3pOLzRTbzhES0IyWXBRcGlJcit4MXBKSldLakt4L0xE?=
 =?utf-8?B?RERRNmdzK0drRmRFZmVkVkl0bnZsRUZTRVZMNEhOakxHeWdOOGI4WElVSGsw?=
 =?utf-8?B?S3NXb09PR01QVkdkUTdoOVAyOTJBd3NCOUdZNjc5Z2FXOUVBWk9kWWIyMDNu?=
 =?utf-8?B?YWptUnFCU1JZWERtWXJCZ1RuekxTUWJxR1BIa0JFNkVJN0c2KytYbUtCN25U?=
 =?utf-8?B?SjB4WFpPZCsybWhSdE15YWJWL1JOaDRBRUJkbFc1cEtDd2Q3QUVJa1JKSDdH?=
 =?utf-8?B?WjQwQjUzZFVFSUhFUEU5aTVOeTZ6dEpRZmd4R3Y4KzJwRlRyRGJnWlZNOEtK?=
 =?utf-8?B?WkNFeE8yWUtRWnFNN0xFRktFREFla0hrWUY4bnlvUmVWeDgvVnE0d3RBQU9m?=
 =?utf-8?B?VmduNDZuRkRZaUs4bzQrR0x1RVlJZmxCQXZVQWhTbDM0TXlHNGJCVXY5MHk4?=
 =?utf-8?B?bVpYYmJSYVF0QzRTOHZEdmEvUFB4VEpVQ3I4bVNEZ3h0YlQ5N1ZLcmdGQ2hB?=
 =?utf-8?B?S3lmcU5VK0FOOVpIeFBlTTVlU2szUkFxUmRBcWRQUjZRS3BLOVJhMlFLLzRa?=
 =?utf-8?B?ZzR4Nm1aK2gydTJ0UWg0L3Z4UHhudEdBZ1Vkd0pmNHRIZm1vVkt1YUJPRkla?=
 =?utf-8?B?RCtJMWZVSUpYV0JoYSs0ZVRua1F5SDhaTVJKc00yT0hZT01zRkE4RUF3UjZl?=
 =?utf-8?B?VlhkYkt2RVhUdGJFVzNNSThZTHNyVWRsOUJYdk14ZGdudnBoOTErWmdtTlJJ?=
 =?utf-8?B?SFJoSUJiZFI2MGgzQjZPMnBOaXlMSFN0Q1UyU1hTOTU4YkVOdXExZktBK2Nh?=
 =?utf-8?B?VmpKdmQ2b0h4dWIxTFByNUNHVlluek1oaXg0SE5ndnFjK0k5RGh0ZlFlV0xK?=
 =?utf-8?B?SzRPd0ZaV0xyUkt4Uk90VmFvaXYyM05nK1lpL2c1UmtPS01udm9hNUErZWwv?=
 =?utf-8?B?K2VOVEQwbG1OV2ZpeG8wZjNydFV0RDEvTFg3YW1kc0J4emh0VXhMNjcrQXp5?=
 =?utf-8?B?ZmxNSmE5SlBOSzZtcXVGdnltU1pNWC91Y25MTFBIL05ic0xHOG9UR2JuOWRp?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af88dd-a69e-40af-8045-08dd9e02e9e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:15:50.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFqk9Cf5MhbA58Ght0fGjeapwW7Gl5b/JOkQJVeJEtNJkVwMq+VUk8ahaajQSra3bQ7/SCLWmFYdWhnsC+C+iKb1ftNhfYzQajE9lHX6r5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10033
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

Hi Simon,

On 5/28/25 4:32 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 28 May 2025 at 14:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> dev_read_u32_default is for getting a u32 from a Device Tree property
>> and allows to take a default value if that property is missing.
>>
>> Considering it calls ofnode_read_u32_default which takes a u32 and
>> returns a u32, it should do the same instead of using an int, especially
>> considering that int size is typically architecture-specific, as opposed
>> to u32.
>>
>> This incidentally matches all other dev_read_*_default functions (except
>> dev_read_s32_default which will be tackled in the next commit).
>>
>> Fixes: 47a0fd3bad38 ("dm: core: Implement live tree 'read' functions")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   drivers/core/read.c | 4 ++--
>>   include/dm/read.h   | 6 +++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Re your comment above 'int' seems to mean 32-bit on the toolchains we
> use. For example, in global_data we use int when we want a 32-bit
> value and long when we want a machine-word-sized value.
> 

Fair enough, the only thing I can say - without real world experience - 
is that int isn't guaranteed to be 4 B by the standard? c.f. 
https://en.wikipedia.org/wiki/C_data_types#Main_types

> In general I try to use natural types (int, long, ulong) where
> possible, to avoid the compiler masking values before calling a
> function, which can increase code size. In this case I could make the
> argument either way.
> 

I'm happy to reword this commit log to be less confusing or alarmist. I 
can remove the "especially", would that be enough, do you have something 
else in mind?

Cheers,
Quentin
