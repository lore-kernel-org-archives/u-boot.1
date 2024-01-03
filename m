Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC76C47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742CD80844;
	Wed,  3 Jan 2024 11:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SEfsqnkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A45A807E2; Wed,  3 Jan 2024 11:49:03 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB18280844
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQThFVRuxZAGZd9b3rGVVYU3laUEloK02d7JoLL8NTlUtHj383MZXrOjjxEJlHJYKy4L9hImb+1zXJDztq9NGQfKup0d/c6T/X3wkCXDahu0WrkQaWSP6jpFM6oi1E2wUSTnmpoiOes96TWe5iYMswuggxM511X5bfirrxrkwtSPXvzDkcUdJgTz/1rlcPKzI9XYJ1Tob9cvq7c95t3eylIz5uYa/tpEr9xaqSGtWWNjN/MFsNtwBTiODUFb+nvVo6h3jafXoiDG20NB04khn6OhyGRv7ORcw6M/zQvjuc0EoJDABgOd12G2LVMRxESQDy7Ttw+CwCpYXW475BcGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZXF8GS2FwKoM/ydtwr/9cVIYBB390yPXtRFEwWyHds=;
 b=VRK78HtK7PYh/KbuP7TiHXTPCGG5IlUk7bMS+MJ0TjrBzhOUjqPrbVKHHSa/MlT+tRWZA8qymvM4uhdnJ8qa2huLnOL7aLVBvtkNqjm2lgTyFzQn83I4McVtMUGyHStg+KEDI59ebjN1X4T8zlbKNufqgZKEZyJftROXv4SJrDd7hTu6Nji22QhUovO/sTFBiPDSLMUNoq5ayi3qkhIs9c//KMLbD44Eo5aEc5gntbnu2RovvHlUbYD9urrMt7fgvas8R2M+CFh5/c2cenujzxf/MzXFFOQuToJrsQMX5Mxj7nqhvQ8jyZO9DZqouIIS/jSrPnK3lkVCMkSGEbQrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZXF8GS2FwKoM/ydtwr/9cVIYBB390yPXtRFEwWyHds=;
 b=SEfsqnkAc8vCj5fLYyZRHDKbHet45od46dWFTpVCt1K5iOoJ7U4fVY031ZaaiICIQWUnX/DazcH0QPtB9AfMRFcH15CDvtNSDM5VEAAOOzK5iyJRE37UIIFDkcQS+HVeXwYM93RXiZaMSUYhnxdOPwfWej+7gbCnUE9BOZ1Th78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:48:58 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 10:48:58 +0000
