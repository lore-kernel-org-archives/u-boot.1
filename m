Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA95CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F85848B4;
	Mon,  1 Jun 2026 15:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="bThqcxZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB02848CF; Mon,  1 Jun 2026 15:41:12 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84E8848A6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrUpyf4XlzB4009ogcqLAj0OPhzs97mMs4nHvEQt0CsqiAN6+9I99GwHArfF92WWfo0OWPV1G29+W5o2uUOI8G5EDE1eRZuJHjj9vZ/01pVwpW8kwPxmz3Gc1lWXDznEedB1htURQJhcmBG/gfloc2G6Q55nwrxXnlChkSfCU7rsz1YgNx/AMCI59zACrxpiyByj6kcJbODQdy4Nr1r0/4Bgz+iHCLRnRVOek9PB29fXrd26u0PBNqYLgkJaWNcTErHN/MP57xfq2OazM5Jz08J1vpElpkrQK7djYuo8wEOxr6sgpIv3vqX31TnsWGxbMvYsjDKWwT8sRg+EMcED7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx66uGoNnXZ1Fdi/RfhgkflZ+AEPQecB2FAA4pCdcWY=;
 b=pwfZl/ng6/YOaE2DXxVdCARrM0ygYb+C9KhQpgp7IwoIzpYwxJS1aYfUGXQgXe259m0/RWLmw3rx5u4PYXyRy84EZ+bPgQQ/X7ddo55WepILRohlhYD/tHNHkc0G1DIjkjWNAUasgfq9nsv6botb60g11G7ooGawiiUdvplBqOSwJmAKMn58D0k0/7eTe66w8WbPMuF3htP0vsZLmzU0uZMfYCiSfATyiEAl2LIIoy8Ubritl4dTAfBqodIVSw40201hecNLJr1GZ5id0eSDP8vJSeW9q5Bx4G0pUx4B/qn7ljQbr24EBSSCgsahyQT29e9xYbed7pAh3AZpoT8uTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx66uGoNnXZ1Fdi/RfhgkflZ+AEPQecB2FAA4pCdcWY=;
 b=bThqcxZW9IVguSh3jwj4wmnukWiwIqPNU6rfC2xN85LwL9yA8YAgDQggbYbbBFDOms6O3yGtSYS+vh5wBEyFng99e2E+USLTUIXSdnQ0E264W7VMo27rmK9vc/OdeVM6rhXqqi0Km7VoRKt1wL/JPdY9VSiWgwexbwKQYCOKlferhCiO67z5sOCqW5NoR/oaGT9XXwxNG8jmB7K1kVuGY6qlcJKVS67nfWH4PY+hsc4KCw13W4HbJQqH27dEXik9qphEXh9IccyuL+wPurH/brO4RgTrar8B5eAa6odwq0IQ5AqXPTUM8HcX2tISzsHXqB3XmYbbRGIoOUELk6nf1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB3192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:41:06 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:41:05 +0000
