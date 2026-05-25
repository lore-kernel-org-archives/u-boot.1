Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8D4CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20BC84862;
	Mon, 25 May 2026 16:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="O/MzceBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A5D84874; Mon, 25 May 2026 16:41:16 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2206284841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E284326B12;
 Mon, 25 May 2026 16:41:13 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TPargGG1XJz; Mon, 25 May 2026 16:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779720073; bh=0R0V6JzM0Zr/aW0iY19XVYgQ/bwTkUiYVTSVcfZxQ3A=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=O/MzceBbhm+AsfM+GKpdkvHrnbnk2bJbpXBNZzHjI7r9AwNP/YrlqmBmG0P2EaYp2
 fB/1f5YXyqhIcQHWaPQ9MV/ZflZl04ICAZt40dvLW3bf3Myh/2mzXoj5MA7jKC/k9Y
 8tyvJtsgOizusgOO2G5hPkw9wSOZq4rAFZOWIwdQggXzeVrXZI/+ODfnYp10wxXr8Q
 WXUWspBmojpOsQG1UdWmp/4BsKiqlCzMz5aaXJ9KmYKF8WupdwnXrAywMXjDk6uNBC
 ajJTWQYeQkiRMxA4uiEzresarpDopyyVVHkNXcAVfpFqRhssZcbexhLnufKS/mEExP
 iTB9h/5SSaLtA==
Date: Mon, 25 May 2026 15:41:11 +0100
From: Josh Law <josh2@disroot.org>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
In-Reply-To: <20260525143951.GK1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
 <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
 <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
 <20260525142159.GI1858239@bill-the-cat>
 <1B7720FE-03CB-4CA5-A063-2B4A87B633C5@disroot.org>
 <20260525142718.GJ1858239@bill-the-cat>
 <7418B716-CA18-4745-A95A-D4C61AA903F7@disroot.org>
 <20260525143951.GK1858239@bill-the-cat>
Message-ID: <8A38DBEA-01F7-44F2-9D2F-F86D52804CE9@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
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

