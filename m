Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE5CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 05:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E28680433;
	Thu,  4 Jun 2026 07:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R1ATKH3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AF4848E2; Thu,  4 Jun 2026 05:39:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3AA8467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 05:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 53DBF3F29D
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 03:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780544395;
 bh=cMFc4C27OzZHOq0oYrKiEBKesGJQXBGzg5fqmwG7N4U=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=R1ATKH3li5nTFJJUPizKnn2P4uTbEsreOhvzmr0wBgNmBF6WvxptyifhnspMSXXVo
 zPkeWxSj1TMT1oqxM7XB+tmdX8aVwsetlosU0e5lVXPMJXbNL+p0yeXDDZtwq3DD3D
 x+Eq537lSfUMYhEY6X+W06TPWaXgBHli52K7tl1B62w4g+cMFKTP9XhJxly8S8xXN6
 u/CyOXgE6yRXvT2ez+6hWx3E+yQ1hWGojP2FAwUXOpG5KCtSPu/VUWenSjEQOZDZOX
 m0NGYWTJQnyyfBqsGJEsPZODXN/X2v8keXsnOmtCTTgh9Dq32w/pZR17ZyBPZLfNFZ
 elLxTXe63jnBPQ4v86oj9/QA4m+beoKTQLxtidBxNq3FOG3P8utUm7ld8RY96qcEz9
 DPvWEBo6vt60lP5QBePlpq9qlhmVVtc06D32vawr2mWndrSURIGYQsS+oROLqOa21t
 v6Z8zNsH8uJRMhnKFAqn9mokPCYejZfQWAsmHUuTZv9m4P/TxOFQrKpvbEbSvJNlT7
 YdZb7aWUIcTZAg3NGD+hU2vGabGRKqPW92n1xpqnBPsJR2lruCFHzOEa685hFJNqJw
 UTQ4fL+KdjrWnyBLaJJ350dBZslOSTh85ZWXIq3fMW4iswzrX8rN45xoBuQUBJfGYI
 Fijvl64HMw9Zm8NeuzFeO3gA=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-68d9309b510so153493a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 20:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780544395; cv=none;
 d=google.com; s=arc-20240605;
 b=P8Dzphjj8daFncQvSrdKRRek6ZI//whnun6DwO5FVyt73it24IWPUu2NMFvBWmomB3
 OKZmLQyqQzUfsyhZRozp2nU39iLyI2H6+y9LKzFZgoNJp8HyOXzWn/LmazMs+cLIab2s
 hY2v8gOXsAJiDg2Bv1cRzPqrN9dJGdBMtg7bQZoMcegT86AmpQX3Y8qZWvv5mW3nLgbJ
 WWAK9J5Jd79Y+tj3q/Y8eMsprPLbZRN8UPLYGcMhHZcRdgWCMyFh7X8pTdfHWuSvC57p
 qIc7pOeUmHpRher1J/kLheRpChBSAT4rFH9PomqXEg38jUh6RLWTEH2dUliKVxRDCbIn
 lD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=cMFc4C27OzZHOq0oYrKiEBKesGJQXBGzg5fqmwG7N4U=;
 fh=Qjr6Pb174X52BXgAGhHwqAsN33Frk73aPFS63OiMcjM=;
 b=Ion4aCzX5XAeVlG8F9CHkqwo4JU+Xl2YVZI4TqvYS815/gWadN0GCQqdXGxjoT+s8j
 SX2POXsIvNLVBgTFnZ5OKVGHyFHq1J1NQP6QxaRk0pIjlCktGk3yb2yupLZkcuiGsEuX
 oLzslb5cbODgSGAFFxcj6G0E3960GbNLGi6+hkUVt2I4uvZqr0H7VWfnSr3S6ZhQrlIW
 D0H2VOZGt+yhB7JZV0zOhKjHNgJvtX8gHON5zT0MDkqP1DuuPKS4E0VYFNoB5Cj8wMCl
 iguHjjAbmef+KaTPtSheXKnKQAIBgphD1r/bLQp8XNsbJJku2pfSrWout6h4BA1BC2DP
 uxyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780544395; x=1781149195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cMFc4C27OzZHOq0oYrKiEBKesGJQXBGzg5fqmwG7N4U=;
 b=h0dyGwEp7x+wuOd16bFGimiKxBYfUsTYFiCmkuAFDDp//nff83ChC9tANIAHGw4H4m
 DOfAS23c4//2iSzVHfLEdVVtkcZNt1xceg+uCeezI8kd7O4CPmS+4/7OcHIWp5egbKJC
 tsZjLfQW1IMjBIdqU3PCwLOAR2Q5SFexR5gLS+Wwuqb5Ybxabha16cRLyIiHNYu+G+20
 zo4B/18rr4MCNRAR/ds/T/B0kX5xubEuAIKhDHRqjVhgCLsKhYdvnQOueGoMaMaXBmLX
 sIsEG3dC1KNEeBpTKB107QhyuQYXkdMGMY4aAqDFr0OZDk7fzk78aQBdILaIrTmDyA5w
 DSIQ==
