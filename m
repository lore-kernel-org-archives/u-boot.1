Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC27C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 06:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858FC88498;
	Tue,  9 Jul 2024 08:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C87Qeaiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36AE883C3; Tue,  9 Jul 2024 08:31:32 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28265884D0
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 08:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXT84q1KsKUsKesBgcvQ+4BFazbVI2HOkj2jGlKrxctKo3oopXsipWW5yj+UmZ5Xms9GnK27DaiPf6mCLDm5OPpp89rOxik/mgu9RNkerGA1jFzWjPfbRl0kGKHJOMuq4KmD/PM9mQgDU6M9K3OEh405cEBzlTrjMEgZH/c6Q/akgE+aRZWqoUn35whEG5oHWEqvECC9yJP8ZYgNKZClg/+wxICBDfkLDfDCB5YKRg9j7EBnX8iIydvym3tckwHChIXNLUfX9Bm6//ZEKcOGNlHkWdvKok0BLAaJogIsIMjFwQ821cNe+byuabZI3I0yLXHOjq0+96vsGmtY/+1XTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1HCu2lGy8ovqLKRSf+s8r1MeQRHObIpxxqz9oYVFYg=;
 b=YcFBJN4G3+RUPu29VTV2tNiHVY8FAUF+ikbKKYcUST6nqi+CukepI8AgkZQZJAzCXpybLrqnSKGuU4a6jr8v6vVkvluoo3rhhWZIVibOnv9yeuFPCHSA9m5kdEUytV+oZ2FNNDTlLlXc/qJ9Duf5wRODSLp+/3FQ+cF+nRXtJzrf5IwbeaA5wVK5OOPH3exRRxT28pYlEZbt3acvEspoMnfMMKiktgFvZ2pMyeUBXQCZxcpwFcw6B25PKDzRTTAb+xsgi0CkPWWah6Rho6sV2xqbkIeBhwhDkcE6p7g7VzGPGSbCYnrzRsw4oxhH3Ctb3uZfR6zhHMo1UIrPwzrrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1HCu2lGy8ovqLKRSf+s8r1MeQRHObIpxxqz9oYVFYg=;
 b=C87QeaizHo39Do9pRpUl5reXHzpGhkXvbmXsSSLvUW+lWlXQjuIihHI2tbRoFl0i6U6ANgSDq5+67/6FYfdLan/qFXor6+zT3N7BwsM/9QTitk8f12N4eXDaz9yNDSLNUbRUPyEDxJjYvAcdvWc78PW1PF6/nSYtiu3XS04VNAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Tue, 9 Jul
 2024 06:31:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:31:26 +0000
