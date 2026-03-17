Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B330EFED9E4
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176478435C;
	Tue, 17 Mar 2026 16:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="c87/bUt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A16284366; Tue, 17 Mar 2026 16:12:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D412842D7
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIiXKGP/V3pgWb/E66/l0apUnx86fJtRNlLQ3D3oyJwUa9Dg0yOWxFCsFNwQPxpmsycGyKCXY2u+YbaKY4nFCXMPbDP/9d8xJEg9ZC+KTuvEWq/YQWFJgp7gm13e32FU3yP+MQnpzRYpoPyG5iw7nApW5l6WW62J6OfPqM4L8F3nqSmaznG+97F1Mdzkdv8Cqf5TbKdArc2Akj8U2utMrQN8t9cfmXOvn5dtLXXQoFKxuXdwZ8CYvo8GKfTv+E8Wz1WM2RFlffF15noqiGsUeHMP7gtnvaDJ+/nbxeilMAEz1slB35+eUv7ZLcvs55/s6SwGiBT9w9c4XkzBgWtJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEYatEBj0Oul2PXCdhkMeqVCrB3UWl4expiTPG4wZ+0=;
 b=WbIjNH3CDsF1/onK/oAl12BXVvUQGmawNW3HRoQbg+djWI0NZSrVqnW4WamSacI8xyn1IeStT/3CSBhr3YdexACJCoKNxiZNvlhVXII9zLY82VC5uHOJ2YNNVw+mFuv6zMz90HqfRpBR7AxuR3NwxZtXtOWNNIye5czJ9NWl7SU/PjURsUTCUC+64H9/kXKBeGSYN8mFGV/JdLabGrzjVqQloEcRpJz76KYCPqkEf/6izoYI3wuoIDC8jBmkIPXb8lELj045sh2td8tlZMs/sCcEfbB4t76iNZSYB6OmiwPJirioQbi1MNkEI1Jp2e/hYWjxtIeMp3iv4gI8+tx/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEYatEBj0Oul2PXCdhkMeqVCrB3UWl4expiTPG4wZ+0=;
 b=c87/bUt2Ajs11M+vTRhei4oHhfFAtk5nkpqbZUEkVmGde+y54HZvIci2xvk3GI3hxSkVQytvsNXXiNge0RW7FAEDbpI/b5CrMfLbpa7cQqPIlinbucT6wB+UNVtPX9VMFdTUg2Ov0Exrg7bpW+6vAGzGE1WlfTSIn/muxpcT49c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by GV2PR10MB7078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Tue, 17 Mar
 2026 15:11:57 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e639:bdd4:4bb5:6361]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e639:bdd4:4bb5:6361%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:11:57 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] test: add tests for left-bracket alias for 'test'
 command
