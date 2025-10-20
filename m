Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F3CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 05:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EBC82C84;
	Mon, 20 Oct 2025 07:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swix2pqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22CF83043; Mon, 20 Oct 2025 07:51:50 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4868280422
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmXhwe7qHgJdyrU/WOfRIc6+/pShtZOZZvxxUi9WSuvowhV3Gm6bldE8tyIPNu5knF71BXb4pA83tmlLX4tiHiD/pggbet6yJI4Xb8+XtKQBZUOjPKm7pufauvaOuUB6HpQsTWUm4hU7yNtCEazGAUFejD+g4w3gfKu9CM3fgwEQgINm8l192W0j4gZOpnwOO2lbHj+Y/TXJUDQBEu7QqrhBXD6hSxSO6iAtyM6AqF1JK1x7H6xgKdMi27t0NGMgXouXpLzLwA/9lzcnRrQNS+4b2P8RoyCy+IN1AsL4GV/U9wQ12Nilo7QaMd8lsG13BgYQIj077vzlWc3kDT3fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E84oYaJOFz174lK1ReOJfZ+0VtX7yhgWsApRF6dOX4k=;
 b=NRZZ3XSXgnPZHCshzqQlKgih65GG5B9rMj+61IYYlHWqHF0HGeFOLdxc2nvSCOj9bSXBRclQpizRWtD4ehWMj9VKdk03wbGl5lDUwmCt8oFV60o67WLeYNz57qJKd0iJVTe291OE4PseiQ8jI0KRb7C7KMthaFZJUVW/IwCy8WQXUTCs4IC7AtQKhZYy1+OTC3YqcNhlii/SnMMEmePhwbYmeMWWkDHa7WWI9FGckdzDM5fzhqO5mkhDhGqTGX+9lcVyXXPVBxP6Fk5FTCExZwZ1Hd85vDw6BSKXFsQCkeYhMn8yiVohJOnIPHPVoiWEF62Z7DD3rGnnZ5eNy35GUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E84oYaJOFz174lK1ReOJfZ+0VtX7yhgWsApRF6dOX4k=;
 b=swix2pqblqTEcCXOC4ikYC9zQCMpJTKgVww77o30vHzSKp96jsqtgJS2J6c7SRBtson3xmHItdDNC4iDm5ojRy6iBXDoZVztdBrHArOdgjbFxkmJ8nQVjcQ8gONAPnq61CDTWAh0FaVxmBS4iKMyvPQ0TIspWmYg40qqj4mw+Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 20 Oct
 2025 05:51:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 05:51:38 +0000
