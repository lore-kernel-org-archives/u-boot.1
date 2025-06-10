Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B02AC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 10:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A664880E9A;
	Tue, 10 Jun 2025 12:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MUowO12o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9519282A39; Tue, 10 Jun 2025 12:36:29 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3583C8070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4xy9Ziteu1TD045f2bwqASnzUsnJs/UhKq1UdaXTbhtItDPMREdqZsrkEJmC1Q3jeTpmMivP2lytdLNcBsuVXPsnLQVSWqJwZOg0i9FffYQbvBsoSi4KYzeQ1FZG1+pTIiXE0aYiGVsrjZbVjMGa3U6l4j5MngCv8/6DY95zBHwcJkuwZ44w80gtImx2BelMBSbj7cQqVrZFayzDSXQ5o1O+qUKIGGiG6Ej/U3yjUk5Ctoou0KA7fAfXbm9iJtjC07aB/QIe0Ck8Pk5QQe8DhzLIw7SnYdBtVYBCZLdwpTen2dNFIxzkrOCHvl9B0zc+JUVUiQn3QpdvwT8nWyUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwVJSDHe4PIVbk1ting9i8o3XGk6tWULKE4BOyuFR0c=;
 b=tJl+AfcrOq+m46dOT0/YwehPsCGAmkbretifm4dLF3kPD9aQcdg/Y5KCnheAwU3ba9H1EgZwRQgx+SBu9XuS+CqjJR0nxxKH+RHPUmOiu+fRMMAOWAQ0A8YbBFLHGfXbf3hVHHL8O1Nc91JfEA5p663acQpvhiR+8xiZMDBIcYzW0nQBqKKsY1SpimIAXeNOPSiOQdbZMWZPl/zj+I4XKzXv7Kkt6lrmYN5S0natYmUBcgDNeCm+5vkTnF3CskZuYGU0njqllDY6vDLpHof5zAA4G7/rEuBRaH46P0DwGmdEvdhu9VPoTdCBVD/nV85kVrRnjWkNnWU6zi2SkvW3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwVJSDHe4PIVbk1ting9i8o3XGk6tWULKE4BOyuFR0c=;
 b=MUowO12oG0bxlHDTXyRBLy4U41pvx3jQ88kD0h2li96jN5Tlp4r8CRcMMi39S71W6i1NOLw5uS1/uhjJzuLQgnr0vw9jhasbfwDw/QnA/8HnWzqSaGklmxoouAJJIGoAlOT8bGn3fnE8maiXy2IH6X0FuXO/fdClvW9dSnPHTJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10599.eurprd04.prod.outlook.com (2603:10a6:10:593::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 10:36:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 10:36:24 +0000
Message-ID: <dc51ba46-010e-4fc5-a0bd-88c758940e96@cherry.de>
Date: Tue, 10 Jun 2025 12:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Searching and Finding boot.scr and uboot.env on a Raspberry Pi 4
To: Marc Haber <mh+u-boot@zugschlus.de>, u-boot@lists.denx.de
References: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10599:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc53be5-202a-4826-0b28-08dda80aa621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1pveWlnbVg5dTI2NjFjVDNjdkJZRnZLU0dPYjlqbWVlMTNZRmVlZ2RIMlZD?=
 =?utf-8?B?QWY2THFVNFVkMFp1TWxJTjJBQS8ycEsxaFZwaXMzNFVwU1FrRmF4cnJQMUQ3?=
 =?utf-8?B?U0I4eEJLbnJlMzBXVTRMZGlUOGVnbXZhOHZiSVZobExHdjJBT1NhUFNiSlpG?=
 =?utf-8?B?MUU4czNzYStwd3MxRzAxL0kramNjMzdzWDVQZmtjUkJJMW9Cd2hLT3RVZmdV?=
 =?utf-8?B?ODRUSElJQlYyOFREOGdXKzY1OTFKQXNIZVZ1MVpFVXd6dHFNRFhiRnJYOCtH?=
 =?utf-8?B?VCtQUEpGMUpOU1VmWHJTMEpUMXRwQnlmbCtnZXRlVDFMVUl2MEUwbm9MM211?=
 =?utf-8?B?ZXpobTZibE9QcVVCOG5GbHRSak5DVHpFT1U3YWZpNzQrbE5NemtpUXRLYTZC?=
 =?utf-8?B?b3hiY0xHcjNmaU5zMmtsV29aMklub3pvbHluYWRhSjZCMzNvcjcvR1RoOGhU?=
 =?utf-8?B?Rmt6ck1IcjVnTnFGWFA5TTdCWmFKby9RZk1JU0dueFVvMGI4NkJ1VkJtOUZm?=
 =?utf-8?B?ZWxDejFvbUx1aHJNMklHRHpNN3lhUnRUUGI4S3FGTnkvOUdURVU5UVVWOWQ5?=
 =?utf-8?B?amtrVG01RnpFcXBGTVNFVStIbURndjU3ZHRmVVQzczBwNUp0R3dZb0txckJS?=
 =?utf-8?B?UlgrTi8vekRBUWdtVWJqZE1sQ3BSTXduRkt0bERLdW95U1hmaHV6c1hQZyts?=
 =?utf-8?B?M3FyNFJNQm1xbXFBbkFvVUhPcUp5RW1adThtSFlnbWR0MjNjajAzQzRKa2dO?=
 =?utf-8?B?UTB6dDBVMU1FT0VlWkNnV2hmeEFHSFQ1TmFCeG5UMUhWQStQbUFVL0F0V0Zu?=
 =?utf-8?B?dFZjS2NoUnhLSG5Cc1EvVlh6QWp0TlNCU0RuckhFRkZGSmIrV2tvbHhvYXhT?=
 =?utf-8?B?NG5OMEZhVEFXcmJaOTJMQkpsR2dlVDd2UFVuazJzR1FBQmc4NE11cUFIaldL?=
 =?utf-8?B?MlVhYmFNVk8rOEZvdUlvN3MwV2xXYzlsU2FPb2p4TDMvcGVGUjlJZnRvYlY3?=
 =?utf-8?B?b1BRbC9UVTBWUlJONDI0YkVJR3RuRElySlJPWXNkUklwZmp0aGFTb01YNlRO?=
 =?utf-8?B?OWlhQzUyaU5CWC8yUWpyTzdtL2p3cDZFQ1JXWURKK0IrQU1VK0RIYmU4ekYv?=
 =?utf-8?B?TkNGajFBcUorTE9acnVLOXNXYWd6UmNkdzhpMmdIMnprNW13aklBS04zMjBO?=
 =?utf-8?B?bWZHb042cGtUOGRyRjNRRHcrSXVYdDRtV2JHN0pzdU9nbk9IVFp5RUM4SFJE?=
 =?utf-8?B?azJaNDJSVHNUWlNtUXhwL0p2SnYzWi9mbVVFRFZ1MDYrQXRpRnlYN3g0OXE2?=
 =?utf-8?B?SGg2MmhMM0lXOGR0QzVBWXgzdnBZZUtYVEN3dXF4cmw5R2twRElMYzc1UXYw?=
 =?utf-8?B?L3F6T0hNcmRzaU16RDVIWVcvZDJkVDNOODdYMEUyc1BIa282UTJBbENSZ2d0?=
 =?utf-8?B?Q0lGU2wyTkFNK1RBOEhrOHd2ZmlyVGVtZjEvaXNoY3kzU1VZQ1VOQlNCSTV0?=
 =?utf-8?B?dHhwZmxhOHNHVVErTS81UEw0c1BzN0ZMOU1vT1FybWRVWm9DRTh4cTlyQTQw?=
 =?utf-8?B?YWMyRzBUOW5aVC9mUTZLdllYaUtSSHhWSjZTajNZOXZkM0RRQjZJVk5YaTI5?=
 =?utf-8?B?MW5WOXJWWVpheWN6VUdsWEQ1T0FmQkdGY3hpQTdKV1JEQlZiVWlkdVkwQXZQ?=
 =?utf-8?B?dWUyVHA3Q216ZWQ0NTRIcEVubDQ3R3dKbG1UTi9GSkc3SVRnK0lyMnZJT2Nx?=
 =?utf-8?B?TjJaUis5Rk5sa05wdDlvQnZBRU9ocTE5SDdIOEx4NnBjazFMV3laNGxjSTZ4?=
 =?utf-8?B?UGZQN0lzaGQ0U2s5OUVrZm9ScDc5K1UxcHVuaHRlQkwxMUtVTVJRbURjUEYw?=
 =?utf-8?B?d0ZaRVZNZy8rYkkzbFNMQ2R1MUMyejF5cHBsY2pidTVYMkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ozTEU1Y1lSdzA4SmEwby9JZytFb1VMUi93ZzZUZXgvcXRrSWN5STN1K1Uv?=
 =?utf-8?B?bk5OOEp1aWlMb01lQmxHVUdjaGdpMzlYcGhRZ01DYTJ6NWMwMlZNU2w5VGhT?=
 =?utf-8?B?TGFvY0dDY3U3NlBRbG14c2VMQzNtaTJJa2VueE9SeXc3eHhYZ0tXS0RXUUpl?=
 =?utf-8?B?aU1GQkprcTg4aFJNZ2xlRXlmN1RFd1dEaWFIVFI0VnlMcUE5Vm9uMkQvNWxJ?=
 =?utf-8?B?ZlNPUWdhelczRnpjU2t5dmt1TlpOczRGR1Bha2orTHl0SitNMWZHZWNvY3lr?=
 =?utf-8?B?ZGcwVVFobXFFdnlIZnFSWk00Mm52a3QraDB1VitLVkNiZjkyODdhOU5QRFFF?=
 =?utf-8?B?TkVrbkF1SFZQUUhjOFdlWms1NTJ2aXFkYVEySjVCRllSTkNCVFd0aWlsc0NX?=
 =?utf-8?B?cHVXY2Q3UFJYZ0pwT3AvdnVYR1NySmtpQW9lR1FFeWpNcDBrenBhSHNsNEtT?=
 =?utf-8?B?RFB4ZWhGeG1YNTY2eXRRbENreTN0Q0llRCtMb3pyTVpZZGpPd1pDbVdHS0Fp?=
 =?utf-8?B?T3Q2ck9jbnMvSW9FQXc0SWhXUnZlU0JPT1RBMUJNcTlZNFVlYjZOUCtRWWVj?=
 =?utf-8?B?RGJsTUVaTklNV0crMmJtVXpiTm9OYjFoeDd2bExabTJIdHozVkNEaVhCL01h?=
 =?utf-8?B?S2hzZW1CdUEzSHRvcE1DamdGcHF0c05UcXNBeWZ1RFFyWXQxYXUxTWZKMUVw?=
 =?utf-8?B?b1lRSEEzRGwxTGZha3YyYUJ0N0p2aGd3U0l5cXdULzlUdmpPSCtYZ1lDbXRV?=
 =?utf-8?B?K2NnTGErQTlzRzdNNjZ6bCtrdlRWNDRvNFJhb1pDR2tmWjB4eHpVZ1NrTnA1?=
 =?utf-8?B?MDdTam1CREEvbHJmd1NFbk5VVkQ0cTErVDdnclNWKzhHaTAza3NiOFhRQU1C?=
 =?utf-8?B?WTQ5SEIya2VPTUhrVWRPZ1MvdWc4YTZHbVZtTW95cm94NGQ3ZXFWaHRYcmh3?=
 =?utf-8?B?YWhack9PYlhHWm5JSW1ybE10OXhFN0F0V0orc2c1ZWkxdXUzeDhQMGh6ZjVU?=
 =?utf-8?B?elhJNUM4bGp1eFdYZHc5Yit3VVhqdWI4a0lvajN0b1VOVW5wQk5TSUhETE8v?=
 =?utf-8?B?am1JZ3d3T1BwaytVbTRwdWFKYTF1cFZKQWlnejNsczNpQUw0cDI2c0RUMndx?=
 =?utf-8?B?WXVMRDVWVmFjMHU5dkdXWXZaMGtReWowcXdFcUFwQjA5a1RZVEgwVS83eExH?=
 =?utf-8?B?Uy9DeE5DQ2VJSW9JVTN2dzRLVnV5M2RpYWwyb3VTNmZIZjI4NFJoU1ZGbU0y?=
 =?utf-8?B?ck1JcEY4QXZTRDNpMXl3UVlVUXRZMFJBSStpT2svY3QxYmxXNXpsRkZPNkFK?=
 =?utf-8?B?NEhPOEhZZlVnZGlEOG4xOHJDMHh6VVBtaHc2clBCc1ZRQkZrK2htd3dtT093?=
 =?utf-8?B?QnF5MTZobWN6c09RaDhkaXM2dEhkUmpnM2QxZzFWbjlycERBY1ZVUVNvcHpN?=
 =?utf-8?B?UkdkcUxhRXFjaVNBVE5mbjRkU1MyempuWXd5K1BIc0R5TWJyaEJ6TExnRC9v?=
 =?utf-8?B?RVp6SUN6UkR6cjI0MTQ4WWNGSVpjV05lZG1Rd055cTJvS2p4UGNabUR6MC9J?=
 =?utf-8?B?ZFhla2d4dHpubitXdEMrczhtUmN3dDJ1UnEzK2Q5eGltdlZ4ZDRMR09XSm1P?=
 =?utf-8?B?S1Zyam9ZRGFpNjBwR0o3THM2N2V1QmZaOFdJT0dxUXhoME9ZWGFmN3J1NlNB?=
 =?utf-8?B?QTY2ZHZncmw0VGJxNS9lM1dWMkxIV3I0V0h6VWVCd3h1TDlEa2hIL0FTeXNq?=
 =?utf-8?B?M1R3U2pOZFRLKzRGRkhWaFh1ZEQ4MTdiaVQvN0dCMUtNYnNwb1Nac3NTV0Nk?=
 =?utf-8?B?MjFsek14U0VvRFAzd1V6c3V6eHNCTHUzNXpoc0IrYXRFdXYvbHpKNDVibUhl?=
 =?utf-8?B?N2pkZjE1L3lmL1F6Z3M5Mmh3eTdCM042Sk1ZbHNQck9OQWovMmVrb1VZdWhz?=
 =?utf-8?B?M1VYTmtBZmYyaFEvNEVSVHFyK3N6QnZRckYxbndHMlhyZGFuTEFVVVhqQU5I?=
 =?utf-8?B?QldNNHhWRnNReGZCam9menZZVnFvN2IyZkxXQ3hNcWdQbERJcjJtZmNwRzh1?=
 =?utf-8?B?d05JT2FkbUZEN0pseTBUSG16cXcyR3gxS3p5Q2ZheGFwOG1rRjJ5Vk5zV21F?=
 =?utf-8?B?cWFySHRlZndZMERiMmFxR28ySmo1RHZ2OHM3N1d5amdHZDBGRS9sTVlQV0dv?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc53be5-202a-4826-0b28-08dda80aa621
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:36:24.7719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7b2mRteko82C1B9W3R4fwnn+nfszligL6wQZj/q4pX/IdfVd+wlLk2SJ9OL4C/h5v2GCE/rTT0XDazAPD1O0mxkkInaweM9ZKxuFER9Ka0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10599
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

Hi Marc,

On 6/9/25 6:40 PM, Marc Haber wrote:
> [You don't often get email from mh+u-boot@zugschlus.de. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> for flexibility reasons I want to use u-boot to boot Debian on a
> Raspberry Pi 4. I want to be able to fix a broken boot from remote over
> the serial console. I have therefore written a boot.scr script that
> looks for kernel and initrd on various partitions on various media in
> various directories, loads kernel, initrd and devicetree and boots.
> 
> I am using the uboot binary that comes with Debian's u-boot-rpi:arm64
> 2025.01-3 package. That one is configured like that:
> 
> CONFIG_ENV_IS_IN_FAT=y
> CONFIG_ENV_FAT_INTERFACE="mmc"
> CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> CONFIG_ENV_FAT_FILE="uboot.env"
> 
> This works as long as I am booting from an MMC card: The Raspi Firmware
> reads config.txt (from MMC), loads uboot.bin (from MMC), which in turn
> reads uboot.env and boot.scr (from MMC), the script runs and the system
> comes up. While this happens, u-boot talks to me on the serial console,
> presumably because uboot.env contains variables like
> baudrate=115200
> stderr=serial,vidconsole
> stdin=serial,usbkbd
> stdout=serial,vidconsole
> 
> However, when I have everything on USB, things don't work as smoothly.
> The system does not come up and it doesn't talk to me on the serial
> console. What I guess is that the Raspi Firmware reads config.txt (from
> USB), loads uboot.bin (from USB) which then looks on the non-existent
> MMC device for uboot.env and boot.scr. Game Over.
> 
> Is it somehow possible to have u-boot look for uboot.env and/or boot.scr
> on the same device it was booted from? Can I compile in some kind of
> search order so that u-boot can find uboot.env and boot.scr on other
> devices than the first partition on mmc? Or do I really need to build my
> own u-boot.bin?
> 

On Theobroma boards (Rockchip-based), we force the environment to be 
coming from the same storage medium as U-Boot proper, c.f. 
board/theobroma-systems/common/common.c:arch_env_get_location()

This is the location of the U-Boot environment in raw, not in a 
filesystem, so this won't apply to your use-case.

But quickly looking at env/fat.c which makes use of the CONFIG_ENV_FAT* 
variables from above, it seems like you should be able to override 
env_fat_get_intf and env_fat_get_dev_part from a board file and 
implement what you want there, provided U-Boot (and/or the RPi firmware) 
provides you with the information from where it was booted.

If you don't want to change the U-Boot binary and somehow you can have a 
minimal environment to run a few commands, you could probably erase the 
whole environment and re-import it manually with `env import`?

Cheers,
Quentin
