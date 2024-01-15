Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FBAC47422
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2206865F5;
	Mon, 15 Jan 2024 10:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4T1gaUS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB810865F5; Mon, 15 Jan 2024 10:28:51 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347A884694
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BORichBFGwemDb0FXcbiaFxUgvhN8iiUZFgKbIVL7HUL09csWmD/VbV+Dqxo7FsnbdJj4aifLvnEFQ2+O35FwCPaivFtlpKUjwie9Q+y7t9V+QZ88ApKjVpZECCWtK6VeWhKLAhStmZ3HW8RzcTYXP9ko6AZBpo+aMkRYczFO3RxpQk7rgpl8RIGHUKkHT5A8XaZKmuymn6E9dbj2bpj1SfMPGGKsoobq5HUvsKMb6PJE67LRh5MUo4Uik2ieCKz1/bJzWo2286LJ1X+Sx1PRjNlVFZZhcZdXThu1ybSlm4ZBbrSEVy06uPaZvnY64eNfXO7J5LnL8Xd4ho/Ejvalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb4FVF0PA9RreE4lh0C/T7oYxtRswD53gj8105P5u6Y=;
 b=Eg1CcFV5tsY8Y804WbxlKzlfkBvv7vUoNQPeW+OKk2yY8oT6J/kQMNZCcYhsPdCu5/8nt+duvXzKBy6BLK0IHfMasdXLoVmDvzJg2C6l4gt8vCROYKsF55MeJz1tl8IzTGZU0z66eBO3s2MiTjD4zMXS4vHzToH6bEBRyBvsyUYNxNeBq96QPKWv7G8UzDpuBhoJMUXpRob5uGdDpw26vw2iTPS/r5yvZ6RgtuOo6iYBRJ1VcDeUfOu8mUC0h0fmJIYGU/hX6tnextOl6QKB4JJ+QITsHleS8RgDosAqswDU6LmPbQOy+VJsnZQLOGwerMpgOL20vCY+GghgNSVwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb4FVF0PA9RreE4lh0C/T7oYxtRswD53gj8105P5u6Y=;
 b=4T1gaUS7Mv7wodO82osX+0ytpbHJmrUeVkq6M50i7zn/VyMWKdfzIJtZQmbxQX29cmDHopjRHhj9FRc/iYlMKyk2AjdVwndQVQ9+a9Afs3estnJmDohJXjNoXIEPEH59nzgj30+ot0OWobCbvE7eNo4gj/NFHea/LtVYibYH0nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:28:46 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:28:46 +0000
