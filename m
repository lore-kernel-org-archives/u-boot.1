Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D4C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D844849A3;
	Mon, 29 Jun 2026 17:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wz3uqUEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5924849F6; Mon, 29 Jun 2026 17:25:52 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EAB84942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sArnYAOuhLRZDwxMYlxPJlEteBZrxGnvRFNWtb32vFNoC0B5NRamNBjbPOO3LWvT0Q1ljHUooQs3MGER1KUxCfOTe/+exaWz3HY2wNFCo8jdRqHyjoZGSLpEPJhelCpv2rT5y1sNZ35CrCWATf9oB3kSxWERMsLKZNnlQj643w2Hagw5ghsqCvg4kqvg/KYZCJodlVn119TUDtijEw+jk64bQNIewaoT7ARLWIfnQgNX1cRoUPrKh14PoojQj5LyRTavheewG7COmKPjbCdx63NCJghbzqawryPVHMzEgV03bNXduK5kN5Y8G/MZE7uIzxjo4LcK7zzT7kZMF9Xf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5oJqAZRGYykAa720Yha0+jg7xkV+6uuIAZ9HqUIgUU=;
 b=M106wE2ykHwyFxH8mBQH53+Rm67FDhDUfmhEUeD4kISC2sOKo2oHPoNo4w5TQ3jYFsVkmhB1TWJqJR5tUw5/0OozRBuvUe7UM4ENwienhzgW3l5jzcR+oKilQr7xbkiEyDzkWcrSQloZL1anR8uWZ1RIwN2u7iDNCdl9XUdIALNamX9OPWOtNGFCPqq4sAebKIqOc4I0HR6kB+aoA9Kv53+FlJFT29YfjLA7ie5EloFYxDTdltzcHTwMSc+iBklGD5bpExBf0M3EtcCe/EmoOpiy2az7nDg/AmSEFdXAIHqsmQmFO4XjARBzX9F+w/csxuNq+FwxA1vibXjEOVYQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5oJqAZRGYykAa720Yha0+jg7xkV+6uuIAZ9HqUIgUU=;
 b=Wz3uqUEHvrpH3CySJXNscsLpGFvdmAHK++vTyu7D8bpyt3poJ66usLSBc9Ytc57IlCISPl5/f0TV8Dt9irFxK+WwibMzd1iBsSbZNfDKPgz92imlBmPY3HXZ9khYU7jGXCT68/nKLz8ye2wcUuV0elmxsg9BCkUaYdTjopFANMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:25:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:25:40 +0000
