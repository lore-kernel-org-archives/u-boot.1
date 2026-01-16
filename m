Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E9D4A609
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD08F83015;
	Fri, 16 Jan 2026 09:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWEVRSEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAA1830E4; Fri, 16 Jan 2026 09:17:20 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F050980077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo+pdNDfkWcH/mRfGKH3+WERajPq+Nha3zs+XOua6W8xicq0MehuciUms589mTCCEbkIgxjCh9QWSpiLSjDNdXCzJQKNuXKzh7Gh4b/eB1CP3sxRqGibxENMzxO+L4zFkKr2W1M/omUNs6+En06k3zAs866TGCCpXEvF4k3GuFcviDlzQlIYiK22HAkw14s1suP/VvRfD3/DZO4OBuNc2quWLCqqVuk3uIQwXiqiSYd/Gb5XQrYkv7GQylyKlM4JAYGerZm3xcjfjTrRTLIbD0YuVdSwBtHf0Hz8sA/c7LDC03FYqjhdwJKQ4bIcb2x8AFmqovGydFSHeQypLGv5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OLU7akXRDXynCddzDOi1x32rRGBjIzRUWXPrTDWk4s=;
 b=GMPGhtHyqkv0SwO03Th68myv7BS1tUpUobxvs5G4O5tJYFPxeRlO6pKq2H4O4sce3v25TufqodvGmVHzpRblgnlBrQhd9isGRh0MkqJUj5nu7L3A0KdTeXensIAXZPzRKsWnZKnpTt3fYJKAV8rJaeLyRJNsP4JizV1I9NWI3nKiWcbh74FbpSPTMi5dDIGCObm5IFxLONmgSQ0+QeNonDup/kEW9i6dkBghcu2wqpPHbVMU9vd10ESSFwRo9yWUQ8sSLjZOzfXpRpS4qv1b7xO/kxhB5+RYeL/qh/QuTmmMxPhZPUfd4gSK4ELaN83XKsdTJ5tXT0v6872LsMhZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OLU7akXRDXynCddzDOi1x32rRGBjIzRUWXPrTDWk4s=;
 b=tWEVRSEnzGrgZzELEGGqOf4GPAD/X+/bHqWMbRNiumDUw6I3KzV2WiCWpd4g9h5ZEIYD9Tpf87p3PvJrS3ETirE+3/NfoqzQ5jOfuxVisuO9QWYMCXcK7XVmR196DdOxsB3CLmfs48c27N5UmEPLdmHVrGmldQxoxP+cJXlXanM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:17:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:17:14 +0000
