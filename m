Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C954C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 11:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C7780326;
	Tue, 21 Jan 2025 12:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TC+iE0e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD35D805C5; Tue, 21 Jan 2025 12:44:51 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A22D801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 12:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLU78KMX9P0SCk4pE7SHV7h5zDH+qgZ6feLFx7k4PhdHM1Ae5JUNtk/ff3Pi1dDdFRCdB+4HAsRB2hYOEyrqpHQtFn4rE24OC9nuUl+V/YTwKrWge9CuudC9C3mXzVHuJ88v4aOg69LHB53III6GfQRbkFnWy6IZQ+Y8sD3AnvsHabF4oJAR+B4e9sf8UlMHtz0eNYUsyJ4w1qjFdoyjf7gW3Y8zMKc7eb12/6Wl0tqpUbQ5j8hQNdo9KUGAIDW7zsvJbeOgcfjBGDgOFZ7n4t321rym5SVzsXzz+vEGQJn8qIiQpdzChRQ+dHOgOm8rqAmKPr0v/n6u+bVqW+336Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNsL6uqE75pHPUuqrTpiCe/ILK1jtxYl8LQnser2Edg=;
 b=pGOuN2FhzXlmhDlolPyl1TNmrdPu80ekC+5QWZZgglKcSd3stL+Gt6pfqvZE44dH7Ldgoq3j4GJA581yoS5fIUt3FiEm+GNvxeXleA/i4TfZomH0zQYiiMJZE5ukNygogNR0eeIre4cRq/ObjdwnRSI8bLoILtrl49jbr1OfIX+6qROHbpteatUo+e0RJxgRAPJrH4G9Zzl/C+bXXYyfwCT7f7UMS8nIuz4aSnN4UDyKWKQA4V7mgEGi4Z1qdd6eCwFT0tRC0Jxtwp6+0y5nVQwWod5q5SVWwOFJd9RPwG/tNO59yfu3s1A1MhLJ8fyeHryykgOyQAtJcyYh9iV/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNsL6uqE75pHPUuqrTpiCe/ILK1jtxYl8LQnser2Edg=;
 b=TC+iE0e6CWc3EyxKf4W+KoHIXOPySbqbEGT5QlgkHcDN1KUY+5zFtkdHsmYjjgXABtelsB5edQ2uPDpo2eRRSI1Bwdraoo09RarAd1AombQXDaPbB3Gw9vjEyngTiJNEhwty96/p0a1kXMxkPVwSaOoXYjkT4m0E4Q7cODHmQik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 11:44:45 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 11:44:45 +0000
