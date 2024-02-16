Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8885C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 15:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DAA87E4D;
	Fri, 16 Feb 2024 16:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcIzrgTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021A987E4F; Fri, 16 Feb 2024 16:07:09 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE03C87E46
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 16:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SecgfCGT8ZZoRfTsbPNEt2sSZRcwV6VGrk/ZuLEa555z8HxdY35zV47bHVOOzZQISaDVuDsDI9gxQZepdz1F6/CE5QBBzSmnX5oUc9Yl0A/iGBjYRCU6S1FWhJ8eft2PcDqKPtyn5QZacrcRDCDI66UuK3sK4mQ+qepX5l/pdX5RVpQOC0wpL17Afs/yDgWdzQ8iRm40DFU6PDyP4zemcKrVzTWgNKcwVRmb9DCOtZZbDGG3firGzyf+9PDX5YWQBQ7fd/h+iKVMuRVae09n6x/SkBjjXJjYnNKRWVhxiVcquSUeCvy238SYAYmfOq6SjFT0NHhQiiiFryBE8Hgn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcWKsWrpUS6tQZtdI3IptpJ7LSlJjs3bfNj/rofvxOM=;
 b=mlPTbAKbLw1+fMw1fiVsdcHayQWCgMoS1A2JgRhIU6jZtcgK1hx2Kc7aSpVQV3lyhbjY623+duPdc/h6GKp4V2YzvLUpvtPHZXsywu7yxtJOCnij3Wqh/gnA7y0NaZzccVALfGf6dFOlQFUQmrjPy54B8QqaQSX7TwLsSto4ODRAn6sLC7d3FVndZp0LmHXqZnjBNM0w53FuxM6q2110QkMXjJJbD8MLypOpcnPU1O13bQDsFcEz9Y578REwkehfxibxRENGziMjJJqWoay/ads5bgju1N7g9KdyPcpQ7sQkoRzb+jXTvRneEAl+agm7Wbh6mOit2dmi1Edv8ZeqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcWKsWrpUS6tQZtdI3IptpJ7LSlJjs3bfNj/rofvxOM=;
 b=vcIzrgTbRwnJBFn67SG6TRPdG0ssWnoqCdv2bymYIW2UXCKrjTBzembew/5J+5J7G7twNWemuzySww2ZzSRBjqONQsQ10bE2vh/8PXUnATJ1JeTfsxAIkhxjMnlH7o9oZzf0n8KbB7XyqNPnvBPK47QZ3A1HnBkxGDdAUrRSNjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 15:06:58 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 15:06:58 +0000
