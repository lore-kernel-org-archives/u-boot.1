Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013C4F46453
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 11:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2146183FE1;
	Mon, 16 Mar 2026 12:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yz0SJ+Nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463FF83FEC; Mon, 16 Mar 2026 12:55:19 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE02283FDB
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 12:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7Xd411Cfb85do8CMU8I8zChUGK9XVS6RzOVpk0QnXNfnJsN+aOzAdG+G9Xg4f9+1E9NmXbPA0rAFGnsGHHGe4YNSLVrsVUtBCVC1HJA/x9CQcXwOuNNKFnvLplyrHXX2PfJ8+KpxVRgGopp/+KP8EChb7PNbifndltVPxVxNOByAFqOAPfi2jMXPCd58eAfDPETRZdmVyCL/f2yD8SJWz/oZABnB/A322yrHC4z4zbKiFEUTwlM9ES4Bl9VHHxObYa5lE8jgkxgyfUDJrqpxfvNVmjdJOq4jcuQ4iPDdpOetXE+40lt8wshnEaviCzh7K80NDNrDzxET45KARmGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFCD6olTpU8wJr5f3BJC+8RCBFmDOM/y2Rz1YzWoRhU=;
 b=wo/DIPJs8iA1XOJ/Vfz6zmjqIAWim33q5yhLLyW7EJGtKShL7NXVGQLf1Rb8DyN7F8Jth/FacQKCPNf1dsJ8ZOEOilBOlG7g89WSLQ4dbOsJU+fDlvgzGcEYh8QsfPJYYvDuw0tnwyoKV0OvUZLUu2HVROv+iM6Z+SflkxkIRhBI+N6F9dnkonKKFkjVh1AqP/uBvQ32pKB0Y1N3Xue/MgHbWc/T2gPI41hxHsOU13VaRw/RbVXHLeUMGTJlbmK09a6n8LAuhmbzoC8mXeB5VlZfxN+l2PeJmRWX095AO/c0clNwl38jibSSXyXxOUcowR2tdJEF6KuGvYiCj1DgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFCD6olTpU8wJr5f3BJC+8RCBFmDOM/y2Rz1YzWoRhU=;
 b=Yz0SJ+NdDUQyCutmgaK616a9GCZi2gKBo7rBX5v5KsP56fUUFRJnLg1C68FzrzbDQ0Q/0lyZUbTwGTD0af2ioDLdB5PM0U6pKQUYOwqGEDBKYWL4QJ9XKsxx/OMJUKQh6rWn3n2GmHlGNJcyhDW8r5cl7HUr8MXYNL8N9+zrLew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 11:55:09 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 11:55:09 +0000
