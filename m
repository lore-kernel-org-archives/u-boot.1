Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51BD2505A
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B0E83CBD;
	Mon, 12 Jan 2026 10:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlkkaoug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD9883D0B; Mon, 12 Jan 2026 10:31:35 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E206983CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIQJkw+KD846TuA9wQBv3yMVbIWL7FNzUCCmXbZzDMx/90+qrmzY22qVlxiRZiv/BawOnuiWwtGhFgowZRNf7fDjppHTneMz6o6/GXv2JLKL6zU5gGUB6tn49CzJ/KkDR90x9ByTOGUs+c81rTRbCiN+or/8sRqdB7vNsEsHCNP9jv/St7Dgjw+TF3MGQEW1THkQmibzQ8Gle56E6owLf/OvM//Ot6dyyIXpAQNrJnoy5A3X1ZPsBKSjgj6NttT5BHunY3bn5k1O+mvmmU+2lZOrTrCGB0PySqBqZ/KKaOmJp38iA72aYxCkREeGlLQxqXYNAeWasEFJ/zFHuF3SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZkIQFvPsgl39mHC4LWJreIYKD0ozDvn9bMRvjrjpSA=;
 b=D0lGyK6P0S1/sXXwyrpIbqVF++nw+mr0WTxUXKDL/zCPYUGRShHeu91ZWQL+5RxxvFrl0UNnKxVi19TD0at22mEeK0zxhF8oUOT76JP6aHsnULvwdTFLyTnAna66ftoBoCuzkdh9njPytebnCxnpzxh9gqUZKE15Fq4FAZLxP4EAC/BzBgr+BGohkHTWEvy9vkZ2t9IZ2p2zLqVpfqDINpZIy8aMZh01vvyCUH2W1/KZNARvB2dixFWc37WmgfNWTVZwUN06YOSBDiGAm2Y5ZuwlrBqvNGTGo6t//xvFKwyE0Uv/EJ+jVcT2zR3W+caH2UhN9cjVLjmX9h7KbH4PFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZkIQFvPsgl39mHC4LWJreIYKD0ozDvn9bMRvjrjpSA=;
 b=qlkkaougffcf3BPQaMarb9RvksNbd5pLq6goSH4EdTuANf+5z1nJRwleKZKL59hGJ5zM2In3QuI7B7S7aKi/31KmachCFRQav0j8/RoENKv3xEMp5A4lGMEvAvGaR4pVjUYPimUoXzv0paIJS6a9KHYazVMLbGrj+PHbhmBDTCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:31:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:31:28 +0000
