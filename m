Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692A4F46119
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DD184181;
	Mon, 23 Mar 2026 14:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCwTauBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6298418A; Mon, 23 Mar 2026 14:57:48 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB7184175
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn63f51Q7YMKjfa00G9rU/CakbVxamdvX8ZymzLTe1UVjNzm40QkDp96VDgHIeRn46+HpVn/gG1p71iY808Hs8ooryvPKZgC25puDI3VGFrsSgEbz2Bp6H92H8GoRvhxo8fZJDYte5oD0wudRB6guf9MNjPiFfXD4lorglaOIERYkOfUDpsS9iyA9ykKYK3VQcZBOaoe5JCgnGGm1eHMrzWL3usJE6CEH/CkAMvYPEj3csGIUm4NtsVqIONQvCu4L+Y2wXRcyuCcdE5qSeGTp056lTHMRwIwX3bg17o6OpLPoF+KMcbLu9wolcrmA2mskVSzpeVcEOPWq6wYGkYg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjukpXgjVizi/s68aMbM76347INclPSJtXSeVMchW9o=;
 b=PilSvog66c8BK/6fkJo2Tc6w2X+8avT1RBTw64jGr8smpSj8lXr1GBnlfu4Zo4LqrWdJLj2YaxUbmNwPvVw28IXhF8ttbfDUa3xXcUwbXaP0dNnkK3RCkwesQPFRun5NTn97+Dj9WElMsDraCjOrBofGk1gUWy59L3lA4tc63bxBRabio3gCw0YJ2Zow5bqGM+9mBLBpbDGY9Nmmu9PDDjtlte9tJroLtkpUJ8cNECDK9FH0HMQl5QgMDagpWaxVY8Cv23WFkPy/34W2IXYRrVR4A9MM4jHG+ChEoyp7Jn2leCMNaPXBbFFMhs05IxrSYl+/uNgsV2x7XVs73PsXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjukpXgjVizi/s68aMbM76347INclPSJtXSeVMchW9o=;
 b=rCwTauBSsfiZeaRaKnCnhp0rv1LKdlNZFzegnntErPax4t3g9dcQMc2xOG4X1VqxqHSHMpOc5tIkr/Iv/5wW33ri23nxTtVWIdFwuqxi3293NPRw8eQxkly59aLy88UZDZQGnBF6JSt8CsnQ9otWiYOiszKndTWDmuNhfxE7XQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:57:39 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Mon, 23 Mar 2026
 13:57:39 +0000
