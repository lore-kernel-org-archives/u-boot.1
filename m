Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66145CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C95848D7;
	Wed, 17 Jun 2026 08:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="doYFMpVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FA484704; Wed, 17 Jun 2026 08:28:01 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB1B838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vk092kumar@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7fd6b4d5d49so5339697b3.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 23:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781677678; cv=none;
 d=google.com; s=arc-20240605;
 b=FEs0RYFfSIo7hClZ33aIuipFUS6Ab9ut71i6zCbBpg1qMo2QOr/mEw+5I8wojvyI2C
 34cir1kqc3CrRy5B9xSQeITF4QrobJr7qomEsn2Vjyol5mwSaIziO2J9MbzwLo7uo/KJ
 3rum4xQdrw4XnlmFC5Av1YDOWRmwLYzFPuNQbv9Iz4A5sOGFZZj83Xju8CpZUkyDhgUA
 cVlKV/cqLciD2uIjAhoaQATox36si62fqQ8gh6uIgm6xMcTnv+KaoxnJALV9rp+grXly
 E5t+xapQfAwGNbZWh42fh++241Yzz586IGlYU0veJW0RReTrss0SCwWx+SFeGMiNxnyr
 l7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=phZ25FLOG9srRIPJoFnwqa+euVi8wb8o2sKEVXtU1is=;
 fh=QDN0bLC2E6pVywqN9OV5jVlv6VCVAIIAFICIFJGq4SA=;
 b=E+rb0rb+/XL8NT7/lT/+bOowStpmRpMF0vzQ17Xt2ZCx0HMurdhUoEqhOKKOeQu2ZM
 r6XLBlpZhEa0W73Lite+YkK0fjQZA1ZYs8Us6UKrYbGf0OzCSZ/uwcMcnDPHWM4qtimj
 ikktMpleF23DOAhICtRgh5+m8FWoJQc+nxI2pRiv4wFZdIo3c6ho6auiFgxqxFIQdob+
 QyfyhLKQntyW2+MRVfvKXzvJ1bkhg3AnU5yvZBR53UqFtOEtRe2kBhmK6O/1kOQo+VBB
 grr9AqWvXODZpgo6lE5zrAI6f5CJ69gMF7dN1LoOdNwfgh+fM9DCrQ/X88288qU1ZJsa
 zYsQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781677678; x=1782282478; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=phZ25FLOG9srRIPJoFnwqa+euVi8wb8o2sKEVXtU1is=;
 b=doYFMpVhm5AWGwrvtX8IKUQLjoRSJe4+0gH9jLOftOoe3ss3VEodiE7wy7c6CKa+uS
 Wvnvsn8A70KLvl88kt1meqGmLOyBW7DCL/BEuEeVtnT+zVbrw9buzKuq9Sg/0kRwrNn4
 EkwDWGBDQNlTCTpqhers42yPxXJXpwlLDQfVrALBJnOmUsFXVUTS8eFYKseD3s6TBfi+
 cNzT/cS1krUTnaelxLJe2UlDKpLeaFIn/dEzLe2nlMum7KisfWyLu7WW7h6plNNBLkER
 OspNq07/HbvyB7Vw05PNv3O3WFP04YdJggDCQVq9DgKhCIouxKsCsFnrqA0Tt4k3pg4u
 nwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781677678; x=1782282478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phZ25FLOG9srRIPJoFnwqa+euVi8wb8o2sKEVXtU1is=;
 b=lIuQGJ6yQJgNBsNHG5WBpt0igkX9ALP+RQiMcL73MxBlkF7y9QbWnb0/Gu910ScaZK
 Q9Br++0800lM3Z0F/7S+5hmshVGPbqakxcqaSokEWtD8/6IH9588JZkCFkHQAZAuB+7g
 WvbrBiLnAQyNtdGQMoG6rF2cx9TdpTEtnEu5EROZIEC+s0JtU5R4FIm8j5x5b/s9XFdh
 4AKhIfBJptJ6DkGlOLMmzpJpeF7KrrQJqDVwYgNQc6I7E5P8x4j62RLkQ1za7TdxG6IV
 iNz9Pf66bypliztPYWjH7EatYNfMh9SvBgjJmIix/zKk9jZFmUbzVHFn1ft5iwqEU2Q7
 n3sA==
X-Gm-Message-State: AOJu0Yylpg2FViYabNSDkpnV6g7Ik7VnaxqOVUc6aet1D2ca33nqOiJv
 oDIz+BYFmVlVrAOyOl2GxqO/Ou4nPaq+i/OECDIDat5oBFr7tLg2uiDqW3L1BqqOPqHD1X/6z+G
 ZZ3P24Mg3g4q/YLGwVlM3Ki32+PJTfVC6IDHj
