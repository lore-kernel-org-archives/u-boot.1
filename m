Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F88AD6555F
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 21:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BE18999F;
	Tue, 26 Nov 2024 22:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MAmIXaCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91F489C73; Tue, 26 Nov 2024 22:46:29 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 931DD8972A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 22:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ee9d50efaaso59177787b3.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732657586; x=1733262386; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRKtyW18geUlBWd0FV+bBIvb8dkV1BsBM9oM0VbHXE8=;
 b=MAmIXaCf5OP5yJTg2h4gBuO0R3jXJFGjga6VuH4hfbhdHJt7azkC6sZIy5TCH4Cx+E
 8dzsu5UqKk5xV7rt0jkEHgS8FXDQINFA0UXTF5xBDB/EsPj5iOYvrbv+qd+KszQDvi3+
 2b4sAfS0LVeNHq1o17R0AuvGrbn/nUVNM7ptx/a1HWKvH4ApNBcCX6u7HIattRuZb3mf
 CkLbFpxJpur87J5DnNk6cfjKkZMJLKe3fxwDUzdT82B34zoYA2FMjX9mGpdlliXtmPmf
 BsbDWTuiE12meoDKsR3inIYWcqomhyC1eHKcusDp34l96GiF9QEIABb7an/fyg7kyMtJ
 PnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732657586; x=1733262386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRKtyW18geUlBWd0FV+bBIvb8dkV1BsBM9oM0VbHXE8=;
 b=TsyIHL2MhSiALwVf2QkSPGuGXGHYio5p4+kXRlL5AIRShAZkrG9TTB6gQtohhF8ulv
 8PkeEE67BlzA8wpVxTY2l8YG/4bciYDNxmEuYnJwxlwc078M7NYqoenQR2d+P7UZgb6O
 L3+hMiYyRoGUC5T266ONXdio0/9pJ3X+dK5kzkYUTa9LCDH5+wMA3rPm6BUxbN8kgmty
 jl8YnTngSqVFxiX7akZjFmSHGMwCN+3mzFpx7bA0+uy6xKeJ/+4E+pkQMfriupXG0eTQ
 nwVf85Fq0cFL9DKBtC8T9JhDuaYUbP51DO9B/D8IyxU5ORzfrZ5ZzJiEvHHsrK2BK9fr
 RX1A==
X-Gm-Message-State: AOJu0Yxk69pkg7a9+rV65esxLY6CdPnHkFSE7ht9ZP88jmUe3AwKY68z
 8+F71RcMJ6G+4mSM96PHQOWNkhY8JJM04SqaCqAbHD7cFdvaBpRaa3H/dmGtHiLhFh3YD5cp/Un
 gpM0KFT6LTHj1w7wOI8j+Ba2NrBLjrLkC
X-Gm-Gg: ASbGncsTrhJrSSVobqIDgkzzYIZyKXwxUBPa0vgrgUCdWp60jzC4bR+Viv8eenJTb3C
 JSM4BfH1jH8IExfKHPNFkQ4J7WEXgsQ==
X-Google-Smtp-Source: AGHT+IFS6tvm4FuYG1IpjstlCTzT+U5z/AxjOxelALH6dmRPOEQxTLi9iVMneNIJvuTyyaLZkmzvpXypKz4ojvpM4E0=
X-Received: by 2002:a05:690c:7009:b0:6ea:edab:de1b with SMTP id
 00721157ae682-6ef371e7b67mr12826707b3.2.1732657586317; Tue, 26 Nov 2024
 13:46:26 -0800 (PST)
MIME-Version: 1.0
References: <CAFOYHZCwXSChH_rH251cUp-bgwai+e8xrOuqxepX9Dur2wGTJg@mail.gmail.com>
 <20241123024048.GK3600562@bill-the-cat>
 <CAFOYHZCuqSDWOUBGQ5_PAaLW229fwyk9vF47vC+rq_TW5J-qjg@mail.gmail.com>
In-Reply-To: <CAFOYHZCuqSDWOUBGQ5_PAaLW229fwyk9vF47vC+rq_TW5J-qjg@mail.gmail.com>
From: Chris Packham <judge.packham@gmail.com>
Date: Wed, 27 Nov 2024 10:46:14 +1300
Message-ID: <CAFOYHZDSw3_3t-AMF2M8DcoQ6XkcEjDCGpEiCJaQrB6MOgpnHw@mail.gmail.com>
Subject: Re: Odd error with cn9130, asix88179 and xhci
To: Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>
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

