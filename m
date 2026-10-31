Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BE606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SxZJUJyy;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WmH4+OOg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55C7140B2D;
	Sat, 31 Oct 2026 08:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9B20nbUSw1S; Sat, 31 Oct 2026 08:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7402940B08
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436714;
	b=pGTxrWUn89JmnjrEmSSISBs6b2e3nhS8C9ql+Za/xkCzfluwr2s2HnXvT1a5DYbu7d25
	 pmfSfFdkTJ9BjVksImdu0zSGZ27gQM+Tl3pSyUqLM3gBXv/KT1RnJIv21Fi73/URRqrdp
	 AkSL4RPwvGBK672rUsCAmdRrsLTw/TNmtClK4RTW1udrIpkknhtK5wf0lWszNH8cLKX2u
	 S5/mbyu/KHF/3YgkafegXOuVyr7pUEsbfUGhQdEFD1r62b7zFFHAnuPj/DaNy+sXuGSRj
	 lEmqZh74aP3VU6qjHIu3z4hPxdzP137W3CzfX1ieNn9Jk+1ZFyQJR656KDlpsCy8bYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
	b=Ex4QlLmrtNp+8bYgSGmAYmah0X+cFfhZ6KzOtwg7UVnKWk816WrlXzP0iBbo3gIChbAw
	 sZvCDBkKMTnJWrbJW/s5raiucvV6svGD+nbsMJpSKO7is7cPodrTn5xHPn3fW+fotw44j
	 kCehrPHHqRxS7aWHu0m8ZkWzvSTAv08Z61CuDVGe6FG2uSey1Sqzu64PNZm/H6ck9k1w2
	 kxTKuXpfGt09rn+1QZhwjV7zp96XPOAT3Xc8IYOaU6DxtbWznGUl3ZyvurAGezkZ2xC5c
	 zCI/CsLrEk2BU4v4LiYOIsP9MtWPAdgqO63txUNX8a4TZ4/ewsKhz95MM0EZmS/g8NA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436714;
	bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxZJUJyyjx9bHroU2SubhSnlQJDXRMyDjpyjhiuHeCBCvAzZT4cEGNCnBHP99KX/m
	 agt4LErL0DfDWp938cdHydocIYGx4isXA1LGfByOHKGzqMSF5FSJZkb3NVB9ocF/ft
	 Gr6kB+txiZOTTzeuP6kY8TvJDADy0F+bQR3IJ+X04vfF3i4pAhRHPgWHgohUQjt9mJ
	 JbdCMHuVVJF6PO6ZvaiD7o6N1C2gCxy3PiEmQqjeZGje5YraQ2oTm85VzPPt+KlkYA
	 LXxai1LH+LtRK0klAdKzO2jpNR9OvJ15YF9jQN3HKNIvRbMZlEsGH0lrssbCsWMoge
	 RN/lWqFM1HQMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7402940B08;
	Sat, 31 Oct 2026 08:51:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ABEC4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C768400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNbjQHdllk1N for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6E18740057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436712;
 b=Cus1qwGfHcqCKyz7zTsGGEplqW3vK+NtFbj9c2xJVNDNaH5niJ2h7He72zmdGXDu8PpA
 mflLr/36EAKTGzrUp24FPeU5ArcGhAcrTnIy3lWlX1BVOyctCqnFI9clXEbjFheLj2sCY
 dwrTyoFEcGnlAVqSFiKr/AHIYQ426M6pp5NXACR3uuDwhz07JXuF2PuIB8oEz22ySgz3d
 Tg9GVIyWUYrDESn0HDuRirbHeo/jOkJFpFbNZdNxuXixrdf26t4w9qBNwkmcG3aIts5hz
 nBWii7qhdQi7OEPQccVJ7xFbzGZ3l6j9KRR5QgSLjHNhsOFsRp1SpiDgkbuj9ZhzNcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
 b=fbOJ3jE8ceiTY2/rbZ/a5TsBVTV6s/qdvXhBjOuW/38PwGBzZEtu1Rv9eapbojgQd64b
 6co9ZCqBNOFlehCqMv/zHtBYSP7aonMaPxNTrqhilqj4BR9qrz5X+iWK3qFOlKE2RYhnS
 FmXQaP2PmwVe7/R9nlnykG/1xwDtHLKT8FtJ6beOfcppIlvm7j7Xi4bnr2LDxPke6P8Cx
 h8uVdfkc/OzAMMquGS8MxlcLFagM2uevXMiLK0sYOJsboWqLgY19WFzXvn6QK5CuNWUDJ
 9lgmFNEz/qr6ntmxe9vxkqD+XCcGKQJ3MrO2uZIwPsBWcugD7Hx/OstI7guFkAJK2Ng==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WmH4+OOg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WmH4+OOg
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E18740057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:51:51 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so1280870a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436711; cv=none;
 d=google.com; s=arc-20260327;
 b=pU6zWmHKV45qryKl3lHdF1w55dk3Tq+aSiMsCkVSjDA8uSfF64xVatJMIIUmZP1cFG
 Q1K6tK4qeEwccpiQOQ7135pOy0ldCiGgyMocPB7BL88LaiVVQhwYB+JEyBC4ddnhMw2S
 xx3Ed2GnY9B5/8NYyhDhxU9hpgLgtOT/2A5auaWbVoZ6B/VlyQ8XL6Hv8MkqOj+LrPME
 vSuLmBJeENEv5VxpXUERjmBYVp2bNcOY4eA6cUzW/l8bwSRP2rREWdjQBoyv8qIRNtoV
 8mxgu4trDqf4MNHBeLNrSsYeSlhXZiciBsvvUysLH3vanlyOWBbqvRsP59EWRZvp/jmo
 LTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
 fh=UvvEvGtP3+Vd42RN1AtDp+p52eu+Hb850kLhD+/8Iy4=;
 b=R+Qa+6dzpBjVNrAvyyleT7xrTVgfaOnaf/rxKpTSPwDlBX2fXjtsySf7N8UiI7VQeG
 oQUW+M1ddnMmIpE6QaCuXBh1Dqvy6ZUc+cjNbblfcCYgokDruVDiJzxf7gK5vbpvY2Z6
 rciQZQbaEFqArbZRjFsLZLPDvhIgbJvMiYhdBlfC4xWekFyXGdirFiwppO/MhzQu0NYl
 tWCDK2c3NoHEyd8+mK/0PI/HK02kp9hc9IgKiCNPjaMKrfgaKx3KfDOasm/Q47Kl11Ns
 2Al3wOmBkBkXps52quFZfmgEe5XYRF/V+hSn/jiCSBii1SshpDSjPrSZDCQIF7VeIFhY
 zWaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436711; x=1794041511;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
 b=WmH4+OOgzy9ZwG5XgZw1YBOiodsJy6wOaWvVgh/lQ2uNNqTDacsfG+wAeJn5VnbB+P
 U+CKqtApRLi9GSjtgZfPbI5ZizV1fXor3vUVqtEeN/pc+UzfZa8nL6gvekLkeUgUTC8o
 A+1iobASh890nVbYmEYFj9/qj1TtuzoNgc0lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436711; x=1794041511;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=siOhEze+N26K4XA4pxN3ZELzBENuIHIe8hJXjJRrqK0=;
 b=od3BSYa2VddL3jqQcbNDkrpYi/1JQgwkCm+x/Y5tt+29Xn1buyC7nY//vgjbXEWTD7
 TKXivOVlB5ICeVxyJgqJgvimw+ZaRoUDR5cQPPMe16NEODwAPX1KrIkPcZGf7NTlqURF
 +JVzXHtqyJnwm1x9VcCJX1ZY9WPiQPhz85vx5goAqwuxAEkbIu9GXOqDAjy3S51OBUoS
 7MFnf/TcdzSDyjniPpSSrI7h4Jp+uN2FYymXXjB+IxxqxrpSg7CKQSrZdof5BJshFNYh
 8lSdTXibxU0Vfq+EJkrxGKBg78T0PI4VPJUrpiqgWp3P5kqV2Qs2ThSm1XcoynBVA6Ap
 tnKQ==
