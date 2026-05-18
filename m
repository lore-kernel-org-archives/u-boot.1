Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A33CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D308469F;
	Mon, 18 May 2026 23:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTdmDmZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30DB2846A7; Mon, 18 May 2026 23:54:21 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D1084694
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcd689829eso2466338a34.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141257; cv=none;
 d=google.com; s=arc-20240605;
 b=Qf61Jtj645QOQVVGK5evktARm3dUx2iGVrhARM9Ib/R0mZladjAK3Zmsq0PQdBrth1
 U9PGmv8MhiLN71qjf/6syssPDVWiNAD0fZQyd2oJZeeqUswSKpjf4p56AS9jB3PpRG8w
 T6HlJSy6S+cA0bb2gDpWWIubjTr9TNaS4RQahvgzZzEkZwtTUj5ca2wtrcvfqPK7jJhN
 +MXgpfiNPdPwVraX6EW1kx6JKsU7u4XRzBY/y534mFuvTcZErVnv0tFhrtXVQQ9OOr6m
 kG40W1gQp45efJRAcUn1WbIGXnhV/MLydm91eDlIO4Auh2k5evgpPdbycOrnTPOiOnfY
 xRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LvjbG9fNaHOqdPjhyjf4NoOJd6nxx3NyFFl7SIzRJq0=;
 fh=hSx6fDNzE80BnQkPsI4WHAGQW+l7zolfPlVDE4ySAYg=;
 b=Fb8eatAdQuBAHKVwcmivZl7KT/DCmtKky4y2CELOxpbeBUCg0unZ5wHT6/tfvgXjyl
 1Ujl6NBcth1FdsDgwGdxfwRKZngWVvRqd7N2yHUPT5M/Ol9ntDEHO4zwoxjc9lDbFIHi
 ackLGZEus9wkcx2dVz3kdK7oOpIw6n5pxMVfmIwztuzBIWJTs/kkqN+OsAbYwBvBcsmr
 /9XcSRMXAWhX21Zv7RPWQxALugm+N3Ea/R/ji9GV00Mft531B2ml8JpwvD2Q7l8ravjA
 SUoE108INV1WEOMYnbq8Huw9WVFeMy4oUc+LPJvenajbKdH1x66cJrHgqx4sh+k64GQk
 GOLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141257; x=1779746057; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvjbG9fNaHOqdPjhyjf4NoOJd6nxx3NyFFl7SIzRJq0=;
 b=rTdmDmZ/nViCgBm8LePyZLYi2rOMvnWmqaE3VMQfOOiHlPLbe7Eb+jsEL0foQrlJYD
 tipsfKlW1w2Jb4CtBrM9BZLiS8bxIk/nmiGPAx065pSF03WzlrULrfAb0wn9A0Ex77aW
 EG6fOx8i6k29eLtj1N2uzEInUMfCPM3APP23zN/X/Cuawg1oyrnLfVX22yTDxp0ByKGM
 Pc/wrRrphXE9Cj8DEHDtmuQjjGzajHpJNJX0RkiT3NzflFjPGvBaB/R4k2TIlsCdOQvA
 Y+EY59Uo43W2ycAlpJycmd9wmlYxLx2fuCke/XDmpHPwoZds7ekGikDQudvgzSNOYk3x
 c6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141257; x=1779746057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LvjbG9fNaHOqdPjhyjf4NoOJd6nxx3NyFFl7SIzRJq0=;
 b=S0wXDQAGXR7cO8w/uwwLFnX/wYW7pWPC+J7/5LDwch4cCCnYo3OsJtazvvuzsj4mq/
 Ky1ZoRFeV4O+KC3J0IDNd7WCaP6dagI0/Lm9lp7IQtpr1ynSUw1WAvT6TgHRgeqYYuar
 dz6q00zkWvJrokA2cc/m6pLGnI0Ls1k9Yf405kOpSa3XWfzzhQZmINYZfhUQMp+LikkJ
 TKhos5OmSsfPUplddGIBfBTP32ZAekFgxT6XmJKSygrIGeM4YjoP+UOjUTMI41nlEl1Q
 hhiCl2Jpgoji+addEuu2M63jTe2aChdQ8Y9X3J8wY8PT2xzdKi9EPNs7eMp3RgPovwmK
 iI2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/I6mqFvEP9CMUg6hGP6B3R42yPkm4CzNQIEm4jFjmvCQA/g3MLH5ROUpGfy2hIuIgKmic2eWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+1QZgHguT743s0z6SgSw6XBw9ASzUArdIUwbRMZfhEVqV1gi5
 9nkHIY4jHQH/y5buFOZbQymiCvmghp8oVnAsgG71C/h7mi73oM3tWz+7gJKrKWBsOEi6vUCDpY8
 46y0TZoib4ortW407SgN2040CSeVupU8=
