Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9460D6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42587897C4;
	Wed, 27 Nov 2024 12:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Q/7KotVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4123C897C8; Wed, 27 Nov 2024 12:42:14 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2278977F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn/hCVx4B0NYu8BUu5u+Gi2KKTLayhRUKM8M+u3PwkQMTaREXI6id+xe7Hmh1qipWqd2bzK96ofSI9qpyvQnIefXRZjdkP1dVopBTIrGiQIsB8SDP1BJtmG4yTXN9LdgTxxaG3HIO2EkDUEj04kFoPobNLiIJOubDgHhEpmIQT8Xi5I6/Q2VVgcfDgE4yXY4QvyESE14bJFRGrEdlP2Ug1X0zQWI9+b7U6fVN58EbQpAnaY6K08Gh2bHlvvhhhEIWZ/2qR+cZ8WfUcVIIMBLzD7kLBw9KG8TibbBctm2DhzcL7xWZs3C0MptF4pmwiH+ESqFeT/BXl322tRGlWGF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHiCKhIg7nv2UVnXGKmyS3IqzcR0VDCbOqRMeK2FTOg=;
 b=Q8+q92cjy1KzTDN6wKYxx9tAmjRuuPSEt2OT7VnW1zz9HaYG/TuBlgc/Ez1wSVsIFZ0P9G3l9YF+IkT6CR2d7MRuBm1gpXIO3cRH9UqiP27OJKPn84v+F31ec2UAylWbd2scOmiHzwT+ViG1jAhRJb2Uzxs62yVDQp6AkXcms1gMMRCTn/JrLaitha9Mycl82Tyd18pkanrLNFS/W1b2/xlwxqPuBPplKPxcJW7otOug/RBcB/iWVStZEhomhSiRRfKv95lt2TTNgKWceD7Kc2OFc0Vb6293n9x7yts3pXajR89nsk8u8+ryFcycl7k2e2UJA29gwb4/L5OkBQgtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHiCKhIg7nv2UVnXGKmyS3IqzcR0VDCbOqRMeK2FTOg=;
 b=Q/7KotVsIjq2PjhQpsckzx54G1UXO/xCx9FKorzV7zs5/7U3N8ZPfzX16+NpWJEr24I504KbZDDZNJDokDgOfPtHy5Jepn/0xR/LgQy1ZDk6CsUznLeRZ2bU+pv1lLySulEdv3iMBBivxJ4mA7dLlgqWo07kNR7YUnqjQ046+Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:42:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 11:42:10 +0000
