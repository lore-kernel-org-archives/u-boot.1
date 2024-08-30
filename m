Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CCCA0EE8
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 07:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C4E88C47;
	Fri, 30 Aug 2024 09:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gwl0CzUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754F688D23; Fri, 30 Aug 2024 09:45:26 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921EB88BDA
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 09:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFi1NH0KMAjQ93pFafVLstKsXkgxPBp+p2pb8sGBCQtl84dl7Klhg6EIdOObpqkBarWXE+hlnqbHhwm7wqdgDrPAwwbkEff3OjV58EA95PNUZ8Ls2ImzXcA5y/Jv3W3jWSFowuMR8klailcHVjvUYPFTYgbb6LqJnyIyQCne94RI4aIqbkBsZuPrQ/sw6AFSXGbZl7FIUoqFK8z9JsZ/nXA6/edziTsHlwnTwKvoaBTytxNXbm2C9tJh2fK9HPh6MTUoAa5Dvt8xKeTtkfG3+z7tLHFpy2TSSXnq1cah7JCwhDgme6fpg3L2CFF+gPGrHRBTpVZAdekuR7w05Fd83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdmC6+DGOn1z9nBCRjnm6PZDhBJ2QoR1qMHpKNbIqWc=;
 b=bE0BYh+F48bs2OuRBo1Ea2rFzfKkWLwCWG6SHchr75jFaKF9X6fMjePPGcgSpqfYPFRyz0ehDwrbZNbF2N7HxWrekqnuy88GHnbZ8M8EywAftcw5I/uCX6rDUGfkPh+/iqJ9GKNTISvtieI5zW3zVR31MiczTpk3HRR2QcYeEMRQagyuf62wYNUuIwCRQYI1tPHNHVJOcMBibsVScy45B9EFOrlfcZCBhD0dJayFR0vNIH0lKoOlo7fL3GsxYbeF1iotB8MnDLcSMLOI/wUlP4aU/IxcwK3ocIH1P6b02tHgrkcFpTRiUFDcxmCt5sH6CNVLTb6VV5N/830PwGgYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdmC6+DGOn1z9nBCRjnm6PZDhBJ2QoR1qMHpKNbIqWc=;
 b=Gwl0CzUK7GG4CJZSipBW9qHaZTj0FM380UIBne8wWTe1+RXTM8hc5exIcaIagjwEeXEsrTk4BHY2LJQEmWqRTM8qyPHr5v6n9AUUj86LKcsJAfVoN+YNVY31ZTdLa19Lid1qTaQwgnQ9WV7Xyu91210m2R7J4+F5vTLrAsqLzsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:45:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 07:45:19 +0000
