Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D442ACD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58387844CF;
	Wed,  3 Jun 2026 19:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UAFey7Lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47658467E; Wed,  3 Jun 2026 19:04:55 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD22983FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84226d0f1d2so3204329b3a.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506292; cv=none;
 d=google.com; s=arc-20240605;
 b=KD2khAVFlmhZujMTwW+wrkopIocFNun/o1VXMc6V5HFGU3XBPPzbTupf8cXFlou5Od
 6eXk80o8E3MNwODknRGVUyLJMmQ4XT6inQ5k6XZ80E6XbsxsAhlq4J3gTEE5xpqpegnc
 AslOyi4I1ci6JXK3KFpt9GE0ixeoC4I58tpQiMfh2I7CcZv8afhZk6weTTw+hu7NkEaa
 QK6huDBE5OEFENyjlHXJW6ntapWfe854gxfdFmX06+ZAsJqxcEdx5E6FpCjUOJkJmX4w
 DT4iw0QVBsQjtNJ7r7bE0GIiLcLlQ0Knxvr1dQv8gNo7bltYsI4d++OavetXBM5Gtwkt
 Sesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0M7AXnGUo/72cVP5pA9GdX2S2Ne2Q7dioGFw+9rReFo=;
 fh=JuVPvCcdYHbTQ05Cm0UdwBY7HolDRTcJQpnzV1O7sm0=;
 b=cvZZmIluJ1Y6OBX26jIInGJwoS4Dh3isfYoo4htji6cQDWmFnegQ/MaLWQcYjZEgyZ
 LgXNeK9Hd4MHefMt0oi4Nt8fABz6odBHrsdLh/ykkbENINHHWWBiBrhsXmnUb6mdboWY
 M7MHRjIiU7PewD9USrTwhEJnX/mquix1DKGRGkYnR4t7LC1lCI8LZe7eqheKnHjPdvjb
 dMnZ8N0w1wJ8dVb+pnfafiKGJNE2AdTeEKeJsVafGWpohDFKyv5B5kaopVJkqCEoEfqi
 KX85DgKYydsuoJyjcV8Ay/J/x97FujJgwHoqdWDgOB9RAO4naeoM0//M0wrRcBjyuEld
 1arQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506292; x=1781111092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0M7AXnGUo/72cVP5pA9GdX2S2Ne2Q7dioGFw+9rReFo=;
 b=UAFey7Lrxz8uKVYKK7TRH6SfGND9fjAsv+nMOf+vx5WVyGSK11RDaKDG+x7ej3sB2g
 NDowN7oxRWM9xlk7VldFri6POC2rxMw3voFpG1zZJ35tO0CE4zXrdnET8PTJkBtjpzAO
 /aI8wNM498Ti98hAGV+VTkxtCSaWHPjswXGls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506292; x=1781111092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M7AXnGUo/72cVP5pA9GdX2S2Ne2Q7dioGFw+9rReFo=;
 b=BskLXbyhzMyQHt/97R5B6nDQoS5zy9WtJL52IVynwQkgf9fXiA0HwPddqT/KIlt6vK
 xsJG3QYeCF1ECznBeRrqs+aGg6pr/TeS8ouxL9B5OoFiA6gnu4uezlZZ3ubwrfTwjg1g
 dwDq4S394tzVooTA/gvJxLlCjiKaPE56NKoXDgGfznnJbSt2QBnoZh6MoimQNp2Sm4WZ
 H7EDbnVjs8RzTnqd/Lp0v81wIlS8zq48gMdN9c+2OoeoVlOzAjH7N0m5g9HXzT5GBM+P
 3Enz2KXW64+FS39EdmTKrT9JBblktGlKJwhDT1u9A8ei7NfAXjeTgIvgFHXOYOgN3DnP
 JG3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uCt9VyRktIaSR1lHdy/ZcN1Tad5S/KnYVAbPtW27o8/D5FRSH63fb+CIBrpnLTfkb+AaOf/U=@lists.denx.de
