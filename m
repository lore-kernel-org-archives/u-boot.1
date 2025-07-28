Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86182C87FCF
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4428A82EB8;
	Mon, 28 Jul 2025 10:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n615aT9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D32182F14; Mon, 28 Jul 2025 10:19:40 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4C382E52
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 10:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIjQntAdO04JrPnIW9XwmFZnT5hr9BHxObThN5hGIxaSBOG3J4pkxyuJsWIVmIcHQqYufBCFk49f/4ilDUzr264fcVJwXocKbWU9DeVVvJ8zgG0zKmzX6Po/rtE4m4ysw9+R7Kak6E0xJuH4rnl1nVDT4LSwbspeQ2aIeVYBvLOCSjITsESxEguGK4tivi5UhzyMxfYdBq2mKvxuOu/2w61JIGv5EMsbsyetL2dedKgIemn6ybPAwAG51xq0HoQdn37vuTkByofHCizZaoMnbbJ7z6cpv6IaPR+oBsO9brLhX/rDS11rnIYposD0TU35VH2ZCXAgyZrUuGIZ5c1euA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSpXHA1K1XaINHzmSy+zIE3qbtDYNMD6NvbIUF0qoQg=;
 b=amPZest1Q3SteRM/Glk6y5w7lwuc+A5kzi8PsJVVJjrUWmfxzNvNKO//0+TBgClbIF5GKc2hj9bn2OaUP02dVEDo4+84Xc02YQ0ZR+cu5Xccn33OwsQYFOnw2INqaudZQ5cUH+/jbZX+k1sk5WiJXibn84BN+hH3lA3Ok+3gsKQuLmeIwFsVA7kkL7IJ9y3vpXmgLe8gulznHRis790pgiqSqXlaa/GgNYmO80tZ/nRPO5nLGGeZtbzVzVtzblJA/4OUKMZK7rAvMUdABfD4iTM+GwvJ1nZoKLv/yusx2vEr+9bicjwd2nrj18jyuLWc6xk5BWrDvo1et/ihSFjOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSpXHA1K1XaINHzmSy+zIE3qbtDYNMD6NvbIUF0qoQg=;
 b=n615aT9TvI2LhlLTVQqe+3k36KGmDXYHCyytErAEjbBsODxQbObLodHd3AbeZhbGEdPY0I3i+5Kshgayf170al9qGGIs8D4ZBsZvhUoKe5YqIaiTVTSRTzvCes1GupLkbfNYNGNzmCNzW+9Rf5JZDn2e9nrZXEooqKQxoKKI42Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:19:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 08:19:32 +0000