X-Gm-Message-State: AFq9FYLP/XalxtTNkF7UK2gbzq335VtIgIBKEZs4L8flzKle0epuTcBZ
 lM5T8R6xY8RoJt4EHx74IjuNa1YTck5kKN3gJLW6NN+8W1DEOPPxvGXcgMIAO6CsGs7enCnf3W+
 wojZ/U+Fj2J0F8UOL8mWWOrcdx7VaiW5TEpQTvkeh
X-Gm-Gg: AYBFou01TGbBK1PC8FF6sFIQ7fuZKZt8qt3YDPj4g3soKYfGVhLWNcqRg9fNGrOdfDk
 12odRu3uz+9xt2DWzpt8i+o1j4UzhuYZXqGLbvfeKdGdcqdeYVNP22lx6b79F4ww9p9tugoPRIA
 Abi8BqubNS/ZRuuo+c5PaP5KxJLWzwBwci1qsIPnDxHQaJCsxHu4UzshzuF+vuay/8RzFVA8EK8
 nJ0fxtl84L0Et2iCicM/dhdV6sHYe81DH6AIqpzvvDYXn4BrgfiJ4OViwUcIz/MRB23AHtr0GFR
 I3ihjCrmtn6XfHpG4EHCSCvYPcyCGdJZ5dKVzx4zdayBi6GNmNqRAqfg68xji/fOvZVfKKAxay2
 WkORPMZKXFkidr+7h+T4Di8l/t6hFbC3vVAlIB2ijLgvdrLdkxDG+hFg+wZUnS53PtegfBVA=
