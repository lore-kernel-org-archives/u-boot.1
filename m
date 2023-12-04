Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198CDC10DC1
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A0A876E0;
	Mon,  4 Dec 2023 08:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnmyV+kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33718759E; Mon,  4 Dec 2023 08:35:25 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5977876E0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgiKm17wtz4A1LDpFvHFjoW28835fkokcr1u1+JwW0F8tyM4H4QpIxwkI/sZFF0IwE+cA7HI/47pYxG7liHNDOQA6IrL16PK62nbjqjwxIg1aGIaW6dfCZ8gTHqKCYR7utaZEObbR5HpGk1s22OHPaVHW4HrwlKNECO7EosPpTHcfCidniiu+jdF69sHTyar/YwT/SIqVfalRCoMtU+8apsd9hGqQpyQNgdHilnzVRcRyrXpOKMpflNQtYbm59/fQD2N+yy9Uy4kfv4NIIevBfsbd6VwtL6EotTRV4FTMu3JtRGkSORSkLNB35GhBssGVKavfkQozN0zWdkk293/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb8BOL+vvfSENho5G5mUXJ7lPpGp/OyyukfM5Pu1mEQ=;
 b=V4j4RzqgO1Yq453JktJoTaibzoo0l27izOOIb3aF8ak2rOWl9crlZ2H4SppCuuUyuGJj0Tbix3/ueLPnkGe4rndG7gTuNQAK/Buf52BsBH4EMuWqF7UPR9ztn7LQl3NpEaQAfVAXxorZ2YvAeGu5AzH5rsMTR8DIf4NQ/nXiMt16+Cj4baSk3Qsem+Nv9xiNCguCJOmVfUmFVI9e0ADaa+bPBFP8fY5msw0avuYyotYj4xN95rwCj1afO5T2rBlT6vXODm5AlyP0R+EeTHvmsBONy1dRUQ9hKU+MFuEZvWsWEfjlGIdLwS58Tmjuku3lJoo/p+xBpQdBLtYEeFa0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb8BOL+vvfSENho5G5mUXJ7lPpGp/OyyukfM5Pu1mEQ=;
 b=PnmyV+kjjU5i+WJ97YsOjyLW7t56mm00mpC5JUlhKpodvowX47YANXuStrQsiyTpWNWwBMF1mjKhZ2par2LZ9m1tA6WOGSp7vI02iHw/eCfaKbI5o6VSbPQoGrct5deT7Kadq31ytbn3fSbfAq1AYXyuLlKtxu79UhZ6e7zRXqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 07:35:20 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 07:35:20 +0000
Message-ID: <6455a85e-9434-43bf-a668-0c8c7dc57459@amd.com>
Date: Mon, 4 Dec 2023 08:35:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynqmp: enable topsw_lsbus clock
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, git@xilinx.com,
 sreekanth sunnam <sreekanth.sunnam@amd.com>