Message-ID: <b33e3834-b0db-4940-8f39-e76b173e4bc1@cherry.de>
Date: Mon, 28 Jul 2025 10:19:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pylibfdt: setup.py: Drop license_files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>
References: <20250725151821.2067853-1-trini@konsulko.com>
 <ad876397-a18f-42b8-ab84-47282b7a4f48@cherry.de>
 <20250725155720.GF1807455@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250725155720.GF1807455@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5d78fc-b0c8-41d2-4ccf-08ddcdaf7b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlhraXVhOFZoZTRXd2xFMjVVYzVyZi9KcTVpaGtrcDA5SG53UVRXVWd4WG93?=
 =?utf-8?B?T2hDcnEwZWRQTGZLYnh0cGU5N1RZSExYY1huOHdSZ3BlVFN5amtEQWgrZDVN?=
 =?utf-8?B?c3JEZHA2Vm96ZDhKd0xnZVgvdmVVNVRqOFZqQU5rdUdNRU8xOG9ENThLejc2?=
 =?utf-8?B?cC9sbTFhZkxoaUM1SUh3a3ZiWmp2ZmdkY3RHQlF0SHFxWGxBcTRtdC9aM3Rq?=
 =?utf-8?B?UGtEODNuMENDd0F0YlNkaytrbnVJbHRTT0V0WDVJckFmYVRUK2RROXNOSDEr?=
 =?utf-8?B?ZlZudXNIWTRMVFNSVldLVXVONDZYejdLMmxhZCtMVEN5dTdQcmxMT1YwLzJi?=
 =?utf-8?B?bnRrcGFRZnA1YlJub3IrcmFsOWVBRlp6djdwTDZCY2w2R2t1cTNrRVhjQTdP?=
 =?utf-8?B?bW8zdnBCelhXTENZT2paWXJ4OW94VWtRMWlGajZVeFlBSldHZnlyN09DYmRW?=
 =?utf-8?B?dUxFVG4zVjY1SDFTVGhLY09aLzcxZXVpbjFhdDRzQUhzOTRXK0dwaWxud211?=
 =?utf-8?B?ZGtYQ0FsanVoSVNkbDlXNEh0TVhiQXE4dzlQc0JUNk9PbjZWa0dFV3hUdm1D?=
 =?utf-8?B?S0gvcTBlRHMyQWlKSklrZ1FnZEdHckRKOXZjMmVSWlBNaUREanFqaTR6d0hO?=
 =?utf-8?B?YkRjUXhBWHVRejE2UHZpVFpIRWJPZzZpNXpHOWxyOGhPcVhwVXhVVGF4UXln?=
 =?utf-8?B?d1M3dUV6MFBjNEZuVTB6YnA5SUoyRU8xQnNLS0ZpTjh5WEY1VkVRNXRKK0E2?=
 =?utf-8?B?MklZZmQ0SzNpQTd2eGJ3SDZCMC9RcUxZQVU2ZXJJZVZaM0hhQm5lRDMyNEFU?=
 =?utf-8?B?eHdvWWVCMTVIUkNFTUduTEtQOFAvWEREYU5UTy9PRGhWblFFcERyUEFtUktD?=
 =?utf-8?B?a2I3MHM2Z0RsZGwzVmpIMXBxcjBOSlBQN2UwZVQybzNaMlBOQzRSdEU2c0hE?=
 =?utf-8?B?UFlxTVZsTnFzYk85NnpVa01KS0JvMVdka1JTY2xTdmFHL0U1NHF3cFZqMmZu?=
 =?utf-8?B?eWh5NG1xYW5KTDVoRXNtRDJHQ3E3RWgwZzIvL3VIenBHdlRUSDhZbW5kbXNx?=
 =?utf-8?B?WWVtSW9vRVp4eUdXRVBhWkdqL29uTXJPVG9lMDl4aG9ESkViSitCWFNwc3VK?=
 =?utf-8?B?MDR4RS9mQjIyeEx0dExPWkhjMGtPQ0FSUnZtbHpiTjdXQkxrK1ViczhVMU5s?=
 =?utf-8?B?Y0EvWUpnb3BRSzltWE1WVzFhNXFMbzlZNWJRcjduU2JVOWY1SFViZkZxR3hE?=
 =?utf-8?B?WHhVZkZ2eXZRcTZkZnBhaXVDQnJTNUhvcjE0QWJUb2NBZlVrOXlIWmtzRjVQ?=
 =?utf-8?B?bHY2ZlpvWFlkSFNjcHVmcHN0aDQxY2hNRXZuR09tazhGU000dFpEN05wN0ta?=
 =?utf-8?B?U3orWTExSzZ6VXloUjVINll5THVIcnVBREkwRHQ0OFF6VCtUSFFMZktIdmd1?=
 =?utf-8?B?REkzMXFjU1p1NXo1UnMvZ2pWMEdBZ3U1MThBVFhSeUk3NUpBOTRYblBGZXBr?=
 =?utf-8?B?Y2Ewd2tiOVpiRVQybjlidDlpZWNjNFNNVkhXOVFtanFEWTZaeTFZR3plQkdK?=
 =?utf-8?B?dkkwRnMweHI3VjFkZEs1TER4bjNJNHFQSEtVcGpKWjNNcnhWaE1TOHZuOXF3?=
 =?utf-8?B?M2JLdU9vaHNxTXBWOFgzcVl1U2RiWHFFSmY0TGM1VkxRR2tkMDFQSkVQd3RY?=
 =?utf-8?B?NzVmaHlTcGxaSVQwd1d3QTV3UmtlcUdIaWRxL2VyY21ScWMydWh5TUQ5T0NM?=
 =?utf-8?B?VWVHYW9qVlZPNjF0U3VZTmlGclVNMk52MHc1Z0NYbDFGT0RGUDQ2ek9kMmNi?=
 =?utf-8?B?clRRb3JSaHBNSzhNd0tQQVhDMUhKSE94WjV0clcyWjRrQTRQUHdlcmpDK0hV?=
 =?utf-8?B?OFFZQ3JMN3NBYU1NU1d2cUlBYitGUEZKMXVCemRkSzBSRUVwMzB5dCtBM2kx?=
 =?utf-8?Q?7v2lY9yHBOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFXeFpyRTRHQjVFUW9wS2NnZmpwZkxIV0JMenNwZGNVeFpQVkVmSUR1OTc3?=
 =?utf-8?B?dDNHYW9aOGhMZHF0Wiszb24zL2ZPTTJSVGEwRkZmdlJqUTJkVmU4OVFMKzRR?=
 =?utf-8?B?RGlaOTdwZ3NDUDY3VHlvQW5VYXNPeVIxUEVZSFBlSytzWnlKcElTV1FpQ3h1?=
 =?utf-8?B?bEgvL1RUZHBYVFgxc3lMTzdTTjAzSUhLdFVweVBwdDZyMXFhRGV2bHh0cHZ2?=
 =?utf-8?B?MWJmTGpjL0k1N2d3K0RoZmY1eXBacldKTUU3bzdXcTJPOHlNbGN1eEFGNm80?=
 =?utf-8?B?OHRQYlh0OW5QZW9GTDdXUGROKytuamFFZ0U2S3BITFUrMnQ1cnJEaS9MQVBI?=
 =?utf-8?B?dUdFTG52b2JScUNvYnA2dCtlbzd0VFJlZHl6ZFRJWW13cFVyb3lkSHFoY216?=
 =?utf-8?B?NHJBTlhSZVlQZWJUc0NIQnpKQnB0VU1vWUw3eit0MnJLT2hpdWxYeXNQaTBT?=
 =?utf-8?B?RVNpSUNwdUIxNTdBOVo1dWZkWVJMRi9mcVNhbWZ5L2s4QVpIQytuUDZWTGZC?=
 =?utf-8?B?azVYTG1xTE5MNVl5R2V4WnVaMStneEVyRnhqR3FaWnFrL2RKZXhaTmQ2c3VK?=
 =?utf-8?B?NEt6RFppL2V0b2MvZks1SFZjNlIzNGtoK1gxOVd4TFFCb0I4ckNuaGhkdVdF?=
 =?utf-8?B?VFVlRVBOSkl6KzUvTWtVWFFwc2h2K3k5WjZjL2J0L3NtWUNXNlpWUEEzcjdB?=
 =?utf-8?B?Q1BmUnhFSlBzbGhFYk1kU011VGdCT2xlR1k2WmpjclcySHNVTHhFRXdsVE9M?=
 =?utf-8?B?aGpkbkZwTXBuK0FlUi9NRUd0eVFIOFVIVDdFOTVYSUNKNjdxOTNsaHVoRXVj?=
 =?utf-8?B?VXAvYVp2Rk93ZWFQUVpORlEvTmUxQkxtdzZZQXFmQjR2WHYwR3N3b2tQT29W?=
 =?utf-8?B?dWFncGpNaXl6THR3MnRuUmtWSU1iSTNkbTQ5SkE2RHlKTVZSL1U2MDNOZmRM?=
 =?utf-8?B?UnZzcjdPWVAyZHlrZUlCaWVXNWlPdms3MWk3Wk5NWG5mb3hNaDdHYU5XeTVV?=
 =?utf-8?B?a21remYwSGtEQU4yV21UNEl6dkJZNWs5SmFOMk1raUNNNytRRVZYaUdTTWVw?=
 =?utf-8?B?M2FkYzhUajNhaEs1UFN2SGZ2NzJzNlRnYkdzbzlxWjRGbngyWDgvNlBTZzhC?=
 =?utf-8?B?SzFjV2FQQllEWlYrVzVXKzVYakgxRVhNRUlSZ0IzcWJ6N0lsT00yN2xySTNh?=
 =?utf-8?B?c3VYWWJIbWlWRFF0WXBWUnJmK3kzbkNTN0tvTGhXQUw5U1NQMGRTdmc4dEtv?=
 =?utf-8?B?emY1NUpvVWx5VnFYSXN1SDFPOUhLS1JoYlBteWxaZEQ5N0hIb01YUFNaK3Za?=
 =?utf-8?B?ci8yQVRSRGg1NVRxV3BNQWZOUWhycUJVbEVaNUtCc2Q4Ymdld1lVZXhtc1B2?=
 =?utf-8?B?bmkvTFJaSVd0dkFGMFFkcTBPVTlBZlhiRmhwNjVwM0tvMHNGcFZTdmNML2xp?=
 =?utf-8?B?TXA4eGNCWTJjenBnYnFXWjdkcWt6K2VWMUNRSFpBekNDaCtsMjJza3dUdzhy?=
 =?utf-8?B?ZkhxVGswb3I1ejlYSTZMN0k4bVBkKzI2alhscEtmWkJJZCthSm1TYzdwenlO?=
 =?utf-8?B?eXJUcHJJZWFlMFd4dTRRQzErTFowMURSdWhpYnQ2YVZpd28vWGlkZDRCNFZC?=
 =?utf-8?B?UXBaMHBsVmFWUjUvZHlLTlphZTlQcnJpQW85RnNHbnU1eXRRNmx3SU51aE5Q?=
 =?utf-8?B?SUVHRHJub3VBMCtRKytoV3Z4aDkrSzlVNTM4Y1RPMTg4Zk01b0J4OTA4bTR1?=
 =?utf-8?B?VE1yVCt3MTJmd0lEMmRDbUs5dEVNWXdVZ0JXN0RRbWpQNkY5VFlSbGwrTXBP?=
 =?utf-8?B?aEZLUG55UHcrQksyZXhnbmJCN254cmhua2YyMzM4NTgwcXJkRnpRem9lVmNa?=
 =?utf-8?B?VEpTSTBmSUVkdEcrWStZUngyalk3ZmdaaE0wMlZyTUJpZE5DL2dPbDFqWTUz?=
 =?utf-8?B?NzdrdExVdWZvMjNhdzk5bUVRa1p0RTJUSE94Z211NUlVcGVDbXhwYVpiZWox?=
 =?utf-8?B?Rmp1MjQ3aG9TQ3VxdWFqSjUyZG5yN0ZYWU92RExydm51aGF5NGsrVjczcENP?=
 =?utf-8?B?YU9vKzhiMndWT29EQUYySkJCY0VkZS83ZHlKdkRFWVN6eVJ1WjJ4R1RnckZN?=
 =?utf-8?B?bHhuSDBPZ2FJNWFRL2NpUC96RkpoQitjNDJHQzZLNVRSOVM0WFprb2xHVms3?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d78fc-b0c8-41d2-4ccf-08ddcdaf7b09
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:19:32.6074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UEnIJgUIw3WQjfsOIGbx5AG3l3VQgUCDxx8VcNQZ2Z8UhWcNCqEqHhrtXLL6PIluY/DkXHdWwhpb3N3LXnQGNRkmcVuUK6c/akJyxaVhvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851
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

