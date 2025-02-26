Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A2FC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71291801DE;
	Wed, 26 Feb 2025 10:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIQhxs+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C648081A; Wed, 26 Feb 2025 10:04:49 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9BC80077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CflCEvCaZVKasw2Q0ENF8vfrLj3W+vkxEEYWqCurdn139r25Yfe3fPA6BhZGCvRMvuAXobcF62mXUCd64gwMeORe4WaUM0ECbIuP1RD6HWNG7nWRodRtADDCZ9ZLnBhnR/ilzjjUyg1+m5Ibo0cNCMOhdm0DwljpQWLJ+sbovI5/yfzu4WAumGZAa+84p4fIZuqAYBMi+arsPCxbQiy5/zZB0Yod9Yfce9J0KKb+x1ABTpQ9XJ56ws5wn47QMckRYqj364Xmaz+7n0zdxVE44hWd782M018Ezu6ZgRWwmUlqOWsv7ZjZ3hxTMtI8av5UZwqfnjyNC/Bja3fPg7zfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmW6+NzPk/D2921upqPjx1wizKrcUO+1LKx/CjG4AW0=;
 b=ctjlxB8k4e6I5OCWWxYUxU3hyrHF93Lrpl+yaw7nWi0wlXuo/KGRwJ3WWf1/ztZiqaHrreM1KCWOUb6y4VVT/+TBfOrXZD6cz63wiKgTZ0JxqiLv6bhPQ4h4tEYG38gUo1s+w+b9H7qpex6X5NPzMTQFSEeUkAzBqIkuXw+sUsQDH19qF3YyD8zrirtPc1X0o4hbCFWJGV3aCXcD7SCqEtT3BrPc/Zz77sTQCaf6A2svY2X584CnexbU8tTGbraqBQ7aIqde4Z7ZnUqOsPejTYooUcM/xAHOAnC5GLliKqQs5U5OHQi7LaSkLOtsNwLqHgRnEHbLmebSZ20beCBhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmW6+NzPk/D2921upqPjx1wizKrcUO+1LKx/CjG4AW0=;
 b=SIQhxs+GX+gmdOmt8lm1AJQF4ypvMSNoTATggLq1tpNOYE0D+xcZKz+lebfXSruTDnNqgDs5pXq+ZEb5i7yRBs/HPkDmbAtDTmV4ZLBNSYAar+iSpbPMz+iN0Pilk0Hr1Ew93zbHw4Zk4eH/Qcb8TxNhpgZpmumka7UWpgRd2p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:04:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:04:42 +0000
