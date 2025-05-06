Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CA2C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 21:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FED8007D;
	Tue,  6 May 2025 23:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="c9NoZO3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CC881FAB; Tue,  6 May 2025 23:10:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DFAD80050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 23:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7E/AiCmPUNwJDBf0hXtTe68UkqbPqBA9IwFjeyoIbeBZ1hq973dunsoyXMkBEv3e/D48GFGp1csh89EsvenkQrsNPzZfZpKeDquGav4ekQamhjvk07WJW8w47MiwsJ4V7CjMC4Ve/GN9lvl0C4gUU9BijsuVBrIAc3aDaZknrH8MvUudDVr4za7qXqYWtsS7FbxpaFa2ZBCLzaPbRKT9VS080q/NkyXbWOIC+KZzZFR6jut/QOLQN7yLX+uc/geheRNzsDJQkzVqU0iOG8oYEU0xD/GpPfq5Y230p+lfu12kwU1z+J2hnzDVIuPUHeRTt9pAe/krO9g9LyykuvjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxhVrt0nSJomkBqnFRvEUaH5q6dH4kq8Fpl4n/uhhxs=;
 b=vM+KwgnsYlrj00iwj5F9UCISorp84+wvoDd5GG1jD9Fcv4e4IGdqbdVu21Zps3wHuuLNBVZbeFrnyOknHcm1+tNXaLT5K5V7RqY4fHo4zSAb/DC2aca8A1MHDiMv9JN+mudMYLkK7wuW+6XUYl1ELN+I6Tk0nR82YY+CkFAsIqEJ+Xl6wpn7MI2iNtz2MUPsvIxtsVPtL+RF1wb9WnxZ7PeHjVHL5K91v//teO8a8dzYo/s5mcToDY+Ggl88nr/mAp5y37AJl6LxUw+Rco2+5j3BXvD33ltiItFQ+OT/URwivcxalAVeVALJX7pjYJ1H2sX1NeasCK5rqpF/hBsYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxhVrt0nSJomkBqnFRvEUaH5q6dH4kq8Fpl4n/uhhxs=;
 b=c9NoZO3HPnzFAy+uwqW1mPm3aAc6IltG2N++9D+7cFsgsLAt4jidrajC2UXbupAxHi6GwXc/YYa3jd52U9NY3AzGKnBJiE8bwHbmanRlH97FwAtcNOZwf34mMjdBvZK6KmVHszDGP5LtYoimUKalnPdDFCV+hBKN9GfqGBYVoAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PR3PR10MB4141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 21:10:20 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 21:10:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] cmd: test: add support for =~ operator
