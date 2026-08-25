Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AC2C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BE6D80CA7;
	Tue, 25 Aug 2026 14:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oU7YKwlsE2CH; Tue, 25 Aug 2026 14:33:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787668405;
	bh=ciUOBlQevciRY7Y+8pKi+2b/Z+IJHFjwBIbAtm2zSrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXPj7OsGoL51sR2LPV0suP6js8ErsrJs332XHwQDE4xYAfFAuXAKYjSYKh9P5b3ax
	 orOve05tbHUN5sc2/la/cBD98Vjkb+623N3rcRJZL7ht2T8AHPb8NXCLgd4X8ehZ6c
	 fD1B2cTJ8H9qCc+twdFeuPjejK7VwS4VQt0X0i28CcSFFSSIGJ6YOK5FOikz2TEsE3
	 hLP+s3gyyB3lB2bpoJhPXTspLTJEr6xHJBYnezVo2w2N+IJLqLD2tFw+LboKXqgmL5
	 cktymCQwObx2UVwVYIbJUxBL1XsxuqWaCuQrSLQRaQwy2NtsYpv2vt6yXC2DuOsNkM
	 opPmZoZucul0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A95880C94;
	Tue, 25 Aug 2026 14:33:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D332B1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9A1F400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgglUuNJSdkV for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:33:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=m0NhqXR6
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C87E40092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHA4ADTNqtTrqkV7oLFsHxXlOg1I0iBtJYM1zB9JLIfMRLBGQCMsMFznXhTe1B3raotdkLpEeCQ0azfEftye3Cy9ObvLhYrudM8k1UHzeq6qoFVtvU/oitHgRUU91knmbsxQRvN2w5u7Kwl9s/+pi6dauEgX8hX4KXNZFMCsFFkMZ0MKAO9UIY400gH9FCvdmxRY9SWNvRPLoSlXHvOJ4NdUa1Rq9qDvu+tnYDcl/kAueVYsYIQsjqho2+Yg3StoeMipdQonXCB6Fh19rqFdttTmmZ/OyiG5SvX4hWKUv3ofkX/5nGQ5IN06Rt8foa4mjtwsxIZ4v2Rx6pHhx6glcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciUOBlQevciRY7Y+8pKi+2b/Z+IJHFjwBIbAtm2zSrI=;
 b=ihr4Ksy+Se30TKRO+Wbk1Yw1m39KtmvQEcZPO7pHygjekcyFT2gFktZM3eoGZmTqV7+1rMr5niCvJN5RTIiT7obKcVnvXKJD8Bmvsyrthugnl+7lNNMfCiFmBNUglJCy6XCLSlu8xYZJcT0oj2FcUEVsITecVOa8SFhWyevB218J+3UMPSXIr1POFHo5HjGHkuAZiQ5FlO63hoZu+GHjdlAgxuddh4rAM8RkMDYg6Zi/0r0ykX8ILBdsQNhkRzi/nPLmmhvSqa9ya6jIaK1N/rXGAJ8BJvvzNx4VVXPSENWWpXauliONipo7IdCoBJN8kTplfWfURUpg0aQZDMGaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciUOBlQevciRY7Y+8pKi+2b/Z+IJHFjwBIbAtm2zSrI=;
 b=m0NhqXR6uy/Yo0hg4UqAdihOOkzmzrwpew+QjWXRG10/USZZQ3o6I+xT575FSf43WVVx7VdbCpEH94xIKQlXn6Ty4EBXkGZuh0AG4HETmMe050glV0em3d0bhczAuGgrRavW9Vwm9OdY2CWrAIBJsPsVu2EAByhdKyJCoBilWK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:33:10 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:33:10 +0000
