Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C673CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB8A80398;
	Tue, 12 May 2026 13:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbLYlCdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E465780F0E; Tue, 12 May 2026 13:41:35 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECF5801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so2182866a91.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778586092; cv=none;
 d=google.com; s=arc-20240605;
 b=PopHF001o3blWkXw0fc8KA5VKLoy8q2REySL1TqNcbcjeZW0LrPWJSPFf6pyPdsgiM
 Z9imqFrsh+EVXhrqYYPj8y0QaeiZNcWhnMt1VH8sPxt+q079GFhMrdHSFVD3hvpYMo1q
 wUIcnrQ50KCcM3uN6GXajiLlXDTiJtILvy/sAJQNWfxhABo/+veMlaf13CGv0TG00rmM
 b26hnuprFT4cmvIMtkwLjXveyhJSXjIwO/F5YH5zV9cbOGOQ5H9E0ffb0XUNwNmn7VQV
 iq9DfXW0SotvPQbu1Vr9nl6q3pcg0rR8D5kAZGcyfBDDfyPvFkjZkUl/P+yCzKSkG1iI
 t9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rinE0E2IAQekbHyV1PaA4N0V5Ga4+lAW8iZ9QUhifjI=;
 fh=eIoeGfRhJs0Xwa9O3Q17ErGstXvEKnFyiIwPMMa+JvI=;
 b=TymZQIXIwKfJ9HWhOKWv+P9ax/iSgERPumX3w8k8rZWg+YtZWAUoMxpRzD/hHVq9dm
 OirLIlRWBu6r+vB5py1/ZH8U7wYFGOLkWmUef2f63pdPPRxtEu/pBqwpC6Ni/HwkiZDb
 R3uqmZeSdzYJWcjd4rT5ve7X3quzegBqcye4qypoY9NxwzGW/xy8i8n8YyNRQ09UZmZK
 EmrKdXbt7TLfDqhYOo/jrqPU5UD3dUQ3ByCQhTOKubwMlGsVSUSfdii9J1bEPNdvkck7
 /VgGcigQuLchIlf4ghKiiQvxjvBvxbnHTYXHPwhO4m1nNWwKops4pUrnLB+1cpwOqt0h
 X0YA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778586092; x=1779190892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rinE0E2IAQekbHyV1PaA4N0V5Ga4+lAW8iZ9QUhifjI=;
 b=UbLYlCdA/4pfsPQk1eTPk7Xk8qsOV7yagbTKeQ9+Mv2IJoIu/dDA8cmIeoftvnxGAl
 tLQqg8Yyy0YUxNnS59/uGyFGjDPEk/iJjTMyRIQCrMeEiRXMpCjPD0WB1MdyTSJKoJ67
 jVyyDoNSOsFQ9bFO7xNQVogEk9UCFDXRB48zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778586092; x=1779190892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rinE0E2IAQekbHyV1PaA4N0V5Ga4+lAW8iZ9QUhifjI=;
 b=oST0P5WSwHg/PrajzuBLdDDEGCY+Qm0ygunz5fL5cjkS7PZao3bjA2fH0RDuO2AvBF
 +SjU7uRbnPFCzsXiD4jvQsvPKpYQT68Cpfwff6P6viibQ47O7He8YI+ACGscgJB9xUqu
 Kd4ZRaeGqy6H4zk+8v0y0d08TGoNiT41rmjwpfEM/zK0xn4KGx7yg67+dDmRUtB7m2qz
 csh+l2E5ZEXTTj/DiK/EqoB9bTEXqiGSsvyxU8WW6qi0E61Ic/hrPbYadsEj+AHNaiBY
 4t61xIbhzyawH7EHrrztSSpexJGc+PA7bcOCFfS87BvaiwT3OBVLlMtfpGymcKDamznC
 nkfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FQXPVRdbu8btiIm6ea7vnFigxsu3FYpwCakLzzx/eEhDTGDzHwBaFocJJKeOWbjcjL1OXCMk=@lists.denx.de
X-Gm-Message-State: AOJu0YztxyVjpfTpAieOljs5+oIUkF0PYGUZqs0cg5p/S0XJin/W6tiO
 JvGGGyoxAMR71ZSe4yG3jz3e71SYP/GTYvlUJJIGpxM470K8eamH4b9EVAcwtWCn16yKV9cdEee
 BntzfjSjYOnMN850o9EBABOQQpoQaeT9JoGu6sFwO
X-Gm-Gg: Acq92OFhKDJ4Efx6IigojWp7ncQ65Kh/HfRel7bgZKeU0mbecvxBOzgjMgwG1BN0aT8
 jixlzBEddLYVE5mzHvrrMlHJpbvEcuqK27wA/v82sfn5DbfvCYfphEzeoERAjiru2YoRV+T6AeK
 cdJwVjkqaJTRHCuKTdBd7uOmEeIAsDSt6nc/vAwkRxsbwsH8UXRCAYsknrGwGR1oPaO2GVqJr4H
 ef/u9LhsG/oB6be2pRY4IFBABue+mpErqfzQRsfpNt4R9p6djs34ebdftkT7kLUF+IC19TVycNa
 m7AzWx5K1GWdZCJY
