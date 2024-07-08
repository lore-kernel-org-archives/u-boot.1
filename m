Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF242C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF15C88783;
	Mon,  8 Jul 2024 17:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHTfRR07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F31887C0; Mon,  8 Jul 2024 17:24:51 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F178873C
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO9xA6YvcJIHOnCcQu7AavmxeT0V81Lad2o45xh6BudngjVeTy6ez7mskS++xQYfhZ/BnnD7hShITsAsazT8AhCmI3s+rZBgggS+ING8WfODKbKDl7WVcCr8g1rX4/Lvi6K+jXyoKO46PEvlg3uxbWhzyZP2UPZ6goKIHztwoshJAtd5hCgYp5Yv5cKePt+txyICsOq6bP157J3MObtnPezmfFWjaxWRhe42vAIVavCdztCbtgevi+uMBDhzO9NNuhpjTMJBwD7IfECidF+zvPtDcC0yofvjbX0E7y0FKSaRdtqTQRD1q+I9FMX2FU6hZg6OhXuZC9qgYlwHFI6cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQqtROeHqY8TWuf0CK2jwgWyP0XLUmXhGCTZ2nWmsf8=;
 b=Tr1qDHxw8d/DreVuCZBf/7Mq9XC3/zU7m6A2j9Y5cgWAOV+8YahrS9eF60xErW5bLUdW6pmed839rLtGsXD6DG5y3osBDtULuxU3lRY/da+RCetmFgneLMN6qWDDhSSjVe0Qfow8J2NqQnU6oPkiWRGykgJlZvJuEFPgmpx9hxGTLEd7lE1twWT5qQmjQe2Oa3cPAHkoHV9kjmvRkkGQkSipwvrWqAueBdzLpoefVBafLl/wEBeeLyLzWxRZnU86Xv5q8mOxJZV1CtJaPSrwLFPfmbNtkBWe1VDUlphhGOhBoiiNwkMaG4mBdXMvWdCeaBezFz9W6qOndsSGd2o2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQqtROeHqY8TWuf0CK2jwgWyP0XLUmXhGCTZ2nWmsf8=;
 b=jHTfRR07QG2bU1fK1AI1ir0J2h0XjAEoPL7sw1na8yvc/QOMhrVKhx4p1a1idmi5WPjs/VNq/KDPErctOMbSiDusQo+Zqh9CHTZBTuReIaKshveWUGOK1tVp9dOn++Rc0+z0qsPFWOwMLrPH3gZackLQeWzOlDWGEz3G4vymt74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 15:24:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 15:24:44 +0000
