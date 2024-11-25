Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4623D3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF87389986;
	Mon, 25 Nov 2024 01:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F/1wKKJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CD489323; Mon, 25 Nov 2024 01:09:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A33588815
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6eeac3535baso36475317b3.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732493375; x=1733098175; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+AN2kiW4SdF4PKYHJzy1n7eNoDLuLmngAkFu5YiDKA=;
 b=F/1wKKJ8Hf+0urujPDbOMrd64wYQ/gduIsfyKDelXID+lrulkHh14oBBR42UM4qgAt
 puYZRqP4ATZKrf8fq4lqrbrepsmtNQG32zDevhfaf/M/sYkW0onRPSc80cYrC7DTva7H
 Wuz1/djrCkeQlfdIxtRWyLJhyE/FxO0HlTm18JkN0ukB71oIR14w5ZAySzOOEFGWoD62
 l/3OSLGw1y0nF6T+MYbHGjN3G1FE2pB41LFgCn13Qv/YjI0n+gfvSYRw12XMoNR1UpIl
 +6XfQ0T6AVF6zMqJPk2azVtn9bZkXxQ5vFgCIZ9s05gSFHLCjuWwkA/9e2xs4S4FuGQf
 HDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732493375; x=1733098175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+AN2kiW4SdF4PKYHJzy1n7eNoDLuLmngAkFu5YiDKA=;
 b=O5oZ3MczAm8AQ8UUpvWLekIfUidhW5bDa/N2Xf3J8IC8/k8MWF1Ii43BVoMimSijwv
 2q64xxaQiinhTR897sd675LZwUICGzTnS7DCiFFsf2gSP2KrJ2mGs8kNPG7S39oVJEZA
 Cr1LuxCsz8lyxHXPAb/cxtWMK4CLEt8O5HE/5Z/gGIgTKJ+KnexiLjd8Mo3erbtnT4s5
 uLs5GnehOeIBFfOFE1M4jZg57rGybcetslWxBCecfvLtk7gZp+bn9mxjAEsiMyzxrFOC
 uwtC+RBwvRmY/ni+GPhJaJ64RP38pVFSXbzYN9rrAMb5px48ZTyn8avaBM1K2JiKUyWr
 uU/A==
X-Gm-Message-State: AOJu0YzphRVzonfxGH6oDWUN5mKPi+Sr8DpBwUjsfVjJBifMewWPNEk3
 IKWuCmfYBd+nEvocv3KbYS0/SS3yk6Y2UMsIPNaZCS7IG8yveXR+WiK5s010pPKH3FjJQSxyffm
 yN5G1BKQPCOTh7hg6kezB8RI1fFbzBSUe72k=
X-Gm-Gg: ASbGncuJgWO2VYYcVfsD+UAmM/3bEk8hBuRWGFWaCjSbtfIs4BelPmdRXMrh/qJu4sE
 0GDkJ/ixJVKn8wHC0zLLqIVvcAkIQyQ==
X-Google-Smtp-Source: AGHT+IHiF0L7qQORKDd+Mo/Gsftqd1F43WTaS7XnnHOILPmTV0f2Its9kbV0KB6kX13DuTd4i8E5qQd1lgWIvVXICzU=
X-Received: by 2002:a05:690c:3686:b0:6ee:ba42:7611 with SMTP id
 00721157ae682-6eee08c3391mr105800137b3.10.1732493374921; Sun, 24 Nov 2024
 16:09:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFOYHZCwXSChH_rH251cUp-bgwai+e8xrOuqxepX9Dur2wGTJg@mail.gmail.com>
 <20241123024048.GK3600562@bill-the-cat>
In-Reply-To: <20241123024048.GK3600562@bill-the-cat>
From: Chris Packham <judge.packham@gmail.com>
Date: Mon, 25 Nov 2024 13:09:23 +1300
Message-ID: <CAFOYHZCuqSDWOUBGQ5_PAaLW229fwyk9vF47vC+rq_TW5J-qjg@mail.gmail.com>
Subject: Re: Odd error with cn9130, asix88179 and xhci
To: Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:56 +0100
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

