Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E31E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 07:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A748941E;
	Wed,  4 Dec 2024 08:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZeENILS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7016E89543; Wed,  4 Dec 2024 08:08:17 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38701894DF
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 08:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS0zh6a58k77KFd3sne0UnsLsYcoVZb8jQSb9jH7uPW2UVdkkB/GRSfEfNrCKWaNshUsCnUszkoazhoEQtxovwBtSX+sULMxXjxjaP07umQEmv5Z1O21Pyqk9yhnaQuTSMtMIbiz4JbECirtiFldP+UR0jxvgZd8EO91ZXwasuci4EoSyZThTiIrQUB93auAqbYRomZAAyj8i9Di8O+Ltc2XF0s/qK+m4ZE8YZos/1S0FIOR3ozN1SI2SzBJq7I9drGWL70q1BLBmo1xmeT6ycQvBa43484NC69+UZlCGquSw4BQAvvsqz86d053GdXwF66pjHJ7UtMwyMDIPCv+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB2bx5Gb6rayRf8FhABxB3Ts226S/fht+hK//DBA8fY=;
 b=sGwJmNYNMZOGxd0Ih+PkipEev0d8rTAhQTr7hXcElcX69qgKF6JMCYgFr8RPwOr5BOaZ/sFEGFCzdBeiYzOceWgeihAlXk5bRWm/fnCgXhJsp/Hr+e0c8hFC96zXEuAYiDDx7E3Wlpgut4vLIgyekYtFlhIJo9CvSaK4kdHnrM8zWs9mmVN+h4sgeGK6VIQ8A8FuoPOs19SrIYDrw620/rw6P/Es9EBxU82nVtszX5GYw9rBmDVEm3eWicaBy3+6DHQnWNIZVAn/EB/C1zCQUO8cxhyNR51LVdhAzLCwxfQbck3LNz7At1iJ0e+R7MnUKHm2hJdOL7mcQhbK8crNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB2bx5Gb6rayRf8FhABxB3Ts226S/fht+hK//DBA8fY=;
 b=xZeENILSDWpFBSbemz82Hzd6BhXsWVluSPD9a80UlLCjby5q9kzcnKs446jhf8rgoXzo6D3EPGHiqeZuug6RgP/j+QgL5x21zFu1/z7GWL8/Ke5px0I7COx2kuejW1nds3cISFBk6yRmcO1Oq6/vTLIDniMMXVNHIzIXYyqky8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 07:08:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:08:10 +0000
