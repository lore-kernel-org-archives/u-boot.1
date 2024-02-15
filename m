Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00331C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 19:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DB887D80;
	Thu, 15 Feb 2024 20:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zvLW8SGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6AC800A5; Thu, 15 Feb 2024 20:08:26 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECA4800A5
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 20:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg+jZK9Es6Iq/AxP5NWi6wRt3ZPuj7Rxvnn8jsSQ7C/sZNTjrC+wjPUoAkv9rN0bJfEI+KJ5x9xFmK4cwo9AOLWJACD0/tA2MBA/aF1VVcXJVwi+i/QNjLK4IcOYFt2hAK6rO5oqAgttoXhXRc7iPzzxTzt7ku2FW3S2R6YdliPF/z2Idxb+ykriQWIZRy88zeFVDhoxXDipY9D3jTke1tEW2SHSPt629zo/DMTcs6qRN25uPtOMXaDXYI/ssooTLCjdrdguhyJoFZ1UOJkI5aH10y3ax3mCtdyWacYGaIOW0UeB8cewRbePqokWHqNY7iYXcKu+DpD9OgQ+LLpk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxmMYlw6Wf470EH4FG5ITlBcxhN/2t0bb3Ej56jtvFQ=;
 b=fko0lD+oP2/cFUUjQ+/paGm3oQ+nd3lmDcDvVTwT2vBjI2fBE94VEj2TWStYJ+9XOlM8p43LFBIQ909wn2z2Z2WPakmgyedcciAK31aLq1SMAe7Tw8D78WVtA/riHGw+++38+cI9NRLQunJrLmqv5r3HgrtS0Z8BIh+HhLvEEqjHdPzoNl2OxnIGRczRMNvcWfdfyLFLQS6HLNaYEWUSMouMCL8KV+XY0lYDx/kFSVbDTTxQHkupqcQJgRRiWFl8jwvTbzUp7PGpQTEXk9Sduoh8ObxvY1VZhrf7JXEhtDsVW+ahgJ2QaOT/f67QIBRqfqMB0Xv8jek+8OEHsNXPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxmMYlw6Wf470EH4FG5ITlBcxhN/2t0bb3Ej56jtvFQ=;
 b=zvLW8SGHflh4gi1Rf/MY7zahLT6Z1YNOjUVly0vjzQZwv/wllnWZawB+ug3OuxCDTbILig7eptMgDw7XtiJjH+CgOBrYwrBC84do6l3gqQcEAFAEkson+bBEBs+wMVoOuufhCIPZCj434oC9zFoDXKtuIPbs8+ROYT+x24FFMvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 19:08:14 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 19:08:14 +0000