X-Gm-Gg: Acq92OEpoBZ1kwn2UTqcPAkSrxfsQJC8779K9ZHp0xgxiE0ZsINitZag9TogHoo0YS1
 TwpWRcatI0BhwBmxqA4PRH8nSaG/U3OzkNzv7athT332EcIS6K7K3Wg5I2Wmx1uTwmvnEeotjN0
 aslTq71d9xfSOMqSQP+gVEM63Uk/Y8swP4vNK4ETxMM4xDJyCAf+RqgcmrL3tNYUvuSG97P+7JN
 gS3QhptA7gyaNlSA97GhauwlFcpK+1gIidM64eMwESJAFAUUyFO4EqTvAy8M2pyhoAGFCqe6JnM
 tvr2DmuRaTmAheRY7Q==
X-Received: by 2002:a05:6830:4708:b0:7dc:1615:7b52 with SMTP id
 46e09a7af769-7e4fa083007mr11776808a34.26.1779141256953; Mon, 18 May 2026
 14:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
In-Reply-To: <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 19 May 2026 05:54:04 +0800
X-Gm-Features: AVHnY4KcRBRZ6KSt7G5ykP31JT0FRs_kjmNDUY7MzpelqA-gl9usVe_TL-Zl0hg
Message-ID: <CAN7C2SCguh2M3JFC2UE3UFYf6_Z9a9038UEKpFLTTGFTH_r60w@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

You replied with a long passage.
No worries, I finished reading it.

On Tue, May 19, 2026 at 2:29=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Brian,
>
> On 5/14/26 3:51 AM, Sune Brian wrote:
> > Hi Tom,
> >
> > Sorry to bother you.
> >
> > I am curious that for me myself I had no issue to follow
> > the requirements [1] as long as all patches that are
> > passing the review stage do follow the rules in [1].
> > However based on most recent commits and reviews
> > most of those are not even close to what [1] mentioned.
> >
> > So at the end, reviewers in U-Boot just made their own
> > standard and requested contributors to follow?
> >
> > Rather the U-Boot itself should all follow the docs rules?
> >
> > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#send=
ing-updated-patch-versions
> >
>
> If you feel like other people's patches aren't properly formatted
> according to the docs, you have two options:

First I had no intention to step into someone's shoes.
My intention or goal here is pointing out a double standard
on a single patch by the same group of reviewers.
Again no intention on pointing to specific people or persons.

>
> Maintainers are famously overworked in any open-source project you can
> think of. By following the rules (which sometimes are implicit), you
> make their life (and the life of reviewers) easier as it's less effort
> for them to review as it follows some patterns they are used to.

Agree, so in order to follow or change at least as possible why not
quote the docs or requirements or even give out examples in the first place=
?
And rather rephrasing yourself in various standards along the same
patch version?
I guess this is not a schizophrenia behavior right?
Also I would consider such behavior as teasing behavior.

>
> Maintainers are people, like you, like me, they also make mistakes or
> give some leeway because it's the 15th version of a patch and required
> changes aren't worth going back and forth with the contributor. This is
> the *maintainer*'s call, and they're free to decide to do it for one
> patch of one person or not. It's a fallacy to say "this patch didn't
> follow a rule and got merged so I'll not follow this rule". At that
> point, why even write a commit log? Why even have comments? Why even
> care about the code compiling without warnings? Why care about security
> holes in the patch since other patches got merged with security issues?

Agree that human form indeed.
If the same person works on the same review mindset, with my quoted
patches how could it even possible that there will be different
standards when reviewing or passing patches that alarmingly mentioned on
one patch that the format wordings should be xxxx?
I cannot tell this is done by mistake nor not worthy in the first place of
standard who mentioned specifically.

>
> I've learned over the years to not answer when I'm getting angry because
> someone doesn't understand what I'm writing or they have unreasonable
> requests. You wait a few hours, or a few days, and you read again the
> mail with a cold head and you usually read with a different perspective
> and you can now stay polite with them (and sometimes you understand what
> you wrote was confusing because it could be understood another way).
> Getting angry, especially at maintainers, will be a sure way to get
> people to ignore you. Since they are not your colleagues they perfectly
> can decide they don't want to work with you. Yes, it's unfair.

For this it is not unfair to me and it is perfectly fair.
Meantime I have no anger in this first place. I explained on the reply and
had done what you also mentioned at the end of this reply. By xxx reasons
I am going to ignore your mail etc. Why bother?

>
> Remember also that people are not in your head, so providing context in
> your patches or emails is really important. The more information and
> context you can provide, the less the person reading your mail will have
> to think or guess before they can review your patch.

Agree! So this works on both not only one side but both sides right?
Why not cite the docs or provide examples or even explain better from
first place on review in order contributors know what is the standard.
Reviewers expect someone to correct something and with expected
standards so laid down necessary info for it.