Message-ID: <ba4fd0dd-f23a-418e-a443-f5575472523f@softathome.com>
Date: Mon, 1 Jun 2026 15:41:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/15] ecdsa: fix support of secp521r1
To: Simon Glass <sjg@chromium.org>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-2-philippe.reynes@softathome.com>
 <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0254.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::20) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB3192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2a4fc8-a029-4bd3-f52d-08debfe36dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: HEUojXlihY2QtvzEPkHGo2rTkjCmBkrBwLXymjDXHHh48ZgcpfZGKsZdU4tY1boWtEmfrM+CHbjfDK9zjdYDYQnnK0UApnrh3swc7bQPJWZvc9xdU0bMUa8d8NBNHWuAq1pahAMQlddCIfz7F1R/vLPSXnw/nAkNv3kfVAMOinmpUNvOziMm1QitcHyIF8nrZm44fumPj9EUEkY8Ah0VMUf2yQk3ADkyIyiUYrcv+XIhy66kDTNsN0IKENRhdmLxk9Rt395geKTqN22dJDm3fexdrq3P5+ppDRPYQz3KaSBIO41saKCsHlI/EauJVBu7LjPt9K5r+CyOGeIrZuuc7ObpNlMOpJ3/qQVKNIkZo+m6MRWv6VCUKpHwduZ6h7ePMltGof0d/0C/tCIGeOx1b9hstkCZYudoP36n+WqT24uS+w5fRMRy5zsw+Z9Zb+ixktlWPyVXDHFAlFRqQRPhlWwPR6KwD2leh0BdVczHuhv8a0sbebuNQaBr1FEP6nTr0UrgzaL/Ts5gbyItmy15BivLHtbSnf5TvPRdedOjqJuPxzhW4CnFpyVBfpP4BMB2hSn8KUE9GzG/UYB/biv8FO1b6MJ9/9wJw0lsy0yVvCUBDNuTXnu9tHt5Zhf+SNIR52/iY/cLXAgf7vgOGi/CX3o8qJFwxSD00T6xVANnJgxqMux97fkZtY9tUIDA3SUC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlU2S2t1TkxvQ3QxWnMxVVl6NTR2aU9hT3VkTSt4N3hTMTJaTkN6bVFRejRh?=
 =?utf-8?B?aVBHKzdLNEZIL2xYamYrTUtRWnVjbWJqSjdBK2JJUjNvV3NZNlB5Tms2S29L?=
 =?utf-8?B?TEQ5dXhwKzMyMDVjcVJ3L044NUdEeHZ6YXdZT3ZzT3VUaGY5c1U1ZDJqVHRN?=
 =?utf-8?B?ZzBqUGljTUI2cXhlczR4dmlxbldrcno3djJGNHg4TUtNUFVLc2JLL3BmMHBE?=
 =?utf-8?B?cGhWSDhNWTdlYVRYb0hnanQ4ekpLTUNRelI4VWxwSkFnelZjMmlJNHpwZ0JZ?=
 =?utf-8?B?cjFWTWJpWktxQWJnZTRZQmUrLzlqazhza3VoNEgzbm11LzMwdWtYeHUwWVJa?=
 =?utf-8?B?YTNUaGZuaFBkS3dDdXBWdU9LcENEd0wzMVRrRFRkZFJyNWQ1TUZEaXR3dkEv?=
 =?utf-8?B?MmFPb0p0OHJvR0NFUFZUNTFkVlV5cEhYZnVWOTVWajRzUy9JUzUyVEU0YlFn?=
 =?utf-8?B?Z3MyWWJKdm1kaXRyZ1pDbVlsTVdUQVpLdzJUbVBBMHZySWNIbDFGU1VJUmNs?=
 =?utf-8?B?WTZ6N0RpMFhoSVpsdDcxN3lPdWhEQWY1c0ZzZmpxN3cyV21IWXd6cERQMU9q?=
 =?utf-8?B?Rk0wU2FMR24wQ2hZMHJFNitSNUt3QjhxZEpORVN4Z1c0b1QvcnFsSTZ6OTda?=
 =?utf-8?B?dHlhNGtvLzJOWjQyUm5iTzlKR25FdndOQ1F3NXU2bkMvL1NWVnlRQ2dJRVQz?=
 =?utf-8?B?K2FIWGYvYzRNMjVYUy9RU0ozK0VJWG9Jazd0clJTUU52bFI5ZVhoeGZkNkFT?=
 =?utf-8?B?akZhS240ME9zQm1JR1lWSmlkeE9Scm5CUUI4U1dVNjRmaUlra2p4TkRsbjFm?=
 =?utf-8?B?bzRkdUcxa3UzODRPSjN1azJEZzEwYUNxVmplU1p2UE5OTEwwc09xWGExTEx3?=
 =?utf-8?B?SkNLSzdwU1BjVzFrcUozczB4d3pmanoyZkp1UHpDa1BFczZiMjYydWVoV3JS?=
 =?utf-8?B?OG1BMnAvKzZKNVB1ZkFGTVYzT2pKUnpudUZKZFo0eE1Xa3JqSHByRGQvSCsr?=
 =?utf-8?B?NmNoRjc0MmVSUjMzR2tpTXU0bklWN1JrSUpQOEtJcHE1MFN3cVZFYmMwNFRn?=
 =?utf-8?B?ZlRraE0zQzRPV1F3dkkxVFp3UjNXWXVGb0IvNnl5ditzSFdpdmZDZng5VjJ0?=
 =?utf-8?B?eEovOXQ0ZHpHOGxYRldYM3E5UDVEN0phT0l1NmxKeU5odU9sY1ZybjFGbDh5?=
 =?utf-8?B?RW02bzQreHVOSEMyNEVCdnU2eFcwTGgwRFluL1VXbEJWMkRvNU5uOUJDZTN4?=
 =?utf-8?B?ZWdYMUdqeHEwa1Z3VG9MOWFPTlBUOEMrQ2F0aHJPQlNpc3NXMlVqUkxNV2o0?=
 =?utf-8?B?TUxJanl1Q2NyN3A2dmhEdG9HWEtNdUFCMU9UUEFvZXRKbXBvbVlnWlZ5Zk5s?=
 =?utf-8?B?UTRFL0p5QWl5cnhZNEFKcThoMHlNdCtReXQ5S2VnSTY1Uy9nYmhKNFRBQTlP?=
 =?utf-8?B?VU04Q2ZyWHZWRzdROW45M1d4a0xRNjBKcElRTjNqM2NsT2FUelJzWHRyNG9J?=
 =?utf-8?B?VEM5WHA3STFDNXIzYWFKQVZLV3VoSjUvY3NHR0JPK21mcHRDMFU0ek9BRVZy?=
 =?utf-8?B?c1lVanpGVUV4T3lqQ24vd3lTb3o0VGdQNFpHblJaK2h4czBLVGdEZWFRaFM4?=
 =?utf-8?B?OEI3aU1nNXFRbjRyeTAyRzQwTUhqOUJST0k2SG5XNGNJUFk3NTJCSGZiQ0pD?=
 =?utf-8?B?ZGxNWWcwL0w3VkJrNFVybFFVY0U2eldiYmx0WWNRWW1ML2hBV0d6eTViK3BW?=
 =?utf-8?B?MHRRSjFodXorZkwrRmpmQWJYajJpUW1DLy9mZ2Q2R1dlR0NMMVc2aHRYdFN4?=
 =?utf-8?B?Z0pmM1JHclJNUkhBZGFZdWtsb3ZTQytlTmxIODlpSWc4eituZjZML1o1Z2ZS?=
 =?utf-8?B?bU1yc0UrZEZRQkVJRGU2RysrcWxFdThHOWRKWmt2WGtLbHNKN2EwS1BCaDJv?=
 =?utf-8?B?L3FRd1RXS2N0Z0l0cFpzaU5uMlk4Y0FzeW5MazRmcGQwQ2FURkpGclozdjVp?=
 =?utf-8?B?QjVuTm5YcFBvenJpWFVaR2Z3c3RycjB6VEZ2R1M0WFAxcjNpSURWdG9JYStp?=
 =?utf-8?B?bm8ybXZRaDVsWUlZMWFhbFQ5bXVQUGRIOEp4elN3QUVvQ2Jqc2dTVjNiNll1?=
 =?utf-8?B?eHJhMjMrTUFzbytuYy9kZlRPdE83eXliemx3UkVBTS9ja0ZCcExwTTBRTjli?=
 =?utf-8?B?MWFhNk1jQVdOM0VUclZYeEtxQ3Y0ZTlJeDZwbEsxZ3lsRDRlNG4wSzMzRUJK?=
 =?utf-8?B?MjN0REhDeDVKdG9pVlNTMmx2OTVtclozT2FLemx0NWtlVXlCRnlYQnFtVzRi?=
 =?utf-8?B?MWFoMW1SVnlKWlNFV0Fpa0k1NEtTcG5MRzFjUFdvQTdqU2U3WGkzcjFGVzdB?=
 =?utf-8?Q?/8CpiLKRnI49N77k=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2a4fc8-a029-4bd3-f52d-08debfe36dea
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:41:05.8870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsdMjse2Gdhz61pjDxiBYtXA9sLAI0UgdPQTbsl3bAcXBZv9mFDIY9XyEkmg3LgUemX6Axql+NOaKd8LdnD0YQ8j1VbVegs0bgFcCM5Jdkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3192
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