Message-ID: <8b100da2-0e81-4340-9e5f-cb534449416a@amd.com>
Date: Mon, 16 Mar 2026 12:54:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <8ee5fc7a49816d9e26f38999990aa1e4e354801f.1773416725.git.michal.simek@amd.com>
 <9334dd3b-3bf9-43f3-b711-235246f3c901@gmx.de>
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
In-Reply-To: <9334dd3b-3bf9-43f3-b711-235246f3c901@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c86a705-eea6-49ed-3633-08de8352df29
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aSPJwALOH4OGDgvUv+UrLI7TOCsAe64zXRtRQL5YN56ovJBczomboe5xayhX6WD3zFvPcR8qUNkz/4eKFE5deSuBhvZBYGDJOX4YVwvXO/HI9lX5T4hpIBaLbfsB9+8+SN4AbRfE85f3L110HRfQpWeuqqVNLQZ3vx3Zj2CVlunqCZcH25t1zTtzE4kolSKngNNkezOr87AETcCm6BV8iQ4K/ogOkfA7XC4VrxbM9a2KhG8YR1cCJvIz/DgHXED7fXfyRq4myRzi6SrgwWzM6ofWrGVEDOra9OoAr3m4TkLpNveZfjBdfWVWy681Ey4RRykZfi10CCjjiY3Ln4Ekch0H9URzgoCdukU/me9bC+FLJIEF1QF+BnZnAKwlD6n0dzR6Sn8CE8CMX0aOiDbHbktEQsHbuxgJWa3Xg2bixG4tPYPkOgQ3SNr+yVV8/BmbJ/2iCP7jobjMsfx2BoHthI4Qj/Ntz1Xd7cZ7f4hn8NXmWElqpaZ9DO8QJh2nRwbsJnEJXH5CuHTHQiIWElKoH80Cyt7L1oBDoZKYf1aNWyVmxdL4kFY0HJfaZRrGoBpwTBXkUpTnrcUlKTUpbJMcqT1JflUr9yAVm5QbIrE/ZuDzqi/FJntq5VRKQqyAKCNoCtrvccT+DBdyzQveVis23ID1RK1wwWbGLmOraBwKqncBqELe7xadv8a4eWFw6ln7t/jzMMVUomHqrSd16V8NILE/T7VzKR+MX7fk/jApU2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NaMERTUkx0QW1qc3FiQmtjdjdIU2NFd1hzNTlkQUZ2NmQzcFJLaWh3Sm9a?=
 =?utf-8?B?UUNQY0NHbHRIZWh3b0VCZlZ0U3pZaVh5Z3lqVTdDRHNJdUprNDJQMFZPWThI?=
 =?utf-8?B?azh6NkJIZWcxZ3lKK0FNaWczNWt4K1ZrRUFzcDVGMkg2bkNVaTdLMTNQaUQ3?=
 =?utf-8?B?akRDR2tkdmE0OXRYVkdmT081cnZ3dytXaEQ1eUtWbTJHSHUrRTBhRVVVbGNB?=
 =?utf-8?B?dGJ0emZFQTNob1lGS3ZERTBnckxONlhQZ2dVYW16NmlsSmk1cnFRUlRKVmlo?=
 =?utf-8?B?UGZQUzdvS1E4cXJsWTNaMTlVM3VUSmZwaW1aYmxScnRPMXZPTmlBaU9STm16?=
 =?utf-8?B?RWRUS0J5ZXgrRU0zQ2dKRFVCcXBOcU5vVEJ6R0F5eVZQMlJ3bkU4OFRBOG00?=
 =?utf-8?B?aHIvMFJPRnczQ25DWWFqMVluWWx0TmlhTk1BM01CaWM0b0w5R0llUkMxRHdC?=
 =?utf-8?B?NGs1WXIrRE5UYlJrQzZCYmxkSHpJaldYWDQ4OFhMZ0dhWGxWbjVTVkRkdDdV?=
 =?utf-8?B?Q09QRXgxYStyWHduWVUvc3VwcGlYOENvbmMza3hpY01VUEdSZGtQcEY2ajht?=
 =?utf-8?B?Nkp6Rzh1L1Y0K2psaXlBZzFzVGV0ZFRBb1Z6VG5sY1FMTHBVNThIWmtCVlVI?=
 =?utf-8?B?VEUwOXFRenZwWml5cWNieHNYNUtoZFhtOS9vUEVERE1DT2M0TWNVSCtvazRi?=
 =?utf-8?B?Wi9ha1NGMm14Ui9BOHFRRWNUcUJGd25EeHFRYW9jQUpFNWtuWkRiVVRrRnBO?=
 =?utf-8?B?M2VpaWlXWURQUjVHdjZXWFZUTmwvV1NXS3BHMDRKRC9rd0NCbk4zdkREVkc2?=
 =?utf-8?B?SnNRd1JBdHFnaUdORnErckVsdFdkMXJsYU01dkVXY0xJSDNleTVKbGVWL1pj?=
 =?utf-8?B?eEc2ZGVHaFphS0JPWngwcjhzZjN0cjUxdTRFanhqTnVkaFdNQm9qOUdXV1JY?=
 =?utf-8?B?VERlRE9KR2k2eHN3dldxaVJSL2ZSbTJteVd1K3UxK3FKNyt2YWdBcXlLWGVi?=
 =?utf-8?B?MGYwaXU4ckhuMzZOZkFYeGhiR2F6UkVuUEYwRnc4YzhHVC9VWk92VzBiZWc3?=
 =?utf-8?B?TEZHSnZzbFJBVUZSSHZVNkIvaVhETDBydWc4L01MQkhucGFhZUtKK3c4Z0Vx?=
 =?utf-8?B?WmJqOVk2OGh6UG5qVjhvRU42czZZSDJSR2dTNko0Ym5VTVVENy9IYTZNK1ZV?=
 =?utf-8?B?SURST05hcTJuWXdFSU9mRnJNNlBXVmVQMytLMVhPeGU4MURkTjdPTmFBRkty?=
 =?utf-8?B?YUxjTzAzTlBiLy9KNTdqSi91d1l6WHIzamZRMFJEMFB3bXNCSkYvWFpLeDJV?=
 =?utf-8?B?MFhmRXhWL3VmbTl3RUU5MitBa1RuTzQ2L25yVXFkeHF2eVd0NGN5WVRQS0VS?=
 =?utf-8?B?RVRPbWxsM0xiUnhpbmw5SUI1NG1Na0RPZWJ1NzMzaHZSOWFCTlhzNlB0T1I3?=
 =?utf-8?B?bFZVSEdmVVlQRlhSYXlEOFBMenFQeHBvY2RJeFZSM1VETGVJM0dEVjRFb0lY?=
 =?utf-8?B?Q080bEVFaDd0cWxBNTNhU0M4TXQ1aWlQdUdRQVlhM0lncCtOcFZFcW9qbjN1?=
 =?utf-8?B?cUxrdHZhUVZtb3pyV0V6dWljeFl2QUdzaFVJa3NCUnVqMmhUdVRDY0dlNDk0?=
 =?utf-8?B?Zmh4eVdyN0d3NUp4UmEwK2FaaVkzV0xtb2IzcDA5NEVVVlFJZ052UHo0M1ll?=
 =?utf-8?B?WFRNUWp5VDNzNmZJS2dGWFBiMW9FUmQzYUY2NCt3aHNtM2VGQVNLR1VHUE5H?=
 =?utf-8?B?UzVaNGhwcENRZkJqSUNPSkhFeHZUajNxbFRpcWNuMmMrdXhuUEp6MFZZVjJL?=
 =?utf-8?B?VFpzbXcwdmQ4UFNnZFJ6TmkrUlN0TWhBMUZibHlGNkk4MHMvbmNSdytyWDJz?=
 =?utf-8?B?OGpoWEJqSytLUG90ZVM5eWllOGNDTVA5Q09ZM01ZbG5ScWZBczlsa3dnbWxD?=
 =?utf-8?B?OW1vNlZIdkNPajZyZmd4emVmM2FQb000cEdTT0dwTUJ1Vi8yd0ZyeXVtZDA4?=
 =?utf-8?B?bEpqTW5rQ0dBb1l1eHNhVHlmUkp0dWtUT0I5V3BSYjJqVjEwY1VOWGdrVnpK?=
 =?utf-8?B?bTF1MGJHYTc0aGRRdWwxYm9zZzlSdWRPMVlLdjFMKzVadmd1R1A0WUdYNUl1?=
 =?utf-8?B?UldTUlRHNFQxRWl0RlJWY3p2YzJkeG5XVUg0R25laCs3dzRWZ0NjZVFNeDJz?=
 =?utf-8?B?OW9LS2V6a0ZrYUU1SmdHSmZlNXJCS0RZcnM1UzZPV2VIcldOTGwxUDZxQ2hX?=
 =?utf-8?B?NnlZaldJdUFhZnRIN3J4ZlZteTJobE9yV2hDR01raG1OMG41dStjUlRyK3Qr?=
 =?utf-8?B?QllhdTFRTEZLMFI1eGhuK1F1TFcwb2UreDNmeCsxR3JmaWRpNHFMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c86a705-eea6-49ed-3633-08de8352df29
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:55:08.9459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZAiGjxpaDpeYQuBOiPawq2V0jJdoQoD6but/QY+GxkjljDiiCs1OWZ8TyuyRMrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479
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