Message-ID: <1b9ccfbb-b6be-4ce6-9256-2737038491a3@amd.com>
Date: Tue, 9 Jul 2024 08:31:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable the NFS command for zynqmp_kria
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240709042232.860395-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240709042232.860395-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8e4057-b6aa-4c3e-b282-08dc9fe0c26d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGF2bzhWTTFiSnJMZTMxYVJuOHNVU0h3dU5KMXh0a0JmNzRGTnQ5ZnFyU0NH?=
 =?utf-8?B?UG1YSXprNHpoVWl6TWc3dTFPcHZLVFNKMkRDMlpOWFA5QWFkZGxNdE1hMVBs?=
 =?utf-8?B?OVN1TGFYbFczcmxBelBIazdoMllGalc3Y2R3cXRFMTQrTHNKbHpnUkNIUkRq?=
 =?utf-8?B?V0tCZUhyTlVXeGNVTGhiczR0eHV1WHcwRThHeUJJM3QrcTRURjdITFkyWmhh?=
 =?utf-8?B?SThCeUlSUHpqSTh5M1RscTJObzFsRytmeVdaS1FlUk5XYTJTWHpJSW53NWgr?=
 =?utf-8?B?c3A0dDZFR1JCam5LNE9yMUlvZDZkYXQwQ0s2MWdydWhNTk9sR3JxYUhBQUVE?=
 =?utf-8?B?QkN4WWUzVGFidVY5T21mZXhReTVuVWxwbkh4SjN2Y3I4dTBDdjZqYXlLVWtv?=
 =?utf-8?B?SFdVTGVIb0tYaDEwMWlHV0E0QWZoRmZFSmJBaFdBdTBjbU1IcHp1VVhyV2dQ?=
 =?utf-8?B?MjVFMVQvU1VlRkgxUlY5clJmVzJLYk5pQnpBWDllMXFDZ0ZVMnRrVTFGS0hl?=
 =?utf-8?B?VnpVSkhRcXpZL3EwVGF1d0RtSGlhdExsb0gwRExaTnQxd2F2S0ViSlI1Q0Mr?=
 =?utf-8?B?VW5IY3M1cHZSQ0UyaGtBejNTT3c1dHBUOFZjMWsxVTdUNHZOUGduQ2xLbUY0?=
 =?utf-8?B?bGtXN2dqQ1BrTk1MdmlPaXpTQkU5anZ4cS9sSDUrNzRpQ2M3bnpYcjN4TzE0?=
 =?utf-8?B?SlhLN0pVMGsySGcvcW8yUElqQ2JTZE04MXdLV0tpWHcyWGFHTFlQWVhCaDRj?=
 =?utf-8?B?L0UyRHNqNDF4N3loS0VUdFd4Z0I1MnhZUklMUUw0UmMzQnhqdkc2OU1ma3Z3?=
 =?utf-8?B?c1JwL3N0RlVBOEwyNllEVVdTeFMwOG5jNUt5a1JUYjNOc0x2aFU2eEdOUUo0?=
 =?utf-8?B?WGJDLzdBdVpqUVhlY3dXeXI5a0VMYmFEcEpmdUVpbkV3V3k1T3pjWDQrdG9k?=
 =?utf-8?B?TS80USt0T292VFoxSHYzNlNCZ21LQ20yaVNRczRwZTlaM1o3enMwd0trM0Fp?=
 =?utf-8?B?QkJVb3BNWmg3aGxPUTBOOWNrUktEeXc2TmJDcWlNdjkxa3dRaklCVDVvNG42?=
 =?utf-8?B?TkR2QkMvTUFWa3VzelFHT1NyU1dNT0lOTGJvK0IyUkJlaE9IM1RHMm54dEsy?=
 =?utf-8?B?TTBkNDJJdzJ5SEs3U0hNa0VIWTdyUmZ0ZlVvVzNFTi9Pc0VhQ0VBR1BBYzd6?=
 =?utf-8?B?ZUo1b25JQ1p3WWhEWGRDY3RoV1NuOWdkOE0rN2p0T2lxendCZlcvbXVjamhh?=
 =?utf-8?B?bFBwQk1KVDVJekRBZ0Y3WTBSV1k1SkJ0NlJnK25HNzEvMWd6NzJtenFRZ2Er?=
 =?utf-8?B?Y2w0bnpZZHVYclZ6NE5CZ2h4UlAyTUlUdjQxcSs5VEZ4bFl5WFVxOE4wZEVs?=
 =?utf-8?B?Tmh2ZnJpZVlyejBCVkY4QmNTZVZRNkE4OE1ZMDJTUFdSYVF0TEtlM00ralpv?=
 =?utf-8?B?S0FpQjZNQ0JteFpXaTg0T2kyTjRPVWtneHBwUXozS1ovQzg4Ym1EV0VULzdU?=
 =?utf-8?B?TlVhYUFDM3VuUDlheld2aTRvYXNVQ1QrL1BZUjdMdXIyNXhNNzNabkFTYkxF?=
 =?utf-8?B?akZLMkR5L082dlg4eC9DMFA4d3hIY3Jic0NacTQzaHRCYzZKU2U2TnYvZW5u?=
 =?utf-8?B?RW1XajZUNmRmYkVYREdyS2dXcDk5MnU1SGMwampaUzFwREdmaVNEU2wvVXBG?=
 =?utf-8?B?VEVnZEJhYWU4MUw3VTZPS0Nvd09WOXJRajNkY1NzekMvcjVTYnpLdzJHWFNk?=
 =?utf-8?B?M3JsOWxiQ1VnejY1Y2FKMjhRTmNRcFEwZ1JPalp1L2FxdTBqZ3JlamZnT2NC?=
 =?utf-8?B?NEs1ZzFIZTdrR29vZ1JGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGxVRUQrbXdMeTVDanBXNmZBNldETm1RaFFmNGtoamFrem1KdHJkNjZwT0N3?=
 =?utf-8?B?RW5SbHdHY2svcDZqTytGNUVhbGI2UUpac3l5TkxBZk4wTFVDV2c5SUJ3dE4z?=
 =?utf-8?B?QjI1ekN2VWkrakRFcmJkTng5SWNuQ01FcHhvdzljNGNKbnBIeXgzTEpWNm54?=
 =?utf-8?B?NU9hdjRuYlJrZWVIbzBNVjNZMTQvaWliUmtaZ2pnVVV1eHlDV3drSjFzZFY2?=
 =?utf-8?B?S2RUTkRSVFBiOFoyUVdpWmJ4NDVCZDVpT1h5WWd6eVVENlVGNW9IdC81SjFE?=
 =?utf-8?B?Vm84eTZOT0lyZzhDNk9JYkRuMGw3UFZLZitVQVlJdjdtYVBEemRFekZ3NXhB?=
 =?utf-8?B?Q3dPWlBENjI2eFVDQm1XYWh1ZGNtY2UxYkRZL0NVelUrU3NURXdOVnFRTTJP?=
 =?utf-8?B?UjJoYXlGRDRaNktXYTQ4TmNuMytpc0F5VUozYlpiYnNpcVJ0bmFlNWdOcHBz?=
 =?utf-8?B?bnNWUVJMMnZ1d3lUV2JPSTJSZkt4M24wNFFYL3NXd2JKbEo4WW1YRk9nTmdt?=
 =?utf-8?B?Mi9DYUxIRzcxaUpXc1IzdlQyeG1jc3Zianp1SncwMzc5aGxwZzZqVU1uMTJo?=
 =?utf-8?B?bmoxS0QzY1d1Z0NEVzdmUkt4bk5zT3dlM0EvdG5MeFhjTjBhbFZJUkZuWWln?=
 =?utf-8?B?ZHhuMTdpVjZUQzlTSnlhV2RjRldPeTliNXEzSHc1bjlqWmNUelZFUjhtc0pW?=
 =?utf-8?B?UC9XUUIxaS9PbnMvV3dUK2piRG9Fb2VoSVhHT3dHUjdwZmVEYVVrNkhKNE04?=
 =?utf-8?B?M3FyUG5PYWtJc2w4NzhkbmdYY1hPM0dJeGVIL0xNVDhQcUZ1b2UvQ1JiTmh2?=
 =?utf-8?B?U2NPTHpXdXlJNkFlMjBGSUhESENXbzNrdHdVcFNZakRqc2c2M0E1Y1hURm9y?=
 =?utf-8?B?dVhOZUgwVHkrZ3NIeGhxSFhTczRPb1dodVVjUUpmMGpIZFg1emp0UkFzK2RZ?=
 =?utf-8?B?TG43MkphR2FFZ0JGVmhjNmdLTUxsa0JyeWo0bDNiYmxLdEs4bjZzdjdrWVdt?=
 =?utf-8?B?Qy94UG9ZdmJFdVFHRlpXTG5tQklnbEI2ZzRjMzZvMHlSaXl4eXpFdDZqeGw3?=
 =?utf-8?B?L2Q4OGFQZmJNb3l1OUJEMnVVZWtiZkJNUlE2MFZLN0ptRDBBbDdMQTV0cDdn?=
 =?utf-8?B?NDJGclVYYjhWSUM5Yy9sSkswaDBxbE9SNlhzSlg1bmlOaTBEY2N3ZkRtWGhi?=
 =?utf-8?B?RXVSd3NKbExES0d4OVR5ZzErYkl0S0hNN21pdXRldUJoRU52Z3loSDkvb290?=
 =?utf-8?B?N1pTV0J5eUwyamUwUUYxRTJWckI1TkdKS3ZzY210M3c4WDhXeXdkcm5KR3dU?=
 =?utf-8?B?TDlkV0NCMmpnWWp1VkdNYWtqYUZoOGtKMmJZWElFeGxZWXRJVnd6VHEzL0lN?=
 =?utf-8?B?NDl2aXp2ekhoQkRBMjIybTd0Qm1acHQ2TGNrQlMvc0l0ajd3cUloOU9uNjY4?=
 =?utf-8?B?TkpNbjQ0YURiZ2gvVFBJTW1KZWhUdkpIU2xzMzZ4ZzdEdGxwakFtLzZkaksw?=
 =?utf-8?B?ZDRZQWRkc0Mwb2lPd3k3WjJ4NGVPZmVWa1JickZIaXh0M3E2dkZiWjJxUk9m?=
 =?utf-8?B?YTBMa2N6N1g1dHl1TWF5Q2dMKzBMaFEwWnVvdjdadUZqS0xQK2hwcXc5Zkw4?=
 =?utf-8?B?TmlvN29zVXYzTXh6azlLdThudkFMRHZjMERESlNIWnhPVTFsMDNIUHQ5NFNP?=
 =?utf-8?B?eDVleUJKbSttb0htZlROZ2xSQm9XWkU5MzRFdjNZbzErY1pPVXMvNGs1d20x?=
 =?utf-8?B?K0FtYjdDM1lLY0hUc3RLdGMxNDJLQkIxMTF2RjVRb3c2V1NaaUprZkxKK2hy?=
 =?utf-8?B?anRSa21pUlVzaVAvclMwZFZLZVh5WGMrRW1FR0pwUzVXZHArVm9iVUdDYjk0?=
 =?utf-8?B?YnBnaWN1dUhPaFBjamlzcHRpOFRCQmRjTWxHbVU1VGUydlgybHJ0TkdoNEN5?=
 =?utf-8?B?VndXdzZOdXRxd3hRbnpVMm5rYk1SSXVEWnRtbTBwSFMvejZaOTZvVFZKL2xO?=
 =?utf-8?B?RUZpN29pSFU5UEFQT3dDK3lMUWRhYkNXTElDZmIvam9DdmxNMXptbzlUWjl2?=
 =?utf-8?B?ZG5iUmJIeDVIOHBZeFRmWWpjVGhlYVRGdmtRU1hoRThnaGsxODJMekNtbXZ4?=
 =?utf-8?Q?ia6O+iZhHSBKuHJs6QH1ZFIg3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e4057-b6aa-4c3e-b282-08dc9fe0c26d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:31:26.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1opsyjZL3bu0cbbrQqzh8c4FSbYKvAwncydlYEDrNFmCSSnel9No0pSwQ1FxZkJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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



On 7/9/24 06:22, Prasad Kummari wrote:
> Enabled the default utilization of the NFS command on ZynqMP Kria
> platforms to facilitate booting images through the network using
> the NFS protocol.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   configs/xilinx_zynqmp_kria_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 58e88b25fd..4c66c536d0 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -81,6 +81,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y

please also add it to amd_versal2_virt_defconfig

Thanks,
Michal
