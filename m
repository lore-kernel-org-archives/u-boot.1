Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEAACD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6E3838BB;
	Tue, 12 May 2026 18:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TZqNG1Ak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C28383C2B; Tue, 12 May 2026 18:40:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4414836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 18:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8+XvsNa3B6cSqZG7ocDQmyecNx33CgyR3Kd5a5SFVgeqrLT6QkbIoHE7ubmvaJvXJRWoIOTn7HC8GuCRUip31ppnwrXY6YGthaoDgGNMInR00nzJoPTSFPMRU+3BU4jxWvDqqTzD9+02VWAz1XqMyxxuhNsMgpj0NoRqSXKaW2AV8Y2SF/69WtxNsehsxN/bP8jKP26SJs3r0KmgKW1NkoblU0baYir9ie9f46P/Odgn9nyVZArXBBkW+ArX559jp8ndc9X+EZAdqdl674Y/H1sQIPVDi/cAvD75NazZ/vExe9UYR4b0h5/qd2JA+LwSUQDEj02G9X7wLCLzAZQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+70fqyhJ+99fDquzJIE0rKXeS7Dymt7lIcoeYFmMGzc=;
 b=VqbAFs8Je5ePuIX5Zn6sOMd5HEQrKtuvrhwyJchaHV9f4ihuNFqX97HxmcssJD0mVSqJyIkCsSRlWmMo5e6tr8XfdaK+fzqiZ6he2KH06SWnNWDIlsUJSHcS0+LbQrQbbCuFWzjL8du7R54EFbSA1YhuQhHfgJ/srJ8Zduc9OxAg8L0g6FN+qZrP1J9O2xdjMU6omYLdTYsI7f95TZzUtNxwvyNoD4jBQ6p4nxC7XT3uHDar2J+yqc8LfxqEAFPEU1zAYA0E5sa13agueGIY+JvPEEjtmkaStSDnK0pZIfFuY/FwnE8BNGbZMPQizmnHIgHtdNv1fqRcd3VSYiN77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+70fqyhJ+99fDquzJIE0rKXeS7Dymt7lIcoeYFmMGzc=;
 b=TZqNG1Akl+ZixqWKtmWrfFF2SUoLswdAr3dP7RFVkCW7dBPCLwNe9EjSnvicZpF9QhXl2oBxSUMGaujF8i315+FLQ1FMLmrXyBcODSNAV3ryeies+x55Dia36bG6WiR8inbf1bWZoQ31TfNk1Q2z6zVOnoYrieXojFZAXK0awp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Tue, 12 May
 2026 16:39:55 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:39:54 +0000