Message-ID: <19e041b8-be1c-4e34-a296-b0acfcfcb6e0@amd.com>
Date: Mon, 8 Jul 2024 17:24:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings with xilinx_zynqmp_virt
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <CAFLszTghO10vjaofEVwqPKinG1gvRf8Jy1--77kx3SgkHLrFxA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTghO10vjaofEVwqPKinG1gvRf8Jy1--77kx3SgkHLrFxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0159.eurprd07.prod.outlook.com
 (2603:10a6:802:16::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 35938122-8f10-4ec5-e235-08dc9f62180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUxpMnFCRS9OekFDUEQva09OT0tYKzV5Zmh5ZTRyN2tGbDNvSnpqdEs5cm1U?=
 =?utf-8?B?dGEyUGd3b3JjWGkzQjh0MHdjYnRPT3dTanRENTFVdGpsS1dLS3hpMFN6NzdH?=
 =?utf-8?B?cVVjc2syTnIza1UrOENCdWtXTmN5NjlDWnBDRmVPaDBBQ05XTk1jYWswTnc0?=
 =?utf-8?B?K0M1UC92bzBoOTUya2hSTzZnM1Uzd0ExUmNPS1hCTCtnRUlaSWdlajNRRnMz?=
 =?utf-8?B?MU52Qk1KZ3g1blJvWExtbXloejdGOWJVTlFPS1FtRlpCckMxZjkyV01STkdt?=
 =?utf-8?B?NVA1eEF6RU5DL0hmRnc0RVhLOXhiK2JkRWxYcEN3ajNjTXpaVnZFRk1EamRY?=
 =?utf-8?B?WUJCRlhLS0tObmtHWlhiaGJOaGxLb04vYURXd0pvS28zSFU5RTJ5TUFuZjU2?=
 =?utf-8?B?Ym01YzRmQ0Y4WEpWT1pjQUkycENLTnJOQmhmZU5MTGR6aEZjcThuMlNod1kw?=
 =?utf-8?B?TFViSGl1eE94RkZFSkczeFVCNnd6cjNpTklXYWpuc2plQ1V4ampjQUFnZTlY?=
 =?utf-8?B?MDdpSjhjT21nVEhSS2JNcGxjbmpGWC9MdjJNb2xRQUx4L0N1bENLVkJybkpv?=
 =?utf-8?B?SVhUemhmUzh1a2FsWkYxcEVvRVJxY21iSzAwQkJpWmw1MlZ6M1ZCL2ZJUWp2?=
 =?utf-8?B?YUZBWTVQS01SRnI2ZU4zcW5ySndhRW42UkFaRkV2YUNOSTVBUHJUZGIyc2dy?=
 =?utf-8?B?ZThtYTlmRWZscC9HQlZGUjlIdXNyL3ViekdRZFp1c3V3MDNoazZ1eTQ5K1Ny?=
 =?utf-8?B?eCtXT2RBQUY4NEo4a2Jkek5oKzZ3MThTY0FqR05BOFdZY25MVXQyeHBjblJO?=
 =?utf-8?B?WXBwd0hacHhPK3ZGeEJ1dTRsZHQzRWRxODJoZGxKUEV2OXpmRVlNb205T3FB?=
 =?utf-8?B?QkhpcGNxdXBQQ3pvQkN2NjVXS2FQaXc4VzJ1T2szbVlzNm1vd0liY0pzQUU3?=
 =?utf-8?B?SWs4Q3p3VjBoTS9GZkJSd205VVlBUUFqcDEyWTlMNC80TnA4NkRvSkxRSVdM?=
 =?utf-8?B?ZUpHTmEyS01heTY1ZzdnWm5CZmRFZnA3WlY5d0dhcUIxOWZGRjJZN3NPYmQw?=
 =?utf-8?B?MmZSd25WdHVXT2VqanpFcU56UGg5ZGJaQitubzBORGJQYlk0SHBpK21HcFRl?=
 =?utf-8?B?cDRGdzMwZTR0NjVIQXZKb3M1azlha3Fnb0N1bDRBOXQyL0NaN3JQQm9SNm53?=
 =?utf-8?B?NHpOK0VGK1hUcjV1RE91cUsvSUlLSGVTdVVFcE5ReFFndml4R2ZWUWxOQko3?=
 =?utf-8?B?dmEraGI0Vkg1Z0dzc3VHRldQZlhXejVHTWJhUUlkVEFmendwUjczVVBzVlQy?=
 =?utf-8?B?VmJxWTlTV2V5L0o2d2tmdmRrK2VERDhHNnJhWFpFeTB6Nmh6K0gzOWhqVG5T?=
 =?utf-8?B?QjNJMXJRMVR3aDNsNjA1a2lybEFoMU5rV2lpTkozeENOMXg0S0dvQm52NEFR?=
 =?utf-8?B?RDErSjBLeEo1Q01vRlBSTURreUZvTFBNMzRaSVBZTVNPUVEwL09MUHNQbWg1?=
 =?utf-8?B?YkFWYlpJSXJVVFFldXQ1alBRVXRJTHZmc2xMM1d5REZJTjhIZmJMWU10enlr?=
 =?utf-8?B?SmxkWE1sRGk5SlBselErTnRPYkJ6MDVQVmd1NnZwcWJ6T3BySlowRDByOXFw?=
 =?utf-8?B?UG54TW5KL0tqMGloOHY1WlVORlQ5a3JZcHpCMWJIaUZhVFZ4ZDdQbnQrblR3?=
 =?utf-8?B?Wi9sUy9wcnJlUlJWMVdFblU4bTB6Q2d3U0wzbEU3UW5ZSUJJTVJhb3dCTDVV?=
 =?utf-8?B?T0UwZXQyTUNHNWFZMkZaRkVnZG1VcjJvdWN6blJZaWdqOCtwRC90aWlhMWNC?=
 =?utf-8?B?akQ1SFV1N0tkV0UreTNiZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHYzbXRMVEhVRXZienN4RDhoaGp6WVcyUjBqRDNPeGJScGMzTDRNcUdkK1Mr?=
 =?utf-8?B?NDhyMi8veXBFamRSVUFONUlVRU1MWmhjU1FpU09mN1VaSjNVRFI5QTdjWEs3?=
 =?utf-8?B?VXdZaXBycjdmSS94ZS9hclRJbXJhazZzS0w0VHl0VVZDV3hySFNvWnFTRjI5?=
 =?utf-8?B?S0FPbWxvNk5rUTN2cndRenFLcldra3ZTeHpWTkNMOFRubHgwalRzZUdITWNk?=
 =?utf-8?B?TkNPZEtraG5JMHMybHZRZVNlK3BZTkZ4eUl0dGN4L1o5WnZZSnFuaFc4dzda?=
 =?utf-8?B?RkFwYW1QNCtVR1M2c3Bad2JhMWdEZjNBRzA3VWQrUm1PNy80R01kU2Jsb2h6?=
 =?utf-8?B?YTRBK3R2bS8yWkRNekpxYUVIbm16WUlXcVlNYzF6NzBBeFJDVXU0My9GRVBO?=
 =?utf-8?B?R2xyaGd5QWVnSGt3Q2pVcy9tNWY1V1VWbmJ2TjhIZ3hCbUFXcmFBMmplWEY3?=
 =?utf-8?B?WnZ3TU5qMVVRT0FwKzBDMDNnTkJSbzNrK2NlcW96V3I3TEdiMFhNNFRQamN0?=
 =?utf-8?B?K0dOUzI4V1Z2dUlhRXhxZU1GWnQ1SFhwYzN2RFBVeUFBa2pmem9CWENVQXlZ?=
 =?utf-8?B?TDk4eVpWeDM3d1gwUDZRR21NYzBQeE5GQkxhVlJkMFc5UUkxKzFranc5dnhx?=
 =?utf-8?B?Nkk2UlNWekVoWnR3R3RsVDhqS3RTN0t0WWJVYkpiY08rN3B2allDRWVHT0pW?=
 =?utf-8?B?dWduaW5rZkNZYVBUVUZrZHJ6RXVrTE93L3lnRDlDWUpOZExEWWtFV1Fkai8x?=
 =?utf-8?B?MTVENlozbG0yM0VMenhrSXZQRUJFT09BaXlNUXAwb1k5T2YwU2RwOUp5TVRN?=
 =?utf-8?B?ZXJYb0F0TGRydEF0alNUODZ1Wkcwa3JCd0JuVXlpZys0QWZvNTdFM3JUUlVL?=
 =?utf-8?B?VWl6UTZFaUU3TlhhNFNmOGtpZjlnRVM5Sm9Fd0U0aUhVMUU2eVNoUGZRN1I2?=
 =?utf-8?B?VXlqTTFQS2hFcmpHaFNFYkNpRWNINk51Sy9YRDVWWkhqUklFL3R2WkpiOERq?=
 =?utf-8?B?RnVMNmdIVjJ1U3FSbzUxT21jSEdPOGM1eVpmaU5pRlBkd2RkUVB3aTZFTjAz?=
 =?utf-8?B?c092eHF3RDVZTUxmKzg5WjVzN0R0QXhQc2hyV0lzWnJQQ1ZJbkJ0Uis3Szls?=
 =?utf-8?B?WE0rZCtmNEtES2hNRms5OU8zTGxVcitpZVpiL1VsK3V0b3pWR3YvcjdQQTJ6?=
 =?utf-8?B?WDBKcm5XSkRDT3ZjVDZDY2NXV2ZEYk5lSnM5ZjZsdE0xNENFL1QvV1YxMlV0?=
 =?utf-8?B?aU03TXdZaU9BQ05lYVhOb2grUXRJcU1xakI2U2FYOE1zT1RXeWJlQ3R0UDJT?=
 =?utf-8?B?UHFvcldUVFZPZnVKNnhDUm1Xb0xGbmpMRlF1MVpsSVNHc0RzTGJXbkhRSG9l?=
 =?utf-8?B?N2JNMnBKUVNSU08xUGs0VERTWi9kcXVZUTNadWkxelhjR0JhYWlSeHdxZ2dO?=
 =?utf-8?B?YU9pWUJYYlo5dWFPd2RtNi9wd0FlL3MxZGZzazJEc01mVUV1d2Y3a3FVc21M?=
 =?utf-8?B?Rzk1WHNNWFJmeG9EMGdBeXFqZmVzRURVQjJIOUROU2tiNjRWTk5icTZkRG5m?=
 =?utf-8?B?OTZHM2VLUTlQQ1VwUncrTk9CcWkrcElDYnFUWTRMNFcrWXhqOFA1WlF2NlFB?=
 =?utf-8?B?WmpuNFBhOExaL3VkYkVRT1FPN0Jnck4yZjk1NU9lYUsrL2ludUVSdmo5YmtL?=
 =?utf-8?B?ZW9yemxMZ00vNUcwSklHUmoyVEFBRkZGbXM3MGVHS2pVWEw4aVZUTDA4QnVa?=
 =?utf-8?B?RGlLZGFadHZhMmZuRDhNWkhsdUdTVWdER3BEbHEzSlpKbTAwSmJ5UlEyYTkx?=
 =?utf-8?B?UDdDcFJwSys0S2d4ZEE4R0VRWTVHZGtobGFLeUNiSFNDZUllRFFybWdoRXlU?=
 =?utf-8?B?WU1hZ0hTM3cwTHZsekFGNXdISUsyajdoeS8xUUNQYVJxaTA5cklTNTdreEJG?=
 =?utf-8?B?U1NuNkEzT2pmb3dVMU1MMHpnRGQ3ZWswcUlxK0lOa2N0Rm1GSzExMFIwWGk0?=
 =?utf-8?B?SWlQakJjRWYzRktROHQ3ZUo3NnJNQlEyMDJPc3hDQ3d4cEIzTWVxaHFVR01P?=
 =?utf-8?B?YTBneWVybDNjeGxFR2E4d004OThGOFFOV0JLOVczV1kxNzliZEcvV0VlcjhM?=
 =?utf-8?Q?9vkF42RxW134/p5xhzdpt0Pqq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35938122-8f10-4ec5-e235-08dc9f62180c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:24:44.1326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6EukF5nmEsm3NusqmE69GIxNCfBV4FNCl7oNt1dJgfbNYYqF2DYYOKgBIwHLq8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

Hi Simon,

On 7/2/24 17:51, Simon Glass wrote:
> Hi Michal,
> 
> I am seeing errors when building xilinx_zynqmp_virt:
> 
> Can't set hash 'value' property for 'hash' node(FDT_ERR_NOSPACE)
> Can't set hash value for 'hash' hash node in 'fdt_35' image node
> Can't add verification data for node 'fdt_35' (<unknown error>)
> 
> The problem is visible in CI, e.g. [1]
> 
> A bisect points to this, but it might not be helpful:
> 
> 46f04087712 (refs/bisect/bad) arm64: zynqmp: Add support for vck190
> revB system controller


I am aware about this issue.  I didn't have time to dig into it but actually 
that error should be suppress.

It is based on your commit
commit a9468115699de562f08796bf2eabd832435bedec
Author:     Simon Glass <sjg@chromium.org>
AuthorDate: Mon Jun 2 22:04:53 2014 -0600
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Wed Jun 11 16:25:46 2014 -0400

     mkimage: Automatically make space in FDT when full

     When adding hashes or signatures, the target FDT may be full. Detect this
     and automatically try again after making 1KB of space.

     Signed-off-by: Simon Glass <sjg@chromium.org>


that there is missing space in FDT. The first error should be reported from this 
function

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9253f81fff54..3509ed3bd168 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1218,7 +1218,7 @@ int fit_set_timestamp(void *fit, int noffset, time_t 
timestamp)
         ret = fdt_setprop(fit, noffset, FIT_TIMESTAMP_PROP, &t,
                                 sizeof(uint32_t));
         if (ret) {
-               debug("Can't set '%s' property for '%s' node (%s)\n",
+               fprintf(stderr, "Can't set '%s' property for '%s' node (%s)\n",
                       FIT_TIMESTAMP_PROP, fit_get_name(fit, noffset, NULL),
                       fdt_strerror(ret));
                 return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -1;


but
commit 8df81e17f81ba0542f6dbb7636db64fa56c12d8a
Author:     Simon Glass <sjg@chromium.org>
AuthorDate: Sun May 1 13:55:37 2016 -0600
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Mon May 23 11:50:18 2016 -0400

     image-fit: Don't display an error in fit_set_timestamp()

     This function returns an error code and its caller may be able to fix the
     error. For example fit_handle_file() expands the device tree to fit if there
     is a lack of space.

     In this case the caller does not want an error displayed. It is confusing,
     since it suggests that something is wrong, when it fact everything is fine.
     Drop the error.

     Signed-off-by: Simon Glass <sjg@chromium.org>

change it from printf to debug
I think the same chagne should be done for my error messages. Something like this.

diff --git a/tools/image-host.c b/tools/image-host.c
index 49ce7436bb97..e9e5eebe8dc3 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -40,7 +40,7 @@ static int fit_set_hash_value(void *fit, int noffset, uint8_t 
*value,

         ret = fdt_setprop(fit, noffset, FIT_VALUE_PROP, value, value_len);
         if (ret) {
-               fprintf(stderr, "Can't set hash '%s' property for '%s' node(%s)\n",
+               debug("Can't set hash '%s' property for '%s' node(%s)\n",
                         FIT_VALUE_PROP, fit_get_name(fit, noffset, NULL),
                         fdt_strerror(ret));
                 return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;


> Also the board seems to be the only one still using SPL_FIT_GENERATOR.
> The migration message was added almost 3 years ago. Would it be
> possible to move it to use Binman?

we have it on our todo list but Venkatesh didn't get to that yet.

Thanks,
Michal

