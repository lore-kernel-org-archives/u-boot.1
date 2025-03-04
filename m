Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64174C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36F4812D8;
	Tue,  4 Mar 2025 16:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jfFWncUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2101081430; Tue,  4 Mar 2025 16:35:45 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24FB4812D8
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac0cc83e9adso392626966b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102541; x=1741707341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kRNRJKehp5tXxhz5M6VKRhNVuavAjAHntKzQ+4Vy72c=;
 b=jfFWncUK63QMh/iVmaZEnrYRuw4aj5K8GrBN8+kh5UsMmagbfoxQUn1zTDog+hvwCx
 1C6yysEA6ffdR0qMobBDA8TKlxwB8Qn1VnXw1dN3fNSOpkcCJ7QY79VDD/UPduRCAkgg
 q/BcEh2a1GoM4Tz1jMkFWNlu06X80e9TaG3xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102541; x=1741707341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kRNRJKehp5tXxhz5M6VKRhNVuavAjAHntKzQ+4Vy72c=;
 b=rx8A2jhJlyV89gQpBpQGkmwZ5ZWZrBsRCHxBkzmROrUR3qxRtob4Ndl0kckJQWBYm9
 6qYxnrYmJi0ZreKStCZ4bs9jdnN93I/wIwXEQM/TutARymk+XyaZdX0CUmqwjX6T/NXy
 GiRJrQWaHSahXfBmWHvaZcZCIfT6P65Ne0/YqDHMDtPoEVvOY3QKrI7ws8vFXhHLuhzz
 yjlzI39BA2D0+8zr5WE0MNZEVgA/f55oDHq/IPjFBjQEfqAo/SzRh5tDc7GalR0GSbg4
 2gtIcJaXjaqFtHbhPv2wTN/+0sE9LMfk3BHbwiubGN74IZykr2FhlCniy+vhkQpKqpey
 Shzw==
X-Gm-Message-State: AOJu0YynSACcal4476Hzzk6DTFf2uWP8yoSPcDsTOIgiRFRizqGlBI/S
 eBYgQtqTqg921trNkgubInDc1jgvVmLyLz+0q3OHH+ZCjE+xE57m0D4gAgdJTEBSqg9QZySmTgc
 QHjTDfHOtNL1Gg/QFK4BQWVQB4duZsDqAxZfP
X-Gm-Gg: ASbGnctkf49FUVhYECLjN9KXqBzf8cmSYpqhGUdz0M1jDPJnLV/+nKXK0dLca5+Ho1X
 gSrF8ejeFeSeIKGR8SPgvQEaWxpbxTNsyDlABlQzAP35oTroLaBkqGqP4M3rVmqV7zPmatxQ29W
 4pK3kIgdFyVMt+BYJb4893t1s/XT8=
X-Google-Smtp-Source: AGHT+IGQxhVx6GYyW2cRVpmeW5v75Xod2yq4P/fkmzPGKxXjqWNQZ1JcqpVtSca3V3Y8qElEe8qYhacoUCHuuPvEfnA=
X-Received: by 2002:a17:907:3daa:b0:abf:641a:571e with SMTP id
 a640c23a62f3a-ac1f133a41emr392378766b.30.1741102541368; Tue, 04 Mar 2025
 07:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
 <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
 <20250225215100.GC2640854@bill-the-cat>
 <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
 <20250226145255.GJ2640854@bill-the-cat>
 <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
 <20250227171753.GG2640854@bill-the-cat>
 <CAFLszTg1A0HiaqVPxY3utpztOw6QFNQGZwPgtN9tZBN+3E9TiQ@mail.gmail.com>
 <20250227203017.GK2640854@bill-the-cat>