Message-ID: <c2692425-f8e9-44d6-abe0-4bbb41f6dae9@amd.com>
Date: Fri, 30 Aug 2024 09:45:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Kevin Hilman <khilman@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <20240828201912.GV2479150@bill-the-cat>
 <CAFLszTjzH9kiM3SEzfjfhCWMCMnLLeBy1UipH9kW0-z3s-1xxA@mail.gmail.com>
 <20240828213345.GW2479150@bill-the-cat>
 <CAFLszTjG1ySeXpWD60aNEX5Te0nRKC53EXP5L1AoG+kXqFe8Ew@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTjG1ySeXpWD60aNEX5Te0nRKC53EXP5L1AoG+kXqFe8Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9c6bf8-157e-410c-b068-08dcc8c7b23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2NjU2dKODlYRnlZb0F1T25xNEpjT3ZGbEMzQ0pjTXd1czdDU2pkeGZkL0ZK?=
 =?utf-8?B?RE9YcnNVL0FWRVo5YWR0Vld0Y3JvMlZPWWEwWllYRXVKL0M2dHIwd2ZtaHlY?=
 =?utf-8?B?NSsrNkgvcjdDUTVQbmdmYTUvTjlWcW4vdnZEMEJyNklEQ3psYmkrRnBUYkxU?=
 =?utf-8?B?V2g4clk5ZDg4MTNEUkYzNWF0MGIrZ3hqU0hEZnQ3Zk91TnE4WThNckRTeUVL?=
 =?utf-8?B?U3NnRjJMUG9WWStSRUdjb0s2eU9nMUdmT1g1ZTJSdG41dXAxNUROSEJUSDVP?=
 =?utf-8?B?OEtwWHNZQ20vcHk0c1JaeUtxbjZyeE5xN3BlVUZ0L3U4SGtON1BLTEVwSTJk?=
 =?utf-8?B?MTVnN0FjT2pGaUNCL2c3SDFXVXR4ZVVtSHg2ZThCQWFvb21hSDJwTmt5bDJQ?=
 =?utf-8?B?dkVUc25wWEVmWnIxTmxBQ2dhaU93ZWQyK3R4b1hoTWdYMUdrVDZNZHVKVVpK?=
 =?utf-8?B?TzZpUVFicFV0K0dRcnI1YjNsbFVsbFRJYklYVnZHMXZCYjFwc2N2am1vOG4v?=
 =?utf-8?B?ZnRqWHVBZXd5SXU1OUdCTkF0Uy9qSlVVQkFzU25sTHNlRkJrL1RSbnlmTW00?=
 =?utf-8?B?WFFjTXZ5dE1DV2NWV2t1OFFINDJqWVVJNVJDNTMxQnhzZkwvM0pOaVViWGFr?=
 =?utf-8?B?UDN6QnJZUFRDME8rSUo3S3kzWldXZ3JSTWV3clhOcUcxS1ZqdjJaZExhaVg2?=
 =?utf-8?B?SUJYWE9NVVg0RW02QTB6clcwZHhWVUs1WlVYRjVRTXl0MjhTbEk3SEJDTFBr?=
 =?utf-8?B?SElnc1ZxVFFVM25NbnUzTjZ0UGRyZW5sNHpCa3VYeU9BL1VtaUdiZlR6NDZW?=
 =?utf-8?B?VldBZjNUU2g3UE9odVFMaHRGZ0FTZ3haK0FMaFY2eWJ5UXYxUWtrTVo3N3Zo?=
 =?utf-8?B?azhVVlhyK0x4a2Z6T1NZZzQ3cExRaWZJODBZZHJLbUNGUnhNaVZKUmdlMVho?=
 =?utf-8?B?ZWRBWTRveVpteGJBYTNaMm1Id1ZiaVVDME02YzNkbytLTlB6Uy9nckJidkZF?=
 =?utf-8?B?NWtteGU0TlBZWUJGMHR0eVhrNDlIQ1VlNTU4b0Zqbmhray8xYTVRaEhUOWVz?=
 =?utf-8?B?ck8wWFRJdnRISStVM0ZQY1FtdUJFZjQ2L1VyUkhtS2o0R2R1VEJzRnRhR0hO?=
 =?utf-8?B?SnB5RnVUeVZNc3EvKzFZTHpZRHkzRkRmajAyUVVnUEVHOU1QNTF4bFI4V0ZK?=
 =?utf-8?B?cjB1Y3VGSzYyM0ZwdEV4ZkpwaFNTSEw2Y1B2dXJvdGxOZWVoZ2FGM3hVU0U1?=
 =?utf-8?B?R3IvQjV1Tk9Kd2lDdytTQi9VT2syVkZDNkFCMkY2QlIxZE0wamdhSGVNZHJO?=
 =?utf-8?B?djloT3JzS0dBUjdmTDczVi9MNUJ1Tmp3eGFSakdMZ0FBR0x3cUtHUmV1MjFk?=
 =?utf-8?B?QzJzMi9DaGpjcURuU0ZsOFdpVklpWHJCQU9zMDJhTlBXR3U4SVdNOXJQWGN5?=
 =?utf-8?B?R2swV2s2dHZyUm01LzV1bnJLTFdsaFV6djkwRFV6UUhscTFmVVBEQ1hTLzl5?=
 =?utf-8?B?dzVrcXJtaDhMbVJtakZvdkVQZllSM3o1azhwa1dCQ252NVUxNDBKenB2K1ZD?=
 =?utf-8?B?VGM1cGgzZE5zbHRHVGtqUlBSUEU3dGl1ckZuUmJCdExQb0g0UE5SMnp3VG0v?=
 =?utf-8?B?OC9OQVFZdy8vM3RGRDVJNTU2UUU4enhTS05Wa3VuMkI0Z3F4SzNkTlJBTGRM?=
 =?utf-8?B?Nm5PUzVCZllON2E2MlpqeURISVBMNVhtVUFtOGROL1gwZzVIRTRLeHE5bnpo?=
 =?utf-8?Q?rrai1VZcerwtX8CcSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N280NTg1QytXV0o3OTRuYnNXSHZIVDZ5c0VQM1RpRUNzejJqallEdG11dGZF?=
 =?utf-8?B?T3pJQ2hOMGo2RmdOWUFOK3A4N1M3dlVzbUV0YzJ5TTNJdlkzNkdVWS9XclBQ?=
 =?utf-8?B?SnFKeCtPeXIzR2h5YXJZTEZvbFgvMTFlVlNHMk9VM3NqbVlSMU1iWVB0eUdz?=
 =?utf-8?B?YkFJaWN3SmhjNXdOQ3FTUStXQVBWWWFkNmpoYkZxNTBzT0VEOTgzWHJEaEZK?=
 =?utf-8?B?KzBUdHFpQ0tsemkrZVNOSUNCN0JRMzU0UnllaGJIU3VxcDB2RExheDJHN3VF?=
 =?utf-8?B?clFSKzFSbUR6S1JhT2VZM3J5Q2s1OWMzWGFqRWpCc2dSVlhHMlhjYzBnTXY1?=
 =?utf-8?B?WkdNTjhWSCtqMHZseEpTS05SQWFqTUF1VU9kbGVBYjBqTllUSkRkNEdEMCtJ?=
 =?utf-8?B?TVNvWFF1ZzhPejNQcENMMmFKbFcya2Jza0l2TFRlWTdvaTY0ZEdTVUU1RmdD?=
 =?utf-8?B?TDRZc09oV3lVd3dsMXlheHJDR1dTWVlWODIzZ01aay9iOG95cnp1WDIydE93?=
 =?utf-8?B?N1JldlB6bEJoSFFncFlTYUVraHZ1MERMcGZYM0cxbDVEeUg4dDg5YjRjL0Jt?=
 =?utf-8?B?anhkd0JVWFQ4dkdqU2Y1QWhZazVSR2M2VUwvaUVDOHBzU0tWQkFrREMvbXRJ?=
 =?utf-8?B?NzhjQUZONGU2SUxKblR2NGpCVHRvalFYVEZDQlFob0ZvaFlWaTNJcEZaYm1S?=
 =?utf-8?B?N3JqZitEeG1XNWlwVkVuM1FTdTZHSXBsLy83b1FrbnBnZXdrQlRXYUxCT0tL?=
 =?utf-8?B?WEFER1BQM080MzlyZk1iRmp0Z0pxR3FIdVNaVVppTWdIak90a2VRWmh3VlVS?=
 =?utf-8?B?VFpVVXRnd1hFUVVyS3pFQ25ZQlZqK3ViZmF0dnk0bzVDTmpOMURDRXE4U1FK?=
 =?utf-8?B?WFM1T0dBakVxL2Q3U2FUYnhSSGRWNnhJV0d3NlVZSjBEbUNPYkRQUDVkTXVN?=
 =?utf-8?B?T2ZCU1MwNnZVVjB6S09FR1dZN0dsWC9TelJxVTUwUS9ucmt4cm1Ock9nd01p?=
 =?utf-8?B?UmpMMmdMaTdxanArRHFFN2ZZT1kyRmNPdVowNkVtSFEwV1pyM3ZvZmQvbTNW?=
 =?utf-8?B?VjlHb3ZvZytjOW5Ua2UwZnczVEJFT1F4M2orak1WTXlFMlpCQ1RmRFlKWnBJ?=
 =?utf-8?B?cS93bWhlVVRwdS81V1A2UTRCUGdmRktIaWM5R0szWTBlTnA2VDFtSSs3TFNm?=
 =?utf-8?B?cUFKMG9yNE1NMmRMWkZ1Mmc1aU44Y1JrNmp3dytTWlhZYndkRjFOSk5GbnFo?=
 =?utf-8?B?V1kreDR0U3E4S0VPeUhXWmdtdXpSMytvNHNacXBJQUx4c2NwQVpmb2RGSWZR?=
 =?utf-8?B?T3FmQmwzNGhLekViaU1ZUWVlUTRNM09OQjRqU21QQVo0OHhzcStZRXlCN3JQ?=
 =?utf-8?B?WVFCV1MrOVNDMXRXeHFyNndtQTgvODZXT3o4TkZ5M2d6YWxXSnRaOFg5Snp3?=
 =?utf-8?B?MU5jT1ZoeStjdS9GZE9CbEJ0TGRDMjlQNzVIK2IwazdIZjltZ29kNlVMYWxz?=
 =?utf-8?B?MDBtUC84TTBoek5CajlONjVrT2NIUzFSRUV0dWZKM1ZjY2JROFlZOWxkRGtu?=
 =?utf-8?B?bzhXU2x2RUhWL1k3OFc4S2FVQ1lPRnVHbmpPc0ptWUhObHNXRU5BbGw0ZEJ3?=
 =?utf-8?B?Ujl0S1VPVUVxd2tpMFp6RUZ4SU9FdmtCSDYybXh5MXRYQVYrUHRXMDZBaGMx?=
 =?utf-8?B?MnVZRE1XR2l4dmJNcmxwWkY0Mnp4Wnhud2NuYXhlTXBYWis4dVdvbGFFY29Z?=
 =?utf-8?B?eFBibXR0RzR0YkVxVGwwajFxYWV5R1RWMFRubXMyRDd6YU5mWkhkdXdRSkVk?=
 =?utf-8?B?akNXZDl0T0pueGRUdkVCaCtoekE0dEl0a2JxQVIvRitSTFcrbjN1UXFveDR4?=
 =?utf-8?B?L0UwcExtMmZ0QkRML3BhVm5QTzJIbmZGUm1rRWRMUnlYOGdKdkQ5UWM4RzVs?=
 =?utf-8?B?WmpsbU9ndWg4WXlRYjhwMndVU01ELzlRaXk0ZjlIM2VJNFNQK3VQM1hDNm5r?=
 =?utf-8?B?SXdrQkgzYTZmMVYwd01mTjlhbFFsVkhvbHpTTGkreW1HMis5SE83d2JOQkkw?=
 =?utf-8?B?T3lIU3diUkFjRHJGekhZdjFLZlhneHU2MHVZZkJmTmtuRGM5MnJxVnhIZkYw?=
 =?utf-8?Q?I10jSc5cbF4Vju/JF4Aalslax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c6bf8-157e-410c-b068-08dcc8c7b23a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:45:19.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J8WenK3hoBP2RDsbGLjHGqjkiWwoch2YBEQG9AZl4+O/Y9s/1PnOYjrEanYTYRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