Message-ID: <9a9dac7c-b57f-4ad8-a220-0347c95bb9f0@amd.com>
Date: Wed, 4 Dec 2024 08:08:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Update the bind function based on
 peer-hub property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: marex@denx.de, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241204043908.186431-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
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
In-Reply-To: <20241204043908.186431-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 9370c179-3f11-482b-8438-08dd14326919
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkFhcTNNQ2JwYmVQUDk2bTB2b3NTQ29hRkhCcDQxdDZyRG9oUmQvem1lY2Fa?=
 =?utf-8?B?b2pWNUNrSzN1SHo0YTlodFZ6K0xnbTlVM01DY2NVZUt0UzJ4bkhMRjFtdlh5?=
 =?utf-8?B?NXkvaG5xMURYaDIrQnVRY1ZUMk51bXhJdTRjNm1Rc1R2NHU3OERDZTZBWEVH?=
 =?utf-8?B?STNUUktYaWhZc1BLRlFpQ0g2N1YvQVZ1amVZS3pGRHhMQ2k3ck4zWWZ6d1Ra?=
 =?utf-8?B?elhlSkFnQ3E2YnZEOUs2emFianAzU2FaNUwreUtleUN6NTdSbnJHT0xGZitQ?=
 =?utf-8?B?STRoRzVkTEtXYlFWcVFCaFFaUjUrRGZoMGxZTjJqVS82bnRiUDJUZWFhWDlF?=
 =?utf-8?B?Umpwdi84aFR3ektNazI5WlZwbDE5aWRLTXd0bGZ4VFVOUFFyQmtSVzJKRk8y?=
 =?utf-8?B?eXhNYkxyMzlxZ3g3UTRFREtrMTJCc2taaXRRSjAxdTZrelByUTVzbHlCWmZW?=
 =?utf-8?B?Nm9ZbXl6RURNekpFQk1uOXVia0hGcG43WFJVRlorWjlabFZ3amVwYWt2MEg1?=
 =?utf-8?B?RmpOSmpMaktRY1dNcTNzUTkzYmJhMDMweVRGUXc3clo2WWtwQjV1YlpVN0dl?=
 =?utf-8?B?RmlFS3NrSnFjUWJvYldRNVZWVkJ3TWtDbVdkVWg3bk8wMnhvR21qd2hRWnl6?=
 =?utf-8?B?M1ZEZzhUWEFHb0dMWkhKRFVmbTAvcVBZNUp1aC95R3k3ZWdWM2szRTFOV1M1?=
 =?utf-8?B?SVo3RDI4QWRyY3QwVTNET3M1bFF5RnhaaGsvSStmUFpZcGszYnEvZXFvc1lV?=
 =?utf-8?B?cmtFamI4aGkwNHdBNXFld28yY2M0bnF3a0lwUVJRRHNUMFdGc0xhT3UyWFhp?=
 =?utf-8?B?RnRXa0hLNDhjdElHQy8zZGV3SktWdDMzWXJJL1hkNkR0S0xjOFpqV2VHNkpV?=
 =?utf-8?B?R2ZOTS9ZMTlXVTRhYU1JNUU4NDlvcitucGFLUFF1cFdPQ2lwMFNMQ3htWnlU?=
 =?utf-8?B?OE15Zkt5emN5SUluZGlBRWpjQ2h2eE9XelV0V1ErY0ZMVEZTUElmR21tS0d1?=
 =?utf-8?B?bW1FUHlQUlVsUzZhWmZEeVZHMlhyQWJnbkNNR2N6Q0lTYS9jQlV4NDJ3YWxw?=
 =?utf-8?B?cmpxQ2dwQ1BpNzlkcHkvbjAyQkNZZ3d3dVhQMUZ2dE9jNmtuWC9EYWx5TTNN?=
 =?utf-8?B?VEFYaUZKbXdHenA5dFMxeFlJYzVtRWN4U3hLUzl4dURQbGxRdnVFY1M4b3Bx?=
 =?utf-8?B?bVpiTDdiRGx1cGlpNmRJb1FHY0tuT0M5Mk5LUmNieTg2Y3B1RzlBL2MwMWVx?=
 =?utf-8?B?cGZvdjFKaUtkeHpLbzMrV2tiS2RjUGRvMnlXZ0QwUklLQjZkVzhNVVhoWlpq?=
 =?utf-8?B?OXJ6dGNuVHdXOTh1Y09kWGZXdVVsZFdOeElzMFNnUFY1MjNxTDhhb2VSdy9B?=
 =?utf-8?B?SXhIRlFzUitDaTdqZXg4VjJiNUd0SVhTd2ZGY3pQUitJcys0Zm8rejBZZmJo?=
 =?utf-8?B?cjlXTDEvajJJV1czM0JhUUg2eU1YRjc3ODdIYlpKRGRRVkNNVkxVK1Q2dStS?=
 =?utf-8?B?Q2V4bnVNZkdIc2JPVG5saUcvNzNvUnZmRzFVeTdvMHRtMWZCeTAxWXBoSTRx?=
 =?utf-8?B?MFRtQXJ5VEVsZ3psYXEwYmdBYzZTZVJJWFFiV3hXU085bnphMkViVGxqMytu?=
 =?utf-8?B?eHVTd3ZGb24vL21lZ2VnbmNwbEFoUzNCeExKcGFVbW42V2FXR2FYVzZSeUpx?=
 =?utf-8?B?Y2FFUnFwandCNmJhQ0xyMnlvWWlnREhmRFdqSUxWY25JSmN0WmtEejluMFhC?=
 =?utf-8?B?Zkczd2cyck9PRURENXovUEFac1ljZ1FDNW5rUS9pRzFncWQvZHBXTnpxWDlj?=
 =?utf-8?B?a3RoM0pJVEUzRFdoaG5YQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhYdjNjSXppWkErNEFNeURzQm5MbjBVUUFZSGZZNDFDa1NHaUpmYWRyVnJt?=
 =?utf-8?B?Y21sbjZhMFVLMzRpVnEyRmZXREFjYWx1Z0dXbXM0ejQrZG5GakFMblByMnl2?=
 =?utf-8?B?bnRxTU1rRW9ydVJCMlMyaWlMNjNBUnVnSVFPZkF5cVlCdEJlR1o5RHdvOVl5?=
 =?utf-8?B?aXRBaW9JaHJDM0pEbG4yNzQwQTlYQWduTXg2bmN3NWhmWWI4YXJVME9nMHB5?=
 =?utf-8?B?d1VZVUZTcGtRSk1XSmFaVE1WOVdLa2Z3UDZ1eHY3MnBkYTFnTitKdjhLMDgy?=
 =?utf-8?B?R1RXYUUvV09TTkxVZGRrK1V4NG9kNEduSStaMXFHYlFiZ25DcEtoaGY4OXBr?=
 =?utf-8?B?OTdBZ0t2a0RYV1BTSitLVkNoNVowVXhmeUVjRWlYSVE4RS96N2ZHSkE4ZE9q?=
 =?utf-8?B?WmNIVkZZaXZQUVJXU3BFQ2p5ZTJVcUw2bUx3SU1yMXpzdE1Uc3AxMlNNWGFU?=
 =?utf-8?B?a1RxYzFBVEhLZjA0anVrVFIzUjZPZzdwb1VIU0pEYSswRDhGWHdwVWl0eGh6?=
 =?utf-8?B?M0JNTWlYQ0NhSTMrMzE0aGhqT2xmNTNjVkdJY2xsbTl4MVZGZ2lRaHd1VVQz?=
 =?utf-8?B?bFp6L1FBbVozbDlzWnZBM3JvUE5Dclc0M1RwMEUveUpSUW5CUjArUVNhSTVN?=
 =?utf-8?B?a0VJQ0x5Q0tLNWZPQnIva2l5M0d5eE1DSTUvNGd0T2pYcXJaOFpUU0hpYnM0?=
 =?utf-8?B?ZTA0WmVIazBvVHYrMCsvTy9EaDhsODUxU1NHeTRyMG9IYVdsZndqZzFQenVV?=
 =?utf-8?B?anJ6VnZHcC93K1I1QjhXQ3pySElqQkdQZkVRK2RERzEzVWhpN01teksxSWNr?=
 =?utf-8?B?b2VCWlhYRmZ0a0l4cU14Um8yY256VW1EbktISGhKeHo3K2ZSU2Nvd2tHQW9r?=
 =?utf-8?B?SjFQbzVNUXhweHphR201SDliR1Zob0dCV1BhVFoxMlZUV0N3WEphbFBoUk84?=
 =?utf-8?B?cGhyNVVEUDdTcUNRdEpZc2ZsK1FaUStIN3REcHR3THRJKzA1V0RlT2RsMmJS?=
 =?utf-8?B?MlZwRnR5Vkp4aWxUaVArRWMwSVBGUSszLzhxUkp0TW5aLzJJWTFIOXM4QlVO?=
 =?utf-8?B?Mk9BRkZiY25HZDVhdGFhWkx4SjNKd21GQmp4NWVUb2R4dktaemxYZDZ3OFk4?=
 =?utf-8?B?ZjA3cVhCUFZneEZpaFp3MGtpRnhOQmZ6b3l1V1VVR1gvMlFkZUtYMUtMZEhM?=
 =?utf-8?B?cExqYnlNWko5UDRPeXZtYU5Fdnh5R0FWSEczd0V5Q2ZtV2hZM2lhamJBamY4?=
 =?utf-8?B?ZzRyWVVrOEw5RG9Db2lMWWgreUtFS1A0VHFOcWU0MFdMdFM1c0JHbmJsREVr?=
 =?utf-8?B?ZUpzY2loOWV5TTNacGJYc3BpWThJb25yNnhsSE1OTnUvaVVzTk1BVGhkSkg5?=
 =?utf-8?B?TlhIRkZKUmpueVBhVGhlaGZEelJ4Y1dmL0g0bk5XR29ScXAweS9qTG51cU9J?=
 =?utf-8?B?bVJHcUpUcTU3K1lSTmhnM296MXV5dDVqU2tHL0dLQ2QzUWxyZGIwUXlCa091?=
 =?utf-8?B?a0RMTWdnLzhSNlZobXdLL1FGOXQrSXhaUlROcytneEZyeG92Nkd0eVpDMVE3?=
 =?utf-8?B?SWhlSnB3MFFTajRLNlZ0dDhpUEZtcXd6L0RoMnRieURXejhXTmZNK3RXRERF?=
 =?utf-8?B?ZGRGdHdxalhwbzBCNy9iUWRzcWFsNkJveVQ0UUdrNGNkRDJKQ3dYaE56NENC?=
 =?utf-8?B?NlM3TzhPdDRqcnRaOUhmUE43UGF0U2M0bW96dDJJUUwxUGFqWStoRnNDOVNB?=
 =?utf-8?B?KzZXekZSMktzNktMeHZBSTFGd2ZYdi95SnA4RDBGcGFXaEF0VHdhdys5MEQ3?=
 =?utf-8?B?VEU3YnlyM0RoeTRTcmxOMStpYXVETng3eEhkaC9Md3gxR0Z6OUYvdFIxb042?=
 =?utf-8?B?MGhxSVF3NGFGdERpRzJVNVRQZk5Xek1oMlZXMXlmSWFFRDNNdEZjNnVCdVls?=
 =?utf-8?B?ZHRLMUgvRVRUK0hFcFVJdDQxN1VxZTBFbUlUMncvVU5oSTkxZlFqRWUrRUFr?=
 =?utf-8?B?ZUNXVnJHS0gyNFI5Rk4wanBaV0JHeTZKT2EwRmZrTnR6V3F5ZUxIeUlQNVRk?=
 =?utf-8?B?eHN5YWdrNGQxOHFFVHp3S2RUS0lWRjRibjlhY2Nqbm5VdThzcFRSVnhibHpU?=
 =?utf-8?Q?Jxn6VMCmPw52jBfNP+T8CtH3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9370c179-3f11-482b-8438-08dd14326919
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:08:10.3004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJXyIMkWK7u+E+6Omg8mMQczyUDTQxOpu0FyMb4jHD2K3CqB7cvHOF6XL+xnvWuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

+Patrice

On 12/4/24 05:39, Venkatesh Yadav Abbarapu wrote:
> As the "peer-hub" property is optional, don't error out just
> skip the bind function.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the peer_hub variable and used the return value.
> ---
>   common/usb_onboard_hub.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..be83f168e1 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -183,7 +183,11 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>   	int ret, off;
>   
>   	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
> -	if (ret)  {
> +

no need for this newline.

> +	if (ret == -ENOENT) {
> +		dev_dbg(dev, "peer-hub property not present\n");
> +		return 0;
> +	} else 

This else is not needed. Write it like this.

if (ret == -ENOENT) {
	...
	return 0
}

if (ret) {
	...
	return ret;

}

if (ret) {
>   		dev_err(dev, "peer-hub not specified\n");
>   		return ret;
>   	}

Patrice: Can you please try this patch to see if fixes your problem?

Thanks,
Michal

