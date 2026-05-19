Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5757FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE766847C5;
	Tue, 19 May 2026 16:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="M3Ssndk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF36847E1; Tue, 19 May 2026 16:01:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E23846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is5FOASwPB+9qgw78sTdKBxrfeWzGQCeDAxBYkzWhLj/vkCHz80siAb98uV3VOQVve6kKIn7ASpxY2IVLEIhcLT8eYorbr2knbKKXZWD01DktmFh/PDES2oWDFjAQGG2AE9k5X2tPG8cmdWTIfnXcZowTN25D8AkXvZm+WXHQucPX0OrXl1M1p+PeNEz2KCMADXAW+zaN0ewQW3e8xdmvPGMtO6yoKT2OmSYVkM+5uACq1NuoamR2r2N10QxQI77ZUDX2+nmfQvlzk9kPqyxClNWJsuELS+ETqV1zLkQG4V2eCkNiyFMgx/1XWJschdlxKBm8XQ7r5YNZOxy2NtnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTJKcZlFwV98/ju3VzU3SPWXnCU2B+I/+28lQ4EXuHo=;
 b=A6InsqAcvrt6+elaRgkz1m52c3ePXEs+Obz/a5ltGH1HvojpXQcyYOIPBjzkTjT/qDc9MAnLgl98nmn99zro/08/Mh5UHa6j6zBn/N7MJuS7O1aEixkNz8fkLt7dYgIYpzWIZxMNhLU9sn+712qrbEmkwebbf5bjUvuvWXWz7IkYEiNnhX5J29CD0yYBFNaR9AEfGdngVVJfUj7LBi4OxHpTOQMlSJrerGt/dLYh3VefDO7BHl1YYiiGOBbCCyXwxTb4NRNVDZIBq8EPJmd/ZrCU21sCpwtZGCBTZsYKnzh4R0qxJ39/+KKBEioIVVH24Gplt8ntdyyjJA357jlXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTJKcZlFwV98/ju3VzU3SPWXnCU2B+I/+28lQ4EXuHo=;
 b=M3Ssndk8qjiOzZ9SicjP8C6nkDZyysXxTHXthxMyjP5ahgxXgToccvxcYI0pDTUdgHbIetrrgwk3P0n03lEmTANGdKX+YNYvk8XpbN40nLKyAmdqzSgUV2AIwjUVjndS2LwtSEfeOWG9kWpSoptVQKVrqG2zFHpob1IvfRP0hB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB8074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 14:01:12 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:01:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/2] test: hook up test of allowing control DTB to act
 as FIT image