Message-ID: <8a7df219-60c9-43b2-970d-3206f0f4fad7@amd.com>
Date: Mon, 23 Mar 2026 14:57:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu: microblaze: Fix unmet direct dependencies for
 XILINX_MICROBLAZE0_PVR
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <61ddd555f58ef5169c48b190423640d949e4aad1.1773764781.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <61ddd555f58ef5169c48b190423640d949e4aad1.1773764781.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b7cd0a-4f9d-4042-3a75-08de88e42541
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 7YkrVrjkOEoX9Uvdsgd1c//qdUQZOXhxyaTbhB+nXBtSuhEYBbH86JYFsZNnW27SDwyGhPk2h8/ydoKGrQ0ZDgeeDd1RfSEoQUbOYIupTmNMmyQwkD2u1WbnarUETD/4Jzsv20deEO6TPFXyiiSr7rQE58a/2lTDfIGRSq8JIB5CuncC+JLJtA5/7hEHGu+iBFMjD1Abi6zBCr9Bzp8HyTL7alojSyxWremYrWENPspZImO9pjY2k61/vyP2wLvqUDvNezuX1tqQ0DZpOwKZYR0DY+Kdf/MS9lqZlyrb16T/T79fMXiuWLtcubLqKsq5ykhejlxTM1x/CI4p4RBqkBAnTRyOJXcLdp4cGOvGiZ6WOABU0jiqpLHEmTWAPBwyl9b5CK1RhPGHxnXxALtgeemuILfCHaCF7qQAA8UURinlq7QS8iiiHcyJRCGMVnSJ5TBHCig7W73ppWtSr9O0kDyDgVbtlpAEt2Ppdclxje5esS926hUW35o3FIsp6HowaC4zx+xNtONJH9Ek1xluqeRGvgmiHj2LAgug27og/pnNH9406BTw6UUpQB4anjNMiHpzDwwOQPoZk9RVscveB5LLKGJykoyiaxuEKG+arG44bek94OQyUJqWSfgVHVPQfBxFM5WXmBjEriRa7Qiy0umy1pd32soWka5jPLyfVtuyZX99qep19laxph3TCW4R+/VpnCdZNuDbT29utvJh8zRF2eLOpTLuA4rYe+LBVXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBCMGdwck4ydW1nbTk0YzNpcGg2dy9nVTF4Y3ppQkFFYXpoTmRmUE81QW9i?=
 =?utf-8?B?aFJYTnNsN0tLTG9SNGNPTEVxYXc5RDk5cGRmNGE2M01ybHVLZG1zQ0c5VEdT?=
 =?utf-8?B?WlJaVXB0L1FudXNUbEZVTUZSVDlIT1NYdEpIUTVXS1hBdGx6d245QVlRZzFK?=
 =?utf-8?B?R0h5dzRLeGZFV1NMeVZsb1MrRm1lWXg2Y0x2WXNQWmVlbEtBRVdHVmczMCtj?=
 =?utf-8?B?d1R2OHNhQ1dBTmNSbkFmSkNMdFRyKysrTDBXd3Q0WXBOaEpWWEZYNTR5d2ti?=
 =?utf-8?B?KytIL1ZiSDQxYWo0NE5LNUNibVBweHdKcU5sZ3V6RHBHdmNCMzNKdURRajNX?=
 =?utf-8?B?MXo4aU9JVW1BUGRGVFJacUFzcFBqTDR4dzZrbGtsVmNsd3JtejgyL0VicERk?=
 =?utf-8?B?bURCUHYwc1dMMmhWd3RrSmxvMHFZemlrV2FDclFoTGVYMVVMOHQvMU42cFpw?=
 =?utf-8?B?cHBkVmZ1d2pOZk5RM0I3MEd2eFA1MS9IVHpJNmNUOTYya05KMkFZbC8rYStC?=
 =?utf-8?B?L1pBUmRXMlZtc05VMERhY2tCRURZRXZVUk1KQ0hrT2JTaXFzWUY4d0xCMjNL?=
 =?utf-8?B?MlhQVEl3alE5dVhzUEovYTE0bDdLVzNUUzQzR3YrRkdsN29WVC8wOGRGSUZN?=
 =?utf-8?B?QW5UeG14UUZlODMvZi95dnE5bGxHRFVETDR0S2lwc292MXBmaU44Wi9OUEth?=
 =?utf-8?B?RTBSYUdud0lLZWdNUHprcnRBb1lYa3R1dVlEZ2lPdzJJMzJXeHhvOUhSOG1H?=
 =?utf-8?B?Z282Tml3RzJUT1liS2pOOE9EZkNlRlIzbW5MdkNuL3RKUWoydTExUWNHTDFQ?=
 =?utf-8?B?Z3k0Y2ZNZGtid0wyTjZBakZZMEEzU05wb3orL0JYeElEVzhOb0NPdFRJRkI2?=
 =?utf-8?B?enhyTEh4ZVZrb2dOU0ZMeHdhSkhWQ1NKNDlRRUFTdTV1SmtZWlVZWUdyY1hy?=
 =?utf-8?B?Z2VMcUFFSFJIYmkyVC93TE15QmUycEFDYlNuSUtrWkk2QmxuVGhFRHVrVGRD?=
 =?utf-8?B?cGxTMlk4Q1EwUzlBVFR2SGVFd0ovZ2xlVzBDbkswYW5YWDZIT0NHcUJXV1RV?=
 =?utf-8?B?N2VWYnlYTFFiVnVvSEQzUWFlTFppMW1lS3JnY3VMZExtREYweWJaaTIvOThz?=
 =?utf-8?B?WkdEWFIvYW0wMC9qbVFZNURtSWFRMG1Gb1hOMmp1M2JNRnd5MEFvRG1qZEdx?=
 =?utf-8?B?K2xXUFBkV1lpY2M5ZTV5VzBZcjVuYnUySVo2R1AvV21YdzBBejNQMkhmaFdK?=
 =?utf-8?B?cmlhcDR3VnlnZk1MTHhSWVZidkpGVkZKVGRiT2Ftd2ZPL0VkZ0JGbVV0Q3JI?=
 =?utf-8?B?dUU2UmdKQVEzUHNSNFlLZmdQVmlVRzhpUk5MYjlCbnlqQUFIdGxhd3pnbkkx?=
 =?utf-8?B?V09TTVVaN0VxNVpvMS9LU2JsVms0S2Jtd3JWR0JlM01UenA0c0VIYjFiQTUz?=
 =?utf-8?B?THNLVW1zcnBvcElESlkyQTBkOTU2bXo0VE1rV1hYM0h5a2JOR1FUcUk2bmIr?=
 =?utf-8?B?TktRSEZscDVxaFVwTEtIMU5VcUZvUW0xUzgvYnY2enE4VHprcitzdEJBV3hh?=
 =?utf-8?B?L2FaelJuQ0w3S1FyemNQYVBCNGZUaU1ETndkbFE4cUdRRWVlOVNaUlE3QXpD?=
 =?utf-8?B?NnVkbkRxemd6d3RwYTgrcnRoVCtxclY3Zm9YMjgvTFM3MitJUVdyNlljMjdn?=
 =?utf-8?B?RXhtVjM4YVlPMDIwbC9jdDNmdEd6RHlPVTE0Uk1zbFUyUm9ldHJHcUZwMUFh?=
 =?utf-8?B?SGU2WjBYOS9jS3YycFR3ZE5vVXAwdVArSkxGLytnMTNjMS8wZFBvQWlmT3lP?=
 =?utf-8?B?Wk1qRS9xemlpTEFxRzJ2RzBXZ3JTZGkrU1N4NnRyMENTNWFnWE10YzBNOUJY?=
 =?utf-8?B?ZXBjWDNwdWZzOTMwNFU1bldWL0JXWERFWGlyVXlrWHZqcXA3L0RSM1I4UVhM?=
 =?utf-8?B?Q2xZd2w2UnpuL0xHZzNVOEFNaWt1S0puSEFSbnBXMDYwZWM3VFZMUjhZZCtx?=
 =?utf-8?B?NzBLaGdodGtvMzBQWkE0UVhOdGVRSzJUbk5CZzBCby8rb2ZmczZWOEhvQjQr?=
 =?utf-8?B?OUUwL0ZScGZsQVRJMVpoNzRFSHVYcE9ubmtUSFBHUTJPT2tJY1BXNXNpY2h3?=
 =?utf-8?B?YzBkSkk3Y2c0VE44NVVHRmdidExzcWY4R25udnUwMllNaGJDRzFFRnVKcWR2?=
 =?utf-8?B?V1Qwd2c0RnkwaG8wejFOWDdHYkxoeUlkeVJubXBZd2Ura0J4bXNxY0dYc3FZ?=
 =?utf-8?B?cUlzbFdvalcvUnV0ZmpVSEtJaGhxbGl6U2dNZmg2WHlGdHJ3bGR0UUNhY3A5?=
 =?utf-8?B?NDZ0WXZEUTd4ZnVNVURkZnkxTEJWRTRiY1VLeGZVeUo4K0xYOFdDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b7cd0a-4f9d-4042-3a75-08de88e42541
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:57:39.4488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM1SaDpzlFfvVPCS4aNMqH/Psaw1WblY+jcOqE0ryXT6EOsTEA7zUirVrINHRt1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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