In-Reply-To: <CAFLszThvNq_KXzoyvOULU74EVWDRYcu2OYz0GS6N+D+mT-BD4w@mail.gmail.com>
 (Simon Glass's message of "Tue, 17 Mar 2026 06:28:57 -0600")
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-3-ravi@prevas.dk>
 <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
 <87ldfsp4sr.fsf@prevas.dk>
 <CAFLszThvNq_KXzoyvOULU74EVWDRYcu2OYz0GS6N+D+mT-BD4w@mail.gmail.com>
Date: Tue, 17 Mar 2026 16:11:55 +0100
Message-ID: <87se9yo5hg.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0019.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::7)
 To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|GV2PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3972601f-6770-431a-71d8-08de843787c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: Bv4MF9zExJTMw4DkPeMQoJoeP9D32s/ZBdZ9xyfA2H7mlXpogjswhkprYwozOD3/gmaM2z7KWzHKhA2nMdC1aYhj+Qjp2zD4lV5+PfnPQKPZtIzVsd7u6eyRPMLlVYIyMXnShIUyVRufOHL8L1D48T+Uc1LPzoVG4M080QKXdTlQNrQhYKE8GRYYr/YuTw+DmfS7Z3Iyu8XbDSBBQE+Aj7riWddnvK6xus2ijrn9filshOEozFpvyhF+crWCOZQjWc+xXx802xG2UiDOIMmbkfNGs9gFng4RKFtrrISyfVgYC/aVhkh5P8Rxriuc+Uxgk1UCO+TlR9pxTX4LGMiLyrxjON/2ehH9ClEXzRPWgJkJsvZ2uz+07e1TRc4nlgBSB8aj/G6SJO0JhORL0sqBOaE4WPGqcrhI6AlI94ywe/MmQV49EnmHTMlaH7DTY1Wjez8x+KQPNumnAsKJoiUqLqD7fD/z49UezO4Dmh/zX2RUpXILeXMJsEiWAevfI0N+OLGoRRbm34u8R7AbgcWbvQ5dKtR0Tma2VPVzoHWfC7g5gV13uo/n9j//C5XDf7Gsaa1RdvpCNHOg+8tRWgADBgfeYSADC0IqwQqzSGQsjxCFHxFVOTcdOn38/TiY1CPBWAuIvTLSuXVPaywY/AwFwB6GvtyZcXLDSjQLjlLfIgJNRHlGg7mQyIVeQL7EwfU3bPFbg/hwMp0jPB2SOo89BfanSyU6G7DdNvZH4DdD2fqSFFrnNvScpElvzRemcs43RK6tPASQhxBscbrYnnYjZ81bGezl4tA+baVOjeKn5h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTBkmG7Ho3hxMo9faTMHGG0kzvNfvWigXiItwMWfloL57GHg32Ucen81XrgE?=
 =?us-ascii?Q?V+oGWgfKAnPY6gsgAPNS0YIbC3/ybZe/KEmv31aFeHH4bfqzm49LwFRL3DUA?=
 =?us-ascii?Q?UZzVDiniKwQLdIC3DOOWTWC9Arr8SHIRINNiefeLeiipv17jPZqnvtPk9dTd?=
 =?us-ascii?Q?gc81NPcjYDO3b03+1/Iu4vdOqCkR79zgYy5ibGaZb165IHPTlfPOu3esFKlf?=
 =?us-ascii?Q?g4+SChf55FZjQp/dXKoKJp2pVN/hsPMidvr7J8v3ObzHHMkJsaU/AObzGkM4?=
 =?us-ascii?Q?fSB+YaAhaM0Nnz9ANeUp30Ng1znq6gJ+oT4nS+TyHt7fCUVUW67rX5sNbUy5?=
 =?us-ascii?Q?TUPYOWDljItFmCxCfXFNr6x/hTeKocFKQXg8I73Fwdoy80vmwuH8HO5fPJr2?=
 =?us-ascii?Q?yC35eDAUgeF98Vb5ohTNpDOabBOQibjTcISlIjU7yPshy5mt+MPrZlBvBRfY?=
 =?us-ascii?Q?E3BQy/A+IwXsSnbeeOUN/E6vrxkUFnWZq1Cj0s/LNg5u7yEta67c6udrwjaf?=
 =?us-ascii?Q?Du33J7Pels4ocqCN/UrSuNvtSvjWbEbWOizcELdt8g9vnUNnbIiE/iIUoEEb?=
 =?us-ascii?Q?P/o7oULpVNIwWPt6cyOt6IGrs1o7dBQ6oalPgY0mC24mB4O27aXBMg6WwjkP?=
 =?us-ascii?Q?zgXfYN9WJY1NIUxyZBdkosVrXLBItTi7LVtTu5x830FM7WkiWfBoPQSfoefH?=
 =?us-ascii?Q?ft7ZFyN7UfndvRWGnUT8bD4rUm7quMSU4R4+GH3SsHceN6D+wTHskT1r9gOr?=
 =?us-ascii?Q?LP42GgEfdb1xBlWPVtENxukzB0/3eixIX0iQTKVJwAfiWil002nMDiyqRuGP?=
 =?us-ascii?Q?2WDYP2BfUzsOzwIwDotvwWM0ii+lzuuI7JwJc9hIVz3/ikARKxhbKOCrGM0T?=
 =?us-ascii?Q?5UEDvFbqMSqnRQTsBPlc7vFhMy/v8gsNFbNFn5HJv3D2gQxhmkBLg0gl1r5L?=
 =?us-ascii?Q?TrX0FlWJOdQksp3UlW5x/s1Gi5N5zUpSjP01zPsZVtetp4OiaAsVLmJ5qC6R?=
 =?us-ascii?Q?dULj0aLnevx/JQCCnhDYZsafiX62f2vu91NaovEETiOkBzfhP3Vyi9qwjKhP?=
 =?us-ascii?Q?cb3sSNFAY0Hn5RttrE6T8pTlo9BqTPJDBHVob9MKppF2i2CI9BZPXxn10z4a?=
 =?us-ascii?Q?x/FZWTQ/yHLLuH5v4UjNhw+cgZbcCK3Bs5ZR2dmmzFa1dqCb2TVJ+i/L7SD/?=
 =?us-ascii?Q?/kKq3JhtVCGUc8doEqF8cNLFyoQ+05h1kV+En3HcMP14R/HBPOame4o8M9cO?=
 =?us-ascii?Q?qjIhAaW3FWv1VmpajzE8leegEJFDLP9UgICfmKceZCmqlI3qcVLTT5BdE0mt?=
 =?us-ascii?Q?OUE9eeIsXUXtFQeoqAFx2It9J3VzN99PonnE6wrLMnkfg3VEByMHjslZhvqM?=
 =?us-ascii?Q?RULvezisGhiFzdPK8vYETdBPnJVHT/cmmdpJ7HxismbdHmjeUzlEUFIqzlFH?=
 =?us-ascii?Q?xNKlL0lv1NA8DmozutdnUT2BNY5loQ6BWTZwySspHMEubpauvXDcAQtZYtp1?=
 =?us-ascii?Q?nB0vBSjlMQXPefS7/v0Lo6OU8/h6ojgbGce04SDHsWzE5dZUGnWIpXye3XFw?=
 =?us-ascii?Q?bmWKsaTg8bAX3xNbJi0TACEfcxlS4zeOO98QlOJpEvemYk3IViu6JKtVxe+4?=
 =?us-ascii?Q?JZjg/LqDQ/G5tjygT0V8gpPem1duguGhUhvVZArJ30I8RO25OX70pEHbJ4X2?=
 =?us-ascii?Q?kOy9hfouOwuS0FRqfmXp3QroF36G+iiyfutdWGwr3h+6hHUxDvPjdQeYl4D/?=
 =?us-ascii?Q?gGm0LrBi4QuAm5Ala1Zt0lRIHzszsrs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3972601f-6770-431a-71d8-08de843787c9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:11:57.0867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/lpx8DBhK9FxQoD9DAy0uYnyJ8O5ct9oTndQLZ5Nb9DspimKbg6QVTmc3ZLW8pFLdOk6qIEqryOuxuErwGZAMJfHdyX3Kq48J8+RJuNe/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7078
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