Message-ID: <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
Date: Thu, 15 Feb 2024 20:08:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
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
In-Reply-To: <20240215171918.3729508-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0871b2-2e76-421b-a5d9-08dc2e59757a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5ySMJmlqa+alJ2+2baP+LwWZQRlfOOGWsgm1RfMZUIdryD1/4gaiLjowaGMKeJx5ty4IfXom/uhO/byRwouH1Eebm5gMu5bnauAzfdCaFBrptJUSy96z/4JN060jqGjrkSZ81I8HvvIgwOnL3lifZQt2Pb1abRRShR5QJwvdk6SQB7mWtYUSRfjiF8qIcMV0swR254aTPcwWRb+DC2sXF9/Gd87c2XAQhSClhsR24wyUYqS8o5dO/k5x9spIu5U7lGFApg3JJjO1OCabZ0sIHmWDmjotSmG7jitkiAoQRRTFWfH9KtyWj3GHsYXgbHH81eWN0E92KsMYLlDbozgsbDJE8yilaDzSJu4OxSOXm8N7+YnJYDIrBeL9NQ/EpH9qXnc9kDskeP/4N9MYMhwj2tzMS33a/LWZYYafawkFNv4OZ/bIT3lY2pph1NwvqWYO2lTZ2mNgIKOjq/gV5FbDhpr1kuMhIz4fB6o/uJ7TXRfEzQsQVRAYasOx5d7Spxkh9Dvl/m+pn8kgnaSll54GtQgeGt3Ai65SCCwY0rIKNOZsvVt4GC+L64tEnKaWcPL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36756003)(31686004)(2906002)(44832011)(2616005)(478600001)(8936002)(53546011)(26005)(66556008)(83380400001)(66946007)(6512007)(66476007)(5660300002)(6486002)(8676002)(6506007)(86362001)(41300700001)(31696002)(316002)(6666004)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVPaEd1NU5lZEQ3RmJwZ1I4YVQwUlVLV2wxZEtVZWdROEUzTDJCTmtpVExM?=
 =?utf-8?B?cXpzckpwdFVidXN1MG95c2VoT2lLYlJKNUFYaTBNdW9uRi9SVUlOaVpDOVo3?=
 =?utf-8?B?RnJrVGo3WWFDOEtvaEgzeWxjbmxWUjlhWGhUV0RvWXZhUGg2d29YOEN6QjNJ?=
 =?utf-8?B?WmpESWNmY0tobWdUUU1yQjFGRVluUFA2WHF0alVzOEtXL2k0OC9SNC9ENFVP?=
 =?utf-8?B?b0tXWEdySERGdDN2MnpOektNcEdHZ0pTN2I0R2tSbXlISldwUjFBQ2VWMnI4?=
 =?utf-8?B?bEpKSzNWbGNpQStvWGVBVHl0T0RSVVdPWFpOeXk4aWpYay9EWkIzYUJ0dlBY?=
 =?utf-8?B?S3I0d2F0S1ZvWlpsaDg2ZmM2L2RxblplYWlmYmYwcmNValZWVWxqcmJNUDZJ?=
 =?utf-8?B?Mnlja2pvaW4xT1Z1RE9wL1AxeHdPSE8zNm03c0lhN25SVHdISSt6dTUzTWZS?=
 =?utf-8?B?MnMxM1pscCsxbEc3bFdrZk5MSmNOek81TmhSQUhQWm8vVDAyZ3dscGZ1aWR6?=
 =?utf-8?B?T3dVeWhZRE1jVmtpV0NlUE1JQXpTRFpCVHR2VEMvSU5TQ0hMR1VTUVlpemRu?=
 =?utf-8?B?aGpyQ1RuWW5jRklXT2htNjh3SnBhMlhDT2o5b1pDRTFYM09VN1c0Qkl0MVlW?=
 =?utf-8?B?aWVMU3had0V4S0YzZkRkWHBTQVdZZlRTaCtRSGhjaHFPNjd2SlBhdGxEb2xi?=
 =?utf-8?B?N2Q2ZnUvOStBMk5LMHpuUnFiQXA2K2E4eGZrcWFpNGtib3ZhbmVtQndScWRw?=
 =?utf-8?B?MGlJV3hLRTg0anJydW1BMDF2c2hCdDhld2JwVUVlWEtONEpaQUh5Q0kwVzc0?=
 =?utf-8?B?V1J0SHJQVVFlTEthN1pvSVVsWVBjNmNnQ0ZvUlZ5c3h0dzlpRjRHNDFRc0tz?=
 =?utf-8?B?WmlUakZrL0lSN1RCVGRmUjE1aTJFby9wcUYvOVhQNmd2a1MxVFlyZDZvUnhS?=
 =?utf-8?B?NUoyNXFoU2tlRjQ0RVJZbFRhMmlIekFtQzVsaGhGQWxtQTFqYytVN3Q1N3By?=
 =?utf-8?B?WW1kS1NrRDUwaWZMNFBhUkcwQ09Rc0tYcTBnMVNoQnNlY05ycVJmWW1kejZX?=
 =?utf-8?B?VVMwUEErZXYzSEZVOE51bCtBQWdMY1BHK2I3NGN3WVBneTZSN0gycm42Q3JE?=
 =?utf-8?B?Zk43dUMyTHp4clJabndKYjVlc1RpMGVpV25Jc1IrM3hMTk9OWmpMMFdsVExa?=
 =?utf-8?B?RGhHSWRBL3NhU20wQW41NkZRaXhLOXl3SDQ3KzVrZHVpUjVKR29Dckt4VW16?=
 =?utf-8?B?ZHd3Z0dGSEVUZC9Qa3hqSTMxNmY3b1BLbm9ERllzK1JhQlROcWppNVRnSW9V?=
 =?utf-8?B?bDZwaHFveG95Mmx4R2c3OUJmNjdNMEhTc2hDOW10eU5IUDNzK1pVRmlxUmlI?=
 =?utf-8?B?OGkveDVWTWNOTFpaQklOOHh1Ymd5Tk5pWU05ek12dHQvUWlXTzRFeEtONzkz?=
 =?utf-8?B?dFlhV1J3WGtRL1lmWE5lSUoyRmlJSjNBblNTL1FPYjUyQmhMSGxHekJWU0hp?=
 =?utf-8?B?WTEycW4wQWNsdTdENmFpbjV1MkxwRTVXV0dxcVR2cTNLcU9JMnVKV05wc1NU?=
 =?utf-8?B?U041VHBFSUJ6U0RQbWdKOTJmb2swVnZSZFRrVFgyeXBvTE1wYnVKVDFVMHVl?=
 =?utf-8?B?Y0FZNDIzQ2lnS3V3elNHclMrV3hoM280RCszV0Z3cHZ6RFVtTDVtNCtHOExY?=
 =?utf-8?B?U0JVeS9taDRNVVEvZUYvcC9mNjQ5Z24veXJNYkxSelRycHgwOXZvRGZtYzZP?=
 =?utf-8?B?OEhTcHdzRFdPZ3NrWjh3S0F0d1dIYU5aSDl6bEVoa3RMdVVqRTI4U0RYMG5H?=
 =?utf-8?B?RTh3RXkrYUxkTjlxZ0ZlUzJJeXk3enZmdFphYXBHd3lTQWw5QXQwc1NJcDFP?=
 =?utf-8?B?Yjk2dzRkWGFTNURIZWxvMmIvbUxnQlBnMGlMYzhnTHRWTm4xN3ZIREFVa2lp?=
 =?utf-8?B?TVdRdVpZc2FhbmJ1UmpHQmpNczgzNit1S0grbGREQUg3dkE2RVJTYXErcWhC?=
 =?utf-8?B?UlczZitxZVkxT3dXOTJYbHBZYjdFWnRKT0xpNVNPbmhVMnNNT3NqRWRsUHM4?=
 =?utf-8?B?eE9MZDUvaEVrQXN5Q2tZcjY0cFQzcjROKzUvVW9MZWM1UnRMSW8yOGZuOEs3?=
 =?utf-8?Q?kyWUqeZy8mG+F7s51CfXKJZTZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0871b2-2e76-421b-a5d9-08dc2e59757a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:08:14.0677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAL83BKEIQhhLWU4oggvkRCQnjbDVXsOyXzkUF9pBUO+sdhDdw/2o0lExUachKUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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