Message-ID: <d98b3907-2486-4fff-ba1f-69f3b51d593d@amd.com>
Date: Mon, 15 Jan 2024 10:28:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Rename zynqmp-power node to
 power-management
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <a2f7fe30e3630c262c2773a595b7a0c8918573a0.1704359569.git.michal.simek@amd.com>
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
In-Reply-To: <a2f7fe30e3630c262c2773a595b7a0c8918573a0.1704359569.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 376d8bdf-7bca-4988-0a4e-08dc15ac5f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwqyjNAHT/jQRYx4z+RzKX/2iAZTa1tFUkUykKkDep0ZB5fsQjL9lacddq3pvjRhybPCAHlppIlchOGzXS0A0qG6QQ1vcd6uB31DzomzW8ekyuCEFEN2YKXzYD14LQhHOhilIBAwDyahB71j8U2K5lwqDhKN42kz65uOa12oh+9OJZReiGKhmwMo6kuqzOVeExpruSEScH5wmD81gASCbKZN0CbBC5vzUCm+62jgn9XhpWqGBQ+TG/yyL6TYB9bcWQzGMfTTu9BLzMi3bpOqtPR6NzHXZEsYjtc8lvXaTW91ctOsZ9SUcdmtykz1FoKWH78ozwIsZwhkl77fph3cHUtoXYrQcZgGOU9ymuEhR3Lpr1KxS51/5dhT4IOtAaRneQeorE0/eT3ZRjTJ/ZFpemCsV58UFZDE8vICleNuqQkdhsegVkLNHvm2QcQfWzEJ61jGXQm0sQHPhJwcStVE2U40LY9M42PMWOPgAz6bSKW+s+IZpxyNNHm8m8U8DhKvjGLicFVOdzeNzCgKyDmNmBFxl4wQzwBCQamtqg6pvhpG7PJof+tgwCqYnD9QEkqaXxf4ycjN42B+4z5GKiVkXJYLLYb6xh1wgpC5gZavE92EAPaJwwDvJTz7Zzphb+ysn6YnPJv4HcWQa1TkHa3TEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(66476007)(54906003)(66946007)(66556008)(6486002)(966005)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJDdlIrOFJSZU8wNThEbEpQOUdNWnRzcGF6YXh2SjBpYmRMc3IxekNDZ2h1?=
 =?utf-8?B?em9qTm5rMW9Ba1hpVHpIODREQ0pKN3cwRklGVkhmeXM0cVpIblZMamhReEx6?=
 =?utf-8?B?eDJrekdEZ0NUWU54c0VCcCtjQnczK3pDb2VmZlZqNCsrWmdzajBYR0d2VnNw?=
 =?utf-8?B?eGIvNUFUYWo2OElZbGw5NTFsaUpVNzBsR0xCVU4zYzJwMFZzVnVVR0xZd3hG?=
 =?utf-8?B?NjBITEU0MEFZVk9jSDY5ZTJpQ1JIRHoxMFNOQm5HRzBmVThUSk5MVm9wd3Ny?=
 =?utf-8?B?VDlBb1UrMnVhTEx2NXZtK0I4Q0g2c0xmZGdiMmtZNHFkdkZEOVRTT0lLdDRZ?=
 =?utf-8?B?V2dNVkNjUFR5WTJBS0hXTERVRSt3N081VldaK3gwSkRhbGdLL3ljaXM4SldS?=
 =?utf-8?B?aEFTazFiK3c2QktmQk1URFAvK2I0UlByQVljaHB6UXl1ek9KRUFkZ29WM042?=
 =?utf-8?B?UXF6a28vMWVCanZFeUUyUEdFQ3pQbnAyNGkyZGdIYUlCT2I1QVRBUEN3SUVF?=
 =?utf-8?B?OFFmTXkzWERBTmQzQ3pkZlBLV1BnWTVwbUdOa0xXN3g0OVZhNDBTYzZiKzc2?=
 =?utf-8?B?WWtGVHc3ZitNWmpFYXh6cFdlK05yOW56SzdVVGl5NExGaDJTNXhhVzA1N2Jj?=
 =?utf-8?B?SFZhcmlZS3A1OFhFVXllYzV5ZU9mZktnOXdmOThIUmFTSFk1UWdNNTNQUDNC?=
 =?utf-8?B?cktiRXJYeFJpVHo2NHV4MG1LOVdNQmlkZFZkcXp5dzNtYmplRDUrQmtBczZo?=
 =?utf-8?B?NW5sc3JTUDVnMHIxcUtvWWlWVVlLMVBZU28zRTFmVHp6NDlnQ2lHMlppckty?=
 =?utf-8?B?WkhIeThzOHBWMjlHcDlVajZTaVZlUVUrWWUvY1l5SmF3aWt0cE5ONGZVMFJJ?=
 =?utf-8?B?M0N4dHdON2krcjd6bFZjc1d4VnNjbERSc3NJNHFKV2hYTENmaUJtbGxDdU1V?=
 =?utf-8?B?NFluYlZWUGlRQ1dVSTlsOS9tS2Jud2ltREIxYnY1dGt1ZHVkWXhaazRnb0Qy?=
 =?utf-8?B?OEh2bWdmZjhjQUJLVUMva2I2QkRhUnV2Z0U2eW1WeDNiSUw0V2ZvSm9CRGF5?=
 =?utf-8?B?dnAvRHZVdXF5MlBiRllraDF1ZzFsaFNhaS9BY2Y4OHFmZFNmdVFwZmV1UjdG?=
 =?utf-8?B?SFlYTU9pc043UDFUNVU3MkhRN2s1MnRWMWRVTm1PUThTcWNKc0lWTzBnRU9y?=
 =?utf-8?B?SE83OUJtOTdta3pwSFhWUStJdnFyZmIzZVR4TGMwYXM0L2xOOS9sMDFXaTNU?=
 =?utf-8?B?bk4vUlBodXhIeWRJRnlzZmVDV0cveklrZTZjUkJyNFZmZGlZdHl3aUpmTlZF?=
 =?utf-8?B?MEduWHdmRUVBU2d4eGJTRHZzNVBCWWxieGRhNFNIaVc3SDBRK0pqOWY0alpv?=
 =?utf-8?B?NXdpV053Z2M3aHp4a2lxWWZJTU0zMzBGdUI4bGNnQmIweFhLZ0l3K2ovSnRa?=
 =?utf-8?B?enJpQVUxeXA4cGttVmVVNi81eEpUUlFiZTdhZ3M4VlUrQzV2MVIwWTFES3ho?=
 =?utf-8?B?RHZvUUhGck9SM2luM0t1UEhCZU1ET1VZZ2JlYVo4anRrM0ZYT2ZoV2VMSkZT?=
 =?utf-8?B?WE1ONUN2VHZBVUVHdHYyWi9xdUl2cnBDM3BGd21sdHFMYlBCbk1sU0xUWUxS?=
 =?utf-8?B?dVN1MTJpUHZWTXlEZkdMQ1BpdFA0MGVCNUtkQkgzVlpQVlhvcE54QmQ4NmRD?=
 =?utf-8?B?SklVK1R4dTJ3UFlNc0pJNFJEY3ZRVU1FMEtBaTF2ZzRXY0hXaHlsd1U0VHh4?=
 =?utf-8?B?NkhqZkRJZll1cm5jbm5zalplL2NJaGpNaldoMXE0UU9RaWM5RUhDN3k4bWpK?=
 =?utf-8?B?TStJYk1CYk9EbktYRjdIeVJwOGEvaENSa3pJSHN6NlN3MVdwc1VPMisyNDFH?=
 =?utf-8?B?ME9yS2hyRDhUcG5HVlVpaG0vRTNiVVh1bmpNaEw3aG1DTG0wN3MxV2RGS09p?=
 =?utf-8?B?ZktQYmtJZERmN0E1RXcxSkRmZXFvMEhoelJSalhPbU5oZERRdzRQT2svWG5C?=
 =?utf-8?B?V05mbTlvNUF0OEFEbXF1T3JmMEtZcFU4US91SkhZNVdSTDNneEY3dGJ6VVZq?=
 =?utf-8?B?ZWNIbnJJaTF5bGFqSDlPWXdmWUZtOFM2MmtIaHk2SmhNS2ViRnNyZzM3ayts?=
 =?utf-8?Q?c1zAjDQtxHbWlmCXWB3yte+oi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376d8bdf-7bca-4988-0a4e-08dc15ac5f6c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:28:46.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r6Tb5FY1hgWkyT58s8AgrG9xOVqcRzPeRQKveZfYChqpTKx+ilIofyh8fQi3PW0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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



On 1/4/24 10:12, Michal Simek wrote:
> Rename zynqmp-power node name to power-management which is more aligned
> with generic node name recommendation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Linux patch already reviewed here
> https://lore.kernel.org/r/bf24cde92c2b9e2824847687fab69fc25c533d53.1703161663.git.michal.simek@amd.com
> ---
>   arch/arm/dts/zynqmp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 21be909b1abe..2066d5b616d2 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -198,7 +198,7 @@
>   			method = "smc";
>   			bootph-all;
>   
> -			zynqmp_power: zynqmp-power {
> +			zynqmp_power: power-management {
>   				bootph-all;
>   				compatible = "xlnx,zynqmp-power";
>   				interrupt-parent = <&gic>;

Applied.
M
