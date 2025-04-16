Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F32C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3673482E38;
	Wed, 16 Apr 2025 13:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QE8rWsHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90CA82E3F; Wed, 16 Apr 2025 13:46:46 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C53181F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBy2wQGnsWz7iabf4daj4n36tlfBbJaIZ7MqWzw7GCmPmy+vczsXgzTRSL80JTTFxrj4+qlFGdqmi4mYksGBxxcANOWk2F5D4SQtAFAVjTy2areLemKjwryN6Fof7v9R3EtvbifBeDlDdxCafzIVpKqsmfWXJYllUFVdWvuMz91g0KatVFKBqko9FOJHmZhuXgHfERfeLodY02ONRlCU6e6VNXSsshDOPn6oP/kRG4u7EkqtO7/zGH/hIX5DLbq71rfZdg5537rmCe5/8hCzSSBriog6rCce89QVpTtlf9b6s4rl3iPjNAZ87vquwj0ntd/FWivB0gq7S6S3ikuQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Wt7VHKLAH479wjhdxInZqMDMsMTy8YNKeaW3HSK70=;
 b=RXV/fwk91hO3j/PlXSnj+OM72NqLdFYGWLAC+N04HS8O0kAeCjFDQb8T27DShrE8W/3oExTXnJP6Y8x1OGsBy882bdGmVdBsjqhJZbZc/+fnNoXxVL2HeB3+acNNq2GW1TfjU8nFlvjc9pAF0hPuGMme2m5nPBWyU99THqr/JX0yczwQZmNfjrO7B2fReMyUJrAYPzpsV3r3/PtZlatg4YF9D+0KGCZErB5LB1EtpDVikGlQNiK99wd0Jb9INEFYyLBro1hWS1pCTobuLDwf89T/cbwDRnuLxBC1yFikCBQN3qLXDrmLA1abZihv15NjqmL68D4sP3MOigXdjItPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Wt7VHKLAH479wjhdxInZqMDMsMTy8YNKeaW3HSK70=;
 b=QE8rWsHZvGWBiPVNn18AMoZYZWgKZpsqS4rQCEcQZkI4oXXyFlLqq639AxfW6wAJriAGUND0GKqDIqSuF/n+XY149LEONFdIwbaCR7StGZ4hJ66EFe6m6aiPYmgZPtwAWpZQAOEcN0rTMSHDZE82NvNXAiAzrPjKgNFPCsJjBGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:46:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:46:39 +0000