X-Gm-Message-State: AOJu0YyFt1bOAvyy0U8K6eBef0noQrVfKfzHbnaWxwjjPpAjbJDY6EFl
 8JBfXKWX3lK0MIp0eQUp9S3zjuMOe4DIdf7TXco6omUYXTzHl2prvAs2c/fxR0G7tGObwir7bNv
 MqyMynbZSK1UGxWG/GiJ5fCNdqNfQnAycCakQrBvmPtblATfNbwCiO7tyPvFwzRwqQKeQZKxyvM
 edffwv+zqEfk9APU1V1diZQDU5chNANUWCXoyUyJjtYy86OdgZudKNbQ==
X-Gm-Gg: Acq92OFPceY6EMplylU73a21US1JrBe6T6pVGzwJoJ7wjjgZo58An2G4cBAn49UHkY3
 rB+Nkjk2ppkJx7da+kXYFI6wIeHN8vv/gFeLY7LUDvJ9zjulbtfLmjOHyjgJDEAJUoGzPsl6tEV
 jX+fBkw/IvXiihxebvxNHS5BW9aX+SYrIX2zwvoHb74q0jQQlHt9pf0uEAmAy2/IYrE7XtWXNgZ
 KPm4eXlQclvaaUPGg==
X-Received: by 2002:a05:6402:380b:b0:683:dd5c:191d with SMTP id
 4fb4d7f45d1cf-68e7293d4eamr3008849a12.24.1780544394950; 
 Wed, 03 Jun 2026 20:39:54 -0700 (PDT)
X-Received: by 2002:a05:6402:380b:b0:683:dd5c:191d with SMTP id
 4fb4d7f45d1cf-68e7293d4eamr3008838a12.24.1780544394641; Wed, 03 Jun 2026
 20:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260527150637.2850104-2-aristo.chen@canonical.com>
 <CAFLszTgTZsjQZhFqp7MDAeUxyWKOe7jwHjAGG2Zcr67yEmG_3w@mail.gmail.com>
In-Reply-To: <CAFLszTgTZsjQZhFqp7MDAeUxyWKOe7jwHjAGG2Zcr67yEmG_3w@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 4 Jun 2026 11:39:43 +0800
X-Gm-Features: AVHnY4KtvVtS5PE4tp1O6F-OAH5u2ukn2iMpth-v6MGcOHnyH7l49lSKB2Y8wlM
Message-ID: <CAA=k7==U+Qv=t4wPdN17tz6+D7F4Sg+U-qrpa2rF1RX0T20_hA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bootm: fix overflow of the noload kernel
 decompression buffer
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Ludwig Nussel <ludwig.nussel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:10:31 +0200
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

Hi Simon,

On Thu, Jun 4, 2026 at 12:49=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> > bootm: fix overflow of the noload kernel decompression buffer
> >
> > For a compressed kernel_noload image, bootm_load_os() allocates a
> > decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
> > kernel compresses by no more than a factor of four. It then passes
> > CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
> > image_decomp() as the output limit. The decompressors honour the limit
> > they are given, so a kernel that decompresses to more than four times
> > its compressed size is written past the end of the allocated buffer and
> > corrupts adjacent memory.
> >
> > Pass the allocation size to image_decomp() and handle_decomp_error() so
> > decompression stops at the buffer boundary and fails cleanly when the
> > image is too large, instead of overflowing. The regular non-noload
> > paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN. When the
> > failure is triggered by the smaller per-image buffer, print a note so
> > that handle_decomp_error()'s generic advice to increase
> > CONFIG_SYS_BOOTM_LEN does not mislead the reader.
> >
> > Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> > [...]
> >
> > boot/bootm.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > @@ -635,17 +636,20 @@ static int bootm_load_os(struct bootm_headers *im=
ages, int boot_progress)
> >       err =3D image_decomp(os.comp, load, os.image_start, os.type,
> >                          load_buf, image_buf, image_len,
> > -                        CONFIG_SYS_BOOTM_LEN, &load_end);
> > +                        decomp_len, &load_end);
> >       if (err) {
> >               err =3D handle_decomp_error(os.comp, load_end - load,
> > -                                       CONFIG_SYS_BOOTM_LEN, err);
> > +                                       decomp_len, err);
> > +             if (decomp_len !=3D CONFIG_SYS_BOOTM_LEN)
> > +                     printf("Note: noload decompression buffer is %#lx=
 bytes (not CONFIG_SYS_BOOTM_LEN)\n",
> > +                            decomp_len);
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> The note is printed after handle_decomp_error() has already produced:
>
>     Image too large: increase CONFIG_SYS_BOOTM_LEN
>     Must RESET board to recover
>
> So I think this is worth a follow-up, too...see also below:

Noted, I will find time to see how to fix this

>
> Using decomp_len !=3D CONFIG_SYS_BOOTM_LEN as the gate is
> indirect - it relies on the alignment never coincidentally matching
> the global limit. The condition you actually want is the one that
> allocated the per-image buffer (IH_TYPE_KERNEL_NOLOAD and os.comp !=3D
> IH_COMP_NONE), so testing that directly (or a bool set inside the
> allocation block) reads more obviously and stays correct regardless
> of how CONFIG_SYS_BOOTM_LEN is configured.
>
> The cleaner fix is to teach handle_decomp_error() itself about
> the noload buffer (e.g. an extra flag or a separate label for the
> limit), so the 'Image too large: increase CONFIG_SYS_BOOTM_LEN' line
> never gets printed when the noload buffer is the true bound. The
> trailing 'Note:' is essentially patching over a message
> handle_decomp_error() should not have emitted. What do you think?
>
> Regards,
> Simon

Regards,
Aristo