Message-ID: <56ed3099-ac7d-4224-a2e6-a38d31f0b29f@amd.com>
Date: Wed, 26 Feb 2025 10:04:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "Kummari, Prasad" <Prasad.Kummari@amd.com>
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
 <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
 <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: e1128a5f-1a23-4151-bc78-08dd56449b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|220923002; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0s5cUxOd0x4cUUrYTRiN2o1MnB2cmNnTW82WmVXWjJTTUxUcWVsSHhZZjlE?=
 =?utf-8?B?dEw5VnBZaE9TZnc5UE4yc0pqbnJGV0ZVeU5iZUFqYnZVWm9KYnFuSEkzYklU?=
 =?utf-8?B?N3NSVG8xdGhUN1A3d3gxRVh2b2FSNmQvakw4NG9kRW5EWVVyWGNRVm5hOXN5?=
 =?utf-8?B?dE5WK3ZuY2VrVXR3K29mNkt6b3docXVocVQ5SHp0SUpFdWlYNE5QZFE5K1Rs?=
 =?utf-8?B?RktxR3pXcGxlV09IZlhqMm44MnYvYWNQNForTjJvTDJoYlU4TDFzWVBCWUNz?=
 =?utf-8?B?VEdDMzFZUlNWT2NHZGk5U1QvaVdWZWh1Y1RJbzFoN1lOZjBSNktyUi9vRTJJ?=
 =?utf-8?B?WituNE0zeTlyNFYvemxNVU1DbXFReUlYRXh0OFl3Sy9BUEZza3pNOFhyTS9r?=
 =?utf-8?B?dW8yZjVEZW51a0t2bU5FME1ya3NUODFnMFZjV005TFFJaWoxTW1vWWtFSjgw?=
 =?utf-8?B?UWd3ZlprRXZVZjdCZTF2ZVgxU2U2U3hiR1dqL1hsYjdidWVRd1I3eFI0QU1O?=
 =?utf-8?B?dmdxWnNaY3F2T0FYamVIZjFPSDg0WXVaYzVyMmZNVHY5UGNTemt2aldPVDUz?=
 =?utf-8?B?U2tWN2d3Zk1DN2kxK0UrMEdMNUZWN1ZqVU1nSE54YTdMbnMyKzhPL3hTVk5o?=
 =?utf-8?B?T0dpSGVWMkVzU1l1eWVkTlB4Z0ozMk9ZTjNkTEpOdkRFenBFYWJlRzZ6VE8y?=
 =?utf-8?B?YmFqck13SCtlTFFjM1A4THRrcFJIdThhcWwxQlhEM0VCYW15OUR4Q2ZrNXFn?=
 =?utf-8?B?U0t3WWZONWlCS2pWbWhRenlOKzg5SWREUmpuSm1hbWVtNHU2WnRTTjNvWGYr?=
 =?utf-8?B?QnZVWTloSlVqaTRkZFJsWEZoTEVnMTNRZnlQT0VaR3lSeHFtVDJXVjl0emhY?=
 =?utf-8?B?TCtIS0NtUkRiTElQL0ZtbWlibk51UXlGVXVNcEEwdVVQVm5sMFpKeFZZOGpp?=
 =?utf-8?B?ZEx3VkJ3TE1YNUo4ZElCbjJTSktrNXQ5MnNkK0V3dGpWdStxS2hUL0xKN0F0?=
 =?utf-8?B?UEV1bHRBM09ac0NOWncvNHdyMFVJN1JudFNiUTQyRmJJN1BKMTlqdGttdnN5?=
 =?utf-8?B?T2FzaU5qbUVqQWo5SnR5Y3d0cDJBQ2JDaUNSVmw1dEM1MFRmQmxMR3d5RWgw?=
 =?utf-8?B?MWoxSDVxRXhXTldTY3huYUYycjh2QnF0QmdRSXQzdTd5UTNPdUlUTUdXOFkx?=
 =?utf-8?B?Z1V1YW9ZZVhaN0p5SHp0RnY2V1MrektNVXF1OHY5SSsyVjZCVXFwa3YxVEpY?=
 =?utf-8?B?Z043WkN0eUlHaHJyaEdYRlplQnU3U21QcWgveG11UU1XdTJkYkVoRjBSNXMx?=
 =?utf-8?B?QmdXcVRQME9CbnFJRSsyOUlQaFgyMzU0NGRUbk1GYlNVbmtZSmN5VVgzUHJk?=
 =?utf-8?B?bUJ1T3VNU29VdHIreUYwYnAyVENGVkVhczM5dXM0bXM5a1ZQSEV3Mm52Z01C?=
 =?utf-8?B?ajZ2ekdGRmxWeVJ1RWVYakRDVEthVjRWSzB3ZUpNNndsVm1HNFpmRmQ4bStj?=
 =?utf-8?B?MTVldURvdHJ2bGIrb1ZNZE9SVklMSjJDTEphSVRUNC9uS0tMWXlIYnpiVFhF?=
 =?utf-8?B?eUVEODZ5dk1NN01xbmZPZ2RLTitPV1BlNmZXMEVkWXNOcmpTUnFiTE4xZzFT?=
 =?utf-8?B?QlJyd21pT05ialczS044TmdlOGJaZEd3SjdkWlh1MjZJNUhOaGdDZHRia0kw?=
 =?utf-8?B?K3NhQmRxVE5hREUyNmVHTlh1eUlUZE9YT0tDLzhubmVlWWsvT3ZMelFNKzJI?=
 =?utf-8?B?SExma2I5RE4rNjZiNGdNTHdaTFBicks3cUJROU1GNU5mMUgvMDlwYnd4ZTh6?=
 =?utf-8?B?TkUzZ1A4SzJ3ZjU1UlV5Y1ZLRkh4alNPeWZza0VHNFpqbVlTeklJcGs3aU80?=
 =?utf-8?B?WmpQWTk5b2F5SHZidDdkbWlUWHZka2drL2cwMlIzOEN5L0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(220923002); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHg3aURTMEtLcFBhbjVZVGV6Z2FUQVpHRFg5b296RldCWFNaeDdpaUFOK3hP?=
 =?utf-8?B?MThYRW5zRXRmRi9QQzF3MnZiYmtXdzJqK1BVajBHRXJycWc4T1RxNzBhOElp?=
 =?utf-8?B?YkRXNzk5SG9reXZwQnlhcHptYUt1aENaSkhBM3g5WlE3aHZUNGRkUXB0eVpT?=
 =?utf-8?B?dU40enhCclplU1VuRzN3S3cyQTQrRWRwRFN5WldjS2hzUjZwc2NXdTl5K2w3?=
 =?utf-8?B?eVJLUDg1QjF5dzlMakJESXIrZWtlbG02M1JETC9nekcxaTZiV2N0THNTWk1E?=
 =?utf-8?B?NzM4TU1lZklYUXZBNDNXQTFJWStTczVseG5HMXU0RGdGSHE4aDhtVW02S3JJ?=
 =?utf-8?B?Mm85bEtZQVg2OVNzMEtzc3hucmdxSDJiQm5xZ2VVYzNteWNGQWtQN2VlYVNR?=
 =?utf-8?B?c0lCUUhNaEYyRlBrRUNseGtwNTZCb1dkZkI3OHlmS3NUbzV4a3l0eGlzdGNy?=
 =?utf-8?B?NTJjNkt5KytqOFg4T25RZjE1UldtTy9EVzd6T3BiOGZ6WHRnVm9oK1hUVzBu?=
 =?utf-8?B?Kzc5ek5INXpNWURxWGhLRDBEKzV1a0VEMmJ1ZFpubG5FSDhvd2xUakx6RlpB?=
 =?utf-8?B?amNLWlZ1TGhVRmNzYXpmSUwxQk1hbnVHTVhidCtOR1F4c2t4Um5TQjM4bzhh?=
 =?utf-8?B?T3ZON1BaU1lCalFYVUJPejIzSEdIUE5KVkRBc2NCZEJseWRFSmpTdWRnLzlK?=
 =?utf-8?B?dTdBYm8yZnVXZGVNTXFwcWxqYi92ZjY5WlNVZms1SytUUmEzZGJtZ3hxdUN5?=
 =?utf-8?B?aWxiMHh0eFJuS1JHaEdVYU9hR3NDNksvaHJEcFZObk9kTUxLNU1MK01EZkpm?=
 =?utf-8?B?aEd5RFFhK25LWmI1a1RWYk4xa09oTWJoeWQvV1FucUU3QUJzUzJQS2JOYnpK?=
 =?utf-8?B?VXI3aCtTU0RtOTRldHhuSjVKZEw4L0hETlhvZE5CNFFTZlQ2Z1FRTEs0SnE3?=
 =?utf-8?B?VmZVOXpySG1TYkVoSGMzVldhZjAyRnJZZHpHNE0vMlI4Rmtvd3RJbG9pNUk5?=
 =?utf-8?B?WkY0bEU3RmJzVnVRQkR3bDJacEt5K3E5bjBXVTJvamVvZEZYRkJINTRpUnJG?=
 =?utf-8?B?T2hCY0d1YWRIM3U5STRWYStYa3F5dEZvQ0tDZXVTSWpCN1F1bnprWnVDRnRK?=
 =?utf-8?B?eFRRSkw1amVHUUU3VHhSOWNGbnZoNEVneTdOZTlnRVBRcWdVNVU0R0VaaTFI?=
 =?utf-8?B?bjVaSE9KZ0lVYlhsVEozL1d5VWFSNWdpTzFzWk1qZ3RYZzNtYW1EbTNlWG50?=
 =?utf-8?B?dmUrVW9Zbm5TUkFPRXJiZEV3ZFNEdGZ5TDFmOE1jdnI2cGxQVi9ZQVZrNklt?=
 =?utf-8?B?OUxScUFSbzBoUkhzdHk0VGdlZUhFaGF5TzNkbVNHaHJ3bFV0bjBOQTNYWG5O?=
 =?utf-8?B?N3BualRZME03UUxKN1RsUzc0Uzg3dlhZNDd4dXpIVjZ5dVZZbkU0Vjdpa2Y0?=
 =?utf-8?B?U0lrYTFoNnVUSXBwTDZiWTh2R1hXQVNzYVBiQjlnUzVsSWZaSjVQTUVWdEZI?=
 =?utf-8?B?eUdmbG9NU3EwNTA0bnJFQ0NuS3BRcWNsYjdzQ1AyZ3pWYnVzODUzRzRVQkVE?=
 =?utf-8?B?TTRDTWdIcm5VVjI0V3Bxd24zQnpVNm9GUllDZXZIdFRLdlYyVmVaSmhPeFRC?=
 =?utf-8?B?MWxhN1F4aTQ4TFpQU0haTUl2WXE0YUR1cXZZWEV0THFpdjU2aFVna05ZaEFD?=
 =?utf-8?B?WkJ2NzgyODdQZTd5Tm1ZOWxnQUtiREo5eXVOdEg5TllyTHNmV3pTSUVod1px?=
 =?utf-8?B?YWJXQTBXVTFXVUdyWm1GTmdUNThzOW1CSTduYXFxYkdMMUFTZTN4SS8vTVkx?=
 =?utf-8?B?djN6cmVSeHZkY0pPMGNSWVYxWlFFRGdrbzgrRGZ3eUw3Wi95aFRYYkFnV1lk?=
 =?utf-8?B?YjVJQ3MxYjNXaWUvWUZxcEE0LzlNc2pZV0ZHSTUzMDVXYjVhRzlGZFNsbGN6?=
 =?utf-8?B?ZFkwRVJqblZXdVNmQlZIUjY3bTUwVG9meGZoSWV0RENyNU5wT3VkdEtyV21S?=
 =?utf-8?B?eGNzdjQwMWtiL1d3dDhHQklSWUFpekc3VG1IT2pleHBoeVF2SSt4MnNieVFV?=
 =?utf-8?B?RkovNHZrSGVkMlF3RVFwTWdZRXRrOUxyYVdGMGlRRVVCNUNEcTRMTHdsRkd5?=
 =?utf-8?Q?Oa4vZv9M8HpX97TTZ0Sw0DdIp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1128a5f-1a23-4151-bc78-08dd56449b8f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:04:42.5051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPrjjjKzXHttFicoQdpZ5bsxi8MeORyjv6723VB6oF4QVARqDd5jFb2s9JVcgai8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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



