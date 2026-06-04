Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE6ACD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C059D8493A;
	Thu,  4 Jun 2026 18:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kA6vjR1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B6684948; Thu,  4 Jun 2026 18:53:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3C384928
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso1606800a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780592030; cv=none;
 d=google.com; s=arc-20240605;
 b=SflaEclTjjJKSf95GRLf17cKLP0sSNx0eJocosuxQNBPN674ujooBxK3BAhVUjZrfE
 WvkCMJA2LUlFSsVkLhQKjrPlVXd0h079OA5eCjkN2oSmLjFvtM2OhNBEB2VlL1v5p75/
 CBsBGRucvXCn0A5tioJPrcB655e5WStw3u/e31f/gPGKh56C5tLVW0hRgUH2bh7bz1eH
 PywrCriAha/uUA6NgbfT5TGIRQZK/XEdTDejxSn49VZAgluF1ARdhU+bim6r4IiXomKh
 XyehbQNbpPwHhXxhrlWYYLKymL3vDIyQZyxUn+Ley2CdlRuE6qjT+TcJzR9tqWJHv9yl
 ew9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FMnz8D2XEZMxFPFBwCn1+chcJkqsIGG/xB+TavbVikg=;
 fh=+avX0Dz129UuuqPRulcLS2JtcY1HLWk9FDPxasV+FGA=;
 b=Q6w+UUzUquHYM3R6sTukXnMZoOsdc/tKEhmwKCuf3d3KoW2iXteqUl4NMf1PuDYnbI
 uThBdmhDydbfSVGN/KCrhsWrIl6KmB1oR5sUWNrddYqbgy+TnREVLHgW+beVhz8wvP8J
 RtMXrmvFBoTYsdctuLxo1tP32JzF6W7CAHuFjKukqjwkoQxXzGf9aBYm7jGXHGfdO4nG
 Awlrd3a6EUzymOkQGtVUcDT8DLcOcXGtau5zCM2oa9z+5t393eL5ALk8MjFwGvG3C0Gx
 mCYsRse1ptsdIif8PnSAKhDd2PCt4JZkxeey0c5G4RR5gzycT86Dva7PjxREFKvVWvp8
 tunA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780592030; x=1781196830; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FMnz8D2XEZMxFPFBwCn1+chcJkqsIGG/xB+TavbVikg=;
 b=kA6vjR1ZBpYUaQgNIvCh2eXwmWzC7R5WAeE8osejlug3u0r8QO6HLOwZkAKjTxyqGC
 R42Id8XeJFTic753FYZiQAGDkIjr3uKIr05ZnD0zgD91QheoHrHWGBLAhSSCE54RHeBq
 S7ktNtDhigtEWHCw1NenwisnkqsNtXB7qsNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780592030; x=1781196830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMnz8D2XEZMxFPFBwCn1+chcJkqsIGG/xB+TavbVikg=;
 b=n858vrdXFkpkNKfiXYarJygrmO4tbBDQ631r23WEwZTZV3SqbI2KaBrrc2fZeLZnPH
 KFfLTtaYqOFscO0QbGPsFSVL7IpJvTRrwPO2TUf8rp1HUYiwey6bU3OfPDi5xg+9ZJcM
 ftm11RyqxDteNb7e4rK6K+nrP1ZEZMeOyTeuV/hp5jpAhtj4ofzWt+P9Gr8iy1+Svvzk
 oizhCBIAzavyqr1GHf3dAqQna/nSCINBVPRfggKNVdg5bagWrMPgW4/SB+STYYh+sp/J
 UB8ymVfk+pukag0QrkCgg5MCfTJoHsFrIiQE1HDwL3lWMSBpef3T9mcqTiB1aVlWm81P
 a/hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q7tBHkn84CPqCTCfVWxGVBOqOnwfugQYYe988oq+KDFCMFOzoG9b3N7q25FWGhY3l0vyyP+s=@lists.denx.de
X-Gm-Message-State: AOJu0YybroyzimC8PjVwuwm3fhp8gg1hcRvszqVOxX4Ibmt0/docrCWg
 dhr1zKJyceWgZENWVMVtn9MR76FJwgeXS68nEkQhCm3jQBjqzP2eIRuCfop3di22fnQHt14J9ay
 zSRlwq3jbDx3q2LlIAFCpQbY1vdhkCj1T4xoPtF3R
X-Gm-Gg: Acq92OG6n5tr6YhQnct7sLxNiozMbM+KUT4pcUxoGdJXkfEb4YjMFOqr5ddMP/AKMrs
 EdIcklco+8CnCh+mZpGVJ7guZltLg6X3JkMcM/hQCnuvKy9TWMXdl4BOG74Z3lDl4Untlwjs1qt
 Vd1BlQMfGrv22ToUcmiYAHdEwsG7J6+ttyac5kliwr+aI+VYr0/jZ+/w28M+l7tOF+EmWbcPqVq
 3IhN4uU5CoAhF6jpLKpSKH+ZYAq4Hy6SRe4/zxYRaU/xWpD5KYG1f/ysD0YeigYaNhX68BsoiFQ
 RUmXLtCX0xfPTjwy5UkSAZli90I=
X-Received: by 2002:a17:907:eb10:b0:be2:11d7:8b05 with SMTP id
 a640c23a62f3a-bf0aac10b53mr347259166b.24.1780592030293; Thu, 04 Jun 2026
 09:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
 <CAFLszThkbskeSsf+HJY41Q0BKYiX3QgXAuSR3Vx6anPXTrR-kw@mail.gmail.com>
 <00f5f51e-3fcc-49d1-82ce-e6311ab64339@nokia.com>