Message-ID: <960bd4b8-3643-4e78-ae70-b29453ae083d@amd.com>
Date: Fri, 16 Jan 2026 09:17:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: zynqmp: Add SPL support
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20260106224202.754923-1-sean.anderson@linux.dev>
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
In-Reply-To: <20260106224202.754923-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: cefcf496-fd16-4ab9-51f5-08de54d7a782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTRQUlNDZUNRRFg5ek9KZjB0Uyt5Q0prUjI5K1gzNFEyYnZiWlNaMlBBQ1Nx?=
 =?utf-8?B?YXp2TFNzOHMrZVVkWnFsdlJJMHVFb0tDa2xqdm1ybjBjdHdoUWpma1FZQVpT?=
 =?utf-8?B?YVFrYk45OG5vZHM3SjZVeWpkNTlaZ1JzaSs1djhHMHp3Tk45Zm5IK1FlTkI4?=
 =?utf-8?B?dG9RbE1FdzdRUEIzdnVyUEtxT3pOd3dObklBK011KzE2clQ4QzhxWFUvelNX?=
 =?utf-8?B?cmRybUlKbWZSQnVCQTBvUmhjdGo4cHRCNXVHbUtJSVN0N05UOVhHdGlodFkz?=
 =?utf-8?B?djZkNmNaM3cyVXRhRkk4T0VhTDJ2Z0RmbklMVW1SenRoZnozaHhta2hoTFlH?=
 =?utf-8?B?VzVGbkhxY3g4TmpvR2JWOS9La3oxb2pPdGluVXdtSzJNdHJkd3J5Vld6b1Jk?=
 =?utf-8?B?ZERPdk00dnkwd1YrWkpHRnpmTVdyZVhla3g2VmgxTzBaYkNSUytoU1pTZWk2?=
 =?utf-8?B?VlJPTWNnbXF1cmdndndHNXA0bnZucGVxNzBRK0lyNFlCRzlaUFgrZzc3ZW96?=
 =?utf-8?B?Y1EyRkY3Nndac05FUkZjN2xXQXBlYmE5cUJWa25DVnVXRVdVeWNRODhHR2U0?=
 =?utf-8?B?NHlkbWlhc21RcHlWeURiZEY4aGFqOXBWYnhDMmlCNTYrWitJVGlNSkdUdGpl?=
 =?utf-8?B?aUVFdk1sdjRmdjB6Zngwc25nTEFvYVVQdDJoK2hPMlpHREplOEs5MXNkRklY?=
 =?utf-8?B?OWVRdytrK0RGTUlYTDY0ZjcycitpalEzdEI2R3hVVGQ5L3Z5SnJUUXp4MU5h?=
 =?utf-8?B?WXFXNU5KNlM3OTV2bldkQ1BRSUNESmFETjRzLzJrTHZLUmdsNnM2bzk5TnZp?=
 =?utf-8?B?U29CQWJjZEh1TCtzcC9USEJhZFpkZ3Q3NmJmU1hqaStzalN3UFI5eVh2TXIx?=
 =?utf-8?B?S2Qzd1hNTUcrTDdiRUpTZjcySWpCR3hic1FYL2hCRE9ET0U3T3NtSERMTk4v?=
 =?utf-8?B?NDVwOExMQVpmT0FMV0hEYlBheHZNSi9oYmwzTGMrNXA0Nkc3cVhES016eTlQ?=
 =?utf-8?B?ckZlNmlZemZDUDR4eG5wVU0wNDNmZXJLTnBxM29ic0I4YitJUmhjK2VVRmZp?=
 =?utf-8?B?M2hnTDUrNndsaWgxUk5NN1c3cWFEN1JVUG1ydktodWRUeThRcGRQc2hmOUtn?=
 =?utf-8?B?V3duMkZIVktWZUJpQTN5cTkyaS9GZ09ETkVwUm9ZZlFDd2o4S0l5Y0E4dGFa?=
 =?utf-8?B?SHlmUTZEQmRjcXR5U3J1M0pqSzR1ZlBHZ2hOUEQ0YWcrTTh5cEJPYlkrMmxM?=
 =?utf-8?B?WmdMWk4vREdETXc3RlF1aHNjN1ZHeVJCZHBnRXdWRmQySm4vQmkyZU9XalVT?=
 =?utf-8?B?UHdzY01SNlNqSEl6aVNFanlCcGZjVisvV2RXUlNsT2luN05EaE84cVFma1ZZ?=
 =?utf-8?B?elhkb1lBODlsSXhUZ20xZUdzeGZMRXBQbjB2WnRWeksrR1lvMWFqU0pvdS9L?=
 =?utf-8?B?SGZjRkZmKzRobnh5cjJTdWlqaDJmblFEaThxQSt6MFNSamxoa2RaN21SVVpH?=
 =?utf-8?B?SlZheEJLL3VJaHFvcS9RU3RYVmdHRkUzWVpVZDdoYzBIelBCUm9FR1BDNGcx?=
 =?utf-8?B?K1RMR2hCV2kwNmRFdFRoZm9rcy9wZjdLeHA3ZDFEU3JoeEFEZ1dvSFdQam15?=
 =?utf-8?B?ekEwV3dESXhQQW5ra3ZIVUk5ZHR1b3hhcnArR0xTZzk1RDVRUnRZTWFIZ3ZN?=
 =?utf-8?B?Uy9ucmNMOXk2bEV5YXh6MVY1bHVZUWxUU25tQm8wZFRFNzVNN3lkOCtCOUdr?=
 =?utf-8?B?aXY0NmdLdWlFemxmMG41RVMxWWtPcXZmRGdsSzRKWDdaeWhBeTR6YnRLdC9z?=
 =?utf-8?B?ekl5Mk5xSkcvMTRsMUJUR201aXM1MGFQZDE3eGNFaC9SMkl6S3RqQ3pHSTRL?=
 =?utf-8?B?RjRKMFNmYzlRSHNEMDdwcDExRjd1VkdtOVBIUE1PM3BmRldrZTdWRXIyaDAx?=
 =?utf-8?B?VWpQdit6NE5VcEpIQ1VnT1Zsd1BKU1JnMjJSWmorKzkxT0U4anRMeGVISXQv?=
 =?utf-8?B?WERNbFdFdXJ5NC9MVG43TnVkRmJ4dVE5NEpDK3YyRXMway9xMmEzVHZCUWV6?=
 =?utf-8?B?Sm42VWM1aXpvWjB1K3FUV0xhNE9KNjNOakN2bUdwVnozSGlYSGtxZ1M1RSt2?=
 =?utf-8?Q?Wpgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUgyaEVYd041Y3Z4R01lelJuMHY4TThidElSaHRuU3c2d1BTM3ovM0doVnJT?=
 =?utf-8?B?RWQ1cW0zeHZVRnlFZTZwRjJDVG5pd3lKaWdSMmVkS0xOUXRZTmFUZDFxL2lj?=
 =?utf-8?B?UU9JUXB5TkhFeUpFS1UvUU5pWlpvNDg3WkIzd3Zyc0I4MEU4dEc0eU9HWGN6?=
 =?utf-8?B?SDd2YitMdUpHSFF2UWNzMExsQlBkb0hGVEo2SGxpcjdXOExiem16RFJINjgy?=
 =?utf-8?B?ekpwSDVXTktjMFc4cVlEYkRzTStjalBqRndYYmhIVFo1dktscmZ2NWhOVkZw?=
 =?utf-8?B?K0VrTGwzVzZsMUQxWFBBWlFDcDBsSjJSUkp2a0ovU29xV3dnNTJMaStCUHVD?=
 =?utf-8?B?OWUzNHhUUGRyUmYya3ljWFcxVkZzUU5rbzQ3SzVnblN6OVNKaTd2cFRrWmRo?=
 =?utf-8?B?SFkvbHFHbXVKZXZJS1p3cXBlNGVaSnJ5eXd4N0d5NlJyVEJFTkJ0Q2RkZHVP?=
 =?utf-8?B?QnM4QXorb3JiNEhvVDAyZ1lOMWdNckJnc2xHNGQrb1BnTGpIdXJ6U1pIV3BU?=
 =?utf-8?B?anBYblJQYTlFNWRqeTM1T0VKQ1IxVm9FOEpnRVhNcVpvRXJiYzR6SVF1U2Fn?=
 =?utf-8?B?ZTVob240Z1pVOWt3cW5HazhRbGhNKzFGVWtRaGdOMkJ6bkdEUWlCUUd1MVhn?=
 =?utf-8?B?bHBPZ0E5V3RuZWdOdkRlT1Z5THJIb05yYy80eS9SOG5wRU4wWGlPY0E4dnZk?=
 =?utf-8?B?L0xGNklOOHdBSUIxalNHaG5tTjBTaVNvSXNqdEVTK2RzL3VwMFhxWW9ydC9x?=
 =?utf-8?B?clB3eTYxMzZhdnR0YVdwVmw0NFgvN25TYWdoYlNpcmFhV1kwTkRRc09JK2Rp?=
 =?utf-8?B?UFlkQzNSZmJscHRZR3BBZGo4VFRDTm53Q3VGTGJGSWMra2djTFJ3RzcrTnov?=
 =?utf-8?B?SlVoa1YzU3lqM0puQXBaUzlMdW94QzNZUHE3VnA2cUx0WThuM1BuQThodUhK?=
 =?utf-8?B?Mk5TekpzNnFZOVRTZ1d5K3dwWDhPZkhGcVlETFlkbDhVRHZaQkpwcVVPcnUy?=
 =?utf-8?B?ZndJMVhlNFNlVG5OdEtqR0xBSG5uUzlRSFFjbllrZHlDQUZVVHpCU3NQc2Vn?=
 =?utf-8?B?d2RjWmZkV3Zodm5qNDRIblRDbUNvWlYxbzgvam1pOUpVU0VEVExLdkhnai9T?=
 =?utf-8?B?dHpHb2hNTW1LSDN0VzFySGFKRUlyNjIrQ0RHY1RsRDAveUZsaldqeldPaFZI?=
 =?utf-8?B?eFNKRms3UDlBWW14YkhkY08rMGRxVU13NjRIS1VrTXV1aFVQeStHbVFobSsv?=
 =?utf-8?B?YmlVMDhzNjVWU0xlb09iamtpc2x5dkZ3bXVXOGh3T2w0ZUcrczU1cjNZSndP?=
 =?utf-8?B?V2cxcmIybU1UYUZHWUd1bFJ5UTlQbkdmU05uY3dqWStjYnZNc2dJSGEwTTV4?=
 =?utf-8?B?Wk9xS252eUhuN3p1SEVCVm0rakpWN0ViOFRBNjJHR05NZ3dPNHZJc1hHMzJY?=
 =?utf-8?B?RmEwS1hMS01pTkxIOWpIWDE5R25sNTJ5TWRYakt5Y29Cbi9mZ0lVZnlRQ2ly?=
 =?utf-8?B?cjl2NE5XQ3p4cTNRRTNaRVkxK0xTK1FlMm92VVkyRFNjTlJIRTErM3kveVFT?=
 =?utf-8?B?ZzJORHBvWmhORzhhRk9jZkFreEo4UkhPV1F0Z0JweHRWeU9ncktiaUxJLzds?=
 =?utf-8?B?dG13cncxMnAwVDg2TnRBQmZXL2JxUnM0eFBBUnhRdkhYS1RiREp5OUR4M3Vz?=
 =?utf-8?B?ZjlHTEs3MDM1blIyWVdiVmh6cGVQeHBqS1gveVFZaXBlUExBNTl3b1UxdEtT?=
 =?utf-8?B?ZDFjWXUzbUE3elRxV29JNVNEeHVQeGEyS1ZBKzN3aGE0UXZURVI3V3pWWFgr?=
 =?utf-8?B?WURNeTJDUDdBOUZEMjBXQTVMditGQlRFMWFZai9yUXZraDF2Vnpld29BTjY0?=
 =?utf-8?B?ODhMeUsyemNGK1Z2Q2FMcGw4QU56R0dJYkFyQlJacFNNMVpsYkdJSlRZQk9q?=
 =?utf-8?B?ZDNRZENzeVF5TW1aS0Y2dDZwNmx5YWo3aXcwZ2FqQ2ZRT2pIUnVKdkpqMUVK?=
 =?utf-8?B?U3RKV3RnUjR3N0tOaWFSMlJMTUFzMzVQRkxQTTdrWU1IR0o0L3lDaTFHb25U?=
 =?utf-8?B?TjhTalp0TDBDbUdMUWw2QzdpbkdsaGhBbFlhQ3hjRng1elVGdWhJMXBOTFBa?=
 =?utf-8?B?YkN6VWpjZnlxSWZzWUY0MkVZMVBiU1VhWU91R1lFSDlVSWlUV2xSWTF6enFC?=
 =?utf-8?B?enhZNURDNmlwNUNmMjFLc1FhSEFXUmJwK1Y2NHdZSEpSWFAzeUE3c0cyaEdD?=
 =?utf-8?B?bEJ0RDFTSG5VVVNoWW1Xdmp5eFV0ZDhLd3RzandqQXJEZ0ZNTCtCMFdpbWFX?=
 =?utf-8?B?SFFQZEl0OE54MkQvNENJclcyODB4VkhBcnUveUNJUnJEc2dhdDRPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefcf496-fd16-4ab9-51f5-08de54d7a782
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:17:13.9516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwjoUxrqDv56sd3gBBtgWFWuJPL7EpDBoOhD69DPYno5Gi2FJak/Kz40O8n3Sw2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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