Message-ID: <8e37f69b-1ccf-4073-92d5-e55407659db6@amd.com>
Date: Mon, 29 Jun 2026 17:25:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: zynqmp: Add TCG variant detection for ZU3TCG
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20260623150943.2662500-1-padmarao.begari@amd.com>
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
In-Reply-To: <20260623150943.2662500-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3778f832-9468-4882-036f-08ded5f2ad7d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: K7UERsjBW2Q5keDha53iAZ86FGKduIRPTd5x9gqbTS9aubkbHBXXdBE2wJ+M34P+0QNiYe85M1LpAsAL53Y2POlt1d2HgcSn2iv7UMFnvGeWowrDfCbWrw/y+OjF4HNNl9OmwVmbfoUzmZB2Z4Zz9JWpgAvCgzI5BqgVHWXbdXr+KRMRf74C4iOiaNiyIv4KnoUymRjpwLXgXflO3MEf8rb09Ntth3q0pUe6wNg+4LXfcAtvHSDAHaWlP6cKv1GtWwTUvJSujCZbJuFlqOwxznw7xW1smbBkWzIjNRO3YzIUkTJ6NeUUnmtNNSnxRLWkJP6I55kYnRFcpdKgd0lFeNve/nDvdjIBTSvkzfE70SKvW6YXX9u3two7RkM4uo2UBwssoxKT6/04q00ZMdyrAGwHAtMIwY9mhKDc1RvTW4bIyjzvzb/zVhi71QOWVetBG1XI3jdI9RRE5NdUzeq5CqGejWRvf2VRbLn6avgnhUrRhtTHKGVAJVlop9/KUkDRA81AFQQ/Z3/OVWu+Hqlz0+j8QD5tAj7nj3JnmtX0iVgXs2ajOKiNKLu/WJ/tw15HUzTQLUfkjSZv2885Ca5Q46OobNeKrU5SVZIpp70gyBeCJKQZ1wR9oVhJYl28KwDJ7DAuoQHQdFZgCxoZghOKkK1gmIXTl3ywPaBFJmrArOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBnbHc4U2ZiSTRZZnBPSTdWWGNxTHRGb2xsKzB3T2E5akdmMFJ5Z3dSb2dx?=
 =?utf-8?B?ajY3TitTdlNNZFBtcmhUWHhOZENrSW9Bc0g1L1VMY2JmK1gxMXhHUDY1UXFx?=
 =?utf-8?B?SGhKdVBoVks5dWVJSGh1dStMU3hEcFIyT0R5K1VTNjJMMXhaVGdWN0FRbzlK?=
 =?utf-8?B?eHoyWTBReHREZHAvN2FOek1qamVPNnI0cXg4dlJRbWNhSnZjb3dFTmZZbm9M?=
 =?utf-8?B?aDJlVHVKS0JXSm4vNnZrRUQ5U2NkSGx3VkZvaVlBbzJMckZXcU5GZEsybHdz?=
 =?utf-8?B?M3VUc0pZbDRydXo4cGYrc3dndFFIVXZkTmdOazluVFVLOXBKN3l3TUs1NlBi?=
 =?utf-8?B?L09JdU9WdXpmY3dpc2VlYmtiUDBIcXFpMmJkZ3UrVWtoeGFweWhheUtVaVVz?=
 =?utf-8?B?WlpYWmpxaUlyaU9LQkZtYUtCaXE2dk5SVWJDQTZQTlJ2RGVXNGQ3anB0R2p5?=
 =?utf-8?B?NEoyWDNvNFpxUGwvWDVadHlrc1o4OWNLUFoyeFFwQ013TURhb2lGSmM1bzdC?=
 =?utf-8?B?UlVoUzNkajF0dksxODNjVFlkNk4yMjhCaFYxZllhaHlvVEhSK1laVEYrbEx2?=
 =?utf-8?B?VmNXaFZGbnh4ZFBXeGxHanY5NHNjZG5oaldnRnNwa3lTdTUwQkJFRlV3aVZa?=
 =?utf-8?B?WWFxakFmOU1LTkM2U3dDa3htWWFjRDcva1laN2hncWlBNi9VTGdlOEZMRTBX?=
 =?utf-8?B?TjNMLzdYbG1BV3pGbTN6aDcxK05md2FLZHNDYkZOWjNFdFdacXZRMWM1M3NW?=
 =?utf-8?B?OGhUMDU1RUczcmtrT2Ryb0VDTWlwRjQrOTVhRlhhOHgzQXlBa0VuNkZOdDlH?=
 =?utf-8?B?OEYzamYyNE9WaUpJY3BCTkltaEZpRDdaVHFmYXAvYmg0S0NkOU03OVA0ZUdv?=
 =?utf-8?B?clRjdm1wWW1sMHNqMHRtdGVGMEJtcmF3clorVXdnM0tFNktvZ1RDcVFsa0Ur?=
 =?utf-8?B?dGhseWZjNEpwbE9nNUdQajJpS09mbFRwSE96aW5rOWtuNjVtMklzZGJ1d1pD?=
 =?utf-8?B?Q0R0RncvZEZKUzNFdjlqQWpRLy94T2M0QmQxNHhkdXdKQjdnTTRPTFhCWWRx?=
 =?utf-8?B?WWJhMTdQQ1RncEE3TEtEUUJob0x2UlFTSk94NFBDSDBacVZNZFBMTmQrSkpX?=
 =?utf-8?B?eklmWG0rUGd2dGZRM3dua0FqQWlxVzIvaUtXbUV3ajBydTVYbkNTdWVsZ0Uv?=
 =?utf-8?B?V0VJbHg2RGRXR1BjZllqZHJCUjZOWk1jUnc2SjRqdkErbGtmMUlLbHQ1cGNM?=
 =?utf-8?B?QzZ4cmFCQU4rb1l2SU4vOFBxVmlaZWxHT2JpSTY5RDdYbDRiVGhEYjZoZkYz?=
 =?utf-8?B?WDJCN2RObDgwVDNCRXVhRVhTaTZYelNkMDlicG1zTWhCTFg3VG9lUGhjbVNQ?=
 =?utf-8?B?VmlxaVgvWTU5QVVKbVExcUM4VTJVcUZtZmR1eDlNRk42SXFKSU5ZcVVsdjFn?=
 =?utf-8?B?WFlsMnVDaDh6NTFCVlJnc0pJZzdVWTZ3cGt3a3plc2JoV3Bla2p2WG03cXFx?=
 =?utf-8?B?QXBTZ2tuZnN6ai9lZXNHbWdhNy9EVkdHcjBlVllWeHVBSDJiMmZPWHRwdUs1?=
 =?utf-8?B?QUV0dHBYc1h2QVUrTEx1eTBHVjl1MVF0TnE5UG55UWROYmxHa2xMaU1DMUhJ?=
 =?utf-8?B?ZDZac3Z2WGFlaVl4aURDbGtvZHdMWDBzaEI0K3VCWCtRcUp4V3JUUllYWExF?=
 =?utf-8?B?WFgySW8vSHNQRVlGMTB0UE9wU1lWV3cxNXpsS0RQQ2xKR0pySmJNYjlTcGdX?=
 =?utf-8?B?U1luWUxIdGppRHVoM1pIN3B3MHpYZ09zU0h1SW1zaHhWWTZuNXNxR2JzZWhz?=
 =?utf-8?B?QXc4eExEdmQvcmwyVzAyWUxnWTFTWit6YTZoVUF6eTJQVWMxZGFEeG9tcGYy?=
 =?utf-8?B?ZWVhMWpZV2xONVhubDU4bkxSdmZwazB5SWU5KytJZWUxWU0rQ0xDeXN2MFM3?=
 =?utf-8?B?VTVuQ2R6MUJuLzhMZTk5M1dTa1NHdCtOYk5IYkF2dXcvUFNsRUZWV3kvQkdu?=
 =?utf-8?B?YlRnOUNmY3dkejk0LzJaTUJtcmpwcWZLaXRUV3BrdDBTR2trNDNFTGpMRWJh?=
 =?utf-8?B?MnY2MHNxUEo2c0wwSUJHM1pXYVB3clZCZEJDa21pUGlCc0hJUktqaFNrZ3J3?=
 =?utf-8?B?dVlkeGE3VE9rRnYxenlBMmE1Mkw5SW9zclI1dE9NR3BhTmxFdjNpUStOTFJ0?=
 =?utf-8?B?cXhyM0QwWjFaOE84OGhyTFhrc1pCb3cwa1lXRlR0TjZoWTUvaTlqbzhZTTlE?=
 =?utf-8?B?TTFhb0ZEZkdZcVNSYkh1eG1YODJzcXd2UjRtY1FxSEpybEc4bWw2Mm9JR1JP?=
 =?utf-8?B?SkMyanB3cDhWbUFiK1JqellhdlBQUDhZMzZ5Mmk0TGpuTGlqV3hVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3778f832-9468-4882-036f-08ded5f2ad7d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:25:40.3979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn0QrSwttUhK3GaaS/NInDr5d42p9KdJuQ89bL2lKXUH4E9bLBdiGMhJRjnAFkt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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



