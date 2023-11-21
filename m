Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F8FC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A3887590;
	Tue, 21 Nov 2023 19:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ahcIw0xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65C78269F; Tue, 21 Nov 2023 19:40:31 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E694487590
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a55302e0so8532981e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700592027; x=1701196827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sDrnhqZZKfOE5ciEnGXpA17Z4p5wGxqPBeElk2IKK2I=;
 b=ahcIw0xXBCb6X5QGKMH+M9+B2Jqik/IASYXvv0dmBQEe6JOaSmHUSYlGGLFmAvo/lc
 iNW+j6mgSSw+sLzQekji5jIK1ZjmVkJv1kbzbkEZBO/Az6+fi1BYRunBEyqZ5Elgkjt6
 5yeFEYoI0HdOnfq84gEHdcGOaJdjfOaAaruQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700592027; x=1701196827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDrnhqZZKfOE5ciEnGXpA17Z4p5wGxqPBeElk2IKK2I=;
 b=HID7PkqE0UsBwIb7PkymY4OiFANzp8G9/QaO18buwDm46Pk5L9Ils4BBdW9qqQuAwc
 Y7ZLsdysPtCoFIHY6X14LuEyuJV8WedNCV63uEVCAtWo9EUpRmvPBwHlm9MH3PmbdXWD
 9rzGQ9M8COANSPUgPRQHSP4Kd7X41dsp1NXXMGWa3eyLcfIL3il1fYzd2UynqUVCAR8Q
 ulW6R6GTHDrou4sbiBFGprAET9A7flMyE4XZx/TAcQsm76JrYcIMq4it+6LQVlAdw3xC
 a06oqkpKSG/c2E6GNaGAfgV2r5Y9akIyz+TO6ZZHK/ntS/G1zJv9XlVnaNHnPO44LdDc
 fb1g==
X-Gm-Message-State: AOJu0YzkhZxuddNAHgI/lEwt6zGKxPPDYumEjpPzPZQsjKCLe+xFNmzq
 G0bm6Zl0t94WJ6MrXnU94wv05pt7yaNX/baqjy4e8A==
X-Google-Smtp-Source: AGHT+IHGn32kjMnrIq1G/GNPvJ+pQnnEqxufuUHEAjFtEj20Z8q0GCq25w34qif9qC1FMdSHp+YdSkayvznKXJWKAgk=
X-Received: by 2002:a19:5501:0:b0:50a:760f:dd29 with SMTP id
 n1-20020a195501000000b0050a760fdd29mr35301lfe.66.1700592026844; Tue, 21 Nov
 2023 10:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121183510.6451-1-clamor95@gmail.com>
 <20231121183510.6451-5-clamor95@gmail.com>
In-Reply-To: <20231121183510.6451-5-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 11:40:08 -0700
Message-ID: <CAPnjgZ14yKRz06=j5+_e7XE2G82PWRb2QijkYsCPXkpqSFtbaQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] lib: membuff: fix readline not returning line in
 case of overflow
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Tue, 21 Nov 2023 at 11:35, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> If line overflows readline it will not be returned, fix this behavior,
> make it optional and documented properly.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootmeth_extlinux.c | 2 +-
>  common/console.c         | 2 +-
>  include/membuff.h        | 5 +++--
>  lib/membuff.c            | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index aa2a4591eb..ae0ad1d53e 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
>         log_debug("parsing bflow file size %x\n", bflow->size);
>         membuff_init(&mb, bflow->buf, bflow->size);
>         membuff_putraw(&mb, bflow->size, true, &data);
> -       while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' '), len) {
> +       while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
>                 char *tok, *p = line;
>
>                 tok = strsep(&p, " ");
> diff --git a/common/console.c b/common/console.c
> index 8a869b137e..cd56035171 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -846,7 +846,7 @@ bool console_record_overflow(void)
>  int console_record_readline(char *str, int maxlen)
>  {
>         return membuff_readline((struct membuff *)&gd->console_out, str,
> -                               maxlen, '\0');
> +                               maxlen, '\0', false);
>  }
>
>  int console_record_avail(void)
> diff --git a/include/membuff.h b/include/membuff.h
> index 21051b0c54..4eba626ce1 100644
> --- a/include/membuff.h
> +++ b/include/membuff.h
> @@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
>   * @mb: membuff to adjust
>   * @str: Place to put the line
>   * @maxlen: Maximum line length (excluding terminator)
> + * @must_fit: If true then str is empty if line doesn't fit
>   * Return: number of bytes read (including terminator) if a line has been
> - *        read, 0 if nothing was there
> + *        read, 0 if nothing was there or line didn't fit when must_fit is set
>   */
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch);
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
>
>  /**
>   * membuff_extend_by() - expand a membuff
> diff --git a/lib/membuff.c b/lib/membuff.c
> index 36dc43a523..964e504d5b 100644
> --- a/lib/membuff.c
> +++ b/lib/membuff.c
> @@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
>                         (mb->end - mb->start) - 1 - membuff_avail(mb);
>  }
>
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)

Shouldn't that be the normal case? I might have this wrong, but this
looks like a bug fix to me.
>  {
>         int len;  /* number of bytes read (!= string length) */
>         char *s, *end;
> @@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
>         }
>
>         /* couldn't get the whole string */
> -       if (!ok) {
> +       if (!ok && must_fit) {
>                 if (maxlen)
>                         *orig = '\0';
>                 return 0;
> --
> 2.40.1
>
