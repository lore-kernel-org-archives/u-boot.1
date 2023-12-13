Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575FAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 21:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9684878B7;
	Wed, 13 Dec 2023 22:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="pc3QnaXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EE587880; Wed, 13 Dec 2023 22:00:43 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B97878B7
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 22:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a90b0ae8-99fa-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a90b0ae8-99fa-11ee-91e7-005056994fde;
 Wed, 13 Dec 2023 22:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=/kwpCwXIvI24I6ir6VJT2uOWiiU5t0LwyDXeifhGX+I=;
 b=pc3QnaXmQsRSCc/dCBpqw0yABD8okHQw4RUIuYp3fxIPKQojG1DOZ5aYg+bGQ7sM7mm1yNh0SuDOy
 0lyeY1zsu76xxgq/WEBEBFphA6u/EEFz1AC3Pp/LJygPJwA/YmIhZ5/z3IrIOMAyacSkuaH+y8w7ad
 jFFRhMX+Bz7ijcvPNS6W4dv5rEtAa+vRtKbytcqZ//QHhGWTZhEwW62VO0IGrevYSt5jgyHScDNtMl
 i3XxO2J6vNHUqGLrD0hIStbl5VWHr1hpRMmbk2q2GFNH/xwotACIymYoOQC/fUO3fpdi5pDAnyajbm
 6aN5mJyRRppq/Roz8f4kLOvfz98c/hA==
X-KPN-MID: 33|KYHi0bGRzDTkToC+WnYFJ9aPX2bUXrnHNloFbu6o9SFLO25mncS7DdusxBSeVGf
 8VHP52yyaalOVK2nelHJhG8ZQxk8J0Fbndj9rW/DMlyA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|auxhqopRA4sSCXJvFzZifrITU5KA0Kyh3qaf9OK+bRKnSkrk3ME/0Cu78AytYtH
 omypJFgg69rFhAmK02C1cWg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ab3051d9-99fa-11ee-ad2d-005056998788;
 Wed, 13 Dec 2023 22:00:39 +0100 (CET)
Date: Wed, 13 Dec 2023 22:00:38 +0100
Message-Id: <87y1dx6cnd.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, pbrobinson@gmail.com,
 u-boot@lists.denx.de
In-Reply-To: <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
 (message from Simon Glass on Wed, 13 Dec 2023 13:41:05 -0700)
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
 <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
 <20231213201909.GG2513409@bill-the-cat>
 <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Wed, 13 Dec 2023 13:41:05 -0700
> 
> Hi Tom,
> 
> On Wed, 13 Dec 2023 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:50:03PM -0700, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Mon, 11 Dec 2023 at 00:49, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Sat, 9 Dec 2023 at 20:49, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > >> > Changes since v1:
> > > > > > > >> > - Tokenize the DT node entry and use the appropriate value instead of
> > > > > > > >> >   the entire string
> > > > > > > >> > - Removed Peters tested/reviewed-by tags due to the above
> > > > > > > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > > > > > > >> >
> > > > > > > >>
> > > > > > > >> Can this be put behind a Kconfig? It adds quite a bit of code which
> > > > > > > >> punishes those boards which do the right thing.
> > > > > > > >
> > > > > > > >
> > > > > > > > Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
> > > > > > > >
> > > > > > > >>
> > > > > > > >> > +
> > > > > > > >> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
> > > > > > > >>
> > > > > > > >> Could this use ofnode_read_string_index() ?
> > > > > > > >
> > > > > > > >
> > > > > > > > Maybe, I'll have a look and change it if that works
> > > > > >
> > > > > > Unless I am missing something this doesn't work.
> > > > > > This is designed to return a string index from a DT property that's defined as
> > > > > > foo_property = "value1", "value2" isn't it?
> > > > > >
> > > > > > The code above is trying to read an existing property (e.g compatible)
> > > > > > and get the string after the comma delimiter.
> > > > > > Perhaps I should add this in drivers/core/ofnode.c instead?
> > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > >>
> > > > > > > >> Any chance of a test for this code?
> > > > > > > >
> > > > > > > >
> > > > > > > > Sure, but any suggestions on where to add the test?
> > > > > > > > SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?
> > > > > > >
> > > > > > > They are written on startup, right? They should certainly be in place
> > > > > > > before U-Boot enters the command line.
> > > > > >
> > > > > > Not always.  I am not sure if x86 does that, but on the rest of the
> > > > > > architectures, they are only initialized when the efi smbios code
> > > > > > runs. Wasn't this something you were trying to change?
> > > > >
> > > > > One of those things I keep repeating is that we don't know for sure what
> > > > > the right values here are until we load the DT the OS _will_ use. It's
> > > > > quite valid to start U-Boot and pass it a generic "good enough" DT at
> > > > > run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
> > > > > what the real DT to load before passing to the OS is. Since U-Boot
> > > > > doesn't need SMBIOS tables itself, we should make these "late" not
> > > > > "early".
> > > >
> > > > Fair enough, we can defer the init and testing of those late, just
> > > > before we are about to boot. But this is irrelevant to what this patch
> > > > does, can we get the fallback mechanism in first, assuming everyone is
> > > > ok with the patch now?
> > > >
> > >
> > > I would like this behind a Kconfig. Making it the default means people
> > > are going to start relying on (in user space) and then discover later
> > > that it is wrong.
> >
> > What do you mean wrong, exactly?
> 
> "raspberrypi" instead of "Raspberry Pi", for example, or "friendlyarm"
> instead of "FriendlyElec"

Heh, well, even in the x86 world vendors can't even spell their own
name consistently.

> I just wonder what this information is actually used for. If it is
> just for fun, that is fine, but I believe some tools do use dmidecode,
> at which point it needs to be accurate and should not change later,
> e.g. when someone decides to actually add the info.

So the Linux kernel uses this information to apply quirks for specific
machines.  But I hope that on platforms that have a device tree folks
will just use the board compatible string for that purpose.

Otherwise I think this information is mostly used to populate system
information UIs and asset databases.
