Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A32EC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 13:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57B580F9C;
	Wed, 23 Apr 2025 15:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFTvFLbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB6480FA8; Wed, 23 Apr 2025 15:50:45 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900828082A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 15:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFoaVwuHsBF0CLNGYz+afQ/EYMPdg9mxU0fA3ph1RIsS4sMLXpMmamWZEsDzYITJvhmjyC8hLztZ5r1nGkl1k/UL9x5gec1oTnwm/AQCIuJ75LZ/a4lHmgJYMSG/6Pfwv89CTJ+j499uT10L5KcwowZipyKBj0t0ILNyd+Sk0cNRvKaCUUoEi2fZYXN5/8sSs9cMWTUIUxhCOXhvOocrUQ+BFOLh2pnX7wvMejE5aR2Z8yUsV10AtNQES5d/ZyXuwwiOvfxTbSjePfSLJvCFarZB7LaVYCJYtWYf48wurPeMfBtpXGSN8oJXmE82JZFRYDu1H1iIMk1loFiufLV4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXGu2Po4URzjAZMPfF0DiYcPh3YPayMOAAZxrDKpizM=;
 b=sLruV6wq1K+nboSokZZ8Hg0lrshKbx6GMiqHsAIFopQWUGN8NK+BIgSEBKw/j3RGU1tuwFRGsGb5y5lhBXMBgKiOlzwctKIXK3E71X+VKXJ54EQzlsajvpMP529+95hHOKPW6X8hpmQsVsb503kl2KX85+1FZJ5J8fR6ETrygD7wytV1ux7SzhiUgtsyG0uN1AMGwxPbojrouq6Pkq7i2eRO5r4qjUtLJYw1XK8l3dHPrOCANqe5VwMQ4VbG4vK4oNf9PQWZmeZRJz++fIueZx0nzQlUV8DjhNt98NJ/OnHEPO9VidRdQ03PrZoGrWPVjvXEG9FNnkd4i/sstkLznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXGu2Po4URzjAZMPfF0DiYcPh3YPayMOAAZxrDKpizM=;
 b=GFTvFLbcVV6qY1V0c7TyOVbAwtKI7GJalgWXS3KAzJRybHRJB8eau86nRxmVMsZIrD8aWmv4p7a6LGc/6mP2aWg1ypNc4VkyOPdTRgBi7b15Nup/u4QmD3EAGi4o4LaoaLt6v2TPgE1ZfxAf5Anm/RCSDB6B/L6xc+GHY6U2bRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:50:39 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 13:50:39 +0000
