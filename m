Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EFFFED9E7
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72098432F;
	Tue, 17 Mar 2026 16:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8iDxkHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456C384359; Tue, 17 Mar 2026 16:35:45 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F1B841C8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbtYsMyVOK53xSRja/NiE0jZntkcdRbzH91BTYsXAG2ivz162T8t2JKNsq7aWH9DusMh0AulFsTt3pN6ZU33wAhOpFYwl1+NMklgv1kvrvpIGOtRilmE7ssVUR9gHb1YQ8i41yE7mpDXmay6GUARFzr4c30Gv126kd2v02coxxo6+KFAlNYBHuHoDddDNqhGiTs3DYjsxxaHmJiURMD2iHZWnhfqsDjzjBHdOsus5rYgLhm0cyCbiHRTE+1YM1Qnus38Ys8xVmC/R4clQzUVrTin7Kp40HDtqg8WdOxTRpyvpUdyDPjBWEsifOXhLLSinIbW8LLLgMHFA775P41GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ula58kKv4kyZNbL4iUsGF1TazEYX2uXI6J2mSOjJhMI=;
 b=bmVP+1+TA6yTAcyonz2kJk9AIEoAz1WTe0cj4y/dXFIc4C/oowxBfeZDASUfcDufQcQGkoFufcFkVj870mjh7WN/uSs3MUr2ZrMRT6c6fyrKiv/5h1ClgRdu0NDaTQ+n2/j1lSqMrHKmAdA2tgPpnNcFwY+b5Ozx18uOCdgdsC8rzdZk7sGxywMyjbnqcrGgd8cl4jmdQHH9YbIXkKaktJJ25mXES1CQV1dPwGcyTOI6izeCY8s1GXVaWErEXWxQMGKhqjQuUmBiFvFZnAwMchGzKimtEueLl8sYplRu6MbEhKjO4DV5l15bLR+ksYpmleaZZAYhfzcao7xcauLo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ula58kKv4kyZNbL4iUsGF1TazEYX2uXI6J2mSOjJhMI=;
 b=a8iDxkHuL7MJRZMwNVVlOqOkclMc5ZKLX4PQ9QtUBm8hS+J9r2lK4x1Jeti/Ga4h6qI6L3eL3Eqn+RVBMO2n0UEDJFqXo/PGIaMYVZsYOqsQT/XQ9qiX2TYMJ8oSdPeVL3gQi1zV9oYg0ilOc+9cCA+F32rZrdS3Qz5x99b+mhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 15:35:37 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:35:37 +0000