Message-ID: <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
Date: Fri, 16 Feb 2024 16:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
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
In-Reply-To: <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 734b7b91-6610-41b8-af35-08dc2f00ec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52LdL3rd0OCNyf0z2p9Etar/W5sKbFk8LFhu7E8D/ip2e+Ei8OH3dtZA5mKQvATFIHwgCthh/k02DE4rdqXRlfb0WyntR8TxN9EtrY6I62YVZ7gwCQtosL30io4hkvT07aBSfXwRvQMWzHMw1V3hH6dS+6dY5bHHzisv4R+vdBLT+P5EQ4HjUri1a1FfAqrwJO2ufr+KvK4iITM3T7+EeYQssay77IGnDaWeBCkqi48yHw7hA/JsAMD/3/T+N39qZ5Z/0eRiggg7x/RxhSo+LsR2GWkh2QOvBPZTJvRIASDJpVrcBChUrCiHvSFlKW72OsnwclH1L3XU0q1NdzYSBqh2K+v6TsmDtg7vPv8LMF3fs45pY8xtZRBcyAfQFMnf/4m0vfb3EeROGBZgpNYZ/uBDcRfTxO/8pKt2nR0dQYf/gvlhBFyKEtyGaHkemzuphYnXqG4sfNTNAlQNU7NOLgWT0ZNr6bWcKuMQDmgh1N2a6Us7c/KNEsbtmWC+1GH/v6qoMoIBBY9gb+tZ7swlhynElB3H2RZ5oteAMDriRkmIVDR2WktLL6XI7nuXXnrK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(86362001)(31696002)(19273905006)(38100700002)(316002)(6486002)(478600001)(6506007)(6666004)(966005)(6512007)(53546011)(2616005)(26005)(36756003)(41300700001)(2906002)(66946007)(31686004)(5660300002)(66476007)(44832011)(8936002)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHcvYlBVSFlXSnVuVjRIYUxWV3dtTVNUNE5Gb2RkdWxJckxtZ2JWalB0WVlx?=
 =?utf-8?B?OHZjcUU3azFhUWY4RWk5cFZaZ0oyK2ZoUHdlNWxORXplVXVUYy9vald3MmRD?=
 =?utf-8?B?T1BOQS9JcFZQdzl4T3ZYVmdZcWpvbk9rVkJsdlhUakFPTFhEUitpZzBWQkJn?=
 =?utf-8?B?VlNVdUdhRE0rVE9LU0xkbTcrMTVnMGxzNHp2TktKc2RrZVJNSGxpOVVWWW1h?=
 =?utf-8?B?T3VUeTExWXZjdXRBbmxxYjYycFVBSlcxMTRXUDlTa2w1MmVVMm5IdHhSU0h6?=
 =?utf-8?B?UStIVVRMbGNLWHBWS2tmODRpR2h6NmFodlFjZEFLa0xhUldNSStZM1VIWXl2?=
 =?utf-8?B?Z090UlBVTnNpU0NUcjQ2YWtMY1FiNXdPTzVGK3UzNytYL1pLRFk0ZS8vYUt3?=
 =?utf-8?B?eUlyeWY5bmZ2N2xRVmlkakxrS2pLeEZtYlYxczNqcVdJMnUwcDRvQjBFNzlz?=
 =?utf-8?B?MDF4WUFhNFVEa1VxNUtDSjJzdkVsaHpPSEp4OWpLZFpRKzlPQ1BzWFQzbE9v?=
 =?utf-8?B?Nko1R0RrSktUMjZaZlJ3WC9rZ1g3NHkwaU1rZUkyWWZIVkI0WW50bTZjQkFR?=
 =?utf-8?B?M3BicVBYeTdISENrY2tnL0JqUVUvdlpITzZPRGZjRkZMbkluQnlPV2lIU254?=
 =?utf-8?B?cnBjM0thTk0rNkJUeFRtZUJyMkN1dHp1M1RMUHlVYjBqQzVCSFlYRTByZDhw?=
 =?utf-8?B?TTJFZXh3dW9IVDZtaXZtU1lxM2pTVHpyVWgyU29OVUpTZ2c5K3dvSnVEMmN5?=
 =?utf-8?B?aENBL2NHKzQ0YmtJRFZWaUd2Sm9RTmtKL3lVUmhvKytKY2p6MTVhenRjWGFD?=
 =?utf-8?B?czdTVkJkS3FCdnJaT21VSndISkhQREQzNnU0YnhIUU5jN0VkQjRKVkdtNFRZ?=
 =?utf-8?B?Yk9ka0ErZ0ZLem5UMXI3emwxSEdnZkxXU3ViU2F6UjNFMGo4ZjExUlVuWnhH?=
 =?utf-8?B?NnA4N1pHTlpwOFY0UmZFY3ZUcjZFVXJtNG1pS3dKRjNJbUlJZFBXZGNQL1BO?=
 =?utf-8?B?dFQwaWh2b2w1cWp6bGFQT216T3pCQ0RXWjRRUGVGbldLSU1EOUxxN1JSK3d4?=
 =?utf-8?B?U3V6Mk5NOUpaM20xVmJlODcrbllNZTNseXBMclgxMDBWQXhwcnkyRitQTTBa?=
 =?utf-8?B?VlBQdnRNT2pPR01Xc29JRFdqNk1YZStIWGVqMzRvL2VZV1RPdHJBWHhKbklz?=
 =?utf-8?B?cHZoUGRxWG9CRVpmSHEzTEJFNmtvQko2MGZlN0pHNWNNeHdTcWI2NHlWNWt5?=
 =?utf-8?B?d1FvVno1aEZBRUR6V01MRDNvSG5OMWxleU04NzlRVDJwcFZFdExXbmFUbEly?=
 =?utf-8?B?REtBRHJQUkpFMCszcy9zcUtLVld3NlRxc2ZFczNnM1BrQjFoWnBmUVRwd1ZE?=
 =?utf-8?B?N1lzQ0hCeWgxTFJINHArN2NPT2V5UkIvQTVHOWo5dnJIVU1tT3FCMmJYdnhy?=
 =?utf-8?B?eWN0MWJBQlc1YjlPTWVzWWh4Ti9MUlJtQ1haUXZCUmsrSUpuWWpIL1cwN041?=
 =?utf-8?B?RlRYVnpPZHBQOXUxM0RsUFJIcHNraW9aUzlyd3FVUEl4K0ZJM2s4Unh0cXVW?=
 =?utf-8?B?RlJ2RW9oZ1pTdnRtdWJkRXVXb0pLbUlvOVVlYm02SmsvOVU2WVBqUE9SVXB6?=
 =?utf-8?B?M2x6UURFZTZKeG5ZMUY3MGs4bXlEQWhuems5UWJZV1FSb1BiTHlBeGpUVUJ4?=
 =?utf-8?B?eWVERlluUDNTOThJQWRrWEw3Rm1wZVVYUW43SVFGc1pLaElmcEpBUUUvQW95?=
 =?utf-8?B?QTc0SW9hcXFiRzBTOW1PazlVekJiWjdDa0V4WW5DNWtQUlE2TEJ1bDdzUTZB?=
 =?utf-8?B?T3pFdXFnbkpjMkRDUTVOYjJjdGxScXYxTUVBWW53VUVSbzRaV2VsSmVMU0Vk?=
 =?utf-8?B?dTNJb3JIL2VMeVdyZGp5U2dYMEtoS2xiT2RyaXdhbDhubjFHdGpHMjEvVHBv?=
 =?utf-8?B?N2cvelVsdTlZcytRQlUvOXVOSTJFS3hrcE5YSmZQeGV4Z0JuTytPa3JwVDFL?=
 =?utf-8?B?MXF4cDFFUkdrQlRHa1dWWWR5dmZXWnl2MG1DeVJCWlIxOEwySFhRMExDMHU2?=
 =?utf-8?B?TTY0V044T1ZPMlA5RWhIUVBOVnRPbVR0TkZCVDcwSnZkVitSRDNDSmJWK00x?=
 =?utf-8?Q?j6wKfjgSz56Stt++hR+HyWyQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734b7b91-6610-41b8-af35-08dc2f00ec10
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:06:58.8109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3Q9O+auNdVGzEDuiS9DjHyRNkW/89rPmG8bBt0ftbYMp1MJc6j4lMcAXe7nHKhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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



