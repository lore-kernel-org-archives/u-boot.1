Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6F2CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16E4844CF;
	Wed,  3 Jun 2026 19:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pmyx2dRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E831C8467E; Wed,  3 Jun 2026 19:16:27 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99BB83FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSHtfrxt5tDm16Qnm0loh0yQ6UrDpIeCsrqeoVak7VaSrLwmDxLn8ysQs8nAdN64azQW4We0fa1GmKMBgoD/iNRDtQBAlTiBBxgY1AT8SaX//v+hHZQDuaJIjK/mCDS3egw4PYL0MZcEY5zvANRZ4jhradnaUIy2iQijuc8iiSCtH/83qmhXqeIbiPjU1Z9RnbI1l5t/RlQUX95uygw1tX1F9VWv96tHXLHq+44MaWiAXZR3jnDaRrDdLeDrZzObeSBywooyBN2tCWWQDiSNkiE8lQ0NLNcnoBR03KV9pkwCVdZMdGtIJJDMB4ETyUaiReRrudgkx2d/LEfVdffArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihFeI8qwG88Y+9P/0hmPPiqeEt3fCIlrGjuhZMKE/D0=;
 b=NrEyN/0Bv/rwSE6YewtotSAx5qsi/NR6IxDsFM1SujLnUCiJnMsV/e+VMOg1XidiIEUHheVAKg9fr8oOj58/J50D0AVU1P1JYYUeExZS1f1pFz62taR6ZU/2+bGZlTepT4xRkLaIjg4Db7a1b1VMG9ihPBVvTmrdyIbqzwGxDEAXjFqxNEihFKmcDpRdpQ3WgEO9teriED4K7NkUcWbPKSi2jMcLPevlNAn/NpE5LKEw5Dwbqo8K24ih7c2TfmukQ4Hy0OXYPkRAmic0+qCahe6ndSsf6HmChTmnA+dAZKQr44kH+GZUITkP/GiDrFi1cE4SJJ0CXCW5ZFSuCGSTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihFeI8qwG88Y+9P/0hmPPiqeEt3fCIlrGjuhZMKE/D0=;
 b=Pmyx2dROBqMXim5b3Wfi18gTgfhRfKnCq/TgrItF17aNYpQ5bgrKXaIDGUldsi1EHdtDR1IQlIlobI86OthqHOFlDP/mhxabfS/4Ci2JgrLJFDhzCgH7qoRZ2VaUGHV2DxrD8wYpIIhVFLGo4gtqbV+pYL95XVNG3/82Z7H4KVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 3 Jun
 2026 17:16:22 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Wed, 3 Jun 2026
 17:16:22 +0000
