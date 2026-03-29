Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D0F3D603
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 12:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A295783D71;
	Sun, 29 Mar 2026 14:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=WINDOWSLIVE.COM header.i=@WINDOWSLIVE.COM header.b="BAUH2XRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822D483D71; Sun, 29 Mar 2026 13:51:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5CB83B48
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 13:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=windowslive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=szabo_tamas@windowslive.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRhZQesymsaes/DABuD6YbdHnjbXh2rgRpPdhiQ6TrOF1bEkSOnB8sKYy7FfDfBmbO4WbwTvoYEICvW4l7O7Cg3ukwwurDh/UemanWwi1yPRDJznWxqKRoWN5HpVMxzx3fFnjRtpEi0kaHYRmrvSDUrpVjU9eXA0SgQzr8RQjgqAXC8qj5942yO7Ow6yAQY2TNN6JgXI3aMrVfOMRDXnVyzn4z/zZWf5+Y9dvc8nLNRWlBcGLhCIyvPFLouLBOSnvjNsAWlv36BCKkOtbcLXeo3QaSx62x8l1L5DQfczqlRAaKcXz+9CD0AAULAeWtzLeXvxFuiArtBVfifElYyY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk+idOZ0OL3DrzCZwwHVg04XvnOh5RVqYNsDpMzA/ZM=;
 b=tJ6/yI0aeZDridMv3xvzU1yBpM41XDN9Udxx0oRgYQGBQymkg6qZDkTerIYjHmivalRdHIuxggA0gJo0O/C0o+wRqQkTRx/12H4eSnl5vsselyFNAslnNmL4peyR0oo7n7uWYiT6QbgRXsE09M0M+muxjg9XUM+Pb9ZqGb2uVvGm00CCpZ1zhItxAz/oy/HTPBY4B9CW3RHrimWI45TrP/8gdupk62JaUbj/ngHF1TpnIkcpNBwueQuhCbLUeC3ZxEPJaq699B381ZTCdZBnBVvr1t5HsOi3ZQ+0aQkOW5JUJULp1KdHUcIdCaZTZczP8iLQgguzH4PQpFLNAT5rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=WINDOWSLIVE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk+idOZ0OL3DrzCZwwHVg04XvnOh5RVqYNsDpMzA/ZM=;
 b=BAUH2XRTV6V6xbNrQcrMRGVU1P8QKRCV9f68RjsDkhORY9aYEP2Iu0CizypRobxlRmk5XYhrN3/9Kh82lPUSZgyOZgptLZYCrnpLlybNa/I8TwSIen9Y5OX45CAXW1mr6e+UZ5uWvvjXACulsN4/Rb2bdvGj2S0bqgxFqDzDVFN3mSSTVPXiwemxeSIViD4aH7RgPTph8sgw5negd9l0BlZ2ZJJn9WLriJdRZTp4wSG8CQMF1QE81DlSqFZOJcPoENBjrhXLjSvq6nr/LOITJl4RGPnWcsNMf6RMr0HcUK5UdcIX/5OOGVPf3M6O+lZ49bhD3Mv04W1ohk+WLnNv4A==
Received: from MRWPR01MB12974.eurprd01.prod.exchangelabs.com
 (2603:10a6:501:84::21) by AM7PR01MB6625.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:18f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 11:51:40 +0000
Received: from MRWPR01MB12974.eurprd01.prod.exchangelabs.com
 ([fe80::d472:59c2:473:cc9]) by MRWPR01MB12974.eurprd01.prod.exchangelabs.com
 ([fe80::d472:59c2:473:cc9%6]) with mapi id 15.20.9745.019; Sun, 29 Mar 2026
 11:51:40 +0000