In-Reply-To: <20250506192454.GF5430@bill-the-cat> (Tom Rini's message of "Tue, 
 6 May 2025 13:24:54 -0600")
References: <20250506141035.385756-1-ravi@prevas.dk>
 <20250506141035.385756-2-ravi@prevas.dk>
 <20250506164931.GA5430@bill-the-cat>
 <20250506165221.GB5430@bill-the-cat> <874ixx5zja.fsf@prevas.dk>
 <20250506192454.GF5430@bill-the-cat>
Date: Tue, 06 May 2025 23:10:19 +0200
Message-ID: <87zffp4f9g.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PR3PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c79506e-f8be-467f-9ea3-08dd8ce26889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yGa0Q4HihGNDUg+3ruRjvCWaPI4P0DGRRNoAsqtC3KwJXYyedQDg2YomwKFD?=
 =?us-ascii?Q?TTArWDhDtK0ITDw5cFhLs9wwhdb5JbrZ9HotdIJiYpCNFhjS0IItvvfzV2Oh?=
 =?us-ascii?Q?1KPjUwrC7Dbk0Xd5FmF48oVxW9JCpEnuP4XYNYrnDeSZXTwN7+tW4SPdE/sX?=
 =?us-ascii?Q?Je+CQdstIJ8l27x5I3bZ2lnNfc/D752HjDYA8MeQLId1D6qsQNi6AvSAHChp?=
 =?us-ascii?Q?rw0ijJ9LC2zQCjH0AbxiRHS8t79rptnZAXiIgXNJHeW7qfVcvPvHHTl5v+Zz?=
 =?us-ascii?Q?Z5prQORUYVV7yf8tVvXUjZ2dC4Y5LAs9pN89ZICwjkZgFM84KiZmH8+g0CbQ?=
 =?us-ascii?Q?zQTaqNHfZj33Z0vJfvsgO8oc/ngJNEe8b5q+JYCVGsdYH7zFY3hW2sU+eTub?=
 =?us-ascii?Q?StBjuHZrAYxph9LgFGfLc5yyKF7f/NM9Z/zjhxR0xhNNcFH0QVjMzyy9hgER?=
 =?us-ascii?Q?7fKdArvqWMWduvHF7DbLMhKjPAgTUEmFo+LzSTxXw0lt9CgM6F2D0mP4WPI/?=
 =?us-ascii?Q?z6hdx1ELIoJ7ulJyah9RJ91DZ0/GaTJeI+GYv0mXd8f7bU6U/VlqIjxWSNhd?=
 =?us-ascii?Q?oV5JmlLyGV8o+g3n5BdjPwUtlPJw8CPfb9IUUaT/7zci1IPyPYl9igFKgIf0?=
 =?us-ascii?Q?1N9vj2DOIVBRp44hrn80HS8d3eweJ+pAEYYVkejQlDMEpS4R2An6kRD+8N8c?=
 =?us-ascii?Q?FylKuJkBVnGKmav5GzIGO9GAHAb48RTxPnCirW3lLGDS17hz+LNrwA6sqcXK?=
 =?us-ascii?Q?EYkjY5jTewzbWJCoACZfPksd989MzptZzJzN4Shd4cUzms2T4ERwMi/s1JdF?=
 =?us-ascii?Q?wHKPCQhGua3yvYoouiAYFUQUWE4HvR+QPn2jIcprTS0AdQG/VqLsksaG3//9?=
 =?us-ascii?Q?6tvnZpivHOLuJOlOqyI9Djn08RCV0wpoHnUDT3eASjo2oFQj4stzQM2WiVqf?=
 =?us-ascii?Q?QATYDdnPJQ6X/6J0bO8rYwlRlqCpmKo8w2RV991ocAP3g7KnlsvcYUx0Y6Wn?=
 =?us-ascii?Q?74GOE4US023xyzZKfjiSk8sYmYojXHzfDAN9kqNBE+eKFDPk5BOMgX+Rs8QY?=
 =?us-ascii?Q?NJeD22A3nAPkb/RV/BAnfOjGLssOB3g8CgqUiT32xwBlMygNsWjUIvconQuI?=
 =?us-ascii?Q?UYIijTWCRpB8g7U0EM45QJzKQYIyZilSU7cb8sAdPZRGZ8Gwx1MLDyt8WOJB?=
 =?us-ascii?Q?2HZCGlfB0xxIBsUW6aJc5WDaLadI3FUjyF4Os5ZQLYk5NxfdHvTVRuvafnEJ?=
 =?us-ascii?Q?8mPUPkmigdPTW620Qly2NEzA1o+unIF90+dd0j1GLZLKzWmKPpTpuZrS/HcO?=
 =?us-ascii?Q?NUOZLHNHnKlnOqjSRDLkKbqCli7vKVqu8d8CusueK1PIXwVCKuGEQmwadFsy?=
 =?us-ascii?Q?tpBuBKMofkW6ntrZYQngtrGV6Ih4nYbK9oQIV82kDJQ4zkL3ZiO4tr3mYPkf?=
 =?us-ascii?Q?UStoGyDuXN/7rtYfMk6QXbLw8p5luBDWpPKd6X6Rs3Iem5gs7A7zig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LtZQRwkXflsheKbuMVgEjApdktRfn0fY2W/+r5xwAq2aFRq5DwK9pKmGLZ2?=
 =?us-ascii?Q?C0tbS6b4k/vo3BrcJTyqz4iFU2uYreKd/54yHW2kprDtEGyXQ0IfEm3wDvis?=
 =?us-ascii?Q?JQ2dtAnAHtvT/smCdVViuFGnc8i3XHdH7JIsDS5f2AyuKR8QM2LzMuoPZ4/c?=
 =?us-ascii?Q?LgFBx6sjqqeV9EGG8zR3Xfv+MsagFVZS0/kD4Pl8k4/lJKIZgptMpjUgJI9s?=
 =?us-ascii?Q?WXwfDoYjLgcXpiaQJpHq02c/NpsZKVZwbQsRja2JsQ4Cf/9QbQ/I5zwyPQb/?=
 =?us-ascii?Q?rwt/IcdcxfooH47qMlL/4KkWobGMfZRyo03LhHKeVbQiYhh+46lmozytxXlS?=
 =?us-ascii?Q?yjdgnDQZCHwLR1o9LD+Ad88OyWJoKkJ001h16wWJ3faUGvjID4a6E2PzDQgZ?=
 =?us-ascii?Q?H+7xUtPjnGeckEBjrYihriRalgpheiJeeAJirtZ2AeC0oHOMG3TSRIpQ15dm?=
 =?us-ascii?Q?d+8S/qmJalWjbtdb3aXUD83b0qzDZbQfyBtNH+VL3Yh5lslYF719xKZDCQ7H?=
 =?us-ascii?Q?rQX1NZh/ogXc8/1lnh27FjOVzhlTInSWmeKCQd03HhGSBciZyukQj89L5GoS?=
 =?us-ascii?Q?DE/Jdr8gYL7eGROUEBVzLA6iAsWqTW8yzq10JPPwL3eYeUTljQza8/GBD89Z?=
 =?us-ascii?Q?ErTxOzGTEhtDbz8sK75vfDnqoP44WXr9TjLNjeKR2A6cjQVA7+uMsNT/AWiT?=
 =?us-ascii?Q?O0/ksjAPV1+mA3S9VdiftU3/POdVmg3CZOvbl4ggiBiRCA3BOj0duaw+g0Rx?=
 =?us-ascii?Q?Wi84/DLHtpLAHSdrZwOoM+PVjCvSs/tlCh+JXiPbBwiRC5qPbdiHBqKEF7Me?=
 =?us-ascii?Q?2xDDBCf+Et3/ozaq1ekGUv1VlWHf5coXiaFuxfvX1I0iwysyFQ7rhov/x1pW?=
 =?us-ascii?Q?0TP+n167ASjahcSzo9u+Jo8UK2fuLiwCD04ucVvyQTdgCiYqu3SGem9JkAJG?=
 =?us-ascii?Q?RgAb+z9hTGIAVT8DLtbu0gY0zCZb/tlnP50wNPM40M2Y/yA9SYpaLMdlk4uh?=
 =?us-ascii?Q?N/41iibGUFVJqVCNfo6j/dS/13nFEjTJ2y0XNUrGxsi51yY0wak4nofHxHIM?=
 =?us-ascii?Q?uSZaVv9wqov/MBMGFZ419GMlx8FiAmajFSt0pLMhbZTX2UfzUrWr+h05Lun9?=
 =?us-ascii?Q?fimVzuXAKNrqw3qXmO776ry4xD591YVz5Snsqg3gHTjj19e5noGYhjmCrYHf?=
 =?us-ascii?Q?LWvPkj/J94wlKrnsAcwd65IfhHq0E3qnenYS6s0B4AEnFif/ihTMwgYfIDAE?=
 =?us-ascii?Q?JOgoq56dpapOEwJicy0U2068feqfPnZPfavSSi9Yx60/79xWLuFhfpJ+GBI+?=
 =?us-ascii?Q?6/wZI7fSbubVgkLyqNZJi397iFWtekY2eJbpzEVYdHPpmM/+mayhczN/T8PF?=
 =?us-ascii?Q?M4V3/lgkzq+6LWeqW91Owz610gbR0t5izW6CROViVQusYPv+7gXv5eE/u/t2?=
 =?us-ascii?Q?hT3wwSV4JLIVAiLX6crRaE0O4NeDfczK/sj90mkupp2H0Kq8vklH9IlsZc7G?=
 =?us-ascii?Q?nOF+/+XO5l2+8xZD+HO7OXLcXfIZ8Qi3Tc/Nugk044g5ALGkEaa4eRDuJJwH?=
 =?us-ascii?Q?IaliqSYJ2pUVGSJwjENmiJWKSZtC6PCzxaglgNGIbNCbeJke/CyV35MiKD85?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c79506e-f8be-467f-9ea3-08dd8ce26889
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:10:20.1998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWI/m2p3+tXF+HIjgUqc/XgnU9Kho2ukEciZ5QBnqzgHuPUGBZvB2NzfO9kM5+xOlR7E5wJxWUUJRHPROkOaP9muMMj1dLKvX0DQXoCF7yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4141
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

On Tue, May 06 2025, Tom Rini <trini@konsulko.com> wrote:

> On Tue, May 06, 2025 at 09:07:05PM +0200, Rasmus Villemoes wrote:
>> On Tue, May 06 2025, Tom Rini <trini@konsulko.com> wrote:
>> 
>> > On Tue, May 06, 2025 at 10:49:31AM -0600, Tom Rini wrote:
>> >> On Tue, May 06, 2025 at 04:10:25PM +0200, Rasmus Villemoes wrote:
>> >> 
>> >> > Currently, the only way to make use of regex matching in the shell is
>> >> > by using "setexpr [g]sub" command. That's rather awkward for asking
>> >> > whether a string matches a regex. At the very least, it requires
>> >> > providing setexpr with a dummy target variable, but also, the return
>> >> > value of setexpr doesn't say whether any substitutions were done, so
>> >> > one would have to do some roundabout thing like
>> >> > 
>> >> >   env set dummy "${string_to_test}"
>> >> >   setexpr sub dummy '<some regex>' ''
>> >> >   if test "${dummy}" != "${string_to_test}" ; then ...
>> >> > 
>> >> > When CONFIG_REGEX is set, teach the test command a new operator, =~,
>> >> > which will allow one to more naturally write
>> >> > 
>> >> >   if test "${string_to_test}" =~ '<some regex>' ; then ...
>> >> > 
>> >> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> >> 
>> >> We should also mention here (and then in docs) that this the same as the
>> >> =~ operator in bash, which I only learned about now as part of answering
>> >> my own question of "Are people going to expect =~ to do something
>> >> else?".
>> >> 
>> >> With that,
>> >> 
>> >> Reviewed-by: Tom Rini <trini@konsulko.com>
>> >
>> > Oh, and we should update doc/usage/cmd/setexpr.rst at least and we
>> > should have one for test as well, but don't, yet.
>> 
>> Yes, if test.rst had already existed I would have updated it, but I
>> didn't feel like writing the whole thing from scratch until I had a
>> sense of whether these were going anywhere. I'll take a stab at it,
>> including the bash ref, but I'm not sure what you want to put in
>> setexpr.rst? Perhaps a reference to test.rst for an overview of what
>> regex features are available so they don't need to be repeated?
>
> Yeah, for setexpr.rst I would go for (a) making sure it's correct and
> without subtle bugs (as you just fixed a number of them) and then (b)
> noting that the =~ operator exists and link to the new test.rst

See the patch I just sent. As for subtle bugs, IDK, I've made sure that
the setexpr test suite passes throughout my series, so I don't think
I've changed anything that affects those tests, but I also don't know
how comprehensive those tests are or if they even exercise
e.g. character classes.

>> Another thing I considered was to have the 'test foo =~ ...' thing
>> populate shell variables $1, $2, ... with the capture groups, if any;
>> and possibly even $0 with "what matched the whole thing", as U-Boot
>> doesn't really have anything sensible for that.
>
> I would ask what bash does here first (are things saved anywhere?)

Yes, but bash also has array variables, and it stores the capture groups
in the array variable BASH_REMATCH, so capture group 2 would be
"${BASH_REMATCH[2]}". If $n is too subtle, we could certainly make it
REMATCHn instead for analogy with bash.

> as I assume you use this feature there.

Yes, I do occasinally use [[ =~ ]], but no, I rarely find myself needing
to extract capture groups in that setting. But that's probably partly
due to bash's string expansion features that make a lot of string
munging quite easy; e.g. to get the basename of a file one simply does
${file##*/} ; there's really never any reason to do "$(basename
"$file")".

> And then a second of how useful the captured output is likely to be
> outside of debugging a script you're writing.

Well, I had half a use case some time ago when I first started thinking
about having regex matching in U-Boot shell in the first place, but then
I got distracted, did the whole thing some other way, and now I can't
even remember what it was. I'm just floating the idea, and I won't push
it until there is a real use case.

As for the use case for the regex matching itself, this is at first for
some sanity checking/verification of data related a secure boot setup;
if it doesn't match some strict checks, I'll throw it away and use sane
defaults.

Rasmus