On Sat, Nov 23, 2024 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Nov 20, 2024 at 11:29:43AM +1300, Chris Packham wrote:
> > Hi U-Boot,
> >
> > We've hit a weird problem at $dayjob with a board using the Marvell
> > CN9130 SoC and using the asix88179 USB-Eth adapter.
> >
> > The problem is after enabling and unrelated feature in u-boot the
> > asix88179 fails to receive data (I can confirm that the link partner
> > does see packets in the transmit direction)
> >
> > =3D> version
> > U-Boot 2022.01 (Nov 08 2024 - 09:45:44 +0000)
> > =3D> usb start
> > starting USB...
> > Bus usb3@500000: Register 2000120 NbrPorts 2
> > Starting the controller
> > USB XHCI 1.00
> > scanning bus usb3@500000 for devices... 2 USB Device(s) found
> >        scanning usb for storage devices... 0 Storage Device(s) found
> > =3D> ping ${serverip}
> > Waiting for Ethernet connection... unable to connect.
> > Reset Ethernet Device
> > Waiting for Ethernet connection... done.
> > Using ax88179_eth device
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> > Rx: failed to receive: -5
> >
> > Abort
> > ping failed; host 10.37.233.65 is not alive
> > =3D> <INTERRUPT>
> >
> > Debugging a little we can see that the -EIO is actually because
> > xhci_bulk_tx() hits a timeout from xhci_wait_for_event().
> >
> > We think this is triggered by the u-boot image size crossing some
> > boundary (the problem seems to start when .bss_end crosses
> > 0x00000000000f0000) although I've so far been unable to find
> > specifically why that might be. As far as I can tell u-boot is being
> > built relocatably and nothing is overlapping. I also considered that
> > ATF might be preventing access to something but so far I see no
> > evidence of this.
> >
> > If I turn off some features to reduce the build size the problem goes
> > away. That is actually how we've avoided the immediate issue, although
> > that means the problem will likely come back and an inopportune time.
> >
> > Does anyone have any ideas as to what the true root cause might be?
> > I'm a bit stumped.
>
> Hummmm. Since you note it seems to be when a threshold is crossed in BSS
> size, add something to the BSS of a variable size that you control, and
> after confirming that you can replicate the problem this way, grow it
> just past the limit and compare u-boot.map files in the works/fails
> cases to see just what's being moved around?

So I tried a little experiment

diff --git a/net/net.c b/net/net.c
index b003b84b3537..a6def9785133 100644
--- a/net/net.c
+++ b/net/net.c
@@ -180,6 +180,10 @@ u32 net_boot_file_size;
 /* Boot file size in blocks as reported by the DHCP server */
 u32 net_boot_file_expected_size_in_blocks;

+#define DUMMY_SIZE (1 << 11)
+
+int dummy[DUMMY_SIZE] =3D {0};
+
 static uchar net_pkt_buf[(PKTBUFSRX+1) * PKTSIZE_ALIGN + PKTALIGN];
 /* Receive packets */
 uchar *net_rx_packets[PKTBUFSRX];
@@ -211,6 +215,7 @@ int __maybe_unused net_busy_flag;
 static int on_ipaddr(const char *name, const char *value, enum env_op op,
        int flags)
 {
+       dummy[DUMMY_SIZE - 1] =3D -1;
        if (flags & H_PROGRAMMATIC)
                return 0;


If I make DUMMY_SIZE (1 << 10) I don't see the problem. With
DUMMY_SIZE (1 << 11) I can see the problem. If I make it DUMMY_SIZE (1
<< 14) then the problem goes away again.

The obvious things that are moving are net_rx_packet,
net_rx_packet_len and net_rx_packets. I'll see if I can narrow things
down to specifically which of these is being problematic.

>
> --
> Tom