Message-ID: <MRWPR01MB1297423A4A87C6FDEC941A2898C55A@MRWPR01MB12974.eurprd01.prod.exchangelabs.com>
Date: Sun, 29 Mar 2026 13:51:37 +0200
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: =?UTF-8?B?VGFtw6FzIFN6YWLDsw==?= <szabo_tamas@windowslive.com>
Subject: U-Boot HDMI console on rk3399
X-ClientProxiedBy: VI1P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::19) To MRWPR01MB12974.eurprd01.prod.exchangelabs.com
 (2603:10a6:501:84::21)
X-Microsoft-Original-Message-ID: <7c615cde-7003-4749-9870-96f7cb68ec4c@windowslive.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR01MB12974:EE_|AM7PR01MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: bb25fc18-38f0-4efa-e36d-08de8d898946
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|12121999013|8060799015|19110799012|23021999003|461199028|15080799012|39105399006|5072599009|440099028|3412199025|26104999006|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDF1RW5RdzFzN292WjdoRU9nMmxKbys0UmQyZkNqRHk3UTdsdjVuV1hzd0hE?=
 =?utf-8?B?NzMvNjRPVkZqVmprdk5KeVc2cXNEZEkvTXN2UWxMWW1Fd3dtdFR4U0M1TVZQ?=
 =?utf-8?B?TnZJWlhhWGo3OUFhVThBMzhiTlV0YmR1MmJpM0d4ZmlpUkdVZ090ZmxRQnR1?=
 =?utf-8?B?d3QwY2t1SGFVc2dDaHN2U2tMMjZPWUhEUWRYRTU1VnFjYzlYNTE0R0Nib1lz?=
 =?utf-8?B?aXlBbm9FbnRGQWVYZytyZVBwa3dDZ2dZdXR6Mmt1YjJzUkJtZHFYcGYvZXlw?=
 =?utf-8?B?bjlLZ1JySVhnMjZvRnBIRjk1d0MzTFdlM2hKazlFeEU5K0VEaDZUSjQ2b3J2?=
 =?utf-8?B?T3p5K1BkZ3NoUTlRaDkrajM3ZktYUlNJNXFkZVJBeWZuTHlYb3dwWW1mYjhD?=
 =?utf-8?B?VklaVDh6OEhTbERlSGJJdmdBVnVyVXlDYXA3K2gyU1dyTEhTSG9uQUF0Tjg2?=
 =?utf-8?B?eXBjZFRrbjlaRVE1Q0x5TkF4WGppek1xczNGUzliVHhHQXdJQm5vWkFDbjNj?=
 =?utf-8?B?WmhJNnVCUlloUW9rcmJVUGI5QW5CUEZrOXdWUktNamkweDJoL2dmbE1weVhB?=
 =?utf-8?B?VHVyUGhjdzh2a0NjT1pGN2g2WkY0TnlQbXFRL05kZXlzWHBtblJjcmVzMkZS?=
 =?utf-8?B?UEJkTlV2dEdiTGRILzRaanNMeEtRYi85OEJ1Wk40amQ0THRONUhhMGwrL25V?=
 =?utf-8?B?a3R2SkVmamNwbS9lbHZ5cWFZdmk0dTNBeGE1WjBSTnJPaUdJYUs1Y1NQZGRL?=
 =?utf-8?B?cG1WNFdXVkE3eGlPMmw4aUROVlFzMFdXTzdEeVRxc1pRaEVxQzd1NEdnRVNW?=
 =?utf-8?B?aFpjTDh1MnJ1NGMyeDFPdEJXSi91aEhwZkFJRTBNZEZVakhYWm1Ba3EwNU1H?=
 =?utf-8?B?Uld2cGJ2c1d1anNxcFVMd2lWVjFCUW8vMTIwb0VKSndnSmhQejFNdHFWT0dE?=
 =?utf-8?B?Zk1sQXkwaEFGWlBmUHVTU054aWZsOWx2S2QxT3NYTXgxU0wxQ2pHNmlQc2t2?=
 =?utf-8?B?d1BuYUtuZUhXTGY1WkFGekZwejVGTmZ2K0EyWnZ2WDFQQU5uVCtscStzK2M3?=
 =?utf-8?B?UkNKVUE0N1hTNFdyRkdiMzZUcjJWNnMzZWY4RGFuYnA0OERhS2cxMkJxcnNO?=
 =?utf-8?B?QVBRMW01c2JMMWFBQ3pSMm9MaHlKUmxXY0oxczgveEIxOHBTR2pEQzFieGFT?=
 =?utf-8?B?VDB6SzFJeWczZHVEYnZ2Z1JJTHpMR2FCaHdRaFN2SGc3TUVINGdjZTUzQlhJ?=
 =?utf-8?B?NzcvTk5NUGNQTUtCOWRvZnRMNmI1Y0ZkZTZ0SFloUjJTckV2UktpdDRMWURa?=
 =?utf-8?Q?2oLPxQEn+Yvvw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhWV3MyRVlrSHZRYjRZb2k5bVdTaERwVEFVOEpkcytCTlExOFh6OHZrUnNK?=
 =?utf-8?B?ZDRDMW90Qk9RVlFnS3pURFpjUDIzdW1LWno5YlJ3MHhMMndyRTlMQkRwTjRu?=
 =?utf-8?B?a3hIL0FzMis3aW1FOWxQS3VmTWdvaFNNVC8zbmgySVMwNndVM0RubmYxZURu?=
 =?utf-8?B?eG84YVkxb2ZzU2dKNjIyRm1nTnc0RzVJVzB5VVRhYUVGczdUUFE4Y3VmN0lx?=
 =?utf-8?B?T1FiS0QrQ09rVmxoVDVDbFR1ZUhLenNibjdESmdldEdhdWRqdm1vU29EQWYr?=
 =?utf-8?B?VjYyQ3l4MTZCOG00RFlZMmRlK0hWU0ZjTkMxN1UyeXRLcWkvdnFjZXg5QTZG?=
 =?utf-8?B?aHNFa0lsSUYyMEFDNGVPSUFhSDBoeXVDUFpMcGRXZi94bGF1QTVTR0VZekQ3?=
 =?utf-8?B?YlQxNVNGLzVzWWMvVGVYSVprZ1hZUzU5UzhvV29KOERiK0tDbGdENi9qcVNI?=
 =?utf-8?B?cVdmeis3U2tEMjBDTytkM2xEZk84K0dqQTJUVElFUzd4VWdmOTBOQlNKVFd2?=
 =?utf-8?B?Sm12SGZJWGpTMXlIaWRjRCtqc3dEVngyWUdCd0ZvdkpNOE1vQkxRb0lvMkwy?=
 =?utf-8?B?MTVOZTRMWllpdkxwNi9LbUtPT1FYZmo0N1htbGhxcUc2bGhzMi9rTFFQc29J?=
 =?utf-8?B?dk5hSWdTS2xyQ2ZxZHQyRVBLc3FjYU1Kajh4QnFkTWduWVB3cXNhUmhVT0Mx?=
 =?utf-8?B?VnZQdFBCTW94ejJYQXVhQjNDamdEay9EbG8vWi9wNU1KZG9qMDNOM1dtQjM4?=
 =?utf-8?B?QitaTDl6RVVNUG5TYWNRSjJtOHdDSlRzWXRBM0d5QzRpZzFiZUYxRjJyRWF5?=
 =?utf-8?B?c0lvQ0FJdkVrRmZzQTdnZXBYc3VzZ1ptQThlS3VUT01UNEtzSlZVSUhhMXVO?=
 =?utf-8?B?V01tcVpLd1hIVUhnRzhKSy96eDV5KzFoMjdtZjlTT2Y0aHRCRjVLQjROMGI2?=
 =?utf-8?B?Vkl0ZW9CVUtUbEJTU1Z2b3h3d2pENVhRa2J3cFd4L2c1WHV6Y2hGTllLNzNj?=
 =?utf-8?B?MEMxVVA2eHFVWVJRamJ4SXl0U0JTdG1TOGRaRG9QT0NrTFA0eHVITTVPYmwx?=
 =?utf-8?B?a21CTm1ZelYwS3h4emNwaGcxbTRMWDgrc0tNUHZQSlA5dEJPYklQd2JGZitO?=
 =?utf-8?B?dDRPYjJQNlZvUjl2ZW05OEwyV0M3MTN6cjE5U2xyeVBrNm90YXVIVTFtMk8r?=
 =?utf-8?B?N1JjdkN1Zk8relc0TElHZXNYbU5vQi9YTUdqSGQ5dDBWQkVzNXFaMG5wUCtj?=
 =?utf-8?B?NnVKOHIzYTR3TGxEckFRYlBMMFFGMGJUcjBxZXlFWnlYU25RVnNtaUdaRE9u?=
 =?utf-8?B?VUdxVlVLNWlGeGtvNnVPZXhyQzY5WUZWNVd6dldNT1UzUDR5V2JoYXNST20y?=
 =?utf-8?B?S0xLdW1jQUF2bHdkMG4vaDV3RVAxVVY0L0sreCtBbDJycVdaY0srV1E5MmpS?=
 =?utf-8?B?TnpUcHNhZWM4VkkxVnlHSjZzMWJPWVVxb2pKWStBbmhnUGNRNFhMYXRUTDRQ?=
 =?utf-8?B?WTVYaW56ZjVxbW0zMjhnVFhWbzdxMTNlVkNzR0xMT0NHTllvNDNsQ1RuK3Va?=
 =?utf-8?B?REx5bll3Y2FGYTZTdmxHZWJyakhMVGdTUTNuSTJvOWJFQjkxNktzSkNwRERD?=
 =?utf-8?B?WExkK1NJdWVHOHhCNCtoY3MzNGJzNTQ0TXpsbEJuVGg3Q1dNdXdGVFFMcTVv?=
 =?utf-8?B?bUtkY01ibGZHZm5Tb1BITGorMmY0eTBEMFpuc2JPT2RHVGdFNnJ3OVVwaUY2?=
 =?utf-8?B?TzBqR2ZZenhrb2g3RmxHK3JtNUFTcW1YdUdEbWN2YnE2QVAwaG5WNld2M3Rz?=
 =?utf-8?B?TEU1TkFIaTZiR1p0a3BkU25HTDZLMlh0ZWFJYWdlcTRUT2NIdElaMGZsakJt?=
 =?utf-8?B?Rm5UekVXY1BtdlU2M0dibGNtUTBnTHROTlZWcEVYcDl1Ri9yZldzYVZieWcy?=
 =?utf-8?B?ZHJGMXc5Z1VldXJUK0ppRng2UEoyUTFtQityMmNKNzllSTZjVnZZdzU3NnFH?=
 =?utf-8?B?T2FaNklPbkRRPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-d13a4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25fc18-38f0-4efa-e36d-08de8d898946
X-MS-Exchange-CrossTenant-AuthSource: MRWPR01MB12974.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 11:51:39.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6625
X-Mailman-Approved-At: Sun, 29 Mar 2026 14:59:47 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,


I read there is possible to use HDMI as console output on rk3399, but I 
do not find any documentation about this, only Google AI give some 
hints, but mostly mix up rockchip and sunxi stuff.

I have a Giada DN74 which is based on rk3399 but I am not able to enable 
HDMI output in u-boot.

I check in which defconfig is use necessary configs (|example: 
CONFIG_VIDEO_ROCKCHIP|) and which one is similar to my board, I choose 
nanopi-m4-rk3399_defconfig and build u-boot but no output.


Is the HDMI output in some rk3399  board enabled by default?

There is documentation about HDMI output in u-boot?

If not documentation, someone could please write a sort advise how to 
enable HDMI output.


Regards.

Tamás
