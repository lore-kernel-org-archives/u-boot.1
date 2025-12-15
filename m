Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9CFD5B17F
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 15:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A46780325;
	Mon, 15 Dec 2025 16:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXqlW50e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C7480433; Mon, 15 Dec 2025 16:12:51 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2119A80081
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLBjywlzhGy2hU9vkL/ciLIfsaBWaIA7rUpbtgaDB4Y+hmm825tWltgeMu5enXU1XOJW+PxV8i5tg9Gqyrd+8W5DqYOoadFOVUdOc6GcAko4S+4nrc/kSUz65F0CeV7DRrBFmftwb+Jb358aEKox2mPfu7iBFAfnwgaAa9wOMO6vCeGvt4QrupeeTbR1bCHjuPYmAjhyg35cOpTTUr7NzmSdtbGDeFOoVe1H7AhiMJxBihuH7csoLSHKbX8t4WmDgB6o2zbD03ts71rmgXeA1VyBnYv7SDB2Cp6nDWvDLwViEOl/PUhuNZyAS3Av3K71V+K4Oeu3POHzSn7UrkqzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LoWb2bYNLMPjQM39PDpN9fraLKKDbGkHJEQC9bp23w=;
 b=NcnDpNBjXlGOPKOIh2YuZV8oFo7SnKCJkCQNdJqQUSTWzAnhw4Kb5Qe8cTC9iVIxVQXXrvZ9YRMwrtTTeI5dgMHjB54xTr7BH20qJAIW1DB0gwgEMToFaFWwSDbeCvnsPQ2pVdhIf6kDISLdhDDkgzhAwXtufiKT6Oe56n4CcaH+XIcR4jG98J+4/8+j9C9j0RcxjZQ0hoxyLHKFy3tFfKLMJmRWyqhr8HOQ/ahOjW8xVRNmjZ8Fom/slmn+RvXHR5U5mNzSJAWNo+xbCzUIS0cnWUT7S8rAUso16qXOWq6+ZV4zT492msEtFyXXhjCm2ByjtAHvNQvQaq5KKaK6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LoWb2bYNLMPjQM39PDpN9fraLKKDbGkHJEQC9bp23w=;
 b=UXqlW50eFmBS1Owa4FxxJni33B8tSFydtVYA8xVwjxMNLg6k9vM4ubAHj7uqhgJVO2Fu1xvnN2HaLpmjaIIt42Nj5tCUqcVOReR/2v5VxE/ToBFvI22PNt2KpIuNNmuhxJFKJsqPsNjlLDHSMBEv+s98BUCIkom7WQzTWRGPclw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:12:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 15:12:41 +0000
