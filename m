Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C198103E305
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E582842F4;
	Fri, 13 Mar 2026 16:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jvtq4Q6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343FA843C4; Fri, 13 Mar 2026 16:50:27 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6078423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQDBrkSl1kvaf5o4of6SXLe0+SMKgVd/kxkbBgQKanuveI3kyuBCXjk/AD8HhMCwaj8eREl4EOdDjKJ/YDL/nnS7wynx0nGQ8HUBy+Xue4WRBBeVHizSB/ANXGt3qVLZLlqIeH4Z8QgK2GzJT0jq73lE4NLlrc6Yw72ajLXuFajbb8fXoByCjtC6eltquqia2S8kdl8PBjdGRmdwZLxgjPDKqmwXmsnWXbxev+I+XE9j9Li2lFByhJtLIMnRqckoTYxngW++vN0STyBZ6vjwImrng/jSPWSiZx4WOGV7Hu8F4acadm5yCyS0svL6ku7Vp1ybkjBAsejUJv0c8gxiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT8ZuhPVPKBHympSpeanyO99Jcn/fA05Ub9TKWMS+EU=;
 b=psHSqPGawTnCLRy6JraL8MLRWXLfhM9FutUmUxywllM5HNPUH6WtF2n15nDUv4YFFE971KwIfONpReJPI/vei/zt8z3FngNU4JH69+cYjuNLXDujezc6O9mFUF2sxwu58R5qH12BgNp+HMD/8L7U/q+CbLdPm273iw35pRp25orWwsb4C//HuPzxcMTf6yNDCGuvsQSLrzRw2toSvXOqxXwJq/TATFAQqR+c4gjo1+wDleyZG2BOKmlUPa0VpmMnUvoSCvQTiIYAuPKNp6Gq0Q05URnGUffe7Mnd7GcgIwEv3mYNSe59fyy9Dk278qlDbQg5VA1cqI6mvlVLZ9NHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT8ZuhPVPKBHympSpeanyO99Jcn/fA05Ub9TKWMS+EU=;
 b=Jvtq4Q6ycMkyp+unlmSzeN41fmvxBRDU8g8u8MQUlc8pP9ww/RhyuENtU0zj3EyeTWgdhFai2dV/7RCbQx1MtKfYT4j00cZwScgC+ZxG1V6cgMZzib2BARUSolj/5321DpS8IIvxgs7vdUzBWTMZBcDDl+tKu5MH4w/4JsSFyM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 15:50:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 15:50:19 +0000
