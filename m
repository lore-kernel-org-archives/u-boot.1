Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59712F013CA
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83E183DA7;
	Mon, 16 Mar 2026 09:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gPs9sVWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1354083CF3; Mon, 16 Mar 2026 09:17:03 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA39083A41
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqucA3Otafx1+DKQgN0DtidOChTsexi5xoWb3EmoY0BFclEGnQpgS1v9tNgwuvn7J/JE0Ag5etQFh8NY+fACgsE3KlW0IfgTwbo0aUFBIwwiAxdM3KFjTxNAQoZE2G/xOjmSenOUh8TvUqP9PDiPhxIor9dkGxg+no4+i9mCBSIBJJu+rOB0Oj3OU5o9QMmxh+v+avp1Rw+Kjts8J8V8h7HrDRYWOolnX6IN1n7hW3GmMJlfZ4Ms+u+WVl50ILhvQC4lufAKtDveHpTSePbAyRP3bc4CXgTZSJnlDCSlqH72qKpTj5gnImlzgazzfuo0uJwR52iLnPJ29/Uu6HB/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB9ZIKEvOm8TkrFR74ALfYIEi0uXeqBUDz7aXBFfAWE=;
 b=U0CZ/8cZf664kn5G1QHKei6AOtl022ICr0TvviyunXhaZEbTmmi30eeg1BCFc8GU63gI8yRGb1X1n7wcEvlRHy/jlaSlIbbInQu4H70CqDFPMgdcxsH4SSRyMFCjKg8ahx/7EnlR04A5JbTv8T63JYjjInZFYmjDiC2YRDfVRsFKzxjpnLkYqvlnrQlXxNs/2UK8V7pT97c0NEKJcsZF2LBPdZ65FLvwKoS4gx+DpKdj5xr4fINmuuFifLNcL1La7tWdSaRiM+D0um5nRxNIegNghimI8ME9CBPEQVe7fXMUTED4BFJ+1np56jJXJlnmE0DV4QClLadavkGWsrdD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB9ZIKEvOm8TkrFR74ALfYIEi0uXeqBUDz7aXBFfAWE=;
 b=gPs9sVWIOlV9CCVzrgXd2sbfPlVyM4QIhuhdIXSpbL/q0+zDE/IQby8DGDDN50sZ98D9UrSD0WYh5dlF0cyYFhrpj3N6s3B+HVn+6cVnaCeiovolzC+Gq/voguErH/4JpbHNod2hJMoSodbSogq5lyDBdBFro32n/Oa148meTj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB5PR10MB7773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Mon, 16 Mar
 2026 08:16:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 08:16:55 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] test: add tests for left-bracket alias for 'test'
 command