X-Received: by 2002:a17:90b:584c:b0:3ac:9c37:9418 with SMTP id
 98e67ed59e1d1-3ae89724824mr3804457a91.19.1793436711391; Sat, 31 Oct 2026
 01:51:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThhg2QQgw0q0tiY4=11Ze4gBTsQbZ=arnKD5QuaCs7nfw@mail.gmail.com>
 <28c467a6-2ff6-44a2-9638-aa158ccaa100@mailbox.org>
In-Reply-To: <28c467a6-2ff6-44a2-9638-aa158ccaa100@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 08:51:37 +0000
X-Gm-Features: AclHuK_GjO1LCbr67DJBQKd7-dL9zPzPLizg4-nE9pvdykujkGEvxjHlo-vdsCQ
Message-ID: <CAFLszTg+p1+h2yCk1radYXjgMwDNPS78s9bBip74MtdT3+eB3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: mkimage: Simplify fit_pre_load_data() data
 types
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Thu, 29 Oct 2026 at 06:28, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 10/28/26 9:41 AM, Simon Glass wrote:
>
> Hello Simon,
>
> > On 2026-10-27T23:15:27, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> >> tools: mkimage: Simplify fit_pre_load_data() data types
> >>
> >> The fdt_getprop() already returns strings, use const char *
> >> and get rid of the void types and multiple type casts. No
> >> functional change.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>
> >>   tools/image-host.c | 19 +++++++++----------
> >>   1 file changed, 9 insertions(+), 10 deletions(-)
> >
> >> diff --git a/tools/image-host.c b/tools/image-host.c
> >> @@ -1721,7 +1721,7 @@ static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
> >>   static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
> >> -                                   int pre_load_noffset, const void *key_name,
> >> +                                   int pre_load_noffset, const char *key_name,
> >>                                     const void *algo_name)
> >
> > (not sure if you missed these or decided not to do them, so here they
> > are again just in case)
> >
> > The 'algo_name' parameter is still const void * here, so the two (char
> > *) casts in the 'Can't find valid checksum/crypto' fprintf() calls
> > remain. Please can you change it to const char * too and drop those
> > casts?
>
> Fixed in V3, thanks.
>
> >> diff --git a/tools/image-host.c b/tools/image-host.c
> >> @@ -1794,10 +1794,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
> >> -            fprintf(stderr, "The name of the algo is invalid: %s\n",
> >> -                    (char *)algo_name);
> >> +            fprintf(stderr, "The name of the algo is invalid: %s\n", algo_name);
> >
> > This line is 84 columns, so please can you keep the wrap?
>
> I kept that, since Linux already switched to 100 wide and checkpatch in
> U-Boot is not complaining about this. And the readability of this is
> better than with the wrap.

Fair enough. With my setup (multiple editors side by side) this goes
off the side so I don't see it :-)

Regards,
Simon