Message-ID: <2c7641bc-abe6-432f-b0ee-ef13b713dccb@amd.com>
Date: Mon, 12 Jan 2026 10:31:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Fix reset names with binding
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <e1082054610fe73d4487d12f4274315030592c77.1765813212.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e1082054610fe73d4487d12f4274315030592c77.1765813212.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: cae20e79-ecb0-482e-1ccc-08de51bd5cd7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlI4TUtFQytKQzcwc0VqOUZRdjFFamZLYUNOaWowMndzWktFbXhJQWMxSTlO?=
 =?utf-8?B?NjF6QXN0RmNXZTB0TDE5Y3NzMDMxL1ZwNlEwSEoxMHhnVjl1cU5lTStiVGxM?=
 =?utf-8?B?TEhPU0c2dFZkZDg2QXJHRmVCNzhxajlOUzcvSFJwMzUwR3pERTNXOHpEK2ho?=
 =?utf-8?B?TFNuZEZTYTdvYzhRTXlCSTBiUDA3ODZEL3BORnIyK1BhQlFmamplVmcwR3hk?=
 =?utf-8?B?aG0yM3dwNVpqb0FQTFVJWXh5U3h6QmRUampEaUVTamducGZldTIrNWZCMnRa?=
 =?utf-8?B?N2JFYWVMRWNTV0Q0dTBIeTM4SEdPMld2MHloeElieEM1bEptS1NhRzlqbmM0?=
 =?utf-8?B?UzhHS2lySDNld2J5eU44Sk9lSW5lSVpwaVZjeXJhejRZV2VRMzIrRkdKVEtj?=
 =?utf-8?B?VlJOcnJNaTJjNzhKOVl4bGFITXhBckZMZ1lJdU56c1VCOWZBSWIyNEdPb25n?=
 =?utf-8?B?K0hEczFCWjdUalAyRHc4Um9xYmdOWW5ZWXJHOEY5cXVzdmM2NTVSUTNXZVJ2?=
 =?utf-8?B?bGZGcjYvc2JhM09zMHVYTFpQT242d3ZiSDRZR0dMOHJsM2NFNURvMFBoRW0v?=
 =?utf-8?B?ck5qVlZJdjR6MHV1NmdZbUg0TytmWmVUVnpON0tXb2Z4cnhVdjNDV1hTWmtL?=
 =?utf-8?B?amordk9lQWF5S0ppTGM2VFFYSDBkSXd4M2FRZTloZTRIYmgreTVqWVNHL1Fp?=
 =?utf-8?B?a2xpMnh2WForQVhrK0xieWhIRkVIQXNvTGZ3cXNvSGw1TEJncFdpNExNQ0o5?=
 =?utf-8?B?R2luTjljeFFGa1l3TitTTkZDTHZhZU9WeDZZUS9VQTZZTzA0VkR4NkhnRFI5?=
 =?utf-8?B?T3gvQTNkR1IzYTNJTENZN3hLV2tIRGJGOWVuUkFzcHJqWFFvNk1zd3hodElH?=
 =?utf-8?B?QnpsUVFWMnJ3bThWWEs5Y3JCZFlEZXZvWjJ0OXFUc0hxNk5VVFhSWUJrUlRX?=
 =?utf-8?B?Rk01dXRqT0l1WTdKZ1dsNjZVcGc3R0t5bk1zVUNydmhnOWFZcWx0TktGQklE?=
 =?utf-8?B?UEZ1TGw3TGZaTzRka0xnL2swdkw3emNYNE52WjBIZ3ExQjBzZXNCQXR5L3lE?=
 =?utf-8?B?MkVhOTNLRXQ3bkpJOUtDZFNHN05uV3dTaE5OSGpTVS9xbDJucE1LSTFKQUFX?=
 =?utf-8?B?U3o0ekh1eWE0Ny9YenBSQU1rWkF2WGpTcERDYi83bmo3Q2JUakt0cEYrRmVH?=
 =?utf-8?B?cUlDU1Y2UGRLOHAzenQ4Qi90TVczVW4rM2ZGR0hFSiszQVhwWTNqb1BuZ2Zs?=
 =?utf-8?B?eUMrQlVXL2N5RVJBUGJTNlVpU1I2RndRYnRwM1MwS3RQQmFnK3lHRWQrbkYx?=
 =?utf-8?B?OUxhSFJ1VVJoVzR1ejZZczFlc0VIWkNUKzFGZnhobk93WDR0VnYwYUUxNHJh?=
 =?utf-8?B?WSt0RGNkd293VEd5Y1AzUjJxdXo3bU9QOXMzRzFONzZ4K2ZZOGJzaFlBYjhJ?=
 =?utf-8?B?U1pqYmR5WjhnNTRCSUN1NjYxYVlyYzVTZ1VxamFuZUlVa3dlemZhOERHc0Fj?=
 =?utf-8?B?ZjFKTy9pV0xhSXZjMW82TC9IS0tBYTRzM01jL0M4OFg2NzIrc2VDTkRZSjhW?=
 =?utf-8?B?WiszUE91RzlGVFBEN1hDV0h1VDI2Yit5S09mTURwcW9yUEVPcUd2QVNxMU1I?=
 =?utf-8?B?bklqYUxldDBIbWtWMkZYcnpBeUZqQVFiRU9XUllCWFE3anVUS1R6akxrZ1hB?=
 =?utf-8?B?NUdqOENXSm9ZZzlua1dRdUh6eXVvMFU3aEFQekpJc09RQ2hIbDlPN29QczE0?=
 =?utf-8?B?RDN3VmlYMjZCZG9MMnZvMHYvTytJRVhlT1BlWk9kc2c5WFE4WURPYkxVdUhm?=
 =?utf-8?B?UHZLbzFtY2oyNXJKTVJ1c2ZzNnBiaEI5TlVMdWN1dUM1NTFnSGJQNnFqVXh3?=
 =?utf-8?B?Z09OYWh1OGZhTVBoTU5rTVVFYUFSU1A4QmJVYTJLTGI5TVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFJaDZNaktSeXUyL3Y2aE1yN1Mvd3lPVVkySWd0NnRLeWlNaU9XbXFxdlpH?=
 =?utf-8?B?ckxMMnpWN2kzU21ocDhzcDBoMWl6d2hiQnBGSGxlUVVhaEJ4clk5YWNFOWFJ?=
 =?utf-8?B?QmxneUJDZGU2VzViWVVNWHdiY0hjN0ZTTmhndHZxU1Y0T25YVmRTTHl3Q1pS?=
 =?utf-8?B?K3hoRXpOT1BCdk1nK1l1TjNHNzBFWVFHNUhtam9EY2VHTSs3WWpscG9HbGIz?=
 =?utf-8?B?bEUycFBRcjRieU5mVWxOQTFFQzhVeHVmQTgwbWFTei9GK0lHSGxaTkRUaVY4?=
 =?utf-8?B?TEhuQ1dHMVJlZmNSNWVWWjlWazFwL3BmaVEzM1pmckZSTkc4eUxBYnpmZTB0?=
 =?utf-8?B?QzlKZnJyM1EvRDcrYUNJdWsyRm9qUzBkK3MzMC9PamFwcEtNK0V3cyt2eng5?=
 =?utf-8?B?Zk1peDBZbER0QzdDYmg4QkF1TWtBNFRibmhXSjBYbGRSSGpYTFB6SHRUZmxL?=
 =?utf-8?B?WXRrSEdJZWxySzZkeGpHamFzZjdpQ0FiUGZEUlFYQ2Z5aG9NSHdWaFFpMEhh?=
 =?utf-8?B?ZFhhYWxtSzBaUnplZzZ0MFlPRk9yVi9WQkxlcEhiZE50MGMxMnFxc1ZNL2FR?=
 =?utf-8?B?U0tpUGpoajJSZ2FTM3NGaTFWaWpjYTZ1NllqU2FXdHVyVGNtTy9VWE9tMjRK?=
 =?utf-8?B?cWhuNFlJVTQwOGZYUDVKbVg2aHBDLytWY0lVaWk3dFhQeVRpNEtDS3pZZTdX?=
 =?utf-8?B?QkRibkRFZWNaUGFJSS80SE4zajFTUjJVMFlXY1dmYW9XeHJMWkVGUUVONUF2?=
 =?utf-8?B?MTA0aVo5RnB0bENPcGdDVkI4aGd5OW50NUEzME1Fd0FwcGVoS1hzTEZEd3k4?=
 =?utf-8?B?Ui9ZU2xvQ3hvTko1V1lvYmdEMThpb2hiNGplMjJkR1dyaWZGWG5OajJoTERo?=
 =?utf-8?B?ck9rdVhUdHV1cHlwbyt3YXVwLzdTQTE2T1hDR0lmTjFzL1RSQUdSM2JLbzFn?=
 =?utf-8?B?K053ZFhRblNVTEdReFpWdFJySlVIV1YvclIwNU1PcXd4OWRHL3pNbEI5UmF6?=
 =?utf-8?B?V3J5UlhuTWEwR1d1S1lZWnR3eSt3bXVsNGVFdjNxdGFZTm0zU3JVOU9WajM0?=
 =?utf-8?B?b1M4U1ZWNDNRVm1HUitmN21ZRXFHazc3eFIzTFFLVXdML0xpUEJoWkxFZzhJ?=
 =?utf-8?B?VFNpZXA1VjZUZjhjM3VXaE5mRUhBTGpnQ3ROK0FjMnpjbTd2VXVSSFRua21k?=
 =?utf-8?B?V3pESHJHTStOUGxEUWdraUhocHV4L2V6SEhnQStaMlRMR0lXUFlUMEppTVVi?=
 =?utf-8?B?R0laSVdqeFdKSmhpSytqUzRJWlZJZ25aZU5lSk84a1VlbW9NM1F5ZEloc3Ex?=
 =?utf-8?B?Z2ZQSFlSSXROMU85MjliUzFwTnpIc2FEdlJ3dWJkYzRybGRQdmZBSHlVa21D?=
 =?utf-8?B?aXZpVVZGZXFNK2xGWGFKUU44eUhrSFJ3dlJ6dFFHS1Q2OGJWd09ubk80Unpw?=
 =?utf-8?B?YUZMdHhVdVYzdWY2d1pLUDRrdHhSNEJGQVQ0MEN4eXc3YjNETzhnWFBJR1VM?=
 =?utf-8?B?eUlFQWpJRExSTWJmN010T3pZN2QyZkVuNDBVemozOUpsd3hhbTlWMCtxTm9y?=
 =?utf-8?B?bTFlRVNBQVlNUjJOVzk3NGoyRzJxMytibnhsQVRyL3YzdWR1aVY5TU5XWThE?=
 =?utf-8?B?cnhPazhvdG00cjEvSExud2lZMkprcCs0RzFZRCs1M3h5ZDlVcXo3bmJ5TlFM?=
 =?utf-8?B?VEN2Z1BjTFVubXJJNVloY1VJMnp1eldTRnJtczlRQUUzVkxNYUxjempPc0Rz?=
 =?utf-8?B?K09zaFFOcjB5YjJHTTZvRGJKS1lQZ1p0ZzJlZW9IZUNGNlJDU0R4MlVBZUlB?=
 =?utf-8?B?MUJOcENXZzZqR2NZczBsbUJrNXlqbTlUL2J4bnQweWxxakpqWU45OXp0UlJ4?=
 =?utf-8?B?T0tiek9PQjBXY244cG9KS0poYWVpYloxSU9CczhPZjF1eWtLakVkQkc1T0Ju?=
 =?utf-8?B?QldEYW43OGJCVi9wYmV5UjY4VlFXNTJtdFBOQ3VvRS9mVnJuMCtRNkxiN2wy?=
 =?utf-8?B?SG1qbHJKQ1N2S3VrOHptL2orUEZPcFJ6a0pCa3NzZ1h5SC9ZU1pLVEk5Wlds?=
 =?utf-8?B?Qm1DeERPek1mcjBmN0UyMFhkR1FQb05EYkhOVXd0SXZJbVVQaDdBb002RUdD?=
 =?utf-8?B?RmZFazd5SUdkT1ZZSlB6QlJoU2M3Y1Y1NVJIN2wyN0RyWHJRMXUydHErYlNv?=
 =?utf-8?B?dzNubjdROFBRZkx6aEdPUm5xZ2h6c0ZpT3MySkF6V3ordmZXNm1hMUtOUFFx?=
 =?utf-8?B?MUtVMnlJcUZzVUthS2o0RHg3MzdOSkhnZnhuaDVkM01laHBVQnVIY09CTmU5?=
 =?utf-8?B?LzQxcFJnRitzYUFzYlczaG0wczB4RkZQMm8vMWdIM1ZrUzNWTWVpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae20e79-ecb0-482e-1ccc-08de51bd5cd7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:31:28.2879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82Ex/wiNjiAwoqLRxHRtPa4NcNQ2d7IFTQUnrmjr00oSJbA1ZLe3Z/pBqYPMJ929
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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



On 12/15/25 16:40, Michal Simek wrote:
> Align reset names with DT binding.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Binding is available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
> ---
>   drivers/ufs/ufs-amd-versal2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index bf23439e59d7..97de0756f70a 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + * Copyright (C) 2024-2025 Advanced Micro Devices, Inc.
>    */
>   
>   #include <clk.h>
> @@ -319,12 +319,12 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   	}
>   	priv->host_clk = core_clk_rate;
>   
> -	priv->rstc = devm_reset_control_get(hba->dev, "ufshc-rst");
> +	priv->rstc = devm_reset_control_get(hba->dev, "host");
>   	if (IS_ERR(priv->rstc)) {
>   		dev_err(hba->dev, "failed to get reset ctl: ufshc-rst\n");
>   		return PTR_ERR(priv->rstc);
>   	}
> -	priv->rstphy = devm_reset_control_get(hba->dev, "ufsphy-rst");
> +	priv->rstphy = devm_reset_control_get(hba->dev, "phy");
>   	if (IS_ERR(priv->rstphy)) {
>   		dev_err(hba->dev, "failed to get reset ctl: ufsphy-rst\n");
>   		return PTR_ERR(priv->rstphy);

I can't see it applied that's why I will take it via my tree.

Applied.
M