On 3/14/26 10:19, Heinrich Schuchardt wrote:
> On 3/13/26 16:45, Michal Simek wrote:
>> From: Shantur Rathore <i@shantur.com>
>>
>> Currently U-Boot uses ESP as storage for EFI variables.
>> Devices with SPI Flash are used for storing environment with this
>> commit we allow EFI variables to be stored on SPI Flash.
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Tested on StarFive VisionFive 2.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> 
> The next logical step will be to define a value like RTStorageVolatile and allow 
> to select CONFIG_EFI_RT_VOLATILE_STORE.
> 
> One way to define the location would be a SPI flash partition defined in the 
> device-tree. An EFI variable could provide the compatible property of the 
> partition that efivar should write to.
> 
>      partitions {
>          compatible = "fixed-partitions";
>          #address-cells = <1>;
>          #size-cells = <1>;
> 
>          partition@c0000 {
>              compatible = "uboot-efivar";
>              reg = <0xc0000 0x20000>;
>          };
>      };
> 
> cf. Linux
> Documentation/devicetree/bindings/mtd/partitions/partition.yaml

Can you clarify your request?
I mean, yes partition can be defined but that's more or less for OS/efivar.
U-Boot is using Kconfig parameters to save it to exact location.
Or are you suggesting that u-boot itself should be also decoding locations from 
mtd partition (as second configuration method)?

Thanks,
Michal