Message-ID: <67617c43-741f-49be-af89-49af45531fd1@amd.com>
Date: Mon, 15 Dec 2025 16:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] net: Port NFS to lwIP
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0273.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 145c0190-1fd4-49e3-bb56-08de3bec63fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkdSS0dFODRUZHNNdWc5YXFPQm14V1JCenJFNjlSUVp4QXJLeEg3RDZaZTNL?=
 =?utf-8?B?Ui9Ec0xheHdrN0xsNU5SbGJpNGRjRDdncW9HQTNXZ2lQeFd2Q3JMQnJraHZa?=
 =?utf-8?B?MkZ6eVozMFRlVVljdGtvRmdWc2IrTDVQOTdZckwyQThsQlozTWtjUnNXeGlh?=
 =?utf-8?B?NVlUYkgzNlkyeHE5OHlsYzhWeEFMSnF3Z1RXK0VENERvelJtVjJ5dXFtNEdt?=
 =?utf-8?B?WVV4b3lVcUJQRmxoeFl5eDBpMWhGY0Znc2xBaGFkeFF2ckNXdHY5QVA2dDdU?=
 =?utf-8?B?Njlka2o0MzBldGtaZkFqQnV3UXJyY1ZUMXpqRjc3Zk1hVTZ0M2ZVcFh1cXJT?=
 =?utf-8?B?YjZIRTRYWEl0OUhTTkNVcXVZMVlkeGdKY2RlTjJyL1Y2aUFCdDY5NHg1bm4v?=
 =?utf-8?B?SlJHYkpCYnJjNjZUcVR5dzRnWUtRVElaS1ozWG9lcHdBV29DWGpZOUNXaTJa?=
 =?utf-8?B?Njc1Z2xmT0ZNbHpYa0JjN0FSWVN6WFEvWk5uNDVqYXMwYWVCK2taUHhHeFZi?=
 =?utf-8?B?ZFRDWUszNDRkVFJqaDdJUDE0NUJIOWw0NkMzaVhMQk9SdVdESFFXSmwxN05t?=
 =?utf-8?B?bVlrWnZTbytyZFZrL0xBN2FTUTc0Wm4zTkt5WU1HRXdyZ2owc005N29NQyt4?=
 =?utf-8?B?NzJidjNUMnBRL3d3RHF0SjNYQUhEbXF4dXlLUjFsU3JkdDAra0NyTEp5NktD?=
 =?utf-8?B?OEd4Z3VIajhjeTZId1BlNnBpNnFiV1lUa0dWTWJacktMY0FBTzh1TW54TmV3?=
 =?utf-8?B?TXYwQnJRM0s5RzQydWpRVVlpSkJIay80WUt3eVhvd3ZNQTF1ZHF6dVowVTVJ?=
 =?utf-8?B?ZUlkYlFRb005bDQwNUVzWTJEOU5mc0xKQllXMmduTHhvaUpLRlVGNmh0TEdN?=
 =?utf-8?B?cUlncHdJZldTK2Y4OGorcERCYTBFQkZ4Rk5WN1JWdXFoV2xHRWUycno2L3VE?=
 =?utf-8?B?Q0wySlFCaTNPVkp3L0U2Yy9kaDdxMkh5WENxWVViTHRBMjdiNXE4Z0ovUWNO?=
 =?utf-8?B?RE5IS0szbEUwbVdYRW9rbGticWVCekRjSzFCRzhLU2tNMnNnbXRNNk1DMTkr?=
 =?utf-8?B?bitGQUtFbHhqQUJDMHpDdlovSXpxWHVrOFRRWFBCN2V2K1FYQWhjSFNCcjdk?=
 =?utf-8?B?eWhGdWZNMGhIM1F2QnZncVRSdmVBZjBQam84OUQ2aC9mWWZSUWdJZkV0TmtY?=
 =?utf-8?B?Q0IxelBqYXduLzdueTZJUWlja0tnRkJxL0hDOFpEaUpLL1BITlhMbTdoQlhz?=
 =?utf-8?B?ZmpmWjFLOHlkUEZMVzBRMnArV0lrelhsVFFWeDZhYlhhTS9nQzVaZCtYTWNj?=
 =?utf-8?B?QXpQYlNyeW11enBEOEhtcFFrZDNBcU1QdlM3cW84T00rZTJ4VjB4dzhXVXZN?=
 =?utf-8?B?eERvdDRvb3J6QU9RNHF5UXVKQjNLM0RwK0pMZS9KY2twd3VtK0dXdEdMYlNG?=
 =?utf-8?B?NGpqN3pHSlpnQ2JvZXlJbllTOEcwWE9WSDlHd0V2Y1pyUGNJZmltakJ2cEZq?=
 =?utf-8?B?SzlMMTNoYzZZc1VvVjd1aDhVZnUrT09qS2U4NENrY3VOc1oyY2tLUXc5SVRX?=
 =?utf-8?B?aFlDSG5YWU16REg3N2lWdWtleVNJaE9NOXlnUld3R1RKNTBFZkh6cUN0eGdU?=
 =?utf-8?B?SnVBYllBZVJSZkhWZEs1eEhHVHhIZmFuNFE1S2R0RU9zS1VyZmhjcG5IR21w?=
 =?utf-8?B?SFArNW5RTDlzUVUzalh4K01KYytOVXYzaitJYit0bXVydFVTdmFqcFJTaWRM?=
 =?utf-8?B?UmFvU2FTRUFlR21oRDVjdk1RNjJFUERBYzVmbGIzYW43VFhEL2JGb2VaZjdn?=
 =?utf-8?B?dktLVkVzZWNqQ1l1TVZWSEpYdG50ZzNNL0k2U1FKdHBqV05iV01YeDNVRWlj?=
 =?utf-8?B?dnhWTi9DaTRQNEE5LzZ6aklKdEZtSkVURDNRM2xmZTdDZFNaN0MvbTRNNTdr?=
 =?utf-8?Q?fEFWr0hj6olnH8IhghcCV7BLfPX3u3S/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2d2V3NqQXhUMDI1Ny9tTkhzcmdmS2VyZ0x0ZlFPQzdaN01VYzI3ZGVQeUVq?=
 =?utf-8?B?d25tMXp0WCtzM0ExR1BWNkxyMkY2RDJ0QXo0K0t5WUxRalVVMjZycnRGdUxz?=
 =?utf-8?B?eDZSbGl0Zko1WUxMSDhTR3l0TC9GdVZwODd3MGQyeVhGMEZab015dkhFNHha?=
 =?utf-8?B?SFNQVDRpMWRyazlOMXhEN1NtMlNPdHk0NEFKOVZNUkFkMDJJT2luK2djQ0pU?=
 =?utf-8?B?M21DMnQwdGlYdzE2WFZZMzh3dUc1Vm0rSzkxa2VNem9yMTRyZS9aRXU2TUlK?=
 =?utf-8?B?b21oalNkdFFqZ3pLTHhMaURTaUtudnptTGZPWW94RkZUbVFGa1hmY0JuajJP?=
 =?utf-8?B?c3oxODJCMGlwL2VIZlZuakRORHpuRDlNRnAvQlV3MnN0eFFHNFEvMjg0dndF?=
 =?utf-8?B?ZG40ODNNZjg0ZytFazVlUmluYWN0T2h2b2VwNzRZdFhMQ1dRYmRURGZ2by9T?=
 =?utf-8?B?VFVITDBxcXJzOWFPQldlU290Qmo1SWkzRmdhSVljNG9yOGZPWk1kS05RNHJJ?=
 =?utf-8?B?ekpHamVUMkJCM3hOZk5TREhsSE0xYjY4Mm5uUG9KcjRRelFYRW9nUzErclJ3?=
 =?utf-8?B?czE3eU5EQjE0bE9KZGNpTmR2dUJZT2xOSGg4bEYyZktsendiSTdNZjB2MmNz?=
 =?utf-8?B?ZkdJaDIrc2tGU000SVo3V3VWc0l6RjhueWtqSWx4M05Db0JzTGp2WThTQmFW?=
 =?utf-8?B?dTgwMSttVy96SEJWZkI1SXVZUWlIOG4rQTdGdzgycDVJMGdvWG9qUTRLeG05?=
 =?utf-8?B?dGlkd0tSbEZPdXlyVU9OY0NtTXAzQ01ub1B1RlRnV1VkTDRDYWk5YUNDL251?=
 =?utf-8?B?d3loOUNnNy94Mk91WmFERGt0cEI2LzNSSmtubXVtRVE3amRJZmNLN2FjQ25J?=
 =?utf-8?B?N2tiOExTZFRzemx2N2RKUE5Ubm05Y2tPdVBsaDdnaDhrblljM1J4ci95c0Nz?=
 =?utf-8?B?SGpPcDltZkZjOTFhbjNubVZJak9LR1RXNXBmcWY4NzIxU3p6VVg0NTZ4ZVpO?=
 =?utf-8?B?SmlJbGlLeVg1WVlQNlNIb2doZGJENHZaUUtUaWMvSTY3bFhOb25KT25WSmpo?=
 =?utf-8?B?VkZXdlppMWRtUTFRbkFRUjZZanZreUJsditiRlg2TEJZQjJTa0FKc0RmRXU2?=
 =?utf-8?B?ZW1MeXo0QW1UMUt5UzhOSlFjZlhrNVdidTFJOTJvaUI4L1pVUHdGVjhSRWRF?=
 =?utf-8?B?WWFmUnE1NzVDcVhVN2huSFdiWW1rSk5lU2lZNkpIZHBtUExqOXQyZ2llSmJZ?=
 =?utf-8?B?L3RIcDFqU1NzMkhnUk1iaWYwcmx4ZUJHalNxSFI5VldPc1FxVmpJdzhsTzhm?=
 =?utf-8?B?MmhnSVg5QzBqOHFJQzd5czFnbXNtRmMzeG8xeUtESFVkREhhT3pYZ28xYXc3?=
 =?utf-8?B?bU5hRENackNnZWVmK1UxNktaMWUyOC9uUE9MeUJXQ3pmTGxLSDVIZkNzREZl?=
 =?utf-8?B?bkQyYUhvZEVSbHErRktQYlIvWTk3VEllRHE4UHNTNE5UTTZ5WWFQTWI3UXVE?=
 =?utf-8?B?TWVCMm8zVk9OcXlLa1ZUeEJYSExpSGFmZmdYUWpNRTUrTVNqbXdCajRkdEtn?=
 =?utf-8?B?VkUyNXFWOEZtWjgyYm1JTzhDYUYvVk1OWGNaamdGdkZzUVJscGp0cFRPVkho?=
 =?utf-8?B?Z0NJUFZHb1dRdzlsd3ZtQkVWRmtISmcweFVIaVpaaTdwZmZuNEJsdlhwVGo4?=
 =?utf-8?B?QkVRL3dzUWp2d1R4cjB6dWc0aWtmcXhGZW9GZ1g2cUYxRFJhYWtXZE5VRlc2?=
 =?utf-8?B?NHhSeFdINEJ0OWxZZEprYVZQdnpsQlFyN3JFQ2prRHZhUmovREtsUFdPL1gv?=
 =?utf-8?B?ZFNMalRZaXJaUmdCMTl3ajFPUTJQaEFkYklqYklDRHYwWXJxeUxjM0M2MW9E?=
 =?utf-8?B?UjZzTExCSXJ5VjkzQ1hrQ1RiNDE0c1F5SHFqZU1VTzVsZkRXb01UUWFjREJk?=
 =?utf-8?B?aTZpS1RIakk1akllVUlQRkdYdmc4MkZXYVRuQ0NtTWRxa010dUJLTkYwSDhG?=
 =?utf-8?B?TCt2Q1IyemMrMzQxOVFtM0FXbEdQY0lxYXdDQkhYQUkzRlNuVDFaTWkwZk9a?=
 =?utf-8?B?OXpiNzljMHB5MmY5YWhlTmhWOXYvVGpZaUVSajBCNDhpdzNsdkExcXU1UE5E?=
 =?utf-8?Q?Hz2znRyI/tmrUJ28ZwPiOeljy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145c0190-1fd4-49e3-bb56-08de3bec63fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:12:41.3222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx4iIvfczdlWgttgxCLm9CRVjMJPfbMKnX5kpp6LkymKDAdiDKvLKwW3tKP0WfGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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



