Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A06C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 13:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3408876A6;
	Wed,  6 Dec 2023 14:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vaKPcKMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4E38706F; Wed,  6 Dec 2023 14:42:05 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3D687708
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 14:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqC+SXIglSPkBftzIL/dG2HpqEe75q4NNU7rWPG0HiVmCrjDwoueaB1FMLdByLtRkcNX5EUFDlZ7A9AxBRDCA7MbEsjnWJuueJSJqEnlB0Zr8heW9oYFJm23IlYUU8L2bn40LdlyXKDRjQDqYwxJaiX2ma1F78JY/f0TGPPUk1QOlvjMlroREMHXPhlQNxUtR6hpZ+5trHnL9QgY4ZnBFNuoYTVigPSoh+eyIrNWdBrqJwWTpjNSfHRFhYmogQXMZgxgbH5VQKHG11X0QdEDiUxwPhDkXVuGkZ41aLqoxZhUsZuVMpKvlmcUa+9hfdwMtfrG0F1LE8uPu9YKK0Chmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91EZkqHHLqsv0ftB/VumXpYgFbWYh6hgj4c7Sic1AFU=;
 b=W9ToO/KtZfg7gY7MttK0q/nltXyu3U8uFrZiQNPmXHsQhTIND5prn+O9C7yo3mKln59akX/1FBdreTDgY+MlasMkpid8iTyxFuDjb3NtBoeV1wW/zQ9XFH2nix6VT/js0nSVoG4vKFARu+dEzsLhnFrQcO5CIYOGSJT2Z5Tqet35yLCcJbO+zfpKHvrJdU3fsBngft+Zjf8fzv8OyztB4hSoZy2BUaYM4+ulXDFDIysAjyTPeygBl/bWIpizsmjl8/0fX25TXc+DQNu32sNCrtaDD5vDa12UbU+p07qnRjuX79i3zZdCgSqEiuWX2rU9lB5rgMp3wFH8046vhwP17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91EZkqHHLqsv0ftB/VumXpYgFbWYh6hgj4c7Sic1AFU=;
 b=vaKPcKMKQXDYtd2c7/xAqrS56fmJPrtWR2NqXyhAXPBKlRkEkhj0bvXxqomSk3od/12e2kRNrDF6cGZP+uYU13uKn427yJZhorKHdQr7tHBUeHU8IR2lYWSi7cuQw5/dLZ1EDmbpCjrWZ+HXa/+jOZet2xqKEx6Q/sw+zHpIXHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 13:41:58 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 13:41:58 +0000