In-Reply-To: <00f5f51e-3fcc-49d1-82ce-e6311ab64339@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jun 2026 10:53:38 -0600
X-Gm-Features: AVHnY4KLVYfqp6mULEmg5slgpMSjwWj8lMnKMsC9OGQGdsKYlFEt6F0fm55e0qE
Message-ID: <CAFLszTgzEkoJkcvpU9xMfwaosYgVr8ZWBpNtaG_FVpaHeSa+bg@mail.gmail.com>
Subject: Re: [PATCH] net: clear IP defragmentation state after returning a
 complete packet
To: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Cc: Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, 
 u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>
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

Hi Mateusz,

On Wed, 3 Jun 2026 at 17:23, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
>
> Hi Simon,
> Thank you for a review!
>
> (I apologize in advance for any issues caused by my mail client's
> potentially still incorrect configuration)
>
> On 03/06/2026 19:04, Simon Glass wrote:
> > Hi Mateusz,
> >
> > On 2026-06-01T22:48:21, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
> >> net: clear IP defragmentation state after returning a complete packet
> >>
> >> During the IP defragmentation process, after the reassembly is finished
> >> with the last packet arriving with MF=0, the reassembly state wrt.
> >> static counters is not cleared. In case this last arriving packet with
> >> MF=0 gets duplicated, payload bytes are mistakingly treated as hole data.
> >>
> >> A malicious actor who can deliver fragmented IP traffic to a U-Boot
> >> instance with CONFIG_IP_DEFRAG=y can corrupt memory via out-of-bound
> >> writes and redirect control flow into attacker-supplied payload bytes
> >> that already sit in pkt_buff[].
> >>
> >> Publicly available AI models are able to generate a reproducer based
> >> on the provided information.
> >>
> >> Fix: once the assembled packet has been handed back to the caller, mark
> >> the reassembly state empty so that any further fragment (duplicate,
> >> replay, or a brand-new datagram that happens to reuse the ip_id) goes
> >> through the normal re-init path and rebuilds a clean hole list instead
> >> of dereferencing payload bytes as struct hole.
> >> [...]
> >>
> >> net/net.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > with nits below
> >
> >> diff --git a/net/net.c b/net/net.c
> >> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
> >>
> >>        *lenp = total_len + IP_HDR_SIZE;
> >>        localip->ip_len = htons(*lenp);
> >> +
> >> +     /* Mark the reassembly state empty so that any further
> >> +      * fragment goes through the normal re-init path and
> >> +      * rebuilds a clean hole list
> >> +      */
> >
> > Please use the standard U-Boot multi-line comment style with /* on its
> > own line, to match the rest of this file (see lines 962 and 1016):
> >
> >     /*
> >      * Mark the reassembly state empty so that any further
> >      * fragment goes through the normal re-init path and
> >      * rebuilds a clean hole list.
> >      */
> >
>
> Ack, will do.
>
> >> diff --git a/net/net.c b/
> >> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
> >> +     total_len = 0;
> >> +     first_hole = 0;
> >> +
> >>        return localip;
> >>   }
> >
> > Only total_len = 0 is actually needed, since the re-init path at line
> > 1007 already resets first_hole (and payload[0]) whenever !total_len is
> > true. Still, this doesn't hurt.
>
> Ack, will keep the first_hole = 0 for the sake of "defensive programming".
>
> >
> > Any chance of adding a test? Probably this is a little tricky...
>
> Hmm. __net_defragment() is called from net_defragment() when
> CONFIG_IP_DEFRAG=y, which in turn is called from
> net_process_received_packet().
>
> net_process_received_packet() is finally declared in
> include/net-common.h and reachable from outside the compilation unit of
> net.c.
>
> If this isn't too much of a stretch, I'd propose creating a new file in
> test/dm/net_defrag.c and reuse the existing test infrastructure here.
> The stretch is this placement in `dm`. What could be a better choice?

That seems fine to me.

>
> The test would pass a 2-fragment, pretty short datagram:
> - frag A = MF=1, 8 bytes of data
> - frag B = MF=0, 8 bytes of data
>
> After completion the unfixed code leaves total_len=16, first_hole=1, and
> payload[1] now holds frag B's data bytes. On a duplicate of frag B, the
> function does h = payload + first_hole and reinterprets those data bytes
> as a struct hole.
>
> Now, in order to actually have a deterministic and reliably failing test
> for the unfixed code, we could:
> - first, use net_set_udp_handler() to count incoming datagrams
> - craft B's 8 data bytes to look like this "benign" hole
>         last_byte = 16, next_hole = 0, prev_hole = 0
> - abuse the delivery condition (net.c lines 1054-1058):
>
>         if ((h >= thisfrag) && (h->last_byte <= start + len)) {
>                 /* complete overlap with hole: remove hole */
>                 if (!h->prev_hole && !h->next_hole) {
>                         /* last remaining hole */
>                         done = 1;
>
> Duplicated packet B would trigger duplicated delivery condition, call
> handler registered using net_set_udp_handler() and increase the counter
> in case of unfixed version; fixed version would count only a single UDP
> packet in the test scenario. No segfaults.
>
> Sounds like a plan? Let me know if test/dm is an acceptable place for
> this and I will write it in a separate commit (same patchset).

Yes that's good.

>
> >
> > BTW, 'mistakingly' in the commit message should be 'mistakenly'.
>
> Thank you, honestly, that's a way to finally remember the correct
> spelling :D. Will fix the commit message.

Regards,
Simon
