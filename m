Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2B9D6ACC4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35427897B1;
	Wed, 27 Nov 2024 13:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="g4ZKkncK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F1AB897BF; Wed, 27 Nov 2024 13:42:56 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9C8897B1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVpSBNdgFhZjybW4FJnWZioxudtImHM6xsk/iwXVqi3vYyl0vEtKfIsTetQv5hH8TbIJ1oeYbx1wixN7gdqiKQ8dqsvrGdu3bsxBvfwCd5J/JWbRiHYpInZsTubwixV16/N68cuvCdrmvZUSqr5+oFX7d8rKGL9Queqxnuuz9QqSitIgRUGGY5oAjDOmJ2rROuyqA+rSAv5glK/jc+UNHqSTtjzGS4DCWkV0zd09Crzv2dnBz6v2aH1/ABg7npl+dTNpxUN2OWieIgrGljCc9Agw/nvtx3pCWMiY38AgjKLrFSNXZmOrIijIZi6ZLWC8CvPfwhMiqeNEAajqwOl/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3/QFgNlMq4fL22iFMWNewzqaVjAEulfWfw/hfwFn2E=;
 b=jT4RenySz/guQnDFw1MAi6YhaSdXlwberXygFS9OP5D0/MRrlX9fGf3EYadJ6O1TXTcC8TMcjlIaMttxi+/wBT7vGhr/t9gP1BFXc5OfFT1xOMR98/vIBEGm0i4QlDxJePnuGnGPDOBIWjVpe9YVrQyLwOK7Xco9rwF25gbe/yR5etiYHR9tJX3OYqTJzww5mAEnFH+xbe5zbWGHAfhXyR9az0zMzZugUsep3hlCJaIWqAGPef05uv1xD9xZL/Dc/+cW+AgKYNGWUX+yUSo1jJ5jxdxOUENLUoclGJKntxg6XMBYVhBGUH+xz2lpeBYdbiK6dc3s24LFC0nA/Lhudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3/QFgNlMq4fL22iFMWNewzqaVjAEulfWfw/hfwFn2E=;
 b=g4ZKkncK8T0gA1FNi4Dg2bt5y54TpoHGMiQXm9gwyNkEQ6PTW4CC4cGZLvsexG7Y4TTi2pQ8p5/4e3u0hJvxeXAdOrW8+dhDQFxSF427WnELwaDGWBHfkEutozZlfMP2D9FYGRMQgqc340G3zcYQD/vCbzyKW8aeo4EDhN5TCt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:42:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 12:42:51 +0000