On 2/15/24 18:19, Sean Anderson wrote:
> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
> However, this is a bit tricky to time, since the debugger has to wait
> for SPL to initialize RAM before it can load U-Boot. This can result in
> long waits, since occasionally initializing RAM (and other things in
> psu_init) takes a long time to complete and the debugger must wait for
> this worst case.
> 
> Support semihosting if it is enabled, as it lets U-Boot tell the
> debugger when we are ready for the image. This means we don't have to
> wait any more than necessary. We don't change the default config to
> ensure we don't break compatibility with existing debuggers that don't
> expect us to hit semihosting breakpoints.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>   arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index a0f35f36faa..5af735aa5ce 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -9,6 +9,7 @@
>   #include <image.h>
>   #include <init.h>
>   #include <log.h>
> +#include <semihosting.h>
>   #include <spl.h>
>   #include <linux/delay.h>
> 
> @@ -66,6 +67,11 @@ void spl_board_init(void)
>   }
>   #endif
> 
> +static u32 jtag_boot_device(void)
> +{
> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
> +}
> +
>   void board_boot_order(u32 *spl_boot_list)
>   {
>          spl_boot_list[0] = spl_boot_device();
> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>          if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>                  spl_boot_list[1] = BOOT_DEVICE_MMC1;
> 
> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
> +       spl_boot_list[2] = jtag_boot_device();
>   }
> 
>   u32 spl_boot_device(void)
> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
> 
>          switch (bootmode) {
>          case JTAG_MODE:
> -               return BOOT_DEVICE_RAM;
> +               return jtag_boot_device();
>   #ifdef CONFIG_SPL_MMC
>          case SD_MODE1:
>          case SD1_LSHFT_MODE: /* not working on silicon v1 */

Good timing. Can you please tell me how to test this? What's the setup?
Which debugger are you using?

Also curious if semihosting serial can be used in your setup.

Thanks,
Michal