Message-ID: <c6e0418e-9544-4553-a3d3-5f371b61233d@cherry.de>
Date: Tue, 12 May 2026 18:39:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] allow control DTB to double as "FIT image"
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20260512161631.284143-1-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260512161631.284143-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 10054750-b2a0-4589-c613-08deb045183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: mqoy7JStY03329iCRCsbsoC//Mzcl7RL+0DQyDosEkfzvc4Of0GlI1CMrWco5z73ZKGe92PJSbnBWVDE4TC/M0zMMCREyk84v0zv+9DYCHcdsL1MSP9wgsfBY6YhmYWcg2VzFkzoobjkjGBgtePhEjJOXbqk8ISq93UDIDlvn6w8PkwezyMSrP/BIiGwxGiktTXBcbSQYVhZU1WvAcPzvS97tZYgsr2GYwpamyvhVy2FqjMDoKnCQuLrS8bVezUEwa+mE6mrw7oszNuEK9xv584+Uajv6Y8h63wEAjIahqwc8poB2uxTLLCf91beZlm2ASZLjY2D8y2apVeZm3NuQrkFJsNi2y0q70F4ZakDzwlmnF5EBvFFFpkb9R5pxlMOTcz31CiR5wsKKN1RU94EglKEhURJkS+uq9fCg3ccDvA8L6/IZAnEuvCA4RV64wRiZnalFPGHkhUNE9Uy7GU+95hpDwXljqE//hd61tDBfgZycZC2F4bWjwcgYU0R6eVqzYRtMKS/Fsm7r6OwGIZGB8CQTkDSc2WBs53g+RH2cncbk0N4Hpco4ztlwnCla9VC0WYDx+W9UBeJ4+zIbgT//ih4iJ5wR11WGy79DtlKpfD7N6Foi+kJ3T8MGc+lrxojKQJAVTcJCHHpkh6Nap0Wmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJPUExsNEtQeHAzMFlaZmltS3R0ZEtKNjdoMHByc3RjWmZKalh4NG9xNUhq?=
 =?utf-8?B?Q2FiWm05bWJMYlVBUHNmK2t2Z1JEbWRVUTQ2SEpIOURkbktSUUxneGNUR2JG?=
 =?utf-8?B?WVRDRTFGdHg1a1o5cEVKc1RlbjBXeG0zamhaOFpYVGNjdk9VKy94SFFINE51?=
 =?utf-8?B?QWNDNURnRzkzaithWjNQbG9uUmd2cjRCNnM3WXVrMVRHc2lWNXJmbXlHUHFW?=
 =?utf-8?B?aGo1TzVpdDhCOEUxNncra2p0TGFjY1B6U2xsMjN4OTJQMWN3eG5pY25mU0pq?=
 =?utf-8?B?dU5LVHgvcjEreWVjSkRjWXFUUUs2Z3U1Mjcxblh0TVQ2RUpTWmdoOGNQemdy?=
 =?utf-8?B?V3NYR2pud0kwUlJDN0dPemNnYzVwTEVtd1pMMWVUZks1bUVjeWpWeVl3Y1hi?=
 =?utf-8?B?Smw1TC80Nyt3L09wd1ViTUN1Qk8wSTdWeVkrQ1dycVFub2lCS3lUbk5GazZE?=
 =?utf-8?B?MEk4ZnN4V1J2VGhVTE8yUUpUTm9QSXJIMWdTaWI4T1dMelRUZ1BtbFEvd05K?=
 =?utf-8?B?STBHL2tsb1Fic2tvLzVKSzBieG00MGtXdVM0OGxDZElnZEZsNjJ6TlEvUysw?=
 =?utf-8?B?YWE5KzdVZ3JBZVkzRU5PNkRGVlJ2c2xCY0JyRTdaaitoTXBlWU9mQVk0YWFs?=
 =?utf-8?B?aVBTWE0xZ3kvSFNFOGM4MFJadHRWQnc2MEUzSExJSUxvSm1VQ1hoaTdTd05m?=
 =?utf-8?B?VlBVRGI2NEtHcDJFb2I1WWx1RFhjMnlZZEZYYklrTm9MQzk4aVpNbDB4SXVY?=
 =?utf-8?B?UmJPbElzeWdjSVU1NEJkRFZZdjloajRIRzlqRDdGWWN6QzcweVdDMlA1cEdr?=
 =?utf-8?B?RnFGdytJS0tDRmFySFZoaXRvMDUwbGNacEpiY1pNUkZyelBxTlFiL1FEYVha?=
 =?utf-8?B?Y2NSOU9BQi9GclVIVkdoWEpuR1hITFBTc3FFc2Q5NE5PRzRDejYwck5UYWR5?=
 =?utf-8?B?Q05kTGlUUGhTN0I5ZTVYRkhYM3Uybzk0QUhmL3RlaUV4aHhDU3BoZW5sOXU4?=
 =?utf-8?B?eldpZDFsUnVnZ3ZDRThBNkQwZkpIQ2lBMy9RazlPeXllakVRbHErcEhCVkNO?=
 =?utf-8?B?UCtScTF6K3ZSaXJ2Q0RpYWhJVlRmSzltR2lMMzVHc1JoL25jSFVQOS9tMC9K?=
 =?utf-8?B?bkVNenhPemNhWTkzdUlLdFovbW9QMFp0Qmg3N0JVYTZSaFpDRVlHcnB3SGNF?=
 =?utf-8?B?bUdUaElyeXZQWE5rT2RlYmYzblcvWkIxeGY3YzgwUEYvaDV2emtrUnFpenNB?=
 =?utf-8?B?UW9SMkM1c3U4VDE4Nnh0ZHVFVkxXcE0yMFVjM3ZtYWZvN1R1SGtpMGpXQjVJ?=
 =?utf-8?B?TGxIOWdGRmxzVEVvTmRoaURrRG9tSlczT2tIME1ZRHRUU2lGak5uZmFsWjJW?=
 =?utf-8?B?bTZxVVJFL3Zvbk5EZldHSnB6WFV1eWc5NnZTbG9IS05IMUYyRFJrd2pDSCtR?=
 =?utf-8?B?Vk5RYnZUMFErMkFTc1NHb3g3WEdNVFFXNXBEZVUwQlVNRkNNbmVnQjhxZXBl?=
 =?utf-8?B?U3FjNWo5N2dVb0NNa0dTWDNUbVRweWNIQUZmb0FJY2g1eWxGcEk5WUNxMW0z?=
 =?utf-8?B?eGZacDJYTU5PQ2hWYTdoMUEvR1ZnZjM5SUU1cFNxeEZuWjR4RkdOdHlXL3lp?=
 =?utf-8?B?aGN2LzNTUWV5ZzBqNzlYV3lxb1dqQWhrUjQ5d1haNUgrQXIxcFVmSitXUUhX?=
 =?utf-8?B?cGN1WlpRR0ZiUmZoZFhaN2Q1dlBEMzZqTXBFQU9Yci9JU3RlNGpwWW1KZ3ls?=
 =?utf-8?B?Qi8zQTh1bGs2bW8zcDJOYWZVWmlJZ0d2Y3NiZFd4NjJ1dnVQaWQvOFJ6SUNq?=
 =?utf-8?B?eVFiVkhwSkNlOVpzbWZKRGpDNXFJZkpGZVdDRjg0SnlrSjVIcGNzMnBQOHZP?=
 =?utf-8?B?NGJpSUdEYkVmZFdaT2xFckw3TWRqc2hUVEtrQ3ZSRHZsb1ZRTVJReTF0MFNC?=
 =?utf-8?B?REhlS2h3RC94YjRlVGZYMTQ1SXRuS1pXU2xMbnFVdWFFbkw0dmtCWkdKejV1?=
 =?utf-8?B?ZEVLUDBSQ2lKSXBGY2ZPcm91cmgvdCtyWGxwZVh2ZnpVY2NYQ1N6UjVZM2Zq?=
 =?utf-8?B?VE01K1E2T014VGllMko3MGdsdHZvay90ell3SS85WHBSUzhmNmJQK0gweTBF?=
 =?utf-8?B?WlZpY1p0enVxeHhIQjhTN3FKMUxOOGt6SVFNdjVDdXptN2d2T3N6NnhPRGVs?=
 =?utf-8?B?SDlsV1VzS1hzaUs4NGR0VWdSc0YwQWQvWW1vTnJ4K2hUcDBDQjZOUXJUMytD?=
 =?utf-8?B?WGVrdDAyYzNRZGhHNWQ2eTZRQVdsRzFzMFJNM3ptQWhtazlwbWNIck1Qd1pY?=
 =?utf-8?B?UTFrbFAzUmpqU0VZeFlBb0J3RVNidDhybHJjbG9QSi9CTmxNYjdKdVhCbCtl?=
 =?utf-8?Q?46rUMPfw7WquTEZ2psUOLWeAMguOdEF9d4Ues2T1AJFhd?=