Message-ID: <678c1b23-402c-45f3-95c2-96bd3ca3d240@amd.com>
Date: Wed, 23 Apr 2025 15:50:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Dockerfile: Simplify applying cadence_gem commit to QEMU
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, git@xilinx.com
References: <5061af5aef7e964431679bee94b7ccfd2579e521.1745412278.git.michal.simek@amd.com>
 <b6e719bc-58dd-46b1-a4c5-79f2a8848358@gmx.de>
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
In-Reply-To: <b6e719bc-58dd-46b1-a4c5-79f2a8848358@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: de16add7-709c-4d10-ea55-08dd826dd4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVlTSzk4am50VU5pdVF0dlA0eE5ENXRmY2dDc1hjTG9Sc3Y0d21UbVh4S0Nt?=
 =?utf-8?B?WUhYS0JpL215bjIvanlnakFQb2Vja0IvUGpiRWd4YWNYaEJHclMrZXJ6RjN1?=
 =?utf-8?B?RlkvVFBraU5QYjVKQmhWRi8yQjVta0pGT0RtVUlrMGpwMll5Y0xXNVR5by8r?=
 =?utf-8?B?TkZhNlZVbFhLNHgvVDdQSU52eDN0czVyOGlhaU9PUzNOaFM5TFprdG1LWG94?=
 =?utf-8?B?VWExaE9qdDlrRy9SZndWRmNWVUMyajlKRXFWUTJiWnRuMTU4TFFJbEJyNGJF?=
 =?utf-8?B?QjBIV1VlRmRPZjI3a2tFZ3UyclBERVNjc1lLZndPL0huSWFnYzRXeng5Vk1U?=
 =?utf-8?B?U0NEaVpJSmpwcEg0eHcxMW9rS04zUkg4b04yY0h5czdZMlQvc2Yyd1JtQ0Yr?=
 =?utf-8?B?NnUvL0RhZjAwWmhQcnhJcWwvbzlTblhwcTFtem5JM0JaTFJsZGM0cFpwUk5u?=
 =?utf-8?B?cGZHRkF1MVJwV2NIRVdaSzBtTUJBcGFpRjExSU02Wktxc1NublJwSXRPQ2tn?=
 =?utf-8?B?bnkyY0Y4Tml3eHRKb3QzWGlzN0NZMWdyckhyZFlTKzVQREVFaTVxYUNvaGdI?=
 =?utf-8?B?OHVZSU4zOS8yS003QnZoSU4xcnZWN2srV2dKUHUzOG54Wm56VWNvQmdDU2xx?=
 =?utf-8?B?NW1qY0hWa25UTEJnMldid0pMWlpwT0svdDBwektlOVdjY3VLQk1NalBldTV6?=
 =?utf-8?B?VE9CUUVFV1Npcm1jTmp3ay9Gdy9PbEtiWFFPSUVtL25wWjVrUldWbHhPZFZ6?=
 =?utf-8?B?SlpMeHRnRllkVVRYZTRtRXAxM01RN3VqZ25US3BrRENyWmpPWk8vVW9UdWdT?=
 =?utf-8?B?ZmJPS1JSNXp6MEg0ODczQlFZeGUwdW53RVFPVndIUkhVV01ONEdDaGowUSth?=
 =?utf-8?B?aVZ3Tzl0aUVlSStZY1MvbTg5U2wvMUNpenVnMXVQdEhseFNZc0tIaTJmZnRn?=
 =?utf-8?B?SSt5NHg4TzFSNWd4bDNkemNoYzE4a21mdnZQRTJvSXpBN3JDc09XOTlveGJa?=
 =?utf-8?B?N1Z1WDgwR1llMlY2d1FRSVNZQ3RBeWdINlc4Y1lkSXdJb0tjVXRMbk9ieGhh?=
 =?utf-8?B?VWxrNUNmbTVFRk02ZzhNSjlaMDVpVnB3dmJBbTZHTEU0MEJEWS90UzZLQWlq?=
 =?utf-8?B?c1RKN0tjeVpVOEJhamZTN3dBSy9CZVZvNWxUSUpEYTZTK040Ry9kZS9zL3hC?=
 =?utf-8?B?a0ZJRWJnQlVpQXZLMHdjbnExOUh6a3Y4cUk5ZGJKUUVwWWNkZHlWR1pJdTlV?=
 =?utf-8?B?Qk1XUk42SEIvZ2pzT2JySkR5eDJhdnlDcXFoZVR4dFlWN244QlFCSE9PanBO?=
 =?utf-8?B?VlJZbmNSeWlPT3lYeFdtTDk3STdCdyt3UUh6TlpSd1BFcmVUM3ltYjNFZHdH?=
 =?utf-8?B?Yk1Wc2dyMjJ6M0J6cUVzTXBkaUpId0NQaHlKWFZ1M3FUTkJPM1pCR21pOWNX?=
 =?utf-8?B?OUF0dkFaVWFxSXZvd0IvM0FhOGhDZ1ZaTk1ibEVHM294cldJaHZwZWx2dEpp?=
 =?utf-8?B?amhnMEdXVTBDbDBEeE42T0VFMXB6QjhUNVViVlZjVTl1dWxFbGJpMnJpSjZ6?=
 =?utf-8?B?OGNtZHlTWVl1UlNrSTJSd3hNTVNXc0lmOEVVME9lMEZ0TGdERDNxNGh2Z2V1?=
 =?utf-8?B?UTRIQUdCYlhKcUxoa2xQWGJERVRLeXNsbzVxK3Z2K3dVZDFIdDFHT3IrQ003?=
 =?utf-8?B?eWZkMnh2eGpzeXZzck50WFJ2d1pzUndTcWh4N3pPdDRESVdlTVZWVmJhUzJn?=
 =?utf-8?B?OUZDOFBRSDZxbkt5cXQ4VlhiU3hXVVo5VVhsS3FybVlYS1E1TXVNRlJZZ2VO?=
 =?utf-8?B?Z1BGNXJRY09aYzBCTmx1anBvcHFJNGxJeTdqNmRlRFhsOUtYaHg1MEQyZ204?=
 =?utf-8?B?Zy9iekEzZFU2KzhvS2RKNk1XdXB2cDZzZlFxcU5iWHIyQms2SVpaRFRZaXZO?=
 =?utf-8?Q?1NzREsSVSo8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFtZ1ErcEJwaWZkM3RLOXhxQ1JtTWhRcGt5VjQ4SFYzVDkwY3E4RVhod25v?=
 =?utf-8?B?dXEzZ1kxRFFJaFlYVGkrenVKMXJjeFNTbFBOeXNjU3pmT09sa0tUa1JOby9s?=
 =?utf-8?B?SkJtL1R1TEdibkM4WlkyaUJsZmx3ZHZSM3JoUS9URHVCWVdJTnhrMFZVcUla?=
 =?utf-8?B?WmtaZXFacG02UzJrblNVR3NzOEhqZExZNWs3M2ZDZWFCTmVoUGhtTHRpUTZN?=
 =?utf-8?B?T3JXWldWb1ZGSWl5NU03Y2dCS3kydTNrZUxjV1RzYldJdHlQMEw1bEJKSDFs?=
 =?utf-8?B?MTRuVmtkRC9IYzh1L1R0VEIrYnBlbHRWb0UzZzEyNnJwTVdYa3hPYzA3bkVt?=
 =?utf-8?B?RzltOE02UHk1aEh2akVzWTBBL0g3eFhaREE3V1hmaGZ6SDBHVExrUFNpSndp?=
 =?utf-8?B?Rms0bDVrZ0VqNzB3RGRpR3JkWjhtODZnOHlCbFAvNERHTU96ZGcxVGJiM2tS?=
 =?utf-8?B?eHA1WEpacXkvNG5RS0ppa0VBdXFYbzVWR2tKK1lIOGRVV1RRMVZrTGx2Nlgw?=
 =?utf-8?B?TDFxRVJDMnM5cklNTlNiVHZJME10Y0p4MTlQWTVHN1FSNHI3MHQ4SkhVWmpQ?=
 =?utf-8?B?VmR3aUJCME84SGtTN0RRRlEwc244LzU3MFA3N3NwQndBMzdtMkh2MTZBUDIv?=
 =?utf-8?B?V0pnTG1mcnRiQWNhNkVtc1Q1eU1iU2tXamthZFgrWVVUNjEwaFhMdjZiY0FR?=
 =?utf-8?B?ekt4ekdtdmVHZ3prYjJ5TUI4cjRZT2htVjIyazVWNy9UYmtWL1YvRlJNM29L?=
 =?utf-8?B?MjFLanhaRGNJdE8xL1doSWV4VmN0QzdER2JzUkJVYzhEMmdwQkdFU1NVc2lF?=
 =?utf-8?B?T3JEZ05OTGltNkhUVlczQlJTd0hMNXpHV3RuMDZLbXRCWEo5YkcxZEovVUww?=
 =?utf-8?B?UlJsNTIrOWRMS083ODRNSnE2R1hzUmtNRjJ1Mnh1cm1mV3NsZm85VjBYZldm?=
 =?utf-8?B?cmJNMGw1ZkRyTnZDRWtZK2JHczZrZ016Q0VLN2tzeWFpRkRHQ0o0ZXBaZlVP?=
 =?utf-8?B?clE4VCtPNW5YWEZ6SEJrVU16UU5kZlc1TStGM2VwSzd6WVpNdjZXLzhJQm5m?=
 =?utf-8?B?T2x3bHNCSy8rR2JmRXZwSi8zYWphTmFMNi8vaXRyYjhXQlRvTXhKUkhsS2xD?=
 =?utf-8?B?dUYyKy9TWHJXZTE1eXRCa0hNM3UxejVvUk43NUk4Wm1DakxLN3NaeVJjYUdo?=
 =?utf-8?B?KzRxR3VoL25ZRm14UnVMTTA0SUs1OFY2dFhZZFcyME5KbjNyVEEzcG5aSUJq?=
 =?utf-8?B?MUtlUVZOQU9NZksrVUlHTXR1Q0NYYk5JTTBQOElyUGc5MDV4U2FWVXQwV2J3?=
 =?utf-8?B?LzZTSlVKenNKU3Z0WmRBdkczbUJMNGY0cWF6WFp2TFZKYmlHNE1tM3F3S3BZ?=
 =?utf-8?B?eWNlUXliY1ROSVkyTkQ0cGRJZ0xTU2hKcDV1ZnA3dWdmNE5Zd2xYWUJWODF1?=
 =?utf-8?B?VTBHdG9seEZ0eXhnQXdjVEFHK2NYeS9QU25iMXBZYndnMHYvYkdEc3Y0Vmtk?=
 =?utf-8?B?OGtPeTJMakdWZkQzNkpwSytWZDFuYWN6ZjVRUkVHVXY2VGVTL0l4ZlBBOEZX?=
 =?utf-8?B?TmFlRlk2dkxrMU90ZlU2MmYrNWhja3MyeEoyZTFYTTlxYkp6UTlCclVHUWxw?=
 =?utf-8?B?WXpDcEFPZXh4bTR4NnpOLzNLVUFVM0JvUVQrdjhKMGpBOFl2K3lhVStvTDcz?=
 =?utf-8?B?QnpZeDVrM0tPc3pRbWlpUlIzYytkdWpLcW1jUGNaejg2MHBlY2xSRjl0MFZM?=
 =?utf-8?B?dzZzS2NSM0drTHd5VkQ3YkdBMndOdzU3cGxRZXZpL0FrSktRajRsZS9xVTlS?=
 =?utf-8?B?aGxWRG5xaFhtTzJSaXVvdmdmaFo3anhLTDJvcDcxNG5hQWtqM1lxODdwQnZt?=
 =?utf-8?B?SHdURm45aEJUd2ZhTk1teGlMTGdBdHY0MmNRcFRxTExsMDVRZFNoZXBhbnpT?=
 =?utf-8?B?enFpcWVMaEdBZzNYRnYyNkJGSTFleUUrQXVjKzZXL2l3c21ieVI0a3AxR2Q3?=
 =?utf-8?B?SmtyUW9DMHdHVFlsYnBFNkZwS0c1NHRnNmVrVWJjN29DUCsvaktvazNqc3g4?=
 =?utf-8?B?UDcvOGgvay9US3N6ZjE4Ulc2WlJlMXFmS0Y0WjBnMEVhbVpTeGpaNE1zRDFq?=
 =?utf-8?Q?a/Ks6uivye98Mj7RTj1Sq2btN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de16add7-709c-4d10-ea55-08dd826dd4f6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:50:39.3575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ3YqUfKYpVGm7DhES/EYPh90vMwQH8u6FO4he1kLTecmq01w9mqSSYd6HjjAp6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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



