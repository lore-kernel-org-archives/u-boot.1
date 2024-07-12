Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA612C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 10:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E038859B;
	Fri, 12 Jul 2024 12:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GHqRw5Hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20638859B; Fri, 12 Jul 2024 12:41:44 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101DA87F19
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 12:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so3117852a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720780902; x=1721385702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAnDB3I6WatuAicYE/+7GUI6qZNiQaY2sz+Xb3Y4liE=;
 b=GHqRw5Hv4r3RBBElrtfPzLeKz5VMgdN63yOLnnluVKvQBQqyYMcwb430ol48itRQ86
 DBuSq50WZ+s7GNwCdIcAntrkjdc7UDjWpEdur/BwPaglohJxlDbT27xmI1zmUwmkg75T
 9Jv+wF4Auo53/zzfjr9wDkJzVA2NPA1g+lHyLpz4f1BKWgwlSFrSh7l5Tqs75tMOA8mG
 yD9Lmyemqx2o1ajPW1LLrwIQolTTaedmR1Wrlr7+jr/AVrTY7164M3ELT0oFmTwGH76a
 PZkQLQL4NcJV0vfhp4jtrX2sVEHQNnQXcFB7DtObAm0kySamWr/oas7/EG+4+GUSp2I9
 Fqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720780902; x=1721385702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAnDB3I6WatuAicYE/+7GUI6qZNiQaY2sz+Xb3Y4liE=;
 b=o/mzf1qSERvlPvPgDbNxeESkxxd3KdJ6fw+COztY76TxqZsjwn4EI+iX2QZmIp0mve
 4o1LcqIcU10dz6zBhbsXckKcN0UC9BkSHRWuLHTe83LyxMlwYoYdZ/2mwMlmPEOMjBPM
 FdQCYmbR/5VNM/i5UbcQ0c110oeSSImld6Hlxpr5MHRSUKEU60zjCMpTg+E3hZ9g3X6t
 3lOeAwjWhorneTWVS9+GAwy2nYpOrhep5ODe5eKWAV8+QPwvGlsDODyF6Gl0C4qkj2VH
 gGGGTCm4JetYv13kd/VujLE6aRDdzsx+CILzRnRgHWdsuMcNiw7AOmJis9lfedHPjo8u
 77IQ==
X-Gm-Message-State: AOJu0YzBgVFwcG99jvKyfSM3r4yBZONhh3zDLQ9ymYP9SKlAku83PXfM
 pZTAdkmTE9slAH3TIAESifwUXrxy757sYbBUfQcjzq3aZZI3w1rQVBczKxiYdbE97riaLO45Vj9
 F1npWaka49YcxhqvpOwmj+CqJhSE=
X-Google-Smtp-Source: AGHT+IEmd+7hKO3m80K1y1rlsz8dZqeOpkVnMVpPGYzJucCjwwoRnIIPHUJZV4LA584SZ3mgyNQyTPJHw1KoPCAMRqE=
X-Received: by 2002:a05:6402:35ce:b0:57c:bec1:ff4b with SMTP id
 4fb4d7f45d1cf-599647adfedmr2107379a12.10.1720780902423; Fri, 12 Jul 2024
 03:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <PAWP194MB20554D5B2D9D47E02E35F062DADB2@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <PAWP194MB20554D5B2D9D47E02E35F062DADB2@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jul 2024 11:41:31 +0100
Message-ID: <CALeDE9MNjZRFEVYjCcnPStvz1rnzWC0JEx3ouFzag3mnchO01g@mail.gmail.com>
Subject: Re: [PATCH] board: raspberrypi: Fix format specifier for printing
 rev_scheme
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
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

On Tue, 9 Jul 2024 at 13:20, Francois Berder <fberder@outlook.fr> wrote:
>
> rev_scheme is an unsigned integer and must not be printed
> as a signed integer.
>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  board/raspberrypi/rpi/rpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index d996eb0cf6..caa4483117 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -381,7 +381,7 @@ static void set_board_info(void)
>
>         snprintf(s, sizeof(s), "0x%X", revision);
>         env_set("board_revision", s);
> -       snprintf(s, sizeof(s), "%d", rev_scheme);
> +       snprintf(s, sizeof(s), "%u", rev_scheme);
>         env_set("board_rev_scheme", s);
>         /* Can't rename this to board_rev_type since it's an ABI for scripts */
>         snprintf(s, sizeof(s), "0x%X", rev_type);
> --
> 2.34.1
>
