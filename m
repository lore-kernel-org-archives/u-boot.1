Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A97CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 07:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4ED83AA9;
	Fri, 15 May 2026 09:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SJ+9VboE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41EE983E81; Fri, 15 May 2026 09:29:02 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5435F838BB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILKFLEWNSy5NGDJ1w3flj6Ta9AmaYoVCJXcPtoQ+SnvtnHd9mO6b7WYIylAEz8Q2VmdA2tD/7ix771gFdOcNi4qs6gp5wTpQX7HhHUxdNluGYUvnvb7i748PdKcgEutdzewkmrc1mLupngXdtdPRtu0NL8SoAGPtAsEdEbBg6rguL3pPrmLS/29Bxayz9ZGuRKwVX7DhA3e4gjsG7FrSBG79rT3yOCtRHx+HAVYpEvBwQqZxUIov+SEGYSZL8K3bML7zYf4RySqQN58giXDhMzkUxW3cqZ4V8Kc0+LOyAaQ908QnQ/whQOGNpvC6wFzIfghlwrBfOc1nGNooS1u9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ojn+ayq0DKznp9MuWPkLaoxEPHNlWuCxibEJTdTkhYg=;
 b=KePENoEPn1gfkUbXdRKv4y0W5zAYeG7YuGpSC2jjrw7xJ8311sWVY+M16xW9go3VTX5h4L51UrGRw5LL+wXqmlx+lA869YrpFJ/eOk4rHalLAEJvCRiR/9l3w256ci4Gr0+4ElQEn6L+BOJ+dVXHSKDC8nr6R/dbM+Ji5caa0ac3AwvCS9SR4RvFvOLwcO5PVgkWQRMPuH6U9e8aW1iUI0tC5kR5BsfzA/z3lKQricMFywwRh1Zlgq//hidkDR517ZK8efCvoSA8GVFKUAPDZJtBfl+Bn8R7AL6LFKlskHUFGgCerltkwPb6hdQCZskek/zJ0e+Hl3WCWwZ6V+IJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojn+ayq0DKznp9MuWPkLaoxEPHNlWuCxibEJTdTkhYg=;
 b=SJ+9VboEduIcvPkyxae1xYRzpukqBiYUK+dcKjFI//G33MYFh6KPmgrswDuJXQQUBTR5kKCjz7PYvIKkmkcSWUr2pkgwdFAW9JZ0igUyY6jrSR6S+rOey3Ydbzlq7Ezp0bY1p4jpjj4wqt1QaOYu+GWkN+lxSWbZwj0r0Im9MX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Fri, 15 May 2026 07:28:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 07:28:51 +0000
