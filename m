Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD8C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 20:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC4387C69;
	Mon, 13 May 2024 22:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="CSRjbNOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AA688210; Mon, 13 May 2024 22:52:18 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770DE87ABC
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so1232676266b.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715633536; x=1716238336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLkROO1SQNO9dE6+P1muioxZq3ExeRvliE5viOMXuXQ=;
 b=CSRjbNOAA+f9OEFzhsmXY7F8FCwQnA6q7JtxxMhj9HQFDc4bnLM8QWc1Y4TMvghWuh
 RtmfoYaCs1jRKdH5iLdl3K9vGl6ZUBCY0dNbfZmHqxu15Kl3bHNjB1b9PyyuXvuAmHlV
 qVveJzm6CZKy4y9m6xb3vwT9ReFOrBYGg18NT1kQf7yRnLqi6ie9YjqnvfxNY21eDM4P
 aipahxVzZrgIHGKbH4LpcHVnuBZiZhqGIkqWl6MQ8y0i1geCkvCBcwTN2L5aP1lYy7W7
 thlHJUmTQrkbrTt1Q/a97iIZAfTfDMDemLmVxr7bFriUyjCdyzkJs14G8BZ0g0XGRFxq
 fRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715633536; x=1716238336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLkROO1SQNO9dE6+P1muioxZq3ExeRvliE5viOMXuXQ=;
 b=Nuqzg0n1gffBhl4hd8hEUbWtYJ3WZPNMlSr0x2ZYTbrFaw+OirnTln9OGAk7m6BWx+
 LeoG8ALzqEflqeK05HTaW5Cykhrb3cPJ4eftRCQPDEuXZzsTq1Ede8z0i4DEZ+OKPoJK
 rM76lhv/3rSgbRSdkDJZgHSUeEWXK2aIIaEZ0vJqBLrHlvYHXrBwPUaSj9MBVPOfqbt/
 1qLNwiE0xRneCi4ZkDomj+8jn3+h9hzFniJ8Ai0b66gFf0FpS6UTBRnCx/Pyg04g9UoQ
 DiNafdQ4wImBnALfWTLIS22FzcCJJdKcg2qUfx6P2dJ4JxODoK38cLag2XW9tlMPfZiu
 pcGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+oiDkC8HHeurDpQ0L5bxa0aDtWu5uqXosy2EV6ArD8EprUVmZULhLnfaRr4UCcJgP/GDJOujLrwPnjpppKfe9LtwPIQ==
X-Gm-Message-State: AOJu0YyzZSIfcd0COGlzF2rrUT1gMZLqql121qnizHMKHJk9rUhL4wck
 8Onc09m9X69kdqi9OlXln6oDqF8Fu5XdQ/252cHID2xj3I9JJilaBDAdwEKB837AxFxa5/d9tTO
 8FnZ9cc9MLgv7KXlXJj8DnJd+z8x1X7yNPncwig==
X-Google-Smtp-Source: AGHT+IGRdpohCOy14xyo4/B3ivQE5ESqlhpHTs3XhOJW0XE4x5TgxjN6+HS1+QmDEV2peBkQCiLjGIY5tzX99Wvi5js=
X-Received: by 2002:a17:906:1551:b0:a59:b6de:2919 with SMTP id
 a640c23a62f3a-a5a2d5f18e4mr779445366b.43.1715633535697; Mon, 13 May 2024
 13:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
 <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
 <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
In-Reply-To: <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 13 May 2024 13:52:03 -0700
Message-ID: <CAJ+vNU3bOrBHf4nQeb=1_EfrcsjcjYncQN3Od2=O93yuVQc2FA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 29, 2024 at 1:51=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/29/24 6:48 PM, Tim Harvey wrote:
> > On Sat, Apr 27, 2024 at 4:20=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 4/27/24 2:11 AM, Tim Harvey wrote:
> >>
> >> [...]
> >>
> >>> diff --git a/include/mmc.h b/include/mmc.h
> >>> index 4b8327f1f93b..7243bd761202 100644
> >>> --- a/include/mmc.h
> >>> +++ b/include/mmc.h
> >>> @@ -381,6 +381,21 @@ enum mmc_voltage {
> >>>    #define MMC_TIMING_MMC_HS200        9
> >>>    #define MMC_TIMING_MMC_HS400        10
> >>>
> >>> +/* emmc hardware partition values */
> >>> +enum emmc_hwpart {
> >>> +     EMMC_HWPART_DEFAULT =3D 0,
> >>
> >> One more thing ... eMMC hardware partition 0 and 7 are both referring =
to
> >> USER HW partition. Have a look at the git log, there have been patches
> >> which handled this case in the MMC subsystem from about a year ago.
> >
> > Hi Marek,
> >
> > I can't find what you are referring to. I assume you are talking about
> > calling the first name something other than 'user' as technically it's
> > not (but it gets treated as user).
> >
> > Can you find the commit or discussion you are thinking about?
>
> It seems this whole thing is much older:
>
> 7dbe63bc950b ("SPL: Add CONFIG_SUPPORT_EMMC_BOOT support to
> CONFIG_SPL_FRAMEWORK")
>
> +                * We need to check what the partition is configured to.
> +                * 1 and 2 match up to boot0 / boot1 and 7 is user data
> +                * which is the first physical partition (0).
> +                */
> +               int part =3D (mmc->part_config >> 3) & PART_ACCESS_MASK;
> +
> +               if (part =3D=3D 7)
> +                       part =3D 0;

Hi Marek,

Sorry, I haven't been able to work on U-Boot for the past week or so
and am just getting back to this.

I'm glad you pointed this out as it made me aware that there is a bit
of a mixing of eMMC PARTITION_CONFIG (Ext CSD 179) fields
BOOT_PARTITION_ENABLE and PARTITION_ACCESS in U-Boot currently.

I'm going to add an enumerated type for each and update the various
places where a 'conversion' as above is done but I'm still a bit torn
on naming conventions.

Consider the following:
- the eMMC spec refers to boot partitions and gp partitions as 1 based
- the Linux kernel device names for these are 0 based
- U-Boot does not currently refer to the boot devices by names but
does currently refer to the gp's by names using 1-based names (the
'mmc hwpartition' command)

Personally I would like to name the boot partitions 'boot0' and
'boot1' to match Linux but I think I should name the gp's
'gp1'...'gp4' to be backward compatible with the 'mmc hwpartition'
command.

What do you think?

Best Regards,

Tim