On Tue, Mar 17 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Mon, 16 Mar 2026 at 02:17, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Sun, Mar 15 2026, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi Rasmus,
>> >
>> > On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> >>
>> >> Duplicate a few of the existing test cases, using the [ spelling, and
>> >> also ensure that the presence of a matching ] as a separate and last
>> >> argument is enforced.
>> >>
>> >> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> >> ---
>> >>  test/hush/if.c | 31 +++++++++++++++++++++++++++++++
>> >>  1 file changed, 31 insertions(+)
>> >>
>> >> diff --git a/test/hush/if.c b/test/hush/if.c
>> >> index ea615b246a9..148e9a53e90 100644
>> >> --- a/test/hush/if.c
>> >> +++ b/test/hush/if.c
>> >> @@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
>> >>         return 0;
>> >>  }
>> >>  HUSH_TEST(hush_test_if_z_operator, 0);
>> >> +
>> >> +static int hush_test_lbracket_alias(struct unit_test_state *uts)
>> >> +{
>> >> +       char if_formatted[128];
>> >> +       const char *missing_rbracket_error = "[: missing terminating ]";
>> >> +
>> >> +       sprintf(if_formatted, if_format, "[ aaa = aaa ]");
>> >> +       ut_assertok(run_command(if_formatted, 0));
>> >
>> > How about using run_commandf() so you can do this in one line? Looks
>> > good apart from that.
>> >
>>
>> I did cringe a little when I saw that repeated sprintf()/run_command()
>> pattern all over that file, but I preferred to stay consistent with the
>> existing style.
>>
>> If anything, one should do a whole-sale conversion of that file, but
>> then I'd not use run_commandf() directly, as one would still pass in
>> that if_format argument every time, so rather create a local macro that
>> wraps run_commandf() and provides that if_format as a literal string,
>> which would also enable format checking.
>
> Well you could have a helper function which takes the string argument
> and does the assert. The duplication makes it a bit harder to
> maintain.
>
> sprintf(if_formatted, if_format, "test aaa != aaa");
> ut_asserteq(1, run_command(if_formatted, 0));
>
> could be something like:
>
> ut_asserteq(1, check_operation("test aaa != aaa"));

Yes, I'd definitely make sure that each test would only occupy one
source line instead of two. What I meant was that I didn't want to
convert

    sprintf(if_formatted, if_format, "test aaa = aaa");
    ut_assertok(run_command(if_formatted, 0));

mechanically into

   ut_assertok(run_commandf(if_format, "test aaa = aaa", 0));

and having to repeat that if_format thing on each and every line.

Also, I think I would prefer to change the assertok()s into asserteq(0,
... ) as I think the mix of assertok() and asserteq(1, ...) is not very
readable.

> If you had the energy to adjust the rest of the file, that seems good too.

I will fix that in a followup if the current patches get merged (they're
at v2 by the way), I do not have the energy to start over and doing the
mechanical changes first and then redo my patches on top of that, so
please don't request that I do that.

Rasmus
