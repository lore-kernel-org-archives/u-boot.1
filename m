Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD76606A331
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=exofiQK5;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=N9oAItiJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44AA380C0D;
	Mon, 26 Oct 2026 21:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSti0GjC7hqY; Mon, 26 Oct 2026 21:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 34AEB80BFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793049599;
	b=py895NP3UgV1E5/gRpFbJpBWmHrjetZcW7zCHO3SudAVrnvx43wGkgIdsYMSnIlK4Hmo
	 Q9YJ44M4JDWz1u2FnFgU6VJeTbVpeP2SnOualWEAHUXZoMFZXCQz//LEKFRk7ge1WqyD2
	 tdU+vZKDLs0ic1N2US/xY7oXVby0PHT5pAYWR1Evw7TZfE/je2wxTVjAESD01XR4qNh6h
	 dK7kEWL45haoslp1EZzHieDDZnSBp7nb5NQDvdIgJsWCV28Cvz2oGAstCvynPdegCpX5K
	 ainMyeWU8P4+kb+ZqlJEOH4h1Mh7ggf1eek7a3fgWRfEESyl8wXAE1ECAAg1bLVgOkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793049599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G6FSbqTfCx0P/kpdMhFkAbm0DcQjtaK/xlsGFLnP7h0=;
	b=ZJiHSOENDM7cD0mQFckYwrmokElTG6d+tf5MH9y5SKt45eWYabuN+D1s3RHauXlnEC7r
	 DAcbWMyOHMnwYTH9txtrNVsOzLjoSDRgB6xgdEkqfZJZBmmlY4pGsr7DYytRWircus2oF
	 puifoMEEExG23vPi1AxJ4jzsW27M/RR8bzRc5Ka/7WN8YZ/xL8y1b8nqtEQPvxpnotrpA
	 vcfWdyBEyQuypInr8Yb5t8xjF1uJtfI9YjqDdr8froJGCzIAMOInkL5XgrwMgGTArOhtT
	 GQrPPUyGekDfSufxWRMM7MictvxKvkJQKa54NP3VCRyIVhlWZrZewsvAES9G58VO6bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793049599;
	bh=G6FSbqTfCx0P/kpdMhFkAbm0DcQjtaK/xlsGFLnP7h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exofiQK5fxG/lxOKaR9nZqxtw4IEA2adJVAFzm1LgM42RnObUR6+rSOVtDtiT+0+V
	 Pgo5Sh/Za5Wckf+NwIVz5qSCbroV3DIYqRwWMKbrBt68uynOLKQ5JQasxnTjkY7s+R
	 eM2qEsTVOd7mPEmZfuVc7sczPoNDhE6eTsKWYDrGeeip46pdii1O2F0mpnhc1ldUZG
	 JW8UX8Y4vYrOf9FBqenYXy2yZCFCyfWwoNgBdU5vipWhTaEJxrzXR/hFfVhOQpyy7y
	 GBAUlI5yRw1+PDxKL14AfZzA7pkUz+qaxMlCTJsJJJ6TAPre+pTJBQIo68kAdaWPMy
	 IhgSENaPRu4Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34AEB80BFE;
	Mon, 26 Oct 2026 21:19:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3915235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89A8A405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYqspYPCTa8h for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:19:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 895C0405EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793049596;
 b=XrGl1K7cwT7Wp8gArH5ebLd/j3UFVIQuR3BvRWhHzv9k0HaxQW9WHD3FdUrn77vl0kpI
 FRZFSQq4cXEKi8M5lAj1wOpt2cq7hOE6rxvbajkNH8z8FnBmYuTgkNbyvdllVzQEgmCSO
 bKfLQ7q9eY74gFCDkZwzEDv4R8T5pYZo+hIdoX6rjdEXlTOJgHNpkxw8TeZcqQs18FgWU
 HYvzzP54wq+si9PDELdYWw3YzvqbUmZPwVbQG7J6bUYA635cuaaYV3MMGTlbfR2Ed+Hr9
 ydIhaqkVL/lynqexOaQqAKKWBKUkaf+tE3oW21jUvagieIywjpWDxs5N0K4tn/0h8Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793049596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=G6FSbqTfCx0P/kpdMhFkAbm0DcQjtaK/xlsGFLnP7h0=;
 b=A3SS0GxQpoY8VS8i7iFaergZbOR6yKW3/FkIe/14KAs8MktDbSq+TCYYcFLLjFRt91ht
 pSkGkkV+s1+51ebsWhrV3pbxOvHdcbyHHIgDLbuOGfnGW6rkc+xO53n/SITpsLPEzF5PI
 wWwFpk6A1oalLiuhuDimfT3TNktYgNQW0LBG8OHbMkYRpWqDvPQEXYApt7eGOhIYRpxJF
 YnHwbHd69JFFq4Qs2YJxTgUXS6/FGOI8z7JGIqMcyN5HWxopcKTulhd6ZhUG8d440sMSR
 QpAZFQCY2qrxo0Lo2lOOJ1yNTvz+ElCnfOuQAcehjrd0M4AaaZ+0JDFpeAzry3OMkfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N9oAItiJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N9oAItiJ
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 895C0405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:19:56 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4f47feb5a15so610123b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793049595; x=1793654395;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G6FSbqTfCx0P/kpdMhFkAbm0DcQjtaK/xlsGFLnP7h0=;
 b=N9oAItiJhdmR+0+pAPrZy1u9BG3lwj6OINwd5qtOWLMtUr3/nEirLTZdWESuT3VhmK
 0TaDcANyJsxLwQwdQR8Dot7bO5UxzVx1CsMFv4qIWbytM3f1UyXJfRQ6zj2sHSKwm+HP
 2lH7q+aZkOfsml4uhd7dmBlp5OfzWoUqVpB+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049595; x=1793654395;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G6FSbqTfCx0P/kpdMhFkAbm0DcQjtaK/xlsGFLnP7h0=;
 b=fd4+r6aKF9WqYhMDDICUVyqoX2iFhEu2RBa4TSyYpR4YrWwAmUpt3NjrRuZaOUuVvp
 99OoQbaltEtl966FBEv9YaTE91lBmOg3JzDVig8+a8MV2ZvHWEBFXlZhsMzdFXK0rKmF
 XSa+XfLwUI+F1m9paVh6ztelKwTtYwsHyt9KVb2SKEBUXItm+LFZiZ5KNnFRddzQFj6A
 JBSuzXrrZFpQAyzJA85I91aPnp/6iY0/r5jaVesRdu7H5X5/AgW3+3XTik+dSZsyOMyE
 HeO+Re+GeO2e8foyCDETbEwmZBwR3w7Mteio7v1Oxqzgf73H6KP1u6CBRS9fmYEGDSGb
 IvUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdS9KK5ZxxBQsuY5KXeFq6DCXrNUYa7JueQJ39h4mvVZtSnOi052HRdVNeoE3ntpiK5GvlDZY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK6tdaClmNTRt2jMUk2Ovn+f5szZQJy0WRawzi7eVPRpkE6Ykhn
 wZnLBEh4keLvppDpYfBlyEQ9bs2WU4FF+c4HHcKb/8x3CSwzszlynC7cG+g/KQHmsfE=
