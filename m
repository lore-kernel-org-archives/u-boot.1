Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEBAD2E9E3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC85C89395;
	Mon, 11 Nov 2024 13:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h7FPc8YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F8488FC4; Mon, 11 Nov 2024 12:46:33 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E994C88FCE
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwb4WwTyp7Idhy1UtHUbqnNxPrlcC9NO4LZdcu005C9v16DmcQSr2QbbMR9wV/I2zvVwy+ATHbsx5hm9IUf+MxMdWQUIgxrKTri2unCPsrCsC5vprzndbFXqxKdIGIeoZr51qCBxuIYHx5lQdIHih1XSTk+aiQjyUSxnwJy55EArcKIURNojefgMJ2H1KzMZOax+0t246+OkkI62R69SqHAQnU0a+83+RqJh0bhGFxwc0FxiJZgba6bEcwwGOOQi4++I4GljNbFemYucNowbC/rqUFK/K2f7mnPx6SIT+/rB4+x6yyUuTRcOcsZiMfpUHoWr4hpi4bFXE6bJynBkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eA0aqPwghgU5YuVDHIUXFmbs3e36NTg93OgF/Hdd3A=;
 b=Rp68kwiLd9kfFtXb/tm7/zYD964aTMQouNXdbE/KaTzoa2yvYTeN7LHWrubUsa6gKJbEOktW0FovDJdIYMEl91MpWRDbsCs7o2VLo/hNieiPw4moA/Wujs7giRzB+tRWwNzUyoszA/MrjFY3b0aZhZ1MaJAUzZBIeAGDZoGQVLSNw9Gi136CTs7iiLspxaC7OK6tfVCUSVZ+o0No/q8B3hL8X/aCXr2S34zdExGIT9aFiGY1DtLH3rRNZVacIsg9Q6uW9hXnQ0jgizBIKs6prctPGTUicVYEK51QpsvngOdBYyCoU1UpYdaUxG7L7dYEUzSS8FaRcr+bvgvOzjTxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eA0aqPwghgU5YuVDHIUXFmbs3e36NTg93OgF/Hdd3A=;
 b=h7FPc8YJh6CMec3xSYJex7uM2/Ohz8+P8gSEV8Ah7R769hlbXZepL77VFucrA5AYS9/eJuodDVyp0FBUpjNTLYSR3/EABRcJJEll7rAoPPQsmqKZ1BA3XfBNBXc8ZB6D04SGGA9w2AJ1+jcGEhNVKr71mp3cas5r5H1VG8excDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 11:46:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:46:27 +0000