>
> For example:
>
> - 8f41874f4631 ("fix socfpga GEN5 handoff script path"). When was src
> variable removed? If I had reviewed that patch, I would have looked for
> a commit that removed that variable and it may not be obvious so it'll
> take me time that you likely have already spent yourself.
> - bb1c2b463265 ("update GCC version check after Kbuild bump"). What
> errors did you see? Did you test any other toolchain than GCC 10.0.1?
> - 5b1fe6ef6b81 ("Altera SoCFpga Boot Stall Fix"). Where does it stops in
> the boot process? What's the boot log? "After testing", what kinds of
> tests? There's no explanation as to *why* this patch works, only that
> it's imported from downstream fork from Altera (that you say is
> "official"). I can understand this as "I don't understand what this is
> doing but it works", which some maintainers may accept, some may not.
> - e291277689f6 ("sync socfpga common u-boot dts". The Device Tree node
> would be present in U-Boot proper. So the issue is that you're missing
> L2 and memory controllers in xPL stages. Why is it important? What kind
> of issues does it fix?
> - 3ba9b1f7bd7e ("Cyclone V Board handsoff script"). No explanation as
> what this does. Why is it better than the current implementation? What
> does it bring? From which version of "official" downstream fork of
> Altera did you import this script?
> - 1feebc36e588 ("FPGA2SDRAM setup fix"). When does it stall? What's the
> symptom? What are the bootlogs? What is stalling "from distro"? "This
> patch fix the issue", but why/how? This sounds like "I tried something
> and it worked, I don't understand why" which we typically do not like.
>
> Were *I* maintainer, I would have accepted none of those patches in that
> form and instead asked you to provide more information. By not providing

Good why not do so, if this is really doing U-Boot benefit?

> information, you're stripping users the ability to figure out if an
> issue they experience in an older U-Boot has been fixed in newer
> versions without having to compile the new version and testing by
> themselves. They could just look at commit logs (or do a search on the
> Internet since our mailing list is publicly archived) and see if someone
> had the same issue and it was patched. This is *not* a theoretical
> benefit, it happens often in the Linux kernel. With additional
> information, it helps us figuring out if we can refactor or remove code
> a few years from now because we could hope to reproduce the problem you
> fixed and see if it's still fixed after refactoring/deleting code. All
> that to say, your patches also benefited from not exactly following
> rules. An obvious one being (specifically the last sentence):

I am not sure I follow you here but I will try.
I am not sure how other reviewers work their code. At least I work on real
hardware no virtual or even without real hardware testing.
At the end of the day U-Boot is to serve not display so real hardware
functioning is the goal.
At least this could trigger maintainers to investigate or confidently reply=
 this
is not the case.


>
> """
> Keep EVERY line under 72 characters. That is, your message should be
> line-wrapped with line-feeds. However, don=E2=80=99t get carried away and=
 wrap
> it too short either since this also looks funny.
> """
>
> They also do not adhere (according to me; see the list of questions I
> would have had on now-merged commits) to:
>
> """
> Detail level: The audience of the commit log message that you should
> cater to is those familiar with the underlying source code you are
> modifying, but who are _not_ familiar with the patch you are submitting.
> They should be able to determine what is being changed and why.
> """
>
> I've noted multiple times that your patches typically do not follow the
> naming scheme where there could at least be one prefix like "socfpga: ",
> c.f.:
>
> """
> If applicable, prefix the summary line with a word describing what area
> of code is being affected followed by a colon. This is a standard
> adopted by both U-Boot and Linux. [...] The best thing to do is look at
> the =E2=80=9Cgit log <file>=E2=80=9D output to see what others have done =
so you don=E2=80=99t
> break conventions.
> """
>
> Though to be fair, some merged socfpga patches don't and it's not always
> easy to find an appropriate prefix. For
> arch/arm/mach-socfpga/misc_gen5.c, it could have been "arm: socfgpa: ".
> For arch/arm/config.mk, "arch: arm: " or "arch: arm: build:" for
> example. For cmd/Kconfig, "cmd: " at the very least. For the new boards,
> something like "arm: socfpga: " for example. This is important because
> people visually filter what they want to review or not. After looking
> into your patch submissions in the past, I understood that you mostly do
> stuff related to socfpga which I have no interested in, but since the
> commit titles don't match what I'm expecting, I now simply ignore all
> your patches even though I could and likely would have reviewed
> f26db83ca964 ("fix PL330 CMD supported target") and bb1c2b463265
> ("update GCC version check after Kbuild bump").

Ok the last part of the reply said why you ignore my patches and
propose the title naming etc.
Again do those have a docs or page that people could reference to?
Or can a reviewer simply mark it as change requests and reply one
sentence i.e. missing proper patch group title reference [1] to correct etc=
?

At least this reply is really constructive on pointing out what the issue
rather than teasing on the header wordings.

Thanks for the suggestions.

Bests,
Brian

>
> Cheers,
> Quentin