X-Gm-Message-State: AOJu0YziO0iLjk1B8dGqPlOHy3JYn3ZUGNHCcyZY/eGT6mIixpIST+pZ
 1Rraan3Fs85LiYINOr+qSw5JceIxiT3LwIozrswLh/2UVvyS9KCgtwnVQoRWh7LtEAJMrhqgfxi
 USNBPkEoN4pJ/9W5RyP0XE8jn9F0Mi9viR7wDBiSF
X-Gm-Gg: Acq92OFHSCEL3kRP8Y+bryRzN4qakfomAWM9wLF/TH2dGpk43NX8PZlT7mR2kF4895k
 vryEsGzFKarV5Rc7cu2DnTP+CKsC7M5uW3IgcB1/U5aJ28yWvGY+7OUJmSjI7WlKPcaFQvO4W/L
 egDLFwYdRcTrfih9MlgUPVgmfoiAmkc+9Al/ewtNhfdP1OpWIqBSrIqvi6zDz1G3L1wIs3iJOMX
 CfopNYdDDez4DD4JonzyCD9SLUsCDiXW1XFPSYUpgZ9jjBonnSNX78w/9ffB24qPRAEPbJawMlP
 hINhkt76agHVCpGq
X-Received: by 2002:a05:6a00:4f94:b0:842:7f81:8085 with SMTP id
 d2e1a72fcca58-84284d5abe3mr4588753b3a.8.1780506291895; Wed, 03 Jun 2026
 10:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
In-Reply-To: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:32 -0600
X-Gm-Features: AVHnY4KoF2nTZNvA333u_uXW_gWcUZ95ehtYsYEFIBk5QaXLkZfFXhCqv8XVNqw
Message-ID: <CAFLszThkbskeSsf+HJY41Q0BKYiX3QgXAuSR3Vx6anPXTrR-kw@mail.gmail.com>
Subject: Re: [PATCH] net: clear IP defragmentation state after returning a
 complete packet
To: mateusz.furdyna@nokia.com
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

On 2026-06-01T22:48:21, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
> net: clear IP defragmentation state after returning a complete packet
>
> During the IP defragmentation process, after the reassembly is finished
> with the last packet arriving with MF=0, the reassembly state wrt.
> static counters is not cleared. In case this last arriving packet with
> MF=0 gets duplicated, payload bytes are mistakingly treated as hole data.
>
> A malicious actor who can deliver fragmented IP traffic to a U-Boot
> instance with CONFIG_IP_DEFRAG=y can corrupt memory via out-of-bound
> writes and redirect control flow into attacker-supplied payload bytes
> that already sit in pkt_buff[].
>
> Publicly available AI models are able to generate a reproducer based
> on the provided information.
>
> Fix: once the assembled packet has been handed back to the caller, mark
> the reassembly state empty so that any further fragment (duplicate,
> replay, or a brand-new datagram that happens to reuse the ip_id) goes
> through the normal re-init path and rebuilds a clean hole list instead
> of dereferencing payload bytes as struct hole.
> [...]
>
> net/net.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

with nits below

> diff --git a/net/net.c b/net/net.c
> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
>
>       *lenp = total_len + IP_HDR_SIZE;
>       localip->ip_len = htons(*lenp);
> +
> +     /* Mark the reassembly state empty so that any further
> +      * fragment goes through the normal re-init path and
> +      * rebuilds a clean hole list
> +      */

Please use the standard U-Boot multi-line comment style with /* on its
own line, to match the rest of this file (see lines 962 and 1016):

   /*
    * Mark the reassembly state empty so that any further
    * fragment goes through the normal re-init path and
    * rebuilds a clean hole list.
    */

> diff --git a/net/net.c b/
> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
> +     total_len = 0;
> +     first_hole = 0;
> +
>       return localip;
>  }

Only total_len = 0 is actually needed, since the re-init path at line
1007 already resets first_hole (and payload[0]) whenever !total_len is
true. Still, this doesn't hurt.

Any chance of adding a test? Probably this is a little tricky...

BTW, 'mistakingly' in the commit message should be 'mistakenly'.

Regards,
Simon
