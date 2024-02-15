Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C0C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1592287DEC;
	Thu, 15 Feb 2024 15:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PqTgEyfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE4486D38; Thu, 15 Feb 2024 15:32:09 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FF687DEC
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH8AgBqPLh7zSXDUn/tcqOgHFTZegUUlUdb6+MW1c0NBxFjc7k9Mnfqc5UeOqxtPzTOirwvWU8eibhjUhWtLfoTQ0L1MxmoTzyuddivXUjGFCUb5WGOG+FDuHHXG9Vx3uWouZDFeZLL8/LQi9ykAUddzu/qlCi//rSIWnTKr5svV0t4VNBtMGrfz+cykd9GbiwXnC+o5SBTWhaKH/RNTdG3uPcxzgPwCPRLFgTMDmDEL+IIjsJNB3+4HorLd5rws2bv609185c5tL64sNwMl0Re47ulXIJpK76v82toLyD1HllZi2hdw1R2oWrY4zKezYupF8JtxToN9dbfbyRz3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjd2tyetUd5LDY+wr4YbQ6ONPcEZQ+SLqgC3pgYh2BA=;
 b=DeImG5Rqo0qpIe+XNtWcTs7jwP2KO3k1mEnMoc1Ynv40P8UyL706nxnioyabCveyN3K9I2ojNYvRSLyZB0H7gC5vkrE1qpKtNxTmL87ZhOHsXUJ1nNv88oBiwTUVS6LOx5rSqkjFQMjd4eiv8ausgiJW5Paso/Mm5r+ivqU0TJnANE8k5ThOUhLLiGr+bnuNauWC7eDF4fBP7FdhLwRIxqO7QiX9N+cw6bH+YItgQ4lOuDTb8wl5Hd9qKtxHFt6gczVZpDh3Vk2WWvYqXGlNHTU8RD2m51RJQqLv5YO8GEO0PPJd5ayyHfkhEqBfiACf4r0GfBiFMzAoaDRoxbKS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjd2tyetUd5LDY+wr4YbQ6ONPcEZQ+SLqgC3pgYh2BA=;
 b=PqTgEyfuTcMfag5FpgnYRplHg6H5/tr9gjRZkoKVjKn+GMNiWc3Z8YtokR0g2UeRGfGsi+EqNGXpu3oo+xoQkLGkkiAyKjxkZCoiKFqE6ks6aZQa2xt5EQGEtjvgTV/ufeZNvR5IxKQZJqZvaxtfZy725+VzZ2Mfqzl/movfN/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 14:31:48 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 14:31:48 +0000
Message-ID: <877195ff-1c10-4e98-b042-cdc47cbaa293@amd.com>
Date: Thu, 15 Feb 2024 15:31:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/21] tools: mkfwumdata: add logic to append vendor
 data to the FWU metadata