Message-ID: <10778457-8b6b-4ecf-9e62-0762c76ea5b2@amd.com>
Date: Wed, 16 Apr 2025 13:46:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Update the number of DRAM banks to 36
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250410092528.3713904-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20250410092528.3713904-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0348.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbc5311-3bd6-45c5-57d6-08dd7cdc5948
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFpyRXhOSm1jLzIzNnlLcFFGZ2NlZTdtaVVaSTl3d3p3c2FlVm9pN3RyNG94?=
 =?utf-8?B?YVNoaUxwTG42R3JHYURQN3VoSG1jWDU5ZnJpZkwySUt0M1NsNmw1NnRKbWtC?=
 =?utf-8?B?dkJUdmJqV1Q1N0VqZnRrbThpYjhGYjhrYzZ4bE15NUgxekpaZ3oraGJtd05r?=
 =?utf-8?B?YVUwTTdsWmFOMVRaT0JzZGhNQnY4V0l3d0FJSFM0c2lkZ01ycjdBZ094YWZ0?=
 =?utf-8?B?UHFBSDZQa3krK3dsakhwOFcwYXV2ZkwwYUl1d3I3WWxGb1RGWDl3ak1hUVFq?=
 =?utf-8?B?TXMyZElHb0Jzc0NCelBWYk9kVEFMV2pCY2t1djA5endUcm5WVlUwZVVobmdR?=
 =?utf-8?B?Qi9pQTJHQ0hZQldvVmRQRVh3Vjl6bWpQSy9HMEEzZTZJbFFGTk5oaysvU05w?=
 =?utf-8?B?QjIzWjFJYXo3SzRyWVRLai9nbkZKaithLzdBRFU4dzJLWWd6Q0NORWZteWJt?=
 =?utf-8?B?aVhPd3JGa3VCK0tSVzdSSFJjSENtTTVaM3V0OWtYSURJVHF3L3dBTTA2TXJX?=
 =?utf-8?B?dm4wZm12czBrM0xxbTN0dlJ1L2dGdGw5aWI3ZFQ0a0VyVExFRTRzRW53VCtq?=
 =?utf-8?B?VHpIcURDd0JKazVVQkxHWDdzMEVXajdLZTcwR3NZRXJmQmx3S21LeG1wT3dt?=
 =?utf-8?B?SDE0Zmd3L09DMXFQVEJoM2NjUVZVbVhSUyt0V3paVlVEZk5YanY3UWR6U1M3?=
 =?utf-8?B?TGY4U3phOEFPNm11UUtPT3JVOTIrNi96SU1pR3VUOUxXTmcrWER6MFZRbmVk?=
 =?utf-8?B?MXY3QTRLMnhSNGczQm9GUW8rbG1oNEFObnB0Y1J5UmVsNlJneEx0blY2VU1Y?=
 =?utf-8?B?ZFhXVWYxYzRROUtYZkljNTYzMjRiK0pJME4ycmNoRHVaK1VTSEdkdksxVi9N?=
 =?utf-8?B?T096WTZEbzZCN3J0RTBWUDhRWmVQYXh5elhQdkFoTGpQREJaUFBFb0orTnhk?=
 =?utf-8?B?cnd0RjgxMGw3ZlF0MlUyenEvbFQxb2NKM1c1cW90WjF5MlBDMmpIcmx4UmV0?=
 =?utf-8?B?RHFEekYyaEttS1A2ZHFnajEzdWlhaExUcmpJdUVQNVBYSjN3NVg2ODlPSCtL?=
 =?utf-8?B?bnRXbG9jSXpqZFg5aEl1cjkraGJZTnNnK3FLYUVWOWxzUGs1VVpxWVRLeFhy?=
 =?utf-8?B?ekxQQ3ZvM1dpTE1QWmduUXV3ZGZTVG1jUUFKK3IrWWdmRDZydVFxUkgxbWV3?=
 =?utf-8?B?dUQ5UzVFRzRJMzJpOUlUTnl2VStqMjlpTnR2YUxpSlRoajljV0MxSGgzYUZz?=
 =?utf-8?B?VDFnUXhWdVQxc1lsZUJrSVJmb2gvUUVPN1VpTnFLWk12Yi90K3I3NWx1SXRO?=
 =?utf-8?B?MEFMcGhnSVIySTYrWGYxY09YbVNNTk1IUktRaG5PRzQ3N2JSY3Zyd1VGVGJ2?=
 =?utf-8?B?WWNBd2llUmhnaGM0dnhBSFcrdW9iUDB6RDJQWW9TQkg3OFBad0RmNHlkbHFS?=
 =?utf-8?B?WFNLeWVMejN6ekx1TWprTEdzeTRIdWoyQkVRSEc3L0RmRlk5d3BYZ3ZLUEp2?=
 =?utf-8?B?ais0cUtBT3FzaFIxTEd5NmdMK0lOM21tdmZuQ3lPaFB4TXVnQ1hkaDlVY1Jt?=
 =?utf-8?B?dzNJUzBhSjdVaitEa2ZaOFYvTjdpcjV1d0ZoamkrbVVVRFFkUk5sRC9LSU55?=
 =?utf-8?B?Q0JzWW85bDFBL3VSQWdNcGwxUEsrbE1oRDVjUlUxQ0o3N0g2YVJsWVAraDNM?=
 =?utf-8?B?RmQraGp6YWdnVnlvVHV0NkV3bzVoUDRUWFBVWTBjNStKYm5mUUU2OTUrakxF?=
 =?utf-8?B?b2FxZlQrZVc5ZVRTdWpGak4wSEVHbytpRU5kTmVqQzV4L2JCbkMwcEcvYng5?=
 =?utf-8?B?M3loejhTaXFTTTBEM28rWVJOVFFHeDdxRmxwY04xSlM1SytCSDFwbDZLY1Fn?=
 =?utf-8?B?VitpSCtlSGxpSmsyR1cvclZWN2cwanp3ajVsdlV4M3ZQTWRCNEN6NEFIOW43?=
 =?utf-8?Q?CUXHMSVhiEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmo2eUlncmFLdENuNVZXekFyTUVsUlpQQ2FwdTBrbVk5Q2Vtd0ZVYlFmTkxX?=
 =?utf-8?B?bzBnZVVtbThTYjNaOUFmMHZhTU5KaXA2dGpZWW1BSVZlWEN5d1ZGNDEwTkJq?=
 =?utf-8?B?eU82YUJpbXZXekd0eEdIRlBhc2Q4NSt1NE8wa3RzZStGVGdBR0tXanpnVzA5?=
 =?utf-8?B?eDdMZHR6Q2hRV2NqMkdnVDF3bzgwWFVIMCtmYitTb2NtdTF3aGdSZkM5MytT?=
 =?utf-8?B?REYvZmRWajJQeG5YclZNclQ1eUx0Z3FWejd4Zk4wYnpwQlVTR3JCUUt4MHBU?=
 =?utf-8?B?V291TDBxZnN6SFp2VjVQYklHT05XVCt4ZlR3U3gwWWw0VzBIODFlSlhnTHdr?=
 =?utf-8?B?QytlczI4aVJmNlZRMWJuRXU2eDBjWDZqRGU1VXVLWGdLaXZFaFB3Wll1S3B0?=
 =?utf-8?B?THVqYnNnR0V3T1RnZUhncldkMGNuemJuWXZ4aWFTUEtCbGUvR2pYRzdkeUZZ?=
 =?utf-8?B?c3ZwR0RmYnVleW1JekhPSkMydlYzWVp2Wk9xdzBmdWE2b0dKUnVwcCtJYzZ3?=
 =?utf-8?B?NTFxZFNiQ2FIbUdVMnV3UWRrNzltRWFCNFRaTk1hZ3Y1MDVRanpQcHREM0lD?=
 =?utf-8?B?bERBenJKenVObkNLWG5JOFlwSFZidVk2K0lyaUtLbUhLbmhWNEQrSk1renJj?=
 =?utf-8?B?d1d1c2hFVUwzNDVOY1JTVHQvalg5cVlVYW5nN3VTSnBZZHBEdzJjWWhUbFZZ?=
 =?utf-8?B?VWE4SFczTGlNRkdienhQTnVBSk1wVk80SExZZ29nWHNHNVh1WUlvU0R0emh3?=
 =?utf-8?B?NU92eGZxVGxYZG16SjUxL2dVTGNRbVRsQ0Fpd0RCT05SaVpYU1ltYlpOa2U5?=
 =?utf-8?B?cmNTU1BITlp1U1dNS1Nseksxek1BVi9qRlJ0eC9HYlhSYXRlMCtNSU9YRnFq?=
 =?utf-8?B?RDM2VDkwOWNaa2dRaXVzUDdmemdVZGY5WWwvMXF2UWsySzdaZFM2dVVGdkdD?=
 =?utf-8?B?Q1Y3QnVVMk9LbDUzNnZoVTh0WThPVUtFYUJuM3YrYXNyVXZ4Ni9JWkxuZ1JT?=
 =?utf-8?B?aE9KbmhzclgwbVFVTlZIaEpwdzdZU01oaU1JRVFVRnhCM1J2azFCZjdOcXlu?=
 =?utf-8?B?bC9kbUFLOGtvV2JJSVhLT1RaMnhGcW8yZmpxdlVTeE80NjBkVlBzMG9FdXZm?=
 =?utf-8?B?ZkpjT1VxZUNUem9kbHdJWXkrYm8yUTBEUzZVQlJEQVh1QWhhWXBZeHJ2dVZS?=
 =?utf-8?B?ZEF0LzRCSERhZGtPNVhXU2FBSWQ1bzJVR2JxUmtiNTFqa0daUHpLOEpjREZh?=
 =?utf-8?B?TjFaNHMzVFhpZ1p4b25XR3FNODVHaGlGaHNRZ0ZOSFVodk9INWlpN1JVS2ZC?=
 =?utf-8?B?ek5KV0RGM2d6aTRDQkY5WWV1emJ6MnExeG1URDVaTjBHRFVRbm53RDlUU2tC?=
 =?utf-8?B?YlV4R0EzOFBBTm5IV1ZCMDlGejJMbmFsRm9wL2xNWm15ZDBtb0I0VnFoclZv?=
 =?utf-8?B?eTlQRDZJcm1nb05MK0VwY2JSQ1ZSY3I1ZzhaUU8xTzBMRXJEdWx0cUFGSmJK?=
 =?utf-8?B?aVV3WVFoc1MyRUJJbUtaL0JGNkRiOGthNWVqSEw0Njd5ZjJ0R0FzRFdVdDZo?=
 =?utf-8?B?TEF5UVg4dk1UYzlPZG81czhTek1udDNVekZuTHJBZDJ6M2xKbTF2aG02dzZ0?=
 =?utf-8?B?azJZK25vYm83bDBKTldyYVppT2twMG5CbGF2bnVYMzZLa3lucFpHdlZBWjdU?=
 =?utf-8?B?bkZKSjVjb2E2TUJhMnlheG40UjB1SytlWGdNbm1xUy9yaU81K052UnhMLzlv?=
 =?utf-8?B?elNNK2VGTnVLb0xHKzhTbHlzL1M1SHIrempmd1RqaFlxVnpsUlZrTnJDN3dC?=
 =?utf-8?B?T1MvVXVkNVRvRTQxWHp1WTVjWTkwdnZiM0k5NTRTZElTN2twTEI1RzZtbzFI?=
 =?utf-8?B?Uzh6eGtwcTI1ZmlKVWJhZkRiRlh0Rjk5VWk2Ri81T2tMQUY4ckw0bHlORjhN?=
 =?utf-8?B?UElLOGczQk5tZVplODNncERhN3pWSTlqei9QK1R2MXo0RjdHb0NhbHFqdDND?=
 =?utf-8?B?Ny90RnhBQlRpcCtLcFlKYXc5d0tmSW1DOVFQTG1PcnlnMzFqV2VHMnBXMzRT?=
 =?utf-8?B?bUJ2TEhTU3dJdTRWOVMwbzdoV1RxRlBqNW9aQjAvODc5S3pvSkRnUy94c3Fq?=
 =?utf-8?Q?zfvT9JUketGi87HYPOHGQZ10c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbc5311-3bd6-45c5-57d6-08dd7cdc5948
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:46:39.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drb7IrxuRGbq3E0P+4bPriKA9BarmqcXdb1TcwyV/WEmEYjKSEtEg4dDbTkfE6Dw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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



On 4/10/25 11:25, Venkatesh Yadav Abbarapu wrote:
> HBM stands for high bandwidth memory and is a type of memory interface used
> in 3D-stacked DRAM (dynamic random access memory) in some AMD GPUs (aka
> graphics cards), as well as the server, high-performance computing (HPC)
> and networking and client space. High Bandwidth Memory(HBM) has total 16
> channels, one channel is divided into two pseudo channels which makes its
> 32 banks each with some amount of memory.
> And then we have DDR_LOW PS low, DDR_HIGH0 PS high, DDR_HIGH1 PS very high
> and pretty much there should be also place for PL DDR. So maximum number of
> memory banks will be 36, updating the CONFIG_NR_DRAM_BANKS to 36.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 9911caa0e46..59a817a2a85 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_ARCH_VERSAL2=y
>   CONFIG_TEXT_BASE=0x8000000
>   CONFIG_SYS_MALLOC_F_LEN=0x100000
> +CONFIG_NR_DRAM_BANKS=36
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y

Applied.
M