Message-ID: <655f3b7b-0e78-4544-b151-e48f8113c6cc@amd.com>
Date: Mon, 11 Nov 2024 12:46:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: zynqmp: Convert platforms to use binman
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>,
 neal.frager@amd.com
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddadc8f-a206-4bc2-2ef3-08dd024679dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJwcVBFODRhRUQ4N2plWjhSR1BOdFphV2N4bjhscTVZYXVocjMvODErTEtH?=
 =?utf-8?B?ZFlpVDdtYWFNZkxNVkUrWlRSSlJDUnpFWXJSaFh0akp1eHRKNDkrQ2psWThR?=
 =?utf-8?B?aTlpdFRaeG1QNE1lbkxKenAzZ1pDY1JndS8vUGRoTS9iM0JTSHhNc1ZZK0Jr?=
 =?utf-8?B?cjNHdnlEL3ZKUlV4dzhobFRiWEdaRGxaZTY5cXdDcXFLZ1VqZlB0RnQ1Wmh0?=
 =?utf-8?B?ZktFRklvbEhDVGhhdkNWZVRqeW5KNzhTZjZoU2c3elZWemhOWlBpbWVyaTdt?=
 =?utf-8?B?a0xhNkdxdENGRU1CczUrcE5hQ3JyWGYwYnZLaHV4TlRsUWNmUkZyd1RVcVRw?=
 =?utf-8?B?UXNRZW85SFNtSm5aQnVyajFQNWZDRGVOa1RqcUVZSDI5THJocHIwTlZjYVF5?=
 =?utf-8?B?R2JxV0RNQWd4YmErU0RZZVBuZUNhaVlJUC9adUxKN0lRZFpSMVNrZFVyUDFJ?=
 =?utf-8?B?N1BXa3hSWjRoNWs1YTdIYXlmV0JmYmJCa1NzRkJVL0JadVUwZ3lVZWxwYncx?=
 =?utf-8?B?NW0xY2Njb2pyWTM5eXRuMTl0RW1KRVFsRDU2T2l1dVUvKzRXQjBkWGVTN1dG?=
 =?utf-8?B?YlJldkZlSjJSa1VoVERVVTFUT091SUZNVVRRaTJwVFduVGFlQjJ0czFURVI3?=
 =?utf-8?B?NmE5WkNsSHhoRVdWcXJVSEZjTmlVejRSRVN5dEdSdk1tT09MN0I3Mml5ck1y?=
 =?utf-8?B?SGUyalh4TmJKSHFaWEU2aFhDQXFTZ1BCWEtHY05hRDdKd3k0L25jVDRDZDRt?=
 =?utf-8?B?alFEYXloU2tTd0MvNWcxUGd4amtUWUd1Vjhsb3RXa2liWXNkejdDeHdKZzNI?=
 =?utf-8?B?dDBRcW53UUVKb2ZWQ1R2djZuY0pkdXRMb0cxTWlNUXJNSm4vRGtianZRU2R6?=
 =?utf-8?B?Q0dVTUlpdXowaldOTndlTzN3T05VcXhNVVpOcFBGMlROeTRiUklUOUcwVjZ2?=
 =?utf-8?B?b0VCM3ZyTUZ5dWUwZE5VVXhpcmJ4SnY0UlQ2OWxkWXUyZUgvdkVwdDhIL2Q0?=
 =?utf-8?B?Mzg0V09wcC9zWmMxZTJzd0pJMFRsZzVITUNkanZlRFRGYnBZTXZHTlBHTGpL?=
 =?utf-8?B?VitBMG9zNUNtNkFBcTZuMDRDZVZ1V3VOMW9vbHlEUWZtNFdqQmRLTDUyVG9v?=
 =?utf-8?B?QW5uT1ZCbVMvZVRPTU9zMjU5UzNwUjNnNU42TzI0OG9yVFpldEU2YzdQQlFr?=
 =?utf-8?B?YTQrVGFpTkJua2R3UGZlOXREay91Nkk4WnQwdDk5TW11bzUrV281Q0FCMVVy?=
 =?utf-8?B?NGYvaWIwSWZmTzZLUGtYT04rZnhYVktuRTNwTWdRVHR5RHJSeENuemJMSzND?=
 =?utf-8?B?ZC9aOTRSK1QwdWVuVDFTazUxeGdXMER0QVF3WWMwNkIxQ0hldlJCY21MVm1a?=
 =?utf-8?B?bUpiZ1RZVUFFQWdwZFM2clZwSlZoZklmQ0hEVGRCZjdVN1BWL2JWUGNZWWFE?=
 =?utf-8?B?RzZONklmUjE2d0t3bTZaVDlWT2xkRVdxdGFNMU8xU05EdHJaZmViY2ZTOFVQ?=
 =?utf-8?B?TGptSG1oSEkxbTJvQVlHN2JvT0ZmOEJub1FNMEF2NitSbDZCSW5ieGFTQkNF?=
 =?utf-8?B?SGtJbDBMbzlKZ2tIeXYxeFNFcUxqZHAzYnF3ZWpadDRUQXVhS2F0eUtuTVJ3?=
 =?utf-8?B?Wm8xYlBGK3Byc2dIaU9hS0NScUlKQUltYjBwUDdwVnhOc2pMTDZWTWF6bGdO?=
 =?utf-8?B?UnczZ3hyTzFjMVF2RlVRWGZicmMyU0E0RlR3U0NnbTdGS2tvekJVNllxYk9N?=
 =?utf-8?Q?gK01zRwLOkBqiSlgd0fQq7JD5dI7WUnZrzF099w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9KSks3YXdIcDNwcjBzdHFyRi9ubFE1NkpMdWtXRzNtVXJNR21JNFZ0Um52?=
 =?utf-8?B?cUFqRDN2MjRMbFFNVEZVMTJGZksyVGdERGR3MStOUko3WDBQbTh5SUZCM1FY?=
 =?utf-8?B?NHU5RmcxNTN1S293MUNub05Cc0M3anJZT0J4RWVmQjBpTVNjNzlhek9jamgv?=
 =?utf-8?B?KzZDN2pXRjBNU3VPRDBiQTM5RjV0MGkzMkpGUDZKNzJwTmx0WkF6Z292WlNY?=
 =?utf-8?B?QXY5QkN6MHpKRGJYREQ4SlJSd3hTTHRGMVhZc0FreEVkQ2hxMldjMEk4eFpY?=
 =?utf-8?B?azFiUG40V2ZyYlAvOWx6OXIwMmpXK0E5b3JqbERLUEM2cnlQQVhKZ1F5Z3g5?=
 =?utf-8?B?dHdaT3hoeU1pTHFOd2NpTnI1em94MjNpWnJ3U1FDcWEvSkhKSjlsMTkxNHNj?=
 =?utf-8?B?ZHRUQlVHOGhEdjh0UzcwRXBvcUp1Y09LZVlXemVhak95aTVtK3BWcDJFb1FG?=
 =?utf-8?B?TWxrL1lsU1ZxZGJ3bUxMVU8vb3VsY3QyKzJUUGVIWmVZK0hCdEZxNGd4NjVZ?=
 =?utf-8?B?QnNaRG92Y3FiL1ZzcDJsYzlpYlJ5a2U5RnFyNUpDNktKSzZDaG5VM0xxRWNP?=
 =?utf-8?B?VlhlY1VTRjVpSkVkL1Ftay9QdWxwV1dxMlFvdkZyOFRWODN3cVZNU2p5UUsz?=
 =?utf-8?B?UlVBSVU1Z240cW1tYXR5VlFKQmF4SzVzU0hLaTVKbnVtYjN2a0FqVUdKbUR4?=
 =?utf-8?B?Tk5kT25DcFEwSHJtOVNMMWlodDM0YitONUNEOVZIZC82THJTWWFkMnlvQ2pz?=
 =?utf-8?B?aHYvdFg5dDV5N2dLN3gzd2w0SlB6UG4wMExvaWppYnV3WVQ1SWV4dGxUOVRQ?=
 =?utf-8?B?WjVpSjBnUExQL1B0WVo2QTdReFpZYnJRN3d5bGpieG1iMi9INWFjTEVPRlBh?=
 =?utf-8?B?UjFPd09JdDR1aWw1T1FCeTEwWTZCYjYydDd5Z0k0SldEc3NPcjlQbmR0UVVw?=
 =?utf-8?B?VEZ2dktKaEtZMHFGTnpGeWhJWExlanZ2czkxQzMxa0dFbnV4bGxhLzl3ZDlN?=
 =?utf-8?B?ZUtBTDBpRUViQi81U1g1cFdHZkovUGxtdDJqUm54b05QV1NjeVEyMTRkUUV3?=
 =?utf-8?B?ZmZtZm1MaHVtNVM1YnUwTnlYT0lBVGlKTHFKODR3V1l0QzJJQzRDSkxqT2JQ?=
 =?utf-8?B?M1dRS0Y5NC8xSlRXSkhOSlFzSE9hZXc1THNzd2xpU1h0cW1HZzdjVUwvOWFW?=
 =?utf-8?B?TFJ1U2JBUjNiUTRhSzh2bkhnaGc1NHowNDRRSWVzMnlDeFlFdkNyZ2szTy9p?=
 =?utf-8?B?SENtQzNaUHA0czU5Z3E1QXRFNU5welJ5NCtDWTFiM2xiRzRKVmJBcDcwZWJa?=
 =?utf-8?B?c1hQT1BRQlBqaGRONHY5R0tQZ3gvUGs3TWx0WUhndy9QQlJhY1RmZVluaFlP?=
 =?utf-8?B?emx4T3lSUFZ1djFnaVFkR0dYVWpyclQ5MzJlRU5rcnpaNVFMWUVGV3RkMHd2?=
 =?utf-8?B?UTJZcHVDUkxWenR4N1FDYWxKZFNScXNkVHY2eXd5bW90OFVMMmFEQXQ4blRv?=
 =?utf-8?B?WnRXS210T21QeWlhNTY4Q052ditDTjJPNzNhdWZ5RHYzTUQxWVhCL0M3MDdH?=
 =?utf-8?B?WHNHOExMcXlZUHB1elZBNncrSDNIcmRRL1gwZ1oydWhtcjFjRTBJUTBmM3Vv?=
 =?utf-8?B?RnUxMFdrOHhhZG1nK0hnMFB5YTRMUTNXM2pHa1FKUVg2WGxrb0hwdWt6WmhB?=
 =?utf-8?B?QnJTazh0bHk1akFPKzIyMEdyTnZGRkkvYURyTFhsdG5WekJBZll2VVZSR2E5?=
 =?utf-8?B?REhQMEkxbTlNTzF4TGNPb2NtQVpCMnBqL012T1Nxd1FRWXVTd1g5Wll4SUx5?=
 =?utf-8?B?QXNTbmJPbk5lQTNkSHZQNzBPWkpIcUI1MWppbGM4NUl2dnBJZnpyS1ZZRElE?=
 =?utf-8?B?NE5DZklOY1oyMElwdjJGMWZOdU1BcFhoN1Q5M2Qwd1AzbDhzdFpGY2c5Zmhy?=
 =?utf-8?B?aVNaNjNXYitsc3RNVkNLSmdsNnBTemJHTWZ1dm9KM3hlSGNPWkQzNVlUSEZ4?=
 =?utf-8?B?dytZT2ljVVNIdjRqKytLVys2U0g2TmcrRC9wcjk3K3YvZFQ4bHhzeHUrUjA3?=
 =?utf-8?B?Z0cvQnduS0RrWTl0NDNWNzV3a3BNYXpSVUk2a1Q2NW1xeUljR1NhaWFrVkQ4?=
 =?utf-8?Q?vU/ousK2hbHXCIGHYrggxGfOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddadc8f-a206-4bc2-2ef3-08dd024679dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:46:27.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxFrWZcKc116yi7oOXERQ68g5xBtnixKR8JPkgCk6LNF/rwe1hV600zQ7Bp9RDK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
