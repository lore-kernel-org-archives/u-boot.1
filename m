Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB487CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B1A863F3;
	Wed, 18 Oct 2023 09:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hk/6+Ddv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DAD86F39; Wed, 18 Oct 2023 09:43:58 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205CE805F5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw3OODAE/ZjXIzCOPerMAsvHqCTzzpX6q7WKEzqhcWhzHCUuQ/acS86IFolsWl/ZeoNkoU1Y3BvcJTzYiVM+/jgozrxMvHvUjo/Xz7+FAR3ILpxDVeAAPeuPTTuawAk4h6OF0ZJlH1NN72zG1PO/2ZbUDpJZvpusFiHJKcB3NME3Pux0HxnL5Xa8c1OP9w3Wwg04pJGzrwhEOveAK//YyrmwYB0+OH6dvzyCAVkjZnjbg6v1EGb0ckj5nZmnYaerDQoa/DX/g513s1uYKdPMJ1a/M+c9zZykSoyd1T8Q6Nc+XnlxMH2d5QkQuQPFHjsb88PqXL3/9ZUUg2MpI/vIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIGCvuu2nlAczbmiznEQjhpEC3qFrPH/8c18X5KAmXY=;
 b=XnLVjfjhAJQVhbvxvfBT6uWbNiIOFcggcJMM0rB7OS7jPQPb2ftmy5ct4+7OGicdlDcVEtqhdClcNIAR2nGBgUr4t/zLVEakRux765eG1ooSvpF9MLlYQ2ewrWZ0XpUOTC6yTAxF83MHOQhNsPajeliWRcDIdoahqPlXHyChYb4o1LXRVnl2AKTWh01rDseMJTZU1wWSh82Nmgqbo3i/4Dv8ANZMByjSXZOuuIaCTYIePio6WhWooymHqqSC6J4ww6Rb8bAh3adbWx2CsljqS3xaVXI3GKF3WCoSh3Oro4K0NUWvhHd4OUYEKBhK9tKda+1KcRF0zbyt/CUMFbAkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIGCvuu2nlAczbmiznEQjhpEC3qFrPH/8c18X5KAmXY=;
 b=hk/6+DdvHEZqIHs2hKTLfC9XVOGXeUMf1V0OtNja0TYeFXm+9nD1XaWz/G82JdMvCPymNn6WhZRlNdaZoax6eLYYUxz6UgsVgYAGa8kwigUHnRpWmADLAKqtlZ/LW5Rw9seo3VHmfkHk4Jj8XDsu8Dxf/YFpk8CSADhob8aH2Qs=
