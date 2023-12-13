Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C140FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 07:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B4D87463;
	Wed, 13 Dec 2023 08:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipzydZbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C3F874D0; Wed, 13 Dec 2023 08:59:41 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F9787015
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzYldISHNC5Sh4wtNnelUnDwU6y3ELWWR+/0Sgkxmc0BecLjp3Mblnj1/RRZxxP1gQ4R6GsmU4vg/iyE6sCoqgELnuKLpji7csDHGjmR/2nwZsNY9Rsg2t4trnycj/HlX+zCVlie+U+wzmY3nKcZK0zGivNNhhvJbB3Z7bklAVlrD28HZ5r5oV6dMWF5+qI0cfTdm3+lP+GYj9/gZMJPUbDaXzI2S4otrGjrAdNJ8T8ErJc8oyK5OaweB8aBkKFcf+3j7fp6QbXEkCQia5KjDVtgw+KbtKdkGyzt3G52+9z/6K30R1+MfPveqeTj/3NaDZBLQNQcVD1Ndu5VcO6elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8rbCTutn2laGmiY0KlU9o47BaPsQmUFjxXgrB1IfOo=;
 b=XOW4GZ9bdc/oQ3o1VNPjzg6344tvOkXyW/9MhgdS50K6rro146ISMEgx8DbotzwuKEd/U9B8I8zDLycCvm1KyS4NgjwApMLg7bxsd0nRgPB8xtqm319K6vU59GIChgtLQdEsbo46jPIRP+CQLxaPRlXGdOg2sYDP7C8/4dfla2Dw1teqWRkewRF4nvHwPMtvJybyMxz/lDALGIenD6cQ4XdzpbcR5zSkSTFSllzrluKrqPb2EZDP395MdPl8h2Wem6zzUAj4QrPEwS48RBXenbhaHAVbsVn2JNOckWLYeC1SxfT7qyCoxSmJRYZtnERe31NjycraPbTU3l7qNrA2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8rbCTutn2laGmiY0KlU9o47BaPsQmUFjxXgrB1IfOo=;
 b=ipzydZbrPDl4ad0jwU6FGnE8Li/1TDTOINVv6pM0P5odqfYUmYho/y6NShBXUDZ7/gU5NN+tB3kfrSqafMK6np+6VvaFOVJs3mFX4z+fwKoH8jaOmj9FRzWYSn8ggSv85hgpwkmCUYHZRG+sy7EldDQKXDkJ2RsqKj3dV9Rdx9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 07:59:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 07:59:35 +0000