In-Reply-To: <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
 (Simon Glass's message of "Sun, 15 Mar 2026 20:43:49 -0600")
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-3-ravi@prevas.dk>
 <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
Date: Mon, 16 Mar 2026 09:16:52 +0100
Message-ID: <87ldfsp4sr.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F6AD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::290) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB5PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c579ae-3109-48c4-ec47-08de833462a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 4iCm9VAIXPeadlVLSX+wdx5LwJ8eQxTuyJqOK/DCx8QfSLDbd6MLPDOAvkBhMKBu37u6B7aUUNEeKrr+p3AE3U6jvg2HPjSAnQWMTEeLqEtAnzjxnHpywLtCKx1sZdLNE2SsxSyMaMj+Rh3CibbLwMWe2TxxtMpX2SHLnmjXdBu49BfrIunj+h6HRVY62w4/+VOk0mY4IHcC5WkJndnHY6C0ddEd0EBoXFfNBLljkNEbENHqVWfNQSWf4m0cwJ812yLYlwBrighd7kHlOMkyL81XZMN2w/TE3GUknbU8gSRzXVUQFxX8/EJEAwsTaOy5/ffGB41dumM19jdFGcxbxzSlnK0AT5q0qvL/WMxdEVaZzVjvUaQqbO+5nA9OmtKV8+L9mLfeZeHPxnEhGw56PSNs8giwo5GQks+2b4OI9IjkRlKlmmtaWC9/DdrcWw9+QmSD6fi1nFt6u/ZKR28o0hd3kZbvAuOyweDKc4Xe1so5U9QUrfOwoENtb28U1n1K5tPg0+QWdt9HmQs8Bo7KjL7RNAGzdP1Atnq6Wm9tOK3Rgz75MmiWiaobAHOt1Nfs1JdeZg2T5mLl0HXtxGHzKyoo5P/OJR50y/h4W3QrNSPFvVpsSLJxqFowabuqY2SWJZ/KR/5+ve5SBfALmPRng0ODh+DCvx4QktW/S9GJw/ryBZrT7dJtHs85gF6i/SuH3Ru2yjlH1c6IDK4gjdTT4H4ChY9iccLYTPjawtjCa25PSSIG5L7qmFA9ASKHp2wHElsXYx1r/yqoMbzwVoilJsOEY6Dxj/5680PUdTMQZuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KvovfqLNg9ZxVN8Lq+nJrS1fs+GSSvIg3aA4sq9Oi5FGjk9JsyZ/Im4/Nql?=
 =?us-ascii?Q?TdyVXjFgYFsyXa6h1ri0+aLJMZzSfFrb3zYBrNqfhJgPkAh2GVsleoxnWkRL?=
 =?us-ascii?Q?QrjYbDXKO0pXq3s5qGCsIhNt47E1D2o7is7XzaAEMPdbeLiPyhiC7CGPKmur?=
 =?us-ascii?Q?uyZfeMnENB9mZuICxqS4y51cHVnOeHqY1IOFy+144vuTNk07CHwMFYUOMO9V?=
 =?us-ascii?Q?traev51/I7AO71Ku1vBPdzs45odJpM0dowjFPsVRMRTuiZcRVgZgiSq5feJ/?=
 =?us-ascii?Q?/TchgBGYg4i6bJKOSKBYTR4aVUN7Zt1HZZa/Gd3t1c5gs+INNAc4KrLBjDKS?=
 =?us-ascii?Q?E+uz14RTE+7K76S2vL8/B0eDMAmiQAPn1Y4z8E/tqKjUyh2NPaPNJWRLRxXa?=
 =?us-ascii?Q?25ETE10gmakOH79+klLqdLZx9629iL9MPJ4MSvX7kx9k4FrVNu/cWfZgwFUL?=
 =?us-ascii?Q?CyEkwfL//it0yPp8GtToYoJw0kw3S0aVkO7kYZdKN8ev+4L6PuzfHR6W3bqB?=
 =?us-ascii?Q?yJPxUhZkZP46jNUdHx3HDXmyRBxKdkOQnuPpIIwQ4hfRiwUo8uF4yQNv8D2o?=
 =?us-ascii?Q?4uwVlwI5dZA+/7MyqIGDVOrDRnpg0RASJAV27H9EQfjBZuS2XoO1N8SRF9nI?=
 =?us-ascii?Q?szyzGsEuW+OoY9hsxnWBQFxJYffbXbp2TbYJiUKv29DTCbhCgFK24hS0pb1S?=
 =?us-ascii?Q?L+7bzs1vMI53uTR+s4C1pBG9TPgzaCPI2PSc9eHihrE6CiMdrSzn2JBZa+cN?=
 =?us-ascii?Q?CYxuKt4Q3WraTwSAAIOPXfR4CgpRXM1Kceifih+8BdL/vFdebV/UnSfgrfxv?=
 =?us-ascii?Q?3g5wl4WoU/nAdbpqi89/0cbL4vS51oqFmOgHOLfaRXv9kld6si5xfN78pT6+?=
 =?us-ascii?Q?2KPr97w6kFK9LPLWtp0RX1IrMQJmt71BN/VAY6W7h4hFqjEjQZQ1hqCInQ1e?=
 =?us-ascii?Q?8x6JvQjuXR5Xxg9xHU4yDAuqytEwLQREWeNsYpTzhXWJGdbb5LJ4MXIdFRVF?=
 =?us-ascii?Q?VZc7/7F2Yg1jb1ZvTkWPLXMAtOXo/Is/Vyg+NF14f8MjQWspnNDxPP5E6C64?=
 =?us-ascii?Q?Kjo5mZfvn2ZgKOFK63DGFwNtkChwBeWWOBZ/R2jw2LQ2XWx8gqPA+wCxKtB0?=
 =?us-ascii?Q?J1MrKBqaXieFWBnNh/darZVFe405xUoXHmDiVhcRXXWGrR339VRycGv1EG+s?=
 =?us-ascii?Q?nM8jPrTmeSbwi11Yd56kQtasYZ7ydwl1MdNgDyEuKZeqNI7oqaSawtPsOk2q?=
 =?us-ascii?Q?kJ8N/bE8yyZ5/8+p1V6NkbI/5rYXUWOKcD8+6VZMCEtRGdvJBnQnSGT3jRbu?=
 =?us-ascii?Q?WnPjj//PKlBAKB0UtuvFdZ0pnY11fvSPxhpGTjPKON/3+X5ffRVH84epsK3u?=
 =?us-ascii?Q?RAgqotuleo2G7bGCLL0D+YOhy6f6PxfnanNRplIH5sQfRzPKedTjJDscLdnD?=
 =?us-ascii?Q?lGLcXoyZ8A9u4/hLqR46gxLXlOzU8jahMvsWci8MimEW8npoVqgUMpmifyy2?=
 =?us-ascii?Q?PaoHumr53YN9XYxoRm5304nwxZihssLs0SGWjvWjXZ3FwsWj0o7UwS3M+lC3?=
 =?us-ascii?Q?VB9R32H0pLIVy2P62YRGla4vbPDPNN5QalhAvZ7zgXHGC1Z9H9a1/TKExglV?=
 =?us-ascii?Q?SG7DgodbCnKzHAt9MV4Y9mXKhPbfyvwakOUx6JGnl8BAr4dK9h6ElDPKVQbH?=
 =?us-ascii?Q?eEJYCGybiDjKZpvLm2zAFPvWAAJv9pzdqYNRc3Kg4MVifeyu/7vykb4VE4jS?=
 =?us-ascii?Q?Wcp32ekgjiszCwifz/sCdtR2PLpq93c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c579ae-3109-48c4-ec47-08de833462a8
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:16:55.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zghgurm0rInoUcytBbmJ0XuePs7OEMz6CzAmyc+rgYbxNfXLiATpANN+2YR8oWVXE26bF92ov29YxdTPxvjQXVmZUxjxeO9OyUcAI8zQclw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7773
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