+Kevin,

On 8/29/24 00:27, Simon Glass wrote:
> Hi Tom,
> 
> On Wed, 28 Aug 2024 at 15:33, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Aug 28, 2024 at 03:25:00PM -0600, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Wed, 28 Aug 2024 at 14:19, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Aug 28, 2024 at 10:45:23AM -0600, Simon Glass wrote:
>>>>
>>>>> With Labgrid we don't need to specify the various methods, except for
>>>>> the console, which simply calls labgrid-client.
>>>>>
>>>>> This allows supporting any boards in your lab, without adding per-board
>>>>> configuration to these hooks.
>>>>>
>>>>> Provide ellesmere files as an example.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> I think maybe we call this version "labgrid-buildman" and make sure the
>>>> documentation emphasizes using buildman to provide U-Boot. This will
>>>> make it easier for me to provide a follow-up of say "labgrid-external"
>>>> that requires the binary to be provided, similar to our other hooks.
>>>
>>> It can be used in this way. The 'ub-pyt -B' does a bootstrap of the
>>> board without doing a build, if that helps to show the path through
>>> the code.
>>>
>>> If you don't pass --build to test.py then it won't do a build.
>>>
>>> If you like, you can pass --build-dir (and with the testb series
>>> --build-dir-extra) as you do now. The binary will be written to the
>>> board as is.
>>
>> Right, but this gets back to what I'm most confused about (and need to
>> talk with Kevin Hillman about maybe, but I missed my last meeting where
>> he was as well), you have a bunch of logic for integration of buildman
>> too, and I have a few wrappers around exiting labgrid-client commands.
>> And I don't know what direction upstream is going to want to take.
> 
> Hmm, who is Kevin?

