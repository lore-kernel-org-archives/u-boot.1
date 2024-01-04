Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F098C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A3C87968;
	Thu,  4 Jan 2024 13:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgvxEDb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1818C87968; Thu,  4 Jan 2024 13:48:17 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEE587756
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTwu2gZCrAX1Gz38pkYXqoEH2qJltF1WS1VfwqIYD35OMdGV5AaHy68XIxIAaoTwZN7gF5XNDMgGHWPV5HOokGiZH4dXKDARC7LHkoSJACnXiYYvEdyVF+Nn5pkXGZPc43+ZiYZWuQW073jcpieznk5gOwtPxI+QmRDBSk0kr1m8ES0MDEaMdIg2+26OaY7bXopHUf+zNLPmV0qC94JEni2RgNoxZYH6PZpDy/YGtjslvErEB1+IQS5vEPalLitXCGO7uYtySAdMvMUq9IWPsOs24M+YcpB/wc/7rfgUTSolb8Kzftuc08cudO7OqqsQsSNO3ohuf2jAhhGWPi+I+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk3SN7u2oN//+3ekKLbK+yFKfPyxtv8y1yDq1pLQOAc=;
 b=nKLHOZuFmnMxcKIN23K5goVmXl1rXUJm5amVGRy8skWdRgXHdRHyuqjjdma0jBnHVTa1XwH+1G4d6WKZfxhm31ElvP76KY6mp3NRY+znJN/oAIe0mfQ7Vabx48GRozXGP/RfiNy9n3I0syndvNuo0Vqdl6EHuo6W5Za3YGJGsfBfw7hjqXwSjTzzQ7RYDkvUypN/Pgesl3B7Zy3+GW5qlNr/rcdXyKcux1ONnQIY2TlZGivLBV2iszrbghpcl+sa3YSU7Ut4w9Z5nhFSN7pX069ROoilcimWgqi0QFzArfwNlxrpePkGRYD0aoWGDpBYEpevElklTvhuzvMTKR34Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3SN7u2oN//+3ekKLbK+yFKfPyxtv8y1yDq1pLQOAc=;
 b=WgvxEDb2f+wN0RrSDHlOBMcX3/jiMcpecFcGy5+LABFAMdiifXYWKzi6Je590uRlgyLocqH81Nnm7u0KSAiPFFIadw93/coPr8i0C+xDu68/t4yh2FVVVBY21Dkdd3ptV7oeL65UUHPcfvwpyQ528QPK5MTM64g3yV5bZ4qfTU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 12:48:10 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:48:10 +0000