Le 29/05/2026 à 09:16, Simon Glass a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
>> ecdsa: fix support of secp521r1
>>
>> Current implementation of ecdsa only supports key len aligned on
>> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
>> aligned on 8 bits. In this commit, we update the keys management
>> for ecdsa to support keys that are not aligned on 8 bits.
>>
>> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>>
>> lib/ecdsa/ecdsa-libcrypto.c | 65 +++++++++++++++++++++++++++++++++++++++++++--
>>   lib/ecdsa/ecdsa-verify.c    | 65 ++++++++++++++++++++++++++++++++++++++++++---
>>   lib/fdt-libcrypto.c         |  2 +-
>>   tools/image-sig-host.c      |  7 +++++
>>   4 files changed, 132 insertions(+), 7 deletions(-)
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> questions / nits below
>
>> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
>> @@ -41,10 +43,26 @@ struct ecdsa_public_key {
>> +static char *memdup(char *buf, size_t size)
>> +{
>> +     char *dup;
>> +
>> +     dup = malloc(size);
>> +     if (dup)
>> +             memcpy(dup, buf, size);
>> +
>> +     return dup;
>> +}
> Please match the U-Boot signature: void *memdup(const void *src,
> size_t len) (see include/linux/string.h). Making buf const lets the
> call sites lose the (char *) casts. Also note that fdt_get_key() now
> hands back malloc'd buffers - please spell out the caller's free
> responsibility in a function comment.
>
>> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
>> @@ -135,6 +180,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
>>        .verify = ecdsa_verify,
>>   };
>>
>> +U_BOOT_CRYPTO_ALGO(ecdsa521) = {
>> +     .name = 'ecdsa521',
>> +     .key_len = ECDSA521_BYTES,
>> +     .verify = ecdsa_verify,
>> +};
>> +
>> +U_BOOT_CRYPTO_ALGO(secp521r1) = {
>> +     .name = 'secp521r1',
>> +     .key_len = ECDSA521_BYTES,
>> +     .verify = ecdsa_verify,
>> +};
> I'm not entirely clear why there are two entries here?
Without this serie, there is an initial (broken) support of ecdsa 521.
It was added only to tools/image-sig-host.c, but with the name if 
"secp521r1" instead of "ecdsa521".
In my first proposal, I have changed this "secp521r1" to "ecdsa521". 
Then, in the review, You and Raymond
were worried about breaking existing code (see: 
https://patchwork.ozlabs.org/project/uboot/patch/20260331100047.34618-6-philippe.reynes@softathome.com/).
So so avoid any issue, I have added the support of secp521r1 and ecdsa521.


Best regards,
Philippe


>
>> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
>> @@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
>> +     x = memdup((char *)key->x + (x_len - expected_len), expected_len);
>> +     if (!x) {
>> +             debug("Cannot allocate memory for point X");
>> +             return -ENOMEM;
>> +     }
>> +     key->x = (const uint8_t *)x;
>> +
>> +     y = memdup((char *)key->y + (y_len - expected_len), expected_len);
>> +     if (!y) {
>> +             debug("Cannot allocate memory for point Y");
>> +             free((char *)x);
>> +             return -ENOMEM;
>> +     }
>> +     key->y = (const uint8_t *)y;
> A few things:
>
> 1. You should be able to drop the char * casts for memdup()
> 2. When the y allocation fails you free x but leave key->x pointing at
> the freed buffer, so a later fdt_free_key() will double-free. Please
> set key->x = NULL after the free.
> 3. The debug() messages are missing a trailing newline.
>
>> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
>> @@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
>> -     if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
>> +     /*
>> +      * The public key is stored as an array of u32, so if the key size is
>> +      * not a multiple of 32 (for example 521), we may have extra bytes.
>> +      * To avoid any issue later, we shift the x and y pointer to the first
>> +      * useful byte.
>> +      */
>> +     expected_len = DIV_ROUND_UP(key->size_bits, 8);
>> +
>> +     if (x_len < expected_len || y_len < expected_len) {
> The previous check was !=; you have loosened it to <
>
> The padded length is known exactly, I think - isn't it
> DIV_ROUND_UP(key->size_bits, 32) * 4. ? So could we check the exact
> value to avoid silently accepting (and truncating) over-sized
> properties for prime256v1/secp384r1 ?
>
>> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
>> @@ -130,11 +189,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
>>                fprintf(stderr, "Failed to set EC_POINT as public key\n");
>>                EC_POINT_free(point);
>>                EC_KEY_free(ec_key);
>> +             fdt_free_key(&pubkey);
>>                return -EINVAL;
>>        }
> The repeated EC_POINT_free(point); EC_KEY_free(ec_key);
> fdt_free_key(&pubkey); return -EINVAL; across five exit paths is
> begging for a goto-style cleanup at some point in the future :-)
>
> Regards,
> Simon
