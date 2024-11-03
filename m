Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D31E6F09E
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 14:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E3B88D70;
	Sun,  3 Nov 2024 15:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AmJMitc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9901B88D70; Sun,  3 Nov 2024 15:46:16 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 920B68862E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so265999766b.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730645174; x=1731249974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8g1mTonPtd+4mLLyOZUBwZWnX7C+lWrNPeY4FHtuvY=;
 b=AmJMitc/SLN2GoNxbyN/W/xpWMIicapVlQv98SwNds2amn2tLs+N8gdgLc8j/mdehT
 9Gj9CqpkVLluq7tAFZB19blRUIxCqDbWoVm/KzRj++9i87bhLWTThTPdUYqHr9Kio0qg
 fhySxnx8UZtNS7dR9ggPFh2F9bymAfnmxEV/rZDNStQEqPbQixqfn8eca+mofWjjIkm0
 YzphRnilz0s0bp3/3U5fTO0vhLP4NbM17shXtSwAtQ/8neykCLX79EAaFW+3nAeFvTDm
 HsLf8qADgKmkNSW55QTC8KSnbMzFyjEf7Tr8OhobJH0oJxoFNccFwvh/mXdzKPyfLBUW
 KanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730645174; x=1731249974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8g1mTonPtd+4mLLyOZUBwZWnX7C+lWrNPeY4FHtuvY=;
 b=Sg09w/2ZrbR0n4FQG1/0ahQMFUhnEetllxweFVe+k+Vd/0rqE0aMNckwlLHi4ZNojB
 b8O7pFADaS258w6omUmZgtdYPjsWWg0lbUda1uIiw/YVrnJErj52QYaUNm2Utv6og4n+
 2bw2QC23J/Lvca1s27Anlr5UOGgAV5h3Vyxx2RtTAItrhHbpIjWCErC2hVGEIoqPq7nb
 4A9rL2j2VlI6TyhNwMTRx9djxTp6bomNtwnOms5u4wggMLsU9TCmyx5hA5paVcRteed5
 bOGl3RVCVigub5RyJUTSD44IELFWtF4M28dW9fASg/vbINndPdfsJ5VXJupPFjWyWF6z
 ZMWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTXdQK+Ia0Oj+/0IfuXoJ81ezMeekJ+Z3zRB2bDZld50pE6rZWRa5D2ISKjVKTiz9+W0U6cOM=@lists.denx.de
X-Gm-Message-State: AOJu0YzC7mqiiVNY8dl8nchJF6ssUNy1WbAjKk2m6gzNslYsfzofx8DD
 Ioy8BvZJoDa0WNrX1uPGGFoWbuKntTZiq5SgfkcZYuNntoZhd+qs37EjJQtRXKkX6P4jrFcnXlT
 qKUSCdCiel1AoK18trTrLTVIa8INhjaLP8WkLHQ==
X-Google-Smtp-Source: AGHT+IH11WggHn1Refz6TYxbVq1s5VYP+SUkvnQMu4a+X+SY6x/hMPvju0FRKhxWXRnsVPz7UwYAwB0DFBv/Um+vk3Y=
X-Received: by 2002:a05:6402:510a:b0:5ce:dcb1:b786 with SMTP id
 4fb4d7f45d1cf-5cedcb1b89emr242137a12.4.1730645173875; Sun, 03 Nov 2024
 06:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20241102063226.39388-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102063226.39388-1-heinrich.schuchardt@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 3 Nov 2024 20:16:02 +0530
Message-ID: <CADg8p96T+TUydSAnpdyVP0m8-C2m19gRdWNJToOYy4bAHUYXdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: do not panic in lmb_print_region_flags
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Sat, 2 Nov 2024 at 12:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Commit c3cf0dc64f1c ("lmb: add a check to prevent memory overrun")
> addressed a possible buffer overrun using assert_noisy().
>
> Resetting via panic() in lmb_print_region() while allowing invalid
> lmb flags elsewhere is not reasonable.
>
> Instead of panicking print a message indicating the problem.

I had initially considered only printing an error message in case of
an invalid flag, but my thinking was that something like an invalid
flag is a serious issue with a subsystem like lmb. But otoh, your
argument is correct that we don't take the same action elsewhere in
the module.

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
> fls() returns an int. Using a u64 for bitpos does not match.
> Use int instead.
>
> fls() takes an int as argument. Using 1ull << bitpos generates a u64.
> Use 1u << bitpos instead.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lmb.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 96a055f951e..00c8888936a 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -72,16 +72,22 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
>
>  static void lmb_print_region_flags(enum lmb_flags flags)
>  {
> -       u64 bitpos;
>         const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
> +       unsigned int pflags = flags &
> +                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> +
> +       if (flags != pflags) {
> +               printf("invalid %#x\n", flags);
> +               return;
> +       }
>
>         do {
> -               bitpos = flags ? fls(flags) - 1 : 0;
> -               assert_noisy(bitpos < ARRAY_SIZE(flag_str));
> +               int bitpos = pflags ? fls(pflags) - 1 : 0;
> +
>                 printf("%s", flag_str[bitpos]);
> -               flags &= ~(1ull << bitpos);
> -               puts(flags ? ", " : "\n");
> -       } while (flags);
> +               pflags &= ~(1u << bitpos);
> +               puts(pflags ? ", " : "\n");
> +       } while (pflags);
>  }
>
>  static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
> --
> 2.45.2
>