Message-ID: <e6ecad5d-5ec6-4ce7-a072-1c9e3b2761a1@amd.com>
Date: Wed, 13 Dec 2023 08:59:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mailbox: zynqmp: support multiple child nodes
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, u-boot@lists.denx.de
References: <20231204215620.63334-1-tanmay.shah@amd.com>
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
In-Reply-To: <20231204215620.63334-1-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:803:50::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de8f6d6-49a2-48ff-5b34-08dbfbb171f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08W82gtopHfR5ONjqzaGim1tw8MOuoTHs8dUjp1gElv0bc1kifE84hL235XPHHfquD0oKmTQSbEimwmZ+Yxrfox29dPXzA1b873B0+j25E4L70O+OBmt3s/l6hhSTEvrJChzyqzJJ4iIUzHhWEBnadREpaCm6NbPl1wT1mHSjDOkbvn4ztUrBX9CeAcTs7p5CNcQinRss7DZoW5PuFzBw17w3pGObCeWo+C5Lc+wXNCiyr7wxi325QVBct4bGV8icph6kREOa1jeQdBGHrwbTHLjixUIRRl9QruBQ/SpgxybVTD0Q629B8imnIiZFYMQPwa9ev3Sc+r/GJsl5Jwlo7XihSISmWZbQI2aZ/3aCc8l4JXJazdbffDcWzB86EEca9FQs3rzxZrXcr4whH/MxRwn8sjXExKsdvxz7dYktv8XDp+ML1Uns+/igm11+/hLSa7OIAeYJ2+B1ns45Apszy10JonzEEt5MzWjeREjVVuRvVpCh+vDzi2sOm9SclydNSana9dWfuAscY9s5HK81CpIzQbXWwTkhWTDq7+2x238nllf+BVMTTpUKvKjfo6/iGugNo/xzUAht7ibtZ8/po8ejZ3iked34jOd2mMapNerxPB0E0ZS0HYPFg36C+rVCH4dVQgNdWdMceBzIfoD6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(66476007)(31686004)(15650500001)(5660300002)(2906002)(44832011)(316002)(6506007)(6666004)(8676002)(8936002)(41300700001)(38100700002)(478600001)(31696002)(86362001)(53546011)(83380400001)(6512007)(2616005)(26005)(36756003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEVBdFV0bG9OckFYQmQrQk9rMG9aWXZ3Z0cvWElQcSt0T1llc0lYb0RUb005?=
 =?utf-8?B?SUdLdGx3KzZwOW15cHhzZmZtb3ZjakNuV2hkSHE4d2lPYUxldmRaOHh4M01I?=
 =?utf-8?B?ZWZPS1N5UmlSRFBxQ0R6SE9xOE4rbVFjcG5hSURWUGJOTUdEaUgvRHl1SGdk?=
 =?utf-8?B?djZ6NzN4bThDSUZjSzNhckZ3MWtLYWlFZzFZb01URWJOVXFhR1dtOXluaWhQ?=
 =?utf-8?B?NDVnbjhXNXdtNUhpdkswbjBQRjQxTUh6My9QMjlNRzRha2hpWXgxcUw2ZDRR?=
 =?utf-8?B?U3FlMDhCdStrV1ova1F5TE16eTJLRWxoWVlmYVRVVzhJQ3BNVi82cnlYdnQw?=
 =?utf-8?B?T3VKMG5DUUxOcXA2emN3MmRJUm9IZTY1bGlSM2htS1NmNmpjSENvMFpnWHl4?=
 =?utf-8?B?bWNzdDFYNHpnanJCakp6SUg1OUpTUTVyS1hRS1R5SUNyVzZvVnk2eDVpd3lq?=
 =?utf-8?B?ZlBVblBtRTFSc2YxYkRuV0EyQWswbFR6amd3UVc2TVZ5MXhhbHVJWDJmWHJS?=
 =?utf-8?B?aVVRK1FUcXhjYzN4TysxdlYvejFwUzM1bGd5SkFieTFSNm1zcHRlSkpua1I5?=
 =?utf-8?B?ZUZJMUdxUTVNU3F4TTc4aVNySjNTS3lMUkFmSlBxQTNJb21jZEFTQzN5c2tx?=
 =?utf-8?B?MWR6Ni9UVUROL0lDUjR3cmlNYjcrZ096RXZsYkE0cXptbE9VeU0rMnFzVzBO?=
 =?utf-8?B?T1M0d1gwOXd2alFXZWlEQUttUGlPZTh3aHpGZ2NlZ0xaZWxqNVVHaW1TeWtQ?=
 =?utf-8?B?c2RwVWJMd2pnNnhReStwaDg5SUdPWEN2ZytFODRKTnBWSWVrRGFNak8vNlVY?=
 =?utf-8?B?cHMwNFBSdVNmVlRoaXcrWXF6bTBWV1hDMUlwVUk3NTRnVFlTQkh0dkhrZjBy?=
 =?utf-8?B?b0dhN1pvc2s4TExzcmJmdTE2dWEvT21qL0p4bFUvaW5rSUg1YStsVllnTW5L?=
 =?utf-8?B?Uk9GWDBLVGQwWTVwbmllUXR3T0dCNVNCUXQrWjBqbHFyNmE2Q2pTek9FMEVD?=
 =?utf-8?B?ODJpMW1KeFF5MDZHZkRzN3JWcVVaRmZmT1pIYkd2anRQWkdDYnNuRkJmSzRr?=
 =?utf-8?B?aFJIZGdpUHJhaVhIdGJINDJCRUtNc1pZbzRjSUxhaWcySEVzNitEc3o3TDAv?=
 =?utf-8?B?Q3J4RE5NbWRXU2VES2dHOHV2SjJYbkUvZVliZkRwdGRaMnV2czhveGlMMjky?=
 =?utf-8?B?N2Y0Z1NxSlVMdHFMNis2c2NTb1h6U1BQNnlvblpHUHNpWmhaaERuMVozYW9s?=
 =?utf-8?B?Q2RISis3M3h4RU8xbm9kQTV1YXdJRXFURXRSSk9nbUltdHAwNTVnRkNIcTF2?=
 =?utf-8?B?STd3NVhPOTA2UWxzTHhCeVk2SjVvb0NhS0NQZTQyQTB2SFBTVGNhT2xjd2pI?=
 =?utf-8?B?c2JjNEdaMHpNREtNazViM01EWFpHcUM2eHplNFZuMW5YNG1IcE5LNVhPcHAy?=
 =?utf-8?B?Qi9YejlpMzFZQzdVdWVidldHQzhMbHdVOEozd3QzMnRsSEFPWmlPT0JiVE1J?=
 =?utf-8?B?THd3anlCVCthUmxxYmZiMS9ySE1lUXJVajJ3T3YyVGlkamkwMEU4b3NIMlVC?=
 =?utf-8?B?cTh4K0lJay9hUW5WOEpCRVpTVnNVTU9sZTREaVRCMmNmb0xyL0x5SGpKdytQ?=
 =?utf-8?B?K3BYZERUUTMvMkFwdXVFQ3oyRGRMLzFQSWhleEJiNmVha1Blbmx5b1M2R3pP?=
 =?utf-8?B?MWRZVkltMklEemJsY1I0ZkxmbGUrSkM4amRuVHlYbDE5R0FpalVvWkZ6aVlm?=
 =?utf-8?B?ejk4YjcxZWEvVERySG9UYkQwczJTaXhmNVAwZHBCSTBNMnQ2OW5INDltRWNZ?=
 =?utf-8?B?Z2tlL1o5SHJNMmlmUENZUWxFNW12Vk43SzM3Ly9JWnJ5cjZLcGFsQ3NkbU1Q?=
 =?utf-8?B?M0M5WkcxUkNtTDB3NXdTaHptUk0zWGEyb1c1TWx6RitFQUxJR3Q1bUtES2Zw?=
 =?utf-8?B?dkZ4cHppbGFwSTZrWDhrZ3FpdGJtTjF1TFhSRnl5WkdmZFVwTlVYOWFDTW9E?=
 =?utf-8?B?NldTbmpUWmFWVS9ROXFsUkZqOWdnSHdvRUgxd0tCVjlzdGZHclY2RzNqRG1O?=
 =?utf-8?B?Zk8xb0VONWVUdEdhYkg4cmw5NkE0ZDdudWVMZEVuNkxEVEg3Z1IxbE1RcnVo?=
 =?utf-8?Q?jAQzmDH091iKcYq3hNcoKTC7u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de8f6d6-49a2-48ff-5b34-08dbfbb171f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 07:59:34.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nhn0pgxl8e9fczFTOhB0kn19ja4FviMaKyCfnrE/aa+xkw7KdA6pcmjbd5gGxdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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



On 12/4/23 22:56, Tanmay Shah wrote:
> Current zynqmp_ipi driver is hardcoded to work with only PMU
> mailbox node.
> 
> This patch series adds new driver "zynqmp_ipi_dest" to support
> multiple child node of current "zynqmp-ipi-mailbox" node. It
> also adds support of SMC calls to TF-A to configure IPI
> register address space.
> 
> New driver uses compatible property recently introduced for each
> child mailbox node. However it is important to maintain backward
> compatibility for old dts. Previous driver now binds each child
> node to "zynqmp_ipi_dest" driver which is needed to maintain
> backward compatibility.
> 
> Tanmay Shah (4):
>    mailbox: zynqmp: support smc calls to TF-A
>    mailbox: add el3 support only for zynqmp platform
>    mailbox: zynqmp: support mulitple mboxes via device-tree
>    dts: zynqmp: add missing destination mailbox compatible
> 
>   arch/arm/dts/zynqmp.dtsi           |   1 +
>   drivers/firmware/firmware-zynqmp.c |  22 ++++
>   drivers/mailbox/zynqmp-ipi.c       | 159 ++++++++++++++++++++++++++---
>   3 files changed, 169 insertions(+), 13 deletions(-)
> 
> base-commit: 5c4e9d0c74a8c2f8d0f4e0ab9cf44959298c2bad

I have reviewed it internally multiple times and also tested on kv260 and I 
can't see any issue. That's why applied.

Thanks,
Michal
