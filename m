Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D58C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E8286925;
	Mon, 18 Sep 2023 16:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KL5tWt7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9DD80726; Mon, 18 Sep 2023 16:20:42 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7C086925
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct+SZzwvMwsJoiHTNXt3SmpC/onOshlx+H0rk0pizoOvyDtnNWg3qScqDLYIyWMi4yw0nPbE9wtnPi5iEFwPR5wVxUfXnsB/GFC6hG4hiGPSuI9mnsIILMCSW/D5bfYPffast15sLx2AB8GLP+zx1CPP+R0UNeLMNe6+XB4F6NYi8Rkkca/0FjPSsN4I3e1gW4v+LVydNJV2Qw0aXCFZiGTZje9pL7twxYfVeTd5lDcIzI5xSncPP8jIbQ//zuJukDdrwv1XC0GfVGRxIrkYi/BxxGQu8p1Qk92RsPjf6rA+0oc/vJggUZFO2BiuuGBHe6fqv/GQ+XPGp3O49hoN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a57V9w3VfeOGi2urX0i+rVgYcKIs4EcNdeSHeW3449w=;
 b=iRlTA5CBaTr4eQ+xXNvfFV5/7YIuScJx5U9UTReLs9XRj6l58wlNxX1Y47NJNqMHwUAWuRhk/JETiRWW7vHDdVYTKg7jYf1qIUiHlKDfzrdUKJNOAB0y/sNo2rSz7/M+OdW6FGqKk2+2VLFIoLfaULS+NaunVUTSr+iCXYy2hbPNYMC6Yxs8ZpYKh2FnhgpjDRP1s3ZsLWMWc/odjexgkL8kJGHlhh4ADIrghLDXkowolKSPuyesVruIRJfSrKHxA0/u6PJJeQbIN+eZvSVRlVGh/8myD4MZuCMdbF2AT1s6u1W0/jcF+mCtwGv0ZXEnOMB6tyy7Y01xRctYlsJg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a57V9w3VfeOGi2urX0i+rVgYcKIs4EcNdeSHeW3449w=;
 b=KL5tWt7aj44wD+d4ivyxovqdK2PQ8u11ThsjcQWblGD8gIzuNgwtNFMfZShERt7u0zIa/U0cCELdtYx7gQqEvdfh49ufP3xObnw28Veiu8LSzRTXUseQVhg8WjMG5PaqRNH0mjRAiQj1EUlelblzICfg8NTgHOHQxSSRIf2CAa8=
Received: from SA9PR10CA0022.namprd10.prod.outlook.com (2603:10b6:806:a7::27)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 14:20:37 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::bc) by SA9PR10CA0022.outlook.office365.com
 (2603:10b6:806:a7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 14:20:35 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 09:20:33 -0500
Message-ID: <e688b682-25b3-49d0-b5e1-2eec3d5ad8d5@amd.com>
Date: Mon, 18 Sep 2023 16:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix dependencies of USB Kconfig options
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <rfried.dev@gmail.com>, <seanedmond@microsoft.com>, <tobias@waldekranz.com>,
 <sr@denx.de>, <john@metanate.com>, <git@xilinx.com>
References: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2013c9d0-495a-4c00-3c75-08dbb8526d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpTaQ84IMlfHHfjA9ZE/Zp3yoNNgcDo7Z7m3uOLote2V/6cnmdeun8lkY1yuIxs9CSRG4+h1kdglTc6LZVUnyDVEvC5TtsBDKszila/VHeYMA0xiDvyYoyTOy/ps1Ne8d2FOX9g7LtcNwkOAjPt2ZLzPYQeaWJHDXDqvz0eyacn25V1aJmKU/FxVO9vJ+wwEgLfto6UYlZJcUQ8r70TdLdjK4EYb4EemoBYrBWzk+fEG+B+FGlmxBdafEnRWUaiEMAuLWTSTB9Rr9Xl1hsa0sgwfdhUxjBuMQrGN8Qd01WzUpeaCC6x9R69yoMgGdUar8NBtumYFCU3pXCZjT7c+AQtj1kojBvHT+c6AqTNuI1DgscXBoJJZ6edY+frZHu9PbfVXKNU8+vj8cA1D46T99NhIvh//ZgRzJODaX7n3Z20Xk2RsEFgnmfwgrMiGOz/KqYYn3DsyO9LZ2aBc0lww3peF4RrGv1g/q11CpL++cMSAx3WzpncCgSxI72CPE5r7QGc4+1p7FGbbYRgStyuaM0AeEhYww/cTLA5IRhcjDhYe8HI5Uy+ieDc4XGF+BLfyNohzvOy50oLYzdiASnr2Ee/Y9PrXyKEWT3NnndkJXblZkodgdRR4pZbe2AdecpIIJGZEdy2ISz5O0JFFKsoFCkT5S4j2VYoRERoPxQJbrkspV4FPX0+XqdRWkhMXillltW3pW2DQ8D2uKDpsByDxhnwlLkLVoKOGocImpr3K1v7LN5cD1L04UkAowbKY9I4vMJ8aCmRGLBCflJirkMgfRMVW/yeAuePVS/g2zhcT1heG/0+IXwSWBmrwHezIfzuE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(53546011)(47076005)(44832011)(83380400001)(81166007)(31696002)(86362001)(36860700001)(36756003)(5660300002)(82740400003)(356005)(2616005)(26005)(107886003)(16526019)(40480700001)(426003)(336012)(2906002)(31686004)(41300700001)(8676002)(8936002)(4326008)(70586007)(70206006)(16576012)(110136005)(54906003)(4744005)(316002)(478600001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:20:35.8320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2013c9d0-495a-4c00-3c75-08dbb8526d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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



On 9/4/23 05:15, Venkatesh Yadav Abbarapu wrote:
> When USB device driver CONFIG_USB and CONFIG_CMD_USB are disabled,
> some compilation issues are seen. Also CMD_THOR_DOWNLOAD should
> depend on USB_GADGET_DOWNLOAD. Add dependencies to resolve those
> issues and compile properly. Also remove unused config CONFIG_ZYNQMP_USB.
> 
> Changes in v2:
> - Added the dependency on USB_GADGET_DOWNLOAD for CMD_THOR_DOWNLOAD.
> 
> Venkatesh Yadav Abbarapu (2):
>    cmd: thordown: Add proper dependency for CMD_THOR_DOWNLOAD
>    zynqmp: config: Add proper dependencies for USB
> 
>   arch/arm/mach-zynqmp/Kconfig         | 3 ---
>   cmd/Kconfig                          | 2 ++
>   configs/xilinx_zynqmp_virt_defconfig | 1 -
>   include/configs/xilinx_zynqmp.h      | 4 ++--
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 

Applied.
M