Message-ID: <d710f2d3-4044-4a64-a85a-2650b3ca6238@amd.com>
Date: Mon, 20 Oct 2025 07:51:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
To: Ronald Wahl <ronald.wahl@legrand.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
 <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
 <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
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
In-Reply-To: <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: a82ebb13-2bf4-4ae8-d3ce-08de0f9cbc6f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkpYRGp6dEdGdnUyNmlyZVRWeVdBY1ptcjlDWjJPRHFnZWE3a1ovUWNrSzVE?=
 =?utf-8?B?TkZqWGhjMStkN01nWktjWktsNmFWWURrbThjNTZkVnNSQktWd0NwRE9EOFI1?=
 =?utf-8?B?Wmp1MlNoeGpkSXJHSEtIcTFRV0dUTUFkUU54OFhMeW11cHYzRDFyTUJnMTRx?=
 =?utf-8?B?Yjl3VEtkNStmY0lUcUwyRjZZendLaENLTFQ5czdhb1JhdU5Jb0dNQlFhRkNZ?=
 =?utf-8?B?YzgvSU5xZG9sY3UzUTErVWdzUWwwcnhremJrUXdqbzd4Rkk0a3VldERLeDVr?=
 =?utf-8?B?ekZObDdiRG1KMFdkVlEwbUtZV0ZoSlorcVI0NVBXZ0tUNmNqQXdFcnZQc3BU?=
 =?utf-8?B?cVVSRUxJZFlxWWZFSktjWTBHNUdrQ25hbWhtengxeTZrQ3BYN2Zmbmdmd01h?=
 =?utf-8?B?R2NOUXFMVWEvOEpUQUlKdGlRNnl2NldaK25tYTUzQ2cwOW56bjBHOWZTT0NE?=
 =?utf-8?B?T0c0ZnkyRnIwRHg1Smd0UGdLUkNUWUtGMjBObE8xVGlRWlByUldyMVpQVXVC?=
 =?utf-8?B?RUNId1E5ZWRpSkZudUFMWGRpbWJRdUNyTWRXQ3hvSDREcHBOanNTTDJiRng3?=
 =?utf-8?B?ZXJ4ZWlLeGxiczdHdXpDWDVLaGVSL29ZTzBzcDJybUpPNDVJWWxhQjlhWWtQ?=
 =?utf-8?B?Q1JOU0poNzRJWlBqRUZ1czFiRm1kTDF3RmVhdmxSS3N0ajgxM1ZMSmZkWkZD?=
 =?utf-8?B?emRraldWTVFUak1BcVdaaFYyOG5NVzJRN0RnUC9PKzFLWmNNaXBpUkFqWkhB?=
 =?utf-8?B?Vitya1piYlVENHpra3VOcFZkaGxnN1BSa2ZjMHZhb3VWTU9HSytmemhuVUEv?=
 =?utf-8?B?ekNwSGZkQm1GdERkakgwdEJ0Rm9hOW0zRFhET2NqaFAySURqc0E4S1Jnai9J?=
 =?utf-8?B?RHBqbzY4M2dEd3NwQWN6a3pTendXb1lEMkZuRVJBWllUZkQrZStaUE4zQnlq?=
 =?utf-8?B?cUd0Uy9MV1BiMktoVWVYM0JXSVpHdXFLMFE4Zk1aOHFaRHBiLzRWYjFOMXho?=
 =?utf-8?B?MG8yUk9pMXRkTCtBN3VuTE9naWFpRFc2aXNJZlB3bUlPaGxBNExVWDkxSkpu?=
 =?utf-8?B?MEdnVkdtOU9Cc1dSRFNlSmhGcDRWNEtPRVZZTmkzdVdNMUNDQTFKL3J1aU9E?=
 =?utf-8?B?SjkvRDBBSEJmOFIzeEJuaE56eUxFNXZRUExTSFdNQmYvZXZHZUVVeFczYk9v?=
 =?utf-8?B?aUJ3d1JPYTlseHVVYW5sZW9KMm1XenhYYitnYWRXM1o4TXQ1VlBPRVZNUHAy?=
 =?utf-8?B?Z2N3MUVyenpwZ1M4aVJqQUhhM2VMdUdxRTQzZE9aL0cvVmQ4SFcxTS9WM2I3?=
 =?utf-8?B?Smx0WHYxU3F1UjBxRVAxMEV6cVYwZjh3RDBJdmpwS29ES2pvaWlkU2VpZnVB?=
 =?utf-8?B?RHN1SDdHQ0R0eEpUaEZXT3ZOMGYwS3dGZkkyZnFIZEt6eE5HbTRsYjZBc3Nl?=
 =?utf-8?B?ZG9jenhjZFJUMDB2T1c5RUlSN0h1WnRiUDg5WHJFdjlpdXBiRzY5ZGREcXdm?=
 =?utf-8?B?MHhXeTJkNitXMjUzOVZ2OUJvaHFLeG82ZHhlMnpLdDFaeWh2U2pmVERvYUFT?=
 =?utf-8?B?UzRseGRjQXBBQklBREhlYW9TUjZ1T1V5ZGpYZjVGcUppYU5raXhQUld1RGxX?=
 =?utf-8?B?TitleDdyQlZCeVlReXdETHl3UEVyUDJ3VTViS2xycnBCTnJnOEJVSkdBVFQw?=
 =?utf-8?B?VFYxODBBRlFRTWRYYWRSUnFyaEV3MFN3a09kaHFSYnJ5bXhsUU9zV1E3RTlD?=
 =?utf-8?B?S3dUSzdpZUxUS2lzNDkzandqb0J4WkhuVUN3YnFEWTg2dUtYRUhNWVQwWC8z?=
 =?utf-8?B?Qlp3eHBGbTRhdTg4c2lIYnc5TU81SmRWZ2ZmeTI2MVAzbjdJRCtkdGdJcmdz?=
 =?utf-8?B?TnkzV1Y4emZTYXpPZG52QVd2UEU4SDNna2NUWHp1cG8rV2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dGVnBWdGJmUDFWcXpNUE52bEJZTDBjbE53MndqdEhTU3JMQmtNYTJNRTNr?=
 =?utf-8?B?SmpDSWJqaGNlYzVVK2w3YkMwSE1hYjlZaG83QnkrMlA0V0FwU3o3UVBmMU0z?=
 =?utf-8?B?dEtkcnNVcFNYL1JjVEZnVjF5Zk1sSXhjWE1QRG5aV0FGeUZSWC9PaUJxeVNH?=
 =?utf-8?B?MUV5TkFCMm5nVUcwNEhmU2tBcEkra1dmZjNleTJ5eldpWEJFcFBUTlVXQnlB?=
 =?utf-8?B?dmJJblFhUVo2MWlPc3ZPOUw4S3F3TzFnYSsrdHJQTzJkSXZtV043SThudUZZ?=
 =?utf-8?B?VWxrRm5XMVl4UzhlY3Y2WDdoUzY0V1VOZk05SWRJT0V0Zis5S0N1UHdLMnhz?=
 =?utf-8?B?WVJXNitVWkErSTJ5YkQxLzFqQkRqbTRtRGd4dW9SWktaUGVPSmJsaWpyNVFL?=
 =?utf-8?B?YTZKdkJZSVlpMUlIZ1ZIZ1ErREF3Uk1nWit4ZW41dTNhL3VqeXZhcmFkeTJ6?=
 =?utf-8?B?aGRxVVFTWWhCaFplbmVoQ2ZRaGZibE1QM1AwNlFYN3QxZHBWL0lUOGp4dzdH?=
 =?utf-8?B?NDY1anJYWWE5RHFRMkZhTmVtdmY1RWxzVHVXaUtiTTUvemIrN1F6Z3NNT05U?=
 =?utf-8?B?Nm1ZQWlRMFZHMG82dHoweXVjQXkzREZqaU9mclh1dHp4d1gva1pMNDhqV0dh?=
 =?utf-8?B?MThRVXMzK0lOWCtoNDQ3dGtBMGRKN09yR2V4a0J2d2FKeUx3Ly9oLzBRWkVK?=
 =?utf-8?B?REpyd0hKRHJzVDljY1FUOVI5ZG9USFJZUDFKQ0lXSFRPaVZMMXh2ZUUzREZs?=
 =?utf-8?B?UTZZMytQWDY0Nmljb2p5V1BPbHRVYUREbWF3MGdtNFUzSG9ZekpEVVN2eERu?=
 =?utf-8?B?SGdEeW12M05LV1loeGRaV1pKSFg0S0o5TUN4MnpwWjA5WnYrZ1dRVVFHdmxJ?=
 =?utf-8?B?T3JQcHNVVXU1S0dqNUJTNUp4VGZNeGNiYTB4Z3FzQUExK0orVTFmWFJwTk94?=
 =?utf-8?B?aTQ2bnFURStvVmx3Z2VPT0lMNTJuYUNISjZSM1ZBd25tRnBjTUZsTXFDREpv?=
 =?utf-8?B?UGd1ZmRQQ2prN04vZWxGSzVvWDRWOFVZUHJzdGJtajlIckdsd2s2eFpicnVq?=
 =?utf-8?B?NmtWWkdBdEJlMkVlN1ZFeGlyTDlTemZsendib1N4OVk1YnJIbHh2cjc3WmIr?=
 =?utf-8?B?L0RKVlk4WmpDNWljOHFOWDFnMkUwenRRRzE0MWtRU1duL3g2Qk50bjVCUVN0?=
 =?utf-8?B?cWh6TUc3Wno1OEpwK04xRHdkTnBHSm92YzRjTEFWS1B0dGZoeUZlVWZaRkpJ?=
 =?utf-8?B?N3gvTktadjJzQmxzKzZBeFhUR25GZHpreUtKNC9pVmxQdkcvSDFMbnV4L1R4?=
 =?utf-8?B?dmV4WEU1TEY4VFVSTU5UQ1VCUnVKWURIWkdwdjBiVWp2MWV0aVpPci82WnNQ?=
 =?utf-8?B?KzMzRnlBK3lma2xibW9SNmFZamZnMVVEQmpKQ2JCMk13bWpsNHByTWFNTldU?=
 =?utf-8?B?K2toM3dmQzkxVUxrSTRvbGZsL0FySlZoY3QzZVhrWElBWkx3L3VpWk1sTTY2?=
 =?utf-8?B?U3NCK2t1K0VxVGZMcFllaEVvM3B6bUZLNVg3dkJWMkgrYUVqTWh1STV2MnNL?=
 =?utf-8?B?bG9GM1E0NmxQNmRDTXZGeDFNYzhEbXhDQnd5cTNtVXp1UkttZFduT0hsV1V5?=
 =?utf-8?B?WWVXOTVmUlgveTIrK08rckdsS3E2dDd4c3ZvSEdMRWU2UmR3QmloSDJJM1RG?=
 =?utf-8?B?YnE3T0llK0tCem9tQTRxdWZBa3RMUE1XK2Zja3Vwekcrbm9SbFE2YTJQRmkx?=
 =?utf-8?B?a2VhTVlhYXVNR1JpVVovRmUxYXVEK2pqN3R4bFMvNnJqL054cVZxbEgzSDFl?=
 =?utf-8?B?TCtwN2g3VFA5R0tWU0h6UXFhVTY3dFNZeGFWeVY3U1prclRTYTRLQ2lJWG1Z?=
 =?utf-8?B?R3lLZ0VCS1I4ZTZFcVpQK1d4aDdnQlVXUzdNUDZ3Z1ZnN2dsam1IT2lOSUdB?=
 =?utf-8?B?MFZUWlVEcVpKd3RtWXg2NkEwdkVRV0p0elMxRFhHT2E1dC93dWF5bFFGb0R3?=
 =?utf-8?B?d2VuRFcvM1lZblZWYmZFdTlxZGEvQWJEWHRKNmVzVC9EMGJoejBvR3g4b2Z6?=
 =?utf-8?B?c25abHlzeTNnZElXSzNKcjg2UzdXc0ZBRUJvT0oxL0JrS0lQdzJQajJmQ2hD?=
 =?utf-8?Q?EgYsrgnRB35spu8Wt7MkMYi+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82ebb13-2bf4-4ae8-d3ce-08de0f9cbc6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 05:51:38.5746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMAXVOgas05+MTxEKT/k43fIgx/vbj9cGl2WKVRwn0X/1i3OnXEL2fM5X4t4Fj9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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

