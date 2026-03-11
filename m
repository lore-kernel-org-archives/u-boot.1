Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A96F1125808
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D8384013;
	Wed, 11 Mar 2026 14:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KZ9ZsLX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D7B84020; Wed, 11 Mar 2026 14:25:36 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB6D84010
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL/iozwpw/kBvddDrC5DZaUJ8NNsD4pqNDx9TpTRPaKJXDERuXErfH5wsHmI2o7zPRXnjztxUlWwEVYttgupOLdOOut3rX6k8uLY/2cyIMUSe/eYG5FBvchNCBVd7Kkx46rXRoeAxjmiyUGSvGG1IW6docuAWo7/WsuhNX5MASYO6bZstPRwzBm8wKfr8vFjWv75MoF48V9ZHQTZT8YKnNOVdRRuZhyjfRR53Eovxn70XbmaCa2ICf7nZ53FArZDB/wGMzqa16unKC/s/oxsYdqYwZtiaxeyo8RbdlWaEdrA4oqGof1+GSwkTw+PF8ltvF1KaYGqPzObTYP8AsRUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFtKCgTw7uMt86tAANKIG5EKzdizm4O0+sj2GbOH0DU=;
 b=V39sgcwYzWbt3zBrdWmhCKCfKGhqoCN5hi+JMhLgo/LekSespEZ7FGcORuFWruhXwp7Zt6DCFyUwO2sJfZ8X52CsXaD6tuif3TuZdgYx/YDglGo9mehUoP+zvVnL0rpMHHZjmNVKD4hZA6lVp0U19BpbJhNom9zbuoU7NajkFPUoIc5PN+0lE+T6i9rASbcL822lw+f80GvBO3iffckYvbLwZuiltT1SkRQmKGDmPMDrDojB3HrsLKaV2w/OPw7BsysI5CkbJ2fbPyG8cL4zJdfAygqNLvpi0V7geEHBQdSR9DlT5XqnESiaA83XCEAdfY/hpOdLja5t5IU2HreQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFtKCgTw7uMt86tAANKIG5EKzdizm4O0+sj2GbOH0DU=;
 b=KZ9ZsLX+S4yGgqpXb1IMI/+IOE+aIY8HzTsVj0IaBJLiOBoolfOTWMVLfenCf7yOShKa7ZK/7X0Z3Kumfl7FFlJj7qCok0a2Zx071gFsKihmfA22hzdhj7wa4TpWik7zoHuVNEHbXbZKRyLQcuOwmqxY0IbmFFHO7Uy3f4Cnzjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA1PR10MB8872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 13:25:31 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:25:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] cmd: test: allow using [ as alias for test
In-Reply-To: <abd3d7c1-b56e-4639-85d8-3083f9d0842b@cherry.de> (Quentin
 Schulz's message of "Wed, 11 Mar 2026 14:08:33 +0100")
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-2-ravi@prevas.dk>
 <abd3d7c1-b56e-4639-85d8-3083f9d0842b@cherry.de>
Date: Wed, 11 Mar 2026 14:25:28 +0100
Message-ID: <873426qz07.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000239F9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2ba) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA1PR10MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 351eec81-7e4f-4950-a1fe-08de7f71aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: YEM1aO61e7pmkpfzsXaNn9GPyKXhSn4mAQharKCPqKUZ1LpMuMab0jep7bHFDuFnU7uwFfEI7XbfIjvmB49P8tg1mlYY3X/sMPBsHHWUh30BatGeqABewl7FwjJogjM8K/0tmGvV5gvZsUhhvcPdYXbKYCWkHKMiiKYfNi804UMh9+t+WpaHQjbaqgCUH9bkDUZvox95ah9QCn3774WOKwR59Tdwojw6ZWef5uDQStFTqKifd4jtQIspNWJQ2v4a9AtlzI6Q4MCdu13qJ4J8hZMDmFKEWZqMK6qeK/qlT656Oyfc9809UOgY08o2s2QyXlmfASI5M+tZwCwFDyBa7U1NAYsqdYFXq31esCDD+uZFNzPsXI59gejUJ2yhvlfhr9HvPQca1/UskoPacwC4YsLmLFOq/UfkUIB24aBj1X3Bpasjf9hmIUy9gg/COZLXx0pf3H3opYw0oXgV8C2rfBVWiABfpsby1QMXk5qAjAE7gYoOTNEJhL2CI9g5NbehUMzbWQiD8iP/VXOIQFmuadH1299tqnyBUrvNWWYMFL6ScDDAmwWYF43JJ4vjIXsL+lKWnnVreykxQXcWtwONWtTL3sQgEzldn0bPmSjZcAyHGVZFjkP30KR7FgkfIgq5BZG08uOlqId00K34/8lxV15yUe/4f73jhDtrJB1THoG5Ad05Yd0uxXlNVGTwvJpBXu32IB1F2A3DQBFAW4UWFwcLVYJ7Ee38A1LMy2IE/WORjaufSUzn6MC5q3nlOSsM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vcz5YI/4o/bqypl1xc6eoHusV7VSB6krm/JZUSAJZfRHW2PC+P2Q9gjJdzgf?=
 =?us-ascii?Q?5orZUC527/pP0lqgHcoFOmAAn3Hf5doFTPEkueL5g6cO7nICBh6ZfQi8C70R?=
 =?us-ascii?Q?C66DiOgq0fb/hn5VuAnHX01WIhIeMypBCsipghyru5RLvAdtGdvYKMxQUJA8?=
 =?us-ascii?Q?P8HdEHEt+bNz0xiWq/EsXNTYBAHU2q2YSM0szjyIATPotsvE0eGbXsQ9eG9o?=
 =?us-ascii?Q?qvftrHsdm1EbduAXtsLZyJWhkGoMMrYGeBJxxXxJf7HvDKbBaoHH3Zy3/ZZP?=
 =?us-ascii?Q?bvqUv2mldsirj2fL/pdHWJaGOnZp9LvqLq24FjWw5MI2virX+W+IAf3iUO7W?=
 =?us-ascii?Q?ZYpclFcMEnKtEp4i5YHC9WYufUy5othce6BjdY8BiOfGZch3sOt4m9+4pQQQ?=
 =?us-ascii?Q?T7zrsPJ4KKrlGb0Y5eYmCATjPmPRe0dGHoRqtQe2emiVcahC2bFfjyh3PmMw?=
 =?us-ascii?Q?0C30AZT8S/x87nKU+CVPWcA0YUnSp3heORJpTUHviq6h+pIjpl6zoLzTTm7M?=
 =?us-ascii?Q?w0Ewtg1l//MAbw+fG4KGwUpSNnUaQHi3QE452xz0kG3XFQEK1nnEQpJ0WA+2?=
 =?us-ascii?Q?gOGtFd+iZceRq5Lxbl7dLyCoOiZ7R1oOxe4LQi41+FhbV41x6wdddPVWEg9R?=
 =?us-ascii?Q?2LOy9p7POugP3aHQPJ1jUhp8Ma4ln+ytOObl5ueZ4Lr9vMuH4mKZ/QC9x+a5?=
 =?us-ascii?Q?zGODw1zvbdCfiEoKDXEJKo8Lvca94VdYPVYbLykVOWJTu/5G4+bVaTBqDFGx?=
 =?us-ascii?Q?DVfiO77pRI1t7GXvxt+D8ULApNy/C3Vbpwds1d/VApQ09t8a7NUxZU8QuiIE?=
 =?us-ascii?Q?evYzj9s4L0Se28F1geGdYPHI4/HWvOL/oHlv8jMvkKQOs0qd8gGb//Rbk2fh?=
 =?us-ascii?Q?9BLD+1x5oj09L3T2EaSZKDb1Ur/wH5KGqPW3dewa+yNw8mFRlcLOuBqgDu4L?=
 =?us-ascii?Q?HP3ek/GYU0RG2ZoStAazf8ktdBeoZZiVntIYJsQYKjM+tAWe4x+bWbUHnfyT?=
 =?us-ascii?Q?qgfzPQxgjcY6K78EIRvo9w/Nc+Ixenc68YBoTrWnRKnRUKcaHcNA7ykCkHIX?=
 =?us-ascii?Q?/VGsTaEKr3vCJte14DUZDUxGIBtD/wja/u5EPugHWr6KAmu/PI+rOg9GXBGZ?=
 =?us-ascii?Q?NUNZuHzE9Xr1aTa/r7cExS1QYMT1bUQttK/SKj5arX69PeD6Uk+V+KoXBGYT?=
 =?us-ascii?Q?P200i6m7wtakIUMpHAs9SNfnboRL6JL268+1Qzcq74RSLB54Ds9BWtzOPrZf?=
 =?us-ascii?Q?2/XJuckkrzSoYeOQyY6hdk5S6e6wT2HgTAIbqbEs6ZQAExQJcRsaXV4jaxtH?=
 =?us-ascii?Q?9aUVRao2TUgUmp7lpIPlU7R0/LdPLp9qJzCkRYm93vjp4jwMAKAyukwWTQpV?=
 =?us-ascii?Q?muWssY90fXRS9k2EoFN9TchmLSPEyaGPlxFDRBL2QPt5q80B1DRqcSU5M6f4?=
 =?us-ascii?Q?jhndXB/PmMCkCQ9KZHzybWmb9lseRn6zoZINTZA/mzIzlwcmvFlrdaRRpfnQ?=
 =?us-ascii?Q?ul8hSE/C++lg/d1uxfbKWcxv1Wtp1dtuPvWuh8y4ZVatJxu7hOI2U5lDw7D+?=
 =?us-ascii?Q?fa2DbQjQLSphNwCIA7xqt0ZyHA1EKGVTaIfadN8iB9lSEnZi7IQwxk/kiIXZ?=
 =?us-ascii?Q?XK/8AyB/QrZP/b+AJGmvxvlAbxMngeBk0AiOChrh75g6b8RN3LbqHG1mkhpT?=
 =?us-ascii?Q?3KCfXb5f0Tid8jc6sZzPHIcQrSgC6Yix0MgVuyzjdRQbw17DGXGFKNuUnDdd?=
 =?us-ascii?Q?wMoRxa3n1Vud1904evkkiKr6qVFJJf0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 351eec81-7e4f-4950-a1fe-08de7f71aa9e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:25:31.0076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2GSmhK1pvH/aHigl6PTDG6hL6NqWrbc2qNPrfbrBDxDiC+BeKmgi8gstyrggFibBDrFtbunwjq18HznASoPCwWLVSXwy3Svu1129IshcCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8872
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

On Wed, Mar 11 2026, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Rasmus,
>
> On 3/11/26 1:09 PM, Rasmus Villemoes wrote:
>> I often find myself writing something like
>>    if [ "$somevar" = 123 ] ; then ...
>> only to realize that that syntax doesn't work in U-Boot shell, and
>> must be spelled
>>    if test "$somevar" = 123 ; then
>> It only takes a few lines of code to support this POSIX-standardized
>> alias for test, and helps developers focus on their actual problems
>> instead of dealing with such unexpected quirks of the shell.
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> ---
>>   cmd/test.c | 19 +++++++++++++++++++
>
> Please don't forget to update the docs. It still states "Unlike in
> ordinary shells, it cannot be spelled [.",
> c.f. https://docs.u-boot.org/en/latest/usage/cmd/test.html#description. The
> synopsis should also have a few examples using the new syntax.

Ah, yes, thanks. Rather amazing that I could complete forget having
written that only 10 months ago...

Will update.

> Another question is if you have thought about/tested multi-expressions?
>
> e.g.
>
> [ aaa = aaa -a bbb = bbb ]
>
> and possibly also
>
> [ ! aaa = aaa ]
>

Yes, I did think about those, and I can certainly copy-paste a few more
test cases and spell them using [], but as the implementation is so
simple (check last argv, decrement argc) I couldn't really imagine those
being any different than the simple cases.

> I think adding tests for those would be nice too?

Sure, will do.

Rasmus