Hi Tom,

On 7/25/25 5:57 PM, Tom Rini wrote:
> On Fri, Jul 25, 2025 at 05:30:59PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 7/25/25 5:18 PM, Tom Rini wrote:
>>> On more recent versions of setuptools the warning about not being able
>>> to find the files specified in license_files has re-appeared. This is
>>> because as best I can tell, it can't and won't look in $(srctree) but
>>> rather only subdirectories of scripts/dtc/pylibfdt. Since we already
>>> provide both SPDX tags and a license field with the SPDX contents, let
>>> us just drop license_files as it's not mandatory.
>>>
>>
>> IANAL but I believe we need to ship the file, that's part of the license
>> requirements for both GPL-2.0-or-later and BSD-2-Clause.
> 
> I mean, we who? As part of "we should re-examine how we bundle Python
> stuff", yes, I don't know if our pylibfdt stuff is at all optimal
> anymore and we should maybe we talking with upstream dtc more. But
> $(srctree)/Licenses/gpl-2.0.txt and
> $(srctree)/Licenses/bsd-2-clause.txt exist and we don't publish the
> python binaries.
> 

Yeah I guess it's the last part that matters, as far as I understood 
from what you wrote, this means it's essentially only used locally and 
never uploaded anywhere for consumption by users, so I believe that 
would be fine.

I guess this patch is an ok stop-gap measure?

Cheers,
Quentin