Message-ID: <83e3de0b-b4e3-4dab-8ddb-2646e15c9cf9@amd.com>
Date: Wed, 3 Jan 2024 11:48:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] bloblist: Load the bloblist from the previous
 loader
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Baruch Siach <baruch@tkos.co.il>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-8-raymond.mao@linaro.org>
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
In-Reply-To: <20240102221237.1007090-8-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::21) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 563971f3-1d60-4ba9-810c-08dc0c49968c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6wAk1L0SBhD9wL3eW+C9Is5ccaFLpKpiYvRiS6DAhse2MYtcOtcsKDbUZ0BSAm5lw0KLeeJGFaZIEMhoBMO6dvC2e8ZpNSH6YUxH92EnRxez5anehWvoKylcbZev/42AXf9+rhLiMoO9QVNtW87w0sc8Cwu9gj999C5wEdWzL/ciQg2RDKujd+v3PeWjDWj7ScLP/3S3gKVVtgii1a0PuAMRTgScVC+r0ABu26qRLaRuF2a9Xg18dHNwWhEFLnTVTcUc5bDqS+E7zBgOy4WSGwDcmYDN0j77m1Gk7bFUvFqY5L7cPlSURQDtufH5zcUtw8AQxcY/HlDWtBDsCE6X/PahQ7V28AygjMwmAXPWhYLSzF+Uoeg0LO9JMZ1dOttXGOKauktaYuRKLWcTCF1/688Ck3bQPROJ2keG0bPleba8o6NoIfaa4uqMIcL1betqKN/2nDDtuvOf1KrRIuK56MrYhDpRj3e3pQTbUwhej/4KRZ6gh12JIt1b16CpCkeEbZAbtcMYCFroxd2rHkW8Rb2jAg8/0gF2LTDn6IHToI7NYnhVHubvL2swi/jN61whrkrQ9OEztq2Nrtf47BSqlAdx7MM6vP/7Y36JqKufbHdlJdMyJ6Zo2yDGJm/taYzG7hylQ3pkGMvYKfohBVtWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(36756003)(31686004)(31696002)(86362001)(2616005)(26005)(53546011)(6506007)(6666004)(6512007)(66946007)(6486002)(316002)(478600001)(54906003)(8936002)(8676002)(66556008)(66476007)(4326008)(83380400001)(5660300002)(41300700001)(44832011)(7416002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Z1a01Gd2V3T0dKdDN0M1d6VE5NSlN3Z3g3Nllxd2J5d25YUXhzeDBlRFlJ?=
 =?utf-8?B?di8xVkVBNnV1TG9ra0xYRXlyVHN1Z0NzYWtpTlBqL3ZkMml2Y0JYcGNseEZW?=
 =?utf-8?B?S2hzSXhWU2V6Umo4cWpmR1FqdGRLVHgyUmhOQVVyN2MzQzJtNTZ3QnkxajMr?=
 =?utf-8?B?eVdjc2Nab0xKWjJyVDd0T0o2aitpMW5jM0dobk5zczJHTnpXd0NoNHVFMUdQ?=
 =?utf-8?B?NzE0R2ZHL1ZXa2ZoV2QwVjl6Mmx3VGdLN1lxVUxwalh4bVhmQWdhOUFNZDQ4?=
 =?utf-8?B?NWZSYW5JOXdFRk1LR2drTEErLzVxY0hKcnRTQjRtcWtVZ1h6TlpSTW92SUtD?=
 =?utf-8?B?R0w3NVBoam13S3ZSL01RRU9JbXBkbkVGdTV0azhhdUF1ZVROSGczN2NmOXZa?=
 =?utf-8?B?SDJ0T2FqdkxzQUpyNWlDNTJ3MDBtUmE2NWNTTkgxR2NZMFE3bmgyS3hOZkIr?=
 =?utf-8?B?Vkx5TjRJMDBOSHJjWmNlRzdjRFpPeGdDZStWY3VhUkZmanl0VHpJWHFPcFNk?=
 =?utf-8?B?WUJpVlVralpTaW5XYytGdE43b0xSenp2OHF2aENFdVJuNEdOOUluSkRiazd5?=
 =?utf-8?B?YTMvY1U3aVVUZkxXRkhaanplc201S0E1Wm9zOGN5YVNJY1FJSlhCc0luRFNI?=
 =?utf-8?B?dXQ1cTAwNWxPQk5YRFNYRmF2UXVuWFljMjFIYVpCSlNOODlYdXc2MHpuanRu?=
 =?utf-8?B?RmhXK3NDM2NQekFYS3p1blp6bncvaC9ldWQ3c1dYK29KZ01YU0JxRXJSWkUv?=
 =?utf-8?B?ZXdJVHlJWE00ZFM2VTlQRGN3SzVBSS9LNGlmVkNiWkU0bkg4QjBYN3VrY21F?=
 =?utf-8?B?TFVOcTR4dVllUW13a1dCL2g3NTZ2UlFnVmpWakJGeVQyc0llV0RCMFlrNS9a?=
 =?utf-8?B?bGlvRTIrMzV0T1cwZFh1emxmWHdwa1MyRlN6UmNQMW1rYkRjbU1peDYveEtq?=
 =?utf-8?B?Z3M2NEVuakVvMkJjeWtMNys4STExejB3RlVyUE5odjcxWURHS2d1bTZMYStv?=
 =?utf-8?B?djg2RlRJbzFLUnZtZVpCNjUvRHE0REFBdHRrYngwOURlK01FMlBJYkdCV0FC?=
 =?utf-8?B?K05ET2FXVHhvR3lTVGlXMFI3dUxaZEluMkQ4VDVsNURXOW5zd0hObjlsWFdF?=
 =?utf-8?B?UmY0enRRYUswek1XMW1FbGw0a3VnUEtDYmF3Sk91T2YxdGw5bGZJNE56bm40?=
 =?utf-8?B?eGNMMmFsVytDYU4vdWN2L1BCbWRtSlM5SnZrRzVWak81VE9hUGR3WXhkQ0hE?=
 =?utf-8?B?a0Z0ZjJKbWMvS2xpQ2xJRFpNMFZVWEgwcXVqZGJ1c2FVR1ExUzNPNnJjVWpO?=
 =?utf-8?B?cExwa3dkVGl6eXVuSWV2ZnZnaEc0U2V2WjNSM0krTUc0Z0MvWjRvOWd1d0hm?=
 =?utf-8?B?dk5zNCt3Y3ZPVDhXL2JqbDY1cGxoYklyUXpWODVteCtqenBPUVdzVndoYlh6?=
 =?utf-8?B?SmdkUytwMVdsZER0K29neThSL3NjYVIwZjRvWDF3OGZZNjBYN0xFUi9DN05G?=
 =?utf-8?B?TThiWGhSeDV0aFBiZHQvbWEwRkNZbXhVUlRVbWM5dFJyRUFvejRyVUdqSUFr?=
 =?utf-8?B?ZGMwZjc4dHZJelRpU2Z1aFhCaG5VbnJ5ZEdFWGtqR3dlOUFzMjB4cW5NYnJL?=
 =?utf-8?B?Y2xIVmhjTFdSVHNFdVFHRHg2UUhMNmpmYkN3VllIODEvSE42RzV4UEtCODIz?=
 =?utf-8?B?OFZnY2lhK2hFWnRicXRUaGxHeFhKeit1blN1cDEwc00vbVozQUdDY0xiUFJx?=
 =?utf-8?B?ZGpaMFF0RVR5MldEQzNCa21SUGo1ZUlHelFKbU9sak41M0NwSkIwTWZMcnNG?=
 =?utf-8?B?bTJ3QmFMOWZjK1c3a3pTc3dBeXRtUEgrdEE1ZEdKbS9KYVh1akVOYU9Pek0y?=
 =?utf-8?B?ejNJWU5WSitYZE1ZVnMwZERsTzIvbUltWmU1QVVTV2FMQTRjNEJZOENsSWt4?=
 =?utf-8?B?eEE0TlpaTlQ1OTBqZzl0N3pkdEhvR0VnUmVjbEpsQ0lMWW50djJscCswSHRV?=
 =?utf-8?B?YTZIU0N6bmpSeWFSOGV3QVppV2hJWlc3M1AyRWliK09xb213SjZPUjJncVhI?=
 =?utf-8?B?NXdtK1NNa0U0TDlaUlR5WC92Nmh6MzdGcFFQc1QwMCtkNnVyTzdBeUdScktK?=
 =?utf-8?Q?J5iauKx7tvV8IRvRmnmctm7OE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563971f3-1d60-4ba9-810c-08dc0c49968c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:48:57.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Qim8f4LQArQRRsFhL6h9DVomu0qSSe8V52SBnj3ZwvYHaxW3KLQW0zajcfmaeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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



On 1/2/24 23:12, Raymond Mao wrote:
> During bloblist initialization, when OF_BOARD is defined, load the
> bloblist via boot arguments from the previous loader.
> If a valid bloblist exists in boot arguments, relocate it into the
> fixed bloblist memory region.
> If not, fallback to support BLOBLIST_ADDR or BLOBLIST_ALLOC.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Add weak default function.
> - Add comments for BLOBLIST_ALLOC.
> - Add local debug macro.
> - Refine the commit message.
> 
>   common/bloblist.c  | 66 +++++++++++++++++++++++++++++++++-------------
>   include/bloblist.h | 10 +++++++
>   2 files changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 4e76975627..65c3c031d0 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -17,6 +17,9 @@
>   #include <asm/global_data.h>
>   #include <u-boot/crc.h>
>   
> +/* local debug macro */
> +#undef BLOBLIST_DEBUG

What's wrong with standard DEBUG macro that you need to introduce another one?


M