Message-ID: <24dc7f4c-62bb-46e4-b7d7-6c3aa472c36f@amd.com>
Date: Tue, 21 Jan 2025 12:44:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] Introduce coroutines framework
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
References: <cover.1737380886.git.jerome.forissier@linaro.org>
 <e17799b6938d4afe08b80fc20b70f4d3a81db848.1737380886.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e17799b6938d4afe08b80fc20b70f4d3a81db848.1737380886.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6b36a0-b879-45c6-13b9-08dd3a110056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0pwMUthN3JGVUZheTdLaXNPTC9vOFBvUWtSTEN2VHJRUDVCNW9Ic0VVTFdK?=
 =?utf-8?B?djZNNEV6ZkVvWVVVUjFqRmRaWEhNd00xUDJUYlF3L2dpQnZkMGJOTWswSnNi?=
 =?utf-8?B?YlhNSzdIeHdhTWlpRmIyOXcyNnBhUEs5cXh4djRFL1NFZEdYZ2NMNEdpUmRX?=
 =?utf-8?B?Zks5K2d6eGdSWWZub1VkRjBiVGpvSFQ5QmdnMUVHa2Nsd05Fd1IraXNUdzFT?=
 =?utf-8?B?a3ZXRyt4SGRjNkdNYmRCaEQwTm90bjZEc3NuUDNLREpnRUJybEROREFtNkVB?=
 =?utf-8?B?VWNPRlhDTVpkdE85Y3ZwMEhQZjhuV2lhM1FwejhweTd4NjE5NFh4RDZjK0l6?=
 =?utf-8?B?bmNhcGFiT016VDhLSWswOVdRa3ZZLzhhMmdtZ3FtTVFxV1EwQVZCaFQ1OGVt?=
 =?utf-8?B?bXJNSldNQnBmcW5XNWdIVVQzS1JXa3MxNXBTMXpkNGFyb3lPZzRncUEzenB2?=
 =?utf-8?B?Szd6ZCtLT3E5YVZZcytoR0ZQNHd1Q0t2UkF1aW5tUFQvMzUrUkFBQzViQjZr?=
 =?utf-8?B?dGs4YXppaHpOTzJyZTcxQTRweTB3TlNoSElLbmZ6NUlpc2lCTWxZS0s1b1kx?=
 =?utf-8?B?SC9IY08rWXFtelBQb0Y5UjBXTlRyc21yTjZaK2MrbHIwcGJTdm1ubndnWlNt?=
 =?utf-8?B?ZlJVcnpXUTVweUtpbXFydFJyY3VUeklGcmVremFJb2l3cmcwVmRDS0Nidmdn?=
 =?utf-8?B?U3ZaR2N3d3dLV3c1TTRFUW9jME94M2k5SnQ0S296M1hCbUhnVUtSM0FuZGhF?=
 =?utf-8?B?emw2YjhFRm9mT3JzcVBVVjJDZnVBQkcwdVBQbXptbWo5TDVPclVDWEJReVFS?=
 =?utf-8?B?dXRCd0FENVlNeEUzMGxyVGtScXV4Wi9oUHo2Nk05dEJpc1hDMllhTG5UZU0x?=
 =?utf-8?B?R0I1eTI4QlFEbEFFN0JiZjF5N01kdzJqMnQrT0MzTkRJN05ORitQZkNKYzcz?=
 =?utf-8?B?c2VTN1N4bE0zQy9FT1RiVUtRQjhhQmp6NWV4cEhGTHlVV215THEzekpaUG9k?=
 =?utf-8?B?Vk5Fd2lDSmtsNlRYbmZmRXZNbWtKbGdqYi9kSkhtRTFvN3JIOWcwLy9lWjZQ?=
 =?utf-8?B?aGZKcWJTSWRNWm1mL3ZueTVUZWdyM1p4dEJobm15QzRjMHk0YzVHR0hxb1R3?=
 =?utf-8?B?LzhCQkRVbEEzMlk1UGJQcmdCTm9CYXI2bXZoYy9velpKQkxiMzZJTy9Jc0cy?=
 =?utf-8?B?K09mZjl3T1I4eUpua2tWOTF5NEs5NzhQajl0blMwZGlEWXI2NVZxRlhudC9p?=
 =?utf-8?B?NGNOYURMNmFTYkpjTVRYczlacDRSYi8yQy9wcUN2M3lkc05HMjZjRjhFUkNi?=
 =?utf-8?B?NGlnSUJvb2Jyei8xd08rMWZPVmhCVmhieWcwVzNqTzE4dUhTWW5td25Dd3hR?=
 =?utf-8?B?UExqMld4TGkwN3N6MFc4UElxU2l1Nk5ZMWJJcVZGNXNSRjBJN3NQbDFVSDFa?=
 =?utf-8?B?SnU4eVFqeWYybXBJaGJTaTBIZFZuOHIwQjRqejMxdjFZK1B5VGVZQk0yZEND?=
 =?utf-8?B?VDNDYjVmRWpna0s1UlBMSVpVQ2RBc0poTWlvTXgzNVBjYUZuRTVtWjV1dXlV?=
 =?utf-8?B?MGl3eVdFZ2wyWlVySEdIYWxXc2dQTFJxemNFOWpCNmg1NWQ5M2ZXL1E4RnN2?=
 =?utf-8?B?YzQ3eFFsVy9Xenc2WVF6QXYwcmc4ZENUTGt0UWw5YmthamozUThwYW5oQVNQ?=
 =?utf-8?B?Rk1ieUtGK2R6WERXQ2NEQnVoei9tcnRJUEV6VWtuMmt2RzlSeFhuLzF3dTZs?=
 =?utf-8?B?Y1dzazJWN0FnNVdKWndaMlZWazlIdmpZbmROUjN6c0xTQUZPQ1ZQTUV3RTB3?=
 =?utf-8?B?alNuNzIvaXdPK0ZCQmZyYVNrR2I3K0NMM0dkbGkyS09TOEVZblJCMVdTQnRp?=
 =?utf-8?Q?hcL1vWJBix2P1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkk3NkdOZll5RUhBRVM4bVZidGJKM2VpcWRmVm40aUl4bHhnNFhLcWJGa2RD?=
 =?utf-8?B?UHZlRlhFTEgwZTNxZXhQV1lRdGQ5aFg2RVBEV1VKSS9ZeSsxUlJQOXZEekhB?=
 =?utf-8?B?NTZGbG1ta0JuMkFaQTJZOWFyblAvQS9TSHJ3MnNuU1EyQVM1dWpTREkyM0RO?=
 =?utf-8?B?VWhWZ3BKTVpYbWsrODd0UW4yUS9keWRCNkE4bjBQQ09VbVorM3R1cmx4NGpk?=
 =?utf-8?B?eWNHc05rTDBXWCs0cm5DaDRDTGlyMy9oWW9QcVYxUitxa3JFZ2RJMlMzSis2?=
 =?utf-8?B?Vnd5U3JHWnlCM3U0K0RzRk9qcFhNY2RieEV0NDg2Tk1TdnB6OGVxajNmNmpY?=
 =?utf-8?B?elROVWxMaTJ3NkFrRnduZ2h0ZXNEWnpRSkFKRU9nTFNEaEZPYVRpcy9GNVR1?=
 =?utf-8?B?VzloV1AxVU1zK2JGZFdFQWZzL2FmYlBxNHJJaHk4cXZwK21BaFVjNFBkMTMr?=
 =?utf-8?B?UUl4NzREOUVOazUrbk9wdlk2VG9LTllncCtkeGtVNDNtSXNldm8wMEFTUm9n?=
 =?utf-8?B?cHMrQ1VId0gybDc0UnpUbFRMWEticTBxdFFPbXovVml3blcreHEwM0JNTkxP?=
 =?utf-8?B?QkZaY3BaRmpwdFNETk13RFRFSHJSSTNGcGl3bXVhQ1JnUXR0UlNRcEhUZFVR?=
 =?utf-8?B?K3EycW1ONkZDaGtrYnQ3dC9kNUc3SjN0eWpSU1Zna25LaWNHTk5sQUJxVDNP?=
 =?utf-8?B?QkdGcy90RVhSZUxCL3RkTVI2bGxYV3dDdVo3aFMzR3pZL3pHbjdpRGV1c3Rh?=
 =?utf-8?B?eGFSSlMxeXpkd3hGcjI2Q3JTM0tzTnFKQkh3YmhyTHpJOGVpaW1vUTcxV0xO?=
 =?utf-8?B?WHdSYTlSVkNKc3NmRHZJaE9odXgwWC8zVmI4VDFQQ2NNN1BMbGtTL3EwZTlk?=
 =?utf-8?B?VklQMXhKekFwUWRESTdlVExOS3lQS0EwdjQ4T2FzS1lwOVFhdFl4bmUyYmdp?=
 =?utf-8?B?ZmxJVEI1S2o0dGRKam9FangzZXh6dUJJRnlCODFJQ2JPci9pUnppK3RIaGM4?=
 =?utf-8?B?aFh0SGx2dzlxaWdCeHpGSXBwWnEzNGRKSnltbWVmOXQzOFhRbjVnUUhLWnZp?=
 =?utf-8?B?NCsrT3JldTIyR3BMTVhQVklnYTlQaS9hbldHcDFEeVpGRGdYcEw3UE5jWHJF?=
 =?utf-8?B?RHhXdXhNZjN6NEJ0dnFMYzlHblhTZllUNHIwVi9EdWd0aGdyUC9EYXpMYVdL?=
 =?utf-8?B?cGYxZGdiTnNBL1MzWjFBTk1GeHZCeDRsaFlET01SMUxlWllvbDdYNXUveDls?=
 =?utf-8?B?bTNock9yOGhaVTlkQzE5NkZQNjM2TkQzS25WT09CMVZQL3RjcTlCWTlsRlBM?=
 =?utf-8?B?YXBVbVZIWENKZUVIK0FBVFRYSlNza2NjeGhHYUVCdkFRZGZPczc2RkthSVBN?=
 =?utf-8?B?eWgxbjQvT1B6ZTBnUWtQTTR5YUdPQmNHeE5MNU02cTAxaVJFckhyaHRQTlU0?=
 =?utf-8?B?ckRnSzQwR3JYQXo1d2UvTDZRQ2F3c0JsVDhYYVB1UUc4RThFUUMwMGp5WFVr?=
 =?utf-8?B?YTd3RHR2bm90QStOK2FadnJNaUZJZWRNcG9nTXlrM1J4Vk1YR1hBR3E1VjhV?=
 =?utf-8?B?S1pJYmZGekdwbU81bWR5NU53YWJpbVo2WjRWRENNZ3JmL2pLK0g5Q3VYbzYy?=
 =?utf-8?B?Tk04Qys1Ujc4bXB4dzIzMmJHZXJweTJBaTVWaFF5YjZsS3UrMGNpNWhnd0dN?=
 =?utf-8?B?a3hWeElUMlRBdjgrcW93cHFNeVJscVJYcFo0WXZ2aTlFdTZaY0NIRHJNdkdD?=
 =?utf-8?B?LzNpMm5ad0w3ZnRyV1BJSTBXaWtsWkdpdXI2VlhSY3RBNUZUYjAraVJiUFhw?=
 =?utf-8?B?S1JkWnQ5MWZKNEF0MGhpMUxpRXErMmZGVkdGL0FGbjVTRnRPMFhqbEorQzls?=
 =?utf-8?B?K0l0R3h1N1dNODd6NVJuekdUZURkTTRDUzBISG1HZWlMUXo0RytOWGRpMDNJ?=
 =?utf-8?B?cUlKb0ZJMlNiZzJkYWw4SEZTcHlVTmorNVJCU2w0Z005Nld4QnUwUnl5bWEw?=
 =?utf-8?B?WXhMZnRTcTRaZ1d1RFJQa0dVWFh2T2Z0RWt5YjJhTmJCUzFGbE8zM2ZCSVVt?=
 =?utf-8?B?SzUydmY2U2dNWVF3VkhYWGtydWxraDBJMTNHUWhLMzdMZFBSTUhCZTYzbXp3?=
 =?utf-8?Q?CCT6RJkzkIIZO3R6uVw3rOiac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6b36a0-b879-45c6-13b9-08dd3a110056
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 11:44:45.3276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFhqrrGBrqLe94Pm5Gx0XNCH/qCI1hdEkW5gAsQSOtHVJtyEfEHE/bB6DSGFbPwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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