X-Gm-Gg: AYBFou3mmZZe21a2vMv14Z9wihF136pZhL2qEHCPPO3A/2qTm4YAHE8kr5ZKIPjrNTR
 4q/tFId0FJm8RdvB/mES3oUVSZDbqmrEuGZ4Hb+BipSlff5FQq41kyOUx02KqYJH2a30Y0HBo6A
 +zf/BrfltzZjJhAjD28XJrHdsm8Ar2q5/1f81uWT4PaYO+TCsVJyRZ/j4Ji7an4NJlIn/lKZnsU
 LNb8F0X+/EpB/ruUfmn9WUdL7lAmiXeClOuTDjeqfb6k0l7xfIdH1eDqOkg36hSqAyNsC8pbHbE
 mu6kEFnXw6uEgy3sFUy2K9G7oecHuP5JnXQJwXuzFMWhPS3ZZqGD7MjG+MDVd8nq/B85PkUKnEm
 fvK8dXg8zCRAqgUPywOItU7hNjUcws7NsVqpQfVbUcZ+ousoZbOx++7ZUBUIyQatuQm03Ju4ELw
 MmlkRViceAS01NigwaPpvBG3LubEKAw8IZqK8XDX5ceWA2b2zNqSOiIxnbkF09+xIBJOlqs8B1B
 PweXx4BmQxM2GxU29x5OQoOHMmkavu7qkqGfoH8qrBEyXg1vwT3DYv6UxIcAVWicmSoQiaVHhs+
 4AaBfTnaUWnuWHiz2s2HQAjE2eF/jnHWL/KiS2LojUsDv6TBc53CBDJPJWB+VjBnwLJVhhwNejN
 33/9lXheBnD2PT3dhRRLKdO/Lxhvba2/4jbd9Cr2wIa5zShiSugTuaHw55Lk=
