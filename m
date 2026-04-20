Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B774F5A8D1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 23:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECA2841C8;
	Tue, 21 Apr 2026 01:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PfvbANvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D5B8422D; Tue, 21 Apr 2026 01:12:42 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE0184198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 01:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd689829eso302031a34.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776726759; cv=none;
 d=google.com; s=arc-20240605;
 b=GRhCoIYaltp7v8OdtrO8Ech0FLv08MLFPLoympbano4e0OPISxLlGRayLCDhzPAcfv
 6+YmD/9XyTcsxvF5mq3CMi6t4HRdyz3Jp4LZ/swOfBDyLBtrLxXkH4EMd+CkS48n+k4R
 h0tmgY65MpjnQtgOSLJCmoISccwo1Cg99DRMzyPTeGkQAf+WEOyA/CvcdNf8v1AffavF
 r9x9xo/yymOFmSHzwb2aTOUFnNUv4/krgXo3zMJ6peQzK6TmccaABYUsGiFAnMon07/8
 h7oEoYAYWNxOUGcD7C7lz2HYk/5Q43d6bS8w+woNn8aPwocdBEVBYrzpQEghJwk2EpR4
 4ETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wr0D/hS+t7K216CMIBiFE+Onq/MZD3BFS4jUzL5BkIM=;
 fh=9r7S9p3VRn7IEaRdmSc0Ybs7HmGN7dtMxEobdXEs+bg=;
 b=SbP+eW0uDUKvuGpMGdJ1lWZo3pbGcPonz1jNrxZXiHUVuMfh3yNrt5QWCmjPGfqz4f
 zTzji0ySRTYUjtptYuuVWfjR03qPgXPSkHWLBLKiMKHjvR4nclimgaBAygkehtKm00iL
 cUPqbkeAEVOq33ubYnWRoAk2C4TPDbjrOyG8wIuIYAwqlSWUQM5jkCFxdgkUkkS8j3p4
 ytMORicptK/F1dVyOcqfOwj05k4+lINqAMOJnGFd+92plM1HZHONEwKql9AzNGTRkiPL
 BKS3r45zcuEaX51cmqb8dbONrfV0kv9iZaMkehFmh2vwcKqwpqgb17X2AsFW1qKaDw8f
 Bfbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776726759; x=1777331559; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wr0D/hS+t7K216CMIBiFE+Onq/MZD3BFS4jUzL5BkIM=;
 b=PfvbANvwdUULTDbouCW3h6v59Pio18RTVdgq6GhViuvP8YFGqTm9a2ojoRm1+kGJfq
 qfAww8QYgophOMP5+uV2c5bN4s23OsyC3Y4gEtvsUxWcRr8IZX6AY1TUe5hNMh36V96f
 iX5f9DrQA4hYCdoMlXvcSxR2BWv3b7+fMB1nwIqp4tIyKOE/p5cEs3A3K5cdsgSiU3/P
 MR+UW+2VPJ5WWDmJ+1+Rc4/ckzuhYGQwyd+A4nZX1Rr2roZfUx2DLTqFwuGV+++rat08
 tZmbooLZ7FbL9H2w3MI35yymR8XsZ+6lisKtX6N0latmS6iI1Wt3XJ0k24yxXN4hy+5E
 f4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776726759; x=1777331559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wr0D/hS+t7K216CMIBiFE+Onq/MZD3BFS4jUzL5BkIM=;
 b=AHFHBpzdu8jkZ/z8U9rCgeadGbImbHa1rXBBmK+5038MyIf02/+diTeW79xa/ZkqN/
 c3CsJuE22eaEeDG2uWamCfaWGk8HmoszZuKB7pjGzl7y9YBAKLlWTXFPK+cAbzjn158A
 uyrBzCWnDmWNYO+5xxrlqWqScCIUEfykxB+mFNqEy921G2Wb/3nX39bm5vv/2AYZsWUm
 P1gVWFsBp9WLHUypY9qHMfqzszx1fp6kpzShs0Y2yYL63vuPMArP5WqK04WS5gi16sNw
 5ohDTEBSEBOWgSlzG5UEdinyDThzs1CciNihCWDzQEca4XpoBEntNjghyNZCT6Um2Tom
 yVJQ==