In-Reply-To: <20250227203017.GK2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:35:29 -0700
X-Gm-Features: AQ5f1Jr8gXiqYc0O_D92xPJX0Ui_WXqnhvbjUjfD0yzNahdaH1V3lJSXmhLex5I
Message-ID: <CAFLszTgA9G8pueG5w6Vjq8Qg3Qqwivs=9J2ZiuBk2dv+tr1pOg@mail.gmail.com>
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 27 Feb 2025 at 13:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 27, 2025 at 12:32:42PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Feb 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 09:24:45AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 26 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 25, 2025 at 07:51:07PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > > > > > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > > > > > > > > > > > > > > > > > > > > look at it, and refrain from otherwise assuming how it solves the
> > > > > > > > > > > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I pushed an updated version to dm/splg-working but it is not very
> > > > > > > > > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > > > > > > > changes, here's another example of the problem with your approach. What
> > > > > > > > > > > > > > > > > > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > > > > > > > > > > > > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> > > > > > > > > > > > > > > > > > > since I always use O=, rm -rf) is needed for changes there to be picked
> > > > > > > > > > > > > > > > > > > up, but that's maybe just a missing Makefile dependency line. But that
> > > > > > > > > > > > > > > > > > > just makes it easier to see the next problem, which I don't see the
> > > > > > > > > > > > > > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > >   203 |         plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > >   205 |         plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > > > > > > > >       |                          ^
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > And I don't see, really, what's even getting us down this error path.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> > > > > > > > > > > > > > > > > > across all phases.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I pushed a new tree which builds without the warning. Note that
> > > > > > > > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
> > > > > > > > > > > > > > > > > scripts/conf_nospl is going to be a problem in and of itself, and likely
> > > > > > > > > > > > > > > > > as confusing if not more-so than any of the in-the-end visible changes.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, perhaps the key point I've been trying to get across is this confusion.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > As you know, at present we have two types of options:
> > > > > > > > > > > > > > > > a) those for which each phase has its own value
> > > > > > > > > > > > > > > > b) those for which there is a single value shared across all phases
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The only way today that you can tell them apart is by looking for uses
> > > > > > > > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Partially agreed. Those are strong indicators that both CONFIG_FOO and
> > > > > > > > > > > > > > > CONFIG_SPL_FOO exist, but not always. We have, intentionally, both the
> > > > > > > > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR does
> > > > > > > > > > > > > > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the future,
> > > > > > > > > > > > > > > but not yet).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > OK
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > then the option is a) otherwise it is b). There is no way to tell from
> > > > > > > > > > > > > > > > Kconfig.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a linter
> > > > > > > > > > > > > > > would be a handy thing to have. But you're mentioning this in another
> > > > > > > > > > > > > > > context, why we need some additional knowledge somewhere.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > What I meant was that we don't have anything in the Kconfig for FOO
> > > > > > > > > > > > > > that says this is a global option or an xPL-specific one. We have to
> > > > > > > > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > > > > > > > > > > > > > > an option, some may use IS_ENABLED() for that same option. Some may
> > > > > > > > > > > > > > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm sure you can find some examples where we have CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not a
> > > > > > > > > > > > > > > big deal, and should be fixed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But this is largely the point of my series. It's the reason why
> > > > > > > > > > > > > > qconfig is able to locate these cases and warn about them. It is a big
> > > > > > > > > > > > > > deal, IMO, or at least big enough for me to attempt this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm only going to rant slightly that checkpatch.pl telling people to use
> > > > > > > > > > > > > > > these macros has made the situation worse, not better, out of an
> > > > > > > > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And what you're missing is that sometimes we intentionally don't want
> > > > > > > > > > > > > > > $(PHASE_), or would need to rewrite the Makefile to make use of it.
> > > > > > > > > > > > > > > fs/Makefile is an example of this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The next step from my side would be to get rid of the 'ifdef
> > > > > > > > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Stepping back a bit, perhaps the goal of my series is to identify
> > > > > > > > > > > > > > > > options in b) so we can deal with them in a better way. They are all
> > > > > > > > > > > > > > > > listed in conf_nospl, in preparation for some future action.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > There are two big problems here. The first of which is that conf_nospl,
> > > > > > > > > > > > > > > as a concept, is going to be incomplete. Do you list every CMD in there?
> > > > > > > > > > > > > > > Why? They'll never be in a non-PPL phase. It will be its own nightmare
> > > > > > > > > > > > > > > to keep correct, once it is bug-compatible with what we have today.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This is actually the *nice* thing about conf_nospl. We should reduce
> > > > > > > > > > > > > > it to empty, just like we did with the Kconfig whitelist.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We have this rule:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > libs-$(CONFIG_CMDLINE) += cmd/
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > which is enough for most things. The only issue is that sometimes,
> > > > > > > > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So I don't agree at all that my series is a 'big problem'. It is a
> > > > > > > > > > > > > > solution to the current confusion and it shows up what is broken and
> > > > > > > > > > > > > > needs to be fixed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The second big problem is that it doesn't make it any easier to solve
> > > > > > > > > > > > > > > what I keep calling the DWC3 problem. It's a valid use case that two
> > > > > > > > > > > > > > > developers have hit independently of wanting to enable USB gadget
> > > > > > > > > > > > > > > support (and the HW uses DWC3) in SPL and not PPL. Not only are you not
> > > > > > > > > > > > > > > solving this problem, it gets worse to solve. Today it's "OK, I need to
> > > > > > > > > > > > > > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > > > > > > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_FOO)
> > > > > > > > > > > > > > > working here but not there?".
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Is that because some Makefile higher in the hierarchy is not building
> > > > > > > > > > > > > > that subdir? I don't know what this is about.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > To me, at absolute best case here, we're making a lot of changes and
> > > > > > > > > > > > > > > spending a lot of time to not really address the underlying problems,
> > > > > > > > > > > > > > > just making some questionable value visibility changes. We could reduce
> > > > > > > > > > > > > > > ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where it
> > > > > > > > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Or we could finish and apply my series, which does this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminates the
> > > > > > > > > > > > > > > which to use of those question.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Again, let's apply my series, which actually gets rid of PHASE_, SPL_
> > > > > > > > > > > > > > and XPL_ altogether.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And update / expand upon the existing
> > > > > > > > > > > > > > > documentation we have as it's not clear enough for everyone. Then we can
> > > > > > > > > > > > > > > think, again, about how to solve the problems that are introduced by
> > > > > > > > > > > > > > > building our entire source tree N times from a single configuration
> > > > > > > > > > > > > > > file. Or if we need to do something radical there.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > At this point I'm getting the feeling that you imagine my series is
> > > > > > > > > > > > > > some grand unified plan for Kconfig. It really isn't and this thread
> > > > > > > > > > > > > > is reminding me of why I originally wrote it. Bear in mind it was over
> > > > > > > > > > > > > > two years ago and I have mostly forgotten all the issues. It is a
> > > > > > > > > > > > > > clean-up series. It isn't the second coming but it isn't the
> > > > > > > > > > > > > > antichrist either.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I worry you're going to spend another month of effort to get this to 1:1
> > > > > > > > > > > > > compatibility (modulo fixing bugs) with what we have today and get
> > > > > > > > > > > > > disappointed once it rolls out to -next. But I guess I've already spent
> > > > > > > > > > > > > too much time trying to convince you this is a bad idea and that your
> > > > > > > > > > > > > cure is worse than the disease.
> > > > > > > > > > > >
> > > > > > > > > > > > To me the core issue is whether to completely split the defconfig
> > > > > > > > > > > > files. I am quite worried about that. You are quite worried about the
> > > > > > > > > > > > confusion my series will cause.
> > > > > > > > > > > >
> > > > > > > > > > > > I think it is reasonable, if we go with my series, that I drive
> > > > > > > > > > > > conf_nospl down to zero lines (and remove the feature) before going
> > > > > > > > > > > > any further. Would that make you more comfortable? It would be a fair
> > > > > > > > > > > > bit of work, but could be done over a few releases.
> > > > > > > > > > >
> > > > > > > > > > > Here is my core concern. Can macros be tricky? Yes. Do we need a
> > > > > > > > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the real problem is
> > > > > > > > > > > bugs like:
> > > > > > > > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > > > > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_USB_GADGET
> > > > > > > > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > > > > > > > >
> > > > > > > > > > > Your proposal neither fixes that bug nor makes it easier to understand
> > > > > > > > > > > why that bug happens. And this is the category of build problems that we
> > > > > > > > > > > get that aren't "you missed using the right macro".
> > > > > > > > > >
> > > > > > > > > > Honestly, what on earth does this have to do with my series?
> > > > > > > > >
> > > > > > > > > It's that your series doesn't address the real problems we keep having.
> > > > > > > > >
> > > > > > > > > > The problem happens before and after my series, from what I can tell.
> > > > > > > > >
> > > > > > > > > Yes, I've said that numerous times.
> > > > > > > > >
> > > > > > > > > > If you want these sorts of combinations to be tested, perhaps add a
> > > > > > > > > > board that enables them, or even rethink your opposition to my
> > > > > > > > > > buildman proposal?[4]
> > > > > > > > >
> > > > > > > > > This isn't relevant to the point I've raised several times now. The
> > > > > > > > > failure mode above was reported by two different developers, neither of
> > > > > > > > > whom saw how to correctly solve the problem.
> > > > > > > >
> > > > > > > > That surprises me a little, as the problem seems pretty fundamental.
> > > > > > > > If you don't enable USB_GADGET, then symbols which depend on it don't
> > > > > > > > exist.
> > > > > > >
> > > > > > > But they don't want USB_GADGET in PPL. They only want it in SPL.
> > > > > >
> > > > > > That seems to be splitting hairs, but OK. So why not make
> > > > > > USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_GADGET ?
> > > > >
> > > > > Yes, the solution today involves reworking drivers/usb/gadget/Kconfig so
> > > > > that USB_GADGET_MANUFACTURER, USB_GADGET_VENDOR_NUM,
> > > > > USB_GADGET_PRODUCT_NUM, USB_GADGET_VBUS_DRAW and that might be it, are
> > > > > exposed to USB_GADGET || SPL_USB_GADGET and possibly down the line
> > > > > VPL_USB_GADGET.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER as surely it
> > > > > > would be the same value? This is once good thing about what we have:
> > > > > > we can share values between phases without typing them in separately.
> > > > >
> > > > > Most of these should be, there may or may not be the questionable case
> > > > > where one of the ID changes so the host knows what stage things are at.
> > > > > But that's just an aside.
> > > > >
> > > > > My point is that drivers/usb/gadget/Kconfig is yet another case where we
> > > > > need to make it much more complicated so that it works for all the use
> > > > > cases. And that it's a more common and harder for developers to fix
> > > > > problem than "Do I use $(SPL_TPL_) I mean $(PHASE_) or $(XPL_) in the
> > > > > Makefile?"
> > > >
> > > > Yes, I understand that, but this is a tradeoff between that complexity
> > > > and the one we would introduce by splitting the defconfigs. Given all
> > > > the Kconfig churn it would require just to get things to work, it
> > > > isn't a clear win, to say the least.
> > >
> > > Since we would be removing stuff from Kconfig with the larger idea I
> > > proposed, I'm not sure what you mean. We wouldn't have this problem at
> > > all with the larger idea.
> >
> > But we have other problems, mainly that we cannot easily use an option
> > from one phase in another, so need to duplicate all such options, then
> > add tooling to try to keep them in sync, except when we don't want
> > them in sync, etc. Are you sure you have thought this through all the
> > way?
>
> Yes, I have. Because rarely are there cases where we *need* to share a
> value from multiple phases *and* we can't have the default be correct.

