Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A0CEFC37
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 17:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1382B88C63;
	Tue,  8 Oct 2024 19:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="drZX40uG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4472588B1F; Tue,  8 Oct 2024 19:20:42 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308E388DE9
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 19:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0AC4B203A3;
 Tue,  8 Oct 2024 19:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1728408039;
 bh=NjtPXrJ8UCOOay0G2R0JTNAknjDB4D4i1MiRVPDtnyY=; h=From:To:Subject;
 b=drZX40uGx0Jj+wUSQ0K3GL6EMxHmQeTPT9QypgAVTSbOgmB4nhMRZYx5+il4M8gUY
 0jbvbu6O/+yf/LiRlXK1VyGspAohxYqr02lL1jd8X7sElVAnayje2K8YFxH9cCmRjb
 ITOX3dcR11Il2eQqxyZ13Jw4tIJ3SHhbizdF3dLFVtnboeUqGHloJcBaPoNukoefFB
 dv1CzhUYoWpQb2tLYOQXg8QC49qu/a8ZVfIxld6u3d7nQmraB0K4kv/dQtvuqPlF38
 SsqzC9WCE9PgWAw5jknfC0VHNufBPAkHXBD8+Ymbu8E/HvTg2hf/RxOBeDMxbRTh4X
 LFAI6cAMQet6Q==
Date: Tue, 8 Oct 2024 19:20:35 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Massimiliano Minella <massimiliano.minella@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Massimiliano Minella <massimiliano.minella@gmail.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2] cmd: setexpr: fix no matching string in gsub return
 empty value
Message-ID: <20241008172035.GA66965@francesco-nb>
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
 <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
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

+Tom

Hello Massimiliano,

On Tue, Sep 03, 2024 at 01:06:21PM +0200, Michal Simek wrote:
> HI,
> 
> čt 8. 2. 2024 v 16:00 odesílatel Massimiliano Minella
> <massimiliano.minella@gmail.com> napsal:
> >
> > From: Massimiliano Minella <massimiliano.minella@se.com>
> >
> > In gsub, when the destination string is empty, the string 't' is
> > provided and the regular expression doesn't match, then the final result
> > is an empty string.
> >
> > Example:
> >
> > => echo ${foo}
> >
> > => setenv foo
> > => setexpr foo gsub e a bar
> > => echo ${foo}
> >
> > =>
> >
> > The variable ${foo} should contain "bar" and the lack of match shouldn't
> > be considered an error.
> >
> > This patch fixes the erroneous behavior by removing the return
> > statement and breaking out of the loop in case of lack of match.
> >
> > Also add a test for the no match case.
> >
> > Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
> > ---
> > Changes in V2:
> >  - update documentation to describe the behavior
> >
> >  cmd/setexpr.c             |  9 ++++-----
> >  doc/usage/cmd/setexpr.rst |  1 +
> >  test/cmd/setexpr.c        | 10 ++++++++++
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/cmd/setexpr.c b/cmd/setexpr.c
> > index 233471f6cb..ab76824a32 100644
> > --- a/cmd/setexpr.c
> > +++ b/cmd/setexpr.c
> > @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
> >                 if (res == 0) {
> >                         if (loop == 0) {
> >                                 debug("%s: No match\n", data);
> > -                               return 1;
> 
> This patch actually changed the return value from command.
> In board/xilinx/zynqmp/zynqmp_kria.env we have
> 
> bootcmd=setenv model $board_name && if setexpr model gsub
> .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter*
> $k26_starter; then run som_cc_boot; else run som_mmc_boot; run
> som_cc_boot; fi
> 
> and this patch actually breaked it because we rely on return value.
> Changing return value is not described and I want to know if this
> patch should be fixed
> or we should update our commands to match new return value.

Massimilano, any comment on this?

This change broke also our use case - our board is no longer booting
with v2024.10 U-Boot. I do not think we should change something like
that without a clear reason and I was not able to understand it from the
commit message.

Francesco