References: <20231204031248.6938-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231204031248.6938-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: d1615d12-17ce-4f91-b055-08dbf49b9131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk1IwL61WU6D8syGoTLnGt2mfTyjQhCF8HQrdAZE+6kjpcPOlNp+2tzaCSWq6aN1nNIFrTe4GW2yMV/yQzQedVHFaXcNfhKhwNNzP6Ur7N+QioqUKlhvZwyiHqEKh+ayivo4jIRF8nruigQhO2ZI3MopqAyXln33B63KkZii8PXmbwS/iayJlQDW4PlP/uJ+8VBthrNfOXOHn1iNqHyfFE+5/IeLNOEuwt/UpJ9RmNpDNeqbI4p7HmyUwvuCcIlBFv1Wu1fXc8HQSVBWYh4p7XYnDl4DWas7g/TOlAF/lgegbuN4/4hdyzRn1JvEg8dM9JmpRcI32WgEM5vz1t4QQ4Hwcxnfk7m/dNcSctQGwzRuwY/Gu2y75YdnAYc+86uSXZZc6OsQ0N5SLSkVcE7i/G2dy5AY3v65HmB0Kbv4Czs+ff9KZ55pzerQtxTwfLQ9hA4VEXVkodV8m/IP5xfmAYA92+KPJ+64ZPRi0cH6oBmrTISGvHwJo+ZYgLtMSHzNqXzdG0Ye/IVcFTF6wC4pJFN36FYUTB6CV7ZJArsvuXwjAKFY+8V7BOuqRCov19W0M78plmQc6D1GmdmnIe3aguDycFAOJ32mUY6PrqWdNxYitFENUybRN13Plc1lSg8NDAV3JaUhizrxQ4DkcCEa5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31696002)(558084003)(5660300002)(44832011)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(6512007)(6506007)(53546011)(83380400001)(6486002)(478600001)(26005)(6666004)(38100700002)(31686004)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHMyNjJNMTFqYk9FWVZ4N2Z1bjFEZGlhekgvMERYS3NpRllBdVNaekR5clhx?=
 =?utf-8?B?RlpreUd1SlNib3NaUUZOS3FpeW1heG5zTDMybHRTWDFHQXViZ0c0NE9iSlJx?=
 =?utf-8?B?Zmo0ZXh2cStmU1VqcS9XRG1NWlZJQW1oSVYyaWlGdGVsMWtIQ1lpTUdkUVBr?=
 =?utf-8?B?NEV2akhVUmZIb2JhR2FhRERjd3ZYVy8wMVJXeXVzMERScXh6NGExVzRBemdF?=
 =?utf-8?B?VW4xSlRCQ1JOUnV3dTRQVTFTcFV4VkRhWUVnbTRkemJidFZDcXptYVhtaE5j?=
 =?utf-8?B?R3NVMmFjV29HblV6Z3dodFN6RVpZYlFQc0NKYmtaQnlsQzl4UUtpSDVOSG8x?=
 =?utf-8?B?YTE0QTVKcVl0NDVydXVpTzhRMEd0MUtuMmNYajdSOVNTUFZCQlNTa1hMWUZx?=
 =?utf-8?B?RzJZbkg3c2NoZjd1bDhvalAwbE9PTHExeVJwNnhMSWt1bDV6bGxYRHF0S2tj?=
 =?utf-8?B?cXRtMDFLd1RZSXdZTFZrZWFCakxCbmFld0dIeUxBb3hKVXhvbEFrRXhiQm9n?=
 =?utf-8?B?cVYzYmpBem5sNExGYzI4RTUzM291WDBZRzBCVHZUeXd2SFlJcGJvUG1TS0NY?=
 =?utf-8?B?UDM4MEZkaW5LMDNnSDRHeW1MWkZBaHE0UE52MkRTeTBtdmVMUjNEcFNZckdF?=
 =?utf-8?B?cHNoVjlwSkk0WTFReWRxYUx5QnVxQzJFVTE1Z3B2Z3hmZk90aTQ2M0drUG5q?=
 =?utf-8?B?WDN5RExQZDhEZkErRTFiS2l5Ti9tRlZaSG91SDBsT0V6VTBaN1FMWFhhcWFK?=
 =?utf-8?B?MGx2OFBtQnd3L0lsTkx4ckJVUDZ1YUMxNTlWNXJHWEdNNWZyaDh5QzV2a3pp?=
 =?utf-8?B?WjRrUDlFVlJ1NnlERFgyekh0aWh6S3lwNS94RHFZQ3NCbHd0MFA0TGZPS2hH?=
 =?utf-8?B?elg3WG5aYXNnVld0dnRtNVV5Z3owczJ1VG1aTkJPVDV0UlFwU3FId1VWTmE2?=
 =?utf-8?B?TkNQMnZFMllPbENteDUvTWVuYmlaYjFSa08raXduYkcxeUxZTWZ3S1BRWlVn?=
 =?utf-8?B?ZWJpZE02bnBtc2RDeHpmcW8rdU16MUJ4cmtsd1cvcnMrYm1ZNjFpb3dwNE9p?=
 =?utf-8?B?N3dIY3hTNU0rWUtubWxKYk0wdUo5a3EvenJGZUFzTGJyNVErN3BHeGJaS200?=
 =?utf-8?B?UTg5Y1NXVkNmTWwwOVBzQzBTdlVWdmF5Mk90S0dBbE9WTWYwME85SFJ0bjEz?=
 =?utf-8?B?ZG9CM0Z2K1FUaE9hUTIzSVlGNW1IamxKdHkrTG5HUnNrNDF0VnNIN0pWZGZQ?=
 =?utf-8?B?c1JiSkZGb3RnTzFkN3MrY3pmbDFaUzM1ZXN4bERNbU81QTBhRmhDcFRDcGRm?=
 =?utf-8?B?RUkraHFFM3ZTVjd5K1VaR29MUVpVK1FzaGhVeEx4MlNMVnVoeURYbDhzLzdm?=
 =?utf-8?B?ZTFJTE01SmFwdmZqOXRMYnhXT054OWF3dzk1RFpDdC9vbHZreFp3bStiMndZ?=
 =?utf-8?B?Zk01THdXNTdmT2FWSmNRRzZiTVMrTm4yUkhCYm5CWVBibkNHdTNBUUtyYTBL?=
 =?utf-8?B?MzVwVWoxVEo2dzF0NFdQSzk3WEUxeHNSWXA3VEY3V0JiaWRZbjlZZzl2Vk9T?=
 =?utf-8?B?U25STExIVUdySThjYW1KdjNTazlsMGJNeWhyZUpJdng4MGJmTVlOQlcxcncv?=
 =?utf-8?B?RzIwN1lEK3lEalJGL2hPRkhDcERDandQcUtFcXFyZ0NxNWZsMmxRY3RQbFZ5?=
 =?utf-8?B?RGcwOWRVVmNoRi9TSmlnM1M5RFpGMWszNFg5MDZZYWtKZU5lVnZ4N3FxaWNQ?=
 =?utf-8?B?b0RpWkZ6NVpLbi85YVRBejdhbDN5VDdFbWsxNXc5anZUbFhRM1pDVEQ4b1lq?=
 =?utf-8?B?MGVRTFJ0azRlYmxvVnUxNUpjM05Qay9ONFhQQmowc1NzVUNEcXE4Si9ZczFN?=
 =?utf-8?B?Y2xlUXJaYnF5VU5iajVZelZKL0gzaUJmWlJ2NCt5L1hRdEQ0ZzRob0VZOHBh?=
 =?utf-8?B?SlhHT2xhRVhCS3lVd0YyVEJka1J5Nzl6aWNwVE5aY3pWTU5JeEZDd2ozSzll?=
 =?utf-8?B?SkN3VlFZK294M0lqdVpGYlhTZldZb1FTMStLSWhKRXJ4a1MvQWZvUmNFUUNw?=
 =?utf-8?B?R3IzaG5tUysxaEg4T0x3ekZMQ1IwdW9wUE5mSGdDMmJwR1JoZjNqSVRQK2tm?=
 =?utf-8?Q?nK1RiOYnzMwmSSaA/q6gsbOKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1615d12-17ce-4f91-b055-08dbf49b9131
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 07:35:19.9927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PGVGltrp8hWXS0fAJmXAaNeg5fLqzz8OKLVC+K9NMNvzk6fwSPmGsCOBBU1aUw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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



On 12/4/23 04:12, Venkatesh Yadav Abbarapu wrote:
> Display port is using topsw_lsbus clock, it is failing
> while enabling the clock, so enable the topsw_lsbus clock.
> 
> Signed-off-by: sreekanth sunnam <sreekanth.sunnam@amd.com>

Likely Sreekanth Sunnam

M