On 12/12/25 12:32, Andrew Goodbody wrote:
> This series ports the existing NFS code so that it can be used with both
> the legacy network code and also with lwIP.
> Firstly some legacy network code, mostly variables, is moved into common
> files so that it is accessible to lwIP.
> Secondly the NFS code is refactored so that the parts that are not
> specific to the network code can be shared with both network
> implementations.
> Finally the lwIP specific parts needed to interface the NFS shared code
> to that network stack are added and enabled.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Corrected capitalisation of lwIP
> - Stopped moving some variables into common code that are not used by
>    lwIP
> - NULL check a pbuf after allocation and before use
> - Add patch to enable CMD_NFS on qemu_arm64_lwip_defconfig
> - Link to v1: https://lore.kernel.org/r/20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org
> 
> ---
> Andrew Goodbody (6):
>        net: move net_state to net-common
>        net: Move some variables to net-common files
>        net: nfs: Add licence header
>        net: nfs: Move most NFS code to common files
>        net: lwip: nfs: Port the NFS code to work with lwIP
>        configs: qemu_arm64_lwip_defconfig: enable CMD_NFS
> 
>   cmd/Kconfig                       |  28 +-
>   cmd/lwip/Makefile                 |   1 +
>   cmd/lwip/nfs.c                    |  11 +
>   configs/qemu_arm64_lwip_defconfig |   1 +
>   include/net-common.h              |  29 +-
>   include/net-legacy.h              |  22 -
>   include/net-lwip.h                |   1 +
>   net/Makefile                      |   1 +
>   net/lwip/Makefile                 |   1 +
>   net/lwip/net-lwip.c               |   5 -
>   net/lwip/nfs.c                    | 286 +++++++++++++
>   net/net-common.c                  |  12 +
>   net/net.c                         |  12 -
>   net/nfs-common.c                  | 863 ++++++++++++++++++++++++++++++++++++++
>   net/nfs-common.h                  | 123 ++++++
>   net/nfs.c                         | 849 +------------------------------------
>   net/nfs.h                         |  59 ---
>   17 files changed, 1355 insertions(+), 949 deletions(-)
> ---
> base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
> change-id: 20251029-lwip_nfs-5385efca71bc
> 
> Best regards,

Tested-by: Michal Simek <michal.simek@amd.com>

On vek385. I am missing some TODO to say that this is NFS v3 (or lower but I did 
test only v3) via UDP.
Not sure how much work is to enable TCP when we are in LWIP already
but some information about NFSv4 would be good too.

Thanks,
Michal