Kevin was starting with kernel testing long time ago which become kernelci.


> 
> At the moment we are a long way from upstream. I have only one
> reviewed patch and it is pretty trivial. I just updated the stack
> again. I am hoping to meet some of the people in a few weeks, but they
> are pretty tied up on other projects, from my understanding.
> 
> Anyway, we could have a chat about it if you like. So far I'm pretty
> comfortable with the approach taken here. At this point it replaces my
> Labman as well as tbot for my use cases. Without integrated building,
> everything will be a PITA for me.
> 
> I am not sure this much matters on your side though, since you don't
> intend to use the building features here? How exactly are you building
> U-Boot? Is it using the --build option with pytest, or something else?
> 
> In the interim, one way of threading the needle would be to have
> test.py get the info from Labgrid using the 'query' and then run in
> the build in pytest. Or, even worse, have a separate yaml file with
> the required info and parse that in pytest and run buildman there...
> but as I say we are a long way from getting this integrated into
> Labgrid, so it is somewhat academic at present.
> 
> My immediate goal is to get all these things merged in U-Boot, so I
> can get my lab running properly with gitlab, etc. and ideally allow
> other custodians to push to it. Getting the integration landed in
> labgrid will likely come a lot later.

We are using these hooks script for u-boot testing for a while in AMD boardfarm.
It is not perfect but we find a way how to get it work with AMD boardfarm.

As is visible there is never going to be one boardfarm solution because it is 
hard to do switch from existing system to something else and move all 
infrastructure around.

Recently Linaro announced onelab [1] where the part of it is LAA. Pretty much 
ready to go box which you can connect your local HW to it and start to schedule 
jobs to it.

And I think this is a step which I am missing here. I have bunch of HW here and 
I know how to configure it, boot it, etc but I want to use it and I don't really 
want to take care about lab SW, maintain it, test it, etc.

It means I have no issue with Labgrind but I don't want to waste my time on 
making sure that Labgrind itself is working. I just want to configure my board 
connection once and then do the work not really updating Labgrind instances, 
deal with dependencies, etc.

It means having generic box, sw with connection to gitlab should get us to 
situation that u-boot will be tested on more HW and make it available for others.

Thanks,
Michal

[1] https://www.linaro.org/blog/onelab-launch-at-linaro-connect-madrid-2024/