X-Received: by 2002:a05:6808:1506:b0:4f8:65de:7293 with SMTP id
 5614622812f47-55c00296244mr4952653b6e.15.1793049595113; 
 Mon, 26 Oct 2026 14:19:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm6138939b6e.3.2026.10.26.14.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:19:54 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:19:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261026211952.GL646438@bill-the-cat>
References: <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
 <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jDsvNLehfl+bN54x"
Content-Disposition: inline
In-Reply-To: <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--jDsvNLehfl+bN54x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:14:37PM +0000, Bradley Morgan wrote:
> On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
> >> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrote:
> >> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
> >> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
> ><brads@mainlining.org>
> >> >> wrote:
> >> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
> >> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
> >> >> >>>>
> >> >> >>>>Hi all,
> >> >> >>>>
> >> >> >>>>Just a data point from a user: we are using U-Boot on a T1040
> >(QorIQ
> >> >/
> >> >> >>>>mpc85xx) in a product, and we intend to keep up with mainline as
> >> >much
> >> >> >as
> >> >> >>>>we can. We'd appreciate PowerPC support staying in tree, and
> >we're
> >> >> >happy
> >> >> >>>>to test patches on T1040 hardware and report back.
> >> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to use
> >> >64-bit)
> >> >> >>>>and
> >> >> >>>>linux in 64-bit.
> >> >> >>>>I am in the process of bringing it up to our 2025.07 branch and
> >> >> >>>>potentially
> >> >> >>>>mainlining as much as possible. We have some remnants of it und=
er
> >> >> >>>>`board/keymile/kmcent2`.
> >> >> >>>
> >> >> >>>Would T1042D4RDB affect you?
> >> >> >>
> >> >> >>Not directly from what I see in the code, as long as the shared
> >code
> >> >with
> >> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to
> >report
> >> >that
> >> >> >>there are dozens of us using powerpc :)
> >> >> >
> >> >> >What you could do if you would like is to test the whole series to
> >see
> >> >if
> >> >> >it unaffected you.
> >> >> >
> >> >> >
> >> >> >Btw tom I had a idea: you merge Vincent's bug fix and my maintaine=
rs
> >> >> >patch,you make a PowerPC custodian tree, and I handle the series a=
nd
> >> >the
> >> >> >naks and stuff and the comments.
> >> >>=20
> >> >> and btw yes I'll make the pr with the finished patches so you can
> >merge
> >> >> them cleanly
> >> >
> >> >Trees are relatively cheap, but I'm not sure we need another one eith=
er
> >> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts. Sin=
ce
> >> >I added you to the fsl-qoriq tree, you can also just pick up the
> >> >outstanding fixes and your maintainer patches (and leave dropping stu=
ff
> >> >for now, as this series shows today we're just getting people having a
> >> >chance to see and reply to this stuff) and send me a PR. Thanks.
> >>=20
> >> Hi, sorry, I didn't clarify enough, so I had a chat for some people fr=
om
> >> the open src firmware slack, yes?
> >>=20
> >> And here is their answer=20
> >>=20
> >> "Ah, Peng Fan maintains the FSL QoriQ tree:
> >> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
> >>=20
> >> That is the vendor one though.
> >> So yea, I'd go with a general PowerPC tree.
> >>=20
> >> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
> >>=20
> >> And even my slopper suggests the tree, for sanity purposes :D
> >
> >Fine, trees are still cheap. There's u-boot-ppc now. But please keep in
> >mind everything else I said, thanks.
>=20
> Thx.=20
>=20
> Question: will you merge the maintainers patch on this PR, so I can focus=
 on my add-on maintainers patch and the removals?

Lets hold off on the removals a bit more, as I was saying.

--=20
Tom

--jDsvNLehfl+bN54x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/D9AAKCRAr4qD1Cr/k
CprTAP9Bj8MPJXBVETfaIIcND5fnr/jNLXIcRBKglzb4UPgQQwEAwF1xkyEtwpfX
lBmHi7Sx844d5F1teF7SxJbbymusLgI=
=RmE3
-----END PGP SIGNATURE-----

--jDsvNLehfl+bN54x--