On 2/26/25 09:59, Heinrich Schuchardt wrote:
> On 2/26/25 09:28, Michal Simek wrote:
>>
>>
>> On 2/26/25 09:23, Heinrich Schuchardt wrote:
>>> On 2/26/25 07:48, Kummari, Prasad wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>>
>>>> Hi Heinrich,
>>>>
>>>> Regarding below commit.
>>>>
>>>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
>>>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
>>>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
>>>>
>>>>      efi_loader: initialize console size late
>>>>
>>>>      If CONFIG_VIDEO_DM=n we query the display size from the serial console.
>>>>      Especially when using a remote console the response can be so late that
>>>>      it interferes with autoboot.
>>>>
>>>> *    Only query the console size when running an EFI binary.*
>>>>
>>>> https://lore.kernel.org/u-boot/20220614060203.33600-1- 
>>>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u- 
>>>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
>>>>
>>>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to query 
>>>> the console size only when running an EFI binary. However, when 
>>>> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being invoked, 
>>>> which shouldn't happen. This results in issues on our terminal, which cannot 
>>>> handle the resulting characters, leading to incorrect display and halting 
>>>> the auto-boot process in the U-Boot shell.
>>>>
>>>> *Log Output:*
>>>>
>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8:c4
>>>>
>>>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3: 
>>>> mrmac@a40f2000, eth4: mrmac@a40f3000
>>>>
>>>> Cannot persist EFI variables without system partition
>>>>
>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>>
>>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>>
>>>> Hit any key to stop autoboot:  0
>>>>
>>>> *Versal> [42;173R*
>>>>
>>>> *Unknown command '[42' - try 'help'*
>>>
>>> Hello Prasad,
>>>
>>> The terminal emulation seems to be sending a valid reply indicating 42 rows 
>>> and 173 columns.
>>>
>>> It could be that in your setup you are hitting the time out in term_get_char().
>>>
>>> Could you, please, check what happens if you apply
>>>
>>> --- a/lib/efi_loader/efi_console.c
>>> +++ b/lib/efi_loader/efi_console.c
>>> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
>>>          timeout = timer_get_us() + 100000;
>>>
>>>          while (!tstc())
>>> -               if (timer_get_us() > timeout)
>>> -                       return 1;
>>> +               ;
>>>
>>>          *c = getchar();
>>>          return 0;
>>>
>>> If the failure disappears, next you would have to analyze why the timeout is 
>>> occurring (e.g. timer_get_us() running too fast).
>>>
>>> If you still get failures, please, add debug output term_read_reply() to 
>>> understand what is happening.
>>
>> But why is this send at this stage? Why capsule update needs to be aware about 
>> size of terminal? I understand that you need to know it for efi application 
>> but what's the reason to know it capsule update?
>>
>> Thanks,
>> Michal
>>
>>
> 
> Hello Michal,
> 
> There are two separate questions to answer:
> 
> * Why does determining the console not work?
> 
> The problem can only occur EFI enabled systems. If determining the console size 
> fails here, we can expect it to fail when running EFI applications, too.

yes but you don't know if users are going to boot over EFI or via legacy way.
You can still use capsule update part only and using bootm/booti for booting.

> 
> * Why is the EFI console initialized here?
> 
> We have currently only one entry-point for initializing the whole of the EFI 
> sub-system. We are using the console before running any EFI application, e.g. in 
> the eficonfig command.
> 
> This could be redesigned with some effort.

And I think it should. Because there is no reason to do initialization of 
anything what it is not going to be used. At the end of day it is just delaying 
boot.

Thanks,
Michal