You're likely right about this, but I can imagine it being quite
painful for the cases where we do need something. We could have some
kconfig tooling which prints a list of those cases, perhaps.

>
> > > > > > > > > And again, if you tried to solve this problem on your series you might
> > > > > > > > > see how what you're proposing will make things worse, not better.
> > > > > > > >
> > > > > > > > At least with my scheme you can do something like this:
> > > > > > > >
> > > > > > > > config SPL_USB_GADGET
> > > > > > > >    bool "USB Gadget Support in SPL"
> > > > > > > >    depends on USB_GADGET
> > > > > > >
> > > > > > > That symbol already exists. The problems are around all of the gadget
> > > > > > > symbols that don't exist.
> > > > > >
> > > > > > OK. But we have to move in steps. We can't do everything at once.
> > > > >
> > > > > Yes, which is why we have so many of these duplicative symbols
> > > > > (USB_GADGET, SPL_USB_GADGET) and keep needing to add more.
> > > >
> > > > Yes, I don't like it either. I believe that if I had been able to land
> > > > my solution last time, we would be having different discussions by
> > > > now, e.g. how to tidy up the Kconfig without changing the build
> > > > system.
> > >
> > > I strongly doubt it.
> >
> > I know you do, but I could be right about this.
>
> You could. But you could also be very wrong. And the struggle I've had
> with showing you problems other developers have has not left me feeling
> great. But I've still said I'll take this but need you to commit to
> following up with bug reports.