Message-ID: <d7471910-b1cd-4aeb-9d7e-165659394314@amd.com>
Date: Wed, 6 Dec 2023 14:41:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, sjg@chromium.org, git@amd.com
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
 <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
 <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aeb74a9-a335-41db-2f4f-08dbf6611e0d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1RdSSTSngix/r3exjJnEXEqLY2quGUBfMbknM0pnMlvVYEgB9OmVNVLNzQVyVIZBnDSrfG9xv9rLDVWESeiaF1Hkvai2pyISZrWHI+S8quaAkrFouGMoPAIm6nXz/TsEKP/s8qNubOT0oWY1n6CT0Km8Y6W3r4J0UamIUm2f56mjl20JrM05nVN91iXeQpDMAOJzlJgBC5uLlOr2HO8llWfLemCOvb0ABIj7U1ZHJp8VysRLJjLQiAy7yS6e6lpDOrODM2LYF+lRiQehiaepWfiM8Gab69YHeJfkVLD98iqTBuCEwA0UBynB+Kec/ALsnSAi6LkEUV6ZyQKlu0FtKw+qtUX95bujQfC4SdyzygFeh0BOQFU2gnAT7Zm5BKB7DOczkdTT8ZDVLrYQAtsbXhlgLWQII0hI51LZLnC3ydgKat7nmAYdm+4Z7l/QylI3W8fkqX6T2PpjlkMAL6YWmLImj4nDAT0pnQYJGhJtpHXAa/0BrNP7MQZG/G5cZiflvbO2huiCCBkOzDgr/hLdA6eBpyK7gJthOF2T1nVYc3OV2SCFYmaSJmoMB+BYmygTNgmJJddyp4rQn3kuAaea5wNIgog/XG0QK1RqL8eZsDn7fyd5pqy2GvprvtYWRCDP5kBhZ3WLMR4n0ZRIIw3Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(478600001)(966005)(83380400001)(6512007)(53546011)(2616005)(6506007)(26005)(6666004)(66476007)(66946007)(110136005)(316002)(66556008)(36756003)(8676002)(86362001)(8936002)(41300700001)(4326008)(44832011)(2906002)(31696002)(5660300002)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JWbXl1TlltemtIUzFXSFJKcU9DeDJaT0NZR1dwQ3Y1RC9vd1hhb3Y4bHA2?=
 =?utf-8?B?UXZGWVJYTHJKTkdmc2pFNk9aeHc0NC9VUWF0NmtnMDB0c3BZUWZCRmVWaE9U?=
 =?utf-8?B?K0g1ODFmbnRqSUQwUStOVFNqUHY2R3Y3UVVJa3kyTVdsMS95eTBnVXRRazZ3?=
 =?utf-8?B?VEhlUU5yeFdXRCtMa2ZOWCt4YmRsUDJQWnJhcnRibDVGdUZPaW52Z3dGcWk5?=
 =?utf-8?B?dytISDEyY3VjNHRISVpLRWxnRTRIYWFzRW1zR1Q3RDNtNFpHbXRKRGJjcFVD?=
 =?utf-8?B?dExUM21kOWlSUDdOb0g3bWhMcGNMVmFuMlplWDJEQVBxQmx3eUtVb1JhNVBU?=
 =?utf-8?B?R2ZvTWZIcFlSZGNKR2hmaDJkSXM4Z21FY2xZQ1U4aWVySG5zUlg2dWNmdjdL?=
 =?utf-8?B?aW94WUFHUjErSUNJWjZUMVhxaTVQcWdOYTRNUmR3ZlNDd2FPVGlOcHRHWEZs?=
 =?utf-8?B?V1Y1cnRORno5bG5lTmxRai80a0lSV2JjMEVEK0E0N252RlJtZUtRVFFLWkFS?=
 =?utf-8?B?b0xKYlBlK3V1Uks4R1h1VGZBcWpYTysrcEpFWDRXczVFcDNFSWlXUUZQSlM3?=
 =?utf-8?B?UndBYXk3amhxMlkzazFudjhCaDVUbDMvcG9qbkl5Y09Jb0xVTDVrY3VMR2Fo?=
 =?utf-8?B?TklnUEtOYmtROXhJei9RamlsVEU5SDJETk4wU1hQeUFVSUhBZmhneHUveDNC?=
 =?utf-8?B?aWFUbGxtZWdGQ0JiS3BYRXpHNDI2STBUSE1oOCsxSzVPRk1nRTN1aWFvMlVF?=
 =?utf-8?B?dmNqL2hEQzhRcE9uajFVTzhDbUlPbjNQNk1FaVY4bFJHWVNYRzVSZDhLcVQ5?=
 =?utf-8?B?eUpFL2djZnBHcFZXcHhIS25oSGtpN08zb2RQSjlTU1NJME5SMDN1ZVA0SnZS?=
 =?utf-8?B?Z05IK0RZTjFjeFI5QitxbFR4ekpSU2xrRU8yZEdaNHZDUXFkcEJyY2lzcXlX?=
 =?utf-8?B?SWxkOHZMKzE0ZXlmSS9Wd2UzbWxvd01BY2kwUHNWTThWZ3ZYVTlpOFNKVzFw?=
 =?utf-8?B?NmtHMGE5cDl1RjNzSCtmd3ZTQW5IZDNOUHZpb0o4M3pwaUhhZFN5dnI5cXl2?=
 =?utf-8?B?cXNWSURGbGt4eTk0QWVvMGlwblVnNXNBcGc1RU1WMmt4Y1BoVEhhUzVTWFpZ?=
 =?utf-8?B?UXVzS1Mzd0JKNWoyZm5iakp2RmM4MEVJNmRxbXFqMy9NOHlUOGNZRFNpUitO?=
 =?utf-8?B?bHBua1NMNmhOZm4vRVZYNURiM0JMWFRRYUd0c3gyemd4RDhqRFpHRnpXNmI3?=
 =?utf-8?B?amxOS0ZzYTl1NjhNcmwranNMZkJKTk1YSGhhaEdDWm9wSFp2aGJ0Nm5IaXVC?=
 =?utf-8?B?TjVjeEM5UWhET09oeHJONUVDS1dVMGl0S3M5VjFSS1ljNkFHSlhnWUN0MTJk?=
 =?utf-8?B?a3g2K0JRZ0lDb2YzNXhkWFBHbEJzYkdoQXhoNTZoc0twWTIySmpvc1cxVm5a?=
 =?utf-8?B?OHR0Vm5MTGNNV2hYdTk3MHBhWXJCckQ0L0JaVTAzbFBuUE1wbUlLSldoNnoy?=
 =?utf-8?B?aGNrMlFPU0xBZ2dPTldqTkIzUWdjT2dyR2VWZWJaK0llNStYUDl2Ris5RlJS?=
 =?utf-8?B?bkhTQkVzUEZVZEM4ZllpdFJFTlpMRmRkeGszYUoxWFZRVEpnclgxREpkQTF6?=
 =?utf-8?B?Sm9vTkQrMHpUOVg1RndlQ04zMXg1RUZ0NUxab0VBczZGZG8ydDBUMWtxa3dV?=
 =?utf-8?B?QnUxYnA3YU1EQXNQNzRheXpEU3pDcHRPZnZiODhScjFvd0JmTVBaeVY5emp5?=
 =?utf-8?B?M3hlSkY3em5GdGFMOGQ0RHJ3RTlTNXRidStuLzV3UG5FYXl2Qm9HdW9OWG5F?=
 =?utf-8?B?L1Jmd3p4Z3hsNVkyNE5OTkRvOHlYSE82UjRVZGNSWjd5VGRrRzRWM3VSY1Zq?=
 =?utf-8?B?Vy9YMkFHdWltaEYvWmpaTW5aQkFVcVNFczNBUDVvVkdKUkNBSnJWWUFoMDhs?=
 =?utf-8?B?UWM5d2VLMUlFcHdHQktqNjYreks1MlplUUZ1TFpoNm5HZ3NXMm9LRUZKeW45?=
 =?utf-8?B?WXhGN0VSYjhjSncrYWN3aHFnaVcrbG5WR203OEIwbDhDbHpWc2pwSXBUY3RU?=
 =?utf-8?B?L0dpRXVMRlczelFMVkV5amlMazBXQlNvNWNYQk5jcHVjSGtHZmhaRnhXdml6?=
 =?utf-8?Q?gv8970R33bVfkHRBPvGRTzh2c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeb74a9-a335-41db-2f4f-08dbf6611e0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:41:58.0832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBRl3oKSFo2TdUxc6pmpv89zFTkcg4eO1pRitvAoxa4c9Qki34tInSeM9ffmJs4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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



