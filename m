Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C52C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEF187646;
	Wed, 20 Dec 2023 10:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Za1j99tD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1736287692; Wed, 20 Dec 2023 10:35:48 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06138752B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXu7ZEX1BMXt8W/hQVooCJ6WIVA5DufHi0zAvznKr+q9chcac6ULB5KIAwwvvHcWaE+tNtl0I9zj5F7bjsn38lsYJD7huiM3Nz8sv503g1Sl8KU7vloNgXdf3gqkyxSFyl/k2Z1rsys/3GTogh8w4gY0VKOYxLigu91j2/A5T1DyYiGg+ct8UegtFtMy2G9ioCXCLcKMEvqok4xETS2vKyesRgAev8/Xd5rjNTWmeJjmX8E8lFdwzTUhgum8iWhtBfxYCxnfwYBp3g95sZ99cGQjsD8E2IzUFiMbsz6WavWvlzF7fi0cXPtg/+t6jbqYo/pXiJSGu8h3MGeKPm4b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jrcK8TpZf3JAV4+M7DrZzrUv2Yh8fTJUI3wA6m6vxg=;
 b=Mi1YelUFHoMS7miEYTULQgp6JgKpSzgfChOD4ZoGiNbzo1ei7F08TdPBk3UaryEV83/P5HVod6r6zY9oZIps0eXAymlTF9NDfIoG8bYN1l34cwEm4k4zyo8HbZpw3tXYU7c4nJjffPtvoBDXe3lNgeCjFQCKCu0O38KuKVdO08RCC9Q/s4K81pRdMQst9ncK1Kelp4orD5VFepjkDJspyePxfj5D+EzB+H6npLQn13CLTTMXyKrPv25wDnZmZ0FNLLVAu8AiupIo6XVnRJh63/M8YZVKfqQTbrLf7B09Axau6G32p7mQjcPV8qOjqfHWtaeLuLN+EmuxuswGr55TXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jrcK8TpZf3JAV4+M7DrZzrUv2Yh8fTJUI3wA6m6vxg=;
 b=Za1j99tDIFrbKsH3fPTFVJfqzGJCYAJV0b2wPreWLhQK8DHe0ywiVCJ/JF6gCyWX5NbvySrcvfMP/cBfyu+W7L1KRNMje2v4alx0Gh+iaGkk3RWGOExiSuKtK3G95FdP+GJYe3arFf0ogEIV8fypEPsnuruzb67fCYj8HXHgTMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB8PR10MB3660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 09:35:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 09:35:42 +0000
Message-ID: <aa0ef8d8-45f1-4199-ba89-67ec1bb49a7c@prevas.dk>
Date: Wed, 20 Dec 2023 10:35:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Makefile: pass -ansi option to cmd_gen_envp
Content-Language: en-US, da
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Fabio Estevam <festevam@denx.de>,
 Heiko Schocher <hs@denx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Eduard Strehlau <eduard@lionizers.com>
References: <20231220085955.25561-1-sebastien.szymanski@armadeus.com>
 <20231220085955.25561-2-sebastien.szymanski@armadeus.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231220085955.25561-2-sebastien.szymanski@armadeus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::12) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB8PR10MB3660:EE_