Received: from MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 07:43:49 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::1c) by MN2PR22CA0026.outlook.office365.com
 (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 07:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 07:43:48 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 02:43:46 -0500
Message-ID: <14b71e46-55c3-4304-b993-df76045b5bc5@amd.com>
Date: Wed, 18 Oct 2023 09:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mtd: spi-nor: Add parallel and stacked memories
 support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
References: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
 <20231017033158.27740-2-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20231017033158.27740-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4994d99a-2b02-4061-da14-08dbcfadf6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkPpOeoHlYWf1KHGLTjul0CSTJSX4qNsRRsKPKBQ6IegET5w3ROqwGgSnkJmGcjS2N4OW6wwvmtQsxZhKYZuDplIEwEWUiTwl9yGVbsCI1VUl347EDF4ePQdx0hLjNCOatlXooDVWcAT7yhVO/LLkBpJncREySQdAe8Pmv3nLkSlALyauwfGLLLWMIOaJUeZmQApTfjMwUnjV1FXYvUd/+aAaxeMVGdQ/c/cFme6+UaRJenDhxU0lY3mOVBsH2E638Ss6vPeorY8+ZULE6won1rBUbLudLIOhnBnikr8n9dUVvTJ56b8LhfVRozqLFCeiLcttXVXrTkjK4fxAcDKksMQupEOQYgYY8AolHrX8dukH4lO2l1sw2B4f8h4De+5hiY2Jqv2aABLz1fNfaxr3ELMHsvcPplO8qDb/h8y7Qd+a7CnweRsKGGl4qkH6T31il9gn1eF84dZy45RmRjbjk6jL2qjxD6I1k6/MZXRiVV2d6XZot/VLKRmws0EqV///j9JyS16ILxj3cbNQ7m72IgAckBAyw/9ZXC0tT+dGKqthkXRXruKf0tIn8dsTtMEV0nJ3AEGgRNJ5juXF1CApxFKg6UJx46Kdk1TdSr7A1Mpeu8sPexy0CPahgKMLvYb5UXQuxGiJ13iNG4nPiHJrWxTpAv2951jP6SFuYZlrLFV+NxbG0u+ldvthYv4mre6Nzah867NanEjkDk2hQtenesLq2cgi6g3OdGZsia3InI46riBN0J7QRCeaeSfwxa43NJ34c1UfMoa1LjGIKfswVR1snOnJJ8fhBMl1sbkBzY1MQU7ekvHuZ8vHFd/agSZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(316002)(70586007)(70206006)(40460700003)(110136005)(16576012)(16526019)(53546011)(86362001)(40480700001)(426003)(83380400001)(36756003)(81166007)(47076005)(356005)(36860700001)(82740400003)(2616005)(31696002)(478600001)(54906003)(41300700001)(44832011)(5660300002)(26005)(336012)(30864003)(31686004)(2906002)(8676002)(4326008)(8936002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:43:48.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994d99a-2b02-4061-da14-08dbcfadf6ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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



On 10/17/23 05:31, Venkatesh Yadav Abbarapu wrote:
> From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> 
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly
> between both the flashes so, both the flashes that are connected in
> parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical
> 
> Spi-nor will pass on the appropriate flash select flag to low level
> driver, and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling
> the address space each operation is performed at addr/2 flash offset,
> where addr is the address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes,
> so size and offset are divided by 2 and send to flash.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-core.c | 280 +++++++++++++++++++++++++++++----
>   include/linux/mtd/spi-nor.h    |  13 ++
>   include/spi.h                  |  12 ++
>   3 files changed, 277 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index db20feb4da..b2e5494e78 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -639,12 +639,17 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
>   static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>   				      const struct flash_info *info)
>   {
> +	bool shift = 0;
> +
> +	if (nor->flags & SNOR_F_HAS_PARALLEL)
> +		shift = 1;
> +
>   	/* Do some manufacturer fixups first */
>   	switch (JEDEC_MFR(info)) {
>   	case SNOR_MFR_SPANSION:
>   		/* No small sector erase for 4-byte command set */
>   		nor->erase_opcode = SPINOR_OP_SE;
> -		nor->mtd.erasesize = info->sector_size;
> +		nor->mtd.erasesize = info->sector_size << shift;
>   		break;
>   
>   	default:
> @@ -965,8 +970,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>   static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   {
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> +	u32 addr, len, rem, offset;
>   	bool addr_known = false;
> -	u32 addr, len, rem;
>   	int ret, err;
>   
>   	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
> @@ -991,6 +996,19 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   			ret = -EINTR;
>   			goto erase_err;
>   		}
> +
> +		offset = addr;
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			offset /= 2;
> +
> +		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			if (offset >= (mtd->size / 2)) {
> +				offset = offset - (mtd->size / 2);
> +				nor->spi->flags |= SPI_XFER_U_PAGE;
> +			} else {
> +				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +			}
> +		}
>   #ifdef CONFIG_SPI_FLASH_BAR
>   		ret = write_bar(nor, addr);
>   		if (ret < 0)
> @@ -1394,6 +1412,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>   	u8			id[SPI_NOR_MAX_ID_LEN];
>   	const struct flash_info	*info;
>   
> +	if (nor->flags & SNOR_F_HAS_PARALLEL)
> +		nor->spi->flags |= SPI_XFER_LOWER;
> +
>   	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>   	if (tmp < 0) {
>   		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> @@ -1418,28 +1439,57 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   {
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>   	int ret;
> +	u32 offset = from;
> +	u32 stack_shift = 0;
> +	u32 read_len = 0;
> +	u32 rem_bank_len = 0;
> +	u8 bank;
> +	u8 is_ofst_odd = 0;
>   
>   	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
>   
> -	while (len) {
> -		loff_t addr = from;
> -		size_t read_len = len;
> +	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
> +	    /* We can hit this case when we use file system like ubifs */
> +		from = (loff_t)(from - 1);
> +		len = (size_t)(len + 1);
> +		is_ofst_odd = 1;
> +	}
>   
> -#ifdef CONFIG_SPI_FLASH_BAR
> -		u32 remain_len;
> +	while (len) {
> +		if (nor->addr_width == 3) {
> +			if (nor->flags & SNOR_F_HAS_PARALLEL) {
> +				bank = (u32)from / (SZ_16M << 0x01);
> +				rem_bank_len = ((SZ_16M << 0x01) *
> +					(bank + 1)) - from;
> +			} else {
> +				bank = (u32)from / SZ_16M;
> +				rem_bank_len = (SZ_16M * (bank + 1)) - from;
> +			}
> +		}
> +		offset = from;
> +
> +		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
> +			if (offset >= (mtd->size / 2)) {
> +				offset = offset - (mtd->size / 2);
> +				nor->spi->flags |= SPI_XFER_U_PAGE;
> +			} else {
> +				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +			}
> +		}
>   
> -		ret = write_bar(nor, addr);
> -		if (ret < 0)
> -			return log_ret(ret);
> -		remain_len = (SZ_16M * (nor->bank_curr + 1)) - addr;
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			offset /= 2;
>   
> -		if (len < remain_len)
> -			read_len = len;
> -		else
> -			read_len = remain_len;
> +		if (nor->addr_width == 3) {
> +#ifdef CONFIG_SPI_FLASH_BAR
> +			ret = write_bar(nor, offset);
> +			if (ret < 0)
> +				return log_ret(ret);
>   #endif
> +		}
>   
> -		ret = nor->read(nor, addr, read_len, buf);
> +		ret = nor->read(nor, offset, read_len, buf);
>   		if (ret == 0) {
>   			/* We shouldn't see 0-length reads */
>   			ret = -EIO;
> @@ -1741,6 +1791,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>   	size_t page_offset, page_remain, i;
>   	ssize_t ret;
> +	u32 offset;
>   
>   #ifdef CONFIG_SPI_FLASH_SST
>   	/* sst nor chips use AAI word program */
> @@ -1750,6 +1801,27 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   
>   	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
>   
> +	if (!len)
> +		return 0;
> +
> +	/*
> +	 * Cannot write to odd offset in parallel mode,
> +	 * so write 2 bytes first
> +	 */
> +	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (to & 1)) {
> +		u8 two[2] = {0xff, buf[0]};
> +		size_t local_retlen;
> +
> +		ret = spi_nor_write(mtd, to & ~1, 2, &local_retlen, two);
> +		if (ret < 0)
> +			return ret;
> +
> +		*retlen += 1; /* We've written only one actual byte */
> +		++buf;
> +		--len;
> +		++to;
> +	}
> +
>   	for (i = 0; i < len; ) {
>   		ssize_t written;
>   		loff_t addr = to + i;
> @@ -1767,17 +1839,37 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   
>   			page_offset = do_div(aux, nor->page_size);
>   		}
> -		/* the size of data remaining on the first page */
> -		page_remain = min_t(size_t,
> -				    nor->page_size - page_offset, len - i);
>   
> +		offset = (to + i);
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			offset /= 2;
> +
> +		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			if (offset >= (mtd->size / 2)) {
> +				offset = offset - (mtd->size / 2);
> +				nor->spi->flags |= SPI_XFER_U_PAGE;
> +			} else {
> +				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +			}
> +		}
> +
> +		if (nor->addr_width == 3) {
>   #ifdef CONFIG_SPI_FLASH_BAR
> -		ret = write_bar(nor, addr);
> -		if (ret < 0)
> -			return ret;
> +			ret = write_bar(nor, offset);
> +			if (ret < 0)
> +				return ret;
>   #endif
> +		}
> +
> +		page_remain = min_t(size_t, nor->page_size - page_offset,
> +				    len - i);
> +
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			goto write_err;
> +
>   		write_enable(nor);
> -		ret = nor->write(nor, addr, page_remain, buf + i);
> +		ret = nor->write(nor, offset, page_remain, buf + i);
>   		if (ret < 0)
>   			goto write_err;
>   		written = ret;
> @@ -1785,8 +1877,20 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   		ret = spi_nor_wait_till_ready(nor);
>   		if (ret)
>   			goto write_err;
> +
> +		ret = write_disable(nor);
> +		if (ret)
> +			goto write_err;
> +
>   		*retlen += written;
>   		i += written;
> +		if (written != page_remain) {
> +			dev_err(nor->dev,
> +				"While writing %zu bytes written %zd bytes\n",
> +				page_remain, written);
> +			ret = -EIO;
> +			goto write_err;
> +		}
>   	}
>   
>   write_err:
> @@ -1825,6 +1929,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
>   	if (ret)
>   		return ret;
>   
> +	ret = write_disable(nor);
> +	if (ret)
> +		return ret;
> +
>   	ret = read_sr(nor);
>   	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
>   		dev_err(nor->dev, "Macronix Quad bit not set\n");
> @@ -1886,7 +1994,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
>   		return -EINVAL;
>   	}
>   
> -	return 0;
> +	return write_disable(nor);
>   }
>   #endif
>   
> @@ -2062,6 +2170,10 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
>   	nor->read_dummy = 8;
>   
>   	while (len) {
> +		/* Both chips are identical, so should be the SFDP data */
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			nor->spi->flags |= SPI_XFER_LOWER;
> +
>   		ret = nor->read(nor, addr, len, (u8 *)buf);
>   		if (!ret || ret > len) {
>   			ret = -EIO;
> @@ -2726,6 +2838,11 @@ static int spi_nor_init_params(struct spi_nor *nor,
>   			       const struct flash_info *info,
>   			       struct spi_nor_flash_parameter *params)
>   {
> +	struct udevice *dev = nor->spi->dev;
> +	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
> +	u32 idx = 0, i = 0;
> +	int rc;
> +
>   	/* Set legacy flash parameters as default. */
>   	memset(params, 0, sizeof(*params));
>   
> @@ -2844,6 +2961,60 @@ static int spi_nor_init_params(struct spi_nor *nor,
>   		}
>   	}
>   
> +	/*
> +	 * The flashes that are connected in stacked mode should be of same make.
> +	 * Except the flash size all other properties are identical for all the
> +	 * flashes connected in stacked mode.
> +	 * The flashes that are connected in parallel mode should be identical.
> +	 */
> +	while (i < SNOR_FLASH_CNT_MAX) {
> +		rc = ofnode_read_u64_index(dev_ofnode(dev), "stacked-memories",
> +					   idx, &flash_size[i]);
> +		if (rc == -EINVAL) {
> +			break;
> +		} else if (rc == -EOVERFLOW) {
> +			idx++;
> +		} else {
> +			idx++;
> +			i++;
> +			if (!(nor->flags & SNOR_F_HAS_STACKED))
> +				nor->flags |= SNOR_F_HAS_STACKED;
> +			if (!(nor->spi->flags & SPI_XFER_STACKED))
> +				nor->spi->flags |= SPI_XFER_STACKED;
> +		}
> +	}
> +
> +	i = 0;
> +	idx = 0;
> +	while (i < SNOR_FLASH_CNT_MAX) {
> +		rc = ofnode_read_u64_index(dev_ofnode(dev), "parallel-memories",
> +					   idx, &flash_size[i]);
> +		if (rc == -EINVAL) {
> +			break;
> +		} else if (rc == -EOVERFLOW) {
> +			idx++;
> +		} else {
> +			idx++;
> +			i++;
> +			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
> +				nor->flags |= SNOR_F_HAS_PARALLEL;
> +		}
> +	}
> +
> +	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL))
> +		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++)
> +			params->size += flash_size[idx];
> +
> +	/*
> +	 * In parallel-memories the erase operation is
> +	 * performed on both the flashes simultaneously
> +	 * so, double the erasesize.
> +	 */
> +	if (nor->flags & SNOR_F_HAS_PARALLEL) {
> +		nor->mtd.erasesize <<= 1;
> +		params->page_size <<= 1;
> +	}
> +
>   	spi_nor_post_sfdp_fixups(nor, params);
>   
>   	return 0;
> @@ -3158,16 +3329,54 @@ static int spi_nor_select_erase(struct spi_nor *nor,
>   	/* prefer "small sector" erase if possible */
>   	if (info->flags & SECT_4K) {
>   		nor->erase_opcode = SPINOR_OP_BE_4K;
> -		mtd->erasesize = 4096;
> +		/*
> +		 * In parallel-memories the erase operation is
> +		 * performed on both the flashes simultaneously
> +		 * so, double the erasesize.
> +		 */
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			mtd->erasesize = 4096 * 2;
> +		else
> +			mtd->erasesize = 4096;
>   	} else if (info->flags & SECT_4K_PMC) {
>   		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
> -		mtd->erasesize = 4096;
> +		/*
> +		 * In parallel-memories the erase operation is
> +		 * performed on both the flashes simultaneously
> +		 * so, double the erasesize.
> +		 */
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			mtd->erasesize = 4096 * 2;
> +		else
> +			mtd->erasesize = 4096;
>   	} else
>   #endif
>   	{
>   		nor->erase_opcode = SPINOR_OP_SE;
> -		mtd->erasesize = info->sector_size;
> +		/*
> +		 * In parallel-memories the erase operation is
> +		 * performed on both the flashes simultaneously
> +		 * so, double the erasesize.
> +		 */
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			mtd->erasesize = info->sector_size * 2;
> +		else
> +			mtd->erasesize = info->sector_size;
>   	}
> +
> +	if ((JEDEC_MFR(info) == SNOR_MFR_SST) && info->flags & SECT_4K) {
> +		nor->erase_opcode = SPINOR_OP_BE_4K;
> +		/*
> +		 * In parallel-memories the erase operation is
> +		 * performed on both the flashes simultaneously
> +		 * so, double the erasesize.
> +		 */
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			mtd->erasesize = 4096 * 2;
> +		else
> +			mtd->erasesize = 4096;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -3867,6 +4076,9 @@ static int spi_nor_init(struct spi_nor *nor)
>   {
>   	int err;
>   
> +	if (nor->flags & SNOR_F_HAS_PARALLEL)
> +		nor->spi->flags |= SPI_NOR_ENABLE_MULTI_CS;
> +
>   	err = spi_nor_octal_dtr_enable(nor);
>   	if (err) {
>   		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
> @@ -4033,6 +4245,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   	struct spi_slave *spi = nor->spi;
>   	int ret;
>   	int cfi_mtd_nb = 0;
> +	bool shift = 0;
>   
>   #ifdef CONFIG_FLASH_CFI_MTD
>   	cfi_mtd_nb = CFI_FLASH_BANKS;
> @@ -4169,7 +4382,9 @@ int spi_nor_scan(struct spi_nor *nor)
>   		nor->addr_width = 3;
>   	}
>   
> -	if (nor->addr_width == 3 && mtd->size > SZ_16M) {
> +	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
> +		shift = 1;
> +	if (nor->addr_width == 3 && (mtd->size >> shift) > SZ_16M) {
>   #ifndef CONFIG_SPI_FLASH_BAR
>   		/* enable 4-byte addressing if the device exceeds 16MiB */
>   		nor->addr_width = 4;
> @@ -4179,6 +4394,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   #else
>   	/* Configure the BAR - discover bank cmds and read current bank */
>   	nor->addr_width = 3;
> +	set_4byte(nor, info, 0);
>   	ret = read_bar(nor, info);
>   	if (ret < 0)
>   		return ret;
> @@ -4196,6 +4412,14 @@ int spi_nor_scan(struct spi_nor *nor)
>   	if (ret)
>   		return ret;
>   
> +	if (nor->flags & SNOR_F_HAS_STACKED) {
> +		nor->spi->flags |= SPI_XFER_U_PAGE;
> +		ret = spi_nor_init(nor);
> +		if (ret)
> +			return ret;
> +		nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +	}
> +
>   	nor->rdsr_dummy = params.rdsr_dummy;
>   	nor->rdsr_addr_nbytes = params.rdsr_addr_nbytes;
>   	nor->name = info->name;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 2861b73edb..72206f51ad 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -13,6 +13,9 @@
>   #include <linux/mtd/mtd.h>
>   #include <spi-mem.h>
>   
> +/* In parallel configuration enable multiple CS */
> +#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
> +
>   /*
>    * Manufacturer IDs
>    *
> @@ -185,6 +188,13 @@
>   /* Status Register 2 bits. */
>   #define SR2_QUAD_EN_BIT7	BIT(7)
>   
> +/*
> + * Maximum number of flashes that can be connected
> + * in stacked/parallel configuration
> + */
> +#define SNOR_FLASH_CNT_MAX	2
> +
> +
>   /* For Cypress flash. */
>   #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
>   #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
> @@ -298,6 +308,8 @@ enum spi_nor_option_flags {
>   	SNOR_F_BROKEN_RESET	= BIT(6),
>   	SNOR_F_SOFT_RESET	= BIT(7),
>   	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
> +	SNOR_F_HAS_STACKED	= BIT(9),
> +	SNOR_F_HAS_PARALLEL	= BIT(10),
>   };
>   
>   struct spi_nor;
> @@ -555,6 +567,7 @@ struct spi_nor {
>   	u8			bank_read_cmd;
>   	u8			bank_write_cmd;
>   	u8			bank_curr;
> +	u8			upage_prev;
>   #endif
>   	enum spi_nor_protocol	read_proto;
>   	enum spi_nor_protocol	write_proto;
> diff --git a/include/spi.h b/include/spi.h
> index 1bc18e6552..2a3ccaa754 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -39,6 +39,16 @@
>   
>   #define SPI_DEFAULT_WORDLEN	8
>   
> +/* SPI transfer flags */
> +#define SPI_XFER_STRIPE	(1 << 6)
> +#define SPI_XFER_MASK	(3 << 8)
> +#define SPI_XFER_LOWER	(1 << 8)
> +#define SPI_XFER_UPPER	(2 << 8)
> +
> +/* Max no. of CS supported per spi device */
> +#define SPI_CS_CNT_MAX	2
> +
> +
>   /**
>    * struct dm_spi_bus - SPI bus info
>    *
> @@ -156,6 +166,8 @@ struct spi_slave {
>   #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
>   #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
>   #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
> +#define SPI_XFER_U_PAGE		BIT(4)
> +#define SPI_XFER_STACKED	BIT(5)
>   };
>   
>   /**


This patch breaks sandbox64. You can see reported issue by running this command.
./test/py/test.py --bd sandbox64 --build -s -k test_ut

Thanks,
Michal