On 1/20/25 14:50, Jerome Forissier wrote:
> Adds the COROUTINES Kconfig symbol which introduces a new internal API
> for coroutines support. As explained in the Kconfig file, this is meant
> to provide some kind of cooperative multi-tasking with the goal to
> improve performance by overlapping lengthy operations.
> 
> The API as well as the implementation is very much inspired from libaco
> [1]. The reference implementation is simplified to remove all things
> not needed in U-Boot, the coding style is updated, and the aco_ prefix
> is replaced by co_.
> 
> I believe the stack handling could be simplified: the stack of the main
> coroutine could probably probably be used by the secondary coroutines
> instead of allocating a new stack dynamically.
> 
> Only i386, x86_64 and aarch64 are supported at the moment. Other
> architectures need to provide a _co_switch() function in assembly.
> 
> Only aarch64 has been tested.

I can't see the reason why to keep x86 around if it is not tested.

Licenses should be cleared for all files.

Also I think this mostly should target full u-boot and not really TPL/SPL as of 
today.

I have applied this patch to measure time difference on kv260 and kd240 and 
pretty much the time is the same.

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 94160f4bd86c..18d2260b8c11 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -258,6 +258,7 @@ extern int udelay_yield;
  efi_status_t efi_init_obj_list(void)
  {
         efi_status_t ret = EFI_SUCCESS;
+       ulong t0, t1;
  #if CONFIG_IS_ENABLED(COROUTINES)
         struct co_stack *stk = NULL;
         struct co *main_co = NULL;
@@ -272,6 +273,7 @@ efi_status_t efi_init_obj_list(void)
         /* Set up console modes */
         efi_setup_console_size();

+       t0 = timer_get_us();
  #if CONFIG_IS_ENABLED(COROUTINES)
         main_co = co_create(NULL, NULL, 0, NULL, NULL);
         if (!main_co) {
@@ -333,6 +335,9 @@ efi_status_t efi_init_obj_list(void)
                         efi_obj_list_initialized = ret;
         }
  #endif
+       t1 = timer_get_us();
+
+       printf("time counted %ld\n", t1 - t0);

         /* Initialize variable services */
         ret = efi_init_variables();

Please correct me if you have measured it differently.

Thanks,
Michal