On May 25, 2026 3:39:51 PM GMT+01:00, Tom Rini <trini@konsulko.com> wrote:
>On Mon, May 25, 2026 at 03:29:50PM +0100, Josh Law wrote:
>> On May 25, 2026 3:27:18 PM GMT+01:00, Tom Rini <trini@konsulko.com>
>wrote:
>> >On Mon, May 25, 2026 at 03:25:19PM +0100, Josh Law wrote:
>> >> On May 25, 2026 3:21:59 PM GMT+01:00, Tom Rini <trini@konsulko.com>
>> >wrote:
>> >> >On Mon, May 25, 2026 at 03:11:49PM +0100, Josh Law wrote:
>> >> >> On May 25, 2026 3:03:28 PM GMT+01:00, Simon Glass
><sjg@chromium.org>
>> >> >wrote:
>> >> >> >Hi Tom,
>> >> >> >
>> >> >> >On Mon, 18 May 2026 at 09:58, Tom Rini <trini@konsulko.com>
>wrote:
>> >> >> >>
>> >> >> >> On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > On 5/16/26 00:07, Tom Rini wrote:
>> >> >> >> > > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass
>wrote:
>> >> >> >> > >
>> >> >> >> > > > Hi,
>> >> >> >> > > >
>> >> >> >> > > > There was a query on the call this week about whether I
>am
>> >> >doing
>> >> >> >> > > > AI-assisted code review. As I said on the call: yes. Here
>is
>> >a
>> >> >> >brief
>> >> >> >> > > > description of how it works.
>> >> >> >> > > >
>> >> >> >> > > > It is built into Patman (on the Concept tree) with a new
>> >> >'patman
>> >> >> >> > > > review' command. You give it the series name / number, or
>> >> >perhaps
>> >> >> >a
>> >> >> >> > > > patch name/number and it applies the patches to a new
>> >branch,
>> >> >does
>> >> >> >a
>> >> >> >> > > > review then adds its comments to its database.
>> >> >> >> > > >
>> >> >> >> > > > A '-d' flag can be used to create draft emails in Gmail
>> >(sorry,
>> >> >it
>> >> >> >> > > > doesn't support other email programs yet). You then check
>> >and
>> >> >> >update
>> >> >> >> > > > the emails and send them (or delete them). I am not an
>> >expert
>> >> >in
>> >> >> >> > > > handling the 'user voice' part of AI, but have made an
>> >attempt
>> >> >to
>> >> >> >make
>> >> >> >> > > > it follow any provided configuration, as well as to scan
>> >recent
>> >> >> >> > > > reviews to actually create to create a voice.
>> >> >> >> > > >
>> >> >> >> > > > Obviously this is very rudimentary and could be expanded
>> >> >> >considerably.
>> >> >> >> > > > But the mere fact that it creates draft emails is a win
>for
>> >me,
>> >> >> >even
>> >> >> >> > > > if I ultimately delete or rewrite most of the comments. I
>> >can
>> >> >> >imagine
>> >> >> >> > > > 10 different ways to improve it to be more useful.
>> >> >> >> > > >
>> >> >> >> > > > I wrote a blog post about it if you want more details, or
>> >you
>> >> >can
>> >> >> >ask me here.
>> >> >> >> > > >
>> >> >> >> > > > I am very interested in hearing how others are using
>these
>> >new
>> >> >> >tools
>> >> >> >> > > > for code review.
>> >> >> >> > >
>> >> >> >> > > And the big thing for now is that since we as a project do
>not
>> >> >yet
>> >> >> >have
>> >> >> >> > > an AI policy aside from "please don't". One of the points I
>> >was
>> >> >> >making
>> >> >> >> > > on the call is that there's a difference in value between
>> >"Human
>> >> >> >> > > reviewed it, looks fine" and "Human spent some tokens,
>agent
>> >> >didn't
>> >> >> >see
>> >> >> >> > > any problems".
>> >> >> >> > >
>> >> >> >> > > And I know several other people have been doing at least
>first
>> >> >pass
>> >> >> >> > > reviews with various agent-tools, it's just no one else has
>> >been
>> >> >> >posting
>> >> >> >> > > reviews at your scale. And lessons learned from other
>projects
>> >is
>> >> >> >that
>> >> >> >> > > the prompts are more important than whatever wrapper around
>> >the
>> >> >> >agent
>> >> >> >> > > one is using.
>> >> >> >> > >
>> >> >> >> >
>> >> >> >> > Don't think scale is the problem. Tool and integration is
>> >another
>> >> >> >topic.
>> >> >> >>
>> >> >> >> Simon posted approximately 100 reviews in about 24 hours. That
>> >scale
>> >> >is
>> >> >> >> a problem, when most of them are just reviewed-by tags, from
>> >someone
>> >> >> >> that has a history of doing human reviews. Reputation is a
>factor
>> >> >here
>> >> >> >> I'm trying to figure out how best to articulate.
>> >> >> >>
>> >> >> >> I have thoughts on the rest that I want to get back to later,
>> >thanks.
>> >> >> >
>> >> >> >I should point out that I tend to do reviews locally bit by bit
>and
>> >> >> >then recheck and send out in batches later, particularly when I
>need
>> >> >> >to dig into the code and check things. I suspect a lot of the
>> >> >> >'reviewed-by' ones are on revised series where I already reviewed
>> >v1,
>> >> >> >etc. For better or worse, patman tends to have something to say
>on
>> >> >> >most patches (too picky for my style so I often delete comments).
>> >> >> >
>> >> >> >Re the AI policy, I suggest adding it in the project docs (even
>if
>> >it
>> >> >> >is very brief), rather than referencing a URL from another
>project.
>> >> >> >
>> >> >> >Regards,
>> >> >> >Simon
>> >> >> >
>> >> >> 
>> >> >> Hey guys, sorry for the unexpected email but I have a question
>> >> >> 
>> >> >> How would you know the reviewed by tag wasn't just made by a AI
>> >> >> 
>> >> >> Would like: "Here is the tag from soandso AI"
>> >> >> 
>> >> >> Or would it be like
>> >> >> 
>> >> >> "AI reviewed this and it looks fine"
>> >> >> 
>> >> >> Apologies for the unexpectedness of the email :)
>> >> >
>> >> >That's one of my concerns, yes. And I've been a bit shocked that
>other,
>> >> >bigger, projects that do allow for AI review haven't come up with
>> >> >something already.
>> >> >
>> >> >
>> >> 
>> >> Personally Tom, projects like Linux take it slightly different
>> >> 
>> >> maintainers usually say:
>> >> "AI asked a question" then link the sashiko (AI review tool) link,
>with
>> >> all of AIs comments
>> >> 
>> >> The general gist, is if there is any comments, you either fix it, or
>you
>> >> say why it isn't a bug
>> >> 
>> >> I have mixed opinions on sashiko tbh.
>> >> 
>> >> Also, maintainers tend to use their **OWN** review tools.
>> >> 
>> >> But most projects do generally ban AI anything.
>> >> 
>> >> Idk what we could do for u-boot when it comes to a sashiko like
>> >solution.
>> >> 
>> >> Maybe we could talk about it?
>> >
>> >Proposing a policy for the project about AI (and indeed not just
>linking
>> >to other projects which have what I find to be helpful references) is
>on
>> >the TODO list for the project leadership committee. We've just been
>> >busily handling other issues for a while now, unfortunately.
>> >
>> >
>> 
>> I could put something into suggestion:
>> 
>> 
>> So, for patches: you could do assisted bys, and it depends on the
>> maintainer, etc etc like Linux,
>> 
>> 
>> And for reviews: that's actually hard to think about, because some
>> maintainers love using AI review tools because it's useful, others
>> don't particularly like tools like that, maybe a opt-in "reviewman"?
>> 
>> But tbh that's up for discussion.
>
>Thanks for offering, but it's going to be a large / contentious enough
>issue that we haven't gotten to it yet, unfortunately.
>
>

Cool cool, have a nice one!

Thanks!