Message-ID: <0f352388-4e79-483a-a4ca-2f14f4bea6c8@amd.com>
Date: Tue, 17 Mar 2026 16:35:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260317012412.4162279-1-trini@konsulko.com>
 <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
 <20260317144955.GC502704@bill-the-cat>
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
In-Reply-To: <20260317144955.GC502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0110.eurprd09.prod.outlook.com
 (2603:10a6:803:78::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aefcc2e-2e19-42aa-8f7e-08de843ad620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: U+fheHYNHGFhQlncHxXSWtVedXWVQjOjSu9vCcumixQScjhd1E4QnVB8KkaY1GPgt12O+VIOVCifFzGO92pIiJCtz6iY/R4Sv7+oezCDoPSO+Ddjzd26a6a+FsnsVzclUKa2oeZyjs6UvhHLFVgpWsMwZQC4lrCfN7k9DVhLabv/CTQFQwwnL87il4744gMiMOf0wKjmTpgS/o5nBaPsAG0eYjVOOlJaoa3hAWlyPC0EBWW0vYEpM/BCEKq7J7qHigItoOPsOu2qSje2YqPUkQTQK3ZC1ir8xmIdJSkZK1l0Bam2l41OFWz/VSkB6lN6O1GN6VJ5x9psKdrJwfNKy9hsKSZUbvnU4t/ixQlBJcxg9p8ICvlZgl5yP9kKKimTz3degsLGZHY6zWqGGdTYY6ucChZwWl6uCRYpmMmLLMJG08bofwLVjmfG9CEvH6BXz2wBwOGirz26hyB+qZaGWl3iNAYu+wK7CDMBHRjVbAPdPmTJzRVs0f+B6V24TetfvsRFPxCndFlGieglkEiwS7crBhReqL8F7lGS8Zzp6saNFNJ/7yt/zmnd6QPCVwWgIGiAjJ3U6Br2zU0/h6NikSQR/MKBwkKu1qaMjdMIDkA7DU7i9NxAYrl3BPPtnt7t0ePevDyrO9zJvykFTk2B32fIFhic0QPx6vVCFizJL8KLGohqC3qINLct8md18T7D2awkYW96g7L3xAo1IeI7YypYWndS7cg5gL+MRlMhgQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxZNVlPVk81SDFWbkRCdVhyZllrVTg0aFNJKzh0VXhZZXh6SVI1RGhRcnFV?=
 =?utf-8?B?YWRaT1JyZDhYdTU0L05XVEVOcC9SSkFiZnBKOTJxdnNRdVF2N0NVcUNzL3lx?=
 =?utf-8?B?bEZpTmEyVXY0eGNXT2tTUHVYY3V1cTk0YllITjVYVkd3RFhWTnhHOSsydkU4?=
 =?utf-8?B?Q3RqaGRLdVI3U0NUc2dzNmt2eFJXYi91UG1ReDkyQlYwaFRmVnhITWFIQVZ5?=
 =?utf-8?B?djRCNkpYd1lPUmNKZDhRNDU5L1ZxSmdtNXAyVXlVY2NPTkFaOGUrTlpnTE9o?=
 =?utf-8?B?enVFTnRORnhXb2RiSHBwZVVtNzBMSURHSUZjZ1U1QUJmeXdFdDdodUVIZVpv?=
 =?utf-8?B?TFQwWFJYUE4waUhvWjV6dXBWbTJRZzZLS1BGSzRFVytVSXhZWUlnWGFScGxP?=
 =?utf-8?B?bGlmRnRKaTUwNnRib1NkOXZjdGoyR29ZMG9QK2xxTFRQUU1BUEkvTy81OTFp?=
 =?utf-8?B?NTJVR3ZXK2FWWis3YW5yVDVjQ1I1K2pXZlIzNytLd1kyMW5GclhrdGNEOG9W?=
 =?utf-8?B?ZkVSbXdweVhXMmt1Q2pTKzVTckVyZngyY2hOY3pSV1VFRkY4OUpnVThOZlhI?=
 =?utf-8?B?NDFGVXU4djh5clhPYktiZEhSSVFnTEw1Zk8zK043M3hKaVhLTWdia09KVisx?=
 =?utf-8?B?R2xDTjh3bDBubjI4RHZTK2p5M05PSmNuaFl1Q2x3VTVvK2luQ3B3RmxBbFlu?=
 =?utf-8?B?UGxuelJFTytCZHVDbkplSTVoTzdhV1B1VCsvQ1IrQ203Qy80M0dlbGZrNWFZ?=
 =?utf-8?B?N2R6RVh6aTl5YTRrZ1RhNVFBbDIyNGpYMkJkaXEycW9seDZPcVVoTEtueDEw?=
 =?utf-8?B?T1FVS0JxZU85dzViQUhIV3JTSlA2NDk5Yk54VUlWcTRrSlZEb3BlUUFKUjVL?=
 =?utf-8?B?M2FPTWdvQkp6YlpJVFN0NFdJVjEySkxraDc5NG0wM2M0bFdqblpkYVVzS2dy?=
 =?utf-8?B?MmNFRW5WSHJIR2t0OUsvaDdtOFV4d3VlTEhKb0hyaGg5UnBRQ1Y1OVltRzhW?=
 =?utf-8?B?UE9PaTRwRVRldnBHVTB3ZFdiY094Z0Z3NVQzSHhLMXpoc0llM3RWaE9Db3F5?=
 =?utf-8?B?VHpET3NNNnJreXgrTFJtTXpycXdqRXoyTjhYb1gwSm5sQ1ZEYStmeHNNbEEr?=
 =?utf-8?B?cWVnS0YzOVJMaSt2R210TE1aS1ZJaE4yRm1hdHBOTXFVTk14d1VwTXRjZFlm?=
 =?utf-8?B?dFd0YVFtVkhGaURFOXhkY2tMM2p5ZjRydzRjeHVtR2IzanpoRUFjdTg5NWc1?=
 =?utf-8?B?L2ZoQWdOc0JsVm9OOWtMMndWSk9TNGF5bDgreXhDWEEyd0ordnIxNmUwdWRo?=
 =?utf-8?B?TEh0dmN5MFV6MGUzeVZyWXVtZmRCR3lmMlY5eUJlN08yM0hZeGVoR3pNckNY?=
 =?utf-8?B?dHBaVmh3Q0RMd0RpV2xaVjRWRTJ4NG5IeFdqUUlmeHkxVTErNllhQ0NvNCtk?=
 =?utf-8?B?K1kvemd3SU5VeC94QS85U3pVNDMzVEN3Sjg1WllNODZBRHFHN2JFZFhIM01Q?=
 =?utf-8?B?N21DaHJmaUJMOWVqVkV3OHdzbGJuakZRSXNZNzJZbTlrbEQ2UXNOUk1icTJq?=
 =?utf-8?B?OC96N3YxOXQvL1RMNHE1d3g0eWZQU2hZeWUwZW9tWWhTY3V0SVdGd2lHQm45?=
 =?utf-8?B?NVJJVnJ4OGdjSElaSDdCaGNsS1pPekxUZm9sUHE2ZG10MlRsYklLUVVtcG91?=
 =?utf-8?B?aWlwYXc5UXNnL1A3N1ZTaWlBaGYyRUpjTnN4QWpkSmt3Vml5YkhmL0lOeVpD?=
 =?utf-8?B?K090YkM3bVRVM0MwVi9SbHQ2MFJ3d0U3SGpSbkw3elptVXNYYVFaaTNvNVNJ?=
 =?utf-8?B?R2dYQ2FSWWp1bGhtOGZKS2pDTmdLV1hUL1A1ZzNQZFR1b3huU21LL0MvTWdK?=
 =?utf-8?B?WVp5VjNjYTQ1K1Z4ZVQrMVF6OEovYWdCeUZFMWd2ZkkyL2xnSVg2d0lnN3Z0?=
 =?utf-8?B?aVpQZjY4T0tmME1Qc3QvM2lucFl6YzRsWmk0VWltVmNDc05XMVcrS2Vpc2tM?=
 =?utf-8?B?YXFIL1FhRFkralVtcUJBRHZ1SUhXcnVXUjRLa3k1ZUpNekk3dnN2T1ZPZ3BE?=
 =?utf-8?B?YlJSN0txeG5nSnE0ZWV4c3crN0xabGhNQ2ZSWEJTaGRBM01rV0pLNEk4YnBh?=
 =?utf-8?B?Qk43dWd4dXoxMVRJenZTTXd3UHFEU3dnQXF1NGMwanFpV3VNeS9Xb3AvbzVm?=
 =?utf-8?B?VFFDbGlza25DR1BUeitEeEdYaE1OR3hvZFMvRWlvYVZrcjlmSi9WeGNkN25Q?=
 =?utf-8?B?VloxZ09KYWp5N3Fkejhmd0sxWjMwdVNqVXYramRJYXl0U1IrSE84SklPdHl3?=
 =?utf-8?B?RUFGUFhkYVNvS1dVNnc0TXZsbUFIUUdrQWVzcUM3dkx2azhnd3RyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aefcc2e-2e19-42aa-8f7e-08de843ad620
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:35:36.9564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaecZGesO7FBy87UPYxmxt35Hfxibp9jjxlDEl9czNz1bLnx9RrllTYstza34SyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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



On 3/17/26 15:49, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 01:06:15PM +0100, Michal Simek wrote:
>>
>>
>> On 3/17/26 02:24, Tom Rini wrote:
>>> As exposed by "make randconfig", some symbols such as
>>> XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC but
>>> have a transitive dependency on it. The easiest path of resolution here
>>> is that since there is only one valid microblaze "board", rework that
>>> symbol to be non-optional.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> ---
>>>    arch/microblaze/Kconfig | 10 +++-------
>>>    1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>> index 4261e5009fdc..16c55ddfd95c 100644
>>> --- a/arch/microblaze/Kconfig
>>> +++ b/arch/microblaze/Kconfig
>>> @@ -7,12 +7,8 @@ config SYS_ARCH
>>>    config STATIC_RELA
>>>    	def_bool y
>>> -choice
>>> -	prompt "Target select"
>>> -	optional
>>> -
>>>    config TARGET_MICROBLAZE_GENERIC
>>> -	bool "Support microblaze-generic"
>>> +	def_bool y
>>>    	select BOARD_LATE_INIT
>>>    	select DM
>>>    	select DM_SERIAL
>>> @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
>>>    	select MTD
>>>    	select SPI
>>>    	imply CMD_DM
>>> -
>>> -endchoice
>>> +	help
>>> +	  Support microblaze-generic
>>>    source "board/xilinx/Kconfig"
>>>    source "board/xilinx/microblaze-generic/Kconfig"
>>
>> Applied.
> 
> Please drop this for now, I need to do a v2 and I've found another
> randconfig that gives me:
> WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
>    Depends on [n]: MICROBLAZE [=y] && TARGET_MICROBLAZE_GENERIC [=n]
>    Selected by [y]:
>    - CPU_MICROBLAZE [=y] && CPU [=y] && MICROBLAZE [=y]
> 

I expect this is from cpuinfo driver.

M