I'm happy to follow up with bug reports.

>
> > > > > > > > I normally make the SPL symbols depend on PPL, since it normally
> > > > > > > > doesn't make a lot of sense to have the feature in SPL unless it is in
> > > > > > > > PPL. Is this an exception to that rule?
> > > > > > >
> > > > > > > This half of the problem (you're still missing the other half of the
> > > > > > > problem, the DWC3 code being built in TPL now and throwing
> > > > > > > warnings-turned-error with -Werror and then discarded at link time) is
> > > > > > > one of many examples where we keep having to duplicate symbols in
> > > > > > > Kconfig.
> > > > > >
> > > > > > >
> > > > > > > > If we do go ahead and enhance Kconfig, then we can combine the two
> > > > > > > > symbols, which is something.
> > > > > > >
> > > > > > > Or, we go the direction I suggested instead. Where we never duplicate
> > > > > > > symbols, because we never need to anymore.
> > > > > > >
> > > > > > > Or, we step back because believe you're missing the bigger problems.
> > > > > >
> > > > > > At this point I'm not sure where to go. You are determined to split
> > > > > > the defconfig files and have grace concerns about my schema. Vice
> > > > > > versa for me.
> > > > > >
> > > > > > But my scheme takes us forward without needing to split the
> > > > > > defconfigs. It does offer some benefits IMO. Once we split the
> > > > > > defconfigs we can never put them back together.
> > > > >
> > > > > My continued strongest preference is to do the minimal effort to better
> > > > > document what we are doing today and add the missing tooling so we don't
> > > > > keep getting wrong macros in the code.
> > > >
> > > > I did actually do the tooling in qconfig - give it a try and see what
> > > > you think. For documentation, we can discuss that as part of myt
> > > > series.
> > >
> > > The missing tooling is things like:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250226153346.2736160-1-trini@konsulko.com/
> >
> > Well that's good to have anyway.
> >
> > >
> > > I'm not sure what qconfig features you're talking about.
> >
> > It is qconfig --scan-source which prints a lot of warnings.
>
> I'm not sure I saw what that was for when it went in. But I'm not sure
> how useful that is either. The first section shows some dead code to
> remove, which is good. It complains about cases of CONFIG_$(PHASE_)FOO
> being used as future-proofing which is not good. And it caught none of
> the errors like:
> https://patchwork.ozlabs.org/project/uboot/patch/20250226203123.3831960-1-trini@konsulko.com/
>
> And I'm not sure "CONFIG options used as Proper but without a non-xPL_
> variant" is a valid variant at all. I'm sure you've found it useful but
> I'm not sure it's something I would suggest people run normally.

The tool identifies problems which cause build errors (or changes in
the effective value of Kconfig options).

>
> > > > > If you're hellbent on doing this
> > > > > and do it against master and not your personal tree, I'm expecting you
> > > > > to be available to help clarify problems for developers if they report
> > > > > them.
> > > >
> > > > That's fine. I do my development on my own tree, but once I actually
> > > > do the series and it is reviewed, I can do a version against -next. As
> > > > you know, there are a lot of moving parts, so I would want it to go in
> > > > quickly to avoid a lot of rework.
> > >
> > > Just don't post things that aren't against next, when you have something
> > > as that makes review impossible for the rest of us.
> >
> > I had thought we agreed that to minimise differences you would review
> > patches that I sent from my tree?
>
> I said that back when I thought you would default to posting against
> the relevant upstream branch and not developer further against your own
> tree.

That's not what I intended you to think. We should look to find some
way to do this via pull requests.

>
> > Anyway I'm going to do what you suggest and see how it goes.
>
> Thanks.

Regards,
SImon