Message-ID: <3a641dc3-b795-46d4-9165-be7e397f6259@amd.com>
Date: Fri, 15 May 2026 09:28:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Enable SPL_REMAKE_ELF support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, michael.srba@seznam.cz
Cc: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
References: <aa144c8002ba86154dcb62624a1d9d7cbe8c2cdf.1777962845.git.michal.simek@amd.com>
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
In-Reply-To: <aa144c8002ba86154dcb62624a1d9d7cbe8c2cdf.1777962845.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000092F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::835) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e70cde-fd87-45c6-03b6-08deb2539c60
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: O9r8Oit2DID6smJNyHcoOqaotUkkml+94dXqkMqAiPXRF9rQxvKR9BWhIh9pFBcZW1/YZR08R1abaKOxOkjMF2dZs8m3Z0YfW8rVysfD0Swd2UqJL+eG41bDBFT8JYCrz8iWXvgYz2Tx4X52dV7CchtWCidnQswTjXBhjiGNGZBbFyBrLj29J5GevJGO8Rks9ZmDMYKhqf/hHK7aavsUlaSHN5y4M/9zO1+ZfxUP+sEyciDG8nKqsYkiiUaFRUugA1Xe54xMrHQv8rcO79cUZ66FXHhjRyJvq2oxJXWN/C9/qeFO7wvPSQoZPoCz85R81mh6qrNeykptGy9N8OCk47csMofiygfj/uFUoB+SRJbN1lKJzHOcEhMR2ky+rGW+B8kylIsaT+uHoBeUg7X1QV/nLSrMHmf6A2oyKYKYBZK7leLbLSPugpq6/cxiIXo93bIC2dqp3rz5qk9WD8cNKz+zLu8f4FirO3hPkgMExe3HHV6aR1OLm2hP44SaMEIANa2CLhGLK1qlkKFXk9ChuN+ivO+f4/6CUhHThBQrboEYQcue9yUhXSefv77JCOa1uWxlJmVQ8NBfyGMruNzVgii66DSmbtJ4tqVSIX0Dryq5OByr2SqJJPCqMGYhGaOiWYto3Qk4bPe0NoVFs+InJAZLecP2oCpJuTOfwnhm/WyrN52HOwRpATRqB6WNHdcn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDhKQXhsTW1NMGRnVnZ0T1BhSktuYkdJVWdxM3F1bDU1alU1MVFCR24remM5?=
 =?utf-8?B?MEVtVnBaTWRhQllGWTJ6VnVJT1lXcDk2WC9OQXE1QzFUbUMzVURLcW1HR0Nm?=
 =?utf-8?B?WFZIcTR3T21mb1NoZ3I1UU82eXdqZktyTHpQR0NVMUM1cUYxY2p0WlgvZEh1?=
 =?utf-8?B?dTZhK3haeVBnL0szZVlYczBEVDEzNU40SDFpU28yYWV2L2JNeitERVczdjhy?=
 =?utf-8?B?TEsxUGxscWNxdERJcEhJRzZYR2l5anpzM1UzbDBVQ3dSaC9lSnVhTFppam41?=
 =?utf-8?B?UWxOcmJZYThLWXBXOXBsRmRKMGsxZFFrREh0aWlyTEE4b3hTQlovcG94bURB?=
 =?utf-8?B?SlUwTHUrTW5iZWhDdU5SSVVOSEpZSDdmTUROTk5HRzg1SFhXN2tzQmxucXky?=
 =?utf-8?B?WnNLMEhodUkrbWU3dUNTZ0RKY2NyaVhKeFFIZlBMS1M5RW5WdjRPUlUzYkRF?=
 =?utf-8?B?eFBWZlNQdndUSnlwaTNkSitaVDA1aEQ5SFFGREV6alNSU2tuT1hLV1VvS01Q?=
 =?utf-8?B?Qk04QWNNcHhNa1Baa2RoeE10WUNXa2plQnVkUUdlUHVHUTV4eldDRkc0cmwy?=
 =?utf-8?B?cytRREpHTUdHS1B0YVlGKzFlS1lJaW04aFlGdDdqaEhVZ2VLZ1JUQno5WVVo?=
 =?utf-8?B?U0tyS1AyaHJyZk9DOG9JSUs2YmxmaWVFLzdxRjVlTmh3TnFaYXZDQVZFM1Br?=
 =?utf-8?B?VUZqQy93d0xpd1JTcERySFFwekVrQ3lYT1R6Q3lzME93U002WG5BTDc1MjJm?=
 =?utf-8?B?S0s3dmsxRkN6cmVnK1I1ejBuUjRPR0wyQmdCNHFGbG10R0VzWGw4TmlGYWhY?=
 =?utf-8?B?NEphSStKTUxhVzVoS21hRTdiUWt1S2M3ZjhuV3JKVTZnVHVacHRYcTViVmRW?=
 =?utf-8?B?N0JScSsyTjZYcjIveHN6OWJqZnZtSG44K3VkM3BrbzJoK1JGN05OcVdLdTZY?=
 =?utf-8?B?YnJnSG5Lc2ZxdGdRUUxkSmlFL0IyNVJISlZFNk42VUtVRkZmM21zUjJmbllI?=
 =?utf-8?B?dFBDR3ovRTNKYm5hZEI1NTgyUG1FcFk2VDg5a0xDVnNSMHhRQTB2UHpDdjhL?=
 =?utf-8?B?bWFkRTNkQjB2N25NV2NTdlFtUFo4czgyTUYvQU5RWEJtdGVmWmRaWkJyOUtE?=
 =?utf-8?B?S0dZM042NWZpdVhBS3dZbGRneUgrUUEyamxqbkxscm9ESDFlazlBM3JDZmhn?=
 =?utf-8?B?ZWp5TFk2R25KVGROelJiSmVEU2tYOVN5QUsrMXViMjYvUmVvWlpRQnpuYTgr?=
 =?utf-8?B?ckhRREorcEdMblZQczBoblJGTnVuQzROSE8rZnJkLzI4cXI4TWlvT3VRQUt1?=
 =?utf-8?B?OHU0NjdoTXNscklxU0tZVkcrVWx6ejhxamo4R2ZMUnlSVU95aUlmS1IxclZW?=
 =?utf-8?B?OXRoNzJvSkEzdVlGUUlHdW5MSzNCc0w4VFhyQkNUOTJzOWVyMDNJazBaQlhL?=
 =?utf-8?B?TWVpZWcvNExMczU1TkVuNWdzSkRUeFZ4MnpLVkhkWEpMU1VLazYvK3FtUyto?=
 =?utf-8?B?cEVMV243SXpWTnAzSmZqMHhtRy9rSnNteFhDcmtLeTlaaU14TDlVREJWQ2o5?=
 =?utf-8?B?WnprYkg0TktnOFlJbGVUb250L05nYnVEcVBPUU1CeGs4RGluUXBRd0Q4ZWFD?=
 =?utf-8?B?Vy9RWWFSYTM3WmVMbHZOZVNqQWtaUmo5SlJxUDM2NTdZQjJzRXZXN2k2b0FV?=
 =?utf-8?B?MlZiMFJUNUFwNUdqZjVsTFNCSDFHYTVFSWE5dFc0WWplNnZUUjVoai9wVGpo?=
 =?utf-8?B?THFhZ2hLZU1JNjBsdi9paldvOU1ydUFGQU9XSXpiZTJUSFVZck9HdXpETVZT?=
 =?utf-8?B?RU1VWVl5T0V0anJTYW5kb1B6RWhoZTFUdWJkclEwZFk1aURHVEdHOHF1bUxs?=
 =?utf-8?B?RS9HcXhDeEtNUEM0eWoxRXBvZjlDVVlaODhSeXdNcUhNOGJKeWVWbEhBNHFh?=
 =?utf-8?B?bFYrQm5XUXV3Tm1SdEdCTGFNV1ZaZWtsMHdYUUxwNXREMkpMbjlRT2wwd01v?=
 =?utf-8?B?cUFUSUVuYW4xUXpZQWVGUFg5SGVxL3dMZHQ5WjhsREZkUmFaYzR1M1pRckhn?=
 =?utf-8?B?bU5wdEErMWVEbjJNa29DQ3k0S3VqQmdrSHRSaGkrZjN3NDdVK0cwVk9VSlFQ?=
 =?utf-8?B?bWV5R1NDeFNGaGhUUjZqTFd4a1JKMEswYUNkQXNtbUdPdDNuOFptTUZCNmFy?=
 =?utf-8?B?UEwwRWJ3SnpHY2JXbGNCNHplaGJlOHdueGZyMnpaTStha20rQmI2b2tMZnFS?=
 =?utf-8?B?eERtQU1iRkNrT2djcDlyeno1dGVRcG55STJoQ2RzdHcxZzI3b2tNeGMxTExa?=
 =?utf-8?B?N1hEMWh1Tzd6aUQ5a2tPUmYxQ3g3QUxhZyticVg1OHZLNUxVaHEzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e70cde-fd87-45c6-03b6-08deb2539c60
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 07:28:51.0328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI9WyRAtrkX2vGOicUKnsrHFJvji4u1xptLxl7pGyxTWffFwBGO9wKdhYrbhZjXn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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



On 5/5/26 08:34, Michal Simek wrote:
> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> 
> For MicroBlaze-V SPI boot, the u-boot-spl.elf should be embedded into
> the BRAM (Block RAM) of bitstream or rcdo. This requires SPL_REMAKE_ELF
> to be enabled so that the SPL ELF is generated during the build.
> 
> Enable SPL_REMAKE_ELF for MB-V devices to support this flow.
> 
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 4ff3bd6b6875..0f88826687ff 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -34,6 +34,7 @@ CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
> +CONFIG_SPL_REMAKE_ELF=y
>   # CONFIG_CMD_MII is not set
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_TIMER=y

Applied.
M