X-MS-Exchange-AntiSpam-MessageData-1: ijGhawlW9DjQx2+egXD3vK7ti8udcUeJ2+Q=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10054750-b2a0-4589-c613-08deb045183f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:39:54.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b24eT6ejDkk5ox5kRWdZeZ4Ymcku06H57EyFVqSlADBjTOTGCOwLg1l0+qMmL9f/Oyt4wev0Jf7RT67AJxjoQVUypfzrtPoQ3JCY0Lz+zQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
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

Hi Rasmus,

On 5/12/26 6:16 PM, Rasmus Villemoes wrote:
> The commit message for patch 1 explains what it is I'd like to be able
> to do, but here's some more background:
> 

For reference:

"""
Writing those scripts in the built-in environment leads to
backslatitis and missing or wrong quoting and is generally not very
readable or maintainable.
"""

> For a long time, we've embedded the boot script in the U-Boot binary
> by building a bootscript.itb, and using a .dtsi like
> 
>    / {
>            config {
>                   bootscript = /incbin/("/path/to/bootscript.itb");
>            };
>    };
> 
> which in turn is mentioned in CONFIG_DEVICE_TREE_INCLUDES, that
> bootscript.itb FIT image has been embedded in U-Boot's control
> dtb. Running that was then a matter of doing
> 
>    fdt addr ${fdtcontroladdr} && fdt get addr bsaddr /config bootscript && source ${bsaddr}
> 
> There are a couple of advantage of having the bootscript (and other
> script logic) embedded in the U-Boot binary. First, there's no need to
> figure out some separate partition to store the script in, and making
> sure that gets updated whenever the bootloader itself does. Second,
> one doesn't need to worry about verifying the script; whatever steps
> one needs to take to implement secure boot for U-Boot itself will by
> necessity also cover the control dtb (if nothing else then because
> that's where the public key for the kernel verification lives).
> 
> Now with the stricter requirements of libfdt starting from v2026.04,
> the above command no longer worked, or only half the time, because the
> embedded FIT image may not land on an 8-byte aligned address. So that
> line had to be changed a little (line breaks added)
> 
>    fdt addr ${fdtcontroladdr}
>      && fdt get addr bsaddr /config bootscript
>      && fdt get size bssize /config bootscript
>      && cp.b ${bsaddr} ${loadaddr} ${bssize}
>      && source ${loadaddr}
> 
> which is getting quite unwieldy.
> 
> Then it struck me that one could perhaps simplify all of this quite a
> lot: Cut out the intermediate bootscript.itb, just create a .dtsi
> which directly puts a /images node inside the control dtb
> 
> / {
>    	images {
> 		default = "bootscript";
> 		bootscript {
> 			description = "Boot script";
> 			data = /incbin/("/path/to/bootscript.sh");
> 			type = "script";
> 			compression = "none";
> 		};
> 	};
> };
> 
> and treat the control dtb itself as a FIT image; so the command to put
> in $bootcmd becomes simply
> 
>    source ${fdtcontroladdr}:bootscript
> 
> and embedding other pieces of callable scripts is quite trivial.
> 
> And that almost works out-of-the-box, except for the fit_check_format() sanity check.
> 
> I realize this is a bit of a hack, but I do think it's somewhat
> elegant, and avoids inventing a whole lot of extra infrastructure for
> allowing one to embed larger scripts and invoke them from the shell. I
> am of course happy to put this exemption for gd->fdt_blob under a
> CONFIG_ knob if that is deemed necessary.
> 

Have you tried to use the text-based environment mechanism as described 
in 
https://docs.u-boot.org/en/latest/usage/environment.html#text-based-environment? 
(I've learned about this only very recently with the Apple devices being 
migrated to it)

Cheers,
Quentin