X-Mailman-Approved-At: Mon, 11 Nov 2024 13:26:21 +0100
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

On 11/1/24 10:17, Michal Simek wrote:
> Hi,
> 
> I have put togethere couple of patches to convert platforms to use binman.
> The first patch has been sent separately. The third (SOM description) has
> been also sent out for ilustration as RFC.
> The last one is just cherry-pick the patch which has been reverted because
> our platform wasn't converted to binman yet.
> 
> v1 of external description
> https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
> 
> RFC for SOM:
> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Change subject, align commit message
> - binman - rename variable
> - Use relative path
> - Use separate variable in makefile to also handle empty string and default
>    to u-boot.dtb
> - new patch
> - new patch
> - Align fit,fdt-list-val to have shorter lines
> - Add reference to defconfig
> - Rename zynqmp-som-binman.dts to zynqmp-binman-som.dts
> - Use conf instead of config
> - Change image name from image.bin to qspi.bin
> - Remove RFC
> - Change default addresses for BL31/BL32
> - new patch
> - new patch
> - Rebase on the top of my series which do conversion to binman
> - Taken from git with all tags
> 
> Marek Vasut (1):
>    Makefile: Drop SPL_FIT_GENERATOR support
> 
> Michal Simek (6):
>    binman: Add option for pointing to separate description
>    common: binman: Calling initr_binman() when BINMAN_FDT
>    arm64: zynqmp: Describe empty binman node
>    arm64: zynqmp: Add binman description for SOM
>    arm64: zynqmp: Generate u-boot.itb and QSPI image via binman
>    arm64: zynqmp: Remove mkimage fit script
> 
>   Makefile                                      |  29 +--
>   arch/arm/Kconfig                              |   1 +
>   arch/arm/dts/Makefile                         |   3 +
>   arch/arm/dts/zynqmp-binman-mini.dts           |  10 +
>   arch/arm/dts/zynqmp-binman-som.dts            | 225 ++++++++++++++++
>   arch/arm/dts/zynqmp-binman.dts                | 111 ++++++++
>   arch/arm/dts/zynqmp-u-boot.dtsi               |  11 +
>   arch/arm/mach-zynqmp/Kconfig                  |  14 +
>   arch/arm/mach-zynqmp/mkimage_fit_atf.sh       | 240 ------------------
>   boot/Kconfig                                  |  15 --
>   common/board_r.c                              |   7 +-
>   configs/xilinx_zynqmp_kria_defconfig          |   3 +
>   configs/xilinx_zynqmp_mini_defconfig          |   2 +
>   configs/xilinx_zynqmp_mini_emmc0_defconfig    |   3 +
>   configs/xilinx_zynqmp_mini_emmc1_defconfig    |   3 +
>   configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +
>   .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +
>   configs/xilinx_zynqmp_mini_qspi_defconfig     |   3 +
>   configs/xilinx_zynqmp_virt_defconfig          |   3 +
>   doc/usage/fit/howto.rst                       |   4 -
>   lib/Kconfig                                   |   9 +
>   21 files changed, 418 insertions(+), 282 deletions(-)
>   create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
>   create mode 100644 arch/arm/dts/zynqmp-binman-som.dts
>   create mode 100644 arch/arm/dts/zynqmp-binman.dts
>   create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi
>   delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh
> 

Any issue with this series?

Thanks,
Michal