Content-Language: en-US
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Jassi Brar <jaswinder.singh@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
 <20240212074712.3657076-19-sughosh.ganu@linaro.org>
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
In-Reply-To: <20240212074712.3657076-19-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 562b7a2b-96c0-4777-b196-08dc2e32d789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33NB8/0E4ceqPBfwNk5FCUzmot+McaA5p4F74zfoyFUjqHNXz1vmdjGpYqcLLf53SrsNzLeUeUyesYauNnqEvzdPZrHvKhcCtH7VBWxOjBx/GzmJFthLi5ShOmMdM3FdDopCQm3sCqewvq8zOspFnC0lL/FyqXVW7rjYFPmD6q+y94t4UgnUk5Uq/tnWLIYcLaO3IrEo3a9YOP8TRLBqbLwEngr2hKeAr4hDroTbXxwsZ2WuZ1+8LA1OrL9v4gFhQ/L5D0a5fnwKEECtoc5Ok+/oeRpgC+mH33Dd9+EkQOUjsLxeGEsD7C3vhcSRHHlmgWx9rDTjio8eTHRM1RxzSMyQkM22S8xfk5eVNFgd7Nm15FXzOCr/Mo/deiUGLRi1hmffJY5t0xvTVgGOTSYS6inNd+X4O5z1Ov/y0SdBaUGPGDFrk0YpHGFPBlFnqZf6vswbty44dxath8hZiutBoyHK5+0Fd0Yu/YZPZI91WFk0N8VgKO4hneC/NZ0vvYy6Ue1Wegjh64mNOE8N/5UHteddnvR5t21oNr2T0WINbxst2bapcfBqRI43GcOZc+FE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(31686004)(6512007)(6666004)(478600001)(41300700001)(8936002)(44832011)(2906002)(8676002)(7416002)(4326008)(5660300002)(6506007)(53546011)(54906003)(66946007)(66556008)(66476007)(316002)(2616005)(83380400001)(31696002)(38100700002)(86362001)(26005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVYyRDhXNzJ3STVGZk1vREloQTBOUzdhTG9iblJiQjdoK0pod3d5cDR0WkVo?=
 =?utf-8?B?RWx5WGRDZjduUzVIajM0V1Z2b20xbUVDVGtmMENFK0lxZWVrWk1TaVRaRGZv?=
 =?utf-8?B?K0k0UDU2c3dzNGI4dlJnMCtGM3RlRU5VZHZLcUpiZTVTbXNuNzllRzJlcmZ0?=
 =?utf-8?B?NVI2bWtJeWdoWWlvbDQ2dTJxTmxCVVBhSy9IUUlpQ3lwM3ZXU1F1clNwVGlM?=
 =?utf-8?B?YlJENG9BZjRKRTd2R3ZRcHVza0xmYnMwZjllWUJPMUdkcHBscG1OVXpjeXNp?=
 =?utf-8?B?ZW5VZ3pvS2dQTGlVZ1RzOU1STDNyNGNpbHo5alg2dzlQazNNeEU1dWRmVFkw?=
 =?utf-8?B?NEZzYXhGdVc3Vnp1V0ZYU240TERhZ2xkMGlDSThwaGwzZFlYaXpvNGFNWVps?=
 =?utf-8?B?UG8zcHRQd2pzZG1NWEYzMDdLRGRvSkdXRU9nMzY0KzQxRmttL0gyMk5wckth?=
 =?utf-8?B?Uk1KREcva2xISldkK2cweHVyV1VpNHdjSGhjOUFVRlpEekpqYkVrZEJyQklT?=
 =?utf-8?B?ZllyTzFkTy81aGM3cTkxa25TSXErZUtUZjJEZy83L2Z3SS9uYWcrcmVtTytR?=
 =?utf-8?B?U05Qakx6NEpIeGJPTmFsdnVVWTJGSXlwbCt2c1BsdU4yWHZNTVY4cm1FTXda?=
 =?utf-8?B?UzFWeHhjSHZPUVJVakRtMEMrTlpyOFhpTkFkMm1MK05zYlJ4RDFlOTd0TXp3?=
 =?utf-8?B?V1NkVHZrbERaaGNFR29EbkM4THBNSVlxRVJtTkN5WWhWcHQrNnVwMkRpcTJo?=
 =?utf-8?B?bUR3VEh0ajJOMmh4aWFFUUl3RUFjd3FkZy9uWXJqYk9FeGUzWm5GQmZQUGhm?=
 =?utf-8?B?Q0E0ejc3YWNJdFhxaE9yaCtFUC9FODRGK2l2TXZzRzh0V1dOSTVmMUNnVi8z?=
 =?utf-8?B?dVJjTWV1WGl5U1ZVdHk0Uk9zTmEzK3o1Smd3OEplelJLUGRIWHliS3hwY3A5?=
 =?utf-8?B?amVuSTArK0d1WktnQzFmMVkxd3Y3Nkk3aGVkS3pFVEVIZHpVR1dyblBzRzlh?=
 =?utf-8?B?OTMrdGdNbngxaUVtUmpBVU1xUkxCektmV3dGMmJOOXZacEZlaEVoV1JON2hv?=
 =?utf-8?B?MDBPV3U5enZzUXlFdGY5VzZnQ0tsQ0E1UzB5Y0NNNDFySFhaeDBhWDduZzRD?=
 =?utf-8?B?dzI1Y2lJTDZDbkxseDJrVVdmZi9MOGxIbDF6dGl1SDZGK3VHMHdxbzlaY3Y0?=
 =?utf-8?B?S2tkdWpEWFA2L2t2YUpQN2szampMeGpqMmVoQ2FGdzQrWEFUQXRtWFhseXBm?=
 =?utf-8?B?M0hyYUlxaWtUejFxUjVGUkhKQVlvM0xweGQ1Q1d5RWpaSTZxTDdrQXo3dDU1?=
 =?utf-8?B?QmgxNnRETUZrWkJjZXNSSFJGdGpxcENzT0Rmb2lFU0pKU0VVUkdHbitPdGV5?=
 =?utf-8?B?ajNBOU5Cc3pwbjlZMDBWVnhVVlpaZnJzRExKc1lFNW5CVVNqak1ORE1hU0Jt?=
 =?utf-8?B?SjV2T3J1MWh5NnV1Y3dRMU1Kcm01MFl0em50WWpsUDFtWFVPODY5Y1VhVGVz?=
 =?utf-8?B?T3NrQ3lCa00zYktTeDBpd1lpNWVEV3FLQnpSejZ1dElzSmpaVWJtNHFTK09l?=
 =?utf-8?B?bWg5c2pCZnRZdFV2M2hHUm5weXVZUkdDSHJDWXdOZG1BUW51VXhtSkd1YmVK?=
 =?utf-8?B?VFhsN2JhT0JnN1Z3S0lEek45L1A2YWxYWWQ5S1JUN1lia21rbzE4VEhmMCtv?=
 =?utf-8?B?MUErblZSUXI3RzRkMDc4UlhRbTc2enpjTVNZdU5pSnRZVjg3QXlReWlCeEti?=
 =?utf-8?B?SnZVZEUwYXpNQW91dG5XaEJ1bGhPemlzdW1RSzhZbXIxN3pZays3Rzl1M1hE?=
 =?utf-8?B?SGlMWnIvQW5CbzlwVUc0UEg5Zy9Bckx6RlMza3FaRHkyL1JKdDByb3RRR2RH?=
 =?utf-8?B?MDIveWxOcmlOY1BVVFJjcHd4UHNEQVplRUhwUlVoY0RjT3V4SzJXdklxTGRW?=
 =?utf-8?B?Q0s2U1VYV0xYWjZVK1hzL2p6ODJ3TWVCM1BtSEdpNitKNFJPazhlOTQybnpm?=
 =?utf-8?B?Rm8xTmFrWmw4amY5Rm9PVWg1Q2p0UkN6b09OWlVRT1gwZlV3Qkx3UXJTcVhU?=
 =?utf-8?B?MVc5T2o0MU0wbjdoWlFJT3JoZjRjTUhaRVNib2Q3N3ZreUN0NGlnVUZEbEV1?=
 =?utf-8?Q?0IqVYYA7aozPs8NvpYz8QWl/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562b7a2b-96c0-4777-b196-08dc2e32d789
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:31:48.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFQVeL7fehemJ66SzF353NV+0t5jurvd1Mt/jokz/4T1qIyCj/V6vHsqovcxvrHz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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



On 2/12/24 08:47, Sughosh Ganu wrote:
> The version 2 of the FWU metadata allows for appending opaque vendor
> specific data to the metadata structure. Add support for appending
> this data to the metadata. The vendor specific data needs to be
> provided through a file, passed through a command-line parameter.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> 
> Changes since V1: New patch
> 
>   tools/mkfwumdata.c | 85 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> index fb847e3a78..ab07623e25 100644
> --- a/tools/mkfwumdata.c
> +++ b/tools/mkfwumdata.c
> @@ -12,6 +12,8 @@
>   #include <string.h>
>   #include <u-boot/crc.h>
>   #include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
>   #include <uuid/uuid.h>
>   
>   /* Since we can not include fwu.h, redefine version here. */
> @@ -30,7 +32,7 @@ typedef uint64_t u64;
>   
>   #include <fwu_mdata.h>
>   
> -static const char *opts_short = "b:i:a:p:gh";
> +static const char *opts_short = "b:i:a:p:v:gh";
>   
>   static struct option options[] = {
>   	{"banks", required_argument, NULL, 'b'},
> @@ -38,6 +40,7 @@ static struct option options[] = {
>   	{"guid", required_argument, NULL, 'g'},
>   	{"active-bank", required_argument, NULL, 'a'},
>   	{"previous-bank", required_argument, NULL, 'p'},
> +	{"vendor-file", required_argument, NULL, 'v'},
>   	{"help", no_argument, NULL, 'h'},
>   	{NULL, 0, NULL, 0},
>   };
> @@ -51,6 +54,7 @@ static void print_usage(void)
>   		"\t-a, --active-bank  <num>    Active bank (default=0)\n"
>   		"\t-p, --previous-bank  <num>  Previous active bank (default=active_bank - 1)\n"
>   		"\t-g, --guid                  Use GUID instead of UUID\n"
> +		"\t-v, --vendor-file           Vendor data file to append to the metadata\n"
>   		"\t-h, --help                  print a help message\n"
>   		);
>   	fprintf(stderr, "  UUIDs list syntax:\n"
> @@ -69,13 +73,16 @@ struct fwu_mdata_object {
>   	size_t images;
>   	size_t banks;
>   	size_t size;
> +	size_t vsize;
> +	void *vbuf;
>   	struct fwu_mdata *mdata;
>   };
>   
>   static int previous_bank, active_bank;
>   static bool __use_guid;
>   
> -static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
> +static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
> +						size_t vendor_size)
>   {
>   	struct fwu_mdata_object *mobj;
>   
> @@ -87,16 +94,28 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
>   		sizeof(struct fwu_fw_store_desc) +
>   		(sizeof(struct fwu_image_entry) +
>   		 sizeof(struct fwu_image_bank_info) * banks) * images;
> +
> +	mobj->size += vendor_size;
> +	mobj->vsize = vendor_size;
>   	mobj->images = images;
>   	mobj->banks = banks;
>   
>   	mobj->mdata = calloc(1, mobj->size);
> -	if (!mobj->mdata) {
> -		free(mobj);
> -		return NULL;
> +	if (!mobj->mdata)
> +		goto alloc_err;
> +
> +	if (vendor_size) {
> +		mobj->vbuf = calloc(1, mobj->vsize);
> +		if (!mobj->vbuf)
> +			goto alloc_err;
>   	}
>   
>   	return mobj;
> +
> +alloc_err:
> +	free(mobj->mdata);
> +	free(mobj);
> +	return NULL;
>   }
>   
>   static struct fwu_image_entry *
> @@ -223,6 +242,7 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
>   {
>   	struct fwu_mdata *mdata = mobj->mdata;
>   	struct fwu_fw_store_desc *fw_desc;
> +	char *vdata;
>   	int i, ret;
>   
>   	mdata->version = FWU_MDATA_VERSION;
> @@ -249,23 +269,65 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
>   			return ret;
>   	}
>   
> +	if (mobj->vsize) {
> +		vdata = (char *)mobj->mdata + (mobj->size - mobj->vsize);
> +		memcpy(vdata, mobj->vbuf, mobj->vsize);
> +	}
> +
>   	mdata->crc32 = crc32(0, (const unsigned char *)&mdata->version,
>   			     mobj->size - sizeof(uint32_t));
>   
>   	return 0;
>   }
>   
> +static int fwu_read_vendor_data(struct fwu_mdata_object *mobj,
> +				const char *vendor_file)
> +{
> +	int ret = 0;
> +	FILE *vfile = NULL;
> +
> +	vfile = fopen(vendor_file, "r");
> +	if (!vfile) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	if (fread(mobj->vbuf, 1, mobj->vsize, vfile) != mobj->vsize)
> +		ret = -1;
> +
> +out:
> +	fclose(vfile);
> +	return ret;
> +}
> +
>   static int
> -fwu_make_mdata(size_t images, size_t banks, char *uuids[], char *output)
> +fwu_make_mdata(size_t images, size_t banks, const char *vendor_file,
> +	       char *uuids[], char *output)
>   {
>   	struct fwu_mdata_object *mobj;
>   	FILE *file;
> +	struct stat sbuf;
> +	size_t vendor_size = 0;
>   	int ret;
>   
> -	mobj = fwu_alloc_mdata(images, banks);
> +	if (vendor_file) {
> +		ret = stat(vendor_file, &sbuf);
> +		if (ret)
> +			return -errno;
> +
> +		vendor_size = sbuf.st_size;
> +	}
> +
> +	mobj = fwu_alloc_mdata(images, banks, vendor_size);
>   	if (!mobj)
>   		return -ENOMEM;
>   
> +	if (vendor_file) {
> +		ret = fwu_read_vendor_data(mobj, vendor_file);
> +		if (ret)
> +			goto done_make;
> +	}
> +
>   	ret = fwu_parse_fill_uuids(mobj, uuids);
>   	if (ret < 0)
>   		goto done_make;
> @@ -286,6 +348,7 @@ fwu_make_mdata(size_t images, size_t banks, char *uuids[], char *output)
>   
>   done_make:
>   	free(mobj->mdata);
> +	free(mobj->vbuf);
>   	free(mobj);
>   
>   	return ret;
> @@ -295,11 +358,13 @@ int main(int argc, char *argv[])
>   {
>   	unsigned long banks = 0, images = 0;
>   	int c, ret;
> +	const char *vendor_file;
>   
>   	/* Explicitly initialize defaults */
>   	active_bank = 0;
>   	__use_guid = false;
>   	previous_bank = INT_MAX;
> +	vendor_file = NULL;
>   
>   	do {
>   		c = getopt_long(argc, argv, opts_short, options, NULL);
> @@ -322,6 +387,9 @@ int main(int argc, char *argv[])
>   		case 'a':
>   			active_bank = strtoul(optarg, NULL, 0);
>   			break;
> +		case 'v':
> +			vendor_file = optarg;
> +			break;
>   		}
>   	} while (c != -1);
>   
> @@ -348,7 +416,8 @@ int main(int argc, char *argv[])
>   		previous_bank = active_bank > 0 ? active_bank - 1 : banks - 1;
>   	}
>   
> -	ret = fwu_make_mdata(images, banks, argv + optind, argv[argc - 1]);
> +	ret = fwu_make_mdata(images, banks, vendor_file, argv + optind,
> +			     argv[argc - 1]);
>   	if (ret < 0)
>   		fprintf(stderr, "Error: Failed to parse and write image: %s\n",
>   			strerror(-ret));

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