X-Gm-Gg: AfdE7cn8XS/XBD1xfbosgEtfkOo0Ha0ahuW9g5rPQSJjJbOR65yIg54vmrlFNPx0lSA
 aflUgCrNE/sePLkyjSdaFtGBELHa0cE2rhWBexeivQfAQRzef6YJQXfiyRiY+0iIgXicrPLiyCx
 PZTeCwBd3MSgVVtrfdAsAJ9R8P3oCdju2A/Wxg4GiZftw27EhEFGFdr9sdsxOzfhgeIdP2IfX+g
 7zSlCP9rEB8i2xUg0NgchykkCh9vJ+DNrm1i1htUb6Z9nGHvuc4hHmaARjGT5Wc6VfBzLLDDoEZ
 MpvNpw5ET3aGYAP7dAy0XG4MJdEc3F+/4uxIWWbnyxaMwRYw7rMEimDNw+3Hsqs3mu1I0TE=
X-Received: by 2002:a05:690c:660d:b0:7dd:a645:a57 with SMTP id
 00721157ae682-7fe73bbfd7dmr15097647b3.10.1781677678184; Tue, 16 Jun 2026
 23:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260610093726.1231041-1-vk092kumar@gmail.com>
 <20260610135440.1589268-1-vk092kumar@gmail.com>
In-Reply-To: <20260610135440.1589268-1-vk092kumar@gmail.com>
From: Vivek Ray <vk092kumar@gmail.com>
Date: Wed, 17 Jun 2026 11:57:47 +0530
X-Gm-Features: AVVi8Ce0E7CqFZgL6mxxamvYAFtWyPzah3o6U2IMHadim3Uo3SIp99QEbB6w4z0
Message-ID: <CAJD4gbt6-ovuQavFF7BNSukmPK-uezJN2XdgvARyZN70-zSaZw@mail.gmail.com>
Subject: Re: [PATCH v2] arm: mach-snapdragon: increase compat buffer size and
 warn on root compatible string truncation
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com, 
 u-boot-qcom@groups.io
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:59:32 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Casey, Neil,

Just a friendly ping regarding this patch.

The v2 addresses the review comments from Casey:

   - Increased the compatible string buffer size
   - Fixed the truncation check

This was motivated by an issue I encountered on a QCS6490-based board where
a longer compatible string caused the generated fdtfile name to be
truncated, leading to a boot failure.

I wanted to check whether there are any remaining concerns or if further
changes are needed from my side.

Thanks for your time.

Regards,
Vivek Ray

On Wed, Jun 10, 2026 at 7:24=E2=80=AFPM Vivek Ray <vk092kumar@gmail.com> wr=
ote:

> The configure_env() function copies root compatible strings into a
> 32-byte buffer prior to parsing. If a compatible string exceeds this
> limit, strlcpy() silently truncates it, producing a malformed fdtfile
> path and a silent boot failure with no indication of the root cause.
>
> Bump buf[] to 128 bytes and dt_path[] to 256 bytes to accommodate longer
> compatible strings. Also, add explicit truncation checks after both
> strlcpy() calls and emit a log_warning() with the offending compatible
> string to make such failures easier to diagnose.
>
> Signed-off-by: Vivek Ray <vk092kumar@gmail.com>
>
> ---
>
> Changes in V2:
> - Bump buf[] from 32 to 128 bytes and dt_path[] from 64 to 256 (Casey
> Connolly)
> - Fix line size check, use > not >=3D (Casey Connolly)
>
> ---
>  arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/board.c
> b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..d9390d9b5d3 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -390,13 +390,14 @@ static void configure_env(void)
>  {
>         const char *first_compat, *last_compat;
>         char *tmp;
> -       char buf[32] =3D { 0 };
> +       char buf[128] =3D { 0 };
> +       int len =3D 0;
>         /*
>          * Most DTB filenames follow the scheme:
> qcom/<soc>-[vendor]-<board>.dtb
>          * The vendor is skipped when it's a Qualcomm reference board, or
> the
>          * db845c.
>          */
> -       char dt_path[64] =3D { 0 };
> +       char dt_path[256] =3D { 0 };
>         int compat_count, ret;
>         ofnode root;
>
> @@ -417,7 +418,11 @@ static void configure_env(void)
>                 return;
>         }
>
> -       strlcpy(buf, first_compat, sizeof(buf) - 1);
> +       /* A safety check to avoid silent failure due to name truncation =
*/
> +       len =3D strlcpy(buf, first_compat, sizeof(buf) - 1);
> +       if (len > sizeof(buf) - 1)
> +               log_warning("compatible '%s' got truncated, fdtfile name
> too long\n",
> +                           first_compat);
>         tmp =3D buf;
>
>         /* The Qualcomm reference boards (RBx, HDK, etc)  */
> @@ -468,7 +473,12 @@ static void configure_env(void)
>
>                 /* Copy the last compat (e.g. "qcom,sdm845") into buf */
>                 memset(buf, 0, sizeof(buf));
> -               strlcpy(buf, last_compat, sizeof(buf) - 1);
> +
> +               /* check for name truncation */
> +               len =3D strlcpy(buf, last_compat, sizeof(buf) - 1);
> +               if (len > sizeof(buf) - 1)
> +                       log_warning("compatible '%s' got truncated,
> fdtfile name too long\n",
> +                                   last_compat);
>                 tmp =3D buf;
>
>                 /* strsep() is destructive, it replaces the comma with a
> \0 */
> --
> 2.34.1
>
>