Message-ID: <5a7cb24e-1fb7-424f-88f5-3f15858bd366@cherry.de>
Date: Wed, 27 Nov 2024 12:42:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] boot: Pass just the FDT argument to
 label_process_fdt()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-12-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119131844.4078144-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0170.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: a2574a46-bfbc-46e5-2604-08dd0ed8878b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlVyWm9TeTdGK3FyaGU3VkMxZ3JHWFg2UWN4MENXMVJScUhpaVlNK1hxaVRj?=
 =?utf-8?B?NW91bU1Rd2UzWEh0S2NBV2ZOY3dESkZrNmliY0hmRkV3TUVYb3lVV2M0VVlR?=
 =?utf-8?B?blVLbDNSOTJGa1ZTU08vOWF3aXZHOTMzTDBobkFkenRtck9pN1l4eERJTWRu?=
 =?utf-8?B?YldPNHk3NUNWMEUzZlR1Y0VUVmxxUVV2eklyaWNGdjR6azdiQTNtS24xOUll?=
 =?utf-8?B?bEdEOFBOTXZVbG1rYytKZmQwbFBPZzBWalB5NVJxdi8zWVlGbkpFNVBJQTg1?=
 =?utf-8?B?S2ZWMUo1R1ovTDlBZll4UUJOZVZnTVZoVnFMMnNsclNVT1NUWmZWblVkNENH?=
 =?utf-8?B?ekVvcXZjWmJhN0Frd2ZCWW90US9FOVMvUHUySm1ibFFySzlHR1BDVGZ5MGkr?=
 =?utf-8?B?cExnb2dDVHpoSjQ5eHJmcU5oUnB4cXQweVR5Y1VLN1ZjTDVPa2pjNmJyb2pj?=
 =?utf-8?B?MEEyNTZoRjQ2aDlqT2lJczYxQjVQSVlaL2d0ZkNqZGIxSUpOWnE2cGNTeGRR?=
 =?utf-8?B?OXh4amk4MzFweEU0ajRVVWoyQVplOUVCWmY1ZXVoc3J0QlBTR1RRQ3AxOHc3?=
 =?utf-8?B?MERTY3hmVEFmSGNMRGJ5ZVE0N2c4dS9zUksvZ0hMTzRtZzdSQTBLWFVzanZr?=
 =?utf-8?B?MHEzNGdvcmdXZnRaOEVhaXk0ZThtVW5UWVV4eWpxRk5ReXpwWEd3elA3OXhR?=
 =?utf-8?B?NHRPSmVpcGdoVkVqWHFISmFCd3VzRmhwQ01Uc1dzcWZFbkFpTGI1YnkvVzl1?=
 =?utf-8?B?eldDYlhBWXU1cXphdi9zUDV5S1J6WHF1dXNUc2RhWllvSFl6a0VpRHdsc1pY?=
 =?utf-8?B?SGxUMVlWWExZTXpNOFcxQzBBeS9nMitmLzBKZkVZM0w4YnF5L2Vja280V3A5?=
 =?utf-8?B?UE9zdm9YdXhpSDEvSElhVThyMmJKQlFtL0hkeFlidEpyUDltcUNPS0VBT1ov?=
 =?utf-8?B?TGw2S2l6Z3FLdnZSTTZicWdOdW9laUF6M0tSOGNDU0Y3aTlIV20yYVp3TDMw?=
 =?utf-8?B?SGU3OU40UkxFMDlGMUlKYnR5dmtNbmdnSGM4RkIvK01IVk5vMEFROEQxQlBj?=
 =?utf-8?B?M1A1MGRWZ0hMRXRGUi9hT21jdCtQL3ZUWkRXc2V3Z0VBc2tPVkh2ZU1hZ1pn?=
 =?utf-8?B?QWRYUkhsZUd1ZVYxazlySjBNT3gxOFZuT1RPU1BDbGxNVjdyWml0L3M1aEZY?=
 =?utf-8?B?dHI2SE9OQ0RSa1pnaGgzNndZbjYwTlZ0M2srNGs3aFN3NDVMV2crWnlJU0pL?=
 =?utf-8?B?Q1NkREsxNmJzenlMMUdDcWc1cjFMOWh5M043QVlUQjJJRFg5blNDYnQ0T2Nu?=
 =?utf-8?B?TExaNWljRzRzZUtqN0lzNjhFTFZTc2xMNDBVK0pXUE0rcjhpS1ZaQksvc1Zn?=
 =?utf-8?B?M3VhSmJuc3NWLzJ1MFBHZlBRblRvS201bW05Z3g3aDB3blpVekFmZUg2Tk8x?=
 =?utf-8?B?UEhXTS91dVF4QVgxS2pXUmhIaDNlWGVCWGRmYWJBelJFRXJKejk5aFhiUStU?=
 =?utf-8?B?RFBCM2JSOHFQNm9RakZMUHdyWDR2S2JCZ2R4RzdxMS9FMWFYMDhtUXhLL3po?=
 =?utf-8?B?Tnp4WUVlck5md04xUGdyUmNodzF3bXhIaG96emJETEpuQzlnOGptZExvaWYz?=
 =?utf-8?B?UUJ2WWp3K0FJZ3NYdDFrNWxSZnZnMGFIdDRmV0V5OHZ1bXBFbC83VFhSejlt?=
 =?utf-8?B?WmJETThkajNBVkJEVGhaRUVvdmhFVnRDRGhJeVNUc2UzTnQzV0dNZGUycDVN?=
 =?utf-8?B?MmF2cGd6YUdHcGVPWE9ad0lpaGZURE5sb3ArbEJOczBudnFoQ0JOaVhyR3l6?=
 =?utf-8?B?S2Q2aktqWS9wb2JxREZpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRSOENvVWFWMUlQVnZhQzM4cERNRDAxVXRjbEg5N2M0d0tpc2w3MkdMQ3JU?=
 =?utf-8?B?NzY3WTJVbDlGMjNkRDZBVFRRMEI1aFhraWp4YytRR1hBaFBoMmxHQ1VFaUlr?=
 =?utf-8?B?R2lwU2cwYzVFZ1F5LzIyVDYwOFFza0dkanBsOFR1MHdITDZsVFhQUFJ5YjBO?=
 =?utf-8?B?RktjWjhQUTVMbHpzQVgvYitPUkVxYlFiOER3cDloWGZFbk9EYmJlNDJRR1ND?=
 =?utf-8?B?djZUQUJnOWNjWlFVLzRPdUxLc2JISDJmL3Z2LytPUStpa0lSOUI0ZGd4TXBZ?=
 =?utf-8?B?SW1SWG9wRjNhRmR4ZkJXZmFRRFV4aDlueGNaWUFmRTJFUGtsTXlUOHdBRGkw?=
 =?utf-8?B?aE9oOU5HZW1uWUttUWZJbmNxT0JnQk9nd044MjBpMk56dnF5Uks4YU1ETGZO?=
 =?utf-8?B?M01KUHRURmhMa2haL2ZuYlY0THRMNlRoS0liSlZXOVp0YTRlUjdiK3l6RGZn?=
 =?utf-8?B?c1dNd2oxNENSS2wwVjIrQ1BsTnZvSGNDeGx0aTlUWjlKbXJtWnUzTkRHTkNk?=
 =?utf-8?B?Q0t5UFpRVkgweDZOeXB4Z21kd0YvSEV3RGFRSjVoM2xSbGlmVTdWbk5KQUtD?=
 =?utf-8?B?MHQvZk5adVZNalF5TCt1eGpMYk9yZ0VqOW9wQzFNZi96YVJuTmxxcVdJaXNB?=
 =?utf-8?B?YkpGMTgzTVBZaGNGbzZ5NzVYK3hIUktRcVpWOU01dC9USU9hd3hISEx4RTdk?=
 =?utf-8?B?SmJTaHV3bXV1VlRjVGNVZFJKY3ltWkdkOTJtQU15N2xaOUI3Ukd1eW9EWXU0?=
 =?utf-8?B?VFhqcDJQMElYYXkzSnRSUUVuV05SL1daU1doS3JZeGhOek9QSHE4L05nazdT?=
 =?utf-8?B?WTVjUFJpM1R5WmNPSkdMM3J6T3ZnWFpyUEZiL2gzZUhLNnJCaGF1djBONW5j?=
 =?utf-8?B?aUs0b3Z3L3ZDWUdwbXVET09hSTNWZ0dVVEx6VDVJOWg2NkRoYkl5ZHR3NzRH?=
 =?utf-8?B?VUE4OUxOR0VaRUxVZEloa0hUZVphSk5SS3Z0NDdSTGozVWNLTk12bkl3UkxB?=
 =?utf-8?B?ZlNHdTRZclIzekF2bTYyVStlMkNIdGp0SXV4THpoV2xRYld4R0h0Z3ltaHMw?=
 =?utf-8?B?a2hCYWIwYUdYaFBGZ3NpU2svdnBJREZ3U3BmZFVlYU1BK2VrUndmLzM2QjUy?=
 =?utf-8?B?cmtNSGZCN0xsbWhNdktkU1lQdkJvMHdQK0srU3hTL2h4Ulg5VkdnaHR3TjZN?=
 =?utf-8?B?M0Frb1lJcVFtMkh5bUlzdGxsMlZVbXdEZE4vWlBXUG4xMG1VU25WVGZtNEdH?=
 =?utf-8?B?QWJ5cy9HZUtmcFZ6NEV1RVJHRkdXODYwdXkxQklLK3Ura0hvYjZ5cjI0SFhy?=
 =?utf-8?B?am1tdXViY3kxcHJqVDh2K25LUHNubE4rZ3FtcXFabnd3eHQ1MCtOVDVtZlBw?=
 =?utf-8?B?eXB2b1ovdURqRXQybVZoNDZiMEFYTmNvbWVWOWsyM2Y4RTUrNkNXdFlXRzNF?=
 =?utf-8?B?anNpRnRRYkNUeGNBc0hTNHhHUHVseGZabER3dUFTOVprU2J0aDl2MHVwSHA5?=
 =?utf-8?B?REI0Z2Jwb0xLbDc2TUcyREdtWUMyNlRDOEFQM1QrN1ZHNDZ1a1ZsN1RnUmlL?=
 =?utf-8?B?U2xPSGhtZzlrZWxlMWUvWFY0a0FHK1BpbVgraXhCSGdxUlZvR21xcy9MaCtX?=
 =?utf-8?B?MUxCSXNEZ2VrTzBpeXNsSFRTc2ZhV1ljeGJlSUV0TDRkb1hQSTgvQjV2c0tp?=
 =?utf-8?B?SVY1V2NIQjFVTjBoMFFhWkNvTXVxbkMwN2hxNVRjbmVNSFdaakNVSTl5cWVY?=
 =?utf-8?B?RmU1OXhhcW9BRXdJSzh6WFFKZU93bG9aYzVLU3hFdUhHdmRNTlVBdTdaK0p6?=
 =?utf-8?B?MWJkV0EzV1J3dzh1WlovdGxnUnNjY05mSnVqb2Y4STBHSU1KV1VpY2RtR0NU?=
 =?utf-8?B?TU5ZL3JBZEUzSkcvODVuWEg0cFc2blI1UnlRSXFQdE1MNmhQN3pXVTUwZ3Fz?=
 =?utf-8?B?b2xReTJPVW9YK2Z1cFhjakluNVFiYUpMaFRxWnBJWTNLTEJRYTZzbkR4alor?=
 =?utf-8?B?YzN1LzV4aDZQdTFHZTM3RkZBOXcveDlpWmNwWlZRUHVWNTBJMkFzYXJUNlhh?=
 =?utf-8?B?QnVWRElnOXhzYktXVWVNOEJuMmZVYXdPZ0NoUWs5TUFVQi83aUFXYWZXYWdO?=
 =?utf-8?B?WnlROWRXYkNCSWFTbyt1bVpqYTB5R2tjeGZMa0J0dmU3Y053cTFkcm1QVENB?=
 =?utf-8?Q?CKxowNLi9zwQu6DShpm8VzE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a2574a46-bfbc-46e5-2604-08dd0ed8878b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:42:10.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y1aPQUXhYIpM5hLUd80567vgg0M3tQb/RV/VT50Kaf/LkUFm9Yh0t0WeQI2SOyqQW1wuVAS4UxeJezVMGbirWbvB2hm7gI8y2eMcCPR9XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8412
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

On 11/19/24 2:18 PM, Simon Glass wrote:
> Since this function only adjusts one element of the bootm command, pass
> just that. This will make it easier to refactor things to remove the
> bootm command.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