In-Reply-To: <CAFLszTjjSHWVUjsCCxK2+w6Cp4W56xDis2sWiYFUDDdeAafwjw@mail.gmail.com>
 (Simon Glass's message of "Fri, 15 May 2026 07:06:12 -0600")
References: <20260512161631.284143-1-ravi@prevas.dk>
 <20260512161631.284143-3-ravi@prevas.dk>
 <CAFLszTjjSHWVUjsCCxK2+w6Cp4W56xDis2sWiYFUDDdeAafwjw@mail.gmail.com>
Date: Tue, 19 May 2026 16:01:11 +0200
Message-ID: <871pf7ebx4.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b71f2a7-0706-4db8-564e-08deb5af15b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|3023799003|4143699003|18002099003|56012099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: 3Vh5dRUY+WWCFGK9V7K91fQUmqLW4FM4Alv8XMNuxvtR4fbOYhClSnAaIm1K0+ywrS4PBuGUV46sMQFah5z7jMqorOqqQV96BLAvP+F7+2kfpBskRu+hUZXe71TR1PFvA+3vU+7rqfi2hn01hRYCQNMFw1s5Ah4xgsRjT5M8YKmBq0DI7a/ziQ3R7/e0WdalKl1GjM/RiRFKMwlxkGKqgwBuqqcZfRP/XdgrEygKNcHcjT+OXAyh//fiPDW4vlkhru9vZNHMFJEUV7mslTBj/4QmLkkRh2W/6keV9oAjBXOEgmJT2oxJpgcJz/w5HHGpfHKW9oSQeA4aG51v+RhMnLkcxUaAg4JmucbIPUP+mAgK3vUhg2SbHA6WRWMnABLd8nPVOfaHe4g6NGwYKjydRV9STvo9OSEMcdvuwGtNFp38/Zm9IGc88/qEnNKDvx2njDPyv89YcmYYLYzkJvYlT/G56Swo1tD7y0CVj+SCqDJhQ4aPajKNehq9PNdNHeSilz8u83XvdX5QIpNOc3WiocbPTfU+6UCJlhSQz8RmQAm2dOBgnVoLPU0NE8rmBP/WV2uw/leoIYWddQLKdz7EFfirymdqNbKIWapRPO9olIQjcHhKN14hVXVIS3SUeLBNf4l6b76ot/dqzRpzrDfBCZA1GbYShRVPxC9l8cEt/LC1KITzAC4G7U3eeBqRfTjOen3cs9NeFUDw1TJYcPLwQr+uJlIupVlsTHhgRZSvXgSVrnSe3lsYXRFeOGqdRUUd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(3023799003)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6H2yEql52hCAfWwaC0VX/a6WFSwMj7zynpH/sQHPAE14ODysfvuU3XUE+xoL?=
 =?us-ascii?Q?BepNkTMxOFJRdfL1gRMEMoDhMCe4SjBr5nWP0PJOyjVvzufbejVhfPWIr5s0?=
 =?us-ascii?Q?dQ2wP8MalN08jTEXQ1K+YA5gJufMyyd/EpTRHtmfHhAzeg/oiPC9caGKPh3e?=
 =?us-ascii?Q?tfTvxEGJGD2uEnHFTkD8q8LrIs4KgbO84u+/7RmKYbafev0ymTEZTj+1YSyz?=
 =?us-ascii?Q?yaLeNJWnXMzeyihmNJ2lBot3QGRWLpzMt9W3LLA+ugJlay72qeFY/d8pbbmg?=
 =?us-ascii?Q?LKs226Ae2QRjMLot/4YMuJbqC7Ku9Qyc5NKmO+oIuOqsLBz8ycP5HxwPPY54?=
 =?us-ascii?Q?KAfA+XpqdHnugHR9r7PN06Ya+B89L3iKpv7h89zQ+WzQqKlnIcQM3OwhG2Hm?=
 =?us-ascii?Q?uj/m2DXTpHHg4pEmTbbeLN0J+s3FVxrtaUAC29RuZOcucbmt49eiQtLwY4g/?=
 =?us-ascii?Q?tWHS0ZV2xdW8nK74EA6x4YyL/vI5Oi/JkaebBULzdv14U/SQ3yOcRjt1m/1h?=
 =?us-ascii?Q?OqrweqSJRfJgQWO+pblRX0O5b4ASy2CbKaSpvkQnFqiaF2uhNVQcwLMfMirk?=
 =?us-ascii?Q?z7FtWbFJsTR2vZ1a+amye4ATKh1zkyzWxbY3ICtvpsbITBuao8LemdhRMFJS?=
 =?us-ascii?Q?yRrnj89ePpFvtMlOWtZv+Gnt2hFyvh67K/24Jgc5PzzYTD7m1+4Eb4Y23AVX?=
 =?us-ascii?Q?9BST1zOis36HIi66hmB3iAwpAH4tdo4ZU9VoG4v6xYjLx/8QHCQhBoca7pGF?=
 =?us-ascii?Q?HtXkVzWaxHAyMHhX28MwRjxOejgdZejr8IYV3OUMQI1/vTqWIjg69UWf1zbX?=
 =?us-ascii?Q?ZvX15nyb+LO6lKlaYOC6j8Ucsf2pRolDUVunRgIPwBnPxeboIL+YTT7pGcau?=
 =?us-ascii?Q?I43jcdU5E1K3xTpi+e5tTk8zyItuiFzxQHhekvKaMBTcaqfuOJqXca9fgsl7?=
 =?us-ascii?Q?x5fD6QV2aNSS4pr0gvY7boTV1Gm+eibm+yFS14WihDZGGwHELq0eKKMByIhW?=
 =?us-ascii?Q?vw4Hlx7DdLXWKz4g+xeaERznHM7EgZdtfVIr/9bt/3SRGx2YKA76TGVSC7ce?=
 =?us-ascii?Q?eEvZa5slKD95VUOpKpGWiwHryO32vEbx4pLpU0G/g0Zr8NeTH+hyXswjdAkY?=
 =?us-ascii?Q?2T8exgeeWz1be0KR22Zr0DR2LeWIIi78laIVEyqYI5sDlNx1x+WiXQCDikfU?=
 =?us-ascii?Q?SrI+h+nskE9frrQ60upmhFK+TxN7GCyqsS4CODkIWwpUoVD35mXpjtXM/QRa?=
 =?us-ascii?Q?2OEhaJKjJYWuJ6W3LYd4OGx5WizSAaMVjCUo8jENRn5WejK/QdkOF19bleMP?=
 =?us-ascii?Q?i89ASdqAXmSEYInwPhKdNcvczx/SMSKdEcfMJeeYDfUhZzu5Bk+v16xzYB6N?=
 =?us-ascii?Q?91w4tlk0MLUJSSRgVpFP0T+xas6PexLvpcTRzsilwnOyxf0oaOW0UtNCQHMx?=
 =?us-ascii?Q?ck6YkOUvFKonkex1J6UgsgTAjw9ZHnb1NxG9ApwxJf/ZjOAahFQXUKVC5S3R?=
 =?us-ascii?Q?fC4K3nyzxpkTGV3JAoXrdbqmdFvs8CrNG13FuBK0Zao0p+w/fhJ2NQx0soKC?=
 =?us-ascii?Q?81ryH3imMvLs8xkjI5cqH3zvrF0JBHWWvgeA826sq6og6/4yu1Sx6vPgv4EJ?=
 =?us-ascii?Q?DgejZnpTg19qnBEf5GclWoLDxcCW6Qg+0iVpPCo0kQEzjB0WDUW7TiZccWOV?=
 =?us-ascii?Q?DLsXhHnMMCjax5719oGCvMHyvTSB9ZVUD4+OIUJZVt6b9NXa321MAJQam8tG?=
 =?us-ascii?Q?Z83uzt9T/iGWF/LWb8aEc3xWJC0BYg4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b71f2a7-0706-4db8-564e-08deb5af15b6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:01:12.2619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TZ780EbwCwRAgJEzmIC3V1MywEopawuki0rdK0B9qI3BvOvuZBrQM5KKmZg7hS8Za+14T3BBXAfcJYYMhDkw2KvAwiYc/mkEYH6oB52RhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8074
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

On Fri, May 15 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> test: hook up test of allowing control DTB to act as FIT image
>>
>> Add a test demonstrating how one can embed various scripts in the
>> control DTB and verifying that the source command can be used with
>> ${fdtcontroladdr}.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>
>> arch/sandbox/dts/sandbox-test1.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox-test2.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox_scripts.dtsi | 18 ++++++++++++++++++
>>  configs/sandbox_defconfig             |  1 +
>>  test/py/tests/test_source.py          | 12 ++++++++++++
>>  5 files changed, 39 insertions(+)
>
>> diff --git a/arch/sandbox/dts/sandbox_scripts.dtsi b/arch/sandbox/dts/sandbox_scripts.dtsi
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/ {
>> +     images {
>> +             default = 'test';
>> +             test1 {
>> +                     description = 'Testscript';
>> +                     data = /incbin/('sandbox-test1.sh');
>> +                     type = 'script';
>> +                     compression = 'none';
>> +             };
>> +             test2 {
>> +                     description = "Another testscript";
>> +                     data = /incbin/('sandbox-test2.sh');
>> +                     type = 'script';
>> +                     compression = 'none';
>> +             };
>> +     };
>> +};
>
> There is no image called 'test', so default = 'test' points at
> nothing. Did you mean test1? Fixing it would also let you exercise the
> no-uname case (see below).

Good catch, thanks! I mixed this up with the .dtsi I used for the actual
board I was testing this on.

>> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
>> @@ -34,3 +34,15 @@ def test_source(ubman):
>> +    output = ubman.run_command('source ${fdtcontroladdr}:test1')
>> +    assert 'aaa' in output
>> +    assert 'bbb' in output
>> +    assert 'ccc' in output
>> +
>> +    output = ubman.run_command('source ${fdtcontroladdr}:test2')
>> +    assert 'aaa' not in output
>> +    assert 'bbb' in output
>> +    assert 'ccc' not in output
>> +
>> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:no-such-script || echo Fail')
>
> The cover letter calls out 'source ${fdtcontroladdr}' (no name,
> falling through to /images/default) as the headline use case, but
> nothing here exercises it. Please add a case for that once default
> points at a real image.

Done.

>> diff --git a/arch/sandbox/dts/sandbox-test1.sh b/arch/sandbox/dts/sandbox-test1.sh
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +echo 'aaa'
>> +source ${fdtcontroladdr}:test2
>> +echo 'ccc'
>
> The commit message is very terse for three new files plus a defconfig
> change. Please mention that the test also verifies recursive sourcing
> from the control DTB (test1 invoking test2), since that is a
> non-trivial property worth flagging.

Agreed, done.

> Also, could you add to doc/ ?

Absolutely.

Thanks,
Rasmus