On 12/6/23 14:28, Jagan Teki wrote:
> On Wed, Dec 6, 2023 at 6:11 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 12/6/23 13:24, Jagan Teki wrote:
>>> On Fri, Aug 18, 2023 at 9:51 AM Ashok Reddy Soma
>>> <ashok.reddy.soma@amd.com> wrote:
>>>>
>>>> This series adds support for Xilinx qspi parallel and stacked memeories.
>>>>
>>>> In parallel mode, the current implementation assumes that a maximum of
>>>> two flashes are connected. The QSPI controller splits the data evenly
>>>> between both the flashes so, both the flashes that are connected in
>>>> parallel mode should be identical.
>>>> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
>>>> nor->flags.
>>>>
>>>> In stacked mode the current implementation assumes that a maximum of two
>>>> flashes are connected and both the flashes are of same make but can
>>>> differ in sizes. So, except the sizes all other flash parameters of both
>>>> the flashes are identical
>>>>
>>>> Spi-nor will pass on the appropriate flash select flag to low level
>>>> driver, and it will select pass all the data to that particular flash.
>>>>
>>>> Write operation in parallel mode are performed in page size * 2 chunks as
>>>> each write operation results in writing both the flashes. For doubling
>>>> the address space each operation is performed at addr/2 flash offset,
>>>> where addr is the address specified by the user.
>>>>
>>>> Similarly for read and erase operations it will read from both flashes,
>>>> so size and offset are divided by 2 and send to flash.
>>>>
>>>>
>>>>
>>>> Ashok Reddy Soma (7):
>>>>     dm: core: support reading a single indexed u64 value
>>>>     mtd: spi-nor: Add parallel and stacked memories support
>>>>     mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>>>>     mtd: spi-nor: Add parallel and stacked memories support in read_bar
>>>>       and write_bar
>>>>     spi: spi-uclass: Read chipselect and restrict capabilities
>>>>     spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>>>>     spi: zynq_qspi: Add parallel memories support in QSPI driver
>>>
>>> This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
>>> and let Linux approve the parallel and stacked otherwise it is very
>>> difficult to maintain.
>>
>> Linux thread is here and it is pretty close to be merged.
>> https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra@amd.com/
>>
>> DT binding is already approved but have no clue how big effort is to synchronize
>> it. When was it synchronized last time?
> 
> It wasn't. U-Boot spinor has its own and makes changes accordingly. It
> would be better to sync the Linux. This is what I'm referring to here.

Wasn't this the style which barebox guys wanted to do long time ago in U-Boot 
and the reason why barebox was born?
I don't think that this can happen over night and also I don't think make sense 
to pretty much close spi framework for new changes till this happen.
Tom: What do you think?

Thanks,
Michal






