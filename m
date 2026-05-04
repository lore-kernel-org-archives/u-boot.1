Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DEAFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961FB845E9;
	Mon,  4 May 2026 15:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ONsT4Gr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C025980F0E; Mon,  4 May 2026 15:02:40 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05418468B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bc1f0830f44so167453066b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899758; cv=none;
 d=google.com; s=arc-20240605;
 b=Scu5v7V+hL5FlY/fY3Fy3psffgcsHN8/q2EZB8kfjS6rNn5zS1ieWjbJWEshsFUkYu
 O0FTrkOvr01ejDp6aSZvwBqqRDAIJoNHi7rxLX4yL5bUGDv6PblYmuqpk7DnT8/FIMHo
 BYvxdyn9vk3ZvxeJCQJ+ZVqooY3jzVzz/b+6IkCoyM9M9L+T/JcNhtjNkE4XIniRpxhr
 85+rN/T84onUmJRSKdk8g5RQpDhAQKtdscDPjSXOCz44S4/LJUG85GL4pOVrNg/vRB+E
 tfZx1GFEScX1+lKuByKJ7eUwqusK3B4+W2bnTOyLZ4dZc1vZFrlSMMyvbg/4RRCmobVH
 LvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rMz+t1G6t191fyFHxGhhQ1Cb2uLq1PAIodjwG8TMzv0=;
 fh=MiPMVlZqbKlw1fatphHz+fPQCRVQHGg4dnQ7ziOy4C8=;
 b=DfZA0HDA1/BU5s5M9mNPlfz5JRjKrHPu3fiUkE6/QbXeJXtMTGaAx/QkfmEbaK1sAl
 gBH9yEiMgUaXTdPSYDP/7YdjqQ/lobSGqMcC1D3uP2PME9IYArsdbwP9o004ojFoI7dK
 tNOtyqZq4FhrCTv3R68UMS8fImjk+W+mlYWaz/Pu3egw/SNKCJrP/CqHW0q/t3vdM+KK
 7rJqg/Jq2UrWc6HqkqajtjqEQ3cwh2y0GsZAvFZUxh2rdKwsUhvuqCghJCLkV/oCAZiU
 XKKLcO0c1SIwhquaXCTVECEaPC+H/9rfolT0fUBDG6E6aEXTIIUAhfvaEniKzzK6MDV4
 C7pQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777899758; x=1778504558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMz+t1G6t191fyFHxGhhQ1Cb2uLq1PAIodjwG8TMzv0=;
 b=ONsT4Gr2XkpiU/JHS3Ilf0BS1Y2PlYejh8fVIhXGD1wkg0mdKWacJgDsMBK0lBD8Tu
 QCWCflDUgI/Ov7AuPx+4dXsH9auyZUoQLKHIWeKhmlV9pkQrC2CA2CMyqMMufLbe6WQ2
 yt1w3go2lp0C49bHuJMJatuEdjUPZku5+XIq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899758; x=1778504558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMz+t1G6t191fyFHxGhhQ1Cb2uLq1PAIodjwG8TMzv0=;
 b=hyEQ6V+5cdMfDyNIOtiqLuHJxmG+V5EWaYGEnoNJSBiSHCbRLSdUuhHZUY/hnW6j9S
 6nQ4vY6HijHFZyIGC2Ksebe6ddvF09slMECvMSfOrp7ZsouRyvOHUigoM49B2j2Wr/FU
 rMvJh7jAqI1GvArASrXC/x19cicdRn8VSSf2cvpcli+/rJAhJPMI+ejEy1m+V/NIPILC
 VJGWi/nU2ITRO+2lhAkdgOPr20GSYR/HCR21ELatxpc7+jiz00spX1olmt4OksuxiF91
 69Hl4DXNO/fwPzxmsuUPBgxKPqNRfHXoV4YUXbx7p3PF5Coch+YT4W2mviqJsjWc9uvh
 XXYQ==
X-Gm-Message-State: AOJu0YxFDVciswQeGqcXjy3pZf0c0vf8DLt1Fy2Wv0Ms3U1pc3uzYmBI
 UebcfGQP+1fGuNSi7Wn5uNFYI1y6O0tW+wA0rhDfUfeNqvrvEI/h43o8FN5TE8VYT9Fv1IvZsuP
 gMVft6O1fqpEcJm4NROAnI3mtXbGqdI+g3V+XU/UIBxMht4QUNxI=