On 6/23/26 17:08, Padmarao Begari wrote:
> The XCZU3TCG device shares IDCODE 0x04718093 with XCZU3TEG but has
> the GPU disable eFuse bit set (Consumer Grade, no GPU). Previously,
> the TEG detection branch appended "teg" unconditionally, causing
> U-Boot to report the device as zu3teg and failing bitstream ID
> checks for xczu3tcg bitstreams.
> 
> Check EFUSE_GPU_DIS_MASK in the TEG branch to distinguish the two
> sub-variants, mirroring the existing EG/CG detection logic:
> - GPU disabled -> TCG family -> "zu3tcg"
> - GPU enabled  -> TEG family -> "zu3teg"
> 
> Fixes: fa2f0c97af96 ("soc: zynqmp: Add the IDcode for TEG variant")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/soc/soc_xilinx_zynqmp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index 4abc73013eb..0e13e230914 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -358,7 +358,9 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
>   	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
>   		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_TEG) {
> -		strlcat(priv->machine, "teg", sizeof(priv->machine));
> +		/* Devices with TEG variant might be TEG or TCG family */
> +		strlcat(priv->machine, (idcode2 & EFUSE_GPU_DIS_MASK) ?
> +			"tcg" : "teg", sizeof(priv->machine));
>   	}
>   
>   	return 0;

Applied.

M