On 2/16/24 14:48, Michal Simek wrote:
> 
> 
> On 2/15/24 20:31, Sean Anderson wrote:
>> On 2/15/24 14:08, Michal Simek wrote:
>>>
>>>
>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>> However, this is a bit tricky to time, since the debugger has to wait
>>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>>> long waits, since occasionally initializing RAM (and other things in
>>>> psu_init) takes a long time to complete and the debugger must wait for
>>>> this worst case.
>>>>
>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>> debugger when we are ready for the image. This means we don't have to
>>>> wait any more than necessary. We don't change the default config to
>>>> ensure we don't break compatibility with existing debuggers that don't
>>>> expect us to hit semihosting breakpoints.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>> ---
>>>>
>>>>    arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>> index a0f35f36faa..5af735aa5ce 100644
>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include <image.h>
>>>>    #include <init.h>
>>>>    #include <log.h>
>>>> +#include <semihosting.h>
>>>>    #include <spl.h>
>>>>    #include <linux/delay.h>
>>>>
>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>    }
>>>>    #endif
>>>>
>>>> +static u32 jtag_boot_device(void)
>>>> +{
>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>>> +}
>>>> +
>>>>    void board_boot_order(u32 *spl_boot_list)
>>>>    {
>>>>           spl_boot_list[0] = spl_boot_device();
>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>           if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>>                   spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>>
>>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>>> +       spl_boot_list[2] = jtag_boot_device();
>>>>    }
>>>>
>>>>    u32 spl_boot_device(void)
>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>
>>>>           switch (bootmode) {
>>>>           case JTAG_MODE:
>>>> -               return BOOT_DEVICE_RAM;
>>>> +               return jtag_boot_device();
>>>>    #ifdef CONFIG_SPL_MMC
>>>>           case SD_MODE1:
>>>>           case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>
>>> Good timing. Can you please tell me how to test this? What's the setup?
>>> Which debugger are you using?
>>
>> I am using OpenOCD with the patches at 
>> https://review.openocd.org/c/openocd/+/8133
>>
> 
> I am trying it on the top of the latest git but getting issue with event block 
> and no idea how to fix it.
> 
> # sudo openocd -f 
> /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_hs3.cfg -f 
> /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
> Licensed under GNU GPL v2
> For bug reports, read
>      http://openocd.org/doc/doxygen/bugs.html
> Info : auto-selecting first available session transport "jtag". To override use 
> 'transport select <transport>'.
> wrong # args: should be "-event <event-name> <event-body>"
> 
> 
> Do you know how to fix it?


I actually bisect it and found that it is caused by
jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
ea2e26f7d521f5755b4bfda7bf12d99650277421

# sudo openocd -f 
/usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_smt2_nc.cfg -f 
/usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
none separate
Info : auto-selecting first available session transport "jtag". To override use 
'transport select <transport>'.
Info : Hardware thread awareness created
boot_apu
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Warn : An adapter speed is not selected in the init scripts. OpenOCD will try to 
run the adapter at very low speed (100 kHz).
Warn : To remove this warnings and achieve reasonable communication speed with 
the target, set "adapter speed" or "jtag_rclk" in the init scripts.
Info : clock speed 100 kHz
Info : TAP uscale.tap does not have valid IDCODE (idcode=0x48e70126)
Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), 
part: 0x4738, ver: 0x2)
Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM Ltd), 
part: 0xba00, ver: 0x5)
Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), 
part: 0x4738, ver: 0x2)
Error: JTAG-DP STICKY ERROR
Error: [uscale.a53.0] Examination failed
Warn : target uscale.a53.0 examination failed
Info : [uscale.axi] Examination succeed
Info : starting gdb server for uscale.a53.0 on 3333
Info : Listening on port 3333 for gdb connections
Info : gdb port disabled


but with zcu102 I am still not able to connect because error above.
The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
It looks like that not everything is working for zynqmp.

And no issue with xsdb.

Thanks,
Michal