X-Received: by 2002:a05:6a20:12c5:b0:394:3001:8b59 with SMTP id
 adf61e73a8af0-3aab1876f97mr20707968637.53.1778586091861; Tue, 12 May 2026
 04:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
 <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
 <c92efcca-0b81-4b67-a628-0ee93da6862c@baylibre.com>
In-Reply-To: <c92efcca-0b81-4b67-a628-0ee93da6862c@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 May 2026 05:41:18 -0600
X-Gm-Features: AVHnY4J4A71DW2IMPpSyvo9oiTTQdD5FHPdAu1t2Dg9UIF20NV7uYXOJudw3VIY
Message-ID: <CAFLszTj1y0=N2=PqW75q3-_3E88XLArDUPfVDOH9X_Zky6NQTA@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
To: David Lechner <dlechner@baylibre.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

Hi David,

On Mon, 11 May 2026 at 15:48, David Lechner <dlechner@baylibre.com> wrote:
>
> On 5/11/26 1:08 PM, Simon Glass wrote:
> > Hi David,
> >
> > On 2026-05-09T17:36:26, David Lechner <dlechner@baylibre.com> wrote:
> >> net: lwip: introduce net_lwip_eth_stop() function
> >>
> >> Add a introduce net_lwip_eth_stop() function and use that to stop the
> >> network interface after each command that uses the network.
> >>
> >> This makes the behavior the same as the legacy net code and avoids
> >> potential issues with the network interface being left in an active
> >> state after a command finishes.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>
> >> cmd/lwip/ping.c     | 10 ++++++++--
> >>  cmd/lwip/sntp.c     | 10 ++++++++--
> >>  include/net-lwip.h  |  1 +
> >>  net/lwip/dhcp.c     | 15 +++++++++++----
> >>  net/lwip/dns.c      |  6 +++++-
> >>  net/lwip/net-lwip.c |  6 +++++-
> >>  net/lwip/nfs.c      |  4 ++++
> >>  net/lwip/tftp.c     |  4 ++++
> >>  net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
> >>  9 files changed, 68 insertions(+), 22 deletions(-)
> >
> >> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> >> @@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
> >>       struct udevice *udev;
> >>       struct netif *netif;
> >>       struct wget_ctx ctx;
> >> +     int ret = CMD_RET_USAGE;
> >>       char *path;
> >>       bool is_https;
> >
> > Initialising ret to CMD_RET_USAGE changes error paths:
> >
> >    netif = net_lwip_new_netif(udev);
> >    if (!netif)
> >         goto out_stop;          /* ret is still CMD_RET_USAGE */
> >
> >    if (!tls_allocator.arg) {
> >         log_err(...);
> >         goto out_remove_netif;  /* ret is still CMD_RET_USAGE */
> >    }
> >
> > The fall-through after 'Certificate verification failed' also lands on
> > out_remove_netif with ret unchanged. These paths previously returned
> > -1; now they return CMD_RET_USAGE (1), so the command framework prints
> > usage for a network/TLS failure.
>
> The code I am looking at says:
>
> enum command_ret_t {
>         CMD_RET_SUCCESS,        /* 0 = Success */
>         CMD_RET_FAILURE,        /* 1 = Failure */
>         CMD_RET_USAGE = -1,     /* Failure, please report 'usage' error */
> };
>
> So I don't think these changed. CMD_RET_USAGE is -1.
>
> Happy to init it -1 though as you suggest if the name doesn't make
> sense here. That is might be why it was -1 before instead of using
> the macro anyway.

Ah yes I missed that this is a pre-existing bug. We should return
usage only when parsing is wrong, not when something fails.

So what you have here is fine and actually makes the bug more obvious
in the code, which is good.

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> >
> > wget_do_request() isn't a command handler either, so CMD_RET_USAGE is
> > doubly out of place. Please initialise ret to -1 and set ret =
> > CMD_RET_FAILURE explicitly only in the paths that previously returned
> > that.
> >
> > It might make sense to split this up function (perhaps in a prior
> > patch) to try to make the error handling easier?
> >
> Sure. Is there a common naming pattern for that in U-Boot. I would
> call the inner function __wget_do_request(). But I know opinions on
> such things can vary widely. :-)

If you do take this on, I would say better to rename it, e.g.
handle_request() - strictly speaking we are supposed to avoid leading
underscores, since they indicate symbols used by the
compiler/toolchain, particularly the double underscore. In practice
you will see use of a leading underscore in the code.

Separately, I am taking a look at more use of getopt(), which would
make parsing more regular, but unfortunately adds code size.

Regards,
Simon