Message-ID: <7a713b05-030c-48ae-af3d-e7fb02b2f7c5@cherry.de>
Date: Wed, 27 Nov 2024 13:42:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: avoid non-standard sed expressions
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, marex@denx.de
References: <20241126191214.21709-1-kettenis@openbsd.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241126191214.21709-1-kettenis@openbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 68886c12-5ce2-44a8-04bc-08dd0ee10185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnNTQXY2UUh2OURLU1dsOVd0RWNWY29BcVhxMzZkcHkyZUgydGo5VGxBaisv?=
 =?utf-8?B?WUVNR2dQdE9LOURzeUJRM3VlMmQwZFdYLzlGWjhWNDNxcUNQbGI5Q2hrKy9s?=
 =?utf-8?B?Nkl4NW1kOHhyYjNBMUtmVWtFakRBWXJUWk9OSkw5ZE9VWUU4NG5KRW94bzlW?=
 =?utf-8?B?Ynh5dzdoam1tZkdsL25hby81WGtBdFM3T1p4dkdBQWtMRFdwVm9zTDUvWVBN?=
 =?utf-8?B?cjdvc0s5UFNBazNtaEVFanEvRGJuakZJbFArNGZPYTV2N0dXMkJRdTc3d3BU?=
 =?utf-8?B?UGVFMysxTHY2VTNuakliM0pGUnFJLzYzQVkxVlp3dFhncnk5YXFibmxqYUow?=
 =?utf-8?B?SEhIdVg0OXZWWmE1SnNYb1lxRkVubnJnLzlJVVFEajZXVXpyZkRTU3UyOEtl?=
 =?utf-8?B?VjRNRlM1ZEtQUUJjaW9pYUVDTlk0aUpEV0JQVTE0MDhtNkVmeHRiK0puamQy?=
 =?utf-8?B?WW9LOGQ5UlNXRTB2d0hNN3hlVmx3c25vYWI0Z0ZtSU9aYjhvc3RiaEtHc1hD?=
 =?utf-8?B?dzJBWVc0elpVa1crZU9uUFJoTVNTQmFZN0E0eDl3ek9ubzZVcU51a2s0U29y?=
 =?utf-8?B?Vzh5bEhIM3VPSWlCNFVCYnkybXlhNFhSaFlRZCtGRGs4ZlN5UkNZVlpmM3oz?=
 =?utf-8?B?NFFkQXdKbXl1emRIa3QwQWc1T01qYzFmbkxUQjFvNVVqb2dDVDNyVUxHTkpt?=
 =?utf-8?B?bWRXK2Q5cjFhdGRmUXB5RCs2WllvUENpbTJ2MG9xSis3QjlQOS92WldLUWc2?=
 =?utf-8?B?SFpyNXN0akt4UGdoa2ZXNVJaT1p5NytRZTRDekRjZ2ZyajRNaHlhcTF0SUZ5?=
 =?utf-8?B?Z21pV3lJUS9FazI4c253TkxjWXY0K1JGWjJDTytKWjZMaXVoeGxkN0E5OFMy?=
 =?utf-8?B?dTRlSStjUCtqRGY5TS9iWDhHOWNoQW9hdjdzRDRHTSs3N0toWFZNbVJVS0hV?=
 =?utf-8?B?VDNIRGNNTXlsdGdTOEVmRGNQZitHOEU4UVVrSlBTa1VNWTZsVXZJcUFlK2Qr?=
 =?utf-8?B?dlpVdGp1SGdMdS94UFNDYmYvekNJcmxWMktpTEg5RFM5OFN1Z0t6UFd6QzlC?=
 =?utf-8?B?aHRvelpEQzBrUVRpWDdGWmdnUm9NM2VoRFczd0xQZk42OW1JZmt0L3hwTnEy?=
 =?utf-8?B?UHJKUUtsYjF4NXNuMGwyTlJDc1J1WEZZNkpKK0RYdFBDb3hmb2Y4eXpqa3F6?=
 =?utf-8?B?R1Q1Y2xTWlpTcTdFU291b3ltL3FYK0FRaGRQUERuRzRDTmVmVFNSRlJteEtw?=
 =?utf-8?B?Z1JDTzArYkFLV2E4ck9Bdko4UDJUVkRxZ1VYckJlRUJHR0pVWlNUb21RUjlM?=
 =?utf-8?B?Q2xHNnR6OEQxSlBxT0NhRHVuMldQcm1CSHM5NldMTXhpeTVzeENBcjBxZm5G?=
 =?utf-8?B?U2hKdzdUTHZteVg2REQ0a04vNDRObTM1NTJzcTlmd0xCanhmMkk0VXJYUDRr?=
 =?utf-8?B?Q2VsQjBqWGV3UDNDOTRqWUgwcW81ZExYa0xJdEdIOWRKMkpiVHB4bFViSm4x?=
 =?utf-8?B?cThaaE9CbnBKNnRtTi8xUzNvVjA3UXV1d0g3ZG1FOFZZTjdOVzhVRjFicnRo?=
 =?utf-8?B?cXZLQU1YUmxRNWZPOEJlR0RuUnJ4SGVqMDh0eng3SS9yaklQMWYvblpTUWVr?=
 =?utf-8?B?bkMwMktNaGREQ28zNUdsTm5RRmVyMXZOUnRwTEcvdDZHLzZsZXBlRkNBbFVq?=
 =?utf-8?B?WlE2VzZZZlNiRFVjTTBjWFJXL1lUVlpsUWNkTjQ4VHVFVGpST09pSHppYUJQ?=
 =?utf-8?B?cHhTK0pUR1ZvL3lOSWVCUVdHcWROMUo1SE9nd0hhK0dSTEJVMUVxc3AxaVpD?=
 =?utf-8?B?M2ZBK2lTd2tQTDJLaHpoUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNrRUZIY0dSVTBGSHNPQTZZb0Z5Y2JUZE04Ny9Nck1uakdhYjNydVBoSW1p?=
 =?utf-8?B?b0tIKzlzUHluRXBieGsybS9EVzhZcmUxV2o3M1ZiUmxzcUNqZ0NEdGNJSTdK?=
 =?utf-8?B?Mng3OWFCMlhoK0N0d1doeGtLa0xRb2Q2TXpzcXhiUjQxUlJKZ3FVT3FwNlcx?=
 =?utf-8?B?NTFLd1B4MDU5WkdGZkhpNGk3aXRkZTV4M3ZmU3Bvd2JlVzVlak9tZXlndHJs?=
 =?utf-8?B?c1IwdVFHV1gvTGVra1hGVWU4TFc5NnFvTHdZMkNFL2FFLzNFUUcxM3lVUlVF?=
 =?utf-8?B?Q0xPMjBXOVNXUjkxQ1lzekJBamNoVENpbzlsaklkT1pmTm1zK1VnSC9mNGVo?=
 =?utf-8?B?SGk4TW1LeGZ6RitEaERucW93cFcvUXJkd08xMWU4YzBYbjlpWTFwaDcvU2dn?=
 =?utf-8?B?VHcwSzlDbkJhUFJqcG1rNFo5azJEYnNtY0JGejdnRFl3Ujd6dHZlUU9oa1NO?=
 =?utf-8?B?QWtiaFBlZEM1QmxSN01sWnFVUFZYZWg0eXlOYUc2WkVtcG12dlRIV3dlbERx?=
 =?utf-8?B?NjFZQ3BtV0FKUUpUdG8vdVY0eGlsTnlxMVZXMjc5c2hsbWoxR2NJdG81VWZp?=
 =?utf-8?B?cDlDTWFzZkhxbWZ6bXhDU0Z2R3pLTGw4VFpYZUJQLzh1M0RQVHQ3RjNlQkRy?=
 =?utf-8?B?elBBUklOa29RZm9aT21rWlZWL282aDJRU1BRcGpEMXF0T2gwVFJUWVB1MHd5?=
 =?utf-8?B?L2pYZGg0Z25FeEs5UjZwbm9GZFE4U3RjU0o1ZjBxUVFMWmphWlJ5RHJWYUVi?=
 =?utf-8?B?TzVGcDd5T2pBTHl3cnJoMlZpNXNZN2FpaHJrV25vWklkRUVZWk5KVUtQZm1C?=
 =?utf-8?B?ck44MXFKeGNRbTc5TVFycDdDWXBvcGQzOExBMnFtZmV4RVAzL1RoRXVJWFoy?=
 =?utf-8?B?bG1jWU5ndVIvZHRwTFBCYWMrekxvYllwekE1RlZ5VHRvZTYwdzZheGlsbGlR?=
 =?utf-8?B?Yk10RmEwSEcxdVp4b0FsbTlqL3dPU2gyU1c3Nkp0eXJvNDQ5ZnZKY3NTQUdR?=
 =?utf-8?B?TnQzOGoraEcrVWVVVWkvTzBzQ3hEUi9JVFdZNHZwSEtWQlNWdStkZzhTd2x1?=
 =?utf-8?B?QWI5eHhrMkdaalZwQ2wxa1lxRVRIRUo5Q0cyTVI4cnp3RWxVOHBFSnkyZ2Y0?=
 =?utf-8?B?MHl3MzFWbjJUQWpQWWgrWUd0Vzk3MnNDajZzeldZMTNkRkcvanpNZkZWSnU0?=
 =?utf-8?B?SmU1YmNhRXorVXZXZDIyTXMySmhiNVczLzZJSEFTRHY1NUVvRnFKRnJiem1H?=
 =?utf-8?B?UlQzV1ByOUNCdjJqRUs5MVJiVDYzYVZ1NFB1R09heTlLVDROY0NRUlQvZHFX?=
 =?utf-8?B?NThINEVtZUwzVi95Qkl3TlRCZ0Rib1JxRVRtNGUrZXBoM2VteWptNm9IajZS?=
 =?utf-8?B?L2RPeWcxL1VYV2xlK3pybllyZTBnSTZaMFNnZDV0V3VxdG9QR3JJcEZvQUVj?=
 =?utf-8?B?ak04RGJnWFdUaEdLVFY2RFdYWXZ5U1U4WHV6aTU3eWtJK3RzclhYMjI2SXhs?=
 =?utf-8?B?QnBTMEx6S1RPTDRSREwvT0ZGSG9qbml2SXZpeDdYOEdBYlhsS3FaMW9jTGxk?=
 =?utf-8?B?c0U4NWxaZTRSTFhPdEtrYVFHczY2b3AzbXJraVgzYWZGVHJMMlRWdkJXL1RY?=
 =?utf-8?B?cEZMWnRCcTJyRHNpZFVIUHUveWYzMy92aG04OTVURGlGWFdxTzJEeENLRlhU?=
 =?utf-8?B?SHVOQ0JJWURrTkM1Q1kzT3VyVXRFUnpvdjFxT0VmTGpRWkQ1SjdvWlpYVHhv?=
 =?utf-8?B?bkNtek42dnhvUnhISXkrVEN5cmVOMnRqTDJWS21DY2pxWVJYc2R4SGdJRFk2?=
 =?utf-8?B?eEVWekhINXI0K3ZUWTU4WXZFdVluUjBZQzFTWURNUFlXanBpbXBFUk02NWRL?=
 =?utf-8?B?QVgvOS9aRldLZExLN3hqNTZydWU4UTZBNXJBY0J4a2Q4TDlwMU92VitYd1VI?=
 =?utf-8?B?MW91SWNQajVuR0RjTlNZRGZITlFtVHRIR3l4ZHhKdHZXbnNOWGM5dG5WdG1v?=
 =?utf-8?B?dE82S09OQ1N0S3hRT05tZFZUZ1Bsb1dBdVBKdUFuTllMT00yMWJvaGIxZFQ3?=
 =?utf-8?B?U292K0s5M3RBd0RYU2VXWVdmMWhlUFRTTkFvcWM1aEVUN3hFRFRCOWM3ZEow?=
 =?utf-8?B?TlcwanJFMlQ3Nnd2TVZ2VXowS210WE5KSFlkcFQwTDlubmFMMEIxSERIVzkv?=
 =?utf-8?Q?d/HGmlHwVGX92agihZaPMzw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 68886c12-5ce2-44a8-04bc-08dd0ee10185
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:42:51.4483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8dJSfIo1lTZXghCSfZIv3MnaJP9ImqwFlFg1Cda1OBsefi94HyAlLHjf1+v65AuvVNe5gHic/NNd3mNVGoTp+tfex0M2bHgeLTrBh5BVzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
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

Hi Mark,

On 11/26/24 8:12 PM, Mark Kettenis wrote:
> The '?' that is used in the sed expression that determines MK_ARCH
> is part of the extended regular expression syntax, but the default
> behaviour of sed as specified by POSIX is to use only basic regular
> expression syntax.  Use the equivalent '\{0,1\}' instead as
> suggested by the OpenBSD re_format(7) man page.
> 
> Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Considering that it's not the first time someone breaks this by making 
it non-POSIX, can you add a comment just above with a link to the 
re_format(7) man page so people are at least more aware than they are 
right now?

Thanks!
Quentin