Message-ID: <acddf62e-384c-4fee-8926-c6aa759a7dec@amd.com>
Date: Thu, 4 Jan 2024 13:48:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
 <7bb9480d-ccd1-4717-8083-b007efd7567e@amd.com>
 <CAHk0HovT5XbejLHaTdpOTkR=dXhK=Q-GAO+=sXgdvfE4fyTuag@mail.gmail.com>
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
In-Reply-To: <CAHk0HovT5XbejLHaTdpOTkR=dXhK=Q-GAO+=sXgdvfE4fyTuag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 80de261e-fd9b-4f4a-f772-08dc0d23683a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP3vQpW/932mTufkyASjKJ1I725m8QuRIZFMRB6q2EMNoHwPEms7IhpXRx1DdzRMdXWHbiK7qrZvfL8FB61Q16x2dTtPMtpS/UklqLbR6cO5/ANAiwwNYDSoOBJwY6aY9ELe2nHwRNt6xvmu7Lfdd+XGXJo8s9P/KJRQh2yH2b3LAg3SQpsb/zswEA3LL5Suq7li0L7HvqrMt9TUFc+paZnDMVghuB2BlXdrmkbVBf0Uq9eLbTZhyGa7xO5jsUVRZ1IJfX67DjOuUL+t6f4Wd81+f7TTg7jgh4xTWWwV+GLUTQwqsrmlWd0t7cInPAXKpRabdKNNc61incMqMSkZ4qXu4TOvtGRJg/ZS5wieoEnIeH7p98CZQskvWN8nE8/t0YfL/NKTRvo/XbQiIbCbc3Ephkb2y9yCuTQqpfdNro8ZR6ie3tDjsU0wFd+WsPlKYJ5d5l5tDbjoR/UiHYSgaUmTwfKITOA1SGiFClWA/mk4SLvS6NsIPW4maV6Qn3IONo8SZGFgWtYrj3uw+j/g/NF3V64InxbZZbV0nusnGp9ScyikAEDfmxtc0ClAktgE5CYtThv7FPLI49v2dtNlp01IUT3TyhSodWLPNDCCMBswIgo6EIeIOye4JXOLB+ozvIre8nmVPH1LMTyh1EmykA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(6486002)(8676002)(54906003)(316002)(4326008)(83380400001)(66556008)(6916009)(478600001)(66476007)(66946007)(44832011)(6506007)(53546011)(6666004)(6512007)(2616005)(26005)(41300700001)(2906002)(5660300002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5tRFhOL0lvcm5aSTZjeUtKMkcvVUVRQmFOVUZPUWlhbE1PWFpiamhUSVUr?=
 =?utf-8?B?dGJlWkM5NGFBVnVIUVhGRkhYMWJZL2ZqRTRiZVJPQVN1VnJIVDFhYVpSZlNn?=
 =?utf-8?B?UkxiZ1VPSGN5ajFqMURHQkZCVld3OWowY1VBWmtOVWNGN3MrWVgyelp6VHk4?=
 =?utf-8?B?QUNzUWFiZ0x5Y3dxaUl2eEtuV1lMT2FRRGM4Q251Q0RWeUpuTmhiQW1pU0tI?=
 =?utf-8?B?SmIwc3dMZkJRemt3cnpsYVZuOGkxZWdxZWhSeXg0NEQ2T3VvUzh6Z3RheU1q?=
 =?utf-8?B?cmJuSE9GSGpaRHk5SzNEWVBXVDJLMUw2TVlxK1ROZzlxTXlzVW9wamtuTXBt?=
 =?utf-8?B?U2N6TVRmdi8wNTE4NThhdUJLUHBqOXFNaC9zM3UwUGZDL1FiUXpGMDZieUQw?=
 =?utf-8?B?NElyS3RWcjI5ZkMvVXB1TXBmTFNLeWVwUXJpbjVpTXZlWGZqMkM2VGh2VzZU?=
 =?utf-8?B?RmphWm5GSFpjdVJuSnpXOWZlblZBcHJyUHBwL2lIMFY1b1BDeDVrbXdOamY4?=
 =?utf-8?B?eU9sTHlzWi9mY2NNZHZKcHZaSUJrQ2hlQS9ubnpObEhVQmpHd1VhNzJDYS9D?=
 =?utf-8?B?U3hBdGd4RlFYSjN4NUtxRnRoTS9KOTFUNnp2TThwTTVlM2lsbitCS1BGVWFM?=
 =?utf-8?B?Y3BvcmlVMXc0ZTEwd3NlcENHOW9ObzJuT0lTYi9zdzZqZmMzM0swRzBZeXVS?=
 =?utf-8?B?c0R3VmZOeWV1U3lGR0g2WDNvZUdNbEJEbnB1U0k2d2pibUFXZ092Wko5aHZV?=
 =?utf-8?B?cWF4ZlJIMGhYOGlMK1o5a05tSEdKaDdPMzNHUStIT0NOR2tIeTdETHZuSVk4?=
 =?utf-8?B?N2pJZ0VJSEFvN1ZvT3czV3l6dFZUTHJ5UWxlQVl5VmNqemt3djR0RCtaR0pC?=
 =?utf-8?B?MzRhUUlVT2VBcDdEVytmYU4rcHdTRVRSR3RxaEZIWFZsNXFhejdLSVN6QkUx?=
 =?utf-8?B?UVJ6TWNTSWR4MjhhbFN3OTQvR1NSSm0zR3Z6VkFVSUk4eXJGUUMyV294NnNG?=
 =?utf-8?B?cGZZSXFHRGZPVm8wekgrNHhRTVMzY2kvbWxrNmVJSTZiUWJ2aGxJWUhBaWJ4?=
 =?utf-8?B?WE1XNDF5KzBRVWpQSWFtb3Y5akdINzljekFYeXhGdHhGTElnMG5tbDlZT0ZX?=
 =?utf-8?B?UFhDMlcvbWJkdGlGcmVOSWg0bWI2UExndGdOdFh2TzVwTGxJbjdrSmxYRzI5?=
 =?utf-8?B?OVAzOXBLVGljRDRSVnpDaXhvT0dScC95SkFiUUpGaUZrTDlBU1hoaGUxYzll?=
 =?utf-8?B?YzFZS0tmQzNhVXRiczRmMnNnbGRYTm9tUVIrSW1HT3JjM0hIM3d2czVmcE80?=
 =?utf-8?B?MFp2cldBQzROWEZqS1BCSDNrVGYwWHJ2a1hJSm1TOHNmWnBCbDQ5VXY2QmlT?=
 =?utf-8?B?cDUwZjdMTVUycGQ4VmRLMG5UOHBPbitGK1JBM0xYM2lYSVJLV2QxSTZzSFFy?=
 =?utf-8?B?RjlVZ01na1VVME13Uk56OCs4RkpwWmVGTWtQekFUeHJ6YTY1bjJadVlZekYv?=
 =?utf-8?B?Nm5BSW5mbmo3aDVrRi9PbjRJVUtsd0szWDBjOHRoRDZZSkNkWGZscFhUU2Vo?=
 =?utf-8?B?TU9PS01SNTFjL3lDK2llOWJFeDBNOVJOUHRYMG91VUR5blA4K0VZYmlFZVFs?=
 =?utf-8?B?aHB1cnpNcy9oY1NUaTZQek9kK3FRRzgwU3dxdzhWQmxzSUpsMk1PMmdTT1hO?=
 =?utf-8?B?eEhNOVNrRnE3ZEdxQkRvVGE0dFFHbmo1OXdBMHNrTjFtY3JaWTJ1OFJ1dStl?=
 =?utf-8?B?UEZoN1FublNhc1ZFWjRZK1NDZXRwZmtvM2FjdDFGQ0luMzV2VFJaS0tLeC9h?=
 =?utf-8?B?dXVwVkcxeXRVbFRnQXFpTGNhR3VJWDZNT0xzdVlsVUdJMUVoaERPNTlManB4?=
 =?utf-8?B?QU12cGZGUko3RVgzSEdsU0RVNmQxeHFUenpzdEpiSmNmSEFiMUxqd204WmxO?=
 =?utf-8?B?dWFrbTJwemtQYWN1YldIeHh2ZjkyN2hkS1NGLzhDWk4wZjkybXZjcW94N1Bn?=
 =?utf-8?B?MDA0MnZFb3dmbzlMaTVFZGI4V2tGUjdLWm1WMENqNlZqbkhQL1RsRzFJVkJq?=
 =?utf-8?B?cWI5OWdrdUJpQlJHVE5KUm5pVXRmSXBKcUVsOFBjU21aT2QvaWZpOVZzUFlx?=
 =?utf-8?Q?ntYwb9KSIkISxF8jaiNnozH9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80de261e-fd9b-4f4a-f772-08dc0d23683a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:48:10.5673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEfyOBUEgUqfyErfUP+JTgHkvE2/NFqgZ+CCW4mgQY/fDFU9RVYtfVYP20jxE9sX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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



On 1/4/24 13:28, Weizhao Ouyang wrote:
> On Thu, Jan 4, 2024 at 8:21 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 1/4/24 13:15, Weizhao Ouyang wrote:
>>> On Thu, Jan 4, 2024 at 8:00 PM Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/4/24 12:46, Weizhao Ouyang wrote:
>>>>> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
>>>>> crashes.
>>>>>
>>>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>>>>> ---
>>>>>     cmd/sf.c | 5 +++--
>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/cmd/sf.c b/cmd/sf.c
>>>>> index 730996c02b..e3866899f6 100644
>>>>> --- a/cmd/sf.c
>>>>> +++ b/cmd/sf.c
>>>>> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const argv[])
>>>>>         }
>>>>>         flash = NULL;
>>>>>         if (use_dt) {
>>>>> -             spi_flash_probe_bus_cs(bus, cs, &new);
>>>>> -             flash = dev_get_uclass_priv(new);
>>>>> +             ret = spi_flash_probe_bus_cs(bus, cs, &new);
>>>>
>>>> if (ret)
>>>>           return ret;
>>>>
>>>> don't you want to rather propagate that error?
>>>>
>>>
>>> Well, since the spi_flash is empty, the following code will
>>> print the error message and return.
>>
>> And you return 0 which means everything is fine. But is everything fine in this
>> case? Or do you want to see the error?
>>
>> This is command it means you can simply use && and if previous command succeed
>> you can call something else.
>>
> 
> Hi Michal,
> 
> Please check the code that follows this commit snippet:
> 
> if (!flash) {
>      printf("Failed to initialize SPI flash at %u:%u (error %d)\n",
>          bus, cs, ret);
>      return 1;
> }
> 
> it will print the error and return 1 as the return value.

ok. Then good.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