On Mon, Nov 25, 2024 at 1:09=E2=80=AFPM Chris Packham <judge.packham@gmail.=
com> wrote:
>
> On Sat, Nov 23, 2024 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Nov 20, 2024 at 11:29:43AM +1300, Chris Packham wrote:
> > > Hi U-Boot,
> > >
> > > We've hit a weird problem at $dayjob with a board using the Marvell
> > > CN9130 SoC and using the asix88179 USB-Eth adapter.
> > >
> > > The problem is after enabling and unrelated feature in u-boot the
> > > asix88179 fails to receive data (I can confirm that the link partner
> > > does see packets in the transmit direction)
> > >
> > > =3D> version
> > > U-Boot 2022.01 (Nov 08 2024 - 09:45:44 +0000)
> > > =3D> usb start
> > > starting USB...
> > > Bus usb3@500000: Register 2000120 NbrPorts 2
> > > Starting the controller
> > > USB XHCI 1.00
> > > scanning bus usb3@500000 for devices... 2 USB Device(s) found
> > >        scanning usb for storage devices... 0 Storage Device(s) found
> > > =3D> ping ${serverip}
> > > Waiting for Ethernet connection... unable to connect.
> > > Reset Ethernet Device
> > > Waiting for Ethernet connection... done.
> > > Using ax88179_eth device
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > > Rx: failed to receive: -5
> > >
> > > Abort
> > > ping failed; host 10.37.233.65 is not alive
> > > =3D> <INTERRUPT>
> > >
> > > Debugging a little we can see that the -EIO is actually because
> > > xhci_bulk_tx() hits a timeout from xhci_wait_for_event().
> > >
> > > We think this is triggered by the u-boot image size crossing some
> > > boundary (the problem seems to start when .bss_end crosses
> > > 0x00000000000f0000) although I've so far been unable to find
> > > specifically why that might be. As far as I can tell u-boot is being
> > > built relocatably and nothing is overlapping. I also considered that
> > > ATF might be preventing access to something but so far I see no
> > > evidence of this.
> > >
> > > If I turn off some features to reduce the build size the problem goes
> > > away. That is actually how we've avoided the immediate issue, althoug=
h
> > > that means the problem will likely come back and an inopportune time.
> > >
> > > Does anyone have any ideas as to what the true root cause might be?
> > > I'm a bit stumped.
> >
> > Hummmm. Since you note it seems to be when a threshold is crossed in BS=
S
> > size, add something to the BSS of a variable size that you control, and
> > after confirming that you can replicate the problem this way, grow it
> > just past the limit and compare u-boot.map files in the works/fails
> > cases to see just what's being moved around?
>
> So I tried a little experiment
>
> diff --git a/net/net.c b/net/net.c
> index b003b84b3537..a6def9785133 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -180,6 +180,10 @@ u32 net_boot_file_size;
>  /* Boot file size in blocks as reported by the DHCP server */
>  u32 net_boot_file_expected_size_in_blocks;
>
> +#define DUMMY_SIZE (1 << 11)
> +
> +int dummy[DUMMY_SIZE] =3D {0};
> +
>  static uchar net_pkt_buf[(PKTBUFSRX+1) * PKTSIZE_ALIGN + PKTALIGN];
>  /* Receive packets */
>  uchar *net_rx_packets[PKTBUFSRX];
> @@ -211,6 +215,7 @@ int __maybe_unused net_busy_flag;
>  static int on_ipaddr(const char *name, const char *value, enum env_op op=
,
>         int flags)
>  {
> +       dummy[DUMMY_SIZE - 1] =3D -1;
>         if (flags & H_PROGRAMMATIC)
>                 return 0;
>
>
> If I make DUMMY_SIZE (1 << 10) I don't see the problem. With
> DUMMY_SIZE (1 << 11) I can see the problem. If I make it DUMMY_SIZE (1
> << 14) then the problem goes away again.
>
> The obvious things that are moving are net_rx_packet,
> net_rx_packet_len and net_rx_packets. I'll see if I can narrow things
> down to specifically which of these is being problematic.
>

The plot thickens on this one. First I found that even if I moved my
dummy block after the symbols I suspected the failure would remain. I
kept narrowing things down and found that my dummy array needed to
have a length between 0x800 and 0x8e0 to cause an issue. As I was
trying to debug why this was, I found that I could fix a failing
system with a `usb reset`. I'm now suspecting there's something in the
mix that is relying on uninitialised memory (or perhaps the
calculation for clearing out .bss is slightly off).