Hi,

On 10/20/25 00:36, Ronald Wahl wrote:
> On 20.10.25 00:03, E Shattow wrote:
>> On 10/9/25 03:34, Michal Simek wrote:
>>> Remove cdns,is-dma DT property handling. Property is not the part of DT
>>> binding and it is also hardcoded to value 1 in all DTs that's why remove it
>>> because none is also testing value 0.
>>> If there is any use case when this configuration should be supported this
>>> patch can be reverted.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Remove other functions which are reported as unused by gitlab CI.
>>>
>>> v1: https://lore.kernel.org/r/ 
>>> c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com>>> ---
>>>   arch/arm/dts/versal-mini-ospi.dtsi     |   1 -
>>>   arch/arm/dts/versal-net-mini-ospi.dtsi |   1 -
>>>   drivers/spi/cadence_qspi.c             |   8 +-
>>>   drivers/spi/cadence_qspi.h             |   5 --
>>>   drivers/spi/cadence_qspi_apb.c         | 119 -------------------------
>>>   5 files changed, 1 insertion(+), 133 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini- 
>>> ospi.dtsi
>>> index eec2a08e7c70..6991f6a51db0 100644
>>> --- a/arch/arm/dts/versal-mini-ospi.dtsi
>>> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
>>> @@ -38,7 +38,6 @@
>>>                num-cs = <1>;
>>>                cdns,fifo-depth = <256>;
>>>                cdns,fifo-width = <4>;
>>> -             cdns,is-dma = <1>;
>>>                cdns,trigger-address = <0xc0000000>;
>>>                #address-cells = <1>;
>>>                #size-cells = <0>;
>>> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal- 
>>> net-mini-ospi.dtsi
>>> index 1c94b352dc97..d2d5ec8e5cbf 100644
>>> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
>>> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
>>> @@ -52,7 +52,6 @@
>>>                num-cs = <1>;
>>>                cdns,fifo-depth = <256>;
>>>                cdns,fifo-width = <4>;
>>> -             cdns,is-dma = <1>;
>>>                cdns,is-stig-pgm = <1>;
>>>                cdns,trigger-address = <0xc0000000>;
>>>                #address-cells = <1>;
>>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>>> index 599596f9f087..849bd930edf0 100644
>>> --- a/drivers/spi/cadence_qspi.c
>>> +++ b/drivers/spi/cadence_qspi.c
>>> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>>>
>>>        priv->regbase           = plat->regbase;
>>>        priv->ahbbase           = plat->ahbbase;
>>> -     priv->is_dma            = plat->is_dma;
>>>        priv->is_decoded_cs     = plat->is_decoded_cs;
>>>        priv->fifo_depth        = plat->fifo_depth;
>>>        priv->fifo_width        = plat->fifo_width;
>>> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>>>        case CQSPI_READ:
>>>                err = cadence_qspi_apb_read_setup(priv, op);
>>>                if (!err) {
>>> -                     if (priv->is_dma)
>>> -                             err = cadence_qspi_apb_dma_read(priv, op);
>>> -                     else
>>> -                             err = cadence_qspi_apb_read_execute(priv, op);
>>> +                     err = cadence_qspi_apb_dma_read(priv, op);
>>>                }
>>>                break;
>>>        case CQSPI_WRITE:
>>> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
>>>        if (plat->ahbsize >= SZ_8M)
>>>                priv->use_dac_mode = true;
>>>
>>> -     plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
>>> -
>>>        /* All other parameters are embedded in the child node */
>>>        subnode = cadence_qspi_get_subnode(bus);
>>>        if (!ofnode_valid(subnode)) {
>>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>>> index 879e7f8dbfb8..10c4ad14cc05 100644
>>> --- a/drivers/spi/cadence_qspi.h
>>> +++ b/drivers/spi/cadence_qspi.h
>>> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>>>        u32             tchsh_ns;
>>>        u32             tslch_ns;
>>>        u32             quirks;
>>> -
>>> -     bool            is_dma;
>>>   };
>>>
>>>   struct cadence_spi_priv {
>>> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>>>        bool            ddr_init;
>>>        bool            is_decoded_cs;
>>>        bool            use_dac_mode;
>>> -     bool            is_dma;
>>>
>>>        /* Transaction protocol parameters. */
>>>        u8              inst_width;
>>> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct 
>>> cadence_spi_priv *priv,
>>>
>>>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>>>                                const struct spi_mem_op *op);
>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>> -                               const struct spi_mem_op *op);
>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>                                 const struct spi_mem_op *op);
>>>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
>>> index 4696c09f754b..58be017720bc 100644
>>> --- a/drivers/spi/cadence_qspi_apb.c
>>> +++ b/drivers/spi/cadence_qspi_apb.c
>>> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv 
>>> *priv,
>>>        return 0;
>>>   }
>>>
>>> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv *priv)
>>> -{
>>> -     u32 reg = readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
>>> -     reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
>>> -     return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>>> -}
>>> -
>>> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
>>> -{
>>> -     unsigned int timeout = 10000;
>>> -     u32 reg;
>>> -
>>> -     while (timeout--) {
>>> -             reg = cadence_qspi_get_rd_sram_level(priv);
>>> -             if (reg)
>>> -                     return reg;
>>> -             udelay(1);
>>> -     }
>>> -
>>> -     return -ETIMEDOUT;
>>> -}
>>> -
>>> -static int
>>> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
>>> -                                    unsigned int n_rx, u8 *rxbuf)
>>> -{
>>> -     unsigned int remaining = n_rx;
>>> -     unsigned int bytes_to_read = 0;
>>> -     int ret;
>>> -
>>> -     writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
>>> -
>>> -     /* Start the indirect read transfer */
>>> -     writel(CQSPI_REG_INDIRECTRD_START,
>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>> -
>>> -     while (remaining > 0) {
>>> -             ret = cadence_qspi_wait_for_data(priv);
>>> -             if (ret < 0) {
>>> -                     printf("Indirect write timed out (%i)\n", ret);
>>> -                     goto failrd;
>>> -             }
>>> -
>>> -             bytes_to_read = ret;
>>> -
>>> -             while (bytes_to_read != 0) {
>>> -                     bytes_to_read *= priv->fifo_width;
>>> -                     bytes_to_read = bytes_to_read > remaining ?
>>> -                                     remaining : bytes_to_read;
>>> -                     /*
>>> -                      * Handle non-4-byte aligned access to avoid
>>> -                      * data abort.
>>> -                      */
>>> -                     if (((uintptr_t)rxbuf % 4) || (bytes_to_read % 4))
>>> -                             readsb(priv->ahbbase, rxbuf, bytes_to_read);
>>> -                     else
>>> -                             readsl(priv->ahbbase, rxbuf,
>>> -                                    bytes_to_read >> 2);
>>> -                     rxbuf += bytes_to_read;
>>> -                     remaining -= bytes_to_read;
>>> -                     bytes_to_read = cadence_qspi_get_rd_sram_level(priv);
>>> -             }
>>> -     }
>>> -
>>> -     /* Check indirect done status */
>>> -     ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>> -                             CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
>>> -     if (ret) {
>>> -             printf("Indirect read completion error (%i)\n", ret);
>>> -             goto failrd;
>>> -     }
>>> -
>>> -     /* Clear indirect completion status */
>>> -     writel(CQSPI_REG_INDIRECTRD_DONE,
>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>> -
>>> -     /* Check indirect done status */
>>> -     ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>> -                             CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
>>> -     if (ret) {
>>> -             printf("Indirect read clear completion error (%i)\n", ret);
>>> -             goto failrd;
>>> -     }
>>> -
>>> -     /* Wait til QSPI is idle */
>>> -     if (!cadence_qspi_wait_idle(priv->regbase))
>>> -             return -EIO;
>>> -
>>> -     return 0;
>>> -
>>> -failrd:
>>> -     /* Cancel the indirect read */
>>> -     writel(CQSPI_REG_INDIRECTRD_CANCEL,
>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>> -     return ret;
>>> -}
>>> -
>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>> -                               const struct spi_mem_op *op)
>>> -{
>>> -     u64 from = op->addr.val;
>>> -     void *buf = op->data.buf.in;
>>> -     size_t len = op->data.nbytes;
>>> -
>>> -     cadence_qspi_apb_enable_linear_mode(true);
>>> -
>>> -     if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
>>> -             if (len < 256 ||
>>> -                 dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
>>> -                     memcpy_fromio(buf, priv->ahbbase + from, len);
>>> -             }
>>> -             if (!cadence_qspi_wait_idle(priv->regbase))
>>> -                     return -EIO;
>>> -             return 0;
>>> -     }
>>> -
>>> -     return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
>>> -}
>>> -
>>>   /* Opcode + Address (3/4 bytes) */
>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>                                 const struct spi_mem_op *op)
>>
>> Your patch results in corrupted SPI NOR flash writing from U-Boot on
>> starfive_visionfive2_defconfig target board Pine64 Star64:
>>
>> a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
>> commit a040578d8270ed8788d7663808ea63ce5ffd7840
>> Author: Michal Simek <michal.simek@amd.com>
>> Date:   Thu Oct 9 12:34:48 2025 +0200
>>
>>      spi: cadence-qspi: Remove cdns,is-dma property handling
>>
>> Steps to reproduce with Star64:
>>
>> 1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
>> 2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
>> 3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
>> 4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` or
>> similar for serving U-Boot SPL and U-Boot Main to save some time with
>> UART transfer:
>> 4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out && sf
>> update $loadaddr 0 $filesize
>> 4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadaddr
>> 100000 $filesize
>>
>> Repeat steps 4a and 4b, note that each time all bytes are written and no
>> bytes are skipped. Written data is wrong and device unsuccessfully boots
>> in SPI NOR flash BootROM loader configuration showing wrong information
>> to output.
>>
>> Please follow up with your analysis of why these changes have this effect.
> 
> I guess this is because the committer didn't take into account that when
> a DT did not mention the property then it is 0 (false).
> 
> I assume TI K3 hardware is affected as well. So I think the patch must
> be reverted.

Are you using cadence-qspi in non DMA mode? DT property shouldn't be introduced 
in the first place that's why it was removed.

Thanks,
Michal