On 1/6/26 23:42, Sean Anderson wrote:
> Although the pinctrl pm requests are implemented in the PMU firmware,
> PM_QUERY_DATA is actually implemented in ATF. In SPL (or when running in
> EL3), ATF is not yet running, so we need to implement this API
> ourselves. Do the bare minimum, allowing SPL to enumerate functions, but
> don't bother with groups. Groups take up a lot of space, and can be
> emulated with pins. For example, a node like
> 
> 	display-port {
> 		mux {
> 			groups = "dpaux0_1";
> 			function = "dpaux0";
> 		};
> 	};
> 
> can be replaced by
> 
> 	display-port {
> 		mux {
> 			pins = "MIO34", "MIO35", "MIO36", "MIO37";
> 			function = "dpaux0";
> 		};
> 	};
> 
> While this isn't backwards-compatible with existing devicetrees, it's
> more than enough for SPL where we may only need to mux one or two pins.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 100 +++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index f8a9945c1da..77911757177 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -427,6 +427,102 @@ U_BOOT_DRIVER(zynqmp_power) = {
>   };
>   #endif
>   
> +static const char *const pinctrl_functions[] = {
> +	"can0",
> +	"can1",
> +	"ethernet0",
> +	"ethernet1",
> +	"ethernet2",
> +	"ethernet3",
> +	"gemtsu0",
> +	"gpio0",
> +	"i2c0",
> +	"i2c1",
> +	"mdio0",
> +	"mdio1",
> +	"mdio2",
> +	"mdio3",
> +	"qspi0",
> +	"qspi_fbclk",
> +	"qspi_ss",
> +	"spi0",
> +	"spi1",
> +	"spi0_ss",
> +	"spi1_ss",
> +	"sdio0",
> +	"sdio0_pc",
> +	"sdio0_cd",
> +	"sdio0_wp",
> +	"sdio1",
> +	"sdio1_pc",
> +	"sdio1_cd",
> +	"sdio1_wp",
> +	"nand0",
> +	"nand0_ce",
> +	"nand0_rb",
> +	"nand0_dqs",
> +	"ttc0_clk",
> +	"ttc0_wav",
> +	"ttc1_clk",
> +	"ttc1_wav",
> +	"ttc2_clk",
> +	"ttc2_wav",
> +	"ttc3_clk",
> +	"ttc3_wav",
> +	"uart0",
> +	"uart1",
> +	"usb0",
> +	"usb1",
> +	"swdt0_clk",
> +	"swdt0_rst",
> +	"swdt1_clk",
> +	"swdt1_rst",
> +	"pmu0",
> +	"pcie0",
> +	"csu0",
> +	"dpaux0",
> +	"pjtag0",
> +	"trace0",
> +	"trace0_clk",
> +	"testscan0",
> +};
> +
> +/*
> + * PM_QUERY_DATA is implemented by ATF and not the PMU firmware, so we have to
> + * emulate it in SPL. Just implement functions/pins since the groups take up a
> + * lot of rodata and are mostly superfluous.
> + */
> +static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2,
> +				u32 *ret_payload)
> +{
> +	switch (qid) {
> +	case PM_QID_PINCTRL_GET_NUM_PINS:
> +		ret_payload[1] = 78;

Macro for this value please.

> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_NUM_FUNCTIONS:
> +		ret_payload[1] = ARRAY_SIZE(pinctrl_functions);
> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS:
> +		ret_payload[1] = 0;
> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_FUNCTION_NAME:
> +		memset(ret_payload, 0, 16);

Where is this 16 coming from? I expect this is max number of chars of function.


> +		strcpy((char *)ret_payload, pinctrl_functions[arg1]);

you should check that arg1 is between 0 and array size not to read value behind.


> +		return 0;
> +	case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
> +	case PM_QID_PINCTRL_GET_PIN_GROUPS:
> +		memset(ret_payload + 1, 0xff, 12);

Where is this 12 coming from? Macro for it.


> +		ret_payload[0] = 0;
> +		return 0;
> +	default:
> +		ret_payload[0] = 1;
> +		return 1;
> +	}
> +}
> +
>   smc_call_handler_t __data smc_call_handler;
>   
>   static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
> @@ -493,6 +589,10 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
>   
>   	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
> +		if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
> +		    IS_ENABLED(CONFIG_PINCTRL_ZYNQMP) &&

This logic have to change a little bit.
There is also CONFIG_SPL_PINCTRL symbol which likely needs to be enabled. But if 
it is not still this code ends in SPL and just extend binary.

Don't think you want to support running U-Boot out of EL3 but if yes that logic 
should be adjusted in connection to CONFIG_SPL_PINCTRL.




> +		    api_id == PM_QUERY_DATA)
> +			return zynqmp_pm_query_data(arg0, arg1, arg2, ret_payload);
>   #if defined(CONFIG_ZYNQMP_IPI)
>   		/*
>   		 * Use fixed payload and arg size as the EL2 call. The firmware

M