X-MS-Office365-Filtering-Correlation-Id: 18034326-ed66-44b7-fe68-08dc013f08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYQf+m3UOkF6F9+GJ5uIQifpPm0opaHY4skSYhuRsqctWGtPEqVyKwNObuUMeDgKQ1kwbReqznTEhGVSotm6kCgpcIBXFWSvwVaK7yOszkHg7pmJsa+Zkjj1q/z6O/D0e8Eg7NDSNvbkCrmKyRC60LjfVgshfeI5ue+p+qHCMrsIwiuUdttlKWb6e4p+KSVWQRslSEpjHgb35Y5IdPR2bb5CpD17/hUZqgM9cbku3TSsy1HZtOsovuTgBPgxzaUhm4AidBPv0Pp61U03B5uePS7YxsKiDywJKIGCbZmbP3Sr3GTdfIztdkq4NB1lzBCc9j+AFOne+pyy73NyuPZHXHBlXkj9zVr7UH5Fb2+QLMSfP45n2d2mncRg7yLyajx6TXPUOhb7hnp7Ur9znHz9tSrOlZOtr0sKhgy9xD2t/p1HQaoqhz/TebX1FFUfE7GQZb/5/qVLPBHQvmiyKxs3Qm6Lth0dC3R9zyjeQCy1bn24Fexb1e7UcvOkGxO1rNqUkLotHVV2hI68ftCwdmz/nxvH2gb48kVo5i0+oB8HiPYU4po1OaPW8Ojayxgm9IwcyGIOoXwM6+8zAYT0nOLK8FxPhp6NxhIesIZs2KkB2KKJxz3gn6biw37RdK5T5NW8D3qtS3LDjk8U3FQsfTDmXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(376002)(366004)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4744005)(8676002)(8976002)(8936002)(4326008)(6512007)(6506007)(6666004)(316002)(5660300002)(44832011)(66946007)(66556008)(66476007)(2906002)(54906003)(38100700002)(478600001)(31686004)(26005)(6486002)(2616005)(41300700001)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVBWY3NBZG9HZmo2eDJRQ2F1VEQzblplSXJ5NTVtbksvaXRQZVF2U3BUcEhU?=
 =?utf-8?B?M01YQUordTM2MTFlbE9jS0NTVnN2WkxSTWRhZEkvY3hrVXMrY1FrZUhId1Fl?=
 =?utf-8?B?RU9vTVdCOUtyL3ArYlNKcmhFdmNSVWxVZWlaQXBVQW12VDFGdFMzd0I2dDA2?=
 =?utf-8?B?YWdRSHM3cjMzZlNoczZsdStZNG40NVZkZ3BFLzZRMkNJMUdncFk3Y05wRjJI?=
 =?utf-8?B?ZktVY1JYWE9SeVF1NjhWYVdicVZuS3pkUUk0NXMwY255OE9iNWY5RGpCYTIr?=
 =?utf-8?B?WHBiemhIdHo5NFlTWDk0ZEt5Tjl5cEE3UE5JdnM4RlVGbjdhNmtROU5RVFo0?=
 =?utf-8?B?Mk9RN0hMM2RjZURtZDN5MTR4MERMd05QYkloUVpsdFlDSjJQOC9kYU05VUIv?=
 =?utf-8?B?QzF3azBydlAyWmRDYUljN0FFU2tNb0wxQzM3U1lETFdVelpGM05UM0FhTzh3?=
 =?utf-8?B?WFU3cE5LZlN3WjdjM0pRL3ZMclljRm1NbTIrM3hwckNtZy9teUlNek15Vzcz?=
 =?utf-8?B?bnVPRjhyS09xdkNrZDJsTlROanRUZkxrUWNVZjByL1E0M29CdHZGRDN5OWdU?=
 =?utf-8?B?ajZSMEVpTVErcFVzYnNNczZaNXVJdXBoSU16MVVRR04rZ0pYSDkxY1UzOUpV?=
 =?utf-8?B?amlmUk52ZlFsWlRTNVh5VTFhcEJaR0d2UXpjSUhMRjBJVDRDVkFVbGdDdUEz?=
 =?utf-8?B?WkFaUit2SHNITnNXekhyb3UrUnB4VkFXdnMyeHY0dVUwSmtYQlE2QW5BMTZP?=
 =?utf-8?B?WGJ2OVNHMExicVBFemg4Z1VRNVNHRlVlbTdkQ01hZ0QrQitUOGhVNnlBZHly?=
 =?utf-8?B?aDRQVjFTdjNpRmZQRnlnZ2JUdkFrR0t4MTJZWlExamZIVTd5NTg3RXVlVHZh?=
 =?utf-8?B?aTV0Vm5IZFkra1ZZOFVyVnZKaENBandJLyszdEdUdDh3ZUlZdldCaTErZ0wy?=
 =?utf-8?B?ZU9wRVRTZlRHY3g0Wk04MkxtRk5sRXhEblhSMHZ2VXpWblZYYVlDdkxsY2lQ?=
 =?utf-8?B?TnVDTkNFUTRPREcrL05rOWtrZ1B4Tm94YW0rZExuMjIzRm1JN3NpWjJIN2dK?=
 =?utf-8?B?eFJ3aThUOHdGZmFGbmhFeUxBZS9HMkFkSzJjOFJLUDhiOHFGRmxLQ3pnbVp6?=
 =?utf-8?B?UFZrNnVmeWhiYVpad2s4TFYxMkJCaldBUDdCbGJxQlU4bW9RZ1lqZ0xTbkl0?=
 =?utf-8?B?SGxqNzBacHduVFFvaWZIT01xUWx0N2xjeWpLbGRLTnd0S0VFYS9Ucm0rUm5V?=
 =?utf-8?B?NitFSHNGSmN2Q0JkdlpQd0ZrUVpkTHZPQ3RXZm1Yamc3b3JvUUNuQWQxSGpr?=
 =?utf-8?B?L3VqME1ndGtndlhDaHFWR09DY1h0VmNla0FuTklYU1BvS2JtQjg1TWNtV0tY?=
 =?utf-8?B?WEpIbG5CVU5JdlJ5UU5WL29CYys5MENPNDZnWHBpZHdMOG0rMXdVYS9nQXJ5?=
 =?utf-8?B?YXRGMFIzOGJIb1AwcGlCekVvVGZvTFFQVkE3eXh2RXJMaXVxb3llSzNrbEFm?=
 =?utf-8?B?SXlZTWx0MlV2S2FoTWQ5WUxvRld0UWd3ZkE3V0VQVXVhZkVad0ZENGljbEtp?=
 =?utf-8?B?TFlhQVpxdnl4Zk5LVm5MNWx5VkJYSHR3MHF3YzJ0bUJtT01yR2xyd1MxUUts?=
 =?utf-8?B?T1dkWEUwVVRpYjRudk5oUlo4N3lkVzZvUHFZNnRIb0QrQm9zSkNzQUczNS9s?=
 =?utf-8?B?eFFBaWxoWlc5U3hDV0daaVE4WWo4eUUwMUI1ZVNhamV6eWprR3J0VVhsN2hE?=
 =?utf-8?B?RkJiWmdyTWtSSHpaWDIzSHduTThWcllkWUR6aDR6MGxocFVQejQ3aXJaN1JM?=
 =?utf-8?B?SEJLNUdBTHRuTExTUlVaMkxzNUk1SEZta3EvaHFWeXZuSjhPcXdYT2dEaVhi?=
 =?utf-8?B?NHZUa0xZQzRZVk1EUnJIL0tVTVhTdFdvQmVJN2ZuWWJXYjM1QkpVTWtwbUxo?=
 =?utf-8?B?OVlmZ1VqNHdWd0RjYmRMdGh3ZGpRb3gyNFVqV21tTWNyUndjZFpqWVhGZUZQ?=
 =?utf-8?B?eXRwSFZNdGIwcXAzdEk3M1o2RS9SazA5cFFYYy9QRXBzVUE1NEE3VkIvSloz?=
 =?utf-8?B?MFhNbHJWZWdQQjIxcVo3c09EU2NJR0FKcWwrdWk4bk1kZng0VHhEYXh1NEJn?=
 =?utf-8?B?TzM3K1ljdHFEbWF2c2pMaFhlenBkWkwybjdUS2hhLy96aVBBdWZCUWpTOHBY?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 18034326-ed66-44b7-fe68-08dc013f08ea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 09:35:42.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vArFys1EN8MZlcUblBSti1dmg196uf2AkQlWdMLXajnHNKkwPI4FmsULYRYTf9WLr7OnxskpTW8zp0rA4knxAmztixBU+DVmuI8BXHkl6vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3660
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

On 20/12/2023 09.59, Sébastien Szymanski wrote:
> Without the '-ansi' option, the 'linux' string in env. files is replaced
> with the string '1 '. For example, in the
> board/armadeus/opos6uldev/opos6uldev.env file,
> 
> kernelimg=opos6ul-linux.bin
> 
> becomes
> 
> kernelimg=opos6ul-1 .bin
> 
> in the include/generated/env.in file.
> 
> That's because 'linux' is a System-specific Predefined Macros. [1]
> 
> Pass the '-ansi' option as suggested by the GCC documentation. [1]

So when the .dtb files are built, we use

  -x assembler-with-cpp -undef

and that -undef seems to suppress a lot more than just the linux and
unix defines. So I wonder if this case should also use that? I think
that would also allow the c++ comments to remain.

Rasmus
