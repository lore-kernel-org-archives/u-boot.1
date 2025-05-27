Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A4FC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 19:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D682838C2;
	Tue, 27 May 2025 21:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TkFO4tjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE0E8317B; Tue, 27 May 2025 21:35:00 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53315830AB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 21:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso886864b6e.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748374493; x=1748979293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fr2OKuGCr+JRtIRsDvdFyRbqZrmFr2mpqsyaN/CeWH0=;
 b=TkFO4tjLR6YLvYyruhmCeo1JvZk3c66L/cucTg6+FxcJQe6gqcGboHHNpPnR8AfS6V
 MPZeVWy0kyBRgo6S3cGVsHOjadnHnrA7QCxbs7KMEZA6mbMiH5k/7iIa2DrmKaAsYgpC
 vmudzJTdAsw2TKAMZe3dnGBwvUD2MTqUyeRWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748374493; x=1748979293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fr2OKuGCr+JRtIRsDvdFyRbqZrmFr2mpqsyaN/CeWH0=;
 b=U30yiNQwYA/O0OubD3EbmoFEL6EJ/2ISVkAeureVrrkmM4AzW7ENWmCUSgEE67BaSl
 UtK5u5JyN7uQOYPQ4B9vcagI9jz2oIutnQ+Dm2doYooFu6FLFGfuverX+iBqtVwxKBBV
 K7/FLWJQDlBxXzG3EeYhcvpzX16Zehw4zMves5cyKUaLxN/StF5gIXZp7XMSL2JjbL3O
 m9c13Xt+2oGKs73vQ0eZTAwBFtxOFrSeWCIuq+fJwnHgU6hidzKgb0OQbPkraoA7Trt7
 g67sbc/F5+66a6WWZKP2eZHos2X6xOVDTwFjoP/Y/Rd4ZvEz78Bto7r6BF7k73zF17si
 86DA==
X-Gm-Message-State: AOJu0YxoeX346nvLVNDNbol/m2Nd2JStZk5vq/OvbOLJy03LQsxadoa0
 Iv/UK2SQZBJ0+ycZB26uraL8b8pYThhXr4vR7PNUtmYKG1ETS4tfpwSB9IEapHSAR4SC5S1Pqiq
 WF6Cw8uI=
X-Gm-Gg: ASbGnctl8GWiikZVqzSvuGXWzwE3HKaatDu+ym0wwbP7P9Xs8tBcSIzGwpFlZjdTPkN
 WFvoQRxBudZvo7ZvapejnZZKpAB53eJIUviIdxedr3QcifXLAJZMP5kQBaFjsu00ws9X+6a3gQc
 GpR2ySA09B1mdAhIPQckGbq/4WbzJQRr0ZX2BjWYvqFUEzJPCdqpfUJ4GdQ/CFbsLgMwANdXRZC
 AAWmGrzonizuQZwU3lfTihLehSp/vA8/QKquKwrzQWFepwVA0nkiUwditj2iHYDJsR8NceoIvU+
 5KlW+C9sX8oBL1j4iVPxYMZklppwgXzXTWG8AcqYzI9qQYv/QvgikU3IJbrYqnbT89yk/BfxMkY
 2OXzebhk19XRp
X-Google-Smtp-Source: AGHT+IE4rZDPrUFhFKKOqBoSWHD6oPtZgJMPpPjVziOKgudmgRbkcZOjDWMmpRwrboQ3ZMJSehmtuQ==
X-Received: by 2002:a05:6808:1c07:b0:402:a5c:906 with SMTP id
 5614622812f47-406468c7d03mr9010419b6e.34.1748374492459; 
 Tue, 27 May 2025 12:34:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f41a3ec2sm4981429eaf.27.2025.05.27.12.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 12:34:51 -0700 (PDT)
Date: Tue, 27 May 2025 13:34:48 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc3 released
Message-ID: <20250527193448.GL100073@bill-the-cat>
References: <20250526220311.GF100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="czJKpCRHE0ZH3xGl"
Content-Disposition: inline
In-Reply-To: <20250526220311.GF100073@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
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