X-Gm-Message-State: AOJu0Yx34BvmLWgL/lnPcH54/3H1Spgwf5gS0Slv5D/Co5Q7hvrdadhm
 mQi6DqUy4ddDOBwp9kHejVRSM0CJ49+xQXcjFxLPKXNTzMlMgTUg3/8Jv621e2h1jJsK0y2aSDY
 VeIOXODYmEXaz2Qj/tvm5gFkG/V4A+PY=
X-Gm-Gg: AeBDieuOwl3X5S+W30/Smm88icWiCadH4K0dKXEmAfqATZ2dVSy3SnfwooQL8GIYuu/
 GihzojFMH70Un1y9p/tIZtR1OFwJ9m8VA7gjsxADSQSGahdL0TILDDGXBTk0hIoT3F/Jl0U5N5B
 mdAF3oC3YK7IPRjvlDGN0jqGFH5lhdm4W8vBACtLPnVJugBydEUopcds8qJ7gBTNFA3qDOKKool
 rCrpct+aGpp2xax326SdodDs30uPJf/xdy4EV426ZYMIJAO/frmRnZlhFhdxdLGn3f0kOZhTZcd
 kiLksznZ2gB7+JYksHao1Cvks0z/
X-Received: by 2002:a05:6830:2815:b0:7d7:cc49:9ad6 with SMTP id
 46e09a7af769-7dc9521ca77mr10311779a34.22.1776726759387; Mon, 20 Apr 2026
 16:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074601.24988-1-briansune@gmail.com>
 <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
In-Reply-To: <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 21 Apr 2026 07:12:27 +0800
X-Gm-Features: AQROBzBRHLAo1WyxvvVb_x45QDn1GJRIR1sSIG-9IFwZlT-hMVKr7oq30lDCyFw
Message-ID: <CAN7C2SCpBYi=c1kS7-aXL9Qf7wUq_ipcvQMSUSW9aYrQqUcAAg@mail.gmail.com>
Subject: Re: [PATCH v3] Improve handosff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, Apr 21, 2026 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Brian,
>
> On 2026-04-20T07:46:01, Brian Sune <briansune@gmail.com> wrote:
> > Improve handosff prepare on SoCFPGA
> >
> > There are some cases that the Python scripts
> > are run and the qts files are not replaced.
> > Make sure qts folder h files are removed before
> > handoff script runs.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> >
> > arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
>
> Typo in commit message: "handosff" should be "handoff".
>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
> > +HANDOFF_KEEP ?=3D 0
>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > +             if [ -n "$$HANDOFF_KEEP" ]; then \
>
> HANDOFF_KEEP defaults to "0", so -n "0" is always true. I suspect you wan=
t:
>
>     if [ "$$HANDOFF_KEEP" !=3D "0" ]; then \

Hi Simon,

I think this is a misunderstanding.
My original idea is to use the HANDOFF_KEEP=3D(whatever is mistyped)
to run the keep branch.

While the absence of HANDOFF_KEEP(anything) will not keep.
But simply HANDOFF_KEEP will not work and need HANDOFF_KEEP=3Dxxx.

Because the command >
"make prepare HANDOFF_KEEP=3Dxxx" is very distinctly long
HANDOFF_KEEP=3Dxxx so it must keep my thingy.
Even if I mistyped =3D0 etc.

And during the absence of HANDOFF_KEEP=3Dxxxx
"make prepare " immediately, see ok clean so it will not keep good.

That's my original thought.
I think I should changed to:
if [ -n "$${HANDOFF_KEEP+x}" ]; then \


Need your comments on this.

Thanks,
Brian

>
> Otherwise the 'preserve' path is always taken and the 'clean' path is dea=
d code.
>
> You could also have an empty variable meaning don't keep.
>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > +             trap 'rm -rf "$$TEMP_DIR"' EXIT;
>
> The trap is set after TEMP_DIR has already been used. If the python
> script or mv fails partway through, the temporary directory won't be
> cleaned up. You could move the trap to immediately after mktemp
>
> Regards,
> Simon