Message-ID: <549986cc-e647-4f7b-8bd9-8747f04d9789@cherry.de>
Date: Wed, 3 Jun 2026 19:16:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tools: mkeficapsule: Rework pkcs11 support
To: Simon Glass <sjg@chromium.org>, Wojciech.Dubowik@mt.com
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 David Lechner <dlechner@baylibre.com>
References: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
 <CAFLszThvtrgFCdvOa1-QYYcrefW=vt95jwMfr+QQykE8E1hg-g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThvtrgFCdvOa1-QYYcrefW=vt95jwMfr+QQykE8E1hg-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfdcfc5-a8ed-4e75-5eed-08dec193d57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|5023799004|18002099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: hUvu2WPlJzslnTasoWn998d8YwJ++Z0bFrSIGj87v7e3zsEUoBZ0hczagsn/ACQlMdozd2jA5HWkDhGGsbF4eThzEBriVdBrACSv0FqqvdcxZFc2KixxByYlKiMepoTLsGDoZGAgC+nUUZV/lg2hNKlnJ+9YlSVFq5n4wdH4IWtaJpa/gsJK1HjykJtGe0E7nfYOGfs9hbXx4Z33OK6JiEkr1r5ifXhLyKuYD48Xj8cZIUGF9s8lvq0aojImzuSrv6ZbxQLcY8gY2jGWs2XyzIxp/yBglZpEL0SpvYbK6bT73lFY+Bsqfw8Ad0zstTb0/tyBKWFiy3hIeCZ4oFjlnE+qnKNKBLHOrI8NgIo91m+e8duBp0p3tEmgD6H+Fl2RU8lYq2xvEIA8+9dwyUtrbqhaBWY3NL0NFt7sZubJQHLawC44lP5mkBcna+noIDtN3OGJjg7/L7/Fp75WFkxk5xq6jr56ZOFP4H6Mzqm7tydLO3FRg01D7Qhn4v2a6uPrFF9ZquiG5lpXyuQXuGl2/w603QcRjgf2iW8x4iSiyxxAlg4Lu0U5RmqQqpGFuPTR4PN1SBvuJAs1p6/cSUUKQHZsaUeVkP8l71cDZd770gjsmIt6q6ZI+VbljdV2G5215eRCT0Ej1imlj9lwXqGHEOElkA0nGOOsCakBSq8VlawR+wJNiUl80kgC8GGq7Z3k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(5023799004)(18002099003)(6133799003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1JQjMrNUlOdS9rMm9raWRuL0JVemxQWDV0dkRzSzJZckFqUzA3OEFWU2ZD?=
 =?utf-8?B?dWFZRnAzaVFCN25oM1FhVXBVbjZEblR6OWtzTC8wcFZuY0ZkQXZMbjVrNFox?=
 =?utf-8?B?a09ScjNCL3d3M1BYVkpjY2M0Mnh2N1RpRTU1elJDSCtJSzJVVUNPOFVDSG0w?=
 =?utf-8?B?OC9yQUYxencwNlVNR2NzMWRUN2JjV1pzemFZNWx4T0hIOHA5UlNzVkFaMFhT?=
 =?utf-8?B?aW9zd05mci9CaVNiYldQbzhuTXFpTWVNMjNDblVUWVFURTFUb1dOZGRmMkpv?=
 =?utf-8?B?RHU2MzkxZDJYb2F2Y0xjdWxsNS9GTUtwNDltdFZiUVlYN282QW5VazR1b1Fj?=
 =?utf-8?B?RnVNaVpNbHRPL29lZXVFWWhPWnNJem1vckJPWTl3VzFFcDBvQkVkTDNQSU1I?=
 =?utf-8?B?OXpZU0toUjB2OTNOMFV1OUwxdXhsMkFRQ1c5ZDZBNjRjZThrQ09LR2d2bmZ3?=
 =?utf-8?B?cVBhenM4OFh2eUVTU29udzlSSlBka0dXS2FvZ1ZPVkptY29HMlYxMU9TNmtj?=
 =?utf-8?B?aDV0MFN3M1Jac2Q3UW1CczZZNXBaa0U0dkNWcE10Qnkwd2NXYTlJZFZabVN3?=
 =?utf-8?B?dDRvNXZqL3RMRFowRU9ZYjFGbzNPaUNiY1hRMTBhOWdPLzk2cnliR21VeHVD?=
 =?utf-8?B?MXdYTmFtZ0RjSkdIcXhac1JKQzMvNVFubm1lcHNQNmZIejNRcWoyRnNsTlZ2?=
 =?utf-8?B?RXRMTHhqZDkvaUNvcmtLNDU1OTY0YzBZVXc0N0tjUEt4dzVkZUpmbndDUFF5?=
 =?utf-8?B?ajErN2VFV0hQY2JheHhhdnY2Y1RCNFd2YW5KRnAyYlhVSnhBSW95KzIvL0JP?=
 =?utf-8?B?S3g3UXdRZ2FERG81RXpXZGd1ZXJhV3BRZlNMbWJxRC9RNG1uTjljdUkrNnBI?=
 =?utf-8?B?R1V4UVVWeTljMlY2R1dwSFpUSHhTb2pRWXRWUUJlMklyRzVvVWF4cXlDdFds?=
 =?utf-8?B?d25pZmVNSHFQblErTGJGUmV5YWhhUGhwUnZ1bmZ3aDVBcHIvY2NhNWdiUWxV?=
 =?utf-8?B?ME5nT09wZ2ZteDZqSXVFTDFvR0NFbW9MVkpSdXpCZVBXSlFJcVJObURRSXU4?=
 =?utf-8?B?WUQ2Z3M1RGc0TDZPMUJYVXlNalhPbXZFVldHTjF6V21YNC9mWFBNQ0VXMWlT?=
 =?utf-8?B?U1pQVXBmNE4rQzA5YXIwVm94OFBvVFVXbll2OTlocTM2dTA4bW9NbytIaVRy?=
 =?utf-8?B?RUdWaTNCTFFaS1N4dXI0bFVjUTh2a0ZvSXV3N0JoNW5ZQmJQUmNsZTIvUUs1?=
 =?utf-8?B?d1FCWUo5K0hJWHB3M1R2WUl5NWZLS0l1OXBqY01pTk8wbkVjd0Z5OUZqWEw5?=
 =?utf-8?B?YkovNlVIZnlHQW84TFZnb2dHV1VvSlhucmFTZnFqN0JQMmhIUFkxTS9oRitM?=
 =?utf-8?B?TFduZU1aK2RlYko4QU9xSlkxTXpCTTlOSDJvQVN4bW1WNFJWTDFDbmVzdzE1?=
 =?utf-8?B?VEZjM1BsRWVZTzNwbk9GVjRBb2FVQzBlekk5NDkzNGg4T2U4OUZFVSt2MXBl?=
 =?utf-8?B?OFVZSU1qY2RBR0h0ODd3RjV1TWU2SVI0cng2THd6TEhoSTJ4dHp3QU1KQ1lJ?=
 =?utf-8?B?VnBBREE2eDd1UXdqSXN5Rnl1UHhUZ2JXU1o5NnpTSGRUSk5tQkRDQkJzcnBS?=
 =?utf-8?B?KzJNVHB1ZlA2dktyZ21McWxDYmhsS2hhNEJYYVNYZWtMMTg1R3BxVHZoQVJP?=
 =?utf-8?B?VVdFYWx1TTk5UCtjanlXakhuNVdPb0VTcU1PV1F5Rit0YjJqTk9SZWJIY1h6?=
 =?utf-8?B?cmwxSkpxT04yWFhlZ1NZNHVMWkVqa01TcmJjaVpRWUJzNlZQU0lpbGRXN2Iw?=
 =?utf-8?B?WHRQRDFKZ2NHQjJvUmtSRUd3VUhhUHU0bUVZUDcyQ2gwaXJZQkNqQ2VEN0NQ?=
 =?utf-8?B?MzRFZVVhTEU1MnNTUjgvam82c0dpZEFRTFVCYkV4QzVYZlJmQ2dOVFBVMVcz?=
 =?utf-8?B?VmVTd0RpbUxYaHNZTE05UWEvZmJNcHdPbENxOHcrN0ZZOWRiM1lwRVVpSUJR?=
 =?utf-8?B?eENxUXFVYlRNVzZNY0EyOStlU3doQWx4QmJveXhnZjdzdGRpR3gzalhGa255?=
 =?utf-8?B?L0JDU2ZRazVXRHo4dHlOU1lHZlFGMnEwMzJ5VjZFY0IxTmgvczJySldGVHk0?=
 =?utf-8?B?S2Jja1lZYlBTMjg5NDh0ak1nSTJYaXBnWHREbk1EanFsVmlzbklMMExKVVdX?=
 =?utf-8?B?eE1RQVJnM3krTjMzNFErYWxvTEx0YU9CZkJhN0xwYVZ6NTdKY1VwSlh1WUR2?=
 =?utf-8?B?UWJPTVVFb0pJRUJLSExRZlB2cVI1T0xBM1VWZlA2dGtWSkZqYjdYdzZSRXNF?=
 =?utf-8?B?bTJPb0w5Z3ZCSjdIRWZnUk80dmtQUnl0TlM4ZGN5K25mZkNHUzFXZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfdcfc5-a8ed-4e75-5eed-08dec193d57b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:16:22.0781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u52vg18PE216vZN290Frt7sgB0mZba5y25F0Hmoa5C2ULJDMjr5JKBjDxDqccgICSD0q+UEWJ5o8ydJYi4fEdoq6UuubL7d8oSuTAY60Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
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

There's a v6 already, please post your reviews there again if applicable.

On 6/3/26 6:43 PM, Simon Glass wrote:
> Hi Wojciech,
> 
> On 2026-05-28T08:03:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>> tools: mkeficapsule: Rework pkcs11 support
>>
>> Some distros like OpenEmbedded are using gnutls library
>> without pkcs11 support and linking of mkeficapsule will fail.
>> It would make maintenance of default configs a hurdle.
>> Add detection of pkcs11 support in gnutls so it's enabled
>> when available and doesn't need to be set explicitly.
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Cc: Franz Schnyder <fra.schnyder@gmail.com>
>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> tools/Makefile       |  5 +++
>>   tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++++++++-------------
>>   2 files changed, 77 insertions(+), 23 deletions(-)
> 
>> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
>> @@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
>> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
>> +{
>> +     gnutls_pkcs11_obj_t *obj_list;
>> +     unsigned int obj_list_size = 0;
>> +     int ret;
>> +
>> +     ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
>> +                                              ctx->cert_file, 0);
>> +     if (ret < 0 || obj_list_size == 0)
>> +             return ret;
> 
> !obj_list_size
> 
> Behaviour change: when obj_list_size == 0 but ret >= 0, the caller's
> 'if (ret < 0)' check passes and execution continues with an empty
> obj_list. Please return -1 explicitly in that case.
> 

Yes, good catch, we can have ret == 0 here when obj_list_size==0 and 
thus return 0.

>> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
>> +{
> 
> ...
>> +     ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> ...
>> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
>> +{
>> +     return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
>> +}
> 
> gnutls_x509_crt_t and gnutls_privkey_t are already pointer typedefs
> and neither function reassigns the handle, so the extra indirection
> buys nothing. Please pass the handles by value and drop the '&' at the
> call sites.
> 
>> +#else
>> +static int pkcs11_init(void)
>> +{
>> +     fprintf(stderr, "Pkcs11 support is disabled\n");
>> +     return -1;
>> +}
>> +
>> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
>> +{
>> +     fprintf(stderr, "Pkcs11 support is disabled\n");
>> +     return -1;
>> +}
>> +
>> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
>> +{
>> +     fprintf(stderr, "Pkcs11 support is disabled\n");
>> +     return -1;
>> +}
>> +#endif
> 
> "PKCS#11 support..."
> 
> import_pkcs11_crt() and import_pkcs11_key() are only reached after
> pkcs11_init() has already failed with the same message, so these two
> stubs look like dead code.
> 

How do you compile the code if you don't have those stubs?

Cheers,
Quentin