On 3/17/26 17:26, Michal Simek wrote:
> As exposed by "make randconfig", CPU_MICROBLAZE uses select to
> force-enable XILINX_MICROBLAZE0_PVR, but that symbol depends on
> TARGET_MICROBLAZE_GENERIC. The select bypasses this dependency chain,
> triggering a Kconfig warning:
> 
>    WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
>      Depends on [n]: MICROBLAZE [=y] && TARGET_MICROBLAZE_GENERIC [=n]
>      Selected by [y]:
>      - CPU_MICROBLAZE [=y] && CPU [=y] && MICROBLAZE [=y]
> 
> Change XILINX_MICROBLAZE0_PVR from select to depends on, so that the
> CPU driver is only available when PVR support has been explicitly
> enabled.
> 
> Fixes: 816226d27efa ("cpu: add CPU driver for microblaze")
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/cpu/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
> index 6a96be94de49..c805c0bbfa19 100644
> --- a/drivers/cpu/Kconfig
> +++ b/drivers/cpu/Kconfig
> @@ -35,9 +35,8 @@ config CPU_ARMV8
>   
>   config CPU_MICROBLAZE
>   	bool "Enable Microblaze CPU driver"
> -	depends on CPU && MICROBLAZE
> +	depends on CPU && MICROBLAZE && XILINX_MICROBLAZE0_PVR
>   	select DM_EVENT
> -	select XILINX_MICROBLAZE0_PVR
>   	help
>   	  Support CPU cores for Microblaze architecture.
>   

Applied.
M