--czJKpCRHE0ZH3xGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 04:03:11PM -0600, Tom Rini wrote:
`
> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. I will be
> updating the next branch shortly. There's still a few things that need
> to come in for the release, as fixes, but otherwise I think the next
> branch is where most changes should end up.
>=20
> We're continuing with a community meeting following the release and is
> the same time as the previous meeting. The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> May 27th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

For today's meeting it was suggested to try and use Google's
transcription service to take notes. What follows is a lightly edited
copy of the transcript. I will say it took a good amount of time to read
and re-edit. I will follow-up with a lightly edited Gemini summary, just
to finish evaluating this idea.

Attendees:
Andre Przywara, Andrew Goodbody, Bryan Brattlof, Gopinath sekar, Ilias
Apalodimas, Jesse T, Mattijs Korpershoek, MV, Rogan Dawes, Simon Glass,
Tom Rini, Yao Zi

Transcript
Tom Rini: So yesterday was release day. I put out RC3. I believe overall
things are in a good state. the one thing I know I need to take in next
is that the revert I posted for the ext4 overflow issue as unfortunately
it leads to different problems. That's on me for taking it so quickly.
Sorry about that. looking forward into the next window next branch
rather.
Tom Rini: so I see that kernel release v6.15 is now in the device tree
rebasing repository as well. So I plan to sync that up and throw it at
CI today. I already did the first half of it. There's a couple of real
quick merge conflicts I need to resolve with copy. let's see.  So we are
what little over a month away from the July release. So I would
encourage everyone to test the current state of master on whatever
hardware they can easily test things on.
Tom Rini: if there are regression fixes that people are aware of, please
reach out to me with a link either in chat here or IRC or email so I can
make sure it doesn't get lost and I will make sure it doesn't get lost.
with that, are there specific things people would like to talk about?
Ilias Apalodimas: I can start the discussion on your preference of the
makefiles because it's a mess anyway the Kbuild system.  I mean, I've
sent the first round which was I don't know basically me porting patches
back typing make looking at the patches and getting further than that is
a bit problematic right the number of patches is huge because the last
thing was on v4.20 and it's not a full thing anyway so there's things
missing to move forward from v4.16
Ilias Apalodimas: I've pasted you some of the patches yesterday, So
there's two options. I either do it incrementally so we can read the
commit messages and review them, but this is going to take a long time
or I just do a diff and I try to bring it up to speed and the commit
message is going to be unreadable. the parts, right? So I don't know
what everyone prefers. I have been moving it forward. I'm trying to sync
it up to v5.1, but again, if I have to do patch by patch, it's going to
take ages.
Jesse T: You're updating the Kbuild system, I take it.
Ilias Apalodimas: Yeah. Yeah.
Jesse T: Okay.
Simon Glass: From my point of view important thing is to update it not
to have a commit history. And you're talking about going back years,
right?
Ilias Apalodimas: Yeah. It's more than four years. Simon Exactly.
Jesse T: I was wondering when I was going to get updated.
Ilias Apalodimas: I can makefiles. that's the easy part. if no one
minds, I can just send the parts I have once I make it pass Power PC or
whatever is failing, right? Because the Partial linking has gone away.
There's a few things that changed over the years. Now, I'm not sure
about partial linking because I was planning on using it on EFI, but
that's fine. And I can plug it on the EFI only. I can send the be if Tom
how confident are you the CI. if that thing passes it mean it means our
CI build is fine.
Tom Rini: So, first, when we've done things up, historically, it hasn't
really been a reviewable diff anyways because it's been grabbing
everything that appears to have been missing from one kernel release
over, the next one we're syncing up with. So, I think it's all right if
we have just several large patches so long as they're at least
biseectable for builds.
Ilias Apalodimas: Yeah. Yeah. Yeah.
Tom Rini: And then when it does come to so what do we do with the
output? There's definitely going to be a few gaps just because there are
some platforms that don't make use of the flag to say hey here's what my
actual final build target is and instead the build instructions for them
are first configure run make all then run make you do whatever to get
the actual resulting binary.  I'm not overly concerned with those just
because I believe we'll just need to do a little bit of kind of manual
spot checking and then ask people to go ahead and test them out. The
biggest offenders there, I believe, are the IMX family. So, it's also
something that's fairly straightforward to spot check at least.
Ilias Apalodimas: Yeah. So the plan I had is this I have the patches I
sent you which work fine and I've tested them enough and I think it's
fine to pull them into next. Then I have another path that basically
brings the cable bill to 5.1. The CI is not passing on that. I have to
fix the remaining CI issues. But my plan once I reach 5.1 is to split
off all the make files to autmake file that we can include and then just
do the dig 6.15 and that should be substantially easier. That's the
plan. Now if this is going to work
Tom Rini: Okay. Yeah.
Ilias Apalodimas: I have no idea. but that's the best thing I found, The
only downside is that you're going to get a makefile patch of 300 lines
that's going to be unreadable.
Tom Rini: If we can do things such that it will be easier to do future
reyncs that would also be good and breaking out as much of our specific
logic as possible into a standalone file will aid with that.
Ilias Apalodimas: Yeah. Yeah.
Tom Rini: I definitely agree. We should be able to get what we've done
so far and then what you have into the current next window and out for
the October release and then sticking up on top of that. Definitely see
how long it takes to get v6.15 or so working.
Ilias Apalodimas: It shouldn't be too far away, If I spend a couple weeks
Tom Rini: Okay.
Ilias Apalodimas: I think I'll be fine. But it's just painful. you add
something, you look at object files, try to figure out what's going on.
It's a bit painful, but overall, I have it passing for most of the ARM
boards.  Sandbox is working. some DTS are blowing up for Xilinx boards,
and I haven't figured that I probably saved off a rule I shouldn't have.
and then it's the Power PC, but I'll leave that for last. but overall I
mean overall I changed the targets to v5.1 I changed everything to v5.1
once I reach v5.1 I'll do a refactoring so we can split off the hub
stuff
Tom Rini: Okay.
Ilias Apalodimas: then if my theory is correct we should be able to jump
to v6.15 a relatively painless move
Tom Rini: Yeah, I definitely look forward to you being able to evaluate
your theory in practice. Yeah, thank you for digging in on all the
Kbuild stuff.  It's greatly appreciated and it really will be nice that
there's light at the end of the tunnel and we'll be able to just go with
hey colonel release let's reync again and not get years out of date.
Ilias Apalodimas: So my whole point is to fix LVM on that, because I'd
like to compile with LVM because it's catching some bugs that are not at
least on the GCC does the same job, But does it's a bit stricter on the
default flags. and the kernel has this nice it says LLVM equals one and
then it use all of LLVMs and flags assemblers linkers and everything
while the only thing we do is use the compiler right now with our make
files I want to use the whole thing but yeah I'll get Yeah.
Tom Rini: Yeah, that definitely be nice.
Tom Rini: And then another thing for people to integrate into their
labs. I know it's been a good number of years since I was able to check
for Pi, but mostly built with clang and see how it worked because
there's some bugs.
Ilias Apalodimas: It does pop errors about unaligned struct members that
are indeed errors. and nothing is blowing up because most of the CPUs
today do unaligned access is fine.
Tom Rini: All right.
Ilias Apalodimas: But yeah I will get there once I fix the build system
first.
Tom Rini: Anything else to talk about on the Kbuild side of things? If
not, that does remind me that I wanted to ask if you had any chance to
further delve into just what we need to do about that QEMU issue on
vexpress_ca9x4
Ilias Apalodimas: No. I'll have a look. I really don't know what's going
on there, right? Because in theory, unaligned accesses should be up and
running at that point. and from what I've looked, it's not EFI that's
crashing because that's what I figured out from the bug report. It's the
TFTP that's crashing.  So my local reproduction, I didn't even manage to
launch the application. The moment I TFTP it just blew up.
Tom Rini: Which is strange for a lot of reasons.  I just gonna say I'm
still not entirely unconvinced that we don't go back to QEMU and say we
dug into this more and know really why is this happening the way it
does? Just for more context for everybody else trying to upgrade CI from
QEMU 9.0.0 to a more current release introduced two regressions or
there's two problems in One of which is specific to a sifive platform in
the SD card emulation
(https://gitlab.com/qemu-project/qemu/-/issues/2945) The other one is
that the V Express Cortex A9 platform fails on a specific test and boot
blows up (https://gitlab.com/qemu-project/qemu/-/issues/2944). Peter
looked into it and one of his comments was that QEMU aims to I don't
think I best phrase it, but it's allowed to do things that real hardware
may not have done but still be correct. one of his thoughts was that
this test should actually fail on real hardware as well, but as far as
I've been able to test and get other people to try out and test as well
on similar real hardware that particular Cortex A9, it's fine on real
hardware. So, it really is a funky thing that QEMU is doing. Maybe it's
really a funky thing we're doing. It's not getting there.
Ilias Apalodimas: So Tom, I talked to Peter in connect and I also talked
to Richard Henderson for QEMU. they believe this could also blow up in
A15 not's due to the architectural things that are enabled. on the other
hand Peter directly went and said this function calls Peter assumed that
this is because of an aligned accesses and he also assumed that the MMU
is not enabled. right now. I don't know if I have the reproduction
wrong, but I didn't even get to initializing the FI subsystem. The thing
crushed when I TFTP something. So, I don't think it's that. And I think
that his assumption by reading the code because the guy didn't run it,
He just read the code and tried to figure out what's going on. I think
we just started from the wrong assumption. I'll try to find some time
and debug it by the end of the week.
Tom Rini: Okay. Yeah, for both of the issues I provided, here are the
steps to reproduce a crash in hopes that someone fire up GDB and Q side
of things and see what's going on. But yeah, it's only, inspecting some
aspects of the code and not rerunning it. It's entirely impossible to do
an assumption. Okay. Thank you. are there new topics people would like
to bring up?  So from the chat, does that also happen on sandbox running
on a armv7a? this particular blowup. I don't know that we've actually
run sandbox on an armv7a host just because I know we don't do that in
CI. Part of that would be because the sandbox tests take so long to run
on anything that's not really really fast. And the next problem is we
don't have armv7a hosts in CI just because again platform be rather
slow.  So in chat (from Marek Vasut) the comment was that would make it
easy to test on sandbox and do we want to sync up off list to talk about
this a bit more I can show you the reproducers? OK yes, so we'll talk
about this a bit more on IRC, thank you. Are there other topics people
want to bring up?
Jesse T: I have a quick question. so for CI, is there a way to make
reproducible builds how buildroot kind of does where it compiles the
compiler and a bunch of other stuff like that or no?
Tom Rini: We don't go to that level of reproducibility with CI and part
of the pluses or minus there is that we do have the docker file which in
turn says we're going to grab some existing well-known pre-built tool
chains so that we can not have to worry about hey did something go wrong
with building a compiler I guess I will as an aside mention that's much
less of a concern these days than it was 20 years ago, but yeah in terms
of reproducibility build support we do have things like being able to
say here is the timestamp to use for any sort of build and we kind of
rely on whatever external build system is building us for handling the
more general build.
Jesse T: And another question, if I was going to set up a CI bot to test
on boards, is there has someone made a build bot for that? I know LDM, I
think LV has their own build bot thing. But that's a little complicated
to set up. Has anyone done that for you?
Ilias Apalodimas: I've done build in the past.  It's not that
complicated, but it's just annoying because the configuration is mostly
in Python.  Other people find it it's fine. I just find it annoying. But
it's pretty reliably.
Jesse T: Can you share that with me? Is that public or ?
Ilias Apalodimas: Yeah, I can share it. I mean, it's not public, but
it's a file. I can send it over.
Jesse T: Okay, thank you. that would be great.
Tom Rini: I was just going to note that I don't know if anyone else has
done buildbot. I know that Heiko has done tbot and has a bunch of that
stuff configured and couple months ago at this point also posted some
patches for here's how to plug bot stuff into the GitLab CI pipeline we
have
Jesse T: Okay. I'm specifically using it to test boards, so I don't know
if it's easy to transfer to runtime testing versus buildtime testing,
especially because runtime testing you don't get a lot of verbosity. It
kind of just fails silently typically.  Tom Rini: So, this was just to
be clear how to have, various boards in his hardware lab get a build,
throw it on, run some tests, and come back.  Jesse T: Okay.  Ilias
Apalodimas: Send me an email because I'm ound to Send me an email and
I'll respond with the billboard confluence.
[edit: Removed some confusion about copying out Ilias' email address].
Jesse T: Also, one of my professors at school found a bug in, DE1 SOC. I
can't reproduce it, which is unfortunate because it's a compiler issue,
which is why I asked about the reproducibility thing. so this was
actually like last year he found this and it's still broken for him. and
another student actually compiled it the same way and also broke but
basically he compiled the compiler himself. He compiled yes that the
Altera thing this is on one person did it on Fedora but also compiled
the compiler themselves but my professor did it on Arch and it's a
runtime thing but if you build root to compile it with the latest deboot
it works fine and on De using the Debian's built-in compiler it works
fine but using that compiler doesn't work. But if I try and compile the
compiler on Debian, it works.
[edit: For clarity, Marek was making some comments in chat here about
the problem].
Tom Rini: Yeah. Any chance you can get the failure log post and post it
somewhere.
Jesse T: Yeah, it does the SPL and then nothing after that.
Tom Rini: And also I guess maybe a log of the building you with that
compiler just in case there's some warnings being thrown up and not as
visible as they should be.
Jesse T: As far as I'm aware, no. I can't reproduce it on my end. If I'm
on their computer, I can reproduce it. two people have been able to
reproduce it. Except I can't. I've been trying to fix it. I have the
board, but I can't. even in an Arch Docker container, it doesn't work.
And I'm like, what? Mhm.
Tom Rini: Yeah, this definitely reminds me of some of the user induced
errors I've seen over the years, but it would be interesting to see what
the logs are.
Jesse T: Where it failed on try to build but the D1 SOC that's a
different thing. yeah. I was just bringing that up??? because compiler
issues. if anyone has the board, maybe they can try to figure it out. I
can send the build script.
Tom Rini: Any chance you also have the script for how everyone is
building the compiler?
[edit: Jesse T has access to the scripts being used]
Tom Rini: Yeah, that'd definitely be an interesting to look at. And I
feel like the end result here might be filing another issue on the GCC
Bugzilla, seeing what happens.
Tom Rini: is there anything else to handle on the call or should we
finish it up afterwards? Okay. Are there other topics people would like
to bring up?
Ilias Apalodimas: There's a CI discussion that Simon asked for yesterday
about running an OS. that's doable. there's one module missing from the
kernel config. I've only worked with Fedora to add that. I tried asking
on Alpine, no one responded and then I just ignored them. I'm pretty
sure that the distro cases involving the one for the phones which is
based on Alpine supports it. If anyone is interested I can send him the
commit message you need a very specific kernel module enabled but if you
enable that kernel module then we can basically boot Alpine on the fly
in DRAM. and it's really easy and really fast to test.  We're working
with Yocto to do the same thing. I lost track of where this is. but if
you don't care about Alpine specifically, in a few months or weeks or
whatever, we'll probably be able to test with a generic Yocto image as
well.
Simon Glass: Yeah. the image I was looking at was it Alpine?
Ilias Apalodimas: you said Alpine on the email and it makes sense
because it's very small but yeah it's fine
Simon Glass: Yeah. 250 megs or so. and I think Tom's response was that
that was sort of okay.
Ilias Apalodimas: but it depends what you want to test right because If
you boot with EFI, what happens is that you create the ISO image in
Uboot, you jump there, but once you jump into the kernel calls exit boot
services and the image you just create, it just disappears. So, You can
boot the kernel, but you won't reach a login.
Simon Glass: I see.
Ilias Apalodimas: So, has all the patches it needs. I mean, I think I
sent a pull request to Tom for that a month ago or something like that.
I think it's in master the obvious problem is that in order to do that
you need the kernel to support the same feature which is basically
preserve a memory node. I'm not sure how many dual support it does
because I added it. I tried to talk to Alpine and they never responded.
So I was like all right I'm going to fix it somewhere else.
Simon Glass: So there is the only test I have at the moment and Tom's
pointed out that there are the network tests that run in the QEMU in CI
but the one not QEMU in some boards or something. the one I have at the
moment is a Ubuntu 24.04 desktop which is 5 GB and that's running on my
lab. so it doesn't matter how big it is because it's just sitting on a
local disc somewhere.  And basically all that does is it boots up. This
is running the installer by the way, not the real OS, just the
installer. And then at some point it says welcome to Ubuntu 24.04 and
then the test passes. is you I don't care after that kind of thing.
Ilias Apalodimas: So Tom, I can add instructions somewhere on how to do
that over HTTP. I mean, it's literally a single command. you just need
the right OS. I can even send you an OS to test with for QEMU and I can
some somewhere in IRC on in an email explain what modules need to be
enabled.
Simon Glass: Is it?
Ilias Apalodimas: I think someone added it on Debian. I haven't tested.
I fixed you. That's all I could do. Right. If this can follow up that
would be great. If they can't that's unfortunate.
Tom Rini: So I guess kind of the high level question is what is it we
are wanting to be testing here? And what I've long wanted and we do have
some ways of doing now is U-Boot able to start an OS successfully? And
for that, it's a much more on the one hand, it's a much simpler test
because we really just need to make sure that we get some known line out
of whatever OS kernel we're testing. It says, "Hey, I've gotten far
enough that the bootloader is likely not going to be an issue. We're not
trying to have an entire compliance suite run every time, especially
since runtime services are their own kind of special challenge." Kind of
the next part of the I know it would certainly be good for other labs to
do more intensive testing infrequently but still at a regular interval
but just kind of for every time CI you definitely also have to worry
about how long is that going to take and what value are we going to get
out of that too and then kind of the next set of challenge is also if
we're going to start including a distribution image and kernel. what's
it actually like to support hardware wise?  Because on one hand we have
two virtualized platforms. On the other hand everybody has their own
hardware lab and everyone is aware of the levels of pain involved with
hey is this particular board actually going to be functionally usable
with this particular distribution.
Simon Glass: I mean, my question was really just what can I put in CI?
and maybe if you could send an email about the problem you're talking
about because I don't really get it.  But, from my point of view, just
being able to boot and see welcome to Ubuntu or welcome to Alpine would
be good enough on the serial console.
Ilias Apalodimas: So the question is do we want to do it now?
Because I have one of my team members fixing exactly that adding the
modules in. Once this is merged you'll get a nightly build for Yocto
that works. Right. If that's good enough fine. If not, I can send an
email of what's needed and someone can enable it in Alpine or Ubuntu or
whatever and then we can test with that.  Right? But the whole point is
that from Yubot's point of view, we did exactly what ACPI does to solve
the problem. booting from a USB disc.
Simon Glass: But sorry, I actually don't understand the problem because
I have a test that boots. So, what is the problem you're talking about?
Ilias Apalodimas: [edit: Booting from USB is] fine, If you're booting
=66rom network or an ISO, that doesn't work because the ISO gets mounted
in RAM, gets abstracted as a disk, but once exit boot services is
called, that disc goes away. If it's a USB disc, Linux just rescans it
and happily continues, but the problem is that on a CI you can't expect
to, write the OS all the time or write a USB disc all the time. your
best course of action on a CI is to be able to boot everything from
DRAM.
Simon Glass: I see.
Ilias Apalodimas: And that's what this fixes.
Simon Glass: I was assuming we could just if it's in the Docker image,
just run QEMU with the ISO.
Ilias Apalodimas: That will work as well. Yeah.
Simon Glass: So, if we're okay with having it in the Docker image, that
was really what I was getting at, then I think I could just do that with
Alpine because if it's small enough. I mean,
Tom Rini: that's worth doing just because it gets down to the next
problem of okay, so we can run that on one image. if we're going to
include an image, we want to make sure it's as small as possible. We
want to make sure we can get something as widely usable as possible and
a network, if it's also loaded over the network, that's a lot easier to
deal with rather than, okay, now we also need to make sure we're passing
the right things to QEMU. That's one more little thing to configure.
That's what I was trying to get at with, hey, let's look at network
testing rather than hard coding passing some device to each QEMU
instance we're going to try and test this on.
Ilias Apalodimas: Simon, the network one is probably going to be even
easier than the disc one. It's literally a single command. So, I don't
mind.
Tom Rini: We're still going to have to include the image inside the
Docker image so that it's not something that we have to spend some
amount of time fetching every time we're running a test.  It's just a
file that already exists local to CI.
Simon Glass: But I mean, it sounds like you're already working on this,
Ilias. So, if that's all right, I might just do nothing and wait for you
to
Ilias Apalodimas: I was so by Simon. I don't mind. If you want to do it,
I can help. I'll wait until the ARM 64 image is fixed and I'm probably
going to plug that in or maybe not me someone from my
Simon Glass: Yeah. Yeah. let's just do that. I'm in no rush. I was just
thinking, what to do. I've just logged into that ARM 64 machine to see
Tom Rini: Sounds good. Thank you both.
[edit: Simon and Ilias now start talking about the U-Boot running on
aarch64 host with the -kvm flag to QEMU]
Ilias Apalodimas: I haven't found time to look at it. Sorry.
Simon Glass: if I could repeat that thing you were talking about. The hang
Ilias Apalodimas: It just hangs right and it just hangs only when you
have KVM enabled. I think it's something running out of memory in KVM
with blob list.
Simon Glass: Yeah. Yeah.
Ilias Apalodimas: I couldn't find time to look at it.
Simon Glass: I've got the bug, so might look at it at some point. I've
never tried running QEMU on an ARM 64 machine.
Ilias Apalodimas: Yeah, I ARM sent me a server I don't know four years
ago or something. Ampere sent me one. So it's easy for me to run that
stuff. I just have it locally and I just, SSH and run an instance.
Jesse T: By the way, it was actually the D10 standard, not D1 SOC. We
were using both boards for different things. So I also sent all the pkg
builds and on IRC I used pastebin. I don't know if I should have used
something else or
Tom Rini: Pastebin is fine. Thank you.

And that was the end of the meeting.

--=20
Tom

--czJKpCRHE0ZH3xGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg2E9QACgkQFHw5/5Y0
tyyvBQwAkwlX6ce2MM4oM1FOMdsGQ4Kq3UGMkU3xRAAMt8Ss3pjJV1sbgkrQ4u4m
0mz+TyZCwtPGspOqGtHkUDKYTp1eNZvWLbWM0dK04Qsif4oUjFcmgOQufV6WKKRU
JwbFMy2Cvu+aOYjVky2ESwBXO4pywuTh1QeaHlQb9MHAhuuv+wIyiaIOyznL78gP
puBeEpwiCTVB5zQRjYS7XTqH4sCPbs6ehU5KMi3K3UG5NaTZq3VkXDxbOyc/p2/d
UHe2YtdEGMmQGtBVWkWgxbwl/gTD9dIm00jdBjR+X5zvYEiap8z96cbrYkIMgd5B
YRUxX+g4G/1kNo3VFwL+XxpCNG4bDx65neOse3tJC5eYaRQx8E2uA9iz94Iun7US
td9v/YkBkJYkC2kLHcNBnk7XE1VH3CgyMKujpbsltjuLwiOkmoKRC3YxCqh3mFFf
d6CGXkyjyAkd/XNoAJWAchWXveUVG80rs9j1bI1mHyth5HO3IPB1wV6XV9dNvc5z
hJasSXSg
=Bghg
-----END PGP SIGNATURE-----

--czJKpCRHE0ZH3xGl--