X-Gm-Gg: AeBDievBo+gqZedyW7trDzbi5j/C817zzshrjS/hsASpX8nwVIUJAjmdK0aU0rczfw4
 deJAykIbVmSmobasS6ZUXmPIqSdFCo4hCcamuE3x0f3Jwz4UoC44U4ln8POmh/xKIop3Fh0H+pS
 2baDEpMRXZGdhEGT3iEfmeY7UGN2sfVfFSPfD/QOXE129zLeJF7LBdDCSb8qx3IfUqqnXklnSCF
 Affuh6fJeVV8L7XpnVeKzWXQuEK/8Tekfn97t6Pigrpkn1luok3AvMsw0/DWew2GDWtcUKrRDu0
 hA==
X-Received: by 2002:a17:907:a01:b0:b9d:14e9:d06d with SMTP id
 a640c23a62f3a-bbfdef8a89bmr431468766b.8.1777899758000; Mon, 04 May 2026
 06:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
 <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
 <6980d77d-b0d6-4b77-9ade-4201bb88cb87@cherry.de>
In-Reply-To: <6980d77d-b0d6-4b77-9ade-4201bb88cb87@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 07:02:25 -0600
X-Gm-Features: AVHnY4J3FrumZcyAy12V854e-hH1JOrRE-8Ub9lbKfd-fqs8kpqKBMt3jXBVbbE
Message-ID: <CAFLszTis91k0xp6DaiV6aW2OgLYyRhHLEwpTk1jeWv0sD8gXpQ@mail.gmail.com>
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 4 May 2026 at 06:59, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/4/26 2:49 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 27 Apr 2026 at 03:14, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon, Marek,
> >>
> >> On 4/22/26 4:31 AM, Simon Glass wrote:
> >>> When producing a DTB from fdtgrep, there is no way to reserve extra
> >>> space so that more nodes/properties can be added at runtime without
> >>> growing totalsize first.
> >>>
> >>
> >> Ok but why is that an issue? What is the actual usecase? What I'm afraid
> >> of is that you pad enough and you hit random bugs because you forget
> >> that adding enough properties can now hit the size limit and you forgot
> >> to add the logic to resize/grow the fdt when it's too small to fit new
> >> properties.
> >
> > I'm going to leave this question to Marek :-)
> >
> >>
> >>> Add a -B/--pad option that appends a caller-specified number of free
> >>> bytes after the strings section and grows totalsize accordingly. The
> >>> padding is applied after fdt_pack(), so it is not reclaimed when -r is
> >>> used.
> >>>
> >>> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>    tools/binman/btool/fdtgrep.py |  3 ++-
> >>>    tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
> >>>    2 files changed, 32 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> >>> index 446b2f4144b..7b393241878 100644
> >>> --- a/tools/binman/btool/fdtgrep.py
> >>> +++ b/tools/binman/btool/fdtgrep.py
> >>> @@ -16,9 +16,10 @@ Output formats are:
> >>>        dtb - device tree blob (sets -Hmt automatically)
> >>>        bin - device tree fragment (may not be a valid .dtb)
> >>>
> >>> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >>> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >>>      -a, --show-address                 Display address
> >>>      -A, --colour                       Show all nodes/tags, colour those that match
> >>> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
> >>>      -b, --include-node-with-prop <arg> Include contains containing property
> >>>      -c, --include-compat <arg>         Compatible nodes to include in grep
> >>>      -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
> >>
> >> I'm tempted to remove this and just tell people to look at the
> >> documentation in tools/fdtgrep.c. Especially since we don't actually
> >> allow the user to pass any of those parameters themselves via the
> >> bintool, so it isn't actually useful.
> >
> > I would like fdtgrep to give useful help, though. It is a tool which
> > can stand alone.
> >
>
> Yes, but this here is docstring for the fdtgrep *Bintool* module which
> actually doesn't support most of the arguments specified here. So I
> would say it's more confusing to have it there than not have anything.
> For sure we want to keep documentation of fdtgrep, the tool as in
> tools/fdtgrep.c, complete and up-to-date!

Ah yes, I just generated it directly from fdtgrep. So perhaps we
should have no argument docs here and just mention what the bintool
actually supports / uses?

Regards,
Simon