Message-ID: <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
Date: Fri, 13 Mar 2026 16:50:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
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
In-Reply-To: <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed0f62-1f02-4853-37bd-08de81183a1b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 88pw2LpKeZJePtZFXlZy2VpCeKG6cpoPAP9mJgPrjszBXfUZz5GnQ95V/awu0FRvaBF84Y1sSge4mvzKghJu5nX2Ez2T2JVvQX8hzUXLRIMP2ubA1q48hiI+T/YALLo3QLcsOr+hESXtM35/0mpH3IM3cx/F8qT1yolgezLk2ZjnxBTphidTDy4KsgnCUEqiHCK4Q9VQ3e6NmXwU/EiRJhAP69e38MTknprTTgnxKOmQahTIcmjI2Dp+KYmZqVkpw8BNhB6UvJgL+dJCYIBRCUMIMHQhYNvDjnuqss43+bECl/RGYm3RGLweRullp9MT+Io5CTibIba2CTQAtZtZAxpwdrgyI/2e4triFxask1LUirjDdoxlotZf2xg2/R5i/moGcE0OSPCHjS5+dlvWe2/Qdh519hsVoTOXoV4a4AqvbE/qv/3ekt7NI4CXJ5a7onGjPel6YO0c7dhpzo0XKgC8PmN0rDF6nTiyAmZl3dBel+KDBSncMYCN1ZLVvpMSa8Pl5F6k/YtMv6MDG4oC7k8FV3YenuDtVmA/7q6Du6/gUAGF3WD5ISMbOOw+LbjH0ddTL/c90CvlfdjSgdShwMa0Uz7FU3Nb6bUJI5najzwlEwW3vyJlOoRvB3F7G09Apk7TKgb453NN4REbwYKCwlE5A+NCdk6wXZib+1Bc4Frm22X7Uzs10bVBHVjYk12w77n1F4V2884Ufzvg4AoU5e6fHZs64/vCe5fk+upQ1us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlwY2R2TDl3czk0emxYQy9FQjI2ZzVQWmkwVnhoYWk5TWZsejFvYXc4a1ZJ?=
 =?utf-8?B?RnRKTDN2cG9ML2JRcGhXMFVVdGp2bmhJVWIyd21iaHBHVzVBNGpmaVY0NXc5?=
 =?utf-8?B?d2xhTFRrQ2x3eTF6cnlUeDc4SmRtQnY3eFV1QnZ4eGl1QmtzUjZQRnRJUkR0?=
 =?utf-8?B?T29JQnpMRFowOWpQcS9HMWk1c1krcDc0THNNKytCR2VrS2IyWTBwd29OZ2tK?=
 =?utf-8?B?ZkIwQTlQbGRVL3I3bTRjZGpPMlZZTVhjVHBYdjlGZ0RHOU9MbEV3OGlwSXFW?=
 =?utf-8?B?YnJWNVFmMTVIdGZ4dEUvSERsRmFGNnF2VGt0Sk5mcHQ2OUYvQnhsWTdqVUFw?=
 =?utf-8?B?eWo4MmFhU082S3pHWUkxYzF3dVIzamFIZEkrTlNnTTNxTVVlZXpRczE0dlNT?=
 =?utf-8?B?QitWaWZpQm5IWkUzcFBuM1lEL3NzL1M3eWZidkdQMXROOTBRRTRGR0p5OFhx?=
 =?utf-8?B?OUttTHRJV1dpekZ1Zyt6RkJkbHpMZWg1bEcwRjQwZnZsbXBPSkliaVNyM1Fl?=
 =?utf-8?B?ZzQydUVaVTE5NHoyb2E4NE9teGpKK1U0bHdra0pZSU9kM3lzQXczZTNpeTI5?=
 =?utf-8?B?SG5wNGFZZ2ZHdkpZM2dqYTZmQUZWOG1FeWp1S1BVZSs0SkRqNUhBM0laYXo0?=
 =?utf-8?B?bVcveVVvTEJXMThLN3I4YUdMVDlncEZnYjhLdzBmSHZUSWw5UVAxQUJSd1NY?=
 =?utf-8?B?NFdPMjZSWktKRGFveldHU2t3Tyt4Wk5SeUkvTTQ2aFFzM2VScFdCRGxhRndk?=
 =?utf-8?B?dkFkU3N0b0EybmhGQmk2QWk5ckVTd3kyQ2hmbk54YUwzYUEyR0RCSUdKUlRk?=
 =?utf-8?B?MGp4dEQyLzdMZUQyQ2RUZ1pjNlFVcC82U09FY1R2bnRSQnRZcjE3bVVqdy96?=
 =?utf-8?B?T1FKZ0grSXdtbngvYy9sVHl3azFRM0hjVWJHVGd5TnJtNkRrbVIzQUUyY3ps?=
 =?utf-8?B?K3d2UTBrZXZMUzhYYlJkNExMYzU5cnNGQlFJR3ZTd2NTMitZakdxV3lRaXNV?=
 =?utf-8?B?bWwyb0U4aVpNeGFYWndVQmV6WEdCU1dZQkFyNnVXSHpMZ1dGVitCMnBSSko3?=
 =?utf-8?B?amJBZjBVOGYweHVwSVRUY0FZN0FqMWEzZ0FBV2tlby91dWphQ0RIM1JHT29u?=
 =?utf-8?B?QSs4TVlNMDgvS2EzU3Ezd3M4OWNWM2piSnNqOE9saUlRRXFqRUJMUlkvWktx?=
 =?utf-8?B?VlRGMlpINmlPVjNXRWF2SWtHczlUNUlPZFV2RWcxc2tIV1MwUVh6eXVjamU5?=
 =?utf-8?B?YWJCUWIxbFo0WkRUbGloeWJsdWNvK0ZyRUFXaHgwK0xwek5YNEMwY2h0YXNs?=
 =?utf-8?B?UmtxNEo3S2NnVDhXT1NMZHdjN1RwTzBZSXgyT2J2RnRJeXRNWWJadkFYTWxo?=
 =?utf-8?B?RW9BNHlyamhiKzVKMWVNZ01tMElSRDdZQ3EvbndxN3kxMkxTY1g1S3MvZlU2?=
 =?utf-8?B?eDNGcjIvSE1qcmpjR0NOdTFLM3hCdjZRTzEyRS95aithSHZQYnZpZjZmZ2Vs?=
 =?utf-8?B?TkxRVE9vVXBISWUwMjdaNjBPV3BjVDBUNGlicXVhWm9yM2VqbFBxZzc3Vkxv?=
 =?utf-8?B?QzVCZzBmOFZsQkhYcTkwa1ZyL1FVVnVNYnRINnRRODlOOExFcDMzMW9QV1Rs?=
 =?utf-8?B?UEVlQjNFODg3NXNxRlQ5ZktMaFQ5ZE55R2ZvQTIxWHVhSlV5QUgydnIzelZP?=
 =?utf-8?B?TXVMZlVGQUE2OWs1REtVMVp1bFBiaFhPUFlEbVNQVWFiVm5YdVFLL1ZTYnhs?=
 =?utf-8?B?WjZzTmJaeHZzV3J4OGtkeFd1Y25BWkphUGFxU0JXRjJZMWd5bzJsUTVSQk1Y?=
 =?utf-8?B?dG9MeVU4dTZ0SWNjd25wMzRIT1ZQTHBKZGFOUVBrVEZDTGJNSkpvUGdmTEJC?=
 =?utf-8?B?ZWZsTEVFRFpBYmVlMFFjNFdSTDZlVTVFUENOeGg5T05nb0NtSXExa1JZeDFE?=
 =?utf-8?B?STVMVUpBbHMycE1BTjBsZk9QMmd0dmZMemdFMzNHcWJ0SFBJQWw0dXAyTVBF?=
 =?utf-8?B?bi95Siswb3crQm16UFc0dmdlWXZ1cCtvK01WelZCazhyZHZ6K2Nrd0xmRm5u?=
 =?utf-8?B?enVIbWdYS3dmWndTVldEZXBjMVhtRHFQUmI3c2VQWHo4Q2lEandrODBsNnVn?=
 =?utf-8?B?QkdXY0N2eWQwc29ta2lnR0lFS0JmRWl3VFFlVmtzKzh3WGVjb2lFU2k5MU4x?=
 =?utf-8?B?cUxjNlFvUi85RHk5NkhmK2xURXUrWnFLb2RPbUVXWVRidkxTWlI2dlAvdmJI?=
 =?utf-8?B?U1lmb3NPNUFpOWpndlJpbUlwRUgvc2s0MEZCcE5aRFdFRkFFQ1U0aGc2bkl4?=
 =?utf-8?B?by93aDVDdXdNN2x5OXpINHJ1N2ZzVnZpVFJrTnhtZnJHOUkvVzZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed0f62-1f02-4853-37bd-08de81183a1b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:50:18.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGGGLEWpe2cww5bVSFlp6rB8l/vWzAfjRTdbBeXZDA22mtnnTN6CPazrF08qJF92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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



On 3/13/26 16:47, Peter Robinson wrote:
> On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Michal
>>
>> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
>>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
>>> during unit tests. Extend this mechanism to be runtime-configurable via
>>> the 'no_ansi' U-Boot environment variable.
>>>
>>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
>>> at the start of efi_setup_console_size(). This prevents
>>> query_console_serial() from sending ANSI escape sequences to the
>>> terminal, using default 25x80 dimensions instead. This is useful for
>>> platforms where the serial console cannot handle ANSI queries.
>>
>> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
>> It really means don't use ANSI queries to detect the console.  So
>> before creating an ABI to the cmd line should we really call it
>> "no_ansi" or perhaps "no_detect" and in the future clean up the
>> variable names as well?
> 
> I wonder whether this should be a Kconfig option too, a maker of a
> device likely knows when this is an issue on their device and
> explicitly enabling it via a config as opposed to an environment
> variable would likely be useful when there's a menu enabled and the
> shell possibly disabled?

There are a lot of Kconfig options and variable which can aligned it.
It means we can create Kconfig option for it but likely we should also have 
variable way as common way in uboot.

Thanks,
Michal