Message-ID: <57548c50-e2de-44eb-944e-554438c2cfd0@amd.com>
Date: Tue, 25 Aug 2026 16:33:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
 <20260825142736.GV523975@bill-the-cat>
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
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
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
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260825142736.GV523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 795fb09f-0fe0-4f25-a453-08df02b5c994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o26ODWM/jdeCZEWzxPnG2N+HZ/k4W9NOOpqwYTCviYk5LTC0PmDU1znF4skHW2IGMTmQr9EuT4YyG/kFIXuDZjo53dL2LeglEof57OvRJhdA23muFeJEX9uK4B2sVfojZD0SpzYE6SHPQ0cdVwSn4ywVD3yS2ZV5DYbrj8C8LO6DHsCddlrW3YuTjzurqnaOJ54TpP6czN6MyXIt4R3eKTpVgi2G13e2Ns2PludHCQV4hmxE8T28aH/tRyGJSdGbGdv3DzECtMXtI5XaXrFAWSrppDCXM+0Wg/YCciSUCkUbA97vPcP7rOPPkjxIN8ibcj47f1QQqqitcUMi4tILiHRsD5A+tN09E/Juhq5ta5qHbMiVkgTsqD0t/DMub9v7oRXEFJcdcE0SRM7AzRuOVF9n6JErEUZa0/XUn10EUpzuiP/FDADcjuTaLvdMTvIWSMLbaVXh/ir8OIUDVHAIW2fAbVp1mwG7206GHVgDluIJlJY7RW15FznCHVNjTg4Tg9Ziwr/WrGT3cvNU7HfAX0VFA9haeb/aeo3l7jzAuvlOI+SNPkn2C2Sp6jNQz6SJSd1UPbTEha2RBK6zxhWbNt33rkOlr0kkadky1k9Sb1kdDeHcxi1tntH7iiLejxlnwvs4mC20ZSz7Fx0+OftbpFyGj0S9I5mm+ENHRt17yJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUkwS2E2enR0Nzh4OHVES1ltb0k3RGR2MGJsenRLMTdoQm12U0FERnN2VTA3?=
 =?utf-8?B?V0dza0N6YnVvSllmUVRzakhuS2dXTjdxMWlIUEJFaXhpOGM2bzVxUVVoUlcx?=
 =?utf-8?B?NUlEb3FlVnpwellGdzgzcXRyNGtPOCtCcm5LT3VEZXF5bWFnS0lBdmh5VUpr?=
 =?utf-8?B?clpFV1plcnRwMkhBUjMxUnhKTHYzV2lBbDdITExRTERiQXNjckZjVVA0TkdX?=
 =?utf-8?B?ZStJaTdkNGtKTzdpbDRqNTI5N1poNE1Fak5KaStkcmdtdWl6L3l1SUx6c1RC?=
 =?utf-8?B?Qjk1ZUUxRUZxV3lJT2YrVkd5N2dSWnJmL1ZqZ2ZZMEY3WVphNHVwVU5oZllR?=
 =?utf-8?B?d1FYN2Joc2lDR2ZTNktJOFFIcStuNmE3cnFSZEFHMVliZ1ZOaGJpVEJrMEhv?=
 =?utf-8?B?YU5yV1FRR3YrSzNQUnFZS0J6Y2Mvck5CU1RleUhmb211V24zSklueXVpQ0VC?=
 =?utf-8?B?djJYS3BlamZMSEpiNzZ1Y2JkWUtYN1RrcDhkekhKL1JMNm5EUENJcnJQMzA4?=
 =?utf-8?B?d2U0L2ZQNnZuZVZ4NWdwNThVN0d4cjZIMjgySTAxTk5YbURwTGlXaUFHMURP?=
 =?utf-8?B?OTBBUlJ3YnVnR2xNZGJMUGVWdnhtOHB1TTg2elRpZjdieWxJM2tKSHhqQ01i?=
 =?utf-8?B?eU5wUC9ySGd1a2kvSHd5QXdCV3FxNUVtRDhvRmRsemNLVkpmZFlsa2tLejJL?=
 =?utf-8?B?U2dVNVp3TTV1eTFiTnNvYUg5ekdYWjhzK1JtODU1SEg5T1FaTnZKbjhNQlQz?=
 =?utf-8?B?Zkt5NTZvRlhhT25IQW1yOUorTHZBWWFKMjloUENDMHhJZXZxSnpZcTlIaVVs?=
 =?utf-8?B?Nk9NRTdndUExUit1OStPNDZWaTJvRm5memxLckdUTm5EUFVjYWNPbE82RTR0?=
 =?utf-8?B?WHNPVCtmenBoSGpPUlZCakJvbEtJbzlUZ2w2dE9CVGd1RDNZYWluRWFUQlNj?=
 =?utf-8?B?TmNsUTRvOURqSHFCMkhmM0diNDdrWWlISHUxQ0VHVFlteFQyZUoyTmx6QUtp?=
 =?utf-8?B?ZDdybG9NaCtoOU1XUzYwQ3ZkeE1kdms3aTBQdjFJVHo0QnFMaFpJTXZOKzc2?=
 =?utf-8?B?bHAveUtVeFNVUXdDWHA0SWdMK2I5bDQ5dmNqVWVEeHFXMVg1UGdEK3lSQ0d3?=
 =?utf-8?B?TGt0ZjIrWTJXcHN5eVhmSkNIMk50eXNudWVZajJKT2crTnBIZ3REYTN3UEEy?=
 =?utf-8?B?aUlNV1hEODdhN0pDSzc1VElwNzI0bWRFblZtRGVjVnl4TW5kbGNLNFlxcEsz?=
 =?utf-8?B?YW9MSTBweHJtbU15eDlnVDJKQUQrQk1yaWxLdkxvTkp4dnR3NDBUOVlGdE92?=
 =?utf-8?B?cTRiNDhIb0o4T0RwZlNQVXdtUzJNQ05sV296Y1lLU2xLZmhpV3hNNnB2ckM3?=
 =?utf-8?B?U2dwTDVsTEJGK2NaR3F5NVpmdDlPaFQvbEVSL2VHcVUxV0FnYjVUcDdXZGp6?=
 =?utf-8?B?cklHSkJZc0U2ZHBncEQ3MEN4QnZ3MmZHdFkva3BDa1F2ZlhBOGhreUE1RDVO?=
 =?utf-8?B?S2hUTXRlTVR3THQ3Zk5LNi9BSmpoV2IxbW13NnZSWFc4aHEweG5kcERXOWdl?=
 =?utf-8?B?Z1hzQ1hFVFVrcEozenduNWV0YWUrTUpjUmpldDdEYjREQmtSeWtGQWlRQVpk?=
 =?utf-8?B?ZmFxdmpQb2Fqc1BpWDdvdXB5cVZHZzhrRFdqVUNpWVlHbDM1SHBWbHhkdkxT?=
 =?utf-8?B?dVNwSEg5bkxIRUlzZ2pNU0JYVk1lT3Nlbi94aGd1WTZNazlIZExEczREY3k0?=
 =?utf-8?B?bHBTSmNUZFJiTnRCSnA4ejkzaHl3K0ZZdkc1U3lLc2pnWXNjU1hoUFlKMktD?=
 =?utf-8?B?TXlaV2ZUdy9vS0pFYkFuMjlpQzhMcjZDR0c4NGJKbWRCcTIxMGMvdzFaOHFJ?=
 =?utf-8?B?NWZuK2htajZ0QS9qYmRubUNTbzZscDBhZ1BVa25OTjZkdHlWT2xnT1F0cjJp?=
 =?utf-8?B?QXdXWjh4Ni9IQkRZZHlBb0c2SXhVVS9FNG1lRmxTemFQM3p3ckRvcUNjdGJC?=
 =?utf-8?B?U2E3L0xEdDgrbG4vUjRRTG0wa0g4SFB2NW1sRTN2eEVCb1U4K2c4SG5XclE0?=
 =?utf-8?B?TFpkS3g4YlJzTTk4cmFCa1VVSjdYWHZkZm4xMVYyV2lMeWhzSm1tTkZxREVS?=
 =?utf-8?B?U2tNd3ZuWEh6YmJ2WHAxZ2tXOFp2LzN6WGVNQXY4SkdYTDdhMXY0SndEY3R5?=
 =?utf-8?B?WEtYUUE4c2NCSnE4dFNFZDh0L1U1VUVDd2ZZaXVBRzlqb2Zvck03WW9wTzVo?=
 =?utf-8?B?UFQ2SE03d2FobWNNTlNtVkNyRHpzZ0l2T0RqQkdpaW1NdFN6U1RZOGsvb2pF?=
 =?utf-8?B?dE5xVHhIcEVhSmhsb2JFREJSenFUbTdjcFdrZkg4SkwrZzkwNjFhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795fb09f-0fe0-4f25-a453-08df02b5c994
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:33:10.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DbvmsNWA2dPXaceY9HnlgtCpGQZLaJg52snrnrr5iHNjAnF/X3ypzpAx6R0usVb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/25/26 16:28, Tom Rini wrote:
> On Tue, Aug 25, 2026 at 08:48:12AM -0500, Bryan Brattlof wrote:
>> On August 24, 2026 thus sayeth Michal Simek:
>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>> files or directories which had been renamed or removed over time. Drop
>>> these stale references so that every F: entry resolves to an existing
>>> path.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>>>   board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>>>   board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>>>   board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>>>   board/Marvell/octeontx/MAINTAINERS                |  2 --
>>>   board/Marvell/octeontx2/MAINTAINERS               |  2 --
>>>   board/Synology/ds116/MAINTAINERS                  |  1 -
>>>   board/acer/picasso/MAINTAINERS                    |  1 -
>>>   board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>>>   board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>>>   board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>>>   board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>>>   board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>>>   board/amlogic/p212/MAINTAINERS                    |  1 -
>>>   board/amlogic/q200/MAINTAINERS                    |  1 -
>>>   board/amlogic/s400/MAINTAINERS                    |  1 -
>>>   board/andestech/voyager/MAINTAINERS               |  1 -
>>>   board/asus/grouper/MAINTAINERS                    |  1 -
>>>   board/asus/transformer-t114/MAINTAINERS           |  1 -
>>>   board/asus/transformer-t20/MAINTAINERS            |  1 -
>>>   board/asus/transformer-t30/MAINTAINERS            |  1 -
>>>   board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>>>   board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>>>   board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>>>   board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>>>   board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>>>   board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>>>   board/avionic-design/plutux/MAINTAINERS           |  1 -
>>>   board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>>>   board/avionic-design/tec/MAINTAINERS              |  1 -
>>>   board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>>>   board/bosch/acc/MAINTAINERS                       |  1 -
>>>   board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>>>   board/compal/paz00/MAINTAINERS                    |  1 -
>>>   board/compulab/trimslice/MAINTAINERS              |  1 -
>>>   board/comtrend/vr3032u/MAINTAINERS                |  1 -
>>>   board/comtrend/wap5813n/MAINTAINERS               |  1 -
>>>   board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>>>   board/davinci/da8xxevm/MAINTAINERS                |  1 -
>>>   board/embest/mx6boards/MAINTAINERS                |  1 -
>>>   board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>>>   board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>>>   board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>>>   board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>>>   board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>>>   board/ge/bx50v3/MAINTAINERS                       |  3 ---
>>>   board/htc/endeavoru/MAINTAINERS                   |  1 -
>>>   board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>>>   board/intel/agilex-socdk/MAINTAINERS              |  1 -
>>>   board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>>>   board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>>>   board/keymile/km83xx/MAINTAINERS                  |  2 --
>>>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>>>   board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>>>   board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>>>   board/lg/x3-t30/MAINTAINERS                       |  1 -
>>>   board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>>>   board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>>>   board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>>>   board/mediatek/mt7981/MAINTAINERS                 |  2 --
>>>   board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>>>   board/microsoft/surface-rt/MAINTAINERS            |  1 -
>>>   board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>>>   board/nvidia/beaver/MAINTAINERS                   |  1 -
>>>   board/nvidia/cardhu/MAINTAINERS                   |  1 -
>>>   board/nvidia/dalmore/MAINTAINERS                  |  1 -
>>>   board/nvidia/harmony/MAINTAINERS                  |  1 -
>>>   board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>>>   board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>>>   board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>>>   board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>>>   board/nvidia/p2571/MAINTAINERS                    |  1 -
>>>   board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>>>   board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>>>   board/nvidia/seaboard/MAINTAINERS                 |  1 -
>>>   board/nvidia/tegratab/MAINTAINERS                 |  1 -
>>>   board/nvidia/venice2/MAINTAINERS                  |  1 -
>>>   board/nvidia/ventana/MAINTAINERS                  |  1 -
>>>   board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>>>   board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>>>   board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>>>   board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>>>   board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>>>   board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>>>   board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>>>   board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>>>   board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>>>   board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>>>   board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>>>   board/nxp/lx2160a/MAINTAINERS                     |  2 --
>>>   board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>>>   board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>>>   board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>>>   board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>>>   board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>>>   board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>>>   board/ouya/ouya/MAINTAINERS                       |  1 -
>>>   board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>>>   board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>>>   board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>>>   board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>>>   board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>>>   board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>>>   board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>>>   board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>>>   board/renesas/blanche/MAINTAINERS                 |  1 -
>>>   board/renesas/eagle/MAINTAINERS                   |  1 -
>>>   board/renesas/grpeach/MAINTAINERS                 |  1 -
>>>   board/renesas/v3msk/MAINTAINERS                   |  1 -
>>>   board/samsung/starqltechn/MAINTAINERS             |  2 --
>>>   board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>>>   board/siemens/iot2050/MAINTAINERS                 |  1 -
>>>   board/sifive/unmatched/MAINTAINERS                |  1 -
>>>   board/sunxi/MAINTAINERS                           |  2 --
>>>   board/ti/am62ax/MAINTAINERS                       |  1 -
>>>   board/ti/am62dx/MAINTAINERS                       |  1 -
>>>   board/ti/am62px/MAINTAINERS                       |  1 -
>>>   board/ti/j7200/MAINTAINERS                        |  1 -
>>>   board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>>>   board/toradex/apalis_t30/MAINTAINERS              |  2 --
>>>   board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>>>   board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>>>   board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>>>   board/toradex/colibri_t20/MAINTAINERS             |  2 --
>>>   board/toradex/colibri_t30/MAINTAINERS             |  2 --
>>>   board/toradex/colibri_vf/MAINTAINERS              |  1 -
>>>   board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>>>   board/traverse/ten64/MAINTAINERS                  |  1 -
>>>   board/wandboard/MAINTAINERS                       |  1 -
>>>   board/wexler/qc750/MAINTAINERS                    |  1 -
>>>   board/xiaomi/mocha/MAINTAINERS                    |  1 -
>>>   board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>>>   board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>>>   board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>>>   134 files changed, 241 deletions(-)
>>>
>>
>> Thanks for the cleanup!
>>
>> For the TI boards
>>
>> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
> I want to call out the TI borads here, because I'd like to see the
> entries fixed as the first thing I noticed was "it was called
> am62a7_evm.h downstream, not am62a_evm.h upstream" and we should have
> an entry for the include/config/ file :)
> 

Maybe make sense to find out which of these configs are not covered by any 
fragment.

Thanks,
Michal