On Sun, Mar 15 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> Duplicate a few of the existing test cases, using the [ spelling, and
>> also ensure that the presence of a matching ] as a separate and last
>> argument is enforced.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> ---
>>  test/hush/if.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/test/hush/if.c b/test/hush/if.c
>> index ea615b246a9..148e9a53e90 100644
>> --- a/test/hush/if.c
>> +++ b/test/hush/if.c
>> @@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
>>         return 0;
>>  }
>>  HUSH_TEST(hush_test_if_z_operator, 0);
>> +
>> +static int hush_test_lbracket_alias(struct unit_test_state *uts)
>> +{
>> +       char if_formatted[128];
>> +       const char *missing_rbracket_error = "[: missing terminating ]";
>> +
>> +       sprintf(if_formatted, if_format, "[ aaa = aaa ]");
>> +       ut_assertok(run_command(if_formatted, 0));
>
> How about using run_commandf() so you can do this in one line? Looks
> good apart from that.
>

I did cringe a little when I saw that repeated sprintf()/run_command()
pattern all over that file, but I preferred to stay consistent with the
existing style.

If anything, one should do a whole-sale conversion of that file, but
then I'd not use run_commandf() directly, as one would still pass in
that if_format argument every time, so rather create a local macro that
wraps run_commandf() and provides that if_format as a literal string,
which would also enable format checking.

Rasmus