On 4/23/25 15:42, Heinrich Schuchardt wrote:
> On 23.04.25 14:44, Michal Simek wrote:
>> No reason to call format-patch and then apply it with git am. It is enough
>> to cherry-pick it directly like it is done by commit 074bfab54d83 ("CI:
>> Cherry-pick reset support for m68k for QEMU").
>>
>> Fixes: 50a907edbb2c ("docker: build QEMU v8.2.0")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   tools/docker/Dockerfile | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>> index a0fd174ff602..0aa9d3ab3a84 100644
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -222,8 +222,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git / 
>> tmp/qemu && \
>>       # config user.name and user.email to make 'git am' happy
>>       git config user.name u-boot && \
>>       git config user.email u-boot@denx.de && \
>> -    git format-patch 0c7ffc977195~..0c7ffc977195 && \
>> -    git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
>> +    git cherry-pick 0c7ffc977195 && \
>>       git cherry-pick d3c79c3974 && \
>>       ./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm- 
>> softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el- 
>> softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4- 
>> softmmu,x86_64-softmmu,xtensa-softmmu" && \
>>       make -j$(nproc) all install && \
> 
> This change looks good but we should move to a newer QEMU version instead, see
> 
> [PATCH 1/1] Dockerfile: use QEMU 9.2.3
> https://lore.kernel.org/u-boot/20250418025743.529973-1- 
> heinrich.schuchardt@canonical.com/
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Definitely much better. v10.0.0 would be also good one because it has MB-V enabled.

Tom: Feel free to ignore if update patch to v9.2.3 is applied.

Thanks,
Michal

